Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 035A41BBCA8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Apr 2020 13:42:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726579AbgD1Lmi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Apr 2020 07:42:38 -0400
Received: from mx2.suse.de ([195.135.220.15]:39642 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726264AbgD1Lmh (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Apr 2020 07:42:37 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 1CB70AC6E;
        Tue, 28 Apr 2020 11:42:34 +0000 (UTC)
Subject: Re: [PATCH v9 08/11] scsi: sd_zbc: emulate ZONE_APPEND commands
To:     Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Jens Axboe <axboe@kernel.dk>
Cc:     Christoph Hellwig <hch@infradead.org>,
        linux-block <linux-block@vger.kernel.org>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Keith Busch <kbusch@kernel.org>,
        "linux-scsi @ vger . kernel . org" <linux-scsi@vger.kernel.org>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        "linux-fsdevel @ vger . kernel . org" <linux-fsdevel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>
References: <20200428104605.8143-1-johannes.thumshirn@wdc.com>
 <20200428104605.8143-9-johannes.thumshirn@wdc.com>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <92524364-fdd2-c386-9ac4-e4cbb73751f0@suse.de>
Date:   Tue, 28 Apr 2020 13:42:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200428104605.8143-9-johannes.thumshirn@wdc.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 4/28/20 12:46 PM, Johannes Thumshirn wrote:
> Emulate ZONE_APPEND for SCSI disks using a regular WRITE(16) command
> with a start LBA set to the target zone write pointer position.
> 
> In order to always know the write pointer position of a sequential write
> zone, the write pointer of all zones is tracked using an array of 32bits
> zone write pointer offset attached to the scsi disk structure. Each
> entry of the array indicate a zone write pointer position relative to
> the zone start sector. The write pointer offsets are maintained in sync
> with the device as follows:
> 1) the write pointer offset of a zone is reset to 0 when a
>     REQ_OP_ZONE_RESET command completes.
> 2) the write pointer offset of a zone is set to the zone size when a
>     REQ_OP_ZONE_FINISH command completes.
> 3) the write pointer offset of a zone is incremented by the number of
>     512B sectors written when a write, write same or a zone append
>     command completes.
> 4) the write pointer offset of all zones is reset to 0 when a
>     REQ_OP_ZONE_RESET_ALL command completes.
> 
> Since the block layer does not write lock zones for zone append
> commands, to ensure a sequential ordering of the regular write commands
> used for the emulation, the target zone of a zone append command is
> locked when the function sd_zbc_prepare_zone_append() is called from
> sd_setup_read_write_cmnd(). If the zone write lock cannot be obtained
> (e.g. a zone append is in-flight or a regular write has already locked
> the zone), the zone append command dispatching is delayed by returning
> BLK_STS_ZONE_RESOURCE.
> 
> To avoid the need for write locking all zones for REQ_OP_ZONE_RESET_ALL
> requests, use a spinlock to protect accesses and modifications of the
> zone write pointer offsets. This spinlock is initialized from sd_probe()
> using the new function sd_zbc_init().
> 
> Co-developed-by: Damien Le Moal <Damien.LeMoal@wdc.com>
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> ---
>   drivers/scsi/sd.c     |  24 ++-
>   drivers/scsi/sd.h     |  43 ++++-
>   drivers/scsi/sd_zbc.c | 362 +++++++++++++++++++++++++++++++++++++++---
>   3 files changed, 395 insertions(+), 34 deletions(-)
> 
> diff --git a/drivers/scsi/sd.c b/drivers/scsi/sd.c
> index a793cb08d025..66ff5f04c0ce 100644
> --- a/drivers/scsi/sd.c
> +++ b/drivers/scsi/sd.c
> @@ -1206,6 +1206,12 @@ static blk_status_t sd_setup_read_write_cmnd(struct scsi_cmnd *cmd)
>   		}
>   	}
>   
> +	if (req_op(rq) == REQ_OP_ZONE_APPEND) {
> +		ret = sd_zbc_prepare_zone_append(cmd, &lba, nr_blocks);
> +		if (ret)
> +			return ret;
> +	}
> +
>   	fua = rq->cmd_flags & REQ_FUA ? 0x8 : 0;
>   	dix = scsi_prot_sg_count(cmd);
>   	dif = scsi_host_dif_capable(cmd->device->host, sdkp->protection_type);
> @@ -1287,6 +1293,7 @@ static blk_status_t sd_init_command(struct scsi_cmnd *cmd)
>   		return sd_setup_flush_cmnd(cmd);
>   	case REQ_OP_READ:
>   	case REQ_OP_WRITE:
> +	case REQ_OP_ZONE_APPEND:
>   		return sd_setup_read_write_cmnd(cmd);
>   	case REQ_OP_ZONE_RESET:
>   		return sd_zbc_setup_zone_mgmt_cmnd(cmd, ZO_RESET_WRITE_POINTER,
> @@ -2055,7 +2062,7 @@ static int sd_done(struct scsi_cmnd *SCpnt)
>   
>    out:
>   	if (sd_is_zoned(sdkp))
> -		sd_zbc_complete(SCpnt, good_bytes, &sshdr);
> +		good_bytes = sd_zbc_complete(SCpnt, good_bytes, &sshdr);
>   
>   	SCSI_LOG_HLCOMPLETE(1, scmd_printk(KERN_INFO, SCpnt,
>   					   "sd_done: completed %d of %d bytes\n",
> @@ -3372,6 +3379,10 @@ static int sd_probe(struct device *dev)
>   	sdkp->first_scan = 1;
>   	sdkp->max_medium_access_timeouts = SD_MAX_MEDIUM_TIMEOUTS;
>   
> +	error = sd_zbc_init_disk(sdkp);
> +	if (error)
> +		goto out_free_index;
> +
>   	sd_revalidate_disk(gd);
>   
>   	gd->flags = GENHD_FL_EXT_DEVT;
> @@ -3409,6 +3420,7 @@ static int sd_probe(struct device *dev)
>    out_put:
>   	put_disk(gd);
>    out_free:
> +	sd_zbc_release_disk(sdkp);
>   	kfree(sdkp);
>    out:
>   	scsi_autopm_put_device(sdp);
> @@ -3485,6 +3497,8 @@ static void scsi_disk_release(struct device *dev)
>   	put_disk(disk);
>   	put_device(&sdkp->device->sdev_gendev);
>   
> +	sd_zbc_release_disk(sdkp);
> +
>   	kfree(sdkp);
>   }
>   
> @@ -3665,19 +3679,19 @@ static int __init init_sd(void)
>   	if (!sd_page_pool) {
>   		printk(KERN_ERR "sd: can't init discard page pool\n");
>   		err = -ENOMEM;
> -		goto err_out_ppool;
> +		goto err_out_cdb_pool;
>   	}
>   
>   	err = scsi_register_driver(&sd_template.gendrv);
>   	if (err)
> -		goto err_out_driver;
> +		goto err_out_ppool;
>   
>   	return 0;
>   
> -err_out_driver:
> +err_out_ppool:
>   	mempool_destroy(sd_page_pool);
>   
> -err_out_ppool:
> +err_out_cdb_pool:
>   	mempool_destroy(sd_cdb_pool);
>   
>   err_out_cache:
> diff --git a/drivers/scsi/sd.h b/drivers/scsi/sd.h
> index 50fff0bf8c8e..6009311105ef 100644
> --- a/drivers/scsi/sd.h
> +++ b/drivers/scsi/sd.h
> @@ -79,6 +79,12 @@ struct scsi_disk {
>   	u32		zones_optimal_open;
>   	u32		zones_optimal_nonseq;
>   	u32		zones_max_open;
> +	u32		*zones_wp_ofst;
> +	spinlock_t	zones_wp_ofst_lock;
> +	u32		*rev_wp_ofst;
> +	struct mutex	rev_mutex;
> +	struct work_struct zone_wp_ofst_work;
> +	char		*zone_wp_update_buf;
>   #endif
>   	atomic_t	openers;
>   	sector_t	capacity;	/* size in logical blocks */

'zones_wp_ofst' ?

Please replace the cryptic 'ofst' with 'offset'; those three additional 
characters don't really make a difference ...

> @@ -207,17 +213,35 @@ static inline int sd_is_zoned(struct scsi_disk *sdkp)
>   
>   #ifdef CONFIG_BLK_DEV_ZONED
>   
> +int sd_zbc_init_disk(struct scsi_disk *sdkp);
> +void sd_zbc_release_disk(struct scsi_disk *sdkp);
>   extern int sd_zbc_read_zones(struct scsi_disk *sdkp, unsigned char *buffer);
>   extern void sd_zbc_print_zones(struct scsi_disk *sdkp);
>   blk_status_t sd_zbc_setup_zone_mgmt_cmnd(struct scsi_cmnd *cmd,
>   					 unsigned char op, bool all);
> -extern void sd_zbc_complete(struct scsi_cmnd *cmd, unsigned int good_bytes,
> -			    struct scsi_sense_hdr *sshdr);
> +unsigned int sd_zbc_complete(struct scsi_cmnd *cmd, unsigned int good_bytes,
> +			     struct scsi_sense_hdr *sshdr);
>   int sd_zbc_report_zones(struct gendisk *disk, sector_t sector,
>   		unsigned int nr_zones, report_zones_cb cb, void *data);
>   
> +blk_status_t sd_zbc_prepare_zone_append(struct scsi_cmnd *cmd, sector_t *lba,
> +				        unsigned int nr_blocks);
> +
>   #else /* CONFIG_BLK_DEV_ZONED */
>   
> +static inline int sd_zbc_init(void)
> +{
> +	return 0;
> +}
> +
> +static inline int sd_zbc_init_disk(struct scsi_disk *sdkp)
> +{
> +	return 0;
> +}
> +
> +static inline void sd_zbc_exit(void) {}
> +static inline void sd_zbc_release_disk(struct scsi_disk *sdkp) {}
> +
>   static inline int sd_zbc_read_zones(struct scsi_disk *sdkp,
>   				    unsigned char *buf)
>   {
> @@ -233,9 +257,18 @@ static inline blk_status_t sd_zbc_setup_zone_mgmt_cmnd(struct scsi_cmnd *cmd,
>   	return BLK_STS_TARGET;
>   }
>   
> -static inline void sd_zbc_complete(struct scsi_cmnd *cmd,
> -				   unsigned int good_bytes,
> -				   struct scsi_sense_hdr *sshdr) {}
> +static inline unsigned int sd_zbc_complete(struct scsi_cmnd *cmd,
> +			unsigned int good_bytes, struct scsi_sense_hdr *sshdr)
> +{
> +	return 0;
> +}
> +
> +static inline blk_status_t sd_zbc_prepare_zone_append(struct scsi_cmnd *cmd,
> +						      sector_t *lba,
> +						      unsigned int nr_blocks)
> +{
> +	return BLK_STS_TARGET;
> +}
>   
>   #define sd_zbc_report_zones NULL
>   
> diff --git a/drivers/scsi/sd_zbc.c b/drivers/scsi/sd_zbc.c
> index ee156fbf3780..d35047ca87f6 100644
> --- a/drivers/scsi/sd_zbc.c
> +++ b/drivers/scsi/sd_zbc.c
> @@ -11,6 +11,7 @@
>   #include <linux/blkdev.h>
>   #include <linux/vmalloc.h>
>   #include <linux/sched/mm.h>
> +#include <linux/mutex.h>
>   
>   #include <asm/unaligned.h>
>   
> @@ -19,11 +20,36 @@
>   
>   #include "sd.h"
>   
> +static unsigned int sd_zbc_get_zone_wp_ofst(struct blk_zone *zone)
> +{
> +	if (zone->type == ZBC_ZONE_TYPE_CONV)
> +		return 0;
> +
> +	switch (zone->cond) {
> +	case BLK_ZONE_COND_IMP_OPEN:
> +	case BLK_ZONE_COND_EXP_OPEN:
> +	case BLK_ZONE_COND_CLOSED:
> +		return zone->wp - zone->start;
> +	case BLK_ZONE_COND_FULL:
> +		return zone->len;
> +	case BLK_ZONE_COND_EMPTY:
> +	case BLK_ZONE_COND_OFFLINE:
> +	case BLK_ZONE_COND_READONLY:
> +	default:
> +		/*
> +		 * Offline and read-only zones do not have a valid
> +		 * write pointer. Use 0 as for an empty zone.
> +		 */
> +		return 0;
> +	}
> +}
> +
>   static int sd_zbc_parse_report(struct scsi_disk *sdkp, u8 *buf,
>   			       unsigned int idx, report_zones_cb cb, void *data)
>   {
>   	struct scsi_device *sdp = sdkp->device;
>   	struct blk_zone zone = { 0 };
> +	int ret;
>   
>   	zone.type = buf[0] & 0x0f;
>   	zone.cond = (buf[1] >> 4) & 0xf;
> @@ -39,7 +65,14 @@ static int sd_zbc_parse_report(struct scsi_disk *sdkp, u8 *buf,
>   	    zone.cond == ZBC_ZONE_COND_FULL)
>   		zone.wp = zone.start + zone.len;
>   
> -	return cb(&zone, idx, data);
> +	ret = cb(&zone, idx, data);
> +	if (ret)
> +		return ret;
> +
> +	if (sdkp->rev_wp_ofst)
> +		sdkp->rev_wp_ofst[idx] = sd_zbc_get_zone_wp_ofst(&zone);
> +
> +	return 0;
>   }
>   
>   /**
> @@ -229,6 +262,116 @@ static blk_status_t sd_zbc_cmnd_checks(struct scsi_cmnd *cmd)
>   	return BLK_STS_OK;
>   }
>   
> +#define SD_ZBC_INVALID_WP_OFST	(~0u)
> +#define SD_ZBC_UPDATING_WP_OFST	(SD_ZBC_INVALID_WP_OFST - 1)
> +
> +static int sd_zbc_update_wp_ofst_cb(struct blk_zone *zone, unsigned int idx,
> +				    void *data)
> +{
> +	struct scsi_disk *sdkp = data;
> +
> +	lockdep_assert_held(&sdkp->zones_wp_ofst_lock);
> +
> +	sdkp->zones_wp_ofst[idx] = sd_zbc_get_zone_wp_ofst(zone);
> +
> +	return 0;
> +}
> +
> +static void sd_zbc_update_wp_ofst_workfn(struct work_struct *work)
> +{
> +	struct scsi_disk *sdkp;
> +	unsigned int zno;
> +	int ret;
> +
> +	sdkp = container_of(work, struct scsi_disk, zone_wp_ofst_work);
> +
> +	spin_lock_bh(&sdkp->zones_wp_ofst_lock);
> +	for (zno = 0; zno < sdkp->nr_zones; zno++) {
> +		if (sdkp->zones_wp_ofst[zno] != SD_ZBC_UPDATING_WP_OFST)
> +			continue;
> +
> +		spin_unlock_bh(&sdkp->zones_wp_ofst_lock);
> +		ret = sd_zbc_do_report_zones(sdkp, sdkp->zone_wp_update_buf,
> +					     SD_BUF_SIZE,
> +					     zno * sdkp->zone_blocks, true);
> +		spin_lock_bh(&sdkp->zones_wp_ofst_lock);
> +		if (!ret)
> +			sd_zbc_parse_report(sdkp, sdkp->zone_wp_update_buf + 64,
> +					    zno, sd_zbc_update_wp_ofst_cb,
> +					    sdkp);
> +	}
> +	spin_unlock_bh(&sdkp->zones_wp_ofst_lock);
> +
> +	scsi_device_put(sdkp->device);
> +}
> +
> +/**
> + * sd_zbc_prepare_zone_append() - Prepare an emulated ZONE_APPEND command.
> + * @cmd: the command to setup
> + * @lba: the LBA to patch
> + * @nr_blocks: the number of LBAs to be written
> + *
> + * Called from sd_setup_read_write_cmnd() for REQ_OP_ZONE_APPEND.
> + * @sd_zbc_prepare_zone_append() handles the necessary zone wrote locking and
> + * patching of the lba for an emulated ZONE_APPEND command.
> + *
> + * In case the cached write pointer offset is %SD_ZBC_INVALID_WP_OFST it will
> + * schedule a REPORT ZONES command and return BLK_STS_IOERR.
> + */
> +blk_status_t sd_zbc_prepare_zone_append(struct scsi_cmnd *cmd, sector_t *lba,
> +					unsigned int nr_blocks)
> +{
> +	struct request *rq = cmd->request;
> +	struct scsi_disk *sdkp = scsi_disk(rq->rq_disk);
> +	unsigned int wp_ofst, zno = blk_rq_zone_no(rq);
> +	blk_status_t ret;
> +
> +	ret = sd_zbc_cmnd_checks(cmd);
> +	if (ret != BLK_STS_OK)
> +		return ret;
> +
> +	if (!blk_rq_zone_is_seq(rq))
> +		return BLK_STS_IOERR;
> +
> +	/* Unlock of the write lock will happen in sd_zbc_complete() */
> +	if (!blk_req_zone_write_trylock(rq))
> +		return BLK_STS_ZONE_RESOURCE;
> +
> +	spin_lock_bh(&sdkp->zones_wp_ofst_lock);
> +	wp_ofst = sdkp->zones_wp_ofst[zno];
> +	switch (wp_ofst) {
> +	case SD_ZBC_INVALID_WP_OFST:
> +		/*
> +		 * We are about to schedule work to update a zone write pointer
> +		 * offset, which will cause the zone append command to be
> +		 * requeued. So make sure that the scsi device does not go away
> +		 * while the work is being processed.
> +		 */
> +		if (scsi_device_get(sdkp->device)) {
> +			ret = BLK_STS_IOERR;
> +			break;
> +		}
> +		sdkp->zones_wp_ofst[zno] = SD_ZBC_UPDATING_WP_OFST;
> +		schedule_work(&sdkp->zone_wp_ofst_work);
> +		/*FALLTHRU*/
> +	case SD_ZBC_UPDATING_WP_OFST:
> +		ret = BLK_STS_DEV_RESOURCE;
> +		break;
> +	default:
> +		wp_ofst = sectors_to_logical(sdkp->device, wp_ofst);
> +		if (wp_ofst + nr_blocks > sdkp->zone_blocks) {
> +			ret = BLK_STS_IOERR;
> +			break;
> +		}
> +
> +		*lba += wp_ofst;
> +	}
> +	spin_unlock_bh(&sdkp->zones_wp_ofst_lock);
> +	if (ret)
> +		blk_req_zone_write_unlock(rq);
> +	return ret;
> +}
> +
>   /**
>    * sd_zbc_setup_zone_mgmt_cmnd - Prepare a zone ZBC_OUT command. The operations
>    *			can be RESET WRITE POINTER, OPEN, CLOSE or FINISH.
> @@ -269,16 +412,104 @@ blk_status_t sd_zbc_setup_zone_mgmt_cmnd(struct scsi_cmnd *cmd,
>   	return BLK_STS_OK;
>   }
>   
> +static bool sd_zbc_need_zone_wp_update(struct request *rq)
> +{
> +	switch (req_op(rq)) {
> +	case REQ_OP_ZONE_APPEND:
> +	case REQ_OP_ZONE_FINISH:
> +	case REQ_OP_ZONE_RESET:
> +	case REQ_OP_ZONE_RESET_ALL:
> +		return true;
> +	case REQ_OP_WRITE:
> +	case REQ_OP_WRITE_ZEROES:
> +	case REQ_OP_WRITE_SAME:
> +		return blk_rq_zone_is_seq(rq);
> +	default:
> +		return false;
> +	}
> +}
> +
> +/**
> + * sd_zbc_zone_wp_update - Update cached zone write pointer upon cmd completion
> + * @cmd: Completed command
> + * @good_bytes: Command reply bytes
> + *
> + * Called from sd_zbc_complete() to handle the update of the cached zone write
> + * pointer value in case an update is needed.
> + */
> +static unsigned int sd_zbc_zone_wp_update(struct scsi_cmnd *cmd,
> +					  unsigned int good_bytes)
> +{
> +	int result = cmd->result;
> +	struct request *rq = cmd->request;
> +	struct scsi_disk *sdkp = scsi_disk(rq->rq_disk);
> +	unsigned int zno = blk_rq_zone_no(rq);
> +	enum req_opf op = req_op(rq);
> +
> +	/*
> +	 * If we got an error for a command that needs updating the write
> +	 * pointer offset cache, we must mark the zone wp offset entry as
> +	 * invalid to force an update from disk the next time a zone append
> +	 * command is issued.
> +	 */
> +	spin_lock_bh(&sdkp->zones_wp_ofst_lock);
> +
> +	if (result && op != REQ_OP_ZONE_RESET_ALL) {
> +		if (op == REQ_OP_ZONE_APPEND) {
> +			/* Force complete completion (no retry) */
> +			good_bytes = 0;
> +			scsi_set_resid(cmd, blk_rq_bytes(rq));
> +		}
> +
> +		/*
> +		 * Force an update of the zone write pointer offset on
> +		 * the next zone append access.
> +		 */
> +		if (sdkp->zones_wp_ofst[zno] != SD_ZBC_UPDATING_WP_OFST)
> +			sdkp->zones_wp_ofst[zno] = SD_ZBC_INVALID_WP_OFST;
> +		goto unlock_wp_ofst;
> +	}
> +
> +	switch (op) {
> +	case REQ_OP_ZONE_APPEND:
> +		rq->__sector += sdkp->zones_wp_ofst[zno];
> +		/* fallthrough */
> +	case REQ_OP_WRITE_ZEROES:
> +	case REQ_OP_WRITE_SAME:
> +	case REQ_OP_WRITE:
> +		if (sdkp->zones_wp_ofst[zno] < sd_zbc_zone_sectors(sdkp))
> +			sdkp->zones_wp_ofst[zno] += good_bytes >> SECTOR_SHIFT;
> +		break;
> +	case REQ_OP_ZONE_RESET:
> +		sdkp->zones_wp_ofst[zno] = 0;
> +		break;
> +	case REQ_OP_ZONE_FINISH:
> +		sdkp->zones_wp_ofst[zno] = sd_zbc_zone_sectors(sdkp);
> +		break;
> +	case REQ_OP_ZONE_RESET_ALL:
> +		memset(sdkp->zones_wp_ofst, 0,
> +		       sdkp->nr_zones * sizeof(unsigned int));
> +		break;
> +	default:
> +		break;
> +	}
> +
> +unlock_wp_ofst:
> +	spin_unlock_bh(&sdkp->zones_wp_ofst_lock);
> +
> +	return good_bytes;
> +}
> +
>   /**
>    * sd_zbc_complete - ZBC command post processing.
>    * @cmd: Completed command
>    * @good_bytes: Command reply bytes
>    * @sshdr: command sense header
>    *
> - * Called from sd_done(). Process report zones reply and handle reset zone
> - * and write commands errors.
> + * Called from sd_done() to handle zone commands errors and updates to the
> + * device queue zone write pointer offset cahce.
>    */
> -void sd_zbc_complete(struct scsi_cmnd *cmd, unsigned int good_bytes,
> +unsigned int sd_zbc_complete(struct scsi_cmnd *cmd, unsigned int good_bytes,
>   		     struct scsi_sense_hdr *sshdr)
>   {
>   	int result = cmd->result;
> @@ -294,7 +525,13 @@ void sd_zbc_complete(struct scsi_cmnd *cmd, unsigned int good_bytes,
>   		 * so be quiet about the error.
>   		 */
>   		rq->rq_flags |= RQF_QUIET;
> -	}
> +	} else if (sd_zbc_need_zone_wp_update(rq))
> +		good_bytes = sd_zbc_zone_wp_update(cmd, good_bytes);
> +
> +	if (req_op(rq) == REQ_OP_ZONE_APPEND)
> +		blk_req_zone_write_unlock(rq);
> +
> +	return good_bytes;
>   }
>   
>   /**
> @@ -396,11 +633,67 @@ static int sd_zbc_check_capacity(struct scsi_disk *sdkp, unsigned char *buf,
>   	return 0;
>   }
>   
> +static void sd_zbc_revalidate_zones_cb(struct gendisk *disk)
> +{
> +	struct scsi_disk *sdkp = scsi_disk(disk);
> +
> +	swap(sdkp->zones_wp_ofst, sdkp->rev_wp_ofst);
> +}
> +
> +static int sd_zbc_revalidate_zones(struct scsi_disk *sdkp,
> +				   u32 zone_blocks,
> +				   unsigned int nr_zones)
> +{
> +	struct gendisk *disk = sdkp->disk;
> +	int ret = 0;
> +
> +	/*
> +	 * Make sure revalidate zones are serialized to ensure exclusive
> +	 * updates of the scsi disk data.
> +	 */
> +	mutex_lock(&sdkp->rev_mutex);
> +
> +	/*
> +	 * Revalidate the disk zones to update the device request queue zone
> +	 * bitmaps and the zone write pointer offset array. Do this only once
> +	 * the device capacity is set on the second revalidate execution for
> +	 * disk scan or if something changed when executing a normal revalidate.
> +	 */
> +	if (sdkp->first_scan) {
> +		sdkp->zone_blocks = zone_blocks;
> +		sdkp->nr_zones = nr_zones;
> +		goto unlock;
> +	}
> +
> +	if (sdkp->zone_blocks == zone_blocks &&
> +	    sdkp->nr_zones == nr_zones &&
> +	    disk->queue->nr_zones == nr_zones)
> +		goto unlock;
> +
> +	sdkp->rev_wp_ofst = kvcalloc(nr_zones, sizeof(u32), GFP_NOIO);
> +	if (!sdkp->rev_wp_ofst) {
> +		ret = -ENOMEM;
> +		goto unlock;
> +	}
> +
> +	ret = blk_revalidate_disk_zones(disk, sd_zbc_revalidate_zones_cb);
> +
> +	kvfree(sdkp->rev_wp_ofst);
> +	sdkp->rev_wp_ofst = NULL;
> +
> +unlock:
> +	mutex_unlock(&sdkp->rev_mutex);

I don't really understand this.
Passing a callback is fine if things happen asynchronously, and you 
wouldn't know from the calling context when that happened. Ok.
But the above code definitely assumes that blk_revalidate_disk_zones()
will be completed upon return, otherwise we'll get a nice crash in the
callback function as the 'rev' pointer is invalid.
But _if_ blk_revalidata_disk_zones() has completed upon return we might 
as well kill the callback, have the ->rev_wp_ofst a local variable ans 
simply the whole thing.

Hmm?

Cheers,

Hannes
-- 
Dr. Hannes Reinecke            Teamlead Storage & Networking
hare@suse.de                               +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer

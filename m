Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8F7011A1269
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Apr 2020 19:05:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726477AbgDGRFC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 Apr 2020 13:05:02 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:44664 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726352AbgDGRFB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 Apr 2020 13:05:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=tgNhHQ1LnnIXxPemT9F+0btbd2e857a9SqYq0A6DWAE=; b=qfvGkBVd+rsh7At/3yckv0NtrL
        VPzXuXhzu8iOJ2d7miuqimjaGG7Jk7drsBAdqumX7BG9BXiUrJBP/6DtSI9ypyEFJFzkz7ibncDvu
        aWBNiQjSPneOj4kXGHd7Kg7eTd4Kaf2quQHGIvAPwcWsads4/7O7IRyGLTwcEC0Qa+xDe6N007N4z
        kT7+B2iEbrzVBJ2EbOrac+h5kKnmDNCSsdn+91Wk6Den8CjanDXDATCOckd11Hw6Zk8jS13uVIVey
        C6T5IWG+/Ry5Pr3jFM10s438fTQWj1Nvdp2JwZFl95vCi+pe/kSL3gPIq+4fkucjQPIFk1F1XVMmV
        JLiXw7Wg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jLren-0007Jh-44; Tue, 07 Apr 2020 17:05:01 +0000
Date:   Tue, 7 Apr 2020 10:05:01 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        linux-block <linux-block@vger.kernel.org>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Keith Busch <kbusch@kernel.org>,
        "linux-scsi @ vger . kernel . org" <linux-scsi@vger.kernel.org>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        "linux-fsdevel @ vger . kernel . org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH v4 07/10] scsi: sd_zbc: emulate ZONE_APPEND commands
Message-ID: <20200407170501.GF13893@infradead.org>
References: <20200403101250.33245-1-johannes.thumshirn@wdc.com>
 <20200403101250.33245-8-johannes.thumshirn@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200403101250.33245-8-johannes.thumshirn@wdc.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Apr 03, 2020 at 07:12:47PM +0900, Johannes Thumshirn wrote:
> Emulate ZONE_APPEND for SCSI disks using a regular WRITE(16) with a
> start LBA set to the target zone write pointer position.
> 
> In order to always know the write pointer position of a sequential write
> zone, the queue flag QUEUE_FLAG_ZONE_WP_OFST is set to get an
> initialized write pointer offset array attached to the device request
> queue. The values of the cache are maintained in sync with the device
> as follows:
> 1) the write pointer offset of a zone is reset to 0 when a
>    REQ_OP_ZONE_RESET command completes.
> 2) the write pointer offset of a zone is set to the zone size when a
>    REQ_OP_ZONE_FINISH command completes.
> 3) the write pointer offset of a zone is incremented by the number of
>    512B sectors written when a write or a zone append command completes
> 4) the write pointer offset of all zones is reset to 0 when a
>    REQ_OP_ZONE_RESET_ALL command completes.
> 
> Since the block layer does not write lock zones for zone append
> commands, to ensure a sequential ordering of the write commands used for
> the emulation, the target zone of a zone append command is locked when
> the function sd_zbc_prepare_zone_append() is called from
> sd_setup_read_write_cmnd(). If the zone write lock cannot be obtained
> (e.g. a zone append is in-flight or a regular write has already locked
> the zone), the zone append command dispatching is delayed by returning
> BLK_STS_ZONE_RESOURCE.
> 
> Since zone reset and finish operations can be issued concurrently with
> writes and zone append requests, ensure a coherent update of the zone
> write pointer offsets by also write locking the target zones for these
> zone management requests.
> 
> Finally, to avoid the need for write locking all zones for
> REQ_OP_ZONE_RESET_ALL requests, use a spinlock to protect accesses and
> modifications of the zone write pointer offsets. This spinlock is
> initialized from sd_probe() using the new function sd_zbc_init().
> 
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> ---
>  drivers/scsi/sd.c     |  26 ++-
>  drivers/scsi/sd.h     |  38 ++++-
>  drivers/scsi/sd_zbc.c | 367 +++++++++++++++++++++++++++++++++++++++++-
>  3 files changed, 413 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/scsi/sd.c b/drivers/scsi/sd.c
> index 2710a0e5ae6d..569b22ab394e 100644
> --- a/drivers/scsi/sd.c
> +++ b/drivers/scsi/sd.c
> @@ -1206,6 +1206,14 @@ static blk_status_t sd_setup_read_write_cmnd(struct scsi_cmnd *cmd)
>  		}
>  	}
>  
> +	if (req_op(rq) == REQ_OP_ZONE_APPEND) {
> +		ret = sd_zbc_prepare_zone_append(cmd, &lba, nr_blocks);
> +		if (ret) {
> +			scsi_mq_uninit_cmd(cmd);
> +			return ret;
> +		}
> +	}
> +
>  	fua = rq->cmd_flags & REQ_FUA ? 0x8 : 0;
>  	dix = scsi_prot_sg_count(cmd);
>  	dif = scsi_host_dif_capable(cmd->device->host, sdkp->protection_type);
> @@ -1287,6 +1295,7 @@ static blk_status_t sd_init_command(struct scsi_cmnd *cmd)
>  		return sd_setup_flush_cmnd(cmd);
>  	case REQ_OP_READ:
>  	case REQ_OP_WRITE:
> +	case REQ_OP_ZONE_APPEND:
>  		return sd_setup_read_write_cmnd(cmd);
>  	case REQ_OP_ZONE_RESET:
>  		return sd_zbc_setup_zone_mgmt_cmnd(cmd, ZO_RESET_WRITE_POINTER,
> @@ -2055,7 +2064,7 @@ static int sd_done(struct scsi_cmnd *SCpnt)
>  
>   out:
>  	if (sd_is_zoned(sdkp))
> -		sd_zbc_complete(SCpnt, good_bytes, &sshdr);
> +		good_bytes = sd_zbc_complete(SCpnt, good_bytes, &sshdr);
>  
>  	SCSI_LOG_HLCOMPLETE(1, scmd_printk(KERN_INFO, SCpnt,
>  					   "sd_done: completed %d of %d bytes\n",
> @@ -3371,6 +3380,10 @@ static int sd_probe(struct device *dev)
>  	sdkp->first_scan = 1;
>  	sdkp->max_medium_access_timeouts = SD_MAX_MEDIUM_TIMEOUTS;
>  
> +	error = sd_zbc_init_disk(sdkp);
> +	if (error)
> +		goto out_free_index;
> +
>  	sd_revalidate_disk(gd);
>  
>  	gd->flags = GENHD_FL_EXT_DEVT;
> @@ -3408,6 +3421,7 @@ static int sd_probe(struct device *dev)
>   out_put:
>  	put_disk(gd);
>   out_free:
> +	sd_zbc_release_disk(sdkp);
>  	kfree(sdkp);
>   out:
>  	scsi_autopm_put_device(sdp);
> @@ -3484,6 +3498,8 @@ static void scsi_disk_release(struct device *dev)
>  	put_disk(disk);
>  	put_device(&sdkp->device->sdev_gendev);
>  
> +	sd_zbc_release_disk(sdkp);
> +
>  	kfree(sdkp);
>  }
>  
> @@ -3664,19 +3680,19 @@ static int __init init_sd(void)
>  	if (!sd_page_pool) {
>  		printk(KERN_ERR "sd: can't init discard page pool\n");
>  		err = -ENOMEM;
> -		goto err_out_ppool;
> +		goto err_out_cdb_pool;
>  	}
>  
>  	err = scsi_register_driver(&sd_template.gendrv);
>  	if (err)
> -		goto err_out_driver;
> +		goto err_out_ppool;
>  
>  	return 0;
>  
> -err_out_driver:
> +err_out_ppool:
>  	mempool_destroy(sd_page_pool);
>  
> -err_out_ppool:
> +err_out_cdb_pool:
>  	mempool_destroy(sd_cdb_pool);
>  
>  err_out_cache:
> diff --git a/drivers/scsi/sd.h b/drivers/scsi/sd.h
> index 50fff0bf8c8e..74448c250fea 100644
> --- a/drivers/scsi/sd.h
> +++ b/drivers/scsi/sd.h
> @@ -79,6 +79,10 @@ struct scsi_disk {
>  	u32		zones_optimal_open;
>  	u32		zones_optimal_nonseq;
>  	u32		zones_max_open;
> +	u32		*zones_wp_ofst;
> +	spinlock_t	zones_wp_ofst_lock;
> +	struct work_struct zone_wp_ofst_work;
> +	char		*zone_wp_update_buf;
>  #endif
>  	atomic_t	openers;
>  	sector_t	capacity;	/* size in logical blocks */
> @@ -207,17 +211,32 @@ static inline int sd_is_zoned(struct scsi_disk *sdkp)
>  
>  #ifdef CONFIG_BLK_DEV_ZONED
>  
> +int sd_zbc_init_disk(struct scsi_disk *sdkp);
> +void sd_zbc_release_disk(struct scsi_disk *sdkp);
>  extern int sd_zbc_read_zones(struct scsi_disk *sdkp, unsigned char *buffer);
>  extern void sd_zbc_print_zones(struct scsi_disk *sdkp);
>  blk_status_t sd_zbc_setup_zone_mgmt_cmnd(struct scsi_cmnd *cmd,
>  					 unsigned char op, bool all);
> -extern void sd_zbc_complete(struct scsi_cmnd *cmd, unsigned int good_bytes,
> -			    struct scsi_sense_hdr *sshdr);
> +unsigned int sd_zbc_complete(struct scsi_cmnd *cmd, unsigned int good_bytes,
> +			     struct scsi_sense_hdr *sshdr);
>  int sd_zbc_report_zones(struct gendisk *disk, sector_t sector,
>  		unsigned int nr_zones, report_zones_cb cb, void *data);
>  
> +blk_status_t sd_zbc_prepare_zone_append(struct scsi_cmnd *cmd, sector_t *lba,
> +				        unsigned int nr_blocks);
> +
>  #else /* CONFIG_BLK_DEV_ZONED */
>  
> +static inline int sd_zbc_init(void)
> +{
> +	return 0;
> +}
> +
> +static inline void sd_zbc_exit(void) {}
> +
> +static inline void sd_zbc_init_disk(struct scsi_disk *sdkp) {}
> +static inline void sd_zbc_release_disk(struct scsi_disk *sdkp) {}
> +
>  static inline int sd_zbc_read_zones(struct scsi_disk *sdkp,
>  				    unsigned char *buf)
>  {
> @@ -233,9 +252,18 @@ static inline blk_status_t sd_zbc_setup_zone_mgmt_cmnd(struct scsi_cmnd *cmd,
>  	return BLK_STS_TARGET;
>  }
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
>  #define sd_zbc_report_zones NULL
>  
> diff --git a/drivers/scsi/sd_zbc.c b/drivers/scsi/sd_zbc.c
> index ee156fbf3780..49c78040fa84 100644
> --- a/drivers/scsi/sd_zbc.c
> +++ b/drivers/scsi/sd_zbc.c
> @@ -42,6 +42,30 @@ static int sd_zbc_parse_report(struct scsi_disk *sdkp, u8 *buf,
>  	return cb(&zone, idx, data);
>  }
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
>  /**
>   * sd_zbc_do_report_zones - Issue a REPORT ZONES scsi command.
>   * @sdkp: The target disk
> @@ -229,6 +253,134 @@ static blk_status_t sd_zbc_cmnd_checks(struct scsi_cmnd *cmd)
>  	return BLK_STS_OK;
>  }
>  
> +#define SD_ZBC_INVALID_WP_OFST	~(0u)

Normally you want the braces on the outside:

	(~OU)

to avoid issues with complex expressions.

> +	/* Only zone reset and zone finish need zone write locking */
> +	if (op != ZO_RESET_WRITE_POINTER && op != ZO_FINISH_ZONE)
> +		return BLK_STS_OK;
> +
> +	if (all) {
> +		/* We do not write lock all zones for an all zone reset */
> +		if (op == ZO_RESET_WRITE_POINTER)
> +			return BLK_STS_OK;
> +
> +		/* Finishing all zones is not supported */
> +		return BLK_STS_IOERR;

I still find different locking rules for the all vs individual zone
operations weird.

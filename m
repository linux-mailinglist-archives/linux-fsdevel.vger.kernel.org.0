Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E932212825
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Jul 2020 17:41:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728669AbgGBPlN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 2 Jul 2020 11:41:13 -0400
Received: from fallback21.m.smailru.net ([94.100.176.131]:33514 "EHLO
        fallback21.mail.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726353AbgGBPlM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 2 Jul 2020 11:41:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mail.ru; s=mail2;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID; bh=AMazAOSkEYWJLSJv5b5/+9tWuzuN6QSzwWNXjpQWpas=;
        b=Xp2QhFz/kKegqxwoYA1IFcX96dAdUdMsqd2/4RnPhc8BK0lmq+xoBm04dr9OcyDjAZohF3ASSR/R1hZc2XyA8fqAX7ituoElKZ2pANbRiez7RC2dRDMOscpBnL1So6P0t4yr6u85LgleEHGXTdh/aDxhwc5wVHzDWvIYhthLL5s=;
Received: from [10.161.64.48] (port=49258 helo=smtp40.i.mail.ru)
        by fallback21.m.smailru.net with esmtp (envelope-from <alekseymmm@mail.ru>)
        id 1jr1Kf-0002Sk-L2; Thu, 02 Jul 2020 18:41:01 +0300
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mail.ru; s=mail2;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID; bh=AMazAOSkEYWJLSJv5b5/+9tWuzuN6QSzwWNXjpQWpas=;
        b=Xp2QhFz/kKegqxwoYA1IFcX96dAdUdMsqd2/4RnPhc8BK0lmq+xoBm04dr9OcyDjAZohF3ASSR/R1hZc2XyA8fqAX7ituoElKZ2pANbRiez7RC2dRDMOscpBnL1So6P0t4yr6u85LgleEHGXTdh/aDxhwc5wVHzDWvIYhthLL5s=;
Received: by smtp40.i.mail.ru with esmtpa (envelope-from <alekseymmm@mail.ru>)
        id 1jr1KR-0005GD-7v; Thu, 02 Jul 2020 18:40:48 +0300
Message-ID: <9c6ab0948d3391dbd8aaea671f5902a1fd0373d2.camel@mail.ru>
Subject: Re: [PATCH] block: Set req quiet flag if bio is quiet
From:   Aleksei Marov <alekseymmm@mail.ru>
To:     Jens Axboe <axboe@kernel.dk>, Ming Lei <tom.leiming@gmail.com>
Cc:     Denis Efremov <efremov@linux.com>, linux-block@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Borislav Petkov <bp@alien8.de>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Kai =?ISO-8859-1?Q?M=E4kisara?= <Kai.Makisara@kolumbus.fi>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Date:   Thu, 02 Jul 2020 18:40:44 +0300
In-Reply-To: <6611337f-f73e-7c7a-d8b0-428121e659b2@kernel.dk>
References: <bdef634a3a41dbecfd3d74f6bd25332445772902.camel@mail.ru>
         <CACVXFVObNuK=Uii_Tm2pSEEm2RAeECeha97-q=+XkDsuD6Vmsg@mail.gmail.com>
         <6611337f-f73e-7c7a-d8b0-428121e659b2@kernel.dk>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.3 (3.36.3-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-7564579A: 646B95376F6C166E
X-77F55803: 4F1203BC0FB41BD9AAC5A87EC32CE31E27640D885F1355A9B73DBC959FDB3EDB182A05F5380850405FAEF09EC9984FD987741A94517A70F4FDB8C796C773D318E368B24B0A5711F5
X-7FA49CB5: FF5795518A3D127A4AD6D5ED66289B5278DA827A17800CE76574C3D62D66A535EA1F7E6F0F101C67BD4B6F7A4D31EC0BCC500DACC3FED6E28638F802B75D45FF8AA50765F790063725D748B084CAA27D8638F802B75D45FF5571747095F342E8C7A0BC55FA0FE5FC0B2CE18087B06CAE188EA0B2C8DCE6357651DC143DAFEDE5389733CBF5DBD5E913377AFFFEAFD269A417C69337E82CC2CC7F00164DA146DAFE8445B8C89999725571747095F342E8C26CFBAC0749D213D2E47CDBA5A9658359CC434672EE6371117882F4460429728AD0CFFFB425014E40A5AABA2AD371193AA81AA40904B5D9A18204E546F3947C093C2F12201C912A040F9FF01DFDA4A84AD6D5ED66289B52F4A82D016A4342E36136E347CC761E07725E5C173C3A84C3B8066AFCF2BB2551BA3038C0950A5D36B5C8C57E37DE458B0B4866841D68ED3567F23339F89546C55F5C1EE8F4F765FC8C0F931425D397B1A7F4EDE966BC389F395957E7521B51C24C7702A67D5C33162DBA43225CD8A89F616AD31D0D18CD5C57739F23D657EF2BB5C8C57E37DE458B4C7702A67D5C3316FA3894348FB808DB48C21F01D89DB561574AF45C6390F7469DAA53EE0834AAEE
X-C8649E89: 74425B1C3EA6FAB932837FD6A4443DEE05AC78AAA71156473B78A7B66A2B740E242614503E66B7A9E9A4B081A2E84879
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2biojSri/cP7+1cUv24EjmP656w==
X-Mailru-Sender: 8261CADE3D3FA0B4BDFD1058942BD7EA5D3733B460AF532EB1E2146D43D3660614A4EB82564EB30EFEDCCAD94ABAB60078274A4A9E9E44FD4301F6103F424F867A458BE9B16E12C867EA787935ED9F1B
X-Mras: Ok
X-7564579A: EEAE043A70213CC8
X-77F55803: 5241C2F38277A35D7F9F52485CB584D7271FD7DF62800FDCBF11866496FE9895607158B4A2B68D781CF014E904298B7CFADF6C21B4D7AA75
X-7FA49CB5: 0D63561A33F958A5FE4999A208A509C4146E0C0FFC1E28EF3AC33A78DAAFBB358941B15DA834481FA18204E546F3947CEDCF5861DED71B2F389733CBF5DBD5E9C8A9BA7A39EFB7666BA297DBC24807EA117882F44604297287769387670735209ECD01F8117BC8BEA471835C12D1D977C4224003CC8364767815B9869FA544D8D32BA5DBAC0009BE9E8FC8737B5C2249425A8B0AE447E08B76E601842F6C81A12EF20D2F80756B5F7874E805F1D05189089D37D7C0E48F6CA18204E546F3947C9FFED5BD9FB4175535872C767BF85DA22EF20D2F80756B5F40A5AABA2AD3711975ECD9A6C639B01B78DA827A17800CE75B51C8FB0C3E748C731C566533BA786A40A5AABA2AD371193C9F3DD0FB1AF5EB82E77451A5C57BD33C9F3DD0FB1AF5EB4E70A05D1297E1BBCB5012B2E24CD356
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2biojSri/cP7+1cUGnuFsFbvsBw==
X-Mailru-MI: 800
X-Mailru-Sender: A5480F10D64C900511DAD0B11101DE4FF221D83292821239607158B4A2B68D786F46F3E7DDF2A4D4BA06D6758C6957D0C77752E0C033A69EE9C7C6BE7440F28B4CF838113C6AC4B43453F38A29522196
X-Mras: Ok
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 2020-06-29 at 14:44 -0600, Jens Axboe wrote:
> On 6/27/20 2:00 AM, Ming Lei wrote:
> > On Sat, Jun 27, 2020 at 2:12 AM Aleksei Marov <alekseymmm@mail.ru>
> > wrote:
> > > The current behavior is that if bio flagged as BIO_QUIETis
> > > submitted to request based block device then the request
> > > that wraps this bio in a queue is not quiet. RQF_FLAG is not
> > > set anywhere. Hence, if errors happen we can see error
> > > messages (e.g. in print_req_error) even though bio is quiet.
> > > This patch fixes that by setting the flag in blk_rq_bio_prep.
> > > 
> > > Signed-off-by: Aleksei Marov <alekseymmm@mail.ru>
> > > ---
> > >  block/blk.h | 3 +++
> > >  1 file changed, 3 insertions(+)
> > > 
> > > diff --git a/block/blk.h b/block/blk.h
> > > index b5d1f0f..04ca4e0 100644
> > > --- a/block/blk.h
> > > +++ b/block/blk.h
> > > @@ -108,6 +108,9 @@ static inline void blk_rq_bio_prep(struct
> > > request
> > > *rq, struct bio *bio,
> > > 
> > >         if (bio->bi_disk)
> > >                 rq->rq_disk = bio->bi_disk;
> > > +
> > > +       if (bio_flagged(bio, BIO_QUIET))
> > > +               rq->rq_flags |= RQF_QUIET;
> > >  }
> > 
> > BIO_QUIET consumer is fs code, and RQF_QUIET consumer is block
> > layer,
> > so you think
> > the two consumers' expectation is same?
> 
> They should be the same, the intent is to say "don't log errors on
> this
> piece of IO".
> 
> Would be much nicer if RQF_QUIET was just inherited naturally in
> req->cmd_flags from bio->bi_opf, like we do for the shared parts.
> Pretty confusing to have two different sets of flags and needing
> to inherit them independently, also more inefficient.
> 
I agree it would be nice to inherit bio QUIET flag to rq->cmd_flags
making the whole io quiet. The problem with the current splitting of
req and bio flags is that starting from
e806402130c9c494e22c73ae9ead4e79d2a5811c BIO_QUIET flag lives in 
bio->bi_flags (not bi_opf) and RQF_QUIET lives in rq->rq_flags 
(not rq->cmd_flags). But request inherits from bio only bio->bi_opf
  to its cmd_flags if I understand it correctly. In the past (before
e806402130c9c) we do have REQ_QUIET in bio->bi_opf that was  
directly passed to req->cmd_flags. I tried to fix this by removing 
both BIO_QUET and RQF_QUIET, using only REQ_QUIET and pass it from 
bio->bi_opf to rq->cmd_flags as you suggested. Please have a look at
this rewritten patch.

From c2c227edd268a020b914a89e3aa93817d1a741f2 Mon Sep 17 00:00:00 2001
From: Aleksei Marov <alekseymmm@mail.ru>
Date: Thu, 2 Jul 2020 17:45:57 +0300
Subject: [PATCH] block: Use common quiet flag for bio and req.

Signed-off-by: Aleksei Marov <alekseymmm@mail.ru>
---
 block/blk-core.c                            |  6 ++---
 block/blk-mq-debugfs.c                      |  2 +-
 drivers/ata/libata-eh.c                     |  2 +-
 drivers/ata/libata-scsi.c                   |  2 +-
 drivers/block/floppy.c                      |  2 +-
 drivers/block/pktcdvd.c                     |  2 +-
 drivers/ide/ide-atapi.c                     |  2 +-
 drivers/ide/ide-cd.c                        | 25 +++++++++++----------
 drivers/ide/ide-cd.h                        |  2 +-
 drivers/ide/ide-cd_ioctl.c                  |  6 ++---
 drivers/ide/ide-pm.c                        |  2 +-
 drivers/mmc/core/block.c                    |  2 +-
 drivers/mmc/core/queue.c                    |  2 +-
 drivers/scsi/device_handler/scsi_dh_alua.c  |  2 +-
 drivers/scsi/device_handler/scsi_dh_emc.c   |  2 +-
 drivers/scsi/device_handler/scsi_dh_hp_sw.c |  2 +-
 drivers/scsi/device_handler/scsi_dh_rdac.c  |  2 +-
 drivers/scsi/scsi_error.c                   |  2 +-
 drivers/scsi/scsi_lib.c                     |  8 +++----
 drivers/scsi/sd.c                           |  2 +-
 drivers/scsi/sd_zbc.c                       |  2 +-
 drivers/scsi/st.c                           |  2 +-
 fs/buffer.c                                 |  2 +-
 fs/iomap/buffered-io.c                      |  2 +-
 include/linux/bio.h                         |  2 +-
 include/linux/blk_types.h                   |  3 ++-
 include/linux/blkdev.h                      |  2 --
 27 files changed, 46 insertions(+), 46 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index 03252af8c82c..586675db6d8e 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -240,8 +240,8 @@ static void req_bio_endio(struct request *rq,
struct bio *bio,
 	if (error)
 		bio->bi_status = error;
 
-	if (unlikely(rq->rq_flags & RQF_QUIET))
-		bio_set_flag(bio, BIO_QUIET);
+	if (unlikely(rq->cmd_flags & REQ_QUIET))
+		bio->bi_opf |= REQ_QUIET;
 
 	bio_advance(bio, nbytes);
 
@@ -1551,7 +1551,7 @@ bool blk_update_request(struct request *req,
blk_status_t error,
 #endif
 
 	if (unlikely(error && !blk_rq_is_passthrough(req) &&
-		     !(req->rq_flags & RQF_QUIET)))
+		     !(req->cmd_flags & REQ_QUIET)))
 		print_req_error(req, error, __func__);
 
 	blk_account_io_completion(req, nr_bytes);
diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
index 15df3a36e9fa..5ec48b9cc348 100644
--- a/block/blk-mq-debugfs.c
+++ b/block/blk-mq-debugfs.c
@@ -281,6 +281,7 @@ static const char *const cmd_flag_name[] = {
 	CMD_FLAG_NAME(NOWAIT),
 	CMD_FLAG_NAME(NOUNMAP),
 	CMD_FLAG_NAME(HIPRI),
+	CMD_FLAG_NAME(QUIET),
 };
 #undef CMD_FLAG_NAME
 
@@ -295,7 +296,6 @@ static const char *const rqf_name[] = {
 	RQF_NAME(DONTPREP),
 	RQF_NAME(PREEMPT),
 	RQF_NAME(FAILED),
-	RQF_NAME(QUIET),
 	RQF_NAME(ELVPRIV),
 	RQF_NAME(IO_STAT),
 	RQF_NAME(ALLOCED),
diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
index 474c6c34fe02..76b505538233 100644
--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -1894,7 +1894,7 @@ static inline int ata_eh_worth_retry(struct
ata_queued_cmd *qc)
 static inline bool ata_eh_quiet(struct ata_queued_cmd *qc)
 {
 	if (qc->scsicmd &&
-	    qc->scsicmd->request->rq_flags & RQF_QUIET)
+	    qc->scsicmd->request->cmd_flags & REQ_QUIET)
 		qc->flags |= ATA_QCFLAG_QUIET;
 	return qc->flags & ATA_QCFLAG_QUIET;
 }
diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index 46336084b1a9..7cc41900db40 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -635,7 +635,7 @@ static struct ata_queued_cmd
*ata_scsi_qc_new(struct ata_device *dev,
 		qc->sg = scsi_sglist(cmd);
 		qc->n_elem = scsi_sg_count(cmd);
 
-		if (cmd->request->rq_flags & RQF_QUIET)
+		if (cmd->request->cmd_flags & REQ_QUIET)
 			qc->flags |= ATA_QCFLAG_QUIET;
 	} else {
 		cmd->result = (DID_OK << 16) | (QUEUE_FULL << 1);
diff --git a/drivers/block/floppy.c b/drivers/block/floppy.c
index 3e9db22db2a8..d4da7ad1f49a 100644
--- a/drivers/block/floppy.c
+++ b/drivers/block/floppy.c
@@ -4224,7 +4224,7 @@ static int __floppy_read_block_0(struct
block_device *bdev, int drive)
 	bio_add_page(&bio, page, size, 0);
 
 	bio.bi_iter.bi_sector = 0;
-	bio.bi_flags |= (1 << BIO_QUIET);
+	bio.bi_opf |= REQ_QUIET;
 	bio.bi_private = &cbdata;
 	bio.bi_end_io = floppy_rb0_cb;
 	bio_set_op_attrs(&bio, REQ_OP_READ, 0);
diff --git a/drivers/block/pktcdvd.c b/drivers/block/pktcdvd.c
index 27a33adc41e4..178cbb472542 100644
--- a/drivers/block/pktcdvd.c
+++ b/drivers/block/pktcdvd.c
@@ -720,7 +720,7 @@ static int pkt_generic_packet(struct pktcdvd_device
*pd, struct packet_command *
 
 	rq->timeout = 60*HZ;
 	if (cgc->quiet)
-		rq->rq_flags |= RQF_QUIET;
+		rq->cmd_flags |= REQ_QUIET;
 
 	blk_execute_rq(rq->q, pd->bdev->bd_disk, rq, 0);
 	if (scsi_req(rq)->result)
diff --git a/drivers/ide/ide-atapi.c b/drivers/ide/ide-atapi.c
index 80bc3bf82f4d..559285898a55 100644
--- a/drivers/ide/ide-atapi.c
+++ b/drivers/ide/ide-atapi.c
@@ -316,7 +316,7 @@ int ide_cd_expiry(ide_drive_t *drive)
 		wait = ATAPI_WAIT_PC;
 		break;
 	default:
-		if (!(rq->rq_flags & RQF_QUIET))
+		if (!(rq->cmd_flags & REQ_QUIET))
 			printk(KERN_INFO PFX "cmd 0x%x timed out\n",
 					 scsi_req(rq)->cmd[0]);
 		wait = 0;
diff --git a/drivers/ide/ide-cd.c b/drivers/ide/ide-cd.c
index 7f17f8303988..871d63bfe394 100644
--- a/drivers/ide/ide-cd.c
+++ b/drivers/ide/ide-cd.c
@@ -100,7 +100,7 @@ static int cdrom_log_sense(ide_drive_t *drive,
struct request *rq)
 	struct request_sense *sense = &drive->sense_data;
 	int log = 0;
 
-	if (!sense || !rq || (rq->rq_flags & RQF_QUIET))
+	if (!sense || !rq || (rq->cmd_flags & REQ_QUIET))
 		return 0;
 
 	ide_debug_log(IDE_DBG_SENSE, "sense_key: 0x%x", sense-
>sense_key);
@@ -321,7 +321,7 @@ static int cdrom_decode_status(ide_drive_t *drive,
u8 stat)
 			cdrom_saw_media_change(drive);
 
 			if (!blk_rq_is_passthrough(rq) &&
-			    !(rq->rq_flags & RQF_QUIET))
+			    !(rq->cmd_flags & REQ_QUIET))
 				printk(KERN_ERR PFX "%s: tray open\n",
 					drive->name);
 		}
@@ -356,7 +356,7 @@ static int cdrom_decode_status(ide_drive_t *drive,
u8 stat)
 		 * No point in retrying after an illegal request or
data
 		 * protect error.
 		 */
-		if (!(rq->rq_flags & RQF_QUIET))
+		if (!(rq->cmd_flags & REQ_QUIET))
 			ide_dump_status(drive, "command error", stat);
 		do_end_request = 1;
 		break;
@@ -365,14 +365,14 @@ static int cdrom_decode_status(ide_drive_t
*drive, u8 stat)
 		 * No point in re-trying a zillion times on a bad
sector.
 		 * If we got here the error is not correctable.
 		 */
-		if (!(rq->rq_flags & RQF_QUIET))
+		if (!(rq->cmd_flags & REQ_QUIET))
 			ide_dump_status(drive, "media error "
 					"(bad sector)", stat);
 		do_end_request = 1;
 		break;
 	case BLANK_CHECK:
 		/* disk appears blank? */
-		if (!(rq->rq_flags & RQF_QUIET))
+		if (!(rq->cmd_flags & REQ_QUIET))
 			ide_dump_status(drive, "media error (blank)",
 					stat);
 		do_end_request = 1;
@@ -432,16 +432,17 @@ static void
ide_cd_request_sense_fixup(ide_drive_t *drive, struct ide_cmd *cmd)
 int ide_cd_queue_pc(ide_drive_t *drive, const unsigned char *cmd,
 		    int write, void *buffer, unsigned *bufflen,
 		    struct scsi_sense_hdr *sshdr, int timeout,
-		    req_flags_t rq_flags)
+		    unsigned int cmd_flags)
 {
 	struct cdrom_info *info = drive->driver_data;
 	struct scsi_sense_hdr local_sshdr;
 	int retries = 10;
+	unsigned int flags = 0;
 	bool failed;
 
 	ide_debug_log(IDE_DBG_PC, "cmd[0]: 0x%x, write: 0x%x, timeout:
%d, "
 				  "rq_flags: 0x%x",
-				  cmd[0], write, timeout, rq_flags);
+				  cmd[0], write, timeout, cmd_flags);
 
 	if (!sshdr)
 		sshdr = &local_sshdr;
@@ -456,7 +457,7 @@ int ide_cd_queue_pc(ide_drive_t *drive, const
unsigned char *cmd,
 			write ? REQ_OP_DRV_OUT : REQ_OP_DRV_IN, 0);
 		memcpy(scsi_req(rq)->cmd, cmd, BLK_MAX_CDB);
 		ide_req(rq)->type = ATA_PRIV_PC;
-		rq->rq_flags |= rq_flags;
+		rq->cmd_flags |= cmd_flags;
 		rq->timeout = timeout;
 		if (buffer) {
 			error = blk_rq_map_kern(drive->queue, rq,
buffer,
@@ -845,7 +846,7 @@ static void cdrom_do_block_pc(ide_drive_t *drive,
struct request *rq)
 				  rq->cmd[0], rq->cmd_type);
 
 	if (blk_rq_is_scsi(rq))
-		rq->rq_flags |= RQF_QUIET;
+		rq->cmd_flags |= REQ_QUIET;
 	else
 		rq->rq_flags &= ~RQF_FAILED;
 
@@ -978,7 +979,7 @@ int cdrom_check_status(ide_drive_t *drive, struct
scsi_sense_hdr *sshdr)
 	 */
 	cmd[7] = cdi->sanyo_slot % 3;
 
-	return ide_cd_queue_pc(drive, cmd, 0, NULL, NULL, sshdr, 0,
RQF_QUIET);
+	return ide_cd_queue_pc(drive, cmd, 0, NULL, NULL, sshdr, 0,
REQ_QUIET);
 }
 
 static int cdrom_read_capacity(ide_drive_t *drive, unsigned long
*capacity,
@@ -1000,7 +1001,7 @@ static int cdrom_read_capacity(ide_drive_t
*drive, unsigned long *capacity,
 	cmd[0] = GPCMD_READ_CDVD_CAPACITY;
 
 	stat = ide_cd_queue_pc(drive, cmd, 0, &capbuf, &len, NULL, 0,
-			       RQF_QUIET);
+			       REQ_QUIET);
 	if (stat)
 		return stat;
 
@@ -1052,7 +1053,7 @@ static int ide_cdrom_read_tocentry(ide_drive_t
*drive, int trackno,
 	if (msf_flag)
 		cmd[1] = 2;
 
-	return ide_cd_queue_pc(drive, cmd, 0, buf, &buflen, NULL, 0,
RQF_QUIET);
+	return ide_cd_queue_pc(drive, cmd, 0, buf, &buflen, NULL, 0,
REQ_QUIET);
 }
 
 /* Try to read the entire TOC for the disk into our internal buffer.
*/
diff --git a/drivers/ide/ide-cd.h b/drivers/ide/ide-cd.h
index a69dc7f61c4d..7f1249affe43 100644
--- a/drivers/ide/ide-cd.h
+++ b/drivers/ide/ide-cd.h
@@ -98,7 +98,7 @@ void ide_cd_log_error(const char *, struct request *,
struct request_sense *);
 
 /* ide-cd.c functions used by ide-cd_ioctl.c */
 int ide_cd_queue_pc(ide_drive_t *, const unsigned char *, int, void *,
-		    unsigned *, struct scsi_sense_hdr *, int,
req_flags_t);
+		    unsigned *, struct scsi_sense_hdr *, int, unsigned
int);
 int ide_cd_read_toc(ide_drive_t *);
 int ide_cdrom_get_capabilities(ide_drive_t *, u8 *);
 void ide_cdrom_update_speed(ide_drive_t *, u8 *);
diff --git a/drivers/ide/ide-cd_ioctl.c b/drivers/ide/ide-cd_ioctl.c
index 46f2df288c6a..5539699754f6 100644
--- a/drivers/ide/ide-cd_ioctl.c
+++ b/drivers/ide/ide-cd_ioctl.c
@@ -298,7 +298,7 @@ int ide_cdrom_reset(struct cdrom_device_info *cdi)
 
 	rq = blk_get_request(drive->queue, REQ_OP_DRV_IN, 0);
 	ide_req(rq)->type = ATA_PRIV_MISC;
-	rq->rq_flags = RQF_QUIET;
+	rq->cmd_flags = REQ_QUIET;
 	blk_execute_rq(drive->queue, cd->disk, rq, 0);
 	ret = scsi_req(rq)->result ? -EIO : 0;
 	blk_put_request(rq);
@@ -442,7 +442,7 @@ int ide_cdrom_packet(struct cdrom_device_info *cdi,
 			    struct packet_command *cgc)
 {
 	ide_drive_t *drive = cdi->handle;
-	req_flags_t flags = 0;
+	unsigned int flags = 0;
 	unsigned len = cgc->buflen;
 
 	if (cgc->timeout <= 0)
@@ -456,7 +456,7 @@ int ide_cdrom_packet(struct cdrom_device_info *cdi,
 		memset(cgc->sshdr, 0, sizeof(*cgc->sshdr));
 
 	if (cgc->quiet)
-		flags |= RQF_QUIET;
+		flags |= REQ_QUIET;
 
 	cgc->stat = ide_cd_queue_pc(drive, cgc->cmd,
 				    cgc->data_direction ==
CGC_DATA_WRITE,
diff --git a/drivers/ide/ide-pm.c b/drivers/ide/ide-pm.c
index 192e6c65d34e..5e31f4cbcedd 100644
--- a/drivers/ide/ide-pm.c
+++ b/drivers/ide/ide-pm.c
@@ -45,7 +45,7 @@ static int ide_pm_execute_rq(struct request *rq)
 	struct request_queue *q = rq->q;
 
 	if (unlikely(blk_queue_dying(q))) {
-		rq->rq_flags |= RQF_QUIET;
+		rq->cmd_flags |= REQ_QUIET;
 		scsi_req(rq)->result = -ENXIO;
 		blk_mq_end_request(rq, BLK_STS_OK);
 		return -ENXIO;
diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
index 7896952de1ac..25b36c10902e 100644
--- a/drivers/mmc/core/block.c
+++ b/drivers/mmc/core/block.c
@@ -1875,7 +1875,7 @@ static void mmc_blk_mq_complete_rq(struct
mmc_queue *mq, struct request *req)
 		blk_mq_requeue_request(req, true);
 	} else {
 		if (mmc_card_removed(mq->card))
-			req->rq_flags |= RQF_QUIET;
+			req->cmd_flags |= REQ_QUIET;
 		blk_mq_end_request(req, BLK_STS_IOERR);
 	}
 }
diff --git a/drivers/mmc/core/queue.c b/drivers/mmc/core/queue.c
index 4b1eb89b401d..c81e123a5da7 100644
--- a/drivers/mmc/core/queue.c
+++ b/drivers/mmc/core/queue.c
@@ -257,7 +257,7 @@ static blk_status_t mmc_mq_queue_rq(struct
blk_mq_hw_ctx *hctx,
 	int ret;
 
 	if (mmc_card_removed(mq->card)) {
-		req->rq_flags |= RQF_QUIET;
+		req->cmd_flags |= REQ_QUIET;
 		return BLK_STS_IOERR;
 	}
 
diff --git a/drivers/scsi/device_handler/scsi_dh_alua.c
b/drivers/scsi/device_handler/scsi_dh_alua.c
index f32da0ca529e..ff1e80b2bede 100644
--- a/drivers/scsi/device_handler/scsi_dh_alua.c
+++ b/drivers/scsi/device_handler/scsi_dh_alua.c
@@ -1093,7 +1093,7 @@ static blk_status_t alua_prep_fn(struct
scsi_device *sdev, struct request *req)
 	case SCSI_ACCESS_STATE_TRANSITIONING:
 		return BLK_STS_RESOURCE;
 	default:
-		req->rq_flags |= RQF_QUIET;
+		req->cmd_flags |= REQ_QUIET;
 		return BLK_STS_IOERR;
 	}
 }
diff --git a/drivers/scsi/device_handler/scsi_dh_emc.c
b/drivers/scsi/device_handler/scsi_dh_emc.c
index caa685cfe3d4..b7acd657ea7b 100644
--- a/drivers/scsi/device_handler/scsi_dh_emc.c
+++ b/drivers/scsi/device_handler/scsi_dh_emc.c
@@ -334,7 +334,7 @@ static blk_status_t clariion_prep_fn(struct
scsi_device *sdev,
 	struct clariion_dh_data *h = sdev->handler_data;
 
 	if (h->lun_state != CLARIION_LUN_OWNED) {
-		req->rq_flags |= RQF_QUIET;
+		req->cmd_flags |= REQ_QUIET;
 		return BLK_STS_IOERR;
 	}
 
diff --git a/drivers/scsi/device_handler/scsi_dh_hp_sw.c
b/drivers/scsi/device_handler/scsi_dh_hp_sw.c
index 8acd4bb9fefb..9856392f74ee 100644
--- a/drivers/scsi/device_handler/scsi_dh_hp_sw.c
+++ b/drivers/scsi/device_handler/scsi_dh_hp_sw.c
@@ -164,7 +164,7 @@ static blk_status_t hp_sw_prep_fn(struct
scsi_device *sdev, struct request *req)
 	struct hp_sw_dh_data *h = sdev->handler_data;
 
 	if (h->path_state != HP_SW_PATH_ACTIVE) {
-		req->rq_flags |= RQF_QUIET;
+		req->cmd_flags |= REQ_QUIET;
 		return BLK_STS_IOERR;
 	}
 
diff --git a/drivers/scsi/device_handler/scsi_dh_rdac.c
b/drivers/scsi/device_handler/scsi_dh_rdac.c
index 5efc959493ec..8a0785dd2110 100644
--- a/drivers/scsi/device_handler/scsi_dh_rdac.c
+++ b/drivers/scsi/device_handler/scsi_dh_rdac.c
@@ -649,7 +649,7 @@ static blk_status_t rdac_prep_fn(struct scsi_device
*sdev, struct request *req)
 	struct rdac_dh_data *h = sdev->handler_data;
 
 	if (h->state != RDAC_STATE_ACTIVE) {
-		req->rq_flags |= RQF_QUIET;
+		req->cmd_flags |= REQ_QUIET;
 		return BLK_STS_IOERR;
 	}
 
diff --git a/drivers/scsi/scsi_error.c b/drivers/scsi/scsi_error.c
index 927b1e641842..c4dc4ac4d15a 100644
--- a/drivers/scsi/scsi_error.c
+++ b/drivers/scsi/scsi_error.c
@@ -1989,7 +1989,7 @@ static void scsi_eh_lock_door(struct scsi_device
*sdev)
 	rq->cmd[5] = 0;
 	rq->cmd_len = COMMAND_SIZE(rq->cmd[0]);
 
-	req->rq_flags |= RQF_QUIET;
+	req->cmd_flags |= REQ_QUIET;
 	req->timeout = 10 * HZ;
 	rq->retries = 5;
 
diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
index 0ba7a65e7c8d..7c0c4eb7b6d6 100644
--- a/drivers/scsi/scsi_lib.c
+++ b/drivers/scsi/scsi_lib.c
@@ -263,8 +263,8 @@ int __scsi_execute(struct scsi_device *sdev, const
unsigned char *cmd,
 	memcpy(rq->cmd, cmd, rq->cmd_len);
 	rq->retries = retries;
 	req->timeout = timeout;
-	req->cmd_flags |= flags;
-	req->rq_flags |= rq_flags | RQF_QUIET;
+	req->cmd_flags |= flags | REQ_QUIET;
+	req->rq_flags |= rq_flags;
 
 	/*
 	 * head injection *required* here otherwise quiesce won't work
@@ -768,7 +768,7 @@ static void scsi_io_completion_action(struct
scsi_cmnd *cmd, int result)
 	switch (action) {
 	case ACTION_FAIL:
 		/* Give up and fail the remainder of the request */
-		if (!(req->rq_flags & RQF_QUIET)) {
+		if (!(req->cmd_flags & REQ_QUIET)) {
 			static DEFINE_RATELIMIT_STATE(_rs,
 					DEFAULT_RATELIMIT_INTERVAL,
 					DEFAULT_RATELIMIT_BURST);
@@ -857,7 +857,7 @@ static int scsi_io_completion_nz_result(struct
scsi_cmnd *cmd, int result,
 		 */
 		if ((sshdr.asc == 0x0) && (sshdr.ascq == 0x1d))
 			do_print = false;
-		else if (req->rq_flags & RQF_QUIET)
+		else if (req->cmd_flags & REQ_QUIET)
 			do_print = false;
 		if (do_print)
 			scsi_print_sense(cmd);
diff --git a/drivers/scsi/sd.c b/drivers/scsi/sd.c
index d90fefffe31b..3498eaa0d106 100644
--- a/drivers/scsi/sd.c
+++ b/drivers/scsi/sd.c
@@ -2066,7 +2066,7 @@ static int sd_done(struct scsi_cmnd *SCpnt)
 				} else {
 					sdkp->device->no_write_same =
1;
 					sd_config_write_same(sdkp);
-					req->rq_flags |= RQF_QUIET;
+					req->cmd_flags |= REQ_QUIET;
 				}
 				break;
 			}
diff --git a/drivers/scsi/sd_zbc.c b/drivers/scsi/sd_zbc.c
index 6f7eba66687e..e52560cc0559 100644
--- a/drivers/scsi/sd_zbc.c
+++ b/drivers/scsi/sd_zbc.c
@@ -524,7 +524,7 @@ unsigned int sd_zbc_complete(struct scsi_cmnd *cmd,
unsigned int good_bytes,
 		 * attempted on a conventional zone. Nothing to worry
about,
 		 * so be quiet about the error.
 		 */
-		rq->rq_flags |= RQF_QUIET;
+		rq->cmd_flags |= REQ_QUIET;
 	} else if (sd_zbc_need_zone_wp_update(rq))
 		good_bytes = sd_zbc_zone_wp_update(cmd, good_bytes);
 
diff --git a/drivers/scsi/st.c b/drivers/scsi/st.c
index 87fbc0ea350b..c39878af00f4 100644
--- a/drivers/scsi/st.c
+++ b/drivers/scsi/st.c
@@ -553,7 +553,7 @@ static int st_scsi_execute(struct st_request
*SRpnt, const unsigned char *cmd,
 	if (IS_ERR(req))
 		return DRIVER_ERROR << 24;
 	rq = scsi_req(req);
-	req->rq_flags |= RQF_QUIET;
+	req->cmd_flags |= REQ_QUIET;
 
 	mdata->null_mapped = 1;
 
diff --git a/fs/buffer.c b/fs/buffer.c
index 64fe82ec65ff..c4c1391d6bcf 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -3016,7 +3016,7 @@ static void end_bio_bh_io_sync(struct bio *bio)
 {
 	struct buffer_head *bh = bio->bi_private;
 
-	if (unlikely(bio_flagged(bio, BIO_QUIET)))
+	if (unlikely(bio->bi_opf & REQ_QUIET))
 		set_bit(BH_Quiet, &bh->b_state);
 
 	bh->b_end_io(bh, !bio->bi_status);
diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index bcfc288dba3f..8aa90668f59d 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -1099,7 +1099,7 @@ iomap_finish_ioend(struct iomap_ioend *ioend, int
error)
 	struct bio *last = ioend->io_bio, *next;
 	u64 start = bio->bi_iter.bi_sector;
 	loff_t offset = ioend->io_offset;
-	bool quiet = bio_flagged(bio, BIO_QUIET);
+	bool quiet = bio->bi_opf & REQ_QUIET;
 
 	for (bio = &ioend->io_inline_bio; bio; bio = next) {
 		struct bio_vec *bv;
diff --git a/include/linux/bio.h b/include/linux/bio.h
index 91676d4b2dfe..942707056fd2 100644
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -425,7 +425,7 @@ static inline void bio_io_error(struct bio *bio)
 
 static inline void bio_wouldblock_error(struct bio *bio)
 {
-	bio_set_flag(bio, BIO_QUIET);
+	bio->bi_opf |= REQ_QUIET;
 	bio->bi_status = BLK_STS_AGAIN;
 	bio_endio(bio);
 }
diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index ccb895f911b1..19721f6c2d06 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -231,7 +231,6 @@ enum {
 	BIO_USER_MAPPED,	/* contains user pages */
 	BIO_NULL_MAPPED,	/* contains invalid user pages */
 	BIO_WORKINGSET,		/* contains userspace workingset pages
*/
-	BIO_QUIET,		/* Make BIO Quiet */
 	BIO_CHAIN,		/* chained bio, ->bi_remaining in
effect */
 	BIO_REFFED,		/* bio has elevated ->bi_cnt */
 	BIO_THROTTLED,		/* This bio has already been subjected
to
@@ -343,6 +342,7 @@ enum req_flag_bits {
 	__REQ_RAHEAD,		/* read ahead, can fail anytime */
 	__REQ_BACKGROUND,	/* background IO */
 	__REQ_NOWAIT,           /* Don't wait if request will block */
+	__REQ_QUIET,		/* don't worry about errors */
 	/*
 	 * When a shared kthread needs to issue a bio for a cgroup,
doing
 	 * so synchronously can lead to priority inversions as the
kthread
@@ -377,6 +377,7 @@ enum req_flag_bits {
 #define REQ_RAHEAD		(1ULL << __REQ_RAHEAD)
 #define REQ_BACKGROUND		(1ULL << __REQ_BACKGROUND)
 #define REQ_NOWAIT		(1ULL << __REQ_NOWAIT)
+#define REQ_QUIET		(1ULL << __REQ_QUIET)
 #define REQ_CGROUP_PUNT		(1ULL << __REQ_CGROUP_PUNT)
 
 #define REQ_NOUNMAP		(1ULL << __REQ_NOUNMAP)
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 8fd900998b4e..89a7bbb6a54b 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -85,8 +85,6 @@ typedef __u32 __bitwise req_flags_t;
 #define RQF_PREEMPT		((__force req_flags_t)(1 << 8))
 /* vaguely specified driver internal error.  Ignored by the block
layer */
 #define RQF_FAILED		((__force req_flags_t)(1 << 10))
-/* don't warn about errors */
-#define RQF_QUIET		((__force req_flags_t)(1 << 11))
 /* elevator private data attached */
 #define RQF_ELVPRIV		((__force req_flags_t)(1 << 12))
 /* account into disk and partition IO statistics */
-- 
2.26.2


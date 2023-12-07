Return-Path: <linux-fsdevel+bounces-5283-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E5F55809744
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Dec 2023 01:34:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 156C01C20A80
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Dec 2023 00:34:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75D085231
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Dec 2023 00:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="Z1hiUoIu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2381B1724
	for <linux-fsdevel@vger.kernel.org>; Thu,  7 Dec 2023 15:03:12 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1d04dba2781so12677095ad.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 07 Dec 2023 15:03:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1701990191; x=1702594991; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zUUqo74HjIp6iFPzKT+HkCFNHmNTvkgJqATOqeb1f+Q=;
        b=Z1hiUoIuOKiKGS4UyruDP3fn4gCojKwtkqfIFsRC3bpipi9k8MDWri3e6pkz+++LUb
         MNaux+SfRUP1tRItV+ykXLLBRUiGpC8kTExBq3d5HhZy1yvYwpLRO/a+2uxDFPb7fhK/
         nC72EK9Suny6v5LztIjEGjko9p5pRipTfeYfOchcv/2UYTxGWqS45xy9oKE2tZkYr2v5
         HpkXC++GPo7veD23BxXjYWovBQ7hnNRjtN5HQboUT/ctn9ku8GA+LyQy9fu6409dcLPd
         r9Hsw1pYSwBeQU5DAhkfMibmhQKjD5U6O+DINdOG4X8UknRwNMNN4Yeh/QNLZxRZiY8E
         tTtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701990191; x=1702594991;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zUUqo74HjIp6iFPzKT+HkCFNHmNTvkgJqATOqeb1f+Q=;
        b=jFH9PPPsvRD2yuWa0k4Mu6yyFMYdAv/h40dEqdcM4bB/uWlnMhUfINzOds9u0HDrF9
         CNq7/7oUmrO5nlp4Lt26YFeCPRU54MGWZJ7X4aB9xaLmhb34TcKI2am9Mx+heAT8V4aj
         KJr1JV8Lv4O32ICQw0RHgyEbTlQcvtW40CGr35oFB1SPFofbUAC1eSn71qQ9b/amKgtV
         1588GMmb7PvJfSR+vtnbLUZSQa0BlH51DDNbnxUoLWttOROHqDMWq8DUet22nfRzURdh
         04vMkZg/OaizCFsgV1Hy1IgDda5xTGs3U/6Z9JDUVYUTiFsJzHNEIlQcooAoYsIO1bDD
         oBzw==
X-Gm-Message-State: AOJu0YwgK1/WD6oguIMFRKoPvYT8HKFcGYOLaYYDmwZ4Te1nz4Psu5gp
	N8a5/2AVPC5I5jqUseNBFgv66g==
X-Google-Smtp-Source: AGHT+IFv/Ceiyuqh/M33UV2KoeRNYkDVWI2D5YhRjIdm15A5hPRHHs9y/kAgnKAhkc0fdTTe/qoM6g==
X-Received: by 2002:a17:902:ec85:b0:1d0:6ffe:1e88 with SMTP id x5-20020a170902ec8500b001d06ffe1e88mr3424044plg.107.1701990191462;
        Thu, 07 Dec 2023 15:03:11 -0800 (PST)
Received: from dread.disaster.area (pa49-180-125-5.pa.nsw.optusnet.com.au. [49.180.125.5])
        by smtp.gmail.com with ESMTPSA id h9-20020a170902b94900b001d071d58e85sm341966pls.98.2023.12.07.15.03.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Dec 2023 15:03:10 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1rBNOd-005GxC-1u;
	Fri, 08 Dec 2023 10:03:07 +1100
Date: Fri, 8 Dec 2023 10:03:07 +1100
From: Dave Chinner <david@fromorbit.com>
To: Theodore Ts'o <tytso@mit.edu>
Cc: hch@lst.de, Christian Brauner <brauner@kernel.org>,
	"Darrick J. Wong" <djwong@kernel.org>, Jan Kara <jack@suse.cz>,
	linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] [RFC] iomap: Use FUA for pure data O_DSYNC DIO writes
Message-ID: <ZXJPK0BTSs843bmt@dread.disaster.area>
References: <20180301014144.28892-1-david@fromorbit.com>
 <20231207065046.GA9663@mit.edu>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231207065046.GA9663@mit.edu>

On Thu, Dec 07, 2023 at 01:50:46AM -0500, Theodore Ts'o wrote:
> On Thu, Mar 01, 2018 at 12:41:44PM +1100, Dave Chinner wrote:
> > From: Dave Chinner <dchinner@redhat.com>
> > 
> > If we are doing direct IO writes with datasync semantics, we often
> > have to flush metadata changes along with the data write. However,
> > if we are overwriting existing data, there are no metadata changes
> > that we need to flush. In this case, optimising the IO by using
> > FUA write makes sense.
> > 
> > We know from teh IOMAP_F_DIRTY flag as to whether a specific inode
> > requires a metadata flush - this is currently used by DAX to ensure
> > extent modi$fication as stable in page fault operations. For direct
> > IO writes, we can use it to determine if we need to flush metadata
> > or not once the data is on disk.
> 
> Hi,
> 
> I've gotten an inquiry from some engineers at Microsoft who would
> really like it if ext4 could use FUA writes when doing O_DSYNC writes,
> since this is soemthing that SQL Server uses.  In the discussion for
> this patch series back in 2018[1], ext4 hadn't yet converted over to
> iomap for Direct I/O, and so adding this feature for ext4 wasn't
> really practical.
> 
> [1] https://lore.kernel.org/all/20180319160650.mavedzwienzgwgqi@quack2.suse.cz/
> 
> Today, ext4 does use iomap for DIO, but an experiment seems to
> indicate that something hasn't been wired up to enable FUA for O_DSYNC
> writes.  I've looked at fs/iomap/direct-io.c and it wasn't immediately
> obvious what I need to add to enable this feature.

I've actually looked briefly into this in the past for ext4 - IIRC
the problem is that mtime updates during the write are causing the
inode to get marked dirty.

Yeah, typical trace from a RWF_DSYNC direct IO through ext4 is:

xfs_io-6002  [007]  2986.814841: ext4_es_lookup_extent_enter: dev 7,0 ino 12 lblk 0
xfs_io-6002  [007]  2986.814848: ext4_es_lookup_extent_exit: dev 7,0 ino 12 found 1 [0/30720) 34304 W
xfs_io-6002  [007]  2986.814856: ext4_journal_start_inode: dev 7,0 blocks 2, rsv_blocks 0, revoke_creds 8, type 1, ino 12, caller ext4_dirty_inode+0x39
xfs_io-6002  [007]  2986.814875: ext4_mark_inode_dirty: dev 7,0 ino 12 caller ext4_dirty_inode+0x5c
xfs_io-6002  [007]  2986.814917: iomap_dio_rw_begin:   dev 7:0 ino 0xc size 0x40000000 offset 0x0 length 0x20000 done_before 0x0 flags DIRECT dio_flags  aio 0
xfs_io-6002  [007]  2986.814922: iomap_iter:           dev 7:0 ino 0xc pos 0x0 length 0x0 flags WRITE|DIRECT (0x11) ops ext4_iomap_overwrite_ops caller __iomap_dio_rw+0x1c2

So I think the problem may be through file_modified() from
ext4_dio_write_checks() triggering mtime updates which then comes
back through mark_inode_dirty and that ends up causing
the inode to be marked dirty and tracked by the journal.

Yup, there it is in generic_update_time():

	if (updated & (S_ATIME|S_MTIME|S_CTIME))
                dirty_flags = inode->i_sb->s_flags & SB_LAZYTIME ? I_DIRTY_TIME : I_DIRTY_SYNC;

it's setting the inode I_DIRTY_SYNC for mtime updates.

XFS does not do this. It implements the ->update_time() method so
doesn't use generic_update_time(). XFS tracks pure timestamp updates
separately to other dirty inode metadata. We then elide "timestamp
dirty" state from the IOMAP_F_DIRTY checks because O_DSYNC doesn't
require timestamps to be persisted.

FWIW, the patch below allows testing FUA optimisations on loop
devices....

-Dave.
-- 
Dave Chinner
david@fromorbit.com

loop: add support for FUA writes

From: Dave Chinner <dchinner@redhat.com>

Any file-backed loop device on a filesysetm that support the ->fsync
operation can do FUA writes. All a FUA write requires from the loop
device is RWF_DSYNC semantics for the specific REQ_FUA request that
is being processed. i.e. that it is on stable storage before the
request completes.

This allows simple testing of things like iomap FUA optimisations,
and should also provide better performance for loop device in
situations where the upper filesystem is issuing FUA writes to try
to avoid needing journal flushes. Using RWF_DSYNC will also allow
the lower filesystem to attempt to use REQ_FUA on loop devices using
direct IO and potentially improve the IO patterns all the way down
the stack as a result.

Prep:

# losetup --direct-io=on /dev/loop0 /mnt/scratch/foo.img 
# mkfs.xfs /dev/loop0
# mount /dev/loop0 /mnt/test
# xfs_io -fdc "pwrite -b 2m 0 1g" -c fsync /mnt/test/foo
# sync

Measure:

# xfs_io -fdc "pwrite -V 1 -D -b 128k 0 1m" -c fsync /mnt/test/foo

Before:

# grep . /sys/block/loop0/queue/*
....
/sys/block/loop0/queue/fua:0
....

# trace-cmd stream -e block* |grep xfs_io
.....
<...>-4654  [007]   809.018173: block_rq_issue:       7,0 WS 131072 () 192 + 256 [xfs_io]
<...>-4654  [007]   809.025910: block_bio_queue:      7,0 WS 448 + 256 [xfs_io]
<...>-4654  [007]   809.025917: block_getrq:          7,0 WS 448 + 256 [xfs_io]
....

After:

# grep . /sys/block/loop0/queue/*
....
/sys/block/loop0/queue/fua:1
....

# trace-cmd stream -e block* |grep xfs_io
.....
<...>-4648  [006]   793.968169: block_rq_issue:       7,0 WFS 131072 () 192 + 256 [xfs_io]
<...>-4648  [006]   793.977521: block_bio_queue:      7,0 WFS 448 + 256 [xfs_io]
<...>-4648  [006]   793.977531: block_getrq:          7,0 WFS 448 + 256 [xfs_io]

The upper XFS filesystem is issuing REQ_FUA writes to the loop
device now.

Signed-off-by: Dave Chinner <dchinner@redhat.com>
---
 drivers/block/loop.c | 29 ++++++++++++++++++++---------
 1 file changed, 20 insertions(+), 9 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 9f2d412fc560..6f2df09b3179 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -238,7 +238,8 @@ static void loop_set_size(struct loop_device *lo, loff_t size)
 		kobject_uevent(&disk_to_dev(lo->lo_disk)->kobj, KOBJ_CHANGE);
 }
 
-static int lo_write_bvec(struct file *file, struct bio_vec *bvec, loff_t *ppos)
+static int lo_write_bvec(struct file *file, struct bio_vec *bvec, loff_t *ppos,
+		rwf_t rw_flags)
 {
 	struct iov_iter i;
 	ssize_t bw;
@@ -246,7 +247,7 @@ static int lo_write_bvec(struct file *file, struct bio_vec *bvec, loff_t *ppos)
 	iov_iter_bvec(&i, ITER_SOURCE, bvec, 1, bvec->bv_len);
 
 	file_start_write(file);
-	bw = vfs_iter_write(file, &i, ppos, 0);
+	bw = vfs_iter_write(file, &i, ppos, rw_flags);
 	file_end_write(file);
 
 	if (likely(bw ==  bvec->bv_len))
@@ -261,14 +262,14 @@ static int lo_write_bvec(struct file *file, struct bio_vec *bvec, loff_t *ppos)
 }
 
 static int lo_write_simple(struct loop_device *lo, struct request *rq,
-		loff_t pos)
+		loff_t pos, rwf_t rw_flags)
 {
 	struct bio_vec bvec;
 	struct req_iterator iter;
 	int ret = 0;
 
 	rq_for_each_segment(bvec, rq, iter) {
-		ret = lo_write_bvec(lo->lo_backing_file, &bvec, &pos);
+		ret = lo_write_bvec(lo->lo_backing_file, &bvec, &pos, rw_flags);
 		if (ret < 0)
 			break;
 		cond_resched();
@@ -392,7 +393,7 @@ static void lo_rw_aio_complete(struct kiocb *iocb, long ret)
 }
 
 static int lo_rw_aio(struct loop_device *lo, struct loop_cmd *cmd,
-		     loff_t pos, int rw)
+		     loff_t pos, int rw, rwf_t rw_flags)
 {
 	struct iov_iter iter;
 	struct req_iterator rq_iter;
@@ -446,6 +447,7 @@ static int lo_rw_aio(struct loop_device *lo, struct loop_cmd *cmd,
 	cmd->iocb.ki_filp = file;
 	cmd->iocb.ki_complete = lo_rw_aio_complete;
 	cmd->iocb.ki_flags = IOCB_DIRECT;
+	kiocb_set_rw_flags(&cmd->iocb, rw_flags);
 	cmd->iocb.ki_ioprio = IOPRIO_PRIO_VALUE(IOPRIO_CLASS_NONE, 0);
 
 	if (rw == ITER_SOURCE)
@@ -464,6 +466,15 @@ static int do_req_filebacked(struct loop_device *lo, struct request *rq)
 {
 	struct loop_cmd *cmd = blk_mq_rq_to_pdu(rq);
 	loff_t pos = ((loff_t) blk_rq_pos(rq) << 9) + lo->lo_offset;
+	rwf_t rw_flags = 0;
+
+	/*
+	 * If we are being asked to do a REQ_FUA write, then we convert that to
+	 * a datasync write so that the contents of the write are on stable
+	 * storage before the write completes.
+	 */
+	if (rq->cmd_flags & REQ_FUA)
+		rw_flags = RWF_DSYNC;
 
 	/*
 	 * lo_write_simple and lo_read_simple should have been covered
@@ -490,12 +501,12 @@ static int do_req_filebacked(struct loop_device *lo, struct request *rq)
 		return lo_fallocate(lo, rq, pos, FALLOC_FL_PUNCH_HOLE);
 	case REQ_OP_WRITE:
 		if (cmd->use_aio)
-			return lo_rw_aio(lo, cmd, pos, ITER_SOURCE);
+			return lo_rw_aio(lo, cmd, pos, ITER_SOURCE, rw_flags);
 		else
-			return lo_write_simple(lo, rq, pos);
+			return lo_write_simple(lo, rq, pos, rw_flags);
 	case REQ_OP_READ:
 		if (cmd->use_aio)
-			return lo_rw_aio(lo, cmd, pos, ITER_DEST);
+			return lo_rw_aio(lo, cmd, pos, ITER_DEST, 0);
 		else
 			return lo_read_simple(lo, rq, pos);
 	default:
@@ -1077,7 +1088,7 @@ static int loop_configure(struct loop_device *lo, blk_mode_t mode,
 	mapping_set_gfp_mask(mapping, lo->old_gfp_mask & ~(__GFP_IO|__GFP_FS));
 
 	if (!(lo->lo_flags & LO_FLAGS_READ_ONLY) && file->f_op->fsync)
-		blk_queue_write_cache(lo->lo_queue, true, false);
+		blk_queue_write_cache(lo->lo_queue, true, true);
 
 	if (config->block_size)
 		bsize = config->block_size;


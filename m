Return-Path: <linux-fsdevel+bounces-19858-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ED4B88CA63A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 May 2024 04:38:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 196621C20E97
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 May 2024 02:38:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8061F10953;
	Tue, 21 May 2024 02:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="evMcCNPM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10E311B299
	for <linux-fsdevel@vger.kernel.org>; Tue, 21 May 2024 02:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716259116; cv=none; b=GaKXlrTRtSO70BYpc0C++sOUSqNW7g+Ki364Mt6BqIqauKaahWvUiJ+8uNj1svs8jzjlqxRUB9HbMIBibBRZevTA0M3698QBTzVr4Ydkna4/T0S/jviTozpZHs35IN0ia4vkUxk5Je1+Rt33qDiTJEnDP4O/WrdYUGCLcTMi4pU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716259116; c=relaxed/simple;
	bh=04V2TiG7n1566pTE69nmTzCYQM93yyc3uTcAW5bgVaU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rS77P0QJBsO6qMJUUYlI4bZtRWfmJIpgEkFTNL/kGgb6CtE+ogF41ofH5q35mWutBRzPXrsdto+GGcsdg1CVn+C4FBDdsXGpJ6gJhYMML2Z6y7CRdXxSSKAcRoypS3Kxj6pVCVgCn8ymu1vcW93yH53cYTsy86bBU3slodH4NbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=evMcCNPM; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1ee954e0aa6so64551575ad.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 20 May 2024 19:38:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1716259114; x=1716863914; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nAD2HfoXLZII7PkQY+RIy3eDF2S7Lzem/nR8E1ux0Zo=;
        b=evMcCNPM/oQaYMxN5Tu6ChZk/eJjm1GQ7ac5FjwH7ETz17OMJHkA8BExK9wzo4N8V1
         mZsNUG3a5h7BcE+Bvhk6xW6T5a7laj0uK+kvsSWGwprkNz9T0AUccLU21hUolmXkaA3q
         XOqaKxl+L3dwgwEku1KiRUSE5mWj6l3iHII5A1mmaZCymmZm2ODNGafpacssQjC/I1o7
         ekxBMG7rqdCXFNlFFQWtMLvA1yD4I7SSDeffZPSAYBOtv/4QnmCd6eoYG1meReUljzAG
         hn4Il/rrhj9EGVzUHGqNjrdXLLTh+WxW0zxS6TRCK5XAEEVgW19oUD4FpKVK8+Ei89Y+
         cREQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716259114; x=1716863914;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nAD2HfoXLZII7PkQY+RIy3eDF2S7Lzem/nR8E1ux0Zo=;
        b=MkZfdAolbWZYdXX+GeRO9eB70gMEwDl9oKIYIXCyUjxkRYFus7vmITljKjo/g28tW+
         VLfncTzKIxg4jkWZyUlfVVbpYpbbwjrv28zO+FFtKD7g+e7pl44pWrfCZD5qOP9JzCcX
         qUT9DJiuZUltzdGpCUPTAroMwdb20u8DIHBdMQxJuMvAopKiPPlOAyk5PDvaP8tzzbDs
         i0Xk0YuzEnijnzA4s28j1lSPyrL8xxK40icCNOtLTuTtMZx57lbC4fYNeOu2JtREj7Gg
         G5u9tJfZ+FdVmIQf80PGObWedXrOZU8OxWMUHRMwM3exCR4KRo6L9s6ts5rpjePFs1Gi
         1DbA==
X-Forwarded-Encrypted: i=1; AJvYcCXeyJ++YbU9b6148gMB5Pc5LwjbqPd6S8wwAZ7LEzipNfu+c8VNg4whQebHk3v5q/NhEk1A24M9IdxULUI1J2kqNua9yK+re05DkHyfSA==
X-Gm-Message-State: AOJu0YxFm7HU6bgrlqc2Z2LYl8KLSqHxAuMH+FmRi1+NlFopdP4OqSUn
	Po63x5FgkFQkpHt2zhf9dCEyfVtvyra/a1vH2ED2fY+IeSi35fhav+nM43JUXE0=
X-Google-Smtp-Source: AGHT+IF+y45+russ+eDPrVjYNTO1UVyGDJjV/s+G/taRA7G2C00wpzQgV7fi+keZlGEa+fybql83YA==
X-Received: by 2002:a17:90b:301:b0:2bd:92b3:c09b with SMTP id 98e67ed59e1d1-2bd92b3c272mr755060a91.42.1716259114007;
        Mon, 20 May 2024 19:38:34 -0700 (PDT)
Received: from dread.disaster.area (pa49-179-32-121.pa.nsw.optusnet.com.au. [49.179.32.121])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2b67158c39dsm20679185a91.35.2024.05.20.19.38.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 May 2024 19:38:33 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1s9FOY-004rHv-07;
	Tue, 21 May 2024 12:38:30 +1000
Date: Tue, 21 May 2024 12:38:30 +1000
From: Dave Chinner <david@fromorbit.com>
To: Zhang Yi <yi.zhang@huaweicloud.com>
Cc: linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-ext4@vger.kernel.org,
	djwong@kernel.org, hch@infradead.org, brauner@kernel.org,
	chandanbabu@kernel.org, jack@suse.cz, yi.zhang@huawei.com,
	chengzhihao1@huawei.com, yukuai3@huawei.com
Subject: Re: [PATCH v3 3/3] xfs: correct the zeroing truncate range
Message-ID: <ZkwJJuFCV+WQLl40@dread.disaster.area>
References: <20240517111355.233085-1-yi.zhang@huaweicloud.com>
 <20240517111355.233085-4-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240517111355.233085-4-yi.zhang@huaweicloud.com>

On Fri, May 17, 2024 at 07:13:55PM +0800, Zhang Yi wrote:
> From: Zhang Yi <yi.zhang@huawei.com>
> 
> When truncating a realtime file unaligned to a shorter size,
> xfs_setattr_size() only flush the EOF page before zeroing out, and
> xfs_truncate_page() also only zeros the EOF block. This could expose
> stale data since 943bc0882ceb ("iomap: don't increase i_size if it's not
> a write operation").
> 
> If the sb_rextsize is bigger than one block, and we have a realtime
> inode that contains a long enough written extent. If we unaligned
> truncate into the middle of this extent, xfs_itruncate_extents() could
> split the extent and align the it's tail to sb_rextsize, there maybe
> have more than one blocks more between the end of the file. Since
> xfs_truncate_page() only zeros the trailing portion of the i_blocksize()
> value, so it may leftover some blocks contains stale data that could be
> exposed if we append write it over a long enough distance later.
> 
> xfs_truncate_page() should flush, zeros out the entire rtextsize range,
> and make sure the entire zeroed range have been flushed to disk before
> updating the inode size.
> 
> Fixes: 943bc0882ceb ("iomap: don't increase i_size if it's not a write operation")
> Reported-by: Chandan Babu R <chandanbabu@kernel.org>
> Link: https://lore.kernel.org/linux-xfs/0b92a215-9d9b-3788-4504-a520778953c2@huaweicloud.com
> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
> ---
>  fs/xfs/xfs_iomap.c | 35 +++++++++++++++++++++++++++++++----
>  fs/xfs/xfs_iops.c  | 10 ----------
>  2 files changed, 31 insertions(+), 14 deletions(-)
> 
> diff --git a/fs/xfs/xfs_iomap.c b/fs/xfs/xfs_iomap.c
> index 4958cc3337bc..fc379450fe74 100644
> --- a/fs/xfs/xfs_iomap.c
> +++ b/fs/xfs/xfs_iomap.c
> @@ -1466,12 +1466,39 @@ xfs_truncate_page(
>  	loff_t			pos,
>  	bool			*did_zero)
>  {
> +	struct xfs_mount	*mp = ip->i_mount;
>  	struct inode		*inode = VFS_I(ip);
>  	unsigned int		blocksize = i_blocksize(inode);
> +	int			error;
> +
> +	if (XFS_IS_REALTIME_INODE(ip))
> +		blocksize = XFS_FSB_TO_B(mp, mp->m_sb.sb_rextsize);
> +
> +	/*
> +	 * iomap won't detect a dirty page over an unwritten block (or a
> +	 * cow block over a hole) and subsequently skips zeroing the
> +	 * newly post-EOF portion of the page. Flush the new EOF to
> +	 * convert the block before the pagecache truncate.
> +	 */
> +	error = filemap_write_and_wait_range(inode->i_mapping, pos,
> +					     roundup_64(pos, blocksize));
> +	if (error)
> +		return error;
>  
>  	if (IS_DAX(inode))
> -		return dax_truncate_page(inode, pos, blocksize, did_zero,
> -					&xfs_dax_write_iomap_ops);
> -	return iomap_truncate_page(inode, pos, blocksize, did_zero,
> -				   &xfs_buffered_write_iomap_ops);
> +		error = dax_truncate_page(inode, pos, blocksize, did_zero,
> +					  &xfs_dax_write_iomap_ops);
> +	else
> +		error = iomap_truncate_page(inode, pos, blocksize, did_zero,
> +					    &xfs_buffered_write_iomap_ops);
> +	if (error)
> +		return error;
> +
> +	/*
> +	 * Write back path won't write dirty blocks post EOF folio,
> +	 * flush the entire zeroed range before updating the inode
> +	 * size.
> +	 */
> +	return filemap_write_and_wait_range(inode->i_mapping, pos,
> +					    roundup_64(pos, blocksize));
>  }

Ok, this means we do -three- blocking writebacks through this path
instead of one or maybe two.

We already know that this existing blocking writeback case for dirty
pages over unwritten extents is a significant performance issue for
some workloads. I have a fix in progress for iomap to handle this
case without requiring blocking writeback to be done to convert the
extent to written before we do the truncate.

Regardless, I think this whole "truncate is allocation unit size
aware" algorithm is largely unworkable without a rewrite. What XFS
needs to do on truncate *down* before we start the truncate
transaction is pretty simple:

	- ensure that the new EOF extent tail contains zeroes
	- ensure that the range from the existing ip->i_disk_size to
	  the new EOF is on disk so data vs metadata ordering is
	  correct for crash recovery purposes.

What this patch does to acheive that is:

	1. blocking writeback to clean dirty unwritten/cow blocks at
	the new EOF.
	2. iomap_truncate_page() writes zeroes into the page cache,
	which dirties the pages we just cleaned at the new EOF.
	3. blocking writeback to clean the dirty blocks at the new
	EOF.
	4. truncate_setsize() then writes zeros to partial folios at
	the new EOF, dirtying the EOF page again.
	5. blocking writeback to clean dirty blocks from the current
	on-disk size to the new EOF.

This is pretty crazy when you stop and think about it. We're writing
the same EOF block -three- times. The first data write gets
overwritten by zeroes on the second write, and the third write
writes the same zeroes as the second write. There are two redundant
*blocking* writes in this process.

We can do all this with a single writeback operation if we are a
little bit smarter about the order of operations we perform and we
are a little bit smarter in iomap about zeroing dirty pages in the
page cache:

	1. change iomap_zero_range() to do the right thing with
	dirty unwritten and cow extents (the patch I've been working
	on).

	2. pass the range to be zeroed into iomap_truncate_page()
	(the fundamental change being made here).

	3. zero the required range *through the page cache*
	(iomap_zero_range() already does this).

	4. write back the XFS inode from ip->i_disk_size to the end
	of the range zeroed by iomap_truncate_page()
	(xfs_setattr_size() already does this).

	5. i_size_write(newsize);

	6. invalidate_inode_pages2_range(newsize, -1) to trash all
	the page cache beyond the new EOF without doing any zeroing
	as we've already done all the zeroing needed to the page
	cache through iomap_truncate_page().


The patch I'm working on for step 1 is below. It still needs to be
extended to handle the cow case, but I'm unclear on how to exercise
that case so I haven't written the code to do it. The rest of it is
just rearranging the code that we already use just to get the order
of operations right. The only notable change in behaviour is using
invalidate_inode_pages2_range() instead of truncate_pagecache(),
because we don't want the EOF page to be dirtied again once we've
already written zeroes to disk....

-- 
Dave Chinner
david@fromorbit.com


[RFC] iomap: zeroing needs to be pagecache aware

From: Dave Chinner <dchinner@redhat.com>

Unwritten extents can have page cache data over the range being
zeroed so we can't just skip them entirely. Fix this by checking for
an existing dirty folio over the unwritten range we are zeroing
and only performing zeroing if the folio is already dirty.

XXX: how do we detect a iomap containing a cow mapping over a hole
in iomap_zero_iter()? The XFS code implies this case also needs to
zero the page cache if there is data present, so trigger for page
cache lookup only in iomap_zero_iter() needs to handle this case as
well.

Before:

$ time sudo ./pwrite-trunc /mnt/scratch/foo 50000
path /mnt/scratch/foo, 50000 iters

real    0m14.103s
user    0m0.015s
sys     0m0.020s

$ sudo strace -c ./pwrite-trunc /mnt/scratch/foo 50000
path /mnt/scratch/foo, 50000 iters
% time     seconds  usecs/call     calls    errors syscall
------ ----------- ----------- --------- --------- ----------------
 85.90    0.847616          16     50000           ftruncate
 14.01    0.138229           2     50000           pwrite64
....

After:

$ time sudo ./pwrite-trunc /mnt/scratch/foo 50000
path /mnt/scratch/foo, 50000 iters

real    0m0.144s
user    0m0.021s
sys     0m0.012s

$ sudo strace -c ./pwrite-trunc /mnt/scratch/foo 50000
path /mnt/scratch/foo, 50000 iters
% time     seconds  usecs/call     calls    errors syscall
------ ----------- ----------- --------- --------- ----------------
 53.86    0.505964          10     50000           ftruncate
 46.12    0.433251           8     50000           pwrite64
....

Yup, we get back all the performance.

As for the "mmap write beyond EOF" data exposure aspect
documented here:

https://lore.kernel.org/linux-xfs/20221104182358.2007475-1-bfoster@redhat.com/

With this command:

$ sudo xfs_io -tfc "falloc 0 1k" -c "pwrite 0 1k" \
  -c "mmap 0 4k" -c "mwrite 3k 1k" -c "pwrite 32k 4k" \
  -c fsync -c "pread -v 3k 32" /mnt/scratch/foo

Before:

wrote 1024/1024 bytes at offset 0
1 KiB, 1 ops; 0.0000 sec (34.877 MiB/sec and 35714.2857 ops/sec)
wrote 4096/4096 bytes at offset 32768
4 KiB, 1 ops; 0.0000 sec (229.779 MiB/sec and 58823.5294 ops/sec)
00000c00:  58 58 58 58 58 58 58 58 58 58 58 58 58 58 58 58  XXXXXXXXXXXXXXXX
00000c10:  58 58 58 58 58 58 58 58 58 58 58 58 58 58 58 58  XXXXXXXXXXXXXXXX
read 32/32 bytes at offset 3072
32.000000 bytes, 1 ops; 0.0000 sec (568.182 KiB/sec and 18181.8182 ops/sec

After:

wrote 1024/1024 bytes at offset 0
1 KiB, 1 ops; 0.0000 sec (40.690 MiB/sec and 41666.6667 ops/sec)
wrote 4096/4096 bytes at offset 32768
4 KiB, 1 ops; 0.0000 sec (150.240 MiB/sec and 38461.5385 ops/sec)
00000c00:  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
00000c10:  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
read 32/32 bytes at offset 3072
32.000000 bytes, 1 ops; 0.0000 sec (558.036 KiB/sec and 17857.1429 ops/sec)

We see that this post-eof unwritten extent dirty page zeroing is
working correctly.

This has passed through most of fstests on a couple of test VMs
without issues at the moment, so I think this approach to fixing the
issue is going to be solid once we've worked out how to detect the
COW-hole mapping case.

Signed-off-by: Dave Chinner <dchinner@redhat.com>
---
 fs/iomap/buffered-io.c | 42 ++++++++++++++++++++++++++++++++++++++++--
 fs/xfs/xfs_iops.c      | 12 +-----------
 2 files changed, 41 insertions(+), 13 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 4e8e41c8b3c0..6877474de0c9 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -583,11 +583,23 @@ EXPORT_SYMBOL_GPL(iomap_is_partially_uptodate);
  *
  * Returns a locked reference to the folio at @pos, or an error pointer if the
  * folio could not be obtained.
+ *
+ * Note: when zeroing unwritten extents, we might have data in the page cache
+ * over an unwritten extent. In this case, we want to do a pure lookup on the
+ * page cache and not create a new folio as we don't need to perform zeroing on
+ * unwritten extents if there is no cached data over the given range.
  */
 struct folio *iomap_get_folio(struct iomap_iter *iter, loff_t pos, size_t len)
 {
 	fgf_t fgp = FGP_WRITEBEGIN | FGP_NOFS;
 
+	if (iter->flags & IOMAP_ZERO) {
+		const struct iomap *srcmap = iomap_iter_srcmap(iter);
+
+		if (srcmap->type == IOMAP_UNWRITTEN)
+			fgp &= ~FGP_CREAT;
+	}
+
 	if (iter->flags & IOMAP_NOWAIT)
 		fgp |= FGP_NOWAIT;
 	fgp |= fgf_set_order(len);
@@ -1375,7 +1387,7 @@ static loff_t iomap_zero_iter(struct iomap_iter *iter, bool *did_zero)
 	loff_t written = 0;
 
 	/* already zeroed?  we're done. */
-	if (srcmap->type == IOMAP_HOLE || srcmap->type == IOMAP_UNWRITTEN)
+	if (srcmap->type == IOMAP_HOLE)
 		return length;
 
 	do {
@@ -1385,8 +1397,22 @@ static loff_t iomap_zero_iter(struct iomap_iter *iter, bool *did_zero)
 		size_t bytes = min_t(u64, SIZE_MAX, length);
 
 		status = iomap_write_begin(iter, pos, bytes, &folio);
-		if (status)
+		if (status) {
+			if (status == -ENOENT) {
+				/*
+				 * Unwritten extents need to have page cache
+				 * lookups done to determine if they have data
+				 * over them that needs zeroing. If there is no
+				 * data, we'll get -ENOENT returned here, so we
+				 * can just skip over this index.
+				 */
+				WARN_ON_ONCE(srcmap->type != IOMAP_UNWRITTEN);
+				if (bytes > PAGE_SIZE - offset_in_page(pos))
+					bytes = PAGE_SIZE - offset_in_page(pos);
+				goto loop_continue;
+			}
 			return status;
+		}
 		if (iter->iomap.flags & IOMAP_F_STALE)
 			break;
 
@@ -1394,6 +1420,17 @@ static loff_t iomap_zero_iter(struct iomap_iter *iter, bool *did_zero)
 		if (bytes > folio_size(folio) - offset)
 			bytes = folio_size(folio) - offset;
 
+		/*
+		 * If the folio over an unwritten extent is clean (i.e. because
+		 * it has been read from), then it already contains zeros. Hence
+		 * we can just skip it.
+		 */
+		if (srcmap->type == IOMAP_UNWRITTEN &&
+		    !folio_test_dirty(folio)) {
+			folio_unlock(folio);
+			goto loop_continue;
+		}
+
 		folio_zero_range(folio, offset, bytes);
 		folio_mark_accessed(folio);
 
@@ -1401,6 +1438,7 @@ static loff_t iomap_zero_iter(struct iomap_iter *iter, bool *did_zero)
 		if (WARN_ON_ONCE(bytes == 0))
 			return -EIO;
 
+loop_continue:
 		pos += bytes;
 		length -= bytes;
 		written += bytes;
diff --git a/fs/xfs/xfs_iops.c b/fs/xfs/xfs_iops.c
index 8a145ca7d380..e8c9f3018c80 100644
--- a/fs/xfs/xfs_iops.c
+++ b/fs/xfs/xfs_iops.c
@@ -838,17 +838,7 @@ xfs_setattr_size(
 		trace_xfs_zero_eof(ip, oldsize, newsize - oldsize);
 		error = xfs_zero_range(ip, oldsize, newsize - oldsize,
 				&did_zeroing);
-	} else {
-		/*
-		 * iomap won't detect a dirty page over an unwritten block (or a
-		 * cow block over a hole) and subsequently skips zeroing the
-		 * newly post-EOF portion of the page. Flush the new EOF to
-		 * convert the block before the pagecache truncate.
-		 */
-		error = filemap_write_and_wait_range(inode->i_mapping, newsize,
-						     newsize);
-		if (error)
-			return error;
+	} else if (newsize != oldsize) {
 		error = xfs_truncate_page(ip, newsize, &did_zeroing);
 	}
 


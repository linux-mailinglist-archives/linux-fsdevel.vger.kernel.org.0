Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0B6A6A83EA
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Mar 2023 15:01:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229502AbjCBOBh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 2 Mar 2023 09:01:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjCBOBf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 2 Mar 2023 09:01:35 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3E2F30EB5
        for <linux-fsdevel@vger.kernel.org>; Thu,  2 Mar 2023 06:00:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1677765648;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mzxqT/82eghJHi/A12/GzK4yJegSBl5g7iy38wvVo6c=;
        b=gJ4QrIUzcp4OBrX6kkclKkP7Db71LTzGmDkR+qQYmQgzo4PQv6Qj9Gz4F1McPeAmi8ffwW
        Iv9sslE12ACp4tThOpUEcIsRl5I11EjiD2Y/JFOtLu+IXfoCrdJv1fRcmBJIknVeWpiUEp
        x2RxW5MmM3xMUGcLj+OpZyEe7TlnB64=
Received: from mail-oa1-f71.google.com (mail-oa1-f71.google.com
 [209.85.160.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-224-OX5k3sn_MpudPl9-JTMNTQ-1; Thu, 02 Mar 2023 09:00:47 -0500
X-MC-Unique: OX5k3sn_MpudPl9-JTMNTQ-1
Received: by mail-oa1-f71.google.com with SMTP id 586e51a60fabf-172c14fe3d4so8813331fac.4
        for <linux-fsdevel@vger.kernel.org>; Thu, 02 Mar 2023 06:00:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677765646;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mzxqT/82eghJHi/A12/GzK4yJegSBl5g7iy38wvVo6c=;
        b=T2766bpZD+3ufR1Jhvgk1r+eEOnGJlHWgkaWkTwCrzprGrbCrbZnyLmBy62Zxkc1B3
         JVpE0ewk5asHh3QdJY1BYWsGxLmN2siMoWKxqNRCTjHVsK1D9EvCS3GvOBKlcR3aSLUb
         1SFUKIfAW+ZMZu7305cX+hWu4OJwJquqQV7n5ueFuEBGAl0QQXdPfFBpFXMBvPgNmZds
         9jEFjZeBMmFq+l7G/QExGOapA5EXyDNUGna7YMkBwjaVGWeHzB72T6SPCPHrBU24SWSH
         6SBiBbsYaor5zQ8JJTCnXCB6/JYMD4lZs6saQljPMd7q+zhD4gQPtgLOTfobTTR0fC68
         6h3g==
X-Gm-Message-State: AO0yUKVkaj1eYNS5HAEcfoOCTcrgz4zZqfVOaScWI7uDU6ICJkUy4NIi
        ClP1UEk2LDP6XMgploPDP35simfayquY1hxlgPAkMqdeV+gBTybm6g2oJ/h4Gh1C7YlA5zA8KOi
        tOgOz34mKEbXtmYvTOZfu2AfV0g==
X-Received: by 2002:a05:6870:3322:b0:171:a571:2116 with SMTP id x34-20020a056870332200b00171a5712116mr6094382oae.9.1677765645659;
        Thu, 02 Mar 2023 06:00:45 -0800 (PST)
X-Google-Smtp-Source: AK7set+XXo0XybOq0+lg8x3/be2IvSuOu3oOvihizc9upCOP4ziqItFr1Ht0JiuPi0OpiNiAYGtv5Q==
X-Received: by 2002:a05:6870:3322:b0:171:a571:2116 with SMTP id x34-20020a056870332200b00171a5712116mr6094341oae.9.1677765644888;
        Thu, 02 Mar 2023 06:00:44 -0800 (PST)
Received: from bfoster (c-24-61-119-116.hsd1.ma.comcast.net. [24.61.119.116])
        by smtp.gmail.com with ESMTPSA id q11-20020a37430b000000b00742a252ba06sm8744805qka.135.2023.03.02.06.00.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Mar 2023 06:00:44 -0800 (PST)
Date:   Thu, 2 Mar 2023 09:02:24 -0500
From:   Brian Foster <bfoster@redhat.com>
To:     "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Aravinda Herle <araherle@in.ibm.com>
Subject: Re: [RFCv3 3/3] iomap: Support subpage size dirty tracking to
 improve write performance
Message-ID: <ZACscHnzmywRaXvu@bfoster>
References: <cover.1677428794.git.ritesh.list@gmail.com>
 <9650ef88e09c6227b99bb5793eef2b8e47994c7d.1677428795.git.ritesh.list@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9650ef88e09c6227b99bb5793eef2b8e47994c7d.1677428795.git.ritesh.list@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Feb 27, 2023 at 01:13:32AM +0530, Ritesh Harjani (IBM) wrote:
> On a 64k pagesize platforms (specially Power and/or aarch64) with 4k
> filesystem blocksize, this patch should improve the performance by doing
> only the subpage dirty data write.
> 
> This should also reduce the write amplification since we can now track
> subpage dirty status within state bitmaps. Earlier we had to
> write the entire 64k page even if only a part of it (e.g. 4k) was
> updated.
> 
> Performance testing of below fio workload reveals ~16x performance
> improvement on nvme with XFS (4k blocksize) on Power (64K pagesize)
> FIO reported write bw scores improved from around ~28 MBps to ~452 MBps.
> 
> 1. <test_randwrite.fio>
> [global]
> 	ioengine=psync
> 	rw=randwrite
> 	overwrite=1
> 	pre_read=1
> 	direct=0
> 	bs=4k
> 	size=1G
> 	dir=./
> 	numjobs=8
> 	fdatasync=1
> 	runtime=60
> 	iodepth=64
> 	group_reporting=1
> 
> [fio-run]
> 
> 2. Also our internal performance team reported that this patch improves there
>    database workload performance by around ~83% (with XFS on Power)
> 
> Reported-by: Aravinda Herle <araherle@in.ibm.com>
> Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
> ---
>  fs/gfs2/aops.c         |   2 +-
>  fs/iomap/buffered-io.c | 104 +++++++++++++++++++++++++++++++++++++----
>  fs/xfs/xfs_aops.c      |   2 +-
>  fs/zonefs/super.c      |   2 +-
>  include/linux/iomap.h  |   1 +
>  5 files changed, 99 insertions(+), 12 deletions(-)
> 
...
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index e0b0be16278e..fb55183c547f 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
...
> @@ -1630,7 +1715,7 @@ iomap_writepage_map(struct iomap_writepage_ctx *wpc,
>  		struct writeback_control *wbc, struct inode *inode,
>  		struct folio *folio, u64 end_pos)
>  {
> -	struct iomap_page *iop = iomap_page_create(inode, folio, 0);
> +	struct iomap_page *iop = iomap_page_create(inode, folio, 0, true);
>  	struct iomap_ioend *ioend, *next;
>  	unsigned len = i_blocksize(inode);
>  	unsigned nblocks = i_blocks_per_folio(inode, folio);
> @@ -1646,7 +1731,7 @@ iomap_writepage_map(struct iomap_writepage_ctx *wpc,
>  	 * invalid, grab a new one.
>  	 */
>  	for (i = 0; i < nblocks && pos < end_pos; i++, pos += len) {
> -		if (iop && !iop_test_uptodate(iop, i, nblocks))
> +		if (iop && !iop_test_dirty(iop, i, nblocks))
>  			continue;
> 
>  		error = wpc->ops->map_blocks(wpc, inode, pos);

Hi Ritesh,

I'm not sure if you followed any of the discussion on the imap
revalidation series that landed in the last cycle or so, but the
associated delalloc punch error handling code has a subtle dependency on
current writeback behavior and thus left a bit of a landmine for this
work. For reference, more detailed discussion starts around here [1].
The context is basically that the use of mapping seek hole/data relies
on uptodate status, which means in certain error cases the filesystem
might allocate a delalloc block for a write, but not punch it out of the
associated write happens to fail and the underlying portion of the folio
was uptodate.

This doesn't cause a problem in current mainline because writeback maps
every uptodate block in a dirty folio, and so the delalloc block will
convert at writeback time even though it wasn't written. This no longer
occurs with the change above, which means there's a vector for a stale
delalloc block to be left around in the inode. This is a free space
accounting corruption issue on XFS. Here's a quick example [2] on a 1k
FSB XFS filesystem to show exactly what I mean:

# xfs_io -fc "truncate 4k" -c "mmap 0 4k" -c "mread 0 4k" -c "pwrite 0 1" -c "pwrite -f 2k 1" -c fsync /mnt/file
# xfs_io -c "fiemap -v" /mnt/file 
/mnt/file:
 EXT: FILE-OFFSET      BLOCK-RANGE      TOTAL FLAGS
...
   2: [4..5]:          0..1                 2   0x7
...
(the above shows delalloc after an fsync)
# umount /mnt
  kernel:XFS: Assertion failed: xfs_is_shutdown(mp) || percpu_counter_sum(&mp->m_delalloc_blks) == 0, file: fs/xfs/xfs_super.c, line: 1068
# xfs_repair -n /dev/vdb2 
Phase 1 - find and verify superblock...
Phase 2 - using internal log
...
sb_fdblocks 20960187, counted 20960195
...
#

I suspect this means either the error handling code needs to be updated
to consider dirty state (i.e. punch delalloc if the block is !dirty), or
otherwise this needs to depend on a broader change in XFS to reclaim
delalloc blocks before inode eviction (along the lines of Dave's recent
proposal to do something like that for corrupted inodes). Of course the
caveat with the latter is that doesn't help for any other filesystems
(?) that might have similar expectations for delayed allocation and want
to use iomap.

Brian

[1] https://lore.kernel.org/linux-fsdevel/Y3TsPzd0XzXXIzQv@bfoster/

[2] This test case depends on a local xfs_io hack to co-opt the -f flag
into inducing a write failure. A POC patch for that is available here,
if you wanted to replicate:

https://lore.kernel.org/linux-xfs/20221123181322.3710820-1-bfoster@redhat.com/


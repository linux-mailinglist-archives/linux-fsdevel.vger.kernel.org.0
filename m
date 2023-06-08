Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FC02727889
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Jun 2023 09:17:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234276AbjFHHRd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 8 Jun 2023 03:17:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233688AbjFHHRS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 8 Jun 2023 03:17:18 -0400
Received: from out-44.mta0.migadu.com (out-44.mta0.migadu.com [91.218.175.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD5B211F
        for <linux-fsdevel@vger.kernel.org>; Thu,  8 Jun 2023 00:17:16 -0700 (PDT)
Message-ID: <ef307cf6-6f3a-adf8-f4aa-1cd780a0afc6@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1686208635;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PYaxIE7drJ+/TJJv2q7eZno6OBcQyD/ucHHPYyFGpK4=;
        b=wkJNRJHLbh9aQ4unHXMUUmMjaeBcXs/qFR3Rs4KyovmLF+kdicnLN+R7RHFxZR8gPOeUp9
        NX2P+REnUEJ34GOGBJdqlnL4r3MWIn5sufjigvIydnRKgqwEVvKiVeSEw5Vpc0fYi1EekM
        GtzdXjz0W+Gt6CipwVe6wb8Pthy8PJw=
Date:   Thu, 8 Jun 2023 15:17:03 +0800
MIME-Version: 1.0
Subject: Re: [PATCH] fuse: add a new flag to allow shared mmap in
 FOPEN_DIRECT_IO mode
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Hao Xu <hao.xu@linux.dev>
To:     fuse-devel@lists.sourceforge.net
Cc:     miklos@szeredi.hu, bernd.schubert@fastmail.fm,
        linux-fsdevel@vger.kernel.org
References: <20230505081652.43008-1-hao.xu@linux.dev>
Content-Language: en-US
In-Reply-To: <20230505081652.43008-1-hao.xu@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

ping...

On 5/5/23 16:16, Hao Xu wrote:
> From: Hao Xu <howeyxu@tencent.com>
> 
> FOPEN_DIRECT_IO is usually set by fuse daemon to indicate need of strong
> coherency, e.g. network filesystems. Thus shared mmap is disabled since
> it leverages page cache and may write to it, which may cause
> inconsistence. But FOPEN_DIRECT_IO can be used not for coherency but to
> reduce memory footprint as well, e.g. reduce guest memory usage with
> virtiofs. Therefore, add a new flag FOPEN_DIRECT_IO_SHARED_MMAP to allow
> shared mmap for these cases.
> 
> Signed-off-by: Hao Xu <howeyxu@tencent.com>
> ---
>   fs/fuse/file.c            | 11 ++++++++---
>   include/uapi/linux/fuse.h |  2 ++
>   2 files changed, 10 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/fuse/file.c b/fs/fuse/file.c
> index 89d97f6188e0..655896bdb0d5 100644
> --- a/fs/fuse/file.c
> +++ b/fs/fuse/file.c
> @@ -161,7 +161,8 @@ struct fuse_file *fuse_file_open(struct fuse_mount *fm, u64 nodeid,
>   	}
>   
>   	if (isdir)
> -		ff->open_flags &= ~FOPEN_DIRECT_IO;
> +		ff->open_flags &=
> +			~(FOPEN_DIRECT_IO | FOPEN_DIRECT_IO_SHARED_MMAP);
>   
>   	ff->nodeid = nodeid;
>   
> @@ -2509,8 +2510,12 @@ static int fuse_file_mmap(struct file *file, struct vm_area_struct *vma)
>   		return fuse_dax_mmap(file, vma);
>   
>   	if (ff->open_flags & FOPEN_DIRECT_IO) {
> -		/* Can't provide the coherency needed for MAP_SHARED */
> -		if (vma->vm_flags & VM_MAYSHARE)
> +		/* Can't provide the coherency needed for MAP_SHARED.
> +		 * So disable it if FOPEN_DIRECT_IO_SHARED_MMAP is not
> +		 * set, which means we do need strong coherency.
> +		 */
> +		if (!(ff->open_flags & FOPEN_DIRECT_IO_SHARED_MMAP) &&
> +		    vma->vm_flags & VM_MAYSHARE)
>   			return -ENODEV;
>   
>   		invalidate_inode_pages2(file->f_mapping);
> diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
> index 1b9d0dfae72d..003dcf42e8c2 100644
> --- a/include/uapi/linux/fuse.h
> +++ b/include/uapi/linux/fuse.h
> @@ -314,6 +314,7 @@ struct fuse_file_lock {
>    * FOPEN_STREAM: the file is stream-like (no file position at all)
>    * FOPEN_NOFLUSH: don't flush data cache on close (unless FUSE_WRITEBACK_CACHE)
>    * FOPEN_PARALLEL_DIRECT_WRITES: Allow concurrent direct writes on the same inode
> + * FOPEN_DIRECT_IO_SHARED_MMAP: allow shared mmap when FOPEN_DIRECT_IO is set
>    */
>   #define FOPEN_DIRECT_IO		(1 << 0)
>   #define FOPEN_KEEP_CACHE	(1 << 1)
> @@ -322,6 +323,7 @@ struct fuse_file_lock {
>   #define FOPEN_STREAM		(1 << 4)
>   #define FOPEN_NOFLUSH		(1 << 5)
>   #define FOPEN_PARALLEL_DIRECT_WRITES	(1 << 6)
> +#define FOPEN_DIRECT_IO_SHARED_MMAP	(1 << 7)
>   
>   /**
>    * INIT request/reply flags


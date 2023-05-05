Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90D476F8A43
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 May 2023 22:38:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230483AbjEEUir (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 5 May 2023 16:38:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229628AbjEEUip (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 5 May 2023 16:38:45 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C68DF49FE
        for <linux-fsdevel@vger.kernel.org>; Fri,  5 May 2023 13:37:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1683319078;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=eD1AMxxfBQfqYaB1iN4u85B3IBKCpSSmTNe8DCcQ7d4=;
        b=OnMmeVdxcrDFJ/DRyRlBIG9wqEDLwzjYezxEh8zoaT1kivLHbOg9bjaUe7stBplHirLrGT
        cq6CpDiK5CyEA6Zyi+G7M4Nva7rpw92vRDwgPM7CEFU1rIfnoHXRLqt6Pql2rPbKEAdmwY
        2GvmPdVRaYPkCRFRCRAiqsRA01ohkCw=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-144-nlFiOJDbMFSp7h2z3cB03w-1; Fri, 05 May 2023 16:37:53 -0400
X-MC-Unique: nlFiOJDbMFSp7h2z3cB03w-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 10CA43804518;
        Fri,  5 May 2023 20:37:53 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.22.8.233])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 56F22140E917;
        Fri,  5 May 2023 20:37:52 +0000 (UTC)
Received: by fedora.redhat.com (Postfix, from userid 1000)
        id E995E1647DE; Fri,  5 May 2023 16:37:51 -0400 (EDT)
Date:   Fri, 5 May 2023 16:37:51 -0400
From:   Vivek Goyal <vgoyal@redhat.com>
To:     Hao Xu <hao.xu@linux.dev>
Cc:     fuse-devel@lists.sourceforge.net, miklos@szeredi.hu,
        bernd.schubert@fastmail.fm, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] fuse: add a new flag to allow shared mmap in
 FOPEN_DIRECT_IO mode
Message-ID: <ZFVpH1n0VzNe7iVE@redhat.com>
References: <20230505081652.43008-1-hao.xu@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230505081652.43008-1-hao.xu@linux.dev>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, May 05, 2023 at 04:16:52PM +0800, Hao Xu wrote:
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
>  fs/fuse/file.c            | 11 ++++++++---
>  include/uapi/linux/fuse.h |  2 ++
>  2 files changed, 10 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/fuse/file.c b/fs/fuse/file.c
> index 89d97f6188e0..655896bdb0d5 100644
> --- a/fs/fuse/file.c
> +++ b/fs/fuse/file.c
> @@ -161,7 +161,8 @@ struct fuse_file *fuse_file_open(struct fuse_mount *fm, u64 nodeid,
>  	}
>  
>  	if (isdir)
> -		ff->open_flags &= ~FOPEN_DIRECT_IO;
> +		ff->open_flags &=
> +			~(FOPEN_DIRECT_IO | FOPEN_DIRECT_IO_SHARED_MMAP);
>  
>  	ff->nodeid = nodeid;
>  
> @@ -2509,8 +2510,12 @@ static int fuse_file_mmap(struct file *file, struct vm_area_struct *vma)
>  		return fuse_dax_mmap(file, vma);
>  
>  	if (ff->open_flags & FOPEN_DIRECT_IO) {
> -		/* Can't provide the coherency needed for MAP_SHARED */
> -		if (vma->vm_flags & VM_MAYSHARE)
> +		/* Can't provide the coherency needed for MAP_SHARED.
> +		 * So disable it if FOPEN_DIRECT_IO_SHARED_MMAP is not
> +		 * set, which means we do need strong coherency.
> +		 */
> +		if (!(ff->open_flags & FOPEN_DIRECT_IO_SHARED_MMAP) &&
> +		    vma->vm_flags & VM_MAYSHARE)
>  			return -ENODEV;

Can you give an example how this is useful and how do you plan to 
use it?

If goal is not using guest cache (either for saving memory or for cache
coherency with other clients) and hence you used FOPEN_DIRECT_IO,
then by allowing page cache for mmap(), we are contracting that goal.
We are neither saving memory and at the same time we are not
cache coherent.

IIUC, for virtiofs, you want to use cache=none but at the same time
allow guest applications to do shared mmap() hence you are introducing
this change. There have been folks who have complained about it
and I think 9pfs offers a mode which does this. So solving this
problem will be nice.

BTW, if "-o dax" is used, it solves this problem. But unfortunately qemu
does not have DAX support yet and we also have issues with page truncation
on host and MCE not travelling into the guest. So DAX is not a perfect
option yet.

I agree that solving this problem will be nice. Just trying to
understand the behavior better. How these cache pages will
interact with read/write?

Thanks
Vivek

>  
>  		invalidate_inode_pages2(file->f_mapping);
> diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
> index 1b9d0dfae72d..003dcf42e8c2 100644
> --- a/include/uapi/linux/fuse.h
> +++ b/include/uapi/linux/fuse.h
> @@ -314,6 +314,7 @@ struct fuse_file_lock {
>   * FOPEN_STREAM: the file is stream-like (no file position at all)
>   * FOPEN_NOFLUSH: don't flush data cache on close (unless FUSE_WRITEBACK_CACHE)
>   * FOPEN_PARALLEL_DIRECT_WRITES: Allow concurrent direct writes on the same inode
> + * FOPEN_DIRECT_IO_SHARED_MMAP: allow shared mmap when FOPEN_DIRECT_IO is set
>   */
>  #define FOPEN_DIRECT_IO		(1 << 0)
>  #define FOPEN_KEEP_CACHE	(1 << 1)
> @@ -322,6 +323,7 @@ struct fuse_file_lock {
>  #define FOPEN_STREAM		(1 << 4)
>  #define FOPEN_NOFLUSH		(1 << 5)
>  #define FOPEN_PARALLEL_DIRECT_WRITES	(1 << 6)
> +#define FOPEN_DIRECT_IO_SHARED_MMAP	(1 << 7)
>  
>  /**
>   * INIT request/reply flags
> -- 
> 2.25.1
> 


Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A354955DA6C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Jun 2022 15:23:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236854AbiF0OpX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Jun 2022 10:45:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236155AbiF0OpX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Jun 2022 10:45:23 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 28778DEF4
        for <linux-fsdevel@vger.kernel.org>; Mon, 27 Jun 2022 07:45:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656341121;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yyYHa7y7EUCo9FXbppA7Bdwl7O2prZRvBIG44/C0Bxw=;
        b=HmgfQJJcf3tN1lvtUn2+E+YoSOCViAPhDPcpkYp8PlylGwCV/FQNJnMl8VkefC87TMNjWL
        9FHQrw/nAi8FuHGsvPeQbBJz1DottkyMeWZ1ZcRf8XGc2EphU+G4Y/o9c4woo/dD0EB9fj
        nSOvJZGsFt+LtR983CG9W5N394SYbLo=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-218-CNTJjapDMpuv8IMhdLFhYg-1; Mon, 27 Jun 2022 10:45:17 -0400
X-MC-Unique: CNTJjapDMpuv8IMhdLFhYg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8EBB938149C4;
        Mon, 27 Jun 2022 14:45:17 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.18.25.210])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1473740C1289;
        Mon, 27 Jun 2022 14:45:17 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id E1EFA220463; Mon, 27 Jun 2022 10:45:16 -0400 (EDT)
Date:   Mon, 27 Jun 2022 10:45:16 -0400
From:   Vivek Goyal <vgoyal@redhat.com>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Jiachen Zhang <zhangjiachen.jaycee@bytedance.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Xie Yongji <xieyongji@bytedance.com>
Subject: Re: Re: Re: [RFC PATCH] fuse: support cache revalidation in
 writeback_cache mode
Message-ID: <YrnCfISl7Nl8Wk52@redhat.com>
References: <20220325132126.61949-1-zhangjiachen.jaycee@bytedance.com>
 <CAJfpeguESQm1KsQLyoMRTevLttV8N8NTGsb2tRbNS1AQ_pNAww@mail.gmail.com>
 <CAFQAk7ibzCn8OD84-nfg6_AePsKFTu9m7pXuQwcQP5OBp7ZCag@mail.gmail.com>
 <CAJfpegsbaz+RRcukJEOw+H=G3ft43vjDMnJ8A24JiuZFQ24eHA@mail.gmail.com>
 <CAFQAk7hakYNfBaOeMKRmMPTyxFb2xcyUTdugQG1D6uZB_U1zBg@mail.gmail.com>
 <Ymfu8fGbfYi4FxQ4@miu.piliscsaba.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ymfu8fGbfYi4FxQ4@miu.piliscsaba.redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.2
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Apr 26, 2022 at 03:09:05PM +0200, Miklos Szeredi wrote:
> On Mon, Apr 25, 2022 at 09:52:44PM +0800, Jiachen Zhang wrote:
> 
> > Some users may want both the high performance of writeback mode and a
> > little bit more consistency among FUSE mounts. In the current
> > writeback mode implementation, users of one FUSE mount can never see
> > the file expansion done by other FUSE mounts.
> 
> Okay.
> 
> Here's a preliminary patch that you could try.
> 
> Thanks,
> Miklos
> 
> ---
>  fs/fuse/dir.c             |   35 ++++++++++++++++++++++-------------
>  fs/fuse/file.c            |   17 +++++++++++++++--
>  fs/fuse/fuse_i.h          |   14 +++++++++++++-
>  fs/fuse/inode.c           |   32 +++++++++++++++++++++++++++-----
>  include/uapi/linux/fuse.h |    5 +++++
>  5 files changed, 82 insertions(+), 21 deletions(-)
> 
> --- a/include/uapi/linux/fuse.h
> +++ b/include/uapi/linux/fuse.h
> @@ -194,6 +194,7 @@
>   *  - add FUSE_SECURITY_CTX init flag
>   *  - add security context to create, mkdir, symlink, and mknod requests
>   *  - add FUSE_HAS_INODE_DAX, FUSE_ATTR_DAX
> + *  - add FUSE_WRITEBACK_CACHE_V2 init flag
>   */
>  
>  #ifndef _LINUX_FUSE_H
> @@ -353,6 +354,9 @@ struct fuse_file_lock {
>   * FUSE_SECURITY_CTX:	add security context to create, mkdir, symlink, and
>   *			mknod
>   * FUSE_HAS_INODE_DAX:  use per inode DAX
> + * FUSE_WRITEBACK_CACHE_V2:
> + *			- allow time/size to be refreshed if no pending write
> + * 			- time/size not cached for falocate/copy_file_range
>   */
>  #define FUSE_ASYNC_READ		(1 << 0)
>  #define FUSE_POSIX_LOCKS	(1 << 1)
> @@ -389,6 +393,7 @@ struct fuse_file_lock {
>  /* bits 32..63 get shifted down 32 bits into the flags2 field */
>  #define FUSE_SECURITY_CTX	(1ULL << 32)
>  #define FUSE_HAS_INODE_DAX	(1ULL << 33)
> +#define FUSE_WRITEBACK_CACHE_V2	(1ULL << 34)
>  
>  /**
>   * CUSE INIT request/reply flags
> --- a/fs/fuse/inode.c
> +++ b/fs/fuse/inode.c
> @@ -222,19 +222,37 @@ void fuse_change_attributes_common(struc
>  u32 fuse_get_cache_mask(struct inode *inode)
>  {
>  	struct fuse_conn *fc = get_fuse_conn(inode);
> +	struct fuse_inode *fi = get_fuse_inode(inode);
>  
>  	if (!fc->writeback_cache || !S_ISREG(inode->i_mode))
>  		return 0;
>  
> +	/*
> +	 * In writeback_cache_v2 mode if all the following conditions are met,
> +	 * then allow the attributes to be refreshed:
> +	 *
> +	 * - inode is not dirty (I_DIRTY_INODE)
> +	 * - inode is not in the process of being written (I_SYNC)
> +	 * - inode has no dirty pages (I_DIRTY_PAGES)
> +	 * - inode does not have any page writeback in progress
> +	 *
> +	 * Note: checking PAGECACHE_TAG_WRITEBACK is not sufficient in fuse,
> +	 * since inode can appear to have no PageWriteback pages, yet still have
> +	 * outstanding write request.
> +	 */

Hi,

I started following this thread just now after Jiachen pointed me to
previous conversations. Without going into too much details.

Based on above description, so we will update mtime/ctime/i_size only
if inode does not have dirty pages or nothing is in progress. So that
means sometime we will update it and other times we will ignore it. 

Do I understand it correctly. I am wondering how that is useful to
applications. 

I thought that other remote filesystems might have leasing for this so
that one client can acquire the lease and cache changes and when lease
is broken, this client pushes out all the changes and other client gets
the lease.

Given we don't have any lease mechanism, we probably need to define the
semantics more clearly and we should probably document it as well.

Thanks
Vivek


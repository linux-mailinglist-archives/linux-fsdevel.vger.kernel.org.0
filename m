Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 748D979E241
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Sep 2023 10:37:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238724AbjIMIhn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 13 Sep 2023 04:37:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236752AbjIMIhm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 13 Sep 2023 04:37:42 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 452CFC3
        for <linux-fsdevel@vger.kernel.org>; Wed, 13 Sep 2023 01:37:38 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 739D6C433C8;
        Wed, 13 Sep 2023 08:37:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694594257;
        bh=bUwES1xfo/p8oEGzbYIZ/Df1mz0G6XgzHsNGrUdhoCs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QUm5RjXHqajwBFsTyMfZbE/A5/10jqZqmTsGUj9i6arjNRVf49fwKsi5TETI+yOrk
         JtqtdS28cCDj65BbVvHMbm2BIHicvyyENdfKAbFDLbLAu/cejEuJaLBX/zdzTRx07W
         n/JSv7T30V2TPRE2HEE9OgwNKI/XRD5H4Vqe7oaI5EBWts2xXwLM3jo6DtvFpsiSUQ
         zdWFG1p2xQBuQBCAP+Ms9WF9gXTRRuzLl5SbVG5T5AlZN4ru656xQ8roDJobljtCOv
         u1vUL8C1cuw4SPLDyU4s3z133ARkIBMQ6XW5FLSW9ZfFbr6Y0YQK+t4OdytrJeVCB0
         wOZ/GKiP4GlCA==
Date:   Wed, 13 Sep 2023 10:37:33 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Miklos Szeredi <miklos@szeredi.hu>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Jan Kara <jack@suse.cz>
Subject: Re: [PATCH] ovl: factor out some common helpers for backing files io
Message-ID: <20230913-sticken-warnzeichen-099bceebc54d@brauner>
References: <20230912185408.3343163-1-amir73il@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230912185408.3343163-1-amir73il@gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Sep 12, 2023 at 09:54:08PM +0300, Amir Goldstein wrote:
> Overlayfs stores its files data in backing files on other filesystems.
> 
> Factor out some common helpers to perform io to backing files, that will
> later be reused by fuse passthrough code.
> 
> Suggested-by: Miklos Szeredi <miklos@szeredi.hu>
> Link: https://lore.kernel.org/r/CAJfpeguhmZbjP3JLqtUy0AdWaHOkAPWeP827BBWwRFEAUgnUcQ@mail.gmail.com
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> ---
> 
> Miklos,
> 
> This is the re-factoring that you suggested in the FUSE passthrough
> patches discussion linked above.
> 
> This patch is based on the overlayfs prep patch set I just posted [1].
> 
> Although overlayfs currently is the only user of these backing file
> helpers, I am sending this patch to a wider audience in case other
> filesystem developers want to comment on the abstraction.
> 
> We could perhaps later considering moving backing_file_open() helper
> and related code to backing_file.c.
> 
> In any case, if there are no objections, I plan to queue this work
> for 6.7 via the overlayfs tree.
> 
> Thanks,
> Amir.
> 
> [1] https://lore.kernel.org/linux-unionfs/20230912173653.3317828-1-amir73il@gmail.com/
> 
> 
>  MAINTAINERS                  |   2 +
>  fs/Kconfig                   |   4 +
>  fs/Makefile                  |   1 +
>  fs/backing_file.c            | 160 +++++++++++++++++++++++++++++++++++
>  fs/overlayfs/Kconfig         |   1 +
>  fs/overlayfs/file.c          | 137 ++----------------------------
>  fs/overlayfs/overlayfs.h     |   2 -
>  fs/overlayfs/super.c         |  11 +--
>  include/linux/backing_file.h |  22 +++++
>  9 files changed, 199 insertions(+), 141 deletions(-)
>  create mode 100644 fs/backing_file.c
>  create mode 100644 include/linux/backing_file.h
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 90f13281d297..4e1d21773e0e 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -16092,7 +16092,9 @@ L:	linux-unionfs@vger.kernel.org
>  S:	Supported
>  T:	git git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/vfs.git
>  F:	Documentation/filesystems/overlayfs.rst
> +F:	fs/backing_file.c
>  F:	fs/overlayfs/
> +F:	include/linux/backing_file.h

I'd like to do this slightly differently, please. All vfs infra goes
through vfs trees but for new infra like this where someone steps up to
be a maintainer we add a new section (like bpf or networking does):

VFS [BACKING FILE]
M:      Miklos Szeredi <miklos@szeredi.hu>
M:      Amir Goldstein <amir73il@gmail.com>
F:      fs/backing_file.c
F:      include/linux/backing_file.h
L:	linux-fsdevel@vger.kernel.org
S:	Maintained

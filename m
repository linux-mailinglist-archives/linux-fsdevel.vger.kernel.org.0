Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BF6E79E214
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Sep 2023 10:29:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238838AbjIMI31 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 13 Sep 2023 04:29:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233957AbjIMI30 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 13 Sep 2023 04:29:26 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4298A10E6
        for <linux-fsdevel@vger.kernel.org>; Wed, 13 Sep 2023 01:29:22 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 467C5C433C8;
        Wed, 13 Sep 2023 08:29:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694593761;
        bh=Emf3mPjVS8E0V1hEcyVVDKhlnHNx8Y4gVQiIyEUe+ZM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PneSVik4fo6Aj3qy5kY5edLe5eAzKpg2Vm795aS9HeFPhUE1KtJ//+Q1YvJxwqBvM
         gAcyMnq/lyniiV4GdyYc7SCs/0cpw1OKm+BzhRBGwkwIsW1khBhJ/hoGmC7lELAqXM
         AGOcnOQpZndxU+OySzbcqbockuPO2bFXhqexehX6UlgGOwpDFzB2jIjtViyftuCOuj
         w8I4QS/wPidFadDGN9Kw8XmgCJ2N5ZuTcocpwtPYkCzRRDtd/8K/XsvvIjSfmJsPyQ
         Kq8RFxDoRWjqyQALIx/pWA71GMzj45ZB1eb6cmyFD/BLW+ujCm37sxUJv0NsvCHOMq
         /V0IcL92ZKqQQ==
Date:   Wed, 13 Sep 2023 10:29:17 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Miklos Szeredi <miklos@szeredi.hu>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Jan Kara <jack@suse.cz>
Subject: Re: [PATCH] ovl: factor out some common helpers for backing files io
Message-ID: <20230913-galaxie-irrfahrt-a815cf10ebdc@brauner>
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

I'm sorry but I'm missing mountains of context.
How is that related to the backing file stuff exactly?
The backing file stuff has this unpleasant

file->f_inode == real_inode != file->f_path->dentry->d_inode

that we all agree is something we really don't like. Is FUSE trying to
do the same thing and build an read_iter/write_iter abstraction around
it? I really really hope that's not the case.

And why are we rushing this to a VFS API? This should be part of the
FUSE series that make it necessary to hoist into the VFS not in
overlayfs work that prematurely moves this into the VFS.

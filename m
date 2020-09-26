Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 007AE279A3B
	for <lists+linux-fsdevel@lfdr.de>; Sat, 26 Sep 2020 16:57:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729186AbgIZO5I (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 26 Sep 2020 10:57:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726210AbgIZO5I (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 26 Sep 2020 10:57:08 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8465AC0613CE
        for <linux-fsdevel@vger.kernel.org>; Sat, 26 Sep 2020 07:57:08 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kMBdL-006gro-5j; Sat, 26 Sep 2020 14:57:07 +0000
Date:   Sat, 26 Sep 2020 15:57:07 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 1/4] fs: remove the unused fs_lookup_param function
Message-ID: <20200926145707.GA3421308@ZenIV.linux.org.uk>
References: <20200926092051.115577-1-hch@lst.de>
 <20200926092051.115577-2-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200926092051.115577-2-hch@lst.de>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Sep 26, 2020 at 11:20:48AM +0200, Christoph Hellwig wrote:
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  Documentation/filesystems/mount_api.rst | 18 +-------
>  fs/fs_parser.c                          | 56 -------------------------
>  include/linux/fs_parser.h               |  5 ---
>  3 files changed, 2 insertions(+), 77 deletions(-)
> 
> diff --git a/Documentation/filesystems/mount_api.rst b/Documentation/filesystems/mount_api.rst
> index 29c169c68961f3..dbff847986da47 100644
> --- a/Documentation/filesystems/mount_api.rst
> +++ b/Documentation/filesystems/mount_api.rst
> @@ -254,8 +254,8 @@ manage the filesystem context.  They are as follows:
>       will have been weeded out and fc->sb_flags updated in the context.
>       Security options will also have been weeded out and fc->security updated.
>  
> -     The parameter can be parsed with fs_parse() and fs_lookup_param().  Note
> -     that the source(s) are presented as parameters named "source".
> +     The parameter can be parsed with fs_parse().  Note that the source(s) are
> +     presented as parameters named "source".

Umm...  Not sure - I'm not too fond of fs_lookup_param(), but AFAIK there are
efforts to convert more filesystems to new mount API and I don't know if any
of those are currently using it - this work has moved to individual fs trees
now, so it's hard to keep track of.

Generally I would say "if it's out of tree, it's not our problem", but the new
API is fairly recent and conversions of in-tree filesystems aree still in
progress.  And they are likely to stay in topical branches in the regular
git trees of those in-tree filesystems while they are being developed, so
right now I would rather be careful with removals in that area, short of
serious problem with the primitive itself.  Being able to make lookup_filename()
static is obviously nice, but considering the changes done later in the series...
Let's hold it back for now.

Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA5E23ED420
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Aug 2021 14:40:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231880AbhHPMk7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 16 Aug 2021 08:40:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232101AbhHPMkG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 16 Aug 2021 08:40:06 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E52BAC0613CF
        for <linux-fsdevel@vger.kernel.org>; Mon, 16 Aug 2021 05:39:18 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id u3so31518786ejz.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 16 Aug 2021 05:39:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=QsArmkC7/t2VhHzST2KPlnEJHUeQeVx1V9DgwCCi1GA=;
        b=AKrChsAzdFzVnygcARdNofVHvr9ENOyX5gt7/1LBLAT9MQNE+RXAXoCS9jqXTqrvpm
         AxFx3zWIUkrlU0YO7U0HcDiArmtKpNNYYeQ13gUWQ9V4PXNhsfCLShxqs1Iqtr7yAJ3e
         AYlcifnX2bOPwpRwsyhXcAiGEZv2H7ixOPDhw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=QsArmkC7/t2VhHzST2KPlnEJHUeQeVx1V9DgwCCi1GA=;
        b=sfxP8N8qdDoq5v9Btzdt+oDEN7hSiXe+dDdgWusBpIUY/hu/EHoGbZJheGQmaAGKFD
         Ao8/KAbRgSlHd7wIGLXqIk3Gmh5K/HdqTIf80Lgdnn58cXkvvwxxbHK6S1JYPbQhj1EN
         2mSTYw1c8OdUzjFnOghFz8TA9aAH5MSjnJV+LzeuRxLZsWEBUgR8GRHLh2jEjXoR7S2g
         buOs6VV6tIk93sL7BSZ3WbXRsvCTfoeorErnl1irl779vimLZgDYOEJDHTSgO9gxw0wx
         xrZsssg35oK0mV5lVUux285laRK483P+DENSv41LNYuKU20/ruX82F0ZqeVlZXmuGs/R
         3mYw==
X-Gm-Message-State: AOAM5314IYm8d19O9S+omhVQCQooXl4lopzIs4NdocdsIQstF1l2/y9C
        AuwaPdoGOdw7IQOSqIoEUpxXLGvAsDlTqg==
X-Google-Smtp-Source: ABdhPJzdBqIDPSW/qBehqsoOkvq5uJ2SEUzXECQyGVYwEZzSjblc3NIHX5Rcl+zQVADOfmCAmuF9xA==
X-Received: by 2002:a17:907:72ce:: with SMTP id du14mr16103629ejc.523.1629117557485;
        Mon, 16 Aug 2021 05:39:17 -0700 (PDT)
Received: from miu.piliscsaba.redhat.com (catv-86-101-169-16.catv.broadband.hu. [86.101.169.16])
        by smtp.gmail.com with ESMTPSA id ks20sm3647064ejb.101.2021.08.16.05.39.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Aug 2021 05:39:16 -0700 (PDT)
Date:   Mon, 16 Aug 2021 14:39:14 +0200
From:   Miklos Szeredi <miklos@szeredi.hu>
To:     Xie Yongji <xieyongji@bytedance.com>
Cc:     linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] fuse: Fix deadlock on open(O_TRUNC)
Message-ID: <YRpcck0FHaH+uxgp@miu.piliscsaba.redhat.com>
References: <20210813093155.45-1-xieyongji@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210813093155.45-1-xieyongji@bytedance.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Aug 13, 2021 at 05:31:55PM +0800, Xie Yongji wrote:
> The invalidate_inode_pages2() might be called with FUSE_NOWRITE
> set in fuse_finish_open(), which can lead to deadlock in
> fuse_launder_page().
> 
> To fix it, this tries to delay calling invalidate_inode_pages2()
> until FUSE_NOWRITE is removed.

Thanks for the report and the patch.  I think it doesn't make sense to delay the
invalidate_inode_pages2() call since the inode has been truncated in this case,
there's no data worth writing out.

This patch replaces the invalidate_inode_pages2() with a truncate_pagecache()
call.  This makes sense regardless of FOPEN_KEEP_CACHE or fc->writeback cache,
so do it unconditionally.

Can you please check out the following patch?

Thanks,
Miklos

---
 fs/fuse/file.c |    7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -198,12 +198,11 @@ void fuse_finish_open(struct inode *inod
 	struct fuse_file *ff = file->private_data;
 	struct fuse_conn *fc = get_fuse_conn(inode);
 
-	if (!(ff->open_flags & FOPEN_KEEP_CACHE))
-		invalidate_inode_pages2(inode->i_mapping);
 	if (ff->open_flags & FOPEN_STREAM)
 		stream_open(inode, file);
 	else if (ff->open_flags & FOPEN_NONSEEKABLE)
 		nonseekable_open(inode, file);
+
 	if (fc->atomic_o_trunc && (file->f_flags & O_TRUNC)) {
 		struct fuse_inode *fi = get_fuse_inode(inode);
 
@@ -211,10 +210,14 @@ void fuse_finish_open(struct inode *inod
 		fi->attr_version = atomic64_inc_return(&fc->attr_version);
 		i_size_write(inode, 0);
 		spin_unlock(&fi->lock);
+		truncate_pagecache(inode, 0);
 		fuse_invalidate_attr(inode);
 		if (fc->writeback_cache)
 			file_update_time(file);
+	} else if (!(ff->open_flags & FOPEN_KEEP_CACHE)) {
+		invalidate_inode_pages2(inode->i_mapping);
 	}
+
 	if ((file->f_mode & FMODE_WRITE) && fc->writeback_cache)
 		fuse_link_write_file(file);
 }

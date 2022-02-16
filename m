Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 020504B85B5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Feb 2022 11:31:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229479AbiBPK3B (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Feb 2022 05:29:01 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:60916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231144AbiBPK24 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Feb 2022 05:28:56 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24E3621EC37
        for <linux-fsdevel@vger.kernel.org>; Wed, 16 Feb 2022 02:28:31 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id q17so3119333edd.4
        for <linux-fsdevel@vger.kernel.org>; Wed, 16 Feb 2022 02:28:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=h5LMjKcr6PyqZitTAY4fxVujQ96SMEzb1ukbNS+2yqQ=;
        b=F8ZP+yWx3/Vgmx9io+r2UQbYy4b794FeDw8vT/9eSh+GVB9n4TBfBb6lKbxjKXySfZ
         6cpWpoF+fHenSWzmay83Tryjq/DtAEW4dY/GA0/b1r5wqmIZLdTElVQg/8ZLwy4Bvpox
         CjF0xb3TIlkmO4k/w1JRrOFg6KwPt1tDR1VzQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=h5LMjKcr6PyqZitTAY4fxVujQ96SMEzb1ukbNS+2yqQ=;
        b=y5kGcHLRJ8MFgcgIioMiNa8CgMQTAB1KmKA523Md/kV11AZEw4sZtR1AwNYcwUifLi
         nEJxoKMwUz33rmUknQdldrgvxl3vPw2I2F2OXTebq8+dZ9E9nrmv0suqsiLTrT2kDplb
         pFpO7qWCwAkKlAuNX1VWG8IiH4c3EZepbNPU5E+SSFbxD+uAId3KNM5TA6hBwv8WgtNa
         yUV23jKPDCHIPvos2DmDmdpL42x8bRknlE7Um4HvZvrizp+l2mgpXeIVxAcYuAmMhP5o
         Ny/5E/2v5S+6TMN+a5hCOCHzg+evBBaK5PArbcXAKsDTqIe7rGrRyNymo7nHHaQYR1dt
         QPIQ==
X-Gm-Message-State: AOAM532c7D8yhOH8ZOcfsn6WGzwAX/Iq1G8HFF+NdNs2IIYm6H3yPKWX
        ty6retY/J+3fBlJ9iXu62nGDTQ==
X-Google-Smtp-Source: ABdhPJy7Y6JBt5j2jM9BY2aJtfySo/GeQzuue2bA5X4BQ4sBhrOE0G8XQI6we7N0sLQWONlCLCFKcQ==
X-Received: by 2002:aa7:daca:0:b0:410:d02a:1bf3 with SMTP id x10-20020aa7daca000000b00410d02a1bf3mr2173399eds.455.1645007306948;
        Wed, 16 Feb 2022 02:28:26 -0800 (PST)
Received: from miu.piliscsaba.redhat.com (catv-178-48-189-3.catv.fixed.vodafone.hu. [178.48.189.3])
        by smtp.gmail.com with ESMTPSA id qo24sm3284400ejb.92.2022.02.16.02.28.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Feb 2022 02:28:25 -0800 (PST)
Date:   Wed, 16 Feb 2022 11:28:18 +0100
From:   Miklos Szeredi <miklos@szeredi.hu>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Xavier Roche <xavier.roche@algolia.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: Re: race between vfs_rename and do_linkat (mv and link)
Message-ID: <YgzRwhavapo69CAn@miu.piliscsaba.redhat.com>
References: <20220214210708.GA2167841@xavier-xps>
 <CAJfpegvVKWHhhXwOi9jDUOJi2BnYSDxZQrp1_RRrpVjjZ3Rs2w@mail.gmail.com>
 <YguspMvu6M6NJ1hL@zeniv-ca.linux.org.uk>
 <YgvPbljmJXsR7ESt@zeniv-ca.linux.org.uk>
 <YgvSB6CKAhF5IXFj@casper.infradead.org>
 <YgvS1XOJMn5CjQyw@zeniv-ca.linux.org.uk>
 <CAJfpegv03YpTPiDnLwbaewQX_KZws5nutays+vso2BVJ1v1+TA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJfpegv03YpTPiDnLwbaewQX_KZws5nutays+vso2BVJ1v1+TA@mail.gmail.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Feb 16, 2022 at 10:28:20AM +0100, Miklos Szeredi wrote:

> So this is a fairly special situation.  How about adding a new rwsem
> (could possibly be global or per-fs)?
> 
>  - acquired for read in lock_rename() before inode locks
>  - acquired for write in do_linkat before inode locks, but only on retry

Something like this:

diff --git a/fs/namei.c b/fs/namei.c
index 3f1829b3ab5b..dd6908cee49d 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -122,6 +122,8 @@
  * PATH_MAX includes the nul terminator --RR.
  */
 
+static DECLARE_RWSEM(link_rwsem);
+
 #define EMBEDDED_NAME_MAX	(PATH_MAX - offsetof(struct filename, iname))
 
 struct filename *
@@ -2961,6 +2963,8 @@ struct dentry *lock_rename(struct dentry *p1, struct dentry *p2)
 {
 	struct dentry *p;
 
+	down_read(&link_rwsem);
+
 	if (p1 == p2) {
 		inode_lock_nested(p1->d_inode, I_MUTEX_PARENT);
 		return NULL;
@@ -2995,6 +2999,8 @@ void unlock_rename(struct dentry *p1, struct dentry *p2)
 		inode_unlock(p2->d_inode);
 		mutex_unlock(&p1->d_sb->s_vfs_rename_mutex);
 	}
+
+	up_read(&link_rwsem);
 }
 EXPORT_SYMBOL(unlock_rename);
 
@@ -4456,6 +4462,7 @@ int do_linkat(int olddfd, struct filename *old, int newdfd,
 	struct path old_path, new_path;
 	struct inode *delegated_inode = NULL;
 	int how = 0;
+	bool lock = false;
 	int error;
 
 	if ((flags & ~(AT_SYMLINK_FOLLOW | AT_EMPTY_PATH)) != 0) {
@@ -4474,10 +4481,13 @@ int do_linkat(int olddfd, struct filename *old, int newdfd,
 
 	if (flags & AT_SYMLINK_FOLLOW)
 		how |= LOOKUP_FOLLOW;
+retry_lock:
+	if (lock)
+		down_write(&link_rwsem);
 retry:
 	error = filename_lookup(olddfd, old, how, &old_path, NULL);
 	if (error)
-		goto out_putnames;
+		goto out_unlock_link;
 
 	new_dentry = filename_create(newdfd, new, &new_path,
 					(how & LOOKUP_REVAL));
@@ -4511,8 +4521,16 @@ int do_linkat(int olddfd, struct filename *old, int newdfd,
 		how |= LOOKUP_REVAL;
 		goto retry;
 	}
+	if (!lock && error == -ENOENT) {
+		path_put(&old_path);
+		lock = true;
+		goto retry_lock;
+	}
 out_putpath:
 	path_put(&old_path);
+out_unlock_link:
+	if (lock)
+		up_write(&link_rwsem);
 out_putnames:
 	putname(old);
 	putname(new);

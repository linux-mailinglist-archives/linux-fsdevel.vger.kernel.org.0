Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A4EB7790AB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Aug 2023 15:22:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235504AbjHKNWA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 11 Aug 2023 09:22:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235354AbjHKNV5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 11 Aug 2023 09:21:57 -0400
Received: from out-98.mta0.migadu.com (out-98.mta0.migadu.com [91.218.175.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 021BBE4D
        for <linux-fsdevel@vger.kernel.org>; Fri, 11 Aug 2023 06:21:53 -0700 (PDT)
Date:   Fri, 11 Aug 2023 09:21:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1691760112;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5Wbq4/JJuBY4TNVGgKXukYsKEB24Q5KXW1eLJj20I7I=;
        b=dQYG5IWCByG1WgWzrltmOg1tCCB1aWWQlWqxanKrKd67iJ1HCy8YsArZt1BHMEjDHlVdzZ
        4BD1Bw7jz+1Fubhh/zQAlwpf/s5qeNDvzQU7af8kcFSLJJqVeUL7OImP7YJUjmXBGizldb
        q+FsYca8QxqrQMmX1J4Bf7B5LfZijC8=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Kent Overstreet <kent.overstreet@linux.dev>
To:     Christian Brauner <brauner@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-bcachefs@vger.kernel.org, djwong@kernel.org,
        dchinner@redhat.com, sandeen@redhat.com, willy@infradead.org,
        josef@toxicpanda.com, tytso@mit.edu, bfoster@redhat.com,
        jack@suse.cz, andreas.gruenbacher@gmail.com, peterz@infradead.org,
        akpm@linux-foundation.org, dhowells@redhat.com, snitzer@kernel.org,
        axboe@kernel.dk
Subject: Re: [GIT PULL] bcachefs
Message-ID: <20230811132141.qxppoculzs5amawn@moria.home.lan>
References: <20230626214656.hcp4puionmtoloat@moria.home.lan>
 <20230706155602.mnhsylo3pnief2of@moria.home.lan>
 <20230712025459.dbzcjtkb4zem4pdn@moria.home.lan>
 <CAHk-=whaFz0uyBB79qcEh-7q=wUOAbGHaMPofJfxGqguiKzFyQ@mail.gmail.com>
 <20230810155453.6xz2k7f632jypqyz@moria.home.lan>
 <20230811-neigt-baufinanzierung-4c9521b036c6@brauner>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230811-neigt-baufinanzierung-4c9521b036c6@brauner>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Aug 11, 2023 at 12:54:42PM +0200, Christian Brauner wrote:
> > I don't want to do that to Christian either, I think highly of the work
> > he's been doing and I don't want to be adding to his frustration. So I
> > apologize for loosing my cool earlier; a lot of that was frustration
> > from other threads spilling over.
> > 
> > But: if he's going to be raising objections, I need to know what his
> > concerns are if we're going to get anywhere. Raising objections without
> > saying what the concerns are shuts down discussion; I don't think it's
> > unreasonable to ask people not to do that, and to try and stay focused
> > on the code.
> 
> The technical aspects were made clear off-list and I believe multiple
> times on-list by now. Any VFS and block related patches are to be
> reviewed and accepted before bcachefs gets merged.

Here's the one VFS patch in the series - could we at least get an ack
for this? It's a new helper, just breaks the existing d_tmpfile() up
into two functions - I hope we can at least agree that this patch
shouldn't be controversial?

-->--
Subject: [PATCH] fs: factor out d_mark_tmpfile()

New helper for bcachefs - bcachefs doesn't want the
inode_dec_link_count() call that d_tmpfile does, it handles i_nlink on
its own atomically with other btree updates

Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org

diff --git a/fs/dcache.c b/fs/dcache.c
index 52e6d5fdab..dbdafa2617 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -3249,11 +3249,10 @@ void d_genocide(struct dentry *parent)
 
 EXPORT_SYMBOL(d_genocide);
 
-void d_tmpfile(struct file *file, struct inode *inode)
+void d_mark_tmpfile(struct file *file, struct inode *inode)
 {
 	struct dentry *dentry = file->f_path.dentry;
 
-	inode_dec_link_count(inode);
 	BUG_ON(dentry->d_name.name != dentry->d_iname ||
 		!hlist_unhashed(&dentry->d_u.d_alias) ||
 		!d_unlinked(dentry));
@@ -3263,6 +3262,15 @@ void d_tmpfile(struct file *file, struct inode *inode)
 				(unsigned long long)inode->i_ino);
 	spin_unlock(&dentry->d_lock);
 	spin_unlock(&dentry->d_parent->d_lock);
+}
+EXPORT_SYMBOL(d_mark_tmpfile);
+
+void d_tmpfile(struct file *file, struct inode *inode)
+{
+	struct dentry *dentry = file->f_path.dentry;
+
+	inode_dec_link_count(inode);
+	d_mark_tmpfile(file, inode);
 	d_instantiate(dentry, inode);
 }
 EXPORT_SYMBOL(d_tmpfile);
diff --git a/include/linux/dcache.h b/include/linux/dcache.h
index 6b351e009f..3da2f0545d 100644
--- a/include/linux/dcache.h
+++ b/include/linux/dcache.h
@@ -251,6 +251,7 @@ extern struct dentry * d_make_root(struct inode *);
 /* <clickety>-<click> the ramfs-type tree */
 extern void d_genocide(struct dentry *);
 
+extern void d_mark_tmpfile(struct file *, struct inode *);
 extern void d_tmpfile(struct file *, struct inode *);
 
 extern struct dentry *d_find_alias(struct inode *);

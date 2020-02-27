Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5D74A1728E5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Feb 2020 20:44:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730499AbgB0TnP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 Feb 2020 14:43:15 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:47542 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730433AbgB0TnP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 Feb 2020 14:43:15 -0500
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j7P3w-0021LD-Ku; Thu, 27 Feb 2020 19:43:12 +0000
Date:   Thu, 27 Feb 2020 19:43:12 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC][PATCH v2 02/34] fix automount/automount race properly
Message-ID: <20200227194312.GD23230@ZenIV.linux.org.uk>
References: <20200223011154.GY23230@ZenIV.linux.org.uk>
 <20200223011626.4103706-1-viro@ZenIV.linux.org.uk>
 <20200223011626.4103706-2-viro@ZenIV.linux.org.uk>
 <CAHk-=wjE0ey=qg2-5+OHg4kVub4x3XLnatcZj5KfU03dd8kZ0A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wjE0ey=qg2-5+OHg4kVub4x3XLnatcZj5KfU03dd8kZ0A@mail.gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Feb 22, 2020 at 06:07:39PM -0800, Linus Torvalds wrote:
> On Sat, Feb 22, 2020 at 5:16 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
> >
> > +
> > +discard2:
> > +       namespace_unlock();
> > +discard1:
> > +       inode_unlock(dentry->d_inode);
> > +discard:
> >         /* remove m from any expiration list it may be on */
> 
> Would you mind re-naming those labels?
> 
> I realize that the numbering may help show that the error handling is
> done in the reverse order, but I bet that a nice name could so that
> too.

Umm...  A bit of reordering in the beginning eliminates discard1, suggesting
s/discard2/discard_locked/...  Incremental would be

diff --git a/fs/namespace.c b/fs/namespace.c
index 6228fd1ef94f..777c3116e62e 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -2844,22 +2844,22 @@ int finish_automount(struct vfsmount *m, struct path *path)
 	 * got", not "try to mount it on top".
 	 */
 	inode_lock(dentry->d_inode);
+	namespace_lock();
 	if (unlikely(cant_mount(dentry))) {
 		err = -ENOENT;
-		goto discard1;
+		goto discard_locked;
 	}
-	namespace_lock();
 	rcu_read_lock();
 	if (unlikely(__lookup_mnt(path->mnt, dentry))) {
 		rcu_read_unlock();
 		err = 0;
-		goto discard2;
+		goto discard_locked;
 	}
 	rcu_read_unlock();
 	mp = get_mountpoint(dentry);
 	if (IS_ERR(mp)) {
 		err = PTR_ERR(mp);
-		goto discard2;
+		goto discard_locked;
 	}
 
 	err = do_add_mount(mnt, mp, path, path->mnt->mnt_flags | MNT_SHRINKABLE);
@@ -2869,9 +2869,8 @@ int finish_automount(struct vfsmount *m, struct path *path)
 	mntput(m);
 	return 0;
 
-discard2:
+discard_locked:
 	namespace_unlock();
-discard1:
 	inode_unlock(dentry->d_inode);
 discard:
 	/* remove m from any expiration list it may be on */

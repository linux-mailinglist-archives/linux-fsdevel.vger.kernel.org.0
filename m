Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F30C3580E30
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Jul 2022 09:47:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238264AbiGZHrY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 26 Jul 2022 03:47:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237783AbiGZHrX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 26 Jul 2022 03:47:23 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32DDF1FCF1
        for <linux-fsdevel@vger.kernel.org>; Tue, 26 Jul 2022 00:47:22 -0700 (PDT)
Date:   Tue, 26 Jul 2022 09:47:19 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1658821641;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=29CActygTDI8QI5QtQ/hhwNU7LvhcY+F8JPzzESKgw8=;
        b=YLELDO2aGwFJtSjl5ZkY5x4zVe5JKn/pFd53k4xW7r3sgM8r9drcrBn/PMe4injzf3Y4wH
        smDCUjvIhV9P8fbYQNwVfm5hhKD5wYHpWXPgIsuEMmoJy3gKv9UPc9xFn34kZootCccw4p
        pH8h2L6mPjDXWuTvZj0zcbu5FcDUVZHlEv/QUTmMAgiWTn8xkZmYiN2f4ayF1Y4SZSts+B
        3VRafw/gSw/eheO/i6cEDTjOOkLLJEmHxwas8jvVtNt7pOmdTPGSnv0KVnAII24haRqyCu
        YURn+NTDp/EdZ8OvQK7GMt4hLMav1wHRC6wkEw894Ze8JkqZahivMET5KAWcNA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1658821641;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=29CActygTDI8QI5QtQ/hhwNU7LvhcY+F8JPzzESKgw8=;
        b=M9ZIvGfVUJlVOj/3XascNIK9RgMbbEBdgHlt7K1fecnZDtFGa5a3rjhF5wO3wbZA7ISjB8
        af8cPP+bNsVE1yDg==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel@vger.kernel.org,
        Matthew Wilcox <willy@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH 3/4 v2] fs/dcache: Use __d_lookup_unhash() in __d_add/move()
Message-ID: <Yt+cB0SKcAu2iSf/@linutronix.de>
References: <20220613140712.77932-1-bigeasy@linutronix.de>
 <20220613140712.77932-4-bigeasy@linutronix.de>
 <Yt9Y2JhqVHOP0vRT@ZenIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <Yt9Y2JhqVHOP0vRT@ZenIV>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

__d_add() and __d_move() invoke __d_lookup_done() from within a preemption
disabled region. This violates the PREEMPT_RT constraints as the wake up
acquires wait_queue_head::lock which is a "sleeping" spinlock on RT.

As a preparation for solving this completely, invoke __d_lookup_unhash()
=66rom __d_add/move() and handle the wakeup there.

This allows to move the spin_lock/unlock(dentry::lock) pair into
__d_lookup_done() which debloats the d_lookup_done() inline. Rename
__d_lookup_done() -> __d_lookup_wake() to force build failures for OOT code
which used __d_lookup_done() and did not adapt.

No functional change. Moving the wake up out of the preemption disabled
region on RT will be handled in a subsequent change.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
v1=E2=80=A6v2:
   - Rename __d_lookup_done() -> __d_lookup_wake().

 fs/dcache.c            |   10 ++++++----
 include/linux/dcache.h |    9 +++------
 2 files changed, 9 insertions(+), 10 deletions(-)

--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -2735,11 +2735,13 @@ static wait_queue_head_t *__d_lookup_unh
 	return d_wait;
 }
=20
-void __d_lookup_done(struct dentry *dentry)
+void __d_lookup_wake(struct dentry *dentry)
 {
+	spin_lock(&dentry->d_lock);
 	wake_up_all(__d_lookup_unhash(dentry));
+	spin_unlock(&dentry->d_lock);
 }
-EXPORT_SYMBOL(__d_lookup_done);
+EXPORT_SYMBOL(__d_lookup_wake);
=20
 /* inode->i_lock held if inode is non-NULL */
=20
@@ -2751,7 +2753,7 @@ static inline void __d_add(struct dentry
 	if (unlikely(d_in_lookup(dentry))) {
 		dir =3D dentry->d_parent->d_inode;
 		n =3D start_dir_add(dir);
-		__d_lookup_done(dentry);
+		wake_up_all(__d_lookup_unhash(dentry));
 	}
 	if (inode) {
 		unsigned add_flags =3D d_flags_for_inode(inode);
@@ -2940,7 +2942,7 @@ static void __d_move(struct dentry *dent
 	if (unlikely(d_in_lookup(target))) {
 		dir =3D target->d_parent->d_inode;
 		n =3D start_dir_add(dir);
-		__d_lookup_done(target);
+		wake_up_all(__d_lookup_unhash(target));
 	}
=20
 	write_seqcount_begin(&dentry->d_seq);
--- a/include/linux/dcache.h
+++ b/include/linux/dcache.h
@@ -349,7 +349,7 @@ static inline void dont_mount(struct den
 	spin_unlock(&dentry->d_lock);
 }
=20
-extern void __d_lookup_done(struct dentry *);
+extern void __d_lookup_wake(struct dentry *dentry);
=20
 static inline int d_in_lookup(const struct dentry *dentry)
 {
@@ -358,11 +358,8 @@ static inline int d_in_lookup(const stru
=20
 static inline void d_lookup_done(struct dentry *dentry)
 {
-	if (unlikely(d_in_lookup(dentry))) {
-		spin_lock(&dentry->d_lock);
-		__d_lookup_done(dentry);
-		spin_unlock(&dentry->d_lock);
-	}
+	if (unlikely(d_in_lookup(dentry)))
+		__d_lookup_wake(dentry);
 }
=20
 extern void dput(struct dentry *);

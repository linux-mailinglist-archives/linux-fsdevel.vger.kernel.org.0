Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF261549B35
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Jun 2022 20:12:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244204AbiFMSMo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 13 Jun 2022 14:12:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244987AbiFMSMe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 13 Jun 2022 14:12:34 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AD8C939DC
        for <linux-fsdevel@vger.kernel.org>; Mon, 13 Jun 2022 07:07:19 -0700 (PDT)
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1655129237;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8xXJNt0pcED+Mh3lw0k/HQozt40Il0fk+LG9zMZD91I=;
        b=Hpj9nj5Hq0D+QXD0ult/2SCBkQ1Ye6NKl6+s6SCk0iG/Ey+OGkhDaAsNoY1LyGlUY0cleE
        p3zJmiwwilCU+bnKefc5LBQ2njcVmLupYYxhCHFK5JUiIMi68Q3YW4OO4O8EYlkIiQn0UY
        8JBMf71wd/Ww39Zqv/VumvrYlnhgQedkMGvAx8NumGeqEviYQFcT5CW0ZMmoqGka/YMFun
        KEji0sKTz/Da1i5WpOiqYVTDNeuSwYrOmJi/33H98hyCklW87ECYTKaVZx418KlQTJ479n
        yZqkQbam8D7FMG3f2BuQSuoqQPTTTDxbi8aiqIyUzi02mPq2KLpM/Wfr18w9CQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1655129237;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8xXJNt0pcED+Mh3lw0k/HQozt40Il0fk+LG9zMZD91I=;
        b=QmQ9YkpItYU6kRr5zUNcKU8kzM20n7LEz6hnx39TOboWZz5dGvhH1OxTjVsxPsOy/xVBfX
        gpKAPuCW9fHv6eAQ==
To:     linux-fsdevel@vger.kernel.org
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 3/4] fs/dcache: Use __d_lookup_unhash() in __d_add/move()
Date:   Mon, 13 Jun 2022 16:07:11 +0200
Message-Id: <20220613140712.77932-4-bigeasy@linutronix.de>
In-Reply-To: <20220613140712.77932-1-bigeasy@linutronix.de>
References: <20220613140712.77932-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

__d_add() and __d_move() invoke __d_lookup_done() from within a preemption
disabled region. This violates the PREEMPT_RT constraints as the wake up
acquires wait_queue_head::lock which is a "sleeping" spinlock on RT.

As a preparation for solving this completely, invoke __d_lookup_unhash()
from __d_add/move() and handle the wakeup there.

This allows to move the spin_lock/unlock(dentry::lock) pair into
__d_lookup_done() which debloats the d_lookup_done() inline.

No functional change. Moving the wake up out of the preemption disabled
region on RT will be handled in a subsequent change.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 fs/dcache.c            | 6 ++++--
 include/linux/dcache.h | 7 ++-----
 2 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/fs/dcache.c b/fs/dcache.c
index fae4689a9a409..6ef1f5c32bc0f 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -2737,7 +2737,9 @@ static wait_queue_head_t *__d_lookup_unhash(struct de=
ntry *dentry)
=20
 void __d_lookup_done(struct dentry *dentry)
 {
+	spin_lock(&dentry->d_lock);
 	wake_up_all(__d_lookup_unhash(dentry));
+	spin_unlock(&dentry->d_lock);
 }
 EXPORT_SYMBOL(__d_lookup_done);
=20
@@ -2751,7 +2753,7 @@ static inline void __d_add(struct dentry *dentry, str=
uct inode *inode)
 	if (unlikely(d_in_lookup(dentry))) {
 		dir =3D dentry->d_parent->d_inode;
 		n =3D start_dir_add(dir);
-		__d_lookup_done(dentry);
+		wake_up_all(__d_lookup_unhash(dentry));
 	}
 	if (inode) {
 		unsigned add_flags =3D d_flags_for_inode(inode);
@@ -2940,7 +2942,7 @@ static void __d_move(struct dentry *dentry, struct de=
ntry *target,
 	if (unlikely(d_in_lookup(target))) {
 		dir =3D target->d_parent->d_inode;
 		n =3D start_dir_add(dir);
-		__d_lookup_done(target);
+		wake_up_all(__d_lookup_unhash(target));
 	}
=20
 	write_seqcount_begin(&dentry->d_seq);
diff --git a/include/linux/dcache.h b/include/linux/dcache.h
index f5bba51480b2f..a07a51c858fb4 100644
--- a/include/linux/dcache.h
+++ b/include/linux/dcache.h
@@ -349,7 +349,7 @@ static inline void dont_mount(struct dentry *dentry)
 	spin_unlock(&dentry->d_lock);
 }
=20
-extern void __d_lookup_done(struct dentry *);
+extern void __d_lookup_done(struct dentry *dentry);
=20
 static inline int d_in_lookup(const struct dentry *dentry)
 {
@@ -358,11 +358,8 @@ static inline int d_in_lookup(const struct dentry *den=
try)
=20
 static inline void d_lookup_done(struct dentry *dentry)
 {
-	if (unlikely(d_in_lookup(dentry))) {
-		spin_lock(&dentry->d_lock);
+	if (unlikely(d_in_lookup(dentry)))
 		__d_lookup_done(dentry);
-		spin_unlock(&dentry->d_lock);
-	}
 }
=20
 extern void dput(struct dentry *);
--=20
2.36.1


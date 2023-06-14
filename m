Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8682972F7F3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jun 2023 10:34:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243564AbjFNIeg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 14 Jun 2023 04:34:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235199AbjFNIef (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 14 Jun 2023 04:34:35 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44D24199C;
        Wed, 14 Jun 2023 01:34:34 -0700 (PDT)
Date:   Wed, 14 Jun 2023 10:34:30 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1686731671;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Z9JEhE0hBbRNxo8+2E1TzVaia14Yakp3vq1MLnG86lA=;
        b=foJ+Wbj0WC+nPGHftYz9yJRHPEhztvj3Sdeps8Ljt6YHB540Vw1kBFhIjuPsL1sSWMhMQ6
        Y/TeO5Y+Jy5j/hlU4EQO9kEk2/rIhZz7ejsw452xfqxf6/W2hAUmRAPUZ7ulKOrof/kN6P
        0/PuQgNjujNzEXgSVXHgk5sqOSD/u/Y84YOMQo/6Fm/rq8KP0IyOdfHPTCTl7eXV5JnDfI
        bOCM80aWeNLjR9PplBGYenpUjKmU6qADFVlaP2eb2eobHijFLAoI+l9HQp2uXH9btudZqp
        kH0DE4lVCVJy9p9IivOh+vVfcIPe5vRzM8zQDmiQT+M1brAT6Caw28nFZVxTQQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1686731671;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Z9JEhE0hBbRNxo8+2E1TzVaia14Yakp3vq1MLnG86lA=;
        b=pkD7kUXK6OwOM9xLCsZ6ECtfUNx+zHRoZ4mXbogQRlYhTlZK/TZcLLbqnF3eGEGr7NjCQ9
        AHK4EAsrWRQY7+BA==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux-Fsdevel <linux-fsdevel@vger.kernel.org>
Subject: [PATCH v4] bpf: Remove in_atomic() from bpf_link_put().
Message-ID: <20230614083430.oENawF8f@linutronix.de>
References: <20230509132433.2FSY_6t7@linutronix.de>
 <CAEf4BzZcPKsRJDQfdVk9D1Nt6kgT4STpEUrsQ=UD3BDZnNp8eQ@mail.gmail.com>
 <CAADnVQLzZyZ+cPqBFfrqa8wtQ8ZhWvTSN6oD9z4Y2gtrfs8Vdg@mail.gmail.com>
 <CAEf4BzY-MRYnzGiZmW7AVJYgYdHW1_jOphbipRrHRTtdfq3_wQ@mail.gmail.com>
 <20230525141813.TFZLWM4M@linutronix.de>
 <CAEf4Bzaipoo6X_2Fh5WTV-m0yjP0pvhqi7-FPFtGOrSzNpdGJQ@mail.gmail.com>
 <20230526112356.fOlWmeOF@linutronix.de>
 <CAEf4Bzawgrn2DhR9uvXwFFiLR9g+j4RYC6cr3n+eRD_RoKBAJA@mail.gmail.com>
 <20230605163733.LD-UCcso@linutronix.de>
 <CAEf4BzZ=VZcLZmtRefLtRyRb7uLTb6e=RVw82rxjLNqE=8kT-w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CAEf4BzZ=VZcLZmtRefLtRyRb7uLTb6e=RVw82rxjLNqE=8kT-w@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

bpf_free_inode() is invoked as a RCU callback. Usually RCU callbacks are
invoked within softirq context. By setting rcutree.use_softirq=3D0 boot
option the RCU callbacks will be invoked in a per-CPU kthread with
bottom halves disabled which implies a RCU read section.

On PREEMPT_RT the context remains fully preemptible. The RCU read
section however does not allow schedule() invocation. The latter happens
in mutex_lock() performed by bpf_trampoline_unlink_prog() originated
=66rom bpf_link_put().

It was pointed out that the bpf_link_put() invocation should not be
delayed if originated from close(). It was also pointed out that other
invocations from within a syscall should also avoid the workqueue.
Everyone else should use workqueue by default to remain safe in the
future (while auditing the code, every caller was preemptible except for
the RCU case).

Let bpf_link_put() use the worker unconditionally. Add
bpf_link_put_direct() which will directly free the resources and is used
by close() and from within __sys_bpf().

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
v3=E2=80=A6v4:
  - Revert back to bpf_link_put_direct() to the direct free and let
    bpf_link_put() use the worker. Let close() and all invocations from
    within the syscall use bpf_link_put_direct() which are all instances
    within syscall.c here.

v2=E2=80=A6v3:
  - Drop bpf_link_put_direct(). Let bpf_link_put() do the direct free
    and add bpf_link_put_from_atomic() to do the delayed free via the
    worker.

v1=E2=80=A6v2:
   - Add bpf_link_put_direct() to be used from bpf_link_release() as
     suggested.

 kernel/bpf/syscall.c | 29 ++++++++++++++++-------------
 1 file changed, 16 insertions(+), 13 deletions(-)

diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 14f39c1e573ee..8f09aef5949d4 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -2777,28 +2777,31 @@ static void bpf_link_put_deferred(struct work_struc=
t *work)
 	bpf_link_free(link);
 }
=20
-/* bpf_link_put can be called from atomic context, but ensures that resour=
ces
- * are freed from process context
+/* bpf_link_put might be called from atomic context. It needs to be called
+ * from sleepable context in order to acquire sleeping locks during the pr=
ocess.
  */
 void bpf_link_put(struct bpf_link *link)
 {
 	if (!atomic64_dec_and_test(&link->refcnt))
 		return;
=20
-	if (in_atomic()) {
-		INIT_WORK(&link->work, bpf_link_put_deferred);
-		schedule_work(&link->work);
-	} else {
-		bpf_link_free(link);
-	}
+	INIT_WORK(&link->work, bpf_link_put_deferred);
+	schedule_work(&link->work);
 }
 EXPORT_SYMBOL(bpf_link_put);
=20
+static void bpf_link_put_direct(struct bpf_link *link)
+{
+	if (!atomic64_dec_and_test(&link->refcnt))
+		return;
+	bpf_link_free(link);
+}
+
 static int bpf_link_release(struct inode *inode, struct file *filp)
 {
 	struct bpf_link *link =3D filp->private_data;
=20
-	bpf_link_put(link);
+	bpf_link_put_direct(link);
 	return 0;
 }
=20
@@ -4764,7 +4767,7 @@ static int link_update(union bpf_attr *attr)
 	if (ret)
 		bpf_prog_put(new_prog);
 out_put_link:
-	bpf_link_put(link);
+	bpf_link_put_direct(link);
 	return ret;
 }
=20
@@ -4787,7 +4790,7 @@ static int link_detach(union bpf_attr *attr)
 	else
 		ret =3D -EOPNOTSUPP;
=20
-	bpf_link_put(link);
+	bpf_link_put_direct(link);
 	return ret;
 }
=20
@@ -4857,7 +4860,7 @@ static int bpf_link_get_fd_by_id(const union bpf_attr=
 *attr)
=20
 	fd =3D bpf_link_new_fd(link);
 	if (fd < 0)
-		bpf_link_put(link);
+		bpf_link_put_direct(link);
=20
 	return fd;
 }
@@ -4934,7 +4937,7 @@ static int bpf_iter_create(union bpf_attr *attr)
 		return PTR_ERR(link);
=20
 	err =3D bpf_iter_new_fd(link);
-	bpf_link_put(link);
+	bpf_link_put_direct(link);
=20
 	return err;
 }
--=20
2.40.1


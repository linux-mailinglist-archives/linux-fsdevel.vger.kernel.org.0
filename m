Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1AC5626912
	for <lists+linux-fsdevel@lfdr.de>; Sat, 12 Nov 2022 12:17:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234825AbiKLLRf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 12 Nov 2022 06:17:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233681AbiKLLR3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 12 Nov 2022 06:17:29 -0500
Received: from sender-of-o50.zoho.in (sender-of-o50.zoho.in [103.117.158.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE9F31F9DD;
        Sat, 12 Nov 2022 03:17:26 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1668249073; cv=none; 
        d=zohomail.in; s=zohoarc; 
        b=WvjIxDY9DG6YuzcAwCxhgC+1QeN+Or0Glx//RDKFYJtEKRoUf7s8ly6xpRvOkbm4JCKwyvfi36jQ9RxZGpsamB1ePt4gIVxsbGfTg3Yzoa9Vsl5IVaZjroRHh4b8gNZ6DiQDkakwI4asbsZtm2Tcgaf65o+nt1ADLspU7xnX8aQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.in; s=zohoarc; 
        t=1668249073; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=CciC0JA+1Sl6P741HLOLO7oPE18KzPzTWUnJ9g4NcCY=; 
        b=degMBSnd9mGkKSPgdaapCdnzUPijGJ/a4MH85DcCllqX8o8cQ7EUSMFVg9m+rqFcL741P6czQkys9PXclLmJvjWnjpb4YTFGsJsBqMm3Cjy6FVgykzkQGl+i+APFF6LZHe8Frz9chLNlQlV4aSdB1t9LIhn4igYi90O7buSdj6s=
ARC-Authentication-Results: i=1; mx.zohomail.in;
        dkim=pass  header.i=siddh.me;
        spf=pass  smtp.mailfrom=code@siddh.me;
        dmarc=pass header.from=<code@siddh.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1668249073;
        s=zmail; d=siddh.me; i=code@siddh.me;
        h=From:From:To:To:Cc:Cc:Message-ID:Subject:Subject:Date:Date:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Content-Type:Message-Id:Reply-To;
        bh=CciC0JA+1Sl6P741HLOLO7oPE18KzPzTWUnJ9g4NcCY=;
        b=KeYri2bDEYsjQ5ROrUNLIT/BtrfEBjYg5D/Aot2N09fxzzzUpkethOo9sk1RFEvl
        y3KvB3tbeR+0Q8wdSe5EcX2+0D5TxFJX4wsOz0MK6aAPHU8MS/tJzI5zx9afafbQBfw
        hI5vrRMIzBt/na673W7ByHSPaQoNAXhD6lCgS4hg=
Received: from kampyooter.. (110.226.30.173 [110.226.30.173]) by mx.zoho.in
        with SMTPS id 1668249072566411.90214034857365; Sat, 12 Nov 2022 16:01:12 +0530 (IST)
From:   Siddh Raman Pant <code@siddh.me>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        David Howells <dhowells@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Eric Dumazet <edumazet@google.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Eric Biggers <ebiggers@kernel.org>
Cc:     keyrings <keyrings@vger.kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <21ea7a96018db8f140d7c68ca75665064361ad1b.1668248462.git.code@siddh.me>
Subject: [RESEND PATCH v2 2/2] kernel/watch_queue: NULL the dangling *pipe, and use it for clear check
Date:   Sat, 12 Nov 2022 16:00:41 +0530
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1668248462.git.code@siddh.me>
References: <cover.1668248462.git.code@siddh.me>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-ZohoMailClient: External
Content-Type: text/plain; charset=utf8
X-Spam-Status: No, score=-0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLACK autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

NULL the dangling pipe reference while clearing watch_queue.

If not done, a reference to a freed pipe remains in the watch_queue,
as this function is called before freeing a pipe in free_pipe_info()
(see line 834 of fs/pipe.c).

The sole use of wqueue->defunct is for checking if the watch queue has
been cleared, but wqueue->pipe is also NULLed while clearing.

Thus, wqueue->defunct is superfluous, as wqueue->pipe can be checked
for NULL. Hence, the former can be removed.

Signed-off-by: Siddh Raman Pant <code@siddh.me>
---
 include/linux/watch_queue.h |  4 +---
 kernel/watch_queue.c        | 12 ++++++------
 2 files changed, 7 insertions(+), 9 deletions(-)

diff --git a/include/linux/watch_queue.h b/include/linux/watch_queue.h
index 7f8b1f15634b..d72ad82a4435 100644
--- a/include/linux/watch_queue.h
+++ b/include/linux/watch_queue.h
@@ -55,7 +55,7 @@ struct watch_filter {
  *
  * @rcu: RCU head
  * @filter: Filter to use on watches
- * @pipe: The pipe we're using as a buffer
+ * @pipe: The pipe we're using as a buffer, NULL when queue is cleared/clo=
sed
  * @watches: Contributory watches
  * @notes: Preallocated notifications
  * @notes_bitmap: Allocation bitmap for notes
@@ -63,7 +63,6 @@ struct watch_filter {
  * @lock: To serialize accesses and removes
  * @nr_notes: Number of notes
  * @nr_pages: Number of pages in notes[]
- * @defunct: True when queues closed
  */
 struct watch_queue {
 =09struct rcu_head=09=09rcu;
@@ -76,7 +75,6 @@ struct watch_queue {
 =09spinlock_t=09=09lock;
 =09unsigned int=09=09nr_notes;
 =09unsigned int=09=09nr_pages;
-=09bool=09=09=09defunct;
 };
=20
 /**
diff --git a/kernel/watch_queue.c b/kernel/watch_queue.c
index a6f9bdd956c3..a70ddfd622ee 100644
--- a/kernel/watch_queue.c
+++ b/kernel/watch_queue.c
@@ -43,7 +43,7 @@ MODULE_LICENSE("GPL");
 static inline bool lock_wqueue(struct watch_queue *wqueue)
 {
 =09spin_lock_bh(&wqueue->lock);
-=09if (unlikely(wqueue->defunct)) {
+=09if (unlikely(!wqueue->pipe)) {
 =09=09spin_unlock_bh(&wqueue->lock);
 =09=09return false;
 =09}
@@ -105,9 +105,6 @@ static bool post_one_notification(struct watch_queue *w=
queue,
 =09unsigned int head, tail, mask, note, offset, len;
 =09bool done =3D false;
=20
-=09if (!pipe)
-=09=09return false;
-
 =09spin_lock_irq(&pipe->rd_wait.lock);
=20
 =09mask =3D pipe->ring_size - 1;
@@ -603,8 +600,11 @@ void watch_queue_clear(struct watch_queue *wqueue)
 =09rcu_read_lock();
 =09spin_lock_bh(&wqueue->lock);
=20
-=09/* Prevent new notifications from being stored. */
-=09wqueue->defunct =3D true;
+=09/*
+=09 * This pipe will get freed by the caller free_pipe_info().
+=09 * Removing this reference also prevents new notifications.
+=09 */
+=09wqueue->pipe =3D NULL;
=20
 =09while (!hlist_empty(&wqueue->watches)) {
 =09=09watch =3D hlist_entry(wqueue->watches.first, struct watch, queue_nod=
e);
--=20
2.35.1



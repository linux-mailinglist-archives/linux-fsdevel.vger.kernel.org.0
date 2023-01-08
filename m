Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C93866148A
	for <lists+linux-fsdevel@lfdr.de>; Sun,  8 Jan 2023 11:37:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232934AbjAHKhf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 8 Jan 2023 05:37:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229716AbjAHKhe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 8 Jan 2023 05:37:34 -0500
Received: from sender-of-o50.zoho.in (sender-of-o50.zoho.in [103.117.158.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93F35E0BA;
        Sun,  8 Jan 2023 02:37:30 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1673174207; cv=none; 
        d=zohomail.in; s=zohoarc; 
        b=QbZrTUpSmkOYv7vjHClErIi+mibauz+HcRYC/sNwC102L6vBR7Iq5X2+77N6rRkPvB9Coo03qoiNIYbgZUvLdPOF24KFsZuqWfOthzPU+omDMpzRmJQjugzGc4uGa7B9WDTY8pBJ7Yc4Q7o2yrg1+u+8QZP0YfiQAmHEXXpTyCY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.in; s=zohoarc; 
        t=1673174207; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=+jigenlUh+9Y3CbE3GiZGHYIBoFAXIN6GyyVO/YTVrc=; 
        b=V0vjWOsbpi5xmCzh2i6OxFh14YCdxkOx6qNi/ktu59JzvmPve0VdmxVJjolIhX0n69W9NTXm+GfANKvnAfb1MJ7UZxvPgr08ij01bpOjFg5qcCMHFffrmWPB1KjjpNllx4XHzl9uMpRFSdJ7fS1RTMKkBZ975s5zZsVpeywC2ZQ=
ARC-Authentication-Results: i=1; mx.zohomail.in;
        dkim=pass  header.i=siddh.me;
        spf=pass  smtp.mailfrom=code@siddh.me;
        dmarc=pass header.from=<code@siddh.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1673174207;
        s=zmail; d=siddh.me; i=code@siddh.me;
        h=From:From:To:To:Cc:Cc:Message-ID:Subject:Subject:Date:Date:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Content-Type:Message-Id:Reply-To;
        bh=+jigenlUh+9Y3CbE3GiZGHYIBoFAXIN6GyyVO/YTVrc=;
        b=hwfg/lH5Z7JO4CQq4K81aOEinouUIe9huOOIGpGNr62JtVh8nPKB+ZslVGThEjoJ
        4RlZsaGGB5zQe2tZPxerFxq8bgwzOIrkxA669FZU8CPV/GSVQG8LEpubq8OPwcl17ei
        K1IcSijCT/hmSwzW6UFvfWumU/NbFH0YJgWHhNxU=
Received: from kampyooter.. (110.226.31.37 [110.226.31.37]) by mx.zoho.in
        with SMTPS id 167317420635758.71149531098649; Sun, 8 Jan 2023 16:06:46 +0530 (IST)
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
Message-ID: <f2eb717a205279633ca75b4d9790ad3eb5084a70.1673173920.git.code@siddh.me>
Subject: [PATCH v3 2/2] kernel/watch_queue: NULL the dangling *pipe, and use it for clear check
Date:   Sun,  8 Jan 2023 16:06:32 +0530
X-Mailer: git-send-email 2.39.0
In-Reply-To: <cover.1673173920.git.code@siddh.me>
References: <cover.1673173920.git.code@siddh.me>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-ZohoMailClient: External
Content-Type: text/plain; charset=utf8
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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
index 7f6eea4a33a6..63592c597ec9 100644
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
index a6f9bdd956c3..6ead921c15c0 100644
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
+=09 * This pipe can be freed by callers like free_pipe_info().
+=09 * Removing this reference also prevents new notifications.
+=09 */
+=09wqueue->pipe =3D NULL;
=20
 =09while (!hlist_empty(&wqueue->watches)) {
 =09=09watch =3D hlist_entry(wqueue->watches.first, struct watch, queue_nod=
e);
--=20
2.39.0



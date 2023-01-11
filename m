Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88DD366605C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Jan 2023 17:25:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239411AbjAKQZ3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 11 Jan 2023 11:25:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239322AbjAKQYp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 11 Jan 2023 11:24:45 -0500
Received: from sender-of-o50.zoho.in (sender-of-o50.zoho.in [103.117.158.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90A651EAE9;
        Wed, 11 Jan 2023 08:21:30 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1673453996; cv=none; 
        d=zohomail.in; s=zohoarc; 
        b=KM/fWr6Ijp70rtm8BZuHp4yu61t3UXAW5rtoQ6TXGcicAfJmHGPfWLKr1gytRoSKd8RkFFo9uEWR22Bhfm+UxDGANxl6JOGr27UdMYWvtgvWRjZn0e7X72aX4eom3nwSbyezPydcXNa3LtLcjuu9FZETcZ+zXvJiBfS3gVXmwuE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.in; s=zohoarc; 
        t=1673453996; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:MIME-Version:Message-ID:Subject:To; 
        bh=tiQTww6+qZYfimr4KPwcIb2tftIxWwGfB8Hm6/Cz1yE=; 
        b=Fq+x9KElNqehQrZGMJw69xRwsNuD311UXDJ9bkbqSa49Bhruze+kkmiUVsKvwD0MYpJxcxnuZQoWSdo5pOEFSVwCOtmizn5s1NDPOCoUnWC+xVrCDz+WuttE3C+jQ8skTtcdChEr18E5eOBBt1SAy3lJj0kbdE6Wy26FyhuRUm8=
ARC-Authentication-Results: i=1; mx.zohomail.in;
        dkim=pass  header.i=siddh.me;
        spf=pass  smtp.mailfrom=code@siddh.me;
        dmarc=pass header.from=<code@siddh.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1673453996;
        s=zmail; d=siddh.me; i=code@siddh.me;
        h=From:From:To:To:Cc:Cc:Message-ID:Subject:Subject:Date:Date:MIME-Version:Content-Transfer-Encoding:Content-Type:Message-Id:Reply-To;
        bh=tiQTww6+qZYfimr4KPwcIb2tftIxWwGfB8Hm6/Cz1yE=;
        b=pJbSoUWrTmpTUzq+rwtrHjuujzN9fCIUXl8zqM90VORnwxTSqUNH2Y8uBmVdrB6d
        FaXexjLpbLxFRqnpKv2UdSOXAXBttTZFkOYbK9be51q77qMETJEozSPKPRivgHFS1W0
        uTEWfkwldcnnTZE2KKgrPNhADs6Zejk/R3ut48Vs=
Received: from kampyooter.. (110.226.31.37 [110.226.31.37]) by mx.zoho.in
        with SMTPS id 1673453995499381.7961469408317; Wed, 11 Jan 2023 21:49:55 +0530 (IST)
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
Message-ID: <20230111161934.336743-1-code@siddh.me>
Subject: [PATCH v4] kernel/watch_queue: NULL the dangling *pipe, and use it for clear check
Date:   Wed, 11 Jan 2023 21:49:34 +0530
X-Mailer: git-send-email 2.39.0
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
Changes in v4:
- Drop preceeding kerneldoc-changes patch and change appropriately.

Changes in v3 (8 Jan 2023):
- Minor rephrase of comment before NULLing in watch_queue_clear().

Changes in v2 (6 Aug 2022):
- Merged the NULLing and removing defunct patches.
- Removed READ_ONCE barrier in lock_wqueue().
- Better commit messages.

 include/linux/watch_queue.h |  3 +--
 kernel/watch_queue.c        | 12 ++++++------
 2 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/include/linux/watch_queue.h b/include/linux/watch_queue.h
index fc6bba20273b..45cd42f55d49 100644
--- a/include/linux/watch_queue.h
+++ b/include/linux/watch_queue.h
@@ -38,7 +38,7 @@ struct watch_filter {
 struct watch_queue {
 =09struct rcu_head=09=09rcu;
 =09struct watch_filter __rcu *filter;
-=09struct pipe_inode_info=09*pipe;=09=09/* The pipe we're using as a buffe=
r */
+=09struct pipe_inode_info=09*pipe;=09=09/* Pipe we use as a buffer, NULL i=
f queue closed */
 =09struct hlist_head=09watches;=09/* Contributory watches */
 =09struct page=09=09**notes;=09/* Preallocated notifications */
 =09unsigned long=09=09*notes_bitmap;=09/* Allocation bitmap for notes */
@@ -46,7 +46,6 @@ struct watch_queue {
 =09spinlock_t=09=09lock;
 =09unsigned int=09=09nr_notes;=09/* Number of notes */
 =09unsigned int=09=09nr_pages;=09/* Number of pages in notes[] */
-=09bool=09=09=09defunct;=09/* T when queues closed */
 };
=20
 /*
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



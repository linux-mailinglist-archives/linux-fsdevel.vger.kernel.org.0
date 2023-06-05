Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CA9D7229D2
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Jun 2023 16:52:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234622AbjFEOwm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 5 Jun 2023 10:52:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234650AbjFEOwb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 5 Jun 2023 10:52:31 -0400
X-Greylist: delayed 916 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 05 Jun 2023 07:52:24 PDT
Received: from sender-of-o51.zoho.in (sender-of-o51.zoho.in [103.117.158.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42327F2
        for <linux-fsdevel@vger.kernel.org>; Mon,  5 Jun 2023 07:52:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1685975788; cv=none; 
        d=zohomail.in; s=zohoarc; 
        b=I/MNviWllcoNociBuVMUjvf/4cmNOBv9CinXXyuEx+o6nHyIiQ8Py93j7m8Kxh3cWZjebJEB7xL3kxliRbd9aZzuWq/DKZArO+Az5y4lKHHXQy0ZHS+glVJ0Q2dPlkq+d20FgEvB/tXhWJQKfjxZP/SfdRoB6XHIHgtohJqyq6w=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.in; s=zohoarc; 
        t=1685975788; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:MIME-Version:Message-ID:Subject:To; 
        bh=G+0R5+PtzmbZTJMOunHX+jthOd0HYHJjkvOrxJuEthU=; 
        b=Kmk8/MmpJEkq7zU+IzPdRlBCfPT++h6bCISBTviNggIch3cqZ6QnD96dR+hcwlQKOydFc7n7hvxsFOPrx7oOHD22RzOMuxmHuruexKMPOuh9/X9smyhciEwC34mUx56PgKYEuf6g0QNHBkcBygLEzT6S75Yz91QUkmEYwKBay3w=
ARC-Authentication-Results: i=1; mx.zohomail.in;
        dkim=pass  header.i=siddh.me;
        spf=pass  smtp.mailfrom=code@siddh.me;
        dmarc=pass header.from=<code@siddh.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1685975788;
        s=zmail; d=siddh.me; i=code@siddh.me;
        h=From:From:To:To:Cc:Cc:Message-ID:Subject:Subject:Date:Date:MIME-Version:Content-Transfer-Encoding:Content-Type:Message-Id:Reply-To;
        bh=G+0R5+PtzmbZTJMOunHX+jthOd0HYHJjkvOrxJuEthU=;
        b=fxlRRdswQBmxRF8xMd/GGaY3HureaR+7e07JxHb2WC5TrZubv6SIm3gcLB56JTeY
        PUEWzqkhLbkcGl9Tz/O5XsHMf4vhgwMrGFpx2usInVRDbmol16aCi+qkdUokSWcYDcy
        vE3Qar9kp9n9+JF05paK312kGguNAXwsd4X66YiI=
Received: from kampyooter.. (223.236.126.120 [223.236.126.120]) by mx.zoho.in
        with SMTPS id 16859757868871021.8385417806124; Mon, 5 Jun 2023 20:06:26 +0530 (IST)
From:   Siddh Raman Pant <code@siddh.me>
To:     David Howells <dhowells@redhat.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        David Disseldorp <ddiss@suse.de>,
        Nick Alcock <nick.alcock@oracle.com>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        stable@vger.kernel.org
Message-ID: <20230605143616.640517-1-code@siddh.me>
Subject: [PATCH v5] kernel/watch_queue: NULL the dangling *pipe, and use it for clear check
Date:   Mon,  5 Jun 2023 20:06:16 +0530
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-ZohoMailClient: External
Content-Type: text/plain; charset=utf8
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
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

Tested with keyutils testsuite.

Cc: stable@vger.kernel.org # 6.1
Signed-off-by: Siddh Raman Pant <code@siddh.me>
---
Changes in v5:
- Rebased to latest mainline.
- Added Cc to stable.
- Specify tests passing. Note that all tests in the keyutils testsuite
  passed, except tests/features/builtin_trusted, which we should not
  worry about as it requires some kernel preparation according to
  David Howells in v4 discussion.

Changes in v4 (11 Jan 2023):
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
index e91cb4c2833f..d0b6b390ee42 100644
--- a/kernel/watch_queue.c
+++ b/kernel/watch_queue.c
@@ -42,7 +42,7 @@ MODULE_AUTHOR("Red Hat, Inc.");
 static inline bool lock_wqueue(struct watch_queue *wqueue)
 {
 =09spin_lock_bh(&wqueue->lock);
-=09if (unlikely(wqueue->defunct)) {
+=09if (unlikely(!wqueue->pipe)) {
 =09=09spin_unlock_bh(&wqueue->lock);
 =09=09return false;
 =09}
@@ -104,9 +104,6 @@ static bool post_one_notification(struct watch_queue *w=
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
2.39.2



Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 59084F9533
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Nov 2019 17:10:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726980AbfKLQJ7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 12 Nov 2019 11:09:59 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:39501 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726718AbfKLQJ7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 12 Nov 2019 11:09:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1573574997;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=c7nS+L24X7lJanaYypJtlLKF8SsjhTn6uG0Gv83hCho=;
        b=CeznGhR3QdoOSunpOrNHq6iCY78/uMTWgX/x2qEejCR559thpdbI5IIOpIx/T7saCLtYsA
        bGs4jA7kJ+8Jy6bX+PfC0jcBUKGFe/LCY9kKTD1lq14f1CJRQsA/kvovVQq0R6QTUzqNH6
        60OOvJ5s9QhcFCkQbyGTxWRIlMKNBtg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-429-Iv-B_fuvOduL8bLkc3OrQg-1; Tue, 12 Nov 2019 11:09:56 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BA81FDC54;
        Tue, 12 Nov 2019 16:09:54 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (file01.intranet.prod.int.rdu2.redhat.com [10.11.5.7])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 39F9C816E;
        Tue, 12 Nov 2019 16:09:52 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (localhost [127.0.0.1])
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4) with ESMTP id xACG9pOd017623;
        Tue, 12 Nov 2019 11:09:51 -0500
Received: from localhost (mpatocka@localhost)
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4/Submit) with ESMTP id xACG9pJr017619;
        Tue, 12 Nov 2019 11:09:51 -0500
X-Authentication-Warning: file01.intranet.prod.int.rdu2.redhat.com: mpatocka owned process doing -bs
Date:   Tue, 12 Nov 2019 11:09:51 -0500 (EST)
From:   Mikulas Patocka <mpatocka@redhat.com>
X-X-Sender: mpatocka@file01.intranet.prod.int.rdu2.redhat.com
To:     Mike Snitzer <msnitzer@redhat.com>
cc:     Nikos Tsironis <ntsironis@arrikto.com>,
        Scott Wood <swood@redhat.com>,
        Ilias Tsitsimpis <iliastsi@arrikto.com>, dm-devel@redhat.com,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Daniel Wagner <dwagner@suse.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-rt-users@vger.kernel.org, tglx@linutronix.de
Subject: [PATCH RT 1/2 v2] dm-snapshot: fix crash with the realtime kernel
Message-ID: <alpine.LRH.2.02.1911121057490.12815@file01.intranet.prod.int.rdu2.redhat.com>
User-Agent: Alpine 2.02 (LRH 1266 2009-07-14)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: Iv-B_fuvOduL8bLkc3OrQg-1
X-Mimecast-Spam-Score: 0
Content-Type: TEXT/PLAIN; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Snapshot doesn't work with realtime kernels since the commit f79ae415b64c.
hlist_bl is implemented as a raw spinlock and the code takes two non-raw
spinlocks while holding hlist_bl (non-raw spinlocks are blocking mutexes
in the realtime kernel).

We can't change hlist_bl to use non-raw spinlocks, this triggers warnings=
=20
in dentry lookup code, because the dentry lookup code uses hlist_bl while=
=20
holding a seqlock.

This patch fixes the problem by using non-raw spinlock=20
exception_table_lock instead of the hlist_bl lock.

Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
Fixes: f79ae415b64c ("dm snapshot: Make exception tables scalable")

---
 drivers/md/dm-snap.c |   23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

Index: linux-2.6/drivers/md/dm-snap.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.orig/drivers/md/dm-snap.c=092019-11-12 16:44:36.000000000 +01=
00
+++ linux-2.6/drivers/md/dm-snap.c=092019-11-12 17:01:46.000000000 +0100
@@ -141,6 +141,10 @@ struct dm_snapshot {
 =09 * for them to be committed.
 =09 */
 =09struct bio_list bios_queued_during_merge;
+
+#ifdef CONFIG_PREEMPT_RT_BASE
+=09spinlock_t exception_table_lock;
+#endif
 };
=20
 /*
@@ -625,30 +629,46 @@ static uint32_t exception_hash(struct dm
=20
 /* Lock to protect access to the completed and pending exception hash tabl=
es. */
 struct dm_exception_table_lock {
+#ifndef CONFIG_PREEMPT_RT_BASE
 =09struct hlist_bl_head *complete_slot;
 =09struct hlist_bl_head *pending_slot;
+#else
+=09spinlock_t *lock;
+#endif
 };
=20
 static void dm_exception_table_lock_init(struct dm_snapshot *s, chunk_t ch=
unk,
 =09=09=09=09=09 struct dm_exception_table_lock *lock)
 {
+#ifndef CONFIG_PREEMPT_RT_BASE
 =09struct dm_exception_table *complete =3D &s->complete;
 =09struct dm_exception_table *pending =3D &s->pending;
=20
 =09lock->complete_slot =3D &complete->table[exception_hash(complete, chunk=
)];
 =09lock->pending_slot =3D &pending->table[exception_hash(pending, chunk)];
+#else
+=09lock->lock =3D &s->exception_table_lock;
+#endif
 }
=20
 static void dm_exception_table_lock(struct dm_exception_table_lock *lock)
 {
+#ifndef CONFIG_PREEMPT_RT_BASE
 =09hlist_bl_lock(lock->complete_slot);
 =09hlist_bl_lock(lock->pending_slot);
+#else
+=09spin_lock(lock->lock);
+#endif
 }
=20
 static void dm_exception_table_unlock(struct dm_exception_table_lock *lock=
)
 {
+#ifndef CONFIG_PREEMPT_RT_BASE
 =09hlist_bl_unlock(lock->pending_slot);
 =09hlist_bl_unlock(lock->complete_slot);
+#else
+=09spin_unlock(lock->lock);
+#endif
 }
=20
 static int dm_exception_table_init(struct dm_exception_table *et,
@@ -1318,6 +1338,9 @@ static int snapshot_ctr(struct dm_target
 =09s->first_merging_chunk =3D 0;
 =09s->num_merging_chunks =3D 0;
 =09bio_list_init(&s->bios_queued_during_merge);
+#ifdef CONFIG_PREEMPT_RT_BASE
+=09spin_lock_init(&s->exception_table_lock);
+#endif
=20
 =09/* Allocate hash table for COW data */
 =09if (init_hash_tables(s)) {


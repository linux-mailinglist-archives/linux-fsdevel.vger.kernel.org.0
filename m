Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A07D9F9556
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Nov 2019 17:16:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727010AbfKLQQi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 12 Nov 2019 11:16:38 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:29271 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726799AbfKLQQi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 12 Nov 2019 11:16:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1573575397;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=til87Hw17HKI7TEgbgUhu2Gk+tx9OhdI8SUQLLm8NMQ=;
        b=NVDLY1pr5WvoG6V3EzQCkt+FfuHpvmiRqWQjDz6kM2+2zucg0MaJJhLJeXmMzXrVXaju/n
        1kyTZQ+LWRgAlRlIxgAGEZ3oYD9aTmm7mMjfS02rlFCcTB+QyqfDmX01ujwUvNIzXvaHCx
        khnmAQXluUzSOhJhYmdaAnHl8eE9bw8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-291-4pd-lHFHON-uapLGkhrGKQ-1; Tue, 12 Nov 2019 11:16:34 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D1FE91800D63;
        Tue, 12 Nov 2019 16:16:32 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (file01.intranet.prod.int.rdu2.redhat.com [10.11.5.7])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 1EA7E67E40;
        Tue, 12 Nov 2019 16:16:30 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (localhost [127.0.0.1])
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4) with ESMTP id xACGGTZK018091;
        Tue, 12 Nov 2019 11:16:29 -0500
Received: from localhost (mpatocka@localhost)
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4/Submit) with ESMTP id xACGGTeA018087;
        Tue, 12 Nov 2019 11:16:29 -0500
X-Authentication-Warning: file01.intranet.prod.int.rdu2.redhat.com: mpatocka owned process doing -bs
Date:   Tue, 12 Nov 2019 11:16:29 -0500 (EST)
From:   Mikulas Patocka <mpatocka@redhat.com>
X-X-Sender: mpatocka@file01.intranet.prod.int.rdu2.redhat.com
To:     tglx@linutronix.de, linux-rt-users@vger.kernel.org
cc:     Mike Snitzer <msnitzer@redhat.com>,
        Nikos Tsironis <ntsironis@arrikto.com>,
        Scott Wood <swood@redhat.com>,
        Ilias Tsitsimpis <iliastsi@arrikto.com>, dm-devel@redhat.com,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Daniel Wagner <dwagner@suse.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH RT 2/2 v2] list_bl: avoid BUG when the list is not locked
Message-ID: <alpine.LRH.2.02.1911121110430.12815@file01.intranet.prod.int.rdu2.redhat.com>
User-Agent: Alpine 2.02 (LRH 1266 2009-07-14)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: 4pd-lHFHON-uapLGkhrGKQ-1
X-Mimecast-Spam-Score: 0
Content-Type: TEXT/PLAIN; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

list_bl would crash with BUG() if we used it without locking. dm-snapshot=
=20
uses its own locking on realtime kernels (it can't use list_bl because=20
list_bl uses raw spinlock and dm-snapshot takes other non-raw spinlocks=20
while holding bl_lock).

To avoid this BUG, we must set LIST_BL_LOCKMASK =3D 0.

This patch is intended only for the realtime kernel patchset, not for the=
=20
upstream kernel.

Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>

Index: linux-rt-devel/include/linux/list_bl.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-rt-devel.orig/include/linux/list_bl.h=092019-11-07 14:01:51.00000=
0000 +0100
+++ linux-rt-devel/include/linux/list_bl.h=092019-11-08 10:12:49.000000000 =
+0100
@@ -19,7 +19,7 @@
  * some fast and compact auxiliary data.
  */
=20
-#if defined(CONFIG_SMP) || defined(CONFIG_DEBUG_SPINLOCK)
+#if (defined(CONFIG_SMP) || defined(CONFIG_DEBUG_SPINLOCK)) && !defined(CO=
NFIG_PREEMPT_RT_BASE)
 #define LIST_BL_LOCKMASK=091UL
 #else
 #define LIST_BL_LOCKMASK=090UL
@@ -161,9 +161,6 @@ static inline void hlist_bl_lock(struct
 =09bit_spin_lock(0, (unsigned long *)b);
 #else
 =09raw_spin_lock(&b->lock);
-#if defined(CONFIG_SMP) || defined(CONFIG_DEBUG_SPINLOCK)
-=09__set_bit(0, (unsigned long *)b);
-#endif
 #endif
 }
=20
@@ -172,9 +169,6 @@ static inline void hlist_bl_unlock(struc
 #ifndef CONFIG_PREEMPT_RT_BASE
 =09__bit_spin_unlock(0, (unsigned long *)b);
 #else
-#if defined(CONFIG_SMP) || defined(CONFIG_DEBUG_SPINLOCK)
-=09__clear_bit(0, (unsigned long *)b);
-#endif
 =09raw_spin_unlock(&b->lock);
 #endif
 }


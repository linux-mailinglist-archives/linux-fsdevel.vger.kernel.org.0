Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30FFA2A42E0
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Nov 2020 11:43:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728705AbgKCKfM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Nov 2020 05:35:12 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:38330 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728519AbgKCKeH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Nov 2020 05:34:07 -0500
Message-Id: <20201103095859.632601906@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1604399640;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=BkU+tnLkRKR9tWKe3hevtehunqdIqgczXq1AHqpv3q4=;
        b=KJf8zms3zcTUg/g/XiQKKwBV2+EGVfb2u6h4vllDaW1ez/6EBzhuUPcV5jYjkgK7/2tTNT
        qa9meb2s93/KBKnvJtf7CaHAT8ZFpd7v/uDOmyc6h4+65DvAL8nMOPTgxeMwXec71wKviC
        gz+l4oJdNdRF681hb02MgaZ8n1LTFM12pOX0R3Y6kTHEtlSnwJNnKuWAQNeTkLaIi8i7t3
        B7yCZDHpTZLzl/MKlFABrQ2M+t1vry/EDo/Dfbd7n6CnEj3z8AhqyHdXDUxHJtlLsKb9Iy
        +K2WT76685XP/mxAZ6mzKSlMAP/ZbKhBPVY2/azsvsrUQ/qHyD8kIOTXSXqhkQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1604399640;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=BkU+tnLkRKR9tWKe3hevtehunqdIqgczXq1AHqpv3q4=;
        b=VFptQlcVWRmmzZcgWUr7xM35WWw+Igz4v/KmNvEZ7Y4AvSm9gz9Y19AW04WlVkG++aOR3h
        ADLKc+FsTUi0cTDA==
Date:   Tue, 03 Nov 2020 10:27:42 +0100
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Linus Torvalds <torvalds@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Paul McKenney <paulmck@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Benjamin LaHaise <bcrl@kvack.org>,
        linux-fsdevel@vger.kernel.org, linux-aio@kvack.org,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        x86@kernel.org, Vineet Gupta <vgupta@synopsys.com>,
        linux-snps-arc@lists.infradead.org,
        Russell King <linux@armlinux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org,
        Michal Simek <monstr@monstr.eu>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-mips@vger.kernel.org, Nick Hu <nickhu@andestech.com>,
        Greentime Hu <green.hu@gmail.com>,
        Vincent Chen <deanbo422@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev@lists.ozlabs.org,
        "David S. Miller" <davem@davemloft.net>,
        sparclinux@vger.kernel.org, Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>,
        linux-xtensa@linux-xtensa.org, Ingo Molnar <mingo@kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Christian Koenig <christian.koenig@amd.com>,
        Huang Rui <ray.huang@amd.com>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org,
        VMware Graphics <linux-graphics-maintainer@vmware.com>,
        Roland Scheidegger <sroland@vmware.com>,
        Dave Airlie <airlied@redhat.com>,
        Gerd Hoffmann <kraxel@redhat.com>,
        virtualization@lists.linux-foundation.org,
        spice-devel@lists.freedesktop.org, Ben Skeggs <bskeggs@redhat.com>,
        nouveau@lists.freedesktop.org,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        intel-gfx@lists.freedesktop.org
Subject: [patch V3 30/37] highmem: Remove kmap_atomic_pfn()
References: <20201103092712.714480842@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

No more users.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
V3: New patch
---
 include/linux/highmem-internal.h |   12 ------------
 1 file changed, 12 deletions(-)

--- a/include/linux/highmem-internal.h
+++ b/include/linux/highmem-internal.h
@@ -99,13 +99,6 @@ static inline void *kmap_atomic(struct p
 	return kmap_atomic_prot(page, kmap_prot);
 }
 
-static inline void *kmap_atomic_pfn(unsigned long pfn)
-{
-	preempt_disable();
-	pagefault_disable();
-	return __kmap_local_pfn_prot(pfn, kmap_prot);
-}
-
 static inline void __kunmap_atomic(void *addr)
 {
 	kunmap_local_indexed(addr);
@@ -193,11 +186,6 @@ static inline void *kmap_atomic_prot(str
 	return kmap_atomic(page);
 }
 
-static inline void *kmap_atomic_pfn(unsigned long pfn)
-{
-	return kmap_atomic(pfn_to_page(pfn));
-}
-
 static inline void __kunmap_atomic(void *addr)
 {
 #ifdef ARCH_HAS_FLUSH_ON_KUNMAP


Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51A192A4295
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Nov 2020 11:42:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728324AbgKCKdf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Nov 2020 05:33:35 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:37854 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728257AbgKCKde (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Nov 2020 05:33:34 -0500
Message-Id: <20201103095857.268258322@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1604399611;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=mZznvRq2pjMB0UxfV7Tofiw+ZX8bqdvzvy1elzwqCM0=;
        b=iJ/nMPZ/ADH458Z97fsOSw5wf904BzHADYKEdaFCBP8jKIH9j+SxmjzGepeQQmEuDdNCyA
        XxWrtJu+F6lu3Lp7uDpoRKHumZPJMpKU0JAHitmBCq936hqJimtruAT0Rlh/aJD2nJW2U2
        sNv+WzdDOcpqWuWjf03Z6cFdbYts7znLi/vRFm9Inq1DOBuw4Cv5ZvCTAkemTzZPRqX9Us
        A/gXqaxzBtunufmgE+J6ou52fpkTr0wPHTsN2lG/n5pspmhs9CquSUQH5jaynAXffSMhb0
        Y/avkAR9q97xAA+G8lllFeR3zkhF27Vtrd+kwqZDO8mrS5ZturOc+6Mxv/CPoQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1604399611;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=mZznvRq2pjMB0UxfV7Tofiw+ZX8bqdvzvy1elzwqCM0=;
        b=YkjV/BXfl1xf/PJwkxxRp2il3aCsOfTo0zpayVu8o2qPQTr7lA/QrCtxb7deyA8IfhHH+y
        cIngF4mt/rXTgQCg==
Date:   Tue, 03 Nov 2020 10:27:19 +0100
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
Subject: [patch V3 07/37] highmem: Make DEBUG_HIGHMEM functional
References: <20201103092712.714480842@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

For some obscure reason when CONFIG_DEBUG_HIGHMEM is enabled the stack
depth is increased from 20 to 41. But the only thing DEBUG_HIGHMEM does is
to enable a few BUG_ON()'s in the mapping code.

That's a leftover from the historical mapping code which had fixed entries
for various purposes. DEBUG_HIGHMEM inserted guard mappings between the map
types. But that got all ditched when kmap_atomic() switched to a stack
based map management. Though the WITH_KM_FENCE magic survived without being
functional. All the thing does today is to increase the stack depth.

Add a working implementation to the generic kmap_local* implementation.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
V3: New patch
---
 mm/highmem.c |   14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

--- a/mm/highmem.c
+++ b/mm/highmem.c
@@ -374,9 +374,19 @@ EXPORT_SYMBOL(kunmap_high);
 
 static DEFINE_PER_CPU(int, __kmap_local_idx);
 
+/*
+ * With DEBUG_HIGHMEM the stack depth is doubled and every second
+ * slot is unused which acts as a guard page
+ */
+#ifdef CONFIG_DEBUG_HIGHMEM
+# define KM_INCR	2
+#else
+# define KM_INCR	1
+#endif
+
 static inline int kmap_local_idx_push(void)
 {
-	int idx = __this_cpu_inc_return(__kmap_local_idx) - 1;
+	int idx = __this_cpu_add_return(__kmap_local_idx, KM_INCR) - 1;
 
 	WARN_ON_ONCE(in_irq() && !irqs_disabled());
 	BUG_ON(idx >= KM_MAX_IDX);
@@ -390,7 +400,7 @@ static inline int kmap_local_idx(void)
 
 static inline void kmap_local_idx_pop(void)
 {
-	int idx = __this_cpu_dec_return(__kmap_local_idx);
+	int idx = __this_cpu_sub_return(__kmap_local_idx, KM_INCR);
 
 	BUG_ON(idx < 0);
 }


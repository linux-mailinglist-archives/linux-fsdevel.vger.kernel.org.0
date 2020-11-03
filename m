Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78DB72A433A
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Nov 2020 11:44:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728450AbgKCKhb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Nov 2020 05:37:31 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:37666 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728224AbgKCKdb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Nov 2020 05:33:31 -0500
Message-Id: <20201103095857.078043987@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1604399608;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=ut1GkVw4OXMSCtChDMtmqVv6FlrafPsAPVPH5qh/+W4=;
        b=DeNS3WE1qEb0dgla8K3N8yAAxK42YXCD7IXZTcjA5JidpsaOjufBQETLeVjVdMGu5N+Epm
        TN2LbLx9UK5WAHAuFTdAVHgpIusNly6ze0TP49RK3GBjU6VwMiULa7UcabIY/uYmkhC/Q2
        7E+DRfk3lJMdS7ur2nAIDXy3dY58VVhKxNO+bAOTSYjktAom2snLnmjN0H65s8xX6vxXVt
        YQ4LzfUHrOasGRYEc8hqqfEQ7zS/2/eXUx4Jjj3gU8+4EJPX/jeKSlxdZhR8rS5rw5hOzP
        O8oe69upLo4k/OB5xaqFs3Q3SWo87jVdet4A8lOOlvU3BX6pueHmK6FL3MJKuw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1604399608;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=ut1GkVw4OXMSCtChDMtmqVv6FlrafPsAPVPH5qh/+W4=;
        b=97wrklPJQnUcEJTW2FcH4zagpYwVXJJ9W1FwrGZ1R9owPebJ4P6ITrCybgRDr7QJGxe2Wp
        Y3q7gG0ch2kbmeAA==
Date:   Tue, 03 Nov 2020 10:27:17 +0100
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
Subject: [patch V3 05/37] asm-generic: Provide kmap_size.h
References: <20201103092712.714480842@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

kmap_types.h is a misnomer because the old atomic MAP based array does not
exist anymore and the whole indirection of architectures including
kmap_types.h is inconinstent and does not allow to provide guard page
debugging for this misfeature.

Add a common header file which defines the mapping stack size for all
architectures. Will be used when converting architectures over to a
generic kmap_local/atomic implementation.

The array size is chosen with the following constraints in mind:

    - The deepest nest level in one context is 3 according to code
      inspection.

    - The worst case nesting for the upcoming reemptible version would be:

      2 maps in task context and a fault inside
      2 maps in the fault handler
      3 maps in softirq
      2 maps in interrupt

So a total of 16 is sufficient and probably overestimated.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
V3: New patch
---
 include/asm-generic/Kbuild      |    1 +
 include/asm-generic/kmap_size.h |   12 ++++++++++++
 2 files changed, 13 insertions(+)

--- a/include/asm-generic/Kbuild
+++ b/include/asm-generic/Kbuild
@@ -31,6 +31,7 @@ mandatory-y += irq_regs.h
 mandatory-y += irq_work.h
 mandatory-y += kdebug.h
 mandatory-y += kmap_types.h
+mandatory-y += kmap_size.h
 mandatory-y += kprobes.h
 mandatory-y += linkage.h
 mandatory-y += local.h
--- /dev/null
+++ b/include/asm-generic/kmap_size.h
@@ -0,0 +1,12 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_GENERIC_KMAP_SIZE_H
+#define _ASM_GENERIC_KMAP_SIZE_H
+
+/* For debug this provides guard pages between the maps */
+#ifdef CONFIG_DEBUG_HIGHMEM
+# define KM_MAX_IDX	33
+#else
+# define KM_MAX_IDX	16
+#endif
+
+#endif


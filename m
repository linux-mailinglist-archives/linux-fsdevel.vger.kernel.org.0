Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A05D22F55E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Jul 2020 18:30:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732229AbgG0Qas (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Jul 2020 12:30:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:59694 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729573AbgG0Qar (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Jul 2020 12:30:47 -0400
Received: from aquarius.haifa.ibm.com (nesher1.haifa.il.ibm.com [195.110.40.7])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 286AF2074F;
        Mon, 27 Jul 2020 16:30:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595867447;
        bh=/Qw/NeLTpR/6aCJ04huD3Mp72u1Bfe6uWLUqSL0Zn2g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KtM0Agb5HnPUkY+CbqIdR37o127nhQKSy5Dq+iFtbhAZ5rXOrCF/TCi/y9dVBPJgG
         ESLcg0dYR67EEDk5MwOpPeS2zHrUXad+3m3RPRP3kklfQeu9q9pdGF6IS3dzaGLPnI
         xswjDrT4XhuX8HarB2l6OUZFzMfxbAPY98Qdg+hQ=
From:   Mike Rapoport <rppt@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christopher Lameter <cl@linux.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Elena Reshetova <elena.reshetova@intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Idan Yaniv <idan.yaniv@ibm.com>,
        Ingo Molnar <mingo@redhat.com>,
        James Bottomley <jejb@linux.ibm.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Matthew Wilcox <willy@infradead.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Mike Rapoport <rppt@kernel.org>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tycho Andersen <tycho@tycho.ws>, Will Deacon <will@kernel.org>,
        linux-api@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-nvdimm@lists.01.org, linux-riscv@lists.infradead.org,
        x86@kernel.org
Subject: [PATCH v2 7/7] mm: secretmem: add ability to reserve memory at boot
Date:   Mon, 27 Jul 2020 19:29:35 +0300
Message-Id: <20200727162935.31714-8-rppt@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200727162935.31714-1-rppt@kernel.org>
References: <20200727162935.31714-1-rppt@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Mike Rapoport <rppt@linux.ibm.com>

Taking pages out from the direct map and bringing them back may create
undesired fragmentation and usage of the smaller pages in the direct
mapping of the physical memory.

This can be avoided if a significantly large area of the physical memory
would be reserved for secretmem purposes at boot time.

Add ability to reserve physical memory for secretmem at boot time using
"secretmem" kernel parameter and then use that reserved memory as a global
pool for secret memory needs.

Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
---
 Documentation/admin-guide/kernel-parameters.txt | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index fb95fad81c79..6f3c2f28160f 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -4548,6 +4548,10 @@
 			Format: integer between 0 and 10
 			Default is 0.
 
+	secretmem=n[KMG]
+			[KNL,BOOT] Reserve specified amount of memory to
+			back mappings of secret memory.
+
 	skew_tick=	[KNL] Offset the periodic timer tick per cpu to mitigate
 			xtime_lock contention on larger systems, and/or RCU lock
 			contention on all systems with CONFIG_MAXSMP set.
-- 
2.26.2


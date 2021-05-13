Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73F9437FF6E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 May 2021 22:47:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233139AbhEMUtF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 May 2021 16:49:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:56294 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231249AbhEMUtF (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 May 2021 16:49:05 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id CC49A61287;
        Thu, 13 May 2021 20:47:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1620938875;
        bh=ph/D2ruaZJycXfWKMXtRhWDiuhNBEwRkB87bfJEc7wQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=yT0GSlqeFDTM/njo6gS0zUif6V5qdEVi1ci+b3bvuCtP5u2XB6cWVOaGaVYgDzrNX
         Ajln01PVePlCbU87w1oeQfjsEhRHGDhSS2F4nBpWt0JTKDv6Y6FFGXSb+TAruaI1FH
         ty2mA4dnAGWdBz1VpY+k7082g09XhS5b1PxpOpa8=
Date:   Thu, 13 May 2021 13:47:54 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Randy Dunlap <rdunlap@infradead.org>, broonie@kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-next@vger.kernel.org, mhocko@suse.cz,
        mm-commits@vger.kernel.org, sfr@canb.auug.org.au
Subject: Re: mmotm 2021-05-12-21-46 uploaded (arch/x86/mm/pgtable.c)
Message-Id: <20210513134754.ab3f1a864b0156ef99248401@linux-foundation.org>
In-Reply-To: <54055e72-34b8-d43d-2ad3-87e8c8fa547b@csgroup.eu>
References: <20210513044710.MCXhM_NwC%akpm@linux-foundation.org>
        <151ddd7f-1d3e-a6f7-daab-e32f785426e1@infradead.org>
        <54055e72-34b8-d43d-2ad3-87e8c8fa547b@csgroup.eu>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, 13 May 2021 19:09:23 +0200 Christophe Leroy <christophe.leroy@csgroup.eu> wrote:

> 
> 
> > on i386:
> > 
> > ../arch/x86/mm/pgtable.c:703:5: error: redefinition of ‘pud_set_huge’
> >   int pud_set_huge(pud_t *pud, phys_addr_t addr, pgprot_t prot)
> >       ^~~~~~~~~~~~
> > In file included from ../include/linux/mm.h:33:0,
> >                   from ../arch/x86/mm/pgtable.c:2:
> > ../include/linux/pgtable.h:1387:19: note: previous definition of ‘pud_set_huge’ was here
> >   static inline int pud_set_huge(pud_t *pud, phys_addr_t addr, pgprot_t prot)
> >                     ^~~~~~~~~~~~
> > ../arch/x86/mm/pgtable.c:758:5: error: redefinition of ‘pud_clear_huge’
> >   int pud_clear_huge(pud_t *pud)
> >       ^~~~~~~~~~~~~~
> > In file included from ../include/linux/mm.h:33:0,
> >                   from ../arch/x86/mm/pgtable.c:2:
> > ../include/linux/pgtable.h:1391:19: note: previous definition of ‘pud_clear_huge’ was here
> >   static inline int pud_clear_huge(pud_t *pud)
> >                     ^~~~~~~~~~~~~~
> 
> Hum ...
> 
> Comes from my patch 
> https://patchwork.ozlabs.org/project/linuxppc-dev/patch/5ac5976419350e8e048d463a64cae449eb3ba4b0.1620795204.git.christophe.leroy@csgroup.eu/
> 
> But, that happens only if x86 defines __PAGETABLE_PUD_FOLDED. And if PUD is folded, then I can't 
> understand my it has pud_set_huge() and pud_clear_huge() functions.

Probably because someone messed something up ;)

Let's try this.

--- a/arch/x86/mm/pgtable.c~mm-pgtable-add-stubs-for-pmd-pub_set-clear_huge-fix
+++ a/arch/x86/mm/pgtable.c
@@ -682,6 +682,7 @@ int p4d_clear_huge(p4d_t *p4d)
 }
 #endif
 
+#ifndef __PAGETABLE_PUD_FOLDED
 /**
  * pud_set_huge - setup kernel PUD mapping
  *
@@ -721,6 +722,22 @@ int pud_set_huge(pud_t *pud, phys_addr_t
 }
 
 /**
+ * pud_clear_huge - clear kernel PUD mapping when it is set
+ *
+ * Returns 1 on success and 0 on failure (no PUD map is found).
+ */
+int pud_clear_huge(pud_t *pud)
+{
+	if (pud_large(*pud)) {
+		pud_clear(pud);
+		return 1;
+	}
+
+	return 0;
+}
+#endif
+
+/**
  * pmd_set_huge - setup kernel PMD mapping
  *
  * See text over pud_set_huge() above.
@@ -751,21 +768,6 @@ int pmd_set_huge(pmd_t *pmd, phys_addr_t
 }
 
 /**
- * pud_clear_huge - clear kernel PUD mapping when it is set
- *
- * Returns 1 on success and 0 on failure (no PUD map is found).
- */
-int pud_clear_huge(pud_t *pud)
-{
-	if (pud_large(*pud)) {
-		pud_clear(pud);
-		return 1;
-	}
-
-	return 0;
-}
-
-/**
  * pmd_clear_huge - clear kernel PMD mapping when it is set
  *
  * Returns 1 on success and 0 on failure (no PMD map is found).
_


Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5857B2703F1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Sep 2020 20:25:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726380AbgIRSZe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 18 Sep 2020 14:25:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:52326 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726381AbgIRSZe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 18 Sep 2020 14:25:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600453532;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eg/2C71vV3EBvxwezzmYF9acSvHgEEsLNSCT9Xp2Ew0=;
        b=copdo0IU+G3QmqasVpbRGg2GoEg0FGz4yvS7q1C0mMAT7BJrFQDrrNby8KPUX7ILg7YEjA
        dIwV5UanJP1vnzwrsJLtxDmItI4nu8ENsXnR8WEt6CIcrU6rmCoBQfJLUtEi6AR9xEk3SR
        W8R5fBGRpi6ktRVMwZDdGGsIW55YVO8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-453-kfXmF_4QNlaAc1bwQzkdqA-1; Fri, 18 Sep 2020 14:25:28 -0400
X-MC-Unique: kfXmF_4QNlaAc1bwQzkdqA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3D64F9CC08;
        Fri, 18 Sep 2020 18:25:23 +0000 (UTC)
Received: from ovpn-113-208.rdu2.redhat.com (ovpn-113-208.rdu2.redhat.com [10.10.113.208])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7F3425D9D5;
        Fri, 18 Sep 2020 18:25:15 +0000 (UTC)
Message-ID: <fdd0240c187f974fccc553acea895f638d5e822a.camel@redhat.com>
Subject: Re: [PATCH v5 0/5] mm: introduce memfd_secret system call to create
 "secret" memory areas
From:   Qian Cai <cai@redhat.com>
To:     Mike Rapoport <rppt@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christopher Lameter <cl@linux.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        David Hildenbrand <david@redhat.com>,
        Elena Reshetova <elena.reshetova@intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Idan Yaniv <idan.yaniv@ibm.com>,
        Ingo Molnar <mingo@redhat.com>,
        James Bottomley <jejb@linux.ibm.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Matthew Wilcox <willy@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tycho Andersen <tycho@tycho.ws>, Will Deacon <will@kernel.org>,
        linux-api@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org,
        linux-riscv@lists.infradead.org, x86@kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        linux-next@vger.kernel.org
Date:   Fri, 18 Sep 2020 14:25:15 -0400
In-Reply-To: <5d97da4d86db258fdc9b20be3c12588089e17da2.camel@redhat.com>
References: <20200916073539.3552-1-rppt@kernel.org>
         <5d97da4d86db258fdc9b20be3c12588089e17da2.camel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, 2020-09-17 at 09:27 -0400, Qian Cai wrote:
> On Wed, 2020-09-16 at 10:35 +0300, Mike Rapoport wrote:
> > From: Mike Rapoport <rppt@linux.ibm.com>
> > 
> > Hi,
> > 
> > This is an implementation of "secret" mappings backed by a file descriptor. 
> > I've dropped the boot time reservation patch for now as it is not strictly
> > required for the basic usage and can be easily added later either with or
> > without CMA.
> 
> On powerpc: https://gitlab.com/cailca/linux-mm/-/blob/master/powerpc.config
> 
> There is a compiling warning from the today's linux-next:
> 
> <stdin>:1532:2: warning: #warning syscall memfd_secret not implemented [-Wcpp]

This should silence the warning:

diff --git a/scripts/checksyscalls.sh b/scripts/checksyscalls.sh
index a18b47695f55..b7609958ee36 100755
--- a/scripts/checksyscalls.sh
+++ b/scripts/checksyscalls.sh
@@ -40,6 +40,10 @@ cat << EOF
 #define __IGNORE_setrlimit	/* setrlimit */
 #endif
 
+#ifndef __ARCH_WANT_MEMFD_SECRET
+#define __IGNORE_memfd_secret
+#endif
+
 /* Missing flags argument */
 #define __IGNORE_renameat	/* renameat2 */


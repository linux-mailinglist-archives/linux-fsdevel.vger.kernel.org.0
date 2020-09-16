Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B24926C998
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Sep 2020 21:14:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727497AbgIPTOl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Sep 2020 15:14:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:23162 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727282AbgIPRk1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Sep 2020 13:40:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600278025;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4m/h+yY/PVAaaASlrExFZfjTuXa07+sxs0XLIUnFi6k=;
        b=RgvaAjW4rid7mCypxBARQb2WX2vRi+LPz2VdcVb5lsY68A5gtO538VQ5s7N2pfgRxTe226
        i6USsibtDPVfO0f1P/FlQJ26J+a9SP7qNJI+JkkihFJD9nXtp1uQ/OKcy/EopUGlLob4Js
        1/2XhD3vmQANBid+Fydg9rr8B/uxTvU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-485-JHbHg4c9NlaKwI5bE_0bzQ-1; Wed, 16 Sep 2020 06:57:15 -0400
X-MC-Unique: JHbHg4c9NlaKwI5bE_0bzQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2C02D1006712;
        Wed, 16 Sep 2020 10:57:13 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (file01.intranet.prod.int.rdu2.redhat.com [10.11.5.7])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 9E3CC7880C;
        Wed, 16 Sep 2020 10:57:12 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (localhost [127.0.0.1])
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4) with ESMTP id 08GAvCZm014220;
        Wed, 16 Sep 2020 06:57:12 -0400
Received: from localhost (mpatocka@localhost)
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4/Submit) with ESMTP id 08GAvA4V014216;
        Wed, 16 Sep 2020 06:57:10 -0400
X-Authentication-Warning: file01.intranet.prod.int.rdu2.redhat.com: mpatocka owned process doing -bs
Date:   Wed, 16 Sep 2020 06:57:10 -0400 (EDT)
From:   Mikulas Patocka <mpatocka@redhat.com>
X-X-Sender: mpatocka@file01.intranet.prod.int.rdu2.redhat.com
To:     Dan Williams <dan.j.williams@intel.com>
cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        Eric Sandeen <esandeen@redhat.com>,
        Dave Chinner <dchinner@redhat.com>,
        "Kani, Toshi" <toshi.kani@hpe.com>,
        "Norton, Scott J" <scott.norton@hpe.com>,
        "Tadakamadla, Rajesh (DCIG/CDI/HPS Perf)" 
        <rajesh.tadakamadla@hpe.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>
Subject: [PATCH] pmem: export the symbols __copy_user_flushcache and
 __copy_from_user_flushcache
In-Reply-To: <alpine.LRH.2.02.2009151332280.3851@file01.intranet.prod.int.rdu2.redhat.com>
Message-ID: <alpine.LRH.2.02.2009160649560.20720@file01.intranet.prod.int.rdu2.redhat.com>
References: <alpine.LRH.2.02.2009140852030.22422@file01.intranet.prod.int.rdu2.redhat.com> <CAPcyv4gh=QaDB61_9_QTgtt-pZuTFdR6td0orE0VMH6=6SA2vw@mail.gmail.com> <alpine.LRH.2.02.2009151216050.16057@file01.intranet.prod.int.rdu2.redhat.com>
 <alpine.LRH.2.02.2009151332280.3851@file01.intranet.prod.int.rdu2.redhat.com>
User-Agent: Alpine 2.02 (LRH 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On Tue, 15 Sep 2020, Mikulas Patocka wrote:

> 
> 
> On Tue, 15 Sep 2020, Mikulas Patocka wrote:
> 
> > > > - __copy_from_user_inatomic_nocache doesn't flush cache for leading and
> > > > trailing bytes.
> > > 
> > > You want copy_user_flushcache(). See how fs/dax.c arranges for
> > > dax_copy_from_iter() to route to pmem_copy_from_iter().
> > 
> > Is it something new for the kernel 5.10? I see only __copy_user_flushcache 
> > that is implemented just for x86 and arm64.
> > 
> > There is __copy_from_user_flushcache implemented for x86, arm64 and power. 
> > It is used in lib/iov_iter.c under
> > #ifdef CONFIG_ARCH_HAS_UACCESS_FLUSHCACHE - so should I use this?
> > 
> > Mikulas
> 
> ... and __copy_user_flushcache is not exported for modules. So, I am stuck 
> with __copy_from_user_inatomic_nocache.
> 
> Mikulas

I'm submitting this patch that adds the required exports (so that we could 
use __copy_from_user_flushcache on x86, arm64 and powerpc). Please, queue 
it for the next merge window.


From: Mikulas Patocka <mpatocka@redhat.com>

Export the symbols __copy_user_flushcache and __copy_from_user_flushcache,
so that modules can use this functionality.

Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>

---
 arch/arm64/lib/uaccess_flushcache.c |    1 +
 arch/powerpc/lib/pmem.c             |    1 +
 arch/x86/lib/usercopy_64.c          |    1 +
 3 files changed, 3 insertions(+)

Index: linux-2.6/arch/arm64/lib/uaccess_flushcache.c
===================================================================
--- linux-2.6.orig/arch/arm64/lib/uaccess_flushcache.c	2020-09-16 12:44:15.068038000 +0200
+++ linux-2.6/arch/arm64/lib/uaccess_flushcache.c	2020-09-16 12:44:15.068038000 +0200
@@ -38,3 +38,4 @@ unsigned long __copy_user_flushcache(voi
 	__clean_dcache_area_pop(to, n - rc);
 	return rc;
 }
+EXPORT_SYMBOL_GPL(__copy_user_flushcache);
Index: linux-2.6/arch/x86/lib/usercopy_64.c
===================================================================
--- linux-2.6.orig/arch/x86/lib/usercopy_64.c	2020-09-16 12:44:15.068038000 +0200
+++ linux-2.6/arch/x86/lib/usercopy_64.c	2020-09-16 12:44:15.068038000 +0200
@@ -134,6 +134,7 @@ long __copy_user_flushcache(void *dst, c
 
 	return rc;
 }
+EXPORT_SYMBOL_GPL(__copy_user_flushcache);
 
 void __memcpy_flushcache(void *_dst, const void *_src, size_t size)
 {
Index: linux-2.6/arch/powerpc/lib/pmem.c
===================================================================
--- linux-2.6.orig/arch/powerpc/lib/pmem.c	2020-09-16 12:44:15.068038000 +0200
+++ linux-2.6/arch/powerpc/lib/pmem.c	2020-09-16 12:44:15.068038000 +0200
@@ -75,6 +75,7 @@ long __copy_from_user_flushcache(void *d
 
 	return copied;
 }
+EXPORT_SYMBOL_GPL(__copy_from_user_flushcache);
 
 void memcpy_flushcache(void *dest, const void *src, size_t size)
 {


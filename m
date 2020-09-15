Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0E7126AC31
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Sep 2020 20:39:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727979AbgIOSjU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Sep 2020 14:39:20 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:24301 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727939AbgIORin (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Sep 2020 13:38:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600191497;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=RxByhYJNtAoO/ydyFRO1RXTNjxPYd9rIcotBMI+uGJE=;
        b=FzVGkyTKzzmMbHR03oemCHSiyGD5h5Fk8NFhSzOyrSOBa7lFQ1RD7kh0VvPvW5H6ZWcgEy
        sGhD7T2pCMNls0SnxXccqZGSMP7MyFrN3FkSlpy/+ceJF+KIUcKs8KeMUOyRJxTn+EfSz3
        GW0oOoRoWnJfy4cw7mc3NPNOT0UD1iA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-203-IsF8JrMIPgSPuKStpjnk1A-1; Tue, 15 Sep 2020 13:38:13 -0400
X-MC-Unique: IsF8JrMIPgSPuKStpjnk1A-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 06D56AF206;
        Tue, 15 Sep 2020 17:38:11 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (file01.intranet.prod.int.rdu2.redhat.com [10.11.5.7])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id CAAA65C3E0;
        Tue, 15 Sep 2020 17:38:10 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (localhost [127.0.0.1])
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4) with ESMTP id 08FHcAsU004160;
        Tue, 15 Sep 2020 13:38:10 -0400
Received: from localhost (mpatocka@localhost)
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4/Submit) with ESMTP id 08FHcAxo004156;
        Tue, 15 Sep 2020 13:38:10 -0400
X-Authentication-Warning: file01.intranet.prod.int.rdu2.redhat.com: mpatocka owned process doing -bs
Date:   Tue, 15 Sep 2020 13:38:09 -0400 (EDT)
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
Subject: Re: [RFC] nvfs: a filesystem for persistent memory
In-Reply-To: <alpine.LRH.2.02.2009151216050.16057@file01.intranet.prod.int.rdu2.redhat.com>
Message-ID: <alpine.LRH.2.02.2009151332280.3851@file01.intranet.prod.int.rdu2.redhat.com>
References: <alpine.LRH.2.02.2009140852030.22422@file01.intranet.prod.int.rdu2.redhat.com> <CAPcyv4gh=QaDB61_9_QTgtt-pZuTFdR6td0orE0VMH6=6SA2vw@mail.gmail.com> <alpine.LRH.2.02.2009151216050.16057@file01.intranet.prod.int.rdu2.redhat.com>
User-Agent: Alpine 2.02 (LRH 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On Tue, 15 Sep 2020, Mikulas Patocka wrote:

> > > - __copy_from_user_inatomic_nocache doesn't flush cache for leading and
> > > trailing bytes.
> > 
> > You want copy_user_flushcache(). See how fs/dax.c arranges for
> > dax_copy_from_iter() to route to pmem_copy_from_iter().
> 
> Is it something new for the kernel 5.10? I see only __copy_user_flushcache 
> that is implemented just for x86 and arm64.
> 
> There is __copy_from_user_flushcache implemented for x86, arm64 and power. 
> It is used in lib/iov_iter.c under
> #ifdef CONFIG_ARCH_HAS_UACCESS_FLUSHCACHE - so should I use this?
> 
> Mikulas

... and __copy_user_flushcache is not exported for modules. So, I am stuck 
with __copy_from_user_inatomic_nocache.

Mikulas


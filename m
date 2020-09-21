Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 179A3272B9A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Sep 2020 18:19:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728072AbgIUQTU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 21 Sep 2020 12:19:20 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:21664 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728041AbgIUQTS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 21 Sep 2020 12:19:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600705157;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZmFjVvOWAAxGsKnBKa5OzPqNgYQ+Dx+Zm77T3IL8Os4=;
        b=Z2l06jRkQQd+mObFHJ7dYlQxMJOmVX35UrfGuiciY9WI2R0qTCI13FIeTyhw7uKlM9laXL
        owNHHFQw4jVCPcJ7kG1CXffYyS8oOa2bEc8uxLhCKaDE2+XFGnvFq0lZxvpen3ZF6Jgenj
        y9X3iJakKJ6Vw+UbJ/kClI1nN2wxenU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-407-VnG3BKQDNH25JjLQQZjOew-1; Mon, 21 Sep 2020 12:19:13 -0400
X-MC-Unique: VnG3BKQDNH25JjLQQZjOew-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0746C801F99;
        Mon, 21 Sep 2020 16:19:11 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (file01.intranet.prod.int.rdu2.redhat.com [10.11.5.7])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 4BF186115F;
        Mon, 21 Sep 2020 16:19:10 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (localhost [127.0.0.1])
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4) with ESMTP id 08LGJ9Iq006331;
        Mon, 21 Sep 2020 12:19:09 -0400
Received: from localhost (mpatocka@localhost)
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4/Submit) with ESMTP id 08LGJ7Y4006327;
        Mon, 21 Sep 2020 12:19:08 -0400
X-Authentication-Warning: file01.intranet.prod.int.rdu2.redhat.com: mpatocka owned process doing -bs
Date:   Mon, 21 Sep 2020 12:19:07 -0400 (EDT)
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
In-Reply-To: <CAPcyv4gh=QaDB61_9_QTgtt-pZuTFdR6td0orE0VMH6=6SA2vw@mail.gmail.com>
Message-ID: <alpine.LRH.2.02.2009211133190.15623@file01.intranet.prod.int.rdu2.redhat.com>
References: <alpine.LRH.2.02.2009140852030.22422@file01.intranet.prod.int.rdu2.redhat.com> <CAPcyv4gh=QaDB61_9_QTgtt-pZuTFdR6td0orE0VMH6=6SA2vw@mail.gmail.com>
User-Agent: Alpine 2.02 (LRH 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On Tue, 15 Sep 2020, Dan Williams wrote:

> > TODO:
> >
> > - programs run approximately 4% slower when running from Optane-based
> > persistent memory. Therefore, programs and libraries should use page cache
> > and not DAX mapping.
> 
> This needs to be based on platform firmware data f(ACPI HMAT) for the
> relative performance of a PMEM range vs DRAM. For example, this
> tradeoff should not exist with battery backed DRAM, or virtio-pmem.

Hi

I have implemented this functionality - if we mmap a file with 
(vma->vm_flags & VM_DENYWRITE), then it is assumed that this is executable 
file mapping - the flag S_DAX on the inode is cleared on and the inode 
will use normal page cache.

Is there some way how to test if we are using Optane-based module (where 
this optimization should be applied) or battery backed DRAM (where it 
should not)?

I've added mount options dax=never, dax=auto, dax=always, so that the user 
can override the automatic behavior.

Mikulas


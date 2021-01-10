Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68A012F09D3
	for <lists+linux-fsdevel@lfdr.de>; Sun, 10 Jan 2021 22:21:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726525AbhAJVUs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 10 Jan 2021 16:20:48 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:36152 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726432AbhAJVUr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 10 Jan 2021 16:20:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1610313561;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GzR2svGdni3UUiAwy2uWgYKwGxzlJZYVizDa0vCUdQY=;
        b=cdVEdrV2Y2Z+YquHjQB4nge2XHuqisOJaUBeegK1nfAhBMxaT+ul7bHXqCB5tDbDnF/jd3
        1vl0j8D5hjyQw2NESeWZN15hl0Pc9RZeO699afSRoa2/UTNtI2dkiuogHTSuVMfp+vKhcF
        iGfbhER0Bw4/Mb/O6UQlmYBy1rC14fk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-493-gerFTRC6OEKKrZ73RlIjtA-1; Sun, 10 Jan 2021 16:19:18 -0500
X-MC-Unique: gerFTRC6OEKKrZ73RlIjtA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 69C8615720;
        Sun, 10 Jan 2021 21:19:16 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (file01.intranet.prod.int.rdu2.redhat.com [10.11.5.7])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E1FA350A80;
        Sun, 10 Jan 2021 21:19:15 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (localhost [127.0.0.1])
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4) with ESMTP id 10ALJFNW017003;
        Sun, 10 Jan 2021 16:19:15 -0500
Received: from localhost (mpatocka@localhost)
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4/Submit) with ESMTP id 10ALJFs6016999;
        Sun, 10 Jan 2021 16:19:15 -0500
X-Authentication-Warning: file01.intranet.prod.int.rdu2.redhat.com: mpatocka owned process doing -bs
Date:   Sun, 10 Jan 2021 16:19:15 -0500 (EST)
From:   Mikulas Patocka <mpatocka@redhat.com>
X-X-Sender: mpatocka@file01.intranet.prod.int.rdu2.redhat.com
To:     Matthew Wilcox <willy@infradead.org>,
        Al Viro <viro@zeniv.linux.org.uk>
cc:     Andrew Morton <akpm@linux-foundation.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ira Weiny <ira.weiny@intel.com>, Jan Kara <jack@suse.cz>,
        Steven Whitehouse <swhiteho@redhat.com>,
        Eric Sandeen <esandeen@redhat.com>,
        Dave Chinner <dchinner@redhat.com>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Wang Jianchao <jianchao.wan9@gmail.com>,
        "Kani, Toshi" <toshi.kani@hpe.com>,
        "Norton, Scott J" <scott.norton@hpe.com>,
        "Tadakamadla, Rajesh" <rajesh.tadakamadla@hpe.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-nvdimm@lists.01.org
Subject: Re: Expense of read_iter
In-Reply-To: <20210110061321.GC35215@casper.infradead.org>
Message-ID: <alpine.LRH.2.02.2101101458420.7366@file01.intranet.prod.int.rdu2.redhat.com>
References: <alpine.LRH.2.02.2101061245100.30542@file01.intranet.prod.int.rdu2.redhat.com> <20210107151125.GB5270@casper.infradead.org> <alpine.LRH.2.02.2101071110080.30654@file01.intranet.prod.int.rdu2.redhat.com>
 <20210110061321.GC35215@casper.infradead.org>
User-Agent: Alpine 2.02 (LRH 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On Sun, 10 Jan 2021, Matthew Wilcox wrote:

> > That is the reason for that 10% degradation with read_iter.
> 
> You seem to be focusing on your argument for "let's just permit
> filesystems to implement both ->read and ->read_iter".  My suggestion
> is that we need to optimise the ->read_iter path, but to do that we need
> to know what's expensive.
> 
> nvfs_rw_iter_locked() looks very complicated.  I suspect it can
> be simplified.

I split it to a separate read and write function and it improved 
performance by 1.3%. Using Al Viro's read_iter improves performance by 3%.

> Of course new_sync_read() needs to be improved too,
> as do the other functions here, but fully a third of the difference
> between read() and read_iter() is the difference between nvfs_read()
> and nvfs_rw_iter_locked().

I put counters into vfs_read and vfs_readv.

After a fresh boot of the virtual machine, the counters show "13385 4". 
After a kernel compilation they show "4475220 8".

So, the readv path is almost unused.

My reasoning was that we should optimize for the "read" path and glue the 
"readv" path on the top of that. Currently, the kernel is doing the 
opposite - optimizing for "readv" and glueing "read" on the top of it.

Mikulas


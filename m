Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BC4631C81C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Feb 2021 10:32:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230015AbhBPJbZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 16 Feb 2021 04:31:25 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:60015 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229694AbhBPJbO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 16 Feb 2021 04:31:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1613467786;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WQwBpcCMDRihoSLkY0nXiJYZq45llCzJSk2sVrYmZu4=;
        b=SlE27LqMmBcFGqjY/0rwKv6XlBqfYZJs0wxQWcu8H41l/FRJ52yMCowvZhiZgMfnJizQgy
        taRsdX2IV/xYIvszpCL3SXhIQ0gFaEf18e1UfQj3APty3B6nNeHQKyGgxfqaeHRSZhe+Su
        MyH7e/WimY2l6FlZsT1ovw2xqJkgtTg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-46-Zx6-8XXBP9WnKXi9yDelKg-1; Tue, 16 Feb 2021 04:29:43 -0500
X-MC-Unique: Zx6-8XXBP9WnKXi9yDelKg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0BA5A100A8E8;
        Tue, 16 Feb 2021 09:29:40 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-119-68.rdu2.redhat.com [10.10.119.68])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 709A110023AB;
        Tue, 16 Feb 2021 09:29:32 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20210216084230.GA23669@lst.de>
References: <20210216084230.GA23669@lst.de> <161340385320.1303470.2392622971006879777.stgit@warthog.procyon.org.uk> <1376938.1613429183@warthog.procyon.org.uk>
To:     Christoph Hellwig <hch@lst.de>
Cc:     dhowells@redhat.com, Trond Myklebust <trondmy@hammerspace.com>,
        Marc Dionne <marc.dionne@auristor.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Steve French <sfrench@samba.org>,
        Dominique Martinet <asmadeus@codewreck.org>,
        linux-cifs@vger.kernel.org, ceph-devel@vger.kernel.org,
        Jeff Layton <jlayton@redhat.com>,
        Matthew Wilcox <willy@infradead.org>, linux-cachefs@redhat.com,
        Alexander Viro <viro@zeniv.linux.org.uk>, linux-mm@kvack.org,
        linux-afs@lists.infradead.org,
        v9fs-developer@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org,
        Jeff Layton <jlayton@kernel.org>,
        David Wysochanski <dwysocha@redhat.com>,
        linux-kernel@vger.kernel.org,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH 34/33] netfs: Use in_interrupt() not in_softirq()
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1419964.1613467771.1@warthog.procyon.org.uk>
Date:   Tue, 16 Feb 2021 09:29:31 +0000
Message-ID: <1419965.1613467771@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Christoph Hellwig <hch@lst.de> wrote:

> On Mon, Feb 15, 2021 at 10:46:23PM +0000, David Howells wrote:
> > The in_softirq() in netfs_rreq_terminated() works fine for the cache being
> > on a normal disk, as the completion handlers may get called in softirq
> > context, but for an NVMe drive, the completion handler may get called in
> > IRQ context.
> > 
> > Fix to use in_interrupt() instead of in_softirq() throughout the read
> > helpers, particularly when deciding whether to punt code that might sleep
> > off to a worker thread.
> 
> We must not use either check, as they all are unreliable especially
> for PREEMPT-RT.

Is there a better way to do it?  The intent is to process the assessment phase
in the calling thread's context if possible rather than bumping over to a
worker thread.  For synchronous I/O, for example, that's done in the caller's
thread.  Maybe that's the answer - if it's known to be asynchronous, I have to
punt, but otherwise don't have to.

David


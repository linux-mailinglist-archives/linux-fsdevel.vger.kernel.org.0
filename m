Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D608631C7D0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Feb 2021 10:09:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230028AbhBPJHZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 16 Feb 2021 04:07:25 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:37810 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229784AbhBPJHK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 16 Feb 2021 04:07:10 -0500
Date:   Tue, 16 Feb 2021 10:06:26 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1613466388;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=pXA7fe5dhXsardy0H04SmPnjEF++cQlTzGur8gI2QwM=;
        b=uXu4DrRfVfYd+SEG3ThhnB52KojptJp1umEHZg0FmpjEQep/Ku3kzNsXtNtm4y2OvGQYCz
        OLs6q1Olm4WMjW8Ea8Taei49T0k0cKzTOrGtC+oWXJ9GC9xRA/7JtEnNpLZULW8V29OnOk
        wHRKW12eXeYum2jTj0jCN9oFFhwRzyFoROpBA1D2OM7d+/uei0+SwOk2ugACt13vA4WPVh
        S7Uwi+v7smyObt0GWYz9jP+YanQo0+/A5vhfmAt0DTRoaPu4Rv3MoJeSkZdCkGLgqFco24
        FlES+01Vf/SwNmUk4/j8HuJUCPA0ndLoqPKs4DCDgxP8GNsXW2EkLnFvJ1PJJw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1613466388;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=pXA7fe5dhXsardy0H04SmPnjEF++cQlTzGur8gI2QwM=;
        b=Ex3kELqMANnnWJzXjLUZrdgvFr6FqspWhFNNwj6u53hxH3IdxEGU5swcYLIBWpwsv6M7s8
        aY5ia4rpeMb3TYAQ==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Christoph Hellwig <hch@lst.de>
Cc:     David Howells <dhowells@redhat.com>,
        Trond Myklebust <trondmy@hammerspace.com>,
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
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 34/33] netfs: Use in_interrupt() not in_softirq()
Message-ID: <20210216090626.kqnk726i6f77libt@linutronix.de>
References: <161340385320.1303470.2392622971006879777.stgit@warthog.procyon.org.uk>
 <1376938.1613429183@warthog.procyon.org.uk>
 <20210216084230.GA23669@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210216084230.GA23669@lst.de>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2021-02-16 09:42:30 [+0100], Christoph Hellwig wrote:
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

Yes, please. I try to cleanup the users one by one
    https://lore.kernel.org/r/20200914204209.256266093@linutronix.de/
    https://lore.kernel.org/amd-gfx/20210209124439.408140-1-bigeasy@linutronix.de/

Sebastian

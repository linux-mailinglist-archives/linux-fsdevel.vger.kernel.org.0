Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98E2131C78A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Feb 2021 09:48:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229983AbhBPInb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 16 Feb 2021 03:43:31 -0500
Received: from verein.lst.de ([213.95.11.211]:40353 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230018AbhBPInO (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 16 Feb 2021 03:43:14 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id C34B368B05; Tue, 16 Feb 2021 09:42:30 +0100 (CET)
Date:   Tue, 16 Feb 2021 09:42:30 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     David Howells <dhowells@redhat.com>
Cc:     Trond Myklebust <trondmy@hammerspace.com>,
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
        Christoph Hellwig <hch@lst.de>, linux-fsdevel@vger.kernel.org,
        linux-nfs@vger.kernel.org, Jeff Layton <jlayton@kernel.org>,
        David Wysochanski <dwysocha@redhat.com>,
        linux-kernel@vger.kernel.org,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH 34/33] netfs: Use in_interrupt() not in_softirq()
Message-ID: <20210216084230.GA23669@lst.de>
References: <161340385320.1303470.2392622971006879777.stgit@warthog.procyon.org.uk> <1376938.1613429183@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1376938.1613429183@warthog.procyon.org.uk>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Feb 15, 2021 at 10:46:23PM +0000, David Howells wrote:
> The in_softirq() in netfs_rreq_terminated() works fine for the cache being
> on a normal disk, as the completion handlers may get called in softirq
> context, but for an NVMe drive, the completion handler may get called in
> IRQ context.
> 
> Fix to use in_interrupt() instead of in_softirq() throughout the read
> helpers, particularly when deciding whether to punt code that might sleep
> off to a worker thread.

We must not use either check, as they all are unreliable especially
for PREEMPT-RT.

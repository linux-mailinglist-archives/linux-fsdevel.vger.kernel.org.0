Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A53613241D1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Feb 2021 17:19:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235712AbhBXQLg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 24 Feb 2021 11:11:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236777AbhBXPxM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 24 Feb 2021 10:53:12 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A28C4C061788;
        Wed, 24 Feb 2021 07:52:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=1iUhtDEi+5CkGUvyZLsVBOnlGWt86U2HUz3W2iE42HY=; b=LBROo6968UJXNWuvJt7SF366Zt
        iIP5QF+rM+aTNmUyr+hfxsInxV40EbrDM7j/il7G5o/9qtY6exZWs/T6Iqf772qHIppcDJMb1NJZn
        phm9I1J2568XEQfvf+XTA4PWCrbE7MeMmOEr5A3VlbG1kogSiPxU2i8TByW/7aipMq0msY8WHuFL+
        DgbfVbHfY0vuyMKSDHXFgyV2cRxWbSHN+hXpKc1fzxc12Mg6lodWqRBhNKxqAmvW0pWmI5sv5jOp2
        WtiPX3StG7iGvARSYw8+rEEGy4Za1PT4EW+UM1FP4DxZaZWq2K6vpiCflB6eB+DAqQEgWaA2XVibt
        +0Wh2msw==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lEwRd-009aTu-W2; Wed, 24 Feb 2021 15:51:25 +0000
Date:   Wed, 24 Feb 2021 15:51:21 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     David Howells <dhowells@redhat.com>
Cc:     Steve French <smfrench@gmail.com>,
        Jeff Layton <jlayton@redhat.com>,
        Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Steve French <sfrench@samba.org>,
        Dominique Martinet <asmadeus@codewreck.org>,
        CIFS <linux-cifs@vger.kernel.org>, ceph-devel@vger.kernel.org,
        linux-cachefs@redhat.com, Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-mm <linux-mm@kvack.org>, linux-afs@lists.infradead.org,
        v9fs-developer@lists.sourceforge.net,
        Christoph Hellwig <hch@lst.de>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-nfs <linux-nfs@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        David Wysochanski <dwysocha@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        William Kucharski <william.kucharski@oracle.com>
Subject: Re: [PATCH 00/33] Network fs helper library & fscache kiocb API [ver
 #3]
Message-ID: <20210224155121.GQ2858050@casper.infradead.org>
References: <CAH2r5mv=PZk_wn2=b0VQcaom9TEw1MGLz+qB_Ktxxm2bnV9Nig@mail.gmail.com>
 <161340385320.1303470.2392622971006879777.stgit@warthog.procyon.org.uk>
 <9e49f96cd80eaf9c8ed267a7fbbcb4c6467ee790.camel@redhat.com>
 <CAH2r5mvPLivjuE=cbijzGSHOvx-hkWSWbcxpoBnJX-BR9pBskQ@mail.gmail.com>
 <20210216021015.GH2858050@casper.infradead.org>
 <3743319.1614173522@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3743319.1614173522@warthog.procyon.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Feb 24, 2021 at 01:32:02PM +0000, David Howells wrote:
> Steve French <smfrench@gmail.com> wrote:
> 
> > This (readahead behavior improvements in Linux, on single large file
> > sequential read workloads like cp or grep) gets particularly interesting
> > with SMB3 as multichannel becomes more common.  With one channel having one
> > readahead request pending on the network is suboptimal - but not as bad as
> > when multichannel is negotiated. Interestingly in most cases two network
> > connections to the same server (different TCP sockets,but the same mount,
> > even in cases where only network adapter) can achieve better performance -
> > but still significantly lags Windows (and probably other clients) as in
> > Linux we don't keep multiple I/Os in flight at one time (unless different
> > files are being read at the same time by different threads).
> 
> I think it should be relatively straightforward to make the netfs_readahead()
> function generate multiple read requests.  If I wasn't handed sufficient pages
> by the VM upfront to do two or more read requests, I would need to do extra
> expansion.  There are a couple of ways this could be done:

I don't think this is a job for netfs_readahead().  We can get into a
similar situation with SSDs or RAID arrays where ideally we would have
several outstanding readahead requests.

If your drive is connected through a 1Gbps link (eg PCIe gen 1 x1) and
has a latency of 10ms seek time, with one outstanding read, each read
needs to be 12.5MB in size in order to saturate the bus.  If the device
supports 128 outstanding commands, each read need only be 100kB.

We need the core readahead code to handle this situation.  My suggestion
for doing this is to send off an extra readahead request every time we
hit a !Uptodate page.  It looks something like this (assuming the app
is processing the data fast and always hits the !Uptodate case) ...

1. hit 0,
	set readahead size to 64kB,
	mark 32kB as Readahead, send read for 0-64kB
	wait for 0-64kB to complete
2. hit 32kB (Readahead), no reads outstanding
	inc readahead size to 128kB,
	mark 128kB as Readahead, send read for 64k-192kB
3. hit 64kB (!Uptodate), one read outstanding
	mark 256kB as Readahead, send read for 192-320kB
	mark 384kB as Readahead, send read for 320-448kB
	wait for 64-192kB to complete
4. hit 128kB (Readahead), two reads outstanding
	inc readahead size to 256kB,
	mark 576kB as Readahead, send read for 448-704kB
5. hit 192kB (!Uptodate), three reads outstanding
	mark 832kB as Readahead, send read for 704-960kB
	mark 1088kB as Readahead, send read for 960-1216kB
	wait for 192-320kB to complete
6. hit 256kB (Readahead), four reads outstanding
	mark 1344kB as Readahead, send read for 1216-1472kB
7. hit 320kB (!Uptodate), five reads outstanding
	mark 1600kB as Readahead, send read for 1472-1728kB
	mark 1856kB as Readahead, send read for 1728-1984kB
	wait for 320-448kB to complete
8. hit 384kB (Readahead), five reads outstanding
	mark 2112kB as Readahead, send read for 1984-2240kB
9. hit 448kB (!Uptodate), six reads outstanding
	mark 2368kB as Readahead, send read for 2240-2496kB
	mark 2624kB as Readahead, send read for 2496-2752kB
	wait for 448-704kB to complete
10. hit 576kB (Readahead), seven reads outstanding
	mark 2880kB as Readahead, send read for 2752-3008kB

...

Once we stop hitting !Uptodate pages, we'll maintain the number of pages
marked as Readahead, and thus keep the number of readahead requests
at the level it determined was necessary to keep the link saturated.
I think we may need to put a parallelism cap in the bdi so that a device
which is just slow instead of at the end of a long fat pipe doesn't get
overwhelmed with requests.

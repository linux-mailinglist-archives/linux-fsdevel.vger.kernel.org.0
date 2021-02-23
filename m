Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21D1D32321C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Feb 2021 21:30:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234253AbhBWU3M (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 23 Feb 2021 15:29:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232942AbhBWU3E (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 23 Feb 2021 15:29:04 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F2F0C061574;
        Tue, 23 Feb 2021 12:28:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=V88KanrG68jeibxEGiMg5wPm/95lNG+KdlAZmbHwfNg=; b=WsrJrMaCSkHBCRydgslpm+bYR7
        p4fZaB4qJVm4eh/q4N9ITrmuWgU22B1d2LPb0yP61G6zCvOG4nZbMvPCFXGMdgl4kliAGgFgRHfSK
        vBkrCF7V78z7YKGtGtCYPngbxKEdwwfVRKQNk88r0NnpnhmSdXye788ZaCAS/38sjxJGvjCU8gmAZ
        0Po70uq86ABK1s0pppmhu68EwIBCytaT6WL17R2ISODMQrLMpYDPuJDblWkLgeZmGAOSG2DI4WurP
        dlmqQcawkf3fmLa27fEdJHsx5uXkFApiU8O/jT0SoBE9lHBeRm5DoQ2t5hpdhqKdGSRus/saT/nk/
        QuTxmsSA==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lEeHW-008TA8-Qu; Tue, 23 Feb 2021 20:27:48 +0000
Date:   Tue, 23 Feb 2021 20:27:42 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Steve French <smfrench@gmail.com>
Cc:     Jeff Layton <jlayton@redhat.com>,
        David Howells <dhowells@redhat.com>,
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
        William Kucharski <william.kucharski@oracle.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <yuchao0@huawei.com>,
        linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [PATCH 00/33] Network fs helper library & fscache kiocb API [ver
 #3]
Message-ID: <20210223202742.GM2858050@casper.infradead.org>
References: <161340385320.1303470.2392622971006879777.stgit@warthog.procyon.org.uk>
 <9e49f96cd80eaf9c8ed267a7fbbcb4c6467ee790.camel@redhat.com>
 <CAH2r5mvPLivjuE=cbijzGSHOvx-hkWSWbcxpoBnJX-BR9pBskQ@mail.gmail.com>
 <20210216021015.GH2858050@casper.infradead.org>
 <CAH2r5mv+AdiODH1TSL+SOQ5qpZ25n7Ysrp+iYxauX9sD8ehhVQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAH2r5mv+AdiODH1TSL+SOQ5qpZ25n7Ysrp+iYxauX9sD8ehhVQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Feb 15, 2021 at 11:22:20PM -0600, Steve French wrote:
> On Mon, Feb 15, 2021 at 8:10 PM Matthew Wilcox <willy@infradead.org> wrote:
> > The switch from readpages to readahead does help in a couple of corner
> > cases.  For example, if you have two processes reading the same file at
> > the same time, one will now block on the other (due to the page lock)
> > rather than submitting a mess of overlapping and partial reads.
> 
> Do you have a simple repro example of this we could try (fio, dbench, iozone
> etc) to get some objective perf data?

I don't.  The problem was noted by the f2fs people, so maybe they have a
reproducer.

> My biggest worry is making sure that the switch to netfs doesn't degrade
> performance (which might be a low bar now since current network file copy
> perf seems to signifcantly lag at least Windows), and in some easy to understand
> scenarios want to make sure it actually helps perf.

I had a question about that ... you've mentioned having 4x4MB reads
outstanding as being the way to get optimum performance.  Is there a
significant performance difference between 4x4MB, 16x1MB and 64x256kB?
I'm concerned about having "too large" an I/O on the wire at a given time.
For example, with a 1Gbps link, you get 250MB/s.  That's a minimum
latency of 16us for a 4kB page, but 16ms for a 4MB page.

"For very simple tasks, people can perceive latencies down to 2 ms or less"
(https://danluu.com/input-lag/)
so going all the way to 4MB I/Os takes us into the perceptible latency
range, whereas a 256kB I/O is only 1ms.

So could you do some experiments with fio doing direct I/O to see if
it takes significantly longer to do, say, 1TB of I/O in 4MB chunks vs
256kB chunks?  Obviously use threads to keep lots of I/Os outstanding.

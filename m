Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1D05484870
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Jan 2022 20:23:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236489AbiADTXZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 4 Jan 2022 14:23:25 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:56896 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235922AbiADTXY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 4 Jan 2022 14:23:24 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4E595B817DE;
        Tue,  4 Jan 2022 19:23:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1731AC36AE9;
        Tue,  4 Jan 2022 19:23:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641324202;
        bh=kFXhcxSguP4J87bclpOKVk/E7FEOX2MRw/6e/KBHsS8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=G6/+BCSeOkPFqxKfWdAOvubSEitoNbJ0VdCkSPZEzI47gpIoED6IJXEmhrvbZ7u9B
         LFzuvEVcQnkQR6kIzxvoWx7IXAqv63+FSqf26DABkxYcD1B4pL2l5MxePkuVYdAKld
         jjtjNtpHT5li0zcpAHf7AB7rE3bUjPX+jPjFnau8ZBAOOJeHWVunYUoqom9t4nnYaK
         HrD2f+v5noUYTIyOBfujyjOoorVHxmG9gFu/u8/x3LmovycVt6WIhdn4moQMOTmqwH
         e4vCbD1IKMF0hlS1XuH5iRZSq+Cu3xn5XtW4B1MTuDt5Eaew1Ga+q8pN/svoxIR5w9
         biK1EVg/XYkZw==
Date:   Tue, 4 Jan 2022 11:23:21 -0800
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Brian Foster <bfoster@redhat.com>
Cc:     Trond Myklebust <trondmy@hammerspace.com>,
        "david@fromorbit.com" <david@fromorbit.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "trondmy@kernel.org" <trondmy@kernel.org>,
        "hch@infradead.org" <hch@infradead.org>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
        "willy@infradead.org" <willy@infradead.org>
Subject: Re: [PATCH] iomap: Address soft lockup in iomap_finish_ioend()
Message-ID: <20220104192321.GF31606@magnolia>
References: <20211230193522.55520-1-trondmy@kernel.org>
 <Yc5f/C1I+N8MPHcd@casper.infradead.org>
 <6f746786a3928844fbe644e7e409008b4f50c239.camel@hammerspace.com>
 <20220101035516.GE945095@dread.disaster.area>
 <fb964769132eb01ed4e8b67d6972d50ee3387e24.camel@hammerspace.com>
 <YdRNasL3WFugVe8c@bfoster>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YdRNasL3WFugVe8c@bfoster>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jan 04, 2022 at 08:36:42AM -0500, Brian Foster wrote:
> On Sat, Jan 01, 2022 at 05:39:45PM +0000, Trond Myklebust wrote:
> ...
> > 
> > Fair enough. As long as someone is working on a solution, then I'm
> > happy. Just a couple of things:
> > 
> > Firstly, we've verified that the cond_resched() in the bio loop does
> > suffice to resolve the issue with XFS, which would tend to confirm what
> > you're saying above about the underlying issue being the ioend chain
> > length.
> > 
> > Secondly, note that we've tested this issue with a variety of older
> > kernels, including 4.18.x, 5.1.x and 5.15.x, so please bear in mind
> > that it would be useful for any fix to be backward portable through the
> > stable mechanism.
> > 
> 
> I've sent a couple or so different variants of this in the past. The
> last I believe was here [1], but still never seemed to go anywhere
> (despite having reviews on the first couple patches). That one was
> essentially a sequence of adding a cond_resched() call in the iomap code
> to address the soft lockup warning followed by capping the ioend size
> for latency reasons.

Huh.  I wonder why I didn't ever merge that?  I said I was going to do
that for 5.14 and ... never did.  ISTR Matthew saying something about
wanting to key the decision off of the number of pages/folios we'd have
to touch, and then musing about adding QOS metrics, me getting fussy
about that, trying to figure out if there was a way to make
iomap_finish_page_writeback cheaper, and ...

<checks notes>

...and decided that since the folio merge was imminent (HA!) I would
merge it after all the dust settled.  Add several months of Things I
Still Cannot Talk About and now it's 2022. :(

Ah, ok, I'll go reply elsewhere in the thread since I think my thinking
on all this has evolved somewhat since then.

--D

> 
> Brian
> 
> [1] https://lore.kernel.org/linux-xfs/20210517171722.1266878-1-bfoster@redhat.com/
> 
> > 
> > Thanks, and Happy New Year!
> > 
> >   Trond
> > 
> > -- 
> > Trond Myklebust
> > Linux NFS client maintainer, Hammerspace
> > trond.myklebust@hammerspace.com
> > 
> > 
> 

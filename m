Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D2443D76EC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jul 2021 15:38:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236575AbhG0NiZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 27 Jul 2021 09:38:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236509AbhG0NiY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 27 Jul 2021 09:38:24 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7B04C061757;
        Tue, 27 Jul 2021 06:38:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:To:From:Date:Sender:Reply-To:Cc:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=EpSbFrEHGAQA1xr1naEuF16MkP61b5G7e9AV8x/Ex4E=; b=o3L8a9jEH3Ul9rQPCR8ay1CcPx
        wIvSa1TgAQ50cmZBTGLgdFt+6KKz9MeISZt2oLyJAD+VrxC8sVZkQDWVTFzAm7Iwxmpok/1Mp4p6l
        P3Nl2s2YEtHdeeEepN52ujuAy8ErrEuQsmZ0DzDilBtZpMXt8pbSZ387BLsESn7wQtqgtyy131Fgr
        V9tKJps9bOSaCDF4lQ4fPtAksGfWW7/qHx9sl878omOclcnrAte+06XMAscDe8xg0q4Zv3OxvS6QB
        8i4Bw2KjwG4FkaEEwKm3MCpXkLEBkiiptKY01o0p92Uxi/IvCJJVRpyiIPCzrVvjXAgtyPhGczHr3
        KaXHSOCg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m8NFL-00F2s7-Bz; Tue, 27 Jul 2021 13:36:29 +0000
Date:   Tue, 27 Jul 2021 14:35:46 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     dsterba@suse.cz, Christoph Hellwig <hch@lst.de>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Gao Xiang <hsiangkao@linux.alibaba.com>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Huang Jianan <huangjianan@oppo.com>,
        linux-erofs@lists.ozlabs.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Andreas Gruenbacher <andreas.gruenbacher@gmail.com>
Subject: Re: [PATCH v7] iomap: make inline data support more flexible
Message-ID: <YQALsvt0UWGW+iMw@casper.infradead.org>
References: <CAHpGcMKZP8b3TbRv3D-pcrE_iDU5TKUFHst9emuQmRPntFSArA@mail.gmail.com>
 <CAHpGcMJBhWcwteLDSBU3hgwq1tk_+LqogM1ZM=Fv8U0VtY5hMg@mail.gmail.com>
 <20210723174131.180813-1-hsiangkao@linux.alibaba.com>
 <20210725221639.426565-1-agruenba@redhat.com>
 <YP4zUvnBCAb86Mny@B-P7TQMD6M-0146.local>
 <20210726110611.459173-1-agruenba@redhat.com>
 <20210726121702.GA528@lst.de>
 <20210727082042.GI5047@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210727082042.GI5047@twin.jikos.cz>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jul 27, 2021 at 10:20:42AM +0200, David Sterba wrote:
> On Mon, Jul 26, 2021 at 02:17:02PM +0200, Christoph Hellwig wrote:
> > > Subject: iomap: Support tail packing
> > 
> > I can't say I like this "tail packing" language here when we have the
> > perfectly fine inline wording.  Same for various comments in the actual
> > code.
> 
> Yes please, don't call it tail-packing when it's an inline extent, we'll
> use that for btrfs eventually and conflating the two terms has been
> cofusing users. Except reiserfs, no linux filesystem does tail-packing.

Hmm ... I see what reiserfs does as packing tails of multiple files into
one block.  What gfs2 (and ext4) do is inline data.  Erofs packs the
tail of a single file into the same block as the inode.  If I understand
what btrfs does correctly, it stores data in the btree.  But (like
gfs2/ext4), it's only for the entire-file-is-small case, not for
its-just-ten-bytes-into-the-last-block case.

So what would you call what erofs is doing if not tail-packing?
Wikipedia calls it https://en.wikipedia.org/wiki/Block_suballocation
which doesn't quite fit.  We need a phrase which means "this isn't
just for small files but for small tails of large files".

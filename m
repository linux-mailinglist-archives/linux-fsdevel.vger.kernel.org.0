Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CB043D7B6D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jul 2021 18:56:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229687AbhG0Q4E (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 27 Jul 2021 12:56:04 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:48726 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbhG0Q4D (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 27 Jul 2021 12:56:03 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 0F3F7221EC;
        Tue, 27 Jul 2021 16:56:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1627404962;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=I6xqCcuCxJ3dCYSStp64lbp+Ddy6J/xCqtuiJjo0KTU=;
        b=l9VZZdmXPaqiSYtXX46V49UfixDqIhSkECPLTwTkbtGHLK/AuoKm06q7J3PS373yKVmts2
        O1lrA2stloOZxxU5jN7bq00RpFLddcX2uIIN2fAnKqONgUg6hYoAmUfTEaUA9iBQ+j2HGk
        owdkUrtd1KN7PW2qSLuwBHp7oGC/vIE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1627404962;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=I6xqCcuCxJ3dCYSStp64lbp+Ddy6J/xCqtuiJjo0KTU=;
        b=tZv5ZZHUElMD+oEJaRkN3pa6JgcLy1DGjYM+xi/S88Md/OALdTnSju1j/wKZw93J67fkLj
        H4rY+l0mcJfK1wBw==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 81D68A3B81;
        Tue, 27 Jul 2021 16:56:01 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id EBA30DA8D6; Tue, 27 Jul 2021 18:53:16 +0200 (CEST)
Date:   Tue, 27 Jul 2021 18:53:16 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Christoph Hellwig <hch@lst.de>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Gao Xiang <hsiangkao@linux.alibaba.com>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Huang Jianan <huangjianan@oppo.com>,
        linux-erofs@lists.ozlabs.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Andreas Gruenbacher <andreas.gruenbacher@gmail.com>
Subject: Re: [PATCH v7] iomap: make inline data support more flexible
Message-ID: <20210727165315.GU5047@suse.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Matthew Wilcox <willy@infradead.org>,
        Christoph Hellwig <hch@lst.de>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Gao Xiang <hsiangkao@linux.alibaba.com>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Huang Jianan <huangjianan@oppo.com>, linux-erofs@lists.ozlabs.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andreas Gruenbacher <andreas.gruenbacher@gmail.com>
References: <CAHpGcMKZP8b3TbRv3D-pcrE_iDU5TKUFHst9emuQmRPntFSArA@mail.gmail.com>
 <CAHpGcMJBhWcwteLDSBU3hgwq1tk_+LqogM1ZM=Fv8U0VtY5hMg@mail.gmail.com>
 <20210723174131.180813-1-hsiangkao@linux.alibaba.com>
 <20210725221639.426565-1-agruenba@redhat.com>
 <YP4zUvnBCAb86Mny@B-P7TQMD6M-0146.local>
 <20210726110611.459173-1-agruenba@redhat.com>
 <20210726121702.GA528@lst.de>
 <20210727082042.GI5047@twin.jikos.cz>
 <YQALsvt0UWGW+iMw@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YQALsvt0UWGW+iMw@casper.infradead.org>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jul 27, 2021 at 02:35:46PM +0100, Matthew Wilcox wrote:
> On Tue, Jul 27, 2021 at 10:20:42AM +0200, David Sterba wrote:
> > On Mon, Jul 26, 2021 at 02:17:02PM +0200, Christoph Hellwig wrote:
> > > > Subject: iomap: Support tail packing
> > > 
> > > I can't say I like this "tail packing" language here when we have the
> > > perfectly fine inline wording.  Same for various comments in the actual
> > > code.
> > 
> > Yes please, don't call it tail-packing when it's an inline extent, we'll
> > use that for btrfs eventually and conflating the two terms has been
> > cofusing users. Except reiserfs, no linux filesystem does tail-packing.
> 
> Hmm ... I see what reiserfs does as packing tails of multiple files into
> one block.  What gfs2 (and ext4) do is inline data.  Erofs packs the
> tail of a single file into the same block as the inode.  If I understand
> what btrfs does correctly, it stores data in the btree.  But (like
> gfs2/ext4), it's only for the entire-file-is-small case, not for
> its-just-ten-bytes-into-the-last-block case.
> 
> So what would you call what erofs is doing if not tail-packing?

That indeed sounds like tail-packing and I was not aware of that, the
docs I found were not clear what exactly was going on with the data
stored inline.

> Wikipedia calls it https://en.wikipedia.org/wiki/Block_suballocation
> which doesn't quite fit.  We need a phrase which means "this isn't
> just for small files but for small tails of large files".

So that's more generic than what we now have as inline files, so in the
interface everybody sets 0 as start of the range while erofs can also
set start of the last partial block.

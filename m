Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B355E3D7945
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jul 2021 17:04:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232661AbhG0PEk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 27 Jul 2021 11:04:40 -0400
Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130]:43692 "EHLO
        out30-130.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231552AbhG0PEk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 27 Jul 2021 11:04:40 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04395;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0UhAAkxc_1627398276;
Received: from B-P7TQMD6M-0146.local(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0UhAAkxc_1627398276)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 27 Jul 2021 23:04:38 +0800
Date:   Tue, 27 Jul 2021 23:04:36 +0800
From:   Gao Xiang <hsiangkao@linux.alibaba.com>
To:     Matthew Wilcox <willy@infradead.org>,
        "Darrick J . Wong" <djwong@kernel.org>
Cc:     dsterba@suse.cz, Christoph Hellwig <hch@lst.de>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Huang Jianan <huangjianan@oppo.com>,
        linux-erofs@lists.ozlabs.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Andreas Gruenbacher <andreas.gruenbacher@gmail.com>
Subject: Re: [PATCH v7] iomap: make inline data support more flexible
Message-ID: <YQAghPSTWdTGYAm5@B-P7TQMD6M-0146.local>
Mail-Followup-To: Matthew Wilcox <willy@infradead.org>,
        "Darrick J . Wong" <djwong@kernel.org>, dsterba@suse.cz,
        Christoph Hellwig <hch@lst.de>,
        Andreas Gruenbacher <agruenba@redhat.com>,
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
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YQALsvt0UWGW+iMw@casper.infradead.org>
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

Plus each erofs block can have multiple inodes (thus multi-tail blocks) 
oo as long as the meta block itself can fit.

No matter what it's called, it's a kind of inline data (I think inline
means that data mixes with metadata according to [1]). I was called it
tail-block inline initially... whatever.

Hopefully, Darrick could update the v8 title if some concern here.

[1] https://www.kernel.org/doc/Documentation/filesystems/fiemap.txt

Thanks,
Gao Xiang

> what btrfs does correctly, it stores data in the btree.  But (like
> gfs2/ext4), it's only for the entire-file-is-small case, not for
> its-just-ten-bytes-into-the-last-block case.
> 
> So what would you call what erofs is doing if not tail-packing?
> Wikipedia calls it https://en.wikipedia.org/wiki/Block_suballocation
> which doesn't quite fit.  We need a phrase which means "this isn't
> just for small files but for small tails of large files".

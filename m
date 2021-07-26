Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE6743D5A4C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jul 2021 15:27:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233408AbhGZMrX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Jul 2021 08:47:23 -0400
Received: from verein.lst.de ([213.95.11.211]:45189 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232572AbhGZMrX (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Jul 2021 08:47:23 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 5A9F867373; Mon, 26 Jul 2021 15:27:49 +0200 (CEST)
Date:   Mon, 26 Jul 2021 15:27:49 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Andreas =?iso-8859-1?Q?Gr=FCnbacher?= 
        <andreas.gruenbacher@gmail.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Gao Xiang <hsiangkao@linux.alibaba.com>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Huang Jianan <huangjianan@oppo.com>,
        linux-erofs@lists.ozlabs.org,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v7] iomap: make inline data support more flexible
Message-ID: <20210726132749.GA6535@lst.de>
References: <CAHpGcMKZP8b3TbRv3D-pcrE_iDU5TKUFHst9emuQmRPntFSArA@mail.gmail.com> <CAHpGcMJBhWcwteLDSBU3hgwq1tk_+LqogM1ZM=Fv8U0VtY5hMg@mail.gmail.com> <20210723174131.180813-1-hsiangkao@linux.alibaba.com> <20210725221639.426565-1-agruenba@redhat.com> <YP4zUvnBCAb86Mny@B-P7TQMD6M-0146.local> <20210726110611.459173-1-agruenba@redhat.com> <20210726121702.GA528@lst.de> <CAHpGcMJhuSApy4eg9jKe2pYq4d7bY-Lg-Bmo9tOANghQ2Hxo-A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHpGcMJhuSApy4eg9jKe2pYq4d7bY-Lg-Bmo9tOANghQ2Hxo-A@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jul 26, 2021 at 02:27:12PM +0200, Andreas Grünbacher wrote:
> > That is how can size be different from iomap->length?
> 
> Quoting from my previous reply,
> 
> "In the iomap_readpage case (iomap_begin with flags == 0),
> iomap->length will be the amount of data up to the end of the inode.
> In the iomap_file_buffered_write case (iomap_begin with flags ==
> IOMAP_WRITE), iomap->length will be the size of iomap->inline_data.
> (For extending writes, we need to write beyond the current end of
> inode.) So iomap->length isn't all that useful for
> iomap_read_inline_data."

I think we should fix that now that we have the srcmap concept.
That is or IOMAP_WRITE|IOMAP_ZERO return the inline map as the soure
map, and return the actual block map we plan to write into as the
main iomap.

> 
> > Shouldn't the offset_in_page also go into iomap_inline_data_size_valid,
> > which should probably be called iomap_inline_data_valid then?
> 
> Hmm, not sure what you mean: iomap_inline_data_size_valid does take
> offset_in_page(iomap->inline_data) into account.

Indeed, orry for the braino.

> I thought people were okay with 80 character long lines?

No.

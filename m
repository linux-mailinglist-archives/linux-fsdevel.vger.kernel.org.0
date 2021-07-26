Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64EBF3D593F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jul 2021 14:17:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233829AbhGZLgh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Jul 2021 07:36:37 -0400
Received: from verein.lst.de ([213.95.11.211]:44953 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233713AbhGZLgg (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Jul 2021 07:36:36 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id DA9AA67373; Mon, 26 Jul 2021 14:17:02 +0200 (CEST)
Date:   Mon, 26 Jul 2021 14:17:02 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Andreas Gruenbacher <agruenba@redhat.com>
Cc:     Gao Xiang <hsiangkao@linux.alibaba.com>,
        Christoph Hellwig <hch@lst.de>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Huang Jianan <huangjianan@oppo.com>,
        linux-erofs@lists.ozlabs.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Andreas Gruenbacher <andreas.gruenbacher@gmail.com>
Subject: Re: [PATCH v7] iomap: make inline data support more flexible
Message-ID: <20210726121702.GA528@lst.de>
References: <CAHpGcMKZP8b3TbRv3D-pcrE_iDU5TKUFHst9emuQmRPntFSArA@mail.gmail.com> <CAHpGcMJBhWcwteLDSBU3hgwq1tk_+LqogM1ZM=Fv8U0VtY5hMg@mail.gmail.com> <20210723174131.180813-1-hsiangkao@linux.alibaba.com> <20210725221639.426565-1-agruenba@redhat.com> <YP4zUvnBCAb86Mny@B-P7TQMD6M-0146.local> <20210726110611.459173-1-agruenba@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210726110611.459173-1-agruenba@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> Subject: iomap: Support tail packing

I can't say I like this "tail packing" language here when we have the
perfectly fine inline wording.  Same for various comments in the actual
code.

> +	/* inline and tail-packed data must start page aligned in the file */
> +	if (WARN_ON_ONCE(offset_in_page(iomap->offset)))
> +		return -EIO;
> +	if (WARN_ON_ONCE(size > PAGE_SIZE - offset_in_page(iomap->inline_data)))
> +		return -EIO;

Why can't we use iomap_inline_data_size_valid here? That is how can
size be different from iomap->legth?

Shouldn't the offset_in_page also go into iomap_inline_data_size_valid,
which should probably be called iomap_inline_data_valid then?

>  	if (iomap->type == IOMAP_INLINE) {
> +		int ret = iomap_read_inline_data(inode, page, iomap);
> +		return ret ?: PAGE_SIZE;

The ?: expression without the first leg is really confuing.  Especially
if a good old if is much more readable here.

		int ret = iomap_read_inline_data(inode, page, iomap);

		if (ret)
			return ret;
		return PAGE_SIZE;

> +		copied = copy_from_iter(iomap_inline_data(iomap, pos), length, iter);


> +		copied = copy_to_iter(iomap_inline_data(iomap, pos), length, iter);

Pleae avoid the overly long lines.

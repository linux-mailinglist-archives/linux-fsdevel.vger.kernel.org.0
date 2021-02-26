Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD36E32604F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Feb 2021 10:42:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229482AbhBZJke (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 26 Feb 2021 04:40:34 -0500
Received: from mx2.suse.de ([195.135.220.15]:40552 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230001AbhBZJjd (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 26 Feb 2021 04:39:33 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id DAFDEAAAE;
        Fri, 26 Feb 2021 09:38:46 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id B3D69DA7FF; Fri, 26 Feb 2021 10:36:53 +0100 (CET)
Date:   Fri, 26 Feb 2021 10:36:53 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     dsterba@suse.cz, Neal Gompa <ngompa13@gmail.com>,
        Amy Parker <enbyamy@gmail.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: Adding LZ4 compression support to Btrfs
Message-ID: <20210226093653.GI7604@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Eric Biggers <ebiggers@kernel.org>,
        Neal Gompa <ngompa13@gmail.com>, Amy Parker <enbyamy@gmail.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
References: <CAE1WUT53F+xPT-Rt83EStGimQXKoU-rE+oYgcib87pjP4Sm0rw@mail.gmail.com>
 <CAEg-Je-Hs3+F9yshrW2MUmDNTaN-y6J-YxeQjneZx=zC5=58JA@mail.gmail.com>
 <20210225132647.GB7604@twin.jikos.cz>
 <YDfxkGkWnLEfsDwZ@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YDfxkGkWnLEfsDwZ@gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Feb 25, 2021 at 10:50:56AM -0800, Eric Biggers wrote:
> On Thu, Feb 25, 2021 at 02:26:47PM +0100, David Sterba wrote:
> > 
> > LZ4 support has been asked for so many times that it has it's own FAQ
> > entry:
> > https://btrfs.wiki.kernel.org/index.php/FAQ#Will_btrfs_support_LZ4.3F
> > 
> > The decompression speed is not the only thing that should be evaluated,
> > the way compression works in btrfs (in 4k blocks) does not allow good
> > compression ratios and overall LZ4 does not do much better than LZO. So
> > this is not worth the additional costs of compatibility. With ZSTD we
> > got the high compression and recently there have been added real-time
> > compression levels that we'll use in btrfs eventually.
> 
> When ZSTD support was being added to btrfs, it was claimed that btrfs compresses
> up to 128KB at a time
> (https://lore.kernel.org/r/5a7c09dd-3415-0c00-c0f2-a605a0656499@fb.com).
> So which is it -- 4KB or 128KB?

Logical extent ranges are sliced to 128K that are submitted to the
compression routine. Then, the whole range is fed by 4K (or more exactly
by page sized chunks) to the compression. Depending on the capabilities
of the compression algorithm, the 4K chunks are either independent or
can reuse some internal state of the algorithm.

LZO and LZ4 use some kind of embedded dictionary in the same buffer, and
references to that dictionary directly. Ie. assuming the whole input
range to be contiguous. Which is something that's not trivial to achive
in kernel because of pages that are not contiguous in general.

Thus, LZO and LZ4 compress 4K at a time, each chunk is independent. This
results in worse compression ratio because of less data reuse
possibilities. OTOH this allows decompression in place.

ZLIB and ZSTD can have a separate dictionary and don't need the input
chunks to be contiguous. This brings some additional overhead like
copying parts of the input to the dictionary and additional memory for
themporary structures, but with higher compression ratios.

IIRC the biggest problem for LZ4 was the cost of setting up each 4K
chunk, the work memory had to be zeroed. The size of the work memory is
tunable but trading off compression ratio. Either way it was either too
slow or too bad.

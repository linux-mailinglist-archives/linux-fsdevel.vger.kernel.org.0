Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1912325087
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Feb 2021 14:37:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233236AbhBYNbL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 25 Feb 2021 08:31:11 -0500
Received: from mx2.suse.de ([195.135.220.15]:49632 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229722AbhBYN3X (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 25 Feb 2021 08:29:23 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 42252AF6F;
        Thu, 25 Feb 2021 13:28:40 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 991F4DA790; Thu, 25 Feb 2021 14:26:47 +0100 (CET)
Date:   Thu, 25 Feb 2021 14:26:47 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Neal Gompa <ngompa13@gmail.com>
Cc:     Amy Parker <enbyamy@gmail.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: Adding LZ4 compression support to Btrfs
Message-ID: <20210225132647.GB7604@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Neal Gompa <ngompa13@gmail.com>,
        Amy Parker <enbyamy@gmail.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
References: <CAE1WUT53F+xPT-Rt83EStGimQXKoU-rE+oYgcib87pjP4Sm0rw@mail.gmail.com>
 <CAEg-Je-Hs3+F9yshrW2MUmDNTaN-y6J-YxeQjneZx=zC5=58JA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEg-Je-Hs3+F9yshrW2MUmDNTaN-y6J-YxeQjneZx=zC5=58JA@mail.gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Feb 25, 2021 at 08:18:53AM -0500, Neal Gompa wrote:
> On Wed, Feb 24, 2021 at 11:10 PM Amy Parker <enbyamy@gmail.com> wrote:
> >
> > The compression options in Btrfs are great, and help save a ton of
> > space on disk. Zstandard works extremely well for this, and is fairly
> > fast. However, it can heavily reduce the speed of quick disks, does
> > not work well on lower-end systems, and does not scale well across
> > multiple cores. Zlib is even slower and worse on compression ratio,
> > and LZO suffers on both the compression ratio and speed.
> >
> > I've been laying out my plans for a backup software recently, and
> > stumbled upon LZ4. Tends to hover around LZO compression ratios.
> > Performs better than Zstandard and LZO slightly for compression - but
> > significantly outpaces them on decompression, which matters
> > significantly more for users:
> >
> > zstd 1.4.5:
> >  - ratio 2.884
> >  - compression 500 MiB/s
> >  - decompression 1.66 GiB/s
> > zlib 1.2.11:
> >  - ratio 2.743
> >  - compression 90 MiB/s
> >  - decompression 400 MiB/s
> > lzo 2.10:
> >  - ratio 2.106
> >  - compression 690 MiB/s
> >  - decompression 820 MiB/s
> > lz4 1.9.2:
> >  - ratio 2.101
> >  - compression 740 MiB/s
> >  - decompression 4.5 GiB/s
> >
> > LZ4's speeds are high enough to allow many applications which
> > previously declined to use any compression due to speed to increase
> > their possible space while keeping fast write and especially read
> > access.
> >
> > What're thoughts like on adding something like LZ4 as a compression
> > option in btrfs? Is it feasible given the current implementation of
> > compression in btrfs?
> 
> This is definitely possible. I think the only reason lz4 isn't enabled
> for Btrfs has been the lack of interest in it. I'd defer to some of
> the kernel folks (I'm just a user and integrator myself), but I think
> that's definitely worth having lz4 compression supported.

LZ4 support has been asked for so many times that it has it's own FAQ
entry:
https://btrfs.wiki.kernel.org/index.php/FAQ#Will_btrfs_support_LZ4.3F

The decompression speed is not the only thing that should be evaluated,
the way compression works in btrfs (in 4k blocks) does not allow good
compression ratios and overall LZ4 does not do much better than LZO. So
this is not worth the additional costs of compatibility. With ZSTD we
got the high compression and recently there have been added real-time
compression levels that we'll use in btrfs eventually.

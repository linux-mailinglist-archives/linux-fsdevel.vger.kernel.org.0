Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46A413263E4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Feb 2021 15:15:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229864AbhBZOOk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 26 Feb 2021 09:14:40 -0500
Received: from mx2.suse.de ([195.135.220.15]:37466 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229545AbhBZOOi (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 26 Feb 2021 09:14:38 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 5FC9DAD57;
        Fri, 26 Feb 2021 14:13:56 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 22658DA7FF; Fri, 26 Feb 2021 15:12:03 +0100 (CET)
Date:   Fri, 26 Feb 2021 15:12:03 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Gao Xiang <hsiangkao@redhat.com>
Cc:     Eric Biggers <ebiggers@kernel.org>,
        Neal Gompa <ngompa13@gmail.com>,
        Amy Parker <enbyamy@gmail.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: Adding LZ4 compression support to Btrfs
Message-ID: <20210226141203.GJ7604@suse.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Gao Xiang <hsiangkao@redhat.com>,
        Eric Biggers <ebiggers@kernel.org>, Neal Gompa <ngompa13@gmail.com>,
        Amy Parker <enbyamy@gmail.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
References: <CAE1WUT53F+xPT-Rt83EStGimQXKoU-rE+oYgcib87pjP4Sm0rw@mail.gmail.com>
 <CAEg-Je-Hs3+F9yshrW2MUmDNTaN-y6J-YxeQjneZx=zC5=58JA@mail.gmail.com>
 <20210225132647.GB7604@twin.jikos.cz>
 <YDfxkGkWnLEfsDwZ@gmail.com>
 <20210226093653.GI7604@twin.jikos.cz>
 <20210226112854.GA1890271@xiangao.remote.csb>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210226112854.GA1890271@xiangao.remote.csb>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Feb 26, 2021 at 07:28:54PM +0800, Gao Xiang wrote:
> On Fri, Feb 26, 2021 at 10:36:53AM +0100, David Sterba wrote:
> > On Thu, Feb 25, 2021 at 10:50:56AM -0800, Eric Biggers wrote:
> > 
> > ZLIB and ZSTD can have a separate dictionary and don't need the input
> > chunks to be contiguous. This brings some additional overhead like
> > copying parts of the input to the dictionary and additional memory for
> > themporary structures, but with higher compression ratios.
> > 
> > IIRC the biggest problem for LZ4 was the cost of setting up each 4K
> > chunk, the work memory had to be zeroed. The size of the work memory is
> > tunable but trading off compression ratio. Either way it was either too
> > slow or too bad.
> 
> May I ask why LZ4 needs to zero the work memory (if you mean dest
> buffer and LZ4_decompress_safe), just out of curiousity... I didn't
> see that restriction before. Thanks!

Not the destination buffer, but the work memory or state as it can be
also called. This is from my initial interest in lz4 in 2012 and I got
that from Yann himself.  There was a tradeoff to either expect zeroed
work memory or add more conditionals.

At time he got some benchmark result and the conditionals came out
worse. And I see the memset is still there (see below) so there's been
no change.

For example in f2fs sources there is:
lz4_compress_pages
  LZ4_compress_default (cc->private is the work memory)
    LZ4_compress_fast
      LZ4_compress_fast_extState
        LZ4_resetStream
	  memset

Where the state size LZ4_MEM_COMPRESS is hidden in the maze od defines

#define LZ4_MEM_COMPRESS	LZ4_STREAMSIZE
#define LZ4_STREAMSIZE	(LZ4_STREAMSIZE_U64 * sizeof(unsigned long long))
#define LZ4_STREAMSIZE_U64 ((1 << (LZ4_MEMORY_USAGE - 3)) + 4)
/*
 * LZ4_MEMORY_USAGE :
 * Memory usage formula : N->2^N Bytes
 * (examples : 10 -> 1KB; 12 -> 4KB ; 16 -> 64KB; 20 -> 1MB; etc.)
 * Increasing memory usage improves compression ratio
 * Reduced memory usage can improve speed, due to cache effect
 * Default value is 14, for 16KB, which nicely fits into Intel x86 L1 cache
 */
#define LZ4_MEMORY_USAGE 14

So it's 16K by default in linux. Now imagine doing memset(16K) just to
compress 4K, and do that 32 times to compress the whole 128K chunk.
That's not a negligible overhead.

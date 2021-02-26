Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDF7B32642E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Feb 2021 15:38:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230206AbhBZOg6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 26 Feb 2021 09:36:58 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:36882 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230185AbhBZOgv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 26 Feb 2021 09:36:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1614350124;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Z0UEtT1xxQkq7jvE/gzRGeVwRilrSoAFuOXJwma7YY8=;
        b=etoK10LAOgK2w8gjhaGOUncPfrUMZPMvGzn05ARCkcwTWZxd15ed25I8PmJ5P6gUxDL+6F
        hEK6mBuJDfISnvNuCeFBAgP7hmcjtO0VfUzICU/pJ/ZrUHa2gi/r2K1OZl7+IfCChhnS9H
        talKWFqaELStG4Fdd+b9P+Md30cbMxY=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-382-tWTZRs85MwayEL6ChFYonQ-1; Fri, 26 Feb 2021 09:35:22 -0500
X-MC-Unique: tWTZRs85MwayEL6ChFYonQ-1
Received: by mail-pg1-f197.google.com with SMTP id y26so6222445pga.10
        for <linux-fsdevel@vger.kernel.org>; Fri, 26 Feb 2021 06:35:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Z0UEtT1xxQkq7jvE/gzRGeVwRilrSoAFuOXJwma7YY8=;
        b=G/yL76/lCxJNThMe8MGVz7ZQHy6oOd3wn+lAh35EX29m5JIVxZkr7n1cUl2/L5OH5z
         o566eJukqwM4axlRUpHfrlCqVGQf7Re/qlvoGQwG0bRt44m7UZJXRy6y1bA7kakQPRcX
         fgZmxNlnh8dWuXA0EkCttu/vaSKB79tHIKq1QuOqX9z5tSM8fM77Sc3GR2s75ILOleIr
         9wWGfiu1jiBzF43dJB9Aj3w1sZ1qggSp3o4MxtgL5jvOExF54ihBqbpgnCdrqI6/bLlZ
         X1q49s/my+QSNbefy4s31KpQEh4SfyYJYshUav1VIjYXss3EaSASPhHPymib5tkRB4Tm
         jTGg==
X-Gm-Message-State: AOAM532AmjYAtKU8n9YMlUX63Qnun61sLjs+9mwp7EVKsmNrKCbKBEYW
        nuYCdZKu8t6N0BCYrbE0YmwWN1giEhqp4PhG/iX/C1mM3xdk5uRv43VrNhtZmEJOYJFbfn+60lL
        Knw2OC+BCre22cmOof1rFR2UssA==
X-Received: by 2002:a62:f20d:0:b029:1ed:c019:50dd with SMTP id m13-20020a62f20d0000b02901edc01950ddmr3385496pfh.67.1614350121166;
        Fri, 26 Feb 2021 06:35:21 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyMynrqUTTph41HDFIDaheM+7S9T9q1nsHtcWBLAs8KHu2yOGmotRO54ulaXZnxVWr0b73oXg==
X-Received: by 2002:a62:f20d:0:b029:1ed:c019:50dd with SMTP id m13-20020a62f20d0000b02901edc01950ddmr3385474pfh.67.1614350120769;
        Fri, 26 Feb 2021 06:35:20 -0800 (PST)
Received: from xiangao.remote.csb ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id w6sm10132555pfj.190.2021.02.26.06.35.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Feb 2021 06:35:20 -0800 (PST)
Date:   Fri, 26 Feb 2021 22:35:09 +0800
From:   Gao Xiang <hsiangkao@redhat.com>
To:     dsterba@suse.cz
Cc:     Eric Biggers <ebiggers@kernel.org>,
        Neal Gompa <ngompa13@gmail.com>,
        Amy Parker <enbyamy@gmail.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: Adding LZ4 compression support to Btrfs
Message-ID: <20210226143509.GB1905816@xiangao.remote.csb>
References: <CAE1WUT53F+xPT-Rt83EStGimQXKoU-rE+oYgcib87pjP4Sm0rw@mail.gmail.com>
 <CAEg-Je-Hs3+F9yshrW2MUmDNTaN-y6J-YxeQjneZx=zC5=58JA@mail.gmail.com>
 <20210225132647.GB7604@twin.jikos.cz>
 <YDfxkGkWnLEfsDwZ@gmail.com>
 <20210226093653.GI7604@twin.jikos.cz>
 <20210226112854.GA1890271@xiangao.remote.csb>
 <20210226141203.GJ7604@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210226141203.GJ7604@suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi David,

On Fri, Feb 26, 2021 at 03:12:03PM +0100, David Sterba wrote:
> On Fri, Feb 26, 2021 at 07:28:54PM +0800, Gao Xiang wrote:
> > On Fri, Feb 26, 2021 at 10:36:53AM +0100, David Sterba wrote:
> > > On Thu, Feb 25, 2021 at 10:50:56AM -0800, Eric Biggers wrote:
> > > 
> > > ZLIB and ZSTD can have a separate dictionary and don't need the input
> > > chunks to be contiguous. This brings some additional overhead like
> > > copying parts of the input to the dictionary and additional memory for
> > > themporary structures, but with higher compression ratios.
> > > 
> > > IIRC the biggest problem for LZ4 was the cost of setting up each 4K
> > > chunk, the work memory had to be zeroed. The size of the work memory is
> > > tunable but trading off compression ratio. Either way it was either too
> > > slow or too bad.
> > 
> > May I ask why LZ4 needs to zero the work memory (if you mean dest
> > buffer and LZ4_decompress_safe), just out of curiousity... I didn't
> > see that restriction before. Thanks!
> 
> Not the destination buffer, but the work memory or state as it can be
> also called. This is from my initial interest in lz4 in 2012 and I got
> that from Yann himself.  There was a tradeoff to either expect zeroed
> work memory or add more conditionals.
> 
> At time he got some benchmark result and the conditionals came out
> worse. And I see the memset is still there (see below) so there's been
> no change.
> 
> For example in f2fs sources there is:
> lz4_compress_pages
>   LZ4_compress_default (cc->private is the work memory)
>     LZ4_compress_fast
>       LZ4_compress_fast_extState
>         LZ4_resetStream
> 	  memset
> 
> Where the state size LZ4_MEM_COMPRESS is hidden in the maze od defines
> 
> #define LZ4_MEM_COMPRESS	LZ4_STREAMSIZE
> #define LZ4_STREAMSIZE	(LZ4_STREAMSIZE_U64 * sizeof(unsigned long long))
> #define LZ4_STREAMSIZE_U64 ((1 << (LZ4_MEMORY_USAGE - 3)) + 4)
> /*
>  * LZ4_MEMORY_USAGE :
>  * Memory usage formula : N->2^N Bytes
>  * (examples : 10 -> 1KB; 12 -> 4KB ; 16 -> 64KB; 20 -> 1MB; etc.)
>  * Increasing memory usage improves compression ratio
>  * Reduced memory usage can improve speed, due to cache effect
>  * Default value is 14, for 16KB, which nicely fits into Intel x86 L1 cache
>  */
> #define LZ4_MEMORY_USAGE 14
> 
> So it's 16K by default in linux. Now imagine doing memset(16K) just to
> compress 4K, and do that 32 times to compress the whole 128K chunk.
> That's not a negligible overhead.

Ok, thanks for your reply & info. I get the concern now. That is mainly a
internal HASHTABLE for LZ4 matchfinder (most LZ algs use hash table as a way
to find a previous match) to get len-distance pair from history sliding
window. I just did a quick glance, If I understand correctly, I think LZO
has a similiar table (yet not quite sure since I don't looked into that
much), see:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/lib/lzo/lzodefs.h#n68
#define D_BITS		13
#define D_SIZE		(1u << D_BITS)

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/lib/lzo/lzo1x_compress.c#n108
t = ((dv * 0x1824429d) >> (32 - D_BITS)) & D_MASK;
m_pos = in + dict[t];
dict[t] = (lzo_dict_t) (ip - in);
if (unlikely(dv != get_unaligned_le32(m_pos)))
	goto literal;

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/lib/lzo/lzo1x_compress.c#n334
memset(wrkmem, 0, D_SIZE * sizeof(lzo_dict_t));

LZO uses 13 but LZ4 uses 14, so in principle less collision. But it can
be tunable especially considering btrfs 4kb fixed-sized input compression,
it seems double memset though (16kb vs 8kb)..

Thanks,
Gao Xiang

> 


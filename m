Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B85E701F0B
	for <lists+linux-fsdevel@lfdr.de>; Sun, 14 May 2023 20:43:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232685AbjENSnc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 14 May 2023 14:43:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbjENSna (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 14 May 2023 14:43:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E30921BD3;
        Sun, 14 May 2023 11:43:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7D73760C90;
        Sun, 14 May 2023 18:43:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92277C433EF;
        Sun, 14 May 2023 18:43:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684089807;
        bh=Ml1D73OgB6a09DYGjURU+FXwDDBxN+djnvR7hyV+9F0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=A2U/h4UC1lJ+/+TsINJXlcGGXwM2KWKtn7CtMQSjOIVu+yQ/6t6hjWIaG/FAweri7
         H2RRMav2LKvE+bBx7gW8jBfiJkzwlJ90LQaBX/3CgXwqVL0NHYOB9FJ+q2ylSqt4c9
         +gTlsaj0svT4NGEIKuwVXXrX1hlgjl7MFr7debe3zFqLm5JmQ4oPbHZc+W5y62XAlu
         6xX8TwUME2Dcokfpp9+5m5ozGSPIN8Gb5l0+8nXWEtgykcTCwMqwKcaCNE9CsUXZx4
         nCMgUqNWxyUjChh6D4N9/5G/5ocXTte/QVnvsmqYBgZa1PmHoNpFUHl0XyQAMajrrY
         sdCAr9023sF2w==
Date:   Sun, 14 May 2023 11:43:25 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Kent Overstreet <kent.overstreet@linux.dev>
Cc:     Lorenzo Stoakes <lstoakes@gmail.com>,
        Christoph Hellwig <hch@infradead.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-bcachefs@vger.kernel.org,
        Kent Overstreet <kent.overstreet@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Uladzislau Rezki <urezki@gmail.com>, linux-mm@kvack.org
Subject: Re: [PATCH 07/32] mm: Bring back vmalloc_exec
Message-ID: <20230514184325.GB9528@sol.localdomain>
References: <20230509165657.1735798-1-kent.overstreet@linux.dev>
 <20230509165657.1735798-8-kent.overstreet@linux.dev>
 <ZFqxEWqD19eHe353@infradead.org>
 <ZFq3SdSBJ_LWsOgd@murray>
 <ZFq7JhrhyrMTNfd/@moria.home.lan>
 <20230510064849.GC1851@quark.localdomain>
 <ZF6HHRDeUWLNtuL7@moria.home.lan>
 <20230513015752.GC3033@quark.localdomain>
 <ZGB1eevk/u2ssIBT@moria.home.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZGB1eevk/u2ssIBT@moria.home.lan>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, May 14, 2023 at 01:45:29AM -0400, Kent Overstreet wrote:
> On Fri, May 12, 2023 at 06:57:52PM -0700, Eric Biggers wrote:
> > First, I wanted to mention that decoding of variable-length fields has been
> > extensively studied for decompression algorithms, e.g. for Huffman decoding.
> > And it turns out that it can be done branchlessly.  The basic idea is that you
> > have a branchless refill step that looks like the following:
> > 
> > #define REFILL_BITS_BRANCHLESS()                    \
> >         bitbuf |= get_unaligned_u64(p) << bitsleft; \
> >         p += 7 - ((bitsleft >> 3) & 0x7);           \
> >         bitsleft |= 56;
> > 
> > That branchlessly ensures that 'bitbuf' contains '56 <= bitsleft <= 63' bits.
> > Then, the needed number of bits can be removed and returned:
> > 
> > #define READ_BITS(n)                          \
> >         REFILL_BITS_BRANCHLESS();             \
> >         tmp = bitbuf & (((u64)1 << (n)) - 1); \
> >         bitbuf >>= (n);                       \
> >         bitsleft -= (n);                      \
> >         tmp
> > 
> > If you're interested, I can give you some references about the above method.
> 
> I might be interested in those references, new bit tricks and integer
> encodings are always fun :)

There are some good blog posts by Fabian Giese:

* https://fgiesen.wordpress.com/2018/02/19/reading-bits-in-far-too-many-ways-part-1/
* https://fgiesen.wordpress.com/2018/02/20/reading-bits-in-far-too-many-ways-part-2/
* https://fgiesen.wordpress.com/2018/09/27/reading-bits-in-far-too-many-ways-part-3/

And the examples I gave above are basically what I use in libdeflate:
https://github.com/ebiggers/libdeflate/blob/master/lib/deflate_decompress.c

> > But, I really just wanted to mention it for completeness, since I think you'd
> > actually want to go in a slightly different direction, since (a) you have all
> > the field widths available from the beginning, as opposed to being interleaved
> > into the bitstream itself (as is the case in Huffman decoding for example), so
> > you're not limited to serialized decoding of each field, (b) your fields are up
> > to 96 bits, and (c) you've selected a bitstream convention that seems to make it
> > such that your stream *must* be read in aligned units of u64, so I don't think
> > something like REFILL_BITS_BRANCHLESS() could work for you anyway.
> > 
> > What I would suggest instead is preprocessing the list of 6 field lengths to
> > create some information that can be used to extract all 6 fields branchlessly
> > with no dependencies between different fields.  (And you clearly *can* add a
> > preprocessing step, as you already have one -- the dynamic code generator.)
> > 
> > So, something like the following:
> > 
> >     const struct field_info *info = &format->fields[0];
> > 
> >     field0 = (in->u64s[info->word_idx] >> info->shift1) & info->mask;
> >     field0 |= in->u64s[info->word_idx - 1] >> info->shift2;
> > 
> > ... but with the code for all 6 fields interleaved.
> > 
> > On modern CPUs, I think that would be faster than your current C code.
> > 
> > You could do better by creating variants that are specialized for specific
> > common sets of parameters.  During "preprocessing", you would select a variant
> > and set an enum accordingly.  During decoding, you would switch on that enum and
> > call the appropriate variant.  (This could also be done with a function pointer,
> > of course, but indirect calls are slow these days...)
> 
> testing random btree updates:
> 
> dynamically generated unpack:
> rand_insert: 20.0 MiB with 1 threads in    33 sec,  1609 nsec per iter, 607 KiB per sec
> 
> old C unpack:
> rand_insert: 20.0 MiB with 1 threads in    35 sec,  1672 nsec per iter, 584 KiB per sec
> 
> the Eric Biggers special:
> rand_insert: 20.0 MiB with 1 threads in    35 sec,  1676 nsec per iter, 583 KiB per sec
> 
> Tested two versions of your approach, one without a shift value, one
> where we use a shift value to try to avoid unaligned access - second was
> perhaps 1% faster
> 
> so it's not looking good. This benchmark doesn't even hit on
> unpack_key() quite as much as I thought, so the difference is
> significant.
> 
> diff --git a/fs/bcachefs/bkey.c b/fs/bcachefs/bkey.c

I don't know what this patch applies to, so I can't properly review it.

I suggest checking the assembly and making sure it is what is expected.

In general, for this type of thing it's also helpful to put together a userspace
micro-benchmark program so that it's very fast to evaluate different options.
Building and booting a kernel and doing some I/O benchmark on a bcachefs sounds
much more time consuming and less precise.

> -struct bkey __bch2_bkey_unpack_key(const struct bkey_format_processed *format_p,
> +struct bkey __bch2_bkey_unpack_key(const struct bkey_format_processed *format,
>  				   const struct bkey_packed *in)
>  {
> -	const struct bkey_format *format = &format_p->f;
> -	struct unpack_state state = unpack_state_init(format, in);
>  	struct bkey out;
>  
> -	EBUG_ON(format->nr_fields != BKEY_NR_FIELDS);
> -	EBUG_ON(in->u64s < format->key_u64s);
> +	EBUG_ON(format->f.nr_fields != BKEY_NR_FIELDS);
> +	EBUG_ON(in->u64s < format->f.key_u64s);
>  	EBUG_ON(in->format != KEY_FORMAT_LOCAL_BTREE);
> -	EBUG_ON(in->u64s - format->key_u64s + BKEY_U64s > U8_MAX);
> +	EBUG_ON(in->u64s - format->f.key_u64s + BKEY_U64s > U8_MAX);
>  
> -	out.u64s	= BKEY_U64s + in->u64s - format->key_u64s;
> +	out.u64s	= BKEY_U64s + in->u64s - format->f.key_u64s;
>  	out.format	= KEY_FORMAT_CURRENT;
>  	out.needs_whiteout = in->needs_whiteout;
>  	out.type	= in->type;
>  	out.pad[0]	= 0;
>  
> +	if (likely(format->aligned)) {
> +#define x(id, field)	out.field = get_aligned_field(format, in, id);
> +		bkey_fields()
> +#undef x
> +	} else {
> +		struct unpack_state state = unpack_state_init(&format->f, in);
> +
>  #define x(id, field)	out.field = get_inc_field(&state, id);
> -	bkey_fields()
> +		bkey_fields()
>  #undef x
> +	}

It looks like you didn't change the !aligned case.  How often is the 'aligned'
case taken?

I think it would also help if the generated assembly had the handling of the
fields interleaved.  To achieve that, it might be necessary to interleave the C
code.

- Eric

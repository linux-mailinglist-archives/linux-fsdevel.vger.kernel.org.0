Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 865FE7AC4DA
	for <lists+linux-fsdevel@lfdr.de>; Sat, 23 Sep 2023 21:31:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229564AbjIWTbJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 23 Sep 2023 15:31:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbjIWTbI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 23 Sep 2023 15:31:08 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35EB7196
        for <linux-fsdevel@vger.kernel.org>; Sat, 23 Sep 2023 12:31:00 -0700 (PDT)
Received: from letrec.thunk.org (c-73-8-226-230.hsd1.il.comcast.net [73.8.226.230])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 38NJUgVM032361
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 23 Sep 2023 15:30:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1695497445; bh=KDFc9Ol/EE4RqD0zI5Zpzlegr8hS7WyFmPJjMKXneoc=;
        h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
        b=AX+5gB1KNdF6ofn0VcwbFPgwhMQ4RCjr/KzTwhuKLSy8sCDHKxVLa+3UnZ5Kz37+k
         NnE4UYGFuE/l+yuJ5JT1/9Bz11ogR51H+20nq1CUn7liPK1qOwFDfgzaDV4UXNCKsK
         NDq9U3kD3BzssvQPk5QRyp5w+gQfH+YGML2M8jT5qTNc4vRq5ZNbAiIzceV2v2gmzE
         ZkoLWA2cAhgE3kmcHSbv0gW61r8XOGsVWIRHged9k+qIRm0M5ZfAU9+NNPnspi3V5J
         GQ5ucDzKY8cYLG1aOLqPvUpXQmL5CSCBzw6JFR6fG/lwyZV02rP7w9SnsU2Eo744GR
         lEC3ogs/nYBgw==
Received: by letrec.thunk.org (Postfix, from userid 15806)
        id 1BC5E8C036B; Sat, 23 Sep 2023 15:30:42 -0400 (EDT)
Date:   Sat, 23 Sep 2023 15:30:42 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Amir Goldstein <amir73il@gmail.com>,
        Jeff Layton <jlayton@kernel.org>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jan Kara <jack@suse.cz>, "Darrick J. Wong" <djwong@kernel.org>
Subject: Re: [GIT PULL v2] timestamp fixes
Message-ID: <ZQ884uCkKGu6xsDi@mit.edu>
References: <20230921-umgekehrt-buden-a8718451ef7c@brauner>
 <CAHk-=wgoNW9QmEzhJR7C1_vKWKr=8JoD4b7idQDNHOa10P_i4g@mail.gmail.com>
 <0d006954b698cb1cea3a93c1662b5913a0ded3b1.camel@kernel.org>
 <CAHk-=whAwTJduUZTrsLFnj1creZMfO7eCNERHXZQmzX+qLqZMA@mail.gmail.com>
 <CAOQ4uxjcyfhfRhgR97wqsJHwzyOYqOYaaZWMWWCGXu5MWtKXfQ@mail.gmail.com>
 <CAHk-=wjGJEgizkXwSWVCnsGnciCKHHsWg+dkw2XAhM+0Tnd0Jw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wjGJEgizkXwSWVCnsGnciCKHHsWg+dkw2XAhM+0Tnd0Jw@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Sep 23, 2023 at 10:48:51AM -0700, Linus Torvalds wrote:
> 
> I feel like 100ns is a much more reasonable resolution, and is quite
> close to a single system call (think "one thousand cycles at 10GHz").

FWIW, UUID's (which originally came from Apollo Domain/OS in the
1980's, before getting adopted by OSF/DCE, and then by Linux and
Microsoft) use a 100ns granularity.  And the smart folks at Apollo
figured this out some 4 decades ago, and *no* they didn't use units of
a single nanosecond.  :-)

100ns granularity is also what what ext4 uses for our on-disk format
--- 2**30 just enough to cover 100ns granularity (with only 7% of
wasted number space), and those two bits are enough for us to encode
timestamps into 2446 using a 64-bit timestamp (and what we do past
2446 is pretty much something I'm happy to let someone else deal with,
as I expect I'll be long dead by then.)

(And if someone does happen to event some kind of life-extension
technology, I'm happy to fix it up... later.  :-)

> That said, we don't have to do powers-of-ten. In fact, in many ways,
> it would probably be a good idea to think of the fractional seconds in
> powers of two. That tends to make it cheaper to do conversions,
> without having to do a full 64-bit divide (a constant divide turns
> into a fancy multiply, but it's still painful on 32-bit
> architectures).

It depends on what conversion we need to do.  If we're converting to
userspace's timespec64 data structure, which is denominated in
nanosecods, it's actually much easier to use decimal 100ns units:

#define EXT4_EPOCH_BITS 2
#define EXT4_EPOCH_MASK ((1 << EXT4_EPOCH_BITS) - 1)
#define EXT4_NSEC_MASK  (~0UL << EXT4_EPOCH_BITS)

static inline __le32 ext4_encode_extra_time(struct timespec64 *time)
{
	u32 extra =((time->tv_sec - (s32)time->tv_sec) >> 32) & EXT4_EPOCH_MASK;
	return cpu_to_le32(extra | (time->tv_nsec << EXT4_EPOCH_BITS));
}

static inline void ext4_decode_extra_time(struct timespec64 *time,
					  __le32 extra)
{
	if (unlikely(extra & cpu_to_le32(EXT4_EPOCH_MASK)))
		time->tv_sec += (u64)(le32_to_cpu(extra) & EXT4_EPOCH_MASK) << 32;
	time->tv_nsec = (le32_to_cpu(extra) & EXT4_NSEC_MASK) >> EXT4_EPOCH_BITS;
}

> Of course, I might have screwed up the above conversion functions,
> they are untested garbage, but they look close enough to being in the
> right ballpark.

We actually have kunit tests for ext4_encode_extra_time() and
ext4_decode_extra_time(), mainly because people *have* screwed it up
when making architecture-specific optimizations or when making global
sweeps of VFS code.  :-)

     	    		     	    	      	  - Ted

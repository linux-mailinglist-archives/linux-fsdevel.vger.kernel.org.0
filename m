Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B9366FEB3A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 May 2023 07:34:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236172AbjEKFeB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 11 May 2023 01:34:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230267AbjEKFeA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 11 May 2023 01:34:00 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E73ED1BE
        for <linux-fsdevel@vger.kernel.org>; Wed, 10 May 2023 22:33:58 -0700 (PDT)
Received: from letrec.thunk.org (h64-141-80-140.bigpipeinc.com [64.141.80.140] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 34B5XEbN029523
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 11 May 2023 01:33:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1683783198; bh=SMmV3TzaqHRTrXH6Q0nofDnJqnbSzTYjFsEZvKZ4z+8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=j0HanOY4jf1J54zi0i0lwYZmgLq0/Ss5ILpuFT7MZBXheoGDM4ZR4KhI9GTbErwmm
         McYjxSg24VdxTJnvNpHfEOgY7MxjKA3ibaqz/9XLwbTrl/s6PygVJHF9OhxcSz2l+8
         F4YqJEo2S5W9FnEmozQRSmKmBkYYZpS38T4Axq5yZpBG18V29DOCHbb6X+Hn0z9ZpS
         muw7Xmf+h2N8tt0ncXZ2V2IWwR8ZMBzFl4SpUAQwZOo5z3xa6FFkkcQE9LbtNuwa5X
         2NyR3pQFe+1v43HP2jRX4X9XZKOswe2fS4BeCA8H0Nm/kVPADxGSmXjDJf4uhiVHDV
         Zu7MvmI+YvVHw==
Received: by letrec.thunk.org (Postfix, from userid 15806)
        id 478D28C023E; Thu, 11 May 2023 01:33:12 -0400 (EDT)
Date:   Thu, 11 May 2023 01:33:12 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Kent Overstreet <kent.overstreet@linux.dev>
Cc:     "Darrick J. Wong" <djwong@kernel.org>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Christoph Hellwig <hch@infradead.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-bcachefs@vger.kernel.org,
        Kent Overstreet <kent.overstreet@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Uladzislau Rezki <urezki@gmail.com>, linux-mm@kvack.org
Subject: Re: [PATCH 07/32] mm: Bring back vmalloc_exec
Message-ID: <ZFx+GOjabJIaJWU8@mit.edu>
References: <20230509165657.1735798-1-kent.overstreet@linux.dev>
 <20230509165657.1735798-8-kent.overstreet@linux.dev>
 <ZFqxEWqD19eHe353@infradead.org>
 <ZFq3SdSBJ_LWsOgd@murray>
 <20230509214319.GA858791@frogsfrogsfrogs>
 <ZFrBEsjrfseCUzqV@moria.home.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZFrBEsjrfseCUzqV@moria.home.lan>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, May 09, 2023 at 05:54:26PM -0400, Kent Overstreet wrote:
> 
> I think it'd be much more practical to find some way of making
> vmalloc_exec() more palatable. What are the exact concerns?

Having a vmalloc_exec() function (whether it is not exported at all,
or exported as a GPL symbol) makes it *much* easier for an exploit
writer, since it's a super convenient gadget for use with
Returned-oriented-programming[1] to create a writeable, executable
space that could then be filled with arbitrary code of the exploit
author's arbitrary desire.

[1] https://en.wikipedia.org/wiki/Return-oriented_programming

The other thing I'll note from examining the code generator, is that
it appears that bcachefs *only* has support for x86_64.  This brings
me back to the days of my youth when all the world was a Vax[2].  :-)

   10.  Thou shalt foreswear, renounce, and abjure the vile heresy
        which claimeth that ``All the world's a VAX'', and have no commerce
	with the benighted heathens who cling to this barbarous belief, that
 	the days of thy program may be long even though the days of thy
	current machine be short.

	[ This particular heresy bids fair to be replaced by ``All the
	world's a Sun'' or ``All the world's a 386'' (this latter
	being a particularly revolting invention of Satan), but the
	words apply to all such without limitation. Beware, in
	particular, of the subtle and terrible ``All the world's a
	32-bit machine'', which is almost true today but shall cease
	to be so before thy resume grows too much longer.]

[2] The Ten Commandments for C Programmers (Annotated Edition)
    https://www.lysator.liu.se/c/ten-commandments.html

Seriously, does this mean that bcachefs won't work on Arm systems
(arm32 or arm64)?  Or Risc V systems?  Or S/390's?  Or Power
architectuers?  Or Itanium or PA-RISC systems?  (OK, I really don't
care all that much about those last two.  :-)


When people ask me why file systems are so hard to make enterprise
ready, I tell them to recall the general advice given to people to
write secure, robust systems: (a) avoid premature optimization, (b)
avoid fine-grained, multi-threaded programming, as much as possible,
because locking bugs are a b*tch, and (c) avoid unnecessary global
state as much as possible.

File systems tend to violate all of these precepts: (a) people chase
benchmark optimizations to the exclusion of all else, because people
have an unhealthy obsession with Phornix benchmark articles, (b) file
systems tend to be inherently multi-threaded, with lots of locks, and
(c) file systems are all about managing global state in the form of
files, directories, etc.

However, hiding a miniature architecture-specific compiler inside a
file system seems to be a rather blatent example of "premature
optimization".

							- Ted

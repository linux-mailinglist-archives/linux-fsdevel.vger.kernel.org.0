Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E41AC7AC5A6
	for <lists+linux-fsdevel@lfdr.de>; Sun, 24 Sep 2023 00:08:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229687AbjIWWIW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 23 Sep 2023 18:08:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229664AbjIWWIV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 23 Sep 2023 18:08:21 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F464180
        for <linux-fsdevel@vger.kernel.org>; Sat, 23 Sep 2023 15:08:14 -0700 (PDT)
Received: from letrec.thunk.org (c-73-8-226-230.hsd1.il.comcast.net [73.8.226.230])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 38NM7v7G019349
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 23 Sep 2023 18:07:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1695506880; bh=WPgIP1OKYXQhlTobK38qEKfYwfANAfvfSRRokPueeS0=;
        h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
        b=hzZYHkdvm1g6SCrimbPLQhA0UE+ZuN05WGB3bG69RPPvHd0Z2JUUAlztL3I2wJI3v
         q30dmen2hOaqJ/zxtNpLWLiI33zRxh7yysAb2lXPMmNuKHsLNMbEoWxnFJg8f7MJfD
         QBSiiOQoeAY/+4oKarvEXeXwlhs5KAwgIiXlur4rMWAef3Qx39BKX9uq/fBA/bbjF/
         Sl5gQgKAK8i+6dAvmeVFQsmqQYiRSuTRgm1QJMG0oLP6WdXO1izwpHPApjM234O3n7
         c3KLUfRsmIEqmCCzXInYF1HPQ2WoMhB+Zdz2LAGkGsA4yJSuPoh6gLnnCBeiilV9+K
         qphnN8CulWdug==
Received: by letrec.thunk.org (Postfix, from userid 15806)
        id 18C0A8C036B; Sat, 23 Sep 2023 18:07:57 -0400 (EDT)
Date:   Sat, 23 Sep 2023 18:07:57 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Amir Goldstein <amir73il@gmail.com>,
        Jeff Layton <jlayton@kernel.org>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jan Kara <jack@suse.cz>, "Darrick J. Wong" <djwong@kernel.org>
Subject: Re: [GIT PULL v2] timestamp fixes
Message-ID: <ZQ9hvS4m775EosEm@mit.edu>
References: <20230921-umgekehrt-buden-a8718451ef7c@brauner>
 <CAHk-=wgoNW9QmEzhJR7C1_vKWKr=8JoD4b7idQDNHOa10P_i4g@mail.gmail.com>
 <0d006954b698cb1cea3a93c1662b5913a0ded3b1.camel@kernel.org>
 <CAHk-=whAwTJduUZTrsLFnj1creZMfO7eCNERHXZQmzX+qLqZMA@mail.gmail.com>
 <CAOQ4uxjcyfhfRhgR97wqsJHwzyOYqOYaaZWMWWCGXu5MWtKXfQ@mail.gmail.com>
 <CAHk-=wjGJEgizkXwSWVCnsGnciCKHHsWg+dkw2XAhM+0Tnd0Jw@mail.gmail.com>
 <ZQ884uCkKGu6xsDi@mit.edu>
 <CAHk-=wg8zxC9h5a0qimfGJVvkN0H5fNgg03+TNn9GE=g_G30vw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wg8zxC9h5a0qimfGJVvkN0H5fNgg03+TNn9GE=g_G30vw@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Sep 23, 2023 at 01:03:56PM -0700, Linus Torvalds wrote:
> 
> Except it looks like ext4 actually does full nanosecond resolution (30
> bits for nanoseconds, 34 bits for seconds). Thus the "only a couple of
> hundred years of range".

Hmm, yeah, sorry, I misremembered.  We did talk about possibly going
with 100ns, but if I recall correctly, I think there was a desire that
an arbitrary timespec64 should be encodable into an on-disk timestamp,
and then back again, and hundreds of years of range was considered
Good Enough (tm).

> Except we'd do it without the EXT4_EPOCH_MASK conditionals, and I
> think it would be better to have a bigger range for seconds. If you
> give the seconds field three extra bits, you're comfortable in the
> "thousands of years", and you still have 27 bits that can encode a
> decimal "100ns".

I might be screweing my math, but I believe 24 bits should be enough
to code 10,000,000 units of 100ns (it's enough for 16,777,216), which
should be sufficient.  What am I missing?

As far as how many seconds are needed, that's an area where people of
good will can disagree.  Given that I don't really believe a machine
is going to be up for decades before we will need to reboot and update
the kernel to address zero days, and LTS kernels are going to be
supported for two years going forward, if what we're talking about is
the in-memory time type, my personal opinion is that hundreds of years
is plenty, since it's not hard to change the encoding later.

Cheers,

						- Ted

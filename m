Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2945B6A5E51
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Feb 2023 18:38:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229731AbjB1RiI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Feb 2023 12:38:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbjB1RiH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Feb 2023 12:38:07 -0500
X-Greylist: delayed 337 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 28 Feb 2023 09:38:04 PST
Received: from mail.hallyn.com (mail.hallyn.com [178.63.66.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB607A5F3;
        Tue, 28 Feb 2023 09:38:04 -0800 (PST)
Received: by mail.hallyn.com (Postfix, from userid 1001)
        id 3C327115; Tue, 28 Feb 2023 11:32:25 -0600 (CST)
Date:   Tue, 28 Feb 2023 11:32:25 -0600
From:   "Serge E. Hallyn" <serge@hallyn.com>
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Mateusz Guzik <mjguzik@gmail.com>,
        Serge Hallyn <serge@hallyn.com>, viro@zeniv.linux.org.uk,
        paul@paul-moore.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: Re: [PATCH v3 1/2] capability: add cap_isidentical
Message-ID: <20230228173225.GA461660@mail.hallyn.com>
References: <20230125155557.37816-1-mjguzik@gmail.com>
 <CAHk-=wjz8O4XX=Mg6cv5Rq9w9877Xd4DCz5jk0onVKLnzzaPTA@mail.gmail.com>
 <97465c08-7b6e-7fd7-488d-0f677ac22f81@schaufler-ca.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <97465c08-7b6e-7fd7-488d-0f677ac22f81@schaufler-ca.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Feb 27, 2023 at 06:46:12PM -0800, Casey Schaufler wrote:
> On 2/27/2023 5:14 PM, Linus Torvalds wrote:
> > On Wed, Jan 25, 2023 at 7:56 AM Mateusz Guzik <mjguzik@gmail.com> wrote:
> >> +static inline bool cap_isidentical(const kernel_cap_t a, const kernel_cap_t b)
> >> +{
> >> +       unsigned __capi;
> >> +       CAP_FOR_EACH_U32(__capi) {
> >> +               if (a.cap[__capi] != b.cap[__capi])
> >> +                       return false;
> >> +       }
> >> +       return true;
> >> +}
> >> +
> > Side note, and this is not really related to this particular patch
> > other than because it just brought up the issue once more..
> >
> > Our "kernel_cap_t" thing is disgusting.
> >
> > It's been a structure containing
> >
> >         __u32 cap[_KERNEL_CAPABILITY_U32S];
> >
> > basically forever, and it's not likely to change in the future. I
> > would object to any crazy capability expansion, considering how
> > useless and painful they've been anyway, and I don't think anybody
> > really is even remotely planning anything like that anyway.
> >
> > And what is _KERNEL_CAPABILITY_U32S anyway? It's the "third version"
> > of that size:
> >
> >   #define _KERNEL_CAPABILITY_U32S    _LINUX_CAPABILITY_U32S_3
> >
> > which happens to be the same number as the second version of said
> > #define, which happens to be "2".
> >
> > In other words, that fancy array is just 64 bits. And we'd probably be
> > better off just treating it as such, and just doing
> >
> >         typedef u64 kernel_cap_t;
> >
> > since we have to do the special "convert from user space format"
> > _anyway_, and this isn't something that is shared to user space as-is.
> >
> > Then that "cap_isidentical()" would literally be just "a == b" instead
> > of us playing games with for-loops that are just two wide, and a
> > compiler that may or may not realize.
> >
> > It would literally remove some of the insanity in <linux/capability.h>
> > - look for CAP_TO_MASK() and CAP_TO_INDEX and CAP_FS_MASK_B0 and
> > CAP_FS_MASK_B1 and just plain ugliness that comes from this entirely
> > historical oddity.
> >
> > Yes, yes, we started out having it be a single-word array, and yes,
> > the code is written to think that it might some day be expanded past
> > the two words it then in 2008 it expanded to two words and 64 bits.
> > And now, fifteen years later, we use 40 of those 64 bits, and
> > hopefully we'll never add another one.
> 
> I agree that the addition of 24 more capabilities is unlikely. The
> two reasons presented recently for adding capabilities are to implement
> boutique policies (CAP_MYHARDWAREISSPECIAL) or to break up CAP_SYS_ADMIN.

FWIW IMO breaking up CAP_SYS_ADMIN is a good thing, so long as we continue
to do it in the "you can use either CAP_SYS_ADMIN or CAP_NEW_FOO" way.  

But there haven't been many such patchsets :)

> Neither of these is sustainable with a finite number of capabilities, nor
> do they fit the security model capabilities implement. It's possible that
> a small number of additional capabilities will be approved, but even that
> seems unlikely.
> 
> 
> > So we have historical reasons for why our kernel_cap_t is so odd. But
> > it *is* odd.
> >
> > Hmm?
> 
> I don't see any reason that kernel_cap_t shouldn't be a u64. If by some
> amazing change in mindset we develop need for 65 capabilities, someone can
> dredge up the old code, shout "I told you so!" and put it back the way it
> was. Or maybe by then we'll have u128, and can just switch to that.
> 
> >              Linus

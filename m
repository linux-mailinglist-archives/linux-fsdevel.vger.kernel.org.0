Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E6D442604B
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Oct 2021 01:15:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233546AbhJGXRt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 7 Oct 2021 19:17:49 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:49822 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232772AbhJGXRt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 7 Oct 2021 19:17:49 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 37AA222390;
        Thu,  7 Oct 2021 23:15:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1633648553; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kSnrerwv270QxT0w2bS3cPFwhWQVdE6mdRZdEBg4V4o=;
        b=Pn27Dngy7k6xyCB/L8UnC3idx+w9mU6b8Q2lt4+NQFDFiGnhBi9jq3UDR0hysdsa7PFnZV
        zB46tndaWmkqwMnZmG0A6VLfehDUUpxSzpMvC8ze+NcgM/WLFBH7lKLW9GSg/JWo7I0S+m
        2thz9a10DZWK0cihVLW/hy3PzPPWkOs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1633648553;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kSnrerwv270QxT0w2bS3cPFwhWQVdE6mdRZdEBg4V4o=;
        b=eIauZ+xvoroRlzFeFKYGLP++hO24vjEin49QWmDbxltJw1low2C3e6OU4+G/OJ+dMC+RFu
        eEOM33gIa1WozrBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7648113C3A;
        Thu,  7 Oct 2021 23:15:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 7SFLDaR/X2EGMAAAMHmgww
        (envelope-from <neilb@suse.de>); Thu, 07 Oct 2021 23:15:48 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Michal Hocko" <mhocko@suse.com>
Cc:     "Dave Chinner" <david@fromorbit.com>,
        "Vlastimil Babka" <vbabka@suse.cz>,
        "Andrew Morton" <akpm@linux-foundation.org>,
        "Theodore Ts'o" <tytso@mit.edu>,
        "Andreas Dilger" <adilger.kernel@dilger.ca>,
        "Darrick J. Wong" <djwong@kernel.org>,
        "Matthew Wilcox" <willy@infradead.org>,
        "Mel Gorman" <mgorman@suse.de>, "Jonathan Corbet" <corbet@lwn.net>,
        linux-xfs@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH 2/6] MM: improve documentation for __GFP_NOFAIL
In-reply-to: <YV7G7gyfZkmw7/Ae@dhcp22.suse.cz>
References: <163184698512.29351.4735492251524335974.stgit@noble.brown>,
 <163184741778.29351.16920832234899124642.stgit@noble.brown>,
 <b680fb87-439b-0ba4-cf9f-33d729f27941@suse.cz>,
 <YVwyhDnE/HEnoLAi@dhcp22.suse.cz>,
 <eba04a07-99da-771a-ab6b-36de41f9f120@suse.cz>,
 <20211006231452.GF54211@dread.disaster.area>,
 <YV7G7gyfZkmw7/Ae@dhcp22.suse.cz>
Date:   Fri, 08 Oct 2021 10:15:45 +1100
Message-id: <163364854551.31063.4377741712039731672@noble.neil.brown.name>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, 07 Oct 2021, Michal Hocko wrote:
> On Thu 07-10-21 10:14:52, Dave Chinner wrote:
> > On Tue, Oct 05, 2021 at 02:27:45PM +0200, Vlastimil Babka wrote:
> > > On 10/5/21 13:09, Michal Hocko wrote:
> > > > On Tue 05-10-21 11:20:51, Vlastimil Babka wrote:
> > > > [...]
> > > >> > --- a/include/linux/gfp.h
> > > >> > +++ b/include/linux/gfp.h
> > > >> > @@ -209,7 +209,11 @@ struct vm_area_struct;
> > > >> >   * used only when there is no reasonable failure policy) but it is
> > > >> >   * definitely preferable to use the flag rather than opencode end=
less
> > > >> >   * loop around allocator.
> > > >> > - * Using this flag for costly allocations is _highly_ discouraged.
> > > >> > + * Use of this flag may lead to deadlocks if locks are held which=
 would
> > > >> > + * be needed for memory reclaim, write-back, or the timely exit o=
f a
> > > >> > + * process killed by the OOM-killer.  Dropping any locks not abso=
lutely
> > > >> > + * needed is advisable before requesting a %__GFP_NOFAIL allocate.
> > > >> > + * Using this flag for costly allocations (order>1) is _highly_ d=
iscouraged.
> > > >>=20
> > > >> We define costly as 3, not 1. But sure it's best to avoid even order=
>0 for
> > > >> __GFP_NOFAIL. Advising order>1 seems arbitrary though?
> > > >=20
> > > > This is not completely arbitrary. We have a warning for any higher or=
der
> > > > allocation.
> > > > rmqueue:
> > > > 	WARN_ON_ONCE((gfp_flags & __GFP_NOFAIL) && (order > 1));
> > >=20
> > > Oh, I missed that.
> > >=20
> > > > I do agree that "Using this flag for higher order allocations is
> > > > _highly_ discouraged.
> > >=20
> > > Well, with the warning in place this is effectively forbidden, not just
> > > discouraged.
> >=20
> > Yup, especially as it doesn't obey __GFP_NOWARN.
> >=20
> > See commit de2860f46362 ("mm: Add kvrealloc()") as a direct result
> > of unwittingly tripping over this warning when adding __GFP_NOFAIL
> > annotations to replace open coded high-order kmalloc loops that have
> > been in place for a couple of decades without issues.
> >=20
> > Personally I think that the way __GFP_NOFAIL is first of all
> > recommended over open coded loops and then only later found to be
> > effectively forbidden and needing to be replaced with open coded
> > loops to be a complete mess.
>=20
> Well, there are two things. Opencoding something that _can_ be replaced
> by __GFP_NOFAIL and those that cannot because the respective allocator
> doesn't really support that semantic. kvmalloc is explicit about that
> IIRC. If you have a better way to consolidate the documentation then I
> am all for it.

I think one thing that might help make the documentation better is to
explicitly state *why* __GFP_NOFAIL is better than a loop.

It occurs to me that
  while (!(p =3D kmalloc(sizeof(*p), GFP_KERNEL));

would behave much the same as adding __GFP_NOFAIL and dropping the
'while'.  So why not? I certainly cannot see the need to add any delay
to this loop as kmalloc does a fair bit of sleeping when permitted.

I understand that __GFP_NOFAIL allows page_alloc to dip into reserves,
but Mel holds that up as a reason *not* to use __GFP_NOFAIL as it can
impact on other subsystems.  Why not just let the caller decide if they
deserve the boost, but oring in __GFP_ATOMIC or __GFP_MEMALLOC as
appropriate.

I assume there is a good reason.  I vaguely remember the conversation
that lead to __GFP_NOFAIL being introduced.  I just cannot remember or
deduce what the reason is.  So it would be great to have it documented.

>=20
> > Not to mention on the impossibility of using __GFP_NOFAIL with
> > kvmalloc() calls. Just what do we expect kmalloc_node(__GFP_NORETRY
> > | __GFP_NOFAIL) to do, exactly?
>=20
> This combination doesn't make any sense. Like others. Do you want us to
> list all combinations that make sense?

I've been wondering about that.  There seem to be sets of flags that are
mutually exclusive.  It is as though gfp_t is a struct of a few enums.

0, DMA32, DMA, HIGHMEM
0, FS, IO
0, ATOMIC, MEMALLOC, NOMEMALLOC, HIGH
NORETRY, RETRY_MAYFAIL, 0, NOFAIL
0, KSWAPD_RECLAIM, DIRECT_RECLAIM
0, THISNODE, HARDWALL

In a few cases there seem to be 3 bits where there are only 4 possibly
combinations, so 2 bits would be enough.  There is probably no real
value is squeezing these into 2 bits, but clearly documenting the groups
surely wouldn't hurt.  Particularly highlighting the difference between
related bits would help.

The set with  'ATOMIC' is hard to wrap my mind around.
They relate to ALLOC_HIGH and ALLOC_HARDER, but also to WMARK_NIN,
WMARK_LOW, WMARK_HIGH ... I think.

I wonder if FS,IO is really in the same set as DIRECT_RECLAIM as they
all affect reclaim.  Maybe FS and IO are only relevan if DIRECT_RECLAIM
is set?

I'd love to know that to expect if neither RETRY_MAYFAIL or NOFAIL is
set.  I guess it can fail, but it still tries harder than if
RETRY_MAYFAIL is set....
Ahhhh...  I found some documentation which mentions that RETRY_MAYFAIL
doesn't trigger the oom killer.  Is that it? So RETRY_NOKILLOOM might be
a better name?

>=20
> > So, effectively, we have to open-code around kvmalloc() in
> > situations where failure is not an option. Even if we pass
> > __GFP_NOFAIL to __vmalloc(), it isn't guaranteed to succeed because
> > of the "we won't honor gfp flags passed to __vmalloc" semantics it
> > has.
>=20
> yes vmalloc doesn't support nofail semantic and it is not really trivial
> to craft it there.
>=20
> > Even the API constaints of kvmalloc() w.r.t. only doing the vmalloc
> > fallback if the gfp context is GFP_KERNEL - we already do GFP_NOFS
> > kvmalloc via memalloc_nofs_save/restore(), so this behavioural
> > restriction w.r.t. gfp flags just makes no sense at all.
>=20
> GFP_NOFS (without using the scope API) has the same problem as NOFAIL in
> the vmalloc. Hence it is not supported. If you use the scope API then
> you can GFP_KERNEL for kvmalloc. This is clumsy but I am not sure how to
> define these conditions in a more sensible way. Special case NOFS if the
> scope api is in use? Why do you want an explicit NOFS then?

It would seem to make sense for kvmalloc to WARN_ON if it is passed
flags that does not allow it to use vmalloc.
Such callers could then know they can either change to a direct
kmalloc(), or change flags.  Silently ignoring the 'v' in the function
name sees like a poor choice.

Thanks,
NeilBrown

>=20
> > That leads to us having to go back to writing extremely custom open
> > coded loops to avoid awful high-order kmalloc direct reclaim
> > behaviour and still fall back to vmalloc and to still handle NOFAIL
> > semantics we need:
> >=20
> > https://lore.kernel.org/linux-xfs/20210902095927.911100-8-david@fromorbit=
.com/
>=20
> It would be more productive to get to MM people rather than rant on a
> xfs specific patchse. Anyway, I can see a kvmalloc mode where the
> kmalloc allocation would be really a very optimistic one - like your
> effectively GFP_NOWAIT. Nobody has requested such a mode until now and I
> am not sure how we would sensibly describe that by a gfp mask.
>=20
> Btw. your GFP_NOWAIT | __GFP_NORETRY combination doesn't make any sense
> in the allocator context as the later is a reclaim mofifier which
> doesn't get applied when the reclaim is disabled (in your case by flags
> &=3D ~__GFP_DIRECT_RECLAIM).
>=20
> GFP flags are not that easy to build a coherent and usable apis.
> Something we carry as a baggage for a long time.
>=20
> > So, really, the problems are much deeper here than just badly
> > documented, catch-22 rules for __GFP_NOFAIL - we can't even use
> > __GFP_NOFAIL consistently across the allocation APIs because it
> > changes allocation behaviours in unusable, self-defeating ways....
>=20
> GFP_NOFAIL sucks. Not all allocator can follow it for practical
> reasons. You are welcome to help document those awkward corner cases or
> fix them up if you have a good idea how.
>=20
> Thanks!
> --=20
> Michal Hocko
> SUSE Labs
>=20
>=20

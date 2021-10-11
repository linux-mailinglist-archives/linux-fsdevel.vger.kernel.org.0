Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 629CA42E424
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Oct 2021 00:28:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234196AbhJNWad (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 14 Oct 2021 18:30:33 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:51220 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229768AbhJNWab (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 14 Oct 2021 18:30:31 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id C3A5A1FD37;
        Thu, 14 Oct 2021 22:28:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1634250504; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XamiXsFb6RQH4eKb4WeCOhk32Zh5qQsoE1V0O9eGBfc=;
        b=nWjnsuhqzJKhcayDHGPSKVhGlxwOGc1FYOYAIGXOxXi+KmMZ6G3bzFhb35Mrx5ahaR7jZa
        PWr6UUzOXGL755IhAqhMAkhrgHR9yJnBRad9O7EQTfHSHon1T8eEmBl5qXiJpziDYPszuN
        WAG3Jp8f1UqTXeD6J2dkg4YKUMAFDi4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1634250504;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XamiXsFb6RQH4eKb4WeCOhk32Zh5qQsoE1V0O9eGBfc=;
        b=/068GKy8+Es6V00efq8CtbnWkMwkStq+NFkGkSd+LYhmyfVgvIxiSKpOP3WZrHB9q3ZUem
        aG9MPOMP0uI9AQBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8EEC313B3A;
        Thu, 14 Oct 2021 22:28:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id swtxDgKvaGHoPAAAMHmgww
        (envelope-from <neilb@suse.de>); Thu, 14 Oct 2021 22:28:18 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
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
In-reply-to: <YWQmsESyyiea0zle@dhcp22.suse.cz>
References: <163184698512.29351.4735492251524335974.stgit@noble.brown>,
 <163184741778.29351.16920832234899124642.stgit@noble.brown>,
 <b680fb87-439b-0ba4-cf9f-33d729f27941@suse.cz>,
 <YVwyhDnE/HEnoLAi@dhcp22.suse.cz>,
 <eba04a07-99da-771a-ab6b-36de41f9f120@suse.cz>,
 <20211006231452.GF54211@dread.disaster.area>,
 <YV7G7gyfZkmw7/Ae@dhcp22.suse.cz>,
 <163364854551.31063.4377741712039731672@noble.neil.brown.name>,
 <YV/31+qXwqEgaxJL@dhcp22.suse.cz>,
 <20211008223649.GJ54211@dread.disaster.area>,
 <YWQmsESyyiea0zle@dhcp22.suse.cz>
Date:   Tue, 12 Oct 2021 08:49:46 +1100
Message-id: <163398898675.17149.16715168325131099480@noble.neil.brown.name>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 11 Oct 2021, Michal Hocko wrote:
> On Sat 09-10-21 09:36:49, Dave Chinner wrote:
> > 
> > Put simply, we want "retry forever" semantics to match what
> > production kernels have been doing for the past couple of decades,
> > but all we've been given are "never fail" semantics that also do
> > something different and potentially much more problematic.
> > 
> > Do you see the difference here? __GFP_NOFAIL is not what we
> > need in the vast majority of cases where it is used. We don't want
> > the failing allocations to drive the machine hard into critical
> > reserves, we just want the allocation to -eventually succeed- and if
> > it doesn't, that's our problem to handle, not kmalloc()....
> 
> I can see your point. I do have a recollection that there were some
> instance involved where an emergency access to memory reserves helped
> in OOM situations.

It might have been better to annotate those particular calls with
__GFP_ATOMIC or similar rather then change GFP_NOFAIL for everyone.
Too late to fix that now though I think.  Maybe the best way forward is
to discourage new uses of GFP_NOFAIL.  We would need a well-documented
replacement.

> 
> Anway as I've tried to explain earlier that this all is an
> implementation detail users of the flag shouldn't really care about. If
> this heuristic is not doing any good then it should be removed.

Maybe users shouldn't care about implementation details, but they do
need to care about semantics and costs.
We need to know when it is appropriate to use GFP_NOFAIL, and when it is
not.  And what alternatives there are when it is not appropriate.
Just saying "try to avoid using it" and "requires careful analysis"
isn't acceptable.  Sometimes it is unavoidable and analysis can only be
done with a clear understanding of costs.  Possibly analysis can only be
done with a clear understanding of the internal implementation details.

> 
> > It also points out that the scope API is highly deficient.
> > We can do GFP_NOFS via the scope API, but we can't
> > do anything else because *there is no scope API for other GFP
> > flags*.
> > 
> > Why don't we have a GFP_NOFAIL/__GFP_RETRY_FOREVER scope API?
> 
> NO{FS,IO} where first flags to start this approach. And I have to admit
> the experiment was much less successful then I hoped for. There are
> still thousands of direct NOFS users so for some reason defining scopes
> is not an easy thing to do.

I'm not certain your conclusion is valid.  It could be that defining
scopes is easy enough, but no one feels motivated to do it.
We need to do more than provide functionality.  We need to tell people. 
Repeatedly.  And advertise widely.  And propose patches to make use of
the functionality.  And... and... and...

I think changing to the scope API is a good change, but it is
conceptually a big change.  It needs to be driven.

> 
> I am not against NOFAIL scopes in principle but seeing the nofs
> "success" I am worried this will not go really well either and it is
> much more tricky as NOFAIL has much stronger requirements than NOFS.
> Just imagine how tricky this can be if you just call a library code
> that is not under your control within a NOFAIL scope. What if that
> library code decides to allocate (e.g. printk that would attempt to do
> an optimistic NOWAIT allocation).

__GFP_NOMEMALLOC holds a lesson worth learning here.  PF_MEMALLOC
effectively adds __GFP_MEMALLOC to all allocations, but some call sites
need to over-ride that because there are alternate strategies available.
This need-to-over-ride doesn't apply to NOFS or NOIO as that really is a
thread-wide state.  But MEMALLOC and NOFAIL are different.  Some call
sites can reasonably handle failure locally.

I imagine the scope-api would say something like "NO_ENOMEM".  i.e.
memory allocations can fail as long as ENOMEM is never returned.
Any caller that sets __GFP_RETRY_MAYFAIL or __GFP_NORETRY or maybe some
others which not be affected by the NO_ENOMEM scope.  But a plain
GFP_KERNEL would.

Introducing the scope api would be a good opportunity to drop the
priority boost and *just* block until success.  Priority boosts could
then be added (possibly as a scope) only where they are measurably needed.

I think we have 28 process flags in use.  So we can probably afford one
more for PF_MEMALLOC_NO_ENOMEM.  What other scope flags might be useful?
PF_MEMALLOC_BOOST which added __GFP_ATOMIC but not __GFP_MEMALLOC ??
PF_MEMALLOC_NORECLAIM ??

> 
> > That
> > would save us a lot of bother in XFS. What about GFP_DIRECT_RECLAIM?
> > I'd really like to turn that off for allocations in the XFS
> > transaction commit path (as noted already in this thread) because
> > direct reclaim that can make no progress is actively harmful (as
> > noted already in this thread)
> 
> As always if you have reasonable usecases then it is best to bring them
> up on the MM list and we can discuss them.

We are on the MM lists now... let's discuss :-)

Dave: How would you feel about an effort to change xfs to stop using
GFP_NOFS, and to use memalloc_nofs_save/restore instead? Having a major
filesystem make the transition would be a good test-case, and could be
used to motivate other filesystems to follow.
We could add and use memalloc_no_enomem_save() too.

Thanks,
NeilBrown

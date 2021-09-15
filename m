Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F81740CF6E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Sep 2021 00:35:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232990AbhIOWhN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Sep 2021 18:37:13 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:38310 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232949AbhIOWhK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Sep 2021 18:37:10 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 53ED322323;
        Wed, 15 Sep 2021 22:35:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1631745347; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JgZsYMmsqoTtaIffqm+LgUI61DrT1bvGtpHuAgBAgHg=;
        b=shB4rBHWjsQzJSjuYNvpz+qx09iQlmlzyUlYQG4mK0I8Oq0LoBQdBjz5SC8d9rCNaSEQC3
        z4cnLF7vLZbCLfS68MgEbMX/JiWYAabou3SUCIzfEg4sL7Lz4hjdMOCz9731kDaPCwaLLA
        FtnGEE57fq/siqOWE3m9PSg3ovkUvWE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1631745347;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JgZsYMmsqoTtaIffqm+LgUI61DrT1bvGtpHuAgBAgHg=;
        b=s5BHawe8Yvvo9IzI+WIYfpeIDNcwBKcloNxJGfnJCVoVXQp+rZk0It2270SDw/l+t64odJ
        tR44mjA4Vwlf7zAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 65EF613C77;
        Wed, 15 Sep 2021 22:35:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 0QavCT91QmFWUgAAMHmgww
        (envelope-from <neilb@suse.de>); Wed, 15 Sep 2021 22:35:43 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Michal Hocko" <mhocko@suse.com>
Cc:     "Mel Gorman" <mgorman@suse.de>,
        "Andrew Morton" <akpm@linux-foundation.org>,
        "Theodore Ts'o" <tytso@mit.edu>,
        "Andreas Dilger" <adilger.kernel@dilger.ca>,
        "Darrick J. Wong" <djwong@kernel.org>, "Jan Kara" <jack@suse.cz>,
        "Matthew Wilcox" <willy@infradead.org>, linux-xfs@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-nfs@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/6] EXT4: Remove ENOMEM/congestion_wait() loops.
In-reply-to: <YUHh2ddnJEDGI8YG@dhcp22.suse.cz>
References: <163157808321.13293.486682642188075090.stgit@noble.brown>,
 <163157838437.13293.14244628630141187199.stgit@noble.brown>,
 <20210914163432.GR3828@suse.com>,
 <163165609100.3992.1570739756456048657@noble.neil.brown.name>,
 <YUHh2ddnJEDGI8YG@dhcp22.suse.cz>
Date:   Thu, 16 Sep 2021 08:35:40 +1000
Message-id: <163174534006.3992.15394603624652359629@noble.neil.brown.name>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 15 Sep 2021, Michal Hocko wrote:
> On Wed 15-09-21 07:48:11, Neil Brown wrote:
> >=20
> > Why does __GFP_NOFAIL access the reserves? Why not require that the
> > relevant "Try harder" flag (__GFP_ATOMIC or __GFP_MEMALLOC) be included
> > with __GFP_NOFAIL if that is justified?
>=20
> Does 5020e285856c ("mm, oom: give __GFP_NOFAIL allocations access to
> memory reserves") help?

Yes, that helps.  A bit.

I'm not fond of the clause "the allocation request might have come with some
locks held".  What if it doesn't?  Does it still have to pay the price.

Should we not require that the caller indicate if any locks are held?
That way callers which don't hold locks can use __GFP_NOFAIL without
worrying about imposing on other code.

Or is it so rare that __GFP_NOFAIL would be used without holding a lock
that it doesn't matter?

The other commit of interest is

Commit: 6c18ba7a1899 ("mm: help __GFP_NOFAIL allocations which do not trigger=
 OOM killer")

I don't find the reasoning convincing.  It is a bit like "Robbing Peter
to pay Paul".  It takes from the reserves to allow a __GFP_NOFAIL to
proceed, with out any reason to think this particular allocation has any
more 'right' to the reserves than anything else.

While I don't like the reasoning in either of these, they do make it
clear (to me) that the use of reserves is entirely an internal policy
decision.  They should *not* be seen as part of the API and callers
should not have to be concerned about it when deciding whether to use
__GFP_NOFAIL or not.

The use of these reserves is, at most, a hypothetical problem.  If it
ever looks like becoming a real practical problem, it needs to be fixed
internally to the page allocator.  Maybe an extra water-mark which isn't
quite as permissive as ALLOC_HIGH...

I'm inclined to drop all references to reserves from the documentation
for __GFP_NOFAIL.  I think there are enough users already that adding a
couple more isn't going to make problems substantially more likely.  And
more will be added anyway that the mm/ team won't have the opportunity
or bandwidth to review.

Meanwhile I'll see if I can understand the intricacies of alloc_page so
that I can contibute to making it more predictable.

Question: In those cases where an open-coded loop is appropriate, such
as when you want to handle signals or can drop locks, how bad would it
be to have a tight loop without any sleep?
should_reclaim_retry() will sleep 100ms (sometimes...).  Is that enough?
__GFP_NOFAIL doesn't add any sleep when looping.

Thanks,
NeilBrown

Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB04A43BE8C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Oct 2021 02:43:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234724AbhJ0Ap5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 26 Oct 2021 20:45:57 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:48244 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230373AbhJ0Ap5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 26 Oct 2021 20:45:57 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 4FD82218F7;
        Wed, 27 Oct 2021 00:43:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1635295411; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RvmWQZ8FUef1/pzCcXG+8ld2wRn/BMgxM97QzliYX8o=;
        b=yeJ2tAIusCxl+1cK5wTbRGSjjseBdjgKX3viSptEtw3ez1VlvFxmoJsGyzFYcS3E3s/U32
        6hF/LXI2leR8R4pSZceocmbAZjqj9raHjGy5JO8sKhKqx/iQIzrIktQC+u8lKlZ8GkaF4l
        LTEfPkwWVvEIu3BybuY2M8bTtaQQAcQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1635295411;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RvmWQZ8FUef1/pzCcXG+8ld2wRn/BMgxM97QzliYX8o=;
        b=wLkr3Le61xAdgwL4cWK6b93mUV03kGFjKkMzXMaIgX3BHcJPspVwyzWscPVUzg+1VQ2CvL
        Qgtt8sgSQohS1cDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D81DB13CBF;
        Wed, 27 Oct 2021 00:43:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id tW3jJK6geGFjdQAAMHmgww
        (envelope-from <neilb@suse.de>); Wed, 27 Oct 2021 00:43:26 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Mel Gorman" <mgorman@techsingularity.net>
Cc:     "Andrew Morton" <akpm@linux-foundation.org>,
        "Theodore Ts'o" <tytso@mit.edu>,
        "Andreas Dilger" <adilger.kernel@dilger.ca>,
        "Darrick J . Wong" <djwong@kernel.org>,
        "Matthew Wilcox" <willy@infradead.org>,
        "Michal Hocko" <mhocko@suse.com>,
        "Dave Chinner" <david@fromorbit.com>,
        "Rik van Riel" <riel@surriel.com>,
        "Vlastimil Babka" <vbabka@suse.cz>,
        "Johannes Weiner" <hannes@cmpxchg.org>,
        "Jonathan Corbet" <corbet@lwn.net>,
        "Linux-MM" <linux-mm@kvack.org>,
        "Linux-fsdevel" <linux-fsdevel@vger.kernel.org>,
        "LKML" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 0/8] Remove dependency on congestion_wait in mm/
In-reply-to: <20211022131732.GK3959@techsingularity.net>
References: <20211019090108.25501-1-mgorman@techsingularity.net>,
 <163486531001.17149.13533181049212473096@noble.neil.brown.name>,
 <20211022083927.GI3959@techsingularity.net>,
 <163490199006.17149.17259708448207042563@noble.neil.brown.name>,
 <20211022131732.GK3959@techsingularity.net>
Date:   Wed, 27 Oct 2021 11:43:22 +1100
Message-id: <163529540259.8576.9186192891154927096@noble.neil.brown.name>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, 23 Oct 2021, Mel Gorman wrote:
> On Fri, Oct 22, 2021 at 10:26:30PM +1100, NeilBrown wrote:
> > On Fri, 22 Oct 2021, Mel Gorman wrote:
> > > On Fri, Oct 22, 2021 at 12:15:10PM +1100, NeilBrown wrote:
> > >=20
> > > > In general, I still don't like the use of wake_up_all(), though it wo=
n't
> > > > cause incorrect behaviour.
> > > >=20
> > >=20
> > > Removing wake_up_all would be tricky.
> >=20
> > I think there is a misunderstanding.  Removing wake_up_all() is as
> > simple as
> >    s/wake_up_all/wake_up/
> >=20
> > If you used prepare_to_wait_exclusive(), then wake_up() would only wake
> > one waiter, while wake_up_all() would wake all of them.
> > As you use prepare_to_wait(), wake_up() will wake all waiters - as will
> > wake_up_all().=20
> >=20
>=20
> Ok, yes, there was a misunderstanding. I thought you were suggesting a
> move to exclusive wakeups. I felt that the wake_up_all was explicit in
> terms of intent and that I really meant for all tasks to wake instead of
> one at a time.

Fair enough.  Thanks for changing it :-)

But this prompts me to wonder if exclusive wakeups would be a good idea
- which is a useful springboard to try to understand the code better.

For VMSCAN_THROTTLE_ISOLATED they probably are.
One pattern for reliable exclusive wakeups is for any thread that
received a wake-up to then consider sending a wake up.

Two places receive VMSCAN_THROTTLE_ISOLATED wakeups and both then call
too_many_isolated() which - on success - sends another wakeup - before
the caller has had a chance to isolate anything.  If, instead, the
wakeup was sent sometime later, after pages were isolated by before the
caller (isoloate_migratepages_block() or shrink_inactive_list())
returned, then we would get an orderly progression of threads running
through that code.

For VMSCAN_THROTTLE_WRITEBACK is a little less straight forward.
There are two different places that wait for the wakeup, and a wake_up
is sent to all waiters after a time proportional to the number of
waiters.  It might make sense to wake one thread per time unit?
That might work well for do_writepages - every SWAP_CLUSTER_MAX writes
triggers one wakeup.
I'm less sure that it would work for shrink_node().  Maybe the
shrink_node() waiters could be non-exclusive so they get woken as soon a
SWAP_CLUSTER_MAX writes complete, while do_writepages are exclusive and
get woken one at a time.

For VMSCAN_THROTTLE_NOPROGRESS .... I don't understand.
If one zone isn't making "enough" progress, we throttle before moving on
to the next zone.  So we delay processing of the next zone, and only
indirectly delay re-processing of the current congested zone.
Maybe it make sense, but I don't see it yet.  I note that the commit
message says "it's messy".  I can't argue with that!

I'll follow up with patches to clarify what I am thinking about the
first two.  I'm not proposing the patches, just presenting them as part
of improving my understanding.

Thanks,
NeilBrown

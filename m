Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15A06436F48
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Oct 2021 03:15:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231582AbhJVBRh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 Oct 2021 21:17:37 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:35686 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbhJVBRh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 Oct 2021 21:17:37 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 62C431FD58;
        Fri, 22 Oct 2021 01:15:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1634865319; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rq3odoy59HyrQmg1a3mSgH5Sm3cJlmjDdKCFffu3ors=;
        b=u0B1GEQrCpyqj8Z6ws+ubTOKH/ZRz0M3QCcHzMT6rQaqAeOpdAmRDIWA8CSGzXZLTzWA9h
        Vnb0tY/v4WD4lw2vfFFK2UArb9UNpLi5Bdk8TqJ3EGTgGnvi+NO2MhKLNNsrGWzKA7yxUM
        0D1l1xGWXhh/gakZPupCsbrRsqeHCpo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1634865319;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rq3odoy59HyrQmg1a3mSgH5Sm3cJlmjDdKCFffu3ors=;
        b=+017rT++tLS4HEnKQpedB2d9HZCFOKBj6ESEC3XLw61sawVxQ/NPe50NhFAK2jaqUfqZV3
        f/qtKZQyKlu3BBAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E37A31346B;
        Fri, 22 Oct 2021 01:15:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id pE7qIqEQcmEZKAAAMHmgww
        (envelope-from <neilb@suse.de>); Fri, 22 Oct 2021 01:15:13 +0000
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
        "LKML" <linux-kernel@vger.kernel.org>,
        "Mel Gorman" <mgorman@techsingularity.net>
Subject: Re: [PATCH v4 0/8] Remove dependency on congestion_wait in mm/
In-reply-to: <20211019090108.25501-1-mgorman@techsingularity.net>
References: <20211019090108.25501-1-mgorman@techsingularity.net>
Date:   Fri, 22 Oct 2021 12:15:10 +1100
Message-id: <163486531001.17149.13533181049212473096@noble.neil.brown.name>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 19 Oct 2021, Mel Gorman wrote:
> Changelog since v3
> o Count writeback completions for NR_THROTTLED_WRITTEN only
> o Use IRQ-safe inc_node_page_state
> o Remove redundant throttling
>=20
> This series is also available at
>=20
> git://git.kernel.org/pub/scm/linux/kernel/git/mel/linux.git mm-reclaimconge=
st-v4r2
>=20
> This series that removes all calls to congestion_wait
> in mm/ and deletes wait_iff_congested.=20

Thanks for this.
I don't have sufficient expertise for a positive review, but it seems to
make sense with one exception which I have commented on separately.

In general, I still don't like the use of wake_up_all(), though it won't
cause incorrect behaviour.

I would prefer the first patch would:
 - define NR_VMSCAN_THROTTLE
 - make reclaim_wait an array
 - spelled nr_reclaim_throttled as nr_writeback_throttled

rather than leaving those changes for the second patch.  I think that
would make review easier.

But these are minor and I'll not mention them again.

Thanks,
NeilBrown

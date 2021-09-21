Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34AE8413CE0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Sep 2021 23:47:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235659AbhIUVsg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 21 Sep 2021 17:48:36 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:54418 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234813AbhIUVsf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 21 Sep 2021 17:48:35 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id A7CE622231;
        Tue, 21 Sep 2021 21:47:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1632260825; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MmQGJX320SQ4PZHIT6qqIM++413uNofSb605veJtUls=;
        b=lo3tPEOB+9EEtY34A9L0SIPIqL8yXfjOoyht9pn3t5JrMo/ofPS9Qve5i+0IP1YTzCjwj7
        Qt5bAr4Fr5aHKrtALXP1f4Fa4OEYr7IPJWdjiErbWJoMhV4RubzSGtuztoLzbzeKzwdcWa
        LkFM5DGifU7g8HUNPZc31k5jUcOcdFw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1632260825;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MmQGJX320SQ4PZHIT6qqIM++413uNofSb605veJtUls=;
        b=51wishEjuzRkwfkIV3k1ec7a1+4CQwhMnJYsRAX6+vvLW1sJPtJQf9+e4HLn/WfVnjGS5b
        5EVYZRn/eLAq1lCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id BF75413BF7;
        Tue, 21 Sep 2021 21:47:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id emXmHtVSSmFPJQAAMHmgww
        (envelope-from <neilb@suse.de>); Tue, 21 Sep 2021 21:47:01 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Mel Gorman" <mgorman@techsingularity.net>
Cc:     "Linux-MM" <linux-mm@kvack.org>, "Theodore Ts'o" <tytso@mit.edu>,
        "Andreas Dilger" <adilger.kernel@dilger.ca>,
        "Darrick J . Wong" <djwong@kernel.org>,
        "Matthew Wilcox" <willy@infradead.org>,
        "Michal Hocko" <mhocko@suse.com>,
        "Dave Chinner" <david@fromorbit.com>,
        "Rik van Riel" <riel@surriel.com>,
        "Vlastimil Babka" <vbabka@suse.cz>,
        "Johannes Weiner" <hannes@cmpxchg.org>,
        "Jonathan Corbet" <corbet@lwn.net>,
        "Linux-fsdevel" <linux-fsdevel@vger.kernel.org>,
        "LKML" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/5] mm/vmscan: Throttle reclaim when no progress is being made
In-reply-to: <20210921111630.GR3959@techsingularity.net>
References: <20210920085436.20939-1-mgorman@techsingularity.net>,
 <20210920085436.20939-4-mgorman@techsingularity.net>,
 <163218069080.3992.14261132300912173043@noble.neil.brown.name>,
 <20210921111630.GR3959@techsingularity.net>
Date:   Wed, 22 Sep 2021 07:46:58 +1000
Message-id: <163226081891.21861.1286773174123207227@noble.neil.brown.name>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 21 Sep 2021, Mel Gorman wrote:
> On Tue, Sep 21, 2021 at 09:31:30AM +1000, NeilBrown wrote:
> > On Mon, 20 Sep 2021, Mel Gorman wrote:
> > > +
> > > +		reclaim_throttle(pgdat, VMSCAN_THROTTLE_NOPROGRESS, HZ/10);
> > 
> > We always seem to pass "HZ/10" to reclaim_throttle().  Should we just
> > hard-code that in the one place inside reclaim_throttle() itself?
> > 
> 
> do_writepages passes in HZ/50. I'm not sure if these values even have
> any special meaning, I think it's more likely they were pulled out of
> the air based on the speed of some disk in the past and then copied.
> It's another reason why I want the wakeups to be based on events within
> the mm as much as possible.

Yes, I saw the HZ/50 shortly after writing that email :-)
I agree with your guess for the source of these numbers.  I still think
we should pull them all from the same piece of air.
Hopefully, once these changes are properly understood and the events
reliably come as expected, we can make it quite large (HZ?) with minimal
cost.

Thanks,
NeilBrown


> 
> -- 
> Mel Gorman
> SUSE Labs
> 
> 

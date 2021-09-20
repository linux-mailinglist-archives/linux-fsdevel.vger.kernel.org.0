Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C09C641167C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Sep 2021 16:12:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233724AbhITONc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Sep 2021 10:13:32 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:57632 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230175AbhITONb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Sep 2021 10:13:31 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 3E77F21E7C;
        Mon, 20 Sep 2021 14:12:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1632147124;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7YZycW7OK1xqPCqQ0PYTJxyKG0/lg8miVizE0TtV33s=;
        b=nFG8Lwf9RHij/Hz5MLtk5b2dhULRS3DnSnRo6B0ABmwFh8POog9oEpE0zaXjtlL6i0UyLx
        DaV4jhCTh8Yk6X/A6TZaX0xiClYI2COB5CEmCn1J7kA+3YgaDzJDAkZvjpY1Xb/V6s0BAG
        beN+uvXFsT+aSVCTvAJQH6QrkwiDzqw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1632147124;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7YZycW7OK1xqPCqQ0PYTJxyKG0/lg8miVizE0TtV33s=;
        b=GXP2WHPbdYhcobfrUQXqE+v5htzJez2gLQ3UhwsIfmeeqW5/8NXg/+DBVe7PjIkQbFUNDw
        q4/Kp17W/Iw8r9CQ==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id D161DA3B96;
        Mon, 20 Sep 2021 14:12:03 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 3E029DA7FB; Mon, 20 Sep 2021 16:11:52 +0200 (CEST)
Date:   Mon, 20 Sep 2021 16:11:52 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Linux-MM <linux-mm@kvack.org>, NeilBrown <neilb@suse.de>,
        Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Michal Hocko <mhocko@suse.com>,
        Dave Chinner <david@fromorbit.com>,
        Rik van Riel <riel@surriel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH 0/5] Remove dependency on congestion_wait in mm/
Message-ID: <20210920141152.GM9286@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Mel Gorman <mgorman@techsingularity.net>,
        Matthew Wilcox <willy@infradead.org>, Linux-MM <linux-mm@kvack.org>,
        NeilBrown <neilb@suse.de>, Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Michal Hocko <mhocko@suse.com>, Dave Chinner <david@fromorbit.com>,
        Rik van Riel <riel@surriel.com>, Vlastimil Babka <vbabka@suse.cz>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <20210920085436.20939-1-mgorman@techsingularity.net>
 <YUhztA8TmplTluyQ@casper.infradead.org>
 <20210920125058.GI3959@techsingularity.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210920125058.GI3959@techsingularity.net>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Sep 20, 2021 at 01:50:58PM +0100, Mel Gorman wrote:
> On Mon, Sep 20, 2021 at 12:42:44PM +0100, Matthew Wilcox wrote:
> > On Mon, Sep 20, 2021 at 09:54:31AM +0100, Mel Gorman wrote:
> > > This has been lightly tested only and the testing was useless as the
> > > relevant code was not executed. The workload configurations I had that
> > > used to trigger these corner cases no longer work (yey?) and I'll need
> > > to implement a new synthetic workload. If someone is aware of a realistic
> > > workload that forces reclaim activity to the point where reclaim stalls
> > > then kindly share the details.
> > 
> > The stereeotypical "stalling on I/O" problem is to plug in one of the
> > crap USB drives you were given at a trade show and simply
> > 	dd if=/dev/zero of=/dev/sdb
> > 	sync
> > 
> 
> The test machines are 1500KM away so plugging in a USB stick but worst
> comes to the worst, I could test it on a laptop.

There's a device mapper target dm-delay [1] that as it says delays the
reads and writes, so you could try to emulate the slow USB that way.

[1] https://www.kernel.org/doc/html/latest/admin-guide/device-mapper/delay.html

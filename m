Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1F044375F5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Oct 2021 13:26:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232744AbhJVL27 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 Oct 2021 07:28:59 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:33716 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232741AbhJVL26 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 Oct 2021 07:28:58 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id CE4481FD58;
        Fri, 22 Oct 2021 11:26:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1634901999; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=G+CT6BgCtYpvdAl4MhY2kM2fLPV09SlNX2gZkJNaBZo=;
        b=DmdRpB0nz/eEkPbaRbG5oT04ItfX62+OAxSQO3vWI+pOdkBg8ek78HvN7hTZwHiZmd6hYU
        ZG3SCvUAk20HFuSn5Dr5gKZ3zbkw6/AXc1vGYMYgnnkz0WkD+T4o7qzvXNHwRJD8UN3dYK
        3fFYIBkfAtqPoMqVMpzdBsCp7fcWfrs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1634901999;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=G+CT6BgCtYpvdAl4MhY2kM2fLPV09SlNX2gZkJNaBZo=;
        b=j7JodYggPkHHKNiWjC6WC+fc7I4Vca5MEAR7EZMkb/nSTIY9J28Lv4ZDsmbb/vE6GGh22S
        BhWLFwOhBNrySdDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8228F13CD4;
        Fri, 22 Oct 2021 11:26:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id EaZRDOqfcmHKIQAAMHmgww
        (envelope-from <neilb@suse.de>); Fri, 22 Oct 2021 11:26:34 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
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
In-reply-to: <20211022083927.GI3959@techsingularity.net>
References: <20211019090108.25501-1-mgorman@techsingularity.net>,
 <163486531001.17149.13533181049212473096@noble.neil.brown.name>,
 <20211022083927.GI3959@techsingularity.net>
Date:   Fri, 22 Oct 2021 22:26:30 +1100
Message-id: <163490199006.17149.17259708448207042563@noble.neil.brown.name>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, 22 Oct 2021, Mel Gorman wrote:
> On Fri, Oct 22, 2021 at 12:15:10PM +1100, NeilBrown wrote:
> 
> > In general, I still don't like the use of wake_up_all(), though it won't
> > cause incorrect behaviour.
> > 
> 
> Removing wake_up_all would be tricky.

I think there is a misunderstanding.  Removing wake_up_all() is as
simple as
   s/wake_up_all/wake_up/

If you used prepare_to_wait_exclusive(), then wake_up() would only wake
one waiter, while wake_up_all() would wake all of them.
As you use prepare_to_wait(), wake_up() will wake all waiters - as will
wake_up_all(). 

When I see "wake_up_all()" I assume it is an exclusive wait, and that
for some reason this particular wake_up needs to wake up all waiters.
That is not the case here.

I suspect it would be clearer if "wake_up" always woke everything, and
"wake_up_one" was the special case - but unfortunately that isn't what
we have.

There are other non-exclusive waiters which use wake_up_all(), but the
vast majority of wakeups use wake_up(), and most of those are for
non-exclusive waiters.

Thanks,
NeilBrown

Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76CD841296B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Sep 2021 01:30:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232815AbhITXbc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Sep 2021 19:31:32 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:37828 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232018AbhITX3b (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Sep 2021 19:29:31 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 349961FE8A;
        Mon, 20 Sep 2021 23:28:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1632180483; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/C6da5eeUa7YP9LdZVBTb91w0ysI+DwHwEBCgSWwGeo=;
        b=zSrUNUVFh2Z82i65SHp6/Tr/GGuMWAWfv+emDJ6RNohece0x+m4QE3BBQjaVqhMeefxG3x
        7z3i2SsuGYmhneWI/W6pyYTZtblb8Fhmaehkr3T+aHa5QIZyUGTRzgiQOMcrQSrhgutude
        iuwYti/nOPu2k48JIl6AIXVtwAmVX34=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1632180483;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/C6da5eeUa7YP9LdZVBTb91w0ysI+DwHwEBCgSWwGeo=;
        b=QZHlnr+c9Ur+GAXN3V+zMCNqnBkOLw3ACTa0Mz311Jau3aKxgdTwAAtuwc68ZMKsaFOBTJ
        ZBuAdQCWRRwIc4Bw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4795A13B38;
        Mon, 20 Sep 2021 23:27:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id TDWWAf8YSWFiaAAAMHmgww
        (envelope-from <neilb@suse.de>); Mon, 20 Sep 2021 23:27:59 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
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
        "LKML" <linux-kernel@vger.kernel.org>,
        "Mel Gorman" <mgorman@techsingularity.net>
Subject: Re: [PATCH 2/5] mm/vmscan: Throttle reclaim and compaction when too
 may pages are isolated
In-reply-to: <20210920085436.20939-3-mgorman@techsingularity.net>
References: <20210920085436.20939-1-mgorman@techsingularity.net>,
 <20210920085436.20939-3-mgorman@techsingularity.net>
Date:   Tue, 21 Sep 2021 09:27:56 +1000
Message-id: <163218047640.3992.16597395100064789255@noble.neil.brown.name>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 20 Sep 2021, Mel Gorman wrote:
> @@ -2291,8 +2302,7 @@ shrink_inactive_list(unsigned long nr_to_scan, struct=
 lruvec *lruvec,
>  			return 0;
> =20
>  		/* wait a bit for the reclaimer. */
> -		msleep(100);
> -		stalled =3D true;
> +		reclaim_throttle(pgdat, VMSCAN_THROTTLE_ISOLATED, HZ/10);

Why drop the assignment to "stalled"?
Doing that changes the character of the loop - and makes the 'stalled'
variable always 'false'.

NeilBrown

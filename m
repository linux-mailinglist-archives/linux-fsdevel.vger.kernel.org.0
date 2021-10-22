Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 219B7436F45
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Oct 2021 03:07:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231921AbhJVBKL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 Oct 2021 21:10:11 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:35500 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbhJVBKK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 Oct 2021 21:10:10 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 85D361FD5D;
        Fri, 22 Oct 2021 01:07:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1634864872; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UhUuNIRaH32Jg6rNRG9aJqS7Vzin0wwV0iGwsDMIo8Y=;
        b=JWeAJeHHc23DutYi/I3mBxe0vpnYRi37B0yVlrR84wIEUTZfLpsZ4VUzwPkXUpi9zP2blY
        AoJpZHcfy62DoUpkDjPJiJpulIfe1q4pEP3BKWpZ7O6IdoYtKZLVm1zW0QScowM+35dIXl
        WivDFoKYGvvr3tgs+J5vFRSsPwl04HU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1634864872;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UhUuNIRaH32Jg6rNRG9aJqS7Vzin0wwV0iGwsDMIo8Y=;
        b=MRDubLBijrL0abU+hF316RmPJCeCcnsIhZ6AbgVbj5+ERWZkIJnQpwD1YqxoO+ELWDNnE2
        f0mqdAzRG+motvAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0E4B01346B;
        Fri, 22 Oct 2021 01:07:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id KRnFKuIOcmHrJQAAMHmgww
        (envelope-from <neilb@suse.de>); Fri, 22 Oct 2021 01:07:46 +0000
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
Subject: Re: [PATCH 7/8] mm/vmscan: Increase the timeout if page reclaim is
 not making progress
In-reply-to: <20211019090108.25501-8-mgorman@techsingularity.net>
References: <20211019090108.25501-1-mgorman@techsingularity.net>,
 <20211019090108.25501-8-mgorman@techsingularity.net>
Date:   Fri, 22 Oct 2021 12:07:43 +1100
Message-id: <163486486314.17149.7181265861483962024@noble.neil.brown.name>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 19 Oct 2021, Mel Gorman wrote:
> Tracing of the stutterp workload showed the following delays
>=20
>       1 usect_delayed=3D124000 reason=3DVMSCAN_THROTTLE_NOPROGRESS
>       1 usect_delayed=3D128000 reason=3DVMSCAN_THROTTLE_NOPROGRESS
>       1 usect_delayed=3D176000 reason=3DVMSCAN_THROTTLE_NOPROGRESS
>       1 usect_delayed=3D536000 reason=3DVMSCAN_THROTTLE_NOPROGRESS
>       1 usect_delayed=3D544000 reason=3DVMSCAN_THROTTLE_NOPROGRESS
>       1 usect_delayed=3D556000 reason=3DVMSCAN_THROTTLE_NOPROGRESS
>       1 usect_delayed=3D624000 reason=3DVMSCAN_THROTTLE_NOPROGRESS
>       1 usect_delayed=3D716000 reason=3DVMSCAN_THROTTLE_NOPROGRESS
>       1 usect_delayed=3D772000 reason=3DVMSCAN_THROTTLE_NOPROGRESS
>       2 usect_delayed=3D512000 reason=3DVMSCAN_THROTTLE_NOPROGRESS
>      16 usect_delayed=3D120000 reason=3DVMSCAN_THROTTLE_NOPROGRESS
>      53 usect_delayed=3D116000 reason=3DVMSCAN_THROTTLE_NOPROGRESS
>     116 usect_delayed=3D112000 reason=3DVMSCAN_THROTTLE_NOPROGRESS
>    5907 usect_delayed=3D108000 reason=3DVMSCAN_THROTTLE_NOPROGRESS
>   71741 usect_delayed=3D104000 reason=3DVMSCAN_THROTTLE_NOPROGRESS
>=20
> All the throttling hit the full timeout and then there was wakeup delays
> meaning that the wakeups are premature as no other reclaimer such as
> kswapd has made progress. This patch increases the maximum timeout.

Would love to see the comparable tracing results for after the patch.

Thanks,
NeilBrown


>=20
> Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
> Acked-by: Vlastimil Babka <vbabka@suse.cz>
> ---
>  mm/vmscan.c | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index 1f5c467dc83c..ec2006680242 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -1033,6 +1033,8 @@ void reclaim_throttle(pg_data_t *pgdat, enum vmscan_t=
hrottle_state reason)
>  	 */
>  	switch(reason) {
>  	case VMSCAN_THROTTLE_NOPROGRESS:
> +		timeout =3D HZ/2;
> +		break;
>  	case VMSCAN_THROTTLE_WRITEBACK:
>  		timeout =3D HZ/10;
> =20
> --=20
> 2.31.1
>=20
>=20

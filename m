Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B89241296F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Sep 2021 01:33:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235410AbhITXfG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Sep 2021 19:35:06 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:45376 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238939AbhITXdG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Sep 2021 19:33:06 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id ACD2E2209E;
        Mon, 20 Sep 2021 23:31:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1632180697; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=p+xWJ0YkatGIKOHgIGcojVmd5miNxn0VeGIwFFaZE0g=;
        b=NIWYSMW7/xcDx9iujTBP2ZVH/ylAswRbkhrJNa8S6dq0m0/Hk6cwP0EwSbMYWJuwHLP4tR
        G16gMLywCWg9GxCUeEflCtWs8uiA7TmRRJj9RrU5OVxyQ3zdc2bK2lBBRGok0RBfHPXPje
        SbwcGzL5TN+fQks5SFlkTWZtQK+KCLU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1632180697;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=p+xWJ0YkatGIKOHgIGcojVmd5miNxn0VeGIwFFaZE0g=;
        b=4cGiKRfw6Tdv5gQ50a591jAd2tWJ2v5dWHV/wjFpwW93rfTOpjhhaklqRASgPIhRywUWOl
        hR4tNr8Pv290q7Bg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C640613B2E;
        Mon, 20 Sep 2021 23:31:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 4IkQIdUZSWGjaQAAMHmgww
        (envelope-from <neilb@suse.de>); Mon, 20 Sep 2021 23:31:33 +0000
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
        "LKML" <linux-kernel@vger.kernel.org>,
        "Mel Gorman" <mgorman@techsingularity.net>
Subject: Re: [PATCH 3/5] mm/vmscan: Throttle reclaim when no progress is being made
In-reply-to: <20210920085436.20939-4-mgorman@techsingularity.net>
References: <20210920085436.20939-1-mgorman@techsingularity.net>,
 <20210920085436.20939-4-mgorman@techsingularity.net>
Date:   Tue, 21 Sep 2021 09:31:30 +1000
Message-id: <163218069080.3992.14261132300912173043@noble.neil.brown.name>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 20 Sep 2021, Mel Gorman wrote:
> +
> +		reclaim_throttle(pgdat, VMSCAN_THROTTLE_NOPROGRESS, HZ/10);

We always seem to pass "HZ/10" to reclaim_throttle().  Should we just
hard-code that in the one place inside reclaim_throttle() itself?

NeilBrown

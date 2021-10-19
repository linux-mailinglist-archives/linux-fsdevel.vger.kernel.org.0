Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E7A743320D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Oct 2021 11:21:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234957AbhJSJXN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Oct 2021 05:23:13 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:39952 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234871AbhJSJXG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Oct 2021 05:23:06 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 076B4219CB;
        Tue, 19 Oct 2021 09:20:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1634635253; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9VgWU1s/0gfGgLR7Sl7F/C/e7bwTkKRJ55tTUCwUG3Q=;
        b=I7lUoBhQOzqQfnnYWPGQClpg5p/2Xbgea6OGzW7r0jDuDJQ7+lsXqehJaVWa8FCpHbNy6Z
        /q53kp04oHpionNd3EDUhoRyaWczReKDVg8b7jiJUFGA439cCaSWqbuoFpeNBhP2zx7t6Y
        LbQOFHHuqB4WbKkcTXpX4WWzU51OMxE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1634635253;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9VgWU1s/0gfGgLR7Sl7F/C/e7bwTkKRJ55tTUCwUG3Q=;
        b=CmF3MEuzA5v8iCj1RhQJTAVRZu36POV3h4AmgVINadSaklB0hdDv6xe5H7ucUDE82c2hIE
        N1nHTvOqJmQQ8ZCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B713A13FE1;
        Tue, 19 Oct 2021 09:20:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 2YHCK/SNbmEwKQAAMHmgww
        (envelope-from <vbabka@suse.cz>); Tue, 19 Oct 2021 09:20:52 +0000
Message-ID: <2d3d2636-a8ba-4aa1-e7f7-1a00bd7eb097@suse.cz>
Date:   Tue, 19 Oct 2021 11:20:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH 5/8] mm/page_alloc: Remove the throttling logic from the
 page allocator
Content-Language: en-US
To:     Mel Gorman <mgorman@techsingularity.net>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     NeilBrown <neilb@suse.de>, Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@suse.com>,
        Dave Chinner <david@fromorbit.com>,
        Rik van Riel <riel@surriel.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Linux-MM <linux-mm@kvack.org>,
        Linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <20211019090108.25501-1-mgorman@techsingularity.net>
 <20211019090108.25501-6-mgorman@techsingularity.net>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20211019090108.25501-6-mgorman@techsingularity.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 10/19/21 11:01, Mel Gorman wrote:
> The page allocator stalls based on the number of pages that are
> waiting for writeback to start but this should now be redundant.
> shrink_inactive_list() will wake flusher threads if the LRU tail are
> unqueued dirty pages so the flusher should be active. If it fails to make
> progress due to pages under writeback not being completed quickly then
> it should stall on VMSCAN_THROTTLE_WRITEBACK.
> 
> Signed-off-by: Mel Gorman <mgorman@techsingularity.net>

Acked-by: Vlastimil Babka <vbabka@suse.cz>

(did in v3 already)

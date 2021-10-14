Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BD3542DE49
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Oct 2021 17:38:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231526AbhJNPkY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 14 Oct 2021 11:40:24 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:50958 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230389AbhJNPkV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 14 Oct 2021 11:40:21 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 57BA02197C;
        Thu, 14 Oct 2021 15:38:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1634225895; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GxLH0z7C+H9xHqrBRI+kBoQatoT6Befch1xXUBOMRvk=;
        b=wbuuGwLQVKd5RGDVEuiKlyGa4uSDIPQIj3iTwLLGyLMsj1FIXqLCyC4SWZfKz9Y52rxVWX
        jXSR6UdtN2SQhnvuIhAzM/7S110oBFVEVXWBPV3vnUO19qOAd4fui4K9xCBADnjX1NIDKO
        kouz2fDzruRykAWYJYRg1X9KxXcNFmY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1634225895;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GxLH0z7C+H9xHqrBRI+kBoQatoT6Befch1xXUBOMRvk=;
        b=HWNic10Z5eyZjDRof2nMzOceoNhhVXTEui8u/gJbvPKg83g3XcTyKgV28mYXRyPhO4MWOj
        nV62pu27waEV4ABA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2A73E13D9F;
        Thu, 14 Oct 2021 15:38:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id BIG+CedOaGEwHwAAMHmgww
        (envelope-from <vbabka@suse.cz>); Thu, 14 Oct 2021 15:38:15 +0000
Message-ID: <76454f39-8e41-e757-3a71-c85303c6257e@suse.cz>
Date:   Thu, 14 Oct 2021 17:38:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH 6/8] mm/vmscan: Centralise timeout values for
 reclaim_throttle
Content-Language: en-US
To:     Mel Gorman <mgorman@techsingularity.net>,
        Linux-MM <linux-mm@kvack.org>
Cc:     NeilBrown <neilb@suse.de>, Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@suse.com>,
        Dave Chinner <david@fromorbit.com>,
        Rik van Riel <riel@surriel.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <20211008135332.19567-1-mgorman@techsingularity.net>
 <20211008135332.19567-7-mgorman@techsingularity.net>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20211008135332.19567-7-mgorman@techsingularity.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 10/8/21 15:53, Mel Gorman wrote:
> Neil Brown raised concerns about callers of reclaim_throttle specifying
> a timeout value. The original timeout values to congestion_wait() were
> probably pulled out of thin air or copy&pasted from somewhere else.
> This patch centralises the timeout values and selects a timeout based
> on the reason for reclaim throttling. These figures are also pulled
> out of the same thin air but better values may be derived
> 
> Running a workload that is throttling for inappropriate periods
> and tracing mm_vmscan_throttled can be used to pick a more appropriate
> value. Excessive throttling would pick a lower timeout where as
> excessive CPU usage in reclaim context would select a larger timeout.
> Ideally a large value would always be used and the wakeups would
> occur before a timeout but that requires careful testing.
> 
> Signed-off-by: Mel Gorman <mgorman@techsingularity.net>

Acked-by: Vlastimil Babka <vbabka@suse.cz>

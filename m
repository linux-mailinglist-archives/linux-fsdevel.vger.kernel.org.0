Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8A3D4221F4
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Oct 2021 11:16:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233568AbhJEJR6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 5 Oct 2021 05:17:58 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:32864 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232920AbhJEJR5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 5 Oct 2021 05:17:57 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id D14BF222E2;
        Tue,  5 Oct 2021 09:16:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1633425365; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/ThOmbiGRYKn2nnNwyvJcqEVvTNtr1GRMmAy+3vp6S8=;
        b=N+YuAsS0RWIkK8xSiaVHWPrcFj6Vkw5RjrUbcXkNWatj1zS9tp7bJ2LIFCYBeBqvSsEYUH
        /iTUxFMrteXb9ipCsAvKDk9+1W+Nqo6ARm5jzX8teZhaVWsLbm81JkgtrPB5gyjIPCacgj
        iPyurgn4Fdd7QHkVFLiT5BYKQSa7fCc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1633425365;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/ThOmbiGRYKn2nnNwyvJcqEVvTNtr1GRMmAy+3vp6S8=;
        b=df+BMW9OkAfq6YBbymxZbcDCld7xAbE3FMddRc4PnOqTXLGNmbzwPjAM4RDqkYJhHIdqra
        4wCAPW6bQiQkJ6AQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8C631133A7;
        Tue,  5 Oct 2021 09:16:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id rLeKIdUXXGGuegAAMHmgww
        (envelope-from <vbabka@suse.cz>); Tue, 05 Oct 2021 09:16:05 +0000
Message-ID: <60ffc506-236c-faf7-ba64-5d853d3a67e7@suse.cz>
Date:   Tue, 5 Oct 2021 11:16:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.2
Content-Language: en-US
To:     Mel Gorman <mgorman@suse.de>, NeilBrown <neilb@suse.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@suse.com>,
        Jesper Dangaard Brouer <jbrouer@redhat.com>,
        ". Dave Chinner" <david@fromorbit.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-xfs@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-nfs@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
References: <163184698512.29351.4735492251524335974.stgit@noble.brown>
 <163184741776.29351.3565418361661850328.stgit@noble.brown>
 <20210917144233.GD3891@suse.de>
From:   Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH 1/6] MM: Support __GFP_NOFAIL in alloc_pages_bulk_*() and
 improve doco
In-Reply-To: <20210917144233.GD3891@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 9/17/21 16:42, Mel Gorman wrote:
> I'm top-posting to cc Jesper with full context of the patch. I don't
> have a problem with this patch other than the Fixes: being a bit
> marginal, I should have acked as Mel Gorman <mgorman@suse.de> and the
> @gfp in the comment should have been @gfp_mask.
> 
> However, an assumption the API design made was that it should fail fast
> if memory is not quickly available but have at least one page in the
> array. I don't think the network use case cares about the situation where
> the array is already populated but I'd like Jesper to have the opportunity
> to think about it.  It's possible he would prefer it's explicit and the
> check becomes
> (!nr_populated || ((gfp_mask & __GFP_NOFAIL) && !nr_account)) to

Note that AFAICS nr_populated is an incomplete piece of information, as we
initially only count pages in the page_array as nr_populated up to the first
NULL pointer. So even before Neil's patch we could decide to allocate even
if there are pre-existing pages, but placed later in the array. Which could
be rather common if the array consumer starts from index 0? So with Neil's
patch this at least becomes consistent, while the check suggested by Mel
leaves there the weird dependency on where pre-existing pages appear in the
page_array.

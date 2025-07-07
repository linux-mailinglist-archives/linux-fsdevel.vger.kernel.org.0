Return-Path: <linux-fsdevel+bounces-54111-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03186AFB5A2
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Jul 2025 16:14:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E719D17DB2A
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Jul 2025 14:14:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7FC62BE05F;
	Mon,  7 Jul 2025 14:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="2376GiWL";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="9pC5qqvz";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="2376GiWL";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="9pC5qqvz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 968C229B782
	for <linux-fsdevel@vger.kernel.org>; Mon,  7 Jul 2025 14:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751897673; cv=none; b=b2TJLFCg4otKLSBwICDpnDXQVpW/QLqlt72qVP0zC1ToG5w8/mpUsQKR3H9iYqkUcpchX+121wJ1UsCY8p8NXLIUv5gvddbhSRZhf5NOUU73pOSxmKk/FitV5ohpq7RiVygxQwRxgbnqi6ziBpxvyhJa4oWeKyGCbh1R5Dmdulc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751897673; c=relaxed/simple;
	bh=wyyuJDrRfoNJOmcanbvB4+TVaoG0zMMIZkVOHnDpIVc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=l70T0aNbfevcLHFLX5BV8CoclFqokGXfz2ytZMugKLgdrvRWPa8y0jGylHbJES4eoiNrvNr4e3Cx0qAHIeXIlG8f5AokFywpK3uXekJdImBhqPpZBpeJV+Fg+EgJVssTIaMMz8RgL4zjrUy4qT0QJ1B2IQ2sG5+bVnyZTsRZ5CI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=2376GiWL; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=9pC5qqvz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=2376GiWL; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=9pC5qqvz; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id D2AD721169;
	Mon,  7 Jul 2025 14:14:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1751897668; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=jLZYdJeenU37StAo31l/djlK1WDY3qDtjHuaWSDBpeI=;
	b=2376GiWLhZkC3nXDMVhHeSl9tiJUIEhuBiE+AbRhrCcb7D/K+WVvEZvJ2z6T+ZmGCsmJvV
	4NCGQkajTub7LNOJzXebfdHBygrWfI9SY8BlJA3/jyRwFYvbu4khy8oDxdqFgvBBE+TSHR
	R6aTJxvFl63iOPh2TTFoSyGBAp5Z4y0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1751897668;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=jLZYdJeenU37StAo31l/djlK1WDY3qDtjHuaWSDBpeI=;
	b=9pC5qqvzGMg0wh3oWA4ItU4tK4Lw3GisfGVzcsaiExKo6Z67zng4/gBWQJ/9GkXrCZ7uWR
	WEYqGD0/6EqjFKBw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1751897668; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=jLZYdJeenU37StAo31l/djlK1WDY3qDtjHuaWSDBpeI=;
	b=2376GiWLhZkC3nXDMVhHeSl9tiJUIEhuBiE+AbRhrCcb7D/K+WVvEZvJ2z6T+ZmGCsmJvV
	4NCGQkajTub7LNOJzXebfdHBygrWfI9SY8BlJA3/jyRwFYvbu4khy8oDxdqFgvBBE+TSHR
	R6aTJxvFl63iOPh2TTFoSyGBAp5Z4y0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1751897668;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=jLZYdJeenU37StAo31l/djlK1WDY3qDtjHuaWSDBpeI=;
	b=9pC5qqvzGMg0wh3oWA4ItU4tK4Lw3GisfGVzcsaiExKo6Z67zng4/gBWQJ/9GkXrCZ7uWR
	WEYqGD0/6EqjFKBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A190A13757;
	Mon,  7 Jul 2025 14:14:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id rz6eJUTWa2iOKgAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Mon, 07 Jul 2025 14:14:28 +0000
Message-ID: <5a848e15-6a57-4ecb-a015-d4f358b8a5d3@suse.cz>
Date: Mon, 7 Jul 2025 16:14:28 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm, vmstat: remove the NR_WRITEBACK_TEMP node_stat_item
 counter
Content-Language: en-US
To: Andrew Morton <akpm@linux-foundation.org>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: Tejun Heo <tj@kernel.org>, Maxim Patlasov <mpatlasov@parallels.com>,
 Jan Kara <jack@suse.cz>, Zach O'Keefe <zokeefe@google.com>,
 Jonathan Corbet <corbet@lwn.net>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
 Brendan Jackman <jackmanb@google.com>, Johannes Weiner <hannes@cmpxchg.org>,
 Zi Yan <ziy@nvidia.com>, Joanne Koong <joannelkoong@gmail.com>,
 Jingbo Xu <jefflexu@linux.alibaba.com>, Jeff Layton <jlayton@kernel.org>,
 Miklos Szeredi <mszeredi@redhat.com>, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-mm@kvack.org, Jens Axboe <axboe@kernel.dk>
References: <20250625-nr_writeback_removal-v1-1-7f2a0df70faa@suse.cz>
From: Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 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
 m6M14QORSWTLRg==
In-Reply-To: <20250625-nr_writeback_removal-v1-1-7f2a0df70faa@suse.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[25];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,parallels.com,suse.cz,google.com,lwn.net,linuxfoundation.org,suse.com,linux.intel.com,cmpxchg.org,nvidia.com,gmail.com,linux.alibaba.com,redhat.com,vger.kernel.org,kvack.org,kernel.dk];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:mid,suse.cz:email]
X-Spam-Flag: NO
X-Spam-Level: 
X-Spam-Score: -4.30

On 6/25/25 17:51, Vlastimil Babka wrote:
> The only user of the counter (FUSE) was removed in commit 0c58a97f919c
> ("fuse: remove tmp folio for writebacks and internal rb tree") so follow
> the established pattern of removing the counter and hardcoding 0 in
> meminfo output, as done recently with NR_BOUNCE. Update documentation
> for procfs, including for the value for Bounce that was missed when
> removing its counter.
> 
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
> ---
> The removal of the counter is straightforward. The reason for the large
> Cc list is that there is a comment in mm/page-writeback.c function
> wb_position_ratio() that mentions NR_WRITEBACK_TEMP, and just deleting
> the sentence feels to me it could be the wrong thing to do - maybe the
> strictlimit feature itself is now obsolete? It sure does mention FUSE
> as the main reason to exist, but commit 5a53748568f79 that introduced it
> also mentions slow USB sticks as a possibile scenario. Has that
> happened? I'm not familiar enough with this so I'd rather highlight this
> and ask for input here than make "git grep NR_WRITEBACK_TEMP" return
> nothing.

Thanks all for the input. Andrew, please squash in this fixup. The changelog
of that can be appended to the changelog of the original patch. Thanks.

----8<----
From 55d9070995010991abc0c6dbd68a8a53b5d622bc Mon Sep 17 00:00:00 2001
From: Vlastimil Babka <vbabka@suse.cz>
Date: Mon, 7 Jul 2025 16:09:31 +0200
Subject: [PATCH] mm, vmstat: remove the NR_WRITEBACK_TEMP node_stat_item
 counter-fix

Also remove the mention of NR_WRITEBACK_TEMP implications from a comment
in wb_position_ratio(). The rest of the comment there about fuse setting
bdi->max_ratio to 1% is still correct.

Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
---
 mm/page-writeback.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/mm/page-writeback.c b/mm/page-writeback.c
index 72b0ff0d4bae..3e248d1c3969 100644
--- a/mm/page-writeback.c
+++ b/mm/page-writeback.c
@@ -1101,9 +1101,7 @@ static void wb_position_ratio(struct dirty_throttle_control *dtc)
 	 * such filesystems balance_dirty_pages always checks wb counters
 	 * against wb limits. Even if global "nr_dirty" is under "freerun".
 	 * This is especially important for fuse which sets bdi->max_ratio to
-	 * 1% by default. Without strictlimit feature, fuse writeback may
-	 * consume arbitrary amount of RAM because it is accounted in
-	 * NR_WRITEBACK_TEMP which is not involved in calculating "nr_dirty".
+	 * 1% by default.
 	 *
 	 * Here, in wb_position_ratio(), we calculate pos_ratio based on
 	 * two values: wb_dirty and wb_thresh. Let's consider an example:
-- 
2.50.0





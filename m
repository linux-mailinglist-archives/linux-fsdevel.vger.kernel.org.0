Return-Path: <linux-fsdevel+bounces-52536-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DF8A5AE3E6C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Jun 2025 13:47:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8833F1897A2A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Jun 2025 11:48:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97B97248F46;
	Mon, 23 Jun 2025 11:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="RGCfOQeJ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="YaW3yg9M";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="RGCfOQeJ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="YaW3yg9M"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85B5B248886
	for <linux-fsdevel@vger.kernel.org>; Mon, 23 Jun 2025 11:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750679179; cv=none; b=n20w2+DpuFepwbuvKUpAEKTf2MfMWFurgwZRdKiiPTGzqT9Eshh4COEofD3tdX/Sz/C3+WxmS7+iX/g9Fp7d2iGN7Ck9+Uv38z62tXwu4lGo7yBLrAMyzsA5d1egOqIRc/GOVNVkWrdbnIM+0DmK4JH37YlrOzF5+HlOuFH4P/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750679179; c=relaxed/simple;
	bh=KVCn3pmMJ5yCE9/Zk+aqhDjnGhs1KKfsE2Frela8LbQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z0dj9jFqXZedxR5TC5KgM6FemCYuolEEuNpAMwnmqjX0foZx1am2hJEzAZS7BF/RnOA93dF2RUwFoMqoaN9PmgSx9AjAxUqjb5ImkkprRkXkIWrwxW5YpGBlqJE7J3b8ycZR6bxNqKdxZkXfrdEEqBQi7d4lpYZjMun4+j4oYcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=RGCfOQeJ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=YaW3yg9M; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=RGCfOQeJ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=YaW3yg9M; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 9A4D91F457;
	Mon, 23 Jun 2025 11:46:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1750679169; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=85n04soQnTCspGUaqCxhy29BgIf3j4nlIk46T5YAzUY=;
	b=RGCfOQeJLcVCKlFWzY+AutjvAGUSCzMHSsj2mDWzbWFGuAQUK8Z9lqIDNxllMbX2iwMXmO
	r0miBWkH81zwzfSaJv03zEz8MWROtaYAmZeZl19ya6bM1oWPqIf5QSzG6Ov0t5uht/5mxU
	Mrs7X8TYW0qK9U2RWJueh4e57l0FRCk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1750679169;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=85n04soQnTCspGUaqCxhy29BgIf3j4nlIk46T5YAzUY=;
	b=YaW3yg9MuMH/odDJ2AOLcTGXzwtGwQ9tacQ/LyfLJ1OVSHcwQhg2BfFD+YDaR1EHtmgfdF
	O4y47yPQWsoxh0Cg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1750679169; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=85n04soQnTCspGUaqCxhy29BgIf3j4nlIk46T5YAzUY=;
	b=RGCfOQeJLcVCKlFWzY+AutjvAGUSCzMHSsj2mDWzbWFGuAQUK8Z9lqIDNxllMbX2iwMXmO
	r0miBWkH81zwzfSaJv03zEz8MWROtaYAmZeZl19ya6bM1oWPqIf5QSzG6Ov0t5uht/5mxU
	Mrs7X8TYW0qK9U2RWJueh4e57l0FRCk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1750679169;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=85n04soQnTCspGUaqCxhy29BgIf3j4nlIk46T5YAzUY=;
	b=YaW3yg9MuMH/odDJ2AOLcTGXzwtGwQ9tacQ/LyfLJ1OVSHcwQhg2BfFD+YDaR1EHtmgfdF
	O4y47yPQWsoxh0Cg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 62D3813A27;
	Mon, 23 Jun 2025 11:46:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id O55gFoE+WWgRNQAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 23 Jun 2025 11:46:09 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 0D650A29FA; Mon, 23 Jun 2025 09:38:53 +0200 (CEST)
Date: Mon, 23 Jun 2025 09:38:53 +0200
From: Jan Kara <jack@suse.cz>
To: Zhang Yi <yi.zhang@huaweicloud.com>
Cc: Jan Kara <jack@suse.cz>, linux-ext4@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, tytso@mit.edu, 
	adilger.kernel@dilger.ca, ojaswin@linux.ibm.com, yi.zhang@huawei.com, libaokun1@huawei.com, 
	yukuai3@huawei.com, yangerkun@huawei.com
Subject: Re: [PATCH v2 2/6] ext4: fix stale data if it bail out of the
 extents mapping loop
Message-ID: <cqhltjvxmmbv4fafoc6gb4lisd63osqw44njmxjvmpgqzkqn3g@ncworvfx7iys>
References: <20250611111625.1668035-1-yi.zhang@huaweicloud.com>
 <20250611111625.1668035-3-yi.zhang@huaweicloud.com>
 <m5drn6xauyaksmui7b3vpua24ttgmjnwsi3sgavpelxlcwivsw@6bpmobqvpw7f>
 <14966764-5bbc-48a9-9d56-841255cfe3c6@huaweicloud.com>
 <ygdwliycwt52ngkl2o4lia3hzyug3zzvc2hdacbdi3lvbzne7l@l7ub66fvqym6>
 <49596299-8cd5-4b43-ba32-cf2b404236a7@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <49596299-8cd5-4b43-ba32-cf2b404236a7@huaweicloud.com>
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_COUNT_THREE(0.00)[3];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -3.80

On Sat 21-06-25 12:42:11, Zhang Yi wrote:
> On 2025/6/20 23:21, Jan Kara wrote:
> > I suspect you thought that the failure to extend transaction in the middle
> > of order 0 folio should not happen because you reserve credits for full
> > page worth of writeback? But those credits could be exhaused by the time we
> > get to mapping third folio because mpage_map_one_extent() only ensures
> > there are credits for mapping one extent.
> 
> Ooops, you are right. Sorry, it was my mistake.
> 
> > 
> > And I think reserving credits for just one extent is fine even from the
> > beginning (as I wrote in my comment to patch 4). We just need to handle
> > this partial case 
> 
> Yeah.
> 
> > which should be possible by just leaving
> > mpd->first_page untouched and leave unlocking to
> > mpage_release_unused_pages(). 
> 
> I was going to use this solution, but it breaks the semantics of the
> mpage_release_unused_pages() and trigger BUG_ON(folio_test_writeback(folio))
> in this function. I don't want to drop this BUG_ON since I think it's
> somewhat useful.

Oh, right. Well, we could modify the BUG_ON to:

	/*
	 * first_page folio can be under writeback if we need to restart
         * transaction to map more
	 */
	BUG_ON((invalidate || folio->inode > mpd->first_page) && folio_test_writeback(folio));

> > But I can be missing some effects, the writeback code is really complex...
> 
> Indeed, I was confused by this code for a long time. Thank you a lot for
> patiently correcting my mistakes in my patch.

Thank you for taking time to properly fix these issues :)

> > BTW long-term the code may be easier to follow if we replace
> > mpd->first_page and mpd->next_page with logical block based or byte based
> > indexing. Now when we have large order folios, page is not that important
> > concept for writeback anymore.
> 
> I suppose we should do this conversion now.

Yes or this... I guess it would be more obvious what's going on this way.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR


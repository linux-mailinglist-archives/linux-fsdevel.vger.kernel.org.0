Return-Path: <linux-fsdevel+bounces-70449-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D327BC9B3F1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 02 Dec 2025 12:01:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C80403A63BA
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Dec 2025 11:01:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7765C30BF6D;
	Tue,  2 Dec 2025 11:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="BsigXTSk";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="+zyTFxGC";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="B8T1ZMee";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="O8KgmaIg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 403EC223DEF
	for <linux-fsdevel@vger.kernel.org>; Tue,  2 Dec 2025 11:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764673266; cv=none; b=W9Ug9cq5/cfzMro6PCJ81e2+zmcON9Qu9LU+k0bKUHsuteve557uS4UxNj5I+JSJUdrmMuSp17EBylQJ2dBatiW7RTrZtmo5K6VwpQ09n4hhN93F9Q3U+h0z8c5504DDJgf1WwDONq+/wailazJeTe82FcAZskw5Z2qmHPNEn30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764673266; c=relaxed/simple;
	bh=NQC/2H20E3uzfmG1Ov2QyhlVwe7zK10GUYNYRX+6bHE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dPqNfFGwiY/S8MayEPR8Sjg6cL/TkOmWv/u9b+44glzyBVSiU03XlRJE7kUl7iZvoqpFdY17mT7q/maQFnOZ+/IMZXg/rSFyKtME14WNfdGmW/VyNHzMRvmaQ1fGiHUUZCqYuPByr7eQ8//rVDr0ymxYd7p4vrbC+fccz1oaZ3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=BsigXTSk; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=+zyTFxGC; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=B8T1ZMee; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=O8KgmaIg; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 31FD833697;
	Tue,  2 Dec 2025 11:01:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1764673263; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eL1k6OzgMQQLmwBTWiq3h/Cj6eUJKa3OgIBJUfzx080=;
	b=BsigXTSkyjLR0gKtAt4fyLHlzOjstxNoyYTf9qOt7t8jYMUlD5f3AA9C50ef6QNH7GnO4n
	C29e1ZAgpFssl0Pwk0U3So4hXlJUvS74rugXM82OD5OyIuWUysVaur2jWthHFsgyj7JK0Z
	vd1+6EqDvEkcBcFHEJzsfeIt2wzmx+U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1764673263;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eL1k6OzgMQQLmwBTWiq3h/Cj6eUJKa3OgIBJUfzx080=;
	b=+zyTFxGC4sTS6pK9CS/xgX12/hNwUV0HXUhINHABNufIUDIt9n91RX3eZKrl7cBihrM7Y5
	E/eLl7L8WFQq22DQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1764673262; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eL1k6OzgMQQLmwBTWiq3h/Cj6eUJKa3OgIBJUfzx080=;
	b=B8T1ZMeeFRvDjIKkrUyEixQpuzn3Ad2NTLJAB8rLbXnyP/QYZrAwJOW1WP/l7/7sFaT0ny
	8hHiAYOxa8JcuERitU/RmwOAusnMnt2Hqr4QcUpvRA1swJiAauyhSKgMCE07jGp6v9kS1E
	SJgoneDvxCC8u5/uxfDP7R3/MR5rzDY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1764673262;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eL1k6OzgMQQLmwBTWiq3h/Cj6eUJKa3OgIBJUfzx080=;
	b=O8KgmaIgxsMJvHRl0os8BEtEhw09yUasQQWcI0d6EoQJjE348SkjAmwnckt55Cycqc+7dO
	RfYxbVsORyPRLOAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 22ECA3EA63;
	Tue,  2 Dec 2025 11:01:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id CeZ/CO7GLmk5NwAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 02 Dec 2025 11:01:02 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id CEEFBA09DA; Tue,  2 Dec 2025 12:01:01 +0100 (CET)
Date: Tue, 2 Dec 2025 12:01:01 +0100
From: Jan Kara <jack@suse.cz>
To: Chen Ridong <chenridong@huaweicloud.com>
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz, 
	hannes@cmpxchg.org, mhocko@kernel.org, roman.gushchin@linux.dev, 
	shakeel.butt@linux.dev, muchun.song@linux.dev, tj@kernel.org, mkoutny@suse.com, 
	akpm@linux-foundation.org, vbabka@suse.cz, surenb@google.com, jackmanb@google.com, 
	ziy@nvidia.com, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	cgroups@vger.kernel.org, linux-mm@kvack.org, lujialin4@huawei.com, chenridong@huawei.com
Subject: Re: [PATCH -next] cgroup: switch to css_is_online() helper
Message-ID: <dzp6jxmf5ggidkhmqabuttaotyrkxzf6ohiuzgcdn6oppkcmfc@vrjeeypoppwe>
References: <20251202025747.1658159-1-chenridong@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251202025747.1658159-1-chenridong@huaweicloud.com>
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[22];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[huawei.com:email,suse.com:email,imap1.dmz-prg2.suse.org:helo,suse.cz:email]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -3.80

On Tue 02-12-25 02:57:47, Chen Ridong wrote:
> From: Chen Ridong <chenridong@huawei.com>
> 
> Use the new css_is_online() helper that has been introduced to check css
> online state, instead of testing the CSS_ONLINE flag directly. This
> improves readability and centralizes the state check logic.
> 
> No functional changes intended.
> 
> Signed-off-by: Chen Ridong <chenridong@huawei.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/fs-writeback.c          | 2 +-
>  include/linux/memcontrol.h | 2 +-
>  kernel/cgroup/cgroup.c     | 4 ++--
>  mm/memcontrol.c            | 2 +-
>  mm/page_owner.c            | 2 +-
>  5 files changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
> index 6800886c4d10..5dd6e89a6d29 100644
> --- a/fs/fs-writeback.c
> +++ b/fs/fs-writeback.c
> @@ -981,7 +981,7 @@ void wbc_account_cgroup_owner(struct writeback_control *wbc, struct folio *folio
>  
>  	css = mem_cgroup_css_from_folio(folio);
>  	/* dead cgroups shouldn't contribute to inode ownership arbitration */
> -	if (!(css->flags & CSS_ONLINE))
> +	if (!css_is_online(css))
>  		return;
>  
>  	id = css->id;
> diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> index 0651865a4564..6a48398a1f4e 100644
> --- a/include/linux/memcontrol.h
> +++ b/include/linux/memcontrol.h
> @@ -893,7 +893,7 @@ static inline bool mem_cgroup_online(struct mem_cgroup *memcg)
>  {
>  	if (mem_cgroup_disabled())
>  		return true;
> -	return !!(memcg->css.flags & CSS_ONLINE);
> +	return css_is_online(&memcg->css);
>  }
>  
>  void mem_cgroup_update_lru_size(struct lruvec *lruvec, enum lru_list lru,
> diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
> index 1e4033d05c29..ad0a35721dff 100644
> --- a/kernel/cgroup/cgroup.c
> +++ b/kernel/cgroup/cgroup.c
> @@ -4939,7 +4939,7 @@ bool css_has_online_children(struct cgroup_subsys_state *css)
>  
>  	rcu_read_lock();
>  	css_for_each_child(child, css) {
> -		if (child->flags & CSS_ONLINE) {
> +		if (css_is_online(child)) {
>  			ret = true;
>  			break;
>  		}
> @@ -5744,7 +5744,7 @@ static void offline_css(struct cgroup_subsys_state *css)
>  
>  	lockdep_assert_held(&cgroup_mutex);
>  
> -	if (!(css->flags & CSS_ONLINE))
> +	if (!css_is_online(css))
>  		return;
>  
>  	if (ss->css_offline)
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index be810c1fbfc3..e2e49f4ec9e0 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -281,7 +281,7 @@ ino_t page_cgroup_ino(struct page *page)
>  	/* page_folio() is racy here, but the entire function is racy anyway */
>  	memcg = folio_memcg_check(page_folio(page));
>  
> -	while (memcg && !(memcg->css.flags & CSS_ONLINE))
> +	while (memcg && !css_is_online(&memcg->css))
>  		memcg = parent_mem_cgroup(memcg);
>  	if (memcg)
>  		ino = cgroup_ino(memcg->css.cgroup);
> diff --git a/mm/page_owner.c b/mm/page_owner.c
> index a70245684206..27d19f01009c 100644
> --- a/mm/page_owner.c
> +++ b/mm/page_owner.c
> @@ -530,7 +530,7 @@ static inline int print_page_owner_memcg(char *kbuf, size_t count, int ret,
>  	if (!memcg)
>  		goto out_unlock;
>  
> -	online = (memcg->css.flags & CSS_ONLINE);
> +	online = css_is_online(&memcg->css);
>  	cgroup_name(memcg->css.cgroup, name, sizeof(name));
>  	ret += scnprintf(kbuf + ret, count - ret,
>  			"Charged %sto %smemcg %s\n",
> -- 
> 2.34.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR


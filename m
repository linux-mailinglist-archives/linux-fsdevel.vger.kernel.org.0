Return-Path: <linux-fsdevel+bounces-50555-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B748ACD502
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Jun 2025 03:37:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A9129189D5C3
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Jun 2025 01:31:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F6CD146D6A;
	Wed,  4 Jun 2025 01:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b="A8AFYfWY";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gINE5AWF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39BC013BC3F;
	Wed,  4 Jun 2025 01:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748999405; cv=none; b=JwAa+P/TbIGSCXZ6owAI6Czfe16Uv5gkRWEqOzX/Y7Gi0TH7LL+POZ5B4Si7W13em6rDojHlpGrWzGcLAv4SJLai6EQVrnjgR0blkI5TT6eTnfKGodFvaXpxtn2X/osfjjcuM4eqMigl9O9h4wwFS3N+c+ZJ50qefnHBEbfkjNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748999405; c=relaxed/simple;
	bh=Z9qpfh0pPo4BNHkZ5/TaFR4ap2xVr20tYHUyCc9D0c0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=d40EQzUCUV/MIGJq+j1Fd55UT9ixKLdEt427GuOHEBHIl1hl/wNtEHDK5h09vwv+fvwCc8niEacL+o8E/cF2pEPxUpAmuG+5V7WG+EQsakMDasPrvjoiS1Kj44wVQjM44snm9hp2NWzxQ22IC8Zc310CQ7AI+c8WprGvtw8pDbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org; spf=pass smtp.mailfrom=maowtm.org; dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b=A8AFYfWY; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gINE5AWF; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maowtm.org
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id ED609254017F;
	Tue,  3 Jun 2025 21:10:01 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Tue, 03 Jun 2025 21:10:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maowtm.org; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1748999401;
	 x=1749085801; bh=xUFb22FplTmZ613N3z4Gz55bVzhwDUP/BuAQmEDvrKo=; b=
	A8AFYfWYprtG7yjZ+lmvt0Hu1vUvXb0dmzu8GqX1zMzcVLTEnPxBoCDEcaGQP+45
	2UV4gepSLbRNA5Z9Z/OGWongvC2todiwe/0DqGfLDDxevWmRTpgXb1sz6HltzUM/
	KcB8n8CJl1aYfur8OeqcnXLxCU+IimhQjRZmjyTHtioe2LOwSY+OuzKYu1UbShbE
	UofRVwYazkQIAgAE98BJOaaGzQcYR32V/pbgXzTvQ9+xzML+vQH33r2hGT8CmzMI
	Iu1LDNuC3rRbTpgcrU1D+LDQyo4Ux6ACtEx0Woq+/C+3d9/yfyhJXmBZXheJYGK/
	BW50uNQX9+suH5Y68ZmWmg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1748999401; x=
	1749085801; bh=xUFb22FplTmZ613N3z4Gz55bVzhwDUP/BuAQmEDvrKo=; b=g
	INE5AWFP1cykDBoT00u2jrLibygX6GMCBOd/7GFzCb8ZAWvVDFqomto2snD0Du7F
	70ggs5afZRezLWh09o/u8lIPvW1iYf1bVGMwzsRp4D+rlylZSrvAh+50HbmuwSYP
	132i6XHzrVd3aCyEpmstffZemfdz9GUDXWO69DjII3XdRxNOdUZl4/p6AOFwe2U4
	aZuN3OhxODL3B1G5mh6vSH+NxUXw+0VqxQnqHoH0ur9uf1KpseYoO+22TY5ZOW1O
	mg54YfWOs46akLnMuYLLcQUFIBluDApu7J/KR1WlLjacppBUQNvwwXtLCEiXToEE
	2rEtnWVjbphR2Iuj8d9FQ==
X-ME-Sender: <xms:6Zw_aFZXK1QykEznGnVE-apjaJmZ28LF8hOEns01cm2xuotDa_sCmA>
    <xme:6Zw_aMaPKSY3YiZxJkrxYn9zZQgG_w04ki-z5rxCJv7YLS8pkq_g2ddOpC0DenKFs
    E0iM4q-dzh_9Fecv7k>
X-ME-Received: <xmr:6Zw_aH9zxsxVJERECwGUB4r_UdFUv47UJqR5SeEoHGigqP2mOX3B9qXDVziTwctyGTnimJ0ChD1rcPU8qpugHfCJ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugddufeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepkfffgggfuffvvehfhfgjtgfgsehtjeertddtvdej
    necuhfhrohhmpefvihhnghhmrghoucghrghnghcuoehmsehmrghofihtmhdrohhrgheqne
    cuggftrfgrthhtvghrnhepfedvheeluedthfelgfevvdfgkeelgfelkeegtddvhedvgfdt
    feeilefhudetgfdunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilh
    hfrhhomhepmhesmhgrohifthhmrdhorhhgpdhnsggprhgtphhtthhopeelpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehmihgtseguihhgihhkohgurdhnvghtpdhrtghpth
    htohepshhonhhgsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehvihhrohesiigvnhhi
    vhdrlhhinhhugidrohhrghdruhhkpdhrtghpthhtohepghhnohgrtghksehgohhoghhlvg
    drtghomhdprhgtphhtthhopehjrggtkhesshhushgvrdgtiidprhgtphhtthhopegrlhgv
    gigvihdrshhtrghrohhvohhithhovhesghhmrghilhdrtghomhdprhgtphhtthhopegsrh
    gruhhnvghrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhsvggtuhhr
    ihhthidqmhhoughulhgvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplh
    hinhhugidqfhhsuggvvhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:6Zw_aDqzOlwF7cAnIYKlLwUYswqfMjr6MfJ28i8pNfZ9x8gSuo_eVw>
    <xmx:6Zw_aAowwMOkXuz2s-t9O9XsQAJX_MUCp18iabSy7vObgOLISQaY2Q>
    <xmx:6Zw_aJQMHHqr1VhnyrRoVMqyA0XVJAmDLDMQZ9emXREoF3O9mBrzug>
    <xmx:6Zw_aIrkS5TqpQ8r4_nfdYHu4RvYuA5ebeYxrhdtD7ZctXT2xniKYg>
    <xmx:6Zw_aAMRptDHFYZLzGT25y0fBNlLo2NIBZzVHyqlNrg2FsC3_Pnd9xBe>
Feedback-ID: i580e4893:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 3 Jun 2025 21:09:59 -0400 (EDT)
Message-ID: <22dcdbc4-7237-4693-8bd6-c1404918b648@maowtm.org>
Date: Wed, 4 Jun 2025 02:09:59 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 3/3] Restart pathwalk on rename seqcount change
To: =?UTF-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>,
 Song Liu <song@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>
Cc: =?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>,
 Jan Kara <jack@suse.cz>, Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 Christian Brauner <brauner@kernel.org>,
 linux-security-module@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <cover.1748997840.git.m@maowtm.org>
 <7452abd023a695a7cb87d0a30536e9afecae0e9a.1748997840.git.m@maowtm.org>
Content-Language: en-US
From: Tingmao Wang <m@maowtm.org>
In-Reply-To: <7452abd023a695a7cb87d0a30536e9afecae0e9a.1748997840.git.m@maowtm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/4/25 01:45, Tingmao Wang wrote:
> This fixes the issue mentioned in the previous patch, by essentially
> having two "modes" for the pathwalk code - in the pathwalk_ref == false
> case we don't take references and just inspect `d_parent` (unless we have
> to `follow_up`).  In the pathwalk_ref == true case, this is the same as
> before.
> 
> When we detect any renames during a pathwalk_ref == false walk, we restart
> with pathwalk_ref == true, re-initializing the layer masks.  I'm not sure
> if this is completely correct in regards to is_dom_check - but seems to
> work for now.  I can revisit this later.
> 
> Signed-off-by: Tingmao Wang <m@maowtm.org>
> ---
>  security/landlock/fs.c | 109 ++++++++++++++++++++++++++++++++++++-----
>  1 file changed, 98 insertions(+), 11 deletions(-)
> 
> diff --git a/security/landlock/fs.c b/security/landlock/fs.c
> index 923737412cfa..6dff5fb6b181 100644
> --- a/security/landlock/fs.c
> +++ b/security/landlock/fs.c
> @@ -771,6 +771,9 @@ static bool is_access_to_paths_allowed(
>  		_layer_masks_child2[LANDLOCK_NUM_ACCESS_FS];
>  	layer_mask_t(*layer_masks_child1)[LANDLOCK_NUM_ACCESS_FS] = NULL,
>  	(*layer_masks_child2)[LANDLOCK_NUM_ACCESS_FS] = NULL;
> +	unsigned int rename_seqcount;
> +	bool pathwalk_ref = false;
> +	const struct landlock_rule *rule;
>  
>  	if (!access_request_parent1 && !access_request_parent2)
>  		return true;
> @@ -811,6 +814,7 @@ static bool is_access_to_paths_allowed(
>  
>  	rcu_read_lock();
>  
> +restart_pathwalk:
>  	if (unlikely(dentry_child1)) {
>  		landlock_unmask_layers(
>  			find_rule_rcu(domain, dentry_child1),
> @@ -833,13 +837,32 @@ static bool is_access_to_paths_allowed(
>  	}
>  
>  	walker_path = *path;
> +
> +	/*
> +	 * Attempt to do a pathwalk without taking dentry references first,
> +	 * but if any rename happens while we are doing this, give up and do a
> +	 * walk with dget_parent instead.  See comments in
> +	 * collect_domain_accesses().
> +	 */
> +
> +	if (!pathwalk_ref) {
> +		rename_seqcount = read_seqbegin(&rename_lock);
> +		if (rename_seqcount % 2 == 1) {
> +			pathwalk_ref = true;
> +			path_get(&walker_path);
> +		}
> +	} else {
> +		path_get(&walker_path);
> +	}
> +
> +	rule = find_rule_rcu(domain, walker_path.dentry);
> +
>  	/*
>  	 * We need to walk through all the hierarchy to not miss any relevant
>  	 * restriction.
>  	 */
>  	while (true) {
>  		struct dentry *parent_dentry;
> -		const struct landlock_rule *rule;
>  
>  		/*
>  		 * If at least all accesses allowed on the destination are
> @@ -881,7 +904,6 @@ static bool is_access_to_paths_allowed(
>  				break;
>  		}
>  
> -		rule = find_rule_rcu(domain, walker_path.dentry);
>  		allowed_parent1 = allowed_parent1 ||
>  				  landlock_unmask_layers(
>  					  rule, access_masked_parent1,
> @@ -899,13 +921,16 @@ static bool is_access_to_paths_allowed(
>  jump_up:
>  		if (walker_path.dentry == walker_path.mnt->mnt_root) {
>  			/* follow_up gets the parent and puts the passed in path */
> -			path_get(&walker_path);
> +			if (!pathwalk_ref)
> +				path_get(&walker_path);
>  			if (follow_up(&walker_path)) {
> -				path_put(&walker_path);
> +				if (!pathwalk_ref)
> +					path_put(&walker_path);
>  				/* Ignores hidden mount points. */
>  				goto jump_up;
>  			} else {
> -				path_put(&walker_path);
> +				if (!pathwalk_ref)
> +					path_put(&walker_path);
>  				/*
>  				 * Stops at the real root.  Denies access
>  				 * because not all layers have granted access.
> @@ -925,10 +950,27 @@ static bool is_access_to_paths_allowed(
>  			}
>  			break;
>  		}
> -		parent_dentry = walker_path.dentry->d_parent;
> -		walker_path.dentry = parent_dentry;
> +		if (!pathwalk_ref) {
> +			parent_dentry = walker_path.dentry->d_parent;
> +
> +			rule = find_rule_rcu(domain, parent_dentry);
> +			if (read_seqretry(&rename_lock, rename_seqcount)) {
> +				pathwalk_ref = true;
> +				goto restart_pathwalk;
> +			} else {
> +				walker_path.dentry = parent_dentry;
> +			}
> +		} else {
> +			parent_dentry = dget_parent(walker_path.dentry);
> +			dput(walker_path.dentry);
> +			walker_path.dentry = parent_dentry;
> +			rule = find_rule_rcu(domain, walker_path.dentry);
> +		}
>  	}
>  
> +	if (pathwalk_ref)
> +		path_put(&walker_path);
> +
>  	rcu_read_unlock();
>  
>  	if (!allowed_parent1) {
> @@ -1040,22 +1082,55 @@ static bool collect_domain_accesses(
>  {
>  	unsigned long access_dom;
>  	bool ret = false;
> +	bool pathwalk_ref = false;
> +	unsigned int rename_seqcount;
> +	const struct landlock_rule *rule;
> +	struct dentry *parent_dentry;
>  
>  	if (WARN_ON_ONCE(!domain || !mnt_root || !dir || !layer_masks_dom))
>  		return true;
>  	if (is_nouser_or_private(dir))
>  		return true;
>  
> +	rcu_read_lock();
> +
> +restart_pathwalk:
>  	access_dom = landlock_init_layer_masks(domain, LANDLOCK_MASK_ACCESS_FS,
>  					       layer_masks_dom,
>  					       LANDLOCK_KEY_INODE);
>  
> -	rcu_read_lock();
> +	/*
> +	 * Attempt to do a pathwalk without taking dentry references first, but
> +	 * if any rename happens while we are doing this, give up and do a walk
> +	 * with dget_parent instead.  This prevents wrong denials in the
> +	 * presence of a move followed by an immediate rmdir of the old parent,
> +	 * where even when both the original and the new parent has allow
> +	 * rules, we might still hit a negative dentry (the deleted old parent)
> +	 * and being unable to find either rules.
> +	 */
> +
> +	if (!pathwalk_ref) {
> +		rename_seqcount = read_seqbegin(&rename_lock);
> +		if (rename_seqcount % 2 == 1) {
> +			pathwalk_ref = true;
> +			dget(dir);
> +		}
> +	} else {
> +		dget(dir);
> +	}
> +	rule = find_rule_rcu(domain, dir);
> +	/*
> +	 * We don't need to check rename_seqcount here because we haven't
> +	 * followed any d_parent yet, and the d_inode of the path being
> +	 * accessed can't change under us as we have ref on path.dentry.  But
> +	 * once we start walking up the path, we need to check the seqcount to
> +	 * make sure the rule we got isn't based on a wrong/changing/negative
> +	 * dentry.
> +	 */
>  
>  	while (true) {
>  		/* Gets all layers allowing all domain accesses. */
> -		if (landlock_unmask_layers(find_rule_rcu(domain, dir), access_dom,
> -					   layer_masks_dom,
> +		if (landlock_unmask_layers(rule, access_dom, layer_masks_dom,
>  					   ARRAY_SIZE(*layer_masks_dom))) {
>  			/*
>  			 * Stops when all handled accesses are allowed by at
> @@ -1069,9 +1144,21 @@ static bool collect_domain_accesses(
>  		if (dir == mnt_root || WARN_ON_ONCE(IS_ROOT(dir)))
>  			break;
>  
> -		dir = dir->d_parent;
> +		if (!pathwalk_ref) {
> +			parent_dentry = dir->d_parent;
> +			rule = find_rule_rcu(domain, dir);
> +			if (read_seqretry(&rename_lock, rename_seqcount)) {
> +				pathwalk_ref = true;
> +				goto restart_pathwalk;
> +			} else {
> +				dir = parent_dentry;
> +			}
> +		}

Forgot else branch here

diff --git a/security/landlock/fs.c b/security/landlock/fs.c
index 6dff5fb6b181..885121b1beef 100644
--- a/security/landlock/fs.c
+++ b/security/landlock/fs.c
@@ -1153,6 +1153,11 @@ static bool collect_domain_accesses(
 			} else {
 				dir = parent_dentry;
 			}
+		} else {
+			parent_dentry = dget_parent(dir);
+			dput(dir);
+			dir = parent_dentry;
+			rule = find_rule_rcu(domain, dir);
 		}
 	}
 

>  	}
>  
> +	if (pathwalk_ref)
> +		dput(dir);
> +
>  	rcu_read_unlock();
>  
>  	return ret;



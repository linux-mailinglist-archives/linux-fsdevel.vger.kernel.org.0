Return-Path: <linux-fsdevel+bounces-54834-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B07C0B03EE0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Jul 2025 14:39:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3EDD37A5729
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Jul 2025 12:38:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C30221B91F;
	Mon, 14 Jul 2025 12:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b="TtF2tmFq";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="c9emcqzR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 040FE225771;
	Mon, 14 Jul 2025 12:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752496761; cv=none; b=R/1QW1lEj3JdhpGSKGkPqZlcepmWWr/tIgUTODVfBfeJ8NYE8vAwVICL2pzF3b8Ss8JfF0DkTjcGX+MBj0nsO62zUSjQT4oNQ3fhDd8Vs5yAF7aIV7NcaFglXnY3aGVeTnva3JyGlJp6Bh3qjzXsMBjygctKnRPhMpFf0sCc6VE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752496761; c=relaxed/simple;
	bh=ufQPPQAeS3SL8o9K6fDayVHLOOrkXJg0re8Mkzhvteg=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=mdFMLz/62qnCNzsO0DMq1Fl3QVjJEMrttCHvyxRY5QvG7oVLu5z+iNnbrcspvlDyRk5/lxoggsgaWruZq0C3nzH9UwrASA+XWpzZ7dGeSOTdvHKjrJ4MmO5HVmlvaRbHeFQbjtuDNN61MWiO1cJolRasdFL1WC+8ZdT6XUuUUxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org; spf=pass smtp.mailfrom=maowtm.org; dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b=TtF2tmFq; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=c9emcqzR; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maowtm.org
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfhigh.stl.internal (Postfix) with ESMTP id B16857A0312;
	Mon, 14 Jul 2025 08:39:15 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-10.internal (MEProxy); Mon, 14 Jul 2025 08:39:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maowtm.org; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1752496755;
	 x=1752583155; bh=eZfhrIe15WfzMr12qujZXH4iMPdEaqg6OoXlBqW0VY0=; b=
	TtF2tmFqPlhlcORKvtT1/MLgxbN0nF5eCmF68Gpcmp57eJSnVAGPBJx5gLS+XZLG
	l0pgWBB8fA5Ji999Bsdbgf3MXlDUcyxpz1nBphtdK1OlbnSN/idUXEO82/LKl5F4
	AyiUO0iFhjcISItadYybu5AtJrXm9BsRhEtOtNgDmU8v1lKdBw8kItd5t6IGV/u+
	vNwgedE+oJTuS7cZdwJPBrlB8KJtxxrUf8LLu2EwK1n3GiwVfR0zJIr4imz0T76A
	gUuDtb1VQbIoG+h7XKK43G7AbSeCN6vGGLo3N4NBrpg6WlLMXUNsqLdNevIwwq+9
	82oyvXsnlsOkMyMzTgjxJQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1752496755; x=
	1752583155; bh=eZfhrIe15WfzMr12qujZXH4iMPdEaqg6OoXlBqW0VY0=; b=c
	9emcqzRJmAjlUQQ7zOG5ApNJTlbosrRZdXFHiUcRMLmbIgYc9cez4Nv4fSdqDSWx
	YSWN76XvlJAsOgM+nrNqQDcOr0mzM0/RY+BIkWmwNydIwseRj7p82Twe68NnWWPl
	Z/fh4MTX+n1mC0pb3SSs/l6CJGzfq8hzQrSerUKROrh/DobWab7IF06hyd15UcNB
	KlSv2bVmLYsKEQfI7+cImpp9ueENB8L+BQc6H/g/wUgoKH0qAyo+by73z6A8AdwR
	GavuRhzw4UpgZOTg4P6blsc0Mt1OimzNK3BEjl+jkEK2szp5xR9M0s5QRCJ7thqL
	b4Rt4Es5mKmj+wob01kRg==
X-ME-Sender: <xms:cvp0aAKHH-ku2OryCEs4mZ4TpuWWjzgzc7Dwc1Jk3_PST51IIp8utA>
    <xme:cvp0aOrP-uYCLICFh2c_jwBH-RKcwzck-wfW_7MIVFq1QTx7YAu_CGdxZ0-HkToei
    K3Vs6O0z6pVq8qhdqE>
X-ME-Received: <xmr:cvp0aMMBbeV39AjvWi6Zxj45Nji9df9OBm22dRy_l2GH3dT1uu6H7MhrLDpu5NNsCLuAn-8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdehudeljecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefkffggfgfhuffvvehfjggtgfesthekredttddvjeenucfhrhhomhepvfhinhhgmhgr
    ohcuhggrnhhguceomhesmhgrohifthhmrdhorhhgqeenucggtffrrghtthgvrhhnpedvge
    duuefgudejgfdtteffudejjeelleeiudekueejudehtefghfegvdetveffueenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehmsehmrghofihtmh
    drohhrghdpnhgspghrtghpthhtohepudefpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehmihgtseguihhgihhkohgurdhnvghtpdhrtghpthhtohepghhnohgrtghksehgoh
    hoghhlvgdrtghomhdprhgtphhtthhopehvihhrohesiigvnhhivhdrlhhinhhugidrohhr
    ghdruhhkpdhrtghpthhtoheprghkhhhnrgesghhoohhglhgvrdgtohhmpdhrtghpthhtoh
    epsghrrghunhgvrheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepuggsuhhrghgvnhgv
    rheslhhinhhugidrmhhitghrohhsohhfthdrtghomhdprhgtphhtthhopehjrghnnhhhse
    hgohhoghhlvgdrtghomhdprhgtphhtthhopehjvghffhiguhesghhoohhglhgvrdgtohhm
    pdhrtghpthhtohepnhgvihhlsegsrhhofihnrdhnrghmvg
X-ME-Proxy: <xmx:cvp0aHiFPjujrbJgZ_JvBWIG1FQepDAbUwiktFTrswz03ZHQi9QZXw>
    <xmx:cvp0aAYkCcE8vj0trDYIyxyuU_-yEwNlGT-Qdne5021RRWQE7ZFVIA>
    <xmx:cvp0aLhLhRMbUjdNny2fg2fjpIBrQc6phNDOXzp3TJQzAt5KZhYCZA>
    <xmx:cvp0aCainfZ0q54rgwdoEFzS9lRgis6PGVNCQGVFyLQJIWZ_5z245w>
    <xmx:c_p0aH9sKTit0XrXeVvwCfhOrvjAjvyyWQf_AXwoCPGjtRudaePZgRoO>
Feedback-ID: i580e4893:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 14 Jul 2025 08:39:12 -0400 (EDT)
Message-ID: <4d23784f-03de-4053-a326-96a0fa833456@maowtm.org>
Date: Mon, 14 Jul 2025 13:39:12 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Tingmao Wang <m@maowtm.org>
Subject: Re: [PATCH v2 1/3] landlock: Fix handling of disconnected directories
To: =?UTF-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
Cc: =?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>,
 Al Viro <viro@zeniv.linux.org.uk>, Ben Scarlato <akhna@google.com>,
 Christian Brauner <brauner@kernel.org>,
 Daniel Burgener <dburgener@linux.microsoft.com>, Jann Horn
 <jannh@google.com>, Jeff Xu <jeffxu@google.com>, NeilBrown
 <neil@brown.name>, Paul Moore <paul@paul-moore.com>,
 Song Liu <song@kernel.org>, linux-fsdevel@vger.kernel.org,
 linux-security-module@vger.kernel.org
References: <20250711191938.2007175-1-mic@digikod.net>
 <20250711191938.2007175-2-mic@digikod.net>
Content-Language: en-US
In-Reply-To: <20250711191938.2007175-2-mic@digikod.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 7/11/25 20:19, Mickaël Salaün wrote:
> [...]
> @@ -800,6 +802,8 @@ static bool is_access_to_paths_allowed(
>  		access_masked_parent1 = access_masked_parent2 =
>  			landlock_union_access_masks(domain).fs;
>  		is_dom_check = true;
> +		memcpy(&_layer_masks_parent2_bkp, layer_masks_parent2,
> +		       sizeof(_layer_masks_parent2_bkp));
>  	} else {
>  		if (WARN_ON_ONCE(dentry_child1 || dentry_child2))
>  			return false;
> @@ -807,6 +811,8 @@ static bool is_access_to_paths_allowed(
>  		access_masked_parent1 = access_request_parent1;
>  		access_masked_parent2 = access_request_parent2;
>  		is_dom_check = false;
> +		memcpy(&_layer_masks_parent1_bkp, layer_masks_parent1,
> +		       sizeof(_layer_masks_parent1_bkp));

Is this memcpy meant to be in this else branch?  If parent2 is set, we
will leave _layer_masks_parent1_bkp uninitialized right?

>  	}
>  
>  	if (unlikely(dentry_child1)) {
> @@ -858,6 +864,14 @@ static bool is_access_to_paths_allowed(
>  				     child1_is_directory, layer_masks_parent2,
>  				     layer_masks_child2,
>  				     child2_is_directory))) {
> +			/*
> +			 * Rewinds walk for disconnected directories before any other state
> +			 * change.
> +			 */
> +			if (unlikely(!path_connected(walker_path.mnt,
> +						     walker_path.dentry)))
> +				goto reset_to_mount_root;
> +
>  			/*
>  			 * Now, downgrades the remaining checks from domain
>  			 * handled accesses to requested accesses.

I think reasoning about how the domain check interacts with
reset_to_mount_root was very tricky, and I wonder if you could add some
more comments explaining the various cases?  For example, one fact which
took me a while to realize is that for renames, this function will never
see the bottom-most child being disconnected with its mount, since we
start walking from the mountpoint, and so it is really only handling the
case of the mountpoint itself being disconnected.

Also, it was not very clear to me whether it would always be correct to
reset to the backed up layer mask, if the backup was taken when we were
still in domain check mode (and thus have the domain handled access bits
set, not just the requested ones), but we then exit domain check mode, and
before reaching the next mountpoint we suddenly found out the current path
is disconnected, and thus resetting to the backup (but without going back
into domain check mode, since we don't reset that).

Because of the !path_connected check within the if(is_dom_check ...)
branch itself, the above situation would only happen in some race
condition tho.

I also wonder if there's another potential issue (although I've not tested
it), where if the file being renamed itself is disconnected from its
mountpoint, when we get to is_access_to_paths_allowed, the passed in
layer_masks_parent1 would be empty (which is correct), but when we do the
no_more_access check, we're still using layer_masks_child{1,2} which has
access bits set according to rules attached directly to the child. I think
technically if the child is disconnected from its mount, we're supposed to
ignore any access rules it has on itself as well?  And so this
no_more_access check would be a bit inconsistent, I think.


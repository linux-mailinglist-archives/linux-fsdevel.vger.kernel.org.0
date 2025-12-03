Return-Path: <linux-fsdevel+bounces-70606-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B7CACA1D9C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 03 Dec 2025 23:41:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3E0EF300D66B
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Dec 2025 22:41:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5335D2E8B78;
	Wed,  3 Dec 2025 22:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="ITKn2eU+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="uPOjuVxm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7700C258CD9;
	Wed,  3 Dec 2025 22:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764801695; cv=none; b=ZEekUu3rqFqdExoJUjNoga5I8EkEYu9C3riihwTplFf0vPjLnxOrVK1u3gbnh47wYIishBoYdQq8Y1DoEO09P7J6bj92Wk/BnflRZGckVfjs2i0CDa5Lt+FvsqjyoqMPDZWFXuaLqM7TQFWjHkouLjjxaa4Q+BKu1zLm1017Yzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764801695; c=relaxed/simple;
	bh=VC9DwROaA0A33x4J40o77qgm2MFk/5b97ugERcQQUb0=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=EAV7K39uPmwmwp8nROmo/q7DOOI1d2gvDc2HKAe2FRWl6OBwZd93VtqUOi8MYMqPSLi8MoekjFl3rHTUSzfvJ4p8bJEaVTrP19+jBkfGxhuliB8J6+xRDjjQkeLIFw+WehzFe2K4tWBIQwXEwfH6XXDzqrNEauIDHGbg3KqdHDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=ITKn2eU+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=uPOjuVxm; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 4AA2D1D00077;
	Wed,  3 Dec 2025 17:41:31 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Wed, 03 Dec 2025 17:41:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm1; t=
	1764801691; x=1764888091; bh=blcVSOMJUfXZMr51tI9w/korSD55CK9JPkl
	ZcQMV3kk=; b=ITKn2eU+Rsbh4ezERVc/wjjx81MTqYrfUi43cKeTRxeyiBxpvaR
	RDpw6DPlKJSOG+gi4txobBs5wUnTGB4CCjqMgw/yb1da//Y9rI1LsXUmpdbmOqyv
	1Cj1FC4g1UaPSglfFZ/p1F/8J+I6sn4Ib3RZvy1oK5IgE2xSA6XRThh7rif8kqXp
	bREQptfPeShQUjX/5HDcwgupO8QOKCmNRtN/H/+1yydxhVOZUe6sBS6fOGoPbMWV
	MBc1y+AnPQATFlliFcjOCZ6ScwPu0h6rTt3tFNF5OUZ5QCJNDwMgo5jwXkDyfs4K
	rFYxAqV0l4Y+Tu2X6I1uiJOYTuZvXMiq4/A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1764801691; x=
	1764888091; bh=blcVSOMJUfXZMr51tI9w/korSD55CK9JPklZcQMV3kk=; b=u
	POjuVxmnPu/jVZSiXP5kjYS9owFxpfUz+UnaWPdGANS4yj/Bw8T6vnfYWpQ6/nmJ
	wwOULObfWdTVy4TwXCOfVdpTS8EY0d2vEe/XF3TsW4o2K79lp+PbYE+N1AvVSNu9
	8EWUX9GHR0BvyGB9RrxbMVP5p8mQAkemNKEd9FiFKs31OcdCzZk/uu9rKvbefb0G
	ecU1BRyVHtr0xXoQsyzzIZq5jauBC5iSDyaAVkmI8ytCz1Ms1LpxcqZpAheoiYTB
	D9yTNkLLhAJ5EFZcue1MMs8l4W9MaoxwintXoEy20tz8y+tOudS4ubED3JysXaqJ
	tYg+YHXrudSVNeUZ5mcnQ==
X-ME-Sender: <xms:mbwwaU8DpMpgGePiSsW7gLxuRexMF_-xdWHoQnYopqDwOyl9uVp6jA>
    <xme:mbwwadrg2m1wmDcvVG24KcqFeH2Onj1A2smWtVhKrTPr4LjyNw1Y-5mLP_PNprVm0
    Wu2qvPMUGynJmcv9hW-NV2nTO8-YyaL5_b_5632l5NGIj_X>
X-ME-Received: <xmr:mbwwaaWe2p_tOZIs7kpJb6FXv-oiMcpZsK7GbnTXComrKlbTQsXCZz1_en8h-LecGj29dxFZbPgNMOpiT-Fxoxq0GmmOzhWnlGAJFZyO8_NO>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdegtddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    eptgfgggfhvfevufgjfhffkfhrsehtjeertddttdejnecuhfhrohhmpefpvghilheurhho
    fihnuceonhgvihhlsgesohifnhhmrghilhdrnhgvtheqnecuggftrfgrthhtvghrnhepud
    etfefhudevhedvfeeufedvffekveekgfdtfefggfekheejgefhteeihffggfelnecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepnhgvihhlsgesoh
    ifnhhmrghilhdrnhgvthdpnhgspghrtghpthhtohepudeipdhmohguvgepshhmthhpohhu
    thdprhgtphhtthhopehvihhrohesiigvnhhivhdrlhhinhhugidrohhrghdruhhkpdhrtg
    hpthhtoheplhhinhhugidqnhhfshesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphht
    thhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtph
    htthhopehlihhnuhigqdhfshguvghvvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhr
    tghpthhtoheplhhinhhugidqughotgesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtph
    htthhopehtohhmsehtrghlphgvhidrtghomhdprhgtphhtthhopehjrggtkhesshhushgv
    rdgtiidprhgtphhtthhopehokhhorhhnihgvvhesrhgvughhrghtrdgtohhmpdhrtghpth
    htoheptghhuhgtkhdrlhgvvhgvrhesohhrrggtlhgvrdgtohhm
X-ME-Proxy: <xmx:mbwwaS6UO34Y5wSic-5Ce9cewEzgCevKqR4TPhwAGkUUX6fGlQcdOg>
    <xmx:mbwwaQAO3X6S5nWYbbnpx_4_1fl7c394Yv34svubcwWzxFnyfc6EAg>
    <xmx:mbwwaee0989VAqK3bNTjHUbEx5-78_uZKqZ1zDvprBIwGJKI72mAVw>
    <xmx:mbwwaZss1fIGWDlNajBvAvdG35KxbSInViVvwvDKYCPuD9FViH6Yvw>
    <xmx:m7wwaRpLNOGwclRX0MWPDUCj8uT9le0cX4Xn0BLMp_d5uoib06aVR3QL>
Feedback-ID: iab3e480c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 3 Dec 2025 17:41:25 -0500 (EST)
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: NeilBrown <neilb@ownmail.net>
To: "Chuck Lever" <cel@kernel.org>
Cc: "Jeff Layton" <jlayton@kernel.org>,
 "Alexander Viro" <viro@zeniv.linux.org.uk>,
 "Christian Brauner" <brauner@kernel.org>, "Jan Kara" <jack@suse.cz>,
 "Chuck Lever" <chuck.lever@oracle.com>,
 "Alexander Aring" <alex.aring@gmail.com>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 "Jonathan Corbet" <corbet@lwn.net>, "Olga Kornievskaia" <okorniev@redhat.com>,
 "Dai Ngo" <Dai.Ngo@oracle.com>, "Tom Talpey" <tom@talpey.com>,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-nfs@vger.kernel.org
Subject: Re: [PATCH 1/2] filelock: add lease_dispose_list() helper
In-reply-to: <9a6f7f4b-dc45-4288-a8ee-6dcaabd19eb9@app.fastmail.com>
References: <20251201-dir-deleg-ro-v1-0-2e32cf2df9b7@kernel.org>,
 <20251201-dir-deleg-ro-v1-1-2e32cf2df9b7@kernel.org>,
 <9a6f7f4b-dc45-4288-a8ee-6dcaabd19eb9@app.fastmail.com>
Date: Thu, 04 Dec 2025 09:41:21 +1100
Message-id: <176480168199.16766.17148776636684804633@noble.neil.brown.name>
Reply-To: NeilBrown <neil@brown.name>

On Thu, 04 Dec 2025, Chuck Lever wrote:
> 
> On Mon, Dec 1, 2025, at 10:08 AM, Jeff Layton wrote:
> > ...and call that from the lease handling code instead of
> > locks_dispose_list(). Remove the lease handling parts from
> > locks_dispose_list().
> 
> The actual change here isn't bothering me, but I'm having trouble
> understanding why it's needed. It doesn't appear to be a strict
> functional prerequisite for 2/2.

This was almost exactly my thought too.  The commit message should say
*why* the change is being made and this one just left us guessing.
But I *do* like the change and would rather it were kept in the series,
but with a simple addition to the commit message saying that is a
simplification that isn't strictly necessary.

Thanks,
NeilBrown


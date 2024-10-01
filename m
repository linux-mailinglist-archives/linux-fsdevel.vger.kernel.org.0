Return-Path: <linux-fsdevel+bounces-30506-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A70E598BE36
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Oct 2024 15:43:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 122C2B2062A
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Oct 2024 13:43:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03B081C461F;
	Tue,  1 Oct 2024 13:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.pizza header.i=@tycho.pizza header.b="Fq8Pru2J";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lWAUaY4A"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 135E81BFE02;
	Tue,  1 Oct 2024 13:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727790224; cv=none; b=ObVIxYNxqEoVjemuLVosQChEA1OI9AfgOm9mgA9W5akH1KAdwDaYgie6tGiShnpu0RfFlkPILzPUARDLbCOX2XzYkonoiHwGeaCQLfl8dBdBrOGhJHb084jdpuW66xIuQ/4QfIAD5Q8AFt0Cnsxb+WU/Gud0l6S0u/yRbZcnRnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727790224; c=relaxed/simple;
	bh=ckqTM5snifxs8egOM2wYaryGvv/IndZyV1QjPCX/NhY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=llVh/uDsEPqtA2jzY3H+y4j/upDbOysTBFLjGoRAGtXFyNqcI2NBnn811YSqNBd6+CrWRo9W4oOBe50sl5wUi3SwJkFhC+PZf2IT9NYr06OgSG8Q/QdwBrADROlYaqIXfRDXpcH4IOdYZl0M0/SKE/F+TorLG+6TdRy/9PRnCBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tycho.pizza; spf=pass smtp.mailfrom=tycho.pizza; dkim=pass (2048-bit key) header.d=tycho.pizza header.i=@tycho.pizza header.b=Fq8Pru2J; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lWAUaY4A; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tycho.pizza
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tycho.pizza
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfout.phl.internal (Postfix) with ESMTP id EB037138187E;
	Tue,  1 Oct 2024 09:43:40 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Tue, 01 Oct 2024 09:43:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tycho.pizza; h=
	cc:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1727790220; x=1727876620; bh=9eJfTq98nK
	sS/oxhfrBvZbGHDG0wJU4VJL04JAqQ3dc=; b=Fq8Pru2JrJ3LdbXR3W2bOiOUX2
	YPTI1Ul4/3a0mkjMfGCV1M51FD+CmKqSjGFcSMmfWkf7zWtqydb2v84kbtP9JnYY
	vlnVLRasWWix6VegO0nPXgmdp1e3CKP9SclLPbMa8xG07cY8q91/x/HhbD9GnqN8
	iR3vXY9/d2adZ5Gv1GwbTKBZxO0+28/4ENUygQ2KATlmLRakFtng+ey3HK4SJgCx
	8b1bJbSDMvFeHXeuDA+xukL5lr4pgZiUoV4Oj4mEzQoOt67u16AjSDPCS133UfkK
	c76Bhb7a/QDks82aKhcDE35+O87CIJm5OsPGlabIdQNv6Sjl7SpszzIjEaQw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1727790220; x=1727876620; bh=9eJfTq98nKsS/oxhfrBvZbGHDG0w
	JU4VJL04JAqQ3dc=; b=lWAUaY4AyIhnV8M7GE2ZVVzdk/KRPWIFlBv3eLj4Lkup
	BlPm+8oeTqzyalge3ZDK4LYCFLGbnv2bvqgVcG1e2JBxZvmQECU8kdF19jZL+bWQ
	4OQu94YwSeNaVUFr6AgEmvE3zu35/ejFzR0xZ80k5YIqSlMMaS5ybLxVUpjvWu+j
	WSOgGIbWQSVHsu2EKThDx8XSTwU61cXOpLmEvCkM4SXACNV8Xr6NHnaw2/4Amnr/
	ibfd1BYNps275IqCNbDJve0VQ1A3879tbebMl+L1A3gItspfCJm9hE2SAyJZJvGq
	0hUWJENG4kCfWn6cjrbX1OvC4f0ptU5j3liu7iCasw==
X-ME-Sender: <xms:i_z7Znh8uXrUsDXt1POAp39vuKa3NYcuXfoJ-jKTqhY_qPxYb__Nmw>
    <xme:i_z7ZkDrY_21zP7vwS0R0MOlv5DTsuu7Q3Lkc06Sy35v77L5sVNEEhqkrPOTF8uUE
    ha8mJcx8U-MsV9WJbk>
X-ME-Received: <xmr:i_z7ZnECR_9kw7YrK6u674wtRFOsxVv4zhWLs5dij0GGXYn5q6wuMRhINYloZJdryfmShjYE0JTO0YPxpzGI1lw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvddujedgieeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomhepvfihtghhohcutehnuggvrhhsvghnuceothihtghhohesthihtghhohdrph
    hiiiiirgeqnecuggftrfgrthhtvghrnhepueettdetgfejfeffheffffekjeeuveeifedu
    leegjedutdefffetkeelhfelleetnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepthihtghhohesthihtghhohdrphhiiiiirgdpnhgspghrtghp
    thhtohepuddvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegvsghivgguvghrmh
    esgihmihhsshhiohhnrdgtohhmpdhrtghpthhtohepkhgvvghssehkvghrnhgvlhdrohhr
    ghdprhgtphhtthhopehvihhrohesiigvnhhivhdrlhhinhhugidrohhrghdruhhkpdhrtg
    hpthhtohepsghrrghunhgvrheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhgrtghk
    sehsuhhsvgdrtgiipdhrtghpthhtoheplhhinhhugidqfhhsuggvvhgvlhesvhhgvghrrd
    hkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhmmheskhhvrggtkhdrohhr
    ghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdroh
    hrghdprhgtphhtthhopehlihhnuhigqdhkshgvlhhfthgvshhtsehvghgvrhdrkhgvrhhn
    vghlrdhorhhg
X-ME-Proxy: <xmx:i_z7ZkT8fACSVpcmLpXgLzDbLtbea-C0XY9J_IZv1JabauP9vk_8yw>
    <xmx:i_z7ZkxF0ELlnC29EC-LBNEcmtj5oSxSmnTbUSMm_iqwuKfNBAdMCA>
    <xmx:i_z7Zq5l5ttDUooDr3YpJqA766jolT--X5ehlH4KSlyMPzcoM2GfEA>
    <xmx:i_z7ZpwwebOtrpFRvEUGDSJiTfk34YQXiVSLwZKNNIwoRkYplT5BPA>
    <xmx:jPz7ZvqPgrFBB4XkZKRvZgX1ePK74gadwWyU7anU1omVQ1mtgcR_HZ-i>
Feedback-ID: i21f147d5:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 1 Oct 2024 09:43:38 -0400 (EDT)
Date: Tue, 1 Oct 2024 07:43:37 -0600
From: Tycho Andersen <tycho@tycho.pizza>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Kees Cook <kees@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	Tycho Andersen <tandersen@netflix.com>,
	Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>,
	Aleksa Sarai <cyphar@cyphar.com>
Subject: Re: [PATCH v2 1/2] exec: add a flag for "reasonable" execveat() comm
Message-ID: <Zvv8iWjZQ/cE4LLa@tycho.pizza>
References: <20240927151746.391931-1-tycho@tycho.pizza>
 <87ikuhw155.fsf@email.froward.int.ebiederm.org>
 <202409281453.B9B9999D@keescook>
 <87bk05vobx.fsf@email.froward.int.ebiederm.org>
 <871q10vr62.fsf@email.froward.int.ebiederm.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <871q10vr62.fsf@email.froward.int.ebiederm.org>

On Mon, Sep 30, 2024 at 03:10:29PM -0500, Eric W. Biederman wrote:
> "Eric W. Biederman" <ebiederm@xmission.com> writes:
> 
> > Kees Cook <kees@kernel.org> writes:
> 
> >> I'm not super comfortable doing this regardless of bprm->fdpath; that
> >> seems like too many cases getting changed. Can we just leave it as
> >> depending on bprm->fdpath?
> 
> I was recommending that because I did not expect that there was any
> widespread usage of aliasing of binary names using symlinks.
> 
> I realized today that on debian there are many aliases
> of binaries created with the /etc/alternatives mechanism.
> So there is much wider exposure to problems than I would have
> supposed.
> 
> So I remove any objections to making the new code conditional on bprm->fdpath.

Yep, and it looks like Alpine distributes busybox with symlinks
instead of hard links. I will respin with a fixed subject line shortly.

Thanks,

Tycho


Return-Path: <linux-fsdevel+bounces-33720-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E6689BE0E7
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Nov 2024 09:28:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D7601C23018
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Nov 2024 08:28:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2768C1DA10B;
	Wed,  6 Nov 2024 08:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b="mfeqlBAU";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YC+I0dR0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B63E01D5178;
	Wed,  6 Nov 2024 08:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730881373; cv=none; b=swP+xQvylSSc0JMUM8GyA2NOw/5SMRiN9HwmmS/X9ABhsaZUzE7vEbp2ZyE9ULAN4G/onHHEojHCkOy0H0PM3W2nK1+yXMkChBF2iD4JKBLDzg8dYFvLgBGUHonKF283ZSdO0iXcgF0MSe0NlSHPGqTK7Q1g4VUVnsRYTFb/wlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730881373; c=relaxed/simple;
	bh=A9mkpVGy4g8Gd1WTOi/LPIQNtCBmj80Bd2ZolAjz9pk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YTACn55iRzszyqw/ANDGAtb8MjOffrXi0mzdMcoIswinX990AHJ0Uj/3dbdpfpOk9sdscdxhDNwrdlimwhkWUo1voI3RxCj7nZmoRLJ/wtProyDzTTrypywlVzbiIkHUMFUgcZLYZc/zXSnP/RGBDtg2TRvCUdPsYg7um9OGzjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name; spf=pass smtp.mailfrom=shutemov.name; dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b=mfeqlBAU; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YC+I0dR0; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shutemov.name
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id A6D84114014A;
	Wed,  6 Nov 2024 03:22:49 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Wed, 06 Nov 2024 03:22:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1730881369; x=
	1730967769; bh=cUJGhA+EqaCERMowqa0oAWZk0dGBxuPHW0azPfwVRNw=; b=m
	feqlBAU/iRdSmfdsB5UznNsL9kCz2Dq17My1bH1J9tV2n2qyAc/Mi2SkHck5flN1
	pGmdrNCFiU/YUX5hVZfaTLSkX10MFNxJBl31diQdOPt38pG96QXPiYh1aGCrt6ud
	FJ6BDKv1RSaT6GDO7zWhcoZ9AuOnTl2FNElGXs1wX90p/kRLZy4HqA2+J/zmAYo1
	yxkE1Ns353YcoFJhH4VBGm803+IazJBN76Qfvwgaf1yeyXxRryz100m9erfDOjey
	uoqRfp5cJwhcCFKdBJflwYcTFNicaKY/3F8iU/SXG6RXZ7kW9sXVVs2Lwnrau+xR
	lusnayucyjOmJOZCF9j2Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1730881369; x=1730967769; bh=cUJGhA+EqaCERMowqa0oAWZk0dGBxuPHW0a
	zPfwVRNw=; b=YC+I0dR0vYSMIv6f2/J+h29yFAkRQqdJC86GOMPsxlFRYeoEmnz
	kLANdnulyWGl5PSJsq6gY3+O+p6oriemCaJGLlyvaYe4KAnTw9OikVeJWR+km1Lm
	rr8StFwphn7D/LYtgDNWW23lgORQomup8HJ8qI1CXtdSQt6aIMi+qQoiOJ7BVlgv
	hU3oz6AA6wuDEB3LdtDb85iawnIbAmgn/KeP33jonTBvZQhSnSFiVIsl+2bCoWaZ
	cu0Ui5IwYD+AH39UP2Ioqhj3Tfoz/9rDGmnwtnlANsSDH5APzl1YfCksKKks7Zfj
	ykctJDvS4/y33i3VUcMOzc/nGNhm1TWX9SQ==
X-ME-Sender: <xms:WScrZ2fnNVXF2KCr5opUNktBIyJed6Sh6ru4kqOBcD0sP7XeeIpjow>
    <xme:WScrZwMtxKL91UO9u-AUWCs-tzCsR84DeoL3n4kxOWtrX9c_bJpRVu2B_LIq_0ww0
    DJu2lXypk02i1tAR48>
X-ME-Received: <xmr:WScrZ3g0HJ5ZYFoV2IpZQnTq2ltA2Yfvex32IUEZVuGvCIQvvvt-izHIBvLK5acGoYgaPQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrtddugdduvddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtsfdttddtvden
    ucfhrhhomhepfdfmihhrihhllhcutedrucfuhhhuthgvmhhovhdfuceokhhirhhilhhlse
    hshhhuthgvmhhovhdrnhgrmhgvqeenucggtffrrghtthgvrhhnpeeltedugedtgfehuddu
    hfetleeiuedvtdehieejjedufeejfeegteetuddtgefgudenucffohhmrghinhepkhgvrh
    hnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhf
    rhhomhepkhhirhhilhhlsehshhhuthgvmhhovhdrnhgrmhgvpdhnsggprhgtphhtthhope
    duvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepkhgvvghssehkvghrnhgvlhdr
    ohhrghdprhgtphhtthhopehvihhrohesiigvnhhivhdrlhhinhhugidrohhrghdruhhkpd
    hrtghpthhtohepshihiigsohhtoddtfegvudgrfhehtgeffedvfhejvgdtvggskeegsges
    shihiihkrghllhgvrhdrrghpphhsphhothhmrghilhdrtghomhdprhgtphhtthhopegsrh
    gruhhnvghrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehjrggtkhesshhushgvrdgt
    iidprhgtphhtthhopegvsghivgguvghrmhesgihmihhsshhiohhnrdgtohhmpdhrtghpth
    htoheplhhinhhugidqfhhsuggvvhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgt
    phhtthhopehlihhnuhigqdhmmheskhhvrggtkhdrohhrghdprhgtphhtthhopehtrghnug
    gvrhhsvghnsehnvghtfhhlihigrdgtohhm
X-ME-Proxy: <xmx:WScrZz-TqVzchTIxabqBnD-hREhjsoD-9dlp1cU1cb3QJHNnIsNc6w>
    <xmx:WScrZysQ1moPuR9BLb3ZA4UN4LCtq3OOzGNJTrNc-cgjSAgLC67RJg>
    <xmx:WScrZ6EgNoK6mRi10czN4zJPM8ULH8uz7EZVGebH6PYjIDwYSnaGqA>
    <xmx:WScrZxMcZjdc9qCjh8zqPl0TCWprccn-5-ZXe6yoPmCSMxNHiapR9Q>
    <xmx:WScrZzFHbVw1xRUT4URxxH08R0sz3dZwCr-V_lOJiwXH7iLjVLZalIx0>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 6 Nov 2024 03:22:45 -0500 (EST)
Date: Wed, 6 Nov 2024 10:22:37 +0200
From: "Kirill A. Shutemov" <kirill@shutemov.name>
To: Kees Cook <kees@kernel.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>, 
	syzbot+03e1af5c332f7e0eb84b@syzkaller.appspotmail.com, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Eric Biederman <ebiederm@xmission.com>, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	Tycho Andersen <tandersen@netflix.com>, Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] exec: NULL out bprm->argv0 when it is an ERR_PTR
Message-ID: <nx6v7xrlkq5svczxyxky3sfckkpnvuz3ifj4jcsordabyyy4sw@h7svrhdgcmft>
References: <20241105181905.work.462-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241105181905.work.462-kees@kernel.org>

On Tue, Nov 05, 2024 at 10:19:11AM -0800, Kees Cook wrote:
> Attempting to free an ERR_PTR will not work. ;)
> 
>     process 'syz-executor210' launched '/dev/fd/3' with NULL argv: empty string added
>     kernel BUG at arch/x86/mm/physaddr.c:23!
> 
> Set bprm->argv0 to NULL if it fails to get a string from userspace so
> that bprm_free() will not try to free an invalid pointer when cleaning up.
> 
> Reported-by: syzbot+03e1af5c332f7e0eb84b@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/all/6729d8d1.050a0220.701a.0017.GAE@google.com
> Fixes: 7bdc6fc85c9a ("exec: fix up /proc/pid/comm in the execveat(AT_EMPTY_PATH) case")
> Signed-off-by: Kees Cook <kees@kernel.org>
> ---
> Cc: Alexander Viro <viro@zeniv.linux.org.uk>
> Cc: Christian Brauner <brauner@kernel.org>
> Cc: Jan Kara <jack@suse.cz>
> Cc: Eric Biederman <ebiederm@xmission.com>
> Cc: linux-fsdevel@vger.kernel.org
> Cc: linux-mm@kvack.org

Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

-- 
  Kiryl Shutsemau / Kirill A. Shutemov


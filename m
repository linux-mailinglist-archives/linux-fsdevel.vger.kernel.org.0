Return-Path: <linux-fsdevel+bounces-28220-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AD2AC9682C2
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Sep 2024 11:10:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE0651C22399
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Sep 2024 09:10:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35666187552;
	Mon,  2 Sep 2024 09:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="GvS4fPt+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="iGX83XVz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fhigh8-smtp.messagingengine.com (fhigh8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD3BC2D7B8;
	Mon,  2 Sep 2024 09:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725268220; cv=none; b=re4K1CO/tAeMTaHVHdxzhd/St42SnX+mgRRWVkIRZ0GngK9XLOhaGQtcW4mMpv1aGDd+GhuD97BQPeNHamcm0P9fK4GoYutAYWrdSLpmdv12nRAThYqofNwOJUUqqiR6VQo9sSakDh6hfl8Hwt0N9niTbYDhUXwgnLhlhSKFA7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725268220; c=relaxed/simple;
	bh=6j0Oy77vc3k7Bm97cy+0sWSoGWBccV07dWxxIiN5yTg=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=Zqp0Fzo+ZLv20DTDKqr3aqKRm2M049hrznqUNCujMSTzUVBg938+4vbjfThCo3hGIRG6U12XAckqzNmEPom5y597Q+2CQmKclKqxr7Ffi3xC6BrR/lJXooQ7aSBRCuVpMS1s/MGt/rUlg/0KzsIKDN5qKMkdCubrolhYXjBvI4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=GvS4fPt+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=iGX83XVz; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-04.internal (phl-compute-04.nyi.internal [10.202.2.44])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id DA62111402A6;
	Mon,  2 Sep 2024 05:10:17 -0400 (EDT)
Received: from phl-imap-11 ([10.202.2.101])
  by phl-compute-04.internal (MEProxy); Mon, 02 Sep 2024 05:10:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1725268217;
	 x=1725354617; bh=bzaUZvBR6GY2fVCjdmz9wFgI6HiU4z7HCwf2miDnwYA=; b=
	GvS4fPt+9jtPThPXCzHUZbVhVte9hekuZsxDuetitVoYOHcXDzlGMvxagUBSBs+Y
	gWO1ZjbblIjtYEFSzM7Cy6+3L7hgXo2jSMqusFnu1BWonO9x7qPADYCEKnUiJqg8
	KNNnmP0fgYOin2LxZCw1SkZl2oUV+V/R2Sd493BivMAq6H9fWoXXtGYBojuGgZkr
	uYIskeOO645P/8et/V11ne5V6yr7YeLuBLTQ3j75wuQDyLmeiCSwexNxN6UXZmiY
	l9lPBSCFOV3FuLJEC7N1RcdAijZtipDtn9e0lCcVwlBM7asEO+Bh+D2wNUBC1lKE
	p39I8IBv/2JrfjzHNrLFfA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1725268217; x=
	1725354617; bh=bzaUZvBR6GY2fVCjdmz9wFgI6HiU4z7HCwf2miDnwYA=; b=i
	GX83XVzAoGLYdZx2vbv5UP4w29BGMp9szfjvexA7zY/zvv+cpwxcXp7HTdXqLgCK
	a1Sl5CVaCmF6wjx/PS54odSwp6n5VOPgXNcjOHESt20QrGIJygkBGYCoBbnbpc6W
	pZx2qTIpy5Rzg5rICCypPmIftKnFC4RqDdAa6u9q+ug40IYF5a/lRHQnfE4TKTHg
	Rmf2v1CxAnNAyXxenNYkpAQkjb8ajh6+SHVY027B4IPDGxM7D/Q1nNKU4Vnh8zgh
	mnFceguqwrlh3qtBiAcCCwT5DqqgI+s6l29Vym8SH29NrBWxvm7yYIv5MEuS6BdW
	pjMrWBntCChPZvy7fExgA==
X-ME-Sender: <xms:-YDVZoJtGIfQ-SaB70EHDJmU1AS_aHtyq9G07YCD9ka7SFfK2G7jUQ>
    <xme:-YDVZoKIl28I_f7LJnmk0YVmkDyO2srCnsC_PVxPIidohgDF3H5AmAGZGc6xQIXmv
    FK-qmbi5j7ms_BiG_w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudehfedguddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddt
    necuhfhrohhmpedftehrnhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrd
    guvgeqnecuggftrfgrthhtvghrnhephfdthfdvtdefhedukeetgefggffhjeeggeetfefg
    gfevudegudevledvkefhvdeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomheprghrnhgusegrrhhnuggsrdguvgdpnhgspghrtghpthhtohepvdef
    pdhmohguvgepshhmthhpohhuthdprhgtphhtthhopeguihgvthhmrghrrdgvghhgvghmrg
    hnnhesrghrmhdrtghomhdprhgtphhtthhopehmrghrkhdrrhhuthhlrghnugesrghrmhdr
    tghomhdprhgtphhtthhopegthihphhgrrhestgihphhhrghrrdgtohhmpdhrtghpthhtoh
    eprhhoshhtvgguthesghhoohgumhhishdrohhrghdprhgtphhtthhopegsshgvghgrlhhl
    sehgohhoghhlvgdrtghomhdprhgtphhtthhopehpvghtvghriiesihhnfhhrrgguvggrug
    drohhrghdprhgtphhtthhopegsrhgruhhnvghrsehkvghrnhgvlhdrohhrghdprhgtphht
    thhopehkvggvsheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshhhuhgrhheskhgvrh
    hnvghlrdhorhhg
X-ME-Proxy: <xmx:-YDVZotDYjNwOLmbepGuzRbve8dpg4PUkv-Z3Z5HZ4thEqpif7IOFw>
    <xmx:-YDVZlYQjTxLpm4yBsjpAQNUQK56ngTLtrSpT_4M6EI8MfCOstHtAg>
    <xmx:-YDVZvb8SGQi2U9tYXOv94ItwL-JifN3KKNb6FctzcRFlq2JVp6zow>
    <xmx:-YDVZhBVB07Hh6OWpB_irfc3Q8tn58t4BJbVaJHchXxoOgq9Jz6ecQ>
    <xmx:-YDVZsJwLH0OCSZIqhg0QIi80Ml9hJvUQLfbZ2iagsSkpsES3sM5MBEJ>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 3C9DA2220083; Mon,  2 Sep 2024 05:10:17 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 02 Sep 2024 09:09:55 +0000
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Aleksa Sarai" <cyphar@cyphar.com>, "Ingo Molnar" <mingo@redhat.com>,
 "Peter Zijlstra" <peterz@infradead.org>,
 "Juri Lelli" <juri.lelli@redhat.com>,
 "Vincent Guittot" <vincent.guittot@linaro.org>,
 "Dietmar Eggemann" <dietmar.eggemann@arm.com>,
 "Steven Rostedt" <rostedt@goodmis.org>,
 "Benjamin Segall" <bsegall@google.com>, "Mel Gorman" <mgorman@suse.de>,
 "Valentin Schneider" <vschneid@redhat.com>,
 "Alexander Viro" <viro@zeniv.linux.org.uk>,
 "Christian Brauner" <brauner@kernel.org>, "Jan Kara" <jack@suse.cz>,
 shuah <shuah@kernel.org>
Cc: "Kees Cook" <kees@kernel.org>, "Florian Weimer" <fweimer@redhat.com>,
 "Mark Rutland" <mark.rutland@arm.com>, linux-kernel@vger.kernel.org,
 linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 Linux-Arch <linux-arch@vger.kernel.org>, linux-kselftest@vger.kernel.org,
 stable@vger.kernel.org
Message-Id: <63193b87-7057-4ad0-aef2-fdb5d15138c3@app.fastmail.com>
In-Reply-To: 
 <20240902-extensible-structs-check_fields-v1-3-545e93ede2f2@cyphar.com>
References: 
 <20240902-extensible-structs-check_fields-v1-0-545e93ede2f2@cyphar.com>
 <20240902-extensible-structs-check_fields-v1-3-545e93ede2f2@cyphar.com>
Subject: Re: [PATCH RFC 3/8] openat2: explicitly return -E2BIG for (usize > PAGE_SIZE)
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Mon, Sep 2, 2024, at 07:06, Aleksa Sarai wrote:
> While we do currently return -EFAULT in this case, it seems prudent to
> follow the behaviour of other syscalls like clone3. It seems quite
> unlikely that anyone depends on this error code being EFAULT, but we can
> always revert this if it turns out to be an issue.

Right, it's probably a good idea to have a limit there rather than
having a busy loop with a user-provided length when the only bound is
the available virtual memory.

>  	if (unlikely(usize < OPEN_HOW_SIZE_VER0))
>  		return -EINVAL;
> +	if (unlikely(usize > PAGE_SIZE))
> +		return -E2BIG;
> 

Is PAGE_SIZE significant here? If there is a need to enforce a limit,
I would expect this to be the same regardless of kernel configuration,
since the structure layout is also independent of the configuration.

Where is the current -EFAULT for users passing more than a page?
I only see it for reads beyond the VMA, but not e.g. when checking
terabytes of zero pages from an anonymous mapping.

    Arnd


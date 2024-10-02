Return-Path: <linux-fsdevel+bounces-30701-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0863E98D9BE
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Oct 2024 16:14:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E1D81F26225
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Oct 2024 14:14:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BA621D1E81;
	Wed,  2 Oct 2024 14:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.pizza header.i=@tycho.pizza header.b="FZXvD6c8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hVhpksMZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 041461D07BD;
	Wed,  2 Oct 2024 14:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727878191; cv=none; b=oOP5EirgwNUiicazrHmOw9PhAIQ3LTASxn4iChFOXHeIBfvMOPfogjLuQVkkspjEoq3Z+M90w1SUT5Sx9/p5W1g03GmPC/v9bh4bgVDwqjgQ7F8neq86mkUg7n39H75RaDZSzYsLQSwxI1RFx6LVRQJWDbRxMssNfQ3NFl7CJkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727878191; c=relaxed/simple;
	bh=t7sMXL29ykoJyeu82nXO9yxES6WmjOpirFkBSpRF/eA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AzEf9pRnQX5ZIUVipumfEQJpvIOH5Kp1K3Lw/JBBMWTnNPbusptatqPWEdfGrCLj5Hp7gycVlGjOrvW8GZiPtySyEPu3PSBWJxUDWkBQ73tVR3cq/zQG+EkVrCMQ5k8Zo8x99+YEtVv+p2/DVpEicvn8cmL+urfLVwnOv0VM0mQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tycho.pizza; spf=pass smtp.mailfrom=tycho.pizza; dkim=pass (2048-bit key) header.d=tycho.pizza header.i=@tycho.pizza header.b=FZXvD6c8; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hVhpksMZ; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tycho.pizza
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tycho.pizza
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 2106A11401B1;
	Wed,  2 Oct 2024 10:09:48 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Wed, 02 Oct 2024 10:09:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tycho.pizza; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1727878188;
	 x=1727964588; bh=D9f5mwetgYmnswxXDIMmoQPKc8ofGIpzwf7vHe4haFM=; b=
	FZXvD6c8gX9dl4ov59CcEc9JhfyiDf3XlQu9nsZe3/M0U3iGEJU0OiLUOKdIpLHT
	2bm+KcYUFVnsBXlsoEP6qstmx4F8Dk7FKW6H4ylsUmgKQUIrAA9C+FDSR3EXCP5M
	vIbX7OvgaOSqMHllkREj/qfjMIb0btv4rS4YPpE0wCTL2qFDnxrxgc+Kze6CadeM
	JgiZLKeNVKQPm7Nn/lwKwsG2XXIed+zH719Q4smlPqhv69nMP4l/W/A/EqqoGMd0
	WY3e9AraTaedvFfSFcu7wyukSKNRehKmI53NRcO11pZ/xuh13EGVOYeH67ZPqbj0
	boELUedf84CFtYsL/tOsSw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1727878188; x=
	1727964588; bh=D9f5mwetgYmnswxXDIMmoQPKc8ofGIpzwf7vHe4haFM=; b=h
	VhpksMZbTy3hg05gWDKTwOsgC8FIYIfg3LIRJNCuCWiqcda27qYgWdcyHLEiVDXW
	E/GsA2cH14E+xL8eH9RRixsc+Wbb9smIsxBtZYWCnna92pjharmvMY7udbAXo7db
	/QV0ZOTS4D5PHOcVf8A+YcABAvpoafR14DShE00cttOqTqf3yVgyvnl7z/8+Zadp
	zuIEtcII8s4tIINxcxPRpssMYuKp227RpuQQO28tFk63HjgmcwlYTfYA4Q8JQ53J
	AX3h6wFt2XXnCwqEbZnPM0PkBlX/0s/JDt5RogEmi7F+XerOrmkPoiIAC2bQLDYo
	UYrAwfqVZtDvCfdZoUJ9g==
X-ME-Sender: <xms:K1T9Zt_tLnNC_T29NT0b_z517yQtTv0beNPHGp0Es2P29O1k7HreIA>
    <xme:K1T9Zhu-Oyi7XZNNOcRG77aJJy9QtTubGJMtDMKS6lqwXqXDzVQEYq0vwRuDJ42l_
    FNWxcSVEvBbacM_tBg>
X-ME-Received: <xmr:K1T9ZrCLgHA48tR-fBgCfLfCbLs1g63_wY7fcuKzqVJIG_LqaJZ8mhDREDM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdduledgieelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggugfgjsehtkeertddttdej
    necuhfhrohhmpefvhigthhhoucetnhguvghrshgvnhcuoehthigthhhosehthigthhhord
    hpihiiiigrqeenucggtffrrghtthgvrhhnpeettddvheefffetkeejieehhfehieekgedv
    jeelieehkeefueevheehteegteevgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehthigthhhosehthigthhhordhpihiiiigrpdhnsggprhgt
    phhtthhopeduvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepiigshihsiigvkh
    esihhnrdifrgifrdhplhdprhgtphhtthhopegthihphhgrrhestgihphhhrghrrdgtohhm
    pdhrtghpthhtohepvhhirhhoseiivghnihhvrdhlihhnuhigrdhorhhgrdhukhdprhgtph
    htthhopegsrhgruhhnvghrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehjrggtkhes
    shhushgvrdgtiidprhgtphhtthhopegvsghivgguvghrmhesgihmihhsshhiohhnrdgtoh
    hmpdhrtghpthhtohepkhgvvghssehkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhn
    uhigqdhfshguvghvvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplh
    hinhhugidqmhhmsehkvhgrtghkrdhorhhg
X-ME-Proxy: <xmx:K1T9ZhcGXw-di1j1tq5NWYGCdHJrtHxD_rVE6gwgajI20aKIaMWlSg>
    <xmx:K1T9ZiMGZratpkdbwjcVhBjaTC7sHdL6IhOWmyXk7e8Fezao4q-Njg>
    <xmx:K1T9ZjmrHtZyafp24NXMOrZCpuRD5gqCPBq4iKoKjW2fy8C6yB19EA>
    <xmx:K1T9ZsuuDXJG1UYLrfHQQALGQ5IeoUq8efJmCLjzTz_cby-N9096cg>
    <xmx:LFT9Zun3fgu8Ws1cncVI_2Aca-bkUnds9bikcsOAxwgiekvO1883f_ad>
Feedback-ID: i21f147d5:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 2 Oct 2024 10:09:45 -0400 (EDT)
Date: Wed, 2 Oct 2024 08:09:42 -0600
From: Tycho Andersen <tycho@tycho.pizza>
To: Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>
Cc: Aleksa Sarai <cyphar@cyphar.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Eric Biederman <ebiederm@xmission.com>, Kees Cook <kees@kernel.org>,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	Tycho Andersen <tandersen@netflix.com>
Subject: Re: [PATCH v3 1/2] exec: fix up /proc/pid/comm in the
 execveat(AT_EMPTY_PATH) case
Message-ID: <Zv1UJmR1UZUG2P/t@tycho.pizza>
References: <20241001134945.798662-1-tycho@tycho.pizza>
 <20241001.175124-western.preview.meager.saws-pzvpWxOhfokt@cyphar.com>
 <Zv1OayMEmLP2kjhj@kawka3.in.waw.pl>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Zv1OayMEmLP2kjhj@kawka3.in.waw.pl>

On Wed, Oct 02, 2024 at 01:45:15PM +0000, Zbigniew Jędrzejewski-Szmek wrote:
> On Tue, Oct 01, 2024 at 08:42:56PM +0200, Aleksa Sarai wrote:
> > On 2024-10-01, Tycho Andersen <tycho@tycho.pizza> wrote:
> > > From: Tycho Andersen <tandersen@netflix.com>
> > > 
> > > Zbigniew mentioned at Linux Plumber's that systemd is interested in
> > > switching to execveat() for service execution, but can't, because the
> > > contents of /proc/pid/comm are the file descriptor which was used,
> > > instead of the path to the binary. This makes the output of tools like
> > > top and ps useless, especially in a world where most fds are opened
> > > CLOEXEC so the number is truly meaningless.
> > > 
> > > Change exec path to fix up /proc/pid/comm in the case where we have
> > > allocated one of these synthetic paths in bprm_init(). This way the actual
> > > exec machinery is unchanged, but cosmetically the comm looks reasonable to
> > > admins investigating things.
> > 
> > While I still think the argv[0] solution was semantically nicer, it
> > seems this is enough to fix the systemd problem for most cases and so we
> > can revisit the argv[0] discussion in another 10 years. :D
> 
...

> Unfortunately, I don't think that the approach with
> f_path.dentry->d_name.name can be used :(

hmm. Somehow earlier I had managed to convince myself that this gives
the right answer for symlinks too (instead of the original
kbasename(__d_path(file->f_path, root, buf, buflen)), but now upon
retesting it doesn't. So I agree, seems like the argv[0] hack is
needed unfortunately.

Tycho


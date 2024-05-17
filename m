Return-Path: <linux-fsdevel+bounces-19651-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13B1A8C8453
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 May 2024 11:56:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C3AD8284BBC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 May 2024 09:56:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA409339AB;
	Fri, 17 May 2024 09:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=3xx0.net header.i=@3xx0.net header.b="SFLGcB5W";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="J76x28/z"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from wflow4-smtp.messagingengine.com (wflow4-smtp.messagingengine.com [64.147.123.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 055CA262A8;
	Fri, 17 May 2024 09:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715939764; cv=none; b=rTxgAc2ET1L3LM0pSMDgTKZRjhgiqXUotXgx22qL7Falqdkm0/5RiL8n5eiQ05aiqDfrKyIzNH4lE14M5BO1z2JHVWhH4NlqlCPOGqG91Z93PeikZBUjNn0BVkKZDmgU1gmI/R0JBwt2cWSZ8T3dJomzeD5ZDOsXn0ZWYRtAlUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715939764; c=relaxed/simple;
	bh=KkGcrkmfBCDmC5wsXf5TmL47hbWnMH6ayavHpq65iaM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uUXoDdhqoJ3NcZNnqWPSGPPo8cfZj80OKv3B+wGSPlbZnJSgLxjZHyLYBO27pXOJhtAx9Yw0OsnupZBeAUtfQQbQjaPzh6QwlMIPpsDavwwpVmjD+1NEgOtjiHaTzysCxnK3kl2EDLw6YnkT8j3ONNFE5JAemcoapIRymk1Cgdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=3xx0.net; spf=pass smtp.mailfrom=3xx0.net; dkim=pass (2048-bit key) header.d=3xx0.net header.i=@3xx0.net header.b=SFLGcB5W; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=J76x28/z; arc=none smtp.client-ip=64.147.123.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=3xx0.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=3xx0.net
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailflow.west.internal (Postfix) with ESMTP id 308202CC0147;
	Fri, 17 May 2024 05:55:59 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute7.internal (MEProxy); Fri, 17 May 2024 05:56:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=3xx0.net; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1715939759; x=1715943359; bh=rzLpoh5FVD
	3LOyLFCdIzkEcNceRgesd/v21Z/l7RZ5E=; b=SFLGcB5WertXb1V3m2fi+z4zdU
	Jp9S90ls3K+H9voIL3aIAJvTxnNjtJnWNCzLTGwdYoRMvNdLQUPAoi53A3ZbmzFN
	RlE8d1Snpi/dYtx6gH6uWh/wH3uKykEWklZOvuFDMZy9/o1VQ1u/O8XHKYoyzugn
	PNKksWA0LVq6/Q2MCD7vuymOtGhnnEoIqWWzVGk1sDKavrJIp1v4QAoqpDVmxaMo
	LSuehCvyvygU0bfbS5KroosGXeBzFTd2dfV2h/w95wS4ghWZ+QT8mX8ekacHbBmG
	bVlUNhJ5Py3c0QJHeKaGL1DoD2S6Wf1hDEg8jJCPKyAOEf5Zd8lz2BW9eXZQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	i76614979.fm3; t=1715939759; x=1715943359; bh=rzLpoh5FVD3LOyLFCd
	IzkEcNceRgesd/v21Z/l7RZ5E=; b=J76x28/z38Uyk36WUZXKSl0R9o1g4tW23+
	JtnPiGE6MbZgwvdz6mfgHIEWv8388bFiJkRd2c16WvW6fEqe8sUpcmbqBODF1uFY
	eeTIYBjuqbDDoX32oeXKr75JT++SadWSHuS99rk21COe4YdU/lKTw8K+eyDpknRr
	iz+aN4cHZGX8NvVtu3eVKEn7WNC71wiKzKRdvpr5FmtEtfxmhc94xpcXnmoNOBYF
	WviHE/W0ubivbnhaj4fgvYQSmuQL1jxMmelMgA3//R6WaDgu41IEGAi5paEhbS2A
	NGpaB3RPwBHmGBkJaygKFl07N6z9pb/BgAx+9ncpIGegZG+cmBMQ==
X-ME-Sender: <xms:rilHZj0FM99tlirSD41vgsWEJEEdqQTGO29OwOru8OwDwnqzlZ8aWg>
    <xme:rilHZiEloOFsYNCyshssEqC-7yh12MJxICZMxyzRlcPiTYlG5zU42E7EH2wqDIN0Y
    51tssm036N2jKPFSdk>
X-ME-Received: <xmr:rilHZj7NV8Ly8xSd9EsBVvlug2QPKNmcEcVlkiU83xlv63_xTWVyLIA_iWkhPP-lwQ9ozA6_CiDU6MAV3nNtBBY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdehfedgjeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtsfdttddtjeenucfhrhhomheplfhonhgr
    thhhrghnucevrghlmhgvlhhsuceojhgtrghlmhgvlhhsseefgiigtddrnhgvtheqnecugg
    ftrfgrthhtvghrnhepkeekteegfefgvdefgfefffeufeffjedvudeijeehjeehffekjeek
    leffueelgffgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
    homhepjhgtrghlmhgvlhhsseefgiigtddrnhgvth
X-ME-Proxy: <xmx:rilHZo2D099dIZwbXk55mk2SKAngP2oXBOENCkmjh4DAJPwZ6w9qAw>
    <xmx:rilHZmF1fx2MHJyoHxM7X06m7qiNCl2lJ54lmveuB-S7nBZFGwm_MQ>
    <xmx:rilHZp-8DOew53kGbq6lGMvcv9iRDw_tJJ6fxxzywkDXukR7zGxhnw>
    <xmx:rilHZjm7FAk5hNjKBn5SYAxY8cqgB5IB51w2jF76ZbiZk-WmM0c6kQ>
    <xmx:rylHZiHgiPuOWpTUiiuyl2BhNMuqGhKfsDpvzi0N3-Wb5eFH1SyQQIzm>
Feedback-ID: i76614979:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 17 May 2024 05:55:57 -0400 (EDT)
Date: Fri, 17 May 2024 03:00:58 -0700
From: Jonathan Calmels <jcalmels@3xx0.net>
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: Ben Boeckel <me@benboeckel.net>, brauner@kernel.org, 
	ebiederm@xmission.com, Luis Chamberlain <mcgrof@kernel.org>, 
	Kees Cook <keescook@chromium.org>, Joel Granados <j.granados@samsung.com>, 
	Serge Hallyn <serge@hallyn.com>, Paul Moore <paul@paul-moore.com>, 
	James Morris <jmorris@namei.org>, David Howells <dhowells@redhat.com>, containers@lists.linux.dev, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, keyrings@vger.kernel.org
Subject: Re: [PATCH 0/3] Introduce user namespace capabilities
Message-ID: <lkgjtvvbhiaern2fkcsholu4yaypsykfdpxim3k3mug2oko5iq@hoyossca24y5>
References: <20240516092213.6799-1-jcalmels@3xx0.net>
 <ZkYKgNltq2hlBzbx@farprobe>
 <D1B3XN42A6DR.1RSMLZ6R7VRHT@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <D1B3XN42A6DR.1RSMLZ6R7VRHT@kernel.org>

On Thu, May 16, 2024 at 04:36:07PM GMT, Jarkko Sakkinen wrote:
> On Thu May 16, 2024 at 4:30 PM EEST, Ben Boeckel wrote:
> > I note a lack of any changes to `Documentation/` which seems quite
> > glaring for something with such a userspace visibility aspect to it.
> >
> > --Ben
> 
> Yeah, also in cover letter it would be nice to refresh what is
> a bounding set. I had to xref that (recalled what it is), and
> then got bored reading the rest :-)

Thanks for reminding me, I actually meant to do it, just forgot.
Having said that, `Documentation/security/credentials.rst` is not the
best documention when it comes to capabilities. I will definitely add
few more lines in there, but it's probably not what you're looking for.

capabilities(7) is where everything is explained, I should have
mentioned it. I could try to summarize the existing sets, but honestly I
will probably do a worse job than the man page.

I do plan to update the man page though if it comes to that.


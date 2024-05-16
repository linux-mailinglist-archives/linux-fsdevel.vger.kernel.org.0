Return-Path: <linux-fsdevel+bounces-19583-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0618A8C77B5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 May 2024 15:32:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 727E51F23C1D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 May 2024 13:32:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A0B414E2EC;
	Thu, 16 May 2024 13:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=benboeckel.net header.i=@benboeckel.net header.b="Ulgo0/uJ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CMPaTGX3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fhigh5-smtp.messagingengine.com (fhigh5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AADD14E2CC;
	Thu, 16 May 2024 13:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715866246; cv=none; b=FsRwvX+bv89EZgN9wz4gBSpMV/l2Q+PUcQR99wReMhbuh55Pp4GSecjF0vjmKsIlcLEYi7ynv1DUqrdMlkTHQFX3ueru8ZwWzFVgUlsrjUe0efPtgEIuPiPElRBdYpf6xFu3kNbU6+JLPODueTUox7ABbqCzxJZeS5AZ/WP4XSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715866246; c=relaxed/simple;
	bh=69YmzG7HlmyFpdfSNhi6JvNROFFTperfLVWxTG48xks=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sDOJ9nFJ+zUnpQsY+UEqUWtm+kyHEiuGz9T0rGc5uOoyHsVfuuLgFcM6MDubPhv5BDJ+f0EJdqmXoF66GeOppHHXp0wpQHi89w+FtyRMCMTucXqwQw4PU3WC4UODe9hhpJFrj44YXeNqzhonZAb8EGJIXI7+nSPr3+2LtAyNkqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=benboeckel.net; spf=pass smtp.mailfrom=benboeckel.net; dkim=pass (2048-bit key) header.d=benboeckel.net header.i=@benboeckel.net header.b=Ulgo0/uJ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CMPaTGX3; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=benboeckel.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=benboeckel.net
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id A2B621140163;
	Thu, 16 May 2024 09:30:43 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Thu, 16 May 2024 09:30:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=benboeckel.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1715866243; x=
	1715952643; bh=srNyWoS8gHl7ihHI55zXs+WUoGWk3Nt7F0kqPAoVUgo=; b=U
	lgo0/uJOxneabXt0AO0W3Um5NvHMW3NQiBpDz8F3oMLNvhLBfqo7vCO8H4n/7irr
	agpY5/XrkIACg6iTAWjOFv5euU8S6F474qhXpW0LgfCCuPWiRn28CRkygS7YwBgf
	7Hu7DbqU7i39PcQUwYqqOOABn+QucgKolm4j0FvsrVF27q3vcPrEk4oWgGmXN79I
	qDQqq4Jxy8loVaiv63zw/CBWMGGAuj4eipGBRfNggJhuPoqzeVCn36NPNZNy2cFd
	1pLQiXcD2b2DUpJW9h7E0TipvGbKcsp9eJrvPpTBfCvK6EF+Ou4zB3v4NuRQ5CXe
	eKAjoiSg925auwaFUn0vw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1715866243; x=1715952643; bh=srNyWoS8gHl7ihHI55zXs+WUoGWk
	3Nt7F0kqPAoVUgo=; b=CMPaTGX36RAvpWpuLUdskxeKMOkh8NSmRhKj7qJy/FO0
	0hbdZDmwxRDRvehUreDUTjxmGVUcOTPAwglbSQfYawQX3JP32EEGe1xYkXbAVTq1
	N/H6BsWu9+QC+dJEOVNCUed1g/C6VZWArsC1kO8w0NZ8xyjZudDNAukXJC/UKrF0
	ngYh1kefeAg6loSLmgk6zJpalYB53lM1eJi/4L6CEhKmyebHjnb1nODNuPJxSQqJ
	SmFOnOFqg37E7AkKtBAr2ryALsRN7gMJI/NcPWEhe/zcyzEhGtX8a/u44jMCiNuA
	kUwAGKAMAN3wjuvdvPDjWrYfzJ5i4VVp8Y4HDP15uw==
X-ME-Sender: <xms:gQpGZnnPscjJflIkLrGofT2-Dvm0xkBHgMpOoUoOj77wTVnsAhQ_DA>
    <xme:gQpGZq0onq26fCD5nXCJVGsp4y_wKTqcDudN0rnZjpd2F0OvAuJJYXPgi1MQsgbuS
    o4vtRtuElhcqLsqD-4>
X-ME-Received: <xmr:gQpGZtoXv4FK_6IOr7oSTq9lhfSWKCxN18O_2wuXGv-jA18Uc-wuTeHCltMo5ZDJTwIvndnQNr4686xw9xhLS2ZLX-7YbbzpsrUz>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdehuddgieefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujggfsehttdertddtreejnecuhfhrohhmpeeuvghn
    uceuohgvtghkvghluceomhgvsegsvghnsghovggtkhgvlhdrnhgvtheqnecuggftrfgrth
    htvghrnhepffelgeffveelkeffkeehiefgtdeluedvtdfghfdtvdefgfejheffudeuveek
    vddvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepmh
    gvsegsvghnsghovggtkhgvlhdrnhgvth
X-ME-Proxy: <xmx:ggpGZvlvpjtSb_TmrALGRHYZdhaWLs-zxbFoBzNxHJVoSXWJkWKEeQ>
    <xmx:ggpGZl0nR1LnPmlWKoaPNhTEAoO5CytJyReBzV1nb4b-BaUb79L4og>
    <xmx:ggpGZuvsS2YxGDuTeEtF6n8k4Sr-AVOji0EqVFsNqK7WPzwivAn67Q>
    <xmx:ggpGZpWTcGqpLW9ijjbtsqcd8ln0xc-DXgh4fTgVfZ8Vcc3bbvYpiw>
    <xmx:gwpGZmHPE40il4HXpuoPKONGo7DBMWBXMShW5T8oNWMVLbwrKSJoZQLW>
Feedback-ID: iffc1478b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 16 May 2024 09:30:41 -0400 (EDT)
Date: Thu, 16 May 2024 09:30:40 -0400
From: Ben Boeckel <me@benboeckel.net>
To: Jonathan Calmels <jcalmels@3xx0.net>
Cc: brauner@kernel.org, ebiederm@xmission.com,
	Luis Chamberlain <mcgrof@kernel.org>,
	Kees Cook <keescook@chromium.org>,
	Joel Granados <j.granados@samsung.com>,
	Serge Hallyn <serge@hallyn.com>, Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	David Howells <dhowells@redhat.com>,
	Jarkko Sakkinen <jarkko@kernel.org>, containers@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-security-module@vger.kernel.org, keyrings@vger.kernel.org
Subject: Re: [PATCH 0/3] Introduce user namespace capabilities
Message-ID: <ZkYKgNltq2hlBzbx@farprobe>
References: <20240516092213.6799-1-jcalmels@3xx0.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240516092213.6799-1-jcalmels@3xx0.net>
User-Agent: Mutt/2.2.12 (2023-09-09)

On Thu, May 16, 2024 at 02:22:02 -0700, Jonathan Calmels wrote:
> Jonathan Calmels (3):
>   capabilities: user namespace capabilities
>   capabilities: add securebit for strict userns caps
>   capabilities: add cap userns sysctl mask
> 
>  fs/proc/array.c                 |  9 ++++
>  include/linux/cred.h            |  3 ++
>  include/linux/securebits.h      |  1 +
>  include/linux/user_namespace.h  |  7 +++
>  include/uapi/linux/prctl.h      |  7 +++
>  include/uapi/linux/securebits.h | 11 ++++-
>  kernel/cred.c                   |  3 ++
>  kernel/sysctl.c                 | 10 ++++
>  kernel/umh.c                    | 16 +++++++
>  kernel/user_namespace.c         | 83 ++++++++++++++++++++++++++++++---
>  security/commoncap.c            | 59 +++++++++++++++++++++++
>  security/keys/process_keys.c    |  3 ++
>  12 files changed, 204 insertions(+), 8 deletions(-)

I note a lack of any changes to `Documentation/` which seems quite
glaring for something with such a userspace visibility aspect to it.

--Ben


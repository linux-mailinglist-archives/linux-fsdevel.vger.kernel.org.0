Return-Path: <linux-fsdevel+bounces-19661-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D28EC8C85E1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 May 2024 13:50:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6BEAF1F24333
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 May 2024 11:50:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B4DE3FB84;
	Fri, 17 May 2024 11:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=3xx0.net header.i=@3xx0.net header.b="oN+OJvCa";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OMHyxNdB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from wflow6-smtp.messagingengine.com (wflow6-smtp.messagingengine.com [64.147.123.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 842DF3EA68;
	Fri, 17 May 2024 11:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715946607; cv=none; b=duKV3iR8L+/tXvx3DMOULbGXkQs++U9J7Q77VSe2i9uWqAS78A2cYJV5sKLnW3WOSEYSjsq5wmt0hJy8+Lnzmm4vgUHb7+jDPFJEB+3kZdQw7AjItMnSOcLgpLpmRuTJLt4D5pRzln42fDqxzNPUEUTWNHGBkbEtIoOdmEpv+ww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715946607; c=relaxed/simple;
	bh=fcsO48qIpnVYqAJjQXdMJxocnktnEkqyPz8/MEos1uw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u+1RiXnNQLSEVAdaROQ2EMsaqknLlBRxaQvVpg32HMzpWmgiii91ONA7T1UKNQGCkAw3U/WNMzOiRePnWwhNdUn/k2HZYOoA0YhKvqjszEm/fAveZ27oAxoZs7ZABJt8J3aqOOkq6rONs1gvrV5wtlqMyrKUcm2xd6EQfz+g9iU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=3xx0.net; spf=pass smtp.mailfrom=3xx0.net; dkim=pass (2048-bit key) header.d=3xx0.net header.i=@3xx0.net header.b=oN+OJvCa; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=OMHyxNdB; arc=none smtp.client-ip=64.147.123.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=3xx0.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=3xx0.net
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailflow.west.internal (Postfix) with ESMTP id D222C2CC0202;
	Fri, 17 May 2024 07:50:04 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute7.internal (MEProxy); Fri, 17 May 2024 07:50:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=3xx0.net; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1715946604; x=1715950204; bh=YBR/kzVP1R
	uULEn1G9m27wd3x25feteROyMUF2wtSUE=; b=oN+OJvCaaj/aOGeeQiKJjifSEn
	mXkYghwt8nmJwJPBgXWwa6yITxbhzv/tndzUeX/gSJigCMOoMZAKl/ungWvPz3P1
	l7WqR46291xSWccaG6Zl45zyBUF3UoR2e3JnNW9IoMJY9R0y1o3fMzwfp6nYHxRo
	VB/0LaQKRaElfsaA5jX0zsB6M5NRIfrRm8Qb1Qw1eTU0roZj+bCs6C1Ac86amP6H
	zAkuc6srhpWUWMceNyQXoO/a8uZRKgD01CCqopRzFXn5guL14jInjCPQddDVHSq9
	LmkoC+uMgFSDbJM00AvlkhMSLszWxv9wLRFaJYa9O3cvev7YMUbAsXv6cSUw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	i76614979.fm3; t=1715946604; x=1715950204; bh=YBR/kzVP1RuULEn1G9
	m27wd3x25feteROyMUF2wtSUE=; b=OMHyxNdBVKsPsSWDTFbB+BzBYTKfVTwAGA
	tEnSRY1DI2zWLntqO+LnrYiIjZcqvrLSNBiR0Z8y/4QHI2y7WVJ9fAGZt5u15n7R
	8yHwteCV+JiDclKu4TeAvoCNV+TvbpNMqGI09an+XVJYMSWhdfXVNR66vmhROkb4
	BN7tAjRrtWN7gESTJJWDl8YEqyE1UzrnxBhGQiVK6NLNpHWdPlO/6s8Gc63sFYaf
	SMG2rjEbRbDyBvlwiPtDwad6pQj7+L+6Wl6dUIKuSPoOiBwa13m7hZVQ4mgMGRL0
	X09LY/xiC4kpAirO7+Pa1oibg5lL23aHfu/bHIMhYFEVPDpOc8HQ==
X-ME-Sender: <xms:a0RHZopWMhklPMtnYyTMpmP8V_ds5PR-xqozqYezePcerS7kYf85zA>
    <xme:a0RHZurwXK8CBgwPVaD_oUKbn1uvqrNBtQKY-4qzgt_1m67krd-BG5O2yUTklaz_V
    gUnzKrHGDoyW5_DAOQ>
X-ME-Received: <xmr:a0RHZtMnHSbxWRZv8eSceAFPoSRrWz9cxnTz2XWgwVObl7TwFE7vvBNJMxS8BxINRHo4wHEHSXMJ_bEcFRoutpQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdehfedgleekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    gfrhhlucfvnfffucdlqdeimdenucfjughrpeffhffvvefukfhfgggtuggjsehttdfstddt
    tdejnecuhfhrohhmpeflohhnrghthhgrnhcuvegrlhhmvghlshcuoehjtggrlhhmvghlsh
    esfeiggidtrdhnvghtqeenucggtffrrghtthgvrhhnpeegleelleefgffhkeeukeetudek
    vdevgeehkeelhffhleelffevgeefffdutdefieenucffohhmrghinhepnhhishhtrdhgoh
    hvpdhsvggtlhhishhtshdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehjtggrlhhmvghlshesfeiggidtrdhnvght
X-ME-Proxy: <xmx:a0RHZv7ymGEj1Ji2D81ExlCoUJfgfPoC-lX1_qjvViyHJBV-O7lSIg>
    <xmx:a0RHZn5u23p9_k1J6BWFLg-aJ6FCyZvpoteSylWbwo8KHlLNrqKS_Q>
    <xmx:a0RHZvjbwRVEhoAZXlaPgcO0PMdDWZBFb6prhzO6E9ryrCaOD6mLoA>
    <xmx:a0RHZh4Kabq7CSgxGTDITCvVmHQdupkFVtJpI6UMbU1Y2bFd2X9v3g>
    <xmx:bERHZvzNA6P81LPMZXXs_YiJUgZRmw5yGYFvp6EXCInwKewQ99Z4fdAo>
Feedback-ID: i76614979:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 17 May 2024 07:50:01 -0400 (EDT)
Date: Fri, 17 May 2024 04:55:03 -0700
From: Jonathan Calmels <jcalmels@3xx0.net>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: brauner@kernel.org, Luis Chamberlain <mcgrof@kernel.org>, 
	Kees Cook <keescook@chromium.org>, Joel Granados <j.granados@samsung.com>, 
	Serge Hallyn <serge@hallyn.com>, Paul Moore <paul@paul-moore.com>, 
	James Morris <jmorris@namei.org>, David Howells <dhowells@redhat.com>, 
	Jarkko Sakkinen <jarkko@kernel.org>, containers@lists.linux.dev, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-security-module@vger.kernel.org, keyrings@vger.kernel.org
Subject: Re: [PATCH 1/3] capabilities: user namespace capabilities
Message-ID: <xv52m5xu5tgwpckkcvyjvefbvockmb7g7fvhlky5yjs2i2jhsp@dcuovgkys4eh>
References: <20240516092213.6799-1-jcalmels@3xx0.net>
 <20240516092213.6799-2-jcalmels@3xx0.net>
 <878r08brmp.fsf@email.froward.int.ebiederm.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <878r08brmp.fsf@email.froward.int.ebiederm.org>

On Fri, May 17, 2024 at 06:32:46AM GMT, Eric W. Biederman wrote:
> 
> Pointers please?
> 
> That sentence sounds about 5 years out of date.

The link referenced is from last year.
Here are some others often cited by distributions:

https://nvd.nist.gov/vuln/detail/CVE-2022-0185
https://nvd.nist.gov/vuln/detail/CVE-2022-1015
https://nvd.nist.gov/vuln/detail/CVE-2022-2078
https://nvd.nist.gov/vuln/detail/CVE-2022-24122
https://nvd.nist.gov/vuln/detail/CVE-2022-25636

Recent thread discussing this too:
https://seclists.org/oss-sec/2024/q2/128


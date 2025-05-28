Return-Path: <linux-fsdevel+bounces-49965-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 90CB8AC6610
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 May 2025 11:34:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B9DB4E26DA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 May 2025 09:34:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16CF4277807;
	Wed, 28 May 2025 09:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=tnxip.de header.i=@tnxip.de header.b="x3o0pfEx";
	dkim=permerror (0-bit key) header.d=tnxip.de header.i=@tnxip.de header.b="bO5s1g5n";
	dkim=pass (1024-bit key) header.d=tnxip.de header.i=@tnxip.de header.b="RCF/oxrH";
	dkim=permerror (0-bit key) header.d=tnxip.de header.i=@tnxip.de header.b="RS/hvYC+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail.tnxip.de (mail.tnxip.de [49.12.77.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44478275862;
	Wed, 28 May 2025 09:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=49.12.77.104
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748424843; cv=none; b=OmIE/nOmlsfGmnA48FY2nk54v6UlX6P/HI+zSLQXUyFjsyysAaEVLpB3GkpsKkU6spP+6GcgVJ0xLCj/j3OruRhbGuJqkQmZlxbqWTOvBPu7hn3pu/EeDvbag5kL57yCiSrIerQGdFa+gwJT1/3nnbScbAfY6cBWF7OQ+S5wNE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748424843; c=relaxed/simple;
	bh=lHOao4f90r2RuIwnd2exhchFt6vf/wURXyd5Uy6/grY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TaK6NMs+hQfMpPa+MJKy0zguwyfKQTanUNILsB7iQ9rHnFjEO4BLbknqscbmE+Se/l560hOFwWkwxgCYjp51TDofRsAx2oeXqEWovq30Y2ZcsA96ULUuULkUpexbx2pGnnmTTKlu1SmPemWXjAK46a5DQrfBoFYXNg+ds5QRYss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=tnxip.de; spf=pass smtp.mailfrom=tnxip.de; dkim=pass (1024-bit key) header.d=tnxip.de header.i=@tnxip.de header.b=x3o0pfEx; dkim=permerror (0-bit key) header.d=tnxip.de header.i=@tnxip.de header.b=bO5s1g5n; dkim=pass (1024-bit key) header.d=tnxip.de header.i=@tnxip.de header.b=RCF/oxrH; dkim=permerror (0-bit key) header.d=tnxip.de header.i=@tnxip.de header.b=RS/hvYC+; arc=none smtp.client-ip=49.12.77.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=tnxip.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tnxip.de
Received: from gw.tnxip.de (unknown [IPv6:fdc7:1cc3:ec03:1:f29b:38e6:bb40:eef3])
	by mail.tnxip.de (Postfix) with ESMTPS id 09C78208AE;
	Wed, 28 May 2025 11:33:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tnxip.de; s=mail-vps;
	t=1748424821;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=unXoNt8RgGaDR53xvpXFRb94qbLzrsUOA132jkwj588=;
	b=x3o0pfExGWs0xCktoi1YrVcQUEhflEhWUQIo/tlbrRZi1PHnoGp8uBmAl2acf95FhmPg6A
	BcqzNh1kW3D/3y4n3OrQ6sX1zuYuLDm4o9tCt6yV+EGQjydk/DQluy1PbrQ8R4jjrmXVE8
	C2h0C8CurRHJ+U1xZ4BL3VMsB5LEFOA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=tnxip.de;
	s=mail-vps-ed; t=1748424821;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=unXoNt8RgGaDR53xvpXFRb94qbLzrsUOA132jkwj588=;
	b=bO5s1g5nTtmyPfJpZQ+Jpreo3UD87C9LZoa14jQjc93MNP53QtdXnLMCift6Hx4LatPVX4
	G8SS0B/FDfPEJ3Aw==
Received: from [IPV6:2a04:4540:8c01:d800:4e12:6eb0:854b:f0d1] (unknown [IPv6:2a04:4540:8c01:d800:4e12:6eb0:854b:f0d1])
	by gw.tnxip.de (Postfix) with ESMTPSA id 85B3F6C00000000007B4C;
	Wed, 28 May 2025 11:33:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tnxip.de; s=mail-gw;
	t=1748424820;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=unXoNt8RgGaDR53xvpXFRb94qbLzrsUOA132jkwj588=;
	b=RCF/oxrHzS55UvfwOwJpiC7ivcWvloPThIisxnSdLKhYSJTeJZ6iU8afyglxVv3Ga+dny7
	aZi5JcoPogG9cQ0d3iQ6UOrZm0PiJ6Nl6U/SqHc4eh50h5Tqsgb4ZL8+cTqzwHLy98DT9Q
	sujdzG6ahXbGMNOas6mugRHRztD66mQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=tnxip.de;
	s=mail-gw-ed; t=1748424820;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=unXoNt8RgGaDR53xvpXFRb94qbLzrsUOA132jkwj588=;
	b=RS/hvYC+l6MlBletU1Cjx1t0tFPFDiC4pZoiA4/MF6PdfmETR0e+jsMGPHQNCmtXdl6wgx
	n3oJRF9cV4IARvAg==
Message-ID: <c2001c69-e735-4976-ac8b-6269c825cb92@tnxip.de>
Date: Wed, 28 May 2025 11:33:34 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Linux)
Subject: Re: [GIT PULL] bcachefs changes for 6.16
To: Christopher Snowhill <chris@kode54.net>, John Stoffel <john@stoffel.org>,
 Kent Overstreet <kent.overstreet@linux.dev>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
 linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <oxkibsokaa3jw2flrbbzb5brx5ere724f3b2nyr2t5nsqfjw4u@23q3ardus43h>
 <dmfrgqor3rfvjfmx7bp4m7h7wis4dt5m3kc2d3ilgkg4fb4vem@wytvcdifbcav>
 <26678.2527.611113.400746@quad.stoffel.home>
 <DA7O5Z6M9D5H.2OX4U4K5YQ7C9@kode54.net>
Content-Language: en-US, de-DE
From: =?UTF-8?Q?Malte_Schr=C3=B6der?= <malte.schroeder@tnxip.de>
In-Reply-To: <DA7O5Z6M9D5H.2OX4U4K5YQ7C9@kode54.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 28/05/2025 11:00, Christopher Snowhill wrote:
> On Tue May 27, 2025 at 11:52 AM PDT, John Stoffel wrote:
>>>>>>> "Kent" == Kent Overstreet <kent.overstreet@linux.dev> writes:
>>> There was a feature request I forgot to mention - New option,
>>> 'rebalance_on_ac_only'. Does exactly what the name suggests, quite
>>> handy with background compression.
>> LOL, only if you know what the _ac_ part stands for.  :-)
> Would you have suggested perhaps _mains_ ? That may have rang better
> with some folks. I suppose, at least.
>
What about 'no_rebalance_on_battery'? 

/Malte



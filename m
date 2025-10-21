Return-Path: <linux-fsdevel+bounces-65007-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id ABA2DBF903F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Oct 2025 00:12:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C108E4EDA62
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Oct 2025 22:12:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BCB229A312;
	Tue, 21 Oct 2025 22:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="kX4lhc38"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from submarine.notk.org (submarine.notk.org [62.210.214.84])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AE722989BC;
	Tue, 21 Oct 2025 22:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.210.214.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761084751; cv=none; b=jRYLGt61yeHjQPfJuTqQWIw2WwdkXxrUJY494wwu/t3p+jgj26hOPks9fmQH+t5Hzt6XzUjo2kJqjst+5N6Tb2n9O1J1Gb8yP1aIyHaqtdflcDGFJJYIPXhvALxCCllgWBgPcDbOJZOgdpVXehyQzjQ39mMXfnykW7YQY/EBSjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761084751; c=relaxed/simple;
	bh=ofUIlUcJf+qSxbCYFOj4Dmv8C/Q/gYj+rCTIU17Szqs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DwTx0+dt8MgglW7D0oIeKqnBM+gYBI/5wC2cGWfdfw5gSDSZf2EJA6ioKng1h1BYpS+NPPqtD/9eAFbygTDnLZ8BRXWXBachonE52NVg+PgJEnKJfdzv4wtL1SptF/0wq6AKzRp5kiqGlQ318zORo7KMLF12Cl1MsX4lzeUyVKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org; spf=pass smtp.mailfrom=codewreck.org; dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b=kX4lhc38; arc=none smtp.client-ip=62.210.214.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewreck.org
Received: from gaia.codewreck.org (localhost [127.0.0.1])
	by submarine.notk.org (Postfix) with ESMTPS id B02D014C2D3;
	Wed, 22 Oct 2025 00:12:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org;
	s=2; t=1761084741;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DvgjUM9pwk9ojxcDr4HMoG2nE5PWiwPcbp29vqBU1MQ=;
	b=kX4lhc38IASBnGAnsO2gRsnvwMooM10C4XUxJwu1iiBoQ0Yt6dRbGxRdV59OGZmDIh7SJ1
	CCCbN+U8fQMKAdz0ruJhqkEutoTsmcoVqmtyro9Brk6JK4EJs8QAJVVAHZfh2o31AjmxGK
	IcJi68ksWWiz9jNTtOVPbCmUFfJq7t+Rlh8IbUJILZ129kf9BIcftNqZQiPk6ylgFWHp5a
	Fe1NArMgPxT/x4V4M5Cq8WqVdPAWs4yARjmreAuatu7fowYr69lhmChIsDTQlGujjYF3rK
	Ed02cDwGfd9zIzELtdIkr8TmufRWTQ0LuNmntysnVeYTFgIaDGrD5QSykKSCSw==
Received: from localhost (gaia.codewreck.org [local])
	by gaia.codewreck.org (OpenSMTPD) with ESMTPA id f75e589d;
	Tue, 21 Oct 2025 22:12:17 +0000 (UTC)
Date: Wed, 22 Oct 2025 07:12:02 +0900
From: Dominique Martinet <asmadeus@codewreck.org>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Song Liu <song@kernel.org>,
	Linux-Fsdevel <linux-fsdevel@vger.kernel.org>,
	Christian Brauner <brauner@kernel.org>, Tingmao Wang <m@maowtm.org>,
	v9fs@lists.linux.dev, Eric Van Hensbergen <ericvh@kernel.org>,
	Latchesar Ionkov <lucho@ionkov.net>,
	Christian Schoenebeck <linux_oss@crudebyte.com>,
	=?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>,
	bpf <bpf@vger.kernel.org>
Subject: Re: 9P change breaks bpftrace running in qemu+9p?
Message-ID: <aPgFMtg2DzzeRreH@codewreck.org>
References: <CAHzjS_u_SYdt5=2gYO_dxzMKXzGMt-TfdE_ueowg-Hq5tRCAiw@mail.gmail.com>
 <e0c7cd4e-4183-40a8-b90d-12e9e29e9890@maowtm.org>
 <CAHzjS_sXdnHdFXS8z5XUVU8mCiyVu+WnXVTMxhyegBFRm6Bskg@mail.gmail.com>
 <aPaqZpDtc_Thi6Pz@codewreck.org>
 <CAHzjS_uEhozUU-g62AkTfSMW58FphVO8udz8qsGzE33jqVpY+g@mail.gmail.com>
 <086bb120-22eb-43ff-a486-14e8eeb7dd80@maowtm.org>
 <CAHzjS_vrVJrphZqBMxVE4UEfOqgP8XPq6dRuBh9DdWL-SYtO2w@mail.gmail.com>
 <CAADnVQKSJTAx-4T4WLFhLPcmJ-Ea5onKG+Z-d9iv48r4A6nJMQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAADnVQKSJTAx-4T4WLFhLPcmJ-Ea5onKG+Z-d9iv48r4A6nJMQ@mail.gmail.com>

Alexei Starovoitov wrote on Tue, Oct 21, 2025 at 09:56:10AM -0700:
> > I am not sure what is the "right" behavior in this case. But this is
> > clearly a change of behavior.

That's definitely wrong, the resulting file was truncated.
Thanks for the repro!

I've sent a fix here:
https://lkml.kernel.org/r/20251022-mmap-regression-v1-1-980365ee524e@codewreck.org


Would be great if you could confirm it fixes your problems, and I'll get
it sent to Linus

> Andrii reported the issue as well:
> https://lore.kernel.org/bpf/CAEf4BzZbCE4tLoDZyUf_aASpgAGFj75QMfSXX4a4dLYixnOiLg@mail.gmail.com/
> 
> selftests/bpf was relying on the above behavior too
> which we adjusted already, but
> this looks to be a regression either in 9p or in vfs.

Looks like a 9p bug, sorry :(

-- 
Dominique Martinet | Asmadeus


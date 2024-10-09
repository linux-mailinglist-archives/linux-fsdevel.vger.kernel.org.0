Return-Path: <linux-fsdevel+bounces-31499-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 65DDE997830
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Oct 2024 00:05:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0ED721F22FB4
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Oct 2024 22:05:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 453BE1E284D;
	Wed,  9 Oct 2024 22:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="R16IwXGB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45E2917BB0C;
	Wed,  9 Oct 2024 22:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728511545; cv=none; b=NX79ahUabthsdxiesyva8CIK8FYh4o1l8AKryQ7ECE3G17ZaHIKEfzRdpL+1OFDrI87DKxUMXEcX9AWmHIjiztVsWpsOCAuaVAzg07kf04fobHuzF5gH1G9efUvD/SB63rXp8qiyAXuRCepwpAN81UMI/iqTvfbbFRbNrl+8Lto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728511545; c=relaxed/simple;
	bh=wxF79zloP0555edTYf3CDSmVOmYgTFrK1mTExF/iD/o=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=pTRjk11IdvEFUWRTESj4dGTogApqDJGV1zN6h1y9Rb9xquD+7wsyh5ZSUCM9vffxElHJKF6HVzsA8oe89NkEm0kU/1WhUSpy/kbzlGl1rKQWRH5cDuI9DJwpCpDcpsQGJEQajbTtbu6s9qHkWRF43hxicjZA+TjHBFZijt4vBcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=R16IwXGB; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 4ABCF42BFE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1728511543; bh=GHDVqJYVncsyLXfe8qK6kBUI51p/2a3Wwqa6+2vFPRc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=R16IwXGBK5EY8sN05mtSLHMC4ghhhkIjPFbQy9XAOCm/obkELNzX5S6NuVi1lNr0a
	 QLCb9gOr2ukJanfsEw1e9vCXP8Z/m59B+H6m6iT84HnDkiZu9wT5IukQRvl499KNDR
	 zafwJutTC5Ke4hbsKRJSpyROgGjv13g0wup1N2U52WgC5IFg32mQIDZ5vFCq/mfaLN
	 Q89K6+ynVHXkL6kvH1MusABIEJxCqDNCKQDuRMOc6LoECqQmlz5lYwdMKl0L4nNQRI
	 GvDQitEnwfIYAWOcoJTpxQvLHbI5f82Xogfn/QecGEQv9fGYFIR961kzCw1fXvFYn3
	 ee6tjQgu0WWIg==
Received: from localhost (unknown [IPv6:2601:280:5e00:625::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 4ABCF42BFE;
	Wed,  9 Oct 2024 22:05:43 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Aleksa Sarai <cyphar@cyphar.com>
Cc: luca.boccassi@gmail.com, linux-fsdevel@vger.kernel.org,
 christian@brauner.io, linux-kernel@vger.kernel.org, oleg@redhat.com
Subject: Re: [PATCH v9] pidfd: add ioctl to retrieve pid info
In-Reply-To: <20241009.210353-murky.mole.elite.putt-JnYGYHfGrAtK@cyphar.com>
References: <20241008121930.869054-1-luca.boccassi@gmail.com>
 <87msjd9j7n.fsf@trenco.lwn.net>
 <20241009.205256-lucid.nag.fast.fountain-SP1kB7k0eW1@cyphar.com>
 <20241009.210353-murky.mole.elite.putt-JnYGYHfGrAtK@cyphar.com>
Date: Wed, 09 Oct 2024 16:05:42 -0600
Message-ID: <87y12x7wzt.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Aleksa Sarai <cyphar@cyphar.com> writes:

>> In fairness, this is how statx works and statx does this to not require
>> syscall retries to figure out what flags the current kernel supports and
>> instead defers that to stx_mask.
>> 
>> However, I think verifying the value is slightly less fragile -- as long
>> as we get a cheap way for userspace to check what flags are supported
>> (such as CHECK_FIELDS[1]). It would kind of suck if userspace would have
>> to do 50 syscalls to figure out what request_mask values are valid.
>
> Unfortunately, we probably need to find a different way to do
> CHECK_FIELDS for extensible-struct ioctls because CHECK_FIELDS uses the
> top bit in a u64 but we can't set a size that large with ioctl
> numbers...

Add a separate PIDFD_GET_VALID_REQUEST_MASK ioctl()?

But then I'm bad at designing interfaces...

jon


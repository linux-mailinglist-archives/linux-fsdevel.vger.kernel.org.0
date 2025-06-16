Return-Path: <linux-fsdevel+bounces-51776-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BDD2ADB41F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Jun 2025 16:41:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC6C51883196
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Jun 2025 14:39:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6653E218AB0;
	Mon, 16 Jun 2025 14:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cj3IxzR1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C62A921771A
	for <linux-fsdevel@vger.kernel.org>; Mon, 16 Jun 2025 14:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750084725; cv=none; b=gST0nsr15wlbmHrlN9beCW9YPvSuF/Dgly26UPZqHgGXjqc7LC8iTWH0xSSR+AkLLiNArti6iyRZAexA/t2OiT9Rrkkk+6kf8JWaDz/agc2eDlFBP9Hln43EAhVVoGxiWVsGzLP9kNquw10+z4deQFtr1JCCvmMKTTW/wYNt6Ew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750084725; c=relaxed/simple;
	bh=mBzuWIEwOaoYMN2iEm9j+ZbWeWPHELGxS9paPkq1zDU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cEDoEdD2kawKZh3zX/u/NcilpPDveiEzm/DLdtthhFqrBiB8hsI2/2lIQ3xAt+kPaJW729LiTmoALEqbzzJwqQt3yeHzv6znX/08rt45BY00ECxbhP0xInbfwqhA7XpJpTv06OQ61+on1fAUIQaFXCwoYJJHPz69+Zk2hviD3mU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cj3IxzR1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D789C4CEEA;
	Mon, 16 Jun 2025 14:38:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750084725;
	bh=mBzuWIEwOaoYMN2iEm9j+ZbWeWPHELGxS9paPkq1zDU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Cj3IxzR1cLkIfazf2dx33lvSKdEAFm1mlmmocxc9/sJF1VSEDerAyar2P589Aed57
	 n428J7QjmVbe1bd/91WAtEvDXnyRVYpQCiKNAY0teOKKMjUpy63PDxd3IMNs0UfYDU
	 OpUU7x3JE0RkxmtsofbfX+l3ZSHsWXmNGu4CC4GMzNx12RUJYUmIcr6aaUCqYF9cmL
	 ZPk+NO1BpLZaT7cGf3NhL7ziyt5KTTQzuNJTFAqH1FYEkRKtkgNm1ZO22bxqkGF/HY
	 nLWkR062ey4m/cwRpJd2pkRuoGlnpCCD9Lfa/bL7uCnlxJGeHmxN/Yqe36GZhaW4+D
	 ePQgJwz4+f2qg==
Date: Mon, 16 Jun 2025 16:38:41 +0200
From: Christian Brauner <brauner@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, neil@brown.name, 
	torvalds@linux-foundation.org
Subject: Re: [PATCH 2/8] add locked_recursive_removal()
Message-ID: <20250616-visier-anblicken-29e086687864@brauner>
References: <20250614060050.GB1880847@ZenIV>
 <20250614060230.487463-1-viro@zeniv.linux.org.uk>
 <20250614060230.487463-2-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250614060230.487463-2-viro@zeniv.linux.org.uk>

On Sat, Jun 14, 2025 at 07:02:24AM +0100, Al Viro wrote:
> simple_recursive_removal() assumes that parent is not locked and
> locks it when it finally gets to removing the victim itself.
> Usually that's what we want, but there are places where the
> parent is *already* locked and we need it to stay that way.
> In those cases simple_recursive_removal() would, of course,
> deadlock, so we have to play racy games with unlocking/relocking
> the parent around the call or open-code the entire thing.
> 
> A better solution is to provide a variant that expects to
> be called with the parent already locked by the caller.
> 
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---

Reviewed-by: Christian Brauner <brauner@kernel.org>


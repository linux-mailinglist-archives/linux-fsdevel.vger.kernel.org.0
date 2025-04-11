Return-Path: <linux-fsdevel+bounces-46264-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D1019A86012
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Apr 2025 16:10:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D13B63A899C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Apr 2025 14:08:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 592671F2C44;
	Fri, 11 Apr 2025 14:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s6P/XPij"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7E431865EE;
	Fri, 11 Apr 2025 14:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744380497; cv=none; b=Q7FOxjeGrsE5eQnbu9IzD5lNdQFNu0pq9vodS76v6R4h3MZXaJG+ST9su6OyG7TubyRiPzcg183B97F48PH7H3ygYRPTEiA4AbZyHmSFZTPbjHccyNBQqzzueO5Cqee5oawjtVbCSbq9R7gc5dL29ynT7+MEJx/ym3vspzu0q4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744380497; c=relaxed/simple;
	bh=PodhmP7IA+b1pr+LJt26zz1zpXSXHObcfFT8DaM85BI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uAvFANlZL/3B+/fO0oBbsNjP++LUK8miyPLCiebi1rSNtTOPudlzzWsS/o3W04oWJiFltGHYMqN4qyWObvWVA6amllf2oqayq9ZRhp6JQA1QRugWKucXcOIv3HJWnBWwxvoFcv1vmdNY25JjWF4PLTwBZIt944dlVxJlLzbDdpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s6P/XPij; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B854DC4CEE2;
	Fri, 11 Apr 2025 14:08:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744380497;
	bh=PodhmP7IA+b1pr+LJt26zz1zpXSXHObcfFT8DaM85BI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=s6P/XPij9+owbKpkyZK9j5tfz6QnlYAynhLzSYkbVQhR3FFQBjQ5FIKBsjmAATWJr
	 4DZUesZcpvW84Z54FW3Egotjy5/BbempjQu9xE2pEt9Hj2y/kswR5a+o1BYqSY98bx
	 cU8a6j7V3IF2EmsUziAjKeWj9C09E1+x23/JRoEvWrK53d9M0K25ydjigBElLsoKCi
	 oAUDJGfF5DTUA6tUo61KicRQXnBJHaQQEAcknO3gv7yz4LvogfgfZTwhO0+vMk++H7
	 TUmABjBBE1vSXGiFGYR7RCgIwvNi8TmDFtISm7f4ElgYXxHXwAAdpL5VcSspi4RXvS
	 lfYJrp0ZJSX3w==
Date: Fri, 11 Apr 2025 16:08:13 +0200
From: Christian Brauner <brauner@kernel.org>
To: Jan Stancek <jstancek@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk, jack@suse.cz, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fs: use namespace_{lock,unlock} in dissolve_on_fput()
Message-ID: <20250411-umlegen-herauf-508fe182fffa@brauner>
References: <cad2f042b886bf0ced3d8e3aff120ec5e0125d61.1744297468.git.jstancek@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cad2f042b886bf0ced3d8e3aff120ec5e0125d61.1744297468.git.jstancek@redhat.com>

On Thu, Apr 10, 2025 at 05:05:42PM +0200, Jan Stancek wrote:
> In commit b73ec10a4587 ("fs: add fastpath for dissolve_on_fput()"),
> the namespace_{lock,unlock} has been replaced with scoped_guard
> using the namespace_sem. This however now also skips processing of
> 'unmounted' list in namespace_unlock(), and mount is not (immediately)
> cleaned up.

Thank you for spotting and fixing this! My bad.

> diff --git a/fs/namespace.c b/fs/namespace.c
> index 14935a0500a2..ee1fdb3baee0 100644
> --- a/fs/namespace.c
> +++ b/fs/namespace.c
> @@ -1830,6 +1830,8 @@ static inline void namespace_lock(void)
>  	down_write(&namespace_sem);
>  }
>  
> +DEFINE_GUARD(namespace_locked, struct rw_semaphore *, namespace_lock(), namespace_unlock())

I'll call that namespace_lock instead if you don't mind.


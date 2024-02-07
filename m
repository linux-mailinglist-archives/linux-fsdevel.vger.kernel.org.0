Return-Path: <linux-fsdevel+bounces-10669-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6917384D34F
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Feb 2024 21:56:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 55639B27AE3
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Feb 2024 20:56:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 361BD8593E;
	Wed,  7 Feb 2024 20:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kYut+V7K"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81E0A5A0EB;
	Wed,  7 Feb 2024 20:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707339391; cv=none; b=rZCcbH5wWd1k8Ze8CpscUuKEXpssKuc9F5qT6H5C+74Sj7yVGJ1r5eopYGY34JGFKZiJV7HpOi1JijRaDf3dRN7JAzigtCoI/aw3VaVT1XSKb5SNakhcOATj/oq7OqFkw2kTNcx1nojziN8BZtEr3L9/lg8l4OYs3vYy+vWqNDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707339391; c=relaxed/simple;
	bh=O9TU/DdbGeLFdubQoNlLF1Trt2IeopsApf3EemlHi6Y=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QcArXmIok18WyXr4SytssJyKFAEuiV7OJcjHyQQZ+G32FIqhXgbuUCMHO6ScZPBBZBHPRh/4/vZ/3NK8DZ5BpkXhrM17+1So2O27LawZZEdFOaR0ieZw7DkVdn4g6daVWYtFv6LHz3bjSglh0Rh6OHy+0pNfIRQ5ltvBArmhvL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kYut+V7K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96A5AC433C7;
	Wed,  7 Feb 2024 20:56:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707339390;
	bh=O9TU/DdbGeLFdubQoNlLF1Trt2IeopsApf3EemlHi6Y=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=kYut+V7KhMj1sRThLMAxbOr3ZEjyRsnXLexMXFD7K9mPevhW7o4xU+pjGquYXHx5G
	 SXrQkIL9faPgy5DgiOzV/Iz8yUin1c7ruI0qLvomSJq10HTjZ93tqPT0+C88g8vLDf
	 e3KKoEsbfCwMDjWggS6+imu99xHx9aA082xeW/vW1ZQOsIwTb6kJcgUtqUgGjS3SFQ
	 seCQSVN2HjpFt0SEyrxiEw5rq9qlURCgDqO5qQz1C9v2hncxVYu6J3l8Otu1mMJdk4
	 81G2h8skksL3mIfLwwLtHX3izqkg92hwKoVESIkdMKbU3FMkNB7U2E0L85PTdZT81h
	 0lnLScoQH0AyA==
Date: Wed, 7 Feb 2024 12:56:28 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Joe Damato <jdamato@fastly.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 chuck.lever@oracle.com, jlayton@kernel.org, linux-api@vger.kernel.org,
 brauner@kernel.org, edumazet@google.com, davem@davemloft.net,
 alexander.duyck@gmail.com, sridhar.samudrala@intel.com,
 willemdebruijn.kernel@gmail.com, weiwan@google.com,
 David.Laight@ACULAB.COM, arnd@arndb.de, sdf@google.com,
 amritha.nambiar@intel.com, Alexander Viro <viro@zeniv.linux.org.uk>, Jan
 Kara <jack@suse.cz>, "open list:FILESYSTEMS (VFS and infrastructure)"
 <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH net-next v6 1/4] eventpoll: support busy poll per epoll
 instance
Message-ID: <20240207125628.44c5d732@kernel.org>
In-Reply-To: <20240207202323.GA1283@fastly.com>
References: <20240205210453.11301-1-jdamato@fastly.com>
	<20240205210453.11301-2-jdamato@fastly.com>
	<20240207110413.0cfedc37@kernel.org>
	<20240207191407.GA1313@fastly.com>
	<20240207121124.12941ed9@kernel.org>
	<20240207202323.GA1283@fastly.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 7 Feb 2024 12:23:23 -0800 Joe Damato wrote:
> > Unless you have a clear reason not to, I think using u32 would be more
> > natural? If my head math is right the range for u32 is 4096 sec,
> > slightly over an hour? I'd use u32 and limit it to S32_MAX.  
> 
> OK, that seems fine. Sorry for the noob question, but since that represents
> a fucntional change to patch 4/4, I believe I would need to drop Jiri's
> Reviewed-by, is that right?

I'd default to keeping it. But the review tag retention rules are one
of the more subjective things in kernel developments.


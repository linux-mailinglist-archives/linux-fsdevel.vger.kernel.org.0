Return-Path: <linux-fsdevel+bounces-41056-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93552A2A652
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Feb 2025 11:51:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9DFB53A7F12
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Feb 2025 10:51:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27E4822757C;
	Thu,  6 Feb 2025 10:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ftwqyJ2/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88D4E1F60A
	for <linux-fsdevel@vger.kernel.org>; Thu,  6 Feb 2025 10:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738839081; cv=none; b=O3hH1DJs5JC+En3CXnBHOA2v+Z+9nrhQlO3lFn91DOX8QjzkK+G+CgGdgr8tSGY8qefT9L4RSAV4rRR1jwl5IGNKPU4LCce2p27lX7oaqn79+dkujnFXL476pLDDo685Lm3zjLckhUA71cVBm7AN9uC9+LmdQLktjx4Q+Ft1euU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738839081; c=relaxed/simple;
	bh=P2pD0H+UuzpB9LIk9tsXrVUTH6ri0XNBtZXvmGZIWeI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bP5D01FpTOPoDBR6FHweiQVzrY1qhglWIPI3uULgIJYFQvTzOQ+vwxnXsqjCnjePELsO2ZRwPYc9eLNP02HDtasbxGUEyijeR2m6u30NHrtOvFZ/f5BDhDieEGNEYNKXha3Qlj0gtDqf6OMoPG2YGjAZP6VkClKjojdjuQSgMJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ftwqyJ2/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2271C4CEDD;
	Thu,  6 Feb 2025 10:51:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738839081;
	bh=P2pD0H+UuzpB9LIk9tsXrVUTH6ri0XNBtZXvmGZIWeI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ftwqyJ2/6V019NJIPf+/0MC9A1caJ8L75ZdNQziK/BzF5D8B0c41cLfOYX5yQMpLO
	 HiJ4iTegwhwW7uWG0l7jWbhUQ0fUuK9l5hTjQrWSpljfcUajZitXiuFWbkx29BIbbu
	 UkhDeJlneX6b057kmawjl/c2hwJLw6Qc8WmBrhPSbekBxFNHqXZqrcOtit+rM/IcKQ
	 RIHec42rC0wWxvg9pT1KiFA1MDdgsKWrdKJ5JjRZoIqMe+Y4N9VBN7QndsII2xDb4k
	 1WMquYLwWWNNeo7rYnIfU/KVeouJ/R3OzCZicBlVDi6HR4mTyFWBWdMfHiqpkSYWdC
	 bWfWo8535B4og==
Date: Thu, 6 Feb 2025 11:51:16 +0100
From: Christian Brauner <brauner@kernel.org>
To: Eric Sandeen <sandeen@redhat.com>
Cc: Kees Cook <kees@kernel.org>, linux-fsdevel@vger.kernel.org, 
	viro@zeniv.linux.org.uk, neilb@suse.de, ebiederm@xmission.com, tony.luck@intel.com
Subject: Re: [PATCH 1/4] pstore: convert to the new mount API
Message-ID: <20250206-gedreht-rhythmisch-cfdc5663787d@brauner>
References: <20250205213931.74614-1-sandeen@redhat.com>
 <20250205213931.74614-2-sandeen@redhat.com>
 <DD66BE90-95CD-4F75-AD47-50E869460482@kernel.org>
 <57a9557f-c895-466f-afaa-a40bf818e250@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <57a9557f-c895-466f-afaa-a40bf818e250@redhat.com>

On Wed, Feb 05, 2025 at 08:19:06PM -0600, Eric Sandeen wrote:
> On 2/5/25 8:04 PM, Kees Cook wrote:
> >> @@ -431,19 +434,33 @@ static int pstore_fill_super(struct super_block *sb, void *data, int silent)
> >> 		return -ENOMEM;
> >>
> >> 	scoped_guard(mutex, &pstore_sb_lock)
> >> -		pstore_sb = sb;
> >> +	pstore_sb = sb;
> > Shouldn't scoped_guard() induce a indent?
> 
> Whoops, not sure how that happened, sorry.
> 
> Fix on commit or send V2?

I fixed it.


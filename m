Return-Path: <linux-fsdevel+bounces-59128-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 63429B34AB6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Aug 2025 20:58:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D0B31A87FFD
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Aug 2025 18:58:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74066280A5A;
	Mon, 25 Aug 2025 18:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r3Zra8lO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C97B027F182;
	Mon, 25 Aug 2025 18:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756148263; cv=none; b=KfH9MKUbEu0owfY85m0/kQR3BIq8JmMMECnmOnLA5Wc3v0qAQNP2n2RHYITwykFZK68K3VWnyIwh4RS0SPn+jnpLJ/g/Nl6P+jbvjYAkMtfVcKDjr/M/YamJyRV0DCW62VSkE5DDGgVQxzMfgiu4jUz7E7TRthU3fbAouQP9Y0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756148263; c=relaxed/simple;
	bh=/mJuxFdTQE1L3kaxSOXwl3RZpWFZMZRe4dIbwAoXMw4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JVGSaT/HXn13LPuTjyZ0X4DeNOjoiHVfvtzLp44lShw3V7lIfrROWaM39Tq3c8NS1PYmbESMW45ISf5dpsIVkfBazbLOyodKEWPGJCfiX+UIt+hG/Y31cWudcbKhgG2rofvoOLDkJO5wVaxwFG3g4Hu5/ME1Pj5H+7j4mnERZXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r3Zra8lO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B45CC4CEED;
	Mon, 25 Aug 2025 18:57:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756148263;
	bh=/mJuxFdTQE1L3kaxSOXwl3RZpWFZMZRe4dIbwAoXMw4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=r3Zra8lOZKgIjBJAZ9oshWQ4h1NZkRdzLLTmgjirzNyb2s2rvUHH8ZsxXGOcxkmBg
	 l5OTGIYXD6RzAbEy3AUB4IdjFKwIY5JIVCY6ajUuTTNGlH7QXTlHSuDJDY7S+0Vxm8
	 xzLeHdw3+wVPDja1Hkr6nZsYUHXz9oHIxoJG9YXxc1LJtucNcgvJMqqZtReMFxMwMa
	 u77/7wFPGSsaGzw6Iz5vFe66d31IiwkuMfMjjINSauymNiypQ2QrJG2usbFwkOgOh+
	 8OzG8sn5q51Di3y8G7106ttIJIwLge+7AMSW90DgZZzTpY7SC1I961CacfxomhlRYE
	 9hUReuldZfkzg==
Date: Mon, 25 Aug 2025 08:57:41 -1000
From: Tejun Heo <tj@kernel.org>
To: Jan Kara <jack@suse.cz>
Cc: Julian Sun <sunjunchao@bytedance.com>, linux-fsdevel@vger.kernel.org,
	cgroups@vger.kernel.org, linux-mm@kvack.org,
	viro@zeniv.linux.org.uk, brauner@kernel.org, hannes@cmpxchg.org,
	mhocko@kernel.org, roman.gushchin@linux.dev, shakeel.butt@linux.dev,
	muchun.song@linux.dev, axboe@kernel.dk
Subject: Re: [External] Re: [PATCH] memcg: Don't wait writeback completion
 when release memcg.
Message-ID: <aKyyJZOwdJ6CNNjg@slm.duckdns.org>
References: <20250820111940.4105766-1-sunjunchao@bytedance.com>
 <20250820111940.4105766-4-sunjunchao@bytedance.com>
 <aKY2-sTc5qQmdea4@slm.duckdns.org>
 <CAHSKhtf--qn3TH3LFMrwqb-Nng2ABwV2gOX0PyAerd7h612X5Q@mail.gmail.com>
 <lvycz43vcro2cwjun4tswjv67tz5sg4tans3hragwils3gvnbh@hxbjk6x6v5zk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <lvycz43vcro2cwjun4tswjv67tz5sg4tans3hragwils3gvnbh@hxbjk6x6v5zk>

Hello,

On Mon, Aug 25, 2025 at 12:13:53PM +0200, Jan Kara wrote:
> True, but is that mechanism really needed? Given the approximate nature of
> foreign flushing, couldn't we just always replace the oldest foreign entry
> regardless of whether the writeback is running or not? I didn't give too
> deep thought to this but from a quick look this should work just fine...

Maybe, it's a bit difficult to predict. The thing was built to work around
real cases of problem and FWIW we haven't heard of similar issues
afterwards. Given the peculiarity and subtlety of the problem, I wonder
keeping the behavior unchanged, if reasonably possible, is an easier path to
follow here.

Thanks.

-- 
tejun


Return-Path: <linux-fsdevel+bounces-13726-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C0CF87320D
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Mar 2024 10:08:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 42B5B1F21080
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Mar 2024 09:08:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 243905F852;
	Wed,  6 Mar 2024 08:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tEP0kwFg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 805F35E3BA;
	Wed,  6 Mar 2024 08:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709715391; cv=none; b=cvpInHjiv4TbgmstJybwRwuf+SrFVF2LH5mM/rg/9ZkQldbBQlicuna6EX4kuOlYmKK6NmLUYEKpwidY8fXhsFDXutMVIRcx95ThPTTpH5YpFDf3w+pUmzzz6piQpY1Zcfzaev1qBYpdksOAuFb2hUe7hnVOx5k7LVjaXRI9QUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709715391; c=relaxed/simple;
	bh=YibjqG5I7aN25AkuN0pObg8REkaXhF2CKEKu/0j8bIQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PuNeacDGS6tREv+ClR9jXFlltLpli5LRhRBvOz4dM6aGCA11Ry1D01x9zdo61L1L9pmfqP2HPBtwpXVc8lY0olAXBcFeslpsgXdT/if7Pruzd/nY86/ZsPRtnyOavHwcxlmsBuTVbON2+6Ql2GLV1+i6aDvAo0sxnJBO4V4JJkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tEP0kwFg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 379F3C433B2;
	Wed,  6 Mar 2024 08:56:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709715391;
	bh=YibjqG5I7aN25AkuN0pObg8REkaXhF2CKEKu/0j8bIQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tEP0kwFguZgkAQpbRG0yAy53agHk5WUOm9xYyg2r01emvedl1Sb2mUZ8Mp1YU2yPc
	 CDhkAf23HlZRsjToGX9IJbQMNiT28osNxweszlJbmXkZcTxgrVoo4oop4mqQ1Wgieh
	 eEOG5J0kMF9IjH4bdo17D9XRjkbzKoL+0rZlUA4nhaNCHKuGoeR1mS6GqxsPi4fCFk
	 eZi8Qan69iVUgXimldBhmbDdyUPeefiG8uW4ngyh5bfCBxcw4wA3RKuZrujpIYQnYx
	 DXvQ1PsQ0D5Lqde5+i3/qWRN3UOppzeQv7C1ulvcCq4uC1gTZBpvbSz3bwUNGBYf9Z
	 4wPlT6lR7OvVg==
Date: Wed, 6 Mar 2024 09:56:25 +0100
From: Christian Brauner <brauner@kernel.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
	Tong Tiangen <tongtiangen@huawei.com>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	wangkefeng.wang@huawei.com, Guohanjun <guohanjun@huawei.com>, 
	David Howells <dhowells@redhat.com>, Al Viro <viro@kernel.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] coredump: get machine check errors early rather than
 during iov_iter
Message-ID: <20240306-karate-bekehren-164d0ab5c462@brauner>
References: <20240305133336.3804360-1-tongtiangen@huawei.com>
 <20240305-staatenlos-vergolden-5c67aef6e2bd@brauner>
 <db1a16d1-a4c2-4c47-9a84-65e174123078@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <db1a16d1-a4c2-4c47-9a84-65e174123078@kernel.dk>

> For what it's worth, checking the two patches, it's basically the one
> that Linus sent. I think it should have a From: based on that, and I

Yeah, fixed that.


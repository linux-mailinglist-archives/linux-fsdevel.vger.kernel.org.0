Return-Path: <linux-fsdevel+bounces-28502-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B79F796B5A4
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Sep 2024 10:58:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B8367B23821
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Sep 2024 08:55:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64D1719B3F6;
	Wed,  4 Sep 2024 08:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WRpNIT5n"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3B07192586
	for <linux-fsdevel@vger.kernel.org>; Wed,  4 Sep 2024 08:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725440133; cv=none; b=g4JNQ2x+ixPjVnJQ75xSBj7wMPEaxPys5cMNZLTHJrr6n1G70btpuYTRLHhcEGsd1fjX/ZUmrnQNXdmHyz9fws85MohtOmm/83wsqSoS1dNFWRKccVXYa7gORvHjFXrw6JrTLzvR1filtwm/HzjAHJKnhAHoh7OsVkNQj9Q36Rw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725440133; c=relaxed/simple;
	bh=/OltdKGXS9WRNRb4vVWJPOQtjSxmm1hW+BFD9TNqPCo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H6nNsuywL+TnsvMijYslG7dkJsU31jn8Gy7WvITE/gCDFqlUXmuafCUWC9Ozq9KsP0LVZDVXUSXnF5MDZyQVIG6igUVo7Ap2Cc8GrkBVCvrwOLLIwni3WgK9oF7PF2vu/36853eAJqJ3uge9LOneWpYknR/HW84KBAiMXTxssVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WRpNIT5n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71A29C4CEC9;
	Wed,  4 Sep 2024 08:55:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725440133;
	bh=/OltdKGXS9WRNRb4vVWJPOQtjSxmm1hW+BFD9TNqPCo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WRpNIT5nKAw+zp/G1HeAm9OK/H545viWDzIzwpclPxHYeSskfGqNjtAwUYxBF52Jk
	 al0jbfwAgKDlCuJWIrcR39Knja6RK4yxNpaoOyRlVyG+gyrVZjVBu/mDOuAUR/4SXM
	 AaKAEvR50AEX/7jGaF/GykRLT/7pG+d8Zkdy3PgOWSaSwp8BOVVavPe8kdZsHhlNdc
	 aZqR8njKavuigzshS7IRipBHWobDR4d8K7Pelg67BlKeJz/fdsujjQlMZYz1o2yMRd
	 KfUGEXqeHxSMCAuQ94d2FgHQs9aBil8Wr844DBEYtRkOS6mLvWs1fnIHBzPQsoKNFv
	 9yiQ6xC3SW58g==
Date: Wed, 4 Sep 2024 10:55:28 +0200
From: Christian Brauner <brauner@kernel.org>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Jens Axboe <axboe@kernel.dk>, Jann Horn <jannh@google.com>, 
	Linus Torvalds <torvalds@linux-foundation.org>, Mike Rapoport <rppt@kernel.org>, linux-mm@kvack.org, 
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 14/15] slab: remove kmem_cache_create_rcu()
Message-ID: <20240904-teebeutel-pythonschlange-f14cc2ef004b@brauner>
References: <20240903-work-kmem_cache_args-v2-0-76f97e9a4560@kernel.org>
 <20240903-work-kmem_cache_args-v2-14-76f97e9a4560@kernel.org>
 <f0000af0-99aa-4b10-8d56-da1cc13c445c@suse.cz>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f0000af0-99aa-4b10-8d56-da1cc13c445c@suse.cz>

On Wed, Sep 04, 2024 at 10:18:39AM GMT, Vlastimil Babka wrote:
> On 9/3/24 16:20, Christian Brauner wrote:
> > Since we have kmem_cache_setup() and have ported kmem_cache_create_rcu()
> 
> Nit: it's now kmem_cache_create() variant with kmem_cacheargs, not
> kmem_cache_setup()

Thanks. I've changed that to:

"Now that we have ported all users of kmem_cache_create_rcu() to struct
kmem_cache_args the function is unused and can be removed."

on the work.kmem_cache_args branch.


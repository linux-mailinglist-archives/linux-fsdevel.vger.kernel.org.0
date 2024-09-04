Return-Path: <linux-fsdevel+bounces-28504-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 042CE96B5AC
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Sep 2024 10:59:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 379B81C20A41
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Sep 2024 08:59:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5D32198E7F;
	Wed,  4 Sep 2024 08:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dzA+w/9S"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50DAABA27
	for <linux-fsdevel@vger.kernel.org>; Wed,  4 Sep 2024 08:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725440384; cv=none; b=XSglGzBR252hzOlRPQAWf9mBeIMuAMuFs74oit6Kt7ZPUPzfOnEQs1rM3HwXSdT8BgLKmJNaDNuth6KE08u+7TJFUaqkt5dyvhdtv+60dif0fW7hhCk2Q0TZF7NCVdIUvXrjrDoKW/o2DM0YQ9YFfOK5+01pYJIXq2/wFx3E038=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725440384; c=relaxed/simple;
	bh=JG2C8PCn2ZCFQ9y3w8TIcFxPHogTETPZAyI+23L3I8o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pZ96Y/9+KaCPjrRF8Ig73rpTtuRRgblkYih48jUu62ALjOBfPejH4sA3GjNvPvSDHhJEqI8HO1xFnVwddtekZGk0FSGoERMBPcu9qZtR7zMzZCxOvyW7HQ7HvUjmtz3qf756/Dfv2FWGe4YMpNjbQn874tH4ZSCfN+BLOaF1I5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dzA+w/9S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0892DC4CEC2;
	Wed,  4 Sep 2024 08:59:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725440383;
	bh=JG2C8PCn2ZCFQ9y3w8TIcFxPHogTETPZAyI+23L3I8o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dzA+w/9SlfcfKTct0Qs+OAz/0fbxblVqseqAi0ihPEXv2oy+LC88uXTop+Z+/6iMi
	 Z0qRKoYq5eawy8q5sq2Y/Ucqny/t0/nPicmvSZD1hyjuJlMlDdZemDn+AUz0oaVKQA
	 LgNY14sXSpnN5go6X4eN0AKuI05AJN6jqp24DdaGsgE8D8Kyp1mIaTbKw9tLcx2H2O
	 UDqQtgwh4AAK3xALkw9RIdhzhz9XLGsPouP4uIj4TCeN3jvJSnHoPqmnvpjQNwkTFM
	 ybeOKBLViy+wzWdun2vKBNgKKa5QOHdiE3CKzZH01+RyCMXEDGWZUbEy3aORbzE84N
	 tdY42b6or37dw==
Date: Wed, 4 Sep 2024 10:59:38 +0200
From: Christian Brauner <brauner@kernel.org>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Jens Axboe <axboe@kernel.dk>, Jann Horn <jannh@google.com>, 
	Linus Torvalds <torvalds@linux-foundation.org>, Mike Rapoport <rppt@kernel.org>, linux-mm@kvack.org, 
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 05/15] slab: port kmem_cache_create_usercopy() to
 struct kmem_cache_args
Message-ID: <20240904-augen-befallen-f759c30c7b07@brauner>
References: <20240903-work-kmem_cache_args-v2-0-76f97e9a4560@kernel.org>
 <20240903-work-kmem_cache_args-v2-5-76f97e9a4560@kernel.org>
 <44c51c2b-957c-4bb6-bade-fb202dbd07ce@suse.cz>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <44c51c2b-957c-4bb6-bade-fb202dbd07ce@suse.cz>

On Wed, Sep 04, 2024 at 10:14:37AM GMT, Vlastimil Babka wrote:
> On 9/3/24 16:20, Christian Brauner wrote:
> > Pprt kmem_cache_create_usercopy() to struct kmem_cache_args and remove
> 
> Typo

Fixed on the work.kmem_cache_args branch.


Return-Path: <linux-fsdevel+bounces-28590-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F414996C41D
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Sep 2024 18:27:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B96EA28863E
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Sep 2024 16:27:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8E751E0B66;
	Wed,  4 Sep 2024 16:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Fgd9jWhK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95A631DFE3F
	for <linux-fsdevel@vger.kernel.org>; Wed,  4 Sep 2024 16:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725467233; cv=none; b=Z9vS4KshawaxSKCGo+cqlndZMoTLaPkGzdxAi9/6rRX3JE4wF4+LidtH/xDqoi24p6MYQkjfF2VzslGGXSeRDwtDAKHqtPVa5mF/u7PoS7yPvInsoi3GTYPi7CCyVHAcLIDgqJm/Sqnkpxc3xFgShGk6cLcuGWfCod+x5MLs/O8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725467233; c=relaxed/simple;
	bh=8CM+ER6jT6WN3Myh785kYSCtSEAyLTkTXwTJgmUn8VU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b/7xPjleq9u05YY2Jc8OBrBnMoLPZ45s3tIi4JBAOIp/Pru8bfOYG5Do2ooNqc72JNlhy0pSiyfBA/bJ9odCwDziYtCdWutI1Oyj0R9yCgHM1vIatTNNILrfeJ/P20NBVdOxu6DnK3dYH9ksHVqxyCACPoeS5WdPY22OLRXSI6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Fgd9jWhK; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 4 Sep 2024 12:27:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1725467228;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Uf/mkXIK3Bv8nG/HByUgMnT8fjINIkgAQjXvtIV+Ba8=;
	b=Fgd9jWhKnrgYi5m4PD5uSb1Hk/QHINynu/oAUGS724gNEz/iK7YYQvO1SK2E2FrelY3N3F
	/090wgIgZCkYoLOcmLzFv/xcIn+Dw5R/xKaBG29E2IBvh4ctTGbQevntMxta+qk+gDfSLQ
	7FnVruthDocgRD9Ac8uByWEoyKyUhiw=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Christoph Hellwig <hch@lst.de>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Michal Hocko <mhocko@kernel.org>, Yafang Shao <laoar.shao@gmail.com>, jack@suse.cz, 
	Vlastimil Babka <vbabka@suse.cz>, Dave Chinner <dchinner@redhat.com>, 
	Christian Brauner <brauner@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-bcachefs@vger.kernel.org, linux-security-module@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2 v2] remove PF_MEMALLOC_NORECLAIM
Message-ID: <l3dngdjyglhpnlcmjxerpmiyw4euodb6sxsxe3mwtyd2z3uopu@amisj3chjfqe>
References: <20240902095203.1559361-1-mhocko@kernel.org>
 <ggrt5bn2lvxnnebqtzivmge3yjh3dnepqopznmjmkrcllb3b35@4vnnapwr36ur>
 <20240902145252.1d2590dbed417d223b896a00@linux-foundation.org>
 <20240903051342.GA31046@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240903051342.GA31046@lst.de>
X-Migadu-Flow: FLOW_OUT

On Tue, Sep 03, 2024 at 07:13:42AM GMT, Christoph Hellwig wrote:
> On Mon, Sep 02, 2024 at 02:52:52PM -0700, Andrew Morton wrote:
> > It would be helpful to summarize your concerns.
> 
> And that'd better be a really good argument for a change that was
> pushed directly to Linus bypassing the maintainer after multiple
> reviewers pointed out it was broken.  This series simply undoes the
> damage done by that, while also keeping the code dependend on it
> working.

Well, to be blunt, I thought the "we don't want the allocator to even
know if we're in a non-sleepable context" argument was too crazy to have
real support, and moving towards PF_MEMALLOC flags is something we've
been talking about quite a bit going back years.

Little did I know the minefield I was walking into...

But the disccussion seems to finally be cooling off and going in a more
productive direction.


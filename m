Return-Path: <linux-fsdevel+bounces-35380-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DE0149D46FB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Nov 2024 05:53:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 916D21F22553
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Nov 2024 04:53:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19CED149011;
	Thu, 21 Nov 2024 04:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ub7OH5ZF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D3DF230986
	for <linux-fsdevel@vger.kernel.org>; Thu, 21 Nov 2024 04:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732164816; cv=none; b=LQTf9frCpI3OT75Z/oZpZ0FJ7ztxV+s8dK1xLTKpyb573TIAKRaOSdD6rzjg/wOCHrCR2H02mAe6XBKK2RbPByYpZrpWZ5nNLpVx6ZqhI4XOHpT5vlRL9yyUiMCDW1zWTYmnBVzxex2f3t4UxS4llnLzs+zjHonp4BmFNH4qTd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732164816; c=relaxed/simple;
	bh=Ij0HDsfLaBRrZfAtCTu8XbYtmIPNsEOALdn60KpGHsc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a0Z/kkpH0eCJNJnbAqk5CsA0tlu+xCOHY8OIxTY3bplfz+zlbiiCJU6PlnCzEprrQDI+2I08SBF9pQzR/oFZrMiaaV70lJRMA4UPOgWiqmVNwuDXH9FKBVpB1LI0h1m/YnQgunhCHryKHL3vltup3Bh+6BHfoc2aRnz4gteuvMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ub7OH5ZF; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 20 Nov 2024 23:53:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1732164810;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ENB2kor/jdS78IhNaupupsMY4qX+PiyIEzt301nX8dw=;
	b=ub7OH5ZFxuMTogSswMhL6laP6FmQ+LpfRgOWFiPWmxY2qlPEKOD7uorveRva0zo/xwBdSE
	gH+QltkL48B32CHyOwZgPSK2ll1/NgflmB16iYHWh+l8EPzYYAPOFztgHWLAPnGLfgA6ve
	tVI43Oz1XoumG7YqcMlD25QAXKJCcos=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Christoph Hellwig <hch@lst.de>
Cc: Theodore Ts'o <tytso@mit.edu>, Shuah Khan <skhan@linuxfoundation.org>, 
	Michal Hocko <mhocko@suse.com>, Dave Chinner <david@fromorbit.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Yafang Shao <laoar.shao@gmail.com>, jack@suse.cz, 
	Christian Brauner <brauner@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-bcachefs@vger.kernel.org, linux-security-module@vger.kernel.org, 
	linux-kernel@vger.kernel.org, "conduct@kernel.org" <conduct@kernel.org>
Subject: Re: [PATCH 1/2 v2] bcachefs: do not use PF_MEMALLOC_NORECLAIM
Message-ID: <thwbzrybt6kk3x6o5ege3h7k6vsip4j6mllxdvn6poldvdczz6@zobwlfwgxhkt>
References: <22a3da3d-6bca-48c6-a36f-382feb999374@linuxfoundation.org>
 <vvulqfvftctokjzy3ookgmx2ja73uuekvby3xcc2quvptudw7e@7qj4gyaw2zfo>
 <71b51954-15ba-4e73-baea-584463d43a5c@linuxfoundation.org>
 <cl6nyxgqccx7xfmrohy56h3k5gnvtdin5azgscrsclkp6c3ko7@hg6wt2zdqkd3>
 <9efc2edf-c6d6-494d-b1bf-64883298150a@linuxfoundation.org>
 <be7f4c32-413e-4154-abe3-8b87047b5faa@linuxfoundation.org>
 <nu6cezr5ilc6vm65l33hrsz5tyjg5yu6n22tteqvx6fewjxqgq@biklf3aqlook>
 <v2ur4jcqvjc4cqdbllij5gh6inlsxp3vmyswyhhjiv6m6nerxq@mrekyulqghv2>
 <20241120234759.GA3707860@mit.edu>
 <20241121042558.GA20176@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241121042558.GA20176@lst.de>
X-Migadu-Flow: FLOW_OUT

On Thu, Nov 21, 2024 at 05:25:58AM +0100, Christoph Hellwig wrote:
> On Wed, Nov 20, 2024 at 03:47:59PM -0800, Theodore Ts'o wrote:
> > On Wed, Nov 20, 2024 at 05:55:03PM -0500, Kent Overstreet wrote:
> > > Shuah, would you be willing to entertain the notion of modifying your...
> > 
> > Kent, I'd like to gently remind you that Shuah is not speaking in her
> > personal capacity, but as a representative of the Code of Conduct
> > Committee[1], as she has noted in her signature.  The Code of Conduct
> > Committee is appointed by, and reports to, the TAB[2], which is an
> > elected body composed of kernel developers and maintainers.
> 
> FYI, without taking any stance on the issue under debate here, I find the
> language used by Shuah on behalf of the Code of Conduct committee
> extremely patronising and passive aggressive.  This might be because I
> do not have an American academic class background, but I would suggest
> that the code of conduct committee should educate itself about
> communicating without projecting this implicit cultural and class bias
> so blatantly.

I wasn't even thinking about the language issue, but I think that's a
very good point.

We have a very strong culture of personal responsibility and taking
responsibility for our work here, and I think that's one of the main
thing that enables us to function and work together even when we're
constantly butting heads.

Broadly speaking, what that means to me is: I will justify, explain and
give the reasoning for my actions if asked, and if I can't because I
made a mistake, then I will make it right or at least acknowledge my
mistake.

So, the very passive language from Shuah (i.e. "I'm not the one 'doing'
this, I'm just implementing the policy that we all decided on, even
though I totally wrote and advocated for that policy") does seem
problematic to me as well.


Return-Path: <linux-fsdevel+bounces-35570-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B4EA9D5E8F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Nov 2024 13:06:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D84721F21092
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Nov 2024 12:06:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84A991DE3D6;
	Fri, 22 Nov 2024 12:06:43 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C02A44500E;
	Fri, 22 Nov 2024 12:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732277203; cv=none; b=mLzWkMmQW4BffRNAvfpsDgBAjpPfpBANx2BORS7eqXPCaB+7EhPyABzgbzZ7gDVHDaUBLOLg6X5BFNqeLz7m1l5s9VXkO3yGApon/XHBwRgwCfTFxhanHHTgvani96T+JNfmY+WiIaDIXrckkZ8/jznymNKYcTVoEn1SjnwO+cA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732277203; c=relaxed/simple;
	bh=BYqXJlZACzd2/GK3N7rCy85f9v4k+hok/4yv8tI6Is8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nTNkf+5xt0Iu634VaZHji99gu16aUzMuuhx+khRsCxARYTnbIDmrVuRYRKIvWfFC/R1x7rxadpl7LfcM1oOZYCVsUnQ1XDYdXnNcnMpmUwUu8exwLhjZu+1tee382PxUoE6BZ6wsa5DOJmAfF7dirikQIpQ3EtKU2HSTfROQZXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 2EF7368C4E; Fri, 22 Nov 2024 13:06:36 +0100 (CET)
Date: Fri, 22 Nov 2024 13:06:36 +0100
From: Christoph Hellwig <hch@lst.de>
To: Shuah Khan <skhan@linuxfoundation.org>
Cc: Christoph Hellwig <hch@lst.de>, Theodore Ts'o <tytso@mit.edu>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	Michal Hocko <mhocko@suse.com>, Dave Chinner <david@fromorbit.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Yafang Shao <laoar.shao@gmail.com>, jack@suse.cz,
	Christian Brauner <brauner@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>, linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org, linux-bcachefs@vger.kernel.org,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
	"conduct@kernel.org" <conduct@kernel.org>
Subject: Re: [PATCH 1/2 v2] bcachefs: do not use PF_MEMALLOC_NORECLAIM
Message-ID: <20241122120635.GA25707@lst.de>
References: <vvulqfvftctokjzy3ookgmx2ja73uuekvby3xcc2quvptudw7e@7qj4gyaw2zfo> <71b51954-15ba-4e73-baea-584463d43a5c@linuxfoundation.org> <cl6nyxgqccx7xfmrohy56h3k5gnvtdin5azgscrsclkp6c3ko7@hg6wt2zdqkd3> <9efc2edf-c6d6-494d-b1bf-64883298150a@linuxfoundation.org> <be7f4c32-413e-4154-abe3-8b87047b5faa@linuxfoundation.org> <nu6cezr5ilc6vm65l33hrsz5tyjg5yu6n22tteqvx6fewjxqgq@biklf3aqlook> <v2ur4jcqvjc4cqdbllij5gh6inlsxp3vmyswyhhjiv6m6nerxq@mrekyulqghv2> <20241120234759.GA3707860@mit.edu> <20241121042558.GA20176@lst.de> <39e8f416-d136-4307-989a-361bf729e688@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <39e8f416-d136-4307-989a-361bf729e688@linuxfoundation.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Thu, Nov 21, 2024 at 04:53:48PM -0700, Shuah Khan wrote:
> I tend to use formal style when I speak on behalf of the Code of Conduct
> committee. I would label it as very formal bordering on pedantic.
>  Would you prefer less formal style in the CoC communication?

I would prefer a less passive agressive and more to the point one.



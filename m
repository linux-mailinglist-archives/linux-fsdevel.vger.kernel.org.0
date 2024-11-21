Return-Path: <linux-fsdevel+bounces-35377-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AC1879D46AA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Nov 2024 05:26:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2BCFDB237BF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Nov 2024 04:26:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D0911BBBDA;
	Thu, 21 Nov 2024 04:26:13 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0453161FCE;
	Thu, 21 Nov 2024 04:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732163173; cv=none; b=XUIYppN0zeUEE4QUC1MPIkgtusGV5P30b1XMXutdhGmOv3Uasn6NoAXwrSD14009ftraQ25m+Oj5FSE8J9m594/EfvaO5pnP4+2TY73tPcSIe+fzj3hVAWF7U4dToCPH9+Gax2/IHPIRw38T3l4VOAiJt7AoemgNPP08QPiS5P8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732163173; c=relaxed/simple;
	bh=+1MV8Cjak5TWRWIylPpVXkrM1YeOQvakuMeaa1f3wps=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e10w5JxY/lr/ZdP+Ws659nzYXT7Z0ohQKkdQ5xO63deVxulYDZPYW3ns+XzQvwBlbO51E4iEzGjE7bv3TwDo6JT03DI2tAp+Q4U0lwjxW3yUj0INNvp6vS57TABb0OPZ+0IF5AHfd6lk4/bQ6MwLrmkbnlS2kEzhXa7GCORGrgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 8235368BEB; Thu, 21 Nov 2024 05:25:58 +0100 (CET)
Date: Thu, 21 Nov 2024 05:25:58 +0100
From: Christoph Hellwig <hch@lst.de>
To: Theodore Ts'o <tytso@mit.edu>
Cc: Kent Overstreet <kent.overstreet@linux.dev>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Michal Hocko <mhocko@suse.com>, Dave Chinner <david@fromorbit.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Christoph Hellwig <hch@lst.de>, Yafang Shao <laoar.shao@gmail.com>,
	jack@suse.cz, Christian Brauner <brauner@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>, linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org, linux-bcachefs@vger.kernel.org,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
	"conduct@kernel.org" <conduct@kernel.org>
Subject: Re: [PATCH 1/2 v2] bcachefs: do not use PF_MEMALLOC_NORECLAIM
Message-ID: <20241121042558.GA20176@lst.de>
References: <citv2v6f33hoidq75xd2spaqxf7nl5wbmmzma4wgmrwpoqidhj@k453tmq7vdrk> <22a3da3d-6bca-48c6-a36f-382feb999374@linuxfoundation.org> <vvulqfvftctokjzy3ookgmx2ja73uuekvby3xcc2quvptudw7e@7qj4gyaw2zfo> <71b51954-15ba-4e73-baea-584463d43a5c@linuxfoundation.org> <cl6nyxgqccx7xfmrohy56h3k5gnvtdin5azgscrsclkp6c3ko7@hg6wt2zdqkd3> <9efc2edf-c6d6-494d-b1bf-64883298150a@linuxfoundation.org> <be7f4c32-413e-4154-abe3-8b87047b5faa@linuxfoundation.org> <nu6cezr5ilc6vm65l33hrsz5tyjg5yu6n22tteqvx6fewjxqgq@biklf3aqlook> <v2ur4jcqvjc4cqdbllij5gh6inlsxp3vmyswyhhjiv6m6nerxq@mrekyulqghv2> <20241120234759.GA3707860@mit.edu>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241120234759.GA3707860@mit.edu>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Wed, Nov 20, 2024 at 03:47:59PM -0800, Theodore Ts'o wrote:
> On Wed, Nov 20, 2024 at 05:55:03PM -0500, Kent Overstreet wrote:
> > Shuah, would you be willing to entertain the notion of modifying your...
> 
> Kent, I'd like to gently remind you that Shuah is not speaking in her
> personal capacity, but as a representative of the Code of Conduct
> Committee[1], as she has noted in her signature.  The Code of Conduct
> Committee is appointed by, and reports to, the TAB[2], which is an
> elected body composed of kernel developers and maintainers.

FYI, without taking any stance on the issue under debate here, I find the
language used by Shuah on behalf of the Code of Conduct committee
extremely patronising and passive aggressive.  This might be because I
do not have an American academic class background, but I would suggest
that the code of conduct committee should educate itself about
communicating without projecting this implicit cultural and class bias
so blatantly.


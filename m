Return-Path: <linux-fsdevel+bounces-35371-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AAAC9D44B9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Nov 2024 00:58:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2394F1F2262A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Nov 2024 23:58:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ABDA1E4A4;
	Wed, 20 Nov 2024 23:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="HsjSXGJD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F23A1B5808
	for <linux-fsdevel@vger.kernel.org>; Wed, 20 Nov 2024 23:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732147072; cv=none; b=gZ0B5lNKGQa8I95ob2tSvV+hevbfe0hHdLHW/YHSZQ9LAKOulLECopNU68jdMs2lM1jbDw+vv4BSPM+txVVuR6OIl44UQKDDRSDDxIAa5a2BkCQ7iKjOhg6IRdpSurC3oLcpGtBljHH1O8LoaLF6m8PEX8aI1mjYKbdKW1hb60c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732147072; c=relaxed/simple;
	bh=xAJiMOy/tYwJ2SRHkwirLqKL/+U2qvyXPidllX/e5sc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KQhxdUOqQnuqybcbkD1QhWUEqp5ALkZK7N6+Xf2LYYvduygkWKP+hS5zZX5gQNjj5Qi6d3G9L7B7wvXcBwxePJUq1F48aciKLo1DAuuzLPkDAQYoz0CjzzJtpLwocHzpfyNT5SCCy4ww6uYeYl2vqayctaYULnKn6cYGzfegQGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=HsjSXGJD; arc=none smtp.client-ip=95.215.58.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 20 Nov 2024 18:57:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1732147068;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+/zQUiFZa2/Psd9mNiVAyI7r4UoULDnI3eDp0bLin/I=;
	b=HsjSXGJDjkCq50YVDxBlWSy0liTPKmzIp6QG5Y5lBGoOO9V+h6rlIpkJxkiUoj1fMTvFtK
	nvF60ap2G/fxq3GGqJpKsTYhamASQs+oSgMFxdHybVda6EIoCCckaq/0C7a+SN/i30ME4y
	/bagUqINsDLLpFJJmeFqNgohtnLNiU4=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Theodore Ts'o <tytso@mit.edu>
Cc: Shuah Khan <skhan@linuxfoundation.org>, Michal Hocko <mhocko@suse.com>, 
	Dave Chinner <david@fromorbit.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Christoph Hellwig <hch@lst.de>, Yafang Shao <laoar.shao@gmail.com>, jack@suse.cz, 
	Christian Brauner <brauner@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-bcachefs@vger.kernel.org, linux-security-module@vger.kernel.org, 
	linux-kernel@vger.kernel.org, "conduct@kernel.org" <conduct@kernel.org>
Subject: Re: [PATCH 1/2 v2] bcachefs: do not use PF_MEMALLOC_NORECLAIM
Message-ID: <gdorei5imv4qs476pcshmmw7ty7zyhqkb2hvda3ucihxqwlgwl@brnwkt4e7ili>
References: <citv2v6f33hoidq75xd2spaqxf7nl5wbmmzma4wgmrwpoqidhj@k453tmq7vdrk>
 <22a3da3d-6bca-48c6-a36f-382feb999374@linuxfoundation.org>
 <vvulqfvftctokjzy3ookgmx2ja73uuekvby3xcc2quvptudw7e@7qj4gyaw2zfo>
 <71b51954-15ba-4e73-baea-584463d43a5c@linuxfoundation.org>
 <cl6nyxgqccx7xfmrohy56h3k5gnvtdin5azgscrsclkp6c3ko7@hg6wt2zdqkd3>
 <9efc2edf-c6d6-494d-b1bf-64883298150a@linuxfoundation.org>
 <be7f4c32-413e-4154-abe3-8b87047b5faa@linuxfoundation.org>
 <nu6cezr5ilc6vm65l33hrsz5tyjg5yu6n22tteqvx6fewjxqgq@biklf3aqlook>
 <v2ur4jcqvjc4cqdbllij5gh6inlsxp3vmyswyhhjiv6m6nerxq@mrekyulqghv2>
 <20241120234759.GA3707860@mit.edu>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241120234759.GA3707860@mit.edu>
X-Migadu-Flow: FLOW_OUT

On Wed, Nov 20, 2024 at 03:47:59PM -0800, Theodore Ts'o wrote:
> On Wed, Nov 20, 2024 at 05:55:03PM -0500, Kent Overstreet wrote:
> > Shuah, would you be willing to entertain the notion of modifying your...
> 
> Kent, I'd like to gently remind you that Shuah is not speaking in her
> personal capacity, but as a representative of the Code of Conduct
> Committee[1], as she has noted in her signature.  The Code of Conduct
> Committee is appointed by, and reports to, the TAB[2], which is an
> elected body composed of kernel developers and maintainers.
> 
> [1] https://www.kernel.org/code-of-conduct.html
> [2] https://www.kernel.org/doc/html/latest/process/code-of-conduct-interpretation.html
> 
> Speaking purely in a personal capacity, and not as a member of the TAB
> (although I do serve as vice-chair of that body) I am extremely
> grateful of the work of Shuah and her colleages (listed in [1]).  I
> believe that their work is important in terms of establishing guard
> rails regarding the minimum standards of behavior in our community.
> 
> If you look at the git history of the kernel sources, you will see
> that a large number of your fellow maintainers assented to this
> approach --- for example by providing their Acked-by in commit
> 1279dbeed36f ("Code of Conduct Interpretation: Add document explaining
> how the Code of Conduct is to be interpreted").

Authored by Shuah, so I do seem to be talking to the correct person.

Regardless, we talked privately about opening some sort of public
discussion, this is pursuant to that.


Return-Path: <linux-fsdevel+bounces-10664-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8857084D2C6
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Feb 2024 21:18:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4395D284684
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Feb 2024 20:18:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54A8A1272D7;
	Wed,  7 Feb 2024 20:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NEFuw/ej"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C6F0126F37;
	Wed,  7 Feb 2024 20:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707337126; cv=none; b=Cx/COZtc7Y6hH5hInCguPVyjAI9OYB3o4Z7pfO+6JOvu7PN5uofOwmsEDkD41b7XeAu3ZcPmJIOwa9cqI62Jr2+x7EVzhHIKy2qH2goUCwsi9a1hzRtfYb9YDaRpqsVrGsuvF0vTcEQsDwVxjQCQNPh2LBeQqBLz8yH1nTBE688=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707337126; c=relaxed/simple;
	bh=3DBdSkr1+oN510ucK4APN7lecmvtDgNwN2r/J31Mba0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=B4NzmW+shwoHcNQHfbUfj/dVrWujbzCgpJNgFA3niE829LC/1xb0ilIPDbs3oDYUl+JvP1Q4TO2L2gkU4h7JOkgNmB8ZmJqiu6HjaCDuh15RNrff/NAERV+eQk9YmN/UA05zdHhw6B+jP7VwN5co5sHAqV6zkv9a5RHWtB+itRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NEFuw/ej; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E61FC433C7;
	Wed,  7 Feb 2024 20:18:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707337126;
	bh=3DBdSkr1+oN510ucK4APN7lecmvtDgNwN2r/J31Mba0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=NEFuw/ejNPdZC/T+TmKCAo/eVBLcHKGs+gAzsnAOT1Z3Pk1+kHIFk5qOiqT+x7LvO
	 ibzQMw15E9lNzOdHZIEI3EVuyp22O8Xfo21T64QhQazWamkzSRHbWdBgaJqbZsp6EL
	 IbsZxi1ThJgF17+yE0hpL2iruWh2V3Sw0gsHiOPH+DzEo6MjJ04Fml8EqKOGrE6Pio
	 2c9Okoqr3741mPdoHwQJEVFO7x+lFuBqWjEWOqv8AUFxPCV7vQYQ8+Mk6y/shdNKAk
	 ZvunoN+G00tuZe1DW516zTmTO5VRY3h5nkUQ8KkNA7C/svrr/+jSYU69TvIARo6ljn
	 aXXMdSQxTjIrg==
Date: Wed, 7 Feb 2024 12:18:44 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Joe Damato <jdamato@fastly.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 chuck.lever@oracle.com, jlayton@kernel.org, linux-api@vger.kernel.org,
 brauner@kernel.org, edumazet@google.com, davem@davemloft.net,
 alexander.duyck@gmail.com, sridhar.samudrala@intel.com,
 willemdebruijn.kernel@gmail.com, weiwan@google.com,
 David.Laight@ACULAB.COM, arnd@arndb.de, sdf@google.com,
 amritha.nambiar@intel.com, Jonathan Corbet <corbet@lwn.net>, Alexander Viro
 <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, Nathan Lynch
 <nathanl@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, Namjae Jeon
 <linkinjeon@kernel.org>, Steve French <stfrench@microsoft.com>, Thomas
 Zimmermann <tzimmermann@suse.de>, Julien Panis <jpanis@baylibre.com>,
 Andrew Waterman <waterman@eecs.berkeley.edu>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, "open
 list:DOCUMENTATION" <linux-doc@vger.kernel.org>, "open list:FILESYSTEMS
 (VFS and infrastructure)" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH net-next v6 4/4] eventpoll: Add epoll ioctl for
 epoll_params
Message-ID: <20240207121844.6bf34083@kernel.org>
In-Reply-To: <20240207191603.GB1313@fastly.com>
References: <20240205210453.11301-1-jdamato@fastly.com>
	<20240205210453.11301-5-jdamato@fastly.com>
	<ec9791cf-d0a2-4d75-a7d6-00bcab92e823@kernel.org>
	<20240207185014.GA1221@fastly.com>
	<20240207110726.68c07188@kernel.org>
	<20240207191603.GB1313@fastly.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 7 Feb 2024 11:16:03 -0800 Joe Damato wrote:
> > > netdev maintainers: Jiri marked this with Reviewed-by, but was this review
> > > what caused "Changes Requested" to be the status set for this patch set in
> > > patchwork?
> > > 
> > > If needed, I'll send a v7 with the changes Jiri suggested and add the
> > > "Reviewed-by" since the changes are cosmetic, but I wanted to make sure
> > > this was the reason.  
> > 
> > Yes, I think that's it.  
> 
> OK, thanks for letting me know. I wasn't sure if it was because of the
> netdev/source_inline which marked 1/4 as "fail" because of the inlines
> added.
> 
> Does that need to be changed, as well?

For background our preference is to avoid using static inline in C
sources, unless the author compiled the code and actually confirmed
the code doesn't get inlined correctly. But it's not a hard
requirement, and technically the code is under fs/.

In general the patchwork checks are a bit noisy, see here the top left
graph of how many of the patches we merge are "all green":
https://netdev.bots.linux.dev/checks.html
Some of the checks are also largely outside of our control (checkpatch)
so consider the patchwork checks as automation for maintainers. 
The maintainers should respond on the list if any of the failures 
are indeed legit. 


Return-Path: <linux-fsdevel+bounces-24175-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 374FA93AC23
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jul 2024 07:04:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 692741C22C5F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jul 2024 05:04:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEE9945C0B;
	Wed, 24 Jul 2024 05:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="yaWQMapi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01F142572;
	Wed, 24 Jul 2024 05:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721797441; cv=none; b=pncRMFiMe2EC0bwqDzGmNH9hdzv1HmmJBCz+jCBZ9UR1djR0IbA5EH3BIiJTGHLbPssih4ovJ487CeLzGWMRrE5LhLd3JW5lvmdIPGy/X2mln+T9OZ6djOszFOdZXtRdOGf4CrnSzyEj+AIwRZb3rcoBvFA4HT4ejxRcPNBizBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721797441; c=relaxed/simple;
	bh=tarG3fO9F6MF8bV9XdA6weIpvTjg9vWcL+LPZUa5yhU=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=I+CHE1GARfn6VIt2MTboUZA4RYr8EWfopjCw/47gEuTN2/3kHy7X6mkodxqrqjLM9+TVUe/3hP/rLWgvnmsmiy8VJbdfvIZpdruoygWG27tOB9S4xdilpCpDbHInI7L+giIDCUOiPTKLXyPVQeCbqO0Ta9dS+nNVEr8HtpVT5Js=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=yaWQMapi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D8E4C32782;
	Wed, 24 Jul 2024 05:04:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1721797440;
	bh=tarG3fO9F6MF8bV9XdA6weIpvTjg9vWcL+LPZUa5yhU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=yaWQMapiYejqz+M0Dy0tkygjaGej3J2SleHLgQl8OUVnUaDuzc3ZOcaMlkaPpYobt
	 h6H4LNo4OLXcsIV5meyREZ8yF5Sj0wMMjtfzJIruT4JYUzNFN9m1BYto2ZdnZMjuVF
	 TMMrjmKZoIyzlfJo4Q07a9gTnZLILaCOTnK9+ez0=
Date: Tue, 23 Jul 2024 22:03:59 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Julian Sun <sunjunchao2870@gmail.com>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, jack@suse.cz, brauner@kernel.org,
 viro@zeniv.linux.org.uk, masahiroy@kernel.org, n.schier@avm.de,
 ojeda@kernel.org, djwong@kernel.org, kvalo@kernel.org
Subject: Re: [PATCH] scripts: add macro_checker script to check unused
 parameters in macros
Message-Id: <20240723220359.e96522515469210f5a420aab@linux-foundation.org>
In-Reply-To: <CAHB1NagijZv=M28x+QDF8aS7rVGaPsXdaLgJvRyLODPL0DTe0w@mail.gmail.com>
References: <20240723091154.52458-1-sunjunchao2870@gmail.com>
	<20240723150931.42f206f9cd86bc391b48c790@linux-foundation.org>
	<CAHB1NagijZv=M28x+QDF8aS7rVGaPsXdaLgJvRyLODPL0DTe0w@mail.gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 23 Jul 2024 23:03:53 -0400 Julian Sun <sunjunchao2870@gmail.com> wrote:

> > > "make help | grep check" shows we have a few ad-hoc integrations but I
> > > wonder if we would benefit from a top-level `make static-checks'
> > > target?
> I have another idea. I asked some of my friends,  they are familiar
> with scripts/checkpatch.pl and usually use it to check patches before
> submitting them. Therefore, can we integrate some checking tools like
> includecheck and macro_checker into checkpatch?

Well, checkpatch is for checking patches - it will check whole files
but isn't typically used that way as far as I know.

A higher-level script which bundles the various static checking tools
would be the way to go.



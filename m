Return-Path: <linux-fsdevel+bounces-22076-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90F35911C5C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Jun 2024 09:00:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C1BF51C20ADB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Jun 2024 07:00:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBB6916A957;
	Fri, 21 Jun 2024 07:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tNbZ3asG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C750167D98;
	Fri, 21 Jun 2024 07:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718953207; cv=none; b=ielNjSvMQNIxLx2wPppgJS4o5Kgk+/QeVpILztTQ/0qBg2eQH39+gVB9ogF0dF7e9J/WpRM8inQs3Xa+nJn5jucmqiwa5BWzApDHzzcrmAZl2Oy0Gp+0gRjN9k4fTBRbS8kATXmeoIg+T8s0KZVvApC5XEvb1XgF0o7yWY/f9W4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718953207; c=relaxed/simple;
	bh=HLK1QrlfbbMEdecZH3fuabbAT7AvcBUTRYiFLz+4f7c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZRMiYMDzcGFQY1cPMsL3WrnTYQQ9l2/SuCK8IfaWg7BBUYP2baNRDrpYDYwpjBD7ZOX+p87eqAh6Fn5WpaFol4KPvDXrYdhn3nODzBpf59VEjFGGJJx6EHMbccAbe3LQXDdO+kSylFgl6wdH+5NhrHpCzAkYyHr2AqVsjb5nk5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tNbZ3asG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCF54C2BBFC;
	Fri, 21 Jun 2024 07:00:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718953206;
	bh=HLK1QrlfbbMEdecZH3fuabbAT7AvcBUTRYiFLz+4f7c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tNbZ3asG1h+6NzR3gqFiEzc9uHqZKts3ieC9wbv7XJJhABcQaRwcERAmfisEEbzbw
	 KolyAPJk7xHHKrq3H0qp3S5z2eQ6Isff96dCX6ASIkb3b+bfa5Hw04mLeOzlsF+6Wa
	 CEd2P3VjBIFwbeY2nD3/unii4yee7O7yIb6d3f7az5tDmKiASMcnHSdqUUw3AduWbr
	 jvRu12juB64C5a0r2l6VAoT9zClsTUK2Qrbb84feV6yBdw9O7SalWTODGKVri30ywX
	 b1zbF5k/d8klmpeNuMM3onVDGAMMAL7IAdixxB/TVdX+dvtPDV5IPI4mb4Vo775IAj
	 9WxJ8dnLpRIVw==
Date: Fri, 21 Jun 2024 00:00:06 -0700
From: Kees Cook <kees@kernel.org>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Eric Biederman <ebiederm@xmission.com>,
	Justin Stitt <justinstitt@google.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH 2/2] exec: Avoid pathological argc, envc, and bprm->p
 values
Message-ID: <202406202354.3020C4FCA4@keescook>
References: <20240520021337.work.198-kees@kernel.org>
 <20240520021615.741800-2-keescook@chromium.org>
 <fbc4e2e4-3ca2-45b7-8443-0a8372d4ba94@roeck-us.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fbc4e2e4-3ca2-45b7-8443-0a8372d4ba94@roeck-us.net>

On Thu, Jun 20, 2024 at 05:19:55PM -0700, Guenter Roeck wrote:
> Hi,
> 
> On Sun, May 19, 2024 at 07:16:12PM -0700, Kees Cook wrote:
> > Make sure nothing goes wrong with the string counters or the bprm's
> > belief about the stack pointer. Add checks and matching self-tests.
> > 
> > For 32-bit validation, this was run under 32-bit UML:
> > $ tools/testing/kunit/kunit.py run --make_options SUBARCH=i386 exec
> > 
> > Signed-off-by: Kees Cook <keescook@chromium.org>
> 
> With this patch in linux-next, the qemu m68k:mcf5208evb emulation
> fails to boot. The error is:

Eeek. Thanks for the report! I've dropped this patch from my for-next
tree.

> Run /init as init process
> Failed to execute /init (error -7)

-7 is E2BIG, so it's certainly one of the 3 new added checks. I must
have made a mistake in my reasoning about how bprm->p is initialized;
the other two checks seems extremely unlikely to be tripped.

I will try to get qemu set up and take a close look at what's happening.
While I'm doing that, if it's easy for you, can you try it with just
this removed (i.e. the other 2 new -E2BIG cases still in place):

	/* Avoid a pathological bprm->p. */
	if (bprm->p < limit)
		return -E2BIG;


-- 
Kees Cook


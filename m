Return-Path: <linux-fsdevel+bounces-22153-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 80DE8912E26
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Jun 2024 21:55:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 342DE1F21E86
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Jun 2024 19:55:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AABE517BB35;
	Fri, 21 Jun 2024 19:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iwNCySql"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F5AF15F336;
	Fri, 21 Jun 2024 19:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718999690; cv=none; b=BEDrKkOgdv/0WiflinRuGvRLmBiy4Hh9DKYsQUl2uPo8ZGS/tGRfIwDdCDZx0HG3i1IgqqXQIwuaGPWe2/mN+L3rCviHf5BJoX/gCyuGce3USG2Mwr6o/czKLeapzPW2fmTYLWgr6tDIuCscxr2IO4bafv5r3dMS+Fn/pG6TILs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718999690; c=relaxed/simple;
	bh=08OZLQzHczJXvI/92ifq133qphMksTOQY9iO9c3L7Mk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iOXGvWDW7nj6DKtfP8J+6seooCT5J42Y+U1fQ6och7qiZqDzfSjk/I4ty4iELlhpP0JuUDjRXIbmKdW4nXNFh+JIEtSqqUHDwvsbphN3qKq5HcAXV8ECobBVwHnosLbwS/iVAP0uU1yDp2GQyAHL3ChXl6AUgP4jRsqkF/Ls+uU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iwNCySql; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97090C2BBFC;
	Fri, 21 Jun 2024 19:54:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718999689;
	bh=08OZLQzHczJXvI/92ifq133qphMksTOQY9iO9c3L7Mk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iwNCySqlZdeszGD4B9MJnJgroEhQAAmklWeqpCDmvAN3oCw2FMLffDzm0/bqZt9Rc
	 45WEbirPPH5mEglpgJqGQiU0wibvyvDr4pcaN6TMxghA5Em7wlE8CplQd+CVG9CKFU
	 56IiRr0LFPE7AANKIrl703qDoEk3nfO/TXxBaTxb20sihW+GjX91TgsTQwbr7CpKFa
	 C7ixhTyejfOmh1b2hJdWdtwWG5sA6aS7WUMM36mzntbJVL1gxMeuSerbougN1raodQ
	 YnGKUK8ApMnqUyK9xTnoc8OkpnDO6TOr4yHNjYsrv3/TK367s2ns7MxBA3LUYxPfyB
	 vxqn2yJtjCt8g==
Date: Fri, 21 Jun 2024 12:54:49 -0700
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
Message-ID: <202406211253.7037F69@keescook>
References: <20240520021337.work.198-kees@kernel.org>
 <20240520021615.741800-2-keescook@chromium.org>
 <fbc4e2e4-3ca2-45b7-8443-0a8372d4ba94@roeck-us.net>
 <202406202354.3020C4FCA4@keescook>
 <1f410012-bf41-4825-9a37-7b7cc7c1df76@roeck-us.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1f410012-bf41-4825-9a37-7b7cc7c1df76@roeck-us.net>

On Fri, Jun 21, 2024 at 06:21:15AM -0700, Guenter Roeck wrote:
> On 6/21/24 00:00, Kees Cook wrote:
> > On Thu, Jun 20, 2024 at 05:19:55PM -0700, Guenter Roeck wrote:
> > > Hi,
> > > 
> > > On Sun, May 19, 2024 at 07:16:12PM -0700, Kees Cook wrote:
> > > > Make sure nothing goes wrong with the string counters or the bprm's
> > > > belief about the stack pointer. Add checks and matching self-tests.
> > > > 
> > > > For 32-bit validation, this was run under 32-bit UML:
> > > > $ tools/testing/kunit/kunit.py run --make_options SUBARCH=i386 exec
> > > > 
> > > > Signed-off-by: Kees Cook <keescook@chromium.org>
> > > 
> > > With this patch in linux-next, the qemu m68k:mcf5208evb emulation
> > > fails to boot. The error is:
> > 
> > Eeek. Thanks for the report! I've dropped this patch from my for-next
> > tree.
> > 
> > > Run /init as init process
> > > Failed to execute /init (error -7)
> > 
> > -7 is E2BIG, so it's certainly one of the 3 new added checks. I must
> > have made a mistake in my reasoning about how bprm->p is initialized;
> > the other two checks seems extremely unlikely to be tripped.
> > 
> > I will try to get qemu set up and take a close look at what's happening.
> > While I'm doing that, if it's easy for you, can you try it with just
> > this removed (i.e. the other 2 new -E2BIG cases still in place):
> > 
> > 	/* Avoid a pathological bprm->p. */
> > 	if (bprm->p < limit)
> > 		return -E2BIG;
> 
> I added a printk:
> 
> argc: 1 envc: 2 p: 262140 limit: 2097152
>                 ^^^^^^^^^^^^^^^^^^^^^^^^
> Removing the check above does indeed fix the problem.

Thanks for checking this!

And I've found my mistake. "argmin" is only valid for CONFIG_MMU. And
you noticed this back in 2018. ;)

http://lkml.kernel.org/r/20181126122307.GA1660@redhat.com

I will try to fix this better so we don't trip over it again.

-- 
Kees Cook


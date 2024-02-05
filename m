Return-Path: <linux-fsdevel+bounces-10238-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC26A8492CD
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Feb 2024 04:35:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DED661C2224F
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Feb 2024 03:35:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 661D59468;
	Mon,  5 Feb 2024 03:35:10 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail.hallyn.com (mail.hallyn.com [178.63.66.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5C0B8F47;
	Mon,  5 Feb 2024 03:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.63.66.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707104110; cv=none; b=UBiHaIQMC59e5N1t4uNWLPe+iog9RQzeCieVqSmelfsT0ZZqJ9fzvUiie9LMZYVGpeX08OnGIvKDSZ/sB6cz8mPP/uuKV/qfyfNKECPRWY7MJ3TgzBR3W6/hY7+KO9Pc1QWoOXoItGyI2w364x0j9liTfloDNfw6UNn+2Pmg4jc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707104110; c=relaxed/simple;
	bh=HxA3GtKQYAgVitXTbgC0lk+XNefu3YtMS+OJuROCUmI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ERshqjX4qgYe8e8Hube4RZV4vUs9avjVBgeCpIUsBpogdUumOpeTU5dWSl49AtcbjY/wYBmKS+IiXYGk166W8X/jYv3SH7zcydCe3650xQHCEnXU+lM7hGVec3RYjJjLMH9W/B/c9SuWOgCRdzAz827H8lL4NP+79b0t6WxfY4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hallyn.com; spf=pass smtp.mailfrom=hallyn.com; arc=none smtp.client-ip=178.63.66.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hallyn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hallyn.com
Received: from serge-l-PF3DENS3 (99-112-204-245.lightspeed.hstntx.sbcglobal.net [99.112.204.245])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: serge)
	by mail.hallyn.com (Postfix) with ESMTPSA id C217B6A3;
	Sun,  4 Feb 2024 21:28:03 -0600 (CST)
Date: Sun, 4 Feb 2024 21:28:01 -0600
From: Serge Hallyn <serge@hallyn.com>
To: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Eric Biederman <ebiederm@xmission.com>,
	Kees Cook <keescook@chromium.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	linux-security-module <linux-security-module@vger.kernel.org>,
	linux-fsdevel <linux-fsdevel@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 0/3] fs/exec: remove current->in_execve flag
Message-ID: <ZcBVwb/ILOH9Vwa/@serge-l-PF3DENS3>
References: <8fafb8e1-b6be-4d08-945f-b464e3a396c8@I-love.SAKURA.ne.jp>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8fafb8e1-b6be-4d08-945f-b464e3a396c8@I-love.SAKURA.ne.jp>

On Sat, Feb 03, 2024 at 07:52:24PM +0900, Tetsuo Handa wrote:
> This is a follow up series for removing current->in_execve flag.
> 
> https://lkml.kernel.org/r/b5a12ecd-468d-4b50-9f8c-17ae2a2560b4@I-love.SAKURA.ne.jp
> 
> [PATCH v2 1/3] LSM: add security_execve_abort() hook
> [PATCH v2 2/3] tomoyo: replace current->in_execve flag with security_execve_abort() hook
> [PATCH v2 3/3] fs/exec: remove current->in_execve flag
> 
>  fs/exec.c                     |    4 +---
>  include/linux/lsm_hook_defs.h |    1 +
>  include/linux/sched.h         |    3 ---
>  include/linux/security.h      |    5 +++++
>  security/security.c           |   11 +++++++++++
>  security/tomoyo/tomoyo.c      |   22 ++++++----------------
>  6 files changed, 24 insertions(+), 22 deletions(-)
> 
> Changes in v2:
> 
>   Replace security_bprm_aborting_creds(const struct linux_binprm *bprm) with
>   security_execve_abort(void), suggested by Eric W. Biederman.

It seems good to me, apart from the mistaken bprm arg mention in
tomoyo_execve_abort() comment in patch 2 which kernel-test-robot found.

Acked-by: Serge E. Hallyn <serge@hallyn.com>

thanks,
-serge


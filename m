Return-Path: <linux-fsdevel+bounces-6942-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ACE3181EC19
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Dec 2023 05:43:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 648F6283477
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Dec 2023 04:43:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E75E73D8E;
	Wed, 27 Dec 2023 04:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b1s3NJMh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46ED85662;
	Wed, 27 Dec 2023 04:43:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28843C433C8;
	Wed, 27 Dec 2023 04:43:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703652206;
	bh=q9xaXdvN3BYNJgeWAI7noIC+KES6Pzsqpe3mtN3BIDo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=b1s3NJMh2hEIWh/xlnYXyLkkAcUimXVOAgMNmiJK0beYwm6lcizuvIYfp0GwexhMB
	 1J/ifsOVm7ZNEAajqiZtj9DaymllGHduLSd/nMrEVmgopmYzr/CKMMX/kez1ShgYHC
	 Uj+of1xNLDPzkvCG64VTyO5/clMWJ0cYtJTsoj+kyS9hgvcGilTze+skX0W7JrRNvn
	 YF8gD0kJF/5RkUfrrAWkCXQ1uoYQedHz6X9f/D1TpdCN+hiTgFvEV/Z0Gqm0TCpJPX
	 4FkW4NMRUYsEOqoPa/DZW5bizcq8O0W8pwgZ6jUza/SPc1ITq8t8HQcQEqYrHI+tLm
	 NXQV8uwwgc+tQ==
Date: Tue, 26 Dec 2023 22:43:22 -0600
From: Eric Biggers <ebiggers@kernel.org>
To: Paul Moore <paul@paul-moore.com>
Cc: Alfred Piccioni <alpic@google.com>,
	Stephen Smalley <stephen.smalley.work@gmail.com>,
	Eric Paris <eparis@parisplace.org>,
	linux-security-module@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, stable@vger.kernel.org,
	selinux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] security: new security_file_ioctl_compat() hook
Message-ID: <20231227044322.GB4240@quark.localdomain>
References: <20230906102557.3432236-1-alpic@google.com>
 <20231219090909.2827497-1-alpic@google.com>
 <CAHC9VhRDPv4-gNNiFMNtP_vL8UM66RQX0vxB0WkNw3Rn_Lcfmg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHC9VhRDPv4-gNNiFMNtP_vL8UM66RQX0vxB0WkNw3Rn_Lcfmg@mail.gmail.com>

On Sun, Dec 24, 2023 at 03:53:16PM -0500, Paul Moore wrote:
> On Tue, Dec 19, 2023 at 4:09 AM Alfred Piccioni <alpic@google.com> wrote:
> >
> > Some ioctl commands do not require ioctl permission, but are routed to
> > other permissions such as FILE_GETATTR or FILE_SETATTR. This routing is
> > done by comparing the ioctl cmd to a set of 64-bit flags (FS_IOC_*).
> >
> > However, if a 32-bit process is running on a 64-bit kernel, it emits
> > 32-bit flags (FS_IOC32_*) for certain ioctl operations. These flags are
> > being checked erroneously, which leads to these ioctl operations being
> > routed to the ioctl permission, rather than the correct file
> > permissions.
> >
> > This was also noted in a RED-PEN finding from a while back -
> > "/* RED-PEN how should LSM module know it's handling 32bit? */".
> >
> > This patch introduces a new hook, security_file_ioctl_compat, that is
> > called from the compat ioctl syscall. All current LSMs have been changed
> > to support this hook.
> >
> > Reviewing the three places where we are currently using
> > security_file_ioctl, it appears that only SELinux needs a dedicated
> > compat change; TOMOYO and SMACK appear to be functional without any
> > change.
> >
> > Fixes: 0b24dcb7f2f7 ("Revert "selinux: simplify ioctl checking"")
> > Signed-off-by: Alfred Piccioni <alpic@google.com>
> > Cc: stable@vger.kernel.org
> > ---
> >  fs/ioctl.c                    |  3 +--
> >  include/linux/lsm_hook_defs.h |  2 ++
> >  include/linux/security.h      |  7 +++++++
> >  security/security.c           | 17 +++++++++++++++++
> >  security/selinux/hooks.c      | 28 ++++++++++++++++++++++++++++
> >  security/smack/smack_lsm.c    |  1 +
> >  security/tomoyo/tomoyo.c      |  1 +
> >  7 files changed, 57 insertions(+), 2 deletions(-)
> 
> I made some minor style tweaks around line length and alignment, but
> otherwise this looked good to me.  Thanks all!
> 

Reviewed-by: Eric Biggers <ebiggers@google.com>

(I reviewed the version in branch "next" of
https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/lsm.git)

- Eric


Return-Path: <linux-fsdevel+bounces-46219-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32DA8A84AED
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Apr 2025 19:26:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 323C51701D0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Apr 2025 17:24:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D3411F17F7;
	Thu, 10 Apr 2025 17:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="st7Ba1Lu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 944F41F098E;
	Thu, 10 Apr 2025 17:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744305854; cv=none; b=B3Y6uIkchB4v2UL0z9rrqNVgTQe2HW3lhgu0Ht+wO2VbSkQzAM6roKapCr/wJYDmfoJElJraoduHlqjstOeI/+EpiO/hAK3Ta68kam6TyVZtGhwketB+Z0WYaC2kmpD5+LsygpGw7x107HQzypmsRGl9ZknU4lh0+BSPU2KW5Oc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744305854; c=relaxed/simple;
	bh=LytjVK/uTAfK1ATja76akWBApQICg4D2IClyyAxnKiM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kTMrqbgrpAPkPbOyKnRgWr1QtLCIkF4O4a93d7zuTGtqjmuPD7JsVbJmjpcBsjRuhOX0pqdFfD/PsnWx6++E+fMKX4aMr99c9FqaK1TybhH+QgKdkwCWCvvvJCZYaCdxu8fc0ayDSDf/Pcg30C4Pk/nuIjuHJ3X4FYV0he2YLyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=st7Ba1Lu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29FAAC4CEEA;
	Thu, 10 Apr 2025 17:24:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744305854;
	bh=LytjVK/uTAfK1ATja76akWBApQICg4D2IClyyAxnKiM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=st7Ba1LuzVZa0v54c9Ukc2WUdpZnIkKxlfeukTkFvSwLPgVfrDsskz1HCRHKJQ0T7
	 uMSXiewUUu9WBVsQ/8Pjt22rGUmOdeb7hmG4uKGTYR2WX3JqwccflfNdC6oG0cu7XV
	 cwlKJfsSwQSpZ7ywbAmDv5zWTvPU2SgrZnMjcaE/9DB5r9KZg+RSoTblyxRnjQv5iw
	 2N85PRGR6SkAy2O/Znz0ys7TnbfNo9rmHMm8bgR+lCv1lQYMj/yQf6LAr65+6mN8a2
	 NEg9CZAW62k7agS6GwhSs763Yw+J/F5oHCEu7MJr7KGZoscDny/YkmwI0KVN/V4rAA
	 quhT8VvqDf9tg==
Date: Thu, 10 Apr 2025 17:24:08 +0000
From: sergeh@kernel.org
To: Roberto Sassu <roberto.sassu@huaweicloud.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Kees Cook <kees@kernel.org>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org,
	linux-integrity@vger.kernel.org, zohar@linux.ibm.com
Subject: Re: Credentials not fully initialized before bprm_check LSM hook
Message-ID: <Z_f-uBGhBq9CYmaw@lei>
References: <fb9f7900d411a3ab752759d818c3da78e2f8f0f1.camel@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fb9f7900d411a3ab752759d818c3da78e2f8f0f1.camel@huaweicloud.com>

On Thu, Apr 10, 2025 at 01:47:07PM +0200, Roberto Sassu wrote:
> Hi everyone
> 
> recently I discovered a problem in the implementation of our IMA
> bprm_check hook, in particular when the policy is matched against the
> bprm credentials (to be committed later during execve().
> 
> Before commit 56305aa9b6fab ("exec: Compute file based creds only
> once"), bprm_fill_uid() was called in prepare_binprm() and filled the
> euid/egid before calling security_bprm_check(), which in turns calls
> IMA.
> 
> After that commit, bprm_fill_uid() was moved to begin_new_exec(), which
> is when the last interpreter is found.
> 
> The consequence is that IMA still sees the not yet ready credentials
> and an IMA rule like:
> 
> measure func=CREDS_CHECK euid=0

"IMA still sees" at which point exactly?

Do I understand right that the problem is that ima's version of
security_bprm_creds_for_exec() needs to run after
bprm_creds_from_file()?

Given that Eric's commit message said that no bprm handlers use
the uid, it seems it should be safe to just move that?

> will not be matched for sudo-like applications.
> 
> It does work however with SELinux, because it computes the transition
> before IMA in the bprm_creds_for_exec hook.
> 
> Since IMA needs to be involved for each execution in the chain of
> interpreters, we cannot move to the bprm_creds_from_file hook.
> 
> How do we solve this problem? The commit mentioned that it is an
> optimization, so probably would not be too hard to partially revert it
> (and keeping what is good).
> 
> Thanks
> 
> Roberto
> 


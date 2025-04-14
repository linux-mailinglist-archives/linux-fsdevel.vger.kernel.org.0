Return-Path: <linux-fsdevel+bounces-46394-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 67832A885CE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Apr 2025 16:53:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D5BDA16770C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Apr 2025 14:49:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB897274FF8;
	Mon, 14 Apr 2025 14:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ntpSpUHj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A83C22097;
	Mon, 14 Apr 2025 14:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744641686; cv=none; b=GvDzuekW7kh251qdHs0ePd1s8u6Ve9X3ZP8IoI1xwp0hMIJ8zDETARtbXUrRkCWs4mvufVroDLudX4DpKzTHYkvOxFMoAZk2fHvUIe8aazH6QeWcCj1WhWU7Umv36swemfGF5wjHdlzT7CDykhATmUO8cBfpnO80qTP8JrbxMXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744641686; c=relaxed/simple;
	bh=IiqTMb8EdX6P83ovafpdAamRgrLSnbCbPGnUMugFHT8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bJFV0H/yBkj7jirCazHXbG3P+cDfht2oEQ84U43P6QLhBw+eBozdlyTtc/qLopCAfEyUtdUA4iOtGFKMihx4lxFHSqUzqZztqEIU9YTp8wvaC2oxHk2/+vsN+VsJqFnWFDU8aPCe4rPf+WGpAGMRFWZ2VsEBiLH9GQoPsVsSmAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ntpSpUHj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B97F3C4CEE2;
	Mon, 14 Apr 2025 14:41:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744641685;
	bh=IiqTMb8EdX6P83ovafpdAamRgrLSnbCbPGnUMugFHT8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ntpSpUHjNnIQwjHylgSgFNu0tbbJGvALDUSS1ATh3E6MkvROhWAvL0Cci+OMomVV4
	 Io8c+SUmIWf4IlvJMCi4LZElVE/xPDObvWilrevJwCtdpTiSFp1FXaIf1WLE1MRqVN
	 T4g0AEqO5wJEk3a9HH+nLnpjcPE+eY/xNKrAZ8I0y3lvviyAdAIKcGkj6EfrQxgJUj
	 TY/1Vmc4T2JML2u/733Yyrd5xG0FarHXmCsoL6bpzAiGwK3TGEWhw1D5O14SVuFTsV
	 X4WQCOy5bGdst/xr25Z1rPBkOtSD4xtMpzoCKnwWHmLUR+Tqdosth0uK3wCamYXy9N
	 /Tp7Xww8qfAsQ==
Date: Mon, 14 Apr 2025 16:41:21 +0200
From: Christian Brauner <brauner@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, Luca Boccassi <luca.boccassi@gmail.com>, 
	Lennart Poettering <lennart@poettering.net>, Daan De Meyer <daan.j.demeyer@gmail.com>, 
	Mike Yuan <me@yhndnzj.com>, Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/3] coredump: hand a pidfd to the usermode coredump
 helper
Message-ID: <20250414-boiler-expedition-3f27837c513f@brauner>
References: <20250414-work-coredump-v2-0-685bf231f828@kernel.org>
 <20250414-work-coredump-v2-3-685bf231f828@kernel.org>
 <20250414141450.GE28345@redhat.com>
 <20250414142807.GF28345@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250414142807.GF28345@redhat.com>

On Mon, Apr 14, 2025 at 04:28:07PM +0200, Oleg Nesterov wrote:
> On 04/14, Oleg Nesterov wrote:
> >
> > On 04/14, Christian Brauner wrote:
> > >
> > > -static int umh_pipe_setup(struct subprocess_info *info, struct cred *new)
> > > +static int umh_coredump_setup(struct subprocess_info *info, struct cred *new)
> > >  {
> > >  	struct file *files[2];
> > >  	struct coredump_params *cp = (struct coredump_params *)info->data;
> > >  	int err;
> > >
> > > +	if (cp->pid) {
> > > +		struct file *pidfs_file __free(fput) = NULL;
> > > +
> > > +		pidfs_file = pidfs_alloc_file(cp->pid, 0);
> > > +		if (IS_ERR(pidfs_file))
> > > +			return PTR_ERR(pidfs_file);
> > > +
> > > +		/*
> > > +		 * Usermode helpers are childen of either
> > > +		 * system_unbound_wq or of kthreadd. So we know that
> > > +		 * we're starting off with a clean file descriptor
> > > +		 * table. So we should always be able to use
> > > +		 * COREDUMP_PIDFD_NUMBER as our file descriptor value.
> > > +		 */
> > > +		VFS_WARN_ON_ONCE((pidfs_file = fget_raw(COREDUMP_PIDFD_NUMBER)) != NULL);
> > > +
> > > +		err = replace_fd(COREDUMP_PIDFD_NUMBER, pidfs_file, 0);
> > > +		if (err < 0)
> > > +			return err;
> >
> > Yes, but if replace_fd() succeeds we need to nullify pidfs_file
> > to avoid fput from __free(fput) ?
> 
> Aah, please ignore me ;) replace_fd/do_dup2 does get_file() .
> 
> For this series:

Thanks for the excellent review as usual!


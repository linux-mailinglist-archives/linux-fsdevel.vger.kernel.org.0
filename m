Return-Path: <linux-fsdevel+bounces-46369-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6E18A88135
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Apr 2025 15:09:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EAD397A6A8D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Apr 2025 13:08:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B35F2C3775;
	Mon, 14 Apr 2025 13:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Syx6/GGw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 788671E86E;
	Mon, 14 Apr 2025 13:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744636175; cv=none; b=X69/XYKsflMoJXXhMTebpnq3X6yJTd6/LlwBDU1e5UYkkk7MkRWdqOl0MwyxbA9Bzm1mzTpjc6D3z7Bki3oGGf6wfhi4gj7RD0iWgzmn5vSU5fyVcdIteXD59ip8erjE8Tci6/Mi307NE76/Y/WqAMF0aHTd/SmSDeKfkDepYlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744636175; c=relaxed/simple;
	bh=OqDvYuf9mPaH7z7H/UyCQTy/GMst+kRxyHV3QQutdzA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OI2riphh9vxqV2FDpgMhPUIfXMjSo0deAFXkCtAeVOlpk6BYs2MgxXFp6b1CWjom5eBaj1zPtDYWOPhFdBiGaQt3T33QcmYr0YEqTbrbnSL1qbnCg92zU+Yyd+ob0/regEGpMlhYvnWNxTMPLyYnI5hr/m/agfSduo6eB+NgtDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Syx6/GGw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19991C4CEE2;
	Mon, 14 Apr 2025 13:09:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744636175;
	bh=OqDvYuf9mPaH7z7H/UyCQTy/GMst+kRxyHV3QQutdzA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Syx6/GGwRDVkR/3iMMBgIyqVKOilZWJ+FL/xOixSoX1DVA9tn1561splJV4SkQux6
	 luD6tMFT9er/pjcTy3ChxTRwWqBKxDP7EugKJDsJyHGciDZMGfqjWVaKQkWQgEIzio
	 YTFVJSaYIEn505hwYJ50TrAlwiDRHp7jQj6jClSn0bIan/6jfmD10rYjZlTENPfO5G
	 OYjEz/bz6MmRGc4Z/pTI2zK7CafAHYNbHtfycUqb3z0XJGYrv5r3+x4SvMzFw2BEI6
	 5wtj4QcfXVlCqNOwEJco3Ua8flDHCNADfQzbRmnI5+eu6L/tklFlJ/6CoczeXoT0Ip
	 v+2mmS6+al4vw==
Date: Mon, 14 Apr 2025 15:09:30 +0200
From: Christian Brauner <brauner@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, Luca Boccassi <luca.boccassi@gmail.com>, 
	Lennart Poettering <lennart@poettering.net>, Daan De Meyer <daan.j.demeyer@gmail.com>, 
	Mike Yuan <me@yhndnzj.com>, Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] coredump: hand a pidfd to the usermode coredump
 helper
Message-ID: <20250414-jawohl-herziehen-1c77e6e9065b@brauner>
References: <20250414-work-coredump-v1-0-6caebc807ff4@kernel.org>
 <20250414-work-coredump-v1-3-6caebc807ff4@kernel.org>
 <20250414124843.GB28345@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250414124843.GB28345@redhat.com>

On Mon, Apr 14, 2025 at 02:48:44PM +0200, Oleg Nesterov wrote:
> On 04/14, Christian Brauner wrote:
> >
> > +			case 'F': {
> > +				struct file *pidfs_file __free(fput) = NULL;
> > +
> > +				/*
> > +				 * Install a pidfd only makes sense if
> > +				 * we actually spawn a usermode helper.
> > +				 */
> > +				if (!ispipe)
> > +					break;
> > +
> > +				/*
> > +				 * We already created a pidfs_file but the user
> > +				 * specified F multiple times. Just print the
> > +				 * number multiple times.
> > +				 */
> > +				if (!cprm->pidfs_file) {
> > +					/*
> > +					 * Create a pidfs file for the
> > +					 * coredumping thread that we can
> > +					 * install into the usermode helper's
> > +					 * file descriptor table later.
> > +					 *
> > +					 * Note that we'll install a pidfd for
> > +					 * the thread-group leader. We know that
> > +					 * task linkage hasn't been removed yet
> > +					 * and even if this @current isn't the
> > +					 * actual thread-group leader we know
> > +					 * that the thread-group leader cannot
> > +					 * be reaped until @current has exited.
> > +					 */
> > +					pidfs_file = pidfs_alloc_file(task_tgid(current), 0);
> > +					if (IS_ERR(pidfs_file))
> > +						return PTR_ERR(pidfs_file);
> > +				}
> > +
> > +				 /*
> > +				 * Usermode helpers are childen of
> > +				 * either system_unbound_wq or of
> > +				 * kthreadd. So we know that we're
> > +				 * starting off with a clean file
> > +				 * descriptor table. Thus, we should
> > +				 * always be able to use file descriptor
> > +				 * number 3.
> > +				 */
> > +				err = cn_printf(cn, "%d", COREDUMP_PIDFD_NUMBER);
> > +				if (err)
> > +					return err;
> > +
> > +				cprm->pidfs_file = no_free_ptr(pidfs_file);
> > +				break;
> > +			}
> 
> So the new case 'F' differs from other case's in that it doesn't do
> "break" but returns the error... this is a bit inconsistent.

Yeah, though that already happens right at the top.

> 
> Note also that if you do cn_printf() before pidfs_alloc_file(), then you
> can avoid __free(fput) and no_free_ptr().

Seemed inconsitent to me to print first even though we didn't succeed
but I agree that it doesn't matter.

> 
> But this is minor. Can't we simplify this patch?

Let's hear it...

> 
> Rather than add the new pidfs_file member into coredump_params, we can
> add "struct pid *pid". format_corename() will simply do
> 
> 	case 'F':
> 		if (ispipe) {
> 			// no need to do get_pid()
> 			cprm->pid = task_tgid(current);
> 			err = cn_printf(...);
> 		}
> 		break;
> 
> and umh_pipe_setup() can itself do pidfs_alloc_file(cp->pid) if it is
> not NULL.

Sure, same result but works for me. I'll send v2 in a bit.

> 
> This way do_coredump() doesn't need any changes.
> 
> No?

Yep, sounds good.


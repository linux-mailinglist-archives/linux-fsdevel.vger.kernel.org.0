Return-Path: <linux-fsdevel+bounces-43243-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E4C86A4FC68
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Mar 2025 11:41:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 326243AFFDE
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Mar 2025 10:39:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 588C52066F9;
	Wed,  5 Mar 2025 10:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UHdB+/8O"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B24131FBC84;
	Wed,  5 Mar 2025 10:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741171132; cv=none; b=ls2GeNrpJ3Y93ZBTugYgNJ/s6sfM3T/mcBHCMCN3+Syi0BmXxqAscjlchSz8adk6fvaLgfTEB8TnNvM6QZh3CF78p9Ou+ntS4HxMw4TCfSSw07Mwckts6y1mhlpZOdJIEbLebNuqSDGaxX9zq3BlCPAPMYcQXhNXhql5/7ZcHXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741171132; c=relaxed/simple;
	bh=Csp6GVyKJhlpTqY4qJzrrUmCc24wfHMu90CB/DuDtSs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sWjfJ/dmdcH1lOdOTIkUfqSVRbk9ZYHW333wpp4eI7uM2x40i6FWn5hEWq6nl8vruxpXpZXJVF8tTOJBQFTykvMcac75iaeO/CsGUiDGYL5TY0cOpSmJ43LjZlvPyBWt7uBHOI1Bz42aKHl6wGmZ/+noK8ElJQHUmP+q2HjpMVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UHdB+/8O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAA7CC4CEE2;
	Wed,  5 Mar 2025 10:38:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741171132;
	bh=Csp6GVyKJhlpTqY4qJzrrUmCc24wfHMu90CB/DuDtSs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UHdB+/8OqDlOt+yoEyMZA3mnNIj03tjF/dSApmSbB34R3G0cu4NDZV5bAD02V7VtE
	 YqFYOEazNSp+pKLNDMO868DTQg8wSYR00NjiJHelHiIVLeuuEGFw4uT1AMaMMaSnUB
	 zRtkKRjBAjeMDrjxAfMjlvJ0YPRL2erARnJXt+oZ80Q1uYfiShagK1OBUETJB8QyKL
	 H03GpfHWsataIGOtJh1GTbwNym2jczF0rwpOD3WubMuID7TlCFllGhb81KrRMPh6Ww
	 lyZu+6JszPU+vbZgysljKdBXlDUdHwanI2eQQ68Zu/qIi8qKbuj9aqudnOBQqI1v4h
	 TyZ+W8387KOGA==
Date: Wed, 5 Mar 2025 11:38:47 +0100
From: Christian Brauner <brauner@kernel.org>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: viro@zeniv.linux.org.uk, jack@suse.cz, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Subject: Re: [RFC PATCH v v2 0/4] avoid the extra atomic on a ref when
 closing a fd
Message-ID: <20250305-sofern-visite-70a6134399cb@brauner>
References: <20250304183506.498724-1-mjguzik@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250304183506.498724-1-mjguzik@gmail.com>

On Tue, Mar 04, 2025 at 07:35:02PM +0100, Mateusz Guzik wrote:
> The stock kernel transitioning the file to no refs held penalizes the
> caller with an extra atomic to block any increments.
> 
> For cases where the file is highly likely to be going away this is
> easily avoidable.
> 
> In the open+close case the win is very modest because of the following
> problems:
> - kmem and memcg having terrible performance

I thought that was going to be addressed by Vlastimil, i.e., the mm guys
to provide a new memcg api.

> - putname using an atomic (I have a wip to whack that)
> - open performing an extra ref/unref on the dentry (there are patches to
>   do it, including by Al. I mailed about them in [1])
> - creds using atomics (I have a wip to whack that)
> - apparmor using atomics (ditto, same mechanism)
> 
> On top of that I have a WIP patch to dodge some of the work at lookup
> itself.
> 
> All in all there is several % avoidably lost here.
> 
> stats colected during a kernel build with:
> bpftrace -e 'kprobe:filp_close,kprobe:fput,kprobe:fput_close* { @[probe] = hist(((struct file *)arg0)->f_ref.refcnt.counter > 0); }'
> 
> @[kprobe:filp_close]:
> [0]                32195 |@@@@@@@@@@                                          |
> [1]               164567 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@|
> 
> @[kprobe:fput]:
> [0]               339240 |@@@@@@                                              |
> [1]              2888064 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@|
> 
> @[kprobe:fput_close]:
> [0]              5116767 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@|
> [1]               164544 |@                                                   |
> 
> @[kprobe:fput_close_sync]:
> [0]              5340660 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@|
> [1]               358943 |@@@                                                 |
> 
> 
> 0 indicates the last reference, 1 that there is more.
> 
> filp_close is largely skewed because of close_on_exec.
> 
> vast majority of last fputs are from remove_vma. I think that code wants
> to be patched to batch them (as in something like fput_many should be
> added -- something for later).

We used to have that for io_uring and got rid of it. The less fput()
primitives the better tbh. But let's see.

> 
> [1] https://lore.kernel.org/linux-fsdevel/20250304165728.491785-1-mjguzik@gmail.com/T/#u
> 
> v2:
> - patch filp_close
> - patch failing open
> 
> Mateusz Guzik (4):
>   file: add fput and file_ref_put routines optimized for use when
>     closing a fd
>   fs: use fput_close_sync() in close()
>   fs: use fput_close() in filp_close()
>   fs: use fput_close() in path_openat()
> 
>  fs/file.c                | 75 ++++++++++++++++++++++++++++++----------
>  fs/file_table.c          | 72 +++++++++++++++++++++++++++-----------
>  fs/namei.c               |  2 +-
>  fs/open.c                |  4 +--
>  include/linux/file.h     |  2 ++
>  include/linux/file_ref.h |  1 +
>  6 files changed, 114 insertions(+), 42 deletions(-)
> 
> -- 
> 2.43.0
> 


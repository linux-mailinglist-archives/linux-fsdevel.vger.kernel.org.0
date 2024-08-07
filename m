Return-Path: <linux-fsdevel+bounces-25251-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 617B694A4CB
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Aug 2024 11:55:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 099B21F228B4
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Aug 2024 09:55:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 824981D27BD;
	Wed,  7 Aug 2024 09:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KCqsN5dr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C37891C9DC8;
	Wed,  7 Aug 2024 09:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723024505; cv=none; b=trfyPRVEmjj9bFbteLf2M2OMiEZQvXT+bDSeixmr+C8zs+5PPUWR0mZvgMmPMtwQ4k/wj+A/DI9QbtP74fRvaT2dVXJvLouVfACYW4W7P6JBE4Uvuomky1hJUY8jxnP1bWTykAupSYFIjVenteHEcx7l2b/eHZdMe7p030xEpO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723024505; c=relaxed/simple;
	bh=Bm0CzK4dod1bX3KrhA9w8qddCLpMv+2reqKJERplQUM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V0JAe9O6+5N9/qXgGffE9Fu77z9/oJ516uE0yMR5RQ9/k5cOT50xqcNArFLxdRbloTJin4bSNEIHdBtzKfmNPN62/UzwNTM+EFkrsuYB9WNIIrDyOAdnPrbDtfQjliZJWDFY5hw9pz56Fw0/FLKC3ncDMWF+Tl8Z1s9A8NO3sVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KCqsN5dr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82A17C4AF0B;
	Wed,  7 Aug 2024 09:55:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723024505;
	bh=Bm0CzK4dod1bX3KrhA9w8qddCLpMv+2reqKJERplQUM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KCqsN5drwfHgt0Y7YgD44EoyschQj5fXyt0tQfmThhrZUqTG4esOg0wOWUsgnmGgo
	 udTzFabLlWNtBaIRrn9DFbWYQ20b/7gl66WPORX5T5lcOZpb18Eh/EmP+KMZw+MLF4
	 dfqzCN+RLl/WfemLiYosLa8fWelrbZcfSBifsSw8uX1iSCjzf7O4L6txPP5DetXjWw
	 aezPDb9SHoyHjrMYfoZEeSjqqLM4fVd6nseGIs0+7XVmOfEKetP+Ptlpwef+unSa3P
	 x4hr9swzwmVrtlJDO8/jrqiavUr77rTjozfSmLHvWQ1Zmot6/T+WyOQ/6ykWqEPpVv
	 jQZ0ttUnvCaIQ==
Date: Wed, 7 Aug 2024 11:55:00 +0200
From: Christian Brauner <brauner@kernel.org>
To: viro@kernel.org
Cc: linux-fsdevel@vger.kernel.org, amir73il@gmail.com, bpf@vger.kernel.org, 
	cgroups@vger.kernel.org, kvm@vger.kernel.org, netdev@vger.kernel.org, 
	torvalds@linux-foundation.org
Subject: Re: [PATCH 02/39] introduce fd_file(), convert all accessors to it.
Message-ID: <20240807-gutschein-entkriminalisierung-0ab94dad84a9@brauner>
References: <20240730050927.GC5334@ZenIV>
 <20240730051625.14349-1-viro@kernel.org>
 <20240730051625.14349-2-viro@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240730051625.14349-2-viro@kernel.org>

On Tue, Jul 30, 2024 at 01:15:48AM GMT, viro@kernel.org wrote:
> From: Al Viro <viro@zeniv.linux.org.uk>
> 
> 	For any changes of struct fd representation we need to
> turn existing accesses to fields into calls of wrappers.
> Accesses to struct fd::flags are very few (3 in linux/file.h,
> 1 in net/socket.c, 3 in fs/overlayfs/file.c and 3 more in
> explicit initializers).
> 	Those can be dealt with in the commit converting to
> new layout; accesses to struct fd::file are too many for that.
> 	This commit converts (almost) all of f.file to
> fd_file(f).  It's not entirely mechanical ('file' is used as
> a member name more than just in struct fd) and it does not
> even attempt to distinguish the uses in pointer context from
> those in boolean context; the latter will be eventually turned
> into a separate helper (fd_empty()).
> 
> 	NOTE: mass conversion to fd_empty(), tempting as it
> might be, is a bad idea; better do that piecewise in commit
> that convert from fdget...() to CLASS(...).
> 
> [conflicts in fs/fhandle.c, kernel/bpf/syscall.c, mm/memcontrol.c
> caught by git; fs/stat.c one got caught by git grep]
> [fs/xattr.c conflict]
> 
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---

Reviewed-by: Christian Brauner <brauner@kernel.org>


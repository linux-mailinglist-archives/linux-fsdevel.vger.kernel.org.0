Return-Path: <linux-fsdevel+bounces-70273-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 90FACC94B71
	for <lists+linux-fsdevel@lfdr.de>; Sun, 30 Nov 2025 05:24:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0E1F54E17B9
	for <lists+linux-fsdevel@lfdr.de>; Sun, 30 Nov 2025 04:24:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EEB823E334;
	Sun, 30 Nov 2025 04:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="eKKTxaA2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39E2C1AAE13;
	Sun, 30 Nov 2025 04:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764476634; cv=none; b=omYCaLBIayAITznrB/YL7lDRoMNx3fDs2a1LfYY5HtvtdIswlmHywQGstYGsIStASSuT208gXxZeIsHReZHIQqDlRu/I+4IM6+osK/doBb9a3JZvX9znpodsb74t2vWShVj9ylUt2BTZCsvQLbJssRQQT7iV5yE0QWQdHMH7/Gc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764476634; c=relaxed/simple;
	bh=hnR5Dz0QikR5HczIuSiGehBOvUQvy0paTIbwbsOVlIo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iv0r3QI0C4bwNoqBSnE83zWme8/2gFDMmHeSCIULDjEFMg9ThYegRHtE+ujPDSaLyNeEoPn0/uGAuXA8/XVWU9cn8Ze0tHYs5xgTgSZsv4IBuKxOxLzAjHJUf3PPaTWSL1VNTwcAHchmJR3jT19IUshLJTPBOqmONnSALiBDgCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=eKKTxaA2; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=C90osfOQN3ODna9AT6v7fUkP7V1+3pgvvE8/tqbHiCQ=; b=eKKTxaA2+V0HCHPyaG83vtSHbs
	08rCqXx+oZh/p7ZPjH6eSe7RZPWLY9W9fJvE5NdyW1wUbFXVUJ1qGkHHlATfdIMVDp3Vf4QAalXh5
	mJcwm6zBMo5z0sclEoGvDjkpASAHlSc7Gx4NfNOCsTZXyWoFxtm/PMPQCnh0lyLVzyq2jtkOh3dU8
	q7RYkg53i0NVDxyNOBAZL34gL8y8IZAx8F3xlSYCmgYCAUZS9BIGpP3hfpRiTMB9itl+995pnvS13
	fDc0OM8+y4xwFaSs+YML1rx1RYZ2mnXvV5mDpvlSsIiMe7+xg+QVeo0awOCuW28IgaXxeGiM/YHMI
	xa//LhQg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99 #2 (Red Hat Linux))
	id 1vPYyb-0000000Dy0n-1Le3;
	Sun, 30 Nov 2025 04:23:57 +0000
Date: Sun, 30 Nov 2025 04:23:57 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Song Liu <song@kernel.org>
Cc: bpf@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-security-module@vger.kernel.org, ast@kernel.org,
	daniel@iogearbox.net, andrii@kernel.org, kernel-team@meta.com,
	brauner@kernel.org, jack@suse.cz, paul@paul-moore.com,
	jmorris@namei.org, serge@hallyn.com
Subject: Re: [PATCH bpf-next 2/3] bpf: Add bpf_kern_path and bpf_path_put
 kfuncs
Message-ID: <20251130042357.GP3538@ZenIV>
References: <20251127005011.1872209-1-song@kernel.org>
 <20251127005011.1872209-3-song@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251127005011.1872209-3-song@kernel.org>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Wed, Nov 26, 2025 at 04:50:06PM -0800, Song Liu wrote:
> Add two new kfuncs to fs/bpf_fs_kfuncs.c that wrap kern_path() for use
> by BPF LSM programs:
> 
> bpf_kern_path():
> - Resolves a pathname string to a struct path

> These kfuncs enable BPF LSM programs to resolve pathnames provided by
> hook arguments (e.g., dev_name from sb_mount) and validate or inspect
> the resolved paths. The verifier enforces proper resource management
> through acquire/release tracking.

Oh, *brilliant*.  Thank you for giving a wonderful example of the reasons
why this is fundamentally worthless.

OK, your "BPF LSM" has been called and it got that dev_name.  You decide
that you want to know what it resolves to (which, BTW, requries a really
non-trivial amount of parsing other arguments - just to figure out whether
it *is* a pathname of some sort).  Thanks to your shiny new kfuncs you
can do that!  You are a proud holder of mount/dentry pair.  You stare at
those and decide whether it's OK to go on.  Then you... drop that pair
and let mount(2) proceed towards the point where it will (if you parsed
the arguments correctly) repeat that pathname resolution and get a mount/dentry
pair of its own, that may very well be different from what you've got the
first time around.

Your primitive is a walking TOCTOU bug - it's impossible to use safely.

NAKed-by: Al Viro <viro@zeniv.linux.org.uk>


Return-Path: <linux-fsdevel+bounces-41836-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 46496A38051
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Feb 2025 11:37:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3622A3A858B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Feb 2025 10:35:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2CB6216E1E;
	Mon, 17 Feb 2025 10:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="arzicGKL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 287B423CE;
	Mon, 17 Feb 2025 10:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739788521; cv=none; b=FxYX1mL66A9mtc+urSoOnF/nsajHS6cOvJPbf1I1rHrjuv0CsaJMemhil038N756EhDIgv+H53DWPczSXfXeghe7P0bB4GH5dR57KkQLJM9j+Z133U7w8pdDVVFR2ox7VRsJrUzaQJ0EImrj9uvGlAMqg+anI6eeN89meXdMk1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739788521; c=relaxed/simple;
	bh=YYPjNLzART297Jx9/s3Mk48I26sLiTPzF7mzU/7ugoI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r8OwuvuJAe3CWJ883+C6CfrghbuT851+qGj3W3Qj9dy+AqxIES6w7iOK+gqhQca7yyUR2anXWsBSJn/eFJihCNlHeStYzOXIig/IcbSM8T3NscTD9aSQsH8Fptjy+pDClkFMzbNW+PYlwP/GapOo5QPJgBAmIRoBrGkxFz3vYGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=arzicGKL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 514EBC4CED1;
	Mon, 17 Feb 2025 10:35:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739788520;
	bh=YYPjNLzART297Jx9/s3Mk48I26sLiTPzF7mzU/7ugoI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=arzicGKLKkKvuAwJMrTrr+3a3T4qmpUQLX7ThgtO16dUNc6FtI1UQ49Aa13J6SJkq
	 C9ChdfmqifuDVKa+nXWNTzqwbEl0uDNx2Y3VmzdmBSw4XumQGDeyEehsNMh2DmfGLH
	 dslAL7/8jVpRddEP9nSmCxhToL1XC2x166uPkr7gMEkjGq8qYvkDXBKcAE+sKh6rHT
	 X1R2t3pA/Edf671J7zx+ujdNVAFE5HcGsCu2ZxMkyiEGgPOlmYRc6HhNI0TAnRByYB
	 rSCox9Wxv52Er6btlvEjrPMmXmtOxgECnPJ18rmQgnf1pICxUX9R+Ni6q19/hddKjt
	 Kz0C/4gt3oO/Q==
Date: Mon, 17 Feb 2025 11:35:15 +0100
From: Joel Granados <joel.granados@kernel.org>
To: nicolas.bouchinet@clip-os.org
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	Nicolas Bouchinet <nicolas.bouchinet@ssi.gouv.fr>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Jiri Slaby <jirislaby@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Luis Chamberlain <mcgrof@kernel.org>, 
	Kees Cook <kees@kernel.org>, Joel Granados <j.granados@samsung.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Neil Horman <nhorman@tuxdriver.com>, Lin Feng <linf@wangsu.com>, 
	Theodore Ts'o <tytso@mit.edu>
Subject: Re: [PATCH v4 0/2]  Fixes multiple sysctl proc_handler usage error
Message-ID: <unfyshpxhpvemwitht574ibizvuob55jgc45wbkiq7yvjvwvwq@ofo3kkmq5vvj>
References: <20250115132211.25400-1-nicolas.bouchinet@clip-os.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250115132211.25400-1-nicolas.bouchinet@clip-os.org>

On Wed, Jan 15, 2025 at 02:22:07PM +0100, nicolas.bouchinet@clip-os.org wrote:
> From: Nicolas Bouchinet <nicolas.bouchinet@ssi.gouv.fr>
> 
> Hi, while reading sysctl code I encountered two sysctl proc_handler
> parameters common errors.
> 
> The first one is to declare .data as a different type thant the return of
> the used .proc_handler, i.e. using proch_dointvec, thats convert a char
> string to signed integers, and storing the result in a .data that is backed
> by an unsigned int. User can then write "-1" string, which results in a
> different value stored in the .data variable. This can lead to type
> conversion errors in branches and thus to potential security issues.
> 
> From a quick search using regex and only for proc_dointvec, this seems to
> be a pretty common mistake.
> 
> The second one is to declare .extra1 or .extra2 values with a .proc_handler
> that don't uses them. i.e, declaring .extra1 or .extra2 using proc_dointvec
> in order to declare conversion bounds do not work as do_proc_dointvec don't
> uses those variables if not explicitly asked.
> 
> This patchset corrects three sysctl declaration that are buggy as an
> example and is not exhaustive.
After some time in sysctl-testing, pushing this to sysctl-next

> 
> Nicolas
> 
> ---
> 
> Changes since v3:
> https://lore.kernel.org/all/20241217132908.38096-1-nicolas.bouchinet@clip-os.org/
> 
> * Fixed patch 2/2 extra* parameter typo detected by Joel Granados.
> * Reworded patch 2/2 as suggested by Joel Granados.
> 
> 
> Changes since v2:
> https://lore.kernel.org/all/20241114162638.57392-1-nicolas.bouchinet@clip-os.org/
> 
> * Bound vdso_enabled to 0 and 1 as suggested by Joel Granados.
> * Remove patch 3/3 since Greg Kroah-Hartman merged it.
> 
> Changes since v1:
> https://lore.kernel.org/all/20241112131357.49582-1-nicolas.bouchinet@clip-os.org/
> 
> * Take Lin Feng review into account.
> 
> ---
> 
> Nicolas Bouchinet (2):
>   coredump: Fixes core_pipe_limit sysctl proc_handler
>   sysctl: Fix underflow value setting risk in vm_table
> 
>  arch/sh/kernel/vsyscall/vsyscall.c | 3 ++-
>  fs/coredump.c                      | 4 +++-
>  2 files changed, 5 insertions(+), 2 deletions(-)
> 
> -- 
> 2.48.1
> 

-- 

Joel Granados


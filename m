Return-Path: <linux-fsdevel+bounces-50590-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F81CACD8A6
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Jun 2025 09:37:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A0A47164877
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Jun 2025 07:37:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53BE11FECBD;
	Wed,  4 Jun 2025 07:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MK3tvPDG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B59BC433B3
	for <linux-fsdevel@vger.kernel.org>; Wed,  4 Jun 2025 07:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749022662; cv=none; b=MpXZx0UQ4PKf0rm0cFYfqX0jy2g55ZMpsZfT6ntmvFxfh2jqw7bwc0PpdN4CJSfkSEDOTGIxYmt7itGb7EgnwfUpDcfyM//dp3JK9eWvSYo2r5tgiNpTivFG5KPcoguuig2HvVqssEo1pci5WawPfKx5d13OX74iXKYd85075iE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749022662; c=relaxed/simple;
	bh=nZBPmTMiwWyctKzV3Y+O8i+0IGtKMwWmcFj12EMXlFI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jbQingtc62vpv6qF/qSb/DYluWn2cGvcLGX/kyDYL5dcl6TiUqEVDoxJd9dMUCMQ4iYGvurcBrvCnsj007buBmeEvl+pdrSIghKSRYMKtmy13tNmSMJxwh9PqcwNISPImCw2rqgBSx9hMo9w5/Nan/Bt5piU7UpsFcnF/ExpAMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MK3tvPDG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0363DC4CEE7;
	Wed,  4 Jun 2025 07:37:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749022662;
	bh=nZBPmTMiwWyctKzV3Y+O8i+0IGtKMwWmcFj12EMXlFI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MK3tvPDGhZC5xOaVS1bGqRlhwGLzCOsgQFMZb1Apv3Hs7/6eDzyQQNZOGSRg/KXD4
	 W2friWcdeEWsyk8QArmrXolrrfDE9eXWsfDHHaWFbxbRjNbWc2r3ueJxQutDfia2Iq
	 Y0sfRya+vAVMRPebWMVP0we2GxQIt9xsVM5zfPvh2SyvZJm08qgJvRY+vacr2vSvLm
	 NbcCBfhdJhU4VCUFdCaPS4soVSWfhPWKR/LP/liCbMFJzhyR4wcoMASv16q5eD5Euv
	 wqW+D0u6EcMfEz8NqNTw4EpeAY9QOkpaJUDvKg20+3H8w2Xsc7G1cfNojCLtldKXmU
	 Yayoe47BBRy8Q==
Date: Wed, 4 Jun 2025 09:37:38 +0200
From: Christian Brauner <brauner@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, 
	Linus Torvalds <torvalds@linux-foundation.org>, Jan Kara <jack@suse.cz>, Jeff Layton <jlayton@kernel.org>, 
	Amir Goldstein <amir73il@gmail.com>
Subject: Re: [PATCH 1/5] fs/fhandle.c: fix a race in call of
 has_locked_children()
Message-ID: <20250604-heilkraft-befragen-951ceb9a673b@brauner>
References: <20250603231500.GC299672@ZenIV>
 <20250603231632.GA145532@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250603231632.GA145532@ZenIV>

On Wed, Jun 04, 2025 at 12:16:32AM +0100, Al Viro wrote:
> may_decode_fh() is calling has_locked_children() while holding no locks.
> That's an oopsable race...
> 
> The rest of the callers are safe since they are holding namespace_sem and
> are guaranteed a positive refcount on the mount in question.
> 
> Rename the current has_locked_children() to __has_locked_children(), make
> it static and switch the fs/namespace.c users to it.
> 
> Make has_locked_children() a wrapper for __has_locked_children(), calling
> the latter under read_seqlock_excl(&mount_lock).
> 
> Fixes: 620c266f3949 ("fhandle: relax open_by_handle_at() permission checks")
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---

Reviewed-by: Christian Brauner <brauner@kernel.org>


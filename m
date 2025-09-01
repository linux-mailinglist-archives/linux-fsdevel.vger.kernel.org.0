Return-Path: <linux-fsdevel+bounces-59808-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BB451B3E1A8
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Sep 2025 13:34:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D21647A946E
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Sep 2025 11:32:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F25CB3148D2;
	Mon,  1 Sep 2025 11:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ONedFjEo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E70D3101CD
	for <linux-fsdevel@vger.kernel.org>; Mon,  1 Sep 2025 11:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756726457; cv=none; b=HECqbyhJJ3YdAkjDFfyGPo8JNx6BVHMaJMo+gXOAkzY8WvzMku3oOq23+ieSqD0zm5/+94T7V4PzYmhISrgtiR8EiYMyUxtIajprUyekESd+zaZL8feyvqSs8V3R1eaZgByIXUYjKuDJX2sdf6HZA48lVC7TgxhRsaNjXz/O7p8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756726457; c=relaxed/simple;
	bh=lxZYtRm1xVPBSNypQYEq+T74M+eh2kYTCZgae+STRMA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pn/zqcpxXNn9evowVxajHLx4vjT2BmwqSIHk/ul/istXQNtdeypuKSuYvhO7IVDUMiIkrxTKf8+3VR7HJsPPmCP6bYXOV4n76SKTmoS4aAfGb6vupVAzkTIsfBoEICt4D2IsvdZSVM8TBSEOy0tdcQ+JM3Nzxne8YWp/JVHe1ak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ONedFjEo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5448C4CEF0;
	Mon,  1 Sep 2025 11:34:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756726455;
	bh=lxZYtRm1xVPBSNypQYEq+T74M+eh2kYTCZgae+STRMA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ONedFjEoBp+h3BKwkxQ6apRYL8AZD3R3fb49C6QIu8vG/Tv2JnONgVT/7/9OpzZ4U
	 ZXVn96CXIO3PJg5Nn2OdhzSE/SK4DvXUeJx84RJajjH4At6K0lnmk+5YPCRB1DsPVv
	 yR8P2T4QFI5W+CNkA7otSVig4kxgmCy/cXg+tg3tplebR1BynbSWardr8pIIwNrOkj
	 lqWcAXH/IJPQCnlTtxMlOsRQ0MfD1FkmzqDQwynZnHUHCUcSKZpm7Bx/TLVhAmuYbg
	 AlSuZqzUc2R/ivl0md/LaVHVupagQ94aRZUY1jCMamBtnPjO1OiyR+CLdrxvvlTHTX
	 KPjBOzEuw7DAw==
Date: Mon, 1 Sep 2025 13:34:12 +0200
From: Christian Brauner <brauner@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, jack@suse.cz, 
	torvalds@linux-foundation.org
Subject: Re: [PATCH v2 26/63] do_new_mount_rc(): use __free() to deal with
 dropping mnt on failure
Message-ID: <20250901-kopftuch-gechartert-32285d69d946@brauner>
References: <20250828230706.GA3340273@ZenIV>
 <20250828230806.3582485-1-viro@zeniv.linux.org.uk>
 <20250828230806.3582485-26-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250828230806.3582485-26-viro@zeniv.linux.org.uk>

On Fri, Aug 29, 2025 at 12:07:29AM +0100, Al Viro wrote:
> do_add_mount() consumes vfsmount on success; just follow it with
> conditional retain_and_null_ptr() on success and we can switch
> to __free() for mnt and be done with that - unlock_mount() is
> in the very end.
> 
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---

Reviewed-by: Christian Brauner <brauner@kernel.org>


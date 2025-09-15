Return-Path: <linux-fsdevel+bounces-61378-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AB66B57BA3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Sep 2025 14:46:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D1411A2497A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Sep 2025 12:47:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56D4C30AAC4;
	Mon, 15 Sep 2025 12:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lqFJoy4q"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1D9E1A23A4;
	Mon, 15 Sep 2025 12:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757940350; cv=none; b=J5UPHND0iGYDBrf5o4bQVwTTTiVgHDrOePmZ3DibUdrYO9gbY1eOYhFtw3qeev+7zhUk5uakIJCXL8D0KuatiQbHTEhwEcduJ2q383GwYtg42M7M6oy9QljmR3JfwONtHFZywwrmmNnEJUiqOQEIfP5DtCK6BdXz2/mPR2qeDu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757940350; c=relaxed/simple;
	bh=/jis6g3u9Um8NqJcdzrQNxKN4gSAYL97cW6na3sL4bE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AF/i5etxFtWFxy+y0fIeyrczkAgHox7nIYJU10qy3/yKE2zzvCi/D06Sjck2FjIWrJ5DnnD3Pkr2SDmoKUrO3NzlIDi9GpOckmkNdoqZa7s0x3BFYe/stHLPML3j0f+HiNWjw15Sp+rXJbKTg45zyMRudC/FKR//2wy5k2EChes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lqFJoy4q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98D9AC4CEF5;
	Mon, 15 Sep 2025 12:45:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757940350;
	bh=/jis6g3u9Um8NqJcdzrQNxKN4gSAYL97cW6na3sL4bE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lqFJoy4qHmHW1B9bTkBRYRplUr4arwCCtKA0KrclJkSBEYjgdpgjhdfyGlTBklP9R
	 tzqFx+2oYwadA8einCB9VsL+eiRLuj6CacV/7WL52c3ViAm6bLa9kdueSLoQ97iMqI
	 JtxGET6tUQC4/+NtNiAk84SpY1DyRE/bvQYkKuqigXUK3uUqlZ8QAFXb/hkEM43VPw
	 lxwievKCT21+tc7JR9g1yfJQ/YgD5GQWGdjy90WKorrrdRKW0Rx10o5bINEJ+h6vBB
	 kMrgKbXutmx4/RSaWGjD0QGiWy02zyttlAOb9avBi3O8tX6+42Et+9bP7yy+gGQj8V
	 tgF/+zwMIAX7A==
Date: Mon, 15 Sep 2025 14:45:46 +0200
From: Christian Brauner <brauner@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, torvalds@linux-foundation.org, 
	jack@suse.cz, neil@brown.name, linux-security-module@vger.kernel.org, 
	dhowells@redhat.com, linkinjeon@kernel.org
Subject: Re: [PATCH 3/6] afs_edit_dir_{add,remove}(): constify qstr argument
Message-ID: <20250915-stechen-drechsel-88e24065902c@brauner>
References: <20250911050149.GW31600@ZenIV>
 <20250911050534.3116491-1-viro@zeniv.linux.org.uk>
 <20250911050534.3116491-3-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250911050534.3116491-3-viro@zeniv.linux.org.uk>

On Thu, Sep 11, 2025 at 06:05:31AM +0100, Al Viro wrote:
> Nothing outside of fs/dcache.c has any business modifying
> dentry names; passing &dentry->d_name as an argument should
> have that argument declared as a const pointer.
> 
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---

Reviewed-by: Christian Brauner <brauner@kernel.org>


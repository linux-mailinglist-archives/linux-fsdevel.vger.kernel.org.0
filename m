Return-Path: <linux-fsdevel+bounces-52371-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BDC7AE2717
	for <lists+linux-fsdevel@lfdr.de>; Sat, 21 Jun 2025 04:38:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 38E133AC0E5
	for <lists+linux-fsdevel@lfdr.de>; Sat, 21 Jun 2025 02:37:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C3D414884C;
	Sat, 21 Jun 2025 02:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z1GoAIoZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55B8C382;
	Sat, 21 Jun 2025 02:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750473483; cv=none; b=QwCG+Ye8FS7V8J5Y58uLcu8XTRp+KtWjcNnc2oeMYRvwvCUXSWAIaKo6H/uEKS7h9oKVG5uVW5RsSFmkrk3cJLCs1BFoiliRWMD08krLubaSRLwspymyiSEcGUl9gXKvVEYl3mF6BMyeQ9mTlXI1gcydCmA61iJUwY6oI9D86/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750473483; c=relaxed/simple;
	bh=BRshq0Sw3kdyROGLHlU0T9SNOnO7vor8RQIBZU60VcI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rqa2zLtXWZg/KZM3nqwYl+I7IcstQ4uzDxCqrlpkB8QusLvRfg/Qms8gk3xOXXUhsNHA7YseypHN3eStAfmxBCkRrNXH8ztkFRqCd+snBcaRSsULpA2W6O61Ed6zSzAudsRxY/uS8j0sYJ7kj51VZsPSVQfCCxtuN7KVaMwsqUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z1GoAIoZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4332C4CEE3;
	Sat, 21 Jun 2025 02:38:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750473482;
	bh=BRshq0Sw3kdyROGLHlU0T9SNOnO7vor8RQIBZU60VcI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Z1GoAIoZjvbLrWnTF8AbEJ+PwW58agRljs6lqp1FNO+XWVqzsMpWtF69E91L6ulXm
	 VaG3P/Nzu1mWIWnsyD9Cmx6JW0WI7LCzJ4bI/mEz9+eWtGYIrBFeBN8Zp4SdO6LmD2
	 tZOX3OPaXB1RRIkNn4eTvvZRzvnqPY7REQIURgStU1g0DftKKMA0o9Omx2hmhKo+9r
	 0F+UqqJ/mZNn7A4kAyU4jyXzaNY9Zb3gAfE0eRJ+FxzXZaS9SILoWaLnY52Bb+vHZo
	 mKiInqaewUo6oSMTMc6JDpcr24mxwrFq9Vm/SfvcZY3+GmgjTSIHF4EjYKnJoHcbZ2
	 YHNwr50LAyD/Q==
Date: Fri, 20 Jun 2025 16:38:01 -1000
From: Tejun Heo <tj@kernel.org>
To: Christian Brauner <brauner@kernel.org>
Cc: Song Liu <song@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	bpf@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org,
	kernel-team@meta.com, andrii@kernel.org, eddyz87@gmail.com,
	ast@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev,
	viro@zeniv.linux.org.uk, jack@suse.cz, kpsingh@kernel.org,
	mattbobrowski@google.com, amir73il@gmail.com,
	daan.j.demeyer@gmail.com
Subject: Re: [PATCH bpf-next 1/4] kernfs: Add __kernfs_xattr_get for RCU
 protected access
Message-ID: <aFYbCVRZyyoOXYa-@slm.duckdns.org>
References: <20250618233739.189106-1-song@kernel.org>
 <20250618233739.189106-2-song@kernel.org>
 <20250619-kaulquappen-absagen-27377e154bc0@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250619-kaulquappen-absagen-27377e154bc0@brauner>

On Thu, Jun 19, 2025 at 12:01:19PM +0200, Christian Brauner wrote:
> From bdc53435a1cd5c456dc28d8239eff0e7fa4e8dda Mon Sep 17 00:00:00 2001
> From: Christian Brauner <brauner@kernel.org>
> Date: Thu, 19 Jun 2025 11:50:26 +0200
> Subject: [PATCH] kernfs: remove iattr_mutex
> 
> All allocations of struct kernfs_iattrs are serialized through a global
> mutex. Simply do a racy allocation and let the first one win. I bet most
> callers are under inode->i_rwsem anyway and it wouldn't be needed but
> let's not require that.
> 
> Signed-off-by: Christian Brauner <brauner@kernel.org>

Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun


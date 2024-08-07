Return-Path: <linux-fsdevel+bounces-25283-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 18F3294A670
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Aug 2024 12:56:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E85A5B2C68E
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Aug 2024 10:47:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A5581E2863;
	Wed,  7 Aug 2024 10:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YAIwRnrj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 971F01B32B3;
	Wed,  7 Aug 2024 10:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723027600; cv=none; b=F9fEAoqggrWkcugysx+bWC145/zNet0A46JaUGx9KNBAVNZizTPW3Y3tgXAzgg84v6T2fmPBZpRXaTz83hj28QDsBIhb5q4zYxzdWTjKy0qrYtzsWJ1v5IkLqv1ZWDjJ2iLXrM6AeT7YodGM3Rqycqnd6wTaBy0Bqf6qlkHBki4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723027600; c=relaxed/simple;
	bh=VwxkjHBFepf1G3cbF2M1sec1EMk3D2TOmjaodOriwxE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JFDAb+ldcOcLlGc12jGdrXLgEJ6KgBOxgexKLkJslUkCyhhUewvulOSScjBNST01etpGPTzdd30JH29/X67nbxX6BB8YG9AmrJnP1+K72VowQeeutJbuROxijOD3OGz+C76mSVrjo+U8uYXXzZ4ZfBTWs8cxeCHzEY3Ri1LT9iE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YAIwRnrj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29B3CC32782;
	Wed,  7 Aug 2024 10:46:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723027600;
	bh=VwxkjHBFepf1G3cbF2M1sec1EMk3D2TOmjaodOriwxE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YAIwRnrjlxyNfdnjaBbiGHbfjKsJLykOPWfEBxAhAwjM0X0QBP1TJxcDUl0RbufLR
	 SD+AUxQtyLiC4AnYUUHp0FND1Hc4cvGGJFbPsY7+nu+vdWSa/g3GevRodIzrMNlE3T
	 znigOMrZ18RcmxYIq890b0ZcAQelVuDM3IgbvsKK2A/QengfBP4cf1kxHlX7nRg/lU
	 aiF/tIBGIz3q9N69SOP5uNRnF8ZN0hgWgrJzOXZDaG9BIPDbI6GpGNdbpKw24fF+ov
	 eneMb26rLq071//VcUQM5H6mcQYXa8ix2rnOQDy/kHHAuTQ6xWqtFfgjEaePjvhgYl
	 wdBA3MYl7x4qg==
Date: Wed, 7 Aug 2024 12:46:35 +0200
From: Christian Brauner <brauner@kernel.org>
To: viro@kernel.org
Cc: linux-fsdevel@vger.kernel.org, amir73il@gmail.com, bpf@vger.kernel.org, 
	cgroups@vger.kernel.org, kvm@vger.kernel.org, netdev@vger.kernel.org, 
	torvalds@linux-foundation.org
Subject: Re: [PATCH 36/39] assorted variants of irqfd setup: convert to
 CLASS(fd)
Message-ID: <20240807-evaluieren-weizen-13209b2053ab@brauner>
References: <20240730050927.GC5334@ZenIV>
 <20240730051625.14349-1-viro@kernel.org>
 <20240730051625.14349-36-viro@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240730051625.14349-36-viro@kernel.org>

On Tue, Jul 30, 2024 at 01:16:22AM GMT, viro@kernel.org wrote:
> From: Al Viro <viro@zeniv.linux.org.uk>
> 
> in all of those failure exits prior to fdget() are plain returns and
> the only thing done after fdput() is (on failure exits) a kfree(),

They could also be converted to:

struct virqfd *virqfd __free(kfree) = NULL;

and then direct returns are usable.

> which can be done before fdput() just fine.
> 
> NOTE: in acrn_irqfd_assign() 'fail:' failure exit is wrong for
> eventfd_ctx_fileget() failure (we only want fdput() there) and once
> we stop doing that, it doesn't need to check if eventfd is NULL or
> ERR_PTR(...) there.
> 
> NOTE: in privcmd we move fdget() up before the allocation - more
> to the point, before the copy_from_user() attempt.
> 
> [trivial conflict in privcmd]
> 
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---

Reviewed-by: Christian Brauner <brauner@kernel.org>


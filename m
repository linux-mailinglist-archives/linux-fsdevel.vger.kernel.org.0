Return-Path: <linux-fsdevel+bounces-50594-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C85A6ACD8B2
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Jun 2025 09:40:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E391D7A62CA
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Jun 2025 07:39:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91F3122B8C2;
	Wed,  4 Jun 2025 07:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eMbqcGbD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEBB517A30A
	for <linux-fsdevel@vger.kernel.org>; Wed,  4 Jun 2025 07:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749022833; cv=none; b=jxiXXiSNdSVl+LDo9Q6QwNscmbvYKB6GYC1N71uMgpkbgw2O8jdeVXso7fSAzdGIIJlVZqYLjS1eAGViTbRwC6MrgNTSORRUJ37Dm0/q0oERihgUBsp6jjrpHYZYNSUdFhHiFPFeoaCEXqmiudlgbZuM9fw2CBfl54ih6B8WJl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749022833; c=relaxed/simple;
	bh=H7nS32cvw5dJfhAmIb6vgAeDRFhpmYH+U1QOG947P/g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L+khJe7G7EzmELaG4GiZr70GavazC+APjxTg/bs6nphJ+l0bGgHhmyf5JKeaipRSTE0htIvfgVTorr1BZ1wv1T3xqmZxto2TKNpQBwbsui6rmr45GVRT0ZwEAWJlof7GYrBQj+elcs9DFLWMA3s4aeq6usdB2IosgEfg2P2vm1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eMbqcGbD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B829C4CEE7;
	Wed,  4 Jun 2025 07:40:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749022832;
	bh=H7nS32cvw5dJfhAmIb6vgAeDRFhpmYH+U1QOG947P/g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eMbqcGbDTDwU2WKxHBT8IrGfEodur41iMog6RYSPKVQESNHh4bD1O6/9gTOzDf6XB
	 qKLeZ0gKWNNgm+rVJvQqEoDjgPJZfQWGDYQf/QabLpEwJy9Kqxoh+f6bNOyF/t/yvR
	 eCDT06G1T6Au37/fxHdUZ8bRgFiTz/BpEoG3GwA+NCh8xrQn6QmkbRCbcvj+MQE4vt
	 3wa8z01xoVWnujyx6oQkI0QKCSjTrZa4fBX+LMsaoEOapSvqhtZEH9/EKp6wQDHZE9
	 J2y4U2ggt8P+tlgVN/qar6EZVk4hIq6djN3rUr7lSeaXvdEtaBpkLlF256UFaLkVty
	 YZV0KAiKPCiAA==
Date: Wed, 4 Jun 2025 09:40:28 +0200
From: Christian Brauner <brauner@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, 
	Linus Torvalds <torvalds@linux-foundation.org>, Jan Kara <jack@suse.cz>, Kazuma Kondo <kazuma-kondo@nec.com>
Subject: Re: [PATCH 5/5] fs: allow clone_private_mount() for a path on real
 rootfs
Message-ID: <20250604-vorrang-wandmalerei-60d109f72d4c@brauner>
References: <20250603231500.GC299672@ZenIV>
 <20250603232011.GE145532@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250603232011.GE145532@ZenIV>

On Wed, Jun 04, 2025 at 12:20:11AM +0100, Al Viro wrote:
> From: =?UTF-8?q?KONDO=20KAZUMA=28=E8=BF=91=E8=97=A4=E3=80=80=E5=92=8C?=
>  =?UTF-8?q?=E7=9C=9F=29?= <kazuma-kondo@nec.com>
> 
> Mounting overlayfs with a directory on real rootfs (initramfs)
> as upperdir has failed with following message since commit
> db04662e2f4f ("fs: allow detached mounts in clone_private_mount()").
> 
>   [    4.080134] overlayfs: failed to clone upperpath
> 
> Overlayfs mount uses clone_private_mount() to create internal mount
> for the underlying layers.
> 
> The commit made clone_private_mount() reject real rootfs because
> it does not have a parent mount and is in the initial mount namespace,
> that is not an anonymous mount namespace.
> 
> This issue can be fixed by modifying the permission check
> of clone_private_mount() following [1].
> 
> Fixes: db04662e2f4f ("fs: allow detached mounts in clone_private_mount()")
> Link: https://lore.kernel.org/all/20250514190252.GQ2023217@ZenIV/ [1]
> Link: https://lore.kernel.org/all/20250506194849.GT2023217@ZenIV/
> Suggested-by: Al Viro <viro@zeniv.linux.org.uk>
> Signed-off-by: Kazuma Kondo <kazuma-kondo@nec.com>
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---

Reviewed-by: Christian Brauner <brauner@kernel.org>


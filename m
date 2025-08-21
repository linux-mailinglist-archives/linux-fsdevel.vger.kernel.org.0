Return-Path: <linux-fsdevel+bounces-58602-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 459ECB2F6DE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 13:38:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 40C3B3B2510
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 11:33:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2EFD30F7E1;
	Thu, 21 Aug 2025 11:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A2FowiJY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18FBF2ECEA6;
	Thu, 21 Aug 2025 11:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755776010; cv=none; b=twLR50gnV5iArZqcJbq/MziIonfn7eNtky3Z8VCRlo3+wftZA2HBqafaU0n444MHLBTlTBE0uPQdaR1laTv9csmzlP9FU5cCYFUn+c4ow1DlUPyaMO3nb7fXo1KPMD1Q03rFj/IQXR9lT5KV95kYdsIEhYkfdYAmXd/Lpq2/4qI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755776010; c=relaxed/simple;
	bh=B8rTdCe32fnAlf3pRZMbFjwBhXTLB9CmXjyTTv7kAe8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JOt+WLCDjSlTYDrq6YiHS2R1OOgWWTRoHzz76BOR6or6u60Mpe9BsBBIchc4O3F3LEGKx48nfWY1/PLffHNpgK75Q1WdMcxc+fkezR25Wi9hlG3eVLGrKwzIlx0zD8WCqvkMBguYFrkz8fSmt7mR2zz4YYlujh3Bwxzsy7CuoFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A2FowiJY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BC59C4CEEB;
	Thu, 21 Aug 2025 11:33:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755776009;
	bh=B8rTdCe32fnAlf3pRZMbFjwBhXTLB9CmXjyTTv7kAe8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=A2FowiJYmXzZjNOchIWmCzhIbm6lJPaQpcEtlhfXcibR8YyBy2hT7MgP91nIG4TW0
	 /IDixsssLZDK0DgkPEEt0MejsQ1C34zXFEj7ETxGnYMPlbgU0LwQ7UTI1LJJYjtoeb
	 ji2YijyTpiz2zSfUrKFnK7Em/38UOaO8Gbj0c7XgUfbqo+E9zD1MPaUGU/An5TMJUe
	 U/jSuuUrhsEhGHww6MxaZcXSLk06ODbFjr1SP+8ReL8MZSBVRjHfxR4us6nCD5ABqu
	 woiCmLbOg4hhjYLdZh5iPHzNx9Dc9VlH8ZEURd+mpercWBFDgQkzPHoncb4qEC+UkR
	 U++WM5wfOokDg==
Date: Thu, 21 Aug 2025 13:33:24 +0200
From: Christian Brauner <brauner@kernel.org>
To: Askar Safin <safinaskar@zohomail.com>
Cc: Aleksa Sarai <cyphar@cyphar.com>, Alejandro Colomar <alx@kernel.org>, 
	"Michael T. Kerrisk" <mtk.manpages@gmail.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Jan Kara <jack@suse.cz>, "G. Branden Robinson" <g.branden.robinson@gmail.com>, 
	linux-man <linux-man@vger.kernel.org>, linux-api <linux-api@vger.kernel.org>, 
	linux-fsdevel <linux-fsdevel@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, 
	David Howells <dhowells@redhat.com>
Subject: Re: [PATCH v3 09/12] man/man2/open_tree.2: document "new" mount API
Message-ID: <20250821-adler-beute-47d721cde8a3@brauner>
References: <20250809-new-mount-api-v3-0-f61405c80f34@cyphar.com>
 <20250809-new-mount-api-v3-9-f61405c80f34@cyphar.com>
 <198cc623944.11ea2eb5d86377.2604785241030508275@zohomail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <198cc623944.11ea2eb5d86377.2604785241030508275@zohomail.com>

On Thu, Aug 21, 2025 at 03:27:26PM +0400, Askar Safin wrote:
> man open_tree says:
> > mount propagation
> > (as described in
> > .BR mount_namespaces (7))
> > will not be applied to bind-mounts created by
> > .BR open_tree ()
> > until the bind-mount is attached with
> > .BR move_mount (2),
> 
> It seems this is wrong, because this commit exists: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=06b1ce966e3f8bfef261c111feb3d4b33ede0cd8 .
> I'm not sure about this. (I didn't test this.)

No, it's correct. I reverted this because it broke userspace that relies
on this behavior.


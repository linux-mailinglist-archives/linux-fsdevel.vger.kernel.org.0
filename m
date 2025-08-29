Return-Path: <linux-fsdevel+bounces-59638-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 76BD7B3B7FB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Aug 2025 12:00:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1DF747A58A9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Aug 2025 09:58:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A0CD2877DA;
	Fri, 29 Aug 2025 09:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NcPTPWCS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E493F2638AF
	for <linux-fsdevel@vger.kernel.org>; Fri, 29 Aug 2025 09:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756461599; cv=none; b=DRpC60n4phcqwTS8WgTrR5tRm2w1wHlZDkfwz9kxoD0T+nN2MN8OI9oCyJJcY/Yzla6krWddxNHUJTeZI+JxXA6Xp1dgakba2nyWEmfIegSWaX0Ivf+tBccPgqeBPyanzxg3MCmcqR0oibec4F+GMGvd/vN5PWeVXRp6hhC0ROE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756461599; c=relaxed/simple;
	bh=DhzWxB4ykgCI/W4uDnfZR9AmExODLn32TdImdTtHBd4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HJkh1xJ21gw23ezPaKmc1ffplqdusRLzDVoJgXutP0x8K9100M+9YFWWCEP4zpKR0/1DaQMRhg7/mJQEhpuSWXO7YRV+sE6FaLSNt7WR9Ld4ire84G3ST3AVEmv37HpZIMKmmdYt4sXQVGYLW57S2bPa8tji+WHNiMvv6aFMgZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NcPTPWCS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49B3EC4CEF0;
	Fri, 29 Aug 2025 09:59:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756461598;
	bh=DhzWxB4ykgCI/W4uDnfZR9AmExODLn32TdImdTtHBd4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NcPTPWCSE6GkPFzFxN0a36xIlWG1Tx0cwUW5Ka3hZIApdcwdVq2HeBhta85IwRJ5D
	 7GuoZtjrRJrTVL2VyN8fH+B7Hx81bn9ly0QRpUQABHHDRcT61k8du9IlKJPMLMmQ2r
	 QO3WUW5rx+sDJGlxk1ITcCHjvo5h3zqOWHSpBN+cNI4TvK5ewmvY811EuON4HKso7k
	 X8WEJ6E6RmEGkXIqYhjDuQt8KkhP/CJD8X0zV/Bt5ki4PYGGkHAKMu3z+gzZ3PVGkn
	 2agu4oAKn5+K8JRVwoO1FQpmLtG+Ob9qh0jy4oi/xk3KAvqUfQnxbVpe4yvvhtymY4
	 ESqEVJWUL7gaQ==
Date: Fri, 29 Aug 2025 11:59:55 +0200
From: Christian Brauner <brauner@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
	linux-fsdevel@vger.kernel.org, jack@suse.cz
Subject: Re: [60/63] setup_mnt(): primitive for connecting a mount to
 filesystem
Message-ID: <20250829-achthundert-kollabieren-ee721905a753@brauner>
References: <20250828230706.GA3340273@ZenIV>
 <20250828230806.3582485-1-viro@zeniv.linux.org.uk>
 <20250828230806.3582485-61-viro@zeniv.linux.org.uk>
 <CAHk-=wgZEkSNKFe_=W=OcoMTQiwq8j017mh+TUR4AV9GiMPQLA@mail.gmail.com>
 <20250829001109.GB39973@ZenIV>
 <CAHk-=wg+wHJ6G0hF75tqM4e951rm7v3-B5E4G=ctK0auib-Auw@mail.gmail.com>
 <20250829060306.GC39973@ZenIV>
 <20250829060522.GB659926@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250829060522.GB659926@ZenIV>

On Fri, Aug 29, 2025 at 07:05:22AM +0100, Al Viro wrote:
> Take the identical logics in vfs_create_mount() and clone_mnt() into
> a new helper that takes an empty struct mount and attaches it to
> given dentry (sub)tree.
> 
> Should be called once in the lifetime of every mount, prior to making
> it visible in any data structures.
> 
> After that point ->mnt_root and ->mnt_sb never change; ->mnt_root
> is a counting reference to dentry and ->mnt_sb - an active reference
> to superblock.
> 
> Mount remains associated with that dentry tree all the way until
> the call of cleanup_mnt(), when the refcount eventually drops
> to zero.
> 
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---

Is this supposed to be the v3? I'm confused what I need to be looking
at since it's a reply to v2 and some earlier review comments...


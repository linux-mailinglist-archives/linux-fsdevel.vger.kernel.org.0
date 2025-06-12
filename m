Return-Path: <linux-fsdevel+bounces-51447-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C9D5AD6FC2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Jun 2025 14:10:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 19ABC1787EC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Jun 2025 12:10:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4F2922D4C3;
	Thu, 12 Jun 2025 12:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pLBPk4UB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 195E9135A53
	for <linux-fsdevel@vger.kernel.org>; Thu, 12 Jun 2025 12:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749730197; cv=none; b=c2wOygda2bShCxkDN27TKVh50eaZ1XNzWN9lTKE7ycf44CxGFOvpeJNFPRspfj4Nb6SyEybpYqLxEu+hF/66m/atPVJNW2NxyrmEEJ1eM7DO7Y4pWWc6gnU2t2c7w6BWKFBNUJmTRn3KGAaeKf6eRZuGIK/BbMBfq2ea6hiDuHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749730197; c=relaxed/simple;
	bh=63MpfyGWn21ZIyEkD4Rghtx10lZU5FG2a41FJYNQw8E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ATKE/jrxUC/6h4kZWgvvm/XmbbicMDcxLq9CPRqx+idmY9lyoQDHue5MAFynuLoSLErHQv6+alJs0AeLCH2iqZhHv/xr/rJOKKfRPremzY2oy6DloQ6XCitfVq5A8vh9FPh/Q4MawdwEztiz4xQaZsTEEmUibVhtzfbXPPu0mq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pLBPk4UB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 901FAC4CEEA;
	Thu, 12 Jun 2025 12:09:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749730196;
	bh=63MpfyGWn21ZIyEkD4Rghtx10lZU5FG2a41FJYNQw8E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pLBPk4UBF36nDQjemC5Hg2TmiYmK3bPtgx7K8SGsESeCKDNgqzhgVFUz4JqQoLyER
	 w3Ue0Q/VLvx62+7nlYNEHw2DhARi+EtnuhN67sEz6Ilkyxuht+n3ORqyDASA0smw2j
	 7JvNgRJsgjgLQ04SanvSE9dBtRHU1VCPtO/b40XGmMt+6Snuodsxyg8bxV8NhnPanN
	 1DyQKtXUE6ErlYqksYVHaKUhFyBQ6Vfw9nYMh46kwOyf958Cc2wvZrEUnE1wYF7pQN
	 bOC1KeR6RzD2XwSo5OV4yBBx2tiinrGaW93CFWq9aJJG0CxCUFyHBjULKx7OQBgQUj
	 QKNdRsrGledxA==
Date: Thu, 12 Jun 2025 14:09:53 +0200
From: Christian Brauner <brauner@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, Jan Kara <jack@suse.cz>, 
	Linus Torvalds <torvalds@linux-foundation.org>, Eric Biederman <ebiederm@xmission.com>
Subject: Re: [PATCHES][RFC][CFR] mount-related stuff
Message-ID: <20250612-reden-euren-daa9822438c6@brauner>
References: <20250610081758.GE299672@ZenIV>
 <20250611-ehrbaren-nahbereich-7bb253d46a94@brauner>
 <20250611175136.GM299672@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250611175136.GM299672@ZenIV>

On Wed, Jun 11, 2025 at 06:51:36PM +0100, Al Viro wrote:
> On Wed, Jun 11, 2025 at 12:31:54PM +0200, Christian Brauner wrote:
> > On Tue, Jun 10, 2025 at 09:17:58AM +0100, Al Viro wrote:
> > > 	The next pile of mount massage; it will grow - there will be
> > > further modifications, as well as fixes and documentation, but this is
> > > the subset I've got in more or less settled form right now.
> > > 
> > > 	Review and testing would be very welcome.
> > > 
> > > 	This series (-rc1-based) sits in
> > > git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git #work.mount
> > > individual patches in followups.
> > > 
> > > 	Rough overview:
> > > 
> > > Part 1: trivial cleanups and helpers:
> > > 
> > > 1) copy_tree(): don't set ->mnt_mountpoint on the root of copy
> > > 	Ancient bogosity, fortunately harmless, but confusing.
> > > 2) constify mnt_has_parent()
> > > 3) pnode: lift peers() into pnode.h
> > > 4) new predicate: mount_is_ancestor()
> > > 	Incidentally, I wonder if the "early bail out on move
> > > of anon into the same anon" was not due to (now eliminated)
> > > corner case in loop detection...  Christian?
> > 
> > No, that wasn't the reason. When moving mounts between anonymous mount
> > namespaces I wanted a very simple visual barrier that moving mounts into
> > the same anonymous mount namespace is not possible.
> > 
> > I even mentioned in the comment that this would be caught later but that
> > I like it being explicitly checked for.
> 
> OK...  AFAICS, the way those tests were done it would not be caught later.
> At the merge time loop detection had been the same as in mainline now:
>         for (; mnt_has_parent(p); p = p->mnt_parent)
> 		if (p == old)
> 			goto out;
> and that will never reach that goto out if mnt_has_parent(old) is false.
> The early bailout avoided that problem, thus the question if that's where
> it came from...

Yeah, I mean doing it your way is obviously fine and correct.


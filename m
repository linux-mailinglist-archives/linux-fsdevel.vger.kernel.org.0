Return-Path: <linux-fsdevel+bounces-25586-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57D9694DA98
	for <lists+linux-fsdevel@lfdr.de>; Sat, 10 Aug 2024 06:06:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1447D283AC1
	for <lists+linux-fsdevel@lfdr.de>; Sat, 10 Aug 2024 04:06:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FB3D13B2AF;
	Sat, 10 Aug 2024 04:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E962WysW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC73F4409;
	Sat, 10 Aug 2024 04:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723262781; cv=none; b=JUwfu6nsLRLz5AkwN8DVbouhqGXL9IR4yDU1Pb/fueJV7QPKCXTBruR8PV3oXTYAxdR1Xl4jjlc3EmP7IWtvfinjtVV1MBSoSEpz6MdNuuNXsrenQCqfXinXNKK6Gt9dIY5+fbU0rgUsq0PN8s+82n5fdFCveKjNeaQFbEdNoJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723262781; c=relaxed/simple;
	bh=SOtjsHWHRwe769zIY4hqS+ETtzzThW1sY7Ow+VYY1gs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mU4ET8q/+Y20Fpmp6M149pMKAkPfsyaGSUAN8SkTOx0X/NhRBaqXPFU8akCDxSQ5JfozPmWFjdeybbY7rBIBOPIgz9jQgcxRuEQvDinzDnwO8wHaErVx/3GWSccrbKgaFkzsr00pN2PfRxpCIwUuR49gZjvWFrrlZl34L3oSKDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E962WysW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 341D4C32781;
	Sat, 10 Aug 2024 04:06:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723262781;
	bh=SOtjsHWHRwe769zIY4hqS+ETtzzThW1sY7Ow+VYY1gs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=E962WysW/7ySwspbABoO0RJDoRAliGwxCOx6lTfj91l7RBY0US2Q0b4bSZotvPBLK
	 49IfehDaJWhe1Fl64Ie71KIX22EZHac8RRFqsdoapjhZjieTYQtEI9RE3ez15YNl03
	 d8UnB8H5jHyymdLk7167hqDGWisnqBmvCjk2bGpmKyFX84w8maXDBE0+q6vWv5LFLZ
	 l4cwc0fCuKJYpVB5kY4G5/ZK87zQG38tH0hGoe0MG+9rczitjxfIhVb/I2BW3zcgXS
	 ms/l5Y8oSzbS4bfZjlocTDY6mGdtaywSYcuNlgVy+EeLcG/yI5H3QNTxxJZ8Y4mVlO
	 JIhpaWHQN23MA==
Date: Fri, 9 Aug 2024 21:06:20 -0700
From: Kees Cook <kees@kernel.org>
To: Brian Mak <makb@juniper.net>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Oleg Nesterov <oleg@redhat.com>,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH v3] binfmt_elf: Dump smaller VMAs first in ELF cores
Message-ID: <202408092104.FCE51021@keescook>
References: <036CD6AE-C560-4FC7-9B02-ADD08E380DC9@juniper.net>
 <172300808013.2419749.16446009147309523545.b4-ty@kernel.org>
 <D1EFC173-A7A8-4B0E-8AF6-34AB1A65D2DB@juniper.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <D1EFC173-A7A8-4B0E-8AF6-34AB1A65D2DB@juniper.net>

On Sat, Aug 10, 2024 at 12:52:16AM +0000, Brian Mak wrote:
> On Aug 6, 2024, at 10:21 PM, Kees Cook <kees@kernel.org> wrote:
> > 
> > On Tue, 06 Aug 2024 18:16:02 +0000, Brian Mak wrote:
> >> Large cores may be truncated in some scenarios, such as with daemons
> >> with stop timeouts that are not large enough or lack of disk space. This
> >> impacts debuggability with large core dumps since critical information
> >> necessary to form a usable backtrace, such as stacks and shared library
> >> information, are omitted.
> >> 
> >> We attempted to figure out which VMAs are needed to create a useful
> >> backtrace, and it turned out to be a non-trivial problem. Instead, we
> >> try simply sorting the VMAs by size, which has the intended effect.
> >> 
> >> [...]
> > 
> > While waiting on rr test validation, and since we're at the start of the
> > dev cycle, I figure let's get this into -next ASAP to see if anything
> > else pops out. We can drop/revise if there are problems. (And as always,
> > I will add any Acks/Reviews/etc that show up on the thread.)
> > 
> > Applied to for-next/execve, thanks!
> > 
> > [1/1] binfmt_elf: Dump smaller VMAs first in ELF cores
> >      https://urldefense.com/v3/__https://git.kernel.org/kees/c/9c531dfdc1bc__;!!NEt6yMaO-gk!FK3UfXVndoYpve8Y7q7vacIoHOrTj2nJgSJbugqUB5LfciKy0_Xvit9aXz_XCWlXHpdRQO2ArP0$
> 
> Thanks, Kees! And, thanks Linus + Eric for taking the time to comment on
> this.
> 
> Regarding the rr tests, it was not an easy task to get the environment
> set up to do this, but I did it and was able to run the tests. The rr
> tests require a lot of kernel config options and there's no list
> documenting what's needed anywhere...

Thanks for suffering through that!

> All the tests pass except for the sioc and sioc-no-syscallbuf tests.
> However, these test failures are due to an incompatibility with the
> network adapter I'm using. It seems that it only likes older network
> adapters. I've switched my virtualized network adapter twice now, and
> each time, the test gets a bit further than the previous time. Will
> continue trying different network adapters until something hopefully
> works. In any case, since this error isn't directly related to my
> changes and the rest of the tests pass, then I think we can be pretty
> confident that this change is not breaking rr.

Perfect! Okay, we'll keep our eyes open for any reports of breakage. :)

-Kees

-- 
Kees Cook


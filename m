Return-Path: <linux-fsdevel+bounces-45571-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 86F5FA797B4
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Apr 2025 23:34:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EFAAD189432D
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Apr 2025 21:34:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A5131F4282;
	Wed,  2 Apr 2025 21:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="PfNch3LY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CD6C15CD46;
	Wed,  2 Apr 2025 21:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743629666; cv=none; b=fY+QjZ8eY9/5p7gLQor12JK1w+BSRDUXaa++u65GlkT/d05BJNalHDO9cx/+jyCk6hB/NHkDGksbAFznkJMHHo2jc1yxfIkkzAIGXZQOqpf3YcqzoRQbTAx72rSYgGh6bBU4/DhaALrn72mgeGBcIi+GDmDYTVxc5G8piqX5BrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743629666; c=relaxed/simple;
	bh=WiyRp07KRjQvFYrPtvP7TNMhK2CN2NkL0Ce4/5spsYQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R2lFPj7fk7zP2nEp1hBz3fQgttZcNcuEhMILuJi7lk7mfw0cjj/LIro6Ms6+ynTnfOkNQoFattBxmd5+m+3qsel5ZsVGcthpmJsIzcccWxxf7OrT0KdFoddj2CFSpmbOhVTBV2WDeHibiQ9hgNSuJKouyYUr0dRV05sUlTUHe3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=PfNch3LY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51E15C4CEDD;
	Wed,  2 Apr 2025 21:34:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1743629665;
	bh=WiyRp07KRjQvFYrPtvP7TNMhK2CN2NkL0Ce4/5spsYQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PfNch3LYn76uLKsJHBMZg5CuqcqLzu4IlRLHji4v/M1WEetBHFdys/GZfvCJ6qx4y
	 6c1lnGmCD84i0+ROtWYIpE+9gUfrRa0H8Ybmj8kxr0VrJlO2YUbM378YqjiGSCs+MR
	 Xmn6VlyE97/QeEyc9UTBrl7rX1enSOX1FRnq5ADU=
Date: Wed, 2 Apr 2025 22:32:58 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: cve@kernel.org, edumazet@google.com, ematsumiya@suse.de,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-net@vger.kernel.org, sfrench@samba.org, smfrench@gmail.com,
	wangzhaolong1@huawei.com, zhangchangzhong@huawei.com
Subject: Re: Fwd: [PATCH][SMB3 client] fix TCP timers deadlock after rmmod
Message-ID: <2025040207-yippee-unlearned-4b1c@gregkh>
References: <2025040256-spindle-cornea-60ec@gregkh>
 <20250402205039.9933-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250402205039.9933-1-kuniyu@amazon.com>

On Wed, Apr 02, 2025 at 01:50:05PM -0700, Kuniyuki Iwashima wrote:
> From: Greg KH <gregkh@linuxfoundation.org>
> Date: Wed, 2 Apr 2025 21:28:51 +0100
> > On Wed, Apr 02, 2025 at 01:22:11PM -0700, Kuniyuki Iwashima wrote:
> > > From: Greg KH <gregkh@linuxfoundation.org>
> > > Date: Wed, 2 Apr 2025 21:15:58 +0100
> > > > On Wed, Apr 02, 2025 at 01:09:19PM -0700, Kuniyuki Iwashima wrote:
> > > > > From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > > > Date: Wed, 2 Apr 2025 16:18:37 +0100
> > > > > > On Wed, Apr 02, 2025 at 05:15:44PM +0800, Wang Zhaolong wrote:
> > > > > > > > On Wed, Apr 02, 2025 at 12:49:50PM +0800, Wang Zhaolong wrote:
> > > > > > > > > Yes, it seems the previous description might not have been entirely clear.
> > > > > > > > > I need to clearly point out that this patch, intended as the fix for CVE-2024-54680,
> > > > > > > > > does not actually address any real issues. It also fails to resolve the null pointer
> > > > > > > > > dereference problem within lockdep. On top of that, it has caused a series of
> > > > > > > > > subsequent leakage issues.
> > > > > > > > 
> > > > > > > > If this cve does not actually fix anything, then we can easily reject
> > > > > > > > it, please just let us know if that needs to happen here.
> > > > > > > > 
> > > > > > > > thanks,
> > > > > > > > 
> > > > > > > > greg k-h
> > > > > > > Hi Greg,
> > > > > > > 
> > > > > > > Yes, I can confirm that the patch for CVE-2024-54680 (commit e9f2517a3e18)
> > > > > > > should be rejected. Our analysis shows:
> > > > > > > 
> > > > > > > 1. It fails to address the actual null pointer dereference in lockdep
> > > > > > > 
> > > > > > > 2. It introduces multiple serious issues:
> > > > > > >    1. A socket leak vulnerability as documented in bugzilla #219972
> > > > > > >    2. Network namespace refcount imbalance issues as described in
> > > > > > >      bugzilla #219792 (which required the follow-up mainline fix
> > > > > > >      4e7f1644f2ac "smb: client: Fix netns refcount imbalance
> > > > > > >      causing leaks and use-after-free")
> > > > > > > 
> > > > > > > The next thing we should probably do is:
> > > > > > >    - Reverting e9f2517a3e18
> > > > > > >    - Reverting the follow-up fix 4e7f1644f2ac, as it's trying to fix
> > > > > > >      problems introduced by the problematic CVE patch
> > > > > > 
> > > > > > Great, can you please send patches now for both of these so we can
> > > > > > backport them to the stable kernels properly?
> > > > > 
> > > > > Sent to CIFS tree:
> > > > > https://lore.kernel.org/linux-cifs/20250402200319.2834-1-kuniyu@amazon.com/
> > > > 
> > > > You forgot to add a Cc: stable@ on the patches to ensure that they get
> > > > picked up properly for all stable trees :(
> > > 
> > > Ah sorry, I did the same with netdev.  netdev patches usually do
> > > not have the tag but are backported fine, maybe netdev local rule ?
> > 
> > Nope, that's the "old" way of dealing with netdev patches, the
> > documentation was changed years ago, please always put a cc: stable on
> > it.  Otherwise you are just at the whim of our "hey, I'm board, let's
> > look for Fixes: only tags!" script to catch them, which will also never
> > notify you of failures.
> 
> Good to know that, thanks!
> 
> My concern was that I could spam the list if I respin the patches,
> and incomplete patch could be backported.
> 
> >From stable-kernel-rules.rst, such an accident can be prevented if
> someone points out a problem within 48 hours ?
> 
> For example, if v1 is posted with Cc:stable, and a week later
> v2 is posted, then the not-yet-upstreamed v1 could be backported ?
> 

Anything can be asked to be applied to stable once it is in Linus's
tree, but if you add the cc: stable stuff to the original patch, it will
be done automatically for you.  That's all, I don't see anything about
"48 hours" in that document about submitting patches, that's only in the
-rc review cycle portion of the stable releases, not Linus's releases.

thanks,

greg k-h


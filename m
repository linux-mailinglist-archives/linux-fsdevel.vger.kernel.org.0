Return-Path: <linux-fsdevel+bounces-45557-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4969A7969B
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Apr 2025 22:30:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 19E97171BB1
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Apr 2025 20:30:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEB451F3B82;
	Wed,  2 Apr 2025 20:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="dZ9Mt5uT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E703C1F12EF;
	Wed,  2 Apr 2025 20:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743625819; cv=none; b=HHcptJncbmPN2Req5oK4EufoJO+AgQiV3D/CfGhJxiqDO1GTZBYhwVu6gasWPiMegOwByYToS8zG2V8ZO6VurtEokuyCYahXqaf5fqikQWrioKlCMYaO+Lo/PWmbtftSpzZ516+I9jfg7fSzQVhOEKaQD913Rlc0CsgO9OdX/WM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743625819; c=relaxed/simple;
	bh=L4frJeuLq/Lt6VCxk/O2OjocIX91QfXFH3Bgln6CqsA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AGGky7PAzADbue6xsQE6t3b5ZQeSEJWL+bQEDAANGFkrgE6ZbhQBuflF0lWyOm883+7hbWQ951JvN+Nk9PMZ2a9oWTJUaiA+wOBFVwYNKRkENr+3wtFBUDWZUCU/f11zIgTtCCDOf/aMFJDyoC3Bk5knhfzpQYs5J8EQIjzRf/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=dZ9Mt5uT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62041C4CEDD;
	Wed,  2 Apr 2025 20:30:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1743625818;
	bh=L4frJeuLq/Lt6VCxk/O2OjocIX91QfXFH3Bgln6CqsA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dZ9Mt5uTS0kn4Th4K1TuVXBBjIWu3jPWkfNai96/o+3eFtRcqgTEkebjnUrfpmi9Q
	 q4rcmrLGxiukMx2UrVYg4gg2SbNPAuoJ+d1wxDS6WDoZAkyHHpRKrxL37Z4pHciBaF
	 NGnPUxmPxEybFtYv9OzeLF/OJufT4Wsyf7YlXP0A=
Date: Wed, 2 Apr 2025 21:28:51 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: cve@kernel.org, edumazet@google.com, ematsumiya@suse.de,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-net@vger.kernel.org, sfrench@samba.org, smfrench@gmail.com,
	wangzhaolong1@huawei.com, zhangchangzhong@huawei.com
Subject: Re: Fwd: [PATCH][SMB3 client] fix TCP timers deadlock after rmmod
Message-ID: <2025040256-spindle-cornea-60ec@gregkh>
References: <2025040233-tuesday-regroup-5c66@gregkh>
 <20250402202257.5845-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250402202257.5845-1-kuniyu@amazon.com>

On Wed, Apr 02, 2025 at 01:22:11PM -0700, Kuniyuki Iwashima wrote:
> From: Greg KH <gregkh@linuxfoundation.org>
> Date: Wed, 2 Apr 2025 21:15:58 +0100
> > On Wed, Apr 02, 2025 at 01:09:19PM -0700, Kuniyuki Iwashima wrote:
> > > From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > Date: Wed, 2 Apr 2025 16:18:37 +0100
> > > > On Wed, Apr 02, 2025 at 05:15:44PM +0800, Wang Zhaolong wrote:
> > > > > > On Wed, Apr 02, 2025 at 12:49:50PM +0800, Wang Zhaolong wrote:
> > > > > > > Yes, it seems the previous description might not have been entirely clear.
> > > > > > > I need to clearly point out that this patch, intended as the fix for CVE-2024-54680,
> > > > > > > does not actually address any real issues. It also fails to resolve the null pointer
> > > > > > > dereference problem within lockdep. On top of that, it has caused a series of
> > > > > > > subsequent leakage issues.
> > > > > > 
> > > > > > If this cve does not actually fix anything, then we can easily reject
> > > > > > it, please just let us know if that needs to happen here.
> > > > > > 
> > > > > > thanks,
> > > > > > 
> > > > > > greg k-h
> > > > > Hi Greg,
> > > > > 
> > > > > Yes, I can confirm that the patch for CVE-2024-54680 (commit e9f2517a3e18)
> > > > > should be rejected. Our analysis shows:
> > > > > 
> > > > > 1. It fails to address the actual null pointer dereference in lockdep
> > > > > 
> > > > > 2. It introduces multiple serious issues:
> > > > >    1. A socket leak vulnerability as documented in bugzilla #219972
> > > > >    2. Network namespace refcount imbalance issues as described in
> > > > >      bugzilla #219792 (which required the follow-up mainline fix
> > > > >      4e7f1644f2ac "smb: client: Fix netns refcount imbalance
> > > > >      causing leaks and use-after-free")
> > > > > 
> > > > > The next thing we should probably do is:
> > > > >    - Reverting e9f2517a3e18
> > > > >    - Reverting the follow-up fix 4e7f1644f2ac, as it's trying to fix
> > > > >      problems introduced by the problematic CVE patch
> > > > 
> > > > Great, can you please send patches now for both of these so we can
> > > > backport them to the stable kernels properly?
> > > 
> > > Sent to CIFS tree:
> > > https://lore.kernel.org/linux-cifs/20250402200319.2834-1-kuniyu@amazon.com/
> > 
> > You forgot to add a Cc: stable@ on the patches to ensure that they get
> > picked up properly for all stable trees :(
> 
> Ah sorry, I did the same with netdev.  netdev patches usually do
> not have the tag but are backported fine, maybe netdev local rule ?

Nope, that's the "old" way of dealing with netdev patches, the
documentation was changed years ago, please always put a cc: stable on
it.  Otherwise you are just at the whim of our "hey, I'm board, let's
look for Fixes: only tags!" script to catch them, which will also never
notify you of failures.

thanks,

greg k-h


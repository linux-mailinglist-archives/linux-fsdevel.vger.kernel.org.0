Return-Path: <linux-fsdevel+bounces-45554-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35AB5A7965E
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Apr 2025 22:17:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F072D170D3D
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Apr 2025 20:17:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72AB91F0E4B;
	Wed,  2 Apr 2025 20:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ohven9T5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5D271F03C7;
	Wed,  2 Apr 2025 20:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743625046; cv=none; b=MBZXevEx+y0A30SKEEmwmBcuhoKH2vHxVKjQtibqdolC2cY0tDeb9K4d5dTOB48WSmOTakd/gPDKk8PSufZXv/DaySEJ8vJpg7yg+9WQhEbIDo9W2U4DBA3Uz82f/3iKUsyX1YMegjZ2zLia7GSQNo5Ye21YsFzjqEoopCMQXM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743625046; c=relaxed/simple;
	bh=5wXMy1iTEVmwG+CHMzwtyEKHWRMwlIFCl6N/GqhB6A8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gJcCPK6pkd1QHGvpeP3cMfgMWRrK7s3DiSpUeVQ8mgmnuCqeG9Yw6MtMydwOl4/9vqLv/E+2R2c2TcRnWfZTL0EvmEfpGMO4e91EDpSVnSl5sROgglTlEgs/0KeTGQU3BqUvyknJ6Q/6NLU2R4ZYMwpgwdG6Sy2kINzWYVm99nM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ohven9T5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7076C4CEDD;
	Wed,  2 Apr 2025 20:17:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1743625046;
	bh=5wXMy1iTEVmwG+CHMzwtyEKHWRMwlIFCl6N/GqhB6A8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ohven9T5xPGuF2Yc19Bj7YvBHPiSxr7t3lVEB23ICJzsm1WbWhFKasYdAgirQoqUf
	 wI0ToMFeB4Z03EYUmjIJJhP/bxFigPYZDr8XzTn1T7VDghIKFwpQe50Rhyk+ySv7LD
	 XqXXJA6c/pjqkQRZ2qHjFvhTFSHCh7/43ekI0ObA=
Date: Wed, 2 Apr 2025 21:15:58 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: cve@kernel.org, edumazet@google.com, ematsumiya@suse.de,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-net@vger.kernel.org, sfrench@samba.org, smfrench@gmail.com,
	wangzhaolong1@huawei.com, zhangchangzhong@huawei.com
Subject: Re: Fwd: [PATCH][SMB3 client] fix TCP timers deadlock after rmmod
Message-ID: <2025040233-tuesday-regroup-5c66@gregkh>
References: <2025040248-tummy-smilingly-4240@gregkh>
 <20250402200928.4320-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250402200928.4320-1-kuniyu@amazon.com>

On Wed, Apr 02, 2025 at 01:09:19PM -0700, Kuniyuki Iwashima wrote:
> From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Date: Wed, 2 Apr 2025 16:18:37 +0100
> > On Wed, Apr 02, 2025 at 05:15:44PM +0800, Wang Zhaolong wrote:
> > > > On Wed, Apr 02, 2025 at 12:49:50PM +0800, Wang Zhaolong wrote:
> > > > > Yes, it seems the previous description might not have been entirely clear.
> > > > > I need to clearly point out that this patch, intended as the fix for CVE-2024-54680,
> > > > > does not actually address any real issues. It also fails to resolve the null pointer
> > > > > dereference problem within lockdep. On top of that, it has caused a series of
> > > > > subsequent leakage issues.
> > > > 
> > > > If this cve does not actually fix anything, then we can easily reject
> > > > it, please just let us know if that needs to happen here.
> > > > 
> > > > thanks,
> > > > 
> > > > greg k-h
> > > Hi Greg,
> > > 
> > > Yes, I can confirm that the patch for CVE-2024-54680 (commit e9f2517a3e18)
> > > should be rejected. Our analysis shows:
> > > 
> > > 1. It fails to address the actual null pointer dereference in lockdep
> > > 
> > > 2. It introduces multiple serious issues:
> > >    1. A socket leak vulnerability as documented in bugzilla #219972
> > >    2. Network namespace refcount imbalance issues as described in
> > >      bugzilla #219792 (which required the follow-up mainline fix
> > >      4e7f1644f2ac "smb: client: Fix netns refcount imbalance
> > >      causing leaks and use-after-free")
> > > 
> > > The next thing we should probably do is:
> > >    - Reverting e9f2517a3e18
> > >    - Reverting the follow-up fix 4e7f1644f2ac, as it's trying to fix
> > >      problems introduced by the problematic CVE patch
> > 
> > Great, can you please send patches now for both of these so we can
> > backport them to the stable kernels properly?
> 
> Sent to CIFS tree:
> https://lore.kernel.org/linux-cifs/20250402200319.2834-1-kuniyu@amazon.com/

You forgot to add a Cc: stable@ on the patches to ensure that they get
picked up properly for all stable trees :(

Can you redo them?

thanks,

greg k-h


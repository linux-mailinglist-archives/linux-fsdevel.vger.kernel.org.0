Return-Path: <linux-fsdevel+bounces-9025-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F5E183D16D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Jan 2024 01:24:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D2B5A1C25034
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Jan 2024 00:24:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D52A5EDC;
	Fri, 26 Jan 2024 00:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="NjukxvqJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C12C4C64;
	Fri, 26 Jan 2024 00:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706228640; cv=none; b=RkJOY1pIfbN32Lq1/mX8/7d83MoUEPNSRLPXJ07E5d3mAR+eN/cZe0BLw9nzcWt+6Cwxhn+luRGyfbGUcrup1u9jX8PUTqmwZsIogp6Sqh9qpCL4FFXnz2UBFhzzwrAljNXauGUEpbz0XhYu7UCblYiW2CAZd03kr1U33uJvEN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706228640; c=relaxed/simple;
	bh=1x3A1tyY/z2CMcBEjfjwRQZaFAEYATlyzeNrl/0cQDw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rD7yA/hc1eR7j+ed9LEzOmQMeiED/mWUJdOT82+dnavwuSOVTaFPvCWmneGTJw31JO+iggZ50WJ/ifBYbJhcm+Pz5+jDX65HfaK12S2Yq5hJBHmFUeb6ArO8mjQQvsXVkG+VzL7obpxIOO4qniBzLA2NfdcQ+B3LIX4cWRWujgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=NjukxvqJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61344C433F1;
	Fri, 26 Jan 2024 00:23:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1706228639;
	bh=1x3A1tyY/z2CMcBEjfjwRQZaFAEYATlyzeNrl/0cQDw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NjukxvqJLclq5HF5aare89fbarlB5SwBoq7nG0id5m5r6wPX4p0x05dj+DEbhfikT
	 S4aipo/RHDz1nv66Y8DS94P1x88sf6NRyii80BIQRTHbH04PcK7gO3zJYfEyaclaFN
	 tjE3Epr8jdkta2JU8eHUqT58BUMxvXXObkvkqxDM=
Date: Thu, 25 Jan 2024 16:23:58 -0800
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Joe Damato <jdamato@fastly.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	chuck.lever@oracle.com, jlayton@kernel.org,
	linux-api@vger.kernel.org, brauner@kernel.org, edumazet@google.com,
	davem@davemloft.net, alexander.duyck@gmail.com,
	sridhar.samudrala@intel.com, kuba@kernel.org,
	willemdebruijn.kernel@gmail.com, weiwan@google.com,
	Jonathan Corbet <corbet@lwn.net>,
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nathan Lynch <nathanl@linux.ibm.com>,
	Steve French <stfrench@microsoft.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Jiri Slaby <jirislaby@kernel.org>,
	Julien Panis <jpanis@baylibre.com>, Arnd Bergmann <arnd@arndb.de>,
	Andrew Waterman <waterman@eecs.berkeley.edu>,
	Thomas Huth <thuth@redhat.com>, Palmer Dabbelt <palmer@dabbelt.com>,
	"open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
	"open list:FILESYSTEMS (VFS and infrastructure)" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH net-next v3 3/3] eventpoll: Add epoll ioctl for
 epoll_params
Message-ID: <2024012525-outdoors-district-2660@gregkh>
References: <20240125225704.12781-1-jdamato@fastly.com>
 <20240125225704.12781-4-jdamato@fastly.com>
 <2024012551-anyone-demeaning-867b@gregkh>
 <20240126001128.GC1987@fastly.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240126001128.GC1987@fastly.com>

On Thu, Jan 25, 2024 at 04:11:28PM -0800, Joe Damato wrote:
> On Thu, Jan 25, 2024 at 03:21:46PM -0800, Greg Kroah-Hartman wrote:
> > On Thu, Jan 25, 2024 at 10:56:59PM +0000, Joe Damato wrote:
> > > +struct epoll_params {
> > > +	u64 busy_poll_usecs;
> > > +	u16 busy_poll_budget;
> > > +
> > > +	/* for future fields */
> > > +	u8 data[118];
> > > +} EPOLL_PACKED;
> > 
> > variables that cross the user/kernel boundry need to be __u64, __u16,
> > and __u8 here.
> 
> I'll make that change for the next version, thank you.
> 
> > And why 118?
> 
> I chose this arbitrarily. I figured that a 128 byte struct would support 16
> u64s in the event that other fields needed to be added in the future. 118
> is what was left after the existing fields. There's almost certainly a
> better way to do this - or perhaps it is unnecessary as per your other
> message.
> 
> I am not sure if leaving extra space in the struct is a recommended
> practice for ioctls or not - I thought I noticed some code that did and
> some that didn't in the kernel so I err'd on the side of leaving the space
> and probably did it in the worst way possible.

It's not really a good idea unless you know exactly what you are going
to do with it.  Why not just have a new ioctl if you need new
information in the future?  That's simpler, right?

thanks,

greg k-h


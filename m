Return-Path: <linux-fsdevel+bounces-20324-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A5FC8D1749
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 May 2024 11:32:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 374AD1C230CE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 May 2024 09:32:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1846916936C;
	Tue, 28 May 2024 09:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BcjdhOqQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E9E2168C1B;
	Tue, 28 May 2024 09:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716888760; cv=none; b=Aqeaiz8o0CSgBKZAWs82N0rqARq5WlQB3K21+Ou1AkL9/xi2lxnHK2A1GQ07/4v6wl4gxVRKIZF16VM1wP82kUFs6bGqLl66XmVw6g9WB9VFPRt6XcTvFxWrAdkYW2XGB7KSvzWKmhRLy2sML47j5s1AhtVwTUMXQSU9eTCQz74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716888760; c=relaxed/simple;
	bh=MLCV/GoLW702KDu+5Ueva+3+7n52QjbISOAF+ycWG5E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lwl9Z6aga4HY6ayHlvGSFNNB+hHi0b8yymS+Sgk8mlwv6IcDM0mZPDJQhUbp6IfRqIoQ/cxMMJq8BOUMXSw3AFkZWy9FfCudH8VAAqUEw/3wq4MzcR42G6Hg9jZ23sSqIEqm3NcefX+dniRgSRmjT8Ui0F/q8hx4b+8+WAy2N18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BcjdhOqQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 377D0C3277B;
	Tue, 28 May 2024 09:32:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716888759;
	bh=MLCV/GoLW702KDu+5Ueva+3+7n52QjbISOAF+ycWG5E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BcjdhOqQsWMN764HX66Q2RhSFagJr70TDktgFRzSepPEsgcX6/t1mWUtZnADSaOUx
	 geNHpfGDeJPV5r0j9iI34l2j4o3DvxA1xA3C9pW07lVHhMTFiefAQq41DvQiXURqkY
	 s0bRs3SWyzYiCI8ai/qPFfybOilESLt3nI/Svh/KtE//i/vRR4tKLgc6eHxyr/5tSB
	 iDYwOApDVIzQTkVk1tjbqIonGsvU7GOfmzQB6kMGedwUWiUB4VCJdK3+gAOKZOfJLD
	 QqH3fQnbpuITgI4gihQt0UkSDD1t0fMu3mBcjz25x56PNGF1dlktVNIayKigdK0sfC
	 2efNyffZLC3Vg==
Date: Tue, 28 May 2024 11:32:35 +0200
From: Christian Brauner <brauner@kernel.org>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Cc: Jingbo Xu <jefflexu@linux.alibaba.com>, 
	Miklos Szeredi <miklos@szeredi.hu>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	winters.zc@antgroup.com
Subject: Re: [RFC 0/2] fuse: introduce fuse server recovery mechanism
Message-ID: <20240528-umstritten-liedchen-30e6ca6632b2@brauner>
References: <20240524064030.4944-1-jefflexu@linux.alibaba.com>
 <CAJfpeguS3PBi-rNtnR2KH1ZS1t4s2HnB_pt4UvnN1orvkhpMew@mail.gmail.com>
 <858d23ec-ea81-45cb-9629-ace5d6c2f6d9@linux.alibaba.com>
 <6a3c3035-b4c4-41d9-a7b0-65f72f479571@linux.alibaba.com>
 <ce886be9-41d3-47b6-82e9-57d8f1f3421f@linux.alibaba.com>
 <20240528-pegel-karpfen-fd16814adc50@brauner>
 <36c14658-2c38-4515-92e1-839553971477@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <36c14658-2c38-4515-92e1-839553971477@linux.alibaba.com>

On Tue, May 28, 2024 at 05:13:04PM +0800, Gao Xiang wrote:
> Hi Christian,
> 
> On 2024/5/28 16:43, Christian Brauner wrote:
> > On Tue, May 28, 2024 at 12:02:46PM +0800, Gao Xiang wrote:
> > > 
> > > 
> > > On 2024/5/28 11:08, Jingbo Xu wrote:
> > > > 
> > > > 
> > > > On 5/28/24 10:45 AM, Jingbo Xu wrote:
> > > > > 
> > > > > 
> > > > > On 5/27/24 11:16 PM, Miklos Szeredi wrote:
> > > > > > On Fri, 24 May 2024 at 08:40, Jingbo Xu <jefflexu@linux.alibaba.com> wrote:
> > > > > > 
> > > > > > > 3. I don't know if a kernel based recovery mechanism is welcome on the
> > > > > > > community side.  Any comment is welcome.  Thanks!
> > > > > > 
> > > > > > I'd prefer something external to fuse.
> > > > > 
> > > > > Okay, understood.
> > > > > 
> > > > > > 
> > > > > > Maybe a kernel based fdstore (lifetime connected to that of the
> > > > > > container) would a useful service more generally?
> > > > > 
> > > > > Yeah I indeed had considered this, but I'm afraid VFS guys would be
> > > > > concerned about why we do this on kernel side rather than in user space.
> > > 
> > > Just from my own perspective, even if it's in FUSE, the concern is
> > > almost the same.
> > > 
> > > I wonder if on-demand cachefiles can keep fds too in the future
> > > (thus e.g. daemonless feature could even be implemented entirely
> > > with kernel fdstore) but it still has the same concern or it's
> > > a source of duplication.
> > > 
> > > Thanks,
> > > Gao Xiang
> > > 
> > > > > 
> > > > > I'm not sure what the VFS guys think about this and if the kernel side
> > > > > shall care about this.
> > 
> > Fwiw, I'm not convinced and I think that's a big can of worms security
> > wise and semantics wise. I have discussed whether a kernel-side fdstore
> > would be something that systemd would use if available multiple times
> > and they wouldn't use it because it provides them with no benefits over
> > having it in userspace.
> 
> As far as I know, currently there are approximately two ways to do
> failover mechanisms in kernel.
> 
> The first model much like a fuse-like model: in this mode, we should
> keep and pass fd to maintain the active state.  And currently,
> userspace should be responsible for the permission/security issues
> when doing something like passing fds.
> 
> The second model is like one device-one instance model, for example
> ublk (If I understand correctly): each active instance (/dev/ublkbX)
> has their own unique control device (/dev/ublkcX).  Users could
> assign/change DAC/MAC for each control device.  And failover
> recovery just needs to reopen the control device with proper
> permission and do recovery.
> 
> So just my own thought, kernel-side fdstore pseudo filesystem may
> provide a DAC/MAC mechanism for the first model.  That is a much
> cleaner way than doing some similar thing independently in each
> subsystem which may need DAC/MAC-like mechanism.  But that is
> just my own thought.

The failover mechanism for /dev/ublkcX could easily be implemented using
the fdstore. The fact that they rolled their own thing is orthogonal to
this imho. Implementing retrieval policies like this in the kernel is
slowly advancing into /proc/$pid/fd/ levels of complexity. That's all
better handled with appropriate policies in userspace. And cachefilesd
can similarly just stash their fds in the fdstore.


Return-Path: <linux-fsdevel+bounces-20319-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 260288D1690
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 May 2024 10:43:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 56E811C219EF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 May 2024 08:43:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01F2D13D255;
	Tue, 28 May 2024 08:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BeYy/teY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 613657346A;
	Tue, 28 May 2024 08:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716885800; cv=none; b=MRxGrB8XXr7vwewEMKxvtgFdPDvLlEFdJkI6WAehS6cjgW+iax9OLTXBWD2U9ZZpKwiQU64CphxVABk7xq58dWUQiUfVDqlqnciCrX77p/spmB3EW8Bg0NacUBmAq+DKfWvnrvDaZEq6CYHSaK8RtEcNmt5ilcb1jkD4o2q/dzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716885800; c=relaxed/simple;
	bh=Pcq/VfFNSx3LV1OpnIdsY399L7rZ2gsWs5zwW4FGTBQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PusAm/XByZ89NQdh6tZ8f+bBIWLr1QaXP6y3zbuP1aUaOtrMEl5qzx5gqFGdgOoVeSJ7iUFkKdjdH36nE2fhbxIVCpIWDuGPIO16ydkwSDdCHUyMb4KZKgVaZTCbiIngiQkvzuZzSDJi+Sp6gw248x5hEHGwdrG8s5KCK4Oj9zE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BeYy/teY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48042C3277B;
	Tue, 28 May 2024 08:43:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716885799;
	bh=Pcq/VfFNSx3LV1OpnIdsY399L7rZ2gsWs5zwW4FGTBQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BeYy/teYm/Qu3kgYiJPKjPjEx9Dw52ryKkc4HUoQql+S2VgPrPoIk9c/Gco57sAau
	 Fx/32gaPSOHvRvce/3HEy6Plam8A8FWw7pqPUGdOMV1+e1jBVPrk5mYmKfNvS2ivF+
	 Ksh/wDdX+Aj5kol7IDEivUm2u8R+1U85froMbJPAMpdZ1l9Xnh0c6Ua9DkQYkzpddp
	 7Qd7i99r1V/p2gXNX04xYtDzN7A3GfsdKtRhfu18ypgZ2F3EOolWbQyN+aZQ46tm2w
	 MLwaVEtWGKeIXrkZi4g415T4tue4d89JK0gkaUkkJ99VUhsf1FyTXV6Hqcizp1f++i
	 tS+NVfr06gd7Q==
Date: Tue, 28 May 2024 10:43:15 +0200
From: Christian Brauner <brauner@kernel.org>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Cc: Jingbo Xu <jefflexu@linux.alibaba.com>, 
	Miklos Szeredi <miklos@szeredi.hu>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	winters.zc@antgroup.com
Subject: Re: [RFC 0/2] fuse: introduce fuse server recovery mechanism
Message-ID: <20240528-pegel-karpfen-fd16814adc50@brauner>
References: <20240524064030.4944-1-jefflexu@linux.alibaba.com>
 <CAJfpeguS3PBi-rNtnR2KH1ZS1t4s2HnB_pt4UvnN1orvkhpMew@mail.gmail.com>
 <858d23ec-ea81-45cb-9629-ace5d6c2f6d9@linux.alibaba.com>
 <6a3c3035-b4c4-41d9-a7b0-65f72f479571@linux.alibaba.com>
 <ce886be9-41d3-47b6-82e9-57d8f1f3421f@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ce886be9-41d3-47b6-82e9-57d8f1f3421f@linux.alibaba.com>

On Tue, May 28, 2024 at 12:02:46PM +0800, Gao Xiang wrote:
> 
> 
> On 2024/5/28 11:08, Jingbo Xu wrote:
> > 
> > 
> > On 5/28/24 10:45 AM, Jingbo Xu wrote:
> > > 
> > > 
> > > On 5/27/24 11:16 PM, Miklos Szeredi wrote:
> > > > On Fri, 24 May 2024 at 08:40, Jingbo Xu <jefflexu@linux.alibaba.com> wrote:
> > > > 
> > > > > 3. I don't know if a kernel based recovery mechanism is welcome on the
> > > > > community side.  Any comment is welcome.  Thanks!
> > > > 
> > > > I'd prefer something external to fuse.
> > > 
> > > Okay, understood.
> > > 
> > > > 
> > > > Maybe a kernel based fdstore (lifetime connected to that of the
> > > > container) would a useful service more generally?
> > > 
> > > Yeah I indeed had considered this, but I'm afraid VFS guys would be
> > > concerned about why we do this on kernel side rather than in user space.
> 
> Just from my own perspective, even if it's in FUSE, the concern is
> almost the same.
> 
> I wonder if on-demand cachefiles can keep fds too in the future
> (thus e.g. daemonless feature could even be implemented entirely
> with kernel fdstore) but it still has the same concern or it's
> a source of duplication.
> 
> Thanks,
> Gao Xiang
> 
> > > 
> > > I'm not sure what the VFS guys think about this and if the kernel side
> > > shall care about this.

Fwiw, I'm not convinced and I think that's a big can of worms security
wise and semantics wise. I have discussed whether a kernel-side fdstore
would be something that systemd would use if available multiple times
and they wouldn't use it because it provides them with no benefits over
having it in userspace.

Especially since it implements a lot of special semantics and policy
that we really don't want in the kernel. I think that's just not
something we should do. We should give userspace all the means to
implement fdstores in userspace but not hold fds ourselves.


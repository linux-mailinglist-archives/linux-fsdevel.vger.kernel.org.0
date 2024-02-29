Return-Path: <linux-fsdevel+bounces-13182-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F59886C6AA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Feb 2024 11:17:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AAB0B1F21D96
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Feb 2024 10:17:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79E2263CB5;
	Thu, 29 Feb 2024 10:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZU48I2Eq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCFA86350A
	for <linux-fsdevel@vger.kernel.org>; Thu, 29 Feb 2024 10:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709201859; cv=none; b=NYu6Sa2aSmtnVU27uj1sDllSVENAMzELqVzPBjza4HscCP6vTznrb5FymmvwcXVJXsxMmpOobehunHT+nRHmXrgEb054ABliRRXSqcFz70LaJwE+IisgZSBwO6/YMLCXtMhVOWnGNGvKYvGt0cwnsUmbbumupIm7t+sumNmUU9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709201859; c=relaxed/simple;
	bh=S5ZtlJqORiasu6+RsdBJFuaWBJ9xitRRVyVHPr+O7Nw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n9kJtoel5eOqA4goxnCktqX0vZuYCmdXRmjHpcRjf1/E1/Tk7jYrSn1LxzbpmOGXE7saMR5wcLfFVweK6dU/04maLhTZ9P2kJ/I0D7e3gzP1mgR3/g6ZTtGnmW7RV4OhmuaFBpsUpwOR7RoC/FSK0YNrGvve3vC4x2e5a0J173Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZU48I2Eq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 984E0C433C7;
	Thu, 29 Feb 2024 10:17:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709201859;
	bh=S5ZtlJqORiasu6+RsdBJFuaWBJ9xitRRVyVHPr+O7Nw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZU48I2EqWbGwQ9KWV7D2Al4iFpHCu/dqcNfTzpHQBpP958l0dZeKl/jo2QijANN8G
	 kbURApcqlZkdP27LxyaMfukAY+aF8T24aH2Td4MPovi5dJi30UeuiLEDZapM6QI+ga
	 HlfQ6g5TPgc05CpWy8Gfwoh8ILngIJJMqGG2XWNN9ScVPcpzhbvYIkEvS5IcbzHGId
	 D2viQKkNKoss6Yb7O+9gkL6gf8KLv0XmJW6kE5rc9aZLldF7JDrLheTdQnH6+rqaw4
	 xUBs1ZZYQzRsRUrpC615Egfgn8+TnwhsGehvvNRN/L4YZJ9c/kKEByqxEwOPsJFCsf
	 MPIZcoL+qUJcw==
Date: Thu, 29 Feb 2024 11:17:34 +0100
From: Christian Brauner <brauner@kernel.org>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Jens Axboe <axboe@kernel.dk>, Amir Goldstein <amir73il@gmail.com>, 
	Jingbo Xu <jefflexu@linux.alibaba.com>, Bernd Schubert <bernd.schubert@fastmail.fm>, 
	linux-fsdevel@vger.kernel.org, Alessio Balsini <balsini@android.com>
Subject: Re: [PATCH v15 3/9] fuse: implement ioctls to manage backing files
Message-ID: <20240229-stochern-fachsimpeln-ad8227434069@brauner>
References: <20240206142453.1906268-1-amir73il@gmail.com>
 <20240206142453.1906268-4-amir73il@gmail.com>
 <450d8b2d-c1d0-4d53-b998-74495e9eca3f@linux.alibaba.com>
 <CAOQ4uxhAY1m7ubJ3p-A3rSufw_53WuDRMT1Zqe_OC0bP_Fb3Zw@mail.gmail.com>
 <CAJfpegu3_sUtTC1uCD7kFehJWTivkN_OjcQGsSAMkzEdub=XTw@mail.gmail.com>
 <CAOQ4uxji-yzWFeQYP9FKvVXg473GP6tC2pyHUbEPoYxT+qDYsA@mail.gmail.com>
 <4e3d80ad-3c61-4adf-b74f-0c62e468eb54@kernel.dk>
 <CAJfpegsAs3V8jU2UWyJUB33FCbmoFiOSp9Cjzrgc9+XcomN0Uw@mail.gmail.com>
 <20240229-ausrollen-verebben-ea5597a9cfa0@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240229-ausrollen-verebben-ea5597a9cfa0@brauner>

On Thu, Feb 29, 2024 at 11:15:35AM +0100, Christian Brauner wrote:
> On Wed, Feb 28, 2024 at 04:01:17PM +0100, Miklos Szeredi wrote:
> > On Wed, 28 Feb 2024 at 15:32, Jens Axboe <axboe@kernel.dk> wrote:
> > >
> > > On 2/28/24 4:28 AM, Amir Goldstein wrote:
> > 
> > > > Are fixed files visible to lsof?
> > >
> > > lsof won't show them, but you can read the fdinfo of the io_uring fd to
> > > see them. Would probably be possible to make lsof find and show them
> > > too, but haven't looked into that.
> 
> I actually wrote about this before when I suggested IORING_OP_FIXED_FD_INSTALL:
> https://patchwork.kernel.org/project/io-uring/patch/df0e24ff-f3a0-4818-8282-2a4e03b7b5a6@kernel.dk/#25629935

I think that it shouldn't be a problem as long as userspace has some way
of figuring this out. So extending lsof might just be enough for this.


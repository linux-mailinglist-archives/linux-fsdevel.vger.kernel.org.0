Return-Path: <linux-fsdevel+bounces-21801-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CFF5790A6F5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Jun 2024 09:25:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CADE81C20FF2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Jun 2024 07:25:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F006E18C33C;
	Mon, 17 Jun 2024 07:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o1F50vbj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D65C186E26;
	Mon, 17 Jun 2024 07:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718609129; cv=none; b=qDmrUrC0H5sWFcX49fQUcjoF5FprzT5/IZ82pdnTvVFBzu3hdpdQq4/FF3i+aeXMV69s82Z5zOKZmvTXmZgaWnaEwBP6/o6n0PDNjtrLRhxed7ec+XHNqJIu/jY3pKQUnDYzrZ6TBFNlYZHMjgcqOqcGCNX7VQspbd4LMyFB6pw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718609129; c=relaxed/simple;
	bh=RRklOOLyOV2FNdtepI8jJ3qedGpOhvkVdeVHrm7GU0E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=udTy+X7351AonvuoR+yTqx/UgQ94gUWzFjePYBoc6UywRKssgTibqCKPZwLnxm78rBIOH7hF9K90AL8vfnWkXQ1HyEEyeC/xdy1B6jtG/sfC9c1IuWjwbfmP9utNPlh8vkEX1eXAbx6Pk9bQxjAha+HBatR4Ra/ST4+5NG7KTHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o1F50vbj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B08EC2BD10;
	Mon, 17 Jun 2024 07:25:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718609128;
	bh=RRklOOLyOV2FNdtepI8jJ3qedGpOhvkVdeVHrm7GU0E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=o1F50vbjl2FFGALa8yqr1Dkyx/MQN6AlRTaf+DqkyTR+86HQpgfXkd1Ne3rvzVGBS
	 NqtfbgZ7ktZ/nmy4a3EKOKys6HHPyZLZUdGREPvPkGD7RKvJNbqjC7Osa3aMug+Zyw
	 YU0Ti7bUTs+WFArtCyTx6t4J7uBA7dlCEMWaCmIt4WCeIOqrWIHi2TiNBn/DJrXd7m
	 8yap5nGP8TURM3X/40fh3ZRQ7H3XwbhzLS1RRLiyiawlpvVcy3Sfy7FbZgyYadLk+n
	 L8KxlWUvdKyAclB0dZA3TOywZ/kMdzY7qGLNJwAX1BUzmiObSq0i1oMvNmY3FNtqVO
	 g8z2vLjOMLoJw==
Date: Mon, 17 Jun 2024 09:25:24 +0200
From: Christian Brauner <brauner@kernel.org>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Haifeng Xu <haifeng.xu@shopee.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [RFC] fuse: do not generate interrupt requests for fatal signals
Message-ID: <20240617-vanille-labil-8de959ba5756@brauner>
References: <20240613040147.329220-1-haifeng.xu@shopee.com>
 <CAJfpegsGOsnqmKT=6_UN=GYPNpVBU2kOjQraTcmD8h4wDr91Ew@mail.gmail.com>
 <a8d0c5da-6935-4d28-9380-68b84b8e6e72@shopee.com>
 <CAJfpegsvzDg6fUy9HGUaR=7x=LdzOet4fowPvcbuOnhj71todg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJfpegsvzDg6fUy9HGUaR=7x=LdzOet4fowPvcbuOnhj71todg@mail.gmail.com>

On Fri, Jun 14, 2024 at 12:01:39PM GMT, Miklos Szeredi wrote:
> On Thu, 13 Jun 2024 at 12:44, Haifeng Xu <haifeng.xu@shopee.com> wrote:
> 
> > So why the client doesn't get woken up?
> 
> Need to find out what the server (lxcfs) is doing.  Can you do a
> strace of lxcfs to see the communication on the fuse device?

Fwiw, I'm one of the orignal authors and maintainers of LXCFS so if you
have specific questions, I may be able to help.


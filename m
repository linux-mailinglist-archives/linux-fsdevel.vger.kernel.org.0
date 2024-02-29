Return-Path: <linux-fsdevel+bounces-13181-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D92BF86C69D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Feb 2024 11:15:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8466D1F231D5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Feb 2024 10:15:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ACE363511;
	Thu, 29 Feb 2024 10:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MgHC2k72"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8EFB63502
	for <linux-fsdevel@vger.kernel.org>; Thu, 29 Feb 2024 10:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709201735; cv=none; b=JQe4CfHYr/8nWodpFrfc5kJxb+qm3fy2D6XDJi3PxT5yBT4bpmpE6GP96QRkVW4AhB5oK1gSQLn0UwRydKt0fnFOAMr5gYKfIbuxXpaXyLv+YbkbArN5cytAVAx91x2XRtfu9HNGDtI9KGAWwEctalW+iX+9104p2thiKns1+gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709201735; c=relaxed/simple;
	bh=9Mer8C+xyUZhlsAywsv4I2Yj3Luao9uLmnvoEhBK0fE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qSdD3aMWTCBn1K+bmThuPQ+LVyuBWjIvSorJ5tloRwWGB3IVOWOitnYsTomW+xUPUDF/MDHYaKlnQWqGeBcGGTpFlatb95NTjO8Tf2h8DL+YxUQQbZt/PP33Xl8R29sfSZbShUCJvpilf0O9R00Q2AIznv8X0esUO8sDTo6Na74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MgHC2k72; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D899C433F1;
	Thu, 29 Feb 2024 10:15:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709201734;
	bh=9Mer8C+xyUZhlsAywsv4I2Yj3Luao9uLmnvoEhBK0fE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MgHC2k72V5OEvDTEFM7iHnu8TWSY06YhIfITFjP0Mr/k8OVbTfuGN+IMAaEz5axNK
	 fXPWhY1VB6QwgBBOXLwhLT9GNioenxueycIJrcKN++TFTjKNAc3cILcJ6F18sm5uOk
	 HjIhTot7XuRnPETmRbrKzXU/hr+ZeHv7wGE4x7ogoR/PML4/QKPgGT3rg6e3Chtl5v
	 G7NH7uTY2q3eeIKsQNJD7/jhYYj3ryCLMADO7XzlTEc6RU0hJCXP/h0XVvEO0O2NBO
	 j0QKgcytBzMq1Dmd8wIF3uvO56B3TZPz/9ChLay/GPQqvjb2vUbWKRNumtsgFajgSC
	 9GfM5EFqa8IjQ==
Date: Thu, 29 Feb 2024 11:15:29 +0100
From: Christian Brauner <brauner@kernel.org>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Jens Axboe <axboe@kernel.dk>, Amir Goldstein <amir73il@gmail.com>, 
	Jingbo Xu <jefflexu@linux.alibaba.com>, Bernd Schubert <bernd.schubert@fastmail.fm>, 
	linux-fsdevel@vger.kernel.org, Alessio Balsini <balsini@android.com>
Subject: Re: [PATCH v15 3/9] fuse: implement ioctls to manage backing files
Message-ID: <20240229-ausrollen-verebben-ea5597a9cfa0@brauner>
References: <20240206142453.1906268-1-amir73il@gmail.com>
 <20240206142453.1906268-4-amir73il@gmail.com>
 <450d8b2d-c1d0-4d53-b998-74495e9eca3f@linux.alibaba.com>
 <CAOQ4uxhAY1m7ubJ3p-A3rSufw_53WuDRMT1Zqe_OC0bP_Fb3Zw@mail.gmail.com>
 <CAJfpegu3_sUtTC1uCD7kFehJWTivkN_OjcQGsSAMkzEdub=XTw@mail.gmail.com>
 <CAOQ4uxji-yzWFeQYP9FKvVXg473GP6tC2pyHUbEPoYxT+qDYsA@mail.gmail.com>
 <4e3d80ad-3c61-4adf-b74f-0c62e468eb54@kernel.dk>
 <CAJfpegsAs3V8jU2UWyJUB33FCbmoFiOSp9Cjzrgc9+XcomN0Uw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJfpegsAs3V8jU2UWyJUB33FCbmoFiOSp9Cjzrgc9+XcomN0Uw@mail.gmail.com>

On Wed, Feb 28, 2024 at 04:01:17PM +0100, Miklos Szeredi wrote:
> On Wed, 28 Feb 2024 at 15:32, Jens Axboe <axboe@kernel.dk> wrote:
> >
> > On 2/28/24 4:28 AM, Amir Goldstein wrote:
> 
> > > Are fixed files visible to lsof?
> >
> > lsof won't show them, but you can read the fdinfo of the io_uring fd to
> > see them. Would probably be possible to make lsof find and show them
> > too, but haven't looked into that.

I actually wrote about this before when I suggested IORING_OP_FIXED_FD_INSTALL:
https://patchwork.kernel.org/project/io-uring/patch/df0e24ff-f3a0-4818-8282-2a4e03b7b5a6@kernel.dk/#25629935


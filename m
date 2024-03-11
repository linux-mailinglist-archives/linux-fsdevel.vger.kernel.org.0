Return-Path: <linux-fsdevel+bounces-14131-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 662448780CC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Mar 2024 14:43:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC2BE2822F0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Mar 2024 13:43:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0BAC3E49B;
	Mon, 11 Mar 2024 13:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MTs+ZuHA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2803D3D97A;
	Mon, 11 Mar 2024 13:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710164597; cv=none; b=SUbAgwe+ue8FQ0hklhs3pjgPtnk8RIvuUNQ4ZjTv3e2EHA/QyZTg9mZZ4Pw8Lr0EJwbYtae8JPaMj/vHQxfNLtg2qJAWfDZDENvvYmN++QvA5YIkZf5Sb643RxF6dsl0iupnCWKXCXA05HKCyv14KgZiT6tzLAoNZkPS5gIsULU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710164597; c=relaxed/simple;
	bh=mq8X4JcCZ9rUjnJd/N0SXZgZSoZcc3LD/5PMzOXcmfc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VUMIUirpRAvoagrm1Hu21dK8xAewxRZ4SzpFqfPfTy9BTWylFESenx3UP01x0lTHB8EWjzH1cgVXAwMUvjmZu057Xct6SH8yY++VK8svz1P3tENEdcKoX1pwVSZro9kxE9pDSO3tt+3slmSmngYp0lCjCVC1chG33FcxPeSzkLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MTs+ZuHA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 765BFC433C7;
	Mon, 11 Mar 2024 13:43:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710164596;
	bh=mq8X4JcCZ9rUjnJd/N0SXZgZSoZcc3LD/5PMzOXcmfc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MTs+ZuHA9EVMuiMenxWicsun4LXM9RQql/9Y9HilPPjbJHVFt68HwaTOLRCDXkYWE
	 bxhazABQ0siXaIoPrvlgI4iUZFMC5jffB/8AQB4Cdz9CsumI6tcBVsLQOmJCLXgD9y
	 BWbkcRqE7AfArQQc24iwrMzvdJK+ivuh4w1MI0pX+61o8HJJBijn8PToBrCvhGtArE
	 ByJLqvmWnQXmfYdbRAOI4aYIYs3TuN4kSvmJBYZqYgjseJTNqrWznhAPa9Xk49tYkF
	 h/1xJAvqDCvdDpbkuMjsVgvIjmk5Dyf4FBmXs7TSvIXz1G6+Uryn6OPhyM+a8idZQl
	 +52VM1NOnyr3w==
Date: Mon, 11 Mar 2024 14:43:11 +0100
From: Christian Brauner <brauner@kernel.org>
To: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc: Kent Overstreet <kent.overstreet@linux.dev>, 
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, 
	"linux-bcachefs@vger.kernel.org" <linux-bcachefs@vger.kernel.org>, "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Josef Bacik <josef@toxicpanda.com>, 
	Miklos Szeredi <mszeredi@redhat.com>, David Howells <dhowells@redhat.com>
Subject: Re: [PATCH v2] statx: stx_subvol
Message-ID: <20240311-zugeparkt-mulden-48b143bf51e0@brauner>
References: <20240308022914.196982-1-kent.overstreet@linux.dev>
 <2f598709-fccb-4364-bf15-f9c171b440aa@wdc.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2f598709-fccb-4364-bf15-f9c171b440aa@wdc.com>

On Mon, Mar 11, 2024 at 08:12:33AM +0000, Johannes Thumshirn wrote:
> On 08.03.24 03:29, Kent Overstreet wrote:
> > Add a new statx field for (sub)volume identifiers, as implemented by
> > btrfs and bcachefs.
> > 
> > This includes bcachefs support; we'll definitely want btrfs support as
> > well.
> 
> For btrfs you can add the following:
> 
> 
>  From 82343b7cb2a947bca43234c443b9c22339367f68 Mon Sep 17 00:00:00 2001
> From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> Date: Mon, 11 Mar 2024 09:09:36 +0100
> Subject: [PATCH] btrfs: provide subvolume id for statx
> 
> Add the inode's subvolume id to the newly proposed statx subvol field.
> 
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> ---

Thanks, will fold, once I hear from Josef.


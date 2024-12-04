Return-Path: <linux-fsdevel+bounces-36464-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EAD649E3D1D
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Dec 2024 15:46:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C3DD4B2B9C3
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Dec 2024 14:18:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0A081FA252;
	Wed,  4 Dec 2024 14:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dg55S0om"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 433561BBBE0;
	Wed,  4 Dec 2024 14:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733321905; cv=none; b=c4KwUpUSUtETiZbnDHMPrG/JZLxqCvqQwPYxl9n0niDqEj5AkDYGCMkQSD78Afo8/r/8iIGRgEnEdkZPkvRvpd0io2yVXVHIs+gfdz2pb3yaYzmiQQL9xc9ntnQtzTmAhkU8GLEjSe3N8VSLiDHMd5MPWvLZXYrxmI8c/7osfV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733321905; c=relaxed/simple;
	bh=c0CbMV4Q+T9DSZTAe84qgqzzZe0K8+vcMKOU/Nervp4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q/nU5dDMqsiHa4dJRHYLHCaEQ9C9Tybc0QuRKuJZboRrS3YopWnbDFz6Y+1NIe2HAoZrB8oCJb7wdL3xKGJjiO+QJoPNieY/3NlHZ5VwPA1dUO4bz5V3XKTYR9SVPIzvqU1d+axlSMiEM3fpri2ZZs234+lq4GYQyKp6OxIdJw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dg55S0om; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34B85C4CECD;
	Wed,  4 Dec 2024 14:18:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733321904;
	bh=c0CbMV4Q+T9DSZTAe84qgqzzZe0K8+vcMKOU/Nervp4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dg55S0om/7KA71Pw2ZJOzE5HmchWdsXKAUyuira3zEqzAqGrqILh7jW52fwWij/Mq
	 2qDsqBQ3qODKlAXiON5Lkhc9qsCal1Emy4QHODR4FKhXImuBAkBCglSNtkPIxncG8d
	 pgusGszUVttg3MhfKZ1AOYOl3rb3h1iuIhWUJFLYqpa7d5LHA9uAmFja4/YluKThED
	 RxMBf1AGjrcg1JVyWuWSv6KaVhTLU3e3Ri3DQItsrDL3gn+RMe4jby81YxprhNJ0j7
	 ge3vdVM6JDbzezUn2gBYGaLJe6N+TaQxIN5TU6wylhUYTqMKOxUYngFWWDeoC2I1WO
	 vMe3IkF6AOP4A==
Date: Wed, 4 Dec 2024 15:18:19 +0100
From: Christian Brauner <brauner@kernel.org>
To: Jan Kara <jack@suse.cz>
Cc: linux-ext4@vger.kernel.org, Zhang Yi <yi.zhang@huaweicloud.com>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, tytso@mit.edu, 
	adilger.kernel@dilger.ca, yi.zhang@huawei.com, chengzhihao1@huawei.com, yukuai3@huawei.com, 
	yangerkun@huawei.com
Subject: Re: [PATCH 0/2] jbd2: two straightforward fixes
Message-ID: <20241204-lieblich-injektion-0764382c8cb1@brauner>
References: <20241203014407.805916-1-yi.zhang@huaweicloud.com>
 <20241204-landen-umwirbt-06fd455b45d2@brauner>
 <20241204125631.au6ggazqdnq5xey2@quack3>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241204125631.au6ggazqdnq5xey2@quack3>

On Wed, Dec 04, 2024 at 01:56:31PM +0100, Jan Kara wrote:
> On Wed 04-12-24 12:00:55, Christian Brauner wrote:
> > On Tue, 03 Dec 2024 09:44:05 +0800, Zhang Yi wrote:
> > > From: Zhang Yi <yi.zhang@huawei.com>
> > > 
> > > Zhang Yi (2):
> > >   jbd2: increase IO priority for writing revoke records
> > >   jbd2: flush filesystem device before updating tail sequence
> > > 
> > > fs/jbd2/commit.c | 4 ++--
> > >  fs/jbd2/revoke.c | 2 +-
> > >  2 files changed, 3 insertions(+), 3 deletions(-)
> > > 
> > > [...]
> > 
> > Applied to the vfs.fixes branch of the vfs/vfs.git tree.
> > Patches in the vfs.fixes branch should appear in linux-next soon.
> 
> Traditionally, Ted takes jbd2 patches through his tree. For these two
> patches, chances for conflicts or unexpected effects are pretty low so I
> don't really care but I wanted to point that out :)

Ah, ok.


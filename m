Return-Path: <linux-fsdevel+bounces-32472-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EAB39A683B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Oct 2024 14:25:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0FD4A282B9A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Oct 2024 12:25:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43FCE1FAEE4;
	Mon, 21 Oct 2024 12:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tjP9Suut"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86E231F8928;
	Mon, 21 Oct 2024 12:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729513330; cv=none; b=p2zKJDmniJvU1ir/DO56Wp6kH/Nbk+p1/Nd5ipfW+gZoxHVCpvPPGly+xXDQ/LNntwQdZka5vhp+rAfLuv3zW3V75nIgElER6VTG0Ixk/JdaM9RRnwyFZHy0yXsH0cQEV2PuDLXw2kJlcEMuyBoIBUEI2w2VcISCjTkZCBGY7+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729513330; c=relaxed/simple;
	bh=06YxC/CdS6W3JPD7F96UL5Nll4z1vUEFbWFOMvB5+dE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n2jviduc122zLQTXUvwzRj9W/IXI2TgQflSbFDHWyob7+grFqPuc6lo7B6u6MRGoXKiS3mnfWfR/mlAiZg9Fw/S5HQLGp3pH5dau3jC1SvJOn7JkHb+h9+qESokjJDGXHIGK9LYUfSdsAo3YBllIaC0NBhwUQkk6tKbF2tRDPZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tjP9Suut; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04F28C4CEC3;
	Mon, 21 Oct 2024 12:22:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729513330;
	bh=06YxC/CdS6W3JPD7F96UL5Nll4z1vUEFbWFOMvB5+dE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tjP9Suutn5vjm5+BMui+6h1JpnA+f+KfTmqoPJ+G5LkqDWn9qi6NMuJhmP2mEbeVs
	 6F3cTPEbeOlix37euqBZtHrA2c7MHx/ViNSBRjNouBGvZj4Qmp/xB/ShL8/EtIXkBG
	 m4KljBAUpzGPDRqrUspZqEUVns5dXH0RJU2mNjGCQstvHFwCWCaJhyuy/WFrnpOKSQ
	 gZp7tUJS1xFB3prnQdEOQTQVeA3UGVKIAr4L8c8JaVUvPBRe9JJGzFGCDHvn3Y6MQi
	 ERJ0PJrKhcTuhG7i/MBHXOT2F1C1BSxETnxFTEALGA/SYybWmO09oFCXeMlGVZNuF2
	 uWfJ0uFMZZLaA==
Date: Mon, 21 Oct 2024 14:22:06 +0200
From: Christian Brauner <brauner@kernel.org>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Miklos Szeredi <mszeredi@redhat.com>, linux-unionfs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2] backing-file: clean up the API
Message-ID: <20241021-zuliebe-bildhaft-08cfda736f11@brauner>
References: <20241021103340.260731-1-mszeredi@redhat.com>
 <CAOQ4uxgUaKJXinPyEa0W=7+qK2fJx90G3qXO428G9D=AZuL2fQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOQ4uxgUaKJXinPyEa0W=7+qK2fJx90G3qXO428G9D=AZuL2fQ@mail.gmail.com>

On Mon, Oct 21, 2024 at 01:58:16PM +0200, Amir Goldstein wrote:
> On Mon, Oct 21, 2024 at 12:33 PM Miklos Szeredi <mszeredi@redhat.com> wrote:
> >
> >  - Pass iocb to ctx->end_write() instead of file + pos
> >
> >  - Get rid of ctx->user_file, which is redundant most of the time
> >
> >  - Instead pass iocb to backing_file_splice_read and
> >    backing_file_splice_write
> >
> > Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
> > ---
> > v2:
> >     Pass ioctb to backing_file_splice_{read|write}()
> >
> > Applies on fuse.git#for-next.
> 
> This looks good to me.
> you may add
> Reviewed-by: Amir Goldstein <amir73il@gmail.com>
> 
> However, this conflicts with ovl_real_file() changes on overlayfs-next
> AND on the fixes in fuse.git#for-next, so we will need to collaborate.
> 
> Were you planning to send the fuse fixes for the 6.12 cycle?
> If so, I could rebase overlayfs-next over 6.12-rcX after fuse fixes
> are merged and then apply your patch to overlayfs-next and resolve conflicts.

Wouldn't you be able to use a shared branch?

If you're able to factor out the backing file changes I could e.g.,
provide you with a base branch that I'll merge into vfs.file, you can
use either as base to overlayfs and fuse or merge into overlayfs and
fuse and fix any potential conflicts. Both works and my PRs all go out
earlier than yours anyway.


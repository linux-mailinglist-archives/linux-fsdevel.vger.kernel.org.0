Return-Path: <linux-fsdevel+bounces-11945-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 788E18595F7
	for <lists+linux-fsdevel@lfdr.de>; Sun, 18 Feb 2024 10:30:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A50561C20DBA
	for <lists+linux-fsdevel@lfdr.de>; Sun, 18 Feb 2024 09:30:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC666134BC;
	Sun, 18 Feb 2024 09:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W0F9+hhd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3047A12E4B
	for <linux-fsdevel@vger.kernel.org>; Sun, 18 Feb 2024 09:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708248634; cv=none; b=OQaA96wcvQz/TPs6hicft2GhVxd7VjINgeImAXhNZ4uPn1kxaj4VvSP9rEfo3SNOJIiPJTw8d/CSN/meysJzORul294slIorfP/+pSNj1hfFOAuVPl2DchAMpV2KlIvokq5sLmEsuotmrqT+8cHyjMik9JnwXEkV73Yy9nYDIYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708248634; c=relaxed/simple;
	bh=1q4idVLa5rjd2Xez73iysntFP9xTgV7YWIq4WcWea5U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=afidMnLf8u7OfAXQydXpyOKWArwzv6ba7V1JZLbGSfQQgb4xk/guyUaWUPasyXJKhSJ7tWAjJeMeaXEG6D0CAQ8ryYA2aKKbm8Lc38QNyB4uW365skT3GcOEiugORz8EfLe/jaqv09P43dQD/mAbQSS2tj8B8aiWuT3VuWtuszE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W0F9+hhd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D82AC433C7;
	Sun, 18 Feb 2024 09:30:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708248633;
	bh=1q4idVLa5rjd2Xez73iysntFP9xTgV7YWIq4WcWea5U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=W0F9+hhd2wlmvD4ai16UTuIlu7IrKUJGQClY9ZW+1cD3iiS+hBdlenK47YzZfhQ6C
	 TWlxjZsUv6Ro+56N2ITfS6H3/ty4lDwO2iOMz25XAoSVN24HX94OzIh2LqeoNM/OvG
	 al+39GpN9d6wVUW8hMwFeshQwrtm25C+FP1TkYvEqDNVQ1HTqRSqkCDNnk7pVv7zRc
	 N15o3xFNMi8pQkt2YwQmo9FNnghKcFH5xCJyKCgOHFq6+323oGe5loOdZbUOjqocvW
	 g/2nnjFp51A0U6Ydx6VaSW7Wksa8agYpxRG49l95UekPmvf815zCE/+76iGyxg63RX
	 7tZ7DbU/AfxsA==
Date: Sun, 18 Feb 2024 10:30:29 +0100
From: Christian Brauner <brauner@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
	Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org, 
	Seth Forshee <sforshee@kernel.org>, Tycho Andersen <tycho@tycho.pizza>
Subject: Re: [PATCH 2/2] pidfd: add pidfdfs
Message-ID: <20240218-hautzellen-digital-0e5903ff1bb0@brauner>
References: <20240213-vfs-pidfd_fs-v1-0-f863f58cfce1@kernel.org>
 <20240213-vfs-pidfd_fs-v1-2-f863f58cfce1@kernel.org>
 <CAHk-=wjr+K+x8bu2=gSK8SehNWnY3MGxdfO9L25tKJHTUK0x0w@mail.gmail.com>
 <20240214-kredenzen-teamarbeit-aafb528b1c86@brauner>
 <20240214-kanal-laufleistung-d884f8a1f5f2@brauner>
 <CAHk-=whkaJFHu0C-sBOya9cdEYq57Uxqm5eeJJ9un8NKk2Nz6A@mail.gmail.com>
 <20240215-einzuarbeiten-entfuhr-0b9330d76cb0@brauner>
 <20240216-gewirbelt-traten-44ff9408b5c5@brauner>
 <20240217135916.GA21813@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240217135916.GA21813@redhat.com>

On Sat, Feb 17, 2024 at 02:59:16PM +0100, Oleg Nesterov wrote:
> On 02/16, Christian Brauner wrote:
> >
> > +struct file *pidfdfs_alloc_file(struct pid *pid, unsigned int flags)
> > +{
> > +
> > +	struct inode *inode;
> > +	struct file *pidfd_file;
> > +
> > +	inode = iget_locked(pidfdfs_sb, pid->ino);
> > +	if (!inode)
> > +		return ERR_PTR(-ENOMEM);
> > +
> > +	if (inode->i_state & I_NEW) {
> > +		inode->i_ino = pid->ino;
> 
> I guess this is unnecessary, iget_locked() should initialize i_ino if I_NEW ?

Yes, it does. I just like to be explicit in such cases.

> 
> But I have a really stupid (I know nothing about vfs) question, why do we
> need pidfdfs_ino and pid->ino ? Can you explain why pidfdfs_alloc_file()
> can't simply use, say, iget_locked(pidfdfs_sb, (unsigned long)pid) ?
> 
> IIUC, if this pid is freed and then another "struct pid" has the same address
> we can rely on __wait_on_freeing_inode() ?

Yeah, I had thought about something like this but see Linus' reply.


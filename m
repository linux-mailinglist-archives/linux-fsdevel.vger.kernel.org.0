Return-Path: <linux-fsdevel+bounces-32460-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 291E59A6024
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Oct 2024 11:34:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A44AFB291BF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Oct 2024 09:34:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B25E1E47B6;
	Mon, 21 Oct 2024 09:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="X+hu8zhH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 407D51E3DEC
	for <linux-fsdevel@vger.kernel.org>; Mon, 21 Oct 2024 09:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729503178; cv=none; b=RCFKCgtxjWJlwd6Ylkk6XFtYfnYd5gWtXOPHzlk78aI9Tu7VxVIITTPUd6UMGTRTS7XAvKdHnRhtvCilWISa0uL/ZTyqBFsFWCfEC8l+fkNZ1JRXqj+7uDlD9NoM4C2ShuutNNS7Xr0fhQlv+B9ozR0cpqonWvEsFa64Yrq9cFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729503178; c=relaxed/simple;
	bh=9clzla/O2c8xun3BEoruFaiGBhR8mETSSi3NTpPjI4Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GKJ3jwMC/MPlSNPQ2Kex23tZE1XT1zGysiowFkJjV2DrfmXWaufInWSWD6xjnTLum6KS26C+NiQzGSZj0Ig6dEyxWNRQNw2B1dmhJ4fqrJxnY22EBDaantAr8jKkSo2CxJ3pTcGQKMg5IiLpjZMpJnbeXg13wi16Bfzed8ZTVDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=X+hu8zhH; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-e28fe07e97dso3914501276.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 21 Oct 2024 02:32:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1729503174; x=1730107974; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=wzQoWkoxZnBoGUKhVz/WGG4vDvYXQJw7pxUehUocXpQ=;
        b=X+hu8zhHcPRptgIeGeCqt2Kt6ToncG05T9E72tNVfB84FBiO3n7MNpwWKksTFYgXfE
         w1Gf7j9aZByawVR6eEkk+CKGU4uiXO6bU1kHfx9Zk0UC0I24NRPoekf118o2peX2fzXc
         kcRvQ7SCguhMk/WPqNUr5F9nmY2qEmi4yAitg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729503174; x=1730107974;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wzQoWkoxZnBoGUKhVz/WGG4vDvYXQJw7pxUehUocXpQ=;
        b=nz89MpQsFnUaroi2P6lXZmyhd867aDv+5QkmDczUf/NabmtW41i2WEuaVj4ecylVPb
         ulwBP5UXYVytjiG6eCcqKzUFlXhoPqvNH10vhhfkNTf51KC3Jdeuf+T1GKbd4R4HC7qt
         1TIkkhUDAiFqDXZBaHJl2NvvIakuO5zeDLmND5cXNUSp7g06WtcH1iQy3rRaLzvwdMQm
         732R6kUg5APSikhIpmdRd8Y1Fa+wRu/oALjlZSUI9/j2ZYbRf5cUcNAbmMgx+vFaf0QP
         xn0D1c4dibH690dukzTMYuDqXA7lJIT+J+GQKk27gFwHZPlx7l7Mggeub3eTroO4N4ro
         mEpw==
X-Gm-Message-State: AOJu0YxHhQ7eZV6eZel4nAuVxAvzBuNb1gPlCz1EBOlzQ7Gb92bb+YmI
	+Av2EyrrOJuoTX7OzPC0ONLHXe8NeAiuTc5aXuy7ZHQy1ijcOMT/Y39GWUbBVJNelyS4s0HlOBS
	3jBzqokoRK7IE67FM8W3AhfGOXo3W6YauE5PmeqYsqPDz7iX44uQ=
X-Google-Smtp-Source: AGHT+IF33aCb4BiI0InxUmsARrMvP0g3rwGjh9O0/sliUSZghwSdT6XQrnZ72Y/apOWBultHW7rn7j/QBsg5x8PofFc=
X-Received: by 2002:a25:cec5:0:b0:e2b:d097:377c with SMTP id
 3f1490d57ef6-e2bd0974fa2mr3644302276.10.1729503173952; Mon, 21 Oct 2024
 02:32:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241014182228.1941246-1-joannelkoong@gmail.com>
 <20241014182228.1941246-3-joannelkoong@gmail.com> <CAJfpegs+txwBQsJf8GhiKoG3VxLH+y9jh8+1YHQds11m=0U7Xw@mail.gmail.com>
 <CAJnrk1bByc+qJTAvfJZxp5=o=N8EdgKWxQN-jWOW8Rv-PZMZRA@mail.gmail.com>
In-Reply-To: <CAJnrk1bByc+qJTAvfJZxp5=o=N8EdgKWxQN-jWOW8Rv-PZMZRA@mail.gmail.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Mon, 21 Oct 2024 11:32:42 +0200
Message-ID: <CAJfpegum=FKSKGeE6RqOza-uR_4xXcR4Yibk9HCXYWuuVoBhLw@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] fuse: remove tmp folio for writebacks and internal
 rb tree
To: Joanne Koong <joannelkoong@gmail.com>
Cc: linux-fsdevel@vger.kernel.org, josef@toxicpanda.com, 
	bernd.schubert@fastmail.fm, jefflexu@linux.alibaba.com, hannes@cmpxchg.org, 
	shakeel.butt@linux.dev, linux-mm@kvack.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"

On Fri, 18 Oct 2024 at 03:30, Joanne Koong <joannelkoong@gmail.com> wrote:

> I need to analyze the page fault path more to get a clearer picture of
> what is happening, but so far this looks like a valid case for a
> correctly written fuse server to run into.

Yes.

> For the syscalls however, is it valid/safe in general (disregarding
> the writeback deadlock scenario for a minute) for fuse servers to be
> invoking these syscalls in their handlers anyways?

Generally no.  Any kind of recursion in fuse is a landmine.

E.g. CVE-2019-20794 was created to track an issue with a fuse server
going unkillable on namespace shutdown.  It didn't occur to the
reporter that this is just a special case of a plain old recursive
deadlock, because it happens to be triggered by kill.  But recursion
is clearly there: there's a file descriptor referring to the same fuse
mount that is being served.  When this fd is closed at process exit
the recursion is triggered and the thing deadlocks.  The fix: move the
recursive part of the code to a different process.  But people seem to
believe that recursion is okay and the kernel should deal with that
:-/

> The other places where I see a generic wait on writeback seem safe:
> * splice, page_cache_pipe_buf_try_steal() (fs/splice.c):
>    We hit this in fuse when we try to move a page from the pipe buffer
> into the page cache (fuse_try_move_page()) for the SPLICE_F_MOVE case.
> This wait seems fine, since the folio that's being waited on is the
> folio in the pipe buffer which is not a fuse folio.
> * memory failure (mm/memory_failure.c):
>    Soft offlining a page and handling page memory failure - these can
> be triggered asynchronously (memory_failure_work_func()), but this
> should be fine for the fuse use case since the server isn't blocked on
> servicing any writeback requests while memory failure handling is
> waiting on writeback
> * page truncation (mm/truncate.c):
>    Same here. These cases seem fine since the server isn't blocked on
> servicing writeback requests while truncation waits on writeback

Right.

Thanks,
Miklos


Return-Path: <linux-fsdevel+bounces-56614-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F006B19B17
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Aug 2025 07:31:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 19CD01896A52
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Aug 2025 05:31:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05E7A2288CB;
	Mon,  4 Aug 2025 05:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="p0SE+C0k"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A53021547D2
	for <linux-fsdevel@vger.kernel.org>; Mon,  4 Aug 2025 05:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754285474; cv=none; b=WUs9RNF7MXe1NzJya+PHMb/2KqtNuXJ9YETktCPws7K8OGwP6TolkNp5tzpsi7ecCAKkbLlqH2p30405+6XcABxPPJ3Ht+1JlrLxnYRyk26pyqgtEzExiQWV20WeODiPr7SCo1zyfLsp/agYzHyE7PaC9aaOzi8C0zcyzSsBKqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754285474; c=relaxed/simple;
	bh=EXRLZKVFPqCMYkS125QRJvkk+n0WPGuGtQ1Co+8MwXs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=msFZt0zmJo7USxdISDS+gDoUc5X4hNZM+pbIkjHNQPPTzxhCxDIhloWHtLeU/HgkFpX4SjaX5MRSQZFnEH7a0xkI7uYATxLE7TsUPee5J15XtRzjK+ezUqfVuEuqpnjS3shdyeDNG9cQVlxj+HGG5QmAiPf1z/owvZnzmlciMKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=p0SE+C0k; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-4abd3627e7eso52419111cf.0
        for <linux-fsdevel@vger.kernel.org>; Sun, 03 Aug 2025 22:31:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1754285471; x=1754890271; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=EXRLZKVFPqCMYkS125QRJvkk+n0WPGuGtQ1Co+8MwXs=;
        b=p0SE+C0kEkFFWpIQia4HP8I309Mbc6y2gIideSIetE5RSpT59znz4LC101mFSApKsX
         UaVV38qrKgWCzA/IqM7Ll7Va/AumHXMvpYHCo8x+nc8PAL0SYERd4g81JkRyVezrJtRH
         BuKQzqDQ33pEkvbWumfyc7pdUd/cUgxYzLJuc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754285471; x=1754890271;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EXRLZKVFPqCMYkS125QRJvkk+n0WPGuGtQ1Co+8MwXs=;
        b=w6wxZpBBcrGQxfJMOTYugmXg6/5WW850xaW1cH/w0eHY3f+jWLCgcTDz57m+osy8f4
         XIGvzKeBTqvlOmm1JlW8xUV4k6ASHyo+5KhsAWo3hQzGbQECSom66SrT9qHwvUleaPKV
         fjoY1HWSWfNGhYhYECDQNYPZYLHgKNJ07JXUUHKkqI+1h2hTdcqIh6CimjsVSj60MKfA
         lt0LJDkNp8wAwsBQD+7gwTcJuXpfKdxe7HQqZpDsGhC3Q9ifc5vhgoF2Ehd4khUkEwrE
         cDUXS28q+t9EeW6DK6pOeBxB+yYPGk4MTzjs3RG8U7cKGRfkLBk6WaCLFUIk7aOCtWvq
         SGkg==
X-Forwarded-Encrypted: i=1; AJvYcCVdrTZozw+yjpLX4sp9J2FbQwlGiJ7T+0LaAHMejSniZt9JYjYfgfEGY/74NyHy09pthDliY/gHdujP9ZLF@vger.kernel.org
X-Gm-Message-State: AOJu0YxhPxd3ezaooRW3RA1vXMUCK7DdvsNO56vFfJrYPYI74YcFsnUZ
	ppThfZSbJJq38uPn+x+tvZTzrQtrzRbopV+jOkwLOdD1jKyibfelxMW7+7z9z5B9Z/DpSe7SIHJ
	LrnY3OxuHNSB1VupffdP7yvHtKGZ/KTu5ORkWR+cZwA==
X-Gm-Gg: ASbGncsY7QPKXksS+CbNRy+wXK8gYtus8L1dwWyPnrvTG/equnNBwX9qXFfzOnEJ+Mi
	Cjl5ZhaT3bxpdEdJkyJMUOxqi0knenvO5mNRclPU3+vNUev4Yf+tG+yLMQWKzakf9O8iC5AE9qW
	kwv2HKubsqRed5LUvN9f00CYyTiUGTkPKgzP2efP7PJk/0OZlR8eX6MnkhcK3jQ66UllyG6n0iw
	WTmdWU=
X-Google-Smtp-Source: AGHT+IH0IH0rNC75c+GhfDQJZCuvklC5kQM1oh/HgDVzt03m+1uz14T020E0UkujMdxGJ1sbdkvEK0AIQGjN8f1XEJA=
X-Received: by 2002:a05:622a:1f89:b0:4ab:7fe9:1aa with SMTP id
 d75a77b69052e-4af10a89bbamr143160171cf.29.1754285471393; Sun, 03 Aug 2025
 22:31:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250402-work-freeze-v2-0-6719a97b52ac@kernel.org>
 <20250720192336.4778-1-safinaskar@zohomail.com> <tm57gt2zkazpyjg3qkcxab7h7df2kyayirjbhbqqw3eknwq37h@vpti4li6xufe>
In-Reply-To: <tm57gt2zkazpyjg3qkcxab7h7df2kyayirjbhbqqw3eknwq37h@vpti4li6xufe>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Mon, 4 Aug 2025 07:31:00 +0200
X-Gm-Features: Ac12FXyzcxe_u-skQ24oK2yIIfSZae1qfInamXqtbJ0CQvMMKceqDyTihjyeSp4
Message-ID: <CAJfpegsSshtqj2hjYt8+00m-OqXMbwpUiVJr412oqdF=69yLGA@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] power: wire-up filesystem freeze/thaw with suspend/resume
To: Jan Kara <jack@suse.cz>
Cc: Askar Safin <safinaskar@zohomail.com>, brauner@kernel.org, 
	James.Bottomley@hansenpartnership.com, ardb@kernel.org, boqun.feng@gmail.com, 
	david@fromorbit.com, djwong@kernel.org, hch@infradead.org, 
	linux-efi@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, mcgrof@kernel.org, mingo@redhat.com, 
	pavel@kernel.org, peterz@infradead.org, rafael@kernel.org, will@kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 21 Jul 2025 at 14:09, Jan Kara <jack@suse.cz> wrote:
>
> Hi!
>
> On Sun 20-07-25 22:23:36, Askar Safin wrote:

> > - Suspend doesn't work if we try to read from fuse-sshfs filesystem while
> > network is down
>
> On the surface the problem is the same as the above two but the details
> here are subtly different. Here I expect (although I'm not 100% sure) the
> blocked process is inside the FUSE filesystem waiting for the FUSE daemon
> to reply (a /proc/<pid>/stack of the blocked process would be useful here).
> In theory, FUSE filesystem should be able to make the wait for reply in
> TASK_FREEZABLE state which would fix your issue. In any case this is very
> likely work for FUSE developers.

This is a known problem with an unknown solution.

We can fix some of the cases, but changing all filesystem locks to be
freezable is likely not workable.

Thanks,
Miklos


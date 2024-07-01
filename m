Return-Path: <linux-fsdevel+bounces-22889-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 005B191E5B9
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Jul 2024 18:48:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F36D1C20DBA
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Jul 2024 16:48:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30C6A16DC12;
	Mon,  1 Jul 2024 16:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gIyifpVb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4489418635
	for <linux-fsdevel@vger.kernel.org>; Mon,  1 Jul 2024 16:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719852519; cv=none; b=tGnIknQG43VqMP0QyA//q5Rz7YvSIE28uaWwn1JGtsOJMsTYg3WLnwTAUiToed8B4UvcZku9MPrhL/a2vHJaMnA4npcppB55ZHbDpHyC1RAonaDz7J0kHtP+8eGQ3tKu+7lb7MFV9LxcVSdVHWuIW6Og/bMhOe5R8WMjx/hCWA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719852519; c=relaxed/simple;
	bh=1/+Nu5FYCzMUgShdDXomqvuwMffEsyb54CG/M4FIT4M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YVKUC2Ij8NDfCVBVeHZtlJFsJoulRWlz5pA7VQqjPn5vMVkiyoYwVwzz2+GIjpVZcVNNAoc5DQvXEJzxdzMJ6Cmwb5xc0DLfenETGTNs/DR2ELrjnVafwjW12zXtp0iWm9TgSWjWZY3aghe1Da+YhTCakY3hiEd85qVVaC+pZ4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gIyifpVb; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-64f2fe21015so6942447b3.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 01 Jul 2024 09:48:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719852517; x=1720457317; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P6SsBwX+j6RnP2+owSIF9xFMIeYR6k9uNBJCga6R/28=;
        b=gIyifpVbnaM0Nr/i7vKuqwJ9oiXxmxIHDnV0nwozO1gxfobW0w5qF1Iixh2aNtEUUQ
         3JlFA2WUiUi2P9Vf/WMFE24LurFV9PbXX0xJabFm79BSQVk+g0bLY3TUehCQ5dAD9AGt
         YnC+cae6n2G+KImKYxMw8wp5UFcmVOTzDQM5gqbGOALrt5fbQnhN6qSa1I32768ALYlY
         YjYhA6hVyK85UAJ1/vXZWsJFvdLsND4lomtyQmPbojyFvTDEWcMYxN89//Z0jYQAI273
         yMx7MV2tjVtOlvD8qJCGgKp0YWAd/BfCWM1rWvGULcJvOzpN64khBSrfAji7JyfDC6pK
         dOsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719852517; x=1720457317;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P6SsBwX+j6RnP2+owSIF9xFMIeYR6k9uNBJCga6R/28=;
        b=si6x0ngxEtQ3vDGD80wFi2YvkPXbdfBkW6t31X1Wx2FQP/eEpxr/WRQWBPTVsXrv2r
         H4mzkoaiPu4NhMKaws0Filo80wrWcUW0ThDMjf32trx8aEDvFDDtMX8OlRf+uJXwMRdL
         yXTahYo1Rs7hrogoOhYTJRMngm8dv/H/DINJkuvM+68wMMtiBYmMc4qNLRcZHjSPcqQT
         obsyZL8lCfC/eLz0FRuWPoYJvs0wPSyJOxebDmX+EO3ndeN1BCdaR0phw+wRZisuXCNJ
         tWk6uw2eG9YIEAIJ/rLRKzMfZR/6W23IKhTp3hFt9BJ8A4hGAe81HOHDQXKMfcH5qS1w
         dmGA==
X-Forwarded-Encrypted: i=1; AJvYcCUI3x0evaJ2Hek0Tztvo9l1V40NmL8Tyf35vLqKn4Narp8W3yRV/arrV0jU6j5CUCfn3Tfteyy9syVvRQZ7HIWMvg+reyOSV91ocZNxGw==
X-Gm-Message-State: AOJu0YwxwEqhP8xgz3Lz1uBuq1IVHGoRri4giP8vyi4HY3XSANHmao5j
	mRFtfqbghnJPk4y/oSxeB4mijkdSleoxb2IjL9TqcJ1ysUvP5Tu1uTh8ie/4yaofrTdXN7Wk1BZ
	AdlfyN2zNIFlypDQvtg9aRLq8bYpJSQ==
X-Google-Smtp-Source: AGHT+IGaQ6g7zkqUVnoR0DULYqU39HwgtR6wjGajKPg18Nc3ulm21e+qwOfL4TIaMmhgBVQ6VnZogIFVQ62cjdZ+e48=
X-Received: by 2002:a05:690c:3708:b0:643:5fde:8ebf with SMTP id
 00721157ae682-64c72d40294mr88797217b3.35.1719852517156; Mon, 01 Jul 2024
 09:48:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240628001355.243805-1-joannelkoong@gmail.com> <20240628180305.GA413049@perftesting>
In-Reply-To: <20240628180305.GA413049@perftesting>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Mon, 1 Jul 2024 09:48:26 -0700
Message-ID: <CAJnrk1YAt-dRUMYdS8TyyiXYG32nNBc_gTE0FeP0=XCZF3-pQA@mail.gmail.com>
Subject: Re: [PATCH] fuse: Enable dynamic configuration of FUSE_MAX_MAX_PAGES
To: Josef Bacik <josef@toxicpanda.com>
Cc: miklos@szeredi.hu, linux-fsdevel@vger.kernel.org, osandov@osandov.com, 
	laoji.jx@alibaba-inc.com, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 28, 2024 at 11:03=E2=80=AFAM Josef Bacik <josef@toxicpanda.com>=
 wrote:
>
> On Thu, Jun 27, 2024 at 05:13:55PM -0700, Joanne Koong wrote:
> > Introduce the capability to dynamically configure the FUSE_MAX_MAX_PAGE=
S
> > limit through a sysctl. This enhancement allows system administrators t=
o
> > adjust the value based on system-specific requirements.
> >
> > This removes the previous static limit of 256 max pages, which limits
> > the max write size of a request to 1 MiB (on 4096 pagesize systems).
> > Having the ability to up the max write size beyond 1 MiB allows for the
> > perf improvements detailed in this thread [1].
> >
> > $ sysctl -a | grep fuse_max_max_pages
> > fs.fuse.fuse_max_max_pages =3D 256
> >
> > $ sysctl -n fs.fuse.fuse_max_max_pages
> > 256
> >
> > $ echo 1024 | sudo tee /proc/sys/fs/fuse/fuse_max_max_pages
> > 1024
> >
> > $ sysctl -n fs.fuse.fuse_max_max_pages
> > 1024
> >
> > [1] https://lore.kernel.org/linux-fsdevel/20240124070512.52207-1-jeffle=
xu@linux.alibaba.com/T/#u
> >
> > Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
>
> Overall the change is great, and I see why you named it the way you did, =
but I
> think may be 'fuse_max_pages_limit' may be a better name?  The original c=
onstant
> name wasn't great, but it was fine in its context.  I think having it as =
an
> interface we should name it something less silly.

'fuse_max_pages_limit' sounds great to me. I'll submit v2 with this rename.

>
> I'm not married to this thought, what do the rest of you think?  Whatever=
 name
> we settle on is fine, you can add
>
> Reviewed-by: Josef Bacik <josef@toxicpanda.com>
>
> once we settle on the right name for this.  Thanks,
>
> Josef


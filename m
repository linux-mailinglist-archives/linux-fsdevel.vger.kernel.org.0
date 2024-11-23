Return-Path: <linux-fsdevel+bounces-35632-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F9249D6846
	for <lists+linux-fsdevel@lfdr.de>; Sat, 23 Nov 2024 10:01:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 65C80281DC3
	for <lists+linux-fsdevel@lfdr.de>; Sat, 23 Nov 2024 09:01:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC73817A5A4;
	Sat, 23 Nov 2024 09:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="Krh3un5w"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22427257D
	for <linux-fsdevel@vger.kernel.org>; Sat, 23 Nov 2024 09:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732352495; cv=none; b=SClw+PDtEXOqcuENg6P/UIRj08mr/btwJ4eAnqWwlIDeb5Qy9BjYph2QXxQ+UpfVZfsrYlq8iR/0M7rdxNYf7Rl5yqPTzTaI21mBTK+yDi3ef7U+8rsGCP0oAtxEVE7WxdjZJaXifFNNmY3aMYjeab6neVl684ErV8XJEDfWZYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732352495; c=relaxed/simple;
	bh=jn3jBILo+uDYc8/UF9FILhwsx3ELCEnKu2+O4+G1BA8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W5P2p39c1U5UlXibrxibQ5IH/PNfoJ7IWc/J8Pd65Wo07vTKgxyhAuI63JxXfJfQgMx88IVn5kgj8a6N2zas0Xww5ADrc542Dalweie5c61Z+tr71tQTIkt68tB/v6euNixr5AZ8nm4wzO1wQKmqzpEfwI6u4g+P3I3fAMHd/5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=Krh3un5w; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-4613162181dso18431431cf.3
        for <linux-fsdevel@vger.kernel.org>; Sat, 23 Nov 2024 01:01:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1732352492; x=1732957292; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=DFiXzXBKT2EId4oxO52uRUCqeKRX7R+7nWgLka8QQYU=;
        b=Krh3un5wS9/WiWRQ+PsgWFeBPBvSVOxUpL0P+Gzj88Li8neGW7MHgkEbTfRJhZeV7/
         JzK0Jta/pkHZXKQRZFYFtMey9gzliZuXFpv3aeTPmjrdp/jbSioc4bM2w5LmvknqKpFY
         Cxx9c6R8m+qYDeLArdhEiPUp0963UpO+v4bbs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732352492; x=1732957292;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DFiXzXBKT2EId4oxO52uRUCqeKRX7R+7nWgLka8QQYU=;
        b=HHFQmtYPTDSPjZ5vIkx1UTEm6WNaPAlh15IpZ2rNnn9TCHncwosTmyUER682ieKHLG
         VTseyq3Q+AYGBpdXrkpo+a255h4jUOkPRVRTWjpPqIAtpairFOkZpLZSOJOI7yVGp0S1
         bpSQBMGwPPWfyva+tymMPdhuLMJzs/8b1rdmrKWZpiEpzp3TLThI028C5w9VcuK1h8cN
         +31fkhjiy2cyria1Gp+V01I1qtrkbW7iddqZWyTtCs5zFnv5Hcvx6uK46m2G/pXwngK9
         xwQQCwTIaAxoQIQA/dWdyMEnKli7vkdfXLdMWH1U6Wof+hHi4hP5+sBvKNv4HxPxhSGd
         rEsQ==
X-Forwarded-Encrypted: i=1; AJvYcCV1WDOcOZJc+qpAWhJEyDvfLl4Vd1j2G9lbdROYoTvswu6eaSyPNMl9yBtN/UVDrcBlkpXDEemX8t3PbAPS@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4n7e9RbSlqFJSQQ0kHle6KW2D3M/eyJnIAa+JUjTYh6dkCx7o
	jc2jbmPgA4Rg1na5S6Zqu5jvQlZEgmknOczaS82gVVXd17PxfBl8F17w5V47v9mdEKgoYjIDpe0
	JuBx03tdddQAgOBQwCIpL1e0bAYD1kYz616bTQQ==
X-Gm-Gg: ASbGnctErug3zDwQ8C+cVuZFHmoy56IfT6mRfS7JPtOpsHCXtzNw7m5Z5c/XRkERiH1
	laiZnBryKuRYGczIvaKe8F00QmWIZ6mo2pA==
X-Google-Smtp-Source: AGHT+IF85E/yXEC4k+4bx41PiOx4JBk4RgLR089oIqv0TSCWg27hIBqkf+JsWUUQwo2HY7/suEoxPtLxQChNoQWC0QE=
X-Received: by 2002:a05:622a:188f:b0:461:22e9:5c54 with SMTP id
 d75a77b69052e-4653d5c30e6mr72458871cf.26.1732352491772; Sat, 23 Nov 2024
 01:01:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241122-fuse-uring-for-6-10-rfc4-v6-0-28e6cdd0e914@ddn.com> <20241122-fuse-uring-for-6-10-rfc4-v6-5-28e6cdd0e914@ddn.com>
In-Reply-To: <20241122-fuse-uring-for-6-10-rfc4-v6-5-28e6cdd0e914@ddn.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Sat, 23 Nov 2024 10:01:21 +0100
Message-ID: <CAJfpeguPCUajx=LX-M2GFO4hzi6A2uc-8tijHEFVSipK7xFU5A@mail.gmail.com>
Subject: Re: [PATCH RFC v6 05/16] fuse: make args->in_args[0] to be always the header
To: Bernd Schubert <bschubert@ddn.com>
Cc: Jens Axboe <axboe@kernel.dk>, Pavel Begunkov <asml.silence@gmail.com>, 
	linux-fsdevel@vger.kernel.org, io-uring@vger.kernel.org, 
	Joanne Koong <joannelkoong@gmail.com>, Josef Bacik <josef@toxicpanda.com>, 
	Amir Goldstein <amir73il@gmail.com>, Ming Lei <tom.leiming@gmail.com>, David Wei <dw@davidwei.uk>, 
	bernd@bsbernd.com
Content-Type: text/plain; charset="UTF-8"

On Fri, 22 Nov 2024 at 00:44, Bernd Schubert <bschubert@ddn.com> wrote:

> diff --git a/fs/fuse/dax.c b/fs/fuse/dax.c
> index 12ef91d170bb3091ac35a33d2b9dc38330b00948..e459b8134ccb089f971bebf8da1f7fc5199c1271 100644
> --- a/fs/fuse/dax.c
> +++ b/fs/fuse/dax.c
> @@ -237,14 +237,17 @@ static int fuse_send_removemapping(struct inode *inode,
>         struct fuse_inode *fi = get_fuse_inode(inode);
>         struct fuse_mount *fm = get_fuse_mount(inode);
>         FUSE_ARGS(args);
> +       struct fuse_zero_in zero_arg;

I'd move this to global scope (i.e. just a single instance for all
uses) and rename to zero_header.

> diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
> index fd8898b0c1cca4d117982d5208d78078472b0dfb..6cb45b5332c45f322e9163469ffd114cbc07dc4f 100644
> --- a/fs/fuse/dev.c
> +++ b/fs/fuse/dev.c
> @@ -1053,6 +1053,19 @@ static int fuse_copy_args(struct fuse_copy_state *cs, unsigned numargs,
>
>         for (i = 0; !err && i < numargs; i++)  {
>                 struct fuse_arg *arg = &args[i];
> +
> +               /* zero headers */
> +               if (arg->size == 0) {
> +                       if (WARN_ON_ONCE(i != 0)) {
> +                               if (cs->req)
> +                                       pr_err_once(
> +                                               "fuse: zero size header in opcode %d\n",
> +                                               cs->req->in.h.opcode);
> +                               return -EINVAL;
> +                       }

Just keep the WARN_ON_ONCE() and drop everything else, including
return -EINVAL.  The same thing should happen without the arg->size ==
0 check.

Thanks,
Miklos


Return-Path: <linux-fsdevel+bounces-8302-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DB698328AB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Jan 2024 12:20:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B7DBF1F2361B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Jan 2024 11:20:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ABAA4C629;
	Fri, 19 Jan 2024 11:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="UR0ictAH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5421041C94
	for <linux-fsdevel@vger.kernel.org>; Fri, 19 Jan 2024 11:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705663231; cv=none; b=aStLK/ehiis1PtoGciOv518oBt7ZQ7EUgtnAMgnR109JsRGS3gqkZaloGbGQZBw4c1tGMR4ms1tOlfR6IASlkBj6cUJ2jHtRK3Wmgz95icX/8ZzGGKXSMQF3Eh8b4MdUrIB2gESnt+JFXLLUmUEQnP5KhOP2boI1PcpIc7IU9hM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705663231; c=relaxed/simple;
	bh=Yn3beNcYVdkSQtS6/dBDhptz4UylN9AibkVXgjj+5cw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XY+uHjKk9GYHx9r6kw1/GoPf3m0ndCToK3tYPZWrsqimdesquBpIl/kxia9wyOb+TsjRVQ5G66naBGn81/nwMnd2V6UbbbhhUb8/pJP2Ss9PlIrMjKTUKXE9oWFLh3+8S8oViZprDbxj2FvKjPP+gMGjTvS0y8Qd29q8diRg9DU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=UR0ictAH; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a2a17f3217aso65095266b.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 19 Jan 2024 03:20:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1705663227; x=1706268027; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=aBnEhmd7NsyYgMJlScUd0DjTZJ/ci/Yzod3zpcsS7dw=;
        b=UR0ictAHCO+Z+D8beR7f8YY1zuYjVj7ajXMPZaRk3i//F6NRoVfEcQ/+7cZPIyuOZO
         Uxnr8AfpnB4/Hx+ABeWpeu0FCRCSLFCgfMBU5B2JQwKqlLYCjk/v2ARvmfFYgirrmPko
         hLKQU3BkAet+naV9vczKLtkufn04EHZDlEjNw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705663227; x=1706268027;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aBnEhmd7NsyYgMJlScUd0DjTZJ/ci/Yzod3zpcsS7dw=;
        b=F7Dfz0sTD4Ao4RYN6njllcQF9x03k+sjhupET7dY1Wxy27XoEAeucXVhT2lxmXHl2X
         0KNQHNfrpX3axg0uDF5iEeOrcFuRqYu8hXTXPKwb5OL6iwZ6BVQBMrV0goWTKungwrUz
         kE+B8vE2mrf29muTjgNrJHm/XVDL0SyfI427sy+TNOpeFWktRUD6upboP+smyn5QeufJ
         a6xr+JUnpxuUuxJ9FK1PgtGozLoJ4jqFz3wX8rG350lB1MBiRu/cWaJu5fDTIs0g798Y
         B3rANfb6V1UEmaXjeNiaFtVQgjndmsu1rjge91dB3hP1rLKz+sg2VnOwEaYkuuUCtQwc
         JY6g==
X-Gm-Message-State: AOJu0YwaTm5qkhEGj4kMiG95OL85d8jOkCo4wBwRAHkUByZ+1hRe34FN
	sIzQYCpAiGwetgDbiCOKOpIJWcEbNvbv4iiXz17ywLznczNuL+g28KEzHNbJ4Qm0OQQ2fk/kXI9
	8EPu7vfIQHZUCSviJdYn0aydPFwt7S7/TeLu/UQ==
X-Google-Smtp-Source: AGHT+IFCQLaF1tDjz+sXrYQawR2okyMyjiGZHvJkLev2PMKBOhhjOBWThWDhX+/QlA1615Oc/gfaHB7iQZNRSNa3gBQ=
X-Received: by 2002:a17:907:a4c8:b0:a2e:d789:1cd1 with SMTP id
 vq8-20020a170907a4c800b00a2ed7891cd1mr1713739ejc.15.1705663227289; Fri, 19
 Jan 2024 03:20:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240119101454.532809-1-mszeredi@redhat.com> <CAOQ4uxiWtdgCQ+kBJemAYbwNR46ogP7DhjD29cqAw0qqLvQn4A@mail.gmail.com>
In-Reply-To: <CAOQ4uxiWtdgCQ+kBJemAYbwNR46ogP7DhjD29cqAw0qqLvQn4A@mail.gmail.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Fri, 19 Jan 2024 12:20:15 +0100
Message-ID: <CAJfpegteroc6yJAmjh=MaqZOO9Q7ZJfg5BgMJFN3wdHGZK6gGw@mail.gmail.com>
Subject: Re: [PATCH v2] ovl: require xwhiteout feature flag on layer roots
To: Amir Goldstein <amir73il@gmail.com>
Cc: Miklos Szeredi <mszeredi@redhat.com>, linux-unionfs@vger.kernel.org, 
	Alexander Larsson <alexl@redhat.com>, linux-fsdevel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 19 Jan 2024 at 12:08, Amir Goldstein <amir73il@gmail.com> wrote:

> > @@ -577,6 +580,8 @@ static int ovl_dir_read_impure(const struct path *path,  struct list_head *list,
> >         INIT_LIST_HEAD(list);
> >         *root = RB_ROOT;
> >         ovl_path_upper(path->dentry, &realpath);
> > +       if (ovl_path_check_xwhiteouts_xattr(ofs, &ofs->layers[0], &realpath))
> > +               rdd.in_xwhiteouts_dir = true;
>
> Not needed since we do not support xwhiteouts on upper.

Right.

> > @@ -1079,6 +1090,8 @@ static int ovl_get_layers(struct super_block *sb, struct ovl_fs *ofs,
> >                 l->name = NULL;
> >                 ofs->numlayer++;
> >                 ofs->fs[fsid].is_lower = true;
> > +
> > +
>
> extra spaces.

Sorry, missing self review...

> Do you want me to fix/test and send this to Linus?

Yes please, if it's not a problem four you.

Thanks,
Miklos


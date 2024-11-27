Return-Path: <linux-fsdevel+bounces-35944-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BCC619DA019
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Nov 2024 01:50:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A38D168DA2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Nov 2024 00:50:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A4008F49;
	Wed, 27 Nov 2024 00:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QPkJ7nTO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47283360;
	Wed, 27 Nov 2024 00:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732668638; cv=none; b=aE/SLPM1teykufm3iEyV7m6tYwqA3oJvwRbTRs/gFcV2FenKUATdU3me4WCijsd+xbx489ZuTMSrQ3tj879EKstAiX/+SZQ3FLIA3fFDID21G7KXeo6oTecNe9PZx0wiB60ZAUXJPMEBrvvSE0nk27l7LqGunMBLY2zZcNakNGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732668638; c=relaxed/simple;
	bh=t1hVwwhncVAUj/Lm9r7LI34ioqQ7kMq0x+fo0u4M8Q0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pyoyJFf9vDBNBwidywUODSbgMQa/DytmVIp4AApJXcJTiq5j61nXolfOuUFhMspKmcQcNssk1Vx7dXwylPYk0liAExZTgQwUTJVgWryPUQintj0Tby9WDW8gOvGO4ubTFz0naiSwjsayfob1MKIbvTx7/ci2xEf/OesN2oxf8Hk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QPkJ7nTO; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-43497839b80so27619645e9.2;
        Tue, 26 Nov 2024 16:50:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732668634; x=1733273434; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j3EkoerGTLMLe4OrsMDgak1/GJweiL9MEJTp4Bxm4Oc=;
        b=QPkJ7nTOAqL7nwYQZbew6Jcz+9wC6VCi1AJtWi0Eyp5d5CnDpTQ+9voWMZpJkzt+yC
         RTb5h+v74CF1YKDVw6atVKGg9qcI3Pezl3ZRJJscESDOa4fFO95izCqb4qDLYqI8HDG7
         Nv5+DzJheds/FLqrleTKPqOXRCkpXeCtIoGf+/hLt7+A+ZhLpdzBSrqBBsuF6PB92Odn
         6wXOC1A0qmDQsEIsZyOkoCQ8jLn7hlfUTUoT79RQRcQ60COGqfWKe5L+fI0JayxAWwE4
         oPIwjFSqpBqs6T94EA6kFxBfNSiXALj8IOZDkeXgRryDPMXNuLMQldxmPiUiU/UZDBRK
         6cLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732668634; x=1733273434;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j3EkoerGTLMLe4OrsMDgak1/GJweiL9MEJTp4Bxm4Oc=;
        b=wV1joy3pFX7CFyQKMnr6RcojZdFOrmCOM1VeJtkiybeLPWf7eTr1Ml0k2Fv5CJDB+y
         EFiBCSLwTYu7Nx1zvYJl5FUglfeP4/23QIlzZWUf76XVvjPvL4iUwF7k+4okOXI2uumj
         jmPX1QgCSLt03Y9buIl9FbJjadVoYNrU1FeSZcKyGiLeYWAevi76BR0666I/5Kz5YRlv
         znZe96IzRyO26V4Rn0MWR5x4X6NdEQq1CAcPt6Lw1186U7CgZcnkmeWpHxGu+8evZSnf
         RT+R2T5REI3AZlpCQvohYja45HbOlfLdpFRkHUvM5iGTpQIVkKDy5AmW1skNLepXaP8Q
         978w==
X-Forwarded-Encrypted: i=1; AJvYcCV5txyAorvv3Ewd8gcRmWwULuuW26thTaFlRQt16qkRslAtMjUhqrR0HG2+gfnKFHi6plPCx0VNMmwsRPAL@vger.kernel.org, AJvYcCVvHLKb/Pm9Iyg+aDukr/drsYgmCxBAvmGnQjZva/fk2M0v8wCVo3ZTzCvntiZ+hcgQwWy/f9WpumXywPM0mQ==@vger.kernel.org, AJvYcCWUev8K6l1iM8mlO9a9NCk6tNenu1vDneLdw1dAFkn/+soVOCzisfTThBxpZtxJhnmDfFo=@vger.kernel.org, AJvYcCWzEpW0vng2fSzHMNferCARPcCh3pABmWVq/9JevUD9SRgYciS53SUOlcxE65YOtL2waxMAMAJZfGeLvNgCy3Ty9TEyjUVM@vger.kernel.org
X-Gm-Message-State: AOJu0Yw54rS6hGxSPE51KBQLnxCb0+tsq/pXQNesjTM0CSOLOYhzcx1B
	V0kAZk3rxSFsaGq5mWDTY1WU+2N0YJwer4/7/x3Oa6jJz4hZf+9pFH+ET1qZp3Cy3PhfMI9dvbQ
	xcIk6siAAVuP1VAXeuIlixAjP4QA=
X-Gm-Gg: ASbGncsZ5AiWUiihJdGK3ye3Wt7UIg0ovju+mbmtUajwfUN5VSt9wjaqYJqEO1ZU91X
	weIciTThg1YEGTPqcKKt9uz9NW/Q9PXhdU59mgDwat7cqQeA=
X-Google-Smtp-Source: AGHT+IFylzibwq1l1tgeIghi7zw0a98fwkBarp9Liyrr2JP3fgWDlTpjUXEBRNTykRpSKDm4u8WaYRM6y926pb50xhI=
X-Received: by 2002:a05:6000:18ab:b0:381:f08b:71a4 with SMTP id
 ffacd0b85a97d-385c6edd52dmr635501f8f.45.1732668634501; Tue, 26 Nov 2024
 16:50:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241122225958.1775625-1-song@kernel.org> <20241122225958.1775625-3-song@kernel.org>
 <CAOQ4uxhfd8ryQ6ua5u60yN5sh06fyiieS3XgfR9jvkAOeDSZUg@mail.gmail.com>
In-Reply-To: <CAOQ4uxhfd8ryQ6ua5u60yN5sh06fyiieS3XgfR9jvkAOeDSZUg@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 26 Nov 2024 16:50:23 -0800
Message-ID: <CAADnVQK-6MFdwD_0j-3x2-t8VUjbNJUuGrTXEWJ0ttdpHvtLOA@mail.gmail.com>
Subject: Re: [PATCH v3 fanotify 2/2] samples/fanotify: Add a sample fanotify fiter
To: Amir Goldstein <amir73il@gmail.com>
Cc: Song Liu <song@kernel.org>, bpf <bpf@vger.kernel.org>, 
	Linux-Fsdevel <linux-fsdevel@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	LSM List <linux-security-module@vger.kernel.org>, Kernel Team <kernel-team@meta.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Eddy Z <eddyz87@gmail.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, KP Singh <kpsingh@kernel.org>, 
	Matt Bobrowski <mattbobrowski@google.com>, repnop@google.com, 
	Jeff Layton <jlayton@kernel.org>, Josef Bacik <josef@toxicpanda.com>, 
	=?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, gnoack@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 23, 2024 at 9:07=E2=80=AFPM Amir Goldstein <amir73il@gmail.com>=
 wrote:
> > +++ b/samples/fanotify/filter-mod.c
> > @@ -0,0 +1,105 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +/* Copyright (c) 2024 Meta Platforms, Inc. and affiliates. */
> > +
> > +#include <linux/fsnotify.h>
> > +#include <linux/fanotify.h>
> > +#include <linux/module.h>
> > +#include <linux/path.h>
> > +#include <linux/file.h>
> > +#include "filter.h"
> > +
> > +struct fan_filter_sample_data {
> > +       struct path subtree_path;
> > +       enum fan_filter_sample_mode mode;
> > +};
> > +
> > +static int sample_filter(struct fsnotify_group *group,
> > +                        struct fanotify_filter_hook *filter_hook,
> > +                        struct fanotify_filter_event *filter_event)
> > +{
> > +       struct fan_filter_sample_data *data;
> > +       struct dentry *dentry;
> > +
> > +       dentry =3D fsnotify_data_dentry(filter_event->data, filter_even=
t->data_type);
> > +       if (!dentry)
> > +               return FAN_FILTER_RET_SEND_TO_USERSPACE;
> > +
> > +       data =3D filter_hook->data;
> > +
> > +       if (is_subdir(dentry, data->subtree_path.dentry)) {
> > +               if (data->mode =3D=3D FAN_FILTER_SAMPLE_MODE_BLOCK)
> > +                       return -EPERM;
> > +               return FAN_FILTER_RET_SEND_TO_USERSPACE;
> > +       }
> > +       return FAN_FILTER_RET_SKIP_EVENT;
> > +}
> > +
> > +static int sample_filter_init(struct fsnotify_group *group,
> > +                             struct fanotify_filter_hook *filter_hook,
> > +                             void *argp)
> > +{
> > +       struct fan_filter_sample_args *args;
> > +       struct fan_filter_sample_data *data;
> > +       struct file *file;
> > +       int fd;
> > +
> > +       args =3D (struct fan_filter_sample_args *)argp;
> > +       fd =3D args->subtree_fd;
> > +
> > +       file =3D fget(fd);
> > +       if (!file)
> > +               return -EBADF;
> > +       data =3D kzalloc(sizeof(struct fan_filter_sample_data), GFP_KER=
NEL);
> > +       if (!data) {
> > +               fput(file);
> > +               return -ENOMEM;
> > +       }
> > +       path_get(&file->f_path);
> > +       data->subtree_path =3D file->f_path;
> > +       fput(file);
> > +       data->mode =3D args->mode;
> > +       filter_hook->data =3D data;
> > +       return 0;
> > +}
> > +
> > +static void sample_filter_free(struct fanotify_filter_hook *filter_hoo=
k)
> > +{
> > +       struct fan_filter_sample_data *data =3D filter_hook->data;
> > +
> > +       path_put(&data->subtree_path);
> > +       kfree(data);
> > +}
> > +
>
> Hi Song,
>
> This example looks fine but it raises a question.
> This filter will keep the mount of subtree_path busy until the group is c=
losed
> or the filter is detached.
> This is probably fine for many services that keep the mount busy anyway.
>
> But what if this wasn't the intention?
> What if an Anti-malware engine that watches all mounts wanted to use that
> for configuring some ignore/block subtree filters?
>
> One way would be to use a is_subtree() variant that looks for a
> subtree root inode
> number and then verifies it with a subtree root fid.
> A production subtree filter will need to use a variant of is_subtree()
> anyway that
> looks for a set of subtree root inodes, because doing a loop of is_subtre=
e() for
> multiple paths is a no go.
>
> Don't need to change anything in the example, unless other people
> think that we do need to set a better example to begin with...

I think we have to treat this patch as a real filter and not as an example
to make sure that the whole approach is workable end to end.
The point about not holding path/dentry is very valid.
The algorithm needs to support that.
It may very well turn out that the logic of handling many filters
without a loop and not grabbing a path refcnt is too complex for bpf.
Then this subtree filtering would have to stay as a kernel module
or extra flag/feature for fanotify.


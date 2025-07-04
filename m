Return-Path: <linux-fsdevel+bounces-53901-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 043D4AF8AF5
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Jul 2025 10:16:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CFD2C8026BD
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Jul 2025 08:12:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D63B2FBFE7;
	Fri,  4 Jul 2025 07:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TGHVUoCf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDE792F7CE5;
	Fri,  4 Jul 2025 07:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751615715; cv=none; b=OCGHx4cQq3TTGczo+kS5dGShYFaePbW/9MB7q4uJdJ1iop9WUYkbuUgqbYo0oB7iCFATtR74TYngFzV1vvVzd3RlHvvJI2RxyEZSHzXmk653rJ7C5AjvGWlg3MZPQqbNpaRUzxUK64nfjQ2MZ4MjFCex4IL1WMNiEZ8YeJtf2Hc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751615715; c=relaxed/simple;
	bh=g5Qwv3E6Y5AzhAoHAIoso2lcbLsyKVgZSLviisDZlBk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nI6iqEhg30pTQKEnge/tko+haZHvQHVhfuWe0d1JVvwprZNnPKeINLrOQrfwQAs3I57Gdg95D2XQiGSx8kUVJomiL1sJ93P1PYyCKTKPp3QrEizcJ52J3vFXtsHOt2TW5oLxjwjTTy9yw2e9CxnV1ozHJTroJOJ/Na/qB8I7zg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TGHVUoCf; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-acb5ec407b1so110868866b.1;
        Fri, 04 Jul 2025 00:55:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751615709; x=1752220509; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KqTjHtFUDnwHiahJgAdrD1pVSqjrxzaMh3NEMJveZz8=;
        b=TGHVUoCfczslT4Cszm3O2JE88Xe+7CM0ElkGVuXMV4t1ZrdpVVHyfGJJie4cTZQmdq
         pQthGf/GK1Ow8YqzMaB7Nb+V9xNGb39p7pwj9Rq6kjc3SC6Rn8Iexf9JhMrODMtIhC3E
         ffqO9PlVBobxEdY2bl/D7sedpenn9sSM+zEPEW9A9UgFo/W58//osc1Ysiq6/C2nvgTq
         v3kJajqirPtVqae7yq1Gy5XvcvM4ol8VEb1V7Tx1Dfc/XVpa9qrxFwwtP9HUUwW4K7p4
         Jto/Q70qVuhiwbvN1dZiZaa8pcuhMXP1Dx2dOCBH7HmeI4gce+IjcRcV6K8DX1jxY2k8
         YMZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751615709; x=1752220509;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KqTjHtFUDnwHiahJgAdrD1pVSqjrxzaMh3NEMJveZz8=;
        b=Brl26zIt4RmMIx4IIAF1x3C+mTMH1p/DBwbjrorj0ECl51Of+dwraPoIjcBT9EarZZ
         Rig0yKUlXNERi2+jzxz3PC8sFrQnHB323ElhqMJHPRQm5BwyRBAimyjTQ25Chqkghwro
         bij2XR265UShP4lL44MsFr78+fJiNvKlN4G+eCNVgRGzzOg8CQWO7jHGywpVL0FeGKuF
         MtM6GV10dkxeRQkAAWkFgkya1rjwGFXfr2awT1SbwKjgCvF9XOwCl9Ew92S1HecOzpy9
         JKVB9kRYgu9NowzFNkCxhKoaUOSCiL5c6+Y60/5pWjR5hZ0KQxuNlK3EzSwUfo8eYfZ/
         m3Bg==
X-Forwarded-Encrypted: i=1; AJvYcCU08/cWFgwvCVrBn2VKz4ttsTxi3hOHO9uWgWY2qpNKYKDq0wuZE8MtNk9UB61oEbyACyiU61246yvntMOuAQ==@vger.kernel.org, AJvYcCVywHV8WyT03APVzlovESO5z8INVufiMtZ3Xfa3g/NWA0SZ8Dfhbp/qugk9CCO+aZueAHn+Af4C4l2WyLB+@vger.kernel.org, AJvYcCW7CRVzua9sZwP8qBQUb3otz0aNDPWNT+KilDPbbXH6C/ecvHr8SQDbGrsOFdladQZLugSNNynD44NW@vger.kernel.org, AJvYcCWhV6euYQD1pgCxQk+9NVkSFALTqAf925QoEdt0fETnG3ydtFv/n3dreaG33eI3y73HDnnGI7OgQBw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwtCZUSn6KtOHnaeocUFP8I9aCR9cvC93f8gNZzodU2qLMcIHRY
	DyL4NQglzVO7RpSPJO9Hb5dv9+1gLvxiPh4sxlW4OXDj4ZLcEmnfdNvYmQzPzUbLxAhlMtUDOsV
	tl60bf+gjZMhLfko5ETO51G01YZ2jO3Q=
X-Gm-Gg: ASbGncsvXM1WSs1lnBcNxsO+k/H61mp0klpYXOSLX6XyfdMzRYdR125RweFD6e5l/Yz
	y0yEwbvJgjKrBwoboI73Yx24TRG3xs5735QlcQ8E2CYCvlwEgFZjEKYinT2+GEP6LVGSCH9WUeP
	HhFdmHV4dqUaoLlKjpI0vP/v46mvo6t1Nx67+PiL8ebwV03/xRyjJaPA==
X-Google-Smtp-Source: AGHT+IHbu/7trC65/DeYLqxtEkSBbngCiJCl8lGS3daoUK+l03S1ER+X1QI0bHRXSoe9V0uZOz3GBHDUIYUYwFgLXPA=
X-Received: by 2002:a17:906:681a:b0:ad2:417b:2ab5 with SMTP id
 a640c23a62f3a-ae3fbde92a2mr99463566b.60.1751615708510; Fri, 04 Jul 2025
 00:55:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250703185032.46568-1-john@groves.net> <20250703185032.46568-11-john@groves.net>
In-Reply-To: <20250703185032.46568-11-john@groves.net>
From: Amir Goldstein <amir73il@gmail.com>
Date: Fri, 4 Jul 2025 09:54:57 +0200
X-Gm-Features: Ac12FXx2fL6cg_25gbv1TfaaBei9pa2nMH_xl-QIp40xf5dKMB13gicr8ctumWk
Message-ID: <CAOQ4uxi7fvMgYqe1M3_vD3+YXm7x1c4YjA=eKSGLuCz2Dsk0TQ@mail.gmail.com>
Subject: Re: [RFC V2 10/18] famfs_fuse: Basic fuse kernel ABI enablement for famfs
To: John Groves <John@groves.net>, "Darrick J . Wong" <djwong@kernel.org>
Cc: Dan Williams <dan.j.williams@intel.com>, Miklos Szeredi <miklos@szeredb.hu>, 
	Bernd Schubert <bschubert@ddn.com>, John Groves <jgroves@micron.com>, Jonathan Corbet <corbet@lwn.net>, 
	Vishal Verma <vishal.l.verma@intel.com>, Dave Jiang <dave.jiang@intel.com>, 
	Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
	Randy Dunlap <rdunlap@infradead.org>, Jeff Layton <jlayton@kernel.org>, 
	Kent Overstreet <kent.overstreet@linux.dev>, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, nvdimm@lists.linux.dev, 
	linux-cxl@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	Jonathan Cameron <Jonathan.Cameron@huawei.com>, Stefan Hajnoczi <shajnocz@redhat.com>, 
	Joanne Koong <joannelkoong@gmail.com>, Josef Bacik <josef@toxicpanda.com>, 
	Aravind Ramesh <arramesh@micron.com>, Ajay Joshi <ajayjoshi@micron.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 3, 2025 at 8:51=E2=80=AFPM John Groves <John@groves.net> wrote:
>
> * FUSE_DAX_FMAP flag in INIT request/reply
>
> * fuse_conn->famfs_iomap (enable famfs-mapped files) to denote a
>   famfs-enabled connection
>
> Signed-off-by: John Groves <john@groves.net>
> ---
>  fs/fuse/fuse_i.h          |  3 +++
>  fs/fuse/inode.c           | 14 ++++++++++++++
>  include/uapi/linux/fuse.h |  4 ++++
>  3 files changed, 21 insertions(+)
>
> diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
> index 9d87ac48d724..a592c1002861 100644
> --- a/fs/fuse/fuse_i.h
> +++ b/fs/fuse/fuse_i.h
> @@ -873,6 +873,9 @@ struct fuse_conn {
>         /* Use io_uring for communication */
>         unsigned int io_uring;
>
> +       /* dev_dax_iomap support for famfs */
> +       unsigned int famfs_iomap:1;
> +

pls move up to the bit fields members.

>         /** Maximum stack depth for passthrough backing files */
>         int max_stack_depth;
>
> diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
> index 29147657a99f..e48e11c3f9f3 100644
> --- a/fs/fuse/inode.c
> +++ b/fs/fuse/inode.c
> @@ -1392,6 +1392,18 @@ static void process_init_reply(struct fuse_mount *=
fm, struct fuse_args *args,
>                         }
>                         if (flags & FUSE_OVER_IO_URING && fuse_uring_enab=
led())
>                                 fc->io_uring =3D 1;
> +                       if (IS_ENABLED(CONFIG_FUSE_FAMFS_DAX) &&
> +                           flags & FUSE_DAX_FMAP) {
> +                               /* XXX: Should also check that fuse serve=
r
> +                                * has CAP_SYS_RAWIO and/or CAP_SYS_ADMIN=
,
> +                                * since it is directing the kernel to ac=
cess
> +                                * dax memory directly - but this functio=
n
> +                                * appears not to be called in fuse serve=
r
> +                                * process context (b/c even if it drops
> +                                * those capabilities, they are held here=
).
> +                                */
> +                               fc->famfs_iomap =3D 1;
> +                       }

1. As long as the mapping requests are checking capabilities we should be o=
k
    Right?
2. What's the deal with capable(CAP_SYS_ADMIN) in process_init_limits then?
3. Darrick mentioned the need for a synchronic INIT variant for his work on
    blockdev iomap support [1]

I also wonder how much of your patches and Darrick's patches end up
being an overlap?

Thanks,
Amir.

[1] https://lore.kernel.org/linux-fsdevel/20250613174413.GM6138@frogsfrogsf=
rogs/


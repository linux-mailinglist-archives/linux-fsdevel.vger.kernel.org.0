Return-Path: <linux-fsdevel+bounces-47014-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 88C57A97C2A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Apr 2025 03:36:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 480C63B478B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Apr 2025 01:36:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79D852627E5;
	Wed, 23 Apr 2025 01:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MglYp341"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A4D228EC;
	Wed, 23 Apr 2025 01:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745372181; cv=none; b=YG53BQsR/82lzNgaDsQy/Aa+L/48hGAbdGFyAB6wqdaXjbZsaBJT/VzNUkua+kGliCpUSKKL4lJaGRyywZsXTIepuNw+AILGppYSj0DZn24A20bAxklThHJXEXYeD6JUg+qs9A7mXPiQUEgh8YMoYrAD4tE52o/6u6AQlVGjf+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745372181; c=relaxed/simple;
	bh=UNUzIQyqmwpZ9sBm60WtCTjqwiWikkrXeZHbhkw7c8w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MGDBYVVFdQ2sNr0kbZKMsYF/byIlpMql0r8qGLmWBUhLSItoONibN4g8x5/W+jR7T6xgKgqdWcsl/GWwrWiklR8DX3ZtArHezB31zzJL4tC3mY4soaUQ/K1B5oi7y7htdprt6+1K9BPeug5eAJM8nnjLlGeZFYIpMYquIiCLynw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MglYp341; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-47ae894e9b7so96680291cf.3;
        Tue, 22 Apr 2025 18:36:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745372179; x=1745976979; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YDT0JiTKLEu56zROMSHzh4vPHYYpIB515ncCYLjb8lQ=;
        b=MglYp3412YP1PUHQAaYmbLnsujuoiDGO8Gak6afbc3glJbMxAmv5mXh2vb1PbMU05f
         jHa0F9DzxyUfywlCsXVqU2JWqYcaL5ud88jRzDse38diurM5lCNNpN5/uaHG3kBtqqEa
         /Ey4Fpu7GJnTeP1uWCiUei49kBFW4MBNdpbxns9QPb1YtlYXtate4OeQHsYVj8+K9mj5
         Hcl6P9z4uI4jrh83A4SKru2cY8RsM+UOZGqA/etzLwL4L8foSXwebIkCpNTPXaBx+iD2
         R+Cr3jJXKhV9w9fC2m5Bgt0F2c+HEHSOR1aUt9kg9XqnJTPw7jei1XPnMaKZvStOLZmQ
         dE+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745372179; x=1745976979;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YDT0JiTKLEu56zROMSHzh4vPHYYpIB515ncCYLjb8lQ=;
        b=twersfGzXwny4QvM2wJW2LxkVsL25glXuJasWA0WmI9ezDy6E7MMV0L3ROl5hVB+Fx
         6B72opRU4gpLufCWKIMGtMbm22KLaDZH6x4g/+sc0eqUX6BvrU31agkbgHA36oQNcleC
         PAynUjVS90gjf6b+f6+p3yPKWl3pOXwfA9jtFFn8s3ZMEzA8n9ZZndJpM+jAMIyL3PFj
         gbUpF3Q4SuDX8DCKKy/datQW59NvTRbAKm8NCQVJykd5uxGbav9XCFdASuScGYxamw6h
         pbOlD+gYAaQkEu6Fr+Auowg+XD8XPb1ruuVBLS5d0UWVC5bq2m2OOoTvqFeW3yWWiOSP
         rUJg==
X-Forwarded-Encrypted: i=1; AJvYcCUDVG2PT0gvCUV4aEZakQ7jRGVeEL4/aFnvTsLchNc8YP3juWVBQVQYfG1dNVMnxXfXH14X1a3WN853VoT2@vger.kernel.org, AJvYcCWdNgo7LCMcWFWj14URy9kgMdy9Es/nDEXge2v5Cxoj05cRQNpQLVM7gmIB6zRdA1sh34d2BUeeu6E=@vger.kernel.org, AJvYcCWpPDjVu4JGR/hjythYzW8uOMtvWc/NKH7+r3wPdifK4Wd0XXypL41k1aY4xfSf+bZX6jjepRRkpGMr@vger.kernel.org, AJvYcCXQNOCo/JrFMD/LaWcGUFIuVx5ZXntqxS59U3iDCzX5/GrSXDiamXohOwxwtcYW5TUJKFv2bDZRzityMUZfng==@vger.kernel.org
X-Gm-Message-State: AOJu0YwQiMtdfh8VT5u4yiXIO+3DsnX2XX05P3mzK1NVAPiZFsuFff3h
	kNkUdojUkf01fXtYPP9sIO0bEE8ES4BhoAmZQI4P0wLMxAkTGUrKgrVBtvzvBA74Biw1M7NBZaP
	MjAQwPwpjbup4e9chV6WMLH/LGIc=
X-Gm-Gg: ASbGnctTmuYZfXcowV/KuT+UvKzTFPecQryLM90A4eHoSLc3jnY+O7pvjTlt03OWGoE
	cxcuYDXOKdcmxeRwyivldOhdZGGq/2+IoZhqfPJcFjSGYfpvho6PR8KpGbuGlHsO7iY9fiY0zZQ
	rZzVAi/nZ3U/FG93KFLgKfZWD+gsl5zB/GcLLDT9cpuIqbWRR9
X-Google-Smtp-Source: AGHT+IHlzbvrCevbApD7jzszD6VGDVewMdGYPbCuvZGd+5reLhfdOJmEbpvrMu7I8oAOdE1MkMv/KOclzr8B5UZ2tug=
X-Received: by 2002:a05:622a:2c1:b0:476:8a1d:f18e with SMTP id
 d75a77b69052e-47aec49fef3mr297955681cf.36.1745372179161; Tue, 22 Apr 2025
 18:36:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250421013346.32530-1-john@groves.net> <20250421013346.32530-11-john@groves.net>
In-Reply-To: <20250421013346.32530-11-john@groves.net>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Tue, 22 Apr 2025 18:36:08 -0700
X-Gm-Features: ATxdqUG7M4Ilbi4JBAoLnTSvKlGK4nbtG_HG8a5cZaDG6t4Rd0KpBRJjL7Ttc8I
Message-ID: <CAJnrk1aROUeJY2g8vHtTgVc=mb+1+7jhJE=B3R0qV_=o6jjNTA@mail.gmail.com>
Subject: Re: [RFC PATCH 10/19] famfs_fuse: Basic fuse kernel ABI enablement
 for famfs
To: John Groves <John@groves.net>
Cc: Dan Williams <dan.j.williams@intel.com>, Miklos Szeredi <miklos@szeredb.hu>, 
	Bernd Schubert <bschubert@ddn.com>, John Groves <jgroves@micron.com>, Jonathan Corbet <corbet@lwn.net>, 
	Vishal Verma <vishal.l.verma@intel.com>, Dave Jiang <dave.jiang@intel.com>, 
	Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
	"Darrick J . Wong" <djwong@kernel.org>, Luis Henriques <luis@igalia.com>, 
	Randy Dunlap <rdunlap@infradead.org>, Jeff Layton <jlayton@kernel.org>, 
	Kent Overstreet <kent.overstreet@linux.dev>, Petr Vorel <pvorel@suse.cz>, 
	Brian Foster <bfoster@redhat.com>, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, nvdimm@lists.linux.dev, 
	linux-cxl@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	Amir Goldstein <amir73il@gmail.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
	Stefan Hajnoczi <shajnocz@redhat.com>, Josef Bacik <josef@toxicpanda.com>, 
	Aravind Ramesh <arramesh@micron.com>, Ajay Joshi <ajayjoshi@micron.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Apr 20, 2025 at 6:34=E2=80=AFPM John Groves <John@groves.net> wrote=
:
>
> * FUSE_DAX_FMAP flag in INIT request/reply
>
> * fuse_conn->famfs_iomap (enable famfs-mapped files) to denote a
>   famfs-enabled connection
>
> Signed-off-by: John Groves <john@groves.net>
> ---
>  fs/fuse/fuse_i.h          | 3 +++
>  fs/fuse/inode.c           | 5 +++++
>  include/uapi/linux/fuse.h | 2 ++
>  3 files changed, 10 insertions(+)
>
> diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
> index e04d160fa995..b2c563b1a1c8 100644
> --- a/fs/fuse/fuse_i.h
> +++ b/fs/fuse/fuse_i.h
> @@ -870,6 +870,9 @@ struct fuse_conn {
>         /* Use io_uring for communication */
>         unsigned int io_uring;
>
> +       /* dev_dax_iomap support for famfs */
> +       unsigned int famfs_iomap:1;
> +
>         /** Maximum stack depth for passthrough backing files */
>         int max_stack_depth;
>
> diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
> index 29147657a99f..5c6947b12503 100644
> --- a/fs/fuse/inode.c
> +++ b/fs/fuse/inode.c
> @@ -1392,6 +1392,9 @@ static void process_init_reply(struct fuse_mount *f=
m, struct fuse_args *args,
>                         }
>                         if (flags & FUSE_OVER_IO_URING && fuse_uring_enab=
led())
>                                 fc->io_uring =3D 1;
> +                       if (IS_ENABLED(CONFIG_FUSE_FAMFS_DAX) &&
> +                                      flags & FUSE_DAX_FMAP)
> +                               fc->famfs_iomap =3D 1;
>                 } else {
>                         ra_pages =3D fc->max_read / PAGE_SIZE;
>                         fc->no_lock =3D 1;
> @@ -1450,6 +1453,8 @@ void fuse_send_init(struct fuse_mount *fm)
>                 flags |=3D FUSE_SUBMOUNTS;
>         if (IS_ENABLED(CONFIG_FUSE_PASSTHROUGH))
>                 flags |=3D FUSE_PASSTHROUGH;
> +       if (IS_ENABLED(CONFIG_FUSE_FAMFS_DAX))
> +               flags |=3D FUSE_DAX_FMAP;
>
>         /*
>          * This is just an information flag for fuse server. No need to c=
heck
> diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
> index 5e0eb41d967e..f9e14180367a 100644
> --- a/include/uapi/linux/fuse.h
> +++ b/include/uapi/linux/fuse.h
> @@ -435,6 +435,7 @@ struct fuse_file_lock {
>   *                 of the request ID indicates resend requests
>   * FUSE_ALLOW_IDMAP: allow creation of idmapped mounts
>   * FUSE_OVER_IO_URING: Indicate that client supports io-uring
> + * FUSE_DAX_FMAP: kernel supports dev_dax_iomap (aka famfs) fmaps
>   */
>  #define FUSE_ASYNC_READ                (1 << 0)
>  #define FUSE_POSIX_LOCKS       (1 << 1)
> @@ -482,6 +483,7 @@ struct fuse_file_lock {
>  #define FUSE_DIRECT_IO_RELAX   FUSE_DIRECT_IO_ALLOW_MMAP
>  #define FUSE_ALLOW_IDMAP       (1ULL << 40)
>  #define FUSE_OVER_IO_URING     (1ULL << 41)
> +#define FUSE_DAX_FMAP          (1ULL << 42)

There's also a protocol changelog at the top of this file that tracks
any updates made to the uapi. We should probably also update that to
include this?


Thanks,
Joanne
>
>  /**
>   * CUSE INIT request/reply flags
> --
> 2.49.0
>


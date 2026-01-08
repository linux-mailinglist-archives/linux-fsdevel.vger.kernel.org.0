Return-Path: <linux-fsdevel+bounces-72953-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FAFCD0668D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 08 Jan 2026 23:13:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8BA2E302352F
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Jan 2026 22:13:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6994E32ED34;
	Thu,  8 Jan 2026 22:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DgfYwKdh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2A70322B64
	for <linux-fsdevel@vger.kernel.org>; Thu,  8 Jan 2026 22:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767910379; cv=none; b=gCBEDYBPfn7LWeCwEcclkLJOpp48Yi60qvT3pHrqzENp3lMlLU4xhGtJBBETV5UfyYo8J5ZEKoDcigMzYayrhlzRqom2hZ5IDEi+diibqL9w+vDHl3VtkcSeelbZ7ZlDrSUGULrg5jhyraLaPK+jSs+SneVKSc9r5rPLdio3qg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767910379; c=relaxed/simple;
	bh=Zn78kWlqbbar/LoTcObXeiFgJqEyKn8nf3ElzgX1rpM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ceHOd4/fZ0YKwhe6idexH+gNJBrXW24GxC1aJu/iuD8/HG6o0Flh/VVB4mwJViRRkIFYUDRZy8MQGHjN7/qi1Vs5vTq1tdAscKQc7O2A+vxAcTiPn9aYH7/Au4RrjAXlU6hJdfcVt/9JmKvj2q34cur1oTU5u05svGM4qpS96Vs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DgfYwKdh; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-4ee05b2b1beso35184161cf.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 08 Jan 2026 14:12:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767910376; x=1768515176; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fi+fnNi5xbFv1sgcsW+SwRsE20MqRGIKkmzMGGxW7zw=;
        b=DgfYwKdhHeldxYtsK5iS8tmIn/ljiLUeLicPV7tBiElFM1naVXR9dENqZGWVuryh9y
         pzUrNjSn2rN9DtJ1BMlIsAiNNx/iFPlw8ewhBmvIEV6noEloju+g66ReNnx4yzSczxwo
         0VijgLosTcqnDT8QblXk/wismaq+ly6mjbAaDwaClNWjYyacFx8CF8diEjuJPaiPCLKI
         jzf+H6MVKvL6gJdD+xeJssDcMLXsXJd/xxGPMTtQA3dUZYimx+HzbhN2Il2O0/JKAaYX
         Sc1WyvFVd+DJM4M838Rh3v9DmE2tq5RkPs2q3qbHExMWlBSyhxj3SXu9EDgsfvoMKt6o
         LY1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767910376; x=1768515176;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fi+fnNi5xbFv1sgcsW+SwRsE20MqRGIKkmzMGGxW7zw=;
        b=v/Qv2CAy2i8ATa4M7EUdjTXEqUg3Keg5JPZB1LQ7ZSDwwyzzFMg2zy0idA2wRXD69j
         pPlDOYPOLbOp74JocfB8+32XF+CU/I/tZ+94Zd5CRgaTIvwKZJl9pytypuW+cVrhS8O5
         5oq3ypYSHQ9tDZmCyvKifC+CjoDaMNBh8KDb4YQsEY+vR6NjoKJrIWqr6eGwHTe5fF/y
         6fMU6l87UsTSOLnLmMuxv5+MlP1EsepKg4ryhFH+tgfh/V9BpjSsd2vA+TTElHYS1xNx
         N5UazREqLjeGXPlQsYngvnQPREafi7dYcl49nXYTtZ1MRwQYS9z3h89635xORGIgvxFA
         WJIQ==
X-Forwarded-Encrypted: i=1; AJvYcCWfS/YEuhz6RWc4Th7OYLP3Y58K7Mz/wtg8PzuCi+kS00YVzJ8ijkldHfOHzpsGY0I+hIkB/hyiHqraLOli@vger.kernel.org
X-Gm-Message-State: AOJu0YxMvEPfO1ZKWg2x9BHM895VxoSIlg2wY85aE8VieM80FaAg+ZRp
	h1VS2OT9WSzbULPWXE5NEkGBJsXoBvmoDNzbdbWCqubDV2fOMmwhaqWT6ZkUfW2f2rmZk5eGuAO
	HZBr06A9fwQaMiwh8M0etjz+mfI+wnjc=
X-Gm-Gg: AY/fxX64XRsECVnPAziRDHJAjN7i9cfESBklcYh55CJXc9Y7jRCQXH6ho3d3qlFT4+U
	vc8s5a4VZqiCbaE73IRaZecXAWEysuQvfFPIS18ImTXKgujicM+2CbbQqXaeJbE4Qg9BGDuLIoT
	k6vFKRRzj1YBvuKtLcaE/OkHea7WIxd2pVMvTwbHIdFrwNM+sb8D4megSMJ0iv6lyJMSVAFBM21
	7TnXpAfxrHg/3CpvaKCsOmV7Lak9SJCvcdRhFtZQEX11Ed64jmSccaNqrgl6i8nh7I2rw==
X-Google-Smtp-Source: AGHT+IFwsTMPez/J49tbSGOv2+0dDJrW8HJxAU/y+Rr2DP9l881+AfcKVSgUSWVNVNRw3xheYtESBpqh+GLST/PcCYs=
X-Received: by 2002:a05:622a:249:b0:4f1:83e4:7247 with SMTP id
 d75a77b69052e-4ffb4abeea3mr104318101cf.60.1767910376363; Thu, 08 Jan 2026
 14:12:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260108-fuse-compounds-upstream-v3-0-8dc91ebf3740@ddn.com>
 <20260108-fuse-compounds-upstream-v3-1-8dc91ebf3740@ddn.com> <9a35aa50-1f1d-4d50-aac7-3e0d8bbd7613@bsbernd.com>
In-Reply-To: <9a35aa50-1f1d-4d50-aac7-3e0d8bbd7613@bsbernd.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Thu, 8 Jan 2026 14:12:45 -0800
X-Gm-Features: AQt7F2rMTgORrwMkKAzq_kYDEO8soFgq3YsSaSAHSo2UMNZMXPtC4bvUcDC579U
Message-ID: <CAJnrk1anWXks-JRmEGaYUYuxNqFjBoXsyuT5w2fwbMRcSa5w7w@mail.gmail.com>
Subject: Re: [PATCH RFC v3 1/3] fuse: add compound command to combine multiple requests
To: Bernd Schubert <bernd@bsbernd.com>
Cc: horst@birthelmer.com, Miklos Szeredi <miklos@szeredi.hu>, 
	Bernd Schubert <bschubert@ddn.com>, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, Horst Birthelmer <hbirthelmer@ddn.com>, 
	syzbot@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 8, 2026 at 2:01=E2=80=AFPM Bernd Schubert <bernd@bsbernd.com> w=
rote:
>
> On 1/8/26 15:23, horst@birthelmer.com wrote:
> > From: Horst Birthelmer <hbirthelmer@ddn.com>
> >
> > For a FUSE_COMPOUND we add a header that contains information
> > about how many commands there are in the compound and about the
> > size of the expected result. This will make the interpretation
> > in libfuse easier, since we can preallocate the whole result.
> > Then we append the requests that belong to this compound.
> >
> > The API for the compound command has:
> >   fuse_compound_alloc()
> >   fuse_compound_add()
> >   fuse_compound_send()
> >   fuse_compound_free()
> >
> > Signed-off-by: Horst Birthelmer <hbirthelmer@ddn.com>
> > Tested-by: syzbot@syzkaller.appspotmail.com
> > ---
> >  fs/fuse/Makefile          |   2 +-
> >  fs/fuse/compound.c        | 276 ++++++++++++++++++++++++++++++++++++++=
++++++++
> >  fs/fuse/fuse_i.h          |  12 ++
> >  include/uapi/linux/fuse.h |  37 +++++++
> >  4 files changed, 326 insertions(+), 1 deletion(-)
> >
> > diff --git a/fs/fuse/Makefile b/fs/fuse/Makefile
> > index 22ad9538dfc4..4c09038ef995 100644
> > --- a/fs/fuse/Makefile
> > +++ b/fs/fuse/Makefile
> > @@ -11,7 +11,7 @@ obj-$(CONFIG_CUSE) +=3D cuse.o
> >  obj-$(CONFIG_VIRTIO_FS) +=3D virtiofs.o
> >
> >  fuse-y :=3D trace.o    # put trace.o first so we see ftrace errors soo=
ner
> > -fuse-y +=3D dev.o dir.o file.o inode.o control.o xattr.o acl.o readdir=
.o ioctl.o
> > +fuse-y +=3D dev.o dir.o file.o inode.o control.o xattr.o acl.o readdir=
.o ioctl.o compound.o
> >  fuse-y +=3D iomode.o
> >  fuse-$(CONFIG_FUSE_DAX) +=3D dax.o
> >  fuse-$(CONFIG_FUSE_PASSTHROUGH) +=3D passthrough.o backing.o
> > diff --git a/fs/fuse/compound.c b/fs/fuse/compound.c
> > new file mode 100644
> > index 000000000000..2f292ae3e816
> > --- /dev/null
> > +++ b/fs/fuse/compound.c
> > @@ -0,0 +1,276 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * FUSE: Filesystem in Userspace
> > + * Copyright (C) 2025
> > + *
> > + * This file implements compound operations for FUSE, allowing multipl=
e
> > + * operations to be batched into a single request to reduce round trip=
s
> > + * between kernel and userspace.
> > + */
> > +
> > +#include "fuse_i.h"
> > +
> > +/*
> > + * Compound request builder and state tracker and args pointer storage
> > + */
> > +struct fuse_compound_req {
> > +     struct fuse_mount *fm;
> > +     struct fuse_compound_in compound_header;
> > +     struct fuse_compound_out result_header;
> > +
> > +     /* Per-operation error codes */
> > +     int op_errors[FUSE_MAX_COMPOUND_OPS];
> > +     /* Original fuse_args for response parsing */
> > +     struct fuse_args *op_args[FUSE_MAX_COMPOUND_OPS];
> > +
> > +     bool parsed;                            /* Prevent double-parsing=
 of response */
>
> Just for Joanne and other reviewers, Horst is preparing the next
> version, this 'parsed' is also going to be removed.

Sounds great, thanks for the update. I'll wait for the next version
before reviewing.

Thanks,
Joanne
>
> > +};


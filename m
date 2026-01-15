Return-Path: <linux-fsdevel+bounces-73868-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5080FD222B3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jan 2026 03:42:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0FFA73053737
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jan 2026 02:41:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FC9F27815D;
	Thu, 15 Jan 2026 02:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HHbV07O7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EDD62517B9
	for <linux-fsdevel@vger.kernel.org>; Thu, 15 Jan 2026 02:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768444873; cv=none; b=eJbuV7rXTJ9927y+goLUQyHUObyl8Vr440ArUZ2aokQpd1wOeMNMjuHInGdqcDRWockA/u/+m5owzY0BwDq1q6XgJ39lR0hoSF1LdhHkK7I0xKWWiD6uRDJoD1k0VZWGsOlq29oQR4h2htIf1ObVMKFq4TGv4f+xKiU+Zk1vIsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768444873; c=relaxed/simple;
	bh=RXGOV+i33zQVOlcq5hgnCatqqvmet2wjXrGfTWS7AJE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ssGI9A/2bda/U567w9FUyKm3fW43poeo33kTlNftD0/u22k8ib5VGILAz+o4O7KrJp1Rfc2j6diKXeZzBP540Pre959azbN97TelTJESg+o7WzgL8l4kwOnWBKvVEv9OW/+NZfAH344V8m5/oEF5aFwdbGZofoRCG05eemuhf2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HHbV07O7; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-88a37cb5afdso20659266d6.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 14 Jan 2026 18:41:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768444871; x=1769049671; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wTSDvkC/imf6P83hhRwrHGQeAOUw58nB0CyE2ExbIkE=;
        b=HHbV07O7yfEQuEi3bxZqhAjbnPDnsBbEjMN3F55SaRWt7BV8xpZM46RPNWcNuGGSoY
         V7WMR6NtVQyC9GqFcD7r4hyxttcc2q76duvHGYqmVuTW/9Jq0wAnIpj1NNFD1FLLEH5q
         +V4e9ZMj0Zfm64LZtOo9916oXw4xcbsi2ifvmD32G8kRxmE4KNNqXdegHOOmaQdqozgC
         V++APyjY+8Zyhj2Lpf3hMbsDKrX1hxmIWi2QaqF0an//X59Nfafl7rRSKw2xTndD3GUO
         KOdVsfEvmB7CI602jXsPbwiPFSsDuuj3ESVd7B24c+UO5Mn5zm5hFEMJ54GKQnqDymJX
         JGqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768444871; x=1769049671;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wTSDvkC/imf6P83hhRwrHGQeAOUw58nB0CyE2ExbIkE=;
        b=ZgNY7tU5JzMqCBGHisZl/gdultMM6CC+qx/fgTT64BPc3TmWyrBYXK/y3HU/UsYstC
         vyu7QYgndspd9sealGZj8OXRXbho0fZXlYKpE7ajxuaYyu/s4HUs3Gk+6zknWcHaviwr
         +Ay4tjUu8qrkyCHudyRz5xM4MBpNPdGNGbsIOE/52/jC4i8uKKeaFXcf6kDQr/NZnHzk
         XBYCmCLiUJ2aUI0La0R0XWzQ2ivxKdjGGxL3DHgIJ/SfaYztvQS2O2H1fmR/pjhz7xXg
         +gWxgGHYjzMvyGiAqFj1ooSRI0IdLe8dpsqQH+/PWGFEQXAbUQQxrPVsSicR4jSQHeVy
         +nYA==
X-Forwarded-Encrypted: i=1; AJvYcCVlv6HoSw28CXm2V9MHFgB19t0fuui+H+znQrqOJBlePH24w5drf/6ClZtM543aCL96waj+Px3cCX2bGAVa@vger.kernel.org
X-Gm-Message-State: AOJu0Yyxmk+f4YGi78VF2Vj+iKdZ6vaVmoLduPzja/aL9x68232hvtsC
	T42Kw+G3W1UHlniNw2IPePV29rj15p1ZEptSgZGM2NlXfiiDJf0mGHUZ9dhZlG/njdMIG0bvlcy
	Xc17R8Zt9BCC5P0gyW2r/kOSM7ctfVPtht9Fu
X-Gm-Gg: AY/fxX5IK835NUJ1v5LguMy1YtS0CMepsjyU3LWMukIfY+nNFRy2gzxYC0uXw9y6n8L
	WkEetPIMalQhysUTal5Xx+7bEt7+0L334d4rXsmHVj0vXrMZz9Spit0qxYFmxo0WyQuVC4lr/qo
	mLiMeCNIl54y+7+DkB1RbBVDZcEHLz9UiJv8anXDXT/LXA+ZvASsNc/ViVjeNUpT+pzGVrXJzkt
	VSLiFHLMNNBLuvG1qYZJzzkUZTkeSBMlFcp28esCarHmoANJL8SABOCHIc4Ta0bKhjGYA==
X-Received: by 2002:ac8:7fd0:0:b0:501:4184:b59f with SMTP id
 d75a77b69052e-5019f851ca6mr25050931cf.15.1768444870647; Wed, 14 Jan 2026
 18:41:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260109-fuse-compounds-upstream-v4-0-0d3b82a4666f@ddn.com> <20260109-fuse-compounds-upstream-v4-1-0d3b82a4666f@ddn.com>
In-Reply-To: <20260109-fuse-compounds-upstream-v4-1-0d3b82a4666f@ddn.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Wed, 14 Jan 2026 18:40:59 -0800
X-Gm-Features: AZwV_Qhd3UL2HHZ61dADkhsLOfShL7ROPDzVUCahnv9B9XFcyHZWuIQJR_MyJho
Message-ID: <CAJnrk1YGyiWLjx3FF9U4z4ARAiW93mFjsEdCVxoBGGZP3hgXAg@mail.gmail.com>
Subject: Re: [PATCH v4 1/3] fuse: add compound command to combine multiple requests
To: Horst Birthelmer <horst@birthelmer.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, Bernd Schubert <bschubert@ddn.com>, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, Horst Birthelmer <hbirthelmer@ddn.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 9, 2026 at 10:27=E2=80=AFAM Horst Birthelmer <horst@birthelmer.=
com> wrote:
>
> From: Horst Birthelmer <hbirthelmer@ddn.com>
>
> For a FUSE_COMPOUND we add a header that contains information
> about how many commands there are in the compound and about the
> size of the expected result. This will make the interpretation
> in libfuse easier, since we can preallocate the whole result.
> Then we append the requests that belong to this compound.
>
> The API for the compound command has:
>   fuse_compound_alloc()
>   fuse_compound_add()
>   fuse_compound_send()
>   fuse_compound_free()
>
> Signed-off-by: Horst Birthelmer <hbirthelmer@ddn.com>
> ---
>  fs/fuse/Makefile          |   2 +-
>  fs/fuse/compound.c        | 270 ++++++++++++++++++++++++++++++++++++++++=
++++++
>  fs/fuse/fuse_i.h          |  12 +++
>  include/uapi/linux/fuse.h |  37 +++++++
>  4 files changed, 320 insertions(+), 1 deletion(-)
>
> diff --git a/fs/fuse/Makefile b/fs/fuse/Makefile
> index 22ad9538dfc4..4c09038ef995 100644
> --- a/fs/fuse/Makefile
> +++ b/fs/fuse/Makefile
> @@ -11,7 +11,7 @@ obj-$(CONFIG_CUSE) +=3D cuse.o
>  obj-$(CONFIG_VIRTIO_FS) +=3D virtiofs.o
>
>  fuse-y :=3D trace.o      # put trace.o first so we see ftrace errors soo=
ner
> -fuse-y +=3D dev.o dir.o file.o inode.o control.o xattr.o acl.o readdir.o=
 ioctl.o
> +fuse-y +=3D dev.o dir.o file.o inode.o control.o xattr.o acl.o readdir.o=
 ioctl.o compound.o
>  fuse-y +=3D iomode.o
>  fuse-$(CONFIG_FUSE_DAX) +=3D dax.o
>  fuse-$(CONFIG_FUSE_PASSTHROUGH) +=3D passthrough.o backing.o
> diff --git a/fs/fuse/compound.c b/fs/fuse/compound.c
> new file mode 100644
> index 000000000000..0f1e4c073d8b
> --- /dev/null
> +++ b/fs/fuse/compound.c
> @@ -0,0 +1,270 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * FUSE: Filesystem in Userspace
> + * Copyright (C) 2025
> + *
> + * This file implements compound operations for FUSE, allowing multiple
> + * operations to be batched into a single request to reduce round trips
> + * between kernel and userspace.
> + */
> +
> +#include "fuse_i.h"
> +
> +/*
> + * Compound request builder and state tracker and args pointer storage
> + */
> +struct fuse_compound_req {
> +       struct fuse_mount *fm;
> +       struct fuse_compound_in compound_header;
> +       struct fuse_compound_out result_header;
> +
> +       /* Per-operation error codes */
> +       int op_errors[FUSE_MAX_COMPOUND_OPS];
> +       /* Original fuse_args for response parsing */
> +       struct fuse_args *op_args[FUSE_MAX_COMPOUND_OPS];
> +};
> +
> +struct fuse_compound_req *fuse_compound_alloc(struct fuse_mount *fm, u32=
 flags)
> +{
> +       struct fuse_compound_req *compound;
> +
> +       compound =3D kzalloc(sizeof(*compound), GFP_KERNEL);
> +       if (!compound)
> +               return ERR_PTR(-ENOMEM);

imo this logic is cleaner with just returning NULL here and then on
the caller side doing

    compound =3D fuse_compound_alloc(fm, 0);
    if (!compound)
          return -ENOMEM;

instead of having to do

    if (IS_ERR(compound))
           return PTR_ERR(compound);

and dealing with all the err_ptr/ptr_err stuff

> +
> +       compound->fm =3D fm;
> +       compound->compound_header.flags =3D flags;
> +
> +       return compound;
> +}
> +
> +void fuse_compound_free(struct fuse_compound_req *compound)
> +{
> +       if (!compound)
> +               return;

The implementation of kfree (in mm/slub.c) already has a null check

> +
> +       kfree(compound);
> +}
> +
> +int fuse_compound_add(struct fuse_compound_req *compound,
> +                     struct fuse_args *args)
> +{
> +       if (!compound ||
> +           compound->compound_header.count >=3D FUSE_MAX_COMPOUND_OPS)
> +               return -EINVAL;
> +
> +       if (args->in_pages)
> +               return -EINVAL;
> +
> +       compound->op_args[compound->compound_header.count] =3D args;
> +       compound->compound_header.count++;
> +       return 0;
> +}
> +
> +static void *fuse_copy_response_data(struct fuse_args *args,
> +                                    char *response_data)
> +{
> +       size_t copied =3D 0;
> +       int i;
> +
> +       for (i =3D 0; i < args->out_numargs; i++) {
> +               struct fuse_arg current_arg =3D args->out_args[i];

struct fuse_arg *current_arg =3D &args->out_args[i]; instead? that would
avoid the extra stack copy

> +               size_t arg_size;
> +
> +               /*
> +                * Last argument with out_pages: copy to pages
> +                * External payload (in the last out arg) is not supporte=
d
> +                * at the moment
> +                */
> +               if (i =3D=3D args->out_numargs - 1 && args->out_pages)
> +                       return response_data;

imo this should be detected and error-ed out at the
fuse_compound_send() layer or is there some reason we can't do that?

> +
> +               arg_size =3D current_arg.size;
> +
> +               if (current_arg.value && arg_size > 0) {

If this is part of the args->out_numargs tally, then I think it's
guaranteed here that arg->value is non-NULL and arg->size > 0 (iirc,
the only exception to this is if out_pages is set, then arg->value is
null, but that's already protected against above).

> +                       memcpy(current_arg.value,
> +                              (char *)response_data + copied, arg_size);

Instead of doing "response_data + copied" arithmetic and needing the
copied variable, what about just updating the ptr as we go? i think
that'd look cleaner

> +                       copied +=3D arg_size;
> +               }
> +       }
> +
> +       return (char *)response_data + copied;

is this cast needed? afaict, response_data is already a char *?

> +}
> +
> +int fuse_compound_get_error(struct fuse_compound_req *compound, int op_i=
dx)
> +{
> +       return compound->op_errors[op_idx];
> +}

Hmm, looking at how this gets used by fuse_compound_open_getattr(), it
seems like a more useful api is one that scans through op_errors for
all the op indexes in the compound and returns back the first error it
encounters; then the caller doesn't need to call
fuse_compound_get_error() for every op index in the compound.

> +
> +static void *fuse_compound_parse_one_op(struct fuse_compound_req *compou=
nd,
> +                                       int op_index, void *op_out_data,
> +                                       void *response_end)
> +{
> +       struct fuse_out_header *op_hdr =3D op_out_data;
> +       struct fuse_args *args =3D compound->op_args[op_index];

op_index is taken straight from "compound->result_header.count" which
can be any value set by the server. I think we need to either add
checking for op_index value here or add checking for that in
fuse_compound_send() before it calls fuse_compound_parse_resp()

> +
> +       if (op_hdr->len < sizeof(struct fuse_out_header))
> +               return NULL;
> +
> +       /* Check if the entire operation response fits in the buffer */
> +       if ((char *)op_out_data + op_hdr->len > (char *)response_end)

Is there a reason this doesn't just define response_end as a char * in
fuse_compound_parse_resp() and pass that as a char * to this function?

> +               return NULL;
> +
> +       if (op_hdr->error !=3D 0)

nit: this could just be "if (op_hdr->error)"

> +               compound->op_errors[op_index] =3D op_hdr->error;

If this errors out, is the memcpy still needed? or should this just return =
NULL?

> +
> +       if (args && op_hdr->len > sizeof(struct fuse_out_header))

imo,  args should be checked right after the "struct fuse_args *args =3D
compound->op_args[op_index];" line in the beginning and if it's null,
t hen fuse_compound_parse_one_op() should return NULL.

> +               return fuse_copy_response_data(args, op_out_data +
> +                                              sizeof(struct fuse_out_hea=
der));
> +
> +       /* No response data, just advance past the header */
> +       return (char *)op_out_data + op_hdr->len;
> +}
> +
> +static int fuse_compound_parse_resp(struct fuse_compound_req *compound,
> +                                   u32 count, void *response,
> +                                   size_t response_size)
> +{
> +       void *op_out_data =3D response;

imo it's cleaner to just use response instead of defining a new
op_out_data variable. And if we change the response arg to char *
response instead of void * response, then that gets rid of a lot of
the char * casting.

> +       void *response_end =3D (char *)response + response_size;
> +       int i;
> +
> +       if (!response || response_size < sizeof(struct fuse_out_header))
> +               return -EIO;
> +
> +       for (i =3D 0; i < count && i < compound->result_header.count; i++=
) {

count is already compound->result_header.count or am I missing something he=
re?

> +               op_out_data =3D fuse_compound_parse_one_op(compound, i,
> +                                                        op_out_data,
> +                                                        response_end);
> +               if (!op_out_data)
> +                       return -EIO;
> +       }
> +
> +       return 0;
> +}
> +
> +ssize_t fuse_compound_send(struct fuse_compound_req *compound)
> +{
> +       struct fuse_args args =3D {
> +               .opcode =3D FUSE_COMPOUND,
> +               .nodeid =3D 0,

nit: this line can be removed

> +               .in_numargs =3D 2,
> +               .out_numargs =3D 2,
> +               .out_argvar =3D true,
> +       };
> +       size_t resp_buffer_size;
> +       size_t actual_response_size;
> +       size_t buffer_pos;
> +       size_t total_expected_out_size;
> +       void *buffer =3D NULL;
> +       void *resp_payload;
> +       ssize_t ret;
> +       int i;
> +
> +       if (!compound) {
> +               pr_info_ratelimited("FUSE: compound request is NULL in %s=
\n",
> +                                   __func__);
> +               return -EINVAL;
> +       }
> +
> +       if (compound->compound_header.count =3D=3D 0) {
> +               pr_info_ratelimited("FUSE: compound request contains no o=
perations\n");
> +               return -EINVAL;
> +       }

imo we can get rid of these two checks

> +
> +       buffer_pos =3D 0;
> +       total_expected_out_size =3D 0;

Could you move this initialization to the top where the variables get defin=
ed?

> +
> +       for (i =3D 0; i < compound->compound_header.count; i++) {

compound->compound_header.count gets used several times in this
function. i think it's worth declaring this as a separate (and less
verbose :)) variable

> +               struct fuse_args *op_args =3D compound->op_args[i];
> +               size_t needed_size =3D sizeof(struct fuse_in_header);
> +               int j;
> +
> +               for (j =3D 0; j < op_args->in_numargs; j++)
> +                       needed_size +=3D op_args->in_args[j].size;
> +
> +               buffer_pos +=3D needed_size;
> +
> +               for (j =3D 0; j < op_args->out_numargs; j++)
> +                       total_expected_out_size +=3D op_args->out_args[j]=
.size;
> +       }
> +
> +       buffer =3D kvmalloc(buffer_pos, GFP_KERNEL);

nit: imo it's cleaner to rename resp_buffer_size to buffer_size and
use that variable for this instead of using buffer_pos

imo I don't think we need kvmalloc here or below for the resp buffer
given that compound requests don't support in_pages or out_pages.

> +       if (!buffer)
> +               return -ENOMEM;
> +
> +       buffer_pos =3D 0;
> +       for (i =3D 0; i < compound->compound_header.count; i++) {
> +               struct fuse_args *op_args =3D compound->op_args[i];
> +               struct fuse_in_header *hdr;
> +               size_t needed_size =3D sizeof(struct fuse_in_header);
> +               int j;
> +
> +               for (j =3D 0; j < op_args->in_numargs; j++)
> +                       needed_size +=3D op_args->in_args[j].size;

don't we already have the op_args->in_args[] needed size from the
computation abvoe? could we just reuse that?

> +
> +               hdr =3D (struct fuse_in_header *)(buffer + buffer_pos);
> +               memset(hdr, 0, sizeof(*hdr));
> +               hdr->len =3D needed_size;
> +               hdr->opcode =3D op_args->opcode;
> +               hdr->nodeid =3D op_args->nodeid;
> +               hdr->uid =3D from_kuid(compound->fm->fc->user_ns,
> +                                    current_fsuid());
> +               hdr->gid =3D from_kgid(compound->fm->fc->user_ns,
> +                                    current_fsgid());
> +               hdr->pid =3D pid_nr_ns(task_pid(current),
> +                                    compound->fm->fc->pid_ns);

at this point i think it's worth just defining fc at the top of the
function and using that here

> +               buffer_pos +=3D sizeof(*hdr);
> +
> +               for (j =3D 0; j < op_args->in_numargs; j++) {
> +                       memcpy(buffer + buffer_pos, op_args->in_args[j].v=
alue,
> +                              op_args->in_args[j].size);
> +                       buffer_pos +=3D op_args->in_args[j].size;
> +               }
> +       }

imo this would look nicer as a separate helper function

> +
> +       resp_buffer_size =3D total_expected_out_size +
> +                          (compound->compound_header.count *
> +                           sizeof(struct fuse_out_header));
> +
> +       resp_payload =3D kvmalloc(resp_buffer_size, GFP_KERNEL | __GFP_ZE=
RO);

kvzalloc()?

> +       if (!resp_payload) {
> +               ret =3D -ENOMEM;
> +               goto out_free_buffer;
> +       }
> +
> +       compound->compound_header.result_size =3D total_expected_out_size=
;
> +
> +       args.in_args[0].size =3D sizeof(compound->compound_header);
> +       args.in_args[0].value =3D &compound->compound_header;
> +       args.in_args[1].size =3D buffer_pos;
> +       args.in_args[1].value =3D buffer;
> +
> +       args.out_args[0].size =3D sizeof(compound->result_header);
> +       args.out_args[0].value =3D &compound->result_header;
> +       args.out_args[1].size =3D resp_buffer_size;
> +       args.out_args[1].value =3D resp_payload;
> +
> +       ret =3D fuse_simple_request(compound->fm, &args);
> +       if (ret < 0)
> +               goto out;
> +
> +       actual_response_size =3D args.out_args[1].size;

since out_argvar was set for the FUSE_COMPOUND request args, ret is
already args.out_args[1].size (see  __fuse_simple_request())

> +
> +       if (actual_response_size < sizeof(struct fuse_compound_out)) {

can you explain why this checks against size of struct
fuse_compound_out? afaict from the logic in
fuse_compound_parse_resp(), actual_response_size doesn't include the
size of the compound_out struct?

Thanks,
Joanne


> +               pr_info_ratelimited("FUSE: compound response too small (%=
zu bytes, minimum %zu bytes)\n",
> +                                   actual_response_size,
> +                                   sizeof(struct fuse_compound_out));
> +               ret =3D -EINVAL;
> +               goto out;
> +       }
> +


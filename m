Return-Path: <linux-fsdevel+bounces-72564-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C4ACDCFB9D4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 07 Jan 2026 02:41:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C6C6D304A945
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Jan 2026 01:41:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5382A223DDF;
	Wed,  7 Jan 2026 01:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JarxM9rV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 998431E991B
	for <linux-fsdevel@vger.kernel.org>; Wed,  7 Jan 2026 01:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767750067; cv=none; b=OVp6FXpsko9cyn7d8ar3GUDvkOVCW97xiQgXT6ZQ5+LKZNUZYc1wOhLkRepeH93ELO/yHk54h5QTQlWqQYMCMU/2bXqjteU9rJuY73PnW5HzHENRe1ovcnltQEK4o4clRz2CZdHoP6nwppM+6QBvVKsE47JuT+mxYfhtAGjs7Ao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767750067; c=relaxed/simple;
	bh=QyGWT1HgZqMpMFmYgrqESUNuhOFIsJjoqIaFs+iKlYo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PpSRpQDrXlvNjB2RF45sNnXAcnw0u8IjwdxDaBXvtLn9mkoIvpQzuRBXcDXCwriA1Cqa5B6ElkesNReYiI/qhIVaCrTAx9+YricGkfn0Md1/zdGjuk4Xvz2xLQ0InMgKtUvBrGzqUiJqC8F2u/qN5J0UUjsLUA3HX9T+BeYYsU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JarxM9rV; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-88a26ce6619so15553676d6.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 06 Jan 2026 17:41:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767750063; x=1768354863; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j4rEpXHY07qkETvttGhHJD8v9bnkHyxpEaWLergaRKg=;
        b=JarxM9rVziEfurGqLgJ0OCxsJEWRVNyY8sb/aUY36km+IfOt/SOjyWXo0yBllVs5pT
         ITCd/JiIchuFzRR/ODSbC7SCBYqA8ocGN4Ro4ISwDKjeXC2iurlD0tZiXYv3Oue2Bupi
         hWawdhPpaeyiJDfra5b3v+mcQLS0+cyEBcZQ0CeJHDPBqFsfskMTie/Grtloit8ZQ4f8
         IUjtGpY9nVeQREDHHF7hNg+Qu+Aa4paSImkZobasTBRJCzdIxiN/dLYmk0Zo2uj0fSzd
         inYEA4T1260x7VjCtXME7hJ7dlUT4wOdK7HmLFqmerBWOP7b5lF/Q6oRC0q0CYteQ/je
         6Rvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767750063; x=1768354863;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=j4rEpXHY07qkETvttGhHJD8v9bnkHyxpEaWLergaRKg=;
        b=Dz3GnOEmxjUYaqHhsfkPNWxeiFGvY6U5Y8SbPsyboWTpe8M9WzP91lvAw9HV8h7u1z
         5VfYoLUvQzuQCrMxnY6+/acwQ9VAErsS5iLX88xICLQqrDHm+lG7EHpdFMgtQDgRT0ZJ
         oDlK2fC0VnKPEFFPMXOGjUW5WbL5+NMP2jiHxx9I5D/UuDFb9kT7PgsF2DlRVMhJeqx0
         KMMvP/R/82EVgh7VZgQDztTwZQdq9nn2v4lB+cP5myTpKUan91pzTb++8i6Q8C3BVO9/
         Q46Iv5/3e8+ELnRQw9hO0rmXRkO/FR3a3bKZuU0FNJFsabnkgHfb4f4HwQUuZICfU9GM
         2Law==
X-Forwarded-Encrypted: i=1; AJvYcCWFIY5U3dspTkAw1P2fx0a05/tNJezsrJjT5xnhaDeCElKJo1iuKGdvSTJrVy/S2ErEAytJUN2ztyntzlwI@vger.kernel.org
X-Gm-Message-State: AOJu0Yyce9uJIcYohslYx53ZJxkiwXywjTH0qALpEzBZzWDSvsSgineJ
	rrj5SEiXFOvibwXuZadPqPYG1gnwIR65MYcN6X+BkvQ1b0C7qHi3uxDvfYwDTfsLzFrOGauPg0c
	36/vQkQgBoCpidxdqHEKhU7B0W7Kzcuc=
X-Gm-Gg: AY/fxX5/2Y+pj6bx0mXZsPkpuGY+/cSAAZmYM0Z+5Ag+LwkbngfrlB/w1Dn3lMlESYS
	od/IhvcmTKZcYVXq9xgw8DRtSwU/vTAlSKVVPT+0Tvr4xxzBb+kOyNoNPWF9o+JL37+rKDJS4VA
	A+mJ/yM5IGYUFKBuk259mozZkStJUjCm7GD29YxSEUddTQVzaX+y2IFW9n47eAZ4ZDeuiaccWK2
	QWTQIhBLK7+Wu0CRgE7yXCLiVVzdhkrifrqWcXWRpZYpRDsYgJ8GyFRQ/nGGfVEg7lr7+wz8z3y
	BAKsxMDeA3ADWsnPmzvT9A==
X-Google-Smtp-Source: AGHT+IHc3t/V/tNgfPlWwIiZpz+Uq2zzH4v7pqVX3Tv5lcMUeIF/CkSImZmqR19741FuUpdfX+RQb6EBlBsVdIKQcWY=
X-Received: by 2002:a05:6214:258b:b0:890:5719:2697 with SMTP id
 6a1803df08f44-89084185a54mr15212156d6.5.1767750063270; Tue, 06 Jan 2026
 17:41:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251223-fuse-compounds-upstream-v2-0-0f7b4451c85e@ddn.com> <20251223-fuse-compounds-upstream-v2-1-0f7b4451c85e@ddn.com>
In-Reply-To: <20251223-fuse-compounds-upstream-v2-1-0f7b4451c85e@ddn.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Tue, 6 Jan 2026 17:40:52 -0800
X-Gm-Features: AQt7F2qxzm1p8tkWwxdfziCJMB6ZiEwSI7VhO5zeGdZlIhGRWCxI0spYu0qD72E
Message-ID: <CAJnrk1b-7zqqDG+vROx=eALGkrM3oU-KDx1zHZtj=F5zP+oaLQ@mail.gmail.com>
Subject: Re: [PATCH RFC v2 1/2] fuse: add compound command to combine multiple requests
To: Horst Birthelmer <hbirthelmer@googlemail.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, Bernd Schubert <bschubert@ddn.com>, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, Horst Birthelmer <hbirthelmer@ddn.com>, 
	syzbot@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 23, 2025 at 2:13=E2=80=AFPM Horst Birthelmer
<hbirthelmer@googlemail.com> wrote:
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
>   fuse_compound_request()
>   fuse_compound_free()
>
> Signed-off-by: Horst Birthelmer <hbirthelmer@ddn.com>
> Tested-by: syzbot@syzkaller.appspotmail.com
> ---
>  fs/fuse/Makefile          |   2 +-
>  fs/fuse/compound.c        | 368 ++++++++++++++++++++++++++++++++++++++++=
++++++
>  fs/fuse/dev.c             |  25 ++++
>  fs/fuse/fuse_i.h          |  14 ++
>  include/uapi/linux/fuse.h |  37 +++++
>  5 files changed, 445 insertions(+), 1 deletion(-)
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
> index 000000000000..b15014d61b38
> --- /dev/null
> +++ b/fs/fuse/compound.c
> @@ -0,0 +1,368 @@
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
> + * Compound request builder and state tracker
> + *
> + * This structure manages the lifecycle of a compound FUSE request, from=
 building
> + * the request by serializing multiple operations into a single buffer, =
through
> + * sending it to userspace, to parsing the compound response back into i=
ndividual
> + * operation results.
> + */
> +struct fuse_compound_req {
> +       struct fuse_mount *fm;
> +       struct fuse_compound_in compound_header;
> +       struct fuse_compound_out result_header;
> +
> +       size_t total_size;                      /* Total size of serializ=
ed operations */
> +       char *buffer;                           /* Buffer holding seriali=
zed requests */
> +       size_t buffer_pos;                      /* Current write position=
 in buffer */
> +       size_t buffer_size;                     /* Total allocated buffer=
 size */
> +
> +       size_t total_expected_out_size;         /* Sum of expected output=
 sizes */
> +
> +       /* Per-operation error codes */
> +       int op_errors[FUSE_MAX_COMPOUND_OPS];
> +       /* Original fuse_args for response parsing */
> +       struct fuse_args *op_args[FUSE_MAX_COMPOUND_OPS];
> +
> +       bool parsed;                            /* Prevent double-parsing=
 of response */
> +};
> +
> +struct fuse_compound_req *fuse_compound_alloc(struct fuse_mount *fm,
> +                                              uint32_t flags)
> +{
> +       struct fuse_compound_req *compound;
> +
> +       compound =3D kzalloc(sizeof(*compound), GFP_KERNEL);
> +       if (!compound)
> +               return ERR_PTR(-ENOMEM);
> +
> +       compound->fm =3D fm;
> +       compound->compound_header.flags =3D flags;
> +       compound->buffer_size =3D PAGE_SIZE;
> +       compound->buffer =3D kvmalloc(compound->buffer_size, GFP_KERNEL);
> +       if (!compound->buffer) {
> +               kfree(compound);
> +               return ERR_PTR(-ENOMEM);
> +       }
> +       return compound;
> +}
> +
> +void fuse_compound_free(struct fuse_compound_req *compound)
> +{
> +       if (!compound)
> +               return;
> +
> +       kvfree(compound->buffer);
> +       kfree(compound);
> +}
> +
> +static int fuse_compound_validate_header(struct fuse_compound_req *compo=
und)
> +{
> +       struct fuse_compound_in *in_header =3D &compound->compound_header=
;
> +       size_t offset =3D 0;
> +       int i;
> +
> +       if (compound->buffer_pos > compound->buffer_size)
> +               return -EINVAL;
> +
> +       if (!compound || !compound->buffer)
> +               return -EINVAL;
> +
> +       if (compound->buffer_pos < sizeof(struct fuse_in_header))
> +               return -EINVAL;
> +
> +       if (in_header->count =3D=3D 0 || in_header->count > FUSE_MAX_COMP=
OUND_OPS)
> +               return -EINVAL;
> +
> +       for (i =3D 0; i < in_header->count; i++) {
> +               const struct fuse_in_header *op_hdr;
> +
> +               if (offset + sizeof(struct fuse_in_header) >
> +                   compound->buffer_pos) {
> +                       pr_info_ratelimited("FUSE: compound operation %d =
header extends beyond buffer (offset %zu + header size %zu > buffer pos %zu=
)\n",
> +                                           i, offset,
> +                                           sizeof(struct fuse_in_header)=
,
> +                                           compound->buffer_pos);
> +                       return -EINVAL;
> +               }
> +
> +               op_hdr =3D (const struct fuse_in_header *)(compound->buff=
er +
> +                                                        offset);
> +
> +               if (op_hdr->len < sizeof(struct fuse_in_header)) {
> +                       pr_info_ratelimited("FUSE: compound operation %d =
has invalid length %u (minimum %zu bytes)\n",
> +                                           i, op_hdr->len,
> +                                           sizeof(struct fuse_in_header)=
);
> +                       return -EINVAL;
> +               }
> +
> +               if (offset + op_hdr->len > compound->buffer_pos) {
> +                       pr_info_ratelimited("FUSE: compound operation %d =
extends beyond buffer (offset %zu + length %u > buffer pos %zu)\n",
> +                                           i, offset, op_hdr->len,
> +                                           compound->buffer_pos);
> +                       return -EINVAL;
> +               }
> +
> +               if (op_hdr->opcode =3D=3D 0 || op_hdr->opcode =3D=3D FUSE=
_COMPOUND) {
> +                       pr_info_ratelimited("FUSE: compound operation %d =
has invalid opcode %u (cannot be 0 or FUSE_COMPOUND)\n",
> +                                           i, op_hdr->opcode);
> +                       return -EINVAL;
> +               }
> +
> +               if (op_hdr->nodeid =3D=3D 0) {
> +                       pr_info_ratelimited("FUSE: compound operation %d =
has invalid node ID 0\n",
> +                                           i);
> +                       return -EINVAL;
> +               }
> +
> +               offset +=3D op_hdr->len;
> +       }
> +
> +       if (offset !=3D compound->buffer_pos) {
> +               pr_info_ratelimited("FUSE: compound buffer size mismatch =
(calculated %zu bytes, actual %zu bytes)\n",
> +                                   offset, compound->buffer_pos);
> +               return -EINVAL;
> +       }
> +
> +       return 0;

I wonder if this is overkill to have given that the kernel is in
charge of setting up the compound request and if the code is right,
has done it correctly. imo it adds extra overhead but doesn't offer
much given that the kernel code should aalready be correct.

> +}
> +
> +int fuse_compound_add(struct fuse_compound_req *compound,
> +                     struct fuse_args *args)
> +{
> +       struct fuse_in_header *hdr;
> +       size_t args_size =3D 0;
> +       size_t needed_size;
> +       size_t expected_out_size =3D 0;
> +       int i;
> +
> +       if (!compound ||
> +           compound->compound_header.count >=3D FUSE_MAX_COMPOUND_OPS)
> +               return -EINVAL;
> +
> +       if (args->in_pages)
> +               return -EINVAL;
> +
> +       for (i =3D 0; i < args->in_numargs; i++)
> +               args_size +=3D args->in_args[i].size;
> +
> +       for (i =3D 0; i < args->out_numargs; i++)
> +               expected_out_size +=3D args->out_args[i].size;
> +
> +       needed_size =3D sizeof(struct fuse_in_header) + args_size;
> +
> +       if (compound->buffer_pos + needed_size > compound->buffer_size) {
> +               size_t new_size =3D max(compound->buffer_size * 2,
> +                                     compound->buffer_pos + needed_size)=
;
> +               char *new_buffer;
> +
> +               new_size =3D round_up(new_size, PAGE_SIZE);
> +               new_buffer =3D kvrealloc(compound->buffer, new_size,
> +                                      GFP_KERNEL);
> +               if (!new_buffer)
> +                       return -ENOMEM;
> +               compound->buffer =3D new_buffer;
> +               compound->buffer_size =3D new_size;

Hmm... when we're setting up a compound request, we already know the
size that will be needed to hold all the requests, right? Do you think
it makes sense to allocate that from the get-go in
fuse_compound_alloc() and then not have to do any buffer reallocation?
I think that also gets rid of fuse_compound_req->total_size, as that
would just be the same as fuse_compound_req->buffer_size.

> +       }
> +
> +       /* Build request header */
> +       hdr =3D (struct fuse_in_header *)(compound->buffer +
> +                                       compound->buffer_pos);
> +       memset(hdr, 0, sizeof(*hdr));
> +       hdr->len =3D needed_size;
> +       hdr->opcode =3D args->opcode;
> +       hdr->nodeid =3D args->nodeid;
> +       hdr->uid =3D from_kuid(compound->fm->fc->user_ns, current_fsuid()=
);
> +       hdr->gid =3D from_kgid(compound->fm->fc->user_ns, current_fsgid()=
);
> +       hdr->pid =3D pid_nr_ns(task_pid(current), compound->fm->fc->pid_n=
s);
> +       hdr->unique =3D fuse_get_unique(&compound->fm->fc->iq);
> +       compound->buffer_pos +=3D sizeof(*hdr);
> +
> +       for (i =3D 0; i < args->in_numargs; i++) {
> +               memcpy(compound->buffer + compound->buffer_pos,
> +                      args->in_args[i].value, args->in_args[i].size);
> +               compound->buffer_pos +=3D args->in_args[i].size;
> +       }
> +
> +       compound->total_expected_out_size +=3D expected_out_size;
> +
> +       /* Store args for response parsing */
> +       compound->op_args[compound->compound_header.count] =3D args;
> +
> +       compound->compound_header.count++;
> +       compound->total_size +=3D needed_size;
> +
> +       return 0;

Does fc->max_pages need to be accounted for as well? iirc, that's the
upper limit on how many pages can be forwarded to the server in a
request.

> +}
> +
> +static void *fuse_copy_response_data(struct fuse_args *args,
> +                                    char *response_data)
> +{
> +       size_t copied =3D 0;
> +       int arg_idx;
> +
> +       for (arg_idx =3D 0; arg_idx < args->out_numargs; arg_idx++) {
> +               struct fuse_arg current_arg =3D args->out_args[arg_idx];
> +               size_t arg_size;
> +
> +               /* Last argument with out_pages: copy to pages */
> +               if (arg_idx =3D=3D args->out_numargs - 1 && args->out_pag=
es) {
> +                       /*
> +                        * External payload (in the last out arg)
> +                        * is not supported at the moment
> +                        */
> +                       return response_data;
> +               }
> +
> +               arg_size =3D current_arg.size;
> +
> +               if (current_arg.value && arg_size > 0) {
> +                       memcpy(current_arg.value,
> +                              (char *)response_data + copied,
> +                              arg_size);
> +                       copied +=3D arg_size;
> +               }
> +       }
> +
> +       return (char *)response_data + copied;
> +}
> +
> +int fuse_compound_get_error(struct fuse_compound_req *compound, int op_i=
dx)
> +{
> +       return compound->op_errors[op_idx];
> +}
> +
> +static void *fuse_compound_parse_one_op(struct fuse_compound_req *compou=
nd,
> +                                       int op_index, void *op_out_data,
> +                                       void *response_end)
> +{
> +       struct fuse_out_header *op_hdr =3D op_out_data;
> +       struct fuse_args *args =3D compound->op_args[op_index];
> +
> +       if (op_hdr->len < sizeof(struct fuse_out_header))
> +               return NULL;
> +
> +       /* Check if the entire operation response fits in the buffer */
> +       if ((char *)op_out_data + op_hdr->len > (char *)response_end)
> +               return NULL;
> +
> +       if (op_hdr->error !=3D 0)
> +               compound->op_errors[op_index] =3D op_hdr->error;
> +
> +       if (args && op_hdr->len > sizeof(struct fuse_out_header))
> +               return fuse_copy_response_data(args, op_out_data +
> +                                              sizeof(struct fuse_out_hea=
der));
> +
> +       /* No response data, just advance past the header */
> +       return (char *)op_out_data + op_hdr->len;
> +}
> +
> +static int fuse_compound_parse_resp(struct fuse_compound_req *compound,
> +                                   uint32_t count, void *response,
> +                                   size_t response_size)
> +{
> +       void *op_out_data =3D response;
> +       void *response_end =3D (char *)response + response_size;
> +       int i;
> +
> +       if (compound->parsed)
> +               return 0;
> +
> +       if (!response || response_size < sizeof(struct fuse_out_header))
> +               return -EIO;
> +
> +       for (i =3D 0; i < count && i < compound->result_header.count; i++=
) {
> +               op_out_data =3D fuse_compound_parse_one_op(compound, i,
> +                                                        op_out_data,
> +                                                        response_end);
> +               if (!op_out_data)
> +                       return -EIO;
> +       }
> +
> +       compound->parsed =3D true;
> +       return 0;
> +}
> +
> +ssize_t fuse_compound_send(struct fuse_compound_req *compound)
> +{
> +       struct fuse_args args =3D {
> +               .opcode =3D FUSE_COMPOUND,
> +               .nodeid =3D 0,
> +               .in_numargs =3D 2,
> +               .out_numargs =3D 2,
> +               .out_argvar =3D true,
> +       };
> +       size_t expected_response_size;
> +       size_t total_buffer_size;
> +       size_t actual_response_size;
> +       void *resp_payload;
> +       ssize_t ret;
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
> +
> +       expected_response_size =3D compound->total_expected_out_size;
> +       total_buffer_size =3D expected_response_size +
> +               (compound->compound_header.count *
> +                sizeof(struct fuse_out_header));
> +
> +       resp_payload =3D kvmalloc(total_buffer_size, GFP_KERNEL | __GFP_Z=
ERO);
> +       if (!resp_payload)
> +               return -ENOMEM;
> +
> +       compound->compound_header.result_size =3D expected_response_size;
> +
> +       args.in_args[0].size =3D sizeof(compound->compound_header);
> +       args.in_args[0].value =3D &compound->compound_header;
> +       args.in_args[1].size =3D compound->buffer_pos;
> +       args.in_args[1].value =3D compound->buffer;
> +
> +       args.out_args[0].size =3D sizeof(compound->result_header);
> +       args.out_args[0].value =3D &compound->result_header;
> +       args.out_args[1].size =3D total_buffer_size;
> +       args.out_args[1].value =3D resp_payload;
> +
> +       ret =3D fuse_compound_validate_header(compound);
> +       if (ret)
> +               goto out;
> +
> +       ret =3D fuse_compound_request(compound->fm, &args);
> +       if (ret < 0)
> +               goto out;
> +
> +       actual_response_size =3D args.out_args[1].size;
> +
> +       if (actual_response_size < sizeof(struct fuse_compound_out)) {
> +               pr_info_ratelimited("FUSE: compound response too small (%=
zu bytes, minimum %zu bytes)\n",
> +                                   actual_response_size,
> +                                   sizeof(struct fuse_compound_out));
> +               ret =3D -EINVAL;
> +               goto out;
> +       }
> +
> +       ret =3D fuse_compound_parse_resp(compound, compound->result_heade=
r.count,
> +                                      (char *)resp_payload,
> +                                      actual_response_size);
> +out:
> +       kvfree(resp_payload);
> +       return ret;
> +}
> diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
> index 6d59cbc877c6..2d89ca69308f 100644
> --- a/fs/fuse/dev.c
> +++ b/fs/fuse/dev.c
> @@ -660,6 +660,31 @@ static void fuse_args_to_req(struct fuse_req *req, s=
truct fuse_args *args)
>                 __set_bit(FR_ASYNC, &req->flags);
>  }
>
> +ssize_t fuse_compound_request(
> +                               struct fuse_mount *fm, struct fuse_args *=
args)
> +{
> +       struct fuse_req *req;
> +       ssize_t ret;
> +
> +       req =3D fuse_get_req(&invalid_mnt_idmap, fm, false);
> +       if (IS_ERR(req))
> +               return PTR_ERR(req);
> +
> +       fuse_args_to_req(req, args);
> +
> +       if (!args->noreply)
> +               __set_bit(FR_ISREPLY, &req->flags);
> +
> +       __fuse_request_send(req);
> +       ret =3D req->out.h.error;
> +       if (!ret && args->out_argvar) {
> +               BUG_ON(args->out_numargs =3D=3D 0);
> +               ret =3D args->out_args[args->out_numargs - 1].size;
> +       }
> +       fuse_put_request(req);
> +       return ret;
> +}

This logic looks almost identical to the logic in
__fuse_simple_request(). Do you think it makes sense to just call into
__fuse_simple_request() here?

> +
>  ssize_t __fuse_simple_request(struct mnt_idmap *idmap,
>                               struct fuse_mount *fm,
>                               struct fuse_args *args)
> diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
> index 7f16049387d1..86253517f59b 100644
> --- a/fs/fuse/fuse_i.h
> +++ b/fs/fuse/fuse_i.h
> @@ -1273,6 +1273,20 @@ static inline ssize_t fuse_simple_idmap_request(st=
ruct mnt_idmap *idmap,
>  int fuse_simple_background(struct fuse_mount *fm, struct fuse_args *args=
,
>                            gfp_t gfp_flags);
>
> +/**
> + * Compound request API
> + */
> +struct fuse_compound_req;
> +ssize_t fuse_compound_request(struct fuse_mount *fm, struct fuse_args *a=
rgs);
> +ssize_t fuse_compound_send(struct fuse_compound_req *compound);
> +
> +struct fuse_compound_req *fuse_compound_alloc(struct fuse_mount *fm, uin=
t32_t flags);
> +int fuse_compound_add(struct fuse_compound_req *compound,
> +                   struct fuse_args *args);

Looking at how this is used in the 2nd patch (open+getattr), I see
that the args are first defined / filled out and then
fuse_compound_add() copies them into the compound request's buffer.
Instead of having a fuse_compound_add() api that takkes in filled out
args, what are your thoughts on having some api that returns back a
pointer to the compound buffer's current position, and then the caller
can just directly fill that out? I think that ends up saving a memcpy.

> +int fuse_compound_get_error(struct fuse_compound_req *compound,
> +                       int op_idx);
> +void fuse_compound_free(struct fuse_compound_req *compound);
> +

I think an alternative way of doing compound requests, though it would
only work on io-uring, is leveraging the io-uring multishot
functionality. This allows multiple cqes (requests) to be forwarded
together in one system call. Instead of batching X requests into one
fuse compound request, I think there would just be X cqes and the
normal flow of execution would remain pretty much the same (though on
the kernel side there would have to be a head "master request" that
request_wait_answer() operates on). Not sure in actuality if this
would be more complicated or simpler, but I think your approach here
probably makes more sense since it also works for /dev/fuse.

Thanks,
Joanne

>  /**
>   * Assign a unique id to a fuse request
>   */


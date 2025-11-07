Return-Path: <linux-fsdevel+bounces-67423-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C47EC3F44F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 07 Nov 2025 10:53:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D7DA3A4624
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Nov 2025 09:52:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 441072FFF9D;
	Fri,  7 Nov 2025 09:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jBL0hMsR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com [209.85.221.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4103E2D9EED
	for <linux-fsdevel@vger.kernel.org>; Fri,  7 Nov 2025 09:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762509079; cv=none; b=TtpFQl1x/PiJbBI6hqUnl0cbPrBbRX9t7CQlyX77+LUjzsppsqdNGZYFDv/ObIuMDPUUmMTBnHQqDH20nnKhT+RVxoXi7GuxmkjnZ2i/9LxV7machlBKsQydQh9tl19dmPuwTTFQm0R4OWpxkJmvuDm6MPycaFp1MROLFI0BfH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762509079; c=relaxed/simple;
	bh=++Dy/ZgaZeQxyXh0UrVW7WaILvbvHgp2azMTLaPM+n4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oUHHy1UVQM9iEyJQUpy5BCP63t5ckafxNQrAedRZVC+W1/Pp/afceTgy/34eZ5uJFsHuQaax0yqVbHIOogdYwgj6448yKkGS3Bq8fwgLvQA3Cw6XuBaWmnmTzEh5IC88MYWQOwm/+fu2NVT7vAMKHK1DMyUquqCWiWuvReF3q9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jBL0hMsR; arc=none smtp.client-ip=209.85.221.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f169.google.com with SMTP id 71dfb90a1353d-5597a0a95fcso119492e0c.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 07 Nov 2025 01:51:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762509076; x=1763113876; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fIPRsjJhgiFWlgghaKQPLlxBGWk6bsyE13wTtDPU6jo=;
        b=jBL0hMsR5wUsq5AJkur2BXCa4Zis7JXmDWLX1BkcmRxaluOMt1NJd6+T/GoZgU+v8q
         bb5+8C9dh29MyNp7oR5jvU6xugzL7JHCupLXEPbmAAIjfV66b/w0oytOMh20sShZJQ/s
         UOCknX2+wD2NKLcE0Ps2w8EzcELH29SBuxz+DmyjqeEKTf0sUPHDPeo2vIZy7+HGKPHy
         Uu1PMKMYJKDh51eG8PQXx40dlaKTAq6l5GV00HqsuumPGAaf2dqUjkbmKZw85PA1QyK/
         QEVxday9g9XmQhdpPt4n11uF8yMc+HrGy15nhzKFxbMqtcTo1ofJ7IRYD4c7W+ZQkbIn
         kNJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762509076; x=1763113876;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fIPRsjJhgiFWlgghaKQPLlxBGWk6bsyE13wTtDPU6jo=;
        b=Oups8unhXsptqYxNzOQo40CgvaBa3ehyMXcR5+8q8NQlf7ijy1SYKoPgRyP480OKd+
         Nsv3vMnPtQ9IPlvD7Zto6rVLv+dVD8HnSHDBAptww+d5LAVPvWAn8j7uSNxtv5NmXTJ4
         6y84Y0h548BomqLdSyavCrFP+cuD7fNDJC23AGA22G3NG+j8tRgCjtLPrUtpY2JvuNrW
         9gqdgKqNnZv/sBY9z6yA2LN4cHnKSzz1O7XRjtGDQGT9GVBp32LWlP5Qj4nt2eJsnDbZ
         qXrpXg8FhSSrNgpfWsyMVJSrA9335vQYicJbdGI0dHRg4D0l/NJOg71mvvd+AIFxnlgU
         UUNw==
X-Forwarded-Encrypted: i=1; AJvYcCUqgWhSmeN4MJIAMf0YBSsCZEO1D0oB0j2ugMDgQT3RNFrindDdAFH9dZuSQ02M/sm1xRjNsQ2xxb1sUsPv@vger.kernel.org
X-Gm-Message-State: AOJu0Ywn824YHpnfUlH8dC+HMQjSiprFUHH3ho+8FM6TxkP/gIIe9QL0
	wTybC1xiAbLaWsD8hXE/b4OsB4OL1skDT7QsOMWsHF82UfgSlZzyVv5R+/5OumqSVZv1Q4SB5zp
	UuRFT0GhPlF8LUIftsoVjYG4pG1Kjkqk=
X-Gm-Gg: ASbGncslhwTrICRUKbgTj0cVGeI9X4jNpII0XbOep4PZosGUlfGHGHFad9eXPEoX/fk
	zJrvfDS8wAp+BAWENGqGGEYiKyAd6EaSUJ14M/jI6MbkyMVYh5Ro000z1Q0ZGO0cH4kdpj9T6p9
	pUyMICeUEply1zG1f8puIfs/cD6pTHTWe6iEy7DwoZigdBTgqudGwnu7+eRzhnLsSkizL406ue0
	f7MUmkvOUfNtFCE5fuYyk28Ui2CIvLRE+nJUoWVr1rG9fSk8kZL2SfHH1bluW385ab5bZWbmCRj
	CQFCVfEjxx0gcxkS
X-Google-Smtp-Source: AGHT+IHI4dtmJe9YBUZyvB8I5L4B6hEjxpaY1ljtMSUY/By7YcGREckHfTAtNG3CTEMtAB9g/7xiFNrShAIGvaMlrKc=
X-Received: by 2002:a05:6122:2024:b0:559:74c4:45f8 with SMTP id
 71dfb90a1353d-559a39f8150mr754004e0c.5.1762509075760; Fri, 07 Nov 2025
 01:51:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250813093755.47599-1-nzzhao@126.com> <20250813093755.47599-2-nzzhao@126.com>
In-Reply-To: <20250813093755.47599-2-nzzhao@126.com>
From: Barry Song <21cnbao@gmail.com>
Date: Fri, 7 Nov 2025 17:51:04 +0800
X-Gm-Features: AWmQ_bnSwTKx_aQLRNGzhEJKES-0M_s2kH4__jjyDu05-szzYmSb4WEg5fa9LBQ
Message-ID: <CAGsJ_4xzX0snLs1qMfx4hkCVkZuu2U9tGMyHdJ6r9NcoP+Q30Q@mail.gmail.com>
Subject: Re: [RFC PATCH 1/9] f2fs: Introduce f2fs_iomap_folio_state
To: Nanzhe Zhao <nzzhao@126.com>
Cc: Jaegeuk Kim <jaegeuk@kernel.org>, linux-f2fs-devel@lists.sourceforge.net, 
	linux-fsdevel@vger.kernel.org, Matthew Wilcox <willy@infradead.org>, 
	Chao Yu <chao@kernel.org>, Yi Zhang <yi.zhang@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 13, 2025 at 5:39=E2=80=AFPM Nanzhe Zhao <nzzhao@126.com> wrote:
>
> Add f2fs's own per-folio structure to track
> per-block dirty state of a folio.
>
> The reason for introducing this structure is that f2fs's private flag
> would conflict with iomap_folio_state's use of the folio->private field.
> Thanks to Mr. Matthew for providing the idea. See for details:
> [https://lore.kernel.org/linux-f2fs-devel/Z-oPTUrF7kkhzJg_
> @casper.infradead.org/]
>
> The memory layout of this structure is the same as iomap_folio_state,
> except that we set read_bytes_pending to a magic number. This is because
> we need to be able to distinguish it from the original iomap_folio_state.
> We additionally allocate an unsigned long at the end of the state array
> to store f2fs-specific flags.
>
> This implementation is compatible with high-order folios, order-0 folios,
> and metadata folios.
> However, it does not support compressed data folios.
>
> Introduction to related functions:
>
> - f2fs_ifs_alloc: Allocates f2fs's own f2fs_iomap_folio_state. If it
>   detects that folio->private already has a value, we distinguish
>   whether it is f2fs's own flag value or an iomap_folio_state. If it is
>   the latter, we will copy its content to our f2fs_iomap_folio_state
>   and then free it.
>
> - folio_detach_f2fs_private: Serves as a unified interface to release
>   f2fs's private resources, no matter what it is.
>
> - f2fs_ifs_clear_range_uptodate && f2fs_ifs_set_range_dirty: Helper
>   functions copied and slightly modified from fs/iomap.
>
> - folio_get_f2fs_ifs: Specifically used to get f2fs_iomap_folio_state.
>   It cannot be used to get f2fs's own fields used on compressed folios.
>   For the former, we return a null pointer to indicate that the current
>   folio does not hold an f2fs_iomap_folio_state. For the latter, we
>   directly BUG_ON.
>
> Signed-off-by: Nanzhe Zhao <nzzhao@126.com>
> ---
>  fs/f2fs/Kconfig    |  10 ++
>  fs/f2fs/Makefile   |   1 +
>  fs/f2fs/f2fs_ifs.c | 221 +++++++++++++++++++++++++++++++++++++++++++++
>  fs/f2fs/f2fs_ifs.h |  79 ++++++++++++++++
>  4 files changed, 311 insertions(+)
>  create mode 100644 fs/f2fs/f2fs_ifs.c
>  create mode 100644 fs/f2fs/f2fs_ifs.h
>
> diff --git a/fs/f2fs/Kconfig b/fs/f2fs/Kconfig
> index 5916a02fb46d..480b8536fa39 100644
> --- a/fs/f2fs/Kconfig
> +++ b/fs/f2fs/Kconfig
> @@ -150,3 +150,13 @@ config F2FS_UNFAIR_RWSEM
>         help
>           Use unfair rw_semaphore, if system configured IO priority by bl=
ock
>           cgroup.
> +
> +config F2FS_IOMAP_FOLIO_STATE
> +       bool "F2FS folio per-block I/O state tracking"
> +       depends on F2FS_FS && FS_IOMAP
> +       help
> +         Enable a custom F2FS structure for tracking the I/O state
> +         (up-to-date, dirty) on a per-block basis within a memory folio.
> +         This structure stores F2FS private flag in its state flexible
> +         array while keeping compatibility with generic iomap_folio_stat=
e.
> +         Must be enabled if using iomap large folios support in F2FS.


This is purely an internal implementation detail, not a Kconfig option
in any case.

> \ No newline at end of file
> diff --git a/fs/f2fs/Makefile b/fs/f2fs/Makefile
> index 8a7322d229e4..3b9270d774e8 100644
> --- a/fs/f2fs/Makefile
> +++ b/fs/f2fs/Makefile
> @@ -10,3 +10,4 @@ f2fs-$(CONFIG_F2FS_FS_POSIX_ACL) +=3D acl.o
>  f2fs-$(CONFIG_FS_VERITY) +=3D verity.o
>  f2fs-$(CONFIG_F2FS_FS_COMPRESSION) +=3D compress.o
>  f2fs-$(CONFIG_F2FS_IOSTAT) +=3D iostat.o
> +f2fs-$(CONFIG_F2FS_IOMAP_FOLIO_STATE) +=3D f2fs_ifs.o
> diff --git a/fs/f2fs/f2fs_ifs.c b/fs/f2fs/f2fs_ifs.c
> new file mode 100644
> index 000000000000..6b7503474580
> --- /dev/null
> +++ b/fs/f2fs/f2fs_ifs.c
> @@ -0,0 +1,221 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#include <linux/fs.h>
> +#include <linux/f2fs_fs.h>
> +
> +#include "f2fs.h"
> +#include "f2fs_ifs.h"
> +
> +/*
> + * Have to set parameter ifs's type to void*
> + * and have to interpret ifs as f2fs_ifs to access its fields because
> + * we cannot see iomap_folio_state definition
> + */
> +static void ifs_to_f2fs_ifs(void *ifs, struct f2fs_iomap_folio_state *fi=
fs,
> +                           struct folio *folio)
> +{
> +       struct f2fs_iomap_folio_state *src_ifs =3D
> +               (struct f2fs_iomap_folio_state *)ifs;
> +       size_t iomap_longs =3D f2fs_ifs_iomap_longs(folio);
> +
> +       fifs->read_bytes_pending =3D READ_ONCE(src_ifs->read_bytes_pendin=
g);
> +       atomic_set(&fifs->write_bytes_pending,
> +                  atomic_read(&src_ifs->write_bytes_pending));
> +       memcpy(fifs->state, src_ifs->state,
> +              iomap_longs * sizeof(unsigned long));
> +}

Is it possible to drop this memcpy? It seems iomap has already
allocated ifs, but you=E2=80=99re allocating f2fs_ifs again. Could we exten=
d
ifs_alloc() to support an extra argument so that the inode or F2FS can
pass the additional data it needs?

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index fd827398afd2..f3bfb116dd5a 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -169,7 +169,8 @@ static void iomap_set_range_dirty(struct folio
*folio, size_t off, size_t len)
 }

 static struct iomap_folio_state *ifs_alloc(struct inode *inode,
-               struct folio *folio, unsigned int flags)
+               struct folio *folio, unsigned int flags,
+               unsigned int extra)


Alternatively, F2FS might be able to provide the extra_ifs requirement
using the method shown below?

diff --git a/include/linux/iomap.h b/include/linux/iomap.h
index 73dceabc21c8..c333f934273c 100644
--- a/include/linux/iomap.h
+++ b/include/linux/iomap.h
@@ -107,6 +107,7 @@ struct iomap {
        u64                     length; /* length of mapping, bytes */
        u16                     type;   /* type of mapping */
        u16                     flags;  /* flags for mapping */
+       u16                     ifs_extra; /* extra length needed for ifs *=
/
        struct block_device     *bdev;  /* block device for I/O */
        struct dax_device       *dax_dev; /* dax_dev for dax operations */
        void                    *inline_data;

Not entirely sure what the best approach is, but I=E2=80=99m confident you =
can
find a way to avoid introducing so much duplicated code.

> +
> +static inline bool is_f2fs_ifs(struct folio *folio)
> +{
> +       struct f2fs_iomap_folio_state *fifs;
> +
> +       if (!folio_test_private(folio))
> +               return false;
> +
> +       // first directly test no pointer flag is set or not
> +       if (test_bit(PAGE_PRIVATE_NOT_POINTER,
> +                    (unsigned long *)&folio->private))
> +               return false;
> +
> +       fifs =3D (struct f2fs_iomap_folio_state *)folio->private;
> +       if (!fifs)
> +               return false;
> +
> +       if (READ_ONCE(fifs->read_bytes_pending) =3D=3D F2FS_IFS_MAGIC)
> +               return true;
> +

This seems quite strange =E2=80=94 why is this needed? Can we keep the sema=
ntics
of all existing ifs fields unchanged and simply extend the state[]
array with your new data?

> +       return false;
> +}
> +
> +struct f2fs_iomap_folio_state *f2fs_ifs_alloc(struct folio *folio, gfp_t=
 gfp,
> +                                             bool force_alloc)
> +{
> +       struct inode *inode =3D folio->mapping->host;
> +       size_t alloc_size =3D 0;
> +
> +       if (!folio_test_large(folio)) {
> +               if (!force_alloc) {
> +                       WARN_ON_ONCE(1);
> +                       return NULL;
> +               }
> +               /*
> +                * GC can store private flag in 0 order folio's folio->pr=
ivate
> +                * causes iomap buffered write mistakenly interpret as a =
pointer
> +                * we add a bool force_alloc to deal with this case
> +                */
> +               struct f2fs_iomap_folio_state *fifs;
> +
> +               alloc_size =3D sizeof(*fifs) + 2 * sizeof(unsigned long);
> +               fifs =3D kmalloc(alloc_size, gfp);
> +               if (!fifs)
> +                       return NULL;
> +               spin_lock_init(&fifs->state_lock);
> +               WRITE_ONCE(fifs->read_bytes_pending, F2FS_IFS_MAGIC);
> +               atomic_set(&fifs->write_bytes_pending, 0);
> +               unsigned int nr_blocks =3D
> +                       i_blocks_per_folio(inode, folio);
> +               if (folio_test_uptodate(folio))
> +                       bitmap_set(fifs->state, 0, nr_blocks);
> +               if (folio_test_dirty(folio))
> +                       bitmap_set(fifs->state, nr_blocks, nr_blocks);
> +               *f2fs_ifs_private_flags_ptr(fifs, folio) =3D 0;
> +               folio_attach_private(folio, fifs);
> +               return fifs;
> +       }
> +

As mentioned above, let=E2=80=99s try to remove the duplicated allocation i=
f
iomap has already done it. We can instead make iomap support an
additional argument that can be provided by F2FS and its inode.

> +       struct f2fs_iomap_folio_state *fifs;
> +       void *old_private;
> +       size_t iomap_longs;
> +       size_t total_longs;
> +
> +       WARN_ON_ONCE(!inode); // Should have an inode
> +
> +       old_private =3D folio_get_private(folio);
> +
> +       if (old_private) {
> +               // Check if it's already our type using the magic number =
directly
> +               if (READ_ONCE(((struct f2fs_iomap_folio_state *)old_priva=
te)
> +                                     ->read_bytes_pending) =3D=3D F2FS_I=
FS_MAGIC) {
> +                       return (struct f2fs_iomap_folio_state *)
> +                               old_private; // Already ours
> +               }
> +               // Non-NULL, not ours -> Allocate, Copy, Replace path
> +               total_longs =3D f2fs_ifs_total_longs(folio);
> +               alloc_size =3D sizeof(*fifs) +
> +                               total_longs * sizeof(unsigned long);
> +
> +               fifs =3D kmalloc(alloc_size, gfp);
> +               if (!fifs)
> +                       return NULL;
> +
> +               spin_lock_init(&fifs->state_lock);
> +               *f2fs_ifs_private_flags_ptr(fifs, folio) =3D 0;
> +               // Copy data from the presumed iomap_folio_state (old_pri=
vate)
> +               ifs_to_f2fs_ifs(old_private, fifs, folio);
> +               WRITE_ONCE(fifs->read_bytes_pending, F2FS_IFS_MAGIC);
> +               folio_change_private(folio, fifs);
> +               kfree(old_private);
> +               return fifs;
> +       }
> +
> +       iomap_longs =3D f2fs_ifs_iomap_longs(folio);
> +       total_longs =3D iomap_longs + 1;
> +       alloc_size =3D
> +               sizeof(*fifs) + total_longs * sizeof(unsigned long);
> +
> +       fifs =3D kzalloc(alloc_size, gfp);
> +       if (!fifs)
> +               return NULL;
> +
> +       spin_lock_init(&fifs->state_lock);
> +
> +       unsigned int nr_blocks =3D i_blocks_per_folio(inode, folio);
> +
> +       if (folio_test_uptodate(folio))
> +               bitmap_set(fifs->state, 0, nr_blocks);
> +       if (folio_test_dirty(folio))
> +               bitmap_set(fifs->state, nr_blocks, nr_blocks);
> +       WRITE_ONCE(fifs->read_bytes_pending, F2FS_IFS_MAGIC);
> +       atomic_set(&fifs->write_bytes_pending, 0);
> +       folio_attach_private(folio, fifs);
> +       return fifs;
> +}
> +
> +void folio_detach_f2fs_private(struct folio *folio)
> +{
> +       struct f2fs_iomap_folio_state *fifs;
> +
> +       if (!folio_test_private(folio))
> +               return;
> +
> +       // Check if it's using direct flags
> +       if (test_bit(PAGE_PRIVATE_NOT_POINTER,
> +                    (unsigned long *)&folio->private)) {
> +               folio_detach_private(folio);
> +               return;
> +       }
> +
> +       fifs =3D folio_detach_private(folio);
> +       if (!fifs)
> +               return;
> +
> +       if (is_f2fs_ifs(folio)) {
> +               WARN_ON_ONCE(READ_ONCE(fifs->read_bytes_pending) !=3D
> +                            F2FS_IFS_MAGIC);
> +               WARN_ON_ONCE(atomic_read(&fifs->write_bytes_pending));
> +       } else {
> +               WARN_ON_ONCE(READ_ONCE(fifs->read_bytes_pending) !=3D 0);
> +               WARN_ON_ONCE(atomic_read(&fifs->write_bytes_pending));
> +       }
> +
> +       kfree(fifs);
> +}
> +
> +struct f2fs_iomap_folio_state *folio_get_f2fs_ifs(struct folio *folio)
> +{
> +       if (!folio_test_private(folio))
> +               return NULL;
> +
> +       if (test_bit(PAGE_PRIVATE_NOT_POINTER,
> +                    (unsigned long *)&folio->private))
> +               return NULL;
> +       /*
> +        * Note we assume folio->private can be either ifs or f2fs_ifs he=
re.
> +        * Compresssed folios should not call this function
> +        */
> +       f2fs_bug_on(F2FS_F_SB(folio),
> +                   *((u32 *)folio->private) =3D=3D F2FS_COMPRESSED_PAGE_=
MAGIC);
> +       return folio->private;
> +}
> +
> +void f2fs_ifs_clear_range_uptodate(struct folio *folio,
> +                                  struct f2fs_iomap_folio_state *fifs,
> +                                  size_t off, size_t len)
> +{
> +       struct inode *inode =3D folio->mapping->host;
> +       unsigned int first_blk =3D (off >> inode->i_blkbits);
> +       unsigned int last_blk =3D (off + len - 1) >> inode->i_blkbits;
> +       unsigned int nr_blks =3D last_blk - first_blk + 1;
> +       unsigned long flags;
> +
> +       spin_lock_irqsave(&fifs->state_lock, flags);
> +       bitmap_clear(fifs->state, first_blk, nr_blks);
> +       spin_unlock_irqrestore(&fifs->state_lock, flags);
> +}
> +
> +void f2fs_iomap_set_range_dirty(struct folio *folio, size_t off, size_t =
len)
> +{
> +       struct f2fs_iomap_folio_state *fifs =3D folio_get_f2fs_ifs(folio)=
;
> +
> +       if (fifs) {
> +               struct inode *inode =3D folio->mapping->host;
> +               unsigned int blks_per_folio =3D i_blocks_per_folio(inode,=
 folio);
> +               unsigned int first_blk =3D (off >> inode->i_blkbits);
> +               unsigned int last_blk =3D (off + len - 1) >> inode->i_blk=
bits;
> +               unsigned int nr_blks =3D last_blk - first_blk + 1;
> +               unsigned long flags;
> +
> +               spin_lock_irqsave(&fifs->state_lock, flags);
> +               bitmap_set(fifs->state, first_blk + blks_per_folio, nr_bl=
ks);
> +               spin_unlock_irqrestore(&fifs->state_lock, flags);
> +       }
> +}

Let=E2=80=99s try to reuse the existing iomap code instead of creating a ne=
w
copy-paste version. I believe iomap_set_range_dirty() should work
perfectly fine for our case.

> diff --git a/fs/f2fs/f2fs_ifs.h b/fs/f2fs/f2fs_ifs.h
> new file mode 100644
> index 000000000000..3b16deda8a1e
> --- /dev/null
> +++ b/fs/f2fs/f2fs_ifs.h
> @@ -0,0 +1,79 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#ifndef F2FS_IFS_H
> +#define F2FS_IFS_H
> +
> +#include <linux/fs.h>
> +#include <linux/bug.h>
> +#include <linux/f2fs_fs.h>
> +#include <linux/mm.h>
> +#include <linux/iomap.h>
> +#include <linux/slab.h>
> +#include <linux/spinlock.h>
> +#include <linux/atomic.h>
> +
> +#include "f2fs.h"
> +
> +#define F2FS_IFS_MAGIC 0xf2f5
> +#define F2FS_IFS_PRIVATE_LONGS 1
> +
> +/*
> + * F2FS structure for folio private data, mimicking iomap_folio_state la=
yout.
> + * F2FS private flags/data are stored in extra space allocated at the en=
d
> + */
> +struct f2fs_iomap_folio_state {
> +       spinlock_t state_lock;
> +       unsigned int read_bytes_pending;
> +       atomic_t write_bytes_pending;
> +       /*
> +        * Flexible array member.
> +        * Holds [0...iomap_longs-1] for iomap uptodate/dirty bits.
> +        * Holds [iomap_longs] for F2FS private flags/data (unsigned long=
).
> +        */
> +       unsigned long state[];
> +};
> +

This is completely unnecessary =E2=80=94 it=E2=80=99s just a duplicate of
iomap_folio_state. I=E2=80=99d prefer moving iomap_folio_state to a header
file so that F2FS can reference it directly.

Thanks
Barry


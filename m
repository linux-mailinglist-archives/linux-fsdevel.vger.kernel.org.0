Return-Path: <linux-fsdevel+bounces-50226-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 67205AC9076
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 May 2025 15:44:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3673B1BA2EC9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 May 2025 13:44:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A37F7225A37;
	Fri, 30 May 2025 13:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IuxaBeRf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 341CC17A2F5;
	Fri, 30 May 2025 13:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748612639; cv=none; b=GfExJfj5cG8K3Y+c2tRKSuylPCh2UdZaUrXmMy1Lx2TnPdXuomnvj7qBa6oWf1/QLROq1VUFfPfg+9uGy8TRpw5FcRB2WOdJ2KOJPTtNlbuQO7dDc/VvnfWHUYxRANw9YrJwcv8HbpaVi9OGOLzJ9wutAFzvTakZvU6xzzqxpoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748612639; c=relaxed/simple;
	bh=QjSHNJemlr/cCBeYAFj5VuIcFvzHgKsz0ql6A50+TTE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DIVSslnpv+aU1wtmPOJDGkw+bp2gwd2an662Cb4MibPkW1ch1/69GGnb68//bWmblwdi/5dFecsqhb/IBceSIK8q3iSPgDCGXmMTDnWGEV46Cbm3IdVFWERfTBlDjoLHuaSh7/NjOYuCCcmfP8c2lWNnDKFgbg3IBPzFVUZcZaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IuxaBeRf; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-ad572ba1347so311796866b.1;
        Fri, 30 May 2025 06:43:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748612634; x=1749217434; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cg27jRbqgT6Vx96cOZmKzT7mRTBBHTh/rcABmd3nHl0=;
        b=IuxaBeRf4QM+uTXGvHnvFsXmDdyWhz4MoH+x8mT8j6KFAWGkRZgI74THgzqhjdXXRn
         pWt4KLonV81vrT8UkFrnd0LHThfkgXvIjf6SwP1oQ2Z1WxqbOdR68Rjx0c7P4gsLn3UV
         nzcjOqY2zzbxn7B92cC9m8Cv9sxm8eVIAOAMt6IeMnepx+Nh4fDD1dlGoxoXNDTNws7A
         411eoSyXCz3DKdosX//90XdiYPTfq9RkOSCuZBoOF4mMkL+XdeUYJekm9Oe0gxvl3X1w
         ELjsMn36HguhK4O60fjUnBGJV2kSY272Ih7PjeyThV0YVfKB9ehfOZ3sU2iqDOWRlMsq
         s36g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748612634; x=1749217434;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cg27jRbqgT6Vx96cOZmKzT7mRTBBHTh/rcABmd3nHl0=;
        b=AtLOjOmsWZh34Dkd+HGjG+zaDyJ83P+1SCnVUiqfnPcY+C85n1J/7cYyTjpRBck8Wo
         8kboM2Jhnl7Tj9pdvRkozlelop9kvyFE2ohPPNVr0tJCKLL33ZzZSH++GHSyUe8uNk+U
         6QaxMDdcRhKJmXiWo91q8PxzkDLkfX004PCMbTA25GqLb5S2uTqc7Srx3+eOORS3l+9W
         t1U3Ok4ZOynuM2XhnkW9JVDTXkUmmmGbwDI7cpSSPBDGvMju14PTivraJ6X/VkuaaVug
         nrKkyUBO6hipza6udVAC/BeySiUtJMPAxrY+djd9XR2Pz9v4qdZGnZqTuOB787AlkeFG
         eg1w==
X-Forwarded-Encrypted: i=1; AJvYcCUg9aB2+ooDnDNLCHpThien9AgURJA7xGgffEvAMfJPVhO2DIJUL/ZgtX03hMQkas1Vqkr0egx75BSp/Eo=@vger.kernel.org, AJvYcCVhFchcC6nb5dTndkkAuHup8nV8jZh/XdTg56ReLe3H73V5jni1qfxVABpi4OX0eMw9HXtTR4HJMg+0I22q@vger.kernel.org, AJvYcCVwMR6/StDUcJ6oi4UkZlqU169/UqLmJNbzGFoRsvIXs73agUBbqFYjLUgA2G0DHV0W5f6UrByHC6fa0Q1e@vger.kernel.org
X-Gm-Message-State: AOJu0YzeZoCAAes2EzDumzqgQCpcakKRPMX4btmN2EXn1fRujV5w+08L
	OiqfXJSTsEx51XP2ychTBcecAUyXAbH7F/V8ppSKet6gxvGvWY3lWT5HX+VJEwFV7hp6hCkMKdG
	mS/K4EZ/PFC8AVs4TGp+4aPQqb0EPgDU=
X-Gm-Gg: ASbGncvmo0mLEYV5bH5Ehv73Cm+ktzXuguoi8SlmF4y0PolszRZAv6rLAZSFKetMAxE
	AYn44ExuojL/kVaqYZ+Baao/eW451EK3bTTrkkyFggNZZ5YmnOC/Jr05cAuDe8+OWZ+oRoaqi+c
	XksggAoZWM45ybSZahRon1v7o3qm+l9bvC
X-Google-Smtp-Source: AGHT+IHvBpjR/endSRQUt5FTF0eDLYH+Kdk5Qc8W51rWZR6eg4HtuFzDot8VeE8MsEjFbuxlldLzfxh7KxymP/Pqh8M=
X-Received: by 2002:a17:907:9282:b0:ad8:959c:c55d with SMTP id
 a640c23a62f3a-adb322457f2mr313580966b.2.1748612634069; Fri, 30 May 2025
 06:43:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250530103941.11092-1-tao.wangtao@honor.com> <20250530103941.11092-2-tao.wangtao@honor.com>
In-Reply-To: <20250530103941.11092-2-tao.wangtao@honor.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Fri, 30 May 2025 15:43:43 +0200
X-Gm-Features: AX0GCFshwnygoYp9lqAc5QflEKgeVEHCIAtDwsKnm5KS2y3iB6_sX14JgNpIns4
Message-ID: <CAOQ4uxid9dn3akvN3gMBVOJXoazF5gm6xO+=eaRCzDaC62K5OA@mail.gmail.com>
Subject: Re: [PATCH v3 1/4] fs: allow cross-FS copy_file_range for
 memory-backed files
To: wangtao <tao.wangtao@honor.com>
Cc: sumit.semwal@linaro.org, christian.koenig@amd.com, kraxel@redhat.com, 
	vivek.kasireddy@intel.com, viro@zeniv.linux.org.uk, brauner@kernel.org, 
	hughd@google.com, akpm@linux-foundation.org, benjamin.gaignard@collabora.com, 
	Brian.Starkey@arm.com, jstultz@google.com, tjmercier@google.com, jack@suse.cz, 
	baolin.wang@linux.alibaba.com, linux-media@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-mm@kvack.org, bintian.wang@honor.com, yipengxiang@honor.com, 
	liulu.liu@honor.com, feng.han@honor.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 30, 2025 at 12:40=E2=80=AFPM wangtao <tao.wangtao@honor.com> wr=
ote:
>
> Memory-backed files can optimize copy performance via
> copy_file_range callbacks. Compared to mmap&read: reduces
> GUP (get_user_pages) overhead; vs sendfile/splice: eliminates
> one memory copy; supports dmabuf zero-copy implementation.
>
> Signed-off-by: wangtao <tao.wangtao@honor.com>
> ---

Hi wangtao,

Let me rephrase my reaction gently:
Regardless of the proposed API extension, and referring to the
implementation itself -
I wrote the current code and I can barely understand the logic every time
I come back to read it.

Your changes make it too messy to be reviewed/maintained.
I have a few suggestions for simplifications (see below).

The complication arise from the fact that normally the destination fops
are used to call the copy_range() method and this case is a deviation
from this standard, we need to make the cope simpler using a helper
to choose the fops to use.

>  fs/read_write.c    | 71 +++++++++++++++++++++++++++++++++-------------
>  include/linux/fs.h |  2 ++
>  2 files changed, 54 insertions(+), 19 deletions(-)
>
> diff --git a/fs/read_write.c b/fs/read_write.c
> index bb0ed26a0b3a..591c6db7b785 100644
> --- a/fs/read_write.c
> +++ b/fs/read_write.c
> @@ -1469,6 +1469,20 @@ COMPAT_SYSCALL_DEFINE4(sendfile64, int, out_fd, in=
t, in_fd,
>  }
>  #endif
>
> +static inline bool is_copy_memory_file_to_file(struct file *file_in,
> +                               struct file *file_out)
> +{
> +       return (file_in->f_op->fop_flags & FOP_MEMORY_FILE) &&
> +               file_in->f_op->copy_file_range && file_out->f_op->write_i=
ter;
> +}
> +
> +static inline bool is_copy_file_to_memory_file(struct file *file_in,
> +                               struct file *file_out)
> +{
> +       return (file_out->f_op->fop_flags & FOP_MEMORY_FILE) &&
> +               file_in->f_op->read_iter && file_out->f_op->copy_file_ran=
ge;
> +}
> +

Please combine that to a helper:
const struct file_operations *memory_copy_file_ops(struct file
*file_in, struct file *file_out)
which returns either file_in->f_op, file_out->f_op or NULL.


>  /*
>   * Performs necessary checks before doing a file copy
>   *
> @@ -1484,11 +1498,23 @@ static int generic_copy_file_checks(struct file *=
file_in, loff_t pos_in,
>         struct inode *inode_out =3D file_inode(file_out);
>         uint64_t count =3D *req_count;
>         loff_t size_in;
> +       bool splice =3D flags & COPY_FILE_SPLICE;
> +       bool has_memory_file;
>         int ret;
>
> -       ret =3D generic_file_rw_checks(file_in, file_out);
> -       if (ret)
> -               return ret;
> +       /* Skip generic checks, allow cross-sb copies for dma-buf/tmpfs *=
/
> +       has_memory_file =3D is_copy_memory_file_to_file(file_in, file_out=
) ||
> +                         is_copy_file_to_memory_file(file_in, file_out);
> +       if (!splice && has_memory_file) {
> +               if (!(file_in->f_mode & FMODE_READ) ||
> +                   !(file_out->f_mode & FMODE_WRITE) ||
> +                   (file_out->f_flags & O_APPEND))
> +                       return -EBADF;

I don't like that this both duplicates code and does not check all the chec=
ks in
generic_file_rw_checks() for the non-memory file side.
I do not currently have a suggestion how to make this less messy,
more human readable and correct.

> +       } else {
> +               ret =3D generic_file_rw_checks(file_in, file_out);
> +               if (ret)
> +                       return ret;
> +       }
>
>         /*
>          * We allow some filesystems to handle cross sb copy, but passing
> @@ -1500,7 +1526,7 @@ static int generic_copy_file_checks(struct file *fi=
le_in, loff_t pos_in,
>          * and several different sets of file_operations, but they all en=
d up
>          * using the same ->copy_file_range() function pointer.
>          */
> -       if (flags & COPY_FILE_SPLICE) {
> +       if (splice || has_memory_file) {
>                 /* cross sb splice is allowed */

This comment is not accurate - it should say "cross fs-type", because it sk=
ips
the test that compares the ->copy_file_range pointers, not the sb.
If you are making changes to this function, this should be clarified.

>         } else if (file_out->f_op->copy_file_range) {
>                 if (file_in->f_op->copy_file_range !=3D
> @@ -1581,23 +1607,30 @@ ssize_t vfs_copy_file_range(struct file *file_in,=
 loff_t pos_in,
>          * same sb using clone, but for filesystems where both clone and =
copy
>          * are supported (e.g. nfs,cifs), we only call the copy method.
>          */
> -       if (!splice && file_out->f_op->copy_file_range) {
> -               ret =3D file_out->f_op->copy_file_range(file_in, pos_in,
> -                                                     file_out, pos_out,
> -                                                     len, flags);
> -       } else if (!splice && file_in->f_op->remap_file_range && samesb) =
{
> -               ret =3D file_in->f_op->remap_file_range(file_in, pos_in,
> -                               file_out, pos_out,
> -                               min_t(loff_t, MAX_RW_COUNT, len),
> -                               REMAP_FILE_CAN_SHORTEN);
> -               /* fallback to splice */
> -               if (ret <=3D 0)
> +       if (!splice) {
> +               if (is_copy_memory_file_to_file(file_in, file_out)) {
> +                       ret =3D file_in->f_op->copy_file_range(file_in, p=
os_in,
> +                                       file_out, pos_out, len, flags);
> +               } else if (is_copy_file_to_memory_file(file_in, file_out)=
) {
> +                       ret =3D file_out->f_op->copy_file_range(file_in, =
pos_in,
> +                                       file_out, pos_out, len, flags);
> +               } else if (file_out->f_op->copy_file_range) {
> +                       ret =3D file_out->f_op->copy_file_range(file_in, =
pos_in,
> +                                                       file_out, pos_out=
,
> +                                                       len, flags);
> +               } else if (file_in->f_op->remap_file_range && samesb) {
> +                       ret =3D file_in->f_op->remap_file_range(file_in, =
pos_in,
> +                                       file_out, pos_out,
> +                                       min_t(loff_t, MAX_RW_COUNT, len),
> +                                       REMAP_FILE_CAN_SHORTEN);
> +                       /* fallback to splice */
> +                       if (ret <=3D 0)
> +                               splice =3D true;
> +               } else if (samesb) {
> +                       /* Fallback to splice for same sb copy for backwa=
rd compat */
>                         splice =3D true;
> -       } else if (samesb) {
> -               /* Fallback to splice for same sb copy for backward compa=
t */
> -               splice =3D true;
> +               }

This is the way-too-ugly-to-live part.
Was pretty bad before and now it is unacceptable.
way too much unneeded nesting and too hard to follow.

First of all, please use splice label and call goto splice (before the comm=
ent)
instead of adding another nesting level.
I would do that even if not adding memory fd copy support.

Second, please store result of mem_fops =3D memory_copy_file_ops()
and start with:
+    if (mem_fops) {
+        ret =3D mem_fops->copy_file_range(file_in, pos_in,
+
file_out, pos_out,
+                                                               len, flags)=
;
 +   } else if (file_out->f_op->copy_file_range) { ...

and update the comment above to say that:
+ * For copy to/from memory fd, we alway call the copy method of the memory=
 fd.
   */

I think that makes the code not more ugly than it already is.

Thanks,
Amir.


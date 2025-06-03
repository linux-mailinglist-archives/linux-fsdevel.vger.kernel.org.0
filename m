Return-Path: <linux-fsdevel+bounces-50448-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13CA9ACC4C3
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Jun 2025 12:57:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 158EB7A7C9A
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Jun 2025 10:55:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 427DF22D4CE;
	Tue,  3 Jun 2025 10:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WxsHB3Mi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D938222ACF3;
	Tue,  3 Jun 2025 10:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748948216; cv=none; b=sypD9qiLsQRju6j+F651fvfLZ99WpE2aJQkD1AQMepAAXe1FmoyVIL0cKONZdyqzFxCBfus9V9kO0FPAiO/LodAFHMr5PUKJ1HqzFBwj+2ObPdl/73SAIv1Pk41Fl4pRcOpxXtmkRyob8lV2OK4iFUcZLl64tZp6NNZrBl6m5Co=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748948216; c=relaxed/simple;
	bh=Ur6vVLpxNkxNbe7dEIuP263XbOpSu+doBc10oy7vIqg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iT/sj6XaCrSJYHeDoiEHacBD6YbOl94o1F7TC+SMs00V4meUsxQjOXIUq242pUCRIH6kI6Eferu68z//TZ2VKIhSv10/30bSHx/YT4dktoQda8DUD+MGqGQ3RTCXW0pgy2ejQ+svgljyXE62CzoPxiPCsJ0HguN/9UxsmiyJHkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WxsHB3Mi; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-addcea380eeso354551766b.0;
        Tue, 03 Jun 2025 03:56:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748948213; x=1749553013; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/7blXBO4JKraFXyZYVYjtLes0xIhtY9NoXA5LD7gBEk=;
        b=WxsHB3Mi2xyaN+Ch+hqxTtwIM15ZZ8nFVMbY8KqIXbHoxTMHJL5JJmpNEWdjGSVwEL
         RO/f3LUlbLFJt/aPS1IwUy9EpCIJiJ0Pp1+Z1IcPeuUPjjmFvUEP1QHMWIwjNv1GW4MS
         Bn4GFzUvIDgNGlD8IqQzSa9hef4/iyIX/Wkdjto0BndP9a1VvSpuhCz5eG2mL4U0Z2fG
         5qIgaZX0QpwYw9uSDLjoXZU7yBcFNC8UU5+xIQ6BnrRz8M5A2NRyIMMXPMa7B8kWY1Yp
         lidrS++Q+DJvbF64JweuGkpYK7uNOKyAB7K1ioilm8U66jp457qGKZYjO9zdDdEwioCJ
         mzIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748948213; x=1749553013;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/7blXBO4JKraFXyZYVYjtLes0xIhtY9NoXA5LD7gBEk=;
        b=RcfdwUzEiBNDYs1ZgGEXFpueZCf5IAJ8tQh++VMjZvgP5+NQSBdi6ts8/A2ak+0ieR
         k+RIo8f9jC9Y5Jovpt0jy0QBeAw5mDOwFrAEBq9DcmfIuezKpgt7gEmxOV6FpJxZKBOh
         Ik3s/fxgt7YJ+CkfPOwa2596wR+uTaUgF+N35HXxdFvjCOPHy5ezFxssPMPCJYJ8iPzE
         jGfbRaFRNoAvGgZcbcHvaZmbeoglMfpw27eOB7ZWFeo+p7IwYYpBXC4t5PC0U8rdhFLo
         BinyRf/D3gfD9mQyPkmIwOTSeO47XLotXxS1M5/UPvQqRzbDXhpTPGSOVuydf/BzzQDD
         m+5Q==
X-Forwarded-Encrypted: i=1; AJvYcCVPjIr9i6a5ZRPd5EPn0VAMqGbL/gO/vTHM9sZzHoxemXl3GP0Vhfh1SmsRjAefVlZLR5OP6JiswYo+33jo@vger.kernel.org, AJvYcCVt73TN3oZTlurl2CaGveBnOmhVoxzV+a0qn/R5X7HwDjNPplFd7V5DsHUUeLDJNG4eiE3wKmLUzSfiq9Cj@vger.kernel.org, AJvYcCWe1Hg6vagO094ZdkUEFQNpdFMFkmDFGJKWK6ETvkx2bpXFQvJTZQ62E17CRZns1UVA9ePiRFXhAnB3OcA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzmEglB7h2UcVx3Ant0yzngolMvzR0z8YGZehi1Ov6llMkgrvg6
	JFbX1iYltG+dkphZFyhhKJxJWmYqG+J8y+ef+/NanR9LppvdHTz6PLnl4V36F34gjnQD9tKqb/c
	GL7j6P6g2Of5gYNN/FjQSutGNj97PIoA=
X-Gm-Gg: ASbGncsJzPgWAhYlDv81OiHu1MZcbrLRBjCVp/7UOnJZrdJSni5X4QF1+ZSVr9jgZ0Y
	qIARXsO0g+i/ICEDDP7oi6+k/bZnDAqU1+NGeg1PNk0s8v9yC99R8onbINOooJc/MSw6TEREXzL
	MlNo+2F0+CE5KW2KQM3BDetmOzMTdxtMAQ
X-Google-Smtp-Source: AGHT+IGpvLn8hqrgPkcWVTHoe15k+0yqKJqtqmp3PMmzbuAIudjHSPH95skJXXoflNa4a233DOM5y2pvJ1SiAlHm6rU=
X-Received: by 2002:a17:907:da9:b0:ad8:97d8:a52e with SMTP id
 a640c23a62f3a-adb495983admr1239171966b.55.1748948212831; Tue, 03 Jun 2025
 03:56:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250603095245.17478-1-tao.wangtao@honor.com> <20250603095245.17478-2-tao.wangtao@honor.com>
In-Reply-To: <20250603095245.17478-2-tao.wangtao@honor.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Tue, 3 Jun 2025 12:56:41 +0200
X-Gm-Features: AX0GCFvUGt-jkPjKb-TaQfCiyDY6ri9AEn30VaTl2bfo8Rvzx6IYm2tIEQwOB0U
Message-ID: <CAOQ4uxgYmSLY25WtQjHxvViG0eNSSsswF77djBJZsSJCq1OyLA@mail.gmail.com>
Subject: Re: [PATCH v4 1/4] fs: allow cross-FS copy_file_range for memory file
 with direct I/O
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

On Tue, Jun 3, 2025 at 11:53=E2=80=AFAM wangtao <tao.wangtao@honor.com> wro=
te:
>
> Memory files can optimize copy performance via copy_file_range callbacks:
> -Compared to mmap&read: reduces GUP (get_user_pages) overhead
> -Compared to sendfile/splice: eliminates one memory copy
> -Supports dma-buf direct I/O zero-copy implementation
>
> Suggested by: Christian K=C3=B6nig <christian.koenig@amd.com>
> Suggested by: Amir Goldstein <amir73il@gmail.com>
> Signed-off-by: wangtao <tao.wangtao@honor.com>
> ---
>  fs/read_write.c    | 64 +++++++++++++++++++++++++++++++++++++---------
>  include/linux/fs.h |  2 ++
>  2 files changed, 54 insertions(+), 12 deletions(-)
>
> diff --git a/fs/read_write.c b/fs/read_write.c
> index bb0ed26a0b3a..ecb4f753c632 100644
> --- a/fs/read_write.c
> +++ b/fs/read_write.c
> @@ -1469,6 +1469,31 @@ COMPAT_SYSCALL_DEFINE4(sendfile64, int, out_fd, in=
t, in_fd,
>  }
>  #endif
>
> +static const struct file_operations *memory_copy_file_ops(
> +                       struct file *file_in, struct file *file_out)
> +{
> +       if ((file_in->f_op->fop_flags & FOP_MEMORY_FILE) &&
> +           (file_in->f_mode & FMODE_CAN_ODIRECT) &&
> +           file_in->f_op->copy_file_range && file_out->f_op->write_iter)
> +               return file_in->f_op;
> +       else if ((file_out->f_op->fop_flags & FOP_MEMORY_FILE) &&
> +                (file_out->f_mode & FMODE_CAN_ODIRECT) &&
> +                file_in->f_op->read_iter && file_out->f_op->copy_file_ra=
nge)
> +               return file_out->f_op;
> +       else
> +               return NULL;
> +}
> +
> +static int essential_file_rw_checks(struct file *file_in, struct file *f=
ile_out)
> +{
> +       if (!(file_in->f_mode & FMODE_READ) ||
> +           !(file_out->f_mode & FMODE_WRITE) ||
> +           (file_out->f_flags & O_APPEND))
> +               return -EBADF;
> +
> +       return 0;
> +}
> +
>  /*
>   * Performs necessary checks before doing a file copy
>   *
> @@ -1484,9 +1509,16 @@ static int generic_copy_file_checks(struct file *f=
ile_in, loff_t pos_in,
>         struct inode *inode_out =3D file_inode(file_out);
>         uint64_t count =3D *req_count;
>         loff_t size_in;
> +       bool splice =3D flags & COPY_FILE_SPLICE;
> +       const struct file_operations *mem_fops;
>         int ret;
>
> -       ret =3D generic_file_rw_checks(file_in, file_out);
> +       /* The dma-buf file is not a regular file. */
> +       mem_fops =3D memory_copy_file_ops(file_in, file_out);
> +       if (splice || mem_fops =3D=3D NULL)

nit: use !mem_fops please

Considering that the flag COPY_FILE_SPLICE is not allowed
from userspace and is only called by nfsd and ksmbd
I think we should assert and deny the combination of
mem_fops && splice because it is very much unexpected.

After asserting this, it would be nicer to write as:
        if (mem_fops)
               ret =3D essential_file_rw_checks(file_in, file_out);
        else
               ret =3D generic_file_rw_checks(file_in, file_out);

> +       else
> +               ret =3D essential_file_rw_checks(file_in, file_out);
>         if (ret)
>                 return ret;
>
> @@ -1500,8 +1532,10 @@ static int generic_copy_file_checks(struct file *f=
ile_in, loff_t pos_in,
>          * and several different sets of file_operations, but they all en=
d up
>          * using the same ->copy_file_range() function pointer.
>          */
> -       if (flags & COPY_FILE_SPLICE) {
> +       if (splice) {
>                 /* cross sb splice is allowed */
> +       } else if (mem_fops !=3D NULL) {

With the assertion that splice && mem_fops is not allowed
if (splice || mem_fops) {

would go well together because they both allow cross-fs
copy not only cross sb.

> +               /* cross-fs copy is allowed for memory file. */
>         } else if (file_out->f_op->copy_file_range) {
>                 if (file_in->f_op->copy_file_range !=3D
>                     file_out->f_op->copy_file_range)
> @@ -1554,6 +1588,7 @@ ssize_t vfs_copy_file_range(struct file *file_in, l=
off_t pos_in,
>         ssize_t ret;
>         bool splice =3D flags & COPY_FILE_SPLICE;
>         bool samesb =3D file_inode(file_in)->i_sb =3D=3D file_inode(file_=
out)->i_sb;
> +       const struct file_operations *mem_fops;
>
>         if (flags & ~COPY_FILE_SPLICE)
>                 return -EINVAL;
> @@ -1574,18 +1609,27 @@ ssize_t vfs_copy_file_range(struct file *file_in,=
 loff_t pos_in,
>         if (len =3D=3D 0)
>                 return 0;
>
> +       if (splice)
> +               goto do_splice;
> +
>         file_start_write(file_out);
>

goto do_splice needs to be after file_start_write

Please wait for feedback from vfs maintainers before posting another
version addressing my review comments.

Thanks,
Amir.


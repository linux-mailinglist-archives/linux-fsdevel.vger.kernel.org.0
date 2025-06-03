Return-Path: <linux-fsdevel+bounces-50453-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66D5BACC6E4
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Jun 2025 14:43:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 27D3717284D
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Jun 2025 12:43:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42AB7231A55;
	Tue,  3 Jun 2025 12:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k4+ur3P2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A129D22FF2D;
	Tue,  3 Jun 2025 12:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748954601; cv=none; b=AtVZOBdzcv3TlVP//QMfXNvlSvoeS5uQa/MUeRrEWdozPPa21+ozBN01/6zpbaYKNEQbq1HSrfmMpOteJcW253ZeX//G4HyyMPOstCsaytBLuP94XiILYPxoZjmHK6F5XbTeyl/eymxYNdUwjsgrMR6/qzUCc5WwcC8fqkSdBkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748954601; c=relaxed/simple;
	bh=HfxTCbwpuSHFH8GWpH/5AMQvU8Qg7uvowZzWyjaAOcc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GFrSdSz+KqgG64NfgOg5au66y0dw9PTNJoFifMlfTZAQsAxvrkTs8EsUQKZ6i1ckOcIS+13NklFShPfVluV/efr8JPcfovcVtZWM5WhEVKrR/XdlTRGPDHaqK8opbc1xiyanPF1V7l0CBqPu/Ws5lqBZ6YNZQszXLoFmj+ndrDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k4+ur3P2; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-ad88d77314bso998841966b.1;
        Tue, 03 Jun 2025 05:43:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748954595; x=1749559395; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6sJx8mcfGnFO4aX8W0GB5TfU4SPvOLM9fzBj8cbSzfg=;
        b=k4+ur3P2QoeUdy7w58KiKJG5NrGvm0OYAcu+4dhvLBnOPgCbPWBBBfr/2Q7QrmRFba
         EUrxlCEbnAuTPl7hrP1SOUNSQhwLJjCxgwHCWpt72URHHd3vfoI5gr1AduP6mkFJcSx7
         Pm9fVXYXOnnPzjYVmEnk1IF1xclyyKLjHI166ugQOEALK5RNgPDxHuPHqPIDDFhmIF8r
         zfWK4MwDy9iJ+ietqWJMD4PDS6RPtDosAeyKJhAITPXN6xpryk8MaUTCV0tHyPe2TNr6
         oNCXORwZ9Bg+TW1zPXC2k5YIXtVC1QDgih1mlF3IwT3G0er1+iol+QdWOU5aryW7KdZs
         yXCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748954595; x=1749559395;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6sJx8mcfGnFO4aX8W0GB5TfU4SPvOLM9fzBj8cbSzfg=;
        b=GqlXCiVey6Ra47qlNvH5rE7jo6vLow57O/kLMxIdatrLDpjCcxZsyIHrOx8Q2IrR4p
         69IoDdhkAgRi+GVnjxjLVgXBqTZAsAiA732a6W3Gi4YXoqXwhU2BjqGNSc2QwstZ14aR
         1xgeNpIHNtc7SX9rxWoitKIY2/hj4jRkA34egTBhk4Dwd6x7LDlx5wC6TI+H0z9eVqqP
         aTkwt1BOCQhrVcQIm2QBLxZNwOPDgXpgR14eE1T0aRuZw5tzG8SqaxkM/XD9WzGNhKmJ
         gV/Q6zNzGmOmx5lCvTRmCs+dKIwMaPpm3xOT8fw5HOfq/sud7O60hj6MTgNMEyY5iLrP
         qr3w==
X-Forwarded-Encrypted: i=1; AJvYcCUXPzV1bPZgBIIKO/DuEwOtV2dIDSK/3pgOoiBJVsmy/oAY4tQ1dSj0eWjrG/W8enddmfh/zGIyEUMxnDLe@vger.kernel.org, AJvYcCVB4WqJF4AcoCAN/Heaxg+Gq2+LwzmHNUtaGRQOpDH5jnfNxO0KX3IXhzgV8EsYumi4h+IGMwTiIW75XTpk@vger.kernel.org, AJvYcCVCRRa3nDVKrJvPq7F98ky9M29AYX6NL8Q5/Uqo5htzATd5tUMgNDErLtRUwOUQvggMnpxRjXJaSajfNVk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHJaXMTDVpi1CsKyhzOj6Ztg53eyshmag5qsad8r1DFdKC+lpK
	cPeTF4y/XwO4jOhDQKbSqereM8CtW1QS8oSUS4M83CdF796GI/Ev4WwihocKaNTplYaRdMW7Alv
	jwgfJpeFxaNpLUihlydIaVRIGQ8KSxa0=
X-Gm-Gg: ASbGnctkN7HNeG65K1RW0GukoUUNYZ2ceBmwdQx4OHBkRiFgODiU5Ktakn5ZMriNEsT
	SqwMwwS9mKZ8dYUaX93nYZyUoVVkrBEYQMijCV/whF3HwKxVoPjKoHD0xktpiqV/Z8WVIVnrqwL
	Vi77CcY0DEvaicioh3av3KIWFHhWQYgEy/
X-Google-Smtp-Source: AGHT+IF0Y8eVa/wSpXz4raSNLDvjA9m62FPSA+BLGsYc090YPQ60EU4GYYJzLpKbTnA9JxXmd1DxAASt8NsK3GIUg8M=
X-Received: by 2002:a17:906:85a:b0:adb:413a:a981 with SMTP id
 a640c23a62f3a-adb413aaac4mr1029791066b.14.1748954594439; Tue, 03 Jun 2025
 05:43:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250603095245.17478-1-tao.wangtao@honor.com> <20250603095245.17478-2-tao.wangtao@honor.com>
 <CAOQ4uxgYmSLY25WtQjHxvViG0eNSSsswF77djBJZsSJCq1OyLA@mail.gmail.com> <0cb2501aea054796906e2f6a23a86390@honor.com>
In-Reply-To: <0cb2501aea054796906e2f6a23a86390@honor.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Tue, 3 Jun 2025 14:43:02 +0200
X-Gm-Features: AX0GCFuHzQzF8AX68GwDBFhePF7quh1p9www-VHHK49I3nQ44uIdAWZ_lLdxIa4
Message-ID: <CAOQ4uxi5eyXocmFaDdT_1Jvo0ZiEf66bC9u5qn6B2Rdd_Fuqyw@mail.gmail.com>
Subject: Re: [PATCH v4 1/4] fs: allow cross-FS copy_file_range for memory file
 with direct I/O
To: wangtao <tao.wangtao@honor.com>
Cc: "sumit.semwal@linaro.org" <sumit.semwal@linaro.org>, 
	"christian.koenig@amd.com" <christian.koenig@amd.com>, "kraxel@redhat.com" <kraxel@redhat.com>, 
	"vivek.kasireddy@intel.com" <vivek.kasireddy@intel.com>, 
	"viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>, "brauner@kernel.org" <brauner@kernel.org>, 
	"hughd@google.com" <hughd@google.com>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>, 
	"benjamin.gaignard@collabora.com" <benjamin.gaignard@collabora.com>, 
	"Brian.Starkey@arm.com" <Brian.Starkey@arm.com>, "jstultz@google.com" <jstultz@google.com>, 
	"tjmercier@google.com" <tjmercier@google.com>, "jack@suse.cz" <jack@suse.cz>, 
	"baolin.wang@linux.alibaba.com" <baolin.wang@linux.alibaba.com>, 
	"linux-media@vger.kernel.org" <linux-media@vger.kernel.org>, 
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, 
	"linaro-mm-sig@lists.linaro.org" <linaro-mm-sig@lists.linaro.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, 
	"wangbintian(BintianWang)" <bintian.wang@honor.com>, yipengxiang <yipengxiang@honor.com>, 
	liulu 00013167 <liulu.liu@honor.com>, hanfeng 00012985 <feng.han@honor.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 3, 2025 at 2:38=E2=80=AFPM wangtao <tao.wangtao@honor.com> wrot=
e:
>
>
>
> > -----Original Message-----
> > From: Amir Goldstein <amir73il@gmail.com>
> > Sent: Tuesday, June 3, 2025 6:57 PM
> > To: wangtao <tao.wangtao@honor.com>
> > Cc: sumit.semwal@linaro.org; christian.koenig@amd.com;
> > kraxel@redhat.com; vivek.kasireddy@intel.com; viro@zeniv.linux.org.uk;
> > brauner@kernel.org; hughd@google.com; akpm@linux-foundation.org;
> > benjamin.gaignard@collabora.com; Brian.Starkey@arm.com;
> > jstultz@google.com; tjmercier@google.com; jack@suse.cz;
> > baolin.wang@linux.alibaba.com; linux-media@vger.kernel.org; dri-
> > devel@lists.freedesktop.org; linaro-mm-sig@lists.linaro.org; linux-
> > kernel@vger.kernel.org; linux-fsdevel@vger.kernel.org; linux-
> > mm@kvack.org; wangbintian(BintianWang) <bintian.wang@honor.com>;
> > yipengxiang <yipengxiang@honor.com>; liulu 00013167
> > <liulu.liu@honor.com>; hanfeng 00012985 <feng.han@honor.com>
> > Subject: Re: [PATCH v4 1/4] fs: allow cross-FS copy_file_range for memo=
ry
> > file with direct I/O
> >
> > On Tue, Jun 3, 2025 at 11:53=E2=80=AFAM wangtao <tao.wangtao@honor.com>=
 wrote:
> > >
> > > Memory files can optimize copy performance via copy_file_range callba=
cks:
> > > -Compared to mmap&read: reduces GUP (get_user_pages) overhead
> > > -Compared to sendfile/splice: eliminates one memory copy -Supports
> > > dma-buf direct I/O zero-copy implementation
> > >
> > > Suggested by: Christian K=C3=B6nig <christian.koenig@amd.com> Suggest=
ed by:
> > > Amir Goldstein <amir73il@gmail.com>
> > > Signed-off-by: wangtao <tao.wangtao@honor.com>
> > > ---
> > >  fs/read_write.c    | 64 +++++++++++++++++++++++++++++++++++++-----
> > ----
> > >  include/linux/fs.h |  2 ++
> > >  2 files changed, 54 insertions(+), 12 deletions(-)
> > >
> > > diff --git a/fs/read_write.c b/fs/read_write.c index
> > > bb0ed26a0b3a..ecb4f753c632 100644
> > > --- a/fs/read_write.c
> > > +++ b/fs/read_write.c
> > > @@ -1469,6 +1469,31 @@ COMPAT_SYSCALL_DEFINE4(sendfile64, int,
> > out_fd,
> > > int, in_fd,  }  #endif
> > >
> > > +static const struct file_operations *memory_copy_file_ops(
> > > +                       struct file *file_in, struct file *file_out) =
{
> > > +       if ((file_in->f_op->fop_flags & FOP_MEMORY_FILE) &&
> > > +           (file_in->f_mode & FMODE_CAN_ODIRECT) &&
> > > +           file_in->f_op->copy_file_range && file_out->f_op->write_i=
ter)
> > > +               return file_in->f_op;
> > > +       else if ((file_out->f_op->fop_flags & FOP_MEMORY_FILE) &&
> > > +                (file_out->f_mode & FMODE_CAN_ODIRECT) &&
> > > +                file_in->f_op->read_iter && file_out->f_op->copy_fil=
e_range)
> > > +               return file_out->f_op;
> > > +       else
> > > +               return NULL;
> > > +}
> > > +
> > > +static int essential_file_rw_checks(struct file *file_in, struct fil=
e
> > > +*file_out) {
> > > +       if (!(file_in->f_mode & FMODE_READ) ||
> > > +           !(file_out->f_mode & FMODE_WRITE) ||
> > > +           (file_out->f_flags & O_APPEND))
> > > +               return -EBADF;
> > > +
> > > +       return 0;
> > > +}
> > > +
> > >  /*
> > >   * Performs necessary checks before doing a file copy
> > >   *
> > > @@ -1484,9 +1509,16 @@ static int generic_copy_file_checks(struct fil=
e
> > *file_in, loff_t pos_in,
> > >         struct inode *inode_out =3D file_inode(file_out);
> > >         uint64_t count =3D *req_count;
> > >         loff_t size_in;
> > > +       bool splice =3D flags & COPY_FILE_SPLICE;
> > > +       const struct file_operations *mem_fops;
> > >         int ret;
> > >
> > > -       ret =3D generic_file_rw_checks(file_in, file_out);
> > > +       /* The dma-buf file is not a regular file. */
> > > +       mem_fops =3D memory_copy_file_ops(file_in, file_out);
> > > +       if (splice || mem_fops =3D=3D NULL)
> >
> > nit: use !mem_fops please
> >
> > Considering that the flag COPY_FILE_SPLICE is not allowed from userspac=
e
> > and is only called by nfsd and ksmbd I think we should assert and deny =
the
> > combination of mem_fops && splice because it is very much unexpected.
> >
> > After asserting this, it would be nicer to write as:
> >         if (mem_fops)
> >                ret =3D essential_file_rw_checks(file_in, file_out);
> >         else
> >                ret =3D generic_file_rw_checks(file_in, file_out);
> >
> Got it. Thanks.
> > > +       else
> > > +               ret =3D essential_file_rw_checks(file_in, file_out);
> > >         if (ret)
> > >                 return ret;
> > >
> > > @@ -1500,8 +1532,10 @@ static int generic_copy_file_checks(struct fil=
e
> > *file_in, loff_t pos_in,
> > >          * and several different sets of file_operations, but they al=
l end up
> > >          * using the same ->copy_file_range() function pointer.
> > >          */
> > > -       if (flags & COPY_FILE_SPLICE) {
> > > +       if (splice) {
> > >                 /* cross sb splice is allowed */
> > > +       } else if (mem_fops !=3D NULL) {
> >
> > With the assertion that splice && mem_fops is not allowed if (splice ||
> > mem_fops) {
> >
> > would go well together because they both allow cross-fs copy not only c=
ross
> > sb.
> >
> Git it.
>
> > > +               /* cross-fs copy is allowed for memory file. */
> > >         } else if (file_out->f_op->copy_file_range) {
> > >                 if (file_in->f_op->copy_file_range !=3D
> > >                     file_out->f_op->copy_file_range) @@ -1554,6
> > > +1588,7 @@ ssize_t vfs_copy_file_range(struct file *file_in, loff_t p=
os_in,
> > >         ssize_t ret;
> > >         bool splice =3D flags & COPY_FILE_SPLICE;
> > >         bool samesb =3D file_inode(file_in)->i_sb =3D=3D
> > > file_inode(file_out)->i_sb;
> > > +       const struct file_operations *mem_fops;
> > >
> > >         if (flags & ~COPY_FILE_SPLICE)
> > >                 return -EINVAL;
> > > @@ -1574,18 +1609,27 @@ ssize_t vfs_copy_file_range(struct file *file=
_in,
> > loff_t pos_in,
> > >         if (len =3D=3D 0)
> > >                 return 0;
> > >
> > > +       if (splice)
> > > +               goto do_splice;
> > > +
> > >         file_start_write(file_out);
> > >
> >
> > goto do_splice needs to be after file_start_write
> >
> > Please wait for feedback from vfs maintainers before posting another
> > version addressing my review comments.
> >
> Are you asking whether both the goto do_splice and the do_splice label sh=
ould
> be enclosed between file_start_write and file_end_write?

No I was just wrong please ignore this comment.

Thanks,
Amir.


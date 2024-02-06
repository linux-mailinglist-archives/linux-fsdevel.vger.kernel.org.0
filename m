Return-Path: <linux-fsdevel+bounces-10455-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E84A84B56D
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Feb 2024 13:39:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A31871C25203
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Feb 2024 12:39:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 111D112F59B;
	Tue,  6 Feb 2024 12:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NvNsnv3q"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com [209.85.217.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4BCC487B4
	for <linux-fsdevel@vger.kernel.org>; Tue,  6 Feb 2024 12:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707223156; cv=none; b=ALdt9SVKdvk9QEXkMlLDx/mV8d3vZLfsHknag8kJ80AdrZeKLbyhI5Ry+WaA1qG5GWUYIFpH1ZFF/I1JfskrMfhLknI7Ayqhfiy6cjpR6bps/RF2eEtEjMWo6llFubSXRCskUI4ia15+/wQBnf3l338EHa8eS/6XSE9m7fbab3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707223156; c=relaxed/simple;
	bh=lMJxEB90BSEE0VUvERqqlFTxVbPnzs1nEoFJiWKYEPI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BEwHKDrvnCAKYTc5Z8wzeWYPK0yyPNK9t4DY6h0fROU4GdWwwKz/jy+B53nnYE9zlvpWoxiyIyYPJwgVFD2YN9yKLmSAnlblWwy4Mu5a46/oQgz4868a+VnkAVrB4aOCzC7+LZ8TsAWCcTnZvOtTnN5F9kndEU0+JD3XUZxGKeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NvNsnv3q; arc=none smtp.client-ip=209.85.217.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f50.google.com with SMTP id ada2fe7eead31-46d321e2344so537182137.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 06 Feb 2024 04:39:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707223153; x=1707827953; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aSzKjgOHpvRp3yoC8/mKxn+A2MUCl3e9+m9Osx9DBJc=;
        b=NvNsnv3q6Fqf7U6njCShCutDeo22PFMPrr3j/9TKepekFjblxntdFNmIKBglLkJkJP
         13B2ybzro0QKBxcmL9ZSvCCv0ir8jyvz8/6r+HL4MCHv2UPQOFJf83AywVk6JI8J5Uq4
         JiYGHe9dWGMIYpQlol852uDUD98qHVhhE+MfLwgvj5weiyVcy/cfljEImJqPYBP8Ja1W
         jgFeJi+TE7GGZZzKF+IRx0iTzCklIoVy1D7l/AQHzpQoWoqCIRbUj4RjFifqTk1w1Vaq
         0+mKY438HqjwhsmlqyJKr9e60PmqeRySgXyjMIKSUXur8nditFpPb/6TVbAcy53cfdkf
         Y0dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707223153; x=1707827953;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aSzKjgOHpvRp3yoC8/mKxn+A2MUCl3e9+m9Osx9DBJc=;
        b=uNjucdPOh8ibqZwZIBHyn+XNHIpnTp9QaQn1jXZbrpvWbXkn98365UsjtrGbhtdkZp
         83JaLBCJoCzRYmGfpBxwCRg453HMUywdj7ntYRcMomTnPbtMIQv1zt1nySV10ZW5Du/L
         nVWKvKBb5E0O9XaZfepGK1jq/t651SlyG56R5KGkrhwZ2OjrXSODhvTuABLQS1/3nqhK
         uXEHk+eVMIK+XJHRfxg0UUY6G6Zf+Kp+JIjH8m93eCPKq6XQOcJlGcgJ+iHGoPVsVhG9
         AKFVKtHjOUTMHUhzkb5svqmkxlPy6oHjCZ+pj1f98fYv1d56oUbAjTSRQGZZO6jM9poX
         EmQg==
X-Gm-Message-State: AOJu0YyN6pSEpAVokobUJUUliS4cJx6zFWZ2Ks341lc1z6oFUBLM7oOB
	B7KD72hTOWde/ouJSoZ6krOGAqmBeAqVVIeGdVbmDzKopsqpnDIpLWoA+DxMXSiLHgzOAt2boQe
	ex/pvuWHjS+bkb+FzqI2gtDIS5io=
X-Google-Smtp-Source: AGHT+IHgNiS9eVEoOWb5I8ni+/3NjyUCtJY7KsUIGhrtYLd2F/7aQ6VcjfUy7fMvQBChCtj+Pd8yzEA8z8UCZcQzaEA=
X-Received: by 2002:a05:6102:18d8:b0:46b:28b7:26ef with SMTP id
 jj24-20020a05610218d800b0046b28b726efmr2685566vsb.16.1707223153381; Tue, 06
 Feb 2024 04:39:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240131230827.207552-1-bschubert@ddn.com> <20240131230827.207552-6-bschubert@ddn.com>
 <CAJfpegvUfQw4TF7Vz_=GMO9Ta=6Yb8zUfRaGMm4AzCXOTdYEAA@mail.gmail.com> <CAOQ4uxjVqCAYhn07Bnk6HsXB21t4FFQk91ywS3S8A8u=+B9A=w@mail.gmail.com>
In-Reply-To: <CAOQ4uxjVqCAYhn07Bnk6HsXB21t4FFQk91ywS3S8A8u=+B9A=w@mail.gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Tue, 6 Feb 2024 14:39:00 +0200
Message-ID: <CAOQ4uxjnrZngNcthc9M5U_SBM+267LMEkYxtoR6uZ8J8YNRvng@mail.gmail.com>
Subject: Re: [PATCH v2 5/5] fuse: introduce inode io modes
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Bernd Schubert <bschubert@ddn.com>, linux-fsdevel@vger.kernel.org, dsingh@ddn.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 1, 2024 at 6:33=E2=80=AFPM Amir Goldstein <amir73il@gmail.com> =
wrote:
>
> On Thu, Feb 1, 2024 at 4:47=E2=80=AFPM Miklos Szeredi <miklos@szeredi.hu>=
 wrote:
> >
> > On Thu, 1 Feb 2024 at 00:09, Bernd Schubert <bschubert@ddn.com> wrote:
> > >
> > > From: Amir Goldstein <amir73il@gmail.com>
> > >
> > > The fuse inode io mode is determined by the mode of its open files/mm=
aps
> > > and parallel dio.
> > >
> > > - caching io mode - files open in caching mode or mmap on direct_io f=
ile
> > > - direct io mode - no files open in caching mode and no files mmaped
> > > - parallel dio mode - direct io mode with parallel dio in progress
> >
> > Specifically if iocachectr is:
> >
> > > 0 -> caching io
> > =3D=3D 0 -> direct io
> > < 0 -> parallel io
> >
> > >
> > > We use a new FOPEN_CACHE_IO flag to explicitly mark a file that was o=
pen
> > > in caching mode.
> >
> > This is really confusing.  FOPEN_CACHE_IO is apparently an internally
> > used flag, but it's defined on the userspace API.
> >
> > a) what is the meaning of this flag on the external API?
> > b) what is the purpose of this flag internally?
>
> The purpose is to annotate the state of direct io file that was mmaped
> as FOPEN_DIRECT_IO | FOPEN_CACHE_IO.
> An fd like this puts inode in caching mode and its release may get inode
> out of caching mode.
>
> I did not manage to do refcoutning with fuse_vma_close(), because those
> calls are not balances with fuse_file_mmap() calls.
>
> The first mmap() of an FOPEN_DIRECT_IO file may incur wait for completion
> of parallel dio.
>
> The only use of exporting FOPEN_CACHE_IO to the server is that it could
> force incurring this wait at open() time instead of mmap() time.
>

Miklos,

I have played with this rebranding of
FOPEN_CACHE_IO =3D> FOPEN_NO_PARALLEL_DIO_WRITES

The meaning of the rebranded flag is:
Prevent parallel dio on inode for as long as this file is kept open.

The io modes code sets this flag implicitly on the first shared mmap.

Let me know if this makes the external flag easier to swallow.
Of course I can make this flag internal and not and FOPEN_ flag
at all, but IMO, the code is easier to understand when the type of
iocachectl refcount held by any file is specified by its FOPEN_ flags.

Let me know what you think.

Thanks,
Amir.

https://github.com/amir73il/linux/commits/fuse_io_mode-wip/

--- a/include/uapi/linux/fuse.h
+++ b/include/uapi/linux/fuse.h
@@ -353,7 +353,7 @@ struct fuse_file_lock {
  * FOPEN_STREAM: the file is stream-like (no file position at all)
  * FOPEN_NOFLUSH: don't flush data cache on close (unless FUSE_WRITEBACK_C=
ACHE)
  * FOPEN_PARALLEL_DIRECT_WRITES: Allow concurrent direct writes on
the same inode
- * FOPEN_CACHE_IO: using cache for this open file (incl. mmap on direct_io=
)
+ * FOPEN_NO_PARALLEL_DIO_WRITES: Deny concurrent direct writes on the
same inode
  */
 #define FOPEN_DIRECT_IO                (1 << 0)
 #define FOPEN_KEEP_CACHE       (1 << 1)
@@ -362,7 +362,7 @@ struct fuse_file_lock {
 #define FOPEN_STREAM           (1 << 4)
 #define FOPEN_NOFLUSH          (1 << 5)
 #define FOPEN_PARALLEL_DIRECT_WRITES   (1 << 6)
-#define FOPEN_CACHE_IO         (1 << 7)
+#define FOPEN_NO_PARALLEL_DIO_WRITES   (1 << 7)

...

-       /* Set explicit FOPEN_CACHE_IO flag for file open in caching mode *=
/
-       if (!fuse_file_is_direct_io(file))
-               ff->open_flags |=3D FOPEN_CACHE_IO;
+       /*
+        * FOPEN_CACHE_IO is an internal flag that is set on file not open =
in
+        * direct io mode and it cannot be set explicitly by the server.
+        * FOPEN_NO_PARALLEL_DIO_WRITES is set on file open in caching mode=
 and
+        * is not allowed together with FOPEN_PARALLEL_DIRECT_WRITES.
+        * This includes a file open with O_DIRECT, but server did not spec=
ify
+         * FOPEN_DIRECT_IO. In this case, a later fcntl() could
remove O_DIRECT,
+        * so we put the inode in caching mode to prevent parallel dio.
+         * FOPEN_PARALLEL_DIRECT_WRITES requires FOPEN_DIRECT_IO.
+         */
+       if (ff->open_flags & FOPEN_NO_PARALLEL_DIO_WRITES) {
+               if (ff->open_flags & FOPEN_PARALLEL_DIRECT_WRITES)
+                       goto fail;
+        } else if (!(ff->open_flags & FOPEN_DIRECT_IO)) {
+               ff->open_flags |=3D FOPEN_NO_PARALLEL_DIO_WRITES;
+               ff->open_flags &=3D ~FOPEN_PARALLEL_DIRECT_WRITES;
+        }


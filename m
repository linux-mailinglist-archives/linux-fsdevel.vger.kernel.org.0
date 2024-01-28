Return-Path: <linux-fsdevel+bounces-9236-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C01D183F4E9
	for <lists+linux-fsdevel@lfdr.de>; Sun, 28 Jan 2024 11:07:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7CD2C282DFD
	for <lists+linux-fsdevel@lfdr.de>; Sun, 28 Jan 2024 10:07:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68B0020B29;
	Sun, 28 Jan 2024 10:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XQbM6ZSq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D68A208A6
	for <linux-fsdevel@vger.kernel.org>; Sun, 28 Jan 2024 10:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706436456; cv=none; b=HCRgOJhCY3JH2ZsYCM/UzRVHMJGr/wMhHsF8s3ld+h2cLLjzE07N34SkhxDskVAaz/IV0qQPvXbUK3MBZr5nLbXEyB6L5GMXV9mFL4bHbISSoLLZBPKMTGTY5k+HIRJI8XAD4UY6Mpr2kfpTg9TidKZSvWP+XIsyHQvekzMcvuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706436456; c=relaxed/simple;
	bh=oOCBoLYAj1OYyf0Hp2g+hf02dDS3YvquaLqfBQRQFOw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ARYgIC/4Szk9RDEoD7IfbGaVETdVp7Lkk6/fHXLyF7gqC/cJDxLmfv3mQr02vNHECQBzpuxlxqESDl1eJFqShcJ9RCGEoYC2Mmuo28AkC1ty7kwwiHMNf3wD6yPWVCORzxDbX2Bj+fztGnx6rCspFW0J/Q03MBpZh6NSW8/7WHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XQbM6ZSq; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-68c420bf6e1so7176786d6.2
        for <linux-fsdevel@vger.kernel.org>; Sun, 28 Jan 2024 02:07:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706436454; x=1707041254; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oOCBoLYAj1OYyf0Hp2g+hf02dDS3YvquaLqfBQRQFOw=;
        b=XQbM6ZSqSZSy0+ODRh+hDlFL6+nHZ8L+Zg5ZBzrFRiDu0UZ7IvZFfMj/h1vXL2oa6c
         YJhwwWbtHpR9NYYoJr+M6BtyY+PgAOnhV/3ZX7cInOHMxb8clDaJbR5ZFvMja9/bvjCp
         e5yZioowE6tIxr9aECi+4Wtfbv00AvmYYWao7sLnJ8shA+WGWwnFELJk9OoFeY+Gp46S
         Eah+bq6TJ8/qeuPS23vzETvPsiJvoSVLEU5TUZ+4BftSrEEeO1e1eDo8H76PCaUdrCJF
         vjQYj8SojKzOMzZ75zVxF9kcLTCRv8ZzsAfpvv9tp63VMqeWyhMyf4Ixq5FzSU9GeS+9
         j6Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706436454; x=1707041254;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oOCBoLYAj1OYyf0Hp2g+hf02dDS3YvquaLqfBQRQFOw=;
        b=oCxf6n4+fdYH7KcZ84qpPDg9s9URflrXz9xxsFv1VgwWpjLxE308gQqDFpz9bvDFsm
         Q+JfV27fzeqtXq47UbQDdCLHy8EuAR1Zix1zRbgcDlhpfbH+FjU8K6ruZLClC+syva3B
         ahAOPAqWtSMZnhlletGNBNPgDxNxjArUje5c6Vz2jVaReTEGZ3u1kci2R/8UqxwMRZc2
         ZVX+usgg9gRiD3q+yyYQB9v7JsuLzObPGr6Cd05zP5ASxgFDRiCAPoium2Gr5659QR0Q
         xVh+scXRBz9BkdKLeigpDU8hDOvGCyNEBMrMduAPNkZ7zTxMUgDbsRwSIAdUzpMvkxky
         yfhw==
X-Gm-Message-State: AOJu0YxDqhNHrhb1Clkuxi8ZQI7QssPYnDEBuZM50WFeLeMxrvlqxrh7
	T1mNXEgz8W1mBrcIYNtWPkw47hPogmTm3/Gf/FPC4hGzVyd08Pw8Ju8tiM6Ak140QcgiDLAv87R
	LP/9iUAs8FjApDsViP9rzlcrrpzY=
X-Google-Smtp-Source: AGHT+IElEVeDC8XLqQixNILUk0mzoPP2Kv1misghoohC0MWTc+DF6gxe5F69rkYaBeOOZFSb/34IIuumU+Vi9OWmcls=
X-Received: by 2002:a05:6214:e6c:b0:68c:4cc5:7951 with SMTP id
 jz12-20020a0562140e6c00b0068c4cc57951mr140855qvb.58.1706436454194; Sun, 28
 Jan 2024 02:07:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1fb83b2a-38cf-4b70-8c9e-ac1c77db7080@spawn.link>
In-Reply-To: <1fb83b2a-38cf-4b70-8c9e-ac1c77db7080@spawn.link>
From: Amir Goldstein <amir73il@gmail.com>
Date: Sun, 28 Jan 2024 12:07:22 +0200
Message-ID: <CAOQ4uxgoJkotsP6MVuPmO91VSG3kKWdUqXAtp37rxc0ehOSfEw@mail.gmail.com>
Subject: Re: [fuse-devel] FICLONE / FICLONERANGE support
To: Antonio SJ Musumeci <trapexit@spawn.link>
Cc: fuse-devel <fuse-devel@lists.sourceforge.net>, 
	linux-fsdevel <linux-fsdevel@vger.kernel.org>, Miklos Szeredi <miklos@szeredi.hu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 28, 2024 at 2:31=E2=80=AFAM Antonio SJ Musumeci <trapexit@spawn=
.link> wrote:
>
> Hello,
>
> Has anyone investigated adding support for FICLONE and FICLONERANGE? I'm
> not seeing any references to either on the mailinglist. I've got a
> passthrough filesystem and with more users taking advantage of btrfs and
> xfs w/ reflinks there has been some demand for the ability to support it.
>

[CC fsdevel because my answer's scope is wider than just FUSE]

FWIW, the kernel implementation of copy_file_range() calls remap_file_range=
()
(a.k.a. clone_file_range()) for both xfs and btrfs, so if your users contro=
l the
application they are using, calling copy_file_range() will propagate via yo=
ur
fuse filesystem correctly to underlying xfs/btrfs and will effectively resu=
lt in
clone_file_range().

Thus using tools like cp --reflink, on your passthrough filesystem should y=
ield
the expected result.

For a more practical example see:
https://bugzilla.samba.org/show_bug.cgi?id=3D12033
Since Samba 4.1, server-side-copy is implemented as copy_file_range()

API-wise, there are two main differences between copy_file_range() and
FICLONERANGE:
1. copy_file_range() can result in partial copy
2. copy_file_range() can results in more used disk space

Other API differences are minor, but the fact that copy_file_range()
is a syscall with a @flags argument makes it a candidate for being
a super-set of both functionalities.

The question is, for your users, are you actually looking for
clone_file_range() support? or is best-effort copy_file_range() with
clone_file_range() fallback enough?

If your users are looking for the atomic clone_file_range() behavior,
then a single flag in fuse_copy_file_range_in::flags is enough to
indicate to the server that the "atomic clone" behavior is wanted.

Note that the @flags argument to copy_file_range() syscall does not
support any flags at all at the moment.

The only flag defined in the kernel COPY_FILE_SPLICE is for
internal use only.

We can define a flag COPY_FILE_CLONE to use either only
internally in kernel and in FUSE protocol or even also in
copy_file_range() syscall.

Sure, we can also add a new FUSE protocol command for
FUSE_CLONE_FILE_RANGE, but I don't think that is
necessary.
It is certainly not necessary if there is agreement to extend the
copy_file_range() syscall to support COPY_FILE_CLONE flag.

What do folks think about this possible API extension?

Thanks,
Amir.


Return-Path: <linux-fsdevel+bounces-23041-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D397C9263A1
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jul 2024 16:42:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 888CA287C45
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jul 2024 14:42:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E68417C207;
	Wed,  3 Jul 2024 14:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cm7xXf2Y"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56A1B17BB01;
	Wed,  3 Jul 2024 14:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720017728; cv=none; b=qGyHJVuYQ+hfPQetr3sGBhPgvSHRZDl0iZPwVLXSOc7QtlxMen73HEwyfU4yOvlw8jhDJlzWa++X4Pn/mxJpn6F+wtcYEeR88eI0WSW8erLT1RPMcgMyRFj8S0OanC5XxPWLDaPm0RvAHMZtXZoNNuudbtjAOlouvnDiVK5arfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720017728; c=relaxed/simple;
	bh=y1XsSq4wekcx/s9y/Fu4woRrMmqcpQpIdMnZs2NctUU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Dwy/jL9pgEhO6pjdGIFUBtF5XsWDEwhMM7UQjlbJb3GJEqCgVzlZYnEhBnir8ZyDTEn4u/1m680ygFDWEk1AyrmMOwqd9yn9FhI9y1V3Qgd3si7LLEV2bPJfJ4bo+vyBjpcRXpaVSIJ8Gd7pmmy98UwX14E4XJNaxm2rTEg4EzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cm7xXf2Y; arc=none smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-701fcdff10fso2444229a34.3;
        Wed, 03 Jul 2024 07:42:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720017726; x=1720622526; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=07CmZVIaq3QDFAXqfa0QdNB9rJ8vQUa2/74NR0GJchI=;
        b=cm7xXf2YF4qe95hUgg0mgruFcB7bafBzQBXmFiMZdlUoAw+CM+hU2yVhkkYl76kbgT
         gmwcsroO+ZEL8WIFNolh23gfBw+M1UUGEB2XlEPeROp4lzDohqXIxQvIbbKhNa6uOOuK
         +v3I70IbEHgV4wpg9E5dE2+94e15JdKB0+V150oY4QVGDBfgZnQ1BVbkFw/JInrhd0IM
         cZHKY6cR+H+zZuIy79xVsuc8F15zqxw79dQ2O0mmt+7hSn5M/Lq1kLsHgtq8xirDVild
         2PTU4+ZZL5HOnjzTfNZCthhkK7RMwqpzRwGuGgsE7FKSFSo54uebpNiuCGT75G4TL8a8
         eWvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720017726; x=1720622526;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=07CmZVIaq3QDFAXqfa0QdNB9rJ8vQUa2/74NR0GJchI=;
        b=RWwK7u9T9jTplPGBp4ufFiqa7I8cjlWi3aFcmsL58EClUV22cn6LHZH/9h7i0vHK86
         ktzmTYWhPt2xen8K5TtiOSKh0LBWintkCuOLSbgbN6yIWAZQmIcBeLoUkLxDhoGG/EFU
         rOGAIp1DseNYdnDfxn7FgNZedkR/0eJ1oYPO1bBLQYIF5DLSJXZQxF1m+UIQBjwOPQGd
         4ti37lI7tyy7QsxBCzQjZ+CwtK6C+iGNIWdaNCB1tvMxz2fj/O0JLC5+krB5SIRsSCMQ
         S58sXSjIzy/tyUsb8xZ1JUVwwt1B7CM7sy0SnBn3xCNSbyiG4nhC6quk9UyKZ69jt/dJ
         OPVQ==
X-Forwarded-Encrypted: i=1; AJvYcCUGeOy4QWdf8Ja0NRxrUpLu7CB84hoEmLKTn6815AZHOX70UUaDI1VnTjLliJdZxZJyz2bS6wft6+VfadQl7KQ+pTv67K0+t/rGn6YF9y+0GxmDsYR/TAHatFYiR5SRH8U2D0crfW5Mhsp+IQ==
X-Gm-Message-State: AOJu0YxCRgLW7m2FqvdlV1gE+xgzviA8xhJO3ZO1Y3kfXoMo14qMpoxv
	odrAaL8QFE+IEL6Yxpn1mqT54iRKEVDE46nzXTOewIpe08SPieOyUbo2/Q850kivVk5KugKuC+2
	+pFlSg0jh/Mq+XIXrjq01R+ufKlg=
X-Google-Smtp-Source: AGHT+IFCLQriER+0Mz8QEJilN7vBtTRTmA07M6EtVO8QrrKsqAkKYDFMXMXkxPCAOLEzLTg1vxeH029Mnki/rPi2LKc=
X-Received: by 2002:a05:6830:1e09:b0:702:260e:8bcc with SMTP id
 46e09a7af769-702260e8c4bmr3936001a34.13.1720017726106; Wed, 03 Jul 2024
 07:42:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240703010215.2013266-1-drosen@google.com> <315aef06-794d-478f-93a3-8a2da14ec18c@fastmail.fm>
In-Reply-To: <315aef06-794d-478f-93a3-8a2da14ec18c@fastmail.fm>
From: Amir Goldstein <amir73il@gmail.com>
Date: Wed, 3 Jul 2024 17:41:53 +0300
Message-ID: <CAOQ4uxhYcNvQc-Y+ZZSGyX1Un8WCJuE-aeiRrgLm91HwJ48gWA@mail.gmail.com>
Subject: Re: [PATCH 0/1] Fuse Passthrough cache issues
To: Bernd Schubert <bernd.schubert@fastmail.fm>
Cc: Daniel Rosenberg <drosen@google.com>, Miklos Szeredi <miklos@szeredi.hu>, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 3, 2024 at 4:27=E2=80=AFPM Bernd Schubert
<bernd.schubert@fastmail.fm> wrote:
>
>
>
> On 7/3/24 03:02, Daniel Rosenberg wrote:
> > I've been attempting to recreate Android's usage of Fuse Passthrough wi=
th the
> > version now merged in the kernel, and I've run into a couple issues. Th=
e first
> > one was pretty straightforward, and I've included a patch, although I'm=
 not
> > convinced that it should be conditional, and it may need to do more to =
ensure
> > that the cache is up to date.
> >
> > If your fuse daemon is running with writeback cache enabled, writes wit=
h
> > passthrough files will cause problems. Fuse will invalidate attributes =
on
> > write, but because it's in writeback cache mode, it will ignore the req=
uested
> > attributes when the daemon provides them. The kernel is the source of t=
ruth in
> > this case, and should update the cached values during the passthrough w=
rite.
>
> Could you explain why you want to have the combination passthrough and
> writeback cache?
>
> I think Amirs intention was to have passthrough and cache writes
> conflicting, see fuse_file_passthrough_open() and
> fuse_file_cached_io_open().

Yes, this was an explicit design requirement from Miklos [1].
I also have use cases to handle some read/writes from server
and the compromise was that for the first version these cases should
use FOPEN_DIRECT_IO, which does not conflict with FOPEN_PASSTHROUGH.

I guess this is not good enough for Android applications opening photos
that need the FUSE readahead cache for performance?

In that case, a future BPF filter can decide whether to send the IO direct
to server or to backing inode.

Or a future backing inode mapping API could map part of the file to
backing inode
and the metadata portion will not be mapped to backing inode will fall back=
 to
direct IO to server.

[1] https://lore.kernel.org/linux-fsdevel/CAJfpegtWdGVm9iHgVyXfY2mnR98XJ=3D=
6HtpaA+W83vvQea5PycQ@mail.gmail.com/

>
> Also in <libfuse>/example/passthrough_hp.cc in sfs_init():
>
>     /* Passthrough and writeback cache are conflicting modes */
>
>
>
> With that I wonder if either fc->writeback_cache should be ignored when
> a file is opened in passthrough mode, or if fuse_file_io_open() should
> ignore FOPEN_PASSTHROUGH when fc->writeback_cache is set. Either of both
> would result in the opposite of what you are trying to achieve - which
> is why I think it is important to understand what is your actual goal.
>

Is there no standard way for FUSE client to tell the server that the
INIT response is invalid?

Anyway, we already ignore  FUSE_PASSTHROUGH in INIT response
for several cases, so this could be another case.
Then FOPEN_PASSTHROUGH will fail with EIO (not be ignored).

> I think idea for conflicting file cached and passthrough modes is that
> the backing inode can already provide a cache - why another one for fuse?
>
>
> >
> > The other issue I ran into is the restriction on opening a file in pass=
through
> > and non passthrough modes. In Android, one of our main usecases for pas=
sthrough
> > is location metadata redaction. Apps without the location permission ge=
t back
> > nulled out data when they read image metadata location. If an app has t=
hat
> > permission, it can open the file in passthrough mode, but otherwise the=
 daemon
> > opens the file in normal fuse mode where it can do the redaction.
> >
> > Currently in passthrough, this behavior is explicitly blocked. What's n=
eeded to
> > allow this? The page caches can contain different data, but in this cas=
e that's
> > a feature, not a bug. They could theoretically be backed by entirely di=
fferent
> > things, although that would be fairly confusing. I would think the main=
 thing
> > we'd need would be to invalidate areas of the cache when writing in pas=
sthrough
> > mode to give the daemon the opportunity to react to what's there now, a=
nd also
> > something in the other direction. Might make more sense as something th=
e daemon
> > can opt into.
> >
> > Any thoughts on these issues? And does the proposed fix make sense to y=
ou?

FYI, Miklos suggested that attributes will be passthrough to the "backing i=
node"
when inode is in passthrough mode, which requires lookup-to-forget semantic=
s
just like in the BPF patches.

I have started a POC of this [2], but got sidetracked to other things.
I am not sure when I will be able to get back to them.
If this is interesting to you either for solving the specific attribute mis=
match
issue or as a stepping stone towards FUSE BPF, do feel free to pick up
my patches.

[2] https://github.com/amir73il/linux/commits/fuse-backing-inode-wip/

Let me know if you have any questions about them.

Thanks,
Amir.


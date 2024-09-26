Return-Path: <linux-fsdevel+bounces-30164-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E3CC987381
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Sep 2024 14:24:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E6721C22863
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Sep 2024 12:24:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E64C0178367;
	Thu, 26 Sep 2024 12:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KsnE3XT0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAEF0177992
	for <linux-fsdevel@vger.kernel.org>; Thu, 26 Sep 2024 12:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727353485; cv=none; b=syZwk0oucuE2+FaOmZjzFhbyhJB1sX8xJbK8BEXWvt839UtBIRFrJM3ZUxaWg3MsdlnQ46TOd8+8bhwxgcZ7Zh5Nt66VclpcaxxkpjSVB5szevWMvre14kCdXWfFglL8/4y4ZxUC7vn+GD6QulPtuiV3qN6/ZwKiBYI+9NleXf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727353485; c=relaxed/simple;
	bh=zrcBz7I3rALhJnc2KoGnpAkDw2zpzUEDCmeixy9baC0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DdL0NUrMErGz93aUegCAGLUdqi8ls9DhcLxkd/NZWT/iU/H3J2OHkN0xMGBmyS4RBBNXz29Jgx0bOk98ACQz9zyREFguaTlJ4tybJjGm5PaXC0a1nlfbAYjEZnvKuOiDiW5gMD7fv0j18QvXDEswT999s3KAGbQwFafgQV7XfCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KsnE3XT0; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-7a99a46af10so85905285a.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 26 Sep 2024 05:24:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727353482; x=1727958282; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bDtOzCFSgT9zCcZlFjkCV7vc919Lgexz0Fc0s+RB1yM=;
        b=KsnE3XT0bMAMw4bZUtgisPlHLhzvVm87Gl0rIVFoszNQ/2etqYhIFGWSuq/icR7dwy
         l19kNLCuQP0AMYUsEsUT/HGkFzSsbhf6breFKPz90jE20rMLzHAuSHI99SOeViAesw+g
         qwYLUWMfO9AkbgGsvghRA8+3rQ1WPGOGJK17XQhmr8243hWqgWjts2gEZy54WqH9Vfe0
         xhROzygKV00F8UkNlWyGJZmmL1DYNrOqnYaed6ECE/aiYNmT1MCs/2xl8STi65zKp4o7
         2CdFoJFjPtDAnUx5M4o61f5rGIMaXuH16vesaDur5gPjRIh5I1fLbPQ394VD0bnem9js
         xUDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727353482; x=1727958282;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bDtOzCFSgT9zCcZlFjkCV7vc919Lgexz0Fc0s+RB1yM=;
        b=mAahRaLPfkIXACrA6K/8xoL/NHtXx0sHg4blDJty9pTaBZnVEQPShirFqtRv4WdhfH
         jNdwJYhD/ege64T4BH0bcLsNbTzGnCO0zthn/voq9JdfrnDJIIYnxcXMzN+VWEu7WCBF
         jPnGDQgdKBHXpSuHgcMU7NuC8y/shIorKFlkdLFwkGaw25zWvKfZ3kt89rpxfKImE1d5
         d/PzQC1ujRvU3+KNLQ6vUKN7donVGSLpDo70PevPwr5edVk4f18SiL3CAJ+idht80dv/
         HAteE4M17JEFk7XXGO77LKq0vgDGI2N2+y4eCd2674VLF78sJKOulL3thMT65riMP6D6
         neLg==
X-Forwarded-Encrypted: i=1; AJvYcCWJACdqYQrxfmjpqi2U9nDi0H2FxlwVnjm8sUXtewAntdOnSLeAMDSDCiy53Img47FJH1CPWVN3/fYnrfct@vger.kernel.org
X-Gm-Message-State: AOJu0YzBtyTvAdpQ8Isz5CAAXbMhT/gev5IMT3unsEOen4jwxgT5F4Ap
	R7K2BJ+NznEuOJQ0eEt4pFAeweod9hyfTVDRfJFSQ4+qXXTzvcY2Zh8OJ06+otpKbNh3iLAzru/
	R8Ig6U0gZOC5ddCpULyDTry+358aKjKstgQA=
X-Google-Smtp-Source: AGHT+IFjpT+oXmeaN13ckttytWLdO+dY4zK5i4mANpIPUJwPStbKyK1vqmzBiX/jWf8HjIcQssfaMFhE23hmdOnnrUE=
X-Received: by 2002:a05:620a:19a3:b0:7a9:c129:5da7 with SMTP id
 af79cd13be357-7ace741182amr990623185a.29.1727353482299; Thu, 26 Sep 2024
 05:24:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJfpegsmxdUwKWqeofn9-DYvqmPWafwxQfy4nLgfvosvhXfjOA@mail.gmail.com>
In-Reply-To: <CAJfpegsmxdUwKWqeofn9-DYvqmPWafwxQfy4nLgfvosvhXfjOA@mail.gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 26 Sep 2024 14:24:31 +0200
Message-ID: <CAOQ4uxji-2L-W2+e==NgmhS7i9mMjR4rW9A1_Bkx3aSzB5roAA@mail.gmail.com>
Subject: Re: optimizing backing file setup
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Bernd Schubert <bernd.schubert@fastmail.fm>, Jakob Blomer <jakob.blomer@cern.ch>, 
	Jann Horn <jannh@google.com>, Laura Promberger <laura.promberger@cern.ch>, 
	Valentin Volkl <valentin.volkl@cern.ch>, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 26, 2024 at 11:30=E2=80=AFAM Miklos Szeredi <miklos@szeredi.hu>=
 wrote:
>
> I'm following up on this item mentioned by the CernVM-FS developers.
>
> The concern with the current passthrough interface is that for small
> files it may add more overhead than it eliminates.
>
> My suggestion was to simply not use passthrough for small files, but
> maybe this deserves a little more thought.
>
> The current interface from the fuse server's point of view is:
>
>   backing_fd =3D open(backing_path, flags);
>   struct fuse_backing_map map =3D { .fd =3D backing_fd };
>   backing_id  =3D ioctl(devfd, FUSE_DEV_IOC_BACKING_OPEN, &map);
>
>   struct fuse_open_out outarg;
>   outarg.open_flags |=3D FOPEN_PASSTHROUGH;
>   outarg.backing_id =3D backing_id;
> [...]
>   ioctl(devfd, FUSE_DEV_IOC_BACKING_CLOSE, &backing_id);
>
> The question is: can we somehow eliminate the ioctl syscalls.  Amir's
> original patch optimized away the FUSE_DEV_IOC_BACKING_CLOSE by
> transferring the reference to the open file.  IIRC this was dropped to
> simplify the interface, but I don't see any issues with optionally
> adding this back.

I think it can be workable.

>
> The FUSE_DEV_IOC_BACKING_OPEN could also be eliminated when using the
> io_uring interface, since that doesn't have the issue that Jann
> described (privileged process being tricked to send one of its file
> descriptors to fuse with a write(2):
> https://lore.kernel.org/all/CAG48ez17uXtjCTa7xpa=3DJWz3iBbNDQTKO2hvn6PAZt=
fW3kXgcA@mail.gmail.com/)
>
> AFAICS it's not enough to restrict the backing fd to be an O_PATH or
> O_RDONLY fd.  That would likely limit the attack but it might still
> allow the attacker to gain access to an otherwise inaccessible file
> (e.g. file is readable but containing directory is not).

Daniel took a different approach for averting the security issue
in the FUSE BPF patches.
The OPEN response itself was converted to use an ioctl instead of write:
https://lore.kernel.org/linux-fsdevel/20240329015351.624249-6-drosen@google=
.com/
as well as the LOOKUP response.

Are there any negative performance or other implications in this approach?

Thanks,
Amir.


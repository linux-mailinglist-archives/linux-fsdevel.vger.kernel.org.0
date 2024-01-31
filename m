Return-Path: <linux-fsdevel+bounces-9711-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0B94844840
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Jan 2024 20:49:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F37461C21B27
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Jan 2024 19:49:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94B723E49D;
	Wed, 31 Jan 2024 19:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="nWs6NzYV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ABE0381D6
	for <linux-fsdevel@vger.kernel.org>; Wed, 31 Jan 2024 19:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706730560; cv=none; b=o3Kaz6w+whfKoZGkEgSjzgGpjvm/okEAMpdJQFlsKJs3kMkiKlJDGOUw2P80fI5RpYkts3qkxfz3dUcF3h6+S+abbS/xnIC14nPHZn+W3ecldYggLzl5+zHT7NlcbU0MD8+S3K5l0afZd0/7eIk5euhQnluaDcaYxJJXgV5Ohv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706730560; c=relaxed/simple;
	bh=tZcubABWP4p+PUyhfH6FzH0uYN3/AZjH0UMh30BsGAk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hxy20+uutXb5GpR3D5g0HS1oUB2x0p26+fpN1FQMFvCzXsojnEN43HzcwCVxop3oPg6ex2mw0zYExwK8JRnBqxW7dW0EWFnnt1mzsMoHcbOu8THnctYWQF2AjMlDGYmHpqO8xcz3pDIz9QiKWOEKPioracRH7v28IodyhkQd0Ic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=nWs6NzYV; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a35385da5bbso16116166b.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 31 Jan 2024 11:49:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1706730556; x=1707335356; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=w4m92Mg3PsLlecNHbIrvq/RMmBhqIGNNfRvOCBsW06g=;
        b=nWs6NzYVdMA1rbfYpj9pwtxVLh/tL2KvOiez2XbNN+Csya/CkPW1xxBGa7rUjMbR0m
         2D/eXEFHyrqADx/cFuZkjBHCKwW8fZ8gsuExN8ymJUZXGIQ+xPFPCX8rN9YR+CPZzjLR
         /zE9zJgB5jTCPQj6ToxgpDOiO175+PkqCTuHI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706730556; x=1707335356;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=w4m92Mg3PsLlecNHbIrvq/RMmBhqIGNNfRvOCBsW06g=;
        b=ZgZUoih8jpThl2Dty5ZaHkh+WronBWR5JSPRUSh34TGAxSIEGjn86/8cjApAaZadNi
         JryCDLEtjcayZQ2LqiFaz1O8xONMHXO86mgMwAhEr5UnbOILsVfkXA25/6nqfgAczx/E
         PA/yzwNQ0hs9OnqSMxEv19dtP5WVMllpzoo5qqh0yVGsEmLwDR5zhCkbdDzcZZD7kiXh
         m/xwZO1cmkMZjncl9Y22eO4j2Hs0vlND25ifpphZGOr21YDrem4S0R8gd6tstkTzwGho
         0LbwhUl/uugfRjG4zyreHJPRIl69EjJJplehtcvdDw3OPfKNYPxWfrSr0SVzAfWWhwkd
         yQeA==
X-Gm-Message-State: AOJu0YwaY70OBY5Q7cumVSDBVkFm68sI4PXQltquWESJlOTKn8yO0TW8
	toV5qmkbVMehdU1vwELE07lQXx62FvkzoYqdttC00vk8p6/1drlkQJP18K+hrImTY7mkauy8tNU
	nu2OfeRDJ7ExUkoe7QcMaN63qiX4mbkVnTzdjJg==
X-Google-Smtp-Source: AGHT+IHVYHuwadO5hyl6t0OmWzVHrSNscBOHXCRtlHwexAU0/RB7Ya+T4rewpZRYpgtj8PqFc3QE7gtiQpCqTa2uo5w=
X-Received: by 2002:a17:906:5acf:b0:a2f:68cb:dbe3 with SMTP id
 x15-20020a1709065acf00b00a2f68cbdbe3mr1757941ejs.75.1706730556370; Wed, 31
 Jan 2024 11:49:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <VI1PR08MB31011DF4722B9E720A251892827C2@VI1PR08MB3101.eurprd08.prod.outlook.com>
In-Reply-To: <VI1PR08MB31011DF4722B9E720A251892827C2@VI1PR08MB3101.eurprd08.prod.outlook.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Wed, 31 Jan 2024 20:49:04 +0100
Message-ID: <CAJfpegvBc+Md51ubYv9iDnST+Xps9P=g51NcWJONKy4fq=O8+Q@mail.gmail.com>
Subject: Re: [overlay] [fuse] Potential bug with large file support for FUSE
 based lowerdir
To: Lukasz Okraszewski <Lukasz.Okraszewski@arm.com>
Cc: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, 
	Matthew Clarkson <Matthew.Clarkson@arm.com>, Brandon Jones <Brandon.Jones@arm.com>, nd <nd@arm.com>, 
	overlayfs <linux-unionfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Wed, 31 Jan 2024 at 17:38, Lukasz Okraszewski
<Lukasz.Okraszewski@arm.com> wrote:
>
> Hello all,
>
> I have stumbled into what I suspect may be a bug in the overlayfs/fuse stack.
>
> The repro script looks like this:
> ```sh
> #!/bin/bash
>
> set -xe
>
> for i in large1 large2;
> do
>   if [ -f $i.squashfs ]; then
>     continue
>   fi
>   mkdir -p $i
>   pushd $i || exit 1
>   yes $i | head -c 4GB > test.file
>   popd || exit 1
>   mksquashfs $i $i.squashfs
> done
>
> rm -rf work
> mkdir -p work/{lower0,lower1,lower2,upper,work,mnt}
>
> squashfuse -o allow_other large1.squashfs work/lower1
> squashfuse -o allow_other large2.squashfs work/lower2
>
> trap "set +e; fusermount -u $(realpath work/lower1); fusermount -u $(realpath work/lower2); sudo umount --verbose -l $(realpath work/mnt)" EXIT
>
> sudo mount \
>   -t overlay \
>   -o lowerdir=work/lower2:work/lower1:work/lower0,upperdir=work/upper,workdir=work/work\
>   overlay \
>   work/mnt
>
> pushd work/mnt
> dd if=/dev/zero of=test.file bs=4k count=80
> popd
> ```
>
> When writing to the file I see the following error:
> ```
> test.file: Value too large for defined data type
> ```
>
> The file can be read just fine, stat works.
> Mounting the squashfs with sudo and a loop device does not have this problem.
>
> Now, dmesg shows:
> ```
> [Jan31 08:38] overlayfs: failed to retrieve lower fileattr (/test.file, err=-75)

So this is a FUSE_IOCTL/FS_IOC_GETFLAGS request for which the server
replies with EOVERFLOW.  This looks like a server issue, but it would
be good to see the logs and/or strace related to this particular
request.

Thanks,
Miklos


Return-Path: <linux-fsdevel+bounces-30567-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B80AA98C5D9
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Oct 2024 21:15:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6583D1F21B57
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Oct 2024 19:15:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A991C1CCEC2;
	Tue,  1 Oct 2024 19:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bZhcVsvV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9E2B27448;
	Tue,  1 Oct 2024 19:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727810132; cv=none; b=kLkzGBBSexH8Avaog7RCKWUcDVhFRfhWoUWv05VG39gSzinef5C/RTNDgltjVomoNEym5NreCN6eA4vUvf6a34IJ0eBJd1yEiAS1EOzOun8R9m3AapvFPU7b3B+V3fzm7c0Ch2ifBI1cwmi7g0rrYP2yjub9wYGkDzh4jnCDQrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727810132; c=relaxed/simple;
	bh=oHX9oLhS2fcLUzguZRgRlHOmYwopH0LeGht+u7rjoVk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=axZFkCY12sEKKvuHxaupS7cvb6ltwyLP+3IpVLi9DZq2ZQrItEZeVmAlrve5QNlqPUvcokSQq8nyLOK4nPs7G4kztFsSAUcyEdXHGA6rhgXMJ7J+dO596y9veg1533Ts/0nFWm5HTPKLaL7d6zO0R6Wwaabse8/9NodeOVAU+/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bZhcVsvV; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2e0a74ce880so4871452a91.2;
        Tue, 01 Oct 2024 12:15:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727810130; x=1728414930; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ROw0OxXZu/qRMTETvniaDIW4ULnJVrS+jSpbp/URjhs=;
        b=bZhcVsvVNv0hxf2au7Mebgt7tHRKJcMGgMMqVa7TnCWGvIN4WmTIQyIDk15JJ8X8kA
         b1+rnFUDPj0bGdVUP2tiPpp3Lo/+HZzvTIIG5DOeM6De608cZ0dKjRGcIB+VPHb57PMs
         1axCUApznNYkCmfY5uaJ7bURuTtzvKxc+hBY4QiBqk1K6ixsFB5EOpCVe4u5coQOLK9X
         r1ElMFBiaAaxdH9VXwveBYpV/iQg3fsT2Zqm78ztD+Pvcvcg/mqfLDy2bWhZbC7ApD3I
         Be0XtlEGFTX5fMLysynLu9KW2fGvmZ2Gv9TKPg95jSwZaa+tWhDWofWuMzuohIjB6wfJ
         7TDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727810130; x=1728414930;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ROw0OxXZu/qRMTETvniaDIW4ULnJVrS+jSpbp/URjhs=;
        b=YHjGnMdMOgNXYnUhuxAbNwEFGtILL5V+PAbRiKQTt253IPvNUd5A9fFBnYtZHEQmvl
         Q6vACKBy4fUzMq23MiI28wKXOFGbV1w89ud3cx72mpOgcSEcd6DWhbQpEoOnoCjNdQz/
         cwfwx6cVL8ZFqLEwEayZgj+LcWEKSJVliu7+ZspXdSI8DgA1NnZZHFU23bdDvHR8/Vi5
         WtKcDKmOtXwnVMahnfo5oyzPtJfn/tCUdy2V/NE9iQmgrjSCvuJYwMVRkMYX52esilIL
         mLYCGAVMaUDenCxLg9X7o9oiPbBZ9o+xw3o4zQoJnZ7MsalS2wk7Lfb2PXOB0Uan+dZP
         NVsw==
X-Forwarded-Encrypted: i=1; AJvYcCUpigyGEnik5b0x/v7zn3uNq1OL3g0npgseuuDj1VJm7tzHeWdSHyoJ+JzWzxTGo4BIhEH3T5ZuHVvd6cUm@vger.kernel.org, AJvYcCXgmcHLgxJxICY6FZs/jTeqw4xSo53Z0XSP0MwmFuZ1csJHhl8mRt8QFVYqKHmJwDfCO522ARaLQ+8RUnaO@vger.kernel.org
X-Gm-Message-State: AOJu0YwrtGgz+CgBq9hYKS5Wu0vR74ax1VXlR1D8DZSYHBeUqSl2NCiv
	U1khtS0RNKRrCGu6aCz678BPIjcWZc/uDwjJXCRapn/pLwKK+velrXoR+ORwTwQeezMzZ1Bb/zb
	QlK+A2ulgDMFRpFdxgIPl3rVfJUQ=
X-Google-Smtp-Source: AGHT+IEZYZ9JNe7sHu4GBFJ6hLXR9WIV/8R2Jz2qqX/MxHVuDJ0OhPAc3NQ6vGOJ6Z7qTWLgyUXL2bSD0g0wad8+krg=
X-Received: by 2002:a17:90a:bf17:b0:2e1:89aa:65b7 with SMTP id
 98e67ed59e1d1-2e189aa680dmr223483a91.9.1727810130020; Tue, 01 Oct 2024
 12:15:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <8196cf54-5783-4905-af00-45a869537f7c@leemhuis.info>
 <ZvvonHPqrAqSHhgV@casper.infradead.org> <b77aa757-4ea2-4c0a-8ba9-3685f944aa34@leemhuis.info>
In-Reply-To: <b77aa757-4ea2-4c0a-8ba9-3685f944aa34@leemhuis.info>
From: =?UTF-8?Q?Krzysztof_Ma=C5=82ysa?= <varqox@gmail.com>
Date: Tue, 1 Oct 2024 21:15:04 +0200
Message-ID: <CACw1X3iPMW1+cw8Pz_CG_9KM=Z9XycRPbzF0WDD1nxV1TDn2gQ@mail.gmail.com>
Subject: Re: [regression] getdents() does not list entries created after
 opening the directory
To: Linux regressions mailing list <regressions@lists.linux.dev>
Cc: yangerkun <yangerkun@huawei.com>, Christian Brauner <brauner@kernel.org>, 
	linux-fsdevel@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>, 
	LKML <linux-kernel@vger.kernel.org>, Matthew Wilcox <willy@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

wt., 1 pa=C5=BA 2024 o 14:49 Linux regression tracking (Thorsten Leemhuis)
<regressions@leemhuis.info> napisa=C5=82(a):
>
> On 01.10.24 14:18, Matthew Wilcox wrote:
> > On Tue, Oct 01, 2024 at 01:29:09PM +0200, Linux regression tracking (Th=
orsten Leemhuis) wrote:
> >>>     DIR* dir =3D opendir("/tmp/dirent-problems-test-dir");
> >>>
> >>>     fd =3D creat("/tmp/dirent-problems-test-dir/after", 0644);
> >
> > "If a file is removed from or added to the directory after the most
> > recent call to opendir() or rewinddir(), whether a subsequent call to
> > readdir() returns an entry for that file is unspecified."
> >
> > https://pubs.opengroup.org/onlinepubs/007904975/functions/readdir.html
> >
> > That said, if there's an easy fix here, it'd be a nice improvement to
> > QoI to do it, but the test-case as written is incorrect.
>
> Many thx Willy!
>
> Which leads to a question:
>
> Krzysztof, how did you find the problem? Was there a practical use case
> (some software or workload) with this behavior that broke and made your
> write that test-case? Or is that a test-program older and part of your
> CI tests or something like that?
>
> Ciao, Thorsten

I have a unit test (
https://github.com/varqox/sim-project/blob/889bcee60af56fa28613aaf52d27f3dd=
2c32a079/subprojects/simlib/test/directory.cc
) in my project=E2=80=99s test suite where I create a temporary directory,
populate it with files and then list its contents using the handle
obtained during creation of the directory. And it started to list the
directory empty, since this patch was introduced.

While listing the temporary dir one is using is unlikely in this case,
we will see if any issue in other software will emerge after the 6.11
will be released as LTS kernel.

Thanks,
Krzysztof


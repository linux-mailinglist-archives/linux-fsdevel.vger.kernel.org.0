Return-Path: <linux-fsdevel+bounces-29084-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CCE5B974F05
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Sep 2024 11:48:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A6DA8B24C14
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Sep 2024 09:47:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC26D16EB54;
	Wed, 11 Sep 2024 09:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="co4m6GjQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E857614D2A6
	for <linux-fsdevel@vger.kernel.org>; Wed, 11 Sep 2024 09:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726048071; cv=none; b=OOv9lgcSoo/HdGpokScElBUO/mzk+ubRNzWlJfbveNJTykM3sjhcEj7jqWr6jfAJkB9qgytGxjPQCN3cMfEw2poHAD5XY3VktBSLwpYIm/HG+oYsJ1hjo0xN+RpU3uHRB0dmmr7z2eepLV7ZT07YUTPxIgFcDOmBTbe+T+VfIXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726048071; c=relaxed/simple;
	bh=RGOnbCA7TGIm3Y0iHhNibOMhvZRhRjIpcsbWRpXZrEw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JPgLzYaeJF4LvT/gBLmoxBAvAcSkLQDrzFTbs3rvSyqF4+5pHL4l3CtWcA0LLVxkDuQzyOtMJCdddR6IZQitSuR1fka8phBbgnp0PJpEELxYYgsMj3jc2VcXZOZn/v3AWuyhg3d+yicoLiiVadk5Ej7jo6ZLt+auhYiNbwpqezU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=co4m6GjQ; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-7db0fb03df5so386318a12.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 11 Sep 2024 02:47:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726048069; x=1726652869; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UrfMuV8rHJLED3gdYiI0/AM18djPib2R7h5eJVn2UGM=;
        b=co4m6GjQjp0l3UF0xLBW8QGhaKyD6fLj9T4JW/kvCpw6v/CbVRlDkctSGnTHZ4o8eg
         HHJ6+OWncaAeaof8hPJkJbnv6+FJHPPmxCJB1zW68k46HLGpCXHE7u3ehsTjPrtNUbdt
         4UHTzOWB4bHt/2P6/Ui56GfpfsUqoR8D67cVDBt9v10LYh1bbWE9C5tZluaBR6SMzUq+
         PlVEPeG2nQorClmQfI/scEYLDb9S9TV+fH1/8g/ozolDwDRD1nGzGoPIZO7c3IMkhjhO
         zNzsa5upW2Vw2bpjh9A+tGABib7J4k9Y6sVTGG5/+w8u+InNq0V38gTvHgXmvjcB5xwH
         vuuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726048069; x=1726652869;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UrfMuV8rHJLED3gdYiI0/AM18djPib2R7h5eJVn2UGM=;
        b=tRYRxPpA7MmT48rvfwSLtHd9WXCiN3Fhj0zmPoKPcnaRYg7KEiS1vEJSJ8xj/THnr+
         ZGEVaY7jS69FVl19FsbFyc8H7eeh0KE83NEL68ZsNEuhSetY2yRJZCGHhREfcHQ0awJW
         RsINZBKhW19AudEqcMmqEI18OntCFfGBG0i/GIp3b7Bh/Vvjr7w+Lc9Iv1djlk8lsOVH
         fRqNb1tBr4a9+f2cO8w+i3TZSYWy3eeGnvNVPept7Vnu4g9aPLq8kkedaRAu+alGLUcE
         ajM6QFtl8U/wjcYb8xnSEc4P6PmMmyGjC9H7Nqiy/Qbp6ROjdZ5sb0Y77GdvbDaDGEVB
         Nx+A==
X-Forwarded-Encrypted: i=1; AJvYcCU6Kzpcp++dZHHcM2PKtolhEyevcU3QTJAniAqkfqYg9cPd12SgH//jmcQ+dzAdG2hgZ1T/mil1Op4pkutj@vger.kernel.org
X-Gm-Message-State: AOJu0YzI96ElEdSeDV0tA5oPax7/fbR5ZQWykfWFewhMYKNyyX/1+Pue
	KgSJi5O/73iE0bxvuU+9m+mr3tvuKw0hACTws8sFuRvggrVMyaLwK7aMuBz1zhQHjOJyiwloC80
	lvmzrU5LlWAxx+KH9ldv70HbdDVY=
X-Google-Smtp-Source: AGHT+IFpQ5B8rzoLTZp8cUiE2CrwiL8b4mnvTOVaADyyU5dQfZt+MaPkeZ+BhA+CbDWC8O56uJHnJcdJLEol1xUw3OA=
X-Received: by 2002:a17:90b:164e:b0:2d8:97b7:449f with SMTP id
 98e67ed59e1d1-2dad50f9a10mr20979858a91.38.1726048068779; Wed, 11 Sep 2024
 02:47:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAOw_e7bqrAkZtUcY=Q6ZSeh_bKo+jyQ=oNfuzKCJpRT=5s-Yqg@mail.gmail.com>
 <5012b62c-79f3-4ec4-af19-ace3f9b340e7@fastmail.fm> <CAOw_e7Yd7shq3oup-s3PVVQMyHE7rqFF8JNftnCU5Fyp8S5pYQ@mail.gmail.com>
 <CAJnrk1YxUqmV4uMJbokrsOajhtwuuXHRpB1T9r4DY-zoU7JZmQ@mail.gmail.com>
In-Reply-To: <CAJnrk1YxUqmV4uMJbokrsOajhtwuuXHRpB1T9r4DY-zoU7JZmQ@mail.gmail.com>
From: Han-Wen Nienhuys <hanwenn@gmail.com>
Date: Wed, 11 Sep 2024 11:47:37 +0200
Message-ID: <CAOw_e7YSyq8C+_Qu_dkxS2k4qEECcySGdmAtqPcyTXBtaeiQ7w@mail.gmail.com>
Subject: Re: Interrupt on readdirplus?
To: Joanne Koong <joannelkoong@gmail.com>
Cc: Bernd Schubert <bernd.schubert@fastmail.fm>, linux-fsdevel@vger.kernel.org, 
	Miklos Szeredi <miklos@szeredi.hu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 11, 2024 at 12:04=E2=80=AFAM Joanne Koong <joannelkoong@gmail.c=
om> wrote:
> > A bit of browsing through the Go source code suggests that SIGURG is
> > used to preempt long-running goroutines, so it could be issued more or
> > less at random.
> >
> > Nevertheless, FUSE should also not be reissuing the reads, even if
> > there were interrupts, right?
>
> Is there a link to the test? Is it easy to repro this issue?

I made an easy repro available over here:

  https://review.gerrithub.io/c/hanwen/go-fuse/+/1200990

To repro,

  git init
  git fetch https://review.gerrithub.io/hanwen/go-fuse
refs/changes/90/1200990/1 && git checkout FETCH_HEAD
  go test ./fs -run TestInterruptReaddirplus -count 2000

to get debug logs, add -v to the test command. Typical output:

$ go test ./fs -run TestInterruptReaddirplus -count 2000
11:42:29.186131 writer: Write/Writev failed, err: 2=3Dno such file or
directory. opcode: RELEASEDIR
11:42:30.160136 doInterrupt
11:42:30.160559 observed seek
--- FAIL: TestInterruptReaddirplus (0.01s)
    mem_test.go:301: read back 76 entries, want 100

I am using

$ uname -a
Linux fedora 6.10.7-200.fc40.x86_64 #1 SMP PREEMPT_DYNAMIC Fri Aug 30
00:08:59 UTC 2024 x86_64 GNU/Linux
$ go version
go version go1.22.6 linux/amd64


> If I'm understanding your post correctly, the issue you are seeing is
> that if your go-fuse server returns 25 entries to an interrupted
> READDIRPLUS request, the kernel's next READDIRPLUS request is at
> offset 1 instead of at offset 25?

yes. If the offset is ignored (mustSeek =3D false in fs/bridge.go), it
causes test failures, because of a short read on the readdir result
there are too few entries.

If I don't ignore the offset, I have to implement a workaround on my
side which is expensive and clumsy (which is what the `mustSeek`
variable controls.)

--=20
Han-Wen Nienhuys - hanwenn@gmail.com - http://www.xs4all.nl/~hanwen


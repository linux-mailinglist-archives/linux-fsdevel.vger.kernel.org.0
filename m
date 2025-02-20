Return-Path: <linux-fsdevel+bounces-42177-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4655FA3DF6E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Feb 2025 16:54:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B34ED700E6E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Feb 2025 15:53:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 346521FF1DB;
	Thu, 20 Feb 2025 15:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EgCv3/Ln"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC072211A11
	for <linux-fsdevel@vger.kernel.org>; Thu, 20 Feb 2025 15:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740066721; cv=none; b=TreRSyMcAL3293f2T+NIw5Okwi15XI5nIeX/mYwKKviVYK84BaX4YFO4gxENNKbEe/YJkH5nXQHbmHcCthBGn2V4BYLOLHwc14b2oKSxZk1OrRvYV9ZO03xUtaZc6X4Zn64YdAuCw+qjVc28xQiTA1U9sv3qEJnXpIYuivsyI6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740066721; c=relaxed/simple;
	bh=vVcWTFgk/MxrB0Kna5nUyFFVqbF4DanqdoIJKr2cH+w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KgZopzbjdW+CqTbdWa9I2kB+sT6ePrtV4BPtA/8lkrRD0SZ7vg9HNV7EpVW3PDTfI+qcvxKrd33YYG6POk7kcFGhK3It02W51AdggVvaA7fsS7lRn4ThUB3o1TnNXDVzW/AU7H4e6cBqv81xH5jMforNlwOWf3meJ3abRliZOxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EgCv3/Ln; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5ded368fcd9so1636859a12.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 20 Feb 2025 07:51:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740066718; x=1740671518; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=djuiV5cQnbTKxCOXHMNaBC8XsJufm1H5ZXumurEB+gs=;
        b=EgCv3/LnAHEJGDuLFZs+xy49vL79JfbGd83F8P/h5YhxzXDSUrbxS7F8SzFD0yA0Yd
         LTfiXVuzahaS51vJeQ8HKFb3puUAKzWcMHMIURyoNXPIor+6908xjhEBNuW/VcCPzYJ3
         PjmW2miTBvzE+7qlvDSS06bzH8ookkLZcQBqsdyxuW9pQX79lEIkh09iqahQUlzBaMZI
         EAG9D0du9OfsjV5+BsxEs8yEQ2JptH3YVq//LFUDrzzyWOnvPE6H9ztvls8vfMdyI8LC
         5sJFxfMknc4TS1JO6F2jSyNHojENSTir4FrMePlFW4TnavJyM2Wiw1dcmhSnc2o3QYU3
         emUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740066718; x=1740671518;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=djuiV5cQnbTKxCOXHMNaBC8XsJufm1H5ZXumurEB+gs=;
        b=YM057au7NZ0ljr8X2lPjLbyeKf6ShLRdvfxdpATx9J2NQ0++sItgrq5n6uMG+suD7H
         EjPLkrakY+mtExVru/E8DnKH4S+M0GaETEkIh1YK09InrADvvZkZehFWLkKDUVGvbnnf
         /+RKF5FZmj6ngqdyU162V3A1X0mztj3K5ehqf8/ZAoSy89/t7JtVMJc7/0oB6aa5SgtY
         2WNAGcZxiMwjFOdZf2InfM/oK0c4OhMp/xWnjVBn5148ijszRiJmkijdQuRXPQzoYsQI
         k/Xez5AXlzTWzNliIbNRkEr/C3v9KQLmAITYCEI9F9q4iBzcpSC+dznPxYrhhuILcdYq
         2nkA==
X-Forwarded-Encrypted: i=1; AJvYcCWTKcvlHffkxrCwphrSRycDS3I7skAYLJ55NBbhxBOyfhjA/kPUJgpxXKjgw5k2JIWOrUSDyP2PthugVjGb@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/ePjg8lM1Xre/d6GqRyqKQRApWxqJvu7ubNqDVTZ/RVVYy3rY
	z8x1R33oNMM5k1oQ/lfpWWcWX18b365NnFiocgAle85+boSyyJ7nvRxtgIYBukc32sQAG5R6Kee
	jNnpuI7sL+hzv/2IrB3UFBln3xD8=
X-Gm-Gg: ASbGncuRC+HCfcCmAoVB4fhQ8YhSwgD99iO8save6g5m7PLX5ckR46JXUZX0IXiz9HT
	2g/y8w+lqJszimYK4IFJgle/r90q4z0G4NhfgthlNWey7ZhLnRu8QRuvFo4Rr98yJrQ3S0df3
X-Google-Smtp-Source: AGHT+IEDNgGyzCSy932snnwxe0AvbWrS6WGiPASPWtmn/3znARTpGfik8IwGSb22mA0b56zBvS34dQylIcOUiXmpmWQ=
X-Received: by 2002:a05:6402:40cf:b0:5df:73:6c92 with SMTP id
 4fb4d7f45d1cf-5e089d33dddmr6539719a12.21.1740066717702; Thu, 20 Feb 2025
 07:51:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <a8828676-210a-99e8-30d7-6076f334ed71@virtuozzo.com>
 <CAOQ4uxgZ08ePA5WFOYFoLZaq_-Kjr-haNzBN5Aj3MfF=f9pjdg@mail.gmail.com>
 <1bb71cbf-0a10-34c7-409d-914058e102f6@virtuozzo.com> <CAOQ4uxieqnKENV_kJYwfcnPjNdVuqH3BnKVx_zLz=N_PdAguNg@mail.gmail.com>
 <dc696835-bbb5-ed4e-8708-bc828d415a2b@virtuozzo.com> <CAOQ4uxg0XVEEzc+HyyC63WWZuA2AsRjJmbZBuNimtj=t+quVyg@mail.gmail.com>
 <20200922210445.GG57620@redhat.com> <CAOQ4uxg_FV8U833qVkgPaAWJ4MNcnGoy9Gci41bmak4_ROSc3g@mail.gmail.com>
 <CAJfpegvNZ6Z7uhuTdQ6quBaTOYNkAP8W_4yUY4L2JRAEKxEwOQ@mail.gmail.com>
 <CAOQ4uxiJ3qxb_XNWdmQPZ3omT3fjEhoMfG=3CSKucvoJbj6JSg@mail.gmail.com>
 <CAOQ4uxi2w+S4yy3yiBvGpJYSqC6GOTAZQzzjygaH3TjH7Uc4+Q@mail.gmail.com> <CAJfpegv3ndPNZOLP2rPrVSMiomOiSJBjsBFwwrCcmfZT08PjpQ@mail.gmail.com>
In-Reply-To: <CAJfpegv3ndPNZOLP2rPrVSMiomOiSJBjsBFwwrCcmfZT08PjpQ@mail.gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 20 Feb 2025 16:51:45 +0100
X-Gm-Features: AWEUYZlr-AtbM83yXgM_DrKGARZGQBLKVdteGkHUJT6dPGma-Fa-b8iea62pm4o
Message-ID: <CAOQ4uxj3=iSUSJfnfkMJVfAeOXAZMRb=k6VSJEWH5uv9Z3Gu8A@mail.gmail.com>
Subject: Re: LOOKUP_HANDLE and FUSE passthrough (was: Persistent FUSE file handles)
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Vivek Goyal <vgoyal@redhat.com>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, 
	Hanna Reitz <hreitz@redhat.com>, Bernd Schubert <bernd.schubert@fastmail.fm>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 20, 2025 at 11:26=E2=80=AFAM Miklos Szeredi <miklos@szeredi.hu>=
 wrote:
>
> On Wed, 19 Feb 2025 at 18:58, Amir Goldstein <amir73il@gmail.com> wrote:
>
> > I circled back to this. I don't suppose you know of any patches
> > in the works?
>
> I'm not aware of any.
>
>
> > I was thinking about LOOKUP_HANDLE in the context of our
> > discussion at Plumbers on readdirplus passthrough.
> >
> > What we discussed is that kernel could instantiate some FUSE inodes
> > (populated during readdirplus passthrough) and at some later time,
> > kernel will notify server about those inodes via FUSE_INSTANTIATE
> > or similar command, which will instantiate a fuse server inode with
> > pre-defined nodeid.
> >
> > My thinking was to simplify a bit and require a 1-to-1 mapping
> > of kernel-server inode numbers to enable the feature of
> > FUSE_PASSTHOUGH_INODE (operations), meaning that
> > every FUSE inode has at least a potential backing inode which
> > reserves its inode number.
> >
> > But I think that 1-to-1 mapping of ino is not enough and to avoid
> > races it is better to have 1-to-1 mapping of file handles so
> > FUSE_INSTANTIATE would look a bit like LOOKUP_HANDLE
> > but "found" server inode must match the kernel's file handle.
> >
> > Is any of this making any sense to you?
>
> Not yet.  I remember you explaining why FUSE_INSTANTIATE is needed,
> but I don't really remember.
>
> Can you please remind me how exactly you envision readdir/lookup passthro=
ugh?
>

- readdirplus passthrough iterates on backing dir inode and populates
  fuse inodes with nodeid that is taken from backing dir's children ino
  (hence 1-to-1 mapping from all backing inodes to fuse ino/nodeid)
- stat()/getattr() on those children is served directly from backing inodes
- Let's call one those kernel instantiated child inodes C1
- Before any fuse command is sent to server with nodeid C1, server needs
  to be notified about the entry that only the kernel knows about
- kernel could send a regular LOOKUP for the child and expect to get
  a nodeid from the server that is matching C1 or mark the inode bad

Open questions:
1. Is a regular LOOKUP appropriate here or if this needs to be a new
    INSTANTIATE command which tells the server about the C1 nodeid.
2. Does this need to be a LOOKUP_HANDLE command to verify that
    not only the server's child has the same ino as the kernel's child but
    also that they have the same file handle.
3. What is the proper API for binding a backing id to a fuse inode
   regardless of readdirplus?
   Extend the regular LOOKUP out args?
   Require LOOKUP_HANDLE and use its out args?
4. When a child fuse inode is instantiated via readdirplus passthrough
    it automatically passthrough getattr(). What about other inode ops?
    are they decided only after the response of LOOKUP/INSTANTIATE?
5. Does this response need to reaffirm the binding to the backing inode
    and if not, association is broken and getattr passthrough is stopped?

I have a WIP branch [1] with some of the concepts implemented.
only compile tested!

Thanks,
Amir.

[1] https://github.com/amir73il/linux/commits/fuse-backing-inode-wip/


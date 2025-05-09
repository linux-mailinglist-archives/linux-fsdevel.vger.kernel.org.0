Return-Path: <linux-fsdevel+bounces-48624-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E6278AB183D
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 May 2025 17:19:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 762111897908
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 May 2025 15:19:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 136F12248B5;
	Fri,  9 May 2025 15:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iAszUKSI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7DC8C2D1;
	Fri,  9 May 2025 15:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746803972; cv=none; b=KOsidkQangYasuMnwSHK8KQKKQvKmz0e6uyFQZDDkz9XI0T+VkfbzEB/svB97qHzYtoQr1LThasf5KyJBtGzhciPqpmsCnsZqqQ63VX9JRRMT835Oh4iJyc+/yXq29mVKkUla6Xs+8YHTLxYWtcfLjwqIMTbDTpuonj7lMgRcnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746803972; c=relaxed/simple;
	bh=RFnLY5o3Kp96kdEDzDI/EpZsaBQONOVebHMuIlTxj+I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZsTgHKoXdvFQ6dLgIIm9e0gEVpfBTQwKcH3Ic+HlLxmq+W843CcGe63cUbfN95bM9hNzIZvbcajlr3IYSmsH4JKsh0RcCRZlC7GWS+T8S3IHCB92hEfkTbeiezoz8wwCbAHb2EMs5deltppG6gdTu1x9Zk7DARmo1zWIZ3nm1zg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iAszUKSI; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5fc7edf00b2so2859929a12.2;
        Fri, 09 May 2025 08:19:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746803969; x=1747408769; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M0Zi/+vV1wMuDTyG4BCXclfIkCzcoCV4THJvOJpBF8E=;
        b=iAszUKSIyPOb0R1jOOlcmPHynaCSJDLRCMlgqKYP1U9GZCHbQ2kEbZgb8FFRTFLSE3
         Z2rkxtXmw4x6T/TcN0nrDYzIYhbDhfCKDn+K9sA3yaLBH3gvxlOUAWmV/9oP6FfdKEMv
         endQLGxs7+2uy4nkMgWi1w1lyOkRwILBUkB+OBQYbG3clhTb4NGxJJunP3WjnQnXpdhg
         UsL1omuth/+Sqbwj/UPL8bJ0TQjdWXVVtcjx8vtWdo7DorvzlQB6FXsPe+8BsXUnTk14
         /PNa4OCxI1NcOPWIqT3XQLxhOEb52S/yYhTjukhe1C7yd+v4rwuERk6+zqwT2uWHhNO9
         POjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746803969; x=1747408769;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M0Zi/+vV1wMuDTyG4BCXclfIkCzcoCV4THJvOJpBF8E=;
        b=ZrIVCDIiv8fRPOJwDvDFOkthvz3Kups2tfmgfHtrAsrkDC52eJdk2cWC+c7JRJOLYx
         I0QBrvEsb8eBiurwbNjAguMXWSBCcsJCbucYl5R9l0sWejhhGDncHx7OWjUo8jSk8W4j
         jjbl/wuGi4NN10VYR84HFwWz/tjXGZ1wtnT7/TjdRiCnNQEs3y1lY8+S0lq9zKDbtz75
         TGRsM/SxbnuPCTmUXTMaZXe2HhbmdFUyXlX/l9KDdlytwqm1lar3g7oWCx/CA0pptGxT
         6U1q8BnbIaaJYbt5L8e8NSOa/fOFDsmXl7hOQdsjZ23CVJtWQq8dcfM1aUTPeQ+Nbm5N
         XbSQ==
X-Forwarded-Encrypted: i=1; AJvYcCVGznXH+JVmIucolZ6AShU116NYlPz/fjCRryrxEIZP7Zk2svu8iwGKYbQQRMb4gYF3H+P8lllDeIr3ND4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyA6bA4val+UM6Pn2j+zwYjCE14o6D5XuhQe4t9pSYHo9AtKfIH
	0yblYTEwLwYQU2s7MMotyj7/yp1wdvjxbGox9VwRrojdS+xEjC4PaXANw6BqRVGpqBdjySLlIbS
	DihhZrmxnawaNf7h8ifFFxYSDCfE=
X-Gm-Gg: ASbGnctCkp91jpZdYBYi5VauGvQ4KmQv4H8rGCEfLTswyxEbk5NtWBMAZyV1v7JKeyW
	J7MCpYiW2Xdxbde1vk2QrKuJEZSH3kogS8vw5Bv1N8lz5tfO5q+SzmE/VLXiCd+hDgFCY86cHmP
	oUVxuDZAfeE/tXBbVl8Qa/Aw==
X-Google-Smtp-Source: AGHT+IHZSSkH84PjO5HgQoJm9O7aZdqSsHlhlwPjQnt8/bslUIkw3GD6xGnt6Qr2PzA1HlkJX57v4f7URdE4CtQFrzE=
X-Received: by 2002:a17:907:9717:b0:ad2:db4:2a8f with SMTP id
 a640c23a62f3a-ad21929333fmr386115866b.48.1746803968643; Fri, 09 May 2025
 08:19:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250509-fusectl-backing-files-v3-0-393761f9b683@uniontech.com>
 <20250509-fusectl-backing-files-v3-2-393761f9b683@uniontech.com>
 <CAJfpegvhZ8Pts5EJDU0efcdHRZk39mcHxmVCNGvKXTZBG63k6g@mail.gmail.com> <CAC1kPDPeQbvnZnsqeYc5igT3cX=CjLGFCda1VJE2DYPaTULMFg@mail.gmail.com>
In-Reply-To: <CAC1kPDPeQbvnZnsqeYc5igT3cX=CjLGFCda1VJE2DYPaTULMFg@mail.gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Fri, 9 May 2025 17:19:16 +0200
X-Gm-Features: AX0GCFu4jDKmxCTU4hjV7VzI1bqnuvu1nFiX0PCkZj2hZFB7GNh9Mcb8yx5Ku7g
Message-ID: <CAOQ4uxiBLc9G+CvU-m5XMPbkFJLeCt6R86r8WaGEE2N3k9_qrw@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] fs: fuse: add backing_files control file
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Chen Linxuan <chenlinxuan@uniontech.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 9, 2025 at 4:43=E2=80=AFPM Chen Linxuan <chenlinxuan@uniontech.=
com> wrote:
>
> On Fri, May 9, 2025 at 10:00=E2=80=AFPM Miklos Szeredi <miklos@szeredi.hu=
> wrote:
> >
> > On Fri, 9 May 2025 at 08:34, Chen Linxuan via B4 Relay
> > <devnull+chenlinxuan.uniontech.com@kernel.org> wrote:
> > >
> > > From: Chen Linxuan <chenlinxuan@uniontech.com>
> > >
> > > Add a new FUSE control file "/sys/fs/fuse/connections/*/backing_files=
"
> > > that exposes the paths of all backing files currently being used in
> > > FUSE mount points. This is particularly valuable for tracking and
> > > debugging files used in FUSE passthrough mode.
> >
> > This is good work, thanks.
> >
> > My concern is that this is a very fuse specific interface, even though
> > the problem is more generic: list hidden open files belonging to a
> > kernel object, but not installed in any fd:
> >
> >  - SCM_RIGHTS
> >  - io_uring
>
> Note that io_uring has already exposed information about fixed files
> in its fdinfo.
>
> >  - fuse
> >
> > So we could have a new syscall or set of syscalls for this purpose.
> > But that again goes against my "this is not generic enough" pet peeve.
> >
> > So we had this idea of reusing getxattr and listxattr (or implementing
> > a new set of syscalls with the same signature) to allow retrieving a
> > hierarchical set of attributes belonging to a kernel object.  This one
> > would also fit that pattern, so...
> >
> > Thoughts?

I remember that there was some push back on this idea.
If there was no push back, you probably wouldn't have written
listmount/statmount...
so I am a bit concerned about sending Chen down this rabbit hole.

I think that for lsof, any way we present the information in fdinfo
that is parsable would be good enough for lsof to follow.

We could also list a full copy of backing_files table in fdinfo
of all the /dev/fuse open files, that will give lsof the pid of fuse server
in high likelihood.

But this is not very scalable with a large number of backing_files. hmm.

Is it a bad idea to merge the connections/N/backing_files code anyway
at least for debugging?

The extra fdinfo in patch 3 is just useful.
I don't see why we should not add it regardless of the standard  way
to iterate all backing_files.

Thanks,
Amir.


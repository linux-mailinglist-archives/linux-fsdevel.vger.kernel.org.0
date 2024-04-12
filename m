Return-Path: <linux-fsdevel+bounces-16792-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C507F8A2BF5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Apr 2024 12:08:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 02A661C21422
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Apr 2024 10:08:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30615535B8;
	Fri, 12 Apr 2024 10:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TdssuU5Y"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B88D53378
	for <linux-fsdevel@vger.kernel.org>; Fri, 12 Apr 2024 10:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712916505; cv=none; b=GgCOUM0HR27BSdoKGLT9fNje5h2EvetJzZl8RXpd6GFy8mS1XImQND/Z5pKiWFUD7AqMv8xsemJz90h0BsIshoYpmAh/6Xur9iZAf+v81jPd+0WyvD3+Xl+V7jwlUClJeg5ToJ2odP2gVDMyqtrpcTAgJL+wwJ2+jJgt71cKtS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712916505; c=relaxed/simple;
	bh=68Tp8LpjrT0kob7Vn/qMOBtuI5Nj4DicRVopvpRxJDs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jyWEhkXvjnSZmnk2wG18RYj6Q9G7WsUl8FeaV5LzD/T9Nn3kJSFW2qi+6IrVRUGEVREjS723f1PWT7EOKMvhIxwGiW53dHYHY639lI1Mtz1iYpYkrEIlytHPUDsi37/wH266uMm1nndBWZAp1zl0GMF/lpEE6FnZta1FKpx05IE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TdssuU5Y; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-dd14d8e7026so696447276.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 12 Apr 2024 03:08:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712916503; x=1713521303; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6I+wbZmRRTRrfH1NeQX1GfDmoAmanjK9hp/fnvWRCqo=;
        b=TdssuU5YVchXNOAmPqtd5l7PGhyDvQlMEJFgyjjZTbOCsQ91gHKeXH2jQzkJXRLt9z
         ukO249wF6Xzx6XCZpENoyT5PNK03vUGrgaRJCDiiEfifrDohxBxIUCG7DJXP2eYHgTm8
         FBEyfWz9pzRrB3HxQPhyFr9Vre8sDITJCTPUmWX5XR7L4t0ybYcIChGIWCD4PLssrILB
         bpcFSk9bHeO1f9j8TP/VO9SAjkuHp8eTS2X6QQEsUJd8QeZ9uKVVXT3enk+nnKolD6wN
         RGfOm5xHKORuozMCXEhob+kIS+Ys4mR7xUpNQWP/brT12p7iXDidi1Wi+CghyT8g437A
         SRDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712916503; x=1713521303;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6I+wbZmRRTRrfH1NeQX1GfDmoAmanjK9hp/fnvWRCqo=;
        b=HpaQJ252kODy5kyXrQcxMthJATSiqznnWk+LZhOGHwSOgbUdpNdS1GPnRXS7mOsOct
         0yt8GiNFpyv+sPUEVPVn2PH4l/CPVw6/X4Zd6OMuTZwtfvYxuRAYK6uUf+gVj1N/RXt7
         uznet0Wi04dUcF7KO7yzs3LIjS4B8TNJGgtLB7ClqJLLzu5vLVBHplVirxbpTx970mcM
         /O3xN1+WMBAMZrcF/niqWYf4tZTtid3OUnT2tQ299AIek0IQmWYjG3ABEKgVu1/b5ICu
         IUezqzo77mTpMP3J5lBvyEfRtmWYpjVAjQlFf5R0Uv1B8JNXdSTs7CF7AgyOe6PaAj4P
         ZtIQ==
X-Forwarded-Encrypted: i=1; AJvYcCXGK/3n1bCkAMztt2gFZSHSmIwrlheIHqV8so+Io0/LdTrOHcAG2AiihATkPrrERM1vyHKLiB95vRUnTKXJXrfbeOkkr7tf/BJrAURoRA==
X-Gm-Message-State: AOJu0YzDLeW36nxfPFMi4Yprl6SHIpzPMhU12BYewhkD6YfihHQslxB6
	7bFP2UITLW5FECvxjqE11vzI4TSsSLTBEYpF9POlE/QyicB+T7lrSN6zMA/lb5aQvUiJ+utkPIm
	sGc/2B3PYLnCeP4tD++8LWr7y65c=
X-Google-Smtp-Source: AGHT+IFPAtQHUtStr49FrLgeSPbC8lPN3abnL1Wj+alk6SST8MvTUkL08Aucf6kbql+kKPahiwfb8ozyc+8hoaOKJY4=
X-Received: by 2002:a25:a447:0:b0:de0:f72e:441d with SMTP id
 f65-20020a25a447000000b00de0f72e441dmr1939671ybi.53.1712916503297; Fri, 12
 Apr 2024 03:08:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <67785da6-b8fb-44ae-be05-97a4e4dd14a2@spawn.link>
 <CAOQ4uxjOYcNxNf2S0yFxBgV9zPMhOQOxY72v5ToCxCPJ2S0e+g@mail.gmail.com>
 <03958bec-d387-494a-bd6a-fcd3b7842c6d@spawn.link> <CAOQ4uxjNF4Kdae5uos4Ch9qBvmAC2kSH58+wVr=F865XhVZsNQ@mail.gmail.com>
 <a54405ff-d552-420c-88e9-941007c7f0cb@spawn.link> <CAOQ4uxhnSDshQmjn-39Q9TbMJLZiWiYXf+8YLVqB7nPW1L5fBw@mail.gmail.com>
 <G2XhehibMSoDHBWhAJVS3UfIT1-OlMgYkwAgTu5v2ys1BIUCznJ1B475OEKLBFf6M9gnlpXqFIkrsWRmofllLba2b7cRogWLODZQ5Ma748w=@spawn.link>
 <CAOQ4uxiR7BHP4+PNx0EBo8Pg4S9po7sDP50ZMVq1aN3zpk=z0Q@mail.gmail.com> <CAJfpegukxxb7SOYW_9T5zto9nUgzRgaxVFDzEi_qz1z9A0zkMg@mail.gmail.com>
In-Reply-To: <CAJfpegukxxb7SOYW_9T5zto9nUgzRgaxVFDzEi_qz1z9A0zkMg@mail.gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Fri, 12 Apr 2024 13:08:11 +0300
Message-ID: <CAOQ4uxiw+VNJmthwjQx5-NEZ6yaZbeO4HOiuzOaG33DE=YBm7A@mail.gmail.com>
Subject: Re: passthrough question
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Antonio SJ Musumeci <trapexit@spawn.link>, Bernd Schubert <bernd.schubert@fastmail.fm>, 
	Sweet Tea Dorminy <sweettea-kernel@dorminy.me>, linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 12, 2024 at 11:17=E2=80=AFAM Miklos Szeredi <miklos@szeredi.hu>=
 wrote:
>
> On Fri, 12 Apr 2024 at 09:12, Amir Goldstein <amir73il@gmail.com> wrote:
>
> > Not fh value per-se but a backing id, allocated and attached to fuse in=
ode
> > on LOOKUP reply, which sticks with this inode until evict/forget.
> > OPEN replies on this sort of inode would have to either explicitly stat=
e
> > FOPEN_PASSTHROUGH or we can allow the kernel to imply passthrough
> > mode open in this case. Not sure.
>
> Hmm, maybe allowing a zero  backing_id to mean "use current backing
> inode" would be sane.  And if there's no current backing for the
> inode, and a zero backing ID is given then it would just return
> -ENOENT or something.
>
> I wouldn't change anything else, so FOPEN_PASSTHROUGH would still need
> to be given and all the other states would work.  The only difference
> would be that LOOKUP would allow setting up a backing path (need to
> think about naming, because all these backing somethings are a bit
> confusing).
>
> Thoughts?

Sounds good, except returning ENOENT to user for open with zero backing id
is confusing, so I think it has to be EIO like all the other illegal
passthrough open replies.

Thanks,
Amir.


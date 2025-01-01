Return-Path: <linux-fsdevel+bounces-38313-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B50C9FF3EB
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Jan 2025 12:55:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E7E5E1606F8
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Jan 2025 11:55:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BE1914F9C4;
	Wed,  1 Jan 2025 11:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CLfsT8RL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C80F68827
	for <linux-fsdevel@vger.kernel.org>; Wed,  1 Jan 2025 11:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735732530; cv=none; b=LzL986WAZPXTivZbOjKgHi9FMT0krm5cZEtFiPXsEafMGcUqyrENZUeJQdklKwrJHJhSOm3YrpFLkZ6HfMEUAmdPiT3j07A6i4Nha9fHrF3a30tijtX/IgUihgry5/WmXMrGz5jat6m1x+QcqJo7L8woUW/hknUoeAwhqDmgISg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735732530; c=relaxed/simple;
	bh=QaqNjsfBLiaC/T28Ram6Vi1YZu00//9GAIkCmChoQbc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N/IInn6lJsewYmd1pwiR7w+3qt2lZFkion1g+cicpd9cn4mWQZV0F8TTy1eONryoBFBmYvz4jhLwArVCLPnJTuXRRX+iil8YYDHw4Jk9LKyzmXfwpeQ46eC9uULGnxPAtaEN0spa3FpK6+aJHF40t5720wMZLo9bHpu4dJWdu1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CLfsT8RL; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5d7e3f1fdafso21580095a12.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 01 Jan 2025 03:55:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735732527; x=1736337327; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QaqNjsfBLiaC/T28Ram6Vi1YZu00//9GAIkCmChoQbc=;
        b=CLfsT8RLf8a1kOHeWzQqkTH8Orf/7q5tMwZ7WcV+GrHtda+U2x62iKHPXlD9QG56Q9
         5sWFY5Hg0iVLM8ApJoEEbOVLf9do3FiRIlNwGIz7K/PxfDQwTlcOBqe0yILkht3QYh2t
         bdwRBZuPp0wpd6CZ4mTvNQW1G+IZvhg7Kro4It4J1DUQUVmaVp8yzqs4+f5z4rT9SBlQ
         R+5lTj9GJc6xWFW16f5x9aog8mIRNSyEN9p5VaaYTiMKIHAk7jOGMqSjpmeozvG0lUJj
         I3WWCx8Wkaed6edEk8jZjRMcwiIuIK5lESXNbSqjCzckslJ79y4j/od2ZrG8RXq7GSD2
         TVLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735732527; x=1736337327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QaqNjsfBLiaC/T28Ram6Vi1YZu00//9GAIkCmChoQbc=;
        b=aHWnE8x2Tt14HoSAEBZNNmeLZXoORWYGuB0Scd9Q52jjZ2ZXGj4iI80KeRv2QY8DSm
         p3X0ax8DELf/h4zkTomnMKRTNBllbfHY5d+CuazLGHJoKUDHyahsO51ov9P3JWUTwISf
         68QPpXFO18zdXmSuJMMKdpbD4Afk48iXIFp3YVSZgPyBgG8VjTAd4xVFexblZ3cLZH8y
         R+YJxhqsMVN/eKDYqV/kNCikbyxfGlkSIGOliZ1MulM2T+ftCAvXFD1bJTLiOlyyhP2k
         7DiRqNPLI2bFGQtAJLGJTTzVNl4L7HNii2nSElAhiheti55JwfOz9a3yM01zFvGQdUgg
         9UNQ==
X-Forwarded-Encrypted: i=1; AJvYcCUCALae0yur9CbEAvRUivgkVhVnc1iuqC+ToQ0Q6n8h86weGYw34RDLEfMazC7DfX4iInaZwJsqUqzKJNBP@vger.kernel.org
X-Gm-Message-State: AOJu0Yw931Ah0gxpQeOM4+AnfIpzndW1ByoDt5Rx7oDVokAHs8+sQOeU
	YsQZrmI+sEMN6lfyvw1qEhX0kv/7Gldk2UB0g2vDDvqS054pCP6vwvgSkAHXenvsTskPlP41LIW
	dCpI6hJhA13PK4FAq1xEg3Jqp/kSjqAG1
X-Gm-Gg: ASbGncuP9BHV3GeUWMYX/5e0/FEPviw+ixVaAENRAN6fVL+zI2jxxUk5bNLqHfdgcO2
	MtTvvbGG1OoC4w47+m7/cqRjKZNTDpNhV8U7Hwg==
X-Google-Smtp-Source: AGHT+IFIKaP6dn4LN043WYGCsb1vEEJksL3IY0ycgbS7Q0TSKKNQLJdH0jLxA4FLPFd3kaE86L0/Sg1a59KgQKwO300=
X-Received: by 2002:a05:6402:4492:b0:5cf:d19c:e21c with SMTP id
 4fb4d7f45d1cf-5d81ddec945mr42199280a12.20.1735732526628; Wed, 01 Jan 2025
 03:55:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAEW=TRr7CYb4LtsvQPLj-zx5Y+EYBmGfM24SuzwyDoGVNoKm7w@mail.gmail.com>
 <3d7e9844-6f6e-493a-a93a-4d2407378395@bsbernd.com> <CAEW=TRriHeY3TG-tep29ZnkRjU8Nfr5SHmuUmoc0oWRRy8fq3A@mail.gmail.com>
 <CAOQ4uxhch3DUj3BtYBaZx6X3Jvpw4OqjcdnkXA_qQh2AQwAo1A@mail.gmail.com>
 <CAOQ4uxjM1pkA+w8XF_cJBC-q5n0_9G1g-JYm7dOt2uSRLX8m4w@mail.gmail.com> <CAEW=TRqohNhOH-xbfdNMxCNSwbyQZzzTdMW1TVTKc0BcDrk2_A@mail.gmail.com>
In-Reply-To: <CAEW=TRqohNhOH-xbfdNMxCNSwbyQZzzTdMW1TVTKc0BcDrk2_A@mail.gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Wed, 1 Jan 2025 12:55:15 +0100
Message-ID: <CAOQ4uxh9s7Ynj7GXRz_JgTEXT_QXhfneMskD9hhtJPNkCJEbRQ@mail.gmail.com>
Subject: Re: Fuse: directory cache eviction stopped working in the linux 6.9.X
 and onwards
To: Prince Kumar <princer@google.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, Bernd Schubert <bernd@bsbernd.com>, linux-fsdevel@vger.kernel.org, 
	Charith Chowdary <charithc@google.com>, Mayuresh Pise <mpise@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 1, 2025 at 11:58=E2=80=AFAM Prince Kumar <princer@google.com> w=
rote:
>
> Thanks a lot Amir, for making time for this despite the holiday season!!
>
> Great to know, we have a fix for this.
>
> Prince, if you can, please provide Tested-by.
> > I would love to validate the changes. Although I haven't built or valid=
ated the kernel changes before, so would require some help here.
>
> Could you please help with some basic questions?
> (a) Do we need to build the complete kernel code or just fuse drivers?

Just the fuse kernel module is enough (if your kernel is configured
with fuse module)

> (b) I see there is documentation to build the source code - but it's
> too vast. Could you please point to the specific section which I need
> to follow?

No sorry, it really depends on your distro.
Usually you'd need to follow distro specific instructions and compile
with distro custom kernel sources.

> (c) Can we build the kernel-source code and deploy it as a docker contain=
er?

No, I wouldn't know how and as far as I know, containers can't update
the kernel.

> (d) Please provide any other information which you feel important to
> test for newcomers like me.
>

It would be easier for me to test the fix myself, so if you don't know
how to test it, no worries.

Happy new year!
Amir.


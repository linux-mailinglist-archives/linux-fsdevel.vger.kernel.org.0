Return-Path: <linux-fsdevel+bounces-13072-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 876F186AD89
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Feb 2024 12:37:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 417D828EFAC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Feb 2024 11:37:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 831DE137C21;
	Wed, 28 Feb 2024 11:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nUJuaWOr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FC5213699F
	for <linux-fsdevel@vger.kernel.org>; Wed, 28 Feb 2024 11:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709119730; cv=none; b=U7tdPcneKMWBFfGnx5djkSNhUTb8Jgde9BXoolDwLt9Dba3FISsnU+4z7l4Ha3dMlhZd09VD7bxHA+0Pcsl4xKjQUqhXzGxgMgmA83duYqD13g4igd+fUBCG6P8eBokIyNwxcfCQJQTyAO5l6nba9/SWLo+9Fd7E7ISlzanhVk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709119730; c=relaxed/simple;
	bh=17LS05FsEPOKKmcq77qovsK2s+U7wevbqPjjHS4JS/E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SrU9ZUK1euq40854RHLWLE8LY9bQBuHncYS/9xmbHtXDUE+FO2qAZ2Cq9N25GeGS3hFhBwTUuIrcuQUcBpcRwW3a42UV5cYiuqJg4yY8p/OkFQwRogn1ursKdqTqxO4bv71ASCTPT1/3eVsCtQLS9Zjk2K6Zn/qYU4wTxUeU4is=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nUJuaWOr; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-608cf2e08f9so49241537b3.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 28 Feb 2024 03:28:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709119727; x=1709724527; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=17LS05FsEPOKKmcq77qovsK2s+U7wevbqPjjHS4JS/E=;
        b=nUJuaWOr/KxE/lGc+9kGGYFe7wCktw3cCD6i/Ced1QyLaZQJzGK7J9pUPj7fEvRaCc
         0ghZH7Kt2xk/Wbe9kMSwR0FvOQb2OUdAWv0VVdNS/w1mB1+Q5ehW9Unff4RBsUTo+D2i
         9KHhJr+rr+kPJOccBEVatS4D6QgznxC/O7ROd39saCVIK2KeEW6snH7WWCAqvvKJdS6e
         WRL92RrC6DKjfRi/cSsnav+uE1xY+jCXVvRqndCLFLD7EzFPpDt4D6Wx/+t0ew2hyQqN
         gLQ5VV+GIH3GMZai3Eovp9Q9wVDLQ6hoMZK/0SwJAeV8JAJToOs7XGxHTTpLQHJ7ACLO
         GnQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709119727; x=1709724527;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=17LS05FsEPOKKmcq77qovsK2s+U7wevbqPjjHS4JS/E=;
        b=IU8Ow6VJ965wAE/003gs8rPLxq55uDwdTfOxvOKSzn7zGLGgYi/11Rn8IIbofHioXn
         IHaZ69f7xx98+XwGnH/9sa5b1WQH6iKcHfqvCXMmbOzzf78SRLxyHt3M6kTixJNYgJNP
         gdDGx0Q9qTBFNsjKweiyHdP10u7JBDXs5ICirtPgA+EUJPgyKOGaKN9NyOCd7PP2BykS
         vf0pc0pQXHSI5EInLWQ/4o/0clfdgHMz0ybTN72JGIRU1xVS+Li9ja7upM2a15A5fPBf
         dE1jb4zOQvctVjiKbpa6LDWmH7C7ZeVrJDFb+TSm/+PI1vnV9nN4Ezgqhx0pThnhCA2B
         0teA==
X-Forwarded-Encrypted: i=1; AJvYcCXsnMl3M1VrDwkk3ep/CXM0/GFRbpUZGYOeDFpsWmYQPwJZdm47NXxidiDZDW6zRJ66/lEn0mRdsHJPCVfUWhaW5B8GogadJn7HIu4RCw==
X-Gm-Message-State: AOJu0Yw0T1dH2XjMqFbL4fcQUoeCVF47rTPHtursKfzBZIHOQRAOMQFX
	0VJWvI4awMn79B2FP6HLttLoXnIpf+oTDgtneRDN4aewVPg7BIy63cF7Tgf8pzBDd9U1WjtfsTJ
	q1cr5fgy5sybvB9gQ5cgAKPoS8m4=
X-Google-Smtp-Source: AGHT+IE/YCiRnPFxVP+LTkJXH83zETMjih3olj/Mjp3S9flaUJKerODFRGZUx+frduYi4G6h1Jv4ALxRD+Pc1StHU7g=
X-Received: by 2002:a81:ae24:0:b0:608:1b7a:4984 with SMTP id
 m36-20020a81ae24000000b006081b7a4984mr4903991ywh.17.1709119727553; Wed, 28
 Feb 2024 03:28:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240206142453.1906268-1-amir73il@gmail.com> <20240206142453.1906268-4-amir73il@gmail.com>
 <450d8b2d-c1d0-4d53-b998-74495e9eca3f@linux.alibaba.com> <CAOQ4uxhAY1m7ubJ3p-A3rSufw_53WuDRMT1Zqe_OC0bP_Fb3Zw@mail.gmail.com>
 <CAJfpegu3_sUtTC1uCD7kFehJWTivkN_OjcQGsSAMkzEdub=XTw@mail.gmail.com>
In-Reply-To: <CAJfpegu3_sUtTC1uCD7kFehJWTivkN_OjcQGsSAMkzEdub=XTw@mail.gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Wed, 28 Feb 2024 13:28:36 +0200
Message-ID: <CAOQ4uxji-yzWFeQYP9FKvVXg473GP6tC2pyHUbEPoYxT+qDYsA@mail.gmail.com>
Subject: Re: [PATCH v15 3/9] fuse: implement ioctls to manage backing files
To: Miklos Szeredi <miklos@szeredi.hu>, Jens Axboe <axboe@kernel.dk>
Cc: Jingbo Xu <jefflexu@linux.alibaba.com>, Bernd Schubert <bernd.schubert@fastmail.fm>, 
	linux-fsdevel@vger.kernel.org, Alessio Balsini <balsini@android.com>, 
	Christian Brauner <brauner@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 28, 2024 at 1:14=E2=80=AFPM Miklos Szeredi <miklos@szeredi.hu> =
wrote:
>
> On Wed, 28 Feb 2024 at 12:08, Amir Goldstein <amir73il@gmail.com> wrote:
>
> > I don't think so, because it will allow unprivileged user to exceed its
> > nested rlimits and hide open files that are invisble to lsof.
>
> How does io_uring deal with the similar problem of "fixed files"?
>

Good question.

Jens, Chritian,
Are fixed files visible to lsof?
Do they have to remain open in the files table of process that set them
in addition to being registered as fixed files?
Do they get accounted in rlimit? of which user?

Thanks,
Amir.


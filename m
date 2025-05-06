Return-Path: <linux-fsdevel+bounces-48205-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E2532AABF0D
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 May 2025 11:20:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 24D5F189CA54
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 May 2025 09:20:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9AB8266B56;
	Tue,  6 May 2025 09:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U4FUAzcM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98DA2264612
	for <linux-fsdevel@vger.kernel.org>; Tue,  6 May 2025 09:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746523108; cv=none; b=GSxK2payHLV5aWa/y+8ODp0EaNLVaXavrVAoyPWBlleb4pixxiqdS2/ffr1TpiNVNIpwyt51qMFAYIwH+b8mK+cW5QerHMNCbvGK1kTtUTa3wshoc++IqYL4xtKSzz95jkywziyjVX8oRW03WFYf0MMbyf597E7mhRr412hH6Xs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746523108; c=relaxed/simple;
	bh=CezHdgj/Qng8uUA5myIiSdpcwEepIYwS9+HGUd2g0mE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Q9vjJlTcvWHA6oaXSEpWVfLrP+oprD7M9uxfZ9Z6aHd+LkEODqr47bNCi+jGCRBtogpJYJJd6D2F4IoJvG1Z/ET7nE5VuqVvVWW6HRoQ1svU+yLWMSK/9ersZlw/QO3vVw59NIjoU0qVQLYNHS+0S7zrccwoXmWdSCHorobUTbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U4FUAzcM; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-acb5ec407b1so956226966b.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 06 May 2025 02:18:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746523104; x=1747127904; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CezHdgj/Qng8uUA5myIiSdpcwEepIYwS9+HGUd2g0mE=;
        b=U4FUAzcMF/eCkvbakVyPrf8n/X7abo/8QApocTP4TXiEDkLDH0yD/mi7P8x9JoVHj2
         mMj3ilTQ2MtqoXd0NYy0K/YK+IeAHXXfsKnF6EoRfSwLlO/wvIQhzEdiNx+VyL43joas
         6wTYYkvuc+oDXT2lDnWmIyHJl/CLy27ziMs0k3yb1IwX3pounmRWByGIRJ7ccL8etB/G
         7jYEgHoTiRDAHb2eQ30/eO0/VSDWHhdxFIYdj+XfvG6Et192jX9hjCGNybXQILUtySz4
         YqHWufmI+Uurr/IzVmfuELhUBuYelOia4jWLeCxYbeWkITDHErUL3KmgKbbVzr7Nw/5a
         JGTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746523104; x=1747127904;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CezHdgj/Qng8uUA5myIiSdpcwEepIYwS9+HGUd2g0mE=;
        b=apsgLFoSGN7xZyTZ8lnDFq5gKWVv8VegAznYXzP1kb14INaAsky35qNcGhC6yAnf8E
         jIJmSgMl0/z/ErArnq7Bzjx90+dKuNotiN+VCH2ijRtc8eJgIljrglxtbF9bBuTAIaAy
         No5n65pGHEi4XFG0EE6vKq1PgV2QfNBUOsKy4MOk3YCylGpj5pSgPmotFlYLkI521n2J
         QjzSnrkyH2xrG+xI6nkLT5J0PNKwMHcetjaJzvkAfZ80sAIwlHqhbBKrvil/8VEqpFXf
         cOWyi1d57SI4s9KCU5gsPdAh71/bVWP3kbVL70Ns2niDvK5a4VG7/8QTEqZYJ8yP2Br+
         NR/A==
X-Forwarded-Encrypted: i=1; AJvYcCUA+QIFA21VTiLDrNoPNwFacicahMyleOcFJRZiMfxEzIXesHPYGP2ilBZ0FRnbizlPAPyYrIcvKDiwclfC@vger.kernel.org
X-Gm-Message-State: AOJu0YzgjaPlJHuhaVeHeKFMMrStxuMHI6vUKnR+PfiOQ7fieN7WL8O7
	AR6xh9pnaQ+58x7EllAH4rBHstiWCIXqR8nyPOLE636/OPZIXp63WwYxtm+LT+HFv+NoBthopQg
	wTwWCbM7WBXff7jUyR+rkZEQk2Hw=
X-Gm-Gg: ASbGncvTYYCbbqx+D1YGcoVKFzwvwDTtaPIOK/X2uCFob1Q6stHZeae9mSiSjqISYUQ
	DUPj4pWNcH3Tz9gsMDN1auG7amLAbKdMikcNTRZE/30a+yeJvQ083+YRkamAzBOJIMPm+iJ0fjd
	XNJTUpDhrLOzFOSM090czGhg==
X-Google-Smtp-Source: AGHT+IFkY2UT01LRQOd9W2JXcy4Ha3GKajn7znNfjR714ohgRpDet12x9NvHWKn9bSyc9MuWzBCAezzI/e9rHgbOqGc=
X-Received: by 2002:a17:907:60d2:b0:ac8:17a1:e42 with SMTP id
 a640c23a62f3a-ad1d34c11c6mr189590566b.22.1746523103449; Tue, 06 May 2025
 02:18:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAOYeF9V_FM+0iZcsvi22XvHJuXLXP6wUYPwRYfwVFThajww9YA@mail.gmail.com>
 <ec87f7f4-5c12-4e71-952c-861f67dc4603@bsbernd.com> <CAC1kPDM2gm_Lsg-0KqDm9R3b_TV_JDX1RL9iqD_mJzgLdG+Bzw@mail.gmail.com>
In-Reply-To: <CAC1kPDM2gm_Lsg-0KqDm9R3b_TV_JDX1RL9iqD_mJzgLdG+Bzw@mail.gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Tue, 6 May 2025 11:18:10 +0200
X-Gm-Features: ATxdqUE1TSWlS3CU6Hxfwjdiilo1YlwGTSK3WX45ES2bQpz6ffVdfOIWQTYx1n4
Message-ID: <CAOQ4uxitswS2Fmz3mGzxj27uOP8JvUqpVbwn-dNyOiE-UC5qVg@mail.gmail.com>
Subject: Re: CAP_SYS_ADMIN restriction for passthrough fds (fuse)
To: Chen Linxuan <chenlinxuan@uniontech.com>
Cc: Bernd Schubert <bernd@bsbernd.com>, Allison Karlitskaya <lis@redhat.com>, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 6, 2025 at 4:48=E2=80=AFAM Chen Linxuan <chenlinxuan@uniontech.=
com> wrote:
>
> On Fri, May 2, 2025 at 9:22=E2=80=AFPM Bernd Schubert <bernd@bsbernd.com>=
 wrote:
>
> > I think it would be good to document all these details somewhere,
> > really hard to follow all of it.
>
> I agree with you but where should we document these details?

Documentation/filesystems/fuse-passthrough.rst would be a good place.

At the time, Miklos had an idea to spawn a kernel thread and install
those fds in this threads fd table, so that lsof will see them out of the b=
ox
without having to adapt lsof to learn about new fuse connection files.

But IMO, as long as we have a way to expose those files it is fine.
having old lsof display them is only nice to have.

Thanks,
Amir.


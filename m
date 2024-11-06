Return-Path: <linux-fsdevel+bounces-33741-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CBC39BE526
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Nov 2024 12:04:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9FF731F21904
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Nov 2024 11:04:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0BEA1DE4C6;
	Wed,  6 Nov 2024 11:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ifh3OU9l"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EC961DB377;
	Wed,  6 Nov 2024 11:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730891082; cv=none; b=mQ3+QHalWNY9zFati3IdV8ZcIULpn4sCsLJGC3xtOpJSgqPGm9Iib19QmOy2FTd+ZYb81vS2Il5dsEGaO5BQfaA8nfrz0BKgHX3VtrF5nZlKcpMV/AS3FbXr10KyKOgyGDte974FZxBjl0OdWI7ewYJ3nTRMlsglyScmsPaHCBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730891082; c=relaxed/simple;
	bh=QJzD2cy9KQWR48lFPZQEaD2sL9yIDbAudy3i3zK2Uss=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gOoclqyI9Gq4u2X5FjwSG/KUA6smm8s+zlFFYHt/Nm4QBb0EqJhGdjdXEdl+LuGNa06np816vwzwobfSgzIYex5YwUFzZ8nnxL4+9o6N3aHgRiDd0bnEkieulOPAU00CV9l+oYZbv4HklfD7YBLX7Jyzq1JpC5MPEwLOt4eBRNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ifh3OU9l; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-6cbe3e99680so35170026d6.3;
        Wed, 06 Nov 2024 03:04:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730891079; x=1731495879; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QJzD2cy9KQWR48lFPZQEaD2sL9yIDbAudy3i3zK2Uss=;
        b=Ifh3OU9lbi0qCAhYUsb2PtwLgkcXIiEqv1r3wfK5ImoQKHaoHx4+sA9P00m/Lsof6g
         v6Oj3+OZkmEpYy2Meb9B44zteCgr6gXQ2MxazXTTN0BrO4MaZxHxNVDH7mMskxM3Oxaz
         bDocYNLuSvWBKJKvrt4Quzkcti4ro/MuvA+BIGhBpeWHiLRCNDHXkFLfo5rZLa7yTolR
         8W0VmpaJO7Bq2PTs95iYpeThdbJ4EZ50IrjEjUnI9RcFYORa3vcprfoWPROLmS4BoLeJ
         JJkL5NRBbIDt8Hna/gix6A/q9D8kWrYl2ACKVBVw649av4GpaGSDKeg7UWltuz3tJEIp
         LChA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730891079; x=1731495879;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QJzD2cy9KQWR48lFPZQEaD2sL9yIDbAudy3i3zK2Uss=;
        b=Eo/EHm4VFSSFGA54wePqVZHywl/LiWjozW2udnBJ6yIR8Zg4e5uF33QxNnkArndRL0
         3Zhs7H7EbMkGez0tNISVjw9myfBcQXntseXb01f8dLnzVU1ZhZxA1rE+JWEyv9COKfIO
         ILmqpzZqejzaOWqX0jGBU7lfWaJBM/Bw6VKg2NX9XK5D0JjqtUM92oGF0Cmh44Zx2sTm
         dfApISimM4mbDJKT92rQIcawFa2YAIs1Xx11vzSdFRaZQH38YInAb4wKYaTDFIpm3Yu+
         hZS+Wm32WWeu9iA60Og5/xw6273C6ad2TtLfiAxaB/oLBilvXVjUxmE8zZLe6K+qiYvr
         ZS/g==
X-Forwarded-Encrypted: i=1; AJvYcCVB79Zhp1za2NqRbCzWd9iywiy3mCiyxf/XdtKnU80XKW/Zn4e6bi9zX5vG/oIqNAyp12o8MlgeAvvt8hDy@vger.kernel.org, AJvYcCVDv0qbEx7JjYL5Zo4hhQOHysjT0v+Wblsu2t1dqLG2uQSN03ukZR76QdS3wtpOrAjRCowXXySaRv9za9RryQ==@vger.kernel.org, AJvYcCW+52BvZdj9mP3LnXKYUAzhebOfgVgaNoEkCHFyZhISF6gITsv0rC1Ohw8ZTXR0bZh8bYVoR1cWrZJojmIY@vger.kernel.org
X-Gm-Message-State: AOJu0YxMVbBr8e+ftmljH5Mj8Vnwe+36QcBdewkT2mZkrIccgTYkPBYa
	Qy+QeOgauXYJTb6kvsoWXm0/SPLXitymfGALoeC9RsBqdTReVTfaE62HwiPOkT+lVsrmv0oU3Ru
	u/s+TfAkPe+z6DCYi9E5fwRxttApJp2TS
X-Google-Smtp-Source: AGHT+IFDKH+mbTd2xwsg0nX0AaLCteb2Gnpa4GsMAtV3ol5yplQfOyye01XEeQJimIpoIHwqQBx3mT6BehChS//+utc=
X-Received: by 2002:a05:6214:4b02:b0:6cb:afe7:1403 with SMTP id
 6a1803df08f44-6d185866d2fmr585370366d6.48.1730891079186; Wed, 06 Nov 2024
 03:04:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241106-overlayfs-fsopen-log-v1-1-9d883be7e56e@cyphar.com>
 <20241106-mehrzahl-bezaubern-109237c971e3@brauner> <CAOQ4uxirsNEK24=u3K-X5A-EX80ofEx5ycjoqU4gocBoPVxbYw@mail.gmail.com>
In-Reply-To: <CAOQ4uxirsNEK24=u3K-X5A-EX80ofEx5ycjoqU4gocBoPVxbYw@mail.gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Wed, 6 Nov 2024 12:04:27 +0100
Message-ID: <CAOQ4uxj+gAtM6cY_aEmM7TAqLor7498f0FO3eTek_NpUXUKNaw@mail.gmail.com>
Subject: Re: [PATCH] overlayfs: port all superblock creation logging to fsopen logs
To: Christian Brauner <brauner@kernel.org>, Miklos Szeredi <miklos@szeredi.hu>
Cc: Aleksa Sarai <cyphar@cyphar.com>, Jan Kara <jack@suse.cz>, linux-unionfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Karel Zak <kzak@redhat.com>, 
	linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

[Fixed address of linux-fsdevel]

On Wed, Nov 6, 2024 at 12:00=E2=80=AFPM Amir Goldstein <amir73il@gmail.com>=
 wrote:
>
> On Wed, Nov 6, 2024 at 10:59=E2=80=AFAM Christian Brauner <brauner@kernel=
.org> wrote:
> >
> > On Wed, Nov 06, 2024 at 02:09:58PM +1100, Aleksa Sarai wrote:
> > > overlayfs helpfully provides a lot of of information when setting up =
a
> > > mount, but unfortunately when using the fsopen(2) API, a lot of this
> > > information is mixed in with the general kernel log.
> > >
> > > In addition, some of the logs can become a source of spam if programs
> > > are creating many internal overlayfs mounts (in runc we use an intern=
al
> > > overlayfs mount to protect the runc binary against container breakout
> > > attacks like CVE-2019-5736, and xino_auto=3Don caused a lot of spam i=
n
> > > dmesg because we didn't explicitly disable xino[1]).
> > >
> > > By logging to the fs_context, userspace can get more accurate
> > > information when using fsopen(2) and there is less dmesg spam for
> > > systems where a lot of programs are using fsopen("overlay"). Legacy
> > > mount(2) users will still see the same errors in dmesg as they did
> > > before (though the prefix of the log messages will now be "overlay"
> > > rather than "overlayfs").
>
> I am not sure about the level of risk in this format change.
> Miklos, WDYT?
>
> > >
> > > [1]: https://bbs.archlinux.org/viewtopic.php?pid=3D2206551
> > >
> > > Signed-off-by: Aleksa Sarai <cyphar@cyphar.com>
> > > ---
> >
> > To me this sounds inherently useful! So I'm all for it.
> >
>
> [CC: Karel]
>
> I am quite concerned about this.
> I have a memory that Christian suggested to make this change back in the
> original conversion to new mount API, but back then mount tool
> did not print out the errors to users properly and even if it does
> print out errors,
> some script could very well be ignoring them.
>
> My strong feeling is that suppressing legacy errors to kmsg should be opt=
-in
> via the new mount API and that it should not be the default for libmount.
> IMO, it is certainly NOT enough that new mount API is used by userspace
> as an indication for the kernel to suppress errors to kmsg.
> I have no problem with reporting errors to both userspace and kmsg
> without opt-in from usersapce.
>
> Furthermore, looking at the existing invalfc() calls in overlayfs, I see =
that
> a few legacy pr_err() were converted to invalfc() with this commit
> (signed off by myself):
> 819829f0319a ovl: refactor layer parsing helpers
>
> I am not really sure if the discussion about suppressing the kmsg errors =
was
> resolved or dismissed or maybe it only happened in my head??
>
> Thanks,
> Amir.


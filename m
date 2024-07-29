Return-Path: <linux-fsdevel+bounces-24498-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10C9893FC7D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jul 2024 19:34:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB35E283234
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jul 2024 17:34:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A70F15D5C4;
	Mon, 29 Jul 2024 17:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hijyr80F"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1511D5028C;
	Mon, 29 Jul 2024 17:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722274443; cv=none; b=nW4H7r9Q/lEBuXFu0GFpjDPkrNm4Z5ZVgHf/pydAL+WIY39gCZ95t6r4rCE0Cy4ivPobk+mD4pJHRfbxq+CrsREjPeSExohlQdSsQ4LZt0PaY3j5EFSW4IJJYuRTwgVXI3u2ZAr6BrsW1SkA5hOK2CqHRjpQlJck6u2bRM67BHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722274443; c=relaxed/simple;
	bh=xdfTm7LzMoD5u1SQggiotRToTxWzisl2JjvFX2swJnc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=e+cnZ3dgRE+PeKRTD37UTSQpDBPT8YdSQC5w3MTFXpLoUV/ZfJ4o4Z4hXxgqZCJtHyogLfXaWN4FOlA0NRAMvX2JEae3zrzgQQLANcPfc3hGQRlNF/Qi/hH7w6PtFJ5WX3aMTP3nVq8AY9I3A1+3vDpaqO2NzE/bslw7st7iiBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hijyr80F; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2f0407330a3so997921fa.3;
        Mon, 29 Jul 2024 10:34:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722274440; x=1722879240; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s6kyVEe575aj2OTlvsr7/JLoxWoAePv21nuSGUR5NTQ=;
        b=Hijyr80FhMH+VaekdJJVVfQsTyy3Jhmj7zD6Nt2fEFIWzJSSbSW7gzhygB/5WKlSRF
         ZcjSeWv35ZTNk19fqRdMOa0DtIxbt6dB9Ck6edfmn1MqNKRzYn1dRibkBpCHE1WhcekE
         T2UGpD0xjJqowCH5ij9PXbeNXJI0liFCHlCZhrh1qJZS04SVO3LNWNV/J83PbQ6zwE+d
         wfSEGoLxDgB8yMKBhubrPuDNd9z56JzxnbLvHA0+pSlM350aetvaP2xz6TcSCUF0yaGX
         TClatM9kmg5aDNj25is6YMyPh8cFpmxmJtz7YG98Ez1aupu9aI7gukAVbKC12ZKspqki
         X0Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722274440; x=1722879240;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s6kyVEe575aj2OTlvsr7/JLoxWoAePv21nuSGUR5NTQ=;
        b=OTRA5apmQUZ5TfT/3ZVE/alzBVhUcF3d17AiFbCTsYHCcHi/NFs9A26ja5sWjOIh7R
         HZvRaaw0+qsu22sNaZgpR41lSN9bBwwMlDksP20XFmkuD8h5E9N+kzzM0XAWkq2G2cmQ
         pLdTt20VLCn/E/qKXwxs10HpbIHoyMzb1KbXejqxXE3lVC3OAzh7MuPS9IoaMmvzU4hv
         CQUuU7LA/+wwnd2kC/rPj9veo2MT0/BQ7HPeEyWtvXKoYzw5RgEazdnaLCr39cnsfFyI
         tkW+gSEgOlcLhZeaQjLhdXS6bM3UZ3GhUHYrqH9NtrIZEMSCCcZG15KAPCwtK6yUDQsq
         bfkQ==
X-Forwarded-Encrypted: i=1; AJvYcCVGQUq57tTF5dUBsdttuw1qgtmamcSCGjfefTjmqK3iz6QDXGUX5bsHx9T4QHwVC6/JgeU0z3lFgdi6oqFJkcJoSzBr36clbJ16/52DVfZhYRBF1N7231ogl0NuEKGDRXVv06y9y/OF1Q==
X-Gm-Message-State: AOJu0YwjCu7YA9MIM43wl3hPjaCPPnskXDWUJymCWGWsyhaIwtV4YWa4
	r3sxMLtA+mhiQHfAO2GCgOhny7om+ArRrvkDwcF3s9ODqiXsG37yLTYNjvhLHNYMZ7gsUsuHDTp
	iI96ZjV9MaDuuxLbUbMovKT+PGbUKpVkP
X-Google-Smtp-Source: AGHT+IEa7xJMSK3IqaxgrXEkRQVWf1835DL1FlkHMENIV7BFfCOu1wuo3ZcHBCenA1SDCXXKe04+6B4iP7o21eS5UvY=
X-Received: by 2002:a2e:a41a:0:b0:2ef:251f:785 with SMTP id
 38308e7fff4ca-2f12ebc9755mr59269911fa.1.1722274439914; Mon, 29 Jul 2024
 10:33:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAH2r5ms+vyNND3XPkBo+HYEj3-YMSwqZJup8BSt2B3LYOgPF+A@mail.gmail.com>
 <20240729-abwesend-absondern-e90f3209e666@brauner>
In-Reply-To: <20240729-abwesend-absondern-e90f3209e666@brauner>
From: Steve French <smfrench@gmail.com>
Date: Mon, 29 Jul 2024 12:33:48 -0500
Message-ID: <CAH2r5muRnhFevDR29k=DkmD_B44xQ5jOXd5RnRqkyH27pKzNDQ@mail.gmail.com>
Subject: Re: Why do very few filesystems have umount helpers
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel <linux-fsdevel@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	CIFS <linux-cifs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> umount.udisks talks to the udisks daemon which keeps state
> on the block devices it manages and it also cleans up things that were
> created (directories etc.) at mount time

That does sound similar to the problem that some network fs face.
How to cleanup resources (e.g. cached metadata) better at umount time
(since kill_sb can take a while to be invoked)

> The first step should be to identify what exactly keeps your mount busy
> in generic/044 and generic/043.

That is a little tricky to debug (AFAIK no easy way to tell exactly which
reference is preventing the VFS from proceeding with the umount and
calling kill_sb).  My best guess is something related to deferred close
(cached network file handles) that had a brief refcount on
something being checked by umount, but when I experimented with
deferred close settings that did not seem to affect the problem so
looking for other possible causes.

I just did a quick experiment by adding a 1 second wait inside umount
and confirmed that that does fix it for those two tests when mounted to Sam=
ba,
but not clear why the slight delay in umount helps as there is no pending
network traffic at that point.

On Mon, Jul 29, 2024 at 4:50=E2=80=AFAM Christian Brauner <brauner@kernel.o=
rg> wrote:
>
> On Sun, Jul 28, 2024 at 02:09:14PM GMT, Steve French wrote:
> > I noticed that nfs has a umount helper (/sbin/umount.nfs) as does hfs
> > (as does /sbin/umount.udisks2).  Any ideas why those are the only
> > three filesystems have them but other fs don't?
>
> Helpers such as mount.* or umount.* are used by util-linux. They're not
> supposed to be directly used (usually).
>
> For example, umount.udisks talks to the udisks daemon which keeps state
> on the block devices it manages and it also cleans up things that were
> created (directories etc.) at mount time. Such mounts are usually marked
> e.g., via helper=3Dudisks to instruct util-linux to call umount.udisks
>
> Similar things probably apply to the others.
>
> > Since umount does not notify the filesystem on unmount until
> > references are closed (unless you do "umount --force") and therefore
> > the filesystem is only notified at kill_sb time, an easier approach to
> > fixing some of the problems where resources are kept around too long
> > (e.g. cached handles or directory entries etc. or references on the
> > mount are held) may be to add a mount helper which notifies the fs
> > (e.g. via fs specific ioctl) when umount has begun.   That may be an
> > easier solution that adding a VFS call to notify the fs when umount
> > begins.   As you can see from fs/namespace.c there is no mount
> > notification normally (only on "force" unmounts)
>
> The first step should be to identify what exactly keeps your mount busy
> in generic/044 and generic/043. If you don't know what the cause of this
> is no notification from VFS will help you. My guess is that this ends up
> being fixable in cifs.



--=20
Thanks,

Steve


Return-Path: <linux-fsdevel+bounces-9058-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91F5583D9FE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Jan 2024 13:13:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B33011C21F99
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Jan 2024 12:13:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21CC118B1B;
	Fri, 26 Jan 2024 12:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VMAaWh4n"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34BDB17732
	for <linux-fsdevel@vger.kernel.org>; Fri, 26 Jan 2024 12:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706271213; cv=none; b=ReHFYBfqy+udkN4T/hhLGthM7qOKSNfryuiy5+NDqPVdCQAvuBHXUUMwm3gVzNi4PECJQN8SqAi96286PwMn5u3c5rygVS7L5DyEpyT04oeKReAp9N+VrXgOJwP5Aq6urDZ2EHURi96UJ8cw+yEZuuepQSOxvzCa2qPld6Lo6ok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706271213; c=relaxed/simple;
	bh=1tZf8ImCPaVIMpFDDiuONG3Sax5fy69KNOh0G3ShinE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V/7X1CpQbVJNotx09G/C2xA/vsm5okRNqCUmjF9bDqgKPMhN3GXmgPJLXwj2Yp3n6n9Pfln2wAROOxjGEGoval/7rG15CdKOTkVBfpxUurIUmFK1z3D3mYphchGOgemoLO16ZUhLbt2nmuJICA5VbNynEksQfqoKI/jOLzDuiXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VMAaWh4n; arc=none smtp.client-ip=209.85.161.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-59927972125so172767eaf.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 26 Jan 2024 04:13:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706271211; x=1706876011; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1tZf8ImCPaVIMpFDDiuONG3Sax5fy69KNOh0G3ShinE=;
        b=VMAaWh4nAaNY9P5jlzoW01t78iSaXu3FMUzgWl4aMwMvgSfmSDezZXDDsCH2ODIngA
         +jfzOkYiKGb+JJNlcaNS4T0vRt6WAHw1lBRnGJ7KQlojY6uzEjDX7JCuHQ6VShgQ4eZL
         Fibzlfj4bcSVXmI8OZ7aCkD3pSOFsVPW9cjw4ho/IkkodHuz82/lcyJKwaEUXrMR0EKI
         TXvR7vpM0d5Cx+5UuTQdEN2HFJjzEtcTJHIWVsPzTGBXgohD1j067sJQXnGl7ewq5B7U
         8j+HSWy3xj2Jx8hD7oN5ZvdsznpT0idQNbjmGKiYrMC10NdlGl2G0RGJGqx7n9scNYbr
         XLAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706271211; x=1706876011;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1tZf8ImCPaVIMpFDDiuONG3Sax5fy69KNOh0G3ShinE=;
        b=Ya4sLsCHIo+8uqMPoYtVO8h4IDjPEj/5mCAov/aGXM6FmZa/BbuCiI+KmrGInrn6J9
         CBBvomzY14m/kMbwTptx0m4TcHRgy3p5gvE2kA9wtsKU2Eo28+xyINBREURQNQMuJxoi
         Y8WlnJ1asUQ9WsCvfIsfvnVUHu9Fw+CgCxvigbrrIx3EE+SKeL4TRS/BoHO0SlPpTs0Y
         lfKuYmnpeZgr0DVsS2mDkhdEYhtHpI29/JUotyuvKk2M9eOtJsQJ1MfBzEi3fOkH4eNP
         NJf3oDh5tKb9Eoos18LvzQjAvT2L8Cb/dMhGCSdza6RlE0vodemwyMOB9Cxbc7Q2qsSR
         ux5w==
X-Gm-Message-State: AOJu0YwwFL8xFRtj6lVvN2pr9zaDtGUO6mOPOJZmv1qiBTPSIrgyGkNG
	dQuNWkQF/RicMgD8LH3N1e6e4JXbAPHZAyeM2cApZr2WK8rEMTnQEfYam3NPszxtD966xyscxAq
	pe6tsl6hm9Dp27H0Z2Jbx0y+NdSQ=
X-Google-Smtp-Source: AGHT+IFURqMNxhamp9kylKVlxp7fjKKlYfBIDHhy30vH0PLUQQZjcGesrhIpfguK/unTHki0KQ+AgdGzb/Vm4t4uVek=
X-Received: by 2002:a05:6358:d04:b0:176:9957:c33e with SMTP id
 v4-20020a0563580d0400b001769957c33emr1334534rwj.39.1706271211021; Fri, 26 Jan
 2024 04:13:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231016160902.2316986-1-amir73il@gmail.com> <CAOQ4uxh=cLySge6htd+DnJrqAKF=C_oJYfVrbpvQGik0wR-+iw@mail.gmail.com>
 <CAJfpegtZGC93-ydnFEt1Gzk+Yy5peJ-osuZD8GRYV4c+WPu0EQ@mail.gmail.com>
 <CAOQ4uxjYLta7_fJc90C4=tPUxTw-WR2v9du8JHTVdsy_iZnFmA@mail.gmail.com>
 <CAJfpegufvtaBaK8p+Q3v=9Qoeob3WamWBye=1BwGniRsvO5HZg@mail.gmail.com>
 <CAOQ4uxj+myANTk2C+_tk_YNLe748i2xA0HMZ7FKCuw7W5RUCuA@mail.gmail.com>
 <CAJfpegs1v=JKaEREORbTsvyTe02_DgkFhNSEJKR6xpjUW1NBDg@mail.gmail.com>
 <CAOQ4uxiBu8bZ4URhwKuMeHB_Oykz2LHY8mXA1eB3FBoeM_Vs6w@mail.gmail.com>
 <CAJfpegtr1yOYKOW0GLkow_iALMc_A0+CUaErZasQunAfJ7NFzw@mail.gmail.com>
 <CAOQ4uxjbj4fQr9=wxRR8a5vNp-vo+_JjK6uHizZPyNFiN1jh4w@mail.gmail.com>
 <CAJfpegtWdGVm9iHgVyXfY2mnR98XJ=6HtpaA+W83vvQea5PycQ@mail.gmail.com>
 <CAOQ4uxja2G2M22bWSi_kDE2vdxs+sJ0ua9JgD-e7LEGsTcNGXw@mail.gmail.com>
 <CAJfpegt3mEii075roOTk6RKeNKGc89pGMkWrvVM0uLyrpg7Ebg@mail.gmail.com>
 <CAOQ4uxipyZOSMcko+V+ZxGZwAgKVwWTUeoH79zqtMqbcKSnOoA@mail.gmail.com>
 <CAJfpegs5m-7QapX86CEiyy5oDzJQox6QsWjcLeegMV9OMbkBrg@mail.gmail.com>
 <CAOQ4uxjc6B2kXvbnbYPNCr8+ysFCoH24s+3fFa_Xkapyb9ueKA@mail.gmail.com> <CAJfpegsoHtp_VthZRGfcoBREZ0pveb4wYYiKVEnCxaTgGEaeWw@mail.gmail.com>
In-Reply-To: <CAJfpegsoHtp_VthZRGfcoBREZ0pveb4wYYiKVEnCxaTgGEaeWw@mail.gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Fri, 26 Jan 2024 14:13:15 +0200
Message-ID: <CAOQ4uxhwWPwBtfG7KH8w4bAJ_vZ_xMB-Gz3=D94sdz=3jynYfA@mail.gmail.com>
Subject: Re: [PATCH v14 00/12] FUSE passthrough for file io
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Bernd Schubert <bernd.schubert@fastmail.fm>, Daniel Rosenberg <drosen@google.com>, 
	Paul Lawrence <paullawrence@google.com>, Alessio Balsini <balsini@android.com>, 
	Christian Brauner <brauner@kernel.org>, fuse-devel@lists.sourceforge.net, 
	linux-fsdevel@vger.kernel.org, Dave Chinner <david@fromorbit.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 2, 2023 at 3:13=E2=80=AFPM Miklos Szeredi <miklos@szeredi.hu> w=
rote:
>
> On Thu, 2 Nov 2023 at 14:08, Amir Goldstein <amir73il@gmail.com> wrote:
>
> > Just to be clear, at the last close for an inode, we would check
> > if attribute cache needs to be invalidate and the inode will return
> > to "neutral" mode, when server could legally switch between
> > caching and passthrough mode.
>
> Exactly.

FYI, this is now implemented in the fuse-backing-fd branch OTM [1],
including auto-invalidate of attributes in fuse_getattr() when there is
a backing inode.

With this in place, the few fstests that were reported to fail in the v14
cover letter (top of this thread) are now passing.

One detail worth noting is that I found it too complicated to support
writeback cache (for the non-passthrough inodes) along with fuse
passthrough support on the same filesystem, so for now, this
combination is not allowed.

>
> > EIO works for me.
> > Just as simple.
> > Will try to get this ready for early 6.8 cycle.
>

My patches are based on top of the fuse IO mode patches [2] that
were a joined effort with Bernd.

I will wait for Bernd to post his patches before I post the FUSE
passthrough patches.

There are a few questionable behaviors w.r.t mixing parallel dio
with fuse passthrough, but I won't get into them now.
We can discuss them after the patches are posted.

I will mention that I took a design choice that server can
(and is encouraged to) use FOPEN_DIRECT_IO together with
FUSE_PASSTHROUGH and a backing file id to request that read/write
will go directly to server, but mmap will have a backing inode to map to,
so that it won't need to use page cache and deny future passthrough open
of the same inode.

Thanks,
Amir.

[1] https://github.com/amir73il/linux/commits/fuse-backing-fd-260124/
[2] https://github.com/amir73il/linux/commits/fuse_io_mode


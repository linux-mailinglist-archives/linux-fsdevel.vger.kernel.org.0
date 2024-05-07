Return-Path: <linux-fsdevel+bounces-18948-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F0E8D8BEE31
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 May 2024 22:39:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 66CD81F269FC
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 May 2024 20:39:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E53C23E476;
	Tue,  7 May 2024 20:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20230601.gappssmtp.com header.i=@amacapital-net.20230601.gappssmtp.com header.b="ikl29dlD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com [209.85.221.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3C087E8
	for <linux-fsdevel@vger.kernel.org>; Tue,  7 May 2024 20:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715114336; cv=none; b=r0m/Xg5uzJO5HpzYGuEK+uIoMq3SGRHoD4wfYcr6eXJFnMHAGJqeyyVo/otImkatwgCaPHOjxUEM3fQtuajivRhx0JPfaP9LoF7/x3ciA7d1Fyh/IgVm6cJm9upp9jT/Cn0NPF+34IYDQg8lrb7M4JKkyPvPmXRVXWBlMkkyuEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715114336; c=relaxed/simple;
	bh=Cd3CA+2L3RKB6jP4ss7YRlrKqmhPE6AGzn1nXgsUr10=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EFlJ3LqUoqCokMQ6qBqKzCkFfCKa59q//NTIrjHK8qj4kIn6STgUc+0ELJZAuUZidO0v8SR+7QwC8XREJLv3tVjiaXJb6mSboTH/NWXzJ+mHpx7w/tAWXkG9isxJ0059CTcLNGxiY9GPf2EXpCJRr0HXon/0aYuHpI8DE1WEERY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net; spf=pass smtp.mailfrom=amacapital.net; dkim=pass (2048-bit key) header.d=amacapital-net.20230601.gappssmtp.com header.i=@amacapital-net.20230601.gappssmtp.com header.b=ikl29dlD; arc=none smtp.client-ip=209.85.221.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amacapital.net
Received: by mail-vk1-f181.google.com with SMTP id 71dfb90a1353d-4dcfba0cf35so1179411e0c.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 07 May 2024 13:38:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20230601.gappssmtp.com; s=20230601; t=1715114334; x=1715719134; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vnCeIEbMK/S2Q+LWJU/37wK3PlXMM94h7g54EnTFDpw=;
        b=ikl29dlDaKTt2cZteLe2jQcW0M+pN6/OvAIV8OnoeeLj0RDbcXwv4EUF7b0f4w8wLw
         AFzjFZrzDnpCNBkkmeY+Dn4jmRTPpVR+INy9jMUA8jkPJAfgI78po2/PhT0SdhsFSpRr
         FRGrbJq1r78i6e6ffKa9m5x/ilRD1lZ2KS+pGBQIbQGi/f1h8GZ0RcSkbpJo4HrP0HgL
         Y8l8/MBMgTgUJ3aZEqGTaX8IPtSthIkF4YHYuiCCIdGLogD8D/yCWPi7oZpXqHxTxYM5
         0m3DoVXtfPr1nkiSMMZ6tp3wRryF9dnghf3CtPeezkKqrvtzOm35sKOH1hwBXcVKa4tU
         Iu7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715114334; x=1715719134;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vnCeIEbMK/S2Q+LWJU/37wK3PlXMM94h7g54EnTFDpw=;
        b=RuL3Y16aOCSnUURA2NL8wqagoMgSWBPX70vJ0QV0TWfH2I3g3fPWhzkvX6jGy5At0l
         VcI2ww+9XdHjMWP8sr4dgbcABO6A3ZnHCsFxsB4B6AVY0nFvRZRYGYiMvKVkFSZN+YWZ
         rJCuxcfplBsX0D/O+1v4f/nqPL/hP2t42Qy+9SziAAHxVG/DtJkReUEZm7WPlYgp1PgT
         3dmM1dqBU9wCgGleayNj8JjOd+z7ARA1COBeSb9PUOr3f4sVsbgobYD8WLCPBsWD5jge
         MX/1ervRBUee1lwB/cAS5b4bjmvJV0XV7j1Ax8FwtyzTDeeEjerezkxQsQWdb3wEXkZX
         X3Ow==
X-Forwarded-Encrypted: i=1; AJvYcCVpMqJ3EFzFTxJqPyi+HYVRY9PHcR3erRZMvZ9seAxZkao4BLtBXzF/T6OJ50WoIlii5xK8HpW0NnUG29VCbypn9HXROYil/rxhY7eUtw==
X-Gm-Message-State: AOJu0YyhWoEbaSwxTpic5N/ObyywR5AdSKo5SZqr+7dXC20SaArZCGqv
	BibYvUQyAJ0TnRjoQejBaCszogyWYVI56HQaCb3NyPfKyd88J4/NzxEFKc+A5/1FqnCoiPLYuVZ
	u4XMGtGZYEWjstAhofrZI2vEQ3fKS0usseLXU
X-Google-Smtp-Source: AGHT+IF96ez/SbaMDabA1CLkv2z7bcOSobqP74IQPnlmx8A0CCKvlSCp89o3qEQzUXeSdxqCn3m43X4JpnhygxR/QKg=
X-Received: by 2002:a05:6122:7ca:b0:4da:aff6:5eee with SMTP id
 71dfb90a1353d-4df69399556mr657304e0c.15.1715114333777; Tue, 07 May 2024
 13:38:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240426133310.1159976-1-stsp2@yandex.ru> <CALCETrUL3zXAX94CpcQYwj1omwO+=-1Li+J7Bw2kpAw4d7nsyw@mail.gmail.com>
 <20240428.171236-tangy.giblet.idle.helpline-y9LqufL7EAAV@cyphar.com>
 <CALCETrU2VwCF-o7E5sc8FN_LBs3Q-vNMBf7N4rm0PAWFRo5QWw@mail.gmail.com> <20240507-verpennen-defekt-b6f2c9a46916@brauner>
In-Reply-To: <20240507-verpennen-defekt-b6f2c9a46916@brauner>
From: Andy Lutomirski <luto@amacapital.net>
Date: Tue, 7 May 2024 13:38:42 -0700
Message-ID: <CALCETrWuVQ-ggnak40AX16PUnM43zhogceFN-3c_YAKZGvs5Og@mail.gmail.com>
Subject: Re: [PATCH v5 0/3] implement OA2_CRED_INHERIT flag for openat2()
To: Christian Brauner <brauner@kernel.org>
Cc: Aleksa Sarai <cyphar@cyphar.com>, Stas Sergeev <stsp2@yandex.ru>, 
	"Serge E. Hallyn" <serge@hallyn.com>, linux-kernel@vger.kernel.org, 
	Stefan Metzmacher <metze@samba.org>, Eric Biederman <ebiederm@xmission.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Andy Lutomirski <luto@kernel.org>, Jan Kara <jack@suse.cz>, 
	Jeff Layton <jlayton@kernel.org>, Chuck Lever <chuck.lever@oracle.com>, 
	Alexander Aring <alex.aring@gmail.com>, David Laight <David.Laight@aculab.com>, 
	linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org, 
	Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 7, 2024 at 12:42=E2=80=AFAM Christian Brauner <brauner@kernel.o=
rg> wrote:
>
> > With my kernel hat on, maybe I agree.  But with my *user* hat on, I
> > think I pretty strongly disagree.  Look, idmapis lousy for
> > unprivileged use:
> >
> > $ install -m 0700 -d test_directory
> > $ echo 'hi there' >test_directory/file
> > $ podman run -it --rm
> > --mount=3Dtype=3Dbind,src=3Dtest_directory,dst=3D/tmp,idmap [debian-sli=
m]
>
> $ podman run -it --rm --mount=3Dtype=3Dbind,src=3Dtest_directory,dst=3D/t=
mp,idmap [debian-slim]
>
> as an unprivileged user doesn't use idmapped mounts at all. So I'm not
> sure what this is showing. I suppose you're talking about idmaps in
> general.

Meh, fair enough.  But I don't think this would have worked any better
with privilege.

Can idmaps be programmed by an otherwise unprivileged owner of a
userns and a mountns inside?

> Many idmappings to one is in principle possible and I've noted that idea
> down as a possible extension at
> https://github.com/uapi-group/kernel-features quite a while (2 years?) ag=
o.
>
> > I haven't looked at the idmap implementation nearly enough to have any
> > opinion as to whether squashing UID is practical or whether there's
>
> It's doable. The interesting bit to me was that if we want to allow
> writes we'd need a way to determine what the uid/gid would be to write
> down. Imho, that's not super difficult to solve though. The most obvious
> one is that userspace can just determine it when creating the idmapped
> mount.

Seems reasonable to me.  If this is set up by someone unprivileged, it
would need to be that uid/gid.


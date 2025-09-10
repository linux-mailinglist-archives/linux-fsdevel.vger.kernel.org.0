Return-Path: <linux-fsdevel+bounces-60753-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F626B5144F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Sep 2025 12:47:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E12AD465106
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Sep 2025 10:47:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26DA53168E2;
	Wed, 10 Sep 2025 10:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nrubsig.org header.i=@nrubsig.org header.b="Kl2tfLlF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from duck.ash.relay.mailchannels.net (duck.ash.relay.mailchannels.net [23.83.222.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5E733164C8;
	Wed, 10 Sep 2025 10:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.222.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757501133; cv=pass; b=e59LTWK596C3PBVxftI8dncRQkI6McmxepiIY/zNXJtMpp/pE2ifZ+HRxLb+Xobq2IVhKCnm8jrE+4li2JOzDFkWp2uSt3a6MJYn1gXSG5smWtdlHlcqed+jrqjLDnIyl3iyodOP3brEtIUNCxnJgMk/dHn8z7bmVl1PJeeBiCc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757501133; c=relaxed/simple;
	bh=ZyQZl0BmsGiaSwEFOVHWC8Nv1J46RVBUdcsbZqmNpg4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=m/+SF4ULfIBw1ycDDM7rgpSmfd1GpTqr072Axua6nLI7hGfS5nZtQSt03GzledI6MNT2QBwRj6e3umzyvlVeHDDuqUNT3eS6XNNSlXm5UpwgiHF1vCvsUVMgyzt1gDspEPETWPsjBkZBhbLxSt/WLw/ug4bEnM7O5v3rH9EAOoQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nrubsig.org; spf=pass smtp.mailfrom=nrubsig.org; dkim=pass (2048-bit key) header.d=nrubsig.org header.i=@nrubsig.org header.b=Kl2tfLlF; arc=pass smtp.client-ip=23.83.222.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nrubsig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nrubsig.org
X-Sender-Id: dreamhost|x-authsender|gisburn@nrubsig.org
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 88C49164F84;
	Wed, 10 Sep 2025 10:45:23 +0000 (UTC)
Received: from pdx1-sub0-mail-a237.dreamhost.com (trex-blue-9.trex.outbound.svc.cluster.local [100.107.107.29])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id E5151164D74;
	Wed, 10 Sep 2025 10:45:22 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1757501122; a=rsa-sha256;
	cv=none;
	b=rYbjbXkDURZrCQY+N4nLpsOrfrIXh3t4JsySe5hdG6fZk9QYHgFN44armgDz2Nt2aXCbwm
	dcKEbaF/UYK+INQG99eHimbqsBrAD5QoAJ/Weyeje4WsKz35k2fvhBZYjOU1nbmlyNQBLT
	/tXh7gBB6bq5hZgJYylgtkqoCIYaOktenjG0goV8Ja3L76NtcN8q5KQ2UHVSA8AX9zIQB0
	AKhqLyQ3/qJtsKU4wv02bC9CLxU745At5SIRDymeg6aoj9hmQbLcl8LshilvgTkkH4ShUZ
	9CIc3MCO7CDtz6kUzr3GkfEmvD+kWqMoO6eI6qHDq0ZBQnXuUky0Q3F/smTvYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1757501122;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=WWpiqsnARGBJMOxKWu8O8okhFx6J9JlTgDx5K/YgeL8=;
	b=b272Hvmw48nV7ZXQmAqz2CSBdzAalksD+RxNt2aVkomexGCmUi0EIZsQryTb9ZH2Sn4djm
	4+TwtdczNPF3Qmi4CBagAdcjvQHOsXq/cE79Ha6RwgVAx4eRZmkoz0X9dBzShO54uXU8Ux
	+4Uo3zsD8SVN8P7UGEym4rMe9dL+TMzlnLdIqyMDe3ENznWQr7IPJhN1PH8YFAZ7vTlesF
	CTgpyIz6g6oWcRU0CzEzT3kw8CNbSV7vUS/JcEnIUCv2lHAntqXGh+UXQvNAEXL1+bt2Ks
	8rPmb9Ob6VMrBJ05S7p8st5iga55kAyhOND22JuX3LC4HQ+BqcVyvBLB6/mopg==
ARC-Authentication-Results: i=1;
	rspamd-7b5fd646f8-tthn8;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=roland.mainz@nrubsig.org
X-Sender-Id: dreamhost|x-authsender|gisburn@nrubsig.org
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|gisburn@nrubsig.org
X-MailChannels-Auth-Id: dreamhost
X-Drop-Squirrel: 0e34a47209efcd39_1757501123150_903476887
X-MC-Loop-Signature: 1757501123150:304163345
X-MC-Ingress-Time: 1757501123150
Received: from pdx1-sub0-mail-a237.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.107.107.29 (trex/7.1.3);
	Wed, 10 Sep 2025 10:45:23 +0000
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: gisburn@nrubsig.org)
	by pdx1-sub0-mail-a237.dreamhost.com (Postfix) with ESMTPSA id 4cMHQV4xbMz9s;
	Wed, 10 Sep 2025 03:45:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nrubsig.org;
	s=dreamhost; t=1757501122;
	bh=WWpiqsnARGBJMOxKWu8O8okhFx6J9JlTgDx5K/YgeL8=;
	h=From:Date:Subject:To:Content-Type:Content-Transfer-Encoding;
	b=Kl2tfLlFUrHf3wGRw56KdtBpSiFfj2/f6PlHNJvScrH4/y0vMCTXEH7AIqTO5awaX
	 vksWKOXVueIzmek75nJME9CC2MiX+DhiMrw03lxwX5tGy0Tj4ZB3DleHC3DM8U+nHI
	 qGIyCFxH1wtRC8N6AsnNgVdhduSMquUCgin+9WLTDa3sG+f1c0Duly/xmh2cIbxbXF
	 dcI9w79kwflneV9gQpn3pU1pvaED5pq3CBgzZ6s8KySmSvAu3ObOAH1gKUhXULaeT6
	 dJOs+8sTpgRsIqqiEKu4+V0c6le9u/NpX4if6uSu5sVeHGmZw3nSsFKEF2OBrltzwu
	 77t0F2LzT6Wuw==
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-45df09c7128so4726415e9.1;
        Wed, 10 Sep 2025 03:45:22 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV2LMgBwRLxS0rKixxNujYOm0EV8Yh5Om2uCVN/AH9vEPBdPmW/7JzIqyMKCRIlEmGKRG7mM8TfQHY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1w9J+MOKN730ZCt+e2sRmxxjVUfls4xSu+38uVNrsnf8sWTli
	jqUK6/P5ExO+yHhYFZiJXoDsMya/GSUSwUE+wPYi2RrWlNpDm9hAPb0O1npNsqBzchqemFn+5yV
	l6yTHbnJ7yGpjwGFNCEx4RodRVEm8BZQ=
X-Google-Smtp-Source: AGHT+IGtohjlndak90yy4W7vjFwKTM7hCbh0Fdev9jJNwVpjTD69zeC01lMCgHTMwIhSA/Lg9a4Vq45CQaANPDNjba0=
X-Received: by 2002:a05:600c:840f:b0:45d:dc10:a5ee with SMTP id
 5b1f17b1804b1-45dde20ee09mr137683985e9.15.1757501121122; Wed, 10 Sep 2025
 03:45:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CALXu0Ufzm66Ors3aBBrua0-8bvwqo-=RCmiK1yof9mMUxyEmCQ@mail.gmail.com>
 <CALXu0Ufgv7RK7gDOK53MJsD+7x4f0+BYYwo2xNXidigxLDeuMg@mail.gmail.com>
 <44250631-2b70-4ce8-b513-a632e70704ed@oracle.com> <aEZ3zza0AsDgjUKq@infradead.org>
 <e5e385fd-d58a-41c7-93d9-95ff727425dd@oracle.com> <aEfD3Gd0E8ykYNlL@infradead.org>
 <CALXu0UfgvZdrotUnyeS6F6qYSOspLg_xwVab8BBO6N3c9SFGfA@mail.gmail.com>
 <e1ca19a0-ab61-453f-9aea-ede6537ce9da@oracle.com> <CALXu0Uc9WGU8QfKwuLHMvNrq3oAftV+41K5vbGSkDrbXJftbPw@mail.gmail.com>
 <47ece316-6ca6-4d5d-9826-08bb793a7361@oracle.com>
In-Reply-To: <47ece316-6ca6-4d5d-9826-08bb793a7361@oracle.com>
From: Roland Mainz <roland.mainz@nrubsig.org>
Date: Wed, 10 Sep 2025 12:44:43 +0200
X-Gmail-Original-Message-ID: <CAKAoaQ=RNxx4RpjdjTVUKOa+mg-=bJqb3d1wtLKMFL-dDaXgCA@mail.gmail.com>
X-Gm-Features: AS18NWDtlBwRrOUwZmzN0EzHIi6df-up7-JLWJf7V4Ov3ArDNccLpkl055jV-Wk
Message-ID: <CAKAoaQ=RNxx4RpjdjTVUKOa+mg-=bJqb3d1wtLKMFL-dDaXgCA@mail.gmail.com>
Subject: Re: NFSv4.x export options to mark export as case-insensitive,
 case-preserving? Re: LInux NFSv4.1 client and server- case insensitive
 filesystems supported?
To: linux-fsdevel <linux-fsdevel@vger.kernel.org>, 
	Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 9, 2025 at 9:32=E2=80=AFPM Chuck Lever <chuck.lever@oracle.com>=
 wrote:
>
> On 9/9/25 12:33 PM, Cedric Blancher wrote:
> > On Tue, 9 Sept 2025 at 18:12, Chuck Lever <chuck.lever@oracle.com> wrot=
e:
> >>
> >> On 9/9/25 12:06 PM, Cedric Blancher wrote:
> >>> Due lack of a VFS interface and the urgend use case of needing to
> >>> export a case-insensitive filesystem via NFSv4.x, could we please get
> >>> two /etc/exports options, one setting the case-insensitive boolean
> >>> (true, false, get-default-from-fs) and one for case-preserving (true,
> >>> false, get-default-from-fs)?
> >>>
> >>> So far LInux nfsd does the WRONG thing here, and exports even
> >>> case-insensitive filesystems as case-sensitive. The Windows NFSv4.1
> >>> server does it correctly.
>
> As always, I encourage you to, first, prototype in NFSD the hard-coding
> of these settings as returned to NFS clients to see if that does what
> you really need with Linux-native file systems.

If Cedric wants just case-insensitive mounts for a Windows NFSv4
(Exceed, OpenText, ms-nfs41-client, ms-nfs42-client, ...), then the
only thing needed is ext4fs or NTFS in case-insensitive mode, and that
the Linux NFSv4.1 server sets FATTR4_WORD0_CASE_INSENSITIVE=3D=3Dtrue and
FATTR4_WORD0_CASE_PRESERVING=3D=3Dtrue (for FAT
FATTR4_WORD0_CASE_PRESERVING=3D=3Dfalse). Only applications using ADS
(Alternate Data Streams) will not work, because the Linux NFS server
does not support "OPENATTR"&co ops.

If Cedric wants Windows home dirs:
This is not working with the Linux NFSv4.1 server, because it must support:
- FATTR4_WORD1_SYSTEM
- FATTR4_WORD0_ARCHIVE
- FATTR4_WORD0_HIDDEN
- Full ACL support, the current draft POSIX-ACLs in Linux NFSv4.1
server&&{ ext4fs, btrfs, xfs etc. } causes malfunctions in the Windows
"New User" profile setup (and gets you a temporary profile in
C:\Users\*.temp+lots of warnings and a note to log out immediately
because your user profile dir has been "corrupted")

Windows home dirs with NFSv4 only work so far with the
Solaris&&Illumos NFS servers, and maybe the FreeBSD >=3D 14 NFS server
(not tested yet).

----

Bye,
Roland
--=20
  __ .  . __
 (o.\ \/ /.o) roland.mainz@nrubsig.org
  \__\/\/__/  MPEG specialist, C&&JAVA&&Sun&&Unix programmer
  /O /=3D=3D\ O\  TEL +49 641 3992797
 (;O/ \/ \O;)


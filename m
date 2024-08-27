Return-Path: <linux-fsdevel+bounces-27454-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 532FA961936
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Aug 2024 23:30:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 869E71C22D83
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Aug 2024 21:30:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9F3A1D4149;
	Tue, 27 Aug 2024 21:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sbj2Nwni"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 832EC481CD;
	Tue, 27 Aug 2024 21:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724794193; cv=none; b=WbGWqwXRRtmfR5/WkhltJMFwWKlYXkVjxpOP1VWP7hgQCz6nIRUv5g7lRLG6xnmRSZIB1bR+WT4aAqAsU23S3e0gEQuy6xOHlcdsOSApDykICvy5u1ymL7+SDylEULy+34xb02mFZPZSA0SgZfT2FA7zLBAarX9t0PjsTGA0f9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724794193; c=relaxed/simple;
	bh=d+yn0nkxzSuimP+TA4VAK1zkmLd8RAXtLCH9HszvZbs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dK1k1yt/uUOPEounG6h3hsRdvY1tTRvF3iwLVIAjtNt5h2beSCUfm5eSil8/u0h36hc7UgCzc9WPHldnymwJxgUw6/au3xqZ18qw9FZ745hfkdp5e6YQPQJH4GYIAfncpCCKTMek3u3W90yfKCxOM4mx1ZNhRIrjEKmqIos2frw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Sbj2Nwni; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-533496017f8so7974377e87.0;
        Tue, 27 Aug 2024 14:29:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724794190; x=1725398990; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d+yn0nkxzSuimP+TA4VAK1zkmLd8RAXtLCH9HszvZbs=;
        b=Sbj2NwniihelUq8zKM8FyTI2uCym5fkmKiARY9P4C3dBAkCncGpDizzw67x9hI+po8
         /40I4fr6ao3G60lke8HSIK2K5PJJRUYk7rjVIrPqOTRZt1LwGEQVmUqNgkm871vf241B
         QKOF3v7r0RHlEaOKol5SgxY8IO7DSp0LHdp/u9YuoQj9yClFIBp4TZ60EqKGO3XrKlWe
         pDqSVwzcY+Qehu3qEwtWOOZeJ7r5ciM4WOEXQmNhhH3Us28OzwSz1jw19/E/8xPJCW3p
         PQkaPzaarAZ5rDGUlR/taIec4enZvkSHzhnAKkS1FfkxtfTZ9MZR1xSVNIUDhGEjH+IL
         i2rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724794190; x=1725398990;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d+yn0nkxzSuimP+TA4VAK1zkmLd8RAXtLCH9HszvZbs=;
        b=BelUIXGRgRZSbFwItGB/K4swAH9CJHphYfM8Z8/ItXn48tIxIZq75vwT4oOrY2FBpF
         H+SI0LDx/7PyFZ4XZHo4GDarQnm7VAkvRGXwGpR+Iqp7hM0Fb+H+mPvQ/4aG2AheaDDu
         DL6UDG0iTtAu3M3WOUi7r8apFdh9rejCp1ASaXRoSLEZgu8GhlCugQZcUCHgPP8TC/pl
         m647XGEAcrvLGLZS/YcCKf93zApQFVy/2/cc4jc6b8TgcoLM84wo4+C8FQYXNZ4RELrJ
         Ud391H7g4MxCwIa48bNnjuiA9sUK684uecfAobEx+jWlyqKxc2+qsZKPd5GHmq/8cW35
         FIuw==
X-Forwarded-Encrypted: i=1; AJvYcCVNBdZDuhEOj+8oBgYqb1L9PeT5lYaNF0T7GWloDrY3behD7tBeUNO2JGEQ7roFsct1VScQB41q/9ytyQ==@vger.kernel.org, AJvYcCWsVR3C/IIAlXMn7ax6fGrGZr8raH9jNPSzh0/Met9DafCeEd9hoo7zPblZEeaK7AE/gnum3ejcxd+K@vger.kernel.org, AJvYcCX3xOo0rFad4HXL5uSt02xxK4gh+znU9XcVUNNgqjrV41kuYvAI2lFxTtv+Oo/szXSCvBpQtK+kNLIq4e2gfQ==@vger.kernel.org, AJvYcCX81jNXvpMktZwC/v8coiy9UGXyEkgNrQofI1sYIt4OVYce9uWHi561kFlqeRmGeNTLyzn+dBdZ9ieQ@vger.kernel.org, AJvYcCXY6W0vJPCiMlDeat2mrY6jxHIoOhUsF+YRUHcis1MYpToVlhgsRAnzPEY+5E83IiYSovv/7x+O@vger.kernel.org
X-Gm-Message-State: AOJu0YzCyoaji2s+3LrapigVMaby0EGRGzuyQInZ/phAIoVV7SvCwIcd
	qBi0J+oRIgvR1cD77sUoY7MhNt6BwwW5OrqMTipvIRgz6Y7FouWLx6nSxy+abhhF0uTNT8QUIA5
	jN/1A0waSk+WqhZSDzW6I7I9/2Uw=
X-Google-Smtp-Source: AGHT+IGMOY6Yiz4YkwEpjgWpibJQdtfTsGczDtl/VBKoJFb+V6GQ4EsLOSKLYsP/M6ZKPP5miCYIGAihYSQoDTyOxJw=
X-Received: by 2002:a05:6512:2386:b0:52c:df8c:72cc with SMTP id
 2adb3069b0e04-5343885f615mr9361153e87.43.1724794189192; Tue, 27 Aug 2024
 14:29:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240827143833.371588371@linuxfoundation.org> <20240827143836.571273512@linuxfoundation.org>
 <Zs4v6aV4-VpIqdfy@codewreck.org>
In-Reply-To: <Zs4v6aV4-VpIqdfy@codewreck.org>
From: Steve French <smfrench@gmail.com>
Date: Tue, 27 Aug 2024 16:29:38 -0500
Message-ID: <CAH2r5mtaz5NSzhvq0hyWJJVvYyk_h-LxW=Ku_YjwSEe49EDO7A@mail.gmail.com>
Subject: Re: [PATCH 6.10 083/273] 9p: Fix DIO read through netfs
To: Dominique Martinet <asmadeus@codewreck.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org, 
	patches@lists.linux.dev, David Howells <dhowells@redhat.com>, 
	Eric Van Hensbergen <ericvh@kernel.org>, Latchesar Ionkov <lucho@ionkov.net>, 
	Christian Schoenebeck <linux_oss@crudebyte.com>, Marc Dionne <marc.dionne@auristor.com>, 
	Ilya Dryomov <idryomov@gmail.com>, Steve French <sfrench@samba.org>, 
	Paulo Alcantara <pc@manguebit.com>, Trond Myklebust <trond.myklebust@hammerspace.com>, v9fs@lists.linux.dev, 
	linux-afs@lists.infradead.org, ceph-devel@vger.kernel.org, 
	linux-cifs@vger.kernel.org, linux-nfs@vger.kernel.org, netfs@lists.linux.dev, 
	linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>, 
	Sasha Levin <sashal@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

We are working through this regression with David this week -
hopefully will have more info in a few days

On Tue, Aug 27, 2024 at 2:59=E2=80=AFPM Dominique Martinet
<asmadeus@codewreck.org> wrote:
>
> Greg Kroah-Hartman wrote on Tue, Aug 27, 2024 at 04:36:47PM +0200:
> > From: Dominique Martinet <asmadeus@codewreck.org>
> >
> > [ Upstream commit e3786b29c54cdae3490b07180a54e2461f42144c ]
>
> As much as I'd like to have this in, it breaks cifs so please hold this
> patch until at least these two patches also get backported (I didn't
> actually test the fix so not sure which is needed, *probably*
> either/both):
> 950b03d0f66 ("netfs: Fix missing iterator reset on retry of short read")
> https://lore.kernel.org/r/20240823200819.532106-8-dhowells@redhat.com ("n=
etfs, cifs: Fix handling of short DIO read")
>
> For some reason the former got in master but the later wasn't despite
> having been sent together, I might have missed some mails and only the
> first might actually be required.. David, Steve please let us know if
> just the first is enough.
>
> Either way the 9p patch can wait a couple more weeks; stuck debian CI
> (9p) is bad but cifs corruptions are worse.
>
> Thanks,
> --
> Dominique
>


--=20
Thanks,

Steve


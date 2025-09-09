Return-Path: <linux-fsdevel+bounces-60696-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57796B50221
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Sep 2025 18:07:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CFF167A2E2D
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Sep 2025 16:05:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3183A3314D5;
	Tue,  9 Sep 2025 16:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="guFrApYH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21B552848BF;
	Tue,  9 Sep 2025 16:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757434018; cv=none; b=jC162/HDZ1VXHu/WhICQWhbVi+KRcM0C9Y2Z4F20QmTRXI3U4FY8XyuPkDmUw9noryMNf+BAdlLef/eqe/2OEYZ7TnntIZ4koH8HbZ8lFHmJK5pg9v0ekpciYH0M6iNZJ7SbOIvEoEZs63im6NXnvCkCHxMJqBoEIWc8FHslx70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757434018; c=relaxed/simple;
	bh=wIkdmEnDfRx16sGCzSDwh8nj6plf38nTLnEDgu5AfTs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XT8pqKmkhPzv+qFrLjEY+KlOvQhNkogzvLiLmH5GUImJXEVCxgPuqbyzq0EpdA6XPyE7hngrjTuEWRT5+2nqXdcNh3lHnaLcn7riYQDM+gFng1yQ//+hMX7gUKIYoe0oquC8jbnQkFwS8/g/ULPkSopY+5YsFaFK2wn+zXbcE0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=guFrApYH; arc=none smtp.client-ip=209.85.160.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-30cce86052cso4313249fac.1;
        Tue, 09 Sep 2025 09:06:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757434016; x=1758038816; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=UPutT1P8wArm+aybUvFWVUCh+4/82r9lCyk3RktDmIY=;
        b=guFrApYH0JZEyqCB2zFmm/rBVcuEWfyOhC2x2UOCmM4dCB4s6uH/MizLt+1+Pgc5UL
         lwxSS0b4VnWwmHgLGTlivGOePHh9ue14FlSFdWJoHRsvUd5xLYyh9avQnSdaj7r2d4iX
         ph++35+ya8FTd9hpKTSiabF0Eh9SvmY3YzMEkH/U14a/LjnFT5Sp7PHheN8y/xcaTe1G
         iqzLwub/chcMuwWA1P338ss8BS5BjsRmRXV327JUvQ/+ujAWjPT4M6XIYCMDH4jY8C/I
         w1i8p/mVqny50IjR/feU9c7AzVm3ZQ38uBk5t+gtHmr7XjMt8RpPVrgIVAfLQJJ/FMyx
         do9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757434016; x=1758038816;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UPutT1P8wArm+aybUvFWVUCh+4/82r9lCyk3RktDmIY=;
        b=sfClLBcugxaUs/RT4VgASSISI75hs5Vxy5CJ/3J3ES6IZuNhnDD26mFnO78U57aJjG
         GdD/UKlNI/Yb/1CiCWUNi3ajPy+aCpK94u4HJ+Lei6wlASMRq62/tZkBwNOgyUijxpnG
         fIZLFWVSUXl7e/McPdWeIP3pT7pfBMWRmgYbsFKveSExFyFPVorR+chYQr0ti3hBuRp2
         BnHRAWuI4YXjlJEzwAydLK/WYltIv2KEJOmU7j2J2naRA5ka7w3vRonSj3+nN+zeVOPK
         OAw4WKS0S2cLZOyBnFDWXtj2WrTg76gVj6AChg1xnWpr/Stf9b2uPBWUMEVTyNDBf1z+
         64zQ==
X-Forwarded-Encrypted: i=1; AJvYcCUIYsk6gGohTb7ac+Nwzx6fkmiwzMR7ri75kfbuOjIR/KTrc1ebws/Axjck33itR325W+c2/FA9tbY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJzGBgeogdVohIL36Z0EGWsjueKcwrU+l7G5iEdJcY3HB1YnWc
	342vREbHxXPgqfCC28X0tvzzkntLjm+cSpsDBtd2yztVfXCOEi8N8q1FUtz9qcBImiCz0/p8kfj
	EpayAPOxKOUwJ+uJHF1zfV7bkSllCX3lC2w==
X-Gm-Gg: ASbGncuGC/onhY9gsVIOZXQ190s699xoudp/DeIyO8/Ru5b7dGJQ0z98iwN2e+NVh8T
	ps9NFpt9AeFkHgP03xOf8AoEPVcfrVaXHytGhJ3CFNY4hrhUrMiqU6KgAOkdNoqk3Lfui1myNRt
	S/K2xIR+G1TPAHfoOABxbt9caUnWQGnMZz8mfY9zFeIdcSIxq8BWIlkOVru/vZvlDf65sobINu6
	l/NhRBTyzwIFr381g==
X-Google-Smtp-Source: AGHT+IFk+xgM75yWZWZ002wMMXrSwQ75GQ3PU/cFWEBaxM78xYxYXdpB7xgruwyALFUMF6anE46FAkSMFV8RwTnLYMI=
X-Received: by 2002:a05:6870:9713:b0:319:c3d3:21cb with SMTP id
 586e51a60fabf-32264c1b7e3mr5100889fac.28.1757434015701; Tue, 09 Sep 2025
 09:06:55 -0700 (PDT)
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
In-Reply-To: <aEfD3Gd0E8ykYNlL@infradead.org>
From: Cedric Blancher <cedric.blancher@gmail.com>
Date: Tue, 9 Sep 2025 18:06:19 +0200
X-Gm-Features: Ac12FXyXGqy4XKyMwl8Zkd8NP5hocByGJfYLqu8cG3cu_Oc_NvF1JlXDakmaKgU
Message-ID: <CALXu0UfgvZdrotUnyeS6F6qYSOspLg_xwVab8BBO6N3c9SFGfA@mail.gmail.com>
Subject: NFSv4.x export options to mark export as case-insensitive,
 case-preserving? Re: LInux NFSv4.1 client and server- case insensitive
 filesystems supported?
To: linux-fsdevel <linux-fsdevel@vger.kernel.org>, Christoph Hellwig <hch@infradead.org>
Cc: Chuck Lever <chuck.lever@oracle.com>, 
	Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Tue, 10 Jun 2025 at 07:34, Christoph Hellwig <hch@infradead.org> wrote:
>
> On Mon, Jun 09, 2025 at 10:16:24AM -0400, Chuck Lever wrote:
> > > Date:   Wed May 21 16:50:46 2008 +1000
> > >
> > >     dcache: Add case-insensitive support d_ci_add() routine
> >
> > My memory must be quite faulty then. I remember there being significant
> > controversy at the Park City LSF around some patches adding support for
> > case insensitivity. But so be it -- I must not have paid terribly close
> > attention due to lack of oxygen.
>
> Well, that is when the ext4 CI code landed, which added the unicode
> normalization, and with that another whole bunch of issues.

Well, no one likes the Han unification, and the mess the Unicode
consortium made from that,
But the Chinese are working on a replacement standard for Unicode, so
that will be a lot of FUN =:-)

> > > That being said no one ever intended any of these to be exported over
> > > NFS, and I also question the sanity of anyone wanting to use case
> > > insensitive file systems over NFS.
> >
> > My sense is that case insensitivity for NFS exports is for Windows-based
> > clients
>
> I still question the sanity of anyone using a Windows NFS client in
> general, but even more so on a case insensitive file system :)

Well, if you want one and the same homedir on both Linux and Windows,
then you have the option between the SMB/CIFS and the Windows NFSv4.2
driver (I'm not counting the Windows NFSv3 driver due lack of ACL
support).
Both, as of September 2025, work fine for us for production usage.

> > Does it, for example, make sense for NFSD to query the file system
> > on its case sensitivity when it prepares an NFSv3 PATHCONF response?
> > Or perhaps only for NFSv4, since NFSv4 pretends to have some recognition
> > of internationalized file names?
>
> Linus hates pathconf any anything like it with passion.  Altough we
> basically got it now with statx by tacking it onto a fast path
> interface instead, which he now obviously also hates.  But yes, nfsd
> not beeing able to query lots of attributes, including actual important
> ones is largely due to the lack of proper VFS interfaces.

What does Linus recommend as an alternative to pathconf()?

Also, AGAIN the question:
Due lack of a VFS interface and the urgend use case of needing to
export a case-insensitive filesystem via NFSv4.x, could we please get
two /etc/exports options, one setting the case-insensitive boolean
(true, false, get-default-from-fs) and one for case-preserving (true,
false, get-default-from-fs)?

So far LInux nfsd does the WRONG thing here, and exports even
case-insensitive filesystems as case-sensitive. The Windows NFSv4.1
server does it correctly.

Ced
-- 
Cedric Blancher <cedric.blancher@gmail.com>
[https://plus.google.com/u/0/+CedricBlancher/]
Institute Pasteur


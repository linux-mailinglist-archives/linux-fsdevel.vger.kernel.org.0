Return-Path: <linux-fsdevel+bounces-35243-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 87D939D2EDB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Nov 2024 20:31:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 418E41F23786
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Nov 2024 19:31:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96AB41D2B03;
	Tue, 19 Nov 2024 19:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b="XkGSJIoG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E6E01CCEF7
	for <linux-fsdevel@vger.kernel.org>; Tue, 19 Nov 2024 19:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732044651; cv=none; b=mXWA7iltNWsjKUyNa2HqCd/wD3byrriB3nUXgJRQ41qcCzd+NnQWAP8xr459+jUKnHgNPna8jMDGn2PSoEWUovaCwK+AfqSFp5oF7VbT6t9Cz102XAifDapVxmValp6T9+OdZyPh+1Krw+bYLWPSwYc8i9aBLaWVX6yyfO0lxBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732044651; c=relaxed/simple;
	bh=t+44uM9qtEpj71hEn5ZE2mVnJZcRXf7gUBZDpM/DYKI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gNkB1S6+lMpp9mgvzR/kP0AaawNEyJyS79JMwGePR69xVYv2lBFirggVHVhX7bb/VEmU0g7N5UJWu3DW9TfIX7sAW+fPn5Ohg+E8qjnMLPmUMfYco4AfH9b/0pbBiparfy+DMitr2t0ALK59VVz1Cw7vmM7j1mc3fU+PL7sPzDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b=XkGSJIoG; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-e3889bc7ec6so3137016276.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 19 Nov 2024 11:30:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen-com.20230601.gappssmtp.com; s=20230601; t=1732044648; x=1732649448; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ErTS0IiytaK2L1arGFQ99J+dEynjCDrSs7AnKL0EeSI=;
        b=XkGSJIoGgw6GuFJ3S3a8HmiaNZK0KWM9hSoUPzjOlwGDA4H1lgq4b6a5DEOsjfoBJ/
         PnFOLVsop8TAQznXFn7GV+EgT/J2PzzWnbOSmWJ2hE1TkjdsDd4iXuSLcUrdNJlJgqPc
         oaNvsQECv5orAC9hamXn8lnYBdWzIumMUsg432R4CwNhq1kiuVODVwH8M2JLtfh9f15O
         6gAc0jj/BHVGXfRUHFJA5uQvsQ3PA3/zVqiuGzOtvvlr/A0Tpw/4w8B95eZ++ZvqcI0O
         NwyDm1WP3Tfor2ttXYGx1MwM6qsFwlcolEfImFrA/mYV6gpOm9l7Wcv+nfCbHhenpPgC
         9/Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732044648; x=1732649448;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ErTS0IiytaK2L1arGFQ99J+dEynjCDrSs7AnKL0EeSI=;
        b=wrOucO8lx5NTVYfD0O2uXANho9ABngj9Ad6/2+7IaEbs+Syi3RmbOnZOIZUye7yKui
         sh584F1ZhbhNDIaGf1KxbO7+h4YDxuPA+pF5tVndmc9HpprNNyccrCHuZKKWX+JCIRKc
         3ZHMS1icbM7PXJaDUJ2dmOuZ3e/qzgip+00I/3icV3QlKtFE3Paybw1rlZnunYI8pCeR
         uPapzvQLvYHN+/cPylLqGwCXSXZbdonVM9vqX6UytGdDHnMruvcxmeZ64PQ8G3VHgvvJ
         suixtISj88XgP/h83wef5942pCu9vy2FDg6HwfGufJIxew95/K9BwFHVZ3RTJ7r52/wy
         ++Lw==
X-Forwarded-Encrypted: i=1; AJvYcCVPR+qD08LqJ4XXxkbsAB+8CXVD3KOgB9qHaUNH9un1nas10FT++FghIvfdlvjC2aWhhsQYSEYDUctZ6iTv@vger.kernel.org
X-Gm-Message-State: AOJu0YyTejg5TQTsE1Sz3zQDFvy/Nri+4YKwdjSIrcyvyp2B/jTl+uNK
	sEdKV6DxRDYJBTZxeNuVuQiEwQ+Ppx09EVsntGVk5bx5MfAln+Vj08t8kBSyRzHucRagVuxoQYH
	74eXlrmHw7yxaL4dFsb0vD88ycD+/y4yRR1WRbw==
X-Google-Smtp-Source: AGHT+IGeeI56h/sev1LuUuQX42ZZFRn2zwkBnX1+PaPri6U3dBBz6r4jAnu/fpiH2SeyIRClL3Q6/I20StkdogT6U+0=
X-Received: by 2002:a05:6902:10c3:b0:e38:c366:52b6 with SMTP id
 3f1490d57ef6-e38c3666028mr1691523276.23.1732044648351; Tue, 19 Nov 2024
 11:30:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241116175922.3265872-1-pasha.tatashin@soleen.com>
 <ZzuRSZc8HX9Zu0dE@google.com> <CA+CK2bAAigxUv=HGpxoV-PruN_AhisKW675SxuG_yVi+vNmfSQ@mail.gmail.com>
 <2024111938-anointer-kooky-d4f9@gregkh> <CA+CK2bD88y4wmmvzMCC5Zkp4DX5ZrxL+XEOX2v4UhBxet6nwSA@mail.gmail.com>
 <ZzzXqXGRlAwk-H2m@google.com>
In-Reply-To: <ZzzXqXGRlAwk-H2m@google.com>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Tue, 19 Nov 2024 14:30:10 -0500
Message-ID: <CA+CK2bD4zcXVATVhcUHBsA7Adtmh9LzCStWRDQyo_DsXxTOahA@mail.gmail.com>
Subject: Re: [RFCv1 0/6] Page Detective
To: Roman Gushchin <roman.gushchin@linux.dev>
Cc: Greg KH <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	cgroups@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	akpm@linux-foundation.org, corbet@lwn.net, derek.kiernan@amd.com, 
	dragan.cvetic@amd.com, arnd@arndb.de, viro@zeniv.linux.org.uk, 
	brauner@kernel.org, jack@suse.cz, tj@kernel.org, hannes@cmpxchg.org, 
	mhocko@kernel.org, shakeel.butt@linux.dev, muchun.song@linux.dev, 
	Liam.Howlett@oracle.com, lorenzo.stoakes@oracle.com, vbabka@suse.cz, 
	jannh@google.com, shuah@kernel.org, vegard.nossum@oracle.com, 
	vattunuru@marvell.com, schalla@marvell.com, david@redhat.com, 
	willy@infradead.org, osalvador@suse.de, usama.anjum@collabora.com, 
	andrii@kernel.org, ryan.roberts@arm.com, peterx@redhat.com, oleg@redhat.com, 
	tandersen@netflix.com, rientjes@google.com, gthelen@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 19, 2024 at 1:23=E2=80=AFPM Roman Gushchin <roman.gushchin@linu=
x.dev> wrote:
>
> On Tue, Nov 19, 2024 at 10:08:36AM -0500, Pasha Tatashin wrote:
> > On Mon, Nov 18, 2024 at 8:09=E2=80=AFPM Greg KH <gregkh@linuxfoundation=
.org> wrote:
> > >
> > > On Mon, Nov 18, 2024 at 05:08:42PM -0500, Pasha Tatashin wrote:
> > > > Additionally, using crash/drgn is not feasible for us at this time,=
 it
> > > > requires keeping external tools on our hosts, also it requires
> > > > approval and a security review for each script before deployment in
> > > > our fleet.
> > >
> > > So it's ok to add a totally insecure kernel feature to your fleet
> > > instead?  You might want to reconsider that policy decision :)
> >
> > Hi Greg,
> >
> > While some risk is inherent, we believe the potential for abuse here
> > is limited, especially given the existing  CAP_SYS_ADMIN requirement.
> > But, even with root access compromised, this tool presents a smaller
> > attack surface than alternatives like crash/drgn. It exposes less
> > sensitive information, unlike crash/drgn, which could potentially
> > allow reading all of kernel memory.
>
> The problem here is with using dmesg for output. No security-sensitive
> information should go there. Even exposing raw kernel pointers is not
> considered safe.

I am OK in writing the output to a debugfs file in the next version,
the only concern I have is that implies that dump_page() would need to
be basically duplicated, as it now outputs everything via printk's.


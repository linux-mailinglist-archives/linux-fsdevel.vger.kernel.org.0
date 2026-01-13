Return-Path: <linux-fsdevel+bounces-73475-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 8268CD1A65C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Jan 2026 17:49:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 25907300BBDF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Jan 2026 16:49:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA5CD34D923;
	Tue, 13 Jan 2026 16:49:41 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2473334D91B
	for <linux-fsdevel@vger.kernel.org>; Tue, 13 Jan 2026 16:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768322981; cv=none; b=QIJ+iAZvu3dlz4h8fdpr0kpW7Ec8NcN/2tfQbE/aUEIpB2dy4TnMQryGZ6j6uWH4YI6JkywIInTIExnf2WXQodao8qGYzn6UkwO7FVLWFxdKjxwbQ0HUGxqgaMYjbcVT7e7HeWjDMj6nFB8qMjyZH8JUuHFFtVUcn1Msg+2E1MM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768322981; c=relaxed/simple;
	bh=Hm+hFkCxE6lVbQx4eQObQxXAcvrq9lVQw90Wa4bRafg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RO2c/PJJtgFjsFMj+xwXmnSSAt0rOoEqScb8TePFwZWlFtDh8zUBAMwUc6mCTR6PMrPyHSGtkgqLlqsgBCxFXbJKEyO/Ca9ZU3vTiM42J2sHxo1lorE0VkuJ+VxE1mRp1RTxsDX0uQ6CfaHQ9HCPKBq7StTg0lAGhpjb9foWa0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gompa.dev; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.161.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gompa.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-65cfddebfd0so3849892eaf.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 13 Jan 2026 08:49:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768322979; x=1768927779;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gc7yqO7D0eseyKYDyefBFLldfXSHU35zlyHiXIvs8J4=;
        b=ZGsCgdQLsq83I6rUJgYj0cvHrEJZ4snd0+b4yLnARN9J2e/kRlrEpRoDBrBYuMb2rD
         vTnBpm0gD6JyJPYMm9me2lTvrxmLL+tOaoVlcrVicAPFcyGZthh2HuBMUYd3J6SenoHL
         tZ7tb3BXg9KJ7WHEXidfM4p429IL5kfbpadnDnKwAc4g5Ydj1c1liWO89oUaqnDXMWMo
         SDT0VTJqId5M1kJm+OVX6KB0QLjb5cYo1ac0aOA3mYcGAjSnKndSJ6W/o53ADSyXqnzP
         qpU8VRw/OfxPCZr9fizY5nMl2nfBDWe0MvmWDuPIcl8HV0N9fEzqjZErcda2Ua701reT
         5eRw==
X-Forwarded-Encrypted: i=1; AJvYcCX/X2c9xPvXnS6euPLZcpY4Rukv1WtszyGjTktSc7jD4ESC+a/Sf/N5zZhK5j5h0KPcjaEyLs38oZfcaBFt@vger.kernel.org
X-Gm-Message-State: AOJu0YyYGGgddFOc/DuTUuVS4bi3OGDM1/c0feu303KlHCqW8p2lUuCt
	1zxP5V9qGFZOFcvypTcaSVgyU/U08+dLP0vUCpejehqGNVg9JJazJvDIhCTzRQ==
X-Gm-Gg: AY/fxX6EIlbjSwL45Zb66uSpc7F/TVbkAcpKtENMPCnVH+6Mz//uAM5LX9Gvx/ZYYUI
	bHqkjAX/iVB4wyPGxPMaaPMuriDbp4UUlfkvHDqJvL+itEgnr2XWOylyldVJNnU8divpf/58byG
	oIud2sRGm0pT0wn7fFc9EK2OzQ4jrhADBRj6kv1ROzes7lGYUU2YO7hJV54TJrxB03RfmBDztrB
	2p+ZX5ejQBWUrqtsb7bjyWEw2eEqXcpCXCJHi9kDOKlrzTUH4kvyOZW5vQs+B1oGlAGxC0jiBBw
	22XoKz17stRPl+FWjXGRUyA2UTEtfV+YLaa7zZXFMbI5lJBrJfgxN19MnkssfEJ8sdqUDyFX/wL
	JXSEOdS1EkU7UkMK++IoznIaNIo8ocgS2JmcqlwJd2UQE4YMx6bkVYmyLo7/x9cGFXTrzF3PKnR
	9cYwo9p2NKOItHnXQoisVdyyjbZVDGoP0Q0n1R2DFBDlpteFETtibALkg352/MWTwfkTJvGhYO
X-Google-Smtp-Source: AGHT+IEhsK2R9lWpzOrO1R6xIHGUZ77OAsyNbG3bPdVgbQeOwHCjizVeNrBA5ZAyYlxD39CRmXwbVQ==
X-Received: by 2002:a05:6820:640e:b0:65d:697:3af2 with SMTP id 006d021491bc7-65f550c3360mr6891663eaf.78.1768322978862;
        Tue, 13 Jan 2026 08:49:38 -0800 (PST)
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com. [209.85.210.44])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-65f48cb1444sm8935033eaf.11.2026.01.13.08.49.38
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Jan 2026 08:49:38 -0800 (PST)
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-7cfb21a52a8so1492920a34.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 13 Jan 2026 08:49:38 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVPz+dR9kubuYTTIaKl6ZUU67sYYIyzHKDDcOk+46yT5uYltKPM4UO8BJWQk0LYVSO4ITktdXLwUu2OAUhz@vger.kernel.org
X-Received: by 2002:a05:6830:2e04:b0:7bb:7a28:51ba with SMTP id
 46e09a7af769-7ce50a6def5mr10521137a34.26.1768322616531; Tue, 13 Jan 2026
 08:43:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260112174629.3729358-1-cel@kernel.org> <20260112174629.3729358-9-cel@kernel.org>
 <20260113160223.GA15522@frogsfrogsfrogs>
In-Reply-To: <20260113160223.GA15522@frogsfrogsfrogs>
From: Neal Gompa <neal@gompa.dev>
Date: Tue, 13 Jan 2026 11:43:00 -0500
X-Gmail-Original-Message-ID: <CAEg-Je8LGZGGAQ3XLMQg8=XmJjvvJNShT3zkE-o2t2fv=VGeHw@mail.gmail.com>
X-Gm-Features: AZwV_QiAh8VN4kaDD2E2Q52MaqDS5cW88U1qWaL9kDfC-E_siYu-7adEi4A7eM4
Message-ID: <CAEg-Je8LGZGGAQ3XLMQg8=XmJjvvJNShT3zkE-o2t2fv=VGeHw@mail.gmail.com>
Subject: Re: [PATCH v3 08/16] xfs: Report case sensitivity in fileattr_get
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Chuck Lever <cel@kernel.org>, vira@web.codeaurora.org, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, 
	linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org, 
	linux-cifs@vger.kernel.org, linux-nfs@vger.kernel.org, 
	linux-f2fs-devel@lists.sourceforge.net, hirofumi@mail.parknet.co.jp, 
	linkinjeon@kernel.org, sj1557.seo@samsung.com, yuezhang.mo@sony.com, 
	almaz.alexandrovich@paragon-software.com, slava@dubeyko.com, 
	glaubitz@physik.fu-berlin.de, frank.li@vivo.com, tytso@mit.edu, 
	adilger.kernel@dilger.ca, cem@kernel.org, sfrench@samba.org, pc@manguebit.org, 
	ronniesahlberg@gmail.com, sprasad@microsoft.com, trondmy@kernel.org, 
	anna@kernel.org, jaegeuk@kernel.org, chao@kernel.org, hansg@kernel.org, 
	senozhatsky@chromium.org, Chuck Lever <chuck.lever@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 13, 2026 at 11:02=E2=80=AFAM Darrick J. Wong <djwong@kernel.org=
> wrote:
>
> On Mon, Jan 12, 2026 at 12:46:21PM -0500, Chuck Lever wrote:
> > From: Chuck Lever <chuck.lever@oracle.com>
> >
> > Upper layers such as NFSD need to query whether a filesystem is
> > case-sensitive. Populate the case_insensitive and case_preserving
> > fields in xfs_fileattr_get(). XFS always preserves case. XFS is
> > case-sensitive by default, but supports ASCII case-insensitive
> > lookups when formatted with the ASCIICI feature flag.
> >
> > Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
>
> Well as a pure binary statement of xfs' capabilities, this is correct so:
> Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
>
> [add ngompa]
>
> But the next obvious question I would have as a userspace programmer is
> "case insensitive how, exactly?", which was the topic of the previous
> revision.  Somewhere out there there's a program / emulation layer that
> will want to know the exact transformation when doing a non-memcmp
> lookup.  Probably Winderz casefolding has behaved differently every
> release since the start of NTFS, etc.
>

NTFS itself is case preserving and has a namespace for Win32k entries
(case-insensitive) and SFU/SUA/LXSS entries (case-sensitive). I'm not
entirely certain of the nature of *how* those entries are managed, but
I *believe* it's from the personalities themselves.

> I don't know how to solve that, other than the fs compiles its
> case-flattening code into a bpf program and exports that where someone
> can read() it and run/analyze/reverse engineer it.  But ugh, Linus is
> right that this area is a mess. :/
>

The biggie is that it has to be NLS aware. That's where it gets
complicated since there are different case rules for different
languages.



--=20
=E7=9C=9F=E5=AE=9F=E3=81=AF=E3=81=84=E3=81=A4=E3=82=82=E4=B8=80=E3=81=A4=EF=
=BC=81/ Always, there's only one truth!


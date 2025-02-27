Return-Path: <linux-fsdevel+bounces-42755-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 71F65A47E9E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Feb 2025 14:11:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 37E8D1894F10
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Feb 2025 13:11:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A5A72309A3;
	Thu, 27 Feb 2025 13:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ik45ItTZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3744D23098D;
	Thu, 27 Feb 2025 13:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740661852; cv=none; b=Ux/655nz5Q567BSLcbHkBaP4heLNO8fAswgEbz5yH/Pc5n5DfxH7DMo2V3GtERjRFp8M+pkyNZflJgolBFrlrshTmYTb8wMfVOdW3YtJPhpMNuQcjNbMT3lpzG2U+x8XOBhaPZy73r+QTPPvDotpfraC/Dq7sgWfblz3Y/i2x+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740661852; c=relaxed/simple;
	bh=R7d77jqG9e/8XY1dmND3/XwqRqPLt0jZTqvl1kbSiPk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X9ftY9CKIX/2ms5GK20NBRvrwFCtBrxcZUc3J3cO4SotA2Cjma46LoPa2zWeXtuCt/oannaCbZvYftMLk/3xIXyQgBUR1hDK3winES3TnpQWU5gwp8s2jfu8zPSrKuX67XIiITkB+wdAmg6qclhbd4Zc1+oRgZZwH6hHBjaCJvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ik45ItTZ; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2f83a8afcbbso1617608a91.1;
        Thu, 27 Feb 2025 05:10:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740661850; x=1741266650; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+tVwYL4Np1kVfEcbRLektY77Zj5aQ31EFMmxbuF/ZjY=;
        b=Ik45ItTZXJL1/NaKH4v9OvEnXbgUR/R2dddZYTkCHwT/Eik2oPd+TcGJjj/TgCYn5I
         O2stbHRCShSQYuiQtTfLg9tXSmtoT5LYfpgUTI30lwDc1J5RkkU9v/4kMpQ6UWhU/t22
         cIKqdHnbGpB0XRUBEiKQcqSls3jDXQeQROf0WWKTFrIN8oMFvIxTCR9e4KsvCVu4X2LY
         UV4HXR3njN4XNBUorWubtc+yzJR96DjeiGeg8itAkXf1U76JelAyuRLFmY8qt/DhzNy7
         FF8kJ9tuFnvGVdJicOAAZf0sbDuKON+9AqWV58pUa5s+sxhPSglsOdzYptsXEGgnUXBf
         797g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740661850; x=1741266650;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+tVwYL4Np1kVfEcbRLektY77Zj5aQ31EFMmxbuF/ZjY=;
        b=YhjucngUHcSajDUUmhzIYzYgaUkTK5Q5+hneBWpY8Px7azX3wl1h+ECoS+uimP9CIX
         tRepIV7k1UorAqMXkcKJqct9JGnH0sc7GucABqfrf/LC0USpyyzXlT6Q+M33AzgOmsXc
         BZ3cR5+dc/xZLtVXgy5Ghv9ntEbO7B5BuVbS27udBFqUN9OQQMKgcz1YlPUaervrLkRv
         3DPNIF7RCYCvLdv+sWr2hONxmJCArgeYB/20NmF8wyAk8c9Ccy3+stnMsZAacxDvD3Bw
         kZB7DQ9pTSYaMd+bJ256wpPFatdek3MDGAZ9OCpbotoWqfgr1BCJLkvAcsditCNBXh2s
         ac0g==
X-Forwarded-Encrypted: i=1; AJvYcCU+dTt8VBtL7eT6vzqAoBv4afBS8UVsJ6m8EKhjZUSj5zAymw+v26fXzI+tKzCfsiSUBnMrdCKSBkcC@vger.kernel.org, AJvYcCVh9ZZstjVib9M1YTtfxHDubn0/JYkK1ZTZ0+4NghNw95rChbZayOcmUJRfTlMI1Evohl6vBpg7Xb9eE+r8zQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzBBKsqB+tdPF0PycxZfR4Ipb8gjTaSpQhx8CGpByDWXa45XBxd
	w0U4pTnpQm8WuIah3JYp6WlbpUE9k2Eo5goaUPlSBoqjgeJZH5Yyu1+jZ0A6MwGOm3f2b58boPZ
	4rD0gyOMMa/44dIJhUGKSIqP3BSw=
X-Gm-Gg: ASbGncshdU12MUO83tIWMQ5SzZ2PESFQn6wiD1r3jqvAxQi6yrI2wn3dCSUcHTXaiIk
	sCXGo187AzBk2oURURoQe6XQDTCLikRw2XUt1kKrU8s3noGqotNODcKaEaXl9nBb7xkn9ecnrnk
	uFtIYWCdE=
X-Google-Smtp-Source: AGHT+IFM5uZOw0GvT13/qtPtQsPkK/C59n1CQJGq9bIDBlqTAVBKL82HPJpdk3b/ToG54Ur+HEgTcBwA570BrTg3jhw=
X-Received: by 2002:a17:90b:1ccd:b0:2fa:2133:bc87 with SMTP id
 98e67ed59e1d1-2fea12907f5mr5344384a91.6.1740661850388; Thu, 27 Feb 2025
 05:10:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <3148604.1740657480@warthog.procyon.org.uk> <20250227-halbsatz-halbzeit-b9f6be29c21c@brauner>
In-Reply-To: <20250227-halbsatz-halbzeit-b9f6be29c21c@brauner>
From: Ilya Dryomov <idryomov@gmail.com>
Date: Thu, 27 Feb 2025 14:10:38 +0100
X-Gm-Features: AQ5f1JpUn9OrSpymWhAR7U4p0G7MnKpv4DMvL1kdNmJhTN7vaSjgG-398-AvwP8
Message-ID: <CAOi1vP-5NLXpGrjjw6de-rP29ax8C7ct9srwPiwTk_VBQzkDuw@mail.gmail.com>
Subject: Re: Can you take ceph patches and ceph mm changes into the VFS tree?
To: Christian Brauner <brauner@kernel.org>
Cc: David Howells <dhowells@redhat.com>, Matthew Wilcox <willy@infradead.org>, 
	Viacheslav Dubeyko <slava@dubeyko.com>, ceph-devel@vger.kernel.org, amarkuze@redhat.com, 
	linux-fsdevel@vger.kernel.org, pdonnell@redhat.com, Slava.Dubeyko@ibm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 27, 2025 at 12:59=E2=80=AFPM Christian Brauner <brauner@kernel.=
org> wrote:
>
> On Thu, Feb 27, 2025 at 11:58:00AM +0000, David Howells wrote:
> > Hi Christian,
> >
> > Unless the ceph people would prefer to take them through the ceph tree,=
 can
> > you consider taking the following fixes:
> >
> >     https://lore.kernel.org/r/20250205000249.123054-1-slava@dubeyko.com=
/
> >
> > into the VFS tree and adding:
> >
> >     https://lore.kernel.org/r/20250217185119.430193-1-willy@infradead.o=
rg/
> >
> > on top of that.  Willy's patches are for the next merge window, but are
> > rebased on top of Viacheslav's patches.
> >
> > I have the patches here also:
> >
> >     https://web.git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-=
fs.git/log/?h=3Dceph-folio
>
> Sure! Thanks! I'll wait until tomorrow so people have time to reply.

No objection to taking Viacheslav's and Willy's patches through the VFS
tree given that there is a dependency and Willy wanted his 10/9 that is
strictly speaking outside of Ceph to go along.  It would be good if Alex
could review Viacheslav's series first though as it's a pretty sizeable
refactor.

Thanks,

                Ilya


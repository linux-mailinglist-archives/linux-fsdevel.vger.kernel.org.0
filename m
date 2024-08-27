Return-Path: <linux-fsdevel+bounces-27432-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F22FD961807
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Aug 2024 21:31:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 315371C21FB1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Aug 2024 19:31:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38DFE1CEAB1;
	Tue, 27 Aug 2024 19:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N7l5VMbC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 479E62E62B
	for <linux-fsdevel@vger.kernel.org>; Tue, 27 Aug 2024 19:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724787074; cv=none; b=HOO4C0DX8faLyLODblLp5g0CpfHgcf3ZgQnGqXIu8Xh8K2vYEO2zIxVzpgTwi4i/ctL+Jpwd+McREbem6i8w5IT42k0m2NvorBTUzuZoSZvEZXe4vd717H7RrhGl8v/kimPOuoz7alGPAmzxjj2dCbxTLDqh9gBS1c2XLmMZgv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724787074; c=relaxed/simple;
	bh=foYn+c8q8J4le64G+7M3aKwF3xnlncRl6q9HUHAkWgI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fV43+p70sf4IIBAXXYCEF8ocJk05XVVGDsXSy2RepHy8SsK1pv2hAZhJdWrBZ/lTpM5DfX/MtG5S/5qeYb7pIfhnKb1nnslgvjHd5ADaSupaEKBJDCtCezKG5+Bv6BUW57AJVXQu/T9kyT9pN5UWxyxybxTk+kmACrS8Wp40Kj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N7l5VMbC; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-20230059241so49449085ad.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 27 Aug 2024 12:31:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724787072; x=1725391872; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=foYn+c8q8J4le64G+7M3aKwF3xnlncRl6q9HUHAkWgI=;
        b=N7l5VMbCyB7BLitdygywzLQkHHXh3BxhHhRVrYkJQ8NP7wK7osEpmm6oDbpfHcDKix
         E3+LWpervTTR8o2UkfmTgQP6Z6KZkeY729ODFp/TN1RDsaKREBnDwTkvULm8MWzFzEFP
         ros+nUhOYEOOYKaZE4e3VzyHv7eSTKhOk4sD4JfjGTyDX70hkEjScb4xfG4TtSN2mExC
         ZDk70mjsy6C1muw4gVI0NwFY417ZG6bsQjO30dNwSIFt6Go/3tSRMicCDKyx2Y8hOmGd
         0juV5W1XP2cNs3BRuLW8P9qhlQuDf9PfXWqNkMLoV1Ls9NlZNoeNLB9uwo8+q5/ILRNq
         ZxKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724787072; x=1725391872;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=foYn+c8q8J4le64G+7M3aKwF3xnlncRl6q9HUHAkWgI=;
        b=tIUWmrpxqEoeJSJHu32Zzu9qq9Vgsh+tFlELp36hlPAHfD7TyQkezSnPJ1SZhba9wp
         5Jdr1UPsqABR7wjvei/s7Z9801rF038SJOqtxL3DjmL+fXS56opA34VNpjcIJHB/wzUp
         KDhiHqyYckFzfz+0/MP0PPSleMNUbv4ahThgWT8ZsM0RQ41qvQAmRfW5v04xYeNb55S1
         dvNYAu5hQNSAv1tblRFf0QJ3fujK9ol5uTCSsRzMP9yO73xBmiY5I1KIEyn6Se0SD1Ft
         TUr5mUujXJ+SjOCLQkN1cEHFSPa39D0hnhkc629CmYkvfuT5WNSAFUfFW7ckfQUv8Hlq
         hPew==
X-Gm-Message-State: AOJu0YyEZ7ZVDxgU36CMz8CCtMW4SqueE4n18OodcIZNupLKDLfL8Bf5
	IW2Zq0K8hxPvrFomXjgRBDu3DRONGmjfAsbaU9ZAoKl/9vWGM/iNMSIyqzvWYKVkPhlUYea8F8c
	WXsZfSnOyzTfEteXHgRfa7otQksM=
X-Google-Smtp-Source: AGHT+IFZ7VLlWZhb22peuxlqMhG+2csrEj1a4yZU70b1luclvMOGulVG4GGSZvom/fJknyGugJiSxllsHCDx9ogSLD4=
X-Received: by 2002:a17:90a:b00b:b0:2c9:6278:27c9 with SMTP id
 98e67ed59e1d1-2d646d5dc70mr14496757a91.38.1724787072362; Tue, 27 Aug 2024
 12:31:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAOw_e7bB3C_zbpq6U+FdrjbwJAOKFJk1ZLLETrR+5xqRmv44SQ@mail.gmail.com>
 <CAOQ4uxi=9WpKFb24=Hha_mwj9=bsj9qxiv0f0Z-FMfuBRCvdJA@mail.gmail.com>
 <CAOw_e7bMbwXzv00YeGw2NjGDfUpasaQix40iXC2EcLHk=n2wTA@mail.gmail.com> <CAOQ4uximem-HV4fCYPFMm9wANntKY4XjBGo8=y2zAMciq-5YOQ@mail.gmail.com>
In-Reply-To: <CAOQ4uximem-HV4fCYPFMm9wANntKY4XjBGo8=y2zAMciq-5YOQ@mail.gmail.com>
From: Han-Wen Nienhuys <hanwenn@gmail.com>
Date: Tue, 27 Aug 2024 21:31:01 +0200
Message-ID: <CAOw_e7aD1-9rYzJU5CYAcHgMe7eKqy52A2b+bmaDJHzQWOYJEA@mail.gmail.com>
Subject: Re: FUSE passthrough: fd lifetime?
To: Amir Goldstein <amir73il@gmail.com>
Cc: linux-fsdevel@vger.kernel.org, Miklos Szeredi <miklos@szeredi.hu>, 
	Bernd Schubert <bernd.schubert@fastmail.fm>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 27, 2024 at 7:34=E2=80=AFPM Amir Goldstein <amir73il@gmail.com>=
 wrote:
> > The most annoying part of the current functionality is the
> > CAP_SYS_ADMIN restriction; I am not sure everyone is prepared to run
> > their file systems as root. Could the ioctl check that the file was
> > opened as O_RDWR, and stop checking for root?
> >
>
> Donno. It's a challenge. Will need to think about it.

It looks like `struct file` has an owner field. Could the passthrough
always be allowed if the owner of the FUSE process is the owner of the
backing file? In most of my FUSE filesystems, the backing file is
typically created by the FUSE process (eg. by downloading something
from the internet).

--=20
Han-Wen Nienhuys - hanwenn@gmail.com - http://www.xs4all.nl/~hanwen


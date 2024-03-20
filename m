Return-Path: <linux-fsdevel+bounces-14925-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B4128818A4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Mar 2024 21:31:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C7D81C20F13
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Mar 2024 20:31:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B61923EA9C;
	Wed, 20 Mar 2024 20:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lkq/o/FI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC0A513AC0;
	Wed, 20 Mar 2024 20:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710966696; cv=none; b=njm4Vm8AOW2NO0+N+VKxcWk22/Sdby7WXWAGbRWqXRincpD0NtN7z1OIMHuhGaMaEmTRXfonPuplhapdLUNnlG5loqbdBMvXJV37QHKNFYQ7FtzrFLWOh4MpsRc+0DpKQgnvt9l0YqXpCBxKMyJ/7fUcx8OggumPdJtktvk9qOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710966696; c=relaxed/simple;
	bh=IHC7W0vdNvnZRFwRjzxwMFPPCAErFAkI/NZiAIwKitk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cpGrA773lRO8V/55lBIhI0srFdaXX9FJgkj+r1xo20U/ywHV3favmribuBI+xuCENp/vU47ubw3MbyvN/jH4sdLr7sizb/mh4jibQYY6XcRwdUR12eAvzlBYEC7/+y9v74V/mGZhC0F9YaQFz3QD0WAhwbwkdFOe2VsT27qk6qo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Lkq/o/FI; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-5ca29c131ebso160308a12.0;
        Wed, 20 Mar 2024 13:31:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710966694; x=1711571494; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MDxbUkBjk4CfBwXEKRf8dRtsz89f25MfMN5IRAlH4Dk=;
        b=Lkq/o/FIM/WWsO7QKxWAgfmonBg+XebnUi3fRremxiuU1z84Y0MJ9M8BwOq4zlnJZC
         Oh3G63Xvwqsu8ibftgvrnnEfeicmpK3ToRIWJVnWxtaf0NQQaJgmwzBsN9BwwU1mUrcK
         eYXRR+z1iPOj8Jo0nbfWc0DtY9RzZYwcM3eKDrkAL1vzPWjg1tXjW01nZw56LLwNoVfo
         DrHLIPpfipwaTBQJDAMsvqiZDCemwH67yeoQ1b2jtvyTIIvuiP8DuQLKwxDxdaegIL1h
         Vs4j3Vb6s8hnmfwk7RSyHIvQ8tyjKF3p1eR6K7Scua9AtpU7q/io28p67bEHnSa3vf0Z
         3IJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710966694; x=1711571494;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MDxbUkBjk4CfBwXEKRf8dRtsz89f25MfMN5IRAlH4Dk=;
        b=Kn75ThKJYMxkck4zPg+jVK468kzM52ZuLWKeRmrzMApvB7iWLWrrmX8Csgpa3HkR5d
         rBNcQDnEDoPz1nMZmWqxIVvuE1nxfK0PAB6y6m5Cg/yMK5G/hebtN+XSk3X9tudAGGg9
         OoUmPEtM4eTsQlOlE0zlZvE7HfcmWuY+wNgDQHIFidJAr3TY+8NrX9b8V6PGuk2a5yCz
         trLRGl7xtplyKAwSauxCqAKiSRceJorMgbtBGmUWewHXan8XXrY9tJ8F9CPII9zVtVgC
         hJOfcBBJapFaQv7oln79SimvgKeZVctf2Kz7untj04SYTKumlttSoScU7GvE5OOmX8uh
         gQqQ==
X-Forwarded-Encrypted: i=1; AJvYcCXHmc8kznWK4P7xpNXsgzauLAS1r4jSft/kmOZPSGulULXE/GPIxxcEeVzY3Me/67oKzoSBV7zmYGq7pDD+QuiXPc2ET9KQnUX8y4y8HocEK1YjDjZri/uQR4s8o3PBHBvCR1NGqQ==
X-Gm-Message-State: AOJu0YwSrSBQx+juxEnxusyzx+AKaGrfD64XAoqQtxWwpVS/wya3qMqF
	Tke6LNbFopJ9YkJZMTHjsk20ueQuMQtez8CJqZTS2n/8Aq6gcYm1xZdPNxfp68Cl5pude9Qpc7c
	IL0g584kWsNooWMNxFvTRhUlt62WoClaeqeI=
X-Google-Smtp-Source: AGHT+IHAab/9jqTa5zNphG2tQeRstGzN3AZLZGJkHzVD8WS1O1KnA51gP4O2XQ9c00tGS/TbRDfVXnZUvtDSfcj+l+I=
X-Received: by 2002:a17:90a:c24b:b0:29f:91bf:12f4 with SMTP id
 d11-20020a17090ac24b00b0029f91bf12f4mr3146775pjx.42.1710966693926; Wed, 20
 Mar 2024 13:31:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240320182607.1472887-1-jcmvbkbc@gmail.com> <Zfs5KTgGnetmg1we@casper.infradead.org>
In-Reply-To: <Zfs5KTgGnetmg1we@casper.infradead.org>
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Wed, 20 Mar 2024 13:31:22 -0700
Message-ID: <CAMo8BfJOzPbiOz59kmFuD_4Hkxm50gEujyFYjW2ANqzZNviUGg@mail.gmail.com>
Subject: Re: [PATCH] exec: fix linux_binprm::exec in transfer_args_to_stack()
To: Matthew Wilcox <willy@infradead.org>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-fsdevel@vger.kernel.org, Eric Biederman <ebiederm@xmission.com>, 
	Kees Cook <keescook@chromium.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Rich Felker <dalias@libc.org>, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 20, 2024 at 12:29=E2=80=AFPM Matthew Wilcox <willy@infradead.or=
g> wrote:
>
> On Wed, Mar 20, 2024 at 11:26:07AM -0700, Max Filippov wrote:
> > In NUMMU kernel the value of linux_binprm::p is the offset inside the
> > temporary program arguments array maintained in separate pages in the
> > linux_binprm::page. linux_binprm::exec being a copy of linux_binprm::p
> > thus must be adjusted when that array is copied to the user stack.
> > Without that adjustment the value passed by the NOMMU kernel to the ELF
> > program in the AT_EXECFN entry of the aux array doesn't make any sense
> > and it may break programs that try to access memory pointed to by that
> > entry.
> >
> > Adjust linux_binprm::exec before the successful return from the
> > transfer_args_to_stack().
>
> Do you know which commit broke this, ie how far back should this be
> backported?  Or has it always been broken?

From reading the code I see that linux_binprm::p started being an offset
in the commit b6a2fea39318 ("mm: variable length argument support")
which is v2.6.22-3328-gb6a2fea39318 and filling in the AT_EXECFN
aux entry was added in the commit
 5edc2a5123a7 ("binfmt_elf_fdpic: wire up AT_EXECFD, AT_EXECFN, AT_SECURE")
which is v2.6.27-4641-g5edc2a5123a7. I don't see any translation
of the linux_binprm::exec at that time so to me it looks like it's always
been broken.

--
Thanks.
-- Max


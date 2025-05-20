Return-Path: <linux-fsdevel+bounces-49536-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F00C4ABE17B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 May 2025 19:05:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 314021BA75D9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 May 2025 17:05:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE1CE27AC48;
	Tue, 20 May 2025 17:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dgMzRogV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8639A1DB356;
	Tue, 20 May 2025 17:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747760705; cv=none; b=pBbvhr8g/P3Ttkk1C5KALVhOukfJkq6dLYvPyb9FsiE4fYHSmRU2w1DFKA/v5XloK/xj+e1Zt5cbIx1d3YoX9ioaZbB9wXBd8zDkyPr86mFk4csPRuktuHFJKqOk2Tyy8TQeOLnhYlf9oKuSYLKxytNWdnt0lrhydpVpyn+eRnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747760705; c=relaxed/simple;
	bh=vFLiIsSNJ+9LKlajAAEpNZdNi9SUrHki3vkFk8ViS1Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FS+fnhxLfcrl6WpJeFJJ9fGsOP2e6KN9JWfOmEIZGemwAQ0a50ceHqJYFyteT+9YqLl5WPJeapmn0e4VBJnwSdzV3gG3Pwlj8rPpsfpJcvE4s2C6ys35EgNbUATB9D8icJaqYA5ERYZa/DKKgummCIyumCagF/u+jrE0vJ8JEkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dgMzRogV; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3a363d15c64so2614289f8f.3;
        Tue, 20 May 2025 10:05:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747760702; x=1748365502; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aqfARpqDXwP7K8PtF8oJFF7SVaV8Ol18I4Q0qiBvla0=;
        b=dgMzRogVkdSqrzUfFVhaKOjpnjUn03S+p3KU9ktSLH2gr9j3WvwH8AlHxj8fkWkTJP
         /yASvEFQaXtVqWe5GmdtZlPKK596Z5u3zUIc1ZrWLP69PHPEBOemecMYsr8Myjx5KZ9F
         QLO0R3GVxpRSkh8IgaZO7cjdDvOp0y1Qf0uWYDkznzyhhDnh7QAS9ozs56trYMBf3jJ6
         gDhaplQ4hHEBQ87zP59EDo6GUyBtiiBt1LGZznu5/9jcuB+5ZcBtY3Xd8PGCVME0mwD5
         DItjiAjLF6cJlY0ZesqgCQXLhPxPJEK4FcIKnBG1hkG/5Ws4rFNOnOTEeTarHFhAaWB7
         vS2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747760702; x=1748365502;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aqfARpqDXwP7K8PtF8oJFF7SVaV8Ol18I4Q0qiBvla0=;
        b=ptFnBCBCFe1qOtOzg6U8zPE6Xxrxmo1sneXThX9cZk3586c65CODgXXzNh4LjZa3G1
         y1TWp+yUXsjBo1tmv0uH39nam74G9sK3eBfQE8cxalIwXZ6rVFJoGJE8i7tcgJnhLTHk
         IzH/EYKid8dYL9TTnaMPdfWrwOuPfCYjASOT8smZ+1wLNit8nLK0T+TB8YG0v0XprhmJ
         D2XuFiUqDfo3u7fVSNuPbkWyiwi9JSwHYwsyD0Usq3o+a0DtSGS1Gi8P1KgqyEpaUDAZ
         Z+GquQp1jk++Ft+KNcwcKbcm0EGoJRbEFTEsv7HXTMv/dNQNk/RA/t5KE5M1eyoKbjJu
         HJvQ==
X-Forwarded-Encrypted: i=1; AJvYcCUS4gycfSkMqkvs/SxO/atcrYrGWCDF18hp+gA3ISf/nCyC9jWGRiHc0DlWNKoS/med6hBUG2AUC2DF6Y5B@vger.kernel.org, AJvYcCVcrBID5cIeYYsfUit3PD2y7vQ8lV3A0EQYUA0XzOBgou2/6RsA/v5KUZVBaXBUr+moPryurWkAACwSddqqsg==@vger.kernel.org, AJvYcCVphUN+T+Pn5S49LFyniN+mFgDwsErUzRF3Qz9YYzpZPn8gHbIAIdeQzFWMzTf2yrWQU5s=@vger.kernel.org
X-Gm-Message-State: AOJu0YwzkhO5UYqM18z/bGg42xVm67HalToIGlqwjZ78V2AByA8IyJNS
	iOgGVcyo6aiE2RiQ/CvoRRpudcF7V3UqwNypK/WdOVGYj0K8k8xFaTTcAunAzfLuCg5GwlbnJX5
	webrUdcJ/5ND+bElG8Pdy1zL022g88SE=
X-Gm-Gg: ASbGncsBB8Rur02Gdzd6vGiGiJKWPsExJZil8Js2U/YJ1dQxuF05TkTxH3+cSEo0ilp
	W7nKBthKeh+f/YSf4Ovfdgjf8neIQjbVHSg1JUtizxhly+bY6MpZIh3X0Z0TTfXukCsOKawVjTL
	WUJAtpgF0qYFRnlCaoBdPgwahgZ8Mw6g7dQR+LMEk7QGEC960H
X-Google-Smtp-Source: AGHT+IGoHLX8QBms8mFGB0R5FHXi2uOVwvd1emWDAK8vRyQoBWvaR0hqtnNxbsErK6XMC7RZZfSN4YoOe9vSv2a/T88=
X-Received: by 2002:a5d:5f8d:0:b0:3a3:5b90:5f38 with SMTP id
 ffacd0b85a97d-3a35c7dd76emr15608680f8f.0.1747760701511; Tue, 20 May 2025
 10:05:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250520064707.31135-1-yangtiezhu@loongson.cn> <20250520082258.GC2023217@ZenIV>
In-Reply-To: <20250520082258.GC2023217@ZenIV>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 20 May 2025 10:04:49 -0700
X-Gm-Features: AX0GCFv2NKgzITaEikgjd3zpHj5FtmD5LjKgXj0aULr_MuBKSBnhhz5OfeXNA34
Message-ID: <CAADnVQJW+qyq9wPD6RdoaZ8nLYX8N2+4Bhxyd19h6pdqNRMc3A@mail.gmail.com>
Subject: Re: [PATCH] dcache: Define DNAME_INLINE_LEN as a number directly
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Tiezhu Yang <yangtiezhu@loongson.cn>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Linux-Fsdevel <linux-fsdevel@vger.kernel.org>, bpf <bpf@vger.kernel.org>, 
	loongarch@lists.linux.dev, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 20, 2025 at 1:23=E2=80=AFAM Al Viro <viro@zeniv.linux.org.uk> w=
rote:
>
> On Tue, May 20, 2025 at 02:47:07PM +0800, Tiezhu Yang wrote:
> > When executing the bcc script, there exists the following error
> > on LoongArch and x86_64:
>
> NOTABUG.  You can't require array sizes to contain no arithmetics,
> including sizeof().  Well, you can, but don't expect your requests
> to be satisfied.
>
> > How to reproduce:
> >
> > git clone https://github.com/iovisor/bcc.git
> > mkdir bcc/build; cd bcc/build
> > cmake ..
> > make
> > sudo make install
> > sudo /usr/share/bcc/tools/filetop
>
> So fix the script.  Or report it to whoever wrote it, if it's
> not yours.

+1

> I'm sorry, but we are NOT going to accomodate random parsers
> poking inside the kernel-internal headers and failing to
> actually parse the language they are written in.
>
> If you want to exfiltrate a constant, do what e.g. asm-offsets is
> doing.  Take a look at e.g.  arch/loongarch/kernel/asm-offsets.c
> and check what ends up in include/generated/asm-offsets.h - the
> latter is entirely produced out of the former.
>
> The trick is to have inline asm that would spew a recognizable
> line when compiled into assembler, with the value(s) you want
> substituted into it.  See include/linux/kbuild.h for the macros.
>
> Then you pick these lines out of generated your_file.s - no need
> to use python, sed(1) will do just fine.  See filechk_offsets in
> scripts/Makefile.lib for that part.

None of it is necessary.

Tiezhu,

bcc's tools/filetop.py is really old and obsolete.
It's not worth fixing. I'd delete it.
Use bcc's libbpf-tools/filetop instead.


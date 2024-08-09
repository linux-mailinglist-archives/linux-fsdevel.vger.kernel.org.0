Return-Path: <linux-fsdevel+bounces-25539-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BED6494D30D
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Aug 2024 17:13:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F17711C21452
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Aug 2024 15:13:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FF32198833;
	Fri,  9 Aug 2024 15:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="MmvztOTd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FC1A197A8B
	for <linux-fsdevel@vger.kernel.org>; Fri,  9 Aug 2024 15:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723216410; cv=none; b=XTFgTe+G6UNNyI+PmjPKbGl7UHdp+2YYROKutKrS4OMt8jYoexTNpL8xv9tSBlPlElGI4fGkgIiMZ9NJFcF4OKrniphrWkcdrzpMsaZt8qhjhTFh72lqfN77Uoc/wHqRQ8izvT2BTrrUosYTmfOEeU3XqouaFe7o/wI4fB/N3hI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723216410; c=relaxed/simple;
	bh=zjn3YmKXlPxzbD8VKXj7SB08Iibw46diwUCwOIFAoyo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QCSwaRhkhECSxZX4UO2xYqRHoIMGux/PdceJc0lLncvYpWhdZmLtTt6JWMoDa8BWAh1joqwnG/yL+gC9I+yhj7NBc11aVRsjUia6jMm+veRl2sUFOyG5/QFQFYzgzudN/tJmH8TtBG0M0iH1BZ6IFFcz39G77qwro3djxl5lR3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=MmvztOTd; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5b8c2a6135dso2788706a12.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 09 Aug 2024 08:13:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1723216406; x=1723821206; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=SQb4P6KW7DwW15iPQt+xRBs0vTrFbvLGmJcOvQXiPP0=;
        b=MmvztOTdzxx98OeVNk5YcLW8VIgx4wN0hLJynOMaGsPqpCzQSv+xb3yPwvN52p8kfv
         XOxRdO71eC1rP5n7JLPUj6OkHJ9xiZJUWBjQXJM08ChRJk679stOD/iIuhCWsF+VSaak
         1k9QgzbqRk3Aw6bESUltbXb8OpiJDFtVqd2wc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723216406; x=1723821206;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SQb4P6KW7DwW15iPQt+xRBs0vTrFbvLGmJcOvQXiPP0=;
        b=PFcm/clofah9gxo/ht1ImLOKeAiAEORWlwPDNtXyUsbbo7UaaWwM/+4cgRGuJ8VadE
         Q3RIeMgO7+QTUxnMy6ZXEN4/wQc5d5SO0Y8wxATC84EalqPkl/PAxt5Uv8CfFf37ORqk
         Sw0tEJ386iy7Di8aMuCLyJLs2v0mHhabnUlIAGCVuLggILrkcyFfMCqYZtM2B0eCV8A0
         XQCNoBrP6FT3AVYILbEhLVnRhRGZ8/by0ls7Tz3cNGjFEyYB6ydPMpVuHunL0UENPlc8
         btrgaoawWJSil5DUXk0mIWYqUy+uDZcIUU33gKbbBZpZD0Je/NFO9ngBkeG4MqjZdh3i
         y/IQ==
X-Forwarded-Encrypted: i=1; AJvYcCU2PohZDJ1RDkDZuvOTWXgwHKopm1Yq0pTHa5NAMsOJWLlSyKCF4xRbauA5NhSPn4X/LOhRjLABiaVxWXPyKc8jCCZMgudMYU+NpcIfBw==
X-Gm-Message-State: AOJu0Yz3lrio7Sk0WL0SdladLVAJNwhp8LxaMTjTqK7mRtWnQrvqZFkQ
	cCmpAqdrd+S5n856VYUl5naZzJ03DToW3r5Cs7Q8YjKoa+Bzc+vNqgmtw+iUJE2z6FWkQ8TxYrs
	gviTk5A==
X-Google-Smtp-Source: AGHT+IGITYXrfFGXqq49qe/57tHiXlBNiHSgjLrKH510SFvslzdFKSOKyyeDiYdPR8I1Ncj28Q40Aw==
X-Received: by 2002:a05:6402:13d2:b0:5a1:f9bc:7f17 with SMTP id 4fb4d7f45d1cf-5bd0a50e1a4mr1581421a12.5.1723216406376;
        Fri, 09 Aug 2024 08:13:26 -0700 (PDT)
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com. [209.85.218.53])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5bbb2bf96f5sm1613624a12.14.2024.08.09.08.13.25
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Aug 2024 08:13:25 -0700 (PDT)
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a7b2dbd81e3so289961666b.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 09 Aug 2024 08:13:25 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXwDVMnXF5paHmQmBnnuqgL69P3DlLdsdL+tGtwDdxTzWDN9k0aQ8FFZlcIHDOGd+Gb/uS4Veu7r3BBMp33Msfps5mzHBhBrTeCXsP+hw==
X-Received: by 2002:a17:907:7e92:b0:a7a:ab8a:391 with SMTP id
 a640c23a62f3a-a80aa65c854mr137777266b.45.1723216405166; Fri, 09 Aug 2024
 08:13:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <036CD6AE-C560-4FC7-9B02-ADD08E380DC9@juniper.net>
 <CAHk-=wh_P7UR6RiYmgBDQ4L-kgmmLMziGarLsx_0bUn5vYTJUw@mail.gmail.com> <875xs93glh.fsf@email.froward.int.ebiederm.org>
In-Reply-To: <875xs93glh.fsf@email.froward.int.ebiederm.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 9 Aug 2024 08:13:09 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj+buZ5Efw4so9FbaJ5Q=xLr0+bcYDafouehVG93Msd7w@mail.gmail.com>
Message-ID: <CAHk-=wj+buZ5Efw4so9FbaJ5Q=xLr0+bcYDafouehVG93Msd7w@mail.gmail.com>
Subject: Re: [PATCH v3] binfmt_elf: Dump smaller VMAs first in ELF cores
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Brian Mak <makb@juniper.net>, Kees Cook <kees@kernel.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Oleg Nesterov <oleg@redhat.com>
Content-Type: text/plain; charset="UTF-8"

On Fri, 9 Aug 2024 at 07:40, Eric W. Biederman <ebiederm@xmission.com> wrote:
>
> I asked him to perform this at snapshot time.  Plus it is obvious at
> snapshot time that you can change the allocated array, while it is
> not so obvious in the ->core_dump methods.

Fair enough. The days when we supported a.out dumps are obviously long
long gone, and aren't coming back.

So I am not adamant that it has to be done in the dumper, and I
probably just have that historical "we have multiple different dumpers
with different rules" mindset that isn't really relevant any more.

> I would argue that the long term maintainable thing to do is to
> merge elf_core_dump and elf_fdpic_core_dump and put all of the code
> in fs/coredump.c

I wouldn't object. It's not like there's any foreseeable new core dump
format that we'd expect, and the indirection makes the code flow
harder to follow.

Not that most people look at this code a lot.

             Linus


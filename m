Return-Path: <linux-fsdevel+bounces-24644-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 548C9942362
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Jul 2024 01:19:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F3681F249B0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jul 2024 23:19:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D2941940A2;
	Tue, 30 Jul 2024 23:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="LUyH/i+4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F366D1922DD
	for <linux-fsdevel@vger.kernel.org>; Tue, 30 Jul 2024 23:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722381534; cv=none; b=ZZzyRx7Fjs3VsutzPQyv+Ecf0XNTpJXCRg0L4h0l2fSBahCgGpN9LOeZFD8QrZNi51MdIOMWUVFQdfvKdwe3ex7XigjSaqBzdyOgQY3iRM3oYtX68Sn2FfeM25d67pp5ADGgDpUEMPl70RaPheCRot0ViuL9+0paCZwbgtlhS3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722381534; c=relaxed/simple;
	bh=L0PFJlPNg2nSFAwbo1MUufU0ZJpnKOJlq9Zz7UzENlo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N4vipWR8BDcLYHr/CBZo0kxOIE/ZkAJ5XsQMPWdXD2ceapmjDLZkRAiCtCpL6AT8YFr1dDVLBh4601y09h32TT26otd5hTX538kUiWA3FJZf3kM+TEgXeQ9jwH4vfg+HwOHwYc2NU3BMBukfiuBj/9Bh9j8txKDvNfb+wBdcPQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=LUyH/i+4; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-52efc89dbedso6530948e87.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 30 Jul 2024 16:18:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1722381531; x=1722986331; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=w4KvUDxCv3JZzkJ14qFXFaCRicGT3v3Xu0J6Fixv6r8=;
        b=LUyH/i+4jDT5bE4URJyTFujqpAZxmWvwf/xO57JopMjanlblkfWQTssjMnjHklDkEp
         seDlFF3A/f+EpadRHhLdClF69n5TG/Inkr6x0JNLV5WwPytpKP9NtH5rv7NeJd9L/ROZ
         9h81OFdMh05qQpkjOJ8e4/jGCCebIZEsEDWtk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722381531; x=1722986331;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=w4KvUDxCv3JZzkJ14qFXFaCRicGT3v3Xu0J6Fixv6r8=;
        b=HyuVN/kODsS548hX/QJpYfdLOfK+tfOMZlXE+gAxYY8u1HJqYmgurl2t+u2VkmMXgw
         08GcetAgoDzoF8U1dsUNZBb+Njl6rcz0QjPO79671B4397SVH4qwiToy63gpRUAQ7eB0
         t3c451o6mKRRGzlesvkrT33wC/DZNiGCE7qtjOPgUp5o+LOx6n8Y6kJmYNYj9Fbd6tTq
         On5Z2zkD1sV0jP+UEIe69c2ikbEjyR88xSvU7r/yE5AUnkfA/RSRMJzc1FYVN5MQvlr+
         WIKBYlq2eNGhd4ULCV1eumqxw//FTAYIu/6xuKpC6ewB2mTmnO2wd1YsHwUNVc4Vppoq
         ozFQ==
X-Forwarded-Encrypted: i=1; AJvYcCVjuYyShjGkPHva9BMgUQsauw3CVgrscxBAbDs4AOgOWm8nRGvOdAFbjxPbSL0cHwYpwHRyfdEBHIKNBiHdtKEEMd298ex+iNFnEZ/Paw==
X-Gm-Message-State: AOJu0YzeeWD1ErEAKSQW/yCtpK2Ed+BdXuKhLTx3f67GocXbL4USHGeA
	2q8IRDIVNLHngd5x+R64KOLR98zftglAAItpNZ3UaNnuDbC3F33cAyyoVCApS5aBoI0Mi5CY5gh
	A3xG31A==
X-Google-Smtp-Source: AGHT+IEPi8Saeqg5aKW9z3h+7nY1XSm5d5Hfnxsi+AJalm2YV3p9V74+77zpo5dRkJL2jkb7RYaJSQ==
X-Received: by 2002:a2e:9845:0:b0:2ef:2006:bfb1 with SMTP id 38308e7fff4ca-2f12ee06661mr85238951fa.15.1722381530780;
        Tue, 30 Jul 2024 16:18:50 -0700 (PDT)
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com. [209.85.208.45])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5ac631b038asm7865147a12.14.2024.07.30.16.18.49
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jul 2024 16:18:49 -0700 (PDT)
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5a20de39cfbso6971913a12.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 30 Jul 2024 16:18:49 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWCAb1B9KskLAAOYFWvoc/xjnds7p9ef/w5C/1hZCgtlaHCX7ITxJgW2Z3xtK03qHiCUZXiz809Nq0ilFgo0ujEINd5bITzUaF0iB9YHw==
X-Received: by 2002:a05:6402:430d:b0:5a3:3cfd:26f7 with SMTP id
 4fb4d7f45d1cf-5b022a95ad0mr9903249a12.32.1722381529467; Tue, 30 Jul 2024
 16:18:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240730132528.1143520-1-adrian.ratiu@collabora.com> <CALmYWFumfPxoEE-jJEadnep=38edT7KZaY7KO9HLod=tdsOG=w@mail.gmail.com>
In-Reply-To: <CALmYWFumfPxoEE-jJEadnep=38edT7KZaY7KO9HLod=tdsOG=w@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 30 Jul 2024 16:18:32 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiAzuaVxhHUg2De3yWG5fgcZpCFKJptDXYdcgF-uRru4w@mail.gmail.com>
Message-ID: <CAHk-=wiAzuaVxhHUg2De3yWG5fgcZpCFKJptDXYdcgF-uRru4w@mail.gmail.com>
Subject: Re: [PATCH v4] proc: add config & param to block forcing mem writes
To: Jeff Xu <jeffxu@google.com>
Cc: Adrian Ratiu <adrian.ratiu@collabora.com>, linux-fsdevel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org, kernel@collabora.com, gbiv@google.com, 
	inglorion@google.com, ajordanr@google.com, 
	Doug Anderson <dianders@chromium.org>, Jann Horn <jannh@google.com>, Kees Cook <kees@kernel.org>, 
	Ard Biesheuvel <ardb@kernel.org>, Christian Brauner <brauner@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Tue, 30 Jul 2024 at 16:09, Jeff Xu <jeffxu@google.com> wrote:
>
> > +               task = get_proc_task(file_inode(file));
> > +               if (task) {
> > +                       ptrace_active = task->ptrace && task->mm == mm && task->parent == current;
>
> Do we need to call "read_lock(&tasklist_lock);" ?
> see comments in ptrace_check_attach() of  kernel/ptrace.c

Well, technically I guess the tasklist_lock should be taken.

Practically speaking, maybe just using READ_ONCE() for these fields
would really be sufficient.

Yes, it could "race" with the task exiting or just detaching, but the
logic would basically be "at one point we were tracing it", and since
this fundamentally a "one-point" situation (with the actual _accesses_
happening later anyway), logically that should be sufficient.

I mean - none of this is about "permissions" per se. We actually did
the proper *permission* check at open() time regardless of all this
code. This is more of a further tightening of the rules (ie it has
gone from "are we allowed to ptrace" to "are we actually actively
ptracing".

I suspect that the main difference between the two situations is
probably (a) one extra step required and (b) whatever extra system
call security things people might have which may disable an actual
ptrace() or whatever..

              Linus


Return-Path: <linux-fsdevel+bounces-23053-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EA1939266D4
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jul 2024 19:10:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1917D1C23DDE
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jul 2024 17:10:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04B341836EC;
	Wed,  3 Jul 2024 17:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="NbBCcupb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C54B18412E
	for <linux-fsdevel@vger.kernel.org>; Wed,  3 Jul 2024 17:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720026576; cv=none; b=g/JIwwuSRb4gzghZnHi1bi5UqcMMnkCY4KrhLEs2MYx3H+GZeZw1Z2JpzGbTKu9/wfZ0ASLG9jLM2Am1CHXer1fzj3b/nPtZ9eWAcrVWaTGP/hj/wqg1bxpOPzL/jIRvdc56+W6FEwqz+uTWn/nFVJJfjWtJ5M7JRZh7oRtCiPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720026576; c=relaxed/simple;
	bh=uRU/MzlOzw7CmWbyItl0EyiCdZwjkjyxkrbpjs0FjXU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OEVAQUDnFgbIlz8QWcChgKExDY8qnWnSfjh39fnhaKlps6tvrA2lsttWzUPjnVpCImxtvKCnVLGYlUn9AVe10ZVgpg6QQNOre2ERzSSvtha2B77Ow1GgIywpi+8GVgKgGIJGPGHVDBqyNm1282QWYub1b47YYdb0MZfX2Gc1OO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=NbBCcupb; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a75131ce948so548641566b.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 03 Jul 2024 10:09:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1720026573; x=1720631373; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=kRpbCtw/E4IRbKxwJt2blPeYec2wEFVPadTklw6HsWc=;
        b=NbBCcupblJu4PVrUIvbbrMLbkzfHUFV1a1ICLrJQwWkFgPp3gTk5dYD+x7ICrix5NY
         kuvfH8lDBhfW7akW8dhbntdgiDzS13yG/D7n88brLwWhmWVT/Ql9uBPy9kZLRsskvYIL
         t+A0rPsRghA70DjGHxlqlNiSxomWhEkhkrylw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720026573; x=1720631373;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kRpbCtw/E4IRbKxwJt2blPeYec2wEFVPadTklw6HsWc=;
        b=fADvupdC78VUjen8KO2rRbM1+z1mTZ1n8YpJ3MrgRRoqLmnOcr4TOqo7HEuFaBZiim
         NmL/H2DEFN5zA1dLX1XtkL0LgXwlSzbSIJ/P4LbFB3vaJTex2kgE0AUbY60Jrgr5zAG1
         Ekzb+se+jK5DSP22vQhcPMZGOXS7f9+Enq4QLiDjNQnMqYqaOCp1zq/nEq1d4jzNgr+4
         Jcq7wAGbgieZwGQgY0jrhNRInKsbUVTJGik1abMWAid9CNJSVG29nh9HCwT84Q2PSirV
         xRNrNEwPBGedSQBwZ2TkPlCt37fB+tOj6b6cql+EBtedhTYPILY+giHHeiz0qKYWroMp
         rAVQ==
X-Forwarded-Encrypted: i=1; AJvYcCX8FMTq8FGy4BnwVr8uEWUj/9H35CrSbi/ZCNKf05x6Z/jDlwXHzl1qpIoGCzLfS0Y8sw2Xvge9JOGIKZsNxlQM7B5C7VIUVpsOy8JXLQ==
X-Gm-Message-State: AOJu0YzfWqChuUqQA3ZkzkHjMHEDDWY2I4oIuroSURaiuN3SS6jvLRYl
	j1zb1WQXUZOeSGlACmoq9hjhbvj92Jee6Ew1g7Zp26Y51aeuaF/BY5K2p4vGpCZBz7LMrjn7LB5
	X5rkkvQ==
X-Google-Smtp-Source: AGHT+IH3An0ZuWjCrp6x7u1LeHcJSrxqDGLBwpvMaaYzVtWhd04TppzfNnfodMNxemxaax+X2alLAA==
X-Received: by 2002:a17:907:1c15:b0:a6f:77bb:16f3 with SMTP id a640c23a62f3a-a75144a281fmr988400766b.50.1720026572797;
        Wed, 03 Jul 2024 10:09:32 -0700 (PDT)
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com. [209.85.218.47])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a72ab0b8016sm521278366b.217.2024.07.03.10.09.31
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Jul 2024 10:09:32 -0700 (PDT)
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a75131ce948so548637866b.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 03 Jul 2024 10:09:31 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUBt0jGmvd9k7TIqOxkbJi0JMpMDRsqjPxC4btSfzzJNYQGEhmm014GnaEfe8lez/KKt4ijefrEmn0IS7DCu94vPtkP5BJxPillJ4dD1w==
X-Received: by 2002:a17:906:f756:b0:a72:42b8:257c with SMTP id
 a640c23a62f3a-a751444c4b3mr853732366b.35.1720026571539; Wed, 03 Jul 2024
 10:09:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240625110029.606032-1-mjguzik@gmail.com> <20240625110029.606032-3-mjguzik@gmail.com>
 <CAAhV-H47NiQ2c+7NynVxduJK-yGkgoEnXuXGQvGFG59XOBAqeg@mail.gmail.com>
 <e8db013bf06d2170dc48a8252c7049c6d1ee277a.camel@xry111.site>
 <CAAhV-H7iKyQBvV+J9T1ekxh9OF8h=F9zp_QMyuhFBrFXGHHmTg@mail.gmail.com>
 <30907b42d5eee6d71f40b9fc3d32ae31406fe899.camel@xry111.site>
 <1b5d0840-766b-4c3b-8579-3c2c892c4d74@app.fastmail.com> <CAAhV-H4Z_BCWRJoCOh4Cei3eFCn_wvFWxA7AzWfNxYtNqUwBPA@mail.gmail.com>
 <8f2d356d-9cd6-4b06-8e20-941e187cab43@app.fastmail.com> <20240703-bergwacht-sitzung-ef4f2e63cd70@brauner>
 <CAHk-=wi0ejJ=PCZfCmMKvsFmzvVzAYYt1K9vtwke4=arfHiAdg@mail.gmail.com> <8b6d59ffc9baa57fee0f9fa97e72121fd88cf0e4.camel@xry111.site>
In-Reply-To: <8b6d59ffc9baa57fee0f9fa97e72121fd88cf0e4.camel@xry111.site>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 3 Jul 2024 10:09:15 -0700
X-Gmail-Original-Message-ID: <CAHk-=wif5KJEdvZZfTVX=WjOOK7OqoPwYng6n-uu=VeYUpZysQ@mail.gmail.com>
Message-ID: <CAHk-=wif5KJEdvZZfTVX=WjOOK7OqoPwYng6n-uu=VeYUpZysQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] vfs: support statx(..., NULL, AT_EMPTY_PATH, ...)
To: Xi Ruoyao <xry111@xry111.site>
Cc: Christian Brauner <brauner@kernel.org>, libc-alpha@sourceware.org, 
	"Andreas K. Huettel" <dilfridge@gentoo.org>, Arnd Bergmann <arnd@arndb.de>, 
	Huacai Chen <chenhuacai@kernel.org>, Mateusz Guzik <mjguzik@gmail.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, io-uring@vger.kernel.org, 
	Jens Axboe <axboe@kernel.dk>, loongarch@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

On Wed, 3 Jul 2024 at 09:54, Xi Ruoyao <xry111@xry111.site> wrote:
>
> > Honestly, 'statx' is disgusting. I don't understand why anybody pushes
> > that thing that nobody actually uses or cares about.
>
> Hmm why it was added in the first place then?  Why not just NAK it?

There are valid uses of statx - they are just VERY very few and far between.

For example, if you want the "change cookie" or any number of other
special things that aren't standard, you have to use statx.

But _normal_ programs will never do that. It's unportable, and it
really is a specialty interface.

Pushing 'statx' as a replacement for 'stat' is just crazy. It's a
different thing. It's not a "better" thing. It's an extension, yes,
but "extension" doesn't mean "better".

That's true when it was mis-designed in certain ways that we now have
to fix up, but PARTICULARLY true when it's nonstandard and no other OS
has it.

> And should we add stat_time64, fstat_time64, and fstatat_time64 to stop
> using statx on 32-bit platforms too as it's disgusting?

We already have 'stat64' for 32-bit platforms. We have had it for over
25 years - it predates not only the kernel git tree, it predates the
BK tree too.

I think stat64 was introduced in 2.3.34. That is literally last century.

Anybody who tries to make this about 2037 is being actively dishonest.

Why are people even discussing this pointless thing?

            Linus


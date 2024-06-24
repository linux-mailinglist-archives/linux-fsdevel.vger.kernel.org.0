Return-Path: <linux-fsdevel+bounces-22234-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 86C139149CD
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Jun 2024 14:28:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 17F3E284356
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Jun 2024 12:28:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD42913BAFE;
	Mon, 24 Jun 2024 12:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fjQ2gUgE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4F07137C2A;
	Mon, 24 Jun 2024 12:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719232100; cv=none; b=ac8WDJ/NUaAJwmJ8QXI5Zy0MTNP3qlR4adbyBJ+ixZCh0etcgjFuf0vf7GpiY3WUvTtXbBSqajNngz1ExVGs8WebglErLhLyMli943y7i2X0zZu/wArY33ipFk4hMBp47v2uUpHjPaH0IHsn6r9ydxIenA4tDCjZ7pQe3pcDjCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719232100; c=relaxed/simple;
	bh=vDRm043puDoGOMdb6yxVqyoLpLEK0Mr7K2kShYPQA4M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MCXoY63wg7y4yJJsRCo3nO+0VB4UyrPdOVTYy+c25U2YkkKKijYULvW62JBVooFH2anB6L11foNIMhhKRRKz98ln1oNjxqySHotqds4H/6ulw3/uCH2LIigaoYvh7C8tjhEecSPeqPi7zy0Lk73Ql0X5heJ9d+mAmwlhaCsG1+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fjQ2gUgE; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a724b9b34b0so123007666b.1;
        Mon, 24 Jun 2024 05:28:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719232097; x=1719836897; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xHJsxhxdOLaqizliJLOPpaKHXoqhdyk0yF3LIbtNF28=;
        b=fjQ2gUgEx3MlqtXHGQaCz3zuAIa54ALaXXrBTvEfqoEzfhvHYFe/qG1Rul+NMtmame
         7lE1GEl/DOXfoPR3abMSi4SNip9GxFuo6SuI7DzIWtsO4tUpUzmbw30Sq/gcpY8n6o2e
         yiFDlVpBCHKpMsr8JGegRysONZx2D4Lk+Srnil/zbagjhMoHp4bXrzY9zKiYCMFrxzLw
         RSuhg2DYAsjIZvEMPpxUlNMDAoAb7FFrpD372ih/QcbM2Kh1aP4vEfnCtffwRBmKL6qV
         Ru85gOmzaGkO578gcEcCJsf3mZf8hbIM/GHLXPNKQs9uWcezdVK+pSWf6BO1wEoWFbrX
         N8zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719232097; x=1719836897;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xHJsxhxdOLaqizliJLOPpaKHXoqhdyk0yF3LIbtNF28=;
        b=XkJ5hbVrTdN/bxBIxnYXJYODuJcaXNtH835sSI6FMV+tlotZwf3qIz6Z+0Ld4Eemrr
         uHmJkgNGjC88fZuDQW6W17eRDU4nf2XC6BL/QaTHlBp1KAeDPPPQ6AJFnbSHCzThYfCP
         BI35P3rZ+RcD9gRYxqSJZJMeH6tO/l5M+rPuRIP0ZyYPsnK5FkANBdNbBuzoxMPFmHrt
         ozKwTAvwDLvsj3efWM9KDncbmaTPuI/lSw5Oh8TcKCk6f0yzjrgbf6m75yEUbbvrDuLm
         +TsAHgXz9Oxo7E+dOZYXK3g0DE65fALnAAWDm/dUn6T7L9GIGzOfUge8DlyVvjYmiRn+
         do/A==
X-Forwarded-Encrypted: i=1; AJvYcCUaoj3PljwfGmbGnoy8oBr/2RKrrFqaa9nz/fl/+iAcWHD0E8NHdMPWo/2lZIvbbwfLtqYwy4RCWyDy8xVwKUsZE65/jAdtUZC9HJqh2v0RqejpG4AqbVxNxuleG7fR6THq2dD/QfkYUVjWA5/M0E1amQPIA0EzqamFN9khSbw7Db24zQZCt10=
X-Gm-Message-State: AOJu0Yx6LONvsMl4a59/AgrSjzI5z1jkneWUEg3aVaDYCO0Z7N9R0hWr
	oZHAZkyi5V0t5OXOXQYgNaF+PbF0e+sctVaG8+gwWkEFC79yC1OSTrBWSb+RviPN1a3e/VGVqnT
	CzOT3wuIBVsqnq13iOU/3RHCUpVM=
X-Google-Smtp-Source: AGHT+IFLuihGCVppoutdyi8cBVHlab+e+O4qV5jLbe5dJIxrWHY4mdjCw71NzObZvquv4leyc73TcWAQqFe10tnNgqU=
X-Received: by 2002:a17:907:c5c7:b0:a72:52a6:a06b with SMTP id
 a640c23a62f3a-a7252a6a114mr194276366b.46.1719232096844; Mon, 24 Jun 2024
 05:28:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240624085037.33442-2-xry111@xry111.site> <e2lv3qamggymdjqzujvyhsd2q34jy5tryniac7d446tlaebqwy@5x4zn7z4d3xz>
 <b635271e73b35487a06cf17176243e6ce4cfcd58.camel@xry111.site>
In-Reply-To: <b635271e73b35487a06cf17176243e6ce4cfcd58.camel@xry111.site>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Mon, 24 Jun 2024 14:28:03 +0200
Message-ID: <CAGudoHFQ1SnKubuDsSxE39W+MR6Af2PbHkrNwAAbZFb-9ETswQ@mail.gmail.com>
Subject: Re: [PATCH v2] vfs: Shortcut AT_EMPTY_PATH early for statx, and add
 AT_NO_PATH for statx and fstatat
To: Xi Ruoyao <xry111@xry111.site>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Christian Brauner <brauner@kernel.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
	Alejandro Colomar <alx@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Huacai Chen <chenhuacai@loongson.cn>, 
	Xuerui Wang <kernel@xen0n.name>, Jiaxun Yang <jiaxun.yang@flygoat.com>, 
	Icenowy Zheng <uwu@icenowy.me>, linux-fsdevel@vger.kernel.org, linux-arch@vger.kernel.org, 
	loongarch@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 24, 2024 at 2:19=E2=80=AFPM Xi Ruoyao <xry111@xry111.site> wrot=
e:
>
> On Mon, 2024-06-24 at 11:04 +0200, Mateusz Guzik wrote:
> > Below is a diff which compiles but is untested. It adds AT_EMPTY_PATH +
> > NULL as suggsted by Linus, but it can be adjusted for AT_NO_PATH (which
> > would be my preffered option, or better yet not do that and add fstatx)=
.
> >
> > It does not do the hack to 0-check if a pointer was passed along with
> > AT_EMPTY_PATH but that again is an easy addition.
> >
> > Feel free to take without attribution:
>
> I'd still like to make it Co-developed-by: or just From: you.  Could you
> give a S-o-b?
>

I just trivially shuffled some things around and did not even test, so
I'm not signing off on squat here. :)

However, if you insist you can add something like "Written after
picking up an initial patch written by Mateusz Guzik, see [link goes
here]" or similar.

> And with this change AT_FDCWD with AT_EMPTY_PATH and NULL path does not
> work.  For consistency it'd be better to make it work too:
>

Good catch, I have no opinion which way to fix it.

--=20
Mateusz Guzik <mjguzik gmail.com>


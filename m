Return-Path: <linux-fsdevel+bounces-22320-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A7D33916590
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Jun 2024 12:53:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 33E24B20BA6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Jun 2024 10:53:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ADB314A60D;
	Tue, 25 Jun 2024 10:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JJqFxLvo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7747453370;
	Tue, 25 Jun 2024 10:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719312776; cv=none; b=XEPuIQfrFrU/CXXxOu2bjeTp+FvuSYkKD/E3RUzXTOJcbYvtnGBKeUB3hJO06s+msXEoUwx63p5n+C1pg2vKRTBDiaHcF1UrR4JRv2/yi3L+VoqVW2KCRhc8eCNlUlKcHUkUJ7BfyMg9qjwESSluwfjt9hYbmF82z15wvjur4so=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719312776; c=relaxed/simple;
	bh=vFD+rd/N0ZO2xUJ+4r9RQ68ijp1ed6+yEhJXQ52MV+s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dy9fYsp7PZh7OEtqNSuRo2jk1dDVpKPwxUTxXxsW73lK83oZXipjxbXhHd4ewzxHNwhN1mH5uvfXypY78YY/8xEgIbza1/fOvQYFJr4daGhY11BZJfKrQsrqdtSN1/iSOBd9b4vQszVRMQpCtD1Z77QD8xzbNpLW2FHG/RxyLUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JJqFxLvo; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-57d2fc03740so3964019a12.0;
        Tue, 25 Jun 2024 03:52:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719312773; x=1719917573; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vFD+rd/N0ZO2xUJ+4r9RQ68ijp1ed6+yEhJXQ52MV+s=;
        b=JJqFxLvoKlMYdq8pVMpqudRhAmpGddWaJYBeGUaslDHMARpXs08qA/e9zVHGVrveh1
         RfG7PI+OHPQ46kNc7HbrdVUWIUVcqCgJy41WLPm09uxkr7/ePQ09EjyGV+Ek5M1zPXqp
         Mt2QEScbshMqKi1xVltg+9pStqcDdU4yB9Z4jLr5rbjAnGu9E6Dn8HtqRHoMR7eSRq+t
         ASMCtZXK2uWcahcgzKJsLjW6XrlUZIKxUQCLgiT8QijwNgCjfU/2pfW5l5YK8WTNbgLw
         7yXOEE+j5G9aTjjVKn6wH2Y69GVdyLiQYFYoY4s/iuGh4GDBiTC+ucJoW/EDlpCXVUcO
         6nYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719312773; x=1719917573;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vFD+rd/N0ZO2xUJ+4r9RQ68ijp1ed6+yEhJXQ52MV+s=;
        b=DWs5Pg9+mM+0wQGX8cV5TX8s2OZrAixivAUDH3Y/mg2LLIKPJ+uD4eMoubqzniungh
         Y100cTZGMP8zqNsqBYzjrHo1l92f+S5fFzE/dBVL66E9TKvAgQUu/oHmlrEFwI9zEiiH
         KZMSmu7SxrSHHL1aPHH3BaqIIrosXziC/MS+6u7GldXlAXUpjWaTGnpgwkM3goggEphC
         w1Fqc2M0YS4x/UuI1z2pCef5lvySDqW3X16T2ZHrAiNVHpu4FsRicrQi9U+peK3Ek1zD
         yu2rxPrel6RJpjLSd+fOUE+dzceUN9FB84l+y/POlmLlFz/dfcLGtIOCZonMQ62//tpk
         AnYQ==
X-Forwarded-Encrypted: i=1; AJvYcCVQJXsmI0YblOqJQ3F08NWRGUI6MSVNd7uWNutBTLSu+Ev8etVI+DRcO16fOHpI/5AWMmvhXuDur7OpANAvjNeS8y/hpIR0ghmMwPmm4ms9rBZI/xRq6KmZGENwjqxbVzzNTLaRfCaVZlyh5rFt6+Sxff1Pg/bdwZM8opJDe/LovFqSGOpbfcA=
X-Gm-Message-State: AOJu0Yy11jQD8vPzxl8mX1pxP6U3gms5V0Ows4KomTgxYz+0EXN+t4vv
	tDuYBjEwzQQ2SltYtYPVo4O7Wm7sooRqaGxQX4pXdF0HhtawcJmzbA2wICJ/dryGpHKA8tCvUU2
	IX5N6BwTz2kavxkzL0JxS/lZNy4w=
X-Google-Smtp-Source: AGHT+IGTa887v3D8eziyl3LcY5wiXy2Tj8wU0X39RaxGrXENpYI5ac4WWgcS5FyLRWZK5g48wFj25j5Eqcu4vUAoCQg=
X-Received: by 2002:a50:bac5:0:b0:57d:c8:d295 with SMTP id 4fb4d7f45d1cf-57d4bd566e6mr3835656a12.4.1719312772630;
 Tue, 25 Jun 2024 03:52:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240624085037.33442-2-xry111@xry111.site> <e2lv3qamggymdjqzujvyhsd2q34jy5tryniac7d446tlaebqwy@5x4zn7z4d3xz>
 <20240625-kindisch-ausgibt-b4feede36bab@brauner> <30a5fe67500c40a4d5f9516e9b549ec796faac74.camel@xry111.site>
In-Reply-To: <30a5fe67500c40a4d5f9516e9b549ec796faac74.camel@xry111.site>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Tue, 25 Jun 2024 12:52:39 +0200
Message-ID: <CAGudoHEDKvP926Q6tX1Te_WW9_OTLUoDRTO3nCO3LHo6HJyLpQ@mail.gmail.com>
Subject: Re: [PATCH v2] vfs: Shortcut AT_EMPTY_PATH early for statx, and add
 AT_NO_PATH for statx and fstatat
To: Xi Ruoyao <xry111@xry111.site>
Cc: Christian Brauner <brauner@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
	Linus Torvalds <torvalds@linux-foundation.org>, Alejandro Colomar <alx@kernel.org>, 
	Arnd Bergmann <arnd@arndb.de>, Huacai Chen <chenhuacai@loongson.cn>, Xuerui Wang <kernel@xen0n.name>, 
	Jiaxun Yang <jiaxun.yang@flygoat.com>, Icenowy Zheng <uwu@icenowy.me>, linux-fsdevel@vger.kernel.org, 
	linux-arch@vger.kernel.org, loongarch@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 25, 2024 at 12:51=E2=80=AFPM Xi Ruoyao <xry111@xry111.site> wro=
te:
>
> On Tue, 2024-06-25 at 10:50 +0200, Christian Brauner wrote:
> > No, let's not waste AT_* flag space in fear of some hypothetical
> > breakage. Let's try it cleanly first and make AT_EMPTY_PATH work with
> > NULL paths.
> >
> > Note, I started working on this (checks ...) 30th April but then some
> > other work came up and I never got back to it (Sorry, Linus). I pushed
> > the branch to #vfs.empty.path now. The top three commits was what I had
> > started doing.
> >
> > It was based on a new vfs_empty_path() helper so we could reuse it for
> > other system calls as well.
>
> If I understand correctly, I should submit a patch against
> vfs.empty.path making statx(fd, NULL, AT_EMPTY_PATH) work then?
>

I just sorted this out, will be sending a patchset shortly.


--=20
Mateusz Guzik <mjguzik gmail.com>


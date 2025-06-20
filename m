Return-Path: <linux-fsdevel+bounces-52346-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91E3AAE21D2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Jun 2025 20:12:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A4544A7A8E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Jun 2025 18:12:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 994E92ECD0B;
	Fri, 20 Jun 2025 18:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bw2LgU2V"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FD712DFF17;
	Fri, 20 Jun 2025 18:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750443095; cv=none; b=YGLQTVGUgIYMiHPhNDLXNNh2R/UeARdGr/Rzyr9OWjOjkqy2x4Exbo6e9zGt/e4mFuZhRe6CSVjpAjx23hH/TECDHVekGFb1SZ8mMEoi05jQzdR0pxy44o7Tj5Jqp/o9bOAj9E4le/TE9emth8qZfwigtm8xW0da0YeTBXxnXbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750443095; c=relaxed/simple;
	bh=kpqSjYuyWWjTT8OzZQmWM89sNuGiYAs8n81bDCTR3VE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n/AagfV8ekujuSDtyQWdqcl/Vy1OmOvQE2MmjQvZCsZ2Pqyw3tFn3WS4ZXCK2u0kCVdYYOPqNAwHpRTfvO8jL2Oa58/r6GA7oDuZW6WZ7OOsZ4KBd/gakjGL64wKQT3SRGJuF9gpUqgwquxqgR5+/WDzyFWS6Wem0GJ1Uk6UBAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bw2LgU2V; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-313290ea247so371121a91.3;
        Fri, 20 Jun 2025 11:11:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750443093; x=1751047893; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kpqSjYuyWWjTT8OzZQmWM89sNuGiYAs8n81bDCTR3VE=;
        b=bw2LgU2VbBHypuiszQk1+oKu+o6RJU6Ms83U54+xBx5/fehyCKP/DJOdVRwSNsNr2g
         WS3R+2g6bYR7S7ri3KBFJYq7VQmY4WWiMuPTuUHepWtDDnUSvOFGpmTB2T6t89mkfpkw
         AtcyD25e2FRxxVYbUA5UMNtb39HVi9qb+g7pqPcIwpvGkGHFyh93LWZcNwKtkdwobxQf
         sqpzXwpzUBYFXxacCIEaiQT0spozZ+u1mCWwBFM+Vzfx0+QlrZ+sovkeu/u4Nl9krUUB
         Ktu57250Wz8YcFPRj1iJeHzgpncH+kLsg3Fj8GFDVTI5ayIo2freDYIfaemGW+bF8SsA
         VDbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750443093; x=1751047893;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kpqSjYuyWWjTT8OzZQmWM89sNuGiYAs8n81bDCTR3VE=;
        b=Kee/6K0vnBgEMHTgXNpPAwZtb1KusqSq5u0J/atrRQzHJ/3eOV9qHuOi9nRBHr3Q73
         5w+RO8aLUnnMKCUchWpI4VrU1wFZfbbWMtoWidRVJZtMRqRdIw7k0m76BuW8g9LPCZI5
         2K7iUQxnJoh6v+z719Sdttu29/0ek94KpfPR/T/pVYCGhJLXk9nXUi8+LOC/ZFztEff1
         /mkOq6/SOU5/YYHffDlI9R6lznNp33zgJPS0saOf4vO3D+bodcegylXQ8DxB9JCWE+8q
         ZoW63Rre4H1I2QElZ1pMbl6AudmVRCGrBwE7C9KQv0SCEZ5WNEwRJ0XfoEFPhvRrwuef
         83jQ==
X-Forwarded-Encrypted: i=1; AJvYcCWoWr/sZlsn5tQXDWy4WEny2zPjY45ekt5p/6xd6y3qKAP7jRzTQc0MD+q1DlVPuYZb9zFll6aV2+hvA8mD@vger.kernel.org, AJvYcCXcEgxKo2gzRCcIrM0Gx6NW27HU+P1qKafnpdruESiHModzoSDPFWpvOUQh05DaaSOSGbCnWbjKNaEhPpvagjw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxjjWEKxtJRXcPxq+r/UbQKZ42bSwty/AMwWeRmJKbGdF3AmoHd
	zmRhKtDIECbxk784V/DsiI/8bf/NAmSqaNVbDySKA/hOMRMGRbHtVaq/3WgSPOWjgN+6amOfxzX
	yy9WuicNF17+WOX4rvOGnYnIBS4sGyJ4=
X-Gm-Gg: ASbGncu+cb7CZn669PEUFERjckE081qDTwxNcyMJtb9qzwX6R4nx59nWNOczYhQMAK5
	SBg6CdgynzOJlrpkkhj9eYrGgPAY9P/NvDwfol8x4l1dBXSQxiv9dqJvnKOM80A1VMgCIbxiWRk
	LVtwdTv9GZaUxm40RM6379i+CC2i00uK5wCoTfv8Yi8qI=
X-Google-Smtp-Source: AGHT+IFxqtsyxxBPB2Vl7f77nKfRB1x63LSrdWF4dzpEMQXTmhAJl9NHWHFIwgkJubZvw2ibfMW6FG9dIBVBUAtkBws=
X-Received: by 2002:a17:90b:3a50:b0:313:14b5:2521 with SMTP id
 98e67ed59e1d1-3159d8d8235mr2656028a91.5.1750443092829; Fri, 20 Jun 2025
 11:11:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <d5ea8adb198eb6b6d2f6accaf044b543631f7a72.camel@ibm.com>
 <4fce1d92-4b49-413d-9ed1-c29eda0753fd@vivo.com> <1ab023f2e9822926ed63f79c7ad4b0fed4b5a717.camel@ibm.com>
 <DAQREKHTS45A.98MH00SWH3PU@kernel.org> <a9dc59f404ec98d676fe811b2636936cb958dfb3.camel@ibm.com>
 <DAQV1PLOI46S.2BVP6RPQ33Z8Y@kernel.org> <39bac29b653c92200954dcc8c4e8cab99215e5b4.camel@ibm.com>
In-Reply-To: <39bac29b653c92200954dcc8c4e8cab99215e5b4.camel@ibm.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Fri, 20 Jun 2025 20:11:20 +0200
X-Gm-Features: Ac12FXyibdZ42btlJZAQIYiLMWebP_G6s0CsDZnS-VjXtvvyo2sPMovx1R36vv8
Message-ID: <CANiq72mUpTMapFMRd4o=RSN0kU0JbLwccRKn9R+NPE7DvXDuwg@mail.gmail.com>
Subject: Re: [RFC] Should we consider to re-write HFS/HFS+ in Rust?
To: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
Cc: "frank.li@vivo.com" <frank.li@vivo.com>, 
	"glaubitz@physik.fu-berlin.de" <glaubitz@physik.fu-berlin.de>, "lossin@kernel.org" <lossin@kernel.org>, 
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, "slava@dubeyko.com" <slava@dubeyko.com>, 
	"rust-for-linux@vger.kernel.org" <rust-for-linux@vger.kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Ariel Miculas <ariel.miculas@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 20, 2025 at 7:50=E2=80=AFPM Viacheslav Dubeyko
<Slava.Dubeyko@ibm.com> wrote:
>
> Nowadays, VFS and memory subsystems are C implemented functionality. And =
I don't
> think that it will be changed any time soon. So, even file system driver =
will be
> completely re-written in Rust, then it should be ready to be called from =
C code.

That is fine and expected.

> Moreover, file system driver needs to interact with block layer that is w=
ritten
> in C too. So, glue code is inevitable right now. How bad and inefficient =
could
> be using the glue code? Could you please share some example?

Please take a look the proposed VFS abstractions, the filesystems that
were prototyped on top of them, and generally other Rust code we have.

As for "how bad", the key is that every time you go through a C
signature, you need to constrain yourself to what C can encode (which
is not much), use unsafe code and other interop issues. Thus you want
to avoid having to go back and forth all the time.

Thus, the idea is to write the filesystem in Rust using abstractions
that shield you from that.

Cc'ing other potentially interested/related people.

Cheers,
Miguel


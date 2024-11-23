Return-Path: <linux-fsdevel+bounces-35622-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10FC69D669C
	for <lists+linux-fsdevel@lfdr.de>; Sat, 23 Nov 2024 01:08:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 74DF51612AA
	for <lists+linux-fsdevel@lfdr.de>; Sat, 23 Nov 2024 00:08:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DED59476;
	Sat, 23 Nov 2024 00:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gEOSEUiB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13F80A59;
	Sat, 23 Nov 2024 00:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732320518; cv=none; b=kEedu4AximaJzVqa6KtkEKrmHoPHR9iK7kkjeeY48PZQGH3fLLB4BMkmKJqkwqcqQu/2ng3uIFkBXFCVg9yPnhdmO1+JhinFLmML9QQ8nwEeGDypfyWzdVrj3MQUUYOd48j+AKmUHCjCX0kPLW84CVHWXJ9zHWo4ohZzqq1T57g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732320518; c=relaxed/simple;
	bh=OivMuzy8RmEkygfwmOEeRITzjbJ3pOEAQUDbzLRND4A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gg+b5uZGBFiHBaTX+ccCFWZCrbYkhBs25oVL754xHG6/aHsXC0fO/j0hhVENPZxWqnD5m1m+2uDIsyPrgv92eCp4spRXg+iiZ0v6P9GvHAtneEpvPlXa1fNn1uySwPBf0UKZ3bFlej16clrko8ekVB8V9UI9DOqTBExthBkHo7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gEOSEUiB; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-382325b0508so1777602f8f.3;
        Fri, 22 Nov 2024 16:08:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732320515; x=1732925315; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OivMuzy8RmEkygfwmOEeRITzjbJ3pOEAQUDbzLRND4A=;
        b=gEOSEUiBXbvC61nCDiG8aSMD1cYuCzsisT3U7DznNg0yo9/pmbAGPPJ0Q6+Z4x83mG
         fU0XAoM4f5hDl3PGNCwZ37W5Pr/XlDdopl8f2Mrhe4BU71sb/hEjjF54rfjZVr3OBiUG
         lkZMom+lDFCIyft/0tcNRYLnBtykSszHNHTgJBuAi5ShQL1jjhky9jpybo9arjlRqNWy
         r0pQZKce7mtNKbTlHGynFNKIf1IwHg7+cA7JiXSWLnyS9n0Sfe10w7Vf6vh/kn+S75fR
         YeCu4HUbHtK9u86a9FwhN8ATcPlX2VatXQ2k7kbrhGvPc7wD5vXw4WcEKKJZ7xGCC4OU
         tTXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732320515; x=1732925315;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OivMuzy8RmEkygfwmOEeRITzjbJ3pOEAQUDbzLRND4A=;
        b=KpB6VLs0pOisjBKVwlrcCB2U7saEKbuV9XnJqTt/680SeJyTSMhP0uvvScI+Rbjriy
         i7dS5K9nA2YokOjdBi2Rz8PdKPWqEdLsoLlCiG8P1zD3LQjgmoNEMKwRegl+21xWexwM
         r9PcrXrZT+pRJPX7EGtkcf2Paq3eDE0iqyNAn/HFUBcNlSO3hI0K59pjZbCJ5dyq4bmP
         GJQj0EtxbN33Xe/pehrZzsHbYD2frJ0OKtGOMN5vkirJYUOfjtmpbHAM5fV9obtENen4
         coXUkUazFPzcrNgTgE7wuBX/pcJuHv12evvFivsMeMuCbgG911bPN15w+o3J76CipRxj
         WtZA==
X-Forwarded-Encrypted: i=1; AJvYcCU070cHVUKiy4BMfQKFGUGAf9B4ms1GhOJkXmmcOli301tqE2sl3F5KVcTlFe5ANElbm83XVljX5n7rE1S2xZjLrCw6lj8Q@vger.kernel.org, AJvYcCVDaA6b8+qcjuxvdRd9F81bzmDz4yclN0OL33NaEXObfoRBld5CN0p+32jKZYf5TgFMJ6+OX2PN70S+5UQ6@vger.kernel.org, AJvYcCVsQIWTsnDHHF2DyY6HAQ81uUe7g5yUKBbEVbgndaGl2e2KG5KQW7wLoAWZNw912hrpBsK3D+hQyUFAWTPB6Q==@vger.kernel.org, AJvYcCXupxYHc0cERQKjuhvR5p8KvZHn3gmfLbCFtuTXrb8LupwzmHkzPXeiAoBgiiTm9sh80sg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTSJJ/L5520IKwA23kBTNg5gXeZHxniRxdItAuLQWcO+pTKkuX
	wfuCi816xrfUD4j0cMeRIPO6mr/BZDWAV2z7Za36aS/MBaT74DAD3xn56gz+cjuzOWFggYHLfMW
	6kXFzprAbCYFadeOppGowMxO1bTo=
X-Gm-Gg: ASbGnct8T2r+o16pulLi0Y897le/PzqLh461RYLb9FJjPe8VtHL3QSg9lUuOXhbDX0E
	c4X4alpuy15ImOkbB8e3WSyZjpfT48g==
X-Google-Smtp-Source: AGHT+IHZ4AAsVux9lUn0M+uDFGgBgO1vJ+SRqNv0DY5oxafFBj4LEno3SqwFlKuShIrT1Ho7aCIILMqtA6hgCcTt4iE=
X-Received: by 2002:a5d:5889:0:b0:382:4e6a:bfd6 with SMTP id
 ffacd0b85a97d-38260b46e71mr3947803f8f.10.1732320515104; Fri, 22 Nov 2024
 16:08:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241112082600.298035-1-song@kernel.org> <20241112082600.298035-3-song@kernel.org>
 <20241113-sensation-morgen-852f49484fd8@brauner> <86C65B85-8167-4D04-BFF5-40FD4F3407A4@fb.com>
 <20241115111914.qhrwe4mek6quthko@quack3> <20241121-unfertig-hypothek-a665360efcf0@brauner>
In-Reply-To: <20241121-unfertig-hypothek-a665360efcf0@brauner>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 22 Nov 2024 16:08:24 -0800
Message-ID: <CAADnVQLvN7uF7NBapCWYtsfCHr3rDm-jRnN=9F=_xSjf4SAuLg@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/4] bpf: Make bpf inode storage available to
 tracing program
To: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>, Song Liu <songliubraving@meta.com>, Song Liu <song@kernel.org>, 
	"bpf@vger.kernel.org" <bpf@vger.kernel.org>, 
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-security-module@vger.kernel.org" <linux-security-module@vger.kernel.org>, Kernel Team <kernel-team@meta.com>, 
	"andrii@kernel.org" <andrii@kernel.org>, "eddyz87@gmail.com" <eddyz87@gmail.com>, "ast@kernel.org" <ast@kernel.org>, 
	"daniel@iogearbox.net" <daniel@iogearbox.net>, "martin.lau@linux.dev" <martin.lau@linux.dev>, 
	"viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>, "kpsingh@kernel.org" <kpsingh@kernel.org>, 
	"mattbobrowski@google.com" <mattbobrowski@google.com>, "amir73il@gmail.com" <amir73il@gmail.com>, 
	"repnop@google.com" <repnop@google.com>, "jlayton@kernel.org" <jlayton@kernel.org>, 
	Josef Bacik <josef@toxicpanda.com>, "mic@digikod.net" <mic@digikod.net>, 
	"gnoack@google.com" <gnoack@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 21, 2024 at 1:15=E2=80=AFAM Christian Brauner <brauner@kernel.o=
rg> wrote:
>
> > I'm personally not *so* hung up about a pointer in struct inode but I c=
an
> > see why Christian is and I agree adding a pointer there isn't a win for
> > everybody.
>
> Maybe I'm annoying here but I feel that I have to be. Because it's
> trivial to grow structs it's rather cumbersome work to get them to
> shrink. I just looked at struct task_struct again and it has four bpf
> related structures/pointers in there. Ok, struct task_struct is
> everyone's favorite struct to bloat so whatever.
>
> For the VFS the structures we maintain longterm that need to be so
> generic as to be usable by so many different filesystems have a tendency
> to grow over time.
>
> With some we are very strict, i.e., nobody would dare to grow struct
> dentry and that's mostly because we have people that really care about
> this and have an eye on that and ofc also because it's costly.
>
> But for some structures we simply have no one caring about them that
> much. So what happens is that with the ever growing list of features we
> bloat them over time. There need to be some reasonable boundaries on
> what we accept or not and the criteria I have been using is how
> generically useful to filesystems or our infrastructre this is (roughly)
> and this is rather very special-case so I'm weary of wasting 8 bytes in
> struct inode that we fought rather hard to get back: Jeff's timespec
> conversion and my i_state conversion.
>
> I'm not saying it's out of the question but I want to exhaust all other
> options and I'm not yet sure we have.

+1 to all of the above.

I hope we don't end up as strict as sk_buff though.

I think Song can proceed without this patch.
Worst case bpf hash map with key=3D=3Dinode will do.


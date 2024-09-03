Return-Path: <linux-fsdevel+bounces-28382-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B1293969F78
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Sep 2024 15:54:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6834B1F21D35
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Sep 2024 13:54:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67DEF374CC;
	Tue,  3 Sep 2024 13:54:13 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06F391CA6AD;
	Tue,  3 Sep 2024 13:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725371653; cv=none; b=gxGlAgQQI8HhPAUJKkoH6V5JZBTkLPA9PAhPj1cZ5MdKkK0q1inb7KFKoBeZay9uwQ22r/7r6xpcy6PSQh0tfu7hD9AwcvQfvCMUuRKHyMHIk36lU/kT5pv8s4wKvNdM/HrXuN1VtyuqOxxgzoWJHKxM3wJe8Q5P1/AdGifxcIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725371653; c=relaxed/simple;
	bh=LW2aFcZJH14Q1kEXlseBIgZHNW2q6kUp7VYzJkVVKs8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cZHp3vsDEvsW9yE/TyqX3CYi3LZhhCUQfIPy1UQi7eR+fZKOy30tZUPYxN5uoHCw6JvvYx1eYZrX9/+NvB2KkjMzwtZiJ/5JNo8eQyWjclOnzu7cGl7ALwVchOXxwsJUssmEY5r8SfYaq6Y/KstnuQOGHDZ1MA9z0lEwKeBZyek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-691bb56eb65so47041577b3.0;
        Tue, 03 Sep 2024 06:54:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725371650; x=1725976450;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mqZiEh+o6sfWJuXgzKi0L8anYlIdqwzIKuWOXeuoMnQ=;
        b=EUj89AIo3DW3yVfoC1jZvW6l1z0QH0q0J5ql+yPr4laTt2+ahkMjmcio+7Flca+7Q9
         m0McHE+rXk36/KPTJjXc4Fe2rcm2+wTjpuNolJLwN8qo8uInbNQ5ckta5cXZM4HknHPC
         78bHUtWbliHB/gzGcD7uH7INo1ntfj9i7NPf2k5PmhTkUOaHNe8T+Axi8zuHYsbaFdYK
         ukny7fx2SwCT2KUUzHyADrg9i8qCPJiJWxhQxk6btb0EIsIqC3NusQGngAHFOhPnTAad
         0FsdJraLiBLlL2BWm0VOdVjGBkyPMCNJ7VjZS4ZXdeS3Ak4h8MttWHlTHZ0SqPeckFck
         SZ4w==
X-Forwarded-Encrypted: i=1; AJvYcCUVoTzxxnWDMqSQevl6C2a1YC1bwe7UXd7avk9ogywiRFMmXR7ZbhDnK3mGwXKSCCngxpNa3nUKmWTtXsSA@vger.kernel.org, AJvYcCX5gSUJqLmYYcOlMobb7qGVFoWceb2+gA7XBmGXKlAzgdBW8EG2Yfg6/iIWM8MNUXJiTpjej/vftczJppo6IA==@vger.kernel.org, AJvYcCXDRJ5ffddfrhwu3CC1fh2csk5ZZDpSstzlzDlWqPdtHKBlGhmVBsqtbJ3+7zVV+H696NRwk9g3oCbaEz0D6A==@vger.kernel.org
X-Gm-Message-State: AOJu0YyCykBD8sZ1+Tr5eXklBq22ghMQFEaO6VloKR6qD3amHKRvy/vY
	pzqnvoOXqPUpfPll9ct3ZajG9YOSoVOHckvFFJnmiZ3H/5zU3uEnPG/7uEA4
X-Google-Smtp-Source: AGHT+IH1EEs71yyN4QvmXcCeh/VZvOCftE1Jb6CJ0quGKYOD+39epwfs8DO+4cSDyP+KXqpZU9wazQ==
X-Received: by 2002:a05:690c:e1b:b0:6d4:4cb:e453 with SMTP id 00721157ae682-6d40df802eemr155752407b3.17.1725371649359;
        Tue, 03 Sep 2024 06:54:09 -0700 (PDT)
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com. [209.85.128.182])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6d2d57de3e5sm20083137b3.77.2024.09.03.06.54.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Sep 2024 06:54:09 -0700 (PDT)
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-6d6891012d5so21436017b3.2;
        Tue, 03 Sep 2024 06:54:09 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUYoNleSPBCCRaphC+l+3fEkLVS1slTuIEgt8d228oma7Kwpk1OhEhi4iDKtrnYCuBO0pblKvcr47Yp8mcTTg==@vger.kernel.org, AJvYcCV/+D7aQ8mty/7Jxr2yBcv7QfQX15m1lnrcKon48De44yqEtt4lm953NH3Bhbw3l4nlG3kklh7RX/68hSti@vger.kernel.org, AJvYcCV0jYLQW3MDY1l7154RES3Vxno7Jyr/VevgEOrIzSMrw//O61Vx4jzKeTgo0siAX8+NfGdSt7m6a9eDtLRiig==@vger.kernel.org
X-Received: by 2002:a05:690c:893:b0:6b1:4eb6:345e with SMTP id
 00721157ae682-6d40e7824cemr173350047b3.26.1725371648843; Tue, 03 Sep 2024
 06:54:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <erydumpfxcjakfllmh3y4d7wtgwz7omkg44pyvpesoisolt44v@kfa4jcpo7i73>
In-Reply-To: <erydumpfxcjakfllmh3y4d7wtgwz7omkg44pyvpesoisolt44v@kfa4jcpo7i73>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 3 Sep 2024 15:53:56 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWknzcmc1DZ3HSB9qp4poaEO5_ViCESvQChuAaiOBdr7Q@mail.gmail.com>
Message-ID: <CAMuHMdWknzcmc1DZ3HSB9qp4poaEO5_ViCESvQChuAaiOBdr7Q@mail.gmail.com>
Subject: Re: [GIT PULL] bcachefs fixes for 6.11-rc6
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-bcachefs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Stephen Rothwell <sfr@canb.auug.org.au>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Kent,

Replying here, as there is (again) no patch email to reply to to report iss=
ues.

noreply@ellerman.id.au is reporting several build failures[1] in linux-next=
:

    fs/bcachefs/sb-members.c: In function =E2=80=98bch2_sb_member_alloc=E2=
=80=99:
    fs/bcachefs/sb-members.c:503:2: error: a label can only be part of
a statement and a declaration is not a statement
      503 |  unsigned nr_devices =3D max_t(unsigned, dev_idx + 1,
c->sb.nr_devices);
          |  ^~~~~~~~
    fs/bcachefs/sb-members.c:505:2: error: expected expression before =E2=
=80=98struct=E2=80=99
      505 |  struct bch_sb_field_members_v2 *mi =3D
bch2_sb_field_get(c->disk_sb.sb, members_v2);
          |  ^~~~~~

Apparently this fails with gcc-10 and older, but builds with gcc-11
and gcc-12.

The failure is due to commit 4e7795eda4459bf3 ("bcachefs:
bch2_sb_member_alloc()"), which is nowhere to be found on
lore.kernel.org.  Please stop committing private unreviewed patches
to linux-next, as several people have asked before.
Thank you!

[1] http://kisskb.ellerman.id.au/kisskb/branch/linux-next/head/6804f0edbe77=
47774e6ae60f20cec4ee3ad7c187/

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds


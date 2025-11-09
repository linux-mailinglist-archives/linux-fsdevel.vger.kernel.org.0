Return-Path: <linux-fsdevel+bounces-67623-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A0AAEC44945
	for <lists+linux-fsdevel@lfdr.de>; Sun, 09 Nov 2025 23:33:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E5CC44E5362
	for <lists+linux-fsdevel@lfdr.de>; Sun,  9 Nov 2025 22:33:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EE5923D28B;
	Sun,  9 Nov 2025 22:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P/hnEK4y"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 638A221B9C5
	for <linux-fsdevel@vger.kernel.org>; Sun,  9 Nov 2025 22:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762727599; cv=none; b=BjNkMEFgZxBSkugCfM+cmtRYWJoQQjsREo5x8hp9Soo6EAclY+qvd8t/vtZlqU1/WIvOf1PhER1XoRgBvlPorcIM3hsmE/eNGKZqR6ZtJmA6ylcVbuJ8YVAK0ic7BlkSMSAdYqi4GvuQAx9F8avXwpMOiCksFNYhjjKvPxpscE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762727599; c=relaxed/simple;
	bh=Ik91Thopon6Tumoas6ezzkTtn2KBhQovg72ft8rqYCA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=esSDm7vXPbz+Sut2/lSte5vA4SUWIWV1DIeqPejoZaykyxGRsIu5jjO5CE9320p+qjuTTvjjrs7mgV8SaUstqGe+rbhGB4PG7AhlguSf5fTujV6A72DBcSobUP5DQ/FOje6BjSvKPF7uCTahhjfHqdG4USxDc6ZFIvxIQfjYFdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P/hnEK4y; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-b728a43e410so522790666b.1
        for <linux-fsdevel@vger.kernel.org>; Sun, 09 Nov 2025 14:33:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762727596; x=1763332396; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ik91Thopon6Tumoas6ezzkTtn2KBhQovg72ft8rqYCA=;
        b=P/hnEK4yAKLnD+L+jif4sTXmW9R7jYg6C4PmC53R5UN2DGLB36Hyr+c0eEeiru3BWb
         MsTNYFyGdaWQuaus6zUkB+bWVWgDkvwmc5RCmAfjjfvNrBimGhFZjEm8Ag4X7TIH4VnB
         fnL00boLQp5BENHNKobIUQTuHkjK6RTfxR5ZdYVlOe81ZYt3U7NyXPzIJK976SvbrTYt
         zdkMG82OspQUM/k+vdkFnp3UpviRMm9hkiIz8dUI5jDZbpR/mj2PihcTLUySNWIeBK8R
         +cSMKPGR1LX2GjTvGDAw2/AQsC0sxyogKLSBxhkIC38LrBdNmMNnWWLuPQ9akgP2Cr90
         CxwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762727596; x=1763332396;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Ik91Thopon6Tumoas6ezzkTtn2KBhQovg72ft8rqYCA=;
        b=cHOeS/ZTwTgIHyyNhe/W7dE5/IDSxDBTWSqAx9LNa5EbaYyMMYZIbHjJwNmV0pzfTh
         G1QA7gUirKVucfjyrnCFjy4R3DdJDMrWtWSWEk9WyR0pOV9yjToJuE9A2R5HD4VHKQVv
         jY6PZM5c5ANAJ0HIC4L9j0yeeV+k0wVJodRblkEbNyf4q4BmtZs+tthekNfc5otagADY
         XDUukCdcyqM0gBDHpF6zfenOYlPtu9dwxJqyRbRGP6tX45wIP9GJxnv37b3YtEw17Jlu
         H4l0wIMsAwz5RC7dLYDH9GXsgPKV2ncksc6FFB+yIhjfzj97Nej2CF3WAKlEW+7hvEoe
         3zQg==
X-Forwarded-Encrypted: i=1; AJvYcCX7/lSj4TTUV07l3fi+7B5rm5VxxE/tvgfZsC92r+w5ibnjTO3JSrj2B4AUM1IHIuWaikIWN0++0mafTjzv@vger.kernel.org
X-Gm-Message-State: AOJu0YxjSBSUbG2BTsQw0P20BDbqJjLlOTZre7Xqqb6CHqicL5pyA9dd
	mr/2E36g/GxGH5VRxK11C6QHtmPpXFAsSQrUjhq+h1TVwHjdeIyW9rExYo8/vPurl4CDhS21dyo
	zVbgPDyDsWCmPBjL90W7c9/eLPRw2TvY=
X-Gm-Gg: ASbGncsCjkBnRx7UR9alDNIv5pWtH5AlPkav+Fx+gRojVkxJ6z/4A/02UZRRFZmuno3
	qVGWra5zOVrXaFJopcIOtCeriLFSQlY+0X+Kq75/q2itpHNluFIL5aesoUkAJyTlgRRAJPoAIcp
	R+MonrIUbfIsD03aDiSwe9u66obPbwVKrZ8pqdQEet5dWIxkIsjlgyZXY65ROuj9wboYvHu52EQ
	B1edcyLsC26Y/DuubsAwchTPXurdy2brdfgKANiJTbPOVObtWjolAF091wu7h3/e7wHlpufsJXl
	kT3rYewxXcu72QKeUiUuOTB3aA==
X-Google-Smtp-Source: AGHT+IGAXuUzCiCr2UlFE5rt4GncenzIFzkwMl5gDlCHYQXhQKZkEvl0yPEuoBu5/WrR+tQ9pqCJjRMiI5J3mz/pJMo=
X-Received: by 2002:a17:907:96ab:b0:b72:588:2976 with SMTP id
 a640c23a62f3a-b72e0623e83mr653813366b.60.1762727595687; Sun, 09 Nov 2025
 14:33:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251109063745.2089578-1-viro@zeniv.linux.org.uk>
 <20251109063745.2089578-11-viro@zeniv.linux.org.uk> <CAHk-=wgXvEK66gjkKfUxZ+G8n50Ms65MM6Sa9Vj9cTFg7_WAkA@mail.gmail.com>
 <CAGudoHHoSVRct8_BGwax37sadci-vwx_C=nuyCGoPn4SCAEagA@mail.gmail.com>
 <CAHk-=wiaGQUU5wPmmbsccUJ4zRdtfi_7YXdnZ-ig3WyPRE_wnw@mail.gmail.com>
 <CAGudoHGCkDXsFnc30k10w-thxNZ5c0B9j26kOWsCXkOV8ueeEA@mail.gmail.com> <CAHk-=whxKKnh=rtO9sq0uUL76YGLB3YTb98DVBub_84_nO6txA@mail.gmail.com>
In-Reply-To: <CAHk-=whxKKnh=rtO9sq0uUL76YGLB3YTb98DVBub_84_nO6txA@mail.gmail.com>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Sun, 9 Nov 2025 23:33:03 +0100
X-Gm-Features: AWmQ_blV-P87rGNnE3ChZYuu4mgdUPexUIHqMqYiR-bIQn__LoTAXByyivBDYrw
Message-ID: <CAGudoHHA_dDXMZFh1=U=AjPsqK9PRUGq3fQ_GjOdebUBK-sn3g@mail.gmail.com>
Subject: Re: [RFC][PATCH 10/13] get rid of audit_reusename()
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org, 
	brauner@kernel.org, jack@suse.cz, paul@paul-moore.com, axboe@kernel.dk, 
	audit@vger.kernel.org, io-uring@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 9, 2025 at 11:29=E2=80=AFPM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Sun, 9 Nov 2025 at 14:18, Mateusz Guzik <mjguzik@gmail.com> wrote:
> >
> > You would need 256 bytes to cover almost all of this.
>
> Why would you care to cover all of that?
>
> Your very numbers show that 128 bytes covers 97+% of all cases (and
> 160 bytes is at 99.8%)
>
> The other cases need to be *correct*, of course, but not necessarily
> optimized for.
>
> If we can do 97% of all filenames with a simple on-stack allocation,
> that would be a huge win.
>
> (In fact, 64 bytes covers 90% of the cases according to your numbers).
>

The programs which pass in these "too long" names just keep doing it,
meaning with a stack-based scheme which forces an extra SMAP trip
means they are permanently shafted. It's not that only a small % of
their lookups is penalized.

However, now that I wrote, I figured one could create a trivial
heuristic: if a given process had too many long names in a row, switch
to go directly to kmem going forward? Reset the flag on exec.


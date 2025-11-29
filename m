Return-Path: <linux-fsdevel+bounces-70263-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C746C945CB
	for <lists+linux-fsdevel@lfdr.de>; Sat, 29 Nov 2025 18:34:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2EEB84E0399
	for <lists+linux-fsdevel@lfdr.de>; Sat, 29 Nov 2025 17:34:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7038C257459;
	Sat, 29 Nov 2025 17:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f7GWnThM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 673DE20B7ED
	for <linux-fsdevel@vger.kernel.org>; Sat, 29 Nov 2025 17:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764437670; cv=none; b=gSKOZklqUh5OClDhqTQjahYJ73rq86IvWBIKlpVrBglTrK45M4uoSlvGbnkAq7//X23i9HEKFhRE8QOLuD2UvS839raJ3CpFXRd3t9dk1Ey4Yf1snQ5sKWVi3myvx1vCDdHBrBDHq+pHrGdM1oC2dMKtFaCdAPnAaKiCIZ4vLKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764437670; c=relaxed/simple;
	bh=FuHIwQlAP2udp8Fj5L14YtvfrFs0p8IftgEhMCUlArQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ovuaksTfukhitvjwFKBPeEPAe7NTiRCSt5Ck961Nv0IOmMOfJIEv2HbgeHaM1pR+ZkHrYkCUZN+PLC4ojgZmusFFFxxdJksj/nBD/vX41npQFVOF8EMCRHLQlxy4IJhgoc6OBr3mxYEPVv26HYCN8P7MY1uU5GFk7xtXyBdoc80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f7GWnThM; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-b7370698a8eso211101666b.0
        for <linux-fsdevel@vger.kernel.org>; Sat, 29 Nov 2025 09:34:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764437667; x=1765042467; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=maDmEz6leEp8x7U+/M22lqhF5pJqnpo6KdJXDX8pL/c=;
        b=f7GWnThMerd/210BpPKT/PTJz1Uk07X5X4RB3uqT6Ef+Ni40xKVDXIaVxvUyILd52K
         h/WCWZuGQDWwWq4oJcrQX+6atPBJiu9k4RkqJbYpl4GWyMvqYbEqN6vsTLPo71pGUBRn
         kZDY29UmpGagMC4e1bzyc3RWuFv39znzA/XcKzKnXcpt3aB8rhNQ5r9YszFDqVVi4nDE
         qIgIRiM5W7kY64cZIjeN3GPkZRAXxR8T+2HLsllLiZAOPVsgfitfXFpxpdMTxxvAn8Z7
         ERcVcxmiUQJAh2xLfzibkZHIsZuYIIrCBun44ON1/Fx7e2irVAR3BhVZKwykrRonw6R3
         9XJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764437667; x=1765042467;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=maDmEz6leEp8x7U+/M22lqhF5pJqnpo6KdJXDX8pL/c=;
        b=de5jhGQDlGPJaHlu2mUGKev4jnffBxdWSciUAQ6V89t61AEHOy97QUtWrkk7Zza5Oj
         2Ep7BFFXLVUNeaRytDX7GimJ8JUTeQV960E1pU/lQD4W6fjlzR4Czz9p1VTL9xj0GMzh
         h6nM+ltzCW+3xI90mt90RhPCUpJ7QpUeL8X57YGtiFcNL/ghL318tFXupTWYEDEFoRsI
         hiWrdKpX1bMzQNyVuIj8tyNMEKdvZUHpIODl30LbZAJFFhg2Am6Nt+SJMExeZgwgBrCK
         Zwxyuy3aOEBmesrYAh5XGxptfo2icpxOb9qaD/3m4AEUhGbkmYYkXwrOxijHWg56Kxl8
         9FiQ==
X-Gm-Message-State: AOJu0YxdR3L8n3501PG15vKN+fB+ZWW2aGPd97Kiax02GoxjZZy6P9iy
	KiTzQpOEttFgFsKTFPnoU3AeVnEEw81vlQhm8rsR65hpUMd3qghPD3Pd5yIznD8c3j31MEwTUIH
	T31FKbUm+PdEQVNG/s9YdGru7qm6Z300=
X-Gm-Gg: ASbGncvr3Nc+uCoII6Iiyd8sdjXtU1iYZxO8zGS7YAbB43saT9c1SMe5qpGDJXFtCa3
	IRf4y6MZcX+4iT+nexBwS/5zOqMY1zrMJEaRiHi6QrfaKA/1Ni1FhtYrdQZWOYdCiaM73XTWgPX
	GDi6cTVqfitT/+XHkmfVSZDOfz9GmXOXHC87F06DkghsD9235RJXeUpsm7kYTc40sH4H6mQE3P6
	BXz/hq/goHhpGENR7szWTJeZL3j9n6ED7J6+RSRZlhb1DnIlVhUJQGMHkjecuODodzZqDE8EUtz
	wVNbrKb0K2bYFzNp65P6AQ944goQVJ6w5L6l
X-Google-Smtp-Source: AGHT+IEH5c/pRAcr4BaNTwk+9mX9y+JuA5kpYcYrpik7c+/rjbm2lZ4NulyqOyXcGRACGwaRbgIWFZkTSqKxtbn7HYE=
X-Received: by 2002:a17:907:97c7:b0:b73:4e86:88ac with SMTP id
 a640c23a62f3a-b767153ee6amr3765863766b.12.1764437666585; Sat, 29 Nov 2025
 09:34:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251129170142.150639-1-viro@zeniv.linux.org.uk> <20251129170142.150639-18-viro@zeniv.linux.org.uk>
In-Reply-To: <20251129170142.150639-18-viro@zeniv.linux.org.uk>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Sat, 29 Nov 2025 18:34:14 +0100
X-Gm-Features: AWmQ_bkYhg8ZsPoSvIKVjWFzG0z_YCpKLtzShxZuCW-4-gHoAXRd9J8KuVL5peY
Message-ID: <CAGudoHENCNV87W_wngFsfC99xYohQUiXOjeB24VcYTTOQPv5VQ@mail.gmail.com>
Subject: Re: [RFC PATCH v2 17/18] fs: touch up predicts in putname()
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, torvalds@linux-foundation.org, 
	brauner@kernel.org, jack@suse.cz, paul@paul-moore.com, axboe@kernel.dk, 
	audit@vger.kernel.org, io-uring@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

this was already included by Christian, although with both predicts. I
don't know if the other one fell off by accident.

regardless, this patch needs to get dropped

On Sat, Nov 29, 2025 at 6:01=E2=80=AFPM Al Viro <viro@zeniv.linux.org.uk> w=
rote:
>
> From: Mateusz Guzik <mjguzik@gmail.com>
>
> 1. we already expect the refcount is 1.
> 2. path creation predicts name =3D=3D iname
>
> I verified this straightens out the asm, no functional changes.
>
> Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
> Link: https://patch.msgid.link/20251029134952.658450-1-mjguzik@gmail.com
> Reviewed-by: Jan Kara <jack@suse.cz>
> Signed-off-by: Christian Brauner <brauner@kernel.org>
> ---
>  fs/namei.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/fs/namei.c b/fs/namei.c
> index 37b13339f046..8530d75fb270 100644
> --- a/fs/namei.c
> +++ b/fs/namei.c
> @@ -285,7 +285,7 @@ void putname(struct filename *name)
>                 return;
>
>         refcnt =3D atomic_read(&name->refcnt);
> -       if (refcnt !=3D 1) {
> +       if (unlikely(refcnt !=3D 1)) {
>                 if (WARN_ON_ONCE(!refcnt))
>                         return;
>
> --
> 2.47.3
>


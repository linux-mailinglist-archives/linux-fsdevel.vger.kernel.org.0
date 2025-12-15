Return-Path: <linux-fsdevel+bounces-71299-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id C475BCBD12F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Dec 2025 09:59:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 55CDD3028EE7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Dec 2025 08:57:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B0D3329E4C;
	Mon, 15 Dec 2025 08:56:01 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yx1-f42.google.com (mail-yx1-f42.google.com [74.125.224.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B195832938A
	for <linux-fsdevel@vger.kernel.org>; Mon, 15 Dec 2025 08:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765788961; cv=none; b=iD6wY/kbLtZ6tbVxV2u53IRC3wiRWTGPyf00OwFkcjjMoB5g9XGhiXPWmx4JUPRy2vIDRJj+lFLZjOLpaxBaVj2winrAm31aGEa+MIvdtiRxDf8ZltV/NHwKuXI63Yv92xPT6pfR6HswxtX5npwn7SQ86ECF58qr0siynFeKkT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765788961; c=relaxed/simple;
	bh=JZz9JU4z69cVYdUg7URaUVpfzMhnOcFJCKbJFU1XYuA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qAKr5AIsD3p/2UhAMMvKx70YRUDeZ6jXcWWc0H4fGoch5SpfjfbtZv/TP9f2S9U/DGxcZ096qfFN3KkBMxASShMRh6qkWbjoHL89lcISn7dfFiGiy5NZNw2p50SHZRxYj3y2/w0upz/guRgutNcWHd1CKCLPfZJy4EZ/P2uOOyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=black-desk.cn; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=74.125.224.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=black-desk.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f42.google.com with SMTP id 956f58d0204a3-64470c64c1bso4334830d50.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 15 Dec 2025 00:55:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765788958; x=1766393758;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bZmZ392SyRouDGiRBywTbyIPFjYGlT+0xiRyvkmmrxg=;
        b=QhS6O++wwm2saM2QvyLpAOwBX5YnVVBjFjWZEPad2a9FXRxHzveAKjiV4Gu6kmjxLS
         W4tvRzsxYidG65orgfW8NiaHskQ6qtP9OEHp8qRSy9HhA+4hjeiTeFUiV+moV4i1f/9Q
         wqGaqFzQqHRq/eQbUsQ2Z/Hr8We0jPprG9ERSOGnnkTGmt10kysROler+r8aou9b92TQ
         a3s8Lz+N2OVLgUoal+U+JTV9gPQtz6PLiNWlaWk3/F3G4iHV+STUPDfkA1/utUk0LhJ2
         2TH+nywjsEDNPpk0fZlF6BJ01hSuOv1ygTiuUsrfMosbhL86MQJNShplbMi7KZ4FTFx3
         D8dA==
X-Forwarded-Encrypted: i=1; AJvYcCXOpL00yRo3VuLWuQqrwLUtBe4hNQBE/s8Jq6NR5aqZgXHrZaSaeH/kMU2V3NY34rcQpgCGh2r7rJ7Ac2XB@vger.kernel.org
X-Gm-Message-State: AOJu0YyprkEzN/BLuCkBZQOJvurfXsTyLjeswww3ksLkts76Mu27K/+p
	iuGcHGKEr3Y0/J9KnfS29S//aVixo2yYEH7lVYKXbQ60c1k+LkVKa5cEranQ52s+sHs=
X-Gm-Gg: AY/fxX7tPDeiiWGWVoCEpZ4SRF9iBC01xFhZ91olznrezQSBglvkITID533Suh33uDm
	RTFpzxxfrlgvT760xMAZLz/ivx+o9LCOp/U4IUVb7JVZjQmr0/9noWIzcNrTcfy3uWl5yUYY9Dg
	8iTfrocpZJ2Wd6Ba88S/YbgZz5ARAnqiTzewmLet4m9VLm4rArb3AazdgKoSn+7Hg695BMRQ4MM
	I8vrU8H8Zs5wbJutpXkFSV0qcgY6j9xv2/quHI2tXQgIWgv9BsiApTgSt+UDuWkc92EymH1RNnF
	nGxbUEkE0+TfHihDlRHmFJcsDfcAmejFfwFSsY43lZXBsNf3+H6z4swuD0nSb4YH8bNPUHFh78N
	UjzNDNp/h/ZVdKh+/CvO6FoGipZR+VB1jd5hDFli5lkMscZFQBssRN9KU1GHJOOSOl1whdZp45j
	vgfnAaNJE4SO4s4BlkH5/KW02rry07MFzKq9D7xPfecjH7/2DxC4Ye8g==
X-Google-Smtp-Source: AGHT+IGOHEmlQ20+S/LvvidCUt4RXWNQYoKX4m9pB5LvHzl6MDj2RrjWcXLkI7O/KrFJl2gxBFtFwQ==
X-Received: by 2002:a05:690e:d0f:b0:63f:b353:8fb5 with SMTP id 956f58d0204a3-6455515a1aemr7261778d50.15.1765788958474;
        Mon, 15 Dec 2025 00:55:58 -0800 (PST)
Received: from mail-yx1-f46.google.com (mail-yx1-f46.google.com. [74.125.224.46])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-64477dab78fsm6117637d50.15.2025.12.15.00.55.58
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Dec 2025 00:55:58 -0800 (PST)
Received: by mail-yx1-f46.google.com with SMTP id 956f58d0204a3-64470c64c1bso4334785d50.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 15 Dec 2025 00:55:58 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUDOcjYIyU+LBsRzkXqvXdfRZP9Zw/0PPy4rY4rKJp16faFAdure1Zq02wyXkmVXlMi8/LydPe/ljImWuc+@vger.kernel.org
X-Received: by 2002:a05:690c:dc5:b0:786:a68f:aec7 with SMTP id
 00721157ae682-78d6ded488cmr126790657b3.14.1765788957951; Mon, 15 Dec 2025
 00:55:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251213-mount-ebusy-v1-1-7b2907b7b0b2@black-desk.cn> <k7kcsc6wljl32mik2qqwij23hjsqtxqbuq6a5gbu7r6z33vq5c@7jeeepio6jkd>
In-Reply-To: <k7kcsc6wljl32mik2qqwij23hjsqtxqbuq6a5gbu7r6z33vq5c@7jeeepio6jkd>
From: Chen Linxuan <me@black-desk.cn>
Date: Mon, 15 Dec 2025 16:55:46 +0800
X-Gmail-Original-Message-ID: <CAC1kPDMrF_vZAbPatzgQP_RDowCwOpBV71V1acv5VpogWuhzXg@mail.gmail.com>
X-Gm-Features: AQt7F2q8dQ6TO1jnmhgh6xV5sZ0ve5sQZxU4h-8wlLqKz3QYB8QPxcDhRrAZ-k4
Message-ID: <CAC1kPDMrF_vZAbPatzgQP_RDowCwOpBV71V1acv5VpogWuhzXg@mail.gmail.com>
Subject: Re: [PATCH] vfs: fix EBUSY on FSCONFIG_CMD_CREATE retry
To: Jan Kara <jack@suse.cz>
Cc: me@black-desk.cn, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 15, 2025 at 4:46=E2=80=AFPM Jan Kara <jack@suse.cz> wrote:
>
> On Sat 13-12-25 02:03:56, Chen Linxuan via B4 Relay wrote:
> > If the syscall is restarted, fsconfig() is called again and retrieves
> > the *same* fs_context. However, vfs_cmd_create() rejects the call
> > because the phase was left as FS_CONTEXT_CREATING during the first
> > attempt:
>
> Well, not quite. The phase is actually set to FS_CONTEXT_FAILED if
> vfs_get_tree() returns any error. Still the effect is the same.

Oh, that's a mistake.

> Thanks for the patch. It looks good to me. I'd slightly prefer style like=
:
>
>         if (ret) {
>                 if (ret =3D=3D -ERESTARTNOINTR)
>                         fc->phase =3D FS_CONTEXT_CREATE_PARAMS;
>                 else
>                         fc->phase =3D FS_CONTEXT_FAILED;
>                 return ret;
>         }

Will be applied in v2.


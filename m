Return-Path: <linux-fsdevel+bounces-72188-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A18C0CE7120
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Dec 2025 15:37:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E1C69301F039
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Dec 2025 14:36:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AB90320CD6;
	Mon, 29 Dec 2025 14:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KV3Kygz0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68A4732039B
	for <linux-fsdevel@vger.kernel.org>; Mon, 29 Dec 2025 14:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767018605; cv=none; b=bHvp1TQlbdoaiVVxZWvLHwz+/fT7/zTSgMDQh3OWboX7btuo3sjFylVEbSKy7lFZVgcLgIOOLffnESqeDwNI8CVK7fo8P3qqvE7hugNvkcpjqOVpfQKhZw/jTauX2m0PTE7Fkjlo3YjsIKw21RxN3ciVohXTKcZUQbgA8O5U5BQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767018605; c=relaxed/simple;
	bh=BjExR2fcSwk5ft6XHu7ewQjdKogdco4tISWv876qstE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r4OxT2SAJ8wBr0inSM4ToTAPw3Ok3i0VZpXbPwvlPfFN6dq7h0b2r8oTfJDCqabDEAf93ejAOoq8Zk7MbQCBXaegTcLfg89ZyIey/4WU8aoTeoBif48q0YZxsf1s/eKniJSjH7+mIzvAkK2SgRz5lzwURv/Z2oBUi1aT2fZwclM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KV3Kygz0; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-64bea6c5819so10413449a12.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 29 Dec 2025 06:30:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767018600; x=1767623400; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nUncX7PRBdsLXg+2RDiQBgU1QyWHdZR8qm6qx/C1qPk=;
        b=KV3Kygz0XQb2/t9MGg+pj4p+MV8pMBEV5/eaoLGsJP0YQggwyrfdfMs6Izn9TtwUy0
         o5lpXneg3RBf5oJTxic9aJ4sGhEh6LJcSEcuA0KSpTn0C42PQi1I9yx07CXqzctrN5kX
         qlELV/5+NlkX2/Wta1VTc8ihmyqc3q1TRRhgNYTw9Yuw/jCGx5dXJWXRUeCCKQp+9ZQX
         L4Zp3CFsCC+EhwJiVKc7Psdan2GIJDgsCUcCBBrQJFgAYGcFgx+58P/5bW8vh4anDjrz
         7n/GU943veKOB01pM2glMcw3KrIziCCqtTJOPwYjC4mifvwzK0NbG0YRN0UEVfVt/Zpd
         jWRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767018600; x=1767623400;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nUncX7PRBdsLXg+2RDiQBgU1QyWHdZR8qm6qx/C1qPk=;
        b=E6SL1qEhn1M+TXk6JEkBpN6enzUHTiy9fc/PyUIGMGPMStl0DRAq8nNNAfqmoefJ4J
         ViDoJlMEEG1yArI5WJO2agf2Xumkk0jLR+dJV6zb4PUD5LF8ohi7M5/HmDtd9NrUFK8Q
         DJfmKgX6EMdFfFRCY+n1dSo+8fzXua60dfwF0I5Zh0/n6tJ+xwTgnQ+fUfNjWnNyNizL
         fPp4WToxBxl9EUH7lnVcBz2Zzgwfepy3vK3UEdwyihyYzRw8rMdFL8L/KEpk2pVjAf35
         m3YoGKn0GNPRYFP3bEjmeeJw2MBDWWKsB9IgyjPYaKQvDgUT3N9FNrILUDWuw1NmiS5h
         JXBw==
X-Forwarded-Encrypted: i=1; AJvYcCWKh1dcMsLLq4x6SOsgJD12/ZHwmHtvvyk5ykKuKttlxPSLNF961y0CyMJgJQ5+s39eEkFGUtDe3Gly/Ht4@vger.kernel.org
X-Gm-Message-State: AOJu0YxB4sdMBBL/ZoQFZc6vlMTXup0mE+DvsuJ3nEFcRL54U2bFJ34r
	P7ydqbPwyYIbilD3uz4LGtg7WEaBsxX63ypfR0A/EIHAZY5uoIzjlWbErHwDWNw2crnzzn1vNli
	QobgeOEO9JUSUZphzcnADXjcgwU1VQTA=
X-Gm-Gg: AY/fxX70Jd9DnI7ivrqydz7cg0DtE5RHzKAbUawqCyeud9vrO6587a0w3UlMS1YqqAi
	XXNfgI2xgfb0saJnrrM+eRdg1H+HcyRhdAWpeocHRb4GhzkXeP1JhU2FxX14M9doh5pDQfj4XBB
	1+o/WsDxKZqRnPXIawdSIf093EkMh9pqMBaxYwa3sHZR8CGKYD3fYuyBMwnbHyB1HgKZh1ouz8L
	pgUBWT5op3Y0cfcBXhhSJdM4nztaQarqd3WzIBECgVaWGplzj/cGVywUVoV6IUez/i061uz/AY6
	ZBPCkrBjYglpS5TrYCmGixU3sOTT0A==
X-Google-Smtp-Source: AGHT+IFZz9XX61YXExhwIXv86987Nw+FewSupazYdCLYVs+xCunteo14XdzSlroyODlG9ZYH4HNkxT9brx41xuI87Zs=
X-Received: by 2002:a05:6402:27c7:b0:64d:2822:cf71 with SMTP id
 4fb4d7f45d1cf-64d2822d2d5mr20966627a12.29.1767018600395; Mon, 29 Dec 2025
 06:30:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251229105932.11360-1-linkinjeon@kernel.org> <20251229105932.11360-15-linkinjeon@kernel.org>
In-Reply-To: <20251229105932.11360-15-linkinjeon@kernel.org>
From: Amir Goldstein <amir73il@gmail.com>
Date: Mon, 29 Dec 2025 15:29:48 +0100
X-Gm-Features: AQt7F2rX0VeAJP4K1Kcpmlb1voMbyWLZJUbXM-xp0y3a1-GpMDLvdkp59ZLDEug
Message-ID: <CAOQ4uxh3MM1kToyhpcGR98pD8dH_FMyyvsngnexuqpjU14RfzA@mail.gmail.com>
Subject: Re: [PATCH v3 14/14] MAINTAINERS: add ntfs filesystem
To: Namjae Jeon <linkinjeon@kernel.org>
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, hch@infradead.org, hch@lst.de, 
	tytso@mit.edu, willy@infradead.org, jack@suse.cz, djwong@kernel.org, 
	josef@toxicpanda.com, sandeen@sandeen.net, rgoldwyn@suse.com, 
	xiang@kernel.org, dsterba@suse.com, pali@kernel.org, ebiggers@kernel.org, 
	neil@brown.name, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	iamjoonsoo.kim@lge.com, cheol.lee@lge.com, jay.sim@lge.com, gunho.lee@lge.com, 
	Anton Altaparmakov <anton@tuxera.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 29, 2025 at 2:44=E2=80=AFPM Namjae Jeon <linkinjeon@kernel.org>=
 wrote:
>
> Add myself and Hyunchul Lee as ntfs maintainer.
>
> Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
> ---
>  MAINTAINERS | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 12f49de7fe03..adf80c8207f1 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -18646,6 +18646,15 @@ W:     https://github.com/davejiang/linux/wiki
>  T:     git https://github.com/davejiang/linux.git
>  F:     drivers/ntb/hw/intel/
>
> +NTFS FILESYSTEM
> +M:     Namjae Jeon <linkinjeon@kernel.org>
> +M:     Hyunchul Lee <hyc.lee@gmail.com>
> +L:     linux-fsdevel@vger.kernel.org
> +S:     Maintained
> +T:     git git://git.kernel.org/pub/scm/linux/kernel/git/linkinjeon/ntfs=
.git
> +F:     Documentation/filesystems/ntfs.rst
> +F:     fs/ntfs/
> +

Would have been nicer and more informative if you kept MAINTAINERS
in the first revert patch and then really "Add yourself and Hyunchul
Less as maintainers".

A note about the CREDITS file.
Willy's deprecate commit that you partially reverted added this CREDITS rec=
ord:
`
NTFS FILESYSTEM
N: Anton Altaparmakov
E: anton@tuxera.com
D: NTFS filesystem
`

It is oddly formatted - this NTFS FILESYSTEM header is uncovetional in
this file.
and also, Anton already had a more descriptive entry in the CREDITS file:
`
N: Anton Altaparmakov
E: aia21@cantab.net
W: http://www-stu.christs.cam.ac.uk/~aia21/
D: Author of new NTFS driver, various other kernel hacks.
S: Christ's College
S: Cambridge CB2 3BU
S: United Kingdom
`

So I think that the later entry could be reverted along with the revert com=
mit
and maybe add or update to the Tuxera email/website entries, because the
current W link in CREDITS is broken.

Thanks,
Amir.


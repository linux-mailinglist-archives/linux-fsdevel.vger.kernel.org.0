Return-Path: <linux-fsdevel+bounces-45804-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CD677A7C7A5
	for <lists+linux-fsdevel@lfdr.de>; Sat,  5 Apr 2025 06:54:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8884E17C594
	for <lists+linux-fsdevel@lfdr.de>; Sat,  5 Apr 2025 04:54:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0184F1B0402;
	Sat,  5 Apr 2025 04:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ca5kWAPj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9216383;
	Sat,  5 Apr 2025 04:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743828884; cv=none; b=QkvJdgGr39brcP/A1Mct98cPRx0+oAnDkNlxEIPogXEYZZa5i2DM40Arh+WTPbVfR14/GI9TS/2e1Z+QMnHuSNogWC6MpLb9+5BJYvAs0zr8Agsq8o3aGrMaBqqSaolFISlw/Cz2DX7UCNN2aN98NLzVUCwYwgY/UzytHBL0rDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743828884; c=relaxed/simple;
	bh=nG1KfMCi21VkoOyncF8iU+MfDl1vw2VY6RLzovYDyHA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B1IRf0drt3dc7tSDnhlU6VduJYXPf0bJWiftlMpRiHJ4mXCoak/kXvjjq866nwDDdZFy1E23cQow3F/WAybsTi6JjxrB6nHCDTBiFwN2jxC3aSswobfq6pdFdKh8RfF0EafAaY61YZHOzoFbttxOkKoW2De61btoZa0spyG9MjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ca5kWAPj; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-abec8b750ebso437325466b.0;
        Fri, 04 Apr 2025 21:54:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743828881; x=1744433681; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FgwIujxgtv6O8+KgB2lsc89nQ1Y4gBaGdTYk/GzsDIk=;
        b=Ca5kWAPjb9AAtRmQOBhLdObOZKkEgjuitVau4Hs/er7nRWN/GRDkCfzH4OBAN6I4OZ
         X+3YTSDEVBK4debHJjpYhn13Glv9Bq+t9h9bigvBp4mNp8B3ScLIv33vg58DUimjSVh9
         a4amDgCm/t4GBjGspM97PinyVSSb8W5wUvOPquz5a2ED3eSYErsHQ7Tj+B9dU6AmkLa1
         L7XRbgmKV1CJg9kV/AcbTkHUcL+kGJH0YRGKP2cC41U/tBienOw8gagUuEm2e2kpDcbm
         K9i3xu4lvdtKfHqT250GB3FurDSU6BDmcLKJKJcNAYVQN+1ffaAEPnFsNQ7O3JIXNkkV
         Vpuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743828881; x=1744433681;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FgwIujxgtv6O8+KgB2lsc89nQ1Y4gBaGdTYk/GzsDIk=;
        b=LXcIMpxrDPEowXTlKUEc41nlwD2dVYr6FW0VCUSAFgFpTka5YvCVpHbfNRtnIKXraa
         jFZvBQZLN814s0UKTW+noejnPs//rDzeeo5rjXXegYgHy+9RfTKJCEG+FjSGG8ZuFSVQ
         otq7t6StlAL7FLg5AbX68yuOhvb/QnyBlLYhUb32mUr92+hiyIic2qxgueyPyW4TLORo
         maj5DqRrerGtF4UZG88VZEwxIfJ765pgJIwWwWdtR96jhlJkb0eZKFRtyGfrJqmKEMKn
         WxGif6H5+MnVupP4CUZIyRugfvV6i+B7tyRVlIDA2bQDUbEWFQd1RZjtAPAPsdlxPGl7
         p00w==
X-Forwarded-Encrypted: i=1; AJvYcCVFizq6ZlVFM7nrVQQIwuueLwJ3Y7cc+WYg1awbw/w2nFCkMbFviK0xFSZov6SL8OvYS559ify7RWOk7yUj@vger.kernel.org, AJvYcCXa7ATjzt7qQ26br1a3PLI5u67HatvgB/NyP1ZLef+jgtF4TO6+t2jc5AKgCS9/JekTVFVPrEn9iXL260JP@vger.kernel.org
X-Gm-Message-State: AOJu0Yxf75OY0+04CJOF9ozRzfNOWnDkh2TJsb5CB5STZeIjUASoMx2Q
	dXEVs/dzhnOtnq3lftwpQB4sWXcusf7DZ4mDwceRXvMEV342YY9FYrQnOKou/IHq1tijf0vXv2y
	Oeg0fc+bitOAnV774IhxhlMo9fls=
X-Gm-Gg: ASbGncuJEZup4RDR98dGBFF2VeDTJClJSyMGnCg7Rq/pu0JGHjo4WI6qj/fCtnkPSf4
	v3SSJQfLMhtpLsmui7HB5uM6KCyoRYKIb36+3zpMIYWKNyhdYue/Bo2dTPfYmfgGUr0CeBFDjB+
	O2l9DhU0nhR+95Fqp0UPnGjHM/W/XF7NJyI4QP
X-Google-Smtp-Source: AGHT+IHGm6jty/xrik/LLAA2yfqwc3FBj+1A8wlfL2BLBGLK9diLFUNYnjX3V31wG5kbaDGMuimmimOUYBPG1ZUQojo=
X-Received: by 2002:a17:907:980a:b0:ac2:1c64:b0a with SMTP id
 a640c23a62f3a-ac7e71b254amr134374366b.14.1743828880636; Fri, 04 Apr 2025
 21:54:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250404-aphorismen-reibung-12028a1db7e3@brauner>
In-Reply-To: <20250404-aphorismen-reibung-12028a1db7e3@brauner>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Sat, 5 Apr 2025 06:54:28 +0200
X-Gm-Features: ATxdqUErTBYUalbu-PjJY5f368bM4E-9i7AOj9x_3AzQ16plWjvFowNSDLsYL4o
Message-ID: <CAGudoHErv6sX+Tq=NNLL3b61Q70TeZxi93Nx_MEcMrQSg47JGA@mail.gmail.com>
Subject: Re: [PATCH] anon_inode: use a proper mode internally
To: Christian Brauner <brauner@kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>, Penglei Jiang <superman.xpt@gmail.com>, viro@zeniv.linux.org.uk, 
	jack@suse.cz, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzbot+5d8e79d323a13aa0b248@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 4, 2025 at 12:39=E2=80=AFPM Christian Brauner <brauner@kernel.o=
rg> wrote:
>
> This allows the VFS to not trip over anonymous inodes and we can add
> asserts based on the mode into the vfs. When we report it to userspace
> we can simply hide the mode to avoid regressions. I've audited all
> direct callers of alloc_anon_inode() and only secretmen overrides i_mode
> and i_op inode operations but it already uses a regular file.
>
[snip]
> diff --git a/fs/libfs.c b/fs/libfs.c
> index 6393d7c49ee6..0ad3336f5b49 100644
> --- a/fs/libfs.c
> +++ b/fs/libfs.c
> @@ -1647,7 +1647,7 @@ struct inode *alloc_anon_inode(struct super_block *=
s)
>          * that it already _is_ on the dirty list.
>          */
>         inode->i_state =3D I_DIRTY;
> -       inode->i_mode =3D S_IRUSR | S_IWUSR;
> +       inode->i_mode =3D S_IFREG | S_IRUSR | S_IWUSR;
>         inode->i_uid =3D current_fsuid();
>         inode->i_gid =3D current_fsgid();
>         inode->i_flags |=3D S_PRIVATE;

Switching the mode to S_IFREG imo can open a can of worms (perhaps a
dedicated in-kernel only mode would be better? S_IFANON?), but that's
a long and handwave-y subject, so I'm going to stop at this remark.

I think the key here is to provide an invariant that anon inodes don't
pass MAY_EXEC in may_open() regardless of their specific i_mode and
which the kernel fails to provide at the moment afaics.

With the patch as proposed in the other thread this is handled with
MAY_EXEC check added to the default: clause.

With your patch this is going to depend on the i_mode not allowing
exec or at least the anon inode having a mount or sb with noexec flags
(thus failing path_noexec() check), but from code reading I'm not at
all confident it has one (if it does not, it should get it). Merely
depending on mode is imo too risky as sooner or later there may be a
way to add +x to it. That is to say I think your patch works, provided
the backing mount or sb for anon inodes is guaranteed to have noexec
on it.




--
Mateusz Guzik <mjguzik gmail.com>


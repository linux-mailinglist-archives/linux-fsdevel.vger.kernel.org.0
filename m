Return-Path: <linux-fsdevel+bounces-70659-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A7B3CA3843
	for <lists+linux-fsdevel@lfdr.de>; Thu, 04 Dec 2025 13:00:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B18653089E38
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Dec 2025 11:58:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 334202BD001;
	Thu,  4 Dec 2025 11:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sg8ahjBQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3463D33CEBC
	for <linux-fsdevel@vger.kernel.org>; Thu,  4 Dec 2025 11:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764849526; cv=none; b=Qnv/ndVSylsHdgYUW/dOjcYXB3JMi1jtRBLJ4MNUdlKCEQHDCUy+CFypcixLm/5u66T3EiXU9hvWO/Bj0dJ2iveCJZwRS/zhaYvnYYvWYwmlCkUDW7dQb4itWrtOcKTZcWQEJozmfTci1ISg2arz0uM3TAThHdElH6Y87zj2KX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764849526; c=relaxed/simple;
	bh=G0P/BjEQyt89BmOUGn/wcDWujkDYsVOGhHTJqZN9U3c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Vnbl12gXLU/DbrWRZO1JBitttsnfRD0B8iWLlsg8s6+rAh4Flxoe0bkWiDL+2purK+t3MO5REOYUSoN9l0ae22Eiqx6n+HTtsq/1YZnY7I2+adgtnMqQBacWzs9fBkx00nfl/veuI7AXeWppCTczMLnUpwRgx447bq47LOl+0yc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Sg8ahjBQ; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-b7697e8b01aso150784866b.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 04 Dec 2025 03:58:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764849521; x=1765454321; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kdRxtjV4AYaI8LinC3rLYWwY9We5uYRQ7iuB0whbJMw=;
        b=Sg8ahjBQdLiugsUsxIN3wXWjV1IQjAZsMJZyMsa+xiaa7kPpDhhe26+kXtB6iqs655
         w59StQXlYR8tYB1ksKDqm+1WSHLBtPZEsAlUyDTP9lseOTz0M4gjh2tlOWg7LQLypTjO
         Tr4apvP/4WVoMXPtjfo+0JTpQjn/ZpFAkAQxO+f7rvgfCdc0KeNGOfSeGrWqG1G6joV1
         hHvENml0ob/8HB5nrjAao8oUavQBL09QZBUpn/xFdD0DzXhMr+zwVaTBZARQIUNatb+N
         iUO9Ncbq0e+o/darxLD72szbxhOi3y5DbrbuacyuyytsVjt42Ctib9K/dVImejqPVM0I
         IgfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764849521; x=1765454321;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kdRxtjV4AYaI8LinC3rLYWwY9We5uYRQ7iuB0whbJMw=;
        b=syG2IRUF3ELipqAaerXNWl30YdJP7rLMcMCAnbdEssCJxLIjQq08Ponw6E22RJ+Ev7
         kmJsoT2psreWGUcP79/scYk9c7+iHI4g/bWqk8Y7+wxykENE59s/6Wl0zP0/ws09EQoP
         Nlw497cr1ivahaptmUZ/dzH1pbHvxrFDF8PlP5zWoTw725r7u8TKCf7ltbSIud9IKFP5
         7C0Roqb7l1gjfzru2DPb5dmF5956op8yEvDRCWbBY+k5NYMTDp2GCacT6pH4amVJdGJ6
         RMk1w2a7EVo7r745WWRJOupzkQjNkl+XxFCIDNF0IsC3mDCFqqGri/pDvb/UeXQJBkD/
         lM+A==
X-Forwarded-Encrypted: i=1; AJvYcCW2dPM2qLapga4YeftZCCnl6uv47dlEh0IFz/mDpVyjwUEUSsB63Gt8Qvgp5VHT+KbBssLl1Vr/zYQnQrj6@vger.kernel.org
X-Gm-Message-State: AOJu0Yyiyg7z3hcgN5TwoxBWaaDi7i2NcZT3DZAgANZoEk4A9g82mBtw
	lwUuzAOrX/KN5xVLcCdDObXWJ9S1iXGzjqKvoNL7QTnxOUHn6moE3V/GChiEzIG3r5ra5iOKEin
	ECgPYxXUEmw5mg1NW4TgwfOAM8VqrzYY=
X-Gm-Gg: ASbGncseVJqIs7BIiQWA4E3GR0VEcT7L/WzqoxPnOuF0HqnXXv77M3st8QA3nULBGMF
	SS0hEaT48C6Ca3+p/XMrcZIZ4QpjOaoCanIWsrPCdDO405DY1Uj0TAfEuOTyc9plSKjmnXz0QWL
	6qikMpasO+/QlthN75P4wu6F8OimrXIBFF0Twv3rG11kHcONMZf9xBetrndN0d1GQvrmjXULryk
	PwlLZkFm47LGyxKoTgrYMfFhaE3hMtfLjHj40ttr73aZeu0EODfc8ItyL4yhqOHn1dgjd4PO7Wx
	aiGIyJhPT0hBRkbpxVdtVX7m9Lym3cbId19g
X-Google-Smtp-Source: AGHT+IEZAg/XFTe1Ny7kp3td3ZFktfRztIAEYhqqLPG+NV2hEX+i0dMxJNlWGlVMUPP51XWp+MDN09fnafSDZDrxxXo=
X-Received: by 2002:a17:907:3f24:b0:b73:b05c:38fd with SMTP id
 a640c23a62f3a-b79dc77dfbfmr569759366b.50.1764849520449; Thu, 04 Dec 2025
 03:58:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <y3ucyzxisq6hcrhynzyhmb7h4vpzkyuueqesw547cx5zmzrvl4@offzqo327t4w> <693176d2.a70a0220.d98e3.01ce.GAE@google.com>
In-Reply-To: <693176d2.a70a0220.d98e3.01ce.GAE@google.com>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Thu, 4 Dec 2025 12:58:28 +0100
X-Gm-Features: AWmQ_bkIM7DKIOzDV3ZsYcLI4dGCflwhm-WCUoJ2WXb1p2GWU6R9B8YfTmEKDK4
Message-ID: <CAGudoHG-16TCj3+nMseN9RVeybEPm4WTHn2Xqmek6Hc6k+=e0Q@mail.gmail.com>
Subject: Re: [syzbot] [exfat?] [ocfs2?] kernel BUG in link_path_walk
To: syzbot <syzbot+d222f4b7129379c3d5bc@syzkaller.appspotmail.com>
Cc: brauner@kernel.org, jack@suse.cz, jlbec@evilplan.org, 
	joseph.qi@linux.alibaba.com, linkinjeon@kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, mark@fasheh.com, 
	ocfs2-devel@lists.linux.dev, sj1557.seo@samsung.com, 
	syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 4, 2025 at 12:56=E2=80=AFPM syzbot
<syzbot+d222f4b7129379c3d5bc@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot has tested the proposed patch but the reproducer is still triggeri=
ng an issue:
> kernel BUG in link_path_walk
>
> VFS_BUG_ON_INODE(d_can_lookup(_dentry) && !S_ISDIR(_dentry->d_inode->i_mo=
de)) encountered for inode ffff888074eca4f8
> fs ocfs2 mode 100000 opflags 0x2 flags 0x20 state 0x0 count 2

note the patch at hand made sure to avoid transient states by taking a
lock on the dentry:
+       struct dentry *_dentry =3D nd->path.dentry;
+       struct inode *_inode =3D READ_ONCE(_dentry->d_inode);
+       if (!d_can_lookup(_dentry) || !_inode || !S_ISDIR(_inode->i_mode)) =
{
+               spin_lock(&_dentry->d_lock);
+               VFS_BUG_ON_INODE(d_can_lookup(_dentry) &&
!S_ISDIR(_dentry->d_inode->i_mode), _dentry->d_inode);
+               spin_unlock(&_dentry->d_lock);
+       }

So the state *is* indeed bogus and this is most likely something ocfs2-inte=
rnal.

I'm buggering off this report.


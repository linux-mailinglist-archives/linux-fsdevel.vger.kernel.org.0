Return-Path: <linux-fsdevel+bounces-13172-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E9C9586C3F0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Feb 2024 09:43:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A16481F24A3A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Feb 2024 08:43:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20A574F615;
	Thu, 29 Feb 2024 08:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MW9qslLd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 220D144391
	for <linux-fsdevel@vger.kernel.org>; Thu, 29 Feb 2024 08:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709196191; cv=none; b=YYADJ4z41vftmxiVfew4dkmNVa3+I3RYgaM3U5rc2q1o5YOp8nGQmfMkTRCPTOHdxHWrK1kR/YaaqhopwGDglrmdAvyBcUdK7r/gwaucLZrR8IJK/DwDLqYGW4eD3I25G+qchYlH5KiVXySrj2rKlZZ+U0rt1L+2h+JojjHRX3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709196191; c=relaxed/simple;
	bh=hikBQBwK+HCibV9Ay+uw3hwq6fhlJ+kbZbSIdNLQbuc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jw1VU44tc9kOODpB804mA6AZWfo0CcndhABOAGl+H5UFiaQ327LlqdCfefgwO4pDBjeKNTEKytXi+blG07T8kl0zEoTyiZICMFJd2mjxOURsJYw2lmhCmgzsOv93j1c0PwwGhfDrZUMwUp2LMuzYWdKOwf1oSlKp1YcVV050JuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MW9qslLd; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709196189;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DEuBlHD3kgoIX0ziveljn5872wJi8XDsY60eCgSwad4=;
	b=MW9qslLdZwCW3fRiPfuIk56YiiyYuIdZhYkCK9JiFrrlCDca3VDd9haUpsWxEMHh6R5Qx7
	IDxnwBPFM8sD8woZOPSGAXN76WDgg205MjAKkilhJK+GryPELnhSjE/NyZ0J/RpZwzd8vV
	k+cDPsG5EUQeJ7CQ1qG9hTwVtxEgmF4=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-635-1eCGEmuGOSGMuS4uyyS28g-1; Thu, 29 Feb 2024 03:43:07 -0500
X-MC-Unique: 1eCGEmuGOSGMuS4uyyS28g-1
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-1dc685df4adso5312445ad.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 29 Feb 2024 00:43:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709196186; x=1709800986;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DEuBlHD3kgoIX0ziveljn5872wJi8XDsY60eCgSwad4=;
        b=aZx2RG1DAH5ysSudQRKHujlCPnjUIyfJuNvL1oJKBNO2LivCR9vcMyLWfLATFpfgoK
         fE9POrQ4uyq48IHAScJAG1bokMRQSs5CeMAv8mjdTr0Q8LgNSjVhCGE0fcqhV1G4QicJ
         aZXnzMgvjFwj/kOuclHPxM8V8iDpdJAi904yKahsS6NwpYbgFY6IselFI+tUIK7Kt0Hr
         ZNB+XS7PTPO0/MRME2QHZgW7+XiJTsXglcbci1Fv2pzMrg1iTa5tQEncsWnLoRfEMsDo
         +YorePBMlMx9cLPi4yG4HGUn5WjPxfeqlPss00atYifXydTP5c+qzO9wpdoxQ7oVLi7t
         ImQQ==
X-Forwarded-Encrypted: i=1; AJvYcCX+xDh6uenl4DCDkH3l5lEPwZ8NStRqCtiat7borwV0iHKLzkxoTKpLoEbDpQTD23bsJnsXZhOfwYe1DgCco8s9Gl09TnYG89Yf/X/oSQ==
X-Gm-Message-State: AOJu0Yw5Ifp+kMPRT/RtyjewU2yyncq6uTyHJAayjq5ww1C8Qg81L1MS
	T4pBn2Rhk7nXb1SpuHKxtcPsyG/PlJw3Z49qljjPKkJtEBSI2iK+7i88mPBDDQbeq/em32tvPcC
	0y8jAL9vHVIR6XrxSh31C/Y6D/FKIpVpcdzFBa5NcNWxPLpgATTZfaEHaiIfUaFwEVK+IPxT8/J
	1vX+oimP2Jw+dwQsEw4eyAsTdPxR1a0oPoi65fEePxuVkDVw==
X-Received: by 2002:a17:902:da8f:b0:1dc:ca09:6b7d with SMTP id j15-20020a170902da8f00b001dcca096b7dmr1826115plx.2.1709196185780;
        Thu, 29 Feb 2024 00:43:05 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHRJixUvjUtpkuPEzMa01pFKLhC0GOFKYvulFM09afef/K1eyl+EDf7oLoFQwQVwElle44GHMlouy/Ss7TyUcc=
X-Received: by 2002:a17:902:da8f:b0:1dc:ca09:6b7d with SMTP id
 j15-20020a170902da8f00b001dcca096b7dmr1826093plx.2.1709196185336; Thu, 29 Feb
 2024 00:43:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <00000000000029b00c05ef9c1802@google.com> <000000000000cf2d2d06127def32@google.com>
In-Reply-To: <000000000000cf2d2d06127def32@google.com>
From: Andreas Gruenbacher <agruenba@redhat.com>
Date: Thu, 29 Feb 2024 09:42:53 +0100
Message-ID: <CAHc6FU7GqeMROfnoFLbTaNnoDhwr1+eFAsP_=rQD_JkfF__AqQ@mail.gmail.com>
Subject: Re: [syzbot] [gfs2?] WARNING in gfs2_check_blk_type
To: syzbot <syzbot+092b28923eb79e0f3c41@syzkaller.appspotmail.com>
Cc: axboe@kernel.dk, brauner@kernel.org, cluster-devel@redhat.com, 
	gfs2@lists.linux.dev, jack@suse.cz, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, rpeterso@redhat.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 29, 2024 at 5:46=E2=80=AFAM syzbot
<syzbot+092b28923eb79e0f3c41@syzkaller.appspotmail.com> wrote:
> syzbot suspects this issue was fixed by commit:
>
> commit 6f861765464f43a71462d52026fbddfc858239a5
> Author: Jan Kara <jack@suse.cz>
> Date:   Wed Nov 1 17:43:10 2023 +0000
>
>     fs: Block writes to mounted block devices
>
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=3D108aa9ba18=
0000
> start commit:   861deac3b092 Linux 6.7-rc7
> git tree:       upstream
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3D10c7857ed774d=
c3e
> dashboard link: https://syzkaller.appspot.com/bug?extid=3D092b28923eb79e0=
f3c41
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D1440171ae80=
000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D11b1205ee8000=
0
>
> If the result looks correct, please mark the issue as fixed by replying w=
ith:
>
> #syz fix: fs: Block writes to mounted block devices

Sounds reasonable:

#syz fix: fs: Block writes to mounted block devices

Andreas



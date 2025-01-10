Return-Path: <linux-fsdevel+bounces-38841-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BCC46A08BBC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Jan 2025 10:25:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5470B188D5C5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Jan 2025 09:25:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1265220C02F;
	Fri, 10 Jan 2025 09:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=m.fudan.edu.cn header.i=@m.fudan.edu.cn header.b="NLqh4mZw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtpbgeu2.qq.com (smtpbgeu2.qq.com [18.194.254.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15ED820A5FD;
	Fri, 10 Jan 2025 09:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.194.254.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736500931; cv=none; b=WDfK4bHINxlp+e/HH8ZWHtn2jIkUKLMJQpgIz6wrt+NDAZZP7nM8p7G7eLBd35kyFy42GV8IXyyPNIbU217Q2LIXce91u1dwY0cr8r9xvAhE/kZllkDoVk1Wkpw4Q5yoZ8jkLnkcw+HbV+9UBoghH1citShuov7BVqvYgGM3Z8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736500931; c=relaxed/simple;
	bh=Mqm65RtEOGiTIeRUEYnhvEvP4IJqLlmBHPP2vGo87Aw=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=UJPHlBO1qgE1nlOcMCsp5uhlI/AbZbeLt2fExwL0uxlPkRntkh4vHQJ7q0W+UJHs9xp0i8uptEy3xqo7QdgcINa+T2cYi0EUEYTAta98dIVH2HBBuV6RdbFFnfTN0tC8smEmpIlWGvbRXrsgQ+A4q3zet3rELmZbeuC3JhPsUpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=m.fudan.edu.cn; spf=pass smtp.mailfrom=m.fudan.edu.cn; dkim=pass (1024-bit key) header.d=m.fudan.edu.cn header.i=@m.fudan.edu.cn header.b=NLqh4mZw; arc=none smtp.client-ip=18.194.254.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=m.fudan.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=m.fudan.edu.cn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=m.fudan.edu.cn;
	s=sorc2401; t=1736500897;
	bh=Mqm65RtEOGiTIeRUEYnhvEvP4IJqLlmBHPP2vGo87Aw=;
	h=Mime-Version:Subject:From:Date:Message-Id:To;
	b=NLqh4mZwFpLevBSG0VS8Rtz/t9IEYFOc4QLKVODc2nEfP4AtBfbwwwNuCmUVKsaAc
	 R3fGa1WZfYBPiWZrfREb4p9EahRJjdMfxZ4lX8RHXQSwIKu+tRbMF0j1TmRQHYT1/z
	 V9FIQtCos2qP/FUFSGqi+mlXIAj+L6S/BYHkZ4qo=
X-QQ-mid: bizesmtpip4t1736500891t7obvmm
X-QQ-Originating-IP: Sz9axSVXQH/lEcHIDTIgSlyVUxF0X5TgqmbBgqcGXAI=
Received: from smtpclient.apple ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 10 Jan 2025 17:21:29 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 8432799972483507771
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3818.100.11.1.3\))
Subject: Re: Bug: slab-out-of-bounds Write in __bh_read
From: Kun Hu <huk23@m.fudan.edu.cn>
In-Reply-To: <6yd5s7fxnr7wtmluqa667lok54sphgtg4eppubntulelwidvca@ffyohkeovnyn>
Date: Fri, 10 Jan 2025 17:21:19 +0800
Cc: viro@zeniv.linux.org.uk,
 brauner@kernel.org,
 linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 "jjtan24@m.fudan.edu.cn" <jjtan24@m.fudan.edu.cn>
Content-Transfer-Encoding: quoted-printable
Message-Id: <31A10938-C36E-40A2-8A1D-180BD95528DD@m.fudan.edu.cn>
References: <F0E0E5DD-572E-4F05-8016-46D36682C8BB@m.fudan.edu.cn>
 <brheoinx2gsmonf6uxobqicuxnqpxnsum26c3hcuroztmccl3m@lnmielvfe4v7>
 <5757218E-52F8-49C7-95F1-9051EB51A2F3@m.fudan.edu.cn>
 <6yd5s7fxnr7wtmluqa667lok54sphgtg4eppubntulelwidvca@ffyohkeovnyn>
To: Jan Kara <jack@suse.cz>
X-Mailer: Apple Mail (2.3818.100.11.1.3)
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpip:m.fudan.edu.cn:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: MQ+wLuVvI2LQExZhOW1NPqOitxu0zbonXAyW2I5ya7J8SG6bz4u1Ol7u
	YFpnfeaOBtUkuw3SFBERKRU4JGjHFm8hnYsEhwAjdFqxMzSG+UsUYi+MalJy4HCs3mtXSuA
	4yrljlaNi4FvHBY5zbm49EYa97NijK/1Mg6iQg9Qs1mMTfMSzPtFR13O03VrdF+VaCSaIqL
	/36E9fDbEMrA8sJ0eKgqbpwIw1ZYSD16ZBcEOcrj7k9HLGXMlMdJupsMNdNN6HVt9xf++Tu
	JznFQ9jFSD16liZL/fZK1jgwPFOmL6eiIcdmP/Oi0NWACIpIIwW7GykQl7PI2Fqp3lj7J/Q
	0v/Kpd9m1R/ftLDGEEm1GGNPt0X5ivLuU9aegI4IHkjNpW463hUWfXo0m4HoyZRbhAdgY6s
	AxJOEoTFCDbiYz/gA4ohkeIDU3zSjgLhvDtNxMhdUiBVvwttjyvk/NaEQt5/R57ZA2Q8WmE
	pRG7T5KWU1Qab3BFaXzk1jWZCLQBe1ANYsBeF/2ifvqxVWxrX7SRRVpGnLltk6RLTw9t03h
	c3GwvzMhq8CSqUXzpMTTIbnCe+7VlNxoranMkl2cYDXiJ9LFPRuUSQ36bCsL2Nw6yNO7zm3
	S/xfVS1MQPo+TM/1SUwdv615y8L72a16qR4iLmoJuLPv1E6UuY1yj5TZZzVwPuhiV/gfiYg
	S8/i9V/Kzlq5nwb6SqPtc6vg+W4PbPafge3djQKUJph49PmToupAwyLDWtOLMgKx5Tgv1Io
	95z9Hj1vSFW58PiufNfGZhvqslY/a6CT3vgzFGF7VbltpJZRKEBF3AOlf+GZ51smtR0J9Qt
	bwrhHtd6LkeUPXKmxkqrgMaS3C9N3qLEKeWC9z9WTIP2FQK1v3IT4yG4Vw02Fj1EJlE+pWC
	211lkXf5NBI7nGklAx80Xh4MaOyfWcifqM1+tT5DScqJKt/aKQ87S1mHufGCbVUXHbo6cTy
	ortLVHEzBs8GEzDQGzYUNu2O+IsdPJ213fwIMlTPbbWZt7Q==
X-QQ-XMRINFO: NS+P29fieYNw95Bth2bWPxk=
X-QQ-RECHKSPAM: 0

>=20
> OK. Checking the syzlang reproducer the same comment as for other
> filesystem bugs applies - please run with CONFIG_BLK_DEV_WRITE_MOUNTED
> disabled to rule out corruption of a filesystem while it is mounted.
>=20
>=20

Hi Jan,

We have reproduced the crash with CONFIG_BLK_DEV_WRITE_MOUNTED disabled =
to obtain the same crash log. The new crash log, along with C and =
Syzlang reproducers are provided below:

Crash log: =
https://drive.google.com/file/d/1FiCgo05oPheAt4sDQzRYTQwl0-CY6rvi/view?usp=
=3Dsharing
C reproducer: =
https://drive.google.com/file/d/1TTR9cquaJcMYER6vtYUGh3gOn_mROME4/view?usp=
=3Dsharing
Syzlang reproducer: =
https://drive.google.com/file/d/1R9QDUP2r7MI4kYMiT_yn-tzm6NqmcEW-/view?usp=
=3Dsharing

I=E2=80=99m not sure if this is sufficient to help locate the bug? If =
you need additional information, please let me know.

Thanks,
Kun Hu=


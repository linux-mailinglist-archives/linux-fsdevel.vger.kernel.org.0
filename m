Return-Path: <linux-fsdevel+bounces-51648-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B64BAD99AA
	for <lists+linux-fsdevel@lfdr.de>; Sat, 14 Jun 2025 04:29:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E25EA17C3DE
	for <lists+linux-fsdevel@lfdr.de>; Sat, 14 Jun 2025 02:29:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3F96136348;
	Sat, 14 Jun 2025 02:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="TbhnSsGu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtpbgjp3.qq.com (smtpbgjp3.qq.com [54.92.39.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CE5B320F;
	Sat, 14 Jun 2025 02:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.92.39.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749868181; cv=none; b=g0WS1NuJs8/x8P+TeusnqTZUGyDnubmfeyieebg2cVP/31czS3p4Ni97anaIGuhARmS0KykBRhpW6y0iYgIXRHoGz+GW2mFVfff6SpFxDBmTxQ4tJ9+CnjQB7lb6/jKSKe5RoXY0FCqxrQaGYFJCeRjNXfXtuEC+SX2SPBjRArU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749868181; c=relaxed/simple;
	bh=BovxG10OZYqF6W5tq+yAPUVvqZuanHu7KGWMGNq8AGs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ursxs3FReL6KS8DTwwEOi2J304eZjli763hWNfTQIj1HXj9yGPlujUzx7zj49+MOiG947phk8ZHxcaplbq/pCjeGDjEorARNUnfpKdl/N1l+rVqXXhlIAbntaw5xJoIs1uSZ/z98RxdKt9uuAekXIw9MGExTO8Moel/b/B9mtfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=TbhnSsGu; arc=none smtp.client-ip=54.92.39.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1749868164;
	bh=BovxG10OZYqF6W5tq+yAPUVvqZuanHu7KGWMGNq8AGs=;
	h=MIME-Version:From:Date:Message-ID:Subject:To;
	b=TbhnSsGu2AzCWsOUu32kpMJhyhMUPwrIp/ObFG0RVdBxAqXEPdtBiQZbbclHQp2AA
	 Pizx8UpIy52fYwsfPF88ELeqhIKhoT1UMODiEvSN7i35Bn6LIQpzdTRYIhzNM7493U
	 qs8TX/mCxJUufytjmhfQH8PxpGHwRAGdqrya47mg=
X-QQ-mid: zesmtpgz4t1749868161t60c621e0
X-QQ-Originating-IP: HQ1RifYPmrBvX4nJYiTppklWoUSlq/+jeJSe/oh002w=
Received: from mail-yb1-f170.google.com ( [209.85.219.170])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Sat, 14 Jun 2025 10:29:19 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 17128236805914846518
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-e81a6da56b2so1952783276.3;
        Fri, 13 Jun 2025 19:29:20 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUJp1d+Q7v3Ol18kppXibva4o7biINJfTvw2cRW83E1t89wZ1BL3hma3jQyF1c1RrpzL/jW1U/ku1Zx+cCv@vger.kernel.org, AJvYcCUeQufS1vJRnFK2y95icskimaaMPu+xQEQ4AVVjshICtMtJD20/fQjXhPwEiJGWlInbhIsVMD0mhuN6aJP50T1N@vger.kernel.org, AJvYcCXFpNNxmHZnXiaI2HC3/JSMV1aMUecaJK308iQQPbuwptTYoZKWAVrR/U0llyt/QRroNuzZin5SgSN25iEF@vger.kernel.org
X-Gm-Message-State: AOJu0YxqEJFdRU1wOwq3QJouVUixg+u6S3xuyoY/YPi+z/Acw9jyHLpD
	f8Aq5GzLJ/PrsqQeJlXaIzd+HYHCC+LPPZ4cu2Yq9uRHXI1vHSmzxeeF4qaIhVnu8VvkeZOqof1
	y4Nmc7E5vz4uT4EEBw7qhWsU+ApLkBog=
X-Google-Smtp-Source: AGHT+IGeNNvwOwAtaxQXk0HpW6trsT1/uxwZhODR+aTOWuDPm2/IDyjtvVhhpVls3I7U/ySgcvAXiXClyo/4la4+70w=
X-Received: by 2002:a05:690c:25c9:b0:710:e966:bf96 with SMTP id
 00721157ae682-7117544ca55mr25388537b3.27.1749868158733; Fri, 13 Jun 2025
 19:29:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250610021007.2800329-2-chenlinxuan@uniontech.com> <CAJfpegt8Hk6nt5+iPg-if9iquWqr3eecgDSKYZvJY0OX+y5b9A@mail.gmail.com>
In-Reply-To: <CAJfpegt8Hk6nt5+iPg-if9iquWqr3eecgDSKYZvJY0OX+y5b9A@mail.gmail.com>
From: Chen Linxuan <chenlinxuan@uniontech.com>
Date: Sat, 14 Jun 2025 10:29:07 +0800
X-Gmail-Original-Message-ID: <AD14EFC7B36E9425+CAC1kPDOvZnjDR9-FxxObdJJDuZ4p_uP=3hkkCUi+S=p-jYT6fQ@mail.gmail.com>
X-Gm-Features: AX0GCFuGxAdS_kbYhyuhWm8A4nGla2TR44oTlyAhwzQSDVgEI27EUb_JGxe0VDE
Message-ID: <CAC1kPDOvZnjDR9-FxxObdJJDuZ4p_uP=3hkkCUi+S=p-jYT6fQ@mail.gmail.com>
Subject: Re: [PATCH v3 RESEND] selftests: filesystems: Add functional test for
 the abort file in fusectl
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Chen Linxuan <chenlinxuan@uniontech.com>, Shuah Khan <shuah@kernel.org>, zhanjun@uniontech.com, 
	niecheng1@uniontech.com, Shuah Khan <skhan@linuxfoundation.org>, 
	Amir Goldstein <amir73il@gmail.com>, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz5a-1
X-QQ-XMAILINFO: MfMKp/VE+ZXdb8puI5hdDSN789SNzcKwpowcwTeEgu1lfmrZzg+lJF7g
	UUnwbIjIqeaoKEoidrQ6obPwJgBqK8LfkpGbZezdszSep3o4kpSkJJgUqn4m6tD36ngApe7
	ynEhh11QUdFMMW94Z7ztLy5bmqdQGv1fNu3whIEZKZZ+16mTN+wRA2aVOEprMKsOZA+8n+S
	bDJQjiTOqqVNC4Qov6CKQZRph8p68xH8ebkvXDN3MnQPwSkt/ngy7QhNcuA7i3WaYAM6wVq
	ESOC4mtu5jJjoqVHgY8P00SUr3pdDUkybcOc9IufdQ70W8eV+kJQjNXM8EAiWqJ0VEOJAdm
	wUBTeIh+cl8RJfh9EZ9a6BMQE1gE4cWOXS+ZQgGNhhRumXmGKnHqhQmHMlwP7ytnMri5R5X
	3riIWqaxtG+DnpqAGDXDpdcHjwBHd5L+GsiEIuH217ltSAeVd9Pq1GPrwe9qPC1HS1UbUKi
	goPZ3kvyBMxpj4aIdzfnjK1KY1CHt2yV0MheLFhmnPDeGGQQPN1BDpTwuvZGzUyH6duWFcX
	e5tUdf45vhGZM395KA496/niQZ72V0+AkN1hIgF1usI9fwIP8rkBylp3RcuKgBVUYcbg4iq
	w27e8HFlKhFpd3tAcXj2nIx34X5f/MqMWQpaL1UQRZvU+7FsTtTFvl1dJnZBwU551enWxw+
	TsHDMn4Jfs4qQyXRWQoDcgjFdfYwyx8xgUlsUOCEgyLvkgsEEzN6+dHa+ezQxTwsQemwAXA
	Wh7e2ove9QgpCFC++epPJlkFucKfX6i0nlIkWj00mPITOqMn155j3fuw6B2+4A2rUrSKDEC
	67Az/JJE8ifFJQvE9wWn+r9ln6ImE6XTVSdSCbsQdLBkWrXl/fKDFacWFX6zhbeYAT9bKzf
	DNjetx0AnIDZxVKGSYXwwcknUSq0q4zXjxRytWE9+j29EySs6YVvRy0OBKGioQGFvfvHv2b
	tpwKqH7NQ7zwB8XNpD8RkYQQNhGsD3JTwQzMpL0334NGxlXYanYhb8Si6gFdTo61APwCD6a
	Kr15eQ9bFYrNzKs3hMmheoDvDWu13y3Jla1cJpAncLdvUGLUX+nR3T4it1NH2TxjFIYR/R5
	Q==
X-QQ-XMRINFO: NS+P29fieYNw95Bth2bWPxk=
X-QQ-RECHKSPAM: 0

On Thu, Jun 12, 2025 at 4:56=E2=80=AFPM Miklos Szeredi <miklos@szeredi.hu> =
wrote:
>
> On Tue, 10 Jun 2025 at 04:10, Chen Linxuan <chenlinxuan@uniontech.com> wr=
ote:
> >
> > This patch add a simple functional test for the "abort" file
> > in fusectlfs (/sys/fs/fuse/connections/ID/about).
> >
> > A simple fuse daemon is added for testing.
> >
> > Related discussion can be found in the link below.
> >
> > Link: https://lore.kernel.org/all/CAOQ4uxjKFXOKQxPpxtS6G_nR0tpw95w0GiO6=
8UcWg_OBhmSY=3DQ@mail.gmail.com/
> > Signed-off-by: Chen Linxuan <chenlinxuan@uniontech.com>
> > Acked-by: Shuah Khan <skhan@linuxfoundation.org>
> > Reviewed-by: Amir Goldstein <amir73il@gmail.com>
>
> Thanks.
>
> I suggest setting up a userns environment, see attached patch (also
> fixes a EBUSY on umount/rmdir).

The v4 patch series has been sent with your suggested changes applied:
https://lore.kernel.org/all/20250612094033.2538122-2-chenlinxuan@uniontech.=
com/

However, I have some concerns about creating a user namespace.
Some downstream distributions (such as Ubuntu?) may disable
unprivileged user namespaces by default.
If we create the user namespace before mounting FUSE, these tests
would require privileges.

>
> Thanks,
> Miklos


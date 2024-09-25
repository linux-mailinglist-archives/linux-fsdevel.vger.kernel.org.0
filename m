Return-Path: <linux-fsdevel+bounces-30094-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ACA07986170
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Sep 2024 16:51:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD66C1C26CD1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Sep 2024 14:51:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2B53193435;
	Wed, 25 Sep 2024 14:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZRVKH3Lg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8C33186614
	for <linux-fsdevel@vger.kernel.org>; Wed, 25 Sep 2024 14:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727273781; cv=none; b=iXD3fUGzQNVlnx/h+jkyURsgwSAPmfK8a7gnNnMLXq/FB6G/Nzew8IteqECo0SUUJGs5+yXXqWRtrvH8K6bYk5f34NXGEJdt0nSwolY7GPYXkN6TqF5Q4saj2v3O7sUy5/JrB58wvO3AQz8x2xNd02VWwtTY4h67Ts5Q7/Jb0Uk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727273781; c=relaxed/simple;
	bh=VDeMpAMbnZy5A7Fs5mK35QoMo/QnecaTFugYTwoT5+I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h0w7YoWOVFYEI1LfxOklsOy1lYdZI7QAYePEMPpeLNrGOvh3SfdBu4dD4jdgTYpgRamq+loVlSrAABcQ/Qufo4ZfG4/QVgGkdObppYRyBAriUac5TNo4uMDXpeVl40SukEe9/Pe8uGQeB3TwC7FrWqJ+5Plsu27KfzA+pQAjMH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZRVKH3Lg; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-7a9a3071c6bso763980685a.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 25 Sep 2024 07:16:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727273778; x=1727878578; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VDeMpAMbnZy5A7Fs5mK35QoMo/QnecaTFugYTwoT5+I=;
        b=ZRVKH3LgLJR0ICmiPTxAOUtJIaXwnAHO4vRucnK6KFjWrv/LAupz9shmepV0TtsS+7
         tzDHiLsYm+qhk4xlZJGff29IImQhi2TNeqDsQDl6zmziU4jn7Un19l16qMh0Cw01dvqP
         JReLVxF3NONHCnk7ONw0EWgjh8Z3eLdWkSREF+xVnH8I9eaXKdVrX0CWwcfpWaRqIjUi
         kjYuvm/UHoar4VVq72mpTtzVwAT3ndUszlUMUmnmHmfiE8vYLnmO6OjYc2+pbFBsR6Ho
         UEcI4niZya8Y6ckFMOEDyfVP19Oanpj/C6NuxrgaoXRyAHTGLKWFySiOiAGeYnwdnhdv
         gV9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727273778; x=1727878578;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VDeMpAMbnZy5A7Fs5mK35QoMo/QnecaTFugYTwoT5+I=;
        b=EP3pJikg5LpAs8JOPLXGTRdpbWqtANSDHYoueUULQpRiDeP0WY1/apc5JNQAkw25SA
         liM0kMiMGHRz6kpMS1mrU9qYnt3u7JlWduSMdpsn4GHuaunNSN2ANQXtkN0nVNR/rFxE
         rks8eT4KEzxw28M9CXcD+QK+9Q/+sbFe3YxzHb9zwMM1nb1Y2Fy/SfCO72s+oK9pnlHU
         tzagUTrHBk3N8NvYfz0AnwM+7vNc4XCnxOr4wUSEWCohJwDeZy/CyWevkikY2N+zvvPA
         4F3PCbXlp1avbj1WefMVgZRhaX9GgOMDtlDq91JOxAPie/rPypB1jRC0I1dNI8VZsabR
         x5Mg==
X-Forwarded-Encrypted: i=1; AJvYcCW1JfMj0kEGrwdah6ygSir/SGlgmBmYouZ8XIcdFvnNWLr+yOyuSgSzw2iMWPZaKqRyr6blGlhCPrlHS4+J@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3hvGqRhyeRqwKgaIBuUPmr+7jaAkKVbMKQU3l5JpVK+/Y7nV+
	cERDmSyolgALD/IKA/WdGb8Sc5PFQwzO18teV5+DE0FO36rWbm9KW80OY12Fxa69kof+luCnR5n
	VIb9dcWqGzPjSKpLyYec8upRwxdc=
X-Google-Smtp-Source: AGHT+IF3zXbFwb9usZNQiYWwUWXQ2R8F+mTXhYQZHgcWCBzoOIkDRSsLnKCX2yep9/t0y2PvVnB3vaHwUXngmZ8c4Iw=
X-Received: by 2002:a05:620a:4105:b0:7ab:36c8:6607 with SMTP id
 af79cd13be357-7ace74598d0mr353955385a.54.1727273777942; Wed, 25 Sep 2024
 07:16:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <SI2P153MB07182F3424619EDDD1F393EED46D2@SI2P153MB0718.APCP153.PROD.OUTLOOK.COM>
 <CAOQ4uxiuPn4g1EBAq70XU-_5tYOXh4HqO5WF6O2YsfF9kM=qPw@mail.gmail.com>
 <SI2P153MB07187CEE4DFF8CDD925D6812D4682@SI2P153MB0718.APCP153.PROD.OUTLOOK.COM>
 <CAOQ4uxjd2pf-KHiXdHWDZ10um=_Joy9y5_1VC34gm6Yqb-JYog@mail.gmail.com>
 <SI2P153MB0718D1D7D2F39F48E6D870C1D4682@SI2P153MB0718.APCP153.PROD.OUTLOOK.COM>
 <SI2P153MB07187B0BE417F6662A991584D4682@SI2P153MB0718.APCP153.PROD.OUTLOOK.COM>
 <20240925081146.5gpfxo5mfmlcg4dr@quack3> <20240925081808.lzu6ukr6pr2553tf@quack3>
 <CAOQ4uxji2ENLXB2CeUmt72YhKv_wV8=L=JhnfYTh0RTunyTQXw@mail.gmail.com>
 <20240925113834.eywqa4zslz6b6dag@quack3> <CAOQ4uxgEcQ5U=FOniFRnV1k1EYpqEjawt52377VgFh7CY2pP8A@mail.gmail.com>
 <JH0P153MB0999C71E821090B2C13227E5D4692@JH0P153MB0999.APCP153.PROD.OUTLOOK.COM>
In-Reply-To: <JH0P153MB0999C71E821090B2C13227E5D4692@JH0P153MB0999.APCP153.PROD.OUTLOOK.COM>
From: Amir Goldstein <amir73il@gmail.com>
Date: Wed, 25 Sep 2024 16:16:06 +0200
Message-ID: <CAOQ4uxirX3XUr4UOusAzAWhmhaAdNbVAfEx60CFWSa8Wn9y5ZQ@mail.gmail.com>
Subject: Re: [EXTERNAL] Re: Git clone fails in p9 file system marked with FANOTIFY
To: Krishna Vivek Vitta <kvitta@microsoft.com>
Cc: Jan Kara <jack@suse.cz>, 
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, Eric Van Hensbergen <ericvh@kernel.org>, 
	Latchesar Ionkov <lucho@ionkov.net>, Dominique Martinet <asmadeus@codewreck.org>, 
	"v9fs@lists.linux.dev" <v9fs@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 25, 2024 at 4:04=E2=80=AFPM Krishna Vivek Vitta
<kvitta@microsoft.com> wrote:
>
> Hi Amir, Jan Kara
>
> Thanks for the responses so far. Appreciated.
>
> I have taken step back, started afresh and performed another trial using =
the fanotify example program in another WSL2 setup.
>
> 1.) Uninstalled MDE software in WSL where FANOTIFY was initialized and th=
at marks the mount point using mask: FAN_CLOSE_WRITE only. Ensured no piece=
s of monitoring software is present
> 2.) Ran the fanotify example program(without any changes) on p9 mount poi=
nt and performed git clone on another session. Git clone was successful. Th=
is program was using mask FAN_OPEN_PERM and FAN_CLOSE_WRITE.
> 3.) Modified the fanotify example program to mark the mount point using m=
ask FAN_CLOSE_WRITE only. Ran the git clone. The operation fails.

I ran the rename_try reproducer only with FAN_CLOSE_WRITE events watched
and could not reproduce.

>
> Is it something to do with mask ?
>
> I didn't get a chance to run on standard linux kernel. Can you share the =
commands to do so of mounting 9p on standard linux
>

You'd need some 9p server.
I am using the 9p mount in the kvm test box that you can download from:

https://github.com/tytso/xfstests-bld/blob/master/Documentation/kvm-quickst=
art.md

Thanks,
Amir.


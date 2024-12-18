Return-Path: <linux-fsdevel+bounces-37697-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C3859F5DC7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Dec 2024 05:21:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E418166A67
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Dec 2024 04:21:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BEB414A4CC;
	Wed, 18 Dec 2024 04:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iIrChY8F"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D99375336D
	for <linux-fsdevel@vger.kernel.org>; Wed, 18 Dec 2024 04:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734495688; cv=none; b=BbFLwsP+UC98YSd4MjzpeWjiv/s0gmLdm0RF3xLpbwPXjfO6Q0W7+Kkz8+Mbigtnv7mtvPA912u7Ho35yluBllm+p9FLDG+RQ8U8bVKXaEX9cZ7YJZ0ZTbpPAGgIQAHsvdETj+Pgm7QIOvoOfhIQf0aho2aFFVhQdWd5DrClio8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734495688; c=relaxed/simple;
	bh=KjnVJe+xPB0wf//BO9i7pAEK0DrcBSP6wzmUhTp5YZc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DI5D7TQCNKeEgXN2Wi0mlmLJIczWPaPddxTFSuxFFFuLCXqfH9tdJEq7HAzG0REKpdHy1iuPIHILLhEpR4m8HtNmu9ckT04dSKDFUYRJLXv2PvkP/iCLiAxxwLhIljRJnNxmiadkYbLDbBLLtqodNxBWYY1gOiPy26E0f4yMPZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iIrChY8F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 708F4C4CECE
	for <linux-fsdevel@vger.kernel.org>; Wed, 18 Dec 2024 04:21:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734495688;
	bh=KjnVJe+xPB0wf//BO9i7pAEK0DrcBSP6wzmUhTp5YZc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=iIrChY8FjkB0nC7fD5ilRdcg+fPJ5y+ZSAJiLG+Xwq+pD3iLlrdpUMAc91Jjoc9C4
	 tf4zkF1ntmg6z7dp2pG0fbhTws/+eFrcoWA47ZXmD/CG2YE3PlsIqar27GfHVWBItF
	 caToe9EgJq/udQK8H0O2/CoNqSSG7eFi6mg0Td9o1mSzSZLrT3aK/zoRZBLZhYIYhE
	 l3wLIYUOQ7FturjM0ZOB3Fm7U59K1/2JRfGOzhMKt3Mk41uMEXGQo0AODhrztSixgi
	 0fRobqkj0SOQRU+t+FiU6ei13yQGvPK1FxSoBMExi+D95MSTyeKSCMNBSdnyWuM8je
	 GU0sCsXV0izWw==
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-3ebbec36900so1573147b6e.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 17 Dec 2024 20:21:28 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXfzSFNSOL+bpblZLeOP6ARsK4qMehJ88wZipagR6j2K7NhagvaoVn2PGEuipEoiaXMnoX46y3PxKgjAt2g@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9FFq3qvXvgFdCnKYr9nQx+fpZGo2lBqiB50SNbLusc872I39P
	lNh5XqfutViMKd73Ncag3in5Ud9CzXk4aCTbTGio8r0hAanM1fcCDMATVC0Zg4PDHCxMtsUL7kb
	Q+Wd3Qghg3v6DJpD8OgCC06psMuI=
X-Google-Smtp-Source: AGHT+IETZaZWyMB98J7M+GAmvqv8lxZ+xZRpyMisxDV84lsFIDZEo+oyvRsuWHYN7QQdjwxmxsg8I+JJUMHeIvEYeU0=
X-Received: by 2002:a05:6808:178d:b0:3eb:4fbd:e3fa with SMTP id
 5614622812f47-3eccc0b9b17mr1118349b6e.40.1734495687748; Tue, 17 Dec 2024
 20:21:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <PUZPR04MB6316E933E479EA23F39EC2F0813B2@PUZPR04MB6316.apcprd04.prod.outlook.com>
In-Reply-To: <PUZPR04MB6316E933E479EA23F39EC2F0813B2@PUZPR04MB6316.apcprd04.prod.outlook.com>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Wed, 18 Dec 2024 13:21:16 +0900
X-Gmail-Original-Message-ID: <CAKYAXd_U4wgEaHOrpQYZQCGOo61rUHkurtGXi+FZC939xprP_w@mail.gmail.com>
Message-ID: <CAKYAXd_U4wgEaHOrpQYZQCGOo61rUHkurtGXi+FZC939xprP_w@mail.gmail.com>
Subject: Re: [PATCH v1] exfat: fix the infinite loop in exfat_readdir()
To: "Yuezhang.Mo@sony.com" <Yuezhang.Mo@sony.com>
Cc: "sj1557.seo@samsung.com" <sj1557.seo@samsung.com>, 
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 16, 2024 at 12:37=E2=80=AFPM Yuezhang.Mo@sony.com
<Yuezhang.Mo@sony.com> wrote:
>
> If the file system is corrupted so that a cluster is linked to
> itself in the cluster chain, and there is an unused directory
> entry in the cluster, 'dentry' will not be incremented, causing
> condition 'dentry < max_dentries' unable to prevent an infinite
> loop.
>
> This infinite loop causes s_lock not to be released, and other
> tasks will hang, such as exfat_sync_fs().
>
> This commit stops traversing the cluster chain when there is unused
> directory entry in the cluster to avoid this infinite loop.
>
> Reported-by: syzbot+205c2644abdff9d3f9fc@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=3D205c2644abdff9d3f9fc
> Tested-by: syzbot+205c2644abdff9d3f9fc@syzkaller.appspotmail.com
> Fixes: ca06197382bd ("exfat: add directory operations")
> Signed-off-by: Yuezhang Mo <Yuezhang.Mo@sony.com>
Applied it to #dev.
Thanks!


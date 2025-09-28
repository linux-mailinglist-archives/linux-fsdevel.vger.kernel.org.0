Return-Path: <linux-fsdevel+bounces-62942-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B6DFBA6D48
	for <lists+linux-fsdevel@lfdr.de>; Sun, 28 Sep 2025 11:27:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E02553B809C
	for <lists+linux-fsdevel@lfdr.de>; Sun, 28 Sep 2025 09:27:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1216D2D7DDD;
	Sun, 28 Sep 2025 09:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DWYc6a/3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69FEE2D249A
	for <linux-fsdevel@vger.kernel.org>; Sun, 28 Sep 2025 09:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759051662; cv=none; b=FEYvnYDDl+d8FMWH5XHYTs1EuC7cMsqTBms7YZAkFAHtzAlL+xkUSERxQljKug9e/SIOaMQ91id/pYxn5Bta9sJyxYNNmdGXbPLFc9dDFeo+jou+50sH/OayKiNwnda6X0rgYPSNPpUQ87Y/fWNvjVjv4g3tNvyPnqMJQTEHmYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759051662; c=relaxed/simple;
	bh=ZwtqQlO5EvIzrJO5vA7vA/j+itOB6gyxe+wrXFpq9Gs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d3j0TyAFGutiMPr5pT/lnxF/vMOWOmaFzCbPuboqqte5icbRw1g6A6TQjuRPkbo0nAA5qcwBUIWptXnZTLyi3qM3UbSMWUKypXjM9fvVRjexlL26JoCFAAKAPhPHy5cQFR8JeeKXst+sxNeXaDrBpExPVz65g2qHWzZhjzZFvx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DWYc6a/3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAE63C116D0
	for <linux-fsdevel@vger.kernel.org>; Sun, 28 Sep 2025 09:27:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759051661;
	bh=ZwtqQlO5EvIzrJO5vA7vA/j+itOB6gyxe+wrXFpq9Gs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=DWYc6a/3gv6sxCTNYq++GOu6ugq0U1pVqk45uonMhAgPl2AH/2jILcTxBb9NVTjRS
	 3A/8x1c4hXIyZHMbr5SAKvyDEZm5+FE7DAd5G+r2SUk0112BIkCc/w/CCASwwISMZM
	 yQQodfUvtiM1zTFuv7AQSx3R2t59A67NrfbiZX24b/IXJmJOLB0pP7MAcMo9n/nAJl
	 LWE9QnscKuagO94/WLLmFu8WOWdwXE41SmNlZJ+2zmqpMHGyLFSrsE0MSGOnR55sAB
	 0+gqthA0rpQoq4pTHSCnAD0eEN3T/sTn83sDB48LuQljVkOem9IiYnzIgiZMLFaTqX
	 1g0rKYVBacGjQ==
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-b3727611c1bso609078566b.1
        for <linux-fsdevel@vger.kernel.org>; Sun, 28 Sep 2025 02:27:41 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWXfny6NM5YWO4aISH+Gp3ToCNJCJ5Bc0wNeUAGsg8uzbW1BO4d433lXb9zHtoZAeIaebsZZu8rf1yyINHc@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2WtOEnIQzqQVHSPsqlGEt5h/PD09UfNIxHYxKFvQiqnxDzKu0
	pfOEdis0L7Q/LwMnwM4A8TBM235UnOhZDnH1uzPNsfOb4y0PfC3QK9rrtEJhTSv+dWWg5POgYmv
	B7lzd6ZLC+iG4jExe9ejr3YRputiYR94=
X-Google-Smtp-Source: AGHT+IGRLeY6S0Nk/2wVfERt/yUcn6itRxQaWMwOA785y0FClm1ncWVT5zew7191zEuGCe5/N+/fKRjHLXKFHhr0xYs=
X-Received: by 2002:a17:907:2da6:b0:b04:2ee1:8e2 with SMTP id
 a640c23a62f3a-b34ba93ca65mr1429460766b.36.1759051660386; Sun, 28 Sep 2025
 02:27:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250926153522.922821-1-ekffu200098@gmail.com> <PUZPR04MB631693629BCE735F5C5BBDC48118A@PUZPR04MB6316.apcprd04.prod.outlook.com>
In-Reply-To: <PUZPR04MB631693629BCE735F5C5BBDC48118A@PUZPR04MB6316.apcprd04.prod.outlook.com>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Sun, 28 Sep 2025 18:27:28 +0900
X-Gmail-Original-Message-ID: <CAKYAXd-d1V4-umsqShGHSXqCCnRVFEYXDs95Ym_U2jkbNVJy5Q@mail.gmail.com>
X-Gm-Features: AS18NWBPaVcVqnha7UE-Re56PiKYQldh7SPJzmzQ-Er1CVTGW_dwdpLMzkkruok
Message-ID: <CAKYAXd-d1V4-umsqShGHSXqCCnRVFEYXDs95Ym_U2jkbNVJy5Q@mail.gmail.com>
Subject: Re: [PATCH v2] exfat: combine iocharset and utf8 option setup
To: "Yuezhang.Mo@sony.com" <Yuezhang.Mo@sony.com>
Cc: Sang-Heon Jeon <ekffu200098@gmail.com>, 
	"sj1557.seo@samsung.com" <sj1557.seo@samsung.com>, 
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, 
	"syzbot+3e9cb93e3c5f90d28e19@syzkaller.appspotmail.com" <syzbot+3e9cb93e3c5f90d28e19@syzkaller.appspotmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 28, 2025 at 11:04=E2=80=AFAM Yuezhang.Mo@sony.com
<Yuezhang.Mo@sony.com> wrote:
>
> On Sat, 27 Sep 2025 00:35:22 +0900 Sang-Heon Jeon <ekffu200098@gmail.com>=
 wrote:
> > Currently, exfat utf8 mount option depends on the iocharset option
> > value. After exfat remount, utf8 option may become inconsistent with
> > iocharset option.
> >
> > If the options are inconsistent; (specifically, iocharset=3Dutf8 but
> > utf8=3D0) readdir may reference uninitalized NLS, leading to a null
> > pointer dereference.
> >
> > Extract and combine utf8/iocharset setup logic into exfat_set_iocharset=
().
> > Then Replace iocharset setup logic to exfat_set_iocharset to prevent
> > utf8/iocharset option inconsistentcy after remount.
> >
> > Reported-by: syzbot+3e9cb93e3c5f90d28e19@syzkaller.appspotmail.com
> > Closes: https://syzkaller.appspot.com/bug?extid=3D3e9cb93e3c5f90d28e19
> > Signed-off-by: Sang-Heon Jeon <ekffu200098@gmail.com>
> > Fixes: acab02ffcd6b ("exfat: support modifying mount options via remoun=
t")
> > Tested-by: syzbot+3e9cb93e3c5f90d28e19@syzkaller.appspotmail.com
> > ---
> > Changes from v1 [1]
> > - extract utf8/iocharset setup logic to tiny function
> > - apply utf8/iocharset setup to exfat_init_fs_context()
> >
> > [1] https://lore.kernel.org/all/20250925184040.692919-1-ekffu200098@gma=
il.com/
>
> Looks good to me.
> Reviewed-by: Yuezhang Mo <Yuezhang.Mo@sony.com>
Applied it to #dev.
Thanks!


Return-Path: <linux-fsdevel+bounces-17762-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 845EA8B222E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Apr 2024 15:06:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4049128348A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Apr 2024 13:06:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2E6B149C41;
	Thu, 25 Apr 2024 13:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EJE3B9yH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 422541494D8
	for <linux-fsdevel@vger.kernel.org>; Thu, 25 Apr 2024 13:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714050354; cv=none; b=oaiq5JyuqA4TMNv8obrRWwCLnMht6LId0wlRbeVtv1t/APy/qSE0mjkrJuNwqaTiASAFDY+inxpw4cAHaF+6CLmD2exrSTurcUgHnrDrNNo/UK+Rqk63qnUSZTKeUCdDPIqJOKs0RLo2HfreCbbFWIKUW+NifNSy/b+Z1w5KiQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714050354; c=relaxed/simple;
	bh=uDoGrBVCGBf/mZWc2r3+d5ChWxJt/eB5nZMpgOJc0Eg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FNKCs+RllkAHhSUAMUC3WLlX6ncs9J1Jlh10YL0wBE4QefmZ/ju3sGvAlASK7ADTGfgNYLm7JYtUFprKPbAES7hlPgz3xjFzITVHYtqLU22qbo2VNhjgFdQVrHsueUc21SHZoMH4SlURAo+Xz4+MbkhtJZn1ES7zM6Q95xJ+AyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EJE3B9yH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B27F7C113CC
	for <linux-fsdevel@vger.kernel.org>; Thu, 25 Apr 2024 13:05:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714050353;
	bh=uDoGrBVCGBf/mZWc2r3+d5ChWxJt/eB5nZMpgOJc0Eg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=EJE3B9yHsqiEl2XbSGpwAvcVxozwYVKLUjmIia/PXIaWG0u56dUxwdJSl7bCM5DAc
	 ZmwQEo9WCtwAdeSK5Z05DxzHpbqy5AlT3luROiThOqtrSTrGN2fLRWmgkm5ofYC4E/
	 JKXKW7gKoqAjHfSUXDaLxtLDU8mVVKnzuR95Jk4SxBfsvYx4dRNqPtGw7J0fsQz6Uh
	 6OKqA4nGRtqsm1vaVrZktmmBocJHqHD0cJ9ZjExU8Iyi0KqUR8/EoWJdjfUXypl8L5
	 h3nrpRvZkf6jy6a5wjPJMFJpLTTNrYx55MWyhUdstFu94QMddz/BFy2Btl0cYxdodP
	 jnKGOLDihlIJg==
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-5ac90ad396dso559185eaf.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 25 Apr 2024 06:05:53 -0700 (PDT)
X-Gm-Message-State: AOJu0YxKJS2dYkbeDGdN/js06x3xJLIKg2Gn5L0VY0fyuuL5wSXuAY7t
	A8jDvDqcZkD1Ar2Ua2F3QVccEsB9jb3JJP109RzKE43K0bikBV3nGX19NPl4VJf+INckPHZENZq
	Z50FLHkPaKb5eedzlIViiTDrM9Zc=
X-Google-Smtp-Source: AGHT+IHS0IrTEbeJp3Z5CyAn/KdRPJQssid3W/HyqTKUyYmFl1j5qDJhDjfWeCbYswTYd0xMLI5Vv2Hf7RX8bz9z3OI=
X-Received: by 2002:a4a:301:0:b0:5af:24de:7f1 with SMTP id 1-20020a4a0301000000b005af24de07f1mr6084899ooi.7.1714050353031;
 Thu, 25 Apr 2024 06:05:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CGME20240425045525epcas1p1052d7d89d9ced86a34dbe5f6a7dcad39@epcas1p1.samsung.com>
 <PUZPR04MB6316FDC76BB5D2818276D39581172@PUZPR04MB6316.apcprd04.prod.outlook.com>
 <664457955.21714026181854.JavaMail.epsvc@epcpadp4>
In-Reply-To: <664457955.21714026181854.JavaMail.epsvc@epcpadp4>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Thu, 25 Apr 2024 22:05:41 +0900
X-Gmail-Original-Message-ID: <CAKYAXd_n6SkodLP9+_S3tNL12W=3uH-jvOHrvtSq0_KW30vw9Q@mail.gmail.com>
Message-ID: <CAKYAXd_n6SkodLP9+_S3tNL12W=3uH-jvOHrvtSq0_KW30vw9Q@mail.gmail.com>
Subject: Re: [PATCH v2] exfat: zero the reserved fields of file and stream
 extension dentries
To: Sungjong Seo <sj1557.seo@samsung.com>, "Yuezhang.Mo" <Yuezhang.Mo@sony.com>
Cc: linux-fsdevel@vger.kernel.org, Andy.Wu@sony.com, Wataru.Aoyama@sony.com, 
	cpgs@samsung.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

2024=EB=85=84 4=EC=9B=94 25=EC=9D=BC (=EB=AA=A9) =EC=98=A4=ED=9B=84 3:23, S=
ungjong Seo <sj1557.seo@samsung.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> > From exFAT specification, the reserved fields should initialize
> > to zero and should not use for any purpose.
> >
> > If create a new dentry set in the UNUSED dentries, all fields
> > had been zeroed when allocating cluster to parent directory.
> >
> > But if create a new dentry set in the DELETED dentries, the
> > reserved fields in file and stream extension dentries may be
> > non-zero. Because only the valid bit of the type field of the
> > dentry is cleared in exfat_remove_entries(), if the type of
> > dentry is different from the original(For example, a dentry that
> > was originally a file name dentry, then set to deleted dentry,
> > and then set as a file dentry), the reserved fields is non-zero.
> >
> > So this commit initializes the dentry to 0 before createing file
> > dentry and stream extension dentry.
> >
> > Signed-off-by: Yuezhang Mo <Yuezhang.Mo@sony.com>
> > Reviewed-by: Andy Wu <Andy.Wu@sony.com>
> > Reviewed-by: Aoyama Wataru <wataru.aoyama@sony.com>
>
> Looks good. Thanks for your patch.
> Reviewed-by: Sungjong Seo <sj1557.seo@samsung.com>
Applied it to #dev.
Thanks!


Return-Path: <linux-fsdevel+bounces-25519-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B3A6394D016
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Aug 2024 14:23:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5EC621F2342B
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Aug 2024 12:23:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C66911940A9;
	Fri,  9 Aug 2024 12:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XDZM/8we"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36CAC3398E
	for <linux-fsdevel@vger.kernel.org>; Fri,  9 Aug 2024 12:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723206192; cv=none; b=MjjtApC3se3aHQD04U4Y3V85aRejIuO6xCQOqaoDs/w4Tdmv07dzF/ftVeBUr0QEgGAQK0ft2Cbbid1WL1gehsYkMTFEtdyLD/zI4Bc0UkMpoxxxcDNYiEH53FFlUzil7QsqZ45TxR9ut1cHo6UwXaEhZYdLuKNOdw40ek/SLOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723206192; c=relaxed/simple;
	bh=HFQWLJgk/s1h4/qZpqg0bwTxRm3y4q/N4bDTwQJ4xD8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BVnZlPcYEPAWLp8Ac/szwQ3gjTa2ngWl1m42NVgpJbDYLEfH7KyS0N21lP1jThmP9kh4LLlGaoe8eQxtv8V8a5rqainABfmU+B52t7r6yLg4cH+TfXsD/28JIRGmL4oSH/JFNwWR1By/CRHJgqSZP8Vp0dth51VZEUQwHLMFVG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XDZM/8we; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97E73C4AF0E
	for <linux-fsdevel@vger.kernel.org>; Fri,  9 Aug 2024 12:23:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723206191;
	bh=HFQWLJgk/s1h4/qZpqg0bwTxRm3y4q/N4bDTwQJ4xD8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=XDZM/8we1jl3WVLpjx7MwmcEeemuVCvgcC2dxS6Bgjdkz2wj9CzwOPvKNO1F2vqdA
	 c2Z0jKAxZ/MEXvzyRKcutjgAaCe9aDqgHcof7I9jUVOfbmDTeMTWGAzITKI1JB2AeS
	 hENg0F4woTr7Wq4ZPu3SzWN2XpHZtEf6WJEtk0XPnKk2dEbP74ebjQPR17ZLht5kP8
	 ssHga2Nm1+WJTIOL+8SfQUP9rJvrouQiNJrLycP13YHkZy+HiIJjZUbOuWBH0I16US
	 qPuGv7k220rLS34455WwxvEbJpLqkFW3IqnnZ8qfzSab0FDkgcO40HKI61gEYXquCz
	 uW9MaoVJC/AyQ==
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-264988283a3so1127630fac.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 09 Aug 2024 05:23:11 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWScTlBESpyGYnjYIj7f+E4b8QsuM6WewBqngmwKi7mhkDagFLaGEXS/Zb9aa10tjoVlPzCnsk1d23xe2MJyFLa6nrUtvwV6xFtYrBGpw==
X-Gm-Message-State: AOJu0Yy+eHwD4UtV7DJAeFHpb3uMdVvk1uMX1yjK5BAm8yaK64S8aTJO
	QS31rcbcQ9WAEM/z4SckNkIcldgzwCfzT30n00+gU2AzdGHknhFixIcGu7//8MDVncsVMVslWrh
	cnrIuLvASk2y7qCJq/NRRo7bf1n0=
X-Google-Smtp-Source: AGHT+IEzGgjkb0FYa2mSUVFqhsRsQNuw6o4dSVOsyYmhNj2J69byT0RQQdZ22D9aP7Acow6PAAQ4Ct1g/PqipKV+GpM=
X-Received: by 2002:a05:6870:2105:b0:25e:de4:9621 with SMTP id
 586e51a60fabf-26c62ca7a1bmr1807147fac.24.1723206190884; Fri, 09 Aug 2024
 05:23:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <PUZPR04MB631656C12DC76EFFAF3D181D81B82@PUZPR04MB6316.apcprd04.prod.outlook.com>
In-Reply-To: <PUZPR04MB631656C12DC76EFFAF3D181D81B82@PUZPR04MB6316.apcprd04.prod.outlook.com>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Fri, 9 Aug 2024 21:22:59 +0900
X-Gmail-Original-Message-ID: <CAKYAXd_HGfqVXgaZQvA9zmSdxSWuVb1Zm2G2F=Nw89HRCZ8MHg@mail.gmail.com>
Message-ID: <CAKYAXd_HGfqVXgaZQvA9zmSdxSWuVb1Zm2G2F=Nw89HRCZ8MHg@mail.gmail.com>
Subject: Re: [PATCH v1 0/2] exfat: direct IO refine and code cleanup
To: "Yuezhang.Mo@sony.com" <Yuezhang.Mo@sony.com>
Cc: "sj1557.seo@samsung.com" <sj1557.seo@samsung.com>, 
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, 
	"Wataru.Aoyama@sony.com" <Wataru.Aoyama@sony.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

2024=EB=85=84 8=EC=9B=94 7=EC=9D=BC (=EC=88=98) =EC=98=A4=ED=9B=84 2:45, Yu=
ezhang.Mo@sony.com <Yuezhang.Mo@sony.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=
=B1:
>
> Drop ->i_size_ondisk and ->i_size_aligned, and remove fallback to
> buffered write in exfat_direct_IO().
>
> Yuezhang Mo (2):
>   exfat: drop ->i_size_ondisk
>   exfat: do not fallback to buffered write
Applied them to #dev.
Thanks for your patches!
>
>  fs/exfat/exfat_fs.h | 12 +++----
>  fs/exfat/file.c     | 19 ++--------
>  fs/exfat/inode.c    | 85 +++++++++------------------------------------
>  fs/exfat/namei.c    |  2 --
>  fs/exfat/super.c    |  2 --
>  5 files changed, 24 insertions(+), 96 deletions(-)
>
> --
> 2.34.1


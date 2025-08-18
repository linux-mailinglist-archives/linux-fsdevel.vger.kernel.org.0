Return-Path: <linux-fsdevel+bounces-58143-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BB92B2A094
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Aug 2025 13:38:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C2177164F7B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Aug 2025 11:31:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED70126F2AC;
	Mon, 18 Aug 2025 11:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TCK+vyHf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51DDE31B124;
	Mon, 18 Aug 2025 11:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755516544; cv=none; b=RZhKma+fpHxR/oP7bn9iF7Ns2yPZEC18iWQGz0/aY+5GSRw5RtzcHzUXQ+6qewF7K9IRtY5o1BaKniWm7VIKLfh6LVIgDrznBa8lvLdM1dEvNDP9We0h1q9B4Gejr/y5XMf8ecmPMdJ8mz6WC4VVxJ+E5nP+1rgePX8cm4oXSng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755516544; c=relaxed/simple;
	bh=7CPnt3ZkHJ8yAdbYqqjFr1P9MaHULEhkMAKojduGa/Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=An72Un+CSDY8YANKwSDkf5cP/X8OvkwzZNC8L3bv+3SgPYOgm1NX6W8GmmT0fDztwXERnyh6GtSbYwWjqEhLtGvAaMcUDDpvwMImKKUm2DHORrm/j+eXxTmcQ1JSzLDj3Wim2pC0WlBkqTiYtLu4S529XQ0v4sYJJLCqTm/C+A0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TCK+vyHf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9728C4CEEB;
	Mon, 18 Aug 2025 11:29:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755516543;
	bh=7CPnt3ZkHJ8yAdbYqqjFr1P9MaHULEhkMAKojduGa/Q=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=TCK+vyHf3Xzsk3FkDIcabJxS/Duvx0I0XieekgjiQpSqXir/Ggx0k5Re9oii1m4Hs
	 RdCG7hbRaiFnifiRqLoi3BSYq8N4e7o/lFdQ+5EN74+MK7T7rljtrleF5b4QnOdMOE
	 x5bB5asUyPX43D4Fuh/8GzOxSLcQaspqFaWYwzFjbr3KAXFxVybbE1bo9LSlRv1niw
	 jVhXgcNFEXKz5qYgBSviScrqc7XFWo0xVe1hZrTj+NLO2zktBd3OPxIT/9JLGnZe7T
	 e0Sq8WuPLnGnRTamFCtixv539E30dFwtd3Tg4P3P7Ii0DG4+7rbGpu6miLT/oPOIi2
	 O1mWphSHz+4BA==
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-afcb78da8a7so653679266b.1;
        Mon, 18 Aug 2025 04:29:03 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWOnr4buWFiPwRh5zTFqUtg0prStQzeZD8PM02f1Rj1xOEmhuh5no5ky8B1L/TZs4A5juRCJtBTaZaTGZw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyC2ICZxl2MZfmhYtHPmVzGs8yRvJ96wGC9K6BJ3mtQhaFFv/Pc
	M9lHIL+mRDXOIBgnEb/EpvAus2X2atqE+16KY+7pIdOl0mgGoaEzYcBSUCPFTqJeO0uVWAdIsW9
	twm1FY5K3+QbG8kNW7/Kg0oOeEsfsl58=
X-Google-Smtp-Source: AGHT+IFQHwqtVDT8agxE3p8XjMnIxZxVuu5U6OaetmbOClqhKKWDLwF0on5S+6BGiXA+rmwD/8g6Jpy2EQK3yJ3uXkI=
X-Received: by 2002:a17:907:962a:b0:ae3:f524:b51 with SMTP id
 a640c23a62f3a-afcdc25105dmr1165679766b.10.1755516542358; Mon, 18 Aug 2025
 04:29:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250815093245.118648-1-chizhiling@163.com>
In-Reply-To: <20250815093245.118648-1-chizhiling@163.com>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Mon, 18 Aug 2025 20:28:47 +0900
X-Gmail-Original-Message-ID: <CAKYAXd-Hf-jj01vYjbP3G3kdkdHjUKKoPMs2pMRM-TJbt2_xfg@mail.gmail.com>
X-Gm-Features: Ac12FXwkmPSvv8PL5x97z4K1IYqHvAw4ZLuPXUJYq9g-DiHbg2H_aFBLl_RWFbg
Message-ID: <CAKYAXd-Hf-jj01vYjbP3G3kdkdHjUKKoPMs2pMRM-TJbt2_xfg@mail.gmail.com>
Subject: Re: [PATCH] exfat: limit log print for IO error
To: Chi Zhiling <chizhiling@163.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Sungjong Seo <sj1557.seo@samsung.com>, Yuezhang Mo <yuezhang.mo@sony.com>, 
	Chi Zhiling <chizhiling@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 15, 2025 at 6:33=E2=80=AFPM Chi Zhiling <chizhiling@163.com> wr=
ote:
>
> From: Chi Zhiling <chizhiling@kylinos.cn>
>
> For exFAT filesystems with 4MB read_ahead_size, removing the storage devi=
ce
> when the read operation is in progress, which cause the last read syscall
> spent 150s [1]. The main reason is that exFAT generates excessive log
> messages [2].
>
> After applying this patch, approximately 300,000 lines of log messages
> were suppressed, and the delay of the last read() syscall was reduced
> to about 4 seconds.
>
> [1]:
> write(5, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 131072) =3D 131072 <0=
.000120>
> read(4, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 131072) =3D 131072 <0.=
000032>
> write(5, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 131072) =3D 131072 <0=
.000119>
> read(4, 0x7fccf28ae000, 131072)         =3D -1 EIO (Input/output error) <=
150.186215>
>
> [2]:
> [  333.696603] exFAT-fs (vdb): error, failed to access to FAT (entry 0x00=
00d780, err:-5)
> [  333.697378] exFAT-fs (vdb): error, failed to access to FAT (entry 0x00=
00d780, err:-5)
> [  333.698156] exFAT-fs (vdb): error, failed to access to FAT (entry 0x00=
00d780, err:-5)
>
> Signed-off-by: Chi Zhiling <chizhiling@kylinos.cn>
Applied it to #dev.
Thanks!


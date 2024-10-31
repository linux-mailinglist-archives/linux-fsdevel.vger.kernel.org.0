Return-Path: <linux-fsdevel+bounces-33342-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DC9B19B7A6E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 31 Oct 2024 13:23:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 626F9B22F9B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 31 Oct 2024 12:23:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D42519CC29;
	Thu, 31 Oct 2024 12:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ffvqzONS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5DE214E2C0
	for <linux-fsdevel@vger.kernel.org>; Thu, 31 Oct 2024 12:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730377405; cv=none; b=FmLcx8p5LBt2eADQcd7NRhWjshJzvdTiHMjcd80d7W29UJ8NNZIXw7FOc1BhnRQv84aLjU/HMZNxiY1JykwdFEmYzm8ZEHpV8PdyeyQCR9RsAWzzhUEKTdrosr7FBaYRF3kX5oLxObTz5Pu1Azrc25kRREisJM5nFkX3c34BJJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730377405; c=relaxed/simple;
	bh=A/fsDPSLuuMm2ABef3ySgBvfeTYux3yXY0Em56mbk44=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W7aLR/Vm/KKdRhOq7VFlkM0/2aYpwshpeBcLeugW/a8Q7i69IclMzbBCbAmBhtoklroX9+rQn/CWPvAEuIi7Dw2rCPU9i9b2r393u7Nzc3Jwv002299RnI4z4rPZIYB6ZDq+MN7kQ7yXPQqIFzfTGAvXILuPr9DG6ATFTc8cxtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ffvqzONS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C845C4CED4
	for <linux-fsdevel@vger.kernel.org>; Thu, 31 Oct 2024 12:23:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730377404;
	bh=A/fsDPSLuuMm2ABef3ySgBvfeTYux3yXY0Em56mbk44=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ffvqzONSi+4f05b7uHF/35bVyo8P5b/88BRsgOCuCD4h+ufZFxk+nyu2flJAjI0PT
	 lM9yIkJFarqz7iZZSStIowHJiPMR0c4TZjk7QErkVoqNuGSpyTdsUM59rYv4BuvRM1
	 B338BY6/h/8cm/8Gr1mD3JO7pizzIseLtOYWxtVL5NrX/XPLTlUAmQm3Hj0sh5RmkD
	 g0sztE0U9p7vw2LqPnU+NNBobqnI1ZJx3+2QVfUP+QmjvIY8GywaFQ4mQTSnCgYQ4W
	 PIcts0NtdIqzB0JpPDNeNpDObc0dKQ3OYzE9IW1OPvLKJYDZzfGiUwseraGnH9Y9Ob
	 1no6lzxCtb5yA==
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-28c7f207806so416832fac.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 31 Oct 2024 05:23:24 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUj4cP6TQOCUzB5+4JTHmuNHILjeCdBul5VfSXSg6QOF1nPx0FnRVSANoqe4boXQ/UE/Slw11vCcb0FqUCH@vger.kernel.org
X-Gm-Message-State: AOJu0YxlfMOpucfNpBad37zEQk5Ir8BTiHg7oIaeNbr8PKXRi8DD0p6t
	/zSXUFwdQweR+6E9nVLjLbkQvagmWJwA+xsZc1prdN8xef/zjYob1y0R8U6E1OtpsU63Vmx97xW
	AZ3lx2XvqtHZhM6NNW5DyIpx2188=
X-Google-Smtp-Source: AGHT+IF3DFNGAPx/6NS6vKLX/FkvbeUSeekrgW8wdnMz3sfsnihLRN8FaX2rBmScXPxRTpssKrcPld5BDdo0Qj51VwM=
X-Received: by 2002:a05:6870:6387:b0:277:cc56:2300 with SMTP id
 586e51a60fabf-2946470278cmr7571091fac.12.1730377403944; Thu, 31 Oct 2024
 05:23:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <PUZPR04MB6316005B9D2632DDB7E0E2EB81542@PUZPR04MB6316.apcprd04.prod.outlook.com>
In-Reply-To: <PUZPR04MB6316005B9D2632DDB7E0E2EB81542@PUZPR04MB6316.apcprd04.prod.outlook.com>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Thu, 31 Oct 2024 21:23:12 +0900
X-Gmail-Original-Message-ID: <CAKYAXd-pdzZc0zmNz9A=dAg0VU5K+D_jbFopiy3NuohwGWEL0w@mail.gmail.com>
Message-ID: <CAKYAXd-pdzZc0zmNz9A=dAg0VU5K+D_jbFopiy3NuohwGWEL0w@mail.gmail.com>
Subject: Re: [PATCH v1 0/2] exfat: fixes for invalid start_clu
To: "Yuezhang.Mo@sony.com" <Yuezhang.Mo@sony.com>
Cc: "sj1557.seo@samsung.com" <sj1557.seo@samsung.com>, 
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 30, 2024 at 4:47=E2=80=AFPM Yuezhang.Mo@sony.com
<Yuezhang.Mo@sony.com> wrote:
>
> Namjae Jeon (1):
>   exfat: fix uninit-value in __exfat_get_dentry_set
>
> Yuezhang Mo (1):
>   exfat: fix out-of-bounds access of directory entries
>
>  fs/exfat/namei.c | 21 +++++++++++++++++----
>  1 file changed, 17 insertions(+), 4 deletions(-)
Applied them to #dev.
Thanks!
>
> --
> 2.43.0
>


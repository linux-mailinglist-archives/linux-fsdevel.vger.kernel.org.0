Return-Path: <linux-fsdevel+bounces-34636-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E9E7D9C6FD1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Nov 2024 13:55:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C02D1F21382
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Nov 2024 12:55:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD9AA1DFD8C;
	Wed, 13 Nov 2024 12:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Uap+upJG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 173157DA7F
	for <linux-fsdevel@vger.kernel.org>; Wed, 13 Nov 2024 12:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731502471; cv=none; b=JQO2GAwibhGbIs10SsO6PRSrVXR053TqQQJw8W67UXS9591Kamw0Q+JGm7nzyZ2zbkf8y3k9Vk2tNIvOoqrK30RKalLhulS+Vvw0yX86sMc4xTwV4u7W+M+NFl5tVy+DemzomTG2m3R+L5uq+QfX+oC1qBmrXXjDBmNRRAxKYmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731502471; c=relaxed/simple;
	bh=4C287KbANIr9W9/rNddYpD3J/NDqTMKvkaiZ6SyKFRk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ftcnyj8Fn3i/EVw+wXIl1DDPYmuyV4vNfhHLx+ZceYaIFAYNJv64O6StEhmEQ5r5AyZ4/IfBFYPvK/H8PQdq92STTZ0OKLHWOdvL9GjWxWV8F5Z5mHc4Tm9lITreJ9jqvoNybmC7NS7g7pHu1jIwSb6ytB0KvpJKB5jcHi8flXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Uap+upJG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F56EC4CED5
	for <linux-fsdevel@vger.kernel.org>; Wed, 13 Nov 2024 12:54:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731502470;
	bh=4C287KbANIr9W9/rNddYpD3J/NDqTMKvkaiZ6SyKFRk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Uap+upJGZk4OzVyIWe28r8JqI0VmnskERAE/a+nX0NsBbdFpyzbJ5JfuEkcgDBX4w
	 Kl74e4oyyxBQiYbyjRejPteK3DbmHEMGPYUkEj9knZqgP7//TVRIQZasy8D5zB2Xrd
	 SpRPjwYgcgspo/3M0/3IamJBz4hV0cx507iRONa0X3l2J5GvyruTMlabYPEGhgmMHz
	 a6wWn+qYNEPX155Nvo3Lrs7u24nLOJWWH0fw0OjFyzmuhXsIJ1tYUSSdjlTsvoteDP
	 b/Ixb5IDVcoYI5qwGZdcTWttAXBeKo7RXQoYUT8BztV6+IdgRsb7LNm2blJACYOICU
	 HyTnCrmD4a3AA==
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-5ebc05007daso3010113eaf.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 13 Nov 2024 04:54:30 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVaSnbZglQpKXHta3KeLKPURhtLx2LmmtbYaDDqK4hmENbZrIcKZknuATgSvYJaU10L+BHh8Bu7bGZjFuEs@vger.kernel.org
X-Gm-Message-State: AOJu0YwnCz5q4zDh/lzZQa8PcsTABcGLDIWmuVmV4GY0yD9jpl2WUgG3
	FUtOTbTyCW+UBYS9eTDSHhayr1/a5e/ZTvXRUNjOgbpf5Yt2GTk127YObj5ld1BwnYjJjYNt8LZ
	xHq4k/c4dnK0ZUcRhUbBEMnCWY3w=
X-Google-Smtp-Source: AGHT+IG2qWyHM6jfpZ9hkA/3lTI/hNXEofKoBxU5xNc4kguksLi0MUElhJGe9wDcSBaDtwQnhwt9yJs036Jm0X988DQ=
X-Received: by 2002:a05:6820:190d:b0:5eb:d1ac:21c6 with SMTP id
 006d021491bc7-5ee921e2b3fmr2515224eaf.5.1731502469258; Wed, 13 Nov 2024
 04:54:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <PUZPR04MB631627C059803D3D4609D1C581592@PUZPR04MB6316.apcprd04.prod.outlook.com>
In-Reply-To: <PUZPR04MB631627C059803D3D4609D1C581592@PUZPR04MB6316.apcprd04.prod.outlook.com>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Wed, 13 Nov 2024 21:54:18 +0900
X-Gmail-Original-Message-ID: <CAKYAXd97o3rwnX-EKmCkoJA=3T_q9A=0px50aUimCH48Sz7AXw@mail.gmail.com>
Message-ID: <CAKYAXd97o3rwnX-EKmCkoJA=3T_q9A=0px50aUimCH48Sz7AXw@mail.gmail.com>
Subject: Re: [PATCH v2] exfat: fix file being changed by unaligned direct write
To: "Yuezhang.Mo@sony.com" <Yuezhang.Mo@sony.com>
Cc: "sj1557.seo@samsung.com" <sj1557.seo@samsung.com>, 
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 12, 2024 at 1:00=E2=80=AFPM Yuezhang.Mo@sony.com
<Yuezhang.Mo@sony.com> wrote:
>
> Unaligned direct writes are invalid and should return an error
> without making any changes, rather than extending ->valid_size
> and then returning an error. Therefore, alignment checking is
> required before extending ->valid_size.
>
> Fixes: 11a347fb6cef ("exfat: change to get file size from DataLength")
> Signed-off-by: Yuezhang Mo <Yuezhang.Mo@sony.com>
> Co-developed-by: Namjae Jeon <linkinjeon@kernel.org>
> Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
Applied it to #dev.
Thanks!


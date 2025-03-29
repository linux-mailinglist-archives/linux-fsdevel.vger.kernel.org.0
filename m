Return-Path: <linux-fsdevel+bounces-45267-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4852CA75659
	for <lists+linux-fsdevel@lfdr.de>; Sat, 29 Mar 2025 14:13:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C140716EF02
	for <lists+linux-fsdevel@lfdr.de>; Sat, 29 Mar 2025 13:13:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D37951CAA73;
	Sat, 29 Mar 2025 13:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Il9zEemB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33CDD35972;
	Sat, 29 Mar 2025 13:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743253978; cv=none; b=ebSy3SE1K7scbkJv0Exl1Sol4zIe/6IRAlJX/4suLY8tKJwFCUnCtg+sJ3PJRNcBOz+S3js55WKEVxB4mvcedDb3oYDzCQkZnnHoaY6VK4E4vHZeYD3R3IeTU4koQwcc4AwEd6Bk5OQHyu1lcOtxiGeWD7Dwfe+vaBCNeSzt/x4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743253978; c=relaxed/simple;
	bh=wi+c+GQMw5q+3bCR3TIsBAflQ+EXY6M0KUCrJCujUIE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NWc1JUETbWrqWgHGa8aXM8zb3Gvy/p8czAMwBKTvymmpSH0nS3x4azMPbxoJS5rYfuu2hTTVUG2X1zxWkJjjtpTlJ2RSOcbipiA/hS9VF1L8OAOm47ah24oCr9F3OUPRYwHUL567hCYiWRhaiq9Tgcx1CP1oQOpxGzObgWNxuF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Il9zEemB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99C09C4CEE2;
	Sat, 29 Mar 2025 13:12:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743253976;
	bh=wi+c+GQMw5q+3bCR3TIsBAflQ+EXY6M0KUCrJCujUIE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Il9zEemBXLsLnq/x2AxTuTRAxAhSh3YYa8fd8LqgpSehjGi3PZbgMoZFpStXiyh72
	 rMr7KKW2BTDicz1Pn9qjWfznffKEz9hMEHP6b2ZDMVrMDhy3iic7nzG1SQksqH15mp
	 sxKhuKfvzetoQ00+BSmj7NC99u5Pw+/WnIDWpMq4Itr6G9vDFp8foUrHgbuMzDLGv4
	 B7Ff/D/iVncVGVe81ipdI8u4jt7LZEpXDdQlLhHSZM4xSn8GKfRBIJcX2YeriOzPPp
	 FHcL1Z4QtRyc8mCrWM6ZXFifqPiPTLDZB9jnkINyWMC3R1gtZfnp7yYGCRr1CATSW/
	 0dXhULS+0ixDA==
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-2c2504fa876so788472fac.0;
        Sat, 29 Mar 2025 06:12:56 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWhVqi48n65DRkOlDbOT163+sJfknXfnu3MNltZOSuLb/1w7mU3Z8xN9DMHWDTEJtE276tYsF6cjdpUCIgm@vger.kernel.org, AJvYcCXYzh+4cJTCq6IhcjmPhg27xCDV4AZR0/6usQSSvheqhF8t9oAFM7EuqEEg9vpmnTQj/5Mb0ajbrL7QT+Bh@vger.kernel.org
X-Gm-Message-State: AOJu0YytdebPe076jUoqfyAwNe/khztzBxMv8rkGwqI0ayGGezKAOkK8
	FErWflc4vpZUxqcwoBscptrFMdbl4qgO35UIM/oUy6Qb0xe22yZlTfWYMfmkB7UukmjZj6qDcgZ
	Bub+2TVD5iSvs6etI/NwPwjeuxOQ=
X-Google-Smtp-Source: AGHT+IGNfztDsFLpDkxG/ViPGhrdMUEX8GjFoDByCMbHzEmFCj+HInYa0r+eectfTa2K03ESfZW//t0XL+h0noSgHr0=
X-Received: by 2002:a05:6870:5253:b0:29d:c832:840d with SMTP id
 586e51a60fabf-2cbcf7ae22fmr1815102fac.35.1743253975898; Sat, 29 Mar 2025
 06:12:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CGME20250326150136epcas1p3f49bc4a05b976046214486d7aaa23950@epcas1p3.samsung.com>
 <20250326150116.3223792-1-sj1557.seo@samsung.com>
In-Reply-To: <20250326150116.3223792-1-sj1557.seo@samsung.com>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Sat, 29 Mar 2025 22:12:44 +0900
X-Gmail-Original-Message-ID: <CAKYAXd9dK-NPqxjijtx-6y_ejqg1wsSFsKW1sreOcBZmznD-nA@mail.gmail.com>
X-Gm-Features: AQ5f1JpD2k-OTyUpkuIxuGwuedYuaor34Pv3RdaJt3Hxem700lw4AqInlplhDjI
Message-ID: <CAKYAXd9dK-NPqxjijtx-6y_ejqg1wsSFsKW1sreOcBZmznD-nA@mail.gmail.com>
Subject: Re: [PATCH] exfat: call bh_read in get_block only when necessary
To: Sungjong Seo <sj1557.seo@samsung.com>
Cc: yuezhang.mo@sony.com, sjdev.seo@gmail.com, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, cpgs@samsung.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 27, 2025 at 12:01=E2=80=AFAM Sungjong Seo <sj1557.seo@samsung.c=
om> wrote:
>
> With commit 11a347fb6cef ("exfat: change to get file size from DataLength=
"),
> exfat_get_block() can now handle valid_size. However, most partial
> unwritten blocks that could be mapped with other blocks are being
> inefficiently processed separately as individual blocks.
>
> Except for partial unwritten blocks that require independent processing,
> let's handle them simply as before.
>
> Signed-off-by: Sungjong Seo <sj1557.seo@samsung.com>
Applied it to dev with Yuezhang's reviewed-by tag.
Thanks!


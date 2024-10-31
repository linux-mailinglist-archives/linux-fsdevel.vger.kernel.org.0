Return-Path: <linux-fsdevel+bounces-33343-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E14ED9B7A74
	for <lists+linux-fsdevel@lfdr.de>; Thu, 31 Oct 2024 13:24:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E5101C21E66
	for <lists+linux-fsdevel@lfdr.de>; Thu, 31 Oct 2024 12:24:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A99019CC11;
	Thu, 31 Oct 2024 12:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H1nb5mfc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B99C8198A0E
	for <linux-fsdevel@vger.kernel.org>; Thu, 31 Oct 2024 12:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730377451; cv=none; b=FXd/0JdW2L89fdmpmO9DeLL0z1iPkJs66dpw0Nbs1gqbe4oIAsjjpBQgMeG2yAOUDenj5yuHeMtLAWhzs8goOWYeBbn7fnV3ynxrVghRIS1IDdXbwWBddo5UfW48rJ1w12NFuxvCYBLRCmYXbVkqsV6VVaceekkTim1kV56P+Xc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730377451; c=relaxed/simple;
	bh=1SU7yqKR0amm072nlLOuqbG1rt7zpPeDFMAamVU+miA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YgDp1WMTrNa89vxEMaG02QOuVTBNlJy/8MCe8E9kLXe0KqVgkc2wv7sonr2BvNee6Vjw6Bxd982+3foYVZ5McVqFIg5O8fWLSnvP7UqUasSVSgrbeahvvrdjGFqqtzlXTV5TzLSKqAQtXgsG/WeSARKfk4d/vNs7M2wrE9YNtpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H1nb5mfc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E08CC4FE01
	for <linux-fsdevel@vger.kernel.org>; Thu, 31 Oct 2024 12:24:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730377451;
	bh=1SU7yqKR0amm072nlLOuqbG1rt7zpPeDFMAamVU+miA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=H1nb5mfc/wjGrKgjmlntOYiLZ7fBZ7mg4VhAv6+WUApwxgsuFC0eBDmCaWM3diclm
	 pJaV6Ybbq8huSGDv9FnUm5AMalBSBfEzcOh6fLox9C3qIkRcwsxpvCbWaq5NaP1GoG
	 XvuQYZYQGoX5vsegFKIYNqLue+cAw5gU/awyKqijV4+XDOCYnDf6PUN+4//XgS1xUZ
	 7L3k3qidsFEnjOnnbMwGFjeI403fyYvi6KfAuzNFVA13VBcgUIqOG4fghiI9qMm2eP
	 n+4s3P4WkOxesEduXyrGIJEjdDPCdEI9K2PDS9BiSRfmIjz1JmbWiyUGRuaZQ/DJ2F
	 7lJPhI6v6D6cA==
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-5ebc04d4777so402348eaf.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 31 Oct 2024 05:24:11 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCW1n3gnm9xUJMs6UDKHMH+v4A5AuI8zPh5prvfuqdV29OLa+6XLTOrO+UrERH/tl7FNU/Hy6GjgEYcdnh/i@vger.kernel.org
X-Gm-Message-State: AOJu0YxAOMGNroIaB4y8QX68KHUVOq74b6mdXJZsI+unD5/WlWYzZ9Hm
	hi+qcqXVjevZqdNHUmHdL4J1PTgvltTmjxiSpMjh1vPB+OM0ajUCdrEZodTAQgjouAnYMV03SoA
	s4MttX1/ZuBqCOHt4tJabGYKgtLU=
X-Google-Smtp-Source: AGHT+IGIxA511vuQU/X+p7mt6/fX9IDzc9G2HvvfuakS7FvF+sj/wxpZXD0usvVooWLcBpBtmJQ5KH051/CdVipj79c=
X-Received: by 2002:a05:6820:22a2:b0:5eb:c72e:e29c with SMTP id
 006d021491bc7-5ec5ed145eamr5207870eaf.8.1730377450913; Thu, 31 Oct 2024
 05:24:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <PUZPR04MB631696A2513D72126D4165B881542@PUZPR04MB6316.apcprd04.prod.outlook.com>
In-Reply-To: <PUZPR04MB631696A2513D72126D4165B881542@PUZPR04MB6316.apcprd04.prod.outlook.com>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Thu, 31 Oct 2024 21:23:59 +0900
X-Gmail-Original-Message-ID: <CAKYAXd8uceOOuSR+2YDY3RoEk_fCqMAHD55KNvG_GxO00ZwhGQ@mail.gmail.com>
Message-ID: <CAKYAXd8uceOOuSR+2YDY3RoEk_fCqMAHD55KNvG_GxO00ZwhGQ@mail.gmail.com>
Subject: Re: [PATCH v1] exfat: fix file being changed by unaligned direct write
To: "Yuezhang.Mo@sony.com" <Yuezhang.Mo@sony.com>
Cc: "sj1557.seo@samsung.com" <sj1557.seo@samsung.com>, 
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 30, 2024 at 4:47=E2=80=AFPM Yuezhang.Mo@sony.com
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
Applied them to #dev.
Thanks!


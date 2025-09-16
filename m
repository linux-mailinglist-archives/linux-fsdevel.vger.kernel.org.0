Return-Path: <linux-fsdevel+bounces-61698-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E2AEB58E80
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 08:34:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E90784859AC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 06:34:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F6002C1583;
	Tue, 16 Sep 2025 06:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gpQ9XHDX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C4E52586C7
	for <linux-fsdevel@vger.kernel.org>; Tue, 16 Sep 2025 06:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758004492; cv=none; b=ktGJ2L4xxtERTgZSU7CBogrLklJtwzWpQXZrnYehqr/dlRcKzl0+pcsfGZbR3UAoZ08Z49cb/nVsJJsTwO4wjwpKF2koz1O7afseU6CJFlRpiCaOvf4Y8R42Jq+HrIPECFh460mNOlrHYLujgag82Am5ke4Hg2aniPQghDVdkCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758004492; c=relaxed/simple;
	bh=pqjBLluBDQsx3isgteQFTFwq6cPulY/6rttR++T3Xyc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NFq8ir0W/iC4UNd5mNXD3JHpe5vcrTmM+MeS2tqIS/7P7OCtti2j21lkHHry340eIae3bNdF/zDEczMhdnZoUv3/AOTyRqvJRFNHaTARFwzyfi89x9jKyyCKfbl3I7P5nD6MNVJk5CQKLG/TSQWnpBBm6U9CO8SDhSVHP2F2uzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gpQ9XHDX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35593C4CEFC
	for <linux-fsdevel@vger.kernel.org>; Tue, 16 Sep 2025 06:34:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758004492;
	bh=pqjBLluBDQsx3isgteQFTFwq6cPulY/6rttR++T3Xyc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=gpQ9XHDX833jyUljjskl76BPPtpu4k5D1tpTOAeZTE4DUsQLOKtm4H7M5UkkEgMvM
	 Sh7aG44idUPtev1UMi/OZBePLqiy+wL9hKuN5XGlxFoEWPWddBaREhrKJm/XC9aiPr
	 D4HnTLnfmC3qlmOefJrav7hrhN0OUGIPt6N6n76Qi8iCYZmYZE/WdmUShwdUnpQ9sp
	 7sKNnDj+pVLpCmJWl7hmFzMGT99//SfmvGmKtm51QavQUyq+a9C1ucYm7OF/9MXs81
	 L1/Fza0eYyDEXVF5RvEOrdKI412eOKhGUXPcBl4opkqqZFiI0PkLxeffqo0jDmul1z
	 9uROzHYnrnO/w==
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-6228de280ccso10127974a12.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 15 Sep 2025 23:34:52 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWxPjqJkTpjtPyV9TJ+f9UnSwvyNacUDeC94N30Y5UbJm064FsCJovLRnPPresAzJ/aGKzdP9CjY6ItFP0D@vger.kernel.org
X-Gm-Message-State: AOJu0YxFavN7aaE8k1Ix1rGqQYHpXnpTLA2y90KOev/ozxTfMjg1clXi
	/LYCcnkFVr3hhMICN1X9P5SoRQuPvnAKkoywiuHCgisZ/ybGFRRjfpL14m14uOTE1mpzUEHspDC
	M42jvgTuSfkFCKy3zTbqlXVF3HcN3wnQ=
X-Google-Smtp-Source: AGHT+IGbVpVja4RdWz+7aJho3zauKYxHQiUpYzMYJRNGcKt/uxnZZB17Q5QRMvQM+HiDDyTJFNiIZzM5UVJ1/RVWVL0=
X-Received: by 2002:a05:6402:524a:b0:62f:51ed:1625 with SMTP id
 4fb4d7f45d1cf-62f51ed211emr3740767a12.35.1758004490747; Mon, 15 Sep 2025
 23:34:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250912032619.9846-1-ethan.ferguson@zetier.com> <20250912032619.9846-2-ethan.ferguson@zetier.com>
In-Reply-To: <20250912032619.9846-2-ethan.ferguson@zetier.com>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Tue, 16 Sep 2025 15:34:38 +0900
X-Gmail-Original-Message-ID: <CAKYAXd9PW_p6KZJu-Yz=wCm7S_-MV94FFY3G0U1on1DUBPDQ5g@mail.gmail.com>
X-Gm-Features: AS18NWDlf1id8Vil0W_4v2aPprK8H4P6QdwWDNDV5wa8TYpZKRmtciyiBaD0xjo
Message-ID: <CAKYAXd9PW_p6KZJu-Yz=wCm7S_-MV94FFY3G0U1on1DUBPDQ5g@mail.gmail.com>
Subject: Re: [PATCH v7 1/1] exfat: Add support for FS_IOC_{GET,SET}FSLABEL
To: Ethan Ferguson <ethan.ferguson@zetier.com>
Cc: sj1557.seo@samsung.com, yuezhang.mo@sony.com, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, cpgs@samsung.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 12, 2025 at 12:26=E2=80=AFPM Ethan Ferguson
<ethan.ferguson@zetier.com> wrote:
>
> Add support for reading / writing to the exfat volume label from the
> FS_IOC_GETFSLABEL and FS_IOC_SETFSLABEL ioctls
>
> Co-developed-by: Yuezhang Mo <Yuezhang.Mo@sony.com>
> Signed-off-by: Yuezhang Mo <Yuezhang.Mo@sony.com>
> Signed-off-by: Ethan Ferguson <ethan.ferguson@zetier.com>
Applied it to #dev.
Thanks!


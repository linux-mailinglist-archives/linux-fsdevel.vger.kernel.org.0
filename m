Return-Path: <linux-fsdevel+bounces-38991-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5553FA0ACB8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Jan 2025 00:46:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C3901886947
	for <lists+linux-fsdevel@lfdr.de>; Sun, 12 Jan 2025 23:46:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A977A1C3BFC;
	Sun, 12 Jan 2025 23:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I2Rgv8rR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03CFC46B5;
	Sun, 12 Jan 2025 23:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736725573; cv=none; b=TzkpC5XKNdY657shPlDHvidaHmWSEcjBdQq3ufE7rztiOyEQ5S3QFay0XyMlBhL1mmTk7dAGKgjHiZzAA11DDgtGxmRn0MOpSvbTS0C5s00SFqH1bQ8r4mvmSz3fsH7AclYhmeO5KXQ+0+Rw4LKBGt3aQd19JcD3L7lyiU4qHko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736725573; c=relaxed/simple;
	bh=KedvW7Rs+RJ7tAvRTdbAoJOKqmDvIAn4S2nq0eDaRQU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BOy+mAiOBB/s6m208r3d/vK9UDDqsXXPONyXD14qZ/A4zY50v4/265J0jNhI5YqiKvpO4YAtjOnVtVziZVokp1lMaKUKpz13C/Z8lkqKWYuBXobeNvu00ZFYSJWoPqvhpwBHYn9kq6EjRcvTSAH43PB289wGlNYiryq3iZOoTFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I2Rgv8rR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82AEFC4CEE3;
	Sun, 12 Jan 2025 23:46:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736725572;
	bh=KedvW7Rs+RJ7tAvRTdbAoJOKqmDvIAn4S2nq0eDaRQU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=I2Rgv8rRsfwsYqgK2GfdpK4bggMJjx8G1Mzu1kMqiu45aTWGIHnGv2r8b5aaniIdP
	 snEbHTSlGZsOPz/k/IRy/b0yr9uNJrPBKOGbVRNnj/941W+yLQoA/FFn6PyPsJ434v
	 uP9Uv7lMReZTj9Tqk7pAmU7KL3GHzL65MDUWtxD4uVBYJv5AngVfjey+g43MyJVUhV
	 kUhpb3AiVZqu4+aGBzbalnI1B3JjQbIIpl72fLyDIKyd+OKijh2EnH/gwkpW9m2tOt
	 3cYd/lg8jPNDSg0LOXXnkNA5A5vtM98U1AZiYowOHRnRlD33IqPnZCTEzCss2Qm7c6
	 YATy0DBdfxrcA==
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-3eba50d6da7so892219b6e.2;
        Sun, 12 Jan 2025 15:46:12 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCV+tB7N+sKYs8gFXZ+En9y2lENDmin34laT3Rgag9W550bWmz2bFthm1ZpW4T0jBHS1SJn45OMs3ybxfxLn@vger.kernel.org, AJvYcCX5guD+x33uekRT8OgiUbIGpAyHNJsHCi1g1rC3ZB99V0msMyfyDJpnlbpRy3YJi/bTAjwWirvZPD1gFQuN@vger.kernel.org
X-Gm-Message-State: AOJu0YzLKpAu9Wmej0n/nuDe1tcapbq2Gi38z7oVjRPSGgPWU76yJU70
	Glu4IiYTpWOPGA3iqdDGCxYrCn9wl/EFtdicJ6mQW4qg5A/UGuWjrXw8inT73dX0e8VjNd04FvM
	PElVFODa8fo4xfED95ArKdyiwnCs=
X-Google-Smtp-Source: AGHT+IGu10JICg1J9DZCj2bMhELS2IBLd10QNk4K2oNfmRjtpUvadPOBC6CVhOypsfIkgcbm/NGi8Kc2zlWRpWJEOe0=
X-Received: by 2002:a05:6808:2118:b0:3ea:57cf:7c26 with SMTP id
 5614622812f47-3ef2ec3dfe1mr12476462b6e.19.1736725571679; Sun, 12 Jan 2025
 15:46:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <8F76A19F-2EFD-4DD4-A4B1-9F5C644B69EA@m.fudan.edu.cn>
 <04205AC4-F899-4FA0-A7C1-9B1D661EB4EA@m.fudan.edu.cn> <CAKYAXd_Zs4r2aX4M0DDQe2oYQaUwKrPq_qoNKj4kBFTSC2ynpg@mail.gmail.com>
 <C2EE930A-5B60-4DB7-861A-3CE836560E94@m.fudan.edu.cn>
In-Reply-To: <C2EE930A-5B60-4DB7-861A-3CE836560E94@m.fudan.edu.cn>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Mon, 13 Jan 2025 08:46:01 +0900
X-Gmail-Original-Message-ID: <CAKYAXd-6d2LCWJQkuc8=EdJbHi=gea=orvm_BmXTMXaQ2w8AHg@mail.gmail.com>
X-Gm-Features: AbW1kvY-eFrJ5l8gNJJrr09hdRdooc9h6EN92x3DMxJy9feF1skFJ5u5p7JCjdo
Message-ID: <CAKYAXd-6d2LCWJQkuc8=EdJbHi=gea=orvm_BmXTMXaQ2w8AHg@mail.gmail.com>
Subject: Re: Bug: soft lockup in exfat_clear_bitmap
To: Kun Hu <huk23@m.fudan.edu.cn>
Cc: sj1557.seo@samsung.com, yuezhang.mo@sony.com, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	"jjtan24@m.fudan.edu.cn" <jjtan24@m.fudan.edu.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 12, 2025 at 1:35=E2=80=AFAM Kun Hu <huk23@m.fudan.edu.cn> wrote=
:
>
>
> > Please try to reproduce it with linux-next or the latest Linus tree.
>
>
> Hi Namjae,
>
> We have reproduced this issue in v6.13-rc6 and obtained a new crash log. =
The links are provided below:
>
> Crash log: https://drive.google.com/file/d/1qUmBfpcGeDMHsqBjurhymaH43Jnbv=
t-F/view?usp=3Dsharing
>
> It seems that the new report highlights additional issues beyond the orig=
inal one. While both involve exfat_clear_bitmap and __exfat_free_cluster, t=
he new report indicates broader impacts, such as multiple CPUs encountering=
 soft lockups, resource contention across threads, and potential conflicts =
with the sanitizer_cov_trace_pcinstrumentation. These suggest that the unde=
rlying issue might extend beyond simple bitmap management to systemic resou=
rce handling flaws in the exFAT module.
>
> Could you please help to check the cause of the issue?
This is an already known issue and the relevant patch has been applied.
Please make sure that the following patch is applied to the kernel you test=
ed.

a5324b3a488d exfat: fix the infinite loop in __exfat_free_cluster()

or try to reproduce it with linux-6.13-rc7.
Thanks.
>
> Thanks,
> Kun Hu
>
>
>


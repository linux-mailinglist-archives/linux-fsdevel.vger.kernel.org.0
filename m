Return-Path: <linux-fsdevel+bounces-68641-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 173EAC62E0A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Nov 2025 09:19:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B185034F6B0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Nov 2025 08:19:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCBF931B12D;
	Mon, 17 Nov 2025 08:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HyeFdCfE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4393830F812
	for <linux-fsdevel@vger.kernel.org>; Mon, 17 Nov 2025 08:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763367542; cv=none; b=XgCEJFwSnckMSNiUm1xygJHuhxvpdCAz09guwJB9UEkPxUOIdaR4hc6Gzmo2Aw+aRzYJM45hNY+VObyfNUBuCuZjvVp/oj9waWHBSRFjamqTwFqAt+SyXxNryXsNQmFVCMRagYTPqcs7nQOSyjh2RtcoKT3wjNcX4UlzL1AFbyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763367542; c=relaxed/simple;
	bh=cIoWhHJqbMkvg0uwF+SXmZG3jzCgZOeIwxZQkgGLSbI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OwGHzCZT6qzVKGwhVpcNjZ33fLAo/oGLHPegmrGAr4kRk1I93oq+blrFYHsmMxzIQyS9y6eFP1e5nlzDD5o0TTPSrq3A9LlIHFPzADhNdnRPNiPFNr66m/tPUdLnzwDOxr2kZhD07b+xB57j9xWJjN/4O5KkPxN5rA9h5nW5kU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HyeFdCfE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFC31C4AF0C
	for <linux-fsdevel@vger.kernel.org>; Mon, 17 Nov 2025 08:19:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763367541;
	bh=cIoWhHJqbMkvg0uwF+SXmZG3jzCgZOeIwxZQkgGLSbI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=HyeFdCfEg50UP9urONfSCc2jD7TZUUEfCiN/GCORM8DlBSG04QIIeIOrFMpOYha9t
	 wOCb+k/QKt0WXWsykFOE4aERWYHcNCicoHP4L67fD67oSbQwXvoNdoqahITY4aDl9q
	 BfsonIO2IW4mKcpnqLaCSE+NtHlntGqNNcqrG1oQ4jJ9GGoMDJ190WsjJENWHwH6uH
	 HpDwRk/F+mFBql5gx56UOVGPFO6yysVYmLqK2m6UL077IypvkAiIDZ1XKIZF7dQvry
	 0k3G5N0zV9wuybdtpRGnDhw7oQYi0lZBgz+W1D/w26LmOOXb4nhg8TpriO1FY8ihiy
	 aK4fedbc2P1rQ==
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-64074f01a6eso6720556a12.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 17 Nov 2025 00:19:01 -0800 (PST)
X-Gm-Message-State: AOJu0YzJecC6+x2bzZDaYnvQGUp6mKwNzbU6kyUU704zB+ayb4hP0cZw
	ZRqL3qrrUO9LAZ3T3YuDAk2VCCkA3pRzQl+/3hlBQj1Un1SqCqt465o3g+nlXrWaxJOmWPv/w8x
	H2h3S0bI7GxzI3F0LBYKxx/8faJ92hcA=
X-Google-Smtp-Source: AGHT+IFS482zVjuUKymQvoF32OIb1u639RCHBWt3JF0ZHi3qQIGN1htDwPOgoq2LDP4ingzy0kWdopOrErLL6qoqidQ=
X-Received: by 2002:a05:6402:1456:b0:641:1cd6:fee9 with SMTP id
 4fb4d7f45d1cf-64350e045f9mr10733424a12.1.1763367540492; Mon, 17 Nov 2025
 00:19:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CANypQFb0NeToJrTY5PQi57K_440xQJ1uUS2pMOKqLsqTdEGbRw@mail.gmail.com>
In-Reply-To: <CANypQFb0NeToJrTY5PQi57K_440xQJ1uUS2pMOKqLsqTdEGbRw@mail.gmail.com>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Mon, 17 Nov 2025 17:18:48 +0900
X-Gmail-Original-Message-ID: <CAKYAXd-eqH0HW_=bvTBx+ETtLO505ELRNMcjnUtFgq4waAMEVQ@mail.gmail.com>
X-Gm-Features: AWmQ_bklOb0tMMMaxWuoyHFlMjy_OjjwJv3Pt73hodiqLWs1lB7XOkwdz2l82BA
Message-ID: <CAKYAXd-eqH0HW_=bvTBx+ETtLO505ELRNMcjnUtFgq4waAMEVQ@mail.gmail.com>
Subject: Re: [Linux Kernel Bug] divide error in exfat_load_bitmap
To: Jiaming Zhang <r772577952@gmail.com>
Cc: linux-fsdevel@vger.kernel.org, sj1557.seo@samsung.com, 
	linux-kernel@vger.kernel.org, yuezhang.mo@sony.com, 
	syzkaller@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 17, 2025 at 3:55=E2=80=AFPM Jiaming Zhang <r772577952@gmail.com=
> wrote:
>
> Dear Linux kernel developers and maintainers,
>
> We are writing to report a divide error bug discovered in the exfat
> subsystem. This bug is reproducible on the latest version (v6.18-rc6,
> commit 6a23ae0a96a600d1d12557add110e0bb6e32730c).
>
> The root cause is in exfat_allocate_bitmap(), the variable
> max_ra_count can be 0, which causes a divide-by-zero error in the
> subsequent modulo operation (i % max_ra_count), leading to a system
> crash.
>
> As a potential fix, we can add a zero check before the loop, for example:
>
> ```
> static int exfat_allocate_bitmap(struct super_block *sb,
>     struct exfat_dentry *ep)
> {
>   struct exfat_sb_info *sbi =3D EXFAT_SB(sb);
>
>     ...
>
>   sector =3D exfat_cluster_to_sector(sbi, sbi->map_clu);
>   max_ra_count =3D min(sb->s_bdi->ra_pages, sb->s_bdi->io_pages) <<
>     (PAGE_SHIFT - sb->s_blocksize_bits);
> + if (!max_ra_count) {
> +   i =3D 0;
> +   goto err_out;
> + }
>   for (i =3D 0; i < sbi->map_sectors; i++) {
>     /* Trigger the next readahead in advance. */
>     if (0 =3D=3D (i % max_ra_count)) {
>             ...
> ```
>
> If this solution is acceptable, we are happy to prepare and submit a
> patch immediately.
Rather than handling it as an error, it is better to not use readahead as b=
elow.
Please review it.

diff --git a/fs/exfat/balloc.c b/fs/exfat/balloc.c
index 2d2d510f2372..0b6466b3490a 100644
--- a/fs/exfat/balloc.c
+++ b/fs/exfat/balloc.c
@@ -106,7 +106,7 @@ static int exfat_allocate_bitmap(struct super_block *sb=
,
                (PAGE_SHIFT - sb->s_blocksize_bits);
        for (i =3D 0; i < sbi->map_sectors; i++) {
                /* Trigger the next readahead in advance. */
-               if (0 =3D=3D (i % max_ra_count)) {
+               if (max_ra_count && 0 =3D=3D (i % max_ra_count)) {
                        blk_start_plug(&plug);
                        for (j =3D i; j < min(max_ra_count,
sbi->map_sectors - i) + i; j++)
                                sb_breadahead(sb, sector + j);

Thank you for reporting this issue!


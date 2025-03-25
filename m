Return-Path: <linux-fsdevel+bounces-44951-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5A3DA6F433
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Mar 2025 12:34:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52BE03B80B4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Mar 2025 11:34:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3887B255E4E;
	Tue, 25 Mar 2025 11:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DciKNATW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DE4ABA36;
	Tue, 25 Mar 2025 11:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742902452; cv=none; b=WXizXqZP+nZoD8D8izKeJhlbCtGmPd9o6ZIIjeAjRz2Yrd93kykf0afaonapP2FNS6ZBTW23aVwI9Yyg2D2JsNOxOqVI3Mpsard3NnKORxHKghKM91l/ebmTVUJoSheu6OGHCJeZGnwzoOEMf87pxkdZyfd68WG1DtD7ZXjJ2W4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742902452; c=relaxed/simple;
	bh=kXIhNH5Zx8yhHqkYScg7m7Lk7x8tX+Tr7Vm0yKt300s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HdG4cfTR9rj3jw36xtrafFyvNZW4Q9QacexT1Ynzjra5UCBBGjwYN92OtWCVtlJrIbukigL8l8GBUVVswrv5wzk2pLglWAM8nwn/UWb7wT/AHVhc/LGmH1yQubDqvfEtlaf1p8jjFG8cbJZdcxgczKXMcCT1le5DDLUdNdI+eV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DciKNATW; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-aaecf50578eso1000612066b.2;
        Tue, 25 Mar 2025 04:34:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742902449; x=1743507249; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LyYcDHV3MeCVFAan2iS1JnE3lnrZma43IPGcoEqcEWs=;
        b=DciKNATWZ7da6XYETdlv2Jky6OBjzNbPRmgh98PBxYgR3Kd3tvpnLE+5MiSIllJ7YJ
         oEv6OutGs2vpCr4TRLB3XvhPBCp0S8KgUZS0GuOSWgQq6TTv90GSTxAvpn62sg3mFNw1
         5QNVjtNaf1aJACeuuWxQAv8CHfO/Qx5H9+tocErh+X58kWrXQBmJT6W3ffSHIty9vlZ8
         1M180R7drSFvZhvgCPrpNHTuY8Ma/niqR9TiSX2igAbaVQq2I0tTSghBvVNYJ5VYvQzJ
         IAK3J1XniLwbdkVzsWxAbafnjYyYEfaqeUy93jE5diHUWQ3ZOf+76j2MuCmfa4cqT9kS
         EbPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742902449; x=1743507249;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LyYcDHV3MeCVFAan2iS1JnE3lnrZma43IPGcoEqcEWs=;
        b=h5BR4hjIumwP8Ee9kBGhUiS9AvmthRwaJCBby0BINCr+ZRrYpxDcrWj6+xXf/85wnK
         OqR/LmVM7VejvkBYFr0Qlep0o5bLyEqvhuWCcfIio6RQP72OpO5OEvJIkQnD7QkLZ2o3
         JD85n0hrsoXcI4skj0AuyYeOqyPUTOyucy1FHHERd05ZWUU6gXxETc3vI3GUkPCDGU3g
         wgdBLDr7oJ5cJ6IvRVKpr3flKscSBGt6hxCL+zc/6oT0mLiRI4RWcp5gv640bHt1663k
         rm3TXmR4Mbza2X2k/oBx41icQk8nTEFw0Qo69T2VTjdad1xfrPo8hMfTSm/3325BGf3N
         Jj2A==
X-Forwarded-Encrypted: i=1; AJvYcCXJCNXbj8+5a3h26z4XKJzpS6cHb9GJmgXTgtgnC+77IFxkyNGfUa8zlWUXBcaUPjg37PK/cvzbQ37/k8nq@vger.kernel.org
X-Gm-Message-State: AOJu0YyCUj7+JV4ST+KtIlROTWqzivOlODxkFm41wFPexhsVcSRBQUp8
	+WltXusmRlkoz2VqRjD+RKWvViLrf/AmRjEVBql/2dwNsq6BdDCq3jgOAmk3FyRaTLJJDGuNiBt
	CCg3Zq5QlRThcT5nc7Ig0TLF+qkH6m9CxIpM=
X-Gm-Gg: ASbGnctlWCmMhTXmyqwyq9gQpdOP7S++p3RKx2Bby4T5kJ+2ZDRlAMBeBBQf5Hjup0H
	lHDRTTlFtPIUobpVN6koMqhnFIs5hFT1A3w+EECbzOZHJiRyVNVc+UPRoJFR9NLcIaBTfrxlKGE
	dlXfzSHZ2Vm1o4hD1l/bea/BoD1B8vWDKM1eQ=
X-Google-Smtp-Source: AGHT+IEU2judBSrrGKJG8xSJ8+SEasYx4jHEPAEmHvaTmKoi76Th3aT6Mje4CUMs/3Gf3FeolfQVXkS4BLacUCoZtX4=
X-Received: by 2002:a17:907:d7c8:b0:ac4:2ad:44d9 with SMTP id
 a640c23a62f3a-ac402ad46bfmr1469255066b.24.1742902449031; Tue, 25 Mar 2025
 04:34:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250325104634.162496-1-mszeredi@redhat.com> <20250325104634.162496-6-mszeredi@redhat.com>
In-Reply-To: <20250325104634.162496-6-mszeredi@redhat.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Tue, 25 Mar 2025 12:33:57 +0100
X-Gm-Features: AQ5f1JoOFojxjwabGWnYnlwE_BINrcvxe6EREEdw9cBI9q62xxWW2Hqo4UHIBYc
Message-ID: <CAOQ4uxgif5FZNqp7NtP+4EqRW1W0xp+zXPFj=DDG3ztxCswv_Q@mail.gmail.com>
Subject: Re: [PATCH v2 5/5] ovl: don't require "metacopy=on" for "verity"
To: Miklos Szeredi <mszeredi@redhat.com>
Cc: linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	Giuseppe Scrivano <gscrivan@redhat.com>, Alexander Larsson <alexl@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 25, 2025 at 11:46=E2=80=AFAM Miklos Szeredi <mszeredi@redhat.co=
m> wrote:
>
> Allow the "verity" mount option to be used with "userxattr" data-only
> layer(s).
>
> Previous patches made sure that with "userxattr" metacopy only works in t=
he
> lower -> data scenario.
>
> In this scenario the lower (metadata) layer must be secured against
> tampering, in which case the verity checksums contained in this layer can
> ensure integrity of data even in the case of an untrusted data layer.
>
> Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
> ---
>  fs/overlayfs/params.c | 11 +++--------
>  1 file changed, 3 insertions(+), 8 deletions(-)
>
> diff --git a/fs/overlayfs/params.c b/fs/overlayfs/params.c
> index 54468b2b0fba..8ac0997dca13 100644
> --- a/fs/overlayfs/params.c
> +++ b/fs/overlayfs/params.c
> @@ -846,8 +846,8 @@ int ovl_fs_params_verify(const struct ovl_fs_context =
*ctx,
>                 config->uuid =3D OVL_UUID_NULL;
>         }
>
> -       /* Resolve verity -> metacopy dependency */
> -       if (config->verity_mode && !config->metacopy) {
> +       /* Resolve verity -> metacopy dependency (unless used with userxa=
ttr) */
> +       if (config->verity_mode && !config->metacopy && !config->userxatt=
r) {

This is very un-intuitive to me.

Why do we need to keep the dependency verity -> metacopy with trusted xattr=
s?

Anyway, I'd like an ACK from composefs guys on this change.

Thanks,
Amir.


Return-Path: <linux-fsdevel+bounces-34557-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 785AE9C6598
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Nov 2024 00:59:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A389BB4629C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Nov 2024 22:05:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7530721A6EC;
	Tue, 12 Nov 2024 22:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="InWKjmn7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3611520ADED;
	Tue, 12 Nov 2024 22:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731449080; cv=none; b=IaU1H9L3ifLKJ5sVwFrqYImSUfl1U69UVJXYPZQIUYxhRMZr6Dt5TjI89fTycdQf7AyNjPoNJ9dGS3SGnADcrFx/KkPy/RHYsamDjEA+e0HBTqYF+mWZ3suuNJTJ7nFDJw7RsX7Yg9NbTTiNjTHqEvHu571W+A/stKU7PyW2TbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731449080; c=relaxed/simple;
	bh=ef3LqFPD+hztI4mv7ONPMUuuSFYec47dy9v520a4Qwg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=l8VFJaaZICncU+MPsvUBLSDZBGFQLMKVYOLscVeohkd7iLARHlf6Uf8u+CfhmXo2CQcpgRrdpYldjgJElU3Rltnp70JTsBe1R2cOejSRqILfOdBGPJL6yhD8Err3/F5v0VI4KVqMLGObOW8X8ZixOpBm4S9Jjp/q1gwBy1rAQpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=InWKjmn7; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-37d808ae924so3836300f8f.0;
        Tue, 12 Nov 2024 14:04:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731449076; x=1732053876; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iXTPqpDnYFI6dKGuVKiCWlxzB4ZTcYu8i6NDjSe9Y1A=;
        b=InWKjmn7FKonPoeVrKnJOAQMeyQkrKnClGdUOX02fFeVnKXx2QwSxtr9iGzPVXKiDp
         TV/gc8MrRoP5ybaJB71qJObvxTwCbsLJnggwIvR8Fhn1u7/v2Whm27SfoQwEQu8W7hLk
         MadzNzmCwnV2iCkIyt9tH2XIoRkhPFdKIVLO/7cXR56gyxN6EOE5cOYIQCQKRAZkbRsl
         SOK3w0agmMKSvV5Ib9k9FZzJKriV6TN2lebOrpCwjTVIsMxsAaVaeL73FCZekAmpyzlq
         ONKcO5ePTH2+RQjcj0GyCnHV0Z/Qx5OIkg2kKZxIv/1zPvQymT/C+IBEVnvMl1lADEoN
         jvwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731449076; x=1732053876;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iXTPqpDnYFI6dKGuVKiCWlxzB4ZTcYu8i6NDjSe9Y1A=;
        b=oTVPxq4YRF05N8iSWdwAdCybIEn7Bw+sFklcEd/fQ4CAVQbe/bi7g0BO6gjWAFgVKX
         4OA9T9FF2jkGt8Th5b94q/bFOqhFGoeao1ltiNcgZSheE/bmkAYonNzvMJLO5c3VignL
         UEfK0qKRTs/e39AijC0xgD5qvIxCkMiaj8WHHbMSbZAo2APLGDRm2wKNxfAo7eXg23ve
         5WTOthhN2B6lv1SIosyLZEq2VE3qotqPa/yQ3/H8080nCJZxpHbKFwrJNejrMSBpmtM0
         7Y3/rXLUPw27hU7adRTjjRZAfp6Md5HBRfMf3HZKFFKaP7TeL3AGWIVjXQRktZQesqzH
         b56Q==
X-Forwarded-Encrypted: i=1; AJvYcCW+I1E27W630xElAh1zwp2OWuWrL3a6cDGnjoaHsfRTulDfv7aqTqwwPP/aBZcjA8AHWANOqGrBFTKuKa3evYae2WBDl135@vger.kernel.org, AJvYcCWJi7+hyk4pDm0zL7tgJ8zvCrjeyvaVelbp/hB0GUV58XqH+xe+cptGlMxrRB09EVAmjl0smC/TLxQLjjae@vger.kernel.org, AJvYcCWKHP/0G4/+MRTvJ++oBExkHmNmZKQ7uxJosyPXNLVw5WLKRwjLwC3+k24E/JUYwI2bAPd6Uny6ZjxnIRil@vger.kernel.org
X-Gm-Message-State: AOJu0YyAMM7Nk8pqTzC8AtZFhiA24sMb01pBE5nh6BuX0uT3DXhEAMXD
	OCIN8WPaxJwK+KHMuASLA6Jp1JcrtGTywU/ia1NRswiAMIEkjprvyjce9cdsPmepg041QTW3QdM
	+uyMMQTirSenI9vPI5OBBQbYhOZn6SQ==
X-Google-Smtp-Source: AGHT+IERdWZZ7dWrDNwaHgLXJrof91y4q0FaGemxGDUD7GMdPHn+HWOIGgnkhTHxJzCbbwIdPBC0BCTJl36YDMxR5/E=
X-Received: by 2002:a05:6000:4007:b0:37d:4cf9:e085 with SMTP id
 ffacd0b85a97d-381f186f974mr15396491f8f.25.1731449076167; Tue, 12 Nov 2024
 14:04:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241112083700.356299-1-song@kernel.org> <20241112083700.356299-3-song@kernel.org>
In-Reply-To: <20241112083700.356299-3-song@kernel.org>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 12 Nov 2024 14:04:25 -0800
Message-ID: <CAADnVQ+FCimF_0W0+K872BCtFeLKf+bA_Zy8s_dVdhkhpUcLyA@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 2/4] bpf: Make bpf inode storage available to
 tracing program
To: Song Liu <song@kernel.org>
Cc: bpf <bpf@vger.kernel.org>, Linux-Fsdevel <linux-fsdevel@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, 
	LSM List <linux-security-module@vger.kernel.org>, Kernel Team <kernel-team@meta.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Eddy Z <eddyz87@gmail.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, KP Singh <kpsingh@kernel.org>, 
	Matt Bobrowski <mattbobrowski@google.com>, Amir Goldstein <amir73il@gmail.com>, repnop@google.com, 
	Jeff Layton <jlayton@kernel.org>, Josef Bacik <josef@toxicpanda.com>, 
	=?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, gnoack@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 12, 2024 at 12:37=E2=80=AFAM Song Liu <song@kernel.org> wrote:
>
> inode storage can be useful for non-LSM program. For example, file* tools
> from bcc/libbpf-tools can use inode storage instead of hash map; fanotify
> fastpath [1] can also use inode storage to store useful data.
>
> Make inode storage available for tracing program. Move bpf inode storage
> from a security blob to inode->i_bpf_storage, and adjust related code
> accordingly.

...

> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index 3559446279c1..479097e4dd5b 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -79,6 +79,7 @@ struct fs_context;
>  struct fs_parameter_spec;
>  struct fileattr;
>  struct iomap_ops;
> +struct bpf_local_storage;
>
>  extern void __init inode_init(void);
>  extern void __init inode_init_early(void);
> @@ -648,6 +649,9 @@ struct inode {
>  #ifdef CONFIG_SECURITY
>         void                    *i_security;
>  #endif
> +#ifdef CONFIG_BPF_SYSCALL
> +       struct bpf_local_storage __rcu *i_bpf_storage;
> +#endif
>

This bit needs an ack from vfs folks.


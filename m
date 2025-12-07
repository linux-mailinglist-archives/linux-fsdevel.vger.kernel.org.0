Return-Path: <linux-fsdevel+bounces-70952-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 86284CAB2D0
	for <lists+linux-fsdevel@lfdr.de>; Sun, 07 Dec 2025 09:42:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CB94830050B4
	for <lists+linux-fsdevel@lfdr.de>; Sun,  7 Dec 2025 08:42:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6BFC2E9EC1;
	Sun,  7 Dec 2025 08:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="LqiyTnsA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF0A823B62B
	for <linux-fsdevel@vger.kernel.org>; Sun,  7 Dec 2025 08:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765096955; cv=none; b=qs6g6AYPl5n4KxrRi9Qun7EbONik/NeegZB4gGz2V9F1Ke/pKlF6oYuyT8ePjWuIQOJN9narcQQzDQImArIKabD59Y55LROYW6L+Lr95n5EUZWIk3pg3d4LLeE5dYugqI7I/XYtVbIkPrW/+XJOIsA3X3Y6pjiH3GJyIRGur850=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765096955; c=relaxed/simple;
	bh=WfWLzH+QtHiPwejFZ4ESmAPfSKspUK2Iblm8w5YiNzM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ISJmoJLxiHGBNMnmn62qkPTGpQC8s8MYn8nnk2CI5NYNT8QK+uStVmXye5mQ5JDVKfBYIokE6Rv29RoYU3Ll7UaUErTXwZUG/nHwwCRbRJSGPWvGuldcFpEamI/0BcKLt0Hiz8GEM8EZa5MmakYze91gm2ipG+IJF6h5UzSp8rs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=LqiyTnsA; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-297dfb8a52dso4430205ad.0
        for <linux-fsdevel@vger.kernel.org>; Sun, 07 Dec 2025 00:42:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1765096953; x=1765701753; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zn0TCrqxsSAmiJy2pjhuWlPB88FPESlPZveON9orP+Q=;
        b=LqiyTnsAL0tDy2sdgewOCEL8+dsEXsIKOh+mO0lZ+etIv/UC2CJnzGKmSQVqmpwmIS
         uszny5RUynqJZgxm+7GxaZNqS1mCCQTuH51N0aC295RJE3C1rstJMS/+dU3zRGQJ+ROC
         Zspp0/b0bRtd0bXg7TxbBJOUdxJTLsZ056yTIszteOo5hXGJib8weGcFAqvEmjXQwe05
         6Ce4O/rP3funjbdmzwAuGFl6sQQz3vfycKDhVvcgF+eCkDSiy6XXl08/AtFSyORG9pyZ
         n82j0IHk8nFUPmQeZEfGz6oxVo2J84CaEPqeFTR8sZ0icnKLhP9FN1v9QJO/nnx3VP/a
         FvQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765096953; x=1765701753;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zn0TCrqxsSAmiJy2pjhuWlPB88FPESlPZveON9orP+Q=;
        b=htbrMmLmeUd5wIS/bpw3PoIB8K1XvEMmCYC+SMGm88dhqljZQ8ZgL5rBWVHeQCPx8i
         YaZm9PAe46X1rgWT2E663xKCV58BlfJcQE8Ex+MZtswM3Ss8zFTTfUmlKQ9fkAce1hrj
         j4rhliuYcEWQui2rYgpYhTkjjjLz7MJ/BO2GsXsGiaF6oJiwS4jnWn+P/feT+u7G6SAr
         gobxYSwmxTfO9B3Oi5O/vt8yq8lAfhRBJPJe57kzB2BfQWU1q6v6POgPYPg22Ytu41E1
         hdnz+zmSvmZdpnTnTMVLV9msEaSAuRuF5eTZK10l+vxPQ42Gvw1Z7/Dg9TJKz5yi85Ce
         oeNw==
X-Forwarded-Encrypted: i=1; AJvYcCVPWxYITqPEe0oEqYT70jhEBW6OMzeeSYO9cd7SapCXQp0efiqPDcL6AHVE2cxYDFWP7p/t1lwkMg/bskjn@vger.kernel.org
X-Gm-Message-State: AOJu0YyPw5HEmSsJfI0Jj66PNQp5QW5s7bio0yhYnC2iIIVk1E9Vq22X
	jnPyTBmmi7nr+CTRYOQn/68aM5MTiVMIufla5/x++uTBVQkphuLpyHjOWf/y9z6tmDctk7d6v0k
	EohmYQ9YbnzUDbAu6xRijDQtona8s9XT7Kbhw+LZCjg==
X-Gm-Gg: ASbGncvYcVFWcoGZFi9Xz0XYlyBtkO36cygzbG9dMB3rF2bLbuqJj6dTP/PNFNlBpiL
	o0VPRfqw/yKSbuBJVgpEcIy6fhRe5pxAQALj89R/Quf3dAYRTYBhSQqHkgQq2YGXEC1uQru7zdA
	uCCKttA4aCwlkI5GUtTGFr1sWbLeZCiu1YqZOz6vsquJn8M0EKbCncXl2rd+JmTgXbk+IIwhD/+
	g9JZ3RrkOJ/AIMYT/JZ4ESdqPR1E0U1zYI/RP7m5En2k05fHrKCcl/wQais6mecYn7gpUi8
X-Google-Smtp-Source: AGHT+IHUT+y6UkGiP9rKvffnCpnc8EeoQi7nHIUcEb/aXf01i65WD400NIIsftq5ucQhbMakatsmyVJ8Hr4ePdfh0Ck=
X-Received: by 2002:a05:7022:49f:b0:11e:3e9:3ea5 with SMTP id
 a92af1059eb24-11e03e9447cmr1848664c88.7.1765096953051; Sun, 07 Dec 2025
 00:42:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251203003526.2889477-1-joannelkoong@gmail.com> <20251203003526.2889477-25-joannelkoong@gmail.com>
In-Reply-To: <20251203003526.2889477-25-joannelkoong@gmail.com>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Sun, 7 Dec 2025 00:42:21 -0800
X-Gm-Features: AQt7F2pc21BBeN2HWbX86e7phYaZSB8x1ZZ_Ee_93JIbwmjcqTTombdxWHZe-j8
Message-ID: <CADUfDZorWUN+RHcMWqxi+9nOzcV1OrnYcZvVNHwZUpJ=ZcmV1A@mail.gmail.com>
Subject: Re: [PATCH v1 24/30] io_uring/rsrc: Allow buffer release callback to
 be optional
To: Joanne Koong <joannelkoong@gmail.com>
Cc: miklos@szeredi.hu, axboe@kernel.dk, bschubert@ddn.com, 
	asml.silence@gmail.com, io-uring@vger.kernel.org, xiaobing.li@samsung.com, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 2, 2025 at 4:37=E2=80=AFPM Joanne Koong <joannelkoong@gmail.com=
> wrote:
>
> This is a preparatory patch for supporting kernel-populated buffers in
> fuse io-uring, which does not need a release callback.
>
> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>

Reviewed-by: Caleb Sander Mateos <csander@purestorage.com>

> ---
>  io_uring/rsrc.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/io_uring/rsrc.c b/io_uring/rsrc.c
> index 18abba6f6b86..a5605c35d857 100644
> --- a/io_uring/rsrc.c
> +++ b/io_uring/rsrc.c
> @@ -149,7 +149,8 @@ static void io_buffer_unmap(struct io_ring_ctx *ctx, =
struct io_mapped_ubuf *imu)
>
>         if (imu->acct_pages)
>                 io_unaccount_mem(ctx->user, ctx->mm_account, imu->acct_pa=
ges);
> -       imu->release(imu->priv);
> +       if (imu->release)
> +               imu->release(imu->priv);
>         io_free_imu(ctx, imu);
>  }
>
> --
> 2.47.3
>


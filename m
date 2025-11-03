Return-Path: <linux-fsdevel+bounces-66822-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 19EE9C2CE3B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 03 Nov 2025 16:49:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E39E6427B60
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Nov 2025 15:40:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFAFC27B4EB;
	Mon,  3 Nov 2025 15:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mihalicyn.com header.i=@mihalicyn.com header.b="DuuUb9kS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6876E1B4244
	for <linux-fsdevel@vger.kernel.org>; Mon,  3 Nov 2025 15:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762184192; cv=none; b=tr07lB0wJngZaHlVZXI6ShqsBick5inKECFonY5O4tfqRDlJZraUsJylNFzUvuwXZAiw4nqAyTfxgQihamOyTF+tJKzyioTgiori+mBD0y5TXqIceULtisQYWXdVfjVhJmxkPad12xsE9uA0dyx/ymjxaFizt6XNAKo37ki/cmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762184192; c=relaxed/simple;
	bh=gEnexRt2+csi5XaC3lzTGlhcekCOaPMwHX1bHBIBtuc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dwhB2uLu8/9BOoeeLHzs4NBPu/fRai9I41O/M3Up6Z7XuQbrmA4NaSzL0w6af3ABM+lt9G/2S565FuCOcXXAneXNU12Ek+AUn99VTK0VY46+jIeQgLzhLmdwXNN4JcYLxTt+39OsP0SRSMTkTAxgAPML39E2S3+5bzfGaa3tuX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mihalicyn.com; spf=pass smtp.mailfrom=mihalicyn.com; dkim=pass (1024-bit key) header.d=mihalicyn.com header.i=@mihalicyn.com header.b=DuuUb9kS; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mihalicyn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mihalicyn.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5942ee7bc9dso807121e87.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 03 Nov 2025 07:36:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mihalicyn.com; s=mihalicyn; t=1762184188; x=1762788988; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=zzaNsEzQhP5goti+8a1Sk9MxbSfJlJSHEPqAlOOrCs0=;
        b=DuuUb9kSsjBABxTq9zhbEI0S6w6uuVQwTBfqcybvKbOqplf4u14sU7T3TjVoWjwjJk
         B+Zcwb9FvR0Hmm4URjL1EdhoNDL0V3YgwICDkOwCjVykmXEB5+PT4I6sRt5C3YP5AeR5
         a6gDZkDZDgdRv/clMPxtOP3v19j98ooSB0pco=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762184188; x=1762788988;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zzaNsEzQhP5goti+8a1Sk9MxbSfJlJSHEPqAlOOrCs0=;
        b=Mp38grDpan7OgEU+7YN3gHpnBs0d0BHJb3HrYGDVIH57OL4QF8hhi+u6RLbrRgRdKU
         a3chauHOUmsToMC0uTQ2nTmsQP0J1cmkwkrTUx4SGmSgJWYyKSjRKMqf4TCijSkcBSn8
         8KwI35opCtTQFQOWwmZjvr54kNf9g0ak4IK0r1yIKbeyJ4/pvZjtvi81y1IBhSNx4Ylr
         oLGVJdZ+1r1zogYSnYTTtTrQqtwMq2szdc2hnSye1nOXt15pbF5Z23LI1W7tK2VO+JXX
         7MDFfTF4Czbx0AUbO38Y/JR8Rh2v811iIbOBEoockygpZHm5lcaVuKKhzsuON62nQwrS
         b41w==
X-Gm-Message-State: AOJu0YyJ/cTW1jLbYei/yGYrUv/XyRa4P1LX2xGZhEELjRrf/7ofxfV9
	KYR3G1jxT8CEEB81D6fGvNUVzs98EbA8EE5pQp+3vhHNHQMDZHhJMeXqM6uI6XOuiTbv2DWS5N2
	dtIGvUEdCe4CeRGjlC9QnG5qYdGAuadJQs15uF27Wtw==
X-Gm-Gg: ASbGncvbEL2tsLp4FbzubVHKphRl14CDgzBd3F4hpSbPr0cz8Cg9+8Sw2u4LqO+Ce4T
	m0w/cwTXlomWsYY8GclQWrU9/oDleYG6O1CU4bo28e8lIco9kBuASP4EcVGzUIe2YgC5u7gjIZu
	c4rjFhbuSXJgJjA/dW4K553YXB9iS/G4yJyhI4DUo21Fvz5epSUNEjdrcu891aDyxHM2b+uhBtZ
	hfZWfXFaaz4WvBMkp6LL9M56gZb0vFunmA1aJBWBBHb+sspD8uG5/PNS+F0LVol4fwCmeo=
X-Google-Smtp-Source: AGHT+IH9HFX6m2RKwMUsRL27KWY/hEtnivxTOj9RRRvqz7hBvsvziImPZeLtzdqcc2cw0n4sxqvyxW74pWwgcfRjuf8=
X-Received: by 2002:a05:6512:3e10:b0:594:2f1a:6ff0 with SMTP id
 2adb3069b0e04-5942f1a7404mr801173e87.9.1762184188265; Mon, 03 Nov 2025
 07:36:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251028-work-coredump-signal-v1-0-ca449b7b7aa0@kernel.org> <20251028-work-coredump-signal-v1-3-ca449b7b7aa0@kernel.org>
In-Reply-To: <20251028-work-coredump-signal-v1-3-ca449b7b7aa0@kernel.org>
From: Alexander Mikhalitsyn <alexander@mihalicyn.com>
Date: Mon, 3 Nov 2025 16:36:17 +0100
X-Gm-Features: AWmQ_bkG7jG1pb0tTG3Lf2yxUryV1bOUHLFfSOR9QoDXujCIssfdL2lCJtw2h04
Message-ID: <CAJqdLrqvH4Trs=mbQ8qQGqw1tFdBg_5CLSByT8Ectxbk1p_36Q@mail.gmail.com>
Subject: Re: [PATCH 03/22] pidfs: add missing PIDFD_INFO_SIZE_VER1
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Oleg Nesterov <oleg@redhat.com>, 
	Amir Goldstein <amir73il@gmail.com>, Aleksa Sarai <cyphar@cyphar.com>, 
	Yu Watanabe <watanabe.yu+github@gmail.com>, Josef Bacik <josef@toxicpanda.com>, 
	Jeff Layton <jlayton@kernel.org>, Jann Horn <jannh@google.com>, 
	Luca Boccassi <luca.boccassi@gmail.com>, linux-kernel@vger.kernel.org, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
	Lennart Poettering <lennart@poettering.net>, Mike Yuan <me@yhndnzj.com>, 
	=?UTF-8?Q?Zbigniew_J=C4=99drzejewski=2DSzmek?= <zbyszek@in.waw.pl>
Content-Type: text/plain; charset="UTF-8"

Am Di., 28. Okt. 2025 um 09:46 Uhr schrieb Christian Brauner
<brauner@kernel.org>:
>
> We grew struct pidfd_info not too long ago.
>
> Fixes: 1d8db6fd698d ("pidfs, coredump: add PIDFD_INFO_COREDUMP")
> Signed-off-by: Christian Brauner <brauner@kernel.org>

Reviewed-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>

> ---
>  include/uapi/linux/pidfd.h | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/include/uapi/linux/pidfd.h b/include/uapi/linux/pidfd.h
> index 957db425d459..6ccbabd9a68d 100644
> --- a/include/uapi/linux/pidfd.h
> +++ b/include/uapi/linux/pidfd.h
> @@ -28,6 +28,7 @@
>  #define PIDFD_INFO_COREDUMP            (1UL << 4) /* Only returned if requested. */
>
>  #define PIDFD_INFO_SIZE_VER0           64 /* sizeof first published struct */
> +#define PIDFD_INFO_SIZE_VER1           72 /* sizeof second published struct */
>
>  /*
>   * Values for @coredump_mask in pidfd_info.
>
> --
> 2.47.3
>


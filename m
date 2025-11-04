Return-Path: <linux-fsdevel+bounces-66898-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5956BC3012A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 04 Nov 2025 09:54:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 06CE434DDE3
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Nov 2025 08:54:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E79930BF58;
	Tue,  4 Nov 2025 08:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mihalicyn.com header.i=@mihalicyn.com header.b="H34Il7WF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2D883FCC
	for <linux-fsdevel@vger.kernel.org>; Tue,  4 Nov 2025 08:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762246373; cv=none; b=WgVRa43Ne6gwDFweOs5gD+hDRxlZWk91lhkS9TuQb29eNaCuaY8tcRKNPeEfqB4FvDgMPIhWaJsJ2OR68SBBBsOh0J2gl55Di9HUUMtH6/4qz6Aiz0Ujda9YcELOj2nRDGakEliLtsmm95Cxt02IYyVM3tJ8sSrVHPXYZ9wG25U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762246373; c=relaxed/simple;
	bh=HI7+rpZeec/CFooIPQ0R6s6hxWdGC9RE3ZH35FZIEZQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XnbXN9yA514mueZQOaivjSJVH3S4/ug9Bwv1sZdzU2p1wofMDMCgkIhM9gj960EHDwZPBRgKpP++qCBF7Cpi/yn8d9/c5sy4rNtUvj7d+eQMTfB6w6CeOVnZQ5OSBgalA1i/eowit8KNQr0d0kJMLRzJz2LIzLN6AdR/Wtz2eLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mihalicyn.com; spf=pass smtp.mailfrom=mihalicyn.com; dkim=pass (1024-bit key) header.d=mihalicyn.com header.i=@mihalicyn.com header.b=H34Il7WF; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mihalicyn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mihalicyn.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-59428d2d975so2240476e87.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 04 Nov 2025 00:52:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mihalicyn.com; s=mihalicyn; t=1762246369; x=1762851169; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Z75IjBPhT4kst0ejXkiZdr4y608GAAjYfVhWlec6GjE=;
        b=H34Il7WFs0mHCBKgXj0oDgT8n2snvYmESP5TfK84737DvX/ln/coIwJ757rT2+1aap
         oMJL0qRHsmcoi+VK/rEZ0bJrSLeVBDHTMahYNTXqOpxYMsYsN1jfYAhAqoNnvjFvjL0r
         kDfsPZkL6SXeWFNBF4Nut/7SkfP4VWeu+XCRk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762246369; x=1762851169;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Z75IjBPhT4kst0ejXkiZdr4y608GAAjYfVhWlec6GjE=;
        b=ZRzj0sUnVCmmQD42JIGCmJGZJNh+N41zWWYSRx9vWtHm59YBmwKtbQSMTOUVn5xmL3
         PXo+b6mFqT6fgC5Mv3ZT3sm3tgIgCtxwhP7CVDA4cfqlbwQHFPvLwO5RPxHw4nWMtC9j
         bR77wF4dAElIPvd3lu3bcMXu25ytnSatG3kOp06gM+hap9iDsxFOWukBHzLYxfBrM2UZ
         LFTzZ/7vZpdQXLe+X3Hff8pD/m3sv5BeDm5Ca0J5DV0kdubQLyAIObU7aXjXSHJ5UutT
         XjTyuAspTX/K+Nrs2jJLi5BiOsVf6Gx50FgWB+8YK+0a1NbML2FkPCjKfqpsQD3/9JR+
         Ukpw==
X-Gm-Message-State: AOJu0YxXf1Yxq082DnPjSY4EKrhQrF/NEMnSe1VCGEhhTwIMcapuYO8C
	GR4MgFo3IaSaUqd221NKEVlIvla7NmwWCTYbmmqYbLQUC0NVJrfa4rdTApFUVivvWGpNd6J2tMZ
	x/fIUtSxteM1GzM4Gt5LgESBCjDlEJsr3ABts+KjIQg==
X-Gm-Gg: ASbGncugSX+N6WAjtSjIP6HTocURPE5yQL7TcAGi0lWpO6bvgepin8oQGBe/Udj+Acd
	tMdriUq7AaumXyvELC1on2rvRbM6QZRCtbb40WR3IpiZ2elD86jMlCKzme3oqmMzBTFyqdghWOI
	nyn76ZR6lq5eMkXX5NYIXqYYJmCg1sUM0u4AfYFw1I0K9H2ITk0+cwEDJtEdWSKSguTNWdMo9oR
	7Ngo9FiH7KiRANBDLQvEdK6z9ZssYJKfjf/Tkp14RShIUd4PAo+mansqi6P
X-Google-Smtp-Source: AGHT+IEXt5TElzzeDxQk6jhIi0O6CoCze9GFEKIHI2MOuwfGUwhweABKgWr/yMYr+zIT72QAwZRH8WggMb4bQWYILRc=
X-Received: by 2002:a05:6512:696:b0:592:fb56:f2be with SMTP id
 2adb3069b0e04-5941d55163emr4939379e87.49.1762246368888; Tue, 04 Nov 2025
 00:52:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251028-work-coredump-signal-v1-0-ca449b7b7aa0@kernel.org> <20251028-work-coredump-signal-v1-9-ca449b7b7aa0@kernel.org>
In-Reply-To: <20251028-work-coredump-signal-v1-9-ca449b7b7aa0@kernel.org>
From: Alexander Mikhalitsyn <alexander@mihalicyn.com>
Date: Tue, 4 Nov 2025 09:52:37 +0100
X-Gm-Features: AWmQ_blKnrbsoabiuwCBaSwhOYeiHusMzgCOkxvPifg31ZhSyVcGEctWEkRCKzw
Message-ID: <CAJqdLrqf9Y-qO54Ov2m15W05X2-kZugk68Wm_4Ep2Rn6OG8Ygw@mail.gmail.com>
Subject: Re: [PATCH 09/22] selftests/pidfd: update pidfd header
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
> Include the new defines and members.
>
> Signed-off-by: Christian Brauner <brauner@kernel.org>

Reviewed-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>


> ---
>  tools/testing/selftests/pidfd/pidfd.h | 15 +++++++++++++--
>  1 file changed, 13 insertions(+), 2 deletions(-)
>
> diff --git a/tools/testing/selftests/pidfd/pidfd.h b/tools/testing/selftests/pidfd/pidfd.h
> index f87993def738..d60f10a873bb 100644
> --- a/tools/testing/selftests/pidfd/pidfd.h
> +++ b/tools/testing/selftests/pidfd/pidfd.h
> @@ -148,6 +148,14 @@
>  #define PIDFD_INFO_COREDUMP    (1UL << 4)
>  #endif
>
> +#ifndef PIDFD_INFO_SUPPORTED_MASK
> +#define PIDFD_INFO_SUPPORTED_MASK      (1UL << 5)
> +#endif
> +
> +#ifndef PIDFD_INFO_COREDUMP_SIGNAL
> +#define PIDFD_INFO_COREDUMP_SIGNAL     (1UL << 6)
> +#endif
> +
>  #ifndef PIDFD_COREDUMPED
>  #define PIDFD_COREDUMPED       (1U << 0) /* Did crash and... */
>  #endif
> @@ -183,8 +191,11 @@ struct pidfd_info {
>         __u32 fsuid;
>         __u32 fsgid;
>         __s32 exit_code;
> -       __u32 coredump_mask;
> -       __u32 __spare1;
> +       struct {
> +               __u32 coredump_mask;
> +               __u32 coredump_signal;
> +       };
> +       __u64 supported_mask;
>  };
>
>  /*
>
> --
> 2.47.3
>


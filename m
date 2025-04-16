Return-Path: <linux-fsdevel+bounces-46575-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 797FFA9085F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Apr 2025 18:10:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B04619E0A24
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Apr 2025 16:10:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A98FB211A27;
	Wed, 16 Apr 2025 16:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R0eWpkUV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FD3C211A07
	for <linux-fsdevel@vger.kernel.org>; Wed, 16 Apr 2025 16:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744819767; cv=none; b=fqTCXBJljRwfpMqcgbC90y8XuprSXHFOiggJ+odJGyqbCaooGOzHUJhqavjmIddWp1EFruhA/yZn00U2/JApf5SJs8LqDDuyktPCSQ3I3yYrxhohi88JPd47qWbM5rNuP29iX2B51Gkoa/irXp1qzaoLMKwZZkgX0uXQyENVOoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744819767; c=relaxed/simple;
	bh=rxdX+UPGu17yi7cMKMZGhHSKBDiv7BxRHJriR874jPo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uAGe2ELkCFzpB2DpiHelisHA1DmfrYFP6FpctELZrnOvXUprH1kVbseZUjIDSW+VtuV9OcFKrLo/8GuW7Sz/plQCr24gS10FN3H7qKy0LzV+OZ21oHThivivx0fMiOdJktk3Z7Z+DkqU2viKhXiAuhVNmJ4dmKWzhKzuwDwFU38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R0eWpkUV; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-30de488cf81so66856751fa.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 16 Apr 2025 09:09:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744819763; x=1745424563; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=idztSI3V7p3H0Q/ckJwJfep+KGasWkIWXQjhMU6+t7A=;
        b=R0eWpkUVywjY9MD/cpihfCYnxyzxITeduaKLP5sXZCA9iSOOGU/UrMgsOTJg+9TAPE
         GgRaHl4LTrMlWqQeZ5mcuZ4qSmG/hI1IXVZ1YAbsDycrKCDogyIhVUNJig0rHv3u7/Nm
         HRVe7z/0m2aBr62bfCk8I8gpQW+TawW92ecB+u2AjT3wvur9vZCoOmLgJ0rP6pJp3y5s
         8y/d1wmFTMiApfIWULQlt0mFa4LiXEzUVq7dhO8kC4HN7FB853kbJEyRtJ9qqrK0qnJz
         7cSyOKPUnzpUo8zre03bUXi4Ogain6meNv6zw3tIAmKLuJWvdpj4z/q6Pvw4JBnpyDUm
         HTtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744819763; x=1745424563;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=idztSI3V7p3H0Q/ckJwJfep+KGasWkIWXQjhMU6+t7A=;
        b=uiBjtdwXpH/9/zC6/CA1pdPlZiZA67R4Y9031iI+NPijEbkKpmAOQD4e+E+vv8I/B0
         HBW370LUKNPtJE3NSiqCm41qzvThh1QPq5DazsSP3SmqCF781heTbgvHVWMbleElpYKM
         HXuzfyCli9Iq+HMiLUMo3NsqhfbQmRU/5OqGFlv77vC4CcbYzCJkgWLdTqSRNBWA2IUA
         wcnAg0jBW3Q7roYtv7eTZJsHDNPubhNFp26SjanfvTchMOGM++ewosnXwWzU6HWCT4IR
         exx7UxOr3xakbZjiK0iodGblTm2crYEpfhRsbTfFFtawjRY1jJ6sDeuPBnO+UHp0chXR
         ifHQ==
X-Gm-Message-State: AOJu0Yzs6kAf47awxpNPQAYlvkfLJAHiLi0wCBxVcXZt3F9hZH5qXXPj
	QqHSy5xKuiJ9wbJ2r8HjPn5sLHah4GtOudOZciYM8Ar0NwWUhyNPIyb+GEQRpY7y2toUL9Vs4QR
	K58bSo3RkMjPUvoLYofPsYMqKSPEk/ZqY
X-Gm-Gg: ASbGncsCfRQeRxZlos0WoCex9kVSOAfcLOiWAzlmPavLX77UG/74vSGbjBJERUNyw+h
	KFYlFM8B3QJIJIEUf5xg8g3rp97GtCFg7s7CWvOELgnjriimlrF8Q/rETbgDClxCiOKkojP3T6y
	hhvSutv/qCNkgjuv1pVGhpngs4ETjl6aSliEIkMAkpW14qK79tEizs
X-Google-Smtp-Source: AGHT+IFpk9Gfkd1yr+VBxNa6VCjAurkg8PS5B8OUCIPyHdag652V1RxPGSRz7sLzqEzdEArJzEDGCReSqNO8Em3efLE=
X-Received: by 2002:a05:651c:1449:b0:30b:f775:bae5 with SMTP id
 38308e7fff4ca-3107f695229mr11492151fa.6.1744819763114; Wed, 16 Apr 2025
 09:09:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250415-dezimieren-wertpapier-9fd18a211a41@brauner>
In-Reply-To: <20250415-dezimieren-wertpapier-9fd18a211a41@brauner>
Reply-To: sedat.dilek@gmail.com
From: Sedat Dilek <sedat.dilek@gmail.com>
Date: Wed, 16 Apr 2025 18:08:46 +0200
X-Gm-Features: ATxdqUGk3HLBIzoJyRsSRvglXGlbG1RMCu3UqmEHQJMmXOgrAHgq55QQ0vO2g-8
Message-ID: <CA+icZUXWJc=E8uyKwmWmP2FCjFmRtWvYsp-YOMFxgLyJWrcdUQ@mail.gmail.com>
Subject: Re: [PATCH] Kconfig: switch CONFIG_SYSFS_SYCALL default to n
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, 
	Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 15, 2025 at 10:22=E2=80=AFAM Christian Brauner <brauner@kernel.=
org> wrote:
>
> This odd system call will be removed in the future. Let's decouple it
> from CONFIG_EXPERT and switch the default to n as a first step.
>
> Signed-off-by: Christian Brauner <brauner@kernel.org>

Typo in the subject line: Should be CONFIG_SYSFS_SY*S*CALL (missing S
in SYSCALL).

-sed@-

> ---
>  init/Kconfig | 20 ++++++++++----------
>  1 file changed, 10 insertions(+), 10 deletions(-)
>
> diff --git a/init/Kconfig b/init/Kconfig
> index dd2ea3b9a799..63f5974b9fa6 100644
> --- a/init/Kconfig
> +++ b/init/Kconfig
> @@ -1555,6 +1555,16 @@ config SYSCTL_ARCH_UNALIGN_ALLOW
>           the unaligned access emulation.
>           see arch/parisc/kernel/unaligned.c for reference
>
> +config SYSFS_SYSCALL
> +       bool "Sysfs syscall support"
> +       default n
> +       help
> +         sys_sysfs is an obsolete system call no longer supported in lib=
c.
> +         Note that disabling this option is more secure but might break
> +         compatibility with some systems.
> +
> +         If unsure say N here.
> +
>  config HAVE_PCSPKR_PLATFORM
>         bool
>
> @@ -1599,16 +1609,6 @@ config SGETMASK_SYSCALL
>
>           If unsure, leave the default option here.
>
> -config SYSFS_SYSCALL
> -       bool "Sysfs syscall support" if EXPERT
> -       default y
> -       help
> -         sys_sysfs is an obsolete system call no longer supported in lib=
c.
> -         Note that disabling this option is more secure but might break
> -         compatibility with some systems.
> -
> -         If unsure say Y here.
> -
>  config FHANDLE
>         bool "open by fhandle syscalls" if EXPERT
>         select EXPORTFS
> --
> 2.47.2
>
>


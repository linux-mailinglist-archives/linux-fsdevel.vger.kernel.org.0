Return-Path: <linux-fsdevel+bounces-10428-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AFFC84B0BB
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Feb 2024 10:06:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0A302884B6
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Feb 2024 09:05:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A02E12DD87;
	Tue,  6 Feb 2024 09:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="R5ASdkTv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E79812D74D
	for <linux-fsdevel@vger.kernel.org>; Tue,  6 Feb 2024 09:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707210265; cv=none; b=CZEeqwItdeMsooPt5FQ8H2k3CHh2wd/BtENqfubFOLJSLBF0sTx96vMBelGzUwYnU6eriHFVYB9kcgVcMfcrjcr22Sa9fRg78897Esh1kwDMlXKqdMwxyN8E2aEc3qg2fYsNoKXP8vctZQ87IPxKyUq+VXarZhp/SHdDNJWUCUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707210265; c=relaxed/simple;
	bh=Gp35uNMc518ajDUT+cimYa69HEsvONtpg4a3sm+E5kI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DgdUTeYp2RFwlvjQSgo/VVPLOCYw9n4K+XTpQDYXCHMvZo0jembPMnl0irUmCI+XmrlgEXBs4Z5Kbo4InDXzvnPlqN4v5J8vAfLCrKSSY/EOYCg+0c133GXqMH+MSTWlGAjug8y8SMPRsT7GuRQjuBbmyZRnCH8Yy1Xz6JtYVMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=R5ASdkTv; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5605c7b1f32so2327238a12.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 06 Feb 2024 01:04:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1707210260; x=1707815060; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=oT9eQF6EDyoyZsgVEyZNBHLPqezkyA6nguMaS8W3x+A=;
        b=R5ASdkTvxgylxekuA9je68pNt2bL2E6YftZlDXd4F2sZ4j2dhDuZ8RxTexiVSXlI/c
         F1+CVGN46UedV775iPAcK4YJGhxXvTVA6AxtavewWvUd5X/VmtFJA3Xib22OkcRIZsq0
         qDv8p7XDiIxg4RgqTd+L1/MPd6whNwwKSjoN1MXHkuF/ti5Gxmj14FF/ItBqamuO+oD2
         JGkxxjbj72gPT7v45Ayv7qWy5y/muPEs+5AZys93x4Pd/3doar+gSrSC4sak1L7JMi3G
         urDYjL0npZeEwJxd76qI+DqzKbKuzzwXVc0fKder3l5Dp7PDe8utJ+2U45A//5p+hVt7
         OgCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707210260; x=1707815060;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oT9eQF6EDyoyZsgVEyZNBHLPqezkyA6nguMaS8W3x+A=;
        b=UL+mLGxZV+g4/98BeIQ7cUccjzEEvRz8PPIxDAw1p66zrLnm1PxFtx2otFRbOBgsjT
         fMO80TMQIW/NIzdvoEsmI79bw6L0/e35180utFrCJcgUf3SEO4TmjTOFbtjMQaSObcDj
         teWI+yMbRRJc0xEYaXs5Asg9OrYrWyiVfgqX0xgPBWmB6iwDK56m3dl00MAHjRTovHIa
         HiJPwPZ8K7hhdWZNJ8CQ/nsCyvsuBh8KEFreBAZwoUXBPjyQc/Hzucy/FtC/O+ygMEJz
         ftPVGvrilOUJQEU2C8oBK0mgw+9Iw5ndqDFZXlJIfeNY7i94ybtvgZ4FofjxSvsyFNhg
         aSig==
X-Gm-Message-State: AOJu0YwTKjaEBf3lK3EL6fQbYKYBAQ6WBZaTWq9VwJx1Rh4VBby6qFKk
	I2+c0ZWpX8haR/Vx/yHilrfQy6j9pgWk1UeKXHyWDeHpXmQO8tByRshmP1h1mZA=
X-Google-Smtp-Source: AGHT+IHiM9uAumR+z22zTjpJ85plFmRYDxP1RdptBN/LMoDG9XbGtOvtI9Zo9Eq/Qwcb7wfE9rDM1g==
X-Received: by 2002:a17:906:7105:b0:a37:19f6:b4e7 with SMTP id x5-20020a170906710500b00a3719f6b4e7mr1410042ejj.24.1707210260659;
        Tue, 06 Feb 2024 01:04:20 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWjdEfLWTNrLTJxSl//LlhmFifLaLlKWAEvnFqcOgZ3nYQJpdSh/BWOkJBb4d1XHzLKWYFcIIRXU/WnpzE8AO8b5CpNtpHpkvLeXGwZsSnMHOmMqqpu/ZbFAEctlbG9Mj1ssHOqtg7XHJeSTlOCPnlRgIX3rh1LSF67Mc4o2q8t+rw4WtOO5cZcgwPbaZiba+bM95zsK7TNNtwesWt5Mh0c4Glf7hGxwUk7+Tma8zq+IHJ6VJtb/mmjAclwRs+2DvnYrF5Wz+CUvBPenGN7QMmjzXHZrSxQkUs2226VtpmAAK+YkUysmvqdkAGBRZQOL5S+oz0FBiZ0fSFUTJkJSji1fVKfd3Z85JKJVmQv7fz4672vQdLsSCwS82/iYCzZ+jXqesZVMnnGgWeir8W6BhmcvxXhXLNcTbyExmhEeBtH58wHU/RRCio8hKhGVZESWOHwu13zFZrcPILDgdmJEWoryvO5G+zT7Q/qBiyOnHu30G/J1LonCLCo43b/cTncTgfvxSUnCEnYTeySSwlTzoaPXw+aRByfJh4M7Knqnn0aPwmNmdSzM+KFTW72QJzpKCsbxDRtZ8T6lw4jzrHd8CNE5Vma1CaA/3PVW9riG0TOYp6tpcE8zXpxJvwd8tWOPmQIN+8mXRcbLZGlCdVc/g4AXGan/3SnnlTH4kDTeeqqzmgbB5unmLTwM+fzahS5OH8jXF87900B34PFw+QwPvdOBsV8+rBrgE4Cn869eAj25FNm27N/64JXtAvfjtLbqm316h2G
Received: from alley ([176.114.240.50])
        by smtp.gmail.com with ESMTPSA id d23-20020a1709061f5700b00a377ac3730esm897261ejk.2.2024.02.06.01.04.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Feb 2024 01:04:20 -0800 (PST)
Date: Tue, 6 Feb 2024 10:04:18 +0100
From: Petr Mladek <pmladek@suse.com>
To: Yoann Congal <yoann.congal@smile.fr>
Cc: linux-fsdevel@vger.kernel.org, linux-kbuild@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
	x86@kernel.org,
	=?iso-8859-1?Q?Andr=E9?= Almeida <andrealmeid@igalia.com>,
	Borislav Petkov <bp@alien8.de>, Darren Hart <dvhart@infradead.org>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"H . Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
	Jiri Slaby <jirislaby@kernel.org>,
	John Ogness <john.ogness@linutronix.de>,
	Josh Triplett <josh@joshtriplett.org>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Matthew Wilcox <willy@infradead.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Subject: Re: [PATCH v4 3/3] printk: Remove redundant CONFIG_BASE_FULL
Message-ID: <ZcH2ElZd4BaySeGV@alley>
References: <20240206001333.1710070-1-yoann.congal@smile.fr>
 <20240206001333.1710070-4-yoann.congal@smile.fr>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240206001333.1710070-4-yoann.congal@smile.fr>

On Tue 2024-02-06 01:13:33, Yoann Congal wrote:
> CONFIG_BASE_FULL is equivalent to !CONFIG_BASE_SMALL and is enabled by
> default: CONFIG_BASE_SMALL is the special case to take care of.
> So, remove CONFIG_BASE_FULL and move the config choice to
> CONFIG_BASE_SMALL (which defaults to 'n')
> 
> Signed-off-by: Yoann Congal <yoann.congal@smile.fr>

This might also require updatating the default config files which
unset CONFIG_BASE_FULL. I mean:

$> git grep BASE_FULL arch/
arch/arm/configs/collie_defconfig:# CONFIG_BASE_FULL is not set
arch/arm/configs/keystone_defconfig:# CONFIG_BASE_FULL is not set
arch/arm/configs/lpc18xx_defconfig:# CONFIG_BASE_FULL is not set
arch/arm/configs/moxart_defconfig:# CONFIG_BASE_FULL is not set
arch/arm/configs/mps2_defconfig:# CONFIG_BASE_FULL is not set
arch/arm/configs/omap1_defconfig:# CONFIG_BASE_FULL is not set
arch/arm/configs/stm32_defconfig:# CONFIG_BASE_FULL is not set
arch/microblaze/configs/mmu_defconfig:# CONFIG_BASE_FULL is not set
arch/mips/configs/rs90_defconfig:# CONFIG_BASE_FULL is not set
arch/powerpc/configs/adder875_defconfig:# CONFIG_BASE_FULL is not set
arch/powerpc/configs/ep88xc_defconfig:# CONFIG_BASE_FULL is not set
arch/powerpc/configs/mpc866_ads_defconfig:# CONFIG_BASE_FULL is not set
arch/powerpc/configs/mpc885_ads_defconfig:# CONFIG_BASE_FULL is not set
arch/powerpc/configs/tqm8xx_defconfig:# CONFIG_BASE_FULL is not set
arch/riscv/configs/nommu_k210_defconfig:# CONFIG_BASE_FULL is not set
arch/riscv/configs/nommu_k210_sdcard_defconfig:# CONFIG_BASE_FULL is not set
arch/riscv/configs/nommu_virt_defconfig:# CONFIG_BASE_FULL is not set
arch/sh/configs/edosk7705_defconfig:# CONFIG_BASE_FULL is not set
arch/sh/configs/se7619_defconfig:# CONFIG_BASE_FULL is not set
arch/sh/configs/se7712_defconfig:# CONFIG_BASE_FULL is not set
arch/sh/configs/se7721_defconfig:# CONFIG_BASE_FULL is not set
arch/sh/configs/shmin_defconfig:# CONFIG_BASE_FULL is not set

Best Regards,
Petr


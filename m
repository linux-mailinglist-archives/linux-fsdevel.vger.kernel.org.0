Return-Path: <linux-fsdevel+bounces-40226-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 564A2A20A9D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Jan 2025 13:33:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AEBAB3A7251
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Jan 2025 12:33:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A6E21A2642;
	Tue, 28 Jan 2025 12:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Mvc3vW/h"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 312A818E750
	for <linux-fsdevel@vger.kernel.org>; Tue, 28 Jan 2025 12:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738067602; cv=none; b=lOoubWdtyjfzjulvpDhvyH9kchBID6XB0J88Q8uiIIfDPd/FzDrPEzmDOQVTmX5UNY5sSHpD1fPCw4FuoTuufK5b0o5GTlkkXYcysoQ7MqceYrMvHHNHuH8QsfFKyAsdEUlbet/Tgxr30KaG76/xeJeuVtt5dnVj5bPAA0veyHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738067602; c=relaxed/simple;
	bh=UeV+qmglEQODS8xK2P0BHKe5glqL6zf+/MUL5A3QfLU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IDwgU6oAbonzuPlgfsO6dhfX8K0tf1xYmH3jkiuXEb9q3/GO44zwH5+2Uc+mnruGFEX/dG0iTXpj2cCXE3omWR1+35a++RMoRQMN/P31X4er7BioNMNY5MuKOLDE6I6bGNXKXTfRZ5D6dQJpkZsVFIPcN9xpT8vLWot4cwGB+MM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Mvc3vW/h; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-385de59c1a0so3148322f8f.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Jan 2025 04:33:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1738067598; x=1738672398; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SaxXlr7JRW0jN1vZqbO+0wpauA50DxpP5DF46ktNdPA=;
        b=Mvc3vW/hfpwSYBXdJ9Hijpz7qF9GH/Gz/ExVvEUeUjnqTvAA2TEa3FxsWnDxUqC9/G
         Fv6M8HhH/JJDn6i6pXKK5p61684WLleXG8Rg0JWO26YP9D6yZnf3/ymSnLNhPWUWxlS5
         8UrhQ+DBJNXfE9yWPjSzotT5x2ULcTilHlBVEmuI1+n9TqJmVuQChZ0ReT8hdjmX3FMN
         S015mGBgnud5k3ctkVTWmzKb+AI7DsfhJ51/rYjxME9V8W3KmULf9ndZbGwG6jPx7JV5
         JWyGgETUoNi1U5M+S9rMs0kB8CZ3d33ugFVrHqFMcbOcp8AJyNK3J9HMn/IZoGfTl3pf
         hvtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738067598; x=1738672398;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SaxXlr7JRW0jN1vZqbO+0wpauA50DxpP5DF46ktNdPA=;
        b=H+sGCpHVwCpQ4qHkGUP20cnIuGc29ywrVX67LhmnJlzr6+KRDM8nJx17A/roCaZl6i
         A45KoPNyS0OUUVi46MdtuNd/8AG/VH7iB7cg9uDCf45c/1KxsA956Tj+s8FhGXCMfwfv
         UZycGcB8leEhdIso0wV+jSC/NFlq9x8M7nqVOOs6r7PpcrXDwFdgGCG1LgzG5JA80I4f
         2oUIZVQTv1YUKyWJrqXqSWBv+449AGQj6qxspleblkjnpTJf5hQKR8I5Ogf0wjXAG2di
         LzUP2pIP1LBtJMCkDLmwTaNJOrr4nb133ZZ2rilFCxddM43k0DT4orfwnx9/J13x5+/7
         bN3w==
X-Forwarded-Encrypted: i=1; AJvYcCV9r/OdnHLV1ALJWV0M385ws4H+n9wPSmPJiJY56r6XxK8FbuUSj6fdNkixnG1yxXupejDt9xIVUGTbDDlj@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/6yX4WTwaFf2GK0890esnRl2FuP0CrwHmmyg5Jx+MLx3JdxLu
	I/3oZu9t8yQglsRKuOnaXeHnDn8ERPxCZHN+cV2fq7tsXKABBgy/phbxK9Ua/To=
X-Gm-Gg: ASbGncvE7WoMuEDFNWahsNaP9pp9gXRE4ittfV7MAYkE0SOMQJSd1wA7B5ivR41VFkP
	H0YN3xU+V0ejkckofL0HwM9V7uLkigfUYxiUyLJ3Q6LqPkwKShtt30fkW1ZxRgxiuy9c1e2u/mK
	Vr7iJ4v0x3Fc6DNKL/2zrRCrgRTzEdUb/LTiwulTa+C9uz/Pe33qvpTnPwU2rs4sE3xsHrH1Y05
	DrHdVDCxa3ZN1g5oFZnMmx88mAMDFX15a/Fv3qWD5Aex0IxW7NHx+qrSl5LMhIRZ7w9wst7KX4i
	Z/WPbx1v/GekypKxVXzD
X-Google-Smtp-Source: AGHT+IGTjX2lgddlGfDG+Nf9ahpSkkS+kb4WmJBNdZKk20gINg6VWYaHuLdaH0Zbv47E9dr/Gzf9sA==
X-Received: by 2002:a5d:64e4:0:b0:386:3864:5cf2 with SMTP id ffacd0b85a97d-38bf56633cdmr38729880f8f.19.1738067598441;
        Tue, 28 Jan 2025 04:33:18 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38c2a17650esm14102499f8f.12.2025.01.28.04.33.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jan 2025 04:33:17 -0800 (PST)
Date: Tue, 28 Jan 2025 15:33:14 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Sasha Levin <sashal@kernel.org>
Cc: Mark Brown <broonie@kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	kernelci@lists.linux.dev, Al Viro <viro@zeniv.linux.org.uk>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	lkft@linaro.org
Subject: Re: [git pull] d_revalidate pile
Message-ID: <6400eae4-1382-450d-a7b8-66f9e9a61021@stanley.mountain>
References: <20250127044721.GD1977892@ZenIV>
 <Z5fAOpnFoXMgpCWb@lappy>
 <CAHk-=wh=PVSpnca89fb+G6ZDBefbzbwFs+CG23+WGFpMyOHkiw@mail.gmail.com>
 <804bea31-973e-40b6-974a-0d7c6e16ac29@sirena.org.uk>
 <Z5gJcnAPTXMoKwEr@lappy>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z5gJcnAPTXMoKwEr@lappy>

On Mon, Jan 27, 2025 at 05:32:18PM -0500, Sasha Levin wrote:
> [ Adding in the LKFT folks ]

Ugh...  The website is pretty difficult to navigate.  I've filed a
ticket to hopefully avoid this going forward.  It's a bit late for
the line numbers to be any use but here they are:

Debian GNU/Linux comes with ABSOLUTELY NO WARRANTY, to the extent
permitted by applicable law.
<3>[   62.179009] ==================================================================
<3>[ 62.180289] BUG: KFENCE: out-of-bounds read in d_same_name (include/asm-generic/rwonce.h:86 fs/dcache.c:243 fs/dcache.c:295 fs/dcache.c:2129)
<3>[   62.180289]
<3>[   62.182647] Out-of-bounds read at 0x00000000eedd4b55 (64B right of kfence-#174):
<4>[ 62.184178] d_same_name (include/asm-generic/rwonce.h:86 fs/dcache.c:243 fs/dcache.c:295 fs/dcache.c:2129)
<4>[ 62.184717] d_lookup (fs/dcache.c:2292)
<4>[ 62.185378] lookup_dcache (fs/namei.c:1654)
<4>[ 62.185980] lookup_one_qstr_excl (fs/namei.c:1678)
<4>[ 62.186523] do_renameat2 (fs/namei.c:5167)
<4>[ 62.186948] __arm64_sys_renameat (fs/namei.c:5264)
<4>[ 62.187484] invoke_syscall (arch/arm64/include/asm/current.h:19 arch/arm64/kernel/syscall.c:54)
<4>[ 62.188220] el0_svc_common.constprop.0 (include/linux/thread_info.h:135 (discriminator 2) arch/arm64/kernel/syscall.c:140 (discriminator 2))
<4>[ 62.189031] do_el0_svc_compat (arch/arm64/kernel/syscall.c:159)
<4>[ 62.189635] el0_svc_compat (arch/arm64/include/asm/irqflags.h:82 (discriminator 1) arch/arm64/include/asm/irqflags.h:123 (discriminator 1) arch/arm64/include/asm/irqflags.h:136 (discriminator 1) arch/arm64/kernel/entry-common.c:165 (discriminator 1) arch/arm64/kernel/entry-common.c:178 (discriminator 1) arch/arm64/kernel/entry-common.c:888 (discriminator 1))
<4>[ 62.190018] el0t_32_sync_handler (arch/arm64/kernel/entry-common.c:933)
<4>[ 62.190537] el0t_32_sync (arch/arm64/kernel/entry.S:605)
<3>[   62.190946]
<4>[   62.191399] kfence-#174: 0x0000000012d508d5-0x0000000023355f7e, size=64, cache=kmalloc-rcl-64
<4>[   62.191399]
<4>[   62.192260] allocated by task 1 on cpu 0 at 62.177313s (0.014839s ago):
<4>[ 62.193504] __d_alloc (fs/dcache.c:1678)
<4>[ 62.193925] d_alloc (fs/dcache.c:1737)
<4>[ 62.194204] lookup_one_qstr_excl (fs/namei.c:1689)
<4>[ 62.194741] filename_create (fs/namei.c:4083)
<4>[ 62.195129] do_symlinkat (fs/namei.c:4690)
<4>[ 62.195657] __arm64_sys_symlinkat (fs/namei.c:4710)
<4>[ 62.195954] invoke_syscall (arch/arm64/include/asm/current.h:19 arch/arm64/kernel/syscall.c:54)
<4>[ 62.196461] el0_svc_common.constprop.0 (include/linux/thread_info.h:135 (discriminator 2) arch/arm64/kernel/syscall.c:140 (discriminator 2))
<4>[ 62.197053] do_el0_svc_compat (arch/arm64/kernel/syscall.c:159)
<4>[ 62.197411] el0_svc_compat (arch/arm64/include/asm/irqflags.h:82 (discriminator 1) arch/arm64/include/asm/irqflags.h:123 (discriminator 1) arch/arm64/include/asm/irqflags.h:136 (discriminator 1) arch/arm64/kernel/entry-common.c:165 (discriminator 1) arch/arm64/kernel/entry-common.c:178 (discriminator 1) arch/arm64/kernel/entry-common.c:888 (discriminator 1))
<4>[ 62.197849] el0t_32_sync_handler (arch/arm64/kernel/entry-common.c:933)
<4>[ 62.198422] el0t_32_sync (arch/arm64/kernel/entry.S:605)
<3>[   62.198857]
<3>[   62.199577] CPU: 0 UID: 0 PID: 1 Comm: systemd Not tainted 6.13.0 #1
<3>[   62.200435] Hardware name: linux,dummy-virt (DT)
<3>[   62.201130] ==================================================================
[?2004hroot@runner-vwmj3eza-project-40964107-concurrent-3:~#

regards,
dan carpenter



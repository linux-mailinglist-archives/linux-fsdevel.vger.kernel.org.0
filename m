Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1BED9170ABD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Feb 2020 22:45:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727700AbgBZVpD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 26 Feb 2020 16:45:03 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:39028 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727550AbgBZVpC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 26 Feb 2020 16:45:02 -0500
Received: by mail-pg1-f193.google.com with SMTP id j15so303769pgm.6
        for <linux-fsdevel@vger.kernel.org>; Wed, 26 Feb 2020 13:45:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=LEOG45oBzsk4VkXLaube4iedb24/mnkHl/uPB4eNLko=;
        b=S7QwoillPymvmUXhSvQ9XeY6dt1lsnuG9Gixb/80AnLRzal3BKqeXehLhN8GeIopi7
         mHIWOeTf7r00dNMZbOY0wy/VeWQM2D1PWjaWm6VqnRhDTJ5RtWMC6V4WiBuONgAurgwS
         e6aKokF7WWW6DX6t/rtidzSu6L5+xiuBi/ihA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=LEOG45oBzsk4VkXLaube4iedb24/mnkHl/uPB4eNLko=;
        b=B0qpPSkCyysBbsGxPEUrKskuTVsHRD6Y2Nh6t56CCHno9hq/nOzLJ1c1cbxyHZioEl
         WD/UXNe/Pdo/TZrW8p9onGfleePGlAK1C+tPlCzdKuLBbObU1Ud+ipx3OeFmYsdzMvCv
         8IHNjMcENjap4jd/HDsyco51u4LzO24uXaaSriiSqm/CD6LIM6qr65bBA4Yvq4TBOAXq
         kC0/d5WlINVUGGuPKyb1q13i3bp8MeOEqWONdD3bPHWnNEF9guuUq3Ry/yU1DgvWX3Hn
         8SKEUebCxYGReHidWLcoKP0KqrMhoSQXOYk6MlrEwMLprIPMMEB02MjfgfYvl89mYbTe
         YkvQ==
X-Gm-Message-State: APjAAAUEMbv7uOPQUa/nLBFfsL21YwPDC2RjEqh8bjBOTfXULsqHcYyp
        3uv9x0FGr9JJpeMPDXrQ8/rilg==
X-Google-Smtp-Source: APXvYqzAYJxED0DZuNTQH/pPVYk94YN0FwPubJNZYwjzdTSrs2Ri1O5oY0aDkBqS9krAjOJx6fGojA==
X-Received: by 2002:a63:3004:: with SMTP id w4mr854365pgw.164.1582753500965;
        Wed, 26 Feb 2020 13:45:00 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id z16sm4066910pff.125.2020.02.26.13.44.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2020 13:45:00 -0800 (PST)
Date:   Wed, 26 Feb 2020 13:44:59 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Paul Elliott <paul.elliott@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Yu-cheng Yu <yu-cheng.yu@intel.com>,
        Amit Kachhap <amit.kachhap@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Eugene Syromiatnikov <esyr@redhat.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        "H . J . Lu " <hjl.tools@gmail.com>,
        Andrew Jones <drjones@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>, Jann Horn <jannh@google.com>,
        Richard Henderson <richard.henderson@linaro.org>,
        Kristina =?utf-8?Q?Mart=C5=A1enko?= <kristina.martsenko@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Florian Weimer <fweimer@redhat.com>,
        Sudakshina Das <sudi.das@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v7 00/11] arm64: Branch Target Identification support
Message-ID: <202002261343.3B2ECE90@keescook>
References: <20200226155714.43937-1-broonie@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200226155714.43937-1-broonie@kernel.org>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Feb 26, 2020 at 03:57:03PM +0000, Mark Brown wrote:
> This patch series implements support for ARMv8.5-A Branch Target
> Identification (BTI), which is a control flow integrity protection
> feature introduced as part of the ARMv8.5-A extensions.
> 
> Changes:
> 
> v7:
>  - Rebase onto v5.6-rc3.
>  - Move comment about keeping NT_GNU_PROPERTY_TYPE_0 internal into first
>    patch.
>  - Add an explicit check for system_supports_bti() when parsing BTI ELF
>    property for improved robustness.

Looks good. I sent a few more Reviewed-bys where I could. Who is
expected to pick this up? Catalin? Will?

I'm excited to have both the ELF parser and BTI landed. :)

-Kees

-- 
Kees Cook

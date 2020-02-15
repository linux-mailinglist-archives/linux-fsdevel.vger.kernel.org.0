Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C04A415FE43
	for <lists+linux-fsdevel@lfdr.de>; Sat, 15 Feb 2020 12:56:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726137AbgBOL42 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 15 Feb 2020 06:56:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:42718 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725965AbgBOL42 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 15 Feb 2020 06:56:28 -0500
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F105E2072D;
        Sat, 15 Feb 2020 11:56:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581767788;
        bh=NaAHvFuU+ylYPII07/Q0dVeLaamkxwl2owLhdZmF30s=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=c/I4lBS0EkFioir+ydtfPPjtntwsQIPJ7gsuAA3lo46+qwOcC4aMnOKMd0Z3INdXb
         +XXx9hsOBFemgKcDam3c13z6zdZPka+UYQI4oclDwsHzdHpDY/hsKWrKryaYlalWJW
         y8S7mdF0AnUzkD5yhE5BODnxSJSI/dNdTVzG8774=
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78] helo=why)
        by disco-boy.misterjones.org with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <maz@kernel.org>)
        id 1j2w3e-005RK7-1L; Sat, 15 Feb 2020 11:56:26 +0000
Date:   Sat, 15 Feb 2020 11:56:24 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Paul Elliott <paul.elliott@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Yu-cheng Yu <yu-cheng.yu@intel.com>,
        Amit Kachhap <amit.kachhap@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Eugene Syromiatnikov <esyr@redhat.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        "H . J . Lu " <hjl.tools@gmail.com>,
        Andrew Jones <drjones@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Arnd Bergmann <arnd@arndb.de>, Jann Horn <jannh@google.com>,
        Richard Henderson <richard.henderson@linaro.org>,
        Kristina =?UTF-8?Q?Mart=C5=A1enko?= <kristina.martsenko@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Florian Weimer <fweimer@redhat.com>,
        Sudakshina Das <sudi.das@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Dave Martin <Dave.Martin@arm.com>
Subject: Re: [PATCH v6 10/11] KVM: arm64: BTI: Reset BTYPE when skipping
 emulated instructions
Message-ID: <20200215115624.2afbf55c@why>
In-Reply-To: <20200212192906.53366-11-broonie@kernel.org>
References: <20200212192906.53366-1-broonie@kernel.org>
        <20200212192906.53366-11-broonie@kernel.org>
Organization: Approximate
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 62.31.163.78
X-SA-Exim-Rcpt-To: broonie@kernel.org, catalin.marinas@arm.com, will@kernel.org, viro@zeniv.linux.org.uk, paul.elliott@arm.com, peterz@infradead.org, yu-cheng.yu@intel.com, amit.kachhap@arm.com, vincenzo.frascino@arm.com, esyr@redhat.com, szabolcs.nagy@arm.com, hjl.tools@gmail.com, drjones@redhat.com, keescook@chromium.org, arnd@arndb.de, jannh@google.com, richard.henderson@linaro.org, kristina.martsenko@arm.com, tglx@linutronix.de, fweimer@redhat.com, sudi.das@arm.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-fsdevel@vger.kernel.org, Dave.Martin@arm.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 12 Feb 2020 19:29:05 +0000
Mark Brown <broonie@kernel.org> wrote:

> From: Dave Martin <Dave.Martin@arm.com>
> 
> Since normal execution of any non-branch instruction resets the
> PSTATE BTYPE field to 0, so do the same thing when emulating a
> trapped instruction.
> 
> Branches don't trap directly, so we should never need to assign a
> non-zero value to BTYPE here.
> 
> Signed-off-by: Dave Martin <Dave.Martin@arm.com>
> Signed-off-by: Mark Brown <broonie@kernel.org>

Acked-by: Marc Zyngier <maz@kernel.org>

	M.
-- 
Jazz is not dead. It just smells funny...

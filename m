Return-Path: <linux-fsdevel+bounces-31708-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D0FB399A441
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Oct 2024 14:55:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0CEDD1C2242C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Oct 2024 12:55:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63A882185A5;
	Fri, 11 Oct 2024 12:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bxKmURlS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A742B20C470;
	Fri, 11 Oct 2024 12:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728651310; cv=none; b=fm98Vx8jMG2Z/Bt48hnrblqCPKviquIf16i+i2fNOFIGlHb2Jg3ATEtnq99g8HszjvqU9zRDGvCZiTKn9Q3cwcv2oXwpTLcfGZ+uOIMBDKtO11SsRtaRGc3Vit3IEjEp38Of17ToWOsJMRqNFgZKb0UcnWKQXMRPJravzDhp5jA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728651310; c=relaxed/simple;
	bh=XT4qnBUKa3a1vSK5tJQUDSalL8lZA3BStEeYDOxhiyE=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ohacbR7obUGqNy7eq8xZqvx0i0jxu6Cpg+sAHjmUjU6yFfJQu7ZqAxqv2xWhbiNKjaWGFK08VmrIDUUxwOElkQgiPW/y1N3tubJqTCbSqBdVBGZx4sW+EpmLFKqKncYBelaGXKIpU6x7zurY+gXRrNUtcBj3h8F6sFj8tdmeavI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bxKmURlS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 253F4C4CEC3;
	Fri, 11 Oct 2024 12:55:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728651310;
	bh=XT4qnBUKa3a1vSK5tJQUDSalL8lZA3BStEeYDOxhiyE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=bxKmURlSi26SJe+QK4PGRX/Ogihvq7QIVMr0xUkNhvMtAINqZYYntZBEmNvBhXPzx
	 xaQCgdyiANh8t3XzU1lUElo5+68IFooOi7w967UeZ4uBwr6loXlVb5zk3DL1pKqXt6
	 HBAY4AsSFxH7PoAyDc6zDcqNdJdwwUxb24R7cB1INpTJWpCOEqUw6OP69pfvqNeZbC
	 Vp88tRv635qLdAkY5kchac2l6VKVhUPnICZg2BkQ2S5Mw0CUWfwf+IM4MLzHLqZKMT
	 pfBsODaZQhvykSctTNHB5AQS0tLN6OjiebakwN3EDPLMXixs4xCDyUOUGpJp+oxxoE
	 dWSEZjuQ+PXGA==
Received: from sofa.misterjones.org ([185.219.108.64] helo=goblin-girl.misterjones.org)
	by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <maz@kernel.org>)
	id 1szFAg-002Y12-L7;
	Fri, 11 Oct 2024 13:55:06 +0100
Date: Fri, 11 Oct 2024 13:55:05 +0100
Message-ID: <86h69i6bpy.wl-maz@kernel.org>
From: Marc Zyngier <maz@kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: Nathan Chancellor <nathan@kernel.org>,
	Mark Brown <broonie@kernel.org>,
	Will Deacon <will@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Andrew Morton <akpm@linux-foundation.org>,
	Oliver Upton <oliver.upton@linux.dev>,
	James Morse <james.morse@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Oleg Nesterov <oleg@redhat.com>,
	Eric Biederman <ebiederm@xmission.com>,
	Shuah Khan <shuah@kernel.org>,
	"Rick P. Edgecombe" <rick.p.edgecombe@intel.com>,
	Deepak Gupta <debug@rivosinc.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Szabolcs Nagy <Szabolcs.Nagy@arm.com>,
	Kees Cook <kees@kernel.org>,
	"H.J. Lu" <hjl.tools@gmail.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Florian Weimer <fweimer@redhat.com>,
	Christian Brauner <brauner@kernel.org>,
	Thiago Jung Bauermann <thiago.bauermann@linaro.org>,
	Ross Burton <ross.burton@arm.com>,
	David Spickett <david.spickett@arm.com>,
	Yury Khrustalev <yury.khrustalev@arm.com>,
	Wilco Dijkstra <wilco.dijkstra@arm.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-doc@vger.kernel.org,
	kvmarm@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-arch@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: Re: [PATCH v13 11/40] arm64/gcs: Provide basic EL2 setup to allow GCS usage at EL0 and EL1
In-Reply-To: <ZwgMBAhR5-5R5EYC@arm.com>
References: <20241001-arm64-gcs-v13-0-222b78d87eee@kernel.org>
	<20241001-arm64-gcs-v13-11-222b78d87eee@kernel.org>
	<20241009204903.GA3353168@thelio-3990X>
	<86msjc56mi.wl-maz@kernel.org>
	<ZwgMBAhR5-5R5EYC@arm.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) SEMI-EPG/1.14.7 (Harue)
 FLIM-LB/1.14.9 (=?UTF-8?B?R29qxY0=?=) APEL-LB/10.8 EasyPG/1.0.0 Emacs/29.4
 (aarch64-unknown-linux-gnu) MULE/6.0 (HANACHIRUSATO)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: catalin.marinas@arm.com, nathan@kernel.org, broonie@kernel.org, will@kernel.org, corbet@lwn.net, akpm@linux-foundation.org, oliver.upton@linux.dev, james.morse@arm.com, suzuki.poulose@arm.com, arnd@arndb.de, oleg@redhat.com, ebiederm@xmission.com, shuah@kernel.org, rick.p.edgecombe@intel.com, debug@rivosinc.com, ardb@kernel.org, Szabolcs.Nagy@arm.com, kees@kernel.org, hjl.tools@gmail.com, paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu, fweimer@redhat.com, brauner@kernel.org, thiago.bauermann@linaro.org, ross.burton@arm.com, david.spickett@arm.com, yury.khrustalev@arm.com, wilco.dijkstra@arm.com, linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org, kvmarm@lists.linux.dev, linux-fsdevel@vger.kernel.org, linux-arch@vger.kernel.org, linux-mm@kvack.org, linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false

On Thu, 10 Oct 2024 18:16:52 +0100,
Catalin Marinas <catalin.marinas@arm.com> wrote:
> 
> On Thu, Oct 10, 2024 at 04:18:13PM +0100, Marc Zyngier wrote:
> > From 20c98d2647c11db1e40768f92c5998ff5d764a3a Mon Sep 17 00:00:00 2001
> > From: Marc Zyngier <maz@kernel.org>
> > Date: Thu, 10 Oct 2024 16:13:26 +0100
> > Subject: [PATCH] KVM: arm64: Shave a few bytes from the EL2 idmap code
> > 
> > Our idmap is becoming too big, to the point where it doesn't fit in
> > a 4kB page anymore.
> > 
> > There are some low-hanging fruits though, such as the el2_init_state
> > horror that is expanded 3 times in the kernel. Let's at least limit
> > ourselves to two copies, which makes the kernel link again.
> > 
> > At some point, we'll have to have a better way of doing this.
> > 
> > Reported-by: Nathan Chancellor <nathan@kernel.org>
> > Signed-off-by: Marc Zyngier <maz@kernel.org>
> > Link: https://lore.kernel.org/r/20241009204903.GA3353168@thelio-3990X
> 
> Thanks Marc for the quick fix. It looks fine to me, it will keep the
> linker quiet for a while. I pushed it to arm64 for-kernelci for the time
> being, see if anything falls apart. I'll apply it properly once it gets
> a bit more testing.

Works for me. Bu if that helps, I can also queue it as a KVM fix for
6.12, leaving the GCS branch unencumbered. Just let me know.

	M.

-- 
Without deviation from the norm, progress is not possible.


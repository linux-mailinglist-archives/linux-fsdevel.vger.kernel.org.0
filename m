Return-Path: <linux-fsdevel+bounces-28438-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2963496A434
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Sep 2024 18:24:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C66971F2284F
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Sep 2024 16:24:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0B6318BBB0;
	Tue,  3 Sep 2024 16:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sg6V9ryn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05E45189915;
	Tue,  3 Sep 2024 16:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725380668; cv=none; b=RMOik9t6nvzYmQ5ecYnwkwsl227r+XKEn+0Ju3Ub7N2IFJIdEDaXUbs1PY5HKw9W1IHXnYLeHJauOK5sFNX5YWLQ6JvU2H1cRwwKjB7sYVx/K5JIWpxAomN7MqKYEkvp25EsYo2aIk8AvzcBEc/nwIIk7niRNe26X2143OYGSUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725380668; c=relaxed/simple;
	bh=9iVOVu/9OW9hC1XMij8LOQYkL6JBtfZqflc0EqcwKzo=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Oqn5NFMxffPzhtBIVrX4upX+ZE+41rXbwig8fXFid4L8i6/yKUH4zk70VSA5AKsXWqVxq4Yd3B977G9MAQieBFCEwi+oxmcor4ru4jmduO4jE1TePzasUamUO+eX6qj2ysLO6hx9bKM9WvFtP9XMWR7q+zOstqpPI2NssRADbPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Sg6V9ryn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66625C4CEC4;
	Tue,  3 Sep 2024 16:24:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725380667;
	bh=9iVOVu/9OW9hC1XMij8LOQYkL6JBtfZqflc0EqcwKzo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Sg6V9rynIO66aMzDEBdKiQ0PGMnzTSeEnWtbuUwm1PMyXSw6Eb5HLrr+fSzCLg5VS
	 RpTpcLZdH0/HhnyFmkx7TdZyKyFyZyb2qNdRz3JhkQrXjbDjTft5YAHYZX93CBNlS7
	 CJlI1eqDSRpSThx4MCtKO9jqYyuli7Keqv5WG70qcjiQ5cCbYfJf5Lv8ERlynMtaid
	 lzVOPLg/KQ+9XmZQmpdlE39b4X7g4bqYuZVHPFpOgmTf1jNIgR/+ZnL/1E+0kWG8+i
	 iua2ccNDnbGg78bfE4O5uA36r5FQCvCw5QYJDz5l7ZWpbwBbCiVV9kck1fdcGNeMcK
	 dTaJAroCrhjDg==
Received: from sofa.misterjones.org ([185.219.108.64] helo=goblin-girl.misterjones.org)
	by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <maz@kernel.org>)
	id 1slWKP-009J5x-7F;
	Tue, 03 Sep 2024 17:24:25 +0100
Date: Tue, 03 Sep 2024 17:24:24 +0100
Message-ID: <86r0a0vh6v.wl-maz@kernel.org>
From: Marc Zyngier <maz@kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>,	Will Deacon <will@kernel.org>, Mark Brown <broonie@kernel.org>
Cc:	Jonathan Corbet <corbet@lwn.net>,
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
Subject: Re: [PATCH v12 15/39] KVM: arm64: Manage GCS access and registers for guests
In-Reply-To: <20240829-arm64-gcs-v12-15-42fec947436a@kernel.org>
References: <20240829-arm64-gcs-v12-0-42fec947436a@kernel.org>
	<20240829-arm64-gcs-v12-15-42fec947436a@kernel.org>
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
X-SA-Exim-Rcpt-To: catalin.marinas@arm.com, will@kernel.org, broonie@kernel.org, corbet@lwn.net, akpm@linux-foundation.org, oliver.upton@linux.dev, james.morse@arm.com, suzuki.poulose@arm.com, arnd@arndb.de, oleg@redhat.com, ebiederm@xmission.com, shuah@kernel.org, rick.p.edgecombe@intel.com, debug@rivosinc.com, ardb@kernel.org, Szabolcs.Nagy@arm.com, kees@kernel.org, hjl.tools@gmail.com, paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu, fweimer@redhat.com, brauner@kernel.org, thiago.bauermann@linaro.org, ross.burton@arm.com, yury.khrustalev@arm.com, wilco.dijkstra@arm.com, linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org, kvmarm@lists.linux.dev, linux-fsdevel@vger.kernel.org, linux-arch@vger.kernel.org, linux-mm@kvack.org, linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false

On Thu, 29 Aug 2024 00:27:31 +0100,
Mark Brown <broonie@kernel.org> wrote:
> 
> GCS introduces a number of system registers for EL1 and EL0, on systems
> with GCS we need to context switch them and expose them to VMMs to allow
> guests to use GCS.
> 
> In order to allow guests to use GCS we also need to configure
> HCRX_EL2.GCSEn, if this is not set GCS instructions will be noops and
> CHKFEAT will report GCS as disabled.  Also enable fine grained traps for
> access to the GCS registers by guests which do not have the feature
> enabled.
> 
> In order to allow userspace to control availability of the feature to
> guests we enable writability for only ID_AA64PFR1_EL1.GCS, this is a
> deliberately conservative choice to avoid errors due to oversights.
> Further fields should be made writable in future.
> 
> Reviewed-by: Thiago Jung Bauermann <thiago.bauermann@linaro.org>
> Signed-off-by: Mark Brown <broonie@kernel.org>
> ---
>  arch/arm64/include/asm/kvm_host.h          | 12 ++++++++
>  arch/arm64/include/asm/vncr_mapping.h      |  2 ++
>  arch/arm64/kvm/hyp/include/hyp/sysreg-sr.h | 49 ++++++++++++++++++++++++------
>  arch/arm64/kvm/sys_regs.c                  | 27 +++++++++++++++-
>  4 files changed, 79 insertions(+), 11 deletions(-)

FWIW, this patch is going to conflict badly with -next, because of the
"conservative" approach to dealing with ID_AA64PFR1_EL1 (thankfully,
the *progressive* approach has been merged).

If it gets stuck on a branch together with patch #11 (which seems to
be the minimum for things to compile), I can take it independently and
fix it myself. Just let me know.

Thanks,

	M.

-- 
Without deviation from the norm, progress is not possible.


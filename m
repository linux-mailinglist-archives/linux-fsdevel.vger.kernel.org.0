Return-Path: <linux-fsdevel+bounces-30734-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EB5198DFEC
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Oct 2024 17:56:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E3516286FF6
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Oct 2024 15:56:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 668EA1D0DD1;
	Wed,  2 Oct 2024 15:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k9RkyEgh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B47B41940B0;
	Wed,  2 Oct 2024 15:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727884529; cv=none; b=BFPWknSNz0C56zeMhAWndvH3DZSPm2aEK4v9QU9Dq89fdXYPOMuqhW3PQBA2cBhleMtc79U7Nb9ynC3eXlGRp2vnqce8AyMaU+1aWdqTstilldZEsEBnG6kL+ZilMt39sXE20FZ7GTxR9xuW8s7BpNVbkdG/5Z8OZ4sO1IgdRKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727884529; c=relaxed/simple;
	bh=27HUeDVHXOs+OLA9bA8uKhz/MQrgdafn0/iAATWL0mM=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BSqb7psb5hJOtY4wAztllP3xLFEOxLzysKVuyaLSvUA/xwhHrgSt4pOdG4ok2wM7w2YVsajBkzeu67SJzgQKyrGhT8equzW91kMPGRI3uS5LED/2CzApd8ej9aH+KNA/Ly8XZHkUIbOmsC+SKrfhj6GW9GSY8EyWiFBG+cA8SaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k9RkyEgh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79667C4CEC2;
	Wed,  2 Oct 2024 15:55:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727884529;
	bh=27HUeDVHXOs+OLA9bA8uKhz/MQrgdafn0/iAATWL0mM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=k9RkyEgh+Y/YS87nAPF1Ao6uiCfC2Ka09hloc087gdGHJXHVDYXjBmR2ceETg9ni6
	 deks86zaFNOb6z1/RiWcTXvOF0U/JLOW08+SpteRcOBc5nPa3btIZx+FKc8OiNN7e+
	 FEG/zba/f2YQ1sA2bH3Qf0Z5Uaro4RI1sXzvYN+fyrehRew3uav87f7UIuG26TbRhf
	 SHQvJ+naVNRRTRSJjCOOekaQRb5r/ZRFkTQWCmGQOBDzHBWS9b9AJAbC35w5zYjD/x
	 A1nX477cbgft4pfSE+Rw4NrdL8NdIF2MVohLnxdgNDdBRy1nbrrn5eOA9cIL3jvekY
	 d3ZSOc2PuCwsA==
Received: from sofa.misterjones.org ([185.219.108.64] helo=goblin-girl.misterjones.org)
	by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <maz@kernel.org>)
	id 1sw1hG-00H6P0-9r;
	Wed, 02 Oct 2024 16:55:26 +0100
Date: Wed, 02 Oct 2024 16:55:25 +0100
Message-ID: <86a5fm7b4i.wl-maz@kernel.org>
From: Marc Zyngier <maz@kernel.org>
To: Mark Brown <broonie@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
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
Subject: Re: [PATCH v13 16/40] KVM: arm64: Manage GCS access and registers for guests
In-Reply-To: <86bk0373nq.wl-maz@kernel.org>
References: <20241001-arm64-gcs-v13-0-222b78d87eee@kernel.org>
	<20241001-arm64-gcs-v13-16-222b78d87eee@kernel.org>
	<86bk0373nq.wl-maz@kernel.org>
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
X-SA-Exim-Rcpt-To: broonie@kernel.org, catalin.marinas@arm.com, will@kernel.org, corbet@lwn.net, akpm@linux-foundation.org, oliver.upton@linux.dev, james.morse@arm.com, suzuki.poulose@arm.com, arnd@arndb.de, oleg@redhat.com, ebiederm@xmission.com, shuah@kernel.org, rick.p.edgecombe@intel.com, debug@rivosinc.com, ardb@kernel.org, Szabolcs.Nagy@arm.com, kees@kernel.org, hjl.tools@gmail.com, paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu, fweimer@redhat.com, brauner@kernel.org, thiago.bauermann@linaro.org, ross.burton@arm.com, david.spickett@arm.com, yury.khrustalev@arm.com, wilco.dijkstra@arm.com, linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org, kvmarm@lists.linux.dev, linux-fsdevel@vger.kernel.org, linux-arch@vger.kernel.org, linux-mm@kvack.org, linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false

On Wed, 02 Oct 2024 01:24:25 +0100,
Marc Zyngier <maz@kernel.org> wrote:
> 
> On Tue, 01 Oct 2024 23:58:55 +0100,
> Mark Brown <broonie@kernel.org> wrote:
> 
> > @@ -4714,6 +4735,10 @@ void kvm_calculate_traps(struct kvm_vcpu *vcpu)
> >  		kvm->arch.fgu[HFGxTR_GROUP] |= (HFGxTR_EL2_nPOR_EL1 |
> >  						HFGxTR_EL2_nPOR_EL0);
> >  
> > +	if (!kvm_has_gcs(kvm))
> > +		kvm->arch.fgu[HFGxTR_GROUP] |= (HFGxTR_EL2_nGCS_EL0 |
> > +						HFGxTR_EL2_nGCS_EL1);
> > +
> 
> Why are you still allowing the GCS instructions when GCS isn't
> enabled?

Scratch that, they are NOPs when GCS isn't enabled, so there shouldn't
be any need for extra traps.

	M.

-- 
Without deviation from the norm, progress is not possible.


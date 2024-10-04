Return-Path: <linux-fsdevel+bounces-30994-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BD0219904E2
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Oct 2024 15:52:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C2C81F22E8E
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Oct 2024 13:52:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAEEB2139A7;
	Fri,  4 Oct 2024 13:52:29 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69D0B212EEE;
	Fri,  4 Oct 2024 13:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728049949; cv=none; b=S+2ZB1/9HsoURbtcaIYbyiC2clZn3iIIWDOYQEz92gOxHD/6Dzld5MnsE+h7pIFG9Ia/kXK3owQ1rFHJ4J/NTGzdgzP79YCPyDzET/52jlzC0F6H3e097zhFxUKtGmVbJX4w1omxI3bhBCeynIMyzjVxZZiH951ChNcKtQrf5nA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728049949; c=relaxed/simple;
	bh=CgGaF1WPSG5Fi8uzeesZWuMpwpxItmoNQIqnngNVELo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sljDY5+XXEMXzWYrpiDuD5MNo9CB6aHrJiF11d72/VJgWTljhoGn1CCFdhMR2TY7mulIsBsBaWhbKTVcWq4YkAN21wG1YQ9KQgW/tRAH9H6in90/Yk7SU844WzmZTZu4yP6KIxQivp7j4c6FRaXYtuZqvyh7BKLeoZEBooN9VbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96531C4CEC6;
	Fri,  4 Oct 2024 13:52:22 +0000 (UTC)
From: Catalin Marinas <catalin.marinas@arm.com>
To: Will Deacon <will@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Andrew Morton <akpm@linux-foundation.org>,
	Marc Zyngier <maz@kernel.org>,
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
	Mark Brown <broonie@kernel.org>
Cc: "H.J. Lu" <hjl.tools@gmail.com>,
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
	linux-riscv@lists.infradead.org,
	David Hildenbrand <david@redhat.com>,
	"Mike Rapoport (IBM)" <rppt@kernel.org>,
	Shuah Khan <skhan@linuxfoundation.org>
Subject: Re: (subset) [PATCH v13 00/40] arm64/gcs: Provide support for GCS in userspace
Date: Fri,  4 Oct 2024 14:52:20 +0100
Message-Id: <172804948348.2705006.18010706949544079891.b4-ty@arm.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241001-arm64-gcs-v13-0-222b78d87eee@kernel.org>
References: <20241001-arm64-gcs-v13-0-222b78d87eee@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Tue, 01 Oct 2024 23:58:39 +0100, Mark Brown wrote:
> The arm64 Guarded Control Stack (GCS) feature provides support for
> hardware protected stacks of return addresses, intended to provide
> hardening against return oriented programming (ROP) attacks and to make
> it easier to gather call stacks for applications such as profiling.
> 
> When GCS is active a secondary stack called the Guarded Control Stack is
> maintained, protected with a memory attribute which means that it can
> only be written with specific GCS operations.  The current GCS pointer
> can not be directly written to by userspace.  When a BL is executed the
> value stored in LR is also pushed onto the GCS, and when a RET is
> executed the top of the GCS is popped and compared to LR with a fault
> being raised if the values do not match.  GCS operations may only be
> performed on GCS pages, a data abort is generated if they are not.
> 
> [...]

I applied most of the series to arm64 (for-next/gcs), apart from two KVM
patches - 16 and 40 (the latter is the kselftest). I usually start
picking patches at -rc3 but the glibc folk are waiting for these patches
to at least end up in a maintainer's branch. Of course, these patches
are subject to change until the final 6.13 release.

The KVM patches can go on top once agreed (or they can go in via the KVM
tree, I don't mind either way).

Thanks!

[01/40] mm: Introduce ARCH_HAS_USER_SHADOW_STACK
        https://git.kernel.org/arm64/c/bcc9d04e749a
[02/40] mm: Define VM_HIGH_ARCH_6
        https://git.kernel.org/arm64/c/9ab515b18f84
[03/40] arm64/mm: Restructure arch_validate_flags() for extensibility
        https://git.kernel.org/arm64/c/f645e888b1a6
[04/40] prctl: arch-agnostic prctl for shadow stack
        https://git.kernel.org/arm64/c/91e102e79740
[05/40] mman: Add map_shadow_stack() flags
        https://git.kernel.org/arm64/c/3630e82ab6bd
[06/40] arm64: Document boot requirements for Guarded Control Stacks
        https://git.kernel.org/arm64/c/830ae8a39685
[07/40] arm64/gcs: Document the ABI for Guarded Control Stacks
        https://git.kernel.org/arm64/c/7058bf87cd59
[08/40] arm64/sysreg: Add definitions for architected GCS caps
        https://git.kernel.org/arm64/c/ce0641d48ddd
[09/40] arm64/gcs: Add manual encodings of GCS instructions
        https://git.kernel.org/arm64/c/dad947cc22cf
[10/40] arm64/gcs: Provide put_user_gcs()
        https://git.kernel.org/arm64/c/d0aa2b435186
[11/40] arm64/gcs: Provide basic EL2 setup to allow GCS usage at EL0 and EL1
        https://git.kernel.org/arm64/c/ff5181d8a2a8
[12/40] arm64/cpufeature: Runtime detection of Guarded Control Stack (GCS)
        https://git.kernel.org/arm64/c/6487c963083c
[13/40] arm64/mm: Allocate PIE slots for EL0 guarded control stack
        https://git.kernel.org/arm64/c/092055f1508c
[14/40] mm: Define VM_SHADOW_STACK for arm64 when we support GCS
        https://git.kernel.org/arm64/c/ae80e1629aea
[15/40] arm64/mm: Map pages for guarded control stack
        https://git.kernel.org/arm64/c/6497b66ba694
[17/40] arm64/idreg: Add overrride for GCS
        https://git.kernel.org/arm64/c/a94452112ce4
[18/40] arm64/hwcap: Add hwcap for GCS
        https://git.kernel.org/arm64/c/eefc98711f84
[19/40] arm64/traps: Handle GCS exceptions
        https://git.kernel.org/arm64/c/8ce71d270536
[20/40] arm64/mm: Handle GCS data aborts
        https://git.kernel.org/arm64/c/cfad706e8f6d
[21/40] arm64/gcs: Context switch GCS state for EL0
        https://git.kernel.org/arm64/c/fc84bc5378a8
[22/40] arm64/gcs: Ensure that new threads have a GCS
        https://git.kernel.org/arm64/c/506496bcbb42
[23/40] arm64/gcs: Implement shadow stack prctl() interface
        https://git.kernel.org/arm64/c/b57180c75c7e
[24/40] arm64/mm: Implement map_shadow_stack()
        https://git.kernel.org/arm64/c/8f3e750673b2
[25/40] arm64/signal: Set up and restore the GCS context for signal handlers
        https://git.kernel.org/arm64/c/eaf62ce1563b
[26/40] arm64/signal: Expose GCS state in signal frames
        https://git.kernel.org/arm64/c/16f47bb9ac8a
[27/40] arm64/ptrace: Expose GCS via ptrace and core files
        https://git.kernel.org/arm64/c/7ec3b57cb29f
[28/40] arm64: Add Kconfig for Guarded Control Stack (GCS)
        https://git.kernel.org/arm64/c/5d8b172e7005
[29/40] kselftest/arm64: Verify the GCS hwcap
        https://git.kernel.org/arm64/c/7a2f671db61f
[30/40] kselftest/arm64: Add GCS as a detected feature in the signal tests
        https://git.kernel.org/arm64/c/b2d2f11ff5d6
[31/40] kselftest/arm64: Add framework support for GCS to signal handling tests
        https://git.kernel.org/arm64/c/0d426f7dd9a0
[32/40] kselftest/arm64: Allow signals tests to specify an expected si_code
        https://git.kernel.org/arm64/c/956573ac1890
[33/40] kselftest/arm64: Always run signals tests with GCS enabled
        https://git.kernel.org/arm64/c/42155a8eb0f6
[34/40] kselftest/arm64: Add very basic GCS test program
        https://git.kernel.org/arm64/c/3d37d4307e0f
[35/40] kselftest/arm64: Add a GCS test program built with the system libc
        https://git.kernel.org/arm64/c/a505a52b4e29
[36/40] kselftest/arm64: Add test coverage for GCS mode locking
        https://git.kernel.org/arm64/c/58d69a3e3582
[37/40] kselftest/arm64: Add GCS signal tests
        https://git.kernel.org/arm64/c/794b64ca5665
[38/40] kselftest/arm64: Add a GCS stress test
        https://git.kernel.org/arm64/c/05e6cfff58c4
[39/40] kselftest/arm64: Enable GCS for the FP stress tests
        https://git.kernel.org/arm64/c/bb9ae1a66c85

-- 
Catalin



Return-Path: <linux-fsdevel+bounces-69829-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id AB0E8C869F7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Nov 2025 19:30:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 578CD3509C5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Nov 2025 18:30:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBF0032D0EF;
	Tue, 25 Nov 2025 18:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="b+tzixxm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADEF91F8BD6;
	Tue, 25 Nov 2025 18:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764095416; cv=none; b=VCxaov+Mi4dUya9SetTPESe3W3NsJ8NXgakxcMX1CmgUYEYdJRmXTCNOfU5le7TxUt51uAo3s/67dl3eTh2nRmgQer2a/icDAJSXLZl5uTZzUozGBedQriboNiyEV7lbo007P9GIDKBJ+VqmSTo/ljRejfT6+ko8RqD2RY41dQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764095416; c=relaxed/simple;
	bh=ilWEu5RxIVLfVIaXLQHAdQTbENf6mqv/Hm1iZ1MhI6w=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=XBJnQuRW8JP4OBCHdTuOMnrslkJ+ehAk9c8x+VcR+Fq0q4bHBjl2aN8JeatPUa3A9Lj57JJqHN72xJxI/Az9ujE6Kayaz/+QlJhLw2pTgqRW+i0ynya9NiTv5Oki+0xD/IXiB/023fY02ws4C5mdRYmNm40FTvEcZM1OoBIu/ks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=b+tzixxm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD2C0C4CEF1;
	Tue, 25 Nov 2025 18:30:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1764095416;
	bh=ilWEu5RxIVLfVIaXLQHAdQTbENf6mqv/Hm1iZ1MhI6w=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=b+tzixxmV1ZRmL/hj6nA0kkhxHaUdNXKQqWLsC+tDqtp42wPV/HVAldl2UR2lg/rT
	 xSJtZgyEUdh9WxYrFtcKmqnPiupLOQerU+GcoaZlxAwHQ7BHUkwHOT+4MLntXo2qFU
	 9de67fdf8StJsO22yf01YKRQiw7y3RYkO/wk+/pk=
Date: Tue, 25 Nov 2025 10:30:12 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: pratyush@kernel.org, jasonmiu@google.com, graf@amazon.com,
 rppt@kernel.org, dmatlack@google.com, rientjes@google.com, corbet@lwn.net,
 rdunlap@infradead.org, ilpo.jarvinen@linux.intel.com,
 kanie@linux.alibaba.com, ojeda@kernel.org, aliceryhl@google.com,
 masahiroy@kernel.org, tj@kernel.org, yoann.congal@smile.fr,
 mmaurer@google.com, roman.gushchin@linux.dev, chenridong@huawei.com,
 axboe@kernel.dk, mark.rutland@arm.com, jannh@google.com,
 vincent.guittot@linaro.org, hannes@cmpxchg.org, dan.j.williams@intel.com,
 david@redhat.com, joel.granados@kernel.org, rostedt@goodmis.org,
 anna.schumaker@oracle.com, song@kernel.org, linux@weissschuh.net,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-mm@kvack.org, gregkh@linuxfoundation.org, tglx@linutronix.de,
 mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
 x86@kernel.org, hpa@zytor.com, rafael@kernel.org, dakr@kernel.org,
 bartosz.golaszewski@linaro.org, cw00.choi@samsung.com,
 myungjoo.ham@samsung.com, yesanishhere@gmail.com,
 Jonathan.Cameron@huawei.com, quic_zijuhu@quicinc.com,
 aleksander.lobakin@intel.com, ira.weiny@intel.com,
 andriy.shevchenko@linux.intel.com, leon@kernel.org, lukas@wunner.de,
 bhelgaas@google.com, wagi@kernel.org, djeffery@redhat.com,
 stuart.w.hayes@gmail.com, ptyadav@amazon.de, lennart@poettering.net,
 brauner@kernel.org, linux-api@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, saeedm@nvidia.com, ajayachandra@nvidia.com,
 jgg@nvidia.com, parav@nvidia.com, leonro@nvidia.com, witu@nvidia.com,
 hughd@google.com, skhawaja@google.com, chrisl@kernel.org
Subject: Re: [PATCH v8 00/18] Live Update Orchestrator
Message-Id: <20251125103012.c9f0519e166b810e2e03e1b0@linux-foundation.org>
In-Reply-To: <20251125165850.3389713-1-pasha.tatashin@soleen.com>
References: <20251125165850.3389713-1-pasha.tatashin@soleen.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 25 Nov 2025 11:58:30 -0500 Pasha Tatashin <pasha.tatashin@soleen.com> wrote:

> Andrew: This series has been fully reviewed, and contains minimal
> changes compared to what is currently being tested in linux-next
> diff between v7 and v8 can be viewe, here: [8]
> 
> Four patches have been dropped compared to v7: and are going to be sent
> separately.
> 
> This series introduces the Live Update Orchestrator, a kernel subsystem
> designed to facilitate live kernel updates using a kexec-based reboot.
> This capability is critical for cloud environments, allowing hypervisors
> to be updated with minimal downtime for running virtual machines. LUO
> achieves this by preserving the state of selected resources, such as
> memory, devices and their dependencies, across the kernel transition.

Thanks, I updated mm.git's mm-nonmm-unstable branch to this version.

I expect I'll move all the below material into mm-nonmm-stable in a
couple of days.

kho-make-debugfs-interface-optional.patch
kho-drop-notifiers.patch
kho-add-interfaces-to-unpreserve-folios-page-ranges-and-vmalloc.patch
memblock-unpreserve-memory-in-case-of-error.patch
memblock-unpreserve-memory-in-case-of-error-fix.patch
test_kho-unpreserve-memory-in-case-of-error.patch
kho-dont-unpreserve-memory-during-abort.patch
liveupdate-kho-move-to-kernel-liveupdate.patch
liveupdate-kho-move-to-kernel-liveupdate-fix.patch
maintainers-update-kho-maintainers.patch
liveupdate-kho-use-%pe-format-specifier-for-error-pointer-printing.patch
#
kho-fix-misleading-log-message-in-kho_populate.patch
kho-convert-__kho_abort-to-return-void.patch
kho-introduce-high-level-memory-allocation-api.patch
kho-introduce-high-level-memory-allocation-api-fix.patch
kho-preserve-fdt-folio-only-once-during-initialization.patch
kho-verify-deserialization-status-and-fix-fdt-alignment-access.patch
kho-always-expose-output-fdt-in-debugfs.patch
kho-simplify-serialization-and-remove-__kho_abort.patch
kho-remove-global-preserved_mem_map-and-store-state-in-fdt.patch
kho-remove-abort-functionality-and-support-state-refresh.patch
kho-update-fdt-dynamically-for-subtree-addition-removal.patch
kho-allow-kexec-load-before-kho-finalization.patch
kho-allow-memory-preservation-state-updates-after-finalization.patch
kho-add-kconfig-option-to-enable-kho-by-default.patch
#
#
liveupdate-luo_core-live-update-orchestrato.patch
liveupdate-luo_core-integrate-with-kho.patch
kexec-call-liveupdate_reboot-before-kexec.patch
liveupdate-luo_session-add-sessions-support.patch
liveupdate-luo_core-add-user-interface.patch
liveupdate-luo_file-implement-file-systems-callbacks.patch
liveupdate-luo_session-add-ioctls-for-file-preservation.patch
docs-add-luo-documentation.patch
maintainers-add-liveupdate-entry.patch
mm-shmem-use-shmem_f_-flags-instead-of-vm_-flags.patch
mm-shmem-allow-freezing-inode-mapping.patch
mm-shmem-export-some-functions-to-internalh.patch
liveupdate-luo_file-add-private-argument-to-store-runtime-state.patch
mm-memfd_luo-allow-preserving-memfd.patch
docs-add-documentation-for-memfd-preservation-via-luo.patch
selftests-liveupdate-add-userspace-api-selftests.patch
selftests-liveupdate-add-simple-kexec-based-selftest-for-luo.patch
selftests-liveupdate-add-kexec-test-for-multiple-and-empty-sessions.patch
#
#
kho-free-chunks-using-free_page-instead-of-kfree.patch
#
test_kho-always-print-restore-status.patch
#
kho-kho_restore_vmalloc-fix-initialization-of-pages-array.patch
kho-fix-restoring-of-contiguous-ranges-of-order-0-pages.patch
#


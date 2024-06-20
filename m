Return-Path: <linux-fsdevel+bounces-21955-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3418C910479
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Jun 2024 14:49:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC5012861EA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Jun 2024 12:49:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C63411ACE60;
	Thu, 20 Jun 2024 12:48:45 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B38C1AB91C;
	Thu, 20 Jun 2024 12:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718887725; cv=none; b=i1aRrKvm0ex9NhGMtxOt+qe/P0OV286e29FU9VY/LvAXZaD9Xld50ItZL2rfHgY5hHrhu3qOPaxuRa45r2xYbqYJU5XmKgWKLh62CFMEBulGBfTABsZJJKDRegbEN8Et+MrB0FR7l5Jd9F76JG5Ca348FSfERAngPLWNhVfUqgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718887725; c=relaxed/simple;
	bh=GlC3AyVm0DzPtO4YMlUdHoFLgvGg1FyRZ04zug1OFOA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=VNHsQyqL4c+WBaSyZYLJBcJOFQRqcE10GoCF020hTd2LwsicyfJroUeXuPS+5R22liiQxpsynonICQHpo3skzJwU/gJiX4smM3gGW8cLJHsCOQcobAH/PHnrhO5QASZgDWfr3FyEZxP2wrEYZN3BfCoKCx7CzVSwRNcPmUUxEVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au; spf=pass smtp.mailfrom=ellerman.id.au; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ellerman.id.au
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4W4gJw1sK0z4wcJ;
	Thu, 20 Jun 2024 22:48:32 +1000 (AEST)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: linuxppc-dev@lists.ozlabs.org, Michael Ellerman <mpe@ellerman.id.au>
Cc: linux-fsdevel@vger.kernel.org, brauner@kernel.org, aik@amd.com, torvalds@linux-foundation.org, kvm@vger.kernel.org, tpearson@raptorengineering.com, sbhat@linux.ibm.com, Paul Mackerras <paulus@ozlabs.org>
In-Reply-To: <20240614122910.3499489-1-mpe@ellerman.id.au>
References: <20240614122910.3499489-1-mpe@ellerman.id.au>
Subject: Re: [PATCH] KVM: PPC: Book3S HV: Prevent UAF in kvm_spapr_tce_attach_iommu_group()
Message-Id: <171888750930.804969.9625740096908801774.b4-ty@ellerman.id.au>
Date: Thu, 20 Jun 2024 22:45:09 +1000
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

On Fri, 14 Jun 2024 22:29:10 +1000, Michael Ellerman wrote:
> Al reported a possible use-after-free (UAF) in kvm_spapr_tce_attach_iommu_group().
> 
> It looks up `stt` from tablefd, but then continues to use it after doing
> fdput() on the returned fd. After the fdput() the tablefd is free to be
> closed by another thread. The close calls kvm_spapr_tce_release() and
> then release_spapr_tce_table() (via call_rcu()) which frees `stt`.
> 
> [...]

Applied to powerpc/fixes.

[1/1] KVM: PPC: Book3S HV: Prevent UAF in kvm_spapr_tce_attach_iommu_group()
      https://git.kernel.org/powerpc/c/a986fa57fd81a1430e00b3c6cf8a325d6f894a63

cheers


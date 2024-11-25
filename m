Return-Path: <linux-fsdevel+bounces-35793-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 046F59D860D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Nov 2024 14:13:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 279B61622CA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Nov 2024 13:13:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D3F21AB530;
	Mon, 25 Nov 2024 13:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HUnFiL7m"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA38F1A76B5;
	Mon, 25 Nov 2024 13:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732540401; cv=none; b=MdcVSWnwbPzN0MAohXdRbbtv+7vacbaz70E1mYXGFmpCcVwWF293a2JXAb2p5Qu0J2iWksaX+iE2szOspP2kquTOR7LY0U6ekdyHHyd7LXgn0HPbpoBHyxmUIDHt2UqsC12CUetQVH7TjutRvqc1FT1fI50Tswki1DbU0SSuWuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732540401; c=relaxed/simple;
	bh=zoe9keCgOz8TdgaZeY2U5FChsOFwHzQn4aQ2XQc2oMk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=HsjI1F4lU9xZNA7CT71MkjFklAH31Ft0/sxSBa6eGqJ1GhWWx5/rXM5GLVAAde8SXM3wonadqw86QhjGG5y7HMgsCgHXA+uLub8NJRwzryYpmReI7ceBv2HADGTNL61rHjNZLDNRgr8Oua4XvN6u3DazqzXL53EdycTsAbOzLpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HUnFiL7m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3F59C4CECE;
	Mon, 25 Nov 2024 13:13:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732540400;
	bh=zoe9keCgOz8TdgaZeY2U5FChsOFwHzQn4aQ2XQc2oMk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=HUnFiL7mAae91KuKIjZq38fKCFSJ/xeAJC0MKHSCYoLch7XSINlDDErAkmEKfKrBl
	 7JuTksfjNvU+Dypx8p0EI/G2Fhzu9c8FHGOHjTRsxtkA6VLNB7Gy/Tskmtr9VySjLd
	 1/BwilXjzpT7eWAlgRWDMQVe6RXh1uSt11U6NtohY5ZZvTxLsSbPatv3SQLMVqkMnR
	 1GVIZ9VmtROba4i4EU1fuSctCl91TePgrrkXglv5+hmJlc3o//fcw0LB9Z5o8wnSYB
	 zY4qKyBWauQxBjUch391Y/FMHbdTpfMlXB+FVYUOR6QUhRl2qKkos6e6S6MjIiLwlQ
	 MF/4czrgX+pWA==
From: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To: Alistair Popple <apopple@nvidia.com>, dan.j.williams@intel.com,
 linux-mm@kvack.org
Cc: Alistair Popple <apopple@nvidia.com>, lina@asahilina.net,
 zhang.lyra@gmail.com, gerald.schaefer@linux.ibm.com,
 vishal.l.verma@intel.com, dave.jiang@intel.com, logang@deltatee.com,
 bhelgaas@google.com, jack@suse.cz, jgg@ziepe.ca, catalin.marinas@arm.com,
 will@kernel.org, mpe@ellerman.id.au, npiggin@gmail.com,
 dave.hansen@linux.intel.com, ira.weiny@intel.com, willy@infradead.org,
 djwong@kernel.org, tytso@mit.edu, linmiaohe@huawei.com, david@redhat.com,
 peterx@redhat.com, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linuxppc-dev@lists.ozlabs.org, nvdimm@lists.linux.dev,
 linux-cxl@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org,
 jhubbard@nvidia.com, hch@lst.de, david@fromorbit.com,
 linux-riscv@lists.infradead.org
Subject: Re: [PATCH v3 25/25] Revert "riscv: mm: Add support for ZONE_DEVICE"
In-Reply-To: <f511de7cb9817e2e2fdd274ee842c228d699abea.1732239628.git-series.apopple@nvidia.com>
References: <cover.e1ebdd6cab9bde0d232c1810deacf0bae25e6707.1732239628.git-series.apopple@nvidia.com>
 <f511de7cb9817e2e2fdd274ee842c228d699abea.1732239628.git-series.apopple@nvidia.com>
Date: Mon, 25 Nov 2024 14:13:17 +0100
Message-ID: <878qt7zcb6.fsf@all.your.base.are.belong.to.us>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Alistair Popple <apopple@nvidia.com> writes:

> DEVMAP PTEs are no longer required to support ZONE_DEVICE so remove
> them.
>
> Signed-off-by: Alistair Popple <apopple@nvidia.com>
> Suggested-by: Chunyan Zhang <zhang.lyra@gmail.com>

Oh, we're getting the bit back! Thanks!

Reviewed-by: Bj=C3=B6rn T=C3=B6pel <bjorn@rivosinc.com>


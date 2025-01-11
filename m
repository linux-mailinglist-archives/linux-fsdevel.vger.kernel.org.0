Return-Path: <linux-fsdevel+bounces-38924-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98ADBA0A01C
	for <lists+linux-fsdevel@lfdr.de>; Sat, 11 Jan 2025 02:31:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DC51D7A371D
	for <lists+linux-fsdevel@lfdr.de>; Sat, 11 Jan 2025 01:30:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05EFD3EA71;
	Sat, 11 Jan 2025 01:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="wCdNg1TF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1537B24B240;
	Sat, 11 Jan 2025 01:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736559050; cv=none; b=GmWvCyx+16ML/g4ARzbRQNZ/qmWe4wgJfV26VnyGjSe3PV2ZF0Dn2nsZA1+Xt1rLPXeK75Fh0tkmq89Uhn90GWwWOLqWEpJ0eEfyAt05vZrIQEjjzC8KkFVoQU5piBbfh5upI9L9OthVtevbDmETAMImE/0AZOUQhVexNAOQMVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736559050; c=relaxed/simple;
	bh=7I1OBfWbo908Mx7qvQkrDHGouLRf+dWAo5fEwim6p1w=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=N+OdPa5g/1NrhMK6t4w0PV8rMguk4pGpVgTnDU3pxtJSgFnQNdQV/q8Yhzqk8QUXA25nhfLlQuJrl2n42IFIY0YDyH7BT82q1Gfqx5ZSOcjbp2YD1/bLyWfxhOiug04y2IUHDt46sqp/ICJBNJmxIeQm4rowWWt8AgKPQTt4rDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=wCdNg1TF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CC51C4CED6;
	Sat, 11 Jan 2025 01:30:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1736559049;
	bh=7I1OBfWbo908Mx7qvQkrDHGouLRf+dWAo5fEwim6p1w=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=wCdNg1TFG2mQ2V7JLabBLagQ3iPh1FJkujMfPxuiGPq8mHSUiRbicfuDz2i9VqjFf
	 EAUFhX6Dmh7OxXqZl8IYRBtst8NCQct6t/dFbEismIfwpRA3Qoo2LI1c6LPpWu8fRG
	 2Kmoai3+QNA8Ga1fKjMEVJkS7d/Z4QkUiwdQ67Rg=
Date: Fri, 10 Jan 2025 17:30:48 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Dan Williams <dan.j.williams@intel.com>
Cc: Alistair Popple <apopple@nvidia.com>, <linux-mm@kvack.org>,
 <alison.schofield@intel.com>, <lina@asahilina.net>, <zhang.lyra@gmail.com>,
 <gerald.schaefer@linux.ibm.com>, <vishal.l.verma@intel.com>,
 <dave.jiang@intel.com>, <logang@deltatee.com>, <bhelgaas@google.com>,
 <jack@suse.cz>, <jgg@ziepe.ca>, <catalin.marinas@arm.com>,
 <will@kernel.org>, <mpe@ellerman.id.au>, <npiggin@gmail.com>,
 <dave.hansen@linux.intel.com>, <ira.weiny@intel.com>,
 <willy@infradead.org>, <djwong@kernel.org>, <tytso@mit.edu>,
 <linmiaohe@huawei.com>, <david@redhat.com>, <peterx@redhat.com>,
 <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-arm-kernel@lists.infradead.org>, <linuxppc-dev@lists.ozlabs.org>,
 <nvdimm@lists.linux.dev>, <linux-cxl@vger.kernel.org>,
 <linux-fsdevel@vger.kernel.org>, <linux-ext4@vger.kernel.org>,
 <linux-xfs@vger.kernel.org>, <jhubbard@nvidia.com>, <hch@lst.de>,
 <david@fromorbit.com>, <chenhuacai@kernel.org>, <kernel@xen0n.name>,
 <loongarch@lists.linux.dev>
Subject: Re: [PATCH v6 00/26] fs/dax: Fix ZONE_DEVICE page reference counts
Message-Id: <20250110173048.5565901e0fec24556325bd18@linux-foundation.org>
In-Reply-To: <6780c6d43d73e_2aff42943b@dwillia2-xfh.jf.intel.com.notmuch>
References: <cover.11189864684e31260d1408779fac9db80122047b.1736488799.git-series.apopple@nvidia.com>
	<6780c6d43d73e_2aff42943b@dwillia2-xfh.jf.intel.com.notmuch>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 9 Jan 2025 23:05:56 -0800 Dan Williams <dan.j.williams@intel.com> wrote:

> >  - Remove PTE_DEVMAP definitions from Loongarch which were added since
> >    this series was initially written.
> [..]
> > 
> > base-commit: e25c8d66f6786300b680866c0e0139981273feba
> 
> If this is going to go through nvdimm.git I will need it against a
> mainline tag baseline. Linus will want to see the merge conflicts.
> 
> Otherwise if that merge commit is too messy, or you would rather not
> rebase, then it either needs to go one of two options:
> 
> - Andrew's tree which is the only tree I know of that can carry
>   patches relative to linux-next.

I used to be able to do that but haven't got around to setting up such
a thing with mm.git.  This is the first time the need has arisen,
really.

> - Wait for v6.14-rc1 

I'm thinking so.  Darrick's review comments indicate that we'll be seeing a v7.

> and get this into nvdimm.git early in the cycle
>   when the conflict storm will be low.

erk.  This patchset hits mm/ a lot, and nvdimm hardly at all.  Is it
not practical to carry this in mm.git?



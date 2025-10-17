Return-Path: <linux-fsdevel+bounces-64553-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CD7DEBEBD36
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Oct 2025 23:37:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B70281AE12D6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Oct 2025 21:38:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CBC92D46C0;
	Fri, 17 Oct 2025 21:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="FE1dBvUV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BDBB2036E9;
	Fri, 17 Oct 2025 21:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760737045; cv=none; b=QBEOw+lxd0phQdSYgpcjwzORj5sVJAnKLSsfC/7pmws2jYUff+l/qhwnux6NCqx828MuZQ/rTeRlbtDMebwv4dV48O2RlQZBzNGm8Z1J2xkbFlDJPzmDaaYNbbbIdmRFwuyuHJqDI0guOMt5524LKvHzZApbuARHSysWWsl9e70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760737045; c=relaxed/simple;
	bh=nYpBafhW7YwCHT2Y3O7Vz/Cfc9k402BvH2+Wh0f/DtA=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=cd9pi7fG1cFjyUBuUA1T/KvVxayvLCNYinxzZkHNwWjUhC+wEPrsqY5nFy0FPpfaInFwhXASPu6m1jVDCLQTUayfplYuiHjIslNzlecVsYjfQe0r6lmQNS8Cm6yrAvC/W3mk+L54YHlZiMJTWC54Glq3d9zcJJ9Uxn+NWnfLmMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=FE1dBvUV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7221C4CEE7;
	Fri, 17 Oct 2025 21:37:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1760737044;
	bh=nYpBafhW7YwCHT2Y3O7Vz/Cfc9k402BvH2+Wh0f/DtA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=FE1dBvUVul1ShFrtQ9a2yuuluVLEiX3PNARQaVwbXQaU+qoOwkoZFLo6b4wiRoAnn
	 EAWR1VKBFA4zRtgkP4k2hogdZvMF/OsA2XiB7rwYq/IaAOtbxaSzMwRQdJIRLlTGrz
	 ijhhPTnwyBb6OdZP8xn3qakbxsmeiLKTac97LR64=
Date: Fri, 17 Oct 2025 14:37:22 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Sumanth Korikkar <sumanthk@linux.ibm.com>, Jonathan Corbet
 <corbet@lwn.net>, Matthew Wilcox <willy@infradead.org>, Guo Ren
 <guoren@kernel.org>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Heiko
 Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Alexander
 Gordeev <agordeev@linux.ibm.com>, Christian Borntraeger
 <borntraeger@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>,
 "David S . Miller" <davem@davemloft.net>, Andreas Larsson
 <andreas@gaisler.com>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Dan Williams <dan.j.williams@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Dave Jiang <dave.jiang@intel.com>,
 Nicolas Pitre <nico@fluxnic.net>, Muchun Song <muchun.song@linux.dev>,
 Oscar Salvador <osalvador@suse.de>, David Hildenbrand <david@redhat.com>,
 Konstantin Komarov <almaz.alexandrovich@paragon-software.com>, Baoquan He
 <bhe@redhat.com>, Vivek Goyal <vgoyal@redhat.com>, Dave Young
 <dyoung@redhat.com>, Tony Luck <tony.luck@intel.com>, Reinette Chatre
 <reinette.chatre@intel.com>, Dave Martin <Dave.Martin@arm.com>, James Morse
 <james.morse@arm.com>, Alexander Viro <viro@zeniv.linux.org.uk>, Christian
 Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, "Liam R . Howlett"
 <Liam.Howlett@oracle.com>, Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport
 <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, Michal Hocko
 <mhocko@suse.com>, Hugh Dickins <hughd@google.com>, Baolin Wang
 <baolin.wang@linux.alibaba.com>, Uladzislau Rezki <urezki@gmail.com>,
 Dmitry Vyukov <dvyukov@google.com>, Andrey Konovalov
 <andreyknvl@gmail.com>, Jann Horn <jannh@google.com>, Pedro Falcato
 <pfalcato@suse.de>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-csky@vger.kernel.org, linux-mips@vger.kernel.org,
 linux-s390@vger.kernel.org, sparclinux@vger.kernel.org,
 nvdimm@lists.linux.dev, linux-cxl@vger.kernel.org, linux-mm@kvack.org,
 ntfs3@lists.linux.dev, kexec@lists.infradead.org,
 kasan-dev@googlegroups.com, Jason Gunthorpe <jgg@nvidia.com>,
 iommu@lists.linux.dev, Kevin Tian <kevin.tian@intel.com>, Will Deacon
 <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH v4 11/14] mm/hugetlbfs: update hugetlbfs to use
 mmap_prepare
Message-Id: <20251017143722.d045a2cd9d1839803da3f28a@linux-foundation.org>
In-Reply-To: <c64e017a-5219-4382-bba9-d24310ad2c21@lucifer.local>
References: <cover.1758135681.git.lorenzo.stoakes@oracle.com>
	<e5532a0aff1991a1b5435dcb358b7d35abc80f3b.1758135681.git.lorenzo.stoakes@oracle.com>
	<aNKJ6b7kmT_u0A4c@li-2b55cdcc-350b-11b2-a85c-a78bff51fc11.ibm.com>
	<20250923141704.90fba5bdf8c790e0496e6ac1@linux-foundation.org>
	<aPI2SZ5rFgZVT-I8@li-2b55cdcc-350b-11b2-a85c-a78bff51fc11.ibm.com>
	<c64e017a-5219-4382-bba9-d24310ad2c21@lucifer.local>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 17 Oct 2025 13:46:20 +0100 Lorenzo Stoakes <lorenzo.stoakes@oracle.com> wrote:

> > The issue is reproducible again in linux-next with the following commit:
> > 5fdb155933fa ("mm/hugetlbfs: update hugetlbfs to use mmap_prepare")
> 
> Andrew - I see this series in mm-unstable, not sure what it's doing there
> as I need to rework this (when I get a chance, back from a 2 week vacation
> and this week has been - difficult :)
> 
> Can we please drop this until I have a chance to respin?

No probs, gone.


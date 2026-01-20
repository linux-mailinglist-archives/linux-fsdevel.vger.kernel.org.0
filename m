Return-Path: <linux-fsdevel+bounces-74593-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BE6AD3C33E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jan 2026 10:18:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B566C504799
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jan 2026 09:12:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 472F93BF300;
	Tue, 20 Jan 2026 09:12:30 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 558663BC4FB;
	Tue, 20 Jan 2026 09:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768900350; cv=none; b=ncRvLpd5ckhN3NN6mWjfbqPG+S1x2IbDDTSR5SSA4SzgTP/t35hBfbMbiS/kAEM7neW50qdAKzhA/PsIgv8gkAz3UftMIZMwk62KLC1egYR+qYL8RjLG4Cq54QlHGeRxXj+/J9AboDn7NJoS1rB3vg/UHk17Cv7dn70T/ltW9/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768900350; c=relaxed/simple;
	bh=B05gVguD6HO3xQvzt2rGs+vO4e4DANFflmUfKhWSQPw=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hsV8UjvU7eZoV4gGPN1QsjJJUzVdQPFELTRzmEnOJ+Y2p3Tx87Bpvz1l0FBRoSW1+lB7dY6f9gZ/4eU3XVgnndEFSSTomoOre4rKrDavOtbZDbcbkccFNs+HNe5dcwFNX4ohja/TrX4LokkAaHoT3aTazURrYOM3DuV1Q6Wvx9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.107])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4dwM5j0FVBzHnH4v;
	Tue, 20 Jan 2026 17:11:53 +0800 (CST)
Received: from dubpeml500005.china.huawei.com (unknown [7.214.145.207])
	by mail.maildlp.com (Postfix) with ESMTPS id 7874640571;
	Tue, 20 Jan 2026 17:12:24 +0800 (CST)
Received: from localhost (10.203.177.99) by dubpeml500005.china.huawei.com
 (7.214.145.207) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 20 Jan
 2026 09:12:22 +0000
Date: Tue, 20 Jan 2026 09:12:17 +0000
From: Alireza Sanaee <alireza.sanaee@huawei.com>
To: John Groves <john@jagalactic.com>
CC: John Groves <John@Groves.net>, Miklos Szeredi <miklos@szeredi.hu>, "Dan
 Williams" <dan.j.williams@intel.com>, Bernd Schubert <bschubert@ddn.com>,
	Alison Schofield <alison.schofield@intel.com>, John Groves
	<jgroves@micron.com>, John Groves <jgroves@fastmail.com>, Jonathan Corbet
	<corbet@lwn.net>, Vishal Verma <vishal.l.verma@intel.com>, Dave Jiang
	<dave.jiang@intel.com>, Matthew Wilcox <willy@infradead.org>, Jan Kara
	<jack@suse.cz>, Alexander Viro <viro@zeniv.linux.org.uk>, David Hildenbrand
	<david@kernel.org>, Christian Brauner <brauner@kernel.org>, "Darrick J .
 Wong" <djwong@kernel.org>, Randy Dunlap <rdunlap@infradead.org>, "Jeff
 Layton" <jlayton@kernel.org>, Amir Goldstein <amir73il@gmail.com>, "Jonathan
 Cameron" <Jonathan.Cameron@huawei.com>, Stefan Hajnoczi
	<shajnocz@redhat.com>, Joanne Koong <joannelkoong@gmail.com>, Josef Bacik
	<josef@toxicpanda.com>, Bagas Sanjaya <bagasdotme@gmail.com>, James Morse
	<james.morse@arm.com>, Fuad Tabba <tabba@google.com>, Sean Christopherson
	<seanjc@google.com>, Shivank Garg <shivankg@amd.com>, Ackerley Tng
	<ackerleytng@google.com>, Gregory Price <gourry@gourry.net>, Aravind Ramesh
	<arramesh@micron.com>, Ajay Joshi <ajayjoshi@micron.com>,
	"venkataravis@micron.com" <venkataravis@micron.com>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"nvdimm@lists.linux.dev" <nvdimm@lists.linux.dev>,
	"linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH BUNDLE v7] famfs: Fabric-Attached Memory File System
Message-ID: <20260120091217.00007537.alireza.sanaee@huawei.com>
In-Reply-To: <0100019bd33a16b4-6da11a99-d883-4cfc-b561-97973253bc4a-000000@email.amazonses.com>
References: <20260118222911.92214-1-john@jagalactic.com>
	<0100019bd33a16b4-6da11a99-d883-4cfc-b561-97973253bc4a-000000@email.amazonses.com>
Organization: Huawei
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500010.china.huawei.com (7.191.174.240) To
 dubpeml500005.china.huawei.com (7.214.145.207)

On Sun, 18 Jan 2026 22:29:18 +0000
John Groves <john@jagalactic.com> wrote:

Hi John,

I wonder if these new patches sent recently have been reflected on the github repo readme files. It seems it is not, is it?

> This is a coordinated patch submission for famfs (Fabric-Attached Memory
> File System) across three repositories:
> 
>   1. Linux kernel (cover + 19 patches) - dax fsdev driver + fuse/famfs 
>      integration
>   2. libfuse (cover + 3 patches) - famfs protocol support for fuse servers
>   3. ndctl/daxctl (cover + 2 patches) - support for the new "famfs" devdax
>      mode
> 
> Each series is posted as a reply to this cover message, with individual
> patches replying to their respective series cover.
> 
> Overview
> --------
> Famfs exposes shared memory as a file system. It consumes shared memory
> from dax devices and provides memory-mappable files that map directly to
> the memory with no page cache involvement. Famfs differs from conventional
> file systems in fs-dax mode in that it handles in-memory metadata in a
> sharable way (which begins with never caching dirty shared metadata).
> 
> Famfs started as a standalone file system [1,2], but the consensus at
> LSFMM 2024 and 2025 [3,4] was that it should be ported into fuse.
> 
> The key performance requirement is that famfs must resolve mapping faults
> without upcalls. This is achieved by fully caching the file-to-devdax
> metadata for all active files via two fuse client/server message/response
> pairs: GET_FMAP and GET_DAXDEV.
> 
> Patch Series Summary
> --------------------
> 
> Linux Kernel (V7, 19 patches):
>   - dax: New fsdev driver (drivers/dax/fsdev.c) providing a devdax mode
>     compatible with fs-dax. Devices can be switched among 'devdax', 'fsdev'
>     and 'system-ram' modes via daxctl or sysfs.
>   - fuse: Famfs integration adding GET_FMAP and GET_DAXDEV messages for
>     caching file-to-dax mappings in the kernel.
> 
> libfuse (V7, 3 patches):
>   - Updates fuse_kernel.h to kernel 6.19 baseline
>   - Adds famfs DAX fmap protocol definitions
>   - Implements famfs DAX fmap support for fuse servers
> 
> ndctl/daxctl (V4, 2 patches):
>   - Adds daxctl support for the new "famfs" mode of devdax
>   - Adds test/daxctl-famfs.sh for testing mode transitions
> 
> Changes Since V2 (kernel)
> -------------------------
> - Dax: Completely new fsdev driver replaces the dev_dax_iomap modifications.
>   Uses MEMORY_DEVICE_FS_DAX type with order-0 folios for fs-dax compatibility.
> - Dax: The "poisoned page" problem is properly fixed via fsdev_clear_folio_state()
>   which clears stale mapping/compound state when fsdev binds.
> - Dax: Added dax_set_ops() and driver unbind protection while filesystem mounted.
> - Fuse: Famfs mounts require CAP_SYS_RAWIO (exposing raw memory devices).
> - Fuse: Added DAX address_space_operations with noop_dirty_folio.
> - Rebased to latest kernels, compatible with recent dax refactoring.
> 
> Testing
> -------
> The famfs user space [5] includes comprehensive smoke and unit tests that
> exercise all three components together. The ndctl series includes a
> dedicated test for famfs mode transitions.
> 
> References
> ----------
> [1] https://lore.kernel.org/linux-cxl/cover.1708709155.git.john@groves.net/
> [2] https://lore.kernel.org/linux-cxl/cover.1714409084.git.john@groves.net/
> [3] https://lwn.net/Articles/983105/ (LSFMM 2024)
> [4] https://lwn.net/Articles/1020170/ (LSFMM 2025)
> [5] https://famfs.org (famfs user space)
> [6] https://lore.kernel.org/linux-cxl/20250703185032.46568-1-john@groves.net/ (V2)
> [7] https://lore.kernel.org/linux-fsdevel/20260107153244.64703-1-john@groves.net/T/#m0000d8c00290f48c086b8b176c7525e410f8508c (related ndctl series)
> --
> John Groves
> 
> 
> 



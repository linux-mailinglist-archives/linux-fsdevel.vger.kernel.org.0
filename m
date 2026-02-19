Return-Path: <linux-fsdevel+bounces-77742-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iFxtEimDl2nozQIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77742-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Feb 2026 22:39:53 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 99267162E8C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Feb 2026 22:39:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8E091301DAE5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Feb 2026 21:39:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE7D132AACA;
	Thu, 19 Feb 2026 21:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FCzXJhdp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DD312C1589;
	Thu, 19 Feb 2026 21:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771537179; cv=none; b=cI1mjbpfahtpa48wzl/5VSvWfM6+4gd1chOmmppatEEjjsPTf8k2LoEJJAoQG9WVfJxnFWtEQUotNYUBBXisPA7GLk9/EgdTYA2vIaTK3VsdzF+4sD3/jmDvyW9tXm9XRu2Joi5Kc72YuKPCy9EsQHiMMU9pjWL/+m7R6WURTgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771537179; c=relaxed/simple;
	bh=x0fDg/mrvPWFdEqBiqFoNbiZbpHQldatRPd85b83IZw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ueBwLaSENiERJbgZ2taYzXHog2+paIDET+SBPKXV2yLP18pNlPBhgERfMpJFaLVswvqVUTYkZWw1Zcqka8cCm/AWCdxEXzZ2QiFfYBsA1wOER1qoV1Q8IkSs5YHTxfHdwg2zRwj9dLJsmgHy4CtVCjzToRmSoxlSYxs+WRAL46M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FCzXJhdp; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771537177; x=1803073177;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=x0fDg/mrvPWFdEqBiqFoNbiZbpHQldatRPd85b83IZw=;
  b=FCzXJhdp2QimJIV3qmv5m1C+WkmetSV/R5DqKbn+ryDGjxKmTPuXhoNd
   Va9pF52n/OwKR8wGtNujnSRmh0fxmaylXf/IRSZ1pQKl/35bskaV5lvH6
   F5Ho+0INA7PV3nm7TwmNB7LJOMK0mXok4VovnvpZ8ifB2dUBODi7MR1OU
   dNDa9vVBu4l9W5zLRlVB/UjCFeAw309kZpHNBNx3oZGSqqJqE8g2VSUe0
   sQ+uECsH8VQy0LQltq01lXchIVcxkAWSSHcGCd6oiOtTeCQX4CQCBaylI
   Xk22NErM0Vo3LeAMEFgKx9nyuVEXINTrQAJSc3hknjnnzDOevdfBTP7Pr
   Q==;
X-CSE-ConnectionGUID: nKtAD5FIQCO6jbLG1bLotg==
X-CSE-MsgGUID: BrMHlArZR4637U/x76pHwg==
X-IronPort-AV: E=McAfee;i="6800,10657,11706"; a="76250604"
X-IronPort-AV: E=Sophos;i="6.21,300,1763452800"; 
   d="scan'208";a="76250604"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2026 13:39:36 -0800
X-CSE-ConnectionGUID: 5KF9G3n8SaCmnR2mMQDBjw==
X-CSE-MsgGUID: +GBsdtR/SRGkofsen4P8Zw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,300,1763452800"; 
   d="scan'208";a="219667309"
Received: from dnelso2-mobl.amr.corp.intel.com (HELO [10.125.110.20]) ([10.125.110.20])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2026 13:39:33 -0800
Message-ID: <7facce73-688a-408a-bcf9-f16d5ff36349@intel.com>
Date: Thu, 19 Feb 2026 14:39:32 -0700
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V7 19/19] famfs_fuse: Add documentation
To: John Groves <john@jagalactic.com>, John Groves <John@Groves.net>,
 Miklos Szeredi <miklos@szeredi.hu>, Dan Williams <dan.j.williams@intel.com>,
 Bernd Schubert <bschubert@ddn.com>,
 Alison Schofield <alison.schofield@intel.com>
Cc: John Groves <jgroves@micron.com>, John Groves <jgroves@fastmail.com>,
 Jonathan Corbet <corbet@lwn.net>, Vishal Verma <vishal.l.verma@intel.com>,
 Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 David Hildenbrand <david@kernel.org>, Christian Brauner
 <brauner@kernel.org>, "Darrick J . Wong" <djwong@kernel.org>,
 Randy Dunlap <rdunlap@infradead.org>, Jeff Layton <jlayton@kernel.org>,
 Amir Goldstein <amir73il@gmail.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Stefan Hajnoczi <shajnocz@redhat.com>, Joanne Koong
 <joannelkoong@gmail.com>, Josef Bacik <josef@toxicpanda.com>,
 Bagas Sanjaya <bagasdotme@gmail.com>, James Morse <james.morse@arm.com>,
 Fuad Tabba <tabba@google.com>, Sean Christopherson <seanjc@google.com>,
 Shivank Garg <shivankg@amd.com>, Ackerley Tng <ackerleytng@google.com>,
 Gregory Price <gourry@gourry.net>, Aravind Ramesh <arramesh@micron.com>,
 Ajay Joshi <ajayjoshi@micron.com>,
 "venkataravis@micron.com" <venkataravis@micron.com>,
 "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "nvdimm@lists.linux.dev" <nvdimm@lists.linux.dev>,
 "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
 "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
References: <0100019bd33b1f66-b835e86a-e8ae-443f-a474-02db88f7e6db-000000@email.amazonses.com>
 <20260118223420.92690-1-john@jagalactic.com>
 <0100019bd33ed831-615df3db-7b06-4137-9877-97c0d0fc0a05-000000@email.amazonses.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <0100019bd33ed831-615df3db-7b06-4137-9877-97c0d0fc0a05-000000@email.amazonses.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[38];
	FREEMAIL_CC(0.00)[micron.com,fastmail.com,lwn.net,intel.com,infradead.org,suse.cz,zeniv.linux.org.uk,kernel.org,gmail.com,huawei.com,redhat.com,toxicpanda.com,arm.com,google.com,amd.com,gourry.net,vger.kernel.org,lists.linux.dev];
	TAGGED_FROM(0.00)[bounces-77742-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dave.jiang@intel.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:mid,intel.com:dkim,infradead.org:email,huawei.com:email,groves.net:email]
X-Rspamd-Queue-Id: 99267162E8C
X-Rspamd-Action: no action



On 1/18/26 3:34 PM, John Groves wrote:
> From: John Groves <john@groves.net>
> 
> Add Documentation/filesystems/famfs.rst and update MAINTAINERS
> 
> Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
> Tested-by: Randy Dunlap <rdunlap@infradead.org>
> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
> Signed-off-by: John Groves <john@groves.net>
> ---
>  Documentation/filesystems/famfs.rst | 142 ++++++++++++++++++++++++++++
>  Documentation/filesystems/index.rst |   1 +
>  MAINTAINERS                         |   1 +
>  3 files changed, 144 insertions(+)
>  create mode 100644 Documentation/filesystems/famfs.rst
> 
> diff --git a/Documentation/filesystems/famfs.rst b/Documentation/filesystems/famfs.rst
> new file mode 100644
> index 000000000000..bf0c0e6574bb
> --- /dev/null
> +++ b/Documentation/filesystems/famfs.rst
> @@ -0,0 +1,142 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +.. _famfs_index:
> +
> +==================================================================
> +famfs: The fabric-attached memory file system
> +==================================================================
> +
> +- Copyright (C) 2024-2026 Micron Technology, Inc.
> +
> +Introduction
> +============
> +Compute Express Link (CXL) provides a mechanism for disaggregated or
> +fabric-attached memory (FAM). This creates opportunities for data sharing;
> +clustered apps that would otherwise have to shard or replicate data can

s/shard/share/?

> +share one copy in disaggregated memory.
> +
> +Famfs, which is not CXL-specific in any way, provides a mechanism for
> +multiple hosts to concurrently access data in shared memory, by giving it
> +a file system interface. With famfs, any app that understands files can
> +access data sets in shared memory. Although famfs supports read and write,
> +the real point is to support mmap, which provides direct (dax) access to
> +the memory - either writable or read-only.
> +
> +Shared memory can pose complex coherency and synchronization issues, but
> +there are also simple cases. Two simple and eminently useful patterns that
> +occur frequently in data analytics and AI are:
> +
> +* Serial Sharing - Only one host or process at a time has access to a file
> +* Read-only Sharing - Multiple hosts or processes share read-only access
> +  to a file
> +
> +The famfs fuse file system is part of the famfs framework; user space
> +components [1] handle metadata allocation and distribution, and provide a
> +low-level fuse server to expose files that map directly to [presumably
> +shared] memory.
> +
> +The famfs framework manages coherency of its own metadata and structures,
> +but does not attempt to manage coherency for applications.
> +
> +Famfs also provides data isolation between files. That is, even though
> +the host has access to an entire memory "device" (as a devdax device), apps
> +cannot write to memory for which the file is read-only, and mapping one
> +file provides isolation from the memory of all other files. This is pretty
> +basic, but some experimental shared memory usage patterns provide no such
> +isolation.
> +
> +Principles of Operation
> +=======================
> +
> +Famfs is a file system with one or more devdax devices as a first-class
> +backing device(s). Metadata maintenance and query operations happen
> +entirely in user space.
> +
> +The famfs low-level fuse server daemon provides file maps (fmaps) and
> +devdax device info to the fuse/famfs kernel component so that
> +read/write/mapping faults can be handled without up-calls for all active
> +files.
> +
> +The famfs user space is responsible for maintaining and distributing
> +consistent metadata. This is currently handled via an append-only
> +metadata log within the memory, but this is orthogonal to the fuse/famfs
> +kernel code.
> +
> +Once instantiated, "the same file" on each host points to the same shared
> +memory, but in-memory metadata (inodes, etc.) is ephemeral on each host
> +that has a famfs instance mounted. Use cases are free to allow or not
> +allow mutations to data on a file-by-file basis.
> +
> +When an app accesses a data object in a famfs file, there is no page cache
> +involvement. The CPU cache is loaded directly from the shared memory. In
> +some use cases, this is an enormous reduction read amplification compared

"reduction in read amplification"?

> +to loading an entire page into the page cache.
> +
> +
> +Famfs is Not a Conventional File System
> +---------------------------------------
> +
> +Famfs files can be accessed by conventional means, but there are
> +limitations. The kernel component of fuse/famfs is not involved in the
> +allocation of backing memory for files at all; the famfs user space
> +creates files and responds as a low-level fuse server with fmaps and
> +devdax device info upon request.
> +
> +Famfs differs in some important ways from conventional file systems:
> +
> +* Files must be pre-allocated by the famfs framework; allocation is never
> +  performed on (or after) write.
> +* Any operation that changes a file's size is considered to put the file
> +  in an invalid state, disabling access to the data. It may be possible to
> +  revisit this in the future. (Typically the famfs user space can restore
> +  files to a valid state by replaying the famfs metadata log.)
> +
> +Famfs exists to apply the existing file system abstractions to shared
> +memory so applications and workflows can more easily adapt to an
> +environment with disaggregated shared memory.
> +
> +Memory Error Handling
> +=====================
> +
> +Possible memory errors include timeouts, poison and unexpected

s/poison and/poison, and/

DJ

> +reconfiguration of an underlying dax device. In all of these cases, famfs
> +receives a call from the devdax layer via its iomap_ops->notify_failure()
> +function. If any memory errors have been detected, access to the affected
> +daxdev is disabled to avoid further errors or corruption.
> +
> +In all known cases, famfs can be unmounted cleanly. In most cases errors
> +can be cleared by re-initializing the memory - at which point a new famfs
> +file system can be created.
> +
> +Key Requirements
> +================
> +
> +The primary requirements for famfs are:
> +
> +1. Must support a file system abstraction backed by sharable devdax memory
> +2. Files must efficiently handle VMA faults
> +3. Must support metadata distribution in a sharable way
> +4. Must handle clients with a stale copy of metadata
> +
> +The famfs kernel component takes care of 1-2 above by caching each file's
> +mapping metadata in the kernel.
> +
> +Requirements 3 and 4 are handled by the user space components, and are
> +largely orthogonal to the functionality of the famfs kernel module.
> +
> +Requirements 3 and 4 cannot be met by conventional fs-dax file systems
> +(e.g. xfs) because they use write-back metadata; it is not valid to mount
> +such a file system on two hosts from the same in-memory image.
> +
> +
> +Famfs Usage
> +===========
> +
> +Famfs usage is documented at [1].
> +
> +
> +References
> +==========
> +
> +- [1] Famfs user space repository and documentation
> +      https://github.com/cxl-micron-reskit/famfs
> diff --git a/Documentation/filesystems/index.rst b/Documentation/filesystems/index.rst
> index f4873197587d..e6fb467c1680 100644
> --- a/Documentation/filesystems/index.rst
> +++ b/Documentation/filesystems/index.rst
> @@ -89,6 +89,7 @@ Documentation for filesystem implementations.
>     ext3
>     ext4/index
>     f2fs
> +   famfs
>     gfs2/index
>     hfs
>     hfsplus
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 6f8a7c813c2f..43141ee4fd4e 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -10385,6 +10385,7 @@ M:	John Groves <John@Groves.net>
>  L:	linux-cxl@vger.kernel.org
>  L:	linux-fsdevel@vger.kernel.org
>  S:	Supported
> +F:	Documentation/filesystems/famfs.rst
>  F:	fs/fuse/famfs.c
>  F:	fs/fuse/famfs_kfmap.h
>  



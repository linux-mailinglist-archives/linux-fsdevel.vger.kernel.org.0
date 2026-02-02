Return-Path: <linux-fsdevel+bounces-76074-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mDPUCvfkgGleCAMAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76074-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 02 Feb 2026 18:55:03 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 31FC7CFD0B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 02 Feb 2026 18:55:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id DD0B03009816
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Feb 2026 17:54:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E89D389DEF;
	Mon,  2 Feb 2026 17:54:27 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49FC338946A;
	Mon,  2 Feb 2026 17:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770054866; cv=none; b=QtyhFMJkREHhZkeYQqP8HXrfcp4AXE4FYv/GvoqF+pyN+82Uza+U+LVaLu1VerJ90mXnVSo5GmDUTRGQC3LWCcnnAkXijkxpboou9YQ0rDVmmyhHDObPeUsF+coad3m4M/8xnNLlnDux4LefH7W7RnxihzUPqEw7F7HZwfSPuQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770054866; c=relaxed/simple;
	bh=+YVxmF2myapnZJzWAxzkwc1WbYzrAwrO+lR9xUfX84s=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=u/M95qqqvyT5damML9wy/m6XgzvtQ4uk9xR83bD4h0QjzSfsX0EpRUwwLNhyQy8EOFujk4HaeZtUT5nEFSldNbwPUrHJdYn9dpSkOpr+B7EOTpSIqMavmSoAf2mxdZgd339Q4emwZPN0e31ealumgnGI4BgVuhasL2WKvAFTwyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.83])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4f4Z3Q42MMzHnGgg;
	Tue,  3 Feb 2026 01:53:22 +0800 (CST)
Received: from dubpeml500005.china.huawei.com (unknown [7.214.145.207])
	by mail.maildlp.com (Postfix) with ESMTPS id 546A140572;
	Tue,  3 Feb 2026 01:54:20 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml500005.china.huawei.com
 (7.214.145.207) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 2 Feb
 2026 17:54:19 +0000
Date: Mon, 2 Feb 2026 17:54:17 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Gregory Price <gourry@gourry.net>
CC: <linux-mm@kvack.org>, <linux-cxl@vger.kernel.org>,
	<nvdimm@lists.linux.dev>, <linux-fsdevel@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<kernel-team@meta.com>, <dave@stgolabs.net>, <dave.jiang@intel.com>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<ira.weiny@intel.com>, <dan.j.williams@intel.com>, <willy@infradead.org>,
	<jack@suse.cz>, <terry.bowman@amd.com>, <john@jagalactic.com>
Subject: Re: [PATCH 4/9] drivers/cxl,dax: add dax driver mode selection for
 dax regions
Message-ID: <20260202175417.00000abe@huawei.com>
In-Reply-To: <20260129210442.3951412-5-gourry@gourry.net>
References: <20260129210442.3951412-1-gourry@gourry.net>
	<20260129210442.3951412-5-gourry@gourry.net>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100009.china.huawei.com (7.191.174.83) To
 dubpeml500005.china.huawei.com (7.214.145.207)
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.04 / 15.00];
	DMARC_POLICY_QUARANTINE(1.50)[huawei.com : SPF not aligned (relaxed), No valid DKIM,quarantine];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	TAGGED_FROM(0.00)[bounces-76074-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FROM_HAS_DN(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jonathan.cameron@huawei.com,linux-fsdevel@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[jagalactic.com:email,gourry.net:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,huawei.com:mid,huawei.com:email]
X-Rspamd-Queue-Id: 31FC7CFD0B
X-Rspamd-Action: no action

On Thu, 29 Jan 2026 16:04:37 -0500
Gregory Price <gourry@gourry.net> wrote:

> CXL regions may wish not to auto-configure their memory as dax kmem,
> but the current plumbing defaults all cxl-created dax devices to the
> kmem driver.  This exposes them to hotplug policy, even if the user
> intends to use the memory as a dax device.
> 
> Add plumbing to allow CXL drivers to select whether a DAX region should
> default to kmem (DAXDRV_KMEM_TYPE) or device (DAXDRV_DEVICE_TYPE).
> 
> Add a 'dax_driver' field to struct cxl_dax_region and update
> devm_cxl_add_dax_region() to take a dax_driver_type parameter.
> 
> In drivers/dax/cxl.c, the IORESOURCE_DAX_KMEM flag used by dax driver
> matching code is now set conditionally based on dax_region->dax_driver.
> 
> Exports `enum dax_driver_type` to linux/dax.h for use in the cxl driver.
> 
> All current callers pass DAXDRV_KMEM_TYPE for backward compatibility.
> 
> Cc: John Groves <john@jagalactic.com>
> Signed-off-by: Gregory Price <gourry@gourry.net>
LGTM
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>




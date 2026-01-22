Return-Path: <linux-fsdevel+bounces-75105-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6L17EHxTcmnpfAAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75105-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jan 2026 17:42:36 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E0FC06A2D1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jan 2026 17:42:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4154E3164B29
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jan 2026 16:33:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EF54353ED7;
	Thu, 22 Jan 2026 16:17:04 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECBAC3E280A;
	Thu, 22 Jan 2026 16:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769098620; cv=none; b=AxGRC2Le2P8bMSVM1Kn1N9wvIn0MI7ICe97Jwy0DQ6vQKYdIEn8A3TpThEThf8q8EWtTGA3pN2rlFnlRuQNghckQGio5X72H6SgfaIUozjLLZGq59YnY4H7vmVFVGpExH8RkmWsek2ZMFnrCbwW+oik7oE0crO/kB9jQo9oegLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769098620; c=relaxed/simple;
	bh=XKkCajLL25icKDNtpCFBJmCpoEN/dxlJmGiEXPdER9Q=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=b7esIJGLqJmiFuiTFB7lyhiIZC2WGmcAcBD4bNZ//ABoyswaMzGfc84RNqgiXRCjoAfhuISYPJOYuTZFWL8Pbps1EnxTnSuOp/pusv1EvS4R77U+VYv+EqUrkTeQqcECzzKgOLefNOo7gQlKLzUR2ypUuN5Mlx+CvTlPNMGVsnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.150])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4dxmQQ2QrwzJ467l;
	Fri, 23 Jan 2026 00:16:14 +0800 (CST)
Received: from dubpeml500005.china.huawei.com (unknown [7.214.145.207])
	by mail.maildlp.com (Postfix) with ESMTPS id 494EF4056B;
	Fri, 23 Jan 2026 00:16:42 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml500005.china.huawei.com
 (7.214.145.207) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 22 Jan
 2026 16:16:41 +0000
Date: Thu, 22 Jan 2026 16:16:39 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<nvdimm@lists.linux.dev>, <linux-fsdevel@vger.kernel.org>,
	<linux-pm@vger.kernel.org>, Ard Biesheuvel <ardb@kernel.org>, "Alison
 Schofield" <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Yazen Ghannam <yazen.ghannam@amd.com>, "Dave
 Jiang" <dave.jiang@intel.com>, Davidlohr Bueso <dave@stgolabs.net>, "Matthew
 Wilcox" <willy@infradead.org>, Jan Kara <jack@suse.cz>, "Rafael J . Wysocki"
	<rafael@kernel.org>, Len Brown <len.brown@intel.com>, Pavel Machek
	<pavel@kernel.org>, Li Ming <ming.li@zohomail.com>, Jeff Johnson
	<jeff.johnson@oss.qualcomm.com>, Ying Huang <huang.ying.caritas@gmail.com>,
	Yao Xingtao <yaoxt.fnst@fujitsu.com>, "Peter Zijlstra"
	<peterz@infradead.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Nathan Fontenot <nathan.fontenot@amd.com>, Terry Bowman
	<terry.bowman@amd.com>, Robert Richter <rrichter@amd.com>, Benjamin Cheatham
	<benjamin.cheatham@amd.com>, Zhijian Li <lizhijian@fujitsu.com>, Borislav
 Petkov <bp@alien8.de>, Tomasz Wolski <tomasz.wolski@fujitsu.com>
Subject: Re: [PATCH v5 1/7] dax/hmem: Request cxl_acpi and cxl_pci before
 walking Soft Reserved ranges
Message-ID: <20260122161639.00004dd3@huawei.com>
In-Reply-To: <20260122045543.218194-2-Smita.KoralahalliChannabasappa@amd.com>
References: <20260122045543.218194-1-Smita.KoralahalliChannabasappa@amd.com>
	<20260122045543.218194-2-Smita.KoralahalliChannabasappa@amd.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500009.china.huawei.com (7.191.174.84) To
 dubpeml500005.china.huawei.com (7.214.145.207)
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.54 / 15.00];
	DMARC_POLICY_QUARANTINE(1.50)[huawei.com : SPF not aligned (relaxed), No valid DKIM,quarantine];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-75105-lists,linux-fsdevel=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[32];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.linux.dev,kernel.org,intel.com,amd.com,stgolabs.net,infradead.org,suse.cz,zohomail.com,oss.qualcomm.com,gmail.com,fujitsu.com,linuxfoundation.org,alien8.de];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jonathan.cameron@huawei.com,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[huawei.com:mid,huawei.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email,amd.com:email]
X-Rspamd-Queue-Id: E0FC06A2D1
X-Rspamd-Action: no action

On Thu, 22 Jan 2026 04:55:37 +0000
Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com> wrote:

> From: Dan Williams <dan.j.williams@intel.com>
> 
> Ensure cxl_acpi has published CXL Window resources before HMEM walks Soft
> Reserved ranges.
> 
> Replace MODULE_SOFTDEP("pre: cxl_acpi") with an explicit, synchronous
> request_module("cxl_acpi"). MODULE_SOFTDEP() only guarantees eventual
> loading, it does not enforce that the dependency has finished init
> before the current module runs. This can cause HMEM to start before
> cxl_acpi has populated the resource tree, breaking detection of overlaps
> between Soft Reserved and CXL Windows.
> 
> Also, request cxl_pci before HMEM walks Soft Reserved ranges. Unlike
> cxl_acpi, cxl_pci attach is asynchronous and creates dependent devices
> that trigger further module loads. Asynchronous probe flushing
> (wait_for_device_probe()) is added later in the series in a deferred
> context before HMEM makes ownership decisions for Soft Reserved ranges.
> 
> Add an additional explicit Kconfig ordering so that CXL_ACPI and CXL_PCI
> must be initialized before DEV_DAX_HMEM. This prevents HMEM from consuming
> Soft Reserved ranges before CXL drivers have had a chance to claim them.
> 
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>


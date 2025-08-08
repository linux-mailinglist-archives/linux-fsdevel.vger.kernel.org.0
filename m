Return-Path: <linux-fsdevel+bounces-57029-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CBB4B1E18E
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Aug 2025 07:09:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7BBD56262FE
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Aug 2025 05:09:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA5DE1E1C02;
	Fri,  8 Aug 2025 05:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="dDwFfJdz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF49416F0FE
	for <linux-fsdevel@vger.kernel.org>; Fri,  8 Aug 2025 05:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754629745; cv=none; b=k3MUGbm50ltHa8eZES06ojUDVust/ucH30Ri7GhzWgHvPIjrOEv8ldqqvPmcGmdaSjMrmV76uJAlBNhmokGixOFnIyOrMHuEHr9PdC2I/lD92u1YXVFiQF610ljav6Wab9rUz+F3N5Z0FJzzQ/6NUmZK8SrvNBiRfb02KnUtg1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754629745; c=relaxed/simple;
	bh=YsLMrkf+1ivzC8WoJA/+R7/IB2icXE+D3ZYrrS1/KPI=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:
	 References; b=VLkdNSAkphCDR8TGd94sIsV/jXHY9Wo3M4rR5QzyURxDJAykbln7/s4XnAVKhNqEOeTMSVSd6QLNTy18K+I9Upe8WGC9Ku+cVURzGXAT6HQZdhLr4QLmJ6V5N/xKAQAlTFTsjjS10rRhV16+Y0Dpkb/vvofEKVLXf1XK5/HDiQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=dDwFfJdz; arc=none smtp.client-ip=203.254.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas2p1.samsung.com (unknown [182.195.41.53])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20250808050854epoutp041361b34f912b9885bd5e062f38eb2eae~ZsnJ4dbwi0727207272epoutp04r
	for <linux-fsdevel@vger.kernel.org>; Fri,  8 Aug 2025 05:08:54 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20250808050854epoutp041361b34f912b9885bd5e062f38eb2eae~ZsnJ4dbwi0727207272epoutp04r
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1754629734;
	bh=u3huiNdu0rRAya2M/kre/HuzuylCu0m0RuGmkyeYlU4=;
	h=From:To:Subject:Date:References:From;
	b=dDwFfJdznR7YeHoHrN0tY0n4xOehu7TNaS/C1Krg+K/mam2WC2hxeImS6gc5wxpih
	 mzW522mqaPZANzADwhgE5rXQjouEQMIzu2Br1fXwng6mHB8fXmWs+nyfQWEU1mKU5y
	 k04L8FnZUu5dMdiAHKoJXbJJwPTz/V7jnkz/1eCw=
Received: from epsnrtp02.localdomain (unknown [182.195.42.154]) by
	epcas2p2.samsung.com (KnoxPortal) with ESMTPS id
	20250808050854epcas2p2df1b856b6a98c0feaced3206054adf63~ZsnJXsUMd3201832018epcas2p2W;
	Fri,  8 Aug 2025 05:08:54 +0000 (GMT)
Received: from epcas2p1.samsung.com (unknown [182.195.36.89]) by
	epsnrtp02.localdomain (Postfix) with ESMTP id 4bysWT2W8fz2SSKY; Fri,  8 Aug
	2025 05:08:53 +0000 (GMT)
Received: from epsmtip1.samsung.com (unknown [182.195.34.30]) by
	epcas2p4.samsung.com (KnoxPortal) with ESMTPA id
	20250808050852epcas2p41faca5b3fd8a7bc18cc173ce44650bff~ZsnIKI84i0265402654epcas2p4F;
	Fri,  8 Aug 2025 05:08:52 +0000 (GMT)
Received: from KORCO118546 (unknown [12.36.150.57]) by epsmtip1.samsung.com
	(KnoxPortal) with ESMTPA id
	20250808050852epsmtip12823c61b1c9681d1f46a0d01cd41bd14~ZsnIFlj6d1991519915epsmtip1D;
	Fri,  8 Aug 2025 05:08:52 +0000 (GMT)
From: "hoyoung seo" <hy50.seo@samsung.com>
To: <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<alim.akhtar@samsung.com>, <avri.altman@wdc.com>, <jejb@linux.ibm.com>,
	<martin.petersen@oracle.com>, <beanhuo@micron.com>, <bvanassche@acm.org>,
	<kwangwon.min@samsung.com>, <kwmad.kim@samsung.com>, <cpgs@samsung.com>,
	<h10.kim@samsung.com>, <linux-fsdevel@vger.kernel.org>, <hch@infradead.org>
Subject: Questions about dquota write by writeback in the context of storage
 shortage
Date: Fri, 8 Aug 2025 14:08:52 +0900
Message-ID: <000001dc0822$886fc990$994f5cb0$@samsung.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AdwIIoPDH3+1YAVzRxe4KvlMHLhSQA==
Content-Language: ko
X-CMS-MailID: 20250808050852epcas2p41faca5b3fd8a7bc18cc173ce44650bff
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
X-CPGSPASS: Y
cpgsPolicy: CPGSC10-234,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250808050852epcas2p41faca5b3fd8a7bc18cc173ce44650bff
References: <CGME20250808050852epcas2p41faca5b3fd8a7bc18cc173ce44650bff@epcas2p4.samsung.com>

Hi,

When the storage usage was full(99%), the following panic_on_warm occurred.

In this case, wb_writeback function used writeback workqeue included WQ_MEM=
_RECLAIM flag.
And wb_writeback function called f2fs_write_single_data_page for updating d=
quot(Write checkpoint to reclaim prefree segments)
In this case, dquot_writback_dquots function use events_unbound workqueue.
It is not include WQ_MEM_RECLAIM flag.
So occurred this problem.
First of all, I don't think this situation should be created, but I don't k=
now why it's like this
So I guess quota_release_workfn function should use workqueue with WQ_MEM_R=
ECLAIM flag, but is this the right solution?


workqueue: WQ_MEM_RECLAIM writeback:wb_workfn is flushing =21WQ_MEM_RECLAIM=
 events_unbound:quota_release_workfn
Call trace:
  check_flush_dependency+0x160/0x16c
  __flush_work+0x168/0x738
  flush_delayed_work+0x58/0x70
  dquot_writeback_dquots+0x90/0x4bc
  f2fs_do_quota_sync+0x120/0x284
  f2fs_write_checkpoint+0x58c/0xe18
  f2fs_gc+0x3e8/0xd78
  f2fs_balance_fs+0x204/0x284
  f2fs_write_single_data_page+0x700/0xaf0
  f2fs_write_data_pages+0xe94/0x15bc
  do_writepages+0x170/0x3f8
  __writeback_single_inode+0xa0/0x8c4
  writeback_sb_inodes+0x2ac/0x708
  __writeback_inodes_wb+0xc0/0x118
  wb_writeback+0x1f4/0x664
  wb_workfn+0x62c/0x900

Thanks.



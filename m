Return-Path: <linux-fsdevel+bounces-22566-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 932A4919C3A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Jun 2024 02:56:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 071E4B22B31
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Jun 2024 00:56:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 194B51C6BE;
	Thu, 27 Jun 2024 00:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="RlmP65Ek"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2062.outbound.protection.outlook.com [40.107.220.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E865517C6A;
	Thu, 27 Jun 2024 00:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719449700; cv=fail; b=DeiA5EzD3hcbvqv8FGOGwOqOUfE1AJ26gcr/EL+RgBna0G14PLQDsJd4aTbb4C44BdMPNCD6V8JncxCq6Qu2oQtLUzh5pofCxOPMFwIxrwHbb+yNl0vhRuYPEcnKYJcW+YB2hker0LEC71AbcVf5P0AP9MTN6i8Zm5TZJohQjz4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719449700; c=relaxed/simple;
	bh=nW45EYVNIPVWPNgDLm7Kfe6OYAFUqOEE7mbQN7DBBHo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=f/iJBxzRfoPPlpeKutghZUezv2lUrHaPOCWJZJmMWhGN1IvTyxHqoQbQ7he99j26+nTQ/Bji9NzOU+8Erzj7DyRwUlZqIbPG8aqzWcDAqn1jcFnV9LJKlubZxj3XJHwyjKor4X+LaHkvIbJQf+hjMJMDPEAsOqY03No7D2M2thM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=RlmP65Ek; arc=fail smtp.client-ip=40.107.220.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J8ootAyD+RRQDwLwUyM5oBhoGdunhvskFUj8GZnBdF1Z7pTQ9uaAaAzljuDMhZDme1aTExbO36nqTYWNzoW7t8EGDzuqDkQC9S9CjRrkN/ZpCyHfbpuhgi98p3VJNciJQB06u4/LS0FIqeNN2UMEpD9jpmImEehzNWpTiBDnM09ppMuMMUFglwulH08jP6CKQZq4Fhkge5vw9h7KG9fCO92FnIEN6fljL7LesUkrM/+5qJENkL/pYGWb7KLbFKO+7im06uIR0hJ3QdZrCADBn/OQfbv/bB3q60LUfhtPQg9kV4PZpIDO09vxN7qQxeOt9nAu/O69mWpP7MJHdNP3Bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RdaMrNdetBipLgCehlxgBb33ehvAEhIIAeY4qsi3ae0=;
 b=a+1n3uboHk+90sJxlZlkZor8T/XkxkfbGPpHvlhAofQ920yg8eFb7gl49TsQcroORDgrmhsTeZxurU3Y/jmt26VITtL8+T6BtwL4BRmxcj12sBAADq3SWhKzqI8ObWpiV+zWnMqfbNt5Mvro80vQZL704ac9zeltWVk7xfKBDbHZ62KxnbYshTeKVwsl32FDKHuLcADYSHfvq9EnsoRxMslP1FPTJIWlQHUvT+LznXwmnc2sovtETfe+8Yss+uG4PV1eAFEuMVCf/2fClVZscSJETNrX3t9TAiXOmw+7qIXGuFDI+hvXel8IzIV9LKXrrN31eSPD6nn+yI9JTR07zQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RdaMrNdetBipLgCehlxgBb33ehvAEhIIAeY4qsi3ae0=;
 b=RlmP65Ek1FtwFweaFCkSQpi6VggaOAHiotdxpEFkCL0sWCkKG07A/7I8L7Wm8L27lTW0AYjw/Li9eEBlQdyKyPe+o7U2vz6dqybNJO3DAs4pZouHr10PEk/poL5h0SHXe1h/WWB7c7vexMIqFmZFKa9J4TTrucUcgf5cun9bAYcXqmbkIaHAXujHxUyWngKbNoP/ahgzciRzWbVakow82YC3zPuV+MCGUbAm8nMFiCDd9E56RFw7GkBSnk1Mf2OdsbDs+nGHLgJw2k5PMlcIuThlUP3UOxQUEdGNj1BsU46T/Y91Wz9pOfc4GNWT3Vpi2eOsnjbuFEGZalvs+60hMw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7726.namprd12.prod.outlook.com (2603:10b6:8:130::6) by
 MW6PR12MB7071.namprd12.prod.outlook.com (2603:10b6:303:238::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7698.32; Thu, 27 Jun 2024 00:54:54 +0000
Received: from DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe]) by DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe%6]) with mapi id 15.20.7698.025; Thu, 27 Jun 2024
 00:54:54 +0000
From: Alistair Popple <apopple@nvidia.com>
To: dan.j.williams@intel.com,
	vishal.l.verma@intel.com,
	dave.jiang@intel.com,
	logang@deltatee.com,
	bhelgaas@google.com,
	jack@suse.cz,
	jgg@ziepe.ca
Cc: catalin.marinas@arm.com,
	will@kernel.org,
	mpe@ellerman.id.au,
	npiggin@gmail.com,
	dave.hansen@linux.intel.com,
	ira.weiny@intel.com,
	willy@infradead.org,
	djwong@kernel.org,
	tytso@mit.edu,
	linmiaohe@huawei.com,
	david@redhat.com,
	peterx@redhat.com,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linuxppc-dev@lists.ozlabs.org,
	nvdimm@lists.linux.dev,
	linux-cxl@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	jhubbard@nvidia.com,
	hch@lst.de,
	david@fromorbit.com,
	Alistair Popple <apopple@nvidia.com>
Subject: [PATCH 04/13] fs/dax: Add dax_page_free callback
Date: Thu, 27 Jun 2024 10:54:19 +1000
Message-ID: <e626eda568267e1f86d5c30c24bc62474b45f6c3.1719386613.git-series.apopple@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.66009f59a7fe77320d413011386c3ae5c2ee82eb.1719386613.git-series.apopple@nvidia.com>
References: <cover.66009f59a7fe77320d413011386c3ae5c2ee82eb.1719386613.git-series.apopple@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SY6PR01CA0051.ausprd01.prod.outlook.com
 (2603:10c6:10:e9::20) To DS0PR12MB7726.namprd12.prod.outlook.com
 (2603:10b6:8:130::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7726:EE_|MW6PR12MB7071:EE_
X-MS-Office365-Filtering-Correlation-Id: a501ca68-d6a0-4a5e-d600-08dc9643c1dc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?yhKbID0mpY5O1E0F7jhhF1wN+tTNgF75ty/G7gia7/PQRbzlllDdygoS7abS?=
 =?us-ascii?Q?g20eqhDKeeJAalcGWxLbhQWV/03nHOg6Rj64HOvFDynnm8ZTlF1nOda2+1eM?=
 =?us-ascii?Q?0/6bCg4tpxqZOcMLx4Pmt5LPD4E5bztx4AAThCds4PZlMF1vQ7i3oa0AczZd?=
 =?us-ascii?Q?AxXrbDa5SMALVZRnRHJtvfusFfLjipjr37kY1knTe6ufLzztUrc2DczcBNaS?=
 =?us-ascii?Q?bV1rZJggnY7f/CDRGJYu9dZNA+uaT507+EeA19IjnGVdgGdmedyUX8bY1wny?=
 =?us-ascii?Q?JroUINb5qa3teIxPT9U91K9Ofyxss9FoR+qOykYVq6m/uN5Dl0B1MKhJAsMy?=
 =?us-ascii?Q?L905uLQs0vpzDEcACZNA3f8IKib8SXbJ/0yNLxHEu4uBIQJD5+vdd1G2CtW9?=
 =?us-ascii?Q?dpbE4XcccPh99dLd3UUGciZvefrVnYlDtZvUEdokrwp1SFNya2kNWXeeMjVh?=
 =?us-ascii?Q?am0md0y4IfLxKQry6T8RSeZm4ID6uh778AbK0GyNzOZ9F9Eu4OOWeWOtXJUX?=
 =?us-ascii?Q?zZ212X+zj75ZO/GdQ7oCcEZo+czEjgGhbXaTnT9hQON7NNhHPo0H67XZlFWW?=
 =?us-ascii?Q?zR5wvMG9zhtkwb5RU5gHHOI88+UxwMHLC51fTaDtcodRIuMpGL3Gi/1E+cSy?=
 =?us-ascii?Q?aH+LbNDAPTlIPymnnQsCgN7Qf54dzKMSGr1/1uRTMG16EM/Yt2igGgn1+4/6?=
 =?us-ascii?Q?j5I44xL+1k0K1XwC2nTODXd1GrNsw8Mjb42KRB1KE3AsgwIGDfsmoC3/syll?=
 =?us-ascii?Q?H/xVGE1TG8N3Z9jIPHaw1YRFdkKBFsKhnv/E062opJxgGy6aFEX4XchVQt8W?=
 =?us-ascii?Q?lcklnIPyJ64ebCl+JDLqNljQJ1Zl+JR3BhhXN0Ll6B/baeMmq4BrGNetWuXw?=
 =?us-ascii?Q?rMhRsqVA+4bLVOVov30J21GgguFpSjfNDErjDc0mocJ64ezRkP638/wINDNH?=
 =?us-ascii?Q?iLSZwpjXN9W3YhWJqOem6A4kcFBs6B3BNeeSjkHHSDZrXp3GiOlkg42FnJrZ?=
 =?us-ascii?Q?hC4pk9SkMUx48v6oEqw2vG3IEzFnaZ9qBeiJnUnpKiIaOyxk5B4Ff0QxwrIQ?=
 =?us-ascii?Q?wCUjlFZBwD57ED9010YFhqg5QVAGbnoSPFbHRlt01alLyjgGIvn45vFdlQZ2?=
 =?us-ascii?Q?MiRG99xWHs8z0RLHY5EXf/oA3mgwFzWzpWN86d2ONOu70ODqQeX3JC3OTzgL?=
 =?us-ascii?Q?r4trosIk3FDtcFjAnF4Sl2eOhQOriqpkWB3Z+F7z3ZJev1nUCjx/VrksVuPK?=
 =?us-ascii?Q?MVv6Q8UPPiydsi7bj7hnWvyMAXaaEKJ00DDOf3IWvmSlmXn1w6qfp2vZ+rHo?=
 =?us-ascii?Q?pGaMFN1AnW13aMjkgNcgmmxGEmvAF6cwlSVY+qL6rCXNag=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB7726.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?hqAKZ2kOGKIRQRgT3v95sa3KVSFkwhYhSkYqTnDmiRAmTyGCR2x14IOexjIy?=
 =?us-ascii?Q?Dcqu1udqGqKrATThwp9Blq35yM4gSpgCVTbN2k9RmGxayznt1MfJRtq0rFLS?=
 =?us-ascii?Q?0TyQvPBTRtTezAcsK9HzjlVpcYQjVGYiGjYSysSbB5eh9xFE8pE/xFmr8aHN?=
 =?us-ascii?Q?7Zmw1FKpkJvJjs9LS62yUgwCq6dYgYlVX0309fcFB69BD9uJxaYmgrxgRDPQ?=
 =?us-ascii?Q?p7T+z2aQp83FT+OA+myLMtXX4WrFB/5X5lq02OZuh1PrvPMQbzUiaOs6aVVm?=
 =?us-ascii?Q?wMyl0qOxLTuFy9dfll6050QGiA1i89DQcofvxUI8/TYg9Bytv7sKM7Nc8U9q?=
 =?us-ascii?Q?uLTgQ6q1hhIFM3Jj8LfK2i9bazW6xF5Uje6uvHH0nWVJZM3ymp0CND48zr0+?=
 =?us-ascii?Q?HgFqaooziX+9PkKELXutAkLfz7/GRJ4VcTp1X4n+eLHCs7laYFsidYW5vvR9?=
 =?us-ascii?Q?1yM0bRcLBiKcrtj/XatsAPXjbjC446+M8byhEv9tieELr21wtrKRj1BtddTz?=
 =?us-ascii?Q?RpZ88ckzmnfMxecoMo6nXRbZh21nQlKeDZp9Os5IVnD9WUO9tq+cxK7S3kPi?=
 =?us-ascii?Q?0cqzVqYSqhfG2bPYInMshGXUrhoc/3PZ1te8YjXCG98iC/q+SVmSO7hOHB+b?=
 =?us-ascii?Q?RNE7wu9Q6O+aVh30Lf1VgASJ2TZ5XnKtnZXI5VPmRGvUJwft2b5v/Jfve6BX?=
 =?us-ascii?Q?IHQi4uS7zJ8IjhyJyRWv1C8jMqnTjGqlTnoJBFvAKVu8Ec/VIxRKtRdxwIVj?=
 =?us-ascii?Q?DiPxHxBx3ySfqm7mUGJuyTYA6EhYNFUXJoAu3c3p7gsAZCDPcuz1w6DBp2J1?=
 =?us-ascii?Q?tHd2xvO4Ql2UaVspEJk4RfLjBk0OncMdduB/4ZJXeNxD2GO4CoIeodMlLI0x?=
 =?us-ascii?Q?Z0AgcIGLJk7perX2FuS0T5EqNW+kfsZx847IVt6D3TYAsOabXPo7++xIcWNJ?=
 =?us-ascii?Q?2di/ck2JQ43CYu8EaqvrHl9XXczWFNS9btOUvj3BjiBbj5tW1j8ZSg26a6xB?=
 =?us-ascii?Q?v+pfem3UV/TVm0T9pWk5y4Ol5fuMsc2Sx8crMvEgKztQCNCO1zQb6kIfxHTp?=
 =?us-ascii?Q?Zlxc0pE71RaIpGby/xxMxOOPpZKUw/6y58pP46beZfHkE+17Py2M5POY7tnG?=
 =?us-ascii?Q?8m+/hivHjKHQDsY8ehquNey8CNOAbsLZ+R6cV5lN9V9m0w0S2j9P7TzpLBOJ?=
 =?us-ascii?Q?H22ZYusCQNXNpPWYPuw3aCOpwJbLQ/2oo0is+F/Ltvo934qGPLSk5ax/EFP1?=
 =?us-ascii?Q?tCQHNLFHrE7VxeHBpu6QBUmGz9mkejphg0xyHXtvqzcsnS9sQTBbPo1Uw8JD?=
 =?us-ascii?Q?JzZdhA2ThLmcB7sgKgwABZN3aC2DY0ytkHwBvfVihp6R7Bd/ethAcEL/RcwC?=
 =?us-ascii?Q?pkIpJwELdS9jK90Lk23a85CM12p4NX4M739U4w2XnSqnSPXjcn/cksclfyAb?=
 =?us-ascii?Q?Shd5XeuhW6bmkGkOl1mCxW9oPQyXPwMad/e+3xXkVWsSym+WbUOwYrVPcha0?=
 =?us-ascii?Q?2t0aJFh5aBlJdjrxiwNho7qEX3+2ZfiOHqzR2uTXXnEbhgSzBEwhp7TUwLyS?=
 =?us-ascii?Q?AcB4nuN25UdLcDFF/ayJ2vAezHLZUClA+wQsOoey?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a501ca68-d6a0-4a5e-d600-08dc9643c1dc
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7726.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2024 00:54:54.0440
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jJ7K/ej0IRlpqr8wppnObRDmF9WRwpr/K80S3Lbu/T8ShxlvDA3eRpdOaq1DBJRkum4N/OI8hI6G0JrRi/6P0w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB7071

When a fs dax page is freed it has to notify filesystems that the page
has been unpinned/unmapped and is free. Currently this involves
special code in the page free paths to detect a transition of refcount
from 2 to 1 and to call some fs dax specific code.

A future change will require this to happen when the page refcount
drops to zero. In this case we can use the existing
pgmap->ops->page_free() callback so wire that up for all devices that
support FS DAX (nvdimm and virtio).

Signed-off-by: Alistair Popple <apopple@nvidia.com>
---
 drivers/nvdimm/pmem.c | 1 +
 fs/dax.c              | 6 ++++++
 fs/fuse/virtio_fs.c   | 5 +++++
 include/linux/dax.h   | 1 +
 4 files changed, 13 insertions(+)

diff --git a/drivers/nvdimm/pmem.c b/drivers/nvdimm/pmem.c
index 598fe2e..cafadd0 100644
--- a/drivers/nvdimm/pmem.c
+++ b/drivers/nvdimm/pmem.c
@@ -444,6 +444,7 @@ static int pmem_pagemap_memory_failure(struct dev_pagemap *pgmap,
 
 static const struct dev_pagemap_ops fsdax_pagemap_ops = {
 	.memory_failure		= pmem_pagemap_memory_failure,
+	.page_free	        = dax_page_free,
 };
 
 static int pmem_attach_disk(struct device *dev,
diff --git a/fs/dax.c b/fs/dax.c
index becb4a6..f93afd7 100644
--- a/fs/dax.c
+++ b/fs/dax.c
@@ -2065,3 +2065,9 @@ int dax_remap_file_range_prep(struct file *file_in, loff_t pos_in,
 					       pos_out, len, remap_flags, ops);
 }
 EXPORT_SYMBOL_GPL(dax_remap_file_range_prep);
+
+void dax_page_free(struct page *page)
+{
+	wake_up_var(page);
+}
+EXPORT_SYMBOL_GPL(dax_page_free);
diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
index 1a52a51..6e90a4b 100644
--- a/fs/fuse/virtio_fs.c
+++ b/fs/fuse/virtio_fs.c
@@ -909,6 +909,10 @@ static void virtio_fs_cleanup_dax(void *data)
 
 DEFINE_FREE(cleanup_dax, struct dax_dev *, if (!IS_ERR_OR_NULL(_T)) virtio_fs_cleanup_dax(_T))
 
+static const struct dev_pagemap_ops fsdax_pagemap_ops = {
+	.page_free = dax_page_free,
+};
+
 static int virtio_fs_setup_dax(struct virtio_device *vdev, struct virtio_fs *fs)
 {
 	struct dax_device *dax_dev __free(cleanup_dax) = NULL;
@@ -948,6 +952,7 @@ static int virtio_fs_setup_dax(struct virtio_device *vdev, struct virtio_fs *fs)
 		return -ENOMEM;
 
 	pgmap->type = MEMORY_DEVICE_FS_DAX;
+	pgmap->ops = &fsdax_pagemap_ops;
 
 	/* Ideally we would directly use the PCI BAR resource but
 	 * devm_memremap_pages() wants its own copy in pgmap.  So
diff --git a/include/linux/dax.h b/include/linux/dax.h
index 773dfc4..adbafc8 100644
--- a/include/linux/dax.h
+++ b/include/linux/dax.h
@@ -213,6 +213,7 @@ int dax_zero_range(struct inode *inode, loff_t pos, loff_t len, bool *did_zero,
 int dax_truncate_page(struct inode *inode, loff_t pos, bool *did_zero,
 		const struct iomap_ops *ops);
 
+void dax_page_free(struct page *page);
 static inline int dax_wait_page_idle(struct page *page,
 				void (cb)(struct inode *),
 				struct inode *inode)
-- 
git-series 0.9.1


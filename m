Return-Path: <linux-fsdevel+bounces-37580-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E03DC9F422C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Dec 2024 06:17:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 784791884AD3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Dec 2024 05:17:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 446E71D9A47;
	Tue, 17 Dec 2024 05:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="MoEJwevM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2059.outbound.protection.outlook.com [40.107.220.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1E311D63C4;
	Tue, 17 Dec 2024 05:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734412442; cv=fail; b=gaMCE1pi9Pm48xHY7ZabPyFlaj9wWXh6Re5jPw6itCBNU9+gP6Ggtp7E8HYul9cq5+SfYPkipbdPPNvSsxj+XfYi/qW3O/1qqibjY0h175W2RwCr+Y/0E6wK+tC/G3YmiENvLplS6RzlsVxCxoCtHcf9DxcnPig5AV5BXM65e9Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734412442; c=relaxed/simple;
	bh=LgBQoTDlq/0JUafIgTsYubS4mj2WpYX5sXxYNlVBB10=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=prP2ddmxQeZf17TLqet4nye+W92k4tJOXIx0FF2l4ZTMImqOsGMo91WypbaSIBDXxNQCKSS0jI3mQNF9aW/bUYeIuAMhaD/u46+mm1vPjdirR1ToBrqvbR14/UdiZUCoW/vF/b1MuMQNvLirQxDT3NW6JxHl5BovkyVkmRUDAME=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=MoEJwevM; arc=fail smtp.client-ip=40.107.220.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r7UbssMyxrkp6dlor1G9yJWYPlfVNGnEfPHuv9cbhuJGpITF19pRBMu42wgabztFIJYsbu2XwhlU5u635L4t5mm6pdkZW9ubSRQI/L0p0dN25nvUuiqVUh8phcoEzJSUoF7/9jDfpELaWouAf4ZyoaxkJxZw4WOh5F5taqy1rORjNkLioTsgubpooNHvvgm5g2yjdUEwrrxh01qfI1HxTH9jCURbZziWSZCf86EXDlO4BHFgzVvNnWrBt2s/txsGKQXYGzKlnKp+XRsACc+jLuceNJOpu1POOvHPjEzj51R9bHoZbxuh2EGqRA+QOT94BC2iBHXzpfz3sPucu4WT5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dt16aTHQWa/9x7dM8NaNzVhZVxyBkJOcFpMjfFKYq5Q=;
 b=i1+KdwK+geXm14vWQfURYu2oM+Mix51funTBDLeOmFua2+qpNC/DPOyLjY72EPWILMWGylQHWsI0Vv82hX3L4Nv22hdMWMW531kFbhsO2KpYi5hwKJmk4veBpOBMdX8L8Qh2WREzondG65pDZfuXyGfPVtDGdqmdItqDoElPvwhHfcuikccwhH0kHtsNeQvNG0CMDZ1X8NOoe9CyiaZPeLijGBCXhCB6T5JAnzL0H1EQDWno0lclTZUC5JBcDiE4kLJKcGC/MaCB8b6jMC0V+XxtYNLH8zECYO9tOHzZdbmhVlMvrCESBl47ei202CVEHMOfi8Yv3WQ3gkieC0k1bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dt16aTHQWa/9x7dM8NaNzVhZVxyBkJOcFpMjfFKYq5Q=;
 b=MoEJwevMEMZLA4cUJ6B5q4gOtWRs7dveFE3lRGXDbvb1pPu6//+0lOAXbl6VZzlNSrDdpQBMRWXlJO33RpXm8floW4plRUVa1Xeu8+QuCA82bmv+Heaa3WC1FQsa3OFAUUpOUrQk6lCysGvrgQFdIjYjWz4KzBo53lUx6PXYhd8MnOlf4UVyOa9gPTxUgOKPF+XmMH+H+qAsNC8YZSsKkAAPLZX4irhtIYEK59nYeZtHBMX6LmRjk6zMcFlMMhsw0wTrBMJ0b/vCnv3VAP6MnHVVhlpqrRREEJR2I9iOSjwO7hXf0zPCsI5SEM8bA3Lzxsvt2pb/f3RAw5GG7GUUuw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7726.namprd12.prod.outlook.com (2603:10b6:8:130::6) by
 CH3PR12MB8936.namprd12.prod.outlook.com (2603:10b6:610:179::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.22; Tue, 17 Dec
 2024 05:13:59 +0000
Received: from DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe]) by DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe%4]) with mapi id 15.20.8251.015; Tue, 17 Dec 2024
 05:13:59 +0000
From: Alistair Popple <apopple@nvidia.com>
To: akpm@linux-foundation.org,
	dan.j.williams@intel.com,
	linux-mm@kvack.org
Cc: Alistair Popple <apopple@nvidia.com>,
	lina@asahilina.net,
	zhang.lyra@gmail.com,
	gerald.schaefer@linux.ibm.com,
	vishal.l.verma@intel.com,
	dave.jiang@intel.com,
	logang@deltatee.com,
	bhelgaas@google.com,
	jack@suse.cz,
	jgg@ziepe.ca,
	catalin.marinas@arm.com,
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
	linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	jhubbard@nvidia.com,
	hch@lst.de,
	david@fromorbit.com
Subject: [PATCH v4 06/25] fs/dax: Always remove DAX page-cache entries when breaking layouts
Date: Tue, 17 Dec 2024 16:12:49 +1100
Message-ID: <be25c9f9fbc1481162a46049b62486b9a095bf94.1734407924.git-series.apopple@nvidia.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.18cbcff3638c6aacc051c44533ebc6c002bf2bd9.1734407924.git-series.apopple@nvidia.com>
References: <cover.18cbcff3638c6aacc051c44533ebc6c002bf2bd9.1734407924.git-series.apopple@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SY6PR01CA0056.ausprd01.prod.outlook.com
 (2603:10c6:10:ea::7) To DS0PR12MB7726.namprd12.prod.outlook.com
 (2603:10b6:8:130::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7726:EE_|CH3PR12MB8936:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c042e64-ca26-4b0c-ba6b-08dd1e599cc8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?vOezp3DYsZnu8ke8eB03nSukQUlqBelVOOOUBC6egyP6zgbMomeZ0QSS3VNC?=
 =?us-ascii?Q?pfIWSTDfQoSkXhNu3g+PimbNYPBdT9QgOC6CWTVGw/97l+Y5MsDlQVBHtvle?=
 =?us-ascii?Q?TO3WVHA9fdBFRuiROm0mVuFoRkakK/Dbj0ahnXDWyP7zl1a2uLd6tJu0c114?=
 =?us-ascii?Q?RGTghmJcV9EeWZDgBNZJGYw6rPLPyR9wShvlCeScblQ5647HxzWE9dgo0/bk?=
 =?us-ascii?Q?hF0c6BtuEqn0qD2qcl8DQx1l0S5bBawPd6pJ7rstybfQo1eyn3RMKw6t8X6l?=
 =?us-ascii?Q?kOw3FY5qcavLiAR6sQb/ypLzEa0bWkXg9i/juyIRmvhXHiHwl9gU/Ww0sdH9?=
 =?us-ascii?Q?adNssuTjD1huatM3Q0bhtrGMt7clRDqP92uiDOqPYR8j1dA+V3gWA2s6X4Pz?=
 =?us-ascii?Q?uccSY2n6Clu7FWDqb3Ez7NZe8/BM7mUG48IaiDre3zMoAoGA8qvS4pwwWCuY?=
 =?us-ascii?Q?ruuW79AYqP4Nlx9hRA2VStZVTP5VKXV+I456fK/5ap9qOuYmJAVgGlBzsyD2?=
 =?us-ascii?Q?8HOjZzc8trHhte4LogK6cG/wCtkfRO9yTOlV6JMTElXGNFZoGW80TYC0aRG2?=
 =?us-ascii?Q?KP3pHH1j2L3MtwanU9apEhN3/uYd3GiuVMPZe8GKqMub+Fse+diia/ez/9xW?=
 =?us-ascii?Q?cahEl2+nT5CdcHgpaD5T9kIcZ90sEEF35aWqsjfehQoi7ihcvup10McfIDKa?=
 =?us-ascii?Q?VL//5J/oRjN+qm8CgNaJgBoydUzH7a8C8MhFU9ETF9BXa+GufaNk3zLjHD3d?=
 =?us-ascii?Q?2XR/NebvEgB+JLkCNKACIcfUsa5MiawuAE4OzY77hEULO3WtnxDj3dQH3Gp2?=
 =?us-ascii?Q?+CMAD+hdBB5GjeDA8Is7spqRKSxBVj5y1aCrW+Xwp+4iQ4VHkm6m+203Z2ZI?=
 =?us-ascii?Q?fIY/kJ12RDyQ7sITLAcqwlS9SFlH1PAfoX59/zpy0fFjwaCAgbCf5xhkqXD6?=
 =?us-ascii?Q?huGnz1MQeLlOIp9dGO00HxSzM7BHENM8aqrmjxTYM5zPrjL6OPRCJJS4C0U5?=
 =?us-ascii?Q?SRNBpcy0w3udXLg2+nCixqEAuJ2zHr2lxMHUR8ZudMd3VqUG9jFDeg0bUfiy?=
 =?us-ascii?Q?6TeYlhamPk6BDEZWbIrJmSJzw39fYXaJ9JXD0t7Z/fAwwG8LJ6Ozy8kAeqGs?=
 =?us-ascii?Q?F15u2Ev7ZqWJRwVRrdFwy6z2/JA5kVBEVDXUl7yjDF61uN7azeNHt+CvjYam?=
 =?us-ascii?Q?NnlwvXc73taaStuznq8kq7x8wZnZMYqq99CRIBE9kvELgT8c0GYd3SQX9XSS?=
 =?us-ascii?Q?MTk2vPZsdVZKbpoxjBrOAFJYLFOkdKWYeq2IbVZZV8OJq1Z2yN2L61WvmNCh?=
 =?us-ascii?Q?tKXhC8n/dQz1ZgMFqCDjrU+3oGsjLRvEb5aeV9mVPNC/H0f0LHsdl4Vm7AYE?=
 =?us-ascii?Q?kUFcfzjfTr9aRzCjj3UsMd+43957?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB7726.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8gVl47iUmFUPwo0eqPLmxy28OhBtI2zEwTG+riiycA9fcyENWelBdSCtcdek?=
 =?us-ascii?Q?cspcgFrPNWSGo+hTDzq1ShB6oWyf5QeiGFDWQHlrOeWmfOo5sEQ4t5Bfaa/a?=
 =?us-ascii?Q?HpVVToCFO9ygvdIezu0Vkx+9Kx7yborAswdo0Hwvs4m2I+z4SN3c/EChEMNY?=
 =?us-ascii?Q?FOjluJ+aTDrTy3bvxF33c6iv0aMv9UV6HX81Mq4SD7o9Ktp0aJvSkqCMqiYw?=
 =?us-ascii?Q?Pk/7fMg27X0EKOL+fk0DZU/Tfpqp/7jFx0550WXrrtjp16zamqJ2YrltwC35?=
 =?us-ascii?Q?bbWfwjY3k5+QlGjEoD5j2AX4cwnH0ErlDWb+7Aeo/u/I87ReyMsVxB/QkOri?=
 =?us-ascii?Q?DHy/pBRaQcG7ZglETELl534EzzwjLc/V/l1E217U1BkkDFjh1zuyYqcaxyJq?=
 =?us-ascii?Q?jW9xB6ReCL8dacEP9IYrea3/lfl/5NuyD9M9bvkLTstToyrRcSGO1YirURxp?=
 =?us-ascii?Q?ppLjsvdF9QZGcbrM8cd4ox8kxvgf5PpQ/lzXyhxuXO/2l7ZrygTbppxxRYXv?=
 =?us-ascii?Q?ltQ45qCcubbs144kgXkDJBEVAg178JktgdGVAZj0FpBGEu1BPxianAhRvX3+?=
 =?us-ascii?Q?F/2F70eVHLlo64zkuCMVkpWJ+EkXluheO+CplcwC2Sna/bNmtRW2OP+eseYh?=
 =?us-ascii?Q?F+sEp6R8Vf43T4d1RSmUddZ6R/VeK4bVEfwMPNhO9tHYDD7QQKieLI47+Gu0?=
 =?us-ascii?Q?z0SOrHa4lH/qd7QPyUthnENzHAjb4/kQdR33BORhNztD2IX4bHWmMUMDIYvS?=
 =?us-ascii?Q?WVF4/ZlXyMsKielRtQaGRBp8I0A4Q2cCTmKkeKYyt8xUZJa5EsglsOgYT53R?=
 =?us-ascii?Q?DUMk6JLXA628yEHQfZzuA1oUlDKslr2Ky6MOA9BycsEGmzpzQDKWnLD9ZBz7?=
 =?us-ascii?Q?WvZNlcOStAvOoj8MTG0o9EXPFv2tMLnEiQoBLPhsEXIr+DtsUbswjahBMpCx?=
 =?us-ascii?Q?WVV8yruS6kr0PQfMNMiAjirxhc24hzjVmFhwZYtW5mCAMatifaHRRw2G7io4?=
 =?us-ascii?Q?r7YOhBBdTHVUwfPf6s7kvSZckE49DHO/WX5i9RyfNvvcuNq6x5gaCEv99Vhh?=
 =?us-ascii?Q?CXV/sNVvAGfRtHFQOMOAYtgwKJOO3F35KuMWFf/V2U+RX4OdbD+GoNnKQ01+?=
 =?us-ascii?Q?4l/kGbB6sZ/JCFZWhRj+duvGi8VSNGrMqRLCZPcBocuwF5bA3Q/O90CEAq2O?=
 =?us-ascii?Q?eVMuYAGgppcAY/ZGKzABKBKd+8b+UUn3ptqzGBpcbQ517jlfSeyu8aiSUSCp?=
 =?us-ascii?Q?6Slqenrbm/b9B+LMEtCSg/V+PYYVEEfFlbrU20n/1n+pcZA54Eqe7a+sd/pa?=
 =?us-ascii?Q?pF1kOCH//QC9ZNrRmn3FcsihMNWSSnxM1ImqeHfA+1I9GGDwbyka8qB0clEn?=
 =?us-ascii?Q?pFG2LLNeljFs+byascYGN3T9zJ3Gqtcv0CPO58RKZT8KxktZQ5tbTUIjHqWX?=
 =?us-ascii?Q?h00LfxeDmj9fT+4JEl7UykzlL9pPsNxToFdoC4cVyNnmwTPSwk1VhH29+XuC?=
 =?us-ascii?Q?+MjjJj4MzPSWGr8bI/K9tzaIzLvtmnz0krdNRcEHFh+5eREM2pOlQ4bRAzwk?=
 =?us-ascii?Q?5RFG0Q3aox/iBMO+90q17N9rU7Rho4ricRbduNFv?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c042e64-ca26-4b0c-ba6b-08dd1e599cc8
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7726.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2024 05:13:58.9699
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UhftufAN+wx2FiE+2lnoGrR1ceyzuPxl4QBEQjMt+WzXfdhrVAPJhwCUGWpLrsJNYOBdrdiupC81SxlPikQvDQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8936

Prior to any truncation operations file systems call
dax_break_mapping() to ensure pages in the range are not under going
DMA. Later DAX page-cache entries will be removed by
truncate_folio_batch_exceptionals() in the generic page-cache code.

However this makes it possible for folios to be removed from the
page-cache even though they are still DMA busy if the file-system
hasn't called dax_break_mapping(). It also means they can never be
waited on in future because FS DAX will lose track of them once the
page-cache entry has been deleted.

Instead it is better to delete the FS DAX entry when the file-system
calls dax_break_mapping() as part of it's truncate operation. This
ensures only idle pages can be removed from the FS DAX page-cache and
makes it easy to detect if a file-system hasn't called
dax_break_mapping() prior to a truncate operation.

Signed-off-by: Alistair Popple <apopple@nvidia.com>

---

Ideally I think we would move the whole wait-for-idle logic directly
into the truncate paths. However this is difficult for a few
reasons. Each filesystem needs it's own wait callback, although a new
address space operation could address that. More problematic is that
the wait-for-idle can fail as the wait is TASK_INTERRUPTIBLE, but none
of the generic truncate paths allow for failure.

So it ends up being easier to continue to let file systems call this
and check that they behave as expected.
---
 fs/dax.c            | 33 +++++++++++++++++++++++++++++++++
 fs/xfs/xfs_inode.c  |  6 ++++++
 include/linux/dax.h |  2 ++
 mm/truncate.c       | 16 +++++++++++++++-
 4 files changed, 56 insertions(+), 1 deletion(-)

diff --git a/fs/dax.c b/fs/dax.c
index 5462d9d..cd6cca8 100644
--- a/fs/dax.c
+++ b/fs/dax.c
@@ -845,6 +845,36 @@ int dax_delete_mapping_entry(struct address_space *mapping, pgoff_t index)
 	return ret;
 }
 
+void dax_delete_mapping_range(struct address_space *mapping,
+				loff_t start, loff_t end)
+{
+	void *entry;
+	pgoff_t start_idx = start >> PAGE_SHIFT;
+	pgoff_t end_idx;
+	XA_STATE(xas, &mapping->i_pages, start_idx);
+
+	/* If end == LLONG_MAX, all pages from start to till end of file */
+	if (end == LLONG_MAX)
+		end_idx = ULONG_MAX;
+	else
+		end_idx = end >> PAGE_SHIFT;
+
+	xas_lock_irq(&xas);
+	xas_for_each(&xas, entry, end_idx) {
+		if (!xa_is_value(entry))
+			continue;
+		entry = wait_entry_unlocked_exclusive(&xas, entry);
+		if (!entry)
+			continue;
+		dax_disassociate_entry(entry, mapping, true);
+		xas_store(&xas, NULL);
+		mapping->nrpages -= 1UL << dax_entry_order(entry);
+		put_unlocked_entry(&xas, entry, WAKE_ALL);
+	}
+	xas_unlock_irq(&xas);
+}
+EXPORT_SYMBOL_GPL(dax_delete_mapping_range);
+
 static int wait_page_idle(struct page *page,
 			void (cb)(struct inode *),
 			struct inode *inode)
@@ -871,6 +901,9 @@ int dax_break_mapping(struct inode *inode, loff_t start, loff_t end,
 		error = wait_page_idle(page, cb, inode);
 	} while (error == 0);
 
+	if (!page)
+		dax_delete_mapping_range(inode->i_mapping, start, end);
+
 	return error;
 }
 EXPORT_SYMBOL_GPL(dax_break_mapping);
diff --git a/fs/xfs/xfs_inode.c b/fs/xfs/xfs_inode.c
index 295730a..4410b42 100644
--- a/fs/xfs/xfs_inode.c
+++ b/fs/xfs/xfs_inode.c
@@ -2746,6 +2746,12 @@ xfs_mmaplock_two_inodes_and_break_dax_layout(
 		goto again;
 	}
 
+	/*
+	 * Normally xfs_break_dax_layouts() would delete the mapping entries as well so
+	 * do that here.
+	 */
+	dax_delete_mapping_range(VFS_I(ip2)->i_mapping, 0, LLONG_MAX);
+
 	return 0;
 }
 
diff --git a/include/linux/dax.h b/include/linux/dax.h
index f6583d3..ef9e02c 100644
--- a/include/linux/dax.h
+++ b/include/linux/dax.h
@@ -263,6 +263,8 @@ vm_fault_t dax_iomap_fault(struct vm_fault *vmf, unsigned int order,
 vm_fault_t dax_finish_sync_fault(struct vm_fault *vmf,
 		unsigned int order, pfn_t pfn);
 int dax_delete_mapping_entry(struct address_space *mapping, pgoff_t index);
+void dax_delete_mapping_range(struct address_space *mapping,
+				loff_t start, loff_t end);
 int dax_invalidate_mapping_entry_sync(struct address_space *mapping,
 				      pgoff_t index);
 int __must_check dax_break_mapping(struct inode *inode, loff_t start,
diff --git a/mm/truncate.c b/mm/truncate.c
index 7c304d2..b7f51a6 100644
--- a/mm/truncate.c
+++ b/mm/truncate.c
@@ -78,8 +78,22 @@ static void truncate_folio_batch_exceptionals(struct address_space *mapping,
 
 	if (dax_mapping(mapping)) {
 		for (i = j; i < nr; i++) {
-			if (xa_is_value(fbatch->folios[i]))
+			if (xa_is_value(fbatch->folios[i])) {
+				/*
+				 * File systems should already have called
+				 * dax_break_mapping_entry() to remove all DAX
+				 * entries while holding a lock to prevent
+				 * establishing new entries. Therefore we
+				 * shouldn't find any here.
+				 */
+				WARN_ON_ONCE(1);
+
+				/*
+				 * Delete the mapping so truncate_pagecache()
+				 * doesn't loop forever.
+				 */
 				dax_delete_mapping_entry(mapping, indices[i]);
+			}
 		}
 		goto out;
 	}
-- 
git-series 0.9.1


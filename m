Return-Path: <linux-fsdevel+bounces-64379-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B13A9BE3EC6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Oct 2025 16:33:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A581A3BE839
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Oct 2025 14:32:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E72E340DA3;
	Thu, 16 Oct 2025 14:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="kL1NZJqt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013023.outbound.protection.outlook.com [40.93.201.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2842433EB1B;
	Thu, 16 Oct 2025 14:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760625146; cv=fail; b=OTCy897nRdbp1ug0i974Q7mmkurz5qdorkhfMm6br4qJnaeyqo5lYk9v4dANQE+a9KZ5/hfwbYYzSQAsZxZV3FlnpcIhZvd+/+W8QASenSXapwT72S6uCpjDtX7rWfvW8upIEuRdLkB8gGRXN+n9/ws1CI0Eh3LcMEuy8LjgACs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760625146; c=relaxed/simple;
	bh=p3VMA40UZTfrx45U2kZ9jVQ7ksWdzE5mdEbhvuBdz6o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VUCIROzQfjAyBqv0bcUd8RJYVRAusHeVaGJsrw3KKsNMrqfJti5FlqiQfYEUpfvDblIZ1YctcOwww16M3UohfxYhWCY24E8vp04IA6sR0XFXdbeCkeTyoG/i2+Ro71YsJ7xU/z2bPLroGO6teMW9lmmV0jkWM8Zq6CMXdMQ4C1o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=kL1NZJqt; arc=fail smtp.client-ip=40.93.201.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xEXIXiIy2XVNeYKlWbF731Upes6KHbPVPRQZ3EYZ1yJU3ywF3v0oaqUNBkKPq/gr51JcNQcjMhBMPAXmGYEfuzlJ5x0Vf+pvarAXbsyD2w4aax5fJqXSmgQ5zerLMirqMHMMLuITqNlX5W/sZirJPZG31n8SaN0B9y6B2R2mrJzLOfvxPPn2jKS0EWnfax92Os/s3tLnEfNKsrMTG3Xnpwnk10Macd9QXMw5vPdVcKao2ZZ4zwwvnSYzyp3tl4nXyfRKSiKWEgWhmLq3BiHxksR8nsrEJLSDNB+5lzGQ/QHT3wdavrFCmpHBRq5p2FUfcBoXRTL8vhFbqmibF+D3Lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6+Zcn55Wf9vNUzcVJ/wNxAdNW9vb5Ux2zpBAFyHq3z0=;
 b=buuRBIUL32WF+corNbHMD6B8fGeAs6kvf1NjKx9/8+6cCcvJ83zUwXkeZ6K1d4XBtcAhulf1Rx8OFVbeAzoc0U4X7H7yC9tsTgSNhdPQEurojSRkPOhRm9uurGPerN0tj+4OOi1AqreBNjSOssDaDDv8DYVaQSjLWAfh2G6v1+QjEMWrXI8JIyG0WMrwAgfo+i51OOlwufEn6l3CyWft4j0Hl48EApUWfHVA/jNUMUBa9RMoCZKXx+dSIeO8/k9+8IKprpTxK+bMkTEFQNJaOhn6H53tYmOj+RhbaHcpNHPDZQxsSN72V/51AjYoZFIQna199LoQdI6CpcuzgKUJKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6+Zcn55Wf9vNUzcVJ/wNxAdNW9vb5Ux2zpBAFyHq3z0=;
 b=kL1NZJqtPGoGyfFlCU8fl/oS73oe9f9wHQLbJkl/YIy03VX8+0gfsdYa/Y/tYv2D/XyO83COzsIQCs8TF4A4BHiQArhn7D6wOl3+ziICCsEEKUWfhW7Wi0qEeaQlyyRXd7JGl7tzLU55sqVuFEOyLU1EYBm71W6lT4cDlKK1DAj86p4E6t10USxpUtY2OPFHBJTvKk2IXPrLeWQ3acc0+9D1odjHS9vI6kQIwck9EP4dyjrnkSz8lZtz+t2Gx9WChePACiS5NHYo6Y0Sr6+gP1/Vz+iscNWWtWCWXKuENfVYx5RAAvZJc6IozLtZOz6npAbAqncxjeAA5S2kMcGAXQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 PH0PR12MB7885.namprd12.prod.outlook.com (2603:10b6:510:28f::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9228.11; Thu, 16 Oct 2025 14:32:20 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%5]) with mapi id 15.20.9203.009; Thu, 16 Oct 2025
 14:32:20 +0000
From: Zi Yan <ziy@nvidia.com>
To: Wei Yang <richard.weiyang@gmail.com>
Cc: linmiaohe@huawei.com, david@redhat.com, jane.chu@oracle.com,
 kernel@pankajraghav.com,
 syzbot+e6367ea2fdab6ed46056@syzkaller.appspotmail.com,
 syzkaller-bugs@googlegroups.com, akpm@linux-foundation.org,
 mcgrof@kernel.org, nao.horiguchi@gmail.com,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, Nico Pache <npache@redhat.com>,
 Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>,
 Barry Song <baohua@kernel.org>, Lance Yang <lance.yang@linux.dev>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, Pankaj Raghav <p.raghav@samsung.com>
Subject: Re: [PATCH v2 1/3] mm/huge_memory: do not change split_huge_page*()
 target order silently.
Date: Thu, 16 Oct 2025 10:32:17 -0400
X-Mailer: MailMate (2.0r6272)
Message-ID: <49BBF89F-C185-4991-B0BB-7CE7AC8130EA@nvidia.com>
In-Reply-To: <20251016073154.6vfydmo6lnvgyuzz@master>
References: <20251016033452.125479-1-ziy@nvidia.com>
 <20251016033452.125479-2-ziy@nvidia.com>
 <20251016073154.6vfydmo6lnvgyuzz@master>
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: BN9PR03CA0472.namprd03.prod.outlook.com
 (2603:10b6:408:139::27) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|PH0PR12MB7885:EE_
X-MS-Office365-Filtering-Correlation-Id: ade9b7ed-b601-415c-727c-08de0cc0d070
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?xM0w6yGS02639WLrbmrp4l2KS3nHYzqCBsoQaqOkJCDZRqj7fb3p5opY4G+4?=
 =?us-ascii?Q?6nKEMmUY9KkosO+nIZAqnJAlt60AckIytCFxVpoHo9jyIvpbLOizyI0xFUC4?=
 =?us-ascii?Q?rpHYL50H+I4mPItfWxiG7JLswyqnrIqzzTugXXd50BdmxKHudKpCPdWrwkvP?=
 =?us-ascii?Q?yIytU7itei9kKpLChffLvZNUiEiIe26y/N9eVv6DSAnKXnrR1ljT0YVd52ef?=
 =?us-ascii?Q?YUC6c0l5Ubnw/fKTM0DBx15HxjP/TibqCMQHgyu6C0wh1PUw6ie4/Z1l8yd1?=
 =?us-ascii?Q?iK+wH3eM5TCFbaKdYSq7WS/CWurkE6Co+lMc6Bgq2qFZm+ZfGye065tfGr6c?=
 =?us-ascii?Q?2HGfwe7XKRkVOVDFfJ4P68u6C9i2P85ccus5/Re7ucJi85ngbxEBIGNaFWQz?=
 =?us-ascii?Q?5230wubccfRDK0WcIIrr4XeSjvsxbjcY6bMv5EpoDrRu06eGcX72KHPRoNf0?=
 =?us-ascii?Q?5W4bMo5C+D2MclHOnxqxknm6tfE2Bwax29nLtxOpEMnWwoIjS+vWwTbuYgZr?=
 =?us-ascii?Q?XtQ0cMNw3fGnnrrsziNNXSlDaCcnxCoZeJ7Le020/fgmqkbdKaVRfY0bt4JU?=
 =?us-ascii?Q?nOLpv1g4LJu99/LtMI72pT42KvGvqslKz9C9vUNppyVjyD158FAStqKAAK7A?=
 =?us-ascii?Q?tv0CASDfiMq7C5jRFjRWbMInguaHrQ5/Sc+vERiGaKFeUbh2J9aiaX7aN6KJ?=
 =?us-ascii?Q?upWICJviwOtjl5kaT5ooimex7Za/esjE3nRNelNxz4ajQ0/nzFxI8E82hckA?=
 =?us-ascii?Q?wpfVcFnF/xu1zueIkJWymbeLaKBOAewKVMRjcNTz67JS0A2WyFMn1mrE6jdG?=
 =?us-ascii?Q?aLXVLiencmDPycFtzOGd/j530MmTDlkylvYBnpAb4VgvmaqgM50k0zHSMFwA?=
 =?us-ascii?Q?cQWW+j2BqXSpBEYuWMabQToG4gR8EcZ2C9w4AHgW1K7GnaWamSyqvgbXy7qB?=
 =?us-ascii?Q?H6Z/IFYAK5Sxv4+3yhrgGcI8b3PWLhEWQPROz2We/Gz6NjQGyeLcg/uZe9RO?=
 =?us-ascii?Q?QpB8rIDZbhzz7vgYY5LcefLDrgcwMJpbGZQja2iCeKYoN69BAD8PyPt1T4ta?=
 =?us-ascii?Q?p48drFycmWDsQzO1PLb5WeoTKIPC+LMUqQnWpyn/j3R5wu5ernfnHC+sZ5gm?=
 =?us-ascii?Q?VLH8YVx+T6vr+XkbkWlCZM9pxDVzdJQ4Mt5QRFgeiSBEZ+dBa9rE0sDHdCij?=
 =?us-ascii?Q?8k6ISKQpxo26pM8MEc5HRRbzPACNL1FUucsnDBbnj/InAa0ww04d5TqXjUzD?=
 =?us-ascii?Q?Q64veTFKOX2DfRaNYPyqsQ4DE2mm9Kk/+4D4uaAIK5ghe4Hk/iitwU8HX8mQ?=
 =?us-ascii?Q?0mw3HeGOMBWVhpIn5+QhgCoL/R+ACou8kxGMEBs6//dIPP7kHAZfyZiivEbS?=
 =?us-ascii?Q?rUj7FsbTD6CLCBD/8P0VeY4FJSiAL7gyxWHsleZJe7OF1h8VLIFeNEWQqNim?=
 =?us-ascii?Q?PDTQCIb9a8PS1meoi/X6RUgBTRF/CZfFOdMTsdbIiffmyQImh/WMIw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?BZwwFtXmGORj1aANm0hD9eUHQyyfo9kkgxbu/baPyeCYOt+9QPqqdW24IGd6?=
 =?us-ascii?Q?S1XCI0LqGpQRbumlq7ukpx4ShK1Kpr7txm4IC5UzWQIwFiNnaS7nldPl9nK0?=
 =?us-ascii?Q?S2n8x3bA0wZOvY9vwo4vJpVF0ERuwpvrkscrCgePoo4hrBx0OcTSpL03nfKS?=
 =?us-ascii?Q?dTDruardZzkiB3rlZvlMBojBylKGalFCosHGfs0kZyyTIfBDYH5nNoEypJpG?=
 =?us-ascii?Q?ifKeLgk16oySXz4tSULUkTG3xHYlKeIBb5Np/pRrlcsmTOv+VmHiV3j5KgQX?=
 =?us-ascii?Q?7ReXj6vL7ZofIny2s3xGAkcyWVYzRKBHQ/2OjG5kXgaI7NQoiYmafA8uhlur?=
 =?us-ascii?Q?amJmEK4YX1ma81f4PvgSyFb6pf3Qm3r8w4SO38kM4gt3jDWCAxWpyJwb8sEx?=
 =?us-ascii?Q?GaL4koMm6IS9dtUEi2ezp2iZUbIW1uruCmhYicXCglSlMNN+94ANsASE3RfM?=
 =?us-ascii?Q?dH2PS5BPgTAVYhZ5lkW9mhq9E+SBFSNCqTD3anJ3sNJQNNOcfYwnoB1H9l4o?=
 =?us-ascii?Q?nPxlRYmDujr1MGEp07/9bFCjZw+2v3emzaV8sodRL/p0u8FvwGrRYHe9zmjO?=
 =?us-ascii?Q?QqsOz0z9ZDamOK5+d8/qDCna4y3lvLOXZmQ4MF/fVDO3AK/az/6UuIjlcOTG?=
 =?us-ascii?Q?wgWlk0tGxbVTulDMJ1qeq9NLPdBxIDQyZu4ASaIHSdfE3sHcSn5nKBk9PDXv?=
 =?us-ascii?Q?sVSHSOEk4ugXlGFP/mkjllKhvCB+8NZSYwrOQHWGgCh+w+gFB5LjkmxRGQZu?=
 =?us-ascii?Q?+LElzokhGD58StRKCvjsdzE5iEK0VfAVezYCwQ/lRmmF1LH6Kjtyxf1xxVEM?=
 =?us-ascii?Q?8J/OhDfnQ8158IGDIFqkXuF0EQIWzSI2mw0vCFavTjDzG81LvE2O7iR+9ZyX?=
 =?us-ascii?Q?hPViDiF7uA3vg/jNw4koMjHqGSAMuP9RDHFKfKwWKQ1fJjwQb10xEqay3cPy?=
 =?us-ascii?Q?Nvoh1tU4VwYQJRA8EGQ0DPCbi6a7NV2zydhbSL3DLxNFU3ycuDdANCfxWOoD?=
 =?us-ascii?Q?24W24PWEQIkWG9JhVWGildXo+CgzPGTAVgo7zcTLxOT7Cq1jI1pugF85Hnni?=
 =?us-ascii?Q?ndiOSqh/va7GMHu/IAtuTSyFPk8P4Xb5v/DFTAmHkrFqgDkodQu9fwT2P5R9?=
 =?us-ascii?Q?iTlIZKMh/Yd+UbXbpYR0feep6Fas5dvhkMJ18wg8WTLw4RQ2wk4RwaL51YnM?=
 =?us-ascii?Q?ueMpYXIKnOOBkWYUnNTURr1V86jL9jXvf1TdMM0dRV8k9kbC0sq01ta6TgZO?=
 =?us-ascii?Q?Gy6KTW0QNcH4hOFbC8EUk8B2MrtqQEZpfxLiO2c/m5nnwuZHNcqBbvskof/W?=
 =?us-ascii?Q?d/LnYzTFs5WSMGX1GJ4vBZ1GiuA7IPiymfYlhtMgzy5pF+CHTl6jN4qy9pOm?=
 =?us-ascii?Q?1MuPjJ/5uc9oXAr0hqG/kujJ5ONZiHjPmRPnppc3Mlxd0I05tgYBokEe4AyK?=
 =?us-ascii?Q?ApbDAR4/tRtGdssKKp8b3JPuj7MejN8SsYdm/iTEUiHlvhuOzZKZIcrOj/op?=
 =?us-ascii?Q?VCajQFa4nhiQbPfJeuT8LYXl2W5eTX1wT46M8oW42JeadmewyCvj1gF0E5XT?=
 =?us-ascii?Q?fi8wPVyjfQ1pHdf8Im5xIunxrn1Z8ylbAXZnVThW?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ade9b7ed-b601-415c-727c-08de0cc0d070
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2025 14:32:20.5089
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i4XL2lXV3M1VqudPWKEZgJz6tPkGdIgExBAp1FqU67xF66uO8sg3Vc8WvWWAQLtG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7885

On 16 Oct 2025, at 3:31, Wei Yang wrote:

> On Wed, Oct 15, 2025 at 11:34:50PM -0400, Zi Yan wrote:
>> Page cache folios from a file system that support large block size (LB=
S)
>> can have minimal folio order greater than 0, thus a high order folio m=
ight
>> not be able to be split down to order-0. Commit e220917fa507 ("mm: spl=
it a
>> folio in minimum folio order chunks") bumps the target order of
>> split_huge_page*() to the minimum allowed order when splitting a LBS f=
olio.
>> This causes confusion for some split_huge_page*() callers like memory
>> failure handling code, since they expect after-split folios all have
>> order-0 when split succeeds but in really get min_order_for_split() or=
der
>> folios.
>>
>> Fix it by failing a split if the folio cannot be split to the target o=
rder.
>> Rename try_folio_split() to try_folio_split_to_order() to reflect the =
added
>> new_order parameter. Remove its unused list parameter.
>>
>> Fixes: e220917fa507 ("mm: split a folio in minimum folio order chunks"=
)
>> [The test poisons LBS folios, which cannot be split to order-0 folios,=
 and
>> also tries to poison all memory. The non split LBS folios take more me=
mory
>> than the test anticipated, leading to OOM. The patch fixed the kernel
>> warning and the test needs some change to avoid OOM.]
>> Reported-by: syzbot+e6367ea2fdab6ed46056@syzkaller.appspotmail.com
>> Closes: https://lore.kernel.org/all/68d2c943.a70a0220.1b52b.02b3.GAE@g=
oogle.com/
>> Signed-off-by: Zi Yan <ziy@nvidia.com>
>> Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>
>> Reviewed-by: Pankaj Raghav <p.raghav@samsung.com>
>
> Do we want to cc stable?

This only triggers a warning, so I am inclined not to.
But some config decides to crash on kernel warnings. If anyone thinks
it is worth ccing stable, please let me know.

>
>> ---
>> include/linux/huge_mm.h | 55 +++++++++++++++++------------------------=

>> mm/huge_memory.c        |  9 +------
>> mm/truncate.c           |  6 +++--
>> 3 files changed, 28 insertions(+), 42 deletions(-)
>>
>> diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
>> index c4a811958cda..3d9587f40c0b 100644
>> --- a/include/linux/huge_mm.h
>> +++ b/include/linux/huge_mm.h
>> @@ -383,45 +383,30 @@ static inline int split_huge_page_to_list_to_ord=
er(struct page *page, struct lis
>> }
>>
>> /*
>> - * try_folio_split - try to split a @folio at @page using non uniform=
 split.
>> + * try_folio_split_to_order - try to split a @folio at @page to @new_=
order using
>> + * non uniform split.
>>  * @folio: folio to be split
>> - * @page: split to order-0 at the given page
>> - * @list: store the after-split folios
>> + * @page: split to @order at the given page
>
> split to @new_order?

Will fix it.

>
>> + * @new_order: the target split order
>>  *
>> - * Try to split a @folio at @page using non uniform split to order-0,=
 if
>> - * non uniform split is not supported, fall back to uniform split.
>> + * Try to split a @folio at @page using non uniform split to @new_ord=
er, if
>> + * non uniform split is not supported, fall back to uniform split. Af=
ter-split
>> + * folios are put back to LRU list. Use min_order_for_split() to get =
the lower
>> + * bound of @new_order.
>
> We removed min_order_for_split() here right?

We removed it from the code, but caller should use min_order_for_split()
to get the lower bound of new_order if they do not want to split to fail
unexpectedly.

Thank you for the review.

>
>>  *
>>  * Return: 0: split is successful, otherwise split failed.
>>  */
>> -static inline int try_folio_split(struct folio *folio, struct page *p=
age,
>> -		struct list_head *list)
>> +static inline int try_folio_split_to_order(struct folio *folio,
>> +		struct page *page, unsigned int new_order)
>> {
>> -	int ret =3D min_order_for_split(folio);
>> -
>> -	if (ret < 0)
>> -		return ret;
>> -
>> -	if (!non_uniform_split_supported(folio, 0, false))
>> -		return split_huge_page_to_list_to_order(&folio->page, list,
>> -				ret);
>> -	return folio_split(folio, ret, page, list);
>> +	if (!non_uniform_split_supported(folio, new_order, /* warns=3D */ fa=
lse))
>> +		return split_huge_page_to_list_to_order(&folio->page, NULL,
>> +				new_order);
>> +	return folio_split(folio, new_order, page, NULL);
>> }
>
> -- =

> Wei Yang
> Help you, Help me


--
Best Regards,
Yan, Zi


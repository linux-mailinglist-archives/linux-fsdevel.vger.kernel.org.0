Return-Path: <linux-fsdevel+bounces-52177-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 63915AE00DF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Jun 2025 11:01:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DDAF43B7936
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Jun 2025 09:00:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62C90280012;
	Thu, 19 Jun 2025 08:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="r7GPaOAr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2067.outbound.protection.outlook.com [40.107.100.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CEA227FB1F;
	Thu, 19 Jun 2025 08:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750323532; cv=fail; b=trFxFdogxrO5ahiY8kC6Xu7AVzUIbN0wRVRADg5tdTsQc4/1wYOsX+/bKGDl3ZDK+KB3gFtssqm8BZAPQrQQ+BPmzmBXFvH5Gnh/Oyha+0QTKocU9fuuskZfuVVfftnJOhaMTBh3fN9ih9W7gBQjrQYaXqEhVfk8ZAQsyo/jPiI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750323532; c=relaxed/simple;
	bh=NzIr0tANSNSbXLcQ/MZ3GdCv5rRjD2vZSDfH2x7w3Co=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YLgFDHBdBi2MZZgD+gP0J3UID3yk3+zajnPDzofMpB+zl0kClqwTD2qOtQ68ftrInq6lTWnZ/RnW7sT7RMfPxsu7ELFid1toAnZL8dtkmnzUUe7AP7qCBjyGpXk0tr2xmiWv7g3vEsL77mUaSLtsU8sK6XgmettJQNExVJ/4HRc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=r7GPaOAr; arc=fail smtp.client-ip=40.107.100.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v6Lzlyo8i4GHprbDFsADHpAKAqEJu5tqcnp3B3KvkyfMFXpU/pD/ofdQxZA55YJ7cpVGT9+sQhLi8c2n9P34g2jVFz8X8j/bTtL5+wj9MDUIlfZcd0+lRw2JZkrdo+LBuT3dric59Ij9JIa3hk+iH/QdVgXf5HkebmL7VVzCeFKZl5o/+2/qikAURAHMk2+2vCDi6yfHS5wNU5Oliw+EP+HkNfGQQlN87KIdct6pHHDTlHoLyg3HEltnDFnCSDR1+KKbu0mqJecCUWqKzddmSbXsnis6b59ViGCqdwsxkmJmA5EHrQwEyVWgdrp3J2n5sHdhseFmBFERnL6SykN2zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dtfJ4sC1sHvipc3AQoz4cFP5LuPWOfMwzfszFVhYRBM=;
 b=t2L2lMfW8o6tKCuZHsOWZ+3mDH4DWVqVYCToikDJAN1pQwvKxHiAqKlpVtyKPXt/ZI5/LjBUrrNytpIsyQuNfkjreRrZxPOnpwFIAZ/cyB+62bulHGhZKlgAvGO+neGt5h8O20apg5A0vsy+9QCvbydQT6I/2GVf55D81NgGBiMLRLuzGMB00tyHthw+mE48MqeKE/obZDfXL8ox3XDiMihNgWVI5yElZ4lgmqVMVF7lhFc8eRxqczckPXEudrV+2L4TOosOVbTWL6pCSkP3tGHh4q/AqbNuvo9UyGc235EzDT6SzsBM/N/MmsBs7b2OD88budauNwqRFrozJ06Wvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dtfJ4sC1sHvipc3AQoz4cFP5LuPWOfMwzfszFVhYRBM=;
 b=r7GPaOArlyj9hpek5ZWYIUX6p2/JTzM0qsGM7xglxi9ps2l1/J9G9gKQK5DK9EfX8nSfifMvkSqBtxlDVPf8oiTtNhzK5pBK/H5i9pnrczMULAMweX/jghuOtlme8J4nSRTEB5Kseb6K0fV6zJqw4pdJYJcn73OaJ3QJjxGPaJx94mtQUQVZd5bjDTKGYcaBTQfJHKqR2PWGPK1sVQ1fQeqzW43OQGU5oAjbqnn/jvvLB5h83oRPUNJyCqXdF8BtSV19ZuF+1S3pwhCHWePfmrHfrTQLBg73P2kwGFx3J8XWDdLI5g3UwE/aBDzI4j+fOhptTXU0luaQolS20Qk6qA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY8PR12MB7705.namprd12.prod.outlook.com (2603:10b6:930:84::9)
 by SN7PR12MB7956.namprd12.prod.outlook.com (2603:10b6:806:328::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.25; Thu, 19 Jun
 2025 08:58:48 +0000
Received: from CY8PR12MB7705.namprd12.prod.outlook.com
 ([fe80::4b06:5351:3db4:95f6]) by CY8PR12MB7705.namprd12.prod.outlook.com
 ([fe80::4b06:5351:3db4:95f6%5]) with mapi id 15.20.8835.026; Thu, 19 Jun 2025
 08:58:48 +0000
From: Alistair Popple <apopple@nvidia.com>
To: akpm@linux-foundation.org
Cc: linux-mm@kvack.org,
	Alistair Popple <apopple@nvidia.com>,
	gerald.schaefer@linux.ibm.com,
	dan.j.williams@intel.com,
	jgg@ziepe.ca,
	willy@infradead.org,
	david@redhat.com,
	linux-kernel@vger.kernel.org,
	nvdimm@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	jhubbard@nvidia.com,
	hch@lst.de,
	zhang.lyra@gmail.com,
	debug@rivosinc.com,
	bjorn@kernel.org,
	balbirs@nvidia.com,
	lorenzo.stoakes@oracle.com,
	linux-arm-kernel@lists.infradead.org,
	loongarch@lists.linux.dev,
	linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org,
	linux-cxl@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	John@Groves.net,
	m.szyprowski@samsung.com
Subject: [PATCH v3 06/14] mm/huge_memory: Remove pXd_devmap usage from insert_pXd_pfn()
Date: Thu, 19 Jun 2025 18:57:58 +1000
Message-ID: <cd8658f9ff10afcfffd8b145a39d98bf1c595ffa.1750323463.git-series.apopple@nvidia.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <cover.176965585864cb8d2cf41464b44dcc0471e643a0.1750323463.git-series.apopple@nvidia.com>
References: <cover.176965585864cb8d2cf41464b44dcc0471e643a0.1750323463.git-series.apopple@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SYYP282CA0008.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:10:b4::18) To CY8PR12MB7705.namprd12.prod.outlook.com
 (2603:10b6:930:84::9)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR12MB7705:EE_|SN7PR12MB7956:EE_
X-MS-Office365-Filtering-Correlation-Id: f49951de-4ca5-47a1-88c5-08ddaf0f815c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?AbtBfylxsMryyoSpxZmfbPI3lHIrveEWfsQBdH1N0GNFpnxvjpu3/bNe2uJF?=
 =?us-ascii?Q?NYH2zTz71f2VjsRmgPGA6xOuyBDNd8n99Rc848uFVME2BQRRwFZNN5Dw2pWb?=
 =?us-ascii?Q?MfTP+3ZrrCONgIqeS/TOvnA/R9iqZRe8YxYc32N3tYMLJNiZEqxr5fwHWroC?=
 =?us-ascii?Q?Vv40r7azZF4N4tqJKemh1CTDAz7CnpLai1L/Dm3+dkO73KvHPQNywHJFyLCb?=
 =?us-ascii?Q?JNm2Nej+j1afeah2a4IkiJ32P3KZhddayZ825Lm2CYti/SgSsMWKIgFLZIk3?=
 =?us-ascii?Q?mivK0K+Z2zt8lnOFDm/cAyzy1m6EHbK7HouLZovtPXVE699kE2WsBwo8AYZh?=
 =?us-ascii?Q?bL4jejk9A16uTnLtDo4XUCNh9+XvDtwXgp/xmLtkqhAnuNtxGIzDC1ackNsK?=
 =?us-ascii?Q?Kpd5Mm11KJJ42fuknMlQESJgJhu/9Sp/+Vs27rwKqWeSkUPU/5DkUdpVR/yu?=
 =?us-ascii?Q?ymFoloYX0TMdVvo0FYGPczyUqm9XTwxES2yXctP2HcRZkY01MKf6GOUtsD+p?=
 =?us-ascii?Q?A/zYAGtUH2qkx6iTszFzRL/FeogZTcfsXwi8HnjK6GQHWk+TzkLd7So5UiKf?=
 =?us-ascii?Q?+Wghr0OwTGg9huU+EWt4EOYahU3rQ5V0khG+KUkJa6VqUb0cohQrnvTlDSKo?=
 =?us-ascii?Q?ZgkoGex5pr8Zt83g2M4DE6j8p8HBchipW6XmADefUWkJpH+piJ97PuSrj8fL?=
 =?us-ascii?Q?SdnWwDFIexRUWT0EneDR0HaYzRNn/0G0uCQqPI+IRfe0sqV4Zsjz6QBoXJMD?=
 =?us-ascii?Q?uAC7wLm5dHDBrBxDY6TB8LHLOKeRrZUHE2y1llAL3rGfRZ2AhQp828l784RL?=
 =?us-ascii?Q?ECksbRjrhV8Wu0ZInVB8SfjGis+Be1TUR/PZioKDG6pm/83rReqBpCxwrojh?=
 =?us-ascii?Q?8EHFdQE+82mWQi9SRVfvIOgjppEHw3SL5oT3gydKTtALR/GqeyBkj5NfLGha?=
 =?us-ascii?Q?oG13ImgyTWIlvl3hSsQCJA7OfBvcrqG3RLDNEU1fknsMQpMExTZJvF8sQJly?=
 =?us-ascii?Q?UxOusyThXZXTUyon600wtatO9qmYSN2TWLf6kKID65gjVjRGdhinffG0qfbh?=
 =?us-ascii?Q?rRZJ24n3G6dXH7LKvHCBB1JF4itTi6z3n2a1SPg759UYHiAj1IJOaDw+d/QJ?=
 =?us-ascii?Q?kNUAsaQOAgocMDJLw2RW7x8aydFkd+aaKpOLBBU2xxQ3bfGTpVP7Utr42msl?=
 =?us-ascii?Q?qQeQ1YD2RJ9qx0GnSKUlaY+xxLFleLzXcB+mSrF1wviSVIFZGfEJQ9duUh94?=
 =?us-ascii?Q?oi5mWh5sQbF4iqZ741CA2LXYa8B61fHGz2/XrLjv8FpCR4je6/jAZgshctsE?=
 =?us-ascii?Q?I3URrt9j8DCRoEc6NH+0+XttAPnLlKLNO/AYbkUc15h88AxbBqj7UlbHD7nr?=
 =?us-ascii?Q?vdcLoWA0FyzwpLUcVPwi3zXI/LapZR6Agv6qNjYLf1ViNvHfQvjKUSHwXT2J?=
 =?us-ascii?Q?pgkNFaTG0vg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR12MB7705.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?mbW+kKpI2XwF3EXVhQ5l28PMu29h2pGuhpjAXu/PPJdYJXFHORkXTh5Xs8RS?=
 =?us-ascii?Q?H29Mzkxa3RuPLhhHEjTaKbxnnsqEhl/kFPwYHTVriztUND3PlyjgzYQAaK0M?=
 =?us-ascii?Q?BqxneOqd5NHKx3RoADKhKaM8LKX5NpGgT3Q7kufb3C3uoeDqB/oLGjbLNLHZ?=
 =?us-ascii?Q?uZbqqYLeRRuZVtl/2L/fUSgBoTJQd/ZZ0yIW38OAxSIjDeMkv4iRnqEO2ySt?=
 =?us-ascii?Q?lj6VDkjruUaNoQZiflMTqQYDcJJxoZcG6YlajIcH32GF/MUZC3cmZevYMb78?=
 =?us-ascii?Q?HNZ1ku/6HeI0m2IckSA92f+CxAbuTqbJpJdmcWCKjV5j65KqjQ6hQ3KJsFhY?=
 =?us-ascii?Q?y61wczAiY78DAXXCudVXJJvvhPSuoUSVdBJH62ItM4jLjTepayG6/gOani4R?=
 =?us-ascii?Q?3aOZ+pRncbLVQkF/CYEVz9fSgusRPQPvVV2y5Dl93CHB1/OJMkewRdHM/P68?=
 =?us-ascii?Q?8+TBxFSzo6olLOzL7bLlMQem6YQ9C4tMTJM5/5blp4hioHc6eXZzCLnB0/HD?=
 =?us-ascii?Q?ySRrDoXO6ZVbriQ2t0xoBI4j8xe5ai3cjO4O5BE5S3rO2ploQ0/hXWAYvXqp?=
 =?us-ascii?Q?NHfglqW07qgUgi7iKwIVaAc7BHkrAZDrnuNg1gKO7aWY0M34+YorQ5Q/mViO?=
 =?us-ascii?Q?jZeJzxkVEX6tdUkkiA5uxnhwrd2PxSttH0F4PmgBrP2JjPjtjWC1iJX/jQFs?=
 =?us-ascii?Q?yeCAxBGzppM3veJLHo+yLXVd54e4YNT/ZyvtkF2wKySAozxaI0CjthErFggZ?=
 =?us-ascii?Q?PHLC5QKhuRwbIOusYQVrF7FPzLf9sVd0t0jbbHRNGLXKtBtxjjqK6AZOhn2q?=
 =?us-ascii?Q?6dxJaEg73LP/UJUU6NzZCw6ihWWF4+altwPlGpoEU0+9wkdtYYOCD7ac4eyR?=
 =?us-ascii?Q?8gvfeGb4zE8pCwPIaNNB/kkFOpz+Qr0AVdSBLIcaXGt7yVj0+cVFKsVP0jCn?=
 =?us-ascii?Q?W6xe5QpmwheJK/qz4QB3nBn6StEQv59oozyDYzjBAyH+efVNTwhf6ZprTZTn?=
 =?us-ascii?Q?N2yK3kSjrVV12/q1NYRD+iiG8aYiW7BERnSXg69mvjt52V8ItGVLWfiEufuF?=
 =?us-ascii?Q?9A+N/NdXzs1zyvMLUiS4e6kLVT4J9SoIjH6ob6xAUgBCFJWvGlxabIkIakQ+?=
 =?us-ascii?Q?P5wFJ4cXw46WNVewLPuM5MyVkgCYFoVQg2Jr1M2TBeglTXYZCF5tH1ymrjtG?=
 =?us-ascii?Q?z/mbWDKIHVF0w7vdEbz0BXshajWZ/dw+vVvgBReJlg6vHjZ6E42m+wMHWaHD?=
 =?us-ascii?Q?Uq5uUw6kNnR6puzHI6QCpruQXy9jhSvKx0m8uX8wbvYVvBg0/+z52Gpya69V?=
 =?us-ascii?Q?4O05QjarN3OnmlxVFUuPHef3R8x0JGNCT/nmMshkPCtItiNHwZzCyIGIdjGV?=
 =?us-ascii?Q?H0WNgYKVpm5ToEiA5PuzSFc+zQGHHZo/6t/0Rxl3ghcEPJEj8SOc8Q7dfHSP?=
 =?us-ascii?Q?oJuSGRyMrvrnKR6jE5KI7aixSbnh/7dSiMJAK3UlnSmgy9Oul6PhEu2FiwhF?=
 =?us-ascii?Q?AemhLPPfSw5pMUOnbwqcHbf3L1HQF7S9UBdsqwKDMliVCNojnJzJbUwRm1nl?=
 =?us-ascii?Q?IqLSzmfjal6wS+qoPPgi4iDX1+YbeJWfVaeKXqEi?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f49951de-4ca5-47a1-88c5-08ddaf0f815c
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7705.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2025 08:58:48.7693
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 68z6rTFD0hPpgsRSADZvAlqfFW7JP9jhp5z3Ort59LBgfUfCxNFTRUf/kMJNRESssy1z7scjoiddBt8J+CJIzg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7956

Nothing uses PFN_DEV anymore so no need to create devmap pXd's when
mapping a PFN. Instead special mappings will be created which ensures
vm_normal_page_pXd() will not return pages which don't have an
associated page. This could change behaviour slightly on architectures
where pXd_devmap() does not imply pXd_special() as the normal page
checks would have fallen through to checking VM_PFNMAP/MIXEDMAP instead,
which in theory at least could have returned a page.

However vm_normal_page_pXd() should never have been returning pages for
pXd_devmap() entries anyway, so anything relying on that would have been
a bug.

Signed-off-by: Alistair Popple <apopple@nvidia.com>

---

Changes since v1:

 - New for v2
---
 mm/huge_memory.c | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index b096240..6514e25 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1415,11 +1415,7 @@ static int insert_pmd(struct vm_area_struct *vma, unsigned long addr,
 		add_mm_counter(mm, mm_counter_file(fop.folio), HPAGE_PMD_NR);
 	} else {
 		entry = pmd_mkhuge(pfn_t_pmd(fop.pfn, prot));
-
-		if (pfn_t_devmap(fop.pfn))
-			entry = pmd_mkdevmap(entry);
-		else
-			entry = pmd_mkspecial(entry);
+		entry = pmd_mkspecial(entry);
 	}
 	if (write) {
 		entry = pmd_mkyoung(pmd_mkdirty(entry));
@@ -1565,11 +1561,7 @@ static void insert_pud(struct vm_area_struct *vma, unsigned long addr,
 		add_mm_counter(mm, mm_counter_file(fop.folio), HPAGE_PUD_NR);
 	} else {
 		entry = pud_mkhuge(pfn_t_pud(fop.pfn, prot));
-
-		if (pfn_t_devmap(fop.pfn))
-			entry = pud_mkdevmap(entry);
-		else
-			entry = pud_mkspecial(entry);
+		entry = pud_mkspecial(entry);
 	}
 	if (write) {
 		entry = pud_mkyoung(pud_mkdirty(entry));
-- 
git-series 0.9.1


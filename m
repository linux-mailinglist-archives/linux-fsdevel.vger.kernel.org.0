Return-Path: <linux-fsdevel+bounces-35521-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BEEA49D577A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Nov 2024 02:46:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 79C76283128
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Nov 2024 01:46:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 050F818C003;
	Fri, 22 Nov 2024 01:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="T6pL+4vK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2064.outbound.protection.outlook.com [40.107.243.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE5C918BB9B;
	Fri, 22 Nov 2024 01:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732239729; cv=fail; b=mUVxETffO4zCLTiMF7YvLZHIPUosw1y7vFa5cpBZlajRJj491/1U6Gapa6W5KVD+w3Z2/NyL6NKAghTId6orRUkzLgvkyofZFNw0J64PmHugTwOi6u+KeqXfNvp7Ovq/7Z81snveeBJ14vd3BcB7ATZLx0DsM8oXeG5OTMOzLVE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732239729; c=relaxed/simple;
	bh=rLH4jadUq4KT1P+/KwUXPEJahOuUhvHdvo2VlbP3YR0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=aP2GRALfMBu97NWlK3wxzI5Q1Q0nJHdcktQfOYojhmewYMercnZ1rRPhN8K1MghMUjb5bBAqc6CQff1ALW7WJfQX1Xf3hkv8cNVbFJ9ij+Hnt1MHPef24MsiODfsdUoTuENdc7nxUrcWxkagJxLUxSGqDRHdphZ7irU6SxM5Wek=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=T6pL+4vK; arc=fail smtp.client-ip=40.107.243.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G1UwqxvwdOSaJ0AOiSzR8Cnmx4neIK9mW8tTOorr6heCrtphqjrgLpSENTwfm6IS0xm/jnXIZnbvA8BNT/0A4ILmHY9oYHcOqvaAMY34wy1iV8M2nD1z8CZausLMeSLub1nmHR5GdijwOX76y/BWbfSAD/tBb4YMKfXvlaZf5DSnDPDHvWKB7GzdhadnHEDPk/rRVkaA/DVbgnykiF/fyRIkPSQGfEyjdDkrQBgEdCC1JY194BNBsIF+nDqp2vFTkFVRK//hCkW5GCabneiO9as8IHMKlX1/1C9kYMd6xgy3i9gII8Ot4iRsRLudEpDNeaqf8ovvnhj6jr87QgQl5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IK7Wz+KpFlWHHtm9gXpPrlpwCU5rlt3ww3hmEypY42s=;
 b=iHkC6s/nta81WGT85oFbPnOo2N6JDWajJcc8uNb7PKFdT50q1NTX3HI7XQ6Nn8bUleRVEaiMnk6x9Ciy6L6AFOPQL987ngC8DBFNOPqTS0JgmLNLJ4RTO+qUgEDBDsCjKBJ7H1dqwZZxHJd3BKX8JjAzpQP0h3yLyAPCzFttEuvEZyggESNnomdxbuDL6z3N1DoFzMYHvBwuHaE5EjVW4M06i3ZvWSfb6aRsGECQIiUPsb6z5+aoJCIQ/OC740rz2ouc2oJmrzI3bqLyKNECl5RqDcQxA3QCg3VgyltETYKNRScw5BMh8Lx+mbnLrS6TiJ9Tt8z5kgHyzkVP3xPMlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IK7Wz+KpFlWHHtm9gXpPrlpwCU5rlt3ww3hmEypY42s=;
 b=T6pL+4vKygeQGT0rYY7dPyT8mpNPast9uIx2SrMCDRonti8DMeaOVuAvL2YEQkDwLOvo9dobT/Iv/a9TVSrMpRjTqhjzBjfDldGUeAFUdCc5Wqn9enmPpTrI2+JgZ+7QnQFgS8aC7o0YbDNnd85xNy2oEqkQQnIbIw9wvdI0O27GOARKzL3jAPxb2lwMu4+Zkze5hi4fcCVlRNcaTiv7Wd2YLaAlf5MovTlYDusCpB+a2foqF2leL5LOVs8L+7DCdA1NgAc4qNrZc8IJG9c5X/cdFs2IpLIvId0sy4ydr0bzsN+EfrzUpiVyxDLdWRd7RHaz7x/cLTfiL5S/QFDRdA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7726.namprd12.prod.outlook.com (2603:10b6:8:130::6) by
 IA1PR12MB6305.namprd12.prod.outlook.com (2603:10b6:208:3e7::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.17; Fri, 22 Nov
 2024 01:42:04 +0000
Received: from DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe]) by DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe%4]) with mapi id 15.20.8182.016; Fri, 22 Nov 2024
 01:42:04 +0000
From: Alistair Popple <apopple@nvidia.com>
To: dan.j.williams@intel.com,
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
Subject: [PATCH v3 12/25] mm/memory: Enhance insert_page_into_pte_locked() to create writable mappings
Date: Fri, 22 Nov 2024 12:40:33 +1100
Message-ID: <995f2e7a6b0ffd9ab07bda41511e4505bfb3247d.1732239628.git-series.apopple@nvidia.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.e1ebdd6cab9bde0d232c1810deacf0bae25e6707.1732239628.git-series.apopple@nvidia.com>
References: <cover.e1ebdd6cab9bde0d232c1810deacf0bae25e6707.1732239628.git-series.apopple@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SYBPR01CA0196.ausprd01.prod.outlook.com
 (2603:10c6:10:16::16) To DS0PR12MB7726.namprd12.prod.outlook.com
 (2603:10b6:8:130::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7726:EE_|IA1PR12MB6305:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f54407d-7881-41c3-66cd-08dd0a96de3c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?q02AQzHYoR7X3WwDsntD3t7YujfA6B/+liy2x+JWQst0jYSb9GxrSiiaaK2A?=
 =?us-ascii?Q?u2Eeky+4hhMluox+u1lkT7vnWvxgTK8ux9q1dCVf0Efh4IDFbdVc4jJvcU5F?=
 =?us-ascii?Q?rrL4BCmNv/4MlBsKmxRD4M0QtYbZF0fNeN2aG4e+xGqEo5iXvPohaeCG+ww7?=
 =?us-ascii?Q?17eI7zTqLXfCFD2EbcGv0TSeryhzBPSn13Ftwr4pTv/c0Oz73wP7FJM9OMU3?=
 =?us-ascii?Q?DWhKaWRlI/CtokmWOLK56L1HKmLFsacd+2fwtrnmPZRpullkHcMXGObEXj/h?=
 =?us-ascii?Q?EL2QlOT+26DbuesKblwTD8oHAMPJDCyaJN4xu90xLI8INhUOMpBdpoJWTLUE?=
 =?us-ascii?Q?MRmQLfIg5JVyhbuoFUXTym8y0y4zNMjfwG1DXsOtEWCYMYKAsNcbSazHA15e?=
 =?us-ascii?Q?V3DW9LnUUlNK3fsTob5Wl7YJ9uCqJxOw17evdc69E53xRx8e2dGENZ/A88Bm?=
 =?us-ascii?Q?R+Z/y9O6koNYu9Q0X9wxxsT+W90Ge/kZBDDA2ZW1yA9ug4JT72IDxsxEZ2Fk?=
 =?us-ascii?Q?Y/a7I2Cvp2mfrerwtIdxgFLpXg0yP1MGyd2JnVBD9D2rY0f2t1fFy4e4wP+9?=
 =?us-ascii?Q?vx2tB7/JP+VaqEmirrzfIqymoQ8jEKwkxy7OlzvCCHNVzDjtMh5R3hCl1Q/l?=
 =?us-ascii?Q?CnCE5pkN4meM1PdG7siTN6w6mi87OOkYj/Ny5lGRTj0RaWGdoWSnSYg4jXdk?=
 =?us-ascii?Q?5w5Ne2EM7daY2L3eje4xKIwaeODOqXrLF47HCTCKDXBjCHou+AwcLUtby/PU?=
 =?us-ascii?Q?S9xdo+6JxhP4IpdyqFGqQ+hP3BvspOevO0RyXgoSFVAgnspCn8J2lSBhiCS8?=
 =?us-ascii?Q?FLHf6HdppPRW9CohpjM88qL3zP7GGO5tAnGTCdJtxHP8cg+mbe/U5KGXvXgy?=
 =?us-ascii?Q?KspohihSjhU7TuQJKzjYOcljdebws1TBYwHzWCDeNA9B+86s2Id/UrO67llB?=
 =?us-ascii?Q?UnvDhLyU+RqipX30taxJlL3Cdfhw0RlocfEout5xsoTLTEbwJFyXC0j4AvDo?=
 =?us-ascii?Q?abLRmxVXIgJgC16LdQQ3NjhXia5jTq0dHs6Xa4ISp/NzJMYm4zF4Dyokbuwg?=
 =?us-ascii?Q?lYctxKn79HzFV6OXvgu7v9hsU7QlNe2eUNJVlwYaq02HZkaa+KeYA/YZCKk8?=
 =?us-ascii?Q?/weTEGQKILJ0ROxRGgTCyv1zg6uazHPY8+tlHsDjN1T3m5MWGiuhGIyQi8rs?=
 =?us-ascii?Q?Y4EjoGnPXLJPZTsY/AA5r0X31ZtWK2HaFkpEq0auYuhpG61PG0vX1gutn868?=
 =?us-ascii?Q?abY7/SciXjNbtfuGVTvfbHj5p4tgnVxFfEqMGU0sIjlxq36jz31bcDq8vhIO?=
 =?us-ascii?Q?8Og=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB7726.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?TESPXXhbIdEw9UInSrAciKSMNGcHShHcngY16ays4dGzmVARdHI5PV3LBlZH?=
 =?us-ascii?Q?gc0Ml4iQlNrpp6sjf3lkcYJmIlcWz5fcdtbp6KKSz5rbbioW+KaubAgTwE63?=
 =?us-ascii?Q?ozG+XVGv6aS11ATPUl6s+WP3D+U3X8/2QK7AczL7+ksOf5AAo0/KxWcgieHR?=
 =?us-ascii?Q?AM2lt+xHYJ5hpg6IToOEdSBcDZwAkNstE8zBBy/Nx0RdugyVj3GvdI/yzRZa?=
 =?us-ascii?Q?i0vgM+XZokKkqB8yen76y49cNRW5Vi7+U7xtvwd1R27H4NLXF+sSiXJjTT5N?=
 =?us-ascii?Q?XdJtMs79ZdnJywtTuh3aHtJh3gWWTn7tsjX1ecAO60blBJGjJtiB2NSr6HlI?=
 =?us-ascii?Q?peq2H7jA5PFvJgwOc0WvAEwYqmzb6oqQcAHLQ5czducqwxeK7KBF+Nchc4IC?=
 =?us-ascii?Q?rxQDhkY5Wv7FHPl5c7eBwoWI7JkgRVFRLO6QsPRQ4nxMbmoPPI9XZPBIE/u4?=
 =?us-ascii?Q?sNFcJV1kmZSO9zH7Awu9IlvYQJDZqO2ixvubnyTU6bWtBNmm0qNJssmvOv5j?=
 =?us-ascii?Q?kWOPLL4xO5RXB6RG6AlFq/EcJY8uZq2NNE1chRTDJb1bODUlriTtT1OzQ3Sr?=
 =?us-ascii?Q?cbc8K2F0eT0MMwvt+CBboNTKiLBnaYJ0s5aBbpWsojfOhFs+7bTquveViZ7n?=
 =?us-ascii?Q?4tEiQ/o5Nl/pZCK6fSKW7VU7WWSLkP4oIIngti+D5PNbylSAALeczF/7tvSs?=
 =?us-ascii?Q?/54kjH3CFFtpm/GEWGTXrSUZ4ULBAU6eBN0wTHPf2rcPkm/x0B6whwlM0/Uq?=
 =?us-ascii?Q?hEM3zOakur4+5hqisshF0gZco5b+Mvp1Hj29XzbYRNeHbYSjqyqaMKKXxrja?=
 =?us-ascii?Q?hpfWoEufPJ+IdeTofmF9cGR+SrA8ErkF1+v1/6xPYVjA9gulMIyAfGJQUoBf?=
 =?us-ascii?Q?k8ed7S2yUAMWgRiuftP+8xfmXLLZAlyqRCM6dzYW6y3Uhb+MoXk6QQgVOSj9?=
 =?us-ascii?Q?e2Erp3p4kNqvqOoeGpWsSNwtupG8XSqTscn+oV0QwvXAFRmbgcz+0aB9InYE?=
 =?us-ascii?Q?XgYdRYMaODdxxgo9KoO5MEKb+K1F8FVqe/jzJCkowXvFnXbXRhIP8belhJCP?=
 =?us-ascii?Q?8qzaNKvmnIqcsHmf93XAeq2KDgywsLAjKh3EJINWyC4zZ90s4kaGwvJagVHk?=
 =?us-ascii?Q?Vog0u0+dq+lBiER/IWCJ7+O/eP51ndyv6oZ/wT3im+D52AZUC3PWsxFqWkxj?=
 =?us-ascii?Q?NL2/N3vo+EITCjnaIkrMc90zar4EIsd4qDx8TpreBjq/DWYQIW01ofMt8hie?=
 =?us-ascii?Q?K0Xrpb+dO9Qruzh/kxDZbJqNWXkle4CxY50qb0JtCDbXHXFnuCBr+pKrXnid?=
 =?us-ascii?Q?6mhx9waiDu4cPksh9U6XOk+sMgfLruLNLJrDNOMAFKArU6F/m11Bmq8xT6A1?=
 =?us-ascii?Q?eQFz9dhUKKI2qnM4qI2LC3xL8NoIL8wnwD7ZJYk+Q/a7A+Q625Kbsonl8pXV?=
 =?us-ascii?Q?gA/gG0wVC39RntxkgklKzqGKNz493CVA6kTZAtIfb+TB9b2QFqjLOtv0iaKn?=
 =?us-ascii?Q?amrCKQ63shGHnXtGGsrxNnvR3NAKu26vHT/XFg8PZqMDrFKslHV3198b3v/g?=
 =?us-ascii?Q?v5NQB/NJ6f/eFFtEiS2z+fiI4xC7ks7BJCMuYD4b?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f54407d-7881-41c3-66cd-08dd0a96de3c
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7726.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2024 01:42:04.7904
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K0aVgBabLnIqjLN+U0qc4h1iDvzT0NkPMPxhFZ/B2Z66v0/kHwBlyqmTFe36Vlw9LMOlS57Xfs0L8EqVtaikHg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6305

In preparation for using insert_page() for DAX, enhance
insert_page_into_pte_locked() to handle establishing writable
mappings.  Recall that DAX returns VM_FAULT_NOPAGE after installing a
PTE which bypasses the typical set_pte_range() in finish_fault.

Signed-off-by: Alistair Popple <apopple@nvidia.com>
Suggested-by: Dan Williams <dan.j.williams@intel.com>

---

Changes since v2:

 - New patch split out from "mm/memory: Add dax_insert_pfn"
---
 mm/memory.c | 45 +++++++++++++++++++++++++++++++++++++--------
 1 file changed, 37 insertions(+), 8 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index 24a34a4..323662c 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -2042,19 +2042,47 @@ static int validate_page_before_insert(struct vm_area_struct *vma,
 }
 
 static int insert_page_into_pte_locked(struct vm_area_struct *vma, pte_t *pte,
-			unsigned long addr, struct page *page, pgprot_t prot)
+				unsigned long addr, struct page *page,
+				pgprot_t prot, bool mkwrite)
 {
 	struct folio *folio = page_folio(page);
+	pte_t entry = ptep_get(pte);
 	pte_t pteval;
 
-	if (!pte_none(ptep_get(pte)))
-		return -EBUSY;
+	if (!pte_none(entry)) {
+		if (!mkwrite)
+			return -EBUSY;
+
+		/*
+		 * For read faults on private mappings the PFN passed in may not
+		 * match the PFN we have mapped if the mapped PFN is a writeable
+		 * COW page.  In the mkwrite case we are creating a writable PTE
+		 * for a shared mapping and we expect the PFNs to match. If they
+		 * don't match, we are likely racing with block allocation and
+		 * mapping invalidation so just skip the update.
+		 */
+		if (pte_pfn(entry) != page_to_pfn(page)) {
+			WARN_ON_ONCE(!is_zero_pfn(pte_pfn(entry)));
+			return -EFAULT;
+		}
+		entry = maybe_mkwrite(entry, vma);
+		entry = pte_mkyoung(entry);
+		if (ptep_set_access_flags(vma, addr, pte, entry, 1))
+			update_mmu_cache(vma, addr, pte);
+		return 0;
+	}
+
 	/* Ok, finally just insert the thing.. */
 	pteval = mk_pte(page, prot);
 	if (unlikely(is_zero_folio(folio))) {
 		pteval = pte_mkspecial(pteval);
 	} else {
 		folio_get(folio);
+		entry = mk_pte(page, prot);
+		if (mkwrite) {
+			entry = pte_mkyoung(entry);
+			entry = maybe_mkwrite(pte_mkdirty(entry), vma);
+		}
 		inc_mm_counter(vma->vm_mm, mm_counter_file(folio));
 		folio_add_file_rmap_pte(folio, page, vma);
 	}
@@ -2063,7 +2091,7 @@ static int insert_page_into_pte_locked(struct vm_area_struct *vma, pte_t *pte,
 }
 
 static int insert_page(struct vm_area_struct *vma, unsigned long addr,
-			struct page *page, pgprot_t prot)
+			struct page *page, pgprot_t prot, bool mkwrite)
 {
 	int retval;
 	pte_t *pte;
@@ -2076,7 +2104,8 @@ static int insert_page(struct vm_area_struct *vma, unsigned long addr,
 	pte = get_locked_pte(vma->vm_mm, addr, &ptl);
 	if (!pte)
 		goto out;
-	retval = insert_page_into_pte_locked(vma, pte, addr, page, prot);
+	retval = insert_page_into_pte_locked(vma, pte, addr, page, prot,
+					mkwrite);
 	pte_unmap_unlock(pte, ptl);
 out:
 	return retval;
@@ -2090,7 +2119,7 @@ static int insert_page_in_batch_locked(struct vm_area_struct *vma, pte_t *pte,
 	err = validate_page_before_insert(vma, page);
 	if (err)
 		return err;
-	return insert_page_into_pte_locked(vma, pte, addr, page, prot);
+	return insert_page_into_pte_locked(vma, pte, addr, page, prot, false);
 }
 
 /* insert_pages() amortizes the cost of spinlock operations
@@ -2226,7 +2255,7 @@ int vm_insert_page(struct vm_area_struct *vma, unsigned long addr,
 		BUG_ON(vma->vm_flags & VM_PFNMAP);
 		vm_flags_set(vma, VM_MIXEDMAP);
 	}
-	return insert_page(vma, addr, page, vma->vm_page_prot);
+	return insert_page(vma, addr, page, vma->vm_page_prot, false);
 }
 EXPORT_SYMBOL(vm_insert_page);
 
@@ -2506,7 +2535,7 @@ static vm_fault_t __vm_insert_mixed(struct vm_area_struct *vma,
 		 * result in pfn_t_has_page() == false.
 		 */
 		page = pfn_to_page(pfn_t_to_pfn(pfn));
-		err = insert_page(vma, addr, page, pgprot);
+		err = insert_page(vma, addr, page, pgprot, mkwrite);
 	} else {
 		return insert_pfn(vma, addr, pfn, pgprot, mkwrite);
 	}
-- 
git-series 0.9.1


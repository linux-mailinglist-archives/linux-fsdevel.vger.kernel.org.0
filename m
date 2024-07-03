Return-Path: <linux-fsdevel+bounces-23021-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 81EEA925F68
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jul 2024 13:59:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 029D31F21333
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jul 2024 11:59:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2CA8177981;
	Wed,  3 Jul 2024 11:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="G+Kz0LdU";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="TbEaPJlV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DBF017624E;
	Wed,  3 Jul 2024 11:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720007900; cv=fail; b=chZZ5AErgnfAnBiaopfSyaLRXZlrHC752jfhKjrcpeXRyye0Mnw+n6whA/HzlWKjZaNlfpmpUbq8rVvMmf5nwyhBsZ9YJtHkaUgolkYL4axIR4wJiZmth4fDnwILKu6G9h4eOmmqguvH8EF4TcpjbZWdUl8YhR1t2wRMikuz2UM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720007900; c=relaxed/simple;
	bh=Ra6M4rtT/0LKv+r18UjaZ7XOFLWFl1xu42O4XnR48DY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LjzeI8adAA6/pRKFSVdifgNwBifXgr53bNNy+TuTF4A0yjATcJTGoYwkL8XojkpNFVjEeqZ8TmT4W2N17xGgukbwvpaFYyEIbzMZhngUpOgl+Uu2Q0xxaDt/XdnSb1qLr7Q/2OQRxuT1nkcUnHMZ8c4ax2/o808jMdnKz4FgS4g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=G+Kz0LdU; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=TbEaPJlV; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4638OHOg030257;
	Wed, 3 Jul 2024 11:58:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:content-transfer-encoding:content-type:mime-version; s=
	corp-2023-11-20; bh=MzhyD6cb3BiXjeh/IjbwiE2Jy8JsxlBCHvbf47q1oBw=; b=
	G+Kz0LdU1fnhVQbd3FPTKWkG33x4t5x9IJaDfKxodiBhS9qYS824qATcxFVlrF+1
	hZv+Y2RDgd3DTFEL9w80cJbhSO6CYKK8jv1Rypg8s7KTR9F9d614nLo3Jl/ijTyw
	J+zGy5HRe92SAOp7r8WFc0n2MdxvY0LW0RqnS3IzfvgtNDtwr8PdUrQlgV5leWM+
	zWAzujmzDxF1qSfhihWbHvl7UWGDKq+PdmSqKoEUodYwkIXE81KfNm5FzfpCz0De
	ZOoUXBw1T0YXBFAFk9hzvRn+G776taFu2CAEEHThGUqV8PK6FuQeodin1gaZrPWc
	yKDliyyOBNYIZhtGLbZIZw==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40296b01fe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 03 Jul 2024 11:58:05 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 4639ks41021582;
	Wed, 3 Jul 2024 11:58:04 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4028qf5bm2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 03 Jul 2024 11:58:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R5Iy4pTGki4rSJlRoUw8ecU9xvU4/8ngjoT55zyF3b+6Esdd3n0qCMGExMb4hw4mj+tVA4OGhmFMQi1CusWz8k3dQOxl3ghwzZXn2MvBFtk+rmWOXeeXHHqiNDosZfS1fFPXAF1uoEvgrGzdhyqy6q6TylkoycRta/wL6i5Xu/Qe9I0a5P4C9Vg3+4SjKBUvf8RSrrnWrmxYhTOStJb6IVa+yGiQ2l9PidaXApeZ1jD0t5PkH5NR2sdDgvJ0XO2b/CiqKPPkcljTuHVrodrf9K6kX3jZiT8opHMgOYgh/q3BjpC4cL9Xvav3KZRgphITyLWaO/PCUt+dtKG6mV97yA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MzhyD6cb3BiXjeh/IjbwiE2Jy8JsxlBCHvbf47q1oBw=;
 b=HHtg7IIIViTdpzS4UP20SZVZWlZvj2mbG7TxOHFofMN1Z2SVoAVxjJn4YvJYwBsfp/Td7BTvJzD1RIngCCKrTEFYdvuitsi275DtY0uZ5WXQqzmYNQvWbFMOPCtQ8Ptr4ibQqdL4v17LPvxhDvglJ2SjuIQwCMJxjd59Ui/piHSrIEZwgbOq7LsgDVDBGpatT4nntnYQWR7h1ZuzXJf6r+Wei78S+WdaRYPm6Jbyxs7scyQawxCwtNExHO2RYfVrIsuzs61iyzoFAkMI9GFb1jLEngqtcE22RxDtKkIKwELUIJFCrG/DzTkSW7QyxqiIiNsB7IkxOFbFlpW+OK7G5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MzhyD6cb3BiXjeh/IjbwiE2Jy8JsxlBCHvbf47q1oBw=;
 b=TbEaPJlVpfTkz5EfbVq2i8+Q1ec0UhLc7WamBAB3NylGK2tpDJeOoesy/EwmeRiR60dSIS55qxFdzHnNlI1FFxURpyJxqYU0jktNHdo+6tNJ4DQMBy+HN1nk3cgz6XZjbglc7GPENtTwOZLCOox1o7fXGavbOJnnQtrdLFhAsH0=
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com (2603:10b6:a03:3d0::5)
 by SA1PR10MB7832.namprd10.prod.outlook.com (2603:10b6:806:3a9::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.32; Wed, 3 Jul
 2024 11:58:01 +0000
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e]) by SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e%6]) with mapi id 15.20.7741.025; Wed, 3 Jul 2024
 11:58:01 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Matthew Wilcox <willy@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        Eric Biederman <ebiederm@xmission.com>, Kees Cook <kees@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>
Subject: [PATCH 3/7] mm: move vma_shrink(), vma_expand() to internal header
Date: Wed,  3 Jul 2024 12:57:34 +0100
Message-ID: <c1be2cf261bd0d72fe17084c41452f5ebe030d8c.1720006125.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1720006125.git.lorenzo.stoakes@oracle.com>
References: <cover.1720006125.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P265CA0118.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2c6::8) To SJ0PR10MB5613.namprd10.prod.outlook.com
 (2603:10b6:a03:3d0::5)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5613:EE_|SA1PR10MB7832:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d775c25-b6e1-4ae7-131f-08dc9b5763ab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?1v2TF6QHNbUT3P/2GWSDYV2u8ZvqD+xyZbOJFqJZpgmIc4dXUaEu2qvmK47i?=
 =?us-ascii?Q?e6gyGCw69ytS1up0TlEOjER1IUK8h92zxo5kOPOiRWjsct96T9+s76ALG6sd?=
 =?us-ascii?Q?XtUaNqAh3HwpA3uEAOAWB/alNfxLBwfQtJxtBWaPQLY6lA9pei05545a0Uq9?=
 =?us-ascii?Q?5ziekNVheXScDyFjMcKaljbioMFYGnB6NFnojH4ATxMN1IespGOARcyAlDz6?=
 =?us-ascii?Q?MJBYE7ffAm3jaVSSOrRdSTCbM/l/fmUJKgXav3uDZfZhMi4ADI5kYvFOGzLk?=
 =?us-ascii?Q?c5V2F0p9GPp8cGkneFS+LnOtFhQBx5Nx8jAbpaKX0Vav3NDI8IZBWJFDeFhA?=
 =?us-ascii?Q?AgqcJ8WkhrtbapaDnN/29BwbTyaHk8byWkKAPRV4Ymnjwvv5n8t5zaeCyvvL?=
 =?us-ascii?Q?UY+mWwfghJgVnfwQeAU203Phm88voOJXqlmE7w2Ug1Bw1j5MAYG+Q3ZoJZMZ?=
 =?us-ascii?Q?/fJ6MvBR0vzREHFbXKUvHCWJRcCcmoy5XAbu90KSjN/JehWYkITMH8z8QEmW?=
 =?us-ascii?Q?aiWX15bh657NqwhHdMEE2+FQzrFWIv+TuTUSFoLgXgkfJypD8YQo/aUKPVHt?=
 =?us-ascii?Q?OxlZtkb6roVLR8L3T2Fgp/OzcURcN2NSc9DeVSQlyWGy9yF4UBTVvUm47hwI?=
 =?us-ascii?Q?ZyI758uPOvTYqNlho3PCPxDC1/oEkzUg7oxzBZBX4wYFeIwELivj8R7/ttdY?=
 =?us-ascii?Q?Xm8m1nbLGy+2WO2I8496OwpRLKvPcNRPAXQsxQbWlUQPFssSwrwt6JDrkR+/?=
 =?us-ascii?Q?6HqLjvG4Jljgh2A4QYcvsKb9QWcqaT6E2dVidCmRwCGsJq/ALqn+R8SKg6S5?=
 =?us-ascii?Q?PU26+mYjMaQEWSYDZ1cv2UbO1DPDm3ZZOQ2GB6rlkN6MiwV1t+WhmKABvPrX?=
 =?us-ascii?Q?BEkZbeTstdcvD13iDMHFMWN2p+zZQ4rxXGY+ll4a+rYn4w/3wMbN3+bso/tP?=
 =?us-ascii?Q?JpAdStsEiJCEHII0rh2VSTqC3aJgiwfkuzQV/CqEkDUt17LbgB8wUeWqaWBG?=
 =?us-ascii?Q?j3yaIQr6eQhg6lW0dcaTcuYLyBDwxDgDS8/RwXEdyG4DiH8qcy1uRWQwXNdX?=
 =?us-ascii?Q?KxFH4sZjQwlhKsAPlmLjsldbHBQSWgnCeyDDq+DNBWEidh6T4+CSad0q626k?=
 =?us-ascii?Q?JP7UZokecXIo53wFigGdNQvlgGdQKQJhAoUcyM/JCb2SxxcxCq+/v4uKLDnF?=
 =?us-ascii?Q?lSLYvL2w/hLu9B7qr+wAKnA6Q2caqJM7mVmdHNDPN3WhQMizavF9Uc/Sohv4?=
 =?us-ascii?Q?BhCq/bDZJsZRBcPC2GDV8hvgJNhZzrkQ0gp8X2emjcxoQrmK1zHo75uhUncx?=
 =?us-ascii?Q?bbkHsGiNsOhWfKT0eb5c0X0eG3w9ONXj8ScCtOIHX8wbOQ=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5613.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?bgYdqoTcX3EUYTYGDULG6ceK+o8LPLs/m8QtIYpHDJdrCuYf7PoVp2qG9+eG?=
 =?us-ascii?Q?7LJJJzdj9dDLj4w6AZr1BDm3Je5oCE3tqKGmGiiD17QeSz4KQy64yu1m98iB?=
 =?us-ascii?Q?Qn+jZ8JbroHq/+UbKbujQZNWET5fh0Bj+1QcUVWbLh3AFacU2CHEE9NXEebN?=
 =?us-ascii?Q?wv+1lQI3JbON3Q1BetDpzLbBWqFYj4YHDVW/Mt1I9o4h9WnoIwmaYAkxqMpP?=
 =?us-ascii?Q?zWa5thGNmukz2f/Sj3BkyUuZ5oDtwTYIAaKLlJb6wzZ/CwhGNLO1GhDhHq8y?=
 =?us-ascii?Q?yMGTRv5o2wRHWrSOLssQtWe4leQbXlpp7KLYhPhXmJjxoe+Umgc5g5VAgJsb?=
 =?us-ascii?Q?gJhyRFFiD75Kdl2FzwA5aJFu/Uj3/gLIj8E9tx7lkNr+amWkvY4UUQt4KlEF?=
 =?us-ascii?Q?ptvJNL2IqnhJH7An1+R7DbMxsCMaYYix9ZKYQD/wMSa90GKShQfDZDnBtanu?=
 =?us-ascii?Q?gn6vQjXUMV0SyHOkbUF+kkYNQIKwIfj+WspBhY/e/flxfYPUGMnonc9rlB3F?=
 =?us-ascii?Q?ZAk5ckz4PNCNSVJVca+4ZP6FvEqGh2UfpqMyGlfxAwFl27t8yjevcvBtMcB/?=
 =?us-ascii?Q?XF6ka9xeC4KJS8ZVFNAnZbvZGVGLqzL+w0rqTQ5dHNZ6ly53AbZLurZuQnop?=
 =?us-ascii?Q?b7r7IseI7bSeMJtNczUKmWPvo5PVmgyQyMUV6/4PdEC8ET1r5izkH0TUXwMj?=
 =?us-ascii?Q?1MrNsFSqT8GDU/7ixNqL2gK2TWHx9x8XjPiPzCSAnNimENOBjW71WPkf9YQC?=
 =?us-ascii?Q?qHmHY3Y/9LB6cifzvBMiV3b1U2LimwZPJ/JOd/pa+7oTDtrcSVBv5/V30t6v?=
 =?us-ascii?Q?tlAGrxVwQF8oj48kPPmVTZPFYayZODLifTFJ5flvkIf9sV82giLiFr4rqZsp?=
 =?us-ascii?Q?nEpaMCJumziQo/cVuSf7Qi0ECjUxGz4lK9Cd11oO0/Hxnn2IkTbJ7NTuDfS7?=
 =?us-ascii?Q?PJNbXbq88Efqb9hNDhZvHNhIVtITgwlrkiukjBnK2Ld7iglYEMa44Di+a3Ei?=
 =?us-ascii?Q?7ClwaWMFauhxE7Ow/oXf1qhdOoMmhhityosVk5XbRw2stYzstXgNUS6L3Xwm?=
 =?us-ascii?Q?6kjtIL3gZ0toJ9Fz0GvuBCzJPv85CPYY0UVo01n9qXQxLrqvRzi6i3bLeva3?=
 =?us-ascii?Q?xXnvkZ2D7QujR4aEgFrCEf69dtSgQvDWwLCsdFL+u5IJ0PJKhUhwcSNLo2/N?=
 =?us-ascii?Q?P51pTfB3lMWL+pL79kU9z/yLB5qXWckiotODE9yXDnrDN6Si4FIQ1KCysf9K?=
 =?us-ascii?Q?N/L1ItpBM7+/NzhWpjR53kXg7RvEvS0n+GlDGay0IISY8aTb2A0qXYkhUwOw?=
 =?us-ascii?Q?9BYkGOpM42BKmh+TD1xlXWHiMNgLLoTP+BaZ6ugU1tyfX7jcUI15/uUw0VOh?=
 =?us-ascii?Q?qVdWhmHn7SELebXNWZjT6pff22GhMK75Sei1kUKvWJIACWsN5SzvKvwpwud9?=
 =?us-ascii?Q?Eu1GBwveGtej+QDoWw6PwR/zsU0LzOMIunT/DZLE/nZmcPmm8YFlWU0g3lEI?=
 =?us-ascii?Q?WlDZ6Irc/pSmS7424luP53WWKL70d6wMwEt6CL3jsJSYT+vwB80zyeCJ11ez?=
 =?us-ascii?Q?cUODfDTE3pkX+vcJ9INLnSkHPpS05pryWlg/9YuAGItzPujurbeq03UchJ+X?=
 =?us-ascii?Q?QA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	QDojYLuDGhfFWBa1f8TB5R8yPxw7vYgi+UvPnSYRqLluUK9nsYKq3uBiKriH2WcAK5qhQeimLc0p4pfCqLHs9gyiaO7fgiyLvmuGHNXaWOrjQAF+RcYIo9hcpmQHG0pryXoHPLAeYA2F7F1exYqja3OVVrHc4Q9MwPtH4ResnyWxVwDQH99LpXLAD1XldPqJn4Ji0+0/0EC7Z3oLF9WFBK05G9xSiPwFiSRRljFKk8rbRvNBztp++OSFCjH8X6+hackXcPka5I5nHMLWncYk8zF0cBxcrBdPgKA7S/6k1cnHUXhicNOAZntdOsc5I26YLDTnwJQ4oKkSyQKUosaeF3F2sZ6UYzxpzgX3ay5jp4Ils9iWNMTnMGWDLkjzVU4mZ4pSuFHt4JHDGYF0WvGyq0lBKWlc1jOAXDmm4mIX2Cl3Qj+CnMW9j60MZ7LXSZAmfjfJe24m5gUcaFvpDf1jJi7jpAyAPNIWascMkJRKzloHhf99Oq+OBMEvmmOk/g1b4dYufZsxvyqusO2YNzrZFWQe+vLUy8IGVmwxdF+1TMV+ie5YFExrgay3CUR0yMPoL01PlhBNAdBz76OU+p3E8AL+eVrcDRETSCoR7i6BO5M=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d775c25-b6e1-4ae7-131f-08dc9b5763ab
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5613.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2024 11:58:01.8489
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T7Jyl3/AXIRskJ6gor/ctinQ9Bt2aJymeNLLobzq3t3JjqHeCDRPlvv0eEjyO04aiPtl51Giw5gnXOfgeRG0sbzS/+j06WHuwyMl8JWgUt8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB7832
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-03_07,2024-07-03_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0 mlxscore=0
 phishscore=0 malwarescore=0 suspectscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2406180000
 definitions=main-2407030087
X-Proofpoint-GUID: 8RlY13dTiF4awPZUYWnwXz7HZfPWZG4l
X-Proofpoint-ORIG-GUID: 8RlY13dTiF4awPZUYWnwXz7HZfPWZG4l

The vma_shrink() and vma_expand() functions are internal VMA manipulation
functions which we ought to abstract for use outside of memory management
code.

To achieve this, we replace shift_arg_pages() in fs/exec.c with an
invocation of a new relocate_vma_down() function implemented in mm/mmap.c,
which enables us to also move move_page_tables() and vma_iter_prev_range()
to internal.h.

The purpose of doing this is to isolate key VMA manipulation functions in
order that we can both abstract them and later render them easily testable.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 fs/exec.c          | 81 ++++------------------------------------------
 include/linux/mm.h | 17 +---------
 mm/internal.h      | 18 +++++++++++
 mm/mmap.c          | 81 ++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 106 insertions(+), 91 deletions(-)

diff --git a/fs/exec.c b/fs/exec.c
index 40073142288f..8596d325250c 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -680,80 +680,6 @@ static int copy_strings_kernel(int argc, const char *const *argv,

 #ifdef CONFIG_MMU

-/*
- * During bprm_mm_init(), we create a temporary stack at STACK_TOP_MAX.  Once
- * the binfmt code determines where the new stack should reside, we shift it to
- * its final location.  The process proceeds as follows:
- *
- * 1) Use shift to calculate the new vma endpoints.
- * 2) Extend vma to cover both the old and new ranges.  This ensures the
- *    arguments passed to subsequent functions are consistent.
- * 3) Move vma's page tables to the new range.
- * 4) Free up any cleared pgd range.
- * 5) Shrink the vma to cover only the new range.
- */
-static int shift_arg_pages(struct vm_area_struct *vma, unsigned long shift)
-{
-	struct mm_struct *mm = vma->vm_mm;
-	unsigned long old_start = vma->vm_start;
-	unsigned long old_end = vma->vm_end;
-	unsigned long length = old_end - old_start;
-	unsigned long new_start = old_start - shift;
-	unsigned long new_end = old_end - shift;
-	VMA_ITERATOR(vmi, mm, new_start);
-	struct vm_area_struct *next;
-	struct mmu_gather tlb;
-
-	BUG_ON(new_start > new_end);
-
-	/*
-	 * ensure there are no vmas between where we want to go
-	 * and where we are
-	 */
-	if (vma != vma_next(&vmi))
-		return -EFAULT;
-
-	vma_iter_prev_range(&vmi);
-	/*
-	 * cover the whole range: [new_start, old_end)
-	 */
-	if (vma_expand(&vmi, vma, new_start, old_end, vma->vm_pgoff, NULL))
-		return -ENOMEM;
-
-	/*
-	 * move the page tables downwards, on failure we rely on
-	 * process cleanup to remove whatever mess we made.
-	 */
-	if (length != move_page_tables(vma, old_start,
-				       vma, new_start, length, false, true))
-		return -ENOMEM;
-
-	lru_add_drain();
-	tlb_gather_mmu(&tlb, mm);
-	next = vma_next(&vmi);
-	if (new_end > old_start) {
-		/*
-		 * when the old and new regions overlap clear from new_end.
-		 */
-		free_pgd_range(&tlb, new_end, old_end, new_end,
-			next ? next->vm_start : USER_PGTABLES_CEILING);
-	} else {
-		/*
-		 * otherwise, clean from old_start; this is done to not touch
-		 * the address space in [new_end, old_start) some architectures
-		 * have constraints on va-space that make this illegal (IA64) -
-		 * for the others its just a little faster.
-		 */
-		free_pgd_range(&tlb, old_start, old_end, new_end,
-			next ? next->vm_start : USER_PGTABLES_CEILING);
-	}
-	tlb_finish_mmu(&tlb);
-
-	vma_prev(&vmi);
-	/* Shrink the vma to just the new range */
-	return vma_shrink(&vmi, vma, new_start, new_end, vma->vm_pgoff);
-}
-
 /*
  * Finalizes the stack vm_area_struct. The flags and permissions are updated,
  * the stack is optionally relocated, and some extra space is added.
@@ -846,7 +772,12 @@ int setup_arg_pages(struct linux_binprm *bprm,

 	/* Move stack pages down in memory. */
 	if (stack_shift) {
-		ret = shift_arg_pages(vma, stack_shift);
+		/*
+		 * During bprm_mm_init(), we create a temporary stack at STACK_TOP_MAX.  Once
+		 * the binfmt code determines where the new stack should reside, we shift it to
+		 * its final location.
+		 */
+		ret = relocate_vma_down(vma, stack_shift);
 		if (ret)
 			goto out_unlock;
 	}
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 4d2b5538925b..418aca7e37a6 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -998,12 +998,6 @@ static inline struct vm_area_struct *vma_prev(struct vma_iterator *vmi)
 	return mas_prev(&vmi->mas, 0);
 }

-static inline
-struct vm_area_struct *vma_iter_prev_range(struct vma_iterator *vmi)
-{
-	return mas_prev_range(&vmi->mas, 0);
-}
-
 static inline unsigned long vma_iter_addr(struct vma_iterator *vmi)
 {
 	return vmi->mas.index;
@@ -2523,11 +2517,6 @@ int set_page_dirty_lock(struct page *page);

 int get_cmdline(struct task_struct *task, char *buffer, int buflen);

-extern unsigned long move_page_tables(struct vm_area_struct *vma,
-		unsigned long old_addr, struct vm_area_struct *new_vma,
-		unsigned long new_addr, unsigned long len,
-		bool need_rmap_locks, bool for_stack);
-
 /*
  * Flags used by change_protection().  For now we make it a bitmap so
  * that we can pass in multiple flags just like parameters.  However
@@ -3273,11 +3262,6 @@ void anon_vma_interval_tree_verify(struct anon_vma_chain *node);

 /* mmap.c */
 extern int __vm_enough_memory(struct mm_struct *mm, long pages, int cap_sys_admin);
-extern int vma_expand(struct vma_iterator *vmi, struct vm_area_struct *vma,
-		      unsigned long start, unsigned long end, pgoff_t pgoff,
-		      struct vm_area_struct *next);
-extern int vma_shrink(struct vma_iterator *vmi, struct vm_area_struct *vma,
-		       unsigned long start, unsigned long end, pgoff_t pgoff);
 extern struct anon_vma *find_mergeable_anon_vma(struct vm_area_struct *);
 extern int insert_vm_struct(struct mm_struct *, struct vm_area_struct *);
 extern void unlink_file_vma(struct vm_area_struct *);
@@ -3285,6 +3269,7 @@ extern struct vm_area_struct *copy_vma(struct vm_area_struct **,
 	unsigned long addr, unsigned long len, pgoff_t pgoff,
 	bool *need_rmap_locks);
 extern void exit_mmap(struct mm_struct *);
+extern int relocate_vma_down(struct vm_area_struct *vma, unsigned long shift);

 static inline int check_data_rlimit(unsigned long rlim,
 				    unsigned long new,
diff --git a/mm/internal.h b/mm/internal.h
index 81564ce0f9e2..a4d0e98ccb97 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -1305,6 +1305,12 @@ static inline struct vm_area_struct
 			  vma_policy(vma), new_ctx, anon_vma_name(vma));
 }

+int vma_expand(struct vma_iterator *vmi, struct vm_area_struct *vma,
+	      unsigned long start, unsigned long end, pgoff_t pgoff,
+	      struct vm_area_struct *next);
+int vma_shrink(struct vma_iterator *vmi, struct vm_area_struct *vma,
+	       unsigned long start, unsigned long end, pgoff_t pgoff);
+
 enum {
 	/* mark page accessed */
 	FOLL_TOUCH = 1 << 16,
@@ -1528,6 +1534,12 @@ static inline int vma_iter_store_gfp(struct vma_iterator *vmi,
 	return 0;
 }

+static inline
+struct vm_area_struct *vma_iter_prev_range(struct vma_iterator *vmi)
+{
+	return mas_prev_range(&vmi->mas, 0);
+}
+
 /*
  * VMA lock generalization
  */
@@ -1639,4 +1651,10 @@ void unlink_file_vma_batch_init(struct unlink_vma_file_batch *);
 void unlink_file_vma_batch_add(struct unlink_vma_file_batch *, struct vm_area_struct *);
 void unlink_file_vma_batch_final(struct unlink_vma_file_batch *);

+/* mremap.c */
+unsigned long move_page_tables(struct vm_area_struct *vma,
+	unsigned long old_addr, struct vm_area_struct *new_vma,
+	unsigned long new_addr, unsigned long len,
+	bool need_rmap_locks, bool for_stack);
+
 #endif	/* __MM_INTERNAL_H */
diff --git a/mm/mmap.c b/mm/mmap.c
index e42d89f98071..c1567b8b2a0a 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -4058,3 +4058,84 @@ static int __meminit init_reserve_notifier(void)
 	return 0;
 }
 subsys_initcall(init_reserve_notifier);
+
+/*
+ * Relocate a VMA downwards by shift bytes. There cannot be any VMAs between
+ * this VMA and its relocated range, which will now reside at [vma->vm_start -
+ * shift, vma->vm_end - shift).
+ *
+ * This function is almost certainly NOT what you want for anything other than
+ * early executable temporary stack relocation.
+ */
+int relocate_vma_down(struct vm_area_struct *vma, unsigned long shift)
+{
+	/*
+	 * The process proceeds as follows:
+	 *
+	 * 1) Use shift to calculate the new vma endpoints.
+	 * 2) Extend vma to cover both the old and new ranges.  This ensures the
+	 *    arguments passed to subsequent functions are consistent.
+	 * 3) Move vma's page tables to the new range.
+	 * 4) Free up any cleared pgd range.
+	 * 5) Shrink the vma to cover only the new range.
+	 */
+
+	struct mm_struct *mm = vma->vm_mm;
+	unsigned long old_start = vma->vm_start;
+	unsigned long old_end = vma->vm_end;
+	unsigned long length = old_end - old_start;
+	unsigned long new_start = old_start - shift;
+	unsigned long new_end = old_end - shift;
+	VMA_ITERATOR(vmi, mm, new_start);
+	struct vm_area_struct *next;
+	struct mmu_gather tlb;
+
+	BUG_ON(new_start > new_end);
+
+	/*
+	 * ensure there are no vmas between where we want to go
+	 * and where we are
+	 */
+	if (vma != vma_next(&vmi))
+		return -EFAULT;
+
+	vma_iter_prev_range(&vmi);
+	/*
+	 * cover the whole range: [new_start, old_end)
+	 */
+	if (vma_expand(&vmi, vma, new_start, old_end, vma->vm_pgoff, NULL))
+		return -ENOMEM;
+
+	/*
+	 * move the page tables downwards, on failure we rely on
+	 * process cleanup to remove whatever mess we made.
+	 */
+	if (length != move_page_tables(vma, old_start,
+				       vma, new_start, length, false, true))
+		return -ENOMEM;
+
+	lru_add_drain();
+	tlb_gather_mmu(&tlb, mm);
+	next = vma_next(&vmi);
+	if (new_end > old_start) {
+		/*
+		 * when the old and new regions overlap clear from new_end.
+		 */
+		free_pgd_range(&tlb, new_end, old_end, new_end,
+			next ? next->vm_start : USER_PGTABLES_CEILING);
+	} else {
+		/*
+		 * otherwise, clean from old_start; this is done to not touch
+		 * the address space in [new_end, old_start) some architectures
+		 * have constraints on va-space that make this illegal (IA64) -
+		 * for the others its just a little faster.
+		 */
+		free_pgd_range(&tlb, old_start, old_end, new_end,
+			next ? next->vm_start : USER_PGTABLES_CEILING);
+	}
+	tlb_finish_mmu(&tlb);
+
+	vma_prev(&vmi);
+	/* Shrink the vma to just the new range */
+	return vma_shrink(&vmi, vma, new_start, new_end, vma->vm_pgoff);
+}
--
2.45.2


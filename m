Return-Path: <linux-fsdevel+bounces-54526-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA4F4B007B1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Jul 2025 17:53:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5295F4E8104
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Jul 2025 15:53:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F1FD27E1C0;
	Thu, 10 Jul 2025 15:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Rv5UfvEq";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Swi3536E"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC21827C14B;
	Thu, 10 Jul 2025 15:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752162721; cv=fail; b=EYoIJVFUMKFEJ//4QgIf8YLRuFIl8SJEVR/6sVTSyaC0I0GM4Q+6LL/FCNdNHY4NGSWqwC5/VKVLn07pgMQAQYEbNQNOZ6GL788J1z993G0tZHWvWEDKFjE1bTQCdWYUf2rPekPq++i2BpPJV4eil4fCQKia6jisjh0AiX+sRF0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752162721; c=relaxed/simple;
	bh=rubp4EBrQsLX31k+bTmrsLo8VzGijXlxPXgX2LPCJpw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=AvnKJA5NdjRn5uq+PxI+B48Ei2ZiBHpIam7nl3AxjtmtXmwcgKM8F6kw6lZ6P8W7j+X9UhrhkLsjvEZg8XK87dG7GzDZLLxU00F3ePdalbfActrV2noCBeOVhp0mCSfXCUivxzhSAxGh4Dr0OMgvm4bBGc5rUgMIuBfheAsG+AA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Rv5UfvEq; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Swi3536E; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56AEl0pd000637;
	Thu, 10 Jul 2025 15:51:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=4kr+QnoNSM9F5XY1TkuPv/psT11/S1/R0O/NyaF1dYg=; b=
	Rv5UfvEqWXu6O9EJWBvz4Sb8xC+ouGtljjY3jypgeag3pTGqK4DfWX1UEcEW7Sgi
	pN8sNgPHVPejhN3VS11d7sp91hicJ3ZCYXzomBz9WsLVQTTXKopMIZL3C2F37T45
	fG+S4DeNYBGWnhA5fHLg5XixzW/1MgXibzYIZiTtCrrY+Mys3NslQZVYqgYgqaCi
	1H9h4F7ZZOly7MEMcriXFz6XEvEAJ1L+8ONg7c02Z3+NiS9WdpBRwrSfZBDMB+Ks
	ys+Rk53on/mSlFmD8GOxZzhyQK1KoDcdglxtHOFY7LvVXoFnxPfeDL0OlpYA2T7W
	3ndomS+c2R0Ls448/T0dIg==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47tfjy858a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 10 Jul 2025 15:51:10 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56AF51fL013560;
	Thu, 10 Jul 2025 15:50:55 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12on2072.outbound.protection.outlook.com [40.107.243.72])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 47ptgd800b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 10 Jul 2025 15:50:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZIvaRnADoIc9WZDKcRfij80E+89Eoy5jYpUYCtaSKmQ0ae6mwisxNMT5wydz42FKNA4IGcbv36IZIYmHEL9kk9ymGHXJCuT9w8MqpefZaSGSRnmU/q2e9FkgO22PzJtm8tlIpy4lTVfbl35Q+2B2vUGgfZS344KpP0GlHzNWcb5a/dIeKr7jCgR8TForTstVlePbQM+qSPkpzOJOitHJOF6xp/CkwfFEO6O9zi/0VP+4CKrNtb1g1DwcpmrBkVbN/OdtOsSSoTx5IcB/snh3+RLnh8Vea6+FP5ty+1ZdjEOVVDH86pB7vGbjDLxfX4ly4QS6x/pnFRuMWF1AWcg4fA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4kr+QnoNSM9F5XY1TkuPv/psT11/S1/R0O/NyaF1dYg=;
 b=oD1RyrB/SEf2Tvg8Yj//mFnPIchn2O8QP48sm+yhqMyM1YES+Avmgw743IxQIhmbxMmIqF3fwba5QzL/kNlamh9x+OojPT8ieoN6A35WThd/ZEd11DRYgN2j3lvu5tcGvpkHfxhDKt1tOSQIixCluOjQrGV9ORCWICfwfOONnujf6hStwmzL/m2RWYOfgm2znSvF5R4noTevBwf0qYvKN0cOmaG++L8zzivL7yb1ixJJApczLlDE56yFBJeq8sJSX+D8AwggAXVqLuggFnGn1fqEn+p7qEmk4A5NBfKW66c41ZXv6PCAU+ZhB+ixksW3yyVppoS+K7XeuGTVjv1anw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4kr+QnoNSM9F5XY1TkuPv/psT11/S1/R0O/NyaF1dYg=;
 b=Swi3536EHB2VNv7CV86bcrFzkCI3DR8x0TFXqRPdWIeMD6sMV9MhmKSB28UqG/vVhQlS8wT2D8ENBC0r2U52Tc24U3kkDGiDrJQc0KuoCHc4ogZ6NgtQQIfqUr5tnQSM0V5K+EjIJUtjA6Byj8dWqVHzdHCSaSKNH7SG2yBddrA=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by BLAPR10MB4996.namprd10.prod.outlook.com (2603:10b6:208:30c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.22; Thu, 10 Jul
 2025 15:50:52 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%6]) with mapi id 15.20.8901.024; Thu, 10 Jul 2025
 15:50:52 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Peter Xu <peterx@redhat.com>, Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        Pedro Falcato <pfalcato@suse.de>, Rik van Riel <riel@surriel.com>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: [PATCH v2 05/10] mm/mremap: use an explicit uffd failure path for mremap
Date: Thu, 10 Jul 2025 16:50:29 +0100
Message-ID: <587d14070be9dbd935616749768b0c31f969f838.1752162066.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <cover.1752162066.git.lorenzo.stoakes@oracle.com>
References: <cover.1752162066.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0256.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:194::9) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|BLAPR10MB4996:EE_
X-MS-Office365-Filtering-Correlation-Id: cb3a91e0-7f5b-4ced-f4f9-08ddbfc98cba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?UgoGSD47f0kKRvGki0P2Bzy7mr3g7p9Kmqk8IH8wsGTSeAs+B5tB2sW0MA7z?=
 =?us-ascii?Q?LBd7QUdxDLQ4sTvqBY6+SEitax0wyycTwKgyvtCyG4snzkhKUHUYxcBEk/7r?=
 =?us-ascii?Q?uooV52zcuDJKYrXKXbzqkXZAufAUlnlVSgWP0ObakSWWWKOzZzwhGXsa587k?=
 =?us-ascii?Q?aoSQH4Uip/ywfQiaUnnJ2NH7EBN5Oc+pVvNZ+cpXm78DgzoSDiL+cxHlpyb9?=
 =?us-ascii?Q?7y7maa8APUlTNedK5yprc0S2nx5eqDSLxtkbrONIAj+jAYpKj40aQjMdPVGf?=
 =?us-ascii?Q?6mTD4sy4YITvRX6TBNpxVIr19vuLpo0YnyNhWMa/UNlC58rQVnFxWcQvu4gL?=
 =?us-ascii?Q?dEvDXGPhmh231SMQzRYvR1ZvmW5Os2awJW8I3K11Bf/UFdOxmcq2W9lVMCe8?=
 =?us-ascii?Q?rDjnCmbjHQtxUJVgjKO/dIQH4ur8Zx85UbJ2bq9TgMuG0+/UZT8YLAE9Rncq?=
 =?us-ascii?Q?uvTjwgCJGFXelU+OutVwM+QHZVxOt5zp6MtbD8VDFry3vG5zLR9JFIsTYYlX?=
 =?us-ascii?Q?BoQocVFNoLpuoX0EPtX+QhgF9cXu/C8/qYyML/rzU+sJXCkEb2wb26lN0VRn?=
 =?us-ascii?Q?2vHUcDxbbL5K973Ky9vuBrAzlRxqmhTuG3riW2ZYlo/edmCikenFG1VaYCz1?=
 =?us-ascii?Q?5lpwSqJT3W75MnVflD0RddNyVIKASzv8/R+iasIREaCAbRYf//0/LxB6a0mP?=
 =?us-ascii?Q?dYg+tfyvsOnHoDhzmEX/FJGCsvJsw1Vqil1AFbW18ym9tBi2K5bfr4QTk54y?=
 =?us-ascii?Q?mDsvUg7+hwJ7TKsCKSZIHk1c3kBnPSJlK1O1SpyVYqzfMAQ1+4cYbrjKVnao?=
 =?us-ascii?Q?OfhD9XpvRkB2lyxDIjTuiij5gYzR1iBlpfzAA8nuJbBrQ3WKqFl0iH/+FHWI?=
 =?us-ascii?Q?jADB7kbzEkF1WsSC736WaaWmzh8NXnerOFgN/vIG8XtGKKVVmhbhpRJ/HSr3?=
 =?us-ascii?Q?JGgF5BOUXP5cswB3BtdoGUA6xH8AMB8tSX5XIbae9NMDlon6mJWPyxmb5//i?=
 =?us-ascii?Q?vWnvwkbYP1jUZC3M9QeZHSYvWitaZBmVazXiAnDiPIFT0Mr+hi/JEJwIe628?=
 =?us-ascii?Q?4kfpMQn+aG5jsMXCj/IHDBIsSpMiZM6K5WUJ745VCtX3ghDmsPLEvcaQHBWa?=
 =?us-ascii?Q?HkxZTzdSgEkOwtMNan6pWi4Ayz0oUWrjVZNYRx6rYVy513DPYT8CFvaRl/yE?=
 =?us-ascii?Q?IE/Pr3ijrFHfqetggpo4y4fhf3PA6rkdhbSFRHRtBEwKYQr8bUmI5AgMUmXn?=
 =?us-ascii?Q?2Askf+s6cs24BgizO1XlOyer8rJw0+v0hYLKw4SGrjeWZFFQd9AiyGN7fgkR?=
 =?us-ascii?Q?v7ttI/uZ9kb3B5hsujKlRMm6J2Vu9H2PLrW1BaerQCXuWWDlSTE5aKdFrQBD?=
 =?us-ascii?Q?HpURRsov34l02Z3wz4eD2Wdd1G+84hAr6XR09cmjmOZuXtDeOb/OptolbX1i?=
 =?us-ascii?Q?4l/554sUZwk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?nJAVMeAydXXWeTbsrvNXyIaWFX4+/VkdG87qXTbwH9cuL2JSo4TYZRKckwtG?=
 =?us-ascii?Q?7Zd2wN/fgYpYqfV7qznqwCUJQqZe+EL8P16g2KTDjwskz2TuRa8NJ787ymsj?=
 =?us-ascii?Q?5gs16lKMbz2RokGVRHudAvwtWpBqDNJ8mZ3SvvnZEACs8WM1BUPEN5SehOtG?=
 =?us-ascii?Q?Xpx3eBpltfuf2nkbsj4zozGLztXi0/4KMeqSetCgsCG8ESwgAaD31aYCc/Hb?=
 =?us-ascii?Q?ekD2X5fvB/Afl5WicDMxo+l8QRQd+g63n9gGrb5X+Fgve5B6Ix71r3pZy3+N?=
 =?us-ascii?Q?erZlUYCx+/i73xT/HS9g/FD1rtTTsuhNvWpFVu+25cjjlQbl8jNtKPOwvmS4?=
 =?us-ascii?Q?e/dK9kBuZRWfuOGuOO4HTH5AhECLJdd6pSMzptEdhJb/Lj69rc+HfYk5DHNf?=
 =?us-ascii?Q?RWbZewpGVasRxt7KS6F4owq+61LPd/rdtgfH/7htMdR/SqPf5MG7+gIu6wRy?=
 =?us-ascii?Q?/Jw4fA6tl5hLC5gxbm5/MB0lJJajuim6YoybO5caEYYAWmOiMmdYy0in4I+l?=
 =?us-ascii?Q?23roaxDQiKjF+6OKZSIoWNAR8WQlAHVfUqvyXTpKpC66o8WY/t8k2CnYmZpN?=
 =?us-ascii?Q?XjIicHwxkXcHNe59DNOIfzEH/tW60WWO0Z04HUfYQot/Z4mSFp+VnfNrZFD9?=
 =?us-ascii?Q?yBVRSI7Nxuh1USx0h6ZdLjwr9F/efizZ6zzQJ4SzUeJuJFWDeCdAKA4r7WjO?=
 =?us-ascii?Q?eaTSM8iFF0wPt0zvg44K7HEvwBzHHgb8NAiwHquWVghIervuPXs9ljs1thOi?=
 =?us-ascii?Q?deMxxp/6WGPrLhQesF5dPmkOffmhVaC0O+6UzQ/Rbs9pl8THf8AEgj4AFTbL?=
 =?us-ascii?Q?YhcvQk7L4VQ+8j2SDgiVHy3Smwm7IT7PNU8+VMIQ89WDxp1+1HD3i56071eH?=
 =?us-ascii?Q?Gop8vBi2EWFPAis5nrzum4sesBRvXftW9j1f0ozTv3cnTWpuIMX6F7VIB3/t?=
 =?us-ascii?Q?lpu88Zhao+CkhpvoQKW3BTw3a+UJJtSeXCG3UhvzPc5rf/Ld0H3/A/s066Zy?=
 =?us-ascii?Q?U2dwdkaSlgdTHx7njRKQR4JCSlq9Ugj6FgeSs/l9cboUGpBju6byxRUOc2st?=
 =?us-ascii?Q?nCM7CjjmMx5SpHr2puA7TCD8La9qpprmQJyfxz620lROXvwxabal9pJ0usNY?=
 =?us-ascii?Q?uEcx7Zm2z3FLhhxpeaEHluMp98VDmHcd74jew3DWRyRl6/ZOqeXNspGXYK0a?=
 =?us-ascii?Q?7HiYzmZ8JNtEf2NT4dvJFcASE7S4Qh165fnf7BHYi5fWZKegKLvK4vrrT4cN?=
 =?us-ascii?Q?Y+YtVFe//eQcJPzbIPQ0MsZej8wyp6ktt8JAJErK+8r88TfTk0OPaftTd1mo?=
 =?us-ascii?Q?iwTi6m88dfPR+kHiCDempShhgS3KyS43RaetsuLaDZM/oc3oAlV+WoihKq86?=
 =?us-ascii?Q?2vtuXcMOSRCXz66KQkwqoeg9D8jWgnT907Zkbkj9Zc0fla96UrfRhxo6hPW7?=
 =?us-ascii?Q?n8UUzy5x73cHICpoxKluHvG8VBTUjE3uA6vDifYcJdGEuQcX3HHAFGEJbI2A?=
 =?us-ascii?Q?m/hltIxM9MRXxx2WyEILsMo0RcmJju6jo1VW7UbMmtzMSvQZ4jreJMo8JcmL?=
 =?us-ascii?Q?mz9ZzuSTrtNXmqHRw5eGKWWF3nAefQtWTFUPJlD27ljsaisdMSRbZ+uS/ioZ?=
 =?us-ascii?Q?9g=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	T2mfkMJYvdtBudDhBTOZizD3vHxgS0Jtk5AlovtuOuCjGqrLtDZYTEZMCAYQFa8jhpOaJQOUJOlxG8gYNblICL8jDph+3hL52rmFyl0AxJy+v8iNu9powaqTEZQA+93xRVvG30qCv0EElTHEVYUNo8dWQanve+D+gxcitT8x12i2uTvYjIQb0oxNHF42qw6xJpsgyvX1HlhKnibjyZ12zGZDCikPsnAi5Ffs8tZ+/jTDNNJy2nidJrt4Da8dgZKyo8NcPMPmHhz+m9wdpa5LBYq2f9EfyoT/xwujFXrVMMkci12ePr/5RQ2cVlzdpBSveSfHh+1ZbAA2crIV5BEINORdgXV2E8jYZJX9AGY58LNTx23y1yZtdcV1JBDNMmzQrWMnrxM6ivYQHspwIqOxBGQEP3vmuJOU85DgTkLr9L8fEfXnmeqJgtBIoUoStH3PZFIvsFVV8mD0yXlqJc0AXUa5gbLQbFaxyfMIHwryn6I9q3uYnZ1IbeLFPYs/Hm7Sr7oPng4yflsF5Di0YGb1ADK592jGSRiGWdlaoxT+UzGfhEhRp4xeWT7Qotxa9RAxBFZmA89LLwOk2A2cGA7j+Kr46YQ0Ow4HzRA5+zx66VM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb3a91e0-7f5b-4ced-f4f9-08ddbfc98cba
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2025 15:50:52.7581
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tiNBQrUDPIGcFqLL28XBeKg/6sle8F5SlMZYQ2+u24GnzKMuY90aw3X2XCN9WmNTw8+oLM6RDZRI3hiK0GhtK/zmsSUo3kNNeSd+RNzSy/U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB4996
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-10_04,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 mlxscore=0
 phishscore=0 bulkscore=0 mlxlogscore=999 spamscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507100136
X-Proofpoint-GUID: trVYHsqmyrj6eaZMg8Jt04butXi3FKhe
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzEwMDEzNiBTYWx0ZWRfX/CRTjXSzoQ+0 9c3OV3nkCxQA0ninfoseWmgF7R8w04zvpJIvitJPGDFHb6LkZKwT9oeps3kPeoVz/sZoM/FDY5J h2kvRzdqERRwVW6orsGV6NEZheF72g7ED09PnnjFiPqZmXgt05Cu3I0bWxMxu4yvNEYTYhsX9ag
 9s/Nfaj55stf5FNrGvsXmi05VA6QkfkhdP+qPDUNyllQ3zGGeXWsDyCJhBuEdbHpE6F/7zMXr4q i8CBtvUxiYlSDajemMB89gMVdnTa2WLcKR9W84IYT9tB4jX4YX0d6s3IKZDLLyduxw+5KSUFS4K e/2cqd5WRL5/lVqEk9QaIrKrVm4MdxUJcxo6tZ2fi9V4l1HbVfRvofA9T6rTTCufhFcvBtXrbvi
 0fNAfGLGKk2C/kY18gf8rlN1s/swp/PK7HEto+n5INVLRfBo4icIM1Z1ofm4jq3pbsTtKfPT
X-Proofpoint-ORIG-GUID: trVYHsqmyrj6eaZMg8Jt04butXi3FKhe
X-Authority-Analysis: v=2.4 cv=IMkCChvG c=1 sm=1 tr=0 ts=686fe16e b=1 cx=c_pps a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=D44BCz6ssmwAkLLrWzgA:9 cc=ntf awl=host:13600

Right now it appears that the code is relying upon the returned destination
address having bits outside PAGE_MASK to indicate whether an error value is
specified, and decrementing the increased refcount on the uffd ctx if so.

This is not a safe means of determining an error value, so instead, be
specific. It makes far more sense to do so in a dedicated error path, so
add mremap_userfaultfd_fail() for this purpose and use this when an error
arises.

A vm_userfaultfd_ctx is not established until we are at the point where
mremap_userfaultfd_prep() is invoked in copy_vma_and_data(), so this is a
no-op until this happens.

That is - uffd remap notification only occurs if the VMA is actually moved
- at which point a UFFD_EVENT_REMAP event is raised.

No errors can occur after this point currently, though it's certainly not
guaranteed this will always remain the case, and we mustn't rely on this.

However, the reason for needing to handle this case is that, when an error
arises on a VMA move at the point of adjusting page tables, we revert this
operation, and propagate the error.

At this point, it is not correct to raise a uffd remap event, and we must
handle it.

This refactoring makes it abundantly clear what we are doing.

We assume vrm->new_addr is always valid, which a prior change made the case
even for mremap() invocations which don't move the VMA, however given no
uffd context would be set up in this case it's immaterial to this change
anyway.

No functional change intended.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
---
 fs/userfaultfd.c              | 15 ++++++++++-----
 include/linux/userfaultfd_k.h |  5 +++++
 mm/mremap.c                   | 16 ++++++++++++----
 3 files changed, 27 insertions(+), 9 deletions(-)

diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
index 2a644aa1a510..54c6cc7fe9c6 100644
--- a/fs/userfaultfd.c
+++ b/fs/userfaultfd.c
@@ -750,11 +750,6 @@ void mremap_userfaultfd_complete(struct vm_userfaultfd_ctx *vm_ctx,
 	if (!ctx)
 		return;
 
-	if (to & ~PAGE_MASK) {
-		userfaultfd_ctx_put(ctx);
-		return;
-	}
-
 	msg_init(&ewq.msg);
 
 	ewq.msg.event = UFFD_EVENT_REMAP;
@@ -765,6 +760,16 @@ void mremap_userfaultfd_complete(struct vm_userfaultfd_ctx *vm_ctx,
 	userfaultfd_event_wait_completion(ctx, &ewq);
 }
 
+void mremap_userfaultfd_fail(struct vm_userfaultfd_ctx *vm_ctx)
+{
+	struct userfaultfd_ctx *ctx = vm_ctx->ctx;
+
+	if (!ctx)
+		return;
+
+	userfaultfd_ctx_put(ctx);
+}
+
 bool userfaultfd_remove(struct vm_area_struct *vma,
 			unsigned long start, unsigned long end)
 {
diff --git a/include/linux/userfaultfd_k.h b/include/linux/userfaultfd_k.h
index df85330bcfa6..c0e716aec26a 100644
--- a/include/linux/userfaultfd_k.h
+++ b/include/linux/userfaultfd_k.h
@@ -259,6 +259,7 @@ extern void mremap_userfaultfd_prep(struct vm_area_struct *,
 extern void mremap_userfaultfd_complete(struct vm_userfaultfd_ctx *,
 					unsigned long from, unsigned long to,
 					unsigned long len);
+void mremap_userfaultfd_fail(struct vm_userfaultfd_ctx *);
 
 extern bool userfaultfd_remove(struct vm_area_struct *vma,
 			       unsigned long start,
@@ -371,6 +372,10 @@ static inline void mremap_userfaultfd_complete(struct vm_userfaultfd_ctx *ctx,
 {
 }
 
+static inline void mremap_userfaultfd_fail(struct vm_userfaultfd_ctx *ctx)
+{
+}
+
 static inline bool userfaultfd_remove(struct vm_area_struct *vma,
 				      unsigned long start,
 				      unsigned long end)
diff --git a/mm/mremap.c b/mm/mremap.c
index 87cab223f2bb..b2ee95182b36 100644
--- a/mm/mremap.c
+++ b/mm/mremap.c
@@ -1731,12 +1731,17 @@ static int check_prep_vma(struct vma_remap_struct *vrm)
 	return 0;
 }
 
-static void notify_uffd(struct vma_remap_struct *vrm, unsigned long to)
+static void notify_uffd(struct vma_remap_struct *vrm, bool failed)
 {
 	struct mm_struct *mm = current->mm;
 
+	/* Regardless of success/failure, we always notify of any unmaps. */
 	userfaultfd_unmap_complete(mm, vrm->uf_unmap_early);
-	mremap_userfaultfd_complete(vrm->uf, vrm->addr, to, vrm->old_len);
+	if (failed)
+		mremap_userfaultfd_fail(vrm->uf);
+	else
+		mremap_userfaultfd_complete(vrm->uf, vrm->addr,
+			vrm->new_addr, vrm->old_len);
 	userfaultfd_unmap_complete(mm, vrm->uf_unmap);
 }
 
@@ -1744,6 +1749,7 @@ static unsigned long do_mremap(struct vma_remap_struct *vrm)
 {
 	struct mm_struct *mm = current->mm;
 	unsigned long res;
+	bool failed;
 
 	vrm->old_len = PAGE_ALIGN(vrm->old_len);
 	vrm->new_len = PAGE_ALIGN(vrm->new_len);
@@ -1765,13 +1771,15 @@ static unsigned long do_mremap(struct vma_remap_struct *vrm)
 	res = vrm_implies_new_addr(vrm) ? mremap_to(vrm) : mremap_at(vrm);
 
 out:
+	failed = IS_ERR_VALUE(res);
+
 	if (vrm->mmap_locked)
 		mmap_write_unlock(mm);
 
-	if (!IS_ERR_VALUE(res) && vrm->mlocked && vrm->new_len > vrm->old_len)
+	if (!failed && vrm->mlocked && vrm->new_len > vrm->old_len)
 		mm_populate(vrm->new_addr + vrm->old_len, vrm->delta);
 
-	notify_uffd(vrm, res);
+	notify_uffd(vrm, failed);
 	return res;
 }
 
-- 
2.50.0



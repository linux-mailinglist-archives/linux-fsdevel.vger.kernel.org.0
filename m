Return-Path: <linux-fsdevel+bounces-23219-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 09ED8928C41
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Jul 2024 18:27:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B31E4286A62
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Jul 2024 16:27:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C60216C840;
	Fri,  5 Jul 2024 16:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="aFBpqDuO";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="iOnlHnWj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18BCC16F91A;
	Fri,  5 Jul 2024 16:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720196734; cv=fail; b=VaR6a62UE5ShjKBLnDhtJPMr8KU9QwOKmmbCEWwvK+axbTpkZTy1rntVoLEwolyTRhgveWGdiVS52ZceFqmjMR2vX/VIdKQ8aT5zycqaZsqd/OxJaT8ETF3xSy3pdacv1nhD036hwytqNPj2NZ9StGP68H+/aHlnftEG4ESvWbI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720196734; c=relaxed/simple;
	bh=pUSaUmPvj5Rp7Iq2iwsgn1wkPtGEhxju7DgYXorkw+Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cDljePtm1Ih6A75zhN8c7MoCijEy5Qh4rsSkUneraAkdbgWkhO2PYgxDjUqpa2gmHJzwy55JSxJPuezS0Xpwi/vcugF3DkShy7L9PcfycDweTBNCerLtbK5zFPPpm4kK/mSY9cI4SzQhsAVkxvv2QYtyxASzAUlpDyrIHZvJ/NQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=aFBpqDuO; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=iOnlHnWj; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 465GMW5f011057;
	Fri, 5 Jul 2024 16:25:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:content-transfer-encoding:content-type:mime-version; s=
	corp-2023-11-20; bh=NT7bNhoR4f291pg4VePYRXY/+5BIkGBmmP5luiTjmkw=; b=
	aFBpqDuOGRFT0UyH2YRKdgMWzYCHqoLppOuqjGXGxmJJMKb8NT4nfXog/WcOszpP
	uWsOW0rcm42HUPu7vs9Aisgx5CMv3n+l9V7zcuxgkZRgyxXE5Gjk0wQotMlAZup6
	MjTHEiN7yjpcyS9QdZcjdJSCZ/qhpPJbHDsB6lxuB8QXKlooAeU+/GtwDlwC4EsQ
	UhQruQkwrUYWrkpYILpSL90AuIQdZfnuxkEY0GY76HWYw0S1f/BLvnmceSYmgQQq
	6ZCt1tFb6gEvTjV0snPAImCiS4p44ska3TrINmxZnlZCM2YzswQ647CG0irHh+37
	ltPppyHUwVBTg2FwLutK/w==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4028v0v9dg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 05 Jul 2024 16:25:18 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 465GM3Q7024789;
	Fri, 5 Jul 2024 16:25:17 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4028qc1c0a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 05 Jul 2024 16:25:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hr4v5sfUFkO4dhKwR54/UJsYeYpaRLYq4T5/UCklhm+FTQrty7QUhbv7Ug/83dAVaRu+AKX9g3zeLeJK9/4k1gv21u4gBK0oGS2UGqJKhtfufW97wJGh8ajP3Cp6ZNseyzH5T/hCEwPDebxa3FPGytzENv4js8KTbCj7GACFFuvDDpEGreqD3ODq3IdTMBtrRh1Z2T7yS+ImcYl0sCHwG6em/KHZjGgABRuMUdWOxE90YLMwtHvhMi7Bs4lss92Z8GnEUGv2A4tInF/1uyFB7xSZcnI85zHxtZNt7LqlxGucWgcd5cglTjHXetw490VRS8O1aQTu/GprH0LkIvAIFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NT7bNhoR4f291pg4VePYRXY/+5BIkGBmmP5luiTjmkw=;
 b=ZCDg8vtQcYqHgjC78EQKs4ixD2UBbCm3BAc8DQpMk+0mOWb3uQynRZDbKpNGdGscigWN4QHrDRTq4LJOM5TyKlHjGxvCONriz8IToFc8jv71cv6mGPYgWJUgFnsAO8GB4i0j08n2kG5qQeGFcYst02Oe+5G334xCxkgNGuxiTm5D9C0tCoQIi/CfMiiiVMVRi1k3of5NYwK+zqqcQCrbGuRvIdjnMg8yGHGSb4C99I+zHej8Nhuds6v1oB47vBqLkhKNKFKqEDDZ+PFVUtIxoozNMKkBGk1i0DVWzkG13LIkqYtK5sYJzcFRWKFLBitfu52fCF9KMttdTO8QK/xH8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NT7bNhoR4f291pg4VePYRXY/+5BIkGBmmP5luiTjmkw=;
 b=iOnlHnWjC2Br+a2fwSYtQoRpgaYQz/tX/vLkL5hWJSmz2HaKjJjHFK+IgHwI61sw6c83ruj171sUcR5RpLLKFul8cWE3FxGmrtPEhyOSX7BVGBtAoa5LUQ2oGLLYbGEexuHA6KW2hxvq6lsqe5L4s6D5olBTkIIiwRTHKpksLrU=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by DS0PR10MB7361.namprd10.prod.outlook.com (2603:10b6:8:f8::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.30; Fri, 5 Jul
 2024 16:25:15 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%6]) with mapi id 15.20.7741.025; Fri, 5 Jul 2024
 16:25:15 +0000
From: John Garry <john.g.garry@oracle.com>
To: chandan.babu@oracle.com, djwong@kernel.org, dchinner@redhat.com,
        hch@lst.de
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz,
        linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, catherine.hoang@oracle.com,
        martin.petersen@oracle.com, John Garry <john.g.garry@oracle.com>
Subject: [PATCH v2 05/13] xfs: introduce forced allocation alignment
Date: Fri,  5 Jul 2024 16:24:42 +0000
Message-Id: <20240705162450.3481169-6-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20240705162450.3481169-1-john.g.garry@oracle.com>
References: <20240705162450.3481169-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1P223CA0003.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:208:2c4::8) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|DS0PR10MB7361:EE_
X-MS-Office365-Filtering-Correlation-Id: 39280bd8-a4b4-4789-9b51-08dc9d0f0d26
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?ZNt4P3Yex7bWfXiurC7pldlooXglTbh22OOuwBYNIN4KKoHY5KjQZdbhmQZO?=
 =?us-ascii?Q?yzXX1cmY/mtB+eNDIDE+CBWWjaLvipctemag6cORZ3wFgGtc37GMTknW/s3Y?=
 =?us-ascii?Q?htjFnv8wX00UVdVX0AMSD6WpOd8hVGC3EUlEoQMssiYQ67qD9HRJUaTN+O1S?=
 =?us-ascii?Q?WnXhfkzHdCekTw8t6cYOStmxaNOZ1iSxQiO1UCfMrPDJq9tMpLKpGXQ3Q67J?=
 =?us-ascii?Q?WPLZp1pzl9ns6QoQJpLh8r53ZN+2D6yA3SyVyCIHf998m+tOT4T6ZiT19TmO?=
 =?us-ascii?Q?lDskykI+6Dnf6HZEQCvnzQikJ+cvarZ9MLkAA1Nh5jV8UOHhXktV8PTyhauv?=
 =?us-ascii?Q?dCn4NQzy9pn5Dn1O1s9EPf99QOC/pJfPpDuyvGaSvAdTKO7d8jqQ0VFQ5sDC?=
 =?us-ascii?Q?XoXCd7ZURq1S9hu2H1jigPrIVVm2qdXFjT7BgAec/b2Vc+b0hhVGxs2Ne3eJ?=
 =?us-ascii?Q?/hzwIfEWF1mj7sJbxnVwGnGgvHiXCDFTO4CE8cPyp8FwZlMstXlZ9Y5teX4E?=
 =?us-ascii?Q?IjnzmswkssRgxFjzeY4KoQMp5sj4csffB5prtLBSW/aC2mSHJSnsCqCNLyQl?=
 =?us-ascii?Q?xrSZLpzIvgQnV3NB0xPHxnGHb1ihuW5xRnpfSKFEJSDCBwI9PT8xyXR7SZwg?=
 =?us-ascii?Q?AoNHBegdvIGEBSX+p6RWmJpNBsdkWA0MpGej3Z3AWR/UwRa6kLIgarXRiVjM?=
 =?us-ascii?Q?d+NaM6DvFxfvKbpKv11ywekUHHYYPQlfOaU39PYS3R6k0tlLhsnGqYZh2PWe?=
 =?us-ascii?Q?lpB269kOg7gVER2SkbCKkPfUpnAKmdY/JLQGKH+cFATjCkRtg1RG2RbZuhKq?=
 =?us-ascii?Q?hAFeod6izswVaZhR3+osx5Fkz6KU6RK89wzU38JJv0zxo6idb83y5ykCXMyr?=
 =?us-ascii?Q?F2+5Fu7S9fWM/OoMwRwU7zqfjuWsLQ8qq4TvFfbVsA3JDPJYWv89bSQjNVUt?=
 =?us-ascii?Q?2DN7yhuZjtDrChrfj8IaWF2s/M98F9TCC73AufpOnFIA2b0TxQPeDBTyD5s6?=
 =?us-ascii?Q?1/HZQ3Zaqr9hcOnJKRhUflah2KDBMiFXft3ZZggrr5JNCE/eXHOb9NTOuQNw?=
 =?us-ascii?Q?Oz3uMOATTWDQBYxCkHj5hI98+qbNLAQH1QLxH5IaI47eQwKmEvFy3UcMKsn5?=
 =?us-ascii?Q?latGN0BWj4sEwpwvwhshOI7HODPDT8YxnyktUQy+rKv9Cb06XXag+EZoEZcO?=
 =?us-ascii?Q?VuhZNBpZnau73cbTj3irJpmQCdn+zyEDOF8372/DaNJy+gvaynuFgOPmCc+b?=
 =?us-ascii?Q?giLa4x5IIbO2LFPZXoFq6i5KtzxM++cvCK/b/KVehCnay0RRF7VZKNrVnpvp?=
 =?us-ascii?Q?tTgiYGH5B7NMtwBNLmh+x0dOo7GtquF+aq91MPUMme0Eaw=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?qRJAiWugkg81ODobQG1lWYLYz3kCgUMWTPtP/FR4Gt9N1BtYAmG86dJcsRka?=
 =?us-ascii?Q?+9tPp0kVh5w1ekPCfNie4hLzY4giD2N76n5NopbGCFNmJyuPBnkxZI+kT5p7?=
 =?us-ascii?Q?TyrU1zidZIHiD11Q0nuxnsJpTrjFrRA8DQG2OYu71+XAawnvmTjl2p71CNHT?=
 =?us-ascii?Q?77SC7jbjwJem8sWb1MSotyJgE2pgaxqVTWzrh+/0/uJ73dhhb1/6hm0dfB67?=
 =?us-ascii?Q?XKvUAUy8ZvdwCMLFM2VFdi3NZT76RJOAdp+b+SrX/8gchrZiEWBYCgLXiOn8?=
 =?us-ascii?Q?Y2bu2MG+vuKM+lE+kHswGzGAgdZlChJGxQa3D0NlHlhtYKrulkC0pQluY5H3?=
 =?us-ascii?Q?Q2ljbCQZIOpulMGQ22Yu+JKLfhVigfy2CY9XSfdOUWVENQbVcu4Z94T4eFL5?=
 =?us-ascii?Q?DVlPSCM2fLKfi8jZrPJzvUE/JJhN4npDwDP0QHT4gW+LjH/Ac7UJ764QvQ7u?=
 =?us-ascii?Q?ZmZcNi1gJF3ghO+xClwezLnkwKskQdjjalfCrFatSBW9v8ttaapFDbXFng8b?=
 =?us-ascii?Q?HVqJYpkvgC36zDLql+uktelRi9sqzEJfoYKsQU4GKh/G/oWD5Mv1jKknchcb?=
 =?us-ascii?Q?YSgv7EvjyDw4Bnfda8Onb0ghA5SqLUnuBIfJQxzfTDc+vXpT7wqsjI5+3d87?=
 =?us-ascii?Q?nBdphffH1ht+IkWfZKH9Bm7znbF0IhYN9eiot/BULQEOwaOyxv2AFupf5TqU?=
 =?us-ascii?Q?h48xbqOxmMMgV/fy92cFgFZ3SeEK4+zxkSfzO4hMSEaDDbSCfbSROSn3xRpV?=
 =?us-ascii?Q?vLVFy8Iety8s5New+pz5CK3MWVToS4kd92dIdkufYybTPZCqZQ6xgqcW2/Fy?=
 =?us-ascii?Q?t6dlKVzBWDX8ZYS+Lna3phROyb5oqva+pYpu0tRoAza2OvwLD4MCvR7IPq2O?=
 =?us-ascii?Q?F8eqijhd56vGNnIt7/u9lP7QDPNzKEg6KnwHYL2HsRAbXSPx4p4JAUTNbOif?=
 =?us-ascii?Q?seb0CY7DmkgBGIad+PYTte6i9LTHnxLL1NEByQDIURGkvOz/+3FDto/WwV+x?=
 =?us-ascii?Q?QA0q7nM/lPS7qElx4qDrA/MxP1ynkER0By5moF20p7TncgdR7BfMjrvbHpe4?=
 =?us-ascii?Q?0qNKNiBTsqiLeW8lkyVpbXZep4fHUc6EP/98MwbcDkvkQ2WKgIkzKWG3WCH6?=
 =?us-ascii?Q?24gLOUemJflpEES5hXZVfZrK/Xa8K4BJp5F5G3cSjpj+68lEKZXKofj964Vq?=
 =?us-ascii?Q?GzdfedtpZAgf8jbrX8FFnaDBPB5xCFNVZRSu09nz3e196f8BkEPuWVG1U+B3?=
 =?us-ascii?Q?yhg/t17/0mb9G34uCra+nh6D5gCtUyleeQhn9ICVvbkIiGhkps0YXeLPQUSf?=
 =?us-ascii?Q?chLrjnZWiz8z5WATy29Ea/ke6ofF8jNyj2fTXSRYS5An8b8Vqp3I8+WPHRh0?=
 =?us-ascii?Q?IIYjtv21aAlc2uWuA38RzuFEh+SQ2su3wHJsdls4gAccWeG6JRiLMu2SrROM?=
 =?us-ascii?Q?VRE1m3evk9kI3yx8HYa4A/QiyaCS5obs3/JzNu14ZAG9pv0THWssaG+tQuEA?=
 =?us-ascii?Q?eA7eVm7YvMBDqIgJ1a6KFm+YdPJ6p8kcLH1tPotTKC4g9faKhVDvKnA4koZ3?=
 =?us-ascii?Q?I9ojed5IoYql5Dsf1+61BF6HSCpHQiIqSXCVYA8MbVHi53yUV2h26PIneSXg?=
 =?us-ascii?Q?ig=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	+4fSUw2YK9msOEyFpp9GOs9Q81MhEImTjsbjy8q/ygOtprPL6Nfe/4mrZz7Dylet4lt1jV90pDQqVTLwyJQOW5mSD9XDKuIkqQtlsChL1yzjMaoVjMxgbTwD3gFSy/WoE84vKsRfzN2iQi4xDm1m+jqtH3+O8ZxBOGqajvsu8MLhCee3VuJeWA6hKZUMVbp3DY9JqypmQOBaoOtdvIOnwVS9cYBtlfvIGZTUOtwN38JU3ViHazV5nE8l5a9cAOTmaAMvXvGLF6FmfoY2eEpm1KLf1JzHwqFXNtcSDmqWtORhz0wFaSU5bM8TKbS4hWTlothSX6k7b3C6Wa+p/gBgk0s2IA7JzTDMGJwOSPmi61B2zSyZDf9weICQqPMJx2zEGbPlmNBeJyjSOzAsuBhR/O27PW1TYpejhWSKhEqHQaHkkiNy02ybJVP7rBCFXlkDrT3sPcWsqNcVLYtjk9fU5YCQ/I6HmH0N5P7QZzrXP4QAKR5Tp3LsNz+yRBra4fxigsqbpCIjBaqlfc2XBu7nKstyhu6YtbPr0e7kxJSe2LYmxUw5r9tVOYJhTuDpGVOkK5l2D85A48cfNFupG3nQLrzEEMKYdciS6b0wL7lAxpw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39280bd8-a4b4-4789-9b51-08dc9d0f0d26
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2024 16:25:15.1305
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HW2XOz6M3WR9UgZ3KO7fqe1QbDUm35IyIaL1EsO4kPflVUKXBAyDbmpBHit3b0/y4gjE/vcwuwM14ARXVnzUgA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7361
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-05_12,2024-07-05_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999
 bulkscore=0 suspectscore=0 adultscore=0 spamscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2406180000 definitions=main-2407050119
X-Proofpoint-ORIG-GUID: llO92BiHOPKPiHVCT0PJy7p8Yc6MC9Sy
X-Proofpoint-GUID: llO92BiHOPKPiHVCT0PJy7p8Yc6MC9Sy

From: Dave Chinner <dchinner@redhat.com>

When forced allocation alignment is specified, the extent will
be aligned to the extent size hint size rather than stripe
alignment. If aligned allocation cannot be done, then the allocation
is failed rather than attempting non-aligned fallbacks.

Note: none of the per-inode force align configuration is present
yet, so this just triggers off an "always false" wrapper function
for the moment.

Signed-off-by: Dave Chinner <dchinner@redhat.com>
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 fs/xfs/libxfs/xfs_alloc.h |  1 +
 fs/xfs/libxfs/xfs_bmap.c  | 29 +++++++++++++++++++++++------
 fs/xfs/xfs_inode.h        |  5 +++++
 3 files changed, 29 insertions(+), 6 deletions(-)

diff --git a/fs/xfs/libxfs/xfs_alloc.h b/fs/xfs/libxfs/xfs_alloc.h
index 1e9d0bde5640..71a85439e5fc 100644
--- a/fs/xfs/libxfs/xfs_alloc.h
+++ b/fs/xfs/libxfs/xfs_alloc.h
@@ -66,6 +66,7 @@ typedef struct xfs_alloc_arg {
 #define XFS_ALLOC_USERDATA		(1 << 0)/* allocation is for user data*/
 #define XFS_ALLOC_INITIAL_USER_DATA	(1 << 1)/* special case start of file */
 #define XFS_ALLOC_NOBUSY		(1 << 2)/* Busy extents not allowed */
+#define XFS_ALLOC_FORCEALIGN		(1 << 3)/* forced extent alignment */
 
 /* freespace limit calculations */
 unsigned int xfs_alloc_set_aside(struct xfs_mount *mp);
diff --git a/fs/xfs/libxfs/xfs_bmap.c b/fs/xfs/libxfs/xfs_bmap.c
index 4122a2da06ec..1cc2d812a6e9 100644
--- a/fs/xfs/libxfs/xfs_bmap.c
+++ b/fs/xfs/libxfs/xfs_bmap.c
@@ -3400,9 +3400,10 @@ xfs_bmap_alloc_account(
  * Calculate the extent start alignment and the extent length adjustments that
  * constrain this allocation.
  *
- * Extent start alignment is currently determined by stripe configuration and is
- * carried in args->alignment, whilst extent length adjustment is determined by
- * extent size hints and is carried by args->prod and args->mod.
+ * Extent start alignment is currently determined by forced inode alignment or
+ * stripe configuration and is carried in args->alignment, whilst extent length
+ * adjustment is determined by extent size hints and is carried by args->prod
+ * and args->mod.
  *
  * Low level allocation code is free to either ignore or override these values
  * as required.
@@ -3415,11 +3416,18 @@ xfs_bmap_compute_alignments(
 	struct xfs_mount	*mp = args->mp;
 	xfs_extlen_t		align = 0; /* minimum allocation alignment */
 
-	/* stripe alignment for allocation is determined by mount parameters */
-	if (mp->m_swidth && xfs_has_swalloc(mp))
+	/*
+	 * Forced inode alignment takes preference over stripe alignment.
+	 * Stripe alignment for allocation is determined by mount parameters.
+	 */
+	if (xfs_inode_has_forcealign(ap->ip)) {
+		args->alignment = xfs_get_extsz_hint(ap->ip);
+		args->datatype |= XFS_ALLOC_FORCEALIGN;
+	} else if (mp->m_swidth && xfs_has_swalloc(mp)) {
 		args->alignment = mp->m_swidth;
-	else if (mp->m_dalign)
+	} else if (mp->m_dalign) {
 		args->alignment = mp->m_dalign;
+	}
 
 	if (ap->flags & XFS_BMAPI_COWFORK)
 		align = xfs_get_cowextsz_hint(ap->ip);
@@ -3606,6 +3614,11 @@ xfs_bmap_btalloc_low_space(
 {
 	int			error;
 
+	if (args->alignment > 1 && (args->datatype & XFS_ALLOC_FORCEALIGN)) {
+		args->fsbno = NULLFSBLOCK;
+		return 0;
+	}
+
 	args->alignment = 1;
 	if (args->minlen > ap->minlen) {
 		args->minlen = ap->minlen;
@@ -3657,6 +3670,8 @@ xfs_bmap_btalloc_filestreams(
 
 	/* Attempt non-aligned allocation if we haven't already. */
 	if (!error && args->fsbno == NULLFSBLOCK && args->alignment > 1)  {
+		if (args->datatype & XFS_ALLOC_FORCEALIGN)
+			return error;
 		args->alignment = 1;
 		error = xfs_alloc_vextent_near_bno(args, ap->blkno);
 	}
@@ -3715,6 +3730,8 @@ xfs_bmap_btalloc_best_length(
 
 	/* Attempt non-aligned allocation if we haven't already. */
 	if (!error && args->fsbno == NULLFSBLOCK && args->alignment > 1)  {
+		if (args->datatype & XFS_ALLOC_FORCEALIGN)
+			return error;
 		args->alignment = 1;
 		error = xfs_alloc_vextent_start_ag(args, ap->blkno);
 	}
diff --git a/fs/xfs/xfs_inode.h b/fs/xfs/xfs_inode.h
index 292b90b5f2ac..42f999c1106c 100644
--- a/fs/xfs/xfs_inode.h
+++ b/fs/xfs/xfs_inode.h
@@ -311,6 +311,11 @@ static inline bool xfs_inode_has_large_extent_counts(struct xfs_inode *ip)
 	return ip->i_diflags2 & XFS_DIFLAG2_NREXT64;
 }
 
+static inline bool xfs_inode_has_forcealign(struct xfs_inode *ip)
+{
+	return false;
+}
+
 /*
  * Decide if this file is a realtime file whose data allocation unit is larger
  * than a single filesystem block.
-- 
2.31.1



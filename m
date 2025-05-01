Return-Path: <linux-fsdevel+bounces-47851-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DE8D1AA6246
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 May 2025 19:27:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 482501BA65D2
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 May 2025 17:27:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E14A02153F1;
	Thu,  1 May 2025 17:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="o4N48lDs";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="QtQYZJ//"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AEE21EB5D0;
	Thu,  1 May 2025 17:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746120446; cv=fail; b=KlfXph+Hd5molg9IJsYGKoglJR1b9U3eB8duHh0bL4uGY0IVxxQBQ0lLz8KoyO3BcphtxeF5uaQhj+GEKTO8MS390rb22OMdPEsDut71CA0vd3L75ae64OfPSM7tv1GS3KWrpzH44YxxNPEM7a7Fq127DbsZAyz+IZ0vTT+1MII=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746120446; c=relaxed/simple;
	bh=bslMqB5ei03hKexX2AS8yjNgLJRwR2ekqYylH+bYnNI=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=PMroUM36EVnQokjZoVM5iE29uHdCAPvSdHcls5l87+VNTgdBzOeGnou9cSxrXQr9h56oNR6iUKEfSgLAdyy0Awf0Spskvokcrsh713/W18SBHys4isG4JNIywdJDyMZVidKHz1WywkLrfRQxKTGQGSkD8g8gpPaQ9VA4HULQwTQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=o4N48lDs; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=QtQYZJ//; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 541HNSDx023599;
	Thu, 1 May 2025 17:27:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2025-04-25; bh=Sj0G5DzUspyA8BhJ
	BHeTJ1xfiWywCUm+Gn+jtQcb03I=; b=o4N48lDsDA3z5AvrMivzcMkjAwN7gFXa
	faUQ4revc1BF/ko3Rn27NiPsa3HqRD0NR0mM1cS6uFX0u205vQVJZUhwr/JaasKV
	B7G280cqUfwId19Vx2OzDX04DXFYXNgJfrqJWQl2YYBi8IAwMvr97F+39/7jWHio
	/Yfv0jcBfNRq2YCvY+y/SBrbT5wITKiVqmfeBw/dsp8i1BOV2i4iQ5h/uWHzrteT
	inus1XbcVy3VS5de149PrEUTQyqlG1A100cPFOwTIY+h9elzbQX6hintVRu+rLN7
	Fp/FVPZVKG4OUBUawHWDzmbue6U91rUX4TPrSz4LP1Iqq1uriPhj1g==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46b6uckhma-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 01 May 2025 17:27:06 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 541GclCi011276;
	Thu, 1 May 2025 17:27:05 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2044.outbound.protection.outlook.com [104.47.66.44])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 468nxda838-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 01 May 2025 17:27:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CyWMvnKrNAMl3/pFQ2+NH7FwGiu03+hs8UyTEvSsaVofHf5frGomyRltc3NYuHrvqPw9qHDsuoNVOj4NVZCl+AtCPGqK/ImZfxMKQP8HqBJRp0ODNeo9PgtC/ORQ4gHdHxjAkL05rjx8PQNDXOGFmup23oO5pIs0dF0Wt0SDDRx+TYQR+tgDcW9oWtKNO28cNLAyf4ZtpIyEm4R0vDVFx+Z6AUhhegF7fAlIN3EwaUY+rLRvcfQKT62R67IteFerzZyroW87jfPpljOl3cZpYJ2F+ylZoQkAhhpgPb1iElWyDNSUD2MFaMCjgIEqB7sVQI6Vw7NT/Ktc+Ryx7seyFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Sj0G5DzUspyA8BhJBHeTJ1xfiWywCUm+Gn+jtQcb03I=;
 b=dtJaNbZsKYhTzOegbbrozXTOZZLacqZp7Rzxv0w9b+aEm/FW3oKpGbIGyigXWRYJlVJWYUqqM7wijYbePpZeBLjgPjKcx4xae0LUnJgJc/tDuYWRlmsOezbj31GvmASmWVrzohodvV2Z4DcQtRCpv8qV4adc2DgNJnpXuzKG3YrzaViAHUiN+084mVmdMW5qsUV7xijXrK1qJvGxcOXr4PMIyjwtsU+MzadrdD+ZlMGJTijDlFFuTF+/BuDH/WP/4vWd838UPcNTCOcMH5zgpkhY2RG6yekI2hLnpZBYU93TKWB3Rkl0M1sk7sk3RpphNgr8gVqGEN/3ARaGIb/FEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Sj0G5DzUspyA8BhJBHeTJ1xfiWywCUm+Gn+jtQcb03I=;
 b=QtQYZJ//Btf5G1ikWVp/IzWt3R+6s4mr+RbaZFb7bhkRJa8viZiDGdOdjPC4XHdz8d1hwwYeQEtIu8OyctL59y3KGfgK5swHTri/9v3CSLdaN3HRBrgQbz0Ri4VuohgVhY/V+xja5Cu0q4wpbleXbW6ptvVrH1YC+ku6S5Ui1Aw=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by CH2PR10MB4199.namprd10.prod.outlook.com (2603:10b6:610:7f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.23; Thu, 1 May
 2025 17:27:02 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.8699.022; Thu, 1 May 2025
 17:27:02 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: David Hildenbrand <david@redhat.com>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
        Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        Matthew Wilcox <willy@infradead.org>
Subject: [RFC PATCH v2 0/3] eliminate mmap() retry merge, add .mmap_prepare hook
Date: Thu,  1 May 2025 18:25:26 +0100
Message-ID: <cover.1746116777.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.49.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P265CA0005.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2ad::17) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|CH2PR10MB4199:EE_
X-MS-Office365-Filtering-Correlation-Id: f6f8c5f9-63e8-4532-029b-08dd88d562c0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?cNI0hyvsmbiy1/HOVzbuoKPixBLbWpiBhukmfBTCmDFC3yBcPDJO34V7sKlO?=
 =?us-ascii?Q?0laNLElonOtjx3+utk16OV0S1qaOY4KwTO4DAqKHa47HhH4TJPwXb8WV8VKS?=
 =?us-ascii?Q?ofpUxX+OHDOJKp7InLHmQZKC7JDz+aKFDdSg4SQ8KWa8xjVY6Vioqjj+tjUO?=
 =?us-ascii?Q?6oX9VrEhb3a64119lsheeAxYBiQCcryZUqvzy5KhRwAdSfknc7BDVTg6prE1?=
 =?us-ascii?Q?JhNmt8xG298H8Qw2snjbm5XBJFjWYLzja430CXCtVytAmmwqAd3E8M+ejeuK?=
 =?us-ascii?Q?c2JIfBzm6efr4c9Z/xb8fgDdtTB+zjjKNSOu242LySetiEY9EkIdLgNVxEcM?=
 =?us-ascii?Q?Ou9Fddk+x6bP3NpiXB4c0vrxkZYMRgTiscORucKL5Qfi1bRHemkSRO0SDgJ6?=
 =?us-ascii?Q?5hJNt5rL8QyM6mPKMxURTmHxgE0AtNrkTy+HmoVrZ/F4qM2Y6V8Ged0mgLJy?=
 =?us-ascii?Q?sEsXV9kETp9Q+qupRtGPenrN7Cc8zAfDX11ZMPlVkOkmZtVFxopv1KnaR4Nb?=
 =?us-ascii?Q?uouwYWHQ99tWOHZLv9u4x+GmxwrhBnlCDfUWj42NdJ5w6M17uBRCCHv9BbOn?=
 =?us-ascii?Q?VjN6xbWN4QnIrODOAiruc45zL9Mr0gbdWAOf+iinjIAbjrMb48RRY6vD/aua?=
 =?us-ascii?Q?9zchKKEDCy69/lnZzzfqlNtLjn9zxbnGW9A4dmeifqqBipfJmLtq5sqjdD88?=
 =?us-ascii?Q?MBdIhGvLtHrN7ct2JqfMQiLbOmJoBegv5jkdajVQPLmbB3esjyyELK6Amsfi?=
 =?us-ascii?Q?HoBXPCHfrpPE0xeNqoO57xDsPmVXWg3NM1JvghoAeUsXUku5ZO1kjbkMKC23?=
 =?us-ascii?Q?wfdVKh54sp72zxeq+wfRcFrTL8DSV2SRTctZ0qPp8jpyJSrAyof3O6oZcQ3w?=
 =?us-ascii?Q?IRLh4CqP6sqay774s/5u0O2fKnRXpCu97flAgM6SUNb7CL0YXMiJ/MOO+Cc1?=
 =?us-ascii?Q?GZTWyk1oma0bPhschcgNkZKys0NU/7pbbk8sHnANvx+ngWCINuq/7tNcn1dX?=
 =?us-ascii?Q?owaErteGZsF3OTnCyPlQvGmISAdKd1VsAVOuF6PF11oYNnqqrRSrysgXp98U?=
 =?us-ascii?Q?DpXmuoYbk75ybwn1gZ29j3ZjqlWtYPzGH5trouqAYutosjxYooNIdEWPOZOR?=
 =?us-ascii?Q?/eC+nnxLlnCmBARFogw2/AjRDL5bSLNrug60TPA37CpuiloPxjGnC899rys3?=
 =?us-ascii?Q?a7xrVgXFnqIeZFW9VBjRNUVwSMRLm9Jo8Ij9tENapkN4+KvKNS7l0f3R4QQs?=
 =?us-ascii?Q?OVLxge9oy84l3lSBKEs8v0wryRSGvPm1AI+Q4FDq0/WWRo75fFgN1hZ0kUd4?=
 =?us-ascii?Q?3AWJNqL8BG+pY9+aDtmzB7is+wY/KvLYsH4JPXLKpI5/xirJJWlrJWSoEP3K?=
 =?us-ascii?Q?FML4eDf+pijy111dtMhlXYB5EpGbqZ9h0IcLG2e4zuzkY5Wae5cs7cRenGHx?=
 =?us-ascii?Q?YYtSjIqpeHo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?FIQ4R+G2WaA7n51Mtbk5BN5LhVi5z96c+jstGZEM21WThHfMd/hMzbKLJCF7?=
 =?us-ascii?Q?hsWYeS3ozlu6VahCmon7fW8AulrjwWia7c8j2/XtneAvqt/HCeqAAj/IJIPf?=
 =?us-ascii?Q?JBa/3154zNwplfMZU4qpbAd8K6HIfD/BP7RRv3swK2sPrB87h8PmFcNAvpZv?=
 =?us-ascii?Q?xKixcNT1RwYbgJGUtKPU1O5pF0kOZs6k9neMT2sOXHXTpzj6xWOB9cVHHbhr?=
 =?us-ascii?Q?R5s/stpkYGgD6huyIXxRYOTAIET/g1ZX7WKmocHfpa7l9cjWFLloVHBNblb4?=
 =?us-ascii?Q?zErw1Ql/ERPRmdTI4wSs8qeMEWmniPoB8I/7AJHhnej+UafGQyyX90yno2g1?=
 =?us-ascii?Q?x43bxNfF74h1GgbcwvwjwjCf6SzHMJx4OxfzSyi1PIA4Q3Dz/WUjrtbjawdP?=
 =?us-ascii?Q?n3pmZHamL0sDnnMgGm4peCUaMR0MOWLsFKWie9sprvZQ5PuVpam7jzFb6Eck?=
 =?us-ascii?Q?+bfXunyiE1+zWK4IbjKyFwAIig8Z+hGgMVt+hcZ/ykQiCdD2QeyLVhb4JFBL?=
 =?us-ascii?Q?UhwSoDs18k5mmbIF0sM+6q8zXOI7OsIpYjFcBUO1cbJgj7FcKCmIcdGKa/lB?=
 =?us-ascii?Q?q8rVxVCk7kDte7pYw1xrBmFl69+8DQbdgMfOibIPaqVMtKpYj9WX/IvtpGhs?=
 =?us-ascii?Q?lMaQVk7cZ1Nx40XxRel1aAp3EncqhXKLL0eDWqGVAeUVRdHYKUWyZmYbqTz2?=
 =?us-ascii?Q?mqIUuyGqW3rJ+FweAExgpB7zxKgbf3Yr+Lx+J45vQcmUSqtIxDRVtr8pOBfs?=
 =?us-ascii?Q?0clNzfFQRxrOCMT04gAHSyw1Bp/MoChNwbVvRrxHciyl9bo3mt7cSg5/lPJo?=
 =?us-ascii?Q?T9txHlgmJjIbK2KsRYbJJE+KUldbQ4d6X4WE8o8tURCC8Y+crMatj8UUqKgS?=
 =?us-ascii?Q?f+8AViPk7hEIYW6H3yEse1kK6c6ctWBahtFIq+f8/UOhdyu8PMTxGORw18oJ?=
 =?us-ascii?Q?BaPRjFp5GhF7dQvr3ISTo7Q14T+f4nzEiM2I+MQNAW/SXCVDtvyX5nMRyyNE?=
 =?us-ascii?Q?44sSsdgnYzdgu8xf6BJXQRXgYRfScq/r5CDE8dTAo8ZrEMHcsx/cxS4flMFq?=
 =?us-ascii?Q?kpHUMoGWfd88k7DAdWOIGF/kVWKJ3AwqeggQWHB2APwfvn+JDSGlB73aPtpY?=
 =?us-ascii?Q?yxOQmMtwbk4rjWzSasBe+ZfR78unG3AqddX+rUtQxqjBGXjwk7hI95qO9Aai?=
 =?us-ascii?Q?t36u+PCDNhFFCnzdvwctSFTOXfEf5a0oH4mypcIO47QOELvxS3mFJ59q56kc?=
 =?us-ascii?Q?ngP5GJVYzXUUABwEi2r+lTiWO4tWpnghFX0dBH83DsEpU9JL6U62wrI6rpCO?=
 =?us-ascii?Q?xVX9FLJ9IbolK8/lcREl0nrY79DZpFCY4gNacB35wdIhY3nLSJ1H1BHB1OwJ?=
 =?us-ascii?Q?bW0VRUor5QZLViRpZ9IIkn7k815tY33bln2QGFXfk0uTqREEzJB7XfdXaRS0?=
 =?us-ascii?Q?toTHHmKXzm0VvQJ/d1mNQ+IVAlD9CcBHRHvblcDaUvkdM4XEXCZ8bwM2KnYx?=
 =?us-ascii?Q?2IsC7Kr6nXxpk2Trtvo+clXrd2Ua+hhvFmKMMW/4N0Wbo3OzMO0+UnQf6m1t?=
 =?us-ascii?Q?exgTWSPzzXfFdvmyQzeC2ZlER1Emo8QoDqwWPpoSD3BQ9ZXfHDPBIFfVR0rw?=
 =?us-ascii?Q?zg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	mw0a/Gb6r/kV9AxPrcGGYAJ58m3cL6u9kjWmAUJulFWb1gkR99wNe2F+3IDA0kpkUhRylZq1XbLQ2mmebva2AhDV/2TNIX5DYE22fOsQkmPoE3TGWZvq4wa4WeZ+jf28nsXjx5UBJ4AmV7eJT+J/0yk1E0Gcon+8ZllgILAWEs0gVZo+vYGhEmEsbowv7foU1e8RSMOn3FTKNWY+oCglnKI3Daqw8Ix2uND99L/2vupQsyLONPhIJskrllUv2is0nz5Edx6Pt134m3/4vE3On2QOCQMwz+JjtcmDZmmamPMsboH9usJutq0b7yQi/hjsYlFTahyoulJpeJJQ214GLNF6QcFzNAcRd7zzfCd5PtyzTe2TNyx/uC9vT3Syi7Lb8DUbz+MQ/zW5agZW4DkPV4/McOpYe+FD9jmC3YkrMDQGVr2sZChh72EnE4eYkQwjr7piaEmYoZ0+OSV/MX9R4D5//sgANxC6y0o+TzFzzKUFSY/F1h+sJ+zCoh4bqIaRVZ7o1W+n9g9p4pHQYcfVw4iYOYk3nmIWCT4GOqs6bTvN6ZTkUXKsvg2ezQCJSIv9XwXYWX8xWpPIEHmiaV771OHbv1ggfjGxGmoCjSRAzvY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f6f8c5f9-63e8-4532-029b-08dd88d562c0
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2025 17:27:02.4064
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MoWiGGSFsFAR73CZPZcv6W65u/z6EPdAB1Tz6cFJB9seVtIgvWG/Ov7vecuiKFI9CvDzsaHsgK89e1/k+5Ax9kKn59u37hHmBL9kz2Fwxzg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4199
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-01_06,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 suspectscore=0 adultscore=0 phishscore=0 mlxscore=0 bulkscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2504070000 definitions=main-2505010132
X-Authority-Analysis: v=2.4 cv=ZsHtK87G c=1 sm=1 tr=0 ts=6813aeea cx=c_pps a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10
 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8 a=oEByBfoX5-KuNZ1sLPUA:9
X-Proofpoint-ORIG-GUID: BjYZeDVq_lmOulZIvkpq5GGErBs0T3WP
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTAxMDEzMiBTYWx0ZWRfX+9o6JtALnFYv ZMPU55mt2Oi2Nb5L/Ohfd2upW4NWljlHwYXmgCwDhKA2HJYpdMr4eCxu8ocsU/M5dJP4LVm/JG1 JZ0RtDhStyWpER5gNy5DIgTqCECs9hw+96OnHjTW9RljB5ereGwQcgVlpy9pyZ6EYHDeVktQbXE
 luxNv3HYVzN+gvX5jslIAXvzrtOwCyHb/1TR+mjfPMydprYV+QO4J5FY1Es1tUrgJKq6WVZoZxT h+7YkF1yOnMqrPJMzbcQOL5cxuDfb4HVy/vanNSvksy1nrHWeOgKETjIxSM042adN8fXDHfi7VL +RStSAiEKPm5HWesHWIib09X38EzIoJQgVtEeTpVoMSqKyauq+4N+sMhMfaBWP3wYQ9vJNo1UuA
 wtEymqNKorUyt9NR4KKC4mtugAQ54PJo0y7+vvaF0fp09DjBJjvbxExHEIaQJ1QbrPJaZAnF
X-Proofpoint-GUID: BjYZeDVq_lmOulZIvkpq5GGErBs0T3WP

During the mmap() of a file-backed mapping, we invoke the underlying driver
file's mmap() callback in order to perform driver/file system
initialisation of the underlying VMA.

This has been a source of issues in the past, including a significant
security concern relating to unwinding of error state discovered by Jann
Horn, as fixed in commit 5de195060b2e ("mm: resolve faulty mmap_region()
error path behaviour") which performed the recent, significant, rework of
mmap() as a whole.

However, we have had a fly in the ointment remain - drivers have a great
deal of freedom in the .mmap() hook to manipulate VMA state (as well as
page table state).

This can be problematic, as we can no longer reason sensibly about VMA
state once the call is complete (the ability to do - anything - here does
rather interfere with that).

In addition, callers may choose to do odd or unusual things which might
interfere with subsequent steps in the mmap() process, and it may do so and
then raise an error, requiring very careful unwinding of state about which
we can make no assumptions.

Rather than providing such an open-ended interface, this series provides an
alternative, far more restrictive one - we expose a whitelist of fields
which can be adjusted by the driver, along with immutable state upon which
the driver can make such decisions:

struct vm_area_desc {
	/* Immutable state. */
	struct mm_struct *mm;
	unsigned long start;
	unsigned long end;

	/* Mutable fields. Populated with initial state. */
	pgoff_t pgoff;
	struct file *file;
	vm_flags_t vm_flags;
	pgprot_t page_prot;

	/* Write-only fields. */
	const struct vm_operations_struct *vm_ops;
	void *private_data;
};

The mmap logic then updates the state used to either merge with a VMA or
establish a new VMA based upon this logic.

This is achieved via new file hook .mmap_prepare(), which is, importantly,
invoked very early on in the mmap() process.

If an error arises, we can very simply abort the operation with very little
unwinding of state required.

The existing logic contains another, related, peccadillo - since the
.mmap() callback might do anything, it may also cause a previously
unmergeable VMA to become mergeable with adjacent VMAs.

Right now the logic will retry a merge like this only if the driver changes
VMA flags, and changes them in such a way that a merge might succeed (that
is, the flags are not 'special', that is do not contain any of the flags
specified in VM_SPECIAL).

This has also been the source of a great deal of pain - it's hard to
reason about an .mmap() callback that might do - anything - but it's also
hard to reason about setting up a VMA and writing to the maple tree, only
to do it again utilising a great deal of shared state.

Since .mmap_prepare() sets fields before the first merge is even attempted,
the use of this callback obviates the need for this retry merge logic.

A driver may only specify .mmap_prepare() or the deprecated .mmap()
callback. In future we may add futher callbacks beyond .mmap_prepare() to
faciliate all use cass as we convert drivers.

In researching this change, I examined every .mmap() callback, and
discovered only a very few that set VMA state in such a way that a. the VMA
flags changed and b. this would be mergeable.

In the majority of cases, it turns out that drivers are mapping kernel
memory and thus ultimately set VM_PFNMAP, VM_MIXEDMAP, or other unmergeable
VM_SPECIAL flags.

Of those that remain I identified a number of cases which are only
applicable in DAX, setting the VM_HUGEPAGE flag:

* dax_mmap()
* erofs_file_mmap()
* ext4_file_mmap()
* xfs_file_mmap()

For this remerge to not occur and to impact users, each of these cases
would require a user to mmap() files using DAX, in parts, immediately
adjacent to one another.

This is a very unlikely usecase and so it does not appear to be worthwhile
to adjust this functionality accordingly.

We can, however, very quickly do so if needed by simply adding an
.mmap_prepare() callback to these as required.

There are two further non-DAX cases I idenitfied:

* orangefs_file_mmap() - Clears VM_RAND_READ if set, replacing with
  VM_SEQ_READ.
* usb_stream_hwdep_mmap() - Sets VM_DONTDUMP.

Both of these cases again seem very unlikely to be mmap()'d immediately
adjacent to one another in a fashion that would result in a merge.

Finally, we are left with a viable case:

* secretmem_mmap() - Set VM_LOCKED, VM_DONTDUMP.

This is viable enough that the mm selftests trigger the logic as a matter
of course. Therefore, this series replace the .secretmem_mmap() hook with
.secret_mmap_prepare().

RFC v2:
* Renamed .mmap_proto() to .mmap_prepare() as per David.
* Made .mmap_prepare(), .mmap() mutually exclusive.
* Updated call_mmap() to bail out if .mmap_prepare() callback present as per Jann.
* Renamed vma_proto to vm_area_desc as per Mike.
* Added accidentally missing page_prot assignment/read from vm_area_desc.
* Renamed vm_area_desc->flags to vm_flags as per Liam.
* Added [__]call_mmap_prepare() for consistency with call_mmap().
* Added file_has_xxx_hook() helpers.
* Renamed file_has_valid_mmap() to file_has_valid_mmap_hooks() and check that
  the hook is mutually exclusive.

RFC v1:
https://lore.kernel.org/all/cover.1746040540.git.lorenzo.stoakes@oracle.com/

Lorenzo Stoakes (3):
  mm: introduce new .mmap_prepare() file callback
  mm: secretmem: convert to .mmap_prepare() hook
  mm/vma: remove mmap() retry merge

 include/linux/fs.h               | 38 +++++++++++++++
 include/linux/mm_types.h         | 24 ++++++++++
 mm/memory.c                      |  3 +-
 mm/mmap.c                        |  2 +-
 mm/secretmem.c                   | 14 +++---
 mm/vma.c                         | 82 ++++++++++++++++++++++++++------
 tools/testing/vma/vma_internal.h | 79 ++++++++++++++++++++++++++++--
 7 files changed, 214 insertions(+), 28 deletions(-)

-- 
2.49.0



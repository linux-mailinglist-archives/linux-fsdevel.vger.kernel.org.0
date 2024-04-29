Return-Path: <linux-fsdevel+bounces-18157-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A1A68B60C1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Apr 2024 19:56:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 176171F258BC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Apr 2024 17:56:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A3C812BF2B;
	Mon, 29 Apr 2024 17:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="bHgazVpq";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="HhNIqA2y"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22AF312BEBB;
	Mon, 29 Apr 2024 17:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714413099; cv=fail; b=RpnfrmKT43XpPgLe/u0U0ttyVFN3t+0fpaeY3fBsdfqSo9mvh/rdThCsKNFRCEU8rHFK/n4Rk7xFWSe+j+DU/wVOrzEV3N6veeA16+9JoPHCgf/aZYjtDqeuluYZEEBnyDhrJ/5P7RwtbPJe4u9bwRi6mSI1WCqeTO0g4lsoDPM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714413099; c=relaxed/simple;
	bh=WyGggRr2b/045rvam9wvV/tiYirHJlYKPkAjhqRa0mk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YatEZeT0Ht56WKGjzZkMOsD99S9SBIL17Yc+0fyia6QFQERo3cywJrfa5QeT/Z88bJxu9LYQxF0LNtTOffzY12sBYHjvfa8jH5noSxkeYQDhxMePNK4xQ4q+PXqIEeByNZJ5Di0X+9pIMrJXzpabtlMQCt/4G/qDiN1RfHxfumU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=bHgazVpq; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=HhNIqA2y; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43TGxRa7020045;
	Mon, 29 Apr 2024 17:48:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-11-20; bh=S8m9/G07q7toMjQ0Prow/pJ53GLzLkvO8Dt5ruPctuU=;
 b=bHgazVpqckKDo3DGUG0sCxP1VJkKDy1AY/LBwzcT0seMPUEXKxOkRRSQ5jPmSLhL+cGU
 0nUF/x4lPiYvABBFG4oHmGdoPyR4I57dTZz6K6xwz/zlm4HviIRIHKreOzhYG2Z0OS3r
 7VHeI1fSMCMAcCoSvYgJ2XsqffKDr4O08A9qHccG/+vlHB64w3ADylEpUcuhl+iqS+EK
 2gnqH6Cz7iz6qKQ1KlBZrg4P22EiTGw2HHckyjyeh0E9h2pl94e1UahErDo9HXaLlcTy
 E/jvhpwp6yhFLZmCQPz5MHw6VXClJH4hNwdTT+ZhR0Vdeh/8a5mcKT6g6iEw7kLOtF/g pA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xrs8ck68a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 29 Apr 2024 17:48:29 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 43THkxUU004324;
	Mon, 29 Apr 2024 17:48:28 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3xrqtc7ns0-6
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 29 Apr 2024 17:48:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KBEEkzJTUXnNRT7o9XnS4bcAqvUiHe+IfrP2o8CGAk3sEOO+YIzDHt98jZZ0NUWxsSed1Ftap3C7unenXpXyGKgY3LpYW71HxtI/h7SQWqvl1wTixmvYv85nrxOMEKAJ0BjeTPOycXSWpvB/9enxCoisiKkqcI2ya8ndbZdhWQ5TQrdbXdv7A+gTkwprK3K5cR9RBwasKKvyQRtAgXTkP4e/bpBjXmN8CWXTtYPeHEtlH6KBhNlLNM4rSboqZmM4sWNDTBAhw1crbVTj8HziZhQ302vH4xOoC3STbksqRSg0Rt2vSKsJMpsCTMEiiMfSXaIjVpLqZVJV3VjtYyREWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S8m9/G07q7toMjQ0Prow/pJ53GLzLkvO8Dt5ruPctuU=;
 b=I4AmwZoSUPl8jaKsjiLiZr0cZpI1L0MkErWQmcY5bK2QjHbOu2Pq7z0iOKh10ktsoLO2L/Tu2ABdtOLmAr45g75pjbDpYQqnJZe7K8YnGUd0x23QiKJ6n8KM5ymE3JGdAqSZ3OjV3qZsKeYppOM75WD9BNqMoiQb0Gf00wLoXM+dLqNLMV8dvr62znhpdIatriW3vNnCyBpVPQx2cwHO9/wziIDpa6tHlMxXVeYNWAOyP2arTDXbScKELpTI3Zk+ZJCaAlifOuyuch2pB8WAGQPkgBbQa3dvu/XndZP3w6LtU4WsEoq9M4fa99AaGccATW1sSCyUJNkJG/vkMNT5rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S8m9/G07q7toMjQ0Prow/pJ53GLzLkvO8Dt5ruPctuU=;
 b=HhNIqA2y4eMJ7XM8Aw4axshRL8kM6XFiOIl+aaBWNWiEEksDCUdAkCKTveOE+5YUQipj2k/Z62CJgTCc+3OcZzIFuywUH8yvNxbSwhOqb13eknJhvg+l03/HIEWv6ulm3fQEHNfQ2p8VOkpOMHfQjYMRBNGSyBQu06irP2zQ+t4=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by SA1PR10MB6389.namprd10.prod.outlook.com (2603:10b6:806:255::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.34; Mon, 29 Apr
 2024 17:48:17 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%4]) with mapi id 15.20.7519.031; Mon, 29 Apr 2024
 17:48:17 +0000
From: John Garry <john.g.garry@oracle.com>
To: david@fromorbit.com, djwong@kernel.org, hch@lst.de,
        viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz,
        chandan.babu@oracle.com, willy@infradead.org
Cc: axboe@kernel.dk, martin.petersen@oracle.com, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, tytso@mit.edu, jbongio@google.com,
        ojaswin@linux.ibm.com, ritesh.list@gmail.com, mcgrof@kernel.org,
        p.raghav@samsung.com, linux-xfs@vger.kernel.org,
        catherine.hoang@oracle.com, Dave Chinner <dchinner@redhat.com>,
        John Garry <john.g.garry@oracle.com>
Subject: [PATCH v3 06/21] xfs: introduce forced allocation alignment
Date: Mon, 29 Apr 2024 17:47:31 +0000
Message-Id: <20240429174746.2132161-7-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20240429174746.2132161-1-john.g.garry@oracle.com>
References: <20240429174746.2132161-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR05CA0054.namprd05.prod.outlook.com
 (2603:10b6:a03:74::31) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|SA1PR10MB6389:EE_
X-MS-Office365-Filtering-Correlation-Id: a6d79cae-188e-4f9f-8ed7-08dc68748d4a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|7416005|1800799015|376005|366007;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?dBkPToG/AAFhSY+vJ79OAnxbHyUlKVRWpkt+sUowzCE+oJm1yAU+MMacqk3J?=
 =?us-ascii?Q?LjmzzDUzyVLQ2mICXvEcKa7M8wpczs6DyaX8U/n+bkRyBYipFx5H74EPFH5x?=
 =?us-ascii?Q?W5sa1FMZ7G+BPCIeLg9Jf5FBzVGQXt2JzfVCTseJ7QUT0faenv0TYrAeyGby?=
 =?us-ascii?Q?IjUKKMSyWKn6LYoP/iGR2EejAORZAKaLo5n1d6kz2V9iiab81UhKd/4wefA3?=
 =?us-ascii?Q?Yi8vbi6eP28Aa6YQPo1VJ92PwE1zAD32wdqCjhkROBFGmAChqzkoZEZN62Ov?=
 =?us-ascii?Q?V9PbWY69+A77wVFKkbI0V/nHaWUH41dUvaJjTzF3dVHFu37J5Pwqw8Cwvskw?=
 =?us-ascii?Q?6oVBAxQrA6rhQN6wbiohk9RObgjMwGQrifT9Im0ESpa5cw5/ldy98fHoAGKM?=
 =?us-ascii?Q?DEamwuIuT89hsO41MDvfDP2hLXU8QQR5DAdj8TiAgzmmJkk8roFctNxKMQ5y?=
 =?us-ascii?Q?wwnXCsh+RfgD0LnYvzQY/wLc+oC/7iLz+S3QgT6hE/jpl+Co8XlwiDQPcAAG?=
 =?us-ascii?Q?ZryzE/TVUgnpm1nEHAAwjC5brIq0HEuPEmlXcdn3s1Q4D1n4CXJlH8NVhPnI?=
 =?us-ascii?Q?sR4vFMMbm2e63LgUrg5olZxRz7uPx8kjBZQB3Az8eyCs6hxt+/FciZtvwPWh?=
 =?us-ascii?Q?6NtwS/xFwlYRszQqxIbQxgc5aRyEi59W15x+ucTUXnpF/C68aiFNijgfSwV5?=
 =?us-ascii?Q?ewrPRVJSr0XyqXfkOjyfrrGA4s0qjnVhTUtaghDYzJrMIUZEoiN/impoX9Sz?=
 =?us-ascii?Q?oZmxivFKawDtJ1MK463DHkam8RCSh1VnIQWMUYpnUWF4ml7be+9QtZBd5ni4?=
 =?us-ascii?Q?iVQjF3SO2zHVrmsmhFXmNA7DVacrF2hIdpr2N1quTwLVR0/VVrCDazktTH2F?=
 =?us-ascii?Q?b/GbnEoP97VltMK35OBEyMhNz1cCPNDTDTKCWRbhQOekOcq9gTdZ7DCqYv+a?=
 =?us-ascii?Q?86y8mZzKrIp7jvjPobQGlAImjtz1ZfbzQfWsZE6k45Xgq4fbUvdYRS2qL3i9?=
 =?us-ascii?Q?M1JYTDpmMlGaVqa/VUhrSj9I5LMn8LyaZ+e2yw5FGBVqc2rqcp+ILvKv2z17?=
 =?us-ascii?Q?p0yTIKiBJSrLiL3M1ly/HGfzqXH6N9ZJZOstm7vnCp464diPc8SVDXWRm+9p?=
 =?us-ascii?Q?lzbdsHgZOcd4e7dEr9oNF16s1G4m95gBXhsOm0KPAJ8VMZWvcuTqqF+H2XrH?=
 =?us-ascii?Q?vi1zOdLkWJiHnyunBmMHglB/vm0ugdi87T7ED6Ap5ZhWNFGsT1cKCJn0HU54?=
 =?us-ascii?Q?VQ5oGIatZ5HzBk5eWd8WBywwtRZ8bmXIL077Y2ZIGA=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?oyc/F0sF16A89CVp1PTPCzB8qRLLGqIiwyL4161XQpO8JVPzBPJqbyYbGDFl?=
 =?us-ascii?Q?87fMRbt+f/FfnV1JtZAx8uvav0PjYQTfKDt7jqIMGwC54VHcJxecq2yAI8fz?=
 =?us-ascii?Q?nyQ5wbC20J728+uO1pTgPg9dWaffyFUEKCHvlEWg0EBu7eI0Mjz70/Ks0wVD?=
 =?us-ascii?Q?8M+864iTse+KBXnqY05IBA2u5AUv3jOj4wgo/5/xC1VC9nBTQOa6b6AO7OLT?=
 =?us-ascii?Q?4mWeYzudiZMy9pMuaP6tER5Go+HhHZvlV+6ValXQhraAqeofRkTfsCW9wdsf?=
 =?us-ascii?Q?EBziJeYAuDjH3BuFxAI0rhKmvBUzJwOb4VTfocc6zjSJSS6m/wAwqQYJ+PtC?=
 =?us-ascii?Q?6jt+5OtwxVlV7PNVBALXJFD6mzD7W7Ae6/UNgJZOb7YNOOygxqIJlCqVuINM?=
 =?us-ascii?Q?k14osYx37cT/6JL7gZN02xy52ZzGgCwnIv/YMekcWkfv/0z7ZN5lgPZd5ECT?=
 =?us-ascii?Q?QUSr6RKEGlOEVByr6qP69/fkUF0NmdOVXDwvY/A0x0jw6C2jKlXjRzFl53Hn?=
 =?us-ascii?Q?IWRx1BZPvRmKEUvlUe9w76TOB6G+LAa5jUIJ/JylOjQiHaXQTho0JON03hUk?=
 =?us-ascii?Q?b2QJQOfMk3OXjhtTMfBPi8vo0w8iT7uZIhr9+w4EJbAro1Q/gM8p9OprmyWN?=
 =?us-ascii?Q?SCAYOA9/bopEs3qe5mqhYlIOtAtXr5SU74DUj3abXioP7j1JRk+ciDXqhjyA?=
 =?us-ascii?Q?CE+tGcsuqfZXTZVasx7o4S97E/KpK5y/bXIT6DgRI5FJ7krJwhR0LRrzlMKT?=
 =?us-ascii?Q?dDcH9gMlTW5XObdGksZuwBDL5AOykfkbB8oky5vGBXRObA7GB4kVTco836cR?=
 =?us-ascii?Q?BmWjt9LZMrtpfeAPXP1PNAjOepBySoaJ/KBv0GuEldywRHXx/3rORe9kuuUN?=
 =?us-ascii?Q?iGWvJlCLhp8cnxaPoOHXnCG0qZWg/j87zS28dki4o5MnWfNQqKa0xlLCWdoK?=
 =?us-ascii?Q?iOiMajzKTKhTWgOpGX/qpl3MZVH0OPlg6s/aVaY4xn1P+Txqjb9KmbSjGC4z?=
 =?us-ascii?Q?GZEet7KqOepCREdxI+IJc+v1ACluvS217rVKU4mNyKo491uVnUKj+uxJR/Cg?=
 =?us-ascii?Q?vOd02+9O5NU89YwuZm56g1cruxTgQX/lrRwopcEn4frPwsxQYI1nixU+JayJ?=
 =?us-ascii?Q?siVuhuER38nH4IkAh+CXpmnXwPx747sGZ2ydeRQZ0AA1W0/B8O+HGCpzBO9v?=
 =?us-ascii?Q?etCDJ/xmZMUa5XTLTxwQisVDMoUwyHgCio0H62NQOiVugZN/c7vVkDgjDMhs?=
 =?us-ascii?Q?AbOEOw4vRSoIKYTQpV6mD310r6aqm2zK5KaF+8EoawsBDyVqYS4aAHfrAVTl?=
 =?us-ascii?Q?ajghG1drrKzqou+JbtSV7CjXAbZrbXo01cJyViiwYxE0XRtaOrlBjp4bt4Be?=
 =?us-ascii?Q?lCrW9z3QMz4Cyq+DZjb/ixPglc+aCtUYYV8UBCxzJl81NAw0Hv+UGy/PykTC?=
 =?us-ascii?Q?tv7oIBdZqn54zFfaDxZSUB54IMSuNwEIWtxxUYmtfdxLIDVxkOYLssVLB7eJ?=
 =?us-ascii?Q?8JUU5XLnocqdQzyLv2ZIHnjrlterCErKgbX4uIWCGshfO+xEhzRwBsFKSJVf?=
 =?us-ascii?Q?NvxPJfno0GDvwDubQMVsbHNlbfJWHM2tOg09FUVBfE4ty0dVP8jcliNdM372?=
 =?us-ascii?Q?bw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	uEsHoWnwkINPXZ3GZaxRR7JTeKnkXa8Bcqxxnh9i2g1NqA9/s+QgDUY9hJxJlSoOU9MkF+7GZndXuXdHzgkEgFs6wkuFXNW3LMHW1ymBnhg0T7lLx8CTnK1HLfWp0SSQDpsLQQLG26I2mGhiVSaT76vkTQm/GFY6CPgsL3GbSZvhfpSwRBfeML76xhhjgkxcTx78Wx+uJX0TRqW2vqVo7VTjdziNNuma4Tqnp8Iab1Igrrc5C5IZbKYq2e2JiigoJufWu7qMLI7q+a9B2OKCAX410MHUEA0nlgIpuWnFhaaceXfGQ4bOgbtLuURDG+BIptTy0traqLH5QmpcY8lp1iaawZW0QYXtQqsEU7wH2wlpXNEth5NAfa6qUIEpxFLxifUjYnsvOhsyaEfLwQSpOF+gqBXVzzgHHRy4puhYs/S/IyG5zUjjVST2vSxTS5aEWrNSK1Ge0IvfxQl2bY3C6gJr5Yu7e8Y2sM3K35tabJSJfUQY7chjEJvl3EkAF50nLJmPlIjdxS++L8TVMKAjtdMTyj6IGsxBBfBpOAmXdnlbnYFemPhuCicv7ojkpZOIDwrjuFN9c44kIIn0QI5bzWO/AoNVSxPvgUDZEGThbiY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6d79cae-188e-4f9f-8ed7-08dc68748d4a
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2024 17:48:17.6631
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BIsw0gVw9s1C5RZj699Ddr7E3exsvewoAYA52h+c/4ZA3IRffW09/N4bhRkgwjAkwTZVn8lSoRkRBS+Rfn87lw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB6389
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-29_15,2024-04-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 phishscore=0 bulkscore=0 malwarescore=0 spamscore=0 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404290115
X-Proofpoint-GUID: LJIaQDbXh59l6_0Dw2nVUOUldAxl7pNF
X-Proofpoint-ORIG-GUID: LJIaQDbXh59l6_0Dw2nVUOUldAxl7pNF

From: Dave Chinner <dchinner@redhat.com>

When forced allocation alignment is specified, the extent will
be aligned to the extent size hint size rather than stripe
alignment. If aligned allocation cannot be done, then the allocation
is failed rather than attempting non-aligned fallbacks.

Note: none of the per-inode force align configuration is present
yet, so this just triggers off an "always false" wrapper function
for the moment.

Signed-off-by: Dave Chinner <dchinner@redhat.com>
Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 fs/xfs/libxfs/xfs_alloc.h |  1 +
 fs/xfs/libxfs/xfs_bmap.c  | 29 +++++++++++++++++++++++------
 fs/xfs/xfs_inode.h        |  5 +++++
 3 files changed, 29 insertions(+), 6 deletions(-)

diff --git a/fs/xfs/libxfs/xfs_alloc.h b/fs/xfs/libxfs/xfs_alloc.h
index aa2c103d98f0..7de2e6f64882 100644
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
index c2ddf1875e52..7a0ef0900097 100644
--- a/fs/xfs/libxfs/xfs_bmap.c
+++ b/fs/xfs/libxfs/xfs_bmap.c
@@ -3411,9 +3411,10 @@ xfs_bmap_alloc_account(
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
@@ -3426,11 +3427,18 @@ xfs_bmap_compute_alignments(
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
@@ -3617,6 +3625,11 @@ xfs_bmap_btalloc_low_space(
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
@@ -3668,6 +3681,8 @@ xfs_bmap_btalloc_filestreams(
 
 	/* Attempt non-aligned allocation if we haven't already. */
 	if (!error && args->fsbno == NULLFSBLOCK && args->alignment > 1)  {
+		if (args->datatype & XFS_ALLOC_FORCEALIGN)
+			return error;
 		args->alignment = 1;
 		error = xfs_alloc_vextent_near_bno(args, ap->blkno);
 	}
@@ -3726,6 +3741,8 @@ xfs_bmap_btalloc_best_length(
 
 	/* Attempt non-aligned allocation if we haven't already. */
 	if (!error && args->fsbno == NULLFSBLOCK && args->alignment > 1)  {
+		if (args->datatype & XFS_ALLOC_FORCEALIGN)
+			return error;
 		args->alignment = 1;
 		error = xfs_alloc_vextent_start_ag(args, ap->blkno);
 	}
diff --git a/fs/xfs/xfs_inode.h b/fs/xfs/xfs_inode.h
index ab46ffb3ac19..67f10349a6ed 100644
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
  * Return the buftarg used for data allocations on a given inode.
  */
-- 
2.31.1



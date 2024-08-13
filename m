Return-Path: <linux-fsdevel+bounces-25798-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 265F1950A50
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Aug 2024 18:38:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A7B2B1F23BBC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Aug 2024 16:38:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F263A1A3BB1;
	Tue, 13 Aug 2024 16:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Q5NuGMJx";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="lDk7bSEk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E82741A38E8;
	Tue, 13 Aug 2024 16:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723567031; cv=fail; b=KS+4lX+OhHYH2hSGQI0DY6lOLacKbuZnEuPdZshG33JDR6uitAdbTRY36crZveHBsftsDT0/HulK9GEtqdGs8aCjEjirVzxyaM3iwE8Pr69qiWz22vYUjhVQussJLpQ5MjWiD4PxXCiR/snUP+8TrHsmggJ1EoVqWwSq1v65CG4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723567031; c=relaxed/simple;
	bh=7i1LDL3WYDWP3NMJkoXNt2iBX7UCtqjbXnxeIXFwoEU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=U+hzbAONmq0Fo4+ts4b7RThNSQ9dbCCgLWSTbxS5BjOxeT+c8UpthPV2dKkcCfrOT+4gbLf/86PH8oIK7iTHBEU71ydgf8LvLqmz+6A/To49tMu54HhsULlErdxqsl/F/aqZZ/377L019aXK1I5YZoPJvU9jWI4Cq9gUUtTlU9E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Q5NuGMJx; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=lDk7bSEk; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47DGBTwW007375;
	Tue, 13 Aug 2024 16:36:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:content-transfer-encoding:content-type:mime-version; s=
	corp-2023-11-20; bh=vFeIYph4qKUhP+iOm/lVH4SholLkFyhjHY9Wba5Ldkg=; b=
	Q5NuGMJxcsAfGwG27z7a9wmFy37uzPM404+RAjZy2QxLFRFxgGFUBdTwAnYcGtNI
	RQHlqF5sSLRFHDycIAnPgZOVtljQ0uKmAvqcQMxuDXlfeiEyCAqEvJb2R0OBNzNm
	DNtphhYbCODVl1eLbI93JPg+Ra+as+bAgVGbl+QJ34aeFPzh3NcZg9slQBmNDgHW
	al62pUmJxoMn1QVmkhInpmxPSkYYXOYbS8OIKBXugdHaT2kgXb4FwLJzEUKuxj2E
	5cHZLsrid8/JnFBJvBfjoTlqFYmtnr9mczElSb4qK2DfQc2MzB+0Z8h6equBlqtp
	lXGVfUe5ilyAhCt1+sORNQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40wxt0xffc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 13 Aug 2024 16:36:58 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 47DG94Wl017631;
	Tue, 13 Aug 2024 16:36:57 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 40wxn9pdey-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 13 Aug 2024 16:36:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SiCMZ/xh3aL9goHqeh5DFmg39bXjJvk1IXiKA+3WEyvtXxuTYhcgf2tGf5UrmHrlGK8eeWvIBBhwpt4nHrSDs5PpTRlz5ONpSiPJql+hel3YxlCdCa99ma/5oJOcaGMfqVqWNspjkvhE7TYSuJZcl6Lrwbvgxu74LjUX8CrrdIMAOC0E8R1ml/vtetAtE0vbYiAKUBnQvzOTMTKyjdBo4ClMfBQNFAH8Nfk0dDC++e4PL7GsT0KcTtAbxm0bzAfY9jNPXGWPtS6n8iQ7p1L8QHO9ZN+1ieYb+bIfsRLSBgtL93Sv0PLBHLGYRuJJgy/D6WSWEJJRcF4z8P5UPl/15g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vFeIYph4qKUhP+iOm/lVH4SholLkFyhjHY9Wba5Ldkg=;
 b=dgKk0ic+GNE6TVK42kLyyCjyDTldQIo00fhHAUtqUp3SybJmLKf0Gvo7wBawXusvj/7SxwNMUqkIB7jlSPeIeH8arJfC7BAtC2M36hkRETIvTHvvWi0MSUHwkPrXqqiybueWdDM6v8B2r8Hs+WE0byEEol6p00tJbruWM9pfCzq84evN3Z+LuxvvqD4k65q0UE+wBFkS6YngA1k84X5t1uBcYG7ECBuY11U/G7lvSASXHn1POA2owUBwxJUzW3JBsUGjGc/AMeCIm21gGqaS1ykYtRBJMnYCynxg6LKtDlyhcQ6DHlQqFx2tn7Urg+Xx2oYmDmWTXcTmDlBJxapIJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vFeIYph4qKUhP+iOm/lVH4SholLkFyhjHY9Wba5Ldkg=;
 b=lDk7bSEkvaCsyc9VkQfc4DwcZ9K96f1vehEHY9JJ9QQgtOpk3lfx7S+fPR2hBRyOSYBXCyvaY2EPLsje8tmObo1vjyuNvNLasWDydteSd9Yd3K/E7LnqXwEt08vY91ihEqMPestooaymziy1xg47PvtsGYKqiKaBT02sPW/Hv/I=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by PH7PR10MB5747.namprd10.prod.outlook.com (2603:10b6:510:127::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.13; Tue, 13 Aug
 2024 16:36:54 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%7]) with mapi id 15.20.7875.015; Tue, 13 Aug 2024
 16:36:54 +0000
From: John Garry <john.g.garry@oracle.com>
To: chandan.babu@oracle.com, djwong@kernel.org, dchinner@redhat.com,
        hch@lst.de
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz,
        linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, catherine.hoang@oracle.com,
        martin.petersen@oracle.com, John Garry <john.g.garry@oracle.com>
Subject: [PATCH v4 04/14] xfs: make EOF allocation simpler
Date: Tue, 13 Aug 2024 16:36:28 +0000
Message-Id: <20240813163638.3751939-5-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20240813163638.3751939-1-john.g.garry@oracle.com>
References: <20240813163638.3751939-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR03CA0016.namprd03.prod.outlook.com
 (2603:10b6:a02:a8::29) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|PH7PR10MB5747:EE_
X-MS-Office365-Filtering-Correlation-Id: 2098a8dc-cc31-40b8-b45a-08dcbbb6242e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?W6U4TIxZi3zTkTM0PQoGPwzm/vbyQ6MYUCXmc6ZT1KkpzZMrk/KPieL+p28x?=
 =?us-ascii?Q?CwgXqtQMOCcr6bDMnUuV98ddOAUNROSBM9B1eloU2uep5tB9cMKRM91Bz08V?=
 =?us-ascii?Q?P9o9hTLJ88YSswet7Gn9xm9p9lyR2NOmQ40ATcXz20sOH+AxBwpQH2eSlsRY?=
 =?us-ascii?Q?b1MuWV+TmH/Qk3laAS68nQZPYJUWAQKdy87DGcSXic2VYhHXQ7wQ6pzVd/Lq?=
 =?us-ascii?Q?VX685s8mOzxQAZj/XPpeEasBQ2kmzGPAyccEYqn4eOxpdrfUwlsEm9XJ3w3t?=
 =?us-ascii?Q?aC/UB5Bs1qYTmDkCkfoCY8QfgwRxh86tS2kXwvuYuGgZXWk9RtG/5ard+CKA?=
 =?us-ascii?Q?hW5gdcybxlQ0/V5a9rpYUlKvypSa02XkMHxKZeiMwAsWp2CGEV6LexHu7bBl?=
 =?us-ascii?Q?INtgvIk0lxBh+8qk+HGZ09kTU1eHcQRIbr8+9bjWSBWTH+EP7KJ2sGhMX7Tl?=
 =?us-ascii?Q?DKii1VnU9NYglgAPva5Hb9+rxbCeQF4uYgQ8mmAmDgEuIGKFhiwpgSyUw69e?=
 =?us-ascii?Q?j/wqUa7An8BDz3OiJOAs+NnPbjmo1m0/vUF7oQQSsFbnKatJok0ue9Sffs6t?=
 =?us-ascii?Q?xplyQcZNSTRc72d1V0EZthtvs5fp0jasO/PDBvopFGNmNhm9/0RzDVUvoTrq?=
 =?us-ascii?Q?hLscFrYO7wOusLweYvCyKwyKrk8VSxDFXP+Knl4FDWS0o2x65pREkAxoQbLo?=
 =?us-ascii?Q?rnx6U+iTgcCg3sfbgg4Km0r9xB2vqOyDhO9pssRrLt1YYWgYNdQcXwgoZA8U?=
 =?us-ascii?Q?6pTRjn1fej34ajrkJjGTjrUdEvZmOGa/vzTO3v4mAzktoqP8Ck8AO7WTSTJn?=
 =?us-ascii?Q?un4FRQFVHCKHdeHRz7lXxswbNKAYCj4hLu1OjeDUbHAjyGYFWKeBfLtovTUd?=
 =?us-ascii?Q?tep0CH0XNJbQaY9cNR8hibrUDV1i/f/lfky5gi3Y1I9qOozrjgJ/8Gojnmzs?=
 =?us-ascii?Q?bHPqK1/zic1o7DiJe+rOzzrYtVKJb9vE1ee5tAtv+xXEPw8GgbmgXBCz4Xog?=
 =?us-ascii?Q?GCzepStFJwMweq46R+SANWTYqvlhAbZ/z2jkwmGjq+7aAUhJpa5M2iS8+3bS?=
 =?us-ascii?Q?RuW0zGY5oC4cBLEhnng/K56KQTTxAIn1jmiSxImx4Rer28nXmYXIEQJre5N/?=
 =?us-ascii?Q?v3nef3HeeD0uZVLGW4bwEOe/Akkz96CFt4ack+ApPiygVr3F11Xk2AzCijbk?=
 =?us-ascii?Q?5n+xlp801SFnBiKHmO66Jh4OpBUoNoTebfMh09F2FyHp1rKKbgolwus3+YC/?=
 =?us-ascii?Q?MsuyXze8bylQrYTtD06OxZMn1+IyKQEJXPP7H9foJYPoGPZLoeIk69ApD0W5?=
 =?us-ascii?Q?2GJwxAjy/2XYXInDMxVMfAvUwaheh9KMNs0nTnQY1P9Ajw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?H86b4ENeaKxM4gCeUjhKGfLF2hVz1Uc34MJVQJUYfoDfHs8HsCJYTuJisRdE?=
 =?us-ascii?Q?QUUQyQluSBmIkqTRARs4xBCiFP5rudQuMjlSc6SXSdDCHEr8dYhwiG92T9bc?=
 =?us-ascii?Q?Je6XRT0CVqrAHCVQ3weeba/V70yyVodkKWDlMydY1+n7gQhrnAtqpnKyaw8W?=
 =?us-ascii?Q?o+9spMiMj2I/5kMPAjL1RxVAwoZJ6njJvvLZp7hsXUpfCc+ZensxD97tcNpy?=
 =?us-ascii?Q?5Ehh0uuPjJWe0IHpX+M+BBunn9OR2UTiPS9Jv/a7LGAzx/H/LqjMrDk8K3lA?=
 =?us-ascii?Q?78LeZceh4FyRqNJ1FnoCMnxCpSYvm4Kf1w4cH7tTucSvgnf5Clc9HDxIT0qa?=
 =?us-ascii?Q?AFSLRGy6mKQgyIAvh1pR40NTD4uRX/XppMQN2/ATpJOZBki57eEAJaO/pHrT?=
 =?us-ascii?Q?E+lqFmiv10Chz+8+hVT/zjXIXNzN0dYyju9BjgcQKElBk+IY7cKxk58P9DIn?=
 =?us-ascii?Q?tqkz20nWRTTaWzQkVQK6GBUkybe0nsziFdzRFwJxRGj/ru7kpnDuA45Y+z5X?=
 =?us-ascii?Q?9WI9Ws+oCZJCfdRF/GFJQ1YF5qDdUCCc3Pzzmb7JobUSaEPGrrB/qdh4VD6M?=
 =?us-ascii?Q?Ihm3EKzyGY62AdK8VqAKpyYvappx2srBzpBfjn2aMcBxQiq8+SflOwiC1LVX?=
 =?us-ascii?Q?lnFQupNuIO+9ivgcfT9NNLhmTKB6SMxpIewTV43MZNoerOn3UK8wIca5pbqX?=
 =?us-ascii?Q?HOKbzE9pvicCC3JTQJGpqwwXtw0hjHmOXGKrk+hi8+xRcSrlq2kkq8evkuSn?=
 =?us-ascii?Q?WWYDygWhTJbyotmnJiFiTmQWFh0z+d9v+twXO4yyduutZK4f4OsDRVot4jZO?=
 =?us-ascii?Q?10T1kDyCYSZKF09968w2CHk4+Y4909AN2VEs0ViLPQLD2+knwhzuLF3IxUCl?=
 =?us-ascii?Q?gPFyLuamtllztl+IleZ+8Ic9F8IHV1wCu1WAICoZEwMw3/LNIzPdXH1IMp2C?=
 =?us-ascii?Q?4t4isNssbZnbiLQ2Mp4hNZilX/iP1QCSCg7djFUrnvP5q81Wqbg1oqe7MJo3?=
 =?us-ascii?Q?VCdyNcPIGxpLCSUAe8fWxtP6/9KfqhTHPltC4Lw6mvEEo0pd4cvCD3XcyUHZ?=
 =?us-ascii?Q?k48FE980WskNW+KNK7ShSCkkYZSnvbakC92/wJG3HAtOtolFnLH+Oso7MHCw?=
 =?us-ascii?Q?6OtRmPo/asyKtBx6o+tHm/gPgIb5rbWHuJeL7REnkTNK0yYmMzmhbkU7i3Od?=
 =?us-ascii?Q?hDmx0w7KhnQUPfzCtg3s6HhMgStovXoqATsSGs1wnSivPyezzHKysyBWOhQD?=
 =?us-ascii?Q?y7DlAcvDDAyWGo4unnLgFNl2JSSOzN1/82x4XA0972dkLlFT0zvMkeoB0hSk?=
 =?us-ascii?Q?CFeXrcYOykwBhtik63neRODoouvOrXux4WKoZwg/aZ5b4hPUeiQTBn/uSc38?=
 =?us-ascii?Q?Kh/RuZYydx6iT6ljIBZqwKmPAJSfZj+mQZePzLdrYkLpm2D7NrUNVxpuvSLh?=
 =?us-ascii?Q?vO/lbV5Dx+Sz/btiW5SyPqkbmAnCmeWUqqCLMsAozJsR+og/1ODe0HFVg07l?=
 =?us-ascii?Q?KpBrMycJ7gW2mQ19EE6gvV0nGp0yvUJ5HcSpRMa/bxRbiUpNFGMeOndBzQxe?=
 =?us-ascii?Q?GYZsoeiAylkjhYT/9y1onP+5Cq9mvA0sOrty/iOL4rfdHAmDxiv+4i4F/cUK?=
 =?us-ascii?Q?ZQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	UlS4vvQGRPjsG2zUuh4zvJ5TjMAoy7ffEwfWU7Oy689mXRtpJ/XElxHUqnTtTSSa/vusEX667TXVLGSNf0+mLvxk+tvw17TVx+qiEQMPCLul3xbOossZm90tFuFr7aSTmJoRGThuMrVMirNnL+5K0SrNKgq8iIkmG99p6etINpE0wgZeNsew5d23s2m4ip/T3r6qcHnDzt3cZ+eohOOYedOKjj1LdUzrW80tnt4L3lcJOZlMMp8qf+hYFBywmcnBavYn0KiQLppOOCDtn1PFz/5F3TikJgi6r/deCr9PmkrJFItNl77aNLvknuYVb9zYNL0f/Fy8iimU9X0z3DfZR64cFg6afkRGGxF1WC0iAt6FfMEjto+JZE1ZiDZPwkIiKNzpkjY4HxN+k37BeldnLmXTy9WamkZeo5KUhrNJDCJ1EdcybtgefBP6gkA0it74H0nedIoZM3VXyLvVWq4wOForgCUFCAoIi1iXuVpUdV82aYdJ8Vwp/Ytk4FxHGxQZH5YIl3M8RUkxKUULafmN0joyHKomlSzCuW1TGStR86axM8hC6BDtgoQJaW6MBjwX9KcllThs17On+Ux/loR9OxyeWUzjFbnFFFIQDjMqfmA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2098a8dc-cc31-40b8-b45a-08dcbbb6242e
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2024 16:36:54.7098
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kY4XHqsWZ8Z0d/spyKFv9IIS8IbeoLPPrwAJbx7ULbo+bhJwdBKab5umUdxQ1EBudGYyFeVNs4SoBt91pxwloQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB5747
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-13_07,2024-08-13_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 spamscore=0
 phishscore=0 malwarescore=0 suspectscore=0 bulkscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2408130120
X-Proofpoint-GUID: uKkXokAwG8QeXvbnL0Y0zFig8fhvpBj8
X-Proofpoint-ORIG-GUID: uKkXokAwG8QeXvbnL0Y0zFig8fhvpBj8

From: Dave Chinner <dchinner@redhat.com>

Currently the allocation at EOF is broken into two cases - when the
offset is zero and when the offset is non-zero. When the offset is
non-zero, we try to do exact block allocation for contiguous
extent allocation. When the offset is zero, the allocation is simply
an aligned allocation.

We want aligned allocation as the fallback when exact block
allocation fails, but that complicates the EOF allocation in that it
now has to handle two different allocation cases. The
caller also has to handle allocation when not at EOF, and for the
upcoming forced alignment changes we need that to also be aligned
allocation.

To simplify all this, pull the aligned allocation cases back into
the callers and leave the EOF allocation path for exact block
allocation only. This means that the EOF exact block allocation
fallback path is the normal aligned allocation path and that ends up
making things a lot simpler when forced alignment is introduced.

Signed-off-by: Dave Chinner <dchinner@redhat.com>
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 fs/xfs/libxfs/xfs_bmap.c   | 129 +++++++++++++++----------------------
 fs/xfs/libxfs/xfs_ialloc.c |   2 +-
 2 files changed, 54 insertions(+), 77 deletions(-)

diff --git a/fs/xfs/libxfs/xfs_bmap.c b/fs/xfs/libxfs/xfs_bmap.c
index 25a87e1154bb..42a75d257b35 100644
--- a/fs/xfs/libxfs/xfs_bmap.c
+++ b/fs/xfs/libxfs/xfs_bmap.c
@@ -3310,12 +3310,12 @@ xfs_bmap_select_minlen(
 static int
 xfs_bmap_btalloc_select_lengths(
 	struct xfs_bmalloca	*ap,
-	struct xfs_alloc_arg	*args,
-	xfs_extlen_t		*blen)
+	struct xfs_alloc_arg	*args)
 {
 	struct xfs_mount	*mp = args->mp;
 	struct xfs_perag	*pag;
 	xfs_agnumber_t		agno, startag;
+	xfs_extlen_t		blen = 0;
 	int			error = 0;
 
 	if (ap->tp->t_flags & XFS_TRANS_LOWMODE) {
@@ -3329,19 +3329,18 @@ xfs_bmap_btalloc_select_lengths(
 	if (startag == NULLAGNUMBER)
 		startag = 0;
 
-	*blen = 0;
 	for_each_perag_wrap(mp, startag, agno, pag) {
-		error = xfs_bmap_longest_free_extent(pag, args->tp, blen);
+		error = xfs_bmap_longest_free_extent(pag, args->tp, &blen);
 		if (error && error != -EAGAIN)
 			break;
 		error = 0;
-		if (*blen >= args->maxlen)
+		if (blen >= args->maxlen)
 			break;
 	}
 	if (pag)
 		xfs_perag_rele(pag);
 
-	args->minlen = xfs_bmap_select_minlen(ap, args, *blen);
+	args->minlen = xfs_bmap_select_minlen(ap, args, blen);
 	return error;
 }
 
@@ -3551,78 +3550,40 @@ xfs_bmap_exact_minlen_extent_alloc(
  * If we are not low on available data blocks and we are allocating at
  * EOF, optimise allocation for contiguous file extension and/or stripe
  * alignment of the new extent.
- *
- * NOTE: ap->aeof is only set if the allocation length is >= the
- * stripe unit and the allocation offset is at the end of file.
  */
 static int
 xfs_bmap_btalloc_at_eof(
 	struct xfs_bmalloca	*ap,
-	struct xfs_alloc_arg	*args,
-	xfs_extlen_t		blen,
-	bool			ag_only)
+	struct xfs_alloc_arg	*args)
 {
 	struct xfs_mount	*mp = args->mp;
 	struct xfs_perag	*caller_pag = args->pag;
+	xfs_extlen_t		alignment = args->alignment;
 	int			error;
 
+	ASSERT(ap->aeof && ap->offset);
+	ASSERT(args->alignment >= 1);
+
 	/*
-	 * If there are already extents in the file, try an exact EOF block
-	 * allocation to extend the file as a contiguous extent. If that fails,
-	 * or it's the first allocation in a file, just try for a stripe aligned
-	 * allocation.
+	 * Compute the alignment slop for the fallback path so we ensure
+	 * we account for the potential alignemnt space required by the
+	 * fallback paths before we modify the AGF and AGFL here.
 	 */
-	if (ap->offset) {
-		xfs_extlen_t	alignment = args->alignment;
-
-		/*
-		 * Compute the alignment slop for the fallback path so we ensure
-		 * we account for the potential alignment space required by the
-		 * fallback paths before we modify the AGF and AGFL here.
-		 */
-		args->alignment = 1;
-		args->alignslop = alignment - args->alignment;
-
-		if (!caller_pag)
-			args->pag = xfs_perag_get(mp, XFS_FSB_TO_AGNO(mp, ap->blkno));
-		error = xfs_alloc_vextent_exact_bno(args, ap->blkno);
-		if (!caller_pag) {
-			xfs_perag_put(args->pag);
-			args->pag = NULL;
-		}
-		if (error)
-			return error;
-
-		if (args->fsbno != NULLFSBLOCK)
-			return 0;
-		/*
-		 * Exact allocation failed. Reset to try an aligned allocation
-		 * according to the original allocation specification.
-		 */
-		args->alignment = alignment;
-		args->alignslop = 0;
-	}
+	args->alignment = 1;
+	args->alignslop = alignment - args->alignment;
 
-	if (ag_only) {
-		error = xfs_alloc_vextent_near_bno(args, ap->blkno);
-	} else {
+	if (!caller_pag)
+		args->pag = xfs_perag_get(mp, XFS_FSB_TO_AGNO(mp, ap->blkno));
+	error = xfs_alloc_vextent_exact_bno(args, ap->blkno);
+	if (!caller_pag) {
+		xfs_perag_put(args->pag);
 		args->pag = NULL;
-		error = xfs_alloc_vextent_start_ag(args, ap->blkno);
-		ASSERT(args->pag == NULL);
-		args->pag = caller_pag;
 	}
-	if (error)
-		return error;
 
-	if (args->fsbno != NULLFSBLOCK)
-		return 0;
-
-	/*
-	 * Aligned allocation failed, so all fallback paths from here drop the
-	 * start alignment requirement as we know it will not succeed.
-	 */
-	args->alignment = 1;
-	return 0;
+	/* Reset alignment to original specifications.  */
+	args->alignment = alignment;
+	args->alignslop = 0;
+	return error;
 }
 
 /*
@@ -3688,12 +3649,19 @@ xfs_bmap_btalloc_filestreams(
 	}
 
 	args->minlen = xfs_bmap_select_minlen(ap, args, blen);
-	if (ap->aeof)
-		error = xfs_bmap_btalloc_at_eof(ap, args, blen, true);
+	if (ap->aeof && ap->offset)
+		error = xfs_bmap_btalloc_at_eof(ap, args);
 
+	/* This may be an aligned allocation attempt. */
 	if (!error && args->fsbno == NULLFSBLOCK)
 		error = xfs_alloc_vextent_near_bno(args, ap->blkno);
 
+	/* Attempt non-aligned allocation if we haven't already. */
+	if (!error && args->fsbno == NULLFSBLOCK && args->alignment > 1)  {
+		args->alignment = 1;
+		error = xfs_alloc_vextent_near_bno(args, ap->blkno);
+	}
+
 out_low_space:
 	/*
 	 * We are now done with the perag reference for the filestreams
@@ -3715,7 +3683,6 @@ xfs_bmap_btalloc_best_length(
 	struct xfs_bmalloca	*ap,
 	struct xfs_alloc_arg	*args)
 {
-	xfs_extlen_t		blen = 0;
 	int			error;
 
 	ap->blkno = XFS_INO_TO_FSB(args->mp, ap->ip->i_ino);
@@ -3726,23 +3693,33 @@ xfs_bmap_btalloc_best_length(
 	 * the request.  If one isn't found, then adjust the minimum allocation
 	 * size to the largest space found.
 	 */
-	error = xfs_bmap_btalloc_select_lengths(ap, args, &blen);
+	error = xfs_bmap_btalloc_select_lengths(ap, args);
 	if (error)
 		return error;
 
 	/*
-	 * Don't attempt optimal EOF allocation if previous allocations barely
-	 * succeeded due to being near ENOSPC. It is highly unlikely we'll get
-	 * optimal or even aligned allocations in this case, so don't waste time
-	 * trying.
+	 * If we are in low space mode, then optimal allocation will fail so
+	 * prepare for minimal allocation and run the low space algorithm
+	 * immediately.
 	 */
-	if (ap->aeof && !(ap->tp->t_flags & XFS_TRANS_LOWMODE)) {
-		error = xfs_bmap_btalloc_at_eof(ap, args, blen, false);
-		if (error || args->fsbno != NULLFSBLOCK)
-			return error;
+	if (ap->tp->t_flags & XFS_TRANS_LOWMODE) {
+		ASSERT(args->fsbno == NULLFSBLOCK);
+		return xfs_bmap_btalloc_low_space(ap, args);
+	}
+
+	if (ap->aeof && ap->offset)
+		error = xfs_bmap_btalloc_at_eof(ap, args);
+
+	/* This may be an aligned allocation attempt. */
+	if (!error && args->fsbno == NULLFSBLOCK)
+		error = xfs_alloc_vextent_start_ag(args, ap->blkno);
+
+	/* Attempt non-aligned allocation if we haven't already. */
+	if (!error && args->fsbno == NULLFSBLOCK && args->alignment > 1)  {
+		args->alignment = 1;
+		error = xfs_alloc_vextent_start_ag(args, ap->blkno);
 	}
 
-	error = xfs_alloc_vextent_start_ag(args, ap->blkno);
 	if (error || args->fsbno != NULLFSBLOCK)
 		return error;
 
diff --git a/fs/xfs/libxfs/xfs_ialloc.c b/fs/xfs/libxfs/xfs_ialloc.c
index 2fa29d2f004e..c5d220d51757 100644
--- a/fs/xfs/libxfs/xfs_ialloc.c
+++ b/fs/xfs/libxfs/xfs_ialloc.c
@@ -780,7 +780,7 @@ xfs_ialloc_ag_alloc(
 		 * the exact agbno requirement and increase the alignment
 		 * instead. It is critical that the total size of the request
 		 * (len + alignment + slop) does not increase from this point
-		 * on, so reset minalignslop to ensure it is not included in
+		 * on, so reset alignslop to ensure it is not included in
 		 * subsequent requests.
 		 */
 		args.alignslop = 0;
-- 
2.31.1



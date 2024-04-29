Return-Path: <linux-fsdevel+bounces-18139-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EEA388B607D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Apr 2024 19:49:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 799F61F222B2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Apr 2024 17:49:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B21891292FB;
	Mon, 29 Apr 2024 17:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="an8l4E8g";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ih39yMY5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95E6E127B4E;
	Mon, 29 Apr 2024 17:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714412938; cv=fail; b=Uwb2MNhVEcecYZLM1oloiTMFNxEluY93xqlAa6jXY6ApIjs6vXJ1iBvu9dICIws9wARDNX1ujInE9G+NDPRbj05sk3OfEoR6hl0NwyzkdZhRCD4bGiOllQ6PGuKDK+5NzFLuSSyulzPra5uxUHHVaRVXrBve8TcqBaKxi+1MAzc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714412938; c=relaxed/simple;
	bh=dB5gSlWFXJvHmdCUR/S31Ip4hqxj8kMFpx2YXc5hqxk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=c5QwmYmu41AcPvPev8dkMWCUFBU/z51KYWYsZdDglFVL3cr8VaJg9VRamwMeg2UmSXHL+2IPPaEj4MRv8touDay07sthbzAdgef0aJtmhDqzDAyvzfmcqSEGGV4HzC8CdwLnm5E4Itrn0V8n0+iR5ikdgSKqNKGKuoowIX/gxpI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=an8l4E8g; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ih39yMY5; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43TGwmBq002395;
	Mon, 29 Apr 2024 17:48:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-11-20; bh=sE6iv6DI5Dzh+Sm5956ocukjy6rHOPoR2oP4a6r/Abo=;
 b=an8l4E8gnQHiZsTtXIEnVg1Bi7mOv0/JuDEFwdGDJGc/anQ1GEUHMFFGaxcpY7tGn0CL
 duUplD82HYVI3OnYaPXOENifZDf5cX11W+wdEi8VF+8cpR31FiZA7Wo2WiW8Qx/RAi5i
 biQKXKxQuYpPH5udJtNsP49J6VxsBJWsuY/Y0p3qwI+nkUDuPCGl2RkN4jznwJrNMhny
 W5LaZZStcKCP1h2X1lWak9M+b1m6YAwC3XXiedit53FD5nUz9biu9gtDSaiWTjwJDv9K
 MPIbwM9FRsTPxnupsoX7A/myNRcUevP3nebiNlR5HmNOMnkbRDlkNu0I3UxwayxLuTKP Zg== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xrqseu6p1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 29 Apr 2024 17:48:31 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 43THkxUY004324;
	Mon, 29 Apr 2024 17:48:31 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3xrqtc7ns0-10
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 29 Apr 2024 17:48:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Kn7PVVX13m7opCfwag+warNxAcD1gWJ/VB5VlfVB5A/yGsienybJckZKSbmqlW6nm8lYRuwFYkr00W6sWCECAjU05IGMh8RT1HkNm1OkUh0xBuKl0LkbG4OJ5X3KriedJPN/GIo9eEGtNnHFRnyDNS4HuJFAd7K3l8ghygvl1JePuzMZZL2Zb5MDkQYwENHUpPoPDYUmvlm6WwzhKhdcd15kGsyh9LivA7gdgnHV7mFg+C2DjfHlC5g77gdu+nRukTKo3RIyWNTtoFO5NOzu3qBaN68mBsjKKPnEc5tgTr4zCNq3wkYLEtJzct883LiKnbiHotp2YTBjYiPxKYBeeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sE6iv6DI5Dzh+Sm5956ocukjy6rHOPoR2oP4a6r/Abo=;
 b=R0+zV0AVzUZ8YxdDJW2NEIs/+GyYGWJpy5raZRlYg8uS1VGitgmESc7oNU9+WWnLRiGWYZzUoyNDdsvnISSMI96WgClUx1+nPLhJVPZjIg2bafu6tvbOp8YMlFciw4Z7imh5yBbUpf1IieGCwUKhbkROV507XQfxALItrK8CxMdtJnlGmbXvmdnkN69/xxQicCUDmmMoJuqg3G6DcmjhgZUo+m587WGQv8mbCCzLgGP1KTtAAZGf+TKtmexBBgmhjFNqDQvdE+PhCfSrz72ClXbPpYKfIV2yV7xhaNkrk28D8zJrr7Evyn7GLrJLZupIyC+cPvvoOeDV2aRFDmKySQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sE6iv6DI5Dzh+Sm5956ocukjy6rHOPoR2oP4a6r/Abo=;
 b=ih39yMY5G/U3t1vciTdf+fKSd9YigGsiMCTNuSpNQUHzQ5I/rNM3HMO8Py72U6ELB4uL8eXo8q8RWtRBqBiDwHSbQ+wZzyPJwQamcXcsdVR/+0MFmiYLL6KTnQh0WhWhnhpQcajap5iD0+ffKCY58JY8UkOp9BEag16hWZKDiRY=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by SA1PR10MB6389.namprd10.prod.outlook.com (2603:10b6:806:255::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.34; Mon, 29 Apr
 2024 17:48:27 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%4]) with mapi id 15.20.7519.031; Mon, 29 Apr 2024
 17:48:26 +0000
From: John Garry <john.g.garry@oracle.com>
To: david@fromorbit.com, djwong@kernel.org, hch@lst.de,
        viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz,
        chandan.babu@oracle.com, willy@infradead.org
Cc: axboe@kernel.dk, martin.petersen@oracle.com, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, tytso@mit.edu, jbongio@google.com,
        ojaswin@linux.ibm.com, ritesh.list@gmail.com, mcgrof@kernel.org,
        p.raghav@samsung.com, linux-xfs@vger.kernel.org,
        catherine.hoang@oracle.com, John Garry <john.g.garry@oracle.com>
Subject: [PATCH v3 10/21] xfs: Update xfs_is_falloc_aligned() mask for forcealign
Date: Mon, 29 Apr 2024 17:47:35 +0000
Message-Id: <20240429174746.2132161-11-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20240429174746.2132161-1-john.g.garry@oracle.com>
References: <20240429174746.2132161-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0084.namprd13.prod.outlook.com
 (2603:10b6:a03:2c4::29) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|SA1PR10MB6389:EE_
X-MS-Office365-Filtering-Correlation-Id: be02b222-bbb1-4d11-7e88-08dc687492c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|7416005|1800799015|376005|366007;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?mmU4E3SJDZ2pFuKB8BMVq6z7tYtPUQPSGBUlduHy/mD+lu5ZdYfZHPEmsii1?=
 =?us-ascii?Q?Uo9Pas85IOCxYUf/uxuFr9T41w0HqOZ054Y+H2kwanmamUNp5kzAHue6eUFc?=
 =?us-ascii?Q?mzzZaCkKd2tEpOoE8N+s80W2n7iaQU7qMvkrz5qsypbknNJT3Q3f3TMhmF9u?=
 =?us-ascii?Q?QaFf/BpuoDUaSTYbtd5RWcdFSuCAE2IZ5ClkagxTW002nF53ppYdBJ9gVcgu?=
 =?us-ascii?Q?gicZiBMXfe2Pz1O7bAz4S4HcR9wyyD1xgAZ3yaS73SF6CBfmeAVviKvRwXpS?=
 =?us-ascii?Q?NlL7dWf/zymb3/cenOJzHrRY4Rt7mOgjE3W8EZS49sndb+8L8FQmw4kZRH3h?=
 =?us-ascii?Q?Gxpx9q4xGrL5Mv1W5LtoA9oht0L20yFPrSkGOnElBfWws7mg1I+b2JIqk0o6?=
 =?us-ascii?Q?eEkg8NerGCqjau154WbQ7sQoIThgCcrqRuexd4AmSHFdGojjGlN3t251zYUf?=
 =?us-ascii?Q?sRqyvgPwmJVvaiKCmWJxOLLIzNNMmjsj1NCatRMZA/n/qSl8MSlgFZVDO+x8?=
 =?us-ascii?Q?maolswnNGVoFOzKhRFnA/XfF+hPu6mT+/d0zfA6i7UocBDt0mQ6RAO5Fb7c9?=
 =?us-ascii?Q?W2M6uNPmgdrKz9quhA0gYh1y8X+uBrVhbZmIz6YcT8b7wrClGbiuHJTmdsWl?=
 =?us-ascii?Q?UWMyVLSNRovedUSqFhicyurWALZZF+rxFXhzBXzuNv6LIngqpGnoHDmM+03r?=
 =?us-ascii?Q?fQdQkWtlxO5E+/47KQCQ6Vfn/q0pJfz+TQGIGZw6mlkvUSr/og/SWU5s/43c?=
 =?us-ascii?Q?yJ7T7fYuLXkrzQHeEPcWFTmqzV+zIIgnA2Imdt5ZeWPJNAry+7BiWqFaYMeT?=
 =?us-ascii?Q?2Tshts0y280keyMDq4pxXtnYJfivUgQMMf4qFBpgYcrUcxO8C8wtUY4HHlZj?=
 =?us-ascii?Q?raddlAvvuHa8jY3c6v4L0Go7Y8804YcU0x7IX0Y2A9MbiPdONxoNlNycFzdN?=
 =?us-ascii?Q?KB1O749xoSnDVWEr3B4KGXlMYtVr/H0jXMF82qICxyG12UqAf26bbU8dWPgI?=
 =?us-ascii?Q?g4kzcO5LkOeAS4jBFTcrI0hUphZD18yvHVRMpGZ6de7z6ZkGZnPv1oFCV1BO?=
 =?us-ascii?Q?FB9EkL0VMpcKxd0IQ0PRGqDUJAICunOpv1ISJp2lYVvp0zvfq+5TduPAGYAF?=
 =?us-ascii?Q?SlHYAXvMRQ0I0PXQMkFp+RegJzf+VmuCHIktEcG1GWPTj6Bj/+/fF9/gsu/4?=
 =?us-ascii?Q?CvxyoC+Mn1sNdjTMWY/fAbSFCQZLhDKZgARRzdH4FqqYAz8HiKoQIwuQG5G5?=
 =?us-ascii?Q?De6WI5ecls/McpmxnP8PJe8T1a1/A5HFlFp5x7eDTA=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?zKtJGjhPdlPNA9WJi6Xbo5222SIqK7Ge5L0U6NOf8zuaijjxEMBPG6HifL6N?=
 =?us-ascii?Q?JMg0v/XngcIW2fpBTfc+imvQKiO/vOw7HI1qQS+jYNp2++mE/kHleOTxkdjR?=
 =?us-ascii?Q?M/y/Q0xa4pyA0Qp9A8eSAoPDCSlQYi3vrtwvxBaEvaBhJm+O5h0ukHlsuiQF?=
 =?us-ascii?Q?zw3e7wmUineCcWoQLZPOZ0yDzmt9ha23TKe03wrM8JdUe5xMzs2Tl0pKtM7+?=
 =?us-ascii?Q?h3s8cUXaDEZnfZh9LUbHCxYz1pqbU61vvYj7H5gWjZJ2DbOFR7V+jml4Xt/c?=
 =?us-ascii?Q?1UC+G7rADonHCTts0u7Nf9uB71We4jkO+oFh+F7BNJEXGu10jxGriuoC+YO9?=
 =?us-ascii?Q?OCchkrtHCOqVUltgNbr0lrEx0DC0CWzDIE8J9Odl9EPvzn20rps4tPeYd/5P?=
 =?us-ascii?Q?fifERJfOl8e4D0stPkIxdPFBPGdZwXYQ05Qbike9srpldr/KCKwYaBOhvmAS?=
 =?us-ascii?Q?+XK7d+T37ZI7I/NCVD25Na56bN9fnDDJfAeeMV4d2p1dCrLdXGh61j2xIfyU?=
 =?us-ascii?Q?LRp8I62Bn93BNG9N/g23SJjgH1nOVMTHL5nRgaEG2UTAEKANa5EChmXn2TLY?=
 =?us-ascii?Q?/DD4UKUUd3VpFf0vJRrouW0qnq1xLUFNw1Z1+VNSq2LX7iA5qs+MX+MJVIt1?=
 =?us-ascii?Q?HoMWng1/F2QhwjVaxzlBrymMoDAhCfpenuBLA/z8ZZuDl0l3DGl2s1mY9QwC?=
 =?us-ascii?Q?JfLvUhIxjFD7enw5eI3bP0yj+FQvLuhGZPJYs6xro6bFKdyNUE9RNeI9jNl5?=
 =?us-ascii?Q?6KTWWGECdCNX4X0KEYWNkc4zKsYhhGN4ucBXueNxjaYFj9UN60eIWpHz/HnL?=
 =?us-ascii?Q?kCM60rfA9KTehXf0jfl4c3aQxNDfdEzbVGesBunMwScuKjRKrtCJ80JzFrwE?=
 =?us-ascii?Q?wYpY1FXQpwCWCnYMQ+IkNvuO52WxIIfcGJXqJEk3KXRGKLWnWrufQt8lpaeN?=
 =?us-ascii?Q?67H1Yar2OtmnwiCS7ucHrPBmoYZ4NWlQcKl33QwX+Ua1GTU1MfN/egBEr4zw?=
 =?us-ascii?Q?JskWC1BuO7AAGXy+6eug9bIgPmiSxu5j/c0ooWSIAT9N72RRiqeY4yr7i8aY?=
 =?us-ascii?Q?n1t3a5zJDfAdnYe7XBPR5xKp8+IXxUzZduqkLXSdp6d2NrfGuGfFBF0EzP5f?=
 =?us-ascii?Q?iXsv4Jn6sbilK3tv7SED3BJvVAxCE0mj1TXYVS1tpdfVetFFnU3aLMsX3aS3?=
 =?us-ascii?Q?OSzIerl836j0ax5JXu1x4FKz7ihpqNokodUl3WwvKn2wmoshn2D5Y/1UXa2/?=
 =?us-ascii?Q?KRKaJyn4NxRypiUGW74BU8SVrLUTz+Dv28G48q3fe9fs2f3ZRrfhMvFaEmh1?=
 =?us-ascii?Q?85/hMhK5WMEb3Df3p8mr/smS1HsWLMAEhQLb/dtSESaH9VLcYcljCRzDGBZ3?=
 =?us-ascii?Q?Jd2RrIOt4wMferPwxPnmsbzjt7TnD2imToR0bTkmJX/dbJZhOX45XWREH6YD?=
 =?us-ascii?Q?UX0OKXXmC7tKauK5Z6itURPELGOK2NDfs0Z19DFJ58rExDtEkPX+n6iJJC+w?=
 =?us-ascii?Q?hDhmrw/ui8RxaXlof8WsErr+j29VIZlbnjakR5sdYPnuhakiBBZxLTtHLS6p?=
 =?us-ascii?Q?q1/oY9mOQm+qm57MTw8Lfc1ifp1DNsjzhhaqp6DtHjuzQUvW0BoKDn9xy3Pm?=
 =?us-ascii?Q?Dg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	owZQdcu3/KCHYSw/tDDMAKTtiHXLX9SIJ5X8yUUa6ywWgzILBajSO5QJonm0mB4i25H+EkxM1GRd4Zl1n5F2+aAn1f/m94IGnnb61G6yQ0QebKVXKdwgDzhPD8ACaMP8sX187/s1xrG8ydLsbNnj6QR3Kqve9rY8F/f3i7dIujKmirUm18DtgB2VptP79b9nF5VXxjjLv6dQzsJObvE2gjEA097Wor/sA+8eDHox6vu3j5+yPhwNTH2QncfX6FH76l9vxW63UeDpv4zwuhHqNUnq8zyyBgxam4Lv7IFEgEcZMuXdYoUBafk2omlbwRNQeP3Yxfkb3BmzXyatmFZ0zilYWlr9PqSVZPwuYERotcS0AZtZJmtZtYXDzeS8egrLTeTEiMaDEbGEa7/tS9qmx/32FwhmOrZm+hVQXD538WGV8VZWWgu/sigM5kx26WFvv7/5hNAxuhTBtzQWOUz+O4d/cPgR1xUm9zZL8XNOGjdgoExI8pi+ca364wnKMegb+JBSdXYpHfXEI8TjeXFfWd9ZGhjDuOLHy3Ai85Cjx6cQ7VXOgUwdFlG47SSe7p5qjK7J7ZvBpPb983D3/Bl5VrixiJcwR6mv6LHKP/DX+ow=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be02b222-bbb1-4d11-7e88-08dc687492c8
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2024 17:48:26.8911
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ohnPUBShgN3AEPpy5CrtrhhqsoUe3npAnJbpRwCJ1GEoKFthyWDNQM6ftN9GO1X4QhLgNs3vGtKMUR5bVz0L8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB6389
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-29_15,2024-04-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 phishscore=0 bulkscore=0 malwarescore=0 spamscore=0 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404290115
X-Proofpoint-ORIG-GUID: buFI0N80llPZ2RrX2aF-lQ16QFipq0dp
X-Proofpoint-GUID: buFI0N80llPZ2RrX2aF-lQ16QFipq0dp

For when forcealign is enabled, we want the alignment mask to cover an
aligned extent, similar to rtvol.

Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 fs/xfs/xfs_file.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
index 632653e00906..e81e01e6b22b 100644
--- a/fs/xfs/xfs_file.c
+++ b/fs/xfs/xfs_file.c
@@ -61,7 +61,10 @@ xfs_is_falloc_aligned(
 		}
 		mask = XFS_FSB_TO_B(mp, mp->m_sb.sb_rextsize) - 1;
 	} else {
-		mask = mp->m_sb.sb_blocksize - 1;
+		if (xfs_inode_has_forcealign(ip) && ip->i_extsize > 1)
+			mask = (mp->m_sb.sb_blocksize * ip->i_extsize) - 1;
+		else
+			mask = mp->m_sb.sb_blocksize - 1;
 	}
 
 	return !((pos | len) & mask);
-- 
2.31.1



Return-Path: <linux-fsdevel+bounces-38322-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE6749FFA14
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Jan 2025 15:05:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8951F160EE9
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Jan 2025 14:05:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1B741B4151;
	Thu,  2 Jan 2025 14:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="lWDnLmwG";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="BcruxG1V"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A613B1B395D;
	Thu,  2 Jan 2025 14:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735826697; cv=fail; b=aBu0j7okdD8DbXdaVBhRV7MSrDA6x18lz5V4k/nBFlTR5RdK7oQw2b5LmtBugCgOl38gKgOeY4BwyKseEL5/bJjF0vB3D32krMTZDSFtjWRmEoKMIFgIa9uiPp0iHnNj76juBHvI8HKsFyR2S8p13NApv1671galSi0EVzAzJwg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735826697; c=relaxed/simple;
	bh=H1o8e8YnNVViXxG+sQw9cSh9KhxfRtE1hzn4SZSKGv0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nJPEpkvRnfK1kX38vEUIfaiylC04zS1LUM/McXL593UYoSJLZRhFLJD6fd5o3pO8VH+WcNcbNp03hzcPlN2cZmJ1m/jNUBTxR2Jjgorzb6vQ7UHrqPfM60KILLmYaGQoyVRU4ycH/NhbrCyrNrgjrq0CzhA+KZsEFFe7wjOan90=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=lWDnLmwG; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=BcruxG1V; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 502DtpJd014818;
	Thu, 2 Jan 2025 14:04:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=eVzjfwpjouHHWfThZXSXLNo1RzZ3SFT281E31EQPR3k=; b=
	lWDnLmwGTlUo4VtVVvkue+k1yhRmGzS5jGBp9q7zYsTd4FPG1BzMXuADd35SOC9y
	tXkF/R8SBWQKJAe5NndVVGVBpnzFnTiHmatJoMBgdYUSrxb/FIPVnxNEyUylJkUn
	OLezIqT/TavVVn9O5F6fHqtaBy8YTUE0pHXC6v3pOX/n1LvIQfLhgx1TYhFH3WDl
	IcDQVwETW/qWvHpzyrStP1SnFiLdvzkuTUdrlp4nYHE4ezLlVqDR43N+OILZNVVd
	VY8s8iDbVH2HN7HLgE8UnwPgRCWamGb5woTvh5Mh569lpReZo+uNb+F5vDN+xadv
	WO7znsMVxx3yP5giD/YI/A==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43t9vt5bvb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 02 Jan 2025 14:04:48 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 502CoJI7009189;
	Thu, 2 Jan 2025 14:04:47 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2171.outbound.protection.outlook.com [104.47.57.171])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 43t7s8tsax-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 02 Jan 2025 14:04:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bLM2qes5knB+1xf/+lpR6rhdUoyYiJvbwhfv43PGfbD5m9k8j++ef5GkzupQAmQ+Ii/upYIkK3VQZIlaN6KR3Uaule7YFTwqMsH1PAfaQoLtdY8i020u2gX3gZ967s0FTJyXISI7mxG+cEK6R3x6MIFUc8Me+fp+Ny3Q0INiUEy+cxPPWagPZZTUFyvi+1rG3U30bgvXaGjx6FdSDQLg6TrfXqQcolVzFFhWY0FvyxJ73D7typb2NJgfTXjmFv4bEKopvCkYJWZdvPHiax4f4yAwe2LBwNQ0LKW3wOu/KuOCSqRjpHpo54t1uwmE605Ox0FFA9pe24ry70P1i94OjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eVzjfwpjouHHWfThZXSXLNo1RzZ3SFT281E31EQPR3k=;
 b=CsCwc6mh8psFREm1sKoOidXZDpti8pDy2qM7eEILpEboVvUHukXCeWIkDRefgSJy2Z+iGvit22J9L2jrJm2hk7qZ8djhaXXQt7Ydk4yxtYS68yWiRrS2dkvyXbFxodWxd12SbeCUCUtYm7naUp+S9UlMmNn9zV3SivEIDvS0dL1TAA+E2bc7TUpFxsHMYmmjhznbW/A/91MSxcpQR9WtxUzZxFixCdN8qgpNPc1MVyDeK56E9mNjcPiWAe5Lyyabb492QFRj+xRqdlT3LiZBdQNriiIyCpxefUE4NmulySCCXkOK+jmglz05W7jRo4CW051WQLaxyr+qqzaLOrk08A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eVzjfwpjouHHWfThZXSXLNo1RzZ3SFT281E31EQPR3k=;
 b=BcruxG1VlU0rhh1Unf5u3ia3myyK0qdEmdILcwKOV+RoaJh2y7r1qKE6u8yAO+EjuwQ5bi8/oKcucrDFTaUVzs/TItLAxwx7ohNwQc+V6oildEGnvUTfBzpk7XgxssAm1C7qGvowM/dZTXCKvD7F3B92yJAscGAKZxPzZp5mUVg=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by IA3PR10MB8164.namprd10.prod.outlook.com (2603:10b6:208:514::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.13; Thu, 2 Jan
 2025 14:04:41 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%4]) with mapi id 15.20.8314.012; Thu, 2 Jan 2025
 14:04:41 +0000
From: John Garry <john.g.garry@oracle.com>
To: brauner@kernel.org, djwong@kernel.org, cem@kernel.org, dchinner@redhat.com,
        hch@lst.de, ritesh.list@gmail.com
Cc: linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, martin.petersen@oracle.com,
        John Garry <john.g.garry@oracle.com>
Subject: [PATCH v3 5/7] xfs: Switch atomic write size check in xfs_file_write_iter()
Date: Thu,  2 Jan 2025 14:04:09 +0000
Message-Id: <20250102140411.14617-6-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20250102140411.14617-1-john.g.garry@oracle.com>
References: <20250102140411.14617-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN0P222CA0020.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:208:531::23) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|IA3PR10MB8164:EE_
X-MS-Office365-Filtering-Correlation-Id: f21bdaba-c56c-46e7-139c-08dd2b366716
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?t2S/Ml0JrWLAo4JYXpEv/eRIeG7A0KwDkCdplqyMfIk7eZ8Jx1Ba+RXvpoTH?=
 =?us-ascii?Q?+XLQcCWbHh7/SLo2aHTItoqGmSCUixhvNOB+21yxWjXACzkd9Di3rwkJ7/rA?=
 =?us-ascii?Q?s6kDBdgrrsF21btFmHYLGIkwebqvM41qlh1v7aiDA5zZ0XmAU5N9I9ZjtInS?=
 =?us-ascii?Q?+iZQk4U60b97s2qcaprv/qz+omi/BjBSd1UMbwyZZsUDjO2LG9waHgW53VTP?=
 =?us-ascii?Q?FQ2A01gepWzRVoix1j3QfH7OXjJlQYGOBptZwZPYekfYp4sLjrAuB+dj2rd3?=
 =?us-ascii?Q?s0G49q+DFH+RgxCJzXgIHIXqFuemKA4m88hbN9zKPqIMhxQNUwyiAgqX08TQ?=
 =?us-ascii?Q?bIfHNeXM8IY5K007rmlONDKzC+gugBsvQaUnuUjRVQvkiZNnT2pZHc7QWwtU?=
 =?us-ascii?Q?967lfrOJCzI3jdjcrSrWXXmKK8E0DWY0fo3reFBMKTUHyXSQRvi4ZNTH6py9?=
 =?us-ascii?Q?T67TSW/TYJPcKr0JDhJgqrWppQgV16jwG0M5AA+hdVqFEDQ0aJlqoR3cntBJ?=
 =?us-ascii?Q?Vou0FiumXwp9PA32OL6dQzMAjMrkbW11pXnc/4/fxPre0qoeg0D4qlIKTi1d?=
 =?us-ascii?Q?5L2C90gwIlsXPCo1UInRHQd1HWodci1tMWLm23OMIHGC65RDBeoBq7QzrFbY?=
 =?us-ascii?Q?MCcVR5n4VYOr2iKcT7MuEkNWF1fHeb78zduGcLEIKCCqM/gbl3yCQ+uiq2B1?=
 =?us-ascii?Q?a89HUUzHYIAfs5IL/6qfdVOa3F5Nz3VG086OnhZfhc5sOPyXfujpGib6fblk?=
 =?us-ascii?Q?AnkQ7BZU1vrka1KLK1pXm/vsKGkcbgc/+xz1IUZYGJgBjjwiNgXOrI58aCJ9?=
 =?us-ascii?Q?485zjuNn8SqETEIc2kVh8iZzKQUBbLhGtZEKqg9j9FNBMsCdVNZzL5XXhBr/?=
 =?us-ascii?Q?wSkNm3zHb0CtjPYS7p5t9bKGRKYgm9HyVSzD+G+5ztgZU/4iXbGuMbNAwg3I?=
 =?us-ascii?Q?g6D2QwHjj7UDZMLJ0QRH21wvoVFts7skTI96Cs/KUhg4SMBAcJ6GDresdMqw?=
 =?us-ascii?Q?zvAoK9CkVK9wd+ubpo3W6QFamfUt//Mom4FcRICcwz2wNAudDfC0kOY9+LPw?=
 =?us-ascii?Q?o2SReOCJEqH9Loh4NSZR7z4AtVHYNjk/lpbPID3XmTN4224iOS2pW/ljI5xy?=
 =?us-ascii?Q?oy7X5Nqc2jGVNMnUf1AKPRkbTPHblvgEf+ObapUsPFAUxcQ+Wmomus6PwEes?=
 =?us-ascii?Q?EiwNNwHpiFMNxupBokjhNWmR/hmQ7XxRctoskE4wKWzOhgbSZPxLIRd41ssV?=
 =?us-ascii?Q?FbdPKWAkHg0Mb7S+1wjMteTeNxsA95BC1Aqff8VaPwS7lQ1Mmia4vuJvvZGy?=
 =?us-ascii?Q?xGMqLWa9GoVYYkXF6fR9OE1qfXAY5YgQFH0Wiu5Zwt6tN+ZZYvibsJLKQOMv?=
 =?us-ascii?Q?qi5mEDdWexceiH/ntNDErmzcaEhM?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ofnVEC+lwdn4FLFrcZv8FKA9ONq7hVBpAofbYMes2yaEFkq1pW9ROv0Qh5NM?=
 =?us-ascii?Q?u4Br4QitZXaMAYbIrWdy3AmQ8TAS4XLVfIvh3BcU2P7JYU52QCSJowtcO2eY?=
 =?us-ascii?Q?solTHzXReoNoj2NVQMS1cjB+97p00ihWz25/c1JUrwyh/Sus4UTTGhtY/TYw?=
 =?us-ascii?Q?WxaXoZ9gTG8LV2EjGPkN4SoxlAG92G+eVo6ZnqYw2znvesm9e7iyh71XLXg0?=
 =?us-ascii?Q?x/nRfMySpuPvYxcWkuofRKG9LhdjMft9Kig4U/K+sCvi18Th/p0/XlJXmVHW?=
 =?us-ascii?Q?AjnCdnrMGgpmw2YxIM/4q5aDhlbkvXFF7qq/woEcjcnP05SExJA65bXQKWlG?=
 =?us-ascii?Q?3l73ngUDmFMm6DcitxQcpvnq91pHCwix4zD/5tU2Mo5fe0DrVmih+8JXC4FB?=
 =?us-ascii?Q?/E9AD0vpB+DXdmjb3/kU1VVWslxjhsH3VTISX2JMYfur9/MAnKfP1J0EmarH?=
 =?us-ascii?Q?Al60e6trk2QgX3srXlogGymuirb/WKpw5OZAi+ww0DSKFf+qoutTXoWBuZQI?=
 =?us-ascii?Q?iEXNdNBPEi4V/+th5bHEqTa6LYhgMaKm/38mKR5mBjSK2fLjbfcl7dne95jO?=
 =?us-ascii?Q?6TFwVbRaXVv+HWzWoNBHRzJxMbT7HMFk0N4NvM2DdDhOxbxIPZAgR2Jk+46D?=
 =?us-ascii?Q?jC/x7C2Mi6u416FmTTB/gerp6qQgke431SBF0NSDBruB1kduJ062b+oAihtq?=
 =?us-ascii?Q?qkrvdebTB+bNehPsyMtzGv9ZfUVHNqLFT9KIzV2GeF4I1rRBALRCFo44Q6WV?=
 =?us-ascii?Q?84COrXDoaOZT+stExaOQ41x10alResNYDcGq+iAnySAA3bxdcmHE1ajjyMTO?=
 =?us-ascii?Q?gBH7IB9D5Ha7hywiN+io3ImoqgGjUlC7lEZDB9X4Oxkqcpnu4+U0cmfHvE5R?=
 =?us-ascii?Q?1PgK6T1cEgWyiQ9+exepv3erKvmpT3Dj7RRxwkKI0mHFMWXvS5qtrPU3ocf/?=
 =?us-ascii?Q?PvRmCcmEjFcbGmDM8pN2cDydkiGBQXk16LaooFnkC8LYBZ6yaSuLZKTZ+qQk?=
 =?us-ascii?Q?ZeQYFvP6YwdVp/ecnZLhhpFsB6KWmGW781vxbRxh0Px6QGJZhRBobjpDtAfs?=
 =?us-ascii?Q?1p415zx0bdW9nf1qsOegN46bkcCndDZxeFjnfQaImp3SdeqtE+rr5kZqc1Il?=
 =?us-ascii?Q?4s37CsZJjhB9K8sKB8qpa5KC8IZumY7dNb5OraxFde1chiEz0lS8XqE3ZsFB?=
 =?us-ascii?Q?QkX238m8lDj/2Mnems1Vruhcl2Pn1l5cN409IvXeEtmLpQkFLVu5DtI6hWkl?=
 =?us-ascii?Q?cGVmxc+KOJDrz+qgD9A0XrUrcc9HOmlxkjLKilcnYKXn6XxN0ZYw17OP+9cX?=
 =?us-ascii?Q?u9AbP1uI2I+r1loFE3H02/x42bWbKR+H5oZH+2O9fAaHyBAwuzm+J6Gys6VS?=
 =?us-ascii?Q?vWzmhW2qgs7ajFNTCXYRfzl+FK4JTBV4QlKUhtQi2O1KOcq0a04sa5hV0v3h?=
 =?us-ascii?Q?6Ri55XoSpkpDYj35V5+SYFVSkfPJfgsWnshND9xZQt+7A+l5cX3GGxdWwLr9?=
 =?us-ascii?Q?82y5/GnWk22FWWpcvmOpriTPSGe6EsNOMNsduTEhxz0jupFjdlac2dW26Kn0?=
 =?us-ascii?Q?8CvAxa43Uc/i8Cl77G0vlpbhf2Lme3uVSeiadNverg4Dl2nfJX8ylM5vMOQM?=
 =?us-ascii?Q?Gw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	AtafuAwquR+Fplx1H5dwfT5hIt/H4SPujg1xQs/1QLEVhTp00QFbZ8+je8KJ6vUU2PO7DwB/gNOjXAE9yl/2tgVkLhZcWAa0koBBRzPDqApOuRCtTan7hqrdBSENXjfTWKlo9Ga1PKCvqOBfI9jJA6QHeyznIxU7t95cCxDfwpJYDuRt61fTUnXmgNxJMgEDJIigf5m9Nax7vCkLkr4OXhDQEMh8N6FUAGG1/XZM+FqFy9WFCWokrUQ/FCq/RJadWjQGxoApje6XbiYXSba6wnoZVVJ2FOwelBEVmhgk/2M/FBtqAem5Tr3zQ+R72vmcp1gwBM+1izOFX5DLIDDDvRxBBCSlFWgB48vRSuW0cLGxir12KWlBIWZb/7sfFWtQSyaVlEWFYa+Fxvm58CBDpa4/YY2gaOnZ49Ib3KcNFDk2cocroICi7wbjQg6AoCJh/srAPsgypafBaflsoCgm082FcR2cVGjBwREqhso7yXXX7EkOVvROaHwelpBMS7/x2XFXOT6qNOVo3GiNyFiGgZ/VX2jiFfTM+Q3DFnNe0fXCItBLgU4A5+M9uJ18n/G1XckVjxO2mumm2dXVBa95DfH9fK8AhcZAY7KqBlUfmS8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f21bdaba-c56c-46e7-139c-08dd2b366716
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jan 2025 14:04:41.5682
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9Mfz6pjwyx/8QtkdiFAvNJ40gQFagLmXltiZdl3Ne+MbmddGugxfNESskRjUx0s30YwU72fQwUrZl19EM6QmfQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR10MB8164
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-02_03,2025-01-02_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0 suspectscore=0
 mlxlogscore=999 phishscore=0 spamscore=0 mlxscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2501020123
X-Proofpoint-GUID: EaPrGF7yKnf_y66899c3gYk3Cor3cvv8
X-Proofpoint-ORIG-GUID: EaPrGF7yKnf_y66899c3gYk3Cor3cvv8

Currently atomic writes size permitted is fixed at the blocksize.

To start to remove this restriction, use xfs_get_atomic_write_attr() to
find the per-inode atomic write limits and check according to that.

Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 fs/xfs/xfs_file.c | 12 +++++-------
 fs/xfs/xfs_iops.c |  2 +-
 fs/xfs/xfs_iops.h |  2 ++
 3 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
index 2c810f75dbbd..68c22c0ab235 100644
--- a/fs/xfs/xfs_file.c
+++ b/fs/xfs/xfs_file.c
@@ -949,14 +949,12 @@ xfs_file_write_iter(
 		return xfs_file_dax_write(iocb, from);
 
 	if (iocb->ki_flags & IOCB_ATOMIC) {
-		/*
-		 * Currently only atomic writing of a single FS block is
-		 * supported. It would be possible to atomic write smaller than
-		 * a FS block, but there is no requirement to support this.
-		 * Note that iomap also does not support this yet.
-		 */
-		if (ocount != ip->i_mount->m_sb.sb_blocksize)
+		unsigned int unit_min, unit_max;
+
+		xfs_get_atomic_write_attr(ip, &unit_min, &unit_max);
+		if (ocount < unit_min || ocount > unit_max)
 			return -EINVAL;
+
 		ret = generic_atomic_write_valid(iocb, from);
 		if (ret)
 			return ret;
diff --git a/fs/xfs/xfs_iops.c b/fs/xfs/xfs_iops.c
index 207e0dadffc3..883ec45ae708 100644
--- a/fs/xfs/xfs_iops.c
+++ b/fs/xfs/xfs_iops.c
@@ -572,7 +572,7 @@ xfs_stat_blksize(
 	return max_t(uint32_t, PAGE_SIZE, mp->m_sb.sb_blocksize);
 }
 
-static void
+void
 xfs_get_atomic_write_attr(
 	struct xfs_inode	*ip,
 	unsigned int		*unit_min,
diff --git a/fs/xfs/xfs_iops.h b/fs/xfs/xfs_iops.h
index 3c1a2605ffd2..82d3ffbf7024 100644
--- a/fs/xfs/xfs_iops.h
+++ b/fs/xfs/xfs_iops.h
@@ -19,5 +19,7 @@ int xfs_inode_init_security(struct inode *inode, struct inode *dir,
 extern void xfs_setup_inode(struct xfs_inode *ip);
 extern void xfs_setup_iops(struct xfs_inode *ip);
 extern void xfs_diflags_to_iflags(struct xfs_inode *ip, bool init);
+extern void xfs_get_atomic_write_attr(struct xfs_inode	*ip,
+		unsigned int *unit_min, unsigned int *unit_max);
 
 #endif /* __XFS_IOPS_H__ */
-- 
2.31.1



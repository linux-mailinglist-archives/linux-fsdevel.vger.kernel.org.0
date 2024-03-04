Return-Path: <linux-fsdevel+bounces-13461-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DEBD2870221
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Mar 2024 14:07:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9153B2833DB
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Mar 2024 13:07:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2C2D44C84;
	Mon,  4 Mar 2024 13:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="o1m73hIs";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="KsGZsrVi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EEEE40876;
	Mon,  4 Mar 2024 13:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709557533; cv=fail; b=LpZcOae3JScLl+iDu9iImpdW0ZQigo2SxaoWZ38NkshHF7JHUuPYC6JMn8loZX4Fd7cyJV1kPw8xzOO+UHWuhmWRovmQrWJ3X+qaldXZvMSjFUs+TdysvqTxlQz44nY00AQ2JiHocHdVp2id2EMZmSSBB00hMeGDPcSU6hBkkcY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709557533; c=relaxed/simple;
	bh=Ca+14OJOwwMIJRrzCTAz8rKt9vAQYCBDw96h0gnZYpc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=l3u0/du72vSJjANl3zgH442rlFW/JvoN7ZtCUUv8mOaQoR0cybkPgyqOtPmlaJ4Jro9DnkUMDOZOfso7nAZrOuqzSpaz+QBNcPNVO6NBC5ltq3tIDTIOTRHq5snEwHxq0EZviMD3onupoNaC3f1X/KmUBIVLV2bu4WGxGaYWzwk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=o1m73hIs; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=KsGZsrVi; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 424BTd9l013715;
	Mon, 4 Mar 2024 13:05:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-11-20; bh=WxFhCRvre+2cNUIUmaDBgWrH2k8gt2kohTU0lgHQQUs=;
 b=o1m73hIsWHhqwr3CfeLUhKD/KVOA1nPCQY2l75LCYwG4Ko0pDLj8xAcF2GHT4t2h1kL0
 q6G8GQqIM15fD0GfZ+UK41/6nWum+HQe6SXBPuSxytTlbStgbvcERzEySMJGwsbvFR3z
 xo3ct6V7DjbZeGJMMK3JQHh5GGSnsYzEeA/carguG+3is1LMnekpw0CzRCTTgHlGs+rq
 3+N947gt7VvSKeYvv9y4VVNFRfQx4xucTYfXCwcftt8ZAlkbArCJfFv1OY/DmRUEp7tu
 /wh6ccGrpEErzjumvVzG3wULAUCYki1SPyPka5JoEMtyWHV7K5NUc+25npnT48sfleBn sQ== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wkv0bbewm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 04 Mar 2024 13:05:13 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 424Ci79a017169;
	Mon, 4 Mar 2024 13:05:12 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3wktj5qp7s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 04 Mar 2024 13:05:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mP72Y+Lk69JsPa8tYW2UynC3zne3K4c6xbfiRo0LfYXDdv8RvTykD90JmBjQ//CZfDg03JLoj5Qc97DCuTZZ7DXr9jv5uantZrQOWktZA8BX29syEu0ktdyEpj1jlRDS1tVs7v/LppANTKoP+WpLPsYsL3ft5rNrOZLrpCELinEhbdKhrpahSYAHtXGMbhY9Wc4tFewqC5O1Q8yidJHh5y6IM1W/Mx4Rc4YxT7X510SCpoB6ixO5kmFxht08jfvOm3Gv2SqL2h+IxkY3MA3d32zQwzy7578pJflEVyjosugpHcC76HXl9X+Vloc50s4QIoqrjbxPCOecHqliYt1X3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WxFhCRvre+2cNUIUmaDBgWrH2k8gt2kohTU0lgHQQUs=;
 b=AbnB2USUlkJtW/3A0AsQeZy1ZKSsZezw9XeFKY24/PYVUAtFwfvAgS4fgda5hll2uu/zuO6ZBXExIKVIZB8fO9bB2JoooCfUSfX+c/RqNbXizgdwsyf5eClsgq1H30yihxagKfcQ6Y534HYWC694rOEH/2zRC9xyYGTzUGlhSRpJ7KN5HJb0wswHHctwVukYup+H+pJrOuj+0HCE6RJobJ4dg97i4xAh2cEgrtOYKMj+5M9/ziEpvEG3eVIWupTBt6K114xDCvxokFjTksKxHRQd3WDg+TUIQx56/6WqWSxDsvxMK01VEYbvVf0Zfn5TXAdtns9D0FFTCJBhmDUYQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WxFhCRvre+2cNUIUmaDBgWrH2k8gt2kohTU0lgHQQUs=;
 b=KsGZsrVin/vxXKGJrDoIYvKE11YvBADMZ8rNYivflx5DeGtmUY1UDjywpZQ2pyErQ5WVrTHLJ+rpl/T54vjh4tOaBwndgfNAb9+4Xdtn4APh1O+/IPXjqdC4Sw/Iip7Vvz23WvTTstPSjP9B1RBWQf8xjwzBEOeGx5k6YJA+4Tg=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by CH3PR10MB7805.namprd10.prod.outlook.com (2603:10b6:610:1bc::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.39; Mon, 4 Mar
 2024 13:05:10 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::97a0:a2a2:315e:7aff]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::97a0:a2a2:315e:7aff%4]) with mapi id 15.20.7339.035; Mon, 4 Mar 2024
 13:05:10 +0000
From: John Garry <john.g.garry@oracle.com>
To: djwong@kernel.org, hch@lst.de, viro@zeniv.linux.org.uk, brauner@kernel.org,
        jack@suse.cz, chandan.babu@oracle.com, david@fromorbit.com,
        axboe@kernel.dk
Cc: martin.petersen@oracle.com, linux-kernel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        tytso@mit.edu, jbongio@google.com, ojaswin@linux.ibm.com,
        ritesh.list@gmail.com, linux-block@vger.kernel.org,
        John Garry <john.g.garry@oracle.com>
Subject: [PATCH v2 06/14] fs: xfs: Do not free EOF blocks for forcealign
Date: Mon,  4 Mar 2024 13:04:20 +0000
Message-Id: <20240304130428.13026-7-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20240304130428.13026-1-john.g.garry@oracle.com>
References: <20240304130428.13026-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ2PR07CA0021.namprd07.prod.outlook.com
 (2603:10b6:a03:505::23) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|CH3PR10MB7805:EE_
X-MS-Office365-Filtering-Correlation-Id: e1e2e536-adfd-4b23-4956-08dc3c4bb90c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	7m6xWKHQ2NmJRocbAZezYN2imVqFPoynITOkx35RMEmhsg4KaU+2LlOXw/UelQkjVIUovPU8TPvvunZyzzSj9/Sgf9YRckk2XhIeZY1a46qfm02i+BmnFcw9lK6Y8lQDfwmso4BUM+KJ58yg6+yQ0lSjFROHx7Bk6MMU1MQpVrnfIQz70nP7AzXIFizrhhY9VXnwKgAvT7QS4kpgykuulOl+0UTEk6JITwdIP1mOSlbGNhwGAmk3PkWa9E0p9+A3GfCIuFr2f+GZm7IXOCUE2g6pbsMInVR3g3jZkefXV+692FMErM1fHSglUBWwEJi+w7wMcCC1aNCH4CiWaYpyfHXpqgVAzoRTepE5II2ilmHEWtKoirfzuMd7ZM62hp17+8B2sjzkQVZ2UWlbSsQsZpBZzU6KBF1VWbuWq8dppch+ZiIjL8lD4WziVu//k+G/caKVPYku8ollpzwbRYfHimfq9SLToeLZKnIFMvFxVhxv/PrIRAxo7OMiqObGfXm5i52H4tCDETQXw/RdiYj/936V2uVnb2/hWSRIjboAZeSDdvw/HgL6FfeUisvN2HqcWnzIG9Ae3exwtWJ4zsIXyo+IBvVhZS0bPx0QvRzrbcJj9pA19o242cUUE+zV/+c7y8n8sESCX7kAtmiV6zqvLJV0yUY5lYwj7WlCuL1ce+Y=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?lIcipiJVbXttzZAystilUFrU+lB2aTaIJVC3UgPCWGObrIMx01y+E5R8sNx/?=
 =?us-ascii?Q?XhbjCTGx9vvI3jKJKokXbBDFYwamm+bCja3AWHD3cWr9We0dBYCQaDwdMCnX?=
 =?us-ascii?Q?ebjJEkLDY53bkb7iW7Hz7mCJXKERsvt721/e3GhrO40X29e0nW4S9RtdoaKi?=
 =?us-ascii?Q?28ug6riGVXbfOP7im4FEpOSA3dkHSHQQd+tICethvvSrhDa3EcpT7ZeL/wte?=
 =?us-ascii?Q?vbcOSMcTzJNHvLADzDl+a9uvhOOQHlD1PbKlftOz4T1EYWsqH5Ptnggt5ZBR?=
 =?us-ascii?Q?stEhxum6YqHcaZ2aq7KqR+MfWAk/h+18TrS15kCUJzW/FpCMxKd7EeONE9ee?=
 =?us-ascii?Q?vVHSz8qq5qshLRMkPgVElf+SzoePg2D0LlU2NhD6t7TJFS22zyGZ1IhMfbK3?=
 =?us-ascii?Q?hdxoRToNwOcpwggzejWvLPlVung0OHi0RuE2nO4Zk0rRH7vNiD6NCZ5wuG/B?=
 =?us-ascii?Q?wF7lA0deG9boamH0L80OMO+Mvh4r0wD4zM++bahOSCZ2HEkpRNV2HCL0myp4?=
 =?us-ascii?Q?tgVj4TJhzT97lEIchxdIK55UTjNhj7rivsdnSEJwTbQgXkzlwzK2VSoo+cjl?=
 =?us-ascii?Q?1IVmkk5ooPe7u51vxqpt2qIeSWfVPpvxUGbDwtgJ5R9EsAF6CFJImO6tuZv1?=
 =?us-ascii?Q?cI0CNkXS1nkwMohaY9aXPDlnLRBqiZMyesA3smjQl3HetIqQlpyq3lcjd5nO?=
 =?us-ascii?Q?hYcaupJqr7Z4TNgKWbhfPE1hxzM6koeVaZRidSO+FyyT3b9eu2ME1CcgZY33?=
 =?us-ascii?Q?yLjLPw+UklD3zlsHeMtrOVJISqbXxaW1YHlo2xMVH/JX/qeV+7vHQHnRxVEx?=
 =?us-ascii?Q?yeqxSDJzSn6NKMIUTO+LI+s3IQFT6Qv9x1/z+ilA+SmT+wIYydzK7JLA8ZNO?=
 =?us-ascii?Q?aPloAXhQ7RkF/EuiDIfnCR3QsbHStzSzcV+yePebYS5Q3m4oOHff56SPMBcP?=
 =?us-ascii?Q?FO1NzSGf/ist8Q3oKqIFT9QTdP4rqgqAx+ZmMY/boL8WKOt4LuAtT6iV6bbV?=
 =?us-ascii?Q?m4wqUvkunB7hEkFgKm0ovImwQ/OHyKYqk5Hran5MtJa4QU9YSNOI1+dUGuov?=
 =?us-ascii?Q?xSAwKvBI2Ad1bx6sKx5H1rwJLj9A4FB8+BTs9TG08rwvpL0cl9l2Q1v6m9Be?=
 =?us-ascii?Q?i5Fk3i4+vTSmxpsHZGIiAztZDwrQGhcBIs5CtQ+aFUdTkSxO5IYtSVe3hZDy?=
 =?us-ascii?Q?ZSTcrszcTwvtXK5rUR4XuvdyjZAp9vJzLOhWDkqoaQzg80ssHQEL2gZH9Cle?=
 =?us-ascii?Q?c+OXt3p7X4LusI2+5ma8AJTudeHayvVrDQUtKdjOkOealv/SbxqQU7/Z2due?=
 =?us-ascii?Q?odRjbyycrtGOMoRjS9XMSH14zq9cP9diHhos8Q2QtsQ4cA6bKCJggxfXcRSD?=
 =?us-ascii?Q?tymK76wlrqbH+qylOz2PlZl2qVoYTO34wwb22+1fg/QFlWTymZ2EsXWo2xbV?=
 =?us-ascii?Q?tmoRhZZnrE4LYWVhYdDajD4IC4tuHzuvciufyGaiiNh6eyq6m3LW/kpXz6QM?=
 =?us-ascii?Q?hGhln4jwUMAnZkIDcOb0UZps+bJXEL6xuO6VxYDMm1eZL8dnVXvHVOqoSZSd?=
 =?us-ascii?Q?mwhk/0c9oPm3VWvm+F+BIGrlTe1Kdu/klP13IXZry3msbGm6p4xp1NBQvqDh?=
 =?us-ascii?Q?Yg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	rP1xLx47tBYbhWhYww3bWHpW2LIA3zjB8tXbqejfuTRx1idpq5TBJpRidoL2EGRLqFDn+JQhRqe4WZneSG2lfIj7vL33tzDwdT0thlBXXMr927PvTLfwxVOUQ7G8VCdm+sP6+3IMy3R8e4heeJuNyTLB6mujacDHsl4Cpazmy+dEKCC6CxBG69EH6yTj9mdIBaTCzpGAkQQV1XngkVPBj8f5zoS1oYK/FhFP/smvGTHxX5jQTujBCeo+eWfLXWItaj1EdKCuyQb05Su1ZQZc31ZpbtLi4ebtWDoQmS6uBbyQb9dTAE36T0BLFD/zh45+B6NWvrtxmzlhfTscC6VzATpOg00yGJpTeckJASLhxzdkNr5K67UHf0xe4R0siAVMnfgHNDm7SGewX9cT66Oqi50jSCnDbUH9f90eq+eXhci5Xq9NVpI/wXu/ypEJItEzq2uHkdFiCJwRpbxLHXVlf4ENRqVgLfjByY8AAqPZ2OGnJyBmotSnsVE9g5q7Pd2LlP3oWS+WKVJNAeJePC5tbt4CgHLI6PQwoltizHB0a/4NJLbnJAfwXLXY8h4QEzP/MD7haA+VO79F0Mcly9Cfqud2HhXhePFjeIUcNKVxFyc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1e2e536-adfd-4b23-4956-08dc3c4bb90c
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2024 13:05:10.5534
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GIWQGqkmad7/C936cyeqhCjTXTA7i1XVgQoyXeVuL7y2OoH5YY9mt7kW4Ae6y9RG/LkBS60rxxuU5D1utBXmmw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7805
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-04_09,2024-03-04_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0 mlxscore=0
 spamscore=0 phishscore=0 suspectscore=0 malwarescore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2403040098
X-Proofpoint-ORIG-GUID: 5qEmw5wsRA9CknE5NjX9jPmM-nS4v_R5
X-Proofpoint-GUID: 5qEmw5wsRA9CknE5NjX9jPmM-nS4v_R5

For when forcealign is enabled, we want the EOF to be aligned as well, so
do not free EOF blocks.

Add helper function xfs_get_extsz() to get the guaranteed extent size
alignment for forcealign enabled. Since this code is only relevant to
forcealign and forcealign is not possible for RT yet, ignore RT.

Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 fs/xfs/xfs_bmap_util.c |  7 ++++++-
 fs/xfs/xfs_inode.c     | 14 ++++++++++++++
 fs/xfs/xfs_inode.h     |  1 +
 3 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/fs/xfs/xfs_bmap_util.c b/fs/xfs/xfs_bmap_util.c
index c2531c28905c..07bfb03c671a 100644
--- a/fs/xfs/xfs_bmap_util.c
+++ b/fs/xfs/xfs_bmap_util.c
@@ -542,8 +542,13 @@ xfs_can_free_eofblocks(
 	 * forever.
 	 */
 	end_fsb = XFS_B_TO_FSB(mp, (xfs_ufsize_t)XFS_ISIZE(ip));
-	if (XFS_IS_REALTIME_INODE(ip) && mp->m_sb.sb_rextsize > 1)
+
+	/* Do not free blocks when forcing extent sizes */
+	if (xfs_get_extsz(ip) > 1)
+		end_fsb = roundup_64(end_fsb, xfs_get_extsz(ip));
+	else if (XFS_IS_REALTIME_INODE(ip) && mp->m_sb.sb_rextsize > 1)
 		end_fsb = xfs_rtb_roundup_rtx(mp, end_fsb);
+
 	last_fsb = XFS_B_TO_FSB(mp, mp->m_super->s_maxbytes);
 	if (last_fsb <= end_fsb)
 		return false;
diff --git a/fs/xfs/xfs_inode.c b/fs/xfs/xfs_inode.c
index 2c439df8c47f..bbb8886f1d32 100644
--- a/fs/xfs/xfs_inode.c
+++ b/fs/xfs/xfs_inode.c
@@ -65,6 +65,20 @@ xfs_get_extsz_hint(
 	return 0;
 }
 
+/*
+ * Helper function to extract extent size. It will return a power-of-2,
+ * as forcealign requires this.
+ */
+xfs_extlen_t
+xfs_get_extsz(
+	struct xfs_inode	*ip)
+{
+	if (xfs_inode_forcealign(ip) && ip->i_extsize)
+		return ip->i_extsize;
+
+	return 1;
+}
+
 /*
  * Helper function to extract CoW extent size hint from inode.
  * Between the extent size hint and the CoW extent size hint, we
diff --git a/fs/xfs/xfs_inode.h b/fs/xfs/xfs_inode.h
index 82e2838f6d64..b6c42c27943e 100644
--- a/fs/xfs/xfs_inode.h
+++ b/fs/xfs/xfs_inode.h
@@ -547,6 +547,7 @@ void		xfs_lock_two_inodes(struct xfs_inode *ip0, uint ip0_mode,
 				struct xfs_inode *ip1, uint ip1_mode);
 
 xfs_extlen_t	xfs_get_extsz_hint(struct xfs_inode *ip);
+xfs_extlen_t	xfs_get_extsz(struct xfs_inode *ip);
 xfs_extlen_t	xfs_get_cowextsz_hint(struct xfs_inode *ip);
 
 int xfs_init_new_inode(struct mnt_idmap *idmap, struct xfs_trans *tp,
-- 
2.31.1



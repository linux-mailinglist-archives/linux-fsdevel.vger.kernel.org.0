Return-Path: <linux-fsdevel+bounces-13466-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 99F56870235
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Mar 2024 14:08:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BDC371C21A39
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Mar 2024 13:08:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3E42495FD;
	Mon,  4 Mar 2024 13:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Oupaye51";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="JCtr/d8c"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D30C040876;
	Mon,  4 Mar 2024 13:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709557550; cv=fail; b=TrHMEOEywnr0G9apTmjsB/EHeaRa8iS97PtAp0eBYsfjG0ov12M6YWrINP+T/T+iT5yPAn8TN+MetBR5OqAx/nyatzl87j10/A3plQBKG4Bm3sz9SA9bT+BqO4jT1GY3LYAQ2u2VSUTQ6dola0mj+0xzUy3PUqvYcr7irPsLgyo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709557550; c=relaxed/simple;
	bh=lYLobJ0MIuTtMdARP2KnNZVfpWyfaiPCypqfxE9xGfw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=d7ewmkxQMfiH1vP8E3F2foaxhOCZi5pqydut9qsqrGomX05aN4X+v48pvak/YFvEGl8FJAteE2U/HxV9aVAYo1BnLS7frjXIjAAxjWK61ZjtoNRm3FkFjPZuMsWMKNU69LvpcG7BgH/LBpfiI4tAemaRNRGXNSGBmArZ8Vw7fXg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Oupaye51; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=JCtr/d8c; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 424BTm1n027762;
	Mon, 4 Mar 2024 13:05:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-11-20; bh=Y9Wo9Yza8bnad1n1qNYTg8nNKyoC48u5aWvcAt5RRo0=;
 b=Oupaye51m91lyhUBun0gdw4bP2D7HyVQKEm+GHURFwhrxBqd0obf2WPtTa4nWmaf6ikT
 azQotYqFsPKIRiio+RYpNo+t1aBuCUCh0f4KiRA+SdJoWrlqDQ0tiIOEiKYXZDpZWvFv
 NP2Ml8YCxELXW8uhpDS7gkxcoAkKHteg7ErmY/QlLCOUjJJt8IdLyPk88+Xq5XcMwJi9
 SM9unOEVUaG27shdQp/RVVSnwSQ0gp5qooHvB+KhMyG3Pl3MDpmGloplRi+j3p3NwBOg
 CbMwrXL5++rpVl7dQHkyColyExtPmm2A89BVkJrBDnbV2pxDVQKjuO5zi3vYOmGcCDYd 5Q== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wktq23hn1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 04 Mar 2024 13:05:26 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 424Co7Yf033255;
	Mon, 4 Mar 2024 13:05:25 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3wktj63tqw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 04 Mar 2024 13:05:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mlm4yn4K+KmJniU1BXYUItOePqPwDzuj/GsZWXkNkv0zyBRR+vQ6fEJPGR9dRtWEASJl7X2tKETOhMakegnjT/X1/pCpGKTw7YPLk2skmCBOEn1mJlk+XF8be4u1G6vHVYGakZj1STCBy+H8KIJf8XcLhKJ1iuS5Z0ToBCD+tZOlUS+QqKB/pAVUE8z5enfEFKQVHU6gGLah2QnGin9YekNQYP0ecYp4SWknclV07PIlupdC2Z9NXG/dGB3IIWVbq27XNzRXg8RtJ8Gbpnnk3ureTX+7/ClvACEns3qUQi+HaZ938jLy+36mRY3elvii1nVAw2oxT3Ll224pie+CZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y9Wo9Yza8bnad1n1qNYTg8nNKyoC48u5aWvcAt5RRo0=;
 b=CBBJzQ2Iupjk4ndLVcrjK/jiol/okMv0mILnELm/QrYKusKzYPEG1PInFGyawcAYnT6raiRyhFd3A4WpnsJ/l68JODixmtnVIs5Z2juZJmTzpnjQ1cAwU6rYp46GWARNUA/L0rc2Xtu6cUBl7oYcKLAelR2sT0R0Jq7NnJo/hfI9QTYsks8ibMjmZz/wDO2WhVuLVP+ZsvXlcD5+8c750/IuF+KLOTB2o0NmNJgMyirxKzenOXU4/WJqioTZCNPHdfenb5eq/mLCvf6oxzF49ERqc+1gZJf4nC6osIZp0aQhBJu8uo9hhZdQ4UkkK7S6J+7ffYjMI3BNRXVc5FXaNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y9Wo9Yza8bnad1n1qNYTg8nNKyoC48u5aWvcAt5RRo0=;
 b=JCtr/d8chmValTnUQHm/UVlK5pesOOFmS/3sSkuoyi+IZvoF1J0Q/MLT7y9MpAqadiiBwnYktGUdHD2MJbWB9/Yzfq3QrbJgcJjDDxC/CtOMYygamVAkGhyWDHkcBQLXks9AM5UNn2GyY646ZNUGK9xY4o0M2waiUVf+Tggk36o=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by CH3PR10MB6860.namprd10.prod.outlook.com (2603:10b6:610:14d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.38; Mon, 4 Mar
 2024 13:05:23 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::97a0:a2a2:315e:7aff]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::97a0:a2a2:315e:7aff%4]) with mapi id 15.20.7339.035; Mon, 4 Mar 2024
 13:05:23 +0000
From: John Garry <john.g.garry@oracle.com>
To: djwong@kernel.org, hch@lst.de, viro@zeniv.linux.org.uk, brauner@kernel.org,
        jack@suse.cz, chandan.babu@oracle.com, david@fromorbit.com,
        axboe@kernel.dk
Cc: martin.petersen@oracle.com, linux-kernel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        tytso@mit.edu, jbongio@google.com, ojaswin@linux.ibm.com,
        ritesh.list@gmail.com, linux-block@vger.kernel.org,
        John Garry <john.g.garry@oracle.com>
Subject: [PATCH v2 12/14] fs: xfs: Support atomic write for statx
Date: Mon,  4 Mar 2024 13:04:26 +0000
Message-Id: <20240304130428.13026-13-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20240304130428.13026-1-john.g.garry@oracle.com>
References: <20240304130428.13026-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0191.namprd03.prod.outlook.com
 (2603:10b6:a03:2ef::16) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|CH3PR10MB6860:EE_
X-MS-Office365-Filtering-Correlation-Id: 212e7776-e5c5-4cf3-00cc-08dc3c4bc082
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	sf8nsuokU6CludR1Iup44bOBLyFehi4rqUx1IEkzDYj41MTSY2pv+aU2vEj1bLj04VNvfMC76643TEHlnSglus5QdVLFcovlBjXkgwO+0Q01CIFk1TYBhmXzoFtq4eKMHq2lOHWFS33NG3Voo4Y5YwjweM8a8CMFUDjfRohdXBJfCzJhQN8xkojBjs9FlilbvSE+J3e8sWgfDmZF9EpEndj5gVuvRP/qskaYPa3dWzuR4xfpOMVJSJ8mWaFICcYmsMJB9Bxx35MIxIOrY6PP1atjYMi1IAcvhIJn7QWsPObK7CPVBKrNegQ9ZQflb5IkIR3SAUGrnPIdwZZfgeoPG2oY0DIhD1Syrq6tIIIFKKYur+TJSb6M9MOxs6oIRuZQ4BiHaWQP5seoVP5hAh57OL2h4hQy797ZYwSiDthQput0IHbMKVLfjQQWaD3LVNOILQnt8Z98aFDGfHdMJCYtWk6hzD3RD3TWpG/Fxx7k/0WjP1qD3FPJi9887YKaqW0aZ0iaTpW1YxU+Bar3rM5YKaMAkQOLUGbD7vLvuBNSRX/oCqjAZy4t9dsltS/J9zZmw2MeBFhMcGovOQUMbrhCFmEY4GJ4sk4tFtMvpGFVrcOXUILAuYuFEtBoyuNgva9qQg2q5S9FNpWCKykzdLS4jgtklpXkG2PKAORv74Ioea0=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?tLru9ud7ntP31SKZ3KIfMOAuib3DobDG4N+Y8hO3qwpTUTUe6/+DdEwOPFTb?=
 =?us-ascii?Q?LYzbnpiTQmh9WT+N4WDykySbaV+shd17UEp2r/aSL2pUg6hKF7NF5J4z1hvY?=
 =?us-ascii?Q?h87QHPdTZpizf7BLNpjSvA0HPuPeKUU0teFR6r3I2FGbuMJsAz2U3UrfFjKX?=
 =?us-ascii?Q?JzkUeNLVUDh/Ke8PCmWoANIGLYLiWYUhjo0DGtEco14b4AoFFLbtNb5ztGKk?=
 =?us-ascii?Q?XM1OnEvvP5q7ItdQwNRMxMLAvUNbEDL8zdkaPrrJzqLzFDmontBzfJvcXYY1?=
 =?us-ascii?Q?HqaWJKwYmYmv9py9BME6y1SJGkW+L1J8AUcZy4iEOGCVRrCsM6XvEfP4zmsm?=
 =?us-ascii?Q?OujBIT+UZame0vvZTF6erFedIxWuf01wigtuDC2rx5wV1gX+qsSZNu1NHKq1?=
 =?us-ascii?Q?Jh+M5ZKdicLhfQ2oqqarQvusECMyfWJLWGebymNKYWR9fvBrMvFmmAh+pdDB?=
 =?us-ascii?Q?sw4YAlLX1C/af+Qb2ANPFju0KI54VEiLDYZpObgifuRKODX4m1uA89YJXZBP?=
 =?us-ascii?Q?jUZKqUStj//Fowe05V+htUO0LSIntzPY5egXbWHI0s0AjzTLml7YyDDL8Kuk?=
 =?us-ascii?Q?7PxHSWW8Xa/XlHXjWriPzyTkun/1sPwzTi9acudkpILfwvk4/1oH4rnXRsAZ?=
 =?us-ascii?Q?qLxz/AzjycjECip0k9m8dRvzyYHOJdy/zwqCpW1fC+r4fmcaB0olqx5VQc/0?=
 =?us-ascii?Q?SNhUvaU1sjunvgWJfzA049ZXBUb/rS0jgeKqImPTzAPMkH8eE2HuZWFDk+JC?=
 =?us-ascii?Q?DnPgnQ1vlAI3OvluhknJSaY4ubEvxmsQawgyJR9+DEflqMpW1PRh7V6dTmWM?=
 =?us-ascii?Q?GhbqzU3M/mXVzVSk174pOlN8YYDmAxqHq8wRAVe0ayDiAfZYFvXmVdHAOHiF?=
 =?us-ascii?Q?kkHotfMX8q3IuKGYFa8SZRCSqYEuRnG1iEJJRrqxfqdJkBnBa9Y2on2hjp+W?=
 =?us-ascii?Q?NWW6HBBklvOc+LkLFW7VanxkMt1e1qZqM8Ze2p5Vxw3mGcoJubes4BRmRme2?=
 =?us-ascii?Q?0qsx9Om6Espp2oFmUTueTNTZCSfWFBWT7b3Kwc1ISkT9JflgaO4t8kE1D6cj?=
 =?us-ascii?Q?mh6CK7QHZc001ZEPToCdbmu7N6IoULfMOYWuVET0Gkr/667VjeWv/0/Skft2?=
 =?us-ascii?Q?0NA0/os1l+Z/CKAfesWgMqQjNj298M0iJJBIqCCq/flRofg4CH3WNQy/WQRp?=
 =?us-ascii?Q?GdxpnyJZexv1vbHlegGh0jFNi3/O03CWk9MRmUWaAmhAdbL+7T7oAxlAqPd2?=
 =?us-ascii?Q?bYjifGk0axylT+6HsAl3Qp5bKMH4sW1ZbvRu0eNSOFp6psFKdQowuMlWkUli?=
 =?us-ascii?Q?qvZ6hM4VfvrMPeWqYCgf3TVTh/fpgpIsRBvxC+AKjGFL/BrHTkVBtGZBNBqa?=
 =?us-ascii?Q?zsBX1NBdC1xXo9oiUx09a9ywUAEnl/dI/1By4XloXr8Ptsafkkbym8+uOdwY?=
 =?us-ascii?Q?Ahgj14+vtOv8zPTFgLyVdME7TS+0yvEfXuo+auSZC/FQHRmBhl2MlB9OLTmJ?=
 =?us-ascii?Q?XKie0p4COcQ8oVtNxbQR2lGsxgwzyF5P6BKKQK5eWsCdAxn+710JxzC93Y1U?=
 =?us-ascii?Q?zMxJnJqbyT0rCmM2Vqc05wD9H/efwJ/gmrsYFBTpsJR9MfD2UI+KOCPy+fPP?=
 =?us-ascii?Q?kA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	s3c7shmyA/wxLSL1jzP/iQa7zA115yMC3kHvs9SQuhvxgijLf4XdKTHXH42/NhzsNAnBCVjEi87aqMUicJ9zq7deCwuWBFBhj+c4a5nMa509jLuv8c3iS4rYiaN3wCZrT39wqQH2I1kgmD9u1tXwB78kcx5zLvUcsB0JubaURJiGfE4NSkf1EpZalPk2eqLAH6n6QjjDZ4p8NEZqWgUjqAc89Nz2ZQbqan6S+EW6zAy1oPWq5xRIEEqXZJlul1a0sFGGshkFqzcrFwQWzVFnrpbVeZ1LxpIoeFAnZtb/pLb6jKsT4VVqqmPfQmUgpmSkHx0iW3Hn9WBassI9a/zUHuupqHfsPkzxv0XZoynn5gDs+E5HATgaUnHkgJeyEX0+ocIgAZENv2nHyKexrQjgF02lPEESOOMDJKySeAiOqDkelNEvFR/NmzetH8iknmC443nxZY7wc3dRIluuHaE0nvPPlMzjYaOa4HiSXqqyAolEDdBP72c17On+FgcVZRfFLKEeiW3KBd9W235KJGKK+5QIWsJjwxZ4cfhb1bqd0thJu5jteU9v14o0osu5uRwbSHiLGurJYBVE23NtkTCCkEjPG6msBDLN5F1PePWpImk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 212e7776-e5c5-4cf3-00cc-08dc3c4bc082
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2024 13:05:23.0921
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w7sb4EoaOocLYp4ERGBVWct32PTuTFPaRaRsmHARIfx5UomQR12q5uEqehVtM6bHeoLNW3VC1wnXfUaJjKqYhw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB6860
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-04_09,2024-03-04_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999
 suspectscore=0 adultscore=0 bulkscore=0 malwarescore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2403040098
X-Proofpoint-GUID: 2o3Jqdu9fm3IFtY5nYK_o1lUI64ZPMC9
X-Proofpoint-ORIG-GUID: 2o3Jqdu9fm3IFtY5nYK_o1lUI64ZPMC9

Support providing info on atomic write unit min and max for an inode.

For simplicity, currently we limit the min at the FS block size, but a
lower limit could be supported in future. This is required by iomap
DIO.

The atomic write unit min and max is limited by the guaranteed extent
alignment for the inode.

Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 fs/xfs/xfs_iops.c | 38 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/fs/xfs/xfs_iops.c b/fs/xfs/xfs_iops.c
index a0d77f5f512e..6316448083d2 100644
--- a/fs/xfs/xfs_iops.c
+++ b/fs/xfs/xfs_iops.c
@@ -546,6 +546,37 @@ xfs_stat_blksize(
 	return PAGE_SIZE;
 }
 
+static void
+xfs_get_atomic_write_attr(
+	struct xfs_inode	*ip,
+	unsigned int		*unit_min,
+	unsigned int		*unit_max)
+{
+	xfs_extlen_t		extsz = xfs_get_extsz(ip);
+	struct xfs_buftarg	*target = xfs_inode_buftarg(ip);
+	struct block_device	*bdev = target->bt_bdev;
+	struct request_queue	*q = bdev->bd_queue;
+	struct xfs_mount	*mp = ip->i_mount;
+	struct xfs_sb		*sbp = &mp->m_sb;
+	unsigned int		awu_min, awu_max;
+	unsigned int		extsz_bytes = XFS_FSB_TO_B(mp, extsz);
+
+	awu_min = queue_atomic_write_unit_min_bytes(q);
+	awu_max = queue_atomic_write_unit_max_bytes(q);
+
+	if (sbp->sb_blocksize > awu_max || awu_min > sbp->sb_blocksize ||
+	    !xfs_inode_atomicwrites(ip)) {
+		*unit_min = 0;
+		*unit_max = 0;
+		return;
+	}
+
+	/* Floor at FS block size */
+	*unit_min = max(sbp->sb_blocksize, awu_min);
+
+	*unit_max = min(extsz_bytes, awu_max);
+}
+
 STATIC int
 xfs_vn_getattr(
 	struct mnt_idmap	*idmap,
@@ -619,6 +650,13 @@ xfs_vn_getattr(
 			stat->dio_mem_align = bdev_dma_alignment(bdev) + 1;
 			stat->dio_offset_align = bdev_logical_block_size(bdev);
 		}
+		if (request_mask & STATX_WRITE_ATOMIC) {
+			unsigned int unit_min, unit_max;
+
+			xfs_get_atomic_write_attr(ip, &unit_min, &unit_max);
+			generic_fill_statx_atomic_writes(stat,
+				unit_min, unit_max);
+		}
 		fallthrough;
 	default:
 		stat->blksize = xfs_stat_blksize(ip);
-- 
2.31.1



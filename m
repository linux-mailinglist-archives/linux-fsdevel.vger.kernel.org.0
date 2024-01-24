Return-Path: <linux-fsdevel+bounces-8767-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D457E83ABB1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jan 2024 15:28:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 855C9285D8A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jan 2024 14:28:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 753A977653;
	Wed, 24 Jan 2024 14:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="jLFUxQWb";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="o9gKuXbl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CBDF7A728;
	Wed, 24 Jan 2024 14:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706106455; cv=fail; b=Gt4dUy0ruL3d9Ll2VgEvJPzdDIX7+qqf9k2q7mO6CFS0MJdbzxdZNGMoX+48JFz3HfrEMk+ZsPJCHCr95G1fTuVLZK+5PJ/Twn5fA0skHfivFEKJPl91ZcSnw4+X/Vh3luzx+pzugoj1jD2wL+CzbsnB3vlz1MYnIpQbZSdq/Ys=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706106455; c=relaxed/simple;
	bh=hbt+0k+R4+qccQnxPZlDW0Qi+QvQlzvLsNLX0UMwDtU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=twM5cnWnaQDekESV0QU+jUIjmtwJ99ymKaKUKqXaqYAPuAyZvSLEg6GncCsc2g7lon9mVkYCFJn8e5hQt/t0D/kTtc3zvTB9v2Fx0e9AMykuqXMuLCnHv6UZZQVosLJJ5pdSLceeOI1jMUn1g2n7XEsC3hKwS0fCQFz4B11HtDg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=jLFUxQWb; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=o9gKuXbl; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40OEEaIu026749;
	Wed, 24 Jan 2024 14:27:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-11-20; bh=AFwdfP3dbZoF4oRQn3J9ARLTElsVYZ+A8bsr+ucvIMc=;
 b=jLFUxQWbRc1bGUM5sWwCJzHO0W6RipToCFTYwpTdFIU1O4J6jYlRLwMfU2JKhEr8JEpn
 dQ2f3KvEYZASFq4akkwsKNwdQrAa/hy/o2dhZ6vAHD3XGTHUeMXuBN06t2XHcrwcVC2K
 P3rKUkNeO/zKOTqduDCQhIE6aSQYsTLAwd4KuZHs/IyU7sGhzwN/1IjLpeW+mxxspQrG
 qslGf1wO/RfjSZHqma90jGdycgmg+/W+iTBPJQYkPbaJgo+QhRPAlynfbq/W2WKMT52G
 ha0L3kBoPuicT77N1zkCfgDtZO09vb1flH6d8cH920ztdqzpmCAt31l3Usgl04Hg2uVt IQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vr7cuuucd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 24 Jan 2024 14:27:11 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 40OE1L2E029572;
	Wed, 24 Jan 2024 14:27:10 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2101.outbound.protection.outlook.com [104.47.70.101])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3vs372rr2v-4
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 24 Jan 2024 14:27:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C38CZwLv6yqgVM8MDbOrdqKWXNyOkMqtVDS8HT+Ea0/wr2ZidNOSf2871IogpuePki92YOPwwXgOtJK8bl+BdQp9JYtusw9FN4pZ7ZnO2m0rIiSQKHGBicX07Y7MRnNKm6uF9lI+/L5DPxK8PPFawaWb1a1x0hUAjLK0yNfvyBpdhqTDNcu7Sec7DPho/dtrV5Tt3CA+o6MnRlkKPX18mCNCB71tLTn2Ff3tcjP6dsH5rDeZxOBlmEEnBFPQs6KFrRI1Uqj9I6Qg8hav6BfSYz9G+WacTHSt2WCNkrboIJBx0mvD1xrjaovpBs5UWd/FT/a/Q5ZoC3vV1JBmFbNqGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AFwdfP3dbZoF4oRQn3J9ARLTElsVYZ+A8bsr+ucvIMc=;
 b=lkzkQzpXDCnZUuzgim1aofd2hVqN6LjFYoyOrkRBlbgYG9A4AN1F9ASHwdtUdS5E1rl4mwONAZbrIelCPqyKTBTzoVviWDJIaMRZerPovENjtw2Otqa1Lo5+Nv/OG4ltog7g8Szqw0uiDbq1ORgtY9waIKenKe+JW+nt+sE62TrNCpJ1GVmuUU7ZUsZDXCU2Al/0jqoQmTHe88yK9zBZZglvMLkF5l7un96duy3dByIs6aOn4IiwEq1L49lbil317kYciaYJJzo7i3tyZ6vn1q/zJpE5L+xyMtUFuYIY7saxqYJPcg8W3N1qSrbIkDY/wDgZ0fVocYLzLKtmbLCw2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AFwdfP3dbZoF4oRQn3J9ARLTElsVYZ+A8bsr+ucvIMc=;
 b=o9gKuXbltmNbtfemUqFi2FdHFYMlDxVev5V0+cFDdF0POMO9kp/DkX4X8gjJLYPXgbVfi7u8H5wjrGcjKq6DIHful9gDtra1ySnFDMUVplpVjFoWb/L88+WoOKwKKSM/D5n6sw5PwaihYoM4lsezPKEDkUu9LxLINPylSzwwQWk=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by CH0PR10MB5212.namprd10.prod.outlook.com (2603:10b6:610:c8::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.24; Wed, 24 Jan
 2024 14:27:07 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::f11:7303:66e7:286c]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::f11:7303:66e7:286c%5]) with mapi id 15.20.7228.022; Wed, 24 Jan 2024
 14:27:07 +0000
From: John Garry <john.g.garry@oracle.com>
To: hch@lst.de, djwong@kernel.org, viro@zeniv.linux.org.uk, brauner@kernel.org,
        dchinner@redhat.com, jack@suse.cz, chandan.babu@oracle.com
Cc: martin.petersen@oracle.com, linux-kernel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        tytso@mit.edu, jbongio@google.com, ojaswin@linux.ibm.com,
        John Garry <john.g.garry@oracle.com>
Subject: [PATCH RFC 5/6] fs: xfs: iomap atomic write support
Date: Wed, 24 Jan 2024 14:26:44 +0000
Message-Id: <20240124142645.9334-6-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20240124142645.9334-1-john.g.garry@oracle.com>
References: <20240124142645.9334-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1PR13CA0440.namprd13.prod.outlook.com
 (2603:10b6:208:2c3::25) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|CH0PR10MB5212:EE_
X-MS-Office365-Filtering-Correlation-Id: 94beaeed-c5a6-4a75-7654-08dc1ce88b6b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	MiWChE89foI9Q/P2Fyy4XUB/k/dQtHzzSA0AEljqdQZpqvQgKj33lPk2UafFruNGEC3NfP9CBpIdcRWzK/QTZ+KzpKtQBZk8Y1Ch8Sqs2S96ZAqr4gnPGEeAHCg4/qvcl6hHtKbff+3O9s1pzRDT/VXSUt9VDZ7OXtqfqQNmk77pIWTyoaJKM1bIgH9T/RwC2nx3+UNzq2/9yyEN8ZrY/EYdvsAxXWjtz5CUWAO7IpHH8e+YX7Wng58ufJgZnc9KZg37Gd/rU/sLcosUMWlKfPvSU3DWHA3ahBL8aCfBVlpvfX5q/oq+QarLPfX/remlGK7HFvOThLdk0NHSVmiRGPAgaYTkHhkjfWJ/rCQC/ysR8C68rLYyM29vpMRCXas6GcDU/4c8QBqOhgLNj60lvVupPXlGErSOEWx42WB/UV5zD+vPVWKoSc0MqPCLivFcZRU22zD5cL8CR+ekFjv3y2pHUjeRzCVJIqL29LvqzNyim1JYFWe2hpQQnX8QmzkWTBwWfVRPlmtVnC086DVbRBgQAGae+tdfHQHtoExAk2ZA41mAClQojgJu4cML9Ws0
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(366004)(376002)(396003)(136003)(230922051799003)(64100799003)(1800799012)(186009)(451199024)(83380400001)(41300700001)(36756003)(86362001)(103116003)(38100700002)(107886003)(2616005)(26005)(6512007)(6486002)(1076003)(6506007)(2906002)(478600001)(6636002)(316002)(66946007)(66556008)(66476007)(6666004)(4326008)(8676002)(7416002)(8936002)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?YiKjV+DxWnm3HB26zQ/5g2y2p7qhufYsiDRX1QUjV8xVyADocDNqAanJ3JS0?=
 =?us-ascii?Q?3A6zVuENHvo/WNriKOUskXclZJR9im2wq9Iser0I/lcnIka1uO/0wTfIppKS?=
 =?us-ascii?Q?1QQJ82V8ss2e1CD8nyl8fZoQUR9eZBRN5lLB6jnWT1lVhYKe+iL954PBgLsm?=
 =?us-ascii?Q?c/w6+LYhYOXc4OAkJ/b5uuf2osaBmkZg+4mUIaVTeteHV12RenLOWW72C1tp?=
 =?us-ascii?Q?meBJDn5qiyxp2wil/FqxfIVpMH1fRiZCqK2dnFyIeapjeIoiVi67yUWB+JQU?=
 =?us-ascii?Q?cl2PbwdWnDK9ewzkCmT90mZFz/3aom5sHOeXolExPDm8JbAek/63glmfQDfC?=
 =?us-ascii?Q?QnEPdskhwPRL0JX8OCyglUki34EPa1EwFT6lxffI5Ds4Q3G32e+ymg6n9ZeJ?=
 =?us-ascii?Q?7I/FxUrRIv4YhCptOgPoT6YNxUsoEhqFBDYKowe2vNtknExwcfgwmnPEWnUl?=
 =?us-ascii?Q?my7O/mO3DLbT+FoDzo1xokaCZEU8JN8d+O0F8BTJbbKT8YkPpwg2SmWGIk/l?=
 =?us-ascii?Q?4R+zcP/Tob5fBvLmGYJRuyuq+BwsqZlwwViVCLirf0P6Uhym1to+yA+l6jn1?=
 =?us-ascii?Q?/x8T9whl3e1huj30F9iWu8xE60IRj2VzxWZrifQhUTHEVGR0s3qS8zM+Aoxb?=
 =?us-ascii?Q?BKMHsiHrFUyfKGxNfC6x7puD+TaKgXIIb/+5WDigV6wste4EfDNxQ28Yvp8x?=
 =?us-ascii?Q?PgukZ3EgzoDLtr30cmaNCoVgzr8Bu1FEhCoh7JwBBFE7pEr8OPUqd3tHFH8i?=
 =?us-ascii?Q?aywejjNHtJxVwlCFKpx2C71W4tb0Q5lTKwxCYr7qJ/1ndMTYGYw06Vje1rye?=
 =?us-ascii?Q?K4QxoXHVQK4KLtrA0N1/vWw/B39tgWspg+meMRhlAnLWA82LdWi7VkndLPAP?=
 =?us-ascii?Q?CLVBEns23xUWjo0D9IxlN3udEQrIhkeJ1YFkS1mEDT2SahOlgkVvtaV15CD/?=
 =?us-ascii?Q?btLILX9SntuZ4MKy4PL+RED7uEGFKql6WCnr8YobrVdoiqLzVAs7kAls5X1x?=
 =?us-ascii?Q?zLA4o9g8llZaMKAIB+DDwUeMo5e7+CejwU2z7znUHc6dND4lK3yb1XH73PsS?=
 =?us-ascii?Q?YL0gnHv4/d1HjZlhdyaMKRZzRhCk1/r30dOzMM12RD25szQ5hvl0h99r5gJa?=
 =?us-ascii?Q?BKirIpffQ8dOdHVEPgUES9YG5HS4/VH9k1v1dRSsfgqDQKZWPl47ePmom8VC?=
 =?us-ascii?Q?i8f1ENCo5VxKzp/LErAJb6bztwM5OLWUP2Jpg5iBnH+zbEhTnNj6r+UleUwh?=
 =?us-ascii?Q?TmwcDWiQPwPbg8P8xbRpVOb6YhHNQcqALoNCMbbDpxugZsU7aVj1iSvFlcHs?=
 =?us-ascii?Q?/mW29N6FTzossEcb4ef7x3iOg5G8FjcMfOrZm/pASPCWglRPX6J43YlYhQi7?=
 =?us-ascii?Q?L4Bi1qBqYpG68dbXygCCH92q4Mcfb7leXOs/651ZOtj+glyfAYLcNq6y7cfq?=
 =?us-ascii?Q?mxWThnepWM+WruGVVy3vAGeflpH3l3AYhXMUe3lNRftv1qQD15tPVmi1R6kU?=
 =?us-ascii?Q?AmU1BMlmxab14QaSgYpYTvomNQIBpwSETh5kQPBUuIh+6X5g5QuC73CPOEh3?=
 =?us-ascii?Q?QZhNlJSoReL63OlNtFxhCIzS7cX14yoZ3Cg3XDYEITV935TQbgT8OxblFnfa?=
 =?us-ascii?Q?Ww=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	FC87AnVVvg0QI3ci/T8MlFUni6Z33HPtaVgKgDeGq1vXfoaNNkZqwIFdQfCZCmaVX1D/l3SGHPDPmbglUd7JJHq+wgm8oqYk2lvDj8DnNa1hiARnFNvcoxmGNCFV4k6uV3tw/hbF1TkMU1KUcECuIQP6vzXeLtRcCmrqwYPUq5nBGA9kxk5BIAZnFcOfVb/71jyGSa/qAcAt5aza/zYa6+dJycEnERvVZVwfLwHEP+MntdtHK2J2SLvsYf5Qe0wIfR14RhZ2cmXd7WlHGUbUh6IugyeyhCY9PzGqpxLGrLpO4tE7pKzSTYhh8XnmBSQs6YkaKmT9azuoMLq6yzjw4XpMZxJqQAolEl2VSacrFjYeS37FobG4yljJNBgk4NP8ua3t8EwVT8eZ0sQ55Wmvd0uiTLOr+5w2CeUkvdsk+2Q6DoQKughELoXWzqD5ljUvyNDuiFXSTzgVldpopbSSyDMF18XKRjIgr8r6sKJ6ji8yDH9luSdDAXerv1sxprtYWkm15/6GXsTFtdNAfsMjMh/x18rHg+uqVPSG9jxD/hm2WVI9rpiZaVA1XSm1xv3TIQ36B0n/A/iA+kjS4pXHLGIlJENAh8gpdBQYWHu1CjE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94beaeed-c5a6-4a75-7654-08dc1ce88b6b
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2024 14:27:07.8208
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GSjNsDakt4NAdGvTwN2p53jDzpFGYupFhIRDodDBlymkE7z5wgMxDir82myIZmdjpskVjpH4um5qWkk1zDu+nQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5212
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-24_06,2024-01-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0
 mlxlogscore=999 mlxscore=0 phishscore=0 adultscore=0 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2401240104
X-Proofpoint-ORIG-GUID: EFokGYJGqSYivndvNp0L5eCPc9XTTs6I
X-Proofpoint-GUID: EFokGYJGqSYivndvNp0L5eCPc9XTTs6I

Ensure that when creating a mapping that we adhere to all the atomic
write rules.

We check that the mapping covers the complete range of the write to ensure
that we'll be just creating a single mapping.

Currently minimum granularity is the FS block size, but it should be
possibly to support lower in future.

Signed-off-by: John Garry <john.g.garry@oracle.com>
---
I am setting this as an RFC as I am not sure on the change in
xfs_iomap_write_direct() - it gives the desired result AFAICS.

 fs/xfs/xfs_iomap.c | 41 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/fs/xfs/xfs_iomap.c b/fs/xfs/xfs_iomap.c
index 18c8f168b153..758dc1c90a42 100644
--- a/fs/xfs/xfs_iomap.c
+++ b/fs/xfs/xfs_iomap.c
@@ -289,6 +289,9 @@ xfs_iomap_write_direct(
 		}
 	}
 
+	if (xfs_inode_atomicwrites(ip))
+		bmapi_flags = XFS_BMAPI_ZERO;
+
 	error = xfs_trans_alloc_inode(ip, &M_RES(mp)->tr_write, dblocks,
 			rblocks, force, &tp);
 	if (error)
@@ -812,6 +815,44 @@ xfs_direct_write_iomap_begin(
 	if (error)
 		goto out_unlock;
 
+	if (flags & IOMAP_ATOMIC) {
+		xfs_filblks_t unit_min_fsb, unit_max_fsb;
+		unsigned int unit_min, unit_max;
+
+		xfs_get_atomic_write_attr(ip, &unit_min, &unit_max);
+		unit_min_fsb = XFS_B_TO_FSBT(mp, unit_min);
+		unit_max_fsb = XFS_B_TO_FSBT(mp, unit_max);
+
+		if (!imap_spans_range(&imap, offset_fsb, end_fsb)) {
+			error = -EINVAL;
+			goto out_unlock;
+		}
+
+		if ((offset & mp->m_blockmask) ||
+		    (length & mp->m_blockmask)) {
+			error = -EINVAL;
+			goto out_unlock;
+		}
+
+		if (imap.br_blockcount == unit_min_fsb ||
+		    imap.br_blockcount == unit_max_fsb) {
+			/* ok if exactly min or max */
+		} else if (imap.br_blockcount < unit_min_fsb ||
+			   imap.br_blockcount > unit_max_fsb) {
+			error = -EINVAL;
+			goto out_unlock;
+		} else if (!is_power_of_2(imap.br_blockcount)) {
+			error = -EINVAL;
+			goto out_unlock;
+		}
+
+		if (imap.br_startoff &&
+		    imap.br_startoff & (imap.br_blockcount - 1)) {
+			error = -EINVAL;
+			goto out_unlock;
+		}
+	}
+
 	if (imap_needs_cow(ip, flags, &imap, nimaps)) {
 		error = -EAGAIN;
 		if (flags & IOMAP_NOWAIT)
-- 
2.31.1



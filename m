Return-Path: <linux-fsdevel+bounces-36930-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EDE69EB15E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Dec 2024 13:58:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 549C216B14E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Dec 2024 12:58:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4826A1A7AFD;
	Tue, 10 Dec 2024 12:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="fYG2d2vP";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="HzsnZWk3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF5F278F44;
	Tue, 10 Dec 2024 12:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733835488; cv=fail; b=DlCzPf9e7geMpd51qcVfJIUQm91hSnm9AwrgUB8LR5buUJw86cRpsdWza/orb9lqoh0wTsuOdhD0RC0aU/hKYBCngUY3a3tr8rEQrmXA8HYRZzzJ0tvQQiDiMXBKCxcoAI4bLRs8QC9xSjgX2AgcOlxGxrRs4Qh4uVDJY9jeGCQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733835488; c=relaxed/simple;
	bh=Yiwsw8Zuh0HkkxLPgw5D/CexS7DWkT7IPoPSlz3eC4E=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=Qg+wxVFE/87xPHmCSISf3SN+W2TIdlx/hRJXDRDPirMGYvKA10+IASr/GLpLDwxX6WvKOjmb7K9OSNz4ErP26bLYSefgcoEL+WHL4xHQlfJhoMWOhL0d8oF5Csvq7EQe7LMQwU8Uc0PLgoZNsNJChbjn0sTtIGED5vz1OR1Y5Z4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=fYG2d2vP; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=HzsnZWk3; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BACBXGg028674;
	Tue, 10 Dec 2024 12:57:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2023-11-20; bh=bOQww3l3vqxs9ATe
	OzTXyj/fG23tbwJAqtmMAza7AnM=; b=fYG2d2vP3GuBkHHMyB9aDobF4EbYsBtz
	GfPvKwxQ1nnL8W2NzIDLsvCNsQGBzn6D0oQnfg3gXEvUqpq4x8VuWK/lKXpS/huC
	H/2WPKi5UVGUlzyhOy2gqtyLDYwlN3Nd48uBO43Jwj/n8FV1dx9l7YasX2ugo53+
	f3QYmCJdXVagdMBy76hBuFhvktxfVPTp9Dc1fMH9myjRT74NbdPwUhswxi1uP7Fy
	YHqQrrxFturf+ne/mDzdFMBH9txTLOqL3pEFHCbAPYNVWvKQifUm4LHcm1c7GQfE
	5U7MVDjCAWYaqmXdhoQdaAIyo+z2vSSrIBrRd37RP+5iebS/+wmKcw==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43ccy05se3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 10 Dec 2024 12:57:53 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4BAC36vC020734;
	Tue, 10 Dec 2024 12:57:52 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2044.outbound.protection.outlook.com [104.47.51.44])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 43cct89b2r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 10 Dec 2024 12:57:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v4YHCip3/jn2qr+BEwxaPmsNONkPutfdOjwH7mhYWk1heK2kSqgtKqKzk19yVBCAWSC/AndZBLYCiF0zwrwqOUf6IVhfH6YGLBP3bntqP/ZHj1oZJgDA47UWXBKWRDoGl9YVfzkP2MnNZT5IbIoZFeILfiD1YwW+3CpdvK38xHzG8D45KRNdfPsChr7u98xzpWP7dQg/lfljlFcnVaHrVghd2RjN5FC1WXUHDwJLJW23x+Y7Fmh8C6Dpwnog9uK/HuJNpOOdkeh/1fAnWv9NvBOHoU9ayGoNqm+uaPeP9mhJ0rfGqXPAsrc9MMGDSworMx47E03cv6kHFGRRH4przA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bOQww3l3vqxs9ATeOzTXyj/fG23tbwJAqtmMAza7AnM=;
 b=naG2XOimOsUor3sxc3Uk/haPKqeKBuTqzjv1gKPvwPWwU2NzG153yzEtJIEl/jNDNT1Nq5JXKiLURjUAFxD7kqPnEmZWVBq4uqdIyl34V0gCFPLuqBkgPXw0CRkxsSJGYMxo6RpF9LgwwG94vRtY/HeU+X4kHCrmpODiOXTey3XvzjxWW8een+l3q+lHSzV4zbvJQ6jqCkcxY6A0JaGLI5PqxwLhWu1rIB9t25L0xiuMjFJDeaIHYrnhLSZpjhp7DN4G0OUlegM7R4NPnWRf0OJDNDr0beJ+gjS2eXzPsZhKqvZfwBvtiSf4bvBzmmHKourPx1mRPKF3zZLSPCcEFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bOQww3l3vqxs9ATeOzTXyj/fG23tbwJAqtmMAza7AnM=;
 b=HzsnZWk3jmpCE92GGlSrbZfp166G6walzdnkwF00ibHfA/dW/zkmkiprkvYWr5MlCrUCqe1/nXhq9y/y8pgE07HUEp8r49mj5Md4E3ZNLXcJoJ3bE/ymYcGc4sKPYTi2PRzm9zqpO84Y2JUYt2+hgFy28IKRngRzpU5jZswUFdk=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by SJ0PR10MB4669.namprd10.prod.outlook.com (2603:10b6:a03:2ae::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.18; Tue, 10 Dec
 2024 12:57:49 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%4]) with mapi id 15.20.8230.016; Tue, 10 Dec 2024
 12:57:49 +0000
From: John Garry <john.g.garry@oracle.com>
To: brauner@kernel.org, djwong@kernel.org, cem@kernel.org, dchinner@redhat.com,
        hch@lst.de, ritesh.list@gmail.com
Cc: linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, martin.petersen@oracle.com,
        John Garry <john.g.garry@oracle.com>
Subject: [PATCH v2 0/7] large atomic writes for xfs
Date: Tue, 10 Dec 2024 12:57:30 +0000
Message-Id: <20241210125737.786928-1-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0520.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:272::16) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|SJ0PR10MB4669:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e687f90-91c9-4884-fb08-08dd191a4047
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?sobAXcmCIZ+zg3D6T+CD3KM5tq03t33pmedlo34l+oWXVpxjohc/tYwfcH53?=
 =?us-ascii?Q?DYRmAWb1xZGMrO5GjICsfZA/rdrq4gaQW9767QQNXHa/tSojRDNlI6fhFxFd?=
 =?us-ascii?Q?xdmBICfUywIIitpOekPu/HV9LqpfZaKK4jb7hIfiq6FY07ANr2RTYkuKRe6/?=
 =?us-ascii?Q?FxDbtaNq9pap8FwRz5DzeWbCIkqPIU9vYen5DLcyk6mnPViEe7uEyBU4qrhP?=
 =?us-ascii?Q?gjpJOubZt80nLoJnbQsSgf+9ykpH9nR1hwXEy3hczKM63BDRf/1Nt8Ai83Oq?=
 =?us-ascii?Q?BMMHxkws1vMAMuFoL2R3cPfK3z2Yh4Xqkw5doi9TC4M7ryUD9xa1VsfVbmwu?=
 =?us-ascii?Q?fY2C8DMWkBCiejd4gY79PQDPQzVoaRpqe3jds0j8DYJ8bJOa5xPX08Al6QBA?=
 =?us-ascii?Q?tt5ZfbWiJnfTKOF7wM4qUZstYCmpPXCoscf/fK2Wo3kTNCrTC5PHE3c8wFIQ?=
 =?us-ascii?Q?8w9KyDjNi9omGGhA+XJU6M20WsiAJ7UpGND6/WKM1+2k6mPVHlHEdWL3tGXK?=
 =?us-ascii?Q?O/ouZsWOdcJO6i/phwurZS8Oq0f8B6hc0yWKcEOFTQTucU/4EE6rcnYj4mxc?=
 =?us-ascii?Q?9hIai0TkvZo6ipmvC8u1NP70woCclwb9j30nne58JbbL+BLva/WcJH7WF4xz?=
 =?us-ascii?Q?SyiLNqdpnGvPUjT0q+n/7rp/oSS5uXHUNubExq/knTAuFQ/uZvqVWAYYRFRy?=
 =?us-ascii?Q?+SywBGxYMQDqoCP7yFpHDxEP/Wy4ylPadavUj31v7hvO67E8xmvWm1wTruGT?=
 =?us-ascii?Q?tj3zqxMfSZfwb3wKKKEly2+r15eIjy+xbgI7ZADhFciz8Yx4px/KXWXSYwIN?=
 =?us-ascii?Q?qA8tjEACJY3ayrvwpFLxdgISLJMrd1AMzhBiFXYKsSNT2+dUpjZRBRpamqH7?=
 =?us-ascii?Q?gpq5THUQ6uWC/Qd6ZOP2t0TOOqajbRDWWLeOhPXreepO43zM33InLcN8faDo?=
 =?us-ascii?Q?L3/p4BLfBZRp8h8z6NwUxjb96j5hgE8b5yebsOnhQ9Qf5H0yQM+RFgKdjVFr?=
 =?us-ascii?Q?86yYITudWh7Ha93sqcMhKye+YEIk4c4aVz05kb8FFeY1HXjaFNGBrLeuhYt/?=
 =?us-ascii?Q?67zkjaWOzfFouDpBJLHpVZbgiT+nPIcCA9TunfV0cbw+2PKKbhnpPQzWnQhy?=
 =?us-ascii?Q?vGv1pTquvZxYh6FNUFdKhh9xKqX29exvmteUptg57j2ZrIxnnMGtWTO1sGsj?=
 =?us-ascii?Q?aw9lS05EC4JKA2Xl0xOlN/H1/+937LJURu3aYudS3Cq2/MTVe0xRO30pdXzs?=
 =?us-ascii?Q?KF/Nr0eN1TTVELjn/DOD7SPHTk+wlaZ+W4FIouYSQ2Sw32jjjZ1mxorJh96k?=
 =?us-ascii?Q?thuFnxrS5AosPlOJoqbWOn5oBk5DV+oCB31sbWaZrBYK8yhCJIfOTDNjffAP?=
 =?us-ascii?Q?nPdpiBQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?O0INz+ccURtoQgG3gq+l8lGdX9oNOp7d3ZGw/jPI4kauIdYH19mikj6/Hz4A?=
 =?us-ascii?Q?zzerhX6bmEM1yZVMtz8m8Oixr2Ubjmt4wJIjB/Bsq5KMlvOuFyjI2IlIeW6+?=
 =?us-ascii?Q?+yVR8YS47WtKdzNmAweyWcvXPvDaAcyRp5N4jyi75R0FiGyTrXowTMoha0Db?=
 =?us-ascii?Q?MV9ASS6ILeVqYWouFh9fANZ1gB6CzYsB7S8+I80XtTHr9hoZ5Rg7T6j1NyVc?=
 =?us-ascii?Q?CLA6n5Uiv1u3twjr65eb4uTPLJPKEtk4ZAPbls0BHQfOxedKMOkFaTA+jTuD?=
 =?us-ascii?Q?gTMcbTGob/JE8e2A8ozjeaeXZKBrMrao2LNj2k/YaCnb106PkOdFuItQtEqA?=
 =?us-ascii?Q?4p9WqFip0JQ5wTeTxbLAyGTa+TRnRXGRB8+x5/K1RD3JrZ/3GNFuoAqUgLQf?=
 =?us-ascii?Q?w3DdheMqUh5HQVStht/9ulSl3OyTW46Xx+fQrRPctqx62hlpIDiuaFyuz1p3?=
 =?us-ascii?Q?Zx2iLIcQQe0qdP69/yqRZLTObZ0utkI/qrHU1400pRfZWQRWQBQQssmbEzB/?=
 =?us-ascii?Q?/58TU7tkQCiWCYW7ibB8lBxw8ttZcHeZvbhcoqvP5LYPMnbUMdGfLROyGuAs?=
 =?us-ascii?Q?j/RCZ80F/rnKzL3j+3IqLEiwTrNQ1ZQYa6scKBatu3AZ7kt1Prhy2f7VaMHK?=
 =?us-ascii?Q?M+d4CAAB1DMYKTkIusPHvbVqaEh6Gx1+vPd2V60nK096qOyKs0t0fJRnlnW/?=
 =?us-ascii?Q?nXGhefHQ5VEbkMEnO2Rz/vqUhAbSNsimM3DsZhDMaigyzpxGuaZ6w/RIi0Tu?=
 =?us-ascii?Q?L/tEMmP56Kk7lVURRVkFDEb83CUoL7/QeVr2UZoYUIW3uW/cx6Uc1apG56Ol?=
 =?us-ascii?Q?xDxoHAumxil5DuMTcR7fgS5N1tJc3RR05pdTLe6VCRIEEFk+PwsQk3t5LpZa?=
 =?us-ascii?Q?sexWwlIDxWQbBdQuPLxE+gW5eaE1NGlKauvZtXCOWPePtakN62WulS5VfCz9?=
 =?us-ascii?Q?IKAW5jdMDzKGVwKxqZsmKvY7ljY6t9A2LXYcK3m3Ne5JokWrlrmXeFp5n+Xy?=
 =?us-ascii?Q?SgU6DqNpfsRZQ9+XmLhWsSZIXlQbKWw+rnq/4QMMcV0sIAbVhdG/S8s+d/bq?=
 =?us-ascii?Q?t9xE6s6ohluwMttN/5RZBc7dvRjEtn7Ihe8O9Oy8U7EkJVz9E4xQy/Jikfo8?=
 =?us-ascii?Q?M7QbqbDKY+1GRzaF0v+F3pQk3aR4ejj/xpmZbYq6NzLcUoOv6VvQGjLC2zQ9?=
 =?us-ascii?Q?DLTEz2kSkEVC+VcwVz0+yqCag5NMwC+GttBc0j3KJHkFtgCkGvpMbb47Ps9N?=
 =?us-ascii?Q?p0yUqTEl5usD34nxw9lxdWwK41m5Ze/4kAnJwurPp5+XRpWRxR9OKJUKn9Mu?=
 =?us-ascii?Q?HAhJ2j9HDIrdQsUYfWJIO9CKiaqZDiyRePpX7DxSMbtzsLCGv2wnbWyGDM18?=
 =?us-ascii?Q?WIxeI1U7lARE07wB5kWfbyp/0zKvH+6ycDNrBahuSK0AUhOTeTqop7i/qtz4?=
 =?us-ascii?Q?TZUDCozghyZXGOW6NWEJrInSX8UtluOW0K9zZLQwBemQBQrKcrMb5B4bTpqb?=
 =?us-ascii?Q?rnSg5np3wYHktuyBqpkqodiIWYN0cFJHX+zEiO7JwIvjkG7EiVlCB8m9j2pP?=
 =?us-ascii?Q?A75n/kPFoTRz5Y9m9EUv2fYH+IqdtmgHik/sJeM9D+o50fH4+18BFawhwE50?=
 =?us-ascii?Q?zg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	E+Nwhqadekm15rwDN3LQnB30zAYokGbx+M6DCU2QRvTTkoLNpLViaZTU7EQ6r3KOFMnZ/sBq0js5tBt/uKNqo3iSX26URU9iRvvZ3cYKl7o5PjD4EKbqP+9DVHTFmG3FUcvfd5vB9FWrbaT+9fBvx1Xp3HlkeEir9GRwM5Is8WeH71CVQ91NRb8QlgTzXrO4gjKHGBC5ekGG5r6e1olVNzXtkJRcTcrkFpe3if3nk5hzWnR0sOlhCGkyc1VLafZxlrtW307MB5Ik5+oQNTKF37vm26MAiOBsTcAwMxXdt4cVNZuvMWgl3J+W9TzdDiLyy4dibQEurT3dLuoWtyDLPDCuG0/fiWK7N0kSGwkuI9D5qb2xHbDzaqVeFEzIh09bzthDMgB0OKQY3c+GtH0wNU/vONaH5PXpz0qohC2kAnaN3E6DP5TJa2O0zAZg++5SujNKd3svyBaehBbv6IY0JJyfyT/Ty2VNlWBicBprJKGvedzj6aP8MuYGvjw+uUCqYctA7H5savmOllspCXVQJ1yymFRfowhPMax4qlGNVQSHmhHBEykkxlImLj0JtmfdZUqHFnganBzWUFmrmGWMl33TFQShd9R5wRTcw3afRNI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e687f90-91c9-4884-fb08-08dd191a4047
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2024 12:57:49.6843
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VsMffiZ7jbOR7zqhAgdjG8k+bUj+PReRe3GRiEJuxKwRmzb/D3nxKY0vXlOHtVhroEtcyc09zLzsa9FJxV1XzA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4669
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-10_06,2024-12-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 adultscore=0
 phishscore=0 suspectscore=0 spamscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2412100096
X-Proofpoint-GUID: uhCEECT_gK0iTMpEGaUF-Ql4Mi2nk7qd
X-Proofpoint-ORIG-GUID: uhCEECT_gK0iTMpEGaUF-Ql4Mi2nk7qd

Currently the atomic write unit min and max is fixed at the FS blocksize
for xfs and ext4.

This series expands support to allow multiple FS blocks to be written
atomically.

To allow multiple blocks be written atomically, the fs must ensure blocks
are allocated with some alignment and granularity. For xfs, today only
rtvol provides this through rt_extsize. So initial support for large
atomic writes will be for rtvol here. Support can easily be expanded to
regular files through the proposed forcealign feature.

An atomic write which spans mixed unwritten and mapped extents will be
required to have the unwritten extents pre-zeroed, which will be supported
in iomap.

Based on v6.13-rc2.

Patches available at the following:
https://github.com/johnpgarry/linux/tree/atomic-write-large-atomics-v6.13-v2

Changes since v1:
- Add extent zeroing support
- Rebase

John Garry (6):
  iomap: Increase iomap_dio_zero() size limit
  iomap: Add zero unwritten mappings dio support
  xfs: Add extent zeroing support for atomic writes
  xfs: Switch atomic write size check in xfs_file_write_iter()
  xfs: Add RT atomic write unit max to xfs_mount
  xfs: Update xfs_get_atomic_write_attr() for large atomic writes

Ritesh Harjani (IBM) (1):
  iomap: Lift blocksize restriction on atomic writes

 fs/iomap/direct-io.c   | 100 +++++++++++++++++++++++++++++++++++++----
 fs/xfs/libxfs/xfs_sb.c |   3 ++
 fs/xfs/xfs_file.c      |  97 ++++++++++++++++++++++++++++++++++++---
 fs/xfs/xfs_iops.c      |  21 ++++++++-
 fs/xfs/xfs_iops.h      |   2 +
 fs/xfs/xfs_mount.h     |   1 +
 fs/xfs/xfs_rtalloc.c   |  25 +++++++++++
 fs/xfs/xfs_rtalloc.h   |   4 ++
 include/linux/iomap.h  |   3 ++
 9 files changed, 239 insertions(+), 17 deletions(-)

-- 
2.31.1



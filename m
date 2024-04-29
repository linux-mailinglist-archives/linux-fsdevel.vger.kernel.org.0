Return-Path: <linux-fsdevel+bounces-18141-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5343C8B6087
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Apr 2024 19:50:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5B8BCB20A14
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Apr 2024 17:50:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 440E8128833;
	Mon, 29 Apr 2024 17:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="eFcR4rx1";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="aib1qAId"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C5DD127E2A;
	Mon, 29 Apr 2024 17:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714412961; cv=fail; b=ciuMo4oAvebIa0/Cwk+Td0vTeVM+YT35fSzqnTuLEs9m1l2RZU1bsbtJ1nOY7S1kVxEeSeCvChIDNy4j1Dbyknb2unzJF3OJzZJmKg2F2hkF5ZDhfIIkOYo+RnxbF/fKCnlmrSMJe9LH8Un7TbL88pnQIhPPEvsBxREucG8GVpc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714412961; c=relaxed/simple;
	bh=smjgA1lHm4sf5KhA7qhIuo+DbYCATs5kLmu6zbLk4hE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ASN0MKvsDi8jeWlgmA932ONLI3jhtjAt0XerapxCBQZvrGQriCnU2EaRimbkikKj2gRgOv4FtCIu9Gwu1+n/cbdHxUMZkdBnEWBAmSU56uLfvA0sHuxgW3+dESUIlTfnsjW+40XSGuCGN+LUwlgVJdL4+SNvQbqn82JVLMrIq3w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=eFcR4rx1; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=aib1qAId; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43TGwkoF004986;
	Mon, 29 Apr 2024 17:48:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-11-20; bh=kvyF5iC8aBAqSD3cqY8Xi3nCwgg/rkCiCE3eLrk74bo=;
 b=eFcR4rx1amFg2Y/JNXV/P1YdR8MdfzrFHGGQwv0ZyM75WWMZwLr0QAAvbiypSsAFRFAz
 C6sQYcVOGsymLTO3dq6XlOWMQEMsRrIOvq3u9UMDxUXn2YNrKdJeYU/g+G0blsruU/0S
 syEZ1OpVAY2/Vc18KaQScXznkpdUCoTeiA89vFf8u8iUSMMe8E/VxkmosDhHfWMYtGd0
 /p9DtFOvqZqYpXmV29XHnhxfT27N4aM/TAvrZ+uZEw29s2WLJunATDr3z0qgPsQrk4RZ
 gbo9nE1tjnRo3qUmHBnDMmSxNePgKnJWtYbgWXB4K0qY/AJ1Fbm7kl+9a5ZG0j2eLsXP eg== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xrsdek6ar-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 29 Apr 2024 17:48:25 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 43THkxUP004324;
	Mon, 29 Apr 2024 17:48:25 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3xrqtc7ns0-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 29 Apr 2024 17:48:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cM3J1jPttSF4qASYB/PKL2evvK44o399DE4/WS9UgbdMYIb4TnZLwu3NrILA4Zm1HfYbvCFdNMCg77Xc75PLQJNARVv/gEUSHO6N8hqnBEPAIyL9GGOFc0Ea2+hblQW25tVSOCILZDYPUkTQJd4ru0THCE1JDirqrkUu9wbSxx3Wq8hapODxeD9qwwRzdvAPSGTKeaKMwkjZM1AA+74Llw2G3E7SByJlC3ZQ6f4PE6c2oi+2NnfrVpYLG3Bm4SvSJ+4dx5BuzC+O+H277VbiAWHWWPOIF9UfAluiOKSmtUo/wZ+epLMBvFEPGHLuulN0xsKEJ0TRDUhD+fsuJ5SaZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kvyF5iC8aBAqSD3cqY8Xi3nCwgg/rkCiCE3eLrk74bo=;
 b=OPTygwt83BnYNcw6LQ8bIeTg/OkoAm+kIYJzz+piVi9q5hGHR0iUBxPOuS3miv1I5toOuW+RZPn2PYFml66oktxQgnbbxB4T8hc0Tlx8f2XsCWEhxxIvKhpcivtMehJzHa/DnGmOKm3PSRR93kmSf+xcSHjXNWoCM/QJwIyET2qOjO6eKMYowywJWB4FS8W9VUlU9Z+auzw/HC75HDLijPVlvlgPMsiqHXzve/s+vaFlcliQRx6JMRmsx718m5oqqRlhimAtF8Hsc8yKFHxSBchak958i+ZmvMOpHzDOV3aaRdt6eWBA0AudhwFKHL+9uyE+OHomeBvYVW5Lt7/bJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kvyF5iC8aBAqSD3cqY8Xi3nCwgg/rkCiCE3eLrk74bo=;
 b=aib1qAIdJITi3ydjJ1mCyD3i2bztinF73raZirecNzy0fg83lV/k372IZJ8z7/zxBqFgrRzEuGiXPaX8Q6I3cg59uHQqoz2v8VHBxqKn2OIgto7UDMVeoLv3Dvr2dHmgntyA+Cv4X54FcVvksrlDQQexPzNnvUbMWmufp0TKz18=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by SA1PR10MB6389.namprd10.prod.outlook.com (2603:10b6:806:255::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.34; Mon, 29 Apr
 2024 17:48:09 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%4]) with mapi id 15.20.7519.031; Mon, 29 Apr 2024
 17:48:08 +0000
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
Subject: [PATCH v3 02/21] xfs: only allow minlen allocations when near ENOSPC
Date: Mon, 29 Apr 2024 17:47:27 +0000
Message-Id: <20240429174746.2132161-3-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20240429174746.2132161-1-john.g.garry@oracle.com>
References: <20240429174746.2132161-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0035.namprd05.prod.outlook.com
 (2603:10b6:a03:33f::10) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|SA1PR10MB6389:EE_
X-MS-Office365-Filtering-Correlation-Id: 5695ba6a-0acd-47c5-801e-08dc6874878b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|7416005|1800799015|376005|366007;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?Ws9quFqA6jjgDmqZLJMI/WuNOBvblnpfG/Iiddu/go5mcZhKmyqjHSmSs9up?=
 =?us-ascii?Q?8nIaQQfqw3lxA5e4M1guIMLaTjqMvixMPgr5sZJ4adzxf2NEdquZz3s/aNwl?=
 =?us-ascii?Q?nNR/Q+Jb3ObASmk1GF6KBPIW4kO3CS49+W7SV5IOpvFk18v7u7ZKidRaglQg?=
 =?us-ascii?Q?wFLvt/PX9SUUlc2fNPc78T4eFzDm3boWLSQ5AbKWN8ZbTFDwEoMurTLGtPPv?=
 =?us-ascii?Q?ur7h8wztRNnVI5Nn5qUuSLJL37TUwPHvEPZAxFhRbnZx7oM4ERY3D6C6lKKI?=
 =?us-ascii?Q?nMAOKvY4Ng+o7NlzfV0vdxvfO7o13i1Zxz3geB0Kvljab/7WFCUKAf9cOB7M?=
 =?us-ascii?Q?AbXLa8eCkpILLt9JwPs3sISM3zLxgFcQUavkoyP2ip46+HcKtHLH/q01Sf7L?=
 =?us-ascii?Q?Q+GkBp9QUEcatQ9I2wn3zMi60iVGKLSMP5dVZO0yss6lviEpE0JxTQ33AzRL?=
 =?us-ascii?Q?2SrD7TXb2ESZDzVHINuT3cKQj4oUVLYbuWbVKaiuKiM1POxq0VouZFlG/oFi?=
 =?us-ascii?Q?Kw33ILE+yJ/P4wdvdAPSw6jbejfljykJUV0M0CnbeoV2IPoA+nwpK9g7wNQ9?=
 =?us-ascii?Q?fzvS/nSRltpd+2QfdHN4NWS9XfTRDpj9MeajAWlbVSoU5o7qFO2KTmQji3Gs?=
 =?us-ascii?Q?UGdIrPUu4c9WNNEEIzWkEoE2613wko6lsHuyIngdE187g0vEqOULKGl0Gnre?=
 =?us-ascii?Q?08hqYCFfTEj1oBp7qW8vQRJK0yb4U/PR01ISHNh5fxSQZ3sPZL0qEjx4Ft3E?=
 =?us-ascii?Q?3ymJY1xyPBkKAWglMR4vwESpuP8Zgearq2OnwowR9cZUfTgDBmmwbMl3kiK+?=
 =?us-ascii?Q?ca39WwMvFEI4GLcYrS8ToHRQHmKD4C0boWnYfx+iXMFxlvCmvZlVrB//5vHQ?=
 =?us-ascii?Q?63l+8sy+TUiFDQNH6i+Jd9aaM3tvCvFD5pTXAF/SzvknvtJCXMRjeUsyzn/M?=
 =?us-ascii?Q?lyVXzWJFr1Yd+ygRlSeileGto6iuZkl8B6R7tNn16hAC4lx1SgetAhF76D7q?=
 =?us-ascii?Q?VYKYC5HPbn/jCh4I44IgQyJvexPuoehULBCj9h5bPg4X/Y54UdVUmDOdgq7b?=
 =?us-ascii?Q?SXOCWu4vQaUe23sFByLfUf+3EyeswEW68TUr5zLiHWb3JtMkrZ6gbjrzta/Y?=
 =?us-ascii?Q?5KS/B0tiVBxrolX4fV/0RcvNgGfe8qIgqvXQ0HgLzJ3u/RYpLiAjveZZVcAX?=
 =?us-ascii?Q?TJSwfn8JG5Yn8mdGwd0QCKIYC7zy0r1JVmv8eJrhn3eRVGIIeBOao+5/OwKt?=
 =?us-ascii?Q?CzlDp7T3GQQHt7UFAxPW0QYGVfew56u8ATvS7VDfvQ=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?IvxQOzEwaPNQCEyOcu1rMhmOQLtw4VtjLDnEXf8cZ8lmr9qFz/u/Njz9AFkO?=
 =?us-ascii?Q?eh7raHCpk22V+P0A9JNKu0eAl97Tjwcptqxa2AKej2ShtB/YikzpFbjuMloG?=
 =?us-ascii?Q?6FuV+jZMwLk/PVYEuyfGGLH/cLm0ljsZvwogS9JtwDJiolaLP1/fIPG88Mc0?=
 =?us-ascii?Q?PvLggjtnw7YaQZ92uqPK40zIr+TQFKzfif380tZiD/Llq2q88JS7YJwt6VOe?=
 =?us-ascii?Q?mSO8j3iqezahvhMEejGjXUmHr+m86YORh8Lh+daCPBxClv4EUqVBCFKCqKp7?=
 =?us-ascii?Q?cF1qgDZmrpOA/dn66E3nzHpVhUE/mjeTu9isCTkSuopkLVljMDsgU+o9FehF?=
 =?us-ascii?Q?7VPcJUxBgGUCua+sX6n8JSSqRayhc5HQSDvHWNt4BgyN9c/EwY8rr0NXqE5E?=
 =?us-ascii?Q?pEIT+5mAyEjrqmoaJg6mzq3MrEcE4SyAOcbeKPlpcxDU656VPudU2MCBCKuM?=
 =?us-ascii?Q?YpIQl6xG6XlTkpl4X0sGJENR5XlMvUJPXvJ4+yJUDULv2RGF3SiFtwevhT+e?=
 =?us-ascii?Q?uFWROiGECWr/vCDDbDQugwD4f5mJCFVOuULagAVYIkwuG11AJTW1l2bOicSn?=
 =?us-ascii?Q?Qid6W+ZQEXW6i6eKpBx3F0Et/fI41MwzE/j5nkyf4ix98tMJzlIShItdlMe1?=
 =?us-ascii?Q?mJQ6OdTlMZLEMUjDATC1CGiT5fChSoNqEB/zR2GGkiK5P/vJ46atdsLHvZPA?=
 =?us-ascii?Q?j4BmwHWXkNdVL62FflKpMTxKiMmt+USk7Sq75UU+vW/OLwwC+Egsr5PM8YKw?=
 =?us-ascii?Q?m8Cxsr8yyHQgaZdBxXenl4hdjDFyR7NbPlKVI46egmkPde9fgd1FcSPyqN28?=
 =?us-ascii?Q?U1Tg2dCZ39GxIGhQLtMF8b9h+6FjRVH/U/A0FMw2h3tQUxmwKkpQLyf2TZa3?=
 =?us-ascii?Q?Cn2K41h5e1TEdFcRjeRhP5rFNcoW6TvGlnVZcooge/boCwBQFGi+TQBDfkIk?=
 =?us-ascii?Q?b9W976xFWPj7jOG0LrQWJmJA4CzrJG40SW+3OfzMdv3Ync8cYG60Jz5ZIwb7?=
 =?us-ascii?Q?cR4qzV0IpS0puPaCInCKpPP3sAPoNIBxsr9JOJ7teJbfuKaOnJJNmTWR3eC4?=
 =?us-ascii?Q?aqk5a9PKEZs6hj+vQ8qEZQgZtE9+RlcKkJY2IfjIAPm2TZTdiaB2HgRCdn/+?=
 =?us-ascii?Q?ynPKW79MsUrEgH13Ma+KkNkJ6/n7yaLY9IRupLV4BG8kFhpm5p5cFf2Dqv2N?=
 =?us-ascii?Q?J4GjYr9BWS73fdRf7Bc3+V7eFrKwPkCLMkSdXjCkewObVABQYbxQ7m5nIrcx?=
 =?us-ascii?Q?HPiS/eorokng/1mcx9aPGrFa7ACDNKD6oW3FUxXukyz5xa6NFJfuwjHfkMEI?=
 =?us-ascii?Q?nMpgY+OgOKdqRvacGkfFGhkVADScVC4CKkVLVseXjt6G9OEu6IWyJmIiltoH?=
 =?us-ascii?Q?EUYFy5IrB3jdVK9DTZPXXwthMnejF8hy/KvO4afka/WXeyijKyRdBhfLAuuy?=
 =?us-ascii?Q?Cj2yYvbY+ZyeG/DXPjpcP+/m/P17dwoM/HUkLWL96VjusPNwJg7iLU81SCpI?=
 =?us-ascii?Q?OQqVrHNO2zX5zfKMh6BhpOEVL0pZ6eXYHS62/OwDpZbUoGpSyMlQLwL16sy7?=
 =?us-ascii?Q?ToMc3SjqQ3f/2w9UQ5PEuDUalbPGocbcb0k3JH0SlEsLU07eTxCnAc5Vi7PN?=
 =?us-ascii?Q?Xw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	06yQTTTK35zo4E8pYJIeefBfPLVBv0cGaZ6x6lYc+D0pNift7os+rQLHSS1gyfYsr7hWA1ja/yM8Jqne5QXZVYMzR7DEJV4n943V7OY0xFCffRCmPflp8Oi8ombkfhn4XV91rQeFDtndguaGRKGYsxX5qJlWg1ufr08Rh2Tl/ypV8XUjgdDyPYMYY4YA6rtLLcajaXQx6s+UUrAhVT2wuiA28CU72me623JKnbu1bEr5dyfDS5nAymPHkeTFytuXcEWefmBAKOvejBJ0dQjPbrm+Sz/MGjWqDzRNgff6RMcxTJx9oeXLVQ3g418w9a1L9+xBu7pBQEUBFvfXqHTzhFStjsohK94mRbZwjr9HinF2vdno+4yEGCT1tEne4zsOwU2vAWGIt6d9Rg6f2bkb9QzSNBf8uHznq1XJeBKYu6lA/Zs3uk7qno5xVWhe4VtnXGierIOG8zWA6ReIzTQHKTilMCVm8uIsiov5CqIov0GH1VNQ49aiptpNjCq2QcA0Q1/Og9sTMcZnbq32lC/Nij2KWlX6AEPdZr5j+ZhoFig7Li/nkZQqhBoIXNMJW/Nl6pdQBSUKPdEsguWiQB12tBQhCN4AJNpI7eKJQOEDqUw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5695ba6a-0acd-47c5-801e-08dc6874878b
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2024 17:48:08.0631
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WhTSKpt8dpucyr6L0Ul/NlyaOKWoqVfb6xn7zp7L9c0E1+1b1Q57yE7bhyQV1jv5/Cr1dNFb07pcIb+Bke+tbQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB6389
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-29_15,2024-04-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 phishscore=0 bulkscore=0 malwarescore=0 spamscore=0 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404290115
X-Proofpoint-GUID: qfILHBm8c47S2YHnTktK-CgH_3UH8vAg
X-Proofpoint-ORIG-GUID: qfILHBm8c47S2YHnTktK-CgH_3UH8vAg

From: Dave Chinner <dchinner@redhat.com>

When we are near ENOSPC and don't have enough free
space for an args->maxlen allocation, xfs_alloc_space_available()
will trim args->maxlen to equal the available space. However, this
function has only checked that there is enough contiguous free space
for an aligned args->minlen allocation to succeed. Hence there is no
guarantee that an args->maxlen allocation will succeed, nor that the
available space will allow for correct alignment of an args->maxlen
allocation.

Further, by trimming args->maxlen arbitrarily, it breaks an
assumption made in xfs_alloc_fix_len() that if the caller wants
aligned allocation, then args->maxlen will be set to an aligned
value. It then skips the tail alignment and so we end up with
extents that aren't aligned to extent size hint boundaries as we
approach ENOSPC.

To avoid this problem, don't reduce args->maxlen by some random,
arbitrary amount. If args->maxlen is too large for the available
space, reduce the allocation to a minlen allocation as we know we
have contiguous free space available for this to succeed and always
be correctly aligned.

Signed-off-by: Dave Chinner <dchinner@redhat.com>
Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 fs/xfs/libxfs/xfs_alloc.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/fs/xfs/libxfs/xfs_alloc.c b/fs/xfs/libxfs/xfs_alloc.c
index 9da52e92172a..215265e0f68f 100644
--- a/fs/xfs/libxfs/xfs_alloc.c
+++ b/fs/xfs/libxfs/xfs_alloc.c
@@ -2411,14 +2411,23 @@ xfs_alloc_space_available(
 	if (available < (int)max(args->total, alloc_len))
 		return false;
 
+	if (flags & XFS_ALLOC_FLAG_CHECK)
+		return true;
+
 	/*
-	 * Clamp maxlen to the amount of free space available for the actual
-	 * extent allocation.
+	 * If we can't do a maxlen allocation, then we must reduce the size of
+	 * the allocation to match the available free space. We know how big
+	 * the largest contiguous free space we can allocate is, so that's our
+	 * upper bound. However, we don't exaclty know what alignment/size
+	 * constraints have been placed on the allocation, so we can't
+	 * arbitrarily select some new max size. Hence make this a minlen
+	 * allocation as we know that will definitely succeed and match the
+	 * callers alignment constraints.
 	 */
-	if (available < (int)args->maxlen && !(flags & XFS_ALLOC_FLAG_CHECK)) {
-		args->maxlen = available;
+	alloc_len = args->maxlen + (args->alignment - 1) + args->minalignslop;
+	if (longest < alloc_len) {
+		args->maxlen = args->minlen;
 		ASSERT(args->maxlen > 0);
-		ASSERT(args->maxlen >= args->minlen);
 	}
 
 	return true;
-- 
2.31.1



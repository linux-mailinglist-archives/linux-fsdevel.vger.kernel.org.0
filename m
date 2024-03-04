Return-Path: <linux-fsdevel+bounces-13467-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 831CC870239
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Mar 2024 14:09:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C3B59B260D1
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Mar 2024 13:09:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B69F3E485;
	Mon,  4 Mar 2024 13:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="i1GJJDYh";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ATjYkODY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C8AC3E479;
	Mon,  4 Mar 2024 13:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709557596; cv=fail; b=GJD8TYtoxwDQuf2sD/Q5ypcwU+IFXa9/2mJFLhM7VvKqRAIA0sr9UX++P6HpCwGc9Q3y5xYEyRjGMTN/lYpB0zO3RR3yDJ5Qm3XdRi18uNsR/lFF/y0EoK5sFcbk+rsYaMdTjiL8L0nrHX/Hy5G0DLtAa/Hom9hVDQWzvktiXno=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709557596; c=relaxed/simple;
	bh=tBgXuR/8sAHQntFICvMGTRRv3wsqjgKBJ5Qh6WRnrjw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Q5JaSjM0rvu4NwDpVgR/zPWgyoh2brfkgu+VDn9RjZWKvzsugnYKPU0yghrlprq7biTu9s7G0tqyvH4gDNtrtCipIPOTLMHu1o1LqYz/KRhBfR6DUYehp6XEDf+3JrUFTa2+2fv2rpixgSuD0Q8kHQSxNpPKHZA2jTLmAgswRJY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=i1GJJDYh; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ATjYkODY; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 424BTmf9028485;
	Mon, 4 Mar 2024 13:05:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-11-20; bh=zk4e0dToTTEsqQ87dpyQx5aKdhodoJj2t2vw4pr0zyU=;
 b=i1GJJDYhACtKHGcblepYn8z5Vxuz5FoFIYwUR/L8jYMzb8SRf/ho8P1xR9Hcwax0QO8h
 ZZbNf9AK5vCLe9dILWE52rADYOubQqgTT/buuzQ+xTF/MNr7Fmk6cIl/7elPNWeHA5qK
 I0EsmOExmu1xeRhTSJURKRoec7UsOXeb+yN+yusX+7EMxSPxwlOE61PDcb8z6YiFVfPW
 aXzT2upShFkVjPwUBONV/48IoGQDh7hL4gp3NdyhY7hjjEmW9HZJ9QCsUHKbrJlAhRVF
 HFwIMCAcapmJhLBkv1SouiVfPsffYNrJqCGno+9cQgQ8dJ7pT+rlXfd5+Ep+s7CW95nr CQ== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wkvnuufah-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 04 Mar 2024 13:05:22 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 424BYo4M033901;
	Mon, 4 Mar 2024 13:05:21 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3wktj63tnd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 04 Mar 2024 13:05:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B0WUtl6V9MtEEHJIhZRxqzWKw0swalljMigJ+iC8rTqLHIvj+QPKOuT4VcELM4kboRXYB3m/y4sjKGc/Vqm0cFvbSadHRl/BTjumQA3FblMKzNwaOdiZodXVrmL8llzJ2LGSIwoufg8y2wZFojxWIox1787WV2SMmWu2/LY3+5ASkfljP7SEsttpRg5wF3mGRtdLORHByXXhSPI9ncO0H+g/wEbkHYT9Mw/zinhNPNNmwo6qmvXPpgXow1J7b2LLUGhYS5qvlU/4E+6apfPjCzsLFQOeJ5Gl6mqr76n3yqVc/LzI4Ee7hIG1NI/5gjmjacin08rAymCA/+VPjXjmEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zk4e0dToTTEsqQ87dpyQx5aKdhodoJj2t2vw4pr0zyU=;
 b=OCf1QzbZ/VbjJK81GAEFafyMC9mB5pjM+h+59PpZEq4UVbTXvS2Zoz8WoQzusjIwsYxN+iF8Y03ZLgf7JGnLBZQDYny5u2gj8qv3zAtNDXbdj7lnjT+5MeQTKAd+V5bxBQszd3EbpJfWO4toEOvnbawXamoaWPDhIq6f7r1A5pek13GS7Un8PV8sItQqYBN1GNZQ7WwoyVchnQ8Mbp5E7Ci4OOcOk7O78ZwGsiOLQDMvy/fv2iha0N2kVe/GsZM5Gak4ELp2+iThFpEdvXATkC5MazEPnWrTWQ62MgVST223mhJb5s9B9TwySd6vu4acyF/BNJWn+CIh8qUOEOXtYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zk4e0dToTTEsqQ87dpyQx5aKdhodoJj2t2vw4pr0zyU=;
 b=ATjYkODY+sCS1Wmj+JSTCp/TniW4Mtjz0bezqpm5xY2XKgdwGYw1a99xyC5vuqwh0TulvEGYupD/Lu9z/Nm2U2zjsuehMc9pZ2bk0AcWsh8WCMpVQgVbWkfggorhWuSEbY02mjuhZvlwJ/SFdG07g5ImErJ8Vv1JmTXNHxR7JB4=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by CH3PR10MB6860.namprd10.prod.outlook.com (2603:10b6:610:14d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.38; Mon, 4 Mar
 2024 13:05:19 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::97a0:a2a2:315e:7aff]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::97a0:a2a2:315e:7aff%4]) with mapi id 15.20.7339.035; Mon, 4 Mar 2024
 13:05:19 +0000
From: John Garry <john.g.garry@oracle.com>
To: djwong@kernel.org, hch@lst.de, viro@zeniv.linux.org.uk, brauner@kernel.org,
        jack@suse.cz, chandan.babu@oracle.com, david@fromorbit.com,
        axboe@kernel.dk
Cc: martin.petersen@oracle.com, linux-kernel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        tytso@mit.edu, jbongio@google.com, ojaswin@linux.ibm.com,
        ritesh.list@gmail.com, linux-block@vger.kernel.org,
        John Garry <john.g.garry@oracle.com>
Subject: [PATCH v2 10/14] fs: iomap: Atomic write support
Date: Mon,  4 Mar 2024 13:04:24 +0000
Message-Id: <20240304130428.13026-11-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20240304130428.13026-1-john.g.garry@oracle.com>
References: <20240304130428.13026-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0293.namprd03.prod.outlook.com
 (2603:10b6:a03:39e::28) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|CH3PR10MB6860:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a4c495d-046f-4c68-b901-08dc3c4bbe2d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	9LNi9gRVqT5iReJXEITjnLO1DXkyL940qWIzqpatrpJWZjGDrlnwaOHm9QbLBjV2+OOQEhwC5dKaQRJF5hUa0r0//IPvYYvUVTZ7CDnax1GgEfiFgR1CEPrmAIALhv8d2jVx312gyOMc8N8Fh1f4m9qqF84Aq//xQE3+2l6+Aiwqn35NpRs77C+fkoS5W2kHBUyySHQWBBjbxBsm37JAYIKb+vWm2SUAdq8vxIogoTFffGuracXqAwU8ylT1Iow/v5mOdA142aczYq+7CH2wQxX56dwAV3yC7nggbu3pFuH4eDuhCL9VakUEjLpvp0L7cXv/pPgSeBsB6YbAmYFB6u6dU9QFFVIdmPuhjxz3WhIKumZdSDsydnDvmBkzX8WgV/aYcxXqMDfEVIUj67aKe2a1rumvwSzBWof+uBkkP0bcAxzj56rP2nMLt+fGEaHAH4DGUZYKk6qRfA9hOUIR6QTU0bldJhLgIaWTKKjANQqtFgmfN5MqEVrc8vCiGgsRftTnUKcXAxat1G/ZdWynIJy5SbB3Qhvim+zqE+3Hw3Kdb0oq6OJ9OdRF0cTDWtO+Yws57N5N17McYd7RkN0V8aQdba0aJ/5wSX2AdEU9FQN8rBAzHt3JK6KjMU8FVF4ckiyTB9p4VhAMy0aApFWVSz7PsysmR7B9vKVosj994lY=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?YmrGQ53tnEzVfiBnNXduov1weHpWhXDyhuYMc9JOwM2zPwhe1hDavaggkdj5?=
 =?us-ascii?Q?aUHq5LQxNqVyXwsfEvuxNh7s+J8YG6SwNqigm0Uem1wfFgaTWp/l86OuGLi/?=
 =?us-ascii?Q?mmvqm0ZUTQNhzHeTzo4eWFk8sqBAzfTszMcFLnNCS/z2iHImIrLejB15+c5m?=
 =?us-ascii?Q?Fh6jI4OP71NY91eT0QcRgBWB3z69c4GIDwEGIi8tusTlql9uzQsqShd3j66u?=
 =?us-ascii?Q?NxO3AXZIxbxm3+cQ5l5Xkx4unDL4x99j5aMGAqMx+73hn0jUsL7dXgX9S+a9?=
 =?us-ascii?Q?/19qPPLsBFrJsburEtu3pfc7yNKmxzIPZnNI3XagNyKz4B7tQ6b8wslkdvdw?=
 =?us-ascii?Q?m2RqHu4alTxzuT5W3fCaNzorzpPiZjj6sxixxUaMUbdMRrfwXYetl0iPGCp4?=
 =?us-ascii?Q?8znY9K6tKGoPo92grxm8BsM3GWLKwzRiv0f2VZjU7Iy7Drn47pP2uF8e80uM?=
 =?us-ascii?Q?/rIZFBPBZxanUhpiKuWxuZYS2eOMr654q9hqIKGTKZcwONfwFSPTlW/l2Zfr?=
 =?us-ascii?Q?ghQ/PKq581WsDfAfpv/8pmRStW6MYmc1nJdpLcDU70n7BB6WgDomL6rVgWg+?=
 =?us-ascii?Q?7Xz5oVIfa84HMfrxYmvDYEgreaE8I+IQMVLQq2VNqx5xWIem26sxSFoFd2TG?=
 =?us-ascii?Q?VBYZGmpjEb5DZvBzhIRsPcHoqmru7Ovf/NbcwZt9oT0Gec3TpD7z0Faaic7W?=
 =?us-ascii?Q?vj1bTlPCbvmCevKtZ9jHLHD24Z1eGH1kAhe/12j+b5o1kkYN1TAaNiafACXT?=
 =?us-ascii?Q?XCfs+Z+Bi0ns+YtCH7pvphZ2P2HGWDnw4RVqvl40p5ez+jZhxft6pYikbfi2?=
 =?us-ascii?Q?jm3KVqz5VWxIBWXRPuar1kTVMY2DgBQTc+ns3P6/xsg5ogfh+4wHKW+9TRo2?=
 =?us-ascii?Q?/An5sPh7sSpFOpMRcUGxiX/LXnYyJ5y+HE0uYKVjm/ljphtYhFDWXDJt9rqy?=
 =?us-ascii?Q?uEGa+34Cenb6UtUcUuDeycadnIo79M2GMzIST7mBL/FckCPWKueRi5zVGp5X?=
 =?us-ascii?Q?WJsZd+08Vt2tpcj8lJA06BbTPRfB2jlus5ubn+EorP7UupFulm8HUmTPfnKc?=
 =?us-ascii?Q?DSeIYqg5/RX/CU852DMZ6Y89VYxsFaoCnxAX4+0QY5Qn4bqbOT7AbsLlFgKa?=
 =?us-ascii?Q?lxAFlVzUxl7Xx0OTHSkk2UkWQEGfwgGMtNEXlXwWblAvk343i5tlLYrDXfDc?=
 =?us-ascii?Q?GTHiYrBP/+UmLbUIUlqcFsbf5tGrpiaF23DOFGrfZP6NGTpHLk83GPgEG1cq?=
 =?us-ascii?Q?vOGHp3qh/9prPefLV/V4AUFbxZfi1Vb8C/4/HVnSoDlUaYevTdmdCAx2nEbl?=
 =?us-ascii?Q?6eOam/8Ev6aW7Xv9AJ7W+UCg1tX2DCC/Eq90QeJHuvpDB/fAB51VzVEbtpuJ?=
 =?us-ascii?Q?HRQ6pau5eq+SjBqo909wCi1fIjmHFDDL4nJbtFmHUApMSDnFN0hAkV6CioB4?=
 =?us-ascii?Q?6jHjOX/ezmI0vNTYywcSXmgiNOchXl++OoqD29XFlFwK/NbD7Vz9XCV+8KAg?=
 =?us-ascii?Q?aMZmdS6qqDtJ1y4JiUk6KP8ToaFY9MoBoqgMoqOkZtEsvVdDSCuz7egXWz/S?=
 =?us-ascii?Q?0slrt0/KyQj//VxyQZWdvtMz4FrocUnnQdqljF4yFIhCHw5c+2U0PiATL2ML?=
 =?us-ascii?Q?Dg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	OoL46PFoUo/h7NO1Fjr+QlQ50bT1M0zS/rDRoM6WAFjpwzkMyjk0hRLKziBvwZsnxgWqi9f1sBGuEcJ8gHM6YndAlX0o+PB+ewNcXqW7OdDQWXgOVAVsFOU8Nv1k8FIvmbbYWjKe2dzgRg2HV12fH6CSknVFoBW2GtOaU6DtGS1rb0dm/wKuiWOIZTpwY9ZQLvkcfCJBjjclQDd1C6K+HugkQNWsPVP0+ZsmrSog1yzkLmBD25RjXM9PiSe4++tYnsLDXxP+nqhlXX8M247+p+yK6RxOmIvBOJkve80Rh6PXko/p5dkj8kmAQVNX3PLcUaf0m/Q1iTN3N6135F6oIx61fkI5JD3SSnFtjWM6ToMG9cbAslN/o/2p/BCTQvcNyFYh6XlNAIQqmyVPakbea1h5n3KPgM6x3+UI5jcYSEtEjLo58+HPaOSBc/0xEaaEboGld66+gYUO0pF9j8g7xhVFhqZyRRdCzI0NIoL16nP2ooEkUugrpAMEhMmGcZIhqTAkjn+HVYi0hMK4gsq+j5dB+iQWMbVOyAeXpmrsMUuTM/Qlai9kBeDlTj460vtZoXAzB88/NCR6Ocgq+8bf3mb5YXKjpZrBI7plRJsP6is=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a4c495d-046f-4c68-b901-08dc3c4bbe2d
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2024 13:05:19.1779
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RPTE/GIsrSilqvAsnHC0yNxjHBpyt46xuT0ClxNDifGZgJae57k9rGDUH7JpFa7tONvqqhdcyp1agO4cu1lBcw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB6860
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-04_09,2024-03-04_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999
 suspectscore=0 adultscore=0 bulkscore=0 malwarescore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2403040098
X-Proofpoint-ORIG-GUID: Wtt1xs-BUwvDnsC9Bj9DFpmTNnS5Wnsp
X-Proofpoint-GUID: Wtt1xs-BUwvDnsC9Bj9DFpmTNnS5Wnsp

Support atomic writes by producing a single BIO with REQ_ATOMIC flag set.

We rely on the FS to guarantee extent alignment, such that an atomic write
should never straddle two or more extents. The FS should also check for
validity of an atomic write length/alignment.

Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 fs/iomap/direct-io.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
index 733f83f839b6..197f1bb6a261 100644
--- a/fs/iomap/direct-io.c
+++ b/fs/iomap/direct-io.c
@@ -275,6 +275,7 @@ static inline blk_opf_t iomap_dio_bio_opflags(struct iomap_dio *dio,
 static loff_t iomap_dio_bio_iter(const struct iomap_iter *iter,
 		struct iomap_dio *dio)
 {
+	bool is_atomic = dio->iocb->ki_flags & IOCB_ATOMIC;
 	const struct iomap *iomap = &iter->iomap;
 	struct inode *inode = iter->inode;
 	unsigned int zeroing_size, pad;
@@ -383,6 +384,9 @@ static loff_t iomap_dio_bio_iter(const struct iomap_iter *iter,
 					  GFP_KERNEL);
 		bio->bi_iter.bi_sector = iomap_sector(iomap, pos);
 		bio->bi_ioprio = dio->iocb->ki_ioprio;
+		if (is_atomic)
+			bio->bi_opf |= REQ_ATOMIC;
+
 		bio->bi_private = dio;
 		bio->bi_end_io = iomap_dio_bio_end_io;
 
@@ -399,6 +403,12 @@ static loff_t iomap_dio_bio_iter(const struct iomap_iter *iter,
 		}
 
 		n = bio->bi_iter.bi_size;
+		if (is_atomic && (n != orig_count)) {
+			/* This bio should have covered the complete length */
+			ret = -EINVAL;
+			bio_put(bio);
+			goto out;
+		}
 		if (dio->flags & IOMAP_DIO_WRITE) {
 			task_io_account_write(n);
 		} else {
-- 
2.31.1



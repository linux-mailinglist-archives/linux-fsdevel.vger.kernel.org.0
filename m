Return-Path: <linux-fsdevel+bounces-13464-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F5CD87022D
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Mar 2024 14:08:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 833F91C22112
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Mar 2024 13:08:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE9F247A53;
	Mon,  4 Mar 2024 13:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="H2yDCtvb";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Uod+Qcax"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2FA73D578;
	Mon,  4 Mar 2024 13:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709557536; cv=fail; b=uN2tG7sM8dEgeQfaq9dxqGk9styrteY9JtvHIPHk52spIzkvfLl/A9SPo+WDedYTDQQgai9iRFQzRYHZK5ft9d7MsgU/vM/VKdDrdkwzIYZyew0BQCSbZlPrtz+cuY4iU7QDVyBLUoS5kA1QOl0T9RyYAMwdoZ8P6DbkjDcI34Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709557536; c=relaxed/simple;
	bh=UytkUkRUwEIxo66vkcZ7o4fT5aovX3iG7tkjcKfwUCY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FqC8iRNKhJJJhlGmymMGog7Q7bPg0DBGwHFrtMI8nUmTHUqyB7IhbbXLw5br0FZ6d2vvBHiIVsWyLAGqcjsXb7sbFv6kYKRAOZuMZG5pwBpZjUcqWa0OZtk9JicaT4iYuHzhwryEV0hcO1KUrwEyzqODunXk79/NJQmtJbgxpPw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=H2yDCtvb; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Uod+Qcax; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 424BTBGw006563;
	Mon, 4 Mar 2024 13:05:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-11-20; bh=Kq12PPaf62RHqquV+EQx7IAGXFa73lUNESxSMMKVvhY=;
 b=H2yDCtvbB0YWyCsmo3aZASz7Wu5C9WEPJYeinN/1XbjinElYRVys2qdhaEJFGphU9WTK
 GiI3g6T51PkfhsNOw61yHhTROH4QI1Drvnh+JQgRdB2OkDGS2AZz9CCC9xHFH1eNCY6x
 p7KzQ6EBV9eIdlP2GSL+wDfMTV8kL9XxqkqpjpvywR+n/1n+3Yh//yutRk93Vfu6aUx0
 BiiONbBkdjxpuKttsedbh3B/J4U8inIoA7ug10h7DMbRrfiytYqttjHjzo9sXrXByOTw
 Vp4fyxXNyBAfJ9VsUQLTNNGyLHGdrX8DPqyxstWesjxN40gAdkop0KIkWRUfGIDGNVZ6 TQ== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wkthebku6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 04 Mar 2024 13:05:19 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 424BC3nJ017048;
	Mon, 4 Mar 2024 13:05:18 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2169.outbound.protection.outlook.com [104.47.55.169])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3wktj5qpea-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 04 Mar 2024 13:05:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HGkYoDhxNE4Gfq7ch6bilTw6Z6qnCzcax6fBydKTC9gic+REOQpNiRO9jZZ/TZbzjxHXrcObS5cjmkwANoeQIMZzf95jKRfCLPpHTAww18wizmhPHjN8sgBmx03o4Q1kvzP34rJk9/CX53nsGTAzjtOL4DL3oIIzS6PLcqK1+Zr1rlToJsmhJ+lz3t0GTsaTlrHeVQZHYabm1BRBcI84fmwQMfS+QYoO+fOn83ksh6n1WWlV7CnoJdTJFpQOFi/9UBNEv4Q+08trVEVIhzalI3dHrFdn45Y6kql4RETlzUmBway0kxM8DDDyeihG0CtsPGUZ+1ZWsdvdYVlt4gQQ0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kq12PPaf62RHqquV+EQx7IAGXFa73lUNESxSMMKVvhY=;
 b=WoEj5Kkd7j/YbUdlMwemBzjJSvkj17AYBn/vRjPtWvjSwxSpeM3HMoAC4Fee5wxToMEPF5imAuuHu/N5QDmKn4q2tyF9D7ebq0Blr2PwbSN+a7CJFAly9Br+519SPap/X5UuHVmxEQzxb5OojkqFETulxrt3wyTVzxlqK8+PTI0MooziH6tFSPq0F5Zb1phE1I3LCIQ33nLdzzxtXgOgMHnEgA/eCQpTOl0O7wkneTeN1yXn5CNfqZeg71Y7B8DZQa7DJ6SaMUJhrTz8yrlIu4BUzmMMhr15hY6mgqYVs4IRjEWyrYUo9x869TNxITJHX82diMG20kx1jlRsI59xBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kq12PPaf62RHqquV+EQx7IAGXFa73lUNESxSMMKVvhY=;
 b=Uod+QcaxJBskQrNM8vQZ4sC1m1OPwXBE++McweLh9IPZw3iLBk6avn5y2UT+wGI1KdIoflY7/eCQ151BPygagIKiFD5visoOQpumFwlvYfeLJn8jPVpGtF9aPCcWQEdCl6PzEQGksgZX9J0+6+nfDt8zEeQxh7M7CBVSDVP3S/0=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by CH3PR10MB7805.namprd10.prod.outlook.com (2603:10b6:610:1bc::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.39; Mon, 4 Mar
 2024 13:05:17 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::97a0:a2a2:315e:7aff]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::97a0:a2a2:315e:7aff%4]) with mapi id 15.20.7339.035; Mon, 4 Mar 2024
 13:05:17 +0000
From: John Garry <john.g.garry@oracle.com>
To: djwong@kernel.org, hch@lst.de, viro@zeniv.linux.org.uk, brauner@kernel.org,
        jack@suse.cz, chandan.babu@oracle.com, david@fromorbit.com,
        axboe@kernel.dk
Cc: martin.petersen@oracle.com, linux-kernel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        tytso@mit.edu, jbongio@google.com, ojaswin@linux.ibm.com,
        ritesh.list@gmail.com, linux-block@vger.kernel.org,
        John Garry <john.g.garry@oracle.com>
Subject: [PATCH v2 09/14] fs: Add FS_XFLAG_ATOMICWRITES flag
Date: Mon,  4 Mar 2024 13:04:23 +0000
Message-Id: <20240304130428.13026-10-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20240304130428.13026-1-john.g.garry@oracle.com>
References: <20240304130428.13026-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY3PR03CA0015.namprd03.prod.outlook.com
 (2603:10b6:a03:39a::20) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|CH3PR10MB7805:EE_
X-MS-Office365-Filtering-Correlation-Id: 864638a3-0828-402f-8846-08dc3c4bbce5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	JUpsY5Rfm9Ch9246VzLAxbGP8gKFdvKDFH4QwdtJPGAMWbm1jbE1tW5TTS2DsKr2nspCbMeVstftHiAe2gkF85K/sek8/MgcsbPokou+La30ZsdTGm5VHK/qQF/2sNjh3+5/37wx2lWQayDiuhPMQn81WtuMt7Nh8E9H03KS07/c+vY6zz8TvAkiaj13SDyBA/Pli6MBe6aEw08ywrpjylUi+Xl4Vj+Wj+j1AD4LyZJz20kiNcB0DZqPuPDcgXge9O5g53DfU73fDmC8uys0In7iJ3+UwBB40QfEtEVv4SKaRzGRVx10fSAl4dMu9P59OcHjHOTX6l/99kVtglwVXZicA685VCLYIQbaukbZgNd8ns4NXz/kEkGNVJq+UtYjXWyvBsSMGr5kySTA6+LwTghkeIF0PL+GNSwkwIYT1mQ2Av4ttC4uFLg48lyE1cuN/akWXJfQt1e1bTdS8t5iTaZFcNklMKWv6q5hWgGHZatvZSu3q+UIP+4QbNw0gP307jnS2O7f/oKubqklnDVyc50+2gTNIV+DUyehBFnXnuIMNtoILJvjy5SfQZO+W6ZnTLbm42tf0v+WQaiyYSnyLgAOwnV8Ng7fP9XULrOR2+yE4gqI/xeAo4gK8Mbo6uI8DQ51sDs6VRxQgAuEBU0qVfd82230ji67+R+dTgG5Zco=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?VkToH13b5Zomn0BPSTdi/x2oA3xhrW+Z2iKKO+p0V8ZdreprB7t626DRvVbY?=
 =?us-ascii?Q?XuxQuyh7RGIepi3p10xjjnDS1zoXlRBs09w3HZoLUINlZeHMg33ajRiEsObT?=
 =?us-ascii?Q?GloY9h5+RJZrgJ9QhqGI1et0eyYYLk5lSkJi8x8nGjZM/DChYnWiVJ4L+J3r?=
 =?us-ascii?Q?EJtJiG15DrOZ3vnVboHkOiOwqlQaxTaqxvhadusgwkxcVNGCAPRiXRJrc6zq?=
 =?us-ascii?Q?jtxDDWLlkDz7wo/uTHtZBUfaB9yg8PAgcE5QhvC0tzP40u+syoz8nBxvEVp/?=
 =?us-ascii?Q?SQESaZg8j2/EnlC37xLsx0yV0DTlJ1LpdDsSB363L4tbfurGInJGEMFF9Ouh?=
 =?us-ascii?Q?l/cRJjx/g6r50vDr6r78ty+fHvKqvngkAkGwaH7DQdD+zIVPWcgmXSfA3CfG?=
 =?us-ascii?Q?zqIUUgFhGsWRhoXARSkJ/M1umorUfgoanZ9ckW13NQfEQS50zVyXjA3d1v2o?=
 =?us-ascii?Q?cEgAgCWVwzkdY4GP04eVjQzpS/OMYowodOZwbk/TG52tb8/dQkOMm9MQUZtM?=
 =?us-ascii?Q?QHxFd6eF91BKS85ZQoqFELj+Tn32upEprg2HJ6teNCOA9Rd2F0YdPaxpGRiE?=
 =?us-ascii?Q?zNsmnA13FSXL2HAtEEDJQgxYR+OTehjvyV4mrO7eLLszJlfwr4/4l0cPeD5b?=
 =?us-ascii?Q?oKQCfpeuoxC9BdjI5wBuQgNu9pe0a3eFsoQL5f32usw8JGD5C5XOYwdl2pW6?=
 =?us-ascii?Q?PFXiCAFQPJSJ1kKCtqAqumoU7RzdOrALRQKPB+2OjaIsOuoFYFn1btMJLkAl?=
 =?us-ascii?Q?VTFKQAFORfRZOrqLSE7ZoHqsCTPmEZGVAdyPEo36+CRid1/q9oISEwL+TAs/?=
 =?us-ascii?Q?Zd5PB4DWsWVRy7RA/irPeYfIBYqTFybIu6gsJJVW9hZyKdoFrjdOciuefjCR?=
 =?us-ascii?Q?XUbjH2Hv1fBA2kmCeLzwPbgKabvJNtRFM6oXaLInwSwBx74Dk6sEuMCEMxhE?=
 =?us-ascii?Q?CVa9JZVJKLGQogIUiqg61NqXtN/HI4CJFa735Y8bluyu+eubLAEyMDfaec7n?=
 =?us-ascii?Q?3i82j+BaLuBUAjNW2VJsOIGA9BIKoQDlCQHhytmtrSWC1jlGt6CQYwAFhfnO?=
 =?us-ascii?Q?MXrb+Zn8LzURw+YCcq2Fbt38/kaNwcQ3Ofo/bVHttdgMwRAAA8U2DaRWxF4U?=
 =?us-ascii?Q?otsbKOpu1Obr+a96V/PQSYwzBirmoqGLEqRg43AvZGSMMHcsT49d9Jfi8JBA?=
 =?us-ascii?Q?V6hK1nQC73RIkP6kSJwHtQvlZCYPf26fkn2AMxqbNSXc7ctE31OcKdovTaHh?=
 =?us-ascii?Q?/FhfIHXvHYPI8IfZoIwWvy0AwAf+ec0BJi6VE4hBgynseZvFxPb8NkROKJpA?=
 =?us-ascii?Q?1mIwCrw8KJoAVwd5eLzsTPwBw3hsNhif1a1KxM8YyC4n33Yo58n3zdkl9e3P?=
 =?us-ascii?Q?1TaQ/5GxLvBnIqlJPlD7613Y3mPEexXHvixejoiwjElOdKbNW3QBOEEDT3HC?=
 =?us-ascii?Q?g0yctKb+atu3S+I5z/gGKAML5FNTYO2T21leFzx+R495Y99E0FOmZgjZqvw4?=
 =?us-ascii?Q?bJoTg1eI+B1xTmOv/PvECzZF5i8YLSWDz3yPjzZuTFrqHfpgm+kQOSww5RO6?=
 =?us-ascii?Q?+kksKj/CkzCFMbE6nqF6AvT51eDzu5x5SZZRyiRVElHExkghlIELxJmfRxXx?=
 =?us-ascii?Q?3g=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	Z14VK4dpgMM2bB2VWVgDETVWBcwKf+AcH9e02oxybv1f195cgWX5OtimGp4m1ye8RCmJP2z142DVzFHqhCarhk51fIDWAhxqgTDLzgjYiU8ZXwe4lnN+W8aYIr4enSSPGOIE/daeBQwGuh2QjpGWJyCc9cMw7ZSPFgwKDV/YWoIyr3k208OcUfpvt9SIQavaqgToSdyr4PTUf73F5XfTIDtxiDOqguT11Rv5aDzCY4WJzzNLUf7sapGiAjt4Z7VLbRKbmj7ZDbesbbLHKZ0u9ruiWkVRWZFvuiubfWzV3c/GMVt1QOWgh9zWT1P0PtRpDliucGVMYsyn23z++FlpRqehHvP/SoXmz/YNQsnwpZJd0oOhfrNGO5Hs/FsWzRju+YnhOmu++dPGODSk1iNPrTBJe7rcGTo3eUxOQN+EfEw/HFi63dWAwQcwkMikeXDCSOopVch2Z9Q8agKFw404ZD6AEKNbZZ15bUV7T8hZZ9sS/EK0m3iYD8OZfLu3YAhzZoE1Dx+8zCU0RAn07BBz4j1U0koIFUIIPHosjtuyHupaOeRGzENNsjvB5DCOn+PCUV7TfesC1PzA5/JKcy/OrYMXM1c6pxz5di/Qfnvbsdo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 864638a3-0828-402f-8846-08dc3c4bbce5
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2024 13:05:17.0289
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oLfT69SeyeN1ZlNthLoPhbTmhkocGyqLCatcYap+L274A3PmUbnBEKYzA5BqT3a8Naw5tmg6/LPE4W/IQ/+YRg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7805
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-04_09,2024-03-04_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0 mlxscore=0
 spamscore=0 phishscore=0 suspectscore=0 malwarescore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2403040098
X-Proofpoint-ORIG-GUID: DtBp3BB9H2BKAKNeFeKDzOWsE1LfBMJC
X-Proofpoint-GUID: DtBp3BB9H2BKAKNeFeKDzOWsE1LfBMJC

Add a flag indicating that a regular file is enabled for atomic writes.

This is a file attribute that mirrors an ondisk inode flag.  Actual support
for untorn file writes (for now) depends on both the iflag and the
underlying storage devices, which we can only really check at statx and
pwritev2() time.  This is the same story as FS_XFLAG_DAX, which signals to
the fs that we should try to enable the fsdax IO path on the file (instead
of the regular page cache), but applications have to query STAT_ATTR_DAX
to find out if they really got that IO path.

Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 include/uapi/linux/fs.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/uapi/linux/fs.h b/include/uapi/linux/fs.h
index 8828822331bf..aacf54381718 100644
--- a/include/uapi/linux/fs.h
+++ b/include/uapi/linux/fs.h
@@ -142,6 +142,7 @@ struct fsxattr {
 #define FS_XFLAG_COWEXTSIZE	0x00010000	/* CoW extent size allocator hint */
 /* data extent mappings for regular files must be aligned to extent size hint */
 #define FS_XFLAG_FORCEALIGN	0x00020000
+#define FS_XFLAG_ATOMICWRITES	0x00040000	/* atomic writes enabled */
 #define FS_XFLAG_HASATTR	0x80000000	/* no DIFLAG for this	*/
 
 /* the read-only stuff doesn't really belong here, but any other place is
-- 
2.31.1



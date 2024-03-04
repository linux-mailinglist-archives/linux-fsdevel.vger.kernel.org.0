Return-Path: <linux-fsdevel+bounces-13460-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 854D587021B
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Mar 2024 14:06:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F09A71F2200F
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Mar 2024 13:06:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 248373FB32;
	Mon,  4 Mar 2024 13:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="midsimd9";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="CVzzcK6R"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E0C73F9D8;
	Mon,  4 Mar 2024 13:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709557528; cv=fail; b=L2cgqZr1KuSij7YM8Af1EYXNzweMIbXQrJzXoDfCRbQ2FW0nnWsgubVa+nZ7Cqfshhqx3uYyvWwuaZ3rSSgCEa35gw3glPD+kl+5POhGWbGCkmFYYuRUwzwCot7L+CPOW3tW9A2jFv/8THpijosFesb4e4tSBZ/3cQzzIHPFjus=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709557528; c=relaxed/simple;
	bh=YfCQkGo8Sa28f9cFWhZG2xqcjNQ842ZhnnpGaJeF3m0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Mk87DOhjYthPbCLCmxqODwQ5iEWa0bdySndprq3bEU9mV2gwsnx8TdcEe6wvggwulJIestnMifZFW0mofkWid5uXevbWae1SRVH3YAu9XR09zyKzvMM6n1rVmDP25mjrdXWoy3/NKHb39usV1rVWyLpSw4eoOvYcWX8kYE/x4dQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=midsimd9; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=CVzzcK6R; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 424BTn6a028533;
	Mon, 4 Mar 2024 13:05:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-11-20; bh=U2oPilzhUsywLH65SAAkAkfeC/dSuW+Ee9zFAGHRaQc=;
 b=midsimd9PKsoQDdUrJN5wiG4bvzT8eQE3fpZX6+0/J67pVtJbeQ2fdLDCCg/O5OhuPoW
 /YwpqXdGlAYNyi940RuHKvAoTZVacZ0Y+TsQWyxJL8kd0Y4ti/d8PgfqXGwVI+VlwrW2
 iOMYJQbADhFMl5TH7wqT1UoaDWD3Ev1GBbVT6jM2zwOlSOQ1wmAHEOexx9KGfgUOR21H
 WNYIjNo2KRJ6LN5W5CW4X2LJckHqO52BpStuf+rdDx1iHLPSHwcjolqRmYGL4QW7L5jR
 yulkGOW9PZxs7Uaucw9GCmjdbBEULsk6YrM0PigU+gZU6cmQNgctr4Oa5y21YI9biajQ pA== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wkvnuufa8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 04 Mar 2024 13:05:11 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 424Co7YV033255;
	Mon, 4 Mar 2024 13:05:11 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3wktj63tck-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 04 Mar 2024 13:05:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aGcyq3LdHLISXz8nzF8vLM7VpuG+huOeqdnG47xHQqe7bQ/vkBZ2t/RKyiTNeMXzaruP/Ih/LLfU6vaBLJ1izbdayKuYaU9zfWwbQrSMsW7TBJqMt6a/+UtsxsFNUnuZA/CC9UbkuYQ4opCc6BKNEyg2vqmaNbL2lo4DLhu4/+S7ok+C52WZ+sqe5BeYM6naIXntix6iN5wwNQV4Te9IABYoik9HqZk4xVLfsXaA+0a/sOu69VLwPhszsaDktR3OXfX2s7b0fH7t5HEPfwCzX7KRf+oFMn9yBJA7t/9yYP0dJ/fBo/KHM0qlWXlc25drChXP49Gb7zZMoydeuxW+1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U2oPilzhUsywLH65SAAkAkfeC/dSuW+Ee9zFAGHRaQc=;
 b=DTVcfKmNPAa4eVPfAX3t0q6Vi02/XrmhIx0NC7MGJ6Ouc2DZjadP7/UrS/fMx+zGSbIHxEpFtDLfjGHZAvpgE08cdzHl23Yd+T8b76kAwTPGiBBZNRRykMd5nAVXRTWZ17g0Qm+cyutB3sqofsAPGCXqn5aOqd2trGmjd35hkaNZ3HzQYFzEiCTwA1QcRELmXKt/tsLapvbEVknEFIQei4+2Vy74KkwZN2bDuv8TWE1W/bVtlRCUiqtqjaZIbaJOjS73hYgZnfZ1E+8DrlAoUe/SaVphNJBkwQJEe5HqoP+odXocLPLLgrQrnMa15tar0VGXT56gYzO+KVnS4S4j+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U2oPilzhUsywLH65SAAkAkfeC/dSuW+Ee9zFAGHRaQc=;
 b=CVzzcK6RBJtn4FBgWt9t+NPrH08M8u1qU17h+SB26KSSaM/9gUbqwK8d00ANe03gsYZi/ZaIRkRvoJS0dkWCJwtDaV2rm0MhCtX1eLTjbyq6CQ6Oh1hGtH1MDdtUJtGUSo7OmJe4jyIYmG4+o/SdNtwEbajVQNmvRkaDcdUvhcw=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by CH3PR10MB7805.namprd10.prod.outlook.com (2603:10b6:610:1bc::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.39; Mon, 4 Mar
 2024 13:05:08 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::97a0:a2a2:315e:7aff]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::97a0:a2a2:315e:7aff%4]) with mapi id 15.20.7339.035; Mon, 4 Mar 2024
 13:05:08 +0000
From: John Garry <john.g.garry@oracle.com>
To: djwong@kernel.org, hch@lst.de, viro@zeniv.linux.org.uk, brauner@kernel.org,
        jack@suse.cz, chandan.babu@oracle.com, david@fromorbit.com,
        axboe@kernel.dk
Cc: martin.petersen@oracle.com, linux-kernel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        tytso@mit.edu, jbongio@google.com, ojaswin@linux.ibm.com,
        ritesh.list@gmail.com, linux-block@vger.kernel.org,
        John Garry <john.g.garry@oracle.com>
Subject: [PATCH v2 05/14] fs: xfs: Enable file data forcealign feature
Date: Mon,  4 Mar 2024 13:04:19 +0000
Message-Id: <20240304130428.13026-6-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20240304130428.13026-1-john.g.garry@oracle.com>
References: <20240304130428.13026-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0141.namprd13.prod.outlook.com
 (2603:10b6:a03:2c6::26) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|CH3PR10MB7805:EE_
X-MS-Office365-Filtering-Correlation-Id: 55e487be-6b79-49c4-159b-08dc3c4bb7cc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	H1g+TKLVG6h/0paHN/OJ+GhHfiN4yHNeRosrIt/6szCzB9z6ZQ8XzAsmLkbtE3/Ab41Y/b+uiu5k9h2y/K4CEGRfBVYUB+RDnJ8PC1cuiJpsXpkWtt4QovSP5ygVcb6LZdNAO+4GB9HpP566j723d0dvDR78voZjuGIj+yM1ZeutFHzVgqCt+DVpSEumCIjmMhGuv8cJTCeBruJ8ytrzOfZJ/0gggelSgHdsTOfKeTIgEmK0XjpwiAQnjsnqW616zuZEYYgBgGq8QQbiFByg53iNJrKnwJe1iPxcOusLuubeqqCYG08oV9R1hQLfg0gwTuvUGZpOiSCbKVeUSyqSPk8l1KZBHR6QM1eIkVAhzYgeKYrdwonckWNDpM07HoOGr6mxohe6yizS3r5kK+zJL/vYdwLJqSybbUTih1YI07Dvj6iw4f6F4AxiLiKx6DV1K8t1aIXkUWTiUbULFbv4KZDlEoxaQhPazonX7FKZvGa8EP0FEwRogZy9iNkUOKGjX5ACc9UT6hzRGngVnzIFQK/iFquKQNBr1NXtPqb3gT7AvF4ztHjqkVj+iN1Q63XkFGiJChR4HmoaJuehFvpcrEftr8r+nRceCMu8bwi1RuaJ8iGleVXodCjVfepUNMLyH+G4UmC5xfRS/kzrc0Drttm6BKp+uCMPvgR5YCVSaCI=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?IIBDkv72Z8uMzUUhcxDhlnb7y7cagVTjvs5dz8ONy8XChIOP732tadeRZtCC?=
 =?us-ascii?Q?tXBPWFq/H/D69+Ba4e0YMyXsybPXwkO2ApMSvzafFWw1lOSItotfHrIt/HTH?=
 =?us-ascii?Q?sX15s2L5wY1oh8T3qbPpT+fUZ6ycItQ/bOHXMj+eV4xwDntxmKuqf88kulgn?=
 =?us-ascii?Q?aRGjG5U62mqZBQRmICHlCMb0uA3aqcnlTmC0LB9Tr2Mgr+aI3dkGeyAH53hZ?=
 =?us-ascii?Q?g3ikXf+S8AG4lMOOLLLWuqN0SkmyWgiH9J5LmA7AxDZ/iv7yw1OIevIIVH02?=
 =?us-ascii?Q?XckQNUJHQIgjZlI5YplY6WUk3Z7uRHr+0H10qEablc+mEgbIGFEUs9lqYWad?=
 =?us-ascii?Q?ai4ooucxqg1LfEmGGQGuXMWCp5LdrZhvwNuywN2C9sScg5+r5QJX19YG8i+B?=
 =?us-ascii?Q?f524UhNZApRspGOOgPVjFiH9/3qFNla6YBZMjbiDKfxAbLpQHcGKIb5BhYDl?=
 =?us-ascii?Q?5/EFtvoHu2lHG9A1glC5ytO24wR2FXMyu4dNIiBPGxrFe5gdwyMOFr+gnGNL?=
 =?us-ascii?Q?wkgQisUwIufA14TQYLrN37hP+u14HIXsqmUX3XU8kSxOkmnwyj6zMbZtGqUg?=
 =?us-ascii?Q?S4yLrgaTQZPN4OCMFY2+wXWjCAwyru3DujEUcB+rn+HPOemnOY2z1q8ghoCa?=
 =?us-ascii?Q?PcpL6gzQxDPAuDAwnhrLzUXvpjjjY0ZUCpy6a+/zasqygG4UgyEjbpUlvVSV?=
 =?us-ascii?Q?4b5cepj+6Yosq9WErANWifZtDOXc+flGYYt9081mXsTX3QIFxw4nQSp384Y0?=
 =?us-ascii?Q?wzydILq6DP7DBxN3w5e5rkxlx1FjyUFx5m86AB+2XlTXnqV2vDT0R3A+8R8z?=
 =?us-ascii?Q?88SG7ZooOYA3mEarTGliNFLvoiS0RsDaF7VeFTqx3C0B9/vA+3KDOXVHBMnG?=
 =?us-ascii?Q?MGRIY9kaq2RcX2x9Tua7+0Pt5A2EndJOlM3/yvSOGqO311nzzcdewaB5i3SU?=
 =?us-ascii?Q?/V3Q7Mm0uPaZFsH+90moBSW+RggCJ8al8nAlnx2WnhDCzBvFqbB8wI/gVB9T?=
 =?us-ascii?Q?f4oV8224TloGWW3BneCLwufszjGMbJzR372+Ga1oGLDOnSyGjIonwDgSc42D?=
 =?us-ascii?Q?uSIH1iYKhvm3mj3wzrdsRVZq2K4hDQ6M5vgXMDXUfW+eZBGnriU7wFqsCX+P?=
 =?us-ascii?Q?0aQ8hZO2Y6ny+EK3GyPxDhJpc0hmGszmMe3gOOGsPG17sYk9F6gJvHfDnqwe?=
 =?us-ascii?Q?K/bEEV0SQY1VKETi7XMu6Cww5MthR8Y2QPDRjcrFreTVGfw9b9Bz3+7ttHZ/?=
 =?us-ascii?Q?DJUSCVMyF7O7R1lbVBM9ONL+RR0wmsYVmdFqPPDQgwCyRmgKKf/sEagSwxBF?=
 =?us-ascii?Q?2mAOl06FioP6w+tSbfGJpggTar0lrzrITv9PzgisriujIl5HFvD2FnAbhVnT?=
 =?us-ascii?Q?Drly26CCtp8z6a3rbOjf5VMB0M9VmarJ+jIVI1pTOrbz5YjcSn1eFf9WPEhl?=
 =?us-ascii?Q?np5V+S4HynqB0zcIC8kb0Mq8ES0Z0kop3mv1qF2LCeh+twwU2N/J7ZYAPxrU?=
 =?us-ascii?Q?fMgOvZcXchdAN4Fz+5/gJ2TfqqaP2iah8wlv/BafxUyQi4dNUWt6+Kv1yU/i?=
 =?us-ascii?Q?l6d2jMdkDoqzmBx0vGYc3+6NpJN98wre1TfBjq/YGUAL04uWwi70o0xO+ro3?=
 =?us-ascii?Q?uA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	MdK4PYKLYs1eSvoxrZmA2PdKB50GlcfqGYQ0N6j73qZUemKPj7uRG+S4KdiL3Q4feSRI3Fj9VpmpuOXyZ0u2MYdokc0Vj4qMtno1rdvoadYVvrpnlRDRcZ1mtLpUkRUGX+mAi7KNLQLIXxUo6oYTs6/8GTpn6D3Qt044JyXG09iZA9yf5WATF5ywvXm4XkqZ2fL6lI6gRqze0zaTOp+uD1Hf/jEitCfYLYLMniEHDlTBnnQngeOa4hMO87PjlVtANYtfSZwRhaZgetXxH/5nE183nJhcUJsoEP8y84sFftCobwm3Uq6t4p8z91jQ2JQ0j6SEmEGNlp+XPdgjkkugcoIUlzxKyhtEHQM8Bz1tFbqFM4lRuQoVd5l3rowLcC2sL3LW/91fI3lr0/qqaD813kR7BmsG2MF6Mxy+6bLv3juoKxdF3MsgK9rmW11ODDxXR6S7bxA9HuamuM6Spy9G13bZEGLmZjGvItEkcp3ICTrmWiFs4OJZ5QAIVwWLTg1BmONz/4FTnDnSHIiXyvpKrNcSjmm0d5EPcY8zhd0/g4PfEis1XN9qywaZgPLaBcg7wJQC8vrsYNOodlQkbSrY4NX4gGMes621Sk30JvaOI1A=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 55e487be-6b79-49c4-159b-08dc3c4bb7cc
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2024 13:05:08.4719
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WCljqvTs7JQKRDtD7ufXF8haB70BPzxxZS2AwAdiqI0rwhNuzrY/j/4U2rY4SeiM4XPMQ8wqvnnqtYawjHBqxw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7805
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-04_09,2024-03-04_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999
 suspectscore=0 adultscore=0 bulkscore=0 malwarescore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2403040098
X-Proofpoint-ORIG-GUID: 3lo-OPO1Qfd9JdtykVSTkSaURmSSibXa
X-Proofpoint-GUID: 3lo-OPO1Qfd9JdtykVSTkSaURmSSibXa

From: "Darrick J. Wong" <djwong@kernel.org>

Enable this feature.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 fs/xfs/libxfs/xfs_format.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/xfs/libxfs/xfs_format.h b/fs/xfs/libxfs/xfs_format.h
index db2113cf6e47..2d9f5430efc3 100644
--- a/fs/xfs/libxfs/xfs_format.h
+++ b/fs/xfs/libxfs/xfs_format.h
@@ -358,7 +358,8 @@ xfs_sb_has_compat_feature(
 		(XFS_SB_FEAT_RO_COMPAT_FINOBT | \
 		 XFS_SB_FEAT_RO_COMPAT_RMAPBT | \
 		 XFS_SB_FEAT_RO_COMPAT_REFLINK| \
-		 XFS_SB_FEAT_RO_COMPAT_INOBTCNT)
+		 XFS_SB_FEAT_RO_COMPAT_INOBTCNT | \
+		 XFS_SB_FEAT_RO_COMPAT_FORCEALIGN)
 #define XFS_SB_FEAT_RO_COMPAT_UNKNOWN	~XFS_SB_FEAT_RO_COMPAT_ALL
 static inline bool
 xfs_sb_has_ro_compat_feature(
-- 
2.31.1



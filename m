Return-Path: <linux-fsdevel+bounces-25799-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A33EA950A53
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Aug 2024 18:38:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 232471F23467
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Aug 2024 16:38:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF9481A3BD9;
	Tue, 13 Aug 2024 16:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="SbNx4PYu";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="NRqVEukx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 705181A38FE;
	Tue, 13 Aug 2024 16:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723567033; cv=fail; b=oMhoCriygau4don6DjM/TbUYfj2n3BcGbggzKFQ+Zx9qJp7p8bncN5dHGl0Uq6VC03qu4YU/sWyLJUwIQihWkYutMKyoUrL8MQ+IPUawuFM0EQDSv8oc0MtWUsynUhFdIWytwSa4haIFO1lDId3jmNZWMtHiRERXl3iltfcKDh4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723567033; c=relaxed/simple;
	bh=Ib2HHk/yTuVdz4dw2DPmbyIXO6Y+gsfiEIU6NeveZ6M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=h6jLTrJmc/JPulfDihGfD56/thgJcQROzh9EACAlBJs+o4CcegHLoG3GTD1kC0/QFndV2FWVz8XN4snvMiOOMKpyrrv3kn37bwPaqOWofjOWLfoUQXpqFrlCwfUefdcA10OSHDUSZsHYbxGQUuiWSQ/dWVyGWhiFc2qLfwk1ZEk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=SbNx4PYu; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=NRqVEukx; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47DGBVuq002879;
	Tue, 13 Aug 2024 16:36:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:content-transfer-encoding:content-type:mime-version; s=
	corp-2023-11-20; bh=/qGtRo1kUwZOp4SUJ/OyBt8SlWcPF46XhO9BSs6+/Rc=; b=
	SbNx4PYuDe0PlPOE/ENPn4jUOopIadcLWD6iKzpPQ0R1dmWErz8/ZZlfWmcfjY9d
	NSUedeDvLtlEUKcxttmFLiFVV1cPMmfQ6NIQtLwWC3CUsFqY8xxzijzpMxcLdKjY
	K4QIBeQFjkv/xIbr1gdp8UdXSCYn1ZIFvet4s0ySf6Fc1InjfnfdMDDIDId9F2bo
	xl/JwFRzGeK46kXKjLyQVzUXV40kth5suzAkYKXeyg686s2ycSFlKZBpCHSL8IkX
	RUIPLQTNCrSPYrULl/R29zJhGZt4n9PmloiyY8sDcvw4l7EBG0raupwdyo/RkzIV
	wRJfjLv3+L0NyHngrEawWQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40x0rtpf7q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 13 Aug 2024 16:36:57 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 47DG94Wi017631;
	Tue, 13 Aug 2024 16:36:56 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 40wxn9pdey-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 13 Aug 2024 16:36:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RgTkx25AeLjSExTO8NMDZN90CQJMIswz0Y3eLhH0+DJmSg5vPkNBv8F004PIFsIqV2ZvTYOlD5onkSCHEK/UPdXEu1WjOc4aoUxoUMqanYKFmqkbEG7NjReKl/S6HfLJTdHEVl6qs9g6qxLv+DF6GH9iAgLwVojPxkzXHsGP9YCSona5M/2Vg2T9ZIUAi1HgZJYX1qyJy+kkjluHLRnRdGYqXYO92ngg/l3wNTyovLrCbA3GkErZf9jY10YzUwMZRrvcQnx8Q/sPTt6KwH+VQ9M37RSQkZDk8cuuteuKP2XNCJKrzLd6EapafSvvEzTsHoOqVeP45cFPRHscXlSk3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/qGtRo1kUwZOp4SUJ/OyBt8SlWcPF46XhO9BSs6+/Rc=;
 b=GN76wfBJZ/wrdqsJOFX1mmaJb1zqAyfYRnEXUvGpPzQ8SArXzbHBDAJIsA1RVi2jmnXvK0HjXDBc+98++wHeU/0IrujrN582UpL9IzAGXhB3VzJNMa972GWYO0I4fh/sRPVk3w8/cxGaHYRbLEHvNdarPSsgDYX6yYLreHvkZkbeWbd8DgKiaCyuNl4bAKXfHbDGaVDp8poZfTmJa37HDHWfZ60wiAia3RfIQTjT1AZGXehdtqXBpEH734OdvKnuuXp10bRRUIzyIXBdExC/p8Ro3mv50zQ2xB7Mn4f0XI+dO/gupiGDaqngbgL0x5vjY6VbPrlU6kDPTJqPrK71iA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/qGtRo1kUwZOp4SUJ/OyBt8SlWcPF46XhO9BSs6+/Rc=;
 b=NRqVEukx4Jjac6c9XOKBY8J10nhcBYi0vGips/1GYLxUtU1kf1b2/Bo7scEz/CJkwoILZT52MW5rh2iFLLCI3DWG7jv2WtFG2l+zwRaDy3nkQTaZ+wrkK0DjRLcNWbQ2xRbVgLT/GIJ9uHoh6DT1QXy5s9s6/QoPb7C27Yt5saw=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by PH7PR10MB5747.namprd10.prod.outlook.com (2603:10b6:510:127::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.13; Tue, 13 Aug
 2024 16:36:53 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%7]) with mapi id 15.20.7875.015; Tue, 13 Aug 2024
 16:36:52 +0000
From: John Garry <john.g.garry@oracle.com>
To: chandan.babu@oracle.com, djwong@kernel.org, dchinner@redhat.com,
        hch@lst.de
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz,
        linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, catherine.hoang@oracle.com,
        martin.petersen@oracle.com, John Garry <john.g.garry@oracle.com>
Subject: [PATCH v4 03/14] xfs: simplify extent allocation alignment
Date: Tue, 13 Aug 2024 16:36:27 +0000
Message-Id: <20240813163638.3751939-4-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20240813163638.3751939-1-john.g.garry@oracle.com>
References: <20240813163638.3751939-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY3PR05CA0001.namprd05.prod.outlook.com
 (2603:10b6:a03:254::6) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|PH7PR10MB5747:EE_
X-MS-Office365-Filtering-Correlation-Id: 2898a4d0-8717-4de5-148e-08dcbbb622f2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?SEzPhPovtYX3+G0Ux65Dfuz1nue12Yu9oFoT1/iHxvR7WBV3glLMQ+COPSxF?=
 =?us-ascii?Q?MLFee/wYQCTkqOWIyJiXqDbbd6IEHjmvPyt5Jb6mR5RU6HyByYoH7teGgS7H?=
 =?us-ascii?Q?FPIBBLSb59/IsrhTlkqxDsTJH26NH3VZ5BbaP3vNP/9dHPF2sA15Oa+AcO46?=
 =?us-ascii?Q?B0cp08BPp0E/aZW8Jz0OFcL7blJUhMpwFGSk/h08wORY95+tAOVA8jyrXIEr?=
 =?us-ascii?Q?DwygLZvQRgFM3QxSWMnlBq7eyIxPXBjQEqV4WHVFkFMOx2q4AGZI+DZkNkou?=
 =?us-ascii?Q?9M7+EtIVuebTHWx2I1tyfUrZdiTEQLOw+HT8wYlrdFU7HfMUqXikO0zljpLj?=
 =?us-ascii?Q?zOSDujp6TKaTzwj2BQAXRtsBnoQIkgP+BiLl0SUTPQvgD1pbj6yEU85qaJxE?=
 =?us-ascii?Q?TopxxM7a1uAD5u+sZo9ILRmisnua+QROKSzMBNhon782nL0MYhAplTqs47iU?=
 =?us-ascii?Q?g71vqGO19bWlWooBHrEiVlyfluX47HAZw9dFAXPkvkPbD4rqpSSVMgGupy5D?=
 =?us-ascii?Q?8CuWom9BoyA/5k6KXgP8DAmludUUd3JZLd6Tn4GiWAVt8IJibzYqMX9YhBw3?=
 =?us-ascii?Q?OkmPuqbJTFqcFSEix6soWV0qMjLGda+pKOO/han0w/nq46JY8u6O38XZiImA?=
 =?us-ascii?Q?43UyJFSJeBtg6Dal58GW0NHGka6uvX4epcXj+p/2XF/PptJNXCotGKGtL27i?=
 =?us-ascii?Q?Y98M1j9x8YoDOJVGk9cUSmbBQMPjMDYB1h7BaHhF4SxFI3H9Cw7yGRHllWqq?=
 =?us-ascii?Q?ckcoTA88ey1QscSexb5EM4kX290rZDYFc08Q7JvsaYteuZN7DxJ0bpKQ3BEO?=
 =?us-ascii?Q?2F0IF4iD84j5BNjG3E8ralkrlsm0FVSucNAIAbQfloTijLQ7vo4DIq3MZ+zs?=
 =?us-ascii?Q?vJThrneFEtir6TaouAFz5k7qcOWiS0ydVKwIYTZu/5o5iwNrwymvDgCYgHXq?=
 =?us-ascii?Q?P107AmMNZNYYiPMujoOdhG9LC8oziHHmGCe8RTiMmthrH6y/qp3Kvx3q7y4/?=
 =?us-ascii?Q?sHNlR22EzCAWKmCeMer5rW3IQnKUfnWnWcsOfyH6HQfVrOzMwpLIsMB8VSld?=
 =?us-ascii?Q?Fdt2Xg3FZIYpFAN8+o/4aG3eGebMFFrSPctXHVgakgsaGYGU6PEHadu5iTpT?=
 =?us-ascii?Q?QpAW5x9XpISQCFey6MH/tB+pIM7jX3WEIMWFDGpe2LISGdpgn4mrqekjYosV?=
 =?us-ascii?Q?y5WgUKOdxHvP/XbnEs4dtvKjHpmDqud4kZKPmY2XUNRvPxscwSyYvpL2yEom?=
 =?us-ascii?Q?CEzQ8iaPNAJ2Q3iKuk/ockvWSg9F3epvK1Nmdo3eGemTDsrG1s5CTNQNYjR1?=
 =?us-ascii?Q?Q52aXElMnRMDNR0cUjcVsuhFYq3E6NmAhl3AIW6nrdURIA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?TWj3KyKAZb5d8Bl0bQQnHxeXh5LBPDylCXhMBa0Cr+yHN16ySStfH3FSEJ2A?=
 =?us-ascii?Q?Ck/CFclyT+R69qbDYRdRSmce4PyulC6efXLI6wRlxZFbqOURgF2qPWQHGPRv?=
 =?us-ascii?Q?RztmJ52AsDgaic62cLpjHTsfOxH2loFAGf/J76IBj8E81QqYt+XdSOQY3biJ?=
 =?us-ascii?Q?peoXX1eD+GsIF0dDY+Ho5bKSR6+xMu7aGkxPqW6JI0zhXz6Iu0fMGw87PLTm?=
 =?us-ascii?Q?lIvAKwfaNn3n1aWPUxIJTPNRH4Xj7l1p7Pko3M2HZajVttGQKYRVyR4c9ghU?=
 =?us-ascii?Q?lHswzpS+lzVcYJtF6Ipd4v5bxgcRYvtj/4OvrJKrn4TQAEO0xhPpDD25/5Uj?=
 =?us-ascii?Q?DvIJpiVClhnTB6GZiqAO6HA1ag3b0kKSTU4IwToHcxf3+Tcs5ljAH/GwO348?=
 =?us-ascii?Q?9heMqnBxRY6ZAEJ5fg2QMLFx1ODOF9DjKqDnPrf4lltIMrCunWaewTv046eX?=
 =?us-ascii?Q?ld0d5VNxScAMYSEe6qFYCcZAqRnjLiQBUmWoxsvN3SAkm0qYlpdJCFGrtO5k?=
 =?us-ascii?Q?+fLKNEGX6uceketI0lWuQ/tIHD+naf7lV0YFOnqsjnwOb1YPgZSmABPXJ9cW?=
 =?us-ascii?Q?CpIQpAv6gfyJCAKO+JPNRiQXim5Ni0rZWiPOXbOK9RYdE76jzHlEZ8CpI9ug?=
 =?us-ascii?Q?t34OoF3yzUJo+FDBAlrhyLRbjqcLMNfBNqtaE1poig/kNCAtNHySYCBY6OiQ?=
 =?us-ascii?Q?9EifA3y4/lKQYbhxkDfV3XlrEtqswylbhbdb1wHSB2/AhjkAZKOYfxJefLOV?=
 =?us-ascii?Q?VaK+dman3etXdBae8XEZ1yyN7WdnrK44+/1CbVaPwFjGqvfgJjEKi3aCicZu?=
 =?us-ascii?Q?vXt1a1rZjdPdXvfVPRKJzGYkTo0AScMlbzkq24N+8J0w4zDCZMrbkBJ2XmQ4?=
 =?us-ascii?Q?Z4jrNqcwipiZ6KUtj/8tmI6YHSCfsPAVPWvyxAgwb7QW6m9reyI3c9a13+ti?=
 =?us-ascii?Q?IyH+3ej2SxoCgzqaKJJUL1HpNKV+W7a/aTImgMA5tuEi8g9EcZ/nP4DvnDsH?=
 =?us-ascii?Q?sXj0lSMcBQDNWwX3lTxfjYkN9YiwcHZMmyy19I+nZOF46TLc7LhsPIrXhVbL?=
 =?us-ascii?Q?5C2y0HN/IE3FbsRo+/+WcVbvkAC34f8Ndqdm/IABrQ9uIPJ4CRlmb4JqTCxM?=
 =?us-ascii?Q?ZpPOQAs8Im/C53+Q8bJQUk2SyKziDOoSXM14gaETBCdoeIW7mt3o/lBpZzLz?=
 =?us-ascii?Q?20aAdxNSvIcp7ohq5FSGXr1n7vOF/8ynX9ZEsf8arAahoP5Ka+h8eHZ7I5jp?=
 =?us-ascii?Q?eOsrWJu+pCFuagKqwFad4WoOHenxeRjVslBLHg0k446uiYxemLFmIQJqYH/t?=
 =?us-ascii?Q?KfLokE0YbmqTDirAY3QBv620uk9wscONCZkM1mg1R1lWVm1EFMljqdOraRPY?=
 =?us-ascii?Q?CXtG+jWcQdXRG4lPnnNVX/WKwua7n+uGZvxRTMdNfKuq2NU2NTGPRCintKfa?=
 =?us-ascii?Q?LHEkArMzZiINUf5G16qrV6yiKuO+PxTfI7gDjl9r01i0j0tWEjzqXfvg6Mx8?=
 =?us-ascii?Q?G27EU92Cs0/k4hv8hAd16ZemvAhg7LNZcbYsPYSEkG/PMOmjd+wdffYhN6DW?=
 =?us-ascii?Q?7JYq2OjPdWpBZqH3N6SxvPaQOe6WonimKipSfur93mW7NgwpCxenkhYmkCz2?=
 =?us-ascii?Q?cw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	6oPWZuW+HOS6qD2/BgJwEvmXplpG8ePb8hpTBs1TEL+/YxxsRCuAPi2IQO02uIswu45FBMK1NCHR88O+aWmDRXqIO5FJHCu9XBTFp5xVijCuvyjP8yCSe3X8EzlbYFTSKIcl5OWk26nWtXJGK4B6HSp1NxBsWjOaAwTlFdHp4F3t8IS1q4cLZIuF7kxYo1lEA3YMmweh5WrWvYdHP8Jg3O43xghjjig0GytndqDj+AYtQYrE4kLalHTferXIJrCo4toxFB5zYoeh33Vb7gg9W0XTihDWQvvabDEy4H9IsXuGB33iCtUuIq0F+NCoxT8P+nLdDDW0Lci2dtZSrtD/QA3jiRjhNd7Yr8Z22Ol1qiwtEvYfGlqj6JQv3rX6DFeEarCas2UlcS1WDEwK+BTrGMsgxXWVJvec3PWaeFziX8R4fMvsZT45bw0+gDIWsTVpOG5L/2whp534xvD1LM94q+HiE56Kmh1UZgRfKtZR4cn1Qs3QUz8O60IAinvMIptCTsm00p/1OhTCUHtJUNMjTgq3LxXdSiGrzOYUmyMolHxLiQRspM+mzNeWOaCDJlmMe1snPwaZue5XhJsZwocqfYX9cDaAiqDBdJR9hvm1NFw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2898a4d0-8717-4de5-148e-08dcbbb622f2
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2024 16:36:52.6199
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l2fPU4weNJ7DPbh6oz3DUqHVqTYyqeaq0eBNUizFeixAjJjmYp/PEa5GQiDtPXTfS7Y8hDIkCp4ED/Fy64tt7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB5747
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-13_07,2024-08-13_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 spamscore=0
 phishscore=0 malwarescore=0 suspectscore=0 bulkscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2408130120
X-Proofpoint-ORIG-GUID: uQLoRZqidYJw3hQ_Y8svEv7BhJED4Ebz
X-Proofpoint-GUID: uQLoRZqidYJw3hQ_Y8svEv7BhJED4Ebz

From: Dave Chinner <dchinner@redhat.com>

We currently align extent allocation to stripe unit or stripe width.
That is specified by an external parameter to the allocation code,
which then manipulates the xfs_alloc_args alignment configuration in
interesting ways.

The args->alignment field specifies extent start alignment, but
because we may be attempting non-aligned allocation first there are
also slop variables that allow for those allocation attempts to
account for aligned allocation if they fail.

This gets much more complex as we introduce forced allocation
alignment, where extent size hints are used to generate the extent
start alignment. extent size hints currently only affect extent
lengths (via args->prod and args->mod) and so with this change we
will have two different start alignment conditions.

Avoid this complexity by always using args->alignment to indicate
extent start alignment, and always using args->prod/mod to indicate
extent length adjustment.

Signed-off-by: Dave Chinner <dchinner@redhat.com>
[jpg: fixup alignslop references in xfs_trace.h and xfs_ialloc.c]
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 fs/xfs/libxfs/xfs_alloc.c  |  4 +-
 fs/xfs/libxfs/xfs_alloc.h  |  2 +-
 fs/xfs/libxfs/xfs_bmap.c   | 95 ++++++++++++++++----------------------
 fs/xfs/libxfs/xfs_ialloc.c | 10 ++--
 fs/xfs/xfs_trace.h         |  8 ++--
 5 files changed, 53 insertions(+), 66 deletions(-)

diff --git a/fs/xfs/libxfs/xfs_alloc.c b/fs/xfs/libxfs/xfs_alloc.c
index bf08b9e9d9ac..a9ab7d71c558 100644
--- a/fs/xfs/libxfs/xfs_alloc.c
+++ b/fs/xfs/libxfs/xfs_alloc.c
@@ -2506,7 +2506,7 @@ xfs_alloc_space_available(
 	reservation = xfs_ag_resv_needed(pag, args->resv);
 
 	/* do we have enough contiguous free space for the allocation? */
-	alloc_len = args->minlen + (args->alignment - 1) + args->minalignslop;
+	alloc_len = args->minlen + (args->alignment - 1) + args->alignslop;
 	longest = xfs_alloc_longest_free_extent(pag, min_free, reservation);
 	if (longest < alloc_len)
 		return false;
@@ -2535,7 +2535,7 @@ xfs_alloc_space_available(
 	 * allocation as we know that will definitely succeed and match the
 	 * callers alignment constraints.
 	 */
-	alloc_len = args->maxlen + (args->alignment - 1) + args->minalignslop;
+	alloc_len = args->maxlen + (args->alignment - 1) + args->alignslop;
 	if (longest < alloc_len) {
 		args->maxlen = args->minlen;
 		ASSERT(args->maxlen > 0);
diff --git a/fs/xfs/libxfs/xfs_alloc.h b/fs/xfs/libxfs/xfs_alloc.h
index fae170825be0..473822a5d4e9 100644
--- a/fs/xfs/libxfs/xfs_alloc.h
+++ b/fs/xfs/libxfs/xfs_alloc.h
@@ -46,7 +46,7 @@ typedef struct xfs_alloc_arg {
 	xfs_extlen_t	minleft;	/* min blocks must be left after us */
 	xfs_extlen_t	total;		/* total blocks needed in xaction */
 	xfs_extlen_t	alignment;	/* align answer to multiple of this */
-	xfs_extlen_t	minalignslop;	/* slop for minlen+alignment calcs */
+	xfs_extlen_t	alignslop;	/* slop for alignment calcs */
 	xfs_agblock_t	min_agbno;	/* set an agbno range for NEAR allocs */
 	xfs_agblock_t	max_agbno;	/* ... */
 	xfs_extlen_t	len;		/* output: actual size of extent */
diff --git a/fs/xfs/libxfs/xfs_bmap.c b/fs/xfs/libxfs/xfs_bmap.c
index 7df74c35d9f9..25a87e1154bb 100644
--- a/fs/xfs/libxfs/xfs_bmap.c
+++ b/fs/xfs/libxfs/xfs_bmap.c
@@ -3286,6 +3286,10 @@ xfs_bmap_select_minlen(
 	xfs_extlen_t		blen)
 {
 
+	/* Adjust best length for extent start alignment. */
+	if (blen > args->alignment)
+		blen -= args->alignment;
+
 	/*
 	 * Since we used XFS_ALLOC_FLAG_TRYLOCK in _longest_free_extent(), it is
 	 * possible that there is enough contiguous free space for this request.
@@ -3394,35 +3398,43 @@ xfs_bmap_alloc_account(
 	xfs_trans_mod_dquot_byino(ap->tp, ap->ip, fld, ap->length);
 }
 
-static int
+/*
+ * Calculate the extent start alignment and the extent length adjustments that
+ * constrain this allocation.
+ *
+ * Extent start alignment is currently determined by stripe configuration and is
+ * carried in args->alignment, whilst extent length adjustment is determined by
+ * extent size hints and is carried by args->prod and args->mod.
+ *
+ * Low level allocation code is free to either ignore or override these values
+ * as required.
+ */
+static void
 xfs_bmap_compute_alignments(
 	struct xfs_bmalloca	*ap,
 	struct xfs_alloc_arg	*args)
 {
 	struct xfs_mount	*mp = args->mp;
 	xfs_extlen_t		align = 0; /* minimum allocation alignment */
-	int			stripe_align = 0;
 
 	/* stripe alignment for allocation is determined by mount parameters */
 	if (mp->m_swidth && xfs_has_swalloc(mp))
-		stripe_align = mp->m_swidth;
+		args->alignment = mp->m_swidth;
 	else if (mp->m_dalign)
-		stripe_align = mp->m_dalign;
+		args->alignment = mp->m_dalign;
 
 	if (ap->flags & XFS_BMAPI_COWFORK)
 		align = xfs_get_cowextsz_hint(ap->ip);
 	else if (ap->datatype & XFS_ALLOC_USERDATA)
 		align = xfs_get_extsz_hint(ap->ip);
+
 	if (align) {
 		if (xfs_bmap_extsize_align(mp, &ap->got, &ap->prev, align, 0,
 					ap->eof, 0, ap->conv, &ap->offset,
 					&ap->length))
 			ASSERT(0);
 		ASSERT(ap->length);
-	}
 
-	/* apply extent size hints if obtained earlier */
-	if (align) {
 		args->prod = align;
 		div_u64_rem(ap->offset, args->prod, &args->mod);
 		if (args->mod)
@@ -3437,7 +3449,6 @@ xfs_bmap_compute_alignments(
 			args->mod = args->prod - args->mod;
 	}
 
-	return stripe_align;
 }
 
 static void
@@ -3509,7 +3520,7 @@ xfs_bmap_exact_minlen_extent_alloc(
 	args.total = ap->total;
 
 	args.alignment = 1;
-	args.minalignslop = 0;
+	args.alignslop = 0;
 
 	args.minleft = ap->minleft;
 	args.wasdel = ap->wasdel;
@@ -3549,7 +3560,6 @@ xfs_bmap_btalloc_at_eof(
 	struct xfs_bmalloca	*ap,
 	struct xfs_alloc_arg	*args,
 	xfs_extlen_t		blen,
-	int			stripe_align,
 	bool			ag_only)
 {
 	struct xfs_mount	*mp = args->mp;
@@ -3563,23 +3573,15 @@ xfs_bmap_btalloc_at_eof(
 	 * allocation.
 	 */
 	if (ap->offset) {
-		xfs_extlen_t	nextminlen = 0;
+		xfs_extlen_t	alignment = args->alignment;
 
 		/*
-		 * Compute the minlen+alignment for the next case.  Set slop so
-		 * that the value of minlen+alignment+slop doesn't go up between
-		 * the calls.
+		 * Compute the alignment slop for the fallback path so we ensure
+		 * we account for the potential alignment space required by the
+		 * fallback paths before we modify the AGF and AGFL here.
 		 */
 		args->alignment = 1;
-		if (blen > stripe_align && blen <= args->maxlen)
-			nextminlen = blen - stripe_align;
-		else
-			nextminlen = args->minlen;
-		if (nextminlen + stripe_align > args->minlen + 1)
-			args->minalignslop = nextminlen + stripe_align -
-					args->minlen - 1;
-		else
-			args->minalignslop = 0;
+		args->alignslop = alignment - args->alignment;
 
 		if (!caller_pag)
 			args->pag = xfs_perag_get(mp, XFS_FSB_TO_AGNO(mp, ap->blkno));
@@ -3597,19 +3599,8 @@ xfs_bmap_btalloc_at_eof(
 		 * Exact allocation failed. Reset to try an aligned allocation
 		 * according to the original allocation specification.
 		 */
-		args->alignment = stripe_align;
-		args->minlen = nextminlen;
-		args->minalignslop = 0;
-	} else {
-		/*
-		 * Adjust minlen to try and preserve alignment if we
-		 * can't guarantee an aligned maxlen extent.
-		 */
-		args->alignment = stripe_align;
-		if (blen > args->alignment &&
-		    blen <= args->maxlen + args->alignment)
-			args->minlen = blen - args->alignment;
-		args->minalignslop = 0;
+		args->alignment = alignment;
+		args->alignslop = 0;
 	}
 
 	if (ag_only) {
@@ -3627,9 +3618,8 @@ xfs_bmap_btalloc_at_eof(
 		return 0;
 
 	/*
-	 * Allocation failed, so turn return the allocation args to their
-	 * original non-aligned state so the caller can proceed on allocation
-	 * failure as if this function was never called.
+	 * Aligned allocation failed, so all fallback paths from here drop the
+	 * start alignment requirement as we know it will not succeed.
 	 */
 	args->alignment = 1;
 	return 0;
@@ -3637,7 +3627,9 @@ xfs_bmap_btalloc_at_eof(
 
 /*
  * We have failed multiple allocation attempts so now are in a low space
- * allocation situation. Try a locality first full filesystem minimum length
+ * allocation situation. We give up on any attempt at aligned allocation here.
+ *
+ * Try a locality first full filesystem minimum length
  * allocation whilst still maintaining necessary total block reservation
  * requirements.
  *
@@ -3654,6 +3646,7 @@ xfs_bmap_btalloc_low_space(
 {
 	int			error;
 
+	args->alignment = 1;
 	if (args->minlen > ap->minlen) {
 		args->minlen = ap->minlen;
 		error = xfs_alloc_vextent_start_ag(args, ap->blkno);
@@ -3673,13 +3666,11 @@ xfs_bmap_btalloc_low_space(
 static int
 xfs_bmap_btalloc_filestreams(
 	struct xfs_bmalloca	*ap,
-	struct xfs_alloc_arg	*args,
-	int			stripe_align)
+	struct xfs_alloc_arg	*args)
 {
 	xfs_extlen_t		blen = 0;
 	int			error = 0;
 
-
 	error = xfs_filestream_select_ag(ap, args, &blen);
 	if (error)
 		return error;
@@ -3698,8 +3689,7 @@ xfs_bmap_btalloc_filestreams(
 
 	args->minlen = xfs_bmap_select_minlen(ap, args, blen);
 	if (ap->aeof)
-		error = xfs_bmap_btalloc_at_eof(ap, args, blen, stripe_align,
-				true);
+		error = xfs_bmap_btalloc_at_eof(ap, args, blen, true);
 
 	if (!error && args->fsbno == NULLFSBLOCK)
 		error = xfs_alloc_vextent_near_bno(args, ap->blkno);
@@ -3723,8 +3713,7 @@ xfs_bmap_btalloc_filestreams(
 static int
 xfs_bmap_btalloc_best_length(
 	struct xfs_bmalloca	*ap,
-	struct xfs_alloc_arg	*args,
-	int			stripe_align)
+	struct xfs_alloc_arg	*args)
 {
 	xfs_extlen_t		blen = 0;
 	int			error;
@@ -3748,8 +3737,7 @@ xfs_bmap_btalloc_best_length(
 	 * trying.
 	 */
 	if (ap->aeof && !(ap->tp->t_flags & XFS_TRANS_LOWMODE)) {
-		error = xfs_bmap_btalloc_at_eof(ap, args, blen, stripe_align,
-				false);
+		error = xfs_bmap_btalloc_at_eof(ap, args, blen, false);
 		if (error || args->fsbno != NULLFSBLOCK)
 			return error;
 	}
@@ -3776,27 +3764,26 @@ xfs_bmap_btalloc(
 		.resv		= XFS_AG_RESV_NONE,
 		.datatype	= ap->datatype,
 		.alignment	= 1,
-		.minalignslop	= 0,
+		.alignslop	= 0,
 	};
 	xfs_fileoff_t		orig_offset;
 	xfs_extlen_t		orig_length;
 	int			error;
-	int			stripe_align;
 
 	ASSERT(ap->length);
 	orig_offset = ap->offset;
 	orig_length = ap->length;
 
-	stripe_align = xfs_bmap_compute_alignments(ap, &args);
+	xfs_bmap_compute_alignments(ap, &args);
 
 	/* Trim the allocation back to the maximum an AG can fit. */
 	args.maxlen = min(ap->length, mp->m_ag_max_usable);
 
 	if ((ap->datatype & XFS_ALLOC_USERDATA) &&
 	    xfs_inode_is_filestream(ap->ip))
-		error = xfs_bmap_btalloc_filestreams(ap, &args, stripe_align);
+		error = xfs_bmap_btalloc_filestreams(ap, &args);
 	else
-		error = xfs_bmap_btalloc_best_length(ap, &args, stripe_align);
+		error = xfs_bmap_btalloc_best_length(ap, &args);
 	if (error)
 		return error;
 
diff --git a/fs/xfs/libxfs/xfs_ialloc.c b/fs/xfs/libxfs/xfs_ialloc.c
index 0af5b7a33d05..2fa29d2f004e 100644
--- a/fs/xfs/libxfs/xfs_ialloc.c
+++ b/fs/xfs/libxfs/xfs_ialloc.c
@@ -758,12 +758,12 @@ xfs_ialloc_ag_alloc(
 		 *
 		 * For an exact allocation, alignment must be 1,
 		 * however we need to take cluster alignment into account when
-		 * fixing up the freelist. Use the minalignslop field to
-		 * indicate that extra blocks might be required for alignment,
-		 * but not to use them in the actual exact allocation.
+		 * fixing up the freelist. Use the alignslop field to indicate
+		 * that extra blocks might be required for alignment, but not
+		 * to use them in the actual exact allocation.
 		 */
 		args.alignment = 1;
-		args.minalignslop = igeo->cluster_align - 1;
+		args.alignslop = igeo->cluster_align - 1;
 
 		/* Allow space for the inode btree to split. */
 		args.minleft = igeo->inobt_maxlevels;
@@ -783,7 +783,7 @@ xfs_ialloc_ag_alloc(
 		 * on, so reset minalignslop to ensure it is not included in
 		 * subsequent requests.
 		 */
-		args.minalignslop = 0;
+		args.alignslop = 0;
 	}
 
 	if (unlikely(args.fsbno == NULLFSBLOCK)) {
diff --git a/fs/xfs/xfs_trace.h b/fs/xfs/xfs_trace.h
index 180ce697305a..52a517a2c8e1 100644
--- a/fs/xfs/xfs_trace.h
+++ b/fs/xfs/xfs_trace.h
@@ -1811,7 +1811,7 @@ DECLARE_EVENT_CLASS(xfs_alloc_class,
 		__field(xfs_extlen_t, minleft)
 		__field(xfs_extlen_t, total)
 		__field(xfs_extlen_t, alignment)
-		__field(xfs_extlen_t, minalignslop)
+		__field(xfs_extlen_t, alignslop)
 		__field(xfs_extlen_t, len)
 		__field(char, wasdel)
 		__field(char, wasfromfl)
@@ -1830,7 +1830,7 @@ DECLARE_EVENT_CLASS(xfs_alloc_class,
 		__entry->minleft = args->minleft;
 		__entry->total = args->total;
 		__entry->alignment = args->alignment;
-		__entry->minalignslop = args->minalignslop;
+		__entry->alignslop = args->alignslop;
 		__entry->len = args->len;
 		__entry->wasdel = args->wasdel;
 		__entry->wasfromfl = args->wasfromfl;
@@ -1839,7 +1839,7 @@ DECLARE_EVENT_CLASS(xfs_alloc_class,
 		__entry->highest_agno = args->tp->t_highest_agno;
 	),
 	TP_printk("dev %d:%d agno 0x%x agbno 0x%x minlen %u maxlen %u mod %u "
-		  "prod %u minleft %u total %u alignment %u minalignslop %u "
+		  "prod %u minleft %u total %u alignment %u alignslop %u "
 		  "len %u wasdel %d wasfromfl %d resv %d "
 		  "datatype 0x%x highest_agno 0x%x",
 		  MAJOR(__entry->dev), MINOR(__entry->dev),
@@ -1852,7 +1852,7 @@ DECLARE_EVENT_CLASS(xfs_alloc_class,
 		  __entry->minleft,
 		  __entry->total,
 		  __entry->alignment,
-		  __entry->minalignslop,
+		  __entry->alignslop,
 		  __entry->len,
 		  __entry->wasdel,
 		  __entry->wasfromfl,
-- 
2.31.1



Return-Path: <linux-fsdevel+bounces-18151-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EC388B60A8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Apr 2024 19:53:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C25BD282EDD
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Apr 2024 17:53:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A74512D214;
	Mon, 29 Apr 2024 17:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="DuvnJqZ6";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="qv2i4SMl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AF66129E93;
	Mon, 29 Apr 2024 17:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714413028; cv=fail; b=risDqmAgTmpjGrIa5X+PLKOQxufhMSMxik7qqeqydGO2z/fo1AH0f7N6h41pyBmbgWOCpkhaogZ7j6HgH1vcGuqVbrPjTyN5FsBCQQNJdWyZlVKW1lODQg+G0DVZr74g1Ox1MGtNtW2YXFDAFZN9/ScOH+yBVRLe+VC6dqy0WUc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714413028; c=relaxed/simple;
	bh=b08++4pM+DzCFc8if3CCdgXTEJFeNaZ5kozpvHEbAJE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HVcTtlMKjJ9cCp5tRsemhhSW1X8OMiACWwxyDr2jKkvE0+fTaWt2RyC/e5eyB4vIfkQ0pZMcsErdtnzjO5gtS3San9Arotdc3xmpGBy/6A3NvyTDt1JXM5NmCa9miFZU/w+IcZjMboD1jLKhv19X0u83kW7V9mAcFwFz8QVIrXs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=DuvnJqZ6; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=qv2i4SMl; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43TGwkoM004986;
	Mon, 29 Apr 2024 17:49:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-11-20; bh=0dc9PhpJvK+yLNLKeuZsuX+148+Twg6hbRxHjBBXH0A=;
 b=DuvnJqZ6do/ILZiKrkXdEuEKV9S25eGPI3SoV25zVV8H/j6PhYHQXR9RvRuM9I2pPnxw
 sBYxP+hXvAORGrKgrv+o204oRaldf6cEqQ0UvzB8t6S0zQpEAExUXklGCVOU3Lyenk9+
 LGXurSeRUEicE6S0J3TM+nPffvyjIbvnrVzbE5xPHP5lply95K9p6rLih2GirsekKv+h
 nA64jU+hjnAWCEKVELs3A9vKmFxyj4WYlkiA+QVVkthHW5FzQ81Eo82Vtrsf8OVsIeN6
 75bLUiLYanN0Hd4XI94VYFs2g7e3eJ0o+/DqHSALfsoCwRhREDV7xwCEmQollY9MECzc 6g== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xrsdek6cu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 29 Apr 2024 17:49:04 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 43TGqC8j016783;
	Mon, 29 Apr 2024 17:49:03 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3xrqtcpy8g-5
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 29 Apr 2024 17:49:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f9DEnB0VekhlKWW1G8DlTic6BJZ5UQIiFVQ35AuOMECxwZg+HNtusAkM9jOKcRaHrWRHJY9h+7oI8ISywxTRf1MV++Ui1ZU0RIpt/9z09vKAjKYYb5U08y2XLB8gb5hYG+tbhtxtuf8b2xO9DpAuircWM8Fhfmp2ljlN9GMyJtVVZ/RY31m4J9xrywJR2uyM7eFZnucmhXC49HfrkMiGaOkeR22tKCg8re1Klt15UGq+LIO/fGY8lLz1+cXy4dsu7cJH6d9d5CCgJaS/bC5J2M5z5y+thX9yc5yeffx6Wws/kVqALxV0ZEbdnbIUGxOqXxdwCxeH5jwzaCaDoXIfZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0dc9PhpJvK+yLNLKeuZsuX+148+Twg6hbRxHjBBXH0A=;
 b=Vh6d3ifCS6T1fhwDrV0vOMTvZ7Y5RbHaFBSPtvemlJasSkK6I/SQQE/yvPlck2DnG9i8xCytZvva7VD87FsOXAiYRATKoPqAk5bucxkhUf9ZC0iHHlBtzn0yEMtWdc9U6BL6FLrc755NTqpyoJuzCTT/3TglFaxxaKrUmVHSa+y1JcE1N9Wqr1PHBHFOnzoXrGZtmRJ8nplYoGEZyiwvziaANtqyws6oBOsiDxjhaS4z3gVjL4WM5zh0wk6lUKRdGzk0k7q+x/5O2EqStsaYKMnPyXOKGx9/lDVmP7ZRglX93+YzO+Hlc16m2NK4UtIH7/ZYvSFU6NJaf5o6MsCgpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0dc9PhpJvK+yLNLKeuZsuX+148+Twg6hbRxHjBBXH0A=;
 b=qv2i4SMlNB1vqtn1FAorvD2yBnJGsDZy1MadEXG7VhZdFpMi+vNY3vF7Jac915zVrlnQUFZCE1TRt2QiFdTLJ+XBtuPpNHFTxywES0Ustk8F058bMYv6DnoRLnUMgw3QyFdfahJFdBoSsKuyCRO/svBWzL9GzQN+JEUYSeLrp5I=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by CH3PR10MB7763.namprd10.prod.outlook.com (2603:10b6:610:1bd::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.34; Mon, 29 Apr
 2024 17:48:53 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%4]) with mapi id 15.20.7519.031; Mon, 29 Apr 2024
 17:48:53 +0000
From: John Garry <john.g.garry@oracle.com>
To: david@fromorbit.com, djwong@kernel.org, hch@lst.de,
        viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz,
        chandan.babu@oracle.com, willy@infradead.org
Cc: axboe@kernel.dk, martin.petersen@oracle.com, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, tytso@mit.edu, jbongio@google.com,
        ojaswin@linux.ibm.com, ritesh.list@gmail.com, mcgrof@kernel.org,
        p.raghav@samsung.com, linux-xfs@vger.kernel.org,
        catherine.hoang@oracle.com, John Garry <john.g.garry@oracle.com>
Subject: [PATCH v3 20/21] xfs: Validate atomic writes
Date: Mon, 29 Apr 2024 17:47:45 +0000
Message-Id: <20240429174746.2132161-21-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20240429174746.2132161-1-john.g.garry@oracle.com>
References: <20240429174746.2132161-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR06CA0044.namprd06.prod.outlook.com
 (2603:10b6:a03:14b::21) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|CH3PR10MB7763:EE_
X-MS-Office365-Filtering-Correlation-Id: 476e5869-ffc0-4d2a-837b-08dc6874a287
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|376005|7416005|366007;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?738/O+YdcIlFlXFPoWYpaO3IsSBNnsCvRkrFaZVT7gmrO0OuPE85QbAASIHP?=
 =?us-ascii?Q?0qhkWXzmr1xW3fei7xYZvj4bYQSvoYhreCaa8xdjxuUzZbC64AQgEOhppRKQ?=
 =?us-ascii?Q?E4H5As9/c2skqvdo7YzFqWF6Dn53sQKwGXTnaok557liGNYl9Te9gw128jVZ?=
 =?us-ascii?Q?7WkQkBXu13fmbklIYMsuGO1a/561U+lgcK1lK5ExS9QJ1mT9bxKg59MjkNVL?=
 =?us-ascii?Q?F7pvWo8LqwaraeNJvd2tAOU5oA6IVe5AAmQutPY5ek7n2CAqLv7JXtXpcarD?=
 =?us-ascii?Q?mv2EzBcu9FHvLP1tizF5l/jyxuk4qN9JyPG819BXvKVpJW7DCGxfLzZREGBd?=
 =?us-ascii?Q?8guVZaeLecqlmwofk9EmYsGBJ/stmZLtaIWVmONaNiV+BkuxI2BgR8LZaNal?=
 =?us-ascii?Q?oub2RrbYVSLQZT+XhrBytZa0pQtaio2QqU/jE6b7awX+fyirGDD53kxVRenw?=
 =?us-ascii?Q?udknCfz/22vApSpk5CioU6wPN8vM0uSXWTFmmqtKXMCiQ30eqvQI7RIpUR+V?=
 =?us-ascii?Q?CZ0is9pd5rru91oyxLjZNMJcEMt918a6RPDettlhTijJfT+XKI6Skqpxasah?=
 =?us-ascii?Q?VHGXZAcSiIOmvIWE+pbCGD+JHmoXjnI9O43uLuajMyQclAQ5vGP1kK952Dq+?=
 =?us-ascii?Q?GqFkriu/3tO1msfF7crm309b+VScrMHidH6HBW94dhCTqZ7Lu87TgtmxdHzp?=
 =?us-ascii?Q?F2oM6PB3oQ+Q6ZtVuPlX1/xJQUmRBtDK5oCn5XzheZeRBbp8QwM27YaMzUNw?=
 =?us-ascii?Q?qTTgvTri2Bnjr4dSIpKemaqrBrW1/A65HJa6gQbW0B5646gOsi1KxpjHbVKP?=
 =?us-ascii?Q?OjsCHeZS+GAiZdDMV3pJAyxYB2qR16K59Ef2gdHkuHd1bLyt3q8qvbQIHIw9?=
 =?us-ascii?Q?pAbADGZ9faaQPkdaCbTKmq1PTQH+Ct/RFezd8XE2Yaiol9K4qIEGsWVH83j2?=
 =?us-ascii?Q?G01oO3fVBHwoYDRc+LLpWhFhubRv2rebISw5m/+rjqc8/98tFbTikUmTcjG4?=
 =?us-ascii?Q?3qezwHXsp4Yqd5ZezB4NgtXQUfxuF3gvrRpcLcc2dfNoMshNaqDpGldIm25A?=
 =?us-ascii?Q?dURJsUTim4brG/WldbxC54biN8PQESlE8nxjbGk4Bol/1J+HrSxjD+nDfKKJ?=
 =?us-ascii?Q?hlhtRwHMjtUZh9s6h1oV0na9zrxP9Z12eFYNqVdfWf7MoS3rpzBmepL8vOLT?=
 =?us-ascii?Q?sHVsmEBSzDRkkpWcjtYfXZ5j6ksHLifgVJrxp938rgcREd7gs/Q4HLOSnYWv?=
 =?us-ascii?Q?vVekI1tPKP3B4PkDd5ffheeudysslWELnmROxxqGBw=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(7416005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?Fgaf7NAfC8Z8A6wC3PXx9aChRV6dbatLoSnBNWJscvZDEhbAQ34JB1Lx5mZZ?=
 =?us-ascii?Q?XwqV56uQ4q5zap7DqR+hLNWIZsM/lFile5AxUNDUkNL6G10RJHH65gqb3qui?=
 =?us-ascii?Q?hrGnI67/+L6T/K8L3yOm6RMgXKsXizwYBNUmm0PRMhCybLYbbsk+Fz2v/Fmz?=
 =?us-ascii?Q?wdHXqQlBcC9mCMY25SaDpmv2BlWoAE+AU/9dkz0TAb8+xNF3mnGFUtPNDg5h?=
 =?us-ascii?Q?oPnr9FRfc6OZflaw143BaMtp6vrRyfs3ZJxZCkB90Q1mKo5sVELp145YZF9Z?=
 =?us-ascii?Q?J1R3dqAYPL52/Y6q6/ckKAVCUnnmy9b9oZDXHIjuvlCSIdI4ZKevkw5vPcFG?=
 =?us-ascii?Q?sXju5iyHZKHB0OB81yXg889Zm1NsWobbBKJNBdV5pc+ovha6wG3dfZ3lotBV?=
 =?us-ascii?Q?qeFG1WaKX32j6W0Dq1+hmapKtsM3hGfPJZCiWAJuP9vU5AhVoJ+xMCQoCdG4?=
 =?us-ascii?Q?aTC0zk8bV2h/lE2lduOtMp9xz7e26m9WfHwQUAsLY3RCFM6MUPonEa4ZRsYb?=
 =?us-ascii?Q?bcK9TPKCvTbVAUZNN6fmTsRX6dB4PHGEcbmFziy7wn5HTv4TepRE8jsBNgIq?=
 =?us-ascii?Q?B0+dbzd/wOKAoOlHmwOKvRCapjHM8Fp79miN37cjDx5bTP9IySCGC4bxBVPp?=
 =?us-ascii?Q?pjnRjei9evcbmi67iqf3kWgnV/zWZXKJP3IYnjhyWUL41P0qp63w4aVb8TU2?=
 =?us-ascii?Q?cJ1fljoiTRjqiv3NV9yHxdfaJ3eYqZ8NTPo9DGo1mpAjjh/4hfv2jztwDSzt?=
 =?us-ascii?Q?YxUXOx+tPsszL16ThdavkNh/+90peK8IBUeVQtV/Nkpy3vOYabeY3On75vXX?=
 =?us-ascii?Q?99pGTJZYtQGjRDQpVrMZ7K8ArHlASaX2WsTONoLM5+KVPXOXx0ElzPVWHciW?=
 =?us-ascii?Q?DPSFlBF/LB23LJ8gE5Ij0al+pSakSoYoZvLUiNAAbyao6XREWobbqMuhSjzw?=
 =?us-ascii?Q?yiu/d+LfoG/GrJUiU96OT/IUHDCqQj//gb7OFfA6lQr6eijUZFRJ7ZwlXjRx?=
 =?us-ascii?Q?zW7mWYZLOUdh0LvM6akWNwN/UJWybGIhMuHSEpC3o6rzUU0RaaMm8QFdVUmE?=
 =?us-ascii?Q?2yJgnny0HzP19JS6QvHSCJ8EED7l2zRRlYqbxJau0F4j3uhAbYaKm7o8+8Uy?=
 =?us-ascii?Q?BQ7xw/UH5rbhabpTlKyZyHv/hAryMArtAOorH2dh2Pz40thN5sOAykAvVRWj?=
 =?us-ascii?Q?7F5MFa+QnNWtU3ILppNc8Ttuq0SHQ7+MAYTap71bPnfi5HRPrvo3VgoakXNy?=
 =?us-ascii?Q?+shAcx4LNTdpsnQO3mn/FGB+Riz0zDOr+4ewEJW/xIMehSDvqRHWVfpDrxWd?=
 =?us-ascii?Q?Y+dz+lWxwtivJOhVFDsVTezua1LVyqkTFBTxXeN+AFWXT6tWYUzylJ+AUWXY?=
 =?us-ascii?Q?ij5zA2l++4tuTcyVJMCJ0PT+U/JWn8EfnnmBr9K5AAjZtZ36h+ejG7BLGiFC?=
 =?us-ascii?Q?YIC2Q3q+Q3YvxXvdrYvih+7/NgVDK/qnbc07XORwLg4zbU1MLL9RXGxMz4Zv?=
 =?us-ascii?Q?swo7L7rmpiqwStoswAqzbRO3k+MOJIIWGKoJqhjPgDeWZgmP2jBMbLArgZi+?=
 =?us-ascii?Q?wLBPydn4Bul7oDJs4NCwfdLPRDRY5G8xsJvBgf0+319lvt+nvj2TGePJMs45?=
 =?us-ascii?Q?rw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	UmnZR3xVLum6eY6se/rfhYdIH/v7WYpkXC5nelGtdwTg2bKIpDRgNjP4hmHdmIVJmb5iFRFxPZdpIYmdJZsnG4EGWEBDfL52xfHT7K7WUDyCb/ThV+Uaa7wcpun9VJ7UMdd001/sW0tCMPEXhTIoSUslIr82cwxuIMCtBP76mucCI5TIku22JKAhp4zKG7uYm1UOZnO0h8qAeuOccgJRqE+3EPYDWtOei97bycBViIKVgo/8fe4C+XD6hdUuWZD4fjUM3TFSi3e3zlLRZtcoBUQ0JsUZmcgVyEK87Snjhcwbbx80WHGSUQNTllom20CaPKRa4IYuWJ2cuCJ3vKhcwRiGWAEjJ4fxf5KiKMkHtOOpKRYMKgR2pWImDDwt3IWjURv3WbOI1KJDdI9FOmUxmfcaKpOzB+4V8lRqbNyr1gebVfpVJ1QXmMsGJKE303GlrPgnVqMyscIcuXdIsn1D3bmOOBSOFd3fFkJSz0gx7qSsYtNYlVM64uLeiChc330RuVvfAbgorOVVw5lLn8TKHuIs4FckFylFonwHdmK+tqpTVfXAa5J5PI7xy3XpheXB9NN/mmEpsS1SdEGPuOw2t3mUdvT6BdmwABF9UhJDR6A=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 476e5869-ffc0-4d2a-837b-08dc6874a287
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2024 17:48:53.3231
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g9p9Z3rpxyvjSG8uz5s1S7csJCpfTke0bsqylrFCB9ao96r9LaQvZQm4tMsefnANl/5Aoz7UPWOeK8CIY8qz1w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7763
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-29_15,2024-04-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 phishscore=0 spamscore=0 bulkscore=0 suspectscore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404290115
X-Proofpoint-GUID: w8XJjCVjeFu7x7h5YYAF4oa7fQ2gM3xQ
X-Proofpoint-ORIG-GUID: w8XJjCVjeFu7x7h5YYAF4oa7fQ2gM3xQ

Validate that an atomic write adheres to length/offset rules. Since we
require extent alignment for atomic writes, this effectively also enforces
that the BIO which iomap produces is aligned.

For an IOCB with IOCB_ATOMIC set to get as far as xfs_file_dio_write(),
FMODE_CAN_ATOMIC_WRITE will need to be set for the file; for this,
FORCEALIGN and also ATOMICWRITES flags would also need to be set for the
inode.

Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 fs/xfs/xfs_file.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
index ee4f94cf6f4e..256d05c1be6a 100644
--- a/fs/xfs/xfs_file.c
+++ b/fs/xfs/xfs_file.c
@@ -712,12 +712,20 @@ xfs_file_dio_write(
 	struct kiocb		*iocb,
 	struct iov_iter		*from)
 {
-	struct xfs_inode	*ip = XFS_I(file_inode(iocb->ki_filp));
+	struct inode		*inode = file_inode(iocb->ki_filp);
+	struct xfs_inode	*ip = XFS_I(inode);
 	struct xfs_buftarg      *target = xfs_inode_buftarg(ip);
 	size_t			count = iov_iter_count(from);
 	struct xfs_mount	*mp = ip->i_mount;
 	unsigned int		blockmask;
 
+	if (iocb->ki_flags & IOCB_ATOMIC) {
+		if (!generic_atomic_write_valid_size(iocb->ki_pos, from,
+			i_blocksize(inode), XFS_FSB_TO_B(mp, ip->i_extsize))) {
+			return -EINVAL;
+		}
+	}
+
 	/* direct I/O must be aligned to device logical sector size */
 	if ((iocb->ki_pos | count) & target->bt_logical_sectormask)
 		return -EINVAL;
-- 
2.31.1



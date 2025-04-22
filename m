Return-Path: <linux-fsdevel+bounces-46929-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 76697A96976
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Apr 2025 14:30:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E5999189ED95
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Apr 2025 12:30:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACE64281368;
	Tue, 22 Apr 2025 12:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="SV05gqET";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="SXGEW9fU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5925E280A34;
	Tue, 22 Apr 2025 12:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745324926; cv=fail; b=djjhLMxLSjdCoieQwifvPPqeGoSGksp4ACJrF2+o9pC+ek7A576BYvJdeZ4mngR03PmwjZ+Rl+0AT8aXOvywDFZL8UrE+ac5/8FW38dRCQMdaRBsig5WkrNOhPNz+hzgEuevHIyCGxM0xpZZikgxKhTitpIAtxOUdD84G+BZLRE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745324926; c=relaxed/simple;
	bh=uCBAHIwzOHfSVKzZlKkW1q67smiS3MDfGRHT0qxYps8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RFujxKpQelrqO0tbK/0Wnu54noqThkU87yVefQ1WakQjLZh9DA+JBA3CJJSuIYArDePy48BM+vJF0Gvw9uW2baUpOeSebWvcGAeS25PrY5fKpLJa/dfGEsysHGrlm3iuFjmAGx/0CBQ0TsPU8ubLRc16QpFlFppItlC3YY21UGg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=SV05gqET; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=SXGEW9fU; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53MB3DPm003573;
	Tue, 22 Apr 2025 12:28:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=67/9CFyF1gou1Kj+l1xhrXDmc1NJI+e1nQgbHzsia7A=; b=
	SV05gqETjlGlEiS8DO4uRXJfrtCA9V/0tfvhTZJC0Q41uWZVIVCfP072sHiZtB4n
	XXAGPZ/5Hk96rbsmAr66DzrwyUrerJ4O9/RrXZNkh2DR4WbbnaHZDjLP/9IGWT5N
	bRvTh4QciPmR8ZC6tU+Jrg4NTsjVbtU0eUL4gN1FPp5p/99wDBWBMGxbO/IHMpRj
	nx7dMcsrzUzoluYi4JlI9QdalAnZIGxZ1ClQrlSLg/t+NnGG/lJ7ITZ6rPV3kEFR
	UiUlJPyPQ+zQGxbJQXrnR2Mwc8OYiLpva90FuyTTzFxf6AZXbtGEZhgloRkQtPmE
	z+PwelgzNP1aZHUhFxi09Q==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4643q8vbu8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 22 Apr 2025 12:28:30 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 53MBF6xq033451;
	Tue, 22 Apr 2025 12:28:30 GMT
Received: from ch4pr04cu002.outbound.protection.outlook.com (mail-northcentralusazlp17013061.outbound.protection.outlook.com [40.93.20.61])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4642999rq9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 22 Apr 2025 12:28:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Dn2Lm06sLPQvXXFAA64mM8ywq/1FecgVaTXOADrdpWfyAFwomtzwL6ei8A8+F/sWc8SNlBQFQzHk9uP5j2pfsC82cIV7RG2FYQPx0SxXxDw6veBHgdYuOMOb69DrfwmSAsABw8Id2DtoUfxy2CaeUTRVJMuffYYyeiGKpkdf2IchLLr2ZepqaXIv2Uw9/QkKkGEzlY4yeBeQIaKaGKqn5m3i3aMrEhG7aaALQZPchOIVZkSLFiSDIY0RpPkY/IczbxHpjzaxl8EXimUYju/skHDOVebMY70ztubatGhque2bB2k5ArWfzsCmv4BSGG9vdYDh8yW/W/En0FXvojapdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=67/9CFyF1gou1Kj+l1xhrXDmc1NJI+e1nQgbHzsia7A=;
 b=y5uHTuHkHr7qQZ2585R+cFv2GxGUhFSyZduuMO7Dhv09znZAi5iBV7U3NjADqcL4vfT16M9fMc4lZ5ZkiHXpTsUhMTwLjxZf/gu4imsHsSGDcxr09JRJtfK7Evqw81uonEqHcc6R8EzFEzwUYb+grQvKemH6+E7l3oneYpZUnqEYSrtaLXzGaJdOvf9mOD6YXO0GDvGml4r25mEPPOpSJIJEIbYnJ+sRkNlLabGvHmiXEapSeqvbFh74bcX4uCC5r4Nc30E/+0+LUDy4JM1OH5YRh5d7AjIGXHKazUqAq6OkCKFFXl0JnU2O4MytNeoq3Dpn0XBKNTiU26oD59JpSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=67/9CFyF1gou1Kj+l1xhrXDmc1NJI+e1nQgbHzsia7A=;
 b=SXGEW9fU+bXjUaBK7OIXqcCMojIDbO7oJtHY5NcsI6eF+da7VOFaLKwOiPcG3MqC8NJu7Avdw1jCfVOigjbdFIdX48cZBDlwG9Qb9n33rwlJnbOeapxi4wuBcMWoJ2s7w34Qa6MGNXG+uCgsDD2pLHtxcCScu5OnynW1iPMuja0=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by DS7PR10MB4895.namprd10.prod.outlook.com (2603:10b6:5:3a7::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.31; Tue, 22 Apr
 2025 12:28:27 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%4]) with mapi id 15.20.8655.033; Tue, 22 Apr 2025
 12:28:27 +0000
From: John Garry <john.g.garry@oracle.com>
To: brauner@kernel.org, djwong@kernel.org, hch@lst.de, viro@zeniv.linux.org.uk,
        jack@suse.cz, cem@kernel.org
Cc: linux-fsdevel@vger.kernel.org, dchinner@redhat.com,
        linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        ojaswin@linux.ibm.com, ritesh.list@gmail.com,
        martin.petersen@oracle.com, linux-ext4@vger.kernel.org,
        linux-block@vger.kernel.org, catherine.hoang@oracle.com,
        linux-api@vger.kernel.org, John Garry <john.g.garry@oracle.com>
Subject: [PATCH v8 04/15] xfs: rename xfs_inode_can_atomicwrite() -> xfs_inode_can_hw_atomicwrite()
Date: Tue, 22 Apr 2025 12:27:28 +0000
Message-Id: <20250422122739.2230121-5-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20250422122739.2230121-1-john.g.garry@oracle.com>
References: <20250422122739.2230121-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR08CA0023.namprd08.prod.outlook.com
 (2603:10b6:208:239::28) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|DS7PR10MB4895:EE_
X-MS-Office365-Filtering-Correlation-Id: d554dbd8-2168-41a7-f39c-08dd81992f0e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?8csBhntcsmymtMQGlivd/pJgBn02gISzIzxzmjuPUsE7ec4Foy+MHAxbV613?=
 =?us-ascii?Q?H0pxZzJ0qvapuwcqO+d1g2ZH4+sQ9MGUq8wH+F50DfGVZRt2EqUFfF34CJJX?=
 =?us-ascii?Q?V7iLip+9HhDWhQMH2253F+MD47HG7IwWVeQTebC8L6bAdJgJbzZz+z/q5K+J?=
 =?us-ascii?Q?WuQ/tyIdm2c5FHckSwmMk5lkwt7Qlu0D3qudnmhI4HF5Qs1sQLOfklU8kI2f?=
 =?us-ascii?Q?1VGD60L/tmTbs0P4y+cyxFfrTxx6UAx5seqok2YD364O+I8jkO6DYEeaI3L2?=
 =?us-ascii?Q?MCxmPEb1S/io30wBPWGR4exh/P3yJk64GJ7h9FSfJ2vkkf+PJLmdm+C9iibs?=
 =?us-ascii?Q?edW5kNk4ZUfX70Jxzuk6U4pZQCajcimVMQUfJBWkJCj0r54wMI47NHPS+wY7?=
 =?us-ascii?Q?/FNmemMgKB1ImW4tsjAt6xASElYgz5DWYW/ZfOk5kgojGMOA8AI9tcKVDMLN?=
 =?us-ascii?Q?abuZ7Ug32DoCnra1PnpFawDfB5o7Sg22uVZQ1JDHRq21kBBOWYUfNH+dan92?=
 =?us-ascii?Q?CBurCSkVTPa51tfOoT/fGIgh4M/2wvvutq28A7iNXTSUbUQ1fxf+iL+RNVZX?=
 =?us-ascii?Q?MTlo13X6gh1Xiy7l6/ru8huqQSTxKPMtCZPZSRTnsmNgaurcZ9mX2hFeYqjn?=
 =?us-ascii?Q?pnoje+lhwB62Wj3FGF+3BAwtX8qRbH5NzKwrIWyFiG4xjSn4QYhjZgICDxVZ?=
 =?us-ascii?Q?Uw3xX5NckhrZ9Vgw/SDdKPqbExRMoLvrwfrcU4xOaoI66KPPT0aAUdpN1aFV?=
 =?us-ascii?Q?MQIQGEqtNOUxE14lNdsC3IoMv7IT2QW+k95JucrZIjJJ8ks6ceTEJcj/Zaxr?=
 =?us-ascii?Q?3qy30Fcltt+nI8fLaxxF9qokslI0U2+JteCnT87iAs12RKzQxHsOjPyko3Oa?=
 =?us-ascii?Q?cSy6s1fHMKYoqAAHUvyCUHZxyCd93NfeOYjPi9Bl8nMggIXwscqkht5BQaBI?=
 =?us-ascii?Q?JX3I7qEMhQBDfQvJj9qbW+pjAvEbYC8hxNOKqsMFC5q2jyvL3DCIph36YAlS?=
 =?us-ascii?Q?6MoAuXyFs6RCKOr5mnRwEJUQmGtltuQhb04UefstsHbW2XbE5gNs1ODqoKOl?=
 =?us-ascii?Q?YW1NDKxfJKZSEoUajoqjSQ4UG1iUMQEE6UBNM0JZXlVGNbzM8D+oRNYEo0Az?=
 =?us-ascii?Q?rRbRvUJLcamzlSISRJaae3lfJNK3KwPxc2Ra2Ykuys1Ioe8thiHSTiu8xfJ4?=
 =?us-ascii?Q?igHYqdcc9HqMKEL04NODLBoasr0WJOU7GaDDqLSdHImZnOnZ92hwwLyKkMiW?=
 =?us-ascii?Q?7ZQXVZ5Pu83AcCg9VXnrZiWRuIjldCkTdVDxjP1305KDhWvexj1aP7qCPyj6?=
 =?us-ascii?Q?P76UgCqdenhus9TZVQtE4MUCD5MMlXeUaTa8maOdz544OipjXKVccnB0U+/4?=
 =?us-ascii?Q?cRLk3A9y5H1tiiVrxCjLiPMX+Eo/2VdtnPkvj2KgL04G7Ul89w=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?MMV0C0APUqDSJL/EB/fJjsWSvegzTVfbd7H1JVVmjL+PMKF8ciq2YgdNNaS+?=
 =?us-ascii?Q?I7rYSHWkD0/hi2H6TJUoKVf3QYOM4M/lP/m3JJgMLqOrxBEXOip+ME3HUmzH?=
 =?us-ascii?Q?w3B/Ez3VBNbNvwIVeRyAJeD7CPuo12DxLiOh1zXxRnU2NuXPzM817ovolEKK?=
 =?us-ascii?Q?Rqin4RdkHlGL8KfodSC+rRw9ynmnUjOI7ahv+OLnNNurOQ0x3mDvNl2RLd1+?=
 =?us-ascii?Q?kD5cdVfeohNjyRGCTg0mzMB9pNCsU2hD0HkJmDCsaWlOFdtk4XKBwYij9IDs?=
 =?us-ascii?Q?3JLRQQb2HcOAuFYgDg1cAQmlrtVUqoxoyGsJygYqWL8f1P6CEv8eX2Ph8qJM?=
 =?us-ascii?Q?s84+rhTSRGWm5N0SaBgVGkZjHmUkSg3QCK0xYSlrjpolOIRu2X/4H4Jix6fg?=
 =?us-ascii?Q?dnhjvDQ2rMSSUmIIh6OSYq3FkobsFhNh5i0ELCur2fPPaA5KBv9N8KY8FMQk?=
 =?us-ascii?Q?xd55FO7RQnVpfiXEQGH/lgpmJXlxNW5dSCquMoAKsPA3XzU4Vf8xlYxLFWVD?=
 =?us-ascii?Q?84ohLvX9Ps75YFR1Ggf9fDd+igJnMW9iexrmXcg1PSmTJNLs9Njs5mIn+YLU?=
 =?us-ascii?Q?hvOP7Zq/Tpur4KntPVTCtAdz8oZ+I2zjwKgiA3R2THwWRUHM2c+hTBbyeAWb?=
 =?us-ascii?Q?EfRax/3tD3aIYI1mjaFzQD/OGHija4MvKppYh924c72t2FwwWuBn5iqa01nG?=
 =?us-ascii?Q?dUFk/Rd9YgfBt4ooPOR3FKNa9eN7BwB7OSviQGrT67uRlssjra7CGkY6NyLh?=
 =?us-ascii?Q?V9koSlilJjy91S1/DklB/JTjLtA3mrEV3aLfyud7H0moh/Z81sAABswl1MHc?=
 =?us-ascii?Q?B+bdT6UWYFtiJceZEpWM4ECDxF/nnMoWLw6webVIygWWxbHJvBdU5uzaG25z?=
 =?us-ascii?Q?Chn3I1aDnVV7e4diEexgzxx3vdAZzojOyNJys87NiHMXAFmTSGfsbOq2TgE4?=
 =?us-ascii?Q?UrW41bqoJzkLyXFXONHcyd0uatY6Bub0rn0WLeJYjlVLBDthCcwQE/LkM/VD?=
 =?us-ascii?Q?EwhzKBKSylj4XWUEysuFnZBPTZStGafvxDmE8yu+MFYu4z28VNd8aB0dQkTY?=
 =?us-ascii?Q?A0KTBzSgMAlHF3IVLsgDfdhZvpUr5z/PpkVOqkT0jJubbiuko3GRihtFgKek?=
 =?us-ascii?Q?nROuFu4m89PEpZJFA4UsTw3QJJ94bbVRsCQYLqFtiq9B5wnnpHHZ2baYmKge?=
 =?us-ascii?Q?fUG8BFO9uxquoIb9+pTzAvnY6/Q2DL860PxDe3x0ZkL8do7m9G326vhQ4RK4?=
 =?us-ascii?Q?Orh1swOfsyMCH6/CQjffmGwX77oCdLLLkjPwf3Cp6Pf0hlReclx4SP/aeDoR?=
 =?us-ascii?Q?VqQZSmzfGf8WQ1oopH1dj7YD3Azr0XH4VVmSB/2u4b0KFSgWm35AaSy373nt?=
 =?us-ascii?Q?WHhKNvkmSKeemX9LX26nmMesP/UnQm0pZ8SkQ5Sr00qRZpXQwDVipE/QOC2v?=
 =?us-ascii?Q?l6tjmFKL9n3anBaBziZpjmkAwk+hP5kMk7tkbhg+ekT0cwwBF27BTPuaOiWQ?=
 =?us-ascii?Q?ZhZNCjczvhTSwW25MGiR0wJzeFWlhmTFkUWWVmRNzYUmx9b95HP/qoFS2y69?=
 =?us-ascii?Q?EDTYutWmgEitLGabUbokozD0fWvBr/uXVLQ48eCRDdFR1TtrDJOTElpC9K6N?=
 =?us-ascii?Q?Ow=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	g+B7zEx8XvDtYBNAZ8EGqBkg/s8h+UX4J7c48cxBm3cdbqMbg/kts6+N6NCgvEAjg873RQf1xNa/+UPZHQKn8R3aAXHzK2Krzt6PfRHS0V0hVQpQXB5zQ2fB/GzJtM0N5ipuWAhpaLZo5DMBkxU7Rp84JQo8A6Bnfbya35rb4odvlyBS5oMKupagSIvEWPFZYyDFDubXmMqv2avl68x68ax30wgZ4OagvoIYuSq7Ld6gl8Xzg0NdYUbCaRveD+4npcvbAodwcKAFQ8V/pTIQwRU/IiOWtE6Y1CQCcqaCK7l2bE6LKiNAa7Qy6WhgI3IcHRso82MCQXghwok2vqIp24wnVJLAoxXZLYZPueasG6Uq8AGGj1SUDotp36/8IJf4x141JCdSdT/SpwxyuXZFGk0II3aR2LMgNqThwq3wr74g9a0Kl95cUNijavqH2azyW35drEtfd/hAoUw7bAp0JkQkzWWG96cXU8D84VHf+9ffVkR7uQic/E5rd2OOexr/tET1+0gEzhRWpKKPYKUj+rqV7XBNJG5+u3e3yrtsI3T22WGDNGrC2QajQxmhvB2qixJE+euoSmnMv0jmQ5VBDgc/x6IthKjZ/Wbda/0pwEw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d554dbd8-2168-41a7-f39c-08dd81992f0e
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2025 12:28:27.7558
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gJb25T4gQJkBMUO/Ojzp/WCE5u4X3OG4HmNODoKQckSrnaH/26m9t2pOG/EpWXgEFmbQepGfb1zOZ7SnAPlZsw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB4895
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-22_06,2025-04-21_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0
 phishscore=0 spamscore=0 suspectscore=0 malwarescore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502280000 definitions=main-2504220094
X-Proofpoint-GUID: u0eG7kcT2HD5DKR8S8lJeuW5LdWEG_hJ
X-Proofpoint-ORIG-GUID: u0eG7kcT2HD5DKR8S8lJeuW5LdWEG_hJ

In future we will want to be able to check if specifically HW offload-based
atomic writes are possible, so rename xfs_inode_can_atomicwrite() ->
xfs_inode_can_hw_atomicwrite().

Signed-off-by: John Garry <john.g.garry@oracle.com>
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fs/xfs/xfs_file.c  | 2 +-
 fs/xfs/xfs_inode.h | 2 +-
 fs/xfs/xfs_iops.c  | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
index 84f08c976ac4..653e42ccc0c3 100644
--- a/fs/xfs/xfs_file.c
+++ b/fs/xfs/xfs_file.c
@@ -1488,7 +1488,7 @@ xfs_file_open(
 	if (xfs_is_shutdown(XFS_M(inode->i_sb)))
 		return -EIO;
 	file->f_mode |= FMODE_NOWAIT | FMODE_CAN_ODIRECT;
-	if (xfs_inode_can_atomicwrite(XFS_I(inode)))
+	if (xfs_inode_can_hw_atomicwrite(XFS_I(inode)))
 		file->f_mode |= FMODE_CAN_ATOMIC_WRITE;
 	return generic_file_open(inode, file);
 }
diff --git a/fs/xfs/xfs_inode.h b/fs/xfs/xfs_inode.h
index eae0159983ca..cff643cd03fc 100644
--- a/fs/xfs/xfs_inode.h
+++ b/fs/xfs/xfs_inode.h
@@ -357,7 +357,7 @@ static inline bool xfs_inode_has_bigrtalloc(const struct xfs_inode *ip)
 		(ip)->i_mount->m_rtdev_targp : (ip)->i_mount->m_ddev_targp)
 
 static inline bool
-xfs_inode_can_atomicwrite(
+xfs_inode_can_hw_atomicwrite(
 	struct xfs_inode	*ip)
 {
 	struct xfs_mount	*mp = ip->i_mount;
diff --git a/fs/xfs/xfs_iops.c b/fs/xfs/xfs_iops.c
index f0e5d83195df..d324044a2225 100644
--- a/fs/xfs/xfs_iops.c
+++ b/fs/xfs/xfs_iops.c
@@ -608,7 +608,7 @@ xfs_report_atomic_write(
 {
 	unsigned int		unit_min = 0, unit_max = 0;
 
-	if (xfs_inode_can_atomicwrite(ip))
+	if (xfs_inode_can_hw_atomicwrite(ip))
 		unit_min = unit_max = ip->i_mount->m_sb.sb_blocksize;
 	generic_fill_statx_atomic_writes(stat, unit_min, unit_max, 0);
 }
-- 
2.31.1



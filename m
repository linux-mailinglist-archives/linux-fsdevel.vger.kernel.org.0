Return-Path: <linux-fsdevel+bounces-75604-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QEWUCRXJeGmNtQEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75604-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jan 2026 15:17:57 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id DBE7D957D0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jan 2026 15:17:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 011B83017F10
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jan 2026 14:13:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D6783570B3;
	Tue, 27 Jan 2026 14:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="EHjbM1kd";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="vU/+tdhT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F237F356A2E;
	Tue, 27 Jan 2026 14:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769523193; cv=fail; b=FBZ+fsEljiHCZ95rKEpX3YMWep6HGezaDw12ma1mDZn6l72fuVVb3pXKc7+yU2C3u4vZ8pM9EM+6QpjUf62BIm4PxMFl3FdPbtyGkF63wSoUtPZRDuY8Xmc7Kv7ya1DPAQZTZgaHjmwSk1O8F+GLjSz62KZ2aQ+X/vP7rQwJmWg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769523193; c=relaxed/simple;
	bh=ARFY4rjAL//11trWi5bYqlIBcMS/7aw7MNmJUV1dVFg=;
	h=To:Cc:Subject:From:In-Reply-To:Message-ID:References:Date:
	 Content-Type:MIME-Version; b=kvHl/jXcADXBRvcTSN734bQSZvXJucltKz/giY8O5OVim9WOeL0I7yBa1lmALKtVeFYEZ1Dd8pJRKdx3aZSvrhLQQAcz2duHUl7RBDFks4CAqM7wun4UBvJmqYhmZbyIcuchdhoy5bEwWGyyCRuK2Jl9V4Gi9gjDb1S6AbmMiic=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=EHjbM1kd; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=vU/+tdhT; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60RBExNR3281694;
	Tue, 27 Jan 2026 14:13:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=QBU6cyHONMF54AJKWe
	hcoe8qVmW89H6IVSwb+Lg8CaY=; b=EHjbM1kdtVC3lT36iWEAcrC4vI+7RuT1XQ
	KO2D8dpEqBPK2xF76Vrv5wOvBqZrtDKts9PY3k73JflCOTBI460fPq6T6YFiK8y1
	QhJ0fQlWC37IuQghWQmFowDbZSlyfA465W2aM8QKNPYRg5RU1OEvsersP/FJev9z
	rooQk231n2AVuL1Vr4W8R7wHwfR1gy8tVXFA5Hqx3QYJA7i41NZA9WpwKF7xrFPT
	Cz0bDOUo6JIAGcCUBQxoPheOXJDI3R8nQVWa5gTH4ql/9cXpM9JxyMmjHQt6adEv
	bV9Zq0FnUrRovUBFIVtBv4wvtoBoDynpJaHeF5uWry1xc3C3xLsg==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4bvpmrc20n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 27 Jan 2026 14:13:01 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 60RCVutV001744;
	Tue, 27 Jan 2026 14:12:59 GMT
Received: from sn4pr2101cu001.outbound.protection.outlook.com (mail-southcentralusazon11012031.outbound.protection.outlook.com [40.93.195.31])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4bvmhe07ut-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 27 Jan 2026 14:12:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pPMdzNJ+LhKtmL/RQAjm1Q41L2p1oFToOwjfyaLx9DVJJdaKhxodNq4FyitdqDQ7Sh4zfKD8c45JGBEyVSPXeK+bHp9w7mPX/zg4vpMZSo/HV8eUfqasbFnre108rVM98uLuKpKC4/xtR/gT+ddT6mmkWjUAx25J0MkXe8Gjbc+P0+pvp0HEB0HWXVkFM2g2qVBEciAHHJzPoFzLZSRRdi/SaQaln+3NwPunXiGGnDa0lqgge9QZ7IPGpQKEb3mWjSVH7F9xS7ItFQfRplf3H9MBU3cfV9awUQPcXtByTZs1n0jIyV7nkOzbFJiO6+IV3N41Tr/8vgnsDDOf5cg+PA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QBU6cyHONMF54AJKWehcoe8qVmW89H6IVSwb+Lg8CaY=;
 b=B5Fyno+psh4g9/w2HptKuW+n6m0BIBX9PXVUaQ538zC+Do559oRi/ENZ2K7lAWaBFtevxZpTurg7lmwONB2T0IPfO8GwpaCwSF7zB/fdEPVNHA/6CEPQt3kZkPziOH+QttCkS5lssfBmmyPiMV2xrq+z7s+Hqs3sxhfgLNufb/kLanXggJtG5jGZvu1heEiuFMJ4yPcig6LX2vPaoVDSJeesS0DICsJdQVpa3lccjE0HEEEXvPovH9XtEnhkmGvXxDygdH/M5u9WkTgk3L5+foBgmMX6vGHo8Y6T0hpMCOADbGAK+qB2BaO1t8+0XiDAen7hHysmgeW4YmQo2SfwVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QBU6cyHONMF54AJKWehcoe8qVmW89H6IVSwb+Lg8CaY=;
 b=vU/+tdhTbS8Rirf1Ij5SRFo+FtFEYHDFev1ePODrlQPEJj/1+jJWZ706NBx5IsJD/oJgzudAsYOuyErgu1ObX6SqOJsXvqbmG5hWrF517HNcDUkB+RnAD8DNq7zhhg4KP1oQpg0lVrsFkB23P04FqvQ8z3stJ6OmAmTNxLT2gMc=
Received: from CH0PR10MB5338.namprd10.prod.outlook.com (2603:10b6:610:cb::8)
 by SA2PR10MB4667.namprd10.prod.outlook.com (2603:10b6:806:111::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Tue, 27 Jan
 2026 14:12:57 +0000
Received: from CH0PR10MB5338.namprd10.prod.outlook.com
 ([fe80::e525:dd71:b002:6ad5]) by CH0PR10MB5338.namprd10.prod.outlook.com
 ([fe80::e525:dd71:b002:6ad5%6]) with mapi id 15.20.9542.010; Tue, 27 Jan 2026
 14:12:57 +0000
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Christian Brauner <brauner@kernel.org>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Carlos Maiolino <cem@kernel.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Anuj Gupta
 <anuj20.g@samsung.com>,
        Kanchan Joshi <joshi.k@samsung.com>, linux-block@vger.kernel.org,
        nvdimm@lists.linux.dev, linux-fsdevel@vger.kernel.org,
        linux-xfs@vger.kernel.org
Subject: Re: [PATCH 07/15] block: pass a maxlen argument to bio_iov_iter_bounce
From: "Martin K. Petersen" <martin.petersen@oracle.com>
In-Reply-To: <20260121064339.206019-8-hch@lst.de> (Christoph Hellwig's message
	of "Wed, 21 Jan 2026 07:43:15 +0100")
Organization: Oracle Corporation
Message-ID: <yq1tsw7uote.fsf@ca-mkp.ca.oracle.com>
References: <20260121064339.206019-1-hch@lst.de>
	<20260121064339.206019-8-hch@lst.de>
Date: Tue, 27 Jan 2026 09:12:55 -0500
Content-Type: text/plain
X-ClientProxiedBy: YQZPR01CA0015.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:85::20) To CH0PR10MB5338.namprd10.prod.outlook.com
 (2603:10b6:610:cb::8)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR10MB5338:EE_|SA2PR10MB4667:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e359388-9ac4-47c4-8c95-08de5dae2b8a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?6ysanJo2O7HEV9pKap54zPhhpoHfmJXuoUF6uqenVzoeNp2kV7irV+X+3Q7u?=
 =?us-ascii?Q?MBj2iaa67oK2e6kNjCSYSPFHZqwHo8pbo3IFrdCERp+jHLbSv2W9w21yRbKD?=
 =?us-ascii?Q?Jd16reCCH/OHPeUYt8RhLljMKRYARZQLXzfItqwBK8adySterqMBDvCPLLvs?=
 =?us-ascii?Q?nOJJMCn0ppAaXhPRLipogU+j9MoOXWeBtS5vCHI6i0LvyZfad7VZ9z2oATde?=
 =?us-ascii?Q?7eIMB8DGSwA6snLb/8G89fERN04ip7WEQTbb8cJVMiTRkHcVf+8nVkWDJUOx?=
 =?us-ascii?Q?dbm/6KgGf03SYidar2Rmo0oAv/YGYoqG7DV9cQowS/0COo+UxPCnoASOthH+?=
 =?us-ascii?Q?quYQbAQJY9LW1mZEQHtQHiht0UVPsCafoXgqRXcw9ztO7+sbIOGVbuKqn5y/?=
 =?us-ascii?Q?uRIJ/KktMBLdaMrsFAH6Ak7wtKE7Q71KFMNo/No00XSR1fhhmjbegGu7X+SA?=
 =?us-ascii?Q?LP7NCwkBJMxCXCl89ZKFwhgdtAs1TSrsOCB3LaIMxGsxlHN29U9DYf26ncAf?=
 =?us-ascii?Q?zN9bYf9WqVD/Q8TpU8ZigG7e/nBx99znc2JhCYytjcT5e1fqgZ0j4fZjXf4J?=
 =?us-ascii?Q?1lfQ5kTGxgUFQz7BiYreSprxhWDaF/9pIqWRBk+EJ7zZ8Pjla9oCckRGp8ZB?=
 =?us-ascii?Q?pC4B/vpE5fXva9eo7bwvyLcFOK9fecbOul9vsHAGdBzUnNIO0wz99SIOFTXX?=
 =?us-ascii?Q?EHKPVuPR4K6Z2TFG2qzGQwchD8banWsyHuoo7j1R4f/VAjh9vPqxCiVcwFdB?=
 =?us-ascii?Q?jeWAx6yQ8ZGSPc08Hql+F1nA9ZM+vw2NwiOWFdQyTj2Z+JToT+KY/zYgwQO4?=
 =?us-ascii?Q?SnrS7T/MlcRXn3In/Eio2cOAb5N+FZUd2qnOJuk9Z/s72RIZenzCCitn9gD5?=
 =?us-ascii?Q?hLTDyeCpr9YBT1q+EumIiwdGqUs8QmcaPVFjvKq0C2W31mwD17XriHfPV1oG?=
 =?us-ascii?Q?2TP/63jHuOe7TfZZGKG3iW512ef6fbfYqPXma3G+4RTekQvlZxcK/sHwEl5F?=
 =?us-ascii?Q?kicsrbsvUUtg/Db0l0v9H3ZFwuQTInKqfUaAJ/J46EPWYQYi13H+0/YV0ccJ?=
 =?us-ascii?Q?FwndRss0bnsGd0T6dKr+ekNVIx0S7EVkkUCS9xGon9w354R8JkZ16F4FVjEM?=
 =?us-ascii?Q?k+E+DjpLksWkH1rJTU5Jr7eMyYdB/+KD9qNfwWuJXvC1ylk42R29hEELAQac?=
 =?us-ascii?Q?csZZU1apwyzqInVfypt1iEf0UJ6VuNlvCHRphf3NnoxONT3Vxa3CSnuVWljO?=
 =?us-ascii?Q?Ncj6j1U+0PuSjuBDeA2M2XOQwQg1osnlwyqCVOxkRSNhk2gXPhvCZF9p1h4S?=
 =?us-ascii?Q?FU56g1PNYTO9nKdbj0wFk5LUqFWoB3CdjLmJCs9AnN/4FEifk9tdrzdjNkVg?=
 =?us-ascii?Q?eELDOozvBM1uMceggGXC7osAwsbDl6SLbcLvL0YhAvL+Xi+++r5VlNQYlMzd?=
 =?us-ascii?Q?P+i6VSvM5MzJm8Qj1RH+oaghUwqmkqqLwqqQLmF8ijKOij47mTZrH0+L/htX?=
 =?us-ascii?Q?UjhOev8RHgg/eDgUCU4E8MvH6+ybbEhjs1XhvC/z6gvmn8HUn6orW1UqP04Y?=
 =?us-ascii?Q?MVfFJUQ1v8RIVf4SJdw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5338.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?f55TsLcTLdbs8+l8Fe7FKpbrUZoIzoWy25sc44i+Zm7+YsYfQHKLlVWOjgNR?=
 =?us-ascii?Q?BhIFO4aXks2zJ5B7AGlCkNcOdHLgUitgzhvj8DKREBtG9ra3uTlvPxojDQuD?=
 =?us-ascii?Q?V3AVajzZiu9lbMuF3CIj0AUglFuUoHp/HKWiPLoZYWa8OVVsFI3cWCn+Ve2L?=
 =?us-ascii?Q?uiQB/cWQpW7geNNPwlRdvmZ7UJvPjn8lmjhLayarg20PCyFAKnxe/UWocxKN?=
 =?us-ascii?Q?zQ+BWiPzI9TDCRVRUWhygCWpYMk/JY65a7IeaPy6WzuSsQD4F5stWZlcSO/6?=
 =?us-ascii?Q?Bi1Yfedqp+RoDuHFd+5Y/e0qWq0l2WMDl4pHmK55ctmudZIKZ7IKEDs9gyQM?=
 =?us-ascii?Q?I4zqS0F7AGNXzQbRtw14uf+GV/WBzU1US5bBXC8YwAo/En3xbVYyafMqdiZP?=
 =?us-ascii?Q?lCFrFLbisrzAFRVI2VKIxjf/Ats4NJWeW67366XCOehVWBgf6bS6kSvud+kC?=
 =?us-ascii?Q?3dl8SG7rHuoQ9PuLO3OwbbaLen8T6sPKsD0MQMzdmv4TLYfsLxiQxMnyLXdh?=
 =?us-ascii?Q?AYNB2NPHpeWpzdhMw/zrdGrXXxsxjV3AxjYG1cZsWYpl0PK84cPYZXXnabq9?=
 =?us-ascii?Q?BX5i7dnuOmxbPSq6bHOzoc9/huMpULxyF3ze2dyiNaxmN6Q+x12LXULFHeJm?=
 =?us-ascii?Q?hVWuXcuTfvdayuQFUcu113BK76BXACSNqtV0V9imUcj2u8bSpDtYJnzBaZLo?=
 =?us-ascii?Q?PHtwKgN8W1ZjCTqvmi6+2cu2QHEii1CSxKtLzCoWEb5KHvRm0RM1mUhxq2Zo?=
 =?us-ascii?Q?+Cu2ER9DQd/ssYOXavQ2XOBYjTllI6hi2UWPe+7CyPKz+k4Xjneyd1KjJSIL?=
 =?us-ascii?Q?S60RAIa/TMXA+wTGgmKX8gr2NLiY6G+txshuGnIwN+wqRSL1/nuZMt1pzbTL?=
 =?us-ascii?Q?On4JRwlZRvckn6V4Pt2qo9g9JgnTO93uL6ueW4PHTUEDjyhn3cxQnr1TYm8X?=
 =?us-ascii?Q?BFEJkxqGisOblHtzpeq7narCtvVloq9UJkD5kZYuBLBafLRqB6pzQ2MdkM0p?=
 =?us-ascii?Q?IqcwNTjPScqy/D4K25vY9yZaV45aQ57qwgRwMRReVy7pQ56Dye7AfkvAzFkg?=
 =?us-ascii?Q?jyN9+cdMaWoTt5YxSmMV46mJBBnvr1Hn4vEvb4W7BChgiWiWUsx3T6s4Gp0d?=
 =?us-ascii?Q?uUS0zllyUXaZjq7AUj1ZpkNczWefJ4jh1aPSbirfkOldL2ERVEfm0RLAiPmg?=
 =?us-ascii?Q?5+ZPc9J2JGyO+fsK5plswIMGw/0WE9YCagq1qYtmhUPUsJA7OKzWyg91yvuE?=
 =?us-ascii?Q?yL6C+TMOkWG81ak9rUysqLs8mJ1X9P1BEwmUI/GE/brWkvtfiVS6FYJWrpVZ?=
 =?us-ascii?Q?DxUhGuqipLGrM1eT73GYnE3v+5Qn08ZBzS9DsWWOx2f1fLI8e/aKixSReWI0?=
 =?us-ascii?Q?VEkEM1wxsUejwNFsNWhy36+nDMPq6fpD4VUsJKdkbaPtiTAx6KHkiZGYsHvv?=
 =?us-ascii?Q?demvWXQ3YxG3iCeBESXQdsBxXX4jD+bTWUNdW3tN2Z3+/uxON2wWFWfN4btq?=
 =?us-ascii?Q?uNehBTfklDEI5FyTWQ/LYWILhKj4BnUomhrl7R0U0S2Oig5nmu3kpbu9fHWZ?=
 =?us-ascii?Q?jpSArwaa1Z3xJauf/9ZNtSXgRxNqvzitfj/UlybxsaxjWeRHY6eRlRo532RG?=
 =?us-ascii?Q?RR/2XoHTByAJmO0nD3GMXjdtMFGelw/qiO24WJwre4ZlYwXIh3kA5yHCXoe4?=
 =?us-ascii?Q?RNF8lEmg7hN3P4t/yzPg4mAyuT2ht4BvCa3GA+eYS4TufYBh3WhRuPj1a+86?=
 =?us-ascii?Q?WVakjcgtB+sEYum+9Shu1bCiNRhJ73E=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	dSx142brIcvK1zFRIoIkgvynlHpPg+QxesEc+v0e0DDwh7ykpOeXko9jD99Y/rjcStUJVbopJDOhAUOh4fA6XDzwyYKiNhcg7DxeyIhl3cgPVXAj+09k5VhQnrKy9Monhpl4A/7xhhYcSLziDJ97jzwMtbleYe5PMjP6z/yIw75ROI6VXCUW4WquOvvLSiioKuU24xR3OSZHtBFTbMEcclPz1UWi74s+bu9/otFiTpRO/gX4cIEHy0aHZtRHfmOlEkYcnULagXC7Sfm3KJ84cExH5t/Q90oWQWvQdeW18FeK8VQki/QrASkJFeF/wPsKU8pusU6415NWuMl0Z++IgZUdgo6h3On85EH+EC9wPUWfiJMd1T/eRs7M0Q6qrMY+m6j0sj3taYDb5m/blwj67qZNXo6XBugqw6PICCyJ6+LBgOfxqEbqig3OwXCKdKp4b9sXkfVj2o0DVMjPvnJhSXGpykasLJmS3lbLU7Jxee3XR096b7F0EyunH0MZXv3WFgZ84YwBJeWkQiHHt7hXJbEOycYqPP4dk61nIiiYi8V7Cj1yTcYv/KmC/LboJpJqd07feT2I6wyWNlfCF59DKFQWklanpkNRVgGVuSD+T/s=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e359388-9ac4-47c4-8c95-08de5dae2b8a
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5338.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2026 14:12:57.0444
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OLoU2HHwhAWhRU4extbIqaqAnlLRfYWxLUIO19bXTNalXoymk78WD4vwo91t9t61EwPlttssXA7QQu7U2i5DdN1XszGHrd3hCC/V1PQMM7k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4667
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-27_03,2026-01-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0
 suspectscore=0 mlxscore=0 spamscore=0 bulkscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2601150000 definitions=main-2601270116
X-Authority-Analysis: v=2.4 cv=Q//fIo2a c=1 sm=1 tr=0 ts=6978c7ed b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=vUbySO9Y5rIA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=yPCof4ZbAAAA:8
 a=-gsorZdduX_-YwF5No8A:9 a=MTAcVbZMd_8A:10 cc=ntf awl=host:13644
X-Proofpoint-ORIG-GUID: q2Uy8F1d99OUqCrWUZaEzv9LIxRDEPyP
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI3MDExNiBTYWx0ZWRfXxMjDqWxEt550
 0QbrN+zZ9TBWo8HkuDhxWXodW8JCXEit9ZnuzfgIzeb92A3Kt+Lodx5KNsE/6WM3l3cz0LYtBMs
 lGnT7o+uMaxIxjdGnJ5fHAO5jXL6NyG5Cz3o3bL24N9ELhGiYLz3TE9DWtRoQ1WGvqB3SuKXPaW
 2JFDArZpnoTYEWERl5b5qDyfy21WAygl7g+f4Qr2irJXowV7jM/cexFAQM1qhJdu1kvgKqDulpG
 qzIxYpCn5oCOKRHlgbOGlRALn8LJfsx/ZfNv6oGOedQirtxlxxQ1qx9yujfGj8+rZI7i0F15qLa
 gQvQf85SpBaEazmAdjDoSgNRMKE/Gn/IEoRjZf61Mg6pLM4HekB+HzeYcgcXy6POXNIY8perU2a
 HV7eA7Vw6/t9sY0vn+J6W2QudXrQgAuRs4+bI2ehkmH7gLsGDSkRUDzwroU1pAiVmhmVZMnPRng
 xl+nWJCavwjrXQS3IZuji4/KSCjWYpqjFigeSe3o=
X-Proofpoint-GUID: q2Uy8F1d99OUqCrWUZaEzv9LIxRDEPyP
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[oracle.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25,oracle.onmicrosoft.com:s=selector2-oracle-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	HAS_ORG_HEADER(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-75604-lists,linux-fsdevel=lfdr.de];
	DKIM_TRACE(0.00)[oracle.com:+,oracle.onmicrosoft.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[martin.petersen@oracle.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,ca-mkp.ca.oracle.com:mid,oracle.onmicrosoft.com:dkim,oracle.com:email,oracle.com:dkim];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: DBE7D957D0
X-Rspamd-Action: no action


Christoph,

> Allow the file system to limit the size processed in a single bounce
> operation. This is needed when generating integrity data so that the
> size of a single integrity segment can't overflow.

Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>

-- 
Martin K. Petersen


Return-Path: <linux-fsdevel+bounces-47853-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BA31AA624A
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 May 2025 19:27:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 837DF4C00B3
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 May 2025 17:27:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A70D621D583;
	Thu,  1 May 2025 17:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Qi43DYV+";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="FkSXBrg4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61D6B21CA1E;
	Thu,  1 May 2025 17:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746120453; cv=fail; b=Vb5RIkmxwSLvdWWJv6sFvb+MXL+UqNNfaUW6vG/QNbw4TQCVNPpKH8Aeu5Pta/Hf6goBdXCi4zTQluaidVE+mEfk4ZkGIyNM5pRRirsnbQMInVJGjsbeiMKXO8MG0AqPyxkSkGAknPbxAPD3RCJ2P+YZL5j+912APPGSSdTsu20=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746120453; c=relaxed/simple;
	bh=fPhMg/ygEn25rhC/UqWAWTQ46CVYXx8gATK255zdWQ0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PnpgNF6yAd+u78T9PQzpmVACiCjkJe319tPwmOuqzx1ueYPiI+DT8z0eKlw0UUKJ6fYTTQnhCrPIlm3f3TZT1nUY4Unn16B5bjCgfy4naOtkdlCeOxTyIcGe8bbMQNmvuSq4D6XlEITcTTqOxt0S3aJJPYGmDwT/buIphZatM4I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Qi43DYV+; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=FkSXBrg4; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 541HNXCY002125;
	Thu, 1 May 2025 17:27:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=4kApGDYSYw4N+aTnr0QrVKyTqMzW1pKs1JwehtXKuzU=; b=
	Qi43DYV+QQFCWdHeUjLtW/51n6rVEheBZtuPHJBVWXGpRZ5ElYb6AuAK0kEUeHZr
	Okx80FYbf0YKKSV0p31UimKiHfEpwa3cqnudRFdcCdwmK2JwjCLPdY4f/Zt4j0A/
	FLwHePBLrlSGT8YcDncZXXkSPZAyOzEFzh5HxpJlIbRhAlvBrHozbKSIz3OsMMFk
	e/cP5WKQ0QaNWSNx5CribnnSV38g+zQXIEkPd2N5LyNiwxJpFs0kWsTq4kD+xeu4
	yYnjSnPJNAiRN3elH3MYCigILudvPcKSTCa9syEm1HfYtXH5+OmA100IwhjKDbd1
	HcmyBKS7v95E6nbp+OKqWQ==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46b6uskh3f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 01 May 2025 17:27:10 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 541GW343023986;
	Thu, 1 May 2025 17:27:09 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2173.outbound.protection.outlook.com [104.47.55.173])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 468nxk1pb8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 01 May 2025 17:27:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UhbK+E74Jgb86s2IKxcPQh2P1o3flQDvcQ2EJ+hI1jZ+O6RiiUlAfgzj0whOIyQazQivsJVsbV8FJKs2FO12348asWjxs2/KXtZ5N7iGv6QI/Bn4uzj7zQ6CB16tUW2aK/1g4mLkGTWfRTVLdppVwA1m1ZeWtrhGahHkp0jo97BFr2U9V44HFTArzqtH76rnA60sQnrMcBkkzfRT4VGrbNUQw9O53Z65XemzDLT67CkIgWdXwjXcaR1Fh5+VNrLSRDVrlRzdey6sSGJn+5nUXlBRPASsoQ1Z4nWS4iXTWwpNCTPEZ+SXiULQNqmgug7Aroica8nkMCSeT41l+xv8GQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4kApGDYSYw4N+aTnr0QrVKyTqMzW1pKs1JwehtXKuzU=;
 b=aJkOtVVbehH9vWOKu01dYMn2V3B5XKK5JfbX0oNM3rIQho1T/IGwnK6BqPyP7yJGuRfdW+Eu+icPgJPWMi7PBMemWEtbJLDVPynfeYSaBQYUt0CbSnzaJRyNu83PlwsVhDBK1h/uaR6tZgTDWM0kFQac4Ds+GoEniC02kZa/Xy9KYb4qqKA0ISXRPc+Fa9GVzHDJd8Jo7SALCay+8K0NBkDuYvsLPMxhNTVvhtuVAhd4O8+U7lqs1Oyl2aUbPQIn/tkKLikSNWJarRWLgoXVJ5CP5iA4cCLKEi93hHVpDUtMiCj4DJoPN8Otv0gWGGK80aozi1jGLtbjBhnt0Lz+UQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4kApGDYSYw4N+aTnr0QrVKyTqMzW1pKs1JwehtXKuzU=;
 b=FkSXBrg4s4qaihhnI2qK8FmMxyDweHU+0byjiL8x44LHK8amNbQZiCfDnPHTuk6wfGqGlV13FeHX3x7T67o7DAfLoI/s2Z+qgOAXP2QUp+Q4tj4If9P7db2xzCZOb3O2moYBgt/QlzdI45RKVTCqJZANTJYIPflWf79H2JU8qSA=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by CH2PR10MB4199.namprd10.prod.outlook.com (2603:10b6:610:7f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.23; Thu, 1 May
 2025 17:27:07 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.8699.022; Thu, 1 May 2025
 17:27:07 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: David Hildenbrand <david@redhat.com>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
        Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        Matthew Wilcox <willy@infradead.org>
Subject: [RFC PATCH v2 2/3] mm: secretmem: convert to .mmap_prepare() hook
Date: Thu,  1 May 2025 18:25:28 +0100
Message-ID: <987b620592ad6a472281039c07cc1d67e48d864f.1746116777.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1746116777.git.lorenzo.stoakes@oracle.com>
References: <cover.1746116777.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0684.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:351::17) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|CH2PR10MB4199:EE_
X-MS-Office365-Filtering-Correlation-Id: 116128be-a4f4-4707-b6fd-08dd88d565fc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5ywghiBjILsqitGHbZXNTdQI5+DlFe4sQhImpI4nyjZDx4vHvQeop1zt7LU3?=
 =?us-ascii?Q?M5TCVF5NzKmLbSlMr3a8dKfJzFAePb4LYeBGdrAPmt35VwQviWBYEJmFqJss?=
 =?us-ascii?Q?ewYVlycgYBgnR5DELB8NZfr2lKX4NIK52gVn43YeH7EooVozA7ZV+amLJzKt?=
 =?us-ascii?Q?MKsyCBSMEnaBC8z6PNcYNEmHXQ8yDy3yX6UHHv3Ex/qAf4TApE7jUGtJeGqE?=
 =?us-ascii?Q?r1CtSjxDSQJYBuwhdRD3tnYjFZYgAfKepXgbgHKsqGpH0nf1HV+ykwN7tzhy?=
 =?us-ascii?Q?CG06RHhMldciYexYHetZ1ND+dbIRLJiZRYJDSWhKicNa2+ubejPZbYB3VvmG?=
 =?us-ascii?Q?CtueIh/czI5SEQUtNjBpUJYoIjM2Jqee5JPihnIU2Vl1COfNblvIQmODzmAC?=
 =?us-ascii?Q?+W/riKNZ9DPiIcenhnyDN6MayS6vxTXXWMUD8ktGu5q3+yRtgqu/orrY8byc?=
 =?us-ascii?Q?aWjm5bSCtTU8KOwhV5SUjbVnoC85120YIfTpgR4r9S8cq6eimzeII4C/P8MR?=
 =?us-ascii?Q?7piM1I6b0Fu+OIF+n/aiof8XgyowDmSm191KR1wE2QrYLCfmpXa24Ou+L++t?=
 =?us-ascii?Q?SiUBG8R8bGW68RbU4nBWhvIQfnLPFeOaYGQwfdUeSAYyPj0C9nnT24k3v+iJ?=
 =?us-ascii?Q?xwz61TAcHIloBB2wLterbzC0jlUL6EGlPyb3PT2qc2rjYAo89G85NTrROIS8?=
 =?us-ascii?Q?v0bYdRGsrvs7/2ut3vK4PM6htAB/3JgQVxwPjpaQ98YUPBPVUmD81ujjwqFl?=
 =?us-ascii?Q?wuqAmXZmV4hRA9k1wCCdYXFgsoVinRlkTf9EQawW0gXFuJ+jDXIToqCIZtRP?=
 =?us-ascii?Q?yggOjTfz3pz7wAVhc1XCcqaPS/nN3odvUblj24tldgiqDBDWpsdI1Q/7h9d1?=
 =?us-ascii?Q?YkHapbQLfcLpWfBdg266GryO+0qscVOTf2a9rKjgNjOTbz8o/0F502+5jCb5?=
 =?us-ascii?Q?Q8AwxRkmy9JkYW6sePi1KSncvwg9xiEY/9xbYRMoU6LvD8LVCJdWwTDySA7I?=
 =?us-ascii?Q?7QYqRdX6nCs4BbCHU5GYE1sD/VlFfDEbphNWZOq24owXW6ocigsY3ZRC+R9W?=
 =?us-ascii?Q?pgMCAM49klTtWx5oeu/uIUk6RmwotH5W4j58lyUG/DyedTOeVMg58hibswQZ?=
 =?us-ascii?Q?SGOxN8DYpB5vt4cfaY973b0d+fyugoHfeWzrDqMl3Jv3MR/Db2ATAjoDWmG1?=
 =?us-ascii?Q?CJO6JyAG05vsK/f3EXEbs+5YOow9KPdigf2YxGFNtwqb2F6OOqGpg+0GwuD6?=
 =?us-ascii?Q?yea0OQkQhHjpJ64S2m5tu18M3DjeN1yjHu1YMWG42ZJr2lgonITFfQL8Zgjb?=
 =?us-ascii?Q?OOEWJ6Ud6I2SR0oTZjoQUIicrRi1f04l4JPU7pifeN+2yzxbAzVnbURpAcGw?=
 =?us-ascii?Q?bktyZ+bu5jhpxPNZmZdsjTbKD1qddeDzeeIc47pcO4WOaEmaULs+uVaW/Ydx?=
 =?us-ascii?Q?lO6eC0khgB4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?CWjHSwcpn5S765uXQ2fD5jUwKY7lTF1Q0jdlCDcME+wAY7bJ7xQElG0MCEkv?=
 =?us-ascii?Q?DKVrJ6yh9VQRX/v1sP/fl2ZbqplB+clINYHQeLlUVHeHeZBzzwnUZzXGtcE4?=
 =?us-ascii?Q?4rksixkRwIsEiV7zktkMuHEAtvw8DDHavubOTZu9qMvFDjbJoRD8DE7gfuP3?=
 =?us-ascii?Q?WBSSmzN9I5L+r56yCefh2nROeKqD35tD3APqSwiLqcM+i3szX9OawwirYyNp?=
 =?us-ascii?Q?d3tb93weMiilSYzX0O3m/0RPfCUxzVu8Ad5+89//EQJWdJg9PamITGlH1jVA?=
 =?us-ascii?Q?nicmXfOyi1+AvQbDcUdhVlLdM/mb75DtU3Zy7Wr+tGh69cdS+eOU3sosXWQW?=
 =?us-ascii?Q?ePpazuYTZRWbtSOcn2N8PratDXBxtES13Mlh+XTE1Mi+F9lVUUMrVN5KocTf?=
 =?us-ascii?Q?m3INwuVteAKewGmQoC+LoFcDo0nyYFEqVDL12vxZncNR+sGo2utzzi8XGvhm?=
 =?us-ascii?Q?A1CepPAj1HJfrGPP5SMDJrrDUC7vXZ93OCEpDQgVdjRTBZIo5yi5pgXFn3/w?=
 =?us-ascii?Q?TV0LvePk9cTgMBYPuV+/Ko47UxhKQiM+N7Ilzysu+lPC5M/JlChu5suEPRmk?=
 =?us-ascii?Q?GCO3yBc4csw+DH7T0bntQHzzqzMUQxuquJKjuSIkjUktzl7Q93v5WhrJkcGL?=
 =?us-ascii?Q?NwgEm/3RvDITMy4D4I4m78oO3P5jASxW6t81fAZcTZ3JqN6b56AhkbjEocwh?=
 =?us-ascii?Q?3WKooReb9ZMqstk4ESNIyGtue/ojSxjoVg8ase5TpGOqtVsbhZd9xr30gmDT?=
 =?us-ascii?Q?pVt0MZcxyNWL2kqat+oNm3TQndonLTx+uSCpzaFGLC8Q2qu4a9mkm97OLGyn?=
 =?us-ascii?Q?MKQCAwG9tKFIwSiu1HorG/Kq3seWtVu1xCXVY/XDYhKH2qvC/A0Uj2Dn0PAy?=
 =?us-ascii?Q?YQ2qyXG9NN0L2zYzmZtmlNOvhkVrb67n5g7nAJ/IR9cylvsvU1EfUWF9L9Wi?=
 =?us-ascii?Q?j59umtDoc4QEikxBoyT2vku3FdUELr+fLdAvfq1baf/RN/9MZ87DSGIBkIAM?=
 =?us-ascii?Q?W/z3EN13q4o1Y8vvXF2OFS0y6HEIX6fLK6XM3el7VCQAYdozoBlcGtEqI4r8?=
 =?us-ascii?Q?KA26lIZ1K9w1zdDWPn6M3aPiyvf89MdgEt3ZoF65BZlgqEwHGukMwHcLoFXz?=
 =?us-ascii?Q?QsEU3+vLGv6692zZIPHickepQQ49mrznS3Jy3uaM9pzvuOfV9udlXY0q7iHt?=
 =?us-ascii?Q?rN4IYK/nwgNogOHY9jUnRv5v2aSgc6xKT3nT/MP1Rat+X4XiNiZhZG57wxyB?=
 =?us-ascii?Q?uvba/Qrg8c60L3mNM94mP6SUOotKk0Gc9aQWgpn2PZUPn0XeKTqgG2IJkldS?=
 =?us-ascii?Q?KogJQB2MN++ry9BXvcbFGkC9ndQbtfgRXaCTvwBfpJYA9lO6Ud0Nnf/cqi3R?=
 =?us-ascii?Q?NT09LfSmWDOvyS3f+FCGM6AuVygVwtQkaqZMrCZEKz/NIbb4vFMZBdMhmGbd?=
 =?us-ascii?Q?gHcM8TC1WU76Nc+7BqQLVhBSfcqipm4tQZT/8U/C3yQNGVPuW37PCLWrdHpo?=
 =?us-ascii?Q?l7HiNmLIEn8P/nSzlVd5V9B+NzxjEGYj5bEDtbja5WF5+d7yvw9ghnRLbrba?=
 =?us-ascii?Q?NFyd9xSbNolREm52EmNd3+620RpVXW0XB4ZaicoIezuiVYKyV9vBBWMbQyIp?=
 =?us-ascii?Q?uQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Au8T/EY7fsSkC/MRxrObVFehXXnI2jOWhrzWMbfM+ms+W97Q+DLh8jSS6a1W5pVsP53eCQX1HRAp0m3FYnuBLDGBjlf1e77Rrn5+QpDhq/ScnWkX0XBqbS5jol2rQnV7kBARMARFaFcu8wwIBQ+oW2TVZIP9Q/Rmtu2j7hVZJ6kOtaQVw/diyfiQgCY2wvH716l4WKfHNAExUtz2khyr0kNEHmmftXqHKOuJoOp6wpBFieJHl5bQeqnYzzMlp8dMtFsO1TqOp4aWqjS5MCnwXpJv32daU6WEsEEoFPIoQgwjJbI5X5QDLtrVXLkZN5gSj/0W1cuSEgmTRgifZbqtHoMth9qdd99LwdLvH4r4k3m8a4y6sDalTyXvrX7EGg0O74Daq+9z3QUo9dJBGk76pjB5w6TYdXBZl87euj8Oq+xRe5QF2DPsm55Q6CDBYUOcXJ3nMxmapDl9AgxdLJ/GzNfIvtlsnlrg4Cce7ImgkGR9gLshGBNwnJ+gXGciNlXSGhDd6BdwnfUXo3yf5nfObg5VGszk0Mxb1vhD2U/9D9DHeU3CiVqyqOElXI2f6vAWCf3ztyLFL/hD2bV5MrBz+ozQBslKNmE3pI4Oq5+07YQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 116128be-a4f4-4707-b6fd-08dd88d565fc
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2025 17:27:07.8029
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zENkpIbmw+FN/DX7iUVcFOeGRZ90nahFg/CcBkccvQOvc9gVE64ttGNzBVH/1jACld5Zva3TQJ8D5lsP5aZLFAGGO6H3AMzgsLvjoD28f1A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4199
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-01_06,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 suspectscore=0 spamscore=0 adultscore=0 mlxscore=0 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2504070000 definitions=main-2505010132
X-Proofpoint-ORIG-GUID: 60p90wNtoaUPjBihFTyWmPuJZObTfKWb
X-Proofpoint-GUID: 60p90wNtoaUPjBihFTyWmPuJZObTfKWb
X-Authority-Analysis: v=2.4 cv=Hd0UTjE8 c=1 sm=1 tr=0 ts=6813aeef b=1 cx=c_pps a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=NhHjvP4nXqG-YQoyrwYA:9 cc=ntf awl=host:13130
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTAxMDEzMiBTYWx0ZWRfXwkTDEhT1YZHr 2Ddodcl+rfQG28a4t7czSX8lBvCKO+FHWSBZgMQ29R02+PggH0vlPzaMEXqdUiBvNotPbPAQYSU qQJrVdn4pKZcqsXYjXWW9Oz99aDEG2dyxIceDtjL9FgJ1dSt1Ql06wiqd+LhNr9Qg8jZ3WGZ5rh
 iAW7rDwyk5TKw19wTHsv0t27d6QRw9QXAOrZS3NpH4Cgv0bMe3pNhCPXKeOohUfeOXIZNeF4k/a B0QNiOTEyJpj4YufDsD+NMxXdQg4CdSqgMhW+03cdcKFT9eZx/PAcPgqu4wBy9cvDnAyG+gjXUW s3nPsJJmMeUDW8HzLy1jYxDmKN5ErNMDmCGAY1rW97CE5n9nRuPG57mvuT4xHp3pHfZ6P4JN1ZW
 Nk+QMqGjG2KSSFJ4PU/5OOQiG+OPRuPg3DWPyuSj7Iaf3q5w6y8vTSW5Nu9MnclkTv316wnR

Secretmem has a simple .mmap() hook which is easily converted to the new
.mmap_prepare() callback.

Importantly, it's a rare instance of an driver that manipulates a VMA which
is mergeable (that is, not a VM_SPECIAL mapping) while also adjusting VMA
flags which may adjust mergeability, meaning the retry merge logic might
impact whether or not the VMA is merged.

By using .mmap_prepare() there's no longer any need to retry the merge
later as we can simply set the correct flags from the start.

This change therefore allows us to remove the retry merge logic in a
subsequent commit.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 mm/secretmem.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/mm/secretmem.c b/mm/secretmem.c
index 1b0a214ee558..f98cf3654974 100644
--- a/mm/secretmem.c
+++ b/mm/secretmem.c
@@ -120,18 +120,18 @@ static int secretmem_release(struct inode *inode, struct file *file)
 	return 0;
 }
 
-static int secretmem_mmap(struct file *file, struct vm_area_struct *vma)
+static int secretmem_mmap_prepare(struct vm_area_desc *desc)
 {
-	unsigned long len = vma->vm_end - vma->vm_start;
+	unsigned long len = desc->end - desc->start;
 
-	if ((vma->vm_flags & (VM_SHARED | VM_MAYSHARE)) == 0)
+	if ((desc->vm_flags & (VM_SHARED | VM_MAYSHARE)) == 0)
 		return -EINVAL;
 
-	if (!mlock_future_ok(vma->vm_mm, vma->vm_flags | VM_LOCKED, len))
+	if (!mlock_future_ok(desc->mm, desc->vm_flags | VM_LOCKED, len))
 		return -EAGAIN;
 
-	vm_flags_set(vma, VM_LOCKED | VM_DONTDUMP);
-	vma->vm_ops = &secretmem_vm_ops;
+	desc->vm_flags |= VM_LOCKED | VM_DONTDUMP;
+	desc->vm_ops = &secretmem_vm_ops;
 
 	return 0;
 }
@@ -143,7 +143,7 @@ bool vma_is_secretmem(struct vm_area_struct *vma)
 
 static const struct file_operations secretmem_fops = {
 	.release	= secretmem_release,
-	.mmap		= secretmem_mmap,
+	.mmap_prepare	= secretmem_mmap_prepare,
 };
 
 static int secretmem_migrate_folio(struct address_space *mapping,
-- 
2.49.0



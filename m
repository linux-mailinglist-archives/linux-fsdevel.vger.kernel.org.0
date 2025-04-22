Return-Path: <linux-fsdevel+bounces-46928-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 76F9FA9696B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Apr 2025 14:29:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 148E47A6785
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Apr 2025 12:28:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A75FE280CE7;
	Tue, 22 Apr 2025 12:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="KyYe05r/";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="OUX/6BRt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 518B227F738;
	Tue, 22 Apr 2025 12:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745324925; cv=fail; b=hmHWduems4s62oFKM3KV3olpRqsf8tnczTHUFy9KaO9DPHOgXjprNE3wdH4rJcn9T6YqVrqj9eWhba1twL4YcfzoFwNfZBTvr04+YSv/c5MVNH8H1XyFaJcjNLWJBgALTekFfrn2Tgh5zGgozMk3+nhk5aFoLdP2B40rEYm73v0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745324925; c=relaxed/simple;
	bh=FsyFnFDYqSl2HKnrjzAMq7c4nScevavVKjIcGi9TEDo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dh8KVuwZXetdq5cKVe96vpsUW95Zqvm1KUM2ohb9LRwwyCIel2NUnm+PAyx1z/YlK4xgq+KquUgom5ymJKJh6pVWvdWWWvxyzudP8u47EaOFsbf2PvCfL1qEBhhJGSBDrZLA2bsEpb70xLCYjBsDYGCA2d+MHlKHh2Pe929Jd9w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=KyYe05r/; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=OUX/6BRt; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53MB3C90008318;
	Tue, 22 Apr 2025 12:28:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=nAjtxvjlIrTPgGkbTa6pwP1QEnFKo2ZRlWGI9o3w8j0=; b=
	KyYe05r/DyRgrLOshiNtlj05oPz0BcMTLsrT6oDJIBbiucr8D9CR9EBMBrbG0j7h
	ajy7T7rQ6hk8i6KnAJwOKZBRaeRf+vsmBdKQZ3fN32vmspxkJ4zFrQtoCkzNGqbW
	OslyhPbzHO/ktbAiQ4cH0qeOlIYvy5PG9hbG1R1e/l9pJ3188TRy0K0xaey9YyZr
	FJa4xa+Q9rakpbC7v7wmUpxBgPwUOiSyxmNjl3SBxA88fKcPOiI0j4EiZqxcAz2Y
	S+59hRmvxYAs5QjsoEw3bBm5kdIFYZAHpx1InjLnRMDOX9800T9kiJCe13KuJkax
	UTGKlLvIoDzlysmZ6F6eCQ==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4642e0cde1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 22 Apr 2025 12:28:31 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 53MBF6xt033451;
	Tue, 22 Apr 2025 12:28:31 GMT
Received: from ch4pr04cu002.outbound.protection.outlook.com (mail-northcentralusazlp17013061.outbound.protection.outlook.com [40.93.20.61])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4642999rq9-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 22 Apr 2025 12:28:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ca1MAO/o7t+MsRErM4AqD7Gts6Te4MpJjMRvwC3hsfZoDNoK4+fWR5Rsi76ocNzQS+qkHIwHJG6iVfCJwo6dQjwPybE+93TjpC0X7N57wzkqHxHF4llmFr3e1vfY/s3DGccTAS7BaFZmEJzCt1f81j6j2OmLGddm9Mku/zR0BlzxN2F3ZZuqylB4YyA6zE2OcKayL/PLQfBfmriztDxvQxXTCch39cQA2YTB7VTJYX9KX8fgReMU21YcKxqqSYBh2K78aYdA7VguTPYJJQgADXz9ZgXyHsGHK2co5Adn29brXAWGiosrAB3JON4ht8KRfg3zt9d64cQ3wFWjto/w1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nAjtxvjlIrTPgGkbTa6pwP1QEnFKo2ZRlWGI9o3w8j0=;
 b=pptWMHAYSiSmmDgN2XaQxyBpOz7wLD8J2Ri+uKlCqXH0NjIeNRv5TSpG4XDal1q+eftPTk3uYYbb/coVt8T+urwlqZdxbkpPaR27PZegQQwf4OYKpQo36fajVlGZU3vOiXZYvD4TdRN59yyDLLwAnpBpmSwl5xJAwiqKQtkpBixHsNwqOT+RzfNu+Tyzv49YVcMEK/wAprw0mMSR+UPc2q93mdRBeXO/OzUEbRC8tJbqwhXaDoYvsUQjgQN1/dCEKTyI9382Y4uEfYx4VL1xItdvH4A72Xh80LzFsvpTRfg79zndcY53r9rWbXJsjJd9WdOAp+PfaBbyIUlaDpMjYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nAjtxvjlIrTPgGkbTa6pwP1QEnFKo2ZRlWGI9o3w8j0=;
 b=OUX/6BRtj3he/L7H7WJSbAdaaNvU1SG5scWtcw3xZdsCc4ugSPHKRaMLYX1+wy9M5T4f7VZephRG+E4VyOsq74uzZO0tbPhLoTV8cXHZW2N4TrbsDjETgbUAj2JYjjM/5RhVG1+Wd7/fVVFgWYpakhdsUbl83m7/V2ymBANrGjc=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by DS7PR10MB4895.namprd10.prod.outlook.com (2603:10b6:5:3a7::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.31; Tue, 22 Apr
 2025 12:28:29 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%4]) with mapi id 15.20.8655.033; Tue, 22 Apr 2025
 12:28:29 +0000
From: John Garry <john.g.garry@oracle.com>
To: brauner@kernel.org, djwong@kernel.org, hch@lst.de, viro@zeniv.linux.org.uk,
        jack@suse.cz, cem@kernel.org
Cc: linux-fsdevel@vger.kernel.org, dchinner@redhat.com,
        linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        ojaswin@linux.ibm.com, ritesh.list@gmail.com,
        martin.petersen@oracle.com, linux-ext4@vger.kernel.org,
        linux-block@vger.kernel.org, catherine.hoang@oracle.com,
        linux-api@vger.kernel.org, John Garry <john.g.garry@oracle.com>
Subject: [PATCH v8 05/15] xfs: ignore HW which cannot atomic write a single block
Date: Tue, 22 Apr 2025 12:27:29 +0000
Message-Id: <20250422122739.2230121-6-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20250422122739.2230121-1-john.g.garry@oracle.com>
References: <20250422122739.2230121-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN9P220CA0019.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:408:13e::24) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|DS7PR10MB4895:EE_
X-MS-Office365-Filtering-Correlation-Id: 03f8684d-a106-4520-dd79-08dd81992fd9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Bu9+QoFx838Pqc97q67/YMX3nZ0r2/erAeuE6aTQnkqWqkBnF/VV97jZbPB9?=
 =?us-ascii?Q?S9JMBWT9cnaT+GSiJHXdPiBg8y714OjOu0H6Vp+jC/5+Bo3Qyd5LJ5Yvc1ME?=
 =?us-ascii?Q?u9AMAjZOiG0oeVB0hS3wEBsdbOGEhGLlzhMD03WrKrF2w+gopZoMPlb+0RUG?=
 =?us-ascii?Q?9g6M0xMWZATJg068JeovifxzVotq3WVnizRNiTdhYmV7cFdZlATiQjjr4mNR?=
 =?us-ascii?Q?yB0/aoemrmm/UKCVmZwc0vnMuxR8vp7DKjawvvQ4vdGmOhUdNCTztHQTDr1y?=
 =?us-ascii?Q?lJw/gx1PSq9gCn+gb0XV2IDt6Hz96h4qMxVcQ/inQe+NYvqYHB19BLQivMG6?=
 =?us-ascii?Q?xsLSxT2qqTIi1iJ5E/Hcgz9N7kOkaGwmAp1bL7E8h/l2wUpFSB4OS2oxHRiD?=
 =?us-ascii?Q?Mu4RqmxpwlAO3CwwBmV105jrMCFdm4IHE95EF295+A0nfny+F8xLT1KydpNF?=
 =?us-ascii?Q?i4yT35VpnIkbxYVPKHGzIRWzYLYb4jY/xGtup6vJ8bJTKvRq8iSKVk0MqJNd?=
 =?us-ascii?Q?M5EfCRXk4YcgFNXzGiUPqifYPPZOIBZIq4dIzKBJwghtk1aPfy8mzqAREBvx?=
 =?us-ascii?Q?eUrRi6lUZGuBxljTXAI0Vplem4EmhnRQAaTNFztwvLwJ83nu/84glNDjhflh?=
 =?us-ascii?Q?2r3n2/WNs6Y+EcSvZcK1J4wM+dszGIglT2FQKhHbu1Diw2fwXpH1OQ/vmp+7?=
 =?us-ascii?Q?29Dp8hgj/ECD1AtkfoRGEm1ePl2+4KLmgspn959fZd6FUXHfF4hWPTsyGgGL?=
 =?us-ascii?Q?Mh9z0aUVqFACd2a5n+cNqKznLSfooEfQjHDPLYzaWM7MBvx0UXBd9b9jxChX?=
 =?us-ascii?Q?lIuZ0TF2n5+sZ8di8vLicD58dMxbAVGRzjKJirfLAhDrDcNBx0scYUgPhBn/?=
 =?us-ascii?Q?Ouoz8mU4SUOBm+qriI1eVaBZtsHKUUNU3FgZk8LXkXjuiA/38b78rOYs0QPT?=
 =?us-ascii?Q?6sbeSobNgskDvp7p3z04iJz8FApydVxnbMeImmJBrNVG+81OsodOREh+zfYB?=
 =?us-ascii?Q?1vR0ymfK8+oOsJEKdcD/D1/igA8W8r/YwOgzPiWcNSmyj+S4K9LZrAW4qEYK?=
 =?us-ascii?Q?jvsCD1hgMEVbASwjJjB2mdVb5mKSk80gR57KKkoxlB/jLLXbHXmhIs6DOmE2?=
 =?us-ascii?Q?T//UDLQotklcsrnnlurKgeaCnR8+1jrI1NX5eR5qCRPPX+ncYMOiaivTZgIW?=
 =?us-ascii?Q?MUsWGwjRN0JJOahGgcNCx4X773JHCsQWNWEZP/oHEsAlgk2ElsSLKHYK3f80?=
 =?us-ascii?Q?WI6z07El5rlf6YWYeez5ZaxI1943u1xtLIXVF5lk4aYHtOZPpdzQrUSfF17/?=
 =?us-ascii?Q?fsZx8lz9T3jwJEKpFDFvURa8Q0jqHEIxFjMoOxGrNJKdZZyNrIHCmKDEuUm0?=
 =?us-ascii?Q?21O7kIEaPKUaKS1l54MQlwMxfhEya7gEazLFvYoV0p3im0COxBRee7vPMJm1?=
 =?us-ascii?Q?LYs7tZuzTe4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?aDyd+LVf15ShlGJPCrXPI32AFQhVoe0n+SQTwDOu3Zz/DoOONNVbLadQucF7?=
 =?us-ascii?Q?Bf3d2P0OudnBXPGMi0wMEekzc5tXbUmcpSeu8nHZE6rBlLsOftRFujska+ip?=
 =?us-ascii?Q?DqmX+2QyuKFOBJ6Er7BIVCIYN98qmhFX4IbA2Ecws+6XfP6L50Xj9Y8CT+kC?=
 =?us-ascii?Q?3vET35r/yiyt1ChehFB+OwvsvnRWo30bxF32nk1Wy7vCUOtYlvACo2YHeb5+?=
 =?us-ascii?Q?6mARl9g5qmZ619DQNtmItUzNXETA0KwStjmZY9yDFh7TZX/Afx108gDicxyl?=
 =?us-ascii?Q?J3J4CrnhZaSZ7F+cSGfiVYqJxq1ozpICo418NvztKrn5/4XYoVXsIObmADPP?=
 =?us-ascii?Q?f1pRofSLGAujIG+YCjOjGXDeVTIKz5QhUkkc6RP5F4Gm4+Vo5cl6k3hxfq7N?=
 =?us-ascii?Q?hE4QgC5ijcI2aYKp1OEyJPPzQxz85N0r9V6wp+3n6XE8voNxxSArHhEx7xO1?=
 =?us-ascii?Q?FaxVII/X9VrD7kiJlDAaN68ax1zoO67+nZJaG91ZpW0U38JCZQvg6SDvZ9dM?=
 =?us-ascii?Q?CLwR5cFjOa4mAu0r3taC2T3slJS42rOm5U3rDpKtZaqp6hriqXKZAWunuehP?=
 =?us-ascii?Q?EIIy1P75RYWLumRwtN66hEcb+Nkx5cFZ2XcVzsiw3rIckjiU29EhmQpaAXeA?=
 =?us-ascii?Q?r+ZnNaMoZV4r8ZXPWjEVdFisAUUzUQ6ODXieZcABz+yDg1hKlZVAq9Jr2zvX?=
 =?us-ascii?Q?6ZdQAPlr7AjTJoV9wqSvw1sqD5K0kkBfR+5gkDyTvMOhnjdNa7nd5Hs7MvxY?=
 =?us-ascii?Q?4vl+sHl3F63Xjbbq1+NEgBRIsyxOMLmKEjGErYrykRRroQW703YwcCGdriOU?=
 =?us-ascii?Q?kI0pb9XhzEIQ1zhZbEN+LJvv1lYponb314w5ZfUmOm6Ep7KtPkYuPet3MTWn?=
 =?us-ascii?Q?r7MX7DtDsP/caD53y0YDO0QjPlkwgFqLf6fl5++guOGbXoBv839m1Vj3zLTm?=
 =?us-ascii?Q?/svFXAabj17u0rv+NjIz21zWeI2Ve5kZArN8xcEzFv3cnnmvsMGnB84DEi2I?=
 =?us-ascii?Q?nC/9jssw4PN/AoIiulonR4FulkQtDhMUwudtW/5RPJ/vdqiaufw+b8in2dPv?=
 =?us-ascii?Q?D7p17b/u+lFBO7H4GVtIAnJukeWqqSIfoHbEc8D1XToML7lHomkkovfwzAn7?=
 =?us-ascii?Q?YlxCGYFQsJQeBSs4DkBkXMYRehDMXVy1bvjTj8lKpjsRHTj0/ZP5z57tnuiN?=
 =?us-ascii?Q?Dvm96EfgVPKIZdG0DqDB/L5EHMpZpCWbWt6D1BneAwQj89vbgljw3ghY3oZQ?=
 =?us-ascii?Q?QwEfeh86JRDEQiIDfBhjOeZ4U+uATnNqjTdtFUHUAtb1hisFKk5ASqR3GYIN?=
 =?us-ascii?Q?4qB+wyh8++tMeOtwRhEs4rwAjBEBdSIJieP89p0ICxq13b3KyvIkZL3/x2xu?=
 =?us-ascii?Q?HLupmaGPLF3shMF9YZzho1U/j76vupT3+Cr8bsqpa8AbyztO8Hccm8qGXlER?=
 =?us-ascii?Q?QjvYe+xdexEubGom1nK+DGb+SqXr23NqAuuxosvFok2VNbrNxZRVXdySf8sb?=
 =?us-ascii?Q?oktPyIrNV+avrztOkd36b1XorTnO4VTwETKEE8nRodVxtwt8/LsAEQHXjSqu?=
 =?us-ascii?Q?YR6DXy9Fj0X+/2gnbMaWG72Deik/XzW1Esknj1CEyex3BFguZW4xVNgHmMYs?=
 =?us-ascii?Q?xQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	XYBuJ5ISEZqHh+ze4N5/mI4aa/9621+xYY2OtF8ZN4r7W/mOkC5wzKayEzNI3dkgaVOiOe2tC9yaEOgu3ejO4Q8i91GEa2uBiqxXaPLngICpOi6bBMgfV6C4iNNn5I6WrGL3bnRnMPUpjwyHLtMxx8Ui4yU8Re7B2EWDnWu2UqDfWWlrEHHWSL8E7xNJTJwIbYTDQfGxoyQ9hrAN+PyykWz8nEkF5wrbDaBOu/UnZuOdfDdhQwSLnW+0L0uCX37gZQIdIIo/jc6C2oOMIhDaPcfLS7M2aWCxBjL0qXnjPShz09fcLRXm/8Pm3U1zlow9rePFhWTGN/MpN3RkGDBKEk9mWKd6HG4SIyvNIZPXu8+ARpvXQk3WLSoHT6Ugm5U5kJh3CbZRP7oyQmCYCJQFlBvoRJ9LhR2dLIngNEtBERhVP0Z5iQgcfwnj8+Kka2t96lte1vTDCORmLkOsYadtkJbB3BhaG/+FAZMt9mInImauBhis+dPgsfrHKjhe9dFiPWpXMKvdoDNbWAl1xSDuooJE5ZkVmTpd5QHb/ryeAJFClqvVfuiqbdvjv+yI0VhKzf1fwfBbAbHCX7Yh2WXZjeucNJlXP1CnR+ja6AiegpI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 03f8684d-a106-4520-dd79-08dd81992fd9
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2025 12:28:29.0847
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ek/p/ChhBq5gBiGxDHFAF4lD4+rg/jVqHre0w1e/YFs9UvjsWXcsYQYo23d/jXMozLHpOYhqATye3BPgGhjsZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB4895
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-22_06,2025-04-21_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0
 phishscore=0 spamscore=0 suspectscore=0 malwarescore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502280000 definitions=main-2504220094
X-Proofpoint-GUID: PLWaU6HNElUSihsPQSD2uCLtt8XmiJNw
X-Proofpoint-ORIG-GUID: PLWaU6HNElUSihsPQSD2uCLtt8XmiJNw

Currently only HW which can write at least 1x block is supported.

For supporting atomic writes > 1x block, a CoW-based method will also be
used and this will not be resticted to using HW which can write >= 1x
block.

However for deciding if HW-based atomic writes can be used, we need to
start adding checks for write length < HW min, which complicates the code.
Indeed, a statx field similar to unit_max_opt should also be added for this
minimum, which is undesirable.

HW which can only write > 1x blocks would be uncommon and quite weird, so
let's just not support it.

Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 fs/xfs/xfs_inode.h | 17 ++++++++---------
 fs/xfs/xfs_mount.c | 14 ++++++++++++++
 fs/xfs/xfs_mount.h |  4 ++++
 3 files changed, 26 insertions(+), 9 deletions(-)

diff --git a/fs/xfs/xfs_inode.h b/fs/xfs/xfs_inode.h
index cff643cd03fc..725cd7c16a6e 100644
--- a/fs/xfs/xfs_inode.h
+++ b/fs/xfs/xfs_inode.h
@@ -355,20 +355,19 @@ static inline bool xfs_inode_has_bigrtalloc(const struct xfs_inode *ip)
 #define xfs_inode_buftarg(ip) \
 	(XFS_IS_REALTIME_INODE(ip) ? \
 		(ip)->i_mount->m_rtdev_targp : (ip)->i_mount->m_ddev_targp)
+/*
+ * Return max atomic write unit for a given inode.
+ */
+#define xfs_inode_hw_atomicwrite_max(ip) \
+	(XFS_IS_REALTIME_INODE(ip) ? \
+		(ip)->i_mount->m_rt_awu_hw_max : \
+		(ip)->i_mount->m_dd_awu_hw_max)
 
 static inline bool
 xfs_inode_can_hw_atomicwrite(
 	struct xfs_inode	*ip)
 {
-	struct xfs_mount	*mp = ip->i_mount;
-	struct xfs_buftarg	*target = xfs_inode_buftarg(ip);
-
-	if (mp->m_sb.sb_blocksize < target->bt_bdev_awu_min)
-		return false;
-	if (mp->m_sb.sb_blocksize > target->bt_bdev_awu_max)
-		return false;
-
-	return true;
+	return xfs_inode_hw_atomicwrite_max(ip);
 }
 
 /*
diff --git a/fs/xfs/xfs_mount.c b/fs/xfs/xfs_mount.c
index 00b53f479ece..ee68c026e6cd 100644
--- a/fs/xfs/xfs_mount.c
+++ b/fs/xfs/xfs_mount.c
@@ -1082,6 +1082,20 @@ xfs_mountfs(
 		xfs_zone_gc_start(mp);
 	}
 
+	/*
+	 * Set atomic write unit max for mp. Ignore devices which cannot atomic
+	 * a single block, as they would be uncommon and more difficult to
+	 * support.
+	 */
+	if (mp->m_ddev_targp->bt_bdev_awu_min <= mp->m_sb.sb_blocksize &&
+	    mp->m_ddev_targp->bt_bdev_awu_max >= mp->m_sb.sb_blocksize)
+		mp->m_dd_awu_hw_max = mp->m_ddev_targp->bt_bdev_awu_max;
+
+	if (mp->m_rtdev_targp &&
+	    mp->m_rtdev_targp->bt_bdev_awu_min <= mp->m_sb.sb_blocksize &&
+	    mp->m_rtdev_targp->bt_bdev_awu_max >= mp->m_sb.sb_blocksize)
+		mp->m_rt_awu_hw_max = mp->m_rtdev_targp->bt_bdev_awu_max;
+
 	return 0;
 
  out_agresv:
diff --git a/fs/xfs/xfs_mount.h b/fs/xfs/xfs_mount.h
index e5192c12e7ac..2819e160f0e9 100644
--- a/fs/xfs/xfs_mount.h
+++ b/fs/xfs/xfs_mount.h
@@ -231,6 +231,10 @@ typedef struct xfs_mount {
 	unsigned int		m_max_open_zones;
 	unsigned int		m_zonegc_low_space;
 
+	/* ddev and rtdev HW max atomic write size */
+	unsigned int		m_dd_awu_hw_max;
+	unsigned int		m_rt_awu_hw_max;
+
 	/*
 	 * Bitsets of per-fs metadata that have been checked and/or are sick.
 	 * Callers must hold m_sb_lock to access these two fields.
-- 
2.31.1



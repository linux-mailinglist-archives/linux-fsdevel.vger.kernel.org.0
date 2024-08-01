Return-Path: <linux-fsdevel+bounces-24818-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80BFF9450C0
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Aug 2024 18:35:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CBC91B288A7
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Aug 2024 16:35:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6A3E1BDA9A;
	Thu,  1 Aug 2024 16:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="VbFY8rA1";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="gaXcytoI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DF8F1BD01D;
	Thu,  1 Aug 2024 16:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722529932; cv=fail; b=GRuE1SacT8CO6sJqVfJWHySz3Yb10GnqWyWkxGzoR/lx8fgH9QIeEWuQfHy35OKtioT94L4hzk/Dlbj9mDTOvdWkqq4XYMBV81WFTOk4wMil5J25OSr6CXs+ycTg6Ukf/CFZS7MMv8vnlVU3n1FMk+0xlS00Ew012WLF9knbpQA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722529932; c=relaxed/simple;
	bh=iP5VgZqMMKyaNN872Wec5brnrEankUaD624CQGWv5AM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=iR+ZA5h3iQlDQLJkMQJxlyDTEFwX5pcWsjR78MKBtnBYUyKSEo8t1Z2F03pWWOeLBwkrHJcmMRPlTqcDeXb25EfCNDGXNyXra6W6vDhT/o11LWE55TRZivL53m7Ej/zgvPG7ld8yXjbjJk5PxvNAlNBZgv2iYryHNFD8TnFVr/I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=VbFY8rA1; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=gaXcytoI; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 471FtY6w010856;
	Thu, 1 Aug 2024 16:32:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:content-transfer-encoding:content-type:mime-version; s=
	corp-2023-11-20; bh=COlt0/hvCG/XtFt/RIQWXv0u+rGaER/I+75DfoqfNIE=; b=
	VbFY8rA16orSk1ZzWYDBpDqQqjdJ2aJ//La4pEf29gM0gkOoEtFV8RczuDVHmJov
	Et1ew6bd6gjLAyGF8LnqQzmU+3E/Ejwd+h3i1mQo2Hv5CDytrRhEhaUmjTNywAiy
	xlz4n0lQineLXYg71xaiZyQ/SJoKaqHLm4d4o+v6QqEKBmC7nfJVdQg5EtvvTMiz
	PGzg52IVcekMjULnhTl2j7NqgUQmaT5vaRuLFG6x0WMgHtW+xAP2GDCbFtfw92Wr
	OvJjxssSTbIXcJptTfbkNZNwSfMrg/veHdw5Y4HNZU1SdVCevC2XrXYi7oT0bkhQ
	f2qXKW2R0IVVRasHDfCzMQ==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40mqtat9d6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 01 Aug 2024 16:32:01 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 471FNu3C030932;
	Thu, 1 Aug 2024 16:31:59 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 40nehw38jm-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 01 Aug 2024 16:31:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BoOPgasDsor08ZE4B2cQsdJPQrJubSi7+Cmz+yu/FcabwpD1Qdr2cDkeGVYfLZZIlLIlJyrJQiZc6LFxZzWv6rohCpSwtrX3DXMagFCRxOPAP7tX/BEXqFCBLKZKhGrk2+FhK7dYKH/SOlHePF8aj7XDxj+HpchZIi1LughaQO25uMDd8/Zp6yNdTwG0shJlCJdtMELyzZe3+vfQlwFA4MjS8w/CF3BY0jcV4sQ8rUTKHkjnTvIT1JZ0wphwC21lNUcFw3b4055LCP0aB8DirdmS6qGXCTqHkEejn2tHqqqTKugvZpV9j5ks9bhTSfqQ7IfVu0Xfwm8wgdOhGDGUbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=COlt0/hvCG/XtFt/RIQWXv0u+rGaER/I+75DfoqfNIE=;
 b=o8t33JdzU5iwGJN133gn5UvmQ2XlnScLJbSmRJ+2d+eNSxB+l5ZnX4paPVClwEmlMMo3W+ZdoJbmfYoS/uej5/jqk5YCxj0A+c8tL+GTl5ko/VlW2Slgsp9KfhxLrC3N3ZUHsc4R24KIUUORFOTM1tAlAaTtbZIz5dtuC5AYWQ3mKaMqIkMuB2DJigs3K8kMf4FG0nl2u90RMdMAVc29trpEXwp7YnBphKKh8bByu0gQ07DEXmEGxUQo+7izcCw2TjUGUt3hpKxYqbQMPBNhgFqlEVHW9OLuF9A6C4rW+nUtEKDcMS4Rbm8DZBqqyfHZ4hcFegTt2wWabELgJ7IFsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=COlt0/hvCG/XtFt/RIQWXv0u+rGaER/I+75DfoqfNIE=;
 b=gaXcytoI1ax++elXk/I5GuSWFnMJiWv0kXLaVWeYzQ0qAPV6xiRptzbKM1f/UEnOlMAQe2w2lWxbVAKGCdfo8Q6Yey8XdTVuXGcYI8Q0AD+Yr4aABFnbkprM+oZ4fMZHSGcN+asvMz/c7bdf/42ciKjYqrYr41WK3+xNkshRW0c=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by PH7PR10MB6081.namprd10.prod.outlook.com (2603:10b6:510:1fb::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.22; Thu, 1 Aug
 2024 16:31:56 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%7]) with mapi id 15.20.7828.021; Thu, 1 Aug 2024
 16:31:56 +0000
From: John Garry <john.g.garry@oracle.com>
To: chandan.babu@oracle.com, djwong@kernel.org, dchinner@redhat.com,
        hch@lst.de
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz,
        linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, catherine.hoang@oracle.com,
        martin.petersen@oracle.com, John Garry <john.g.garry@oracle.com>
Subject: [PATCH v3 14/14] xfs: Enable file data forcealign feature
Date: Thu,  1 Aug 2024 16:30:57 +0000
Message-Id: <20240801163057.3981192-15-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20240801163057.3981192-1-john.g.garry@oracle.com>
References: <20240801163057.3981192-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR14CA0010.namprd14.prod.outlook.com
 (2603:10b6:208:23e::15) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|PH7PR10MB6081:EE_
X-MS-Office365-Filtering-Correlation-Id: 3028ee8f-1132-41a9-04f3-08dcb2477567
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?eJHy/ckZWo7UIlOQ1Yqz+KWHSV7WNMTuipzSVMkHydXO/uYdmz8LEw/8ij1Z?=
 =?us-ascii?Q?buGeQDtMrKJYpOyPmL7pcXTCfqz5mdTY+UTTfW66aLra7URKsrOYv+cfNIWC?=
 =?us-ascii?Q?jM1Bj28Uhgv2nt2SJAfe0oZvU7zcfUVSnqvuTKeV/cydKM4VA4aATsbP1vKT?=
 =?us-ascii?Q?wqkVeT2WH3y/zNZIin7K+XcNoUrwLFVl0pOgkTGMA8xoSSAmbK6DJM/68Iz/?=
 =?us-ascii?Q?S8Cc7EsTzx25uljJ7wa6QMNlEvuXm79zO+G29zcRj/2wmgIfRP+H2uwe9MPK?=
 =?us-ascii?Q?4p8Ayvq+ybVSEsiINlsK+vjLsFP57YgkvEeyG/Rp1emDGVcnmW/w6N6D0S6H?=
 =?us-ascii?Q?OjvJ+cJWDpCV3Hdj0PUz4hgS1stVAFoB6dg0Mu3Xyp3ciQN7Q73NNlWhBAsE?=
 =?us-ascii?Q?RwQVg9vabMuVQl0eFf/Q+PRf/XiVDs6rOSVfxkagJznFcILNIl4r2TNENTw5?=
 =?us-ascii?Q?5ZasqlVYMTP2IeqRExR/ChmY6t1DMPoX2bKhXl6pOKyY47E+1i5GsYrpFns/?=
 =?us-ascii?Q?gWSMgeRmsemP8+v5rgKbs5JJsyvxliH4A1iOdw7zsb979UckQOys/fGc9n7h?=
 =?us-ascii?Q?OED3r0hxEztBmxuHu1ksn2KjtP8RIABElT4MeQyJkvZNVMQUGQcbYQW2f17o?=
 =?us-ascii?Q?TzAghibE/CsKsu5+UIr7jk9ttQETw2PQ2dIjHTpitUQRTpQ9aa3/tPW5MXhU?=
 =?us-ascii?Q?i8Eq+DtMDDj3QVqEd1GCdVDtfjSgvN8foM5EMp8gatX/9yTHlhBedlEwJkSp?=
 =?us-ascii?Q?DPaixnG9mt03PAEgCo8JGSynEzkCxPpZ+TiIQPp61h/e3BnaNU5AroL40K5q?=
 =?us-ascii?Q?UTYvLnYxdLLnzqh9jAs+Bu4JvmMvrWkCbR+mk/3WHNSM7CXEGRAz6qEdxCUV?=
 =?us-ascii?Q?QCVRQqWXS6m7yMBZ9Np0RmKmS4DBDMpiTDF9dSNZt3Bk7yjSj9JSunUwCmMy?=
 =?us-ascii?Q?pA4B0+15ZEuuv4pw+MKxhuoja3k7ft/JC3wLUI1X/aOywcAdVJWjYuHSeDU/?=
 =?us-ascii?Q?QBc6w3odL5ssTk1azk2+WlXduNiLKcZukM15YAhLkXuu0t9vNLYEXWVjxz1K?=
 =?us-ascii?Q?tTmHRr/hT5S0ObjZowT2FGcxpyVYBq/8x5ZKzbTmPKecY08eRhXYk1P1jf7g?=
 =?us-ascii?Q?ZNWds4T8SVcEpm0giHYKLZaQVX8lJo6Z1yLdIPQmoCrifu1ZT09aPCgSnINX?=
 =?us-ascii?Q?HNQGf4FuDhBYSKqwmBzS4Fw6s4G1HDHKrfg3ktEnMszH6UCtBnrTq8zTUB6X?=
 =?us-ascii?Q?+9zbCwQzcxnct74FPgYbsHhNeUDQuZCnPQ/2ltGuvAf1W5Ko1Gn4MVLVY878?=
 =?us-ascii?Q?3efanPtiHM96h6e5gcMNgxzsO0xmBgKR91xbnmtXxjP9Og=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?olTnFb/x1nGdblZiyjlyTuKAnrDfpes9Ch1a/h8z8fCSihSpV7WNh8KiRkwm?=
 =?us-ascii?Q?BOTn7AcrkNVGL8VPmf+kLsJurGiT9pA7LDSEYZl6h0J67bvoOAYAYTDbM9t0?=
 =?us-ascii?Q?9ujTNjveyxwV+kt3snwj5Xobb3P2vnvS7+Pp1JGKbMiK339lE3AC/EcM96eS?=
 =?us-ascii?Q?qA7mkJNhrfVfS2x+0L6JKoDXTIBOiKZX/KsmAOjHFlIIp7FKP+/KSsD3H3Xq?=
 =?us-ascii?Q?GXxkM9h8QOLKYmeENU9HeGianScljH3ZQeFiZWdAWwyi+s1UtGUZhslTUTAj?=
 =?us-ascii?Q?eC0IX8W5j4XQCz3M6L3B7D/T4PHEpZoTPfsAhe7WVm5CXkugBJhBvlvsfuiT?=
 =?us-ascii?Q?A9zfVTEt5rNlu5YlJ1+bFnmepQ6RmuGOebyv1lEIzk4tZxgtpIwq4XDaTkGB?=
 =?us-ascii?Q?V0sNEwOgn/BN6n/qbXP3sbdFF7knsUNGj/sDr42zfloQF8AdbPVWLtQNJCta?=
 =?us-ascii?Q?dCnp6pydFIvs3LBs0k1Tpus8g30F1bNpUuiE79ek9zwjgDmp24hng/aHqJ1N?=
 =?us-ascii?Q?p5KQtL2jj531co08ac3D2P+oMYR/JamBTln1AtCsuKRhM4/7TpaDF/8uwmVf?=
 =?us-ascii?Q?M+lJLLsNbyeUCRnn/nkqBQSIe2sFWPlHipRni2aoFRhUVQcDP4hvxPYygOdf?=
 =?us-ascii?Q?HXQ+FVol4Rzy4ZgypytKOWFkmKfvSQdecH4xDVg64sujYpmuwivjaD4sAcBw?=
 =?us-ascii?Q?lXOszeZJZ+2mg1AE9jZ0Lzi9vcvo4f8ShOFdRoqPLhn8IC0zbx3R/UUWrPSj?=
 =?us-ascii?Q?hYsSNGKyo7Dk6XWLtLvWUJ1BbvRbg+6CD5Q38SFmOEQkMnIw1OBD/iuZBq3z?=
 =?us-ascii?Q?VkqYFQJivl+YtxSyya4ade7lfADW07JFtIZ0gsIx7kNhzebc5/tkEU5TgHK7?=
 =?us-ascii?Q?g7CVGMIeD3O15R7VWwm/wQoYyKT76kh6U7umYR65My5VLiB7mc9nLdONhBcZ?=
 =?us-ascii?Q?hxCeJoduGRNFNuguFmwg1ZonMgHUirS2S0YEBUrCKe9n/NczaxSjZnGv5C3u?=
 =?us-ascii?Q?Wn3U8sCtrgZUQyW0fAJw6H3jv7dLnhv3xwwreE7pC4h6IWg5+65DZId8bNlh?=
 =?us-ascii?Q?Dvb0X/nzVPo5Fd6XzDWGrEX1Qf7ZRxust+IIP5jcge/7Luognp7D8Aqihm81?=
 =?us-ascii?Q?ldGYPI5cmj4g6ftkjxfzdmPJyoB5ufv3MW2wQzFMMf1xyKmfrVy6jlTye+Q4?=
 =?us-ascii?Q?hZOa8/fQGBAeUZBuGniX48Ui36NSeS2NQoqqlZNrVI43bakMhDLj0sqsc6le?=
 =?us-ascii?Q?jQ6GhgP0RuoVxP3q6vUcMU9s9VIPZHiS+6oUIdG4y5PPXxmDGDqPbs/u9Lij?=
 =?us-ascii?Q?2DTWB1JHec0AT7GoMSy2pgAiG3ft5VPqxQA5zowrVktQLJw8v5IqWomCYw2P?=
 =?us-ascii?Q?Frv/OBNsrWiUD9JG8TT559Jso8Ke0ahzLUJrg/YySgmf+6TYsG7nPcKcST5r?=
 =?us-ascii?Q?Ex5WyAlorEu8svhVYiDx81fXxjzCm+Neox8ocWOwnds9n05/vwh4Whs3vsyh?=
 =?us-ascii?Q?RyYuAOeI/3mjNruzQtksqW/wgGc/FQjdjUrbU4kXUIrO5qeBZPemiw4cLn/p?=
 =?us-ascii?Q?0BFku1rRiy4D/SArzl+IkmlI8OVHGsusZ/j0Fo5Hi2sCia49HzBkArZN+H1K?=
 =?us-ascii?Q?YQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	lfL0P0c7+JEXC//C3rqVkoCWHTGL1rZvHLksREExuf7FsKqTPTUkXQ7Ko9LqO553vRb/z4lUTP88CL2oCs6e7ZzKXlORY8MoIkW0DqP5EcnkZdX2Qy3y1LvPQ93sHy3sAW6uFJUrZhVEzqV17dKHVbm9KlyEQ/k6A5FlOV8lO2y/zfmXekNJ8tprlYDHO8/rVUIguv+xY4nxuOU31e1IDB/ZLT9Nu3E0XfC0UV0ZYrcnb3dZGcGvm51hMT0ck3dTykbCQmlK4zmchpP9bVDxqmkuKo37poBnFzS9MxpHCsx8+tUyHd/RBDtWhNHDfXgfmj1yWcmb2/eD4WoE2DKnvHKt/w2FS60IKFTq7hjKnXKoJpGYveEz3gAVTJZWfp2V1cI+Ls6TJEsLAkizUU4C44MrRcWrVDeoW4ubQJsxwLkWSZvHZBjFSjTLIBB3cdjWXZUvjjf7K8SHNg6jp9GPZ331qe5MDz6PoJxNVV2XdgsaEpt1eA5NOlXXi/bqmZps++JxGY6tAIyUW+5o4z4ytKZiwgN+NpyBbMt9DKZ6sWLS3kvSEXNzAKQuikUcuCcGCNOpvr25V+YqXouLQTdbWd1jdwa5h5igSigx4l5+mjA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3028ee8f-1132-41a9-04f3-08dcb2477567
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2024 16:31:56.3102
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A2OM6LUYSV48G7pJigOS78+qIlZa3cfbeLTrC7F6Gubd9ykA7lf9BhQnhCTgoxkBl6Q+83vlOzXNAfGYEK4gMQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6081
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-01_15,2024-08-01_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 spamscore=0
 mlxlogscore=999 suspectscore=0 bulkscore=0 mlxscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2408010108
X-Proofpoint-GUID: h0oZ7c8XTMyxfeG_w67kqMdVyh__eyRs
X-Proofpoint-ORIG-GUID: h0oZ7c8XTMyxfeG_w67kqMdVyh__eyRs

From: "Darrick J. Wong" <djwong@kernel.org>

Enable this feature.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 fs/xfs/libxfs/xfs_format.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/xfs/libxfs/xfs_format.h b/fs/xfs/libxfs/xfs_format.h
index 95f5259c4255..04c6cbc943c2 100644
--- a/fs/xfs/libxfs/xfs_format.h
+++ b/fs/xfs/libxfs/xfs_format.h
@@ -357,7 +357,8 @@ xfs_sb_has_compat_feature(
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



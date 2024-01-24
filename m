Return-Path: <linux-fsdevel+bounces-8715-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD44983A85F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jan 2024 12:46:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41E862974A7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jan 2024 11:46:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E74A50256;
	Wed, 24 Jan 2024 11:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ihO35mAo";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="cCYHxPJY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07E9C4F88F;
	Wed, 24 Jan 2024 11:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706096507; cv=fail; b=htOsmU3UYu3fjr5T9/qQsPX/fu/f6xxhCEIfumFJGQsQO4yyNYT7ZUV8ef3i1gQ84TMHlFOFROBtnbrarFoDDCDHbx3CvxAxrwYNBfGFUOfRbkRRgxfA8D7Ia2Nu/itV4YhF0RiRks36T0K+OrAWYVQPKB80fg4ocFSqVR0Fk3U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706096507; c=relaxed/simple;
	bh=GC6ylPX4dQI/1NB88ih3Z9I/YX5vcquE15oYpkKgq9s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KYHjXyHAAigAPpAGDYD+ROGK4PHAY+M61bY8IOtYsrhNsgWOwCL1nHPV64H+bfib3l7Z/3ZWTNWfMTkamxz5VYAV1HxmWgm1lfbITOrpxhM4iH+WU1++iB4p+czrRaQwfxxtp3bP8STPfJAJpB2977tc/Bbixmiun3NO2WnWANQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ihO35mAo; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=cCYHxPJY; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40OAwiWF002342;
	Wed, 24 Jan 2024 11:39:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-11-20; bh=Wvz7ujkQkNFdmcLVymGBe/+aemLauhqF1vKIiLipy0E=;
 b=ihO35mAoy100pBSCqC7+u4E0Nwof6+5ROP89eNJ+cPTPm+yPo1A6gqrhL0Nh2rCOtE/t
 3FujmT0GMPtxBl98Ggw/MyXnoPhAQduTS+1naZiOrvFyFZEyq6UHXGtr4sNT/uGF+ssg
 LjzQNgIOqIjUDyKM3MO/DKSoiwNDd+J+AOjJzx8kRKC+Tp5AryA+jx0S69T1aw6GNakQ
 pzzz07aOoNd5zz3plDzguAXfhweetEAAc8mdcAx0Qk2OYYLZD9OnEFbBmuM1a5PDn6BJ
 4Dy+hMyvWvCDpv+MgUKQyaxrHDtiYCS8rcJ2Jk7426SWKnzA8rfSUAGit6xERMEnhLVO yw== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vr7n8239y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 24 Jan 2024 11:39:25 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 40OBKcRr040865;
	Wed, 24 Jan 2024 11:39:24 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3vs316wnyg-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 24 Jan 2024 11:39:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WgTQp/l/TgHP9awSFAiWwlNpboz5y7DBV7KGL0LhHCNw+g7aFSU0n/I0yvJid0JfY0QflYam8+4IKsM5saKWxFRHeh90Z0CL8ijOZWsRR8GFwOyCIni2MUjjrflNO7HiJEtNJEJz5K4OLu6uY6rDsdFFLun2hHzhFCrFKalRRSv1WI4X8KREPC2+YLzsXXj6l+ADa2heSDHnIQ+ZbeC5pEJm7KbuZqDQsl2yaKBNaNl+BE7gnZ5jE6+RpYhcQept9i4eSm90VKm76H8R8OBjg5luOx0JBQlD5HtMXAmpBBz1NUMyFisDpt3JmnznHZp8kJgt1fv72n0T51+dRJ0+lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wvz7ujkQkNFdmcLVymGBe/+aemLauhqF1vKIiLipy0E=;
 b=oHVKpqE4iGzgHWVzwTQrFNVDQUyk6avjd3/TS5iKw8n0G8NBD0Z5K4IdJbl1wf7ujARUok6pb9Do6oxLhFQ62Ec5X2S0fJAYjqom3IZLUrNqeBvHZVFmaIxebRvmXse8vW/3ynZ9NhFlpPjr+ZjYCtbax0HNY6VEkxxkD+U3mxdwGarxGMEqh6yZlS9LzzbbiQAV/vIk5URcnW+kB7I8HEIgeCeHPkgN/kA46rplGwnYRFA/hesLpp056/519OF7wwdz2lyJJa3CSK3oqj2y3JVLaUuCHLgPodB/YMlnhmY8ZWosfpyGT3gpG4wYXnu29+/AvjFEwOYW51Dao0/ThQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wvz7ujkQkNFdmcLVymGBe/+aemLauhqF1vKIiLipy0E=;
 b=cCYHxPJYsZaybg8RncShHyilAXlOo2jfrGeVTdvsUFCclw8cQ4dbeh+pkKxy9dkBZgrFPJzSXOcLwmEypIeld2FJPWQjALjzy+SkRFyLqI8cUwhf3I7e+tqK8/M2ZIde0c6CG7vpkRp5p/6v1zr7HAlM82Du7L8AgLcMxHnWLHU=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by PH7PR10MB5815.namprd10.prod.outlook.com (2603:10b6:510:126::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.22; Wed, 24 Jan
 2024 11:39:22 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::f11:7303:66e7:286c]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::f11:7303:66e7:286c%5]) with mapi id 15.20.7228.022; Wed, 24 Jan 2024
 11:39:21 +0000
From: John Garry <john.g.garry@oracle.com>
To: axboe@kernel.dk, kbusch@kernel.org, hch@lst.de, sagi@grimberg.me,
        jejb@linux.ibm.com, martin.petersen@oracle.com, djwong@kernel.org,
        viro@zeniv.linux.org.uk, brauner@kernel.org, dchinner@redhat.com,
        jack@suse.cz
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, tytso@mit.edu, jbongio@google.com,
        linux-scsi@vger.kernel.org, ming.lei@redhat.com, ojaswin@linux.ibm.com,
        bvanassche@acm.org, John Garry <john.g.garry@oracle.com>
Subject: [PATCH v3 12/15] scsi: sd: Add WRITE_ATOMIC_16 support
Date: Wed, 24 Jan 2024 11:38:38 +0000
Message-Id: <20240124113841.31824-13-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20240124113841.31824-1-john.g.garry@oracle.com>
References: <20240124113841.31824-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BLAPR03CA0123.namprd03.prod.outlook.com
 (2603:10b6:208:32e::8) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|PH7PR10MB5815:EE_
X-MS-Office365-Filtering-Correlation-Id: d2accf8b-1e09-45c7-33d5-08dc1cd11ba7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	rMJRUXcR/h9nze3yvgcNlO+7y7w7YWCREuNr+erPeM78R3u82kKH5bMnyW6M+4JBmCJ2B2wFFFLRr8wR6M7yErXNeU9j7u6z7aueOAIFrYf1KWoMf8A93tKxI8JxtTgWj2PNL3Nzfyssjmsa+XD16TgY9GoUDmNjZDRvN1bGakTUaAU7voEeJqhwh4Jtk6wvjR+FtEAsWKv+MeLV+ixvtmLr61u55+rOV87DGtDd+BstM2HN/BkLoTFpjt8DUk1EaGRKsfvPZ19VCb23OMLVnogcF8fEY/P8Xl6Wamayu24ozy3o1XoLTxgolfGoSJByHd5GCQtOBKx2Q3QdIBOzPYW1m6RvVVyIOvxwcLX6dCLRHOAICXKiPPB/CFp5Tv7Ta1e7zGXdeMuvyYv06QBA+qCevNPTrZnLZSIG9LZTpFICbnoiag7ovYCEEiJsMbFmNWvMNWiEuBLv8ruzVOt2JeMYTs5JityiOUlNmOUReX4DembzkRRI2vUAQQsgY17ECXWdzXjSP053kQHe3C4k1Joj0zG2MyWA4RzVy5+8z+ArFlSbYmAILgI77zAQxYInttRYDOVtRMAraYMVU2/S898m2dpZsDulQ/0yYnFC3jA=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(136003)(346002)(366004)(39860400002)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(83380400001)(41300700001)(1076003)(6512007)(107886003)(26005)(2616005)(38100700002)(6506007)(8676002)(4326008)(8936002)(5660300002)(7416002)(2906002)(6486002)(478600001)(66476007)(66556008)(6666004)(66946007)(316002)(921011)(36756003)(86362001)(103116003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?pNBIbsfEI9nXd6uZi2dS+PdSDXpopxZvGuYyRPEkTkxcGeM27XFhNx3DRKZV?=
 =?us-ascii?Q?SKPL6Y/A5MFytowBMx6YjjQZII0kLdqFGA0k4ETC8MRYYI9rWFVp8LqBBG+r?=
 =?us-ascii?Q?TdSVA4WCF9sWPOSe31vRFaGiKt9pLS3yKO8z/V3hdvjiSQs+4Yrkn65dilVv?=
 =?us-ascii?Q?QysRl5sFbjA6EhDi0NE7NrLARvH7Gs+YurH0XhQaa/PaVYV8NP6/t6ix/T/p?=
 =?us-ascii?Q?9oQlg8qrUhnvcv+v9ZAg9tdIs4Vi3JpNC5n2IEpOhWnJchQjDAA8/UAR2vaZ?=
 =?us-ascii?Q?Iez0lSJR8tBKeIDD1CrEPCELEPQL2ssYAWJST/Vy10+iPeQldcKExFgaShr5?=
 =?us-ascii?Q?IbWqQZ8yjqxvH4sp+aH4yWoDstf3Vd9iFTBygiZHAO9hf/CL6oeW8430Bgwd?=
 =?us-ascii?Q?LzJIdQ8PksxkHihnsp1s7wxxNYg1tdpJm72NI+kgV5P7RB2JJBFHIhzliOLL?=
 =?us-ascii?Q?zJ4pwKo+2HUyzdtl48dEq8VVKimaXywHp7MwHK0nz5576lL5t7GFQG7/FGxp?=
 =?us-ascii?Q?7ZkI476msPDcIFB6j1stcgjPMaPlhaATPe2AmF0w3FBAfN/gfOPO/zdiWKSn?=
 =?us-ascii?Q?eNQLthYNk+rNQBaJYAGrE5rSU0qDJwqccOm/bedEwdczWqwJri4MrQmo3k/8?=
 =?us-ascii?Q?UxowgTvA4CLCOxNslHIi92pS1TC7tDzcuJuMv9tTvw80ecGzT61CBMIg7Is3?=
 =?us-ascii?Q?15jJorerp9IqexP9eAsjuIahTRQGXtz5Zg3D2TURGNCwN6vCdzBRr5VDL9Cr?=
 =?us-ascii?Q?6XJ52qGjrXyorvi1Bf//wvuTQFX+NgaIoEg3UDcpYvpUVjbHRTI102je+EBv?=
 =?us-ascii?Q?hQHyGaxoVR2Jsw4q+Qs8eFCYcDAY835rkaCzEQueLQBkdpIo77XCaXVGGLrT?=
 =?us-ascii?Q?xhwQ/rtpwC9R8/Nd1IvyuJgF8azSiI9bv2xuhnVuTgN3u71AP3ArZiEqmmRZ?=
 =?us-ascii?Q?uNkuz3YNTimIfpPLxEOxsCOSUMqogEr13JRCEKosEfV17zevQx9NOt7rzgsg?=
 =?us-ascii?Q?3v7e6b4u/d1O6K/0iWOrGxPTZDSJQupURw5c6p0aoLefDKvY8c+FEKPux/Ye?=
 =?us-ascii?Q?OLsu7H1DEAh3o300yuZGc4k0tNMTQL9sfsiFMp8oKB6OmpZXS7TA+iYus0M8?=
 =?us-ascii?Q?+UJQg4eT2uk/GpZ/5LOjGzaeq3iGW0mCQZJfml5TpEwwTYRVZdO64M4vLFK3?=
 =?us-ascii?Q?ao4VG5VkRAdX4Qk5zs2Jt3MoZYFm9qM70WHd6KVNdNUn+KVJi7ZsXT/7oXP2?=
 =?us-ascii?Q?b/mq9tJbIxtjCmPfv+NsitbCxcRFF7bmdo0PTDisN6IOECz8smq84vl+0hJz?=
 =?us-ascii?Q?smBelfcdFMmXo3yVgLApT4DV6MqHvY5pEFabHSlbSMnBlcwBDFdDR2CfYV3D?=
 =?us-ascii?Q?K3Mnwp7lL0OKMqys1Sl4P8HnADxzLH2epGb1eYd/jQhCQp/cUGdbPKURtCSm?=
 =?us-ascii?Q?TWw8Y2VMU1PCUIEGmZjNV567T1xGi8AhWEksz+BapB/VwyZ+1lfa1gb+lhCn?=
 =?us-ascii?Q?JsKLepCBjHNp3lDKwITSRfvfMjHoLfOkThl8vst1n/Pp4I++KkBa85rWxruT?=
 =?us-ascii?Q?/AWjuzzY0pgBEqmniAUGYY/Fe2xwnEfN/f/DAdl8PF9+aYOZNydWi0Aeaw1I?=
 =?us-ascii?Q?uw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	5ohyIq8jwxFaByjGnxR825DRm1yupSzCiJ0sn9hvv/vdPPB3ABr5q9fQj6z4/H9geXIOb8w07XEm0CPvfnNYasBoeanR1hhobtdsSil3wtuukBlswLRXpxFCwAC3Hwl2z0jEjy3XpCc4u3gw7hcG2QCZFgFltUp2TkCptJAkFr/TC9cfDkD3HDIe+f2XwEktJlFmmVWxxqr66aCjq0Ee1Hq8xQMVT2zn+V323fsa+8SMTWIG6SWhobvBocX393v1ct+HQoYaa35Xmcs2prkvmiVrkqNEDRB22CzOHy7g498KHt+41rHlLfmESwi4PAjmt3Em89olePzRCy7D5N1mJsfIGjfKzSJSVT1+Jy/jKNkKlik3lbq/uLXe19I2ZbtCPZCWn0D4OsLZ1LPj9vJT6biC21PqixOuzdj3+3ZF6jVEo4B/AyCUjjMcCo8Gu3yLuBWVdhQHz9nEaTFch3P895DwUHfNC++OG/wmbBJdcwYvOF0LLYHGnm5OYbtarL9wWBGGmbeCCt9EOLIxuIq9biuR8Qk/3Rd3JrDXqqAZyw8PnRWEKdfqVsxCQQzojNKiQlitLXH0gonVmtIra4o3J3X/hENKAFfGxdtuJakNQs8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d2accf8b-1e09-45c7-33d5-08dc1cd11ba7
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2024 11:39:21.8287
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h/eau/8LV6DUChFAYobMju62RCPcdXPJXWZy7vmjtBYM97MIOtp2Ev+uVdeE/LRrTiylz8b6JrzQ0Hom1v1BVQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB5815
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-24_06,2024-01-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 suspectscore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2401240083
X-Proofpoint-GUID: q9TkkVJMWBTu0z72auISEKWcTLU1YY-P
X-Proofpoint-ORIG-GUID: q9TkkVJMWBTu0z72auISEKWcTLU1YY-P

Add function sd_setup_atomic_cmnd() to setup an WRITE_ATOMIC_16
CDB for when REQ_ATOMIC flag is set for the request.

Also add trace info.

Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 drivers/scsi/scsi_trace.c   | 22 ++++++++++++++++++++++
 drivers/scsi/sd.c           | 24 ++++++++++++++++++++++++
 include/scsi/scsi_proto.h   |  1 +
 include/trace/events/scsi.h |  1 +
 4 files changed, 48 insertions(+)

diff --git a/drivers/scsi/scsi_trace.c b/drivers/scsi/scsi_trace.c
index 41a950075913..3e47c4472a80 100644
--- a/drivers/scsi/scsi_trace.c
+++ b/drivers/scsi/scsi_trace.c
@@ -325,6 +325,26 @@ scsi_trace_zbc_out(struct trace_seq *p, unsigned char *cdb, int len)
 	return ret;
 }
 
+static const char *
+scsi_trace_atomic_write16_out(struct trace_seq *p, unsigned char *cdb, int len)
+{
+	const char *ret = trace_seq_buffer_ptr(p);
+	unsigned int boundary_size;
+	unsigned int nr_blocks;
+	sector_t lba;
+
+	lba = get_unaligned_be64(&cdb[2]);
+	boundary_size = get_unaligned_be16(&cdb[10]);
+	nr_blocks = get_unaligned_be16(&cdb[12]);
+
+	trace_seq_printf(p, "lba=%llu txlen=%u boundary_size=%u",
+			  lba, nr_blocks, boundary_size);
+
+	trace_seq_putc(p, 0);
+
+	return ret;
+}
+
 static const char *
 scsi_trace_varlen(struct trace_seq *p, unsigned char *cdb, int len)
 {
@@ -385,6 +405,8 @@ scsi_trace_parse_cdb(struct trace_seq *p, unsigned char *cdb, int len)
 		return scsi_trace_zbc_in(p, cdb, len);
 	case ZBC_OUT:
 		return scsi_trace_zbc_out(p, cdb, len);
+	case WRITE_ATOMIC_16:
+		return scsi_trace_atomic_write16_out(p, cdb, len);
 	default:
 		return scsi_trace_misc(p, cdb, len);
 	}
diff --git a/drivers/scsi/sd.c b/drivers/scsi/sd.c
index 32dfb5327f92..7df05d796387 100644
--- a/drivers/scsi/sd.c
+++ b/drivers/scsi/sd.c
@@ -1240,6 +1240,26 @@ static int sd_cdl_dld(struct scsi_disk *sdkp, struct scsi_cmnd *scmd)
 	return (hint - IOPRIO_HINT_DEV_DURATION_LIMIT_1) + 1;
 }
 
+static blk_status_t sd_setup_atomic_cmnd(struct scsi_cmnd *cmd,
+					sector_t lba, unsigned int nr_blocks,
+					bool boundary, unsigned char flags)
+{
+	cmd->cmd_len  = 16;
+	cmd->cmnd[0]  = WRITE_ATOMIC_16;
+	cmd->cmnd[1]  = flags;
+	put_unaligned_be64(lba, &cmd->cmnd[2]);
+	put_unaligned_be16(nr_blocks, &cmd->cmnd[12]);
+	if (boundary)
+		put_unaligned_be16(nr_blocks, &cmd->cmnd[10]);
+	else
+		put_unaligned_be16(0, &cmd->cmnd[10]);
+	put_unaligned_be16(nr_blocks, &cmd->cmnd[12]);
+	cmd->cmnd[14] = 0;
+	cmd->cmnd[15] = 0;
+
+	return BLK_STS_OK;
+}
+
 static blk_status_t sd_setup_read_write_cmnd(struct scsi_cmnd *cmd)
 {
 	struct request *rq = scsi_cmd_to_rq(cmd);
@@ -1311,6 +1331,10 @@ static blk_status_t sd_setup_read_write_cmnd(struct scsi_cmnd *cmd)
 	if (protect && sdkp->protection_type == T10_PI_TYPE2_PROTECTION) {
 		ret = sd_setup_rw32_cmnd(cmd, write, lba, nr_blocks,
 					 protect | fua, dld);
+	} else if (rq->cmd_flags & REQ_ATOMIC && write) {
+		ret = sd_setup_atomic_cmnd(cmd, lba, nr_blocks,
+				sdkp->use_atomic_write_boundary,
+				protect | fua);
 	} else if (sdp->use_16_for_rw || (nr_blocks > 0xffff)) {
 		ret = sd_setup_rw16_cmnd(cmd, write, lba, nr_blocks,
 					 protect | fua, dld);
diff --git a/include/scsi/scsi_proto.h b/include/scsi/scsi_proto.h
index 07d65c1f59db..833de67305b5 100644
--- a/include/scsi/scsi_proto.h
+++ b/include/scsi/scsi_proto.h
@@ -119,6 +119,7 @@
 #define WRITE_SAME_16	      0x93
 #define ZBC_OUT		      0x94
 #define ZBC_IN		      0x95
+#define WRITE_ATOMIC_16	0x9c
 #define SERVICE_ACTION_BIDIRECTIONAL 0x9d
 #define SERVICE_ACTION_IN_16  0x9e
 #define SERVICE_ACTION_OUT_16 0x9f
diff --git a/include/trace/events/scsi.h b/include/trace/events/scsi.h
index 8e2d9b1b0e77..05f1945ed204 100644
--- a/include/trace/events/scsi.h
+++ b/include/trace/events/scsi.h
@@ -102,6 +102,7 @@
 		scsi_opcode_name(WRITE_32),			\
 		scsi_opcode_name(WRITE_SAME_32),		\
 		scsi_opcode_name(ATA_16),			\
+		scsi_opcode_name(WRITE_ATOMIC_16),		\
 		scsi_opcode_name(ATA_12))
 
 #define scsi_hostbyte_name(result)	{ result, #result }
-- 
2.31.1



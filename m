Return-Path: <linux-fsdevel+bounces-8768-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 22CCB83ABB4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jan 2024 15:28:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A81921F2CF29
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jan 2024 14:28:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2468A7C0AF;
	Wed, 24 Jan 2024 14:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="PvSPsTPu";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Y3TVLwGm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBE877A73D;
	Wed, 24 Jan 2024 14:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706106456; cv=fail; b=I2UDZEmKfdvOyTwLlCt73Y8kLj/V54rSfl62DwpUMoWTkaDDbdJqjW7IJotVcMsI/ZEPquk5PzQnwX4dcYxucn51F5xewLk2d13EGJ2ypsqHLUxcC/E5viR6b+bAzjAY0r519S3kzIslptFjAZk+yDkgbh49s0lD4GF6q47khXU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706106456; c=relaxed/simple;
	bh=qZ3ZqwcL2mSkOxkMdrRgCcLrz5wNP590t1lYbOF3NEI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cNUfKePwf626oJHdc8wr2agMJC2qahd1tZN67MO4z2YcIjP2eRo8nOGfYZTqDIZ3QNtOocPMXLi9F+57LChf/SPDCl9HvK7PAruy89D+Gm57HqfXIzjvxChxfW4Vz11R/KFVFyQ9NSnuiDSwgN0ivI4/8xa/k406PzHTT2jIdOU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=PvSPsTPu; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Y3TVLwGm; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40OEEAwW031335;
	Wed, 24 Jan 2024 14:27:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-11-20; bh=+WEVMn/qZipO6hxM2qw1SmQSPSCdzsis+iVdAbrZA8E=;
 b=PvSPsTPuRBHLdcZ9z0R0SOpQ3MVY+bBcHn6sfbb1MT3F/ESMuT4YCz9XlL3CxH5DsDc7
 UgDHrhLXrNHQN/tXNnl1UH/bnQHZQS4JpuoB1w99vWsORbYm8rethGSUjWOuE/ItJTaS
 HiiwuBMUj0O6egvQc7jRGRiBlIMibNbdf7hl0vhAAsY3uGHPc3U6Yi+7uDwyfZ+ZRrtk
 m4KdBXQYcjOIvr9X9fs6vOY+IDAEYj9seSj6dOd5glEzwpg9dJDmk8Qhc6aNgtDdQPVi
 h+1XP/+rROam80+R0hceXBPNcNQteXVouNB2aEtPtJKkZlq1KcqcyfqURK4S+Pan+hfE rQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vr79nkxaj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 24 Jan 2024 14:27:12 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 40OE1L2F029572;
	Wed, 24 Jan 2024 14:27:10 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2101.outbound.protection.outlook.com [104.47.70.101])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3vs372rr2v-5
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 24 Jan 2024 14:27:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kWWrPK0+P+tUVbfqbx59EvRql0lYN78nTjCq3qHYra8GdAS6xzaYROzyEtnCSgNtqYrRLbcZXwpNt6J/gDNo4yOt2lTQ2yvCWoShUMTKJX7h9YSpiJn/xgEU6COnX3rTCv8Z81vys97p7N1PeTBynGOBXPGWdomXxMyGzBleTsfVTWFYsVeJdyn9/o2uNb3yVjGkiDwCzf00WrHIK79mbr79+RTV2QieDzcf4Kh0lmCeG6B2Oh/cJ67nlRLs+wtHb/6gYXz5ylrGsF2RXNCc4YakpZE4MmeEBNvcw42SRMfGyPyQrT/FyLv7KG1SS+JlT/79NqoizkcZSQSxL9rukg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+WEVMn/qZipO6hxM2qw1SmQSPSCdzsis+iVdAbrZA8E=;
 b=NJv5UN4X7P/bGSsuqRKGe+ZA9TgShStj+LovAH1YCZ0rSpREDsyr+NRLF/lLWmJCwNsc5EZI+2OprCLPUtczna1FByMIuMvfrPZyfoXDoCXBi+O54UYOTP16N0U8P0qzqsraJhSXdufBE92TBdc0wcDgZJ9ESASxksYteR0o1rGKximMclaGWXoQOYIlegCOwA/By14Zuo8FjrJpZcoMMFIhibse1pNXdiB66NHwKlYyKceGCIC0IunfELF6n9ovrPXW2c80c9dhvhFwr7osy1mVq0qMpl6QT/WDtW8uDqzLOdUE3qqFpEZ8PJTVm73UzfKGPz1MxfrtJb2uTc3xDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+WEVMn/qZipO6hxM2qw1SmQSPSCdzsis+iVdAbrZA8E=;
 b=Y3TVLwGmHbu9LFUDdTMhvCMB9vdmVU1+yLFSkgE7IOsaqL5jUcsAo7SzYgTEQZLFaR7osIZUyHn1Ng+tA67MI3lNSgtc0GpuA66OVnJsrNFx+og9Qb8CYZY3/IMuz25zLbC+Eb8+/350DlNuzYKbDMKYLtzvmbr5v/D/VnHOID8=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by CH0PR10MB5212.namprd10.prod.outlook.com (2603:10b6:610:c8::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.24; Wed, 24 Jan
 2024 14:27:08 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::f11:7303:66e7:286c]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::f11:7303:66e7:286c%5]) with mapi id 15.20.7228.022; Wed, 24 Jan 2024
 14:27:08 +0000
From: John Garry <john.g.garry@oracle.com>
To: hch@lst.de, djwong@kernel.org, viro@zeniv.linux.org.uk, brauner@kernel.org,
        dchinner@redhat.com, jack@suse.cz, chandan.babu@oracle.com
Cc: martin.petersen@oracle.com, linux-kernel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        tytso@mit.edu, jbongio@google.com, ojaswin@linux.ibm.com,
        John Garry <john.g.garry@oracle.com>
Subject: [PATCH 6/6] fs: xfs: Set FMODE_CAN_ATOMIC_WRITE for FS_XFLAG_ATOMICWRITES set
Date: Wed, 24 Jan 2024 14:26:45 +0000
Message-Id: <20240124142645.9334-7-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20240124142645.9334-1-john.g.garry@oracle.com>
References: <20240124142645.9334-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1PR13CA0441.namprd13.prod.outlook.com
 (2603:10b6:208:2c3::26) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|CH0PR10MB5212:EE_
X-MS-Office365-Filtering-Correlation-Id: e52ab45a-ed03-467d-eb8c-08dc1ce88c08
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	IjUzRuHWG0EyqtQ3FM93e+GT/PnpNqMb/Dsyteg/clgM7HFRnCmn+tJT8TelvxivRByEJZGTcXT7ZMfsm6+SPbWlZb9JQ3C30Uav6/LuGxdgh+qT0WQsTu07RxAF62PNnS3UjecyplGjQQfXSMBPk0GuY0sRPWdKDcn+r8Hwlmv+fIWkWiy2BONuxcS9YZmBLr1urp6eiSL/j8Q0DIaSrtr99VK02VscA6DaShWnL7aroyju0riAEmnAlxGgQiDHXKLKeEls8ygv8CeYhCBPG/orwIfGAlsj9OuupLrbf8nEefAQJfBsZVcWhv2ripDIr0peqWB8KGvXlw/ZaS0hB3WFfJkDsWjzVBUK01xgF/VMK4QnQ6fiEt0ZiLchnIZ1U2hhzwTt7CImOe6cExWS2BqO+bF1R628Gnam3QcGwaSkZbQ0edEWCyk+UhU5C1DfccA+KeDXJdcDs3xiP1NQ8NV02VQaTlinwFssjAvwb4DZOe5WmtNEZuXP2bxSMJP28s11GSflsXTG9arcQrspXJ/BxhZuhkk1TY7N5scOZjCRSY6nW+jW4fwHjtNrYzKq
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(366004)(376002)(396003)(136003)(230922051799003)(64100799003)(1800799012)(186009)(451199024)(83380400001)(41300700001)(36756003)(86362001)(103116003)(38100700002)(107886003)(2616005)(26005)(6512007)(6486002)(1076003)(6506007)(2906002)(4744005)(478600001)(6636002)(316002)(66946007)(66556008)(66476007)(6666004)(4326008)(8676002)(7416002)(8936002)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?ZMR10NnOzVZruRQtqLY09tE/t7xtvKFZoTNocY7Oirl2tY0hAgQpPM3iAD7J?=
 =?us-ascii?Q?gkdXq9DHA/tKvlxeg2v8w5oBHwTZhebhi0Wi63HYR8c0g3QIg08rfJpwCk7a?=
 =?us-ascii?Q?Qjlnf0wmlRd6OnCQjPWLBuUr7QqZENi+Q2zl3HOiUCgTOdkO4BTlTnNLbdVK?=
 =?us-ascii?Q?vJ137Sm7Sr2323Aonmd2s144KxBBvP6XlvvE04949VRqCeaTDhuY24pxg69r?=
 =?us-ascii?Q?75VEA26hYt04S9V36cvbWuUuo1wxd0x6h8Tj5edAJxFrC6hUH1C+GvPH9bL9?=
 =?us-ascii?Q?Fg14aqGHE0sCz4GnlMdz4w5BfdgUKy/43CjcSJpnjVSeroCRbHoq2Mr8Px5H?=
 =?us-ascii?Q?eR3iZrxGY30279U0Vie5e15HxtLgy5naF82pRd+gy8+Ji2RBif2wW1LFdPyC?=
 =?us-ascii?Q?v+KkQDUShygNFo3ngTyTn8KpY/z3mw2lE+W99KxzMsNeVxpTcd762dCoYpNQ?=
 =?us-ascii?Q?qve7frDX1l8pvVlxWHjAyu6+FOUmZ+QfuZfxqjvcLp2gHEfkZOy0qgXK7RoG?=
 =?us-ascii?Q?i+TGALyHuJ541bT32De9Me6QdCLqfQUVrJWvXGMyobj4U50q7VY7vSRfHW6t?=
 =?us-ascii?Q?b7tA/Afc5y0C7HthLDiBPxLtx5QULKW3ln6lpGd7AGr5531HVnS4Kc0Y/IlP?=
 =?us-ascii?Q?bpgmOGHJp0GgAjfxY3XEA5gGmHtN3UFFGUV/sDCPVr3ZoOQvOScfHqMaZYYa?=
 =?us-ascii?Q?bCIAFdZAOcdq+b5eDjUgq3rhhFA+AssF4nTwFTik/jfcF2aQdrsEFdYnMNj1?=
 =?us-ascii?Q?pJpOFRixhuazfoGfgkiRQvT4wEMUsuzUC8w4c3RlYMKqysNKlvRfGgjXjnty?=
 =?us-ascii?Q?woG3xHCXtkBaU45oYIF77cy1EjJj0Sn15DR3jUmYfvWqp9li0IsZoIjvNUx0?=
 =?us-ascii?Q?GOhm1j3/JTbQ22lYWfCnyFhAWg6h4Rg8anWt7uu6/x8WC+rbuNI7j3VlTDrL?=
 =?us-ascii?Q?SOyQwkqx8/bCQSP5jeIO9ODDRIvxZ+y/9L8qw0ZPE7CMpA0TZYn1tGwG2ZWu?=
 =?us-ascii?Q?INdCuxBzLf8WamjUnZand+3G+9F84yvlvhEqdDRJO7T4ohWBHQnrEpq7xL51?=
 =?us-ascii?Q?IMJLQ2vMlYoGnWRDBB2OkwmRBReJK0NrbTCSG/pL1aKBmVXU7RubkvGJOwTI?=
 =?us-ascii?Q?ogn4/FGAGrS4/ugXh4eHupjebkcmsSi0j2N6LBB1TyDDC+u2FfJ5V+DLMoaK?=
 =?us-ascii?Q?v69D1qRtcEugD0iHYDr9Dm6bMV8ooz0dZSYEa4kPWqT+HKhXl2RN2gcv2hZu?=
 =?us-ascii?Q?bT9KmSkQ+GvFjzPHoMWs0Xjj6cWpxhaVKqSkVYFEsSC9ns6Ovi7Al85mdu27?=
 =?us-ascii?Q?MahzL7ycYkPZY2RjHVvO9EmmXlKAIh0rTCJ5HjElpXiBnvyubJg2e6heYJ6e?=
 =?us-ascii?Q?q62gpJpsHc4NWZSNkwDwlX9DzUFGc4NAzSrcRmNLdcwDOa0KOhwlfUfGWpmp?=
 =?us-ascii?Q?T1eb6hKHxc2B6+mYHdcHV3l8D4qBItgt4sTxoaq0px/pTU11M8uK4vmYyQkn?=
 =?us-ascii?Q?bxdchGcoi7TmUxZGCW1yAl9CJiahr3g+Kcdh8mTGntF6wsWYJaq44BUl2PrN?=
 =?us-ascii?Q?S2Lza5PaeBRmMqjebSfFSJSzqBzkZbXl3AWf/N9hIO9jT9qlnHIoqlH4FOaR?=
 =?us-ascii?Q?9Q=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	J7X1KL7V86+E7SEAsItWNH4+TC5WdoDIvfS0Gp0WNdrbLmQTY8eAfyg5EGQiodmJ3iAAdWQUM4h4PJXVuYTXQXfhoy0ASLip55nwt4KLwMK8SMJclGBC5rM/ZsMPAAlPL1xKCos9EQjTKjDPe8x9Qe24FdENyOrgzKSc1gFZBJhoxQDGxApLu3PawSx96oUTab02BtzlpN4uUuHcQupSs4WwZt5AKYmq5ZmZg3hZBgTxoYvAzVAfI8XNPQJ3lB2DCwD4FrO2bPmUPT/v4UbPi+bF7SsrnA3oFdD5cV81C9HUMLHU+RBRjsUXU/AczN6vwYZGJnixbky06aW2Qux68SpOJEf/42YLVYFXAd00/W4HkmDfBTALa6M4Yp42nQcBMufKyJvQeZjMttWK04UEU6MWpwICa15RLjo1P3XCuCh0614SPA96PbHp5FEDKty1KJz6xSsdqGUE/ONegNvVzqRSSiDZJ9DQxlAc6YkQ2wsmVpsuhdiAsDxwfQrA57QABz8mD1On/IAzF4vNefVLvQDNWrTqjfrhb+tpIhSdPLAiFApyWoKBdk+J0eHn3nWCo+2cB8LmhLpHwOFrvTon86+kBkkrBm4CGeOTghg2r8o=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e52ab45a-ed03-467d-eb8c-08dc1ce88c08
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2024 14:27:08.8655
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xhyf2P5EsJa3rMLlTo/qCPSCFWGrZTXfkGAqwmyOWF78NVZGMRkfiqVGRWo9u/HDWmj/wSRNHHylvaK2V7G9Vg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5212
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-24_06,2024-01-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0
 mlxlogscore=999 mlxscore=0 phishscore=0 adultscore=0 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2401240104
X-Proofpoint-GUID: Rb1ppTtU-Ba4OLTo3ljzvc0A79HyRIrc
X-Proofpoint-ORIG-GUID: Rb1ppTtU-Ba4OLTo3ljzvc0A79HyRIrc

For when an inode is enabled for atomic writes, set FMODE_CAN_ATOMIC_WRITE
flag.

Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 fs/xfs/xfs_file.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
index e33e5e13b95f..1375d0089806 100644
--- a/fs/xfs/xfs_file.c
+++ b/fs/xfs/xfs_file.c
@@ -1232,6 +1232,8 @@ xfs_file_open(
 		return -EIO;
 	file->f_mode |= FMODE_NOWAIT | FMODE_BUF_RASYNC | FMODE_BUF_WASYNC |
 			FMODE_DIO_PARALLEL_WRITE | FMODE_CAN_ODIRECT;
+	if (xfs_inode_atomicwrites(XFS_I(inode)))
+		file->f_mode |= FMODE_CAN_ATOMIC_WRITE;
 	return generic_file_open(inode, file);
 }
 
-- 
2.31.1



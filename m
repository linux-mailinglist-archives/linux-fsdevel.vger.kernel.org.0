Return-Path: <linux-fsdevel+bounces-18149-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D23F8B60A2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Apr 2024 19:53:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E79B51F23A85
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Apr 2024 17:53:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5B52128815;
	Mon, 29 Apr 2024 17:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="NhLFB8eY";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="N4HVY+bu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DAB1129E8F;
	Mon, 29 Apr 2024 17:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714413027; cv=fail; b=bEM6t6zRiuVuoJnGhmZi1shj6W6R3BMN5yor2gok3lwH+UGV8qusgPiuuRYTX9ksaVht4APu7hHs3CppjPNzhd/DYWKVILAoYvXKt2On06vc95b/iqo8UGnUZBaQXU1BSyGIlW7RV+NUc5857PEjAyEtM7pDRFkolXOCeGQGDz0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714413027; c=relaxed/simple;
	bh=VCPkpAEQjz8u8EgR6KUyGxQAA3+mxbDUFf+1SHWJ4Ik=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DkqjwD+RDtgGIkslk29k1PgCBJkWPit0rfscAzuSoYmCTC9BT5XZzpVzfw5DiCjYQkq9PwH6i7GJhAFaV0iVqWWbXGLvghIJSslo4/LbPQGrT3ovBbokc/04SpMeqfmsuYZfqfV239G4eBjU/oM8OOXMWOfqfQE6PTQWbF9mK3Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=NhLFB8eY; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=N4HVY+bu; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43TGwu8W030178;
	Mon, 29 Apr 2024 17:48:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-11-20; bh=OHzS2fYFc0bOcvih7E1zlHuMxQTCpvNo8lJ07t9uTec=;
 b=NhLFB8eY/boS9gOWkCV4+BAFYj0AX4yZzKwY/oHU/4zPbc4tdUsqb3s61D5K38GZy3H/
 6vxMIa7KazegvbCVk1RJFLtheeOE3MjAsq0nU+3mNr+QjapeZelr8nHVBmPJA3HMVOj2
 b2EeqVl80nZGdfJyqZ1f7rgEsh2VWXG9PZOdQ4QFhwgnYLvtsr3sjfywRxBMQ6Dipqmy
 P/ZSv3ySdk+EwgKqUvs55Tkq0EQgHZ4E8zEU2EejhEF+scFYMpVlKShJIxcJfZJI1kkP
 bp+P0CXJqLimvao5Fsbowy5XHvEUVKclIKZ9pRTvkgQTc7/XgKaTRLObpLtY0HoQhqeM EA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xrryv365x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 29 Apr 2024 17:48:27 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 43THkxUS004324;
	Mon, 29 Apr 2024 17:48:26 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3xrqtc7ns0-4
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 29 Apr 2024 17:48:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Pc288GFFDl7jzMDYmfID9NZ/ZxZdXLAOe1t0qJ9CN6wyjGCnzCAE8O1roYtG3VZXxwMsrFGvL4qlctEJsRqm/2G/3rCGkCWt0fiGKuMSd2NwX4W8kI0rCm17kvCiV6kUCJiTrA/zChGdH1XSGvk8xcczPvOc1HrOcamtsdgNhM+zrfYlaCNHa7dUnO5gnnnxxNcEP6EyUNk1wihp5fWLoaFYsRmNuluHT/bEMU816gj7G1GJwThoHw9Xt54i8kgwOuDyED+jcg1sZ9WXHUWdDdlDGwnw5mTSm4ux3+aHLGXPRuQpt0srCAn55jN6RpP1K/vO/1YG8IqXjSPrUZSoKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OHzS2fYFc0bOcvih7E1zlHuMxQTCpvNo8lJ07t9uTec=;
 b=Aoy9TrC9g+BcJ/XwEFXXDDBw0+rkgtO5MS7+eDp0Q2UlmBSPzUJo0jzJJiEIS1EvARrxoN0vKk9AU0JQ9Yk1vPxInCXcT7n9EgFLPJOW13arlL5T125CdEqa3d8YmaV9nLO77f44sWAvmtYRU57fialXOVThyga1DRZeruzSbfYl7HcjQqEW0pYuhOgfOEJCsL+jzsF5FECn2PwwRBjbCSp9ZPxTF9IuEHcQ5+DOTGgakBAYzoozDq+29SzZU9AHvpfzwkbn8i/OD/Zmr8DWFmB3xOjCiSbSMeht/7/Pmu06Fp2qMdzztyS8tTEojJ7PQr2KwhUN+OWrFiJ5zoe1iQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OHzS2fYFc0bOcvih7E1zlHuMxQTCpvNo8lJ07t9uTec=;
 b=N4HVY+bueJSh6/2n4dpmVOm2cGCtXONjI97b6pa4b/vYbi16CU82PUWvP7GiSAXeONBqRo6hoBZ09W4lBezEXUJVnggoe8lOH/7RM5LeYeOEadsog1PrIm+XoCA88WHvklI9X1WO9xYTYeEm4Wn4tJLVEfh4Cyiq4XEU/1fnb2Y=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by SA1PR10MB6389.namprd10.prod.outlook.com (2603:10b6:806:255::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.34; Mon, 29 Apr
 2024 17:48:13 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%4]) with mapi id 15.20.7519.031; Mon, 29 Apr 2024
 17:48:13 +0000
From: John Garry <john.g.garry@oracle.com>
To: david@fromorbit.com, djwong@kernel.org, hch@lst.de,
        viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz,
        chandan.babu@oracle.com, willy@infradead.org
Cc: axboe@kernel.dk, martin.petersen@oracle.com, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, tytso@mit.edu, jbongio@google.com,
        ojaswin@linux.ibm.com, ritesh.list@gmail.com, mcgrof@kernel.org,
        p.raghav@samsung.com, linux-xfs@vger.kernel.org,
        catherine.hoang@oracle.com, Dave Chinner <dchinner@redhat.com>,
        John Garry <john.g.garry@oracle.com>
Subject: [PATCH v3 04/21] xfs: simplify extent allocation alignment
Date: Mon, 29 Apr 2024 17:47:29 +0000
Message-Id: <20240429174746.2132161-5-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20240429174746.2132161-1-john.g.garry@oracle.com>
References: <20240429174746.2132161-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0055.namprd05.prod.outlook.com
 (2603:10b6:a03:33f::30) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|SA1PR10MB6389:EE_
X-MS-Office365-Filtering-Correlation-Id: 3263eb56-8d38-4977-17fe-08dc68748a75
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|7416005|1800799015|376005|366007;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?vKpGhRnGEKmHHocWMzFdzvdYSsjYNp88CesIj+cwXEdFI7WdyepKKMVOtYos?=
 =?us-ascii?Q?UbNm3DCEvdJhKNTFM9bQoKbkFe5swz7cL8MjjSACQfIesqGYe3DdZ6HgJDS0?=
 =?us-ascii?Q?vBMD/4wksFcUwZkNOBsl4O94JQfvFQHF1oR0/ruqso+rcOPa7o0wvVdhjVk0?=
 =?us-ascii?Q?iCDauaS87UhxYUvaFXsIFRpLDBu671y9Xu+edJmWJEDermkyZJeBISZsz3Zq?=
 =?us-ascii?Q?JI+pv/uS95dTXZL9I0oEBB5ApHVXqxMgWaJKdYG0NgEq26ZipceNcpnES6e9?=
 =?us-ascii?Q?YixF1hsjIXQELK0qdDsA4N6oa1WYbdoeYRNKECSdJ9hNKt7lpDXxhugWtZeD?=
 =?us-ascii?Q?kMujbnmC9EliuXDtnW7wy2iP0n0ZU3S6yHlN5b7C8EVhYrhr0ErUqWfJ5l5K?=
 =?us-ascii?Q?tOVe1h6QO518TxVuJ9ErMekJPiQVd2GYeziwLOVx27L2Z2b3j2KsGZPK4lU4?=
 =?us-ascii?Q?DSMk/bHngelMzGQxlIBXNUEmOYfbSTu5/7LKKseUqZ3RlyQ84wmIl9zEOhCD?=
 =?us-ascii?Q?BApjKQPmTCmZOHSidYyg51dvp0UOMvxlfcdxThvOSrPshP+oz0869aA3TXJJ?=
 =?us-ascii?Q?nBoNx5xNHG7AxDbxWCSvHPFiuqrTe1fnK0Ljd1py/oMyKEuJ5JADpKMMUBdz?=
 =?us-ascii?Q?PpTQQ9SWoAXEHn4F9HkoZoiu/sHDHOb831URS7M8PuVcGS35zb81YGiEmL29?=
 =?us-ascii?Q?sJv2BSWfQ3SD6EUViHd8VHQKwRY5n/gEHL/x6lUMWpE1jRiBui825aN+fyYz?=
 =?us-ascii?Q?0dCsN+1BOeAraTh7ni7HuL0MXyPweT7nPO0fFNTepsV9YxCYUc+e6k7CMSfa?=
 =?us-ascii?Q?7ZJQS6FtfbMwZ2opeGCyTVjFgwV4dtM5e50KwrKBl+JatpkWym5spjf64N8L?=
 =?us-ascii?Q?u0cx1zpsWQbR0MfkjslYhzwrBByk4RwVl0T6pyD7+TOkgkfIAXTfPSyGMdnV?=
 =?us-ascii?Q?kAxejuFwtkyz91nkDTscHMtjHLPiaOFsCdJ0WZaJDBo8by+4TAAdERF5LlKm?=
 =?us-ascii?Q?eDy2kUfDZlrjEtGwpiNgIMA4poMo6ANNxiLszQzYyBNGynjvoMtlL1b8+zp9?=
 =?us-ascii?Q?UDC9EM9jG7QEbbvU9/Bt6oLC1upPTRpeiIctlvIDGv42iQLm1u6iaSyyoEvU?=
 =?us-ascii?Q?nJqrsgUya2d2BUUhhwVa0pJXlsyLOnp7v3j/pNVaD288ZbR1ogjO5xU7eNKQ?=
 =?us-ascii?Q?6i44YTHwhHqYG5+/4ksdBjgjedGXy4UTIjHtByr5xXjD+IXAZpNh3x5TN83C?=
 =?us-ascii?Q?Wo2QI1eITTbGBgurZzjAvPpMB7lYVA5jvEwbxowWSQ=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?kjwVhF1Ix75EHdombCV8HA7MEElN8iCEtbLrbUZMIHDLqHf/T51o5XOY2hRs?=
 =?us-ascii?Q?OG2Y71u7S5tzlKtkSgUnJLVt9r6GvwKBQ80uaOqJZkS6QNAmFhkZGdvyZvJp?=
 =?us-ascii?Q?D5kYMdGH19KTHAmfn+oJSG2s57d6OuuTDmZ2/raWSLGHBvqG+jj1FTBtN8Yt?=
 =?us-ascii?Q?LR46et2CPH6jlbnkspM2axhZhIturjfQnj8FR4nntCEtkARgC2saqHnXEGcc?=
 =?us-ascii?Q?aZbBsO8uYEw6afSipTrSIwPilcNDj7QYiMOp6TFFIXSK1iWKmymsLmGXHkXX?=
 =?us-ascii?Q?PswfeonOBtknCFe7yl6V0osDHYUA4IZoUjJQG+mc9dn2mizJ9ZzmPoPn1AbW?=
 =?us-ascii?Q?025zLgASsQOzN6Iw6zPezgJ6MczNSiCYoGmra0uAcNIo5R8LghnnrEBE2j0j?=
 =?us-ascii?Q?cv0IeuNYSz+t0qY4O005SdjhiiAYJa8wjD1viIOZrGiwI12okBONSps8PKz2?=
 =?us-ascii?Q?rQ27D2vnWZUt0XfOZL0OLZnIN5kO7Ws18ENr04zXQzrssIL6WHDp0zNJu7WG?=
 =?us-ascii?Q?3LLijsrBHFJYmLHw4rNXozz0CIVfvoIpufmaW/I7cUq0OSUvufVgjBjsX0vX?=
 =?us-ascii?Q?Guc4xyxn0TSu+Ql2MU82Ityh+ZUPz0i3fSx//UfLpPJ/x7r3UiikL75a/4C6?=
 =?us-ascii?Q?F+irdLQrTLuN4HRBMTwoG5QSNYjZMojdkQcApQOPU7HrrqaVjLu/+Og3zKlO?=
 =?us-ascii?Q?9Xmriz7CE38JLqHkgxe8HBVuFH6vPsZ1gudY5gCKDxFxylE44KQ0z8urIGz5?=
 =?us-ascii?Q?9xcUoz1JdAOhKzWPviUUU3Tp8FRJaSBWzWCNJu45N1wGF4Yz57jRqFyWUe/u?=
 =?us-ascii?Q?gAsAFeaJj9INuV3lW7b5GyL8FqBC1ow00zu0r1r7V0Ml89dX8aQi++knzyGY?=
 =?us-ascii?Q?iGutyNI3rDV7ZqoTvKPnahOK1/jtFtHv21voI8jYCmubv3SOeIpJRu9WgX60?=
 =?us-ascii?Q?ykJM0x6wxJDRuIveIbhs1LqzsVU7HVyut5RygP+KoQzp83RKmdQpnvyZoQ59?=
 =?us-ascii?Q?TOaPB4CbqZVOnumy07d0uUCuullH7f3rZKBgnXmm2w2CKQsRxCnVdfQTANw/?=
 =?us-ascii?Q?fzGZndD1CSkocnJITC8pF0I9JPks3obyRFY8ggFHsvrKI8+VLQ+zSP4nOHsV?=
 =?us-ascii?Q?yhR8EmWn1crj7y7F7z862qEF9r8TRH09/Zy6hEcinP1xz5u972ozMYdRuy4e?=
 =?us-ascii?Q?3lZcNusjVXgfz2AQMPlXB7/t+7buxfLtwB+zKH6oljGn64wm30wJCimXJsam?=
 =?us-ascii?Q?HD2l6oN2wXHFOdW/TWPJXTNAJKkZBZ48CJLCZGVOjdFEPOzJErgKzKY44FFx?=
 =?us-ascii?Q?dWuKJh+Gyl6jWvDb0KOz/AChuzyKiB9EFJKEqFVU1qye7p1qLCwKIkAwB1yW?=
 =?us-ascii?Q?VbiHuR/5S5LlBmGk3IMfijWCXr4EfOEmCTndHQZ4MG2GziU3W1VkSVrucs+q?=
 =?us-ascii?Q?eferGjDPsTOQddq9qmu/088x86R3VukgBqi2xLjxYV+YePgsd7tOPUo1F0J+?=
 =?us-ascii?Q?gGQ0rmdeBS275HL608nknTo3zMJCn1KSBnSFgWfyZRodzm7rDSGVDpKMMdia?=
 =?us-ascii?Q?ZClmzZhfri/tWqVPGhfQW7Xwv2dnJjazrGvghpKLbZVNSZuz4W/aIVG4FNMt?=
 =?us-ascii?Q?wA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	bbOX93HhsGkcrj0ITYvs0aHrZM4quzNjN1n+Ku2X/rV1DOQFMN36Smivlf1qTbW8x7j+Yjr8EBVALq/h/pYQZhGOikxvj7X44iv+YpGsff+757cul6QhRUvh7o7kLZqqadwzZp62Uef7SQ1z4J0Cz9T/XHIeDmQhHEACxbkmD8HRFh/llZXV6In5yaVIHXWVl1Q6Gh2TQzG1U0bw68ZZfVdrSHNFNVspFrNG4HcYCwdGDimuFEL4GRE0yIvwY7iSyZOmMAGT3Sv1ZGevW9y0MBSFB2Zo8Uu/e2A9So9IG+LhrXHdwAbxGrMar+CbjQTpcztK2a9kNIh0V3M19dqEIl7iWZqhKeY2SPDLX6D7iSnoaBZXY2kiSd9n4vWKi5IZ6qIrb4qceBUCDkCFDYCbPq/8P9oWVU4OODXhFgnpcoaxQuBrtkVZZG4e33gBVrse5MekvmD/l0eHUlqWLbo+JEn+R897dvTUxRR9Aaytsrgj+tRb/hI/tlAavE/V0A74ihgYE+USbKTPcgWGEPD4TPQ+lXhNsVWdq2FEg3uSS2QJCaJj1SwN+ufzKu2J5S2rr7Axl6kkI+lrGh65nKXMvMd4cfLWTZNd7S80HV7us+g=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3263eb56-8d38-4977-17fe-08dc68748a75
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2024 17:48:12.9903
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jbk4OEA70MNOSOS88qQRYTcJ48GW6O7N3Cpp52r45cRQgc/3NouqEwVRJLcQX1yce3NaXlpjb7hy8MO5BLn9Ww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB6389
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-29_15,2024-04-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 phishscore=0 bulkscore=0 malwarescore=0 spamscore=0 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404290115
X-Proofpoint-GUID: gy9Gpf2Hf4EckUf0FfDzAk-Kgumks-Yn
X-Proofpoint-ORIG-GUID: gy9Gpf2Hf4EckUf0FfDzAk-Kgumks-Yn

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
jpg: fixup alignslop references in xfs_trace.h and xfs_ialloc.c
Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 fs/xfs/libxfs/xfs_alloc.c  |  4 +-
 fs/xfs/libxfs/xfs_alloc.h  |  2 +-
 fs/xfs/libxfs/xfs_bmap.c   | 96 +++++++++++++++++---------------------
 fs/xfs/libxfs/xfs_ialloc.c | 10 ++--
 fs/xfs/xfs_trace.h         |  8 ++--
 5 files changed, 54 insertions(+), 66 deletions(-)

diff --git a/fs/xfs/libxfs/xfs_alloc.c b/fs/xfs/libxfs/xfs_alloc.c
index e21fd5c1f802..563599e956a6 100644
--- a/fs/xfs/libxfs/xfs_alloc.c
+++ b/fs/xfs/libxfs/xfs_alloc.c
@@ -2393,7 +2393,7 @@ xfs_alloc_space_available(
 	reservation = xfs_ag_resv_needed(pag, args->resv);
 
 	/* do we have enough contiguous free space for the allocation? */
-	alloc_len = args->minlen + (args->alignment - 1) + args->minalignslop;
+	alloc_len = args->minlen + (args->alignment - 1) + args->alignslop;
 	longest = xfs_alloc_longest_free_extent(pag, min_free, reservation);
 	if (longest < alloc_len)
 		return false;
@@ -2422,7 +2422,7 @@ xfs_alloc_space_available(
 	 * allocation as we know that will definitely succeed and match the
 	 * callers alignment constraints.
 	 */
-	alloc_len = args->maxlen + (args->alignment - 1) + args->minalignslop;
+	alloc_len = args->maxlen + (args->alignment - 1) + args->alignslop;
 	if (longest < alloc_len) {
 		args->maxlen = args->minlen;
 		ASSERT(args->maxlen > 0);
diff --git a/fs/xfs/libxfs/xfs_alloc.h b/fs/xfs/libxfs/xfs_alloc.h
index 0b956f8b9d5a..aa2c103d98f0 100644
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
index 656c95a22f2e..d56c82c07505 100644
--- a/fs/xfs/libxfs/xfs_bmap.c
+++ b/fs/xfs/libxfs/xfs_bmap.c
@@ -3295,6 +3295,10 @@ xfs_bmap_select_minlen(
 	xfs_extlen_t		blen)
 {
 
+	/* Adjust best length for extent start alignment. */
+	if (blen > args->alignment)
+		blen -= args->alignment;
+
 	/*
 	 * Since we used XFS_ALLOC_FLAG_TRYLOCK in _longest_free_extent(), it is
 	 * possible that there is enough contiguous free space for this request.
@@ -3310,6 +3314,7 @@ xfs_bmap_select_minlen(
 	if (blen < args->maxlen)
 		return blen;
 	return args->maxlen;
+
 }
 
 static int
@@ -3403,35 +3408,43 @@ xfs_bmap_alloc_account(
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
@@ -3446,7 +3459,6 @@ xfs_bmap_compute_alignments(
 			args->mod = args->prod - args->mod;
 	}
 
-	return stripe_align;
 }
 
 static void
@@ -3518,7 +3530,7 @@ xfs_bmap_exact_minlen_extent_alloc(
 	args.total = ap->total;
 
 	args.alignment = 1;
-	args.minalignslop = 0;
+	args.alignslop = 0;
 
 	args.minleft = ap->minleft;
 	args.wasdel = ap->wasdel;
@@ -3558,7 +3570,6 @@ xfs_bmap_btalloc_at_eof(
 	struct xfs_bmalloca	*ap,
 	struct xfs_alloc_arg	*args,
 	xfs_extlen_t		blen,
-	int			stripe_align,
 	bool			ag_only)
 {
 	struct xfs_mount	*mp = args->mp;
@@ -3572,23 +3583,15 @@ xfs_bmap_btalloc_at_eof(
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
+		 * we account for the potential alignemnt space required by the
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
@@ -3606,19 +3609,8 @@ xfs_bmap_btalloc_at_eof(
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
@@ -3636,9 +3628,8 @@ xfs_bmap_btalloc_at_eof(
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
@@ -3646,7 +3637,9 @@ xfs_bmap_btalloc_at_eof(
 
 /*
  * We have failed multiple allocation attempts so now are in a low space
- * allocation situation. Try a locality first full filesystem minimum length
+ * allocation situation. We give up on any attempt at aligned allocation here.
+ *
+ * Try a locality first full filesystem minimum length
  * allocation whilst still maintaining necessary total block reservation
  * requirements.
  *
@@ -3663,6 +3656,7 @@ xfs_bmap_btalloc_low_space(
 {
 	int			error;
 
+	args->alignment = 1;
 	if (args->minlen > ap->minlen) {
 		args->minlen = ap->minlen;
 		error = xfs_alloc_vextent_start_ag(args, ap->blkno);
@@ -3682,13 +3676,11 @@ xfs_bmap_btalloc_low_space(
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
@@ -3707,8 +3699,7 @@ xfs_bmap_btalloc_filestreams(
 
 	args->minlen = xfs_bmap_select_minlen(ap, args, blen);
 	if (ap->aeof)
-		error = xfs_bmap_btalloc_at_eof(ap, args, blen, stripe_align,
-				true);
+		error = xfs_bmap_btalloc_at_eof(ap, args, blen, true);
 
 	if (!error && args->fsbno == NULLFSBLOCK)
 		error = xfs_alloc_vextent_near_bno(args, ap->blkno);
@@ -3732,8 +3723,7 @@ xfs_bmap_btalloc_filestreams(
 static int
 xfs_bmap_btalloc_best_length(
 	struct xfs_bmalloca	*ap,
-	struct xfs_alloc_arg	*args,
-	int			stripe_align)
+	struct xfs_alloc_arg	*args)
 {
 	xfs_extlen_t		blen = 0;
 	int			error;
@@ -3757,8 +3747,7 @@ xfs_bmap_btalloc_best_length(
 	 * trying.
 	 */
 	if (ap->aeof && !(ap->tp->t_flags & XFS_TRANS_LOWMODE)) {
-		error = xfs_bmap_btalloc_at_eof(ap, args, blen, stripe_align,
-				false);
+		error = xfs_bmap_btalloc_at_eof(ap, args, blen, false);
 		if (error || args->fsbno != NULLFSBLOCK)
 			return error;
 	}
@@ -3785,27 +3774,26 @@ xfs_bmap_btalloc(
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
index e5ac3e5430c4..164b6dcdbb44 100644
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
index aea97fc074f8..14679d64558a 100644
--- a/fs/xfs/xfs_trace.h
+++ b/fs/xfs/xfs_trace.h
@@ -1800,7 +1800,7 @@ DECLARE_EVENT_CLASS(xfs_alloc_class,
 		__field(xfs_extlen_t, minleft)
 		__field(xfs_extlen_t, total)
 		__field(xfs_extlen_t, alignment)
-		__field(xfs_extlen_t, minalignslop)
+		__field(xfs_extlen_t, alignslop)
 		__field(xfs_extlen_t, len)
 		__field(char, wasdel)
 		__field(char, wasfromfl)
@@ -1819,7 +1819,7 @@ DECLARE_EVENT_CLASS(xfs_alloc_class,
 		__entry->minleft = args->minleft;
 		__entry->total = args->total;
 		__entry->alignment = args->alignment;
-		__entry->minalignslop = args->minalignslop;
+		__entry->alignslop = args->alignslop;
 		__entry->len = args->len;
 		__entry->wasdel = args->wasdel;
 		__entry->wasfromfl = args->wasfromfl;
@@ -1828,7 +1828,7 @@ DECLARE_EVENT_CLASS(xfs_alloc_class,
 		__entry->highest_agno = args->tp->t_highest_agno;
 	),
 	TP_printk("dev %d:%d agno 0x%x agbno 0x%x minlen %u maxlen %u mod %u "
-		  "prod %u minleft %u total %u alignment %u minalignslop %u "
+		  "prod %u minleft %u total %u alignment %u alignslop %u "
 		  "len %u wasdel %d wasfromfl %d resv %d "
 		  "datatype 0x%x highest_agno 0x%x",
 		  MAJOR(__entry->dev), MINOR(__entry->dev),
@@ -1841,7 +1841,7 @@ DECLARE_EVENT_CLASS(xfs_alloc_class,
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



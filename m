Return-Path: <linux-fsdevel+bounces-46937-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C3970A969DE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Apr 2025 14:33:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 334FE189EEB5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Apr 2025 12:33:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 551E028A401;
	Tue, 22 Apr 2025 12:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="JsAuQfBb";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="efsSq96+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2468327F4CD;
	Tue, 22 Apr 2025 12:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745324961; cv=fail; b=uOrpzslVewco3B4niPqGJ7ZAGV8iOVf9q+gMafQaNOO32+wXRLsc42BLWspK9ipGHb1pkN12xyL2d6x2De8/BTNjIHQWm74rFBlopQyoZcbYWD2TFD4FBPYLwrd0y0XxzWTQnYJuHy60uaDYVt9mbPSlS/2qqu6ce6qzwsYcQXo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745324961; c=relaxed/simple;
	bh=IViA9c3MF/M32XRGi1r/feC7Bdm3DYEaDn3kzlaHZeY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qDYaj+r3xtL/QIRTrROsYC0mY3GtnOdpX5d+KojI6EWCa0IMAmHMXBI2eOA/1KFjijJEFPWOCBHSaA9Oa+lN2XFCoDHyc2xdFWOV2V9epZQUXkEJI9H9fUx+TTUaaLWhUzl1WJFYmGmLTpVZcJGKM8YeXvuiLKatG6X9+CaYbRw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=JsAuQfBb; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=efsSq96+; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53MB3Gq8008344;
	Tue, 22 Apr 2025 12:28:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=Wja3wyb7ZmwGDtYxv+ByaX28CaCPRg6Qo+pFNR5u/WY=; b=
	JsAuQfBbksYK/pgeD8tby5KLZVwYfywko+WgwdnyqOHm+4l1MN3pfLprkc/Tn0vS
	isZN07WKN/4pj4g8U+ai/koGsoxmvV/Gz5qQS8/8pG1oLNdoAEjPvMWUt8xmku6+
	dxV/+TOBpXa+u8nffdGugSrRUfJh+hEyUD/7VwVbqnYx+Ed70dVqBGaqEUcTnBYn
	s3VTpOzqwQ2gG4fed7nOYlMMFKC3y5btC4AbGgpbaZDrEAn3XjgAbueyhfZPJv2O
	jm4leJIYEkSpKe8NvqlPSi6E2aNzTq7gXw1jTtv3atLo5yDlC0YKTecLAgK+pvIQ
	owSQSUxgngu74JBhMQzzuQ==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4642e0cde8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 22 Apr 2025 12:28:37 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 53MBOta2033464;
	Tue, 22 Apr 2025 12:28:36 GMT
Received: from ch4pr04cu002.outbound.protection.outlook.com (mail-northcentralusazlp17013063.outbound.protection.outlook.com [40.93.20.63])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4642999rtr-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 22 Apr 2025 12:28:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cIaDc2depxN8dyAYIsJmILy4yYniOwARXR1wT/yZMxUVqcSyoCspnKrMyzxioaBzbmVmxEoRHpL15mwxDdVC+aqC+TB14MsBNnNZLp9IxZB35WOIagqBjm1R/+7OCyJTM1Ou8E3k3ToPc9maYDOvE4n03ZaLLYjZrGspbTmV/xR8euIKyQ+4ZTj+m9SqaAlfYr6zhyaSnA2IvKNCMkiZPFPcJUwb5GquBMejsXcBodXAVqNVGMl8hyFEZxMDC7JKEMSvxU+vbB7cCZR00K/MO9B7l10MI4eyk0fAEyOC5GsChsB29xU9mpkFqjnoKhSUq5BAsWnrVC2rK0d9ZIedrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wja3wyb7ZmwGDtYxv+ByaX28CaCPRg6Qo+pFNR5u/WY=;
 b=rn3bhr/a7TU/8VCONIYWoUzAFTKA01uzMZIuIl6nr/Shc3Ls2Yp6rS0LkuCCW5cEPQlA6GpaVPsucsVZ4dVoQaNnxWQMKQVvJY04tmRWXw5x7D6aVAdHfu97Ms/MdyrVScl6hQO3uDhYuC2pQREyupG8ELl/ZsvFwouWR3uknW89br+D9dzI0xOGG452VHrDgY5EtE6LJH9Q2kzlb62HJsY/wf3vnKZT+GauPkHES8v13VAxzc3lsIUbgq1Z93oKwBg4aaRfTjk2Du1+4p4ykLzZGnq1QL9cTFr7pNv+t02tkGSCyikfi9Y9oYJONPxuNUBKFJSqOJ2NcY5OMaP1NQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wja3wyb7ZmwGDtYxv+ByaX28CaCPRg6Qo+pFNR5u/WY=;
 b=efsSq96+rarNWbe00v3AE5zkCcVN6nUBXLNjzSRLSolDj7omvJVUeX2YxmoKufI7Ix4vpqj+xKV9DH2ziCUOQUlufwY9/TjaNduKAd1hvWYWnnr6LZXeSGQ4UkBq6y+O0PlBf21ezNDkO0suKx/xKT60n5/eig5m0Sp9T7oc+kg=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by DS7PR10MB4895.namprd10.prod.outlook.com (2603:10b6:5:3a7::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.31; Tue, 22 Apr
 2025 12:28:33 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%4]) with mapi id 15.20.8655.033; Tue, 22 Apr 2025
 12:28:33 +0000
From: John Garry <john.g.garry@oracle.com>
To: brauner@kernel.org, djwong@kernel.org, hch@lst.de, viro@zeniv.linux.org.uk,
        jack@suse.cz, cem@kernel.org
Cc: linux-fsdevel@vger.kernel.org, dchinner@redhat.com,
        linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        ojaswin@linux.ibm.com, ritesh.list@gmail.com,
        martin.petersen@oracle.com, linux-ext4@vger.kernel.org,
        linux-block@vger.kernel.org, catherine.hoang@oracle.com,
        linux-api@vger.kernel.org, John Garry <john.g.garry@oracle.com>
Subject: [PATCH v8 08/15] xfs: refine atomic write size check in xfs_file_write_iter()
Date: Tue, 22 Apr 2025 12:27:32 +0000
Message-Id: <20250422122739.2230121-9-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20250422122739.2230121-1-john.g.garry@oracle.com>
References: <20250422122739.2230121-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN9PR03CA0094.namprd03.prod.outlook.com
 (2603:10b6:408:fd::9) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|DS7PR10MB4895:EE_
X-MS-Office365-Filtering-Correlation-Id: b0d62ebc-8f11-40f7-5e5a-08dd8199326d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?n0G4H0YbFqVdd/IFRC3a/4yJsChIBU5WJXiQYZ2MfryvmNrXRNbyat5xrZ2D?=
 =?us-ascii?Q?E2iFFkf6gZ0qKi3dxpsIOQ2Mj+2HHp8MslV8mcEs0zNEIMJlA802R5slY6Ou?=
 =?us-ascii?Q?HndseekKq+/8U6L0yIExy1M9sKHVp9yvO18KguqugkGwdLeiKhmcPGbEpw0F?=
 =?us-ascii?Q?wIoDJD+/WGB7qebjt58cxrcLsIa1LwM/1xoknLbAk/V54Ljk0ewJu3IRG/7o?=
 =?us-ascii?Q?nVR9lcPjfdKcehvOxfa1lTbulqUefEQE1lf1qGPkOwWwlHlQAHOWlVc21E3t?=
 =?us-ascii?Q?kZKh0UVoYA5LZrT6NyHW8XJHbhl7ITlfz/+GYSYo9cJWIO2wjBoNILMITyFD?=
 =?us-ascii?Q?9mgrPEtmPUKgk1RX5nTbaio3HWSfJKinDb57t0wcHCTdATn7gTBid/QPWl7q?=
 =?us-ascii?Q?kyN/FalRe48rsbXeTuaFvrHSY87fq26ghSWQ+CK/Uxs6yT2l2NYoGzH6UU+v?=
 =?us-ascii?Q?nFnGGyZPr+UlNWhVbVUvwKZZyjQxH/gq2EPrKrgxa9JQ/H0xyThT5w6sm/Xd?=
 =?us-ascii?Q?VGmxT1RVnxTtAFL6DWPz9eQPjnE/kxaqwUqxywbzzE8jtPXBw3GUPUHIrg5v?=
 =?us-ascii?Q?N3o6E4K77Xxkse2DpfHDqe+vct5xJCTupdExJ5rB7iokcKzeyoeKFXQkGwhw?=
 =?us-ascii?Q?xJ7NrWPoJ+8lPKC6LNsAr44qcHOATBmXoJgkEDT/FflCp5k+yAN24zbNRk2M?=
 =?us-ascii?Q?rVRAQheTONorR4mwkLa9XKVcvI4sVdYDxjDG65KWlxU/wVveCWWoX9VTEz7d?=
 =?us-ascii?Q?QtiYXJTNkFlDhY3Cj1KgPwiSg/hjr/bVOXyyFSJCRS4Ohv24XupRwWM01RXy?=
 =?us-ascii?Q?tHoj4Hm+lEITFSqwuluRhA5uudMsfVXybNr7epbXpO5uLdiej4Dp0mYUqSOz?=
 =?us-ascii?Q?i2GTYWbn05e3o8lYwsP/vSVh3LS+sPUXhwV0hd0qb6UPtw4wGrDJLhhXbsVO?=
 =?us-ascii?Q?19X1gmFP3Q2wbQFXFdErxqVDJIbr152ukfgbJZUNahrPak9O84hbUJGYgL9a?=
 =?us-ascii?Q?Kw/ccDmaM+1Mc2xQtf7pUgO8GzuARx0pxRaWv7aoFc+jIOQk8XdeCRl46Lkd?=
 =?us-ascii?Q?OSC0FdcSHjNJA5oNSC9Yv2ebiyOpON7H4yKWoG7Km5gdpH0eZvKqb/DU63qG?=
 =?us-ascii?Q?WOYyR6ThoqQgDzXhdz0EN+H9OmtxFyJ842eZtDW361cPOFXA8QMefnenADoj?=
 =?us-ascii?Q?tqpUGJN1/8yCOZuk38DQjn0RbbpwOeXgTtZ+s+1fuaAYLNxPtBJHXQborpke?=
 =?us-ascii?Q?1zv3PTtiqUlennzem2W+/0HCkHpC2h3yojsMUoPZMGCVFYXJ031TKKR26GmC?=
 =?us-ascii?Q?xlWBk/gJWJ+Ra/n3aXXR+QtvQ3AWIS5DOfL5IHDgDH5u5mJ7s+uInDVzpgMA?=
 =?us-ascii?Q?VNWC4SwVSGh8Xoxtc17IKgdJca72kLqAeHLbM9c/2FsdIZAy+/krxtEwkZ3F?=
 =?us-ascii?Q?N99BMK3R7ZE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?J+pCFaFI9BSDPKA1jf5r8xwLWH/YoIIJmOhOGt8SQ2uncnI77HXkn6iWvdKJ?=
 =?us-ascii?Q?3ermufZNBMIabQ+/7ttDGIQDmPTJFffDqMODdbMnZYB91u6EiiWJr3bsE6IL?=
 =?us-ascii?Q?3rJgIORCKUV33cn91Ji/D2abUb0baRntnJQbpnGvGPM3m4r0+hYPB9DhQ94x?=
 =?us-ascii?Q?ncKFEf1XHQJajfGTSiWG4O36FCYyQVSB7zsA5RKT4lzjWutfJsVIQfgXNMXM?=
 =?us-ascii?Q?9DfsC50laxtE9ZguziOmbKPF6IG5mRD7j5lsQkQDDRXI57AXd/mCMmsBJ7yl?=
 =?us-ascii?Q?1J5KlQFvX10FsAgmf+dwmIIpiZBN0Vli055zEXh9Jv9FrJqIyZ32u72b1jAT?=
 =?us-ascii?Q?Q1UJ8hoKjp9oSObGo73YxHm+0lg2GppOyDDTLPSKPhg9x1QpOU/o6orMYnld?=
 =?us-ascii?Q?c8Wp9D20IL8o8lKfqyJzzN1nI+PUoqqI4EEsPjTD9prb4Qm8VUKKBXtnND5G?=
 =?us-ascii?Q?rbGRCxF/4Y1WQodCJt4h8Vw/jWvPATfL/lQTKYgn6jqh5qA9QevsqSbzB+CN?=
 =?us-ascii?Q?wBFTtUuYV+gAnpfkZW3obvt5HBeV5gxcf/Klp2F6qbTag+USkNvUiw16uJKw?=
 =?us-ascii?Q?hNhPI15o1epp5kq7VCxBgGazoNofZ/ydQE8unmIYFRxFRlaPZAlSMoTwhiCp?=
 =?us-ascii?Q?+qgFN4jL1BQQyE6+VYdt6nb+fiuX1gUZNJOTpAgcGCLMUeHx3EGkJJaWNvU9?=
 =?us-ascii?Q?pH7cndakr9mj6eVgRVmAwpCvFrHhQV8OgA9+JaIKVw7etS2bNoOdsrvSuz+V?=
 =?us-ascii?Q?W4MpQJBLlfQdsmyRYhO/2yqKASAPCBYvpqCW1dw7HExNrpGlsxS3POerPhFD?=
 =?us-ascii?Q?nEO1N1wky6wCKpCqP2BXkU9kZj06ZsvLyEJzgteh/Zyr6r1hygNbvKSCeNJU?=
 =?us-ascii?Q?4RecRcXAJhkgmj3POlNqElX1TacB+/qR62nm/4jrEUpcJG54fJKDGtK+VheX?=
 =?us-ascii?Q?mSJIBIGmY91E7BMYXgcCzKyxLm/cd7UCu62mkgHopCA1cYBuKg2GwH/6xwb4?=
 =?us-ascii?Q?up8BkhH5mTM2X5ZzfWOiTrJgl+LK/W4fn4m/Bp3pZ64oGKc4l/UjpoMMXH14?=
 =?us-ascii?Q?UxV6DD8Oy/BXl4JG+EvoKlGwqWwNTx5l82W3OGQRAb8ZF3gsfn3ZegKCzMpQ?=
 =?us-ascii?Q?WJbTow5Ww/7TbfAMRJEkdaTYaqXThum6sCew6Jt3cRBwEZVW5sFGr6ukTy2D?=
 =?us-ascii?Q?Tf/fZaCIW+AwWFTDHp2CFZluUfypZovxSUyKfEYOPXIeK+/3/UY7glWUtiMt?=
 =?us-ascii?Q?quLezztGu0sGjuzQ4Ft1Bx7T+0YrNX2+41por47aMuEBjG6JvzQMQE37Jwo3?=
 =?us-ascii?Q?XL7XwgFgVJGdBh7Yb/CcAKg+iecJs2TNr+kC1Tj5Caq3AwMMcDa3j2jztdLf?=
 =?us-ascii?Q?E3McO1avHwr/CF3gqADfHJDNonS0nTnRKgupi8dPNuu30JdVDzfnAW3CIEI9?=
 =?us-ascii?Q?rOZbQnuVNOASdTjV14c5j2bsU5Xnog4U8064mthG5Ih573jKPdN3DgmkD14A?=
 =?us-ascii?Q?yAQFw3LWJJXW7+h5Qx+fZ3dVu+dxq8GAaDHrUGUpLD2grXs4mXpKjDYjwhV3?=
 =?us-ascii?Q?fZk1qAbPLcekTsJgCzSYCCi3LjOTI00MIB4fnvlQbqvk9qh/fC35llQ81jAH?=
 =?us-ascii?Q?nA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	eGxg4Nk4dvoLO/xVVFCU4THlDHNeVHnCJEfMRcaHwCB7hqIOAaAY7FBS9z8yaViMmOLEaidTL3ShCdjeInUfK0HJkzlqF6/pek9y6j3jbDhM3CjQojj0nzZTRw1mXrHMhA8MYXskUg3nzXyLFZ+oVfhVUgYSYHYrQNJjSx3r0PyiOmmowp2nWhdh4hP8kxcYGyGIcZUR0VB9XPAJhy71OyhAqSr++2ZVEB51z517y/OVMzowSyE+dzFS9gBwgfIGkk1s7oEeFf0kowvB5ruoS7JWJXm0cK9jwKG5noH/UtJdTgng3cTP3AH7++/JnYQie1X6dA4Esd+lohUTPre0iAdV/DHFHYjLrwKuRkGv6ZeqULRr3KdItI4Js4HxzbebFQVZ9HhmO+OzG4jd6RQNSXtKG/11+UFKohtxQ5nEQ9aMwusxxHycPwhcqM402pSIJtl40lIGKfGMtYfufGGKZxRsXgPiyPGNBERczvR/78kBgwfgJ7nqtN7Qc3vnv30xpXxZbwvLxvtWx+173QQrbXVWq/AtqNL1IsJx5jLQ2YyN0yBl0bN4LFPgG2k9o2TiB5Wb76xpe3aJPXMdThzxpwHzhBJULHGiAwH+QzvzhQs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0d62ebc-8f11-40f7-5e5a-08dd8199326d
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2025 12:28:33.3692
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KhMqJIFoKh2eyfHLZ1waCJhRaocssTFrc8f0GQpbUiuaVI98a/34zdtsEXGJ+U8oqS/DWFzVavM5w4MM2ZZ2jg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB4895
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-22_06,2025-04-21_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0
 phishscore=0 spamscore=0 suspectscore=0 malwarescore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502280000 definitions=main-2504220094
X-Proofpoint-GUID: XCuXm0BbY5xhhgg-LBkBkSdYk3O_DLLo
X-Proofpoint-ORIG-GUID: XCuXm0BbY5xhhgg-LBkBkSdYk3O_DLLo

Currently the size of atomic write allowed is fixed at the blocksize.

To start to lift this restriction, partly refactor
xfs_report_atomic_write() to into helpers -
xfs_get_atomic_write_{min, max}() - and use those helpers to find the
per-inode atomic write limits and check according to that.

Also add xfs_get_atomic_write_max_opt() to return the optimal limit, and
just return 0 since large atomics aren't supported yet.

Reviewed-by: Darrick J. Wong <djwong@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: John Garry <john.g.garry@oracle.com>
Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fs/xfs/xfs_file.c | 12 +++++-------
 fs/xfs/xfs_iops.c | 36 +++++++++++++++++++++++++++++++-----
 fs/xfs/xfs_iops.h |  3 +++
 3 files changed, 39 insertions(+), 12 deletions(-)

diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
index 653e42ccc0c3..1302783a7157 100644
--- a/fs/xfs/xfs_file.c
+++ b/fs/xfs/xfs_file.c
@@ -1032,14 +1032,12 @@ xfs_file_write_iter(
 		return xfs_file_dax_write(iocb, from);
 
 	if (iocb->ki_flags & IOCB_ATOMIC) {
-		/*
-		 * Currently only atomic writing of a single FS block is
-		 * supported. It would be possible to atomic write smaller than
-		 * a FS block, but there is no requirement to support this.
-		 * Note that iomap also does not support this yet.
-		 */
-		if (ocount != ip->i_mount->m_sb.sb_blocksize)
+		if (ocount < xfs_get_atomic_write_min(ip))
 			return -EINVAL;
+
+		if (ocount > xfs_get_atomic_write_max(ip))
+			return -EINVAL;
+
 		ret = generic_atomic_write_valid(iocb, from);
 		if (ret)
 			return ret;
diff --git a/fs/xfs/xfs_iops.c b/fs/xfs/xfs_iops.c
index d324044a2225..3b5aa39dbfe9 100644
--- a/fs/xfs/xfs_iops.c
+++ b/fs/xfs/xfs_iops.c
@@ -601,16 +601,42 @@ xfs_report_dioalign(
 		stat->dio_offset_align = stat->dio_read_offset_align;
 }
 
+unsigned int
+xfs_get_atomic_write_min(
+	struct xfs_inode	*ip)
+{
+	if (!xfs_inode_can_hw_atomicwrite(ip))
+		return 0;
+
+	return ip->i_mount->m_sb.sb_blocksize;
+}
+
+unsigned int
+xfs_get_atomic_write_max(
+	struct xfs_inode	*ip)
+{
+	if (!xfs_inode_can_hw_atomicwrite(ip))
+		return 0;
+
+	return ip->i_mount->m_sb.sb_blocksize;
+}
+
+unsigned int
+xfs_get_atomic_write_max_opt(
+	struct xfs_inode	*ip)
+{
+	return 0;
+}
+
 static void
 xfs_report_atomic_write(
 	struct xfs_inode	*ip,
 	struct kstat		*stat)
 {
-	unsigned int		unit_min = 0, unit_max = 0;
-
-	if (xfs_inode_can_hw_atomicwrite(ip))
-		unit_min = unit_max = ip->i_mount->m_sb.sb_blocksize;
-	generic_fill_statx_atomic_writes(stat, unit_min, unit_max, 0);
+	generic_fill_statx_atomic_writes(stat,
+			xfs_get_atomic_write_min(ip),
+			xfs_get_atomic_write_max(ip),
+			xfs_get_atomic_write_max_opt(ip));
 }
 
 STATIC int
diff --git a/fs/xfs/xfs_iops.h b/fs/xfs/xfs_iops.h
index 3c1a2605ffd2..0896f6b8b3b8 100644
--- a/fs/xfs/xfs_iops.h
+++ b/fs/xfs/xfs_iops.h
@@ -19,5 +19,8 @@ int xfs_inode_init_security(struct inode *inode, struct inode *dir,
 extern void xfs_setup_inode(struct xfs_inode *ip);
 extern void xfs_setup_iops(struct xfs_inode *ip);
 extern void xfs_diflags_to_iflags(struct xfs_inode *ip, bool init);
+unsigned int xfs_get_atomic_write_min(struct xfs_inode *ip);
+unsigned int xfs_get_atomic_write_max(struct xfs_inode *ip);
+unsigned int xfs_get_atomic_write_max_opt(struct xfs_inode *ip);
 
 #endif /* __XFS_IOPS_H__ */
-- 
2.31.1



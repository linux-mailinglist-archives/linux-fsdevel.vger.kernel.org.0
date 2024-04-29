Return-Path: <linux-fsdevel+bounces-18156-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DF23F8B60BD
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Apr 2024 19:55:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 663B91F25455
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Apr 2024 17:55:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CCD2129A74;
	Mon, 29 Apr 2024 17:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="N8L92++3";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="H9fmtQvz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FD181292F8;
	Mon, 29 Apr 2024 17:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714413087; cv=fail; b=mN/4du0xP5mVwNMLWY66SnxuiUHM14MRCXhdIegb1dLrHKM4WF/8nxuSQ5KunZsn8ypa4xVYxiwjj2wXFutZL02MUAFU0CpRK8Psa9r4EMcmOQNlfjEA7bi1fb18ylGrVy3GdwpX0mo8SwAXMZHCnVd5xqhpu4vvrO+wtlCH50M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714413087; c=relaxed/simple;
	bh=Ns1eGcdSDRI1xfTlYLj8DGPEDQHU8NWelw1WlDH81ck=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=EA3AdeubcTY6t//9k9UHMj7oarJ8BNp6mGgiFYXk0jHvJLvQCN98B2ixDD7U/bJqVsEzSUT7p6oeUyYhxs5PY6f5075u8FAYeRCwYxF/pCcafX8+ZaYdkgThX7TK1+dZRWOJIiMOIQzTiq/ze2C4Kk1bLPJXdFanMP5M/Hw6WTQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=N8L92++3; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=H9fmtQvz; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43TGwkoD004990;
	Mon, 29 Apr 2024 17:49:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-11-20; bh=C218C2V92sC/N3cwZ20ex6c/BuPCg1fOvQVItyDbdwg=;
 b=N8L92++3Jw8crHtrOuBDPnJFT/eoxNqmWZYUAHPD2OXt5Elc1CvAU3PGqUgGpOU5EGN3
 jcf1SA0Z7pkWYsiI6bqqEq0DEvYJ/WYHLaoR6Dv2udfcYSnRoyXbw8eZaInfQlbZcCVy
 is9aM9IHpvMD+XRbONpDhDQ4oFElEaA267TNz0GW6h+L46uzVx/rjI7SHlUsLHRIyTXJ
 U17Ms08TJPT/in/m8f08T9nGkXRTfY7/lYsE0Na0AtoUxWb5d68twcxJYMpd8zsxJKeD
 pwmlIRPjbN5lIH9wZUFDKJBnoybZWC2bFNlQLVbfdsMNpXbYWBQMKuOLSBOi5N8C0bcZ Dg== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xrsdek6d0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 29 Apr 2024 17:49:06 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 43TGRTcv016720;
	Mon, 29 Apr 2024 17:49:05 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3xrqtcpxpb-4
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 29 Apr 2024 17:49:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bf7nkTaH0VN8Z+7JABJHV49QKsABzLIDVgbTOTJUYeiDfy3Hn5aZAsgpxNCNR6mE9+LTgi8F8mQJgjSDA/P0r0twaKmM2+Qli+hXYfVaKPd/WuB+D+iWTu0nCYm23MHd3tWJLg/FWY8osUgWTt7E/a6Hs2ol2iKZCnsOkY6f+nHZ3Yt3qkj5Rh63BZdx/99KtmFSmnjQH5vdCvwyN2iD1sMce4SrvYuRry9KroSqJnbtM4LqtUNid/WE+wbfRZlqk+De9sZXwN16oJq0vdyOrI5i0P2T6YF8Jqgn/YjLziQGnr54KJRukHl/uUcGMy0cyiBn83CzhsVH6Bd15Rtp0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C218C2V92sC/N3cwZ20ex6c/BuPCg1fOvQVItyDbdwg=;
 b=eDBcJX97LubsNbh2vlkQCdbNT+3bKCFUkArlHHhs77CA1R2nsMXuZskTgU9d8o2McssxidaJVmstzfE1VynU4uzoWUE8MM7Aap91jcgzLOjb3ZyfgzXzLJ+ABEfAfH0vxd4H5ya75u8jgAZz27wV61ycVDxebMlhCrQlsIDkJ+3t3nHI642HB9L2cB0Jjc9GGxCI6gF+wTi6IVF/k5Q9ra8/XkDtnp5GN/mDfaPYPIr/GFyuMI2Fl165dD5kevbK47TsJy9Izx/birY7SJPBbuCttsA5r6+MUjDXxUpo7iztj3HFOzfFxsfaAzbVnazeFZFH9EIu80Rzn/j7UlatVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C218C2V92sC/N3cwZ20ex6c/BuPCg1fOvQVItyDbdwg=;
 b=H9fmtQvzgc+dmMfxDc4RjOOpBUDncuGJOhkBvWhnnR9Ggga7HkzqvEzH45EZM6U7OZTuaOhefNrUdwjf0ON+OvrgmSREbOSm5LfdGXI/ZQ8MmOsHUZyv2tFjPjMwneH2MFGJe1aluI3FqWx6u+4/7CbBks18AcmeBPpQsMbGB2g=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by SA1PR10MB6389.namprd10.prod.outlook.com (2603:10b6:806:255::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.34; Mon, 29 Apr
 2024 17:48:36 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%4]) with mapi id 15.20.7519.031; Mon, 29 Apr 2024
 17:48:36 +0000
From: John Garry <john.g.garry@oracle.com>
To: david@fromorbit.com, djwong@kernel.org, hch@lst.de,
        viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz,
        chandan.babu@oracle.com, willy@infradead.org
Cc: axboe@kernel.dk, martin.petersen@oracle.com, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, tytso@mit.edu, jbongio@google.com,
        ojaswin@linux.ibm.com, ritesh.list@gmail.com, mcgrof@kernel.org,
        p.raghav@samsung.com, linux-xfs@vger.kernel.org,
        catherine.hoang@oracle.com, John Garry <john.g.garry@oracle.com>
Subject: [PATCH v3 14/21] iomap: Sub-extent zeroing
Date: Mon, 29 Apr 2024 17:47:39 +0000
Message-Id: <20240429174746.2132161-15-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20240429174746.2132161-1-john.g.garry@oracle.com>
References: <20240429174746.2132161-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR02CA0003.namprd02.prod.outlook.com
 (2603:10b6:a02:ee::16) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|SA1PR10MB6389:EE_
X-MS-Office365-Filtering-Correlation-Id: b62fa46c-ae53-40b2-c314-08dc6874987f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|7416005|1800799015|376005|366007;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?p1NjG31GBtMy3iNBmv+I5vUrG/45gurRCv/D5M1u5b9/H7QQ5ipxnj9Tl0Q2?=
 =?us-ascii?Q?1Fz55TAdAGcx1TnUI471zNRG7HPKxthhQJc8jQMA037RD9PcK3CxkxzKeinE?=
 =?us-ascii?Q?Nr95jdTWWXASAG77uwgDReDwbJMyAy42NCCPMsKjbppauvZMpPxPrySugsci?=
 =?us-ascii?Q?zpWcvC6z7laQmSQcQmv9C+QJ8xi2p/PGljbOE5fldSb6vl43QZxt5sTZexdc?=
 =?us-ascii?Q?zAE6+ltZ0fcvlz6AOi4MsKYdZTAWTNRCwm8Xe4x5C0iXRzAwi4vQL4hLhyR8?=
 =?us-ascii?Q?82a6YNAIEXP+AF2I6Ol6izjIq7/7ckGY+I/KVXeNGD9WAJrjKDJSvEAg7ZJf?=
 =?us-ascii?Q?j83+qku7tQ3plh3HHyHcqA+/dDDNYU8vzWeCwjYSBz8OddAcBywkDuSbe16E?=
 =?us-ascii?Q?gDOMYvtndKWhxKq0nGTJLcheqzKFixitIGHz0X3dKnMUfX8m043uF0XYX0bp?=
 =?us-ascii?Q?sd/Gsg3X6ZRTZoNgiAf/aJBQuP13nS5OMegzn2+QoLj18fQhJqj5Vfp/WAM1?=
 =?us-ascii?Q?H0tbcHStz5WUrrAd7gIqlmYP7TZLSRk+TQUeBhQmf8kf7y84sbGIpuhbwcae?=
 =?us-ascii?Q?bRyuxIurfptL9OOJ/HJPrXHjqUN93q8MyEv2HXtF7VJidVczG8KkZTN8YrGE?=
 =?us-ascii?Q?gLHzeRBuQuvsTZ021lI4CiEkk9rrTjoP+RgfVnej89MTFyA18ax0fRnb6LDf?=
 =?us-ascii?Q?F0HIHZv4ZAuxhumIHlGZoBd9fVI75kqtpv6hZ4SZm02mh0nO+f+XUrwZPaqe?=
 =?us-ascii?Q?MS7G+6tVyKg7hsVESMx7XF07yHQH40soMd+lXCjuwoLpejzYHn5KjFce1xX0?=
 =?us-ascii?Q?dawbs7tcTpkpS+ldf62ZcDn5RbND5MQnFqwAIjfh/66hz/lRZo1fJKHUFrHF?=
 =?us-ascii?Q?tByumuxPLv9kWwcbDA3i0AFW47tam5inxy+Eu0Jz2BMJm1LAD2c1QNd4/6nX?=
 =?us-ascii?Q?WELKBFOPWu+ZyTt9FYZ41uibr7rcYclgSh2Sov3JPgSKjWzFekx5tfGt0VEf?=
 =?us-ascii?Q?WZEHcKgwHBps3UZkbUOBEaSt0sWtXRuU+tAoNisDzBnLCwq59QuAFDXZAUQn?=
 =?us-ascii?Q?+m1z7YcuBQqdxEkT6J9hFbNrSg9RdnjVPn0pZHu2spfm09UdmulwFflhnFk2?=
 =?us-ascii?Q?xmmvRxU880LqtMfHR+J1k9WanSmljR8hdrIEz0yI7qQc7Dh0CEUwoastrK/A?=
 =?us-ascii?Q?MzbLSoVsY617a3semRQSc3I6EapCfJ7Cuj/jM1cQJ36qQm0bEeYOoDhfs/1i?=
 =?us-ascii?Q?QFCYetvUjqYNGUyrOVe398JrVgCk9S9iVeRUyVA1/Q=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?B3LKISGJcpf0PyhV2IPI0LydQNC++HfUZ8dsu2PX6Fn9nn6sPld6qiYCmCWI?=
 =?us-ascii?Q?3q0WfGZtim021i9PPzG5hJeVetQihz65NO6S3K1dD86KovtlnExpZj1Bq06T?=
 =?us-ascii?Q?F7+fQVapxB9izBcGaORIh2NuEkOpBXGAjGZWAz9f5TQEMldqhN9fzdFNCUz9?=
 =?us-ascii?Q?Qe1Ls/xo4nKKYrEf9vwEt3G/J6DbfronKoZWClRkJzNBb7T/PE/b7uP+eJ84?=
 =?us-ascii?Q?jB7HuqwvvD6lDkFIF68YC9PF55de4fiN4GfpfrZoSkkjVj5yhcnJL/dm6olo?=
 =?us-ascii?Q?S6tvq3IWf4CTIWBxLDoHG0ZzttbGte0F11u+u/o5hltoxHC4arl3acdx+Y/I?=
 =?us-ascii?Q?47dBz6B7HNKAezlscuJjFLpgKhy+R818kKtLRhAZ3Qeid58sQwHj88k5GFC6?=
 =?us-ascii?Q?+MT78G0MWPOCtVn4VArJzby6tIgyEqBNLVDTTlmVAbRV1Gbp8PCge9HsR0QM?=
 =?us-ascii?Q?+o22csEn0iLzn9XffVzzRG7JG4VQc4Fhx89vLq/1/uVjQZQpJf+Zt3BjlqSA?=
 =?us-ascii?Q?i2bjyMNs5boIPSbUnQjtnHkbeaAT2ty6wFtBNEApjYoLe+fKDX1M5NZRdRbj?=
 =?us-ascii?Q?TBqR92BpUb5TODH+HB9Gh5O0kV9VJBilDflC501s6wzXoQs1O7deP/qjYEmf?=
 =?us-ascii?Q?KuFCreZOJbg2zN8h3necOkTEpPhB3dcIaWUpHDEDXkICCgeZ9ldnIBzTOeOu?=
 =?us-ascii?Q?BCzpPs9H586XU74Bvr2r/9+a3GPdd4YtVuIFM/oHMx1BmpGu7no3VB1RR6qg?=
 =?us-ascii?Q?y+F66643iKGen4MJzxdvHl79UfYjraKyVBvJ3pURN4zETpPIg//eqz0tSN2V?=
 =?us-ascii?Q?tAOHmKrGO11xc9Zz2AtsH5vsmOZE7Hn+qmjimLSW4f0k7qKjlmyFvY5MuHoB?=
 =?us-ascii?Q?fX0j3F1WRKJM2RSPVRry/S2z6ONGo5s/Rms0+9de6Vzg0ibGrEwUkgXZxIZ+?=
 =?us-ascii?Q?WuRcZpns8o8I3VTiEOEFmLy524WdHsUtVBI5CDZ89czAp9lsqlUvMp0lzLnK?=
 =?us-ascii?Q?kp3n4RCe3iiqsHTad/inFgp71R/pcUvmSmJqexK/tQqC8wZUyVz9Vp0PG4cx?=
 =?us-ascii?Q?zI6X8pA4QjWTffavdQUiM20/zbM0MrAqbS0qm9DSy/xDZZ3Q1gL6P03BzRAE?=
 =?us-ascii?Q?aD0iXin9zpKcu4L6oue2S6zhGzf/TJObq7Njp4250n7l151SqlOIxv5N4dWO?=
 =?us-ascii?Q?2RF46mLrnFMYc0eF5fa1UUety8sSwD+J9Fu98tFzXlFBv6/PzIkdle7H8c/G?=
 =?us-ascii?Q?Js9RNTIJTY0B5IoDOw09fXGtwEM9r3SZPv/LOP/Zi4mZktkTOFSlCc1hoAuR?=
 =?us-ascii?Q?S27qMCldvOIy8twN3LKfmBsHww4ha+4R4H4N/5oX4xMNvYuZIfGUgYrwq38N?=
 =?us-ascii?Q?24PV4MCg5igG/CDVSi0j0DYeRs6tAB9S476iz+oAQtkw1LzDsE4DkOBkqKQ7?=
 =?us-ascii?Q?O+Bmd67+iXtnS6AXM+/igJ6DFZnDIrCRUYWK81YimPT1pkSgaGTPu2CBAMRt?=
 =?us-ascii?Q?pC6TKiY8Tdiv+CENfgH+39lPrfAkXllPG85J2tKNhMyd/pJOgvsNYQ11bEpB?=
 =?us-ascii?Q?j1ba56/cRWMCIf5mMFzmNjOewc/+yNu6QRLPEaYey94GsyeV0h3bBWOBTfmZ?=
 =?us-ascii?Q?hA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	8Z6yAJueiz/mvuU77lMrij41fDmTnh918gFmY4HnSKkyLlrcv3JQcLQJPe4ww/ZxOdFTyyLg9tQ8ia33zfvwXfekFXdGGpeYDqldfEsbV4yhwOfsCm+zbKZQQHzHt8I4g/0Rj14YJkoxQQJxqqB2ItDoJ/Y9rZpPNyHn1ZTR0LUDkXieQqIeYEpbWaJGESQIBjf9zQ9eh4PMnGr4Fwzj1S3OKH/b8VTgfyqnE7YG7gJDWRbFGluA2hPHpdtRrW0N4AMHialbOZ8zJi/35bf1YrhJj/wwfl/XNfWmzL8NKC5lju8pehBlnJehTseDHmO9ds1EDSLKUqGp6wTY2hNaf1lzdkK9RkZwbK09eR+vPSZs+pGQSfd9QfICCApLMBaGHRji6jq0ON3IvvncUp5qbhwVOotffA55NfA5oblFHJMYq7IA5bx1uG3FeCsA1cwEN1c3IJ/UnqgpE6ofJ2/MYrdgP+hPIVkFDCLixMtXEMMRuff22McrE6+tYCZ3XO2Cqoj2Ybo8GUcyfrd0OZhdRqkywZPZCo348Vm6F/x44xFtahlCdZq9Pc/czQynK/WDms2KJsPpuSM+QrJlNcRMoiiKksCexz5yrUlnd3WnB84=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b62fa46c-ae53-40b2-c314-08dc6874987f
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2024 17:48:36.5129
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pZiwM34RuSlhR9gFQjbDlkzEkCPCfJJdMBI1JDh+jA3nxzuhO17UPY5tlFZas+WaDWUWkJJS5+8SdaIFdpWQUA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB6389
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-29_15,2024-04-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 phishscore=0 spamscore=0 bulkscore=0 suspectscore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404290115
X-Proofpoint-GUID: 1hRdqiq1s2UG9xZaHB6SR0qS_Kh73KIJ
X-Proofpoint-ORIG-GUID: 1hRdqiq1s2UG9xZaHB6SR0qS_Kh73KIJ

For FS_XFLAG_FORCEALIGN support, we want to treat any sub-extent IO like
sub-fsblock DIO, in that we will zero the sub-extent when the mapping is
unwritten.

This will be important for atomic writes support, in that atomically
writing over a partially written extent would mean that we would need to
do the unwritten extent conversion write separately, and the write could
no longer be atomic.

It is the task of the FS to set iomap.extent_size per iter to indicate
sub-extent zeroing required.

Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 fs/iomap/direct-io.c  | 17 +++++++++++------
 include/linux/iomap.h |  1 +
 2 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
index f3b43d223a46..a3ed7cfa95bc 100644
--- a/fs/iomap/direct-io.c
+++ b/fs/iomap/direct-io.c
@@ -277,7 +277,7 @@ static loff_t iomap_dio_bio_iter(const struct iomap_iter *iter,
 {
 	const struct iomap *iomap = &iter->iomap;
 	struct inode *inode = iter->inode;
-	unsigned int fs_block_size = i_blocksize(inode), pad;
+	unsigned int zeroing_size, pad;
 	loff_t length = iomap_length(iter);
 	loff_t pos = iter->pos;
 	blk_opf_t bio_opf;
@@ -288,6 +288,11 @@ static loff_t iomap_dio_bio_iter(const struct iomap_iter *iter,
 	size_t copied = 0;
 	size_t orig_count;
 
+	if (iomap->extent_size)
+		zeroing_size = iomap->extent_size;
+	else
+		zeroing_size = i_blocksize(inode);
+
 	if ((pos | length) & (bdev_logical_block_size(iomap->bdev) - 1) ||
 	    !bdev_iter_is_aligned(iomap->bdev, dio->submit.iter))
 		return -EINVAL;
@@ -354,8 +359,8 @@ static loff_t iomap_dio_bio_iter(const struct iomap_iter *iter,
 		dio->iocb->ki_flags &= ~IOCB_HIPRI;
 
 	if (need_zeroout) {
-		/* zero out from the start of the block to the write offset */
-		pad = pos & (fs_block_size - 1);
+		/* zero out from the start of the region to the write offset */
+		pad = pos & (zeroing_size - 1);
 		if (pad)
 			iomap_dio_zero(iter, dio, pos - pad, pad);
 	}
@@ -428,10 +433,10 @@ static loff_t iomap_dio_bio_iter(const struct iomap_iter *iter,
 zero_tail:
 	if (need_zeroout ||
 	    ((dio->flags & IOMAP_DIO_WRITE) && pos >= i_size_read(inode))) {
-		/* zero out from the end of the write to the end of the block */
-		pad = pos & (fs_block_size - 1);
+		/* zero out from the end of the write to the end of the region */
+		pad = pos & (zeroing_size - 1);
 		if (pad)
-			iomap_dio_zero(iter, dio, pos, fs_block_size - pad);
+			iomap_dio_zero(iter, dio, pos, zeroing_size - pad);
 	}
 out:
 	/* Undo iter limitation to current extent */
diff --git a/include/linux/iomap.h b/include/linux/iomap.h
index 6fc1c858013d..42623b1cdc04 100644
--- a/include/linux/iomap.h
+++ b/include/linux/iomap.h
@@ -97,6 +97,7 @@ struct iomap {
 	u64			length;	/* length of mapping, bytes */
 	u16			type;	/* type of mapping */
 	u16			flags;	/* flags for mapping */
+	unsigned int		extent_size;
 	struct block_device	*bdev;	/* block device for I/O */
 	struct dax_device	*dax_dev; /* dax_dev for dax operations */
 	void			*inline_data;
-- 
2.31.1



Return-Path: <linux-fsdevel+bounces-18154-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 326CD8B60B6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Apr 2024 19:54:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 56C061C21A58
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Apr 2024 17:54:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63ED41292EE;
	Mon, 29 Apr 2024 17:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="NXoSUrzY";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Oytqzklx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61ED3127E1E;
	Mon, 29 Apr 2024 17:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714413046; cv=fail; b=vGVbgzTzNlzxH2uVuU4ew/m6KKvXWu5kn5WghbiCOyh70lSVTw0MDSqbXM6Dtw6fVnd6mh3ZhlAmTuuxCkcSJIxRL8aW2kZ7jb0CpgGLUSFWnWaupKoTRTwrMMfn3KVRe/xucYc6/CyJXlMnzxu6zRuoBqHaYVDlaseopydAq4I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714413046; c=relaxed/simple;
	bh=2+Dvc/iH/zUzuqViOW6sj7OwK/eifVH1xVRGMCKilGU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hCDca6bgSBP3gNwuG0gNw7hRCKu2AdyrimcqMM1zHnovRFzLP+2UcDRxREMQ67K1MmVq1HKTtasJhICM8vbE2hzeLrQtx+EaH3J5xAzv2leoQQpMD6NvB48KaAlaKRe4fzMY+hQvclFVOjaUaoGdIjqpJa+Ivtd2vSo0Cv64rwk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=NXoSUrzY; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Oytqzklx; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43TGwmVM024630;
	Mon, 29 Apr 2024 17:49:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-11-20; bh=Eioi8yuVZzq8jDWbsEiokCsbC+jOLcMAsr3yVp0kG2k=;
 b=NXoSUrzYMMP2NJVVwZXcvgkXhtEWEm/OcdfB4ZltPMxMTOIM13ab035pWoJn9esiKcre
 V7oTP4D+LIntdw1taIZ8/rzaGOppZ1n61HyOUh05RSp7MLOXi3Mb1A4dwKe47kARBpP3
 3tfnB91Yp66XGPe6GRGdvG1xeJhFY/6SpBztTcCY3h3zUuKXVczl2l1r6tVT+VmU1R9s
 e3t/RsWlQ02nf6NubDd6ksOpUWFvWI+9/0k3z2dD2ETKzraWz0t9KFJuNWzZ0PhgQ/Lk
 3HDFImiyyAwajzd/0HzBQguxFUB9gGQy4+gmFg8qyLR5Juau6W8d2eOUEGRpnp7oElEC Qw== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xrr54b7kk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 29 Apr 2024 17:49:05 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 43TGRTcu016720;
	Mon, 29 Apr 2024 17:49:05 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3xrqtcpxpb-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 29 Apr 2024 17:49:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UHccTBhe3Wl/9m8Wp08dV57m5cGL3KmVOOLP5l0snTUum8t2C3whElRyoqLbgQOtcxDyA67TTPqJP+zx4BtITTzLO9gEz/w+4zaiHnX1eN/Sx4p0TEcATBF6nIPv9kQzC5wtLvyd2cHFMlyYVhckSIUt095rJxmN2IvJ1tLzQi9LLzdD2r8/HohxpasDfg9NsH+iL/ZnsOzYgh7omV2GSHU3wZPkiLbsMoEVoTd+hdC2og2w3dbcPth01PZDm/rj5mwkMdubf0zPsD+D6PcGWjDinBx48u6WqhGC7v/7Myybw01X4huObA5yK5ct+Jvw8onXQjfG5zYpVujqOCxduQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Eioi8yuVZzq8jDWbsEiokCsbC+jOLcMAsr3yVp0kG2k=;
 b=Bh+kSRg25eS1Kt/b9d0NqYIDg+WyOL5L8o8qRXVp5mWINJY88eFf036/KXu61qklgOaWpUxIVCqvRYztPSrLps2deUbCARX7JzUYIZqu6jB8hEY33wuq7DtR2BumaJ+LxIwnRAK56Tkga/p5I0rrNxRdTKYlLzvqFmIP+kt8ff9QfHOuarZg9WWnIYyJqNmiAci9NqUMjBWyYRGKvc2tlEDQpU9NxBbAvR/WoyppEUgpU1T0c+diUgmWR+T4S/TR5W2AtPWrNw+S14xCiM9MU+c7EWBPjyzDAmHbt0P0UwIgPYlVcN2v7BlaLv0S9mOruLC1+8amTYQ8dZ/I15yofg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Eioi8yuVZzq8jDWbsEiokCsbC+jOLcMAsr3yVp0kG2k=;
 b=Oytqzklxw1uxgqLLPMYXQu7C0YFzrDts6/uC8wq+/KmoJdFxQykmuGQnHYwugwqEYzdCccv/YKYTwKR/6Vi7M4V1y6lnt7vUI3Kq+NR6z5HqQXpwUpPxyMrKKDBZnCbCSExMiqa5noOeDb8/8gohd5zCLkeeJ0VLOen5MS2pu3M=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by SA1PR10MB6389.namprd10.prod.outlook.com (2603:10b6:806:255::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.34; Mon, 29 Apr
 2024 17:48:33 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%4]) with mapi id 15.20.7519.031; Mon, 29 Apr 2024
 17:48:33 +0000
From: John Garry <john.g.garry@oracle.com>
To: david@fromorbit.com, djwong@kernel.org, hch@lst.de,
        viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz,
        chandan.babu@oracle.com, willy@infradead.org
Cc: axboe@kernel.dk, martin.petersen@oracle.com, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, tytso@mit.edu, jbongio@google.com,
        ojaswin@linux.ibm.com, ritesh.list@gmail.com, mcgrof@kernel.org,
        p.raghav@samsung.com, linux-xfs@vger.kernel.org,
        catherine.hoang@oracle.com, John Garry <john.g.garry@oracle.com>
Subject: [PATCH v3 13/21] xfs: Enable file data forcealign feature
Date: Mon, 29 Apr 2024 17:47:38 +0000
Message-Id: <20240429174746.2132161-14-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20240429174746.2132161-1-john.g.garry@oracle.com>
References: <20240429174746.2132161-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY5PR13CA0022.namprd13.prod.outlook.com
 (2603:10b6:a03:180::35) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|SA1PR10MB6389:EE_
X-MS-Office365-Filtering-Correlation-Id: 524ea22b-a72d-407e-1741-08dc687496dc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|7416005|1800799015|376005|366007;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?6ZzAXW0bdrl2Wg2bIX/CLpEnmQ1TI2t8frAx15GlSR3lsSEh0Jd6iqxNK8v1?=
 =?us-ascii?Q?aFEVe6fAn3amDoGYMEPWjlLpRoHGoQtZm7RThiQRaGuNo/5PEuic1LQyw49M?=
 =?us-ascii?Q?PH3qyLmFLCaDFqLThfl1tuo+zJdZWxDOJPZwk88ia6Mphv5zW3a+xRMVrzyc?=
 =?us-ascii?Q?wOGiJXYX2XeIEF+cg71GZkCF96zRKsAkm14yboXCTeiZH65qXnR4Ptp3nvex?=
 =?us-ascii?Q?pmVyKLTyTDyf+LbIcyPhXt1ormdNTOu6hpRqKCGj/XIFKJlgcjuMbozdqsaO?=
 =?us-ascii?Q?KK+XeT3SOPPDSTjBndT/7u5cZWlvoX6dFgV9L+IeCc6yRmoqKkNhiMpDhHPR?=
 =?us-ascii?Q?ZkjbByfiubv9f5ucbFLxqCwDkdG/wicYRmvYqumW1/iOSFgP6KLO2G/P0YuQ?=
 =?us-ascii?Q?9qgELTUHfI+47BSQBZbgc8CV8e+0KpcWoP+fXUdZQ4yBlK9xYMgkl3QUi5Rq?=
 =?us-ascii?Q?tNMsMiQVRLbYJHfCQhrsV1WjJiVGGeRjcqkSV+9Koi7luCeLN417/JryfHs/?=
 =?us-ascii?Q?orTKD+f67v+bMVo/ynGPg00gfU9DKbGo2X604/Uw59GUEMNp3gPlTftxLZbF?=
 =?us-ascii?Q?kYT+QF3fvSMfCGn7vL+9et3zfhCXfzOAX4zGw8YJQ2cd45QChLs/PV7m2Omv?=
 =?us-ascii?Q?4Nfu5wFBKgBRmYEZJPKXDlBc9a6a6wUs2P6qq5+CuIWtu+hyJD2x47XK2PjV?=
 =?us-ascii?Q?PUVqN/3rPmyOuNxrRZQGyWLkjBGCzg0Z0q8CBEcu2ytWEcYEwqyZkHjyekx1?=
 =?us-ascii?Q?zA5XRfB1oPDxFlvArmpZ68d9y/J4Zk2SytMML6a/msU7DtbK3dziQ5DBNZbf?=
 =?us-ascii?Q?lrCP8DBfmghubkW4MxiGqEy3eWrFW1AgxblUrg8K3DmcH4mhhx3FUdtDVg2Y?=
 =?us-ascii?Q?w3QyHa3UXXCqw1PMpuQId+2C/+wYPVn5jRrmI1tqSR5yrcmbRztSCt+9C5Jk?=
 =?us-ascii?Q?jP1EbBgAV//QaUbLVcibTy0pkZDliywDQZFVTv095qzo9ol6zUiV656YuISz?=
 =?us-ascii?Q?522KndCnSVM10olZ5QcnJbhsw8AMFO15IMa11Rt3FNY2IB0kPXibEaXxv3DX?=
 =?us-ascii?Q?EAfBLEypnmqwwm8xmtt/Vg1RgFRZj6Cr7X0aAR2erz0We/uOsly9Q0Sppv5m?=
 =?us-ascii?Q?qs8xqjdpscCxZ527DRRK+lXTbNTIv23HHMceeI/VMEYdr6bVnKZ+iRcYDMv3?=
 =?us-ascii?Q?oRSen26F/RXymm7ugHh2Qzndsh87tEkZyb08eUx/ImCszO6QJrJz3G8wKuK9?=
 =?us-ascii?Q?GgDN7GwHRq6gPO7FsDxvgbLM6pWVaP2jTkNOEHRNaA=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?R2AzGjnP4vuJnKTFOXfa6RbpSkHoRmByJB35gZJI+w//uSfEJ2XzJfQJYT9D?=
 =?us-ascii?Q?3jwUUap9MKATxkkC32NHScEO2+FxkNgqNPEt4p/aHEldM7NbRridCLuZfbfq?=
 =?us-ascii?Q?f1UlEtckCbpWQto9r2WOPMNF/49Ks0LeeioPabTNBMp/cvOB08ZoRs89JL5B?=
 =?us-ascii?Q?2a4Ez1Khc8CVMC9CUOno4l1hmpD5GRiskZFVuWB1aFyjGu1j7Wyq5WH3m81K?=
 =?us-ascii?Q?lXYIeAknjjT5oRl/yV7gWPCDdG1lKCRJM98ZfTUMxPu+ZaCqu+BHQBX0MJ1K?=
 =?us-ascii?Q?DqNjEGUoh28NwhJDsFQmVQdGpm7waFDeL+YOmR9MdkV2vRkFjVyrZrbcupt2?=
 =?us-ascii?Q?W92g2z6qQvEGIn/9S+u4Ht0Ce66lg5jwOsqaKgNRJaorn4+wF2BZkSqT5xf1?=
 =?us-ascii?Q?Y84IiQdYtWOoUDZgqahMYdRO8I5zc9ALtQ/4YLHUAi4WRdMgLRz/EXNwCCEn?=
 =?us-ascii?Q?22vDrBZWpKKI/tqC7DDCX2F8//SoGqXku6RJTaBhTZt2AKhN8q9OYhMNFfYI?=
 =?us-ascii?Q?jBwm1TxKi/Mog0EdLVpGN/pE+/53i8uFeQvf3u0jh1apZC8+lP38+inmlz8q?=
 =?us-ascii?Q?Za6vv17YqmDnLKobnuZy8Ue9f3RBUpTmpJYC+CMSMUpwyywFRc80bnjVxUZx?=
 =?us-ascii?Q?o6Xw0eIoKUjJMjsw58QVJ7WmLog7EHsHNyZL3PB2eZI1jXDLLG7ZHiVlkRXV?=
 =?us-ascii?Q?lO2g7Mqkvkf9uqdd8IDvcOAWCj1yZQZOqMkXslIxxbMGzR4bTfSBmLVxCFIG?=
 =?us-ascii?Q?JqsXiADz73k775QPK3RuCFnOFQqgLNDBibxj+J31g0kj0N4kYQum10izxHjc?=
 =?us-ascii?Q?ptSdELLt/0GoXEn8EF10Ov2rvHHklVeXHWOQQMDnP1lLxvDU7cLp4nrT6uVF?=
 =?us-ascii?Q?C2P4goFxzNSQzwMLCAJ4pQwOhSnIFP7kh7LI9Rnk8oDvSd7qea8aYB60AbSy?=
 =?us-ascii?Q?XIhL/sOUOfusbP5UXHe1f3NCeERVrrghd/z8jVrbFRSUvO3BxEn1u1EtFytK?=
 =?us-ascii?Q?/PrUb+b19/1DbQjqA6qfZ3EyTlTT3qAaifqlH4jodssi67uVN5gwBDLCqTmR?=
 =?us-ascii?Q?+Qp5fSOnDGmYsOdRyYqMvvcXnNeQjA2hSqW84nRFwxDKx4smB7rMzojYiM38?=
 =?us-ascii?Q?GfcvvuP3UFiqWZePjuo4j+6wAoV4obLJfTHdbV7R0ovoJLTyv5QTgmvAjVrm?=
 =?us-ascii?Q?h0+HhBIdApct4puxRwJMhQBIQlHBbGiITN2IxUEAwsfPfIC3Q5BfzbjTAyG3?=
 =?us-ascii?Q?Hv63+KOdu30iroPYWyOC9bFtfkHQBNH2Y+MJCOKUo8rxLeSYihFtKxq6Fjgj?=
 =?us-ascii?Q?g2w40m+8ObF+udv/Zol7u8D4m+Zc1KE2p5L//S+b1hXUuTF/0cdQvAYbe30E?=
 =?us-ascii?Q?80mo0DNCqZZSwdpZpnZplwRKEJt6KBy2WHysZWNXpanZJ3Npmy8oMtaYI1hT?=
 =?us-ascii?Q?papdaymnLrPl2dMiZRNSEw43jdmHA/r2Xjaa7Ye/1A8MB60MSFxYfb5o5jbq?=
 =?us-ascii?Q?bXpVRV/lzV1b+327sekX0KAuSts+XI7N5zmGxC/65DtqgX/cmxVPLmv2uH/k?=
 =?us-ascii?Q?x0OjBpXv7gQHC9wvUkMJ/oKSCs6BueVqkdQRmg668YOOzrQj+urFicJnn0XA?=
 =?us-ascii?Q?3w=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	XYhGKK8ap6yB1I9h8go/wnLNwoAoC6W3J5T+7lrDn7Rw19BNe4AZ7XlixbjR2OoSwb6kpXIqNlsjyZiDuPxXREYMc0nEGcIqHQhUx1fQqSy2+yvnTQ4yqbU7lryabGewnMEqd0X11dw5hOeax31BqDesI9mMYG5kbab3OiQyEHhJvt0R88BHyXkQA56j69coaTMnW8jOFjA45NmCskNgPAHCVeOzUXInx1n/M1aOsuPRSnIl0dUt2CMZAm42dMN0wy/ikqAcnDHPqIURAJ9SiQD3S18VEIchlMRI3X/ZFXWilWAIVeglAch6yncqs7W3uHb8xE4bEOggiyd0QMECqQDCrt03m5cZySJrHqtPvV/7YW7ySDxgsv0bq7maXrNOEd3dwh+S3DAmP7wfWOJjI0td/iHGiBqPz+JtgRAhT2BqC4ZXKVKxrGcSvb3mdvHstaCCA/6uci5/FzIZnxcezV24/XBTxPyRkBCSj2d2MCOE2qTUm06AiqJ7LsQDMOfjg2/J5HlWmoWx3bYqfpOTzF1et+YeiFoD9Z2S+XBvKyzaiqKLeWziNmpnV4d3eeRJB3pneMFUssYtXZmVgNvyJCg0SfHy4cpAuRGKI4l2XYQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 524ea22b-a72d-407e-1741-08dc687496dc
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2024 17:48:33.7591
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AvhQ/JF0s0I/P4lERFC0olQHI8Mwwk/tdpxwuGRIa2bOxXvVzjm8GYhjqj4NRj8QSiwza3srMCNObZFh96N5bg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB6389
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-29_15,2024-04-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 phishscore=0 spamscore=0 bulkscore=0 suspectscore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404290115
X-Proofpoint-ORIG-GUID: H7y42Yr4XOUNxFnlV50wAfjKWYqZxqtQ
X-Proofpoint-GUID: H7y42Yr4XOUNxFnlV50wAfjKWYqZxqtQ

From: "Darrick J. Wong" <djwong@kernel.org>

Enable this feature.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 fs/xfs/libxfs/xfs_format.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/xfs/libxfs/xfs_format.h b/fs/xfs/libxfs/xfs_format.h
index 4dd295b047f8..0c73b96dbefc 100644
--- a/fs/xfs/libxfs/xfs_format.h
+++ b/fs/xfs/libxfs/xfs_format.h
@@ -358,7 +358,8 @@ xfs_sb_has_compat_feature(
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



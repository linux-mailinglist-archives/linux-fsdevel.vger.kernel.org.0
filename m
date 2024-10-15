Return-Path: <linux-fsdevel+bounces-31943-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7972F99E1FA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Oct 2024 11:02:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 33EEC283FA2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Oct 2024 09:02:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A33B1D9A79;
	Tue, 15 Oct 2024 09:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Bn72OfeG";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Wqzbiauu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDB581D5AC2;
	Tue, 15 Oct 2024 09:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728982935; cv=fail; b=Yax9jGaMQ9gwR3icsvSZrWZpYhwk+CREJjfwgtEFlRlA6/w7QVKFIEc9Cz0GIXjQLSQSusV+bN7JnP3h1+Tzgbfdoz1qF7HBhgLsCggUuEPUMGf62VdUzXOmyjYIN7otGZ4EgWRU05hNG+z0iMKnb8aQ5J/WTYuS2/JCoM/jL8A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728982935; c=relaxed/simple;
	bh=KJAmP0gEIqFdsDHQw0vXq6kl8BLXN7Ilg5QGz9ewTHc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PqCZj5/m1HEYbNrMc9CbmTXi/lsi9oxS4aQtBMvALu/IZWRYn6BEvCkRf+MptiQouGi7a5jwGNJddCuVtfQwQwNAmarOIGEt1vEEvXx5seMjyCIGU0McvWzTMD9umlJ6Q+nKHOaACR8VqQj/UnCiUw8d3Mg8pcD7ztnfxjxQOVo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Bn72OfeG; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Wqzbiauu; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49F6F3jt012543;
	Tue, 15 Oct 2024 09:02:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=96/CSpPkbIkWeh3kdzb4Fh9gHbZM5oqNERcAoaBICl4=; b=
	Bn72OfeGd/OKvaRl5cgdmfrl3k+HNdcdgiGhdBOuCl+1wGSqB3o/BrYIJLeGa/ra
	9fAmwQgGBWwSdOzWbkoJYQ1lH/asmM/AV8EsdVRcHXrNYlGVte+/QkfyWTqbhmAM
	t5GUS2B8o3Yf1zxDnmwhlp49r5O6h4PsFjrobBBO+o6oiTVlZhA3RDPxVW6z3Ipe
	UjRERFfz1sCmNrTbFpludJiRpwkydIrPvOFN/douccKt2wneImANPVriMO+7dW+2
	/h60M53kdRmhjVaArYnt9Z/c7pNR6nxVqOa5ANhvgOyjkDOyyizHaOwTRikK44Ls
	jc93i5t3S18HLnC9MgsTjg==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 427h5cgfc3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 15 Oct 2024 09:02:00 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49F7XTSw019936;
	Tue, 15 Oct 2024 09:01:58 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2171.outbound.protection.outlook.com [104.47.57.171])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 427fj75k05-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 15 Oct 2024 09:01:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fvqxJf6ggJtKpa66b5x++juovuHrkdJwvm+iwapqxxQqw9yi5C5v32hTdp9ORdChUCMyl7tl7Z7q8WgPhYlOq9tMvLI4WcoLyRNRU0l3cF5kOlTsvS9IhrnS2L4yzD0w9sj09ruYn0GY45/7fAyo1SLY9VwrodyxH4RSg7MjfeLnwn9KeiCT8IsFCSa4c8yNpK8vv1U7LP0nH3ooNpFTJjZqIzWqwDNblqFU6FahB9R7LLqJFaHibPRpiLK05rHMlN+A1EAASdIYaoIaQFTa7iIK78wXO3UtfPT176Ho6DM3hE7XRSf/gh/dKlEd5/5R6NC7V2DC0StFOvNveXOcow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=96/CSpPkbIkWeh3kdzb4Fh9gHbZM5oqNERcAoaBICl4=;
 b=sxFkdEmEGO8WpnPPiX6xoOpZAacXYEjef10V+LfDFNnAKAe2FFwYYNzFOTxJkju7xRk0GAswUwSi30i/LSEg9kJ6aWxZ3vKs8/v2gmRhH0KvuHgFBOH7ZOIfEViJHSQkrXCiXggDuRSO3aO+txo2buu6tF/2OfSgj7DJThnkui09fluuWJrl+/9kd02JGBhYbMdSPjCgxNOJuj0+/DnxQi35Q1w1Shz4Q0pJc/B63+kB40zpeVOR3WRXPPukol8uoXuoa1KWulVuKqKbviZI1QzZ0LMxsLFXSVBwqZeW1tPdPRC0+1h0ksgRQOPsvEBeQRZiS+QwOf5fyhVPg+jOVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=96/CSpPkbIkWeh3kdzb4Fh9gHbZM5oqNERcAoaBICl4=;
 b=Wqzbiauu/otUCbKy7gTy8vhxI1zmtz/pFOionjJIPRr8+EcUCXYgeKqJY120WXC/As/TVCjODL24H5GijkxYlqwYOv/X0WzYbJSzn/IehPzetvBi/jam8UbSpf/8HY3CJqzlOnpegxqjM7Rhzd6FCOA4wBAXemvHGIAZikk572w=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by CH0PR10MB7439.namprd10.prod.outlook.com (2603:10b6:610:189::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.26; Tue, 15 Oct
 2024 09:01:55 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%4]) with mapi id 15.20.8048.020; Tue, 15 Oct 2024
 09:01:55 +0000
From: John Garry <john.g.garry@oracle.com>
To: axboe@kernel.dk, brauner@kernel.org, djwong@kernel.org,
        viro@zeniv.linux.org.uk, jack@suse.cz, dchinner@redhat.com, hch@lst.de,
        cem@kernel.org
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, hare@suse.de,
        martin.petersen@oracle.com, catherine.hoang@oracle.com,
        mcgrof@kernel.org, ritesh.list@gmail.com, ojaswin@linux.ibm.com,
        John Garry <john.g.garry@oracle.com>
Subject: [PATCH v8 2/7] fs/block: Check for IOCB_DIRECT in generic_atomic_write_valid()
Date: Tue, 15 Oct 2024 09:01:37 +0000
Message-Id: <20241015090142.3189518-3-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20241015090142.3189518-1-john.g.garry@oracle.com>
References: <20241015090142.3189518-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN0PR02CA0021.namprd02.prod.outlook.com
 (2603:10b6:208:530::23) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|CH0PR10MB7439:EE_
X-MS-Office365-Filtering-Correlation-Id: 86c5d5ba-9b55-481a-3322-08dcecf80470
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?fI3FNGJslnfZTrdiQ1h+qMVeWShZe3MuPvNiOa05SJ9VBL2Lqgs44CdxGWa5?=
 =?us-ascii?Q?NmG+PionfhV3ooxPfhLKfbFsE3H+GNdEh7jUvQcqCJndD/nMvHL7e/kWmGVJ?=
 =?us-ascii?Q?iylPucp5XGhE0/92RnAoJZ6sUAr7TIMO/oYsgvvdTWlO1bjrtc4RSKiz23OI?=
 =?us-ascii?Q?Ovtgwgdb+Ew6KiuzbzF2aM39iC3NcpuArjYq6APXEOYu3J2Dqc0acD8spajo?=
 =?us-ascii?Q?cQ6chJYDcQI2fNGZmGc49IQH5qqQglbjnkLHO6L7R97ZjAfDiUlDmp35BpiQ?=
 =?us-ascii?Q?L9tBgjS+BKJIA+nxL4dvbJB4SmlLEomZ5SimCU3hEel4GAV6bo2ZAhzLyFtF?=
 =?us-ascii?Q?Y2jCBwms3eMElU4PmTvsOWtby4Ur5tA7C+etgKZ2LTyIE2dcBrLrUMiOEga1?=
 =?us-ascii?Q?xBVgrZR8fLKREesl2K/SZabCswVAby7nT86M6EqaA8Fk1JdFAHUeMHKnfIUq?=
 =?us-ascii?Q?lY3HRZuRm7JtvIHYZjcbZvJbE4l+7Ovx/yNYp/7jMpYMTComBH1QMLjBzZOx?=
 =?us-ascii?Q?hEHaWf4DGO8vFv5oA7Zt6VvCsTOv+tT2rLftD7gx/oHY0PgThqkKdUAbtMhW?=
 =?us-ascii?Q?jo7p/1PhgUer+g6e6McdOEGs0IHFJWIrBTCbdTQHH8ljL1sAGJKh9wiTztD4?=
 =?us-ascii?Q?Gl9M71DbMGBbPAvzIY+Tb7GDMtwX3xpFZQk1ImMpMF3p4D9IIn3kDA1dv07w?=
 =?us-ascii?Q?CxYzO/DLwxrDnEP92Mmbhigdrmn1gxXzdpyXfMaSPwCXB0VaJY8PEizU2F7g?=
 =?us-ascii?Q?m4TCxB6xPVFeSDlfkuVw3YnfcqPSaFp975Mm9fzmZIaxr87+4jJzRQWtrJV8?=
 =?us-ascii?Q?fcYGiOv2xBZur9LGJTn3xmDdCyimAjxuEmAgwHjwXqhBIFyPs79sW+Al/uBV?=
 =?us-ascii?Q?gndSNadd6F/LsYCdBbMmK5d4PzPB1c9/rqWiu7ZM2CQLQdxit+KeH4Ga9i6H?=
 =?us-ascii?Q?7ndH+qzPa5+0KawWEO5JKoXh1/5pamNeDvipTxSPptWvGeYybes/qhEMi/0W?=
 =?us-ascii?Q?7mNsiC4DZp4qu/u6uO1jim5MPrAtoX+dg1AJInve7pggN2qWySnUsD/eR2rO?=
 =?us-ascii?Q?h1UzXmUiAIthyL4CdtEN+JVFJnVUCu6via0kSrQspXeJHWWTmQrXLZdrbRAS?=
 =?us-ascii?Q?hRDrQaDQnSGZI6vWfeGKldQHX+YvjfLpPU89KUOCUKn0s8+eu36bO2zaG1Xg?=
 =?us-ascii?Q?fjGBdPPC+S/XwMm2PIH9DBdz5u7ZUV8JFv/rDh6DZ6vAojCdAS0AxSeuQ4Bk?=
 =?us-ascii?Q?hPigDhk28RPPTn1N/1nsdING7M2BxolvVSCUh6E3XA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?br2ddAFTtgttvsexIHDtQ7TaSFl+zdI27tgR+UXH0Xo6F+l4Sf8Cr8D5O6xI?=
 =?us-ascii?Q?47bDvGs11rTlPM4+ZqBmEXuQNrxXcCxkC2/ynACs37o3NHQx4g67iQLyVmz8?=
 =?us-ascii?Q?vm0KBLmL7tkNdJS1xvWqBrI2uc+kltpZUKlsfs6yOoOH28hd6lYuhiofSX/w?=
 =?us-ascii?Q?2I0t8DwsVHhErkly836lMrMiuMy8AtcZ8cWlZ3jZOij4i6xhH25xYPs4NJFz?=
 =?us-ascii?Q?+0Y0FFZxCxJRx44AP9DQUIEqiyScC62cvtmqb5ZVD1G3VNUGPEH7ctWrXXP7?=
 =?us-ascii?Q?RJvGxVEFlEoA3nisikCwVmrt0qNimFAtIH36YWtrtxmL1b7pQtDHUAqG0y/x?=
 =?us-ascii?Q?dhtyJiQH/8qzAdWnBMzqNtff7rgpDvVsodBGFVg/+RO85sxPxiK//I9mGrA7?=
 =?us-ascii?Q?T/je+1zsfZ0aWLFJUgXnank7pJvKlImIx/SikaOe/JNraiO0qbW6VC/nrigy?=
 =?us-ascii?Q?i6WnCg+M0j7oQ3AX0hQZNmXLANkAaZKnb5ppcCV9rgbyU/O9pW9K2NSTqx3m?=
 =?us-ascii?Q?+RKXnUK0v2/GKDD3VXtzWIu+uCvjj2bv6efyQTBVDFto0OBAkuurgw0XOeri?=
 =?us-ascii?Q?0YmaGNzLQfUWJgkuJtmkT54L8/X4/JBSi1Dw+AdLn/n8OgDZwbOmjTVe+g39?=
 =?us-ascii?Q?o6mZDxDLqqbwCjvkf3IBKexgAUL7iF5c6mtGYiGG99wwGCs2Xt0Jr2BOe4cc?=
 =?us-ascii?Q?IcgugX6KZFegMD6UOaAM7iqKtdtTLybeWY6qktn+ovocbkxeEOFUuTIuiQ98?=
 =?us-ascii?Q?Pqs/qTwlVYrAJC+0Ntik/N3vWJfPTrT9xcG1Sq7r1mQfIroDlxSWNyohpgFt?=
 =?us-ascii?Q?WdVrdeLqhGkStwkg7N4vLmmxWT1cxLHDMSF4fxVs8DgcOANT36aTWgb1VGL7?=
 =?us-ascii?Q?8joEhpt/1PUBvje9g55/T91SaWNMDQ0Kiqeqy/XXumB3DLl2kNj668YEzxec?=
 =?us-ascii?Q?GphErSOmJJnsjDEfXF0+rhlC/vzlbhh/5sdWEc42ttSYpubxx+yfP+9RPYfW?=
 =?us-ascii?Q?fWch7/x7gScWwtIuDK5eBaHT6fEAtqhc57gkDyz/za92VreGf4Vbql7Cioim?=
 =?us-ascii?Q?Pje64udEt/OAPpP9detak6sq4pSJVe0lFx5oPI7lA7gar63BfHm0bx4gE1Z/?=
 =?us-ascii?Q?/OZehc3Kbt6z+/mUCwIzsXHje1h/4v9l/Iud0oGyRFT0TZUmQvTWwFvSL9Ks?=
 =?us-ascii?Q?ewx/LtVZbHU25MsOtbvS9DjoJcutfEHngM33FgBGOpET+j7VUaE/cLve/0g9?=
 =?us-ascii?Q?sZz3zdIhJKR35HgUBfv6wYrXVnm1pMKOdpw0Z9GTiW8e4ndzfH0ImQk56Y43?=
 =?us-ascii?Q?p7wXwkDXcnBwnVyz7R9UzJIfaZddpz27m8gqQE6dLivbZM3xjVm2NY9ZjWTZ?=
 =?us-ascii?Q?1pzcsiOUcSMTU2ctIq/cuKjivLCRlBrdu58o+5lKNT2i+NXJytT7XUEIT4i+?=
 =?us-ascii?Q?AIFA+U8gCke+EKf87LkDtt11mcQvYTP4nUKm9hRkaq9UfDxYj8uX2YIEHdnH?=
 =?us-ascii?Q?r3MR8Z2XolAZKdai1CMmy71ddyoPp5PDt4IBILKyKml89o1BoSF4hK61pzs3?=
 =?us-ascii?Q?F7nYNf5HRUZBu2Nwy45JOJrrSI0PSaWWw/1qfG6SdHYOtiGMJa9VYbTh4/2K?=
 =?us-ascii?Q?Rw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	mLKPYC87kDwHiMkFZFD7IsuTW6y9GVbo4erb8MMeaw9UV0f8H7yCemq7AJCdu7D76qDpl4nRacRzdffZrUCYTeNUzCeDuV/oVbx0olxddB2vFm8uIvpu0ntnAIdL4QW3UzLKVsdbYE87LQcyvZKIG4Kejg1JrVt8wD7BEj5TCyW+flMJdA2d6ALTdKVALp0wDq4S52E8HSKpzgznKKnZsbSl6JIlI3a+7Qnli8tlresHxx1HwsJehhluOrHnFc5w3LPigfgotPh/iKZzM1HXdM4nuw3IvVCTIRsdf5GNUJc5AQUOd9Ws+3XRmQxiHnABl5AgWMHgYTbLO9KK9rYB4XY/pAIMUq52iPqnKYzvkXpdjkS5UKy0rM+Aque0oKx0aXQN6uq6VSqDcPICd8Tn/Bra88QQ3KqUw3VXEnqrlALzwJXoHbBGfFedFxW/ISrZYYwqRFre/qX7xnZTfLQ165LBa2SoK83KpHvlI/ilG1zeJ6vHmF4uQrjztEHNUr9/9uk9E9zYDTyQT5JUZRWCr/VHeess10oG+vN/bDSu0lS1lRMOaV+6RenohF54h7DU/DZhzZDcjY6f9mRL/rmuA1s98E33SwvxKTy8Ni33jnE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86c5d5ba-9b55-481a-3322-08dcecf80470
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2024 09:01:55.2193
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y1/3VwpEy12hhQ+uHBIcNHR5Vk5RIX9gkc7IoiE7KpzsI03acsEvJLj1ovt3YF8jC28++uH12r/BC3nf/kvE/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB7439
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_05,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0 phishscore=0
 adultscore=0 bulkscore=0 suspectscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410150060
X-Proofpoint-ORIG-GUID: 5OEUFGsC5HWO2-CspMtqL2Ia0dburWVi
X-Proofpoint-GUID: 5OEUFGsC5HWO2-CspMtqL2Ia0dburWVi

Currently FMODE_CAN_ATOMIC_WRITE is set if the bdev can atomic write and
the file is open for direct IO. This does not work if the file is not
opened for direct IO, yet fcntl(O_DIRECT) is used on the fd later.

Change to check for direct IO on a per-IO basis in
generic_atomic_write_valid(). Since we want to report -EOPNOTSUPP for
non-direct IO for an atomic write, change to return an error code.

Relocate the block fops atomic write checks to the common write path, as to
catch non-direct IO.

Fixes: c34fc6f26ab8 ("fs: Initial atomic write support")
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 block/fops.c       | 18 ++++++++++--------
 fs/read_write.c    | 13 ++++++++-----
 include/linux/fs.h |  2 +-
 3 files changed, 19 insertions(+), 14 deletions(-)

diff --git a/block/fops.c b/block/fops.c
index 968b47b615c4..2d01c9007681 100644
--- a/block/fops.c
+++ b/block/fops.c
@@ -36,11 +36,8 @@ static blk_opf_t dio_bio_write_op(struct kiocb *iocb)
 }
 
 static bool blkdev_dio_invalid(struct block_device *bdev, struct kiocb *iocb,
-				struct iov_iter *iter, bool is_atomic)
+				struct iov_iter *iter)
 {
-	if (is_atomic && !generic_atomic_write_valid(iocb, iter))
-		return true;
-
 	return iocb->ki_pos & (bdev_logical_block_size(bdev) - 1) ||
 		!bdev_iter_is_aligned(bdev, iter);
 }
@@ -368,13 +365,12 @@ static ssize_t __blkdev_direct_IO_async(struct kiocb *iocb,
 static ssize_t blkdev_direct_IO(struct kiocb *iocb, struct iov_iter *iter)
 {
 	struct block_device *bdev = I_BDEV(iocb->ki_filp->f_mapping->host);
-	bool is_atomic = iocb->ki_flags & IOCB_ATOMIC;
 	unsigned int nr_pages;
 
 	if (!iov_iter_count(iter))
 		return 0;
 
-	if (blkdev_dio_invalid(bdev, iocb, iter, is_atomic))
+	if (blkdev_dio_invalid(bdev, iocb, iter))
 		return -EINVAL;
 
 	nr_pages = bio_iov_vecs_to_alloc(iter, BIO_MAX_VECS + 1);
@@ -383,7 +379,7 @@ static ssize_t blkdev_direct_IO(struct kiocb *iocb, struct iov_iter *iter)
 			return __blkdev_direct_IO_simple(iocb, iter, bdev,
 							nr_pages);
 		return __blkdev_direct_IO_async(iocb, iter, bdev, nr_pages);
-	} else if (is_atomic) {
+	} else if (iocb->ki_flags & IOCB_ATOMIC) {
 		return -EINVAL;
 	}
 	return __blkdev_direct_IO(iocb, iter, bdev, bio_max_segs(nr_pages));
@@ -625,7 +621,7 @@ static int blkdev_open(struct inode *inode, struct file *filp)
 	if (!bdev)
 		return -ENXIO;
 
-	if (bdev_can_atomic_write(bdev) && filp->f_flags & O_DIRECT)
+	if (bdev_can_atomic_write(bdev))
 		filp->f_mode |= FMODE_CAN_ATOMIC_WRITE;
 
 	ret = bdev_open(bdev, mode, filp->private_data, NULL, filp);
@@ -700,6 +696,12 @@ static ssize_t blkdev_write_iter(struct kiocb *iocb, struct iov_iter *from)
 	if ((iocb->ki_flags & (IOCB_NOWAIT | IOCB_DIRECT)) == IOCB_NOWAIT)
 		return -EOPNOTSUPP;
 
+	if (iocb->ki_flags & IOCB_ATOMIC) {
+		ret = generic_atomic_write_valid(iocb, from);
+		if (ret)
+			return ret;
+	}
+
 	size -= iocb->ki_pos;
 	if (iov_iter_count(from) > size) {
 		shorted = iov_iter_count(from) - size;
diff --git a/fs/read_write.c b/fs/read_write.c
index 2c3263530828..befec0b5c537 100644
--- a/fs/read_write.c
+++ b/fs/read_write.c
@@ -1830,18 +1830,21 @@ int generic_file_rw_checks(struct file *file_in, struct file *file_out)
 	return 0;
 }
 
-bool generic_atomic_write_valid(struct kiocb *iocb, struct iov_iter *iter)
+int generic_atomic_write_valid(struct kiocb *iocb, struct iov_iter *iter)
 {
 	size_t len = iov_iter_count(iter);
 
 	if (!iter_is_ubuf(iter))
-		return false;
+		return -EINVAL;
 
 	if (!is_power_of_2(len))
-		return false;
+		return -EINVAL;
 
 	if (!IS_ALIGNED(iocb->ki_pos, len))
-		return false;
+		return -EINVAL;
 
-	return true;
+	if (!(iocb->ki_flags & IOCB_DIRECT))
+		return -EOPNOTSUPP;
+
+	return 0;
 }
diff --git a/include/linux/fs.h b/include/linux/fs.h
index fbfa032d1d90..ba47fb283730 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -3721,6 +3721,6 @@ static inline bool vfs_empty_path(int dfd, const char __user *path)
 	return !c;
 }
 
-bool generic_atomic_write_valid(struct kiocb *iocb, struct iov_iter *iter);
+int generic_atomic_write_valid(struct kiocb *iocb, struct iov_iter *iter);
 
 #endif /* _LINUX_FS_H */
-- 
2.31.1



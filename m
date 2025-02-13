Return-Path: <linux-fsdevel+bounces-41650-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B926A34110
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Feb 2025 14:59:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C3DB03AB913
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Feb 2025 13:58:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3BF9269807;
	Thu, 13 Feb 2025 13:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Vx8JHElm";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="fsJg/ENz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B23232222AE;
	Thu, 13 Feb 2025 13:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739455041; cv=fail; b=hQVn0tc+lhBUNSmQpXow5U/KvgIl1QYu8FXu7yja6nuncuMlevmKJceGbDXbmVjIBww1JgtQtVnZ5BWVDwaFUA2rv0fQQEJ15rMu7EvT36lNKF0Px808c/jz6OlO59BY3UvAwimSxPSR1y4Y0wmwkOHGc2IVjv1UbYeYkT88a0k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739455041; c=relaxed/simple;
	bh=Xm4jBMxfAFw2CaGFF75S07Q/fh6KRnn+UsMlbS7C3ts=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Sd7JsrFsECAICMRG3A2Nw5XJUuZSRMr6hBpzX4ixjO6wBcSxSoPFn256Y2NJEfobRnfwg/MX7lpG7f5cIQefstaijBSgNl82AKm8Oyp5DuovFz1vFulfWMRS8XabpmLro5Iv3g/v7297ij3QCMH+Z05B1ZxpUqz9q9Ypt6vd23c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Vx8JHElm; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=fsJg/ENz; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51D8g0lK022566;
	Thu, 13 Feb 2025 13:57:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=YGb/DUIfK1AtXKzzRvrKHLaT7pB8CE9DOB3tMX9m2kI=; b=
	Vx8JHElmzrZV/aZOX3LHy12NkYECJQwM6AUxEscbDdGkbJjnooAc/U3nWVYdbXdT
	H0ABAxU2whqGRAe8y8wljg0k4OsC0BrXHOYhhetaBDoC/7ojZhtlurm6MBSdTpkE
	XtIApXXZeM3yoO9NLIGUDIEWlBZVbVkI2NqCoChgb6FIWwUS+KPp0KnzDNvSv7SY
	e+lzedKrKCA1LHQZy4ddhHPdtz6/isCQfk3mdnHcmbTjaHmoFfBn1WnHWj1PFcVl
	ecUqHiBUuiSHvcuoYfxKG4lNqrTshwFCRoJUobg3YZRENow6Yaq3xbu0J68y85v8
	GALsZ9wsIPTxJTeA8t/mjw==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44p0s41mca-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Feb 2025 13:57:04 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 51DCSMVa026996;
	Thu, 13 Feb 2025 13:57:03 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2169.outbound.protection.outlook.com [104.47.73.169])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 44nwqbpr75-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Feb 2025 13:57:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=THVkOOZ1ILLuAlaJRyAX8a5XJxW5chD3EqTYGCopExdRB/d3OuZqOX7JcDA2k2Bhbkl/QGJlMfwZ2XRPrNCj8RJK3EiCBbGn6FA27gEfdSSwp0kTtpA5JKJ9PsRPosTdjWlzl3RfLprZQ7XuLAeC9E3qyDJJmiJhQl2a6ldUDATYNSUqOGz4+swID7gjkaS+SR7AwBvTEogmHhaNp8iW/Y6tJDrdtE9iYc4c7btZ72rb+VqdyALnE7bFd62Wx+OOHF/ADwy33a3GEGOVmULx6nTyyb44XRjl68mTwy+quz+4Hh9ZOaR01cnv2kK18/wAeUyFMujlHxT7CDgmGew13A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YGb/DUIfK1AtXKzzRvrKHLaT7pB8CE9DOB3tMX9m2kI=;
 b=eKU/1CrsyP+OrouuWFvq0qazsK4xs6o3b4jVsSDl/KVbAKnMcjWfSC7wxTZbfUVOG+IuBsnAFNeBsRVy2p1yw4W894GBhvsI+GI0aaazrnreYAOgJfa++0t6paJZrn7IbfEGunew+E9fWYM4g3nrIKHRztooaXxB1bS/j1C39gPZ/PQWQzP/hlyIdWrtiCCVSjrNYwMf3H+/BhDU/+sEy0czTbYu/vpmA/SEAMNnLPZfRxWQo0Zf2vnHpm3xyRyX5Kb+iTxeuNT7Oo/u2G2AAR8KfMeT5pXx4BM4G2Y0sxDd5ZDiFW/gfzAnNRn5btS6e099dsPzQnGhC98HvwcNJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YGb/DUIfK1AtXKzzRvrKHLaT7pB8CE9DOB3tMX9m2kI=;
 b=fsJg/ENzBPaXiLX+6wwl6CDmLvC7t5l+4sbZUio3Cqk+8FCqzBCixsNaT8gMVon8QpdmPBohylfI27N5Y3YMa0mD7kJbkLQDqpRGBd3n30ai0VhBMRfwIhCVUrcimo2W7+RUzvEvcimuoOb8G8WBvaqYTJ+KH6+n+jSVIuOoB68=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by DS0PR10MB7125.namprd10.prod.outlook.com (2603:10b6:8:f0::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8445.13; Thu, 13 Feb 2025 13:57:01 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%6]) with mapi id 15.20.8445.013; Thu, 13 Feb 2025
 13:57:01 +0000
From: John Garry <john.g.garry@oracle.com>
To: brauner@kernel.org, djwong@kernel.org, cem@kernel.org, dchinner@redhat.com,
        hch@lst.de
Cc: linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, ojaswin@linux.ibm.com,
        ritesh.list@gmail.com, martin.petersen@oracle.com, tytso@mit.edu,
        linux-ext4@vger.kernel.org, John Garry <john.g.garry@oracle.com>
Subject: [PATCH v2 01/11] iomap: Rename IOMAP_ATOMIC -> IOMAP_ATOMIC_HW
Date: Thu, 13 Feb 2025 13:56:09 +0000
Message-Id: <20250213135619.1148432-2-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20250213135619.1148432-1-john.g.garry@oracle.com>
References: <20250213135619.1148432-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN8PR03CA0021.namprd03.prod.outlook.com
 (2603:10b6:408:94::34) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|DS0PR10MB7125:EE_
X-MS-Office365-Filtering-Correlation-Id: 10e06808-f052-4dc1-0290-08dd4c364a1d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?U2IHCjwZsBFt9dxE4ZEN7++Rrj/tqm7ewJXzsMQAsYHIiSSboM5ZBeJA95lx?=
 =?us-ascii?Q?sdtYn+G1b2EHB9d0EDrUG7rXsS+YtAcKvyO9LCmMhDp426th2JoSMFm4cUn+?=
 =?us-ascii?Q?1o/fAoJ7gIDl3SpDTx4wkEm6dwdW4yt0V1+LdVeZijWhcjxbd6Rg7/zt8X9a?=
 =?us-ascii?Q?zKR3+UbHsLHitikjAAzBYvELB3XDlV8JLzdEbbGDb0c4kuwM6sv9bfTb4h3x?=
 =?us-ascii?Q?bOWQv0UUw5Q5zdVprMpljGPWXbjmpsMyzGZQnS7ALtxBWmH0UPFiZPYkAlQ4?=
 =?us-ascii?Q?D0U/xjCYpbAz2QY9jsAHfFM9NwrzmhokVdMsR7BBK3z9fGLQxFIwV1++i13q?=
 =?us-ascii?Q?F77LB2p6ddXjeYsFiIvCueJu/wynjq3bKVs/aDEslHPvZ0SdEXsbqpDSu+RU?=
 =?us-ascii?Q?ntYBIpbiaM6iQbL8rN9RHwO15V8wPCnY8QKpJsWpcYoClKXHi8g6T0nD/AJC?=
 =?us-ascii?Q?jI6BWYZ+cTf04CnMcLO4MO6YxcmgAMH30rEGk8rw/M4KDfgghKmHdo3vdtUv?=
 =?us-ascii?Q?maMQy+bD/tgmGeIt1baeAaFcsdAF5r92D2x0QqbuH8BNZ+xZhYR0Yy5GrCek?=
 =?us-ascii?Q?cBxX3N4LrydYyd5sdMRsj6rOkeyWFzhTsgg0ZX1r/K4bQj0wU6Q94PACRwlv?=
 =?us-ascii?Q?0FUDHtlU3YLbaQz8vDVjSVWTkegd1DOEujN0RTg2z76ThKHjZIMl+z3VyPe0?=
 =?us-ascii?Q?3qzdMT3wUaSxy/vWpaBmpgPIQvKAIlnyoYZ2FuWWrx4qmErEq5z4HO3hVM40?=
 =?us-ascii?Q?0rWwgvxBYkWggxkX7MjN+aen7SnA0vqKgNP03TywinbGST5oG6RZoIOOiNiy?=
 =?us-ascii?Q?K/Xg8jkxF/NLhEpqc1aGjgn2s+VXDYifF/1RIt/3JoeAnh7pt3m0PSjeAJVS?=
 =?us-ascii?Q?6rjoQ0vHY+h28To9Lc2k6AJOEZPF5icyxYmUGTT4bU/che8i5xhMfOYBZaqt?=
 =?us-ascii?Q?Kz5dCMuB5xmGFbdlvVvbuL/Im87Zvy6C5j0pUEiflOgtfOl4enRO3aLn/jRU?=
 =?us-ascii?Q?ZRYxauvgYG1uFbTTSOtGWmKUqbfQ0uP3E6+FN7DuDdG76WfrexyvgLBvaTpt?=
 =?us-ascii?Q?Sbj92kiwQhq5bOIHVZEneJg0xkhrIU5mcDQxG6SqB2paRRZzhp3H9GDP7vp9?=
 =?us-ascii?Q?AW8qZcXxoDsKA0mAmoPpXP9BLFAG/gjAoB3FNtOlOs0sHCj9pURr7r9uto41?=
 =?us-ascii?Q?T7LIMQ7D0RD2B5PlDgtS2IDXPQGoOpCvZZ7Og2zzPRaIUZlZ3YIvQjwf60u1?=
 =?us-ascii?Q?POQYUpcSVRj0z//uNVYkc+6nbCmGzmVIJJRbCVdHWt9yQwLd9zliZiidV4O1?=
 =?us-ascii?Q?ZwgOWde6QQTpHKwEyQjKvYtOW1zPm3G0tQp5mYVybvYnnsDHLGNekpeLDmOy?=
 =?us-ascii?Q?o+g3AX4gKfUfoAJMh5OduZwzTKZ5?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?N0z+DKvJRcfezO0h6gtvieow7YQT6wllLwtYiwCi05kJbuKUikLUekHJPxZP?=
 =?us-ascii?Q?LTkDdaPgsC68GDdKlsdx/tv3GyZsPzw7pceJh9gt7vjOPGa6RV1fA1Jsy2Fh?=
 =?us-ascii?Q?CSF/nKtrE8pI1TbAyCAPEDN00WvO2YcksPqgnoOqfBhy0ZLLxer4kVe9AFd7?=
 =?us-ascii?Q?ojrLllDTBzh5FDKJWGaV8fmng71HojSKaH9hhbPe0+/5Zqei+KJZMEesRplC?=
 =?us-ascii?Q?aCcJPCd7tw5tXttLXmg+HQbevJq9CSI0MrtOkCYryLP65N2XydAL2iwf7f3A?=
 =?us-ascii?Q?XXidTPUxbVRMxBlTDoc+VRE8IMEXB/1jcidizd1VOSb6s6ulkLYDC6IFiKCp?=
 =?us-ascii?Q?oToF80TY3lh5+TemWBvkXBX5+u6I+ZaKZJBKWLTktd/76fTS0FPFLxHJVZST?=
 =?us-ascii?Q?l6e5X1YyODboMrzvUqhab9T3mT84GIF2R5VBxAIohfBn5cpailzKhEU07A5+?=
 =?us-ascii?Q?rLs4Z3I5Gvpg7QpSeBkOqIaWMRX4pPAyMSlrQ2+3m589uf/xgTYQ/O3QSKoN?=
 =?us-ascii?Q?5K4ZIKzpHV1gb88r+LzdHMclV+mztes8D3OvDIHLc9k3MmRl4IBzJJDSlnXn?=
 =?us-ascii?Q?IQayW4TN+7iH76bMvSj5V5g0ITP4dD24mP/1pkYVjwkjd7cDH7MHLbGWoh+c?=
 =?us-ascii?Q?g7gg+MXo0hj82+1t7ed2HAbzeqpL/oX0VPCqisRpIpnSMZ9OnGp7U59nrNmS?=
 =?us-ascii?Q?vVtd00MOnJ76siSnuaCKyNjiJicZTn09IUKBNO02mifQx4YPR+DTk7YL01Xw?=
 =?us-ascii?Q?YyreEVn9MluMkCVNSL8LmTpvN79irGTOSH7dMRjrm3pK5qR/iTfqUk2ADX+2?=
 =?us-ascii?Q?NLAUrkxKLLSxrZn1mbzmwwwjq2N14dJnDmz5SAFQ0JRCDIjX83I6eq1wdLDk?=
 =?us-ascii?Q?1MKjzT1VJKt3uTHpUkkk7fshfoUZA9CdEUfCXGg4kLOGbOuHBfYFiLcttVG1?=
 =?us-ascii?Q?+uOxvXSNvcwzysHHk1ClpaBZ51eSo1wYqMBD/sXzAlPzcFbcMryMf59Vd+rr?=
 =?us-ascii?Q?TNKGeYddSNbAWmygWDQ94e74aPJ9133hRHnvIOB/zCWeF2pT5faStc5sH+kK?=
 =?us-ascii?Q?umvgzGV+qCmTwhEsC6PpZfAOVj47TeVELNh9wfdvVFiBHwQy6gNcYjOT9ZTw?=
 =?us-ascii?Q?isi8/mMEUNV9vJuJ5WIPvjaJOLSakifc2qCu22Yeh2kznaxYpwnDGWbwY+gR?=
 =?us-ascii?Q?zU0TeIVu9rQbqFwFPpVO7bC8AgGMTpW3j2x22g4WbLPBjMCPdQXLsGbAbiBJ?=
 =?us-ascii?Q?vM/W8BKd/uyngiG1aYj6l+mE2EvuDDKll5G2IuWucC6srtrNrLm7v8iKhw+t?=
 =?us-ascii?Q?i4jovPzDwk9Nj0R0j4/8T/nZcxSJDtonfydVo1+CPkp1UXuu1YkmH5uAcFvp?=
 =?us-ascii?Q?nf9Qb/CLBCO5McprEgUJE7V/hnFoNsJE1Gsr1xG/jZDGtlpK1OndcLEdvp9e?=
 =?us-ascii?Q?p0pCeafSLmSnV4ueJiFkyXrxs3JKFh2/kuZWFl1W/uBaFiDCx1dqLVhkw21u?=
 =?us-ascii?Q?PvCrKF8mxTtPdRWS/i2sBjKRiWS+CQ60VM7FW5qU83EEqkF0IRIf7ZBUdSi/?=
 =?us-ascii?Q?02kTGfJlH/d4cHvOU4iYOClk1XoyWmcrLHF5Er3/IjRRYDEeuJzX1g2RK8zV?=
 =?us-ascii?Q?Jw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	PltBRNWMwLGLK3JFTvxJx8fB4ZfacEVaF5he1kbN768tGhVNxd28MzFX3azbVndd2tDtdHM9c1AQ4QMCfO+/UdWkQc3rKSg2UBJ2weL9wHHrVCKoacEMCA1On5N6Fh1bmOPnOIhTWSTgWVJw4oVuidQmkwdd23SWNmRIxdYpiPFuqceF4UsVPLwMUzBnFq0pFCX6yasHClvhhSiSDcqAX465XxeEsX70GeOv8/6BWY2x2sO677qnZGMlPv6wVH/JP6UL0vzm2ZhLXz8tCogYiul6kK6BE4M0/N901oDQmkTSh4Quvnocz+z8ED3Q0xuQLQQiKetbb2EhcuZ37FmCLm7Eodfb4qe24xKCU2V9a20KI63iGWG9bWF4a1YoHNboXPM2YyPQF1VEJ+XLg2YFZ3mBhZPUcotymjgaetfv1Ff64dR1jvnA8weP9xzOaXFY75aTG5J4awaTQp6Rj/1La5W3WGlkI9RcnjFAUdM7cJ7u9g//7rN+0cwoZsGGKSliKORrqILvU5TwYbEWGjkGpE8kVA4rHkvD5+a4BhjlEz8rpG6vaDloU99Jmv7nTHoBD3tmftUNWdiOZ6WAket5/88Y6w35udt8h49PxBCb27E=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10e06808-f052-4dc1-0290-08dd4c364a1d
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2025 13:57:01.3401
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7R1bxJapsj2iVS0MIvvWJFhkA499vLcjT874aoeAFdoIOkan65xqj1icnN6bZcJSjmWDfE29LFWF+D/Xg9Ph5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7125
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-13_06,2025-02-13_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 adultscore=0 mlxscore=0 phishscore=0 suspectscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2501170000 definitions=main-2502130106
X-Proofpoint-GUID: XCV1LCmYKqzY8GY-LX0qChssNeD18E7B
X-Proofpoint-ORIG-GUID: XCV1LCmYKqzY8GY-LX0qChssNeD18E7B

In future xfs will support a CoW-based atomic write, so rename
IOMAP_ATOMIC -> IOMAP_ATOMIC_HW to be clear which mode is being used.

Also relocate setting of IOMAP_ATOMIC_HW to the write path in
__iomap_dio_rw(), to be clear that this flag is only relevant to writes

Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 Documentation/filesystems/iomap/operations.rst |  4 ++--
 fs/ext4/inode.c                                |  2 +-
 fs/iomap/direct-io.c                           | 18 +++++++++---------
 fs/iomap/trace.h                               |  2 +-
 include/linux/iomap.h                          |  2 +-
 5 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/Documentation/filesystems/iomap/operations.rst b/Documentation/filesystems/iomap/operations.rst
index 2c7f5df9d8b0..82bfe0e8c08e 100644
--- a/Documentation/filesystems/iomap/operations.rst
+++ b/Documentation/filesystems/iomap/operations.rst
@@ -513,8 +513,8 @@ IOMAP_WRITE`` with any combination of the following enhancements:
    if the mapping is unwritten and the filesystem cannot handle zeroing
    the unaligned regions without exposing stale contents.
 
- * ``IOMAP_ATOMIC``: This write is being issued with torn-write
-   protection.
+ * ``IOMAP_ATOMIC_HW``: This write is being issued with torn-write
+   protection based on HW-offload support.
    Only a single bio can be created for the write, and the write must
    not be split into multiple I/O requests, i.e. flag REQ_ATOMIC must be
    set.
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 7c54ae5fcbd4..ba2f1e3db7c7 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -3467,7 +3467,7 @@ static inline bool ext4_want_directio_fallback(unsigned flags, ssize_t written)
 		return false;
 
 	/* atomic writes are all-or-nothing */
-	if (flags & IOMAP_ATOMIC)
+	if (flags & IOMAP_ATOMIC_HW)
 		return false;
 
 	/* can only try again if we wrote nothing */
diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
index b521eb15759e..f87c4277e738 100644
--- a/fs/iomap/direct-io.c
+++ b/fs/iomap/direct-io.c
@@ -271,7 +271,7 @@ static int iomap_dio_zero(const struct iomap_iter *iter, struct iomap_dio *dio,
  * clearing the WRITE_THROUGH flag in the dio request.
  */
 static inline blk_opf_t iomap_dio_bio_opflags(struct iomap_dio *dio,
-		const struct iomap *iomap, bool use_fua, bool atomic)
+		const struct iomap *iomap, bool use_fua, bool atomic_hw)
 {
 	blk_opf_t opflags = REQ_SYNC | REQ_IDLE;
 
@@ -283,7 +283,7 @@ static inline blk_opf_t iomap_dio_bio_opflags(struct iomap_dio *dio,
 		opflags |= REQ_FUA;
 	else
 		dio->flags &= ~IOMAP_DIO_WRITE_THROUGH;
-	if (atomic)
+	if (atomic_hw)
 		opflags |= REQ_ATOMIC;
 
 	return opflags;
@@ -295,8 +295,8 @@ static loff_t iomap_dio_bio_iter(const struct iomap_iter *iter,
 	const struct iomap *iomap = &iter->iomap;
 	struct inode *inode = iter->inode;
 	unsigned int fs_block_size = i_blocksize(inode), pad;
+	bool atomic_hw = iter->flags & IOMAP_ATOMIC_HW;
 	const loff_t length = iomap_length(iter);
-	bool atomic = iter->flags & IOMAP_ATOMIC;
 	loff_t pos = iter->pos;
 	blk_opf_t bio_opf;
 	struct bio *bio;
@@ -306,7 +306,7 @@ static loff_t iomap_dio_bio_iter(const struct iomap_iter *iter,
 	size_t copied = 0;
 	size_t orig_count;
 
-	if (atomic && length != fs_block_size)
+	if (atomic_hw && length != fs_block_size)
 		return -EINVAL;
 
 	if ((pos | length) & (bdev_logical_block_size(iomap->bdev) - 1) ||
@@ -383,7 +383,7 @@ static loff_t iomap_dio_bio_iter(const struct iomap_iter *iter,
 			goto out;
 	}
 
-	bio_opf = iomap_dio_bio_opflags(dio, iomap, use_fua, atomic);
+	bio_opf = iomap_dio_bio_opflags(dio, iomap, use_fua, atomic_hw);
 
 	nr_pages = bio_iov_vecs_to_alloc(dio->submit.iter, BIO_MAX_VECS);
 	do {
@@ -416,7 +416,7 @@ static loff_t iomap_dio_bio_iter(const struct iomap_iter *iter,
 		}
 
 		n = bio->bi_iter.bi_size;
-		if (WARN_ON_ONCE(atomic && n != length)) {
+		if (WARN_ON_ONCE(atomic_hw && n != length)) {
 			/*
 			 * This bio should have covered the complete length,
 			 * which it doesn't, so error. We may need to zero out
@@ -610,9 +610,6 @@ __iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
 	if (iocb->ki_flags & IOCB_NOWAIT)
 		iomi.flags |= IOMAP_NOWAIT;
 
-	if (iocb->ki_flags & IOCB_ATOMIC)
-		iomi.flags |= IOMAP_ATOMIC;
-
 	if (iov_iter_rw(iter) == READ) {
 		/* reads can always complete inline */
 		dio->flags |= IOMAP_DIO_INLINE_COMP;
@@ -647,6 +644,9 @@ __iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
 			iomi.flags |= IOMAP_OVERWRITE_ONLY;
 		}
 
+		if (iocb->ki_flags & IOCB_ATOMIC)
+			iomi.flags |= IOMAP_ATOMIC_HW;
+
 		/* for data sync or sync, we need sync completion processing */
 		if (iocb_is_dsync(iocb)) {
 			dio->flags |= IOMAP_DIO_NEED_SYNC;
diff --git a/fs/iomap/trace.h b/fs/iomap/trace.h
index 4118a42cdab0..0c73d91c0485 100644
--- a/fs/iomap/trace.h
+++ b/fs/iomap/trace.h
@@ -99,7 +99,7 @@ DEFINE_RANGE_EVENT(iomap_dio_rw_queued);
 	{ IOMAP_FAULT,		"FAULT" }, \
 	{ IOMAP_DIRECT,		"DIRECT" }, \
 	{ IOMAP_NOWAIT,		"NOWAIT" }, \
-	{ IOMAP_ATOMIC,		"ATOMIC" }
+	{ IOMAP_ATOMIC_HW,	"ATOMIC_HW" }
 
 #define IOMAP_F_FLAGS_STRINGS \
 	{ IOMAP_F_NEW,		"NEW" }, \
diff --git a/include/linux/iomap.h b/include/linux/iomap.h
index 75bf54e76f3b..e7aa05503763 100644
--- a/include/linux/iomap.h
+++ b/include/linux/iomap.h
@@ -182,7 +182,7 @@ struct iomap_folio_ops {
 #else
 #define IOMAP_DAX		0
 #endif /* CONFIG_FS_DAX */
-#define IOMAP_ATOMIC		(1 << 9)
+#define IOMAP_ATOMIC_HW		(1 << 9) /* HW-based torn-write protection */
 
 struct iomap_ops {
 	/*
-- 
2.31.1



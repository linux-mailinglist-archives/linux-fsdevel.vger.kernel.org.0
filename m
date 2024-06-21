Return-Path: <linux-fsdevel+bounces-22103-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D2DF9121B9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Jun 2024 12:10:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F8981C2144D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Jun 2024 10:10:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B28A176FC9;
	Fri, 21 Jun 2024 10:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="NBjVLDYf";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="myzT0TWE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D36C4171E76;
	Fri, 21 Jun 2024 10:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718964449; cv=fail; b=KdLOUPDv1KURjK9JVl3qMomd6OVyWtzJLYwC7G6Gxjvt5WsWAahjED8cI4Z1qP3SFuUAQYO1LHoyQjtKwiGQYWP7fwUhiO+Auwkl0Gtn1q2xtcbWnZpH6Lhnn6aIio/KWGLR8gVHhpK7OdBWVzRrV6q/23KErJshZQjwfUb6xK4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718964449; c=relaxed/simple;
	bh=BORAzsPZWFCDexr/SCcO6Uv8k9eKAHXqtZ0/1ltyM2I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Ocdvj4dC0tKY2bM4idnYGZfiVM8Mqiv3T2WQevMeyzsYkErWt62HGSs2J+c0dlhWouSXqHTt4wNZhtvXnABLvvnAt4gAJP0xPWjm4fRCjKMMYUJLdWtYlbwvC+Jr+Hq2H52/Lw+xXbIpdSAbcmbPta/GghWaeyf4WcGGmNIMMig=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=NBjVLDYf; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=myzT0TWE; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45L7fQ66028586;
	Fri, 21 Jun 2024 10:06:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:content-transfer-encoding:content-type:mime-version; s=
	corp-2023-11-20; bh=OcOCKVnoSPM3ibMtHGFm66gkvo1DZj3ubr/TCYKncI4=; b=
	NBjVLDYfFHwgosep7KDOk1lj3N9SqT8ou9Rh8kpWA87FZn2fF3wygGUvrQhWAXgO
	fnNn011L9P/+TnKfnZGWOnsutmJ1l3S8k2CKa2y2GfG+VNup+PDh64/y/N3tz5mi
	6u3DQzdcBo90Wr8IVl8jrMRxt7Fp34E7ThJt/357Ecg/UtUh2ElQHlH/OuhR2pdG
	AQTDxizy9VFEjOqrFUwKmJMEjLGJ2A2xg75jComk6Sm6nBrIzXJcWEu7wj4jJq0d
	TCwsyBOHIThob8lPcP04zATT29CTxCGAazdZIS84HMz3B0xiHz61Ga19BjGOZDVn
	UZEKnWVC8nwP09Q1lzpBug==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3yvrkd1duc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 21 Jun 2024 10:06:08 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 45L91PTY019521;
	Fri, 21 Jun 2024 10:06:07 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3yvrn3mxst-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 21 Jun 2024 10:06:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RvyzjsfV3xhjIsCXW6QcE2Uc4/+QHG54/x0Px0cU0OUzKv7GSuNR1ru081Yiw7EGc5clENDZd0TGDEKY1NaFp0H5rLPRnm1SYAwcFmzqKNJWCL5wGtKUqZe2mR0vQt2Dkoc2zVeIIqzdYJjQoLIzhYFgeqROFiJE8AnLX69VGOVOLgcx0HZjl61yfOzZetiTVBGZ2rWAmnlVtuiwTDvkO3O7eBBqcY186RLIviFFfK5z+PzRhRgGD2EUYOu0CZKjT/7ZdQFhmlcQq6tSU6/xHAOBm6jh1DZ8sMOm1ugcp+MoRNaexi+jQ870PfRus/GuCYAm+hTM2enmJYZdvkjc9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OcOCKVnoSPM3ibMtHGFm66gkvo1DZj3ubr/TCYKncI4=;
 b=Odvznged+fTpu1Skq1+34svSN5Ezy6YVph/FuWVkoE++l6OAHrGBA0wiRbqvQdWr5eqaWdp6slUWmbjpBrzfIlzekTFmdyb/9XyAc2g7EUAt5N0PTTmQFWhADuzSIMQkSuPYgX+lEp6QGkVxNg0jl+TRStwU/CfSf/1hw3E6EpIbnsYBp2DYQUFd0qaTCUDp/1u0Zekyeg0jILq4xjXU+BRtb52Lna42FIr0RGBQOixucCCeOHf11rYUKlkSHudAtmmU5Wxt9pUowGMtFL5ZoxbKFtSDSwy3tEkZb+gUi/DVCMOUCU3KvN9SyVpUUKYY0vFl1UPXzXl//twk5pgWHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OcOCKVnoSPM3ibMtHGFm66gkvo1DZj3ubr/TCYKncI4=;
 b=myzT0TWE5J78CIE/4vWLw2HGqdLcMMIL4kxqnOPxSoNG8c94/Ep0UsWz91hiFUhNovj2Fkx86Q/jYwN4ThbnZyoCA7t3IzVnc93oMEmbpu2snM1sA8VDEvC9QdA7cqO7AD4D8hhA6hPYXfptgD+h1o60Bay1q1qGky+aa7xZQ0I=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by CH3PR10MB6884.namprd10.prod.outlook.com (2603:10b6:610:145::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.21; Fri, 21 Jun
 2024 10:06:05 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%6]) with mapi id 15.20.7698.020; Fri, 21 Jun 2024
 10:06:05 +0000
From: John Garry <john.g.garry@oracle.com>
To: chandan.babu@oracle.com, djwong@kernel.org, dchinner@redhat.com,
        hch@lst.de
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz,
        linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, catherine.hoang@oracle.com,
        martin.petersen@oracle.com, John Garry <john.g.garry@oracle.com>
Subject: [PATCH 03/13] xfs: simplify extent allocation alignment
Date: Fri, 21 Jun 2024 10:05:30 +0000
Message-Id: <20240621100540.2976618-4-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20240621100540.2976618-1-john.g.garry@oracle.com>
References: <20240621100540.2976618-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR17CA0011.namprd17.prod.outlook.com
 (2603:10b6:208:15e::24) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|CH3PR10MB6884:EE_
X-MS-Office365-Filtering-Correlation-Id: e21a5837-9cf7-445f-c240-08dc91d9c385
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|1800799021|376011|366013;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?ppLC+elCrb6T+5zOS5r67/GTBg0bW/AOLCinR9gOl9mkDOAZgqjB9Xz+ixWM?=
 =?us-ascii?Q?b1lg08Iei8mVVjEfkF2P2HzCJEI1hmUT1qz/1IQ+Zx9HlbFxBXvJj4He8V8g?=
 =?us-ascii?Q?hMhSSAUT/g+wMPcZoFl6dNlJKrBQLR0Y+OW59jLdt9ZTSLz9uYAL1RvWv9YU?=
 =?us-ascii?Q?cCCawwpFtLyq6y3bwhrdPrAOr2j+a2E3qxMv6c9IG7ZD7zp7ZFUYNVI0RdEn?=
 =?us-ascii?Q?a8c6GR1mtbbLjXWaJyDp2oN4ufyljspWLGGNSswSHJlY+LxlI4FNlZpdixHg?=
 =?us-ascii?Q?+AFR3bdEUFu/WoK71MFgmxD8Q2qZm4PCjRP+p4LlJBAFki1In9lIpsjaS04X?=
 =?us-ascii?Q?mfpsL5O4HD5AHy32IlsAzLYHVmeO3caw4/rJ1ks6O7987MxLgnJ30KXa0ac8?=
 =?us-ascii?Q?LUZqM3VWPPZ9TxEVMHu09CLlw2Lfp+M+JKbWVCGMgwf+YMpmOHGbIpbQxNrp?=
 =?us-ascii?Q?qJIOB/aFQP64SxHaICpwQ8D+lCEziZPMMXPVAq5JRcdLIGsOhl2qcOi/cMGF?=
 =?us-ascii?Q?cTz0UJlP1oy/ZehOI8H0KosyXPVvCj4stBBUBF9ieLStbOgsYnDwgG4SI8Ao?=
 =?us-ascii?Q?o98//yQBXgzw3NvxjT6DH75r+u5jPoVByHXFKvoQXixk+WcMstKsIpBUJas1?=
 =?us-ascii?Q?mr+C0h6HV0eZej6VfdOrgdsP62iewvYn/KXJIVcMlzHbCuRsH33YIOuK3xB9?=
 =?us-ascii?Q?0MBU6tQ10V2ZlZKBrSYgzxvbkL99T9JTLd6IhXetncLO7ojT0kUXSVJi0qUH?=
 =?us-ascii?Q?93Au808Qcamw6GwDNwGLFX/hIhI+GdJdz9yB8fGumUF8wV8KnP5MFLx7Ax4O?=
 =?us-ascii?Q?mg4NyQkdmLCXcEH9ihaqR1DtNQvjdvpVHkkPFkzV4RUhqmVnsJXuy4QZgQFE?=
 =?us-ascii?Q?k8ocYJNwYs2UnOvHvDx/cC0WulBc+7AizZCs/n8GVA5YLsUTWuAKNqzPnkYP?=
 =?us-ascii?Q?gzaOndkulUzlDEkfC/voqsjeVuUXdT6n/ebipkVjCj9rFWdjluTLXgOzC/IS?=
 =?us-ascii?Q?LxqLUISIdh7h+2Z/c/Q+wPdTch12uTrtmL5AXa+6Dm1v8z9aVRxp4qmknR0i?=
 =?us-ascii?Q?xbX/IPglV/9MJC9aJ14ulgyUNafIhBH/MzxRClxOOLPFforjf5BYkkU3aSkT?=
 =?us-ascii?Q?/nntXZ4KyfyCHE5zttSbGNTPW+TiCnzUOcKFgOkp7bTfovHzo3/TIpO0QeYm?=
 =?us-ascii?Q?V1dc2mXUGExIgfX7UTo0igvi0JbdHh8x7Q7kAwqt4DkUwso9WKGs9NfVs34N?=
 =?us-ascii?Q?gYtfCp0z/WHvRcRBmAc6qs/LTtoJM5aF9+Rndj96Wg44+wsowVbxBbrIWsA2?=
 =?us-ascii?Q?iW0wL4u05bsrgrT8Wa0PBylo?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(1800799021)(376011)(366013);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?qFOase9+I2jPFVOcVuB2euCfvcy5RgCYB1CV/aKJbcb0zRFuKAUf0C5f6YS7?=
 =?us-ascii?Q?vk0RGKimOJ//3E2rcVd5+RIqx9HEyPL5UgbIYKCPwh4G0Iysh5If71zEBfFv?=
 =?us-ascii?Q?zzjnRdvN0dyPbrkuddJfs4WEyoUbgSdgIf1gl2Wzc9Z7l/aY/JsejgfCsfqc?=
 =?us-ascii?Q?Hq/MvfbjPAQx1qjz/eBpijAhDZ/6/Dsp/wL5sjaHyvuOtdXZdEQ9ja5aof79?=
 =?us-ascii?Q?kvk7O4c6Ku8FmYIKlMctpujtL3TOB90LKecjk4IEQF0bFuGesudb8azCyirZ?=
 =?us-ascii?Q?9Vr8nkrHnIAJWd2S0xpUFBMMXECioUePmbJCID8I38cgw1VF3AidSzu4Lj54?=
 =?us-ascii?Q?B7YLwJ1zY5lsksR1vyO1JT7rJwujtDgECEE8MH51/4iMK3BMjoGLybIZYaXb?=
 =?us-ascii?Q?GUOoLYyOlO2T9JmM4SvtG/kf4ulEUPklic391mNzHTOKpwk+GTBzS5lMZP+U?=
 =?us-ascii?Q?B4Nnhjh1w651VS74zl2oCGXtegZlCrUtlrDmuefTxdrYHUe6wh5692pemSb9?=
 =?us-ascii?Q?TUP4wiiQaB75IRk20jFPK/JkX4wGligIY3UlMFXaO92X5Kdl9ckRhBu+Oiy9?=
 =?us-ascii?Q?WxPYhQNk4faOwLq1h9cNL289yw6pgrdH5MVXmEklQl4qlPBVZ3KIG/0qpPbZ?=
 =?us-ascii?Q?2i6Gbz8fIOySNr1nNT3uzlerEyOY7/hRcWi2C34s2CJcNAAizjJPQRVz8hTf?=
 =?us-ascii?Q?ON+1BWVZiweI9QEAiT0MjyeyNRdZab2NRU1ONBXEXYlIzZtE3T75hjUldzYD?=
 =?us-ascii?Q?fhwSldb/WO57qEYlJrSqCD4CFLMUJRV6NOiO+1kDcJAdXQvhH+eJfSCaHPpR?=
 =?us-ascii?Q?JNoPROH6JobSwstz80RHqavY2XIceBwPFueLWo9xLVFnquFNqIetYjV8ZYc/?=
 =?us-ascii?Q?u5WCV2ld9zRz/0qCID5NWtYaz0cDrgLaaDrybhxO+dRbDkFH+AdxlpPv94kP?=
 =?us-ascii?Q?OTOczp1obSDHkPF7Milv3vcHC7Ws5crrG9Q7ufyviCuTvmU37ddadoEY+TKP?=
 =?us-ascii?Q?16KCf2lLR0Gbg7JsKMyZ2U/7Yw04MKXloccD3yEGfpjkjuCJJqkyreUEldFO?=
 =?us-ascii?Q?Geziezoi7h3fBcHGFmSMiLh+VYaBjVWQFI1omn9Lff00QOkIE7rhtwZK/Yl3?=
 =?us-ascii?Q?u2ELCUAeXq3oh96iFyciODGifOKYBhSp8JTNOBTsVeCfnhAhGcvL0TqAPX0i?=
 =?us-ascii?Q?tvAKAqTyYTKDPyymtLwA973iPRN0WpbhKtP8jAl117T4KSDchIpiiot6TEdM?=
 =?us-ascii?Q?Uct1nBVdXV5P7jZclHDjgP9Q32F1rFc5tAHAclJGewfqwi5bRuGD6vKbslOQ?=
 =?us-ascii?Q?vUgnel4Og4S05gRYPblJXl3yh3/yPtFVJZ3fXXjXa/zbC287ZdlzJQs04+qv?=
 =?us-ascii?Q?YY7EDoIVbql5YMKUTXm7mTynoIeFVDSAq5GpaF3ik8yShZmkCyz4wjzAIENN?=
 =?us-ascii?Q?noSatmKtbkIeqFjKcZ8N+DXVuuEL2ZjBfWpFC0nB6HoxH6Wk2tOHlbDb4dHi?=
 =?us-ascii?Q?BP27qcTMY3NfxYtuvkk45KcY3BcUg7tOaZ/fINSM8aE9zbkvoPVUsOeqyjVu?=
 =?us-ascii?Q?VN2KfKKOY8y6WN6GTMTT79E3Jha1MwXNIgW4d3EsnmI7r1RTgIZkGR+CSAvl?=
 =?us-ascii?Q?aQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	vZn8QILOL4rrgjK6QJhdmbLic0tbZFHt+rwFqFZ+1lYltihvo+1MFIFS8zi2eHGRCgvcdntpM9/nBcSQds5GfChgigOxfo/HPv51CnXA1MBbUUrBWvSKoyNhjWWcyTEKDp5MbcMqcQR1aGQGeqXfch8dCGGf57SyZny1CWkU/q5IidatIPjosqqMx2l74Z0nTetM/sJK5hWdvUGrsThXLrD3bl3ecPGxqblSLUzKO6sdFTLtfeSgdJb9B72sjkfgbSmD0h0WC5IHTQIwQnLQGOBpK+e/165BwgIbmRVQTwVlG9jdGbsp/b0+Ys5yeUn1H16DXy8AfnM8GBj4NSzc9MLh3eADgFaeQ3BhRIESfUcYFAQ308xA/UistAaFRoOhVYk/gfUFkTsw9Q3m4S4RTFTRPCfOr/r+tH0lZS1CpBqbuuhtdwORc60QT1tPqj1USRp5GtSxKkTDBrTxR9erUT2iPU+lLAwLE4wpnZy6JdDlm2cdvtzPpRppN5WrMnN2ffV9hwLwaEcj3yKZYhGNDTVXNspLx2fIrNU0/7xaKg18IgUTmtCMVxs5nPTkSnAGdQdtvoTTiAuEhG8bauMs/be9CNjUn6lu2j2h4GaVpDs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e21a5837-9cf7-445f-c240-08dc91d9c385
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2024 10:06:05.5040
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Aw4f/IIsRFaeW7oXE/apXeSfEaT6UEM4ZgU0QB0Rgsfn3ezInmcnTsuGmsDu0kseJf9x6jm2ngE+yLw90XHVyA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB6884
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-21_04,2024-06-20_04,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 bulkscore=0 mlxscore=0
 mlxlogscore=999 adultscore=0 spamscore=0 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2406180000
 definitions=main-2406210074
X-Proofpoint-GUID: Y7qy_cZFXOKaJshye27Z_J_nudRr8kLV
X-Proofpoint-ORIG-GUID: Y7qy_cZFXOKaJshye27Z_J_nudRr8kLV

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
[jpg: fixup alignslop references in xfs_trace.h and xfs_ialloc.c]
Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 fs/xfs/libxfs/xfs_alloc.c  |  4 +-
 fs/xfs/libxfs/xfs_alloc.h  |  2 +-
 fs/xfs/libxfs/xfs_bmap.c   | 96 +++++++++++++++++---------------------
 fs/xfs/libxfs/xfs_ialloc.c | 10 ++--
 fs/xfs/xfs_trace.h         |  8 ++--
 5 files changed, 54 insertions(+), 66 deletions(-)

diff --git a/fs/xfs/libxfs/xfs_alloc.c b/fs/xfs/libxfs/xfs_alloc.c
index 32f72217c126..35fbd6b19682 100644
--- a/fs/xfs/libxfs/xfs_alloc.c
+++ b/fs/xfs/libxfs/xfs_alloc.c
@@ -2391,7 +2391,7 @@ xfs_alloc_space_available(
 	reservation = xfs_ag_resv_needed(pag, args->resv);
 
 	/* do we have enough contiguous free space for the allocation? */
-	alloc_len = args->minlen + (args->alignment - 1) + args->minalignslop;
+	alloc_len = args->minlen + (args->alignment - 1) + args->alignslop;
 	longest = xfs_alloc_longest_free_extent(pag, min_free, reservation);
 	if (longest < alloc_len)
 		return false;
@@ -2420,7 +2420,7 @@ xfs_alloc_space_available(
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
index c101cf266bc4..7f8c8e4dd244 100644
--- a/fs/xfs/libxfs/xfs_bmap.c
+++ b/fs/xfs/libxfs/xfs_bmap.c
@@ -3285,6 +3285,10 @@ xfs_bmap_select_minlen(
 	xfs_extlen_t		blen)
 {
 
+	/* Adjust best length for extent start alignment. */
+	if (blen > args->alignment)
+		blen -= args->alignment;
+
 	/*
 	 * Since we used XFS_ALLOC_FLAG_TRYLOCK in _longest_free_extent(), it is
 	 * possible that there is enough contiguous free space for this request.
@@ -3300,6 +3304,7 @@ xfs_bmap_select_minlen(
 	if (blen < args->maxlen)
 		return blen;
 	return args->maxlen;
+
 }
 
 static int
@@ -3393,35 +3398,43 @@ xfs_bmap_alloc_account(
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
@@ -3436,7 +3449,6 @@ xfs_bmap_compute_alignments(
 			args->mod = args->prod - args->mod;
 	}
 
-	return stripe_align;
 }
 
 static void
@@ -3508,7 +3520,7 @@ xfs_bmap_exact_minlen_extent_alloc(
 	args.total = ap->total;
 
 	args.alignment = 1;
-	args.minalignslop = 0;
+	args.alignslop = 0;
 
 	args.minleft = ap->minleft;
 	args.wasdel = ap->wasdel;
@@ -3548,7 +3560,6 @@ xfs_bmap_btalloc_at_eof(
 	struct xfs_bmalloca	*ap,
 	struct xfs_alloc_arg	*args,
 	xfs_extlen_t		blen,
-	int			stripe_align,
 	bool			ag_only)
 {
 	struct xfs_mount	*mp = args->mp;
@@ -3562,23 +3573,15 @@ xfs_bmap_btalloc_at_eof(
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
@@ -3596,19 +3599,8 @@ xfs_bmap_btalloc_at_eof(
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
@@ -3626,9 +3618,8 @@ xfs_bmap_btalloc_at_eof(
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
@@ -3636,7 +3627,9 @@ xfs_bmap_btalloc_at_eof(
 
 /*
  * We have failed multiple allocation attempts so now are in a low space
- * allocation situation. Try a locality first full filesystem minimum length
+ * allocation situation. We give up on any attempt at aligned allocation here.
+ *
+ * Try a locality first full filesystem minimum length
  * allocation whilst still maintaining necessary total block reservation
  * requirements.
  *
@@ -3653,6 +3646,7 @@ xfs_bmap_btalloc_low_space(
 {
 	int			error;
 
+	args->alignment = 1;
 	if (args->minlen > ap->minlen) {
 		args->minlen = ap->minlen;
 		error = xfs_alloc_vextent_start_ag(args, ap->blkno);
@@ -3672,13 +3666,11 @@ xfs_bmap_btalloc_low_space(
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
@@ -3697,8 +3689,7 @@ xfs_bmap_btalloc_filestreams(
 
 	args->minlen = xfs_bmap_select_minlen(ap, args, blen);
 	if (ap->aeof)
-		error = xfs_bmap_btalloc_at_eof(ap, args, blen, stripe_align,
-				true);
+		error = xfs_bmap_btalloc_at_eof(ap, args, blen, true);
 
 	if (!error && args->fsbno == NULLFSBLOCK)
 		error = xfs_alloc_vextent_near_bno(args, ap->blkno);
@@ -3722,8 +3713,7 @@ xfs_bmap_btalloc_filestreams(
 static int
 xfs_bmap_btalloc_best_length(
 	struct xfs_bmalloca	*ap,
-	struct xfs_alloc_arg	*args,
-	int			stripe_align)
+	struct xfs_alloc_arg	*args)
 {
 	xfs_extlen_t		blen = 0;
 	int			error;
@@ -3747,8 +3737,7 @@ xfs_bmap_btalloc_best_length(
 	 * trying.
 	 */
 	if (ap->aeof && !(ap->tp->t_flags & XFS_TRANS_LOWMODE)) {
-		error = xfs_bmap_btalloc_at_eof(ap, args, blen, stripe_align,
-				false);
+		error = xfs_bmap_btalloc_at_eof(ap, args, blen, false);
 		if (error || args->fsbno != NULLFSBLOCK)
 			return error;
 	}
@@ -3775,27 +3764,26 @@ xfs_bmap_btalloc(
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
index 14c81f227c5b..9f71a9a3a65e 100644
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
index 25ff6fe1eb6c..0b2a2a1379bd 100644
--- a/fs/xfs/xfs_trace.h
+++ b/fs/xfs/xfs_trace.h
@@ -1808,7 +1808,7 @@ DECLARE_EVENT_CLASS(xfs_alloc_class,
 		__field(xfs_extlen_t, minleft)
 		__field(xfs_extlen_t, total)
 		__field(xfs_extlen_t, alignment)
-		__field(xfs_extlen_t, minalignslop)
+		__field(xfs_extlen_t, alignslop)
 		__field(xfs_extlen_t, len)
 		__field(char, wasdel)
 		__field(char, wasfromfl)
@@ -1827,7 +1827,7 @@ DECLARE_EVENT_CLASS(xfs_alloc_class,
 		__entry->minleft = args->minleft;
 		__entry->total = args->total;
 		__entry->alignment = args->alignment;
-		__entry->minalignslop = args->minalignslop;
+		__entry->alignslop = args->alignslop;
 		__entry->len = args->len;
 		__entry->wasdel = args->wasdel;
 		__entry->wasfromfl = args->wasfromfl;
@@ -1836,7 +1836,7 @@ DECLARE_EVENT_CLASS(xfs_alloc_class,
 		__entry->highest_agno = args->tp->t_highest_agno;
 	),
 	TP_printk("dev %d:%d agno 0x%x agbno 0x%x minlen %u maxlen %u mod %u "
-		  "prod %u minleft %u total %u alignment %u minalignslop %u "
+		  "prod %u minleft %u total %u alignment %u alignslop %u "
 		  "len %u wasdel %d wasfromfl %d resv %d "
 		  "datatype 0x%x highest_agno 0x%x",
 		  MAJOR(__entry->dev), MINOR(__entry->dev),
@@ -1849,7 +1849,7 @@ DECLARE_EVENT_CLASS(xfs_alloc_class,
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



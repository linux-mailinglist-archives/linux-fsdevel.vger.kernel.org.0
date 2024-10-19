Return-Path: <linux-fsdevel+bounces-32417-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E3C7C9A4DE7
	for <lists+linux-fsdevel@lfdr.de>; Sat, 19 Oct 2024 14:52:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5ABF81F268C6
	for <lists+linux-fsdevel@lfdr.de>; Sat, 19 Oct 2024 12:52:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D484E1CFB9;
	Sat, 19 Oct 2024 12:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="TNp7hxSz";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="LC+GwcoK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E244B7485;
	Sat, 19 Oct 2024 12:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729342315; cv=fail; b=ZYVMpMmLDyPDIa8EuemU+i5WnnkHGRSd8RE0J9MJrIX1K1+PUysIyeOatlbOsGcuihtEXAdFUIuUyxKMTN/x/Eyvk/YK1EAD1hBPa5T0wJbx9MoGrMgwQX8zld19IbBIrxAwXvEZ7z0l6w2PLBvomaMeyaM/POnT39Tb+BHLnnE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729342315; c=relaxed/simple;
	bh=HRAzBXXkOvnnD3DO5apdwEHJcUieyFgKnpabMqqV1jA=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=ocKPgOsd42AqvBikaEtIEoLfKoJuhTk1Tjewy0RbrMf/MCT9bAX6nMt1iTgNilNwTIIrihEEgQCYpJEDLyY3k6CjLBM1thITRbCVSvuYsdkAC68k8+QTX31VECAFt3d9mp7B7vM7DuTXnUiWLliSoXE1Xp8k9LpPBFCezk4zGzs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=TNp7hxSz; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=LC+GwcoK; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49J6fGRf001909;
	Sat, 19 Oct 2024 12:51:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2023-11-20; bh=KTtSNlsSWyky7B5B
	ea3QF5hv3qLwx4eL6+CpptOXu6A=; b=TNp7hxSzpLGwgeWFbLfbVJsmgfrHOLif
	szTXY7isFdIfk1iz4QD8eHW0YLDV/I3QckVq2rYF3sb1BBUNBq3tJ5zw8Ftq236Z
	fPXlb5l1tzshaxwTA7yrPYFrrliVPpk0V4qO2rE9cQd+as5E6ZL1yck8J7cM49MP
	JjpRaXtHq+PX3m8JtI5ymrzdL70hcuMcp97DTMBWtFT0uoZ9SEbAd3qS44SiAr4p
	q0xAJM2zzyiefPwAWzOgFF6ZJsS6OLQT5BH1Pviyp2vL9IYGyDDbZ3PLx/SO0E5E
	2J2UHm8hv1SKOtQeMrGjHJ23I9yZqUwvw2Bupny+DA+bJ3JS9Lh0vg==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42c57q89j2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 19 Oct 2024 12:51:26 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49JBSCAa026309;
	Sat, 19 Oct 2024 12:51:25 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2177.outbound.protection.outlook.com [104.47.73.177])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 42c374ssae-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 19 Oct 2024 12:51:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=edjDoV/D/pasTuHLUDuHIBxWBfFT1tfAcfbcg6m0DMaEBE8YLsTI4MdfPThqsFsDEa6o7RRklAFM5nPu5FgNPOgh6RyyE9Ette4vF8hU8vh+ovWVYZu/6pfAVfvEOVmvqCmVs8uxiVQPXZlKutzDRlo1Dm4EicYKGB4NktgKGioNU7TKvFdyVa0+0rNSWbBnIkyfqZgNvCCMsei3C5mZDsqHW/H4W/D1j+TYdGNvDCuPnxaDEIVu3NHYe24hVRNfDTsCBivAr2UkemaRZecYDyFqS9+Dxl54jDoxKZ8plAYiezPnuYxKiKLQ1fhgNYr5Gdhj/UYDROCGn6tLXybUsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KTtSNlsSWyky7B5Bea3QF5hv3qLwx4eL6+CpptOXu6A=;
 b=Vo0Y8FcUWnJFtR5hdwPKtEcFZoRu6fJwhwiwdiCn3rFKq/nymCgT3gN6hFFGthJJuZPfoHUMoS7V4CsAJwZ1wtTlMnY89QPxig3sUJMLSOuVDCNTv5/BXewcxsx0l0dNPjwR4hPTlEnQnW9eAyKyfPJ50alsKIS31z9xsh/rQMimoCQRksVgBm6PsWcf1m4BCWLL+GHNABG/0qpcJieD/tSq0hAHMrE2HF0lXSXkFK+G5gn6933GLyLnqC7BU/IuC56zLWeRIVjkQScPIS99O+UeGml1DlaH+4gbHbbIWVsK/V6fBmsxj6lHo/tKUTPaIf8VQ1i/4E4YgtFBn8Jqgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KTtSNlsSWyky7B5Bea3QF5hv3qLwx4eL6+CpptOXu6A=;
 b=LC+GwcoKBksBw9cTzyeVc3eA26psSMuQ1aCc6IZ99rUrf++hmgLfIboGAx+BVDPdQpkrP51F1h2E0HsL6pGjvoO/gCUj0budLPnLwPyiLDc/dGKqE4NucTAF09LuHyoebN5w2BQffct0rZxjx2LZFzC4xwISY0DYX2oOAajoJ1Q=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by PH0PR10MB6435.namprd10.prod.outlook.com (2603:10b6:510:21c::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.18; Sat, 19 Oct
 2024 12:51:22 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%5]) with mapi id 15.20.8069.020; Sat, 19 Oct 2024
 12:51:22 +0000
From: John Garry <john.g.garry@oracle.com>
To: axboe@kernel.dk, brauner@kernel.org, djwong@kernel.org,
        viro@zeniv.linux.org.uk, jack@suse.cz, dchinner@redhat.com, hch@lst.de,
        cem@kernel.org
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, hare@suse.de,
        martin.petersen@oracle.com, catherine.hoang@oracle.com,
        mcgrof@kernel.org, ritesh.list@gmail.com, ojaswin@linux.ibm.com,
        John Garry <john.g.garry@oracle.com>
Subject: [PATCH v10 0/8] block atomic writes for xfs
Date: Sat, 19 Oct 2024 12:51:05 +0000
Message-Id: <20241019125113.369994-1-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1PR13CA0320.namprd13.prod.outlook.com
 (2603:10b6:208:2c1::25) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|PH0PR10MB6435:EE_
X-MS-Office365-Filtering-Correlation-Id: ce4e209f-30b1-4e43-a9f0-08dcf03cbc22
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?EE98wsK9Y9JOQ0x1G8wdXbGiRyN8ttr9iNfjcQ3pMT0m2kDsM2Djr10ONaZM?=
 =?us-ascii?Q?jjvafoPAQ67SlbwZTxQhIq0tHzGyvm2sAAjA+bXpFm5VUFbe+IQYsnDRPjkg?=
 =?us-ascii?Q?dFoB6EYoF1k+Rh1R5Ce6vV9wINs3HOv+G38FuwJPDUKYTWg3S3arZgkLfkI+?=
 =?us-ascii?Q?PnPOLgQOw0/KIA0F1sFxYwVZUBpRK7r8mWx5aEpNHHSISjjHCa3bVZludm2u?=
 =?us-ascii?Q?1lZXdD0Szfdhf2nAcOOLRDk5lzu2WQg0FpkYgoMEbskO3+Vz7Z0iOeKSLJEa?=
 =?us-ascii?Q?WhwrcvbXa9Ncw7EgOQhGArznsnMTOJ97WQXiL/DycmaZ1Raf4s9WHVCGwX5P?=
 =?us-ascii?Q?vnBVtwFaGl0webt1G7nos5RlHNx1nWhX7OCumvvZAJXXGeEQctBVBKqWZEy4?=
 =?us-ascii?Q?iFILlFLZvRlUlBQhpA+wi50JEzwh9hsz10Q0jIvCJwES4LWUPqd2S3Z/Qj8Q?=
 =?us-ascii?Q?cqEkGp38mMsYgnsaJDfFGHndOrGaFmHc2yX8YkahrdVmIiC/smmeSChSYCoe?=
 =?us-ascii?Q?EXNRCt03VAB9r5+xFXOMEyUn3ii6Mnqqjqfey4lc4lDjGsrVjur7GyCQ3hOX?=
 =?us-ascii?Q?34WC27e+rE62ZBSvL9uwpwkvGag1CrDv30wHGMutcLkE9jlRZnoreVhFgvKz?=
 =?us-ascii?Q?bRdODasD+iBAADUUDYox3WDbeck1uL3e1aa6x3nl5L4h4mYef8UzsrNKKLyk?=
 =?us-ascii?Q?ifKtc0Bc1IlWnKbLcGkUPkprDQYsPuLGtU0YVb706Jd7MYMpiYXPaDqnYCUV?=
 =?us-ascii?Q?Ais6CnNrI/2pMRIAjQLcRE89ICU2L6Djj5HFwQNlIqOXOddxr1K/BtorJlXJ?=
 =?us-ascii?Q?qItgqHiQ44LDkDyK7lHOldGAc40co1e/QDwUeN65Olh5Jz1Zo+Ay1lGOBkeh?=
 =?us-ascii?Q?NA+Dp58PWbK3RrrJUx/Nw2cfu/bQ5g82tkEx8pnw61V1W4jomKlR0nAnpA5Y?=
 =?us-ascii?Q?K2lelhCK38rH3BSEOvcptzBeqA0jXH/afGSsecD1OrvRG2r93gVMJthKUT3f?=
 =?us-ascii?Q?U/bnVZy5K7+cYnZYNn7scyhGkhAXPNbVSqHs7nZk0+Jxg7npC/ev92qsRtkU?=
 =?us-ascii?Q?dgI2gDQQsdYEFL8WiizvO4YiSCnZvYcK6I9EelhpGg6KP/Z9f+KStOLCg8tl?=
 =?us-ascii?Q?fWSZDPBhpK4mYsyvmHoJwoMRPtR54BIQ313mhdGeTR/lNIJqeQrKfsqaEdVs?=
 =?us-ascii?Q?DqK/erNzwSUGhUMV4zS/Qp9yEwu1BwSt/8SP1Y+JT99rluQvUdoMUw3KUiai?=
 =?us-ascii?Q?F9+A78d47ZoMKoFRSC4Ph8MJ3mzWGfXq7Y0M3YKmB7nJ6eLpvGyD1PLVjAxp?=
 =?us-ascii?Q?vOsD5E11jd7BP+BaC9QGIu42?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?sg0e3m2xWfQ31YEv6hT5ZJCLVixUDFsmvAEeb7XhNLJxTG4g+CwpGtAVyH3G?=
 =?us-ascii?Q?PNY3N/3yl8U6p4dL65F9W5gUCr39L1qXZpXOWpfG8aMI+W5KOP2VBEwE89PT?=
 =?us-ascii?Q?CBXDEsIlMWb1geyj/hEkYjttjcyIkZCZkMYUvHRQaCpC71OA0DI091FAETM1?=
 =?us-ascii?Q?xksqwBfD4Dxu7leSSettAiOyEpTeSBolwu2/3RnUDQLKfKVHQkRlPC6WYsa9?=
 =?us-ascii?Q?q13d6OZA5N7vtw30/G1FtvlKLh4T3ENwxl2xshggtAA3V5HhwwbvuiiU+5T2?=
 =?us-ascii?Q?t2uzmsZaw41tYVa9ytIO0+KsT0FnartiYENBp7qR+4/licthYI8g7tiiMy8u?=
 =?us-ascii?Q?S8jC3ff1w/5EPZvM2PGC4Nwrg5nh5Yiyl96DtBQgyK8YQ12UlGUVlWEKzRzZ?=
 =?us-ascii?Q?5+wYEUyIEhrSakwW84dEyJhpSqGRaJnLWKANVykoUAwUrzQI249wHrAtlj8c?=
 =?us-ascii?Q?lE/cfbtF+4iXBROo10rlF3wK0CiLhlKum5gUfh0Rxnc9e9iKHW1ZHGkXkch1?=
 =?us-ascii?Q?YubcBsPj9seDbJlDfs5nr/qq73IDFIa1WNP07438ybAyb3IHgbOkWlN4CJZ3?=
 =?us-ascii?Q?LMYxT4r9B681SVjs4k3Ij8OorDBBGFf1PMOs2WBuoBK6MMC1sXPlzQYbLjqo?=
 =?us-ascii?Q?bBMSV8cXeIi7c+69Hq4KIp4fWc/O86dQKIHQxsXh8vlFBONkoPJdOAuMT+sA?=
 =?us-ascii?Q?WoXImcSVBnV2EOLT/ahvcXy2OmXRfQpMEv/5kHpI+ugXKw1mvi4UlLUSH3QT?=
 =?us-ascii?Q?mycfIzP92hprQ8pRzqjivDPzQpAP7CNVBCleS2B7RS4g0KSHWDnDI0Ban9TP?=
 =?us-ascii?Q?FV/38zx6rU7GaQKp6lWxlh/WkUBlm3a4wYd+MkfC8itrNgoh1PKgF6xegMU+?=
 =?us-ascii?Q?l1qRlGTf81HZkx4BWwbMQOwV70AFuzaqvFEFgts3bx7H37n6TjY1/6aPOaJJ?=
 =?us-ascii?Q?/O9PgOmQevI40EvFbgQWL5ljldejX+tinF1x+9OsrhPaHfK3Kv2wGdHoZQuX?=
 =?us-ascii?Q?qri83Wis4JFKj9hnGPzMsQS8lY7sMAZr+zYO5jcW4WMA2oHB4ymCr2okbcgB?=
 =?us-ascii?Q?XUX+MHuupGzItAuXXm3xV9mCdvi2uH1dQ1HaTBDIw7qnHFXPn6ccU5cV2Rm6?=
 =?us-ascii?Q?CzUKfsQmNIRRo0ElGiN+9T/mUEE7apurEFf6QWRg8+K+444r0uikIpXK9Jiu?=
 =?us-ascii?Q?tWGagWDiEeeTWy3CLAiJLwcGR4RI7M/cDe+NqQBg2Pl/SIXl+ASfAQEi5kwv?=
 =?us-ascii?Q?lVt60oot8215lZxqTkWdPJZvQD5wUVUZ6R/3EV46ToMehuJgjeHUl1WREU94?=
 =?us-ascii?Q?i90QvjJTO2u4xbmzBPdDgV3PqvUKCBrTAu4tSSiY5kx2xTY5+TL7rnTA+tNE?=
 =?us-ascii?Q?YwddJgqWzXAbDHGVoqdGNhfvC42ec504GF7fl12LF8Iey2y4yTJnCAichyGj?=
 =?us-ascii?Q?69a99IHV4cy9MyvmsvDXNw5PoEoAVIqfgFZ8TqjbxT1IwqZe/oZmtsgnxP7T?=
 =?us-ascii?Q?MJXu4AWjWleYCZALLRtLKDYKcTaCKumktcxBeyjXGnqWHjRj+HYJunjkq/Mi?=
 =?us-ascii?Q?ZGx3BBligKtEz90+PRti3xBTLGGHm9YB2g6sSB+hP+p8FyMQJx7yNx2V2eUw?=
 =?us-ascii?Q?4w=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ztd7b4KwQhlw96CBkVUOI9N+xqdTNrRKfJs4g5mu9QOb3xx0SprcHtcXykiqWIu7JjKGUPFnu1w1Aw5/YbwZNcvqxTWfgmYSb3frD1FieivajhBqq17ny/knCDfTY+017cZ3YZHMKuxliTABeA3M3KsKYgl1c9xxnngC5Jgvhv8SScCIHnj+JsQihT+cEWnzgpK5eDLALwVr+GR43Po8sml6jQpZxf4xnmLR7A3McgDvIdYiDqJqgqKgE0uzrc+XmblHoE3KEj9ObNwcjqE0ZBv2DqfhWMOyaxpcf8CweIlFAEJmslylnq7GZtba6rc8m3FvL+84kuz9pqcjRHXkNZ8klyv4N77Wpd8Y8bd7ZqvDBU0u2GLQYyTGpwfZFqtYdgmp22kXsezxO4L/K/WqiCd8KW7r9kVkuAeYvdH+q1mHFZsxUNgAitls0Jlx+dkYPu6equ03Oau3LfGDq0UcnsqmD4GZj9FsK9Oa1NNYkxZL7/vDam9Nku9uXYj5HchAxRiimIjCByrjQ1oHctlkrNo/etjjFd3q8FkmZPsmqhRdtsAHyRomuzwSEcFt55BlZQeMMewokaQ9zmB3+dR9RwFE6CV91Gmda5HVCVuDLM8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce4e209f-30b1-4e43-a9f0-08dcf03cbc22
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2024 12:51:22.6215
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f6RtBtcKoDjkOJn0M3hMY6TtM3sOx6aafEP6+C6n6VNuBXrwmV6Trygq6DIB/yCsv3w9x167CEhPiP4STpCmHQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB6435
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-19_10,2024-10-17_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0 suspectscore=0
 spamscore=0 malwarescore=0 mlxscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410190094
X-Proofpoint-ORIG-GUID: ut-XUS9-o4n1QWqhGP5rzqEwFEU2e-ua
X-Proofpoint-GUID: ut-XUS9-o4n1QWqhGP5rzqEwFEU2e-ua

This series expands atomic write support to filesystems, specifically
XFS.

Initially we will only support writing exactly 1x FS block atomically.

Since we can now have FS block size > PAGE_SIZE for XFS, we can write
atomically 4K+ blocks on x86.

No special per-inode flag is required for enabling writing 1x F block.
In future, to support writing more than one FS block atomically, a new FS
XFLAG flag may then introduced - like FS_XFLAG_BIG_ATOMICWRITES. This
would depend on a feature like forcealign.

So if we format the FS for 16K FS block size:
mkfs.xfs -b size=16384 /dev/sda

The statx reports atomic write unit min/max = FS block size:
$xfs_io -c statx filename
...
stat.stx_atomic_write_unit_min = 16384
stat.stx_atomic_write_unit_max = 16384
stat.stx_atomic_write_segments_max = 1
...

Baseline is 77bfe1b11ea0 (tag: xfs-6.12-fixes-3, xfs/xfs-6.12-fixesC,
xfs/for-next) xfs: fix a typo

Patches for this series can be found at:
https://github.com/johnpgarry/linux/tree/atomic-writes-v6.12-fs-v10

Changes since v9:
- iomap doc fix (Darrick)
- Add RB tags from Christoph and Darrick (Thanks!)

Changes since v8:
- Add bdev atomic write unit helpers (Christoph)
- Add comment on FS block size limit (Christoph)
- Stylistic improvements (Christoph)
- Add RB tags from Christoph (thanks!)

Changes since v7:
- Drop FS_XFLAG_ATOMICWRITES
- Reorder block/fs patches and add fixes tags (Christoph)
- Add RB tag from Christoph (Thanks!)
- Rebase

John Garry (8):
  block/fs: Pass an iocb to generic_atomic_write_valid()
  fs/block: Check for IOCB_DIRECT in generic_atomic_write_valid()
  block: Add bdev atomic write limits helpers
  fs: Export generic_atomic_write_valid()
  fs: iomap: Atomic write support
  xfs: Support atomic write for statx
  xfs: Validate atomic writes
  xfs: Support setting FMODE_CAN_ATOMIC_WRITE

 .../filesystems/iomap/operations.rst          | 12 ++++++
 block/fops.c                                  | 22 ++++++-----
 fs/iomap/direct-io.c                          | 38 +++++++++++++++++--
 fs/iomap/trace.h                              |  3 +-
 fs/read_write.c                               | 16 +++++---
 fs/xfs/xfs_buf.c                              |  7 ++++
 fs/xfs/xfs_buf.h                              |  4 ++
 fs/xfs/xfs_file.c                             | 16 ++++++++
 fs/xfs/xfs_inode.h                            | 15 ++++++++
 fs/xfs/xfs_iops.c                             | 22 +++++++++++
 include/linux/blkdev.h                        | 16 ++++++++
 include/linux/fs.h                            |  2 +-
 include/linux/iomap.h                         |  1 +
 13 files changed, 152 insertions(+), 22 deletions(-)

-- 
2.31.1



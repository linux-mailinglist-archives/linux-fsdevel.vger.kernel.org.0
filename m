Return-Path: <linux-fsdevel+bounces-13196-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 60C6A86CF32
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Feb 2024 17:31:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 842BC1C2351D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Feb 2024 16:31:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A489A160624;
	Thu, 29 Feb 2024 16:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="nKGQV56q";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="PnDIAN/q"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE1306CBEE
	for <linux-fsdevel@vger.kernel.org>; Thu, 29 Feb 2024 16:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709224120; cv=fail; b=UGmHSN7mN96xB/0Ci0p0RlfWPMSsUuKQR5qRoA5nZRWy/nIG9SAdy/5MAo1U0juNFqdlM8BSa1/ZUBvyy/BvjCz8fMgScbOk7GSP0bD3pa8S4KZ8+CYMQbNMdDWuWXjGjmaRcI2VqHvXKXgUAsf37BoDAXgnd1ZrcDV9WJ/Yqls=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709224120; c=relaxed/simple;
	bh=8nqak3Ik/nPisqZvQfoIw/TQp3k4XCgwCVaSuRgMR/w=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=RlJyCNh8jSVn67h8zDoshKwetSmsPDLKxGPwhac6gjv7SUEd4gbbrBnsz1m1x0GRpKHDfR/IfkVW3cTlxZAFd1Tw3p+PpThG1h+AM/E0MnCvqftEfuGT4S0A5Ibl4huN/Cakv9PjK0PTq/s9chR6GUPkpxkLFd4Lypzgah7i8BU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=nKGQV56q; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=PnDIAN/q; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41TGERMZ009332;
	Thu, 29 Feb 2024 16:28:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=l+/QBxWpEJ2wGf/ha5cPC7JJHzZnOgPF+Jd8NaiIs2w=;
 b=nKGQV56qdKsINIH0rZL/OJXBRfxtrhvNLSDMRQPeMdMX4DHLk1tBhkcHhQP3lF32BDwf
 ra1VbVfdoeavCiWur8AGnVslj+KI6pO1KLL77y1R33vr0033zK20a0vz56Og8GpRb8ts
 YOXLMWf40NK3hO/aCwVt72DcS50iJuFedMVJCHjbgtKhaz2A5IoitSPvuEH0ETDcnEy4
 JgTz+ylcXPB+gqnlSPwhmPlPELgEbNdozvbMv3FqleF9Aawl7m70UqtY+JqXu59Icukh
 kIRY/SzshYN5FDn6C5XIpnGnOV67gBbA5NBDgD9SfEts+6lzS8jPEKgDQLbUyrPaiWQI tw== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wf7ccp5yp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 29 Feb 2024 16:28:27 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 41TFaeV5004795;
	Thu, 29 Feb 2024 16:28:25 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2041.outbound.protection.outlook.com [104.47.57.41])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3wjrq6dye2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 29 Feb 2024 16:28:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RUqVbdVrq8nrsxdMPiEdHXOXbWwwub0mJvnfyGgMk9WeTzhRqvlmoRCPDeogCMorTj3mdUTSZGkDyF/VuXqpOMlMmJ5MKPur42b1t/W8Fk/mLsTgbF2PcxIfA0l01gcFbe0M1DWJlYPjfoh02wnFpFg/BKgqWRLV3Tp1QSy/rGC2SRpV0BJpLs2xZSRna5zTlkw8oYv+JAcGYYUJqlfFWNx9TqpGKItEugACv9nWNMGwp8j1czL85LWzSqFk03T02gi/Kg7I1WrjLd6pTImavxtbmFttthv962R/WC5S8R+T0tLsyAGhNfVlGeVPxx/mlcBjCqahLMkdWEulQHTTiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l+/QBxWpEJ2wGf/ha5cPC7JJHzZnOgPF+Jd8NaiIs2w=;
 b=FSxJQkCW07WMsALTae17250rweGzCB15dbfJ5rQ8pCwYZQW2090RLuwmEbt/npGH+1BtAMFzoNOB+9nPhj0lcozTwK/SiugUvGmwizEM3VyXLeS2bKE7ObI6c4JNK9CwMiJi0aGpmthbT6m1tO/kNo3OMkSua1aP0tQTFfb7dUBBysRfPWmPGCE2n+5V+cguNniLq9LuR5RhefihqLpPJVV+HGnI6rMpP/kahj0NvfSaE1hqEhItzveHV0TFFgCTINiQpmp+K0zGLpKZCoxL8tY/AJ4WhS9X1en18xTiQPVLaUSsKg87QCnfdf+hG6WHCSzFxUYXmXks+8NTsMzQ0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l+/QBxWpEJ2wGf/ha5cPC7JJHzZnOgPF+Jd8NaiIs2w=;
 b=PnDIAN/qtm2FuXo3dyrhpVjLmN9CvA42ouOcYjWck4gSXie8qiiTjTO1S9dk1FAAFbEWIfsVx1x0v3j2FyoqVCOO0LPGFvUv2NEkBURloAwc+ezQcCAYSIshp82N7XIOUEjmczG2TcpQHv91sT4rX4wQ6koQULjmPCbA/16KYfg=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by SJ0PR10MB7690.namprd10.prod.outlook.com (2603:10b6:a03:51a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.24; Thu, 29 Feb
 2024 16:28:09 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::97a0:a2a2:315e:7aff]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::97a0:a2a2:315e:7aff%3]) with mapi id 15.20.7316.039; Thu, 29 Feb 2024
 16:28:09 +0000
Message-ID: <c909dbe7-a6d4-40af-99a6-2b27a2dbb27b@oracle.com>
Date: Thu, 29 Feb 2024 16:28:05 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [LSF/MM/BPF TOPIC] untorn buffered writes
To: Theodore Ts'o <tytso@mit.edu>
Cc: lsf-pc@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linux-mm <linux-mm@kvack.org>
References: <20240228061257.GA106651@mit.edu>
 <b184a072-86ef-462b-a6da-c2537299aa59@oracle.com>
 <20240228232415.GB177082@mit.edu>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20240228232415.GB177082@mit.edu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P123CA0066.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:153::17) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|SJ0PR10MB7690:EE_
X-MS-Office365-Filtering-Correlation-Id: e334c12e-0ae4-4632-0be2-08dc39436a4f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	vpCsjSbmXqvjuMDRZXSWGGjNsCg6TbvC3Xa7Nn+X2azfElAt+X4q1JfkjE9gmTPqhIS0ZlHQRfyybXkm4mJ5ZRuikwUBTixYt4BrH2EOEX+fYugwQIcnPRRIvL6KBTZ7jY60+7jRrO7n04qcNhFEBWn8DpWGavOtdSw9qx5wuP/trJ9zVJQgqnYm41HoSiPsLfMQxlUAsLRjtexM/MFWuW4mNPwOW3+AbQ/LWxPx+TMmdftHP7qXi5r8/rkUqG5mGVOcrUMwEoyXxJR84ncJSsXXS8QCbk4fsnBThwWlHRX/wLZxJSQ3l1bi/vl34YZRqO+z/DLwauwrVNUU49Q4g+Xb2h7f/0MW3kz6bOgxDWyetaL46NOOkUKGEEXm5dtKGu4GWisJCscc1gcv98NKVCA+PDqAGhkhWDjo/Ap6OaLhYXSSVBLNeZr/1BhVc2eNyavn0hhyk4ASpjKBSkahUDIjz5iz6/ssSyFu5E4vOZirromE2LcB2ncTIYgFuzDc5lpq4gLMaAU6RJ4MYS2MZ1YJtFl0YjTA75+XKDBfz56pCpVSgbVJqvfUW40bhYhisWaUGKZX8B2SR/s0t28VU0Q/saAT+e8ZEr5vEC0ieGU=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?TDVzdHp4dUxMRVpsL3J5blk3RlFGT2FVVDk4RzVIUisyU1J0dDRoQ3ZIQ1B0?=
 =?utf-8?B?Vk4rb0ZGSlErQUQvd3UxeTUzSGpwcUZyWW5HcFlYbDkwY3EyZUh4d3ZRaWdL?=
 =?utf-8?B?aXJHNDk3b0NXcW9ZN2RqOGs3L3kzbG43MjBxbU5ZYTZGSmRsMTlpakxuZ0Vo?=
 =?utf-8?B?dVloVWxHQmwzK0Y0cGlPOTJTQUJrOWk0S0lZT2VCRWRKdGx4bkNmRlo5aDdD?=
 =?utf-8?B?WkFPbFdudXgydVU3U0gycVNNZGFvTlJiMGdFUGZSN3R5WVhHREx2RHo3cHl0?=
 =?utf-8?B?WjNBQlY5OVNodVRla0JiOEh6aVFBSDFOM0Z4ZjVwSW9LWVZwcjBzV2dhZWJR?=
 =?utf-8?B?eFgrMWVReGJva00ycXl4M1lDazFCQUpiUFRISGQ5TFNKem0xQVBXaW13UTJD?=
 =?utf-8?B?WnRUcVJhY0pKTTZ5NXpTWVhib0QvRXQxZHdobTFjWStvUkxpMGQ1WnY2NXQr?=
 =?utf-8?B?eVU0YzAxN2RkYWRBazIrVU1HR3dmd0YwS2haVjN2WkRzTFlRTFhFUm9UU2Qr?=
 =?utf-8?B?dlUxdWNUMDc4U3cza2FPOGNRVThBbXdzdHVFR1M5S2owK0M2V0x4eE1ITU1l?=
 =?utf-8?B?UzIwQkowUkFYYUNhNkFRdnY5QTFmbWdYK2lyRndLQTBmOHFpYU45bUQrTTQ0?=
 =?utf-8?B?TEVXQ2ZsMFdvTFIxcmExYjN0d1ZwbmVIK2VEZklML1Foa2Z0THAzZWREdzNm?=
 =?utf-8?B?VUNhNGZiZEd2d1NyQXlmdThOaHRweDRhY3FKMmN0d1ZINnc1S1Q3dXgwNnlN?=
 =?utf-8?B?ZVlGZjhWd1VZSnFpZTR0aUhBbTZjNHE5RHgycFRtY3ZwbGk0dlczd0NyL1li?=
 =?utf-8?B?Vzk2OWltbS9vU09KUE5IbWMzdmRURDgybE9IUStTUmRTSDZ1cUdvOGNEK2Fi?=
 =?utf-8?B?YURKQnJMazhycUYwOVIxRmxubFhNeURoWEpmWURzd0czMXcvdWFNSEhGS3Fv?=
 =?utf-8?B?QjVGaGNQR3BpQzNuRUlvYldqMjhGcnpwS2I5QmtrQkF4bGtDOWlyNWh5WTZQ?=
 =?utf-8?B?YzJLSFEyekJMSDhLRXMzVG5UWGxlT1lna25sS1pJTG1NeGZMQXY2dzJranpl?=
 =?utf-8?B?bkpNV3RlOUdFVFh3OFdWWTlBaWRPelZwL2xXQ0pxbVhmK3BNbmxMZmx0M0lB?=
 =?utf-8?B?SFFwWFMxTDJHcTdDSDVMVDZCOUZvblZ0aG81bm5ScnZ4YnI2N3NJdTUzWm9D?=
 =?utf-8?B?NjVFTzhXa3BZVmZyamVDcFhSMlB0c0pRcUZGRnJ5UFprVzYyN2E3UzJpVk9x?=
 =?utf-8?B?bjg1UGpCWTl0cURMU1IwN1BhTWxhZS9uVTN2aHUyM0VnM0RaT0d3YS8vRFpt?=
 =?utf-8?B?a0srNDMrVVNhTVBhZzlSSHFMY2ZTR3RNMFM0WUJxbTRzRkZpaWtpM1dFYWRn?=
 =?utf-8?B?aWFSZEF0SUNlZlErZHZ4R2Z4alVTV0t0UFMwY1BoQnZuTHV4UWtDdndiVm9B?=
 =?utf-8?B?OVd2clpNTDVsQmR6L280WkozL0NuamRodUxCOTZET0pZMUI1OXA2V3FoNUxK?=
 =?utf-8?B?dEhLeEVEMmx3SmptUXAwN3JIYk5jK3BqWTlZTC91WXdmUGNwZHJPS2FRODlk?=
 =?utf-8?B?dEg1REhuZ0l5eS9hdE05WnV5R2x6ZlR1bjdpU2NUcy9hNGZnbm5POEJrV3pB?=
 =?utf-8?B?aXdYTVhMN1lHVEswZWZHK3Y0MWVpT2NwSDhibnhuZ1BOc2VFZFVpZXpiNjNr?=
 =?utf-8?B?aGdsU1VqdGFxeEkxTTN4bmFtc295U2FPSmJKTzBZaVhrWTZTV0lEc01NdkR6?=
 =?utf-8?B?ZnBPSXBQYzVkODlHS09DZzFBOUJnOGQxREdYYkhScnJpblRTWnhpZjFWQStE?=
 =?utf-8?B?d2ZoQ2JaejQ3cDdyV2wwRmR3Vy9obmY4cnFSQlhEaFVJb0J0VDFmTmg1OVYx?=
 =?utf-8?B?ZkIwcS9sbC82Z2QzOFY4ZE4rbTZXRU85Nk1BRVJtMWdtUVRKM25VbUpxYTdU?=
 =?utf-8?B?ZmdQbkplOHg0c3A1MUhlMm9BMWx3NmNOOFVwaEtSV0dMQkVlUmtQQy9xMzFa?=
 =?utf-8?B?SnBYSi9oNHBtMkh3T3EzZkYwcCtPZFR5aWxkbnBlZjRxTC83elczVjJUOVpL?=
 =?utf-8?B?cHNxSW1yaXJ6dWo3dUtQeUNQZkpXMGdNa21DZlVnZE5zUmo2dzBXODNWWlE3?=
 =?utf-8?Q?zMzY+xvJhikA1rybQwb2/Cd5V?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	KBkCFroAT+g9REN4dlWciJv9Mibonw1v5et7MsqHTAIRQGTn9ZeWm7keeEeFCbIMSWD3I4nM6P/GNIeFaW6sSZrcPrPWZhWwpD5nd5IdbtEgTd95e40HqezeAHOgneYiMu0gkHegFisylxvbo+KXcJnHFyJtI0OaB4jmfD3RpjS2dBjFWjj/OWNX6E5HQ0CEaAhLGPh5y5tuYoFEix+zP4EfaEDHYFnpMoB/3y3ySCKV46AQpoks0wHH+vgQo7A4FTbZB1mcGGOdMuG/BtW5iNz4nrToAW0i68RzuDCL/pIYE7AKR+M3R1A63VPJmuLRWFnZXWLqjbvfdwYrNW0pSrTYelz6ivlhcB3Q8Z57fZn8bWLEvBo0t0tGedGq7f1J/c3PxrEP6ZWXO66Jq8OFdqrpYrwFCGzqjzMZ7vRfOT2jGuYGXsMYn/4x2nzoiTUfA8x77CgxQeCG9UUeDE3WIXYisO6TpZszGRq7A/JcSAcaXdjKnL2/3P31a7LN1JbTnpwTr2lu5yb2RP5+0MAsj4a2PvKFjvcKz7r//IS8znavv+mScEwi/hpE2KG3hoZ8TIL+3+ATN4t61N3x0GePOq+a6i2lFRl5iYE70mSbbIo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e334c12e-0ae4-4632-0be2-08dc39436a4f
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Feb 2024 16:28:09.1697
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D159FCDhnxBnLUvQMDLyTu8mwxQZqd+LxPacdlElT1g1JFVSmgU3NmXGzoSF7NKeHRSe/cYxNWn8b4XKwQimfA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB7690
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-29_02,2024-02-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0 mlxscore=0
 malwarescore=0 bulkscore=0 spamscore=0 adultscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2402290127
X-Proofpoint-ORIG-GUID: wLlUi7z8V1FA9Z2oZfm5-V6NgK2N4apX
X-Proofpoint-GUID: wLlUi7z8V1FA9Z2oZfm5-V6NgK2N4apX

On 28/02/2024 23:24, Theodore Ts'o wrote:
> On Wed, Feb 28, 2024 at 04:06:43PM +0000, John Garry wrote:
>> Note that the initial RFC for my series did propose an interface that does
>> allow a write to be split in the kernel on a boundary, and that boundary was
>> evaluated on a per-write basis by the length and alignment of the write
>> along with any extent alignment granularity.
>>
>> We decided not to pursue that, and instead require a write per 16K page, for
>> the example above.
> Yes, I did see that.  And that leads to the problem where if you do an
> RWF_ATOMIC write which is 32k, then we are promising that it will be
> sent as a single 32k SCSI or NVMe request 

We actually guarantee that it will be sent as part of a single request 
which is at least 32K, as we may merge atomic writes in the block layer. 
But that's not so important here.

> --- even though that isn't
> required by the database,

Then I do wonder why the DB is asking for some 32K of data to be written 
with no-tears guarantee. Convenience, I guess.

> the API is*promising*  that we will honor
> it.  But that leads to the problem where for buffered writes, we need
> to track which dirty pages are part of write #1, where we had promised
> a 32k "atomic" write, which pages were part of writes #2, and #3,
> which were each promised to be 16k "atomic writes", and which pages
> were part of write #4, which was promised to be a 64k write.  If the
> pages dirtied by writes #1, #2, and #3, and #4 are all contiguous, how
> do we know what promise we had made about which pages should be
> atomically sent together in a single write request?  Do we have to
> store all of this information somewhere in the struct page or struct
> folio?
> 
> And if we use Matthew's suggestion that we treat each folio as the
> atomic write unit, does that mean that we have to break part or join
> folios together depending on which writes were sent with an RWF_ATOMIC
> write flag and by their size?
> 
> You see?  This is why I think the RWF_ATOMIC flag, which was mostly >
> harmless when it over-promised unneeded semantics for Direct I/O, is
> actively harmful and problematic for buffered I/O.
> 
>> If you check the latest discussion on XFS support we are proposing something
>> along those lines:
>> https://urldefense.com/v3/__https://lore.kernel.org/linux-fsdevel/Zc1GwE*2F7QJisKZCX@dread.disaster.area/__;JQ!!ACWV5N9M2RV99hQ!IlGiuVKB_rW6nIXKv1iGSM4FrX-9ehXa4NF-nvpP5MNsycQLKCcKmRgmKEFgT8hoo7rfN8EhOzwWoDrA$  
>>
>> There FS_IOC_FSSETXATTR would be used to set extent size w/ fsx.fsx_extsize
>> and new flag FS_XGLAG_FORCEALIGN to guarantee extent alignment, and this
>> alignment would be the largest untorn write granularity.
>>
>> Note that I already got push back on using fcntl for this.
> There are two separable untorn write granularity that you might need to
> set, One is specifying the constraints that must be required for all
> block allocations associated with the file.  This needs to be
> persistent, and stored with the file or directory (or for the entire
> file system; I'll talk about this option in a moment) so that we know
> that a particular file has blocks allocated in contiguous chunks with
> the correct alignment so we can make the untorn write guarantee.
> Since this needs to be persistent, and set when the file is first
> created, that's why I could imagine that someone pushed back on using
> fcntl(2) --- since fcntl is a property of the file descriptor, not of
> the inode, and when you close the file descriptor, nothing that you
> set via fcntl(2) is persisted.
> 
> However, the second untorn write granularity which is required for
> writes using a particular file descriptor.  And please note that these
> two values don't necessarily need to be the same.  For example, if the
> first granularity is 32k, such that block allocations are done in 32k
> clusters, aligned on 32k boundaries, then you can provide untorn write
> guarantees of 8k, 16k, or 32k ---- so long as (a) the file or block
> device has the appropriate alignment guarantees, and (b) the hardware
> can support untorn write guarantees of the requested size.
> 
> And for some file systems, and for block devices, you might not need
> to set the first untorn write granularity size at all.  For example,
> if the block device represents the entire disk, or represents a
> partition which is aligned on a 1MB boundary (which tends to be case
> for GPT partitions IIRC), then we don't need to set any kind of magic
> persistent granularity size, because it's a fundamental propert of the
> partition.  As another example, ext4 has the bigalloc file system
> feature, which allows you to set at file system creation time, a
> cluster allocation size which is a power of two multiple of the
> blocksize.  So for example, if you have a block size of 4k, and
> block/cluster ratio is 16, then the cluster size is 64k, and all data
> blocks will be done in aligned 64k chunks.
> 
> The ext4 bigalloc feature has been around since 2011, so it's
> something that can be enabled even for a really ancient distro kernel.
> 🙂 Hence, we don't actually*need*  any file system format changes.

That's what I thought, until this following proposal: 
https://lore.kernel.org/linux-ext4/cover.1701339358.git.ojaswin@linux.ibm.com/

> If there was a way that we could set a requeted untorn write
> granularity size associated with all writes to a particular file
> descriptor, via fcntl(2), that's all we actually need.

Would there be a conflict if we had 2x fds for the same inode with 
different untorn write granularity set via fcntl(2)?

And how does this interact with regular buffered IO?

I am just not sure on how this would be implemented.

>  That is, we
> just need the non-persistent, file descriptor-specific write
> granularity parameter which applies to writes; and this would work for
> raw block devices, where we wouldn't have any*place*  to store file
> attribute.  And like with ext4 bigalloc file systems, we don't need
> any file system format changes in order to support untorn writes for
> block devices, so long as the starting offset of the block device
> (zero if it's the whole disk) is appropriately aligned.

Judging from Dave Chinner's response, he has some idea on how this would 
work.

For me, my thoughts were that we will need to employ some writeback when 
partially or fully overwriting an untorn write sitting in the page 
cache. And a folio seems a good way to track an individual unforn write.

Thanks,
John



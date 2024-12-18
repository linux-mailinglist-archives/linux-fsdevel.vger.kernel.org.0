Return-Path: <linux-fsdevel+bounces-37711-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7869D9F5FEF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Dec 2024 09:09:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B6FDB16DD23
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Dec 2024 08:09:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67E2316DC3C;
	Wed, 18 Dec 2024 08:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="GMQmfQCM";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="B7xPQHKc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA58CDDBB;
	Wed, 18 Dec 2024 08:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734509345; cv=fail; b=RYGHK3fkPMmlgunwGd8ZtlrJ5oNzDnCz6lIwQT/YT0/5uFjksnWadCq0Cvpjz3ZOkc1iJilZf/6sVdIzCsiheUIow0mQpi2P5pFL6dgddjlHzCIX+jm7sbDUNtvAqrrdPC54CW4Dm8AVEhzqIY8BSQlljAqKtiug3mBtn/kDIIY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734509345; c=relaxed/simple;
	bh=BPJHILkkHPpTyEciXUc5j3HwzNh70JxwGpm712iwZjw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=FeeESj1iZS5+Dzj+gqdwOCDn0C3qZnr5A/ZYXk8Px6mbzz5LgK/NL2hCeSlkGzcpGVFv5gZPLTVov7aNkuROyuCKh8u/jwM7Sffhd6I5pKEu/GmqaB6E6ihLSDN5Tnyl+UD03FkM7toBJkxF/IR10WFJJyH34Aw9Nj+sxKm9MJ4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=GMQmfQCM; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=B7xPQHKc; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BI6OkTL023869;
	Wed, 18 Dec 2024 08:08:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=QacVGiTPhbK+oBm3S/k3D6syvp88uOZJ/Ho9RaxKsmg=; b=
	GMQmfQCMK/eYMfZzzifXFC17F7CqfjACMfzaCi/LzFtZNfuufcIaAKFJxIETZh0v
	O4xKtsgWyF9z3sbWo6QwVdk3iVFusD/TUzFHbBVSU/wC3qZcalJVH/zq7ChGnO6W
	0DO/NcvSc03fSp/9XESFHxD852DaNV+E1P9BOPPMO9LB4d+hYin5EaJvM9ebuP97
	+2bukvBWmJJ+rxEp6ApnHtu0tEIvpEj9urh8/bBwW0YIuCA4m8oO5lsBElL1YRmX
	HEnObH+ecWIPsQT65yVccxxKg7ccCuE3PAp9v4hGxsMlqR54deiFQ9eErrJrLJSc
	1RViF3YgZh3ZiDRbbg6LPw==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43h0ec84t5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 18 Dec 2024 08:08:27 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4BI7osun018324;
	Wed, 18 Dec 2024 08:08:26 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2047.outbound.protection.outlook.com [104.47.55.47])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 43h0f9rd3n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 18 Dec 2024 08:08:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PKIPCoxNqFXxCEAhPz5bdyLdFYnXm8LL/kvGryXe3lwqKxP6B7reZiLbAnD5g+54sfLWJzuJX41tghO6NR6Hh9FCmxWwfw6O6MsQX6NVdh6idQNxKIRrdbdbdDaWWiyWSuPrztNO1LaTdBXw93bg4RW4+h3KE0ZuEIVoEPNLIYOKXEnKinfXLMhcEgBA7CDIwpGwpAsPz1AGCvVbCv57CRyIltNFFEDLR69//RMuDoGqJ0n/MhmugN+PdLQwL7QHWX+fJ/zijwaoa3g3YcX31phfcDGkpfUjyxhQs6v9TzOHqkhynei9+oj9GIofwCQuHUTJ6FaLXpu0XlbdE42CsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QacVGiTPhbK+oBm3S/k3D6syvp88uOZJ/Ho9RaxKsmg=;
 b=da4kr06cN5vVBi8+zZqzq4UrfajgSeh4Wrfk/2nka3GxJhPzBCoN42YsV1PEiiinLzaUONfpNkgDcANEeP7PVvyizGuEgIFKQy3WaVx/FqkxJRxqp4aEzNgYkMSGtUQRaz/+Shv0o1msEX2bqV8ky5VNrz0RdLv+sMeJr/UhozL+xalODVRlu43e+/gq1CN3Uve2QtqKPEAmY4LGIwmpQVuXcEOSbXjhqZwlR4aqrUXBmPddKha0IRDSYciop40lLcvOAwRd4LqfPYZiR2qZoqndputjDamwafARGvkn6/wOkL/+uzOwWa+OEpcRfOLfAELY+df+mhwLiZxJBD+NAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QacVGiTPhbK+oBm3S/k3D6syvp88uOZJ/Ho9RaxKsmg=;
 b=B7xPQHKcJEBMKKmBnWsJLbGcHhopZ3jBlLLeNJVWK6ctW2kozz5S+WnC4ENHfOuYzEm5kliP9WWsoRZnVCTDAS/JTOQ3lA28P+r7JJXFlmtjj5onb6N65I/ZHYlFzxuAXBClXoQs8AIOGawjL5sQxLMgx9iqXdwIA0/RV90ehEo=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by BY5PR10MB4132.namprd10.prod.outlook.com (2603:10b6:a03:20b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.13; Wed, 18 Dec
 2024 08:08:24 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%4]) with mapi id 15.20.8272.005; Wed, 18 Dec 2024
 08:08:23 +0000
Message-ID: <eb556e80-f7f7-44f7-b015-11ae50d5484b@oracle.com>
Date: Wed, 18 Dec 2024 08:08:19 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] nvme: use blk_validate_block_size() for max LBA check
To: Luis Chamberlain <mcgrof@kernel.org>, axboe@kernel.dk, hch@lst.de,
        hare@suse.de, kbusch@kernel.org, sagi@grimberg.me,
        linux-nvme@lists.infradead.org, willy@infradead.org, dave@stgolabs.net,
        david@fromorbit.com, djwong@kernel.org
Cc: ritesh.list@gmail.com, linux-fsdevel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-mm@kvack.org,
        linux-block@vger.kernel.org, gost.dev@samsung.com,
        p.raghav@samsung.com, da.gomez@samsung.com, kernel@pankajraghav.com
References: <20241218020212.3657139-1-mcgrof@kernel.org>
 <20241218020212.3657139-3-mcgrof@kernel.org>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20241218020212.3657139-3-mcgrof@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO6P123CA0018.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:313::11) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|BY5PR10MB4132:EE_
X-MS-Office365-Filtering-Correlation-Id: 567e1b51-d422-4847-3fc5-08dd1f3b24b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|366016|7053199007|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?L0FFS0J6cDl3eUJ3VjlNK3NHRGtsdThndWM4YjlXd0tMNlJBTVJjeHc1Tng3?=
 =?utf-8?B?azV3eTBLKzZKUUpGTEw2L0pOMXNrZDU1WW15ZkVSOFdpdWhvV0l6VktUaHBH?=
 =?utf-8?B?eUwvRVIyRVlTWWEvRUJpdUhmNmZTYzF2eXBtaE0yYTZkYkZ4ck50Z0ZRU3Zr?=
 =?utf-8?B?YzBQbVNMTldCUUpUR2ZVR1RObmhqc245NU9QeG9DOURDaFhlOUFSOFdVbTBW?=
 =?utf-8?B?SHFCWStpMXJnaTJPT3FzWEVkUGUvbEdrcG9JQjR4VUloOXJUMDEyZW5Ja2F0?=
 =?utf-8?B?Tk9kVkR2cnFORUZpeTNnTHlEMzJBWnBtRjdyb2R1YS9nNWpNUDN5OWtoUnRL?=
 =?utf-8?B?MVRhZ3hpK3FvcUVMUkNya3kxUUVuUTl0cVh0TU5reWhQTjdUbjRjMEpJczQ0?=
 =?utf-8?B?OWswQXRuYTAvUkZhUVpKRXRNeFZETFdwbXllaGorMFZ4WjJSTXNzb1JrY0FO?=
 =?utf-8?B?cThzdEdyU3hRQ3VLYmxHeUhadTY4Z25oK29rV3Z0QUlxVG1oY3UxTExxR3hv?=
 =?utf-8?B?RDFJSDRmMGVJbVJQQ3VGd3RlRktSTmRwTHhmdmRCSmFGTGorbXdXQllBUTgz?=
 =?utf-8?B?WjNFQVJoMVRaUTBNUEdodUwyeFlrY1hhRVpORzNkeTgrblRZS3ExTUxDL1Vy?=
 =?utf-8?B?Qk52a2txYW02d0s4WnJ2aEROT1JzSzFwOFlOSFNyNFJyVm1TOHgwdVdOeThq?=
 =?utf-8?B?T1B6MEVlM1NJaitvVWJpVzVTWkNuaFBkQkZGQjBxZ3IxQmlsNGh2ajRucnk3?=
 =?utf-8?B?LzkwTisybzl3V2JWYllzZG9BWCtvOVJEWUFnSnkvN1lUS3JDME9tQWR5bkpr?=
 =?utf-8?B?aExNSTE4bmNVTVJxV2lIR1hlMmRQOEtqOU00NHpIbk1TUnFjYlBpdFg1SVRi?=
 =?utf-8?B?UW1Ra0hJS2FKUStxNGlIRE9mTXlZN040OTZaOTh0MEZXcGcyRFRWd0pLMmF2?=
 =?utf-8?B?NnE3OFlpZ3ZQc20vbFRIVy9uNmFzSHc5c0I2Vi9DTWVWU1NuVlprRVpwQ2Qx?=
 =?utf-8?B?U1NLaVVhVU5WWVBRWWdteFVSMkNVS29BOXBzSGxBWlpXYlNYbkFrV3p2VlhM?=
 =?utf-8?B?N1RUcDdEY0kxdWZ0Yy84a1AvT25ieW4xZU11a0pER2dFZ0grUXBIaS9ESldN?=
 =?utf-8?B?TFk5eXJwdHAvbHExTFBxMFZaSzVTVU0vckQzTjFVd29jaUhHY2ZpL1MyYkpV?=
 =?utf-8?B?VTZtVCtzMmpRbVNhYUxqeDM1eEVMNlpuUnJlVmdQcVJGbGVTbHN5a1hodkNI?=
 =?utf-8?B?akllamsraHgwWTdOVVhMY3djeTlVeDJOeVorbnMxUmdFeS9DcXhHU0JYNjh6?=
 =?utf-8?B?NDViNUsxNDl2U0I1bXlWdm9VeG03dloxWS92NmxPRUxFSTN2SHZrd3Evb3dk?=
 =?utf-8?B?cHBScDF0NHAxN243SjZNLzN6Wkd4YzMvVUt0UGlYSk5sNXhpS1l1cDhGVXdV?=
 =?utf-8?B?bnhmWGpwUUZ5eE5JQWF1VnY0Z01UREcxaFYyZ1p2U09ERGlKM0tSR1Qwck1o?=
 =?utf-8?B?ZDdiVCtnM3B1M2FDU044M3lFRWRqb1pYQ1lZdmhWekRwWWNqOUcrYkRLMFIy?=
 =?utf-8?B?K1YzdEdGOUJhY3o3VFNPWmhXWUlGbVVkWUJiYnNNY2VNbWd3ZEZqTVc4Zk5E?=
 =?utf-8?B?djY4ajJ1WlRKSXNnMS9XOS9uR2lvZEo5MURYOGZaNHNYMXVBM1YrZjJ1TW5s?=
 =?utf-8?B?ZnRvTzFzMThnN2VNczZOTWpQMjBwTW1ZWm9wU0pmK21XRmxVUjFETDBMK2hR?=
 =?utf-8?B?Zk85RU1GTjBEaTF0eW85WFJiSERhRm1reDlibktRdUJLNXJOdmN1dGNlYU56?=
 =?utf-8?B?U1B2OTFDVXdNYXFTQk1XcWNqLy9YayswUzJtU0JTL3lzSndKWCtUaS9Ucnoy?=
 =?utf-8?B?cm9FVjc3Wk9RZkdSanJRaEFlYkgrZWtEYmNObDYxbFpITG5sZnpHUmo3cEhE?=
 =?utf-8?Q?D0MDQAJ2IGA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(7053199007)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZFZ4M2VpMW5RdGNEbUR5bno3RjdITllycGptSmc0QkJSa3A4MnFqckt4NU91?=
 =?utf-8?B?RW5tNEQvUzdWSWphMEtjV2pNSlFiWWZGTGhNaGo2U01GTWZkMVhwWDgwSGY2?=
 =?utf-8?B?enNGSFRIaGlCbHJHZ3VRL09wS3lkRE5ydnVtL0wyR1p1UnNhL3lkdWpTaGxE?=
 =?utf-8?B?aUIrY2ppOEx6NzdzMXBMbUQxRFBmS0loTVlESk5OM1duZWtHQzZvUk1BUDNv?=
 =?utf-8?B?cm5VTit3MGd6QXNwQ0RkN2NQQkRpeVZHUGs1WVRaN1pZTDZzemxRbHN4WEtl?=
 =?utf-8?B?akJSWitXaWNocjVFT2pJL1o5dUt1WFJETTAxVEpCOGZLcjBuMHRwbTZPQ3pp?=
 =?utf-8?B?dGhKbG1sOTJRSU9vYkNzRkJGVkZVbGtIZjgxSGNVY1o1L0p2NWlHSE1lRU9j?=
 =?utf-8?B?cU9UOG9pVmNYVnBqM3ZhWHlTQ2EvOHhMWFZQYThYV1UxbEZZTEwrRXowVkpn?=
 =?utf-8?B?QnJjeFlUOXR1OE8yQTkzSFEzZ0d0TmU4L0ZFTjhoUEM4RE9ReG1meWRRVmQw?=
 =?utf-8?B?bVQzU2lkdk1PUng5ekVRdm55RXFrbG4zTndQUm1TTFJIR1RsWVlsbE01Znl2?=
 =?utf-8?B?Y1JuUTRsV3lWc2EvRE1vRHkvVUZJazJ0c0pHYytTa3cvaDVyU1pOSWwyaFNk?=
 =?utf-8?B?MDdqYitqM0NvZ1hrMEFuY01YVUdWVWxCNDduTk9LOGIyUVRRaUxqenV6eFR6?=
 =?utf-8?B?dlQ2bjB6L1R1aEpoWE1hQWZxYVVnKzlyRGFmaFZlZlFiUWpIYlB0S09TR3Rm?=
 =?utf-8?B?NWRNUUc2d2FYd2tuU3JFR0ZKVEgrSHJJT3NrcVAzeFQwOS9QTVdNeG52VEFV?=
 =?utf-8?B?VzdOK1YwNXZVU2ZiS3ZXcnYrUTJSekRJM1BiOS92VFNqV2xUdEwrUGNwbHZ0?=
 =?utf-8?B?T1QyeWxFZms1Q2pPeGk5SUFqK0dQTkNNZG5KNVhsU2tiNEZqeVJrdVZCb09k?=
 =?utf-8?B?LzNwdnpneW91QXZCcTJWNnpvOG9FMWJkTEgxMndUSzk5ZVRkaXhnUnYxTWJT?=
 =?utf-8?B?UVZaUXF0d2tJOVFMcmdsR0hQcnA5b3h4RE9hNzhmTDlpNlNCeWg4WDBHaWd6?=
 =?utf-8?B?Q3I1N0RsVUtNTXQxOUM5N1pWRndoUVF5R1dYTXlQSWJZbG13MnoyQzJDK0FD?=
 =?utf-8?B?TWh3NVdNKzhaTk9NL2N1aUNqdHFSak16cjI1QzVucFo3WHFBT2w2R0JaMzF1?=
 =?utf-8?B?Ykg1Q25EdGw4UVFMRVZXNTFqcERiWFRhcGxZSWUxamZxem91SGRROG44V2hO?=
 =?utf-8?B?THd3VGtGNENUY09OTGNnejVRUFI5LzFVSi9nQ1A1Sk55Njltem1rRFZEcVJ0?=
 =?utf-8?B?NVd0QW1sU0JTMDU5Nm5zS3V4VmJpbWptVkJscEFoU0xCWklwS3MyUW5WNTVj?=
 =?utf-8?B?NDBXR3JETldncXRpcklpUnhiNG82M2ozZXdMVkNEYUNYZzFRYVlTWnZDWDBt?=
 =?utf-8?B?T3RoendSMUNNOENtNUFPU2RkYTV0dWdJSVdyb1BJVjNENWswYkw2RzgrNjY3?=
 =?utf-8?B?RDg1U3FocjI0Ky8xZU9POVJINU40cldNUndCcnV0S0g4YkZONlk0VFgzQVVT?=
 =?utf-8?B?WUhsQUNwZWUrdDFYWlE3TVRobXhzbFh6clNrMHpQR1UrSmxVbEtJRjRwR0N0?=
 =?utf-8?B?cnJveWtOOW1jSlVSdExUMERBQnpwcFpFYkQ1REt1SDhTbmhUUnhBZ0YrWXZL?=
 =?utf-8?B?dGxOWXhERWlyMUpLb1h1YVV1Y3N3enJiMjh5Z2l0cUg4Q1NSdlEyeEVmS0ZS?=
 =?utf-8?B?MWxUZWw0aHJCTTBrQWVEempsQ25UZ0YvK2pIYTVodWwzVTUzT005a1ZvQ0d1?=
 =?utf-8?B?RWVZUkczT0tJRlpVQW1Ub0Eyc0dLRlU2ODFMTHFEMGYrNFRpcE9lYjlobTE3?=
 =?utf-8?B?RWpPL3R2aUZsTG1nR0VEbEFobUpDamRCSGJwVzVoMEZzUzZBZ1ZmTk9YMnM4?=
 =?utf-8?B?Smx6TEN6d2QrVVZURjBkTkY1U2U2MXJaSnUrcHZRemhNMWxWZ0RUU29nQWNl?=
 =?utf-8?B?aFpnU1ZPbDhLZ1l2MURJRUphZ1VtQjlKYVRod1JsWFh3bW8vUExPS3Y0UDcv?=
 =?utf-8?B?NURjTUo2L1VpRVYvWDNwOW9zZWJlNzROdWRtODFYOHUrcHA2MHdCTnF3bm9a?=
 =?utf-8?B?YlpuWVVGYXUvTWF5UHVoRGdhbnF1aThQcHdOcFpuS0syKys1ZG9Uc3FMSDk3?=
 =?utf-8?B?NXc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	VzXAwNW2FZI4bkTnH7s3mhjbw+7+PftG/2v2oNolspdpqI6gL97uNeHxIXUWqdmRtJ2BOc5e5mqGn0ckw54yUGfQiPdpCVw1O39FXFPWADbt98HAhQx1r1DmW76Wv4+27/gQs12zzsR3eyOeJSatJ/5wfgj6l4HbAkWnNKrGk3QhGYkl28Bl7wlnhdoZ6w7+K5YrSNLiGuk/RY3VN/51qAdF+u9Kol/dZ7uvSFH4TTIz5e17D2VOeknEOKpvf/gC/LGsjd4AZ3sg/m6602/sDv4MFW5uuvk3qUS6acBXaZ4+IMKIr7OPrHjJwpqLkpghwWbTBhA+YxAJxSrT7tKuIIOQ+8AYYgYTe0Vru4GvHNGMi/eAR2Xx7CW7Ocx/egsma7soW7E03T6RlAyLLu4HLqAtrCU1LrY3Oq40fmjKEaR4srFB4y6MsKfJ5Oga8+4bb/jY6tdT7HaCk21n+SAZyY3VccD0K5QX+fnBmSS+87b2WziVudNajEAbULk3FcbrmFje5JTgDEIfiURAxnQAdS4UM1rffzpUSvFEOhCoLw6hQf/rxhIiuYz7kr6WZNS1dtTh42de2xRDvkh6wVoyQroYu7tG1vBFnnOhbNecj78=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 567e1b51-d422-4847-3fc5-08dd1f3b24b7
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2024 08:08:23.8299
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Q5GpHoN7/ttaszweVQ8deKfthoTsaQY0kOeeAAidlMFqugsvV4ABYipiMpT4kWiq7k0KRice59I63H1+EVbmKQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4132
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-18_01,2024-12-17_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999
 malwarescore=0 spamscore=0 bulkscore=0 suspectscore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2411120000 definitions=main-2412180064
X-Proofpoint-GUID: c1ZUjFKY3UQ2ZEguwfBs5OblMOz5rGVI
X-Proofpoint-ORIG-GUID: c1ZUjFKY3UQ2ZEguwfBs5OblMOz5rGVI

On 18/12/2024 02:02, Luis Chamberlain wrote:

nit: is this really an LBA check?

> The block layer already has support to validates proper block sizes
> with blk_validate_block_size(), we can leverage that as well.
> 
> No functional changes.
> 
> Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>

Most of my comments are minor/off topic, so:

Reviewed-by: John Garry <john.g.garry@oracle.com>

> ---
>   drivers/nvme/host/core.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index d169a30eb935..a970168a3014 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -2034,7 +2034,7 @@ static bool nvme_update_disk_info(struct nvme_ns *ns, struct nvme_id_ns *id,
>   	 * or smaller than a sector size yet, so catch this early and don't
>   	 * allow block I/O.

I'm not sure if this comment is really still of value or can be reduced

>   	 */
> -	if (head->lba_shift > PAGE_SHIFT || head->lba_shift < SECTOR_SHIFT) {
> +	if (blk_validate_block_size(bs)) {

There was only a single user of this outside the block layer, and I was 
hoping that this function could eventually be internalized - not any longer.

>   		bs = (1 << 9);

comment on original code:

		bs = SECTOR_SIZE

seems more obvious

>   		valid = false;
>   	}



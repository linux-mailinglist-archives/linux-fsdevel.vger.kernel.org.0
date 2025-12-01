Return-Path: <linux-fsdevel+bounces-70411-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id F3CF4C9997F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 02 Dec 2025 00:28:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 9A019345EB5
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Dec 2025 23:28:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D189C29AAFD;
	Mon,  1 Dec 2025 23:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ULzZc1j6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7209425F988;
	Mon,  1 Dec 2025 23:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764631688; cv=fail; b=RPBNi6EMm+SyHP1xmG99NhgMCb+7Sg89umJVRkCKZN+0wKOIup4C6MU2prkawCJk6UBepTh2xB5Cl07rOv3fokv2YsEyLqlFQWBtYM3p8kZF9AedZlMR8UqMBTZZPYMAH14hgCOtv/wd05Wy4T48/qdaJK9jMRtkyT7GNlaCqXM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764631688; c=relaxed/simple;
	bh=YbUldkQbvFGYn1x7SCWiHQXRL7fliYO4DcjqYL1UAkQ=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=mNYGAulclREVz0njgELyKO6rMPfjkeZBx2xdTUo1sM+x6X8Gz2B9J5AvZj3rV1iSTZ8+LtBc+wRexB73Tcr5dgdiHSCBCQHNgugCswrAyUx9NICfCR5DHqZNZWD/R+xCM6cuQLwr8oh4SpMqeXxAm9yhPZFrEnyFoL2HwQ6VWUQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ULzZc1j6; arc=fail smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5B1MNWYt005729;
	Mon, 1 Dec 2025 23:28:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pp1; bh=YbUldkQbvFGYn1x7SCWiHQXRL7fliYO4DcjqYL1UAkQ=; b=ULzZc1j6
	d6VDjnIqZKgBBZ59UoqW7CtFybwfuWDTB03P9tKf9ML8BAXoNPX29n+ARCR5b9iv
	GMdbf6v3twlacpMgt3k0KH6xJ0g9i3PmDxs+R5t46lNbZfRhO2zSinyiJXmiUVG1
	eXM8ciN3qBf7XZaw637vHS5705lA5Ba3Ypwq242KPWSYcE+2wLubnJIoBO1MeYHp
	HX9/13LtF3h3jNbtLFqE7hPT0Oeh6e+LmM+MpW6OdhNH+SKWwqvyvca0Ds/SQG3W
	aXv3CgqU6VHX+5WYmb4/p0pgWsmZuMGNz7A+iQCrvI3+J4eCcbNY5efREEI/+93U
	Jxn8h1O/T2V+4g==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4aqrbg223g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 01 Dec 2025 23:28:01 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5B1NS1FR020062;
	Mon, 1 Dec 2025 23:28:01 GMT
Received: from cy3pr05cu001.outbound.protection.outlook.com (mail-westcentralusazon11013061.outbound.protection.outlook.com [40.93.201.61])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4aqrbg223e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 01 Dec 2025 23:28:01 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hwqUmNiL0CSOP7ky2ZnJ50k22IL05F8/TNfLe5vm8elk9VSHAyjtLQ94r1ydAo3ldlZvZxmm1q8vpRzV6hQdNRE5gOxuPSc6sDrfhvfvyDORWC8JYB5RjzKgXChy5IQZ4K8OHXPlAG7Db3HEF57iSHKcfcBBEoZEowcNp9Blysk2DNaqDXnVE/mKBTvRQNg2CivlYF2pbMFRnTN+v1sAAhbChx60vvOsQLEfS1+bFp0XOLLbUNDaVVgZwwETW+RU+NiRx8YnnswrXVYzGOHm+dtcZWmlbW2kwGzq4RUWSKjo5OANsuTSVDlQgdIagr9Rd/1JoxECa3V4tZiCsH6z+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YbUldkQbvFGYn1x7SCWiHQXRL7fliYO4DcjqYL1UAkQ=;
 b=xHEVKeKCVTJDwFlLoDS5XDYYFgCHuG6FATYLTjopqpIYELGUktCnVvbzX8AIFOXy61/dLqDm5yACOjDmMaCEpzRTJfQ3aZCpKIv9bgggCfonGuvR4W0hzESGMMuJqzQK9G8OyC/JyfxA0crCnJJvPFyEnMFHq5KG0Mbr/yBsP1T0oNQofQyew15XaSVx/bvOjq/ZOjQSPb99u+Hqt1n1D8QteH27hqFMNCE/f4jvINz7jgVlbwv86Cor4WNpGZFr/t7h+DLoOYMVyJAjzuQD4OFPnqojH7rYPbJc9aaAC2+Kl9+azrn73l7bMHNLfrtajveBiZi1l17H0gUAtmunLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SA1PR15MB5819.namprd15.prod.outlook.com (2603:10b6:806:338::8)
 by CH3PR15MB5989.namprd15.prod.outlook.com (2603:10b6:610:165::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Mon, 1 Dec
 2025 23:27:58 +0000
Received: from SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539]) by SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539%4]) with mapi id 15.20.9366.012; Mon, 1 Dec 2025
 23:27:58 +0000
From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
To: Alex Markuze <amarkuze@redhat.com>,
        "ceph-devel@vger.kernel.org"
	<ceph-devel@vger.kernel.org>
CC: Viacheslav Dubeyko <vdubeyko@redhat.com>,
        "idryomov@gmail.com"
	<idryomov@gmail.com>,
        "linux-fsdevel@vger.kernel.org"
	<linux-fsdevel@vger.kernel.org>
Thread-Topic: [EXTERNAL] [PATCH 2/3] ceph: parse subvolume_id from InodeStat
 v9 and store in inode
Thread-Index: AQHcX6RV7p4M68pFQ0i9cP+uI2hUcrUNdPeA
Date: Mon, 1 Dec 2025 23:27:57 +0000
Message-ID: <97f3dd22baa3487f94f2966b2ddceb92ea7b2edc.camel@ibm.com>
References: <20251127134620.2035796-1-amarkuze@redhat.com>
	 <20251127134620.2035796-3-amarkuze@redhat.com>
In-Reply-To: <20251127134620.2035796-3-amarkuze@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5819:EE_|CH3PR15MB5989:EE_
x-ms-office365-filtering-correlation-id: 343d9a73-b97f-4569-eeb2-08de31314306
x-ld-processed: fcf67057-50c9-4ad4-98f3-ffca64add9e9,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|10070799003|376014|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?QlVMdmdtRlBWdmxuR0dJajc1cm1CY2g2enh3TjlWVVBqOUhIMHJpckNmdDdr?=
 =?utf-8?B?OXdrM2RDMkRLYXZtMnBkU2NMSkZtdGZ6N1RmQW16MDIxUVM3bGMrQnRsZ0No?=
 =?utf-8?B?WExCZDBlMTR6dys2VE41K2lCamxmQVVxRjFNRnF3Wk5OalRmWFNJelNMbTgr?=
 =?utf-8?B?SXpjb2E1ZnlXa1VWaGxDbXZIVEZoWXY2MUdzTkJqb2J6WG5CQk1ZNVVCUmtL?=
 =?utf-8?B?cVN0SEtFWW1CaE9lbTcweVdnQXRiZXRncUxucjU4RTAvZGkzZ3hzdU02emtF?=
 =?utf-8?B?b3FwL2lTUC91MFgyQnVYUTNYU0w1VlJrK1l6M0RiTnRDc1RZQzhML1BGcGYz?=
 =?utf-8?B?NXJhN29VZ016Q0JzWWkyWVQvUXpsSzZHanBaMHlaZnV5dXJ4cG5kN3cvWTMv?=
 =?utf-8?B?YTh2R3ZuUXFva29lZEhJbzZ5L0RuZGpsOTkvSWFCMFhqSEt5MUd0WURmUnJy?=
 =?utf-8?B?V1UvckpZemRSU2RBajRCTjFMSU9YbDRjWEhlVWxxWFBSck4zSE80dEpETEQy?=
 =?utf-8?B?OGFycTZVVVpBWFlVYkhPWVNNd1piQXZ2RjlOcitQM09Tb2RUUThVZXovOHh1?=
 =?utf-8?B?T0lnQTZaQXd6YW1wUGZCM1BYcWlDOUp3VEJDTHJiYW8zcDc4TEtGZ1BOd3oz?=
 =?utf-8?B?bEJEY3dUMnliaHViNEk5dlBIcEc2S3d5N2ZobmdkNS9KejVoM3puK3dqWVE4?=
 =?utf-8?B?VFRyUnhxSnJ5TXFpNzlQWnlGbGJ0cnIwY1k5OFNoRFFMdHZRQVFRRW9vd2JN?=
 =?utf-8?B?ZXhBdjNvOEtmb3FCY0NCd2ZVVjFBOEdua213RkFMR1hxTDVEQmVxM1NYOTcy?=
 =?utf-8?B?OGhSM2FZM3Q0TkIwNW1aanZpQUF0WktLbitQcHNEUTVXN3VJWXQrUnRJRTdF?=
 =?utf-8?B?MFloclZ2ZVpPQXVtU3N1MlFDSG4zamFDcnNOOUZMbnIrMW5FQitVK2U3cnda?=
 =?utf-8?B?V3dBSTNhM0pTVnNZTTcxb1grajlSNmRwR3BLMDdjcXdHMnJqT2RMM1MzTVVp?=
 =?utf-8?B?YS9kVmp5ZzRPNFN6ZjMzODh0K2dzaWFYMklRY1VJcFRpYitRSGoxVlRpL245?=
 =?utf-8?B?WHlvSG8wNldaSkVGbXdyK3JCWmlQeTlpZjJhYXU5ekFQcytXWkoya1U5Y1JB?=
 =?utf-8?B?cXFlRlR2VERXVmt1QngvemZLaWFLVHc0amVOWmgrb09tMTlrWk52dlVEL0FY?=
 =?utf-8?B?NzZKV3BOeXJPeXdZOUs5ZStrdkgwdlpWRDV5MXV5NmphSlpHR0JrSkpmczlK?=
 =?utf-8?B?TFJUMVBhMU1uRW5jejFrd0FwUnZjRzkzdWloZGNVdGNYcVlObFUzWlUyVEg0?=
 =?utf-8?B?eDAvaUsvQ1lPejBqK3JidVRidk9YSUNOUnM5a2k3UEs1UE13bFF2OHpFMlhK?=
 =?utf-8?B?WU8xdDZ6bHRyLzhuQVdUeCtTd0lOVU4yLzRwWmMvUWZ5NkkzTjdJV2o3V1li?=
 =?utf-8?B?UkUwQlIvL2djbldvQTVFWlpIOVlmNlRHbWJIWjkvSUhsTG5Wb0IyNVZ4enRZ?=
 =?utf-8?B?R1dpQ1RJemEycUhHRitDbHBJL3M4VkF0WHZobDdRVTY1Qm9HTmlHcTdMdW5w?=
 =?utf-8?B?eW1LZEVhbVJPMld2T1psdGplWnZmdFBYSVlBOFczenJzWWdBeVhuYUg2Z1BQ?=
 =?utf-8?B?bXR4NzhzWjREZU05aWlFTWZWRVNVWXVQT3pJdFU2S2RJV0p6TFpYZ0UzaFQ1?=
 =?utf-8?B?RDB4MFJmRmxJMUFFMzdINkFQclBmZDUzTnYxUGhNdzJnNnhIN1BhQVpnR3Yr?=
 =?utf-8?B?MW01NlExdXhVbzZaVWEzbFZNWGQrWVB4aEIydEJjTkpjWm9nMVlvNVZ0dnAx?=
 =?utf-8?B?eGFoWDF5VzdUU3IrZERNUVpxTk9BdWdqWEswWDYrbEY2cFlLeldORlVRS3B4?=
 =?utf-8?B?NUxHVS9KSDAya3VHOG90d01oVGhYNlcrZ3hKT3E0Y0lkQmIzckpadjg4SGR2?=
 =?utf-8?B?dGMxNXFZWmJYN2pHd0crL3V4bmtWRFFXK1dNRHB5bUlHeUszNk5JUGtTVUtC?=
 =?utf-8?B?UWFjaldaQTR3Q0oyMmhKQm9nOEd5dHRaczBRcm5RcXZ3WVFMVTByWmJSUTN0?=
 =?utf-8?Q?YOxuLD?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5819.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(10070799003)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?dysxU3NrdW9ESDBzT0JHMUpIeXNEbzVrZzQvbFh0TVdUd0p6Znl0a0ZTTW4w?=
 =?utf-8?B?cHB1eTY4YWVQdUNUbExHQzliMkJWTWduVTRqQ3ZadW1qVkw4bzRoRW90T3Iw?=
 =?utf-8?B?RExaeDRrelpKWituK0E3M2VIanZEaHFGZTFXUUpmRms0SHBrT1pKSm1oZHJM?=
 =?utf-8?B?Ylo0NUlXQ2FrcHpMZXBVK2N1YXplRE1RdHIvNkxEWWsyLzdQZFMyTVRHZnJI?=
 =?utf-8?B?ZjhyTVRwM1JqTG1Yc1BRUGd3d2VuV04yTkJDRFlyOVQxU0xlUE15dmZyZHd5?=
 =?utf-8?B?Nk1QNkRhMmpucDNTRklVU1lLTzF5SUxETm13dWp1bExwVjk2dGx6akpVTFB2?=
 =?utf-8?B?SHh0a2xKcjdMWEVOZzVaRm9Yd3hDbXVsd2FWVWFoZllsWEEwRHBOeEhmYWx2?=
 =?utf-8?B?YjBEcVNXb0NwYUhDdVhTU04zd1NXaVBrV1R0UGRyT1JPVkl5WklsK2I3RDZk?=
 =?utf-8?B?NlE4c3BLRmR2UGVhOVZ3MUlVUTdBSGlZNVpxSWh2a0tCR0NtMFVERXJ6aHMr?=
 =?utf-8?B?Z0p0aVFMeTNwMFRiL3dZdFNvbDRrUEFyTENyckcycjVxQTRlOWdnZGRXT25u?=
 =?utf-8?B?dUZwNnp1NkFFNDc3VXBzYzByR1ZxbGJNNHVGVU15WUVybmVER1AzNEpOR2Iz?=
 =?utf-8?B?ZjRJYiszTDVIdC93UW41N1dlanhPdEQxSnRRd2l1dVhuQWFuS3NoZXJxODRr?=
 =?utf-8?B?QkZiZUloaWxyT3JVQmZxd2M0TXEzTE1mUnliS1lGYy9CRkh1OVQ2ZnlIcUlw?=
 =?utf-8?B?VUs1V0s2MHc3MDlGT01Qb0JqUDRmbEZ6d0draklycHFLSXNzejhrWllMQStZ?=
 =?utf-8?B?YzV5QUV3L1Y5V0hvVUF2b3FvUWh4OVZvVUdzcEFId3dNUXgyZGFrdHJjU0dJ?=
 =?utf-8?B?ZXNhaCs1NWdKMFdyT09DazE2NDJVODNXckE0VkVLcS9pSVBjbWxOMFdMaDh4?=
 =?utf-8?B?UDNzYU8zak82WWQ5a01Ud3FTUkExcHV4UERxK3ExZkdhei8rY0ptRkE3RFlM?=
 =?utf-8?B?UkpnZHZnSWErbmJxbnRhYi9ZM3MyMFJnRFA2WDd5czFUd1VLRlRlakhTVmsy?=
 =?utf-8?B?R2U3SDhqOXhORXJVV1NTNVNPQXFmM0grVi93UE5YQlMvdWhTOENqUFJwYjY2?=
 =?utf-8?B?MnhTM2tRYWhqMFp0TXpEMzNlWmpha2tsUDVMVDZtSTRUdlFSQUdBWS9LRG96?=
 =?utf-8?B?b1RKMU95WlEveTBnUDZtU0pwVDQvU0FHMnV0eFRQQjJQNEd0eHlvSjhSamk5?=
 =?utf-8?B?YjZ5QjcrRXhKSlRJRVc3Tml5NDhGVEpIV0tNem1PTDY1VERLTTdNK1JabVJv?=
 =?utf-8?B?YlJsZnVreE80V1pFNzN5SEtzZXYrNkgrSUtmems1bWNFVUZMa3ptQ0JLeTJs?=
 =?utf-8?B?VHo3UzMvc3hsV0lxcDFIMnVIUC9sVkNDRitPbk1Zb1haWmE3L2p5dnBUS1I5?=
 =?utf-8?B?ckJaK1c5WFAyN2FlTXlaVnQ3d21lM3FoMHA5bmtsd1FlV2dnaE9qcHN4T1Fq?=
 =?utf-8?B?R0pYa2xvanE2WENlRFB4WURST1FEaTBCYWZtWFNZZXc3bXlVYUR4alpCSHht?=
 =?utf-8?B?N3lFYUpWeXh5b0dwVE5kVUV5cGd1WCtIdmV1YlFCQnBuVFJUWVBwRXBQNWNJ?=
 =?utf-8?B?ZlVFdDRndEhDTFpLczZvYU9sVTNtejZuRHZJaDRDelcxWmxsaVM2a1ZtN2NB?=
 =?utf-8?B?RDM1WjY5MzBsRmNLSzA0Q1lKdFd4eVIzMEdmcnFpYmZsemlTMHdPVHlPakhw?=
 =?utf-8?B?cjhpOUZXVWEzZEY3ZW41OXZabWlFOUo5c0FseWJxVHViNkx2enZxVWhkMS9D?=
 =?utf-8?B?Q2pjRUhtS3BqMFFoZ1hQNG5Qbi82cjdvYjIzZ25RTTVtK1hwQzZFNlBuMVJs?=
 =?utf-8?B?eVljZFE2b0xCaTIrcnZWcmlvQzZWcFlnRWZ3b0Y5SjNWN1BGR3FIVGc5WW9I?=
 =?utf-8?B?Q2JoSzF4cVRRQUN5TVladlVYTXJ5d0UybEtVeE55Um9LeEMwS0Yyc0x4M1kw?=
 =?utf-8?B?eWZnTUhqaExvMVZoem5HNVJkaWszeWtoNTQ1RVEzZlNTdW9FV2hOVTBqSFJj?=
 =?utf-8?B?TzVYK01HRG5kbFEwSzZtc3djYVVDdVR6VzZic3JmbW1CdlFXVXh3aGthY2Vy?=
 =?utf-8?B?U0dxQ3VaNG9EYUZ6QW10dUdVSWo2cW84akhjQUgzN0V0VXNTTGdPdjZHYmJ4?=
 =?utf-8?Q?c+uk+bVgd8Oe5kbkIdiBHhY=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6AB5FB12A50527418FF80FDEC14B5902@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5819.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 343d9a73-b97f-4569-eeb2-08de31314306
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Dec 2025 23:27:58.0313
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YTUG6e21xLSXsFFSF6fb9mpY9iIcGB7nby78II6rCG/j/YR+qlChmx3oZdBer0q9zwnwmLqZ2JC2QOIDcSVolA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR15MB5989
X-Proofpoint-ORIG-GUID: zzSniC-i1pT5FChaNadSguGSQ8L3RnwD
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTI5MDAxNiBTYWx0ZWRfXxH2SnWEdNHr0
 bU5iVPWzu3ZD3qLp7iiDCU86J/WTj/u6i0y2P0Znnv3A9hc6fehJO3GdV3PAq1K0fvjyTyq32sF
 Y30uz/TJpENmB413zhI1gXBePlSJee0i4yEsKIxmYEXmy02z/8XuDbrG4Cj4apPx9UL35woNZ4T
 fl2lk60gXjHBmqtqX6wMtiOwnKAYR6nLR2qQefgXCWL5qkaOII2j7nWDCXwB5DckRhlOlQSj/L9
 jDorkiRzPNEiQC79/sra7EEOOysQrA8MZu0+x67ZXd4clfCAScH9mwcjLjzBLTF/YEPD5p9dQnn
 kzDZ84fUMwNf3UQ0E1KXkOa0LMxmoGcr9e2MlfK5NvxLVZuNst+gbRCHVDsUevQu9qkb7+d2+8i
 xWbT9HDoQ97Idx5o3HZlrhXhy4Eldg==
X-Authority-Analysis: v=2.4 cv=UO7Q3Sfy c=1 sm=1 tr=0 ts=692e2481 cx=c_pps
 a=fvoc8Rb8ruZSznP819E46A==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=20KFwNOVAAAA:8
 a=rxiNKpY3CPn0s67FIDEA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: SURSduuTGbgFVYaC2Rk4tnjXRoHN78av
Subject: Re:  [PATCH 2/3] ceph: parse subvolume_id from InodeStat v9 and store
 in inode
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-28_08,2025-11-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 bulkscore=0 adultscore=0 priorityscore=1501
 impostorscore=0 spamscore=0 phishscore=0 clxscore=1015 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2511290016

T24gVGh1LCAyMDI1LTExLTI3IGF0IDEzOjQ2ICswMDAwLCBBbGV4IE1hcmt1emUgd3JvdGU6DQo+
IEFkZCBzdXBwb3J0IGZvciBwYXJzaW5nIHRoZSBzdWJ2b2x1bWVfaWQgZmllbGQgZnJvbSBJbm9k
ZVN0YXQgdjkgYW5kDQo+IHN0b3JpbmcgaXQgaW4gdGhlIGlub2RlIGZvciBsYXRlciB1c2UgYnkg
c3Vidm9sdW1lIG1ldHJpY3MgdHJhY2tpbmcuDQo+IA0KPiBUaGUgc3Vidm9sdW1lX2lkIGlkZW50
aWZpZXMgd2hpY2ggQ2VwaEZTIHN1YnZvbHVtZSBhbiBpbm9kZSBiZWxvbmdzIHRvLA0KPiBlbmFi
bGluZyBwZXItc3Vidm9sdW1lIEkvTyBtZXRyaWNzIGNvbGxlY3Rpb24gYW5kIHJlcG9ydGluZy4N
Cj4gDQo+IFRoaXMgcGF0Y2g6DQo+IC0gQWRkcyBzdWJ2b2x1bWVfaWQgZmllbGQgdG8gc3RydWN0
IGNlcGhfbWRzX3JlcGx5X2luZm9faW4NCj4gLSBBZGRzIGlfc3Vidm9sdW1lX2lkIGZpZWxkIHRv
IHN0cnVjdCBjZXBoX2lub2RlX2luZm8NCj4gLSBQYXJzZXMgc3Vidm9sdW1lX2lkIGZyb20gdjkg
SW5vZGVTdGF0IGluIHBhcnNlX3JlcGx5X2luZm9faW4oKQ0KPiAtIEFkZHMgY2VwaF9pbm9kZV9z
ZXRfc3Vidm9sdW1lKCkgaGVscGVyIHRvIHByb3BhZ2F0ZSB0aGUgSUQgdG8gaW5vZGVzDQo+IC0g
SW5pdGlhbGl6ZXMgaV9zdWJ2b2x1bWVfaWQgaW4gaW5vZGUgYWxsb2NhdGlvbiBhbmQgY2xlYXJz
IG9uIGRlc3Ryb3kNCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEFsZXggTWFya3V6ZSA8YW1hcmt1emVA
cmVkaGF0LmNvbT4NCj4gLS0tDQo+ICBmcy9jZXBoL2lub2RlLmMgICAgICB8IDE5ICsrKysrKysr
KysrKysrKysrKysNCj4gIGZzL2NlcGgvbWRzX2NsaWVudC5jIHwgIDcgKysrKysrKw0KPiAgZnMv
Y2VwaC9tZHNfY2xpZW50LmggfCAgMSArDQo+ICBmcy9jZXBoL3N1cGVyLmggICAgICB8ICAyICsr
DQo+ICA0IGZpbGVzIGNoYW5nZWQsIDI5IGluc2VydGlvbnMoKykNCj4gDQo+IGRpZmYgLS1naXQg
YS9mcy9jZXBoL2lub2RlLmMgYi9mcy9jZXBoL2lub2RlLmMNCj4gaW5kZXggYTZlMjYwZDllNDIw
Li5jM2ZiNGRhYzQ2OTIgMTAwNjQ0DQo+IC0tLSBhL2ZzL2NlcGgvaW5vZGUuYw0KPiArKysgYi9m
cy9jZXBoL2lub2RlLmMNCj4gQEAgLTYzOCw2ICs2MzgsNyBAQCBzdHJ1Y3QgaW5vZGUgKmNlcGhf
YWxsb2NfaW5vZGUoc3RydWN0IHN1cGVyX2Jsb2NrICpzYikNCj4gIA0KPiAgCWNpLT5pX21heF9i
eXRlcyA9IDA7DQo+ICAJY2ktPmlfbWF4X2ZpbGVzID0gMDsNCj4gKwljaS0+aV9zdWJ2b2x1bWVf
aWQgPSAwOw0KDQpTbywgd2hpY2ggbnVtYmVyIHN0YXJ0cyB0byBpZGVudGlmeSBzdWJ2b2x1bWUg
SUQ/IElzIDAgdmFsaWQgaWRlbnRpZmljYXRpb24NCm51bWJlcj8NCg0KSWYgMCBpcyB2YWxpZCBp
ZGVudGlmaWNhdGlvbiBudW1iZXIsIHRoZW4gSSBhc3N1bWUgd2UgbmVlZCB0byBhc3NpZ24gc29t
ZSBvdGhlcg0KbnVtYmVyIGJlY2F1c2Ugd2UgZG9uJ3Qga25vdyB0aGUgc3Vidm9sdW1lIElEIHll
dC4gV2hhdCdzIGFib3V0IFU2NF9NQVgsIGZvcg0KZXhhbXBsZSwgb3Igc29tZSBvdGhlciBjb25z
dGFudCByZXByZXNlbnRpbmcgdGhlIGludmFsaWQgdmFsdWU/DQoNCj4gIA0KPiAgCW1lbXNldCgm
Y2ktPmlfZGlyX2xheW91dCwgMCwgc2l6ZW9mKGNpLT5pX2Rpcl9sYXlvdXQpKTsNCj4gIAltZW1z
ZXQoJmNpLT5pX2NhY2hlZF9sYXlvdXQsIDAsIHNpemVvZihjaS0+aV9jYWNoZWRfbGF5b3V0KSk7
DQo+IEBAIC03NDIsNiArNzQzLDggQEAgdm9pZCBjZXBoX2V2aWN0X2lub2RlKHN0cnVjdCBpbm9k
ZSAqaW5vZGUpDQo+ICANCj4gIAlwZXJjcHVfY291bnRlcl9kZWMoJm1kc2MtPm1ldHJpYy50b3Rh
bF9pbm9kZXMpOw0KPiAgDQo+ICsJY2ktPmlfc3Vidm9sdW1lX2lkID0gMDsNCg0KRGl0dG8uDQoN
Cj4gKw0KPiAgCW5ldGZzX3dhaXRfZm9yX291dHN0YW5kaW5nX2lvKGlub2RlKTsNCj4gIAl0cnVu
Y2F0ZV9pbm9kZV9wYWdlc19maW5hbCgmaW5vZGUtPmlfZGF0YSk7DQo+ICAJaWYgKGlub2RlLT5p
X3N0YXRlICYgSV9QSU5OSU5HX05FVEZTX1dCKQ0KPiBAQCAtODczLDYgKzg3NiwxOCBAQCBpbnQg
Y2VwaF9maWxsX2ZpbGVfc2l6ZShzdHJ1Y3QgaW5vZGUgKmlub2RlLCBpbnQgaXNzdWVkLA0KPiAg
CXJldHVybiBxdWV1ZV90cnVuYzsNCj4gIH0NCj4gIA0KPiArdm9pZCBjZXBoX2lub2RlX3NldF9z
dWJ2b2x1bWUoc3RydWN0IGlub2RlICppbm9kZSwgdTY0IHN1YnZvbHVtZV9pZCkNCj4gK3sNCj4g
KwlzdHJ1Y3QgY2VwaF9pbm9kZV9pbmZvICpjaTsNCj4gKw0KPiArCWlmICghaW5vZGUgfHwgIXN1
YnZvbHVtZV9pZCkNCg0KQXJlIHlvdSBzdXJlIHRoYXQgMCBpcyBpbnZhbGlkIElEIGZvciBzdWJ2
b2x1bWVfaWQ/IFdoYXQgYWJvdXQgdG8gaW50cm9kdWNlIHNvbWUNCm5hbWVkIGNvbnN0YW50IGFu
ZCB0byBjb21wYXJlIGl0IHdpdGggc3Vidm9sdW1lX2lkIGhlcmU/IEZvciBleGFtcGxlLCB3ZSBj
YW4NCmludHJvZHVjZSBDRVBIX0lOVkFMSURfU1VCVk9MVU1FX0lELg0KDQppZiAoIWlub2RlIHx8
IHN1YnZvbHVtZV9pZCA9PSBDRVBIX0lOVkFMSURfU1VCVk9MVU1FX0lEKQ0KDQo+ICsJCXJldHVy
bjsNCj4gKw0KPiArCWNpID0gY2VwaF9pbm9kZShpbm9kZSk7DQo+ICsJaWYgKFJFQURfT05DRShj
aS0+aV9zdWJ2b2x1bWVfaWQpICE9IHN1YnZvbHVtZV9pZCkNCj4gKwkJV1JJVEVfT05DRShjaS0+
aV9zdWJ2b2x1bWVfaWQsIHN1YnZvbHVtZV9pZCk7DQoNClNob3VsZCB0aGUgY2VwaF9pbm9kZV9z
ZXRfc3Vidm9sdW1lKCkgb3BlcmF0aW9uIGJlIHByb3RlY3RlZCBieSBpX2NlcGhfbG9jaz8NCg0K
SWYgY2ktPmlfc3Vidm9sdW1lX2lkIGlzIGFscmVhZHkgY29ycmVjdCB2YWx1ZSwgdGhlbiBob3cg
Y29ycmVjdCBpcyByZXNldCBvZg0KdGhpcyB2YWx1ZT8gSSBhbSBhZnJhaWQgdGhhdCB3ZSBjb3Vs
ZCBoYXZlIHBvdGVudGlhbCBidWdzIGhlcmUuIE1heWJlLCB3ZSBzaG91bGQNCmhhdmUgbWV0aG9k
cyBvZiBzZXRfc3Vidm9sdW1lX2lkKCkvZGVsZXRlX3N1YnZvbHVtZV9pZCgpPw0KDQpIb3cgbG9v
a3MgbGlrZSB0aGUgaW50ZXJmYWNlIG9mIHNldHRpbmcgYW5kIHJlc2V0dGluZyB0aGUgc3Vidm9s
dW1lX2lkPw0KDQo+ICt9DQo+ICsNCj4gIHZvaWQgY2VwaF9maWxsX2ZpbGVfdGltZShzdHJ1Y3Qg
aW5vZGUgKmlub2RlLCBpbnQgaXNzdWVkLA0KPiAgCQkJIHU2NCB0aW1lX3dhcnBfc2VxLCBzdHJ1
Y3QgdGltZXNwZWM2NCAqY3RpbWUsDQo+ICAJCQkgc3RydWN0IHRpbWVzcGVjNjQgKm10aW1lLCBz
dHJ1Y3QgdGltZXNwZWM2NCAqYXRpbWUpDQo+IEBAIC0xMDg3LDYgKzExMDIsNyBAQCBpbnQgY2Vw
aF9maWxsX2lub2RlKHN0cnVjdCBpbm9kZSAqaW5vZGUsIHN0cnVjdCBwYWdlICpsb2NrZWRfcGFn
ZSwNCj4gIAluZXdfaXNzdWVkID0gfmlzc3VlZCAmIGluZm9fY2FwczsNCj4gIA0KPiAgCV9fY2Vw
aF91cGRhdGVfcXVvdGEoY2ksIGlpbmZvLT5tYXhfYnl0ZXMsIGlpbmZvLT5tYXhfZmlsZXMpOw0K
PiArCWNlcGhfaW5vZGVfc2V0X3N1YnZvbHVtZShpbm9kZSwgaWluZm8tPnN1YnZvbHVtZV9pZCk7
DQo+ICANCj4gICNpZmRlZiBDT05GSUdfRlNfRU5DUllQVElPTg0KPiAgCWlmIChpaW5mby0+ZnNj
cnlwdF9hdXRoX2xlbiAmJg0KPiBAQCAtMTU5NCw2ICsxNjEwLDggQEAgaW50IGNlcGhfZmlsbF90
cmFjZShzdHJ1Y3Qgc3VwZXJfYmxvY2sgKnNiLCBzdHJ1Y3QgY2VwaF9tZHNfcmVxdWVzdCAqcmVx
KQ0KPiAgCQkJZ290byBkb25lOw0KPiAgCQl9DQo+ICAJCWlmIChwYXJlbnRfZGlyKSB7DQo+ICsJ
CQljZXBoX2lub2RlX3NldF9zdWJ2b2x1bWUocGFyZW50X2RpciwNCj4gKwkJCQkJCSByaW5mby0+
ZGlyaS5zdWJ2b2x1bWVfaWQpOw0KPiAgCQkJZXJyID0gY2VwaF9maWxsX2lub2RlKHBhcmVudF9k
aXIsIE5VTEwsICZyaW5mby0+ZGlyaSwNCj4gIAkJCQkJICAgICAgcmluZm8tPmRpcmZyYWcsIHNl
c3Npb24sIC0xLA0KPiAgCQkJCQkgICAgICAmcmVxLT5yX2NhcHNfcmVzZXJ2YXRpb24pOw0KPiBA
QCAtMTY4Miw2ICsxNzAwLDcgQEAgaW50IGNlcGhfZmlsbF90cmFjZShzdHJ1Y3Qgc3VwZXJfYmxv
Y2sgKnNiLCBzdHJ1Y3QgY2VwaF9tZHNfcmVxdWVzdCAqcmVxKQ0KPiAgCQlCVUdfT04oIXJlcS0+
cl90YXJnZXRfaW5vZGUpOw0KPiAgDQo+ICAJCWluID0gcmVxLT5yX3RhcmdldF9pbm9kZTsNCj4g
KwkJY2VwaF9pbm9kZV9zZXRfc3Vidm9sdW1lKGluLCByaW5mby0+dGFyZ2V0aS5zdWJ2b2x1bWVf
aWQpOw0KPiAgCQllcnIgPSBjZXBoX2ZpbGxfaW5vZGUoaW4sIHJlcS0+cl9sb2NrZWRfcGFnZSwg
JnJpbmZvLT50YXJnZXRpLA0KPiAgCQkJCU5VTEwsIHNlc3Npb24sDQo+ICAJCQkJKCF0ZXN0X2Jp
dChDRVBIX01EU19SX0FCT1JURUQsICZyZXEtPnJfcmVxX2ZsYWdzKSAmJg0KPiBkaWZmIC0tZ2l0
IGEvZnMvY2VwaC9tZHNfY2xpZW50LmMgYi9mcy9jZXBoL21kc19jbGllbnQuYw0KPiBpbmRleCAz
MjU2MWZjNzAxZTUuLjZmNjYwOTdmNzQwYiAxMDA2NDQNCj4gLS0tIGEvZnMvY2VwaC9tZHNfY2xp
ZW50LmMNCj4gKysrIGIvZnMvY2VwaC9tZHNfY2xpZW50LmMNCj4gQEAgLTEwNSw2ICsxMDUsOCBA
QCBzdGF0aWMgaW50IHBhcnNlX3JlcGx5X2luZm9faW4odm9pZCAqKnAsIHZvaWQgKmVuZCwNCj4g
IAlpbnQgZXJyID0gMDsNCj4gIAl1OCBzdHJ1Y3RfdiA9IDA7DQo+ICANCj4gKwlpbmZvLT5zdWJ2
b2x1bWVfaWQgPSAwOw0KDQpTaG91bGQgd2UgaGF2ZSBtZXRob2QgZm9yIHN0cnVjdCBjZXBoX21k
c19yZXBseV9pbmZvX2luIGxpa2V3aXNlIGZvciBzdHJ1Y3QNCmNlcGhfaW5vZGVfaW5mbz8NCg0K
PiArDQo+ICAJaWYgKGZlYXR1cmVzID09ICh1NjQpLTEpIHsNCj4gIAkJdTMyIHN0cnVjdF9sZW47
DQo+ICAJCXU4IHN0cnVjdF9jb21wYXQ7DQo+IEBAIC0yNDMsNiArMjQ1LDEwIEBAIHN0YXRpYyBp
bnQgcGFyc2VfcmVwbHlfaW5mb19pbih2b2lkICoqcCwgdm9pZCAqZW5kLA0KPiAgCQkJY2VwaF9k
ZWNvZGVfc2tpcF9uKHAsIGVuZCwgdjhfc3RydWN0X2xlbiwgYmFkKTsNCj4gIAkJfQ0KPiAgDQo+
ICsJCS8qIHN0cnVjdF92IDkgYWRkZWQgc3Vidm9sdW1lX2lkICovDQo+ICsJCWlmIChzdHJ1Y3Rf
diA+PSA5KQ0KPiArCQkJY2VwaF9kZWNvZGVfNjRfc2FmZShwLCBlbmQsIGluZm8tPnN1YnZvbHVt
ZV9pZCwgYmFkKTsNCg0KQXMgZmFyIGFzIEkgcmVtZW1iZXIgZnJvbSBwcmV2aW91cyBwYXRjaCB3
ZSBoYWQgdmVyc2lvbiA4IGFuZCB3ZSBkb24ndCBzdXBwb3J0DQppdC4gRG8gd2UgbWVhbiB0aGUg
dmVyc2lvbiA5IG9mIGFub3RoZXIgcHJvdG9jb2wgaGVyZT8NCg0KVGhhbmtzLA0KU2xhdmEuDQoN
Cj4gKw0KPiAgCQkqcCA9IGVuZDsNCj4gIAl9IGVsc2Ugew0KPiAgCQkvKiBsZWdhY3kgKHVudmVy
c2lvbmVkKSBzdHJ1Y3QgKi8NCj4gQEAgLTM5NjIsNiArMzk2OCw3IEBAIHN0YXRpYyB2b2lkIGhh
bmRsZV9yZXBseShzdHJ1Y3QgY2VwaF9tZHNfc2Vzc2lvbiAqc2Vzc2lvbiwgc3RydWN0IGNlcGhf
bXNnICptc2cpDQo+ICAJCQlnb3RvIG91dF9lcnI7DQo+ICAJCX0NCj4gIAkJcmVxLT5yX3Rhcmdl
dF9pbm9kZSA9IGluOw0KPiArCQljZXBoX2lub2RlX3NldF9zdWJ2b2x1bWUoaW4sIHJpbmZvLT50
YXJnZXRpLnN1YnZvbHVtZV9pZCk7DQo+ICAJfQ0KPiAgDQo+ICAJbXV0ZXhfbG9jaygmc2Vzc2lv
bi0+c19tdXRleCk7DQo+IGRpZmYgLS1naXQgYS9mcy9jZXBoL21kc19jbGllbnQuaCBiL2ZzL2Nl
cGgvbWRzX2NsaWVudC5oDQo+IGluZGV4IDA0MjhhNWVhZjI4Yy4uYmQzNjkwYmFhNjVjIDEwMDY0
NA0KPiAtLS0gYS9mcy9jZXBoL21kc19jbGllbnQuaA0KPiArKysgYi9mcy9jZXBoL21kc19jbGll
bnQuaA0KPiBAQCAtMTE4LDYgKzExOCw3IEBAIHN0cnVjdCBjZXBoX21kc19yZXBseV9pbmZvX2lu
IHsNCj4gIAl1MzIgZnNjcnlwdF9maWxlX2xlbjsNCj4gIAl1NjQgcnNuYXBzOw0KPiAgCXU2NCBj
aGFuZ2VfYXR0cjsNCj4gKwl1NjQgc3Vidm9sdW1lX2lkOw0KPiAgfTsNCj4gIA0KPiAgc3RydWN0
IGNlcGhfbWRzX3JlcGx5X2Rpcl9lbnRyeSB7DQo+IGRpZmYgLS1naXQgYS9mcy9jZXBoL3N1cGVy
LmggYi9mcy9jZXBoL3N1cGVyLmgNCj4gaW5kZXggYTFmNzgxYzQ2YjQxLi42OTA2OWM5MjA2ODMg
MTAwNjQ0DQo+IC0tLSBhL2ZzL2NlcGgvc3VwZXIuaA0KPiArKysgYi9mcy9jZXBoL3N1cGVyLmgN
Cj4gQEAgLTM4NSw2ICszODUsNyBAQCBzdHJ1Y3QgY2VwaF9pbm9kZV9pbmZvIHsNCj4gIA0KPiAg
CS8qIHF1b3RhcyAqLw0KPiAgCXU2NCBpX21heF9ieXRlcywgaV9tYXhfZmlsZXM7DQo+ICsJdTY0
IGlfc3Vidm9sdW1lX2lkOw0KPiAgDQo+ICAJczMyIGlfZGlyX3BpbjsNCj4gIA0KPiBAQCAtMTA1
Nyw2ICsxMDU4LDcgQEAgZXh0ZXJuIHN0cnVjdCBpbm9kZSAqY2VwaF9nZXRfaW5vZGUoc3RydWN0
IHN1cGVyX2Jsb2NrICpzYiwNCj4gIGV4dGVybiBzdHJ1Y3QgaW5vZGUgKmNlcGhfZ2V0X3NuYXBk
aXIoc3RydWN0IGlub2RlICpwYXJlbnQpOw0KPiAgZXh0ZXJuIGludCBjZXBoX2ZpbGxfZmlsZV9z
aXplKHN0cnVjdCBpbm9kZSAqaW5vZGUsIGludCBpc3N1ZWQsDQo+ICAJCQkgICAgICAgdTMyIHRy
dW5jYXRlX3NlcSwgdTY0IHRydW5jYXRlX3NpemUsIHU2NCBzaXplKTsNCj4gK2V4dGVybiB2b2lk
IGNlcGhfaW5vZGVfc2V0X3N1YnZvbHVtZShzdHJ1Y3QgaW5vZGUgKmlub2RlLCB1NjQgc3Vidm9s
dW1lX2lkKTsNCj4gIGV4dGVybiB2b2lkIGNlcGhfZmlsbF9maWxlX3RpbWUoc3RydWN0IGlub2Rl
ICppbm9kZSwgaW50IGlzc3VlZCwNCj4gIAkJCQl1NjQgdGltZV93YXJwX3NlcSwgc3RydWN0IHRp
bWVzcGVjNjQgKmN0aW1lLA0KPiAgCQkJCXN0cnVjdCB0aW1lc3BlYzY0ICptdGltZSwNCg==


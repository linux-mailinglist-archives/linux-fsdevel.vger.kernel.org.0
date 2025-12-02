Return-Path: <linux-fsdevel+bounces-70482-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A7F12C9CF72
	for <lists+linux-fsdevel@lfdr.de>; Tue, 02 Dec 2025 21:50:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6E6134E3CDD
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Dec 2025 20:50:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D00DE2F691F;
	Tue,  2 Dec 2025 20:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="OyPY1GUu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88ED821883E;
	Tue,  2 Dec 2025 20:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764708637; cv=fail; b=tMNmejwW++CF0x1YlMmxOtcVA7O4/Z4pg6tgLluUkNlSvTg2PUv3tWaqR4ey/YcsStb+zMCnPhc9JpY+Qu/37i7FQXDEbMpGqQUzxCGOacT9QahnscTdQfHLwAtyU0mePbz3asa159QhQ8PTKwDJCGH+wirLFMTBf2f8hHJXP+I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764708637; c=relaxed/simple;
	bh=w6It2FQNJkMNhSH3zKc9s2sUH5L8vH9gbZoMx3k0a8w=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=tv5isJRsPnFcVp/2umOVS2mgya/lnYxbWTv8SkDDsy6PyxTmEFsx2tNTN5CyDeysqI/JXBwm4GbTNeBDmYl6N8B8JxxX05255wMtjnW5U/XvFOwD8TZdVnCDL0AT7U/Or2OoT0eg1i/MtcaGSEif3MAknrEF5Uxc8BaseSAyI6c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=OyPY1GUu; arc=fail smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5B2CRVav006817;
	Tue, 2 Dec 2025 20:50:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pp1; bh=w6It2FQNJkMNhSH3zKc9s2sUH5L8vH9gbZoMx3k0a8w=; b=OyPY1GUu
	MUK1cmuXriDwX485bjqW/DW2lyFs6q05mbDDCS6OMTG+t6mWo8n8vWYGyn9yEpAv
	AFiyv1MMbn7SC0N2CwYjFNS+zH2VCaTfF4xVD+QU6qcrVvSBBuH19ycEsXPfg9cN
	E1Ex4fEL0Ryabh2a/EKorEiwy2hJX/sLqphS8exPiyua6QNo67Broyg8MgpT63Kh
	TwC9V1e9wNBXIul3i3q/ubcYYVsAZ453WXIWKJEkh7TsoOVcpBKkYA89VVMspKeK
	W85IdSYy8GZORDA6yh5fe3pWhx7EZo2Y2hBDkRnaBmb0XraQNTFe55LAGhCxo8tA
	4ghUUyBmC2ASrA==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4aqrbg7ck5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 02 Dec 2025 20:50:32 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5B2KlSMH025508;
	Tue, 2 Dec 2025 20:50:32 GMT
Received: from ph0pr06cu001.outbound.protection.outlook.com (mail-westus3azon11011043.outbound.protection.outlook.com [40.107.208.43])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4aqrbg7ck1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 02 Dec 2025 20:50:32 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XO8bLnFoEDbCmcTczmp2NmHhOt8LqBJw2Tq2MBuaEBpilDJA9XIMcBnHXYTEfUYqxcLcHOIZigHt+UJ7oKql+P70L478ZMl/snXcIPUYreKM/ukyU8tpqjCgz8kJRdys2TUpiWOJp6PhyneYhnBjCtMWzQRN6pJWCIcboIs1zXR7yQYeGAWMFyUmXgMkVDT54f0LjInZlfsYJFN05f9zZbZ4TOWqFy8wyovJTOXd0WBnQgEs/tc+tT6D4pkFH7ZRzHPdU7P9u5LrT9/wbDuSe0gHmPP7iIZrYINthNJ+tWLu93+q88RJlDPIM/2k5I17be4o91x3lXCuMFlXa+neFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w6It2FQNJkMNhSH3zKc9s2sUH5L8vH9gbZoMx3k0a8w=;
 b=W+AVEZrBDgLqI2hDys7RUk8Gn94pksI2H+2eNyQxUxvX2KBaEHqOZ1Op317DRsa8Z8WEM1tabQn+ESvjIb/Qc+uxlCIehaP+ZG7UbZqiQlNuPK6X0n74DxzJTDYf4PT9SUWSBKduqfIqpMlo5yt7vM01Ns3fkBTdvYWqJOsRVLbUAL6OYow4ZlJuZhrILau/4+AGcaZHi0owCkYVWYD7mYMa8rQjD38EdaFei3sFdultz97bBz4aThkZCFcXs5EcH5TP4A5h4JRogLeQc7bgxYaFm0mlgpnQdvQ6vCnASuab2weUDbCpBqzMFBFcaWUau96vU3O+n8dx0801Lk2sGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SA1PR15MB5819.namprd15.prod.outlook.com (2603:10b6:806:338::8)
 by BL1PPFDD4142DB7.namprd15.prod.outlook.com (2603:10b6:20f:fc04::e4b) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.9; Tue, 2 Dec
 2025 20:50:26 +0000
Received: from SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539]) by SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539%4]) with mapi id 15.20.9388.003; Tue, 2 Dec 2025
 20:50:26 +0000
From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
To: Alex Markuze <amarkuze@redhat.com>,
        "ceph-devel@vger.kernel.org"
	<ceph-devel@vger.kernel.org>
CC: Viacheslav Dubeyko <vdubeyko@redhat.com>,
        "idryomov@gmail.com"
	<idryomov@gmail.com>,
        "linux-fsdevel@vger.kernel.org"
	<linux-fsdevel@vger.kernel.org>
Thread-Topic: [EXTERNAL] [PATCH v2 2/3] ceph: parse subvolume_id from
 InodeStat v9 and store in inode
Thread-Index: AQHcY6SMd9G08eRjFkmFQLWdcf/RPbUO00eA
Date: Tue, 2 Dec 2025 20:50:26 +0000
Message-ID: <c41cdb3ac27d04bf79d6b22705ec045c11df4798.camel@ibm.com>
References: <20251202155750.2565696-1-amarkuze@redhat.com>
	 <20251202155750.2565696-3-amarkuze@redhat.com>
In-Reply-To: <20251202155750.2565696-3-amarkuze@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5819:EE_|BL1PPFDD4142DB7:EE_
x-ms-office365-filtering-correlation-id: 47d53b6b-d022-4f58-4ba1-08de31e46bf7
x-ld-processed: fcf67057-50c9-4ad4-98f3-ffca64add9e9,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|366016|10070799003|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?Zm8zZTUyNjdHTGtyV2JyOUNIbHBGR2YwaTZpbkFMKzI1MFl2WjlxRUwwMTVK?=
 =?utf-8?B?LzhsL1YzZzdtaWswdmQ2L3VyYytWL2w3MEJOSllYZWxTQ1A4SEE3QWdsTHA0?=
 =?utf-8?B?di9DbkliZ0lBbEJnWWRXeXRkTFQ3N2ZrNndEc3hyTm11NjlmSFVHays5ZHZn?=
 =?utf-8?B?MHp0NVNBdGtianA2UUNYTmRva3gvZWtjQlBSSC91Mjh0REo5UUt5YUxWNG5S?=
 =?utf-8?B?ME1FakFRUUhzbVFHK0RWeisyQ2xibGcrTHdsdkwyNDh5TzVLa1VzRzgyRkQ4?=
 =?utf-8?B?R0M1amdtQUo3ZmNUM09XM2YvWFpRdXh0eEhsanpLbHBHNU5GZW9UN0ZjSDJF?=
 =?utf-8?B?QTI2cjNkSmpndit0Z21Pa1NPd1F4MlNpWkpkeTNSWWp5ZG51Qnl3OUx3V0Jy?=
 =?utf-8?B?REQrQVl3M2dKWlhOdU16SHc1c1k1ODE0NndrV1BlTjlBQ05jcE9tSnRVMDVZ?=
 =?utf-8?B?TU5OQWVteHB0MkRTRU95TVJndDI2M0RCcXZTeW1pa0prRmpiRW02aGl3UCt0?=
 =?utf-8?B?TEpXaFhyTkM1bEdGeXh5a09uVEtsdjMwcmNiTlNGaVlnTnF4TWpYY05RQnk3?=
 =?utf-8?B?V2liZ0txK2tyc2t3N09hZnFyaGc3cDZyZm9MbHEwYStlRTAyd3I4Mzl1WkM0?=
 =?utf-8?B?OFJvUEt3Y05Db3pFd3h4TlFoZnBTeUMwREJPZmVmNTlMWjZpb1ZmY3k2Mmxn?=
 =?utf-8?B?eHhZNmhacUs1bU9RWlJ5ejliN2ExQ1NsZWhadnozTE5IRXJaRzhuVnROWERK?=
 =?utf-8?B?SHJOdTVtRVVLTlRSNE1EYmdWUWpWWGdyRU9sS21tcFpsaFJyWncyRXdhTElt?=
 =?utf-8?B?RndwVThuMEZkV20rUHQyNFV1V3A0VFo2VFpDcXd4cHJHckVLM0NlMHNFd2pq?=
 =?utf-8?B?cFViZFl4OGNTQUlPMTNBQkFhWHhhYWJkczdyRjdzejVRREFYdEtXTHBXMXBx?=
 =?utf-8?B?K0t3dDNLRTgxS1B0ZWFZZ2VkMkFTWCtTd2RUaWJwdnZJK0dEcGtnMzFQdnlB?=
 =?utf-8?B?RXR5bW9xK3krN2c3QnBEV0hZYzdzeG9aRE1LWDB2cGdacjlNejRabVBZSmlV?=
 =?utf-8?B?dlRJWDdKR1ZUVCtsSm1FZlk4YXF4cWZtRWV3T0JoM09MR1hmSW9tdTNuQVFu?=
 =?utf-8?B?MzR5TFdjTGZQbHZSczNYU1crdHJrSDBpSGlsdDhmV2NOcXdMa2R2U2RKNWlP?=
 =?utf-8?B?OW1LZEZRZXBiOUVacUhlMUh1cEM2VDU3VitMYXBCeWx0UzJjWXc3NUh6aFpu?=
 =?utf-8?B?dUlFM2N6ZHQycXBYNzc2MThldmJCUDEyRFpGWi9wMFhlWld0QlhiSnhxTmFh?=
 =?utf-8?B?bTY2eldyYUVwYWYybldBVElqVEJNbHRjb3dNMWcwQUNOYlNmWUMrSmFDcFBH?=
 =?utf-8?B?MmZ1NGRJWlI1cENHejJ3dVhmcnp5VVFEUzdFZ1hpdmsyQ0p2emJDYmE4d2dw?=
 =?utf-8?B?TEQ1OVQ3aFdQelp1LzZJU3ZBTDY3cm9kSkN1RTRJMlM0MmdiaWR4QWJuMkZT?=
 =?utf-8?B?OXFpUm0vT0xhTTIzQThDNHk3R3MxWjJxOTVtbVJ0and1NllBd0twSUhsdllu?=
 =?utf-8?B?TGZlU0dUTUhueDFCZ3NyK3N2YXhrTnJMTTZ3cndUSTRtUEtsc2NkcDZEUlhQ?=
 =?utf-8?B?YXhNcE9DWEtBS0NSSitOMTNka3R6WjZ1WTEyRUorcTBTOERHVVpGOWt6a0I3?=
 =?utf-8?B?UFl5eS82WXFpS2lBcGYwQnF3ZzdkeENTWU4xNnZHZTBydlVMSmR2a2VTQ0Yr?=
 =?utf-8?B?TUFxT2U4ZW9xM3ZGNDk5ZlYrbDZlQm1rUlNmK0laZWt5S2UzWVpwWkxKcGVa?=
 =?utf-8?B?b2MxN2hTQkw1czBSdXJuejdXL1F6SFVtWmR6WTVpTFc5QW45NndmMmdWeHBL?=
 =?utf-8?B?ajQ5TWdDaUtmZ2d5U0VWVEhMMzB0YzRHVktIcWNTQURpY0dHSThQbUhHNXI2?=
 =?utf-8?B?ZkZLRWwxQ2FmbnhuSURtWVdEV3JnTjArTkpmdHNIVG5oaEpEck5TRWdnYVlZ?=
 =?utf-8?B?WmpOdWpoNnRPbWRpMUVrYjdRbG9LTGNvNEtMKzhNV3Q4MWtOOXJMdjV3SmdN?=
 =?utf-8?Q?WyQM0P?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5819.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(10070799003)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?QUhQMGlQMHpZdVZFVUNBeTMwWm5EbGUwQm8vTHhjYXlLbkdqMkloTEhPM3Zl?=
 =?utf-8?B?Vk9SYUk1SXkrSm5HNnAzTFdvOXRTZ1NzYUlaemhNeU9Ca3lUR3VVVVE3TzZs?=
 =?utf-8?B?eWhyRHl6QnA3UG5TOCtsRm5lOE4zdC90OWZsVS9xT2dHYVF3TTAyQ1QyRTlV?=
 =?utf-8?B?STJkN1lhZG02aWgrcHNxUFdueDhsTFFNZ1AzTXFyejNDWldSN1FsZnFjRkJ4?=
 =?utf-8?B?d1RnblFleHF5bS9VR1p3SGllTXVEQkg1L1pJZWNvbW9ESU9YYjJoYSs1NE90?=
 =?utf-8?B?Y3RRaWxybVVNTTFxNlpOeHpIMEY3eEVnTCtlLzRIdmZKOEcxUFp6R1oxWG5k?=
 =?utf-8?B?STRkcFd0YVlVQUJTdUYwSTBuZ1Bsc2Noajl0ZHRHSUVZN01Zb3dGNkdzK2tE?=
 =?utf-8?B?ekJyZzVGa2RSeGsvdVZkNFZpR1NHam01N1huL2R0UDZIUGlpeStzd2lONnFy?=
 =?utf-8?B?bE5FaUVLbnFLWUg0SjVtakMxOVVYNTRYaUNVYkJIYWdDQkJLM1FJTTFQeFJu?=
 =?utf-8?B?a05Ga21LeHRZNVhBRWJhY2dnN0xNUjFTVkhTRklaR0kxT1JnVXlvVy85aUgr?=
 =?utf-8?B?V0hhL1g1ajVnUW9aYnJZVEY5ZUxzZkgxWHpjOFFtY1FvWWUzSEZuUGsvUFJ5?=
 =?utf-8?B?SzljRVQvRENGU0xBQ3lIaG83ZFlPNGdVN3RjRmptUU1vOVcxK0wwanp5QUxM?=
 =?utf-8?B?MENma0NYL1JIaFNNWHlBZjVDVHE0VlZPL2tGVGVSZFFKZ2xBM29kZFlyVnlI?=
 =?utf-8?B?cldMOXVHbzhtY2YzZkgvaWc0R00vcU9MNWFwK3Z3RE5uYzEwUGg0OEMyQ3NJ?=
 =?utf-8?B?eXU3bHdnRHdXRnpRdlIrWlFMQWtGM2RXSTZSc05SQXgyN3REN05UNTFLeGhD?=
 =?utf-8?B?ZkVKKzhhcEV3N3RDSm0ybmhGY0hCN3U2anpZQW5jQVp4U2RZcDMvMzV0NlAr?=
 =?utf-8?B?MFRxN2Y1UmY4dFJOU2hZa1ZGSnlzaUtRNzdqMXhpZklsYWREL1Y5WnpsNUZo?=
 =?utf-8?B?S2J0K3BRZU1VcUROVTIrNVhqZ2JxNXovU2RNalA2RXVEMUJuZC8rV2RnRURx?=
 =?utf-8?B?d3lnOTFPdm05OU9KTy95ODh2eUk1ZThXTzM0VG9UbHVsdFpwNUNZRGpLS3gz?=
 =?utf-8?B?UWRuRmowTFJ2L0dMRlMxMVVRczEzUjJhWTdyeEprNEI4bzRycW1ObVBESHJw?=
 =?utf-8?B?ekVNMW5YU2VLL1k3SXhxY3RqMENLQnhPTWRYbUhGL1hhTnh2SXM3dUEzZGEz?=
 =?utf-8?B?UTRUaXhPNHNSN0xuQ0dqbVZoU3pQTFM3OSttcDZZdjBEOWFYeXJCb0Nqa3JZ?=
 =?utf-8?B?cWtpZTlqVXEwYVJwUHZMUng2aW8yZC9lTDl6emZDWlVBUHBhN2JLeWhMZUpw?=
 =?utf-8?B?bWw1bW1OdFlrS0VGZnVMNnJScnQwZzB1d0NTdWVFOURWdEVPZkVJUjZUaHlC?=
 =?utf-8?B?cWVUOFo1RUpCaE5WWkpUVTEreVFkMXZHVjF0U0JHY3E0YzdydGpXWDVla0hL?=
 =?utf-8?B?T0FkVmJFR0lJRGtkRlJ3TTFEd29pOTlGVU5TLzBxd3VZZ00rMWgxVHFLUDUx?=
 =?utf-8?B?T085RkpacGVKUUUzRElIRVhxTXdNd0R1U3ZJOWpxaVA1QlFSLzlZNW5GNm9z?=
 =?utf-8?B?RjdOeHJOM2NyamVaT0xBU0RuYWhLUFFSYnU2eTRKd1dtMThmQ1loMGlHakM1?=
 =?utf-8?B?Nm5lcVQ0Nmd0amdSbnhsMjFFSC82NUtQKzFBbzEzVlFpYitkZnJ1cTFYU0U4?=
 =?utf-8?B?M004UHFaTnVlaTE0VXdmQ3IzNDlLeHZMSUFhVmNXZ0RxWkVSVWUvYkFYY0JV?=
 =?utf-8?B?Si9QbHNhRllldmwwUytQajBwcFB0cTFhbFIxdGl3dDE1d1l2azRUbmh1MXVt?=
 =?utf-8?B?UGpjdWEvazQ5dys0MlFsbisxZFZWbkNVT0tjZjNDSTVFMzk5ZzF2V2ZUUkt0?=
 =?utf-8?B?VlM4bVROOGVZYkdHTHJkenFLY1hQNkRzS2ZKeVVBbVJVVXRaSWVTQ2xkRzlh?=
 =?utf-8?B?R2VBZjdYR1Exak9lWFFVZWZzVGdkUFVxemxtc3RrcVg1cGpQR213a1B6UmJJ?=
 =?utf-8?B?UWx3VDZQNHJla1dBdVZ1TElFQmt3U3hqbEVnVGdxaGZUNVlhR3VWb1FrNmpR?=
 =?utf-8?B?VzM3YUM1WGpweC9BNmxBSDBOTlFlZXA1U28zSzQrZGd5cXQ2NHBBMlNjenRE?=
 =?utf-8?Q?9ERqHbsiBW4EOraJLdYjNi4=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <CA66364E79BBD04280692AE00147E9AB@namprd15.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 47d53b6b-d022-4f58-4ba1-08de31e46bf7
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Dec 2025 20:50:26.5814
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: M+xguuRA11hwVUFin783xRN19EOGIYNRFSfQ2vdw6vtYRNvsqrPApJqv5nl1MgIzrkOvEyeh6S3RaxPqLR7x3w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PPFDD4142DB7
X-Proofpoint-ORIG-GUID: 26RDi4LnNEaZHxp4ArMFCVkv_qAg5L-8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTI5MDAxNiBTYWx0ZWRfX2rXbLVrsVPLv
 3eUOct9vKcCe6IvAYl2zvR6OOB+HYQNCc0RPgO7BBlrgfHGpONZStxLxfUoYt5NZlc+z721FFGU
 v4g65GND3oiTfWwjgx8I+zmiO6SsZ8TYZqzswrG/JwH4N4lAnjfZs4JMckiaka5FyXTCECukSvx
 RNl5MZt5J4i0v6eWc4pPgCufqHrvZLYJK+S1ac/wh81qSN3NrGRSEcJZyYwd6Y0fLvATLpvIsOz
 XsTi3wEtS5V+V57Eyo/6LGKGXkXfJFbv6h77yqwf3ky/urrKthx5G0pr7UbxXK1tbLUbum6wchu
 IJRcusykzPRfc8mGTvwFbqoplF6ARCvDzfccmMs5xnBcrJYUQTKCUHTwTISr9j2TrxXtR3EnquG
 OH5aUHRtO5+bjiXP1+NWy5UvEmMSbg==
X-Authority-Analysis: v=2.4 cv=UO7Q3Sfy c=1 sm=1 tr=0 ts=692f5118 cx=c_pps
 a=dlt6EHtatQYmFek7NWVDaw==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=20KFwNOVAAAA:8
 a=rxiNKpY3CPn0s67FIDEA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: P7tXFD5D6z9M-b4Kj64ZfG10tCejrQ0s
Subject: Re:  [PATCH v2 2/3] ceph: parse subvolume_id from InodeStat v9 and
 store in inode
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-01_01,2025-11-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 bulkscore=0 adultscore=0 priorityscore=1501
 impostorscore=0 spamscore=0 phishscore=0 clxscore=1015 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2511290016

T24gVHVlLCAyMDI1LTEyLTAyIGF0IDE1OjU3ICswMDAwLCBBbGV4IE1hcmt1emUgd3JvdGU6DQo+
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
cmVkaGF0LmNvbT4NCj4gLS0tDQo+ICBmcy9jZXBoL2lub2RlLmMgICAgICB8IDIzICsrKysrKysr
KysrKysrKysrKysrKysrDQo+ICBmcy9jZXBoL21kc19jbGllbnQuYyB8ICA3ICsrKysrKysNCj4g
IGZzL2NlcGgvbWRzX2NsaWVudC5oIHwgIDEgKw0KPiAgZnMvY2VwaC9zdXBlci5oICAgICAgfCAg
MiArKw0KPiAgNCBmaWxlcyBjaGFuZ2VkLCAzMyBpbnNlcnRpb25zKCspDQo+IA0KPiBkaWZmIC0t
Z2l0IGEvZnMvY2VwaC9pbm9kZS5jIGIvZnMvY2VwaC9pbm9kZS5jDQo+IGluZGV4IGE2ZTI2MGQ5
ZTQyMC4uODM1MDQ5MDA0MDQ3IDEwMDY0NA0KPiAtLS0gYS9mcy9jZXBoL2lub2RlLmMNCj4gKysr
IGIvZnMvY2VwaC9pbm9kZS5jDQo+IEBAIC02MzgsNiArNjM4LDcgQEAgc3RydWN0IGlub2RlICpj
ZXBoX2FsbG9jX2lub2RlKHN0cnVjdCBzdXBlcl9ibG9jayAqc2IpDQo+ICANCj4gIAljaS0+aV9t
YXhfYnl0ZXMgPSAwOw0KPiAgCWNpLT5pX21heF9maWxlcyA9IDA7DQo+ICsJY2ktPmlfc3Vidm9s
dW1lX2lkID0gMDsNCj4gIA0KPiAgCW1lbXNldCgmY2ktPmlfZGlyX2xheW91dCwgMCwgc2l6ZW9m
KGNpLT5pX2Rpcl9sYXlvdXQpKTsNCj4gIAltZW1zZXQoJmNpLT5pX2NhY2hlZF9sYXlvdXQsIDAs
IHNpemVvZihjaS0+aV9jYWNoZWRfbGF5b3V0KSk7DQo+IEBAIC03NDIsNiArNzQzLDggQEAgdm9p
ZCBjZXBoX2V2aWN0X2lub2RlKHN0cnVjdCBpbm9kZSAqaW5vZGUpDQo+ICANCj4gIAlwZXJjcHVf
Y291bnRlcl9kZWMoJm1kc2MtPm1ldHJpYy50b3RhbF9pbm9kZXMpOw0KPiAgDQo+ICsJY2ktPmlf
c3Vidm9sdW1lX2lkID0gMDsNCj4gKw0KPiAgCW5ldGZzX3dhaXRfZm9yX291dHN0YW5kaW5nX2lv
KGlub2RlKTsNCj4gIAl0cnVuY2F0ZV9pbm9kZV9wYWdlc19maW5hbCgmaW5vZGUtPmlfZGF0YSk7
DQo+ICAJaWYgKGlub2RlLT5pX3N0YXRlICYgSV9QSU5OSU5HX05FVEZTX1dCKQ0KPiBAQCAtODcz
LDYgKzg3NiwyMiBAQCBpbnQgY2VwaF9maWxsX2ZpbGVfc2l6ZShzdHJ1Y3QgaW5vZGUgKmlub2Rl
LCBpbnQgaXNzdWVkLA0KPiAgCXJldHVybiBxdWV1ZV90cnVuYzsNCj4gIH0NCj4gIA0KPiArLyoN
Cj4gKyAqIFNldCB0aGUgc3Vidm9sdW1lIElEIGZvciBhbiBpbm9kZS4gRm9sbG93aW5nIHRoZSBG
VVNFIGNsaWVudCBjb252ZW50aW9uLA0KPiArICogMCBtZWFucyB1bmtub3duL3Vuc2V0IChNRFMg
b25seSBzZW5kcyBub24temVybyBJRHMgZm9yIHN1YnZvbHVtZSBpbm9kZXMpLg0KPiArICovDQo+
ICt2b2lkIGNlcGhfaW5vZGVfc2V0X3N1YnZvbHVtZShzdHJ1Y3QgaW5vZGUgKmlub2RlLCB1NjQg
c3Vidm9sdW1lX2lkKQ0KPiArew0KPiArCXN0cnVjdCBjZXBoX2lub2RlX2luZm8gKmNpOw0KPiAr
DQo+ICsJaWYgKCFpbm9kZSB8fCAhc3Vidm9sdW1lX2lkKQ0KPiArCQlyZXR1cm47DQo+ICsNCj4g
KwljaSA9IGNlcGhfaW5vZGUoaW5vZGUpOw0KPiArCWlmIChSRUFEX09OQ0UoY2ktPmlfc3Vidm9s
dW1lX2lkKSAhPSBzdWJ2b2x1bWVfaWQpDQo+ICsJCVdSSVRFX09OQ0UoY2ktPmlfc3Vidm9sdW1l
X2lkLCBzdWJ2b2x1bWVfaWQpOw0KPiArfQ0KPiArDQo+ICB2b2lkIGNlcGhfZmlsbF9maWxlX3Rp
bWUoc3RydWN0IGlub2RlICppbm9kZSwgaW50IGlzc3VlZCwNCj4gIAkJCSB1NjQgdGltZV93YXJw
X3NlcSwgc3RydWN0IHRpbWVzcGVjNjQgKmN0aW1lLA0KPiAgCQkJIHN0cnVjdCB0aW1lc3BlYzY0
ICptdGltZSwgc3RydWN0IHRpbWVzcGVjNjQgKmF0aW1lKQ0KPiBAQCAtMTA4Nyw2ICsxMTA2LDcg
QEAgaW50IGNlcGhfZmlsbF9pbm9kZShzdHJ1Y3QgaW5vZGUgKmlub2RlLCBzdHJ1Y3QgcGFnZSAq
bG9ja2VkX3BhZ2UsDQo+ICAJbmV3X2lzc3VlZCA9IH5pc3N1ZWQgJiBpbmZvX2NhcHM7DQo+ICAN
Cj4gIAlfX2NlcGhfdXBkYXRlX3F1b3RhKGNpLCBpaW5mby0+bWF4X2J5dGVzLCBpaW5mby0+bWF4
X2ZpbGVzKTsNCj4gKwljZXBoX2lub2RlX3NldF9zdWJ2b2x1bWUoaW5vZGUsIGlpbmZvLT5zdWJ2
b2x1bWVfaWQpOw0KDQpJIHN0aWxsIGRvbid0IHF1aXRlIGZvbGxvdy4gSXMgaXQgbm9ybWFsIG9y
IG5vdCB0byByZXNldCB0aGUgc3Vidm9sdW1lX2lkPyBJZiB3ZQ0KYWxyZWFkeSBoYWQgdGhlIHN1
YnZvbHVtZV9pZCwgdGhlbiBob3cgdmFsaWQgaXMgcmVzZXQgb3BlcmF0aW9uPyBDb3VsZCB3ZSBo
YXZlDQpidWdzIGhlcmU/DQoNCj4gIA0KPiAgI2lmZGVmIENPTkZJR19GU19FTkNSWVBUSU9ODQo+
ICAJaWYgKGlpbmZvLT5mc2NyeXB0X2F1dGhfbGVuICYmDQo+IEBAIC0xNTk0LDYgKzE2MTQsOCBA
QCBpbnQgY2VwaF9maWxsX3RyYWNlKHN0cnVjdCBzdXBlcl9ibG9jayAqc2IsIHN0cnVjdCBjZXBo
X21kc19yZXF1ZXN0ICpyZXEpDQo+ICAJCQlnb3RvIGRvbmU7DQo+ICAJCX0NCj4gIAkJaWYgKHBh
cmVudF9kaXIpIHsNCj4gKwkJCWNlcGhfaW5vZGVfc2V0X3N1YnZvbHVtZShwYXJlbnRfZGlyLA0K
PiArCQkJCQkJIHJpbmZvLT5kaXJpLnN1YnZvbHVtZV9pZCk7DQo+ICAJCQllcnIgPSBjZXBoX2Zp
bGxfaW5vZGUocGFyZW50X2RpciwgTlVMTCwgJnJpbmZvLT5kaXJpLA0KPiAgCQkJCQkgICAgICBy
aW5mby0+ZGlyZnJhZywgc2Vzc2lvbiwgLTEsDQo+ICAJCQkJCSAgICAgICZyZXEtPnJfY2Fwc19y
ZXNlcnZhdGlvbik7DQo+IEBAIC0xNjgyLDYgKzE3MDQsNyBAQCBpbnQgY2VwaF9maWxsX3RyYWNl
KHN0cnVjdCBzdXBlcl9ibG9jayAqc2IsIHN0cnVjdCBjZXBoX21kc19yZXF1ZXN0ICpyZXEpDQo+
ICAJCUJVR19PTighcmVxLT5yX3RhcmdldF9pbm9kZSk7DQo+ICANCj4gIAkJaW4gPSByZXEtPnJf
dGFyZ2V0X2lub2RlOw0KPiArCQljZXBoX2lub2RlX3NldF9zdWJ2b2x1bWUoaW4sIHJpbmZvLT50
YXJnZXRpLnN1YnZvbHVtZV9pZCk7DQo+ICAJCWVyciA9IGNlcGhfZmlsbF9pbm9kZShpbiwgcmVx
LT5yX2xvY2tlZF9wYWdlLCAmcmluZm8tPnRhcmdldGksDQo+ICAJCQkJTlVMTCwgc2Vzc2lvbiwN
Cj4gIAkJCQkoIXRlc3RfYml0KENFUEhfTURTX1JfQUJPUlRFRCwgJnJlcS0+cl9yZXFfZmxhZ3Mp
ICYmDQo+IGRpZmYgLS1naXQgYS9mcy9jZXBoL21kc19jbGllbnQuYyBiL2ZzL2NlcGgvbWRzX2Ns
aWVudC5jDQo+IGluZGV4IGQ3ZDgxNzhlMWY5YS4uMDk5YjhmMjI2ODNiIDEwMDY0NA0KPiAtLS0g
YS9mcy9jZXBoL21kc19jbGllbnQuYw0KPiArKysgYi9mcy9jZXBoL21kc19jbGllbnQuYw0KPiBA
QCAtMTA1LDYgKzEwNSw4IEBAIHN0YXRpYyBpbnQgcGFyc2VfcmVwbHlfaW5mb19pbih2b2lkICoq
cCwgdm9pZCAqZW5kLA0KPiAgCWludCBlcnIgPSAwOw0KPiAgCXU4IHN0cnVjdF92ID0gMDsNCj4g
IA0KPiArCWluZm8tPnN1YnZvbHVtZV9pZCA9IDA7DQo+ICsNCj4gIAlpZiAoZmVhdHVyZXMgPT0g
KHU2NCktMSkgew0KPiAgCQl1MzIgc3RydWN0X2xlbjsNCj4gIAkJdTggc3RydWN0X2NvbXBhdDsN
Cj4gQEAgLTI1MSw2ICsyNTMsMTAgQEAgc3RhdGljIGludCBwYXJzZV9yZXBseV9pbmZvX2luKHZv
aWQgKipwLCB2b2lkICplbmQsDQo+ICAJCQljZXBoX2RlY29kZV9za2lwX24ocCwgZW5kLCB2OF9z
dHJ1Y3RfbGVuLCBiYWQpOw0KPiAgCQl9DQo+ICANCj4gKwkJLyogc3RydWN0X3YgOSBhZGRlZCBz
dWJ2b2x1bWVfaWQgKi8NCj4gKwkJaWYgKHN0cnVjdF92ID49IDkpDQo+ICsJCQljZXBoX2RlY29k
ZV82NF9zYWZlKHAsIGVuZCwgaW5mby0+c3Vidm9sdW1lX2lkLCBiYWQpOw0KPiArDQo+ICAJCSpw
ID0gZW5kOw0KPiAgCX0gZWxzZSB7DQo+ICAJCS8qIGxlZ2FjeSAodW52ZXJzaW9uZWQpIHN0cnVj
dCAqLw0KPiBAQCAtMzk3MCw2ICszOTc2LDcgQEAgc3RhdGljIHZvaWQgaGFuZGxlX3JlcGx5KHN0
cnVjdCBjZXBoX21kc19zZXNzaW9uICpzZXNzaW9uLCBzdHJ1Y3QgY2VwaF9tc2cgKm1zZykNCj4g
IAkJCWdvdG8gb3V0X2VycjsNCj4gIAkJfQ0KPiAgCQlyZXEtPnJfdGFyZ2V0X2lub2RlID0gaW47
DQo+ICsJCWNlcGhfaW5vZGVfc2V0X3N1YnZvbHVtZShpbiwgcmluZm8tPnRhcmdldGkuc3Vidm9s
dW1lX2lkKTsNCj4gIAl9DQo+ICANCj4gIAltdXRleF9sb2NrKCZzZXNzaW9uLT5zX211dGV4KTsN
Cj4gZGlmZiAtLWdpdCBhL2ZzL2NlcGgvbWRzX2NsaWVudC5oIGIvZnMvY2VwaC9tZHNfY2xpZW50
LmgNCj4gaW5kZXggMDQyOGE1ZWFmMjhjLi5iZDM2OTBiYWE2NWMgMTAwNjQ0DQo+IC0tLSBhL2Zz
L2NlcGgvbWRzX2NsaWVudC5oDQo+ICsrKyBiL2ZzL2NlcGgvbWRzX2NsaWVudC5oDQo+IEBAIC0x
MTgsNiArMTE4LDcgQEAgc3RydWN0IGNlcGhfbWRzX3JlcGx5X2luZm9faW4gew0KPiAgCXUzMiBm
c2NyeXB0X2ZpbGVfbGVuOw0KPiAgCXU2NCByc25hcHM7DQo+ICAJdTY0IGNoYW5nZV9hdHRyOw0K
PiArCXU2NCBzdWJ2b2x1bWVfaWQ7DQo+ICB9Ow0KPiAgDQo+ICBzdHJ1Y3QgY2VwaF9tZHNfcmVw
bHlfZGlyX2VudHJ5IHsNCj4gZGlmZiAtLWdpdCBhL2ZzL2NlcGgvc3VwZXIuaCBiL2ZzL2NlcGgv
c3VwZXIuaA0KPiBpbmRleCBhMWY3ODFjNDZiNDEuLmMwMzcyYTcyNTk2MCAxMDA2NDQNCj4gLS0t
IGEvZnMvY2VwaC9zdXBlci5oDQo+ICsrKyBiL2ZzL2NlcGgvc3VwZXIuaA0KPiBAQCAtMzg1LDYg
KzM4NSw3IEBAIHN0cnVjdCBjZXBoX2lub2RlX2luZm8gew0KPiAgDQo+ICAJLyogcXVvdGFzICov
DQo+ICAJdTY0IGlfbWF4X2J5dGVzLCBpX21heF9maWxlczsNCj4gKwl1NjQgaV9zdWJ2b2x1bWVf
aWQ7CS8qIDAgPSB1bmtub3duL3Vuc2V0LCBtYXRjaGVzIEZVU0UgY2xpZW50ICovDQoNCkkgc3Rp
bGwgYmVsaWV2ZSB0aGF0IGl0IG1ha2VzIHNlbnNlIHRvIGludHJvZHVjZSB0aGUgbmFtZWQgY29u
c3RhbnQgd2l0aCB0aGUNCmdvYWwgbm90IHRvIG1ha2UgY29uZnVzZWQgYnkgemVybyB2YWx1ZSBh
bmQgbm90IHRvIGd1ZXNzIGlmIGl0IGlzIGNvcnJlY3QgdmFsdWUNCm9yIG5vdC4NCg0KVGhhbmtz
LA0KU2xhdmEuDQoNCj4gIA0KPiAgCXMzMiBpX2Rpcl9waW47DQo+ICANCj4gQEAgLTEwNTcsNiAr
MTA1OCw3IEBAIGV4dGVybiBzdHJ1Y3QgaW5vZGUgKmNlcGhfZ2V0X2lub2RlKHN0cnVjdCBzdXBl
cl9ibG9jayAqc2IsDQo+ICBleHRlcm4gc3RydWN0IGlub2RlICpjZXBoX2dldF9zbmFwZGlyKHN0
cnVjdCBpbm9kZSAqcGFyZW50KTsNCj4gIGV4dGVybiBpbnQgY2VwaF9maWxsX2ZpbGVfc2l6ZShz
dHJ1Y3QgaW5vZGUgKmlub2RlLCBpbnQgaXNzdWVkLA0KPiAgCQkJICAgICAgIHUzMiB0cnVuY2F0
ZV9zZXEsIHU2NCB0cnVuY2F0ZV9zaXplLCB1NjQgc2l6ZSk7DQo+ICtleHRlcm4gdm9pZCBjZXBo
X2lub2RlX3NldF9zdWJ2b2x1bWUoc3RydWN0IGlub2RlICppbm9kZSwgdTY0IHN1YnZvbHVtZV9p
ZCk7DQo+ICBleHRlcm4gdm9pZCBjZXBoX2ZpbGxfZmlsZV90aW1lKHN0cnVjdCBpbm9kZSAqaW5v
ZGUsIGludCBpc3N1ZWQsDQo+ICAJCQkJdTY0IHRpbWVfd2FycF9zZXEsIHN0cnVjdCB0aW1lc3Bl
YzY0ICpjdGltZSwNCj4gIAkJCQlzdHJ1Y3QgdGltZXNwZWM2NCAqbXRpbWUsDQo=


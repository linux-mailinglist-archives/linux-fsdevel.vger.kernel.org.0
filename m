Return-Path: <linux-fsdevel+bounces-41759-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EC94A3676D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Feb 2025 22:22:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D2D2188F5BA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Feb 2025 21:22:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D05001DC9AA;
	Fri, 14 Feb 2025 21:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="hwlAjTsz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC77B1DB365;
	Fri, 14 Feb 2025 21:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739568124; cv=fail; b=dHlwkw2J4MokP8CrbjuBDFTp+LaJ1icG6ypEEvXFPWVHDELn1HDCeLZMWmfFviQcXBurMtVG8HLpQrZDTpQMFSG9Xi3crbfQHJOm5Iyy977RhDLinGAe0bFZyN2hIrR7V/L3DxPyYmDVcg1yiwLAyKqSbvR5JGNSFWKOTdCxbr0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739568124; c=relaxed/simple;
	bh=xI2E+ex6BVKf2MRFAuvKj9lWCjMFfUc5EZPiGL9DAyE=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=nGdiRPNpeCjTG0eOZkvPNG0S7XandXQhrhKPtCrrMVbXoELU/XEEQRIpvEBcI+hSfgC0ZKnev9+bwYJPOyjS8NXPPyXlJn4W3jlogZsZ+gJw6YHRK2iKF1QXoWdvvOGSNtcek9wrvTtePAgxa5uMUGnKEd/XrZg8yOt3d6u4ogM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=hwlAjTsz; arc=fail smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51EEALAD004283;
	Fri, 14 Feb 2025 21:21:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pp1; bh=xI2E+ex6BVKf2MRFAuvKj9lWCjMFfUc5EZPiGL9DAyE=; b=hwlAjTsz
	hfzXszu5tsKSUDU1h0jw7Iw892JGIoq94pYnSqXfT7skGemDAYqOil3l8cW19f5Y
	3k4Irt6OvOttCw/mf0Ieuizvxqc3yX/JNRmD+fhTR0D6wq+QTJZhTYzWToTcgBB2
	DiMLmJnIQCTK71/iy1yH2PKYnWFi3EKVa3/WkGKmsXlngaVphsFtYXE+NEuy5yPN
	/zrT6lsvxQI8qbBWcTKp5BLs5JcjT6obj/YeZgIc1eTQzlJjOw/ariOytscQUzVO
	mkJJ/rD4eMPJdyoqQT7H/QzTEdSyNYYvBVCVWaNP5Hr8hjnyZI3cTcqPEhtMzPHR
	B/aicPkeTgIASA==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44suwa59rq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 14 Feb 2025 21:21:57 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 51ELKWEA010214;
	Fri, 14 Feb 2025 21:21:56 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2046.outbound.protection.outlook.com [104.47.58.46])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44suwa59rm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 14 Feb 2025 21:21:56 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bC5rIAnCIrRGWwI2poENeBtqHQGnD+eG/kRla1NK/ncUN8veNhNTNLO3K8DUfqSTo5R7WQL/YDb1iRsHXdwVFke870NHilCXAOxwzb2YLUO+CUZ42NXLG1Xsaqd2zU3eOW5jevGj6GAD1/qBZK44b19mCRxjoub2mNW/uktHExDAmsIGJ1K+62hl1vIKIyStTUayB1NYKbgixZjOM97UUUjqMrc5tYKbY+mzohdA44YgFgOZ+5aYRHrxbkcIzGRVdS9x9qSeAYBaYGxxh5I8l0DmeGNFj2ReKucG6qrZl9aIywsMQcuYYCDFPTUioQNWmwhzd3o+ecjXxOvficljXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xI2E+ex6BVKf2MRFAuvKj9lWCjMFfUc5EZPiGL9DAyE=;
 b=B7VKztI8a92OAhXSVBxvvY63rEFSEnQgigpg5cpLQtAL2Zk0nVbUQvvok4Xcm2mLS5ASvrVMtI/5vc6iNytYHYQys4jV9emPD4uJCZ7uJurE63rBZCInhnBjOyefk/M5Av7YTChK5f/kF6MPSyzMQjnuwJdnJgv1gl5VDattl+q5vGwniM/chkT7XC8HPeWaMUmv3zc/gpPpJuyq766XZZCUOUK9zPjeeESXb9wgix2okTAPZS2JrVz8P9vn8qlM+0CrvdF6iq1t7kSxEMQgoJj3stAZGqKPF1rYHoMsAaLxub51CXWE5wTS21Grzchfq4VJhSn5ISdAIerB8qU11g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SA1PR15MB5819.namprd15.prod.outlook.com (2603:10b6:806:338::8)
 by CH3PR15MB6282.namprd15.prod.outlook.com (2603:10b6:610:161::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.11; Fri, 14 Feb
 2025 21:21:54 +0000
Received: from SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::6fd6:67be:7178:d89b]) by SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::6fd6:67be:7178:d89b%4]) with mapi id 15.20.8445.016; Fri, 14 Feb 2025
 21:21:54 +0000
From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
To: "willy@infradead.org" <willy@infradead.org>,
        "slava@dubeyko.com"
	<slava@dubeyko.com>
CC: Alex Markuze <amarkuze@redhat.com>,
        "ceph-devel@vger.kernel.org"
	<ceph-devel@vger.kernel.org>,
        "idryomov@gmail.com" <idryomov@gmail.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Patrick
 Donnelly <pdonnell@redhat.com>,
        David Howells <dhowells@redhat.com>
Thread-Topic: [EXTERNAL] Re: [RFC PATCH 3/4] ceph: introduce
 ceph_submit_write() method
Thread-Index: AQHbfyUJV+HgPSNl2UGP49ZlSz2c/LNHTqWA
Date: Fri, 14 Feb 2025 21:21:54 +0000
Message-ID: <bde8970ca24cd35c017646ea3a5a0b5e95691a06.camel@ibm.com>
References: <20250205000249.123054-1-slava@dubeyko.com>
	 <20250205000249.123054-4-slava@dubeyko.com>
	 <Z6-xg-p_mi3I1aMq@casper.infradead.org>
In-Reply-To: <Z6-xg-p_mi3I1aMq@casper.infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5819:EE_|CH3PR15MB6282:EE_
x-ms-office365-filtering-correlation-id: 61a22bc1-daac-48e4-ccfe-08dd4d3d9af5
x-ld-processed: fcf67057-50c9-4ad4-98f3-ffca64add9e9,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|10070799003|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?NDNCZ3kxM29lR2kyRThaYkg5azlGakFYdTlRaTZ5QzdXaTNEWE5JTkR4RVBm?=
 =?utf-8?B?bTc4aS9YMW02T0FCdGltZzUxaXBjOTZLdXEyYlJTTUV6NE5XalYzMkNHejdK?=
 =?utf-8?B?OENkSDRmeEV0a0RoeHBEWnE4WVFkcVNrVXNleEppV0IwOGlYckhHOXlNQmRn?=
 =?utf-8?B?K1BYdmNMRDJnblcrK2EzNTZyeU9ybjlJeGo5RGVqVUJKVFR0MVE5R2tiY2x3?=
 =?utf-8?B?NWdSaDBuVk1WUzJ6bDFISTBrMjh6dEl0VnNXYkh4bmVhckpIN1k4a2MrWDlM?=
 =?utf-8?B?SGp6TFl6UzJOeHJ2NHFSYkJRVmg5QXRGd3hwL0VmOEIyR0E1TWJlNnlaQXhW?=
 =?utf-8?B?WjhHWnZLQlpQNzV4QVJyTldPSlBUMFFoSmRTcW4vT2Uvc0JWNU82b1piZnVC?=
 =?utf-8?B?K3Z5L0ZCYnVNUEYvekpGQWVCVVlLbWcycEZzUDB2L2ZjU3VDMUUwTUVqN0JT?=
 =?utf-8?B?MUc2cmVsYndqQjFDR0hKNXB3R1BMaWJsZTcyYndTZEdxVG8wS1htaCtGSm9O?=
 =?utf-8?B?enhMTGJFMXhqRjZUeWhOOWVuWEF4dEdqeWR0Zi96ajlBcElXUmdTMExmR3My?=
 =?utf-8?B?c1h2aVp5ZXRwd2FGV3UrLzhuVVpmeWhnRUtraElTM3VuZEtHM0tSZnFCWkNl?=
 =?utf-8?B?Tm5vY212V3BpcHk2aHY2bjNuTkVndVNjTktCdnp1SlZiQ0c2MkVNNHR1QmVB?=
 =?utf-8?B?QlFZd290c0huVXU1Sm40S3h5YmNiU0hrU3crYTZqYWIxZHBPa2FwUyswWkRD?=
 =?utf-8?B?YzVZUkhBeHpORGJ5a2xLOWFDSEZIejh3M3VoRlJXWXRBbEVpMnUyUVdydkx2?=
 =?utf-8?B?TDM1QkpFcUp6NityWFZQd0xsK1Yzem9PQmZYRGRJUVBtUllHQ0VBQUNNNkxi?=
 =?utf-8?B?YnYwWkQ0RHFTa1JtYVNmVUxkdEduclVBRUxrRmFOUUY1ajZ0NlIzNXpWb2hU?=
 =?utf-8?B?ekg2Y0NBSEtlYXMzWTZTVkNyWHZrZHovMkVhQ3E3b3BCd1Fza1RQOW81Rm5Q?=
 =?utf-8?B?a3V6TXZFOXI3OEMxb1hNdnhnc3N3Qi90VVNteTZyWkJreGtsUko1dzJxeU92?=
 =?utf-8?B?dU1ad2tHajFvcmZUamlGeVdCMGtCbG5iWENFME95anBGcGFjZVNGT2xVNkda?=
 =?utf-8?B?WEpySmlORUxqS0RjYnlWODVqbTRCQVEyZWpUYzhWektEZytqTkh4ZEd3QjhD?=
 =?utf-8?B?S1VnRlVpZWpkek5uNXY0YTQ1NjliNmVRVm9yMjBtekQ2dTY0cWwvaEpPamZ5?=
 =?utf-8?B?Y3Q5U1d2bHhVNVl0a2tXSmNiNFl2TkpJdFcwanN2VkpONUZaK3hUSkc1QnpV?=
 =?utf-8?B?WEs3UFNTOVJPTmRSYXNBUTJxblBLeXUybnVXdysvNVZzbzg4cEtvZXRIRjRV?=
 =?utf-8?B?UGpyc3NpU3VEeFlBampQN2dUT28veDcyK2QyeDdBbnE5WExTUkpPaURuNjNs?=
 =?utf-8?B?Ym1MUll1N05Yd0JNcCtKTkFQSElDMmt4UEJyZWd3cmFKUDVPUmRkSkEzUThU?=
 =?utf-8?B?bUxFSnl6NWkyUkE1UUFTRzk3RWJmYVY5NWtMYVE2QlExZ294ZUttVzV6NHU3?=
 =?utf-8?B?OHEzMnN1Q0dDcVF2NmsvTTBOZ0dlakZ0bzg1cDVYK09WVStZUFdDZVdhWnBw?=
 =?utf-8?B?U2dTZnhJKzMrWXY4ZTJqQTV0VGJyQXVENVdMdi9ZeTFRYkxvSjNwaTZSaWw0?=
 =?utf-8?B?dXFWK01VRXZJRnFRNk5DbDBnT2h0ZHB1MWZoNDFJc1F5Z1djRWwyZFdKYjJl?=
 =?utf-8?B?eUR3NTR0ZVNGSVFsakUrU1cyckZhS2VGcG1FaTRRcHNNTTZIMWRyWlhsVTY5?=
 =?utf-8?B?MDZFUWRWdDErdkxQeGxVQWUwblA2Y045UU5ENGdJMU94VmJIWDZWS01DTFJC?=
 =?utf-8?B?VFlNdEI3eTg4alhNVHVHZUE1VlZoVFhrMndoYktYazFlRG1KSGl3dmxMeWpi?=
 =?utf-8?Q?9T4Vlj0l3ECpgGiY05DqaCQWMWZfAsbM?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5819.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?SmJNbFYxOGp5b0prcGF0WEpvd0FkcVZJSDZyVGhEYmJIQTliNVVVeVJyV2ZV?=
 =?utf-8?B?K3J5aWx3cCtsN2w2SjY4Z25jQi9QeEcvRTEzSnJwQzE1azlueEFwcDdzcTRL?=
 =?utf-8?B?SG1PNjJNSi96TG5La3pJWnNBQWVJOHVQbkVueFAzMFlWY3BDdDdxSTA5Z0pw?=
 =?utf-8?B?Sk9xa09EYUlpK0piQWJMYWZNS2RETzhKYkR6YnhSMWhsbGpuSldKandGVTRN?=
 =?utf-8?B?RTViSHlER25hRVRDdHZWclZJdXd5RC9vSGRHZ3FjT2haMVRPUWh3MFV0MWF3?=
 =?utf-8?B?MFpmZ0RVRS9vVUZNdDhTUGd5OUxHMWp3SmV5VTgwSXdkRy9jN0Z5RW5lcXYx?=
 =?utf-8?B?OCt3L044aTVtUW5aTXFaLzdOVVNEeldicHBIWWRocENDTzdSTWhoU3BiekpQ?=
 =?utf-8?B?bFdyZFM2SGU3ZURLb3FtM1VRNkhlRVVjQ0NWMzc4ZW1yNFdKUHpKUDFHZGZj?=
 =?utf-8?B?OThHMmY0THBIOThDRklVVDkyUmMyYzFQRnBwRmNBazZjYjAvL1pWb1FqYmFs?=
 =?utf-8?B?WVplQWp4Y3NPSGcrelNGZWRZeWV5YlpERlozbm1RczMwY0p5YXFodldwWFhX?=
 =?utf-8?B?TFN0YU1iT3YvS3R1b1lNU2dNaDlTdnNPaW8wVHJBYkxHa3RacDBmaFhRNlBP?=
 =?utf-8?B?T0tuTHJnV0gxNUxjODVRckZBNXArd3Zxd1RzbUZ6SHlvdnhIQnYwemhnZ2R1?=
 =?utf-8?B?V3JRRFBnZXBZMkJRdjJqTmR4U2RvTlVrK1NZbnBjWUtuSWlRTDhpQXBadURD?=
 =?utf-8?B?VjY1R2YrRFlZRFl0ZTIvSE91RUNJT3B2ck55Q0lWbmNyUlM0K09hbWZEV0hJ?=
 =?utf-8?B?YkJid29mUzMxdjc4czN5NUF1Q1Z6cXA3UldCS0ZMSTBORWorMTIwdTFnVEFC?=
 =?utf-8?B?Q0ZSd2FQc3k1NFJjTlg4VXBiY1ZKWXdKY2NTQ21mSVgvcTdXdG9nVy9RaXVI?=
 =?utf-8?B?aTg5MjNNS0N2clpKbGR3bUdOODdsT01zTWNiWDhaT29mZkxEM0ZoZUJXdGxT?=
 =?utf-8?B?Yi9tR09xeCtsaG45S0NKdDVUS084SDhJWGxvV0p4NTlxelpjazdNTThVUzhB?=
 =?utf-8?B?V3JBYkYyN2s0d0pnZ1JwamhkOWI0ajMzd0REbDRtOHV0YllUSDEvUDZ4V2dx?=
 =?utf-8?B?T2hialljcm55a2JNS3BtczkvS1V0KzRBN3JyanJLcHFKVUNJS1UydFAwa3lN?=
 =?utf-8?B?TGR1NkRGQWRWcEgxNU9zeWhBRmhnUFZlMTFHL2ZJQjVMaU9kQ3k1SXFEQzZQ?=
 =?utf-8?B?VmIyam5RK2dMQ1JYOW9WL2RjTlN3cjR5dFhvaWVLWU1QNlNudWpGNTRuZisz?=
 =?utf-8?B?T2VsZ1MyQndoYkZ0M1daT0daZ2MvM0pleU41YWE2UWFkZEwxczVYYm9KdS9k?=
 =?utf-8?B?VVkyN3dodTBWVUhJVkw1cVZST2pIOTBXYS9hcVBSSzJNcHp4akxzRHkzQ0hF?=
 =?utf-8?B?UmxRS1pDZzE5K3VSblZnZDhPWTF5VGlzMDNrK3ptcWIxU1lzaUlZRk1vc2FZ?=
 =?utf-8?B?RkhBZ3pGdllPdnk1MlJweEVNakprSDdDRnd5QmZHUXp4YjFobEMxa25ZTEVK?=
 =?utf-8?B?TnBUSi9SQXlDQmNuQXVVU3VUNk9jamVPbVZMNHRLaDZTZUpMYkVmd2NUNitG?=
 =?utf-8?B?djFTUWJxcnlkVTFTdXpDMWZNTFNVYTlRSGJxeE9YN2E3VlZxUUQ4RXdaNmVL?=
 =?utf-8?B?SE5mQ2pZSnJ6OWw3dlNFR3RnNmc3SmQ3a3NyTTBvQUVqc0tHLzF5YkpNaWlt?=
 =?utf-8?B?VVZTTG55aHZzbWVCZC9zcEloNDVScVdCUDRqRDl4U1VKZ2FRMXFvVGlHLzQ3?=
 =?utf-8?B?c2ZyMTRQMFF3MmpZdTNaYTJ1NzlKdDlIN29FR1ozK2lMNnpoamNzSGRBSHNX?=
 =?utf-8?B?V2lQUGpDbU9SWThTbU16RWlrM2tWNmVkVUFoSjFyaHpmRXRnZmduY1dqTzFj?=
 =?utf-8?B?dXdNd1YycVpBL1lHeGNZVThwclRBaWU4WG1HWkhxZzgrMXRKWHZFTU5RbjFv?=
 =?utf-8?B?UzUwelY2dEdHa2tQSjNpRmRGSzYrYWNUNXZpWmg5Vk1zMDh1OENUNHNId0NJ?=
 =?utf-8?B?OE5mWjNJV1VwOVUvQ0Z2SWpFdVk5SWpFVnM3dWUwa0hnVHpwU2hlaDF0WTFh?=
 =?utf-8?B?VUduSXQ4VlZjTlE2OXh6V01RU3FoeXQrbVQvZ0VkVUN4VXc0UURnMWRaVS9J?=
 =?utf-8?Q?+d0Y/qxc+2YNxfO4xoPTBkA=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C856D6DD0819B04496F6B2EFAF3A83C1@namprd15.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 61a22bc1-daac-48e4-ccfe-08dd4d3d9af5
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Feb 2025 21:21:54.4532
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TaC8TwYjMatSoQ9BJ3R7bDl4B4FHOXCfEU7fRvbT1Gj714PACCO6IS3Ts+EkHvBVpAclu2nq6Bn/4edU65qZUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR15MB6282
X-Proofpoint-GUID: M7mDOI0z2paIsYpVrOCpMF0e6ikKo0gD
X-Proofpoint-ORIG-GUID: zVLn5CvFKIfzHwSt2Wh6lUQ6W7Rndw_U
Subject: RE: [RFC PATCH 3/4] ceph: introduce ceph_submit_write() method
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-14_09,2025-02-13_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501 mlxscore=0
 malwarescore=0 clxscore=1015 phishscore=0 lowpriorityscore=0 bulkscore=0
 mlxlogscore=576 impostorscore=0 spamscore=0 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2501170000
 definitions=main-2502140142

T24gRnJpLCAyMDI1LTAyLTE0IGF0IDIxOjExICswMDAwLCBNYXR0aGV3IFdpbGNveCB3cm90ZToN
Cj4gT24gVHVlLCBGZWIgMDQsIDIwMjUgYXQgMDQ6MDI6NDhQTSAtMDgwMCwgVmlhY2hlc2xhdiBE
dWJleWtvIHdyb3RlOg0KPiA+IFRoaXMgcGF0Y2ggaW1wbGVtZW50cyByZWZhY3RvcmluZyBvZiBj
ZXBoX3N1Ym1pdF93cml0ZSgpDQo+ID4gYW5kIGFsc28gaXQgc29sdmVzIHRoZSBzZWNvbmQgaXNz
dWUuDQo+ID4gDQo+ID4gU2lnbmVkLW9mZi1ieTogVmlhY2hlc2xhdiBEdWJleWtvIDxTbGF2YS5E
dWJleWtvQGlibS5jb20+DQo+IA0KPiBUaGlzIGtpbmQgb2YgZ2lhbnQgcmVmYWN0b3JpbmcgdG8g
c29sdmUgYSBidWcgaXMgYSByZWFsbHkgYmFkIGlkZWEuDQo+IEZpcnN0LCBpdCdzIGdvaW5nIHRv
IG5lZWQgdG8gYmUgYmFja3BvcnRlZCB0byBvbGRlciBrZXJuZWxzLiAgSG93IGZhcg0KPiBiYWNr
PyAgWW91IG5lZWQgdG8gaWRlbnRpZnkgdGhhdCB3aXRoIGEgRml4ZXM6IGxpbmUuDQo+IA0KPiBJ
dCdzIGFsc28gcmVhbGx5IGhhcmQgdG8gcmV2aWV3IGFuZCBrbm93IHdoZXRoZXIgaXQncyByaWdo
dC4gIFlvdSBtaWdodA0KPiBoYXZlIGludHJvZHVjZWQgc2V2ZXJhbCBuZXcgYnVncyB3aGlsZSBk
b2luZyBpdC4gIEluIGdlbmVyYWwsIGJ1Z2ZpeGVzDQo+IGZpcnN0LCByZWZhY3RvciBsYXRlci4g
IEkgKnRoaW5rKiB0aGlzIG1lYW5zIHdlIGNhbiBkbyB3aXRob3V0IDEvNyBvZg0KPiB0aGUgcGF0
Y2hlcyBJIHJlc2VudCBlYXJsaWVyIHRvZGF5LCBidXQgaXQncyByZWFsbHkgaGFyZCB0byBiZSBz
dXJlLg0KDQpJIHJlYWxseSB3b3VsZCBsaWtlIG5vdCB0byBkbyByZWZhY3RvcmluZyBoZXJlLiBC
dXQgdGhlIGZ1bmN0aW9uIGlzIGh1Z2UgYW5kDQpsb2dpYyBpcyBwcmV0dHkgY29tcGxpY2F0ZWQu
IEl0J3MgaGFyZCB0byBmb2xsb3cgdGhlIGxvZ2ljIG9mIHRoZSBtZXRob2QuDQpSZWZhY3Rvcmlu
ZyBpcyBkb2luZyBvbmx5IG9mIG1vdmluZyB0aGUgZXhpc3RpbmcgY29kZSBpbnRvIHNtYWxsZXIg
ZnVuY3Rpb25zIGFuZA0Kbm90aGluZyBtb3JlLg0KDQpJIGNhbiBub3QgdG8gZG8gdGhlIHJlZmFj
dG9yaW5nIGFuZCBzaW1wbHkgYWRkIHRoZSBmaXhlcyBidXQgZnVuY3Rpb24gd2lsbCBiZQ0KYmln
Z2VyIGFuZCBtb3JlIGNvbXBsZXgsIGZyb20gbXkgcG9pbnQgb2Ygdmlldy4NCg0KVGhhbmtzLA0K
U2xhdmEuDQoNCg==


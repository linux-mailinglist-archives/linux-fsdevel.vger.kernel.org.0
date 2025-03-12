Return-Path: <linux-fsdevel+bounces-43829-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 91B65A5E3CB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Mar 2025 19:43:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1079B3B15C7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Mar 2025 18:43:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 291E625745B;
	Wed, 12 Mar 2025 18:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="nSFBRDwS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 127461BD01F;
	Wed, 12 Mar 2025 18:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741805002; cv=fail; b=NcSWx7uh8SgaM3wvC9G9K5YRDV+PIeSAtfXtwG4r2zuOxJaMFNilXjuxCwrol/vnTEGsDlkfU73cJ8KgCZI0x+Ge8HylwglAVLN75/fwSytzlsjsWHXC1pmt9IOVNWnqT3pUWldywIsbRSpqZMe4WSxcGKvtMGbXDT4gX7fsSP8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741805002; c=relaxed/simple;
	bh=e8REacYsMbX8uDuxJMCKTxBBrJi6mmV4SjxdDKxT+yw=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=IK+kDZr7mVlq6H2sD484DobwAGZAO6JLzSJ7gMjHsN6xTB1zla4pH+HXFrE1pqx2y3SIuNNYFT2RSarh6vLF0BJch3lk1ev1iGKrGm0C8MH/h2yjLFrQW1iYiQxkMwqD06jXeaBvfurcRT6uG52Mj/5j44i0ptjCs3gLZo4BTlU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=nSFBRDwS; arc=fail smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52CCdnH3025444;
	Wed, 12 Mar 2025 18:43:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pp1; bh=e8REacYsMbX8uDuxJMCKTxBBrJi6mmV4SjxdDKxT+yw=; b=nSFBRDwS
	PO81zp0aN6DjEoycsQ/WUxV7Bp5QNP6oL1DlLgzkPHEbxNQ3EmgJS7iH/V/4I6y/
	w5xxHT+7hhN+3eb4L+eUxLpLHHBaNosRoF3T1iXAbt/AOJLAj3r+q+WJ3ldaLP9b
	vilfA7CxM/ZCRMRgfUBEYSvNxNnS7kSORyfx9QQkvr2S4kiEdnTylq6lgFWGv3Yt
	PucnrZoUS3iNyAdPCr4nmucfRxrmzIY/4TiQ+EsAf72QRZGHmtwXNvxkaLC+WNHn
	HyiIersd5uh72T6rSJQZDk/HHa51vmAzUSMN6W531y67DBAkQxitI8qq/gk4J/lu
	tCLqa8D48FC0eA==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45baa2t118-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Mar 2025 18:43:12 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 52CIgEbm007625;
	Wed, 12 Mar 2025 18:43:12 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2176.outbound.protection.outlook.com [104.47.58.176])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45baa2t112-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Mar 2025 18:43:12 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LeHFSuGMrw0z6uNXiWp4zECzZfc+dOfxZOQmskwIFUp7NZciec4/qlh3CtktoEp04tzNX0lwDA8ujVgZmaAn1he/7o2G+vv+PbofQm9kG1gKrPGSqXymvqshfJsHujxk2QCpA32Tc858ZzmX28Ou4UXRG0NEBZOjiXzN9tpqNeVpRD5T2P/d87l/7tdKa88aPw2Hr9I9W7pep0nZHVDoBGD1Y0RHNUAK+pHStK8MpC7ujZmbwkUkWi0CgrFVzLd3rmzNBfjsKPCG26H8f+8WTrqhz2M3+u1GlkmLRcRWpt4tj7gMqBT2/Ag9I/9rr5u3d+3ma/Zs+mp/mW6ZkC/J4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e8REacYsMbX8uDuxJMCKTxBBrJi6mmV4SjxdDKxT+yw=;
 b=i7V9+VXBUIPQ74sKq98JvlXwB8VI9C+1OgNEfg0BC8rli6QD5q/cVVHiTU8GrC6odZo992InBxEstCuOGhzpniyFC1Ajamk0ODC8ZGSG3+4Ok+DkAqyNGiw66ZBZkgovwZYl2+1vLbVw6t/ADzGp3YgkxLIdXdIyph/CM6kq9bDMAFT3tpP0ouhy7M/NfoU0vy8xLr3jX/0u7/FEp+2avfWAMah2OjAXS+yt9ZkXkpRMu0wJJLbEtoOI46fCtGaSuvjFaM+X+8Hk7x1UkTs12wLaOPpGHJkW+6ozFzbd3g1jFP+DOTYHNiQiAEVzyl/5K62gSQ0kwscofM/e5UreAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SA1PR15MB5819.namprd15.prod.outlook.com (2603:10b6:806:338::8)
 by CY8PR15MB5848.namprd15.prod.outlook.com (2603:10b6:930:6c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Wed, 12 Mar
 2025 18:43:08 +0000
Received: from SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::6fd6:67be:7178:d89b]) by SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::6fd6:67be:7178:d89b%6]) with mapi id 15.20.8511.026; Wed, 12 Mar 2025
 18:43:08 +0000
From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
To: "slava@dubeyko.com" <slava@dubeyko.com>,
        David Howells
	<dhowells@redhat.com>
CC: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>,
        Alex Markuze
	<amarkuze@redhat.com>, Xiubo Li <xiubli@redhat.com>,
        "brauner@kernel.org"
	<brauner@kernel.org>,
        "idryomov@gmail.com" <idryomov@gmail.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Thread-Topic: [EXTERNAL] [PATCH] ceph: Fix incorrect flush end position
 calculation
Thread-Index: AQHbkzwvEl6XkpP03kawQtOgQcVkvrNv1riA
Date: Wed, 12 Mar 2025 18:43:08 +0000
Message-ID: <458de992be8760c387f7a4e55a1e42a021090a02.camel@ibm.com>
References: <1243044.1741776431@warthog.procyon.org.uk>
In-Reply-To: <1243044.1741776431@warthog.procyon.org.uk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5819:EE_|CY8PR15MB5848:EE_
x-ms-office365-filtering-correlation-id: ce6debca-f027-422b-f389-08dd6195bbb2
x-ld-processed: fcf67057-50c9-4ad4-98f3-ffca64add9e9,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|10070799003|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?Yk9sZk9ZVlhaeWdJTXJ5T0lzM0k4aTE5N2lhZmkwOHFGZ09iRHM2VHhsaHZW?=
 =?utf-8?B?SXJaa0dYOGFqR09tNzBKYmd1OFJYWWRLK0JrbUNmejdVK003R004eisvVW15?=
 =?utf-8?B?eUpwR0JDU3d5L3p1S01pN3dTNDVMUEwwU3llQ0RJenRqMTlEL3BTd0VsemZz?=
 =?utf-8?B?RW5tNEY0Mnpoby9CbEhYbzF3NkxiVkxQYkhTdEoreEQ4MzB3eVF2QmdoUXZ2?=
 =?utf-8?B?Umc2QjZpc0YrcXJPK2pJdjFkcUxwVkdEQzE0T05FMXE1TXdVQlJmblRpVHFo?=
 =?utf-8?B?YlhHREtXMnR6L3ZZY0JiYkFlcTJyTzBaYnRCNTY1L09IV2xIQXFlV201RUR1?=
 =?utf-8?B?QnZRQVVLWEs3bmtRWFVZMXFOQnF6TFpoTUlDdENxRFhJcGFqdjJZRHRlS3g2?=
 =?utf-8?B?WjJ6TWk4OVFrRlA2c0xVYWV6Q2Zrb00xaVcwNC9TcUM2SFZvL0xaSndpZHVo?=
 =?utf-8?B?T3Nza0V1clNNWU1ZMnhnK2dWRkQrYURBdTBoZ3ltVC9ERzFvL3lwQXF5REEx?=
 =?utf-8?B?ZjRCL1E0UWpycUlUTTlMQ2dvVWgrNlhWQTd1eXd4d2YvQ3JOV25VNW4xdDNX?=
 =?utf-8?B?bHJDTVN4MTl2a0pMZEdQVlpraFdkbXVFTDVsTGFNS0kxVVliRDNVTzhoQlZ2?=
 =?utf-8?B?VGFsQ3JuOHFNeG9NQUFvL2llRS9maGk1SDJzR3VZQ3RyTnBsLy9xNENvRWth?=
 =?utf-8?B?R2lURUwzbDM1TVluRjhWakpwc25WRG94TFo1Y2xHZmxVQ2J3WVJKWVJ6V1Vp?=
 =?utf-8?B?Sms5TVo1eXVRanQ4Qm1VNEZyc3FDa081VjE5Qkk4V0JKTHhEMlhvZUhrTG9W?=
 =?utf-8?B?OTZKMFdDbURnT1p2SGFXYkxWL1M5VE94WWxRZUwwelVxeGc4ZkdHc3RQeGJz?=
 =?utf-8?B?Q3EwRDlmUGM2VmE0aDhtWVVwNDJRdDRVVXY5K1Y0MWhSWGs4VnI1bmlsUXlm?=
 =?utf-8?B?c25MWCtJUFR0U25zU1BEZVROdGZ2QTVzdGFHYW1OV0laa056QmI5RDZaMTlQ?=
 =?utf-8?B?TnRDRTN6WlhSL2VvRW1XbjVBL0sweHhLTUdnVFhEbzMxaEE2OXB6R3JndlVu?=
 =?utf-8?B?VmNpUjNCS05EWm9uY2QveThaRjhHbWk2eHJZTjlMd3lpbXR1RTE0Q1RXaTA3?=
 =?utf-8?B?Q3ZLQVNCdEw5eFJjRUVSdTFVR1kxZWY1dyt3cGoycmpVQjZoNzVVeW1NWXBx?=
 =?utf-8?B?aGtYQzBNc0lwcFEweW9IWFVVLzZBQVdTUXpQSTdmbFVUaHdjNkJ6MDF0K2xT?=
 =?utf-8?B?S0w2ZnFyNG5BNjJ3REd6N3dMZzExZHlKZWdFN2N5bE5QMTF3eDNoM1pXdzNN?=
 =?utf-8?B?YVN1bEt6ZHk0U3d0MDBpaDZZV0VBK3o5MVFFUjNJUk9VQVZhRDV6T0cxV2d0?=
 =?utf-8?B?emd4a21HdzQwZkc1cjI0SW80UzFyVktZRXVFY2FTN0lwM1FiVW4xbnNkVjV3?=
 =?utf-8?B?Qk5kcVdBMEsrZmlJanV4WFB0TmVOaWNvMCs3QmQzU1pHMTZsRG9reFVVZ0pz?=
 =?utf-8?B?MXFwVm5rQW51UU1qcEVIamovc0RuMmFHdlp1U0NqQityN1dEWjhQVjdJUGJo?=
 =?utf-8?B?WW80RktTeWRvOVhVci80WU9jenJNR2N5N0ZjeFFjRnZ2TjQzVGZObXlLQ1Vt?=
 =?utf-8?B?UHowNlhaYjhwSHh3ZGxTUnIrUllRRkM5dnl0eG9na3Q5bzhjV1Vab0NXVjNX?=
 =?utf-8?B?UTBBYUd0NU1zbkhBR05VTjFOdHRDVS9XYjFhMGlKTDhMNWpZclo0QVB5UkN6?=
 =?utf-8?B?Vlc3QWdhalB3QTFXSzB2bUVUL2k0OFBDMjFOdnhGYVBLbENoQVhUZmNxOHNB?=
 =?utf-8?B?RDB3UXFaRzdwWVl4NkpFdlJhVTBlVDAwU2xTK1llWlJRK3NtYzRzRERBb0lo?=
 =?utf-8?B?QXpIYUVWSTlGMVpzNW1MYmg2QXQ2U2JVM0lmZkhUSWZGSm5EVEJ4WTlTM3h6?=
 =?utf-8?Q?ij12AP1P36O1ZbNjHapDVoqGONlpRo88?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5819.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Z3dPWE1yN2VkWlJqeHNFR2hld2dnWjFpVHJuWU5rZ2JKMzZwKy9mL0YrWjYw?=
 =?utf-8?B?RVR3OVl3TzVlL0diODdFUW05RUVpdDAzcHBqSUJ0Y0N6RWNGd09hQ3p5UFRQ?=
 =?utf-8?B?VStYNnRrMVdhQWdROXprYUUxeTBVbVFjQ2xGSXducU0wSi84bWExcWR5NVJG?=
 =?utf-8?B?ei9YM2lwNHhsYUdnZzFFZ3FPRks4RVlJcXA1MlNvc0g1dWI2TUdqQnh5dmRq?=
 =?utf-8?B?b3JWQ2l0TStoQzNzWlBFQjJ4a0tEK250eFhlSGlQY3NZbTlzd2RicmRQWHdx?=
 =?utf-8?B?S1FkbzJjeC9oeHlvdmh3emJMYUM3M1VXdkZxTjBaS0FORVg5bHRDeVp1SmlE?=
 =?utf-8?B?RDZXM25UbnZTUkxLOHJXaDF5Y0hOc3RTVDBLVkg3OGtXa1l0dy8yUko3S1hj?=
 =?utf-8?B?emlsYXNoM3RkcSs4Y3J6WDM1MUNGSHRKbjFVYkpaZVRRN1hDKzluS1NSZWR2?=
 =?utf-8?B?bTBPelZMZ3ZlcVdPUjNLbHdPNVh0cnNDeWo5OEdMZTlCUlBwWnNPcHRZVENr?=
 =?utf-8?B?L24zUS9ZQ0h4aWFabmltaHE3OU52cFpIMDJYN2Q4WFM3cG5ZdXhCaDZWRGlC?=
 =?utf-8?B?ZDVTRys3NmF4S29xZ0xDMXdMRTB4RG5veW1SdnhEUnM2WVlkOHFTaHZsa0pX?=
 =?utf-8?B?aXRFTnRvdEppRkNISnJUdTRnbHppUVpBa2RpdVVRMXBwa2QxNHJaeXZJTmZm?=
 =?utf-8?B?aWRXUjljcmNrb0FPT29lVlpYdWpKRXV4R2Q3YXNXYTdBa0czcmprMFN3Qkky?=
 =?utf-8?B?RkMyZno2dkwxZGw5VCtTK1AzSjg4a0Y4VzJvOEppblNuOG9yRFcxOGZtRC9z?=
 =?utf-8?B?M256aUZEaFhMTGd6eGkwZ3U3TldhSUpBRmZsZ0pZd29uQUU5RDNvWEJ4M2JI?=
 =?utf-8?B?eS91emhrSGlwWDlySFd5b1NCd25TWDJLR28zOENEVExNSjdaZmxHbzNVU2hv?=
 =?utf-8?B?MUZ4aEtIc1ZRNjZ1clFPK1NVS2FRM2tyMHhmWE5UZmZxR2h0Y2R5MVAyTjky?=
 =?utf-8?B?MUY2aFNwb1p2cG9HdnB3Ri9kcmdma2taMnhUalRHa210UG5nSWVLdHJWbVB3?=
 =?utf-8?B?QnRRdFoyZWZka1QzVkxYckFmdlQxS20xZVJPMDZyZEhwYWFtZ0tqMWgxRG9N?=
 =?utf-8?B?N21LaElPWlU4ZVpMSko3TGV0T04wY2l6ZlRlTHBJTnpjakJWYUNhVEo1TDNL?=
 =?utf-8?B?MnJYWGx5L2o4TVN0NVpDd1BUcU1sUGFDcmZWYXZxSmRIQUJmZnZNRnNVZ09k?=
 =?utf-8?B?dWhjTVJVdzhlWndDUnZDV0w1T2ZwbmRMUEhjWWJ3b1VCK2ZDNXVyZ2o1MEo4?=
 =?utf-8?B?dEtITk1xMVJld1V6eU84cm9qWnBJM2czdlVmK1JkUTVmdUNWRVhXYjZkNXdS?=
 =?utf-8?B?c3dxWXc1ajR2Q2pzc3ZSc2lvT3U2aloyWDBKdzVCNUVlUFNKekEzU0xmMXdu?=
 =?utf-8?B?d1ducVBmM2FiRXRCczNJTnBFKytyMjF1VlFmSTJ4RTRwZ3ZNVTVZTXhyTC9F?=
 =?utf-8?B?MGxWdmhoT2grQ2t4cHl3QTJ3K2FSRDlXRTdZZmZpeU1oUGM4TjZvNG1oSWpn?=
 =?utf-8?B?MTcvSm9hSEhCbmlEYi9SZlRNY1JZRUpmUVR4TlZ0c3VDYXJPZys2SDNtZ1ZP?=
 =?utf-8?B?NFhQaWovNEN5cG1MVVQrVThxby9GeVpqL00rSit3SWJZOUpWVlBRbENYbFpZ?=
 =?utf-8?B?UHEzZlFCYUJyU3dwNWpIOUJaeWJyVDN6MGR0QWtvQmJTMXVqamxQbHJrbXc5?=
 =?utf-8?B?YWJ1ZFRrd29ZVlRYRVpUSForVDdPSXc2NTdHWXZTajNYMEVJT2lFQ2xPS1B6?=
 =?utf-8?B?MHJoamtYS0xOQUIyVm5sN25ZcWV0RTk4aG1aRUNha3JLK3R3VDVwYk92ZEJv?=
 =?utf-8?B?RUk4UVRBMCtHaVpQMllrdnc1Vzh1b29tUTMxVFNsYnJ0dWlja3d1aTh3aStr?=
 =?utf-8?B?bUZjZjRFd3lNZUZRNlpkVElGcmc0dUpnZUtkOFNreStLMUVidzNWeFN4MFpD?=
 =?utf-8?B?S1JSaUI2ZG54bEhia25CZjZpelVoRWtsbVNJdVk0VkFKSE5HUmlzS0dpb1Ur?=
 =?utf-8?B?Zkhrd2RNVGFFZnRGQnRDdTVseWFFNlBzdnl4NjljRGNCWkZqcU92Zmczamsz?=
 =?utf-8?B?OUlOZG42ZktHdEp3c202c1NFd3NEUW1iMHoza056aWZoUERMYXFITHlReHg4?=
 =?utf-8?Q?tWvA9z66iMwlfU/G3WcSQJA=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <49DA7906B9AF1F418964F26C0BDEC3BE@namprd15.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: ce6debca-f027-422b-f389-08dd6195bbb2
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Mar 2025 18:43:08.3424
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DL6C9Y50Xh6pR6ijWpK39p6IA5J35gdNiixJFxWssJ/LgQwxhf9RUQdyTB8GYlKcTe1YfIf10DQGxEGH7Ej0kw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR15MB5848
X-Proofpoint-ORIG-GUID: VtNnAxRuD9KFoC54PMGOcnOC-jM7ETy3
X-Proofpoint-GUID: lH2hNi2kvyoPdA0kFtml5F_UWL3pajNh
Subject: Re:  [PATCH] ceph: Fix incorrect flush end position calculation
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-12_06,2025-03-11_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 adultscore=0 malwarescore=0 mlxlogscore=999 phishscore=0 spamscore=0
 clxscore=1015 impostorscore=0 suspectscore=0 bulkscore=0 mlxscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2503120128

T24gV2VkLCAyMDI1LTAzLTEyIGF0IDEwOjQ3ICswMDAwLCBEYXZpZCBIb3dlbGxzIHdyb3RlOg0K
PiBJbiBjZXBoLCBpbiBmaWxsX2ZzY3J5cHRfdHJ1bmNhdGUoKSwgdGhlIGVuZCBmbHVzaCBwb3Np
dGlvbiBpcyBjYWxjdWxhdGVkDQo+IGJ5Og0KPiANCj4gICAgICAgICAgICAgICAgIGxvZmZfdCBs
ZW5kID0gb3JpZ19wb3MgKyBDRVBIX0ZTQ1JZUFRfQkxPQ0tfU0hJRlQgLSAxOw0KPiANCj4gYnV0
IHRoYXQncyB1c2luZyB0aGUgYmxvY2sgc2hpZnQgbm90IHRoZSBibG9jayBzaXplLg0KPiANCj4g
Rml4IHRoaXMgdG8gdXNlIHRoZSBibG9jayBzaXplIGluc3RlYWQuDQo+IA0KPiBGaXhlczogNWM2
NDczN2QyNTM2ICgiY2VwaDogYWRkIHRydW5jYXRlIHNpemUgaGFuZGxpbmcgc3VwcG9ydCBmb3Ig
ZnNjcnlwdCIpDQo+IFNpZ25lZC1vZmYtYnk6IERhdmlkIEhvd2VsbHMgPGRob3dlbGxzQHJlZGhh
dC5jb20+DQo+IGNjOiBWaWFjaGVzbGF2IER1YmV5a28gPHNsYXZhQGR1YmV5a28uY29tPg0KPiBj
YzogQWxleCBNYXJrdXplIDxhbWFya3V6ZUByZWRoYXQuY29tPg0KPiBjYzogWGl1Ym8gTGkgPHhp
dWJsaUByZWRoYXQuY29tPg0KPiBjYzogSWx5YSBEcnlvbW92IDxpZHJ5b21vdkBnbWFpbC5jb20+
DQo+IGNjOiBjZXBoLWRldmVsQHZnZXIua2VybmVsLm9yZw0KPiBjYzogbGludXgtZnNkZXZlbEB2
Z2VyLmtlcm5lbC5vcmcNCj4gLS0tDQo+ICBmcy9jZXBoL2lub2RlLmMgfCAgICAyICstDQo+ICAx
IGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkNCj4gDQo+IGRpZmYg
LS1naXQgYS9mcy9jZXBoL2lub2RlLmMgYi9mcy9jZXBoL2lub2RlLmMNCj4gaW5kZXggYWI2M2M3
ZWJjZTViLi5lYzliODBmZWM3YmUgMTAwNjQ0DQo+IC0tLSBhL2ZzL2NlcGgvaW5vZGUuYw0KPiAr
KysgYi9mcy9jZXBoL2lub2RlLmMNCj4gQEAgLTIzNjMsNyArMjM2Myw3IEBAIHN0YXRpYyBpbnQg
ZmlsbF9mc2NyeXB0X3RydW5jYXRlKHN0cnVjdCBpbm9kZSAqaW5vZGUsDQo+ICANCj4gIAkvKiBU
cnkgdG8gd3JpdGViYWNrIHRoZSBkaXJ0eSBwYWdlY2FjaGVzICovDQo+ICAJaWYgKGlzc3VlZCAm
IChDRVBIX0NBUF9GSUxFX0JVRkZFUikpIHsNCj4gLQkJbG9mZl90IGxlbmQgPSBvcmlnX3BvcyAr
IENFUEhfRlNDUllQVF9CTE9DS19TSElGVCAtIDE7DQo+ICsJCWxvZmZfdCBsZW5kID0gb3JpZ19w
b3MgKyBDRVBIX0ZTQ1JZUFRfQkxPQ0tfU0laRSAtIDE7DQo+ICANCj4gIAkJcmV0ID0gZmlsZW1h
cF93cml0ZV9hbmRfd2FpdF9yYW5nZShpbm9kZS0+aV9tYXBwaW5nLA0KPiAgCQkJCQkJICAgb3Jp
Z19wb3MsIGxlbmQpOw0KPiANCj4gDQoNCkxvb2tzIGdvb2QuDQoNClJldmlld2VkLWJ5OiBWaWFj
aGVzbGF2IER1YmV5a28gPFNsYXZhLkR1YmV5a29AaWJtLmNvbT4NCg0KRG8gd2Uga25vdyBlYXN5
IHdheSB0byByZXByb2R1Y2UgdGhlIGlzc3VlPw0KDQpUaGFua3MsDQpTbGF2YS4NCg0K


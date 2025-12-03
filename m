Return-Path: <linux-fsdevel+bounces-70611-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F127CA1DF9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 03 Dec 2025 23:55:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E92BA300447B
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Dec 2025 22:55:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAF5C2E5402;
	Wed,  3 Dec 2025 22:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="hbzub/Ct"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A34051F3B85;
	Wed,  3 Dec 2025 22:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764802499; cv=fail; b=VNodGcaTXPUgrjPNtJZD3n0s715Nm4yMpb8xv/v0gzO/pNveV8NTJDSouFng07L82SEWoeqKaPvRtW6PGemO8uSAJAxIW8N8DZa6nPeBXOzQgmKBTJoMhDgkhH4TLpjBiGsbAEPA2EhO+wnLTRE6GYwNfc+HnROB9EeEZ1dgzvA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764802499; c=relaxed/simple;
	bh=9HTuIYe6dv4h6iMZflBzcv6EstIUzXl69KDJb/pmVf0=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=ZBuGBxgN9jt/XSuJegbZHxY8LB/QXVX9guJlJwX/rNDbTlXK7FEFhcB+RPxem1aFwIDKwlnUrxi+X3BGmjKrJA9dp0prk6PwxQE95TX/XISSVWt2nfJpAmA5wlPe05rNd5CFNZfjYd4Pfzl99iXh/wL8YSDdkeJa7mgFGZEkTK4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=hbzub/Ct; arc=fail smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5B3FqQFc013225;
	Wed, 3 Dec 2025 22:54:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pp1; bh=9HTuIYe6dv4h6iMZflBzcv6EstIUzXl69KDJb/pmVf0=; b=hbzub/Ct
	3jquKttV1fZPC0CbjaAuK9dO+JgxmFgfpvHgTepWOjO6wVTLGg4ne2t1l3Q4YA8Y
	Z4VNQ2bngPbJpasA9pCgc7K8CX2VpS/hlQiChXWZFWipjclZp+goOHzBe5zpE5hX
	UyiII9QRQwzZuCAiaolMidobp6KKgTlLnggHGfySOhjVmUeOXLxZFbZpN0cOK9Wf
	qgBuHg7OHIJEXWCDmSvEMSMOejR0j3259rrSzpg10NfCZa86rM+UbqSFKoblg8JX
	UgKCCrhrzQQws2jrT6zwhWm0OdTt8/WWR3JbBgGHs9FyxCyW/i2IaK5ZvbHCZEuN
	7pdguZcztBc9YQ==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4aqrj9wdrs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 03 Dec 2025 22:54:54 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5B3Mr6DK011880;
	Wed, 3 Dec 2025 22:54:54 GMT
Received: from cy7pr03cu001.outbound.protection.outlook.com (mail-westcentralusazon11010043.outbound.protection.outlook.com [40.93.198.43])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4aqrj9wdrm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 03 Dec 2025 22:54:54 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ymVqd/XJ9og1IVfcoTMzYizM5W9YxdLAT1RM9k9rBdSlmCu3b4XWq+iI7aPfgmzh0TF/8hB/SY8xA/kaZ3Jpd/vz5EQpuQTt4ehmfNZsWDERJfsyJZRGCKD0SvRmD50wp0nOqnAqrTu9mX+1RNhwldDjWAGeYFS069JmPxCF0FEcR5Jef//t9Ul3vWhveyEYdOaYaUtYZAiaYQE+1wF40wDAj/wVfIXpkXBP7ScOT/UmdIuZfmTAowKhZtUloTAWxIYMZP/UwtXUvmMkHGyh+qVH0U9kWD7+Q2RXurmWAhbNhTj/7NNONZIT13IpnDRmToYnjs6ZrH/Fn+xZ+3wBPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9HTuIYe6dv4h6iMZflBzcv6EstIUzXl69KDJb/pmVf0=;
 b=iSx5r5c8JXTj89QVH//AVc3XI/xVPiuc5g97eC/3O3OqkpJ+7y1idOASACRqAx/zDYSvZi1yN5Q0SslFPicfCb0CAdZ1c4MU+1mhAkx5qAU3CUIMSF89fkRTmcgvCuhlrNZ8juBjCzmfkp5c8j3EURHMdW1pw5ssil4I2CBZfc/t9Q+BuapxitUTSBqM4f/DvU9WvINzZnuY3EkSsIMAoCH4tbxfHxv/5r0Nl5/OjeDOLBk02HxgkSOyOujKK8Lrgvs/IRmbIHLa4mLIfvPmh0u2aaJSQiCU95JFgNw6S7/pxDDY0ArWIgI21BaN/uDXf86ySn/O7oA7dQzUHxvfRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SA1PR15MB5819.namprd15.prod.outlook.com (2603:10b6:806:338::8)
 by MW3PR15MB3898.namprd15.prod.outlook.com (2603:10b6:303:43::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.9; Wed, 3 Dec
 2025 22:54:51 +0000
Received: from SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539]) by SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539%4]) with mapi id 15.20.9388.003; Wed, 3 Dec 2025
 22:54:51 +0000
From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
To: Alex Markuze <amarkuze@redhat.com>
CC: Viacheslav Dubeyko <vdubeyko@redhat.com>,
        "ceph-devel@vger.kernel.org"
	<ceph-devel@vger.kernel.org>,
        "idryomov@gmail.com" <idryomov@gmail.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Thread-Topic: [EXTERNAL] Re: [PATCH v3 4/4] ceph: adding
 CEPH_SUBVOLUME_ID_NONE
Thread-Index: AQHcZJsMNCX0POS6GUieDyf6NSM/g7UQhnIA
Date: Wed, 3 Dec 2025 22:54:51 +0000
Message-ID: <7720f7ee8f8e8289c8e5346c2b129de2592e2d64.camel@ibm.com>
References: <20251203154625.2779153-1-amarkuze@redhat.com>
	 <20251203154625.2779153-5-amarkuze@redhat.com>
	 <361062ac3b2caf3262b319003c7b4aa2cf0f6a6e.camel@ibm.com>
	 <CAO8a2SjQDC2qaVV6_jsQbzOtUUdxStx2jEMYkG3VVkSCPbiH_Q@mail.gmail.com>
In-Reply-To:
 <CAO8a2SjQDC2qaVV6_jsQbzOtUUdxStx2jEMYkG3VVkSCPbiH_Q@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5819:EE_|MW3PR15MB3898:EE_
x-ms-office365-filtering-correlation-id: 92e8ea63-309a-45df-98af-08de32bef7bf
x-ld-processed: fcf67057-50c9-4ad4-98f3-ffca64add9e9,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|366016|10070799003|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?dTZxOXZLTDNYckhkbUVoTGtOUkI0NnErYW5SMW00MW1scUovYTdYcitFVjFR?=
 =?utf-8?B?VEtlR1k4TUVzQzVUUUxQWWt3Wml2TjBhSHRlbDV5WThBNEdmUjlaaE0xUVhp?=
 =?utf-8?B?dDRMSGxtRXc3V1psRFZrb1p3blUrYjFPUE4raVJETVczcjNkd2pQeU1BVmdw?=
 =?utf-8?B?akRaYnlacCtRUEJkckNnL0JOVWJRUFhrVGdOSXJpakNLYzZEbHhIRmdnajNS?=
 =?utf-8?B?dms2YVVYak8zTzhZNWR0YnhOemFpUkJGWktUZ2R6OE9rck9HNzJxeFZ4RE9p?=
 =?utf-8?B?Y25Qc3huZ1lEY0UyYlVRcWhtLzB0aXJIazFnVTQ0N3M3aG11WE5qY1dzdXJH?=
 =?utf-8?B?dWhPb0I5Y2ZiK3BMSTQ1b2k5N0RQODhFUjRDellZYWxjNXlwM3ZCUjZCSlNF?=
 =?utf-8?B?eG1nbG9GMzVITjcwNFJuY1ZrU1JZblNHTGg4L2xFTEtESGphaG5wSzlpQ2gv?=
 =?utf-8?B?QzZTZGhXMUhEVnlUZDJ1OUxMbjlhKzhLRVRlNFdLRVhQNFNucmU4aUR6UzV1?=
 =?utf-8?B?T1c0RlQ5OUV5Q01ZSEVsTm5ILzA3TGx4WXFFb3pZNVh1dlVnQnhlYVdLVjRN?=
 =?utf-8?B?ZGI5eWd0ZFh5ZGhWWDRHREVzUGxjZ01hSndsVkpSZzkvN0VZU0g5aTBFRitW?=
 =?utf-8?B?ZXBKc0RQTHdpS3JNT1pma0FFN1duN0hnVWdkSFFhS3VNSFJRN0hMd2hXcGM2?=
 =?utf-8?B?blNVaVgxNFAxTUJFQWxRWEJUNEVPZG11cGJ0a3JRRS9NdVlzQW03d05XbTJH?=
 =?utf-8?B?Y2ZBT0V3ZDNxUDhiUmFPU3g3ckRHZE56K1lyZXF2VFdmdHdYQUZGYmhibWs3?=
 =?utf-8?B?U1cxRWlJUEdPL3hqT1BoVFRpV2VQdHZ6TVFCN3YvRlB3UWtlTnBHMzBBajkz?=
 =?utf-8?B?cGp0MmNBeUx1SGdBWlIrUi9rSnlneW1QWTU0VWZiSTRlYjMxRHZHaForWmI5?=
 =?utf-8?B?V1lDMWd2WmRGL0ZyZFd3MWp0bW8vK0p0RVRXTjZ6bmJ1YWQ0OE9RWHo0TGVF?=
 =?utf-8?B?SjVIWm5Hb04zL0NGSDFrQWlyM3Z5VE9QRjg5WkJYRDhmZ3NTeE9qR0g3U20x?=
 =?utf-8?B?L2dFRG9EbVVaOHJaS2dwaFJpSWJpNlpidjF0T0x2WmJMdVFBMm9BeUcwL1FL?=
 =?utf-8?B?ZmpaQng3N3ZCZU9UdU5EZ0NWYmtZellYYXBPd1JDSE5pLzErWmIyS3FMeVBa?=
 =?utf-8?B?UXB4RWU1N0dSRWhkNkdDM0N5VFk5Kzd0alJQamViRmF0RGMzMmJRNkl0UnhM?=
 =?utf-8?B?bzkyMjBEMzNkdXVldVUxb0pBRS9yR05NWjZNTUtXTXpGMEV2YTRtbXJXcHVL?=
 =?utf-8?B?T0FzbVN2a1c3eDdsalZuTDFPOHFBQ2lLYnQ2d24zanNoRGJxYzhPeGxzQ3BE?=
 =?utf-8?B?VUFQcE5wNmgxTndlb1AvTWZOL2dtcUgxWjZrY3ZEbWlxYWNzSnlrRHA1MTEz?=
 =?utf-8?B?WjlTbGIvVm5va1dKck0rdGVaZ1pRZTY1NkFuRlBBTlRzZkZ5ZmZJVnlFdlM1?=
 =?utf-8?B?b2QwbE9TdFpod0hvb1dWcmRxNy8vdSttL3pXMmppdEpnMjUrSXpJRXQ2WnVF?=
 =?utf-8?B?TDlnMVRPZUZ3WWJ5WEdVakRxMjM2aTlzZnpYeDlmZGc1eWh4Wi9PR29uSG9a?=
 =?utf-8?B?eWo5aWJPbmhJS3ZqNlhSM0pNVTFLTkdpeE11SzNFUUsvbi9xQ05SY3JERDBZ?=
 =?utf-8?B?OTc5OGNxais5Zyswb1NhK1lPMWRNL3FSQkVSNlh6eGNmbFBoMTRqZ2I4TzBC?=
 =?utf-8?B?NTRHNm11Y3VLVDZ3YVNJUnJscHozcVhQUUNLUk54QmtPSlVDYmNaQkd5MU5l?=
 =?utf-8?B?Y1dsd3lyYWFJbkJoRUVnZE1zQ1ZIRzBvSVcxY1R0WUxqVlFSSThHSWVKTitw?=
 =?utf-8?B?a25CcVllaUVjVjQ5U3U4NC9jd05sWEYxV3FOZitwc09KNHNjRGxzVzV2Mkk5?=
 =?utf-8?B?Q2JpSzNpcnJ4a3RpSTNXQlJUSWNyQ2lReDF1OHhkUjA2TGpFK2pVR3pZUkc3?=
 =?utf-8?B?aVFxZE9YMUhxSTdhaWlYWWJyV0xUaGJhbmh6dlpLTVo3NWhnN09RU1BjNWY2?=
 =?utf-8?Q?hnNMia?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5819.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(10070799003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?cDdjRmNkR2JSUzljRW5HYVhNU3N6Q3FlVjR4TTlpQ2g1TVBmNTBta3ZJQUZs?=
 =?utf-8?B?RG9zRTBic2dMc0JyaStQWS8vUFNiMDNtRkIzbUlIR29SQXM3RzVGa0dhcnp2?=
 =?utf-8?B?NGZlNHpjUkZCQTFHS3VScTIreTRMQTV4bXNRSXpCTHROMExGUVBkcmFkalRD?=
 =?utf-8?B?ZHhJSys5TEorWnhtcWNPcnRJaENER0NHOGlzK3BIRnh0ZjFvbHY0RWV3SEJ3?=
 =?utf-8?B?bDdHMzFKb3NlMjBGRFV1S3lvUmdSQU0vbEt2MDI3bFRiU0dHNEJrNEZyMDRj?=
 =?utf-8?B?eWFESGZDUkljdmdteDJ2YVZveTBNNW5KUkhNOGJDbjNYd0hCUHBVZVZDNDd4?=
 =?utf-8?B?YjdlSTJMNXFLRXpyMmRxYU1GWjNGc1FJUTJCMk8yT0xvSmx6V2xyaFFaQUY4?=
 =?utf-8?B?Z1k2Qk5GRUpOY2tMMURKRzNTRkYvSGNLaUVKY2xzNWpyRGZDeHhDRTVhSEpB?=
 =?utf-8?B?eXpjMFk4YWs3Y0dWR3dPcllwUVZlM081SGwybmZuNlkxWjNwOUdNbEk5UXdQ?=
 =?utf-8?B?K1dZemMzNXFoeitYUWpRR3VEZmFvOVVGL2NqNEpaMUtYMzVMdEp6aUlhMVd5?=
 =?utf-8?B?RFZzOGVEclBDdTJFYU1FaDhWWHZncTYxWEN5K2dKeGJEWU1GOGd3VEJTamNw?=
 =?utf-8?B?MFI5cEkwdnJFV0hndjZWdDMxTTU3ekRhc2FubVNIYlBBbEk4QjBMa2VKdmZU?=
 =?utf-8?B?RkJUL2lzQ05OejUwenh6cUtpc1h6Um5Kam5HMmNNdFY5Unk3S0lEdklTMzJq?=
 =?utf-8?B?Rlo3U3laVlhESXY1OEQzNmpMOUkxNVUrbjk4VmNMZ1J0S2NBT1RNcHV5MjFL?=
 =?utf-8?B?Um5XZjhqVGZZbGNoUmxvSi9BUUtRNW02ZnRqWklZSENzR3BLWW1qc1oxUm94?=
 =?utf-8?B?c0ZHcHR6c1lENDc0aHBYeTU0OE0yamI3V21CSGlvOXlJeW9nbnZHcitDTEdX?=
 =?utf-8?B?TWVjZ0xPVVRVTXROVkFmaEliaEE1c3RoQlNBUlB0a1JFaE8yWWdsTVkzRUFz?=
 =?utf-8?B?T1JiVS9ZYUZ1N2RMQVAwb3pJOGVKM3RjNU41bnM4Q2FBSlljeG5hcmMwSXNH?=
 =?utf-8?B?ZkxRczBsYzFpMVhDd1pkSWwxU04yV2t4TXRNVkloV3U4eGxWQmNFZm56a1g4?=
 =?utf-8?B?VnBQODVldFF4Slg2Y0dsejBycXdBNitTNXo1MkgwZFNFbDRjNW9NSjhiblpw?=
 =?utf-8?B?cmRPcFJyTmo3c2M4ZGVnTDNmUHl2WEc2V0k1S0w4dXdRQTdBaGpSeHM1WDZD?=
 =?utf-8?B?MjNXVWUwL1Rmbnh0Ri9OTTRKT25XcEsxQkFUWm1XMlFZY1hxQ2c5K1JjaDRo?=
 =?utf-8?B?ZS84enlkb2N0bmxHdW9hbjRtTGt5bzRJMkl4Y3ZFTkZlY2FYd1pvZE5od1ZE?=
 =?utf-8?B?eFora3ByK213bHdBVWZTU3ZNU00vVFNLLy8wRlkwNktQbThWcW1xbzZOdWl3?=
 =?utf-8?B?cHAvb3loSnI5OTZhNjdjRlpBQVh3R0pGYjdxbVpmV21PVFg0dnY4STlHK1J2?=
 =?utf-8?B?WUc1VkJPdHVJNHowRjYvck5zVVRYSnZQVjErY0daYnJnUnpLTFJBWFpCOUxj?=
 =?utf-8?B?Y3hOTnZsbnVhNHM5MXg5YnMxRkQzbjNtbnJpYTJ4aVpMYWNwOHJ1cXliZWN2?=
 =?utf-8?B?QUE5a0wrSFhEWEVkTTd2TEc5YVB4bWR4Q2FLR3M1bmhqVzc2S0pJdmRYK3V6?=
 =?utf-8?B?OEF6L0NFb0RPSWtJQnQrK3ArRHA4RU9jUWpLeTc4bmVtZnYyakx5MUs2MEds?=
 =?utf-8?B?dUdqYWZoVGhSWnExZDcrRlhqbm01ZDdqWlgvTnlRb1NEQ1BMYnVJS2lZVGxp?=
 =?utf-8?B?MFhxLzZwTm40eXJxNExuaDBMa0xBQTNzb0dlU0JiQ1lwa0JRZmg2OUtiM2cy?=
 =?utf-8?B?MzRZNWtEbVpndHhsa2Zvd1ZUcUNhY2kzWmdZMXQ2bjRELzJDWm1QQUJVN2pI?=
 =?utf-8?B?a0NnbDNCRmo3cjdiRVdFYStKQmZJZ3ZHeTByM0w0VFQzT21tVWVVb3hQYTht?=
 =?utf-8?B?NkxtSnJBSGNXL0RkTXRUQkNxRDRzYlFJdlo1QjliM3MwRFRkSzRoanVNRnZ2?=
 =?utf-8?B?dC8yb3B2VUozRU5zQi9qYXpGY0V6azRUQWY3NXlHakxPYnhGNzlLaXZHZlpG?=
 =?utf-8?B?bjBSRHFwR1hMT0JVbVZEZU5NSXJabW1oSXdseTh3REM2bkxPaUNSOThsRnFO?=
 =?utf-8?Q?PHHf9i22N3/C9YAYtc08zfA=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <804FDE8D3C90D74D9A8A82C3486A48A1@namprd15.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 92e8ea63-309a-45df-98af-08de32bef7bf
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Dec 2025 22:54:51.3778
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Qv8ST8RllWPkprWgJ4Bd64tPk3L82unDqawNQWRgW9T2TMaI0igcTfmf8CD6iJbsjnjWyJIA4GPiZY56pw9dIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR15MB3898
X-Proofpoint-GUID: AjPgR8RDHyQiuim2lDwR10Ds4cyQESbE
X-Proofpoint-ORIG-GUID: UE1FyfnQhLQJA1LNlXsr4euBEIYO-7BA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTI5MDAyMCBTYWx0ZWRfX1nSndFZy3xvN
 4nG9eBG5gQrYXvk9hSBDJ215k0CL4Kac7VNqOLfe4phqmawwUUyBALlo3kUV/0BTYQtZuY6zJdk
 XLqtfZ+51CQWragF/yoTiuTR70yDlhIOugBPe3ICdoeP1X1RR9wOMCCyT0HwoQQ9siVlpVTDJOD
 T8DJtE5hxb5BrNCN15v9O8d7ZuPMNQXbbfzegG8qgfrB8cy+pft4gtpYfv0OVYjB4cPROQ4NEef
 4oXWKws1jq7qrsnHQeuF0zh9ohBiPudu5ZhDQLk25724Cw8YmyqTjyQlNvGUhGsFTI43Kocdux2
 oLAWUyIYKjisCUoYB0ro6CHzQVQaj1EYme8uA0Q7N9ujxyVL+zahTLFFweM8mw/TcUNVhzcER9z
 DEuYF7bRYwMN4NtPmCwsSZIScmchZA==
X-Authority-Analysis: v=2.4 cv=dYGNHHXe c=1 sm=1 tr=0 ts=6930bfbe cx=c_pps
 a=CcIcsZDwO3wB2ho3dvPJ0Q==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=dW1y_S8sXPSIccB1464A:9
 a=QEXdDO2ut3YA:10
Subject: RE: [PATCH v3 4/4] ceph: adding CEPH_SUBVOLUME_ID_NONE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-03_03,2025-12-03_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 suspectscore=0 clxscore=1015 adultscore=0
 lowpriorityscore=0 bulkscore=0 phishscore=0 priorityscore=1501
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510240000
 definitions=main-2511290020

T24gV2VkLCAyMDI1LTEyLTAzIGF0IDIzOjIyICswMjAwLCBBbGV4IE1hcmt1emUgd3JvdGU6DQo+
IFRoZSBsYXRlc3QgY2VwaCBjb2RlIHN1cHBvcnRzIHN1YnZvbHVtZSBtZXRyaWNzLg0KPiBUaGUg
dGVzdCBpcyBzaW1wbGU6DQo+IDEuIERlcGxveSBhIGNlcGggY2x1c3Rlcg0KPiAyLiBDcmVhdGUg
YW5kIG1vdW50IGEgc3Vidm9sdW1lDQo+IDMuIHJ1biBzb21lIEkvTw0KPiA0LiBJIHVzZWQgZGVi
dWdmcyB0byBzZWUgdGhhdCBzdWJ2b2x1bWUgbWV0cmljcyB3ZXJlIGNvbGxlY3RlZCBvbiB0aGUN
Cj4gY2xpZW50IHNpZGUgYW5kIGNoZWNrZWQgZm9yIHN1YnZvbHVtZSBtZXRyaWNzIGJlaW5nIHJl
cG9ydGVkIG9uIHRoZQ0KPiBtZHMuDQo+IA0KPiBOb3RoaW5nIG1vcmUgdG8gaXQuDQo+IA0KDQpT
bywgaWYgaXQgaXMgc2ltcGxlLCB0aGVuIHdoYXQncyBhYm91dCBvZiBhZGRpbmcgYW5vdGhlciBD
ZXBoJ3MgdGVzdCBpbnRvDQp4ZnN0ZXN0cyBzdWl0ZT8gTWF5YmUsIHlvdSBjYW4gY29uc2lkZXIg
dW5pdC10ZXN0IHRvby4gSSd2ZSBhbHJlYWR5IGludHJvZHVjZWQNCmluaXRpYWwgcGF0Y2ggd2l0
aCBLdW5pdC1iYXNlZCB1bml0LXRlc3QuIFdlIHNob3VsZCBoYXZlIHNvbWUgdGVzdC1jYXNlIHRo
YXQNCmFueW9uZSBjYW4gcnVuIGFuZCB0ZXN0IHRoaXMgY29kZS4NCg0KVGhhbmtzLA0KU2xhdmEu
DQoNCg==


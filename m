Return-Path: <linux-fsdevel+bounces-45242-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 429D2A750AF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Mar 2025 20:12:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E47EC3AC59E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Mar 2025 19:12:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C97F1E1E14;
	Fri, 28 Mar 2025 19:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="aDtcAUQi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0AA51DF986;
	Fri, 28 Mar 2025 19:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743189162; cv=fail; b=HNuCaw42W79Sz2uRkd2/+Hj/4rP811+U/N24kyrIg+K1sn8lYiD4n7hcpZP+iBEwNNAp5kYt/FZ6K/6GQUP37Vsq+zlT2jIF1rcYHc9SU5abCuFOTBhoAbr4Tv/nmiPtP2/u+CeB4TZ+MISh5Gz8l8lbdke+wyISuOwpG53Y9dI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743189162; c=relaxed/simple;
	bh=LBUO3F/LYh71/jobo57JPcjc4kL9dgOuX/IcGOjgaLY=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=jYew3iXDjN2vv61IWlbfqBGHS0FclHE+pYEGq07HQf1F0d/5PTQwrfjazzNEXHHkgksR7NM6d97cqZu7qkrFc4Xu006Ft+dNL0d/AlLxlQphW+D9qX4XiD4kc2tBI5/13wHdD6ycr5hGo1Ppu7LM10ybObblqpQM5fxzHxYNLMY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=fail smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=aDtcAUQi; arc=fail smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52SCq7ev021752;
	Fri, 28 Mar 2025 19:12:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:message-id:mime-version:subject:to; s=pp1; bh=LBUO3F/LYh71/jobo
	57JPcjc4kL9dgOuX/IcGOjgaLY=; b=aDtcAUQi9LY6Wz0hw4YXCK+b1pZ7stJG4
	L3KgOPxaPzS/61LxyoxUKZbZlWr/n7VoC8Wxwz71hCr3+wtJ0LoleY6p4NV7QpV+
	ry9FxggHL7URY4h36yUSfyZZAbl14eOtMc0vx3hs7ZWHxGIMWRrTbjIv1HhAZ2c+
	GzU9ZI5l4oy9olqAcpZFQWcRNayruB4V5H/GuyqI9doWjU7laxOdTA1ycro592te
	A73x/3YLaA2N2RRV56Km2Jm54pr8nOYQpywePDs7VxexrJ67df1vTLI9kLzEHqid
	i+upf6ap2ZMpr/hqJ1/jJBgU3T1zDjD4GGtZz8/mxhWxUddjV6UWA==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45nm59vevc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 28 Mar 2025 19:12:36 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 52SJCarh011297;
	Fri, 28 Mar 2025 19:12:36 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2047.outbound.protection.outlook.com [104.47.70.47])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45nm59vev7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 28 Mar 2025 19:12:35 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i/NgxhVF/ZdsmJS+39vCYqBUvBpd9jizZ9Vxh1VMEUavTwustvVn1crvX47Mm4EqFI3K4Ux/FCLQ+3u1gMSX1AzvqikAyev6un2GuFXI0KrxV2+lbidT4WuemCbB39AbEULLTK6HBT53cmgXo+BigT5lv96Frlu07EapM+3coV3ruPNGXLAanCxQu8uUEdt3TheEUEN+i1h/uN8kBda2fuP0+Ecg58xBwmw19yeXqkKoRwry4ENLg03YsW+8qM/08Bb/dkRmXaDOXBLsCMY/M0+Yraw4DsmbqpuUyUHPKg/37bjqKxi78G9N+FaXg5FIAS9FzcIQNMfHBQ3/xH5LcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LBUO3F/LYh71/jobo57JPcjc4kL9dgOuX/IcGOjgaLY=;
 b=q02BX8pXHYSAgI0tAh5JmLCiT64qvYGm2yOo4TcDJ7/VjUhspLXhXI3s23bwWMECOZnr+9h6/pVC9zuGCCTAZWkW2zfZC9+TQTCTvzgCp26Ngcm8eji1MpCmaXaIUlEjwtApxGEdW6/K/HJhrIcsQZCtvBWaUBOMPJjSvKu3noy0+HwUZxQRyvI2pdFeFWS5EnWqvvFdBT6p+z4yzWJ863vBED014Qc+ro6nq6F20cu5RH9XMCoRdxHCncVn6aqJt5/euiDo4a9gKG+Kuohk17NDkAjmhqjXb3U/DEwHtRt6KDhDVIBkxWrLXw0jUeVh5hwxiYEidDvDskzRvaoNJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SA1PR15MB5819.namprd15.prod.outlook.com (2603:10b6:806:338::8)
 by IA0PPF3B54D8C0D.namprd15.prod.outlook.com (2603:10b6:20f:fc04::b16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8583.30; Fri, 28 Mar
 2025 19:12:33 +0000
Received: from SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::6fd6:67be:7178:d89b]) by SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::6fd6:67be:7178:d89b%7]) with mapi id 15.20.8534.043; Fri, 28 Mar 2025
 19:12:33 +0000
From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>
CC: "slava@dubeyko.com" <slava@dubeyko.com>,
        Alex Markuze
	<amarkuze@redhat.com>,
        "linux-fsdevel@vger.kernel.org"
	<linux-fsdevel@vger.kernel.org>,
        Patrick Donnelly <pdonnell@redhat.com>,
        "idryomov@gmail.com" <idryomov@gmail.com>,
        David Howells
	<dhowells@redhat.com>
Subject: [RFC] page allocation failure in __ceph_allocate_page_array()
Thread-Topic: [RFC] page allocation failure in __ceph_allocate_page_array()
Thread-Index: AQHboBVcDdYDEKVLdkuHXh6srL/aVA==
Date: Fri, 28 Mar 2025 19:12:33 +0000
Message-ID: <644d7cd258476c918d438c358422d7768a5ef287.camel@ibm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5819:EE_|IA0PPF3B54D8C0D:EE_
x-ms-office365-filtering-correlation-id: 2b58c3a7-f1a6-4254-5ba9-08dd6e2c7e81
x-ld-processed: fcf67057-50c9-4ad4-98f3-ffca64add9e9,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?OS9zQ2luNy9hUkZLVU42STRUc1hVVEw0d1FhdENsaGN0U0VyY2NFSGRsNlVw?=
 =?utf-8?B?ZXZTSDkvaVFlSHdYeGZFMHdSejhmK3FLQWVzelFaeTdJQXlycndFaGkwaTla?=
 =?utf-8?B?alVBcFpZWHZmWUxxZVFEUTd6NDU3SkRtYzJVOUNJSFhHb1I5cTZoUEJqc01E?=
 =?utf-8?B?K1FMOXVZUFBDY1NOVXRVOHIxOWZPelJOa3lVSGVmd3hJZ1lkSGh5UVdDUEhU?=
 =?utf-8?B?bllac3NlS1dGR0lKRHhDN1MrT0VwNFo0SkxvMXd2b2dRVm9yL2htanBKY2Nl?=
 =?utf-8?B?ZjFGa2NqOWFBV3AwRmo3eGF1R0dBU25GNHVzejNqNTdEc210OTRhaTFNK0lQ?=
 =?utf-8?B?dUVDejRwcmZYeTJzdm1XdDRwUC9ETUFYVGErd21vU3BNOTlRQkd6eDhGVVdr?=
 =?utf-8?B?ZmNmcThldDNydFlXUE10Q3BkYkZFOTdTOUlkc1ZiMlZvNTN1dHpJZklDVUpG?=
 =?utf-8?B?TmZLK3lCMTdpaFA2NXlHaGtIOXExWEV2dmZRZ0tyTHFVRkM4MWpKZGlOdlpp?=
 =?utf-8?B?V3BRKytpODkyNlZycjBKQUgxcjc4YXJsVmxVeW5lem1hZ2c0cWFqZmppWU84?=
 =?utf-8?B?clo5ZWI0UXZnS0UwKzg4UzBIOHo2T3lJZHdQUmdZU3ZjODYxbG0wek1kVHVG?=
 =?utf-8?B?VEIydDhxRUVvMCtkYzBwbHF1Y0NFVTJ3cWkrMXM0RmFFTVFjaVpnbjdja0d0?=
 =?utf-8?B?NlA5d2ZuK3I3VDdxeE8vaVF3LzBJajlHakY4a0V3WkoxRDBiSjQzQUlpV3kr?=
 =?utf-8?B?aWhabndTSlVabkt2ZGEzV2ZuNXloaHpzYzZZVEtUb2t3RzFVTmlWQ2VYbm5S?=
 =?utf-8?B?cnQ5akhCVmdqT2l1Q0ZzNWdRbkwrSlBZRHNvSGJmSVpmMmtpblYyUTZEblNL?=
 =?utf-8?B?cmltdmJaeFZDM3plU0pkbXlCRTdnWEFONjNHZWltNFUwS2NSSzZDSS9Vcy9N?=
 =?utf-8?B?VzBMNnpEQUZBVFFyTlppS2VLM0Z2dVF0aVVIdjB5RUJhUkM0OTNaNnhXVDZs?=
 =?utf-8?B?aitEN3piaDMrQ3BMcU5KTDAvbGZjS2JxKzBRaDlSeGVOQnFrRlo0OE5XU1FH?=
 =?utf-8?B?eVFKbnZJSkpzUTZ0akZVQW1xZ2daTWFkWlNHUDlIdzdVYjlkcCtZam5xSmFZ?=
 =?utf-8?B?ZDR0VDY0MjNqcjVOWXBnQi9MSDUrbTQ3T0xUUUZnQTBPRGNHMXVFOWhiVldH?=
 =?utf-8?B?UURtUEY2WWhlNEdSeGJOUUlZME1jb1lQakgwR2ptN3ByZk0wcUhkZjNXMGxW?=
 =?utf-8?B?YzU4WnJ4bFgvMVI0RFg5Sjk5endoMnpxd3lwTGVRaXIwQ3FEL3cwMDZncTAv?=
 =?utf-8?B?dzRaeFVKSjNFbnVBSWtOTUtiSEVUNVhqYkZqdTFiSUFVczlVME03bWZGWmJ0?=
 =?utf-8?B?WVlCZjZqOWR3UURmYTU4WXpBc1dKVkxZUkJSNkdkNHhwNkpjcHBCQ1RSaE5C?=
 =?utf-8?B?K1hzMXlwaHoxM3V4dUpHT2ZXeXRaVXlyY1Q4YVR6M2FPR2JqcFE5T3BuNEZa?=
 =?utf-8?B?NWttY0lEbmY0WG5NWCt0bTRBd0x3SXJ2MjFGZlFmakw5bm84UHJtbjFXcWlX?=
 =?utf-8?B?eHdYaVN6L3E2TDdndUV4dWxEWTlNUHBKaVhwdFpnSEpwSU9zMXpDNTJiTVVr?=
 =?utf-8?B?ZUQ5UHJlVmcxdUVHUnpqRTBSUmtZWDlhaW52SHRNODRKZXEwbE0vczFOaU9x?=
 =?utf-8?B?b0NUM3dnSktsTTlMTFYvMUZqOFliVWJrbWdHNGNEUHlwZVhtdHpDNFdQUFA1?=
 =?utf-8?B?TkthR2IwRjh1LytaRmRva3Vwd015Q2NMdUx6NTJDWnhSamZlL3ZpQWgzTEVY?=
 =?utf-8?B?bDZWWUxlNWZaOWVNMnlyd0hhaENkTDYxRTBZUVg4ZVJpeVVsTWZGblZJWklS?=
 =?utf-8?B?Z1RrbEhqYUw5U0pDam5wcUU2MzVTZFE0ZDhuK3pSWVlaVnRIVS9DaEljNlJt?=
 =?utf-8?Q?sm954ob3zKDg9jozF2bK4sjSgEycKEfj?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5819.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?VDY0YmFrNWduQnAxT3ZISXRoa2NNbStMVDZTNEtIdEo3Q1BpcEdVSWc3ZHNZ?=
 =?utf-8?B?Kzg1L0t4S2ZZNnpxUXY1b2FoeVBObDc0WVFUMFVTSXNyM0JWTGhaSzRPWitR?=
 =?utf-8?B?VGZIeDlWK2s3SGNqdFJ3ZXd5MWN2VnhjMWF4YWJKVTIraWY4YXlrb3crSGsv?=
 =?utf-8?B?NEF5VGRMM29La05WK0xkalJLOWNTeWZrbjE5eDZUcXpuWFNxQ1QrK0FDY3JK?=
 =?utf-8?B?UHpteVNGZFJXMjFyMStMdnRqTXdrMWttRmhPRlFVN1ArSU9OdG9GVXpOakJk?=
 =?utf-8?B?L3hmcGJuZ1VBeS90bjE3YkxtYUo5aGRPaEdSSFRoRXBzUFNmKzJNN3NVUlFl?=
 =?utf-8?B?V0ZDS2E2cVY2dU1rZUZNMllqYVNlMGFnNytjYXBRQS9YMXI4YXB6ZEdlem1B?=
 =?utf-8?B?UmdIUlZEbnhLSTVSeXZhemJzUHkwYTFLWmM2elpVTVJ5WVBobW1CQnk0Y1Mw?=
 =?utf-8?B?ekIyU3Y2R25nc3p0WTFsMHI2Yk1CNEh6aXBuWFpSZkVqVHdCTDVhQlpEUjNV?=
 =?utf-8?B?RDNiVDd6OTZhVHcvaTlqS05XQU1Oc2xXRjNLMUtKcC9aMW9kYTNVV1BqcXZu?=
 =?utf-8?B?Y01GRFRDWHh6TlZBOUpWOGNhOWt5eFg3U2puRCtVVWx0M2lpek5pOXY2OGtH?=
 =?utf-8?B?M3NXbDk5eE5UUlpwdzJ5dlVHQTJ5MnVNN3ZFd0JGeDBiL25zQXVNVGVyeFlq?=
 =?utf-8?B?UTlqR3RaU3EweDFWRTZwRi9vMkt4NmprUWdzTUowWTU3bitSdUdOVFJUVmds?=
 =?utf-8?B?ZFBzRGVpS1ZLZHVmU0dLRzA3NWgzQVpFekxxNTM5RGdyN0l4azhjNjE5YWgr?=
 =?utf-8?B?NHdhNnFKU1FXMjh3MmhHRksyMXVvYjBkOTRZWTBKTEdTUU1LSHBDdlVDNjUx?=
 =?utf-8?B?TXhPVDRwL2VIb08zdzhtV2NYSE5TcTJDK1dDMVNzT0dnUXFwV0VIUC9QUG9I?=
 =?utf-8?B?ajJlWkt5ZjY3NUVLYTNjUDVMdnlQTFBobHc4SDkyTzkyZmFwcTNqTW5mR0lx?=
 =?utf-8?B?YndYVmZIVnJwUXE0VzR5R1BUUXBIdnA5Z2liOVllZ3RJQzU3ZkhxdDBSQy93?=
 =?utf-8?B?SmRzaklrOFMzSkxDd01qZXo3WmZyZU1TTE96TktZenBxNFZJME5hWTYvTGxP?=
 =?utf-8?B?VHRsNmduWFdpR21MSEh4WnhQN0U0Tk1kb2xpUXhlcE4zdUgxTyt6alM3QWJo?=
 =?utf-8?B?S3IwWGJqVVBwSzdzd1hQdFJab3RmcGhPcWU2M3o1QVd2QUZBR1htcWV6TVcz?=
 =?utf-8?B?eG9OUFhuSEU1Rk05bVBpZ1FNM1BuR2xHaXoxVmVVRGQ4SVZQa083UWRaM2sy?=
 =?utf-8?B?V2FVc0hENmxQTmZ4aU9xQ0RGZ1lTd1puT2VnT2pRMk1OWFFON3lMb3ExVHY5?=
 =?utf-8?B?bHVPYWx2VDFyL0RYejVhQUlDRU0xOTAyQ09FK0ZrMHZRZXd3NGNxdkpuL3dC?=
 =?utf-8?B?UHZxdzROdmd6NVl1b0xteUtmY0tZZnhteUJVc3lGck5IY0M3SFliNDZMMVFI?=
 =?utf-8?B?K2RLSGVTYUV1eC81SytacW55bWNZTmx2WC9jUkUzUGdtSkF5YlFjUStKa0lk?=
 =?utf-8?B?L2JNMmNZMm9kaklUVEl0YzcxRDBSVHFtMzdldlNUS3I5Ris1Z2RWOXJLWWhT?=
 =?utf-8?B?bDB6SWxpbXB3cTRtSms2Y1dTcE5SZG00UmNtMGtjNC9YL1VaaGcvc0IrWlhO?=
 =?utf-8?B?MFFKUkRLdHNGWlFQWXJPZGtpY2x6amFFSE9OYnkvamZ1YUgrTkxwcHlNbi9M?=
 =?utf-8?B?TVB2M1pWZjc1MEFwWnJFTndCbnZQOTQ3b2VwVy9Eb3drcnNwcUsxcHhsL3Mx?=
 =?utf-8?B?Z25nYUYvNEdxMkQ3ZUZYSzdZOXFLK1ByeHQzS1EzNWkyb01qUEZqUmZjZUFG?=
 =?utf-8?B?ZHBiRXBZd2hYcnpBOFE4anFqSUNTclFGdmR3a29PdWVRZGZXZzFhMkF0bVVJ?=
 =?utf-8?B?MEtpSXRCdys4REVWdGQwMnhmMWYvSEFaTDFRWkZTUGtkMUUxVTFSWXNmaVFj?=
 =?utf-8?B?V2swNTRkbzF5bCs2dW1ycmpHb2dReDM5d2Jyam56dmNnWEFGbGQ3MUhMMnFS?=
 =?utf-8?B?YjNqa1V3V1lFR1hRTGdjVmdxcUpIb05sRlBvZTJSUTFqc0doOC91U0p3UzhP?=
 =?utf-8?B?SnduZ1phN3BuTzhqb0lYaStQM1RIZ1hGOWlCalBXc3lCSEJTeXVwVkswZGRE?=
 =?utf-8?B?ZXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <FC88BA158F6AD943ABE27E60D19C54CC@namprd15.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b58c3a7-f1a6-4254-5ba9-08dd6e2c7e81
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Mar 2025 19:12:33.6372
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ITkbhtkY0N19rKLRU61d5ia8ZS22a7k715l/UXWEo1VTvvqzT/qgSFZdlJuGkmE0xwuC5zJnQ2fuKg6st6g2SA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPF3B54D8C0D
X-Proofpoint-GUID: TVUrIMFDNPjJE3KLJUAkdKtZFvhrjaWk
X-Proofpoint-ORIG-GUID: VMmDteK6nHsmJDVvSx0Rhi3q7loj6-l1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-28_09,2025-03-27_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 bulkscore=0
 priorityscore=1501 adultscore=0 suspectscore=0 phishscore=0 spamscore=0
 lowpriorityscore=0 mlxscore=0 clxscore=1015 mlxlogscore=999
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2503280129

SGVsbG8sDQoNCkkgaGl0IHRoaXMgaXNzdWUgb25seSBvbmNlIG9uIDYuMTQga2VybmVsLiBJIHRy
aWVkIHRvIHJlcHJvZHVjZSBpdCBtdWx0aXBsZQ0KdGltZXMgYnV0IHdpdGggbm8gc3VjY2Vzcy4g
QW55IGlkZWEgaG93IEkgY2FuIHJlcHJvZHVjZSB0aGUgaXNzdWUgaW4gc3RhYmxlIHdheT8NCg0K
TWFyIDI0IDE3OjM5OjE1IGNlcGgtdGVzdGluZy0wMDAxIGtlcm5lbDogWyAgMjY0Ljc0MDgxNV0g
cnVuIGZzdGVzdHMgY2VwaC8wMDEgYXQNCjIwMjUtMDMtMjQgMTc6Mzk6MTUNCk1hciAyNCAxNzoz
OToxNSBjZXBoLXRlc3RpbmctMDAwMSBzeXN0ZW1kWzFdOiBTdGFydGVkIC91c3IvYmluL2Jhc2gg
LWMgdGVzdCAtdw0KL3Byb2Mvc2VsZi9vb21fc2NvcmVfYWRqICYmIGVjaG8NCiAyNTAgPiAvcHJv
Yy9zZWxmL29vbV9zY29yZV9hZGo7IGV4ZWMgLi90ZXN0cy9jZXBoLzAwMS4NCg0KPHNraXBwZWQ+
DQoNCk1hciAyNCAxNzo0MDoyNyBjZXBoLXRlc3RpbmctMDAwMSBrZXJuZWw6IFsgIDMzNi4xNzk0
OTNdIGt3b3JrZXIvdTQ4OjY6IHBhZ2UNCmFsbG9jYXRpb24gZmFpbHVyZTogb3JkZXI6NSwgbW9k
ZToNCjB4NDBjNDAoR0ZQX05PRlN8X19HRlBfQ09NUCksIG5vZGVtYXNrPShudWxsKSxjcHVzZXQ9
LyxtZW1zX2FsbG93ZWQ9MA0KTWFyIDI0IDE3OjQwOjI3IGNlcGgtdGVzdGluZy0wMDAxIGtlcm5l
bDogWyAgMzM2LjE3OTUyNl0gQ1BVOiA3IFVJRDogMCBQSUQ6IDE0MDcNCkNvbW06IGt3b3JrZXIv
dTQ4OjYgTm90IHRhaW50ZQ0KZCA2LjE0LjArICM5DQpNYXIgMjQgMTc6NDA6MjcgY2VwaC10ZXN0
aW5nLTAwMDEga2VybmVsOiBbICAzMzYuMTc5NTMxXSBIYXJkd2FyZSBuYW1lOiBRRU1VDQpTdGFu
ZGFyZCBQQyAoaTQ0MEZYICsgUElJWCwgMTk5NiksDQogQklPUyByZWwtMS4xNi4zLTAtZ2E2ZWQ2
YjcwMWYwYS1wcmVidWlsdC5xZW11Lm9yZyAwNC8wMS8yMDE0DQpNYXIgMjQgMTc6NDA6MjcgY2Vw
aC10ZXN0aW5nLTAwMDEga2VybmVsOiBbICAzMzYuMTc5NTM1XSBXb3JrcXVldWU6IHdyaXRlYmFj
aw0Kd2Jfd29ya2ZuIChmbHVzaC1jZXBoLTIpDQpNYXIgMjQgMTc6NDA6MjcgY2VwaC10ZXN0aW5n
LTAwMDEga2VybmVsOiBbICAzMzYuMTc5NTQ3XSBDYWxsIFRyYWNlOg0KTWFyIDI0IDE3OjQwOjI3
IGNlcGgtdGVzdGluZy0wMDAxIGtlcm5lbDogWyAgMzM2LjE3OTU1MV0gIDxUQVNLPg0KTWFyIDI0
IDE3OjQwOjI3IGNlcGgtdGVzdGluZy0wMDAxIGtlcm5lbDogWyAgMzM2LjE3OTU1NV0gDQpkdW1w
X3N0YWNrX2x2bCsweDc2LzB4YTANCk1hciAyNCAxNzo0MDoyNyBjZXBoLXRlc3RpbmctMDAwMSBr
ZXJuZWw6IFsgIDMzNi4xNzk1NjVdICBkdW1wX3N0YWNrKzB4MTAvMHgyMA0KTWFyIDI0IDE3OjQw
OjI3IGNlcGgtdGVzdGluZy0wMDAxIGtlcm5lbDogWyAgMzM2LjE3OTU2OF0gIHdhcm5fYWxsb2Mr
MHgyMmEvMHgzNzANCk1hciAyNCAxNzo0MDoyNyBjZXBoLXRlc3RpbmctMDAwMSBrZXJuZWw6IFsg
IDMzNi4xNzk1NzRdICA/DQpfX3BmeF93YXJuX2FsbG9jKzB4MTAvMHgxMA0KTWFyIDI0IDE3OjQw
OjI3IGNlcGgtdGVzdGluZy0wMDAxIGtlcm5lbDogWyAgMzM2LjE3OTU3OF0gID8NCnBzaV90YXNr
X2NoYW5nZSsweDFiNi8weDIzMA0KTWFyIDI0IDE3OjQwOjI3IGNlcGgtdGVzdGluZy0wMDAxIGtl
cm5lbDogWyAgMzM2LjE3OTU4Nl0gID8NCl9fcGZ4X19fYWxsb2NfcGFnZXNfZGlyZWN0X2NvbXBh
Y3QrMHgxMC8weDEwDQpNYXIgMjQgMTc6NDA6MjcgY2VwaC10ZXN0aW5nLTAwMDEga2VybmVsOiBb
ICAzMzYuMTc5NTg5XSAgPw0KcHNpX21lbXN0YWxsX2xlYXZlKzB4MTVjLzB4MWEwDQpNYXIgMjQg
MTc6NDA6MjcgY2VwaC10ZXN0aW5nLTAwMDEga2VybmVsOiBbICAzMzYuMTc5NTk0XSAgPw0KX19w
ZnhfcHNpX21lbXN0YWxsX2xlYXZlKzB4MTAvMHgxMA0KTWFyIDI0IDE3OjQwOjI3IGNlcGgtdGVz
dGluZy0wMDAxIGtlcm5lbDogWyAgMzM2LjE3OTYwMl0gDQpfX2FsbG9jX2Zyb3plbl9wYWdlc19u
b3Byb2YrMHhmMjcvMHgyMjMwDQpNYXIgMjQgMTc6NDA6MjcgY2VwaC10ZXN0aW5nLTAwMDEga2Vy
bmVsOiBbICAzMzYuMTc5NjA1XSAgPw0KbXV0ZXhfdW5sb2NrKzB4ODAvMHhlMA0KTWFyIDI0IDE3
OjQwOjI3IGNlcGgtdGVzdGluZy0wMDAxIGtlcm5lbDogWyAgMzM2LjE3OTYxM10gID8NCl9fa2Fz
YW5fY2hlY2tfd3JpdGUrMHgxNC8weDMwDQpNYXIgMjQgMTc6NDA6MjcgY2VwaC10ZXN0aW5nLTAw
MDEga2VybmVsOiBbICAzMzYuMTc5NjIwXSAgPw0KX19wZnhfX19hbGxvY19mcm96ZW5fcGFnZXNf
bm9wcm9mKzB4MTAvMHgxMA0KTWFyIDI0IDE3OjQwOjI3IGNlcGgtdGVzdGluZy0wMDAxIGtlcm5l
bDogWyAgMzM2LjE3OTYyNF0gID8NCnNlbmRfcmVxdWVzdCsweDFkM2QvMHg0ODcwDQpNYXIgMjQg
MTc6NDA6MjcgY2VwaC10ZXN0aW5nLTAwMDEga2VybmVsOiBbICAzMzYuMTc5NjMxXSAgPw0KeGFz
X2ZpbmRfbWFya2VkKzB4MzUzLzB4ZjQwDQpNYXIgMjQgMTc6NDA6MjcgY2VwaC10ZXN0aW5nLTAw
MDEga2VybmVsOiBbICAzMzYuMTc5NjM4XSANCl9fYWxsb2NfcGFnZXNfbm9wcm9mKzB4MTIvMHg4
MA0KTWFyIDI0IDE3OjQwOjI3IGNlcGgtdGVzdGluZy0wMDAxIGtlcm5lbDogWyAgMzM2LjE3OTY0
MV0gDQpfX19rbWFsbG9jX2xhcmdlX25vZGUrMHg5OS8weDE2MA0KTWFyIDI0IDE3OjQwOjI3IGNl
cGgtdGVzdGluZy0wMDAxIGtlcm5lbDogWyAgMzM2LjE3OTY0N10gID8NCl9fY2VwaF9hbGxvY2F0
ZV9wYWdlX2FycmF5KzB4MjcvMHgxMjANCk1hciAyNCAxNzo0MDoyNyBjZXBoLXRlc3RpbmctMDAw
MSBrZXJuZWw6IFsgIDMzNi4xNzk2NTVdIA0KX19rbWFsbG9jX2xhcmdlX25vZGVfbm9wcm9mKzB4
MjEvMHhjMA0KTWFyIDI0IDE3OjQwOjI3IGNlcGgtdGVzdGluZy0wMDAxIGtlcm5lbDogWyAgMzM2
LjE3OTY2MV0gDQpfX2ttYWxsb2Nfbm9wcm9mKzB4NDEyLzB4NWUwDQpNYXIgMjQgMTc6NDA6Mjcg
Y2VwaC10ZXN0aW5nLTAwMDEga2VybmVsOiBbICAzMzYuMTc5NjY3XSANCl9fY2VwaF9hbGxvY2F0
ZV9wYWdlX2FycmF5KzB4MjcvMHgxMjANCk1hciAyNCAxNzo0MDoyNyBjZXBoLXRlc3RpbmctMDAw
MSBrZXJuZWw6IFsgIDMzNi4xNzk2NzFdICA/DQpfX2NlcGhfYWxsb2NhdGVfcGFnZV9hcnJheSsw
eDI3LzB4MTIwDQpNYXIgMjQgMTc6NDA6MjcgY2VwaC10ZXN0aW5nLTAwMDEga2VybmVsOiBbICAz
MzYuMTc5Njc2XSANCmNlcGhfd3JpdGVwYWdlc19zdGFydCsweDI3M2YvMHg1NmMwDQpNYXIgMjQg
MTc6NDA6MjcgY2VwaC10ZXN0aW5nLTAwMDEga2VybmVsOiBbICAzMzYuMTc5Njg1XSAgPw0KX19w
ZnhfY2VwaF93cml0ZXBhZ2VzX3N0YXJ0KzB4MTAvMHgxMA0KTWFyIDI0IDE3OjQwOjI3IGNlcGgt
dGVzdGluZy0wMDAxIGtlcm5lbDogWyAgMzM2LjE3OTY5MF0gID8NCmthc2FuX3NhdmVfc3RhY2sr
MHgzYy8weDYwDQpNYXIgMjQgMTc6NDA6MjcgY2VwaC10ZXN0aW5nLTAwMDEga2VybmVsOiBbICAz
MzYuMTc5Njk2XSAgPw0Ka2FzYW5fc2F2ZV90cmFjaysweDE0LzB4NDANCk1hciAyNCAxNzo0MDoy
NyBjZXBoLXRlc3RpbmctMDAwMSBrZXJuZWw6IFsgIDMzNi4xNzk3MDFdICA/DQprYXNhbl9zYXZl
X2ZyZWVfaW5mbysweDNiLzB4NjANCk1hciAyNCAxNzo0MDoyNyBjZXBoLXRlc3RpbmctMDAwMSBr
ZXJuZWw6IFsgIDMzNi4xNzk3MDRdICA/DQpfX2thc2FuX3NsYWJfZnJlZSsweDU0LzB4ODANCk1h
ciAyNCAxNzo0MDoyNyBjZXBoLXRlc3RpbmctMDAwMSBrZXJuZWw6IFsgIDMzNi4xNzk3MDldICA/
DQpleHQ0X2VzX2ZyZWVfZXh0ZW50KzB4MWZiLzB4NGIwDQpNYXIgMjQgMTc6NDA6MjcgY2VwaC10
ZXN0aW5nLTAwMDEga2VybmVsOiBbICAzMzYuMTc5NzE3XSAgPw0KX19lc19yZW1vdmVfZXh0ZW50
KzB4MmMwLzB4MTY0MA0KTWFyIDI0IDE3OjQwOjI3IGNlcGgtdGVzdGluZy0wMDAxIGtlcm5lbDog
WyAgMzM2LjE3OTcyMV0gID8NCmV4dDRfZXNfaW5zZXJ0X2V4dGVudCsweDQwYy8weGQyMA0KTWFy
IDI0IDE3OjQwOjI3IGNlcGgtdGVzdGluZy0wMDAxIGtlcm5lbDogWyAgMzM2LjE3OTczMF0gID8N
Cl9fa2FzYW5fY2hlY2tfd3JpdGUrMHgxNC8weDMwDQpNYXIgMjQgMTc6NDA6MjcgY2VwaC10ZXN0
aW5nLTAwMDEga2VybmVsOiBbICAzMzYuMTc5NzM0XSAgPw0KX3Jhd19zcGluX2xvY2srMHg4Mi8w
eGYwDQpNYXIgMjQgMTc6NDA6MjcgY2VwaC10ZXN0aW5nLTAwMDEga2VybmVsOiBbICAzMzYuMTc5
NzQwXSANCmRvX3dyaXRlcGFnZXMrMHgxN2IvMHg3MjANCk1hciAyNCAxNzo0MDoyNyBjZXBoLXRl
c3RpbmctMDAwMSBrZXJuZWw6IFsgIDMzNi4xNzk3NDddICA/DQpfX3BmeF9ibGtfbXFfZmx1c2hf
cGx1Z19saXN0KzB4MTAvMHgxMA0KTWFyIDI0IDE3OjQwOjI3IGNlcGgtdGVzdGluZy0wMDAxIGtl
cm5lbDogWyAgMzM2LjE3OTc1NV0gID8NCl9fcGZ4X2RvX3dyaXRlcGFnZXMrMHgxMC8weDEwDQpN
YXIgMjQgMTc6NDA6MjcgY2VwaC10ZXN0aW5nLTAwMDEga2VybmVsOiBbICAzMzYuMTc5NzU4XSAg
Pw0KX19wZnhfY2VwaF93cml0ZV9pbm9kZSsweDEwLzB4MTANCk1hciAyNCAxNzo0MDoyNyBjZXBo
LXRlc3RpbmctMDAwMSBrZXJuZWw6IFsgIDMzNi4xNzk3NjRdICA/DQpfX2thc2FuX2NoZWNrX3dy
aXRlKzB4MTQvMHgzMA0KTWFyIDI0IDE3OjQwOjI3IGNlcGgtdGVzdGluZy0wMDAxIGtlcm5lbDog
WyAgMzM2LjE3OTc2N10gID8NCl9yYXdfc3Bpbl9sb2NrKzB4ODIvMHhmMA0KTWFyIDI0IDE3OjQw
OjI3IGNlcGgtdGVzdGluZy0wMDAxIGtlcm5lbDogWyAgMzM2LjE3OTc3MV0gID8NCl9fcGZ4X19y
YXdfc3Bpbl9sb2NrKzB4MTAvMHgxMA0KTWFyIDI0IDE3OjQwOjI3IGNlcGgtdGVzdGluZy0wMDAx
IGtlcm5lbDogWyAgMzM2LjE3OTc3NV0gID8NCl9fcGZ4X19yYXdfc3Bpbl9sb2NrKzB4MTAvMHgx
MA0KTWFyIDI0IDE3OjQwOjI3IGNlcGgtdGVzdGluZy0wMDAxIGtlcm5lbDogWyAgMzM2LjE3OTc3
OV0gDQpfX3dyaXRlYmFja19zaW5nbGVfaW5vZGUrMHhhYS8weDg5MA0KTWFyIDI0IDE3OjQwOjI3
IGNlcGgtdGVzdGluZy0wMDAxIGtlcm5lbDogWyAgMzM2LjE3OTc4NF0gDQp3cml0ZWJhY2tfc2Jf
aW5vZGVzKzB4NTQ3LzB4ZTkwDQpNYXIgMjQgMTc6NDA6MjcgY2VwaC10ZXN0aW5nLTAwMDEga2Vy
bmVsOiBbICAzMzYuMTc5Nzg5XSAgPw0KX19wZnhfd3JpdGViYWNrX3NiX2lub2RlcysweDEwLzB4
MTANCk1hciAyNCAxNzo0MDoyNyBjZXBoLXRlc3RpbmctMDAwMSBrZXJuZWw6IFsgIDMzNi4xNzk3
OTNdICA/DQpfX3BmeF9kb21haW5fZGlydHlfYXZhaWwrMHgxMC8weDEwDQpNYXIgMjQgMTc6NDA6
MjcgY2VwaC10ZXN0aW5nLTAwMDEga2VybmVsOiBbICAzMzYuMTc5ODAyXSAgPw0KX19wZnhfbW92
ZV9leHBpcmVkX2lub2RlcysweDEwLzB4MTANCk1hciAyNCAxNzo0MDoyNyBjZXBoLXRlc3Rpbmct
MDAwMSBrZXJuZWw6IFsgIDMzNi4xNzk4MDldIA0KX193cml0ZWJhY2tfaW5vZGVzX3diKzB4YmEv
MHgyMTANCk1hciAyNCAxNzo0MDoyNyBjZXBoLXRlc3RpbmctMDAwMSBrZXJuZWw6IFsgIDMzNi4x
Nzk4MTRdIA0Kd2Jfd3JpdGViYWNrKzB4NGVlLzB4NmMwDQpNYXIgMjQgMTc6NDA6MjcgY2VwaC10
ZXN0aW5nLTAwMDEga2VybmVsOiBbICAzMzYuMTc5ODE4XSAgPw0KX19wZnhfd2Jfd3JpdGViYWNr
KzB4MTAvMHgxMA0KTWFyIDI0IDE3OjQwOjI3IGNlcGgtdGVzdGluZy0wMDAxIGtlcm5lbDogWyAg
MzM2LjE3OTgyM10gID8NCl9fcGZ4X19yYXdfc3Bpbl9sb2NrX2lycSsweDEwLzB4MTANCk1hciAy
NCAxNzo0MDoyNyBjZXBoLXRlc3RpbmctMDAwMSBrZXJuZWw6IFsgIDMzNi4xNzk4MjhdICB3Yl93
b3JrZm4rMHg1YWYvMHhiZjANCk1hciAyNCAxNzo0MDoyNyBjZXBoLXRlc3RpbmctMDAwMSBrZXJu
ZWw6IFsgIDMzNi4xNzk4MzNdICA/DQpfX3BmeF93Yl93b3JrZm4rMHgxMC8weDEwDQpNYXIgMjQg
MTc6NDA6MjcgY2VwaC10ZXN0aW5nLTAwMDEga2VybmVsOiBbICAzMzYuMTc5ODM3XSAgPw0KX19w
ZnhfX19zY2hlZHVsZSsweDEwLzB4MTANCk1hciAyNCAxNzo0MDoyNyBjZXBoLXRlc3RpbmctMDAw
MSBrZXJuZWw6IFsgIDMzNi4xNzk4NDFdICA/DQpwd3FfZGVjX25yX2luX2ZsaWdodCsweDIyNy8w
eGJhMA0KTWFyIDI0IDE3OjQwOjI3IGNlcGgtdGVzdGluZy0wMDAxIGtlcm5lbDogWyAgMzM2LjE3
OTg0Nl0gID8NCmtpY2tfcG9vbCsweDE4NC8weDY1MA0KTWFyIDI0IDE3OjQwOjI3IGNlcGgtdGVz
dGluZy0wMDAxIGtlcm5lbDogWyAgMzM2LjE3OTg1MV0gDQpwcm9jZXNzX29uZV93b3JrKzB4NWY3
LzB4ZmEwDQpNYXIgMjQgMTc6NDA6MjcgY2VwaC10ZXN0aW5nLTAwMDEga2VybmVsOiBbICAzMzYu
MTc5ODU0XSAgPw0KX19rYXNhbl9jaGVja193cml0ZSsweDE0LzB4MzANCk1hciAyNCAxNzo0MDoy
NyBjZXBoLXRlc3RpbmctMDAwMSBrZXJuZWw6IFsgIDMzNi4xNzk4NjBdIA0Kd29ya2VyX3RocmVh
ZCsweDc3OS8weDEyMDANCk1hciAyNCAxNzo0MDoyNyBjZXBoLXRlc3RpbmctMDAwMSBrZXJuZWw6
IFsgIDMzNi4xNzk4NjNdICA/DQpfX3BmeF9fcmF3X3NwaW5fbG9ja19pcnFzYXZlKzB4MTAvMHgx
MA0KTWFyIDI0IDE3OjQwOjI3IGNlcGgtdGVzdGluZy0wMDAxIGtlcm5lbDogWyAgMzM2LjE3OTg2
OF0gID8NCl9fcGZ4X3dvcmtlcl90aHJlYWQrMHgxMC8weDEwDQpNYXIgMjQgMTc6NDA6MjcgY2Vw
aC10ZXN0aW5nLTAwMDEga2VybmVsOiBbICAzMzYuMTc5ODcxXSAga3RocmVhZCsweDM5NS8weDg5
MA0KTWFyIDI0IDE3OjQwOjI3IGNlcGgtdGVzdGluZy0wMDAxIGtlcm5lbDogWyAgMzM2LjE3OTg3
N10gID8NCl9fcGZ4X2t0aHJlYWQrMHgxMC8weDEwDQpNYXIgMjQgMTc6NDA6MjcgY2VwaC10ZXN0
aW5nLTAwMDEga2VybmVsOiBbICAzMzYuMTc5ODgxXSAgPw0KX19rYXNhbl9jaGVja193cml0ZSsw
eDE0LzB4MzANCk1hciAyNCAxNzo0MDoyNyBjZXBoLXRlc3RpbmctMDAwMSBrZXJuZWw6IFsgIDMz
Ni4xNzk4ODRdICA/DQpyZWNhbGNfc2lncGVuZGluZysweDE0MS8weDFlMA0KTWFyIDI0IDE3OjQw
OjI3IGNlcGgtdGVzdGluZy0wMDAxIGtlcm5lbDogWyAgMzM2LjE3OTg4OF0gID8NCl9yYXdfc3Bp
bl91bmxvY2tfaXJxKzB4ZS8weDUwDQpNYXIgMjQgMTc6NDA6MjcgY2VwaC10ZXN0aW5nLTAwMDEg
a2VybmVsOiBbICAzMzYuMTc5ODkyXSAgPw0KX19wZnhfa3RocmVhZCsweDEwLzB4MTANCk1hciAy
NCAxNzo0MDoyNyBjZXBoLXRlc3RpbmctMDAwMSBrZXJuZWw6IFsgIDMzNi4xNzk4OTddIA0KcmV0
X2Zyb21fZm9yaysweDQzLzB4OTANCk1hciAyNCAxNzo0MDoyNyBjZXBoLXRlc3RpbmctMDAwMSBr
ZXJuZWw6IFsgIDMzNi4xNzk5MDFdICA/DQpfX3BmeF9rdGhyZWFkKzB4MTAvMHgxMA0KTWFyIDI0
IDE3OjQwOjI3IGNlcGgtdGVzdGluZy0wMDAxIGtlcm5lbDogWyAgMzM2LjE3OTkwNV0gDQpyZXRf
ZnJvbV9mb3JrX2FzbSsweDFhLzB4MzANCk1hciAyNCAxNzo0MDoyNyBjZXBoLXRlc3RpbmctMDAw
MSBrZXJuZWw6IFsgIDMzNi4xNzk5MTJdICA8L1RBU0s+DQpNYXIgMjQgMTc6NDA6MjcgY2VwaC10
ZXN0aW5nLTAwMDEga2VybmVsOiBbICAzMzYuMTc5OTE0XSBNZW0tSW5mbzoNCk1hciAyNCAxNzo0
MDoyNyBjZXBoLXRlc3RpbmctMDAwMSBrZXJuZWw6IFsgIDMzNi4xNzk5ODNdIGFjdGl2ZV9hbm9u
Ojg5OTYyMw0KaW5hY3RpdmVfYW5vbjo3MzExNyBpc29sYXRlZF9hbm9uOjANCk1hciAyNCAxNzo0
MDoyNyBjZXBoLXRlc3RpbmctMDAwMSBrZXJuZWw6IFsgIDMzNi4xNzk5ODNdICBhY3RpdmVfZmls
ZTo3OTY4Ng0KaW5hY3RpdmVfZmlsZTo0Mjk3NTYgaXNvbGF0ZWRfZmlsZTowDQpNYXIgMjQgMTc6
NDA6MjcgY2VwaC10ZXN0aW5nLTAwMDEga2VybmVsOiBbICAzMzYuMTc5OTgzXSAgdW5ldmljdGFi
bGU6MTE1Mg0KZGlydHk6NTI1Mjcgd3JpdGViYWNrOjE2NTQ3DQpNYXIgMjQgMTc6NDA6MjcgY2Vw
aC10ZXN0aW5nLTAwMDEga2VybmVsOiBbICAzMzYuMTc5OTgzXSAgc2xhYl9yZWNsYWltYWJsZToy
MzMwMw0Kc2xhYl91bnJlY2xhaW1hYmxlOjE2NDY4Nw0KTWFyIDI0IDE3OjQwOjI3IGNlcGgtdGVz
dGluZy0wMDAxIGtlcm5lbDogWyAgMzM2LjE3OTk4M10gIG1hcHBlZDo5NjEyNQ0Kc2htZW06NzQ3
MCBwYWdldGFibGVzOjYzMzcNCk1hciAyNCAxNzo0MDoyNyBjZXBoLXRlc3RpbmctMDAwMSBrZXJu
ZWw6IFsgIDMzNi4xNzk5ODNdICBzZWNfcGFnZXRhYmxlczowDQpib3VuY2U6MA0KTWFyIDI0IDE3
OjQwOjI3IGNlcGgtdGVzdGluZy0wMDAxIGtlcm5lbDogWyAgMzM2LjE3OTk4M10gDQprZXJuZWxf
bWlzY19yZWNsYWltYWJsZTowDQpNYXIgMjQgMTc6NDA6MjcgY2VwaC10ZXN0aW5nLTAwMDEga2Vy
bmVsOiBbICAzMzYuMTc5OTgzXSAgZnJlZTo0NDI4OA0KZnJlZV9wY3A6NDQxIGZyZWVfY21hOjAN
Ck1hciAyNCAxNzo0MDoyNyBjZXBoLXRlc3RpbmctMDAwMSBrZXJuZWw6IFsgIDMzNi4xNzk5OTRd
IE5vZGUgMA0KYWN0aXZlX2Fub246MzU5ODUwMGtCIGluYWN0aXZlX2Fub246MjkyNDY4a0IgYWN0
aXZlX2ZpbGU6MzE4NzQ0a0INCmluYWN0aXZlX2ZpbGU6MTcxODk3MmtCIHVuZXZpY3RhYmxlOjQ2
MDhrQiBpc29sYXRlZChhbm9uKTowa0IgaXNvbGF0ZWQoZmlsZSk6MGtCDQptYXBwZWQ6Mzg0NTAw
a0IgZGlydHk6MjEwMjYwa0Igd3JpdGViYWNrOjY2MTg4a0Igc2htZW06Mjk4ODBrQiBzaG1lbV90
aHA6MGtCDQpzaG1lbV9wbWRtYXBwZWQ6MGtCIGFub25fdGhwOjBrQiB3cml0ZWJhY2tfdG1wOjBr
QiBrZXJuZWxfc3RhY2s6MzE0NTZrQg0KcGFnZXRhYmxlczoyNTM0OGtCIHNlY19wYWdldGFibGVz
OjBrQiBhbGxfdW5yZWNsYWltYWJsZT8gbm8NCk1hciAyNCAxNzo0MDoyNyBjZXBoLXRlc3Rpbmct
MDAwMSBrZXJuZWw6IFsgIDMzNi4xODAwMDVdIE5vZGUgMCBETUEgZnJlZToxNDI3MmtCDQpib29z
dDowa0IgbWluOjE0OGtCIGxvdzoxODRrQiBoaWdoOjIyMGtCIHJlc2VydmVkX2hpZ2hhdG9taWM6
MEtCIGFjdGl2ZV9hbm9uOjBrQg0KaW5hY3RpdmVfYW5vbjowa0IgYWN0aXZlX2ZpbGU6MGtCIGlu
YWN0aXZlX2ZpbGU6MGtCIHVuZXZpY3RhYmxlOjBrQg0Kd3JpdGVwZW5kaW5nOjBrQiBwcmVzZW50
OjE1OTkya0IgbWFuYWdlZDoxNTM2MGtCIG1sb2NrZWQ6MGtCIGJvdW5jZTowa0INCmZyZWVfcGNw
OjBrQiBsb2NhbF9wY3A6MGtCIGZyZWVfY21hOjBrQg0KTWFyIDI0IDE3OjQwOjI3IGNlcGgtdGVz
dGluZy0wMDAxIGtlcm5lbDogWyAgMzM2LjE4MDAyMF0gbG93bWVtX3Jlc2VydmVbXTogMA0KMjk5
MSA2ODEwIDY4MTAgNjgxMA0KTWFyIDI0IDE3OjQwOjI3IGNlcGgtdGVzdGluZy0wMDAxIGtlcm5l
bDogWyAgMzM2LjE4MDAzMl0gTm9kZSAwIERNQTMyDQpmcmVlOjYzMjYwa0IgYm9vc3Q6MGtCIG1p
bjoyOTUyMGtCIGxvdzozNjkwMGtCIGhpZ2g6NDQyODBrQg0KcmVzZXJ2ZWRfaGlnaGF0b21pYzoz
MDcyMEtCIGFjdGl2ZV9hbm9uOjE1NTgwODBrQiBpbmFjdGl2ZV9hbm9uOjYyODhrQg0KYWN0aXZl
X2ZpbGU6Mjc3MTZrQiBpbmFjdGl2ZV9maWxlOjExMDcyMDRrQiB1bmV2aWN0YWJsZTowa0INCndy
aXRlcGVuZGluZzoxNjgyMzZrQiBwcmVzZW50OjMxMjkyMDRrQiBtYW5hZ2VkOjMwNjM2NjhrQiBt
bG9ja2VkOjBrQiBib3VuY2U6MGtCDQpmcmVlX3BjcDoxMTA3NmtCIGxvY2FsX3BjcDowa0IgZnJl
ZV9jbWE6MGtCDQpNYXIgMjQgMTc6NDA6MjcgY2VwaC10ZXN0aW5nLTAwMDEga2VybmVsOiBbICAz
MzYuMTgwMDQ3XSBsb3dtZW1fcmVzZXJ2ZVtdOiAwIDANCjM4MTggMzgxOCAzODE4DQpNYXIgMjQg
MTc6NDA6MjcgY2VwaC10ZXN0aW5nLTAwMDEga2VybmVsOiBbICAzMzYuMTgwMDU5XSBOb2RlIDAg
Tm9ybWFsDQpmcmVlOjk3NjYwa0IgYm9vc3Q6NTczNDRrQiBtaW46OTUyNTZrQiBsb3c6MTA0NzMy
a0IgaGlnaDoxMTQyMDhrQg0KcmVzZXJ2ZWRfaGlnaGF0b21pYzozMDcyMEtCIGFjdGl2ZV9hbm9u
OjIwNDAyMjRrQiBpbmFjdGl2ZV9hbm9uOjI4NjE4MGtCDQphY3RpdmVfZmlsZToyOTEwMjhrQiBp
bmFjdGl2ZV9maWxlOjYxMTE4MGtCIHVuZXZpY3RhYmxlOjQ2MDhrQg0Kd3JpdGVwZW5kaW5nOjEw
NzYyNGtCIHByZXNlbnQ6NTI0Mjg4MGtCIG1hbmFnZWQ6MzkxMDQ3NmtCIG1sb2NrZWQ6MGtCIGJv
dW5jZTowa0INCmZyZWVfcGNwOjc2MGtCIGxvY2FsX3BjcDowa0IgZnJlZV9jbWE6MGtCDQpNYXIg
MjQgMTc6NDA6MjcgY2VwaC10ZXN0aW5nLTAwMDEga2VybmVsOiBbICAzMzYuMTgwMDc2XSBsb3dt
ZW1fcmVzZXJ2ZVtdOiAwIDAgMA0KMCAwDQpNYXIgMjQgMTc6NDA6MjcgY2VwaC10ZXN0aW5nLTAw
MDEga2VybmVsOiBbICAzMzYuMTgwMDg3XSBOb2RlIDAgRE1BOiAwKjRrQiAwKjhrQg0KMCoxNmtC
IDAqMzJrQiAxKjY0a0IgKFUpIDEqMTI4a0IgKFUpIDEqMjU2a0IgKFUpIDEqNTEya0IgKFUpIDEq
MTAyNGtCIChVKQ0KMioyMDQ4a0IgKFVNKSAyKjQwOTZrQiAoTSkgPSAxNDI3MmtCDQpNYXIgMjQg
MTc6NDA6MjcgY2VwaC10ZXN0aW5nLTAwMDEga2VybmVsOiBbICAzMzYuMTgwMTI1XSBOb2RlIDAg
RE1BMzI6IDc1KjRrQg0KKFVNRUgpIDY5Nio4a0IgKFVFSCkgMjczKjE2a0IgKFVNRUgpIDI0MCoz
MmtCIChVTUVIKSAxMzcqNjRrQiAoVU1FSCkgNTMqMTI4a0INCihNRUgpIDIyKjI1NmtCIChVTUVI
KSAxMio1MTJrQiAoTUVIKSAzKjEwMjRrQiAoTSkgMTEqMjA0OGtCIChNSCkgMCo0MDk2a0IgPQ0K
NzA4NDRrQg0KTWFyIDI0IDE3OjQwOjI3IGNlcGgtdGVzdGluZy0wMDAxIGtlcm5lbDogWyAgMzM2
LjE4MDI5NF0gTm9kZSAwIE5vcm1hbDogMzAyNSo0a0INCihVTUVIKSAxNDgzKjhrQiAoVU1FSCkg
NTg2KjE2a0IgKFVNRUgpIDM3MyozMmtCIChVTUVIKSAxNjcqNjRrQiAoVU1FSCkgMjY1KjEyOGtC
DQooVU1FSCkgMTkqMjU2a0IgKFVNSCkgMSo1MTJrQiAoSCkgMyoxMDI0a0IgKEgpIDAqMjA0OGtC
IDAqNDA5NmtCID0gOTgzMzJrQg0KTWFyIDI0IDE3OjQwOjI3IGNlcGgtdGVzdGluZy0wMDAxIGtl
cm5lbDogWyAgMzM2LjE4MDM0MV0gTm9kZSAwDQpodWdlcGFnZXNfdG90YWw9MCBodWdlcGFnZXNf
ZnJlZT0wIGh1Z2VwYWdlc19zdXJwPTAgaHVnZXBhZ2VzX3NpemU9MTA0ODU3NmtCDQpNYXIgMjQg
MTc6NDA6MjcgY2VwaC10ZXN0aW5nLTAwMDEga2VybmVsOiBbICAzMzYuMTgwMzUxXSBOb2RlIDAN
Cmh1Z2VwYWdlc190b3RhbD0wIGh1Z2VwYWdlc19mcmVlPTAgaHVnZXBhZ2VzX3N1cnA9MCBodWdl
cGFnZXNfc2l6ZT0yMDQ4a0INCk1hciAyNCAxNzo0MDoyNyBjZXBoLXRlc3RpbmctMDAwMSBrZXJu
ZWw6IFsgIDMzNi4xODAzNTVdIDUxNjg4OCB0b3RhbCBwYWdlY2FjaGUNCnBhZ2VzDQpNYXIgMjQg
MTc6NDA6MjcgY2VwaC10ZXN0aW5nLTAwMDEga2VybmVsOiBbICAzMzYuMTgwMzU4XSAyMCBwYWdl
cyBpbiBzd2FwIGNhY2hlDQpNYXIgMjQgMTc6NDA6MjcgY2VwaC10ZXN0aW5nLTAwMDEga2VybmVs
OiBbICAzMzYuMTgwMzYwXSBGcmVlIHN3YXAgID0gMzk4MjU4OGtCDQpNYXIgMjQgMTc6NDA6Mjcg
Y2VwaC10ZXN0aW5nLTAwMDEga2VybmVsOiBbICAzMzYuMTgwMzYzXSBUb3RhbCBzd2FwID0gMzk5
MTU0OGtCDQpNYXIgMjQgMTc6NDA6MjcgY2VwaC10ZXN0aW5nLTAwMDEga2VybmVsOiBbICAzMzYu
MTgwMzY2XSAyMDk3MDE5IHBhZ2VzIFJBTQ0KTWFyIDI0IDE3OjQwOjI3IGNlcGgtdGVzdGluZy0w
MDAxIGtlcm5lbDogWyAgMzM2LjE4MDM2OF0gMCBwYWdlcw0KSGlnaE1lbS9Nb3ZhYmxlT25seQ0K
TWFyIDI0IDE3OjQwOjI3IGNlcGgtdGVzdGluZy0wMDAxIGtlcm5lbDogWyAgMzM2LjE4MDM3MV0g
MzQ5NjQzIHBhZ2VzIHJlc2VydmVkDQpNYXIgMjQgMTc6NDA6MjcgY2VwaC10ZXN0aW5nLTAwMDEg
a2VybmVsOiBbICAzMzYuMTgwMzczXSAwIHBhZ2VzIGh3cG9pc29uZWQNCg0KQXMgZmFyIGFzIEkg
Y2FuIHNlZSwgd2UgaGF2ZSBpc3N1ZSBoZXJlOg0KDQpzdGF0aWMgaW5saW5lDQp2b2lkIF9fY2Vw
aF9hbGxvY2F0ZV9wYWdlX2FycmF5KHN0cnVjdCBjZXBoX3dyaXRlYmFja19jdGwgKmNlcGhfd2Jj
LA0KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB1bnNpZ25lZCBpbnQgbWF4X3BhZ2Vz
KQ0Kew0KICAgICAgICBjZXBoX3diYy0+cGFnZXMgPSBrbWFsbG9jX2FycmF5KG1heF9wYWdlcywN
CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBzaXplb2YoKmNlcGhfd2Jj
LT5wYWdlcyksDQogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgR0ZQX05P
RlMpOw0KICAgICAgICAgICAgICAgICAgICAgICAgICBeXl5eXl5eXl5eXl5eDQpXZSB0cnkgdG8g
YWxsb2NhdGUgMTZLIHBvaW50ZXJzIG9yIDEyOEsgbWVtb3J5IGhlcmUuDQoNCiAgICAgICAgaWYg
KCFjZXBoX3diYy0+cGFnZXMpIHsNCiAgICAgICAgICAgICAgICBjZXBoX3diYy0+ZnJvbV9wb29s
ID0gdHJ1ZTsNCiAgICAgICAgICAgICAgICBjZXBoX3diYy0+cGFnZXMgPSBtZW1wb29sX2FsbG9j
KGNlcGhfd2JfcGFnZXZlY19wb29sLCBHRlBfTk9GUyk7DQogICAgICAgICAgICAgICAgQlVHX09O
KCFjZXBoX3diYy0+cGFnZXMpOw0KICAgICAgICB9DQp9DQoNCkkgYXNzdW1lIHRoYXQgaXQgd29y
a3MgaW4gbWFqb3JpdHkgb2YgY2FzZXMgaWYgbm8gc2lnbmlmaWNhbnQgbWVtb3J5DQpmcmFnbWVu
dGF0aW9uIGhhcHBlbnMuIFNob3VsZCB3ZSBjb25zaWRlciBrdm1hbGxvY19hcnJheSgpIGhlcmU/
IERvIHdlIG5lZWQgdG8NCmRvdWJsZSBjaGVjayBob3cgbWFueSBtYXhfcGFnZXMgd2Ugd291bGQg
bGlrZSB0byBhbGxvY2F0ZSBoZXJlPw0KDQpUaGFua3MsDQpTbGF2YS4NCg0K


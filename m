Return-Path: <linux-fsdevel+bounces-69464-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 92494C7BBAB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Nov 2025 22:15:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 0DBD135F5E9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Nov 2025 21:15:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 773CA306484;
	Fri, 21 Nov 2025 21:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="tTFqReQw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF51E2D9ECD
	for <linux-fsdevel@vger.kernel.org>; Fri, 21 Nov 2025 21:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763759719; cv=fail; b=pIZIJzLKnAHpXsREIeWYKDVthqR1wJNkin3CCkYx2jqXKzYBKhwxQnUcVnKGciskg1H3zqrUgOJ22A06PFgB7EMAySHwV9zpBqG9Cl90S98jG5pMDzHvfZBK0J2phngt5hlQ/PrxBGSntft+kj1sG+Hl65LiEKJTyTZfg+dtFxY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763759719; c=relaxed/simple;
	bh=nChM3Myd9qh5pDig0RdtUUV3m4RlsVO3Wxe92nl5njk=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=I1K/HEyYarrwQczF3tXcAHtuHc36woX5bWDDS+Fq4F78ux7LHT+XGLM6hnQ4AmppRvVsplQSKe0FzaLHURdmnyKtk+2GTXK+Q3WMyE3ZpfW/FLvfZoiyV9f3nAlfvEhel3QFFLlW5mIhMCDzYFkc6EAzNX+BJC6ylCwWKccucg4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=tTFqReQw; arc=fail smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5ALDnN9k027916
	for <linux-fsdevel@vger.kernel.org>; Fri, 21 Nov 2025 21:15:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pp1; bh=01QvPz/fqM6KPuvMq3lWbY/IWfEr1SLXTRLOcJM9H8Q=; b=tTFqReQw
	QnjqlmkH+wclcA2dX37Okm1JIuQe/Wmhvi7DamDp92MD0Bq/4AywoCNZRiKBCQyi
	1NCWGWAdb660TAqe/7j1JvQQDQVd2IEhxJnGq1pdjD6dkkthA20Nx8KDLYpVnEqT
	1tMr52aO3x6/CdqmnC2PNa0eMNlxROwLLEQue1DrH9HStscGIbk6fRPNeQOrX6Ev
	1gpNfFvnxnstR6LezZOcOCq2HgicFjPPQQwY5ty6/BNeTJgYGYBnlGfcvbjcVYw2
	dR9D9isBtFIBkk6eFiRlGySvPjEc/Jyzti3R5lDmlZRPjA8m7eY2LvzIBivp+yQM
	CtB08owyn/ojWQ==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4aejkaeb76-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-fsdevel@vger.kernel.org>; Fri, 21 Nov 2025 21:15:17 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5ALLBYvM014603
	for <linux-fsdevel@vger.kernel.org>; Fri, 21 Nov 2025 21:15:16 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4aejkaeb6t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Nov 2025 21:15:16 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5ALLFF3G022564;
	Fri, 21 Nov 2025 21:15:15 GMT
Received: from mw6pr02cu001.outbound.protection.outlook.com (mail-westus2azon11012023.outbound.protection.outlook.com [52.101.48.23])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4aejkaeb6n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Nov 2025 21:15:15 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xxLW2vO5bLZzh4LfbFVypwcDSsyppuoZvFq2HWgzYu+iaClx32Bxl+byqYNXiT44grFhcHve/+5WqjIaghv7rafJOJf7+wCf1sGTolomLsyjlXhZfoBdf2QGPm+pr5xX00S9eU5Ft3Yd+XW2qemc25kQXoNO3AF2ZRf0EwN9qeBy9X28maicAV/6W+D9vxBzBZQiZblw6GiM4S+GEEeKnawDtl6l3UzOYO3jDvZVZlFPwSENg4izgqbaXebMQ3jwFtAA4sOD/qA9HTb7iKp37txUxyiTSXyRjEit3aFCppe0tdVg2faMn44VCCS1Z3Xa1raJ0DWxRkQp2AJP29jSFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rdSLsG8za4LmwPSRVIV36rBuHee56DKgQ9HrAERf/f4=;
 b=Gzr2CmAffRCIflxmcMURTq9JUXVwYaD226FUHEUYlqaRx5s/FMBFYqjp0GNsNfWzn7fZKvCmiOTZlWPYvDD+cNZiGg8AVnvPq5F46GW2WcJdxLxGuwHJB2AM3X6GoX5+ijh2dy060QkF4bh8XZuZhJxcS6JGxC6yaYO0GluYXxT4ssZWAJCS5yNZYVco4/D+iCv9RFJ2HLSqsqV8urwJg1dd8LCgPo4gwaSjnHndI7oHDZbF7Ln9KBFu2kwdahF23Q2FweuQHh6+1PXcPJVXaL/b9cMHecGDYEfKnbBHHTDo5HYt4MUrFlom+yw0dSVdZOOQiB7aTQUMDIYPmxc9NA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SA1PR15MB5819.namprd15.prod.outlook.com (2603:10b6:806:338::8)
 by SA6PR15MB6593.namprd15.prod.outlook.com (2603:10b6:806:40d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Fri, 21 Nov
 2025 21:15:13 +0000
Received: from SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539]) by SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539%4]) with mapi id 15.20.9343.009; Fri, 21 Nov 2025
 21:15:13 +0000
From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
To: "jack@suse.cz" <jack@suse.cz>,
        "glaubitz@physik.fu-berlin.de"
	<glaubitz@physik.fu-berlin.de>,
        "frank.li@vivo.com" <frank.li@vivo.com>,
        "slava@dubeyko.com" <slava@dubeyko.com>,
        "brauner@kernel.org"
	<brauner@kernel.org>,
        "mehdi.benhadjkhelifa@gmail.com"
	<mehdi.benhadjkhelifa@gmail.com>,
        "viro@zeniv.linux.org.uk"
	<viro@zeniv.linux.org.uk>
CC: "syzbot+ad45f827c88778ff7df6@syzkaller.appspotmail.com"
	<syzbot+ad45f827c88778ff7df6@syzkaller.appspotmail.com>,
        "linux-kernel-mentees@lists.linuxfoundation.org"
	<linux-kernel-mentees@lists.linuxfoundation.org>,
        "khalid@kernel.org"
	<khalid@kernel.org>,
        "linux-fsdevel@vger.kernel.org"
	<linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "david.hunter.linux@gmail.com"
	<david.hunter.linux@gmail.com>,
        "skhan@linuxfoundation.org"
	<skhan@linuxfoundation.org>
Thread-Topic: [EXTERNAL] Re: [PATCH v2] fs/hfs: fix s_fs_info leak on
 setup_bdev_super() failure
Thread-Index: AQHcWxbjI2wNRsxXGEmG7hnNwSoKY7T9oaoA
Date: Fri, 21 Nov 2025 21:15:13 +0000
Message-ID: <8727342f9a168c7e8008178e165a5a14fa7f470d.camel@ibm.com>
References: <20251119073845.18578-1-mehdi.benhadjkhelifa@gmail.com>
	 <c19c6ebedf52f0362648a32c0eabdc823746438f.camel@ibm.com>
	 <3ad2e91e-2c7f-488b-a119-51d62a6e95b8@gmail.com>
In-Reply-To: <3ad2e91e-2c7f-488b-a119-51d62a6e95b8@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5819:EE_|SA6PR15MB6593:EE_
x-ms-office365-filtering-correlation-id: 335a390d-9f80-493d-f4a0-08de29430f65
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|10070799003|1800799024|7416014|366016|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?YWgzdDFjRHQvOFNLYmYyVy9nR1ZmVE1qU2t0V1M2dFpBTHRBaW5VN3RQdC9S?=
 =?utf-8?B?Rmh4UVFubzhMcnBpL25Sblpld1g5bTgvYWZ2d2R6Q1o2NTJ0ajlJakkxRzU4?=
 =?utf-8?B?ejhhWTlhZE4zVlBtc0JFdTg1SmsrYm5YK1BkbmJrNER2TEloc21nNXRTN2xW?=
 =?utf-8?B?Mm5lTVU3N3VIcTNSbjBIQWR6S05MZGFVaEM2UGFtWWJ1ZUdqZFRRUTRJMnNk?=
 =?utf-8?B?SU5NT3ZPUnVxRjVVem00OXM4M3p0b01KdVpnSGdvemVMRlE0c2NwLzB0ZjFl?=
 =?utf-8?B?UHBKS2lkRGZVSUMxR3NVT3NJR1k4SmdEcXFIbG5CWUJ3NnZlR1BoR3ZMa0Fx?=
 =?utf-8?B?ZlQ5MWgrWXB3YzNwN2phY2UvMkVnbzJEbmYzMGF5MFM0b1k3ZHIzYWRXU0tm?=
 =?utf-8?B?a0lPZVExRDBTOGJ5V1E1Z3dOSWVyWGJQcitpaWs5cjg4dXVzZldXWUNDUFFI?=
 =?utf-8?B?bGpKV2g3SExPUERSUWwwKzBQWU9ieTUrMzR3a0lhSzVUMWZmVWNaZWdSU0Rp?=
 =?utf-8?B?N0JWTE5EU3UyTEVmZGFpWXNRRU1DSGo5elpwRTVqWVlocUZxMjZCTmQ4aDU3?=
 =?utf-8?B?M3ZscTFVRkVwbmwra1BPdVRQUE1PdkJpbEtJaFpwWVg0c2lMTzRLdWsrSkRa?=
 =?utf-8?B?NU80UExYdG1pWDlxYStFdTludWg5TkxIZkdFbHdPbUNxUitTS2tZQlZSQzBo?=
 =?utf-8?B?YnR3Uk9RdEFiRlMvT05yeXFxMGtuVG10OUhXcUJHK3VRQXp1dXArdGMxNjNV?=
 =?utf-8?B?MXQwVU9KUlRQcGdya0luOUJLZlMwVlVtVGtjQktRT3N4alp5aWNtajJEMnJm?=
 =?utf-8?B?ZS9SYXpiQlkxZ3hNY3VwWEIySzhlYXFVTkNwaHp3dHprZlJia29pYWNneXlR?=
 =?utf-8?B?ZlNtTGh5RVlxNWQ2SWtVNXAvZFpmVHVQQnBZY1VnWjFNdmcrbFM5aW1rWDJl?=
 =?utf-8?B?THZCU091eUJaQklLb1c3S0ovdlhEY2ViVktTbVBMUkJxRk5NZ1FRalgzaVY1?=
 =?utf-8?B?Rmw1L2J6alFSWVc1eDd0MWZpMlBBcjQwS2J4SGhpb0NkU29oWWR4TEFFNmIy?=
 =?utf-8?B?ZEdYUjd3VHJPNURiZFNWVXluTkZVamZrSTRXV2pXcFBuTEFoU05CZmpKUVNn?=
 =?utf-8?B?d2MyTFFUdU1wOWJSM2dTUGlPQk90dDRLajU5U3BrdE05WjB0RFAxalBzQWMr?=
 =?utf-8?B?UisvRXpWOUdBSHk5ZTN3dGlOSGg3ajBWY1BOeUtUMGJsR0x4Uzh5cCsrNDRa?=
 =?utf-8?B?UlZUTTZ5RFZIZHpHQlVzdUJkQTFKWmdvZ1NDTER1RkhSdksrTmtFOCthT1Rz?=
 =?utf-8?B?YmxHZnNFNnZ5WkFDbnNYejVaZDVrWktRRnRrYjBJVDg0RDJQdGR3NXgxR3cx?=
 =?utf-8?B?Z2trb0hLaitGU0NZQXpoQk14SSsyRFdSS2ZRSElRRDh6U2grSkl4RkVrcEVR?=
 =?utf-8?B?QXF5ckZhMFAyOUZhcFhwQWxsdTIwUUsvd2xSWDFxcUtPcnBZemtBcmtURzRy?=
 =?utf-8?B?cHVJZm45NGlzUU5jTlZsZys0Z3RaUHJhRWtFMFNXeEc3d3RhTGVXemozbnIz?=
 =?utf-8?B?dElaRm9ZSEEvbWNTTC9Pd204cDQzbjVXWitvTFZVNHBiVXU5V1pIL0RGY1ND?=
 =?utf-8?B?clFwUnZodmJORy9FMGU5cldiNm51bEpseFY2Vmo1UnNNMW9wVGxxUGMraWVW?=
 =?utf-8?B?dEcrWjhhZ3B0cTdQQjg0ZUJTRHBWVXBrdm1iUklBMVB1aUQxWW1nQ3dabi9i?=
 =?utf-8?B?c3l6cmQrU3psR1oyM05qSG1KUVEzN2ROQThpWHZUVHRQNkN2UVhyR1pYcnlO?=
 =?utf-8?B?S0QxdU5XRFNTbWh4TTlnZ0crN2I1UkpGNFBidnAzUXlFWEc4dnFRKy80eDQ2?=
 =?utf-8?B?Vnh5SjAyNklEb1ZpRGMrSjFYNkdtRVhraDR6NGlYWHROUThNOHVxNW1vNXcr?=
 =?utf-8?B?RTJKdmlkK3F4aDI0TEFNb21NRFlWYkQ5NGVOS2lRRzEzR1RQVVB4VjlFVVdy?=
 =?utf-8?B?dTVLV3lzc2JnPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5819.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(10070799003)(1800799024)(7416014)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?R0k5T3NocThxRS9VL20wTTdELzE3c01tYWxxMVBvYUhhUkFYVEkyM2dvQVdB?=
 =?utf-8?B?M2t6aVM4NzhETGVHOExFVjFVVlJqa0xLL2tyYmM5dmFGcU1sNnJETWswak5B?=
 =?utf-8?B?MHp3ckdnNThvMGVaY3c5OXRKN0U5MzEyMWtyK2JVd2pSSWRoZisyQkcxVmc1?=
 =?utf-8?B?S2F1QU4zV2dmVkxtdWlxVE5Hdm9XaVRYT0tvUzVGWmVxNHhoNXF4TnhXWnV1?=
 =?utf-8?B?ei82Ti8rcGhhMkUrb3RJWXkvMXplWnVNNHBrVVJienpQT3NYcHlGei9qUlEr?=
 =?utf-8?B?OU1kRGFjNXU0aitTY0FYTTNWVktEK2JUVEgzMFdQa2lDOG5RREdLNVlrYTZZ?=
 =?utf-8?B?S3VERWZPT2dyd2VaREVEbUJ0SWlkRmw5ZzlveTRQazRqTmhZSG9rVVp3U1E1?=
 =?utf-8?B?NkplK2cxRjlwZVJpRGx5ZHcyQXNTbk5nSVdoYkNPL21PRzFWRXB6UU9zR2lr?=
 =?utf-8?B?UStqVUswbXI1dGJjM3NmeXVWOUhMUDBKbnh6Z2dTV09NU1QyN1FYWmFFWG5G?=
 =?utf-8?B?ZzlFQXhMeTBia3ZoeHRtNVJmYXk1WklWcHR1WW04b2d5ZU93VjBTeFBoUUps?=
 =?utf-8?B?QytqTDNEcVl5YmM0aTN5ZHFiaVpTallqRjUyQkFFaGZUcmt2NHUxMEhFMFhL?=
 =?utf-8?B?b1AzN3JFMzVkODE2Y3p3QmRwM1FwbldGc05ndE1yMUdycTczS1Zpd2xQSHU3?=
 =?utf-8?B?T1V3cG5DWUhCTnRZTjF5djBONy9ETmVkVUNIU3VOc21seWlxNWhEdklaSk1p?=
 =?utf-8?B?Wmt6Mlo5MGFla0x4dmYzS1FQM1MzTVV6T1NyOEJrUkZnQjB3UE1KZnNlV3Rm?=
 =?utf-8?B?eitDT09GcEtBdGRqdStockJ1cDIxZGQ5a2x5cTVYQU9VSXoxTGJ4M0x5ak81?=
 =?utf-8?B?RFk3Y0NFazlQcmRWVzRaR0dRRTlIQjBGYTJRYUJnWk9WSklzT2hxS3B2UUYx?=
 =?utf-8?B?V1FmQjE4WnJKTTBKZ095SVpnTkJtSE9mb1I4N0RJQmlTNkhjdFAxc1Ewcmox?=
 =?utf-8?B?aEJZeGMvcWR1SW5sTmZ4NG03S1VTa1dzb3B5c3AxNVhhbVpWd3FuVHdBb1Nw?=
 =?utf-8?B?eHVrVUd6VWFvdW1PVUZzMVBBYThaTVp1VVRZUExxS2NGR2EwcE4zeHhNamJ2?=
 =?utf-8?B?bEVqWEFWT0FtekM4WVBRbHlHOGlnbTh4WTZ3ZVdiK0ZvUnJ1eENFU28yMGJo?=
 =?utf-8?B?S0NMT2xjOFViWjNxc3N0UUR5ejNBaXVUeTdNRTRQSDA4QVExN0tvcThwd0V6?=
 =?utf-8?B?K3ZReUMyVTZ5UzdyUmE1SkFZRURYMWd2TkttVHVWcTlINy81MkpqbjJOcG5k?=
 =?utf-8?B?YTlvZG44QWVtbG9VZzVqUktzeld2cUhFWXVVTE5idE53ZTY1bFY3Mzd3aUsr?=
 =?utf-8?B?eTNJK2ZmK1l5TnBoQStjTTlwYm9aVnBnd3pBR3RScUxoOXR3SWJYKy9Sdk52?=
 =?utf-8?B?WlBEam81SXhxQithZ0Z1ZG1GWGNFc0VFdC8yQmpKSHVsdjhIaEVySHNNdk9z?=
 =?utf-8?B?L1FDZ0dTcU56cjRXWTFJTmloRTNDOXRZNWVwOUlqQkRDdldYRzNWaDFpeVhY?=
 =?utf-8?B?eXNFcXY1TDdDSU1DUlBnMFl4Zno0a0JkaGEzZWhXVnBPb1JsRThrQWtIcTV5?=
 =?utf-8?B?TDRuSFIyUVNoN2p1MGlDU3d1NnR4UEU0d2tIeURLVm45cnkyVVRiL3gxUysx?=
 =?utf-8?B?cFdicTduWWlwTjVDaENOanIrMXRUazhWWGVGbk1Gei9BenBnNGtySVMxRmVH?=
 =?utf-8?B?RExMSWpSendiYnFOM3dyc3BBRnZ1MXk4K2ZUclVBR2pxaFNFTndHaktSa09F?=
 =?utf-8?B?K1dGckRWbW1EcEJTZmN1SVA0Mnl6MHpKdXZKQVZpM0VRM0N0Ulk2NG5rVkhV?=
 =?utf-8?B?NTFZTmpSUjRoaGd1YUVWanJOQjVXRmFhSnVkZ3dpRWlXc1U1cGhFdXU5SVBV?=
 =?utf-8?B?MDhRSzc4eWFUSXBPOWhSUmhFMHp4OHFhSVMrclJoNitCTURhdDJhcTJRb1pt?=
 =?utf-8?B?RDV0ZkdIMzZVV2dMZ3hpWURGZjJBc2xMVXVRTHR1eXprNjVWSVB4akJ5Ylh3?=
 =?utf-8?B?eEN5SzQvQjFtREJJWWhqNDNyRFh0WFhVWFVaUG0zODZ1WDFnRmFzTzJEV0Fm?=
 =?utf-8?B?WUJmTUY1WmNtQ1d3QkNxc2V5WTljRXhoaTFXV2FVK1N0OThoRW9HYkRJb3Jr?=
 =?utf-8?Q?gKM9B8J3zBw1seApODpJx64=3D?=
X-OriginatorOrg: ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5819.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 335a390d-9f80-493d-f4a0-08de29430f65
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Nov 2025 21:15:13.1010
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pjauP/dDQoC1Mro2/4ipUKg5vApCKehjXFxE87Cwvg+/dN1JJ8bTPm7cG0tpOwoD/Igs9otbKx2CH/cLjkXQlw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA6PR15MB6593
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTE1MDAzMiBTYWx0ZWRfX55+IEDcdCm1W
 sMOCLw2a4Tlr8hoTD+xAbUZJQ2upYTKckkGrVsOWDL4if4C2p+2NTQC+Q/g/Tm0HxIXAS5VcXZs
 EUyM7OKmsNV3SmlP2T6OsrgU7ql5V1EL7KiFmngcvnFXj28SX9UHPvkbQiZgrLVsleXd3THn2uN
 MFtc07v3WSvXXKTP4aGQymIhJista888DJOSrpgpXYZRiQ3M/9KdjLte+XSuYcoOvMMeJc3xLO9
 ze4Nickgvb1bDhdKeqryJgEKrLMRe4k3qg3SOeFGJSKJHln8QsHRkYccCUAxRcECcRjBwedLqSb
 foIBaIksK8twt3mca3ZvrpV06hUJ1vCkFQVTZwtASBpXQJnL4Ga7c/AQApvhURb8J3DPiMJ+/hf
 rQdUzCqWCMoWiGxpZYQK3W75z+S9uQ==
X-Proofpoint-ORIG-GUID: bUzmj76nxFimZP5arsJsC9nQJ_YxQyEZ
X-Authority-Analysis: v=2.4 cv=XtL3+FF9 c=1 sm=1 tr=0 ts=6920d664 cx=c_pps
 a=WV97qI32orZZISq0e28SMA==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=edf1wS77AAAA:8 a=VwQbUJbxAAAA:8
 a=pGLkceISAAAA:8 a=NEAV23lmAAAA:8 a=P-IC7800AAAA:8 a=hSkVLCK3AAAA:8
 a=drOt6m5kAAAA:8 a=jMaJduHr-0vWMAFM8JcA:9 a=QEXdDO2ut3YA:10
 a=DcSpbTIhAlouE1Uv7lRv:22 a=d3PnA9EDa4IxuAV0gXij:22 a=cQPPKAXgyycSBL8etih5:22
 a=RMMjzBEyIzXRtoq5n5K6:22
X-Proofpoint-GUID: I_eRhsyzDqvGzlrCoUfLPaiB3wvPfemn
Content-Type: text/plain; charset="utf-8"
Content-ID: <74638C55EDDCEE428C0BD73913B85022@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: RE: [PATCH v2] fs/hfs: fix s_fs_info leak on setup_bdev_super()
 failure
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-21_06,2025-11-21_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 bulkscore=0 priorityscore=1501 impostorscore=0
 adultscore=0 lowpriorityscore=0 phishscore=0 malwarescore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=2 engine=8.19.0-2510240000 definitions=main-2511150032

On Fri, 2025-11-21 at 20:44 +0100, Mehdi Ben Hadj Khelifa wrote:
> On 11/19/25 8:58 PM, Viacheslav Dubeyko wrote:
> > On Wed, 2025-11-19 at 08:38 +0100, Mehdi Ben Hadj Khelifa wrote:
> > > The regression introduced by commit aca740cecbe5 ("fs: open block dev=
ice
> > > after superblock creation") allows setup_bdev_super() to fail after a=
 new
> > > superblock has been allocated by sget_fc(), but before hfs_fill_super=
()
> > > takes ownership of the filesystem-specific s_fs_info data.
> > >=20
> > > In that case, hfs_put_super() and the failure paths of hfs_fill_super=
()
> > > are never reached, leaving the HFS mdb structures attached to s->s_fs=
_info
> > > unreleased.The default kill_block_super() teardown also does not free
> > > HFS-specific resources, resulting in a memory leak on early mount fai=
lure.
> > >=20
> > > Fix this by moving all HFS-specific teardown (hfs_mdb_put()) from
> > > hfs_put_super() and the hfs_fill_super() failure path into a dedicated
> > > hfs_kill_sb() implementation. This ensures that both normal unmount a=
nd
> > > early teardown paths (including setup_bdev_super() failure) correctly
> > > release HFS metadata.
> > >=20
> > > This also preserves the intended layering: generic_shutdown_super()
> > > handles VFS-side cleanup, while HFS filesystem state is fully destroy=
ed
> > > afterwards.
> > >=20
> > > Fixes: aca740cecbe5 ("fs: open block device after superblock creation=
")
> > > Reported-by: syzbot+ad45f827c88778ff7df6@syzkaller.appspotmail.com
> > > Closes: https://syzkaller.appspot.com/bug?extid=3Dad45f827c88778ff7df=
6 =20
> > > Tested-by: syzbot+ad45f827c88778ff7df6@syzkaller.appspotmail.com
> > > Suggested-by: Al Viro <viro@zeniv.linux.org.uk>
> > > Signed-off-by: Mehdi Ben Hadj Khelifa <mehdi.benhadjkhelifa@gmail.com>
> > > ---
> > > ChangeLog:
> > >=20
> > > Changes from v1:
> > >=20
> > > -Changed the patch direction to focus on hfs changes specifically as
> > > suggested by al viro
> > >=20
> > > Link:https://lore.kernel.org/all/20251114165255.101361-1-mehdi.benhad=
jkhelifa@gmail.com/ =20
> > >=20
> > > Note:This patch might need some more testing as I only did run selfte=
sts
> > > with no regression, check dmesg output for no regression, run reprodu=
cer
> > > with no bug and test it with syzbot as well.
> >=20
> > Have you run xfstests for the patch? Unfortunately, we have multiple xf=
stests
> > failures for HFS now. And you can check the list of known issues here [=
1]. The
> > main point of such run of xfstests is to check that maybe some issue(s)=
 could be
> > fixed by the patch. And, more important that you don't introduce new is=
sues. ;)
> >=20
> I have tried to run the xfstests with a kernel built with my patch and=20
> also without my patch for TEST and SCRATCH devices and in both cases my=20
> system crashes in running the generic/631 test.Still unsure of the=20
> cause. For more context, I'm running the tests on the 6.18-rc5 version=20
> of the kernel and the devices and the environment setup is as follows:
>=20
> For device creation and mounting(also tried it with dd and had same=20
> results):
> fallocate -l 10G test.img
> fallocate -l 10G scratch.img
> sudo mkfs.hfs test.img
> sudo losetup /dev/loop0 ./test.img
> sudo losetup /dev/loop1 ./scratch.img
> sudo mkdir -p /mnt/test /mnt/scratch
> sudo mount /dev/loop0 /mnt/test
>=20
> For environment setup(local.config):
> export TEST_DEV=3D/dev/loop0
> export TEST_DIR=3D/mnt/test
> export SCRATCH_DEV=3D/dev/loop1
> export SCRATCH_MNT=3D/mnt/scratch

This is my configuration:

export TEST_DEV=3D/dev/loop50
export TEST_DIR=3D/mnt/test
export SCRATCH_DEV=3D/dev/loop51
export SCRATCH_MNT=3D/mnt/scratch

export FSTYP=3Dhfs

Probably, you've missed FSTYP. Did you tried to run other file system at fi=
rst
(for example, ext4) to be sure that everything is good?

>=20
> Ran the tests using:sudo ./check -g auto
>=20

You are brave guy. :) Currently, I am trying to fix the issues for quick gr=
oup:

sudo ./check -g quick

> If more context is needed to know the point of failure or if I have made=
=20
> a mistake during setup I'm happy to receive your comments since this is=20
> my first time trying to run xfstests.
>=20

I don't see the crash on my side.

sudo ./check generic/631
FSTYP         -- hfs
PLATFORM      -- Linux/x86_64 hfsplus-testing-0001 6.18.0-rc3+ #96 SMP
PREEMPT_DYNAMIC Wed Nov 19 12:47:37 PST 2025
MKFS_OPTIONS  -- /dev/loop51
MOUNT_OPTIONS -- /dev/loop51 /mnt/scratch

generic/631       [not run] attr namespace trusted not supported by this
filesystem type: hfs
Ran: generic/631
Not run: generic/631
Passed all 1 tests

This test simply is not running for HFS case.

I see that HFS+ is failing for generic/631, but I don't see the crash. I am
running 6.18.0-rc3+ but I am not sure that 6.18.0-rc5+ could change somethi=
ng
dramatically.

My guess that, maybe, xfstests suite is trying to run some other file syste=
m but
not HFS.=20

> > >=20
> > >   fs/hfs/super.c | 16 ++++++++++++----
> > >   1 file changed, 12 insertions(+), 4 deletions(-)
> > >=20
> > > diff --git a/fs/hfs/super.c b/fs/hfs/super.c
> > > index 47f50fa555a4..06e1c25e47dc 100644
> > > --- a/fs/hfs/super.c
> > > +++ b/fs/hfs/super.c
> > > @@ -49,8 +49,6 @@ static void hfs_put_super(struct super_block *sb)
> > >   {
> > >   	cancel_delayed_work_sync(&HFS_SB(sb)->mdb_work);
> > >   	hfs_mdb_close(sb);
> > > -	/* release the MDB's resources */
> > > -	hfs_mdb_put(sb);
> > >   }
> > >  =20
> > >   static void flush_mdb(struct work_struct *work)
> > > @@ -383,7 +381,6 @@ static int hfs_fill_super(struct super_block *sb,=
 struct fs_context *fc)
> > >   bail_no_root:
> > >   	pr_err("get root inode failed\n");
> > >   bail:
> > > -	hfs_mdb_put(sb);
> > >   	return res;
> > >   }
> > >  =20
> > > @@ -431,10 +428,21 @@ static int hfs_init_fs_context(struct fs_contex=
t *fc)
> > >   	return 0;
> > >   }
> > >  =20
> > > +static void hfs_kill_sb(struct super_block *sb)
> > > +{
> > > +	generic_shutdown_super(sb);
> > > +	hfs_mdb_put(sb);
> > > +	if (sb->s_bdev) {
> > > +		sync_blockdev(sb->s_bdev);
> > > +		bdev_fput(sb->s_bdev_file);
> > > +	}
> > > +
> > > +}
> > > +
> > >   static struct file_system_type hfs_fs_type =3D {
> > >   	.owner		=3D THIS_MODULE,
> > >   	.name		=3D "hfs",
> > > -	.kill_sb	=3D kill_block_super,

I've realized that if we are trying to solve the issue with pure call of
kill_block_super() for the case of HFS/HFS+, then we could have the same tr=
ouble
for other file systems. It make sense to check that we do not have likewise
trouble for: bfs, hpfs, fat, nilfs2, ext2, ufs, adfs, omfs, isofs, udf, min=
ix,
jfs, squashfs, freevxfs, befs.

> >=20
> > It looks like we have the same issue for the case of HFS+ [2]. Could yo=
u please
> > double check that HFS+ should be fixed too?
> >=20
> I have checked the same error path and it seems that hfsplus_sb_info is=20
> not freed in that path(I could provide the exact call stack which would=20
> cause such a memory leak) although I didn't create or run any=20
> reproducers for this particular filesystem type.
> If you would like a patch for this issue, would something like what is=20
> shown below be acceptable? :
>=20
> +static void hfsplus_kill_super(struct super_block *sb)
> +{
> +       struct hfsplus_sb_info *sbi =3D HFSPLUS_SB(sb);
> +
> +       kill_block_super(sb);
> +       kfree(sbi);
> +}
> +
>   static struct file_system_type hfsplus_fs_type =3D {
>          .owner          =3D THIS_MODULE,
>          .name           =3D "hfsplus",
> -       .kill_sb        =3D kill_block_super,
> +       .kill_sb        =3D hfsplus_kill_super,
>          .fs_flags       =3D FS_REQUIRES_DEV,
>          .init_fs_context =3D hfsplus_init_fs_context,
>   };
>=20
> If there is something to add, remove or adjust. Please let me know in=20
> the case of you willing accepting such a patch of course.

We call hfs_mdb_put() for the case of HFS:

void hfs_mdb_put(struct super_block *sb)
{
	if (!HFS_SB(sb))
		return;
	/* free the B-trees */
	hfs_btree_close(HFS_SB(sb)->ext_tree);
	hfs_btree_close(HFS_SB(sb)->cat_tree);

	/* free the buffers holding the primary and alternate MDBs */
	brelse(HFS_SB(sb)->mdb_bh);
	brelse(HFS_SB(sb)->alt_mdb_bh);

	unload_nls(HFS_SB(sb)->nls_io);
	unload_nls(HFS_SB(sb)->nls_disk);

	kfree(HFS_SB(sb)->bitmap);
	kfree(HFS_SB(sb));
	sb->s_fs_info =3D NULL;
}

So, we need likewise course of actions for HFS+ because we have multiple
pointers in superblock too:

struct hfsplus_sb_info {
	void *s_vhdr_buf;
	struct hfsplus_vh *s_vhdr;
	void *s_backup_vhdr_buf;
	struct hfsplus_vh *s_backup_vhdr;
	struct hfs_btree *ext_tree;
	struct hfs_btree *cat_tree;
	struct hfs_btree *attr_tree;
	atomic_t attr_tree_state;
	struct inode *alloc_file;
	struct inode *hidden_dir;
	struct nls_table *nls;

	/* Runtime variables */
	u32 blockoffset;
	u32 min_io_size;
	sector_t part_start;
	sector_t sect_count;
	int fs_shift;

	/* immutable data from the volume header */
	u32 alloc_blksz;
	int alloc_blksz_shift;
	u32 total_blocks;
	u32 data_clump_blocks, rsrc_clump_blocks;

	/* mutable data from the volume header, protected by alloc_mutex */
	u32 free_blocks;
	struct mutex alloc_mutex;

	/* mutable data from the volume header, protected by vh_mutex */
	u32 next_cnid;
	u32 file_count;
	u32 folder_count;
	struct mutex vh_mutex;

	/* Config options */
	u32 creator;
	u32 type;

	umode_t umask;
	kuid_t uid;
	kgid_t gid;

	int part, session;
	unsigned long flags;

	int work_queued;               /* non-zero delayed work is queued */
	struct delayed_work sync_work; /* FS sync delayed work */
	spinlock_t work_lock;          /* protects sync_work and work_queued */
	struct rcu_head rcu;
};

Thanks,
Slava.

>=20
> > > +	.kill_sb	=3D hfs_kill_sb,
> > >   	.fs_flags	=3D FS_REQUIRES_DEV,
> > >   	.init_fs_context =3D hfs_init_fs_context,
> > >   };
> >=20
> > [1] https://github.com/hfs-linux-kernel/hfs-linux-kernel/issues =20
> > [2] https://elixir.bootlin.com/linux/v6.18-rc6/source/fs/hfsplus/super.=
c#L694 =20


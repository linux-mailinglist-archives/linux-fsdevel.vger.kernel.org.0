Return-Path: <linux-fsdevel+bounces-70405-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 73B52C9982D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 02 Dec 2025 00:05:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 515103A5C71
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Dec 2025 23:04:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A0D32882AF;
	Mon,  1 Dec 2025 23:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="OatWfWEY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DDEF1E5B71
	for <linux-fsdevel@vger.kernel.org>; Mon,  1 Dec 2025 23:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764630263; cv=fail; b=gSVYhDwyHbPmrCbfOUxUfffPucoqEj+Y3CPAzr96HS0+IyZGw26nIH7eRruG7DeCzMHOTv4sSHWoSzqCmtRxqgqw61N593hO4nqs+P8T7iWGGY65r9sEz4hHmZts/rzQvyiCmEaqxODcis0FCPnvyreYqT/2nBvENugvysT1YjE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764630263; c=relaxed/simple;
	bh=rAOtO64MgRFlQBOJrLcWXxvJx5AQc0gKQm2MVvIVHBk=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=UJh5TgvwlHEq2RQi6k0h/5JP/SF081wHg1Gof/TjAn31YxJXEGs0+b3ALY51lAzE/Vvy/vMXwZTz6cMnf4mGtTfVRHiKkCdLAH/kXNyRWowfgiQAkiPjm7HO94HAvKxLJ9kB4Fpoi8Nq9MLYMHcGdphk6LbPr60GeNgAi1Sdjbk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=OatWfWEY; arc=fail smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5B1MvlY4011424
	for <linux-fsdevel@vger.kernel.org>; Mon, 1 Dec 2025 23:04:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pp1; bh=Z33bws4U6cBZrafWPVhApPbfH869B6ma0N81iikoazA=; b=OatWfWEY
	Wlr+S2rAl6NdFOIAMiwBkjVVIShHmnpII8z4mU0YXqvyGj3xAkYSfI4Nv6NtZRKR
	Ajo6f28zhC/WrZNAD5Jbd1+5o90QG3m99m5y76SKPzdgsrXbQIeLWEDafUNojYdM
	/J9vEzykNPaU/lZtONIiK9/3qz+TeMqj7k713tc3VFtURZFNUUns3M80N1ovr2yg
	uBI8H/iHeZ7ROfIuSm9D0pdZvoqh8YMzuC/Cx9+77orUhQp2XNezmy4dbnAlXPs2
	TSYHfNgyBVq1YMvUPQ/CYfbhqHcam9BuXg2pxx1PFKRd6U8Ba/Jkj/XHmmW1eG2l
	Ot2QSy9OOFA8PQ==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4aqp8psvtv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-fsdevel@vger.kernel.org>; Mon, 01 Dec 2025 23:04:21 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5B1N4K33016772
	for <linux-fsdevel@vger.kernel.org>; Mon, 1 Dec 2025 23:04:20 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4aqp8psvtj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 01 Dec 2025 23:04:20 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5B1N4JmK016761;
	Mon, 1 Dec 2025 23:04:19 GMT
Received: from sn4pr0501cu005.outbound.protection.outlook.com (mail-southcentralusazon11011035.outbound.protection.outlook.com [40.93.194.35])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4aqp8psvtg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 01 Dec 2025 23:04:19 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uyEKUfdVvOwi3K/1UNaClBQbxnq0yOVIHMJ7df8qBzr+wziCY5w0+TCbU6VouYCadORYVlQP+ZGb/1VQKxnXpHb+lcbytfKLpXuoqCEV/c9Zee8QGOkc0KEQe0Zu2AF84Tcj2vqLTClyKtfqagZ20zZ0XEVC8l+yMeSZtOxi+APQFas3DHdGMIN/DfkZ1/eryHcX8PR2EWOOfwjJeNuJcqP/Cr/hCCYiQQ2DV699r0RXaHTxy5YrlDjuXVj0+NvHqZmfMSSUOL7dFIPKw9OqPGwosrE6JqBCJtEaN8z8N8csae47ptVREOgbj9qw38f8b5sNPhUA+kf5rgOmeyB6Nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wSh4g876wC87NuV9FOKvREyN1fXdEQ3tHn1AGtK0hqU=;
 b=T46ZlUCavqvdzhrf+9Vjn7lmwkqy0yAQuHA1kIZOQiTl0p5BtsRgH0SNlavSWdMgazNbrAfT6eBxbfGfnSKxuU+v9VRcYrsFPmtx3DlAg7eLWYgL3Bh12XqLUQ6DfMJ7UNk1vVtv+38I0UdlruhGcLAf1gnDZ4NsngUrHkwr0NYH/WtjnJ9BaRyZxcyE74e8fWPuyr+dcE9Yz8PRUEwptHcr+IDys5E6e/y4YPf3lrRluSkzZj1VM2ea/qqM1Pm6qf70G5qtD7hnGh/iohSAsIayMfOsVdPX4i8PQB4+CauhmQm4WxsEGa/2vRrA0KIvq/KBR7A/lI/q2YKH/WqZoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SA1PR15MB5819.namprd15.prod.outlook.com (2603:10b6:806:338::8)
 by CO1PR15MB5018.namprd15.prod.outlook.com (2603:10b6:303:e9::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Mon, 1 Dec
 2025 23:04:16 +0000
Received: from SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539]) by SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539%4]) with mapi id 15.20.9366.012; Mon, 1 Dec 2025
 23:04:15 +0000
From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
To: "brauner@kernel.org" <brauner@kernel.org>,
        "glaubitz@physik.fu-berlin.de"
	<glaubitz@physik.fu-berlin.de>,
        "frank.li@vivo.com" <frank.li@vivo.com>,
        "slava@dubeyko.com" <slava@dubeyko.com>, "jack@suse.cz" <jack@suse.cz>,
        "mehdi.benhadjkhelifa@gmail.com" <mehdi.benhadjkhelifa@gmail.com>,
        "sandeen@redhat.com" <sandeen@redhat.com>
CC: "khalid@kernel.org" <khalid@kernel.org>,
        "linux-fsdevel@vger.kernel.org"
	<linux-fsdevel@vger.kernel.org>,
        "david.hunter.linux@gmail.com"
	<david.hunter.linux@gmail.com>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "linux-kernel-mentees@lists.linuxfoundation.org"
	<linux-kernel-mentees@lists.linuxfoundation.org>,
        "syzbot+ad45f827c88778ff7df6@syzkaller.appspotmail.com"
	<syzbot+ad45f827c88778ff7df6@syzkaller.appspotmail.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "skhan@linuxfoundation.org" <skhan@linuxfoundation.org>
Thread-Topic: [EXTERNAL] [PATCH v3 1/2] hfs: ensure sb->s_fs_info is always
 cleaned up
Thread-Index: AQHcYwmSp3zWSWmVOEqCav8ABJL8V7UNZ42A
Date: Mon, 1 Dec 2025 23:04:15 +0000
Message-ID: <4b620e91b43f86dceed88ed2f73b1ff1e72bff6c.camel@ibm.com>
References: <20251201222843.82310-1-mehdi.benhadjkhelifa@gmail.com>
	 <20251201222843.82310-2-mehdi.benhadjkhelifa@gmail.com>
In-Reply-To: <20251201222843.82310-2-mehdi.benhadjkhelifa@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5819:EE_|CO1PR15MB5018:EE_
x-ms-office365-filtering-correlation-id: 26768b60-7daf-4784-7d4a-08de312df337
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|10070799003|366016|1800799024|7416014|376014|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?azFnVEg3TjVxYTFtZGVLUUpXSjg5Z1JrQXpOQWVzQVNOWG5vanJweGM5cGps?=
 =?utf-8?B?OEd3aC9RbG9NVHFGU2g4UmFvc3JNajllYU50VEd6OEFGYnVwSXpHWHFXVTlq?=
 =?utf-8?B?dVBwVnN6bWJoWmtsalVJU1c3cnpaRk9ReVhoZG5jWFVaOTMxR1Q4Z0VEWXdv?=
 =?utf-8?B?S1ZyWE1NUVYyUTZ0cjcwTjBpZnZUdGNRcjgxeVJwVUJ6ZW5VVmxnTC9xMEIy?=
 =?utf-8?B?NUJUS3Awa1ViNnBMYnk3enFDZnMyLzNpaHNzd1FVSEV0aHVPM3dkUEJubzRz?=
 =?utf-8?B?SnRYSHZOTUtENDhvQWlpOUZGakRLeUxxSTNJelVvR09FNlVrajFCKythcVJW?=
 =?utf-8?B?czg2Z2x0TVU3ZFZQS3BZblZJRmRaTkVZVmRlRzc5eFg3THpxM1F4Zy94ekJh?=
 =?utf-8?B?OWIycC9nS2h2T2N4UVF1K3pJTHdSQmE0Wi9oMU9MMkZYcUt4WXJYYjI4eDc1?=
 =?utf-8?B?SWxDVjk1WmpPUkhjWS9iTmtzL2ZrY2FnZ2s3elhzVk8zcmY5SnlsNnQ5amlD?=
 =?utf-8?B?NEk2SGF0dFdXT2pPbWl5bkVXcHVVeVZZMTZHdGZYU1RIa1pxMWc1cVRhdWQw?=
 =?utf-8?B?b2NpRU9Dc3NLQnhxN1k1SHphUDduU3JWT1FjUmZ5aXk5TUk3bFVXYnpta25B?=
 =?utf-8?B?bVZHQlJVMVo3TmJqNWhqSmFwVDBNZHRkamE2ZFkrcWZBWWZxMmRCTUhzNXBL?=
 =?utf-8?B?N2NnTEV1NVF6aUFxandnblN5L1l1WkNnZHY4ZjA3OHBSNVJUd04xcUEvOFVN?=
 =?utf-8?B?ZmpRUE5HdzhUU20vLzdkLzVsMmJ3SERZSlJlMllJcmcwR1BCc3lTSXBaaC9R?=
 =?utf-8?B?QW5RaW9tSEoyWE5tSW9kWFRFRTJ3cjZRZ1pUOG55b3F4NWMvNmRrZW8xYVBF?=
 =?utf-8?B?MkhpdHA3UnpVYkQ3ZTQ5TzVuaytJVnorVm9RRkxtZGpNWjArdFN3bFo5WHdh?=
 =?utf-8?B?d0FXMFllOE1MMXU2QzJhNHdpN1FaTXFHZUFUdU1YcDlIVXdOTzM5U0IzSjNP?=
 =?utf-8?B?bmlzZlBkRVk0UjNvWkMreHNlUHRUd0tKTk5sZlRGczdWSS9zWDUydTVvNmZ2?=
 =?utf-8?B?b1Z5ck44bG9QTVJCTlBQcjBHNC9SQmNsSFNBT0hYbU04WkoyNWpVOTFQci9Z?=
 =?utf-8?B?d1dNWUE4cXY0dzJuMlIrdnZkTVVKMDNJdjMyTWRvSkE2bkh0ZDNSSVYzOGgv?=
 =?utf-8?B?NjZROGs4TXRKRmRrMTluaDRhaDFRTG92VHRsV2ViNkZhYlg5ZXhxYlo5K0xr?=
 =?utf-8?B?cWcybDNJM1lQZmNXenJZN3JkMldGbEowWDdYM01Da3ZkYXRWWEEwY09jaUJm?=
 =?utf-8?B?cUcxR2RMVDJGb29qeVRQazZHZ2JIK0dRa1JqSWZTc0h6RktXQ29YcmJNbVNH?=
 =?utf-8?B?Z2JhTkk0SjViNjdmdjZUakNYamRUYTJOd0doaTVqbW1WakdlcWYzN0NaRGNr?=
 =?utf-8?B?dUFleEh1YmNNNk53UWF2UGJEVjFoWE1Vb1I4SmlHWHEwcEdXZ0MySW9OT2JU?=
 =?utf-8?B?VGJmeVUrTWs5VGl1YmJva0s3Mm1yTWJoZktSaE1wSFJtUGY5WUg3OGNKSDZJ?=
 =?utf-8?B?OU1qV1RJVURTQ1p2bDJMK1IrcnhjTUMxUWp0TTlxSHZqUllUZ2M1cWZIOHA2?=
 =?utf-8?B?RXZHY1U4VGlCRlhwRUU1disySk1RUUd2MjV1TWhobHVKM0I1L0hZQmp4aTdC?=
 =?utf-8?B?Vm5Ba29KTURvdWhoS0Y3eVNZbThmOEdsU3huTkIzWmF0cVRlOUs1aHVQWmxV?=
 =?utf-8?B?akdlWm9RbktUd2N5MkQzNEN3cVMyTVkrRkdBN2hEL0ZVR2lIMitTdk9xQmQ2?=
 =?utf-8?B?SUp2bGpmMTJORnpTMTVEZXppdk02VlpOVElheDJ1eVRDbGJRNm15NlhsckVQ?=
 =?utf-8?B?RFpLYi9vUDZOMnEwUW1XQnpQOHhpM0VwMmc2L3Ruc2Fnb0wzano0YUhnQW9H?=
 =?utf-8?B?bUJoanN3SnZ6aGtuZXZmSWwzZEdCUzhNQmkrbSs1S0NmQlp5Y2RQWE0xYzMy?=
 =?utf-8?B?Tys5bTdTSldnPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5819.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(1800799024)(7416014)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?YVArc1lhamVCdmdhVWxjS21lQ2V1UEFVaHN6THRHREZpbWU4aWwvOHhDandN?=
 =?utf-8?B?L2UxRUEzN1l6eFd3VGM1NWNoNS95aUpXenZXeDdpRXlnY2ZaamNNREFHZFJo?=
 =?utf-8?B?ZTBjR09wcHVKcm1qcldRMUpnOXAzS2oxWlZhcFRRWmR0NjVKMlhoaXY2T3RF?=
 =?utf-8?B?UXBOYUFDZmwzeW4yaXppVmhZam53TzV5bVNldzBPaXlOaEV4cG40R29pK0Nr?=
 =?utf-8?B?dVNlWXlQV1FCVm5PS1hFSVdoTXdqaHcwOWhUWkllNnFGNjBrKys5MHF3NjZa?=
 =?utf-8?B?NmJBcjYvTllJaG82a0lIRVE3cExsdnhka2E1eU5SNkZCVzVHTUhXMkZYMGdq?=
 =?utf-8?B?RXFrZHQ1RVJtZkFpNjhtMzBIK3pXTjFoY2dxTFNKQWhIdTZDSndGbmJrR1kx?=
 =?utf-8?B?dTFnV3FaUHQzakptMWhUWHlodEEvb1NjU0F4Yk5JZWVtZS96VHowd2RlZWxi?=
 =?utf-8?B?UjIzV0N5T0xSSmZ0Y1l0aEFkRHFtOEJ3RG9VcSt4VE5qbUZZaWhPYW9DUnRk?=
 =?utf-8?B?eWd1ZHFSTmJwWVhMVUp1RFo1Y0ZyTzlQaWpFOHI4a242alZFRi9LeXlNMVRR?=
 =?utf-8?B?WnNrSjJxNGVNRjVRamRHZ0NPeWp4ME9EanNUclMwUW1NZkQ0bUNlcHNONFVN?=
 =?utf-8?B?UkRJS3ptbkM0dHVtblczRjM5K1RucHkvZTN1SXB4ZGhJRVZFTmZPVk5nSUFO?=
 =?utf-8?B?cTk1VFR6WjZCRDROekladWU5bHNKaWMzQnpEZGFaZXJnbjZXNWVpU3AyWUxx?=
 =?utf-8?B?Y3NvRDhMak5HTlZnY3kwTE1XUEdnR0NCenNKbEg2a1NmRGVNb0hOb2pLT1Bp?=
 =?utf-8?B?bFlUNS95cVVRYnpGRmlBTE5hSHNaekVuMklLNkZNOGNWSkRKY2JwK0JYQ3RL?=
 =?utf-8?B?QnpuNlR6aWtRRmVib1IvNWl0Y1hRRWZrdStOakRGd3pKb21NUWttVkZBdmZI?=
 =?utf-8?B?YnlkanUra1hpeTdJcUwwTTZ4Y2pUZUxmQXZCVUM4WW9PaU04UjRtZ1cvNUIz?=
 =?utf-8?B?TUF4NmgzTjQ1bGIzU2FtSFFFY3JZdE9URjh3VkorcklvcmxwOC9kL1pqQ0RU?=
 =?utf-8?B?QWJRNmhRZ3huYnp2aXR2THFjM1Z0RVRaVDFBcVRmd1Y4QlNNaHpRWTl1K1pS?=
 =?utf-8?B?SWxjZ0k0bmlDNnhUU1kxdzBIQnl0aWZNWTlibSt6ZEppa2c2Sm0vRmZkaVVQ?=
 =?utf-8?B?c1NQRGRGdjd3OHVlZUtFMitFbkt1YnJWVEdYRWIyK3J2RnFRcHBHbmROblJL?=
 =?utf-8?B?RFVPdTZram1hRUZFVDJ2SUF1UThQbGROaCsxN2FjeTJVSVNNdzB2UlNiVjU2?=
 =?utf-8?B?bmRQMy9rWUljbVY3eFdhVkQrK2Y2QjdnaUUyam5naW1tSzdDcS8rb0ljaW5U?=
 =?utf-8?B?VHpxZnBweklPbUpnYlVaTkJsOFhtc2tkYzRaTnAwUXptK05rWDFOSlJMZ3Az?=
 =?utf-8?B?ZDlwSFNJV3JpZ3Ixdy9aK21iMkoxMVhwd1VOakR2enl6eW0xQXdhbWJGbEdy?=
 =?utf-8?B?d3VITHU0bUx0VlJzSmpMZ3ROaWF4RGhDbllKajdTcVJjVVpmVWlYOGlmeUQ5?=
 =?utf-8?B?b3Z1bGVyNSticWdodmxCYW1Wa3lPd0ltUzMrSThVK0ZLQi91d2hKK0h0SjV0?=
 =?utf-8?B?RnB1RnBkbXpWZXBvVTdDN3RNMUtjS1Nvd0Qvby91UEx3a1lPTWlZV2FLRmoy?=
 =?utf-8?B?Y3JWalE2b210SDV6bUpuNzdwTHJ6VitEaldoUWl3WTJ1Q0hNa3ptWEsraVVm?=
 =?utf-8?B?VGNJcHVYTUZTdWxPeFNUcWNvS2Nqa1k3SlRMdkFUdXlvRGdZbUprRFlKM2ta?=
 =?utf-8?B?akE1VG92bTBCeUZqZlV2UHpRUlkzSlpmNFAxR1ZkZnl6eWp3Y2EzLzFtaVMy?=
 =?utf-8?B?aWYrUWZCMlV0c1ltK3NERGFwTDN1enUvNkkvcmdic2MyMjBXY2ExRzhRN0Jo?=
 =?utf-8?B?dTNBVk8rSnAwNkI3Qzh6NmF0allsbzRqYXVMSTRQeUN3V200bkNrMnFyS28z?=
 =?utf-8?B?VEpLTzR6d1o0U2c5aTdjRWhEK1dDOGdreU03aVNiZEdSdmt0eVdUc1ZPVmhj?=
 =?utf-8?B?dm8vQVZDUXZCSzRKZ3A2UW5BamlDOXVOR2hISUxCYnpYajJXbjJnQnQwZkNs?=
 =?utf-8?B?Z255S1RkWjRLK0pFdmE1bnc4bGRmNFVjWG1xNnpzcHNhMmF3b24rOHBMMkZ2?=
 =?utf-8?Q?SzlugKuk5OGbHiBds1TEu5g=3D?=
X-OriginatorOrg: ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5819.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26768b60-7daf-4784-7d4a-08de312df337
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Dec 2025 23:04:15.6813
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: K0yEXEp2jTnhPbF4ZRKIKTn0TpsTYQeJwMveq+KhwL3/znY7ciFkSlH+JOnN6WStt4I8ez0kBmPUmT2UGQLZkw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR15MB5018
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTI5MDAwMCBTYWx0ZWRfX+THqGGwUlG+w
 cQpo3f8n4egWYMcfFvBsOGrQUvVWixVT5ta6lK3VVmdS1OuX+2LfKRSLdbL/VKqaoYUOi0bh7/J
 sgFxP+vV/AkIZX+9lS2eGm5v+jRIgJzMybNpMgZ8/SHbgtYI6QMKmzAc6eTmtTkhqcUO6ze+xXT
 XTvHizMt9RxjR4XZi2XzXDAZWB7d1r/8BMQYnKFs17G0Mks3iUbhxs8uRNONYemZ3U1g5fQw8NI
 30SK6Lvyxr+WUnCbJEExsez/r+lgTOaGJWi0SLUHHdFOiS/e1z7fOwFe2iKczv7Gx/rck7I67dq
 3QTVhUeh3IFuLzwSN/D15emvxjtICjBkCdx4pqLss0Ddvl0k6bHRNEsp+p0V/E7WHnMFH1lIdHW
 1S47R+BN6UeYb/I6T36Kq+LnFXv5Zg==
X-Authority-Analysis: v=2.4 cv=dIerWeZb c=1 sm=1 tr=0 ts=692e1ef4 cx=c_pps
 a=ALJIVG5iHo/ZE5SKMfQyZg==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=edf1wS77AAAA:8 a=VwQbUJbxAAAA:8
 a=hSkVLCK3AAAA:8 a=VnNF1IyMAAAA:8 a=pGLkceISAAAA:8 a=kVi45ne9b_ga1HM0DI4A:9
 a=QEXdDO2ut3YA:10 a=DcSpbTIhAlouE1Uv7lRv:22 a=cQPPKAXgyycSBL8etih5:22
X-Proofpoint-ORIG-GUID: GVLk5CRqO80QjDgy5KoNYW3YBL2HYOE_
X-Proofpoint-GUID: CNh0bh-7_YTPKGyybwXg_BUwmM1eRcZw
Content-Type: text/plain; charset="utf-8"
Content-ID: <2705799BE48C6C4193AE0CB3F3B68197@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re:  [PATCH v3 1/2] hfs: ensure sb->s_fs_info is always cleaned up
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-28_08,2025-11-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 clxscore=1011 spamscore=0
 malwarescore=0 suspectscore=0 adultscore=0 bulkscore=0 phishscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=2 engine=8.19.0-2510240000
 definitions=main-2511290000

On Mon, 2025-12-01 at 23:23 +0100, Mehdi Ben Hadj Khelifa wrote:
> When hfs was converted to the new mount api a bug was introduced by
> changing the allocation pattern of sb->s_fs_info. If setup_bdev_super()
> fails after a new superblock has been allocated by sget_fc(), but before
> hfs_fill_super() takes ownership of the filesystem-specific s_fs_info
> data it was leaked.
>=20
> Fix this by freeing sb->s_fs_info in hfs_kill_super().
>=20
> Cc: stable@vger.kernel.org
> Fixes: ffcd06b6d13b ("hfs: convert hfs to use the new mount api")
> Reported-by: syzbot+ad45f827c88778ff7df6@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=3Dad45f827c88778ff7df6 =20
> Tested-by: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
> Signed-off-by: Christian Brauner <brauner@kernel.org>
> Signed-off-by: Mehdi Ben Hadj Khelifa <mehdi.benhadjkhelifa@gmail.com>
> ---
>  fs/hfs/mdb.c   | 35 ++++++++++++++---------------------
>  fs/hfs/super.c | 10 +++++++++-
>  2 files changed, 23 insertions(+), 22 deletions(-)
>=20
> diff --git a/fs/hfs/mdb.c b/fs/hfs/mdb.c
> index 53f3fae60217..f28cd24dee84 100644
> --- a/fs/hfs/mdb.c
> +++ b/fs/hfs/mdb.c
> @@ -92,7 +92,7 @@ int hfs_mdb_get(struct super_block *sb)
>  		/* See if this is an HFS filesystem */
>  		bh =3D sb_bread512(sb, part_start + HFS_MDB_BLK, mdb);
>  		if (!bh)
> -			goto out;
> +			return -EIO;

Frankly speaking, I don't see the point to rework the hfs_mdb_get() method =
so
intensively. We had pretty good pattern before:

int hfs_mdb_get(struct super_block *sb) {
        if (something_happens)
             goto out;

        if (something_happens_and_we_need_free_buffer)
            goto out_bh;

 	return 0;

out_bh:
	brelse(bh);
out:
	return -EIO;
 }

The point here that we have error management logic in one place. Now you ha=
ve
spread this logic through the whole function. It makes function more diffic=
ult
to manage and we can introduce new bugs. Could you please localize your cha=
nge
without reworking this pattern of error situation management? Also, it will=
 make
the patch more compact. Could you please rework the patch?

Thanks,
Slava.=20

> =20
>  		if (mdb->drSigWord =3D=3D cpu_to_be16(HFS_SUPER_MAGIC))
>  			break;
> @@ -102,13 +102,14 @@ int hfs_mdb_get(struct super_block *sb)
>  		 * (should do this only for cdrom/loop though)
>  		 */
>  		if (hfs_part_find(sb, &part_start, &part_size))
> -			goto out;
> +			return -EIO;
>  	}
> =20
>  	HFS_SB(sb)->alloc_blksz =3D size =3D be32_to_cpu(mdb->drAlBlkSiz);
>  	if (!size || (size & (HFS_SECTOR_SIZE - 1))) {
>  		pr_err("bad allocation block size %d\n", size);
> -		goto out_bh;
> +		brelse(bh);
> +		return -EIO;
>  	}
> =20
>  	size =3D min(HFS_SB(sb)->alloc_blksz, (u32)PAGE_SIZE);
> @@ -125,14 +126,16 @@ int hfs_mdb_get(struct super_block *sb)
>  	brelse(bh);
>  	if (!sb_set_blocksize(sb, size)) {
>  		pr_err("unable to set blocksize to %u\n", size);
> -		goto out;
> +		return -EIO;
>  	}
> =20
>  	bh =3D sb_bread512(sb, part_start + HFS_MDB_BLK, mdb);
>  	if (!bh)
> -		goto out;
> -	if (mdb->drSigWord !=3D cpu_to_be16(HFS_SUPER_MAGIC))
> -		goto out_bh;
> +		return -EIO;
> +	if (mdb->drSigWord !=3D cpu_to_be16(HFS_SUPER_MAGIC)) {
> +		brelse(bh);
> +		return -EIO;
> +	}
> =20
>  	HFS_SB(sb)->mdb_bh =3D bh;
>  	HFS_SB(sb)->mdb =3D mdb;
> @@ -174,7 +177,7 @@ int hfs_mdb_get(struct super_block *sb)
> =20
>  	HFS_SB(sb)->bitmap =3D kzalloc(8192, GFP_KERNEL);
>  	if (!HFS_SB(sb)->bitmap)
> -		goto out;
> +		return -EIO;
> =20
>  	/* read in the bitmap */
>  	block =3D be16_to_cpu(mdb->drVBMSt) + part_start;
> @@ -185,7 +188,7 @@ int hfs_mdb_get(struct super_block *sb)
>  		bh =3D sb_bread(sb, off >> sb->s_blocksize_bits);
>  		if (!bh) {
>  			pr_err("unable to read volume bitmap\n");
> -			goto out;
> +			return -EIO;
>  		}
>  		off2 =3D off & (sb->s_blocksize - 1);
>  		len =3D min((int)sb->s_blocksize - off2, size);
> @@ -199,12 +202,12 @@ int hfs_mdb_get(struct super_block *sb)
>  	HFS_SB(sb)->ext_tree =3D hfs_btree_open(sb, HFS_EXT_CNID, hfs_ext_keycm=
p);
>  	if (!HFS_SB(sb)->ext_tree) {
>  		pr_err("unable to open extent tree\n");
> -		goto out;
> +		return -EIO;
>  	}
>  	HFS_SB(sb)->cat_tree =3D hfs_btree_open(sb, HFS_CAT_CNID, hfs_cat_keycm=
p);
>  	if (!HFS_SB(sb)->cat_tree) {
>  		pr_err("unable to open catalog tree\n");
> -		goto out;
> +		return -EIO;
>  	}
> =20
>  	attrib =3D mdb->drAtrb;
> @@ -229,12 +232,6 @@ int hfs_mdb_get(struct super_block *sb)
>  	}
> =20
>  	return 0;
> -
> -out_bh:
> -	brelse(bh);
> -out:
> -	hfs_mdb_put(sb);
> -	return -EIO;
>  }
> =20
>  /*
> @@ -359,8 +356,6 @@ void hfs_mdb_close(struct super_block *sb)
>   * Release the resources associated with the in-core MDB.  */
>  void hfs_mdb_put(struct super_block *sb)
>  {
> -	if (!HFS_SB(sb))
> -		return;
>  	/* free the B-trees */
>  	hfs_btree_close(HFS_SB(sb)->ext_tree);
>  	hfs_btree_close(HFS_SB(sb)->cat_tree);
> @@ -373,6 +368,4 @@ void hfs_mdb_put(struct super_block *sb)
>  	unload_nls(HFS_SB(sb)->nls_disk);
> =20
>  	kfree(HFS_SB(sb)->bitmap);
> -	kfree(HFS_SB(sb));
> -	sb->s_fs_info =3D NULL;
>  }
> diff --git a/fs/hfs/super.c b/fs/hfs/super.c
> index 47f50fa555a4..df289cbdd4e8 100644
> --- a/fs/hfs/super.c
> +++ b/fs/hfs/super.c
> @@ -431,10 +431,18 @@ static int hfs_init_fs_context(struct fs_context *f=
c)
>  	return 0;
>  }
> =20
> +static void hfs_kill_super(struct super_block *sb)
> +{
> +	struct hfs_sb_info *hsb =3D HFS_SB(sb);
> +
> +	kill_block_super(sb);
> +	kfree(hsb);
> +}
> +
>  static struct file_system_type hfs_fs_type =3D {
>  	.owner		=3D THIS_MODULE,
>  	.name		=3D "hfs",
> -	.kill_sb	=3D kill_block_super,
> +	.kill_sb	=3D hfs_kill_super,
>  	.fs_flags	=3D FS_REQUIRES_DEV,
>  	.init_fs_context =3D hfs_init_fs_context,
>  };


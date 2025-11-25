Return-Path: <linux-fsdevel+bounces-69846-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F9A0C8759F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Nov 2025 23:37:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 711E33450A3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Nov 2025 22:37:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AACB32D0D2;
	Tue, 25 Nov 2025 22:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ttE3jGID"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E32F32ED872;
	Tue, 25 Nov 2025 22:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764110223; cv=fail; b=kWB8EefclqDSKCqxeOqG5pBZCM6L/3otCj4T/ckAgwv8sp1pFSSRfJW3R+KQAJP698yN/R+wcn0Dzoy3QzT7UugvG/FHNCDUSOlOn7SYmv58guNliMVDGYHUJbBffrv+xiJbJLRInluKeypriq1Xgqjz4Kjq8L5j6b5+vFFgqic=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764110223; c=relaxed/simple;
	bh=hyT0hmokgPg3O7604/wJ2dQIIc4UjXuT9DNK2g24Nh4=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=qWn7LEEAxecblodDBh+/AHwM3ivTVONqJC/nt9NccYVBYDjOS5a/WWSAkWfXsappqwjxW9FdQlXGyoNpmhRtdHheJjVSr5wRMmxGL0Vkat50J6GjhkGqt/bw4LdwfUb8fHKNcYGbbLliZbl9TYlfE9oDO2sWJMMs6iu7lOlbLrw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ttE3jGID; arc=fail smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5APEvbpx015710;
	Tue, 25 Nov 2025 22:36:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pp1; bh=hyT0hmokgPg3O7604/wJ2dQIIc4UjXuT9DNK2g24Nh4=; b=ttE3jGID
	z0tnP+GtkEe4FL6AUEafZF7Pam9j5kdtXt8XrkjfS9MfJWHw9CxXdh1KCtwP9u9A
	fsu7zLNOWBUhqgr7ZIX6nSZRoNVfs0HdCB4x6VaVq+CKcflaJ97IlrQmpaIjjwny
	dQBvu0McOCV0fiphbfT8cPDaGWOwrj10FcZkWxTMbjrc9d8W+ppZ4hVjYg/kqpCC
	Q4NTYSZpyrIS2ls5Z7kN7WMcZizwcatmNOeTeqJt5CgAO955uN4vXj7cipxqw/s0
	ETSIaNXuE0Cb85LOa5m6w8A4GBeaeJZ0J8RIL7XLlFWIHFuZJafZSk8BLORWdcGU
	K0z98lGjNrt7PQ==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ak4uv8f18-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 25 Nov 2025 22:36:49 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5APMamuC020574;
	Tue, 25 Nov 2025 22:36:48 GMT
Received: from ph7pr06cu001.outbound.protection.outlook.com (mail-westus3azon11010005.outbound.protection.outlook.com [52.101.201.5])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ak4uv8f14-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 25 Nov 2025 22:36:48 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QJtKows6LRAga7GunXLOqCuQ+dn8Zam37eZ1dqq/5579FCN7557fwisrBIPo8akN3JQ/PS5Gl4UNGsgGt3ddSgqEXM+HHHQRpcne3WNBe2dBnA+RadsfhNN6rVfUfeAjDcHcgh7Net+T/uT7Fz/kKlC6JZ8t6kfJhxRZ8djqNIC45cJb3R80RbHLhDjWMKBG+9j/mnB1v8cLqG82QHQ+bYdgbiSCPJAkfZ7oynOPHp8GRYTSn62c/xiI7FDFI8CUbbJ40g+9wux7NiJy9FgNDpxu30Y/eEq9d93akBX57V36Te58StiiIvMAlpiHtBLRS/QVkGPyJ/sJFh9+okQXKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hyT0hmokgPg3O7604/wJ2dQIIc4UjXuT9DNK2g24Nh4=;
 b=sy1PKqtU1quryH+8145L0lK2t8YnWFIlR3nozBf40cvoCADQKWh3hxV/VELQLBDl0VGt2gACxyu7La4bWSI8IlRBx6RWsW9IRDZmftTxp6ysbOJHzXF20XGjYS3l5wWhYd+uvhsoVswSSOeVZa5t3xwc2M3W+pf4S/0I+1ziajwgiOvrBN+NNVW9M9wzd3+Z29Fp+M0CoA1f/jpDxpnN5pAs/gqG9c+P8/h5bbxcX/Gr2h/vYaxYD0HrKYPcFcQ1ZlGATAaVDkfPS96csEccy8/K6Qf4dt04umwrmtrQvC0w72pTRgCjSDrywSJO1Ygn5yYghNP3ydcKPTtxOyN4cQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SA1PR15MB5819.namprd15.prod.outlook.com (2603:10b6:806:338::8)
 by SA1PR15MB6965.namprd15.prod.outlook.com (2603:10b6:806:4be::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.17; Tue, 25 Nov
 2025 22:36:46 +0000
Received: from SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539]) by SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539%4]) with mapi id 15.20.9343.016; Tue, 25 Nov 2025
 22:36:46 +0000
From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
To: "jack@suse.cz" <jack@suse.cz>,
        "glaubitz@physik.fu-berlin.de"
	<glaubitz@physik.fu-berlin.de>,
        "slava@dubeyko.com" <slava@dubeyko.com>,
        "frank.li@vivo.com" <frank.li@vivo.com>,
        "mehdi.benhadjkhelifa@gmail.com"
	<mehdi.benhadjkhelifa@gmail.com>,
        "brauner@kernel.org" <brauner@kernel.org>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>
CC: "syzbot+ad45f827c88778ff7df6@syzkaller.appspotmail.com"
	<syzbot+ad45f827c88778ff7df6@syzkaller.appspotmail.com>,
        "linux-kernel-mentees@lists.linuxfoundation.org"
	<linux-kernel-mentees@lists.linuxfoundation.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "david.hunter.linux@gmail.com" <david.hunter.linux@gmail.com>,
        "skhan@linuxfoundation.org" <skhan@linuxfoundation.org>,
        "khalid@kernel.org"
	<khalid@kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Thread-Topic: [EXTERNAL] Re: [PATCH v2] fs/hfs: fix s_fs_info leak on
 setup_bdev_super() failure
Thread-Index:
 AQHcWxbjI2wNRsxXGEmG7hnNwSoKY7T9oaoAgAAaLgD///OkAIAAFCeA///ybQCAABMBgP//9kwAAMeFuAAAAMetAA==
Date: Tue, 25 Nov 2025 22:36:46 +0000
Message-ID: <6e1bb0361c7e675f971fc322b061fef6e9c7413e.camel@ibm.com>
References: <20251119073845.18578-1-mehdi.benhadjkhelifa@gmail.com>
	 <c19c6ebedf52f0362648a32c0eabdc823746438f.camel@ibm.com>
	 <3ad2e91e-2c7f-488b-a119-51d62a6e95b8@gmail.com>
	 <8727342f9a168c7e8008178e165a5a14fa7f470d.camel@ibm.com>
	 <15d946bd-ed55-4fcc-ba35-e84f0a3a391c@gmail.com>
	 <148f1324cd2ae50059e1dcdc811cccdee667b9ae.camel@ibm.com>
	 <6ddd2fd3-5f62-4181-a505-38a5d37fa793@gmail.com>
	 <960f74ac4a4b67ebb0c1c4311302798c1a9afc53.camel@ibm.com>
	 <28fbe625-eb1b-4c7f-925c-aec4685a6cbf@gmail.com>
	 <218c654fc2cad8f6acac1530d431094abb1bffbe.camel@ibm.com>
	 <b2fcff21-2b5a-486a-976f-4a5ff4337d72@gmail.com>
In-Reply-To: <b2fcff21-2b5a-486a-976f-4a5ff4337d72@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5819:EE_|SA1PR15MB6965:EE_
x-ms-office365-filtering-correlation-id: be673c36-6d8e-452c-eb8b-08de2c731dea
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|10070799003|7416014|376014|366016|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?TFBPMmp2KzdVS0JvM1RtNUhTeDgwdEVicU1PTmkzYkhJQVlVSGhjZGpQQ3h1?=
 =?utf-8?B?NUV1Nlg3U0Nqb1hDYjR1bCtPOUxJcE91Q3lSekFzLyszcTAwL0dUYkRPSzM2?=
 =?utf-8?B?K1MyM1lJS3p3SHo1dytST3hqVmNRM215ZDkzQnI4cUxvM0I4dW1aU1laQW4v?=
 =?utf-8?B?RFZUVWlDQ3pkZDFXcEFQRnU3Q1VmdlFqb0hwZkxZS2JLRXBubklDdmhqV1NS?=
 =?utf-8?B?cjY3TG1hUkVyMkJNa20yZjB3OWk2Z0pMeTVNelRYM0VNTUJLcm5CdXlDTmdO?=
 =?utf-8?B?L0NuS1krdVQxSWhJUTVBYTFPbHJMTkM0elRuclV4bDE1clpkWjVzcEJiTFp6?=
 =?utf-8?B?V2JSQWUxQWdhREhxcmNFbkdsM1BxbkF5dDlMTzdJMzZYYVVOSXZsdktZcFJn?=
 =?utf-8?B?MUxhcmVtZTVxKy9tUnc0amJ3YmVUbkw0cHoyZk5EWHdXc1lCaWh2Uit0TEpw?=
 =?utf-8?B?ZUZzWlc2NEx4cGhiQklKa3A2M1l4Q2FkZk9PZEpiUjBjYzdPL1NKR1RUcVJH?=
 =?utf-8?B?T1RXZi9nUWRJWWRkQStGd2k1UGdYeVdzMVU4cnRtN0Fwb29jQjBDbXNXWSs5?=
 =?utf-8?B?azBRMjNqOVpHUVJTcVVsSHE5S082dUVNVG53UGMrZ0JCbm5FbVlqZE9YYXJj?=
 =?utf-8?B?WmNWRFd5dUpHQ0NLZ013M0lXME50L0l2bklEVWx4MmFjbkhkNHhmMHU3R2lH?=
 =?utf-8?B?WmoxNXg4ZVZJTnZXYlNURC80MDZOeVlXQ2FCZVdCV0J5RTBQZGxEUWxnbTRy?=
 =?utf-8?B?d0xGUWs3dndJRHlHZkczOXRYV0xqWGh2Q25GZHN5aUZlZW4rMDdNSTh1NmFQ?=
 =?utf-8?B?VGVIT2RobUczcld1OGNMMVNVZGlzd05scWV5UjNORmxJT2FmUVJnVEk3aG1D?=
 =?utf-8?B?VFlpcXBYVXhzcmNaTE9TS0pZKzZCclpWME41T0FPcWxSVjB2RE9JUHo1WXMw?=
 =?utf-8?B?Z0pjMmwrR0lMQTdVcThNUDlHRHJPWmJJZ290Q1ArQ3RSMzR1MmhrRlRRcE9D?=
 =?utf-8?B?aElYckF5bUYrSDVFWGFCUFlVdFBlRTE4YnlWSzdhYXMyRXlGZFZnNDZnU2hN?=
 =?utf-8?B?ZXpyRG9NeG9ZeTJrWVVPWWNGQ1UxeE4xSGhwRThCQjJDVk91Z3JIS0psNU9N?=
 =?utf-8?B?Sm9TYzF6N0hFTE05Z0doMG1aZWkyYXF1NVRJRXZwNUZETkVMS0tIM2xNbUJK?=
 =?utf-8?B?SlQydk9sVURyVkw4RUdPbmNweFlFL0dIam8zVUxPRVRpWE05YXRjRjJtWHhp?=
 =?utf-8?B?QSs2VlRQOFJraWFXaFVISVRPMTkyZEd1ZXBTdXJ2N3ZWb25zTVFIVWpPVU1R?=
 =?utf-8?B?Mkp2a3hMSS9pMDJmTTAxUk5jUmdQV1BYNDdBQitUQmpka3B1a3ZhdzVVRHdZ?=
 =?utf-8?B?clRIV2ZuOTRnVk5MRmtBUzFEdUdETDl1UTBaak5nbWwyb1ZlWk9wTTlGNFZK?=
 =?utf-8?B?cVJaR0FidHpITVN4NWR6SnpQZm9ZenI1VWpCZ05UdXN4di8wdW8wSFMrUUFi?=
 =?utf-8?B?QlFNQ25IM01jLzVjQVFqNmdiTWQ4cG5pd2RKQkdCRGlXanRrZmpUZWJXYzZW?=
 =?utf-8?B?eFJ4eHhzcVI3OElHVUdhWHJ1eCtPT29hdjNWT3RmSVJRcklCRnJLdzFFbVEr?=
 =?utf-8?B?anRJelRqRWxlUW9IN2RUc29KVHlBQVVYVDlYV2ZOQ0Q2cXFXK0tpL0RzWWh6?=
 =?utf-8?B?Q3VJU0N6YWhNSDlpb0dYTThRdSttUUgrL0xDUm5yWTBZZWJGYW5pemQvMzBX?=
 =?utf-8?B?MXlqalF3bmlWZGtjSDlWUEVaREk4bXl0cjRpM0ZxV2RtMkwxVkVWdkdXSFo2?=
 =?utf-8?B?WndWZUlJaXI2TzlDdlA3WVhpOHV3dmg2OGEzUVFQd3hNVXNHNGtBVFc2NW0y?=
 =?utf-8?B?dVpLdXBPV1Uvb0NTdlNJRU5URkNqWWZBUDcwK1FQdDJSa2Y3c3BZalh3bW1T?=
 =?utf-8?B?MlRTazlhc0dBNFZWVHQrOEYyWjVPTTVXYko4dDcxOTZRdTBRTkFJQWxZYk9y?=
 =?utf-8?B?cUxEbjU1aUpKd3dIeU9SbnZIalczeW1ENmo4a1lyeVpBeXF2WUkrc2xjSzc1?=
 =?utf-8?Q?xzH9eJ?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5819.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(7416014)(376014)(366016)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?TlFxSFJzcjBaWVpDczVSemVVRnlJaWJrNldKS0RhWWc1bG0zVmQrdHd1NTNK?=
 =?utf-8?B?YmhDdUlhc2hMellVWFNYekVZWVNmV1RwSThpYUlCY3E0blZWWStiQW5MNkxW?=
 =?utf-8?B?blIwQUUvMnZwTG9DaVdZT1FKOERkUWlQTFkrTmdCcVNNZmo5QmxlL29IWUlQ?=
 =?utf-8?B?SVBadXkrQXg3TUg3MjB0NjRKdGZud3IrdmRGNGF0Zis2M0Q3VWtxV2w0Tk9Q?=
 =?utf-8?B?aENXek5pKzFNdU92ODJaWW1ZMi84WkpPWUU4ditiR2s1UHBuRmpxSnpTRXRD?=
 =?utf-8?B?WHpwRjRzZlNPaXBNT0EySktvK1BZUmJpZTRNaThFSG5jSVF3SFFVVjFITFBO?=
 =?utf-8?B?UUJXeGY3MkN6L3NhWEE0T0lJVHFlUFhIQ3M5WFA3U1c1clFUaGtIVnNFV0l4?=
 =?utf-8?B?Q0RQa2VvaWY3Z3ZjeHNoSDE5NlcybHNWaEVmRmJ1NVVML2k4VmhkZjJQYkZF?=
 =?utf-8?B?aWd0UTZhOTBKTk1rOWZYeHJEeVhBaWFqWWQ3a3RRZ3JZbSs3ZUNKQWJYZUR6?=
 =?utf-8?B?OWVzMWxvbHMrSzNnMFV5dXpHU0xpUTZjeUlieTdhdkFqT0dkaUxOWEJQdEtL?=
 =?utf-8?B?WmFxd2dwTTUzMVZhMUh1N29INlJwdS9VRjNtRi90NUZZd3ZKWFM2TzZxSGhj?=
 =?utf-8?B?YWNDMzcyV1pMZTBUd0N4VnZFb3gybC90TUlTUjJzTkNwaHBGeVNaS1M4Wi91?=
 =?utf-8?B?QUpPbDNzOTY4MVpvNElqdkFlVU5TUjNHbXZIZ2pSbGdIL3JtTXQwaExicEt0?=
 =?utf-8?B?TG9reGk4L2hkMlFweFFCR0NjbnIyaGQrZlFyWmFwcEJKdGVJc1dxY1lUTi9C?=
 =?utf-8?B?UWFWbVRpUkNRU2xtZXh5V3ZRb2w2T0dvOGZmTmk0RnRIUGtaU3E1Sy9IYk9B?=
 =?utf-8?B?OGVETDlyQk14S1JwQ21NY3lybmxkVnRHck1wZzdBVmllREFMbmI2QjIvTWpi?=
 =?utf-8?B?OVcvTUFVTkJvSFphNlRkOU9JcCtzb3JiMTNZTklIdHczWDIwcDRRY2tqd002?=
 =?utf-8?B?a0EyYWsxMU9JTk9BV1ZyTW41MXJiYUNkTDhEOTJmelc4MFVSemtmcG0wZGxk?=
 =?utf-8?B?Ni9DZVgxR3RnS0JqMG1qUWx1a2VxYjhuTGd4Lythd3lCVmhIYXZYTGI2aEsy?=
 =?utf-8?B?SDgrNTdmTm5Ga2lhdGF6UmY3UE5MTTVCSzJHVlg1bUVORFkwb0M4clc0ZnFt?=
 =?utf-8?B?aW1mMlZCN25ha0JEZHVFVzhtcDl1S0kvMUJrR0t0citYV2dCWkNNUlFEYldt?=
 =?utf-8?B?YmxUU0JEVnNqVUxPbTZCN056aTVzT1MwQTUzYWtncERReFNHL1EyRkFXK0xx?=
 =?utf-8?B?akpLd01aak5uRDVoZGxUWm1nTFFOOHYwLzFDNDhyWWZoZlVXUzNtSHNBL3kz?=
 =?utf-8?B?QzBJZk54UlVkN09HRVREaWdYRm9Lbm5ReWRnTVRXKzdCM0xicit3WXRUb01i?=
 =?utf-8?B?OUttQlp1VzhlcHhhR0dvSStod2hmS1dQMzdTdEJ4RENCazJVbnh6RkRUZk83?=
 =?utf-8?B?Zjg1OWtTQTZqMGNMSk10dzRCTk80dzRIbDRyUlZKc2pnOCthbk54L3Y2dllG?=
 =?utf-8?B?T0hFOG9oQjhZd2JEVllFSFViRGJrODdIVEY3bFJkaVZiN2JtcFZBRTB5OEkv?=
 =?utf-8?B?aExCZ1NkRTRRRTEwNXFTM0hpWVR5UE9sNHZaY0tZNTlQbDNVb0VrYkZSUTFp?=
 =?utf-8?B?T3lHdFhFOVVVR01pOVJrYWFtbFVleFlleTFGa3pWbVJMSk1OSDNmNkpWRFR5?=
 =?utf-8?B?TEtKQ3lmU2Zob0l1RUYvZ25DWjlldHIvNHprd0ZMZytkOElrZ251YVU2NDVC?=
 =?utf-8?B?cDU2Smt1cThZYU5xc2hQMnFUQzVBMUc1Z0JyTEZDTXB5QVlxaVZjL1k2YnRX?=
 =?utf-8?B?MVZWUjFXcW1GUUo1VTNvRjQ1K0V2YkpNVFVXRU9EWG53R1BFdUNwSEVGeUdx?=
 =?utf-8?B?aHBabkxDMWFiZlJDZzZOYnJmY1VJNEFRelNmbnowOTh2cUtua3NtcW5tK2tw?=
 =?utf-8?B?ckNtd2dTdnB4eHQ5bWd0UnR0bENWa2wwS3IybFpIM3NnVTVGcFd1TEJwZnZy?=
 =?utf-8?B?b1lWbVRIMWpBK3lnWFZKYU9YQVNhU2wyNFpwQVhKVHpub3o5ektMVkJrSTdV?=
 =?utf-8?B?NFVBTDdMa0ZTbnVvZ2phV1BHektwaHBSZnRtbU51K1NqMjU0N0F4RlBBWS92?=
 =?utf-8?Q?PtL/t9fJj2NWDu49NyHqD/Y=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9E6E2F4BD430A84C8640E49C109D8147@namprd15.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: be673c36-6d8e-452c-eb8b-08de2c731dea
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Nov 2025 22:36:46.7371
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dqTbSzRXgbv4Yiz2eaLeYxGm2Ve9geH00ts/5h8B7ULQiYC1QmDTEzsFKlGbMEYyVj1sYCMhDy/EeG4CLLLFDw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR15MB6965
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTIyMDAyMSBTYWx0ZWRfX1war1raFZ7eh
 1rgZmmVov5dwSTaP267aAgF59+7rKmpOV6t+k6Cxo34+jQdwicAFnlVQtCuz4fBEUIL9huhwhOo
 B79OnK5AuNk/jsdPttspYjfU8nJyh7PLhQtWlQIWaFFqC7SHOE3pK9Tm5xGBxKiLpRu5pSv18N0
 MZX4Es7ah3fO+0Ex6KDclwvjXvm2PcqomVtsbLvYSQ/XpEbOSm63DFoU1x4tOKGoHLRSRxeKo+I
 egegJkcxFowTnuHo2iGKmXJZe5mg4rZ42lfKeE1WjUO7YJ0fzMC6k9WjqqVtedTm1WMfbpjtKkx
 m0dkwgJ7YUl6U4AetQcGKDScSsvDvyUu864IZywA4jtk4z3m4vd9rxRCCM+76PGIyLgjji576Vl
 F+ToURX5Ta/mn67xNijdEdEcQrlmng==
X-Authority-Analysis: v=2.4 cv=PLoCOPqC c=1 sm=1 tr=0 ts=69262f81 cx=c_pps
 a=q0do3moUNMjvKVsQ3EtoVg==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=4xqPWh2aPB-PRFhOWRoA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: vz8kTCSqKFSsgwW5PlArqc9iOh0I-_zT
X-Proofpoint-GUID: OJsetHLvv4_iGAjZaItEbpr2eWdPOukG
Subject: RE: [PATCH v2] fs/hfs: fix s_fs_info leak on setup_bdev_super()
 failure
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-25_02,2025-11-25_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 spamscore=0 adultscore=0 impostorscore=0
 priorityscore=1501 bulkscore=0 malwarescore=0 clxscore=1015 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2511220021

T24gVHVlLCAyMDI1LTExLTI1IGF0IDIzOjE0ICswMTAwLCBNZWhkaSBCZW4gSGFkaiBLaGVsaWZh
IHdyb3RlOg0KPiBPbiAxMS8yMi8yNSAxMjowMSBBTSwgVmlhY2hlc2xhdiBEdWJleWtvIHdyb3Rl
Og0KPiA+IE9uIFNhdCwgMjAyNS0xMS0yMiBhdCAwMDozNiArMDEwMCwgTWVoZGkgQmVuIEhhZGog
S2hlbGlmYSB3cm90ZToNCj4gPiA+IE9uIDExLzIxLzI1IDExOjI4IFBNLCBWaWFjaGVzbGF2IER1
YmV5a28gd3JvdGU6DQo+ID4gPiA+IE9uIFNhdCwgMjAyNS0xMS0yMiBhdCAwMDoxNiArMDEwMCwg
TWVoZGkgQmVuIEhhZGogS2hlbGlmYSB3cm90ZToNCj4gPiA+ID4gPiBPbiAxMS8yMS8yNSAxMTow
NCBQTSwgVmlhY2hlc2xhdiBEdWJleWtvIHdyb3RlOg0KPiA+ID4gPiA+ID4gT24gRnJpLCAyMDI1
LTExLTIxIGF0IDIzOjQ4ICswMTAwLCBNZWhkaSBCZW4gSGFkaiBLaGVsaWZhIHdyb3RlOg0KPiA+
ID4gPiA+ID4gPiBPbiAxMS8yMS8yNSAxMDoxNSBQTSwgVmlhY2hlc2xhdiBEdWJleWtvIHdyb3Rl
Og0KPiA+ID4gPiA+ID4gPiA+IE9uIEZyaSwgMjAyNS0xMS0yMSBhdCAyMDo0NCArMDEwMCwgTWVo
ZGkgQmVuIEhhZGogS2hlbGlmYSB3cm90ZToNCj4gPiA+ID4gPiA+ID4gPiA+IE9uIDExLzE5LzI1
IDg6NTggUE0sIFZpYWNoZXNsYXYgRHViZXlrbyB3cm90ZToNCj4gPiA+ID4gPiA+ID4gPiA+ID4g
T24gV2VkLCAyMDI1LTExLTE5IGF0IDA4OjM4ICswMTAwLCBNZWhkaSBCZW4gSGFkaiBLaGVsaWZh
IHdyb3RlOg0KPiA+ID4gPiA+ID4gPiA+ID4gPiA+IA0KPiA+IA0KPiA+IDxza2lwcGVkPg0KPiA+
IA0KPiA+ID4gPiA+ID4gPiA+IA0KPiA+ID4gPiA+ID4gPiBJSVVDLCBoZnNfbWRiX3B1dCgpIGlz
bid0IGNhbGxlZCBpbiB0aGUgY2FzZSBvZiBoZnNfa2lsbF9zdXBlcigpIGluDQo+ID4gPiA+ID4g
PiA+IGNocmlzdGlhbidzIHBhdGNoIGJlY2F1c2UgZmlsbF9zdXBlcigpIChmb3IgdGhlIGVhY2gg
c3BlY2lmaWMNCj4gPiA+ID4gPiA+ID4gZmlsZXN5c3RlbSkgaXMgcmVzcG9uc2libGUgZm9yIGNs
ZWFuaW5nIHVwIHRoZSBzdXBlcmJsb2NrIGluIGNhc2Ugb2YNCj4gPiA+ID4gPiA+ID4gZmFpbHVy
ZSBhbmQgeW91IGNhbiByZWZlcmVuY2UgY2hyaXN0aWFuJ3MgcGF0Y2hbMV0gd2hpY2ggaGUgZXhw
bGFpbmVkDQo+ID4gPiA+ID4gPiA+IHRoZSByZWFzb25pbmcgZm9yIGhlcmVbMl0uQW5kIGluIHRo
ZSBlcnJvciBwYXRoIHRoZSB3ZSBhcmUgdHJ5aW5nIHRvDQo+ID4gPiA+ID4gPiA+IGZpeCwgZmls
bF9zdXBlcigpIGlzbid0IGV2ZW4gY2FsbGVkIHlldC4gU28gc3VjaCBwb2ludGVycyBzaG91bGRu
J3QgYmUNCj4gPiA+ID4gPiA+ID4gcG9pbnRpbmcgdG8gYW55dGhpbmcgYWxsb2NhdGVkIHlldCBo
ZW5jZSBvbmx5IGZyZWVpbmcgdGhlIHBvaW50ZXIgdG8gdGhlDQo+ID4gPiA+ID4gPiA+IHNiX2lu
Zm8gaGVyZSBpcyBzdWZmaWNpZW50IEkgdGhpbmsuDQo+ID4gPiA+IA0KPiA+ID4gPiBJIHdhcyBj
b25mdXNlZCB0aGF0IHlvdXIgY29kZSB3aXRoIGhmc19tZGJfcHV0KCkgaXMgc3RpbGwgaW4gdGhp
cyBlbWFpbC4gU28sDQo+ID4gPiA+IHllcywgaGZzX2ZpbGxfc3VwZXIoKS9oZnNwbHVzX2ZpbGxf
c3VwZXIoKSB0cnkgdG8gZnJlZSB0aGUgbWVtb3J5IGluIHRoZSBjYXNlIG9mDQo+ID4gPiA+IGZh
aWx1cmUuIEl0IG1lYW5zIHRoYXQgaWYgc29tZXRoaW5nIHdhc24ndCBiZWVuIGZyZWVkLCB0aGVu
IGl0IHdpbGwgYmUgaXNzdWUgaW4NCj4gPiA+ID4gdGhlc2UgbWV0aG9kcy4gVGhlbiwgSSBkb24n
dCBzZWUgd2hhdCBzaG91bGQgZWxzZSBuZWVkIHRvIGJlIGFkZGVkIGhlcmUuIFNvbWUNCj4gPiA+
ID4gZmlsZSBzeXN0ZW1zIGRvIHNiLT5zX2ZzX2luZm8gPSBOVUxMLiBCdXQgYWJzZW5jZSBvZiB0
aGlzIHN0YXRlbWVudCBpcyBub3QNCj4gPiA+ID4gY3JpdGljYWwsIGZyb20gbXkgcG9pbnQgb2Yg
dmlldy4NCj4gPiA+ID4gDQo+ID4gPiBUaGFua3MgZm9yIHRoZSBpbnB1dC4gSSB3aWxsIGJlIHNl
bmRpbmcgdGhlIHNhbWUgbWVudGlvbm5lZCBwYXRjaCBhZnRlcg0KPiA+ID4gZG9pbmcgdGVzdGlu
ZyBmb3IgaXQgYW5kIGFsc28gYWZ0ZXIgZmluaXNoaW5nIG15IHRlc3RpbmcgZm9yIHRoZSBoZnMN
Cj4gPiA+IHBhdGNoIHRvby4NCj4gPiA+ID4gDQo+ID4gDQo+ID4gSSBhbSBndWVzc2luZy4uLiBT
aG91bGQgd2UgY29uc2lkZXIgdG8gaW50cm9kdWNlIHNvbWUgeGZzdGVzdCwgc2VsZi10ZXN0LCBv
cg0KPiA+IHVuaXQtdGVzdCB0byBkZXRlY3QgdGhpcyBpc3N1ZSBpbiBhbGwgTGludXgncyBmaWxl
IHN5c3RlbXMgZmFtaWx5Pw0KPiA+IA0KPiBZZXMsIEl0IGlzbid0IHRoYXQgaGFyZCBlaXRoZXIg
SUlVQyB5b3UganVzdCBuZWVkIHRvIGZhaWwgdGhlIA0KPiBiZGV2X2ZpbGVfb3Blbl9ieV9kZXYo
KSBmdW5jdGlvbiBzb21laG93IHRvIHRyaWdnZXIgdGhpcyBlcnJvciBwYXRoLi4NCj4gPiBUaGFu
a3MsDQo+ID4gU2xhdmEuDQo+IA0KPiBTbyBJIHdhbnRlZCB0byB1cGRhdGUgeW91IG9uIG15IHRl
c3RpbmcgZm9yIHRoZSBoZnMgcGF0Y2ggYW5kIHRoZSANCj4gaGZzcGx1cyBwYXRjaC4gRm9yIHRo
ZSB0ZXN0aW5nIEkgdXNlZCBib3RoIG15IGRlc2t0b3AgcGMgYW5kIG15IGxhcHRvcCANCj4gcGMg
cnVubmluZyB0aGUgc2FtZSBjb25maWd1cmFpdG9ucyBhbmQgdGhlIHNhbWUgbGludXggZGlzdHJp
YnV0aW9uIHRvIA0KPiBoYXZlIG1vcmUgYWNjdXJhdGUgdGVzdGluZy4gVGhlcmUgYXJlIHRocmVl
IHZhcmlhbnRzIHRoYXQgSSB1c2VkIGZvciANCj4gdGVzdGluZyA6IEEgc3RhYmxlIGtlcm5lbCwg
Ni4xOC1yYzcga2VybmVsIHdpdGggbm8gcGF0Y2gsIDYuMTgtcmM3IA0KPiBrZXJuZWwgd2l0aCBo
ZnMgb3IgaGZzcGx1cyBwYXRjaC4NCj4gDQo+IEZpcnN0bHksIEkgY291bGRuJ3QgcnVuIHRoZSBo
ZnMgdGVzdHMgZHVlIHRvIG1rZnMuaGZzIGJlaW5nIHVuYXZhaWxhYmxlIA0KPiBpbiBteSBzZWFy
Y2ggZm9yIGl0LiB0aGV5IGFsbCBwb2ludCB0byBta2ZzLmhmc3BsdXMgYW5kIHlvdSBwb2ludGVk
IG91dCANCj4gdGhhdCBta2ZzLmhmc3BsdXMgY2FuIGNyZWF0ZSBoZnMgZmlsZXN5c3RlbXMgd2l0
aCB0aGUgLWggZmxhZyBidXQgaW4gbXkgDQo+IGNhc2UgaXQgZG9lc24ndC4gSSBwb2ludGVkIG91
dCBsYXN0IHRpbWUgdGhhdCBJIGZvdW5kIGEgdG9vbCB0byBjcmVhdGUgDQo+IEhGUyBmaWxlc3lz
dGVtcyB3aGljaCBpdCBkb2VzIChpdCdzIGNhbGxlZCBoZm9ybWF0KSBidXQgdGhlIHhmc3Rlc3Rz
IA0KPiByZXF1aXJlIHRoZSBhdmFpbGFiaWxpdHkgb2YgbWtmcy5oZnMgYW5kIGZzY2suaGZzIGZv
ciB0aGVtIHRvIHJ1bi4gTW9yZSANCj4gaGVscCBvbiB0aGlzIGlzIG5lZWRlZCBmb3IgbWUgdG8g
cnVuIGhmcyB0ZXN0cy4gSSBhbHNvIHRlc3RlZCBleHQ0IGFzIA0KPiB5b3UgaGF2ZSBzdWdnZXN0
ZWQgYXMgYSBiYXNlIHRvIGNvbXBhcmUgdG8uIEhlcmUgaXMgbXkgc3VtbWFyeSBvZiB0ZXN0aW5n
Og0KPiANCj4gRm9yIFN0YWJsZSBrZXJuZWwgNi4xNy44Og0KPiANCj4gT24gZGVza3RvcDoNCj4g
ZXh0NCB0ZXN0cyByYW4gc3VjY2Vzc2Z1bGx5Lg0KPiBoZnNwbHVzIHRlc3RzIGNyYXNoIHRoZSBw
YyBhcm91bmQgZ2VuZXJpYyA2MzEgdGVzdC4NCj4gDQo+IE9uIExhcHRvcDoNCj4gZXh0NCBhbmQg
aGZzcGx1cyB0ZXN0cyByYW4gc3VjY2Vzc2Z1bGx5Lg0KPiANCj4gRm9yIDYuMTgtcmM3IGtlcm5l
bDoNCj4gDQo+IE9uIGRlc2t0b3A6DQo+IGV4dDQgdGVzdHMgcmFuIHN1Y2Nlc3NmdWxseSBzYW1l
IHJlc3VsdHMgYXMgdGhlIHN0YWJsZSBrZXJuZWwuDQo+IGhmc3BsdXMgY3Jhc2hlcyBvbiB0ZXN0
aW5nIHN0YXJ0dXAuRm9yIGxhdW5jaGluZyBhbnkgdGVzdC4NCj4gDQo+IE9uIExhcHRvcDoNCj4g
ZXh0NCB0ZXN0cyByYW4gc3VjY2Vzc2Z1bGx5IHNhbWUgcmVzdWx0cyBhcyB0aGUgc3RhYmxlIGtl
cm5lbC4NCj4gaGZzcGx1cyBjcmFzaGVzIG9uIHRlc3Rpbmcgc3RhcnR1cC5Gb3IgbGF1bmNpbmcg
YW55IHRlc3QuDQo+IA0KPiANCj4gRm9yIHRoZSBwYXRjaGVkIDYuMTgtcmM3IGtlcm5lbC4NCj4g
DQo+IFNhbWUgcmVzdWx0cyBmb3IgYm90aCBkZXNrdG9wIGFuZCBsYXB0b3AgcGNzIGFzIGluIHRo
ZSA2LjE4LXJjNyBrZXJuZWwuDQo+IA0KPiANCj4gU2hvdWxkIGJlIG5vdGVkIHRoYXQgSSBoYXZl
IHRyaWVkIG1hbnkgZGlmZmVyZW50IHNldHVwcyByZWdhcmRpbmcgdGhlIA0KPiBkZXZpY2VzIGFu
ZCB0aGVpciBjcmVhdGlvbiBmb3IgdGhlIDYuMTgtcmM3IGtlcm5lbCBhbmQgbm9uZSBvZiB0aGVt
IA0KPiB3b3JrZWQuU3RpbGwgSSBjYW4ndCBkZWR1Y2Ugd2hhdCBpcyBjYXVzaW5nIHRoZSBpc3N1
ZS5JZiB0aGV5IHdvcmsgZm9yIA0KPiB5b3UsIG15IG9ubHkgYXNzdW1wdGlvbiBpcyB0aGF0IHNv
bWUgZGVwZW5kZW5jeSBvZiB4ZnN0ZXN0cyBpcyBub3QgbWV0IA0KPiBvbiBteSBwYXJ0IGV2ZW4g
dGhvdWdoIEkgbWFkZSBzdXJlIHRoYXQgSSBkbyBjb3ZlciB0aGVtIGFsbCBlc3BlY2lhbGx5IA0K
PiB3aXRoIHJlcGVhdGVkbHkgZmFpbGVkIHRlc3RpbmcuLi4NCj4gDQo+IFdoYXQgY291bGQgYmUg
dGhlIGlzc3VlIGhlcmUgb24gbXkgZW5kIGlmIHlvdSBoYXZlIGFueSBpZGVhPw0KDQpXaGljaCBw
YXJ0aWN1bGFyIGNyYXNoIGRvIHlvdSBoYXZlPyBDb3VsZCB5b3UgcGxlYXNlIHNoYXJlIHRoZSBj
YWxsIHRyYWNlPw0KDQpMZXQgbWUgYnVpbGQgdGhlIGxhdGVzdCBrZXJuZWwgYW5kIHJ1biB4ZnN0
ZXN0cyBhZ2FpbiBvbiBteSBzaWRlLg0KDQo+IA0KPiBBbHNvIHNob3VsZCBJIHNlbmQgeW91IHRo
ZSBoZnNwbHVzIHBhdGNoIGluIG9uZSBvZiBteSBlYXJsaWVyIHJlcGxpZXNbMV0gDQo+IGZvciB5
b3UgdG8gdGVzdCB0b28gYW5kIG1heWJlIGFkZCBpdCB0byBoZnNwbHVzPw0KPiANCj4gDQoNCkxl
dCdzIGNsYXJpZnkgYXQgZmlyc3Qgd2hhdCdzIGdvaW5nIG9uIHdpdGggeGZzdGVzdHMgb24geW91
ciBzaWRlLg0KDQpUaGFua3MsDQpTbGF2YS4NCg==


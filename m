Return-Path: <linux-fsdevel+bounces-34587-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 89A469C66CC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Nov 2024 02:38:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A9701F25A79
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Nov 2024 01:38:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44D7A2B9A2;
	Wed, 13 Nov 2024 01:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="Aoh36QS6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6FEBBA34;
	Wed, 13 Nov 2024 01:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.153.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731461869; cv=fail; b=t9nGZK8fX3RbRa5u4YUVLqLA6E4gBlVzaK0q6d/4lXg7s/4ktiRqMpbLZyr/403Ygowj3FBj0kQp00rw3bVzhQyuUpOYervt8S3yFnHS7jn/HrDAT7NJfccrkTV+wup7lEWQGoCh9eUcd2i9kP+/cRpPbmqK7TI/WqYmrL3IaDw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731461869; c=relaxed/simple;
	bh=3Ev+ElLu2wiSTLeqq435V1MGyeaRUJif11Lqeb9qcaA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=fLRv3jXuSlH+is6t/kbBCK6J1wWNEmjVKXw6YMJfSpNPSVHzK3klM3YioNps3Omo+pkzbxfsFK2Ych5+ND42o1yxWrInUU3zDYDin0tmt9RtCu1H52gAd2ieilqrZKEentOa8B7oTXZcu2MVshINd3XWVGuehL6QA7zT7P98w0A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=Aoh36QS6; arc=fail smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4ACLmRAY002420;
	Tue, 12 Nov 2024 17:37:46 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	s2048-2021-q4; bh=3Ev+ElLu2wiSTLeqq435V1MGyeaRUJif11Lqeb9qcaA=; b=
	Aoh36QS68Fp4ElAz0IKDMLRYKfswCLLXA6eGOR36G5EWkw3LQqT4cYISnzl3y8uT
	6x1KiC+Bp33mtctADS2uyawF0Qs5p8/DSYNkQT8IC7BWluIuT6Ga+ONztP3quDJ2
	3BwCmaSFLVQrRxlfPn5GCtWxl3Bdt2wVP2cgQEIOS7XkKl+8Lzo0ixkV5W24ltin
	KygRc9vsEQp1poCXfdWlg7Zi9AJ0g/3P3RueeqBWubTiKmoaSd//h5RN0iC/F1WE
	V59oWopnmJ5HlUDolTRXpyDjsgIAXguS0CfKn+I6njUT64d9GI1XXDznXszzKaH1
	Ay/aqyT5vwf4j5LqLKOgUQ==
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2046.outbound.protection.outlook.com [104.47.57.46])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 42vf8ghdru-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 12 Nov 2024 17:37:46 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bb+/baAiTFYx2v/28VydI/Q03fMbG2dXvOpXmnIOA2xZ/hCaw9QdBdSrKxRY/N8d82b8LCYHVFVSa6jIMfmQco+b+wb3AuruiwcPTvxL5YhnnsDgZOZW+SjykfZx1gI3MLXMx5e4BJg+SNG2sLLvtXYMK6f4HvjxXaoJ8RGpKN0QG9W8VqBgohphnOE6qucWlQrs7ZXwDEAtsnLbfRCr72UZnmWSj7QSxTaiB1fWiRS6SOyHQ8smxssmptvNu2mX65ft5pyA78V1e5+5eSWq0YIn7k1IhtN1vobEy/GY2Bmr75Pgee7XnS3RWrukzJtt5vej5jR4bS9oLvkdIsE3iQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3Ev+ElLu2wiSTLeqq435V1MGyeaRUJif11Lqeb9qcaA=;
 b=xSHehgwUTeH7ZPdKtwZJZA60aXnzhxCzR2JdHWyxAqfDk5rPEH4H1MdhZxOO2t3zBQNXluiab77OeIiu2h0YYP3teTfz54vwZrKTG2/4Z5hPj/vZaUt+JCdcNuZ0K+DkqjWOc7RtdlAvfbTuiHSf43TvVB4Gb8ZJ3wfR3ngdOIPect5uIHh3saEHrrNJtvlI1cdYyN0XCRuF0AxOBdmyIktOMS66BCOBPFpQGbiACCfde7PmA6tlWc+5pwTmq1qTwMHWYzVSqdx30QqoDF1eAIxFmFN+1VsYipaIkVjT3H4F+bgH/UtlDR0YeESPOE/OVISQttaF0dxbti/eEYXBCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SA1PR15MB5109.namprd15.prod.outlook.com (2603:10b6:806:1dc::10)
 by SJ2PR15MB5669.namprd15.prod.outlook.com (2603:10b6:a03:4c0::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.28; Wed, 13 Nov
 2024 01:37:42 +0000
Received: from SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::662b:d7bd:ab1b:2610]) by SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::662b:d7bd:ab1b:2610%3]) with mapi id 15.20.8137.027; Wed, 13 Nov 2024
 01:37:42 +0000
From: Song Liu <songliubraving@meta.com>
To: Casey Schaufler <casey@schaufler-ca.com>
CC: Song Liu <songliubraving@meta.com>, Song Liu <song@kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org"
	<linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "linux-security-module@vger.kernel.org"
	<linux-security-module@vger.kernel.org>,
        Kernel Team <kernel-team@meta.com>,
        "andrii@kernel.org" <andrii@kernel.org>,
        "eddyz87@gmail.com"
	<eddyz87@gmail.com>,
        "ast@kernel.org" <ast@kernel.org>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "martin.lau@linux.dev"
	<martin.lau@linux.dev>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "brauner@kernel.org" <brauner@kernel.org>,
        "jack@suse.cz" <jack@suse.cz>,
        "kpsingh@kernel.org" <kpsingh@kernel.org>,
        "mattbobrowski@google.com"
	<mattbobrowski@google.com>,
        "amir73il@gmail.com" <amir73il@gmail.com>,
        "repnop@google.com" <repnop@google.com>,
        "jlayton@kernel.org"
	<jlayton@kernel.org>,
        Josef Bacik <josef@toxicpanda.com>,
        "mic@digikod.net"
	<mic@digikod.net>,
        "gnoack@google.com" <gnoack@google.com>
Subject: Re: [PATCH bpf-next 0/4] Make inode storage available to tracing prog
Thread-Topic: [PATCH bpf-next 0/4] Make inode storage available to tracing
 prog
Thread-Index: AQHbNNyP/8kz7bh9sEuMXmmPH8p6e7Kz8jgAgAAJuQCAAGvfgIAAB6yA
Date: Wed, 13 Nov 2024 01:37:42 +0000
Message-ID: <332BDB30-BCDC-4F24-BB8C-DD29D5003426@fb.com>
References: <20241112082600.298035-1-song@kernel.org>
 <d3e82f51-d381-4aaf-a6aa-917d5ec08150@schaufler-ca.com>
 <ACCC67D1-E206-4D9B-98F7-B24A2A44A532@fb.com>
 <d7d23675-88e6-4f63-b04d-c732165133ba@schaufler-ca.com>
In-Reply-To: <d7d23675-88e6-4f63-b04d-c732165133ba@schaufler-ca.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3826.200.121)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5109:EE_|SJ2PR15MB5669:EE_
x-ms-office365-filtering-correlation-id: 9f589879-5ed5-4d40-a4b9-08dd0383c439
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|7416014|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?R3gwNllsK1lJRGJSZm5KcDg5RnVodHJodkZBMm45WWRCamdSZldBc1pKRFFI?=
 =?utf-8?B?Z0xGRFdOS21qRWhGd0owcjg2ZmF6NGp2bnhld3FuL2o0djJvbXJPWkFSaWRG?=
 =?utf-8?B?aWxTcHIvdUZZaG9ia1MvRGE0bVhhR3FIU3hadGoyTVZQWis5L1ZTSjhuRkp1?=
 =?utf-8?B?bm1zNFFRSFNGQkFSVzVRMFRoVVhPaUdyeTNFMGNFV295NnNiOWEyQVJmN1Bz?=
 =?utf-8?B?NU5FYUZ5NkJvSzRtYW5wK01PMzZWNU16alFIbXc4OEViTmJTMFZyMy9GT21W?=
 =?utf-8?B?djlsY2NoM05wOWpURkdZNkt5ZTVKNC9LZ1pqUktIYXVyMktpVkZ3dVlMdTlv?=
 =?utf-8?B?S1hGeTZQRkNabUVCSVBtc1QzelQvaU1BSVlPWjYycEs3T0FSSGNnUjNxV2hh?=
 =?utf-8?B?SE0wOTVrTVdDczdNVWZ0WXBCMlNldXo5eXRRbVZMMWFaYmRSNWNXeFBJa1Zu?=
 =?utf-8?B?bkhMekpjNGRvbVp5UWpzNjh6TmNYL1R6bFJFejI0QTkxTWlHS1k0R2JpbEUv?=
 =?utf-8?B?RFdxQlk1alliSmFXNTg3MktCNCtmUk5lQVdVMGtZc3NGOFowaEZBcVNLNldU?=
 =?utf-8?B?bFRVelJIVExHOVBOTjJvNGNrbUtqYnVsdzZlUjdTcmxEQ1h5cFFTQVRva3ZB?=
 =?utf-8?B?VmZCRGk2VXdiU1pYS2tVemZkSDVGeWZyVVg3aUpvMDA3ZE10TFRCR0liN1By?=
 =?utf-8?B?dUNvazZOd2ZTYkV2UHdlTkY3VlpXZ2JRbERQMVZvZzFjNitORm1jc0UwZndY?=
 =?utf-8?B?SSszTFBxZVB3eFFUc0VJWkg5bkM4ak9NMllzV2QxeE5lUmdqVEhNTndlTU0z?=
 =?utf-8?B?LzZLQk1GRENiQkVsU09URlZNOExqN1NEVU9HMVh1UkFLNGQyUEhkTndRNWd4?=
 =?utf-8?B?UXB2UUoyM1ZpYXJoaHAxc25FUWhrSFNGMWJzSmkvamZLdEZhWXpDZ1Y3UGZa?=
 =?utf-8?B?eGVwcjg2Q0lsdld4RkJIWDNKb0tQb0JqU25YM2doeXZHRVhBWkJPWXhiU29l?=
 =?utf-8?B?cllXSkg0aVQvMnllTFVaek96N3pEbW1KUFBicXBYamRTWlhIaHFYL0JjTmpV?=
 =?utf-8?B?bXVJalkrSW02THFjZFpNa2oyR1loYVV4UkxiYkpzdUtSVjl6R1dSWDB4aXZm?=
 =?utf-8?B?emJtWUc1anpnd3U5RkR0SzNXRG1hdGszd29BMWFXaWE1UXF6LzBVWGRVK0pq?=
 =?utf-8?B?eDlDRjFCZ3oyR3VyUVVVSk9JVmQ3Y1dLQnJRTkhxUmwvYTVudWpFbVRVc1RV?=
 =?utf-8?B?OGliUDdCNXp5NHFXRG85VkZEdHR0VTh1b3k2cjZKSWlwMjIwOGIrT0RXYlQ5?=
 =?utf-8?B?NnZlSExVbzJCVkxGUENhcWdDNWVvR0N3aWNlTGtPQ0d0c2I0UHZ2OFgwVFBx?=
 =?utf-8?B?anJPS1l4ZDhJdGlHRnVJK0lxSkpBMUZqak9za0xIVkhWT2Q1bXR2dXFoWDl2?=
 =?utf-8?B?c1B2QVJsRTdKQ051eUhuRXFrM2U5anJsQ0I5RmNrcU9Wd3FiWnZITXZWUXRT?=
 =?utf-8?B?cXgxdjlvcG5MNEtYb0dhRzA5a1E2a1J4NUJJZThmK2RMVnRMbmN4MEFPZFpa?=
 =?utf-8?B?MUNDaUNhdWUrNlA5aFhCQWpDU3VjV3R6RndTNmFrNnErbzNMNkxCYTJmTitS?=
 =?utf-8?B?UmRkRDJHMmRZbXNZSmFuQXlFWEh6WUNMUkZhbW9EeWYxWDVzdU5Ec2wyd0gv?=
 =?utf-8?B?YkxiZWtOVHVQNzBzQWtQbnY3cWhGQVlRL21Ya1k2LzBiU0NCSStOMzZCdE1T?=
 =?utf-8?B?NDhwL0tET2plR0RxQ1lQZXJ3VDhwakRCRzRSUU1lTllXekN6cTdPZ1dFelpy?=
 =?utf-8?Q?FbQDDSGX9OT4B+MYCrv2sNnVgaKOUWD3CgZ5k=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5109.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?WTFieFJSVkVnL0dpOG5FZFJocFZMaENYOWlIVWU5NkRVUnZJY1ZKSHljWlE4?=
 =?utf-8?B?czU3Y3NERmQ4Z1R5OWZGMy9CVHZQazcrT0w3SlZqSHVCc0hGWDBjWG1hME1W?=
 =?utf-8?B?TjJVcmtPWWU0dEpxS2dIdlU3ZGhlNjNLaXgzbVIwVVNnMjFFRDNNbEhTbGQw?=
 =?utf-8?B?ZW9tZ05ESTJPR3RGSjY4TFBKbWVWaW1Nd2RudlNlTXZiaFJVY3J3L1Bzc3Vr?=
 =?utf-8?B?bHE4T3RtUnk4MlN6TmQ4bGdQY042eTFYUUNoUkNpNG1aN1ViYTlkcVRpVVZW?=
 =?utf-8?B?S3k1MEJ4WVVjVXhwUGRqZWNTUjZ6MmZnS0JJSGMzTUlxV1BKQnc2MEtDWkVa?=
 =?utf-8?B?TTIwdXJiSENEWjVLck1WaTdoTzBqZS95bDdMVUgybHBjZEhxWFF6TGw5YWpt?=
 =?utf-8?B?c1hscXlXSGxRMnF5aHRRVVdCVlV6T2YrRjJOdXp1RzdLc2N5MlEvczhYSFd3?=
 =?utf-8?B?R2tteFRxbm9sQ1BqYTJMVlRVSTJFUGphbURMc3ZmY2JQMExnci9sQW94TWVu?=
 =?utf-8?B?MjBIQnduVWFnQUJxR2Z2U1NucjlHT1ZIdmlNSUFqV0wyTWtoK25NSWQ5WmNH?=
 =?utf-8?B?eURQRm1CcytFWmp6NndDZEZLbG5USnZWWWhjUlVRS3VKenZabGJCWkpnNnJ4?=
 =?utf-8?B?ajNUNmVaZDQ1cXo0RFdIdDNDR2dtYzc4YkFwR1E2ZHBEckVjeTZSSDdZT1BS?=
 =?utf-8?B?Q2JrM3V6cy81ZFhXSkJEWVpSNjRXdWhETTMzMldlUWVmQVpLT2I0dUdlTWQ0?=
 =?utf-8?B?MVBBdkh0UXJkQzlTbDdOTGtycGtLRTZDRHk5bFdXMlFBQzZiS3p3QkhhMWY1?=
 =?utf-8?B?Rkw1Z0VXNDNlYXIwb2VMdm5VRDNHM095M0ttZnFsL2xpZHJaNHZvMzZSeWFF?=
 =?utf-8?B?N0s3YXFyTXRndGwzbFp1MlpaUHREQWpZeFlxVGY4bmNYdllpYjVHSXdoc2Yv?=
 =?utf-8?B?clZkZTVuWEZmeVZsbmIwdWExQ2MraDR0ei8yOWZnRGw2VytONU9iZVNvWm9T?=
 =?utf-8?B?YkZPUGJmQUFzNXNlLzFpcEJCRXVtV3JTaytpUXhSZVNlTEwvVUpodHJJMmhh?=
 =?utf-8?B?dER0akNKZVZ0a2Y3N29Xall0SG5PNkNkZ1JkditqQi9GSUMvL0xDK2JDTnF0?=
 =?utf-8?B?WHdOWktRa1J2blpaU3d2enEyZXhOK05YakllTng1S1doaWVLWEx3RklSdFpq?=
 =?utf-8?B?NjdGSFhUemR5T2tXTmh3dnBjeUI0V25TQ3lXRzdGSVlTUlJ0ZXdtaVhlenFG?=
 =?utf-8?B?VE9tbE9ydEFlbHFFNVRXNlFyY201bnExV3R1bnQwbnFSNzdYcDFYUE9jTGNn?=
 =?utf-8?B?MlJBKzFBMVlIQ0dNcW9CYVlPNDlBNCt0QTBGclVvUHNodFRmZ20xZjVXZzJi?=
 =?utf-8?B?RWcxN2tPWWRZbkFwMXFYQ1JWdzFHNnVhb3BLY1BmTVVjbnkzdzZ0NExMT1g3?=
 =?utf-8?B?WkVqMmZCS1hJUXoydlE0bGMweDIrb1RBRU5lWmJNSVkyMjBMQy9NZUt4S2hl?=
 =?utf-8?B?c1FjTGlBNDVXcmtPZVZMbHV6R0RCdG5RL2szR29Da3YwSC85a1lURGViK1ky?=
 =?utf-8?B?UUE0WEFNSCtUVE1HNHVMZERsY21TSDdGMzBqMGdHbUNxQkZpdnl3cUhNc2hK?=
 =?utf-8?B?akY2aC9WNndCRHhpTENRS0J2anpCN0dqY1I2dDd5dkh1bUZwRWRkQkdyZk5m?=
 =?utf-8?B?SXlTS09BNVhBSmlsU2thTVNZZ21GZnJ5RVlkcW5jOGpraEI1cXB4SUF3L0k5?=
 =?utf-8?B?Mm1ueXRQQ0Myb0FaT2pTNlNHN1V1Qjc2aGIxQy9CQ2oyUUxhbnFsdFRyQUZi?=
 =?utf-8?B?eHlmaVJLQmdoWStpVWg3ZGFSdjVYMmZmamdFWXVUdEZ2STdMdzkycUoyVHQ1?=
 =?utf-8?B?UXpFeFFBR0ZOTjUxdURpVWdYMzJyZGZrZVlMRHFoR2d3SkpJbmdzU0hpUW9y?=
 =?utf-8?B?OWMyZHB6Qk8yNmVCa1d2UmdSU1BZenI0cEsra2lCRUVkbVVEa2ZHZkl1d2ZY?=
 =?utf-8?B?SnV6UXp5am4rcVdtSVZBZGpjTUVnc0F3OFhGQXZhazdzY3BLMFl5M2FOK08x?=
 =?utf-8?B?SXdxbDFxRE9seFhUUnJBWEx3Q2JSRUl4djRLNlhrakl4eDQwUWZDenllVGIv?=
 =?utf-8?B?OHAxT2xjd0V3eWN1YzB2YUREemY2azI0Mk1kcE5VSXBwZ2x3OE0wMTNNMEU2?=
 =?utf-8?B?emc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9544A09E5EF0AD4DA9DD024D18903090@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5109.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f589879-5ed5-4d40-a4b9-08dd0383c439
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Nov 2024 01:37:42.3899
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LX+aY23sfSrSRUi3ygxj1+/3O1sYkihsBSoGVoUzwVXYxsqoqba+7bVmgbw0OYlHGr1bRahKW+LA5EIkdFBu7g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR15MB5669
X-Proofpoint-GUID: qjt6pWrF137FyQ7D8gkQTOSTThHPrHY7
X-Proofpoint-ORIG-GUID: qjt6pWrF137FyQ7D8gkQTOSTThHPrHY7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-05_03,2024-10-04_01,2024-09-30_01

DQoNCj4gT24gTm92IDEyLCAyMDI0LCBhdCA1OjEw4oCvUE0sIENhc2V5IFNjaGF1ZmxlciA8Y2Fz
ZXlAc2NoYXVmbGVyLWNhLmNvbT4gd3JvdGU6DQo+IA0KPiBPbiAxMS8xMi8yMDI0IDEwOjQ0IEFN
LCBTb25nIExpdSB3cm90ZToNCj4+IEhpIENhc2V5LCANCj4+IA0KPj4gVGhhbmtzIGZvciB5b3Vy
IGlucHV0LiANCj4+IA0KPj4+IE9uIE5vdiAxMiwgMjAyNCwgYXQgMTA6MDnigK9BTSwgQ2FzZXkg
U2NoYXVmbGVyIDxjYXNleUBzY2hhdWZsZXItY2EuY29tPiB3cm90ZToNCj4+PiANCj4+PiBPbiAx
MS8xMi8yMDI0IDEyOjI1IEFNLCBTb25nIExpdSB3cm90ZToNCj4+Pj4gYnBmIGlub2RlIGxvY2Fs
IHN0b3JhZ2UgY2FuIGJlIHVzZWZ1bCBiZXlvbmQgTFNNIHByb2dyYW1zLiBGb3IgZXhhbXBsZSwN
Cj4+Pj4gYmNjL2xpYmJwZi10b29scyBmaWxlKiBjYW4gdXNlIGlub2RlIGxvY2FsIHN0b3JhZ2Ug
dG8gc2ltcGxpZnkgdGhlIGxvZ2ljLg0KPj4+PiBUaGlzIHNldCBtYWtlcyBpbm9kZSBsb2NhbCBz
dG9yYWdlIGF2YWlsYWJsZSB0byB0cmFjaW5nIHByb2dyYW0uDQo+Pj4gTWl4aW5nIHRoZSBzdG9y
YWdlIGFuZCBzY29wZSBvZiBMU00gZGF0YSBhbmQgdHJhY2luZyBkYXRhIGxlYXZlcyBhbGwgc29y
dHMNCj4+PiBvZiBvcHBvcnR1bml0aWVzIGZvciBhYnVzZS4gQWRkIGlub2RlIGRhdGEgZm9yIHRy
YWNpbmcgaWYgeW91IGNhbiBnZXQgdGhlDQo+Pj4gcGF0Y2ggYWNjZXB0ZWQsIGJ1dCBkbyBub3Qg
bW92ZSB0aGUgTFNNIGRhdGEgb3V0IG9mIGlfc2VjdXJpdHkuIE1vdmluZw0KPj4+IHRoZSBMU00g
ZGF0YSB3b3VsZCBicmVhayB0aGUgaW50ZWdyaXR5IChzdWNoIHRoYXQgdGhlcmUgaXMpIG9mIHRo
ZSBMU00NCj4+PiBtb2RlbC4NCj4+IEkgaG9uZXN0bHkgZG9uJ3Qgc2VlIGhvdyB0aGlzIHdvdWxk
IGNhdXNlIGFueSBpc3N1ZXMuIEVhY2ggYnBmIGlub2RlIA0KPj4gc3RvcmFnZSBtYXBzIGFyZSBp
bmRlcGVuZGVudCBvZiBlYWNoIG90aGVyLCBhbmQgdGhlIGJwZiBsb2NhbCBzdG9yYWdlIGlzIA0K
Pj4gZGVzaWduZWQgdG8gaGFuZGxlIG11bHRpcGxlIGlub2RlIHN0b3JhZ2UgbWFwcyBwcm9wZXJs
eS4gVGhlcmVmb3JlLCBpZg0KPj4gdGhlIHVzZXIgZGVjaWRlIHRvIHN0aWNrIHdpdGggb25seSBM
U00gaG9va3MsIHRoZXJlIGlzbid0IGFueSBiZWhhdmlvciANCj4+IGNoYW5nZS4gT1RPSCwgaWYg
dGhlIHVzZXIgZGVjaWRlcyBzb21lIHRyYWNpbmcgaG9va3MgKG9uIHRyYWNlcG9pbnRzLCANCj4+
IGV0Yy4pIGFyZSBuZWVkZWQsIG1ha2luZyBhIGlub2RlIHN0b3JhZ2UgbWFwIGF2YWlsYWJsZSBm
b3IgYm90aCB0cmFjaW5nIA0KPj4gcHJvZ3JhbXMgYW5kIExTTSBwcm9ncmFtcyB3b3VsZCBoZWxw
IHNpbXBsaWZ5IHRoZSBsb2dpYy4gKEFsdGVybmF0aXZlbHksDQo+PiB0aGUgdHJhY2luZyBwcm9n
cmFtcyBuZWVkIHRvIHN0b3JlIHBlciBpbm9kZSBkYXRhIGluIGEgaGFzaCBtYXAsIGFuZCANCj4+
IHRoZSBMU00gcHJvZ3JhbSB3b3VsZCByZWFkIHRoYXQgaW5zdGVhZCBvZiB0aGUgaW5vZGUgc3Rv
cmFnZSBtYXAuKQ0KPj4gDQo+PiBEb2VzIHRoaXMgYW5zd2VyIHRoZSBxdWVzdGlvbiBhbmQgYWRk
cmVzcyB0aGUgY29uY2VybnM/DQo+IA0KPiBGaXJzdCBvZmYsIEkgaGFkIG5vIHF1ZXN0aW9uLiBO
bywgdGhpcyBkb2VzIG5vdCBhZGRyZXNzIG15IGNvbmNlcm4uDQo+IExTTSBkYXRhIHNob3VsZCBi
ZSBrZXB0IGluIGFuZCBtYW5hZ2VkIGJ5IHRoZSBMU01zLiBXZSdyZSBtYWtpbmcgYW4NCj4gZWZm
b3J0IHRvIG1ha2UgdGhlIExTTSBpbmZyYXN0cnVjdHVyZSBtb3JlIGNvbnNpc3RlbnQuDQoNCkNv
dWxkIHlvdSBwcm92aWRlIG1vcmUgaW5mb3JtYXRpb24gb24gdGhlIGRlZmluaXRpb24gb2YgIm1v
cmUgDQpjb25zaXN0ZW50IiBMU00gaW5mcmFzdHJ1Y3R1cmU/IA0KDQpCUEYgTFNNIHByb2dyYW1z
IGhhdmUgZnVsbCBhY2Nlc3MgdG8gcmVndWxhciBCUEYgbWFwcyAoaGFzaCBtYXAsIA0KYXJyYXks
IGV0Yy4pLiBUaGVyZSB3YXMgbmV2ZXIgYSBzZXBhcmF0aW9uIG9mIExTTSBkYXRhIHZzLiBvdGhl
ciANCmRhdGEuIA0KDQpBRkFJQ1QsIG90aGVyIExTTXMgYWxzbyB1c2Uga3phbGxvYyBhbmQgc2lt
aWxhciBBUElzIGZvciBtZW1vcnkgDQphbGxvY2F0aW9uLiBTbyBkYXRhIHNlcGFyYXRpb24gaXMg
bm90IGEgZ29hbCBmb3IgYW55IExTTSwgcmlnaHQ/DQoNClRoYW5rcywNClNvbmcNCg0KPiBNb3Zp
bmcgc29tZSBvZg0KPiB0aGUgTFNNIGRhdGEgaW50byBhbiBMU00gc3BlY2lmaWMgZmllbGQgaW4g
dGhlIGlub2RlIHN0cnVjdHVyZSBnb2VzDQo+IGFnYWluc3QgdGhpcy4gV2hhdCB5b3UncmUgcHJv
cG9zaW5nIGlzIGEgb25lLW9mZiBjbGV2ZXIgb3B0aW1pemF0aW9uDQo+IGhhY2suIFdlIGhhdmUg
dG9vIG1hbnkgb2YgdGhvc2UgYWxyZWFkeS4NCg0KDQoNCg==


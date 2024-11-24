Return-Path: <linux-fsdevel+bounces-35718-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C0FBC9D7791
	for <lists+linux-fsdevel@lfdr.de>; Sun, 24 Nov 2024 19:59:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E62D162CF0
	for <lists+linux-fsdevel@lfdr.de>; Sun, 24 Nov 2024 18:59:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B6A214A4FF;
	Sun, 24 Nov 2024 18:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="GfYusKDy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 050ABB660;
	Sun, 24 Nov 2024 18:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.145.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732474787; cv=fail; b=GPfQU+w2KhoRCm6UrSrJDtZg5/lv5xbXmOv4ETqVmauXsxlnlrcvtz+xMEHnTyW0ABqOLNZbb/Lrxgvsbvci99C3xtyy01NW5zzHGUWM8sZxORAij+m4rQKcybLaExVOObzZuT6QIvOn/PgBLFbL+h5ktl2caSDOy6KEJW6JReY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732474787; c=relaxed/simple;
	bh=uRlPolLa4RtUkhvzZDKvqXZeQL+F20p8acSFCKYMMFk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=h7e+SnpC3qG/7Lkeaisjd5c5Rk89kKKE/50R7ruy+3Th3OzhBK/GIRiiVmEkP7FFXvbs0exEVOYvpQm+9gBeUSNBrfIXAmpaGQW/mf5CQcEMLnRZzb7VU46BppUvZBaOJg4BEkUUeKtltZV+neeRsk3NryZoK8tL7gG+3jauhIc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=GfYusKDy; arc=fail smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AOIAA9C005690;
	Sun, 24 Nov 2024 10:59:45 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	s2048-2021-q4; bh=uRlPolLa4RtUkhvzZDKvqXZeQL+F20p8acSFCKYMMFk=; b=
	GfYusKDyKoVf6vGQNZKeYolOpQ5B2IBYKIphh9nx8MKadRb7gMFbwoUzryjhn6rs
	lj4t/nbP4xfTxuXw1jgvatiNIrw+nFhkxOFIn2luyJK4qvxX3U3SfM8YpEMx3R/n
	aGsxHHDuEk9O9IpycTM4Do3+HZ9iOa/l2xRR6N4s7wHi8JFkcUOW84RgM3CrhyU2
	kQFov2PRRMmLXcn3egFufurlYYhwG+bIpwe65DzARIGNqqLx5uqwXPqPo1w/zy2A
	FqPGy85oYJGfh+0dEYaGW0QSWv3zeIfujuxGkGeDJlRZshiLgioIqOYs1HF47eur
	v+yBqv4RWB+vI9j4SY5W7A==
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2175.outbound.protection.outlook.com [104.47.56.175])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 43496a04kv-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 24 Nov 2024 10:59:45 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=js6eqV/5Fo4NSiDUs83Aiyfpqvd/kjrgqzerzMZgNq0ySsIowwpB7J5yECqIevvT6laG4xL1/w3IZlvXQ2D0zCBVJW39gX+hqfy9tKY7m99kX8HqCems6/WXav710MxE2YhoEk3EfK/nSr6gbpXrfg/d9ZIg4r1xMTtYOi+QvjiHMeZEQhrBxhUALrf2VzeOUdorzTCOLKc+rGLLbimtHwGU6NeQ+UhwJqT8tPMqe1+3CkxG14+DptU+KUiqJaxbabebiR1wSf4CVcC1fE+588I9w9i6ilUKURqVEIUmUt78zcDpEbN2npPpTY/wJVS2sJNV5dx0UcyCQ7bBranZYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uRlPolLa4RtUkhvzZDKvqXZeQL+F20p8acSFCKYMMFk=;
 b=b1rVhN1FvMJTPtV0sHXLmsrFx/8sg6glRzIAHoQItb/VnD59OwEydEEUFxBv4B0wvbPH35lWAVbtzIuFWKTMP5IXY3DJqx45jLM3AhF/2suk2eiJ7GlU9kwPNERCLj9WySZbuXbMbYvurflCU4OEx5LjbtUoNdbr6jtXth1+/kh4p+RfNlUooPRvEUW8A6IWGn1Jdd7cy0mA6iadgLki1/rrj5btRjeQx9ndTIxbMlPWypn1VMYD2KhCmYap0A4xK8hFSapsMiva9fBMz6X6sKtyH1GxENC5mObR2LvS4sZy18IWvd0vQFk7TtpWrj1w60aAjTxeHOlMnIMeDNoF9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SA1PR15MB5109.namprd15.prod.outlook.com (2603:10b6:806:1dc::10)
 by SN7PR15MB4192.namprd15.prod.outlook.com (2603:10b6:806:f6::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.20; Sun, 24 Nov
 2024 18:59:40 +0000
Received: from SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::662b:d7bd:ab1b:2610]) by SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::662b:d7bd:ab1b:2610%6]) with mapi id 15.20.8182.016; Sun, 24 Nov 2024
 18:59:40 +0000
From: Song Liu <songliubraving@meta.com>
To: Amir Goldstein <amir73il@gmail.com>
CC: Song Liu <song@kernel.org>, "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
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
        "repnop@google.com" <repnop@google.com>,
        "jlayton@kernel.org" <jlayton@kernel.org>,
        Josef Bacik
	<josef@toxicpanda.com>,
        "mic@digikod.net" <mic@digikod.net>,
        "gnoack@google.com" <gnoack@google.com>
Subject: Re: [PATCH v3 fanotify 2/2] samples/fanotify: Add a sample fanotify
 fiter
Thread-Topic: [PATCH v3 fanotify 2/2] samples/fanotify: Add a sample fanotify
 fiter
Thread-Index: AQHbPTJZqeNX/hCyTk2z4ZUDy/y7a7LF4v0AgADomQA=
Date: Sun, 24 Nov 2024 18:59:40 +0000
Message-ID: <27D52379-F45A-4E76-8573-5EBDC3C31DDE@fb.com>
References: <20241122225958.1775625-1-song@kernel.org>
 <20241122225958.1775625-3-song@kernel.org>
 <CAOQ4uxhfd8ryQ6ua5u60yN5sh06fyiieS3XgfR9jvkAOeDSZUg@mail.gmail.com>
In-Reply-To:
 <CAOQ4uxhfd8ryQ6ua5u60yN5sh06fyiieS3XgfR9jvkAOeDSZUg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3826.200.121)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5109:EE_|SN7PR15MB4192:EE_
x-ms-office365-filtering-correlation-id: e8925501-49a1-4fd3-06fb-08dd0cba2667
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|7416014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?VUgxK1VjVVBXbkNDak1XZmxIZnpIdEhuc3BpUkdKM0x1M0loZFVFUGovMldZ?=
 =?utf-8?B?cWRuandHZlQzVXpsMVlOWU8vemJaUlRobDRMa3NwVmRKbHRYOFZGNk1SeG9w?=
 =?utf-8?B?MmV6bmx0L1A3WGJIdHFZWVhuazNEZno2aXcrTDRPSTJGN0pzL2pnM2tqQTBN?=
 =?utf-8?B?bnRza2NYVE8rYS9FN2xJUHg2MkZNcHpQR1hQWWpha1ZJdzJucHJDYWdvN1o2?=
 =?utf-8?B?dDg4VURrc01pNllEYVNwSENyN2FraE1UMkxIcEZxTkxQRzJFZjI2c1BwNi96?=
 =?utf-8?B?WjdZa1VtNjVBYXBzOURzdXZWNURjWG9lSUJKM25KdEhHWlJRdjJXckJjeGlt?=
 =?utf-8?B?dWRDQlNTMC82WkUyRXFGV3R0VzZ6c0FUbnZhRkFxdzZKMEFIRWF5RTZaMkVC?=
 =?utf-8?B?VlZ3U2d3RDFkTURIMWU0RDBibVBEM1F2ejF4SFBOV2gxZkFTY3p5OU05YlhR?=
 =?utf-8?B?YWUydjNSSmNzNHl1V1A4cGNOdlhoZkRTU2ZZRExNeHQ2R1M5VUdNVHpiU21J?=
 =?utf-8?B?bVJMZ0pDWkRoRzNSV1FZMkQxenlpOHFKWEZHamZpUWxEUjRkZURZekpOWUhU?=
 =?utf-8?B?Z1J6d2JvaDE0SGw2V1hML3hSWi9kajhyZDQrN0RZa2JpbHcyWDhmaWgwTUQv?=
 =?utf-8?B?MnNwOTAwY0czWnRrNnNjclB4dVVxRkNPVktpMmxoTTR1R2hBeElhWGUwZWRD?=
 =?utf-8?B?WnJoU0x6K2dXYXRpdGE2dFYxYzZmL05ucFhTNVlPbmVrcTMzczUwRjN3bkdw?=
 =?utf-8?B?MVo2bTVURFFCZ3l3WXc1UXYyUy9YanEvdy93S3JUMDV6ZHlLKzhQQmVTMlgz?=
 =?utf-8?B?clFiVmhOQkxrc0FNdkIxVzgzeHBtdmlZYmo1NGpmM2dpclJ1dDM5UDExR1Nk?=
 =?utf-8?B?a09zWndQUHhqOSswQkcya1ZRRm5XMWJ4Z2oweEE1ZGZsR1g5bUxJOXA4N2Fu?=
 =?utf-8?B?QXEzTXdHRXU0MlN2dlc4aGlQZmZrRTl0K0lKU1VEaVc0bDRuSTVHcDJvVWg4?=
 =?utf-8?B?UHZ4YU1UNE9VZ1JSZXQ4bWFDczZrZWd6SVpaWlBobTByUUVjNmhzdXI1Y2dx?=
 =?utf-8?B?QmNCR1NjRDRzZWpEUDVLbHVuTW5ZcU1VdEpPTnVWWjVKbDVWMlB3bk9kcFp4?=
 =?utf-8?B?VGZqOEVlSU5VNHNlSi9ScDdHclI4aXUwc1VWdlIwcU01b21xNU42WXpKNXpQ?=
 =?utf-8?B?UDFFbXJXdWNnZHZLMUtHYjlMRWNHbDdnM1BVQ0ZDZkNtVXJZVWNyUDZhMUtO?=
 =?utf-8?B?V0FjTVYzZnk5S1ZHTUhOM1FkS3NTdGJOdWRlVkdKbTVtMlFoT1RocVZaOWV1?=
 =?utf-8?B?ekFOQ0VxMGhHb0NLWlVJNUxXNVk3VVVhZDU2KzllSW9vaUdLWUpaeDlkbXRz?=
 =?utf-8?B?NFA2WnhRMTVQSnZJU0w2aHlzY0laN2ZjN0pTdmVPcGs4cTdiUCtrWW95Y05t?=
 =?utf-8?B?SEdBYXpWZWVDY2N1RnNOa0hCdkFQaDEyOG9lMUhCeTd0bGxXTmVpZTJmcmtD?=
 =?utf-8?B?d1JaeGVONHM2cW1FZkxaYWkveG1pOFdoWEdvQzgzdThwL0p2VmlNUUVFOGsr?=
 =?utf-8?B?V3kzWXQzdVV4NFpNT2IwazhBUWt5N1BVaG9xbFVpOXhzNnA3Y1hRUGdKRmtQ?=
 =?utf-8?B?RkZrcHMwdUNRbEE3Q3hVdWd3Z2szUVJ6bWxKbW9adFRmanZqWkVkS2Z6Z3lj?=
 =?utf-8?B?M0RyM050c2pZU2p2UkhOcWh2YWowekVmMHF0dnpBTVJqaktRTjNqQS9YUFFZ?=
 =?utf-8?B?STNIdEZUdWtmWGo1bE1aY2Zoc2ZJTS96TmR0VHBVSXJrakN6ZHp0djlWeDM4?=
 =?utf-8?B?VDNSbzdRWTFTdGRWdWhTa1RjaEJRVTN5MW84Q2p5R0h2Q1ZiUVB3ZWx0ckJU?=
 =?utf-8?B?VzZTa05vR25aL1lvQndqNWNlOWpzNkI2NHF3bk1SeWJ6S3c9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5109.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?WXJWeU5tRDJWK0o0QmNuMWxkdU1STE1xdEcraHc1NFh1YmZqOVNNNnpySnBM?=
 =?utf-8?B?WDR3TmNTdDZyQS83bGo3am80TlJoNDhCelJRZ2xGMGEvSEhSTUdSTEVyVkJs?=
 =?utf-8?B?SEplSVROSDY4U0dJcmtJVFBWajl4NzhXSHpCaXh5c1FUSVNsVHpCTUdaRFdr?=
 =?utf-8?B?bng0S211NUIrVENkaStiWmwwemJvM1JkNUVYL1VzZzQrZ09WcStnSnZSeGU5?=
 =?utf-8?B?SHY2eTNaWCtwQW10Tk1URnk0V2JvZFgyT1BjUHNudDd4U1pqQ3A3NGN0SnVS?=
 =?utf-8?B?SnpEOXErZmttMEoyMnFUL0JnTFI4Z3lqV2xLdjM3VDZndzQ2MVp6aXdteDBj?=
 =?utf-8?B?Q2ZXNDBoNjNFb2w1OGdrdHlzV2hoRWNqYU80c09LNW8waFB0SHZOb1AvRzJC?=
 =?utf-8?B?YmY5Mmcra01acXVWbkp0MWNlSEFPNUR4aUJDLzlaOFJibGNYbUJYZ3hhNjBR?=
 =?utf-8?B?SFczYnNiQ2gwQkNaaGJmZHAzWWV1Z0dGblNNZytwQ3E2b0VocXdqTFNsL0xH?=
 =?utf-8?B?NEVGMnFjak9LZ2JZYXgzdlM3TFdaV2Q4c2RjclFaSExnNGVMSysvVGZaaHdK?=
 =?utf-8?B?akFkaUxlbkVPaGFBUHFpLzg2ZnVJcGlGREcwYVo0c08zV1N2NVZMM3NKZGpR?=
 =?utf-8?B?dk1kaHNhYXhtcjliOFZyMFRoYjRrMVRUQmtlZlJIeG1ieWxxVlJhdTAzRVlF?=
 =?utf-8?B?ZkMrUlhOakh6MlFFNGNsOTd5U0tVYlI1TklzY1Frd21oemlYeWdJcjV2MnhF?=
 =?utf-8?B?bkVQK3g3Z3B4L3N1b3FsbGUwNWsxL1VKY0RNSmlOVWR0RldnOW95MFd4TUZn?=
 =?utf-8?B?ZEFZaW8xeUdZMERndUx1N2hwWnhHaEJnWFVVaTNzTXZybzlHY2lJLy9hNGpC?=
 =?utf-8?B?Y0xidkFmTHRvNEdRTXU2cWZxQkFoNmwrT1NNZGFyYytqbjlYaFQ1ZGo1Sm5S?=
 =?utf-8?B?SFVZb0tidlpPajdWblBLMUsvTEVoZ0dVTnRQRUUwY3JQZzBKczdIQlh6ZzE1?=
 =?utf-8?B?Q0M0ZjBjTzd6QlpJazRQeUJnaTd3UWZ5eStWME1EVU0weHpnWWhyQk5BUGRw?=
 =?utf-8?B?c2hMVCtUSEYvNlR3eGZqcGpNL0p2dlJTM0ladVdyakJBMm5rVkxHZWZDQnZ3?=
 =?utf-8?B?a0hDR05NaE1iVER0RzczNXp1Y0hxdmNyUHhyUXpDendSRjBhMnlHbTNqeUlE?=
 =?utf-8?B?NVpIMHY5QzFGcldpVU5kWUdvOStnazFORlpxcVZBYitqdGQ5VkRwSEQ5NGxl?=
 =?utf-8?B?RHJBUWpsbzdXVGVQemNWRTMyNy96RlFmcEplU0Q3UTJkbkNETmU2Skh1b2dN?=
 =?utf-8?B?ekdiSWdQdzhjWHNMaFMwWkN0TTVVR2NvZ1VmaHNrVEEyRWZ1MWFvYjZUQUln?=
 =?utf-8?B?ZUYvaUQ5TG4xSmZ1K3FXWjIzMnFveUI1SGpjYk5CbFVXZG15bDBXcUJ3alJu?=
 =?utf-8?B?cEJZSVJJVnc3RnNQdnlnOVN6SElBRGlJcXp2Vzh6RkdHMVg5QUVoaEhpZGto?=
 =?utf-8?B?RUVNV3RsNGhNTzljaHg0dzVEKzZwUERLL0UwbnFDQlF5ME1MdER5QnpmYlpO?=
 =?utf-8?B?MXhteGxNOTlWakg5Y3IzTnRhUGp5NzgxVmJhNmg1cEEvdWNzRzhoR1B5bE54?=
 =?utf-8?B?eW1XbVZuV0pBWkI0OFB5MnhsNjl0ZGhZT0VndVZlbEo2UHVKMkRTUTlqZ3NO?=
 =?utf-8?B?V3N4TnVHSjV5czhYN0hZR3JBUm1sU1EyR1BaQ252NzhuVGxnVmkwcUx1NHhS?=
 =?utf-8?B?RGFkUjUxcktQTmRUWVVZRGZEZ1dVdzZvKzllMzB0dVVwZCtUSURxSTlMR0dl?=
 =?utf-8?B?VkdoWEFPNnFSV1BHdDdpakI2TS9JT1pIUG81ejY1eXcyaEt2ZEFJN2RXekxv?=
 =?utf-8?B?MFdQeXpscXE5bmltdVJMMllrWTZNOTJYUU1FQTlYNUZWOEhlM1BwU3g4c29n?=
 =?utf-8?B?ZXFVTUdWZlBPbXpyUVJkMDE4bzBuaFBJZUlYZ2tpRHhIQ0M3YTFGL3VTUE90?=
 =?utf-8?B?L3pwd2pJditIOXh6QWp1bUxUbjZsWTdtRHNWOWR0a21QZlp4aUIzRTd3Q2hK?=
 =?utf-8?B?NndYNlg0NnZhWUhCajBDSC9Gcm9aZXZXUmZUZDY0eFJtTFdsc09xNkdhcG9K?=
 =?utf-8?B?Qjk3S2hsVVp0eSsyc3kvN0pzRE43c0tTcmtoczN1RGNHc2dNbEZORlZNL1Z3?=
 =?utf-8?B?Y0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A5CFAC66463D0B45A191993E2B9AA49E@namprd15.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: e8925501-49a1-4fd3-06fb-08dd0cba2667
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Nov 2024 18:59:40.3841
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xbUi3uQ4xph5HPjtdT/MgtCgg0Nl3bT3oRrTZkpu9Lxgk9s5ch5ad2KeMZqxjElvb7Lpu4nNFhMSX1jsx/QqlA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR15MB4192
X-Proofpoint-ORIG-GUID: csQpkqYAGivGeLp2hBNJmSF64txKUhWM
X-Proofpoint-GUID: csQpkqYAGivGeLp2hBNJmSF64txKUhWM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-05_03,2024-10-04_01,2024-09-30_01

DQoNCj4gT24gTm92IDIzLCAyMDI0LCBhdCA5OjA34oCvUE0sIEFtaXIgR29sZHN0ZWluIDxhbWly
NzNpbEBnbWFpbC5jb20+IHdyb3RlOg0KPiANCj4gT24gU2F0LCBOb3YgMjMsIDIwMjQgYXQgMTI6
MDDigK9BTSBTb25nIExpdSA8c29uZ0BrZXJuZWwub3JnPiB3cm90ZToNCg0KWy4uLl0NCg0KPj4g
K30NCj4+ICsNCj4+ICtzdGF0aWMgdm9pZCBzYW1wbGVfZmlsdGVyX2ZyZWUoc3RydWN0IGZhbm90
aWZ5X2ZpbHRlcl9ob29rICpmaWx0ZXJfaG9vaykNCj4+ICt7DQo+PiArICAgICAgIHN0cnVjdCBm
YW5fZmlsdGVyX3NhbXBsZV9kYXRhICpkYXRhID0gZmlsdGVyX2hvb2stPmRhdGE7DQo+PiArDQo+
PiArICAgICAgIHBhdGhfcHV0KCZkYXRhLT5zdWJ0cmVlX3BhdGgpOw0KPj4gKyAgICAgICBrZnJl
ZShkYXRhKTsNCj4+ICt9DQo+PiArDQo+IA0KPiBIaSBTb25nLA0KPiANCj4gVGhpcyBleGFtcGxl
IGxvb2tzIGZpbmUgYnV0IGl0IHJhaXNlcyBhIHF1ZXN0aW9uLg0KPiBUaGlzIGZpbHRlciB3aWxs
IGtlZXAgdGhlIG1vdW50IG9mIHN1YnRyZWVfcGF0aCBidXN5IHVudGlsIHRoZSBncm91cCBpcyBj
bG9zZWQNCj4gb3IgdGhlIGZpbHRlciBpcyBkZXRhY2hlZC4NCj4gVGhpcyBpcyBwcm9iYWJseSBm
aW5lIGZvciBtYW55IHNlcnZpY2VzIHRoYXQga2VlcCB0aGUgbW91bnQgYnVzeSBhbnl3YXkuDQo+
IA0KPiBCdXQgd2hhdCBpZiB0aGlzIHdhc24ndCB0aGUgaW50ZW50aW9uPw0KPiBXaGF0IGlmIGFu
IEFudGktbWFsd2FyZSBlbmdpbmUgdGhhdCB3YXRjaGVzIGFsbCBtb3VudHMgd2FudGVkIHRvIHVz
ZSB0aGF0DQo+IGZvciBjb25maWd1cmluZyBzb21lIGlnbm9yZS9ibG9jayBzdWJ0cmVlIGZpbHRl
cnM/DQo+IA0KPiBPbmUgd2F5IHdvdWxkIGJlIHRvIHVzZSBhIGlzX3N1YnRyZWUoKSB2YXJpYW50
IHRoYXQgbG9va3MgZm9yIGENCj4gc3VidHJlZSByb290IGlub2RlDQo+IG51bWJlciBhbmQgdGhl
biB2ZXJpZmllcyBpdCB3aXRoIGEgc3VidHJlZSByb290IGZpZC4NCj4gQSBwcm9kdWN0aW9uIHN1
YnRyZWUgZmlsdGVyIHdpbGwgbmVlZCB0byB1c2UgYSB2YXJpYW50IG9mIGlzX3N1YnRyZWUoKQ0K
PiBhbnl3YXkgdGhhdA0KPiBsb29rcyBmb3IgYSBzZXQgb2Ygc3VidHJlZSByb290IGlub2Rlcywg
YmVjYXVzZSBkb2luZyBhIGxvb3Agb2YgaXNfc3VidHJlZSgpIGZvcg0KPiBtdWx0aXBsZSBwYXRo
cyBpcyBhIG5vIGdvLg0KDQpNYXliZSBzb21lIGNhY2hlIG1lY2hhbmlzbSB3aWxsIGJlIHN1ZmZp
Y2llbnQgKGFuZCBtYXliZSBhbHNvIHRoZQ0KYmVzdCB3ZSBjYW4gZG8pIGluIHRoaXMgY2FzZT8g
DQoNClRoYW5rcywNClNvbmcNCg0KPiANCj4gRG9uJ3QgbmVlZCB0byBjaGFuZ2UgYW55dGhpbmcg
aW4gdGhlIGV4YW1wbGUsIHVubGVzcyBvdGhlciBwZW9wbGUNCj4gdGhpbmsgdGhhdCB3ZSBkbyBu
ZWVkIHRvIHNldCBhIGJldHRlciBleGFtcGxlIHRvIGJlZ2luIHdpdGguLi4NCg0K


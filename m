Return-Path: <linux-fsdevel+bounces-20795-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F1C88D7DE3
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Jun 2024 10:53:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5ED70B2343A
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Jun 2024 08:53:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E4925FBB3;
	Mon,  3 Jun 2024 08:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="lD3X2EVy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2065.outbound.protection.outlook.com [40.107.237.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50B283D551
	for <linux-fsdevel@vger.kernel.org>; Mon,  3 Jun 2024 08:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717404783; cv=fail; b=ABuAMxUV2SopyyXFku0uinvbLLjrDNNXKlMCI8mKkMJFW8NocbC3CM4W+9GXx3sAghDBAR6S7TOHi3YnrzsUm8jrBwU+g4A2M/EVXW0FYZZeMmL2QuGHAv5nxYob4tcSQ3AoKq+Csd1vGOkSxU6yDm5vyWKU1Eb3zESynkgEJ9U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717404783; c=relaxed/simple;
	bh=tO6McJAT89VuUP9O72qcJ9MO8ZTlW5gU+Sbs99IuKmw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Xlw3q9NQX30uAdrCGBURan0T9EKpBkF2xwrgpQR3t9f0xUcJuGImViK5zRywkjmI45MZ5dhnEdCt4EO05t3m7tdY2cISSkyrcS91ZUXDBJM5O6cfNR8m6NfpuK1jPNGmdoPysl0/xnAmYBv0H45pv3p8vLiKNzyjQgKd+AEOROs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=lD3X2EVy; arc=fail smtp.client-ip=40.107.237.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZDNzNFpgEelCZZl7zEjs1o57sggkpz+sDoVfOxsnGOKs7+XwEBCL32gS7uaX/RwqJi1vfhVAl+jV9H/iCZQerkqc6vO0KUQRXn1X6zvqtgn677JCSPtDbVzkJMHjxI7g4ocQn233samx+vs8X0G3uxb7uUgmwQ6dIOEzBcmEY1vDgkYnLq0aWx7Wo9taKEzx5KgW3x8Ke56EoMSnVmzaA+zmjdyynDZIyQeaX0svGI67n5SBH0rp3R4qfbC+AHE1QnCNhZsKxN3LC5CcNLrDB3gcsH04ouTBO8z4El9ueFBTnEdAcsaeO00bVMsYTO1eaN1EVRc57/YvAkvS9FsURQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tO6McJAT89VuUP9O72qcJ9MO8ZTlW5gU+Sbs99IuKmw=;
 b=nDUAuP42Nu9sXJcGwkKPfrvkncuCy4CnnhxhZTt+GtLiXVHPV4DSbnh6sWsugs4HvvodIu7NnDfrEol/eOGntvRz8sohHqFJPNPh9/2gc9VqjmSNsuQ7vFy3QZ6CN35Ols3coGB7hAUgdURAxZ3GRZ4Gvy1drDrNk2tZeqa/ealdK50UvX1IfQY5Q53zMJD3w2ZOnXyB79NoYbJsFRpmoqgvIuPp3ejlQt3hBfFkx+SC+yDz8Mtdz4twpa/k5FdlS/MjH7fkedz35994pIigSxqNVpfOci6VBGHBwu8Z7TBZMgbykj2tAAf5G00n5kbmMyhlCCIX4VbvuFp6UqQbNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tO6McJAT89VuUP9O72qcJ9MO8ZTlW5gU+Sbs99IuKmw=;
 b=lD3X2EVyDYL74EE7pBhELWny5q3AsAcyaTYXuaoCRdIiHnPwRy1JlUSlGWgNLUPknKzg8WtfgT/0FzpX6o0usMKNkP17kePzMM+PbrpnfcuHPiFgGzcOnyaJ2P/VMPeu9pJEoQw8DzzNCE75fwrV+zcZgLX8gTl996LNvwVIp5Z1OLvI76+5A7QWiXt8sGHXBj/UAkOUd0wLWGWByfh6hyQM/RzwXH0vjl7940MuU3WMzcsI38MPNPh5wxFvIjool4mLtyTpLOG86QvTjCQXpV9+tEf60mWskLvbMJiX9uScQAkEIQoEAoUTZHxl4tpxVbOhtv+SsYZyIPmiqFwvRQ==
Received: from SJ2PR12MB7845.namprd12.prod.outlook.com (2603:10b6:a03:4ce::18)
 by SN7PR12MB6910.namprd12.prod.outlook.com (2603:10b6:806:262::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.22; Mon, 3 Jun
 2024 08:52:58 +0000
Received: from SJ2PR12MB7845.namprd12.prod.outlook.com
 ([fe80::ad75:1017:e4a8:3f91]) by SJ2PR12MB7845.namprd12.prod.outlook.com
 ([fe80::ad75:1017:e4a8:3f91%4]) with mapi id 15.20.7633.021; Mon, 3 Jun 2024
 08:52:58 +0000
From: Peter-Jan Gootzen <pgootzen@nvidia.com>
To: "miklos@szeredi.hu" <miklos@szeredi.hu>
CC: Idan Zach <izach@nvidia.com>, Yoray Zack <yorayz@nvidia.com>,
	"virtualization@lists.linux.dev" <virtualization@lists.linux.dev>, Parav
 Pandit <parav@nvidia.com>, "stefanha@redhat.com" <stefanha@redhat.com>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"bin.yang@jaguarmicro.com" <bin.yang@jaguarmicro.com>, Max Gurtovoy
	<mgurtovoy@nvidia.com>, "mszeredi@redhat.com" <mszeredi@redhat.com>, Eliav
 Bar-Ilan <eliavb@nvidia.com>, "mst@redhat.com" <mst@redhat.com>,
	"lege.wang@jaguarmicro.com" <lege.wang@jaguarmicro.com>, Oren Duer
	<oren@nvidia.com>, "angus.chen@jaguarmicro.com" <angus.chen@jaguarmicro.com>
Subject: Re: Addressing architectural differences between FUSE driver and fs -
 Re: virtio-fs tests between host(x86) and dpu(arm64)
Thread-Topic: Addressing architectural differences between FUSE driver and fs
 - Re: virtio-fs tests between host(x86) and dpu(arm64)
Thread-Index: AdqybnzAiozTvtlkQFaloMBVG2WGpwDHcmEAAADKEAAAAQAmgA==
Date: Mon, 3 Jun 2024 08:52:58 +0000
Message-ID: <bbf427150d16122da9dd2a8ebec0ab1c9a758b56.camel@nvidia.com>
References:
 <SI2PR06MB53852C83901A0DDE55624063FFF32@SI2PR06MB5385.apcprd06.prod.outlook.com>
	 <b55cb50b3ecf8d6132f8633ce346b6adc159b38c.camel@nvidia.com>
	 <CAJfpegsppbYbbLaECO+K2xpg8v0XZaQKFRZRTj=gJc9p7swdvQ@mail.gmail.com>
In-Reply-To:
 <CAJfpegsppbYbbLaECO+K2xpg8v0XZaQKFRZRTj=gJc9p7swdvQ@mail.gmail.com>
Reply-To: Peter-Jan Gootzen <pgootzen@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ2PR12MB7845:EE_|SN7PR12MB6910:EE_
x-ms-office365-filtering-correlation-id: da62aad1-11a2-4c10-5661-08dc83aa9181
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|1800799015|376005|366007|38070700009;
x-microsoft-antispam-message-info:
 =?utf-8?B?VXM0OGFCRkltWWdjNjhqNjlzTG5kYnlTMHpoVmUreXpTbkhia0pvSllESWhI?=
 =?utf-8?B?c2xoZ21zMTMxdUNIckRkeTNhWVVGMFA5MDRnT3ZEYkxlSWt4aEFvR3VKWGMr?=
 =?utf-8?B?Q3ZjeVo1SnNmQkVKNlNENEtmSm1wTFpYbk0wcHBZM0FISUovaVVTQmh6Zzhr?=
 =?utf-8?B?Y21hbEg1aU00UjJlRGp0RWRHMGhOeDRSV3N4Z3I4UFZta1hpVEFEK3RsMlhK?=
 =?utf-8?B?UldpSGZVUStNaTVrcDFadnY5endyS05MbTRra0l1RG0vOFFSOEZDcllxWTdE?=
 =?utf-8?B?cWppQ1dGMDJESXNZMzNyVFVsMXQyRGJSbUwxMit1MmkycnMxUW1YckVuQldL?=
 =?utf-8?B?SHMxMWhLYjFKKzgvR09hVFBma01aTVh2NlpXMTJ6LzJnam5WaXZ6UERtUlFU?=
 =?utf-8?B?Rm1aOFpyTk1xekdyeW9KTG1QeDdhSFFaUUc5WUMwSDBPcEtjK0FXRlZiUUJp?=
 =?utf-8?B?Y2ZCTWRGWGM4dTYwUlVTOWRSazA3OXZwOTFkc2pNOW1pV2pGQUVpUk5RRlRZ?=
 =?utf-8?B?ZFZramg3bGJ3YkVrQWppS3BQeEhBOFJzNXNJbk0zcmNDT3BLVzl6TG9VNU93?=
 =?utf-8?B?Yy9xaEc0M09KeVNDZnd5WFI0ZEdGQ2JKMzhqWHlxeEwxR2I2MGFUd3J2MjJ4?=
 =?utf-8?B?NWdvYVcyb1Zta2FaTklZcC80RjIrelltQVpZWitwbGpMNVR6UDdidlJ4RThH?=
 =?utf-8?B?cCtvcW5NZWdrcHRpSWlvdXVNM2hjd1lkUFlrb1FHQUJRamtTUkkwZGFIOFFh?=
 =?utf-8?B?ejllcWIyVFp0VFV5Zy90bjNVZWVjbTJkQ21IWVdRb0tTdjZnRkE3dlE3N1NJ?=
 =?utf-8?B?NGZ4eWVSaDl4OXp3eUhuRUUra283SDAxQ3FZb0QxRDl0V0VERmlDc0xyRi82?=
 =?utf-8?B?T1VNSGU3KzQ0OWV0aEN5RC9NVzZ2NGVBQWU0TDVPU050T25yVXQzZkw1cWFu?=
 =?utf-8?B?Wm4wZzA0WkZKeTdzMHVzQ3hNaVMvMy9STXV2OW41cUp5TUxMUHZLYWFOSXds?=
 =?utf-8?B?VWhtOVJiZlhGQ2pVN2VQQmNJUVRBNzh6TkdXU1ppT2pUOXhEVGM4ZnVyOFVE?=
 =?utf-8?B?cWFzRjhPZGZkYVoyYzBFU25WZWFnMWxOKzVoQ3ZPb3dnUmp4dDZ5YVF1WVc1?=
 =?utf-8?B?T0R4bmhsV3kzV3VkZ210RXkyb01yL0RMZEpFZEF5UWZYVDRSL2FXSkFpenY1?=
 =?utf-8?B?dWdkd1VhRDRiVmkyUjZmY3NFQ3dnVXZnbGdCdHk5Z0NJZWV5ZUNXYllqWGxX?=
 =?utf-8?B?eEVoSlRqaUc3T05najIxWmE0UjQxcjlEc1BUVEJJKzJqTXVNOUxlZDN3QTBr?=
 =?utf-8?B?cytTbURQQks1amtkNmI4cXpFN3J2cldjOW5aSTNYK3ByRmQ3VzFiMmVINVFr?=
 =?utf-8?B?UHo4bnQxM2ExU0NrWCtOSkl6MUVFeUtWVm9sTEk1VEg2UHBQQXovQkNubXpB?=
 =?utf-8?B?SVgxWUFBc0NhUXVGUWwvVGMxeGNFMCtkS0ZhUHp6SG9jK0pDZmN4ZTlDL2NB?=
 =?utf-8?B?bm01MXRUODFqb3dSSFJINjM5OCtCc2NrVnBRNDl6a05yRGYyUTlKcFZyTldi?=
 =?utf-8?B?YmlWOHYvemFuU1dha1k2ZUx3NlFkMUtqdEpnSFZiMm9qN3pMTWc3YW85dE1K?=
 =?utf-8?B?OUZ0NVEvZS9TNm1LNzY4SXZYd1VseFA2b3pFejVOWVNqSG1hQ2lEc3Vhak9I?=
 =?utf-8?B?SGNkMVVoQnl2SlBzYmpsNWRybUtjcXJGZTBQV2tZTUhQWnV1c1JSdjVwVmg1?=
 =?utf-8?B?VU9kQllTUkpFeHY3NHhzSW5iZzlaVjV6S0w4WkN5U0RIZHQybzMwc0M1alFa?=
 =?utf-8?B?dTVybFlXWVZZK0JmMjJZQT09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB7845.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?TnlqZ2pZUzR2NUJzeFdsUk95UjMvQTA0QmtRZForeElIR3p3TDQ2T1NRa3Jt?=
 =?utf-8?B?eWpETTJ5TXdFUEkrTnZGUHlxMUJrRU5LbStTTnA3MGZWV2hZLzE0aUwvZXZz?=
 =?utf-8?B?endRYWRQRlBMWE0rZDhoTVErUWh4bFFNRWhvc0VleGNXaHdSQ3pLWjh1c0VK?=
 =?utf-8?B?VkQxRkovblpHdjhxRHZxL1N2OFlkNDRKemV0dGxadWZYRUtMWGRnc0xPU2tC?=
 =?utf-8?B?bjZ5WHNibUtkRHQrUlBJcTc0RENlaHlwSHd4cVJ4R0JYbWRkUGxSVjZzdjcv?=
 =?utf-8?B?ZzZIZXJkWFJmZTdoRFdXV2R2UWxiNHozZzBlaWo0V1AvaGtvZmlTL1Jzb2VN?=
 =?utf-8?B?ellJaXpaQjlQQWp5OFVyR1lNbDZJTzRxKzhtYjJMbkFYenozazVLMFltV0dG?=
 =?utf-8?B?VTF2VWovLzRRY0ZNSk5JOEp3Mk5YdWVMOXUwWitsQmhzKy9ZNjJWQ1dtaEtD?=
 =?utf-8?B?eU1DRGxBaHFwNDNYVmMzNFArNkxES0kxR0tRdVNhcmNvZ0hCL1RCQkZpZURO?=
 =?utf-8?B?b0V3RTY3eC9KaDEveEswM1hDZ1IxR3YzbTY2NUZuMDJRVlNvdXhxOGRtZm1s?=
 =?utf-8?B?b2RyQndoc1ZHaVNwelZPSXRtZkhWSWhZMDNJamNodWFsTDdNbjlxM1RSdXlp?=
 =?utf-8?B?aE9Vd0UrVEFLMGhXSENUb0hkSnVpRWcyQ1NQUDZIMGxaajRKQzF3eVh5RVpo?=
 =?utf-8?B?TDFCc2c3UlM3M3UrSWppQ09xMlJTTFlGSEdrUnNrNzh3RDBYa0xzcktZUjJr?=
 =?utf-8?B?eThPVDAwM1JBT0t4ekU1UG9FMEg3RitYYzlTVTFJNXFZWWk1OWZ5NDNxcU84?=
 =?utf-8?B?R0JYZUg4Vm9rTnBFbWE2UXlMQkxOcVp6RDNESHlSYXJ5Rm90TkZnRnRyODd6?=
 =?utf-8?B?RTY0Y3ZWNW5EaWNkdUlkQTN3M3hnbzlocWZJN1d5cWlMOWk1alNNV3NuZnlV?=
 =?utf-8?B?MkxtQW41WHZjZU9oaHpQdVg3cWo0SzJ1L0V3bU5EalNIQTdURERSTWgzbTZI?=
 =?utf-8?B?WkxISitNQTVIMXlUSWIzZlIwSmNQejBTZXdEYithQ0VOVmtMdUtCbTVEZ0Zh?=
 =?utf-8?B?VEhaYkNaMjFnazIzdTU2UFE4ZFl1RjlGVVVqN2E4UFJMdXhrSER3d1Q5by9B?=
 =?utf-8?B?aW0xYjdPUHl3ZzNyWmlicld6NlZmYTlkM0o1RktuYTQyUXI0cnpGMVh6OHkw?=
 =?utf-8?B?YVJRcnhleXoyRFl3VnpwdXF4dzczTHkrTGVVTHdGM21Ic0ZYcDdjblNjSUxL?=
 =?utf-8?B?MVNGTGNTblllRUZFL2xEYklVbjc4S01QZ1R5dWVEcVExbVFRZjBmVlY3NkVk?=
 =?utf-8?B?c3c1bjRvK3Q2Ykp4a1VBV3BPc24rZVVNWVozbmkzU2ErK0ZFWVc3YjdXSVBv?=
 =?utf-8?B?aDFyRlphSGJ5U01NMnhmb1hXKzJSRzhUYmgzT1F0QVo4bHVVemVSVy9LdUJJ?=
 =?utf-8?B?d0JxVWZLaXFySjZzV0pHUUhsS3BRTlRsOUpCZFFuc3BZVmM4MEdiMldEeE1i?=
 =?utf-8?B?S3ZWekN3VVdJVm9GUzF2eVFXZlpWRmtnVjBueS9RWXEzcU9sMWd5NmRCZlRG?=
 =?utf-8?B?TGUzVVdlKzdteUFRZVg4cG5rbkpiWXE2SWt0QUc5TnVYcm4wVWJlRUNrek0x?=
 =?utf-8?B?MGFtOUJDSlhmL1IwK2l5cDBzcmk1amVRRjRGVW5uYU1DdE1WdTc2ZmRaTVY1?=
 =?utf-8?B?dmswNVhRbnR0SnhNcGlGZkc2MVk5TlZIRVBFbGY4TWd1NTBkdlcwSHpQd1Z1?=
 =?utf-8?B?azVqNWpwV1ZIeGdrMG4vZUlvZUE0am9KR1ZlUGloTWpQS3NDaXVNTlVnR1px?=
 =?utf-8?B?UnQ0UUtIQkZSbEtXdDdnRGtNSjJtVXVkNk9KYzlmSmZnbGhmdWdOVkxXcjZ4?=
 =?utf-8?B?UXNETzEzUC9lZTMwdDM5QUs4ZjU1cGxab0tnTThwSVZ0dHRXaW90Ynd5dnBT?=
 =?utf-8?B?WGU1dzdxTzRMNk1NUHlDVWtiMHhTVmRDZWdwOFBRSGNjSjNjWk4rZ0xGVmEv?=
 =?utf-8?B?TUdiVlBOdUJlZ3VvZ0lkaUkya1hsSnpVVjZLUytBaThiTDQ4L2Y1aHpYUHN4?=
 =?utf-8?B?Rjl4bjEwQk9qcGRMU1V0amppaFRwb1pFQ29jdmM0aEQvTThHNUY1L0MxMkVT?=
 =?utf-8?B?VEw4NThST3RhYkgzVHZaWFRkajNLUi9kWWZNOU15SjE0c1ArSHJDNmE0Z3lq?=
 =?utf-8?B?bnc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3729FC288E911E479BD0F9E822FD68F6@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB7845.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da62aad1-11a2-4c10-5661-08dc83aa9181
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jun 2024 08:52:58.8387
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9APYbty1Fo7DTOa+XyDlea38XZMGsGHncY7KzlZLP3us1vxx97dpBSRl8EhpbrkDUVLbizAFJDh3gH/FI3xNRQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6910

T24gTW9uLCAyMDI0LTA2LTAzIGF0IDEwOjI0ICswMjAwLCBNaWtsb3MgU3plcmVkaSB3cm90ZToN
Cj4gT24gTW9uLCAzIEp1biAyMDI0IGF0IDEwOjAyLCBQZXRlci1KYW4gR29vdHplbiA8cGdvb3R6
ZW5AbnZpZGlhLmNvbT4NCj4gd3JvdGU6DQo+IA0KPiA+IFdlIHdvdWxkIGxpa2UgdG8gbWFrZSBh
IHByb3Bvc2FsIHJlZ2FyZGluZyBvdXIgaWRlYSBmb3Igc29sdmluZyB0aGlzDQo+ID4gaXNzdWUg
YmVmb3JlIHNlbmRpbmcgaW4gYSBwYXRjaDoNCj4gPiBVc2UgYSB1aW50MzJfdCBmcm9tIHRoZSB1
bnVzZWQgYXJyYXkgaW4gRlVTRV9JTklUIHRvIGVuY29kZSBhbg0KPiA+IGB1aW50MzJfdA0KPiA+
IGFyY2hfaW5kaWNhdG9yYCB0aGF0IGNvbnRhaW5zIG9uZSBvZiB0aGUgYXJjaGl0ZWN0dXJlIElE
cyBzcGVjaWZpZWQNCj4gPiBpbiBhDQo+ID4gbmV3IGVudW0gKGlzIHRoZXJlIGFuIGV4aXN0aW5n
IGVudW0gbGlrZSBzdWNoPyk6DQo+ID4gZW51bSBmdXNlX2FyY2hfaW5kaWNhdG9yIHsNCj4gPiDC
oMKgwqAgRlVTRV9BUkNIX05PTkUgPSAwLA0KPiA+IMKgwqDCoCBGVVNFX0FSQ0hfWDg2ID0gMSwN
Cj4gPiDCoMKgwqAgRlVTRV9BUkNIX0FSTTY0ID0gMiwNCj4gPiDCoMKgwqAgLi4uDQo+ID4gfQ0K
PiA+IFRocm91Z2ggdGhpcyB0aGUgaG9zdCB0ZWxscyB0aGUgRlVTRSBmaWxlIHN5c3RlbSB3aGlj
aCB2ZXJzaW9uIG9mDQo+ID4gZmNudGwuaCBpdCB3aWxsIHVzZS4NCj4gPiBUaGUgRlVTRSBmaWxl
IHN5c3RlbSBzaG91bGQga2VlcCBhIGNvcHkgb2YgYWxsIHRoZSBwb3NzaWJsZSBmY250bA0KPiA+
IGhlYWRlcnMgYW5kIHVzZSB0aGUgb25lIGluZGljYXRlZCBieSB0aGUNCj4gPiBgZnVzZV9pbml0
X2luLmFyY2hfaW5kaWNhdG9yYC4NCj4gDQo+IFRvIGJlIGNsZWFyOiB5b3UgcHJvcG9zZSB0aGF0
IHRoZSBmdXNlIGNsaWVudCAoaW4gdGhlIFZNIGtlcm5lbCkgc2V0cw0KPiB0aGUgYXJjaCBpbmRp
Y2F0b3IgYW5kIHRoZSBzZXJ2ZXIgKG9uIHRoZSBob3N0KSB0cmFuc2xhdGVzIGNvbnN0YW50cz8N
CkNvcnJlY3QuIE9yIGluIG91ciBjYXNlIG9mIHZpcnRpby1mcywgdGhlIEZVU0Ugc2VydmVyIHJ1
bm5pbmcgYmVoaW5kIHRoZQ0KdmlydGlvLWZzIGRldmljZSAocG9zc2libHkgb24gYW5vdGhlciBh
cmNoaXRlY3R1cmUpIHdpbGwgdHJhbnNsYXRlDQpjb25zdGFudHMgYmVmb3JlIHNlbmRpbmcgdGhl
bSB0byB0aGUgaG9zdC4NCg0KPiANCj4gVGhhdCBzb3VuZHMgbGlrZSBhIGdvb2QgcGxhbi4NCj4g
DQo+IEFsdGVybmF0aXZlbHkgdGhlIGNsaWVudCB3b3VsZCBvcHRpb25hbGx5IHRyYW5zbGF0ZSB0
byBhIGNvbW1vbiBzZXQgb2YNCj4gY29uc3RhbnRzICh4ODYgd291bGQgYmUgYSBnb29kIGNob2lj
ZSkgYW5kIHRoZW4gdGhlIHNlcnZlciB3b3VsZCBvbmx5DQo+IG5lZWQgdG8ga25vdyB0aGUgdHJh
bnNsYXRpb24gYmV0d2VlbiB4ODYgYW5kIG5hdGl2ZS4NCldlIGFsc28gY29uc2lkZXJlZCB0aGlz
IGlkZWEsIGl0IHdvdWxkIGtpbmQgb2YgYmUgbGlrZSBsb2NraW5nIEZVU0UgaW50bw0KYmVpbmcg
eDg2LiBIb3dldmVyIEkgdGhpbmsgdGhpcyBpcyBub3QgYmFja3dhcmRzIGNvbXBhdGlibGUuIEN1
cnJlbnRseQ0KYW4gQVJNNjQgY2xpZW50IGFuZCBBUk02NCBzZXJ2ZXIgd29yayBqdXN0IGZpbmUu
IEJ1dCBtYWtpbmcgc3VjaCBhDQpjaGFuZ2Ugd291bGQgYnJlYWsgaWYgdGhlIGNsaWVudCBoYXMg
dGhlIG5ldyBkcml2ZXIgdmVyc2lvbiBhbmQgdGhlDQpzZXJ2ZXIgaXMgbm90IHVwZGF0ZWQgdG8g
a25vdyB0aGF0IGl0IHNob3VsZCBpbnRlcnByZXQgeDg2IHNwZWNpZmljYWxseS4NCg0KPiANCj4g
V2hhdCBhYm91dCBlcnJubz/CoCBBbnkgb3RoZXIgYXJjaCBzcGVjaWZpYyBjb25zdGFudHM/DQpZ
ZXMgdGhlcmUgbWF5IGJlIG90aGVyIGFyY2ggc3BlY2lmaWMgY29uc3RhbnRzIHRoYXQgd2UgbmVl
ZCB0byBjb25zaWRlci4NCkkgZG9uJ3QgdGhpbmsgZXJybm8gaXMgYWxyZWFkeSBhbiBpc3N1ZSBm
b3IgdXMgYXMgdGhlcmUgeDg2IGFuZCBBUk02NA0KYXJlIG1vc3RseSB0aGUgc2FtZSwgYW5kIGV2
ZXJ5dGhpbmcgaW4gZXJybm8tYmFzZS5oIGlzIGFscmVhZHkNCmNvbXBhdGlibGUgYW5kIGFyZSBs
dWNraWx5IG1vc3QgdXNlZCBpbiBmaWxlIHN5c3RlbXMuDQpCdXQgdGhpcyBwcm9wb3NlZCBjaGFu
Z2Ugd291bGQgYWxzbyBoZWxwIHBvc3NpYmxlIGlzc3VlcyB0aGVyZS4NCg0KPiANCj4gVGhhbmtz
LA0KPiBNaWtsb3MNCg0KLSBQZXRlci1KYW4NCg0K


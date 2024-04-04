Return-Path: <linux-fsdevel+bounces-16108-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1823B89846E
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Apr 2024 11:53:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 35BF51C22D42
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Apr 2024 09:53:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5075C74C09;
	Thu,  4 Apr 2024 09:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b="TO/6z69n"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from outbound-ip168a.ess.barracuda.com (outbound-ip168a.ess.barracuda.com [209.222.82.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECE1D1B7F4;
	Thu,  4 Apr 2024 09:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=209.222.82.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712224422; cv=fail; b=l8tzNhF7aCGFDEdbJaNhX8drCcXceBHYzzQBjZkpnqbtYoONvfr9DNWVbSI7ZBc9r3y+xiX1yFpjyHP3ORGs6AXOZUbB35WsZ/DKoM2DmhFBo2wcyx9dS2++TBsIpwv3yQLD6wEb/qHo2zKe29xAnDbI6BbAGws9KXhJSayOH0A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712224422; c=relaxed/simple;
	bh=rGYxBi98yFVVoG9PTZb8NB5eFIi10bn5jN+p2XaWZPc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=V0jcxsghlwZXA3F/UKmOjaEwMAa1R+/qREqQKkXLjH1GKdxG4eX5HFc19YqNsiH5oUhaKHO+u4u32unNVz9k7YfmDijZJ9BxU5iXZzkrId9/Kkjc0F7qhLF9tZ2uhNjaO1cgZmy0vIzAofVi9kDCkrMTRMtXryn0m1MPxN2nxy0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com; spf=pass smtp.mailfrom=ddn.com; dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b=TO/6z69n; arc=fail smtp.client-ip=209.222.82.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ddn.com
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2041.outbound.protection.outlook.com [104.47.56.41]) by mx-outbound45-126.us-east-2c.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Thu, 04 Apr 2024 09:53:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XzKCJXXmfY6xeMGlHu2vf4c+5snyECLLHADkT8dH5zSWFuUNyauK0HE44yt8pCWWCUO/FkVdArYcWGZ1ODxcKY0URaLiVvoXTP5ufviXraUDv6zJ/M0iYg3+NBUOl/Awwlg2z9Bqe7NxLnYrfnJfAUZM4/WzyHoQuWbq35XrGK5K/QkAbSajUKsXgJT4ajy+A++Boh92M/cobD2AqsUV076VzzrGlz/SWDS81Nzvow0yWLCfJ/xGOqe+GBlvIfb3kFyFl4fqVg9HjX89QOx2mk24ELoW8sbPVPwo+pnRI0oq+6jNDZUR6EXmMERmHtOvLZcO1YWT0mMFAWk0RbMkXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rGYxBi98yFVVoG9PTZb8NB5eFIi10bn5jN+p2XaWZPc=;
 b=eycfn7PgvRY5NXBvPL52wNNlkYoqEZzc5JXyWwFSMnfGrLU3+ONZpi6nY0Pfk1E4MPdn/Yac7O3rgsHvYQZ4e8IpaQ0iUkiJzEiwDo/BMrPr6xDGYbH8AQS9h6y5jv3e5nKDEeZ1PjauczdcBrU9tEzUozvOBG+UZFFY5Apo2mqwNQERoiK2dnqQRnsbSW8HoN2aJNiqGFLs2Ugo5yK9Vqf1gvH+KyreXuzBXqYnx5LFOJAArowHegV+QC0ecBQYJLJgTteisMsqGfCBqKoU4puJt6M5shWtFvk+GNbqMDegMiA8fTGMEo2EZP48vMqgn8sLadWHqOEXPQGor2GQJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ddn.com; dmarc=pass action=none header.from=ddn.com; dkim=pass
 header.d=ddn.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ddn.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rGYxBi98yFVVoG9PTZb8NB5eFIi10bn5jN+p2XaWZPc=;
 b=TO/6z69nGkLrMzTaFWkdfZTU4ZiIfwJYrUW98e5xORJy46xxf0q5fugxM2Zbac4enNonzmOy0N/x3gt2BKVqcgoCKhq2cyK4ePMU5O1Tdb3VhXGonaEBTGnMTLe5HN+buQmiF0nSvNXp/vLx6BB9syt8D6TtypVmWxRCoeGC97U=
Received: from DS7PR19MB5711.namprd19.prod.outlook.com (2603:10b6:8:72::19) by
 CY8PR19MB7618.namprd19.prod.outlook.com (2603:10b6:930:70::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7409.46; Thu, 4 Apr 2024 09:53:11 +0000
Received: from DS7PR19MB5711.namprd19.prod.outlook.com
 ([fe80::8a58:247b:a09d:ede2]) by DS7PR19MB5711.namprd19.prod.outlook.com
 ([fe80::8a58:247b:a09d:ede2%6]) with mapi id 15.20.7409.042; Thu, 4 Apr 2024
 09:53:11 +0000
From: Dongyang Li <dongyangli@ddn.com>
To: "hch@lst.de" <hch@lst.de>
CC: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"axboe@kernel.dk" <axboe@kernel.dk>, "josef@toxicpanda.com"
	<josef@toxicpanda.com>, "lsf-pc@lists.linux-foundation.org"
	<lsf-pc@lists.linux-foundation.org>, "joshi.k@samsung.com"
	<joshi.k@samsung.com>, "martin.petersen@oracle.com"
	<martin.petersen@oracle.com>, "kbusch@kernel.org" <kbusch@kernel.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [Lsf-pc] [LSF/MM/BPF ATTEND][LSF/MM/BPF TOPIC] Meta/Integrity/PI
 improvements
Thread-Topic: [Lsf-pc] [LSF/MM/BPF ATTEND][LSF/MM/BPF TOPIC] Meta/Integrity/PI
 improvements
Thread-Index: AQHaaQmqs4xTfFwV8Umi6fEJWz7IwbFVA82AgABmiwCAAUuvgIAAAMuAgAFi5QA=
Date: Thu, 4 Apr 2024 09:53:10 +0000
Message-ID: <960abc87208c55c74ba18c1ff0ae63921beb8624.camel@ddn.com>
References:
 <CGME20240222193304epcas5p318426c5267ee520e6b5710164c533b7d@epcas5p3.samsung.com>
	 <aca1e970-9785-5ff4-807b-9f892af71741@samsung.com>
	 <yq14jdu7t2u.fsf@ca-mkp.ca.oracle.com>
	 <ab32d8be16bf9fd5862e50b9a01018aa634c946a.camel@ddn.com>
	 <0c54aed5-c1f1-ef83-9da9-626fdf399731@samsung.com>
	 <d442fe43e7b43d9e00c168f91dcfddd5a240b366.camel@ddn.com>
	 <20240403124255.GA19272@lst.de>
In-Reply-To: <20240403124255.GA19272@lst.de>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.50.3 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR19MB5711:EE_|CY8PR19MB7618:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 /CgSx7Dp2mVVg95LdZDTa95ZqCWK/wyACNM+S50Cr0NPWFDPL5/1ZW4a4TBQnCn/n6jpCO5s6UfHRjLdTwgmCWkd5iI4gdZNDd4Rc46r2XHslba8ShmOd4B3vZsE6sG56rPUj2b5gw0ikRewpEecgTJ5tQ2Ar5GtaBJo47NGpXvBcBeJ3YHg6KXNUW53CRew/9q0BakAEhnpNozka+NMGufXE0zydqnJr8JwgU79ZgN7Ey73Ak18TN23PuA3LeRBaVMyaHwyuyUj3k1zFRpUFxOdNzL+UnuQdlQ/uQHdavVq2qxkCeyJ+tflZWmTyPXGaOObfytV+VsnBB+aoK47IQ+db2X3Qra23uZaMk/lLVJqi44zkdA/aRF5Q0kzdW2nRKyPccMBRaSyBW9SoHsUko8d1fnxDRLaoHR4x7m1WWcvjD/V3HcA6jvMtNNUIpf+7ERRRSbpxSBfjKVrmvX+qoWeMPzMBUZh63+fbyLYLvxAzHF9pvOS9dZlq0kXMHcmAwgCtnXat1pgqMDEwwutoBWNrLwBBIC4gg9nu8v17eQ3Uy/cfTF2T8iOPLi821ToclX8kaX41iwBJY159ir2qSoamQuZP6YfiJXOkzUeneRJU+4pWtjmuflcJRSV7x83cHkOjH4KiXxbqt6/5E93FUHlWYyiGPAeL3WL2kJlJLM=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR19MB5711.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(1800799015)(376005)(366007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?U0RvRFc2Z0lNSDNRUi82eGVaY2JjYklVei9EdXVaNHhONzBXQXpqMks5aVNX?=
 =?utf-8?B?NmkvOWJvTFhXWEJ0MHBhKytIeHo4c0t1WkZKUUpvcUxsWjdNUzdxVmQ5OEcy?=
 =?utf-8?B?bVgxQStJL1lxbFFKREgwRXZXeHVHcE5SWGRUOVhMc3J2Q2FPa0doc0dVM2M4?=
 =?utf-8?B?ZEttbUVFb1o2TVdmQVFLM3BabWROR2NvOFczYVJ4ckxWaFA1VFpSTmZwdWwx?=
 =?utf-8?B?Yk51VjVjaGF0dEdSbDV5cmpZWERxUFB5MWRmWXQ4ZGpTWmNLaWp1WjNjUEdX?=
 =?utf-8?B?bllXMXpxQitIMFJ6eDd2T2hBSHpCbUt1QWx1Z1ZDcVd0OGsxZzNPclpIbm8r?=
 =?utf-8?B?cmVrejlqY2t3bzJRaXdLZzVmeXR2U1o3TWo2eWtpa05rWEd1TGgzaVdGMTR4?=
 =?utf-8?B?cTNQTEp6dkxGNlNnOTBEcS81MnF0QzZueDVaOGthRFhFK3diUm10T0ZuUFZ1?=
 =?utf-8?B?R3JZcm9oaVVYTDBJSzhPekpod0pNQ2NKbmd5NzltSUc1YXFEMGVKL1g0bVh1?=
 =?utf-8?B?WkNkdkJBQ1JZMktPSG91d2lZN1JUOThFWHZENXpvanlkdXp3TDNtRk9iL3d2?=
 =?utf-8?B?RHVvb1VQQTlhWEFpU2w5QWw0RGhWUnIzOG1nVDBYeVJFakszaU9rUGJzcit5?=
 =?utf-8?B?UGJVdXN0d2NWZUIrMnFyWThNTXBTVVhZK2ExWUVKMDhHNDducTlLRTZlU3NG?=
 =?utf-8?B?a2ZEQWFCeGhPejBDZmVxNi9DM3hZQnI2WkxCT0RqYXdjRnVRMG9iZFBXcG5u?=
 =?utf-8?B?dWVBaEIvWkoxMjZic0Y0Y0JqZDVjV3I4VnZQWFgySlZaOVBrNmFubXdCY0tI?=
 =?utf-8?B?WExKclZMWk5TdjdYenp3MkFDdldvV25RU2FLS003MmJIMnFGN2VrZmdFU0ox?=
 =?utf-8?B?N1pxanNXNnNNZUZjeE9BdUZ0ZTlHTUVYVEkzUTlQcDNsZVB3NWZmWE5yaWdE?=
 =?utf-8?B?RTV5bjdhdWtrY2FlTnRNSzVNdndTMXU2SWZVRUgzZyt1Vlp1QXJWSFF0RVlS?=
 =?utf-8?B?d1VENDlCZEZIL3hZYTFFREhPSmFQTkRTT1Z3aHJ6N09uV2hxMFNrekppSUtq?=
 =?utf-8?B?cjFKRndPK29Mb2ErdlV0R1lWQW1ucDlPSklqczhJR3hZVlU3bmhQOGVVeXRD?=
 =?utf-8?B?dTllYlBNUzN6U0RpQjAxR2tyL3VyVk5PNzE0U3I3VGMwNjQ3cjN3cDYzK1Ji?=
 =?utf-8?B?eDl5WFZJOVhPcnBadTJQMHV4WjIrbEIwWWNvTVVob0t0VkM1RFVUTlpSZXgy?=
 =?utf-8?B?L05penV0TEt6bU5CeXJtMUVqTzRtN25zdDNYNHV1b3FSa1VKcjRMcnZxeUY5?=
 =?utf-8?B?b00zZ3RGYUNxWGpTa2hVdlp6elp6c3Q3TUlianR5MlpUYXpxTHEySjlHbDNm?=
 =?utf-8?B?K2IwdkxaVmFDY3loL2Z5YVZYdjk5bG1Jdm9GNzcyVjdUN1NhOXdRby9qNHJw?=
 =?utf-8?B?ekpTellWYXpiYXhXY1VHR0FqVXVLcGRrZ1dLbkM3b2xlaFVNazh3cUM2cTFM?=
 =?utf-8?B?MFRUWmF4TG9wNVF6SXVFRFdkdDYwdnB6ZXFjMmxWOFQvRTJqbXBDdS9neW5n?=
 =?utf-8?B?SWRlU1hqY1B1RVVEY0VCaXc1RmpTZENLYnZrdmdTQlNWR2dBMmZSNi9zOXVD?=
 =?utf-8?B?VXdBVy9UWEJqcUJFdE15UzNPd3VqUTY5dUprUnRkbVVyUE1ydjVXNWxtYkRo?=
 =?utf-8?B?by9sVjR4Q0FqWm1Ha01EdURJR2N3N3BoOURqYnAyektkQWJoYkpYSXVFWUtC?=
 =?utf-8?B?L1pyY1p1dDc5bW5nNkVRSG9PcVh5aG9xRVdvNXprQytnZUNKWWJOVU9oYUpB?=
 =?utf-8?B?T09BSUJhd0FJUmM2dEVINXY4ZXdNb2JBOG9LTjVueGNaK2tmNEVkT2FvTzMy?=
 =?utf-8?B?YytZWXVuc3czQk1ja0lucldyVzYrYVZ6Q2tSYUZ1OHBmNmd1WTlsZWRPQkdz?=
 =?utf-8?B?WXloR01CYk5zcEpRRitxNGFQRUsxWDM0Z2xMVVRhdlZraFU3OG10UHdWUFZv?=
 =?utf-8?B?d2FVZG9hT2JtaTlrdngwTmR0cmU3V3lwcnlYK05xR1VKdy9yZ2hGM2MxZVps?=
 =?utf-8?B?RzhJQnZIVk9xaENBSiszMjlUV253SitvdDNoWDhqS1hSSGltM095VTFhU0RJ?=
 =?utf-8?Q?jTR/bPP9w82u1CngMF3RqH1XK?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <296A2BE6A7FEB64FA4F6F31735157BF1@namprd19.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	kCVpXZHEK6UMiBniqo0CM/UrXdxg75xXZTc1BqyV1hKaSxTUpAOD8XgTZC7GmqVn2ksi0NhegkiPvgHj2mR6XOS2JUSSsiu9VelRJzu+kt4jznm3hcwN7oU25B2V+7hj1Z7zlTZklqjxypCYRn/hf4NkqAjh00IS97+FS9c7FeVHKnL/nzeVyg87NRLt+1jlA5FzqRdlIKLCLneaJkG2vRFYGbfVJ9X0tHnCd/giErMbSmNRsrITjKw5pcGDEYWXlAI3vSoEclkisZtsvjVWJ02Ie3t6q9ObptUOK7tkMeL1hoRvjUryd/SGjcjjiblcVEJFqJIXLIw+KyUhUKnkIv4yUg/GwGfz7ajdI3V3pbRRCY9DC6HKcJFnGXdR8TePmhQ/nmrZtg60wgUZGdftPFGg6BKVEvnP6RlWk/meUZ6kF1lg7LfHv8tQAuqM6pAa745HDC8exTVsIuKG9dc+a4nSoo7hb61k8baLK5bcv8V6Fszmebie41wt6iB0rrGlpdw7zNnjt/QUXbqjyEFOV46j2cipPCfFK6DNaSljLOZ/ncwkgp8VzH+mlUIaOnDNsJYVdk8xdbAfNl95y5KZtsMyQ364EeVwrPxI0rmeTNVk15xp4NPu/dVUFlRRV3CiGWItkNdLLtQ/3ZlMy+J+HQ==
X-OriginatorOrg: ddn.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR19MB5711.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d5379c0-2dfe-486e-b6bd-08dc548d09b3
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Apr 2024 09:53:10.9050
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: m5jXX5dKBwzmwtNfa7SrC5bZZbm8bRiboH43vUXg6lAldd26iClH5TZTCJShe8Rl
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR19MB7618
X-BESS-ID: 1712224392-111646-24410-3423-1
X-BESS-VER: 2019.1_20240403.2023
X-BESS-Apparent-Source-IP: 104.47.56.41
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKViamFkBGBlAsMc3Q0NjANNE81T
	DJ1MgwNc3ExCzFzCQx2SgpySw5xUipNhYAvdD1TUAAAAA=
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.255328 [from 
	cloudscan9-178.us-east-2a.ess.aws.cudaops.com]
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------
	0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS124931 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status:1

T24gV2VkLCAyMDI0LTA0LTAzIGF0IDE0OjQyICswMjAwLCBoY2hAbHN0LmRlIHdyb3RlOg0KPiBJ
biBrZXJuZWwgdXNlIGlzIGVhc3ksIHdlIGNhbiBkbyB0aGF0IGFzIHNvb24gYXMgdGhlIGZpcnN0
IGluLWtlcm5lbA0KPiB1c2VyIGNvbWVzIGFsb25nLsKgIFdoaWNoIG9uZSBkbyB5b3UgaGF2ZSBp
biBtaW5kPw0KPiANCldlIGRvIGhhdmUgZG0tY3J5cHQsIG52bWUgdGFyZ2V0IGFuZCB0YXJnZXRf
Y29yZV9pYmxvY2sgdXNpbmcNCmJpb19pbnRlZ3JpdHlfYWxsb2MoKSBhbmQgYmlvX2ludGVncml0
eV9hZGRfcGFnZSgpIHRvIHNldHVwIFBJIGJ1ZmZlciwNCmJ1dCBJJ20gbm90IHN1cmUgaWYgdGhl
cmUncyBhbnkgdmFsdWUgdGhpcyB3aWxsIGJyaW5nLCBsb29rcyBsaWtlDQpiaW9faXRlZ3JpdHlf
YWxsb2MvYWRkX3BhZ2UoKSBhcmUganVzdCB3b3JraW5nIGZpbmUgZm9yIHRoZW0uDQoNCkNoZWVy
cw0KRG9uZ3lhbmcNCg==


Return-Path: <linux-fsdevel+bounces-18576-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C597A8BA896
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 May 2024 10:19:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F2541F22A2C
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 May 2024 08:19:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07BAC148FE2;
	Fri,  3 May 2024 08:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="jW8xozV4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2046.outbound.protection.outlook.com [40.107.243.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 558621487E9;
	Fri,  3 May 2024 08:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714724341; cv=fail; b=sQjnYslGxym2lEp7SVsYRYvFcMnju+zucsxIBjzhn7asMg7+OpPeK0keddileMTMirhJ+lwV72DeVHwcukSKbn6L6rmIrUxvjuNsNJcL/ft0fF66k0z3QSbj/qEPXOBac0PjrRAGjJXE5aHOip15R5o3Hn95RTmMMVQXjAO1+Gs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714724341; c=relaxed/simple;
	bh=E57zS8pU9+M/87XYA+RUYsP8Z9rnYqgFLysuDOFUVZ0=;
	h=Content-Type:Message-ID:Date:Subject:To:Cc:References:From:
	 In-Reply-To:MIME-Version; b=TurV0KCs1rG16L+qZTkQNkoLLrC/HuKTmki+jphlwTazJTdldz69crLn/UFVggfbs7YMAkA+E5PP6mAy3N5NRQGp7rXzIR2EU9RpUNH2B5JC75awDLUMuQETymGywdV9GrBSbNVDZszoUh/3tuY24fjp38nUtZsTc3IvD/uQ0RY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=jW8xozV4; arc=fail smtp.client-ip=40.107.243.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JFUB3fHBLxpTXeX0Iqyjpk4e2AeYWUmDyArZCTEggI6nHX8ZYekhLKzub/wwRhKm8BbazdsbWADGrJzKuaep0X05GPbcfeAESM0Qc7BCSIrZA/fgx9IKcMtxpIoWWUSBKm0WFkZ+R0M+pbywrmlkFLyuf37YLn6vtkJhCC79mvDIsOINkJEADOMukI3j5iLfbTqSVXyUgvF/P1eUniRVh3u3jXv20ga0SwS8h91PqpRS2Dt4aTEFjW/K5s+MVET0Absqol2HTQ87ifscj2rXIhSnHGK/X4i7SiFCAIOmVU6FWXcUmeA87ZgpKNzLm8nKX44eHrl1u0nqKd1mxzFXIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o915BZ04WlVC3i2TAMpdiP+uc1WoYeoEJAgVkWSv4yU=;
 b=e7gkuuNJYo1zxjm4GqHuLez0GLFTVVJKzz1DHby/Oz4mPQIgXwVhTBK8vXnuF5+m9yClmBLaIetsCcYDnONoClSizlRUHMoh22bwGsqEZkUATL4Fm3FDLW3OoW7/Z5KNKvGmUJJEVRctA/aCepeOw/Ib9DYcMwBRFyOIeiy6y2IZJblpOUlNBiKGx2FXgOIizRVgwUrKLxIdhVkg4E3LmOnDfWyt3ekyltBMtAsZ8h1ZhiswpGn923aoV3SvJLrBJKayuf7bx0gkfd9itCsGQMN/a5HlCxyqIEBNCmyG0CRYv/+siQxEFLH4+AsUOeO7fUSMtIJQGlRHISrQkDuM2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o915BZ04WlVC3i2TAMpdiP+uc1WoYeoEJAgVkWSv4yU=;
 b=jW8xozV4xb5K1nUiEneCV6Sdhz0cvpet5/u8K4uUQf1bzJF9WLckKVxvDF8L0U9uscKQoBaG0xBQVw2z4O23sHBVQu6wi77tL7fYYqJN99O8iLR77oyiV54EDvIPuaqIXNHStuFFAAHd4ZTu3T5ob+VP3oI99r03zs9+T9X3ags=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DS0PR12MB8454.namprd12.prod.outlook.com (2603:10b6:8:15e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.30; Fri, 3 May
 2024 08:18:55 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%2]) with mapi id 15.20.7544.029; Fri, 3 May 2024
 08:18:54 +0000
Content-Type: multipart/mixed; boundary="------------N8iAFb3zsMHHLBMpyFe3ApK2"
Message-ID: <a87d7ef8-2c59-4dc5-ba0a-b821d1effc72@amd.com>
Date: Fri, 3 May 2024 10:18:39 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] [RFC] dma-buf: fix race condition between poll and close
To: Dmitry Antipov <dmantipov@yandex.ru>,
 Sumit Semwal <sumit.semwal@linaro.org>, Zhiguo Jiang <justinjiang@vivo.com>,
 "T.J. Mercier" <tjmercier@google.com>
Cc: linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
 lvc-project@linuxtesting.org,
 syzbot+5d4cb6b4409edfd18646@syzkaller.appspotmail.com,
 linux-fsdevel@vger.kernel.org
References: <20240423191310.19437-1-dmantipov@yandex.ru>
 <85b476cd-3afd-4781-9168-ecc88b6cc837@amd.com>
 <3a7d0f38-13b9-4e98-a5fa-9a0d775bcf81@yandex.ru>
 <72f5f1b8-ca5b-4207-9ac9-95b60c607f3a@amd.com>
 <d5866bd9-299c-45be-93ac-98960de1c91e@yandex.ru>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <d5866bd9-299c-45be-93ac-98960de1c91e@yandex.ru>
X-ClientProxiedBy: VI1P190CA0038.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:800:1bb::9) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DS0PR12MB8454:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e5edfbd-3605-48fc-15bb-08dc6b49abb1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|376005|1800799015;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UE9CV2VIWXdqTGx6Sjk1VmdaZm9DQkNqTzRPWHUwL2dhazM1ekxLVEVTalR3?=
 =?utf-8?B?V0JjbHlBTTRCMnpScStMa2RpajNkZ0p0ZUQwZWxUY2JUY09pa1lGTkQ0cFBR?=
 =?utf-8?B?RDdjamQrT3JTZXlSTHMxdWlkUkFoN3JTZUZXdVJGd05VaUduZUFxL3g2RkVK?=
 =?utf-8?B?ZDR1bmtRYTRHOE56em5DcDJPQmxWWjlHSlpPMkR0TCtiZ29ZUlZRZTJqK0lO?=
 =?utf-8?B?Z3JJWkJXRElLYkxFTmdRS0NwVGZXbjR0SEZDQW8rSHZlQlV0TUxFcE1VZnEr?=
 =?utf-8?B?MEFBdGtYbUFuVTJzNi8zWCtLUkErUTZnMmg4aHhXcFdFMjRwY3UzVUFQWHI5?=
 =?utf-8?B?K2xjTWIvd3FlZWV3RXFXRkw5OVo3ZnluNDdNalpJY3VhekhZSzFoT2R0S3Vq?=
 =?utf-8?B?eHVyb3ZKbi9FalJxVzFFRG1oTmFOdWxRVGhpQjhibUV1MDZFL3BYc01FMWgr?=
 =?utf-8?B?Y2V1K1dZaXZLWXhHM29WNTZuTytiRHA0aEdrcUFTeXgvdGpaS1hrMExUYm01?=
 =?utf-8?B?RTA1TmdPbERpdnBFdzVrN1BSY2JINHh2aEtDZFpkVXJDK2JzOFVmVTVrQkFN?=
 =?utf-8?B?Vnk0dmNiWFpaemZleHl1Y0FwZExUNWtSQ2NSMTVGQjJ1MlVZKzRqdFgwK0Rj?=
 =?utf-8?B?RkpQNWxidVVSU0VYVTd5YnRnRlpIWkphcFJCUHRva2dnWG1NUklxR21CYkhO?=
 =?utf-8?B?bEo5NTJqRENUelpRL1NJYXR1ckRKVTh0ek9OSjQ5ay8yY0dvVGIzQk5uNHdW?=
 =?utf-8?B?NGhmSFgzR1FvYjljNWM4NWRhZkM4YjlQbXVreDAydHkrdmk4MkU2N3phRkRa?=
 =?utf-8?B?d1FzQ0FSQ2p6YU05SkxoRjQvcCt4N0sxT1BFcCtHa2ZidzZoeE1tZnhFR0RG?=
 =?utf-8?B?b1NlQm1hU0V6a2VVcTgyL1BsUUoxUzRhQUhyS1ZuZnJMNEx2bXUxbzk0S0Jj?=
 =?utf-8?B?RU5nclNPTUNmc3RMVFpGcWlFY0E5ODlNQjRKUTlMMGxzUVNlQzdlcSt4S0tZ?=
 =?utf-8?B?RmhybUpZMmhaMXFlNGRDTHdLZWF2N1VTeWNhMHBXZjNmN1FYRGpMM0ppa1l5?=
 =?utf-8?B?cG5WZ2RBc2VZVVBFbW1mM29DUWlqRnpxc1NHYUR2WUxaRkR2dEZSWU1uL3V4?=
 =?utf-8?B?RStmUnc1aGV4TFNTblQ3NDQzMFc5VStDNlkwalBTeUdrZHNOcWQ4Q1pzQ0ZI?=
 =?utf-8?B?WUVHMTQ3OTlySTVKelI0N3kvcFgvZ1ZGSUdja1orbGNLWmF2QjNXcjVPQWxW?=
 =?utf-8?B?U1V6aGZLKzNIRjZLZzRXRE9DVHhoRFBFbUVXN2RrOEozK3prOU4rNjhFS2lM?=
 =?utf-8?B?QjRMQ3RxRk1zQlBML0x4K2Z2dTdYdXo2Y3RuMVhjTmJ1L20xQjFNL0R6VDY0?=
 =?utf-8?B?UWhKWEJXazhIS21DbldjTVJvUnMwbTQ4OEpybUZ4bmlueElWSkRmRG4weHpw?=
 =?utf-8?B?OStVN01yNm9QdWFxbXdodkJZOEFzanNMNGtIUE9aR3JqV0dpQUN6YjQrcnVJ?=
 =?utf-8?B?bzY0RFpXSlhDa243RWtSL3o0bCtJRTlLNVlWb3BrYnhFTXRidU1vN0hCUVJy?=
 =?utf-8?B?VlcrK1Z0a1BGVHJwS0kyWDZMUGdBZ1hPUlFLRUhaV3JJZWIzNW52UlM3Ulc4?=
 =?utf-8?B?Wkh0VjFqczdMRzdVckVBNmNsS2FLTXd6R2dnUXZ6L05EdWh0V1BzSCtmZkox?=
 =?utf-8?B?VG1QRUNXNmxwMFpwaGdSeWVlV0NBbWladXd6NjRlQmU2dWFONjV0V2dnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5685.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QXBwWHpoNW11UDU4K0NzUWRPV0ZkemExS3liYnpaY0dBRjVtV0I0Wk5BY1p3?=
 =?utf-8?B?aUxUa1JGOWJtZ3F1RnhXREptTVNKZlU0S0JZWnJoOGxtT05CU3U3dnk3cE1H?=
 =?utf-8?B?V2piWFpDOWxGeEU5OUdZVkdhS0xLZDRLRlp1anlpNGFEMnVFQnp5OExjbldj?=
 =?utf-8?B?Qm85YUNDbVhUSGxGY1hyYnFHdnVNRkFxOHpWb3NiTXNpOGV0K1dMTWlzTU04?=
 =?utf-8?B?VVdoSWdTRTBHYVFoQm9KTDRzanV2eS9CVUd0dytCcFF1eE41RUFIK2kwSmNN?=
 =?utf-8?B?ZmRtR2VLSlpiTWRNa1JZTHFxSlBVRVBldGU1bks2ZlROb0JhNFN0b2M2SnA4?=
 =?utf-8?B?RjBjMXBPUXFTUWdKMXd4SGVvenIwQmkxYm1pVTRBL1ZQWXFqSGV3WERxVkNn?=
 =?utf-8?B?OTJrTE8zYSs0MkxleVdJbU1lV2tobGxucE9halRsblRIdVpzVFhyOGVFSGpi?=
 =?utf-8?B?THBYNGd1U0lTTjBaeTJTOGZ5bDNvellrelpobXl2WUhzTDd4YTdDT0FlR0hY?=
 =?utf-8?B?Ymlqaks3RG4rbEdZVlBrMDZScmpBQ1NkSVo1ZjlvSTZ6TXVRY1pRS1NWT1Nv?=
 =?utf-8?B?QWZWb1MzZjEwWTh3QWJlZ1V0Q2JrZ2VrTThDSDkvUnlRbVE2YlJtdnZzNjN2?=
 =?utf-8?B?RHlrWUpmSGVqZm1YS0liNkVBVHluNDcrQTk0S1ZPakJkQ0JFS2pRQXEvTTlT?=
 =?utf-8?B?OVNLQnYySXJxNEJjTzFtOUx2clNxWXQrbklEd3YrSk1jTWFkQmJDa0RLcExK?=
 =?utf-8?B?VVU0MUJab0owWERYcHd1YUl1MUduam9EdVBxcUlhenVITXBYdVFNWkN2SkxG?=
 =?utf-8?B?MHhFamljdDVza3psdXg0UW9SbVlOSDRVeHRFWHVTejJuQ1JSMzhhbUJidWF4?=
 =?utf-8?B?OTZTaGNsa1J4YU9yUkw2UjlDNXpzb3JLTjJjb2RINVpMdnIrRVlqNkhMSGdH?=
 =?utf-8?B?c0R6SmIwRzNFcWIwYjh4YkQwQ01rZUR5ampiQjJJd0pESUZwSlpLWEY0alRq?=
 =?utf-8?B?QXBrNi9IbDN1elJzUUk0QW00a0x1VkFUYUZwVFZXL1paemRiV1RFZDNxZzJQ?=
 =?utf-8?B?OEUyclpyY3ZrM3VHMDhaOThab1Uvc295UzFJRUxYMGYrOEk1NXIyTVhOcjZY?=
 =?utf-8?B?R3BDYk5oQUxRanpldUJUakorVzRsZVI4dnM5WWJCemNhL1NwZzZkWE9CZkxy?=
 =?utf-8?B?VVA2bncxWE5LdE40elhkOEJDSnowaHZ2WXpsSkhlYXVKSGVYRnZ5NEFONmFM?=
 =?utf-8?B?R0JDcnllNEhqZG5MVFBXWjNKS2haR0pRbHZOUmxkSUVlYWs3ZVNvbXVWamFQ?=
 =?utf-8?B?cGJrai9DNTV1ZXNqR0QxcEZUeDYyY0E4QUZaMU4vNElsSTRybjFLQkZST014?=
 =?utf-8?B?dDA1T1FTMUVjTHR0bVpoMUtFYStoTFB0SXhaSlcxU2hsZUtwVThiVFQ5VGd2?=
 =?utf-8?B?ckwrQnB2cVVTZHpYRTkrRTZHdnQ5NnR4YkFtRXZWOWkwTFBjSmtBdmZjN0g1?=
 =?utf-8?B?QUErRUpGUVZNRVgrcU5Yb2t3V3ZDdW5tQ2IvWVgzc1k4elhjMS9zeUQ5Q2lw?=
 =?utf-8?B?R0R3U0tJTVRpOXJXcTg3VE5qc1VNMzlMR240WlhRcGRMVEgzVjlyZ1RRS0J2?=
 =?utf-8?B?OFVzOFdJcVVpZWhJNDhGaUt3VHB2TVgwZStZRXhqL0hFUWZYanFLY2w0WUFn?=
 =?utf-8?B?am1KUS9GYkI2cm5xc2xHbUEyMUJYd24wY1pLRVlvTVlPTm9yQi90Z0h2SS90?=
 =?utf-8?B?MkZOa05oOVZHWGRvOUI5NVpqUnBxZGRKeXNFU21hTDJHSVZPamZwQmkxQVNw?=
 =?utf-8?B?cWlJS1o1c0ZrS040bTFzOFhXUGdEYzk0TnVCSkY5QWxhYVdSWTdnWm9YeHp5?=
 =?utf-8?B?ejgvVjZXMWtwdFkvQ0lqQ1FWZXpWZUZZN2tiVGVndUpvRENWcEx2VllxNjlp?=
 =?utf-8?B?Q053NWFSbDVrTXorbVJ6ZHo3WTU4bU1DcC9JT2U2SHh6QjlUQlBEdHltOHla?=
 =?utf-8?B?TXhSWEU4Y2pBemlQTXd0ai9JMUVqS2NWcExqd1NWb0ZMQTkwR0VmMWp6cUoz?=
 =?utf-8?B?YmRuTGxFb1BndFZlSFdEdTYzY0tPZXkzK09XajhjSzBnUkQ0ZkdFaHlYZUlW?=
 =?utf-8?Q?SxcD5fcyuxmHPiizrni3YxmGt?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e5edfbd-3605-48fc-15bb-08dc6b49abb1
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2024 08:18:54.2446
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rS4GPd+N2CrA9pRlA7qI5e/z5AiuLxyVZpJi5Tje/wYuCjSr4fB6FPZluEoDPhrc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8454

--------------N8iAFb3zsMHHLBMpyFe3ApK2
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 03.05.24 um 09:07 schrieb Dmitry Antipov:
> On 4/24/24 2:28 PM, Christian König wrote:
>
>> I don't fully understand how that happens either, it could be that 
>> there is some bug in the EPOLL_FD code. Maybe it's a race when the 
>> EPOLL file descriptor is closed or something like that.
>
> IIUC the race condition looks like the following:
>
> Thread 0                        Thread 1
> -> do_epoll_ctl()
>    f_count++, now 2
>    ...
>    ...                          -> vfs_poll(), f_count == 2
>    ...                          ...
> <- do_epoll_ctl()               ...
>    f_count--, now 1             ...
> -> filp_close(), f_count == 1   ...
>    ...                            -> dma_buf_poll(), f_count == 1
>    -> fput()                      ... [*** race window ***]
>       f_count--, now 0              -> maybe get_file(), now ???
>       -> __fput() (delayed)
>
> E.g. dma_buf_poll() may be entered in thread 1 with f->count == 1
> and call to get_file() shortly later (and may even skip this if
> there is nothing to EPOLLIN or EPOLLOUT). During this time window,
> thread 0 may call fput() (on behalf of close() in this example)
> and (since it sees f->count == 1) file is scheduled to delayed_fput().

Wow, this is indeed looks like a bug in the epoll implementation.

Basically Thread 1 needs to make sure that the file reference can't 
vanish. Otherwise it is illegal to call vfs_poll().

I only skimmed over the epoll implementation and never looked at the 
code before, but of hand it looks like the implementation uses a mutex 
in the eventpoll structure which makes sure that the epitem structures 
don't go away during the vfs_poll() call.

But when I look closer at the do_epoll_ctl() function I can see that the 
file reference acquired isn't handed over to the epitem structure, but 
rather dropped when returning from the function.

That seems to be a buggy behavior because it means that vfs_poll() can 
be called with a stale file pointer. That in turn can lead to all kind 
of use after free bugs.

Attached is a compile only tested patch, please verify if it fixes your 
problem.

Regards,
Christian.





>
> Dmitry

--------------N8iAFb3zsMHHLBMpyFe3ApK2
Content-Type: text/x-patch; charset=UTF-8;
 name="0001-epoll-fix-file-reference-counting.patch"
Content-Disposition: attachment;
 filename="0001-epoll-fix-file-reference-counting.patch"
Content-Transfer-Encoding: base64

RnJvbSA3MThlMTBkZjYxYzUyMjY2N2NiYjdjMzI5Nzg3NjFjYzNmMWE0ZDNkIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiA9P1VURi04P3E/Q2hyaXN0aWFuPTIwSz1DMz1CNm5pZz89IDxj
aHJpc3RpYW4ua29lbmlnQGFtZC5jb20+CkRhdGU6IEZyaSwgMyBNYXkgMjAyNCAxMDowMTowMCAr
MDIwMApTdWJqZWN0OiBbUEFUQ0hdIGVwb2xsOiBmaXggZmlsZSByZWZlcmVuY2UgY291bnRpbmcK
TUlNRS1WZXJzaW9uOiAxLjAKQ29udGVudC1UeXBlOiB0ZXh0L3BsYWluOyBjaGFyc2V0PVVURi04
CkNvbnRlbnQtVHJhbnNmZXItRW5jb2Rpbmc6IDhiaXQKClRoZSBlcG9sbCBpbXBsZW1lbnRhdGlv
biBrZWVwcyBwb2ludGVycyB0byBzdHJ1Y3QgZmlsZXMgYW5kCmV2ZW50dWFsbHkgY2FsbHMgdmZz
X3BvbGwoKSBvbiB0aGVtIHdpdGhvdXQgaG9sZGluZyBhIHJlZmVyZW5jZS4KClRoaXMgY2FuIHJl
c3VsdCBpbiB2YXJpb3VzIHVzZSBhZnRlciBmcmVlIGlzc3VlcyB3aGVuIHRoZSBmaWxlCmRlc2Ny
aXB0b3Igd2hpY2ggaXMgYWRkZWQgdG8gYW4gZXBvbGxfZmQgaXMgY2xvc2VkIHdpdGhvdXQKcHJl
dmlvdXNseSByZW1vdmluZyBpdCBmcm9tIHRoZSBlcG9sbF9mZC4KClRyeSB0byBmaXggdGhpcyBi
eSBnZXR0aW5nIGFuZCBkcm9wcGluZyB0aGUgcmVmZXJlbmNlIHRvIHRoZSBmaWxlCnBvaW50ZXIg
YXMgbmVjZXNzYXJ5LgoKU2lnbmVkLW9mZi1ieTogQ2hyaXN0aWFuIEvDtm5pZyA8Y2hyaXN0aWFu
LmtvZW5pZ0BhbWQuY29tPgotLS0KIGZzL2V2ZW50cG9sbC5jIHwgMTIgKysrKysrKysrKystCiAx
IGZpbGUgY2hhbmdlZCwgMTEgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQoKZGlmZiAtLWdp
dCBhL2ZzL2V2ZW50cG9sbC5jIGIvZnMvZXZlbnRwb2xsLmMKaW5kZXggODgyYjg5ZWRjNTJhLi5m
MzU4NGY2ZmJhZWQgMTAwNjQ0Ci0tLSBhL2ZzL2V2ZW50cG9sbC5jCisrKyBiL2ZzL2V2ZW50cG9s
bC5jCkBAIC0zNDksMTAgKzM0OSwxNyBAQCBzdGF0aWMgaW5saW5lIGludCBpc19maWxlX2Vwb2xs
KHN0cnVjdCBmaWxlICpmKQogc3RhdGljIGlubGluZSB2b2lkIGVwX3NldF9mZmQoc3RydWN0IGVw
b2xsX2ZpbGVmZCAqZmZkLAogCQkJICAgICAgc3RydWN0IGZpbGUgKmZpbGUsIGludCBmZCkKIHsK
LQlmZmQtPmZpbGUgPSBmaWxlOworCWZmZC0+ZmlsZSA9IGdldF9maWxlKGZpbGUpOwogCWZmZC0+
ZmQgPSBmZDsKIH0KIAorLyogQ2xlYW51cCB0aGUgc3RydWN0dXJlIHVzZWQgYXMga2V5IGZvciB0
aGUgUkIgdHJlZSAqLworc3RhdGljIGlubGluZSB2b2lkIGVwX2NsZWFyX2ZmZChzdHJ1Y3QgZXBv
bGxfZmlsZWZkICpmZmQpCit7CisJZnB1dChmZmQtPmZpbGUpOworCWZmZC0+ZmlsZSA9IE5VTEw7
Cit9CisKIC8qIENvbXBhcmUgUkIgdHJlZSBrZXlzICovCiBzdGF0aWMgaW5saW5lIGludCBlcF9j
bXBfZmZkKHN0cnVjdCBlcG9sbF9maWxlZmQgKnAxLAogCQkJICAgICBzdHJ1Y3QgZXBvbGxfZmls
ZWZkICpwMikKQEAgLTg0Myw2ICs4NTAsOCBAQCBzdGF0aWMgYm9vbCBfX2VwX3JlbW92ZShzdHJ1
Y3QgZXZlbnRwb2xsICplcCwgc3RydWN0IGVwaXRlbSAqZXBpLCBib29sIGZvcmNlKQogCXdyaXRl
X3VubG9ja19pcnEoJmVwLT5sb2NrKTsKIAogCXdha2V1cF9zb3VyY2VfdW5yZWdpc3RlcihlcF93
YWtldXBfc291cmNlKGVwaSkpOworCWVwX2NsZWFyX2ZmZCgmZXBpLT5mZmQpOworCiAJLyoKIAkg
KiBBdCB0aGlzIHBvaW50IGl0IGlzIHNhZmUgdG8gZnJlZSB0aGUgZXZlbnRwb2xsIGl0ZW0uIFVz
ZSB0aGUgdW5pb24KIAkgKiBmaWVsZCBlcGktPnJjdSwgc2luY2Ugd2UgYXJlIHRyeWluZyB0byBt
aW5pbWl6ZSB0aGUgc2l6ZSBvZgpAQCAtMTEyNiw2ICsxMTM1LDcgQEAgc3RhdGljIHN0cnVjdCBl
cGl0ZW0gKmVwX2ZpbmQoc3RydWN0IGV2ZW50cG9sbCAqZXAsIHN0cnVjdCBmaWxlICpmaWxlLCBp
bnQgZmQpCiAJCQlicmVhazsKIAkJfQogCX0KKwllcF9jbGVhcl9mZmQoJmZmZCk7CiAKIAlyZXR1
cm4gZXBpcjsKIH0KLS0gCjIuMzQuMQoK

--------------N8iAFb3zsMHHLBMpyFe3ApK2--


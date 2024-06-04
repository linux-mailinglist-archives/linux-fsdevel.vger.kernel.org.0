Return-Path: <linux-fsdevel+bounces-20926-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AE498FAE58
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Jun 2024 11:09:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3DACB1C22230
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Jun 2024 09:09:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AF0414375B;
	Tue,  4 Jun 2024 09:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="F1rFbACh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2047.outbound.protection.outlook.com [40.107.237.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D83C8143725
	for <linux-fsdevel@vger.kernel.org>; Tue,  4 Jun 2024 09:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717492133; cv=fail; b=Ho4YzOE/PLR5yfNcEgLYkQmCXI5ssr+ZFkZc9g6aZycVkDkYN9HEFcSQYSiZRFf3+H52JoUjxXLIVBsJjKzkIcLFBkun93QwQsr9xfGMCL/ixu4flLHJ/dvAiYMk5/SLZP652ZTwFGQhs8RD3drDkb/ZXV9Ot8Hgh6B8/04CrQg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717492133; c=relaxed/simple;
	bh=WPrmbJJ2TxtgsBsB80cQFwrT+OLLvT8q8TLgVSyym0A=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=TgjB11/FutwK/4OHVzLmQqgGKRm+Qc9iMbho5KgWho1Lf9R5lxHxR/KURL4kud1R1GFfUlFqnW+Sfhaqgp8qVGwWBor/uzF51iTUKPjTwrF718zCbUcrARCfUnTHZG2YzWKwBRdKfo6cGzqsGN8tyyuSvdlhnMS19uL7GgW/FPQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=F1rFbACh; arc=fail smtp.client-ip=40.107.237.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RAZb4y4dSKUUZnVhrcc4zlCrnmiLA5frJydnNSBJBAz/b+Wg/gNsmkcZJIUHdznMFDG1BCf9fYtqR9OCiY8YR/IpwUsjf3po0ioGMWcVDqQ1Hyxv6Ovcg/9pwiXvTKBw3ovXcnJMoHg66UtWevmraLPj1tO3SSWtjaTyrYvDtoJw6BeyY3TZE8wGIEqh/AkSlzHOXWNGqSq0nwyVGm29hcd9ey26gCX/CnsTntjL1dXHOjs0Gnh1JYgSWDVt9xNObU6jBwVgHwrRtgq8oGv6aGzkwLULvOJSPXJUX8dW8Xe72cws5jD8hFPPbg44dgFCvQBg/FFCtYXodDNlF0kEUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WPrmbJJ2TxtgsBsB80cQFwrT+OLLvT8q8TLgVSyym0A=;
 b=Tl2wrMQqbwX2SUuxe50GeOBG0OW3WYUFhZeU/5f7kz/UrHIVsltBD8KAu9Kce8nAMAoZRWUZsW0qDqbVLwVsJBbVDOop12SrlckXkCj+PeJkuaXSp9lvcXCSkk7b7aWPZJP/B9CVzLn9d/R/k8uMGV8IUvYoJT/N4U9yyw/PJYRPinzzkm8FfRSyrwnmZT0YdawerTlp3JFr4s7aITow2CDy9429lVHpsKsndXhdW1rO7axl7lq/O+4LbkNsshPlu9Ms0EpEbxG6rkeDNYMQqeoGpMxOTzYxrSeZ84oFf315JjR0Z4jBfWQVSvn5MLepmq2/ycc24HfDui8DEVuz2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WPrmbJJ2TxtgsBsB80cQFwrT+OLLvT8q8TLgVSyym0A=;
 b=F1rFbAChjYw9WBJxm4lc5q62s4ztAPp8/LPBaYKSPojw6XxqlEhozjKUW7MupHJPr2P/lXZcUIXxBICJ0+4CuwM4cZ8PbFF7ZvBx/peY2OGdIVbWB1I0hZxvRX5dZOjpOjgg/rfAHdpaQd4zy6s63gSFuorUiuGYg34AZ3cawONlZOgAPxVRQFIO6RRM6QUlgePtbS+32Keuj3OchG7U9Jibx0IqxL574Jq4NOeT77dtUcBGoRMEOwgO/zAwkjdiIWKOGEagJy0PIKo6eZ9d9ZNqwpn/3Kf7K38YwUY8W6V8XYutgex9pSqG4EoGvHwtzh+RSGLj+bp4EHC+RfTxhw==
Received: from SN7PR12MB7833.namprd12.prod.outlook.com (2603:10b6:806:344::15)
 by SN7PR12MB6864.namprd12.prod.outlook.com (2603:10b6:806:263::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.21; Tue, 4 Jun
 2024 09:08:48 +0000
Received: from SN7PR12MB7833.namprd12.prod.outlook.com
 ([fe80::6f09:43ac:d28:b19]) by SN7PR12MB7833.namprd12.prod.outlook.com
 ([fe80::6f09:43ac:d28:b19%4]) with mapi id 15.20.7633.021; Tue, 4 Jun 2024
 09:08:48 +0000
From: Peter-Jan Gootzen <pgootzen@nvidia.com>
To: "miklos@szeredi.hu" <miklos@szeredi.hu>
CC: Idan Zach <izach@nvidia.com>, Parav Pandit <parav@nvidia.com>,
	"virtualization@lists.linux.dev" <virtualization@lists.linux.dev>,
	"stefanha@redhat.com" <stefanha@redhat.com>, Max Gurtovoy
	<mgurtovoy@nvidia.com>, "angus.chen@jaguarmicro.com"
	<angus.chen@jaguarmicro.com>, Oren Duer <oren@nvidia.com>, Yoray Zack
	<yorayz@nvidia.com>, "mszeredi@redhat.com" <mszeredi@redhat.com>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"bin.yang@jaguarmicro.com" <bin.yang@jaguarmicro.com>, Eliav Bar-Ilan
	<eliavb@nvidia.com>, "mst@redhat.com" <mst@redhat.com>,
	"lege.wang@jaguarmicro.com" <lege.wang@jaguarmicro.com>
Subject: Re: Addressing architectural differences between FUSE driver and fs -
 Re: virtio-fs tests between host(x86) and dpu(arm64)
Thread-Topic: Addressing architectural differences between FUSE driver and fs
 - Re: virtio-fs tests between host(x86) and dpu(arm64)
Thread-Index:
 AdqybnzAiozTvtlkQFaloMBVG2WGpwDHcmEAAADKEAAAAQAmgAAAdzaAAAm2tYAAAoHLAAABHCqAACK6xwAAAOV6AAAAntkAAADMmIA=
Date: Tue, 4 Jun 2024 09:08:48 +0000
Message-ID: <464c42bc3711332c5f50a562d99eb8353ef24acb.camel@nvidia.com>
References:
 <SI2PR06MB53852C83901A0DDE55624063FFF32@SI2PR06MB5385.apcprd06.prod.outlook.com>
	 <b55cb50b3ecf8d6132f8633ce346b6adc159b38c.camel@nvidia.com>
	 <CAJfpegsppbYbbLaECO+K2xpg8v0XZaQKFRZRTj=gJc9p7swdvQ@mail.gmail.com>
	 <bbf427150d16122da9dd2a8ebec0ab1c9a758b56.camel@nvidia.com>
	 <CAJfpegshNFmJ-LVfRQW0YxNyWGyMMOmzLAoH65DLg4JxwBYyAA@mail.gmail.com>
	 <20240603134427.GA1680150@fedora.redhat.com>
	 <CAOssrKfw4MKbGu=dXAdT=R3_2RX6uGUUVS+NEZp0fcfiNwyDWw@mail.gmail.com>
	 <20240603152801.GA1688749@fedora.redhat.com>
	 <CAJfpegsr7hW1ryaZXFbA+njQQyoXgQ_H-wX-13n=YF86Bs7LxA@mail.gmail.com>
	 <bc4bb938b875ef8931d42030ae85220c9763154f.camel@nvidia.com>
	 <CAJfpegshpJ3=hXuxpeq79MuBv_E-MPpPb3GVg3oEP3p5t=VAZQ@mail.gmail.com>
In-Reply-To:
 <CAJfpegshpJ3=hXuxpeq79MuBv_E-MPpPb3GVg3oEP3p5t=VAZQ@mail.gmail.com>
Reply-To: Peter-Jan Gootzen <pgootzen@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR12MB7833:EE_|SN7PR12MB6864:EE_
x-ms-office365-filtering-correlation-id: da235a4e-873c-424b-be09-08dc8475f1b4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|1800799015|376005|366007|38070700009;
x-microsoft-antispam-message-info:
 =?utf-8?B?WDdIMWtKUDlWbEloOHd4MXppdm1nODhNQllvSzM4NzRlWm1ibXdvSklsMkV5?=
 =?utf-8?B?RTFONG00VzdpUHBqWTNXSFhDRWlBYS83cWpBVkRTREhMUjE0R3B4Y093SVQ5?=
 =?utf-8?B?ZjVwS0ZHYXV4bEdZY2FpanZjT2gzSmFpdm1WbCtET0pCcUlBdFllZ25aOXov?=
 =?utf-8?B?T3cxbHJGa3ROQlIxUkpVait4QjBFYko1N2laV0ZUcnF4U1ArV2J5R2RCTG1i?=
 =?utf-8?B?eFBuNWxqN3Q3M1NMZXdJUlpKOGhsdXF2Rmd4KzZ0emZRaFNkZG1DVG5YY3pN?=
 =?utf-8?B?aWt5aXp4RmEzZ1hrdVBrZUs0NDE3eXowN0RCTGRqREJjUEVFSkl5ajM3ZFBy?=
 =?utf-8?B?TXJWeFFyOWVkUWhkTnVFT1FvcGNSNDluVnFBWVRxQjdCNjRQQURHY3loV1FU?=
 =?utf-8?B?WmVFU2w4a1BZbC9DYmxaMUI5eURXcktVMzNUdUY5bjR4b1B0blNveE90blNV?=
 =?utf-8?B?ZUQ3YkxSR1lIM1JIR1ZHcTlERndBczJ1dkpkUk82MjRHNmVTajZ1azdUb2Vk?=
 =?utf-8?B?N256S1NMYnlyUkMzdEl1d2xWemNtNVV1U1hueE4zdGc0ZnRzejNjRVZYZGJ2?=
 =?utf-8?B?LzRoMnNlQzR2MDV5V0VmRHJkcldDSDI5MklBY0p0cVh1S212enFKYUxQUFQ5?=
 =?utf-8?B?M0tMaUwvaFM2ZUpMTWxkS0NlbkdGL20rbWZ0V291R0llSzVmem9NV2tzdDF6?=
 =?utf-8?B?WTNHbDVrZUtiRk5IR0lkYW8yUExvb1ljdU9IcVVEUkVwdUVWeG40dllFbHhn?=
 =?utf-8?B?V3lhcGM1V0lSV0UxTVZ1cnpWNk5rNEJnU3V1QU5uYWNSaVUzbEJ4ZzI1b3dj?=
 =?utf-8?B?d2xwTzh6VFJCUjY5VFBhRGFrUS80STF2dVlJZHlnRFFwVzUycW1hbGtoanR0?=
 =?utf-8?B?U2oweWRycUk4a3Y3c2Y4RC90UGw5NHlSNFgvMDJxdUJOTkdmbXJDcGdaVGtr?=
 =?utf-8?B?U1dXYjNHZ1d2V0ZwQjN4YlQ4OEFSSGZhTEZYQnMwOU85UXJwVTR0K1Bsa2lu?=
 =?utf-8?B?bFNRZ1BsanNPeHI4eUw4cTU4eWRsSkF6Y0xUcWRzeXJXdjVneVM3NzR6SXVX?=
 =?utf-8?B?SHZtZ2U2aUtvUHFWcEVsUmJEc3BLbmF5QnZZbE1tQWpsZmZhRHVLK2k3ZWoz?=
 =?utf-8?B?ekk1T0lYQ0Q1d1ZxTjhTOGxnRjU2MkFaTjVXdU5va3haQ2Jsc0hsdzY4TWNU?=
 =?utf-8?B?WWJwOXY1VlJPTE9zVnl4Nm5IdXFmcDlyZ3ZpbXlRbGhzaUJWTWNiTlIzWTcr?=
 =?utf-8?B?bitDb3pGMytuTGo1S1ZTaHVoZVdXQUptMDFWYWt6LzBOdHJXN2ZwcUVZbys5?=
 =?utf-8?B?Q1JOcWdkMWZvL2ptU05CdGNiaFVFd044UXdkcWt4aGpBeDlVV2Z5Nm5GMThK?=
 =?utf-8?B?b3gzKzQ3d3hRd25XK090dlRyRU9VcjUrUWlKVmV5MVYxUEFpQ0l5ajMxbDZN?=
 =?utf-8?B?eGcvci8vY1k4K3oxYVFQVVFOdk9KL3hqUnUvUHBuckt3bWRKaG5jcU1jc1VG?=
 =?utf-8?B?NnRRd3VwYzdjQjJVRHVPZi96YlRTTU44aTJUc1JmNDR0aWJZNWVvajR3dm9x?=
 =?utf-8?B?N2hYdWdETDFUTmZlQ04vUWhxWWpVYlk0d0FnVjN4MmNxaW9oSkhtVDZHV0o2?=
 =?utf-8?B?dGFEbUhpaUxlOGxUaHV0Q1R0aDBtSE9tK08zNVFNMVFacWRvbDB6QzNUSFl4?=
 =?utf-8?B?VWxkWE9jaC9JeE1aZTFoYThiRC9tSzhyN2F1R2c2ZmhRdHAxMWVxWUxpOWN5?=
 =?utf-8?B?ZGt2M0I5d1Q2YUFsQm1VUXROWFgrTURyUUtLWCtseVIxUC82QUZ4QWlpMHpS?=
 =?utf-8?B?OHFPZW9PMFNmS0ZLbkphdz09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB7833.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?d0FORDhudjhFa0NyTjNoSjh0MEJPYVpDalVISTBodzV2Q2RJWHNSanlKQllx?=
 =?utf-8?B?S21zaFI1RVhVcnV4LytzT3ZjSDhqUlc0TFo0UXdPQXdGdVcwNEYrUEcvaGtU?=
 =?utf-8?B?b3h2UlhhT3J4ekpRcktuNk5KN0FLM1gySU1sdy9XcldVK0UxOXJ4V202eGNW?=
 =?utf-8?B?OU5nejVrU2RhS3JiRWFpd25CRDk3WVBmOFA2YXc2a3VyYVM4NW9hLzdyQTkv?=
 =?utf-8?B?UE1LWi9hNWVEdWJBZU1SbXh4c1ZJMldDVitWeUk3NmRYTURFbVBIc0FKbGJC?=
 =?utf-8?B?MmVFUnphdUlGNWR0RGFWNFRuTVZBdW9yZlNSeDlDTG1ZQ1BJc1NMNXdFc3JE?=
 =?utf-8?B?Yndad1M2dFNrMXVibmVGem5QcTkvckJSYU04dU9RVENTcEZYVGh6dWF3WTU3?=
 =?utf-8?B?ckdzK0dTM1NnMDFrRnM3WDRrNjhydFNBTFVYaHFyc28xZ1ExVHgvbEU0VEl0?=
 =?utf-8?B?bXBOYytZMnl6K0NKOXEvTmRMQXZZVUFMT0FieUkyb1VLV00wUGJxNEpabjRI?=
 =?utf-8?B?N1RVTGdhU2RmS3pla09VSWV6Qi9sNm5ubUV2M0R0U08wdUhTRnBHVFlLSTB6?=
 =?utf-8?B?VTFPc3pqYjVMU2JldG12QTdFeHdCYmFKTmdmdTVkaWxGN3JBVktQLzNob21E?=
 =?utf-8?B?OVl6aWdrNGdMcDBuVUpBV3A0N0taTGRTUk9zZnFqbUlNREJhYU4vbVBBdzdB?=
 =?utf-8?B?QVFMQ0F6VTlFYURNMndPeWdhc2dSRDFtVVNLcHFSb21oUTFTMVRUUGJBV2d5?=
 =?utf-8?B?dm9jRDdkbTZzek00MzRSWUhIaThwOHBLMk1oNi8vUnJ4MXdOZjgrSkphSTlO?=
 =?utf-8?B?d2RDNzFlUGliUGhaUDF6N3Bkc1JxNitpbnNYVEdZMWppWjZpcDZjYnl4SmdT?=
 =?utf-8?B?MkpJS0plc0tYaGRoUHRIRitCSzFpcjFjYWE1Qjg0VXZQZmxrc1dYK3RUSWV0?=
 =?utf-8?B?NFJOWVZUd0ZkWHVtdVEzQ3hYbmpqMEdISnlLUmdPRkg0c1JPREEyOURDcmlF?=
 =?utf-8?B?V2tCUVQwZUxtVlJ2ZlIweklXU3hYM2p5WFZwb0hXUERRaWs4N3NmdWdPWUp0?=
 =?utf-8?B?UzVLVWhTUUZRcjJlME1uaVp5aXRVaUcxSElaekhieVdZWHlQNnVud1BSQ0Qz?=
 =?utf-8?B?ckFGQmQyT1VnREdXbkNoblplNVZBdklPMDNZNmJWRzlqaFU0SWNCM3lMNFdM?=
 =?utf-8?B?OFc4eVRuU29sUy9nbHlqZEM2Q2xxdGV0Q2w1WmY5UGhoanZzVjhLenRDNHhS?=
 =?utf-8?B?cmJQUUp1YTM0Q1hGNjNZVkFkOWUyUWpJZWx5SlM0WDVSc3RjMzd2am9MalhO?=
 =?utf-8?B?UU5MRWdtTmtuQjBhK3IyQk02aHZzUEhINWtDYSt0aHNMSXdkYVpBN3Jtcko1?=
 =?utf-8?B?aGV5QWt4T2VhaGFDL1NWWFhudEZLeWhwS1pRRVN6Tm5ucTcxOXMvUXBaRExK?=
 =?utf-8?B?Q2hUcU1RVVYrTy8zbVdiMk0vaXVwK2gxOVVuUTN2N2FoZmUvVWc3QTVoUndi?=
 =?utf-8?B?V2ZRMmdzVFBNbE5qanh0TFg0dGNFUVd5VSs1bEJZVk9ETllwdi9zRDFISVAr?=
 =?utf-8?B?b0JxR1o4UENpOFZ3YTZyUjNDdkxTZnNkNWdJaVQyYW4ybHVYdE9sNjlLYTUv?=
 =?utf-8?B?WDV2VTRzYW9sd1czR1VuaE4wcENaSUNVdDNIS2JPbGhrT1J2aGF2K09ZeTkr?=
 =?utf-8?B?dEM0OHV6NGlrcWNjUTN1SEVVRUl4Z0YxbzZrNzRkVnpYYWZnemJJaTRaRDdK?=
 =?utf-8?B?UVVrRUNGVHdlVldmbk52UnNKdkt3UXoxUmtOZTIwWkNBSWJUYWJ6cHJiZG14?=
 =?utf-8?B?cFpFbE1BZ2hzRWhmTk1oNDY2YkptTEdKOG1OTk10M2s2eGF2aHc5dmhDUUdG?=
 =?utf-8?B?aitSUlFzWDJFSWdyb0FkaUNiR3RyRXlEcFpPVlR6NWY3SzNxcFFsa28yNXZ2?=
 =?utf-8?B?UFk3cVlkYjlaWGkvdFdvL0ZWb1hwV1FsTjdVOU9QL1NWWHAvNU5KeWl5Qng2?=
 =?utf-8?B?MStPUksyd1JhSjk4TUhoZ1g4VkhQRnhQLzRIc2lNMUxLdE43YWI4NUdlSlU1?=
 =?utf-8?B?eDV1Mm14OEpHbWlxK1NwdEtXc2ViejBvakorb3Y5MDFINmdIc0tJR1duZitI?=
 =?utf-8?B?SXJTTW5rb2VJOE9sRkt0ZWhvNlc1b0ZmYUFaMmQ0NHRBR2JaM2RNSjg3eXB4?=
 =?utf-8?B?UlE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B5B616AF866CDC4A8F7CB746A5F348AA@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB7833.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da235a4e-873c-424b-be09-08dc8475f1b4
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jun 2024 09:08:48.0449
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fnjn5+OrdrU6siK2YvsD/H6XBu0w1nL7/+TkUXPW0h1Vg0bBN8CaTi8LXGGGPUFom49G4/veIp125E9mEvQctA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6864

T24gVHVlLCAyMDI0LTA2LTA0IGF0IDEwOjQ1ICswMjAwLCBNaWtsb3MgU3plcmVkaSB3cm90ZToN
Cj4gRXh0ZXJuYWwgZW1haWw6IFVzZSBjYXV0aW9uIG9wZW5pbmcgbGlua3Mgb3IgYXR0YWNobWVu
dHMNCj4gDQo+IA0KPiBPbiBUdWUsIDQgSnVuIDIwMjQgYXQgMTA6MjgsIFBldGVyLUphbiBHb290
emVuIDxwZ29vdHplbkBudmlkaWEuY29tPg0KPiB3cm90ZToNCj4gDQo+ID4gV2lsbCB0aGUgRlVT
RV9DQU5PTl9BUkNIIHRoZW4gYmUgZGVmYXVsdC9yZXF1aXJlZCBpbiBpbml0X2luIGZyb20NCj4g
PiB0aGUNCj4gPiBuZXcgbWlub3Igb253YXJkcz8NCj4gDQo+IE5vLsKgIEl0IGp1c3QgaW5kaWNh
dGVzIHRoYXQgZnVzZSBjYW4gdHJhbnNsYXRlIGNvbnN0YW50cyBmb3IgdGhpcw0KPiBwYXJ0aWN1
bGFyIGFyY2guwqAgQWxzbyBJJ20gbm90IHN1cmUgbm9uLXZpcnRpb2ZzIHNob3VsZCBhZHZlcnRp
c2UgdGhpcw0KPiAodGhvdWdoIGl0IHNob3VsZG4ndCBodXJ0KS4NCj4gDQo+ID4gSWYgc28sIGEg
c2VydmVyL2RldmljZSB0aGF0IHN1cHBvcnRzIHRoZSBuZXcgbWlub3IsIHdvdWxkIG9ubHkgbmVl
ZA0KPiA+IHRvDQo+ID4gc3VwcG9ydCB0aGUgY2Fub25pY2FsIGZvcm1hdC4NCj4gPiBUaGUgZnVz
ZV9pbml0X2luLmFyY2hfaWQgaXMgdGhlbiBvbmx5IHJlYWxseSB1c2VkIGZvciB0aGUNCj4gPiBz
ZXJ2ZXIvZGV2aWNlDQo+ID4gdG8ga25vdyB0aGUgZm9ybWF0IG9mIElPQ1RMIChsaWtlIElkYW4g
YnJvdWdodCB1cCkuDQo+IA0KPiBZZXMsIGZvciBpb2N0bCBhbmQgYWxzbyB0byByZXNldCB0aGUg
RlVTRV9DQU5PTl9BUkNIIGluIGZ1c2VfaW5pdF9vdXQNCj4gaWYgdGhlIGFyY2hlcyBtYXRjaC4N
CkdyZWF0LCBzbyBmcm9tIHRoZSBwZXJzcGVjdGl2ZSBvZiB0aGUgY2xpZW50LiBJZiB0aGUgc2Vy
dmVyIGRvZXNuJ3Qgc2V0DQp0aGUgRlVTRV9DQU5PTl9BUkNIIGZsYWcsIGl0IGNhbiBiZSBlaXRo
ZXI6DQoxLiBUaGUgc2VydmVyIGlzIHRoZSBzYW1lIGFyY2ggYXMgdGhlIGNsaWVudC4gQWxsIHdp
bGwgZ28gd2VsbC4NCjIuIFRoZSBzZXJ2ZXIgZG9lc24ndCBzdXBwb3J0IHRoZSBjYW5vbmljYWwg
Zm9ybWF0IGFuZCBpdCBtaWdodCBiZSBhDQpkaWZmZXJlbnQgYXJjaGl0ZWN0dXJlLCBhbmQgdGhl
IHRyb3VibGVzIHRoYXQgd2UgYXJlIGN1cnJlbnRseSBkZWFsaW5nDQp3aXRoIG1pZ2h0IG9jY3Vy
Lg0KDQpPcHRpb24gMcKgaXMgZGV0ZWN0YWJsZSBpZiBmdXNlX2luaXRfb3V0Lm1pbm9yID49IENB
Tk9OX0FSQ0hfTUlOT1IuDQpPcHRpb24gMiBpcyBkZXRlY3RhYmxlIGlmIGZ1c2VfaW5pdF9vdXQu
bWlub3IgPCBDQU5PTl9BUkNIX01JTk9SLCBub3QNCnN1cmUgeWV0IHdoYXQgd2UgY291bGQgZG8g
d2l0aCB0aGF0IGtub3dsZWRnZSAobWF5YmUgdXNlZnVsIGluIGVycm9yDQpsb2dnaW5nPykuDQoN
Cj4gDQo+ID4gV2hvIGRlZmluZXMgd2hhdCB0aGUgYXJjaCBuYW1lcyBhcmU/DQo+IA0KPiB1bmFt
ZSAtbQ0KPiANCj4gSXQncyBhbHJlYWR5IGRlZmluZWQgYnkgdGhlIGtlcm5lbC4NCj4gDQo+ID4g
VGhlIGxhc3QgdGltZSBhbiBhcmNoIHdpdGggaXRzIG93biBjb25zdGFudHMgd2FzIGFkZGVkIHdh
cyAxMiB5ZWFycw0KPiA+IGFnbw0KPiA+IHdpdGggQVJNNjQuIFNvIHRoZSBoZWFkZXIgd291bGRu
J3QgY2hhbmdlIG9mdGVuLiBPciBpcyB0aGlzDQo+ID4gc29tZXRoaW5nDQo+ID4gdGhhdCB0aGUg
a2VybmVsIGF2b2lkcyBpbiBnZW5lcmFsPw0KPiANCj4gSSBkb24ndCBjYXJlIG11Y2gsIGl0J3Mg
anVzdCB0aGF0IEkgZG9uJ3QgdGhpbmsgZGVmaW5pbmcgY29uc3RhbnRzIGZvcg0KPiBhcmNoaXRl
Y3R1cmVzIHJlYWxseSBiZWxvbmdzIGluIHRoZSBmdXNlIGhlYWRlci4NCj4gDQo+ID4gSWYgYXJj
aF9pZCBpcyBvbmx5IHVzZWQgZm9yIElPQ1RMIGFuZCB0aGUgcmVzdCBvZiB0aGUgdHJhbnNsYXRp
b24gaXMNCj4gPiB0aHJvdWdoIHRoZSBjYW5vbmljYWwgZm9ybWF0IHdpdGggRlVTRV9DQU5PTl9B
UkNILCB0aGVuIEkgbGlrZSB0aGlzDQo+ID4gYXBwcm9hY2guDQo+IA0KPiBZZXMuDQo+IA0KPiA+
IEkgdGhpbmsgdGhhdCBpZiB3ZSBpbnRyb2R1Y2UgdGhlIGNhbm9uaWNhbCBmb3JtYXQsIGFuZCBh
bHNvIHJlcXVpcmUNCj4gPiB0aGUNCj4gPiBzZXJ2ZXIgb3IgY2xpZW50IHRvIGJlIHJlYWR5IHRv
IGRvIHRyYW5zbGF0aW9uIGZyb20gYW5kIHRvd2FyZHMgdGhlDQo+ID4gaGFuZHNoYWtlZCBmb3Jt
YXQgc3BlY2lmaWVkIGluIGFyY2hfaWQuIFRoZW4gaXQgd2lsbCBiZSBvdmVybHkNCj4gPiBjb21w
bGljYXRlZCBvbiBib3RoIHNpZGVzIHdpdGhvdXQgYWRkaW5nIGFueSB2YWx1ZS4NCj4gDQo+IFRo
ZSBwb2ludCBpcyB0byBvbmx5IHRyYW5zbGF0ZSB0byBhbmQgZnJvbSB0aGUgY2Fub25pY2FsIGFy
Y2guDQo+IA0KPiBUaGF0IGRvZXNuJ3QgbWVhbiB0aGF0IHRoZSBrZXJuZWwgKmhhcyogdG8gdHJh
bnNsYXRlIHNvbWUgb2Jzb2xldGUNCj4gYXJjaCwgYmVjYXVzZSBpdCdzIHVzZWxlc3MuwqAgT25s
eSBhZGQgY29tcGxleGl0eSBmb3IgdGhpbmdzIHRoYXQgYXJlDQo+IGFjdHVhbGx5IHVzZWZ1bC7C
oCBBbmQgdGhlIHByb3Bvc2VkIHByb3RvY29sIHN1cHBvcnRzIHRoYXQuDQoNCkdyZWF0LCBJIGp1
c3Qgd2FudGVkIHRvIHByZXZlbnQgdGhhdCB3ZSB3b3VsZCBuZWVkIGEgbW9uc3RlciBhbnktdG8t
YW55DQphcmNoIHRyYW5zbGF0b3IsIHBvc3NpYmx5IG9uIGJvdGggc2lkZXMuDQoNCj4gDQo+IFRo
YW5rcy4NCj4gTWlrbG9zDQoNCg==


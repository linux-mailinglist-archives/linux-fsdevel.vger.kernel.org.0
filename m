Return-Path: <linux-fsdevel+bounces-20916-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C3CE8FABA1
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Jun 2024 09:13:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F71D1C2159E
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Jun 2024 07:13:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3FBB140367;
	Tue,  4 Jun 2024 07:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="c9LvH07a"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2073.outbound.protection.outlook.com [40.107.244.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 742B113790F
	for <linux-fsdevel@vger.kernel.org>; Tue,  4 Jun 2024 07:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717485207; cv=fail; b=MZBYHwF4V7bsAB1DXvHaSGJajn1UoReAWHUXxqgKVTtEoQWtG/JxAGwAlLRvP1QBAiy/LoqZPxnOhfoaNPjIOFfYovFW0hjqqV7YS0v2fKZzuHWPW1EYQkXGDS2hJHm9Scmc4d+UtegM0yiVWf16q4fQ4dTbfj86Py+pdU76cZ4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717485207; c=relaxed/simple;
	bh=8l12TBamRZSodKinZ/ZAnQ25pJomDgm5/NaGeHY8wNc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=fEU0WzXEufu8dWXxgvS41L6E+UxYs5suzGDq0iy2TQYzZ2BOahOdzKD+lcE32ElW05f6LUoVAppMEY58TpTG9uFakEDrNR/n5/mrA5Mo8WMlRGmg7Rd8Rog5p5WBGsk0CzBcgH9CXrbij6ewNaOWCs9ZoI0hw42BBw+UqyWcdRU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=c9LvH07a; arc=fail smtp.client-ip=40.107.244.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FfsT6kUp5mj4dPSCggAOTRAhvdZR5AoHHI6uCEVa8sGS1GQx4S9yYqN1qvCs3UXByBkP5+4Z13WOpPeGtQ22+eYCeabD9/O1jUuq2y0sAqwhA9/rGyMKkGSfd8Z7Huaqp7xxJf8IFrs2tT058kCTAs63yI3Ac4KZg6DZ3RHI9kYHPcaoDNo7AVepAPlQcERiA9FdWWmyvryRR4UGm0IaMJ4mZsM3dL3qOiTYjbbW23c9lYk9ujFmC6/53+Tl4+fqLF/VBt6n9MEub/rqjHYVcJ+sImWGDhJoJGAQKAZgyprmWunxKFj339x3uORpwpAYrNxpKNjrV9osPAS8ZpRi2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8l12TBamRZSodKinZ/ZAnQ25pJomDgm5/NaGeHY8wNc=;
 b=VUir56oKFWw0T62R+jDU5n643uStmZiR9AZhVFgJ6CufJNbKSDqmmZI82c8/JJ6avU4dEFeGFLRiZhferhPNB24D47unnCmUiu6T5BP4vrHPCxiu4dLBWLJAV+gPT2DpJMQ9eKguim6C+j37x5lKx7uUVDqdtZDjqct77jJ1wexRETvSkZ/yK9ie+zB0wv82765ocidAvEiAYAGqqWAi825sX9PjVkyRERAL8RUdIQ5MRtvqaeUM+PmkDNiOwZ2CJ5X90Ak8GQMW/bZsDHgIpFmXh65bmZuYYs8D3f/fSyaVL6DhgXacCCGPsbxgpEb0dS9MGQSpDfGSTAw5k8viOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8l12TBamRZSodKinZ/ZAnQ25pJomDgm5/NaGeHY8wNc=;
 b=c9LvH07a3VZVgatjeve+0mR+MSkkqXFIkg2Sy67xPRscCO6Mj7OS2G6dH61nWC54zlrf/siLcDqTst3UTJ2MoxS3giLEu83wUbOfHaLFzLTSlkd4F6Sby9LXADP63GBCNghaxgh2bfm9A9JvinnRyHrJS8xhpQYmBzGFlCJaXQBZrHWymk/8HGQqtLZv+r6ouITCoxZV8Fb/diLrE921wE7uftSNxXkSdu2k3zJt3mL3+YgLkZJDjil4ua0YwmgNRSb6vl5kel5lpiMQVxsn9OnNxzNp57p/aegNv0PMrG1DLgFyCLf+0Q//xLd/DIXo1pdLYpCw+C9fSyYNU+6KIQ==
Received: from SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7)
 by LV2PR12MB5751.namprd12.prod.outlook.com (2603:10b6:408:17d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.25; Tue, 4 Jun
 2024 07:13:18 +0000
Received: from SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91]) by SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91%4]) with mapi id 15.20.7633.018; Tue, 4 Jun 2024
 07:13:18 +0000
From: Idan Zach <izach@nvidia.com>
To: Lege Wang <lege.wang@jaguarmicro.com>, Stefan Hajnoczi
	<stefanha@redhat.com>, Miklos Szeredi <miklos@szeredi.hu>
CC: Peter-Jan Gootzen <pgootzen@nvidia.com>, Yoray Zack <yorayz@nvidia.com>,
	"virtualization@lists.linux.dev" <virtualization@lists.linux.dev>, Parav
 Pandit <parav@nvidia.com>, "linux-fsdevel@vger.kernel.org"
	<linux-fsdevel@vger.kernel.org>, Bin Yang <bin.yang@jaguarmicro.com>, Max
 Gurtovoy <mgurtovoy@nvidia.com>, "mszeredi@redhat.com" <mszeredi@redhat.com>,
	Eliav Bar-Ilan <eliavb@nvidia.com>, "mst@redhat.com" <mst@redhat.com>, Oren
 Duer <oren@nvidia.com>, Angus Chen <angus.chen@jaguarmicro.com>
Subject: RE: Addressing architectural differences between FUSE driver and fs -
 Re: virtio-fs tests between host(x86) and dpu(arm64)
Thread-Topic: Addressing architectural differences between FUSE driver and fs
 - Re: virtio-fs tests between host(x86) and dpu(arm64)
Thread-Index:
 AQHatYxHUZn7AQ9mbUGobvYpOtWKkbG1s8QAgAAIAACAAAO7gIAATbaAgADgrICAAEJhUA==
Date: Tue, 4 Jun 2024 07:13:18 +0000
Message-ID:
 <SN7PR12MB8059876E876B829C41F8B097D1F82@SN7PR12MB8059.namprd12.prod.outlook.com>
References:
 <SI2PR06MB53852C83901A0DDE55624063FFF32@SI2PR06MB5385.apcprd06.prod.outlook.com>
 <b55cb50b3ecf8d6132f8633ce346b6adc159b38c.camel@nvidia.com>
 <CAJfpegsppbYbbLaECO+K2xpg8v0XZaQKFRZRTj=gJc9p7swdvQ@mail.gmail.com>
 <bbf427150d16122da9dd2a8ebec0ab1c9a758b56.camel@nvidia.com>
 <CAJfpegshNFmJ-LVfRQW0YxNyWGyMMOmzLAoH65DLg4JxwBYyAA@mail.gmail.com>
 <20240603134427.GA1680150@fedora.redhat.com>
 <SI2PR06MB538586B4F0AEFFB20F553240FFF82@SI2PR06MB5385.apcprd06.prod.outlook.com>
In-Reply-To:
 <SI2PR06MB538586B4F0AEFFB20F553240FFF82@SI2PR06MB5385.apcprd06.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR12MB8059:EE_|LV2PR12MB5751:EE_
x-ms-office365-filtering-correlation-id: 0652d1b2-5288-4403-1e2b-08dc8465cf89
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|376005|366007|1800799015|38070700009;
x-microsoft-antispam-message-info:
 =?utf-8?B?Z3ZvMURzais3ZXdQajB1NjU1ZzFtdzc0SWVwR095Y3NxNWY5WjhuRlpGMXA2?=
 =?utf-8?B?N3FwUCtoNGIyZzRWS1Rmd1NoR0hYSmZ3alZXb3F5WXplSnhWdncxVHQyVFpi?=
 =?utf-8?B?anE1cFoyMnZDdXBYbnhDdlhuZjR6M25jZURzTXBoMmh1QWlOT0tTRGljblpK?=
 =?utf-8?B?bU9nTEI5UUtxZ2tKT0pjSEx0QTNyQ1EvcFNLUlV2UXlxMW55SjRxbXhjdXNw?=
 =?utf-8?B?dHovcFNKRVc2ZHZxUTduRitjdlNZWCtmTllWV0FuMEEzc2ZkQ2l3VmgwazZH?=
 =?utf-8?B?dGhQdTNkbmdLT1FKQUY2OEJaU1dOSnRGSlVIaUJCTWpNVHhSeVY1R0IxTG9o?=
 =?utf-8?B?MEwyaVhwVzFJWnU0NVlKRkN0eEZkaUhac0hsb0d3VlZqU0k3UkRyS3E5QW5I?=
 =?utf-8?B?c1JXZnRrNmIxbXVrejY4U0QrVlpPa1N0K2VGblF6ZHRUSXJQeGdIaHNMSWdo?=
 =?utf-8?B?SEVHSGwwNVNjTUhNODZwN1BLQzF0cEFDVXd0ZHI0MURsS2pOVnBEVktCdXdi?=
 =?utf-8?B?dzg4U1dqbEZLSlRKOEVVRmJuSUYydHA4a0M5ZXZlNm11Qm9vSkdFTFZXeEdk?=
 =?utf-8?B?N2d2U1BTb0p5c1MzVUN3STFTWkZkd0dtTEhNNTlVYzRiT2VOYlExc3F5SEtr?=
 =?utf-8?B?NzgxVlRiN09ONHBKZ290K0liaXhUYTNHSGpEaVNqMU4xVGtjK2lCeUFmT0xR?=
 =?utf-8?B?dGdsVFdJZ3d5Tmgvb3NnYXk0a1RkYnRQd3hEQkdQUjVab1psNlJDL2svVHA2?=
 =?utf-8?B?R0RGVUFNRVlOOStNUHA0TmRRY2Z3bXNudTB6QVNyUWhxbkFsVElHSFkwNDhm?=
 =?utf-8?B?R0c1dEdwMEdHcUsza09EYnFaVGU4TGNJT0FzK2lGMzZTblp4VnVMYTRyOVdS?=
 =?utf-8?B?TjBhd2NybExVNmZpOXFNY2hGV25HbnVsNnB6SFZvYWdUMUd1OHV2ZmN5Q0dy?=
 =?utf-8?B?a0t4clhUTVc4YWYwcW9XVEpjdHRGcVIvKzRiR09mY3ppUlF6Yng2N2Y4QVBj?=
 =?utf-8?B?M3Z2d2tBMVdpMHRObndnU0tCSVJ5SnhGMWJhdVBTTTRzazZaQU1JVGtLdkQz?=
 =?utf-8?B?dnR4SnRoaEY3WktpeENvVzRicVk5Q3ZlaDRySkVkNXV6MlduTnZ3N0VKMXZr?=
 =?utf-8?B?TTExSC90Qk1YQVkwNmhXOEV1NjFGc1ZPZmR0a29LVmNtM2NVTFh6b3VJUmpm?=
 =?utf-8?B?ZXdqNGwrMC8vUFpMTlhhbUJ0K0s3V2JJYzFSZ0w3S3k0cytMOFQ5OHhqamE0?=
 =?utf-8?B?U3hRZlZvYytRd25qcW1hMWVzbnJKVEVuSUpDMHNhaWxwUjNHT3hqdGIxRXZY?=
 =?utf-8?B?dVZ0M0Ezc0FacXIybEhzdkYvK3FWbG5ERnd2R0N5TERJZVhnUjNJcms5YUxM?=
 =?utf-8?B?Q3ZsUDRlbHFiNUpoMVpYTVlzWXdIWlVIMU4ra2FzOWJPTUNJZUVkUit6YUU1?=
 =?utf-8?B?SThZUlhjSDFsTFNqQzJmU2ptZTdodFB2WXpmeUYxK2dBMHRxZ1NULzhlTEVV?=
 =?utf-8?B?K3QwN3lMM3FjT3FlR0FlWTdkWGxjT0cxdUJmMWdaWWFBRTRRRnczS2J0WlVY?=
 =?utf-8?B?ckx1K2RrQ3FNZ0UvNmxBTUVvbTVieEh2NDFrSCsrbXJuYk0yWHk3Z213bHlU?=
 =?utf-8?B?OG1Rd2NLMDNJS0hMRmNINVpPRWIzbjA1ZDljSC9wY0QvV3lDdXcySkZIL1V0?=
 =?utf-8?B?TDhFbGRodmhiK0NBYVMrUVJkNHVRSEdtRlRLNHhkWlQ0RjdQOWt0MU5pYkpU?=
 =?utf-8?B?MTk1SDl6YWhnZUxxUCs4cmlTb2ljMWdhYlZMUEZIdVBqMmdTMjVYelN5bU1u?=
 =?utf-8?Q?d61I5lc3PGCHADmq+Jt9STQHSCGeaktYGgm9M=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8059.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?SHV6dHR6RmJiaVlEZWxaY2ZmSXdpR3FpcmpEcWwvVDBVUHlsaWpoZlgvaUVo?=
 =?utf-8?B?MW9kUTB0QlYrWERRRTMwRXhRdEV5UkJZczZISmZmUjZDRS8wTEt5VDBrc2Rp?=
 =?utf-8?B?OTEwM2lnMXBXcE9RMU5iODdoeVhDclBDL3ZwaWdaczNUQlp0dWRMWlRjVWp0?=
 =?utf-8?B?UmUyQnlvcE5SdFRtQ1BQTlBBMGl5V21BREIwMlg5aEpyRnlSRmk1WmZzR0hO?=
 =?utf-8?B?K1p4K3I5KytjSVpvSHNVRGY1enRLTzFvRFFObkNyQTJmaXZkcTA0a1BsUld3?=
 =?utf-8?B?SFRiZ0ZGSTc3QThKaGp4bUtJV2ZIeEV3TTJmN3c1T3VvNjA0QUFONDViQm5o?=
 =?utf-8?B?UUtlbm1wK0w3YU9SalNyall5YldZeVJzQ2VNRE9YWW9TZUtzZS9RbWZrYzNh?=
 =?utf-8?B?NTdCanR6bTE3a2lOdHZ6bjhLd3NycWRzTTdFNnUyYlBUcjZWbU1tQXBkSzFX?=
 =?utf-8?B?dXRMK3NjZzdKRU1udlRTOTFHYWJ4M0tOTngyV2trOVJrODNpd2dVYlZMbVdB?=
 =?utf-8?B?c3luOWhiWjN4dmljcjVySzMyT3pxUWF3QVRlam5NbHBlZVlZQ1RIK1gySmZG?=
 =?utf-8?B?Q0g2dWhEVDMzd3o0cm5yYlRmN3htaEZFakFSdmw5N09zaHhDUytLTC9vcmJm?=
 =?utf-8?B?M3VrL0VhdHlPN2dJTHptUlR3azYwYTkxdDdDVVR0QVhqZ0RpdmpIcmYybWZw?=
 =?utf-8?B?MW1lOEpuWmVmRWFqKzJhZ0g2RDFuQy9Ib1JVS0VaMVJWZWErTStwc0ZyeC8y?=
 =?utf-8?B?SEFaQzFrcnN1eHNoQXllUkpZTDlaVENRWWYzc21hSEZrbUFwbFhPdU8vd0N2?=
 =?utf-8?B?eU1paXhnSHJoRHQ3N1IyVXRiUnQrT3luRmppOVhBbFRSQVZnQkYwYWdPN2x5?=
 =?utf-8?B?eU5YSXJOTzRiYjMzaXNPclh4UWFlcUJvZWlDZWVybHpBSmp4ajVjaS9HblR6?=
 =?utf-8?B?cDFrVXF1MklTWUgrMWUyZFlEaEZaZnAyNjhtVFc0RjUxM3VUT2ZhcWJuRWpj?=
 =?utf-8?B?Z3g0dXZTZFJSN05rc2orckcyOGp5KzVqK0h1U2JPT1I0SkFTWUpRVVArTHg2?=
 =?utf-8?B?RE94TEFwU2dCQXV3bHlxV1RpaHJhRHd4WFA3QmhXMlZXRUl5VGw0VFBONHFO?=
 =?utf-8?B?b3VrMnluL0FPMERzOGpsMFlKazBqa2w3bjB6L1RDVllRTmZmcGVFeUF0ejBx?=
 =?utf-8?B?TU5ieVpUV3VrNE1CTTd6bVFiL3pXOVVTRGtUeDF2MFFYdWhJM2t4R0pHU09N?=
 =?utf-8?B?dE9La2hrNWZjL2F2K2ltMHh0bkhXWVQxdjZORHNXOEZNWnVYUlhFYVBsV1Ns?=
 =?utf-8?B?MFZzZkg0WEx1NXFrNWJaZ3dwMTFiLzJwSEdvdGhDRysrVXMzZk9CSHJkcmYv?=
 =?utf-8?B?NE10Tk50cFA4NURFeDVaMkhIMWw4aUp2Zy96U3ljRHhyUHh2QklhQWY3U0ZQ?=
 =?utf-8?B?YStpLzlIVWFvNUpDVlBKb0JvRlRaTG92UUlCMjdVVjhoU2tOLzg1K3pqakFL?=
 =?utf-8?B?d210UC9jSWNiNXpZUGNiZHlYeEFlS3luaDZsWktrRGVqMTUvRnFublNMZENv?=
 =?utf-8?B?bzFaS0xFNXEyenVoMTFKVHBOVTd4T0p6TzVHNHB4YkFlZW1BVUdqVEFzZHlK?=
 =?utf-8?B?eW9JR1pxWXExUUZZdjNZVGFjbi9TclZQK241REYwc3dkNi83SjdlRk1KVmxa?=
 =?utf-8?B?b3V2YkRkbmhtSVdCWmZ3bGNtSXZ3TnNYRXRPYUhHbDlFRW50dVQ0T1M3Vk1a?=
 =?utf-8?B?bTArdkoyYSswRjFGWlUxbFJGZGhqazdSSjZHVFc0SHl0bkVOZlJ0Zzc0cW4r?=
 =?utf-8?B?Ynk5a0ZvZzExdjRTZUFiS2EwaDhGZWFMOUhJNzhXMmFXNnlXOG4zU1AwckVI?=
 =?utf-8?B?U0VxZWxDNFYzTFAybEtaQmNoNEprZFhTVVpqQUFPNEJYeStvUDN2S2U4TXB4?=
 =?utf-8?B?UG5kdHpWbXVaUDQ4TWJ2Y3BETzZhYVBXejEvTU5mUTlqUFpQR1h3Q2MvQWE4?=
 =?utf-8?B?QStrNTZBMVlTeE14dVFtMC9zRFdGWFhKenlGMW1yYStocnNBMGZ2c3VrRmxj?=
 =?utf-8?B?and5Y0Z4bk40MEErdE4vY1NrOW5KYjgwN2cyalJ2bHFjL2loOWdpZnZKUEVr?=
 =?utf-8?Q?+D3w=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8059.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0652d1b2-5288-4403-1e2b-08dc8465cf89
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jun 2024 07:13:18.7679
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: stlcohcjiFzSr4aCDNAKDUziQSc6hVdGc4l57bWwChnrNeHc5ZO5wl7s9vImPPh8574uhoZyW00Ms2kxHh0BKw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5751

SGVsbG8sDQoNCkkganVzdCB3YW50IHRvIG1ha2Ugc3VyZSB3ZSBkb24ndCBtaXNzIHRoZSBmb2xs
b3dpbmcgcG9pbnQ6DQpGb3IgSU9DVEwgY29tbWFuZHMsIHRoZSBkZXZpY2UgTVVTVCBiZSBhd2Fy
ZSBvZiB0aGUgYWN0dWFsIGFyY2hpdGVjdHVyZSBvZiB0aGUgZHJpdmVyL2tlcm5lbCBiZWNhdXNl
IHRoZSBkZXZpY2UgaXMgcmVxdWlyZWQgdG8gaW50ZXJwcmV0IHNvbWUgb2YgdGhlIGluY29taW5n
IGRhdGEuDQoNCkJlc3QgUmVnYXJkcywNCg0KLS0gSWRhbg0KDQotLS0tLU9yaWdpbmFsIE1lc3Nh
Z2UtLS0tLQ0KRnJvbTogTGVnZSBXYW5nIDxsZWdlLndhbmdAamFndWFybWljcm8uY29tPiANClNl
bnQ6IFR1ZXNkYXksIDQgSnVuZSAyMDI0IDY6MDkNClRvOiBTdGVmYW4gSGFqbm9jemkgPHN0ZWZh
bmhhQHJlZGhhdC5jb20+OyBNaWtsb3MgU3plcmVkaSA8bWlrbG9zQHN6ZXJlZGkuaHU+DQpDYzog
UGV0ZXItSmFuIEdvb3R6ZW4gPHBnb290emVuQG52aWRpYS5jb20+OyBJZGFuIFphY2ggPGl6YWNo
QG52aWRpYS5jb20+OyBZb3JheSBaYWNrIDx5b3JheXpAbnZpZGlhLmNvbT47IHZpcnR1YWxpemF0
aW9uQGxpc3RzLmxpbnV4LmRldjsgUGFyYXYgUGFuZGl0IDxwYXJhdkBudmlkaWEuY29tPjsgbGlu
dXgtZnNkZXZlbEB2Z2VyLmtlcm5lbC5vcmc7IEJpbiBZYW5nIDxiaW4ueWFuZ0BqYWd1YXJtaWNy
by5jb20+OyBNYXggR3VydG92b3kgPG1ndXJ0b3ZveUBudmlkaWEuY29tPjsgbXN6ZXJlZGlAcmVk
aGF0LmNvbTsgRWxpYXYgQmFyLUlsYW4gPGVsaWF2YkBudmlkaWEuY29tPjsgbXN0QHJlZGhhdC5j
b207IE9yZW4gRHVlciA8b3JlbkBudmlkaWEuY29tPjsgQW5ndXMgQ2hlbiA8YW5ndXMuY2hlbkBq
YWd1YXJtaWNyby5jb20+DQpTdWJqZWN0OiBSRTogQWRkcmVzc2luZyBhcmNoaXRlY3R1cmFsIGRp
ZmZlcmVuY2VzIGJldHdlZW4gRlVTRSBkcml2ZXIgYW5kIGZzIC0gUmU6IHZpcnRpby1mcyB0ZXN0
cyBiZXR3ZWVuIGhvc3QoeDg2KSBhbmQgZHB1KGFybTY0KQ0KDQpFeHRlcm5hbCBlbWFpbDogVXNl
IGNhdXRpb24gb3BlbmluZyBsaW5rcyBvciBhdHRhY2htZW50cw0KDQoNCkhlbGxvLA0KDQo+DQo+
IE9uIE1vbiwgSnVuIDAzLCAyMDI0IGF0IDExOjA2OjE5QU0gKzAyMDAsIE1pa2xvcyBTemVyZWRp
IHdyb3RlOg0KPiA+IE9uIE1vbiwgMyBKdW4gMjAyNCBhdCAxMDo1MywgUGV0ZXItSmFuIEdvb3R6
ZW4gPHBnb290emVuQG52aWRpYS5jb20+DQo+IHdyb3RlOg0KPiA+DQo+ID4gPiBXZSBhbHNvIGNv
bnNpZGVyZWQgdGhpcyBpZGVhLCBpdCB3b3VsZCBraW5kIG9mIGJlIGxpa2UgbG9ja2luZyANCj4g
PiA+IEZVU0UgaW50byBiZWluZyB4ODYuIEhvd2V2ZXIgSSB0aGluayB0aGlzIGlzIG5vdCBiYWNr
d2FyZHMgDQo+ID4gPiBjb21wYXRpYmxlLiBDdXJyZW50bHkgYW4gQVJNNjQgY2xpZW50IGFuZCBB
Uk02NCBzZXJ2ZXIgd29yayBqdXN0IA0KPiA+ID4gZmluZS4gQnV0IG1ha2luZyBzdWNoIGEgY2hh
bmdlIHdvdWxkIGJyZWFrIGlmIHRoZSBjbGllbnQgaGFzIHRoZSANCj4gPiA+IG5ldyBkcml2ZXIg
dmVyc2lvbiBhbmQgdGhlIHNlcnZlciBpcyBub3QgdXBkYXRlZCB0byBrbm93IHRoYXQgaXQgc2hv
dWxkIGludGVycHJldCB4ODYgc3BlY2lmaWNhbGx5Lg0KPiA+DQo+ID4gVGhpcyB3b3VsZCBuZWVk
IHRvIGJlIG5lZ290aWF0ZWQsIG9mIGNvdXJzZS4NCj4gPg0KPiA+IEJ1dCBpdCdzIGNlcnRhaW5s
eSBzaW1wbGVyIHRvIGp1c3QgaW5kaWNhdGUgdGhlIGNsaWVudCBhcmNoIGluIHRoZQ0KPiA+IElO
SVQgcmVxdWVzdC4gICBMZXQncyBnbyB3aXRoIHRoYXQgZm9yIG5vdy4NCj4NCj4gSW4gdGhlIGxv
bmcgdGVybSBpdCB3b3VsZCBiZSBjbGVhbmVzdCB0byBjaG9vc2UgYSBzaW5nbGUgY2Fub25pY2Fs
IA0KPiBmb3JtYXQgaW5zdGVhZCBvZiByZXF1aXJpbmcgZHJpdmVycyBhbmQgZGV2aWNlcyB0byBp
bXBsZW1lbnQgbWFueSANCj4gYXJjaC1zcGVjaWZpYyBmb3JtYXRzLiBJIGxpa2VkIHRoZSBzaW5n
bGUgY2Fub25pY2FsIGZvcm1hdCBpZGVhIHlvdSANCj4gc3VnZ2VzdGVkLg0KQWdyZWUsIEkgYWxz
byB0aGluayB3ZSBzaG91bGQgdXNlIGNhbm9uaWNhbCBmb3JtYXQgZm9yIGNhc2VzIHRoYXQgY2xp
ZW50IGFuZCBzZXJ2ZXIgaGF2ZSBkaWZmZXJlbnQgYXJjaGVzLg0KDQpSZWdhcmRzLA0KWGlhb2d1
YW5nIFdhbmcNCj4NCj4gTXkgb25seSBjb25jZXJuIGlzIHdoZXRoZXIgdGhlcmUgYXJlIG1vcmUg
Y29tbWFuZHMvZmllbGRzIGluIEZVU0UgdGhhdCANCj4gb3BlcmF0ZSBpbiBhbiBhcmNoLXNwZWNp
ZmljIHdheSAoZS5nLiBpb2N0bCk/IElmIHRoZXJlIHJlYWxseSBhcmUgDQo+IHBhcnRzIHRoYXQg
bmVlZCB0byBiZSBhcmNoLXNwZWNpZmljLCB0aGVuIGl0IG1pZ2h0IGJlIG5lY2Vzc2FyeSB0byAN
Cj4gbmVnb3RpYXRlIGFuIGFyY2hpdGVjdHVyZSBhZnRlciBhbGwuDQo+DQo+IFN0ZWZhbg0KPg0K
PiA+DQo+ID4gVGhhbmtzLA0KPiA+IE1pa2xvcw0KPiA+DQo=


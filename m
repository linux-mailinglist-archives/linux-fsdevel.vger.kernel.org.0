Return-Path: <linux-fsdevel+bounces-4385-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD4277FF2A6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 15:41:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A9E51C20BDD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 14:41:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6590451007
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 14:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="GFRo6XyO";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="bDd+kNRc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF67610E2;
	Thu, 30 Nov 2023 05:19:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1701350350; x=1732886350;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=i5lgGuo0tXX6fJ+P1IjaRWhy57FeBr0XxgTGPiebeXk=;
  b=GFRo6XyOz+/00TINKh/QkaWAMf9YV+hFTjZhqh2ZzHwSOD5fQsDqDZNb
   LzaI0LOv0+v4nG82uzGKSoJR9LUQ0RUS0cBCNyTksrcylGciPE0/UcJLg
   xqNfwR56mnJUzxmGL/VDD/IaHprlu2uctyl6OiKJ9RG5OB+Fwns/6HwaU
   2KjR7ff0FzZmInHp2ERwI1rxWQbgNfdevq6wmGmqI2QPaoNuucG7v1OGs
   2Ug/BFoJ7ZdqYL3pXXnPawtKIFHbOFYhY+psSpWmeIpOIi+yBusngdel7
   tUm2SB65kvebHMRfpEGUE0VGr3HkxctOQM8LAaA2cJ6C6gNDLgL24eD4o
   A==;
X-CSE-ConnectionGUID: bXlCsAstT2St3REjSUXyFw==
X-CSE-MsgGUID: 2CaxnCa9RxisB01GcHqECQ==
X-IronPort-AV: E=Sophos;i="6.04,239,1695657600"; 
   d="scan'208";a="3562400"
Received: from mail-mw2nam10lp2100.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.100])
  by ob1.hgst.iphmx.com with ESMTP; 30 Nov 2023 21:19:08 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SwxVegcQCQn3p+VD8z8ty2yH501b8x0T1VJSWoU1j/MaUuaPtExd65eNYFqrChHMNAOXgi7Kb+fHaEWhH9Zx7otsXAATZwiRZVX9zDHsXzgbYt4sXEUmLBcvzvDfwavDcviT/+y74LkZybNv+PBKoH3searYYAHtlk7bse/ufmfIqYluy5THXKpx6FFTwA3uY/ePI0DRmGQcXGGppiL1TFnNG3R/J+RgfZTU3VgdikM2DClzqXczD5pKdcCvl35veTYTG6/7lT0taZQPXRzFAVp8Ldkpr8S+obFsQlEMFB7ulvxIuUSZ9fywm2qe0a5gFXV8n2hakDw9ZENmcajwtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i5lgGuo0tXX6fJ+P1IjaRWhy57FeBr0XxgTGPiebeXk=;
 b=XPIF0BpaFnWHnGxnW7jYxlc7w4HaOtmMsQDE+53E1/IJkn51XFFrxoMioBP/Zui2Zr+n9XK7IDx/lVK0Gc0MrtDRLxFrBCm+jvoCqBPaHRY+0v+7bv7VhCZZya0W6X4X3t86wnVBhFZ6JJcGPdIg16BZUtl9sktyc4pIMsxTltrcamR5yp1Vsjo8nHVxRr24Ud806JxHOka/ydqvzwICDCdlb9mWVP8KtiGwmdgu8rL4Q7pHItc/PWfg2KAincM/aovQDvrDWd2rkI51d4hkU8WUdZhyKpQd5ybysB7HzYEK4wMI5a3hZPDFHa0cAyWhb2GOr3MSwhb+cHlVPhATYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i5lgGuo0tXX6fJ+P1IjaRWhy57FeBr0XxgTGPiebeXk=;
 b=bDd+kNRcJDiOAU7NMXg4t0tPXxPfiYEyHlFQ3c34rdJyMj1Xywmfj8avWXjnR+JV79vPyQdSBjn8okCmFfRCY7INxCFPMX0oX+Pjlw/V459zKGyhbBhD6G6CqvdlQJ+uprBXpj7tIs6O8JhwROemSzoWalypgwWLon9OsTbjUeE=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by BN0PR04MB8062.namprd04.prod.outlook.com (2603:10b6:408:15d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.24; Thu, 30 Nov
 2023 13:19:05 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8ea3:9333:a633:c161]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8ea3:9333:a633:c161%6]) with mapi id 15.20.7046.024; Thu, 30 Nov 2023
 13:19:05 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Bart Van Assche <bvanassche@acm.org>, "Martin K . Petersen"
	<martin.petersen@oracle.com>
CC: "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, Jens Axboe
	<axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, Daejun Park
	<daejun7.park@samsung.com>, Kanchan Joshi <joshi.k@samsung.com>
Subject: Re: [PATCH v5 09/17] scsi_proto: Add structures and constants related
 to I/O groups and streams
Thread-Topic: [PATCH v5 09/17] scsi_proto: Add structures and constants
 related to I/O groups and streams
Thread-Index: AQHaIy1re7swogtLckOvYwcVINNzkrCS2TkA
Date: Thu, 30 Nov 2023 13:19:05 +0000
Message-ID: <35f9ad75-785c-4724-b28e-a093212bc480@wdc.com>
References: <20231130013322.175290-1-bvanassche@acm.org>
 <20231130013322.175290-10-bvanassche@acm.org>
In-Reply-To: <20231130013322.175290-10-bvanassche@acm.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|BN0PR04MB8062:EE_
x-ms-office365-filtering-correlation-id: c579a9ff-0538-43ee-95f7-08dbf1a6ed62
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 +mVcsPBgvuygnzWkdKcqhXpOROlwnf1o6cnxgLYGt9YqBlpG+5QnJX0YJfZy+fOBAD+5oEa8CA3e1RxcVEbXrb+6egw0bcdcFIE1MPqemkpKbe/tYxyCUon1wnJX9MxSnE4edcUH8yHkCPvhm7jU0FbPpJjCWazzWXPzj7KdfTkPo3vJ8sJ88+Aj3QmqGfkU4l0GJVzuFtH7GK3h1sGu2yNN1pMkxcU0KF3qev4ERTHJBc3IpS5irEher06pKhWIsPUvgZ0HMoe+3+zjZcuWrK76DAmMKY8B57h+KoWV0T1w+0ARzKtBj2liseOEi/vBycEIZj2J5lfaxpQVstGKAiwxO6k859eYfY0rH/60gv7qdWnwUjF3MAGehGmH/XKGT33jbttPhWuOGXUmBQJlZ+yMMa/eU2TcDb97LefLI8EoL7KAvl3PTI15thmj73JYm5NquSF/vee0iTscFSfS0rcsnYPCfXG28TDg+31YC5OVUwYJl236eEnvjTJLUjPE4eKzermMIgsGW+8PfX4fcrhfL/uJEgj1gmGK7W/zOGraOgKWT1qcLvJ/jI5NhQueopyQql30o8ZwTKDZv+mLszYX7T+BHwD667Ub+w5JZY45YmVzjixk9RH3olUDj+HCAACHK+hJmWK8fGKksZ5JdObniUbxZbIrH9BspuUJlk8TPE+54elNRc3GTmEv3+LO
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(396003)(366004)(39860400002)(136003)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(31686004)(26005)(2616005)(71200400001)(122000001)(36756003)(38100700002)(86362001)(31696002)(82960400001)(38070700009)(83380400001)(5660300002)(6512007)(53546011)(6506007)(8936002)(8676002)(66476007)(66556008)(66446008)(91956017)(76116006)(66946007)(4326008)(110136005)(64756008)(54906003)(316002)(2906002)(41300700001)(6486002)(478600001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?NFY1YmVIZndDQVFGN2ptcWtNNVBvRUQ4UkxCbWhKSTNUNGNTK0hQWEgvZ3BJ?=
 =?utf-8?B?R0x4dXg5eVBVREtWWnloQUdnN0NYclZlRkhzYXp3U21sVEltbU9EaFVLeXBx?=
 =?utf-8?B?czVFNnZtU0dJS2ZDTmxVV1FKdGdtNmp1cDZiUk50b0E1YXdaMnFJa3h5SkRr?=
 =?utf-8?B?WW1ZSHhVMitwdUN3RXVUTHdhU3M4c2Z0cnJCOElER2xFQ29Sd2Q0VXAvaXds?=
 =?utf-8?B?cC9nSGlQNUdnOFo0aVRGUXIrd1pkV2pSQ2V6OTNhVmNlS0laK2YvVmRUdmlW?=
 =?utf-8?B?WXo2b0EwN2gwd3ZYZFVQOCtNM2xqZ2dLMHlqUDRIc08wOXFwalIvOVFDbUdD?=
 =?utf-8?B?Y3pwUVpLUHNtbTNzNWV4eG5NdGpYNUd0TVMxNkFKNWxFV2lTTUNueW5lTGVs?=
 =?utf-8?B?S3JqK1NyM1M0QXlRUzhUWTUyQnZwSGNrR3BYSnVMeVFmemNhN0dHUHVwRTFQ?=
 =?utf-8?B?MUFnSm1RUlJReUR6VThRM2MrV2wzTExYN2dNQ2d0czN5YkMzR0RXM3Q2d29y?=
 =?utf-8?B?QlIweUF4N1NZaEJqVENuWWc5QVBqT3RLeHRLM1dUMjh0UUVxd1FZaGFtanJs?=
 =?utf-8?B?WXhFTXl4Z1VGam9TTkVWVms3ZWFIOVpjdGhDajJRL2cyQnhHT1cvQ3g3WVJ4?=
 =?utf-8?B?aGpPTnFEL0FkWFAwbHFMc1hHOTdRNmFSWkpWblJ3OUZ4cm9BT1haQlBHRzJG?=
 =?utf-8?B?WmNyMmh0aW0vQkcxalhKVU96YW9wZVhXYlJvMit1QWlwREo1NENGWHM4UHZZ?=
 =?utf-8?B?MjhXbzhCejM3T2svcHJOV3hMQUNEVmFrUzAxb3d1QW80SGhRN0JyNjhwU0Y4?=
 =?utf-8?B?UGF6dzFDMVk2bURUSFQ4akRDczJta3ozMHB4bERyQ2pPb1Y1Q3BIdzZuQ2dp?=
 =?utf-8?B?STdrM2tUV1VpMUdudFdaZy9OQ2hkQVBDaFZQYVBmaDZSNmoxOVluMkpPaWdw?=
 =?utf-8?B?TGRPNnpJREM1QUdpVXk4c3ZsYjR3OTh5SWFRVy9ZZU1qZjN2d3lZNExBUTlE?=
 =?utf-8?B?dkd5WDdvMWhHSWFpZ1A0MGJDOXVmeDBIaHNsSTJDR2pvWVpXS2t4NHU3Z3dW?=
 =?utf-8?B?Mm1UN1BreU9WL1JKdW1IVVo3WmxUbGNzUHI0R0FWdEZKSzFTVHk2TUU4c2dB?=
 =?utf-8?B?SXB4WGdVUktwYTdsS1ZXVDVJVU9kQmVFazJMRHdMeFVQbmRPT3g3bThGZCtC?=
 =?utf-8?B?b1luS0hxeEF0YUMzVVpqdURLUDNTZytPWElJNGU0dVNVNTZ5ci9zMDRYSjhv?=
 =?utf-8?B?K3psYkFDNGRDa0R2bVpRUGR3RDllWnE5VG9HamtEK2FPMlhWSW1LUWZVRkNs?=
 =?utf-8?B?bTM0OWJyVk5vVVIvZDJhbUJYamNOdDBFb0R4R0dqYUVhM0dIYnNBVWt3OS8z?=
 =?utf-8?B?L1F3NjZnQjNtK1NLWDF0dS80WlQxREdwQVI0eXMzUUFkblU2SitoNTZ1VU1Z?=
 =?utf-8?B?aWZVKzNsdVh2b2NHb1NvK3lsMHMwc1FuSjFZUFBNYXpDemRwUEJFNDcvSWlN?=
 =?utf-8?B?VzNPV1l1TXQrV05zN0R0WnBJNE45dXJIanNjang5MmIybm02Vk9rS2w0VXJN?=
 =?utf-8?B?Nnd0Ujl1VkI1WjBkRFRRRG01dUtLNDVMRWRheXArcy9HTEhoY2JFNzZ0QXh5?=
 =?utf-8?B?eUw5UlV3SmhDeXJQMFdxaTZVdnlUVkdjRHpORlB4WnkvQ3N1WEowTVJXcVVo?=
 =?utf-8?B?RmFHQkpyWGl3Y3Avb1gzZi9OYUpMb25WazZYY2IrZ1RoUnJZOVNmY0ZQckEx?=
 =?utf-8?B?aEs5L0l4MWhFSC93SjRZZHZXdVV3NC80RkU1V1g0TTlyc3ArTXQ3aGlkb1RZ?=
 =?utf-8?B?TERXbzM4aVFENDF6Rk15SnE1NWNsSEhVcitWckt2K2FDRkFIMEZRV0Vvd0E3?=
 =?utf-8?B?ZXgyTENNWnNtT0g2MndyaitzVXZaWDVSa1kzS3pkRnBFZEg5UklnM1NiRkJJ?=
 =?utf-8?B?UzFCV0pZbCtyYVNRRGFoN00yWVZZU2hHMmV6Zkg4TVZrY214WnVjTUJMdlhp?=
 =?utf-8?B?QzJheHpOTFVHMlcvS0traldCMlhaZ2loa2pnNC9Yb01aS3hpOHIxbWhUZ29y?=
 =?utf-8?B?eXFEclNDUU1Ta3ZyQXhtSUsrTUhyNEVUN0FDaFFzdk9tU0tBV2RkbDZxSENs?=
 =?utf-8?B?SDJkdzl1a2VrRCtMNnJvZUhPZHdZVi9sczlmNWttRG1KUXlUZW1DUUNSQUQy?=
 =?utf-8?B?VFE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0895528150646C4D9378FB9D9657740D@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	fbHtJQtqtV5ls8EaWl2u4BZWBZ4gL4teiDqJJmIBd3GENyXMYJ0t1FT6D+y5utlbT3shQVQTRgQ6egXL75kDwX3i5pKyB79zvslwE0flIHrG2fg0orx0/A68yvEeh5CUX/l483F4fKX8QoD3rTtPgO4gpmD9iBTC0gRLmB3+lr4+GASzACwh9Wv3m5VmgpyA5qq2cW/ZcaKz3fKvcSfiDvna1uMEEpc3eMICawigKuU14eVTRLXqOqREFY/2+a2SH7d4YwdcWvm3RCF9yJOB9caISlRPvW2nh8YtOrF9G/GsOHH/YjvNjWmGw1BicP7HQ3ixiuD74x7iZfxceqHWRRiMt4+daD4DrIBXHApqHvEHb09djYjJABcyeDHkPPZLtHAagW9QrxdSne+UPIlWoOd8Op9mlAte3Qw6MgGrcJgJCAh8WccDsbTS4a6ySj4r1Cdj4Sf7lBPrdg4bYXuwnauE7L1GOAT58+4O25A9ZbQSawYxxXciqWO8HWD89k1bYAd75bpefKXBpp7uKxboRKgrnwY2PLx5D8R9OVf3GfkE0VswXFxjbMtuCOIq0xtb1umH5v1HAiOr+z6tIiCurucjXclBtFyn/VtIUj2s1pFMnd3pq6Vlvjdk6UYt+EHRZxdevwUWZJO00CYwFfFrdECML9K0k486RhFhPu5dGpj03j0dcu6sBsMtSigbGcEl5C3dWVChHlb1lrqbKL6AQT6nEnX2bdbLk8UEcY4APISp49v6b6vI2R7MCUPLB7CPKEC3RTWvday7KyfFxd7wvmPM9WupnlAX0jlSDCkeZfPompNBW/5w8/nuA0GOJtGFS1mR09reVNjUkvkgwXv5CrC/SExv6wSwJ40Wd6y/QIc9b2SbugDCRcd2XsYUh6p6jSoSUdeKmCltb52dbiue5JZAZThcMKT52kbdDuhBL5U=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c579a9ff-0538-43ee-95f7-08dbf1a6ed62
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Nov 2023 13:19:05.1967
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +kdeGW4lM4JMf845xV7hrawO0v/xjbK3FVbn0YNrn770eafqVn2OeEU4nJ2nIJQAmxr9fR+lJtlX36UwKpn8NKunoKmfE8wHcdS8IfgJ9OY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR04MB8062

T24gMzAuMTEuMjMgMDI6MzQsIEJhcnQgVmFuIEFzc2NoZSB3cm90ZToNCj4gKy8qIFNCQy01IElP
IGFkdmljZSBoaW50cyBncm91cCBkZXNjcmlwdG9yICovDQo+ICtzdHJ1Y3Qgc2NzaV9pb19ncm91
cF9kZXNjcmlwdG9yIHsNCj4gKyNpZiBkZWZpbmVkKF9fQklHX0VORElBTikNCj4gKwl1OCBpb19h
ZHZpY2VfaGludHNfbW9kZTogMjsNCj4gKwl1OCByZXNlcnZlZDE6IDM7DQo+ICsJdTggc3RfZW5i
bGU6IDE7DQo+ICsJdTggY3NfZW5ibGU6IDE7DQo+ICsJdTggaWNfZW5hYmxlOiAxOw0KPiArI2Vs
aWYgZGVmaW5lZChfX0xJVFRMRV9FTkRJQU4pDQo+ICsJdTggaWNfZW5hYmxlOiAxOw0KPiArCXU4
IGNzX2VuYmxlOiAxOw0KPiArCXU4IHN0X2VuYmxlOiAxOw0KPiArCXU4IHJlc2VydmVkMTogMzsN
Cj4gKwl1OCBpb19hZHZpY2VfaGludHNfbW9kZTogMjsNCj4gKyNlbHNlDQo+ICsjZXJyb3INCj4g
KyNlbmRpZg0KPiArCXU4IHJlc2VydmVkMlszXTsNCj4gKwkvKiBMb2dpY2FsIGJsb2NrIG1hcmt1
cCBkZXNjcmlwdG9yICovDQo+ICsjaWYgZGVmaW5lZChfX0JJR19FTkRJQU4pDQo+ICsJdTggYWNk
bHU6IDE7DQo+ICsJdTggcmVzZXJ2ZWQzOiAxOw0KPiArCXU4IHJsYnNyOiAyOw0KPiArCXU4IGxi
bV9kZXNjcmlwdG9yX3R5cGU6IDQ7DQo+ICsjZWxpZiBkZWZpbmVkKF9fTElUVExFX0VORElBTikN
Cj4gKwl1OCBsYm1fZGVzY3JpcHRvcl90eXBlOiA0Ow0KPiArCXU4IHJsYnNyOiAyOw0KPiArCXU4
IHJlc2VydmVkMzogMTsNCj4gKwl1OCBhY2RsdTogMTsNCj4gKyNlbHNlDQo+ICsjZXJyb3INCj4g
KyNlbmRpZg0KPiArCXU4IHBhcmFtc1syXTsNCj4gKwl1OCByZXNlcnZlZDQ7DQo+ICsJdTggcmVz
ZXJ2ZWQ1WzhdOw0KPiArfTsNCj4gKw0KPiArc3RhdGljX2Fzc2VydChzaXplb2Yoc3RydWN0IHNj
c2lfaW9fZ3JvdXBfZGVzY3JpcHRvcikgPT0gMTYpOw0KDQpIaSBCYXJ0LA0KDQpIYXZlIHlvdSBj
b25zaWRlcmVkIHVzaW5nIEdFTk1BU0soKSBhbmQgRklMRURfR0VUKCkgZm9yIHRoaXM/IEFsbCB0
aGUgDQppZmRlZnMgbWFrZSB0aGUgaGVhZGVyIHJhdGhlciB1Z2x5Lg0KDQo=


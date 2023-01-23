Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15AFB678221
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Jan 2023 17:49:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231485AbjAWQth (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 23 Jan 2023 11:49:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231923AbjAWQtg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 23 Jan 2023 11:49:36 -0500
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C1E329169;
        Mon, 23 Jan 2023 08:49:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1674492575; x=1706028575;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=8xVfRCHr+FRs5seq8k0QM2Arzalj1slewXTUt1W9h+c=;
  b=GeMEvl/n/AcvxCVp1wbiespPrwoSU5/y17v7p/9bliyQrDTCven7x3P9
   3wzlHThuIshUZTqoNPEPn5fCW5eTBalBO5IbSeXKQuk33moWU3s2OG1tY
   fNfE4IwyhZKPKYiuDKJeuSY9IuF3jK9W7bYHksZ7fKwMLJkJz6/2jD7Uy
   TG8sID54T4pYITRGKCZMjp7Cw62OHLeWpSE9kWywsWti5zRUYaugTZ7h9
   FxAdLcK0LQMdTv0aA8sFMJ05Rn+El/ENTyA0LEA06F49ReadRzVfLAN8j
   aRQfL3Vl9xESItfAVRUIgB3uEBxIlZ1XtDxSnAcFJTVV/VLg8f22qyuv7
   g==;
X-IronPort-AV: E=Sophos;i="5.97,240,1669046400"; 
   d="scan'208";a="333552385"
Received: from mail-bn8nam12lp2177.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.177])
  by ob1.hgst.iphmx.com with ESMTP; 24 Jan 2023 00:49:33 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oHVqLaa2sQic/Iflb/j25ZXanDABjPAnCp6cK5WoPUMEvpezZ2YgafwXfUx0OJzv6uW9rPLh74mwZ08zrx7lsEGkaM1UcWUcLd2UMRtYrWBzQUdbC2DjpZiGHVmAJoNw6gBunTjL/bRzzO6YEoWjWL26cH/xp/xvze2jowAh7+Y0SJROxC0Zfs88nFYk96t8FSX81PaRZWqgoxhR4rqvuksIVvS4ITo7w+vh/sm0AtiLznwDy2NalQ+b5H8STAcWRDyeXH7Gg/upyDZ9Bq+HrcsrFFzlcX9C+bFo7dxqTu1aUDqJdUbLj0LKehz/R/9su0+C09aEfmDa6YmhNXwp4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8xVfRCHr+FRs5seq8k0QM2Arzalj1slewXTUt1W9h+c=;
 b=Crt62xoLznr2jjENm4QFd6fNqAg5k+ILzuzkiLPSGC4fwswTEa2GEsGiOdZ+w6kggeJnKwsqoxaUBa8+LWNQ2ULdafcTyU2LfmBpKomA+Rc2ZnepgmrnNzLyM4dQ5VqhhE2BnkxDg2ntHwejM3qCsbOxK8vAOd8vbKkeTyJPeP5/6rnlvvvh+DpyVcCxS1qqCubgx4v0GxSkC3pCcodlgotGT0DC4geHvro95Y7mEWy6ODcU6mkjlOEX7ku4uatGEEZD66tFdHe47q9w6Wr6QEU0LnhdWg71Cm9pN6q6m+iJ+JOjI+m+4ZDgbduHYRGwvzI7EvL4EH5ierrQcMpIOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8xVfRCHr+FRs5seq8k0QM2Arzalj1slewXTUt1W9h+c=;
 b=DHBu32+EiSvu3ehTHgcm6Hp7ypkd0/l1xse7bliNMDxMkcycHXQDi0oazdB7vz5MwjvJ0IunvBtrvFvNgLayHrQt2HnmaaTEO4mjlTo0kzD+9n5iiqL8I6sQTC916/6AmuTh1cwgEnt5Rpf4gWbggwmBoNK2fsq5N76YpsSU7d4=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by DM6PR04MB4458.namprd04.prod.outlook.com (2603:10b6:5:2e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.28; Mon, 23 Jan
 2023 16:49:30 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::d4bd:b4ef:5bff:2329]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::d4bd:b4ef:5bff:2329%3]) with mapi id 15.20.6002.033; Mon, 23 Jan 2023
 16:49:30 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
CC:     Damien Le Moal <Damien.LeMoal@wdc.com>,
        Naohiro Aota <Naohiro.Aota@wdc.com>, Qu Wenruo <wqu@suse.com>,
        Jens Axboe <axboe@kernel.dk>,
        "Darrick J. Wong" <djwong@kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH 13/34] btrfs: remove now unused checksumming helpers
Thread-Topic: [PATCH 13/34] btrfs: remove now unused checksumming helpers
Thread-Index: AQHZLWTCnDjcfVcXqEO9clcyBb+WIK6sOoiA
Date:   Mon, 23 Jan 2023 16:49:30 +0000
Message-ID: <7e94c06d-3b08-4101-3e5e-ce9001c14bcf@wdc.com>
References: <20230121065031.1139353-1-hch@lst.de>
 <20230121065031.1139353-14-hch@lst.de>
In-Reply-To: <20230121065031.1139353-14-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|DM6PR04MB4458:EE_
x-ms-office365-filtering-correlation-id: bfcb5c2b-1849-4bbf-52de-08dafd61cc1c
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: oboOriMKptjzAH3ibqIZc5EkfirfOdklWyc9q8/Sqrbas+cAPWssnHaNh3bi9l7SmO3XrbnGAxf4THzgZyP99IyyVPP9hEI8IZEgqaZxWSNU/NN4Uh0xlFGrx/qu/fwLCE4FIPfnkUROyYRqmsc9NqXRvR2xlAItk8EJsHmudSefG3vPPrrrtf5C6EBqkzV2SW9PVAmlTKBJzC/bTDU6Rq6A8mV3QiSNm2DBFFFtvcTMlztOKA0RjRXWj4YH24CVvZ7AjqY3BBkld1QknjO4aBYOU9VUx4vZ64iTSJ+XELw33kMQt0/Qr8tmkFotl0OVGuX2tdrnQwk/ufuZiZusYaH0C8NJKCkoTJX1CAuU37DM9lx2kheubWXCDqQuGPSDo54nr1kwehPix4TNDN/5kgdreGbtca4gBXS0aTeO/qwWpjw3DIMZkgfKCAojwGD20YC+vWBt58K2yNEgkugpcvtqZrBJV29qEu4+zQ83S02H5ztu3cYAA6tLi/twdSutFPyAv2xMweCJoYEL7V9FhQhLHkkm5gsHzxuH20PjvFUfT9mIe0fvLBH+pe83XjjIBrd4LzmTKRYUvBDq4PohCJZw1eBxkj3HF2lsOh4i/aPrSdH3zg9Up6Uyepg42kg/NO7sc96XP7YMmMwGo28ke9+T5HAvFmiB1e6HG9K0nJaDdeul6dsgomu2nxMGsMRC6WMeU+GCfbCGhn0SEmRKFapmpvt4svadXdY4YMAkZTGAp1FANTdtpf3bPGmf0NMI9/3W8dCbo2oMFvvhr4vGnQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(39860400002)(376002)(346002)(366004)(396003)(451199015)(31696002)(5660300002)(2906002)(7416002)(2616005)(66946007)(71200400001)(110136005)(8676002)(316002)(54906003)(4326008)(66556008)(66446008)(66476007)(91956017)(76116006)(82960400001)(6486002)(186003)(478600001)(53546011)(122000001)(38100700002)(86362001)(8936002)(38070700005)(6512007)(41300700001)(6506007)(64756008)(31686004)(83380400001)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RHh0N0xBM1ZyenRpakM4cFRRNjcrZTlPR1dteWtIK05rUXdyeFdVaGxXSFpO?=
 =?utf-8?B?aXVYWDZnQ3RRNzNoUytGaEQ4VS80ZGd6a3RqaGpNdmVBUVRMRjRveHdXZStV?=
 =?utf-8?B?Uk9ZMHBsdXpMbkwvS1V0NEtEN0dWMUgzMnRpN0d4UnVKdlhoSXVFTmI2Zk45?=
 =?utf-8?B?aHdBK01ZQXlZa2U3TmsrbkxDeDFFcDcwc25na2FNR1FQWDJGNFhCTFM1b0xt?=
 =?utf-8?B?Z1UwN0xzLzI5ZXhzZndRUjhzcWR5Y1Q5MU5WRmgxY01wbTdGWEFObUJGa25v?=
 =?utf-8?B?aU1BL1JDQ003cFFJclA4djUwQ2I1VUdxVmhxWVZUTm9nUmtnaU1JZitnZFhP?=
 =?utf-8?B?NXg4L1Z6VU8zaUl6aVVWV3U4UnMvSGIzOEt1ZWpBTEZHZm91YmlhbUpEeUZT?=
 =?utf-8?B?aDZBcFFxN211M2hMNU45THpGVlNnUjZ2Qi9KZFNzSFNWY0l5VHhhanVQY3dt?=
 =?utf-8?B?Uy9nRUx6Mk1JQTlJZzFoTUkwVWJzbTBuK3JRVXNZYzVnMkJGMDVyMUk5dHlO?=
 =?utf-8?B?Z1l0SWhwZnJuazdyYU1ybnMwalNxUFZDNjQ2bkpRSlhtYzN3Z0ROWUMrOGhC?=
 =?utf-8?B?QmhYYitMSHFKcDlwQlVaKzJaMlBZT0JwdVJjYXVXTGEveGViSlNUVFAxYjQz?=
 =?utf-8?B?S1lDczFBSUtndVM5K1ZlbXNSRS9EOXdQOG41WXhIMG5HeG0xU3BvbW9LcmZq?=
 =?utf-8?B?dW1qQlJKTThJQ1ZhWG5LMnJLajNYZ2Vkem9RRG5UQTFlN1QyWFRTa0VGeHRB?=
 =?utf-8?B?UE5lWE92M0ZXSnNEZ2FkL25XME1iR0Exd2lhZ2NNVnl4U0lXcVhLcUh4YzJ5?=
 =?utf-8?B?bnpKeEZ4K1lxOStKRGVvNXI1bWFHQnlKdjhpSU15L0V4ZW5EKzJrOEFQZWtm?=
 =?utf-8?B?aVlEWEovQnlZYnA2YVpqa2t0ZkQ3akV2NlFFVktPdGswM0tHZ0ovaTdvczhS?=
 =?utf-8?B?c3JNajBLdXd1a1c5cGpmeVo0aGNZbXVaOFNCUVdTSWdzVEEzOGtTS2lkTVJ6?=
 =?utf-8?B?bTh5dFFkaTl5K3l6cHFQSUNBRWpBOWF6QzRGTmZDR05OUkRGNHRQbTV5dkZm?=
 =?utf-8?B?RUJyN1RKSmx3RktDOTZhNW5qSjJmcmZOR1FadFQ1NGtibmxyOTVLWGNFL2xZ?=
 =?utf-8?B?bndWc0U0dHdHcVI5Y0hYcjFJSXdKamo0Y2k2Q21HUEcrUVJyM0x1UXVsTURB?=
 =?utf-8?B?dVNPZkJ5M1ZtOWtpTWorZ3czd1ZkTFhndUlQSHJNQnNzL0ZnZURqNEVOSWdr?=
 =?utf-8?B?dncyN2xhcnlML0xXTVJBZ3VRY1hXMkdWOThFR0srWFp2WkEzU3ZwZUFTK1Bv?=
 =?utf-8?B?ay9qa25xcG4wT3BweHJ1VnNzcUEvOGdxY3NHNldJUlBaR3NMVi94eW95Q3Rp?=
 =?utf-8?B?cWJmcjdoVzhrbjE2V0tqN3ZsR3JxZVYxckFMV0V4NEZXQWpPMlBoN3VKSmJI?=
 =?utf-8?B?RUMrc3gvaUo3cUg4WFU2U3J5NUVvc2ZRYWcvN0tYNzZmTmM0OXRzR1hXUnpt?=
 =?utf-8?B?b05nekdNeVJkS0FqZEpiMndvRS9TV2FRdEhSMTk1T0srSyswK1M3c3BudmpO?=
 =?utf-8?B?Mk11cVU1V05nbmpMWjIxTkw5KzNPSFdNUkJZOEVudW4yTjRaRVJSOWNvNkxN?=
 =?utf-8?B?QUsvMG5VV0JXSkZjRHpaRGNhMTVIS1hRZ3h3ZHZtWXFSSmNUcXNRUkp3WTRG?=
 =?utf-8?B?dUNIU0VzMzlQODNmei94dmlEYnRtbVd6cUt0VnpLMkRTZEpJaVJUNnJyZktS?=
 =?utf-8?B?eHZtV1hvQjRiMjNRbkZtY2lhZ0Faejhrd2JJeGhNQnpyT3dlVEJCUFRlVitw?=
 =?utf-8?B?N1FQVCtVZzI3bVlvOWoxOWdKanhkOXN5NnBCeVdMdjNGUDFna2wrNHlwazVj?=
 =?utf-8?B?cXJQcWJ6MVZEblBFZUNCNlpNOFp5YXVRMjE3OEZkTG5JaE1UZEdwVzFIcjRV?=
 =?utf-8?B?MzIybksxc0FZQkFSQjlsdExpUUxuaDFYZVFNczYvWndyWTd5bkJCR2RwZ3Jt?=
 =?utf-8?B?eDRmTEFFRDV4ZjlOV0VRRU83QURnMzRtNE5TYnhtcys0bCtTYU9kN0swKys2?=
 =?utf-8?B?YS9SQnpESkR0Nnhpdk9pQ2JieDhuTzFxWE9PUE5mYWNhQjVmQmh4UUduVU1u?=
 =?utf-8?B?OHE0OXA0UVJNOExsZUtuVGFZaCt1ZUZwM05JZlZCaDRXTG9xNkhUUW9VYXlQ?=
 =?utf-8?B?R1hhb2dXM1hGTXd3MEJ1eVRkejVubXlNSmU1eHBWUTJpQ3doUXVTalNnMTZh?=
 =?utf-8?Q?cpXnRcJ3hVIdwzQpiGANSsGPhmrTYhF2feVnQgYyuQ=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <BC21B9421101624B956EF31B319F836D@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?TS84RVN4cE5zc1N4MVhCSVp6dFZIbmY3RXZRSFVBVWxub1ZKT3E4WVdkTnZK?=
 =?utf-8?B?VUdnYThCZ2wrQ1haNUdwYkt1MFdHaHpqWVd4dmF6NTVsZm80WE9sdVpHVDgw?=
 =?utf-8?B?ZkpId3drV0NzM1NGc0tjeW1kR2ZOTGVYTzBpak1vc3FWVWZONXo3QmljZFZ6?=
 =?utf-8?B?S0JWMnBrL0V5Vk1TYzREOFhTQWJxdHlrOWpkVUZpQkRPMFdyUWJoMlkyQ3Q4?=
 =?utf-8?B?RGZsVXNKZ0QyNDd1UWFHZU52ZTVadDk4T05jV3J4dWZVdEl4ZHFHZ3hhSXNQ?=
 =?utf-8?B?ZnlCUzEyTDgzMEpLSjFPY2dxZ2xmWFI0QmpqM1BheGNEMDBWWjZlWVRGTTdL?=
 =?utf-8?B?WTZlNy9qdk1sOTMwSjZ0VkZlaVkzcUpORVJNemx1UkJMRjhaZWRhMkpoNDBx?=
 =?utf-8?B?dlIwb3BFUkJhdU05OXFQWDJvLzROZXNoNFhicGFoVmFYTUtaMzBuYytVeXk0?=
 =?utf-8?B?VUJSVUh5M0twZnUxRnN0RFk2dUtNaVVBWURSaEl5NzFINjgvejBadjdzUW4z?=
 =?utf-8?B?RGFhVTF5aTFaODFWN3ZuVTZJTzB5R0RnL3JjOS9QMHdVOFFSWHA5K2x5MDFp?=
 =?utf-8?B?UTI5d2JNdGQ3VGpVb3VxK0g0WE1rLzI4U3lLQU8yMGxDYkdSWkQyUmNnMG92?=
 =?utf-8?B?MHMwcnduVktlRWk0UElhZHlxWXN3YkRySjJqZGJtdEhJWFNWM0pRL0RIVXdz?=
 =?utf-8?B?NGtpYTRWNUJkdktsOHJWMXZxWXhlbDFyMzl0VUpkcHhERGZIMDFSQWgrR3Bv?=
 =?utf-8?B?cHpnM0s1MUthTkh1MjFUN3BrOUJjRGFlU0pCWG41cjlKdnVIUmQ0SGJRamJD?=
 =?utf-8?B?MlJ0R082ay9GVnFwMUNHczloUG56T2pFaXhISVI4V1JDN1IvZkt3VUVKeVBQ?=
 =?utf-8?B?eHhocjJVVUtNSVE3bDU2MytBTm9OLzJUdjBxY3Y5dS9JdlkzdUFEbURhdkVQ?=
 =?utf-8?B?akVUcVU0WDJjYkcyV3RpenpWWkNWT1NsMDJtVUZTTlhmVkdzREgyQkppSEpJ?=
 =?utf-8?B?WGRKazlHek1vNE5wTFpkOXUwWmtpeGd0UWpMNHFMRWxkYXpyUWtUd1BGaHJu?=
 =?utf-8?B?UmltZFc1WXZ0aWovaEVqNmhocWZOYm44dFBkcjlzVWJxcEFCZDgzb3VDdHFp?=
 =?utf-8?B?eHBPSmpyYlloMHUzQ2FQdEdSVERnN0hRbTBuYlFvSlBQYkVndVBYNDNHWUVB?=
 =?utf-8?B?QWNvT0lwd2plOFpSdE9SanlwQUUvZzVYS1NXaW9tcXhlRG8wWWxWT2Uxb3dO?=
 =?utf-8?Q?HVKfsccQwbZ2VuG?=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bfcb5c2b-1849-4bbf-52de-08dafd61cc1c
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jan 2023 16:49:30.3784
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CUm/E4xp3NkEx9uxdwG233WOnkJiQe7qYA6/NKLjUpSmG03syqEqen3T0BZEPlFMjW1amYUrJcq/RRYuYp15gCJ1fFrRk47k3aSXWOOu7+w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB4458
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

T24gMjEuMDEuMjMgMDc6NTEsIENocmlzdG9waCBIZWxsd2lnIHdyb3RlOg0KPiAtCWlmIChidHJm
c19jaGVja19kYXRhX2NzdW0oaW5vZGUsIGJiaW8sIGJpb19vZmZzZXQsIGJ2LT5idl9wYWdlLA0K
PiAtCQkJCSAgYnYtPmJ2X29mZnNldCkgPCAwKQ0KPiAtCQlyZXR1cm4gZmFsc2U7DQo+ICsJY3N1
bV9leHBlY3RlZCA9IGJ0cmZzX2NzdW1fcHRyKGZzX2luZm8sIGJiaW8tPmNzdW0sIGJpb19vZmZz
ZXQpOw0KPiArCWlmIChidHJmc19jaGVja19zZWN0b3JfY3N1bShmc19pbmZvLCBidi0+YnZfcGFn
ZSwgYnYtPmJ2X29mZnNldCwgY3N1bSwNCj4gKwkJCQkgICAgY3N1bV9leHBlY3RlZCkpDQo+ICsJ
CWdvdG8gemVyb2l0Ow0KPiAgCXJldHVybiB0cnVlOw0KDQpXZSBjb3VsZCBldmVuIGdvIGFzIGZh
ciBhcyB0aGF0Og0KDQpkaWZmIC0tZ2l0IGEvZnMvYnRyZnMvaW5vZGUuYyBiL2ZzL2J0cmZzL2lu
b2RlLmMNCmluZGV4IGM2MzE2MGNmMTM1ZC4uOWYzODQ1NTFiNzIyIDEwMDY0NA0KLS0tIGEvZnMv
YnRyZnMvaW5vZGUuYw0KKysrIGIvZnMvYnRyZnMvaW5vZGUuYw0KQEAgLTM0NDksMTMgKzM0NDks
NiBAQCBpbnQgYnRyZnNfY2hlY2tfc2VjdG9yX2NzdW0oc3RydWN0IGJ0cmZzX2ZzX2luZm8gKmZz
X2luZm8sIHN0cnVjdCBwYWdlICpwYWdlLA0KICAgICAgICByZXR1cm4gMDsNCiB9DQogDQotc3Rh
dGljIHU4ICpidHJmc19jc3VtX3B0cihjb25zdCBzdHJ1Y3QgYnRyZnNfZnNfaW5mbyAqZnNfaW5m
bywgdTggKmNzdW1zLCB1NjQgb2Zmc2V0KQ0KLXsNCi0gICAgICAgdTY0IG9mZnNldF9pbl9zZWN0
b3JzID0gb2Zmc2V0ID4+IGZzX2luZm8tPnNlY3RvcnNpemVfYml0czsNCi0NCi0gICAgICAgcmV0
dXJuIGNzdW1zICsgb2Zmc2V0X2luX3NlY3RvcnMgKiBmc19pbmZvLT5jc3VtX3NpemU7DQotfQ0K
LQ0KIC8qDQogICogYnRyZnNfZGF0YV9jc3VtX29rIC0gdmVyaWZ5IHRoZSBjaGVja3N1bSBvZiBz
aW5nbGUgZGF0YSBzZWN0b3INCiAgKiBAYmJpbzogICAgICBidHJmc19pb19iaW8gd2hpY2ggY29u
dGFpbnMgdGhlIGNzdW0NCkBAIC0zNDkzLDcgKzM0ODYsOCBAQCBib29sIGJ0cmZzX2RhdGFfY3N1
bV9vayhzdHJ1Y3QgYnRyZnNfYmlvICpiYmlvLCBzdHJ1Y3QgYnRyZnNfZGV2aWNlICpkZXYsDQog
ICAgICAgICAgICAgICAgcmV0dXJuIHRydWU7DQogICAgICAgIH0NCiANCi0gICAgICAgY3N1bV9l
eHBlY3RlZCA9IGJ0cmZzX2NzdW1fcHRyKGZzX2luZm8sIGJiaW8tPmNzdW0sIGJpb19vZmZzZXQp
Ow0KKyAgICAgICBjc3VtX2V4cGVjdGVkID0gYmJpby0+Y3N1bSArIChiaW9fb2Zmc2V0ID4+IGZz
X2luZm8tPnNlY3RvcnNpemVfYml0cykgKg0KKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICBmc19pbmZvLT5jc3VtX3NpemU7DQogICAgICAgIGlmIChidHJmc19jaGVja19zZWN0b3JfY3N1
bShmc19pbmZvLCBidi0+YnZfcGFnZSwgYnYtPmJ2X29mZnNldCwgY3N1bSwNCiAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIGNzdW1fZXhwZWN0ZWQpKQ0KICAgICAgICAgICAgICAg
IGdvdG8gemVyb2l0Ow0KDQpBbnl3YXlzIHRoYXQncyBzcGxpdHRpbmcgaGFpcnMsDQpSZXZpZXdl
ZC1ieTogSm9oYW5uZXMgVGh1bXNoaXJuIDxqb2hhbm5lcy50aHVtc2hpcm5Ad2RjLmNvbT4NCg==

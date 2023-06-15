Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6146A731B38
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jun 2023 16:23:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345062AbjFOOXu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Jun 2023 10:23:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345039AbjFOOXe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Jun 2023 10:23:34 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F4BC2942;
        Thu, 15 Jun 2023 07:23:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1686839006; x=1718375006;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
  b=KddQcT0HttYLfFwPkOWSDB+fSASs8Pnqqln/DqXWAntMRVQKC1pS63iO
   VXO8Clkl7vG9jFiot5GpELbp+iWTijcsPN0VL8AllbTjrKKU1HzJZ8w5H
   5W4IlsrZQEIVqirSFzrJihRTScDZ3LmIzv/q45QaeFlRziM0HGwHfJ4dr
   3wmok60dXcS6R/08CTOXVo9U030FQreSRNvLVr7e3KUfpIGd7wM4sB7oI
   e9+jNeevYCoZGSVegCFtOUylX/joOaEZlLz1Cc11UJKPGSH+bsnLlUkxZ
   K0UonNymXN9jDZOOMrVuq6lwvAE6UsfUfqicDh7xpg1M6kD05w4jzkcmU
   Q==;
X-IronPort-AV: E=Sophos;i="6.00,245,1681142400"; 
   d="scan'208";a="240275575"
Received: from mail-mw2nam10lp2105.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.105])
  by ob1.hgst.iphmx.com with ESMTP; 15 Jun 2023 22:23:22 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c6Leq/6WXr3/hv2Ht+VHpcAUc6FN7cWh6SJo9UncKt4JA9G+f66rtOUdyO5b+Sfq+TVlnOQwKvgZlC49BcExpDt885qCwibzlkpiKeaFy2f7jU+/lCygJn5AQJ/QhyP++F3DwmLMtXPNbFE3j7fhT1TjbhTbrvfhMiMRnc8+Q9ZeEk26l9smJvUZZHrBf+1PfwNNsUu3gama7/3SALLiyR1Yz8WoPKZ0U1fvo308JnjDzPF5eQaWOUX+xJrntFpskS/DviKlrq4vcmePLzGrbzpr+nnxYkVeVPptIdGextaMjTS8+GpqCBE+xH+lddaTAI2nzAKiTMEoYA5oP7KWKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=ZvlXfUwoaesZoDJXi62Rx3vWWyXCl8PVT0RHtHtLJt0kMFbPSwwHCddNxRAVxWQkan0CSWk0b2mlHegFgzw3c6V3gjxUhQoUZ2H2LESCIt/GhQTTyVSBmqnwXSrQaFhTn8cVczPY39lRZ4gfuCNSiIIJsL3hOWnrXOEjAfF0C54nKjtih5L3tjMXyfyzQpPuy5wGkUM9mqLiXsRCDet7xpOKIPt6B450rgYNJ4DGZdeBwmwexqQ9bIgRFTUgwKtF/p8Ud1w+MfNY5X4kCugdvp/iNXj3mnYXA8Ok3VUMd0pdKOG8mFm8yGJVT8++NMcarN1D7ibpzFNP4ox3ta89fQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=HeC//lVxJtPSfrx9jLtWbOCmMRbWrzG2eAt8bQXjnyCR53mBPJko71z8I/dSrZtl76vpoRAAH+98NaDjrZ318V1/18s3q9fc6L8DIuWaJyzLeIic7RnHp1P9QAYxXEq4ci2mtcmZB/uFFmqn5NpJkaH79b/JABWvUWxqZvISo6Y=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by SJ0PR04MB7615.namprd04.prod.outlook.com (2603:10b6:a03:32b::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.25; Thu, 15 Jun
 2023 14:23:18 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::23cf:dbe4:375c:9936]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::23cf:dbe4:375c:9936%6]) with mapi id 15.20.6477.037; Thu, 15 Jun 2023
 14:23:18 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Christoph Hellwig <hch@lst.de>, Song Liu <song@kernel.org>
CC:     "linux-raid@vger.kernel.org" <linux-raid@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH 02/11] md-bitmap: initialize variables at declaration time
 in md_bitmap_file_unmap
Thread-Topic: [PATCH 02/11] md-bitmap: initialize variables at declaration
 time in md_bitmap_file_unmap
Thread-Index: AQHZn1W8+ZcIctv87EqE5sjvcTUFq6+L6y+A
Date:   Thu, 15 Jun 2023 14:23:18 +0000
Message-ID: <96fbf8d5-32f4-8a15-556d-c24df063101f@wdc.com>
References: <20230615064840.629492-1-hch@lst.de>
 <20230615064840.629492-3-hch@lst.de>
In-Reply-To: <20230615064840.629492-3-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.2
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|SJ0PR04MB7615:EE_
x-ms-office365-filtering-correlation-id: 72b75e17-db46-40b4-f6de-08db6dac108e
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /R7rWMGDW3quupKQJoQczapQm92eCZQrsmcWSpq2o/U92YVMN5q/7CLQ+LgIR6KBW8pVlR67W8ZsuzzCExSILCMv5PyN5s5aVnrkA0KQkAQu905KfRitQYAiw8MYTx6MvW9rezdJgN2HYVP7kweoYFecjoZPIgY8jo8uLwZESI8VRog791qjOPdiNX138Hb802XHCN903zNAKKIjOfgelHrdYki3opDhcyUKJrjTz3OxPpBZNP5Tq0gcakHKK76oNNiUq8/bnWaJzCMRdpnVoMfzL2yiYuYVY2bAyA2hMJGl2wfjOJw7F/YGyCS3iHCexfU+51FYYYTVTDXq3hv4Z5raMOwWBDZgrhXV/Gyv10Zsi613of/7uVUkjt2iUmmRk+/R5P4g7+ZKyxxHTLsHUuSoH3trG6+id71ZH0Cn1xbp1kH0qsSXpLhGYHXjwobYN0s992zRTmrl11rOZw+hCNhcVSsRxs/wuFk/furNW0M+C4v0CJUUJLf60rsSgn8iro7qd12RqDa99Me6Db3f8DyBtayMmoyEqdmkm8ZkZexz01VQ3PJlWx9g/vKHuPr+RlomNjxpww7eyKFJz64aapqcnTMELyeGnhdh+B0Y2sS646F1LRU5X5g9XOACM29lfvrl0S+mncE6ABSwt6cUrZlovNMtdQpyb2vIl+nf7PSsUUFQyouSbX4pxCmP5TaN
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(376002)(136003)(346002)(366004)(396003)(451199021)(2906002)(19618925003)(2616005)(36756003)(558084003)(86362001)(38070700005)(31696002)(38100700002)(122000001)(82960400001)(54906003)(8936002)(8676002)(6486002)(316002)(41300700001)(5660300002)(478600001)(31686004)(110136005)(66946007)(66556008)(76116006)(66476007)(91956017)(64756008)(66446008)(71200400001)(4326008)(26005)(6512007)(6506007)(4270600006)(186003)(43740500002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dDRXRXZoYSs5eFpVL2ZxS2tPT3hHVnNmWlBFRWxKRFYvUWtoYjlXOFVyM3Zh?=
 =?utf-8?B?WmVSU2sxUjVMUWlUQVNNR0c2VWoxMEFhMi9XSE5tUTVva0FvdHVjWVg0cTJN?=
 =?utf-8?B?ZWpjaElVTVhraVBMY04wSUMwdDBtaThwbWRyWlA3d0MxY3lQSmxLWDNZMnFz?=
 =?utf-8?B?eUtlQ0xxVGdmWWlua3JGZzRIdGlBdjBTRmxMZDdZS3BCbjBpYm8xenFWeVVm?=
 =?utf-8?B?dVF2alZHNWJTemk2UVd6ZEUwWWl2UklxYVo1Mnh4TDE2MzhCWmxVUEZoSEFR?=
 =?utf-8?B?aFpSU1lXNTFKZk1CVi9yN05laElYeTNwRjI1MFVOVDVKSjFsQnd0OG9NdTB2?=
 =?utf-8?B?bFhGWWRoR3ZZMnc5QXI4SGhPQkx2Nm1pUityeHlCT01SQ05zcXJidTlqbENj?=
 =?utf-8?B?bm1EOFBKdWZaT1lMYXlzeUovVi9BWkYvZlIyakxTSGJ2a3dKdmlsUXVqUmkz?=
 =?utf-8?B?SXMvalY1Z3ZTYXZZMnhFV21PSW9QNmR1WE1CYWlxZW9neXBHVDdlbGNMWkYy?=
 =?utf-8?B?SGNZVWVXMnVqQnpRc08vdkVxd1R1TWROQzBLZW9nMGZVbXZnbmFNL1VvMjZZ?=
 =?utf-8?B?ajBHZmo0UmZEMWV4R3dRTFRvaVV0VExjZUdmdFFTajloVTB5YVZBVXREVHdJ?=
 =?utf-8?B?eVllZjZ0M1ErcnhpM2FRQkQzZ3NpaFdFdUcvMGlpbWh4K0lDWWNWVHI2TE5L?=
 =?utf-8?B?RnBIVUFIc1NqMW5yUzQzY3RQc054NEJIZTBsTy8ydkpXdTRxZ0VmMEZudUZ1?=
 =?utf-8?B?eERPVUpJTkFDN29TZ1REajBqN2t5TG9jM2tmQ0x5bFkvcitGVlorSVVoWjgy?=
 =?utf-8?B?dlB2TG15dTJtSDBDNU4rdGJvZlFRZkVobEVMaTlHOEVwWUh2NWdQSUFHQ2JI?=
 =?utf-8?B?TmRkRVVPTmYwZi9rdkJuVkdWOTQ3anJaUmR1WndwQmZKZEE4ZlgxekNlbHc5?=
 =?utf-8?B?ZC9GVm9IL0JCS1huQW9pK05tdDFWcmoxQkdRdzFScjlhK0p4T1YxR213c01s?=
 =?utf-8?B?L1Y3U1FIclFiUVR6WTlmSXVleDRoT0ozV0NpM1RrME1adlVtOWpvWnVGa2pa?=
 =?utf-8?B?NzNHdGVtN1F5NkhJK2U1ekdHSEtnVXk0U2hCMEIxYTRHb0RTbWRZOEk0dUpT?=
 =?utf-8?B?Nm9lRmZXT1ZjM3VObG5vYVJpR2VzRG1IcnEvVFoxR0NxbXVWd1kwV0lTbVpG?=
 =?utf-8?B?TnpybndZV3pTa1BUTjh1L1NVelJXTXJXZzhkcGNQQ0xVZlB0NTBJeTFjTG9C?=
 =?utf-8?B?eGZXcGd1aGtld2NIWERJVGljMXZtMm9HTEFIcjh6WG1FSlh0OVhndFp2TThM?=
 =?utf-8?B?cjQ2SkpiZGQ2UE9EcHNpbDI1N2xZMHhmeDlXSGdpdkpOVGg4OFFIQ0NqK2NK?=
 =?utf-8?B?Q1hub1NVT1hEK0c3Y21IZXAyaHdoWmw1UEsrdVpiZkxJdk1aTEFIeFVQUnJm?=
 =?utf-8?B?SDVLYTVGdTZDTUJtak1kN0JpVnllQm9YRFBXVk1MUVZHZHNJUVVzdS92bkE0?=
 =?utf-8?B?ODc3U2dpSUFJYXhmZ3g1djQ0U0pwVnF0NEVPREVhZmszRVBodnBIRlpIOUMw?=
 =?utf-8?B?UkJaR2JIMCszTDZxSllESEdTaS8yTlJkS1ZCQTJqWElMMC96RVVCVWtoSk1C?=
 =?utf-8?B?cllGWFBLOWlXREFIclpjR0x6c2s2UHZWdXc4NktXK09JWTRSQ2pZcVhLS3Yw?=
 =?utf-8?B?TzYwbEU2a1JZL1Fab1owNHM0aEFPelduN2g0RkZkdWxyY1dUYklaMWgwQVpS?=
 =?utf-8?B?WEh4cDNYNU82T1ovZjQ4R2NDaUl4d2xMVVozd3drVnBBdmg5MFpVWUpXajhX?=
 =?utf-8?B?UkRyQVRNWlNNVXNsbGlYZXdWL1hPK1VQRUNxdzJQMDlVTm9zVFMxSkUwTE9T?=
 =?utf-8?B?S2NreFlNa1VMbTRISDZhNm9heWhyYXNjYjlod3JNNWF1YWIrYkROU3lLQUxr?=
 =?utf-8?B?enovNWR6VC9kS0NGVlFzQVRHMTBmY1Q0Vnh0OHJpNHIyZUZVb25oS1pzK0M3?=
 =?utf-8?B?VmR4UC9uZlM1aytYVTlSdDgrZGtZam1xNFB5dE1JSisvOFJsU2lIN1hSNFdJ?=
 =?utf-8?B?MmJxQzJlV3FEMFJodjBYTlA0RkcxcE14SXVUcEpRMm5NZDN1NWFnUkJoc3pR?=
 =?utf-8?B?Vm0zM2VNQ2pETEdSVWFxbkZzR050SXdFOWo5UmF4VzR0RTR0R0plVzNKZXY2?=
 =?utf-8?B?MUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6B9ADC3EF2EF154FA62B359AFB500409@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: BzRXEYA/0raxtg0TCr+YuWCWBIGIDED8wNbnWB/Dse+Ki3lAe1LNMkC92OoVF16K8EwVwYSM79royzsvJ+ASvhXRvYgPt1rOiGwNKfdy4ebGH2hMQswMld+2sXpVYzOSwyUoBUbsQTeWL5eic8pr47/G+y3jDeBaCTQ1eJLqZohsiInI6dKiHi4wQzCZ5vfOKNWndd5OrCtgtOHncf8D8MBv33kCCd5g/pAc26Eeg8Cz8cFYcbJTE6h4BvdBH9H3cwDuCUyO8CjqF8ssvDiXvvphjGT/yKtXEkwXrYWo2jWzJ6MT/U4rwb5G4oPhVFWkWw4rg8Esx98aixk+iE9i87o+YRiI36tXC6mXvaJoevr8+SCEGP4cNt6EBvzaJA38HRaF1P7NFcvVEwOlIxMYRxYPQ42aqy3tOIfxARFwD6p7KqPN00qq+0DL7+WXmBDpuVmSpDwXKRJUWuwVqJUqE8lhaWLUN8dUU5gTb8JYXfMCGv4dUgzS0U6nsmZqarYIU20YPMRJjPGujjnzjm7U3t70kJcpSBrxxIfMvgeZ+xK2WfutR2zvvnn22NSdzg3xWK1cDxvz4g9BmyKiO8wYzE2unnYlRzTW6YDsV7RU19OlWYz7L8vt6R4r1FH2kry2f4Yp3fL0b7+b5DdFigs3N7FR23D35Vwpn6/BOWM0S+MpC6zOV+vKtWM9I4ree2rzGAsxwQja2EyV5Sf82rv0NgLbk9KzY9t9dGFy1gHy/gK90JA/XaiOM685VbLrqzuKHdG+G30CJ+GELjUpulm6bvX1aun4UmRhrB3j5YRRlACW3KQ5E+WZsRUqmP7ZS6bDXqrKqgXYuFJBqT32/itShQ==
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72b75e17-db46-40b4-f6de-08db6dac108e
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jun 2023 14:23:18.2647
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EuzOMstjKxmrpr5jKSpUi77VAG+t2szurx4eWorg2PLp3dGz4YwsGJmayD3/U4CE38o3zEf703PC6uY4hrWRZo9Yp1Gn3vLwuPCcwPNn5gU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB7615
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

TG9va3MgZ29vZCwNClJldmlld2VkLWJ5OiBKb2hhbm5lcyBUaHVtc2hpcm4gPGpvaGFubmVzLnRo
dW1zaGlybkB3ZGMuY29tPg0K

Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE1D563CC23
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Nov 2022 01:05:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230434AbiK3AFK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 29 Nov 2022 19:05:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbiK3AFI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 29 Nov 2022 19:05:08 -0500
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2062e.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe59::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDCD57044D;
        Tue, 29 Nov 2022 16:05:05 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JLKR206+2zhTSOjKwXRkOfvXOZJ9yD2BEEFJa+eAJOFAhJWz8kdIxexSMucsVwkoOdKAVUIFlBc7Gk8JvdJsNSuzJVAC+dhNAyV7Pif/EpwNZyYOeoz+o+Tvn3OPjn7R+8yD6vuV9bh6WknGchyL2oQnReBo/2Zd5VzSwy2m20Cwmi/QwW4Pfv5aTqQAmzcNXhGKuhjcgnQ87HowfPE/ySPcXKjsNX8We4RKQ7W1NkjX8hORUlJr2QEC5c1ckwSuyb/r/y8+haCt3ApzRK4ZJwlqdHBA+uCiaTRO4ojDfenqfx46UnwiJ5b4AhfpLlk6z3JvIE/cuEo0svNWJmRUaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xhL+aY4Nq4lu8FXriehm5cU8EkT3FJVMAK6FJyYXfIU=;
 b=k9h4hPHzQmUH1umn3o85HMvsnddtsA64Q8jA7cDCA6KGphwncXBBbBTpu+VNbOJX/zc/9U34DL3CZsIHtCia0/VtXnw3JU8+64hwrywKqyCvQBg8m8L/k6DtntNW49avQs4xkf5M0c8B1lBq0JN1b2dIOgIy62qr4IGDKXYCpkza/T2ZCqluvIl11Hu6Al4OIGfaZyAQ1uI04T29F0K+jusxer8TzFu/X7eFPc/RTMtfCBW0kAUwofhxyHhHTLkpOaclHCgpfjRvLwXwqYypst44XtXHCHmxmn72LIyubK2kktpufhdW4vUV09nVdypI5XKCOXCEiW0nYk9GGUQk0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xhL+aY4Nq4lu8FXriehm5cU8EkT3FJVMAK6FJyYXfIU=;
 b=rZ+8DVhcf5Y0ZcwuLW9nos7I8AF0WHkg5a2onpvCGAPuH2MDgkIyHisE1UD00Tga2XTPCKvzuQCdiBD3Rht1rlK7R7cb9q4K6ELLGGcOCrnKb7W0ag702XQe+/cfFa2wb9OPfHON65a10kYow4oVYmb+rm/c4uNWBeWoTpL8M8glm55d3p9f4Gm5HJ0bfwKX0i4Av12MTftdNqQrfMxMjBRiUAbhlfFiTwIBvV8sljjZkJj3PnwvMx6+/nLCDsV+pefKGFxKhYb8bCNJDdAYjyLn17jUHQ0bO6DmNQcgnYbiulXSoLCdaeO21J2dnRYvAMIYx4wdMyBUwEyGlv5CIw==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by SN7PR12MB6888.namprd12.prod.outlook.com (2603:10b6:806:260::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.23; Wed, 30 Nov
 2022 00:05:01 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::f02:bf13:2f64:43bc]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::f02:bf13:2f64:43bc%7]) with mapi id 15.20.5857.023; Wed, 30 Nov 2022
 00:05:01 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Nitesh Shetty <nj.shetty@samsung.com>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "agk@redhat.com" <agk@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "sagi@grimberg.me" <sagi@grimberg.me>,
        "anuj20.g@samsung.com" <anuj20.g@samsung.com>,
        "joshi.k@samsung.com" <joshi.k@samsung.com>,
        "p.raghav@samsung.com" <p.raghav@samsung.com>,
        "naohiro.aota@wdc.com" <naohiro.aota@wdc.com>,
        "damien.lemoal@opensource.wdc.com" <damien.lemoal@opensource.wdc.com>,
        "snitzer@kernel.org" <snitzer@kernel.org>,
        "kbusch@kernel.org" <kbusch@kernel.org>,
        "jth@kernel.org" <jth@kernel.org>,
        "nitheshshetty@gmail.com" <nitheshshetty@gmail.com>,
        "james.smart@broadcom.com" <james.smart@broadcom.com>,
        "gost.dev@samsung.com" <gost.dev@samsung.com>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>,
        "hch@lst.de" <hch@lst.de>,
        "shinichiro.kawasaki@wdc.com" <shinichiro.kawasaki@wdc.com>
Subject: Re: [PATCH v5 00/10] Implement copy offload support
Thread-Topic: [PATCH v5 00/10] Implement copy offload support
Thread-Index: AQHY/wLEUhEocurOikWuV2dsph+j+a5NH5cAgAi7OwCAAMXvAA==
Date:   Wed, 30 Nov 2022 00:05:00 +0000
Message-ID: <a7b0b049-7517-bc68-26ac-b896aaf5342e@nvidia.com>
References: <CGME20221123061010epcas5p21cef9d23e4362b01f2b19d1117e1cdf5@epcas5p2.samsung.com>
 <20221123055827.26996-1-nj.shetty@samsung.com>
 <cd772b6c-90ae-f2d1-b71c-5d43f10891bf@nvidia.com>
 <20221129121634.GB16802@test-zns>
In-Reply-To: <20221129121634.GB16802@test-zns>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW2PR12MB4667:EE_|SN7PR12MB6888:EE_
x-ms-office365-filtering-correlation-id: 616bbd5a-214d-46ae-2d62-08dad2668674
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3FnlmPXME3oMTZeBJ9XQni9kLGFc/0E+gZ52gK1btth5L9afAMIqssPBoOvN/zlUpu/apg//Pi9BBCJ6TY04yEgXTCGU5nMNL5MO0j8gZDW7VN1Vv2z45HYtFGdc8fNbWpWPebk+Ev/F/IaoGMTtC57otFw2QFqpSa+xs5fgIlsRFE1bcCd+GenzbC5A9bklKvGZYHeFapRweazg7pv6HL+TcmXsOU5Szh9CnnmkvUq7vm1Sxv81M4X09LJZr6gTV41igNqiH5KQnTR89xD4Kc71Rb2H5lCLkCbyoCOLJRiPOdmBl4PQ6YYOfTYSrqRE+ge2pSzt+qwSXYk2Mulwqf400pI8IHVbefNxX/G0rNOD1PhR9fz1utBSIgVsXzxD+Yr9cz186T6Df6x+/zMH2qMf21f6UhABv9szYFardQVtglhaWwhVzdXGQ4SWYxkvwT+A6Y9L5lKa5i3JLCKDRHlY2W6Gm9jNzj2NkMDNRUvW9rACXehSPABO3vYfsuUBCyIe7HeZSsmj4VE5sU9Knb7D6hLxPPOUDKn4Vv08Oue/zHCO5nxmlJG7Ve+2OMsyuv2bJv3sWbGkmZ9oRJQAssbwqj62CsQm3xWKrGkC4eEp+BZ9DlFXs6QSeZ832wRHntZfv20emYYyYvZZK38HMyhNV7wZmQIVVSUkTYwuvLAXGjZd3MfDYfOFeTOW7GZ6sD+IPOW08okPUkaYLiIXpQGIKln3gzD5v5W+vurof4EjJg+M5FDsBFc3bOdfIgNpz/EIoXvR7cNY61NfAogQYQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(346002)(366004)(376002)(39860400002)(136003)(451199015)(83380400001)(54906003)(86362001)(31696002)(38070700005)(2906002)(38100700002)(66946007)(7416002)(41300700001)(66476007)(8936002)(5660300002)(186003)(53546011)(4326008)(6506007)(6512007)(2616005)(66446008)(122000001)(316002)(6916009)(91956017)(76116006)(6486002)(8676002)(478600001)(66556008)(71200400001)(64756008)(36756003)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VUFSMDF0T2xsVXUyOEM0Y0xJT3FzMk1kaE0rMnVsNmpyL2lrY1F1MUd0Y1px?=
 =?utf-8?B?Mm9kMkROcFBpbzJPbzUwSHNxUFRudGhGazhaVUpZU1lrT01iS3JIaFhabllp?=
 =?utf-8?B?MFB6K013UVZ6NnRTTTkyT0Q0anpNVUh6TE0ySVpYQXNxR2d0a2RqbWpQMm93?=
 =?utf-8?B?SmlwVER3OXpJdjFIaC9ZRTBBQnIvREloTjJGNDJ2VnRsaHFlOXVQRSttVEdj?=
 =?utf-8?B?YWhLbWNwcXhSN2hzV1JJdVdjKy9aRTQra1VCaERoRktpcytENVd1YnN1N0xS?=
 =?utf-8?B?dmEyR0lsQmI4L294and1VFBjTUQxeTVObDR0dnVtTHNSakZUV1hVcFhpMkxq?=
 =?utf-8?B?MmlWT2ZXQlh4dUJtUUh0TzNtLzh3WWJIZjhyOWI2Q0FLQkpXS1dIR0srcDJa?=
 =?utf-8?B?OWxsNnVJRGNCWnpiWlVuN294K3VBTEVaRUt1NGdtNkZCYTJDbFBkUHZFREM3?=
 =?utf-8?B?b0ZVTnk3azZRMmppY0xqOWN6SVEwd3R6K3dBcjdod3FMU2czQW9pajcrSE5r?=
 =?utf-8?B?MnNWQjhmMExYLzh6YnFvRzUrT1FsUHdEUjNTdzY5VGs5NVdiWkNWM2E0Vkpo?=
 =?utf-8?B?UXEyS0xJaVZjSkxDWlRnR3FsQ3h6S24wRFFmQWVnRXlLYkV6VXhEeDlBbyt2?=
 =?utf-8?B?N3BYZEI2OEJLNFpaSjJwWFhSbmhEV0hkT01uRGJSeFY0MElXcU5WdytnNWhF?=
 =?utf-8?B?QXl6bXFkWldhU2lhWS9ya1hXMHJVZEdOdDlQYS9rR2wyOTArMkNnN21EWDJ4?=
 =?utf-8?B?Y1k5V1JRclVCckVUWk4rVTBVeGZLdXhHZkhqY2djT2lXdm5kRUc1RGVUdkIr?=
 =?utf-8?B?eTJZSVo4SmdXRDBtM2s1TWNvcFE1ZE9wL0dxZC9GWUpNaFkvMHNzcFZpZlVu?=
 =?utf-8?B?YWkyMUdINVBvQS8yMTl1dXJKU1h2cDNWTTFEajBEN3owMVpZdnJsOWhNQ2Yx?=
 =?utf-8?B?MzExaU9BUmJjZzFEZVZJYktzdnpxNFEyM2hKM1g4aDJEQndaQnQ5MGhBdGN4?=
 =?utf-8?B?NEg0R3phVnB0Q1Z5S1hMb09iY2NTMXNCYjVPSWFBQlZuaW9FOHkyQTloU09t?=
 =?utf-8?B?VHpSNUE1QTBGeDFENG43emlwNzUya0IrTjFjVytzbmhuVVIzN1FUWGQ3YTEx?=
 =?utf-8?B?YUdXSjk4bmt3UFVuYkIzb0w0bEVCQjRIYlp6RnYvNmVsOHNQVmppeDdyV2FQ?=
 =?utf-8?B?MDB4RCs3NWFobi83MXFNVVRzaGFSay8xWUdxVVJEbExMbHdzRXpZc1pmY3Mx?=
 =?utf-8?B?S0JYQWFXY1Q0V0V1S0RxUUZreFNuTkZJWlhsODByajlmQjdITlNVcVVIakcv?=
 =?utf-8?B?aE1YV1hTTElTRnlMWGZRQ0hXYlhaMXFvaHppTHdVeGRtUE96dHR5UjNZZW9D?=
 =?utf-8?B?Q2VQU1F5R2IyWlN2MjdhUmRMemhjci9oY2tWeHlzbTFnQjl6RjRheUpQWVVW?=
 =?utf-8?B?aFRuZUIxMVZ3NVhmbmlZQ3VMaDY0Q3d1a2x3OGdEaXB3Q0JXeXFSNGZVS3Nk?=
 =?utf-8?B?ZmV2OWV6ZlkzK09zZXRhTVU3aENMK3NFeVFqSThOek44NExXaW1sZ0hxUDlt?=
 =?utf-8?B?NlBSd0l0WGs3WDcySU5keWs3dVBuQkJubFJGMWJLVjZadTJyenhMOGpGR0U2?=
 =?utf-8?B?aHh3RVNLQmRvZVhTaE9jN3d6UnhTdGRJMXRjSnJkcXhwakJSMnEza1FxZ2VR?=
 =?utf-8?B?am9nRmdnY0VxRy85aHdkQ0ZqMEVNQTlXRlIzUlNVZk1aUjkzcS9CVURQSTls?=
 =?utf-8?B?OEN6KzFDMXYrQzM5Q1BvWkM3TFdmUE5Ic3ZVOStZQWkvVW95Sk9ZblRROEh5?=
 =?utf-8?B?WjlwWkw2UUY0bUtsM2JsUUdoWktybWlLUTVqVlIyVFJoT3QveXFnQnRCa1g5?=
 =?utf-8?B?REliVDN3YmxBK25VNTNoTTNUNkQwcy9PZkZDclpHSG9NRVRCeGp1MEs5a3Zr?=
 =?utf-8?B?NXVyNHpnWVI1TFNQckF0NnBVUXIwMTg2NTF5aGtTOHVmcCtzMjRWUmZ6RE4v?=
 =?utf-8?B?RmhXQ2w4R3p3ZzkxVmhOV3ZiQ0owL3hoeERONW1FSGtuNmNYRUN0SDVlc2ZP?=
 =?utf-8?B?b3h2V214enNvWjRKRlI0ZFoxTGN4VlZLWVRhR2hjaXd2aC8wSGhSNUtBSG9H?=
 =?utf-8?B?MnR5ak9ZYnR2SS9oSWZiSWdIeENrN2IxM2gyZXJQa09hNVlCZC9yREMyK0Ir?=
 =?utf-8?Q?gxVWHCsNdidGDu7XdIZCs8tiB9v0CMT6KvlLp1LB5sPL?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C7D76B178A2A5C4B83085D5EBD91E1B0@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 616bbd5a-214d-46ae-2d62-08dad2668674
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Nov 2022 00:05:00.9979
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FaDO6UBIVs/cLtT7BNu/nEs/4tf8Wf6bPbhv7Xttv1o0Ok1wvApPX9kwhBr7ZCCfICLfhtg7gkAWemShJVA9ng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6888
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,SPF_HELO_PASS,SPF_NONE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

T24gMTEvMjkvMjIgMDQ6MTYsIE5pdGVzaCBTaGV0dHkgd3JvdGU6DQo+IE9uIFdlZCwgTm92IDIz
LCAyMDIyIGF0IDEwOjU2OjIzUE0gKzAwMDAsIENoYWl0YW55YSBLdWxrYXJuaSB3cm90ZToNCj4+
ICgrIFNoaW5pY2hpcm8pDQo+Pg0KPj4gT24gMTEvMjIvMjIgMjE6NTgsIE5pdGVzaCBTaGV0dHkg
d3JvdGU6DQo+Pj4gVGhlIHBhdGNoIHNlcmllcyBjb3ZlcnMgdGhlIHBvaW50cyBkaXNjdXNzZWQg
aW4gTm92ZW1iZXIgMjAyMSB2aXJ0dWFsDQo+Pj4gY2FsbCBbTFNGL01NL0JGUCBUT1BJQ10gU3Rv
cmFnZTogQ29weSBPZmZsb2FkIFswXS4NCj4+PiBXZSBoYXZlIGNvdmVyZWQgdGhlIGluaXRpYWwg
YWdyZWVkIHJlcXVpcmVtZW50cyBpbiB0aGlzIHBhdGNoc2V0IGFuZA0KPj4+IGZ1cnRoZXIgYWRk
aXRpb25hbCBmZWF0dXJlcyBzdWdnZXN0ZWQgYnkgY29tbXVuaXR5Lg0KPj4+IFBhdGNoc2V0IGJv
cnJvd3MgTWlrdWxhcydzIHRva2VuIGJhc2VkIGFwcHJvYWNoIGZvciAyIGJkZXYNCj4+PiBpbXBs
ZW1lbnRhdGlvbi4NCj4+Pg0KPj4+IFRoaXMgaXMgb24gdG9wIG9mIG91ciBwcmV2aW91cyBwYXRj
aHNldCB2NFsxXS4NCj4+DQo+PiBOb3cgdGhhdCBzZXJpZXMgaXMgY29udmVyZ2luZywgc2luY2Ug
cGF0Y2gtc2VyaWVzIHRvdWNoZXMNCj4+IGRyaXZlcnMgYW5kIGtleSBjb21wb25lbnRzIGluIHRo
ZSBibG9jayBsYXllciB5b3UgbmVlZCBhY2NvbXBhbnkNCj4+IHRoZSBwYXRjaC1zZXJpZXMgd2l0
aCB0aGUgYmxrdGVzdHMgdG8gY292ZXIgdGhlIGNvcm5lciBjYXNlcyBpbiB0aGUNCj4+IGRyaXZl
cnMgd2hpY2ggc3VwcG9ydHMgdGhpcyBvcGVyYXRpb25zLCBhcyBJIG1lbnRpb25lZCB0aGlzIGlu
IHRoZQ0KPj4gY2FsbCBsYXN0IHllYXIuLi4uDQo+Pg0KPj4gSWYgeW91IG5lZWQgYW55IGhlbHAg
d2l0aCB0aGF0IGZlZWwgZnJlZSB0byBzZW5kIGFuIGVtYWlsIHRvIGxpbnV4LWJsb2NrDQo+PiBh
bmQgQ0MgbWUgb3IgU2hpbmljaGlybyAoYWRkZWQgaW4gQ0MgKS4uLg0KPj4NCj4+IC1jaw0KPj4N
Cj4gDQo+IFllcyBhbnkgaGVscCB3b3VsZCBiZSBhcHByZWNpYXRlZC4gSSBhbSBub3QgZmFtaWxp
YXIgd2l0aCBibGt0ZXN0DQo+IGRldmVsb3BtZW50L3Rlc3RpbmcgY3ljbGUuIERvIHdlIG5lZWQg
YWRkIGJsa3Rlc3RzIGFsb25nIHdpdGggcGF0Y2gNCj4gc2VyaWVzIG9yIGRvIHdlIG5lZWQgdG8g
YWRkIGFmdGVyIHBhdGNoIHNlcmllcyBnZXRzIG1lcmdlZCh0byBiZSBtZXJnZWQpPw0KPiANCj4g
VGhhbmtzDQo+IE5pdGVzaA0KPiANCj4gDQoNCndlIGhhdmUgbWFueSB0ZXN0Y2FzZXMgeW91IGNh
biByZWZlciB0byBhcyBhbiBleGFtcGxlLg0KWW91ciBjb3Zlci1sZXR0ZXIgbWVudGlvbnMgdGhh
dCB5b3UgaGF2ZSB0ZXN0ZWQgdGhpcyBjb2RlLCBqdXN0IG1vdmUNCmFsbCB0aGUgdGVzdGNhc2Vz
IHRvIHRoZSBibGt0ZXN0cy4NCg0KTW9yZSBpbXBvcnRhbnRseSBmb3IgYSBmZWF0dXJlIGxpa2Ug
dGhpcyB5b3Ugc2hvdWxkIGJlIHByb3ZpZGluZw0Kb3V0c3RhbmRpbmcgdGVzdGNhc2VzIGluIHlv
dXIgZ2l0aHViIHRyZWUgd2hlbiB5b3UgcG9zdCB0aGUNCnNlcmllcywgaXQgc2hvdWxkIGNvdmVy
IGNyaXRpY2FsIHBhcnRzIG9mIHRoZSBibG9jayBsYXllciBhbmQNCmRyaXZlcnMgaW4gcXVlc3Rp
b24uDQoNClRoZSBvYmplY3RpdmUgaGVyZSBpcyB0byBoYXZlIGJsa3Rlc3RzIHVwZGF0ZWQgd2hl
biB0aGUgY29kZQ0KaXMgdXBzdHJlYW0gc28gYWxsIHRoZSBkaXN0cm9zIGNhbiB0ZXN0IHRoZSBj
b2RlIGZyb20NCnVwc3RyZWFtIGJsa3Rlc3QgcmVwby4gWW91IGNhbiByZWZlciB0byB3aGF0IHdl
IGhhdmUgZG9uZSBpdA0KZm9yIE5WTWVPRiBpbi1iYW5kIGF1dGhlbnRpY2F0aW9uIChUaGFua3Mg
dG8gSGFubmVzIGFuZCBTYWdpDQppbiBsaW51eC1udm1lIGVtYWlsLWFyY2hpdmVzLg0KDQotY2sN
Cg0K

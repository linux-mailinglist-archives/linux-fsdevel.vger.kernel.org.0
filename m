Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B1B16C695B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Mar 2023 14:18:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231334AbjCWNS1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 Mar 2023 09:18:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230259AbjCWNSZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 Mar 2023 09:18:25 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2068.outbound.protection.outlook.com [40.107.243.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7157B10E0
        for <linux-fsdevel@vger.kernel.org>; Thu, 23 Mar 2023 06:18:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gYTTOzjhLzjIg7RlrLIWayl6i+rHG5XBaFI3co4ReK39+Vds1cVbY1QoQSaSIWx/k9fUof8jkV3ztdf1Qw5pjvRPhi5YTdNQQmozNGYf1jnTcJhdYHrIBmldgdLarlpuJoIst6NmJbF4FuUfFCjbeLUSCyTfvzv8vy5u8UkGJSe9TYc370G3RItEV3H2S9BIAqDiUZIQCfLFzhURRn2sI0Ve9qFgAP/0g6RMfgrZe3xdOD5v71uzIaSJwLLt2TOtBm3zRilKKbpcV4tlnS/CX91XX/S/p+Mc00FMeZWGWTbeICgaF/STS5LFMopAPC8Quf1LsS4V3H2YErAR9PPG0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dywJP3BLsp6/5STcP3HnjLLKV3o6QC4AYEUW108gW6U=;
 b=gLhBAMAec8viAqXN17w7UmSfmPNYIY/JrEpYb4L6ZaQjI65QsoAUUOgAAJfqrb55zyjIsGVBn5vt0r3ZTW1S+64i4lFl2hkfcCw6e6Aggi1ry5xzzcCk3aRQKmN029jsqa1hW1ZwpSt9h1+GLkE3Gtz8y6GVw8ME0asxcuDD9MfKL2BxxH7wiI+VLyfRGDcqYkazRAtkMcbM8KooDLhFF/EZtNb8CTfX8n6erB6oW5ACfymnApZbaqr8s+Oo81cB5hIaFNRqRR+8n6x3Ge9AF1eCYUFmIygnj4EkHDAQo+JqTEUzlFzCPM4ip+6sp6SgF9RgKLFsweWe/3c2xG973w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ddn.com; dmarc=pass action=none header.from=ddn.com; dkim=pass
 header.d=ddn.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ddn.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dywJP3BLsp6/5STcP3HnjLLKV3o6QC4AYEUW108gW6U=;
 b=T5N9rWbzvULX6a4UZiuiw4fwLHfa+upNhQ7v2E5rT2V8KF+Pd2Gb2mQsO3oaVR4EOo4hKg6rQ0yf7REdBZq+cCYtJclBx7sTd7ds5H/+kkI5zpdzcdWewgueBbYfYl4ng024u7jUteGSAJbigsWQqKgHSqn0NyuuQcK9vbRug/M=
Received: from DM5PR1901MB2037.namprd19.prod.outlook.com (2603:10b6:4:aa::29)
 by MN0PR19MB5804.namprd19.prod.outlook.com (2603:10b6:208:37b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.24; Thu, 23 Mar
 2023 13:18:21 +0000
Received: from DM5PR1901MB2037.namprd19.prod.outlook.com
 ([fe80::e6d4:29f7:2077:bd69]) by DM5PR1901MB2037.namprd19.prod.outlook.com
 ([fe80::e6d4:29f7:2077:bd69%4]) with mapi id 15.20.6086.024; Thu, 23 Mar 2023
 13:18:21 +0000
From:   Bernd Schubert <bschubert@ddn.com>
To:     Miklos Szeredi <miklos@szeredi.hu>
CC:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Dharmendra Singh <dsingh@ddn.com>,
        Amir Goldstein <amir73il@gmail.com>,
        "fuse-devel@lists.sourceforge.net" <fuse-devel@lists.sourceforge.net>,
        Ming Lei <ming.lei@redhat.com>,
        Aleksandr Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
Subject: Re: [PATCH 06/13] fuse: Add an interval ring stop worker/monitor
Thread-Topic: [PATCH 06/13] fuse: Add an interval ring stop worker/monitor
Thread-Index: AQHZW5INP1WhR4AlW0WGDgYwsBdWma8ILRSAgAAKLQCAABl7AIAAC/8A
Date:   Thu, 23 Mar 2023 13:18:21 +0000
Message-ID: <e0febe95-6d35-636d-1668-84ef16b87370@ddn.com>
References: <20230321011047.3425786-1-bschubert@ddn.com>
 <20230321011047.3425786-7-bschubert@ddn.com>
 <CAJfpegs6z6pvepUx=3zfAYqisumri=2N-_A-nsYHQd62AQRahA@mail.gmail.com>
 <28a74cb4-57fe-0b21-8663-0668bf55d283@ddn.com>
 <CAJfpeguvCNUEbcy6VQzVJeNOsnNqfDS=LyRaGvSiDTGerB+iuw@mail.gmail.com>
In-Reply-To: <CAJfpeguvCNUEbcy6VQzVJeNOsnNqfDS=LyRaGvSiDTGerB+iuw@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=ddn.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM5PR1901MB2037:EE_|MN0PR19MB5804:EE_
x-ms-office365-filtering-correlation-id: a2f00509-f0da-4381-c314-08db2ba1132c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: g7na3A0h9b9gsCAf6qzKufYDdGDJSNle8IcZxinN+4zmWsMY4HFtcBSaFq6CSJMU85+TPhGbQWTfV8BSWoKm/OXOr9zEs82DoN6BxzyXihIYf1t4LCKcEOoi/vXMlCRxmFaGQjDeR+CKx2UpBfyI0V9riHoJeY6ebyvPQAF43mIvpGHRVFhqrVmEKrvSP8gjPeNQkjKgRimgeVh7loS0VYVO6VyWmwuZygXN/zFbAJpP12owV8KUB6RnPHYCcj14lP5EZ0IJBQc0DGn5nXuavIbSLc1bgqgBZIFGnmAvxqbheo3qNkg8MOdTjTEF8pY5d+71IBoC7WsZOiR8eItdH1HMk1/Y6Dc3yWPDSK4mhbob8cAsD9y+aVSE6eYazjM2IzTzRbUbZ+pII+JJgeB2t2nzgW9p0L+dfcU99GdPs1ogmIUncvr9MZXbByVCbRjcmUmvSi9VuJWGsJQVEkXHhzG9H73o4zpc/X9262h5jCjlR8xuMpu5ZDcigJPh2vrNPufuNtS1U11XBFtO03BtQs6BUDaktobiG54a5hCLs8wzG4jp/FXfSVTZOEYW1qmWJfKi7f3400Q0DIdcwzzZn098PihfDswa2+KZLcFVYo19cJdAQx5S3T+KB7w/1EgLPfFhqh//YJ2nIYI1RFXRwZFuKZ0iLtivtnU7FEgzQFaBZXrw5HRSpMIZpEPt2W7UV093IoNSCMAq4KInaXnHCsjrQq3F+NePHC4813CncthA1NK5Sd/GEyJ0omrw9IAcJYzTx9GfKYBpAChFA54jbA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR1901MB2037.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39850400004)(376002)(366004)(346002)(396003)(136003)(451199018)(4326008)(5660300002)(8676002)(66446008)(66476007)(66556008)(41300700001)(316002)(6916009)(91956017)(38070700005)(66946007)(2906002)(76116006)(64756008)(86362001)(2616005)(31696002)(122000001)(38100700002)(83380400001)(31686004)(71200400001)(8936002)(36756003)(186003)(6512007)(478600001)(54906003)(6486002)(6506007)(53546011)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?K1lJcWRiaXBDbjhjS0F2bEhZMGpoeURUd3VlOFJkMTBFNmYvV29OTHNzazBz?=
 =?utf-8?B?TGI0NTJzNGtTN2tPckFVTEdrNkdyaDJYTjhIWHUxRDZ6OTJCRTZGTWoxMWly?=
 =?utf-8?B?MDNwYW9yYlNLWmRla0Rsekp5WlpKZWtMdkRsd2dPekdQRHZZNUl0dVIya0Q3?=
 =?utf-8?B?ek96ZXIvZVdxMFNGdndBUmMwb25DSlFhck8yVjBuNkFScEZ1QVNUMFdRVVk4?=
 =?utf-8?B?UFl2SlhsT1pMWWxOZlJqazlCVzNyK1BKUUdtY0tvaTY0MzZWczlPdGdDeFdV?=
 =?utf-8?B?Nnp6WEFVVGprMEpGQ1ZneEhDYVo4U2p2eGpTL2Z2amtSanlyOHR6L2ZjQ0Fm?=
 =?utf-8?B?bksxYmZQY012Q0IveFkvZ0tRcVQ2VkZ4SklCVEVoQllZeXRadVd1R2pzNVV6?=
 =?utf-8?B?eGwrWGZTTVBEZ2RNOXVQWS9EYzBlUUxGMm5Pa2V5ZTE5R2RQaDc1ZGd2aFFE?=
 =?utf-8?B?THNCUGZDSmJSN1JqRkhOUG1kYkdCaWsyeFpQMEZpQTg5OHl1ek1JNHBEcm84?=
 =?utf-8?B?UXNUNkY5SjE0TWtFTVFSc1gxeGszWFN2aVlhdktyTFJ3WjN3M05jNitaTkNz?=
 =?utf-8?B?cFp4Nmx6enY3ZHUrZWpibnEvUmN3Wm4yeW5SdzlJV2l6Vm9DRWN1WHVqdTM2?=
 =?utf-8?B?bG9JV0o5M2VVbzJuQ1RJeE5TM1YzazBoenlmeWNyNnl3NXFrVmdDdHJ6a3ZE?=
 =?utf-8?B?NFVGMlhJNUQwTHlKUnMxbFJVdlloOWNkbk9FK0UxcEtDT3A5SFUyNmdDRFZN?=
 =?utf-8?B?N0luWUY5bkdHOHVqOGtWdHlnLzJWNER6UTI1Q3JTUXhXU3ZyZlIrTGlhaWM2?=
 =?utf-8?B?bjBCQUVycUhYV3V2ZWtCL04zN1FXYklUYWdXc2UwSGtSeUdrRjB0LzU3TG1Z?=
 =?utf-8?B?ak52ZE9tWXhYbU9ibmdMMlVLQ0hHa1N2b0VKR0ZRKzFXdWVlM1ZHTnVTVXNT?=
 =?utf-8?B?cktic0haUk1HWkNhd0RqTjB5c1d3V0lva3JJcURydzQwc3dCS1pNQmJtRUlC?=
 =?utf-8?B?OXYyM1pqdXdZdGNvVStOcFpkOHlsU3huSXhqSlA0M05JNG9kRXNBM0NqWkwv?=
 =?utf-8?B?NjdUYjFCRm5yYTJTeERWcUd6Y0M0QnF1OGd2eGVRSjdXQWpLOTNhdTd6RVhj?=
 =?utf-8?B?LzN2SjhSWkxUZVVObEV1MFN5RUVXSUxJempIcGdzWlZIN1Zuc1RXMnVXT3I4?=
 =?utf-8?B?UEtNODd0UGoyY0tYVlRhc0d6cXVOdE9QWnJMendpc2VYVFpZRnVHeG10TkRs?=
 =?utf-8?B?amhmZnBncEdnbXdKOXlRZ3B4RmEzK0xHbFlWL0xHai96YUt6dkI4N2s1ek91?=
 =?utf-8?B?SGZJWUVQTjUrSHN1TTBRMHFzd3NTbHhpNkNqdjNwWVA4VDdFdTdBaXpwUHFy?=
 =?utf-8?B?MGJETzRJdmQvdUZPeW4yaTVvaFBSNEIwcDhqK21oRmk3ZExjY0pXaVFPSVlH?=
 =?utf-8?B?TUIrSEZwREFGTGJ2UXR5TWJveDZNN0s1eWVJT3p4QmU4WTExdE1KcGNQU0lp?=
 =?utf-8?B?Yjdpa0doUDRrNnNUNDdsSGgzS09SS2dhd1JUTzNQU1pvQnhSZHRIREtRSGdS?=
 =?utf-8?B?U1ZMK2dxcXhnVndRZU1pZzExUjQ0dnVTMElJbHFnN0xnMWJQLyt0WVJYZzNT?=
 =?utf-8?B?dGovN2h4b01MSnBZbGsvNWVOV3BFRnlKQ2ZYOWUzVVVoK2VHYkVkWTZTTzU0?=
 =?utf-8?B?am5ObWlLOE80amJuZzkxOEV4aVdnL3BZcFRRSnFWMVJlYTVUTlBKa2RObUtD?=
 =?utf-8?B?STdNRkdTckh1SW0zUTh4dFUxWlFGeHc0NVJ6SnBDMkZZbkJnUGtDS2Q3N0Rq?=
 =?utf-8?B?NFBvRlFaN1Z6UElMdlJORllvaHJUZFFzYjhXNGVpczAxdlJTVzdPOU1zNVJ2?=
 =?utf-8?B?UEJNa0FXS1dCbjJNa3BQYlU3dUlRaTV5QjVmUE1qYVFEbThjdlB6NjFzd1Jl?=
 =?utf-8?B?andab0N2MHI2MG5sMGJ0Ulp2azNnS0ZNRXc3b1dBNVdmaE5OUFowdDF1cUo5?=
 =?utf-8?B?TFFsYXEwbi8wcUtBcmUyQVZFMm9VM3B1MUMyRkwvdTVPK1ZBTk91RWVweHda?=
 =?utf-8?B?SGlZL0wxQXNIT2ZIMWJEQ0tSdDZMendPVVFoS0FCSmt0YUxBeHNUYWVNTUty?=
 =?utf-8?B?bW9EeGtWSWxnd1QrQ2ZiSlpET3Z4TW1jL040L1J3aGNxNk03cnlpd0ppZGZR?=
 =?utf-8?Q?5cZ3Eh7A9eSG3aJ5Gi8jZ4I=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C647BE0A15DDE64F93E37CDC5859A055@namprd19.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: ddn.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR1901MB2037.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2f00509-f0da-4381-c314-08db2ba1132c
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Mar 2023 13:18:21.3861
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PWzf3NCTDErNXFiPyTPiy0fUPUC5e4bNrgeiMAQAUJA5mdEKTenRUob0jF3Vu4YeUAP2EST0aXUdsBO2XCbKRQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR19MB5804
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

T24gMy8yMy8yMyAxMzozNSwgTWlrbG9zIFN6ZXJlZGkgd3JvdGU6DQo+IE9uIFRodSwgMjMgTWFy
IDIwMjMgYXQgMTI6MDQsIEJlcm5kIFNjaHViZXJ0IDxic2NodWJlcnRAZGRuLmNvbT4gd3JvdGU6
DQo+Pg0KPj4gVGhhbmtzIGZvciBsb29raW5nIGF0IHRoZXNlIHBhdGNoZXMhDQo+Pg0KPj4gSSdt
IGFkZGluZyBpbiBNaW5nIExlaSwgYXMgSSBoYWQgdGFrZW4gc2V2ZXJhbCBpZGVhcyBmcm9tIHVi
bGttIEkgZ3Vlc3MNCj4+IEkgYWxzbyBzaG91bGQgYWxzbyBleHBsYWluIGluIHRoZSBjb21taXQg
bWVzc2FnZXMgYW5kIGNvZGUgd2h5IGl0IGlzDQo+PiBkb25lIHRoYXQgd2F5Lg0KPj4NCj4+IE9u
IDMvMjMvMjMgMTE6MjcsIE1pa2xvcyBTemVyZWRpIHdyb3RlOg0KPj4+IE9uIFR1ZSwgMjEgTWFy
IDIwMjMgYXQgMDI6MTEsIEJlcm5kIFNjaHViZXJ0IDxic2NodWJlcnRAZGRuLmNvbT4gd3JvdGU6
DQo+Pj4+DQo+Pj4+IFRoaXMgYWRkcyBhIGRlbGF5ZWQgd29yayBxdWV1ZSB0aGF0IHJ1bnMgaW4g
aW50ZXJ2YWxzDQo+Pj4+IHRvIGNoZWNrIGFuZCB0byBzdG9wIHRoZSByaW5nIGlmIG5lZWRlZC4g
RnVzZSBjb25uZWN0aW9uDQo+Pj4+IGFib3J0IG5vdyB3YWl0cyBmb3IgdGhpcyB3b3JrZXIgdG8g
Y29tcGxldGUuDQo+Pj4NCj4+PiBUaGlzIHNlZW1zIGxpa2UgYSBoYWNrLiAgIENhbiB5b3UgZXhw
bGFpbiB3aGF0IHRoZSBwcm9ibGVtIGlzPw0KPj4+DQo+Pj4gVGhlIGZpcnN0IHRoaW5nIEkgbm90
aWNlIGlzIHRoYXQgeW91IHN0b3JlIGEgcmVmZXJlbmNlIHRvIHRoZSB0YXNrDQo+Pj4gdGhhdCBp
bml0aWF0ZWQgdGhlIHJpbmcgY3JlYXRpb24uICBUaGlzIGFscmVhZHkgbG9va3MgZmlzaHksIGFz
IHRoZQ0KPj4+IHJpbmcgY291bGQgd2VsbCBzdXJ2aXZlIHRoZSB0YXNrICh0aHJlYWQpIHRoYXQg
Y3JlYXRlZCBpdCwgbm8/DQo+Pg0KPj4gWW91IG1lYW4gdGhlIGN1cnJlbnRseSBvbmdvaW5nIHdv
cmssIHdoZXJlIHRoZSBkYWVtb24gY2FuIGJlIHJlc3RhcnRlZD8NCj4+IERhZW1vbiByZXN0YXJ0
IHdpbGwgbmVlZCBzb21lIHdvcmsgd2l0aCByaW5nIGNvbW11bmljYXRpb24sIEkgd2lsbCB0YWtl
DQo+PiBjYXJlIG9mIHRoYXQgb25jZSB3ZSBoYXZlIGFncmVlZCBvbiBhbiBhcHByb2FjaC4gW0Fs
c28gYWRkZWQgaW4gQWxleHNhbmRyZV0uDQo+Pg0KPj4gZnVzZV91cmluZ19zdG9wX21vbigpIGNo
ZWNrcyBpZiB0aGUgZGFlbW9uIHByb2Nlc3MgaXMgZXhpdGluZyBhbmQgYW5kDQo+PiBsb29rcyBh
dCBmYy0+cmluZy5kYWVtb24tPmZsYWdzICYgUEZfRVhJVElORyAtIHRoaXMgaXMgd2hhdCB0aGUg
cHJvY2Vzcw0KPj4gcmVmZXJlbmNlIGlzIGZvci4NCj4gDQo+IE9rYXksIHNvIHlvdSBhcmUgc2F5
aW5nIHRoYXQgdGhlIGxpZmV0aW1lIG9mIHRoZSByaW5nIGlzIGJvdW5kIHRvIHRoZQ0KPiBsaWZl
dGltZSBvZiB0aGUgdGhyZWFkIHRoYXQgY3JlYXRlZCBpdD8NCj4gDQo+IFdoeSBpcyB0aGF0Pw0K
PiANCj4gSSd0cyBtdWNoIG1vcmUgY29tbW9uIHRvIGJpbmQgYSBsaWZldGltZSBvZiBhbiBvYmpl
Y3QgdG8gdGhhdCBvZiBhbg0KPiBvcGVuIGZpbGUuICBpb191cmluZ19zZXR1cCgpIHdpbGwgZG8g
dGhhdCBmb3IgZXhhbXBsZS4NCj4gDQo+IEl0J3MgbXVjaCBlYXNpZXIgdG8gaG9vayBpbnRvIHRo
ZSBkZXN0cnVjdGlvbiBvZiBhbiBvcGVuIGZpbGUsIHRoYW4NCj4gaW50byB0aGUgZGVzdHJ1Y3Rp
b24gb2YgYSBwcm9jZXNzIChhcyB5b3UndmUgb2JzZXJ2ZWQpLiBBbmQgdGhlIHdheQ0KPiB5b3Ug
ZG8gaXQgaXMgZXZlbiBtb3JlIGNvbmZ1c2luZyBhcyB0aGUgcmluZyBpcyBkZXN0cm95ZWQgbm90
IHdoZW4gdGhlDQo+IHByb2Nlc3MgaXMgZGVzdHJveWVkLCBidXQgd2hlbiBhIHNwZWNpZmljIHRo
cmVhZCBpcyBkZXN0cm95ZWQsIG1ha2luZw0KPiB0aGlzIGEgdGhyZWFkIHNwZWNpZmljIGJlaGF2
aW9yIHRoYXQgaXMgcHJvYmFibHkgYmVzdCBhdm9pZGVkLg0KPiANCj4gU28gdGhlIG9idmlvdXMg
c29sdXRpb24gd291bGQgYmUgdG8gZGVzdHJveSB0aGUgcmluZyhzKSBpbg0KPiBmdXNlX2Rldl9y
ZWxlYXNlKCkuICBXaHkgd291bGRuJ3QgdGhhdCB3b3JrPw0KPiANCg0KSSBfdGhpbmtfIEkgaGFk
IHRyaWVkIGl0IGF0IHRoZSBiZWdpbm5pbmcgYW5kIHJ1biBpbnRvIGlzc3VlcyBhbmQgdGhlbiAN
CnN3aXRjaGVkIHRoZSB1YmxrIGFwcHJvYWNoLiBHb2luZyB0byB0cnkgYWdhaW4gbm93Lg0KDQoN
ClRoYW5rcywNCkJlcm5kDQoNCg==

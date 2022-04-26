Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11B7F50F0EF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Apr 2022 08:27:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245128AbiDZGaS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 26 Apr 2022 02:30:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238318AbiDZGaR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 26 Apr 2022 02:30:17 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2055.outbound.protection.outlook.com [40.107.244.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0162D13D61;
        Mon, 25 Apr 2022 23:27:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y8OBs3YI9k7gzOoSNJL3xCmVJi2gcx6IvrKgXoVAKFGcm6Wu51kNYt5CZw6T45iYK9Q2AEFgQG5ThPeYCyrKznX3GeUPgmLSDP1OYsWS/kiXINEohk9rY7dtUfhDbW42csESHphvoQivcOIGLsFDzat6p+FPgOx4LqXPg/+0A5f9ymQyK4vozPL7GLm30/lv8LcrFVCudAmnKoUs9jl5KEE9b3w44zRcVZz6GvELsJjdCto9Q9eX3tuVkwejiH+VuDARqeDPBsupxnYBVXcHW3YWMeM3BPbm+VBvz46OtcVpv/ROx0EqdBzW63ZogjkDwpnn72d2iqRsr4qdJeACAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JiYxf78wxbvqyksZhG00NDno6YGTEn//341RrLRu58w=;
 b=ZyoCRkjRy/O4Xy+C6o+eRK29fQaE0dQlgWF+99bHJlp04+NFHn/DIVwPhCrsI3m2EZYgnpAXmMS42pTXYcL3ajFvRsnZiGRIZurFXzeEb2OILa/FlJeaqj7i9MJjdALwPtNcXHikmcnOtmjRLEJLPHBUEvbTC+MUg5d3ISpEgMqnlZnJBgY6ZalugRxctN/2dGkpu8fz6keqJ+8hCLROryyGPfSZyd59wLzwiGs3hg2L/7FW8H3enNVakjsHmDqDV/YbdbDhfHQD8MyGJ6JV8IV0vI3N331sZJbeBAxBKhhi1MeIrJnFuL14mT+bsJsHQ9gxMifpQuxoYIRhoYkmZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JiYxf78wxbvqyksZhG00NDno6YGTEn//341RrLRu58w=;
 b=dWCEFmdhnzYYfLhf7uDOtLquoOyy2vlNia6B3bH/fqkGzeH2GLDwgd/zA0pEdAi8xRb35/El5NuAYjzToXBGr6mijAO0Y+b0kZz7E6DmTi1DjXppWT56JtO5DEaOfJdeVm3QB54aonIcxmfWsgDUXowLcEx7v4RSKZ01P4F3AP6gX0RjC8dKuELlJ2wzzwAq1UnvJxFFJj5J+VKoSpBVetbOonXUgo2q37oD1SX39mF9GgG56jSgWrQoAfQYDxuNcpuvUByaKZfYsu5JoPolbwCeLCM5YMA85QR5wk8pAIDp+OHBToMiA7UCN6zO8ASjMrvY/NZzfFZrzSZCe+UzMw==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by MN2PR12MB3005.namprd12.prod.outlook.com (2603:10b6:208:c5::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.13; Tue, 26 Apr
 2022 06:27:08 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::a90b:9df2:370c:e76b]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::a90b:9df2:370c:e76b%3]) with mapi id 15.20.5186.021; Tue, 26 Apr 2022
 06:27:08 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Christoph Hellwig <hch@infradead.org>,
        Theodore Ts'o <tytso@mit.edu>
CC:     Douglas Gilbert <dgilbert@interlog.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-modules@vger.kernel.org" <linux-modules@vger.kernel.org>,
        Chaitanya Kulkarni <chaitanyak@nvidia.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Lucas De Marchi <lucas.demarchi@intel.com>,
        Pankaj Malhotra <pankaj1.m@samsung.com>,
        Vincent Fu <vincent.fu@samsung.com>,
        Luis Chamberlain <mcgrof@kernel.org>
Subject: Re: scsi_debug in fstests and blktests (Was: Re: Fwd: [bug
 report][bisected] modprob -r scsi-debug take more than 3mins during blktests
 srp/ tests)
Thread-Topic: scsi_debug in fstests and blktests (Was: Re: Fwd: [bug
 report][bisected] modprob -r scsi-debug take more than 3mins during blktests
 srp/ tests)
Thread-Index: AQHYVai5ObE79sOWj0ioX+OXtUp396z7cDuAgACZjoCAAa9ZAIAECNqA
Date:   Tue, 26 Apr 2022 06:27:07 +0000
Message-ID: <ee43c2b9-48e1-f493-47d5-480112c3a783@nvidia.com>
References: <CAHj4cs9OTm9sb_5fmzgz+W9OSLeVPKix3Yri856kqQVccwd_Mw@mail.gmail.com>
 <fba69540-b623-9602-a0e2-00de3348dbd6@interlog.com>
 <YlW7gY8nr9LnBEF+@bombadil.infradead.org>
 <00ebace8-b513-53c0-f13b-d3320757695d@interlog.com>
 <YmGaGoz2+Kdqu05l@bombadil.infradead.org> <YmJDqceT1AiePyxj@infradead.org>
 <YmLEeUhTImWKIshO@bombadil.infradead.org> <YmQuUM4A0dB3KgLt@infradead.org>
In-Reply-To: <YmQuUM4A0dB3KgLt@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f163f716-ce07-42c9-48fd-08da274dc9ee
x-ms-traffictypediagnostic: MN2PR12MB3005:EE_
x-microsoft-antispam-prvs: <MN2PR12MB30052514A277739203BF4CDDA3FB9@MN2PR12MB3005.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rztEb1mJoBP9xa36Gh4vrm4Otk+jSw5eiQIzGWFvPmya2utS0J4SnGGHDiYtP5PoZDKy8zGFJpd1KIocswoifndfUiSj+kWMzh5mQsmWdUolaJ3RYOCM4hnlEJZt+BUqYpVUJSq/PG9Bkr3qgn06hn/HNiIxEwMvUZt4FBGlrK2Nq0749oh4TS7TpBWE+01fS8GDx9TTNmS5J2Mq2tdZZQAdRzggU8EoXl+ZmFSk7WecmQajUfUc0wRfPDNM361aYHiaY5WsbKytyOy6tlKTu87myaSjvCI4j1HXHyLh4hoAAQYMIWJchOH7AwPp+Hi6346NUUjQBz11HgWBnbfpGTOpH5zoqsks+J7N/ngPM0hkc78p3/GQxZr2AkdDtb9Y8udmezRsunoiXksUrYU1lb04TJjJgAgK55Vr0+hi5Evfwk6hyJ2r/I7BfwVZwqBOO66Nr05qq/RJ62PWHgZVo2tW4sOMDPe+J5Du4F2DUtbGRJX6silzH/dY/eZtv+P3seOz3IumDpDhZ9qLZGrNph3HwXNW0Cy9csb9Ra0EKSyQpgWk+ArQYD/FBFXgIQhJ8+/k8OQL3d/JXf0OVM1SjG4/Wn1PXrt9cBlQ9CjRLf41UwrJ1UAuQzsK0vMMvtTr1SsnrdYCjhb+8ObB8a41Tggp0wgG0gAdVPQ6mxh5foZHvfpjcSwiRunUKZZOv5HvhlrOUUrWeA6kdeuD6kGsC26y4RciQlm1Ae8v1S5pnMYhtRl0wYDVr/AXbSRsDzR4B58jq0JFAsaG54w0BgqfuQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(4744005)(31696002)(86362001)(5660300002)(36756003)(186003)(71200400001)(122000001)(4326008)(6512007)(6506007)(2906002)(6486002)(66446008)(2616005)(64756008)(66946007)(66476007)(8676002)(7416002)(38070700005)(8936002)(66556008)(76116006)(508600001)(316002)(38100700002)(31686004)(110136005)(54906003)(91956017)(53546011)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MnhLM2U4dTE0ZndFNm1zTU9PRjB4cDZRaGVxYjRuZGkrVFYzV2xxQ0labU5W?=
 =?utf-8?B?Z2ZldGpkZGxIbXN1SURTOXZ1c29wQStrWlpiL1FPWEs3dGh2eFZpQnl2Q0tR?=
 =?utf-8?B?Tmd3SklwdkI1aHc0eUVFYnJyZXc4Z21tM1NCeFp5VTIxbG9sUEIrNGpIWlJ4?=
 =?utf-8?B?Q1haNHpGbk5EL1dDYTJWYUhBaGxvbENwK3VESXhVcnVDclY5WXFjYUY0dnlP?=
 =?utf-8?B?R3Y5dUx6QlI1VmdWdkhLWlFhUER4S3FMZWlPN3VYWVpISGQvcC93a3pRK0VF?=
 =?utf-8?B?ejIvS2ZyVXdkcW1uTkswNTlYMDdPbkZtd3JiWmhMenhzWE5xMUttWjRIQXVx?=
 =?utf-8?B?TDkyV1lWZjFNZXJzUEhTNzFUbWNtR0Rjb2xTd2xmVjU5WXFiN2RmL2p4OG1F?=
 =?utf-8?B?TDJvajRVK0dUMzZuWFZtZ25LeGUwSUo4TjFCdVlmVk5kYVgyUlJWSE1VZVJt?=
 =?utf-8?B?UkhOYmp6WURxSjB5ZjNhTEZGby9QYVE4QlNwNXQ3RndiZUNOSElvUkhCb0tm?=
 =?utf-8?B?UXlNNDB1anNLdlJwL1NNenp1M3gyR2pmaHRNSDQxOCtnQ0NvQitpcVY2eFV0?=
 =?utf-8?B?QTZXYXovUU5GZ3p4MGxxbjQxbHJzSmtMQktPZ3F3V0RubDVBSjN1WkRvOXJR?=
 =?utf-8?B?TzVGSFN6b2tIR0RKb2ZCSCtNcTlJVDE1OUNHdnJtZWNLZ0JhVmRwbFNiZXRH?=
 =?utf-8?B?OTBpOWtYV00rSVpNTjIrQVJGNG1MWmFRRlZPVzBIMGtHMGc5ZlB1dTc3ZE9j?=
 =?utf-8?B?djZaQW0zZWRXam1aaGJ0VGJ3NWNRYStrOFlFTkRCN3dwakd4UnY4QkQvbUZI?=
 =?utf-8?B?cW9kaU1lK0xXb3VuYTlJajJCaDM4by9ZZmZJMkxpdUk4LzI4cjR4b25kTkwy?=
 =?utf-8?B?VGFzQ05LY1dwbDRSaGhwb2JMYXZReDVDZEdYclNXUXVlMkRLU3NwQ05xL1RN?=
 =?utf-8?B?aXE5YUw0eUIrY05xSFJGU0RmWURaNDZxVmI5amdRN2lBT3Vrb2F2WXFOU2Er?=
 =?utf-8?B?UzFnZVVVSDRaL094WFg0Wk1sZWtOVXNxNnRyeGxZaWlGVjVBVDNNanRHVWNU?=
 =?utf-8?B?WGJXelAwWUtJUVI3ZnZvM2hlV3FGVTVTM3ZzUXdlZmlnaXJPWjkzL0NjSlNz?=
 =?utf-8?B?WEFmNUgzMWFwdkNRODRRL20yakU4c0k3NGw1UzFQSzFhQnN1Y29iSHZubmYz?=
 =?utf-8?B?a01YZ3FETlJ0UVBLelQrRmtzamNTdmdEVm1RV05vRlVnQmJBanBWUFEvQVlp?=
 =?utf-8?B?Y0xHc0Vwb0RQMk8zTWhZZ1VHOHdzc1Y4VmNoclducDdIZFlUdGpBTEQ2MVpQ?=
 =?utf-8?B?ZTRpcXQ0bmRsOS9vYWtTRlZ2b3ZkbVE3ajVIa001ZURqVkFpUHRaS1Azc2N5?=
 =?utf-8?B?TDNXVzhiTzRUdXFlckZJMXB6RHJzR095VTZpamR3dkVUTWJXOC9DVk10OWtm?=
 =?utf-8?B?NEl4TWpVaXNrajdlUG1ERE5CQXp4Y2xZblN4dGFNb0gyK2FYclR2Qk52T0Ez?=
 =?utf-8?B?UHYvR0FlYnpWUjlhd1gwaW9PZUhVSmdUTTBycGl3MDV5eVh3T05XSTRoMjd6?=
 =?utf-8?B?VXBYdEh1TDVmZ2IrUTJlcm04OVl1aTNuOUNwRC84WFYySXJveEc0RzBlc3J4?=
 =?utf-8?B?VWJRNlNjR0FHeGFhOHpCa1g2WER1SjV3UTBFOWw4ZGNJSlVHUHFHRzVtZjV5?=
 =?utf-8?B?NzZPSGNKcW1OSXFuM21MUms2b0ZjZDdCZjF1TlgzdnVKWlNrMzFxdHVBSFBL?=
 =?utf-8?B?cnBRdFRsdXVzc1diMEdwRjJwVDV5bkV4SHZDTWU0aXJ5eTFlZk43L3JGNDJZ?=
 =?utf-8?B?cnZDdmV2ZjAzZUxjYXNsc1k4K04ycDBva0ozNmR3N3dIaEljT1FZWXQrb0la?=
 =?utf-8?B?VU55ZXJrODFDMXRBR2NVTnZoa0Q5aFBZRklzV25YdWljUWhBTDhqWU5OQzd3?=
 =?utf-8?B?UmgvRkc5WE44MWpQMGgyK05CUFhCNXlLODErNlFYY3lUYWFWRXRIK1U2UTFN?=
 =?utf-8?B?bG9ISWl2V0JYZ1VtVGxxdXBYdWZoOTA2dEFML0FtdWJhZGxma2FZMEp6MSt4?=
 =?utf-8?B?WVdKWlk4UTlUTFNRNjJqSEVYT1RqUnJUckJJaFZmelptQjRTTUV0SjM5dkZB?=
 =?utf-8?B?ZHIxbHhsblR6Zkk5SWp2SmNkWktMNHhtYUo5TG1UN3kwdk5UM25wTCtMUGYr?=
 =?utf-8?B?UWFJdTlsN0g5QTMwZ1JHSEZzQ2JkTnJXekdLSnJCSy9yQlQ0SUlZZGJuL0k4?=
 =?utf-8?B?UngwMVVsc1FpVHZIV1JjK1F6eG5Dd3JuY0l5dWFBL21XaXcyb29vVDhzZ2R6?=
 =?utf-8?B?S21pcWl4UWU5QlhVRVlVeExhR21FdkhFbWE5WGsrdHBuMlBBbHBSRnZWcnNU?=
 =?utf-8?Q?2RDwAd95VwTLwZEhoPAuqYyU+VxNcWj8gdTQ1VkQqxo6i?=
x-ms-exchange-antispam-messagedata-1: oHJI+TVdm0vZ8g==
Content-Type: text/plain; charset="utf-8"
Content-ID: <CE7502042F6E584C80B842818128FDAE@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f163f716-ce07-42c9-48fd-08da274dc9ee
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Apr 2022 06:27:07.9523
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: horwLJDIDXmvOvjTSNQhlvAF+6LDwT1Ujjz1Tcd2W1dUH1wCqlnItQjwlOt4/XpV+UOhCxzfmQoWiuzoXXuPtg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3005
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

T24gNC8yMy8yMiAwOTo1MCwgQ2hyaXN0b3BoIEhlbGx3aWcgd3JvdGU6DQo+IE9uIEZyaSwgQXBy
IDIyLCAyMDIyIGF0IDA4OjA2OjMzQU0gLTA3MDAsIEx1aXMgQ2hhbWJlcmxhaW4gd3JvdGU6DQo+
PiBJdCBiZWdzIHRoZSBxdWVzdGlvbiBpZiB0aGUgc2FtZSB3aXNoIHNob3VsZCBhcHBseSB0byBm
c3Rlc3RzLg0KPiANCj4geGZzdGVzdHMgZ2VuZXJhbGx5IHdvcmtzIGZpbmUgZXhjZXB0IGZvciBh
IGhhbmRmdWwgdGVzdCB0aGF0IGV4cGxpY2l0bHkNCj4gd2FudCBtb2R1bGUgcmVtb3ZhbCBidXQg
X25vdHJ1biBncmFjZWZ1bGx5IGluIHRoYXQgY2FzZS4gIFVubGlrZQ0KPiBibGt0ZXN0cyB3aGlj
aCBqdXN0IGV4cGxvZGVzLg0KPiANCj4+IElmIHdlIHdhbnQgdG8gKm5vdCogcmVseSBvbiBtb2R1
bGUgcmVtb3ZhbCB0aGVuIHRoZSByaWdodCB0aGluZyB0byBkbyBJDQo+PiB0aGluayB3b3VsZCBi
ZSB0byByZXBsYWNlIG1vZHVsZSByZW1vdmFsIG9uIHRoZXNlIGRlYnVnIG1vZHVsZXMNCj4+IChz
Y3NpX2RlYnVnKSB3aXRoIGFuIEFQSSBhcyBudWxsX2JsayBoYXMgd2hpY2ggdXNlcyBjb25maWdm
cyB0byAqYWRkKiAvDQo+PiAqcmVtb3ZlKiBkZXZpY2VzLg0KPiANCj4gc2NzaV9kZWJ1ZyBoYXMg
cnVudGltZSB3cml0YWJsZSBtb2R1bGUgcGFyYW1ldGVycyB0aGF0IGNvdmVyIGp1c3QNCj4gYWJv
dXQgZXZlcnl0aGluZy4NCj4gDQoNCkkndmUgYWRkZWQgdG8gdGhlIG15IFRPRE8gbGlzdCBtYWtp
bmcgbnZtZS1ibGt0ZXN0cyB3aGVyZSB3ZSBjYW4gYXZvaWQNCnRoZSBuZWVkIGZvciBtb2R1bGUg
bG9hZGluZyBhbmQgdW5sb2FkaW5nLCBJJ2xsIGFsc28gYWRkIGEgbW9kdWxlDQpsb2FkLXVubG9h
ZCBzcGVjaWZpYyB0ZXN0cyB0byB0aGF0IGZ1bmN0aW9uYWxpdHkgd2lsbCBnZXQgdGVzdGVkLg0K
DQotY2sNCg0KDQo=

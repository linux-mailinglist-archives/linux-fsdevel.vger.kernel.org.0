Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2915F6C2770
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Mar 2023 02:26:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229828AbjCUB0i (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Mar 2023 21:26:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjCUB0h (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Mar 2023 21:26:37 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2075.outbound.protection.outlook.com [40.107.94.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7F9210F1
        for <linux-fsdevel@vger.kernel.org>; Mon, 20 Mar 2023 18:26:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zz0GJZDUsgmg24ooZO6B7WQHj8A2UctLNfPmtz2/BnO/2lFDl6PTmX4eMWKHTJtaYDlwBAgUEDkf7pQ9pKSDk13vqgm2WkaGi6SNoeuezd7rcLuAkaI9tbrv3wgb5lWRcJRoJ3wl+ZCmxTndAbVis3j0HqDnLYCPcszodH/JLuVK4HKjPXYL8UOMwIs5rPI2fQgWJPqu76YZcHkM4nqz7//lDO9IR6CLxA2q8Ipd84o/y5WtMzRGhGSjojQe6WAIdpEDJ9ja9oRfldTDf/mt7iaY+xdyzUDglIifJEg1gqWtkIDVD+Xf6vH3/cUW01uvboR4LPOEyRJyqrj3XIquVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AibRYy0u7k3VWaexgahVz4N2T4VvZwSJr3LTeA4e7z8=;
 b=cy4MlK1b2RgoWVgyzqyjSTPz8l6y1lTEKdFnVg1jeWnQMHMw/RhcLO5CC3eHWQyYi8fX44cwIDje4p8Jp+J61e/DrMFhUrbe7hhXe6v0HW18RD9VQDmRQdsIB8JXvHbBixo5PheAJhG4Iy2p9y+ZjPE/RVMlIn7/gvjujkS87W8mSktnhh4do9HBXyeuCvt3QwyLWMSCkZnLW12sVbvOzm7WDdqQv/5nq7+X7MRwYG6QvvDHJAdyvl0V0okSIG/URkXHEmuv9atoD9/CbY1LUREw7al6/epVB/Y7mS+NyrGzYylS/fkYc6Rnf0Y1AHG8DwgwzO4wKyV7z8o4IDPhUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ddn.com; dmarc=pass action=none header.from=ddn.com; dkim=pass
 header.d=ddn.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ddn.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AibRYy0u7k3VWaexgahVz4N2T4VvZwSJr3LTeA4e7z8=;
 b=HILH9lL6ih7ifFCWlNQuVNNd8E2DCJ5kcG9MM3Esn9wRUTASQPoyAVP2uyNvnVa1Sr45iPwMEqTokCYcwo9RreVyJt1RSWmVXFbhM1f9hXkgEtjcC0uf8KRwfz7jSPWqohvras8pio3Vi8leHWDuE1ccw8y9kNHijYzq55wzwRc=
Received: from DM5PR1901MB2037.namprd19.prod.outlook.com (2603:10b6:4:aa::29)
 by BY3PR19MB4882.namprd19.prod.outlook.com (2603:10b6:a03:364::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.26; Tue, 21 Mar
 2023 01:26:23 +0000
Received: from DM5PR1901MB2037.namprd19.prod.outlook.com
 ([fe80::e6d4:29f7:2077:bd69]) by DM5PR1901MB2037.namprd19.prod.outlook.com
 ([fe80::e6d4:29f7:2077:bd69%4]) with mapi id 15.20.6086.024; Tue, 21 Mar 2023
 01:26:23 +0000
From:   Bernd Schubert <bschubert@ddn.com>
To:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
CC:     Dharmendra Singh <dsingh@ddn.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Amir Goldstein <amir73il@gmail.com>,
        "fuse-devel@lists.sourceforge.net" <fuse-devel@lists.sourceforge.net>
Subject: Re: [RFC PATCH 00/13] fuse uring communication
Thread-Topic: [RFC PATCH 00/13] fuse uring communication
Thread-Index: AQHZW5IKkZlOLyhCP0St2kzD8AXnkq8EcSYA
Date:   Tue, 21 Mar 2023 01:26:23 +0000
Message-ID: <9789c678-2ed9-32f5-548a-3f55a51d6d9b@ddn.com>
References: <20230321011047.3425786-1-bschubert@ddn.com>
In-Reply-To: <20230321011047.3425786-1-bschubert@ddn.com>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=ddn.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM5PR1901MB2037:EE_|BY3PR19MB4882:EE_
x-ms-office365-filtering-correlation-id: 54b7d137-59ec-44ca-c544-08db29ab4836
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7VcUJmIK3/38Qs2cwr8d9yzn1zV8eFXhLQinTeWrT0dfDS23vUyHEpflpjRWxNYTAgCx+PJpLgomQeBcMcFEw6vvje1jz6tBd2xS5aBuf9SL5eUvGqKdgmOBplagYC6F/pou3oCwgmIy0yZ6rinMbcWBc1/zN+b/eBOJEtKYIC2qwhS6N/4bxsNTum0OnYYRHcPykm5Pk2sR+Vl4avUa3oOF/YmNo4RY0CY5FlxjLayKNaYirj/tqGQcglsa3DMjSn6h2LYk9qwStJxqDsByAn6JkA771xR4B770q+gzFeQgs2XbS4itLm9s6WMER4cnuGLCrvk5CNHneq0jscrOIEzcTfjQLdE4rqNbYipdCCjELYdlUi87pEc0MPmNcSZAd1eXfqk+UZSY69KS90vPeX2v+cXVVsG8gBfQr3eF8LIEM8MBGLyxjtoUPKaJiz45U88lSYOhMt89fWdt+VptCqNrNPfFZ9nsRGahLZPfEpo/ZiZky0eE5KUKPlpcxoAcE9vXEB7o0m2izdPjKRqtUz+LbSOSBGda83MSlTPrfjxblxWD82JYaxCvrpozGzNl3lIYNG0Dwi3LhyCe0qlxelvtPnOIFafa+z0/hr9OQ5UHVzr9XTRA2gLE5wIommj1AD0zFBAB+PqP4ASjND6uPS1LLEkxarknS+CTf+Xf/2XAUCkOSkUe2XgtFn8MyCQnUirPzF4h/VeN54KU4L9Crx3Oe1vDjNRb9ktx7FSJYz3jL7+u3Jq1i5R3Os6Wm5dBvLb9CMr1G65LCbApm9m5fXBog6zfGbcYnNTNgyHM8PeNmj5noMERz3BwHUtoTy4Y
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR1901MB2037.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(366004)(396003)(39850400004)(136003)(346002)(376002)(451199018)(4326008)(91956017)(8936002)(8676002)(76116006)(6916009)(64756008)(5660300002)(66556008)(6486002)(66476007)(966005)(66946007)(66446008)(41300700001)(54906003)(71200400001)(6512007)(53546011)(186003)(122000001)(316002)(6506007)(2616005)(478600001)(31686004)(83380400001)(38100700002)(38070700005)(31696002)(86362001)(2906002)(36756003)(21314003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bnlCbkpzQ1VheGFCckJ6bGo0UW9VNE5jWTgwSUY3elh2UlB6ZTFwQjdOaXNx?=
 =?utf-8?B?Wnp0WVl1bk9MQjVENEhOTjJkYVYwa0REak8yRlBpKzFCV092YWp3MmxXbm5o?=
 =?utf-8?B?OGNRb3dzWjBqd0VhamZHNEgwYUFKM0QyWG9OSml6ZVVIVjRKZUFQQWFNQzdx?=
 =?utf-8?B?dFpEN2pvWkVPWHFIc2ZGeHpzR1p5VXhGU2d4UlNKUnZmVVdtUnVDVU5VUEhj?=
 =?utf-8?B?YndiUmphc2tSZjh1TFJpWTVheElEVGJndXRzUXZmN0VXTXJLZ3lMRGxJOHRm?=
 =?utf-8?B?Q0lxcm0xU3p4VmtGanZodGpGR1JJN2s4MVBodnVlMnBCc0JOdXZ1bWwyRUFX?=
 =?utf-8?B?bjR4R3RyS2d0NnMvMytuOXpOS0V5NDFXZk1ZK1NpQXZ2emJWYy9XcnRvMlJP?=
 =?utf-8?B?R1BEcjA4cHNJTDRreWg4M3M3eXA5VzJJUVJXU1RxMFlmNzFFaVFsdHhMMjdJ?=
 =?utf-8?B?MFdPZWRKdDNMNE5PemZqc1pQUHZYeGJKOG51VHdNK1dXem5BVlZjRHEyUTAy?=
 =?utf-8?B?eWJhNXk1SkMrN2N3VUNaZ3BNSUE3ZUZMNkk0SjZHZkowTDZMWW5NV0hQTlE5?=
 =?utf-8?B?YXJqWXhYN2YvcTZiTmh4K0JyR1Zsd1QyUk1ldEhYeVY0M1JhOURKRTdnRWI0?=
 =?utf-8?B?TEIzWTFYNXVCT0d0L1hEYmY4YlUvRm5YQ3ovMmh5QkVCV3J0SitPejdncDBo?=
 =?utf-8?B?OFJpdDNEdkVmY2lia3lRbkxtaHVPeit0c3ArNmdPNlZZRWtPWXJLOXdGem9U?=
 =?utf-8?B?T29Lald2ZURLVWlsN2RyTEsxbFlhVGlkMlAycUV6Zy9CVVg3UW1IemVrd2xD?=
 =?utf-8?B?QUpFM0hNUVB1QnpJQ0dKYVhRTDV5bVpCT0M0Tzl0a3FiUGNmUkFsQWIxRjAr?=
 =?utf-8?B?VFgvRHd6Y0I0U1FsYjZsV2IrcDU1dUJNYk9oSFlsQU80a2RxcnlkbERLY0ZW?=
 =?utf-8?B?VkppNkJSdU80dkpmSEdZMUEzbXNwU3FPdjBySlhkWE55K0F6MFhaa3hYZkNq?=
 =?utf-8?B?bUN6OTNxazJPcU1QeUd5TWlJVWpUN1FOTXFLbmcrRjE0ZEp5K2l1ZWNlYlpQ?=
 =?utf-8?B?RnQ2TjZWdXUvNjRmU1FXMUErZmpSbWVUUXhqY2t2M1EzSFFaS2YxL2xCWWJO?=
 =?utf-8?B?TzZmV0JLV212VTV5SE4rMW53MGVXSWlZQUlMNHJhUDRTS3dWUENvby9mUnZD?=
 =?utf-8?B?MkluZ3gxeGZZMndORlNIaGZ5UzZGZXc1bEZuU0ViTGsvdHVyVy9JaEl0NUYx?=
 =?utf-8?B?a2FlbW45TkxIQlFIT2RHY1A2Q0JrKzBOMjh5dkd3NWRBTU52VENqbnl0QUlt?=
 =?utf-8?B?RDRySFdFSVFTVDh3WWtwOVI3WmpMbGE2S1lhS3l5MTNOM3Vxa0p6QytoMGdW?=
 =?utf-8?B?NEJwMzQ3TXMxU0p4WHUxd3dValJtNGc2YUJaNHNhUDhIblVsaXVHNk1VbWhG?=
 =?utf-8?B?cGxPcG5SQVhGSFhZSkV4bHlVQ0VXOCtpQTZNMzBBV3lPUlpPQzJPNGtMMHNw?=
 =?utf-8?B?OTZhVVN5MkNUQ3ZvVGY5bmx5QlJKUnBzMkZydUdNWGYrSEVvS1hPelNnbTRD?=
 =?utf-8?B?TkErNHdXVEtHT1ZILzZ4a1B0eTRnaUJIY1BYbUdrbi9UMVZVeEpLNXRnUUhW?=
 =?utf-8?B?V2hMcVVObnZ5SzBraWpYdXQ2Y1k1eHlxS2NoYWNuMENGT01IL1pSRWxxV01C?=
 =?utf-8?B?QmVXM0VvMUQrMEZFcExRWDhybkIwRjdSc2tOcnA3eFA0eFp0dlI5ODBRRDhS?=
 =?utf-8?B?T1R1a3ZmV1JmdUNJRmIrVmdTOWdJdWI2R1dWb05sblozZEdXVXBKbWpRTVNp?=
 =?utf-8?B?MXc1UkJsdWQvWi83Y0tjVkQxdm0yZUZuQndISXZHdyt0UW0xSldPY2FPN1Aw?=
 =?utf-8?B?VVhVazJCUTRadmJVTFBKV2ZsUGhLRzFQaW9iU1lPT2p0UC9pa1FJNG5jNmMy?=
 =?utf-8?B?Mlh1eWpkMDZ1RUV3N2pqcE96M1NmZWNoNDREUmVDSXhJVTMzUk1qdUtSNk5G?=
 =?utf-8?B?WGlZRG4xdUVzMG9KVm1kKzJHWmVhczlMZS9HcE9sQjdiVFRZYnFTU012cytv?=
 =?utf-8?B?VDlIRDY2akpNNlQ3NzJ5ZVV6NnA3ZytVMUhhY0NndTJFV0QwaUQ5T3V0Vkhl?=
 =?utf-8?B?WFNYNWQ1YTlNWlplSnM2bzY0QUhtZG15L3ZLeGFRdEpYdUtnK084dlRtZXFp?=
 =?utf-8?Q?SiF65bKsmeY9zs33ZZojPBY=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6C916508726716468AF13F5A424A2750@namprd19.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: ddn.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR1901MB2037.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54b7d137-59ec-44ca-c544-08db29ab4836
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Mar 2023 01:26:23.0440
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: E3VUVrV1p0x86Rf6yctCFnVJYlum+5Em2C2a6SocIEm4A4VX88z2SQSjjwmXGkjFQ59Bv4SAWcs0MgipFVL1BQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY3PR19MB4882
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

VGhlIGludHJvZHVjdGlvbiBzZWVtcyB0byBiZSBtaXNzaW5nIG9uIHRoZSBmc2RldmVsIGxpc3QN
Cg0KT24gMy8yMS8yMyAwMjoxMCwgQmVybmQgU2NodWJlcnQgd3JvdGU6DQo+IFRoaXMgYWRkcyBz
dXBwb3J0IGZvciB1cmluZyBjb21tdW5pY2F0aW9uIGJldHdlZW4ga2VybmVsIGFuZA0KPiB1c2Vy
c3BhY2UgZGFlbW9uIHVzaW5nIG9wY29kZSB0aGUgSU9SSU5HX09QX1VSSU5HX0NNRC4gVGhlIGJh
c2ljDQo+IGFwcHJhb2NoIHdhcyB0YWtlbiBmcm9tIHVibGsuICBUaGUgcGF0Y2hlcyBhcmUgaW4g
UkZDIHN0YXRlIC0NCj4gSSdtIG5vdCBzdXJlIGFib3V0IGFsbCBkZWNpc2lvbnMgYW5kIHNvbWUg
cXVlc3Rpb25zIGFyZSBtYXJrZWQNCj4gd2l0aCBYWFguDQo+IA0KPiBVc2Vyc3BhY2Ugc2lkZSBo
YXMgdG8gc2VuZCBJT0NUTChzKSB0byBjb25maWd1cmUgcmluZyBxdWV1ZShzKQ0KPiBhbmQgaXQg
aGFzIHRoZSBjaG9pY2UgdG8gY29uZmlndXJlIGV4YWN0bHkgb25lIHJpbmcgb3Igb25lDQo+IHJp
bmcgcGVyIGNvcmUuIElmIHRoZXJlIGFyZSB1c2UgY2FzZSB3ZSBjYW4gYWxzbyBjb25zaWRlcg0K
PiB0byBhbGxvdyBhIGRpZmZlcmVudCBudW1iZXIgb2YgcmluZ3MgLSB0aGUgaW9jdGwgY29uZmln
dXJhdGlvbg0KPiBvcHRpb24gaXMgcmF0aGVyIGdlbmVyaWMgKG51bWJlciBvZiBxdWV1ZXMpLg0K
PiANCj4gUmlnaHQgbm93IGEgcXVldWUgbG9jayBpcyB0YWtlbiBmb3IgYW55IHJpbmcgZW50cnkg
c3RhdGUgY2hhbmdlLA0KPiBtb3N0bHkgdG8gY29ycmVjdGx5IGhhbmRsZSB1bm1vdW50L2RhZW1v
bi1zdG9wLiBJbiBmYWN0LA0KPiBjb3JyZWN0bHkgc3RvcHBpbmcgdGhlIHJpbmcgdG9vayBtb3N0
IG9mIHRoZSBkZXZlbG9wbWVudA0KPiB0aW1lIC0gYWx3YXlzIG5ldyBjb3JuZXIgY2FzZXMgY2Ft
ZSB1cC4NCj4gSSBoYWQgcnVuIGRvemVucyBvZiB4ZnN0ZXN0IGN5Y2xlcywNCj4gdmVyc2lvbnMg
SSBoYWQgb25jZSBzZWVuIGEgd2FybmluZyBhYm91dCB0aGUgcmluZyBzdGFydF9zdG9wDQo+IG11
dGV4IGJlaW5nIHRoZSB3cm9uZyBzdGF0ZSAtIHByb2JhYmx5IGFub3RoZXIgc3RvcCBpc3N1ZSwN
Cj4gYnV0IEkgaGF2ZSBub3QgYmVlbiBhYmxlIHRvIHRyYWNrIGl0IGRvd24geWV0Lg0KPiBSZWdh
cmRpbmcgdGhlIHF1ZXVlIGxvY2sgLSBJIHN0aWxsIG5lZWQgdG8gZG8gcHJvZmlsaW5nLCBidXQN
Cj4gbXkgYXNzdW1wdGlvbiBpcyB0aGF0IGl0IHNob3VsZCBub3QgbWF0dGVyIGZvciB0aGUNCj4g
b25lLXJpbmctcGVyLWNvcmUgY29uZmlndXJhdGlvbi4gRm9yIHRoZSBzaW5nbGUgcmluZyBjb25m
aWcNCj4gb3B0aW9uIGxvY2sgY29udGVudGlvbiBtaWdodCBjb21lIHVwLCBidXQgSSBzZWUgdGhp
cw0KPiBjb25maWd1cmF0aW9uIG1vc3RseSBmb3IgZGV2ZWxvcG1lbnQgb25seS4NCj4gQWRkaW5n
IG1vcmUgY29tcGxleGl0eSBhbmQgcHJvdGVjdGluZyByaW5nIGVudHJpZXMgd2l0aA0KPiB0aGVp
ciBvd24gbG9ja3MgY2FuIGJlIGRvbmUgbGF0ZXIuDQo+IA0KPiBDdXJyZW50IGNvZGUgYWxzbyBr
ZWVwIHRoZSBmdXNlIHJlcXVlc3QgYWxsb2NhdGlvbiwgaW5pdGlhbGx5DQo+IEkgb25seSBoYWQg
dGhhdCBmb3IgYmFja2dyb3VuZCByZXF1ZXN0cyB3aGVuIHRoZSByaW5nIHF1ZXVlDQo+IGRpZG4n
dCBoYXZlIGZyZWUgZW50cmllcyBhbnltb3JlLiBUaGUgYWxsb2NhdGlvbiBpcyBkb25lDQo+IHRv
IHJlZHVjZSBpbml0aWFsIGNvbXBsZXhpdHksIGVzcGVjaWFsbHkgYWxzbyBmb3IgcmluZyBzdG9w
Lg0KPiBUaGUgYWxsb2NhdGlvbiBmcmVlIG1vZGUgY2FuIGJlIGFkZGVkIGJhY2sgbGF0ZXIuDQo+
IA0KPiBSaWdodCBub3cgYWx3YXlzIHRoZSByaW5nIHF1ZXVlIG9mIHRoZSBzdWJtaXR0aW5nIGNv
cmUNCj4gaXMgdXNlZCwgZXNwZWNpYWxseSBmb3IgcGFnZSBjYWNoZWQgYmFja2dyb3VuZCByZXF1
ZXN0cw0KPiB3ZSBtaWdodCBjb25zaWRlciBsYXRlciB0byBhbHNvIGVucXVldWUgb24gb3RoZXIg
Y29yZSBxdWV1ZXMNCj4gKHdoZW4gdGhlc2UgYXJlIG5vdCBidXN5LCBvZiBjb3Vyc2UpLg0KPiAN
Cj4gU3BsaWNlL3plcm8tY29weSBpcyBub3Qgc3VwcG9ydGVkIHlldCwgYWxsIHJlcXVlc3RzIGdv
DQo+IHRocm91Z2ggdGhlIHNoYXJlZCBtZW1vcnkgcXVldWUgZW50cnkgYnVmZmVyLiBJIGFsc28N
Cj4gZm9sbG93aW5nIHNwbGljZSBhbmQgdWJsay96YyBjb3B5IGRpc2N1c3Npb25zLCBJIHdpbGwN
Cj4gbG9vayBpbnRvIHRoZXNlIG9wdGlvbnMgaW4gdGhlIG5leHQgZGF5cy93ZWVrcy4NCj4gVG8g
aGF2ZSB0aGF0IGJ1ZmZlciBhbGxvY2F0ZWQgb24gdGhlIHJpZ2h0IG51bWEgbm9kZSwNCj4gYSB2
bWFsbG9jIGlzIGRvbmUgcGVyIHJpbmcgcXVldWUgYW5kIG9uIHRoZSBudW1hIG5vZGUNCj4gdXNl
cnNwYWNlIGRhZW1vbiBzaWRlIGFza3MgZm9yLg0KPiBNeSBhc3N1bXB0aW9uIGlzIHRoYXQgdGhl
IG1tYXAgb2Zmc2V0IHBhcmFtZXRlciB3aWxsIGJlDQo+IHBhcnQgb2YgYSBkZWJhdGUgYW5kIEkn
bSBjdXJpb3VzIHdoYXQgb3RoZXIgdGhpbmsgYWJvdXQNCj4gdGhhdCBhcHByYW9jaC4NCj4gDQo+
IEJlbmNobWFya2luZyBhbmQgdHVuaW5nIGlzIG9uIG15IGFnZW5kYSBmb3IgdGhlIG5leHQNCj4g
ZGF5cy4gRm9yIG5vdyBJIG9ubHkgaGF2ZSB4ZnN0ZXN0IHJlc3VsdHMgLSBtb3N0IGxvbmdlcg0K
PiBydW5uaW5nIHRlc3RzIHdlcmUgcnVubmluZyBhdCBhYm91dCAyeCwgYnV0IHNvbWVob3cgd2hl
bg0KPiBJIGNsZWFuZWQgdXAgdGhlIHBhdGNoZXMgZm9yIHN1Ym1pc3Npb24gSSBsb3N0IHRoYXQu
DQo+IE15IGRldmVsb3BtZW50IFZNL2tlcm5lbCBoYXMgYWxsIHNhbml0aXplcnMgZW5hYmxlZCAt
DQo+IGhhcmQgdG8gcHJvZmlsZSB3aGF0IGhhcHBlbmVkLiBQZXJmb3JtYW5jZQ0KPiByZXN1bHRz
IHdpdGggcHJvZmlsaW5nIHdpbGwgYmUgc3VibWl0dGVkIGluIGEgZmV3IGRheXMuDQo+IA0KPiBU
aGUgcGF0Y2hlcyBpbmNsdWRlIGEgZGVzaWduIGRvY3VtZW50LCB3aGljaCBoYXMgYSBmZXcgbW9y
ZQ0KPiBkZXRhaWxzLg0KPiANCj4gVGhlIGNvcnJlc3BvbmRpbmcgbGliZnVzZSBwYXRjaGVzIGFy
ZSBvbiBteSB1cmluZyBicmFuY2gsDQo+IGJ1dCBuZWVkIGNsZWFudXAgZm9yIHN1Ym1pc3Npb24g
LSB3aWxsIGhhcHBlbiBkdXJpbmcgdGhlIG5leHQNCj4gZGF5cy4NCj4gaHR0cHM6Ly9naXRodWIu
Y29tL2JzYmVybmQvbGliZnVzZS90cmVlL3VyaW5nDQo+IA0KPiBJZiBpdCBzaG91bGQgbWFrZSBy
ZXZpZXcgZWFzaWVyLCBwYXRjaGVzIHBvc3RlZCBoZXJlIGFyZSBvbg0KPiB0aGlzIGJyYW5jaA0K
PiBodHRwczovL2dpdGh1Yi5jb20vYnNiZXJuZC9saW51eC90cmVlL2Z1c2UtdXJpbmctZm9yLTYu
Mg0KPiANCj4gDQo+IEJlcm5kIFNjaHViZXJ0ICgxMyk6DQo+ICAgIGZ1c2U6IEFkZCB1cmluZyBk
YXRhIHN0cnVjdHVyZXMgYW5kIGRvY3VtZW50YXRpb24NCj4gICAgZnVzZTogcmVuYW1lIHRvIGZ1
c2VfZGV2X2VuZF9yZXF1ZXN0cyBhbmQgbWFrZSBub24tc3RhdGljDQo+ICAgIGZ1c2U6IE1vdmUg
ZnVzZV9nZXRfZGV2IHRvIGhlYWRlciBmaWxlDQo+ICAgIEFkZCBhIHZtYWxsb2Nfbm9kZV91c2Vy
IGZ1bmN0aW9uDQo+ICAgIGZ1c2U6IEFkZCBhIHVyaW5nIGNvbmZpZyBpb2N0bCBhbmQgcmluZyBk
ZXN0cnVjdGlvbg0KPiAgICBmdXNlOiBBZGQgYW4gaW50ZXJ2YWwgcmluZyBzdG9wIHdvcmtlci9t
b25pdG9yDQo+ICAgIGZ1c2U6IEFkZCB1cmluZyBtbWFwIG1ldGhvZA0KPiAgICBmdXNlOiBNb3Zl
IHJlcXVlc3QgYml0cw0KPiAgICBmdXNlOiBBZGQgd2FpdCBzdG9wIGlvY3RsIHN1cHBvcnQgdG8g
dGhlIHJpbmcNCj4gICAgZnVzZTogSGFuZGxlIFNRRXMgLSByZWdpc3RlciBjb21tYW5kcw0KPiAg
ICBmdXNlOiBBZGQgc3VwcG9ydCB0byBjb3B5IGZyb20vdG8gdGhlIHJpbmcgYnVmZmVyDQo+ICAg
IGZ1c2U6IEFkZCB1cmluZyBzcWUgY29tbWl0IGFuZCBmZXRjaCBzdXBwb3J0DQo+ICAgIGZ1c2U6
IEFsbG93IHRvIHF1ZXVlIHRvIHRoZSByaW5nDQo+IA0KPiAgIERvY3VtZW50YXRpb24vZmlsZXN5
c3RlbXMvZnVzZS11cmluZy5yc3QgfCAgMTc5ICsrKw0KPiAgIGZzL2Z1c2UvTWFrZWZpbGUgICAg
ICAgICAgICAgICAgICAgICAgICAgfCAgICAyICstDQo+ICAgZnMvZnVzZS9kZXYuYyAgICAgICAg
ICAgICAgICAgICAgICAgICAgICB8ICAxOTMgKysrLQ0KPiAgIGZzL2Z1c2UvZGV2X3VyaW5nLmMg
ICAgICAgICAgICAgICAgICAgICAgfCAxMjkyICsrKysrKysrKysrKysrKysrKysrKysNCj4gICBm
cy9mdXNlL2Rldl91cmluZ19pLmggICAgICAgICAgICAgICAgICAgIHwgICAyMyArDQo+ICAgZnMv
ZnVzZS9mdXNlX2Rldl9pLmggICAgICAgICAgICAgICAgICAgICB8ICAgNjIgKysNCj4gICBmcy9m
dXNlL2Z1c2VfaS5oICAgICAgICAgICAgICAgICAgICAgICAgIHwgIDE3OCArKysNCj4gICBmcy9m
dXNlL2lub2RlLmMgICAgICAgICAgICAgICAgICAgICAgICAgIHwgICAxMCArDQo+ICAgaW5jbHVk
ZS9saW51eC92bWFsbG9jLmggICAgICAgICAgICAgICAgICB8ICAgIDEgKw0KPiAgIGluY2x1ZGUv
dWFwaS9saW51eC9mdXNlLmggICAgICAgICAgICAgICAgfCAgMTMxICsrKw0KPiAgIG1tL25vbW11
LmMgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAgICA2ICsNCj4gICBtbS92bWFsbG9j
LmMgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwgICA0MSArLQ0KPiAgIDEyIGZpbGVzIGNo
YW5nZWQsIDIwNjQgaW5zZXJ0aW9ucygrKSwgNTQgZGVsZXRpb25zKC0pDQo+ICAgY3JlYXRlIG1v
ZGUgMTAwNjQ0IERvY3VtZW50YXRpb24vZmlsZXN5c3RlbXMvZnVzZS11cmluZy5yc3QNCj4gICBj
cmVhdGUgbW9kZSAxMDA2NDQgZnMvZnVzZS9kZXZfdXJpbmcuYw0KPiAgIGNyZWF0ZSBtb2RlIDEw
MDY0NCBmcy9mdXNlL2Rldl91cmluZ19pLmgNCj4gICBjcmVhdGUgbW9kZSAxMDA2NDQgZnMvZnVz
ZS9mdXNlX2Rldl9pLmgNCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEJlcm5kIFNjaHViZXJ0IDxic2No
dWJlcnRAZGRuLmNvbT4NCj4gY2M6IE1pa2xvcyBTemVyZWRpIDxtaWtsb3NAc3plcmVkaS5odT4N
Cj4gY2M6IGxpbnV4LWZzZGV2ZWxAdmdlci5rZXJuZWwub3JnDQo+IGNjOiBBbWlyIEdvbGRzdGVp
biA8YW1pcjczaWxAZ21haWwuY29tPg0KPiBjYzogZnVzZS1kZXZlbEBsaXN0cy5zb3VyY2Vmb3Jn
ZS5uZXQNCj4gDQoNCg==

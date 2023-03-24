Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8AE86C8886
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Mar 2023 23:44:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231623AbjCXWoV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 24 Mar 2023 18:44:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230015AbjCXWoU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 24 Mar 2023 18:44:20 -0400
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2047.outbound.protection.outlook.com [40.107.96.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E43E8E;
        Fri, 24 Mar 2023 15:44:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PR89h/VFaLe2UeFnneST0epRXQpfoe6nVdnobPGGDOMezagvCGGTp8EuXkQTQBes9qOgKZchV1uKZSU2vjLzb4UwVqZEyoP9AnbwQC/v6ll1F6ZCZv7l57YrFL3DxrpK0/SLQwBT7MQW74CjRB5LrefpRMofGfGp2K+zDA7k60mEmYR6retLnQyT8f76MaLRz637nyqKfZLtLn9FZgiHh1eSk/4RxCMTmKX/MfaOT76QqY24n67+J97g6jqP10VCas7RzU0at1YGNzQKUr/oErRLP2rsX7+v3sOZ3QRaRh47hitZFZV9+NwDkN0w/Evg0Eujci8L3YOC6nLr2ENcqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zf4fnISRXOTPA0VuCMOnIqllrEWONX/tMFg3Ntfb7vo=;
 b=cX8l8gm2GV3GlhH3GoEbX0hfS0S73kjKoCrrSdyAn65RQOK0m0NPTf8rMQTejf5A9zIqQBQeESbdeX/8kKQRjXuq9laEKxBm8T+bbavLlIB5Ytmcsfv1DJPUhkFv6RV/QiyTuM8W3mwrMFXvIpwYXWwKKDOCf3egYAVx+bxXhvvvs75vVaPUW2cLFXuya1iS95jMn2X2j/pV+hAcBbKKOJ+jWlybjHHaa2Xxan+JlFHHgpv/J8o8fjFoGvvDKvI88dvBpW0BK3e2o6QlZXZKm4ahSU5s5l+uopK7+ChQYvVMoFoOTSUn3BlhQfvAHvfP2fdyXfLfJjDO/4KpJfeEXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ddn.com; dmarc=pass action=none header.from=ddn.com; dkim=pass
 header.d=ddn.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ddn.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zf4fnISRXOTPA0VuCMOnIqllrEWONX/tMFg3Ntfb7vo=;
 b=Xtwdu0ClPGHvkvzHZmmrAsl5vZacqu66mFdppaLvr3j4pR2IO0ifPIf/VZmd6Om9QIa/HYL1k+c7MCU+P0TeEfWSXk9ySao+0YdClgpsXDGcj6k0mVh0XftbdVSbELyvuHOP2Hy+cB2J7TpjokTd7q2uL1khcLbst5EFDpFtSTY=
Received: from DM5PR1901MB2037.namprd19.prod.outlook.com (2603:10b6:4:aa::29)
 by BL1PR19MB5866.namprd19.prod.outlook.com (2603:10b6:208:396::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.24; Fri, 24 Mar
 2023 22:44:16 +0000
Received: from DM5PR1901MB2037.namprd19.prod.outlook.com
 ([fe80::e6d4:29f7:2077:bd69]) by DM5PR1901MB2037.namprd19.prod.outlook.com
 ([fe80::e6d4:29f7:2077:bd69%4]) with mapi id 15.20.6086.024; Fri, 24 Mar 2023
 22:44:16 +0000
From:   Bernd Schubert <bschubert@ddn.com>
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Miklos Szeredi <miklos@szeredi.hu>
CC:     Dharmendra Singh <dsingh@ddn.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Amir Goldstein <amir73il@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: fuse uring / wake_up on the same core
Thread-Topic: fuse uring / wake_up on the same core
Thread-Index: AQHZXonZnrNnGQvxikaxtbJ88GLEB68Khz6A
Date:   Fri, 24 Mar 2023 22:44:16 +0000
Message-ID: <815c0490-cd34-26e8-fb14-bc1449b6784c@ddn.com>
References: <d0ed1dbd-1b7e-bf98-65c0-7f61dd1a3228@ddn.com>
In-Reply-To: <d0ed1dbd-1b7e-bf98-65c0-7f61dd1a3228@ddn.com>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=ddn.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM5PR1901MB2037:EE_|BL1PR19MB5866:EE_
x-ms-office365-filtering-correlation-id: d33a9d18-1761-4c1b-ddf2-08db2cb94c32
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: aG6XV9gUkjISZe4sNsa6H8WlQfMeKvKjNWB4qVHwbdjy0ZbbotclrqA6bSwKlN1kXKAWGCpPDpKQJoHtdmEYVjAJ1yQXnCfcRW1ylpLDijr7iK8gIpQq5XycyLOhQiN9kWpNv3KqqvWyOZToUnwAGASMfwVW/2lcxthSr3JzFUjAuBhYdqTxULZVu2poL7hon8iQZUz1DSlWT4zxyO+pNI8FeZPOADDZXn5Dej0po9BPdkx/wr5TWxQlGlIZtHsNPq/lgXjH84tH0q0Gpm9fjvhGIXUc38GhQUIVf2t/eS2krfJq24t5lJwqPSgJDcRWAywehWmcTIa3BrXgJ5OOnE7nFhXD3PhzqAt/QxDIIYfGJ3W7HtkVdfelGjaIRovtEAfiZfUR7vBoJbwm9v3IJ8RD9cTI2zTlSB6RpiDuaflmcPHopV7HT/oBgbBD6YalEwEDBqgwJJzuXKB5ZQlZHYMH3lNgR5CQOw/lvCJ1Dwk14QTjPUnLeaIZEyBQ6TS+YIMa7EEd6o68BU0p0UPioQWJ5ljIglxDNNuovJhG7NcWsAIvgmytmP3odINuu0+KfwLpnUXlAIoWalbmss7pPuWA0kjJEfEFDCXs4JVE8NsicTnktHUGq3e+I5lwAVCwzy2S6uHVsJIi40Fh6VUJWcd22x2UV8P3udm3ccgiDDA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR1901MB2037.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(376002)(366004)(346002)(39850400004)(136003)(451199021)(41300700001)(36756003)(186003)(966005)(4326008)(6486002)(6512007)(8936002)(122000001)(316002)(5660300002)(76116006)(38100700002)(54906003)(64756008)(2906002)(66446008)(66556008)(66946007)(2616005)(6506007)(38070700005)(91956017)(86362001)(71200400001)(31696002)(53546011)(478600001)(8676002)(110136005)(31686004)(66476007)(83380400001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZnBBVDdNZFh3c1Y4M1JkMDV5alRjU0tHRy9wUGdEWWRBRTJjdGJQclNmbEhU?=
 =?utf-8?B?WDh3YzFtQzJJaTdRNGdKTlBLL1lycGdXekJyVzBwRzRPQmhKL2tDVkJrVE94?=
 =?utf-8?B?Wm1LZDAzeVVLTFdXd1hScDA1Z0xWZER2eFBkWTdrWHN2Y2N1ams5YVRpN0J5?=
 =?utf-8?B?UkZpRFBlRXM2NDdFRmpVV2NzSFVialRGOXhXQVRBbUxPQk5QdEZvTVFRLysx?=
 =?utf-8?B?VGUyR0M2b3VUR0E2ejJxU2dkUm1RTzBGZnppL29hOFJ1M3J3TVluTUFjbnZ4?=
 =?utf-8?B?ZXVkRStHb3BpUXNYLy81bHY1UHlXR2hQdFppelZCRkQ0a2F4LzlKOVdkZ0NL?=
 =?utf-8?B?ajc1V1FnU0hnS3Y3K0lWL0hXNmFsNTgxbXFpRDdDa05RWkZFQ29sUWtTVEFh?=
 =?utf-8?B?Rjl2ckUzaFZId3AvcXNNOVBPNk9zblpkSDlOajhmYkdQd2FCZXFIMUtmQ3VW?=
 =?utf-8?B?dGhIREdvaWZaUjZSWDcxSFd3dGlrS0VEakd3eTFDV0ZxWG50NE9icitOdURI?=
 =?utf-8?B?Yk5YQWtaUmJlczJRZ2F0bm4rZkdoUUJPRmJEZ1VGc0tWYzhvalBmaTYrc0Yx?=
 =?utf-8?B?LzlVS0VkdVkyOHdWOGhnLzNoVG5iTnp4eDlOSDhGbjRZZEhhdGliMXkweW5G?=
 =?utf-8?B?VUVUdkF5OGZGMURMaTAxVDNmK1AwNWt4WUwrdytZVWFHY0pOcjBES3dvYmhR?=
 =?utf-8?B?ckM4V1BMdTNacXZ2MWh0NGhUNkp2dTlJYWxOZVlJUEF2UHpkWTBqMkVTbktv?=
 =?utf-8?B?azZzVVpNRzRuOUxSRlZ2M1ZyeUl2dWEyU0dlYkY0L0IyS1NobEdYSzdiMnhU?=
 =?utf-8?B?Y1JKWlkvMTZIUlZndGdIeUxtZ0kxQ2xlem0xTUlBaEJyekNmUWFHMmxGQ3Bq?=
 =?utf-8?B?SUpDN2VWckVUcTNkNlRLZE9ncVp4Mk1nYkJHT1h4NC9QL3BhTndqV2Nlcjlt?=
 =?utf-8?B?Y3hxUzRNUzZjRmd6OG9zNGdFV0ZYOXdUc0JmTkFDQU12dlBOcWk3THd2bmZK?=
 =?utf-8?B?bFk0S205aE9pK2IyNE5GNjA4NzBhZlJxeiswZEhJSjNuR29GRVpYRHBnSlJV?=
 =?utf-8?B?REJFSmYwQTVnQnUzYXR5TXFIZ3RpM3RTM0Vnam9aaU95UU91c3dHZlJmalM3?=
 =?utf-8?B?aVRXK2pjZ0gyMEVPSTVpRnRKUk9QOEcva2pvam0veUZTYldvQTkzQzRTdVJS?=
 =?utf-8?B?R3g3R1dyMkxxb29HM3BTS0lCODF4UHkrSjZVNExMSEJtQ05jVEtkQ0JmcXIw?=
 =?utf-8?B?dWlVUXkraS9ZMS94SUxTQzB0RWVNcWcrYnFoVjBUSmFFWHRrd1JJNzQ3bDZ6?=
 =?utf-8?B?SGlHR0duQ0dZV1lLOEs1OEloOXBaVm9pOU5RdlEyTzk4T3RDUHVKNkVLRThQ?=
 =?utf-8?B?ZzZGSWVxeVVuaFhNSElLMHpZc1RFanU5cnhDaXV5ckc4RmNWclZ2V0lDQStK?=
 =?utf-8?B?VzhsR21acmoyNmVvUTJ6TGdLRC9DbWZ5RDRyRCtwcHg0L3MvT3dHSkMyYXNu?=
 =?utf-8?B?b0FBWEJ3VUdPTlRpZmppRWp2SStQeEZVdkVZWUIzcTdUMmJiOW9RYVlIS0pP?=
 =?utf-8?B?L25ETEFJaXVWOTN6eE1VREhLK1JYdGdvc09ONHNwdkZlVUZ6SXZJNDhOVnBK?=
 =?utf-8?B?ZVpWWTdZVWovdUUrVndwRWc5K1VRYzd2S2tZOGM1VE9MOUhuOG5iZ2RpbFpk?=
 =?utf-8?B?VDNwRXdNaXV5SjE0eTZST2w5Z2dBUUVMV3VyeEhsMzhpV0JRemU4N2JXdmJm?=
 =?utf-8?B?SE9PZ0JpTEZPK1lCeEcrd2dWTVJyMlM3YlRqOVJFSWlrdC9ZTzVnQ3lRdXk4?=
 =?utf-8?B?MnFkWlhHZTNrUDAzZ3NOYWFIMGtwWEtsaEtUM1BlUjlDZ1JnV0lUN0tiNDdJ?=
 =?utf-8?B?cERBaVRKeFdCL1k3dlVGYU5JWXRodXA4aG9xekRSNHRNMXpnUHRZQmx6eUdG?=
 =?utf-8?B?Nkd3akZqM3VzY0g5N3lzY0lpVm5yMktPc1ZXS3RJR3VNeENFSEQ4ZEFyWG10?=
 =?utf-8?B?UHRIZWxINnBCYnNpN1NNalNkZi9nUGRFWkxHem16Z0ZCWTVKdW1BOW9EemNa?=
 =?utf-8?B?ZUI0KzJjUklidGtuaXNsZHR4RCs0a1RMZ2JkcmQrL3I4VURlZTNMOE0ySFA2?=
 =?utf-8?B?bVFXRW54TFBpaU93L1NNTjhqNWc4NDQwa2J1UzQ1OFNueFZJcTIwSEdrUVJR?=
 =?utf-8?Q?M/y6mZ+pdkx13xYll0/IzXI=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E6C2859DD98767429EBEDC1D55F4F0AA@namprd19.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: ddn.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR1901MB2037.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d33a9d18-1761-4c1b-ddf2-08db2cb94c32
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Mar 2023 22:44:16.1562
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: y7xxXlQAx0n2bHUwpAHEj21GIv+5u9R5Jw9f9MiDU8VTqPp/EQR31+5S4ETCkDj7wBAXRQ5NRpWqzcixIzGXLA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR19MB5866
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

T24gMy8yNC8yMyAyMDo1MCwgQmVybmQgU2NodWJlcnQgd3JvdGU6DQo+IEluZ28sIFBldGVyLA0K
PiANCj4gSSB3b3VsZCBsaWtlIHRvIGFzayBob3cgdG8gd2FrZSB1cCBmcm9tIGEgd2FpdHEgb24g
dGhlIHNhbWUgY29yZS4gSSBoYXZlIA0KPiB0cmllZCBfX3dha2VfdXBfc3luYygpL1dGX1NZTkMs
IGJ1dCBJIGRvIG5vdCBzZWUgYW55IGVmZmVjdC4NCj4gDQo+IEknbSBjdXJyZW50bHkgd29ya2lu
ZyBvbiBmdXNlL3VyaW5nIGNvbW11bmljYXRpb24gcGF0Y2hlcywgYmVzaWRlcyB1cmluZyANCj4g
Y29tbXVuaWNhdGlvbiB0aGVyZSBpcyBhbHNvIGEgcXVldWUgcGVyIGNvcmUuIEJhc2ljIGJvbm5p
ZSsrIGJlbmNobWFya3MgDQo+IHdpdGggYSB6ZXJvIGZpbGUgc2l6ZSB0byBqdXN0IGNyZWF0ZS9y
ZWFkKDApL2RlbGV0ZSBzaG93IGEgfjN4IElPUHMgDQo+IGRpZmZlcmVuY2UgYmV0d2VlbiBDUFUg
Ym91bmQgYm9ubmllKysgYW5kIHVuYm91bmQgLSBpLmUuIHdpdGggdGhlc2UgDQo+IHBhdGNoZXMg
aXQgX25vdF8gZnVzZS1kYWVtb24gdGhhdCBuZWVkcyB0byBiZSBib3VuZCwgYnV0IHRoZSBhcHBs
aWNhdGlvbiANCj4gZG9pbmcgSU8gdG8gdGhlIGZpbGUgc3lzdGVtLiBXZSBiYXNpY2FsbHkgaGF2
ZQ0KPiANCg0KWy4uLl0NCg0KPiBXaXRoIGxlc3MgZmlsZXMgdGhlIGRpZmZlcmVuY2UgYmVjb21l
cyBhIGJpdCBzbWFsbGVyLCBidXQgaXMgc3RpbGwgdmVyeSANCj4gdmlzaWJsZS4gQmVzaWRlcyBj
YWNoZSBsaW5lIGJvdW5jaW5nLCBJJ20gc3VyZSB0aGF0IENQVSBmcmVxdWVuY3kgYW5kIA0KPiBD
LXN0YXRlcyB3aWxsIG1hdHRlciAtIEkgY291bGQgdHVuZSB0aGF0IGl0IGluIHRoZSBsYWIsIGJ1
dCBpbiB0aGUgZW5kIEkgDQo+IHdhbnQgdG8gdGVzdCB3aGF0IHVzZXJzIGRvIChJIGhhZCByZWNl
bnRseSBjaGVja2VkIHdpdGggbGFyZ2UgSFBDIGNlbnRlciANCj4gLSBGb3JzY2h1bmdzemVudHJ1
bSBKdWVsaWNoIC0gdGhlaXIgSFBDIGNvbXB1dGUgbm9kZXMgYXJlIG5vdCB0dW5lZCB1cCwgDQo+
IHRvIHNhdmUgZW5lcmd5KS4NCj4gQWxzbywgaW4gb3JkZXIgdG8gcmVhbGx5IHR1bmUgZG93biBs
YXRlbmNpZXMsIEkgd2FudCB3YW50IHRvIGFkZCBhIA0KPiBzdHJ1Y3QgZmlsZV9vcGVyYXRpb25z
Ojp1cmluZ19jbWRfaW9wb2xsIHRocmVhZCwgd2hpY2ggd2lsbCBzcGluIGZvciBhIA0KPiBzaG9y
dCB0aW1lIGFuZCBhdm9pZCBtb3N0IG9mIGtlcm5lbC91c2Vyc3BhY2UgY29tbXVuaWNhdGlvbi4g
SWYgDQo+IGFwcGxpY2F0aW9ucyAod2l0aCBuLW50aHJlYWRzIDwgbi1jb3JlcykgdGhlbiBnZXQg
c2NoZWR1bGVkIG9uIGRpZmZlcmVudCANCj4gY29yZSBkaWZmZXJuZW50IHJpbmdzIHdpbGwgYmUg
dXNlZCwgcmVzdWx0IGluDQo+IG4tdGhyZWFkcy1zcGlubmluZyA+IG4tdGhyZWFkcy1hcHBsaWNh
dGlvbg0KPiANCj4gDQo+IFRoZXJlIHdhcyBhbHJlYWR5IGEgcmVsYXRlZCB0aHJlYWQgYWJvdXQg
ZnVzZSBiZWZvcmUNCj4gDQo+IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xrbWwvMTYzODc4MDQw
NS0zODAyNi0xLWdpdC1zZW5kLWVtYWlsLXF1aWNfcHJhZ2FsbGFAcXVpY2luYy5jb20vDQo+IA0K
PiBXaXRoIHRoZSBmdXNlLXVyaW5nIHBhdGNoZXMgdGhhdCBwYXJ0IGlzIGJhc2ljYWxseSBzb2x2
ZWQgLSB0aGUgd2FpdHEgDQo+IHRoYXQgdGhhdCB0aHJlYWQgaXMgYWJvdXQgaXMgbm90IHVzZWQg
YW55bW9yZS4gQnV0IGFzIHBlciBhYm92ZSwgDQo+IHJlbWFpbmluZyBpcyB0aGUgd2FpdHEgb2Yg
dGhlIGluY29taW5nIHdvcmtxIChub3QgbWVudGlvbmVkIGluIHRoZSANCj4gdGhyZWFkIGFib3Zl
KS4gQXMgSSB3cm90ZSwgSSBoYXZlIHRyaWVkDQo+IF9fd2FrZV91cF9zeW5jKCh4KSwgVEFTS19O
T1JNQUwpLCBidXQgaXQgZG9lcyBub3QgbWFrZSBhIGRpZmZlcmVuY2UgZm9yIA0KPiBtZSAtIHNp
bWlsYXIgdG8gTWlrbG9zJyB0ZXN0aW5nIGJlZm9yZS4gSSBoYXZlIGFsc28gdHJpZWQgc3RydWN0
IA0KPiBjb21wbGV0aW9uIC8gc3dhaXQgLSBkb2VzIG5vdCBtYWtlIGEgZGlmZmVyZW5jZSBlaXRo
ZXIuDQo+IEkgY2FuIHNlZSB0YXNrX3N0cnVjdCBoYXMgd2FrZV9jcHUsIGJ1dCB0aGVyZSBkb2Vz
bid0IHNlZW0gdG8gYmUgYSBnb29kIA0KPiBpbnRlcmZhY2UgdG8gc2V0IGl0Lg0KPiANCj4gQW55
IGlkZWFzPw0KPiANCg0KSG93IG11Y2ggb2YgaGFjayBpcyB0aGlzIHBhdGNoPw0KDQpbUkZDXSBm
dXNlOiB3YWtlIG9uIHRoZSBzYW1lIGNvcmUgLyBkaXNhYmxlIG1pZ3JhdGUgYmVmb3JlIHdhaXQN
Cg0KRnJvbTogQmVybmQgU2NodWJlcnQgPGJzY2h1YmVydEBkZG4uY29tPg0KDQpBdm9pZCBib3Vu
Y2luZyBjb3JlcyBvbiB3YWtlLCBlc3BlY2lhbGx5IHdpdGggdXJpbmcgZXZlcnl0aGluZw0KaXMg
Y29yZSBhZmZpbmUgLSBib3VuY2luZyBiYWRseSBkZWNyZWFzZXMgcGVyZm9ybWFuY2UuDQpXaXRo
IHJlYWQvd3JpdGUoL2Rldi9mdXNlKSBpdCBpcyBub3QgZ29vZCBlaXRoZXIgLSBuZWVkcyB0byBi
ZSB0ZXN0ZWQNCmZvciBuZWdhdGl2ZSBpbXBhY3RzLg0KLS0tDQogIGZzL2Z1c2UvZGV2LmMgfCAg
IDE2ICsrKysrKysrKysrKystLS0NCiAgMSBmaWxlIGNoYW5nZWQsIDEzIGluc2VydGlvbnMoKyks
IDMgZGVsZXRpb25zKC0pDQoNCmRpZmYgLS1naXQgYS9mcy9mdXNlL2Rldi5jIGIvZnMvZnVzZS9k
ZXYuYw0KaW5kZXggZTgyZGIxM2RhOGY2Li5kNDdiNmE0OTI0MzQgMTAwNjQ0DQotLS0gYS9mcy9m
dXNlL2Rldi5jDQorKysgYi9mcy9mdXNlL2Rldi5jDQpAQCAtMzcyLDEyICszNzIsMTcgQEAgc3Rh
dGljIHZvaWQgcmVxdWVzdF93YWl0X2Fuc3dlcihzdHJ1Y3QgZnVzZV9yZXEgKnJlcSkNCiAgCXN0
cnVjdCBmdXNlX2lxdWV1ZSAqZmlxID0gJmZjLT5pcTsNCiAgCWludCBlcnI7DQogIA0KKwkvKiBh
dm9pZCBib3VuY2luZyBiZXR3ZWVuIGNvcmVzIG9uIHdha2UgKi8NCisJcHJfZGV2ZWwoInRhc2s9
JXAgYmVmb3JlIHdhaXQgb24gY29yZTogJXUgd2FrZV9jcHU6ICV1XG4iLA0KKwkJIGN1cnJlbnQs
IHRhc2tfY3B1KGN1cnJlbnQpLCBjdXJyZW50LT53YWtlX2NwdSk7DQorCW1pZ3JhdGVfZGlzYWJs
ZSgpOw0KKw0KICAJaWYgKCFmYy0+bm9faW50ZXJydXB0KSB7DQogIAkJLyogQW55IHNpZ25hbCBt
YXkgaW50ZXJydXB0IHRoaXMgKi8NCiAgCQllcnIgPSB3YWl0X2V2ZW50X2ludGVycnVwdGlibGUo
cmVxLT53YWl0cSwNCiAgCQkJCQl0ZXN0X2JpdChGUl9GSU5JU0hFRCwgJnJlcS0+ZmxhZ3MpKTsN
CiAgCQlpZiAoIWVycikNCi0JCQlyZXR1cm47DQorCQkJZ290byBvdXQ7DQogIA0KICAJCXNldF9i
aXQoRlJfSU5URVJSVVBURUQsICZyZXEtPmZsYWdzKTsNCiAgCQkvKiBtYXRjaGVzIGJhcnJpZXIg
aW4gZnVzZV9kZXZfZG9fcmVhZCgpICovDQpAQCAtMzkxLDcgKzM5Niw3IEBAIHN0YXRpYyB2b2lk
IHJlcXVlc3Rfd2FpdF9hbnN3ZXIoc3RydWN0IGZ1c2VfcmVxICpyZXEpDQogIAkJZXJyID0gd2Fp
dF9ldmVudF9raWxsYWJsZShyZXEtPndhaXRxLA0KICAJCQkJCXRlc3RfYml0KEZSX0ZJTklTSEVE
LCAmcmVxLT5mbGFncykpOw0KICAJCWlmICghZXJyKQ0KLQkJCXJldHVybjsNCisJCQlnb3RvIG91
dDsNCiAgDQogIAkJc3Bpbl9sb2NrKCZmaXEtPmxvY2spOw0KICAJCS8qIFJlcXVlc3QgaXMgbm90
IHlldCBpbiB1c2Vyc3BhY2UsIGJhaWwgb3V0ICovDQpAQCAtNDAwLDcgKzQwNSw3IEBAIHN0YXRp
YyB2b2lkIHJlcXVlc3Rfd2FpdF9hbnN3ZXIoc3RydWN0IGZ1c2VfcmVxICpyZXEpDQogIAkJCXNw
aW5fdW5sb2NrKCZmaXEtPmxvY2spOw0KICAJCQlfX2Z1c2VfcHV0X3JlcXVlc3QocmVxKTsNCiAg
CQkJcmVxLT5vdXQuaC5lcnJvciA9IC1FSU5UUjsNCi0JCQlyZXR1cm47DQorCQkJZ290byBvdXQ7
DQogIAkJfQ0KICAJCXNwaW5fdW5sb2NrKCZmaXEtPmxvY2spOw0KICAJfQ0KQEAgLTQxMCw2ICs0
MTUsMTEgQEAgc3RhdGljIHZvaWQgcmVxdWVzdF93YWl0X2Fuc3dlcihzdHJ1Y3QgZnVzZV9yZXEg
KnJlcSkNCiAgCSAqIFdhaXQgaXQgb3V0Lg0KICAJICovDQogIAl3YWl0X2V2ZW50KHJlcS0+d2Fp
dHEsIHRlc3RfYml0KEZSX0ZJTklTSEVELCAmcmVxLT5mbGFncykpOw0KKw0KK291dDoNCisJbWln
cmF0ZV9lbmFibGUoKTsNCisJcHJfZGV2ZWwoInRhc2s9JXAgYWZ0ZXIgd2FpdCBvbiBjb3JlOiAl
dVxuIiwgY3VycmVudCwgdGFza19jcHUoY3VycmVudCkpOw0KKw0KICB9DQogIA0KICBzdGF0aWMg
dm9pZCBfX2Z1c2VfcmVxdWVzdF9zZW5kKHN0cnVjdCBmdXNlX3JlcSAqcmVxKQ0K

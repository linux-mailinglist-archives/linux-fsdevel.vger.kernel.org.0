Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C8976A79D4
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Mar 2023 04:14:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229600AbjCBDOg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 1 Mar 2023 22:14:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbjCBDOf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 1 Mar 2023 22:14:35 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2060b.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e88::60b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9D42A5C5;
        Wed,  1 Mar 2023 19:14:33 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ngs+9KyVbY0zkvvwOXfheIdS4EzCqgPxJkXtWkWHzKfEzxyaR/g0J/iKFsZiAAwhvt+XynrPAJeGlMKNNpuVVcLRr1I8C2RHufYxAN2MVYbJ1QSItjVgGYc0OVzjoOF3aaZgJUr+G91K5KPlglrhiQdghSEOm3UTZ+SvE0CLTeK5WiE3hqSxx5VusjHK/PW6ExpSU+us03nwmqbRqhuiQgd8eyKjVsjIJ4Ja0/PUqwNnUtRhs7Wj1t+TvZETqGmAFjjUm+yx7cwzVdk/BJDMCLFMDkK+66S3bCkW27KK1NA7mKB2Qc2oeWm3rpLvq7s72lIQr/iWXUHoqEcTt45gDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9Z1ehk39/mvQzrS31SCp38F/4fYfjxwfhmXgpnYF0Hc=;
 b=WX+1yShRDt3qhTiyEmNs31s0cq0SCqBXTpOKLZsI/maAYv8dHibwyeLQ5ilwUi+icOHDh9zpA9c/8QbSrVmBEOqUKkssg7KaJAyV1TqAVP1mmjjpqtLgkpDLt6vM2mu56gD1hcOKwEVJFWcsEV23X2JmSIts+yetE272gsT7FEWJpdNZKAcx0hAUr7Eh0t39LhJ/4Gt9oEZGLmSep5SAMJ/+Jf7MOiU+06kmtT0xR5yGtYhirwGo+2u/xe+k051enM/Ax1q9WdQQSyELMsepRkUnpEys9imPTLD0vYPgvxl++vhjMJ9b5ytPl00b0fUloBurMvMziJvI2Lj3fycIYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9Z1ehk39/mvQzrS31SCp38F/4fYfjxwfhmXgpnYF0Hc=;
 b=A8kGFLlTdgBtmJui3eBfejJUy2rM3XSt9p9Vfr6zk1haVH6eat42wUoJ/t0ZwBA1iCHIgyxlrB9oWHExKphghryAhEVhCU6K2CI/Ia5cNBINT10AgVOaQrinsVso+SoicQCPgxRa+Rp6IlPqo3RLzFmqLLeSmU6osuUf70LoV+TchV7uWUxD4f5VtPgJjVy1mduiCvMIpzJQolYQVSIIBE7bDlg4eft6PBExzl2QSyc5ggSb9UlkdF47A/dAGg7OeOW7jRLpJ9bF1wDfoNCTvox/d+njyZNNLWWFTDU4Q70q0lpE13/JzxFTfcW4YXXivuIRdg70tT7MKCfv5RjnOA==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by BL1PR12MB5238.namprd12.prod.outlook.com (2603:10b6:208:31e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.18; Thu, 2 Mar
 2023 03:13:25 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::4aaa:495:78b4:1d7c]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::4aaa:495:78b4:1d7c%3]) with mapi id 15.20.6134.026; Thu, 2 Mar 2023
 03:13:25 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Theodore Ts'o <tytso@mit.edu>,
        "lsf-pc@lists.linux-foundation.org" 
        <lsf-pc@lists.linux-foundation.org>
CC:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [LSF/MM/BPF TOPIC] Cloud storage optimizations
Thread-Topic: [LSF/MM/BPF TOPIC] Cloud storage optimizations
Thread-Index: AQHZS/E9Ay3hkXqJaEilH1+ZXggIX67m0geA
Date:   Thu, 2 Mar 2023 03:13:25 +0000
Message-ID: <cc51338a-15e7-4080-8228-53314441f0fa@nvidia.com>
References: <Y/7L74P6jSWwOvWt@mit.edu>
In-Reply-To: <Y/7L74P6jSWwOvWt@mit.edu>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW2PR12MB4667:EE_|BL1PR12MB5238:EE_
x-ms-office365-filtering-correlation-id: 8ef94177-90de-4a86-b8f7-08db1acc1679
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VIFjRqZw+/kJag7RUXlOMZVS8UUyO0mj01a4pxYc6bXVnCLySKHhn7xGoaaWLbg1MCiKAwBRH3MDAvwTg4AHxRtJq6C8g8gztDPY1F60CdDk7TLrYaO9/F8toVMn8E6TojamUXg1OlJuzhNMK5Dy0WRs9l01Z0Wf9MhL+9mR/41jA2utV4mrZpKZSWrPFzVCJY+5S5GIMS5ZVpDEodoltsXzgGBlBGmj7P/tFfIQUZWQvVtsqDy6cgLPpj/Pc57+/R9lFEL93+XbBhDKyi+P7HOvrNiYANiz+REgiLf2b/lgnEXQXzPXnzgdXFwNyrvyrG145RS83zUlVmVIvbJrqHAr7Jmf2REnw/JsRqMqeYUtaL1O5tYQb8nHQQF2QltkbgBFW7NCFj8tjn9N3xNtbPuxOnJGuz4DpNzdEpW76IpqI/Hwp7aQgUHkXtGOBdpBOM2qOC3GQkE4lvJ7RUC3cKso2x/RdftRDCKiqevHXx5pfICL67xYzSyxh3qnq2Oi5DDrvv22moxM3XEMKII1pVcAGTsEsZ4sMVy8F28ChnFBVBHikx/1C2XLeETjFrAKHz3HP3qNbSHgP28UygG7/LVz6qX8QsNdRt3dAAZN7hDPKmEcW1xLLFB4GmW2a3vyBjFo5BKETRXvy4nDOHBoVPgZILZxtNrlgI79/dsPSipYUBsyYeqaFm3+VYzcKVL6VTTfpo19Sxphe44/TgT9B6QAo0LiqBd2Tn2HIMnljYg8I0eW7LwXsLyifEnU85Pv6E2nrhkGtKaybEsdQgB2pw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(136003)(346002)(366004)(376002)(39860400002)(396003)(451199018)(316002)(122000001)(38100700002)(41300700001)(91956017)(66899018)(4326008)(8676002)(31686004)(66476007)(54906003)(76116006)(8936002)(110136005)(66446008)(66556008)(64756008)(66946007)(478600001)(5660300002)(71200400001)(36756003)(2906002)(6486002)(53546011)(38070700005)(86362001)(83380400001)(6506007)(186003)(2616005)(6512007)(31696002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SmU1RGhrRkVtZTM1MmRmeEpUVmVyMWZCYWovQnJNdmlxNlVMQTlPM0FVU2Fh?=
 =?utf-8?B?akRFa0p1bkd0T2NFTDc4QU1oK1VMMG43MnNKdGQ0eGpyaXlhZzFkUlNSZkVD?=
 =?utf-8?B?Y05OU0ZkNzZCNnNxNlpsaW1BWER1eTlpZlRibXdkYUNnTGd0dFpYVy92aGc4?=
 =?utf-8?B?aUlhSTFPWlA0SWszMzg1VE9KbmJxellwb25oUlYyMFRXNGNMeE1ic29vUUQy?=
 =?utf-8?B?VzRiSjA0b1pjRmZlcnpBemZXWUZ0RkxuZW4wOUx3MDg0d0V0L1RoRXN2NGNm?=
 =?utf-8?B?aWxVbU9Melp0ZGlKSitwRmdhSWlabmx1TDlUbGZhd0pWNm16a2Z0aTcyMUE4?=
 =?utf-8?B?aFFJc2w5M09UdktvTkR1YjJRbHBVRkh1eDAwMis1cDFaRiszaTNSZkJWUHEx?=
 =?utf-8?B?NHRJMzJrSy9ZdTI0VzFZVmRpQjVWWHpZU3RCbklEVk5WVGtYQ2ZyU3Y1OFkz?=
 =?utf-8?B?eTk4VUd3RUV4S0NIOEFGOVBtcjd3NmtDeEpvbjRYb0dKU0Jmcmtxc2NQWnI0?=
 =?utf-8?B?R1BsYmFPNjBUcWhpWXB4WUp1WnN3MkZKT1Q4dTZhVVpCSVZDd1luYWNHMmNm?=
 =?utf-8?B?TmViUVE1R3FCRlk1VWRKUU9wTlJoQnZsSmVCd0dsYkJhRmdua0phdXNibnJx?=
 =?utf-8?B?V3kvckxwdlZNeEx3ZFNmVXArTG5zZ216TDdjdnNTaEE1TDMyMGJJbjRJeEJZ?=
 =?utf-8?B?dytFTjRMZTQwVHZYVTJiT2JwMVNmNjNiWjlHUDdPenZBaFpJcTlWRlJOSEgv?=
 =?utf-8?B?bzZKOXp2ZldvZGpRb0V1MTN3ZmlFNjFBcCtTbk8xNXJwQUM4anFlTUxwTUdo?=
 =?utf-8?B?bThicTRZVkw3K1lUU2IzcTk2N09IblpUeGg5TEdHVmVEWGdMSldFaUNwWFB0?=
 =?utf-8?B?WEdheXRQTThTZkQzaEt5emU0bHdnZlY1SHJtaDViWmNpemVyWUc5RzRCUmxm?=
 =?utf-8?B?L2dLWUVUbnVpR21XSXlEL2RrODg5Qjk1Q3cwSnhsWVhIUy85eWtudWZEVWx3?=
 =?utf-8?B?aDNuYWd5YnRsRDI0a1kyaXJTWjN6VmVHVW5oRXlKbE14MU5JQ09aM3ZraXZ0?=
 =?utf-8?B?ZUNnNm80cDE1ajNSOWJjTWFEMVRHY25RU1d1OVB5RmUreGlUYjA3NGk0WnVs?=
 =?utf-8?B?V2RuellVdThOVjFWT0UwNEI3Q2RoM1VQZzlSL3FlRzF6K0RSaUlCaGFjNFov?=
 =?utf-8?B?MmxBT0FyZXN1dDRZNU9JTmo5ZjdZU09zUC9PaEN0bjdRbmVQRVAwU1lVb2w3?=
 =?utf-8?B?TGEyVWZwVDJTMDRGaXdid3d4dzJlQjQvakI5V2VaZUdEb0xpdXZzRVdXRXJE?=
 =?utf-8?B?V0M4SzZwc3dRaUVPZ0ZFYVJ0RzZOQ2hlR2cwRzYxV0ZCSEhUeGZaM0xRL1Q4?=
 =?utf-8?B?ME9NNEYxdUlCdGN0UENpM0hldjlhNit0MmtsRFdmMm40WEpwckxDNDVqNzNK?=
 =?utf-8?B?U2JreldON1BTNzgxT2lhZFM2dU5zc2J2VFJxU1dBRlZPOHFkc0R0ZHo2WTI4?=
 =?utf-8?B?SDYvTG9LdGlwazN1blQ4MUZoWnJxdHMrMjAwVm5TTUx6VFFCcnE0ZHpoQWsv?=
 =?utf-8?B?bm90OUY5Z3JlVVZ6NGhXMXpiRWdwUEFxVzhSVzdQRmYwNE42OElhZWcwY1pQ?=
 =?utf-8?B?V3J6WjdNVDc2Nk9hcjlzVGl1b3lvY1IxR3l6cXJwVzFMb1hhUEkyVHBacWJJ?=
 =?utf-8?B?LzFuVGEzRUE1ZXBGcWgzWFRESm11RnBZbENHb2lFSUVnZ0Z6NnhNQjd5SjBi?=
 =?utf-8?B?bUN0VnAycHAwQnN2VE12YVlyajMyTjREZW4yL1lRMWZ1UHcvSkpQUzRYb1ox?=
 =?utf-8?B?bnU2YlFzUWloVytJbXZsWHIzQlBLVFJKanRWVUNBY0pVY1lWZmxaUU42T3N3?=
 =?utf-8?B?Q2w4TjZoVzRIaGY5RkdlVmo2OGp3Ny9TTHhhcEZ1NVVTVmpzNGhQNmVOUFd2?=
 =?utf-8?B?TlplSDJzMU5PZld1TWo0L1l6dVBtY3RWUHRTN3dzQ3lsZnkvQXZuemp1M2NS?=
 =?utf-8?B?aGRJTVhkbk8rREFLUWpEWWFKZVlyK2RaTGZJNXQ4WlVua285Si9iKzEvSy9L?=
 =?utf-8?B?aU5BNFBBVGl4eUdtZUF2dm9VTFR2T0JYTUNBSklqUVdkd0lGRElaUy8zM0Rt?=
 =?utf-8?B?dzZXZ0pBc1EwT01sbTF4eGtKOVBqKzhaeHFWc1h2SUkrL1pmTjVxUkVNZkhm?=
 =?utf-8?Q?igWlgfI/AqNOKJZj2/t4WU1YT6+ctFQxsTM3noi7Mi5V?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A49CC8FA12A5C64EA57EE26C16516B81@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ef94177-90de-4a86-b8f7-08db1acc1679
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Mar 2023 03:13:25.5314
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pJyPG1dS0eQB3T9ftkbUxJSk8pRpppUW/l4yRMu1ouJB/xUTIIEMDvEcqVX2XqhyNIBNpkHVJyIy8EAsgb1cew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5238
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,SPF_HELO_PASS,SPF_NONE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

KCtsaW51eC1udm1lKQ0KDQpPbiAyLzI4LzIwMjMgNzo1MiBQTSwgVGhlb2RvcmUgVHMnbyB3cm90
ZToNCj4gRW11bGF0ZWQgYmxvY2sgZGV2aWNlcyBvZmZlcmVkIGJ5IGNsb3VkIFZN4oCZcyBjYW4g
cHJvdmlkZSBmdW5jdGlvbmFsaXR5DQo+IHRvIGd1ZXN0IGtlcm5lbHMgYW5kIGFwcGxpY2F0aW9u
cyB0aGF0IHRyYWRpdGlvbmFsbHkgaGF2ZSBub3QgYmVlbg0KPiBhdmFpbGFibGUgdG8gdXNlcnMg
b2YgY29uc3VtZXItZ3JhZGUgSEREIGFuZCBTU0TigJlzLiAgRm9yIGV4YW1wbGUsDQo+IHRvZGF5
IGl04oCZcyBwb3NzaWJsZSB0byBjcmVhdGUgYSBibG9jayBkZXZpY2UgaW4gR29vZ2xl4oCZcyBQ
ZXJzaXN0ZW50DQo+IERpc2sgd2l0aCBhIDE2ayBwaHlzaWNhbCBzZWN0b3Igc2l6ZSwgd2hpY2gg
cHJvbWlzZXMgdGhhdCBhbGlnbmVkIDE2aw0KPiB3cml0ZXMgd2lsbCBiZSBhdG9taWNhbGx5LiAg
V2l0aCBOVk1lLCBpdCBpcyBwb3NzaWJsZSBmb3IgYSBzdG9yYWdlDQo+IGRldmljZSB0byBwcm9t
aXNlIHRoaXMgd2l0aG91dCByZXF1aXJpbmcgcmVhZC1tb2RpZnktd3JpdGUgdXBkYXRlcyBmb3IN
Cj4gc3ViLTE2ayB3cml0ZXMuICBBbGwgdGhhdCBpcyBuZWNlc3NhcnkgYXJlIHNvbWUgY2hhbmdl
cyBpbiB0aGUgYmxvY2sNCj4gbGF5ZXIgc28gdGhhdCB0aGUga2VybmVsIGRvZXMgbm90IGluYWR2
ZXJ0ZW50bHkgdGVhciBhIHdyaXRlIHJlcXVlc3QNCj4gd2hlbiBzcGxpdHRpbmcgYSBiaW8gYmVj
YXVzZSBpdCBpcyB0b28gbGFyZ2UgKHBlcmhhcHMgYmVjYXVzZSBpdCBnb3QNCj4gbWVyZ2VkIHdp
dGggc29tZSBvdGhlciByZXF1ZXN0LCBhbmQgdGhlbiBpdCBnZXRzIHNwbGl0IGF0IGFuDQo+IGlu
Y29udmVuaWVudCBib3VuZGFyeSkuDQo+IA0KPiBUaGVyZSBhcmUgYWxzbyBtb3JlIGludGVyZXN0
aW5nLCBhZHZhbmNlZCBvcHRpbWl6YXRpb25zIHRoYXQgbWlnaHQgYmUNCj4gcG9zc2libGUuICBG
b3IgZXhhbXBsZSwgSmVucyBoYWQgb2JzZXJ2ZWQgdGhlIHBhc3NpbmcgaGludHMgdGhhdA0KPiBq
b3VybmFsaW5nIHdyaXRlcyAoZWl0aGVyIGZyb20gZmlsZSBzeXN0ZW1zIG9yIGRhdGFiYXNlcykg
Y291bGQgYmUNCj4gcG90ZW50aWFsbHkgdXNlZnVsLiAgVW5mb3J0dW5hdGVseSBtb3N0IGNvbW1v
biBzdG9yYWdlIGRldmljZXMgaGF2ZQ0KPiBub3Qgc3VwcG9ydGVkIHdyaXRlIGhpbnRzLCBhbmQg
c3VwcG9ydCBmb3Igd3JpdGUgaGludHMgd2VyZSByaXBwZWQgb3V0DQo+IGxhc3QgeWVhci4gIFRo
YXQgY2FuIGJlIGVhc2lseSByZXZlcnNlZCwgYnV0IHRoZXJlIGFyZSBzb21lIG90aGVyDQo+IGlu
dGVyZXN0aW5nIHJlbGF0ZWQgc3ViamVjdHMgdGhhdCBhcmUgdmVyeSBtdWNoIHN1aXRlZCBmb3Ig
TFNGL01NLg0KPiANCj4gRm9yIGV4YW1wbGUsIG1vc3QgY2xvdWQgc3RvcmFnZSBkZXZpY2VzIGFy
ZSBkb2luZyByZWFkLWFoZWFkIHRvIHRyeSB0bw0KPiBhbnRpY2lwYXRlIHJlYWQgcmVxdWVzdHMg
ZnJvbSB0aGUgVk0uICBUaGlzIGNhbiBpbnRlcmZlcmUgd2l0aCB0aGUNCj4gcmVhZC1haGVhZCBi
ZWluZyBkb25lIGJ5IHRoZSBndWVzdCBrZXJuZWwuICBTbyBiZWluZyBhYmxlIHRvIHRlbGwNCj4g
Y2xvdWQgc3RvcmFnZSBkZXZpY2Ugd2hldGhlciBhIHBhcnRpY3VsYXIgcmVhZCByZXF1ZXN0IGlz
IHN0ZW1taW5nDQo+IGZyb20gYSByZWFkLWFoZWFkIG9yIG5vdC4gIEF0IHRoZSBtb21lbnQsIGFz
IE1hdHRoZXcgV2lsY294IGhhcw0KPiBwb2ludGVkIG91dCwgd2UgY3VycmVudGx5IHVzZSB0aGUg
cmVhZC1haGVhZCBjb2RlIHBhdGggZm9yIHN5bmNocm9ub3VzDQo+IGJ1ZmZlcmVkIHJlYWRzLiAg
U28gcGx1bWJpbmcgdGhpcyBpbmZvcm1hdGlvbiBzbyBpdCBjYW4gcGFzc2VkIHRocm91Z2gNCj4g
bXVsdGlwbGUgbGV2ZWxzIG9mIHRoZSBtbSwgZnMsIGFuZCBibG9jayBsYXllcnMgd2lsbCBwcm9i
YWJseSBiZQ0KPiBuZWVkZWQuDQo+IA0K

Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AA0D63F74F
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Dec 2022 19:14:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231240AbiLASO2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 1 Dec 2022 13:14:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231206AbiLASOA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 1 Dec 2022 13:14:00 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2069.outbound.protection.outlook.com [40.107.223.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82EC627FD0;
        Thu,  1 Dec 2022 10:13:00 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aDbtp7emz/BpH+HGBZxTAiU/++P/Lm3hP2O58rEefDkW1/ouM4JFq4PXYpcKdhf1MrjRCikt2ARLwEb+8g7qeIVmfYn8qHEQdHEupJimqWS7MdXpvhgoFsaWjgu7ZaeVQ0jpx+erz5K+EEFtHlrisHi7gpe0y8RuBXGKkxHejKh9+fdWHLdhK4lgkAT2/mselkhIxmlfV5duhZsocXeEe2SeKdXPN67Q4BoD/DoFjTX4V45VplYRyOo7+dC+70XSCaTTQx2pCEfERv0B6qqxZlxR4fof4xhlBUx47L6mWD/Zd371WUuZSvXaSaZ4vsHgAWtV5wYjx/5ghhKoNlHMLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LFeIhMxz6Pw54+PcLnfu5+zWraGed7Ud1C6WSsguOdM=;
 b=i5DJdLn/am+alSZnfA+lT/S74ZCrX+eF1LsSMkRcH4R3fjFRJCAN3SrWrdpDv7B+otLEIZVg+i5JDzNXtalO7GrWXXJuh9unGV5Pvz0BRnj2FJeKjBzIV7C3heTizeA/4QxTxFhAMpfRm4l4dq+xjUJqdi5OG8qc4L7DawfXKfiQXE3fWOCMcmL5bKuZqT+9KDZ81UfLOoPmDqWnf+0TT8666s5Ab8/8Eqm90brMZhZrIoJTd97BiL3p3tZ1o9yQRl3PkxJ0ZiUNBMZNJy/yfnhSATt/jYCtrv6HM07Q2lJi4bZ67qAVRtN+pj18DiAvs5CE/+3+lQuPtoRVJjPBUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LFeIhMxz6Pw54+PcLnfu5+zWraGed7Ud1C6WSsguOdM=;
 b=G7Vo4VKBjwxWaQDW1pgE+ItIOrVqg7TbyV6ylCMjy3nDCQHhHj5hVymWCJK37KgQGhmHvQBkNpp1JDPiae11piaX2eLAeGjTV/3Y8fiBP1V9kLW4cZbkbwPjV+KAkIGkLlAonGFgvsV+5wrFMRCSCDldTpzcn80SDp2bo7b5/9YX2skztHVfEdnUI+W1NLUFJGGRIr0Xp+ZTuy/18V3PaeM8FuBqI69i5CySq3/6DcTadv/qGsKGDppyMLqytAUromZoLiQJlMPLcTpthlVRMNuVln+GN2l6wCfCQpQ3K/h9KZB0uAjoH+VdCMSDDqnuJG7WJcqt51x8mmQ13QrfFg==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by DM4PR12MB6590.namprd12.prod.outlook.com (2603:10b6:8:8f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.8; Thu, 1 Dec
 2022 18:12:47 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::f02:bf13:2f64:43bc]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::f02:bf13:2f64:43bc%7]) with mapi id 15.20.5880.008; Thu, 1 Dec 2022
 18:12:46 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Matthew Wilcox <willy@infradead.org>,
        Chaitanya Kulkarni <chaitanyak@nvidia.com>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-raid@vger.kernel.org" <linux-raid@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "djwong@kernel.org" <djwong@kernel.org>,
        "kbusch@kernel.org" <kbusch@kernel.org>, "hch@lst.de" <hch@lst.de>,
        "sagi@grimberg.me" <sagi@grimberg.me>,
        "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "javier@javigon.com" <javier@javigon.com>,
        "johannes.thumshirn@wdc.com" <johannes.thumshirn@wdc.com>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        "dongli.zhang@oracle.com" <dongli.zhang@oracle.com>,
        "jefflexu@linux.alibaba.com" <jefflexu@linux.alibaba.com>,
        "josef@toxicpanda.com" <josef@toxicpanda.com>,
        "clm@fb.com" <clm@fb.com>, "dsterba@suse.com" <dsterba@suse.com>,
        "jack@suse.com" <jack@suse.com>, "tytso@mit.edu" <tytso@mit.edu>,
        "adilger.kernel@dilger.ca" <adilger.kernel@dilger.ca>,
        "jlayton@kernel.org" <jlayton@kernel.org>,
        "idryomov@gmail.com" <idryomov@gmail.com>,
        "danil.kipnis@cloud.ionos.com" <danil.kipnis@cloud.ionos.com>,
        "ebiggers@google.com" <ebiggers@google.com>,
        "jinpu.wang@cloud.ionos.com" <jinpu.wang@cloud.ionos.com>
Subject: Re: [PATCH 0/6] block: add support for REQ_OP_VERIFY
Thread-Topic: [PATCH 0/6] block: add support for REQ_OP_VERIFY
Thread-Index: AQHYjGHN/dRfjWV95kG4kItzDx62xa1xpq+AgOihlAA=
Date:   Thu, 1 Dec 2022 18:12:46 +0000
Message-ID: <d14fe396-b39b-6b3e-ae74-eb6a8b64e379@nvidia.com>
References: <20220630091406.19624-1-kch@nvidia.com>
 <YsXJdXnXsMtaC8DJ@casper.infradead.org>
In-Reply-To: <YsXJdXnXsMtaC8DJ@casper.infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW2PR12MB4667:EE_|DM4PR12MB6590:EE_
x-ms-office365-filtering-correlation-id: 01cb81d1-21c3-40bd-210e-08dad3c7a651
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1Lvp111Ep6rYPP8k2+x3mwfcVFNZoc77o/vz5zhZyenNFD+qdOQ/WT+ejKV9+WkAu6wu0IJAerWTr+6web/syPo/KczED4Wp0U8FRD9aG37bjfq33rom7uClT2lSl9grvIa2BVvAXzwKW+WdoeLr+jkb1knhr9jZjSgyg9d5sjMJ756qT4nm+dQQiONijzsujiYb8F6YoWOaZGtIFYz9wC+iY6VEWmIhuZdXHtR8Oyp0VpOHB9zGVwqL6QeDdc3R12yN7uWIjjbvr7vlbGH998XoGHDJ+xYoMUBHZNcqrmIMS8kR6igqgptO+IDvP1Osk43M4AGwnB2YL9JmjSGK5Tw2ilOHEkdHAlIE2Ngu8M3zjuW+5tsGIia35PHXKrWCCo9iGzgg18ns80ws3k701e1iNB3QWN5KgbOE5IgoKD1p1cUUoYf95RNHnwItXMr4mUBfLFHs+QvsbxoMWaIztUy5rBc2q1V4E2RcFPB4hun2vOHrcfmzGasUI9mSD9rD5WSKbT3oZMyzqWuIv4YfR8O6N7I4+wcPJRC3qocz2iDqQK4wR2ZZE2mqJTSfqF64XO3mwEPyODaPfMNKwbTET37WvOtI5oEegBR4J7YoQKHxamziWD29Ua1AmaNpSg5S1a1zfkCXh2V/Xy5uQyeg1TQrj7yftNhLGE4JzZcy7GOOCPBXa5EdLcTTY6HY+DX/CsBgXDlS5Fb4zhGv7jbTrkzeyoh/PgSGqClFt/XlerxU48yrnIbtXUQfv7QwIO3w2AvcyfKFJFe5C9IW4JUcYQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(396003)(376002)(366004)(39860400002)(136003)(451199015)(38100700002)(110136005)(54906003)(316002)(71200400001)(122000001)(64756008)(38070700005)(36756003)(66446008)(91956017)(76116006)(4326008)(8676002)(66476007)(66946007)(66556008)(31696002)(2616005)(86362001)(6512007)(83380400001)(6486002)(478600001)(186003)(6506007)(53546011)(7416002)(31686004)(2906002)(8936002)(5660300002)(41300700001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MVE4d1RWWCtPQjJlcnFLUHZjSkVOTFZObDFpTnJZQTZSb1JVeXR5ZnM3RGo2?=
 =?utf-8?B?WUVQQ21rUFFodDVucmZVZzJnb2xGYW5BRHdMMTlvTkV6aVJnK09xNUNjWWZE?=
 =?utf-8?B?VlF3OEhnMXpuV0xwMkprNXJDb2t3S2c1bjNmcko4WE9yN0RiRUp0ZjI4Y2RH?=
 =?utf-8?B?S0tUVytGS1ZRbDI1OUYxZ2gzaDB4dzJndHpPL2xFN0Z0TVV1dURjVHhUTlVw?=
 =?utf-8?B?V0lXVW8zYXNIRGdwM3JubDdXUWNmd3ZsRnJOVGhUY09JSWNtYTh0Wk1qTVl4?=
 =?utf-8?B?azNvNGZyb01hOC9CSVNNUXJHN1lIRDdVS2dhNGhkcG9mRlMrZnhYaWViUjF2?=
 =?utf-8?B?VUUyK3k3bjIxRzZkeG9WRHY3SlJSYUMzSEh4QkNVcXE2NlkrY29STi93dlBQ?=
 =?utf-8?B?UEFBTG5wdTIvQldBdkN3VkxxTmlBK1RDNkR6SmdMSElMc3FVc0pTSDlRK1Ur?=
 =?utf-8?B?U3M0WklqN1JmUktzQ3BlOGxhMWZudUpYbEhGek0vOWlGc3VmSzN4Y2VsYVY0?=
 =?utf-8?B?bzBnMExxN0pUNWViL1Z5VHVZWG0zREt3SXZYZHJqT0N0RlR0RnZYQnpnSjdT?=
 =?utf-8?B?OVpnZFZPZjIzVURab01SbkI5eld6TjdPditZOG5JNC9ZVkRVWENWNTlxOHlW?=
 =?utf-8?B?M1ZZbDhLcHJRMnBPWmttd3JLUkRZVGdoNDNpUUV5NWdOM29vZDZrNkNsMy9m?=
 =?utf-8?B?dHlJbXVzSnRCbDl1TnhJR25jQlVDdW1QaVAvR0ZMZy9tbjVYMWtPamg5VVh0?=
 =?utf-8?B?dVFRV3laeWlyek5hNllwMllFODdPNnQ2eDJVZmUwZWtUMDhGcnJ5L1YyUG1C?=
 =?utf-8?B?TWJPWEtsZm9ZOHdiVlB5dlErcWI3SUVpeExUaVBFei9SUVRBcUd1T0dSeXg5?=
 =?utf-8?B?bm5CajBlcmF0SHJGY2laTmlJOXBXek1KY2xrNjBZSmlQZXlJcEdUUnp6bS9T?=
 =?utf-8?B?MCttVVJ3a2NXQ0FKbUZWSTVnK08zWXk1RVBnLzF2cGNzNEo5NW4xNjdTVTU0?=
 =?utf-8?B?a3NRVml2WHRHR3p0L1hqcU91c3BNNHJ6dUUvSlVoYnNaanl2YTJxWElwQzFx?=
 =?utf-8?B?d2s3UVpxaUFLM2VsVE8yblFpMnZNZSt6WVYyc1dRZUtvWVR5d0tFdGxXNnZm?=
 =?utf-8?B?WG0rTjJ5aFd0TjE4Y25XcmZFWVdxSlhmamxQSHU3ZGVyMVpjcGd5cHkzTURE?=
 =?utf-8?B?a0lvdDJBZ0J0OWdQWDEvTDlGM3h2ODVQL0pMMUw1V1B6MUEva2l6akVJUFlk?=
 =?utf-8?B?ZkU2Q1V3aHQyNVZUdlJCMzJ1aWJSUkVVUVAvYUcwN0cvbDlDU0JtNU9va0pZ?=
 =?utf-8?B?amVjblp6T3lIeFl6c1RURDlMZ2pMeVJiRWdsbXowako1YmtZMDl6VVJVemNo?=
 =?utf-8?B?ZjZaaVpVanJNOEtjVHNQeGlQNXNzdk1tTHlkWmQyU2VlTG5uUEM4ZDZkUWlv?=
 =?utf-8?B?SFk5NW40aGQvQ1krNmxJT2FFL2x1TWlRekFTWm9qdHNmWjVMSTAvOFBrWVZC?=
 =?utf-8?B?TGV4WVBuSmpKRG9kMFJsT1k3eE5vREt0anNtSVBXYjF1NmVKV1pMZVNMU0pn?=
 =?utf-8?B?REVIZkY3M0FJQWNodER2UlcwOERISVl2NTFBSDlrSGYxckdSTE5UMVF3Vm42?=
 =?utf-8?B?RGlYbDVpWll3WWN0NXdralE5TGFOZStSR3dBM200WFM0cjJ6aldzNE9lcUVw?=
 =?utf-8?B?RGtoblcrVmxwc2dCcFo3dzZCU2ZwcURPMG5OdThGTTNrWVNNNjJBWXNBYjNq?=
 =?utf-8?B?VDZRelowYlRaNDdIUll3Zm11YllTYVlrcG9WdlR6NzR4OEJMcE5Vc25FNHgx?=
 =?utf-8?B?WTZKYVVOMENSMG9Ed1NaWWNpMW5obXRLTGwrMkM5Q2tkajREUlROTHZ0bkNl?=
 =?utf-8?B?R2xNZENiZkxxSG9hUHM3M1JBV1RVVlY5NGYwQWMrWU5EYWc0OW8xNkoxZ2o0?=
 =?utf-8?B?QzJjN0djQXJubFM5ZlVRcWRPbjJxMm50ZW5PaGxFTTd1Z1p1dFd4Z2w4MDZq?=
 =?utf-8?B?NVA4c3hOL0dwakc1UmRBNEsxUlYrYVk1ZVRHL2hsaWQreXQ1WXluaU9lUzJ6?=
 =?utf-8?B?Y0NXWDJDaE5RZVpST3ZpV0JyZnpWT0VnQ2svZkVjM0NtMzZRdStzVmd4OEYw?=
 =?utf-8?B?M1RkeTI3ME5wSkdYNUtBUTVyOFNHckFMK0ZhamlIaStsRWR1dFpSUTBlTWlK?=
 =?utf-8?B?dEE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9125E06BAA8B0D46B10C9AD30E7B7E06@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01cb81d1-21c3-40bd-210e-08dad3c7a651
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Dec 2022 18:12:46.8321
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: H1GOb7Cce41ik8bR5PXJWB02eoJjPV41wFjFakpm8ZVEpz08bIIFag2HOlpM/MOHzPrv2QzwRUpc4OQWcmKPAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6590
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

T24gNy82LzIyIDEwOjQyLCBNYXR0aGV3IFdpbGNveCB3cm90ZToNCj4gT24gVGh1LCBKdW4gMzAs
IDIwMjIgYXQgMDI6MTQ6MDBBTSAtMDcwMCwgQ2hhaXRhbnlhIEt1bGthcm5pIHdyb3RlOg0KPj4g
VGhpcyBhZGRzIHN1cHBvcnQgZm9yIHRoZSBSRVFfT1BfVkVSSUZZLiBJbiB0aGlzIHZlcnNpb24g
d2UgYWRkDQo+IA0KPiBJTU8sIFZFUklGWSBpcyBhIHVzZWxlc3MgY29tbWFuZC4gIFRoZSBoaXN0
b3J5IG9mIHN0b3JhZ2UgaXMgZnVsbCBvZg0KPiBkZXZpY2VzIHdoaWNoIHNpbXBseSBsaWUuICBT
aW5jZSB0aGVyZSdzIG5vIHdheSBmb3IgdGhlIGhvc3QgdG8gY2hlY2sgaWYNCj4gdGhlIGRldmlj
ZSBkaWQgYW55IHdvcmssIGNoZWFwIGRldmljZXMgbWF5IHNpbXBseSBpbXBsZW1lbnQgaXQgYXMg
YSBOT09QLg0KDQpJbiBwYXN0IGZldyBtb250aHMgYXQgdmFyaW91cyBzdG9yYWdlIGNvbmZlcmVu
Y2VzIEkndmUgdGFsa2VkIHRvDQpkaWZmZXJlbnQgcGVvcGxlIHRvIGFkZHJlc3MgeW91ciBjb21t
ZW50IHdoZXJlIGRldmljZSBiZWluZw0KYSBsaWFyIHZlcmlmeSBpbXBsZW1lbnRhdGlvbiBvciBl
dmVuIGltcGxlbWVudGluZyBOT09QLg0KDQpXaXRoIGFsbCBkbyByZXNwZWN0IHRoaXMgaXMgbm90
IHRydWUuDQoNClZlcmlmeSBjb21tYW5kIGZvciBOVk1lIGhhcyBzaWduaWZpY2FudCBpbXBhY3Qg
d2hlbiBpdCBjb21lcyB0byBkb2luZyANCnRoZSBtYWludGVuYW5jZSB3b3JrIGluIGRvd250aW1l
LCB0aGF0IGNhbiBnZXQgaW4gYSB3YXkgd2hlbiBkZXZpY2UgaXMgDQp1bmRlciBoZWF2eSB3b3Jr
bG9hZCBlLmcuIHNvY2lhbCBtZWRpYSB3ZWJzaXRlIGJlaW5nIGFjdGl2ZSBhdCBwZWFrIA0KaG91
cnMgb3IgaGlnaCBwZXJmb3JtYW5jZSB0cmFkaW5nIGhvdXJzLiBJbiBzdWNoIGEgc2NlbmFyaW8g
Y29udHJvbGxlciANCmRvaW5nIHRoZSBtYWludGVuYW5jZSB3b3JrIGNhbiBpbmNyZWFzZSB0aGUg
dGFpbCBsYXRlbmN5IG9mIHRoZSB3b3JrbG9hZA0KYW5kIG9uZSBjYW4gc2VlIHNwaWtlcyBhcyBT
U0Qgc3RhcnRzIGFnaW5nLCB0aGlzIGlzIGFsc28gdHJ1ZSBmb3INCnRoZSBmaWxlIHN5c3RlbXMg
YW5kIGRhdGFiYXNlcyB3aGVuIGNvbXBsZXggcXVlcmllcyBnZW5lcmF0aW5nDQpjb21wbGV4IEkv
TyBwYXR0ZXJucyB1bmRlciBhIGhlYXZ5IEkvT3MuDQoNCkkgcmVzcGVjdCB5b3VyIGV4cGVyaWVu
Y2UgYnV0IGNhbGxpbmcgZXZlcnkgc2luZ2xlIFNTRCBhbmQgZW50ZXJwcmlzZQ0KZ3JhZGUgU1NE
IHZlbmRvciBhIGxpYXIgaXMganVzdCBub3QgdHJ1ZSwgYXMgd2l0aCBlbnRlcnByaXNlIFNTRA0K
cXVhbGlmaWNhdGlvbiBwcm9jZXNzIGlzIGV4dHJlbWVseSBkZXRhaWxlZCBvcmllbnRlZCBhbmQg
ZWFjaCBmZWF0dXJlDQpjb21tYW5kIGdldHMgZXhjcnVjaWF0aW5nIGRlc2lnbiByZXZpZXcgaW5j
bHVkaW5nIHBlcmZvcm1hbmNlL3dhdHQuDQoNClNvIG5vYm9keSBjYW4gZ2V0IGF3YXkgd2l0aCBh
IGxpZS4NCg0KVGhpcyBwYXRjaC1zZXJpZXMgaGFzIGFuIG9wdGlvbiB0byBlbXVsYXRlIHRoZSB2
ZXJpZnkgb3BlcmF0aW9uLA0KaWYgeW91IG9yIHNvbWVvbmUgZG9uJ3Qgd2FudCB0byB0cnVzdCB0
aGUgZGV2aWNlIG9uZSBjYW4gc2ltcGx5IHR1cm4NCm9mZiB0aGUgdmVyaWZ5IGNvbW1hbmQgYW5k
IGxldCB0aGUga2VybmVsIGVtdWxhdGUgdGhlIFZlcmlmeSwgdGhhdA0Kd2lsbCBhbHNvIHNhdmUg
dG9uIG9mIHRoZSBiYW5kd2lkdGggZXNwZWNpYWxseSBpbiB0aGUgY2FzZSBvZiBmYWJyaWNzDQph
bmQgaWYgaXQgaXMgbm90IHRoZXJlIEknbGwgbWFrZSBzdXJlIHRvIGhhdmUgaW4gdGhlIGZpbmFs
IHZlcnNpb24uDQoNCj4gRXZlbiBleHBlbnNpdmUgZGV2aWNlcyB3aGVyZSB0aGVyZSdzIGFuIGly
b25jbGFkIGxlZ2FsIGNvbnRyYWN0IGJldHdlZW4NCj4gdGhlIHZlbmRvciBhbmQgY3VzdG9tZXIg
bWF5IGhhdmUgYnVncyB0aGF0IHJlc3VsdCBpbiBvbmx5IHNvbWUgb2YgdGhlDQo+IGJ5dGVzIGJl
aW5nIFZFUklGWWVkLiAgV2Ugc2hvdWxkbid0IHN1cHBvcnQgaXQuDQo+IA0KDQpPbmUgY2Fubm90
IHNpbXBseSB3cml0ZSBhbnl0aGluZyB3aXRob3V0IGJ1Z3MsIHNlZSBob3cgbWFueSBxdWlya3Mg
d2UNCmhhdmUgZm9yIHRoZSBOVk1lIFBDSWUgU1NEcyB0aGF0IGRvZXNuJ3Qgc3RvcCB1cyBzdXBw
b3J0aW5nIGZlYXR1cmVzDQppbiBrZXJuZWwgaWYgb25lIGNhbid0IHRydXN0IHRoZSBkZXZpY2Ug
anVzdCBhZGQgYSBxdWlyayBhbmQgZW11bGF0ZS4NCg0KVGhlIGJ1Z3MgZG9lc24ndCBtYWtlIHRo
aXMgZmVhdHVyZSB1c2VsZXNzIG9yIGRlc2lnbiBvZg0KdGhlIHZlcmlmeSBjb21tYW5kIHVudXNh
YmxlLiBUaGVyZSBpcyBhIHNpZ25pZmljYW50IHJlYXNvbiB3aHkgaXQNCmV4aXN0cyBpbiBtYWpv
ciBkZXZpY2Ugc3BlY3MgYmFzZWQgb24gd2hpY2ggZGF0YS1jZW50ZXIgd29ya2xvYWRzDQphcmUg
cnVubmluZywganVzdCBiZWNhdXNlIHRoZXJlIGFyZSBmZXcgY2hlYXAgdmVuZG9ycyBub3QgYmVp
bmcNCmF1dGhlbnRpYyB3ZSBjYW5ub3QgY2FsbCBtdWx0aXBsZSBUV0cncyBkZWNpc2lvbiB0byBh
ZGQgdmVyaWZ5DQpjb21tYW5kIHVzZWxlc3MgYW5kIG5vdCBhZGQgc3VwcG9ydC4NCg0KSW4gZmFj
dCBhbGwgdGhlIGZpbGUgc3lzdGVtcyBzaG91bGQgYmUgc2VuZGluZyB2ZXJpZnkgY29tbWFuZCBh
cw0KYSBwYXJ0IG9mIHNjcnViYmluZyB3aGljaCBYRlMgb25seSBkb2VzIGFzIGZhciBhcyBJIGtu
b3cgc2luY2UNCmxhY2sgb2YgaW50ZXJmYWNlIGlzIHByZXZlbnRpbmcgdGhlIHVzZS4NCg0KPiBO
b3csIGV2ZXJ5dGhpbmcgeW91IHNheSBhYm91dCBpdHMgdmFsdWUgKG5vdCBjb25zdW1pbmcgYnVz
IGJhbmR3aWR0aCkNCj4gaXMgdHJ1ZSwgYnV0IHRoZSBkZXZpY2Ugc2hvdWxkIHByb3ZpZGUgdGhl
IGhvc3Qgd2l0aCBwcm9vZi1vZi13b3JrLg0KPiBJJ2Qgc3VnZ2VzdCBjYWxjdWxhdGluZyBzb21l
IGtpbmQgb2YgY2hlY2tzdW0sIGV2ZW4gc29tZXRoaW5nIGxpa2UgYQ0KPiBTSEEtMSBvZiB0aGUg
Y29udGVudHMgd291bGQgYmUgd29ydGggaGF2aW5nLiAgSXQgZG9lc24ndCBuZWVkIHRvIGJlDQo+
IGNyeXB0by1zZWN1cmU7IGp1c3Qgc29tZXRoaW5nIHRoZSBob3N0IGNhbiB2ZXJpZnkgdGhlIGRl
dmljZSBkaWRuJ3Qgc3Bvb2YuDQoNCkknbSBub3Qgc3VyZSBob3cgU1NEIHZlbmRvciB3aWxsIGVu
dGVydGFpbiB0aGUgcHJvb2Ygb2Ygd29yaw0KaWRlYSBzaW5jZSBpdCB3aWxsIG9wZW4gdGhlIGRv
b3IgZm9yIG90aGVyIHF1ZXN0aW9ucyBzdWNoIGFzIGRpc2NhcmQgYW5kDQphbnkgb3RoZXIgY29t
bWFuZHMgc2luY2Ugb25lIG9mIHRoZSBibGF0YW50IGFuc3dlciBJIGdvdCAiaWYgeW91IGRvbid0
DQp0cnVzdCBkb24ndCBidXkiLg0KDQpJJ20gYWJzb2x1dGVseSBub3QgZGlzY2FyZGluZyB5b3Vy
IGNvbmNlcm5zIGFuZCBpZGVhIG9mIHByb29mIG9mIHdvcmssDQpJJ20gd2lsaW5nIHRvIHdvcmsg
d2l0aCB5b3UgaW4gdGhlIFRXRyBhbmQgc3VibWl0IHRoZSBwcm9wb3NhbA0Kb2ZmbGluZSwgYnV0
IHJpZ2h0IG5vdyB0aGVyZSBpcyBubyBzdXBwb3J0IGZvciB0aGlzIHdpdGggZXhpc3RpbmcNCnNw
ZWNzLg0KDQotY2sNCg0K

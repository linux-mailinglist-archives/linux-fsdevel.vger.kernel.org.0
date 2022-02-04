Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20C1E4A929F
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Feb 2022 04:12:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356743AbiBDDMn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 3 Feb 2022 22:12:43 -0500
Received: from mail-sn1anam02on2050.outbound.protection.outlook.com ([40.107.96.50]:10820
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234466AbiBDDMm (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 3 Feb 2022 22:12:42 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZSeepnwT/s+Ddm+NAC5wZGOlHaf+pSaKRg9TjcJj/LdkifyWSA7iX2hqd7Hk6SXcXa2LfT+oIxSsjjr2R93GKfgL9RLGTj6K2slrucokm7rPOtHo7pfVD23IjZCyY4LMHSsZKFtP52Z9tEJKb+TkK8g07I8aj9WeOvPh0KEC/hYONPhnkOOBjgyiPt8SD/Emh7ms+UyrAQ/JW6t0BbvdZ3XKJGLKHxX5y5FVQpJU7iRb7curMjF/aLL65IWsqp/Ms+AvyCQY0Rcj8/q35GIsd8nWTQd5rUDEnx3m2bxVI/oXIOxUlM1Rnlgc90jZMJ9XeIwA5Ebk2XpNpLXKBq1AxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wvZunsXGqZ2vLUb7UrS9IzoH488om251cquAqOdIKLM=;
 b=cgKF3QJLlKbH2w4gXYhve9jRpdhdvYQkfil0txyq+pmMXb2y+w8Bgl2zoSeqbpiZdINw4oe9W0T5SxJc8OXHqU2QclFEmTX4QAPcXVHT/Vb0Aq8WVr/n851IYplriMzytmoSfdxLoE+jbWXRpYEo9B8mI9ezNEkO8iZElDgZa8lHa4CWwf8cm43HfJ6gAJsRolk+AEXPQ+Bv+bYVbfvskkhOSThc2wLDgHdpCw9SHF/AIAuHk1yV2xzPyEwOmUxhA/R7pUjmiZSZNwJmzNB6CQTzjy5WwQ6aIQxTi7i5zaycq09oCbdcBob4w+TVfJr9fO1J1XF0XbUEaN5I1nXsJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wvZunsXGqZ2vLUb7UrS9IzoH488om251cquAqOdIKLM=;
 b=hSUVM10qOqadFg8pMFR8/+Xt1EecAYHKXgKhLjiqzesbHWasvbnEocF3TnDCifRJdJsGJNTk8NQaFagCOpLHQclrjNlGDcuYJZdj51K07W66qK1NCcjffpcZK+iCMeWWbSAR3kvrsnL77HU/ou4rpC1ZbsVok9OmG4r9AQQz9jJ0zadBnCviRWIcqjKqZMhaHYrJMqEhP45JW5iJNNAdEo0KOJJ+ICcEc+5wbsd5X180PXix9ayG1t65vnEYiZh9M8paZNwTq4ALGa7+Mc8m16qCAx40pCLkGb3g6dzcusBKOSMQONMr+pFN9osrXjuCY5q3DDC65Xwez++5oq+Cew==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by BYAPR12MB3096.namprd12.prod.outlook.com (2603:10b6:a03:ad::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12; Fri, 4 Feb
 2022 03:12:40 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::846c:d3cd:5a30:c35]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::846c:d3cd:5a30:c35%5]) with mapi id 15.20.4951.014; Fri, 4 Feb 2022
 03:12:40 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Adam Manzanares <a.manzanares@samsung.com>
CC:     Luis Chamberlain <mcgrof@kernel.org>,
        Mikulas Patocka <mpatocka@redhat.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Keith Busch <kbusch@kernel.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        =?utf-8?B?SmF2aWVyIEdvbnrDoWxleg==?= <javier@javigon.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        "msnitzer@redhat.com >> msnitzer@redhat.com" <msnitzer@redhat.com>,
        Bart Van Assche <bvanassche@acm.org>,
        "martin.petersen@oracle.com >> Martin K. Petersen" 
        <martin.petersen@oracle.com>,
        "roland@purestorage.com" <roland@purestorage.com>,
        Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>,
        "Frederick.Knight@netapp.com" <Frederick.Knight@netapp.com>,
        "zach.brown@ni.com" <zach.brown@ni.com>,
        "osandov@fb.com" <osandov@fb.com>,
        "lsf-pc@lists.linux-foundation.org" 
        <lsf-pc@lists.linux-foundation.org>,
        "djwong@kernel.org" <djwong@kernel.org>,
        "josef@toxicpanda.com" <josef@toxicpanda.com>,
        "clm@fb.com" <clm@fb.com>, "dsterba@suse.com" <dsterba@suse.com>,
        "tytso@mit.edu" <tytso@mit.edu>, "jack@suse.com" <jack@suse.com>,
        Kanchan Joshi <joshi.k@samsung.com>
Subject: Re: [RFC PATCH 3/3] nvme: add the "debug" host driver
Thread-Topic: [RFC PATCH 3/3] nvme: add the "debug" host driver
Thread-Index: AQHYF5pGTuc0vK6aW0WDOYv4vbM4lKx/5pmAgAIScYCAABSnAIAAMdEAgAB7aoA=
Date:   Fri, 4 Feb 2022 03:12:40 +0000
Message-ID: <863d85e3-9a93-4d8c-cf04-88090eb4cc02@nvidia.com>
References: <f0e19ae4-b37a-e9a3-2be7-a5afb334a5c3@nvidia.com>
 <20220201102122.4okwj2gipjbvuyux@mpHalley-2>
 <alpine.LRH.2.02.2202011327350.22481@file01.intranet.prod.int.rdu2.redhat.com>
 <alpine.LRH.2.02.2202011333160.22481@file01.intranet.prod.int.rdu2.redhat.com>
 <270f30df-f14c-b9e4-253f-bff047d32ff0@nvidia.com>
 <20220203153843.szbd4n65ru4fx5hx@garbanzo>
 <CGME20220203165248uscas1p1f0459e548743e6be26d13d3ed8aa4902@uscas1p1.samsung.com>
 <20220203165238.GA142129@dhcp-10-100-145-180.wdc.com>
 <20220203195155.GB249665@bgt-140510-bm01>
In-Reply-To: <20220203195155.GB249665@bgt-140510-bm01>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 59907c04-becb-4258-055c-08d9e78c33ee
x-ms-traffictypediagnostic: BYAPR12MB3096:EE_
x-microsoft-antispam-prvs: <BYAPR12MB3096E2E1137FC138265F688AA3299@BYAPR12MB3096.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bWP0zAl0cseiTGfVM/bOonE4Y/3fo5bTNAxmXqncir1ImSIFHt0DKfaZ5O0QiDby3sUEmnD8KeJiTg6VquMBTjgtHE7wViPm0R4pO++wuvYKvYDvGei9Y5y+kqEioQ/JDmXO7mnC/U1W1pwVuuKQ0em5DjUWwMuoooWEczaemme43VenIh9XGbh0wDIPSJqIyG45GAfPeQOnvPlAV+jcKR7rqDytE3i+g7gOwr5CAOme5X02dn2eAYe8rtoaevKz5fQxVkZmQ0/6ejT6T20l7gu7ThUVeEMUFYXenua75ANW0lkPwUGeWtFlCncMlzwbiY01rXZzHoeJJmPUm2nBacwnSV/h3fMybxCvYEwNK1G4QPW/Tm6rfQNVMEkC/nNq4400m3YhPFxUgepE0r9cxuGvSHbSw1szjm0Syj110lkCv8dYAHpNR0lt0G0ZEpO6EEA0j3cFiTA3HitLYrlRTSsOn+8pUdH2j7osMUz3U6RNyNrrF6HYapOvHnvonh630AQZGKUxpJrRddQysCAXFabYh4jyWaSffwNPwe2nfn7cU9n3NUoM/hTOZBXdMvYAMbSok5E5jqebSJVG3iDyJym39+5CCYTBG2VaUaIPOYi6p5gZ6mBs9rPpuOLYwJ8lgVEJmS1HEYittT1/GMYe0w8CFf257OF+ouP2hy6oRIS6XyNAlblSfpHA5hrvahk89vYF/wCa6UHMlh8MD7+WOj9G9OwNkQj6k6EmwmV+JyRxBpAsedGAagLmejEV67tLDMRJAe8kLGMfi4l8YEe+0A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(71200400001)(186003)(38100700002)(6506007)(6512007)(508600001)(2616005)(6486002)(38070700005)(122000001)(2906002)(316002)(31696002)(54906003)(83380400001)(66446008)(91956017)(5660300002)(86362001)(66946007)(8676002)(76116006)(31686004)(7416002)(6916009)(4744005)(36756003)(4326008)(8936002)(66476007)(66556008)(64756008)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?K0E2UHc3eGV1MkZFUm1nejZZUm11eGJGTVNGZUtudWd5WlJ2QjJVOVhDZmVU?=
 =?utf-8?B?UVRoUDRhR3pBZ0RYUUJSSnM4bkVaakdEMTk5UzUrNHArbzA4U1BmTjZsMmRz?=
 =?utf-8?B?RWRsOXV3OEx4dE1uVjI2dGpyek5wa01QL05yMjNMemRxYzMvL2d6WEc4MUp0?=
 =?utf-8?B?UGhmOUZsSmc5M2lrcnhya0xsN0k2MTZXVTNyNC9Sa2Q1SzdtUU5xVXgrODRo?=
 =?utf-8?B?emEwd2V5VS9KdlViSTRKa0YyRWFMVXMwNjRNbFh6dkV5ZmJTRkxmd24yeVp4?=
 =?utf-8?B?QTVNN3hjc3JqNFI4bmVlVGhqemhWeWNkMGF5V1NPaFIvVldCSHRSUGsyWkdV?=
 =?utf-8?B?TEUxK0RWV2RBaDNac2R6ZkFsb1ZvRWpmQlRMbU9iSjZ5UGxiQlNWc1l4aEk5?=
 =?utf-8?B?aUNBU25KSW1paXZQVTk5YlQxZFhQd2ZWYmpDS2hBL0gveUZQVVFkZU8vSm9R?=
 =?utf-8?B?am16R1gvc2lMRzNiUmwwaHcvSXJPSTdiZVpwWk40TXZ4NVA5VE52aUY3Y2ZF?=
 =?utf-8?B?aE91cStoUGhEK1BDSFZZK3ZzbzN2dW8xQlpyaGlwWXZyaldBVy9SVmhtbGpN?=
 =?utf-8?B?MnMrYnhRQzlkMFlBc0RraHlDUjFiTk1YMUJuNFpnNSs2YUk4ZEkxZFkrVURk?=
 =?utf-8?B?VHhVTDhjaTEycG9YOG1aajV6OE9MaVVQSlRwaFhtb2VLMU5panoyZXdVd1RX?=
 =?utf-8?B?OURLai9wWEtieXZuK3hQOTVKQ3JvTmlEWkF6YmxKR0xYZzlRL0VMNjBsc3ZZ?=
 =?utf-8?B?aDdmZ21xOXFMbkxzTzlSRHQvTXAvVjZwRTNwSTdERFlob0t1emtyeTV0T3J2?=
 =?utf-8?B?a09HZVVzUmxxL1FROW1EdnlKenhDc2E2K2poMjRiWlZPZGFLTUlYaVIxRkpQ?=
 =?utf-8?B?Z1hpZlh6bWIwUlIrSWRNYVZSeERWUUxlZjhWd1hPZ0xRRVB6MUlFZ1JaTG9Y?=
 =?utf-8?B?c1RFOWwzcklLamExOTZBbTFoWmRJbHBIamhPcm1GM0I1OGFidkdtRzM5bzd5?=
 =?utf-8?B?cFJ0ZEZzSW9tSlRQTXh0WUJ0blFNb3hqRUZMTWYzS005WFF5QktUQ3hKeWFy?=
 =?utf-8?B?N3JsL0tWbFdEWndYbzlSQmJ6N0xEWGFGUy9PdXZPYjJWZ2JNdVpCcTI4Nnd0?=
 =?utf-8?B?My9uSS9USGxNYjY1UmpsWDUwOSsxcmsxcW14T2pPWDczZGRySHd6WFRjc3hJ?=
 =?utf-8?B?THFhd1pGYUZ2ZUg3elVoVVdUbERNWTAvMS8vTG9LSmpmdkxjR3JLcjVxUG5J?=
 =?utf-8?B?OHozV2s0VVJzRXNwVXBrMjR1Q3l3Q2JRaTlPWXp5NHRJTkhOcHEwdFZadURm?=
 =?utf-8?B?WXhUNXJZejB2ZkRKdy9ndlZsdFhRL2Y2cEoySjFONmJNUThpSHJqaHB5OVlT?=
 =?utf-8?B?YUZIWlg4aEY2ZkhyakNjYWZ3Q0hXd0R1cEJhdnVnQW0rV1hyck1POUZobEFS?=
 =?utf-8?B?S2pFbElCbWU2YWtZRFBsS1VzZkYrWFoxYXVDcmdxMXVOQk1FUVVacUVaWGhr?=
 =?utf-8?B?L041TFdDREEwYVY1RzFEdm5lU29oTm1kSUlGNWlTM1JTZExPVEI0aW4xakxK?=
 =?utf-8?B?WktUcTJjeUFBNEsxK2sxME5RUUVxWkc0U2wxQXNZZTNTbkE0VHF1U1I1ejR2?=
 =?utf-8?B?VVAvempFcFN2WVVFV3B3UzV5N3I0NzFmSFR6U0FVRTg4L2NvREltbmtoV2o5?=
 =?utf-8?B?UWg0dUlwdTdidHp6Vy9xYmVoZktQcis3R2IrUDZNTXUwdk5sb2FvSCtNTmo4?=
 =?utf-8?B?dWFudFNoRFJSNkxNLzB4ZFdxd3BOTTIxb2dmekpkd0FHTXRwSTY4MU4wOXJv?=
 =?utf-8?B?RmNTSTBOUkhzVFI5eGtmZXJYc1BMUlJxVkhUcFV2bzdTSlpjT3huQ085Y3d3?=
 =?utf-8?B?QnpLcUcxUlhnSzhqUUpIMnEzOVBXRCtOWFdoOWREMEtvQndjRHh1TThzMjRX?=
 =?utf-8?B?MkRwL2lZQmtkNmxKZWw0UzNMRGpWQ2t2cUxmTlBjWmNMc1RpcXVPZ0lWazlm?=
 =?utf-8?B?V2sxc0daM1hXbE5NV0czbVBFOFIxTHQxYUZ2UXQwb2FUN2dlb0RnbjhvTlJQ?=
 =?utf-8?B?UWYxM3ZNWFNJSGd4RUhuQUZTUEJjZElHNmd6TTRyVW1Ndk1KOGF0TWtHZFh1?=
 =?utf-8?B?VitjK0xYSlNDRVJ1aHB2bFF5YnR5dzhrRXlKdWhYZEhaYmdCQXhBTkQzbzVy?=
 =?utf-8?B?MUVjclFPTXhkdFREK0lFYWFqREQ5VEZldTF0S0FaSDd6amVYS2tPNldhSkFv?=
 =?utf-8?B?ZWpjdE45dDUreXYrY1lOK1FCckd3PT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6326D3543531B14E9A33FEF6B268DD16@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 59907c04-becb-4258-055c-08d9e78c33ee
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Feb 2022 03:12:40.0904
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cskadpYcWyuwHHTwCFJPpwlHe1ypBhqX2zevTYgggkPg+9DN5xfD2e3QvCwXJsVZ6G5vcTV9ub2Eta2opIt23Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3096
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

DQo+Pj4gT25lIGNhbiBpbnN0YW50aWF0ZSBzY3NpIGRldmljZXMgd2l0aCBxZW11IGJ5IHVzaW5n
IGZha2Ugc2NzaSBkZXZpY2VzLA0KPj4+IGJ1dCBvbmUgY2FuIGFsc28ganVzdCB1c2Ugc2NzaV9k
ZWJ1ZyB0byBkbyB0aGUgc2FtZS4gSSBzZWUgYm90aCBlZmZvcnRzDQo+Pj4gYXMgZGVzaXJhYmxl
LCBzbyBsb25nIGFzIHNvbWVvbmUgbWFudGFpbnMgdGhpcy4NCj4+Pg0KDQpXaHkgZG8geW91IHRo
aW5rIGJvdGggZWZmb3J0cyBhcmUgZGVzaXJhYmxlID8NCg0KTlZNZSBaTlMgUUVNVSBpbXBsZW1l
bnRhdGlvbiBwcm92ZWQgdG8gYmUgcGVyZmVjdCBhbmQgd29ya3MganVzdA0KZmluZSBmb3IgdGVz
dGluZywgY29weSBvZmZsb2FkIGlzIG5vdCBhbiBleGNlcHRpb24uDQoNCj4+PiBGb3IgaW5zdGFu
Y2UsIGJsa3Rlc3RzIHVzZXMgc2NzaV9kZWJ1ZyBmb3Igc2ltcGxpY2l0eS4NCj4+Pg0KPj4+IElu
IHRoZSBlbmQgeW91IGRlY2lkZSB3aGF0IHlvdSB3YW50IHRvIHVzZS4NCj4+DQo+PiBDYW4gd2Ug
dXNlIHRoZSBudm1lLWxvb3AgdGFyZ2V0IGluc3RlYWQ/DQo+IA0KPiBJIGFtIGFkdm9jYXRpbmcg
Zm9yIHRoaXMgYXBwcm9hY2ggYXMgd2VsbC4gSXQgcHJlc2VudGFzIGEgdmlydHVhbCBudm1lDQo+
IGNvbnRyb2xsZXIgYWxyZWFkeS4NCj4gDQoNCkl0IGRvZXMgdGhhdCBhc3N1bWluZyB1bmRlcmx5
aW5nIGJsb2NrIGRldmljZSBzdWNoIGFzIG51bGxfYmxrIG9yDQpRRU1VIGltcGxlbWVudGF0aW9u
IHN1cHBvcnRzIHJlcXVpcmVkIGZlYXR1cmVzIG5vdCB0byBibG9hdCB0aGUgdGhlDQpOVk1lT0Yg
dGFyZ2V0Lg0KDQotY2sNCg0KDQo=

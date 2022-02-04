Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C07D24A94CB
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Feb 2022 08:58:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239871AbiBDH6a (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 4 Feb 2022 02:58:30 -0500
Received: from mail-bn8nam11on2056.outbound.protection.outlook.com ([40.107.236.56]:29024
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S238494AbiBDH62 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 4 Feb 2022 02:58:28 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iCjMcHQ8wnp1BTMG0g2U+OkySQ8RN8ru4xVG0Q0X9/9b3nUlgQPrFWNe6DyauvK1vqsMvYxeIFitY+seIKl6GR1YXnAklRlbdh7JMxAAudVFT7wqp1GqVlINnNjaTVDmdUjUgDQnSBAaKLqlBYFvwE8T9c26iGX8/e+dReLzATsqWpj9yfU4Elv94XDu/WcxkAFyJzrrsa63rm/F65h/RS70+kNDKy9M+jZGqJ5+O2sbvXikk7tsaMeAklbn0LqKxASWqBzcANAAr3L8/eQfzyT2E5xuMeI3sq+oCg4+VwYiSqT/htD6Jnrfh+FrzDv8ONO2bq6t48ZoS56RaBxlhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MLX1uSPxEbtnLhbVxWg2n7ysBrVnOlSvsO+9YFxUGBE=;
 b=kpeYe7c//s3H3WJbh/YvZNYklabiBqNPJsuEMch6U0twmoRqN70csGM6FQWVWjlCgZDXFBCsKLMiM3jY2g59Q8CwQeeMIlURoxLbojpOnc7uYttqbGr3oFla9zvFuRuY416o5hYRo8tDSaZu5w5CPDsv6xvTahqDUJyR9+Q7ceRskXfOoLHKdYHF/jX7Xzdma5yOU6urf5s0A3pH5Y3nUNbSs2r5WWpeDkJ2e6hxXxgHom+7zWFYB7s4JaIrXjNLflDKwkpgQyZ1vqNzr7Qx29S+4/NMYJe/yYEherCh1EUFhsHGpoAOo/p1VJ+boxjNoCa9ubegBqvrmg/xmXVnlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MLX1uSPxEbtnLhbVxWg2n7ysBrVnOlSvsO+9YFxUGBE=;
 b=b2xUo1LnESF4i2jRKaywVnrIQsCKibhme97YRzPINUEITMHTQI5x2xLgQWyaE7rNb3G8Caq5UK6IiNf11n+lx1v3sXfUeoccDVBjF94kUk/almZAWMoYjymD40e0kyqvJBrC8etMGc6irZil6frXiyNEef0K3qm+MGHBDp2/NuFmMjCyeiElBwkazwLuT/oL4eqoj/h87NKQoS7rt2lGhtoGxhZ4n0KJnQusHPpqQoa7CIyMKn0B8gt8ynGF6/3XAz9bbGFxF/1eBgWS+5HZVnHG676/F5CN4slrKtJT1E70+uxy965oz86gLMIIg3b5Ca5DOdQ1UuRHj3qmQjHrOA==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by BN9PR12MB5099.namprd12.prod.outlook.com (2603:10b6:408:118::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12; Fri, 4 Feb
 2022 07:58:26 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::846c:d3cd:5a30:c35]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::846c:d3cd:5a30:c35%5]) with mapi id 15.20.4951.014; Fri, 4 Feb 2022
 07:58:25 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
CC:     Luis Chamberlain <mcgrof@kernel.org>,
        Mikulas Patocka <mpatocka@redhat.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Keith Busch <kbusch@kernel.org>,
        Adam Manzanares <a.manzanares@samsung.com>,
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
Thread-Index: AQHYF5pGTuc0vK6aW0WDOYv4vbM4lKx/5pmAgAIScYCAABSnAIAAMdEAgAB7aoCAADa8gIAAGRyA
Date:   Fri, 4 Feb 2022 07:58:25 +0000
Message-ID: <9d5d0b50-2936-eac3-12d3-a309389e03bf@nvidia.com>
References: <f0e19ae4-b37a-e9a3-2be7-a5afb334a5c3@nvidia.com>
 <20220201102122.4okwj2gipjbvuyux@mpHalley-2>
 <alpine.LRH.2.02.2202011327350.22481@file01.intranet.prod.int.rdu2.redhat.com>
 <alpine.LRH.2.02.2202011333160.22481@file01.intranet.prod.int.rdu2.redhat.com>
 <270f30df-f14c-b9e4-253f-bff047d32ff0@nvidia.com>
 <20220203153843.szbd4n65ru4fx5hx@garbanzo>
 <CGME20220203165248uscas1p1f0459e548743e6be26d13d3ed8aa4902@uscas1p1.samsung.com>
 <20220203165238.GA142129@dhcp-10-100-145-180.wdc.com>
 <20220203195155.GB249665@bgt-140510-bm01>
 <863d85e3-9a93-4d8c-cf04-88090eb4cc02@nvidia.com>
 <2bbed027-b9a1-e5db-3a3d-90c40af49e09@opensource.wdc.com>
In-Reply-To: <2bbed027-b9a1-e5db-3a3d-90c40af49e09@opensource.wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 156ed700-672e-4599-964c-08d9e7b41f92
x-ms-traffictypediagnostic: BN9PR12MB5099:EE_
x-microsoft-antispam-prvs: <BN9PR12MB5099780EE5C6D06DF05097A8A3299@BN9PR12MB5099.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3AYFENidXhtW58dNct13CbD725jWDTS7y6EVNOIEqNaallAhIpQneh+5SpImDilWwopPI3kQfIUqqjbMZ6/Cd+DDEeWPYyttvAFIaXxXVy5ckYCWI07Xu596+jZ9pi3qNFDA6QYhjIavkMUIayLazGvbQYC0JNivotgGSYb0tv4+aOO+9c4/3T1aErqIaUX0+UOwlCrz67i3a2pQwBhmYGrD3/orBux5T6TDtgXO7M25qiV0gb8PPy6oK/lksRZAgR8XqyafbwfmtM1T0Mkyv2xOemGEG5l4FoRCLQJbVf0eqFQelyVlMbMChBw3Xxtf7lLWexMS14eIpn33i9y9vEgwBETDhutkDkrXHymBDjSOEBUYiIRH/P7kqMosdsz70MjNej+Hv5gIyR5ugVl7qKprTAarW4vucaWBaGQYs4FBGGI8eHdbBEXvlO4YCUsrtnl+pkNPjN84Fb2Wxolo+JLuyUXW+H28JYH1i28xCRUnMQeFzZmerFhn/BqqHM1oQbh9zH/0FNhB6znWQKmAcNo7M68V4mJNgYTQlxiOdqIFj3B8Y2oeAtqRjGh26YClnX3S+K2Mpm2fwLjOhM8daSvWcnpspOdFEdX4e09UXPnV4djB/WjbdgUgaLsaQC44eyE3FcDpj7T0WTZLqm2w/iCQyZXWyxYt6EX4oltPhH/ztmrpzPIHgHfUEH0yWUaHutpieJqYsj0IVVIaWq2xqsannvUyqQkj4zfBvD3BauPBzCnelza3zqLTlifmSuLcmGAwHmPbuXQEaDeHB4+z8g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(2906002)(6512007)(36756003)(7416002)(86362001)(5660300002)(186003)(31686004)(122000001)(83380400001)(38100700002)(66946007)(38070700005)(91956017)(76116006)(508600001)(8936002)(8676002)(4326008)(54906003)(6916009)(316002)(53546011)(66556008)(66476007)(2616005)(71200400001)(64756008)(31696002)(6486002)(66446008)(6506007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NTdlUnhpaEJ1TjZ0dWZHTExRamhFS0EzODlXZGxDNnR4NktpckNvSlpIVDRr?=
 =?utf-8?B?dTlXN0ZKRFdKc0pFaUFOeDhuamFVUERReWx4U0ZaZVBSd1hjb1RLckNsWFZV?=
 =?utf-8?B?TklhS1JZaFM4T2VuMEFjbVBqenQ1SjN0YTFTVG4zNVRNMjdvZ3pEODFpK1V1?=
 =?utf-8?B?dWRiRHU3SjV3S2hLSFZNQ1ZlaWJGZEV3bHRHQStLamIydjIrZFpweUVGNC9R?=
 =?utf-8?B?YmF1UkpDMm1ZWkJIWVNrUVV2Z2xsbmNMYmdEdCtBL0l0Y2U0TWFFVlk0K09o?=
 =?utf-8?B?aVpqVVdDdTlwNGMrVnlxTkViWUhyY3ZsM0FJVFIwcGtXY0hIalVncjFWSmVi?=
 =?utf-8?B?OCtVUkZzWEdmMG1Kb3NUVnVwUUMyNnJBL2VGVmV2NjJBR2NOUFNQZTUwdldK?=
 =?utf-8?B?MjhpNXNyT2tFQ29VL1hSTlYydk1MRHcvM2N3Rlo5Sjh3VjlUd0dhMjZtY0di?=
 =?utf-8?B?YnpZRFhyRVk0NHo0Y3F6S3RLNXlpQVdORFZZbUJBd3FLWlZUNDJja3UvUSt0?=
 =?utf-8?B?eERMbmxqVXRXL0c4U2JuZnEwOE1VUWw3Slh3WEt6ZmdFTTJ2ZFd3UDlHWGV6?=
 =?utf-8?B?TER3S25Kcmp4UmN6SDZEdTAwQkdBTlRSdXpZaXRQeW9lTXBJZVp4bG55c2pX?=
 =?utf-8?B?Ti9XS0F2SE5sa2FiZ3ROQTZNVGVodlpXM0E3Zk9UeVBTbW4vZW43Qk1Jd2FU?=
 =?utf-8?B?cWpnbDZDc2wrWC9jRUc3Q3k3L2luaVlJUzN4NmRFSENFRDhrUmY3QnJ1Q1VS?=
 =?utf-8?B?S1dRNTM0RU5kQjA4MjcrOUoxYi9wZnF6Ry9KaFpPYVpMRTMzMm96K3lsbTlK?=
 =?utf-8?B?VWY2SU9wY0ZNRzBtRUNENjQ1V2w0d090a3VKOGp3cG1Xb3RHaENPVnRUWVdX?=
 =?utf-8?B?Q2dyazJQMXFYN2x4SnBYSDlsUWxTQTZjaWNXZ1JuTFdUM0szVWQ1eEVCY3ls?=
 =?utf-8?B?Vy93VHFlN1V5dk9sMDBHSUZEZmFFUFB3MkN5NkNZTXJFVkRsenFVNmRaQit3?=
 =?utf-8?B?NUg2bE15TmpNLzZRMVEwZlo4Z0g4N1h1Uko5R1ptbFlubWczYVJ3T1pkNWNI?=
 =?utf-8?B?V3NQUUdjVmxFS2E3ZkM2YUlvRzBSMnYwdU14WDdaQTVleE5OUUUrdjlMWjF2?=
 =?utf-8?B?bEZqbitoMkpnUkdXdW5rZEZDQnF3b1g1blkzVmFSMFROSWJDUCt4RWtMLy8z?=
 =?utf-8?B?bmRmbUNxQmd1bFhTNnBnMlRCZWYrSjBSK0x0V2RZRUUxQnZKZ3FMOGZVdEd2?=
 =?utf-8?B?VVB1NGl6RWNvakkyeXdGWFp6dXVnZEJaWHBUUkl5MkJNNDVCWWxENG9JeCs5?=
 =?utf-8?B?UiszWmhzaHYxSGNYdHdiQTR3MkxydGdUREVXZkI1VXgrVUZDbHFjTkY1TEhx?=
 =?utf-8?B?T1ovRmNlck84T1F4S3V1WFdYOEhIdDNQQU5lbG5qUHAyLzJVaE5WK21nUWRt?=
 =?utf-8?B?cEdBQ3N2Q3ZSbEhmMDlDVzNwZUJockRCdWxTSHVBUng5OTNKZDhmY3Y0ZG1p?=
 =?utf-8?B?bFF5RGtDcWxWTWd1MjlTdENwN3YxN1VGL0h5VytWK0NOb0RjRkJNVklIaUFX?=
 =?utf-8?B?MU9yOEVya3NPdVhSR1YrdjV0eHZlZUxySUxuT2VHenVaT2U3aVZraTBrWXVh?=
 =?utf-8?B?MmhmMkltTUt1RmNPeE8wd1BrbjRNKzFDbUtWaEVRR0xFTndIREpBSkhObVY0?=
 =?utf-8?B?Zk00MkxUWGpONGVXS2dNc2pxVjhwdGpwYTBYekZBcDJZSG5hK1hFUERRN1JO?=
 =?utf-8?B?b1pZL0NPSklZUFU4bVJGSjNtNWl2ZG5BZWpqTmUwNnVhS2hIS3RVdnhFUTdP?=
 =?utf-8?B?WU9iKzl4RHh0SGtnNDdjeDhNWDJma0VmS2V0NXc2bW82OWNYUGFqMzh5aFpw?=
 =?utf-8?B?dXhCTDVQOThGUFlTRUFZNzBpM2RZUXZsenVVRTFjRWhmMVNORVVURTdtTWJW?=
 =?utf-8?B?K2ZCNFFtUEZOTVRuamgyZmpPTGhTZldqa2VyWjR1YnJYUmx1aEVNV2FRekU5?=
 =?utf-8?B?MjY3bC9tZlMyNXExYnRIbTNobWduSlNjQzVxdWtKcllJU1pWRHRJNzBkSDQx?=
 =?utf-8?B?UXIrQ09MQTZpQ0p0cjViNjJZclp3c1JKSWZMdEtCUEZhTWk2NHNoUXhxWG1G?=
 =?utf-8?B?ejVwU2ZCMXR1NWp5NldQMFA3S0dhaCs3eDBkU1IrdXF2N3cwcmIvN053cjR3?=
 =?utf-8?B?KzRGM1VPQ2lYVG1pSVJFdmVpWlVubUZ0V1RYYlRpYS9EdDlDc09uUWhhK3N5?=
 =?utf-8?Q?oeAE0UXsqYAVg5RFu+cEXyxPcbiRfGycKf6nQsp0Yk=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A95C95B38A829B428BEAD9BE29762B38@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 156ed700-672e-4599-964c-08d9e7b41f92
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Feb 2022 07:58:25.8528
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6dYSGR4LlEVOSkw9Yx3pCLZad59ZNU8xuP1hEuB2uzq98vVVyDx5DhEnEBGvmVE9aM8eJ2gJBEA4QvnEYNzV1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5099
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

T24gMi8zLzIyIDIyOjI4LCBEYW1pZW4gTGUgTW9hbCB3cm90ZToNCj4gT24gMi80LzIyIDEyOjEy
LCBDaGFpdGFueWEgS3Vsa2Fybmkgd3JvdGU6DQo+Pg0KPj4+Pj4gT25lIGNhbiBpbnN0YW50aWF0
ZSBzY3NpIGRldmljZXMgd2l0aCBxZW11IGJ5IHVzaW5nIGZha2Ugc2NzaSBkZXZpY2VzLA0KPj4+
Pj4gYnV0IG9uZSBjYW4gYWxzbyBqdXN0IHVzZSBzY3NpX2RlYnVnIHRvIGRvIHRoZSBzYW1lLiBJ
IHNlZSBib3RoIGVmZm9ydHMNCj4+Pj4+IGFzIGRlc2lyYWJsZSwgc28gbG9uZyBhcyBzb21lb25l
IG1hbnRhaW5zIHRoaXMuDQo+Pj4+Pg0KPj4NCj4+IFdoeSBkbyB5b3UgdGhpbmsgYm90aCBlZmZv
cnRzIGFyZSBkZXNpcmFibGUgPw0KPiANCj4gV2hlbiB0ZXN0aW5nIGNvZGUgdXNpbmcgdGhlIGZ1
bmN0aW9uYWxpdHksIGl0IGlzIGZhciBlYXNpZXIgdG8gZ2V0IHNhaWQNCj4gZnVuY3Rpb25hbGl0
eSBkb2luZyBhIHNpbXBsZSAibW9kcHJvYmUiIHJhdGhlciB0aGFuIGhhdmluZyB0byBzZXR1cCBh
DQo+IFZNLiBDLmYuIHJ1bm5pbmcgYmxrdGVzdHMgb3IgZnN0ZXN0cy4NCj4gDQoNCmFncmVlIG9u
IHNpbXBsaWNpdHkgYnV0IHRoZW4gd2h5IGRvIHdlIGhhdmUgUUVNVSBpbXBsZW1lbnRhdGlvbnMg
Zm9yDQp0aGUgTlZNZSBmZWF0dXJlcyAoZS5nLiBaTlMsIE5WTWUgU2ltcGxlIENvcHkpID8gd2Ug
Y2FuIGp1c3QgYnVpbGQNCm1lbW9lcnkgYmFja2VkIE5WTWVPRiB0ZXN0IHRhcmdldCBmb3IgTlZN
ZSBjb250cm9sbGVyIGZlYXR1cmVzLg0KDQpBbHNvLCByZWNvZ25pemluZyB0aGUgc2ltcGxpY2l0
eSBJIHByb3Bvc2VkIGluaXRpYWxseSBOVk1lIFpOUw0KZmFicmljcyBiYXNlZCBlbXVsYXRpb24g
b3ZlciBRRU1VIChJIHRoaW5rIEkgc3RpbGwgaGF2ZSBpbml0aWFsIHN0YXRlDQptYWNoaW5lIGlt
cGxlbWVudGF0aW9uIGNvZGUgZm9yIFpOUyBzb21ld2hlcmUpLCB0aG9zZSB3ZXJlICJuYWNrZWQi
IGZvcg0KdGhlIHJpZ2h0IHJlYXNvbiwgc2luY2Ugd2UndmUgZGVjaWRlZCBnbyB3aXRoIFFFTVUg
YW5kIHVzZSB0aGF0IGFzIGENCnByaW1hcnkgcGxhdGZvcm0gZm9yIHRlc3RpbmcsIHNvIEkgZmFp
bGVkIHRvIHVuZGVyc3RhbmQgd2hhdCBoYXMNCmNoYW5nZWQuLiBzaW5jZSBnaXZlbiB0aGF0IFFF
TVUgYWxyZWFkeSBzdXBwb3J0cyBOVk1lIHNpbXBsZSBjb3B5IC4uLg0KDQo+IFNvIHBlcnNvbmFs
bHksIEkgYWxzbyB0aGluayBpdCB3b3VsZCBiZSBncmVhdCB0byBoYXZlIGEga2VybmVsLWJhc2Vk
DQo+IGVtdWxhdGlvbiBvZiBjb3B5IG9mZmxvYWQuIEFuZCB0aGF0IHNob3VsZCBiZSB2ZXJ5IGVh
c3kgdG8gaW1wbGVtZW50DQo+IHdpdGggdGhlIGZhYnJpYyBjb2RlLiBUaGVuIGxvb3BiYWNrIG9u
dG8gYSBudWxsYmxrIGRldmljZSBhbmQgeW91IGdldCBhDQo+IHF1aWNrIGFuZCBlYXN5IHRvIHNl
dHVwIGNvcHktb2ZmbG9hZCBkZXZpY2UgdGhhdCBjYW4gZXZlbiBiZSBvZiB0aGUgWk5TDQo+IHZh
cmlhbnQgaWYgeW91IHdhbnQgc2luY2UgbnVsbGJsayBzdXBwb3J0cyB6b25lcy4NCj4gDQoNCk9u
ZSBjYW4gZG8gdGhhdCB3aXRoIGNyZWF0aW5nIG51bGxfYmxrIGJhc2VkIE5WTWVPRiB0YXJnZXQg
bmFtZXNwYWNlLA0Kbm8gbmVlZCB0byBlbXVsYXRlIHNpbXBsZSBjb3B5IG1lbW9yeSBiYWNrZWQg
Y29kZSBpbiB0aGUgZmFicmljcw0Kd2l0aCBudm1lLWxvb3AuLiBpdCBpcyBhcyBzaW1wbGUgYXMg
aW5zZXJ0aW5nIG1vZHVsZSBhbmQgY29uZmlndXJpbmcNCm5zIHdpdGggbnZtZXRjbGkgb25jZSB3
ZSBoYXZlIGZpbmFsaXplZCB0aGUgc29sdXRpb24gZm9yIGNvcHkgb2ZmbG9hZC4NCklmIHlvdSBy
ZW1lbWJlciwgSSBhbHJlYWR5IGhhdmUgcGF0Y2hlcyBmb3IgdGhhdC4uLg0KDQo+Pg0KPj4gTlZN
ZSBaTlMgUUVNVSBpbXBsZW1lbnRhdGlvbiBwcm92ZWQgdG8gYmUgcGVyZmVjdCBhbmQgd29ya3Mg
anVzdA0KPj4gZmluZSBmb3IgdGVzdGluZywgY29weSBvZmZsb2FkIGlzIG5vdCBhbiBleGNlcHRp
b24uDQo+Pg0KPj4+Pj4gRm9yIGluc3RhbmNlLCBibGt0ZXN0cyB1c2VzIHNjc2lfZGVidWcgZm9y
IHNpbXBsaWNpdHkuDQo+Pj4+Pg0KPj4+Pj4gSW4gdGhlIGVuZCB5b3UgZGVjaWRlIHdoYXQgeW91
IHdhbnQgdG8gdXNlLg0KPj4+Pg0KPj4+PiBDYW4gd2UgdXNlIHRoZSBudm1lLWxvb3AgdGFyZ2V0
IGluc3RlYWQ/DQo+Pj4NCj4+PiBJIGFtIGFkdm9jYXRpbmcgZm9yIHRoaXMgYXBwcm9hY2ggYXMg
d2VsbC4gSXQgcHJlc2VudGFzIGEgdmlydHVhbCBudm1lDQo+Pj4gY29udHJvbGxlciBhbHJlYWR5
Lg0KPj4+DQo+Pg0KPj4gSXQgZG9lcyB0aGF0IGFzc3VtaW5nIHVuZGVybHlpbmcgYmxvY2sgZGV2
aWNlIHN1Y2ggYXMgbnVsbF9ibGsgb3INCj4+IFFFTVUgaW1wbGVtZW50YXRpb24gc3VwcG9ydHMg
cmVxdWlyZWQgZmVhdHVyZXMgbm90IHRvIGJsb2F0IHRoZSB0aGUNCj4+IE5WTWVPRiB0YXJnZXQu
DQo+Pg0KPj4gLWNrDQo+Pg0KDQotY2sNCg0KDQo=

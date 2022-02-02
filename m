Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D3B24A6C8E
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Feb 2022 09:00:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237918AbiBBIAP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Feb 2022 03:00:15 -0500
Received: from mail-mw2nam08on2050.outbound.protection.outlook.com ([40.107.101.50]:29278
        "EHLO NAM04-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231862AbiBBIAO (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Feb 2022 03:00:14 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mfjKVaEWezbJY/yMmFoFeZP4DwWegmYdFlTSlyJZMKqzckHCqboTUJTQiqZmaiYaZD4zcAwVPolVTdje9EJSp6BdSqsMgP1vvp/Zn+xMP0UMKucfrcCjulYTKerPSQ1aB5sDN4kmVhHZAbiyZBxlN9cIOthK18tXx5Xbi9r/lEN8eYCfnQDvbgZCHibmA1HqmzF4UZrJforJrW+qGIl6jL3aqGil+umYCa7Al6exNJZPN111Pn0zgNldyQBCgdSicrdmUxDHtDhuZ+BjCesixt/c7lDOUa/UJXcxwZKeNCWyRexfvyT6by6TPZLqJ3nWprGUp+G4kqhLaY45Wo7CGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A+TwiTF2U16qIB8rorUmD7HpYqFyX7CNVsI7C6qXTdM=;
 b=AyJcPOpbhdELvHh4H+nV+Tdr6z+gkwprLkN/A7KCS8+sIPO3rMBh2BYux0io1821PaK3ESq0rnTIwarxsLrQgPWColmlfT8OKPuYLugejIz3pcEbblT0Yt+3kOIInGh3KEzePoQubJ1sKqYUODhcv5G56VbkFdYIGJtJ3VnR9t8aWzfR5Q3l8bz8MH+l+gre4w9uNxyJvWxlfDpfcliYECt8ZWEHEFZn7c6LG6tYwAhVcFUrma7QyLwcr5m+b4n9XJPQHgDexeOd7xarAm9omwwNmMrdZsENwLeb+2q0DLQ5+JHOljC0vlM7LuoMwD+3F91AtpBtVCugLDUNVRTVbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A+TwiTF2U16qIB8rorUmD7HpYqFyX7CNVsI7C6qXTdM=;
 b=B1rAi/NDILHGys2arz50hVJo4841zDpAnxEdxaiCfU/AfC4zHSR7y0ijGAgq88iK75ttJS05flUcbxbl6Z2Jdv8cD/8wkLHq8yaUaXk/G+i4bzB+iiCTtIMU2Kv5vjOXsNokuHcmjI5MehAcrEsV7jjlBsd6NxjAG03ehS5jDS6NUeCifBzoSwWS+Rq62tz8PeOD20rqyJnYeL7V3hq7VBmjTeA/3k1rvB6HY1xSGW7WSjPf6+1lmnyMd4oHxTBRnoPks43U1oJdcgPUBN5zrquiuPHE7PqV+xVpgtlThQPooq/ms1EYZpg2XxWjMpg0O/v1ooG0WF3eHG281ShivQ==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by DM5PR12MB1595.namprd12.prod.outlook.com (2603:10b6:4:3::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4930.21; Wed, 2 Feb 2022 08:00:12 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::846c:d3cd:5a30:c35]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::846c:d3cd:5a30:c35%4]) with mapi id 15.20.4930.022; Wed, 2 Feb 2022
 08:00:12 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Mikulas Patocka <mpatocka@redhat.com>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
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
        Hannes Reinecke <hare@suse.de>,
        "kbus @imap.gmail.com>> Keith Busch" <kbusch@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
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
Thread-Index: AQHYF5pGTuc0vK6aW0WDOYv4vbM4lKx/5pmA
Date:   Wed, 2 Feb 2022 08:00:12 +0000
Message-ID: <270f30df-f14c-b9e4-253f-bff047d32ff0@nvidia.com>
References: <f0e19ae4-b37a-e9a3-2be7-a5afb334a5c3@nvidia.com>
 <20220201102122.4okwj2gipjbvuyux@mpHalley-2>
 <alpine.LRH.2.02.2202011327350.22481@file01.intranet.prod.int.rdu2.redhat.com>
 <alpine.LRH.2.02.2202011333160.22481@file01.intranet.prod.int.rdu2.redhat.com>
In-Reply-To: <alpine.LRH.2.02.2202011333160.22481@file01.intranet.prod.int.rdu2.redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: cdc7089a-8d42-4af5-bab0-08d9e6220a39
x-ms-traffictypediagnostic: DM5PR12MB1595:EE_
x-microsoft-antispam-prvs: <DM5PR12MB1595DEE0E56E4188FF2275E3A3279@DM5PR12MB1595.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2043;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Tm+RwM6GB6IxBU4X8jfeb7tEGFmxdNaT/j/H/nIHZQVEQbxIzWhGkmSCPwPyk4SKyXzocCDLtTpBMpFF7fYFZGBo2OUQljOfYdg88MpIbaRPMQbUjOdj6wj2dtkWbz3vwPYFfCXactGYi9/x944i2sItRvIMOGdRq3zvyCxIZcpWnQzjDLXRmAYM6+EBYAKxX0xt6QJbcTE00TbU0KXW8nRKTjIZuvS/TUe0er86JrgCkKzuHSIn1x6WZ0M9FYaiO3xp+yWg2IRA5WDiTOty5kLHxhepjrLs/N5ORsf84m0cmggUk/TRwZeK3lUOq5wemR1qPsjwINgEh/icOhjYQi1GCYXUugrycXsAnqHQ5aD4abhTdcpgO/md8RP3AowmuLIvxRu0HUjYY+DL8f5HwL9WhNxQtnoMOmtty8v0QcGFsLFbgTB2Edyq07C2zdCJOD2VTMWZDXm2GXI6qJHCL1lItnWXzd2Nyiix7aH5SieXcbXCoSio9G+yvxJpxCZ8GaDqmoIlGxaoNk6Wy7r8FCkJl+78sZoHl52sFfH1bwID8f85loO6LkWvCJd5/eN1arpJcgK9OdC49IToE8FGhgxNkZ3xLl4uDps0horW9igdi1aaTLWQmD4cDuJ9a1sT74+FLb6zQTiLmmVMXS99kwxu3Nw8p4x2ZIIMHLmawF2/h/bSnW5+Nv97jUThPy3LaOAnMlwIy02gUocq2KVjNEvfSzRUoJ4ewGGWavKplvG4vAZDXi1TaLLaVSTfEPtaENEmAyINXiiW1NjgOM3zSQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(508600001)(71200400001)(53546011)(86362001)(64756008)(4326008)(66446008)(76116006)(6512007)(6486002)(31696002)(8676002)(2616005)(91956017)(8936002)(66946007)(6506007)(66476007)(66556008)(316002)(38100700002)(122000001)(6916009)(54906003)(2906002)(38070700005)(26005)(186003)(31686004)(4744005)(5660300002)(7416002)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?K2hvVmozUTBtQ1pSR1ZFN3gyRjA1emxuTFc4dUNMOGxvT1Z1ZFZQNW5qTHdM?=
 =?utf-8?B?elBoQ0wxM0Z5WWx2eU1iQmlXb3hQdytPSUIzd2dTN3dpRzIyZU9OQTIyYitm?=
 =?utf-8?B?bWszRjRNR3p0NnJ5QW5QK25rcmFlTXZTMW5tKzZWK1FQWmF3blo3NmNlM0tT?=
 =?utf-8?B?cmhrZTRxek1PZHZuODJJL0U4TjkzUDZmQkR6TklvZ3Y1alZlVXB0cStGUWZx?=
 =?utf-8?B?T05wZW4xcGVNYTZaODdVeUI2ZkFuZ3Q3TStENkl0Y2tvSDFER3NZbi9NdXha?=
 =?utf-8?B?RzV5QXM1N2ZSdnZBWWpXVGpjdnZRRTBkS0htZWduR1hZVFFiWmtjMWpCT3Vv?=
 =?utf-8?B?aDdxdG9BRmQvVU9ZcE9sMWtxSUw2bXR5UjRXZlpmL1A0Qk81KzM2Rlcvb0Q5?=
 =?utf-8?B?SGFSaG5vVVBaR01QM25uL2lyWGt5YTN6cmhySHRkdnZPUjRDSDFqa285Q1gy?=
 =?utf-8?B?TnNnQkpSWGNXc1R2OTl4M0hWZ1duNXIvSXV3ZUx6NzQydmt0bTFhd0MwYXJO?=
 =?utf-8?B?OUxKQ1Z0VkxRMm8xcVZDV0dVLzBHWStiRzhNdzQ0dkYrOUh3YktEVENmUnhk?=
 =?utf-8?B?c0ZiNmQzL2kzc0QwZFZzYXViMElBWUMrQnIyTVhuL3N5UDRmV25UM0ROTWxn?=
 =?utf-8?B?Z1laMHdsNnNOei84dUg1TkJhd1FnMmQrWGEvVXBZWE56MWxTZVppUUw4SHY3?=
 =?utf-8?B?QlIwLzFwbnVrRW5odVlwR2JYQ1pvOHJBWnVrZVR0dCs0bURMTUpBMTBycWkv?=
 =?utf-8?B?VFlYT09iV2pGRWRJWXVnVWdPMGwvVDVrWW8xVXRhNjhFSDluQnhMWkdxV2hP?=
 =?utf-8?B?d0VDd1MvQSs1Ykh2WkJaSlhpZlNUS0sxZk9URWM4RWh4T045M0lzenBjU2xZ?=
 =?utf-8?B?bDhCOG00ZFREanVQR2k2M2VIRVpGdFhCZmhaam9JZTVqTll4UFRmZ2ozT1Bo?=
 =?utf-8?B?R1J4MGQzdjF5SkFIb3VGZ3lIdUJpWDJ2dklDNmVuK3VPTEtZdjlvU0dNMnp6?=
 =?utf-8?B?anl2SGdHdi94VDlUOThmSDR0RDFQWkpad1Jydk5XSlltVnd0ZkpSWjVOeHVl?=
 =?utf-8?B?d3I3c2J4UFJjU3V5bW11elJMaXNpcys4MnhCSUpOazBuSUxyOFhLbUNmRzM3?=
 =?utf-8?B?dmVTWm04SkxQcTdQRnJDNk8rSjF1bVN6WDFCN0ZUSm83aXZ5Wk1nMDAvR2Vt?=
 =?utf-8?B?b2NMOSt0U0FXbjBJQnZCcENJVzlSQ1lGb1VNZFpJU0Z4M3lxUVdKWUFvZGhD?=
 =?utf-8?B?bUVKZGdVR3FCRHdGTm95bEVBRVdURCs3RGhpWTZYNXpNNTUrY0twZS9IbXhl?=
 =?utf-8?B?UXZqS1FSVWEzeUZybFNpWE5ZY2Zia2QvMjJGYTJqSDVYcHJVdC9FOEp0bDRI?=
 =?utf-8?B?RzVhYVg4RHRWaEl4NEJ1MUcrWDV4ZVRrc21Obm81TFphd3RTY1E3T1hPbWpo?=
 =?utf-8?B?ZnBLQzhxb0FjQUVJZUJCZ1c4SEJkYzhmeVhUdzRPeHNKOFMyK0xpUzhvWU1l?=
 =?utf-8?B?MVdBeXh5UnlUZm9PU3FyRmtDaXRMaURMWWZMemh0L2NUNTJjQ2lGYmdqMytw?=
 =?utf-8?B?T2VkOVVKbmIxZG9WeFMyYTNmSTFnTk9seGl1TDBIUHVTVDRDVmNKYUtUcGJ3?=
 =?utf-8?B?S3dKekUyaXg1a3pBSFNLSE1EWGJFUHNLYTdEdWFJSDFWYWRySVFaZ00rSFUz?=
 =?utf-8?B?a21YRE9VUFJBUTd4aGdHak9NYnowc2RxWW9kUlRIL0hPVnV1SExtRmFTRnBx?=
 =?utf-8?B?VHZUWUFxSUVGRUpRYlZDSE52STQ4YWRIcWhDZUQ5d2QvZ0lSR2gwVnZvS1Q0?=
 =?utf-8?B?KytKazdCQXZVc1htTmV1T2lSMmhPNUxySjV0d3Z6aWlYUXBFRWhMc3lXb2hN?=
 =?utf-8?B?NEZ1aHJRYjE5UGVTWjFuTDhaL20xenpuZlNvWkszTUxJV0lGa2JjTTU4QXBj?=
 =?utf-8?B?Wk5FSVJsU0Rrckx6MmtBWno2a1AralZ6MjFZQklhc2pPL2taeWNJQk1BSVNU?=
 =?utf-8?B?K0prR0VZMjhvOWI4Y1Q0SjNOb0RDRkM4YWs5ckViMVIxL2Z5b1ZiYm9mYmZQ?=
 =?utf-8?B?MFhYa3RiYzF2QWc2bk1ubDAzZ3Q5SzI0MU5GQlV5Qk5ocjF5ekFubnREMmtr?=
 =?utf-8?B?WUMvVDdFdjZISytPbDVVdEFBdC9kMmFwY0tlMnhRM3NvNFFIT3NldjR1ZGRn?=
 =?utf-8?B?Umc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9ABBCB9470793C4F894F4F286291C06A@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cdc7089a-8d42-4af5-bab0-08d9e6220a39
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Feb 2022 08:00:12.3217
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4MaQS0vpARn5mOeaqday7u/Z9eGwsHoVCtsLcQdlL/hQknTlHQQJu5+gfaguLpKq7GKQUb/EcdmRu9qTkjhB/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1595
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

TWlrdWxhcywNCg0KT24gMi8xLzIyIDEwOjMzIEFNLCBNaWt1bGFzIFBhdG9ja2Egd3JvdGU6DQo+
IEV4dGVybmFsIGVtYWlsOiBVc2UgY2F1dGlvbiBvcGVuaW5nIGxpbmtzIG9yIGF0dGFjaG1lbnRz
DQo+IA0KPiANCj4gVGhpcyBwYXRjaCBhZGRzIGEgbmV3IGRyaXZlciAibnZtZS1kZWJ1ZyIuIEl0
IHVzZXMgbWVtb3J5IGFzIGEgYmFja2luZw0KPiBzdG9yZSBhbmQgaXQgaXMgdXNlZCB0byB0ZXN0
IHRoZSBjb3B5IG9mZmxvYWQgZnVuY3Rpb25hbGl0eS4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IE1p
a3VsYXMgUGF0b2NrYSA8bXBhdG9ja2FAcmVkaGF0LmNvbT4NCj4gDQoNCg0KTlZNZSBDb250cm9s
bGVyIHNwZWNpZmljIG1lbW9yeSBiYWNrZWQgZmVhdHVyZXMgbmVlZHMgdG8gZ28gaW50bw0KUUVN
VSB3aGljaCBhcmUgdGFyZ2V0ZWQgZm9yIHRlc3RpbmcgYW5kIGRlYnVnZ2luZywganVzdCBsaWtl
IHdoYXQNCndlIGhhdmUgZG9uZSBmb3IgTlZNZSBaTlMgUUVNVSBzdXBwb3J0IGFuZCBub3QgaW4g
a2VybmVsLg0KDQpJIGRvbid0IHNlZSBhbnkgc3BlY2lhbCByZWFzb24gdG8gbWFrZSBjb3B5IG9m
ZmxvYWQgYW4gZXhjZXB0aW9uLg0KDQotY2sNCg0K

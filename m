Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9045144D2FA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Nov 2021 09:13:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231961AbhKKIQG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 11 Nov 2021 03:16:06 -0500
Received: from mail-mw2nam12on2074.outbound.protection.outlook.com ([40.107.244.74]:54369
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232276AbhKKIQF (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 11 Nov 2021 03:16:05 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CG1XrnN17UjxOD7WgXnTUJdmUkbEm5TXmsDQBcYTrhKectvs0BeMQWPg3owLq8geJ8XogWit/VQmT8AiR2Baoaq9OFlgTW82LN9SIsL/1YrniRJ6zCPqRzBh2RVFibmryBulWk/8nZ7cIcxCqoRWqWaIq0SjvtZFE54nKzdq3teOc1rWJhiRhDfZp9BYdzg9NX/CSZwjwPB31DL3p+4n2UZZkXKkat0oXAoDOP/WxZvhvXWxPrqmBN6KFSrIky9pkteNq1ijA61QKyQvMIkY8d0ViqfzDQqV6byTKbp+s90L31zLqaX7tg0ZZHQlZe1vitq4yL4BW635uTkbGEJCDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8UIpmT1KGXlkNaw4q8AW28FcKGRpL6ynVp13ll+JIuA=;
 b=c+c8zL18BETdQRZvGzLk7uTfpvHddE3Z0+5Q7RF1bVKmWetTDhew+/yQdeJHW/85bv8c1tkXIBneHsp+6XoqtCBrGAPXfLAHEIKYt7SS4ntwbYPLpL9FQWsOpyxAwx6kPQTUazQKSQfbkEJgV1CYuvaWVpwhLSG7jYjm1rFg/YMiBLwVIl7CSuKSAIbJDpFGGw5Barn5Bzfz9ng+wz9CowaDwhXHx0CwTNINq9arLFerYXk8AWni/nNyf1FW2Dsz64AtbC7XRyOUAExmwi5I153KDit6HvqNCxDdOpsyBRSzWkp3ifyxNPaGxR4z5rq7Vn9uoLnYX7yQpeXeX1yN6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8UIpmT1KGXlkNaw4q8AW28FcKGRpL6ynVp13ll+JIuA=;
 b=lBrrJeLxI1Hzr26IytjF4hINDd15BkKkP3yBs1cMzIzeV62VNlnuu7W/qBNN0grJ6ouMvq8SnnJQrPK9up29k3l6ZVrajjY9k3xBiw1+R6wnRNVecWRSBOx+OwMCji98ZqHgbeRUHJEWZg/kpuUsZ9f/Z8/lZFpAp2ryy4BrAaV/VjwZGp5kDs63buh/+ajbQjMMvyIy4oPmV48bmOzEXKU+aLoxdMdSvs840gf0d6S7QW/2O1wAaZdaj5VTvnr680zy+B3d+HNRYKM2iEoV/eTgBMN1qeOIPAZFnIZDaUuAmW3tx1vZgM+0ZDjQw3CX2g+vgsnJGCck5D35ymzKpQ==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by MWHPR12MB1821.namprd12.prod.outlook.com (2603:10b6:300:111::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.13; Thu, 11 Nov
 2021 08:13:09 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::c961:59f1:3120:1798]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::c961:59f1:3120:1798%4]) with mapi id 15.20.4669.016; Thu, 11 Nov 2021
 08:13:09 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-raid@vger.kernel.org" <linux-raid@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "target-devel@vger.kernel.org" <target-devel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>
CC:     "axboe@kernel.dk" <axboe@kernel.dk>,
        "agk@redhat.com" <agk@redhat.com>,
        "snitzer@redhat.com" <snitzer@redhat.com>,
        "song@kernel.org" <song@kernel.org>,
        "djwong@kernel.org" <djwong@kernel.org>,
        "kbusch@kernel.org" <kbusch@kernel.org>, "hch@lst.de" <hch@lst.de>,
        "sagi@grimberg.me" <sagi@grimberg.me>,
        "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "javier@javigon.com" <javier@javigon.com>,
        "johannes.thumshirn@wdc.com" <johannes.thumshirn@wdc.com>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        "dongli.zhang@oracle.com" <dongli.zhang@oracle.com>,
        "ming.lei@redhat.com" <ming.lei@redhat.com>,
        "osandov@fb.com" <osandov@fb.com>,
        "willy@infradead.org" <willy@infradead.org>,
        "jefflexu@linux.alibaba.com" <jefflexu@linux.alibaba.com>,
        "josef@toxicpanda.com" <josef@toxicpanda.com>,
        "clm@fb.com" <clm@fb.com>, "dsterba@suse.com" <dsterba@suse.com>,
        "jack@suse.com" <jack@suse.com>, "tytso@mit.edu" <tytso@mit.edu>,
        "adilger.kernel@dilger.ca" <adilger.kernel@dilger.ca>,
        "jlayton@kernel.org" <jlayton@kernel.org>,
        "idryomov@gmail.com" <idryomov@gmail.com>,
        "danil.kipnis@cloud.ionos.com" <danil.kipnis@cloud.ionos.com>,
        "ebiggers@google.com" <ebiggers@google.com>,
        "jinpu.wang@cloud.ionos.com" <jinpu.wang@cloud.ionos.com>,
        Chaitanya Kulkarni <chaitanyak@nvidia.com>
Subject: Re: [RFC PATCH 8/8] md: add support for REQ_OP_VERIFY
Thread-Topic: [RFC PATCH 8/8] md: add support for REQ_OP_VERIFY
Thread-Index: AQHX0UgtOC/Y9KWcw0KV7w/MN4Ma8Kv+BV0A
Date:   Thu, 11 Nov 2021 08:13:09 +0000
Message-ID: <d770a769-7f2c-bb10-a3bd-0aca371a724e@nvidia.com>
References: <20211104064634.4481-1-chaitanyak@nvidia.com>
 <20211104064634.4481-9-chaitanyak@nvidia.com>
In-Reply-To: <20211104064634.4481-9-chaitanyak@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 17eb0860-f29c-46fe-4dd5-08d9a4eb1949
x-ms-traffictypediagnostic: MWHPR12MB1821:
x-microsoft-antispam-prvs: <MWHPR12MB182107D498E164C601BF101FA3949@MWHPR12MB1821.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pH75awKNVlo0ml1Tdk75CbLvGCVUCAr8UPpsgUOdklviR01KnLkMri3w+aGPhTZqhicAZZQo7L76BVPmEUraaRa2ZQaIvPiKD+ze3udbyW0eHPWhAQnYT1k2FvuwRW7AjESJlXBQC0hfZqDjpOYs+sM/+WEdSG7vhEn9SfGFewVYemjg+NsxELbbzyfOxcA076fMPWTxPlpzNInuW91kHCmvlZCgIkyQDVNfc273hWfMa9vlz5wNiRcQkFPJfys6WafXDdsJp/uQ8ZNlhdYMvk+0ig3PxULcn/ZcJj5UWqnJMmJb+R1mVKKbhgYWZ6EUMCAcgUehXMm64qIa3t1yAA/hoy9zB0vB14PVHtowV1GsgjwQBRSnCmyMTmnyC3DP6mt4POB6D8M/n/Jb+OLk1pRs18LWCdojbd1dbZ4JDbOpo72pfNtB14ZP7Oz1gjKu1adey8H3Tdd8tG51IqgHRQ6J2PQxAqPtP92/zdCe0pjqFFAfqEnZqMZaC+7M2l1nbeaSKs8PxkP8aUM9f8OqIt9mFW3E6lIWA1SqEs5qBLVcdn09hS7A08hOOS22k1F6yn2XpuhRKB85MAy1qxZaI2PiPljmkwkAYVK9wxBVx8TvRdJXtajOlfkbnhdUnTwSrVcgvjvtShgJN0tf06+VvG09MatT41rdMdjklrCLc5FNm8yXuLQW8Wm1d6DDI88mBZuix+tsiQoKVkGGVgXe9m71C1652+yBwZ6xoc6f5Bxr1UY0xs5DNSc8+xJFbgAssqSXXRhlKLP3IZKPhY2TIg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(83380400001)(8676002)(6512007)(66556008)(66476007)(64756008)(8936002)(31696002)(186003)(5660300002)(86362001)(66446008)(66946007)(107886003)(122000001)(38100700002)(316002)(76116006)(6486002)(31686004)(71200400001)(54906003)(2906002)(53546011)(2616005)(110136005)(7416002)(7406005)(38070700005)(4744005)(6506007)(508600001)(4326008)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?b2Q2TStPOVpSMXBZNnpHS2UxS3lDWUpuTkdOdVpvRkg2eWtmL1E5WUEyV1ky?=
 =?utf-8?B?bG9PajZDZU5LSlNSUXE3SW5XTitrSFMwbmxncmVocE54VHBVTkRoQm1DL2Zs?=
 =?utf-8?B?U0JyUGU4YXRZRVczSUdqMnBhaEtxTFZBSW5sajd6bzJEb2Z2RHlobG8xUXJu?=
 =?utf-8?B?SlZQZCtZenVlaUxKbUl1TjVtdWNTSjlNTmtnV21QZ1A1aTVHMzlUMzRYa3dY?=
 =?utf-8?B?NWhEUnNkdlhVWjFwd0gxNVJCMjE5SkM1OU1aZ1JuWjdXNVZlL1lVcHBRN1pT?=
 =?utf-8?B?U2JKMHR0STBzTWpYV1FST0lRQkhQUzVHZ2VKNHlJaUF3NUpHbUUxYVBxV1Vn?=
 =?utf-8?B?Vm5tN1RIM0pHVUNacUNjelMwRmE3R0x6d1Y3YnkzKzVMcitWaEpFTlN4ejhP?=
 =?utf-8?B?amtkWDBwZFJidmFnbTNOaW02cVZSZ2R3Y2lxV2hCb0lvUkRGam1aRjVRZndP?=
 =?utf-8?B?MXR1alJUYXpPYTlhSTZtcUgxWE5qNVRZZW5iMHBNZnkxNFBtR1VIc3FIODhE?=
 =?utf-8?B?VUt4NytzdWlUM0F2OWZPRE5EZ3N6OVNBTkhzdmtoY3k3ZC9hanNOUGJ4S29v?=
 =?utf-8?B?UUYzNWhWdjF3QThZYXJreTMwTHN4S0JRYU9wS3ZKSjU2VWREYUovR1JZZXd6?=
 =?utf-8?B?cjM0ZW1ZcjdsM0JOWWRzUVQ3d3BPNjZkalJJRWpkaUNMZlowejlvbFoxTDds?=
 =?utf-8?B?ckU3c1dGMlI3L1Z3TmtZajQzMXlORXdqQWovcC9KZ0hHKzRKTm5QcDlUdmZs?=
 =?utf-8?B?cjJmeURVYno0cXdCb2dXaW9zRGdaVVM4TVR0c0d1T2g0Q3BtTUo2eGZST0ph?=
 =?utf-8?B?Ri9XSlQwdHNZMlQ1VXVsOUtKT3kyclk3ekprQ1RjbGw2UnpSV1BsVk5VYm5y?=
 =?utf-8?B?MERySFpLZXh1QzlmS3dWcFFzS05LeC92WlJHN0xrWFpXRTZncDh4a3ViM0lq?=
 =?utf-8?B?bzhmTDQrZzBUNzFzaXlEdmtBemZqZ1R3MldPbzVaSnV1RlZUWEppY21aL1V4?=
 =?utf-8?B?OXAyMHA3aVRLL2Q0em1Nc0ZqcWRpQ0YxMTN5WFI2N2JUUm50VXQxUU5zVTlq?=
 =?utf-8?B?Vi9QbmFhZDAxNzVqNktzZjZiYVhSa3lJakQxc2FhQUQrOUY1MXBlMTFlMmtt?=
 =?utf-8?B?MGxpZytlSWFnMEpOVHpXNGxYK2trUWo0bnkvMkpTSDVCVm1ISGtXTm1KKzlu?=
 =?utf-8?B?RWNjSERiVlc0eUFKSnQ0aUlKWXpIWFh5M1JadzdIQ2s1cUtPVU5nQkJkYWVa?=
 =?utf-8?B?b2tZOUJPL1grMXUwb3BOak5PdG9Bb0VtZ1RoWVgzWDA3N254U2l5MDU3YTk0?=
 =?utf-8?B?aTBucjhWbnRmL1ZGTDlpejhTQUkwVjFGMFJJcWJid1hPeTM4dHVZdSsrdEF4?=
 =?utf-8?B?aCtoRklPRlI0UzQ5NUdodW5JM0dqUjdnb1ErM2FRYTVwc3hyV0tZa0hEVmxv?=
 =?utf-8?B?RTVYMFVJMyt1aVJKTFVmWGlDN0dPOUIrVnB3R24xUnVIMVNJeEorWEwzTG90?=
 =?utf-8?B?a3l3VDZhS09kRkVheURtbWNuWlRMWmZHWFpMVXhoSVRWeEVVZVBFU0dOQndR?=
 =?utf-8?B?Q2R5eTB2TXNVTXhWSXp4MkcvbWtqSmwyMUY1ZzZLa1g1MlpKNWRvZWo0MUxL?=
 =?utf-8?B?T29ES1lpQlkwRFFQNWViNFBLL3h2YjRjVmFxem1UOFFqNmxEd2liZXlSSEhi?=
 =?utf-8?B?U0l4U2hHQzRFWTlZcVpIZklmenBlVHhSUkJINitmY1JIZ0ZCZU82VkpNV3lq?=
 =?utf-8?B?YVZ4NHJFZTJnQ0xoOTU2bDBYVHh6UkJ2V29lVG1GMkJFTlU1V1l1eU10a1ZH?=
 =?utf-8?B?RWM0ektGYisvYTlreWc4eExaU1NSV1JWNURuMGZKaFA0WGhPd0ZFbzJTVUhk?=
 =?utf-8?B?MFdKdFV4ZHFuVm85TSt4UXNrcS92MVBzOXVUbmxpbEIzSDV0OVRKTUtYa2x1?=
 =?utf-8?B?VWhxT09tc3BqcEt6R1F0RzdJblZxZFlxeGV0KzNOWTVYY04zbHMwL2I2bmdE?=
 =?utf-8?B?UnRkSWdOKzB4SExmVlUvbXB6N0pyUFRyMGpWUVdzeUMvcWZPNTlJNkdCVkR2?=
 =?utf-8?B?Wk1ncDZqQ2tkTnhGOUNJOEkxT1MwV3h6dE9xSnQ4Rkc3TFc0NE9Uam9Rclo1?=
 =?utf-8?B?RExnL001UVNjaUtOYVFjUVpqVnkxdVNNNTVwcUdiTEtoOVRwekJXd2sxditw?=
 =?utf-8?B?RklEWFNVSEFaRmd5UEg0SzIvM0hmaWszck4vd1JRMldZUXFGWkRYMzVtcHpp?=
 =?utf-8?Q?8quyouoRJKM6csLFiMtdpOTJNLvEcsvvjRdOxEp37Q=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C565C333DD93604D8832BCFBCCFCED47@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17eb0860-f29c-46fe-4dd5-08d9a4eb1949
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Nov 2021 08:13:09.6261
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zpHAt582iIN9zfPag7KVKOO8cnM/wYlkZM0DNg20fZh7P8Otb5RzoOPGDdRuFF4s4Rj5JdoDtDvPOvJEDRnKJA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1821
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

T24gMTEvMy8yMDIxIDExOjQ2IFBNLCBDaGFpdGFueWEgS3Vsa2Fybmkgd3JvdGU6DQo+IEZyb206
IENoYWl0YW55YSBLdWxrYXJuaSA8a2NoQG52aWRpYS5jb20+DQo+IA0KPiBTaWduZWQtb2ZmLWJ5
OiBDaGFpdGFueWEgS3Vsa2FybmkgPGtjaEBudmlkaWEuY29tPg0KDQpJIHdhbnQgdG8gbWFrZSBz
dXJlIHRoZSBuZXcgUkVRX09QX1ZFUklGWSBpcyBjb21wYXRpYmxlIHdpdGggdGhlDQpkbSBzaWRl
IGFzIGl0IGlzIGEgZ2VuZXJpYyBpbnRlcmZhY2UuDQoNCkFueSBjb21tZW50cyBvbiB0aGUgZG0g
c2lkZSA/IEl0IHdpbGwgaGVscCBtZSB0byByZXNwaW4gdGhlIHNlcmllcyBmb3INClYxIG9mIHRo
aXMgcHJvcG9zYWwuDQoNCg0K

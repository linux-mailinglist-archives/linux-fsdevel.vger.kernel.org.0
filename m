Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47D29567AEB
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Jul 2022 01:55:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229543AbiGEXzO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 5 Jul 2022 19:55:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbiGEXzM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 5 Jul 2022 19:55:12 -0400
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1anam02on2083.outbound.protection.outlook.com [40.107.96.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91AC226F;
        Tue,  5 Jul 2022 16:55:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cXXNHAIko9wwpJj5o/Qg9LvyMilin5gcb8aWkJw8hsD2/YY1yHRYGTMWbhV4F1eozzaJLTNbFLj7tsKasvncxQVXNwsP2jW9Zw/uoBcF7oOAC61JHEZcXuGWFVp/JvgO8YG28eKvDjFF/6oSi15g1y6rM8cLvHCuWCsMBT41oWV3rxM+t99oDW0GRiWFG2d2xbdzTe/gXRIDfo04ZNGAvxRktw5ubAvDWiuTmtfOYKGn07JXc4bkwbJLsFPFaJNOSV+eHw+W9PyQQgqllzNPcFy3jsnfonMbcWwHumIohtRfbSb/KVDVFoKoEhcNCkS/XI0Her76jI1MOMuPEk9jwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dsOYEg+suvhkHM+irjNZFtZ/gva1LdXSbhXID2yugU8=;
 b=VOvhpdblcU+2ux8uOQDkIOjPDtpAQplMtIMwyHIPOPtWjsoPHx5gPByrHJOS65FG2eX83D8KFEeS+Kf1aTPpq10+arKJvqhMPiQd4eMPecLU5aedyFB85L0BJihcGA2rMAcIiq4kNxg2BR0ot0l0gMF4iB8I5m4y7J11Zrbu/sfD13+/8YgrRqReDrj7HJWkKVDYxuj5DRcyeNV33ZTMWWaIuPVuYGzBr1+qDQAnMtWHA2HxbN8vHzPajjqQLp/EwKNu5/2UFVPoL5EhwUyCPpcxYm++Mu4S+7X6OMp4Rndt5x9E97X2kKdPYU1N6XLHR3YIq1DdNMOsSs3saEO/Kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dsOYEg+suvhkHM+irjNZFtZ/gva1LdXSbhXID2yugU8=;
 b=IdHmcw0xnP06Rout8XI9zOfGkAS4UFTsli7vWlECi6V+jA57qiCcaYEckL8KiXAWlvO2wP2Ei06ySmip5MKOzhNFkjblTdf2kqTZip+13Oa7WawD84pUiVr4x/ophPIklmyAmfIt4lS+4nIVt/2JBxTKbQJAfEUKFAIuGkgvDbQrcn1wQdH4gB/wMM8LJvicU4M0ih+RRiIolfB9AVqef7psEGu/lvArspmJ9fXjCsQ2GNoO6Az2bjqPO4TWtQ0FwLNC3wJYkGo3WSIPG+/cOZaDLdAP79uxfXk6YsUMzA0r/4ttaIChjDWGBO7GT6vepKKZ587mqpBUavKBdiAE9g==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by DM6PR12MB2761.namprd12.prod.outlook.com (2603:10b6:5:41::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.18; Tue, 5 Jul
 2022 23:55:09 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::240b:5f1b:9900:d214]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::240b:5f1b:9900:d214%7]) with mapi id 15.20.5395.021; Tue, 5 Jul 2022
 23:55:09 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Christoph Hellwig <hch@lst.de>,
        Chaitanya Kulkarni <chaitanyak@nvidia.com>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-raid@vger.kernel.org" <linux-raid@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "agk@redhat.com" <agk@redhat.com>,
        "song@kernel.org" <song@kernel.org>,
        "djwong@kernel.org" <djwong@kernel.org>,
        "kbusch@kernel.org" <kbusch@kernel.org>,
        "sagi@grimberg.me" <sagi@grimberg.me>,
        "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "javier@javigon.com" <javier@javigon.com>,
        "johannes.thumshirn@wdc.com" <johannes.thumshirn@wdc.com>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        "dongli.zhang@oracle.com" <dongli.zhang@oracle.com>,
        "ming.lei@redhat.com" <ming.lei@redhat.com>,
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
        "jinpu.wang@cloud.ionos.com" <jinpu.wang@cloud.ionos.com>
Subject: Re: [PATCH 1/6] block: add support for REQ_OP_VERIFY
Thread-Topic: [PATCH 1/6] block: add support for REQ_OP_VERIFY
Thread-Index: AQHYjGHTGA1KUuSqQ0qn1A7ygjqAAq1ve0IAgAEBS4A=
Date:   Tue, 5 Jul 2022 23:55:09 +0000
Message-ID: <dc23bece-359e-0da8-c7fc-4e632169b22f@nvidia.com>
References: <20220630091406.19624-1-kch@nvidia.com>
 <20220630091406.19624-2-kch@nvidia.com> <20220705083416.GA19123@lst.de>
In-Reply-To: <20220705083416.GA19123@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bbf24dd0-a4fb-4730-cac9-08da5ee1cb22
x-ms-traffictypediagnostic: DM6PR12MB2761:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: E2a/Ytb8+az75ZpPLL4JhdE99FU4vqRt4bFsy+esl9zZu2ziqS0lNNBjfR5y/CIdikiE+6VcxAWFGKEqIVkrUiRryID7o4+9V8oFLT5fm6QMmp04Qsyqco5qD/pexXTVM/OO3jf8ohC29k1CiwSJAbb2w6YVnQM59yZr0GkI4Pg4oqr+l5NptDeN1iakDkbfSL4ftYyAO+ajZtCSkKp1gIhi+SIamuzMuXBsWguxqNWTgrp1sGX6ZEnrvfQYwlavzoTB+YP5kDa2NIc5NLB+PJVBqTbDugBSruHcGHGaTj7WtDO6+zL4gfcKK29OJAS8ZaV8AXnvNocLRpMae8XWOkvnnBuec7FQEfeSF2grwjW4xt67P0ct6ECeuQCooqhqNsudZ2I8OczHNwr8iGOJ+x9YRUhsBiJpO7md8zDiyp96fHdllGWKg+laJB37v5yLo5Ba+ThbKwHq85KGnDjPblyo/xkI0U7AjLr7W2tMRyXqy/Sd2q251Z34P7Hb+oGOQqMNlwsBmkSGZKuHBHoQHdtHwe3UIer22JyZEyC0/GbPMrLLyS6H0qQdy5wyO5mYiPzFNqzMwt8tgnRYKgaGtmPMgVVGo4SpJ57RZUDI9P+l/clpQ1oE/uoDu7e+M4B/Zvs136FHllL42yq9RC2skXFppAk7E8ClMigxfyKJlNBlhevaEN+LdWAJ4l3Kbx/YTRXUJ3AECQPMhMq299PNabBDW/yvVH7C8ikThA+ip2wRHEZTafhkVRv4zKl42I9/AJ6+nT6kpklSyaFptyGW4uNv02LHLxl4BPvCTreGj5/AVQz+4U4HEZoe0c6fB9FxADhhYp0+SAd4plcXsP29QF47cgapuv1+Oeuus/oHIuXER9n+W6Lgn7n34Tw+70vg
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(39860400002)(376002)(346002)(396003)(136003)(6512007)(53546011)(71200400001)(478600001)(2906002)(7416002)(6506007)(41300700001)(31686004)(4326008)(86362001)(31696002)(36756003)(122000001)(38070700005)(38100700002)(6486002)(8676002)(110136005)(186003)(2616005)(5660300002)(316002)(54906003)(8936002)(66946007)(83380400001)(66476007)(64756008)(7406005)(91956017)(76116006)(66446008)(66556008)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZDNLb1h5VlpLNEMzOXpRb2hQbE1qMk5qR2RmOEMraExUc25xZ0I2V1gzQVRF?=
 =?utf-8?B?WXRkam1UUmJUZzZ6WjZJR3VhMExSREpKNm5NMG83Z1RKbVJ0QzhnaEUvYVJl?=
 =?utf-8?B?QWpTQ0Z4blFWNUNkRSszR0VIdGdSUitvUlFwQnJjN1F6TVN3TEpEVDhpaTNs?=
 =?utf-8?B?S1ZqbituaFBvUWh0c1lwQ05lUWRrdmMrNGdSNUlVSzVqYkh6RWFZdHYzajJp?=
 =?utf-8?B?Njh4L1BRZjE1K0VONkFxNWNwZHhtczNlNFE2VnI1aEZNZm1vOGc4MGpmQ0pH?=
 =?utf-8?B?cHU2b1NpUnJQNEh6eGdqYkxxQ08xUnVzV0VyclArUzZoNDlOdEtvY3NDYnJK?=
 =?utf-8?B?M2Vlbmk0Si9CTnVGSkdMZlhMTEJVditSN3ZQVTlHTFJCaTkxTXBKWTRISkRG?=
 =?utf-8?B?NW5TQU5mZjhVQ3U3UXZVcWtwdlRmN05zQk82SHcrWjYrVnRNblVwME1UekVT?=
 =?utf-8?B?L1g0TzljZm9aZ2dCM2RvWFlkSDlRZFFiYjlPcUppUUt0ZFpRWW1FK1RSbmVO?=
 =?utf-8?B?L0VOeTg4VDNkVTk5Qm9SNExKL09RcC9OSHpMc3Vja0NqeWc3SmYweDZMeENt?=
 =?utf-8?B?cG9CbTJiQVBEZTJnMDhqVEgyOWxWQ0QzOUVmcUt5K0p2TVVmZ1Q0QXRsN1Fv?=
 =?utf-8?B?K2p1SUE2RVNGYndJOFJXaEtoWEprZXdTM1dYQkVTSmVEYkg0MHBNaFg3TDFt?=
 =?utf-8?B?SjhYMUZUdzlVQ2RlYU5ST1hPQURZSm9VVGlhVWhPY0Q3bDc0NS9kL21LaDV1?=
 =?utf-8?B?OW9USEFtdVVnR1pmNUxHT1kvM3gyUjBPQk5nS0oyNzJMT2FPUmFRbzRoZTF2?=
 =?utf-8?B?VE9Kei9mMHRNTkUyWFNEUTcveDBSTUhDU0pudTMyZEh4T1kwZi9veGJrdWI4?=
 =?utf-8?B?SFlPRGpYRTNQdnhoUGRaRThJOVU2ZUxLcVA2eXlBRVI3a2hmWVdDSWcxaG5x?=
 =?utf-8?B?cWRySjRSOXdpQTgrSUtUM2t2bHRXd1R5MDJNM0RjcENLa2RGQmxxaTFCNm1K?=
 =?utf-8?B?dXZXRE5FOUxQeEp5SGlDcHdVT0NWcGpTUjNVcDV0RTRWSU5vcm84VWJ6Rmtj?=
 =?utf-8?B?c3l5UE5UMGwzZlhseVNMRWkyaEZXaVBuVFA2N1BhM1A3Uzhma2NHSk91bkV2?=
 =?utf-8?B?R3pHN3FubmFBOHBVRUdWY2FNc2hESFRNSDR2bkdQV0V3RlRSOFl0NHZFMHox?=
 =?utf-8?B?KzZpd2hDQmVnZGtnTDZCTkttWjJRRE9wU3ZCclI1M0YxQUtSVjJXWjVMTitD?=
 =?utf-8?B?aU1ZV2hzQSs4Sndna3JjcDNyYkF6ZTd5SHJpTmtrcjR2RFBqMU5lSC9hcHFY?=
 =?utf-8?B?ZE1UL3lsc0dPbXlsbStIRG9hb29oK200VTM3V1RWdC8vWksvbE9JZkdkNVFo?=
 =?utf-8?B?UTJDUlNCVEJLajl5QVpVYUlNZmpvRzdzOUptcnp5V2ZhSEdiRHREU3ZRN2FV?=
 =?utf-8?B?V2cyWWN6akpDS09Fb1FlWUhrNE10ZkRsQlc0bGl0R3paLytjVE5TNnYrc0dW?=
 =?utf-8?B?NEpxQkxuVE9SWmJyQjVuTDNKeU1BaHkxSVpZMko5d3Q1QjRFTll2eFRBc3c3?=
 =?utf-8?B?d1U2N1lvNVhSRkZzQ2hjWFl2dGV2UHJGTHc1cDlxSWFYc1V6ZVBPQUdKVGR3?=
 =?utf-8?B?YTljQzRpTmMzT2wvaG1VTmJsejNyZDk5MUNDNmUwRktWeUE1T0crV1o4MEtE?=
 =?utf-8?B?dzc3RTdoMThoc3dQbjdJaDlEdTRFTFpHZGxzSHhHTklTOTZ0QzlpWlpTTHNi?=
 =?utf-8?B?WUZ0MUxDOHN0RU5HUGY4SE5wOURkRThzL2tud1R1ZEUzcUxSYm9iTlhldHpt?=
 =?utf-8?B?Z2lLcEkwNUlvMWNESWpBNEptUEU2eG1oQWVpMHUraExxZm9KNFNRdWViYXRz?=
 =?utf-8?B?RVhoaTZJTjl6L0dCZ0EydXRIQlJoaDlidm4wQjFQZ2FvK3hDY2kvMGtMTUti?=
 =?utf-8?B?QS9kUXowMmVOcmc4QUgvMHJDS1BpWGRmRFcwMkl5V3JrZDhFMVhSZzZ5ZUFQ?=
 =?utf-8?B?dk1ybFRVUlNCYjQyVTRoTjV5MzdGNkZNU3NQZVVLczZ4YmVXVkJQN0lwZUtU?=
 =?utf-8?B?OHBjeEVUMk1QNC8yS3lEZkp2ZE5Oc1ZGVWJESWx4dFZ3bWdEWnI4aEhuWVA0?=
 =?utf-8?B?MWw2UXB6dGxNRWQ2Y1ZuVCtMSWxrTFJUa1FuRDkyZ2gyd1cvRk9iV0hoTGt2?=
 =?utf-8?Q?sVH1ruW0lnZbZIBAB7LxkiMbt1a9GwGtqNujTq6ZeGaQ?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0597DAF5F1608D4BA2ABABC58F5011AA@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bbf24dd0-a4fb-4730-cac9-08da5ee1cb22
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jul 2022 23:55:09.4741
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fQLKo6cRsK35lH28FGiB/syGBT9vZa8oejVC8TRcMlWkzLDQrmz9FowMte58C7umYyDsHjW0nDtsGKZW2qKsdw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2761
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

T24gNy81LzIyIDAxOjM0LCBDaHJpc3RvcGggSGVsbHdpZyB3cm90ZToNCj4gT24gVGh1LCBKdW4g
MzAsIDIwMjIgYXQgMDI6MTQ6MDFBTSAtMDcwMCwgQ2hhaXRhbnlhIEt1bGthcm5pIHdyb3RlOg0K
Pj4gVGhpcyBhZGRzIGEgbmV3IGJsb2NrIGxheWVyIG9wZXJhdGlvbiB0byBvZmZsb2FkIHZlcmlm
eWluZyBhIHJhbmdlIG9mDQo+PiBMQkFzLiBUaGlzIHN1cHBvcnQgaXMgbmVlZGVkIGluIG9yZGVy
IHRvIHByb3ZpZGUgZmlsZSBzeXN0ZW1zIGFuZA0KPj4gZmFicmljcywga2VybmVsIGNvbXBvbmVu
dHMgdG8gb2ZmbG9hZCBMQkEgdmVyaWZpY2F0aW9uIHdoZW4gaXQgaXMNCj4+IHN1cHBvcnRlZCBi
eSB0aGUgaGFyZHdhcmUgY29udHJvbGxlci4gSW4gY2FzZSBoYXJkd2FyZSBvZmZsb2FkaW5nIGlz
DQo+PiBub3Qgc3VwcG9ydGVkIHRoZW4gd2UgcHJvdmlkZSBBUEkgdG8gZW11bGF0ZSB0aGUgc2Ft
ZS4gVGhlIHByb21pbmVudA0KPj4gZXhhbXBsZSBvZiB0aGF0IGlzIFNDU0kgYW5kIE5WTWUgVmVy
aWZ5IGNvbW1hbmQuIFdlIGFsc28gcHJvdmlkZQ0KPj4gYW4gZW11bGF0aW9uIG9mIHRoZSBzYW1l
IG9wZXJhdGlvbiB0aGF0IGNhbiBiZSB1c2VkIGluIGNhc2UgSC9XIGRvZXMNCj4+IG5vdCBzdXBw
b3J0IHZlcmlmeS4gVGhpcyBpcyBzdGlsbCB1c2VmdWwgd2hlbiBibG9jayBkZXZpY2UgaXMgcmVt
b3RlbHkNCj4+IGF0dGFjaGVkIGUuZy4gdXNpbmcgTlZNZU9GLg0KPiANCj4gV2hhdCBpcyB0aGUg
cG9pbnQgb2YgcHJvdmlkaW5nIHRoZSBvZmZsb2FkPw0KDQpEYXRhIGJsb2NrIHZlcmlmaWNhdGlv
biBpcyBkb25lIGF0IHRoZSB0aW1lIG9mIGZpbGUtc2NydWJiaW5nDQplLmcuIHNlZSBbMV0sIGhh
dmluZyBzdXBwb3J0IHRvIG9mZmxvYWQgdGhlIHZlcmlmeSBjb21tYW5kIHdpbGwgOi0NCg0KMS4g
UmVkdWNlIHRoZSBETUEgdHJhbnNmZXIgYXQgdGhlIHRpbWUgb2Ygc2NydWJiaW5nIDotDQoNCklu
IHRoZSBhYnNlbnNlIG9mIHZlcmlmeSBjb21tYW5kIHVzZXIgaGFzIHRvIHNlbmQgdGhlIHJlYWQN
CmNvbW1hbmQgdGhhdCB3aWxsIHRyaWdnZXIgc2FtZSBiZWhhdmlvdXIgYXMgdmVyaWZ5IGNvbW1h
bmQsIGJ1dA0Kd2l0aCB0aGUgRE1BIHRyYWZmaWMgd2l0aCBvcGVyYXRpbmcgc3lzdGVtIHN0b3Jh
Z2Ugc3RhY2sgb3ZlcmhlYWQNCm9mIFJFUV9PUF9SRUFELiBUaGlzIG92ZXJoZWFkIGdldHMgZHVw
bGljYXRlZCBmb3IgdGhlIGZhYnJpY3MNCmNvbnRyb2xsZXIgd2hlcmUgaG9zdCBhbmQgdGFyZ2V0
IG5vdyBoYXMgdG8gaXNzdWUgUkVRX09QX1JFQUQNCmxlYWRpbmcgdG8gc2lnbmlmaWNhbnQgRE1B
IHRyYW5zZmVyIGFzIGNvbXBhcmUgdG8gUkVRX09QX1ZFUklGWQ0KZm9yIGVhY2ggcHJvdG9jb2wg
U0NTSS9OVk1lIGV0Yy4gVGhpcyBtYWtlcyBpdCBwb3NzaWJsZSB0byBkbw0KYSBsb3ctbGV2ZWwg
c2NydWIgb2YgdGhlIHN0b3JlZCBkYXRhIHdpdGhvdXQgYmVpbmcgYm90dGxlbmVja2VkDQpieSB0
aGUgaG9zdCBpbnRlcmZhY2UgYmFuZHdpZHRoLg0KDQoyLiBBbGxvdyB1cyB0byB1c2UgdG8gdW5p
ZnkgaW50ZXJmYWNlIGZvciBhcHBsaWNhdGlvbnMgOi0NCg0KQ3VycmVudGx5IGluIGxpbnV4IHRo
ZXJlIGlzIG5vIHVuaWZpZWQgaW50ZXJmYWNlIHRvIGlzc3VlDQp2ZXJpZnkgY29tbWFuZCBzbyBl
YWNoIGFwcGxpY2F0aW9uIHdpbGwgaGF2ZSB0byBkdXBsaWNhdGUgdGhlDQpjb2RlIGZvciB0aGUg
ZGlzY292ZXJpbmcgY29udHJvbGxlcnMgcHJvdG9jb2wgdHlwZSwgb3BlbmNvZGluZw0KZGV2aWNl
IHBhc3N0aHJ1IGlvY3RsIGZvciBwcm90b2NvbCBzcGVmY2lmaWMgdmVyaWZ5IGNvbW1hbmQgYW5k
DQppc3N1aW5nIHZlcmlmeSByZWFkIGVtdWxhdGlvbiBpZiBpdCBpcyBub3Qgc3VwcG9ydGVkLCBz
ZWUgWzFdLg0KDQozLiBBbGxvdyB1cyB0byB1c2UgY29udHJvbGxlcidzIGludGVybmFsIGJhbmR3
aWR0aCA6LQ0KDQpGb3Igc29tZSBjb250cm9sbGVycyBvZmZsb2FkaW5nIHRoZSB2ZXJpZnkgY29t
bWFuZCBjYW4gcmVhdWx0IGluDQpkZWNyZWFzZSBpbiBkYXRhIGJsb2NrIHZlcmlmaWNhdGlvbiB0
aW1lLCBzaW5jZSB0aGVpciBpbnRlcm5hbA0KYmFuZHdpZHRoIGNhbiBiZSBoaWdoZXIgdGhhbiBo
b3N0IERNQSB0cmFuc2ZlciArIE9TIHN0b3JhZ2Ugc3RhY2sNCm92ZXJoZWFkIG9mIHRoZSByZWFk
IGNvbW1hbmQuDQoNCjQuIFByby1hY3RpdmVseSBhdm9pZGluZyB1bnJlY292ZXJhYmxlIHJlYWQg
ZXJyb3JzOi0NCg0KVmVyaWZ5IGNvbW1hbmQgZG9lcyBldmVyeXRoaW5nIGEgbm9ybWFsIHJlYWQg
Y29tbWFuZCBkb2VzLCBleGNlcHQNCmZvciByZXR1cm5pbmcgdGhlIGRhdGEgdG8gdGhlIGhvc3Qg
c3lzdGVtLiBUaGlzIG1ha2VzIGl0IHBvc3NpYmxlDQp0byBkbyBhIGxvdy1sZXZlbCBzY3J1YiBv
ZiB0aGUgc3RvcmVkIGRhdGEgd2l0aG91dCBiZWluZw0KYm90dGxlbmVja2VkIGJ5IHRoZSBob3N0
IGludGVyZmFjZSBiYW5kd2lkdGguDQoNClBsZWFzZSBub3RlIHRoYXQgYW5hbHl6aW5nIGNvbnRy
b2xsZXIgdmVyaWZ5IGNvbW1hbmQgcGVyZm9ybWFuY2UNCmZvciBjb21tb24gcHJvdG9jb2xzIChT
Q1NJL05WTWUpIGlzIG91dCBvZiBzY29wZSBmb3IgUkVRX09QX1ZFUklGWS4NCg0KLWNrDQoNClsx
XSB4ZnNfc2NydWIgaXNzdWVpbmcgdGhlIHZlcmlmeSBjb21tYW5kIDotDQp4ZnMtcHJvZ3Mvc2Ny
dWIvZGlzay5jIDM0MDogZGlza19yZWFkX3ZlcmlmeSgpLT5kaXNrX3Njc2lfdmVyaWZ5KCkNCg0K
DQo=

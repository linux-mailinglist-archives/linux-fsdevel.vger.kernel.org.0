Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E47F75674BC
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Jul 2022 18:48:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232064AbiGEQsB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 5 Jul 2022 12:48:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbiGEQsA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 5 Jul 2022 12:48:00 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2089.outbound.protection.outlook.com [40.107.244.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86C1515717;
        Tue,  5 Jul 2022 09:47:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KSeJkEpgYofeKm8t37vmhsrw/8AXzdgYWxoriyc/0VNnQX+TaYtMaiXA2hcG6nHYwDmNHpBIIn3pOVrbTFel1a24iQ3f6D7u6gzXh2aZUxckLOVxe5ME8x4EwxQaGazBaBJUurQJ2Uu1BiLWY9pYQjRO+j0wBiBwxlxCBLyzpiPEkKGIxnngYRtiJ5vIQ8xw3JCZ9QHsNGAaUw/pcHJirNh8wxpbCrmUhsM8d5ycZiqvaHQLSSIFL4p1pyxmzuW6IfnL6vWlj4GxwdgeS+Wf1c1z0U3RP3VOmyQsR1xC5nQB++WqUxJBmahCMDfX3728d+oPU8bAhDgqFxRD+CCAGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9+xjtf/oQOuHF4M2tuF+rksWR8SWVyhHS7jZr3ay/ms=;
 b=ezecvITcKpYLhAa1tsch6HR4XntFibZM39NjXDIqE8uwTnkzOf5eFI3dEEq3bewkuFZwt45ThAgl2YV0ZvE4UTQEkGc47IKuQbXzrHleOCe1JIUme+24Xw5W2qAxYMdgsqoNqA8dqYoTcDJTrYn49X3aKahMrIDI06Ti6kzSMTMe6PO0BBErPGU1+cn1O+aP/7qmi4z/Il+Ag1S7ilPfiBCH8/bcIgTJOhg2m/cgNUL+BlzVLCZAAJvvZeRWeThKiY9pLND/mtlBK4NRKXG4PKUezr9mSnymxXfNztQyY6NhngxAkc6b37sKX1N8kgiQuqbAzBhxYH+tCSpagU23oA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9+xjtf/oQOuHF4M2tuF+rksWR8SWVyhHS7jZr3ay/ms=;
 b=tLwSFdRm7Jn1xso9rY4UNvcZ42zhSKx6dIV+ffsQ3Ou7/kH63mATbFjS4a6tPC5wp0cfPPZqF7rMbYGpsl+Orgy1tnA0s6t7N2qOCOldROJEhrDAD9H6lckiRv2hHyCXsOQGqfIldaAf0ZaTS7ADobf2HC1pHlfrCz7D0lxdIt2w4FoKW73sIye+SM/cmQZekPeHCy8g6nUL7S9mQbci8xcutxPnrlLwAJy0TK23T1BSFWcDsbp41nxlcQwAIQZcRcpvTlUsXy2tCTnOhwnVUJXJMabeYGzHxwiYCwHrNRJyjM9tpqnQEqdno3Y6DfHYf9HN4Srs2CsBUcTn2joS4A==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by PH7PR12MB5710.namprd12.prod.outlook.com (2603:10b6:510:1e1::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.20; Tue, 5 Jul
 2022 16:47:57 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::240b:5f1b:9900:d214]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::240b:5f1b:9900:d214%7]) with mapi id 15.20.5395.021; Tue, 5 Jul 2022
 16:47:56 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Christoph Hellwig <hch@lst.de>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-raid@vger.kernel.org" <linux-raid@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Chaitanya Kulkarni <chaitanyak@nvidia.com>,
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
Subject: Re: [PATCH 0/6] block: add support for REQ_OP_VERIFY
Thread-Topic: [PATCH 0/6] block: add support for REQ_OP_VERIFY
Thread-Index: AQHYjGHN/dRfjWV95kG4kItzDx62xa1vfFGAgACI3wA=
Date:   Tue, 5 Jul 2022 16:47:56 +0000
Message-ID: <551c2c6b-a85c-4528-5a0f-c8205e7d002c@nvidia.com>
References: <20220630091406.19624-1-kch@nvidia.com>
 <20220705083803.GE19123@lst.de>
In-Reply-To: <20220705083803.GE19123@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 026b2219-0608-4c3a-6b78-08da5ea61cde
x-ms-traffictypediagnostic: PH7PR12MB5710:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: =?utf-8?B?RFZIdlR4MWJpNHhsZ21YNDFjWktOVGZyUTR2eU0rcmpET28wZndDbWlaYTJa?=
 =?utf-8?B?bGttMkd6V2xzWVJwcG1hYWMxVmtoUkJoL1Buc3BvS0FISWdydHByYVdzby9I?=
 =?utf-8?B?Tmd1TlNEd2REVkR2bFRuNDI0RTZPam5FWXZ4aEtuUFNtVERoaFk2bFBKR2RG?=
 =?utf-8?B?L3I5S1VnVE93TFBRU3pVcDVENTZXQVVBOGhyT3hnT1dzSmQzQy8vUVNGdEhG?=
 =?utf-8?B?MjVQQ1prdGlHZjhhRmFNaUsxbGhWVDNuUFpPNER5TkJlbjdsb1ZGcjBlNEZO?=
 =?utf-8?B?YmxhaGZaVUNpNFk1eTV1ZU12cG5hQVdyTUt6WXp6WURWZnpseXY3ekszKzJR?=
 =?utf-8?B?WGJ5dnZseXNUbjNnSEl0NDRGQ2xnQ0ZKMW05RkJzUmVtUU9wNUwvM2ZkamQw?=
 =?utf-8?B?eTFwVkROdy9MOVJIYmgxbS93ZkttM0h0NmdIUjRVWjRmWWFzK1RlemlXTUpu?=
 =?utf-8?B?MnlqKzlmNFdYMHordW1IejhBK20yc3FTVTBtMGRVRHltT0MvT3hBT1JrdjNF?=
 =?utf-8?B?UVZVYTQyTjJTQU1RcjlJYXN0OG84TlNBN1ZPSGw1TEZjQVYxcGVXZVFjWlBG?=
 =?utf-8?B?ZGo3SFdhQzNRTDJtb3BhQitGaWloODUrb1BHbExIVjdqQk1UZUduWGplOVpk?=
 =?utf-8?B?VHVuRHhDeHdBcFBMVFhUdGM5QkNSam9wa29BcmtIQmduN1VOcEpCa0hLZkZ3?=
 =?utf-8?B?UHV2eUp1cGI5a0RoNUhERWM1cDdFTmVBMFoxUVp6V0dKdnlnZVJkZElBSXdX?=
 =?utf-8?B?T1BMcG1QR1BIZ3NDTnV3TmRwdUlHZVBDOS8wTE5zNHZxNC9IcXVFdHo4S2wx?=
 =?utf-8?B?cXBkTW5DN3lXeHlHeWNlN25ZcmRXeXIxelhGSkwvZVorUGw5K2lGNThLN1Mv?=
 =?utf-8?B?djFvRVduaDlZck9mOVgvZkNjUmJ3Y3ZCTzJnbDUvc09lb3EyamJvVHIxa08w?=
 =?utf-8?B?ZmdYMC8zNUppMVFFRU1qRUQ0N2FpR3hZYkNzNmw2NEMrM0lPT1hlRDB0K21S?=
 =?utf-8?B?bzZqa3pYMkl2SmEvSEw3TzFMcVAvZlRkQXc0QkpGd2FURGVCNS91T3kwbk95?=
 =?utf-8?B?RUVxRy9jUExDd0djbUNNSjR5V0pFdlJya0hBNlBJUCtsS3pWM0pxYjd5QXNt?=
 =?utf-8?B?ckQxQzcxRThEY0V2OFEwa1lvWHE2RWsyL2Nrd0Ryb0NOUHByMjY5SVNJVVlE?=
 =?utf-8?B?UU9qNVhTcWJhbTg2blZUbEFJU3RyekY1b29mTWZ3eHFoV0xBdlNOWU9WbDFB?=
 =?utf-8?B?dElFODZpTytNcm5UVEV3d2duYlBlNEtXZmtGVlVrRTAxeFlSUT09?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(346002)(376002)(136003)(39860400002)(396003)(478600001)(5660300002)(7416002)(4744005)(66556008)(8936002)(122000001)(7406005)(38070700005)(6916009)(54906003)(8676002)(31696002)(76116006)(316002)(66446008)(6486002)(4326008)(66946007)(966005)(91956017)(71200400001)(66476007)(64756008)(86362001)(2616005)(83380400001)(186003)(53546011)(6512007)(26005)(38100700002)(6506007)(31686004)(2906002)(41300700001)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?R3hMbDAvSExtSFZtMHNkSzQrLzJZaWdZcmM1alI2TVZRUVpsTTVzKzFRaTdF?=
 =?utf-8?B?djZ6Y3c0QmRjZW1odGxqLzl1TUxkWWVrU2U0L3VEb3JvVWpWRUJBQXc4VEVv?=
 =?utf-8?B?VzVEMkw1eGthMjV6Y3d1dXpvZG8vOENFYzAydmg3YVVGSmxTNnRYRkEzYW9K?=
 =?utf-8?B?QzlVV2l5dWdDS0RkUFphZmdFU3dJTGtjT2MrZUlxMUJLK1VNNnM2YTJSVUVr?=
 =?utf-8?B?TnJLUktwQW9GRktKZm1qaFM5OURTWG5XUGFaSFIrYWhVMUlhUWJYY2VvWVh2?=
 =?utf-8?B?Ym95NVZTWU4vVXh5d05oLzNKTG8zdUFzdUVWZExGck5odFN3cUtoVDZ3b0lY?=
 =?utf-8?B?NHgvNFcvS3RSVkx4c3NiU2lMTHNUWmZsSjNPamZCbUlWRStBQW1QNjVnRkU0?=
 =?utf-8?B?WUdMck5IQ2NTTGh1Z2VJWE82V1hiUnkwV0hHS3VsbS84cHJNeDVrZ0xQdVBy?=
 =?utf-8?B?WWtMTW55MEVmL0t3YXF4L1lKRDFhUDV5ejI5dmFMNEtJWHlaMVF4Wit0U3dU?=
 =?utf-8?B?dU12cmUyemtPRWpaQTNKTEtoRjVQNWcvbFl6bnNWdlRZZW9QTVJWNUdmRENY?=
 =?utf-8?B?VGNpK2xvTUxML25hQkNpa3EzY2tmTW1WV1RtU09XT0tHckFCZWJxYjg2ajBD?=
 =?utf-8?B?dGFSNHFudjdUcWk4TWVwK2ZNRjNJdkNKM0pCVWJsRHlGNGYySGFqLy8rbGxV?=
 =?utf-8?B?NDhtL1ZaWnlMbURrdnVGajVpS2RWUnpXbkErUkpoWEFmcDErRUhaNHBqUy9a?=
 =?utf-8?B?UWtNSlhVdWVjQ1RCQmpTTDhmVi9zeW9FOTVKdkZ0eThpUzljbDZlZXJwL2VP?=
 =?utf-8?B?c3BMejBlTzZQaWNVZWM2K0VYQk92MEF6QzRGRktST1FYaUlHV2UrVlpDanM4?=
 =?utf-8?B?YldWOTRXdWJKTnVDajZHbEF1RU0yMXdqZUFvK3lQQkt2Z3FyMXNsY054NTJR?=
 =?utf-8?B?a29BTkZkY2RSOStJZUNRcnIyNHBuOVpLbVE1QmJCYXRtbjRXSHpqMHF1Q1Qv?=
 =?utf-8?B?VW0yZ0QrN0dCMmM5OTRabEpXaE9OTGpWdXJxNEV4eitOMlUzRjJ4MFE2VlIx?=
 =?utf-8?B?ZXdZL1h4MjJKcDFSYW5relR0dUtyY2gzeWlvSDBrUlRvbDZYWmkvRkRYdmha?=
 =?utf-8?B?cHBRbm1KZzRDSE5hVmlwY0ZkYnA4R0JtSTNlZnB0WEhZNFYxVlpYVlBlWlYy?=
 =?utf-8?B?dEdwRVpQMi95eFZuVWRvcWQ3bFVydEJCVEYvckVHQkFpSDdXcVl6YllUQlph?=
 =?utf-8?B?MjlFRmhMdVpvendzM3MyV1dZdW5SdVV2ZHRvaC9iK3lnUU5mVDBiUTczZ2VZ?=
 =?utf-8?B?NS92VFhUMENuZ2oxbGJEdkRMNk96UUxmbmNPWk5kZFhLUFhrMkRqK3VqTE1q?=
 =?utf-8?B?cEk0NXNVU0U3R1ZHOCtWRXhOWnVRM1I5dGNlckQxcVZ3YmVveTNhWWVKZjRw?=
 =?utf-8?B?MmphRlQvclpmSXdnaVNVVC9tUk5YVlNmbVkvWkRUYW5hZGxsbGxSSVBQOTN2?=
 =?utf-8?B?a2RyU2pENVlVRkVRUzBIRXQvMHdFSjNNR1RBYlFMUDJOMWorWGdzUHB6cUJ4?=
 =?utf-8?B?TUVjQ2taVENCYmljQ2JyY2hTb1I2L1BqMGdBNXI1QXBFSnk1WWoreUV1NDlk?=
 =?utf-8?B?NGx6VE0xWVk0b3RFRmxjalhoNUpObVc5elprVTZhR3RHeGJDZUVBUjYxU2Fa?=
 =?utf-8?B?QkdGWFRhS3FlTTJQTy85NFQyd2tMbVRaRVFYTENTK3ZJUXBOSkQxWDlYS2xi?=
 =?utf-8?B?empSUEtsWHN3WnR3alN2M2xSRU05UFd2b0ZvSlJJVGVHK29zYWR3VmUwWm0r?=
 =?utf-8?B?Q1Jrdk0ybk92OUpQS1Zsc1hDdlh3WGVraXdtcDRmd1JvQW5ETU5YWTlLUXpv?=
 =?utf-8?B?MllYTDRYbWJWVEZLdHVBdktWOVhxL2Iyb0RWSE1JZERyZVA0alkwUWYwWE8z?=
 =?utf-8?B?QVcwT09Cd29Qam5ITDdaeTFYQVhzVUFOVHVJQk05UE1DeTViOXZIZTNzd1Vv?=
 =?utf-8?B?RjFtMEpkdm9IOGQ1ZVg2bXRxVk9Cc1ZxeXlBalBQa2xOMEJKSVRKNkdydldw?=
 =?utf-8?B?NVZ5V01sNmhsM29UMmVNeEgwV0xVYkM5VzF4TXpmbm45T0VSRUZrV2R0dUpz?=
 =?utf-8?Q?rOu1Mm1etjsEan3tPxOzyV9mX?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4E47C712F532B949811A8AD5CF074842@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 026b2219-0608-4c3a-6b78-08da5ea61cde
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jul 2022 16:47:56.7642
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: op+ohwUqT/bRnNU0c7dMcOph12sfGD2DzM6/N8V4R2FqExQ7Cs/KTSV6KG0AJ000etzfPvQw1i2iowkloYvZJQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5710
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

T24gNy81LzIyIDAxOjM4LCBDaHJpc3RvcGggSGVsbHdpZyB3cm90ZToNCj4gT24gVGh1LCBKdW4g
MzAsIDIwMjIgYXQgMDI6MTQ6MDBBTSAtMDcwMCwgQ2hhaXRhbnlhIEt1bGthcm5pIHdyb3RlOg0K
Pj4gVGhpcyBhZGRzIHN1cHBvcnQgZm9yIHRoZSBSRVFfT1BfVkVSSUZZLiBJbiB0aGlzIHZlcnNp
b24gd2UgYWRkDQo+PiBzdXBwb3J0IGZvciBibG9jayBsYXllci4gTlZNZSBob3N0IHNpZGUsIE5W
TWVPRiBCbG9jayBkZXZpY2UgYmFja2VuZCwNCj4+IGFuZCBOVk1lT0YgRmlsZSBkZXZpY2UgYmFj
a2VuZCBhbmQgbnVsbF9ibGsgZHJpdmVyLg0KPiANCj4gV2hvIGlzICJ3ZSIgaW4gdGhpcyBwYXRj
aCBzZXQ/DQo+IA0KPj4gSGVyZSBpcyBhIGxpbmsgZm9yIHRoZSBjb21wbGV0ZSBjb3Zlci1sZXR0
ZXIgZm9yIHRoZSBiYWNrZ3JvdW5kIHRvIHNhdmUNCj4+IHJldmlld2VyJ3MgdGltZSA6LQ0KPj4g
aHR0cHM6Ly9wYXRjaHdvcmsua2VybmVsLm9yZy9wcm9qZWN0L2RtLWRldmVsL2NvdmVyLzIwMjEx
MTA0MDY0NjM0LjQ0ODEtMS1jaGFpdGFueWFrQG52aWRpYS5jb20vDQo+IA0KPiBXZWxsLCB0aGUg
Y292ZXIgbGV0dGVyIHNob3VsZCBiZSBoZXJlLg0KDQpJJ2xsIHNlbmQgb3V0IHdpdGggdGhlIHVw
ZGF0ZWQgY292ZXItbGV0dGVyIGFuZCBmaXggdGhlIHdvcmRpbmcuDQoNCj4gDQo+IEFsc28gSSBk
b24ndCBzZWUgaG93IGFuIE5WTWUtb25seSBpbXBsZW1lbnRhdGlvbi4gIElmIHdlIGRvbid0IGFs
c28NCj4gY292ZXIgU0NTSSBhbmQgQVRBIHRoZXJlIGlzbid0IG11Y2ggdGhpcyBBUEkgYnV5cyBh
IHBvdGVudGlhbCB1c2VyLg0KDQpJJ2xsIGFkZCB0byBpbiB0aGUgbmV4dCB2ZXJzaW9uLiBNeSBk
ZXZpY2Ugd2VudCBiYWQgdG8gdGVzdCB0aGUgc2NzaQ0KY29kZSwgSSB0aGluayBzY3NpX2RlYnVn
IHNob3VsZCBiZSBva2F5IGZvciB0ZXN0aW5nIHVudGlsDQpJIGhhdmUgdGhlIHNjc2kgY29udHJv
bGxlci4NCg0KLWNrDQoNCg0K

Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6F164B9CEA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Feb 2022 11:17:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238856AbiBQKQj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Feb 2022 05:16:39 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:36974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235008AbiBQKQi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Feb 2022 05:16:38 -0500
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2078.outbound.protection.outlook.com [40.107.237.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73C981E4;
        Thu, 17 Feb 2022 02:16:23 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ga9aUr+zwdg12xdDfS4METp59Kr9vhosk7zdWLXbDPAJ/1BKTH16Y3Prcq0xlLJOhRAhUXIcLcHE6Hn+Xx5jP/wehjhR2mC0hvLTl0WY43J0pkZw4B20UtzPq62hJ8UAlacoucuG5Be5n4Fa+sidNJG5bYSJygE0IEhKqQ9l7DE+FE87Dqz+DilzsczzVOmAJzYatB5EOtjwrc6+HLvjjipqy7RdHAHWz7JbuPvXoh+qc5+q4w6MVp15oh/yagJOHfplEeqBc3u8w8Svd6GYUGPVq8w4bajVR+dNMOHeSfgSq6ym8RUifcgwMQ4/IVflA4lzLJDfLRkLcSdqOmCa6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xtyugX8pwkS9uiXsFfnYAD/NV/QNrthPqEQs5JVPKD0=;
 b=FE2B/6tFz4HyVwOFHKW6HzYQINuumW7KwgsTKww9qgy1LEEE3Bh+p+NgvZcQ/APUgIiNlYxPlkGxRpc3WWq5ZIzR0bWBmFxQ+6UmlzV7TsNfqpV2stNkWxOXc72S7/9pQ+JuYTDNJyw3UxT9xHjL9o/Yh+s6kVheqFlpF3pUiuRAxOfEbLG88/AuCPK4xKxbXDPCdR6cINoWcpzzg9PaxRUpNeulTSxf2NMk9qz4PmTFYWf5cqtOw4NEpM72xZf3McKK0ZTp8Z49zyVvO/NDrjauNzOY3q2lI2ZFwQBOjxSd/zjXIyNX5XcSEm/8C8r0evvxPe8kd84awQWeJ6dxfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xtyugX8pwkS9uiXsFfnYAD/NV/QNrthPqEQs5JVPKD0=;
 b=nZI6xbc1iG3U2/epeT8Hp4VJBXtqGq26Rizk21o1CW4Xdi+iJjldyNZKu6/niOD1spq0hxwQ5A3JD5b3Y49lg0T5gNtBWzzatpDVJWH0b5fh07cDn4qavFYWdA8dtPNmdfY3T1hc882NXSMgSmld5HjgisOwmwEf/IrHx0X+p/euFn5K020pp95ZLbOpzKeeXReeHdOFMPkFJUb+n0Jzld05AZOlZMsp37UDyul8AVZN/46HkH7YnYmGpTGNzSUHxnVT+RKeKy34viRueYJ61U3NiXS7NGzMr4hjcjhOl2iH7EOFt6X1cYssj5qMPpcGt4DV+VfJAX2acJ2kC+xODw==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by BL0PR12MB4724.namprd12.prod.outlook.com (2603:10b6:208:87::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.15; Thu, 17 Feb
 2022 10:16:21 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::846c:d3cd:5a30:c35]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::846c:d3cd:5a30:c35%5]) with mapi id 15.20.4975.017; Thu, 17 Feb 2022
 10:16:21 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Luis Chamberlain <mcgrof@kernel.org>, "hch@lst.de" <hch@lst.de>
CC:     "javier@javigon.com" <javier@javigon.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "msnitzer@redhat.com" <msnitzer@redhat.com>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "hare@suse.de" <hare@suse.de>,
        "kbusch@kernel.org" <kbusch@kernel.org>,
        "Frederick.Knight@netapp.com" <Frederick.Knight@netapp.com>,
        "osandov@fb.com" <osandov@fb.com>,
        "lsf-pc@lists.linux-foundation.org" 
        <lsf-pc@lists.linux-foundation.org>,
        "djwong@kernel.org" <djwong@kernel.org>,
        "josef@toxicpanda.com" <josef@toxicpanda.com>,
        "clm@fb.com" <clm@fb.com>, "dsterba@suse.com" <dsterba@suse.com>,
        "tytso@mit.edu" <tytso@mit.edu>, "jack@suse.com" <jack@suse.com>,
        "joshi.k@samsung.com" <joshi.k@samsung.com>,
        "arnav.dawn@samsung.com" <arnav.dawn@samsung.com>,
        "nitheshshetty@gmail.com" <nitheshshetty@gmail.com>,
        SelvaKumar S <selvakuma.s1@samsung.com>,
        Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        James Smart <james.smart@broadcom.com>,
        Chaitanya Kulkarni <chaitanyak@nvidia.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Nitesh Shetty <nj.shetty@samsung.com>
Subject: Re: [PATCH v3 02/10] block: Introduce queue limits for copy-offload
 support
Thread-Topic: [PATCH v3 02/10] block: Introduce queue limits for copy-offload
 support
Thread-Index: AQHYIX3XHL9e7GOdFkmJOxrEFUhCJ6yXeHUAgAATXwA=
Date:   Thu, 17 Feb 2022 10:16:21 +0000
Message-ID: <f0f9317f-839e-2be2-dec6-c5b94d7022b7@nvidia.com>
References: <20220214080002.18381-1-nj.shetty@samsung.com>
 <CGME20220214080605epcas5p16868dae515a6355cf9fecf22df4f3c3d@epcas5p1.samsung.com>
 <20220214080002.18381-3-nj.shetty@samsung.com>
 <20220217090700.b7n33vbkx5s4qbfq@garbanzo>
In-Reply-To: <20220217090700.b7n33vbkx5s4qbfq@garbanzo>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c1a1b84c-f0d8-4872-61b9-08d9f1fe8b6d
x-ms-traffictypediagnostic: BL0PR12MB4724:EE_
x-microsoft-antispam-prvs: <BL0PR12MB4724CEDBE5856A6200C3BE8CA3369@BL0PR12MB4724.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6Z2W2wzGF0dUKXoe8V/PLOCWOIuMlgKpU5gl8Pwl6MCfuWCN8GbKrZhj3+tkHr/NXWl4aXzmuAVFpWTFDdjoA5eHGYMoIT7MoJMNxFjCgmChl2pZ51+6jhLkh9hXtYnklZjcbkdAWYHFMYHJa//bQWwPcDkP0T7gAlBbtEunI9GOOYcsXUjIg0qbqC72gpDyicngffJOqe2FGJeQKbZHT7kas6h3NXGvOQ6at1qTBBXM0fNxgfWjTHJhStuP+VsAgNIHWCT2zx69ARWu3SU0OHnM7A7m5H6vdBZDbLWXyQJTgWp3yOdbrtFwYtFhDwfMH+NBajtQCxQfr7X7lEP6mb3hWHfJXISN1R1e3LsCl1wQ1IU3Yx1TmLIbfGHaPpR0GcrDyHBujf4cbtslcoCCFbVENAg7XvKfNBkuXwtSUnokCT+dUBDGTadlya9n1d/htTcSt1izAI8Emrt1o5qbYDO1opySeDmMSa6nvjqxVNou9oKrHP1JrRBuMPTtUuQq+NrhmJzk8+OU+6vrr9gU1S3InhBQpr3w9YXIeSWOR3om6ivPJ4I/thEPa9GZo8mKIl6dlj8AIs0eVGyyCiZi21WV91zDXf95Xd3EskUtBEdKc1XbwjjKnFTs8DNhvV0QHROpuS6X3JoiiSkmYCLGIjw6SfBrKR7/mAnqTYHhd8Kf/FIuaVcY9x2kl92rMpG5lWdiYTaZxz/izqE9bp29XCaLgV26Jydn/cxStSJ0sODDswZOuSxmsGGzZyBF5J/VcxGUub9Q4wl6X0BexxsDsA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(71200400001)(7406005)(66946007)(64756008)(66476007)(66446008)(91956017)(86362001)(4326008)(7416002)(6486002)(2906002)(6512007)(8936002)(66556008)(38100700002)(508600001)(8676002)(5660300002)(110136005)(54906003)(122000001)(316002)(76116006)(83380400001)(31686004)(38070700005)(53546011)(2616005)(186003)(36756003)(31696002)(6506007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VUtEZUh2OGVJdzhZWVVtQVhyNkZuTDFrSldVVlNoWWgzd0YwNzBIZVhZaEhv?=
 =?utf-8?B?MjdXNFMwU2FTVWtaVGlCb3U0eU96NjRJYjY4cXA1YkR3WUJxYXRxcjBWT3VN?=
 =?utf-8?B?Y3dlYnU0b2RETngrbkZjK09qeWZCYjJCSVpTRlUzaEVrd3JuLzRrQ0N3YVVQ?=
 =?utf-8?B?cVgyY01kT2lqQ3V4RXpkSzRBaEl6cnhJWHVUWSsvcTdYRFNKSGxXUTRhVDln?=
 =?utf-8?B?M3dNeEdPTFFZQXJMMm52UDJrZ1dtQjBlaThQWWdYV0JBSEVkeWtZazVyZnNI?=
 =?utf-8?B?ZWkyNXR2OTl6aXVKcHdjVlArWEtJNkNudCtHQnAyMGFFdnBRYklrQXdXK2NM?=
 =?utf-8?B?anpIN3kzNmlKRGljUys5TmlGZTc3V3MyK3I4V01YRDcvYURaYUJFeXVFb2xF?=
 =?utf-8?B?elMwbkVUR2lia2xOZ3RrczZLcjgva2k3cFpvZmtLcm5oOTlicEFpRWFPKzZP?=
 =?utf-8?B?RTV3RDRHejhWenlSajR4U0pRUG1OUmhPMW80VTUvNzNFa2RVeUFTMlI4dWRC?=
 =?utf-8?B?OCsrYXVEVEQ4akZLR3Rlc1A1anZnWFFhL0dLVms4UXBNWkJPbldVbnhVNDMz?=
 =?utf-8?B?VnYwdytFZnRuQzlQV2FFMzBPRHFkbEZKUXRVaEtjZjZuZGQ0WkNpTHMveWdz?=
 =?utf-8?B?QmNtWmVIMWVRd3lwSkgyKzE0RnNqNnEzY1BTU3djRlNyRERRQWhXa0pUNjJj?=
 =?utf-8?B?ak54WTNXUnFVUENVZGh2STRWaDhsT1cwV2NnT1p5WnEzNW9Od2hTT2ZjeERl?=
 =?utf-8?B?UWVLS0Y1VFRydXI1TDRtMVRSNnI4OStJd1JqK1B6bkFLdXFCeFlxVWJiRU9B?=
 =?utf-8?B?TG81cllTNndUYkhBdFB6aEkzOGNPUW15MUpJSDJiWHR4K05wdGhCRzgwZHpT?=
 =?utf-8?B?MUZkUGF1QkFvQm5uT0dPNWhLMkIxa04wSTYrUnJuMngza2syWjRsNHNkT1Vu?=
 =?utf-8?B?bDZjSHpmbldEeFN3dnNiZnpGS211VDdiK2RjK1JLSWJIeVordEZGNlFrZjVJ?=
 =?utf-8?B?dlg1NEN5WnFwSExNNXQ4NCsyL0p2MkYyejhVbnZPOVJKOGZZTWMyZ3A5aWp1?=
 =?utf-8?B?TXhOQ1JBRjRLYU5uTEZrV0laOEVFTVBDdjV5VitsaFEyVmI5SWJnbi90cW5V?=
 =?utf-8?B?T2dvMS96T0doODlSb1M0MzhvZkdKVDBGZExRUXEybVFQd3JBUXdRa255cmln?=
 =?utf-8?B?L1Jaa0x0ZXZFcGRVYVYzMHNjOEtVSTF1QnpxTzh4RWI2OFBTSzVsZS9vbUEw?=
 =?utf-8?B?UzViYkVqWEY4ZjQ0aE16dmliQTFvUmFIZlV1SzAxS2lkeGVlWGlBQTdNZGNh?=
 =?utf-8?B?OEtoMWFkTi9LbTdmQTdRVC9UNFVIMjZlRllZeUZFNUZ0QW1XYVU3bTNrNUhQ?=
 =?utf-8?B?QXM2SWJPdTBBTmh1RFR4Q2ZQbnJXVGpoVWpTUVJaTFV6QzhnZ3c2STVPN0RX?=
 =?utf-8?B?NjVtTlV6RE5HS1c0UytubFhVK2ZjN3JMcW9FdEFHbmRYWExldGdJcnl3QklG?=
 =?utf-8?B?TGFERDZkR0krMTBFc1dzdkNvYzg0UVp1dit1TWNoRVlEbEJveFUvcVBvWGtp?=
 =?utf-8?B?SjJYeENUblA1eVVraEVlZ3hPalV2cWxBbUMrOU10Mk9wVktTeUZoL2g0cHZt?=
 =?utf-8?B?bnZoNm9ubHhGRU53M0VtalZVTEtUeDJpbFExUWFPMlhKRDlXRDdPcVo3RG9Y?=
 =?utf-8?B?MkJDNm1FbmFURkxDSi9UR0I2QTR4RUFxdXczZGJNeDlHVnRvTHFmYU1BOEd1?=
 =?utf-8?B?dWlmeXRhVWFGcE5DWkl0VHpIYzl6b0N5Ky9yRnBKUkR5eE54M3pNcVNndEF2?=
 =?utf-8?B?WEhYam43bTFtazlNL3FzY1ZyeVRZSkxHVEpSOWxEM0FxMDF2UUVUVjIxdEZD?=
 =?utf-8?B?OVNSV1V2UmI5NVVja1lwNjJKcFJMK0xBOUJyUElqUmNwaHJPNTlqZTZHWFZi?=
 =?utf-8?B?cWhVU3RWQmk4R0tJd2NrNENrS3pObmo0dUV5K3ltK3V0ZWdzSC8wU2dycklV?=
 =?utf-8?B?Uk5ldTF6V09wTVVqeTA1S1JKdE8vNGVkdXpIUWN3T3QxZENvL2JFMGFqV1Qx?=
 =?utf-8?B?QnR2SVRiOWozK1lDc2ZVcnNZSC9hSGxtODE3NmQ2V3ZYNTFzUWEzeXluaU13?=
 =?utf-8?B?c1RBTUVRQVJkRFBtVytIbFhlVHpvN1AzYjc5c0ZMc0hucHk1ZkJESGZQL3dv?=
 =?utf-8?Q?/ZP6IG4hSLaoX4cTPLBF5yo2G6c6LkusoAacJHs0f/T/?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3C7747923854C747A3CF9C4661B64B1E@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1a1b84c-f0d8-4872-61b9-08d9f1fe8b6d
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Feb 2022 10:16:21.1574
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: meGMcDWO4GHdInb5gwSpsB1ykzvj2VMwEtrwv7nc1iLYS4BbHuyOOGCx3L2XN+DrhlGRpRe3OhTHYKh1e8op9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4724
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

T24gMi8xNy8yMiAxOjA3IEFNLCBMdWlzIENoYW1iZXJsYWluIHdyb3RlOg0KPiBUaGUgc3ViamVj
dCBzYXlzIGxpbWl0cyBmb3IgY29weS1vZmZsb2FkLi4uDQo+IA0KPiBPbiBNb24sIEZlYiAxNCwg
MjAyMiBhdCAwMToyOTo1MlBNICswNTMwLCBOaXRlc2ggU2hldHR5IHdyb3RlOg0KPj4gQWRkIGRl
dmljZSBsaW1pdHMgYXMgc3lzZnMgZW50cmllcywNCj4+ICAgICAgICAgIC0gY29weV9vZmZsb2Fk
IChSVykNCj4+ICAgICAgICAgIC0gY29weV9tYXhfYnl0ZXMgKFJXKQ0KPj4gICAgICAgICAgLSBj
b3B5X21heF9od19ieXRlcyAoUk8pDQo+PiAgICAgICAgICAtIGNvcHlfbWF4X3JhbmdlX2J5dGVz
IChSVykNCj4+ICAgICAgICAgIC0gY29weV9tYXhfcmFuZ2VfaHdfYnl0ZXMgKFJPKQ0KPj4gICAg
ICAgICAgLSBjb3B5X21heF9ucl9yYW5nZXMgKFJXKQ0KPj4gICAgICAgICAgLSBjb3B5X21heF9u
cl9yYW5nZXNfaHcgKFJPKQ0KPiANCj4gU29tZSBvZiB0aGVzZSBzZWVtIGxpa2UgZ2VuZXJpYy4u
LiBhbmQgYWxzbyBJIHNlZSBhIGZldyBtb3JlIG1heF9odyBvbmVzDQo+IG5vdCBsaXN0ZWQgYWJv
dmUuLi4NCj4gDQo+PiAtLS0gYS9ibG9jay9ibGstc2V0dGluZ3MuYw0KPj4gKysrIGIvYmxvY2sv
YmxrLXNldHRpbmdzLmMNCj4+ICsvKioNCj4+ICsgKiBibGtfcXVldWVfbWF4X2NvcHlfc2VjdG9y
cyAtIHNldCBtYXggc2VjdG9ycyBmb3IgYSBzaW5nbGUgY29weSBwYXlsb2FkDQo+PiArICogQHE6
ICB0aGUgcmVxdWVzdCBxdWV1ZSBmb3IgdGhlIGRldmljZQ0KPj4gKyAqIEBtYXhfY29weV9zZWN0
b3JzOiBtYXhpbXVtIG51bWJlciBvZiBzZWN0b3JzIHRvIGNvcHkNCj4+ICsgKiovDQo+PiArdm9p
ZCBibGtfcXVldWVfbWF4X2NvcHlfc2VjdG9ycyhzdHJ1Y3QgcmVxdWVzdF9xdWV1ZSAqcSwNCj4+
ICsJCXVuc2lnbmVkIGludCBtYXhfY29weV9zZWN0b3JzKQ0KPj4gK3sNCj4+ICsJcS0+bGltaXRz
Lm1heF9od19jb3B5X3NlY3RvcnMgPSBtYXhfY29weV9zZWN0b3JzOw0KPj4gKwlxLT5saW1pdHMu
bWF4X2NvcHlfc2VjdG9ycyA9IG1heF9jb3B5X3NlY3RvcnM7DQo+PiArfQ0KPj4gK0VYUE9SVF9T
WU1CT0woYmxrX3F1ZXVlX21heF9jb3B5X3NlY3RvcnMpOw0KPiANCj4gUGxlYXNlIHVzZSBFWFBP
UlRfU1lNQk9MX0dQTCgpIGZvciBhbGwgbmV3IHRoaW5ncy4NCj4gDQo+IFdoeSBpcyB0aGlzIHNl
dHRpbmcgYm90aD8gVGhlIGRvY3VtZW50YXRpb24gZG9lcyd0IHNlZW0gdG8gc2F5Lg0KPiBXaGF0
J3MgdGhlIHBvaW50Pw0KPiANCj4+ICsNCj4+ICsvKioNCj4+ICsgKiBibGtfcXVldWVfbWF4X2Nv
cHlfcmFuZ2Vfc2VjdG9ycyAtIHNldCBtYXggc2VjdG9ycyBmb3IgYSBzaW5nbGUgcmFuZ2UsIGlu
IGEgY29weSBwYXlsb2FkDQo+PiArICogQHE6ICB0aGUgcmVxdWVzdCBxdWV1ZSBmb3IgdGhlIGRl
dmljZQ0KPj4gKyAqIEBtYXhfY29weV9yYW5nZV9zZWN0b3JzOiBtYXhpbXVtIG51bWJlciBvZiBz
ZWN0b3JzIHRvIGNvcHkgaW4gYSBzaW5nbGUgcmFuZ2UNCj4+ICsgKiovDQo+PiArdm9pZCBibGtf
cXVldWVfbWF4X2NvcHlfcmFuZ2Vfc2VjdG9ycyhzdHJ1Y3QgcmVxdWVzdF9xdWV1ZSAqcSwNCj4+
ICsJCXVuc2lnbmVkIGludCBtYXhfY29weV9yYW5nZV9zZWN0b3JzKQ0KPj4gK3sNCj4+ICsJcS0+
bGltaXRzLm1heF9od19jb3B5X3JhbmdlX3NlY3RvcnMgPSBtYXhfY29weV9yYW5nZV9zZWN0b3Jz
Ow0KPj4gKwlxLT5saW1pdHMubWF4X2NvcHlfcmFuZ2Vfc2VjdG9ycyA9IG1heF9jb3B5X3Jhbmdl
X3NlY3RvcnM7DQo+PiArfQ0KPj4gK0VYUE9SVF9TWU1CT0woYmxrX3F1ZXVlX21heF9jb3B5X3Jh
bmdlX3NlY3RvcnMpOw0KPiANCj4gU2FtZSBoZXJlLg0KPiANCj4+ICsvKioNCj4+ICsgKiBibGtf
cXVldWVfbWF4X2NvcHlfbnJfcmFuZ2VzIC0gc2V0IG1heCBudW1iZXIgb2YgcmFuZ2VzLCBpbiBh
IGNvcHkgcGF5bG9hZA0KPj4gKyAqIEBxOiAgdGhlIHJlcXVlc3QgcXVldWUgZm9yIHRoZSBkZXZp
Y2UNCj4+ICsgKiBAbWF4X2NvcHlfbnJfcmFuZ2VzOiBtYXhpbXVtIG51bWJlciBvZiByYW5nZXMN
Cj4+ICsgKiovDQo+PiArdm9pZCBibGtfcXVldWVfbWF4X2NvcHlfbnJfcmFuZ2VzKHN0cnVjdCBy
ZXF1ZXN0X3F1ZXVlICpxLA0KPj4gKwkJdW5zaWduZWQgaW50IG1heF9jb3B5X25yX3JhbmdlcykN
Cj4+ICt7DQo+PiArCXEtPmxpbWl0cy5tYXhfaHdfY29weV9ucl9yYW5nZXMgPSBtYXhfY29weV9u
cl9yYW5nZXM7DQo+PiArCXEtPmxpbWl0cy5tYXhfY29weV9ucl9yYW5nZXMgPSBtYXhfY29weV9u
cl9yYW5nZXM7DQo+PiArfQ0KPj4gK0VYUE9SVF9TWU1CT0woYmxrX3F1ZXVlX21heF9jb3B5X25y
X3Jhbmdlcyk7DQo+IA0KPiBTYW1lLg0KPiANCj4+ICsNCj4+ICAgLyoqDQo+PiAgICAqIGJsa19x
dWV1ZV9tYXhfd3JpdGVfc2FtZV9zZWN0b3JzIC0gc2V0IG1heCBzZWN0b3JzIGZvciBhIHNpbmds
ZSB3cml0ZSBzYW1lDQo+PiAgICAqIEBxOiAgdGhlIHJlcXVlc3QgcXVldWUgZm9yIHRoZSBkZXZp
Y2UNCj4+IEBAIC01NDEsNiArNTkyLDE0IEBAIGludCBibGtfc3RhY2tfbGltaXRzKHN0cnVjdCBx
dWV1ZV9saW1pdHMgKnQsIHN0cnVjdCBxdWV1ZV9saW1pdHMgKmIsDQo+PiAgIAl0LT5tYXhfc2Vn
bWVudF9zaXplID0gbWluX25vdF96ZXJvKHQtPm1heF9zZWdtZW50X3NpemUsDQo+PiAgIAkJCQkJ
ICAgYi0+bWF4X3NlZ21lbnRfc2l6ZSk7DQo+PiAgIA0KPj4gKwl0LT5tYXhfY29weV9zZWN0b3Jz
ID0gbWluKHQtPm1heF9jb3B5X3NlY3RvcnMsIGItPm1heF9jb3B5X3NlY3RvcnMpOw0KPj4gKwl0
LT5tYXhfaHdfY29weV9zZWN0b3JzID0gbWluKHQtPm1heF9od19jb3B5X3NlY3RvcnMsIGItPm1h
eF9od19jb3B5X3NlY3RvcnMpOw0KPj4gKwl0LT5tYXhfY29weV9yYW5nZV9zZWN0b3JzID0gbWlu
KHQtPm1heF9jb3B5X3JhbmdlX3NlY3RvcnMsIGItPm1heF9jb3B5X3JhbmdlX3NlY3RvcnMpOw0K
Pj4gKwl0LT5tYXhfaHdfY29weV9yYW5nZV9zZWN0b3JzID0gbWluKHQtPm1heF9od19jb3B5X3Jh
bmdlX3NlY3RvcnMsDQo+PiArCQkJCQkJYi0+bWF4X2h3X2NvcHlfcmFuZ2Vfc2VjdG9ycyk7DQo+
PiArCXQtPm1heF9jb3B5X25yX3JhbmdlcyA9IG1pbih0LT5tYXhfY29weV9ucl9yYW5nZXMsIGIt
Pm1heF9jb3B5X25yX3Jhbmdlcyk7DQo+PiArCXQtPm1heF9od19jb3B5X25yX3JhbmdlcyA9IG1p
bih0LT5tYXhfaHdfY29weV9ucl9yYW5nZXMsIGItPm1heF9od19jb3B5X25yX3Jhbmdlcyk7DQo+
PiArDQo+PiAgIAl0LT5taXNhbGlnbmVkIHw9IGItPm1pc2FsaWduZWQ7DQo+PiAgIA0KPj4gICAJ
YWxpZ25tZW50ID0gcXVldWVfbGltaXRfYWxpZ25tZW50X29mZnNldChiLCBzdGFydCk7DQo+PiBk
aWZmIC0tZ2l0IGEvYmxvY2svYmxrLXN5c2ZzLmMgYi9ibG9jay9ibGstc3lzZnMuYw0KPj4gaW5k
ZXggOWYzMjg4MmNlYjJmLi45ZGRkMDdmMTQyZDkgMTAwNjQ0DQo+PiAtLS0gYS9ibG9jay9ibGst
c3lzZnMuYw0KPj4gKysrIGIvYmxvY2svYmxrLXN5c2ZzLmMNCj4+IEBAIC0yMTIsNiArMjEyLDEy
OSBAQCBzdGF0aWMgc3NpemVfdCBxdWV1ZV9kaXNjYXJkX3plcm9lc19kYXRhX3Nob3coc3RydWN0
IHJlcXVlc3RfcXVldWUgKnEsIGNoYXIgKnBhZw0KPj4gICAJcmV0dXJuIHF1ZXVlX3Zhcl9zaG93
KDAsIHBhZ2UpOw0KPj4gICB9DQo+PiAgIA0KPj4gK3N0YXRpYyBzc2l6ZV90IHF1ZXVlX2NvcHlf
b2ZmbG9hZF9zaG93KHN0cnVjdCByZXF1ZXN0X3F1ZXVlICpxLCBjaGFyICpwYWdlKQ0KPj4gK3sN
Cj4+ICsJcmV0dXJuIHF1ZXVlX3Zhcl9zaG93KGJsa19xdWV1ZV9jb3B5KHEpLCBwYWdlKTsNCj4+
ICt9DQo+PiArDQo+PiArc3RhdGljIHNzaXplX3QgcXVldWVfY29weV9vZmZsb2FkX3N0b3JlKHN0
cnVjdCByZXF1ZXN0X3F1ZXVlICpxLA0KPj4gKwkJCQkgICAgICAgY29uc3QgY2hhciAqcGFnZSwg
c2l6ZV90IGNvdW50KQ0KPj4gK3sNCj4+ICsJdW5zaWduZWQgbG9uZyBjb3B5X29mZmxvYWQ7DQo+
PiArCXNzaXplX3QgcmV0ID0gcXVldWVfdmFyX3N0b3JlKCZjb3B5X29mZmxvYWQsIHBhZ2UsIGNv
dW50KTsNCj4+ICsNCj4+ICsJaWYgKHJldCA8IDApDQo+PiArCQlyZXR1cm4gcmV0Ow0KPj4gKw0K
Pj4gKwlpZiAoY29weV9vZmZsb2FkICYmICFxLT5saW1pdHMubWF4X2h3X2NvcHlfc2VjdG9ycykN
Cj4+ICsJCXJldHVybiAtRUlOVkFMOw0KPiANCj4gDQo+IElmIHRoZSBrZXJuZWwgc2NoZWR1bGVz
LCBjb3B5X29mZmxvYWQgbWF5IHN0aWxsIGJlIHRydWUgYW5kDQo+IG1heF9od19jb3B5X3NlY3Rv
cnMgbWF5IGJlIHNldCB0byAwLiBJcyB0aGF0IGFuIGlzc3VlPw0KPiANCj4+ICsNCj4+ICsJaWYg
KGNvcHlfb2ZmbG9hZCkNCj4+ICsJCWJsa19xdWV1ZV9mbGFnX3NldChRVUVVRV9GTEFHX0NPUFks
IHEpOw0KPj4gKwllbHNlDQo+PiArCQlibGtfcXVldWVfZmxhZ19jbGVhcihRVUVVRV9GTEFHX0NP
UFksIHEpOw0KPiANCj4gVGhlIGZsYWcgbWF5IGJlIHNldCBidXQgdGhlIHF1ZXVlIGZsYWcgY291
bGQgYmUgc2V0LiBJcyB0aGF0IGFuIGlzc3VlPw0KPiANCj4+IEBAIC01OTcsNiArNzIwLDE0IEBA
IFFVRVVFX1JPX0VOVFJZKHF1ZXVlX25yX3pvbmVzLCAibnJfem9uZXMiKTsNCj4+ICAgUVVFVUVf
Uk9fRU5UUlkocXVldWVfbWF4X29wZW5fem9uZXMsICJtYXhfb3Blbl96b25lcyIpOw0KPj4gICBR
VUVVRV9ST19FTlRSWShxdWV1ZV9tYXhfYWN0aXZlX3pvbmVzLCAibWF4X2FjdGl2ZV96b25lcyIp
Ow0KPj4gICANCj4+ICtRVUVVRV9SV19FTlRSWShxdWV1ZV9jb3B5X29mZmxvYWQsICJjb3B5X29m
ZmxvYWQiKTsNCj4+ICtRVUVVRV9ST19FTlRSWShxdWV1ZV9jb3B5X21heF9odywgImNvcHlfbWF4
X2h3X2J5dGVzIik7DQo+PiArUVVFVUVfUldfRU5UUlkocXVldWVfY29weV9tYXgsICJjb3B5X21h
eF9ieXRlcyIpOw0KPj4gK1FVRVVFX1JPX0VOVFJZKHF1ZXVlX2NvcHlfcmFuZ2VfbWF4X2h3LCAi
Y29weV9tYXhfcmFuZ2VfaHdfYnl0ZXMiKTsNCj4+ICtRVUVVRV9SV19FTlRSWShxdWV1ZV9jb3B5
X3JhbmdlX21heCwgImNvcHlfbWF4X3JhbmdlX2J5dGVzIik7DQo+PiArUVVFVUVfUk9fRU5UUlko
cXVldWVfY29weV9ucl9yYW5nZXNfbWF4X2h3LCAiY29weV9tYXhfbnJfcmFuZ2VzX2h3Iik7DQo+
PiArUVVFVUVfUldfRU5UUlkocXVldWVfY29weV9ucl9yYW5nZXNfbWF4LCAiY29weV9tYXhfbnJf
cmFuZ2VzIik7DQo+IA0KPiBTZWVtcyBsaWtlIHlvdSBuZWVkIHRvIHVwZGF0ZSBEb2N1bWVudGF0
aW9uL0FCSS9zdGFibGUvc3lzZnMtYmxvY2suDQo+IA0KPj4gZGlmZiAtLWdpdCBhL2luY2x1ZGUv
bGludXgvYmxrZGV2LmggYi9pbmNsdWRlL2xpbnV4L2Jsa2Rldi5oDQo+PiBpbmRleCBlZmVkMzgy
MGNiZjcuLjc5MmU2ZDU1NjU4OSAxMDA2NDQNCj4+IC0tLSBhL2luY2x1ZGUvbGludXgvYmxrZGV2
LmgNCj4+ICsrKyBiL2luY2x1ZGUvbGludXgvYmxrZGV2LmgNCj4+IEBAIC0yNTQsNiArMjU0LDEz
IEBAIHN0cnVjdCBxdWV1ZV9saW1pdHMgew0KPj4gICAJdW5zaWduZWQgaW50CQlkaXNjYXJkX2Fs
aWdubWVudDsNCj4+ICAgCXVuc2lnbmVkIGludAkJem9uZV93cml0ZV9ncmFudWxhcml0eTsNCj4+
ICAgDQo+PiArCXVuc2lnbmVkIGxvbmcJCW1heF9od19jb3B5X3NlY3RvcnM7DQo+PiArCXVuc2ln
bmVkIGxvbmcJCW1heF9jb3B5X3NlY3RvcnM7DQo+PiArCXVuc2lnbmVkIGludAkJbWF4X2h3X2Nv
cHlfcmFuZ2Vfc2VjdG9yczsNCj4+ICsJdW5zaWduZWQgaW50CQltYXhfY29weV9yYW5nZV9zZWN0
b3JzOw0KPj4gKwl1bnNpZ25lZCBzaG9ydAkJbWF4X2h3X2NvcHlfbnJfcmFuZ2VzOw0KPj4gKwl1
bnNpZ25lZCBzaG9ydAkJbWF4X2NvcHlfbnJfcmFuZ2VzOw0KPiANCj4gQmVmb3JlIGxpbWl0cyBz
dGFydCBncm93aW5nIG1vcmUuLiBJIHdvbmRlciBpZiB3ZSBzaG91bGQganVzdA0KPiBzdHVmZiBo
dyBvZmZsb2FkIHN0dWZmIHRvIGl0cyBvd24gc3RydWN0IHdpdGhpbiBxdWV1ZV9saW1pdHMuDQo+
IA0KPiBDaHJpc3RvcGg/DQo+IA0KDQpQb3RlbnRpYWxseSB1c2UgYSBwb2ludGVyIHRvIHN0cnVj
dHVyZSBhbmQgbWF5YmUgbWFrZSBpdCBjb25maWd1cmFibGUsDQphbHRob3VnaCBJJ20gbm90IHN1
cmUgYWJvdXQgdGhlIGxhdGVyIHBhcnQsIEknbGwgbGV0IENocmlzdG9waCBkZWNpZGUNCnRoYXQu
DQoNCj4gICAgTHVpcw0KPiANCg0KLWNrDQoNCg==

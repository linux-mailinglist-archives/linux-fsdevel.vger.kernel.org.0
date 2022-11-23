Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65E84636D74
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Nov 2022 23:45:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229877AbiKWWof (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Nov 2022 17:44:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229893AbiKWWo2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Nov 2022 17:44:28 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D77C132F7E;
        Wed, 23 Nov 2022 14:44:27 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DP8kD8cIpSkynDBHv/nAn8eUZXNIkXlwBZRE17ZB8C3Uep9ITvjMfNu+ecMsf73OUfoO4SyGgZG3w7OAaGIRwawRstfMs98FAGQWQkQPAT27x20Kf1dE/j8sLTpbDmcdDlx9ToRota08AQb/hVTYGXmupvlzFyonmO4UNW7rCqyOUlVI52NeA8hj5NglT5nd6VLDgcj+P25NI0h7fZaZ3FRQ5NOrnhGmSYDry1fXkHOx7Zo6W/zmncawBRecv9NActBq9Uw3MRwMjW4HEejAbQ7qQgXS1hMVClav16WOef4lsQWpYfhtsoMDFxxfTOJ1AJs4nNroN6xzniO3FLRZIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DjDx4D4jm5IYjPruBabJcEV5PQa8pRybAFNzaRNPLKA=;
 b=kzqXrZCrdAtRH94tyrHympAJHbKOEFAsmx9Je9HviBaazoFqiHrb8cxmqAMTKakx/RSW1yGQgZbInGBtwaHCYP05ordz1hsEalhxzyiHsbl/K66iMDsEKBxZOgQqr1IuXPvsg2cUB7BZgSK02eUYu3BuK1zchSxNp6fQkgCJjETPmVwI/g42Wk3CocwA/6HRU+G6W+178kZzE1LA7S/+2WEXoP+lxgGzoPeiYNLCAwXmqy9AkupcBzC8f3xx/n0NYO3/TuQIuvKW/95mtjEqaKan+addJ7xm37DbQgiuaHz9dpK/vc8rz508k84NqUUQQH66uBibpAqNh7ix/xr/bQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DjDx4D4jm5IYjPruBabJcEV5PQa8pRybAFNzaRNPLKA=;
 b=Un05z3SgSSI4ACzaSjs4rU7A5KBf/UK08EpfWbKkasF3yIBYpNp7/lhD5Keqf+GUC31IxMJb5jSqFNrJjAHxklTy7tcCQHcGXiIf7jajXVHOa3cooeUHq1H8vAHCnmALNCqb42RUzBROFYQ/bFgB9o9aDLAbYubmSlMNns/Ycd7pB9zX4WVyK3GA1hyGfSedjYPSpy309GrpfgrC9lj+JNkt9j2Co7pzQDl1IlwqzUjh9+sR5KpLafJ9sYEiCfSopPIez12IfqH/PEum0104FRPW4H6DpGIMQ87PS21OvZf9ogKW0LguRsecaxZafN4/r25VQimCcQh3DGh8iGEOgg==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by IA1PR12MB7757.namprd12.prod.outlook.com (2603:10b6:208:422::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.15; Wed, 23 Nov
 2022 22:44:26 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::f02:bf13:2f64:43bc]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::f02:bf13:2f64:43bc%7]) with mapi id 15.20.5834.015; Wed, 23 Nov 2022
 22:44:26 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
CC:     Damien Le Moal <damien.lemoal@wdc.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Qu Wenruo <wqu@suse.com>, Jens Axboe <axboe@kernel.dk>,
        "Darrick J. Wong" <djwong@kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>
Subject: Re: [PATCH 19/19] iomap: remove IOMAP_F_ZONE_APPEND
Thread-Topic: [PATCH 19/19] iomap: remove IOMAP_F_ZONE_APPEND
Thread-Index: AQHY/N6GTDEmD8rj3kizY8OKKh/Iw65NIIiA
Date:   Wed, 23 Nov 2022 22:44:25 +0000
Message-ID: <c1f02271-323f-8cfc-6d86-77c1f4773eab@nvidia.com>
References: <20221120124734.18634-1-hch@lst.de>
 <20221120124734.18634-20-hch@lst.de>
In-Reply-To: <20221120124734.18634-20-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW2PR12MB4667:EE_|IA1PR12MB7757:EE_
x-ms-office365-filtering-correlation-id: 99af7094-b129-4293-4f2a-08dacda44608
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: EYPI8MmKeLYWdAGI9MxIy2qwQ8Q9DtJ327bavC7aHBbz8c2mnsZAatSE1xL1QCAkvysXvYt8+q6JDMYOLcNPvDayoIG0ZZR0vSUR8ORWM77v8iBerEX5TP8D6TGZwwJCOZc4L7mVGwYoKoCXmjx+3nbSS+TW37Ug2PBQfSXVPHyMfQRmNGO2j+r2Nkp91qRvmOM2tDu5PPU/2R/nZfOrV3Lk+TQ0ozkcXypjO5NRHyl0BHFZp8muyUQGAxHw/21ty9z9JcdsEvtWY/+/QNZqVH+ZDvxnHowQjZVale2pwRlKhkXNUqq1++0VVDVCqkmWaXnUyDcyTcpE3ntheNKnJy9RwJZd8NvPZrXOZW5XBqgJQQvkS8nYNMSKNplm8nc6+iB3BCVSuutvx76kCKh+/Pqt+Bv1KQT0cvMrhc/94KSXKiuRZmU3mPjh29l89DPHLvCUhJXA7kB3H7uwq1mP3AFlu8ayqVylPq5jUX4/myUCLppP0/6w0EmzKpo33JVG5AqG0R3LEUHO53QK9Hgb6Coodhe58T8VhlSPeg2xKeUe6XArMgUpU2F3/QwDkee53kpX5MISh8gstSJXHH4PcY47sSHFBFbNAFJYxKX620tVH8DoJO5bWOA/8Ytc19q+8T6mPeoUdLBsL9hveLXwv2Hzsm5ISrkduZzCW8WXCEC2FQnxhyDUYndIjiEECwWt+Gkv+7AV4zfBiwOhnX4EOkg7HF8XOlpNHe0lXT8/I+CIbIK8qHFUKgYFk4HsXHY4O75bM89+N2taa+aybZH4VA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(396003)(376002)(136003)(39860400002)(346002)(451199015)(38100700002)(122000001)(38070700005)(86362001)(31696002)(2616005)(71200400001)(53546011)(478600001)(7416002)(66556008)(6506007)(64756008)(66946007)(66446008)(91956017)(4326008)(76116006)(8676002)(316002)(41300700001)(6486002)(66476007)(110136005)(54906003)(2906002)(186003)(6512007)(8936002)(5660300002)(4744005)(31686004)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MXlEWjZhOEc5bW5SMWJGYnh0dmZKUUw4ZHdVSytLczljS1UzMVBHTENHU1pM?=
 =?utf-8?B?RjhaRE5nS2ZxK3Z4amlad1YxUlFTVmZhcXJzQ0NwRmJUYk1rMXpYRVByaFRW?=
 =?utf-8?B?U2hnQnpDYmJ4N294NWZxMERUR1AvVmxibjRRZnVQeEdwOThJbldGZmg3R1Zq?=
 =?utf-8?B?Q3RqQ2dOL25WVnBLLzJnUjBTZkdSa3hYbDZ5dnBoNHIvMnlvOHhzRHB4V0Zq?=
 =?utf-8?B?SnpxekdhL1g3VnFmL2pxQkNQczc3Mm1XbUh0QXNpelY2NHNEOGNjN29VYllI?=
 =?utf-8?B?SVVZL1NEV29vbXZCYzV4VERUZGhyblpzYlpzZFZDeFh6MTRrUWYrTUgra05N?=
 =?utf-8?B?V0FGWXhIQ1gycng4T255MDdZcGsxaHppang1dTY1VXFhREpiZXZRTVdWeXFZ?=
 =?utf-8?B?REs1SzVRU0FzZ0t6TU1Eek1WTkhJVjhHck83ZktWNnZXRU1wU1VRSkdEMDNS?=
 =?utf-8?B?TnkyN1lXam9XSTlDZmwwNEV2SWp1b3daR2F2L0dwSVhYQmt1WWg1dWFua3JH?=
 =?utf-8?B?cTcrY1ZPSUkveFVxY3cza01PZFZpRlRKczN6WTc4dkFDY3BMNEFVVW40bWdz?=
 =?utf-8?B?QVRzekFvRXRmbmZMM20rZ3JQTmh3WHpWYmxtcXJRNGUxOFhrdVNCWkg1eFpP?=
 =?utf-8?B?QWpQM0JFcHFDZlpvL2Q4eUpjSElEOFh0TzdDSk9KMzRzNzQwZHJ5aW9vdzJY?=
 =?utf-8?B?UGdxcXlFYjBkU3QvUkp1ZkdsendnZmdRUFMwUHZDZlNTTzZPY0ZVd29aZG1Z?=
 =?utf-8?B?TDZDYk53N25adEtQcTNKTHdYSXpaOTFCRjA3VDFVTTdYRy9valVZcjk5ejF5?=
 =?utf-8?B?S2Uxd0p2dVdrRDhVR1VZdUFIRk5wZ28wZ3QvcnM4RkprMEhRWG9KMk9Ed3Nw?=
 =?utf-8?B?U2g3SWFuKzhXVTlaSFNUcHlteUZoenBxV3RvNzJBdG5yVVIybzl2OWRJc0l4?=
 =?utf-8?B?K0xOWlhEdjVZN0FqVW9NSWdWT1ltSWFka2NUT0tMV1Bzb1I2WUVLRCsyRTg2?=
 =?utf-8?B?WHhNdFV1ZGFMc3N5djlUMWFISUlSRitwR0FDeHBiaUdrZXdGVEhYWlFNRWl2?=
 =?utf-8?B?aitOY1dHNllHQ3ZsczdsMnVZN2pLdUVaaS8zdGlWRGhPdURtbWJidmpkQ0ln?=
 =?utf-8?B?L281cnV2aFR6ZEVYYXN3d2d5SjJ5Nmc5SkJBRzd3cHY4ZDB1cStabi90ZHAx?=
 =?utf-8?B?MnFFSmRwekFBYms4RWZyaWNmQ1hZY2ltTWdpazZLZXBmRzFncnZFdlJwZ1B6?=
 =?utf-8?B?L1NTdk5oTDJNSmZLdmJWb3ppakFyWHhiSi9CU3lPMDE1VDNMNk9MQWFuUUJ2?=
 =?utf-8?B?ejB2ZWZuUEF1WjdFWGNRejRYWW1ZNjdqSEtYc29oWllNMnpTcG8ybjJ2UlZJ?=
 =?utf-8?B?VjVrNTAxMDNlR0NyM1I1WGFlalBNZ2pYUWVnSEwxS2ZUQmhsakk0Z0RBV2tC?=
 =?utf-8?B?dEd6NUNQV2hKMlEzKzV5b3RHUXUyMWphaDFxZkFFUDNkbWVybGx6WXlSMFN3?=
 =?utf-8?B?S1NsOXNYaTdZTkhTVE54RmtkdFUzdU5peHlpQnFXTElud2xkdXNINFRiL3cx?=
 =?utf-8?B?RWYyQzJ2cWM4R0Nsck1FU1loM0swZVFPNHJrQTJ0MWxxZUF0M1c4UHBURkVC?=
 =?utf-8?B?YnlDZStFZnlrVXAyVnlTb0prSG1SQzBCZTVTOHRVSkNqWWFDLzU1OCszazgw?=
 =?utf-8?B?VXhXUk9Lb1J5ODdKRXZYVmFLUHZwcTF0Q09WNkJPem5PUitNdHRCMUhpQktp?=
 =?utf-8?B?S05mWXkrR2tBT3VpbE9XdmpBOHh2T0hsaC9DbVZtR2NvNDBnVkZpdEFXWFpo?=
 =?utf-8?B?YTlxaERNTjlMWjcwTGttV2FLdHRwdng0MTd0RG1RREp6aE05MnlmY2JTTnUx?=
 =?utf-8?B?TGdpMmZPNUtpUDN5TVJVclg2Q1BCM1ZUNk1uZ2ZWcno1YkdVcFdPSFRVTStq?=
 =?utf-8?B?SFlBdis3VllQbEtnOUdXWXlKR0NpUW9VamFZci9mRVllK1BtUmorWGZ0OVBp?=
 =?utf-8?B?eEdXVWxoUWpGRml4cmdWTXUxaWFIUDVVRWV0STdWeGRXUk52RnpEeDVocVFY?=
 =?utf-8?B?c3BBclVVZHdNRENkc2M5SzhMcEtseklVRDhPVDJneHdaVTBEVjRQRHF4cEV1?=
 =?utf-8?B?dXI5aVNSc0ZmTi8rM3VTeTBXdldaWDlaNEs4ZjFvMStzYUdhS0VzaWRDQzNY?=
 =?utf-8?B?Wnc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F2E75A06BEC3BF4BA1366B15C94A2E7D@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99af7094-b129-4293-4f2a-08dacda44608
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Nov 2022 22:44:25.9470
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hb5G5rEQ60GYRKvpuw9D6nPoWbbCMvi9WzmxcOJAbT/YkaJQh0HJn+Pbi/oof+4oQKHvDEOf16E6AJn8dsnKVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7757
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

T24gMTEvMjAvMjIgMDQ6NDcsIENocmlzdG9waCBIZWxsd2lnIHdyb3RlOg0KPiBObyB1c2VycyBs
ZWZ0IG5vdyB0aGF0IGJ0cmZzIHRha2VzIFJFUV9PUF9XUklURSBiaW9zIGZyb20gaW9tYXAgYW5k
DQo+IHNwbGl0cyBhbmQgY29udmVydHMgdGhlbSB0byBSRVFfT1BfWk9ORV9BUFBFTkQgaW50ZXJu
YWxseS4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IENocmlzdG9waCBIZWxsd2lnIDxoY2hAbHN0LmRl
Pg0KPiBSZXZpZXdlZC1ieTogRGFtaWVuIExlIE1vYWwgPGRhbWllbi5sZW1vYWxAb3BlbnNvdXJj
ZS53ZGMuY29tPg0KPiBSZXZpZXdlZC1ieTogSm9oYW5uZXMgVGh1bXNoaXJuIDxqb2hhbm5lcy50
aHVtc2hpcm5Ad2RjLmNvbT4NCj4gLS0tDQoNCkxvb2tzIGdvb2QuDQoNClJldmlld2VkLWJ5OiBD
aGFpdGFueWEgS3Vsa2FybmkgPGtjaEBudmlkaWEuY29tPg0KDQotY2sNCg0KDQo=

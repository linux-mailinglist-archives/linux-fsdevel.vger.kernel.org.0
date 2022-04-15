Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B92BC50242E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Apr 2022 07:40:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349615AbiDOFm4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 Apr 2022 01:42:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245194AbiDOFmx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 Apr 2022 01:42:53 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2080.outbound.protection.outlook.com [40.107.93.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADA1711A00;
        Thu, 14 Apr 2022 22:40:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XaUp15sxV+//g92SNHPxpHEIn6Z0vwNxlZ5SiGEOC7n7Y/7SHZOg1QrGwNi+VawjXeEdsooPVfiTferfy+60OecCfl3uv5VV4B+CGo2rWILU6y7YrB4eQKBH9LV/lCSc+crg/7ewvxQmS2/vuYqOay7eJYewBvA/R160NYW2iX54/BBpBerimiazjbnxgR+Ad5eTSrxf/Tnuiq67KLytvLF/zs6nDke9q2KiqBg8nNYmuZBXSCcXmbcV4ZnCyD+ghkGXQ628ZGgso1YvqIKHXP5Cab9GnSCUY6RskwxAqF7EZ/sg8DIeS07IAGhVhHBE5279XeuGjWR0eSqpiy5Zdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zeqRsi5qUzfOoVz5mMgRNawNkDuhgO1aMKf+Il7fseA=;
 b=a5qqqDjvchMTx3X6EmLdiBAbZ6ozPaEX5RpA2w2s1HkzYH/1DzzjdsztZZ09Nb2p9/yFlLMmtgmj1mASL4vrkvyrRvxfTZ3XcSQ2NvKHiqzeQjbrxdTfoNxjNkoD6cNqPmGTmlhHrJ/Qno8QL0q17XWm3iCIFKAMYgHL5ex3zy9OXTRt56cJyUHXToZCS1jn3793fB+Nmie/He3XVjrpV/yotxwaaK6p2VMHYJgJZHLOgmVbCa8IN18+DHZ7y5dZAT7myJP6c7TVMBfRp+dZDelt18yEB8aY04P68bMoq3ctS4p/B8adm5fy1Yh+GidzVWEavSG5IKvakzm+F0LSRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zeqRsi5qUzfOoVz5mMgRNawNkDuhgO1aMKf+Il7fseA=;
 b=azL6I2325DJzuoKqfpuEgluZIpFyKYMAebUZ3uVLb+D8/min/TTIi0GhU5pc5YcoWY3ypu+cvJ2h6kPJ5DzWPQF4Ka+PXGN3utcWBPdOFzQM0cPm4O9O4qw7kZkIL66j6Q/KzDy1bbaz9J0Kfi4ET5fFckgv1moefbaXSwIgsZyMZVVcwedMQE9MkQdzz7yiw2Hp0GxG9oyd07bJYodqBAMeLHSLU9v1uLw2SJF20VOgGob04i3fJh2YXt3oe4bFonCDvWM27tK/2xJHnIzjDDRRz6fQ5V7oHq5tr0JbngQ43LFbjBDPrF91HcbYlB4OVQbnZN4foXvyhXQ7TW/HMQ==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by CY4PR12MB1815.namprd12.prod.outlook.com (2603:10b6:903:122::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.29; Fri, 15 Apr
 2022 05:40:24 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::a90b:9df2:370c:e76b]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::a90b:9df2:370c:e76b%3]) with mapi id 15.20.5144.030; Fri, 15 Apr 2022
 05:40:23 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
CC:     "dm-devel@redhat.com" <dm-devel@redhat.com>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-um@lists.infradead.org" <linux-um@lists.infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "drbd-dev@lists.linbit.com" <drbd-dev@lists.linbit.com>,
        "nbd@other.debian.org" <nbd@other.debian.org>,
        "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
        "linux-bcache@vger.kernel.org" <linux-bcache@vger.kernel.org>,
        "linux-raid@vger.kernel.org" <linux-raid@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "target-devel@vger.kernel.org" <target-devel@vger.kernel.org>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>,
        "linux-f2fs-devel@lists.sourceforge.net" 
        <linux-f2fs-devel@lists.sourceforge.net>,
        "cluster-devel@redhat.com" <cluster-devel@redhat.com>,
        "jfs-discussion@lists.sourceforge.net" 
        <jfs-discussion@lists.sourceforge.net>,
        "linux-nilfs@vger.kernel.org" <linux-nilfs@vger.kernel.org>,
        "ntfs3@lists.linux.dev" <ntfs3@lists.linux.dev>,
        "ocfs2-devel@oss.oracle.com" <ocfs2-devel@oss.oracle.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        David Sterba <dsterba@suse.com>
Subject: Re: [PATCH 08/27] btrfs: use bdev_max_active_zones instead of open
 coding it
Thread-Topic: [PATCH 08/27] btrfs: use bdev_max_active_zones instead of open
 coding it
Thread-Index: AQHYUITWCcMUA8bLiEua0LAPQuFUBKzwdZCA
Date:   Fri, 15 Apr 2022 05:40:23 +0000
Message-ID: <f4851d27-c4c6-7fc2-9c32-ee1ae891c598@nvidia.com>
References: <20220415045258.199825-1-hch@lst.de>
 <20220415045258.199825-9-hch@lst.de>
In-Reply-To: <20220415045258.199825-9-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9d43f1e0-5642-4bc0-dae4-08da1ea27005
x-ms-traffictypediagnostic: CY4PR12MB1815:EE_
x-microsoft-antispam-prvs: <CY4PR12MB18150B7B7C6465355214E778A3EE9@CY4PR12MB1815.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4ZPhtRNK+M5DKU8YWmTcN1yGt63cADpKaKfCy/SEb0ur+bnkBgj3MlbsUf87YdTU/lEwo1kpqxgFgtH8fApnw+l4mJQzPxaR2it9Negil3/1unaOyHoHqsB2RYc4eAWOy7TjHI0V9XtWp0eq8Q6nFlIrU/IQA9ny/AGrRroqxVS0UYCUUBfTbs0OQFL+twKXYYhUOdUF5NGxpRRf/UU3HQ3855viSwY41opIcAH5MN3OiLTGmxOY6qgrUbpyq7SaPp9g3wS1wvUL8ahdr9Vr+8Ua8vSbrn31OnQniKki7qIPMfi/VQGYNLn8wpC/AYXmcfm9Aui0kTzczK374wimI5S+9mGdcIUUXnQpLNxt6pa2ycSh1NipecEHR5kDNNYMMuezpb2BqWkDPjZJk/xmFSuN9RZlpk/Rt45rCQp/6Q47VSXKYSwvB43vOFYqSmdFzhmlkwnsmw5gdzMnd6rLw3wo9ykjXTmv8oOCNpOU5uUOI6nsMvLtFifgR0AhkO41VtGfwUFo4fkHTCfFmMDK2bOrVNRiAnkNSeg4knlHo1ce02U1FgrWfBtIbv6KlV5VDeKgDhTmzeyQrZYwoS3D84S56snOINbURrksogAlCBvSi4vfWgD9y6SpMsQTlr8KXJ4PJnkissEDr0GhMG96/mFk85ei8zPqQg0jPKDCHnTzGWFmG7w+BtU9ztBkWW99Sf8RB/aqb5cuMtiZTpMjDHrjlwVnor19WwImHXrimuJjSYpjbfrMSB1YXRasRs/xLdqtS6uovYxboYtN85dQ0Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(7416002)(8936002)(2906002)(91956017)(7406005)(5660300002)(4326008)(66556008)(86362001)(31686004)(508600001)(38070700005)(6512007)(2616005)(186003)(53546011)(6506007)(558084003)(36756003)(66946007)(66476007)(54906003)(110136005)(71200400001)(76116006)(6486002)(38100700002)(64756008)(66446008)(122000001)(8676002)(31696002)(316002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bXNVZ0s5eHh2SjU5OFR2YUlhcVk1azI0dFRONmRyZW1XTHo5REpvbkJ1d1JS?=
 =?utf-8?B?N0JCV29aalFmajl6eHg2aVZJY2t1dlQvbzJxV0lNOUJJSHE4bXE5am91cjR3?=
 =?utf-8?B?NEd6b0YvMTZhb0ZUU0UvSUMzL3BYNEZ1Ny9YeSt5LzZEUS9sMWFYSU54RTlm?=
 =?utf-8?B?VFRKdC9ZclFITE8zdFhJL2YzTmZVYzEvU2J3anBxZlk2TmgvSjhESXhDbmQ1?=
 =?utf-8?B?OWNUUTVzUExzYVdXRlZZTTl6Vkd5dWlPMEt3LzZHUEt4b2xPSmR4RDVkWThH?=
 =?utf-8?B?WlE4RHduVjJBam13c3IwV3JFcXRFZzd5bmlEZEFybjlZRVI5TStGbWl3RnRM?=
 =?utf-8?B?MytzUFlUanAwOFpHR0RFbGY1YUljTnhwSHVBQ1drUkE3K3dkVjNBU2g0YXl6?=
 =?utf-8?B?QWNoZ2sxcTd6a0NJN0RkVmNGYWRMeFZpZ2Z5WkJvWHpiYUJPVE9EMTc4Z1pi?=
 =?utf-8?B?ekJMVmt0bSt6YXFkeTlyK2szVFhIajE0V0ZhdWU4V1g4VnczbVR3R3FMTjJn?=
 =?utf-8?B?U3A3RlR6SS9uRU54OHZUL1VBUit6ZFFJTndwWWRBc21nUlN6cGcvUVNRSDRw?=
 =?utf-8?B?U1JHalNFQVhDcEpETTBWclhhVXFMejBCTGFWT3I2WVFwMUJvSHBlaDdqeFdu?=
 =?utf-8?B?TytkVSsxRWdjUTFnVFFKOVd1QnMrL2Irb0ttMUxUR3FCVEVKa2kvek5XaEJY?=
 =?utf-8?B?ZWt2RHF4UVJzMzdqVmM4OCs5NnhhejZsYm1jbWJMQ3dyMGxUMzVWUGpRekdl?=
 =?utf-8?B?Tk00K01KY3JvZktIZGh0ejIraWxYN1JlZm1aVGxyM1IwVklhbjhlWlV1dkJq?=
 =?utf-8?B?ZWExcERaVldteEgxWUpuSHB1U3FxMUw1QnUxcUEwQVlpYytIcXBTMmk0V1VL?=
 =?utf-8?B?U2prRFBOdEFEeE1jTmFlb1lRZVBJT1JVUFdLOFAvTjJhWEZjK1VlZjVEcCtq?=
 =?utf-8?B?N1daVC9MQVg5WHRSTTlYWXpxMWIvQVNvdVcyVTJ3R1lZM0p2eC82RkdmZ0l4?=
 =?utf-8?B?Z0UySFJhM3R6OEY5aWxsMW0zWnJIM1A0SmdJcVhlaGdodXpCOVhneHNtc3Nz?=
 =?utf-8?B?SkZ1dmp0dlY2R0pqaGJIM1dJNE5ZNmhlOFJiLzlyVnVwNXBsNExUVkZGK2l6?=
 =?utf-8?B?OUl5UkdETTR4bFI2NWhXYktRYWtoUDVvaGpoRmkwSEZxeHFZR3VLSkJiZ3pr?=
 =?utf-8?B?aXJxUXovV0h4ekROWHVyOEVvTTBtN3MydE01dWV3emZTaGxxMGlqTU43NHpy?=
 =?utf-8?B?Mzg2UUtKTjQwRGNWUGovdlViSXk4TmthZ3dQTXNHQ0pCa1VzOU55WGZzcjBi?=
 =?utf-8?B?M0VHWHBKTngzYy9mR0xkUHhZT0ltdW9aS1VEUlNwbHZMZ2RQR1FNYU5KNHlz?=
 =?utf-8?B?cG1SeFJVdkRaTTFDek9xTi9mM0kvLzFKbHVveC9GUVZlOXkxdWNaY2RyTnR1?=
 =?utf-8?B?VXFxYS9US2dZWXhBZ1EwallXUUlmdE9ZRVN1S2xTdm9vbkdtWHAzRjRncStW?=
 =?utf-8?B?RjYwT28xdm9wVDZwMUpUSEZpR21GeG0wdVF4K1FSL04xdDY4SDg4RmcrVFhv?=
 =?utf-8?B?U2FsWmREQnpoTWMrTmI4bjl5MVRPbFZlWUdIN3FJSWMweHgyV3BlbVNWSFo1?=
 =?utf-8?B?QUNsY29PdFNjS1RBL3N6VkI3OE5kV1J6bFpnc1JiYUpyUHdzNjBhaENZalg2?=
 =?utf-8?B?aGtsWXJMbnNDS29IOTBNK3JJYkRxVFpxbUs3aUxLVS9sVmpaWS9tYndJTzN3?=
 =?utf-8?B?RkFEY3NyakFKQmVTamNSc3BwbjlaaTkzem96SStSUUtXQ1JwYXU5YXliTVM1?=
 =?utf-8?B?YWlrc0RJV0NIL29nMXVUclExaS9yOXU5MVhNdGpFTEJPNXUrREwrQ1lvSW5a?=
 =?utf-8?B?eWdYaCtqekswbHltRUtmNENEdURDU0xVdXpTVVdkYWlxcTVvTzk5ZTQ2YTJJ?=
 =?utf-8?B?TWloY1dVSFdwbUhoOTN4V0dWMDBTSXgzUUI3Vys3WXpMU21JaUpqVFl2Tnhh?=
 =?utf-8?B?cmZNa2wrbGpnMUJndXNQdzlQZml6K1NvTm9nc1IrY1A5a0FFeGtPZTMzaVFh?=
 =?utf-8?B?cE5zV29sN1Z4c3pUTXNrT2JCZDMyRy92VFlKMnBiSHZGYkNsSUFic0x6ZXNW?=
 =?utf-8?B?QW55aDBDYUtrWGp6OXpJOWJMWUorUlliaWJ6YmQ1dzZtdEVOUFdFVUNFNUs3?=
 =?utf-8?B?UjE4MlFnS2Mrc0JmQXJjYWgwa0M2L0dVUktFb1lnWXArRjFaQ3I2VjFOc090?=
 =?utf-8?B?UUlWRUh6Y1Qwakx1RTVPekhBN1E2SGU2ZDYxU3ZJekVnWGNsdlUvYlFOdDVR?=
 =?utf-8?B?dmFxYk9RcXEwWEJnWEdwYzhGYlJpelJnTzVPN3N4Tnl5MXgzZzAzd3FJL0ln?=
 =?utf-8?Q?LoY5Xge/tXZoe4cU=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3BD681E83CBB8E4A8EA752EE0A94BCBE@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d43f1e0-5642-4bc0-dae4-08da1ea27005
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Apr 2022 05:40:23.7751
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Mi5Z+Cd0ksdzCO1rvE8Hu0ta8qQXfT/P1tA5VxBskatP8RIWaggzSdjfKrbZb/7EXEjVORAi8kufABb00rwpzQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1815
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

T24gNC8xNC8yMiAyMTo1MiwgQ2hyaXN0b3BoIEhlbGx3aWcgd3JvdGU6DQo+IFNpZ25lZC1vZmYt
Ynk6IENocmlzdG9waCBIZWxsd2lnIDxoY2hAbHN0LmRlPg0KPiBSZXZpZXdlZC1ieTogSm9oYW5u
ZXMgVGh1bXNoaXJuIDxqb2hhbm5lcy50aHVtc2hpcm5Ad2RjLmNvbT4NCj4gQWNrZWQtYnk6IERh
dmlkIFN0ZXJiYSA8ZHN0ZXJiYUBzdXNlLmNvbT4NCj4gLS0tDQoNCkxvb2tzIGdvb2QuDQoNClJl
dmlld2VkLWJ5OiBDaGFpdGFueWEgS3Vsa2FybmkgPGtjaEBudmlkaWEuY29tPg0KDQotY2sNCg0K

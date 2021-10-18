Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D34E430FCB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Oct 2021 07:46:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230056AbhJRFss (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 18 Oct 2021 01:48:48 -0400
Received: from mail-dm6nam11on2073.outbound.protection.outlook.com ([40.107.223.73]:23328
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229533AbhJRFsr (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 18 Oct 2021 01:48:47 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QQPb03ftzKB1tszalfvbqQA5hX7guySqdqmQMz97Rk5CdfXXRbKp6SNsEcl+gyganzy1NMxcZGvAZRkWvV7mys/wCo7yWr/Y88Sc+qPJfhRXpMFNzPpX2Nr6wJ2YGDgzGrhpacUFSTdUBSlbn3w4wzICGz0TWsTGLhEEouynykmd3ISVmOgSFmUImns07koatLCgeCBTe+ItiZRVjshILlM1BZmLZzBYQyoDarnYFulVBJfDe0C54ZpKonMFt+k4lM0XFMjATRqogoaZ8e7C6n9NftYwrk5cXgx834oI5qJjOxMse68DmaJThuhCDOiixSCQFjZY1QpGKbEpYIZRAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kINAa/Z04YU4i/wC1CQhe6PXPv9YxgHAS2zL29QmIbw=;
 b=MOgbsh37UvPiikmXsT7ki1rGkUsxDgXDvf4rdbEF3udqK+MkM2L9iULrW6WYTZ3r/pQkxX8rXaERatqldQJ6lAYonN3EL59gj3hSCOsoWA8UImp87XzAf4IEVb3zHaISlBNQUvWye59sSakVP388M6R1qQYGfICBwBK2O6Z6S0OVrvVWPeE+I2SNgqW3rGBn4RgQPoIjYtDXMIZaWL7eWL4ZHhhxijF2v7u30dBYSlyuf/ypNchnvAXGjR421enF6a1MKLjquhR4sicFGeax2GjQbXdwZZOo2i/oieusXqR5V1lX42P49XWmgVlAXTFo/WuWe6ae0pkgJPGXvxLqTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kINAa/Z04YU4i/wC1CQhe6PXPv9YxgHAS2zL29QmIbw=;
 b=aFzddktEz+n8maB3vSv+bLaZP8K6eHed05Q9HKZ8ZZQdwjYanhk2Pj7czaRfrsMbZiYEk9iJsjpjmlMAikohTz00+tigHbxqNXfanUhY7HyN5ngKJZf7gAsn9w509CtqP2NaOtQLyexw3M5onyqx/TLpmJRFhozksnNj9q5teXC/06Lv2NIAuQ22Wjj/SsHwJYtGb7SvIZoggHOP2NKVXghw2ySovd2rO9tVsLn3sP0BpjgIWNYd5ELjqMP6vMhsEjagE45iouZ7kTXvy0ubRZahgvrVzkKeSNxeeP8no2ggHNQBtifOWI6rjSnk/I3hoYNySrnSAnPD9121UbuwLw==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by MWHPR12MB1136.namprd12.prod.outlook.com (2603:10b6:300:f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.18; Mon, 18 Oct
 2021 05:46:32 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::3db1:105d:2524:524]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::3db1:105d:2524:524%7]) with mapi id 15.20.4608.018; Mon, 18 Oct 2021
 05:46:32 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
CC:     Coly Li <colyli@suse.de>, Mike Snitzer <snitzer@redhat.com>,
        Song Liu <song@kernel.org>, David Sterba <dsterba@suse.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Theodore Ts'o <tytso@mit.edu>,
        OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
        Dave Kleikamp <shaggy@kernel.org>,
        Ryusuke Konishi <konishi.ryusuke@gmail.com>,
        Anton Altaparmakov <anton@tuxera.com>,
        Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        Kees Cook <keescook@chromium.org>,
        Phillip Lougher <phillip@squashfs.org.uk>,
        Jan Kara <jack@suse.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>,
        "drbd-dev@lists.linbit.com" <drbd-dev@lists.linbit.com>,
        "linux-bcache@vger.kernel.org" <linux-bcache@vger.kernel.org>,
        "linux-raid@vger.kernel.org" <linux-raid@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "target-devel@vger.kernel.org" <target-devel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>,
        "jfs-discussion@lists.sourceforge.net" 
        <jfs-discussion@lists.sourceforge.net>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "linux-nilfs@vger.kernel.org" <linux-nilfs@vger.kernel.org>,
        "linux-ntfs-dev@lists.sourceforge.net" 
        <linux-ntfs-dev@lists.sourceforge.net>,
        "ntfs3@lists.linux.dev" <ntfs3@lists.linux.dev>,
        "reiserfs-devel@vger.kernel.org" <reiserfs-devel@vger.kernel.org>
Subject: Re: [PATCH 03/30] bcache: remove bdev_sectors
Thread-Topic: [PATCH 03/30] bcache: remove bdev_sectors
Thread-Index: AQHXwchkeC3IRJLxik+08glUYT276qvYQ3EA
Date:   Mon, 18 Oct 2021 05:46:32 +0000
Message-ID: <b910c530-1aee-c9f3-c9f7-42c89084c83d@nvidia.com>
References: <20211015132643.1621913-1-hch@lst.de>
 <20211015132643.1621913-4-hch@lst.de>
In-Reply-To: <20211015132643.1621913-4-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
authentication-results: lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 60fa8628-138a-4118-83f3-08d991faa3c8
x-ms-traffictypediagnostic: MWHPR12MB1136:
x-microsoft-antispam-prvs: <MWHPR12MB1136576339658024B5ADA92CA3BC9@MWHPR12MB1136.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:517;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2Ovws/QzAIktCBj8yjmrkzjx187FWf75B1nkRjlq3IyfxHLJqc8SSctXjniRNgCIB3LIzUuyy5StZeesVE8hlG+GfkQ61+/FY5BnlAZEZHYILmR7A5GhhZjj90A5i+/EtyOncsqeA5w+T7MVNzvxkCka4nc2h6yUcqZAtiKKhkymezHkxGXOQjCLzwc609X8uqosHOKp1UbJgABX5jzbRgCNGsm5hehq1/fZizgTICineCIsbsZ0aOVR6aZw6LUGjidWrhW8dd6+fKUO1RYlLFcexQMB7UxVAqjLBN9KrI0j412uoI+e0e1AuQ4axYFUBmV+e+oNL/dMlWs9m6OF6V/EXKD+VSgx+t/pADG1lFY7My8ZL67e63hpgk49HPBMsV5j2n7dsZQ3N0QFkOTtp12Tq1RgyD6sPdNPzVxg1z3PsxwTtt56Sc6Wo9KLQj3UkibhHtPTmkfB+KvkHzSL8IcLJPJ0xcvGhC10dUjjR4juPC8+aqUL96QlKyp+VocmZjbD6U14oOJTsHIuiLfcLOrV3s8QEwoomRQhy+g3UMVK4O4VyfCmt6iKPjWrdoF7fm7GTD0hUhZFRxKlz28so4JwqdANYoT3BglQ85vtqjp2C1f3khFPDH5GVVShB3gY+1OApwRdE9BgkHmo9J94xzgaLWCopYMcayWYZK9RbW2vGMCpuSxynVxSWFsVub+DpjNxdBDsjVHRV94o5B7iotLY9qEqfvjYhgf/LpexeC8GNzm4+SSGb27CEP7+OSE9rU9nI31RCpCL2IMbvjltRA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(2616005)(2906002)(6512007)(86362001)(6486002)(36756003)(122000001)(558084003)(7416002)(7406005)(31696002)(110136005)(71200400001)(316002)(5660300002)(66946007)(66446008)(91956017)(4326008)(76116006)(53546011)(66476007)(64756008)(54906003)(508600001)(38100700002)(8676002)(186003)(8936002)(83380400001)(66556008)(38070700005)(6506007)(26005)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Z1E1anAzb3hpVGtRM1Q2WTRzcXJ5ZjF2K1BsVEplY1NjZTlEUWowZnNUaUtl?=
 =?utf-8?B?T0M0V01Zcm5LcVQvUEF6YW1YZGFjVE9iZ3FISjBHL2lJdVk3V2s0cmwzeXd5?=
 =?utf-8?B?THY3Qm14VHNldHBOVCs1WG95em5nK3FzNU4xWmh4alNLN3IwdWxFUkRoT3ky?=
 =?utf-8?B?cGdDNlZmUUFxdk9BK0R3M1l4MjNYTzNBdDV2WHVVd3RHRFlkUXFqSE9lWVRO?=
 =?utf-8?B?a0kya09ycmFSbjZlbDBURHhuZngyRTd3VUV5V0w5Y3V1UWQxRGFldkxmYzR5?=
 =?utf-8?B?K1Nkcy9nS2tBMzlIOWUxN3BDWkJlTU5TenR0c1RWQWJDZ2tQMDZQckpWb1dr?=
 =?utf-8?B?QWQvWFFtamNiQkFOdjJkRnhVSFdaQm04RUowV2lCV2xLdUx3cVBFZERyc0ls?=
 =?utf-8?B?WTZ0dWtDZnRYNlVLZ0RvRlFMYytlYzk2Z3QrSlgvU0h2WEdnWjBJREVkNEJJ?=
 =?utf-8?B?TGlOdWlxZnNmeXhXbmw5UDlsNnYwN0hkS253TU9HU1czZFF3aGovZjk3MU9T?=
 =?utf-8?B?ZG85OUNON0VPM0g2Z0JXZzdkTUk1WStHUVRUa0UyL1kxOE5GVWRKMjZLQ0or?=
 =?utf-8?B?aG1LeVpzeUxvZm5GSzdIVGk2OHpQeCt3d052SnhZZ2JiYlkwcVJPV2hrZGl1?=
 =?utf-8?B?d1c2WDdaUG9renRmbGNLYmNpSVNGT2pTNXlQc0l5WUduVk5tWXplSEkzaHNP?=
 =?utf-8?B?MjFpYi9pV0RXcEJIQ3BGWFhVcFRvRE9odld2THVNYlp4MUhmYVU5cE5UZk93?=
 =?utf-8?B?MVRkQlZ2dU96cUE3bUFnQVFlN2RGYzZqZjNmTEFjWk9Nd0ZoS1g3NGw3L2Jo?=
 =?utf-8?B?SFBUZmhsZ3MybkdMU1FCZjA1UUluOEZjdVExZ0k2MUthV0NQY3ZmOWx5ZXlT?=
 =?utf-8?B?d05ZUzQ2RzNMZTlCVVpWTHpGRW1VdktWaTdaWkJUN013VFlWMGVqeWx5RDRG?=
 =?utf-8?B?ZXRGZGFXN3l4bk8zaFQ0YnJZdmhuU1VDVHUrQzhWYXZFbUQ3R3NhZkdaNW1V?=
 =?utf-8?B?RlBHeE5LeXc3S1hLZ1d5cy8zM3liQlRzRnBjcXlQTTEwbGdiaThFWjZLaWQ5?=
 =?utf-8?B?SGI5d3Z2Mm4zZms3WVpvUUo1NXU5alFFQzFlVUdHcXRydVZlay8zYWUzL1k5?=
 =?utf-8?B?RDBTNzhYcm5NRHRFY2ZJVkJpeEU1NHpYQUVDbUJ1V3hIU0lwVnRNdTRBNjd6?=
 =?utf-8?B?eXRyWkpwZDhLWHVpRDYrQ2xiRFdXd3dzU1h5YWtZSEpXU2c5VDNMc3FMNFEv?=
 =?utf-8?B?STR4YllhM2JjVGxLb1dXZ3lGOXJkMTM3VGlaZWM1a1ZqQmJDVFRoOXFEY2Vr?=
 =?utf-8?B?b2xydE9oMUlHVlBGc3A5c280VHU5dzNXNkRxVnMwcmJZS0tvUlVFRmpFY0VX?=
 =?utf-8?B?TnYvT3JDVjBza1oySGNyVDUzUnF4S0Exemp1d01WdEhZckRKVmFPZS9YamFn?=
 =?utf-8?B?WDlsTWpzUkllZ2dFMzRxdzM1RVBjZUZkeUxPNFk0MnYyRlh6RmxiekZJZG5u?=
 =?utf-8?B?SjlIZUpEVjYzQjFFL2pQVkViZ3Q4N1liL1ljbjZwU09YNmRwTEorRnltbGxI?=
 =?utf-8?B?S0RWeU05cThCR3hHYlk1UjdDOENVNHNkRGEwMUpGV0srSHVPR29NUG8wQ2da?=
 =?utf-8?B?cXA0Y0Y1REZhQVFwa3Rid0NSMkR0c0pBSyt3STNqSjRnWmRzbFNtUEM1cnly?=
 =?utf-8?B?aEZ2Q2tpSkZ1NG4wSVdkbmx3cXZDMEtLenJhSUQycXJyRlIrb3lNTHlza2kr?=
 =?utf-8?Q?eiM1JOOphQEHs30VRs=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <276A457CC12A29429674DCE72537FB49@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60fa8628-138a-4118-83f3-08d991faa3c8
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Oct 2021 05:46:32.3865
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cewEDTdIBUFBdh3Ewz5MXnO2NXTGZxza+AJJU7u+pIhg/FLIaPQZY93VmNCW33VEzRcWlzFBX+qel49RHX3Rng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1136
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

T24gMTAvMTUvMjEgMDY6MjYsIENocmlzdG9waCBIZWxsd2lnIHdyb3RlOg0KPiBVc2UgdGhlIGVx
dWl2YWxlbnQgYmxvY2sgbGF5ZXIgaGVscGVyIGluc3RlYWQuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5
OiBDaHJpc3RvcGggSGVsbHdpZyA8aGNoQGxzdC5kZT4NCj4gUmV2aWV3ZWQtYnk6IEtlZXMgQ29v
ayA8a2Vlc2Nvb2tAY2hyb21pdW0ub3JnPg0KPiBBY2tlZC1ieTogQ29seSBMaSA8Y29seWxpQHN1
c2UuZGU+DQo+IC0tLQ0KDQpMb29rcyBnb29kLg0KDQpSZXZpZXdlZC1ieTogQ2hhaXRhbnlhIEt1
bGthcm5pIDxrY2hAbnZpZGlhLmNvbT4NCg0KDQo=

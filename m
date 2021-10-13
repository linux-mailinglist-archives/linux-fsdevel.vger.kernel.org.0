Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1647242CE71
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Oct 2021 00:36:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231643AbhJMWie (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 13 Oct 2021 18:38:34 -0400
Received: from mail-mw2nam12on2065.outbound.protection.outlook.com ([40.107.244.65]:45318
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229930AbhJMWid (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 13 Oct 2021 18:38:33 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nmjsyRJbyrbS7BC/cBpGPtpeARt3dYGDaAdqaGF73algf2SGXSeYzeyWmPHtgL6Em1i/hB81Ah86rWqtMnALTT0oFGdGxb7Rkhi5u/N9lwf+UzkRJr6PwDm7Kw+raiQ9xF+JW4BvxqE0hSNp+NTJCFw0B5zX3fauPoJ9+tUnGpV/U4mfKWE5+2vNhKt/3nPE+1bmoE+uVy4YHfcbepyXfJiQ5s4tEyTqcd9KkTHc7l36nWlAKviAa6ihc/hzMiqg6f4NnNz29Rc3pNTLX5hmLrPfK7ugDyt2nPKsKI9EedIkYDYwcyyAdeqCGNeUs7ahEMdiqDx6Z+ubi21z7Czhqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=93r2xFlzBgp2P3mF+smPFUwUw7bjnKI+H5iB7xljbTo=;
 b=MOrSz9fuqRpk0NRQyjHCo0477ouIKPzu3aRYsgN/RDwrh56KNLie76AulVodGEC3t5NGsZanHhJpPOX6Cmuxd0Ogd3576mVFHFadFSp6B82GmaKcA+j+dgV39VtWDs4iplDM28MxBXvcol+8AubyHoQTv16GAYGidW00P9WxfdJSwtOiw8fB+Ef41SZdDph5MQfn03Wp1wkSbdLarAN4lgCO8hd2vLkgA5h94z7/GP9KLgF6/mvh8ph3vyVXuDdE+1/aOXgpCsu5gIqPEDaWjq2erYYsTm2Wn7Xe+wZlGNerln5oxaqK91dlcFH47NmNgOc6Spnqlx/DcxIIXEDebw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=93r2xFlzBgp2P3mF+smPFUwUw7bjnKI+H5iB7xljbTo=;
 b=SRHGYjgiQSDMpeU8plPourPzimx8C9mqti76X4xDngMFD0zMHhNHrs3uNTZgRunpFUHLBPc9Yi5UT326e1NVDD33mphxWlmRwrqbJ3BAhsHcOhf1ocWHKZb942REEjq/5xmUJTOEXZZYEJxRBfxqKnw1WlG1uTFZXmBsFKHD8Xvyp7KDGvUgSEDq8AIEGb9g3qA/WJz8T9HL1MbwLBUAXtWwFuh1gnyJka07ouO4bLW8W3QCRsS4j2wY80VTMLZDcPAUIL2T5UbeUbEhgOoPPgOHN+0sjQggavHruRhIUlldSZTrYVzg+Fvr7K45eEgoIM5YU3+QItIddGQy6Bo8gw==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by MWHPR12MB1472.namprd12.prod.outlook.com (2603:10b6:301:11::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.25; Wed, 13 Oct
 2021 22:36:26 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::3db1:105d:2524:524]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::3db1:105d:2524:524%7]) with mapi id 15.20.4587.026; Wed, 13 Oct 2021
 22:36:26 +0000
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
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
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
Subject: Re: [PATCH 11/29] btrfs: use bdev_nr_sectors instead of open coding
 it
Thread-Topic: [PATCH 11/29] btrfs: use bdev_nr_sectors instead of open coding
 it
Thread-Index: AQHXv/MJov1VVTRZAkC+g1lS+pf5Y6vRhZsA
Date:   Wed, 13 Oct 2021 22:36:25 +0000
Message-ID: <9e275603-359d-4492-98b5-520bbd15cc92@nvidia.com>
References: <20211013051042.1065752-1-hch@lst.de>
 <20211013051042.1065752-12-hch@lst.de>
In-Reply-To: <20211013051042.1065752-12-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
authentication-results: lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6111eedc-9aee-4185-445e-08d98e99e43f
x-ms-traffictypediagnostic: MWHPR12MB1472:
x-microsoft-antispam-prvs: <MWHPR12MB14725CD4191503C5349D3BEBA3B79@MWHPR12MB1472.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:883;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: r9HHMvsQJYFSQtKV3kK7co+vYX8pX/cREePkY7WrcNNoNNKOdjKvYqDpPhj4tUoPAgYiwxMEQsJPmUoht0DBLO5Uo8QHTvcjfM27Y15U6/BmztNrG6zVyLBP4Dp4TOIfyNXWt2n0R5dZq53rPYzkRGDqULQiUU+M1XGyCivhfHCh3FrBHyxiTWwJPjkAHaqJ8Dy/UIl3t7K2uWhkFlYk7SlPpiPm7NVAR4gibjjo9qs1M2ZCO7z+MleFIaNlGjfBAQDKPWT6ToLtcSAH4vwmfyJe/6NQG1qEBZi3i6GLTKdAhHhZx7ZHCZD6g/fzmQVnQvL///9IWbJLmeprCTMQzk8eZCRmqLZQu+gZ9VQqQ2TJE//o0bdt32+Ny0ciQbFof2QZSsdHq86pESutAOp80uzN4OqLt1CWvwiC9obK6+mvxBhDGRcqX4zZpyKaoRXAWW2fe/VcThQ1ePGvZosBBHO5DSUHPn/9UEQYvWVRruCFGk/3nD/VPeyXWVxBHi8NRQArgLJxeRj8gsxbMPtLh0WplZZrU1JKhqKzV5OZesC0egcQyDdKAeE3jwN9qcJQaJm0XX651GOGwnNFCkAF/VXEHw7ulm2/9d7zu0TUJVqmHrUrbBIyn8BFTnGz9zG17kiaO51ECCpHBaWVsHAGc/cK/t8fHIwrzXbDI3ZM3ts0NsUzYEI9uDO1fsu0HFB1/fDHfdy4rIAD93V0S06dAmudxtA4xzF9OjXUTA4sKShPy5MXeiPAH9VETzBMQQ60U5DT0E8p4CNKYF5RolIR2Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(7416002)(66476007)(558084003)(66946007)(2906002)(186003)(66556008)(66446008)(64756008)(31696002)(508600001)(91956017)(316002)(7406005)(8936002)(31686004)(36756003)(8676002)(53546011)(6506007)(5660300002)(6486002)(71200400001)(122000001)(2616005)(38100700002)(54906003)(4326008)(83380400001)(110136005)(76116006)(86362001)(38070700005)(6512007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?T0pYcjg1WEVZaGFsVXBkdmdQdUlLa1Jic2hwb0VjZUloaHFWSGtZRlpQU3VD?=
 =?utf-8?B?TVpwcnVqVDliWU1YWE5TLzFZaW92VGNzVHUwZUVUV2U5azFHTktYNEdpdXMv?=
 =?utf-8?B?TEx5Z1ZRS2ZaNmliWlYyeVVRTGhKU0NSNW15L1RhQWdENjdqRCs4STNEVmVw?=
 =?utf-8?B?SWFidkgvSE5ucDBHVytFcDZQa1VsckM1dDByK3czRzRVN0J4Uzg2VTFISWNR?=
 =?utf-8?B?bkE0TW56Y0NiREF2ckpFQjBrYk9SS3I5RHl1QmxrOXZVZTNyVExaMFRZR1JS?=
 =?utf-8?B?bEpMSG80S1Q0TnMrS2lJdWRKaENuRHdLcjg2eXBjNzdxb3lyZzNuUmJhc1p5?=
 =?utf-8?B?dll1TjVjQzBmTmRiVGkwVGVWWUx5UXBaeUtxbGg1YXI1Q2poR3lEaUpGUXpk?=
 =?utf-8?B?alloSWJKRE9mNVFOWGU0UDNjbEdlaTg3amc2SkhKN2oxb0hXMVNuUE1qNlZn?=
 =?utf-8?B?VjN1R0JDM05PTllONndJMTJlM28zYkN3NGV3MThKMDV6Z3BRa0JyOE9zelhX?=
 =?utf-8?B?Y3U3NnVVangzMTNZUmkyVXJvK1pTYlJmaFR3NEc3RTNjSXByMU5zNFZsZXJn?=
 =?utf-8?B?bDFDQ3psL0pUa2dQSXFHRFBhL3NuVHlzTk1DVEtSME5kckRJN0h0VHF3MTYw?=
 =?utf-8?B?Y1JKYzBYSHdvUHQ2ck5FTExGeThQVFZBVVdkL2hSTXQ2VmY5VlREcjBRMG9O?=
 =?utf-8?B?TG41QXlDSmtTbUcydkIwRUI4Tm5QYVRBNkRTaUtRN3F1Qys1TmxQdlc3Mm85?=
 =?utf-8?B?dkZ4UDVyZGI2SUtLdkJkOXJ3TXNmaUM0ejFqWGI5elBtU2dKTFFYVEkzQnpJ?=
 =?utf-8?B?VEh6NEpBRG5JcG8vRkhwRmRiVnp5SDN3aDR4Vk5vNW94SWppNDQ2UHJDemNO?=
 =?utf-8?B?VXBPTE5zelFYenA2b0NGRVF5TVdaRXVvQVliQ25NMzNoNE9qT0dvZUVyNkxi?=
 =?utf-8?B?bmJtbnR2L2RCbndPWGZ2WFU5OEUzelBKL0toUFNBMjg0eXRLb2ZDM2lHcVNs?=
 =?utf-8?B?RitEYmx0UkdvRzcycTZuaXAwcDVQSmJOaDcyWUZVakJnVXpqaHVjdC9OTFlE?=
 =?utf-8?B?TXprREFGd1czUklmVjYzR3lMdHBOREVmOVAwOWw5UWdWTWZtN29qVnU3d1M4?=
 =?utf-8?B?Vlprb3FvMUJTRUZ3ZmkrbExMSkZjbG5aT1dwdHNiZVprWVBPYUljSThHMnB6?=
 =?utf-8?B?ZDc0eHZRaEdEeGpaUlh2Ly9KZVc3RDYzNHdld3ZsbkdkT3JYUUdYTTdsODBC?=
 =?utf-8?B?Z2pWcnV6NDMxUlVmNEVwbnFkUnhBT0dYaFNzK1JXNDFIZ3dMS3I3aWJNYW9o?=
 =?utf-8?B?L1M1aDBDb3I3MDlOQUc0Sld0dWs4NFNnMVJMY05RZEo1aFZQbTdabkVOa29a?=
 =?utf-8?B?MTNDa3B5UFpFdmdaMG5VYkNsV3pleUJPTmNlamZ1YUUvVGlYd3VCcVVpVVBv?=
 =?utf-8?B?VmYrZ2NYczZUMVZwNmxuT1Z5MDNVcnlCVUppVjc3ZDFDRENnZVJRUEhIOTlr?=
 =?utf-8?B?K1Q4UC9zbVBscHl6MDFNcEdRZ1BkWnpLUHJBMUVOSUxxcW43eVNVcmMrdnVK?=
 =?utf-8?B?eWRwaWExcG9naE82Z0FiSktPVkVIajVVR0VRWEIzamNIbHVpSDRCWitUdXJF?=
 =?utf-8?B?NC9nSWdLQjAwNnUzUmkvbzFkb0Z3WTFRUUtycFBnMUNzQ1JYMmJ2a2FjRkpn?=
 =?utf-8?B?dUV2ZHBwMFZHU1ZVTVFDdHA4b0J4WnpKdDJuVjZZeVRrZEkvRlc3bkhGNWZx?=
 =?utf-8?B?M0pxalN1aFY0Tkl2bmFNTFZ0ejdsWGpUVkRaVHh4L2lQaGtjVU1sWW5ma0Ju?=
 =?utf-8?B?RWdydGU2OVZ0Z05wQ0dTcWorYWlLQlhEdExYc0VLQ0R1Zjk2Tjd5WlZ2MHZn?=
 =?utf-8?Q?F1HetC2Ixhil0?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <0B96D8945A56EF41ABFC6A6B96A751D7@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6111eedc-9aee-4185-445e-08d98e99e43f
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Oct 2021 22:36:25.8338
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 505xP4APZsyB6qWx2lT1fvQKpgSGtn9qKFqZAZ2XgiNLdpXMuDegy2TXycvJ01ru4RNezUNVKw8LUXzh9SGpug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1472
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

T24gMTAvMTIvMjAyMSAxMDoxMCBQTSwgQ2hyaXN0b3BoIEhlbGx3aWcgd3JvdGU6DQo+IFVzZSB0
aGUgcHJvcGVyIGhlbHBlciB0byByZWFkIHRoZSBibG9jayBkZXZpY2Ugc2l6ZS4NCj4gDQo+IFNp
Z25lZC1vZmYtYnk6IENocmlzdG9waCBIZWxsd2lnIDxoY2hAbHN0LmRlPg0KDQoNCkxvb2tzIGdv
b2QuDQoNClJldmlld2VkLWJ5OiBDaGFpdGFueWEgS3Vsa2FybmkgPGtjaEBudmlkaWEuY29tPg0K
DQoNCg==

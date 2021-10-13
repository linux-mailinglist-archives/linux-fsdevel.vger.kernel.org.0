Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AE7B42CE3F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Oct 2021 00:34:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231462AbhJMWf0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 13 Oct 2021 18:35:26 -0400
Received: from mail-bn8nam12on2064.outbound.protection.outlook.com ([40.107.237.64]:62464
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231450AbhJMWfY (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 13 Oct 2021 18:35:24 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SM2arQQxlIgoDYQ46t34DpvON3XojvqUmgBvj3625YvDM8OiZTXIh3Yxj2XldpfNe1+RJBdosqli6LqC+AmJLTDHQbrJxiojwcfpmSVfpXRpu7nRt9m8QIHPBjieSElYq1X0Uuumpjx6KhZfMpmlYhtYgIDGNBQHMfyQ5Shd3OhiL71ddclvV39ao6CP+U2v6S5DXgg5u1bq7ITlx/PX2U5l6qhnf7dKER4vtYRvY+COYTWby6aQKjuME2sTVm1Z/0SMWttZj55UkLBgAILR8rtZEnpuX+saGbptMZpvg+IzzdsybcnGDQITKYC2TmsA+T89gjm3aJz4NbO1ZgCV6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V9WNQaxe89gO8xkELPjDEHsY1By2K3v3YTrmazx1lBU=;
 b=WcFP2yj605NtTLcYHaSAd7nOLjvhEhxG827ixuJJv9I0WMQa7zqXeM7V3q4Hp6hxDICznXui4OCWExbvdpmR8D6n5N/4JnuaeoWYq8rI4q4i3xl26GXAxt0sJ5cZ0ice/EU0NuVhxB+BBOewE9PMFla6cOLnWr5eyi7Rcy21DKMz6DgT85VKVKgS1G6nkcVTfXFRd0lEUgJXv6jPPzgj29s2VK4y/uiYx9dtnu7yUmC78UfyYM5sOFt+Jw3LwTySe9DAjVyxgOaQjzKxnt13UDjhUYqkbuBY5rs6v+9Q7O6SvTwWLfEbvb8UCTY/r9Z7nfL6UpmT7JyMMc0G5zKXaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V9WNQaxe89gO8xkELPjDEHsY1By2K3v3YTrmazx1lBU=;
 b=GpOJhl+LAJaWxKBV1Lu0pgqBbaNRzR4vWpX9AHg7cbRd6RliVVV7f18G/yIuJ8n1yQZaotQ2qYnEeRYtq/oQZ2dbOkxDwwEk56ziBY4u5ui5jowrM33FF+N6wunLiRPk0MwRj6MxAIXnOQVMa8TR0QUhVD3laiur9XyQGsk1huuudfCXENn8bIerLX3JaXqu61E4lnwcQY/trhmzNArzxglLKCv+DwiATk1sLIRKDGLWuQhnRLvCzuVa7EUB/p/kgYZZ4oF5HjzVKXnFWA9156VxZ480AH109Os/mWmzLyqRvoJvRKlQbQOV9kGywsKhHsVynOMT2NlDWYae9/cUFQ==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by MW2PR12MB2379.namprd12.prod.outlook.com (2603:10b6:907:9::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.19; Wed, 13 Oct
 2021 22:33:16 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::3db1:105d:2524:524]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::3db1:105d:2524:524%7]) with mapi id 15.20.4587.026; Wed, 13 Oct 2021
 22:33:16 +0000
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
Subject: Re: [PATCH 06/29] nvmet: use bdev_nr_sectors instead of open coding
 it
Thread-Topic: [PATCH 06/29] nvmet: use bdev_nr_sectors instead of open coding
 it
Thread-Index: AQHXv/IJT42aTaoS/ky8slEigekLeKvRhLuA
Date:   Wed, 13 Oct 2021 22:33:16 +0000
Message-ID: <d061489a-af65-93e3-0e1a-5742b009ac79@nvidia.com>
References: <20211013051042.1065752-1-hch@lst.de>
 <20211013051042.1065752-7-hch@lst.de>
In-Reply-To: <20211013051042.1065752-7-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
authentication-results: lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 925e5792-cd56-400c-cb55-08d98e99737c
x-ms-traffictypediagnostic: MW2PR12MB2379:
x-microsoft-antispam-prvs: <MW2PR12MB2379A765A4511F401E080AB7A3B79@MW2PR12MB2379.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:883;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HmZNDs+/9bmFO3mxqVbYpCBiptkoJOhlXm6drvLo1eIAAPn0GDF5ReB0O24E/3QR9QdZdObW9Fmbvfpd9fmKqBvWculll//lsFwD7JiPtJy3K1fq/8reSUHRkcQe7PN6nyDBGUV6SqFU+AAs7oZI4SL98Nsc0lsn+SC9QCsjOFPAjQ245whu/OdX09HQC2JcOekWTATlBc0DheLZyLAsipKZiZ7HXpz9Z4UT+qVCfD5kTMtUDIOQGDPUXLTzw1Gc9EtXLLMLNAiB2u5QN/664tM+kMgFZ6u2fPLjadG4YgAn3bRt2KcwHol6PgnRlOeqH8HXbEwli1/zkpobuDgxjTtl9d3KdZ/PjAGaZFLzsXUMiRQbRO3/xxg+KxKflIoXdXDhMif8nqavaUbF8WlMr7GHzzksOeAg8EsYuRMaxzMELGyvyV3q5PO4EFI94R/z9r2+INzrMAhMSvWvKVVD8HGY6vax07dJz1OPsOKjQvSC5XXaXlwh7sxbVJ84Y3Dyqtz9SYAIfT8mmLXxXwNT28ZQGhNVW2EGOkXwr8QnbX5EyvX2XdmOkJM9mb/6vR9GzwqZt7DlmhUsVSnC+HQTn+hCqFAH3sxIpXT48NesUZxgA75oRlfejztTYpwFrbw2m2ZaYHD8DnBz9s1AiBKU/r1Jw0oFvVTq5fHiGloruQ/ddTe76i/mnLfmuM1KdbfSsPYbKP7sedZ5BQDx32iPzggdxPc8oJdjvvneOUt9C4heN+1BOPDaqfrTrfeGM5gfNRmqi6zdQj278VcYL5aGAw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(508600001)(122000001)(38100700002)(36756003)(5660300002)(83380400001)(316002)(6506007)(91956017)(66476007)(76116006)(86362001)(6486002)(8936002)(8676002)(66556008)(4326008)(2616005)(2906002)(110136005)(54906003)(66446008)(6512007)(64756008)(186003)(66946007)(31686004)(53546011)(71200400001)(38070700005)(7416002)(558084003)(7406005)(31696002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Wm9Rc09FeE5lSmptUWFYZ0o5RWI5RWRaRDNJaDVTTUVUYzdYK3pmWlFOYWFs?=
 =?utf-8?B?aDBCdm1OK3QvTHNTSlNrekpMR2hZVUp6MSszNmlxRE04TzR1RXQ3WDZiemJR?=
 =?utf-8?B?QmtGRWY3eEtKYWdhV3N0OWtIdVpVenJtYzVtWTVUc2dGTmliYUo0UjZSUEIx?=
 =?utf-8?B?b2hnd05SekloRjMrU1J3cXM3MHVkQ044eTlaRDMwUFN2V2xHb1Q0aXBHU0sz?=
 =?utf-8?B?QkFRWjdBa3ZPZmpyS0Z6aWcyZFNVU2pDMXJVRUw4L3A1UHNnTS9WNmZqNzJ2?=
 =?utf-8?B?U2E4Q3lsWVhjS1d2TFp4OE1kamtUUFk1alpQejFoZXBHQjA0TEZQMTBEdUtk?=
 =?utf-8?B?dUVQNW9xb01KVEE3d3hzczJyMVpOcWxnOUIwalNJOHE3dEpuRkgwcEV1dk9u?=
 =?utf-8?B?RUlhRi80OEdoYno0RGthOXNQdkxFSGVwZG0xQzVWOEtlcXVnV2hCK21Ob1FS?=
 =?utf-8?B?Y1NQYzFXRlZZZ3M2TG43OUc2Zmx5dXdFd2xsY1o1S0doMXZLcUdYV2xVK1RD?=
 =?utf-8?B?MnFoZ3lFbkpCUDN6QS9ldCtsVlgzQ2VrVVpGRnFCY1dsME9rMWFXQ0RaYm9k?=
 =?utf-8?B?ditJZlZaaWN5aDZrWTFRWGZQbmhUVEpNbWczbTI1Z2NNSXc2bWxlanRPSU0v?=
 =?utf-8?B?dVU4RWNkeVZ5dllhZzNqZDZMVXpNZkhEN004dkh1Qm9ENmNmZHcrNFVnbW52?=
 =?utf-8?B?VVRWbEExYkVoNld3ME5Kc25hUngwdDFDSEtndE81UUZ6b3NnbW9mcVR5NDRm?=
 =?utf-8?B?ejVGSGN4MDAvQXJqWGhyK2V3Q2RxQkJhdU9NdkhwSnlUb21lb3g1OXpDc0xH?=
 =?utf-8?B?Z2dDWWRGbEVGaGRSTm5IZXUyV2ZEMU9VeGltejZFOFZrWmtrSk8xRkV3bGd5?=
 =?utf-8?B?ckNmeEQraklBSEh1Y0s0RE1jU0djU3lvb0tPdXI1TkhVdU1COUFLM2VFTTlU?=
 =?utf-8?B?NEk1OU05ZmFzZ0ZkTHB3ZWRETU0zS3pNV3FQdkl3SDcrd0p6NGdmRG1vbXlB?=
 =?utf-8?B?a1ZBbnh5SlhaRGRqaUFQRUNrTFl0ZFlJUTN6N0lBWUNlQkhVTGVqd1FSRmZG?=
 =?utf-8?B?U25VczZKeko5aHFOSTZFU3VPVzBKRERwZ2hZNEkxQlFjbnYyc3A3NzlURlND?=
 =?utf-8?B?N0YyK0M4OGsvdWF0U29vWjEwZG1PYkU1NTZEY0dVUjBOUVpEbW5WcERuM1h6?=
 =?utf-8?B?bDl5WWRSM3AvME9OWHhheE9Mb1Q3MWtudllVY0dSQlRBeGxDSDYzTFlOcERU?=
 =?utf-8?B?dDA4YjJGQ1kvb21IcXVVaElSdmJiYk1DN2dLU0k2TURqU2FKSlFMczZ1T1pm?=
 =?utf-8?B?eFlPQlU3WlBQM1d5SUQwNzh4T2FrK1RLOFU5cGNiUW8wb2ZBaEUzSnZrWm1a?=
 =?utf-8?B?bThxK2x4RXp3aVQxZ0pzNjhaVnBlaGRwSWkwcm9mVnh2YmUyeDc2SHgyQWxE?=
 =?utf-8?B?R1o3TCtNOHR1NStsMVBTVTVCdVZrQklXUlIwalVoWlVtRDFPTUhEbDRaT1lV?=
 =?utf-8?B?UU1nb1hHVkhFZ1VucW1ud1UxRngrL0FiZ0RlUWJ2bHlDSnpvZ2g0bVJKclFF?=
 =?utf-8?B?Tmh3NC9CWmhab3RyczU0MFhkUDlPNUZDa0YyQTQyeHBWdFQvdUgzdEJLSGYw?=
 =?utf-8?B?alAxWklTdVpyNllXemZKTWZ1cWRBS1RNS0liN29va2pmMlppbFlvZWdDMVJL?=
 =?utf-8?B?M3dEL2RYaVBYT0ZheFRiVmxsY1NnQlJ3VSttZHVlSjJ0VDBDcHZPRHdRZmJJ?=
 =?utf-8?B?N0IxRlFPb0dkS1NqVGVrYWNxdWgvdURLeVc2MC92a3NvNU5iWEhXdm5ZeklM?=
 =?utf-8?B?TnFEZVlVYTZ0MjNKN1YzeVRPNUhyWS9xME1UVUpmTXhVVkJpQ0ZQQVlDcmYr?=
 =?utf-8?Q?lon6lLeyBTQAM?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <61F41960B16F6C40AEC03242CA4F6BBB@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 925e5792-cd56-400c-cb55-08d98e99737c
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Oct 2021 22:33:16.6695
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mPsTW6e+igrbMrCtSBOuyDdDJc4pZjDc2MHDoi2YpPa3DR287U8g7YDRmZD1A3l+TXhqsBdc8AuDAbRsnRRXzg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2379
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

T24gMTAvMTIvMjAyMSAxMDoxMCBQTSwgQ2hyaXN0b3BoIEhlbGx3aWcgd3JvdGU6DQo+IFVzZSB0
aGUgcHJvcGVyIGhlbHBlciB0byByZWFkIHRoZSBibG9jayBkZXZpY2Ugc2l6ZS4NCj4gDQo+IFNp
Z25lZC1vZmYtYnk6IENocmlzdG9waCBIZWxsd2lnIDxoY2hAbHN0LmRlPg0KPiAtLS0NCg0KTG9v
a3MgZ29vZC4NCg0KUmV2aWV3ZWQtYnk6IENoYWl0YW55YSBLdWxrYXJuaSA8a2NoQG52aWRpYS5j
b20+DQo=

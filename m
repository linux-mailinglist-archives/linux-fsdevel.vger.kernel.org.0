Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A77B430FEA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Oct 2021 07:49:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230166AbhJRFvg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 18 Oct 2021 01:51:36 -0400
Received: from mail-bn1nam07on2057.outbound.protection.outlook.com ([40.107.212.57]:24999
        "EHLO NAM02-BN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230077AbhJRFvE (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 18 Oct 2021 01:51:04 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JhQpKnXV2mayqrjQSMTdDHiB4rmRv4Kl9rcZdcFDHg7MGVrDxlvu3/aOaMMJqPJv1Owf8hfMHp5yWYyFEjqN/dsnF27KA80kVUfVWHYKD+ka2rNxLWNVx0LAbsavpucknQGR2rjFlIqg6MoV8BodfxCCvM3Ie6O8S0lp91dwNZfshhGU4p6H2LVXD+mFHOJXKdMwj/ReXuOOPA7/6JoeGyLhBIrmzb2juIIGE2YpuyA72RbYRlmxAaRCVu5Q/msnebchsARs8otKQd3r0wOlURnPcukQ9lCMQliZZenRy1vt8izDPIAHDP1gAUwsTgPx0J5+8psBIVvCJUwYq7rpLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wUyTQ3VIv/3lTbE5TBzTeeZRTvN23XnlnIEuP/sUWvw=;
 b=Iu9JwDMLwFkTgfihLxGmmDvuzGvGZGqHOCPUDlVEYqedtrWlyje8eozgryeO6Urq9NJR++aYYir2xup0oHc0bVbtK//CQo3jEnUdPfFjBM2gAREcb5tSMT8AN5/LfFiJm5VR6C5vTRRPZJV7npiDJgPMPvOeWfmoOwaoe1EvENGu2OLAHtnhrJk7J0kc0Bua3rXyoOkh9hehbRFW47tz1gkJxG7e+CZUlJuyybChPXXKZMUzyWyS8VHIak4818gYOCibSTGQv/wvvsVP89YxB4FNThr8OZFi7ynNOaPPzaecrvpofCxB/zqbwMB5h/Lc51q+YZCs57e79ofNhm9PWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wUyTQ3VIv/3lTbE5TBzTeeZRTvN23XnlnIEuP/sUWvw=;
 b=mSNzowhUt565oO36dGskDEWnj46LesjzTOLmY8U46lTVCbpm4h9p2LKnhjcN5wkseKua9MsMw4pOGUGWC8jA3v8kwE2VLN0mNuhokACVw/NhumCh35226wUSASkk8mYGkRYGmUfvSOCb6d1JRoKhmltYHW8W+5bj4cIEjQsBUxcs49tflrgf7iYee48oBGB/+dTmu8E05iGXNnuH9oJ1DVldJ/Phd1B3zI5SIRi1DgJ3hZAG+pFkEg7GHtM9KFKXfHyO+0+ctd+HXWVm+9o14IROCRmMtdkqsOQR+nrIN4vjfKIP/SBhuxuOfDKYsKUqCsuZXQTfIoDB/coHIaoWvA==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by MWHPR12MB1885.namprd12.prod.outlook.com (2603:10b6:300:114::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.15; Mon, 18 Oct
 2021 05:48:50 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::3db1:105d:2524:524]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::3db1:105d:2524:524%7]) with mapi id 15.20.4608.018; Mon, 18 Oct 2021
 05:48:50 +0000
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
        "reiserfs-devel@vger.kernel.org" <reiserfs-devel@vger.kernel.org>,
        Jan Kara <jack@suse.cz>
Subject: Re: [PATCH 26/30] ext4: use sb_bdev_nr_blocks
Thread-Topic: [PATCH 26/30] ext4: use sb_bdev_nr_blocks
Thread-Index: AQHXwcj4vQTXKLQZv0aVSDKRGKA1zavYRBQA
Date:   Mon, 18 Oct 2021 05:48:50 +0000
Message-ID: <1e40ed5d-e21f-b435-a4e5-fddceb1aec98@nvidia.com>
References: <20211015132643.1621913-1-hch@lst.de>
 <20211015132643.1621913-27-hch@lst.de>
In-Reply-To: <20211015132643.1621913-27-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
authentication-results: lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 830464a0-4a07-4339-ffb0-08d991faf609
x-ms-traffictypediagnostic: MWHPR12MB1885:
x-microsoft-antispam-prvs: <MWHPR12MB188504F8BBFE3FFFFEE55443A3BC9@MWHPR12MB1885.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:185;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wHBpUaTTgaDGnI//U15jsw62OzVazRfv67vDtAnAW7TI98WywSXkMnlSyNqY0gGDtfcNovT0jUgN0B4eZXLjW8lxQuuy8UuTr6oiMw62M1mci+VtopwBUVLJYeBAurbmoxquKBMs3E0hpRb6E64+4hdpFno/l4oV+swaHruvw0QQsnbz46rmNF88A1XtdfPSHL7M5g5ILhSfzUBriURkG0WsrlFy00YjsbP/P3oOciWu4jbw+URUjZZtOR1VIt9g2PyFFPTzph+BkMNb/3AC2KIdptxO5T4PnbhByqIlKMUmJPalyxEN5yXzG5VS+URLVFsl60WtlvUIhIjAQ7x5mo4cRI2xrsx9V8MlrR49L6B+UMLlm3Njh+NEQwHMvl3jKTssf00uP64VkBJUCfnkF3aNMlF8dbuILlShn7CKWwsHcs8VYLdRUoyQ82YldF79xI/Ole8AAG0NZ3DiVCEYKYTFA0lqqY4iRgZ9tqURUej53AMAzaJlyWru2+ziW2E/uKumtOycn90o7Y4hR+q2UuhyD9MNdzXpYvmP81unuU4Ix0k36fTq1rJvghbaIayrLItMAqUcmVKlijO0CoQDn6z8bgNjJmVU4bUA0MlH6s1FIUTP38+BDGbLHRKFPHoTBtgq6NOt1Rh6fXiakKQ72W1PfpjwJSMCKn1Qq6c+u/1HqQIQXDYm2UZCK7QebonT81eBdWdOPBGkrj3oQ70cfI1A2T4gnM6U5y1knz5v7x8HovegWVXjUAslA/O/Q2lBsod4rSVmJ/PGhAFwLn1OMw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(4326008)(8676002)(36756003)(8936002)(26005)(508600001)(2616005)(53546011)(5660300002)(38100700002)(66446008)(66556008)(31696002)(7406005)(91956017)(38070700005)(54906003)(186003)(558084003)(76116006)(64756008)(66476007)(316002)(66946007)(6512007)(83380400001)(7416002)(110136005)(71200400001)(86362001)(6506007)(6486002)(2906002)(31686004)(122000001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eTIvaUhtK2l5RU54bmFiYXF1Rm95Q09PSXU4NTVna3lGdllISm5YL0w5b28z?=
 =?utf-8?B?MU5XbVBZQXM1Uk1QNXFMNEtUU2dZbGR5UmFvdVJGZHNCdEc4ZWdhSnZrZXVz?=
 =?utf-8?B?djVobjZweXZvaDUwK3RJVHl4RERmekJqUnRVM0E5R0xFSFpXOGtaa1BWaU9Q?=
 =?utf-8?B?ekQ4OGhFMnBEUHhoN1ZMTG1uaFd5RHRqbnhMb2pOUnVhQVEyMTBTbEd3R21L?=
 =?utf-8?B?aUhyK1hCQTE2UDZTVkVyVVZJOThOek9zTEkwZmQ1Y1B5OWhhTW04SHVndzZT?=
 =?utf-8?B?MHo1dHhoYWFJZnJwVWlCVzlsL3UvTTg4cWM3Vm1DK09sKy9IL1ZJOStlbUlD?=
 =?utf-8?B?ZGV1N0dLbGVLWklSSTIwNTI3UlNNTnZHS0lRaW1SZHdkNkZvN1NwSGZBT01l?=
 =?utf-8?B?aWplZzUrRnh5SVk0VWwreE1mdjQ5VDlGWUJPZ1lRZTU2RGxNRzUxMVRVd3A5?=
 =?utf-8?B?K2JndlNGdk5rNVBRemcrVjZuZGpkYUE3emJvNXhJczdXWkV1d3ZoYjNhY3Y0?=
 =?utf-8?B?N3JkQnlUT3NjSnh2c21MRjMwNFV3QThydk1CUklvd3hYb0x6U1BDVE5RZk5Q?=
 =?utf-8?B?cGU2L1V4ckJoS2xJK1ZJa3IyeG1DYVRYVHY0cWEySTRKaUFiOVY3K2Ziai9r?=
 =?utf-8?B?c3ZXTDhWY2E5WmJtYmxTZjhqN1JzVE9hOTBaV0J1b0IvekF2OHpVMkVoSkFv?=
 =?utf-8?B?M2laN2EvMmlxOXZjMHpVWU96SjBsUFdmZ3k3d09mWTl1aFFud1oycVlJUk15?=
 =?utf-8?B?dy9UZUI0d2ZsdStEaXZIWGZYSzlFL05BOTVFbTVENkxMS3ZTQU1jUWwvRVM1?=
 =?utf-8?B?aW5hdGhOTS9CT0swY05hUENiQVFpNEgwZElHQU1RNGs4U1ROejloNERlWjUy?=
 =?utf-8?B?THMyeSt2U0NJM1ZDV2JGc2tsSlFmS21hRUcvSUxRSzB6cTVWM3VkRmFUWi9q?=
 =?utf-8?B?d2FHUmR0dDloQ3VVUDBTdXh3RnhJUnl3YzF4TmtYb0UxNHBKQ3NSNEtDbmtG?=
 =?utf-8?B?STRyZW40aEFOR2VOSFpoaUVNaElYMDd0dzBLcEk0SDgwZ3RNcUlzdTlBaDVV?=
 =?utf-8?B?NEN0U0p1MmZ4aG92WTJGbm5VVHVEVkFxYXRuNHV5Q2tYeHVSNVRMN1V4OTBB?=
 =?utf-8?B?N2FLc2FnVGFHOThtZFdxbzJIRGptd0dqQk1oY29BbTMvek1yNjB5aUVXbGpH?=
 =?utf-8?B?cDNKTmc3MnpBa3VXM1NvaXB0WnRjdWZxVjFpRnRGcVBWV0puVWswc1hrK29v?=
 =?utf-8?B?aHNTczB1ZEZoR25TSWdKb2VaMjlISHk4L2VMTm5NN1haOVFMNG5nUWQ3MmhD?=
 =?utf-8?B?U2tzQXVvSW9YRFFTUGRYRFk4LzRScW1PZHlMbm5hZVltNis5RzBSeGpRZkwv?=
 =?utf-8?B?cVNnL0d4V1NSdFd4T2x5SjNvaVhGaTMzRUlKN1BpNnhVNkw4SkhzRG1MZ0RC?=
 =?utf-8?B?OTZOY1ZrOWdHV3dHVnloekFldWRnL1dkTkpnSWlFUlJYazJrTnFrYzJwSG01?=
 =?utf-8?B?K0U0bGxYbkFkYmVUd29na21IL0FuSlR5d2cvZXVtY2IvODJqbURuSUo2VVpD?=
 =?utf-8?B?Z0dWVWgyaWNaeE0zZGdaeW1kWDN1dXJocUNOM3hKTE9FUVNDWDJmM2FMeGtw?=
 =?utf-8?B?bWp2OWxjVDNZenI3YUNONklVY1VtZUd1LzEydmtKL0lydDZsRG1EdGliT0d3?=
 =?utf-8?B?cGZ4cUlnbE1MeE14WDh1MFVZbWVrQzBMa1hwczFqQ1V1SmVjbWxxNnlvN0h0?=
 =?utf-8?Q?x0tECZJqXb6mIjw0VY=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <BCC697D6D15CC447B9C6C8675F0B9C0F@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 830464a0-4a07-4339-ffb0-08d991faf609
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Oct 2021 05:48:50.4178
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3ClwBmgBzELKOYexH6VUAXdCzEBfe721/+WVotWwdFYaGb7C9dOLjtZBp1EZ00uK9511RKwMa9+wRrnjunEdWg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1885
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

T24gMTAvMTUvMjEgMDY6MjYsIENocmlzdG9waCBIZWxsd2lnIHdyb3RlOg0KPiBVc2UgdGhlIHNi
X2JkZXZfbnJfYmxvY2tzIGhlbHBlciBpbnN0ZWFkIG9mIG9wZW4gY29kaW5nIGl0Lg0KPiANCj4g
U2lnbmVkLW9mZi1ieTogQ2hyaXN0b3BoIEhlbGx3aWcgPGhjaEBsc3QuZGU+DQo+IFJldmlld2Vk
LWJ5OiBLZWVzIENvb2sgPGtlZXNjb29rQGNocm9taXVtLm9yZz4NCj4gUmV2aWV3ZWQtYnk6IEph
biBLYXJhIDxqYWNrQHN1c2UuY3o+DQo+IEFja2VkLWJ5OiBUaGVvZG9yZSBUcydvIDx0eXRzb0Bt
aXQuZWR1Pg0KPg0KDQpMb29rcyBnb29kLg0KDQpSZXZpZXdlZC1ieTogQ2hhaXRhbnlhIEt1bGth
cm5pIDxrY2hAbnZpZGlhLmNvbT4NCg0KDQo=

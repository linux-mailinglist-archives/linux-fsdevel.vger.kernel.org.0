Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09E24431061
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Oct 2021 08:22:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230203AbhJRGYn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 18 Oct 2021 02:24:43 -0400
Received: from mail-co1nam11on2077.outbound.protection.outlook.com ([40.107.220.77]:7009
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229533AbhJRGYm (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 18 Oct 2021 02:24:42 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EmjrAHZT8yLovb7iN9KqDFsr2VW/QA2tc86XdwfZSEwmyo/23D1dXMjfJiaQpJ48rI4MJcoNDe6sElNvHPDWXu6hCioworqnICCH+0+pexsV7T5F9XoEcjSwSy27Xy+j1YXizYtl/CQ/3RegFqoFoXE/ndZZXYj0WiM+Q24hT8WyrrOtxsLZdfi70ClCgmwdkp2Mkg6vZ+ULIlWME66eRnkG8w/DtcuAH4DxOlLZS957v6CSCFaaG5KmiPweSklziXntJ/kM/mQqc0R0JWiRpuIkr525nZvTPEcG98aogIRS219xg+6TwW0i1QJ/CNQQXB0TU8Qzkb79Yyc9tF6RvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CkKpSR1al2VUo6bot/ISgx0uzk3S61wFAi4ja6KZrqQ=;
 b=CS4euHTQzBErzp/C8YLiNqYQI5d01QIf8nAcEit+AE2kzbRmVvz4u9PLpdubpZ1EuZYhh4/lhrmw/zwgt+TM8KwEjFtPaSM3c1RDcpSvaZlfU8pWb2L8GmgpPO8X0WxYbu0sVqJn0IuSWCMuCAFVfUG+OcPqUHA7TmSgM1tYJU3XOkOg77hp2ySw9pWZgJRcn0mcD9rJH2bTNDTZ9CZ2Le4rIgWG7bFS8brClRnmxaMv2yj4RofALqwfsZvGTN0BGiTlrtMtQkmiCx3py0qr8kvBsSq8Q827NwF/CPei969qxW46wvHrVpFJ7iCiCKZV6ON0jpeesBWdyKrtEbtlGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CkKpSR1al2VUo6bot/ISgx0uzk3S61wFAi4ja6KZrqQ=;
 b=dpa1tMZQ9fZx0+VFd0OtjNnzxqJkTGEeMLAs6FNB09l8Fj6c4idPEUZ7FnaJ+LDfVnoKgE2qp22h1Sn6LFfEbRMlXZuPoEDJzOQZns3nLnvvhT0Jk2LPOlBn+9e9h4PCfMMSWEINo7DiLpDYuTUrQsRNw/S1pdB4rMZIUNNSXB636LB/1nLJoHbESBMpzVL0M7R0dD4FwXEn0dJzaiA6Wy4ieo+fLFOTao8J1jPVD7oy6x2BAARs/j3pgfTKjNRIWgbgq79ZpF/UxWWTCeecyq2ppbEIkYl4ARMMbGzySbmFiN8hvY1pEc8quqj6eW+aWAAs4bXdbkbuwo+/KJXNsg==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by MWHPR12MB1469.namprd12.prod.outlook.com (2603:10b6:301:10::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.16; Mon, 18 Oct
 2021 06:22:30 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::3db1:105d:2524:524]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::3db1:105d:2524:524%7]) with mapi id 15.20.4608.018; Mon, 18 Oct 2021
 06:22:30 +0000
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
Subject: Re: [PATCH 22/30] reiserfs: use bdev_nr_bytes instead of open coding
 it
Thread-Topic: [PATCH 22/30] reiserfs: use bdev_nr_bytes instead of open coding
 it
Thread-Index: AQHXwcjMa97lH3N4IEKZw8BSKviaGqvYTXuA
Date:   Mon, 18 Oct 2021 06:22:30 +0000
Message-ID: <16eaa7bd-3f47-47ef-2cbe-ae7f50779e56@nvidia.com>
References: <20211015132643.1621913-1-hch@lst.de>
 <20211015132643.1621913-23-hch@lst.de>
In-Reply-To: <20211015132643.1621913-23-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
authentication-results: lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3beae86a-d8c4-4803-fe1b-08d991ffa9f3
x-ms-traffictypediagnostic: MWHPR12MB1469:
x-microsoft-antispam-prvs: <MWHPR12MB146922E43E8231B7FF4A2736A3BC9@MWHPR12MB1469.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:240;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Bm1xQodi9Wo6O1N8SoouA/AGi10l+Q4QcMio+B8L93PSW9NM03hCE+iYzbfWN1D6kFeO9dk56lBsss+J9QXSyYKZkob9/B5JUX3L27VD3ltXr4YUX1VPz62oJxjF83WqzKZrhS57cU1MBlsNFesor0VeAi69wLZYbwRL0j9/bRmoAHikPsoN39xomjz5+oYbjT1pcxlbTDdN3kPHcHISJdeiV9mRlBDKJlNfnZzfThpwRJSZkGiAJjhIfEKPg9JaysIjY/E2JSDdcMvQw9XLuyksI9UpbLY1bnqdubrmg3JoHBp5tFXqGTGrshtQTcOhaE6uYoMdxFGARspxvy2bWUDZ68GGVkkLnOqsXOOP9+6bd9urEb2czTn0MfNlKMCjKa+PQJ95dNgXRJIpEYioHvM6NV8ZKA+M9IFI+a2ehMjOYRxMoQdrMwEhVo2QMJ1NA5T5yvQM0TUdFtcuermPWOuhIBSjs5yYTqwjvf5Nosu9rA2XYY/4CNsecUxtoJ8u8x0mTBtysabHe4RGFhc/lI6o9zd6xwfqXBx4khcQDVEyt4T0mfUDl6lTGFKN4bjgiDBSYGUKJ+mBT4azKtu5to+oGNIJKmATC2pjjop1nBuCJC0M3AeDtw0S2uvrT6aJzS3aMOvCVMbBNxtwmpXgEjQvLRV+LfCMQv4v8gBH7vW5ENPg7zXl3/NaDfqC0shuGspvyz+/zTFIs7Zc3zxiZRqOciFBozIc9qAZEwSCZke7jvcjYGh+wdBD7+j24gWjwZfJN29IWrXLWeAQD1Dntw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(71200400001)(5660300002)(4326008)(8676002)(508600001)(122000001)(8936002)(558084003)(53546011)(2906002)(7416002)(6506007)(6486002)(6512007)(54906003)(38100700002)(31686004)(7406005)(31696002)(36756003)(83380400001)(316002)(110136005)(86362001)(66946007)(66556008)(66476007)(2616005)(64756008)(76116006)(38070700005)(91956017)(26005)(186003)(66446008)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SWFKOHl1Z2cyaWdjK0FkWUtBN21raHRKUkFCcjAvVEhTVWtPOUVoUDBqWFNB?=
 =?utf-8?B?dmlGZE1tcnFuMW5qRVR1SmJCSDE3Uit1N2d0TG05WHBOMnU5Q1FTQy9YTWZw?=
 =?utf-8?B?QkNLeno2QzVKUVdRWDdSOXRpb3Z3dFlFbVYvZllma3NETUw1UGZUZWRLSFY3?=
 =?utf-8?B?SSsxYXBvbDE2c1UxeG9ocnQ5Qm5TSzQ2ek5wQnlEMHdNU25LL2h4bVBwUjRU?=
 =?utf-8?B?L0tmaDZ6dDZDZk9yVThwLzcybjMrc3ZtOXYzNkErUXUwbVBrYlBrZjlZWDJk?=
 =?utf-8?B?Q2t4Z3ZaUm04ckRwRGg5T0lkSDI0Y2RyUi9pRi9Qd0luQnA1dm9hWXJ1RWlL?=
 =?utf-8?B?anpraEtjUmpQTm10d1ZxU1ZKbWdFVk5xMm5DTFNtOHBvR2Y3cWRLOWFudWJR?=
 =?utf-8?B?bTROWE4yamVmWUczTy9wdTFDZUJoV1VmL1daTFMrR1B0bjllUHNqVGFucS9H?=
 =?utf-8?B?MTF6dUFTMUI1Vzl2eXZXcHF0UVVpaVdaQy90ZDBMSzVJMERLSjhNWXR4bDA3?=
 =?utf-8?B?UCtBZ0JqanozLzVDUmNFc24yNnZ1a3FRUy9XaS9JeEZKL050OUVLSmFrQXNk?=
 =?utf-8?B?ZHB2b3hNeWoxRHV4anBubFNrcDhrN2xQSWRENzdtVEc4NThuOUEzZTk4ZkZX?=
 =?utf-8?B?M0NpdVlyUkhTSW94bFJWeFlEa3hmV29yOThwTFR6cVgvc1VSSG9ZRWhEc0Zm?=
 =?utf-8?B?Mk1Nb1lQbnNqWk5EdHMydEFzckk5dVk1bEpXM004YkRacFFaN2JERDdOOE0v?=
 =?utf-8?B?SmlreTJiUVZ5dXF4ZENvVU92UmhXTEM2dkVsSDVIV0VHT2hMYTU1bXcxUHRh?=
 =?utf-8?B?UUt2UkowTDZLWjdCQi96SnR1Ynd3UW1oSWl3dG5lQ09LMTRGS2RPS0xJaFB5?=
 =?utf-8?B?bk4rR0U0OVA5enhQR2xXRUhFaGZ2N3hSMy9sMFhPUDVLUnVJLzVVNG5Ma2dz?=
 =?utf-8?B?UitUb3NSZ3RzM2dRRTJ2VktMSE54YTFtc1E4Q1NaVUFhMjZycE16Mlk4RnV5?=
 =?utf-8?B?alN3dytqMEpPSS9KTzRWcFE1Q2N4c3ZHQUMxNVV1bzRsc0dCVmRpZHZ2a0ta?=
 =?utf-8?B?VjRSVEw4RTZpb2ZDTmpRNy9oTEk3Tk5ZcDBlMlgyZDltaHd6blg0eFdaZUpv?=
 =?utf-8?B?ZG9ibnVsUldDenBNVU9hN2pZV2FzUEJBbGx6ak5Zak9KSm5yeHp2WWp0UERF?=
 =?utf-8?B?SFRON1BmZzlDUyt1ZVJ3dWtzZjlpQzhYa2NhUUx5ZEpTTzJsbWRFSS8wdlRE?=
 =?utf-8?B?emRkT1hpRWNSUkdlUkZsZUlmdjN5RVFPRFVONno3bnVJaFFCWWg0b1J2TUwx?=
 =?utf-8?B?TFlEQTFOT3M4cmRQb0l6VkRHeUhGWVNYSmFpVXQvZXUrYUFqYnNiRTg0Z0ha?=
 =?utf-8?B?MWhPbmN6ZFJPSkZiQW5HYlBlTDB0VVM0RDZuL0p3MzNNTllHcTh6OXI4THcx?=
 =?utf-8?B?ZXFxMjh5VGxnVjBNczVtOW1VeHZRbFRJdUU0UGFPbUtYWFVzOGZyZWtlRUVL?=
 =?utf-8?B?MUlpZlI2T2orUmw5TGUzejY1dXRBVmxrbUVEYlhVcHYrT2pVRHBraklNVm93?=
 =?utf-8?B?ZWhVRURoa0UyazYwMnJGTHNRZTVkcnR6Y2pBejlzbm5zeHQ4bGRYOUZIZU0x?=
 =?utf-8?B?OVc1OWpva25ha1E4TzFpRDVkWS9obW1zeEFzQnBBclJwUlg0SmNaSjNNWEd0?=
 =?utf-8?B?cHdNYlRPK1FkQVJZVSsyT01LNmVvNThsSi9xaVNKbkJ4Qy9RNDgrMWR2dGVR?=
 =?utf-8?Q?Js80tRzfIxjbLNqCAk=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <1D52234084563549BE0202AC74D36824@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3beae86a-d8c4-4803-fe1b-08d991ffa9f3
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Oct 2021 06:22:30.2664
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9DYXg1xgl5Dh05S6iVACmdhqBMmZpyS4LAv7vzEY/lC6u9I1ny6yBCvI5G7y7upEjuQJMKRy7a+NWd4tMKv/4w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1469
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

T24gMTAvMTUvMjEgMDY6MjYsIENocmlzdG9waCBIZWxsd2lnIHdyb3RlOg0KPiBVc2UgdGhlIHBy
b3BlciBoZWxwZXIgdG8gcmVhZCB0aGUgYmxvY2sgZGV2aWNlIHNpemUgYW5kIHJlbW92ZSB0d28N
Cj4gY2FyZ28gY3VsdGVkIGNoZWNrcyB0aGF0IGNhbid0IGJlIGZhbHNlLg0KPiANCj4gU2lnbmVk
LW9mZi1ieTogQ2hyaXN0b3BoIEhlbGx3aWcgPGhjaEBsc3QuZGU+DQo+IFJldmlld2VkLWJ5OiBK
YW4gS2FyYSA8amFja0BzdXNlLmN6Pg0KDQpMb29rcyBnb29kLg0KDQpSZXZpZXdlZC1ieTogQ2hh
aXRhbnlhIEt1bGthcm5pIDxrY2hAbnZpZGlhLmNvbT4NCg0KDQo=

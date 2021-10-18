Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FA7C430FDD
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Oct 2021 07:48:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230104AbhJRFux (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 18 Oct 2021 01:50:53 -0400
Received: from mail-bn1nam07on2087.outbound.protection.outlook.com ([40.107.212.87]:54926
        "EHLO NAM02-BN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230077AbhJRFud (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 18 Oct 2021 01:50:33 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N3DWYOB7owvNoPKu8JxjeYo4WDW+TS61sxyxgDZUQJycZf+pkx3oOwuOmDKPeZkCFTatJ17BtJc/aH+Rxr7Jbg6TsToJEkg+Gb/Xb/zJW+RvP/naK4ATLO4zShAIiXQF96SE4Xi7GirNQKnCZ2+XByDi0fYPHBHac4EtCVmyHfsQw7T33xhjNgDkTCS9SUDZylAiu2zhuMVDu/Wa+1JV9rlrQ204b5Tw9/yUn8NF6PkmosXq/OrxDAA2/VZsia4qArPc/WtTvtgzi2Smh+fTsG9nyohSlsgmVU4CQ/LbRRsqfrqbruorrrLh6XS3X16Jbcqrg9bFcvSaZX14iotJYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KoTdo9YmkAjQuMhlsR5rPkyIMnhuRGEF00hqwgXnEBQ=;
 b=f9IN4vMb7D1Bq1bMeflq7MHCUIPJ2aK0obX+BXIJufhTlbF5VpIYzhWlctrYiwkG1SLtKTZ0aIon/4b1xKUyLnG5/ZyzKgRKFlX1DjTx1r9yGKUed41TYH8l6L88cj7Ap7KdulXo8hzZQXKGF+pFdETiOSpdxm1qDth9aifQIQMT37Dr6tZSUwMYdmKcL+XblvdgRDDjc06Z9MBv0q7Mvisojz3rvQhmXN9Pb7VvrapWBL8hIHLboyYeyq22Obp3qabT92ATmLKHovdabCPexhWYP9sxjtfbsugPAM+QyRGRnDMkanDajOiYZr66LcPzEJHYp0HpJqdmVnYBw1x+iA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KoTdo9YmkAjQuMhlsR5rPkyIMnhuRGEF00hqwgXnEBQ=;
 b=hoaoUNKEqX5CPSf7/ier5U8E+/d6KMKgK90jiWg07SyhFUKeiNCwBKUbNls/A0evw43Dngj5kLoW83S+mcdHDyrYey9cWEyM+JL/oBBVZHfU3rXsgK8VOAqh0wx/GDMnlfAjsh3wfeH/JwmpKqVDEcmLWIN7+nrYrILtv4NFoAMzyA+2MiIrbfKXKlgVaByB+AMCZVRpUOG8FaYAS6if3IXZvNgnMW8bKedtz7UlgeTpaLLAMw2P145S709qbYE1lcsqPOIC30KzbmKACz/W1xI2mOKRT+PISyhxZlALvYjJwaESaGx7waO0/2IFLyQRwInupuDv0P95JpS765xD8Q==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by MWHPR12MB1885.namprd12.prod.outlook.com (2603:10b6:300:114::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.15; Mon, 18 Oct
 2021 05:48:14 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::3db1:105d:2524:524]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::3db1:105d:2524:524%7]) with mapi id 15.20.4608.018; Mon, 18 Oct 2021
 05:48:14 +0000
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
Subject: Re: [PATCH 25/30] block: add a sb_bdev_nr_blocks helper
Thread-Topic: [PATCH 25/30] block: add a sb_bdev_nr_blocks helper
Thread-Index: AQHXwcjkKdwm0t7mp0iS/ZytkYe2sKvYQ+kA
Date:   Mon, 18 Oct 2021 05:48:14 +0000
Message-ID: <04beef49-8269-3120-517a-111357ecd2db@nvidia.com>
References: <20211015132643.1621913-1-hch@lst.de>
 <20211015132643.1621913-26-hch@lst.de>
In-Reply-To: <20211015132643.1621913-26-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
authentication-results: lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5bbed4ee-d0a9-4f39-591c-08d991fae0d9
x-ms-traffictypediagnostic: MWHPR12MB1885:
x-microsoft-antispam-prvs: <MWHPR12MB1885B9BBADDA4839CF6512AFA3BC9@MWHPR12MB1885.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:883;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hSe2I+m7J6c8A6D6F3+e5roOGz4eMa4Un+ORKKNoe+CH6CmMQZDIk2ZYHSnb2qNA7lm4qTjMmpRZzy+cBB/zOVzkPY3SSwpjOIIuTU1chI2f2btt4SjfcAXL7/ItBpfoX5aMNyoleKBk7D7RIlAf6xKEkrKI5iiKgqXXDaEEsX0uKXZSdATdMUEiM6lQmvDLToMCvdzx4FTnhlBsMaNq0lMAclPI1DgyPudNs8StJlNBvv2qoBEGASV8PUc4HTdO2HYImXj5jg1dYa/AygP+w+tMFoJ0+pGMjjVxDqhknPs00Py11uJGZw6CWIpA4uV/+R37Imxb/mxlCcB9sCmddrxV+LjvES3O71kjmrmbboG3GOFyZRMKQF4S7FB2xzXb2Jru0X9kzxhFAwLM8j6lJVWnxEVMmdZtkUCDyo1MOavNREqow+TUQjx5F0bMGrC5HaFSyKl23kfXEHF2rXr+wT9TZR898BgHJvc8XKtpGk69oEzJgK0BxE5hYI+pOihJ1vFc+glie8tDJi8Bn+wzH6J8XG/8/eIWykBZm8+fiM4LA7jSdYCPo/0oJovRSVQxYhF94gzZZBvXrs6MG+BMgWoZtXGdZyg/C0wEBliLxzt1aFQfLHhgPhWDuBkyEkehCALX57T5tG2ufm8k+wkbdL4PL12vbjzMieyIK4fEY+B66yPo+J1DSxrHtWUqkToE4fd6Mo2WhRvlg/tOC+dlE/29KnaITXo4YLHEhzDkPZW1cGVVUWqC4LMltBWrxMgxJshcAd5Leaas74B+VWbyNw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(4326008)(8676002)(36756003)(8936002)(26005)(4744005)(508600001)(2616005)(53546011)(5660300002)(38100700002)(66446008)(66556008)(31696002)(7406005)(91956017)(38070700005)(54906003)(186003)(76116006)(64756008)(66476007)(316002)(66946007)(6512007)(83380400001)(7416002)(110136005)(71200400001)(86362001)(6506007)(6486002)(2906002)(31686004)(122000001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UFBTcTdJb1lwclZrb3ZHMHJ6N0d0VGdRSlhseEdMeXNNOWRkVWtNaWcyd1c0?=
 =?utf-8?B?MjRObWxVaHJBdVhJN0lRSUcra1ZnK2gxUkYxVFhlK2FBYVJWYk9vS0VMQjl6?=
 =?utf-8?B?NlI3dEQrdlRqVVZjRnZpSFJRa3VSMkdnM0RtU09aakpoTjFWcmJIUDVQTzR6?=
 =?utf-8?B?UmN5ZDJ3TUt0bW0wc2UxbkFNZlVDQVZpMUhQeUY5VDdod2dFaEttMjBWeVF3?=
 =?utf-8?B?aTZ5K3cwZ3l0b2RON1gwQmRpcFl0M1V1YVcwMytXckRpMFFLc09leFZiZmF4?=
 =?utf-8?B?V1BMbE1XT0h5ODlkOWJ5NXFlNDhOQzFVRE1JQVc1VHBrNzFkQlBYM0JXdzhm?=
 =?utf-8?B?SitaeDFNWWVjS0V1NVlpQXdMckJEekhSMkorNTJLeE1xSHpab1FtTnZLTzRo?=
 =?utf-8?B?ZnFOQ3B3ajRGSFYyVTNYd090L2NYRkhaRnc0Ynp5QzBPc2pwMGJCWE9YVHlv?=
 =?utf-8?B?TUpJdmEwMlZzNGY2NTJRTXBBUExpVjlsK0YycUk0QjlXTlNiR1UxVlhnckpy?=
 =?utf-8?B?WFpzV2l2b2ZGRDBLa3ZuSmJoTWtsSEx3dWNuMzc5Y3lUaGN6Ym1ENlE0dWJH?=
 =?utf-8?B?cnZaL0tpbllsSTZtQi9HQUtNMWFkeFJUaFdaSmpMVUMvL25tTTFISGpCa3Q1?=
 =?utf-8?B?alhIN2xscmt6RWJrYnozcHNXQmh2dlp4VlRtZHJpU0Vnd3JjeFZwY21mRjNa?=
 =?utf-8?B?RTk2Rm0zNXMrdUY4NC83MytUY01OdUxFaXVGbjdWRldRTzdod0xKSkw2aUNB?=
 =?utf-8?B?RXJ0NU9TMi9nZzhVMHZNYnJOd1RWZU00MTc5SGZSRGw1WjEwcWJZVUkvSkYr?=
 =?utf-8?B?TG9sTTA4ckY0QWMwSzd0dmk2cmJOT2V2czZUVFlnOE4wV0JwTDMwZlc5UGdp?=
 =?utf-8?B?aE4zMW16clRqRUxaR1NuMHU2L2RzaU1Wc1BKMm9xcXk1V085bC9Vb0RvWFQ0?=
 =?utf-8?B?OVA5bWw0SGhlRkplaDFHU3U1azhORlVZQUJzWERVUys4c1ljWDErdmxVRUQw?=
 =?utf-8?B?NWtZeCtwKytpVVM0WkM4ZnNTZHhBQ3RqSVdaaXdXUERpamIzT3gxWlM3ZTZl?=
 =?utf-8?B?VGdPUEdlLzFhOVpIR1hzWVJUbFd6RUp3RnpSUEYrWWhxZ1NuTmpxVmp2cGpj?=
 =?utf-8?B?M3lxWG1JME9RTEZaekc0aGRDZmgraXduV1Ayb3lqNXhWVDJRUml6UVhnZUZm?=
 =?utf-8?B?dWVVRlFrOVVMaVVsQUo2V2xzSnRZZ2hqcU8xUFZwSjVoNCtYWnZVSkdqOVNB?=
 =?utf-8?B?eEFkVEVOMHhJWmNtTjgvMVBpV2F2YnpMeFhwVEVPVExaZS9pYzd1emliUFFK?=
 =?utf-8?B?bzR3ZHg3T3E0OUNra25PbGsrWkI0ZXhKQVpEdU9td25ocFVVNlgxY1Jmb1I4?=
 =?utf-8?B?UVpraUtmZjIzTzlHd3hseGZSck04MlltdUZYT2NCRU5lYlJlamhtRlBmMGRX?=
 =?utf-8?B?ZitSWlRUTHVxU3BsT3B2Z1lENlhJeHBMM085Ukkxc3JZRFJReEh0SmxvRE5H?=
 =?utf-8?B?aHhmNjNzYXMxWllqOFczTHhka1Y5OUUya1JVWXZMWXZ2Q3NPNDJ1UmVkYVFU?=
 =?utf-8?B?R0FQdUhFeW05cFc3TW9DT29NdmtQeGtEbUJRSG9lZWk4ZVZ2YlVCMktsZThX?=
 =?utf-8?B?cDhBYUNtWk5FK3RHRFhoaUJBeDEyM0ozQnVyaWltaTBBUE53UXZjalppWkVi?=
 =?utf-8?B?SDNJcFFUUXM1clpGMWNKRmljY2U4ak9TcGJUajBqK1ROYXJzWmRwTjhSdDM1?=
 =?utf-8?Q?4yUf7BXWuRRztrJ7+8=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <E92FCF7DB99A724CBD69B890C7E02284@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5bbed4ee-d0a9-4f39-591c-08d991fae0d9
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Oct 2021 05:48:14.8688
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lGZyDBf7iL41ojT9aO49rUs19j516JBvfEkX6eJAlHp0O2vCw1t0Lr/q1uiKTUjHoQl80y0EG5z+FPC9owhPsA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1885
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

T24gMTAvMTUvMjEgMDY6MjYsIENocmlzdG9waCBIZWxsd2lnIHdyb3RlOg0KPiBBZGQgYSBoZWxw
ZXIgdG8gcmV0dXJuIHRoZSBzaXplIG9mIHNiLT5zX2JkZXYgaW4gc2ItPnNfYmxvY2tzaXplX2Jp
dHMNCj4gYmFzZWQgdW5pdGVzLiAgTm90ZSB0aGF0IFNFQ1RPUl9TSElGVCBoYXMgdG8gYmUgb3Bl
biBjb2RlZCBkdWUgdG8NCj4gaW5jbHVkZSBkZXBlbmRlbmN5IGlzc3VlcyBmb3Igbm93LCBidXQg
SSBoYXZlIGEgcGxhbiB0byBzb3J0IHRoYXQgb3V0DQo+IGV2ZW50dWFsbHkuDQo+IA0KPiBTaWdu
ZWQtb2ZmLWJ5OiBDaHJpc3RvcGggSGVsbHdpZyA8aGNoQGxzdC5kZT4NCg0KTG9va3MgZ29vZC4N
Cg0KUmV2aWV3ZWQtYnk6IENoaWF0YW55YSBLdWxrYXJuaSA8a2NoQG52aWRpYS5jb20+DQoNCg0K

Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FC1449DB43
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Jan 2022 08:14:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237149AbiA0HOS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 Jan 2022 02:14:18 -0500
Received: from mail-co1nam11on2079.outbound.protection.outlook.com ([40.107.220.79]:38146
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231869AbiA0HOP (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 Jan 2022 02:14:15 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T1CSe8I7FLFtQp616YasdW/3lrHg3OkTNMuZiloVFrLt9zcd0/7m5mbI34MaRFfEYFFOCZBlfEpefrNHLCoclGBzDmiSM/t6GrsNQM32H1AWC4qd98Qd5GLfooCqxF3ZS3bTeIv/IcafiuTfpSKSeqcwas2dIrUjPlHTz6BOVFTomd1mIT+6dL/j6i/TTGY2g2mxnaGf/8T/Gvid+KLElpNJ2Z688H73X2XjQbxHKxKT670XMhRZtrjym4LR0oVrtU1mscqKz/rXsLYuOFe2aey+6b2jQRuViBcafld9m3SekdJKWRay2lJRY9FAdYPcgDiApgQPKNFYf+57gmR7QA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9uHzQN1g9IusML2rVFY4zshCwM0cqQIUcR+SvXgbN2U=;
 b=a8ewCOb3rxMLyKJqh621cSik0bIECzTA4vuHEtdngkBcR8Ee0MCecIvpedecHVP8w+oyklIVYEpGO/s4aeb8rFu5/UXb9YPloWc5wF1/MguhNL5jk350eLO/XGIR01U7VvGeWbo8Q3XB9jIjgmhRlvVe3MflxrEiBHptx2nkNglH4rVquouWCYAflzJVoyizhVuLgR6UsGTFcGWwtTEE+7er+anHVR7yUQMwlTvzhlbdly6Wgbq31XIB+pH+AvCDZrIkyWXb2cFcCepZtFj32g6QtNYAH7Z3TCBQuQuJoxUaEinc7Khqp4l+Ewf1PKvgWiOm0IPI5u1di4gKxtVvhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9uHzQN1g9IusML2rVFY4zshCwM0cqQIUcR+SvXgbN2U=;
 b=EnwjKYJLhapus6s9tAfuSxcFC22ubs8vvXdhIqN+LnVB5kAO9EZ4Cu8RyRCkj1Z1W+8fmVMjd08NTERW1TP+ZRKJSaKJ5uYO8JvSjRWSj2heeIe7l4BasRqZ4rNM6IC0/R0obFYQs7+9oiE54iMmJGF04WA0vMG/AHcfVH1N58y2nZy8gMsxrI44F2wYpMio1M73PcRg8dhH3YDL8rkJSzSPwmtTud+LmkQ47QeaUDA3bhTRBvZver5CLYmkOvZBVdBH3TjdI7J8iRtPSwXl46t44m1D560tAs0cDejjJMtm8wjxcSFvHA+htIV1OMGBCvR+oTveFC46JnReT6O6KA==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by CH2PR12MB3816.namprd12.prod.outlook.com (2603:10b6:610:2f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.15; Thu, 27 Jan
 2022 07:14:13 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::846c:d3cd:5a30:c35]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::846c:d3cd:5a30:c35%4]) with mapi id 15.20.4930.017; Thu, 27 Jan 2022
 07:14:13 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        "msnitzer@redhat.com >> msnitzer@redhat.com" <msnitzer@redhat.com>,
        Bart Van Assche <bvanassche@acm.org>,
        "martin.petersen@oracle.com >> Martin K. Petersen" 
        <martin.petersen@oracle.com>,
        "roland@purestorage.com" <roland@purestorage.com>,
        "mpatocka@redhat.com" <mpatocka@redhat.com>,
        Hannes Reinecke <hare@suse.de>,
        "kbus >> Keith Busch" <kbusch@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        "Frederick.Knight@netapp.com" <Frederick.Knight@netapp.com>,
        "zach.brown@ni.com" <zach.brown@ni.com>,
        "osandov@fb.com" <osandov@fb.com>,
        "lsf-pc@lists.linux-foundation.org" 
        <lsf-pc@lists.linux-foundation.org>,
        "djwong@kernel.org" <djwong@kernel.org>,
        "josef@toxicpanda.com" <josef@toxicpanda.com>,
        "clm@fb.com" <clm@fb.com>, "dsterba@suse.com" <dsterba@suse.com>,
        "tytso@mit.edu" <tytso@mit.edu>, "jack@suse.com" <jack@suse.com>
Subject: [LSF/MM/BFP ATTEND] [LSF/MM/BFP TOPIC] Storage: Copy Offload
Thread-Topic: [LSF/MM/BFP ATTEND] [LSF/MM/BFP TOPIC] Storage: Copy Offload
Thread-Index: AQHYE018isCsN3oz40OdcqzMcXhV7g==
Date:   Thu, 27 Jan 2022 07:14:13 +0000
Message-ID: <f0e19ae4-b37a-e9a3-2be7-a5afb334a5c3@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9d7bc4e4-3f75-4bf1-0634-08d9e1649f5a
x-ms-traffictypediagnostic: CH2PR12MB3816:EE_
x-microsoft-antispam-prvs: <CH2PR12MB381600AEBA8037D8A7D632ADA3219@CH2PR12MB3816.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: noNWJHzeQXlQO1kuwhzYwy/j2m6wD+d/AZttjAJKqYy4TyXuaDk3uBEf6wbAx7kXZ1aBciJ24YW0gYLCfwYEzHckn+nf/LzAUZlYTfB6lTAi5Gss58AM4v5KCVOegHIcZvJhHUaCiJTe3uI4Ly53JxtOPBwvhYD9DHquYFe8A3QgSu4zIlcBgKNYtg7mwJKaLsU71eVRM/x7EP2QJgOBvNxDjtael40ydWCbMsTqYH2wkCMQXwYYA5McRsbBOXhlNgXtIUFVL9T+ko1Or8HSuOHa5P8CqsaO/iMmeCfRpuzAyNlOJtuod3xX23bWl7NpmA6NWqMbhWWnoUy4VtgNMhMc03y9tngH2OKjcg5QNhkYnqA6l4Kyp2hzVfePpOKqCxR924gaYXqioSfshehHIF+4czz/q25UeOSsUjOhsuUnL+GLANpFqAWyfrQfMlGgpAIsm+zJ0NBSakS+M52YASR5PMisRxhbiDoWci9CWFIIXdfLSKYZdf3j/XlYMeRSXe57fF3sNPD8f9UjeGxR1TEDbynjGm+6A5MaSKangBeFuQ8uyHlZePFg6X2A16AsBM1iZwZpqSC0sz2oU7sGsI5YZLbqL7KLqziUoS5wKOMRZevXvK2SqsQH7yOTVlHQR50FPpMfc9cNj5OdUIj362fBHrUg3XoD7YSuAHZ8mYRlTJIr7oUSDx47sR/AW+EyAYwg4eRL5brLwVSy0c0994H1UmF4pOtjpgWHHRAn31L6BQbXKLNSbqZ3uZ7HosyIgdfBpvQ7pSBWnj0forJ2iQhFD9JblDhPIj2sEuvUJAILRosez2iFP4FxBeiSbZoFw6tl0HzALjiFaxlMTiUmoI8ahKUq2+kzogJYtenf8fWprpepUH/wND2fjYHsCdOFeC6gNuibLP/hpN0wFnQYNDEXiQQtTvr76bo/sLYFeU8h65fnDthx8Wcp/KgCYVgv
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6512007)(6506007)(2906002)(31686004)(7416002)(5660300002)(36756003)(2616005)(921005)(122000001)(186003)(66946007)(38100700002)(110136005)(38070700005)(83380400001)(6486002)(86362001)(966005)(91956017)(508600001)(8676002)(316002)(71200400001)(8936002)(31696002)(64756008)(66446008)(66476007)(66556008)(76116006)(43740500002)(15398625002)(45980500001)(20210929001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bVFkUzg1S1B6QUVDNG0xS1RSVkpQcVFZbmJVVlpBTFNjdlFSenJFQzM0WnNz?=
 =?utf-8?B?T0I0Y1hQWjFFWGo5blJyV3FscktOL3RHTzdpUlpyY2xXN1l3SDFFMWRCM0xC?=
 =?utf-8?B?WVNQYXpvZ0NuTDZtVEVUT2ZWQVhFSE12WjQ1OWMrZmE1VlpJTmRYU21KY2s4?=
 =?utf-8?B?bGRwTmRQTWlZUmRBS0pWUXpvTVRXd0NMekVFeE5adEYyVDJ6TUhodytjM0p0?=
 =?utf-8?B?Q2sxOGV2cVEwY1NaemtwendwT0hFYkI1SUdqRXdMNmJtSm1MUWZ0ZG5USDNZ?=
 =?utf-8?B?eEJaOVp3SHhSYk9Odno1T1IxZUJKSUFTTnZTdjlLeVhydU1aRkdBY3dMNHV4?=
 =?utf-8?B?bFFCa0UxNFUxaXYvc2wrNm1HcE51RkxxWVFZcUJ2L01yOHZXUWlSYnFuTmRC?=
 =?utf-8?B?MjF5cXp4WUJtalVhaUhlMHFRWXJQUHpJQ3AvSTBFOVNXdU9FTy9xNGo4MFB2?=
 =?utf-8?B?OVlVNFFZcmVYVmsvSXYzZlpyN1k3SDZSaWxieUwyY0g1bG1OSXdlSmpuQ1Bn?=
 =?utf-8?B?OW5zY2RObmE2ZjhHYkZlOWg0dG5BMmJ5bk1VWnMxN05raTRvdEUzdXZKYmsx?=
 =?utf-8?B?Ymlhdk9HZEJhTEUrUTlKTmk2aWtlbW5GL2pXaHE4T2JYN2JXWUpTZjRqaFZX?=
 =?utf-8?B?NHp4Y2d3MzNmbWNjMUoxWjEvRmRUdnFBa1FqMXVZN1NLUFpiTUhWSGwzZWY3?=
 =?utf-8?B?VyszMVV6ZTBHNGtMNEVmenNKUENPemF1UEM5LzNNL0xnWUFhb0VXRzB4anZD?=
 =?utf-8?B?ekROWng5SlBBL0Zwb3RYMHBGSUVGYitxWG5vMGwzU1E0SlNRVkc2SGFTRk9a?=
 =?utf-8?B?MkZJZHF3bXpmMjNhVFN4MzZoTnNzMitVZnNZRnZ3dEFqZUhUQzVmUGpaTWtH?=
 =?utf-8?B?ZXV0eUJ3L3FYUmdsUmtPSTc4U1NkZEFCd0FmYjdTWHlnc3hmSFA1ZG9PVTVF?=
 =?utf-8?B?SUtkL1ZhNjBUVFlITk94bGdYYkZ5Z3p5cTVIUVZEQjRZQWFKYVo5MHVGSGZY?=
 =?utf-8?B?dHp1R2lwNG1LajFIV2RmM1NLL3Q0K0g2Vk9vNlJ6Zlh1YWFoaDZFMWkxTnJ4?=
 =?utf-8?B?V2JPaE5LQlhWMlpDcFJYNjU3Rm9ETVgwUTVicmpZNFZ4dHNseEROaEZyZnJ6?=
 =?utf-8?B?RHYrbjFiekpjeWxTc001QXMzbXpXWm1lQzlxUVRlUVVYNUY5UVJaNFlqbmg2?=
 =?utf-8?B?SXBaczJ4dDZ6aWoyUDUxbExhSFZKemxCZnJxaW1WNjNFSmFZY0ttZDg5WG1j?=
 =?utf-8?B?bVRCKzhFTjd0cHN6WDlaakd0Wi95UGE5Szk5RG43SllsZlhyb01QREVxS3oy?=
 =?utf-8?B?SWpXbHdSem9tV0c2cXR5b1JXSFZnUlFTeGI4NlVvTVlTOXg3V3VkdjdLdUpq?=
 =?utf-8?B?NHFZLzJwWGpvTUhud2MrM003RitaclZjS3VqNzJhaytrWEk1QWpIMkk4bVNY?=
 =?utf-8?B?OE4wMWNpRWF2UGQydlJpQ1E0Z3VKb3hUYW1TRDcwdVB4d0xIck0xc2s3emVD?=
 =?utf-8?B?d1NzQTdSVXVqQTFCb3MvbzMrcDZzTzdzcHJ1dHAyYk1zSEpzdXhCVEpJcGVP?=
 =?utf-8?B?dE9qaG5wRTF0a0RUV0xVOXVFbys1ZHVXeXRpeFI2bTg2d3ZLbFA5Umx2L3hk?=
 =?utf-8?B?S0R5a250cGYrUkFUdHFsMFJSNG5iWXd0YmR5cDhnSEd0ajZDK3V0d2lGd2Rj?=
 =?utf-8?B?cTJhMHFDdDN2QjdkMDg5bm94OE1wNnk0Q0FBdkFvdG5mK3UxaDZmNzFoUGR3?=
 =?utf-8?B?N2djN3FBTzhzZFlzWDJYejdhQk1iblBkRUl6UVpCZWNUVUlEY2ZyOTFEdXB6?=
 =?utf-8?B?bG5sWTRFeHBuOU9EUXdySndFa1I0bXBLdWptTHp6TWg1NS9zaGRTdDE3SlB1?=
 =?utf-8?B?eXMvNmd4VHlYWEJTRmRNcnczRCszUWs1OTlQZW1Ub3M2a1dralppR3dOMHor?=
 =?utf-8?B?bzkrM0lQeFNVcHBsM2FpWDJQMHZwcHBLS2UrcFNsbyszY1l1MzFTTW9oNGlt?=
 =?utf-8?B?UnBqSFJQWHJHN0Z6azRlb2ZvYmtYTllZb0o0V3V0QkFXWnFmaGcyK1k0b3F1?=
 =?utf-8?B?RGdLeU5RcExPemF4T0hrNGcxeFJoWkdLNXh2QUs1RzBCS0RSRFdRZHVobEpF?=
 =?utf-8?B?bndiZ0hSWTU0SmxPcHlLMTZyNzdHQS9ETCtSMXJRYmgwaXhkVkJFd1h6WTU5?=
 =?utf-8?Q?IROfx1/yoiJgAJTFoZGtT/mVZW8rAEg2FYWqPW+u4WYx?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <74E88CD88EF25E4D9F57B2B1BC44850B@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d7bc4e4-3f75-4bf1-0634-08d9e1649f5a
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jan 2022 07:14:13.4998
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KFnbeIkKicSKhOA6spbIyCcQB64ZcsA0uC8lIx/4DjUP0wfEN9C1e0XtTRzTrqNlm1SoyHhSoq1Svy5rkbKsMA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3816
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

SGksDQoNCiogQmFja2dyb3VuZCA6LQ0KLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCg0KQ29weSBvZmZsb2FkIGlz
IGEgZmVhdHVyZSB0aGF0IGFsbG93cyBmaWxlLXN5c3RlbXMgb3Igc3RvcmFnZSBkZXZpY2VzDQp0
byBiZSBpbnN0cnVjdGVkIHRvIGNvcHkgZmlsZXMvbG9naWNhbCBibG9ja3Mgd2l0aG91dCByZXF1
aXJpbmcNCmludm9sdmVtZW50IG9mIHRoZSBsb2NhbCBDUFUuDQoNCldpdGggcmVmZXJlbmNlIHRv
IHRoZSBSSVNDLVYgc3VtbWl0IGtleW5vdGUgWzFdIHNpbmdsZSB0aHJlYWRlZA0KcGVyZm9ybWFu
Y2UgaXMgbGltaXRpbmcgZHVlIHRvIERlbmFyZCBzY2FsaW5nIGFuZCBtdWx0aS10aHJlYWRlZA0K
cGVyZm9ybWFuY2UgaXMgc2xvd2luZyBkb3duIGR1ZSBNb29yZSdzIGxhdyBsaW1pdGF0aW9ucy4g
V2l0aCB0aGUgcmlzZQ0Kb2YgU05JQSBDb21wdXRhdGlvbiBUZWNobmljYWwgU3RvcmFnZSBXb3Jr
aW5nIEdyb3VwIChUV0cpIFsyXSwNCm9mZmxvYWRpbmcgY29tcHV0YXRpb25zIHRvIHRoZSBkZXZp
Y2Ugb3Igb3ZlciB0aGUgZmFicmljcyBpcyBiZWNvbWluZw0KcG9wdWxhciBhcyB0aGVyZSBhcmUg
c2V2ZXJhbCBzb2x1dGlvbnMgYXZhaWxhYmxlIFsyXS4gT25lIG9mIHRoZSBjb21tb24NCm9wZXJh
dGlvbiB3aGljaCBpcyBwb3B1bGFyIGluIHRoZSBrZXJuZWwgYW5kIGlzIG5vdCBtZXJnZWQgeWV0
IGlzIENvcHkNCm9mZmxvYWQgb3ZlciB0aGUgZmFicmljcyBvciBvbiB0byB0aGUgZGV2aWNlLg0K
DQoqIFByb2JsZW0gOi0NCi0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQoNClRoZSBvcmlnaW5hbCB3b3JrIHdoaWNo
IGlzIGRvbmUgYnkgTWFydGluIGlzIHByZXNlbnQgaGVyZSBbM10uIFRoZQ0KbGF0ZXN0IHdvcmsg
d2hpY2ggaXMgcG9zdGVkIGJ5IE1pa3VsYXMgWzRdIGlzIG5vdCBtZXJnZWQgeWV0LiBUaGVzZSB0
d28NCmFwcHJvYWNoZXMgYXJlIHRvdGFsbHkgZGlmZmVyZW50IGZyb20gZWFjaCBvdGhlci4gU2V2
ZXJhbCBzdG9yYWdlDQp2ZW5kb3JzIGRpc2NvdXJhZ2UgbWl4aW5nIGNvcHkgb2ZmbG9hZCByZXF1
ZXN0cyB3aXRoIHJlZ3VsYXIgUkVBRC9XUklURQ0KSS9PLiBBbHNvLCB0aGUgZmFjdCB0aGF0IHRo
ZSBvcGVyYXRpb24gZmFpbHMgaWYgYSBjb3B5IHJlcXVlc3QgZXZlcg0KbmVlZHMgdG8gYmUgc3Bs
aXQgYXMgaXQgdHJhdmVyc2VzIHRoZSBzdGFjayBpdCBoYXMgdGhlIHVuZm9ydHVuYXRlDQpzaWRl
LWVmZmVjdCBvZiBwcmV2ZW50aW5nIGNvcHkgb2ZmbG9hZCBmcm9tIHdvcmtpbmcgaW4gcHJldHR5
IG11Y2gNCmV2ZXJ5IGNvbW1vbiBkZXBsb3ltZW50IGNvbmZpZ3VyYXRpb24gb3V0IHRoZXJlLg0K
DQoqIEN1cnJlbnQgc3RhdGUgb2YgdGhlIHdvcmsgOi0NCi0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQoNCldpdGgg
WzNdIGJlaW5nIGhhcmQgdG8gaGFuZGxlIGFyYml0cmFyeSBETS9NRCBzdGFja2luZyB3aXRob3V0
DQpzcGxpdHRpbmcgdGhlIGNvbW1hbmQgaW4gdHdvLCBvbmUgZm9yIGNvcHlpbmcgSU4gYW5kIG9u
ZSBmb3IgY29weWluZw0KT1VULiBXaGljaCBpcyB0aGVuIGRlbW9uc3RyYXRlZCBieSB0aGUgWzRd
IHdoeSBbM10gaXQgaXMgbm90IGEgc3VpdGFibGUNCmNhbmRpZGF0ZS4gQWxzbywgd2l0aCBbNF0g
dGhlcmUgaXMgYW4gdW5yZXNvbHZlZCBwcm9ibGVtIHdpdGggdGhlDQp0d28tY29tbWFuZCBhcHBy
b2FjaCBhYm91dCBob3cgdG8gaGFuZGxlIGNoYW5nZXMgdG8gdGhlIERNIGxheW91dA0KYmV0d2Vl
biBhbiBJTiBhbmQgT1VUIG9wZXJhdGlvbnMuDQoNCldlIGhhdmUgY29uZHVjdGVkIGEgY2FsbCB3
aXRoIGludGVyZXN0ZWQgcGVvcGxlIGxhdGUgbGFzdCB5ZWFyIHNpbmNlIA0KbGFjayBvZiBMU0ZN
TU0gYW5kIHdlIHdvdWxkIGxpa2UgdG8gc2hhcmUgdGhlIGRldGFpbHMgd2l0aCBicm9hZGVyDQpj
b21tdW5pdHkgbWVtYmVycy4NCg0KKiBXaHkgTGludXggS2VybmVsIFN0b3JhZ2UgU3lzdGVtIG5l
ZWRzIENvcHkgT2ZmbG9hZCBzdXBwb3J0IG5vdyA/DQotLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KDQpXaXRoIHRo
ZSByaXNlIG9mIHRoZSBTTklBIENvbXB1dGF0aW9uYWwgU3RvcmFnZSBUV0cgYW5kIHNvbHV0aW9u
cyBbMl0sDQpleGlzdGluZyBTQ1NJIFhDb3B5IHN1cHBvcnQgaW4gdGhlIHByb3RvY29sLCByZWNl
bnQgYWR2YW5jZW1lbnQgaW4gdGhlDQpMaW51eCBLZXJuZWwgRmlsZSBTeXN0ZW0gZm9yIFpvbmVk
IGRldmljZXMgKFpvbmVmcyBbNV0pLCBQZWVyIHRvIFBlZXINCkRNQSBzdXBwb3J0IGluIHRoZSBM
aW51eCBLZXJuZWwgbWFpbmx5IGZvciBOVk1lIGRldmljZXMgWzddIGFuZA0KZXZlbnR1YWxseSBO
Vk1lIERldmljZXMgYW5kIHN1YnN5c3RlbSAoTlZNZSBQQ0llL05WTWVPRikgd2lsbCBiZW5lZml0
DQpmcm9tIENvcHkgb2ZmbG9hZCBvcGVyYXRpb24uDQoNCldpdGggdGhpcyBiYWNrZ3JvdW5kIHdl
IGhhdmUgc2lnbmlmaWNhbnQgbnVtYmVyIG9mIHVzZS1jYXNlcyB3aGljaCBhcmUNCnN0cm9uZyBj
YW5kaWRhdGVzIHdhaXRpbmcgZm9yIG91dHN0YW5kaW5nIExpbnV4IEtlcm5lbCBCbG9jayBMYXll
ciBDb3B5DQpPZmZsb2FkIHN1cHBvcnQsIHNvIHRoYXQgTGludXggS2VybmVsIFN0b3JhZ2Ugc3Vi
c3lzdGVtIGNhbiB0byBhZGRyZXNzDQpwcmV2aW91c2x5IG1lbnRpb25lZCBwcm9ibGVtcyBbMV0g
YW5kIGFsbG93IGVmZmljaWVudCBvZmZsb2FkaW5nIG9mIHRoZQ0KZGF0YSByZWxhdGVkIG9wZXJh
dGlvbnMuIChTdWNoIGFzIG1vdmUvY29weSBldGMuKQ0KDQpGb3IgcmVmZXJlbmNlIGZvbGxvd2lu
ZyBpcyB0aGUgbGlzdCBvZiB0aGUgdXNlLWNhc2VzL2NhbmRpZGF0ZXMgd2FpdGluZw0KZm9yIENv
cHkgT2ZmbG9hZCBzdXBwb3J0IDotDQoNCjEuIFNDU0ktYXR0YWNoZWQgc3RvcmFnZSBhcnJheXMu
DQoyLiBTdGFja2luZyBkcml2ZXJzIHN1cHBvcnRpbmcgWENvcHkgRE0vTUQuDQozLiBDb21wdXRh
dGlvbmFsIFN0b3JhZ2Ugc29sdXRpb25zLg0KNy4gRmlsZSBzeXN0ZW1zIDotIExvY2FsLCBORlMg
YW5kIFpvbmVmcy4NCjQuIEJsb2NrIGRldmljZXMgOi0gRGlzdHJpYnV0ZWQsIGxvY2FsLCBhbmQg
Wm9uZWQgZGV2aWNlcy4NCjUuIFBlZXIgdG8gUGVlciBETUEgc3VwcG9ydCBzb2x1dGlvbnMuDQo2
LiBQb3RlbnRpYWxseSBOVk1lIHN1YnN5c3RlbSBib3RoIE5WTWUgUENJZSBhbmQgTlZNZU9GLg0K
DQoqIFdoYXQgd2Ugd2lsbCBkaXNjdXNzIGluIHRoZSBwcm9wb3NlZCBzZXNzaW9uID8NCi0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tDQoNCkknZCBsaWtlIHRvIHByb3Bvc2UgYSBzZXNzaW9uIHRvIGdvIG92ZXIgdGhp
cyB0b3BpYyB0byB1bmRlcnN0YW5kIDotDQoNCjEuIFdoYXQgYXJlIHRoZSBibG9ja2VycyBmb3Ig
Q29weSBPZmZsb2FkIGltcGxlbWVudGF0aW9uID8NCjIuIERpc2N1c3Npb24gYWJvdXQgaGF2aW5n
IGEgZmlsZSBzeXN0ZW0gaW50ZXJmYWNlLg0KMy4gRGlzY3Vzc2lvbiBhYm91dCBoYXZpbmcgcmln
aHQgc3lzdGVtIGNhbGwgZm9yIHVzZXItc3BhY2UuDQo0LiBXaGF0IGlzIHRoZSByaWdodCB3YXkg
dG8gbW92ZSB0aGlzIHdvcmsgZm9yd2FyZCA/DQo1LiBIb3cgY2FuIHdlIGhlbHAgdG8gY29udHJp
YnV0ZSBhbmQgbW92ZSB0aGlzIHdvcmsgZm9yd2FyZCA/DQoNCiogUmVxdWlyZWQgUGFydGljaXBh
bnRzIDotDQotLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KDQpJJ2QgbGlrZSB0byBpbnZpdGUgZmlsZSBzeXN0ZW0s
IGJsb2NrIGxheWVyLCBhbmQgZGV2aWNlIGRyaXZlcnMNCmRldmVsb3BlcnMgdG86LQ0KDQoxLiBT
aGFyZSB0aGVpciBvcGluaW9uIG9uIHRoZSB0b3BpYy4NCjIuIFNoYXJlIHRoZWlyIGV4cGVyaWVu
Y2UgYW5kIGFueSBvdGhlciBpc3N1ZXMgd2l0aCBbNF0uDQozLiBVbmNvdmVyIGFkZGl0aW9uYWwg
ZGV0YWlscyB0aGF0IGFyZSBtaXNzaW5nIGZyb20gdGhpcyBwcm9wb3NhbC4NCg0KUmVxdWlyZWQg
YXR0ZW5kZWVzIDotDQoNCk1hcnRpbiBLLiBQZXRlcnNlbg0KSmVucyBBeGJvZQ0KQ2hyaXN0b3Bo
IEhlbGx3aWcNCkJhcnQgVmFuIEFzc2NoZQ0KWmFjaCBCcm93bg0KUm9sYW5kIERyZWllcg0KUmlj
IFdoZWVsZXINClRyb25kIE15a2xlYnVzdA0KTWlrZSBTbml0emVyDQpLZWl0aCBCdXNjaA0KU2Fn
aSBHcmltYmVyZw0KSGFubmVzIFJlaW5lY2tlDQpGcmVkZXJpY2sgS25pZ2h0DQpNaWt1bGFzIFBh
dG9ja2ENCktlaXRoIEJ1c2NoDQoNCi1jaw0KDQpbMV1odHRwczovL2NvbnRlbnQucmlzY3Yub3Jn
L3dwLWNvbnRlbnQvdXBsb2Fkcy8yMDE4LzEyL0EtTmV3LUdvbGRlbi1BZ2UtZm9yLUNvbXB1dGVy
LUFyY2hpdGVjdHVyZS1IaXN0b3J5LUNoYWxsZW5nZXMtYW5kLU9wcG9ydHVuaXRpZXMtRGF2aWQt
UGF0dGVyc29uLS5wZGYNClsyXSBodHRwczovL3d3dy5zbmlhLm9yZy9jb21wdXRhdGlvbmFsDQpo
dHRwczovL3d3dy5uYXBhdGVjaC5jb20vc3VwcG9ydC9yZXNvdXJjZXMvc29sdXRpb24tZGVzY3Jp
cHRpb25zL25hcGF0ZWNoLXNtYXJ0bmljLXNvbHV0aW9uLWZvci1oYXJkd2FyZS1vZmZsb2FkLw0K
ICAgICAgIGh0dHBzOi8vd3d3LmVpZGV0aWNvbS5jb20vcHJvZHVjdHMuaHRtbA0KaHR0cHM6Ly93
d3cueGlsaW54LmNvbS9hcHBsaWNhdGlvbnMvZGF0YS1jZW50ZXIvY29tcHV0YXRpb25hbC1zdG9y
YWdlLmh0bWwNClszXSBnaXQ6Ly9naXQua2VybmVsLm9yZy9wdWIvc2NtL2xpbnV4L2tlcm5lbC9n
aXQvbWtwL2xpbnV4LmdpdCB4Y29weQ0KWzRdIGh0dHBzOi8vd3d3LnNwaW5pY3MubmV0L2xpc3Rz
L2xpbnV4LWJsb2NrL21zZzAwNTk5Lmh0bWwNCls1XSBodHRwczovL2x3bi5uZXQvQXJ0aWNsZXMv
NzkzNTg1Lw0KWzZdIGh0dHBzOi8vbnZtZXhwcmVzcy5vcmcvbmV3LW52bWV0bS1zcGVjaWZpY2F0
aW9uLWRlZmluZXMtem9uZWQtDQpuYW1lc3BhY2VzLXpucy1hcy1nby10by1pbmR1c3RyeS10ZWNo
bm9sb2d5Lw0KWzddIGh0dHBzOi8vZ2l0aHViLmNvbS9zYmF0ZXMxMzAyNzIvbGludXgtcDJwbWVt
DQpbOF0gaHR0cHM6Ly9rZXJuZWwuZGsvaW9fdXJpbmcucGRmDQo=

Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40CED4A9292
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Feb 2022 04:05:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356614AbiBDDFh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 3 Feb 2022 22:05:37 -0500
Received: from mail-bn8nam12on2053.outbound.protection.outlook.com ([40.107.237.53]:58167
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1344936AbiBDDFd (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 3 Feb 2022 22:05:33 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ExILB9g83P/unKWqfkojYouIV7PxmhT3SADkn/BjFZEzeExzNQ4L+Ci7rK2wo6t554NMFdT5Ld9ZW36B488YgTy9ZeQPvHCsTPeOsmQAVNkVMcVpD1943o2iUAGB/CTE14TI99XDGK0dlqX00Eyt63GLVJosHR+ZqzJltfYDMZaXuEcNVeFg7f1j81FNkRjAKCleI200on7Wq0drr8pFFdimdLl34fovB9ee8+7QizEk4Lmpjpm+lJ9Yw7VPLq7mow8r0dCF/ETNjRsuMzdmj3HcNw5uGabXES1jQs0ey9PrsLgbp71IWrsWOBFAFy8/qaj85VtiwhDxyNtpiMO+qA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c2DBWkl1d7LW6mGG0YuO+gtofSaIM9jvZiZJHTwzEE4=;
 b=DdxQ2R+2wp8AOaOV1X9g36QGJdv5ZmsRAS4ZyaRVI14PWM4Au1K2f++BtnMzFR5e4XonqkbAEBH9Z2/EjwLrJ4Wp5gUqoJJ47y93v+OX9lmLZHbqv/Iwg6MHngnRefVfRXMu6Tn5c02NNvI6LH0tQWlSeW5/ePqmf4L6F+QZwdj7a+skC8UEWh7QGjtETQFghcxtTnbx8TP0F5tI75QOlAKWdkIZ+3GFHcGhDyVcWbCto9cZi3V9T6iNpZvHkyG7cGHsN+4yENHwoRYVVkj7/nRZvYK2oHRFWF1BRThwn0MQcEmdo7/X4iaQjCIb9LKfnZdUddfYbUQi3Kn3esRvwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c2DBWkl1d7LW6mGG0YuO+gtofSaIM9jvZiZJHTwzEE4=;
 b=sskJug6HK/FsvpkSU2uTPtG2iaOg9esXOu/EGdpwC7GZoHs3v3mkEuTbKeJ/uzjbbQqkV5D0FPuUs+8VVByBdQMrNXbx6L/O5qn/XKffqqkNGvAmAvvUuVmSJqzcyvilV4h+GUjTBMO5ZWE5pNU57S0LXYMgCuWvrfNEIaQwtq4OWCGykHa5KeJM/DUpAJGEglE10rq0FjgAYBkylPBnPIAUjkSESh6+JPVZpYYz134m68jyZjm71XibnQKTnyrBO4G3O97FDN3CuyhFXUttXxDXPCvPTlELk2aBeLxPTzUdLQ1KjQrPnqqhYHUk47tKjZ/AxPPDMNdAqk/o1+wFbQ==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by MN2PR12MB4423.namprd12.prod.outlook.com (2603:10b6:208:24f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12; Fri, 4 Feb
 2022 03:05:30 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::846c:d3cd:5a30:c35]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::846c:d3cd:5a30:c35%5]) with mapi id 15.20.4951.014; Fri, 4 Feb 2022
 03:05:30 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Luis Chamberlain <mcgrof@kernel.org>,
        Adam Manzanares <a.manzanares@samsung.com>
CC:     Mikulas Patocka <mpatocka@redhat.com>,
        =?utf-8?B?SmF2aWVyIEdvbnrDoWxleg==?= <javier@javigon.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
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
        Hannes Reinecke <hare@suse.de>,
        "kbus @imap.gmail.com>> Keith Busch" <kbusch@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        "Frederick.Knight@netapp.com" <Frederick.Knight@netapp.com>,
        "zach.brown@ni.com" <zach.brown@ni.com>,
        "osandov@fb.com" <osandov@fb.com>,
        "lsf-pc@lists.linux-foundation.org" 
        <lsf-pc@lists.linux-foundation.org>,
        "djwong@kernel.org" <djwong@kernel.org>,
        "josef@toxicpanda.com" <josef@toxicpanda.com>,
        "clm@fb.com" <clm@fb.com>, "dsterba@suse.com" <dsterba@suse.com>,
        "tytso@mit.edu" <tytso@mit.edu>, "jack@suse.com" <jack@suse.com>,
        Kanchan Joshi <joshi.k@samsung.com>
Subject: Re: [RFC PATCH 3/3] nvme: add the "debug" host driver
Thread-Topic: [RFC PATCH 3/3] nvme: add the "debug" host driver
Thread-Index: AQHYF5pGTuc0vK6aW0WDOYv4vbM4lKx/xVyAgAI7dYCAALgbgA==
Date:   Fri, 4 Feb 2022 03:05:30 +0000
Message-ID: <242979a2-6a4d-30fe-2aaf-911b576e2cda@nvidia.com>
References: <f0e19ae4-b37a-e9a3-2be7-a5afb334a5c3@nvidia.com>
 <20220201102122.4okwj2gipjbvuyux@mpHalley-2>
 <alpine.LRH.2.02.2202011327350.22481@file01.intranet.prod.int.rdu2.redhat.com>
 <CGME20220201183359uscas1p2d7e48dc4cafed3df60c304a06f2323cd@uscas1p2.samsung.com>
 <alpine.LRH.2.02.2202011333160.22481@file01.intranet.prod.int.rdu2.redhat.com>
 <20220202060154.GA120951@bgt-140510-bm01>
 <20220203160633.rdwovqoxlbr3nu5u@garbanzo>
In-Reply-To: <20220203160633.rdwovqoxlbr3nu5u@garbanzo>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7bb1b37d-44d6-469c-6032-08d9e78b33bf
x-ms-traffictypediagnostic: MN2PR12MB4423:EE_
x-microsoft-antispam-prvs: <MN2PR12MB4423F24D51A52898F76E2490A3299@MN2PR12MB4423.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4125;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XO1aUShBnfmy+kbnIObm6e7VEpOwWBZ1np0uJvAJtsjE0teguDRvxHgSVQMeM70djdK9Qm5TKHQETySEvlPgdCn/w9s9Mbtq88xnbwIIrk5QrLigpiRgVKoXpjjyW0o59JQASvoAyhKVD+XRPBxB/P7qh9Y4C1QIqBVJBbkEklfrSXfzEpnSua9STaXOrWSi1FxQlcHakvueiL3qAFxtoZyp62H2B9GCjC8cbJhqP/ujdTmAoK7KZJxxmn9wOIxtMChj/i+EGkR0LGuah84htvzs2HwHQe/rx7bn3r6TKX8x9StO89AfspPX7zn4BOOO/OacCAD76reOz6Epf0tRoz40msjqSBGgo3B6ANmPI1570Hf6EdrEAsVphUHfCsXOXgznIIf2TUNQw2IyzQGD7h/FuGip6H06ubzRkRN/SY0WrTSYoxFXJ09zHJR2HDtvht+jEDYDBrRwUzUOJF8CYlGHMra4HFmePUN64sM+4P5B/EFEyjzhIu92ao9bbr68GFlJLRDVB9RqHczlrty6LOd0hiQoVjfvwi3jUFfTh/5+09CK1rjENzvbuAk8gUF/q2uLVa0zv/MCzRRYZ8J2eoM3SyBsGOmDGqnrZtikSsCjWnjBL1lIq/8IxbSuD/IhmF2GzwsnTjESqOtEAC091UwenSCrhpjebMZnKZZ/H3VSABJSubQ6+PqF6GEnsqtqWModuFY2hURkOABOw+M7bxNCjJmxiPekMw69yj+2VafCJe1hZUzA0gbqgvouLbxC
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(54906003)(7416002)(110136005)(38100700002)(86362001)(122000001)(508600001)(6486002)(5660300002)(31696002)(2906002)(4744005)(38070700005)(76116006)(316002)(91956017)(66946007)(66556008)(66446008)(64756008)(8936002)(8676002)(4326008)(66476007)(186003)(2616005)(53546011)(71200400001)(6506007)(6512007)(31686004)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WXBnaGFabzNramNPaFAwYkdaSERqUDByMlUwWElEdEFzanJCWHBlRXJNTW9D?=
 =?utf-8?B?R2lDNm96NEp3d0xzVkVHYThndjJJc1lpUHF0Rm1oU1RldXFuWkRxTzBJeWx2?=
 =?utf-8?B?ZFdjUXJsbUs5SWRQWXllVE1RZm96dTVNKzFIZTdSNzJQdklWZ2VYWnRXRmhV?=
 =?utf-8?B?YXd0ZTFERTZGczFHSzEzSlVPdGJHVFQyakthK01ES0tncS9DSnlpNkNWYmtD?=
 =?utf-8?B?a1RjdjZEOEFyQnNqWVVVSGtsTGUzUXZCMSt2TWFUMzBGdVpIZk8vZmtrVm1r?=
 =?utf-8?B?ZVhyRTNXNWFMWk1NUzkvQWd0NWZNU2lURlBhbSt6UUFEdHFlT3VKTnM5TVlL?=
 =?utf-8?B?ODNCSnpmWDlqQ0lWZTUya1FBa2hlN1UrbXNvaTdxNHFkdzZQZllHZ0Y5UnJ3?=
 =?utf-8?B?RzUvWmxIQUxEYzZBQTJmNWpibldQd1hLS3lETTVka0l2dzJSNTlZd3BPQ29H?=
 =?utf-8?B?WXd1Wm1GS2JQMEduaXhtanRwY3FPczlCaGYxQUlOZ1N5YlQzZnNWSlVGeEc3?=
 =?utf-8?B?SlNsZ0JwOVVJdHoveW5ocW1NSWNISnJnbGVtdDU0SnRmT1ZnNVRjWXBuKzVl?=
 =?utf-8?B?ekNrU213Vko1UFBDbmpleHVrKzVKaCt5RjV4ekZiT2tiVkNyMmNVdkh1OUEx?=
 =?utf-8?B?OUlBZzZVemNhUDdKQkptMjBqbG1DTUVXRFFhblltRnp0OWNNV3pEQnExZy9l?=
 =?utf-8?B?a01sOFg4cFBaT2ZWUW0vcUdPb0hFMS9iMDJzamxMLzhGWU5DZGp5UTVpMzZu?=
 =?utf-8?B?RTl3RjE4dVpKZGVQY0drQlZYdjVyU0ZWRmdjN1VxTlRhR3hrSzQ5U3Q2ZTVh?=
 =?utf-8?B?a1pubUZlVDQ3SlI0TGgwRHRsSDVyWDJkTEFBeGdTNXZzYk5nU0VjRHJwdUdP?=
 =?utf-8?B?WkNzcGRqcHdlclRWTCtUVTlIUU5jWllFODZLNWRzZldDc082d2VpSEUzV3BE?=
 =?utf-8?B?bWgrdWdxVVA0Yzdqa21adlc0Vm9mYkVGM3pCbzNzUGdkWWpBK1N2c2c1Z21Y?=
 =?utf-8?B?ckxmcFlyL0dldjNHYXpmbDFnd3NHYW1vcXUvT2FIUzVzTktlTkx4RmFGWHo2?=
 =?utf-8?B?T3Y1R043UzlyWjQ2b1ZRU2Z1SThnVXlxSVo5LytCZG9acUxheFBWNHd0a1dQ?=
 =?utf-8?B?UlpUMTFabnVrMUNjN3JwSTlMbWRjUURnMUs5dllNclJqSzJnQkhBeXAzWUQx?=
 =?utf-8?B?NGtGSDlORlJmQXBJS0ltUU1nWW90NTNjTWRaY1B5bW5DWDh2U3JsRTNQcXo3?=
 =?utf-8?B?ZHcxb2MyaGUwdUVXd3FrVnJGNHFmWElXN0tidE9QaWhnQ3Bxcnd2TWJoYitw?=
 =?utf-8?B?UGlLbzkrZi8zOExPbFZCRWZVMXIxOXlOekRKSGNWa2Z6dUZwNG5mUHFOU1FC?=
 =?utf-8?B?VGJlalh0dnk3WG9EVXJDOVFZMjkwbmhVRkJaSU5rWTNSTDZNQndFRERqUTNQ?=
 =?utf-8?B?R21jcDc5YU0vVFNqZXNNN3ZaZ3FsVndDWWtGV2ZnMjlDVmQ2aGxLUUN2Uysr?=
 =?utf-8?B?OEkxZW5XV281czV0SHhjMHlyZ2FBNzRIU2lWekZSMVVybXRoNHg3VzRybk1J?=
 =?utf-8?B?OXF0WGJoUVNWdTJvR05lVXIrbVNoYzJ6KzE4dlM5RlFwQmY3YkZFUnhFcWhV?=
 =?utf-8?B?cjY3RTYwbG1COXlyR3VFMHQwQUJQOUljTzdrYmdIWTNkcE9jNk00MCtsZnZM?=
 =?utf-8?B?clF2QVgwVmZZVWtzQzZGamZ0WlEwY2lCcjFrbU9lM1hvYm1WMnM3enhqQWpV?=
 =?utf-8?B?Zlc0cUtQY3VrNHhJRVJaMTJZOFVZUDU0TXM1R1hHZGM2NUNLYytYWk5XNFNm?=
 =?utf-8?B?Ris1VlI5WHlWMnNHZnFPNk4vVm9PdXpxR0lyb3JNVHBzUW5HMHRGTk9vd2dS?=
 =?utf-8?B?eFFOS0tXc0tmOGd6MGoxQ2NQZndkVktUdVIxdURKUGdLOHVtSVZIV1lHdU5j?=
 =?utf-8?B?Q3FTTVI5WWlDUXl3c0dhUDQwdXZCekxtWHNJV1I0bkJBa3hoVU9jd2lKNkM2?=
 =?utf-8?B?bE1zSnZVeHRWQ1I2S1E2eVkvcHNDaGR0Wkg5L0s3alJKTHRqd2VpNXRpbHRJ?=
 =?utf-8?B?RUFtV09qUWFudXZNYzhIclFMb21oQ2NZeEUydnhweWVHZWpVVDZKcGhYS0Ix?=
 =?utf-8?B?TlN4WnZ4TzhINVR0WHZNLzJrYStLTG0zYkNvcy9TNmZxbjFVOFJOSG8wcmJs?=
 =?utf-8?B?UW9HUTF6aDZrRnBTcVgvSmJZUzk5UEhpVGlYeG5FUzJBYmFOYzgraUtGN1lJ?=
 =?utf-8?B?ZVVSY0lOUU9adXZ1UnJ6eUJRZ1hnPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3D9FCC340B339844A9F3FDF367AA635E@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7bb1b37d-44d6-469c-6032-08d9e78b33bf
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Feb 2022 03:05:30.3036
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WiVQJHldvECS90ngkrURvLtSLk2z5o9FjxiZa9apTNtMy8EUrNm35NbEvLDqqyDDHurznU7NqTKw5xlx/ncSFg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4423
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

T24gMi8zLzIyIDA4OjA2LCBMdWlzIENoYW1iZXJsYWluIHdyb3RlOg0KPiBPbiBXZWQsIEZlYiAw
MiwgMjAyMiBhdCAwNjowMToxM0FNICswMDAwLCBBZGFtIE1hbnphbmFyZXMgd3JvdGU6DQo+PiBC
VFcgSSB0aGluayBoYXZpbmcgdGhlIHRhcmdldCBjb2RlIGJlIGFibGUgdG8gaW1wbGVtZW50IHNp
bXBsZSBjb3B5IHdpdGhvdXQNCj4+IG1vdmluZyBkYXRhIG92ZXIgdGhlIGZhYnJpYyB3b3VsZCBi
ZSBhIGdyZWF0IHdheSBvZiBzaG93aW5nIG9mZiB0aGUgY29tbWFuZC4NCj4gDQo+IERvIHlvdSBt
ZWFuIHRoaXMgc2hvdWxkIGJlIGltcGxlbWVudGVkIGluc3RlYWQgYXMgYSBmYWJyaWNzIGJhY2tl
bmQNCj4gaW5zdGVhZCBiZWNhdXNlIGZhYnJpY3MgYWxyZWFkeSBpbnN0YW50aWF0ZXMgYW5kIGNy
ZWF0ZXMgYSB2aXJ0dWFsDQo+IG52bWUgZGV2aWNlPyBBbmQgc28gdGhpcyB3b3VsZCBtZWFuIGxl
c3MgY29kZT8NCj4gDQo+ICAgIEx1aXMNCj4gDQoNClRoaXMgc2hvdWxkIG5vdCBiZSBpbXBsZW1l
bnRlZCBvbiB0aGUgZmFicmljcyBiYWNrZW5kIGF0IGFsbCBvciBldmVuDQppbiBudm1lLWxvb3Au
IFVzZSBRRU1VIGZvciB0ZXN0aW5nIG1lbW9yeSBiYWNrZWQgZmVhdHVyZXMuDQoNCi1jaw0KDQoN
Cg==

Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D1AA60E77F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Oct 2022 20:34:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233951AbiJZSeK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 26 Oct 2022 14:34:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234437AbiJZSeE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 26 Oct 2022 14:34:04 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2060a.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e89::60a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EA9AB74;
        Wed, 26 Oct 2022 11:34:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Mf4nuFT8aXeoTxUodJsntOm1imzlu1JLTGkGtoLZaz6ZgGkVqdNjh3oo23dXyJi0ug4866NxM9qS6hrhpxKWEgwD4HKkr78k55WnCBQPIHl2voGr3cdiCJsoiXAaawk/J1RYm3sbZfhMXsFdG/+TOrumgVmaqkgzPwIaF34E11CQg4ea2ahOCzq/mW9HkoHHJIpARcCkUmz5WorqWwwMdRzYHNVM7KyB61V6UqmDhwU2igX5YTGF0OziurZeo0XTyKWFhjFnOhfZPS2EtHagZOn8Gp3sQ7FtFKt8a6PR2AzMr1jXbEFEMLXjfm3sVf+OKUVH9pg6qUgPK2WHDybCFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PqoRptHVhJyOpT2h7QUUWGFsn4L+afrXgaXCrHs51gc=;
 b=nUFd2z4T0OtpzGS4LcYkhC8MAD7fZnketixiKb9gWUDisQB1CjP2I+H5P19tU2meOQlumUH/3JrTO1Dc4m5pkGiPQ22HuC9dl2RsYkARSbKXTSP40NdaF+jihNOX8z1t2ViXOrVwli2UGldf3pBQkZSWRsWAla6Nx86czkFxiEsuTw1euChQrIsAQ395DNZssOOqscKTxoH5tO8vHGlTbLGz7+XoUASLaR4Km7Y3mwd5pqKON3bMVa36UKhonavzcomJdwtom43djC8cHnRK7sjK9aboJG13kEWPq/Ko/LLtQJ2LY6xnImg1i4e9L0d2MM0LbYznF/PwM+RGMXT7hA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PqoRptHVhJyOpT2h7QUUWGFsn4L+afrXgaXCrHs51gc=;
 b=eWfIs+kjs71vcxOZwbebRtFo/pCuFMgFxv84fkQ1rCm3r9n/YNejmIqz0Gs3QgsenQecqfsU5Jy9gk6UXfiaudnBhYYmgvE78py3gcCwPZk7Vh/ftwWfES3BtNzY82KfCY44zLTQyidS45UO7fTOH1LfTHM6bCQgHEmuF+UDWmMqnkE9bx6ycG5ZyJHZkCr17FI3Cyr2GoSvAIG/ETZiQSh8yqD1xU0tBN5Zqfj+mJiMl+FHMnyf0C1bIZSj5IP5xVraXKFE2ABs8LJUB1Nc/UKPwkJgxlNfbneDXwO29WOnUnjOfac3R43EHlBowuJBzfLv6+rBW/hQNCk1OjD2XQ==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by BY5PR12MB4036.namprd12.prod.outlook.com (2603:10b6:a03:210::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.28; Wed, 26 Oct
 2022 18:33:59 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::1402:a17a:71c1:25a3]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::1402:a17a:71c1:25a3%7]) with mapi id 15.20.5746.028; Wed, 26 Oct 2022
 18:33:59 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Baokun Li <libaokun1@huawei.com>,
        "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>
CC:     "tytso@mit.edu" <tytso@mit.edu>,
        "adilger.kernel@dilger.ca" <adilger.kernel@dilger.ca>,
        "jack@suse.cz" <jack@suse.cz>,
        "ritesh.list@gmail.com" <ritesh.list@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "yi.zhang@huawei.com" <yi.zhang@huawei.com>,
        "yukuai3@huawei.com" <yukuai3@huawei.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH v3 1/4] ext4: fix bug_on in __es_tree_search caused by bad
 quota inode
Thread-Topic: [PATCH v3 1/4] ext4: fix bug_on in __es_tree_search caused by
 bad quota inode
Thread-Index: AQHY6O+jB1yxUUFB20OZn1pPpHUHoa4hASeA
Date:   Wed, 26 Oct 2022 18:33:59 +0000
Message-ID: <85773182-2d49-9095-ca05-d59dc47e342a@nvidia.com>
References: <20221026042310.3839669-1-libaokun1@huawei.com>
 <20221026042310.3839669-2-libaokun1@huawei.com>
In-Reply-To: <20221026042310.3839669-2-libaokun1@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW2PR12MB4667:EE_|BY5PR12MB4036:EE_
x-ms-office365-filtering-correlation-id: 1fe51839-fb66-4cb2-42af-08dab780a62e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9USjc285BqvxfHUxMG3hdiPGkwU5qpV/tfb2ojwwdYaG4axzuvQ8vdNvHeg8ZX70TDzQ+AqRiPDexBjt8Pl0EQ7TME3b3Rkkv3vh2SZfJ+aQp7/PFnYggtMObXMBOdrDE8DkhFctjtaqnaK8p6efEq6J2G5cuNoQfCrFabTog/dDt7uT0jRKmweJrhDpXQSjDmvFNFquSbqkUSoxnzbWqrbH/9VxfO/PWJnR5CSqkKTUkI5Butc2id93tFpfG2YGVv7gRXJnjQetA/nN09vVEdcXE3WnsYiZnHow/kILu5yFGuY8xlOqeWOvM+cto8yjz9ztZgqsUZRDc55kU39weytUVPgTWX97JG6EBn8GeyW/cd9v3loGRU/pYLDyWm0lv8NQ/H2O5zs236eB+wuAWbhZxyCregxWRx+doQT+GUIAwuCV6A9NKXIofwKXoe84zjq8iw7WaXjbM48o49X8iZKLvY0CagjJQf6EcGaU1rmvm5n/ms0wDOg2GNsNA4Pk9DkpRVDwaJw+PWCwANzPlCPT/xrqaP1k0mMuqwNlvXX5qUZIxEOVaCND+Xz6K/O13si3mrmZkwqZLR0IXndtadGT869sxwed4SPOrpJDAFOsFCw5Tnvk7HCU09Memej9V/K9OupIdFfVr0/FEhhl5y/jrN0bMK315wRfGnVJRH8wLeJvZpWozFy5NG1Eg7iMpcj1Ccy+znQkaZ2A1/JRbX1qaThrFz6NwunFQY21ezwnKBO3HrHeH0U8R38B1kl6DXHwsg7aFQGd5Amh/Iq1h+PTPNPRIO4GDNVnP/38MOf5fhI3KloneinwOh2mOCrXNVEuw+waF+EHQ7FZBIctGg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(39860400002)(376002)(136003)(346002)(366004)(451199015)(31686004)(110136005)(478600001)(36756003)(53546011)(38100700002)(122000001)(31696002)(86362001)(2906002)(38070700005)(186003)(83380400001)(6512007)(6486002)(6506007)(66946007)(64756008)(316002)(66556008)(91956017)(71200400001)(54906003)(76116006)(8676002)(66446008)(4326008)(5660300002)(66476007)(8936002)(41300700001)(7416002)(26005)(2616005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VEtmbTBNZVVaT0h3eE1xWStDbzg2MTNKNWhNRUJLVGtUTERIRXZlUkEyZllr?=
 =?utf-8?B?L1V5Zk9nQjQ1aGk0NjMycERhZFhCWm5RWXhwRUNNUFZGdDF6dmdZTEpYUDhm?=
 =?utf-8?B?dTRlaStNdzNUUS9sbFR3ZGdPOUxwdzB4cWN3czRaMzRYaTRndE1PZVpOUUhV?=
 =?utf-8?B?NGh0SEdCcHA5WkduRllvRTZCQ3U3aW53eEhMNDZObGxjYUwxRTlCVnk0dFZI?=
 =?utf-8?B?Zk5NTlQvQjJjS2ZUdU1BMElPSjY4MEtYYlFpSDJUTmw5TDJmM0V4T2REQ3Rt?=
 =?utf-8?B?VEttYmx1MVpYdEdrSVJRU2IzM0l2ejFWSmxJQVplWWdSMlVnY3g3UHNEaEg0?=
 =?utf-8?B?MjVXaXhWMjFBcEtEVnNCeUNheFFMUENOUmJkVS9rY1cvQXRGS28zdmxDbGdO?=
 =?utf-8?B?M0NPR3lSN3dnZkRCUERvQml0RE9jSUxXRi85d3JVL2lycmEzWlorUlI3WjlK?=
 =?utf-8?B?T2VzUzBac0I0NGNUa1BXVXhiT1pDZmUxcDJzajMwMjFyamxnOFVkOVRxd0xk?=
 =?utf-8?B?bnlaTFN1djI5SHIxNVl5NTBxbVRxQ1o5UDViQU44YkFWZ1lOWkRLNmF5QUdD?=
 =?utf-8?B?SkNROUZ2UDhGVkxvbk9OK3RyMWdFN2VqVGZqa2xGVE5veEUxcGNDdlBOUnkz?=
 =?utf-8?B?RTlLMEZld1R1Yml5anlUdnFYdFhTazh4Q1paNUVLZnlpNGRtTExBbFRBM3k2?=
 =?utf-8?B?Vi9uQ2FROUtJa0ZIS1JScjU4MlkxRzdkeGJaT3VacnhQR2lnLzJTRUJqNHhR?=
 =?utf-8?B?aWNOOTE3VlNMQitBSGh6eGFSREhWWHlyYmlhZjUzMXBrV2grcmMxZHRHY2pG?=
 =?utf-8?B?Mi91S2RRbjRLZGthTXlOTFdlNGhuOFMxcWdSUDBkU1VtcVhWM3hLNzBTbEJF?=
 =?utf-8?B?Y1RRbmE1a2hzOHUzbFRodHRPaVkrdmoyZU9rbVNYNUdycEhMV1AvczFORHNL?=
 =?utf-8?B?VGh3SWpoeEZnUGVOVTlrZzVtNFlPWVBkekNZaitnRThDWElqOEtMdm5UeUxy?=
 =?utf-8?B?RTdxNEFjYzNLZFVZOXlYeEJiL2ZrbkFWL3hGWXhvNm9kdDVGaHJWbUwvd0Fz?=
 =?utf-8?B?MmtCMGowT1VYdERjTVlVTURCNDhzMHordnZBZWlVUEV0U2FnWTBUYmxaOThu?=
 =?utf-8?B?UGMvQlljMk1JK3dENGQwblRrU0VOVEpuaHdhNEl1Y0xJZUhhTGJxNkhrZ1NW?=
 =?utf-8?B?UFZHTkI1NkNIWktqeDJCUlQ5bE1vN2VyREY3SUh3NWs5MDVaenBmVW5NK0x4?=
 =?utf-8?B?NFdSQlpnSEtoVk02UXFNNXhKQXp5Uk9TbHlXTDRBZTIyMHpHRnB4RVZoVE9y?=
 =?utf-8?B?VHRZNExxYTVlYVI3QW1nZ0d2MHlrajhYV2syallLeFZwTmgvU3E0ajMxODRK?=
 =?utf-8?B?Tm5TSG9FNmhYRXZVY1NtaDl6enAwVTl0OHgzZzAyTEhBUVhYVlJjUXpENzhM?=
 =?utf-8?B?STZhYzFQWExIckNDb2Z2QndHd3RNaU1Td28zS3FMVDZOMVZXVlkwMEFqKzdh?=
 =?utf-8?B?OVpLVHlyeWozb1Q3RTNoVzVFLzJxNzlaREhXSW5heElqL3FLQkFDb3RIYWox?=
 =?utf-8?B?eW9Rdnk0SEVVeEl2VFNRd2FlOE81VXNuWjJmSVNVM0o0VTlWUmd2ZVZKVGFK?=
 =?utf-8?B?dFlTakI5UFlqNmVPM0s0bjdWZ2pMNS9UZjNQaHY4enBhYjJRbXoyaWlPMnJH?=
 =?utf-8?B?V1lyeWdFWFRxZUwwZ2ZMMmxBY2N6TTZYVklab0k2RUY3V0lhRnZtZ2Zna2Rt?=
 =?utf-8?B?bFlSK2JFZzdEemYyaVlPSDN6bzNoNEc5RSsrZGJTQ3dmUVNPL2ZOR29jemFT?=
 =?utf-8?B?b0tuckZ3SUtPSS9TWnF6cDlKMC8rMTNqamt2Ry9wbTBTbllwTktMMFF3US9y?=
 =?utf-8?B?SVVwUVVpSnNhU1Z5WStQUk1QRnpCUTFhYmtLTlRGaSt4Q2hSSVhHWitnQzF3?=
 =?utf-8?B?Wkdvb00reWxNM0FoUjFja05IMEoyQkllVDJ4TmlRTm92cWI2NjlmbHQ1S25G?=
 =?utf-8?B?VG1qa0lWb3ZNcnY0SnZQcUZIa0RjQ0hJR1FmNENqRllER0dqRXhsZUdJRENq?=
 =?utf-8?B?VHpneFc5Y2JURzlTMkxIaHh1VmJ5YmQyZEVybHdtWkJaRUM1Rk5nNmNaRnZS?=
 =?utf-8?Q?i5UMBvq/mbczudwB2StYKMK5o?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E5BBC60C923C7D42A11F8BD780E7E040@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1fe51839-fb66-4cb2-42af-08dab780a62e
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Oct 2022 18:33:59.7468
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RJuuUe+Az/wlrwaBURZCXH6TPI4TYO7qYZIQh8gsPxx0LZFVeI4HT29q5YmSvlhSIOrLkNlDqLinzDkLXR/f/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4036
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,SPF_HELO_PASS,SPF_NONE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

T24gMTAvMjUvMjAyMiA5OjIzIFBNLCBCYW9rdW4gTGkgd3JvdGU6DQo+IFdlIGdvdCBhIGlzc3Vl
IGFzIGZsbG93czoNCj4gPT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09DQo+ICAga2VybmVsIEJVRyBhdCBmcy9leHQ0L2V4dGVu
dHNfc3RhdHVzLmM6MjAyIQ0KPiAgIGludmFsaWQgb3Bjb2RlOiAwMDAwIFsjMV0gUFJFRU1QVCBT
TVANCj4gICBDUFU6IDEgUElEOiA4MTAgQ29tbTogbW91bnQgTm90IHRhaW50ZWQgNi4xLjAtcmMx
LW5leHQtZzk2MzE1MjUyNTVlMyAjMzUyDQo+ICAgUklQOiAwMDEwOl9fZXNfdHJlZV9zZWFyY2gu
aXNyYS4wKzB4YjgvMHhlMA0KPiAgIFJTUDogMDAxODpmZmZmYzkwMDAxMjI3OTAwIEVGTEFHUzog
MDAwMTAyMDINCj4gICBSQVg6IDAwMDAwMDAwMDAwMDAwMDAgUkJYOiAwMDAwMDAwMDc3NTEyYTBm
IFJDWDogMDAwMDAwMDAwMDAwMDAwMA0KPiAgIFJEWDogMDAwMDAwMDAwMDAwMDAwMiBSU0k6IDAw
MDAwMDAwMDAwMDJhMTAgUkRJOiBmZmZmODg4MTAwNGNkMGM4DQo+ICAgUkJQOiBmZmZmODg4MTc3
NTEyYWM4IFIwODogNDdmZmZmZmZmZmZmZmZmZiBSMDk6IDAwMDAwMDAwMDAwMDAwMDENCj4gICBS
MTA6IDAwMDAwMDAwMDAwMDAwMDEgUjExOiAwMDAwMDAwMDAwMDY3OWFmIFIxMjogMDAwMDAwMDAw
MDAwMmExMA0KPiAgIFIxMzogZmZmZjg4ODE3NzUxMmQ4OCBSMTQ6IDAwMDAwMDAwNzc1MTJhMTAg
UjE1OiAwMDAwMDAwMDAwMDAwMDAwDQo+ICAgRlM6IDAwMDA3ZjRiZDc2ZGJjNDAoMDAwMClHUzpm
ZmZmODg4NDJmZDAwMDAwKDAwMDApa25sR1M6MDAwMDAwMDAwMDAwMDAwMA0KPiAgIENTOiAgMDAx
MCBEUzogMDAwMCBFUzogMDAwMCBDUjA6IDAwMDAwMDAwODAwNTAwMzMNCj4gICBDUjI6IDAwMDA1
NjUzYmY5OTNjZjggQ1IzOiAwMDAwMDAwMTdiZmRmMDAwIENSNDogMDAwMDAwMDAwMDAwMDZlMA0K
PiAgIERSMDogMDAwMDAwMDAwMDAwMDAwMCBEUjE6IDAwMDAwMDAwMDAwMDAwMDAgRFIyOiAwMDAw
MDAwMDAwMDAwMDAwDQo+ICAgRFIzOiAwMDAwMDAwMDAwMDAwMDAwIERSNjogMDAwMDAwMDBmZmZl
MGZmMCBEUjc6IDAwMDAwMDAwMDAwMDA0MDANCj4gICBDYWxsIFRyYWNlOg0KPiAgICA8VEFTSz4N
Cj4gICAgZXh0NF9lc19jYWNoZV9leHRlbnQrMHhlMi8weDIxMA0KPiAgICBleHQ0X2NhY2hlX2V4
dGVudHMrMHhkMi8weDExMA0KPiAgICBleHQ0X2ZpbmRfZXh0ZW50KzB4NWQ1LzB4OGMwDQo+ICAg
IGV4dDRfZXh0X21hcF9ibG9ja3MrMHg5Yy8weDFkMzANCj4gICAgZXh0NF9tYXBfYmxvY2tzKzB4
NDMxLzB4YTUwDQo+ICAgIGV4dDRfZ2V0YmxrKzB4ODIvMHgzNDANCj4gICAgZXh0NF9icmVhZCsw
eDE0LzB4MTEwDQo+ICAgIGV4dDRfcXVvdGFfcmVhZCsweGYwLzB4MTgwDQo+ICAgIHYyX3JlYWRf
aGVhZGVyKzB4MjQvMHg5MA0KPiAgICB2Ml9jaGVja19xdW90YV9maWxlKzB4MmYvMHhhMA0KPiAg
ICBkcXVvdF9sb2FkX3F1b3RhX3NiKzB4MjZjLzB4NzYwDQo+ICAgIGRxdW90X2xvYWRfcXVvdGFf
aW5vZGUrMHhhNS8weDE5MA0KPiAgICBleHQ0X2VuYWJsZV9xdW90YXMrMHgxNGMvMHgzMDANCj4g
ICAgX19leHQ0X2ZpbGxfc3VwZXIrMHgzMWNjLzB4MzJjMA0KPiAgICBleHQ0X2ZpbGxfc3VwZXIr
MHgxMTUvMHgyZDANCj4gICAgZ2V0X3RyZWVfYmRldisweDFkMi8weDM2MA0KPiAgICBleHQ0X2dl
dF90cmVlKzB4MTkvMHgzMA0KPiAgICB2ZnNfZ2V0X3RyZWUrMHgyNi8weGUwDQo+ICAgIHBhdGhf
bW91bnQrMHg4MWQvMHhmYzANCj4gICAgZG9fbW91bnQrMHg4ZC8weGMwDQo+ICAgIF9feDY0X3N5
c19tb3VudCsweGMwLzB4MTYwDQo+ICAgIGRvX3N5c2NhbGxfNjQrMHgzNS8weDgwDQo+ICAgIGVu
dHJ5X1NZU0NBTExfNjRfYWZ0ZXJfaHdmcmFtZSsweDYzLzB4Y2QNCj4gICAgPC9UQVNLPg0KPiA9
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT0NCj4gDQo+IEFib3ZlIGlzc3VlIG1heSBoYXBwZW4gYXMgZm9sbG93czoNCj4gLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KPiBleHQ0X2ZpbGxfc3VwZXINCj4g
ICBleHQ0X29ycGhhbl9jbGVhbnVwDQo+ICAgIGV4dDRfZW5hYmxlX3F1b3Rhcw0KPiAgICAgZXh0
NF9xdW90YV9lbmFibGUNCj4gICAgICBleHQ0X2lnZXQgLS0+IGdldCBlcnJvciBpbm9kZSA8NT4N
Cj4gICAgICAgZXh0NF9leHRfY2hlY2tfaW5vZGUgLS0+IFdyb25nIGltb2RlIG1ha2VzIGl0IGVz
Y2FwZSBpbnNwZWN0aW9uDQo+ICAgICAgIG1ha2VfYmFkX2lub2RlKGlub2RlKSAtLT4gRVhUNF9C
T09UX0xPQURFUl9JTk8gc2V0IGltb2RlDQo+ICAgICAgZHF1b3RfbG9hZF9xdW90YV9pbm9kZQ0K
PiAgICAgICB2ZnNfc2V0dXBfcXVvdGFfaW5vZGUgLS0+IGNoZWNrIHBhc3MNCj4gICAgICAgZHF1
b3RfbG9hZF9xdW90YV9zYg0KPiAgICAgICAgdjJfY2hlY2tfcXVvdGFfZmlsZQ0KPiAgICAgICAg
IHYyX3JlYWRfaGVhZGVyDQo+ICAgICAgICAgIGV4dDRfcXVvdGFfcmVhZA0KPiAgICAgICAgICAg
ZXh0NF9icmVhZA0KPiAgICAgICAgICAgIGV4dDRfZ2V0YmxrDQo+ICAgICAgICAgICAgIGV4dDRf
bWFwX2Jsb2Nrcw0KPiAgICAgICAgICAgICAgZXh0NF9leHRfbWFwX2Jsb2Nrcw0KPiAgICAgICAg
ICAgICAgIGV4dDRfZmluZF9leHRlbnQNCj4gICAgICAgICAgICAgICAgZXh0NF9jYWNoZV9leHRl
bnRzDQo+ICAgICAgICAgICAgICAgICBleHQ0X2VzX2NhY2hlX2V4dGVudA0KPiAgICAgICAgICAg
ICAgICAgIF9fZXNfdHJlZV9zZWFyY2guaXNyYS4wDQo+ICAgICAgICAgICAgICAgICAgIGV4dDRf
ZXNfZW5kIC0tPiBXcm9uZyBleHRlbnRzIHRyaWdnZXIgQlVHX09ODQo+IA0KPiBJbiB0aGUgYWJv
dmUgaXNzdWUsIHNfdXNyX3F1b3RhX2ludW0gaXMgc2V0IHRvIDUsIGJ1dCBpbm9kZTw1PiBjb250
YWlucw0KPiBpbmNvcnJlY3QgaW1vZGUgYW5kIGRpc29yZGVyZWQgZXh0ZW50cy4gQmVjYXVzZSA1
IGlzIEVYVDRfQk9PVF9MT0FERVJfSU5PLA0KPiB0aGUgZXh0NF9leHRfY2hlY2tfaW5vZGUgY2hl
Y2sgaW4gdGhlIGV4dDRfaWdldCBmdW5jdGlvbiBjYW4gYmUgYnlwYXNzZWQsDQo+IGZpbmFsbHks
IHRoZSBleHRlbnRzIHRoYXQgYXJlIG5vdCBjaGVja2VkIHRyaWdnZXIgdGhlIEJVR19PTiBpbiB0
aGUNCj4gX19lc190cmVlX3NlYXJjaCBmdW5jdGlvbi4gVG8gc29sdmUgdGhpcyBpc3N1ZSwgY2hl
Y2sgd2hldGhlciB0aGUgaW5vZGUgaXMNCj4gYmFkX2lub2RlIGluIHZmc19zZXR1cF9xdW90YV9p
bm9kZSgpLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogQmFva3VuIExpIDxsaWJhb2t1bjFAaHVhd2Vp
LmNvbT4NCg0KDQpUaGUgYW5hbHlzaXMgYW5kIHRoZSBwcm92aWRlZCBjYWxsIGNoYWluIGxvb2tz
IHJlYWxseSBnb29kLCBvbmx5IHRoaW5nIA0Kbm9uLWJsb2NrZXIgaXMgbWlzc2luZyB0aGF0IG1h
aW50YWluZXIgbWlnaHQgd2FudCBpdCB2ZXJzaW9uIGhpc3RvcnkuDQoNClJldmlld2VkLWJ5OiBD
aGFpdGFueWEgS3Vsa2FybmkgPGtjaEBudmlkaWEuY29tPg0KDQotY2sNCg0KDQo=

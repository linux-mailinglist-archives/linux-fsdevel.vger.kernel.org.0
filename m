Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 077D94D2424
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Mar 2022 23:19:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235370AbiCHWUI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 8 Mar 2022 17:20:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232983AbiCHWUH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 8 Mar 2022 17:20:07 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2041.outbound.protection.outlook.com [40.107.223.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AEC5F1B;
        Tue,  8 Mar 2022 14:19:10 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dTiwNcFv4PWYh52FdjXZkCgL3fTxG9aHbwu+HKYorJ0V6cMSUBiU9lgw8zFOn3ob+fdU/R0kbJ4+i1q7OhJXN/6PzL18BPW5pYoU2JFZ7PT17adGWLgdPKx3F1iBwiOQDqjJaD7+sTAExWb+zSDElwz/fhn3clH/lrgv4feg6/1hXWTPDsPmOsgW24CATOGagNopQVN6NB70U4zMCPjGlh7owAW6DboSIlZUl8UKnysIexekBc3XlsBxEKhm1o7stYKTXdLc9KDjQzCcp7AzL92z381eQHhIaX1nMoXv5YjeV9w1azB4qImSRorcKNfa39pFeqQyb21UqT1cRAxrQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UOZcNfkRE2TD7pXvWrAWwQEVSTqFlhRP0bwWrtGZzUI=;
 b=FOIlWSN5vGBgE9xAX9jcJ97zlgTEkc7r4r/9nRHR5quKtPeywZmcSX9gXXotU4LpkO83GaPWpuHT1U5SeLbi9cyXfDRw+sxrcIwiwuFZ14dYYjUOyqqksCCJK3GRw/DROYW07FCUykn4Ytd2UudQKm/ZRYFqrDQGa9s0+dsGY5ncb2cBVqRDrIGGOaA+VZqXq19EZ03b+cdZ1yYwW5E1K0yNbZX6nyNR7+k/68vVyE2prXoX2IHnsA4qrZaWGHr91//yFqrKsbZzyRTMcbWzlZRsor0arEHFHVO0Db936tsHteIRuxSdDJEvfpxmtE+qzndTiFj4qjJu0DUXebRGtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UOZcNfkRE2TD7pXvWrAWwQEVSTqFlhRP0bwWrtGZzUI=;
 b=Uz0cjCiwOybwGbqbkhop3J7T4STFTe8LoafWilLXCYWfm3SwuUtYanrQn0ouJ8vFEzUF3+bCsgJa8yKOMUk1XxKxTPExUYLCjuDRmanfTMuKEdO/Oj9HtxtlQlxZFX3aCtIEfIwlU/Gy4rsvicNP+y3DcEdn7RADH9GwSBZzl4AGqSSPdzBrD2WTmkhpn+4VKkIBXD8ZFYDcgRKRs2TcwjY857NFEyFLLZ78h+gTfglT6gKSLCGx32rJicsvmmp7XbDgjVdyndrmNn5PO/gEMJDcAVZwVWOGEyrXt+tXtlCosOqI9Fy7AI49WD1MWn++mjZsVPVIzpnNpyU9g449rg==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by MWHPR12MB1309.namprd12.prod.outlook.com (2603:10b6:300:10::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Tue, 8 Mar
 2022 22:19:08 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::204b:bbcb:d388:64a2]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::204b:bbcb:d388:64a2%4]) with mapi id 15.20.5038.027; Tue, 8 Mar 2022
 22:19:08 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Christoph Hellwig <hch@lst.de>, "axboe@kernel.dk" <axboe@kernel.dk>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH 1/2] fs: remove kiocb.ki_hint
Thread-Topic: [PATCH 1/2] fs: remove kiocb.ki_hint
Thread-Index: AQHYMrKLc0UTVRaB/UCzpz8Ijytpxqy2D6kA
Date:   Tue, 8 Mar 2022 22:19:08 +0000
Message-ID: <cc76b05e-6dad-0fb8-01bf-5883f83b712e@nvidia.com>
References: <20220308060529.736277-1-hch@lst.de>
 <20220308060529.736277-2-hch@lst.de>
In-Reply-To: <20220308060529.736277-2-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8ae8dbbb-a19c-45e4-346c-08da0151aa39
x-ms-traffictypediagnostic: MWHPR12MB1309:EE_
x-microsoft-antispam-prvs: <MWHPR12MB130986083691652297EA824AA3099@MWHPR12MB1309.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wUPVbynszOO9oMy4UthSMP+iZ3BVFAh51+WNwGQGVizDnAEOcg4ChLXv0gRYMUsi7uKNsemiLWBLP+axT1FgNLWewAob79wWRvdaha3AHjLtGPha0qtYY+DBf/KLyBx2Wwpre4PsdKXUyBG920CD7qV5NqgDuCr8vI+bXPRuMWDFSlccuMMSjHTZpYYoE5ATrqItl5oisaQcz2Pzb0vaGqxGa0tMIbtVcASA7yT6EHu/t7z9y+nYTGFrS3lS2tBeypVVmZ6cClqRQ1MmBGP0mGzM5/0IxLta7ZqK87yhKNv3VGtOVlA86yuVPiOu1ip20WoZOK0ZtBJsvhxnIO8zgxesm/QGsOQqv87zTYK9nUPvLoCbdEptjlDd2PqQx6jCCMO4E8s67yqAKRWOzn4A45Q4IUKUG7rijcUHeAidARghUOm0Z1lpLo8ApAmY8tF32aH1LXDn9jpMEWTsKWtF9+D3rujkIlbYniLurj2Z/v8t0BKpSfUpoEljY/+glQgDdu8OXeWYo0HzOY/1h0HB60czWnMKk/BqJnAMSmJHisTfZbFrNy0bUVrfbve1vSCRvQQw7Mbo+LxNhzzXm0dApLSG25hitwjTA06LvO0HXkhKRRB9ISwIAciULI9HOObEgL2PiSPgvICHGR99c0Uv3iwOgUckYFHm9TJp8zqLaF2bdZpYfUK7hwfUG6V3x7v+KOMyNZVnSA39uP4Vv6EjJAk0ryZxLnWkudXlrWdOAfJcY4gphzgRKO054XTk5O3kMWGsmrFxYD+hlK0EhB7GKw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6512007)(2906002)(86362001)(6486002)(71200400001)(26005)(186003)(38100700002)(316002)(54906003)(558084003)(110136005)(2616005)(122000001)(31696002)(66446008)(66476007)(8676002)(64756008)(66946007)(76116006)(4326008)(66556008)(38070700005)(508600001)(91956017)(53546011)(31686004)(36756003)(5660300002)(8936002)(6506007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?R2huWC9mb3dXV3dOeXhIUFFxUDEySmVMNkExRHIrd0V2ZWdsV1dwcTV3RWIv?=
 =?utf-8?B?NTVHaHJ1N3NvZElLdUVjcms2MGVDZElJa1RMMGMyNDRKRHZtTlo3M0VkYzJN?=
 =?utf-8?B?WWg2eldCZ0lQL3k3VThPZmE4bERvWXNJRkNMenpKSzVpd01ZQXhNMWNCWDky?=
 =?utf-8?B?WTYvWGFjdVVpemViUU5RemFDRVVxcHhCRDlBbWw4eENRYithaEVPMGgrK3A1?=
 =?utf-8?B?UVF0REVyK3d1SWgxS3ZKdVY4ZVhUMmllb0RYaUJnZFRYUlFuRU5NTGlWVTlN?=
 =?utf-8?B?QnZvand0aHczNVVEeWxqdUMvNnI3TGtubTZ4Tk12TXVvTDZtZHUvRlRaSGw5?=
 =?utf-8?B?RTJYWWFUS0lvemNmRTY0QVV5VGQ4eHdCOWM0UXhxcEkyOW5rc3ZkVmF6Ri9p?=
 =?utf-8?B?Q3p5eFRZdlBmRkUxajZNL3hlZUVOWEI5T2pueDFGUFdUN3pEM2picEdSNjFK?=
 =?utf-8?B?QlRJOFN0Zzh0bW9EaWRGTjFyT0owUzQyQ3Y5R2g2cFNQRmpWSEs5QlJUN25a?=
 =?utf-8?B?eXFaTVpuZDJKVUZleml6ODIyd04xL3hUYlBLZi9WUUwyNjR0WXVtbUE4RXRJ?=
 =?utf-8?B?b1IxdWtsWHZ0a0w0QXZtUE00ZHJ5VW5ZaWI1bEhNcG0vcHRyajFzaHhGSWFN?=
 =?utf-8?B?WGlUNDh2TDRod1JHZ0ZjanFXaWpBbCtKY2VKbWp0ZDBwSVN5RzRCT3dlUzQ5?=
 =?utf-8?B?TUQxYkl3MjRLWDlENzdFL1d6RjRlcG51Z1V0b1ZyeUVmWG5DUGFuSmJRWlds?=
 =?utf-8?B?ZmZpYW8xbVM1QkZIcHlhWHJ4OE8yTlBhMEZ6N0JjZCtQeGxtdnVwRkFQU01w?=
 =?utf-8?B?Sit4cEVDTWh2d2dTMW1ydHJHYzdDYXI2Ri84OU9SaWlFSGZLcDdCYytVTHNU?=
 =?utf-8?B?SVQ0TXgzMTdlV2E2VDRBY1NHdFBadWVra3I1UlNoeEF5YnBsV3Irckpsem5I?=
 =?utf-8?B?eGEwOExTcHpwMlc2Y1NGTXc3bDc4RzE3b3VWUUJ6cEFQY0RVMDNQdGYzd1dV?=
 =?utf-8?B?Z0R3SjJ6ZG5PWFVOMkQyWnJybmR0S2NETTZJSmZEd01kU0ZMMjFpaWxHUHhO?=
 =?utf-8?B?cGtNSmZEeVIwdGlZVXdSN3VzZC8yZUFNeU5zM2N3ckREbjA5YUR5SWFMMjM1?=
 =?utf-8?B?YWtrWnF1TzBXZkZQWVhvcXJEYXJ0TFRHcHU1dzI5Y1JSZnJ0MndJZmpvWVht?=
 =?utf-8?B?MUdxQ2tueGszcXlEZXY3Q0JsWEUyVHljSzRGT2NsQnl2UGN2ZVNrc2g1WHls?=
 =?utf-8?B?ZkVKc0hqcjJqREFsNkpDT25hcUZZcld6cVkwMmp5dWwwQTYvbUd1R3M4NHNh?=
 =?utf-8?B?RS9kdVRQYUJhV3JSOGMyV0J4MkxpdUlBZnJzamQ2NmRUa0JRTmI0NEhvT3lD?=
 =?utf-8?B?Rk5yMHFNSjVmQ3RhQjZWdWJ5NnZPNkxuNkg1aFdxSGh4S05yYStlZ2tjVFlZ?=
 =?utf-8?B?NCtpOVh0dWhHN1RyeURWTU5IRGJwaEF6a09ET0hiM2RwdkNqT2hMcTNpSGxQ?=
 =?utf-8?B?VG8xVS93TnVyWVgyY1prS2tEMGNVWXpiR0VnUTU2TWV2TzJCUERvTERVWk4y?=
 =?utf-8?B?VFlyYk5YWnBtZlZScWtMWUlkN0NMaGQ2MTliM2RGZys5WmIrQ3lMNkM3cklN?=
 =?utf-8?B?RlAyRFdmeWxlajFjNVZZNkN0eUxzMEdyVGU1aDZ0MXJNUDBKZHNWRHVIZGRJ?=
 =?utf-8?B?WnU2aHJFaTRNKzU5UEh5WmxhY0RZTks3Q1hUSi83NVBxaEZjZGZ5cENlRkpO?=
 =?utf-8?B?SlRaRmsxMXJ1VGRUK3ZNcnNtU1FKNzFYRml3UlRINUZOVTlQQ2I4cVp6QXVL?=
 =?utf-8?B?dWFLSElsYkFuSk11M0Fyb0E0RDNBYVRYTzdWRCtGOUJteWpBdFF4bC9vdGdD?=
 =?utf-8?B?MEQvZmUwOHZJMjY2QW1PSDRRZmwwZStUaVJ1Z2FGYVlORWFEMFBYODBqSXJK?=
 =?utf-8?B?QkszanRjVENBdWFLN2lraHoyRUUwdXU5c281M2FEeTk0eWdRWWQ4b0kzdk9D?=
 =?utf-8?B?QjZsbnJWSnpIaVdncHpJNEwxMDB4R3B2OENlTTU4ejRTMGZDWTZOWEc4VVNn?=
 =?utf-8?B?cnQ1Rk9vdEtBbk5PQjF2NE5rcTc4ZE5oMzJaZVp1SW9mbjlkcy9vRm9YaFBZ?=
 =?utf-8?B?N2F0RGVWTC9HRjlQQ3FrVm5ncU5JQUt3cHg2RXlSNTQxRXJ0N0JYZFMzdjFy?=
 =?utf-8?B?L1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E4830EF9BF90224689E0F879792CB8D1@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ae8dbbb-a19c-45e4-346c-08da0151aa39
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2022 22:19:08.4951
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kcdEhqVQTVfKDrFRlqmg1gjabLW+u6JEkF3TvbhlEm3qQl0iASwMI7+wVjRQUPwRKzRCFrZUYzQYxFM+HVaHOw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1309
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

T24gMy83LzIyIDIyOjA1LCBDaHJpc3RvcGggSGVsbHdpZyB3cm90ZToNCj4gVGhpcyBmaWVsZCBp
cyBlbnRpcmVseSB1bnVzZWQgbm93IGV4Y2VwdCBmb3IgYSB0cmFjZXBvaW50IGluIGYyZnMsIHNv
DQo+IHJlbW92ZSBpdC4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IENocmlzdG9waCBIZWxsd2lnIDxo
Y2hAbHN0LmRlPg0KPiAtLS0NCg0KTG9va3MgZ29vZC4NCg0KUmV2aWV3ZWQtYnk6IENoYWl0YW55
YSBLdWxrYXJuaSA8a2NoQG52aWRpYS5jb20+DQoNCg0K

Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C4A76334A1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Nov 2022 06:12:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229728AbiKVFMT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Nov 2022 00:12:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbiKVFMR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Nov 2022 00:12:17 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C53172EF6C
        for <linux-fsdevel@vger.kernel.org>; Mon, 21 Nov 2022 21:12:16 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gmK5NC9ZhvJuRyvaKTypuDIXUj/oTlXpihLwMXkPBp97/4xAGdJBr/PegrDFIVEZgt+P4x/tm0cbDCrsDLzRfWQy8l4g/pj+HyF1qcsbp3xLfI4o2cl7IlhYpN9Z/vaSZLLT7b+UWDMbhaTQCeTI50ewb3kzOale6oaWb10xRBUYGWissZCwCCcI4EgkkLQcpKfwY+f/vpv5u+NctURGRMgc8O73/evWHwxCzmrP2zyOrA5bZaq5FpS2cnvz80nNo0ktFxTCEPMHxE7V1KduBnvqgZH7AR1D1YCsrKDwxkRUo0lC1Vidz4hw9WngI7lNHcfW4RzTjRuCaMxgDRkK5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xNH+Uj3O/8tb9f1ZbdPZCQ0Ve0aKOLyqsOrtzoAsfXk=;
 b=Ke+ljqFiMlUbe/gzDDbjZv5RJ0cMqFGJAyAtNxj4tNf6VgHxSPRUumg5Si/5mLRbnShNOgb5aDiXQ08nzXbe8OBxnR4RJsIohcvb4c0gYy9XTjoNoO/z+VjxHpt7owLtwlzOtG5ocWoOKo1xKfW0j8VsKLIbzvuk1wx2/4gSnzMj7TWa+TwbqjsC49MyGcCaFSwc2dGuuGE04YxsGp/HBVhaRRKq5oI4ZJtGLiIqpER+XFoeBeovhkvxJS9rdyhHf94mSbILVhtXhxQ2E/1Uazmwedt7MkaWH6Dl/PhSkx6lSpwj2v1XAB2WKd6gFnB5iiT2gLA5rxWl8aMOMr8Vhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xNH+Uj3O/8tb9f1ZbdPZCQ0Ve0aKOLyqsOrtzoAsfXk=;
 b=EJa6gBtf45SgX7gS751WIjdwESw2l1S3G3ZtKPlUJfQwZYp/UMeQLs+u4fUx1PP/9GiP/3liP0ezyXZexa0j6gc3TFxUQ72DnrZQQ7Mc4J9IA/SQhMiLXV112+j/AF5VBSiiwXyIm9HI/iplJOeOmN1GcSlPjUddmTP24gexnlRoz0CXxaOrANqcvVPwO+cCUkKHSYQv4WehW64xmnIfKy295+xxWj3Hsk6YZg9vJMHf84evMQDScmy1NcGb2eL7aE49puLJhcoFrQaBSsMAvYOurCk0fwa61aMmXY9UD97WPWSMmQYizY5FpJyQhU5HoB9RMtwrZtZw7jKlLblNkg==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by DM4PR12MB5819.namprd12.prod.outlook.com (2603:10b6:8:63::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.11; Tue, 22 Nov
 2022 05:12:15 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::f02:bf13:2f64:43bc]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::f02:bf13:2f64:43bc%7]) with mapi id 15.20.5834.015; Tue, 22 Nov 2022
 05:12:15 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Zhang Xiaoxu <zhangxiaoxu5@huawei.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "damien.lemoal@opensource.wdc.com" <damien.lemoal@opensource.wdc.com>,
        "naohiro.aota@wdc.com" <naohiro.aota@wdc.com>,
        "jth@kernel.org" <jth@kernel.org>
Subject: Re: [PATCH] zonefs: Fix race between modprobe and mount
Thread-Topic: [PATCH] zonefs: Fix race between modprobe and mount
Thread-Index: AQHY/MXzDKULcv/K/E6tmXwetxQeBq5KaGsA
Date:   Tue, 22 Nov 2022 05:12:15 +0000
Message-ID: <e6b94b30-4342-7f9c-0574-d4c4ae8d16af@nvidia.com>
References: <20221120105759.2917556-1-zhangxiaoxu5@huawei.com>
In-Reply-To: <20221120105759.2917556-1-zhangxiaoxu5@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW2PR12MB4667:EE_|DM4PR12MB5819:EE_
x-ms-office365-filtering-correlation-id: dd67cb91-e44b-455d-62d2-08dacc481ec2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +CEy5yg2jnLOs/2yxSNo5/bBtKM4bpzWX0is+PGWh7QatWsKS5zSjCzfBoNbPHH5auzY5JA/0fFLfqYVsdq3kxXFBzSWhRvjTr1FwBALQAwwnT08uuN9+30rPmpaFJzzN0do+0An5WHcLZyjJic+yHcvHPBYacNMXawnqW+xo1pkJ5x7FLKXwkqeBLfcrTU5nlxi0mrDI/QOQw1yZXmLCTHIG7P5C54pH0YVCVplWl81/Rpv/Lr3fdqHPqcd4DHpcRG0YgwqXSs4tElaHr9mPqTpLxSJUF44gEkYuLwOW2/NP+apnN1wkMPNMbJNX6rjYkT94mSfPvB4Lfg6dMqc2FfhUqd1aMpAl7qlS/8C8pK23Q85jeDfcIHuJbRm8gVxjCuh8scZ/fFzG4zszgFJdIWV5BdVY9Xpmu8DXSB7Y8pbTFdqumtP9RVxJzadCv0Xvp18/rf+fh1ltf4Z52kD1gagLftQO0v+tD2wOfqC96ARo//4PBq1yGBhQZ9qkvceyswQzrKerzQ6mxV2e2Wlm7NtW96X6DTZNS45yezC/pb+kuToQvlYGM1/RNho5y6CjrveuCB0JQbejnvoXaWbVPR60uirv3sProc/deBM5HkoxSk7d665Ro/IzzgrJYRAek3TkzB5KBWEbpyR7iadKGH3OJsFJeBbwfDs9rt4h+y9Uid5/fm8bIoU1/aMN0HJx2m6RE0vmztMdQa/7H9Pnz/gBu8HGeSXko5q+D7HnWpjX+srtT9bpJ8AAnngf740fZCmSbK2kRPEkgPFvf6ZCw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(366004)(376002)(136003)(346002)(396003)(451199015)(36756003)(186003)(2616005)(6486002)(71200400001)(110136005)(83380400001)(76116006)(66946007)(5660300002)(91956017)(41300700001)(64756008)(66556008)(66446008)(31696002)(8676002)(86362001)(4744005)(66476007)(8936002)(38070700005)(38100700002)(122000001)(478600001)(31686004)(316002)(2906002)(53546011)(6506007)(6512007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?S2RqMnF0TG9pWkMweFhaQmNaTmNUdHF2ajdLZWc5NUovQU9pbmhYWlV4OXov?=
 =?utf-8?B?bm5Gck12WUhpUWhNaGpWRDlWMHpsSkFucUIxNFlrcHFZYW0zTW80SnhRYjFS?=
 =?utf-8?B?REZYMjZLWDBXb2tRb05RbVFOSGdPVG91NG80YzBMdjBDbENrWldPZnQ3eXhj?=
 =?utf-8?B?anJrMW84QytUQXU0ZTE1VkV0dXZtblo4cUhhTCs4NUh1SC8zOE9ZT2hkSDZi?=
 =?utf-8?B?cXJ2ODhLTkVTTnBYQ2h2QjB3SE1VK0piUHlyNEd2andhWkZSMFdsYWx6akF5?=
 =?utf-8?B?aFRKMVUwLzJjL1RjRHRWMDVucXNUTDUvNzVVY2ltVm84bmZMd3UwVEZTMmZq?=
 =?utf-8?B?alBhLytiNEM4MmR0Y3hQRHhtZkRRT1M5VGVXQ05YWGp3aytXNVU2N0FhN2lY?=
 =?utf-8?B?SEMzbndDMkJoQ2dkTXBQazR1emdudkRFSWQ0ZlY4M2Rqd1VzanZ4ZmZKM0Z0?=
 =?utf-8?B?L3l1UlFEWkt1L2xVOERxVkRPUzFQMDNQSVNKZWJuSm93aHpHZUEwNHhGdWlx?=
 =?utf-8?B?R0plUHg5WlZhSzQ2RG1BZFhHUmxBTERJTWwzd0kxcWlacGQwb3ZVMDAwNkR5?=
 =?utf-8?B?ZHNrUlB5b21LU0k3WFJOZFVJTHc2TTl0eEZnNW5XMG5wcVlxQmZYVWs5YkJw?=
 =?utf-8?B?VlVUcjJnRDRSMjR5TDgzWVhUUWRpSEpVUFpZbVBYRFpPNWRIYXZJaGhKNDUx?=
 =?utf-8?B?S3p0OWNCa2k1aitNOUxEQXNMbDdNWnJXVjI5VnM1SzViNUYreUdnWkFUZUNt?=
 =?utf-8?B?WWtUcTZvV0pleGJNcmtORkJSWVZKci9ETnQ2aDVLWi9GaVhoRWVVWVRZbkpZ?=
 =?utf-8?B?UExxWldkVEdndElrVG4xbHVjN0FzdmtJT1hyaTFJMUs5OC9KRUJ6dFhNZEM0?=
 =?utf-8?B?VkowWjl0Z2pEckVISnlSb3JuRkxpVmF5T01XYlhucTMxN2tGZXF4SGRwV0hU?=
 =?utf-8?B?Q1hYbUhaK2lmaUxLWG1sUjhVTjltWGNoQXk1TlZGYkwwKytnTlN6MmRSbHFU?=
 =?utf-8?B?a0d2NFd2Y3pTY00ycjF0d1ZlZ0RKVEpFMUt5VENiUTVxbkhsclRVOEJFUFBy?=
 =?utf-8?B?Y2tFaUdzZUZnTHZnV1ZPMmNmdkZ5dUdZc0xJOUgrQzBwVWpDUkhOdU5iS0R5?=
 =?utf-8?B?NmRHR1hJam8wTUgyQnhKWGF3aTJMMTI2NzY4RVlZYllDNHNYWVRQMjRPZjcw?=
 =?utf-8?B?ODJ6TWliVlcyTFV6dTFhZ0ZIbjh3dzZLSU9nMGRTR1o0VmRKemtPQUhzZzJ2?=
 =?utf-8?B?L1YzL09JQStsc0MvbVk3alRzT1ZEZjlUbGFLQ3VhbHU2dEpkNWpLOWhqOU5U?=
 =?utf-8?B?Z1YxR2g1Z3NTbGJMd2Q4dFNwVi9CblBMdlNqL3psZ0g2UlNNdUd1d3BPUFd2?=
 =?utf-8?B?T1FManNPZU5SY2lhb3RRZVo5K0RRTXVpNlZoeUhadHQ1RFIvV0pvdFhUN1Ez?=
 =?utf-8?B?Ujlzckxjb2dMWXY4ZzBaaUNHSjVKRVhRWERaUDBvWGpDT1l5U3lKN1FDcDRY?=
 =?utf-8?B?a1FTbzhpVUExQnpOSDBWL2FQTDZDQ29EREtKYVpYYWxXU1JSakhHcE9ySVF6?=
 =?utf-8?B?NW8yQ0cwL3RIV3UyZ2pkcWNGWWF1dDNzc1I0WXluTXJmQ0IwbDFrWFltajcz?=
 =?utf-8?B?c0t3NkhjVmN0SWxQSHBRdUk1Y3JsWEsveHRUcWNoYjZKZG8vZnVuK0IyOHRV?=
 =?utf-8?B?YitXKzdxYktCbjgzRVU2emthU3VVWGM1bk1RVXVITDRKOHJPTnc0dTM5VldV?=
 =?utf-8?B?YVJ3QW8xMGRGOTlmZ1BaTi80clkxT09KZ3Q3Vnk4NFpmbGZMT2ErQmhkWVFs?=
 =?utf-8?B?RStqWnVRaVNCUHdoUWJyVzcwZjNma3RTVWJJMVdNK3FwNkZjVm5zQXdQTWpr?=
 =?utf-8?B?M2kvTkJBa0xsV2M2dGVNVW9XeXg2Q2NCczVlaE5RUW8rU1pwS3lQUHdDcmNJ?=
 =?utf-8?B?Rk80TUx5Q1l5WFFsYlhjKzRSNWdyS2lQNE5FRU9XcS9TR1EvWU80RDVFMTlj?=
 =?utf-8?B?QWZyb1ZsM1lzWVp0a3BRM2N4U3U2YmFBRXFCUzBLSFhLUG1DRGs5U0EwSDlu?=
 =?utf-8?B?d2tBcWdENk9TbFVGUThLZDdQZFBrOWpGOHVVSGdTdVdPTy9ZdUVTTi9JNDFo?=
 =?utf-8?B?T2t2bzdkUlhtMi9rMVYvazBqQjhodUV2aC9KL3lrSXJCMjR6cG9RY29nak90?=
 =?utf-8?B?Z1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2D602EF28A2B434BB42F2863FC50F93B@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd67cb91-e44b-455d-62d2-08dacc481ec2
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Nov 2022 05:12:15.1957
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gMY4BDHOpaUcoi90nKOwIm7W0bhTi9Gai9nGPOFschA9eGcssS8/KeKB+psqQ+MfHUsdhSu7jW8VF4Ps1rj1QA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5819
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

T24gMTEvMjAvMjIgMDI6NTcsIFpoYW5nIFhpYW94dSB3cm90ZToNCj4gVGhlcmUgaXMgYSByYWNl
IGJldHdlZW4gbW9kcHJvYmUgYW5kIG1vdW50IGFzIGJlbG93Og0KPiANCj4gICBtb2Rwcm9iZSB6
b25lZnMgICAgICAgICAgICAgICAgfCBtb3VudCAtdCB6b25lZnMNCj4gLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS18LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KPiAgIHpvbmVmc19p
bml0ICAgICAgICAgICAgICAgICAgICB8DQo+ICAgIHJlZ2lzdGVyX2ZpbGVzeXN0ZW0gICAgICAg
WzFdIHwNCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgfCB6b25lZnNfZmlsbF9z
dXBlciAgICBbMl0NCj4gICAgem9uZWZzX3N5c2ZzX2luaXQgICAgICAgICBbM10gfA0KPiANCj4g
MS4gcmVnaXN0ZXIgem9uZWZzIHN1Y2Vlc3MsIHRoZW4NCj4gMi4gdXNlciBjYW4gbW91bnQgdGhl
IHpvbmVmcw0KPiAzLiBpZiBzeXNmcyBpbml0aWFsaXplIGZhaWxlZCwgdGhlIG1vZHVsZSBpbml0
aWFsaXplIGZhaWxlZC4NCj4gDQo+IFRoZW4gdGhlIG1vdW50IHByb2Nlc3MgbWF5YmUgc29tZSBl
cnJvciBoYXBwZW5lZCBzaW5jZSB0aGUgbW9kdWxlDQo+IGluaXRpYWxpemUgZmFpbGVkLg0KPiAN
Cj4gTGV0J3MgcmVnaXN0ZXIgem9uZWZzIGFmdGVyIGFsbCBkZXBlbmRlbmN5IHJlc291cmNlIHJl
YWR5LiBBbmQNCj4gcmVvcmRlciB0aGUgZGVwZW5kZW5jeSByZXNvdXJjZSByZWxlYXNlIGluIG1v
ZHVsZSBleGl0Lg0KPiANCj4gRml4ZXM6IDkyNzdhNmQ0ZmJkNCAoInpvbmVmczogRXhwb3J0IG9w
ZW4gem9uZSByZXNvdXJjZSBpbmZvcm1hdGlvbiB0aHJvdWdoIHN5c2ZzIikNCj4gU2lnbmVkLW9m
Zi1ieTogWmhhbmcgWGlhb3h1IDx6aGFuZ3hpYW94dTVAaHVhd2VpLmNvbT4NCj4gLS0tDQoNClJl
dmlld2VkLWJ5OiBDaGFpdGFueWEgS3Vsa2FybmkgPGtjaEBudmlkaWEuY29tPg0KDQotY2sNCg0K
DQo=

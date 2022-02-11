Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61C8F4B2493
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Feb 2022 12:40:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349517AbiBKLk2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 11 Feb 2022 06:40:28 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:53134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232547AbiBKLk0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 11 Feb 2022 06:40:26 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2085.outbound.protection.outlook.com [40.107.92.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9179E9B;
        Fri, 11 Feb 2022 03:40:24 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VUyyDM5z4h7VhXswr4btj6PhG+P5q5Klk973mzRU02h/4Qwbu0zZ5K+Dgz0S/2ZJTxBI+H8n3rzkNpQSAlC/LLTdyMFNny28sTnxdAGDtzLCyGUALCVcYAgeVAIKVrzMjfuooOSpDYtmFf1HX8reRxezwFN2oPYck0iUmU4rFjtndF1q85N4HFqgjX3T+9atz4vZ4vou5hTShrsAUhbqvNkJ3Igz1Rr0kykFexG5FLj4MmhYEt8+D4yIOKoCzkAUdoM9YjAi0XFSMAWcCN+IOadoCXppk7yZ33McWqiTBn+dQ1rrm7HXdslJrX6n1ZwtzlVYtaAZ6hZYfU/iPACwbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KhT5YiWLnew0VrPJOfN6l+a/a/WSpiyjWcAkGC3UDEs=;
 b=TJ8yIvJBhuiIFZyeuIQsOB/VTyqraLy2frS8nEkDqdfwGAawqvXGSzTuuRmTAJ3xEHveiL5A6XWc9Ib4AiR9b1a0MKbMLhDVcpiCcj/AJDDodOj0SZMNMG/QhO/PFoExxGlwU968l8z/cwqhMy3Fu42ThBDrUq0eANFK0wNBHVxD61hR1rudK0+lJwo/ncRUHtCqKvrgZwyu1tLTYKLIDjeQpFrK/PWBFkLVO0V67J77No8FyUj86St7o3+HeeIZMBrgLs/RXIEDYMJ6dvYrUCIhZ84FRgU51re9eBm4rlhjw6PumnM2xNa6PXtptrjzAighb7Z+eyvJPXL6TINMJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KhT5YiWLnew0VrPJOfN6l+a/a/WSpiyjWcAkGC3UDEs=;
 b=DNriNoyX58xMGp/o7whwoSj7X3mha7MzgOdkwQ1Z74XYuIQJi4gEiuiRn5z+BNYX8iIqdHoSKXugIeS0SPKDnJuETOFLNlqaoNFLnJE+/aZqWkt0eVNQxM3AMmsyqGVkex6ZBsoJ5wA3wbiCiK1gArfKC8oRNyRf7Q2GZrPyjO0Mg7np/sYJA+XPZU47hwTOmCZ93D1dkHnZl0CMQ3AOhteOssfyoNKIWS7bA+XoM++Cv/Q6KWvmb9+SEWyg3XAHP1afhC9vLGgl7w3Raj0DZuEqq1XUeAdYrX4or0yazTBZx9gCbqp8dfYhNXaNL05LtiIeqeJ5+agV5cTcvcxxnw==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by MN2PR12MB3199.namprd12.prod.outlook.com (2603:10b6:208:ae::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.12; Fri, 11 Feb
 2022 11:40:21 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::846c:d3cd:5a30:c35]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::846c:d3cd:5a30:c35%5]) with mapi id 15.20.4951.019; Fri, 11 Feb 2022
 11:40:21 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Eric Biggers <ebiggers@kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
CC:     "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>,
        "linux-f2fs-devel@lists.sourceforge.net" 
        <linux-f2fs-devel@lists.sourceforge.net>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "linux-fscrypt@vger.kernel.org" <linux-fscrypt@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH 1/7] statx: add I/O alignment information
Thread-Topic: [RFC PATCH 1/7] statx: add I/O alignment information
Thread-Index: AQHYHw6MhkvU3aWvQUef3qvKk4R/5KyOOi4A
Date:   Fri, 11 Feb 2022 11:40:21 +0000
Message-ID: <1762970b-94b6-1cd0-8ae2-41a5d057f72a@nvidia.com>
References: <20220211061158.227688-1-ebiggers@kernel.org>
 <20220211061158.227688-2-ebiggers@kernel.org>
In-Reply-To: <20220211061158.227688-2-ebiggers@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a67e323c-eb06-4344-dc1e-08d9ed5348e9
x-ms-traffictypediagnostic: MN2PR12MB3199:EE_
x-microsoft-antispam-prvs: <MN2PR12MB3199759C4DC6E8EB9CF7A168A3309@MN2PR12MB3199.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2331;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vXdHmGwpFnh7FvGwXqqZgLEl/oP7wzqIxVS3Rc29Kvj3Q8iqqbV7dKWC0TuvI+V1yMxJd8q9AdSPQVboG2EoCOfwCU0iqycUAISKnaaOJvS5NylCg4TMNM9Dxg8tXxYvWbsIdHprwPVW7k6X3EmwE3QzGob+dOBuOmU02zEP4rUjgcgxIBEY7OhwdAHiZO26zEub+5ld3IZNLneNeJbZsjH3AxBT5MFdLY4ozTlYjFPDXtdOPYXPySnNeynjlRpoZTZzjVXmHvbF+WbqtlhKX250059/yNxm6LdIjtR09R8CxriZywIZx6tp0KR7Ql2GviuRXjAxOjg8kxtgBB/h0Qqt/QZy0Md0/2paM9KfKMEo8p6kKqbQEmSj053whmOsQQqk53zawWUJ1gx0WZYitY5i7ErKFLy11I8iQZ95lfwCkhwojXMtv6W/uWYEhXLHNfn8AoZgvmiQfSoLsU8uadGn5Rc0tKiDqSvL0CSLOIWwBbtG//yu5uWPk1TtroaGfas4NBXnHpdEXTDNLAxasQqEvtCBxVctcPfCQhCKDq5onn5kbEeo6uIhOyud0XR640P28mt8aaTaLFFIUenDxxnLAu4PQV0mjDzqOIw3MdhXsJ7trU/6f2axwXN0L5ByZrzbkwf5hAONMnN5mu/pEo8uWe4qPs1trO/Vvcc4qoNjNJLXYdGMhT1gWEwYIJ1ve2ch784eXUlzFc1I8zKuPa3lDaitkkmYLBGSqMG0SGq78FxHlXblmjjt+xQ2ci1GoLgxXTUUZqjaobDgxmacrYpY0JPKlkoplFhX2jBC1kX0Xx03/iykCKvqdHvi5HSDbJ0o1nzVSHZgGwjRiw4zGMFJWuKKqd2eUJ4KMtYlAtZ8QqnlC1CQBzYEL9t7IQaANjdfHwT8K2q9gj7euCzISOUb2+EqKNR20FP8BfrfPd8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(83380400001)(966005)(508600001)(71200400001)(6486002)(36756003)(5660300002)(31686004)(2906002)(64756008)(186003)(66476007)(8676002)(66556008)(4326008)(66946007)(91956017)(110136005)(54906003)(8936002)(316002)(6512007)(122000001)(2616005)(66446008)(38070700005)(76116006)(38100700002)(86362001)(31696002)(6506007)(53546011)(21314003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QkVKUUY0RkZNTTBSa2tHZnJiUnNoczdXTFNGWDJPTUJzbUxEbCtia2NzL2xW?=
 =?utf-8?B?dzMra1JmbFM4Y1JIWnRoRXRsMEFqY09Rc3JNQ0RqSmczWTNxRTlNblZsQTN0?=
 =?utf-8?B?WjdzNHVMSVQyVHB1MkFPUUZYL0lwZVRDVVA4NW8yZk1zVzZsNGVvY1Jac0F1?=
 =?utf-8?B?LzhIZDJwZXRyYzlpa2owVTk4VGl4THArTTNicGVxTWxXVlFISmh3WEFWYjJQ?=
 =?utf-8?B?MXQ2M3JyTTRGVkFJWlk1REdDUHB1U1BsSW9DdUhwT3g3cUJWbUpRb2ZxN3px?=
 =?utf-8?B?SlcwL09OZS9ERjZRa0hjS043N3Y2a3MxelpYWHQ0ejhibzlnbDY5dUxDN1Bs?=
 =?utf-8?B?U1g2ckUxS3VXS1NuVm1EVDBlWGVqWGN5Y002ejhGVzdwS2V0ZU5QN2gvYkNl?=
 =?utf-8?B?eThGQXA1RUh0cWxaRG9mZnlVaXJDbjBZR0VHblhleTI5blFGWWYwTTVCWDJI?=
 =?utf-8?B?QTVNU2tKZEpuWmxFZmYwcndyR011d09pc1BBeTZhWnVJQkJJSkFDOGtJUGxn?=
 =?utf-8?B?dGpNblgvZG13WXRCRzJmNmlEUFBUSWpDaGdHNGFvQys3djJWVnRpQVg5OEFX?=
 =?utf-8?B?ZWJEZFBQNVlvMnVQSy8zZ2M5UFZaWk0zaDFBWDNRMENoRU5oUHY1c2d4dkVB?=
 =?utf-8?B?K1VlcjV2QjlWWmVrSWtReWVaYW92b3dIVXY2Rnd6Z3Z4TGxtaTU3NEVUeHN3?=
 =?utf-8?B?d2p3NWdONisxN1hMUHJ3S1VmODJodTVqWk9zMzRaNGZERlJnRk8vclNEbnpy?=
 =?utf-8?B?Z1pSbGp5KzJPNWd3ZmRZeVdpNmpsSzdXYlFVNzVLSWdSM2hMYXB4Q2twYUM2?=
 =?utf-8?B?dzljeUtndFFMVTZCdGp1UU9FYXdpR2o5YWwxekkyT3VsUkkvZW5yanhjS2xw?=
 =?utf-8?B?b0I5WEs5cmoyd25LdzlPUkZOejhmdHQ1QW8rbkR4a1VOS3dtV2w1T3FUZG94?=
 =?utf-8?B?V1dPdGVuQnB1aFN4MjF3RHlveTBxQlRmOGpVRkhQRFZUcEV0Y0w4cVBpNElN?=
 =?utf-8?B?MHg3YnQ3UHAySG1tU0tNdzJUZnlnYUlvVGhwQkEvS1hxckxPb2RnV1pSK3Fl?=
 =?utf-8?B?alpyZzBvb05CRnllSTJVdzU5T3hQTnNoa01taGVTek9PQkswbERheFZ2dzJm?=
 =?utf-8?B?dEdPNU83elpObHJWNzM4dTlvcWJCWkNRNVhaRkpPMW8vYk0ycXMxVTlkcDRC?=
 =?utf-8?B?UUQrRDZ3R3F4R2dFVWRCWnMyU3BYM3F5NkNnc2dCNytZcjU1bUpCOWZ0d2lR?=
 =?utf-8?B?N2RrT1ppd3loa2w2SnFwZFQ1TlVvZFRwdVFZRU5wR2lwUFllQmFQS0ZUQzNo?=
 =?utf-8?B?NVdwVkhMZlBpNStzT1U2OUFNK2oxMzhFNDIrRWhwYkQvNzJGQTk1TzRtdklD?=
 =?utf-8?B?dE9PbE92YXI5N1lyMmZCWVdyTy9HSEQrM3lhbHhNOUpncXErRTVEM090aDJy?=
 =?utf-8?B?VWJhMU4vc3N2TTcyT1M4c2MxekltUmJnbXpSM1pNWWJKZTNBZUVsVzN5VWd0?=
 =?utf-8?B?VXBtOUUxSVNEc21yNEh2eUlKYWh5SnllVGdoekJDNVFNdmtsNWJUcHBscm5q?=
 =?utf-8?B?TkxaOFBpSE1vdjRrL1RyaVJTWTNQeEZFNEpDNVZleUtRc0xvK2wxS09BOTJ3?=
 =?utf-8?B?L1pCZHZMdkdiR2ZnK1p0dEZhcGRZczdJczB1eDdna3M2d2VFSVlWdERZdnE2?=
 =?utf-8?B?S0ZHeEs4eVdoTWNSUWVUUFA4YnBsRzN6RmtBWi9QMjVzamJQaUhMWVltY3ZB?=
 =?utf-8?B?VWdGTXk1UlJQWXpwNnNXdEg1ZFhXTVgrYWphVU43VUFIS1FkTVRYWEtGdjR4?=
 =?utf-8?B?dXcyTGNoYUZYVFlTS2hHNFJFTlhlclB6TUR1dGM2Y2dsT3dFdDIzY0loNVk5?=
 =?utf-8?B?Njk2cHhlSzNzRDk1VWwvMDUwN3NrUmQvQ3JjeGNjRjN4amt5RnNhZVJwWEwy?=
 =?utf-8?B?TVYzTkY1QTdnNEdOYUNmRm1DZ1N5SzBFaTZkTjlZRW96N3dEemc5RzkrMVZS?=
 =?utf-8?B?bzgvZ0haMGxMc0ttUHp6cVJMUGlFRXB2SjE4R2MwUkkvU2tkTHdqbnRpYlNG?=
 =?utf-8?B?VFp2WFR5N1N3dTBSaEpyTS80U0F1OFFoNlBaSlhBb0cvVzZzK2hvWnZFbWEz?=
 =?utf-8?B?eUN4Q25WVFQydXVVSzlmZ3NuL2J4OFp0T25xMVhrQzhrNkJYcmhWbVJqQTFX?=
 =?utf-8?Q?s/Ydwois7cqDk2qO8H/cR+/H5OLbmn4KAta49am2T2tf?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5881397ACD1A9442B7B45570DFB29AB6@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a67e323c-eb06-4344-dc1e-08d9ed5348e9
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Feb 2022 11:40:21.0208
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: c6YMl99caM+32qkVjLy6gIYGRbnP625QIlDREwGHM2c0CALVeu00Xi+4C0fys25km/a/fJcsWqpvqF5Z8iokbQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3199
X-Spam-Status: No, score=1.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,SUSPICIOUS_RECIPS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

T24gMi8xMC8yMiAxMDoxMSBQTSwgRXJpYyBCaWdnZXJzIHdyb3RlOg0KPiBGcm9tOiBFcmljIEJp
Z2dlcnMgPGViaWdnZXJzQGdvb2dsZS5jb20+DQo+IA0KPiBUcmFkaXRpb25hbGx5LCB0aGUgY29u
ZGl0aW9ucyBmb3Igd2hlbiBESU8gKGRpcmVjdCBJL08pIGlzIHN1cHBvcnRlZA0KPiB3ZXJlIGZh
aXJseSBzaW1wbGU6IGZpbGVzeXN0ZW1zIGVpdGhlciBzdXBwb3J0ZWQgRElPIGFsaWduZWQgdG8g
dGhlDQo+IGJsb2NrIGRldmljZSdzIGxvZ2ljYWwgYmxvY2sgc2l6ZSwgb3IgZGlkbid0IHN1cHBv
cnQgRElPIGF0IGFsbC4NCj4gDQo+IEhvd2V2ZXIsIGR1ZSB0byBmaWxlc3lzdGVtIGZlYXR1cmVz
IHRoYXQgaGF2ZSBiZWVuIGFkZGVkIG92ZXIgdGltZSAoZS5nLA0KPiBkYXRhIGpvdXJuYWxsaW5n
LCBpbmxpbmUgZGF0YSwgZW5jcnlwdGlvbiwgdmVyaXR5LCBjb21wcmVzc2lvbiwNCj4gY2hlY2tw
b2ludCBkaXNhYmxpbmcsIGxvZy1zdHJ1Y3R1cmVkIG1vZGUpLCB0aGUgY29uZGl0aW9ucyBmb3Ig
d2hlbiBESU8NCj4gaXMgYWxsb3dlZCBvbiBhIGZpbGUgaGF2ZSBnb3R0ZW4gaW5jcmVhc2luZ2x5
IGNvbXBsZXguICBXaGV0aGVyIGENCj4gcGFydGljdWxhciBmaWxlIHN1cHBvcnRzIERJTywgYW5k
IHdpdGggd2hhdCBhbGlnbm1lbnQsIGNhbiBkZXBlbmQgb24NCj4gdmFyaW91cyBmaWxlIGF0dHJp
YnV0ZXMgYW5kIGZpbGVzeXN0ZW0gbW91bnQgb3B0aW9ucywgYXMgd2VsbCBhcyB3aGljaA0KPiBi
bG9jayBkZXZpY2UocykgdGhlIGZpbGUncyBkYXRhIGlzIGxvY2F0ZWQgb24uDQo+IA0KPiBYRlMg
aGFzIGFuIGlvY3RsIFhGU19JT0NfRElPSU5GTyB3aGljaCBleHBvc2VzIHRoaXMgaW5mb3JtYXRp
b24gdG8NCj4gYXBwbGljYXRpb25zLiAgSG93ZXZlciwgYXMgZGlzY3Vzc2VkDQo+IChodHRwczov
L2xvcmUua2VybmVsLm9yZy9saW51eC1mc2RldmVsLzIwMjIwMTIwMDcxMjE1LjEyMzI3NC0xLWVi
aWdnZXJzQGtlcm5lbC5vcmcvVC8jdSksDQo+IHRoaXMgaW9jdGwgaXMgcmFyZWx5IHVzZWQgYW5k
IG5vdCBrbm93biB0byBiZSB1c2VkIG91dHNpZGUgb2YNCj4gWEZTLXNwZWNpZmljIGNvZGUuICBJ
dCBhbHNvIHdhcyBuZXZlciBpbnRlbmRlZCB0byBpbmRpY2F0ZSB3aGVuIGEgZmlsZQ0KPiBkb2Vz
bid0IHN1cHBvcnQgRElPIGF0IGFsbCwgYW5kIGl0IG9ubHkgZXhwb3NlcyB0aGUgbWluaW11bSBJ
L08NCj4gYWxpZ25tZW50LCBub3QgdGhlIG9wdGltYWwgSS9PIGFsaWdubWVudCB3aGljaCBoYXMg
YmVlbiByZXF1ZXN0ZWQgdG9vLg0KPiANCj4gVGhlcmVmb3JlLCBsZXQncyBleHBvc2UgdGhpcyBp
bmZvcm1hdGlvbiB2aWEgc3RhdHgoKS4gIEFkZCB0aGUNCj4gU1RBVFhfSU9BTElHTiBmbGFnIGFu
ZCB0aHJlZSBmaWVsZHMgYXNzb2NpYXRlZCB3aXRoIGl0Og0KPiANCj4gKiBzdHhfbWVtX2FsaWdu
X2RpbzogdGhlIGFsaWdubWVudCAoaW4gYnl0ZXMpIHJlcXVpcmVkIGZvciB1c2VyIG1lbW9yeQ0K
PiAgICBidWZmZXJzIGZvciBESU8sIG9yIDAgaWYgRElPIGlzIG5vdCBzdXBwb3J0ZWQgb24gdGhl
IGZpbGUuDQo+IA0KPiAqIHN0eF9vZmZzZXRfYWxpZ25fZGlvOiB0aGUgYWxpZ25tZW50IChpbiBi
eXRlcykgcmVxdWlyZWQgZm9yIGZpbGUNCj4gICAgb2Zmc2V0cyBhbmQgSS9PIHNlZ21lbnQgbGVu
Z3RocyBmb3IgRElPLCBvciAwIGlmIERJTyBpcyBub3Qgc3VwcG9ydGVkDQo+ICAgIG9uIHRoZSBm
aWxlLiAgVGhpcyB3aWxsIG9ubHkgYmUgbm9uemVybyBpZiBzdHhfbWVtX2FsaWduX2RpbyBpcw0K
PiAgICBub256ZXJvLCBhbmQgdmljZSB2ZXJzYS4NCj4gDQo+ICogc3R4X29mZnNldF9hbGlnbl9v
cHRpbWFsOiB0aGUgYWxpZ25tZW50IChpbiBieXRlcykgc3VnZ2VzdGVkIGZvciBmaWxlDQo+ICAg
IG9mZnNldHMgYW5kIEkvTyBzZWdtZW50IGxlbmd0aHMgdG8gZ2V0IG9wdGltYWwgcGVyZm9ybWFu
Y2UuICBUaGlzDQo+ICAgIGFwcGxpZXMgdG8gYm90aCBESU8gYW5kIGJ1ZmZlcmVkIEkvTy4gIEl0
IGRpZmZlcnMgZnJvbSBzdHhfYmxvY2tzaXplDQo+ICAgIGluIHRoYXQgc3R4X29mZnNldF9hbGln
bl9vcHRpbWFsIHdpbGwgY29udGFpbiB0aGUgcmVhbCBvcHRpbXVtIEkvTw0KPiAgICBzaXplLCB3
aGljaCBtYXkgYmUgYSBsYXJnZSB2YWx1ZS4gIEluIGNvbnRyYXN0LCBmb3IgY29tcGF0aWJpbGl0
eQ0KPiAgICByZWFzb25zIHN0eF9ibG9ja3NpemUgaXMgdGhlIG1pbmltdW0gc2l6ZSBuZWVkZWQg
dG8gYXZvaWQgcGFnZSBjYWNoZQ0KPiAgICByZWFkL3dyaXRlL21vZGlmeSBjeWNsZXMsIHdoaWNo
IG1heSBiZSBtdWNoIHNtYWxsZXIgdGhhbiB0aGUgb3B0aW11bQ0KPiAgICBJL08gc2l6ZS4gIEZv
ciBtb3JlIGRldGFpbHMgYWJvdXQgdGhlIG1vdGl2YXRpb24gZm9yIHRoaXMgZmllbGQsIHNlZQ0K
PiAgICBodHRwczovL2xvcmUua2VybmVsLm9yZy9yLzIwMjIwMjEwMDQwMzA0LkdNNTk3MjlAZHJl
YWQuZGlzYXN0ZXIuYXJlYQ0KPiANCj4gTm90ZSB0aGF0IGFzIHdpdGggb3RoZXIgc3RhdHgoKSBl
eHRlbnNpb25zLCBpZiBTVEFUWF9JT0FMSUdOIGlzbid0IHNldA0KPiBpbiB0aGUgcmV0dXJuZWQg
c3RhdHggc3RydWN0LCB0aGVuIHRoZXNlIG5ldyBmaWVsZHMgd29uJ3QgYmUgZmlsbGVkIGluLg0K
PiBUaGlzIHdpbGwgaGFwcGVuIGlmIHRoZSBmaWxlc3lzdGVtIGRvZXNuJ3Qgc3VwcG9ydCBTVEFU
WF9JT0FMSUdOLCBvciBpZg0KPiB0aGUgZmlsZSBpc24ndCBhIHJlZ3VsYXIgZmlsZS4gIChJdCBt
aWdodCBiZSBzdXBwb3J0ZWQgb24gYmxvY2sgZGV2aWNlDQo+IGZpbGVzIGluIHRoZSBmdXR1cmUu
KSAgSXQgbWlnaHQgYWxzbyBoYXBwZW4gaWYgdGhlIGNhbGxlciBkaWRuJ3QgaW5jbHVkZQ0KPiBT
VEFUWF9JT0FMSUdOIGluIHRoZSByZXF1ZXN0IG1hc2ssIHNpbmNlIHN0YXR4KCkgaXNuJ3QgcmVx
dWlyZWQgdG8NCj4gcmV0dXJuIGluZm9ybWF0aW9uIHRoYXQgd2Fzbid0IHJlcXVlc3RlZC4NCj4g
DQo+IFRoaXMgY29tbWl0IGFkZHMgdGhlIFZGUy1sZXZlbCBwbHVtYmluZyBmb3IgU1RBVFhfSU9B
TElHTi4gIEluZGl2aWR1YWwNCj4gZmlsZXN5c3RlbXMgd2lsbCBzdGlsbCBuZWVkIHRvIGFkZCBj
b2RlIHRvIHN1cHBvcnQgaXQuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBFcmljIEJpZ2dlcnMgPGVi
aWdnZXJzQGdvb2dsZS5jb20+DQo+IC0tLQ0KDQoNCkkndmUgYWN0dWFsbHkgd29ya2VkIG9uIHNp
bWlsYXIgc2VyaWVzIHRvIGV4cG9ydCBhbGlnbm1lbnQgYW5kIA0KZ3JhbnVsYXJpdHkgZm9yIG5v
bi10cml2aWFsIG9wZXJhdGlvbnMsIHRoaXMgaW1wbGVtZW50YXRpb24NCm9ubHkgZXhwb3J0aW5n
IEkvTyBhbGlnbm1lbnRzIChtb3N0bHkgUkVRX09QX1dSSVRFL1JFUV9PUF9SRUFEKSB2aWENCnN0
YXguDQoNClNpbmNlIGl0IGlzIGNvbWluZyBmcm9tIDotDQpiZGV2X2xvZ2ljYWxfYmxvY2tfc2l6
ZSgpLT5xLT5saW1pdHMubG9naWNhbF9ibG9ja19zaXplIHRoYXQgaXMgc2V0IHdoZW4NCmxvdyBs
ZXZlbCBkcml2ZXIgbGlrZSBudm1lIGNhbGxzIGJsa19xdWV1ZV9sb2dpY2FsX2Jsb2NrX3NpemUo
KS4NCg0KIEZyb20gbXkgZXhwZXJpZW5jZSBlc3BlY2lhbGx5IHdpdGggU1NEcywgYXBwbGljYXRp
b25zIHdhbnQgdG8NCmtub3cgc2ltaWxhciBpbmZvcm1hdGlvbiBhYm91dCBkaWZmZXJlbnQgbm9u
LXRyaXZpYWwgcmVxdWVzdHMgc3VjaCBhcw0KUkVRX09QX0RJU0NBUkQvUkVRX09QX1dSSVRFX1pF
Uk9FUy9SRVFfT1BfVkVSSUZZICh3b3JrIGluIHByb2dyZXNzIHNlZQ0KWzFdKSBldGMuDQoNCkl0
IHdpbGwgYmUgZ3JlYXQgdG8gbWFrZSB0aGlzIGdlbmVyaWMgdXNlcnNwYWNlIGludGVyZmFjZSB3
aGVyZSB1c2VyIGNhbg0KYXNrIGZvciBzcGVjaWZpYyBSRVFfT1BfWFhYIHN1Y2ggYXMgZ2VuZXJp
YyBJL08gUkVRX09QX1JFQUQvUkVRX09QX1dSSVRFDQphbmQgbm9uIGdlbmVyaWMgUkVRX09QX1hY
IHN1Y2ggYXMgUkVRX09QX0RJU0NBUkQvUkVRX09QX1ZFUklGWSBldGMgLi4uLg0KDQpTaW5jZSBJ
J3ZlIHdvcmtlZCBvbiBpbXBsZW1lbnRpbmcgUkVRX09QX1ZFUklGWSBzdXBwb3J0IEkgZG9uJ3Qg
d2FudCB0bw0KaW1wbGVtZW50IHNlcGFyYXRlIGludGVyZmFjZSBmb3IgcXVlcnlpbmcgdGhlIFJF
UV9PUF9WRVJJRlkgb3IgYW55IG90aGVyDQpub24tdHJpdmlhbCBSRVFfT1BfWFhYIGdyYW51bGFy
aXR5IG9yIGFsaWdubWVudC4NCg0KLWNrDQoNClsxXSBodHRwczovL3d3dy5zcGluaWNzLm5ldC9s
aXN0cy9saW51eC14ZnMvbXNnNTY4MjYuaHRtbA0KDQo=

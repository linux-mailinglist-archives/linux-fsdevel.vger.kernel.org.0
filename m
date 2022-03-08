Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 175714D2427
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Mar 2022 23:20:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240452AbiCHWVD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 8 Mar 2022 17:21:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232983AbiCHWVC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 8 Mar 2022 17:21:02 -0500
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2087.outbound.protection.outlook.com [40.107.237.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A88B33EBA;
        Tue,  8 Mar 2022 14:20:03 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Nx/wMytK8EazWo9MDxsu7Mjjr0LnP+V5hCk9uAWGTxed11rBG7uIRzh3cTWt9OxxMimvvEARZTNrkZKkRy0z6pz7T4/yjZh6/XYPSOOfizW0vfs9DDaLfogUwbO6jhyNX6G9CVxMeb5/k8TbXNSzgdq81Hwp7YLL+IYMh1vybrn/tVt/ttldtSEa3l1Pabrmaj9DlS518OxA1tLBQZxcnUzNcVY990swztvH66Ce74dnzlSNHGiagaMln6fdGG8C5PxWOcCyIhqR4yIHI6pa9ACTsz1dCtFytfU7QkUrR8EUmliSYwn3EphJi5tx1jZl8yjAla0of/44Er2edK/LqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mNpKGJaxiKTMhklO1+jow3Zb8WxwbiDuHsXsaeJfJ6k=;
 b=Wd1p3HppjjPHaAllSzX4GnXTX3BWNIuL1PY/ikhArBff+TbOu/TXuMHtb8osxxBv3ah+5OxUuLgYIoXc/PSsdh2zyPgBv8UMAKosAN3wjS8Os6aCRg9IBXU5L/JhNNQ4d4GtftxL7yDoYw8iI9NKj0YKBVuoNtiGH1y1eAdsJibqFA+h1N5ntVBmIHWiGh5M8+3xRZKYO6CcBHiXmw2Swo0OQFZdRuJpK5AtrEkLwWgpwiJChdZ8YDcYvI7Q1/34m9Xk0f1HuG6HlNlaHxGNEv5DoMU375yz0vOe4XHdcGoZAQxXpPydxH/57JHKn9Sux/FD+lhCeyuG1Uzm53FURA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mNpKGJaxiKTMhklO1+jow3Zb8WxwbiDuHsXsaeJfJ6k=;
 b=Pb9X5RhnRPX6/izavSB7tYz3bu7WUNmkv8GGEh7AOTFDc0oCdfOl21F78n8bdBR3JVeJq22G9V0OVM7vPs9lzyvd4jGJvjxODYQ1FMHN9TMCXVhq6c01eDc0VYbJgZ8ICPEvG0MRrpN8aNIFfOFZ43ShUHYOmPOPz5dYOPCzQweP0a73OR7LedaVOhvzAN7aBPkNRwTkEAsdzrPJgfjwjEvWvkQa2V1OcQ7qeMy9E82QPyVDU7/+rQLUOL6pGSqUNYJnvV7s+NkNgn6TIBo6L104JZH4Z2Gcr0j6bHGdHNwCOUeapO9+soUL0ZVns6Zqif8+Sz/derZavCi1PhZ12Q==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by MWHPR12MB1309.namprd12.prod.outlook.com (2603:10b6:300:10::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Tue, 8 Mar
 2022 22:20:01 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::204b:bbcb:d388:64a2]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::204b:bbcb:d388:64a2%4]) with mapi id 15.20.5038.027; Tue, 8 Mar 2022
 22:20:01 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Christoph Hellwig <hch@lst.de>, "axboe@kernel.dk" <axboe@kernel.dk>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH 2/2] fs: remove fs.f_write_hint
Thread-Topic: [PATCH 2/2] fs: remove fs.f_write_hint
Thread-Index: AQHYMrKNUYKLJxnFgEClNe/9RFVXday2D+cA
Date:   Tue, 8 Mar 2022 22:20:01 +0000
Message-ID: <3ffdbd55-e128-74e5-33bc-f5c5b487b206@nvidia.com>
References: <20220308060529.736277-1-hch@lst.de>
 <20220308060529.736277-3-hch@lst.de>
In-Reply-To: <20220308060529.736277-3-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ba269f40-2672-46d5-2017-08da0151c98d
x-ms-traffictypediagnostic: MWHPR12MB1309:EE_
x-microsoft-antispam-prvs: <MWHPR12MB13090F2C9708E32C58792414A3099@MWHPR12MB1309.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: iE9k4WXm8O/AkrZge6ahSEKitHtw3MqPNCP3B9qp6Fmb+/qHFoBuY+Kj1sIphkgK5lYvzEbdIhjllFVSEFQQ8DNmh3cZu8BFMsBvsUQy81OXzlDdKmHN2+7mLsqXQQlGEH9kxsAfGxfFVWH5k1J3YuhBVSS7tQR0lrnpP0xUyAelA9NvPmD3hHVvyAlEVI4/msdvUmJmx+zYgkvvQPHxLx4liJU4k0gPS6Nk9VwUQx/lSWrSF0VAnbIMrJptndc5JYQ+k20kYrwYT2OzPCJRHmToZ4nfxDd5ArIhTCe5znreiwlUmoqw3kZ7aFy0VP9f+Vi3ofmaeDPSJF7y/Tr1iN5L9oZCCtEN9PCooWa62z0HOFfLgnSnpNFQ0g1Q7eCJu+RXMthWeWyzL/24GXz2qsalKuxNSbwakf5RC1Gie2Qt+3+3Pg9aZm15iKr0i1Tbr0ScJDlQ3dNJcYHcLn8ws5jfenZoi86gLbDjRRZj0q3Ok5OHe7ldI3wGElCv4lUY/XyWWfeR4Pe11eg86GcTJQ0ffFyXocPlInb/fp9GFARQNk60eV9bL1T7fvJnpyi5MAyMXBSQ58Mye3RMdQ2/6hWt6h4JnfaVUWCzdbW7fRnpoIt6N8XZobATXOVOHIhD3WIHo/GwrDbadG75lNi41tzEGMCOYGCkWiv+BBIWqh1IS5m8XSH+NYllSGchG95ZwG2PtA5gZS2ae7OXMVt40nv8K1/9jpQ2M1I7VtZ7ikQNv9Qh6M/JEZFHhVvn9BuiR6JpZ8O369f5j2Uw2/oFKw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6512007)(2906002)(86362001)(6486002)(71200400001)(26005)(186003)(38100700002)(316002)(54906003)(110136005)(2616005)(4744005)(122000001)(31696002)(66446008)(66476007)(8676002)(64756008)(66946007)(76116006)(4326008)(66556008)(38070700005)(508600001)(91956017)(53546011)(31686004)(36756003)(5660300002)(8936002)(6506007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?c0FORVdCRGkxWlJnODh0MHhsMms0SFVQZThsMi9zaytwODZYcjRmS3dleXZ4?=
 =?utf-8?B?MGNhRzZEd0ZwUjIybW9WWGl3QjM0U2Jia05DSENTMC80TndXTUhSa2duOEFR?=
 =?utf-8?B?ZldBV1NzcmdrRnNLVW1GbVpYNTF0aDhmRFBIMGpqTUdRZVU5R1FxRGVNbEN0?=
 =?utf-8?B?ek1lVU1jN1VvSkFNd0VwMkx4TytvY0V0VmUwSEVsNWxoZFgyOVZjYWRPcFZs?=
 =?utf-8?B?aXZDYXlsVGoybjV2aUo1WGhkNmtsb3NNenRvMWlQalE5MllBekp5blJmV0Rh?=
 =?utf-8?B?bStOWlgra3Brc2RKZEhqWTFhZFFnZUJFaFpyRGVqN3hKcys0eWVkOWVwQnM5?=
 =?utf-8?B?SzRSeU9WcFl2a2U5Nno1RUQrUU5ZcTVxQTJCYTU3amF4aGhhcWhYMU94d1Ux?=
 =?utf-8?B?MUVHalo0T01MNFprbnJZNjMrVk84aHZMaDd1ZlU5bkVUMjFwQUk0emMra3pT?=
 =?utf-8?B?Q2s1RVZIK0p2ZytrZEY2WnFIMXQwVUUwL05QbVFZR2NxQVdCSEZ5eTltTFVm?=
 =?utf-8?B?czlEM2ZQY1JsaWk1dWNHSzE0WmREWlNJZmQzZFJ1ZWVVRTBrd1BoUTVTYktt?=
 =?utf-8?B?c24zUkJNN1l6SkVrUHQ0cVRRMTNaeEU0VHhpZVJSVyt2d09BMzFJbWpHMkRk?=
 =?utf-8?B?bmg3WVpPVU01dnV2REhpa1p1SnNqSmRzTXdRYkdIM0k5N3BXdFYwUmx0cVpC?=
 =?utf-8?B?VXdMMmJzRDlEcW1QTVlTaFQxb2g2aWJvYVpaUnExN3JYd3FwbXpwLzhJUUc4?=
 =?utf-8?B?RFNub3R6WnRyYUhDRHJKRHh4Z3M0aHVYMnhzVTZncUJUTDJMajcvaW1YelFS?=
 =?utf-8?B?MlorUDBkV0w4VWEyRTlXSmM2aTdVaCs3cjhyM3RLellLVGhVMURvcWMyUkRK?=
 =?utf-8?B?UUROMUZ1czIwTThPTDRxVkhUSU04L0c1eVFqTG1ETloza3dyNlJSVGo4TS85?=
 =?utf-8?B?S3c2T3pGQzMveEJleGpOQVczY2lwbWZablpXRUZCeHhDbTMxQVgzTjZHeFY5?=
 =?utf-8?B?VTZKWkcwU2liS3lpSHEvZ1JBQVZTeGhkN1ExSlFVMTlDb2lnNGtPV3dSMy9z?=
 =?utf-8?B?VTFnNW9YVUVlc0tGclFOMFZrZkRJVWpjekU3Z2NMd3FvQ0grSUVvQTVycmk3?=
 =?utf-8?B?OWJCdzZCWi9lZVNvK1cwWVhuamlneDdKdUlIR1VLRDEzazg2N3dsZXJOZHFk?=
 =?utf-8?B?QlpUbUxlaExJQVNSR3JYbnltazQxU2NiS2tMWnZpWC9ucUVCd2xYQ3VjdmFl?=
 =?utf-8?B?WjU1M0ZjMTdmVWtMUndFUlRPM3Z3dmVaMzBvcG0xc0Y1ZU56MmVqNUQ3ZTFw?=
 =?utf-8?B?bUQvNW55eDlvNlB0NUt4dHYyd2lIdzd2dVBJVEJiQ1d5WWNQQ3k1SHNiRUtR?=
 =?utf-8?B?UlZiQVNGNUpNWDhLbHZTbUZ2ODNhNlA1QTFjQ0g3eE5lTzltTkdtRTJuQmIr?=
 =?utf-8?B?SWRBZUppaW03bTNueTd5NTd3eEJXY09ZWHMyL1E1eDNEMXdlcGE5Q2ZyN0FB?=
 =?utf-8?B?emhDanl1aEJ1WVRNUHY0aW9TemNnSFpaRGMvNXZmQ2NhOS83R3ZoWkxXWGdI?=
 =?utf-8?B?RkNPRmVKYVMxZ0J6dVdKcytWS1hPY05mb3VzN05OclNRbVc2UmlBaElqekUz?=
 =?utf-8?B?dkREMjhnRC85RUJHY1pXd1BrZWJ5K1ZvZTFWbG1Cc2oyWncyZVV4cENrakcz?=
 =?utf-8?B?bnVpek1mdkFCb2dYWE9UK2pJY2JwRUlLSC9md1YzUDdPSXdaOEpuWlpBeWNS?=
 =?utf-8?B?TGtobTNaVlZQeFE1aEUxSWdiU29FYldORVVkOEFjcE8rb2VaUm1LRjhZbzY0?=
 =?utf-8?B?eUlNQjBYWkVvT3VsMTg4K0RiWjA4VERlQUxscG0yb1RSQ0hZcUJRaWZpS25O?=
 =?utf-8?B?NnYybzFnVTk5V3JIVCtnUEVyN0VmeXZPcy9SRjM1VDYyeG55NWx0MVBsa0cy?=
 =?utf-8?B?L01IbEZObUpZbVZLb0FwZ3Jud0dIUDZHcUdBOHJUQlhVU1BqVkM2WlBWbHM4?=
 =?utf-8?B?bXoxdlBPbTJ0eWd1M0U4Rk54V0NET2QxUkZiZ1JFRUZ5dzdXbzByanR6M2h6?=
 =?utf-8?B?dy9ncUR4K1FqbXlBamtwZ1o4ZGJFWlRYTFVhNXFSWFZjUmNmZUZudWg0UmtR?=
 =?utf-8?B?SW0yN0EwZ0hISGw0eUFGQmE1SG9NMkk5Y29Oa3podGdYOVBUeXRRcHpIUncv?=
 =?utf-8?B?clE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9C51019EFA09B444AE9BDBE7084BF28B@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba269f40-2672-46d5-2017-08da0151c98d
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2022 22:20:01.0857
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NdYN/YKZolq4GRg0rIFL0Skt13300vkP35Nwej7Rw43ahazdbgG4/bPSHLbebULGv1rcO+PB0COeA8TQpcRMjg==
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

T24gMy83LzIyIDIyOjA1LCBDaHJpc3RvcGggSGVsbHdpZyB3cm90ZToNCj4gVGhlIHZhbHVlIGlz
IG5vdyBjb21wbGV0ZWx5IHVudXNlZCBleGNlcHQgZm9yIHJlcG9ydGluZyBpdCBiYWNrIHRocm91
Z2gNCj4gdGhlIEZfR0VUX0ZJTEVfUldfSElOVCBpb2N0bCwgc28gcmVtb3ZlIHRoZSB2YWx1ZSBh
bmQgdGhlIHR3byBpb2N0bHMNCj4gZm9yIGl0Lg0KPiANCj4gVHJ5aW5nIHRvIHVzZSB0aGUgRl9T
RVRfRklMRV9SV19ISU5UIGFuZCBGX0dFVF9GSUxFX1JXX0hJTlQgZmNudGxzIHdpbGwNCj4gbm93
IHJldHVybiBFSU5WQUwsIGp1c3QgbGlrZSBpdCB3b3VsZCBvbiBhIGtlcm5lbCB0aGF0IG5ldmVy
IHN1cHBvcnRlZA0KPiB0aGlzIGZ1bmN0aW9uYWxpdHkgaW4gdGhlIGZpcnN0IHBsYWNlLg0KPiAN
Cj4gU2lnbmVkLW9mZi1ieTogQ2hyaXN0b3BoIEhlbGx3aWcgPGhjaEBsc3QuZGU+DQo+IC0tLQ0K
PiAgIGZzL2ZjbnRsLmMgICAgICAgICB8IDE4IC0tLS0tLS0tLS0tLS0tLS0tLQ0KDQp0aGlzIGZv
bGxvd3MgdGhlIGRpc2N1c3Npb24gb24gdGhlIG90aGVyIHRyZWFkIG9mIHJldHVybmluZyBFSU5W
QUwuDQoNCkxvb2tzIGdvb2QuDQoNClJldmlld2VkLWJ5OiBDaGFpdGFueWEgS3Vsa2FybmkgPGtj
aEBudmlkaWEuY29tPg0KDQoNCg==

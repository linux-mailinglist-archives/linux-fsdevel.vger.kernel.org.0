Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E850D4B24B0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Feb 2022 12:46:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349570AbiBKLpX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 11 Feb 2022 06:45:23 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:58142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230229AbiBKLpW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 11 Feb 2022 06:45:22 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2066.outbound.protection.outlook.com [40.107.94.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C0E1EAC;
        Fri, 11 Feb 2022 03:45:21 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yb608LqeKvKglKw0BYE+LWkwmBkbm98SkXkYYV/u69fR+8xsTDq2YHJYn867B6UqL1vWflHLjCuHyJBCbUNUuwc5x0hUHKXrD5IuphdxLMsiu6mO6dhD2ddNCwqqXmkL7cdqWgvUH3jHUmM9EKtCM7c3fx/qnf4rzkvCJOU04EUz0JF6ZRyb04BAyzmJBDLmle69h1xiCgwdd+ialbgsfsJQNyMEM/GfD2X+J6k2QlG8OBoa0yGYWZN17OiEZEqkOtHnOI9/GdSSDKTQ2yiCf6Gg6iBnZEMUq9nquHrf6BF0jIiG/dLfQS17iOVFEu/TtGhyhtOT4oIfHtBheGRHYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CiaFfQsOw48CZUS9v+aqmHUrZlkrbGprBvfhRiOylys=;
 b=HEqlc3L23QCJwuDz5YtuRO09X/L9XGn/k3Vhs+36sYRDAcMPGFf1xAFEL7LfNc7rYlkgeN4mIacOqagbA3SmnChvAiRriC3PUKVBbt/butAakId077vVOn12Lw4QrDRsF1fWLshGcFHVP/GClv6BJO3baBXzd71bkf8ERygpKqRnibvp6W7ZVe2Cr9BLmUI2caxI9vdA67d0XmoJksedV8XVvcUrUaykPZkExe/9X8/XEpQJSojRNJLeaKGgXKSgqYOnJQ13khaz9pK7nJT23uem3gjlRkgVSmt2aFY9Z6O0Njt76hYdWKY1KCtvldhe+lLwHvVLThRgxxFNOO2c/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CiaFfQsOw48CZUS9v+aqmHUrZlkrbGprBvfhRiOylys=;
 b=VLW54X9QKI/Kz4haMXtA4Azki7HShnyFSg64VFigbroFa7zPFhTRMAI4oFQ7rqCTfrUggAEcg72BxfSiVn2BRRcgpVmTHt0L9HkI+YRsYSkD3GHxsFkTHPOLa+YN3IcxmjuD7hDKYmnD22/2X11iFOV4V2crwJuLjOukdOUCQjCwzt0V/cIxYbqRC0euLVZJg0TU8oIXD2UcXfweNJbNOCax9QaMu9Kw5ZeJyP0yUGgpKd6/GVIEOX/osouy4uLZqqndD8asa4NkXq/12GYFQUsPD4JApUDYqMovjOa16PTPd5gN+4VGc7+SiVdY7iIPHRRGQn5GM9gulAu/XGqWwg==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by DM5PR12MB1883.namprd12.prod.outlook.com (2603:10b6:3:113::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.18; Fri, 11 Feb
 2022 11:45:19 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::846c:d3cd:5a30:c35]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::846c:d3cd:5a30:c35%5]) with mapi id 15.20.4951.019; Fri, 11 Feb 2022
 11:45:19 +0000
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
Thread-Index: AQHYHw6MhkvU3aWvQUef3qvKk4R/5KyOOi4AgAABZIA=
Date:   Fri, 11 Feb 2022 11:45:19 +0000
Message-ID: <b05c66c5-81fe-6398-416a-1dc9bdd3469a@nvidia.com>
References: <20220211061158.227688-1-ebiggers@kernel.org>
 <20220211061158.227688-2-ebiggers@kernel.org>
 <1762970b-94b6-1cd0-8ae2-41a5d057f72a@nvidia.com>
In-Reply-To: <1762970b-94b6-1cd0-8ae2-41a5d057f72a@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 42f44365-8ff4-47bc-5acc-08d9ed53faea
x-ms-traffictypediagnostic: DM5PR12MB1883:EE_
x-microsoft-antispam-prvs: <DM5PR12MB1883F5D77FAC84D9E52DE782A3309@DM5PR12MB1883.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:651;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bzpTvW5kj7tJgNyRc3/QymAwdoOFH0Biw9OznsLcD8iUhdvIHvNzL70kteqgpzxKEdKyeRQIBdnlMSk8ntZFQQMb3I+kxKrMp4SI28McVAYoCGf4rhJeBK1dLJeIviiV6Mm9mUmEv8/knVMQxs4F+h86shmUrvsKe1Ltx0gmy3eLU61AVNWCJmcpGxecVMycWkHaHV0dEP6XpQsQp6TBhkaFlCwTY2AX9xVR2EVV2ZOI/AwDphwm6pTdmJgQ2WRVMk78sx75tGSvfoVtq4rL3lLcL9KcyYKmQy1y+dXPGboXLTysr6hmniHHD4mKXbKJ+5NTbGL/bTny9M5sn8Y74T1m7g+5AfPAs8i9IvLeYPKJduTKX3/HviCw+F4dA5FKR80H0yI8PsP+EvsbjfWftq1oxcIfqh6YCkwv+am51uD7Ck+K4osUQ8Ll4WoQ248fiTsUaTlbvXbeHB64cOis4oc8kvmrD0rhf6XNdvbze4V6AVx2N6jZ32wukt3ax6AgbF6ko/LKOWoJv532wT+cjuXrUU3aVx1TjbydGp+JwYvWT/MQpDzVSia4lCuT+h8aagYrgIAS4anKFCipldTWoVpl1yurCMYnzd4isjUtitJLZ6QViuxm8ADLellzHgQP7vJH+c0IgJtuyAtuEkw4nYMO2SiBXFlTVrq3j1+omtdSIUT4oOAA5O/cGWGJiKQRDgbt8buCmNIACSdzWFdTy455d0oQS70nW379gEHTJA3redvBNlvWCseAykwZ3HdWZMmg+ekdj8PUCKhh4Ie+14HTcQz00wguUduwwR7PijADbG/EGgY4X0QM9fCDpTvlsE0uicuMqaOJyIcdjdpmy0+A+ZcFTh7l9RkekWkpjCIKdSt+iq6TeqF1pJ3vK1MQsSvKrjRVBIhfMVOB0MbvrVpaqT2e4/5EHuwdxOvm1T8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6486002)(966005)(2906002)(38070700005)(31696002)(186003)(53546011)(83380400001)(54906003)(71200400001)(508600001)(31686004)(316002)(45080400002)(6512007)(91956017)(64756008)(110136005)(86362001)(76116006)(66476007)(66446008)(5660300002)(66946007)(6506007)(36756003)(8936002)(38100700002)(4326008)(8676002)(2616005)(66556008)(122000001)(21314003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?c3lkL1JVK1hJTHBQZHZJd3AwaUJqaUk5VDgwcGY4RGNxQjEwYThEa0ZWQUNr?=
 =?utf-8?B?MEk3UWJZR2RPTjJuYWloZ2FUU09ZTzIzdktXYnhsM3dsSTR5ams5VnpTV0Na?=
 =?utf-8?B?T2RDTWVDZ2kvcjRmcTBiMDgvZnpNVDNwck5MajFLWlJ3dE5PWVFxRUxVRHNi?=
 =?utf-8?B?SitnS1NESVQ2bHlJQTgvN0JVbU5iU0duOHlrQ0xERVF5dERPWjJHck1hUzhH?=
 =?utf-8?B?S0IzUURlTC9KNmxuL25Zc3JpcVNQRUZrQWg1QzlPcEJ2QWs0TkhkeWtEZVZl?=
 =?utf-8?B?eFNXaWE1eC94a1hBWklRZzFwTXpEQkQzZEpGV2cxRFo1elpPZWV1dkdrUlB4?=
 =?utf-8?B?M0hTNmpHSTdpQmF5eVkxWHRqbGVTWnMxdEc0YWtkb3ZoMHNadXhCU0tHZzJ2?=
 =?utf-8?B?NTZWYndJYks2QnppSmdndklmcC9LdXczMkZPeFgxODM0bldMK00rL3daTG1U?=
 =?utf-8?B?NjJEZGxOZnpKQTc1clU1bElPUldiMEJoWUVBbVhFZjJtRjBGbGw3MVMxREtE?=
 =?utf-8?B?UExBMFNpQm90RnU4NXVjTFpBMXlIQVMweW43YWdlaUhHOFBJV0d4TTlHeWN1?=
 =?utf-8?B?QWNFKzhXUVpLbys0TzhMNVRsQmRkVUdRTmlXdHZMc1luSDcrN2oxeldzRUt4?=
 =?utf-8?B?a3hDWXFSVnE5QmpLbU52QlJZTEwwKzlrdVR3b2V3d2VQSStRRDRjSG1lM0Nw?=
 =?utf-8?B?UlNMSno3Z0VVTUdLS1BMb01jcDh6SUdIWXFWTE5vbmg1ZFVSUHdzVElpNFlS?=
 =?utf-8?B?cGd1US8vUXFGbXkyY0tGVUFsK2U4RXQ2a1RFZ0hsdjZWYWc2NUNqbGh5VDZS?=
 =?utf-8?B?TkFoWXRHUWE1Qm12NkdqZ0V4eGtRcGsycUxsOTkyRFAwRXdHMXFDSFk1Y2Yz?=
 =?utf-8?B?eEJCZmt4dXFCUFBjVUl6ZDE2dFN0ZXNmT0ZNQkl6cEt6dGZ0RG9KejY0VDQ0?=
 =?utf-8?B?N1k0Sm5WR1dzeml4VHNRR1QxUnJRK1pKc0YycXEzM2tOTEpwVXFzRjBnRkE4?=
 =?utf-8?B?cEVwYjZ4ZTZhK0p1U2xTcnQ1aWRjV3l2R1dFR28wRjZNNjFSMGo4Z0l2U2dQ?=
 =?utf-8?B?dVBjYzlzWnlJZ3BHS0ZlYktoOUFBR1JaOXRwUW9wZ3p4Vkt4MUFSZ2t6QkRN?=
 =?utf-8?B?eDUzMGZnbVN6ZlZkRlREWS9aN01ZZDRrc1RUSHJxQ0RKaEVHVVBlTFZJOVN3?=
 =?utf-8?B?K0dkaXFIZ1pQRVc0NGcxVGxzL0xQOVhyVHg4VjB1RFdCTGc4Mk1CVFN5aEYv?=
 =?utf-8?B?ektSVkxqMzBFdEh6VUw4ZEk5b0s0RmRaK0pyUzdkRlBQYUVUdHpqOGdkbGc4?=
 =?utf-8?B?SUlPcFZhNm8zSUdURFhza0pMLzUyaUEzbTh3eFpHd0hxT3cxcUoxQ1dMbUdm?=
 =?utf-8?B?a3ZEczdDSTd3V3Q2OFBWRFRvUUdHbktOb1h4akVhUTQvTk4yQ1ZvVGh0V1l3?=
 =?utf-8?B?NWxEWURQczJpLzN3ekYyL1VrUUJqRitseEt5TElwMWE4TElIVnlVaE5JQU1a?=
 =?utf-8?B?MmNuTnlQSlhIWEhJbExITEhSQTdUdzU4cTlRck1kYk9PRDRwRE1FYWJyNktG?=
 =?utf-8?B?YzRqeWsva1QzK3ZPWWVyc2FNWndic1RvVGovRWxycCtuQVp5cVlmMXduK1hL?=
 =?utf-8?B?VzNUSDFTa2s0blNDelVUdStnRHNyN21XTi9uSnRxZHkxSGEyZFV2T1EwenBI?=
 =?utf-8?B?R2w2em5Bc29IaXZtT1lMT0VUOS80TDR3dzdmREtXNTZ2aGpJbVp5VXluQmlG?=
 =?utf-8?B?alRzc1BEcFVTL0JRK1VMeHRrSXdvZHNnTER4ZEdpUlZ5VzZ0OFJoMFU1S2g4?=
 =?utf-8?B?NjIyM2FsdlFWV0t5ZkRFdHVyRWI1WFVWdm8wWEZaQ29hWW9sUGRLN2tWZ3p3?=
 =?utf-8?B?T0lmb3dLTmtuVFRMTTh2ekt6NktBY09Zd1kvNGJ2c3NJUnd3bndOTXNqOWRU?=
 =?utf-8?B?WFdDbXNjNXp3b1NKSWVYeEppRTl6dHVBb2FPYTNFdDNWU0o0bVY3Sy9Yem5l?=
 =?utf-8?B?dzJkUG56VWc5ekRubk9aTUJFRlZ3emtQNW8xNkltd2dBTlRPdnhodDkzSzEr?=
 =?utf-8?B?bzBBbVJLV2swUWZmWCsvalphc3FuZDRhdWJWTUgrNHR4UytORnRHY2hBd1d4?=
 =?utf-8?B?ZWZCWldmUVVmVWxGajNONGlpNVlKUGtYNlpTY0s0VWxtaDVVMFhzQnRVT0FQ?=
 =?utf-8?Q?A7SnSwQWWNmcRWHvAdPHIL6DSBk48DiNySvZH0nQF1BT?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5E2A13B950A6894DB6AA4D39DCB0F5D5@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 42f44365-8ff4-47bc-5acc-08d9ed53faea
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Feb 2022 11:45:19.6585
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: y1QnMqA0mtt2SfPJ3wIP8zNz4RKtHWPoA3d1YXaSyOmyn9yZfSS7Kl1/1cxvSLTrmXqum5HQ6FRULzrcMqL09A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1883
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

T24gMi8xMS8yMiAzOjQwIEFNLCBDaGFpdGFueWEgS3Vsa2Fybmkgd3JvdGU6DQo+IE9uIDIvMTAv
MjIgMTA6MTEgUE0sIEVyaWMgQmlnZ2VycyB3cm90ZToNCj4+IEZyb206IEVyaWMgQmlnZ2VycyA8
ZWJpZ2dlcnNAZ29vZ2xlLmNvbT4NCj4+DQo+PiBUcmFkaXRpb25hbGx5LCB0aGUgY29uZGl0aW9u
cyBmb3Igd2hlbiBESU8gKGRpcmVjdCBJL08pIGlzIHN1cHBvcnRlZA0KPj4gd2VyZSBmYWlybHkg
c2ltcGxlOiBmaWxlc3lzdGVtcyBlaXRoZXIgc3VwcG9ydGVkIERJTyBhbGlnbmVkIHRvIHRoZQ0K
Pj4gYmxvY2sgZGV2aWNlJ3MgbG9naWNhbCBibG9jayBzaXplLCBvciBkaWRuJ3Qgc3VwcG9ydCBE
SU8gYXQgYWxsLg0KPj4NCj4+IEhvd2V2ZXIsIGR1ZSB0byBmaWxlc3lzdGVtIGZlYXR1cmVzIHRo
YXQgaGF2ZSBiZWVuIGFkZGVkIG92ZXIgdGltZSAoZS5nLA0KPj4gZGF0YSBqb3VybmFsbGluZywg
aW5saW5lIGRhdGEsIGVuY3J5cHRpb24sIHZlcml0eSwgY29tcHJlc3Npb24sDQo+PiBjaGVja3Bv
aW50IGRpc2FibGluZywgbG9nLXN0cnVjdHVyZWQgbW9kZSksIHRoZSBjb25kaXRpb25zIGZvciB3
aGVuIERJTw0KPj4gaXMgYWxsb3dlZCBvbiBhIGZpbGUgaGF2ZSBnb3R0ZW4gaW5jcmVhc2luZ2x5
IGNvbXBsZXguICBXaGV0aGVyIGENCj4+IHBhcnRpY3VsYXIgZmlsZSBzdXBwb3J0cyBESU8sIGFu
ZCB3aXRoIHdoYXQgYWxpZ25tZW50LCBjYW4gZGVwZW5kIG9uDQo+PiB2YXJpb3VzIGZpbGUgYXR0
cmlidXRlcyBhbmQgZmlsZXN5c3RlbSBtb3VudCBvcHRpb25zLCBhcyB3ZWxsIGFzIHdoaWNoDQo+
PiBibG9jayBkZXZpY2UocykgdGhlIGZpbGUncyBkYXRhIGlzIGxvY2F0ZWQgb24uDQo+Pg0KPj4g
WEZTIGhhcyBhbiBpb2N0bCBYRlNfSU9DX0RJT0lORk8gd2hpY2ggZXhwb3NlcyB0aGlzIGluZm9y
bWF0aW9uIHRvDQo+PiBhcHBsaWNhdGlvbnMuICBIb3dldmVyLCBhcyBkaXNjdXNzZWQNCj4+ICho
dHRwczovL2xvcmUua2VybmVsLm9yZy9saW51eC1mc2RldmVsLzIwMjIwMTIwMDcxMjE1LjEyMzI3
NC0xLWViaWdnZXJzQGtlcm5lbC5vcmcvVC8jdSksDQo+PiB0aGlzIGlvY3RsIGlzIHJhcmVseSB1
c2VkIGFuZCBub3Qga25vd24gdG8gYmUgdXNlZCBvdXRzaWRlIG9mDQo+PiBYRlMtc3BlY2lmaWMg
Y29kZS4gIEl0IGFsc28gd2FzIG5ldmVyIGludGVuZGVkIHRvIGluZGljYXRlIHdoZW4gYSBmaWxl
DQo+PiBkb2Vzbid0IHN1cHBvcnQgRElPIGF0IGFsbCwgYW5kIGl0IG9ubHkgZXhwb3NlcyB0aGUg
bWluaW11bSBJL08NCj4+IGFsaWdubWVudCwgbm90IHRoZSBvcHRpbWFsIEkvTyBhbGlnbm1lbnQg
d2hpY2ggaGFzIGJlZW4gcmVxdWVzdGVkIHRvby4NCj4+DQo+PiBUaGVyZWZvcmUsIGxldCdzIGV4
cG9zZSB0aGlzIGluZm9ybWF0aW9uIHZpYSBzdGF0eCgpLiAgQWRkIHRoZQ0KPj4gU1RBVFhfSU9B
TElHTiBmbGFnIGFuZCB0aHJlZSBmaWVsZHMgYXNzb2NpYXRlZCB3aXRoIGl0Og0KPj4NCj4+ICog
c3R4X21lbV9hbGlnbl9kaW86IHRoZSBhbGlnbm1lbnQgKGluIGJ5dGVzKSByZXF1aXJlZCBmb3Ig
dXNlciBtZW1vcnkNCj4+ICAgICBidWZmZXJzIGZvciBESU8sIG9yIDAgaWYgRElPIGlzIG5vdCBz
dXBwb3J0ZWQgb24gdGhlIGZpbGUuDQo+Pg0KPj4gKiBzdHhfb2Zmc2V0X2FsaWduX2RpbzogdGhl
IGFsaWdubWVudCAoaW4gYnl0ZXMpIHJlcXVpcmVkIGZvciBmaWxlDQo+PiAgICAgb2Zmc2V0cyBh
bmQgSS9PIHNlZ21lbnQgbGVuZ3RocyBmb3IgRElPLCBvciAwIGlmIERJTyBpcyBub3Qgc3VwcG9y
dGVkDQo+PiAgICAgb24gdGhlIGZpbGUuICBUaGlzIHdpbGwgb25seSBiZSBub256ZXJvIGlmIHN0
eF9tZW1fYWxpZ25fZGlvIGlzDQo+PiAgICAgbm9uemVybywgYW5kIHZpY2UgdmVyc2EuDQo+Pg0K
Pj4gKiBzdHhfb2Zmc2V0X2FsaWduX29wdGltYWw6IHRoZSBhbGlnbm1lbnQgKGluIGJ5dGVzKSBz
dWdnZXN0ZWQgZm9yIGZpbGUNCj4+ICAgICBvZmZzZXRzIGFuZCBJL08gc2VnbWVudCBsZW5ndGhz
IHRvIGdldCBvcHRpbWFsIHBlcmZvcm1hbmNlLiAgVGhpcw0KPj4gICAgIGFwcGxpZXMgdG8gYm90
aCBESU8gYW5kIGJ1ZmZlcmVkIEkvTy4gIEl0IGRpZmZlcnMgZnJvbSBzdHhfYmxvY2tzaXplDQo+
PiAgICAgaW4gdGhhdCBzdHhfb2Zmc2V0X2FsaWduX29wdGltYWwgd2lsbCBjb250YWluIHRoZSBy
ZWFsIG9wdGltdW0gSS9PDQo+PiAgICAgc2l6ZSwgd2hpY2ggbWF5IGJlIGEgbGFyZ2UgdmFsdWUu
ICBJbiBjb250cmFzdCwgZm9yIGNvbXBhdGliaWxpdHkNCj4+ICAgICByZWFzb25zIHN0eF9ibG9j
a3NpemUgaXMgdGhlIG1pbmltdW0gc2l6ZSBuZWVkZWQgdG8gYXZvaWQgcGFnZSBjYWNoZQ0KPj4g
ICAgIHJlYWQvd3JpdGUvbW9kaWZ5IGN5Y2xlcywgd2hpY2ggbWF5IGJlIG11Y2ggc21hbGxlciB0
aGFuIHRoZSBvcHRpbXVtDQo+PiAgICAgSS9PIHNpemUuICBGb3IgbW9yZSBkZXRhaWxzIGFib3V0
IHRoZSBtb3RpdmF0aW9uIGZvciB0aGlzIGZpZWxkLCBzZWUNCj4+ICAgICBodHRwczovL2xvcmUu
a2VybmVsLm9yZy9yLzIwMjIwMjEwMDQwMzA0LkdNNTk3MjlAZHJlYWQuZGlzYXN0ZXIuYXJlYQ0K
Pj4NCj4+IE5vdGUgdGhhdCBhcyB3aXRoIG90aGVyIHN0YXR4KCkgZXh0ZW5zaW9ucywgaWYgU1RB
VFhfSU9BTElHTiBpc24ndCBzZXQNCj4+IGluIHRoZSByZXR1cm5lZCBzdGF0eCBzdHJ1Y3QsIHRo
ZW4gdGhlc2UgbmV3IGZpZWxkcyB3b24ndCBiZSBmaWxsZWQgaW4uDQo+PiBUaGlzIHdpbGwgaGFw
cGVuIGlmIHRoZSBmaWxlc3lzdGVtIGRvZXNuJ3Qgc3VwcG9ydCBTVEFUWF9JT0FMSUdOLCBvciBp
Zg0KPj4gdGhlIGZpbGUgaXNuJ3QgYSByZWd1bGFyIGZpbGUuICAoSXQgbWlnaHQgYmUgc3VwcG9y
dGVkIG9uIGJsb2NrIGRldmljZQ0KPj4gZmlsZXMgaW4gdGhlIGZ1dHVyZS4pICBJdCBtaWdodCBh
bHNvIGhhcHBlbiBpZiB0aGUgY2FsbGVyIGRpZG4ndCBpbmNsdWRlDQo+PiBTVEFUWF9JT0FMSUdO
IGluIHRoZSByZXF1ZXN0IG1hc2ssIHNpbmNlIHN0YXR4KCkgaXNuJ3QgcmVxdWlyZWQgdG8NCj4+
IHJldHVybiBpbmZvcm1hdGlvbiB0aGF0IHdhc24ndCByZXF1ZXN0ZWQuDQo+Pg0KPj4gVGhpcyBj
b21taXQgYWRkcyB0aGUgVkZTLWxldmVsIHBsdW1iaW5nIGZvciBTVEFUWF9JT0FMSUdOLiAgSW5k
aXZpZHVhbA0KPj4gZmlsZXN5c3RlbXMgd2lsbCBzdGlsbCBuZWVkIHRvIGFkZCBjb2RlIHRvIHN1
cHBvcnQgaXQuDQo+Pg0KPj4gU2lnbmVkLW9mZi1ieTogRXJpYyBCaWdnZXJzIDxlYmlnZ2Vyc0Bn
b29nbGUuY29tPg0KPj4gLS0tDQo+IA0KPiANCj4gSSd2ZSBhY3R1YWxseSB3b3JrZWQgb24gc2lt
aWxhciBzZXJpZXMgdG8gZXhwb3J0IGFsaWdubWVudCBhbmQNCj4gZ3JhbnVsYXJpdHkgZm9yIG5v
bi10cml2aWFsIG9wZXJhdGlvbnMsIHRoaXMgaW1wbGVtZW50YXRpb24NCj4gb25seSBleHBvcnRp
bmcgSS9PIGFsaWdubWVudHMgKG1vc3RseSBSRVFfT1BfV1JJVEUvUkVRX09QX1JFQUQpIHZpYQ0K
PiBzdGF4Lg0KPiANCj4gU2luY2UgaXQgaXMgY29taW5nIGZyb20gOi0NCj4gYmRldl9sb2dpY2Fs
X2Jsb2NrX3NpemUoKS0+cS0+bGltaXRzLmxvZ2ljYWxfYmxvY2tfc2l6ZSB0aGF0IGlzIHNldCB3
aGVuDQo+IGxvdyBsZXZlbCBkcml2ZXIgbGlrZSBudm1lIGNhbGxzIGJsa19xdWV1ZV9sb2dpY2Fs
X2Jsb2NrX3NpemUoKS4NCj4gDQo+ICAgRnJvbSBteSBleHBlcmllbmNlIGVzcGVjaWFsbHkgd2l0
aCBTU0RzLCBhcHBsaWNhdGlvbnMgd2FudCB0bw0KPiBrbm93IHNpbWlsYXIgaW5mb3JtYXRpb24g
YWJvdXQgZGlmZmVyZW50IG5vbi10cml2aWFsIHJlcXVlc3RzIHN1Y2ggYXMNCj4gUkVRX09QX0RJ
U0NBUkQvUkVRX09QX1dSSVRFX1pFUk9FUy9SRVFfT1BfVkVSSUZZICh3b3JrIGluIHByb2dyZXNz
IHNlZQ0KPiBbMV0pIGV0Yy4NCj4gDQo+IEl0IHdpbGwgYmUgZ3JlYXQgdG8gbWFrZSB0aGlzIGdl
bmVyaWMgdXNlcnNwYWNlIGludGVyZmFjZSB3aGVyZSB1c2VyIGNhbg0KPiBhc2sgZm9yIHNwZWNp
ZmljIFJFUV9PUF9YWFggc3VjaCBhcyBnZW5lcmljIEkvTyBSRVFfT1BfUkVBRC9SRVFfT1BfV1JJ
VEUNCj4gYW5kIG5vbiBnZW5lcmljIFJFUV9PUF9YWCBzdWNoIGFzIFJFUV9PUF9ESVNDQVJEL1JF
UV9PUF9WRVJJRlkgZXRjIC4uLi4NCj4gDQo+IFNpbmNlIEkndmUgd29ya2VkIG9uIGltcGxlbWVu
dGluZyBSRVFfT1BfVkVSSUZZIHN1cHBvcnQgSSBkb24ndCB3YW50IHRvDQo+IGltcGxlbWVudCBz
ZXBhcmF0ZSBpbnRlcmZhY2UgZm9yIHF1ZXJ5aW5nIHRoZSBSRVFfT1BfVkVSSUZZIG9yIGFueSBv
dGhlcg0KPiBub24tdHJpdmlhbCBSRVFfT1BfWFhYIGdyYW51bGFyaXR5IG9yIGFsaWdubWVudC4N
Cj4gDQo+IC1jaw0KPiANCj4gWzFdIGh0dHBzOi8vbmFtMTEuc2FmZWxpbmtzLnByb3RlY3Rpb24u
b3V0bG9vay5jb20vP3VybD1odHRwcyUzQSUyRiUyRnd3dy5zcGluaWNzLm5ldCUyRmxpc3RzJTJG
bGludXgteGZzJTJGbXNnNTY4MjYuaHRtbCZhbXA7ZGF0YT0wNCU3QzAxJTdDY2hhaXRhbnlhayU0
MG52aWRpYS5jb20lN0MyNTJkNzhlMDA5YWQ0OWJkNTIyMjA4ZDllZDUzNGRjZiU3QzQzMDgzZDE1
NzI3MzQwYzFiN2RiMzllZmQ5Y2NjMTdhJTdDMCU3QzAlN0M2Mzc4MDE3NjQzMTMwMTQ4NDAlN0NV
bmtub3duJTdDVFdGcGJHWnNiM2Q4ZXlKV0lqb2lNQzR3TGpBd01EQWlMQ0pRSWpvaVYybHVNeklp
TENKQlRpSTZJazFoYVd3aUxDSlhWQ0k2TW4wJTNEJTdDMzAwMCZhbXA7c2RhdGE9MW93cUlEbGNz
dDRoJTJGR3I5QXp0ZWFpeTIydmZIRlpvalJpcEttazZBJTJGQ2clM0QmYW1wO3Jlc2VydmVkPTAN
Cj4gDQoNCkFkZGluZyByaWdodCBsaW5rIGZvciBSRVFfT1BfVkVSSUZZIC4uLg0KDQpbMV0gaHR0
cHM6Ly93d3cuc3Bpbmljcy5uZXQvbGlzdHMvbGludXgteGZzL21zZzU2ODI2Lmh0bWwNCg0K

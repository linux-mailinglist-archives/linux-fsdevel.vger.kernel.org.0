Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49A7D4D943F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Mar 2022 06:58:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233986AbiCOF7m (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Mar 2022 01:59:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232198AbiCOF7l (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Mar 2022 01:59:41 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2045.outbound.protection.outlook.com [40.107.223.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4528237DC;
        Mon, 14 Mar 2022 22:58:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EVlUyJD1GYu1Dn+vulIq+sM7rK2zGvfgkU8fnp8Wnhuo/tHZ1cvju2owXg5/6INpKJ7zLVUmygkWAArlqWp/8GQHWW1XGZnJX0I8u95SwcxgoQsZyOIaym5yqQkESf0hCHE0nJWkzr1Vs7sii4LAifdEpVcmpp2QF1p72htqSxBLbpVO81AKblRiuV2R8Dt0TQ2garqgyW5xStylnfI/kPJDOZLsnsymieilIB0ow6KVezGwNEEZ5RxmIZCdHy3HIvySNW65C7dmTXRB8m71+JaEt2Sdqoj85VAtWDiqePk8QtH5zhgtcNU8VVt0DXNF+o9OqON3lfA+nle3BBSMdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ueWXr7qOxv4xWES+OPkkxV2GUCXSPlUF1D/LM4ln6+0=;
 b=PMoRW0XSvczPPZhH4u0B4FD9N1h3f2TEgPfIdmiiyG4QLwf2DUPbxvCXTc8ueWq/aWYydlDiEkgTcNBj7MtZe7jp4VcyZlsd2dhdktQbswDmDKF5mbg5iFKsorDtfmDNgWzgZZNnrpCzzY408KpOnqojD/+izHVA6GvgMVILYSLFdt4dz6z63EWIMVvqSIS8V/6xDcNFGJ+9sgsK6k4zaaQutYLBiKJ+L16Rz51/kypUNRAx+dDR2zGwU7Z4YtbtP2KhV+hIDa50MCCfFOZNZCVESN6dw7Mh//KCKM344BzoeCWmTVz1CLFouqPL67gIeUGgKZ1G2I4cimHttepjig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ueWXr7qOxv4xWES+OPkkxV2GUCXSPlUF1D/LM4ln6+0=;
 b=lW/ZoPJpvzvYzxf3yWRhV1lQO2U3D1u0Q9TwzJ019kYRSoL0woA/UBNc6SBRB6hS/XIxteZ34aAYv+4TxcdfXuS7yVY4onY/XMp7/F4ZqFe5gzH8ZxcolrFB7sWs20KNx8zcI6EBpC/lM0GEuPUzYQhpV3RGxSkX3pXYUsua2roXE5tuogaNNRjUVL1iVv3zTF22prEapzhzBW/hwrgXggMz08r+/ospzJRwLiBOU0EfJpFBx6vL5gX1X1MF9/SqZeXaxBJ7VWKwrYVxS90rtHq6JJsjvcZIDseGIlBpDvr3MhB+Ouem/3hs/oZKvrVRqOilLYbGzaVi3zRjVHe+NA==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by CH2PR12MB3832.namprd12.prod.outlook.com (2603:10b6:610:24::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.26; Tue, 15 Mar
 2022 05:58:26 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::204b:bbcb:d388:64a2]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::204b:bbcb:d388:64a2%4]) with mapi id 15.20.5061.026; Tue, 15 Mar 2022
 05:58:26 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
CC:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "lsf-pc@lists.linux-foundation.org" 
        <lsf-pc@lists.linux-foundation.org>,
        "paulmck@kernel.org" <paulmck@kernel.org>
Subject: Re: [LSF/MM/BPF TOPIC] Changes in RCU over the past few years
Thread-Topic: [LSF/MM/BPF TOPIC] Changes in RCU over the past few years
Thread-Index: AQHYL3seqjjNDeUGbEaP33FaQ3WZT6yzThOAgARPEYCACGdFAA==
Date:   Tue, 15 Mar 2022 05:58:26 +0000
Message-ID: <42a52088-4e8f-a0bd-a4e7-0efcd214f075@nvidia.com>
References: <20220304035116.GA8858@paulmck-ThinkPad-P17-Gen-1>
 <d25f8c3e-e0d6-cc1c-49ed-7357138aebc3@nvidia.com>
 <20220309213845.GG4285@paulmck-ThinkPad-P17-Gen-1>
In-Reply-To: <20220309213845.GG4285@paulmck-ThinkPad-P17-Gen-1>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a6b6ccc0-5e9e-49c9-8402-08da0648d28c
x-ms-traffictypediagnostic: CH2PR12MB3832:EE_
x-microsoft-antispam-prvs: <CH2PR12MB3832ED0EE12D2C53B8634611A3109@CH2PR12MB3832.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /5YD+5/2beFS3LpkpePQV99WTuTs1YGE2bJNoVeTaoyYYTCkBJKl1fIM2bjYA6d05S0jRfLpoCgJlVkl1UOLgAzzRNZKrcL1UoJn8LlSoq/MlkLEBHj/LIWNeAXH4FppUEeOMtpCS1Cf+REEleFm02Lc+WQCZvsdQi7NBf7wOrEEYiLIeF+S/IKpzHIdd7/B9gFIIlWE5v2NZ3a8FeI5cdFeKZynkUCqJ2WM1ztwWcJfN561ZzXdJOuMV8Zbcx/oAIUUp/eNNrzbvBe/1WtgJcHeVD98alCV80p8J9lvGIAizzFO8XPziDtd9wOwy0tvXjm7F4m/n9+VylIWiIc31Zp5m251qoCNK5ekwLxR1OPjc9P5AYLmDAuUbeM+E78oNVS++f29djMFaYt1P59IDEwmWgkMhvyySmmzRpjN3wJjeB8o2PnMYZBIDkSgF72qz7l5GZpm5eNZ7+Qw8aE0g3tUquYphVov3tWtnPZgox25uYl7qK5T46ifUtiwS4YzSdtbEJggW/UIXpHCFU770iKULE/unhRzgMRbBxz2ZToAQuR1l1ZAQdNN9VmxP6va2uPu3qtgfx4LKf/5k5T4vjAOa8uXOA6pqcdS5YvROitcEYwDaGHxuBC5EdeYWeOtdaI90iHPyVL3vm9ENUVDomgYt2tSZaQVGZR8nH7ScjIYMwgwri14jYAjyfGF64vaMWYotZDhHuEJWSDHBl3ajiB+8LWndboAzSIKzS88T3QsX2OFM8HR2T0Uncz3atTkHvZhS1KAhIEd5uMZiVx6PA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(122000001)(38070700005)(38100700002)(83380400001)(508600001)(6486002)(5660300002)(8936002)(31696002)(316002)(2616005)(76116006)(8676002)(66556008)(66446008)(91956017)(64756008)(66476007)(66946007)(86362001)(110136005)(31686004)(36756003)(186003)(6506007)(53546011)(6512007)(54906003)(2906002)(71200400001)(4326008)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?V2p6bm0reW0xMldNTmordDgvUjJ2YXpGZi8yRVV3Tk9mcjNoTmdTY2ZyWU4z?=
 =?utf-8?B?eUN0d0dRTU40cXBoRGtoejZaN3kyTm83enBnTzVJWXF6MUNhTFc1WFh1eWVS?=
 =?utf-8?B?NVZENE5EQ2h5RlVwc3I3ZlFvSU9hSjllM1pYVHZGY3BkQko5UUc3UmZIbWx3?=
 =?utf-8?B?VkZXN1ZZTmNJalpMQXNZbGp3cVlVR3d0R3h4RXZvL0cyY0FEbjBlZ04zQVlW?=
 =?utf-8?B?eGM3bmZweWRTRUdtODhxSW5IMUlTdW0xbDluMHZXbkRaTllGSGpZZ0I4Misx?=
 =?utf-8?B?MzFobVZjVUZzdHFvK3FnNUtxazhQaHdYSzRINUJQOGJRNjlFRGIvSHhiNUFh?=
 =?utf-8?B?clpBZUxqYXQrN2lXRmJVQVdCeHZVNVZqRTNwUFBaeXhEK3VUbFVoMkcvNkRw?=
 =?utf-8?B?cFlTVXlYKy9hem1RQWRIRXU0TXlkMkIrSml4d2NpZlBTdGo0TzdZL3ZCTHBP?=
 =?utf-8?B?RnNXYmFxUVN3bHRGOE9qNHg5T01UeFZmU0lOQlZsUThGSlBJeUpGbFVuQ1lm?=
 =?utf-8?B?QjB3dTYvOVhQL3hzRkhkUGNTSm1SQzgwVHJYcGJmUmlHU3IraUUyTmZrTVJ6?=
 =?utf-8?B?bGJXUzdBTjN6VjhndUJYaGYwdW9WZHpkanhMcmEyWUFlNzV6QmE0RVdFTzAv?=
 =?utf-8?B?aG05bWVZcEhPd1dadUxRNjVPbmxIVmVLbFVFeUFJRWRYaVJDQllWUU41MDlL?=
 =?utf-8?B?dW9QTU9pYU1TWVRvTDVGMTZBdWlQcmtMejJlcGk5a2dLMlZwTUQ0RE5KZVRK?=
 =?utf-8?B?bTlkSHZPd0MzbUNxVU14UmhJZHhRWlBCb3BUVTlTYnU3YWVKbEV4SWErelZs?=
 =?utf-8?B?ak9ha3lqRWZ0ZDBuMXNLVmN2ZitsRVd3YzRpR2NuejRpL0hFc29IbHdPUWo4?=
 =?utf-8?B?Z1pkYnN3aitiZVVUQ1JYZkhKbGwwdm1LdGF1OXBoeE8wR0R5TWp3aUZ2dHVX?=
 =?utf-8?B?SVhRSUgrQ2ltZTY5Q0xYV2M2djJ2M0VNRTFoWFBaZzFTWGlVTFNRU050S3Z5?=
 =?utf-8?B?L01RSjZiTWtudGlVejl6U2lqZjQ2SVVEVEx4MjVJKy90anhtSmZhSWJGQ0JQ?=
 =?utf-8?B?bUtwQlpBM3FHTjVUQjhtWFY0SGR5eEVtY0w5ZWNlU25FYWVKZlVoT2lJLzZ6?=
 =?utf-8?B?bHFQckFIMWd3V2VRWGp5cXZubDVhak1IQ1FOWW9Qd1p3K1AwQ3pnWFRldFFJ?=
 =?utf-8?B?REFCK2tNektsSHpKcEV1WWFhMHVFN1phU3ZURjJqR0l2TDE0Z1JOdE4vQU5W?=
 =?utf-8?B?MGhDOUJidHp2UHhrcjh2MG9aZFBKZkg4bVB2TEpSbzc2MVpLNDVaelZrRWta?=
 =?utf-8?B?OGJURkNscXVtRlNoRWV3S2JibmhuVWczUVZ2TmRCQXRmeURFcG5hTVJxa3R3?=
 =?utf-8?B?bkhwWEZ1SW9zTkxjWmh1YVIrK1F5NWc0VnhjRHFKQlYvczl1YWFiZEFTWU5B?=
 =?utf-8?B?eEV6UTkyRnRoOVZyNFhXK09FVDdsY1diV0NWQWx1SXlJdUVVN0V2emg1Q1Zt?=
 =?utf-8?B?a2Nxd2FYQ2g4KzE0MnNpelM0Q2RWZ20xMFgzcWJxcUJTSW96clp6bUNKWnRH?=
 =?utf-8?B?U1V3eEFNOGxtT2pDbWk2ajdKZUR5NXVTSGlRNURvckpEZ3doTGhrRy91WS9J?=
 =?utf-8?B?bGtXTEsyalhCbnRYcVllbzFnSkQ1U1Zsck54c1JzZHc5MWpjTlVMbFY0OUhB?=
 =?utf-8?B?TTZjcDBybmE0azRJblZLZlNxTTJxU0JEczF5ZDdtVko3NHBZTk9UWGNZSWtv?=
 =?utf-8?B?WnErRFdsanBDRi9SRDJrV1VxSXFEanpXY2c4NktPSld6SmFWdTlpQkxwR3cr?=
 =?utf-8?B?N0lFWkxtbVFpLy80Sy9Ca2c0enhOQ3Y1S2gvNVhDWDRuQVZGQUV1OG9paEZD?=
 =?utf-8?B?QlYvdlQwSStnSm5UYnVOYkxuVVJjS0pDdVdKYi9jeWtyNzYxbzg1YmVORC9s?=
 =?utf-8?B?MHZOZGowbDBSeFVzOVZNSCtqekh4L0FCSXNvRlBlZ0Yxa003aFdCYlVXYnc4?=
 =?utf-8?B?N3ZrVUp3TC90VEdnUWsxZy9qdWFaekJzU09PRjMvZUwxNC8wU1ZSRUt3WFpu?=
 =?utf-8?Q?LyDcKs?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <15AE11F3576C3D48AE61EF21EE2B4038@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6b6ccc0-5e9e-49c9-8402-08da0648d28c
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Mar 2022 05:58:26.5088
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cT2nnjBifvl02H461S885SJLwTasxXu0/ewQ91udy+cvM7cWGKtOtlG4957OEoHXB+udi6nCV8ixSXH0w3sXKw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3832
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

T24gMy85LzIyIDEzOjM4LCBQYXVsIEUuIE1jS2VubmV5IHdyb3RlOg0KPiBPbiBNb24sIE1hciAw
NywgMjAyMiBhdCAwMzo1MDo0M0FNICswMDAwLCBDaGFpdGFueWEgS3Vsa2Fybmkgd3JvdGU6DQo+
PiBPbiAzLzMvMjIgMTk6NTEsIFBhdWwgRS4gTWNLZW5uZXkgd3JvdGU6DQo+Pj4gSGVsbG8hDQo+
Pj4NCj4+PiBUaGVyZSBoYXZlIGJlZW4gYSBudW1iZXIgb2YgY2hhbmdlcyB0byBSQ1Ugb3ZlciB0
aGUgcGFzdCBmZXcgeWVhcnMsDQo+Pj4gaW5jbHVkaW5nIGNvbnNvbGlkYXRpbmcgdGhlIHVwZGF0
ZS1zaWRlIFJDVS1wcmVlbXB0LCBSQ1Utc2NoZWQsDQo+Pj4gYW5kIFJDVS1iaCBmbGF2b3JzLCB0
aGUgYWRkaXRpb24gb2YgVFJFRSBTUkNVLCBub24tc2xlZXBpbmcgcG9sbGVkDQo+Pj4gZ3JhY2Ut
cGVyaW9kIGludGVyZmFjZXMgZm9yIFJDVSBhbmQgU1JDVSwgYW5kIGFkZGl0aW9uIG9mIGEgY291
cGxlDQo+Pj4gdmFyaWFudHMgb2YgVGFza3MgUkNVLiAgVGhpcyB0b3BpYyB3b3VsZCBpbmNsdWRl
IGEgcXVpY2sgb3ZlcnZpZXcgb2YNCj4+PiB0aGVzZSBjaGFuZ2VzLCB3aXRoIHNwZWNpYWwgYXR0
ZW50aW9uIHRvIGNoYWxsZW5nZXMgd2hlbiBiYWNrIHBvcnRpbmcgdG8NCj4+PiBwcmUtY29uc29s
aWRhdGVkLVJDVSBrZXJuZWxzLiAgVGltZSBwZXJtaXR0aW5nLCBpdCBtaWdodCBhbHNvIGJlIHVz
ZWZ1bA0KPj4+IHRvIGxvb2sgYXQgc29tZSBvZiB0aGUgbnVhbmNlcyBvZiBTTEFCX0RFU1RST1lf
QllfUkNVLg0KPj4+DQo+Pj4gVGhpcyB3b3VsZCBhbHNvIGJlIGFuIG9wcG9ydHVuaXR5IHRvIGRp
c2N1c3MgUkNVIHVzZSBjYXNlcyBhbmQgcG90ZW50aWFsDQo+Pj4gY2hhbmdlcyB0byBSQ1UgaXRz
ZWxmLg0KPj4+DQo+Pj4gCQkJCQkJVGhhbngsIFBhdWwNCj4+Pg0KPj4NCj4+IEknbGwgYmUgdmVy
eSBtdWNoIGludGVyZXN0ZWQgaW4gdGhpcyB0b3BpYyBhbmQgSSB0aGluayBldmVyeW9uZQ0KPj4g
bm9uLW9ubHkgbW0gYnV0IGZzL3N0b3JhZ2UgdHJhY2tzIGNhbiBhbHNvIGJlbmVmaXQgZnJvbSB0
aGlzLg0KPj4NCj4+IFBlcmhhcHMgd2Ugc2hvdWxkIGFkZCByZXNwZWN0aXZlIG1haWxpbmcgbGlz
dCB0byB0aGlzIHRocmVhZCA/DQo+PiAobGludXgtYmxvY2sgYW5kIGxpbnV4LWZzZGV2ZWwpDQo+
IA0KPiBXb3JrcyBmb3IgbWUhDQo+IA0KPiAJCQkJCQkJVGhhbngsIFBhdWwNCj4gDQoNCmFkZGlu
ZyBsaW51eC1ibG9jaywgbGludXgtbnZtZSBhbmQgbGludXgtZnNkZXZlbC4NCg0KLWNrDQoNCg0K

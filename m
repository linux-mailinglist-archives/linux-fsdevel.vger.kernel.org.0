Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36B097022FE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 May 2023 06:45:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235302AbjEOEpt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 15 May 2023 00:45:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbjEOEpr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 15 May 2023 00:45:47 -0400
Received: from FRA01-PR2-obe.outbound.protection.outlook.com (mail-pr2fra01on2074.outbound.protection.outlook.com [40.107.12.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76136213D;
        Sun, 14 May 2023 21:45:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a7kR+N3GXqfmhte1hdOJDGJtUfihquU/A1JnAOpy5uRc6RY84wwR8MEIP20R9VgCkUEarZlwGKQgM4ytil7oVStXxYBRMhBk0LgbybQWwX9bj78zBYXZRbLTNS7ULhfm/rO7zYPkVK3LOyxq4lNri2QxYBr8WClz4ISyM+QEAvaJN09Gbxmlg4cwGcY1LhdxoKIwZM+QuAYke3+NUQs4pl0uDQN5H/Jqb6sBZD+ekDu8s9cVbRP3O/OmZrmnebwXGAO69GD1AfBC5FcstYwTlT6lr/BPNjC6HMV6lhEVh6tKjYSLltG/ifjl51YnG/am8bWWiEEePRU61/O7y9oelg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QgUk3IEYYsvp3eXY2tKFgzDR65XgteOF691S2mk/VVc=;
 b=e+aTgvEpcJlWRe6yry+QBVvUqL62GjVw1dswf9hXmmg6eoXc1KVYHa4rzotdOjZg6tuyze0YCF1ay8CEhjDOJoyW9jpb82Qt5/7hj7nT4CqbJAGvgMfkBnKpTXeEUGe3W5sHGV2gn8hO6bI0dmlqG1bgXgKC1gkxlaqMvZZ12Z7a9K4W84V82mzxxgn4aebF5D6fvTMNbnMkNmnn/P84pitCHJ0sup3yokCFmF4xf/GF8DwINbNY+8PX3mjCuEsWF7zQfqD8JQ6JCSMsVFjqRlJC/7/3GZUDCwmLiPxX3AbKhrNqEKLfKFyMzjaVLKL3RH9WCRGkJFnP5oDg5Bn/Qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=csgroup.eu; dmarc=pass action=none header.from=csgroup.eu;
 dkim=pass header.d=csgroup.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=csgroup.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QgUk3IEYYsvp3eXY2tKFgzDR65XgteOF691S2mk/VVc=;
 b=emNgjpNKKNc6BPTyHrMOJ1FqpQDCMEJwiPUpyzw5Cg9F2krKm3KaX1uH/sn/CqEcPFy7j4zGv/n0eX0hpBxpuefyFU17zZXi33xQzx4OLATdT+SY2PS1Qs7NjCG3UoaqM8NEdQKzSddWW9tWLmOu2b6wtjV+klx0f0dUKfzPWlFDHQgrYAWSwoDzEojDnY1Jf1U1YO73TD+jjyBnvowKenoHdoF36WZL3pFT1Tb3lT52aGOWTxJaIJE7FywjbM6b2lF2R1tPBHI/BomaxuImtaVFnCGDvmHsGhnuGyvtvmaSHkUa4G0mIYgiJEEpYIW3JHGPRnn4iHKmsehY6HA45Q==
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:31::15)
 by PAZP264MB2942.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:1f2::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.30; Mon, 15 May
 2023 04:45:42 +0000
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::447b:6135:3337:d243]) by MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::447b:6135:3337:d243%3]) with mapi id 15.20.6387.030; Mon, 15 May 2023
 04:45:42 +0000
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Kent Overstreet <kent.overstreet@linux.dev>
CC:     Lorenzo Stoakes <lstoakes@gmail.com>,
        Christoph Hellwig <hch@infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-bcachefs@vger.kernel.org" <linux-bcachefs@vger.kernel.org>,
        Kent Overstreet <kent.overstreet@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: Re: [PATCH 07/32] mm: Bring back vmalloc_exec
Thread-Topic: [PATCH 07/32] mm: Bring back vmalloc_exec
Thread-Index: AQHZgpdUsgx7flCbUE+3jXS45Hg7zK9SaWKAgAAHaoCABcbjAIAB6dOAgABVD4CAAFR0gA==
Date:   Mon, 15 May 2023 04:45:42 +0000
Message-ID: <6f049870-1684-1875-3cdc-73e1323ffdb0@csgroup.eu>
References: <20230509165657.1735798-1-kent.overstreet@linux.dev>
 <20230509165657.1735798-8-kent.overstreet@linux.dev>
 <ZFqxEWqD19eHe353@infradead.org> <ZFq3SdSBJ_LWsOgd@murray>
 <8f76b8c2-f59d-43fc-9613-bb094e53fb16@lucifer.local>
 <ce5125be-464e-44ad-8d9e-7c818f794db1@csgroup.eu>
 <ZGFyHY6pH9CU4fzf@moria.home.lan>
In-Reply-To: <ZGFyHY6pH9CU4fzf@moria.home.lan>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=csgroup.eu;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MRZP264MB2988:EE_|PAZP264MB2942:EE_
x-ms-office365-filtering-correlation-id: 21d78b4d-01d8-4f93-5fcd-08db54ff3d29
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +lfKy2T2pH1+24qQcLF2y/FLUNR+YbuoZ+HD/ggpPd0jxLkKrMDLyLDbbnzDCmDg1BXx1LwTBOrcUw3HslJyTq0AqKPiSkn9QOb2En96VsxrW0udSAgqa/QfvBEKVMRyxZe7QZg8douDszFRnll1FPtb9LiVCMn1r/SC6fe46xme24NYO84h6HNnHtAhmBqeZzfCaD/AbKBlfBIwDFBWZJ9vu7iLsLnBt8nXD9KOkWFJqJY9dBWH2C27lN9iKVz5znGDi69YJab4k/mvrZJRX6HNYlbZzgAkXo4+1da3NEozf7kt251Y9tGn1E4jP2+fqyG1bixmE4b3ckoC7vf1bgVMOPeqNOdtt8AIJkHkfsynDU2iLw5UU3mmdkx8XFdGHbxZkk6DVx7g+QkbnD2pmGGX0bBJDHJU/9Xa40TspU8E0ROjkEKDJDjfYZVehluf0DMDMo3IcNpflIKgoFq8uOjCMpo6kgQh306tsJpHNWay4fD+8f38fISBWW4Q51A2vSU1SUOh7f+YgjUSbJRhlo1hTwIXhXN2ZsOS/Un5HB8BzbF6+pv90EUQwBXHbKrT6uZieqhafaUsbcQ4PBgEkMoYsTQxeS4wqWQ6PZCXCnYG6l+6fxrqqH1dIc73QhBggam6Y3uEMicwMD1N78lQjF0slGmOP7GHpjan8dVedXEia/5liOPew0aB5eU3KP5s
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39850400004)(376002)(396003)(366004)(346002)(136003)(451199021)(31686004)(83380400001)(66574015)(4326008)(6916009)(36756003)(38100700002)(122000001)(41300700001)(38070700005)(316002)(6512007)(6506007)(6486002)(26005)(478600001)(66946007)(66446008)(66556008)(64756008)(66476007)(2616005)(91956017)(76116006)(8676002)(8936002)(7416002)(44832011)(31696002)(5660300002)(2906002)(54906003)(86362001)(186003)(71200400001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bjllUHpQNXU0MWFMbUE3bHRjY3Bad3d4L0RNOVVjdk1FaUxvazB6L1ZSTG50?=
 =?utf-8?B?VnJwaEp3U2NVS1BLS0xFTWFlZHc2K3hKRy94b3BUSUUwM2NzajlTQzBncUFx?=
 =?utf-8?B?Z3cwOTg2S1ZFUXVaYnRDckN1MEtHeC9ocG1qZUltaDRpS2VHTFhjU1V1UUFM?=
 =?utf-8?B?WDlrTk5MamhPUWovMWJvY3pGWWxVeG1vcFhneDhCMmEwcFROM1YzSXpLaDNu?=
 =?utf-8?B?cENid2x4a2JoZlU5TVlwVm81UmRtcDBzYmVkbkpGUGxObWc3d0VTNGJFQjVD?=
 =?utf-8?B?Sm1mbkRnQU5zenFzZ2E0ZTlheGxYZjA3bW96YXhCR050eWhBa2tOdW5LSG0y?=
 =?utf-8?B?cmdodUxpWjBVT3Bqc0srd1c4bEtGcTMyRzZCN3h6Y21SVjZKem5JQlZxWmFS?=
 =?utf-8?B?RVdENFBzVWhxWXk2cSsvSlJlZFJ4WFpQNFY4WjV6eU1rdVJMcHJSY0lseU0x?=
 =?utf-8?B?OTBzNVBOTWxER1oxc0hPNG1uV2EzTnpCRS9wMi9mRzJwM3AvVHRRVCt2RTla?=
 =?utf-8?B?UzdoYVBLelp6MS9ldzdabDh0ODBTcEg5Y2ZGNVM4WjNHakVZeXc2QmZhL3BU?=
 =?utf-8?B?WnVEdzd6M0F5K0ErZlZidnVaRDNvVkYxVU8vQnFTMlhPdkFZN2xYNDBHMmtr?=
 =?utf-8?B?YzllYXFwaUpJWjJZQkFLeGx5RllBbEFqdWYydVFFTVg3T2txVStLY1hwODYw?=
 =?utf-8?B?QVhKcEtrbXIySnhlTld3R09CcEI2aGtzOTdxb0hqb3V5bW44b2VydEF0QVFy?=
 =?utf-8?B?R1N0MVJuQm5Tc2pHdDZjWDhnZXJFTTVacjRNcDlyNlNQNXU0OEU3ejlZenJi?=
 =?utf-8?B?K3lXR0ZRNEFyRUZwWHdZbllicEhJNmJFdEJYOEs3Q1F5TEdNd2tSVUk1bWZi?=
 =?utf-8?B?TGphMFc5Tm1LSE9mV2hIWG5nWVlKc2Zqc2crZWl5ZEU1RmlZSnpiUnJvbUpL?=
 =?utf-8?B?OFc5cDN0dzhXTlJSWTRwNFZUc01GYzRqdzZDaXdBK2FCTG1WMm05V2ZXcFIz?=
 =?utf-8?B?N0NOa3BkSUh6K3owckZ4QXRNcVR0UXFVMzdYdEd4Yno2YnM1UDRkUmtrQ043?=
 =?utf-8?B?R2lwcVhaRXA2MGs3bGFkNmtnakVKZlBneUh2bWNhbHdINGw3OHlsc0FKbnZM?=
 =?utf-8?B?K3RJTzZpOWEyS296SFl3L01LZzBvVXFMaUtYSE5hMVplUEF5Wk5yU2F2WG13?=
 =?utf-8?B?TnFsY1lPWU9GWGN5eHZST1hBQ0dYZFhZRDIzbFcra3FLMHVIdWFPdjhjaGVv?=
 =?utf-8?B?Q1pObXJlMlpwNGJjQktHanNtbVRVVzFScEVQdUk1YXQreXN2VjdBU1kwTTZD?=
 =?utf-8?B?OWRtcFlzS3RBaWlUWDV4WHRIeWxRdzRNSFQrVjJMbWh4MDF6c0w0NGJnVllD?=
 =?utf-8?B?K3ZxTzFXcHlkRGZDMDlMVGlDdzRMM0J3QVBKSmtoTEFiVjc3RGFxNFhaMDVW?=
 =?utf-8?B?dklNS3pkTXkxQzA4SkhkTzMwN3JCaFhJMmJyZXpQMW4rdDVaZDNyY0tmRXh2?=
 =?utf-8?B?Zm84RlFtRjRmbXBRa25MM3loZ0VBcVJrb1ZRWm1CaVRWRGdlbEdmT1MrWWRL?=
 =?utf-8?B?TlJkMktrblFqWGhSS0tOR09Ua21ZUGR5ZEFTSGdBMU8yblpNT0l0aS9LV3My?=
 =?utf-8?B?dmZNakxNZmJ4ZFczOUFnSWJnZ1pQRWV3MHZ4UGNCTEFvZThyemlzMVdGbVFQ?=
 =?utf-8?B?Z2xoQWM4V1NQU3VLdjZRMzNvbnhtMlNPMzQwbjFEZDllaWNxU2NzZndSdmha?=
 =?utf-8?B?QU9wcHF5UVRiK0kwdWZhUW9FNGpYU1BaMkxyY2tSODdjMlNtWlZuWHNIYXA3?=
 =?utf-8?B?Rk9nUzN6RVc0NGxFN1VjS09tU1BPa0JGK2xxNG0xeUIwK3lRVVlTckxvUmo4?=
 =?utf-8?B?NUFORG1jRjRXMEdvYTZqdkNsbUpGQklDelZJMTFaWkdFSzNiU2thbE1YT2p6?=
 =?utf-8?B?b0pVOTVaRUpYclpKNkNSSDUzdFJydFl1R0pxZ2lTNVBCbEhJZ1V3SjBwQkNl?=
 =?utf-8?B?UVB6ZHU5S2M1OUhENTFRWmtGN0Rwb0xsa3VpcDBaTHBDR0htZGJ3WENvTVUy?=
 =?utf-8?B?eHVTRzg3czRpNzJyMmZrUHhDYWEzSG1UZFJKL0s3bVpQUmoyUDFMN25hYUto?=
 =?utf-8?Q?XWx9iPydnK8JEbDy0aolGjdub?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7114471F58A50243B48B069A92668383@FRAP264.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: csgroup.eu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 21d78b4d-01d8-4f93-5fcd-08db54ff3d29
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 May 2023 04:45:42.2353
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9914def7-b676-4fda-8815-5d49fb3b45c8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: n9vnrwfNqBRBsVwD6pcf6EejBgogihyUEINxxaxnPdr3OZw1UZd2/OAtlAPJ/bcc2RZB56RlLoQPXu5vnGNBXcgSEiIS6GaJEB+lETML4WE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAZP264MB2942
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

DQoNCkxlIDE1LzA1LzIwMjMgw6AgMDE6NDMsIEtlbnQgT3ZlcnN0cmVldCBhIMOpY3JpdMKgOg0K
PiBPbiBTdW4sIE1heSAxNCwgMjAyMyBhdCAwNjozOTowMFBNICswMDAwLCBDaHJpc3RvcGhlIExl
cm95IHdyb3RlOg0KPj4gSSBhZGRpdGlvbiB0byB0aGF0LCBJIHN0aWxsIGRvbid0IHVuZGVyc3Rh
bmQgd2h5IHlvdSBicmluZyBiYWNrDQo+PiB2bWFsbG9jX2V4ZWMoKSBpbnN0ZWFkIG9mIHVzaW5n
IG1vZHVsZV9hbGxvYygpLg0KPj4NCj4+IEFzIHJlbWluZGVkIGluIGEgcHJldmlvdXMgcmVzcG9u
c2UsIHNvbWUgYXJjaGl0ZWN0dXJlcyBsaWtlIHBvd2VycGMvMzJzDQo+PiBjYW5ub3QgYWxsb2Nh
dGUgZXhlYyBtZW1vcnkgaW4gdm1hbGxvYyBzcGFjZS4gT24gcG93ZXJwYyB0aGlzIGlzIGJlY2F1
c2UNCj4+IGV4ZWMgcHJvdGVjdGlvbiBpcyBwZXJmb3JtZWQgb24gMjU2TWJ5dGVzIHNlZ21lbnRz
IGFuZCB2bWFsbG9jIHNwYWNlIGlzDQo+PiBmbGFnZ2VkIG5vbi1leGVjLiBTb21lIG90aGVyIGFy
Y2hpdGVjdHVyZXMgaGF2ZSBhIGNvbnN0cmFpbnQgb24gZGlzdGFuY2UNCj4+IGJldHdlZW4ga2Vy
bmVsIGNvcmUgdGV4dCBhbmQgb3RoZXIgdGV4dC4NCj4+DQo+PiBUb2RheSB5b3UgaGF2ZSBmb3Ig
aW5zdGFuY2Uga3Byb2JlcyBpbiB0aGUga2VybmVsIHRoYXQgbmVlZCBkeW5hbWljIGV4ZWMNCj4+
IG1lbW9yeS4gSXQgdXNlcyBtb2R1bGVfYWxsb2MoKSB0byBnZXQgaXQuIE9uIHNvbWUgYXJjaGl0
ZWN0dXJlcyB5b3UgYWxzbw0KPj4gaGF2ZSBmdHJhY2UgdGhhdCBnZXRzIHNvbWUgZXhlYyBtZW1v
cnkgd2l0aCBtb2R1bGVfYWxsb2MoKS4NCj4+DQo+PiBTbywgSSBzdGlsbCBkb24ndCB1bmRlcnN0
YW5kIHdoeSB5b3UgY2Fubm90IHVzZSBtb2R1bGVfYWxsb2MoKSBhbmQgbmVlZA0KPj4gdm1hbGxv
Y19leGVjKCkgaW5zdGVhZC4NCj4gDQo+IEJlY2F1c2UgSSBkaWRuJ3Qga25vdyBhYm91dCBpdCA6
KQ0KPiANCj4gTG9va3MgbGlrZSB0aGF0IGlzIGluZGVlZCB0aGUgYXBwcm9wcmlhdGUgaW50ZXJm
YWNlIChpZiBhIGJpdCBwb29ybHkNCj4gbmFtZWQpLCBJJ2xsIHN3aXRjaCB0byB1c2luZyB0aGF0
LCB0aGFua3MuDQo+IA0KPiBJdCdsbCBzdGlsbCBuZWVkIHRvIGJlIGV4cG9ydGVkLCBidXQgaXQg
bG9va3MgbGlrZSB0aGUgV3xYIGF0dHJpYnV0ZQ0KPiBkaXNjdXNzaW9uIGlzIG5vdCByZWFsbHkg
Z2VybWFuZSBoZXJlIHNpbmNlIGl0J3Mgd2hhdCBvdGhlciBpbiBrZXJuZWwNCj4gdXNlcnMgYXJl
IHVzaW5nLCBhbmQgdGhlcmUncyBub3RoaW5nIHBhcnRpY3VsYXJseSBzcGVjaWFsIGFib3V0IGhv
dw0KPiBiY2FjaGVmcyBpcyB1c2luZyBpdCBjb21wYXJlZCB0byB0aGVtLg0KDQpUaGUgV3xYIHN1
YmplY3QgaXMgYXBwbGljYWJsZS4NCg0KSWYgeW91IGxvb2sgaW50byBwb3dlcnBjJ3MgbW9kdWxl
X2FsbG9jKCksIHlvdSdsbCBzZWUgdGhhdCB3aGVuIA0KQ09ORklHX1NUUklDVF9NT0RVTEVfUldY
IGlzIHNlbGVjdGVkLCBtb2R1bGVfYWxsb2MoKSBhbGxvY2F0ZSANClBBR0VfS0VSTkVMIG1lbW9y
eS4gSXQgaXMgdGhlbiB1cCB0byB0aGUgY29uc3VtZXIgdG8gY2hhbmdlIGl0IHRvIFJPLVguDQoN
ClNlZSBmb3IgaW5zdGFuY2UgaW4gYXJjaC9wb3dlcnBjL2tlcm5lbC9rcHJvYmVzLmM6DQoNCnZv
aWQgKmFsbG9jX2luc25fcGFnZSh2b2lkKQ0Kew0KCXZvaWQgKnBhZ2U7DQoNCglwYWdlID0gbW9k
dWxlX2FsbG9jKFBBR0VfU0laRSk7DQoJaWYgKCFwYWdlKQ0KCQlyZXR1cm4gTlVMTDsNCg0KCWlm
IChzdHJpY3RfbW9kdWxlX3J3eF9lbmFibGVkKCkpDQoJCXNldF9tZW1vcnlfcm94KCh1bnNpZ25l
ZCBsb25nKXBhZ2UsIDEpOw0KDQoJcmV0dXJuIHBhZ2U7DQp9DQoNCg0KQ2hyaXN0b3BoZQ0K

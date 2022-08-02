Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4287B588202
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Aug 2022 20:46:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229637AbiHBSqe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 2 Aug 2022 14:46:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbiHBSqc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 2 Aug 2022 14:46:32 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2055.outbound.protection.outlook.com [40.107.220.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3C2C33A00;
        Tue,  2 Aug 2022 11:46:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dk9SM5W8dDkzm8aHKwMNrO4FCJRDWoza6mbU9OYwQyHore2MlPE3AWGFCA5c0vkjdVYY/ubmYT1y7FvploDnu8+mSCJbpG6/5VJCoWyt+TDDhZ9oBIi0kp8VeOve8qpm1yW89h5bQzeD0OSuu44jBMY4ww2gVjxGpSQFKq+zMpa685xSDI6RFgDqYZM3O1tRcKUykAOK1u21JAxw4Glr1kL8F00iN/dLGmHiOIvqO+PWz9DULRXoRAlAPn8vCnD+XpikKLzNE80O+S3N2vKbZWRfR10AZskOnFmTdl0oeQhTxNwzFjXbxTSQqIed5sK9ujm+NOjHM9Jsd+5E+VBtZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HQ5dJArsu/4zOi4NljI5OXsqB0sst2LL2+rvUuJ9SB0=;
 b=YYuwb/oj4jC1cs8mDXh97WRyugXIvtC1Fn1T86hrrlZv7y/svSzDMy8pH03D/QbOZzuPSbVCKkKD1HuWGqh1URPI5k7zxPMHZDspKsJFAGDYjwSRHTT0oAQ79V6KzMHYq3w3UQEm/gKLBlLkE3qSZ9UCYl24HdkN16TXuoVb+rDNxAFxl7nxn2wHXzPEipZIRpLjBjxZII/PGT+LaEbrkvYaq2DHKz3g3V031FPVuOB+1zZ3jFEgF4qPt+zxz6xiBKRd6YomCFTwrANpnmXZlW858l+MtTYAXYoZwPJbXwPJkUSqmuXkbw2g7u2TeaqVWEiFYLhu70BqWw1ZBixo+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vmware.com; dmarc=pass action=none header.from=vmware.com;
 dkim=pass header.d=vmware.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HQ5dJArsu/4zOi4NljI5OXsqB0sst2LL2+rvUuJ9SB0=;
 b=1TGi4rBqmZjGHz0Vq3D8EF+RXV/HU4DnDeMCg2T+LTUyrYgSc6F8tWS4GSYZS5ddtg9qXUvRnwfeT4j+BpeZSkm848Zx0hpv6wGTt8t6l+B9z4K8SH8Wjsjh35AiBsEBO7wDgrnvsTvcwj3H8o70ZeUrV7UCmMOa8dM0ELmyCQY=
Received: from BY3PR05MB8531.namprd05.prod.outlook.com (2603:10b6:a03:3ce::6)
 by SN4PR0501MB3727.namprd05.prod.outlook.com (2603:10b6:803:48::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.14; Tue, 2 Aug
 2022 18:46:29 +0000
Received: from BY3PR05MB8531.namprd05.prod.outlook.com
 ([fe80::d813:9300:4877:39d0]) by BY3PR05MB8531.namprd05.prod.outlook.com
 ([fe80::d813:9300:4877:39d0%8]) with mapi id 15.20.5504.014; Tue, 2 Aug 2022
 18:46:29 +0000
From:   Nadav Amit <namit@vmware.com>
To:     Axel Rasmussen <axelrasmussen@google.com>
CC:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Dmitry V . Levin" <ldv@altlinux.org>,
        Gleb Fotengauer-Malinovskiy <glebfm@altlinux.org>,
        Hugh Dickins <hughd@google.com>, Jan Kara <jack@suse.cz>,
        Jonathan Corbet <corbet@lwn.net>,
        Mel Gorman <mgorman@techsingularity.net>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@kernel.org>, Peter Xu <peterx@redhat.com>,
        Shuah Khan <shuah@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        zhangyi <yi.zhang@huawei.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH v4 2/5] userfaultfd: add /dev/userfaultfd for fine grained
 access control
Thread-Topic: [PATCH v4 2/5] userfaultfd: add /dev/userfaultfd for fine
 grained access control
Thread-Index: AQHYm6msXDLL/Bu+aECRDX4d27LWyK2cCQaA
Date:   Tue, 2 Aug 2022 18:46:29 +0000
Message-ID: <9D80DB2B-B25E-4BF0-8831-95C24818D995@vmware.com>
References: <20220719195628.3415852-1-axelrasmussen@google.com>
 <20220719195628.3415852-3-axelrasmussen@google.com>
In-Reply-To: <20220719195628.3415852-3-axelrasmussen@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vmware.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 03c02aaa-3c42-4a06-8b58-08da74b75010
x-ms-traffictypediagnostic: SN4PR0501MB3727:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hkqR/PLdsiDXYzwvSiUx9RQQi1M85F8R2ceia3EBy9Y65NbeZxAi7UzTkrU3QO4F7WbD2kJ4tbkQP30zlM2JjVE5USdwuNQMsW8mENFRv6hlbMf0AIa+vmHnFWA/I8+aJX7qmvTjch/GdEluZVayI8IUbiAU0kfji4I5UFkOYqjZ+lNUqoYT0IjM/0vPcSm30S6I05HxgMlFbLb3lhGX2U24XuP19Oh/DjhLnkGZ/L/el3eVsQ7R6YG70dPyWV962Dpcuy0uNcT5eXW7QPkpDWZlKVKrvIMSn8gSyQnOF0/l9JI6QwTGesKQib1gyTFT+YIhsjDiwgxKHG8ukKUoqs1HI5Iy8dptVbX9KKnkCQLwne05upOtztWk1UvVZl8nofOUB4s6yb7qo+hGfXVnuALG4xNUmBgKO39oW00iS8D52enqd9uO909zTYAczB5XNl+TEXXElmGGBFgX+mCwjNaWOwhApYhAivs/46kAZA9dtx+C1rWL42YUN2+unB4LHl1v55HduyFmps9Ws2DX2AWK7d7pH97gKPjqmzIjO6PbIwz3olFoUYl66sBuCx/dJY1utWmtZSR/u7sVBp3UQ3ZmOTAxChbeLeM/vdRW/G58FsEpZTC0ZoUr8tVJA8q60HQAkrICKUCJTa2ey0/ehUambGObhyCUbwYXgGAD67MmXheQ7kMleGJE3XaWTL0fgqDlr7PGtkQPED4pgW6wyfaHeQWemxOTcR3i/LxOJJobBpcgwrpLZHD34/PWnFsprwhyqIHCjbt8hwshMjcY/iohvQOBvlBTHXQCRlQVc+dDTf5ES1d6dW1VnYp+GAzsLKj+KVr2mbDeOiiOxn5/qw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY3PR05MB8531.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(396003)(376002)(346002)(366004)(136003)(6512007)(478600001)(316002)(38100700002)(122000001)(71200400001)(26005)(83380400001)(186003)(6486002)(2616005)(8936002)(36756003)(53546011)(6506007)(41300700001)(76116006)(6916009)(33656002)(8676002)(2906002)(4326008)(66556008)(64756008)(66476007)(86362001)(66446008)(66946007)(5660300002)(7416002)(38070700005)(54906003)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OGpwbjFnd1NqZkNuM1pCcVdJVnRDaGRLbkxsTkdyNlA0QVc2NlRUK052SHFZ?=
 =?utf-8?B?MWg0S2ppTmE1Y1lCYmZXT3Vtai9GTi9EWFp3WS9sU2xMbGM1TDd4RHJnTFRs?=
 =?utf-8?B?dGlBaUlDTEI2T3FlVXN3WjlnNmswbDRZUVZhSHZXL3lNa09CcVF3NXRJMGZH?=
 =?utf-8?B?TGdINVh0SVlCS0VEWmsyRmovVmw3eURtUDA0NFBXM2pWZ2dMdHljOHZlWVVR?=
 =?utf-8?B?bEV2TEFMZ3k5Z1ZnTEdkQ0tkUDd4bTRmTkxLa2d1cmNZK0hHZjZ0ZXNLWnNU?=
 =?utf-8?B?dm1mNnlYdm43c1poNGRrRGtia0xnMEJ6MDZQdHd3VW11SmxEcmpReEZrcER6?=
 =?utf-8?B?cGxERGR1bEJscHJ3d1dDMVlZNzZBM3NVaFluR3c2S3NpMHFVZzNPZk9OR1Jh?=
 =?utf-8?B?M2IyREY5UkMvY3Z1K1dHSEV1cVFJalRBaGs5YjFmTHp5ZmVxeXN4UlFGUDZ4?=
 =?utf-8?B?REZZdEhZUmJBRmU5SllaenplNjVOT0xWdGxDVUs4b2lwQTdCTHc5cTQ2cHM4?=
 =?utf-8?B?RlJDYmtieEV6TzdhcEJQRXN2OE1yME5WQ1JNQWRBV2p3TEQyYTEvQWJCb2dv?=
 =?utf-8?B?R2VtR0RYVndHVzErLzNxTlNzVTZaYjR2Y1Q1YjVvMWp4cjhsVlNydElGZFcr?=
 =?utf-8?B?MzRmamxWdis5OG9PVC9nTjdRN2d3cHpVeFNMNDJzUEtnWmpsaEw3MjAyTFgr?=
 =?utf-8?B?NDFZNEV6cDl2c1FkV1RUL2NZaE92T0J6YnpnU1ZwUko0c3F5NGd2L1UxcWVl?=
 =?utf-8?B?SnVZQlBwODVvd0Z4Zjl6RUlHQkVpM1RHbGUvVndsSklPVzcvbU9VaFhLaGd6?=
 =?utf-8?B?YXJZK1lOc3p0aEZtakYxd1d6eEVQT2lYeW1nYWVzeGZlMGdSKzFHaUlJTFl0?=
 =?utf-8?B?ZmNsRlhoUERiV1IvSlAyUEl3dE5jV1d1Z0lWRGRZZ2VLTXBRZGVSVUdqWW9q?=
 =?utf-8?B?L0pGc2VvZU9KbzJmVWZWUkxRKzJwMWVhV2VYNExXTjh1VWdObmRwNUdwa0FH?=
 =?utf-8?B?SkVybjVGV0UxTUpzZVlraE5MamJ3RUJPUk1ncGhUdHBQem9zNFVzbjlXWENq?=
 =?utf-8?B?U20zWUJyR0NsckVFSkpUaHpuM1lVOFZjMVZOakNZSmUvNTdGWXNCMW5SODZF?=
 =?utf-8?B?SlQrRW93REhtcUlyYXBQSU05REhMQTAzRTZCYmhUN3R0dGdwT2t2SHA5ODRU?=
 =?utf-8?B?WVVrcUZGYWxPV0N6MXd6Nkp3cENvZ3libUxIWHp5YzJUMDVkRFdxRXRqdkN5?=
 =?utf-8?B?WkV3NEl1YWNydW16ak5qcGp1VFkvQitrNWQ5ZVR0YzVwWStEbVZUVWFWMzYv?=
 =?utf-8?B?alhvYTB0VHJSOG1OSkdYemUxVWlHN1VTc1JldFNxTFdMM3VIa2FibEtidWFZ?=
 =?utf-8?B?VVhXaG1MZWVxcGFFUUd3MXNoM2JNZ3daM1pQNkNMWk1NTkFTc0ppY1VsTldi?=
 =?utf-8?B?VDhhRmVJQ0pQTzUvMFJmeDlTWmowNU9RV2tqeHlxUVUxelBqdHo5ZkN3QldS?=
 =?utf-8?B?dGJ4dE9EZU8zTndBVVFKT216OTFobUxETmRjWHdZa3dldU5IUDl0ZHRmVTRI?=
 =?utf-8?B?ZTIwTmJrRUwyNXFIZmhjcE80cHE3eFA3VjZuc2JmQ1JXVm5XZ0FJblQ1M2ty?=
 =?utf-8?B?RkJ4bndVMCtmWm9GMHp0QkF4NjR5NWdsQW5wYmJZdUpCaXpYdHpKc1JtUUlS?=
 =?utf-8?B?NUlNSXJXRW43eEtzY2RtWWwyUkw3bi9vNk1ZM0NXZzZPWmw4TEdDTUM4M1VF?=
 =?utf-8?B?b0FMQUQ5R3F6c2RkZy9ZbVNhS3pSSDIvdEdIdkN4SUVHYnR2RHk1QUoyUFpt?=
 =?utf-8?B?cFhnNmI3K2QrY2R0dDhPaHVkQllBTHgveTc4NHR1ZFRORCtYSVNieTZpSkVS?=
 =?utf-8?B?TjloZTRmQWpUcVdjL3MvNTJHQVVPU1pQRkVFNkxFVWFaVkNKRXQyeFdBeGlK?=
 =?utf-8?B?SnhXYnhRaUFlSzVjRGdYMlZVV2xSVEZpeSt0WmY0d2R5dzkvd2NGd1VXUlZW?=
 =?utf-8?B?TFpYd1BTcU91OVBTZjhYZHMvdWM0U0NkVWVCZTlicndJYy9sNEtxWlZkUnpH?=
 =?utf-8?B?d3F4alcvWE51OEhMMldmOTk0dC9uWWVzVUpUNHQ0MGJmcUdtL0w4ZXRoSkt6?=
 =?utf-8?Q?MtgOMaVq28+2MFtTIvsHWtPxI?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B58D16A630470543B9713ACD29DE1B5B@namprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY3PR05MB8531.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 03c02aaa-3c42-4a06-8b58-08da74b75010
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Aug 2022 18:46:29.6976
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dtyQ3t3aq9lIQwo2hUpXNcGmKRsnGVMxrWEvW/dHEWe6nVt1Zpxx9eOX80lu9GN7wh0h513NRPznbcd6sBjkHw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0501MB3727
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

T24gSnVsIDE5LCAyMDIyLCBhdCAxMjo1NiBQTSwgQXhlbCBSYXNtdXNzZW4gPGF4ZWxyYXNtdXNz
ZW5AZ29vZ2xlLmNvbT4gd3JvdGU6DQoNCj4gDQo+ICtzdGF0aWMgaW50IG5ld191c2VyZmF1bHRm
ZChib29sIGlzX3N5c2NhbGwsIGludCBmbGFncykNCj4gew0KPiAJc3RydWN0IHVzZXJmYXVsdGZk
X2N0eCAqY3R4Ow0KPiAJaW50IGZkOw0KPiANCj4gLQlpZiAoIXN5c2N0bF91bnByaXZpbGVnZWRf
dXNlcmZhdWx0ZmQgJiYNCj4gLQkgICAgKGZsYWdzICYgVUZGRF9VU0VSX01PREVfT05MWSkgPT0g
MCAmJg0KPiAtCSAgICAhY2FwYWJsZShDQVBfU1lTX1BUUkFDRSkpIHsNCj4gLQkJcHJpbnRrX29u
Y2UoS0VSTl9XQVJOSU5HICJ1ZmZkOiBTZXQgdW5wcml2aWxlZ2VkX3VzZXJmYXVsdGZkICINCj4g
LQkJCSJzeXNjdGwga25vYiB0byAxIGlmIGtlcm5lbCBmYXVsdHMgbXVzdCBiZSBoYW5kbGVkICIN
Cj4gLQkJCSJ3aXRob3V0IG9idGFpbmluZyBDQVBfU1lTX1BUUkFDRSBjYXBhYmlsaXR5XG4iKTsN
Cj4gKwlpZiAoaXNfc3lzY2FsbCAmJiAhdXNlcmZhdWx0ZmRfc3lzY2FsbF9hbGxvd2VkKGZsYWdz
KSkNCj4gCQlyZXR1cm4gLUVQRVJNOw0KPiAtCX0NCj4gDQo+IAlCVUdfT04oIWN1cnJlbnQtPm1t
KTsNCj4gDQo+IEBAIC0yMDk4LDggKzIxMDUsNDIgQEAgU1lTQ0FMTF9ERUZJTkUxKHVzZXJmYXVs
dGZkLCBpbnQsIGZsYWdzKQ0KPiAJcmV0dXJuIGZkOw0KPiB9DQo+IA0KPiArU1lTQ0FMTF9ERUZJ
TkUxKHVzZXJmYXVsdGZkLCBpbnQsIGZsYWdzKQ0KPiArew0KPiArCXJldHVybiBuZXdfdXNlcmZh
dWx0ZmQodHJ1ZSwgZmxhZ3MpOw0KPiArfQ0KDQpOb3QgY3JpdGljYWwsIGJ1dCB3aHkgbm90IHRv
IHB1dCB0aGUgdXNlcmZhdWx0ZmRfc3lzY2FsbF9hbGxvd2VkKCkgY2hlY2sNCmhlcmU/IFlvdSB3
b3VsZCBiZSBhYmxlIHRvIGxvc2UgdGhlIOKAnGlzX3N5c2NhbGzigJ0uDQoNCkkgYWxzbyBoYWQg
YSBzbWFsbCBjb21tZW50IGZvciBwYXRjaCA1Lg0KDQpCdXQgdGhlc2UgYXJlIG1pbm9yIGlzc3Vl
cywgc28gZm9yIHRoZSBzZXJpZXM6DQoNCkFja2VkLWJ5OiBOYWRhdiBBbWl0IDxuYW1pdEB2bXdh
cmUuY29tPg0KDQoNClsgU29ycnkgYWdhaW4gZm9yIG1pc3VuZGVyc3RhbmRpbmcgdGhlIHNjaGVt
ZSB5b3Ugd2VyZSB1c2luZyBpcyBzaW1pbGFyIHRvDQpLVk0gYW5kIHRoZXJlZm9yZSByZWFzb25h
YmxlLiBdDQoNCg==

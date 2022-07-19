Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B40E57A9DD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Jul 2022 00:32:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239787AbiGSWcL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Jul 2022 18:32:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232480AbiGSWcK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Jul 2022 18:32:10 -0400
Received: from na01-obe.outbound.protection.outlook.com (mail-bgr052101064005.outbound.protection.outlook.com [52.101.64.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F75057E0C;
        Tue, 19 Jul 2022 15:32:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R1OoaguOM1bqLwUmPTcmFZRLEy5K46o642y0C9o2RZ35dCWX5R2S01IyaOyZWQk4zBx3ElMdn2rcub2ITJeaO7LA6ggjywqnpALp0URG2h4mn1sgvCSrdRPfO6Zsg3du15wjVFzZz1W3sSbGyqFLncoGFE3JzJjqZXgWgG5aUOcgShwFGH7zWbZf7q4PVygZh7hmSz/2NdOlT6f9+CUB+AhiMxg215lWdLDZV5XwcLyzIR8XbPRxYY7kxvX9aNwktXcjoIBZVWhJTSd4fyo0CuWGfL0Tp9m7uflLa4LXqT0YSox0zg24yt4shjfZxb+ReRCDhp7C5ET39gAgozjPsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K5ix2rFay6kD66ygOS6RvEghPT3YVih2mv/Y2hMwtks=;
 b=hbrUE9+soRSN2nyjjQksOvXSEweGhnCn9VVpteedIBmw5GkQL4d8VCaGjvteNN+KanQr3Ni9URTWJyorzPwDnvNNpkK86KuP7COnTazebb/DJn5QUwwfTq23xNE7hXVFbTJI53y4FaDDf5s17wM+9/kjo+uudE7P4lsGlN7g+feq7ItbNCCYamzEVG4Zj1JMe1tN3TjqzolewpbS3p1seie+jS/RwlF+MFzVukSL/jfKnBM+vqOZEvi1oSzADpUKKbrq4dPK9DbfuyYooQwenE9lPeFNfEHr0GcVlX13Yg+GTm1sHvtgCRbFuIojP4M3KXT6+w1p4yEmCtUIjP0OBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vmware.com; dmarc=pass action=none header.from=vmware.com;
 dkim=pass header.d=vmware.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K5ix2rFay6kD66ygOS6RvEghPT3YVih2mv/Y2hMwtks=;
 b=YGNU9LeaYfydud1glKUAZ+ZaMxt1o/QYfIgg4v9V3gZ5RNTO0/IMT9CXQGgCaV6HQLE546n1vKtVhv0rEN9gXbGfqmwWw1FV+apV7ZtvERwx/NEdhSu7ntfDiNTKKjE+owBO6bJZgb++pMN4Urs/9e5yXL0tznO1nCkgjEhSIWY=
Received: from BY3PR05MB8531.namprd05.prod.outlook.com (2603:10b6:a03:3ce::6)
 by DM6PR05MB6444.namprd05.prod.outlook.com (2603:10b6:5:128::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.11; Tue, 19 Jul
 2022 22:32:06 +0000
Received: from BY3PR05MB8531.namprd05.prod.outlook.com
 ([fe80::d813:9300:4877:39d0]) by BY3PR05MB8531.namprd05.prod.outlook.com
 ([fe80::d813:9300:4877:39d0%7]) with mapi id 15.20.5458.018; Tue, 19 Jul 2022
 22:32:06 +0000
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
        Linux MM <linux-mm@kvack.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH v4 2/5] userfaultfd: add /dev/userfaultfd for fine grained
 access control
Thread-Topic: [PATCH v4 2/5] userfaultfd: add /dev/userfaultfd for fine
 grained access control
Thread-Index: AQHYm6msXDLL/Bu+aECRDX4d27LWyK2GR2wA
Date:   Tue, 19 Jul 2022 22:32:06 +0000
Message-ID: <D43534E1-7982-45EE-8B16-2C4687F49E77@vmware.com>
References: <20220719195628.3415852-1-axelrasmussen@google.com>
 <20220719195628.3415852-3-axelrasmussen@google.com>
In-Reply-To: <20220719195628.3415852-3-axelrasmussen@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.100.31)
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vmware.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6f15f232-70b3-4d86-ad47-08da69d682e5
x-ms-traffictypediagnostic: DM6PR05MB6444:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: sHtu+DFFhqZKg7G82yOnudfJTqHUeC7QE2Fy4iS5fXPwfw1JuB7BthmX1fuZzSCBjD06D8Z0LroK4CTelYBPbcLy7nccNbKVKFo82wdVaFM68w30y9DBGwQWpbS/2UTRJJ9rwCjKq7F8gGYTGP2zV9VP8IfffogqhfSGZ/WiAy7ihdfR4mdQNOKvbrtV6CvhFTehqOXxa2a8kPtxhEReEq8Xs671KbAQ1rKYZ0J8016DWrrYV4OGMkDX3oQFkbeZoQXa1TtQvQBYLRZ0aEO7L1P9vQBC6KpkBFLxMVDGCJxnhKOBe+84Lnnuq7DAFCssj4sURuF6RaJ+u3AiGPlC4dWXwsbahjO66h9NYV07GKuDj7C2zmiLwmEf1TciIcRljGniVYQ84pCIF84Hh1XV3HaE1fNGuMkpyee9RZFRY+3cXRgk8OBhHxOYv+ORl0UjLfkObY45+UsuDDF8K3GiOVrsGL2axGWpRJYHEGQ2RxCChTQD2sozPsnUHU0k5h+YbeUlW01MLuKF1kd8Wm0W6eZh7iL6jRbLsbecwY7TlVU6g0FbHs2pcY51Hw89k/fAiVQK9Ee0eWAqAL8ABdbfER65nZsmW9OqAhAC1oHCaUXv5AW/Ko7r1wgTBpNFlmTFQw8drEhvY3KAeTgx1xolQb6XfB9779ldjnaB1j9w+AoFcW4guXGdTsfZh9Hs+fWjdgkYiiPgEaTAc4agImCG5B3vCmm9L7F5GznfKz+UHoSjF4aAB9tPyqH26EcYihG0aijlLRpza+kW1htveThd7xC4LixlxL0oxPcKX3qJbvnA0N+5rr+3V05Jb8g7YKuhX41C02My5DvywyszzdOfOA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY3PR05MB8531.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(396003)(39860400002)(136003)(346002)(376002)(4326008)(66446008)(64756008)(6916009)(6506007)(66946007)(76116006)(66556008)(83380400001)(53546011)(6486002)(316002)(66476007)(38100700002)(54906003)(8936002)(41300700001)(26005)(186003)(33656002)(2906002)(478600001)(7416002)(71200400001)(36756003)(38070700005)(86362001)(5660300002)(2616005)(6512007)(8676002)(122000001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Y0lnTThvbnczYnBtckZsQzFkT3hsYXJpd2JQK01NNmxCM1R2dC8yOUZ4VU83?=
 =?utf-8?B?VU5zcGlYeEw5VnA1S1pvWTdWY01iN2JxTjR3cjdtZW1qUDl5M011TUI3alVo?=
 =?utf-8?B?T045MllMQXNnbXdWK3crTDJtZHk2dHNGOStySXhqZG9sNUtuR0tDVTVjU3Bn?=
 =?utf-8?B?TjZNN2ZGUG5zYTQyZUdZYmtYQldNY3RzZm5ZR3BiMkg5SnN6ZnkvL3JnM3hi?=
 =?utf-8?B?TUdzbExZVlFoRFJ1N3lLcUZ3ZzE2L0xOREQ5dm8vbG9jZTFWRVI3bXMyWkRO?=
 =?utf-8?B?UDIwRnllQm9vdnZxMVFVUzFPblViQS80YjN6MWV4YURuYWdmR0RwbEhZTGtI?=
 =?utf-8?B?NlJFNHR5cEpnMSsvOENBVUFEMktjUWFwTFlHcUxqaUgzdWlzYm4wUksrMXVr?=
 =?utf-8?B?WXVrZzZNZWdNZWVHbUpNeG1lekFBYlg2V3ZrOWMzMEpkN3o4RjJleGdzQkdI?=
 =?utf-8?B?NGN1L0U0dDlRTVlOWERoWmt6QW9RQXNwdG5rbjl2R3ZoejZRVDdaZjVhbEM0?=
 =?utf-8?B?RHc0WnJIUVBEdWhxL1Naa0c3M1FoUUlPY2ZzKzk0a0x0M0lWRm5ZZjNpL3Rx?=
 =?utf-8?B?cktWdFVDVzZTRDZ0UTk2R0lWeXM5R09xRHFRVVlYYU90cUNOSis3Qk5iMGxu?=
 =?utf-8?B?WWFQMFp1SnJCOWI1S1ZLSDJRTEFzbUhxS1Q5bUFQUXdLVi9pOG5SSFAza0Zr?=
 =?utf-8?B?Um5LdVk3OVhhQXFhV01PMWNEZm5FaVpDc0ZoUnFPU3QzTmxQRnRBN2pHTHBV?=
 =?utf-8?B?TDRxenJKdFNuWE03WGs0bkV3Y1VybmtiV1d3R1Jya204bHQ4aDh5OVZiYUdE?=
 =?utf-8?B?dC9HY0kzcEN4aWVyNDFvVWxTYjQvTlhXNHR0clpjalRGUzN5YVJmdjlqUjNo?=
 =?utf-8?B?enFSUWlUSmJyQmF0dlFvaDYrOTRvNmlDRzJiY2I3Z1dEc2JoVWk3SnNhcXhI?=
 =?utf-8?B?QmpTVzlSOXFuVkhKQVViMWEwZnlNVDA2NlNEL3FsSkZhTXlPN2ZSMmErYzJv?=
 =?utf-8?B?RngzRzU1MFVvY3g1V2ZFODVzOHpzVGR2M015bmRJcnR6QWFFMmpjc2dnWU5x?=
 =?utf-8?B?Rjl1T1BoTkNBQXFSckd2clNCNW9JSnZwVndVaTVXTFREZjRvakNHai9lMS9T?=
 =?utf-8?B?Uis4NVd6RlZwM2txeE15NWFOSFE4Q2c5SytqK2tJdlRuZGltQVJKdDBYeGU0?=
 =?utf-8?B?NWZKOHRjL2FUVStpWTFaV0c4bFRYVXF3S1dodVlTMmRrbzV0d3BuYzFmS0h2?=
 =?utf-8?B?TThaVXNDV3pOV2hlKzBnQ2JXWjRVUHp5Q2VmOFVsWFFITzFPeXJYMkM1OER2?=
 =?utf-8?B?VDhJQXE2dUVYRzFUZ1RDQ0ZDTnk0WitMWkh2VTlTejRzZHpGVTdQK1FLNnk3?=
 =?utf-8?B?ZXlmYm9scEJJeGtEUWx3NVhVaEhzK2RxUzEyc2lYZmNjeGhTbHJBd1hNV2l1?=
 =?utf-8?B?OXZIYUdFT3NFTHd4MHZLQzM5ODRNOTlTOUhOMzlsM09kZzc4SGVjdldBTGN6?=
 =?utf-8?B?cXlWaFcvY2k0YSsrekJFY3NweCtwU3hiSGpYazVhWU5OdE85Q0ZidkV1VTRs?=
 =?utf-8?B?akQvTHA5d20weUFLcTFPbW5lSGgrMDdCb2ZFSXNIUTZJOE95bTBYcmdmWGYz?=
 =?utf-8?B?eE9Ia3I2clZGdG90c29mdkQyOER0Qi96ZUF2UjhqNzFxTjMrd2ErU0ZQRmI2?=
 =?utf-8?B?UEtHQzhyN1RwalVjbFJQVkFNRHA1QXdaa0V0Y1RHeFFNY09wNlpscHM1QmhY?=
 =?utf-8?B?MnpPa3JGZjBuUGhZTFlQV2pGZ1pnalRXV1AyaEFXSE9aMDM5Q05kOVVvZjVY?=
 =?utf-8?B?UmdqTUMxdmVZK3ArVk1TQ3ZVMzNoRi9QY1hCb3BjejR0UStpQUQvRDRTZ0Jz?=
 =?utf-8?B?amNQQTRxNGlBckhBV1dNSHNsRHNWL2QyY0lpZUtCY3B0ckJrdkErWTBjZHVq?=
 =?utf-8?B?ME5aYjFkbXBIbDhmNzlxNUZrNUtrSjJGTk41WnFWM0RUWWU3WnRxYjRMb21X?=
 =?utf-8?B?aDZSa1A2bFpqREJjdjRMVFdqUUI3TVV2akx4cVdyM1pmVUtPa2phKzY3bi85?=
 =?utf-8?B?VnF2NDZUN3FtKzMyemxUUUNieDRkUnhYK3c1bzBxLzBXWVlyejE3Vk9XWnM1?=
 =?utf-8?Q?cUt5Ovw+qkBcUOySDv2YyFVwh?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E8F8EC33FBA0624E9FC7469A9A4FA785@namprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY3PR05MB8531.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f15f232-70b3-4d86-ad47-08da69d682e5
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jul 2022 22:32:06.5729
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zeN7AABERRXJXpfJ7Qer1fY1ROkh4TB1luT8Gl4IzdhhPNp4sFNjE2QDZMkmuXJdgbDEOFJq1wJXzLT1346ggQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR05MB6444
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

T24gSnVsIDE5LCAyMDIyLCBhdCAxMjo1NiBQTSwgQXhlbCBSYXNtdXNzZW4gPGF4ZWxyYXNtdXNz
ZW5AZ29vZ2xlLmNvbT4gd3JvdGU6DQoNCj4gSGlzdG9yaWNhbGx5LCBpdCBoYXMgYmVlbiBzaG93
biB0aGF0IGludGVyY2VwdGluZyBrZXJuZWwgZmF1bHRzIHdpdGgNCj4gdXNlcmZhdWx0ZmQgKHRo
ZXJlYnkgZm9yY2luZyB0aGUga2VybmVsIHRvIHdhaXQgZm9yIGFuIGFyYml0cmFyeSBhbW91bnQN
Cj4gb2YgdGltZSkgY2FuIGJlIGV4cGxvaXRlZCwgb3IgYXQgbGVhc3QgY2FuIG1ha2Ugc29tZSBr
aW5kcyBvZiBleHBsb2l0cw0KPiBlYXNpZXIuIFNvLCBpbiAzN2NkMDU3NWI4ICJ1c2VyZmF1bHRm
ZDogYWRkIFVGRkRfVVNFUl9NT0RFX09OTFkiIHdlDQo+IGNoYW5nZWQgdGhpbmdzIHNvLCBpbiBv
cmRlciBmb3Iga2VybmVsIGZhdWx0cyB0byBiZSBoYW5kbGVkIGJ5DQo+IHVzZXJmYXVsdGZkLCBl
aXRoZXIgdGhlIHByb2Nlc3MgbmVlZHMgQ0FQX1NZU19QVFJBQ0UsIG9yIHRoaXMgc3lzY3RsDQo+
IG11c3QgYmUgY29uZmlndXJlZCBzbyB0aGF0IGFueSB1bnByaXZpbGVnZWQgdXNlciBjYW4gZG8g
aXQuDQo+IA0KPiBJbiBhIHR5cGljYWwgaW1wbGVtZW50YXRpb24gb2YgYSBoeXBlcnZpc29yIHdp
dGggbGl2ZSBtaWdyYXRpb24gKHRha2UNCj4gUUVNVS9LVk0gYXMgb25lIHN1Y2ggZXhhbXBsZSks
IHdlIGRvIGluZGVlZCBuZWVkIHRvIGJlIGFibGUgdG8gaGFuZGxlDQo+IGtlcm5lbCBmYXVsdHMu
IEJ1dCwgYm90aCBvcHRpb25zIGFib3ZlIGFyZSBsZXNzIHRoYW4gaWRlYWw6DQo+IA0KPiAtIFRv
Z2dsaW5nIHRoZSBzeXNjdGwgaW5jcmVhc2VzIGF0dGFjayBzdXJmYWNlIGJ5IGFsbG93aW5nIGFu
eQ0KPiAgdW5wcml2aWxlZ2VkIHVzZXIgdG8gZG8gaXQuDQo+IA0KPiAtIEdyYW50aW5nIHRoZSBs
aXZlIG1pZ3JhdGlvbiBwcm9jZXNzIENBUF9TWVNfUFRSQUNFIGdpdmVzIGl0IHRoaXMNCj4gIGFi
aWxpdHksIGJ1dCAqYWxzbyogdGhlIGFiaWxpdHkgdG8gIm9ic2VydmUgYW5kIGNvbnRyb2wgdGhl
DQo+ICBleGVjdXRpb24gb2YgYW5vdGhlciBwcm9jZXNzIFsuLi5dLCBhbmQgZXhhbWluZSBhbmQg
Y2hhbmdlIFtpdHNdDQo+ICBtZW1vcnkgYW5kIHJlZ2lzdGVycyIgKGZyb20gcHRyYWNlKDIpKS4g
VGhpcyBpc24ndCBzb21ldGhpbmcgd2UgbmVlZA0KPiAgb3Igd2FudCB0byBiZSBhYmxlIHRvIGRv
LCBzbyBncmFudGluZyB0aGlzIHBlcm1pc3Npb24gdmlvbGF0ZXMgdGhlDQo+ICAicHJpbmNpcGxl
IG9mIGxlYXN0IHByaXZpbGVnZSIuDQo+IA0KPiBUaGlzIGlzIGFsbCBhIGxvbmcgd2luZGVkIHdh
eSB0byBzYXk6IHdlIHdhbnQgYSBtb3JlIGZpbmUtZ3JhaW5lZCB3YXkgdG8NCj4gZ3JhbnQgYWNj
ZXNzIHRvIHVzZXJmYXVsdGZkLCB3aXRob3V0IGdyYW50aW5nIG90aGVyIGFkZGl0aW9uYWwNCj4g
cGVybWlzc2lvbnMgYXQgdGhlIHNhbWUgdGltZS4NCj4gDQo+IFRvIGFjaGlldmUgdGhpcywgYWRk
IGEgL2Rldi91c2VyZmF1bHRmZCBtaXNjIGRldmljZS4gVGhpcyBkZXZpY2UNCj4gcHJvdmlkZXMg
YW4gYWx0ZXJuYXRpdmUgdG8gdGhlIHVzZXJmYXVsdGZkKDIpIHN5c2NhbGwgZm9yIHRoZSBjcmVh
dGlvbg0KPiBvZiBuZXcgdXNlcmZhdWx0ZmRzLiBUaGUgaWRlYSBpcywgYW55IHVzZXJmYXVsdGZk
cyBjcmVhdGVkIHRoaXMgd2F5IHdpbGwNCj4gYmUgYWJsZSB0byBoYW5kbGUga2VybmVsIGZhdWx0
cywgd2l0aG91dCB0aGUgY2FsbGVyIGhhdmluZyBhbnkgc3BlY2lhbA0KPiBjYXBhYmlsaXRpZXMu
IEFjY2VzcyB0byB0aGlzIG1lY2hhbmlzbSBpcyBpbnN0ZWFkIHJlc3RyaWN0ZWQgdXNpbmcgZS5n
Lg0KPiBzdGFuZGFyZCBmaWxlc3lzdGVtIHBlcm1pc3Npb25zLg0KDQpBcmUgdGhlcmUgYW55IG90
aGVyIOKAnGRldmljZXMiIHRoYXQgd2hlbiBvcGVuZWQgYnkgZGlmZmVyZW50IHByb2Nlc3Nlcw0K
cHJvdmlkZSBzdWNoIGlzb2xhdGVkIGludGVyZmFjZXMgaW4gZWFjaCBwcm9jZXNzPyBJLmUuLCBk
ZXZpY2VzIHRoYXQgaWYgeW91DQpyZWFkIGZyb20gdGhlbSBpbiBkaWZmZXJlbnQgcHJvY2Vzc2Vz
IHlvdSBnZXQgY29tcGxldGVseSB1bnJlbGF0ZWQgZGF0YT8NCihwdXR0aW5nIGFzaWRlIG5hbWVz
cGFjZXMpLg0KDQpJdCBhbGwgc291bmRzIHNvIHdyb25nIHRvIG1lLCB0aGF0IEkgYW0gZ29pbmcg
dG8gdHJ5IGFnYWluIHRvIHB1c2hiYWNrDQooc29ycnkpLg0KDQpGcm9tIGEgc2VtYW50aWMgcG9p
bnQgb2YgdmlldyAtIHVzZXJmYXVsdGZkIGlzIHByb2Nlc3Mgc3BlY2lmaWMuIEl0IGlzDQp0aGVy
ZWZvcmUgc2ltaWxhciB0byAvcHJvYy9bcGlkXS9tZW0gKG9yIC9wcm9jL1twaWRdL3BhZ2VtYXAg
YW5kIHNvIG9uKS4NCg0KU28gd2h5IGNhbuKAmXQgd2UgcHV0IGl0IHRoZXJlPyBJIHNhdyB0aGF0
IHlvdSBhcmd1ZWQgYWdhaW5zdCBpdCBpbiB5b3VyDQpjb3Zlci1sZXR0ZXIsIGFuZCBJIHRoaW5r
IHRoYXQgeW91ciBhcmd1bWVudCBpcyB5b3Ugd291bGQgbmVlZA0KQ0FQX1NZU19QVFJBQ0UgaWYg
eW91IHdhbnQgdG8gYWNjZXNzIHVzZXJmYXVsdGZkIG9mIG90aGVyIHByb2Nlc3Nlcy4gQnV0DQp0
aGlzIGlzIEVYQUNUTFkgdGhlIHdheSBvcGVuaW5nIC9wcm9jL1twaWRdL21lbSBpcyBwZXJmb3Jt
ZWQgLSBzZWUNCnByb2NfbWVtX29wZW4oKS4NCg0KU28gaW5zdGVhZCBvZiBoYXZpbmcgc29tZSBz
dHJhbmdlIGRldmljZSB0aGF0IGJlaGF2ZXMgZGlmZmVyZW50bHkgaW4gdGhlDQpjb250ZXh0IG9m
IGVhY2ggcHJvY2VzcywgeW91IGNhbiBqdXN0IGhhdmUgL3Byb2MvW3BpZF0vdXNlcmZhdWx0ZmQg
YW5kIHRoZW4NCnVzZSBtbV9hY2Nlc3MoKSB0byBjaGVjayBpZiB5b3UgaGF2ZSBwZXJtaXNzaW9u
cyB0byBhY2Nlc3MgdXNlcmZhdWx0ZmQgKGp1c3QNCmxpa2UgcHJvY19tZW1fb3BlbigpIGRvZXMp
LiBUaGlzIHdvdWxkIGJlIG1vcmUgaW50dWl0aXZlIGZvciB1c2VycyBhcyBpdCBpcw0Kc2ltaWxh
ciB0byBvdGhlciAvcHJvYy9bcGlkXS9YLCBhbmQgd291bGQgY292ZXIgYm90aCBsb2NhbCBhbmQg
cmVtb3RlDQp1c2UtY2FzZXMuDQoNCg==

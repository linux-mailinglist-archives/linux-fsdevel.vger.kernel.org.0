Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B47BF6EFD95
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Apr 2023 00:43:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239534AbjDZWn0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 26 Apr 2023 18:43:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235325AbjDZWnW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 26 Apr 2023 18:43:22 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2067.outbound.protection.outlook.com [40.107.92.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E4F740ED;
        Wed, 26 Apr 2023 15:42:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hhwv4Qpw7A9EjCeO4EhR+iVIzlBsguQceTmO1vOThegTkRJLzTt1GEyE2XvJjOTs9A5GJ19XkxdyYAeRtdx0tlbIW6M+CGPua2QoKWH50QBDV48jvGvQj+MiKQEvq3lkPlFM3Y48H7sJSZjLIolw6uJly3eCSZt1jpINM1ck3o2TQ4lB3U8PjIZkI9EodBsn+dkXIQxwQaY1bWRxIM27Xk2HSDUhn5DFrRqOQ0D01O9Ljkq3R60+aZH3dqwwhmEgSnxYUr+KwYLElqFeKaJwTlIPRLaL7nEPjqmWtegSbwNCPVkaoowiUK/9t2fp7EnIVcdpHVzZqM9vWHza+v5+og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=22wN+vV9zYmlJNuVTHLAd9s+oSf1SB5JwqBT2ImZpZ0=;
 b=TeFSi0L0MpEVnDzW2nH46Caepj2Qcptq5qGr4nKCzNLQwdM+mSZlAxNbQ+DO/v5oT/en1x/TGIifP86Al2tux88aKavr2TA3BUaMEmFFZZicIssefw2f7bMMwosqZst65/rugozsT10hw0p4ToM4sOlj7vGIRtUhtXZqlAIR6N6++SYKfuo9NSSvtHLv93/OkaycxrNT9nAvSVYLa8MRjdSGVXqn1anpyM+hEmRu/ydTvQNbnN+NrulMYBeN5HaL/iizbzYG8yW7nEjXko9ibgqr/V5ioxCWUtOJz4NWlwgwJjHDOjWN4BJ3HKY/D6DxrhAAu+6GGD2dwjK7wwsB4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ddn.com; dmarc=pass action=none header.from=ddn.com; dkim=pass
 header.d=ddn.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ddn.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=22wN+vV9zYmlJNuVTHLAd9s+oSf1SB5JwqBT2ImZpZ0=;
 b=RFzSlJwpETSlHJH0zfgWteKN4Yh/UKaXgALFQ+DtirqonhpGQ3ZG8X13s8W6t9VeXDBkXe3ssUuq5e93f6upL0jKTwEYo3qSXhk4YM3anT4biocGvHDZx8sYVptWHOI+6Xs1rJsejaLmghhd6yrf2I7S0HhD9ap1+9W7s/Z1AVc=
Received: from DM5PR1901MB2037.namprd19.prod.outlook.com (2603:10b6:4:aa::29)
 by MW5PR19MB5652.namprd19.prod.outlook.com (2603:10b6:303:1a3::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.33; Wed, 26 Apr
 2023 22:40:32 +0000
Received: from DM5PR1901MB2037.namprd19.prod.outlook.com
 ([fe80::8cb3:ef5b:f815:7d8c]) by DM5PR1901MB2037.namprd19.prod.outlook.com
 ([fe80::8cb3:ef5b:f815:7d8c%4]) with mapi id 15.20.6319.034; Wed, 26 Apr 2023
 22:40:32 +0000
From:   Bernd Schubert <bschubert@ddn.com>
To:     Peter Zijlstra <peterz@infradead.org>
CC:     Ingo Molnar <mingo@redhat.com>, Miklos Szeredi <miklos@szeredi.hu>,
        Dharmendra Singh <dsingh@ddn.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Amir Goldstein <amir73il@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        Hillf Danton <hdanton@sina.com>,
        Andrei Vagin <avagin@gmail.com>
Subject: Re: fuse uring / wake_up on the same core
Thread-Topic: fuse uring / wake_up on the same core
Thread-Index: AQHZXonZnrNnGQvxikaxtbJ88GLEB68OcL2AgC/yZYA=
Date:   Wed, 26 Apr 2023 22:40:32 +0000
Message-ID: <6213ca93-a14c-7900-f6dc-4b8bd8ae2e74@ddn.com>
References: <d0ed1dbd-1b7e-bf98-65c0-7f61dd1a3228@ddn.com>
 <20230327102845.GB7701@hirez.programming.kicks-ass.net>
In-Reply-To: <20230327102845.GB7701@hirez.programming.kicks-ass.net>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=ddn.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM5PR1901MB2037:EE_|MW5PR19MB5652:EE_
x-ms-office365-filtering-correlation-id: b3614eb8-f150-4c06-40e4-08db46a73e4b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 72HDQu8uMbhSSRpkEaknO34/qnjqWoqGt5cKp/TbB35H7g02wW6LQ10z7n2H1N+Drzyr3Ai1Gl5C/bpo0oNZPIyBtHTrdGOwiVwftyF1biKQcPmE3x0nl1mbiJI/i08SDeGQBqGHUBk7mLLCBOr6YSxgWJ8BgXQmyCTVfNH9F+RgMBMiXENdEcoJGK5t3meucDSZu+nxcHzClxJ/xwwqykx5r2BcbtdsF8b4r25GRvY3nit9X06eLLOHTgfTYyse4T1kIr9sSYBFwdVfTfnGSwy3/5LB/CALboObyUeq2fdbuPPFImal8Kapev21yMQ9wx73JEb98ErxziWtOUHm74fBvdXOJaIQvc14fKPxe1oFlupD1puoO8o47mHwUeLRyDHtHtJmbFkN/mANEWBHeOAMhGnu3CsXaQ3SFfBPqaYOVrXIPkWDCwixolzCp2igARAaMrkJyY13IROzSLvUi4qRYuoN4GzNxtcMLmN7mb4WAtb82IYvyjUIyUHsdC5l5sJQEXcJf1jwswruTYQPYn/9F4PPs/+cxqSrcrviaCiQ/jTsri5lL60MAHvhixE+UK/4T+eJRINqqlQAl72tQw8S6KrO2w9CXN/4gB6AmR6hsOa7NubZLRJvd72OtrROLP01Tjj5TrsS5uWbJwh/wW1QRXXDJX2OpB4GGjZzXnY=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR1901MB2037.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(396003)(376002)(366004)(39860400002)(136003)(451199021)(66556008)(8676002)(5660300002)(8936002)(966005)(71200400001)(6486002)(38100700002)(76116006)(91956017)(64756008)(66476007)(66946007)(66446008)(316002)(478600001)(122000001)(41300700001)(36756003)(2616005)(31696002)(6506007)(53546011)(6512007)(4326008)(2906002)(186003)(31686004)(86362001)(83380400001)(54906003)(38070700005)(6916009)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?djE2U1ZWdUR6OGovdUI1c08yREdqUjQ2VjlkSjBIUnBXN01aanMxWGxhNzZN?=
 =?utf-8?B?Qk55Q3p6WXQyVlI4RVZkb3FkY2NjL3ZWRzN0UkRNaW95cHdUZXJSQVJmdWF4?=
 =?utf-8?B?SWd0NG5IZ0J1NVVYRlBtQ1FDT2Z5eE1LY3ZDbjZYS0Qyc0FURTl3VlQ5azJB?=
 =?utf-8?B?Wkg0U29PY3lsc0NzaW9tWGxvd2h3Y1Vaa3dnNjNWRGIxZWxPRndOSy9zRWVh?=
 =?utf-8?B?NE1lSmkzZ3hYSnJsZUw4bStnN3VaWFBlbG9YSkVMbDdsQzNYSnFTRXpHY0F5?=
 =?utf-8?B?bmFLKzEreU91Sm1NQ2lJbE9CM1NPamlPLytSOGlrMHh4dkZjaUxVNU5USHk4?=
 =?utf-8?B?RDd0dmpRclhVcFM4M2ZnUjd3Qy92Zys4QXZ1QWVkeElFdFR6cnl3aitSWGxO?=
 =?utf-8?B?bXA2QzRWc2VwN0ZsSUFkVzE2M3UvcHRUUEhDdEJ5U01NbXhBd1I2ZnlkUzll?=
 =?utf-8?B?UmFLbU85RWF2UW9HdzFCVktGZjMxZGJKUTI3bk56MFljclJVcldSZC9yT3ZE?=
 =?utf-8?B?dEt1dWNIUXo1U3hpeGVnUzR6RUtOUHZNcU1QN29odTYzVTBZcTgyaVIxb0dP?=
 =?utf-8?B?N3oyOWFWODZmaDl6QXhQaUROajFYZE05S2dWWS9hWUdGTGt0VWVFcXF5dDB3?=
 =?utf-8?B?WDJYU3BXTEExTlp3QllGVnd0RkZiazlkVWVIL0NSZS9hd1Q4TG5xSWJJWGJi?=
 =?utf-8?B?Y05GZFBaaGVVc0NoUjgvVUFqc2dRZkpMOWVLWFZ0QkZ3ZjdaWHNLOUJxbVlI?=
 =?utf-8?B?OGs3cmZJT2Z3R2FScktXbzhZY0hkQmkrNVNVN1pyTzdqZzB3U2FJbU9aMjgx?=
 =?utf-8?B?NWI0VWxHM0pSVU9Md2hxYVFLeUo5bHp6eXU0eHc2MUtXL2NBOE52elhCenps?=
 =?utf-8?B?RWJ1R1cyRVRVUUxRUjJDcjNFTVhROW12RzAzTjBBd2s2d3EvNkRoeVBuTDU3?=
 =?utf-8?B?U2Z1ZmJOek1YRVZwVkJueGg3L1Q2MmFiMHRPaFM1MEdWR1RIRlBSdVZsZTA5?=
 =?utf-8?B?anBOVmxNdDZ4U1R6YlNSUm1JNDY3dmRoanVNekMxNWt3cmI5UGM5REVlc2cv?=
 =?utf-8?B?WXFYNnQvS2ZLc2pyMUJjOHR6WGxNT0ZuWlJ4TTZUWS9KUjl4Y2FZTkF6c0xr?=
 =?utf-8?B?NlEvN2hyTVlxU0xObTBsMlhwa1A4QVF4ZlNYYWRPZjB1YXM4dHNuM0I4Nks4?=
 =?utf-8?B?bVhnZlpKRG5ocWtGYTBhQ1l4QlN4NzQxeEZrdVhHeDZWcEhHSGxVb1VoUThv?=
 =?utf-8?B?dVF0QmNWQTUwLzZwNXh4ai9mdDZ4WENWR1FFTGM1ZHpseENYOXhURHo0T21l?=
 =?utf-8?B?MVV0OTdnQjFiL05yRnpnNEZIQWVKVnBMM2pUL1hpNmFMRXdCRzkyVEtNR2Ri?=
 =?utf-8?B?cGw0aEtKem5YbVdoWVkycWVmc2FwZ0MycW95amVoN1YvNHp0RnREMG40WktE?=
 =?utf-8?B?SzNRVzR2Vk9TSVQyT2FFdC9iZVMraE42MlpnL3ZsQ1dIMnlJR3VrOWlaSzcy?=
 =?utf-8?B?RkF1N1QzWDdpbGt4N1FSc2xkVnVPYjY0VGRkczlOUEsva3RxMjBaQVBOR0lF?=
 =?utf-8?B?cG9uZlk1VW41UXR5TmRlVTBNZGsrWnY4VWRWc2VkQmdYOXBUMG10YWtkMG9B?=
 =?utf-8?B?a3Roc2c3ZUlLUmJXQy9tNTF2eU5BSXV3elhEVngvUm5DNkp3dXd6NkFJaVJq?=
 =?utf-8?B?RXpFaVFJQzNMeHRERlM3akl2RDhWM040SE5LMUJwbEhMQUM2MzZSbkt5VVIw?=
 =?utf-8?B?aGJmWExxSTA2VGlTUzJpR2wrRmp2dzVEdFRKbStkNjFDa1RXajJ5ZG5UdjVN?=
 =?utf-8?B?NzRCbzIrbXVwWWhQci9jOGlMSEdVMTlYRXlDQTFoektLTnRMMXF0dU1FdGtw?=
 =?utf-8?B?MmVSdUx5YlNvYStjV0h5Z1VVRFVMNWp3MEV6c3NwTktmVUlpRllWMy91SGdP?=
 =?utf-8?B?WlNLaCs3Yk9DaXFZTE1PdXdCTFZ0YWw0djRYdE8yL3RCUDdvU2NxOU0wQjZj?=
 =?utf-8?B?elcvQWhTQ29JUWZueWMxQWZ0dlR2MHoyRGl6QlAveVhzaHQzNGJzMm9UaHNV?=
 =?utf-8?B?YUJnM2F0dVcxRVhaWThIMnJmaWR3K0daeTVoeFdZVkRUeXVuNWRVdHNCZlBu?=
 =?utf-8?B?ekZnZWdTWVhsdEkrSnU3b3U2MTltVk9xVDFJMlNiQ2FzSi9wOXUyUWMwblMy?=
 =?utf-8?Q?RhEqz2m7QdtfGpkjpUp12OI=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <567337DA84BCE342BE62CCEBE1F6EEC7@namprd19.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: ddn.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR1901MB2037.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3614eb8-f150-4c06-40e4-08db46a73e4b
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Apr 2023 22:40:32.1502
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ODs7eySH4qG4bGwodU8nBast9XYcvdsheIxdQ8Fc/rp8Cflu1TSqxSNpyzmUftUTNEwZlW5xsdbio5qAnlPRKg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR19MB5652
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

T24gMy8yNy8yMyAxMjoyOCwgUGV0ZXIgWmlqbHN0cmEgd3JvdGU6DQo+IE9uIEZyaSwgTWFyIDI0
LCAyMDIzIGF0IDA3OjUwOjEyUE0gKzAwMDAsIEJlcm5kIFNjaHViZXJ0IHdyb3RlOg0KPiANCj4+
IFdpdGggdGhlIGZ1c2UtdXJpbmcgcGF0Y2hlcyB0aGF0IHBhcnQgaXMgYmFzaWNhbGx5IHNvbHZl
ZCAtIHRoZSB3YWl0cQ0KPj4gdGhhdCB0aGF0IHRocmVhZCBpcyBhYm91dCBpcyBub3QgdXNlZCBh
bnltb3JlLiBCdXQgYXMgcGVyIGFib3ZlLA0KPj4gcmVtYWluaW5nIGlzIHRoZSB3YWl0cSBvZiB0
aGUgaW5jb21pbmcgd29ya3EgKG5vdCBtZW50aW9uZWQgaW4gdGhlDQo+PiB0aHJlYWQgYWJvdmUp
LiBBcyBJIHdyb3RlLCBJIGhhdmUgdHJpZWQNCj4+IF9fd2FrZV91cF9zeW5jKCh4KSwgVEFTS19O
T1JNQUwpLCBidXQgaXQgZG9lcyBub3QgbWFrZSBhIGRpZmZlcmVuY2UgZm9yDQo+PiBtZSAtIHNp
bWlsYXIgdG8gTWlrbG9zJyB0ZXN0aW5nIGJlZm9yZS4gSSBoYXZlIGFsc28gdHJpZWQgc3RydWN0
DQo+PiBjb21wbGV0aW9uIC8gc3dhaXQgLSBkb2VzIG5vdCBtYWtlIGEgZGlmZmVyZW5jZSBlaXRo
ZXIuDQo+PiBJIGNhbiBzZWUgdGFza19zdHJ1Y3QgaGFzIHdha2VfY3B1LCBidXQgdGhlcmUgZG9l
c24ndCBzZWVtIHRvIGJlIGEgZ29vZA0KPj4gaW50ZXJmYWNlIHRvIHNldCBpdC4NCj4+DQo+PiBB
bnkgaWRlYXM/DQo+IA0KPiBEb2VzIHRoZSBzdHVmZiBmcm9tOg0KPiANCj4gICAgaHR0cHM6Ly9s
a21sLmtlcm5lbC5vcmcvci8yMDIzMDMwODA3MzIwMS4zMTAyNzM4LTEtYXZhZ2luQGdvb2dsZS5j
b20NCg0KVGhhbmtzIFBldGVyLCBJIGhhdmUgYWxyZWFkeSByZXBsaWVkIGluIHRoYXQgdGhyZWFk
IC0gdXNpbmcgDQpfX3dha2VfdXBfb25fY3VycmVudF9jcHUoKSBoZWxwcyB0byBhdm9pZCBjcHUg
bWlncmF0aW9ucy4gV2VsbCwgc29tZSANCnVwZGF0ZSBzaW5jZSBteSBsYXN0IG1haWwgaW4gdGhh
dCB0aHJlYWQgKGEgZmV3IGhvdXJzIGFnbyksIG1vcmUgbG9nZ2luZyANCnJldmVhbHMgdGhhdCBJ
IHN0aWxsIHNlZSBhIGZldyBjcHUgc3dpdGNoZXMsIGJ1dCBub3RoaW5nIGNvbXBhcmVkIHRvIA0K
d2hhdCBJIGhhZCBiZWZvcmUuDQpNeSBpc3N1ZSBpcyBub3cgdGhhdCB0aGVzZSBwYXRjaGVzIGFy
ZSBub3QgZW5vdWdoIGFuZCBjb250cmFyeSB0byANCnByZXZpb3VzIHRlc3RpbmcsIGZvcmNlZnVs
bHkgZGlzYWJsaW5nIGNwdSBtaWdyYXRpb24gdXNpbmcgDQptaWdyYXRlX2Rpc2FibGUoKSBiZWZv
cmUgd2FpdF9ldmVudF8qIGluIGZ1c2UncyByZXF1ZXN0X3dhaXRfYW5zd2VyKCkNCmFuZCBlbmFi
bGluZyBpdCBhZnRlciBkb2VzIG5vdCBoZWxwIGVpdGhlciAtIG15IHByb2Nlc3MgdG8gY3JlYXRl
IGZpbGVzDQooYm9ubmllKyspIHNvbWV3aGVyZSBtaWdyYXRlcyB0byBhbm90aGVyIGNwdSBhdCBh
IGxhdGVyIHRpbWUuDQpUaGUgb25seSB3b3JrYXJvdW5kIEkgY3VycmVudGx5IGhhdmUgaXMgdG8g
c2V0IHRoZSByaW5nIHRocmVhZCANCnByb2Nlc3NpbmcgdmZzL2Z1c2UgZXZlbnRzIGluIHVzZXJz
cGFjZSB0byBTQ0hFRF9JRExFLiBJbiBjb21iaW5hdGlvbiANCndpdGggV0ZfQ1VSUkVOVF9DUFUg
cGVyZm9ybWFuY2UgdGhlbiBnb2VzIGZyb20gfjIyMDAgdG8gfjkwMDAgZmlsZSANCmNyZWF0ZXMv
cyBmb3IgYSBzaW5nbGUgdGhyZWFkIGluIHRoZSBsYXRlc3QgYnJhbmNoIChzaG91bGQgYmUgc2Nh
bGFibGUpLiANCldoaWNoIGlzIHZlcnkgY2xvc2UgdG8gYmluZGluZyB0aGUgYm9ubmllKysgcHJv
Y2VzcyB0byBhIHNpbmdsZSBjb3JlIA0KKH45NDAwIGNyZWF0ZXMvcykuDQoNCklzIHRoZXJlIHNv
bWV0aGluZyBhdmFpbGFibGUgdG8gbWFyayByaW5nIHRocmVhZHMgYXMgSU8gcHJvY2Vzc2luZyBh
bmQgDQp0aGF0IHRoZXJlIGlzIG5vIG5lZWQgdG8gbWlncmF0ZSBhd2F5IHRoZSBzdWJtaXR0aW5n
IHRocmVhZCBmcm9tIElPIA0KdGhyZWFkcz8NCg0KKiBhcHBsaWNhdGlvbiBzZW5kcyByZXF1ZXN0
IC0+IGZvcndhcmRzIHRvIHJpbmcgYW5kIHdha2UgcmluZyAgLT4gd2FpdA0KKiByaW5nIHdha2Vz
IHVwIChjb3JlIGJvdW5kKSAtPiBwcm9jZXNzIHJlcXVlc3QgLT4gc2VuZHMgY29tcGxldGlvbiAt
PiANCndha2UgdXAgYXBwbGljYXRpb24gLT4gd2FpdCBmb3IgbmV4dCByZXF1ZXN0DQoqIGFwcGxp
Y2F0aW9uIHdha2VzIHVwIHdpdGggcmVxdWVzdCByZXN1bHQNCg0KPT0+IEkgZG9uJ3QgdW5kZXJz
dGFuZCB3aHkgdGhlIGFwcGxpY2F0aW9uIGlzIG1vdmVkIHRvIGFub3RoZXIgcHJvY2VzcyANCmF0
IGFsbCwgYWZ0ZXIgdGhlIHdha2UgaXNzdWUgaXMgZWxpbWluYXRlZC4NCg0KSSBhbHNvIG9ubHkg
c2VlIFNDSEVEX0lETEUgb25seSBhcyB3b3JrYXJvdW5kLCBhcyBpdCB3b3VsZCBsaWtlbHkgaGF2
ZSANCnNpZGUgZWZmZWN0cyBpZiB0aGVyZSBpcyBhbnl0aGluZyBlbHNlIHJ1bm5pbmcgb24gdGhl
IHN5c3RlbSBhbmQgd291bGQgDQpjb25zdW1lIGNwdXMgd2hpbGUgYW5vdGhlciBwcm9jZXNzIGlz
IGRvaW5nIElPLg0KSXMgdGhlcmUgYSB3YXkgdG8gdHJhY2Ugd2hlcmUgYW5kIHdoeSBhIHByb2Nl
c3MgaXMgbWlncmF0ZWQgYXdheT8NCg0KDQpUaGFua3MsDQpCZXJuZA0KDQo=

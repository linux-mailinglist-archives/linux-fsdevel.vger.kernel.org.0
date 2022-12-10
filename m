Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B8D4648DDD
	for <lists+linux-fsdevel@lfdr.de>; Sat, 10 Dec 2022 10:18:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229656AbiLJJSs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 10 Dec 2022 04:18:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbiLJJSp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 10 Dec 2022 04:18:45 -0500
Received: from mx6.didiglobal.com (mx6.didiglobal.com [111.202.70.123])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 542E7C33;
        Sat, 10 Dec 2022 01:18:42 -0800 (PST)
Received: from mail.didiglobal.com (unknown [10.79.71.36])
        by mx6.didiglobal.com (Maildata Gateway V2.8) with ESMTPS id 03A5211053D427;
        Sat, 10 Dec 2022 17:18:40 +0800 (CST)
Received: from ZJY03-ACTMBX-05.didichuxing.com (10.79.71.35) by
 ZJY03-ACTMBX-06.didichuxing.com (10.79.71.36) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Sat, 10 Dec 2022 17:18:39 +0800
Received: from ZJY03-ACTMBX-05.didichuxing.com ([fe80::1dcd:f7bf:746e:c769])
 by ZJY03-ACTMBX-05.didichuxing.com ([fe80::1dcd:f7bf:746e:c769%8]) with mapi
 id 15.01.2375.017; Sat, 10 Dec 2022 17:18:39 +0800
X-MD-Sfrom: chengkaitao@didiglobal.com
X-MD-SrcIP: 10.79.71.36
From:   =?utf-8?B?56iL5Z6y5rabIENoZW5na2FpdGFvIENoZW5n?= 
        <chengkaitao@didiglobal.com>
To:     Michal Hocko <mhocko@suse.com>
CC:     chengkaitao <pilgrimtao@gmail.com>,
        "tj@kernel.org" <tj@kernel.org>,
        "lizefan.x@bytedance.com" <lizefan.x@bytedance.com>,
        "hannes@cmpxchg.org" <hannes@cmpxchg.org>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "roman.gushchin@linux.dev" <roman.gushchin@linux.dev>,
        "shakeelb@google.com" <shakeelb@google.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "songmuchun@bytedance.com" <songmuchun@bytedance.com>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "zhengqi.arch@bytedance.com" <zhengqi.arch@bytedance.com>,
        "ebiederm@xmission.com" <ebiederm@xmission.com>,
        "Liam.Howlett@oracle.com" <Liam.Howlett@oracle.com>,
        "chengzhihao1@huawei.com" <chengzhihao1@huawei.com>,
        "haolee.swjtu@gmail.com" <haolee.swjtu@gmail.com>,
        "yuzhao@google.com" <yuzhao@google.com>,
        "willy@infradead.org" <willy@infradead.org>,
        "vasily.averin@linux.dev" <vasily.averin@linux.dev>,
        "vbabka@suse.cz" <vbabka@suse.cz>,
        "surenb@google.com" <surenb@google.com>,
        "sfr@canb.auug.org.au" <sfr@canb.auug.org.au>,
        "mcgrof@kernel.org" <mcgrof@kernel.org>,
        "sujiaxun@uniontech.com" <sujiaxun@uniontech.com>,
        "feng.tang@intel.com" <feng.tang@intel.com>,
        "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: Re: [PATCH v2] mm: memcontrol: protect the memory in cgroup from
 being oom killed
Thread-Topic: [PATCH v2] mm: memcontrol: protect the memory in cgroup from
 being oom killed
Thread-Index: AQHZCrfAdhr5zYTMtke9YS08C4BFfq5jExWAgACNdAD//34EAIAA6LeA//9+mQCAAXznAP//sVGAAEToU4A=
Date:   Sat, 10 Dec 2022 09:18:39 +0000
Message-ID: <395B1998-38A9-4A68-96F8-6EDF44686231@didiglobal.com>
In-Reply-To: <Y5LxAbOB2AYp42hi@dhcp22.suse.cz>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.79.65.101]
Content-Type: text/plain; charset="utf-8"
Content-ID: <2748C5543D3A014D8665D39D4181F452@didichuxing.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

QXQgMjAyMi0xMi0wOSAxNjoyNTozNywgIk1pY2hhbCBIb2NrbyIgPG1ob2Nrb0BzdXNlLmNvbT4g
d3JvdGU6DQo+T24gRnJpIDA5LTEyLTIyIDA1OjA3OjE1LCDnqIvlnrLmtpsgQ2hlbmdrYWl0YW8g
Q2hlbmcgd3JvdGU6DQo+PiBBdCAyMDIyLTEyLTA4IDIyOjIzOjU2LCAiTWljaGFsIEhvY2tvIiA8
bWhvY2tvQHN1c2UuY29tPiB3cm90ZToNCj5bLi4uXQ0KPj4gPm9vbSBraWxsZXIgaXMgYSBtZW1v
cnkgcmVjbGFpbSBvZiB0aGUgbGFzdCByZXNvcnQuIFNvIHllcywgdGhlcmUgaXMgc29tZQ0KPj4g
PmRpZmZlcmVuY2UgYnV0IGZ1bmRhbWVudGFsbHkgaXQgaXMgYWJvdXQgcmVsZWFzaW5nIHNvbWUg
bWVtb3J5LiBBbmQgbG9uZw0KPj4gPnRlcm0gd2UgaGF2ZSBsZWFybmVkIHRoYXQgdGhlIG1vcmUg
Y2xldmVyIGl0IHRyaWVzIHRvIGJlIHRoZSBtb3JlIGxpa2VseQ0KPj4gPmNvcm5lciBjYXNlcyBj
YW4gaGFwcGVuLiBJdCBpcyBzaW1wbHkgaW1wb3NzaWJsZSB0byBrbm93IHRoZSBiZXN0DQo+PiA+
Y2FuZGlkYXRlIHNvIHRoaXMgaXMgYSBqdXN0IGEgYmVzdCBlZmZvcnQuIFdlIHRyeSB0byBhaW0g
Zm9yDQo+PiA+cHJlZGljdGFiaWxpdHkgYXQgbGVhc3QuDQo+PiANCj4+IElzIHRoZSBjdXJyZW50
IG9vbV9zY29yZSBzdHJhdGVneSBwcmVkaWN0YWJsZT8gSSBkb24ndCB0aGluayBzby4gVGhlIHNj
b3JlX2FkaiANCj4+IGhhcyBicm9rZW4gdGhlIHByZWRpY3RhYmlsaXR5IG9mIG9vbV9zY29yZSAo
aXQgaXMgbm8gbG9uZ2VyIHNpbXBseSBraWxsaW5nIHRoZSANCj4+IHByb2Nlc3MgdGhhdCB1c2Vz
IHRoZSBtb3N0IG1lbXMpLg0KPg0KPm9vbV9zY29yZSBhcyByZXBvcnRlZCB0byB0aGUgdXNlcnNw
YWNlIGFscmVhZHkgY29uc2lkZXJzIG9vbV9zY29yZV9hZGoNCj53aGljaCBtZWFucyB0aGF0IHlv
dSBjYW4gY29tcGFyZSBwcm9jZXNzZXMgYW5kIGdldCBhIHJlYXNvbmFibGUgZ3Vlc3MNCj53aGF0
IHdvdWxkIGJlIHRoZSBjdXJyZW50IG9vbV92aWN0aW0uIFRoZXJlIGlzIGEgY2VydGFpbiBmdXp6
IGxldmVsDQo+YmVjYXVzZSB0aGlzIGlzIG5vdCBhdG9taWMgYW5kIGFsc28gdGhlcmUgaXMgbm8g
Y2xlYXIgY2FuZGlkYXRlIHdoZW4NCj5tdWx0aXBsZSBwcm9jZXNzZXMgaGF2ZSBlcXVhbCBzY29y
ZS4gDQoNCk11bHRpcGxlIHByb2Nlc3NlcyBoYXZlIHRoZSBzYW1lIHNjb3JlLCB3aGljaCBtZWFu
cyBpdCBpcyByZWFzb25hYmxlIHRvIGtpbGwgDQphbnkgb25lLiBXaHkgbXVzdCB3ZSBkZXRlcm1p
bmUgd2hpY2ggb25lIGlzPw0KDQo+IFNvIHllcywgaXQgaXMgbm90IDEwMCUgcHJlZGljdGFibGUu
DQo+bWVtb3J5LnJlY2xhaW0gYXMgeW91IHByb3Bvc2UgZG9lc24ndCBjaGFuZ2UgdGhhdCB0aG91
Z2guDQo+DQpUaGlzIHNjaGVtZSBpcyB0byBnaXZlIHRoZSBkZWNpc2lvbiBwb3dlciBvZiB0aGUg
Y2FuZGlkYXRlIHRvIHRoZSB1c2VyLiANClRoZSB1c2VyJ3MgYmVoYXZpb3IgaXMgcmFuZG9tLiBJ
IHRoaW5rIGl0IGlzIGltcG9zc2libGUgdG8gMTAwJSBwcmVkaWN0IA0KYSByYW5kb20gZXZlbnQu
DQoNCklzIGl0IHJlYWxseSBuZWNlc3NhcnkgdG8gbWFrZSBldmVyeXRoaW5nIDEwMCUgcHJlZGlj
dGFibGU/IEp1c3QgYXMgd2UgY2FuJ3QgDQphY2N1cmF0ZWx5IHByZWRpY3Qgd2hpY2ggY2dyb3Vw
IHdpbGwgYWNjZXNzIHRoZSBwYWdlIGNhY2hlIGZyZXF1ZW50bHksIA0Kd2UgY2FuJ3QgYWNjdXJh
dGVseSBwcmVkaWN0IHdoZXRoZXIgdGhlIG1lbW9yeSBpcyBob3Qgb3IgY29sZC4gVGhlc2UgDQpz
dHJhdGVnaWVzIGFyZSBmdXp6eSwgYnV0IHdlIGNhbid0IGRlbnkgdGhlaXIgcmF0aW9uYWxpdHku
DQoNCj5JcyBvb21fc2NvcmVfYWRqIGEgZ29vZCBpbnRlcmZhY2U/IE5vLCBub3QgcmVhbGx5LiBJ
ZiBJIGNvdWxkIGdvIGJhY2sgaW4NCj50aW1lIEkgd291bGQgbmFjayBpdCBidXQgaGVyZSB3ZSBh
cmUuIFdlIGhhdmUgYW4gaW50ZXJmYWNlIHRoYXQNCj5wcm9taXNlcyBxdWl0ZSBtdWNoIGJ1dCBl
c3NlbnRpYWxseSBpdCBvbmx5IGFsbG93cyB0d28gdXNlY2FzZXMNCj4oT09NX1NDT1JFX0FESl9N
SU4sIE9PTV9TQ09SRV9BREpfTUFYKSByZWxpYWJseS4gRXZlcnl0aGluZyBpbiBiZXR3ZWVuDQo+
aXMgY2x1bXN5IGF0IGJlc3QgYmVjYXVzZSBhIHJlYWwgdXNlciBzcGFjZSBvb20gcG9saWN5IHdv
dWxkIHJlcXVpcmUgdG8NCj5yZS1ldmFsdWF0ZSB0aGUgd2hvbGUgb29tIGRvbWFpbiAoYmUgaXQg
Z2xvYmFsIG9yIG1lbWNnIG9vbSkgYXMgdGhlDQo+bWVtb3J5IGNvbnN1bXB0aW9uIGV2b2x2ZXMg
b3ZlciB0aW1lLiBJIGFtIHJlYWxseSB3b3JyaWVkIHRoYXQgeW91cg0KPm1lbW9yeS5vb20ucHJv
dGVjdGlvbiBkaXJlY3RzIGEgdmVyeSBzaW1pbGFyIHRyYWplY3RvcnkgYmVjYXVzZQ0KPnByb3Rl
Y3Rpb24gcmVhbGx5IG5lZWRzIHRvIGNvbnNpZGVyIG90aGVyIG1lbWNncyB0byBiYWxhbmNlIHBy
b3Blcmx5Lg0KPg0KVGhlIHNjb3JlX2FkaiBpcyBhbiBpbnRlcmZhY2UgdGhhdCBwcm9taXNlcyBx
dWl0ZSBtdWNoLiBJIHRoaW5rIHRoZSByZWFzb24gDQp3aHkgb25seSB0d28gdXNlY2FzZXMgKE9P
TV9TQ09SRV9BREpfTUlOLCBPT01fU0NPUkVfQURKX01BWCkgDQphcmUgcmVsaWFibGUgaXMgdGhh
dCB1c2VyIGNhbm5vdCBldmFsdWF0ZSB0aGUgcHJpb3JpdHkgbGV2ZWwgb2YgYWxsIHByb2Nlc3Nl
cyBpbiANCnRoZSBwaHlzaWNhbCBtYWNoaW5lLiBJZiB0aGVyZSBpcyBhIGFnZW50IHByb2Nlc3Mg
aW4gdGhlIHBoeXNpY2FsIG1hY2hpbmUsIA0Kd2hpY2ggY2FuIGFjY3VyYXRlbHkgZGl2aWRlIGFs
bCB0aGUgdXNlciBwcm9jZXNzZXMgb2YgdGhlIHBoeXNpY2FsIG1hY2hpbmUgDQppbnRvIGRpZmZl
cmVudCBsZXZlbHMsIG90aGVyIHVzZWNhc2VzIG9mIHRoZSBzY29yZV9hZGogd2lsbCBiZSB3ZWxs
IGFwcGxpZWQsIA0KYnV0IGl0IGlzIGFsbW9zdCBpbXBvc3NpYmxlIHRvIGFjaGlldmUgaW4gcmVh
bCBsaWZlLg0KDQpUaGVyZSBpcyBhbiBleGFtcGxlIG9mIHRoZSBwcmFjdGljYWwgYXBwbGljYXRp
b24NCkt1YmVsZXQgd2lsbCBzZXQgdGhlIHNjb3JlX2FkaiBvZiBkb2NrZXJpbml0IHByb2Nlc3Mg
b2YgYWxsIGJ1cnN0YWJsZXIgY29udGFpbmVycywgDQp0aGUgc2V0dGluZyBzcGVjaWZpY2F0aW9u
IGZvbGxvd3MgdGhlIGZvbGxvd2luZyBmb3JtdWxhLA0KDQpzY29yZV9hZGogPSAxMDAwIC0gcmVx
dWVzdCAqIDEwMDAgLyB0b3RhbHBhZ2VzDQoocmVxdWVzdCA9ICJGaXhlZCBjb2VmZmljaWVudCIg
KiAibWVtb3J5Lm1heCIpDQoNCkJlY2F1c2Uga3ViZWxldCBoYXMgYSBjbGVhciB1bmRlcnN0YW5k
aW5nIG9mIGFsbCB0aGUgY29udGFpbmVyIG1lbW9yeSBiZWhhdmlvciANCmF0dHJpYnV0ZXMgaW4g
dGhlIHBoeXNpY2FsIG1hY2hpbmUsIGl0IGNhbiB1c2UgbW9yZSBzY29yZV9hZGogdXNlY2FzZXMu
IFRoZSANCmFkdmFudGFnZSBvZiB0aGUgb29tLnByb3RyY3QgaXMgdGhhdCB1c2VycyBkbyBub3Qg
bmVlZCB0byBoYXZlIGEgY2xlYXIgdW5kZXJzdGFuZGluZyANCm9mIGFsbCB0aGUgcHJvY2Vzc2Vz
IGluIHRoZSBwaHlzaWNhbCBtYWNoaW5lLCB0aGV5IG9ubHkgbmVlZCB0byBoYXZlIGEgY2xlYXIg
DQp1bmRlcnN0YW5kaW5nIG9mIGFsbCB0aGUgcHJvY2Vzc2VzIGludCBsb2NhbCBjZ3JvdXAuIEkg
dGhpbmsgdGhlIHJlcXVpcmVtZW50IGlzIHZlcnkgDQplYXN5IHRvIGFjaGlldmUuDQoNCj5bLi4u
XQ0KPg0KPj4gPiBCdXQgSSBhbSByZWFsbHkgb3Blbg0KPj4gPnRvIGJlIGNvbnZpbmNlZCBvdGhl
cndpc2UgYW5kIHRoaXMgaXMgaW4gZmFjdCB3aGF0IEkgaGF2ZSBiZWVuIGFza2luZw0KPj4gPmZv
ciBzaW5jZSB0aGUgYmVnaW5uaW5nLiBJIHdvdWxkIGxvdmUgdG8gc2VlIHNvbWUgZXhhbXBsZXMg
b24gdGhlDQo+PiA+cmVhc29uYWJsZSBjb25maWd1cmF0aW9uIGZvciBhIHByYWN0aWNhbCB1c2Vj
YXNlLg0KPj4gDQo+PiBIZXJlIGlzIGEgc2ltcGxlIGV4YW1wbGUuIEluIGEgZG9ja2VyIGNvbnRh
aW5lciwgdXNlcnMgY2FuIGRpdmlkZSBhbGwgcHJvY2Vzc2VzIA0KPj4gaW50byB0d28gY2F0ZWdv
cmllcyAoaW1wb3J0YW50IGFuZCBub3JtYWwpLCBhbmQgcHV0IHRoZW0gaW4gZGlmZmVyZW50IGNn
cm91cHMuIA0KPj4gT25lIGNncm91cCdzIG9vbS5wcm90ZWN0IGlzIHNldCB0byAibWF4IiwgdGhl
IG90aGVyIGlzIHNldCB0byAiMCIuIEluIHRoaXMgd2F5LCANCj4+IGltcG9ydGFudCBwcm9jZXNz
ZXMgaW4gdGhlIGNvbnRhaW5lciBjYW4gYmUgcHJvdGVjdGVkLg0KPg0KPlRoYXQgaXMgZWZmZWN0
aXZlbGx5IG9vbV9zY29yZV9hZGogPSBPT01fU0NPUkVfQURKX01JTiAtIDEgdG8gYWxsDQo+cHJv
Y2Vzc2VzIGluIHRoZSBpbXBvcnRhbnQgZ3JvdXAuIEkgd291bGQgYXJndWUgeW91IGNhbiBhY2hp
ZXZlIGEgdmVyeQ0KPnNpbWlsYXIgcmVzdWx0IGJ5IHRoZSBwcm9jZXNzIGxhdW5jaGVyIHRvIHNl
dCB0aGUgb29tX3Njb3JlX2FkaiBhbmQNCj5pbmhlcml0IGl0IHRvIGFsbCBwcm9jZXNzZXMgaW4g
dGhhdCBpbXBvcnRhbnQgY29udGFpbmVyLiBZb3UgZG8gbm90IG5lZWQNCj5hbnkgbWVtY2cgdHVu
YWJsZSBmb3IgdGhhdC4gDQoNCllvdXIgbWV0aG9kIGlzIG5vdCBmZWFzaWJsZS4gUGxlYXNlIHJl
ZmVyIHRvIHRoZSBwcmV2aW91cyBlbWFpbA0KaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGludXgt
bW0vRTVBNUJDQzMtNDYwRS00RTgxLThERDMtODhCNEEyODY4Mjg1QGRpZGlnbG9iYWwuY29tLw0K
KiB1c2VjYXNlcyAxOiB1c2VycyBzYXkgdGhhdCB0aGV5IHdhbnQgdG8gcHJvdGVjdCBhbiBpbXBv
cnRhbnQgcHJvY2VzcyANCiogd2l0aCBoaWdoIG1lbW9yeSBjb25zdW1wdGlvbiBmcm9tIGJlaW5n
IGtpbGxlZCBieSB0aGUgb29tIGluIGNhc2UgDQoqIG9mIGRvY2tlciBjb250YWluZXIgZmFpbHVy
ZSwgc28gYXMgdG8gcmV0YWluIG1vcmUgY3JpdGljYWwgb24tc2l0ZSANCiogaW5mb3JtYXRpb24g
b3IgYSBzZWxmIHJlY292ZXJ5IG1lY2hhbmlzbS4gQXQgdGhpcyB0aW1lLCB0aGV5IHN1Z2dlc3Qg
DQoqIHNldHRpbmcgdGhlIHNjb3JlX2FkaiBvZiB0aGlzIHByb2Nlc3MgdG8gLTEwMDAsIGJ1dCBJ
IGRvbid0IGFncmVlIHdpdGggDQoqIGl0LCBiZWNhdXNlIHRoZSBkb2NrZXIgY29udGFpbmVyIGlz
IG5vdCBpbXBvcnRhbnQgdG8gb3RoZXIgZG9ja2VyIA0KKiBjb250YWluZXJzIG9mIHRoZSBzYW1l
IHBoeXNpY2FsIG1hY2hpbmUuIElmIHNjb3JlX2FkaiBvZiB0aGUgcHJvY2VzcyANCiogaXMgc2V0
IHRvIC0xMDAwLCB0aGUgcHJvYmFiaWxpdHkgb2Ygb29tIGluIG90aGVyIGNvbnRhaW5lciBwcm9j
ZXNzZXMgd2lsbCANCiogaW5jcmVhc2UuDQoNCj5JIGFtIHJlYWxseSBtdWNoIG1vcmUgaW50ZXJl
c3RlZCBpbiBleGFtcGxlcw0KPndoZW4gdGhlIHByb3RlY3Rpb24gaXMgdG8gYmUgZmluZSB0dW5l
ZC4NCi0tIA0KVGhhbmtzIGZvciB5b3VyIGNvbW1lbnQhDQpjaGVuZ2thaXRhbw0KDQoNCg==

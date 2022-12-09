Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39DA0647D25
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Dec 2022 06:07:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229640AbiLIFHZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 9 Dec 2022 00:07:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbiLIFHX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 9 Dec 2022 00:07:23 -0500
Received: from mx6.didiglobal.com (mx6.didiglobal.com [111.202.70.123])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 047056D7D1;
        Thu,  8 Dec 2022 21:07:17 -0800 (PST)
Received: from mail.didiglobal.com (unknown [10.79.65.15])
        by mx6.didiglobal.com (Maildata Gateway V2.8) with ESMTPS id AD30211053B806;
        Fri,  9 Dec 2022 13:07:15 +0800 (CST)
Received: from ZJY03-ACTMBX-05.didichuxing.com (10.79.71.35) by
 ZJY02-ACTMBX-05.didichuxing.com (10.79.65.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Fri, 9 Dec 2022 13:07:15 +0800
Received: from ZJY03-ACTMBX-05.didichuxing.com ([fe80::1dcd:f7bf:746e:c769])
 by ZJY03-ACTMBX-05.didichuxing.com ([fe80::1dcd:f7bf:746e:c769%8]) with mapi
 id 15.01.2375.017; Fri, 9 Dec 2022 13:07:15 +0800
X-MD-Sfrom: chengkaitao@didiglobal.com
X-MD-SrcIP: 10.79.65.15
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
Thread-Index: AQHZCrfAdhr5zYTMtke9YS08C4BFfq5jExWAgACNdAD//34EAIAA6LeA//9+mQCAAXznAA==
Date:   Fri, 9 Dec 2022 05:07:15 +0000
Message-ID: <114DF8F0-3E68-4F2B-8E35-0943EC2F51AE@didiglobal.com>
In-Reply-To: <Y5HzfLB7lu4+BOu1@dhcp22.suse.cz>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.79.64.101]
Content-Type: text/plain; charset="utf-8"
Content-ID: <DA91DED913509948B405E42D422872D4@didichuxing.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

QXQgMjAyMi0xMi0wOCAyMjoyMzo1NiwgIk1pY2hhbCBIb2NrbyIgPG1ob2Nrb0BzdXNlLmNvbT4g
d3JvdGU6DQo+T24gVGh1IDA4LTEyLTIyIDE0OjA3OjA2LCDnqIvlnrLmtpsgQ2hlbmdrYWl0YW8g
Q2hlbmcgd3JvdGU6DQo+PiBBdCAyMDIyLTEyLTA4IDE2OjE0OjEwLCAiTWljaGFsIEhvY2tvIiA8
bWhvY2tvQHN1c2UuY29tPiB3cm90ZToNCj4+ID5PbiBUaHUgMDgtMTItMjIgMDc6NTk6MjcsIOeo
i+Wesua2myBDaGVuZ2thaXRhbyBDaGVuZyB3cm90ZToNCj4+ID4+IEF0IDIwMjItMTItMDggMTU6
MzM6MDcsICJNaWNoYWwgSG9ja28iIDxtaG9ja29Ac3VzZS5jb20+IHdyb3RlOg0KPj4gPj4gPk9u
IFRodSAwOC0xMi0yMiAxMTo0Njo0NCwgY2hlbmdrYWl0YW8gd3JvdGU6DQo+PiA+PiA+PiBGcm9t
OiBjaGVuZ2thaXRhbyA8cGlsZ3JpbXRhb0BnbWFpbC5jb20+DQo+PiA+PiA+PiANCj4+ID4+ID4+
IFdlIGNyZWF0ZWQgYSBuZXcgaW50ZXJmYWNlIDxtZW1vcnkub29tLnByb3RlY3Q+IGZvciBtZW1v
cnksIElmIHRoZXJlIGlzDQo+PiA+PiA+PiB0aGUgT09NIGtpbGxlciB1bmRlciBwYXJlbnQgbWVt
b3J5IGNncm91cCwgYW5kIHRoZSBtZW1vcnkgdXNhZ2Ugb2YgYQ0KPj4gPj4gPj4gY2hpbGQgY2dy
b3VwIGlzIHdpdGhpbiBpdHMgZWZmZWN0aXZlIG9vbS5wcm90ZWN0IGJvdW5kYXJ5LCB0aGUgY2dy
b3VwJ3MNCj4+ID4+ID4+IHRhc2tzIHdvbid0IGJlIE9PTSBraWxsZWQgdW5sZXNzIHRoZXJlIGlz
IG5vIHVucHJvdGVjdGVkIHRhc2tzIGluIG90aGVyDQo+PiA+PiA+PiBjaGlsZHJlbiBjZ3JvdXBz
LiBJdCBkcmF3cyBvbiB0aGUgbG9naWMgb2YgPG1lbW9yeS5taW4vbG93PiBpbiB0aGUNCj4+ID4+
ID4+IGluaGVyaXRhbmNlIHJlbGF0aW9uc2hpcC4NCj4+ID4+ID4+IA0KPj4gPj4gPj4gSXQgaGFz
IHRoZSBmb2xsb3dpbmcgYWR2YW50YWdlcywNCj4+ID4+ID4+IDEuIFdlIGhhdmUgdGhlIGFiaWxp
dHkgdG8gcHJvdGVjdCBtb3JlIGltcG9ydGFudCBwcm9jZXNzZXMsIHdoZW4gdGhlcmUNCj4+ID4+
ID4+IGlzIGEgbWVtY2cncyBPT00ga2lsbGVyLiBUaGUgb29tLnByb3RlY3Qgb25seSB0YWtlcyBl
ZmZlY3QgbG9jYWwgbWVtY2csDQo+PiA+PiA+PiBhbmQgZG9lcyBub3QgYWZmZWN0IHRoZSBPT00g
a2lsbGVyIG9mIHRoZSBob3N0Lg0KPj4gPj4gPj4gMi4gSGlzdG9yaWNhbGx5LCB3ZSBjYW4gb2Z0
ZW4gdXNlIG9vbV9zY29yZV9hZGogdG8gY29udHJvbCBhIGdyb3VwIG9mDQo+PiA+PiA+PiBwcm9j
ZXNzZXMsIEl0IHJlcXVpcmVzIHRoYXQgYWxsIHByb2Nlc3NlcyBpbiB0aGUgY2dyb3VwIG11c3Qg
aGF2ZSBhDQo+PiA+PiA+PiBjb21tb24gcGFyZW50IHByb2Nlc3Nlcywgd2UgaGF2ZSB0byBzZXQg
dGhlIGNvbW1vbiBwYXJlbnQgcHJvY2VzcydzDQo+PiA+PiA+PiBvb21fc2NvcmVfYWRqLCBiZWZv
cmUgaXQgZm9ya3MgYWxsIGNoaWxkcmVuIHByb2Nlc3Nlcy4gU28gdGhhdCBpdCBpcw0KPj4gPj4g
Pj4gdmVyeSBkaWZmaWN1bHQgdG8gYXBwbHkgaXQgaW4gb3RoZXIgc2l0dWF0aW9ucy4gTm93IG9v
bS5wcm90ZWN0IGhhcyBubw0KPj4gPj4gPj4gc3VjaCByZXN0cmljdGlvbnMsIHdlIGNhbiBwcm90
ZWN0IGEgY2dyb3VwIG9mIHByb2Nlc3NlcyBtb3JlIGVhc2lseS4gVGhlDQo+PiA+PiA+PiBjZ3Jv
dXAgY2FuIGtlZXAgc29tZSBtZW1vcnksIGV2ZW4gaWYgdGhlIE9PTSBraWxsZXIgaGFzIHRvIGJl
IGNhbGxlZC4NCj4+ID4+ID4+IA0KPj4gPj4gPj4gU2lnbmVkLW9mZi1ieTogY2hlbmdrYWl0YW8g
PHBpbGdyaW10YW9AZ21haWwuY29tPg0KPj4gPj4gPj4gLS0tDQo+PiA+PiA+PiB2MjogTW9kaWZ5
IHRoZSBmb3JtdWxhIG9mIHRoZSBwcm9jZXNzIHJlcXVlc3QgbWVtY2cgcHJvdGVjdGlvbiBxdW90
YS4NCj4+ID4+ID4NCj4+ID4+ID5UaGUgbmV3IGZvcm11bGEgZG9lc24ndCByZWFsbHkgYWRkcmVz
cyBjb25jZXJucyBleHByZXNzZWQgcHJldmlvdXNseS4NCj4+ID4+ID5QbGVhc2UgcmVhZCBteSBm
ZWVkYmFjayBjYXJlZnVsbHkgYWdhaW4gYW5kIGZvbGxvdyB1cCB3aXRoIHF1ZXN0aW9ucyBpZg0K
Pj4gPj4gPnNvbWV0aGluZyBpcyBub3QgY2xlYXIuDQo+PiA+PiANCj4+ID4+IFRoZSBwcmV2aW91
cyBkaXNjdXNzaW9uIHdhcyBxdWl0ZSBzY2F0dGVyZWQuIENhbiB5b3UgaGVscCBtZSBzdW1tYXJp
emUNCj4+ID4+IHlvdXIgY29uY2VybnMgYWdhaW4/DQo+PiA+DQo+PiA+VGhlIG1vc3QgaW1wb3J0
YW50IHBhcnQgaXMgaHR0cDovL2xrbWwua2VybmVsLm9yZy9yL1k0akZuWTdrTWRCOFJlU1dAZGhj
cDIyLnN1c2UuY3oNCj4+ID46IExldCBtZSBqdXN0IGVtcGhhc2lzZSB0aGF0IHdlIGFyZSB0YWxr
aW5nIGFib3V0IGZ1bmRhbWVudGFsIGRpc2Nvbm5lY3QuDQo+PiA+OiBSc3MgYmFzZWQgYWNjb3Vu
dGluZyBoYXMgYmVlbiB1c2VkIGZvciB0aGUgT09NIGtpbGxlciBzZWxlY3Rpb24gYmVjYXVzZQ0K
Pj4gPjogdGhlIG1lbW9yeSBnZXRzIHVubWFwcGVkIGFuZCBfcG90ZW50aWFsbHlfIGZyZWVkIHdo
ZW4gdGhlIHByb2Nlc3MgZ29lcw0KPj4gPjogYXdheS4gTWVtY2cgY2hhbmdlcyBhcmUgYm91bmQg
dG8gdGhlIG9iamVjdCBsaWZlIHRpbWUgYW5kIGFzIHNhaWQgaW4NCj4+ID46IG1hbnkgY2FzZXMg
dGhlcmUgaXMgbm8gZGlyZWN0IHJlbGF0aW9uIHdpdGggYW55IHByb2Nlc3MgbGlmZSB0aW1lLg0K
Pj4gPg0KPj4gV2UgbmVlZCB0byBkaXNjdXNzIHRoZSByZWxhdGlvbnNoaXAgYmV0d2VlbiBtZW1j
ZydzIG1lbSBhbmQgcHJvY2VzcydzIG1lbSwgDQo+PiANCj4+IHRhc2tfdXNhZ2UgPSB0YXNrX2Fu
b24ocnNzX2Fub24pICsgdGFza19tYXBwZWRfZmlsZShyc3NfZmlsZSkgDQo+PiAJICsgdGFza19t
YXBwZWRfc2hhcmUocnNzX3NoYXJlKSArIHRhc2tfcGd0YWJsZXMgKyB0YXNrX3N3YXBlbnRzDQo+
PiANCj4+IG1lbWNnX3VzYWdlCT0gbWVtY2dfYW5vbiArIG1lbWNnX2ZpbGUgKyBtZW1jZ19wZ3Rh
YmxlcyArIG1lbWNnX3NoYXJlDQo+PiAJPSBhbGxfdGFza19hbm9uICsgYWxsX3Rhc2tfbWFwcGVk
X2ZpbGUgKyBhbGxfdGFza19tYXBwZWRfc2hhcmUgDQo+PiAJICsgYWxsX3Rhc2tfcGd0YWJsZXMg
KyB1bm1hcHBlZF9maWxlICsgdW5tYXBwZWRfc2hhcmUNCj4+IAk9IGFsbF90YXNrX3VzYWdlICsg
dW5tYXBwZWRfZmlsZSArIHVubWFwcGVkX3NoYXJlIC0gYWxsX3Rhc2tfc3dhcGVudHMNCj4NCj5Z
b3UgYXJlIG1pc3NpbmcgYWxsIHRoZSBrZXJuZWwgY2hhcmdlZCBvYmplY3RzIChha2EgX19HRlBf
QUNDT1VOVA0KPmFsbG9jYXRpb25zIHJlc3AuIFNMQUJfQUNDT1VOVCBmb3Igc2xhYiBjYWNoZXMp
LiBEZXBlbmRpbmcgb24gdGhlDQo+d29ya2xvYWQgdGhpcyBjYW4gYmUgcmVhbGx5IGEgdmVyeSBu
b3RpY2VhYmxlIHBvcnRpb24uIFNvIG5vdCB0aGlzIGlzDQo+bm90IGp1c3QgYWJvdXQgdW5tYXBw
ZWQgY2FjaGUgb3Igc2htLg0KPg0KS21lbSBpcyBpbmRlZWQgbWlzc2luZyBoZXJlLCB0aGFua3Mg
Zm9yIHJlbWluZGluZy4gYnV0IHRoZSBwYXRjaCBpcyBhbHNvIGFwcGxpY2FibGUgDQp3aGVuIGtt
ZW0gaXMgYWRkZWQuDQoNCj4+ID5UaGF0IGlzIHRvIHRoZSBwZXItcHJvY2VzcyBkaXNjb3VudCBi
YXNlZCBvbiByc3Mgb3IgYW55IHBlci1wcm9jZXNzDQo+PiA+bWVtb3J5IG1ldHJpY3MuDQo+PiA+
DQo+PiA+QW5vdGhlciByZWFsbHkgaW1wb3J0YW50IHF1ZXN0aW9uIGlzIHRoZSBhY3R1YWwgY29u
ZmlndXJhYmlsaXR5LiBUaGUNCj4+ID5oaWVyYXJjaGljYWwgcHJvdGVjdGlvbiBoYXMgdG8gYmUg
ZW5mb3JjZWQgYW5kIHRoYXQgbWVhbnMgdGhhdCBzYW1lIGFzDQo+PiA+bWVtb3J5IHJlY2xhaW0g
cHJvdGVjdGlvbiBpdCBoYXMgdG8gYmUgZW5mb3JjZWQgdG9wLXRvLWJvdHRvbSBpbiB0aGUNCj4+
ID5jZ3JvdXAgaGllcmFyY2h5LiBUaGF0IG1ha2VzIHRoZSBvb20gcHJvdGVjdGlvbiByYXRoZXIg
bm9uLXRyaXZpYWwgdG8NCj4+ID5jb25maWd1cmUgd2l0aG91dCBoYXZpbmcgYSBnb29kIHBpY3R1
cmUgb2YgYSBsYXJnZXIgcGFydCBvZiB0aGUgY2dyb3VwDQo+PiA+aGllcmFyY2h5IGFzIGl0IGNh
bm5vdCBiZSB0dW5lZCBiYXNlZCBvbiBhIHJlY2xhaW0gZmVlZGJhY2suDQo+PiANCj4+IFRoZXJl
IGlzIGFuIGVzc2VudGlhbCBkaWZmZXJlbmNlIGJldHdlZW4gcmVjbGFpbSBhbmQgb29tIGtpbGxl
ci4NCj4NCj5vb20ga2lsbGVyIGlzIGEgbWVtb3J5IHJlY2xhaW0gb2YgdGhlIGxhc3QgcmVzb3J0
LiBTbyB5ZXMsIHRoZXJlIGlzIHNvbWUNCj5kaWZmZXJlbmNlIGJ1dCBmdW5kYW1lbnRhbGx5IGl0
IGlzIGFib3V0IHJlbGVhc2luZyBzb21lIG1lbW9yeS4gQW5kIGxvbmcNCj50ZXJtIHdlIGhhdmUg
bGVhcm5lZCB0aGF0IHRoZSBtb3JlIGNsZXZlciBpdCB0cmllcyB0byBiZSB0aGUgbW9yZSBsaWtl
bHkNCj5jb3JuZXIgY2FzZXMgY2FuIGhhcHBlbi4gSXQgaXMgc2ltcGx5IGltcG9zc2libGUgdG8g
a25vdyB0aGUgYmVzdA0KPmNhbmRpZGF0ZSBzbyB0aGlzIGlzIGEganVzdCBhIGJlc3QgZWZmb3J0
LiBXZSB0cnkgdG8gYWltIGZvcg0KPnByZWRpY3RhYmlsaXR5IGF0IGxlYXN0Lg0KDQpJcyB0aGUg
Y3VycmVudCBvb21fc2NvcmUgc3RyYXRlZ3kgcHJlZGljdGFibGU/IEkgZG9uJ3QgdGhpbmsgc28u
IFRoZSBzY29yZV9hZGogDQpoYXMgYnJva2VuIHRoZSBwcmVkaWN0YWJpbGl0eSBvZiBvb21fc2Nv
cmUgKGl0IGlzIG5vIGxvbmdlciBzaW1wbHkga2lsbGluZyB0aGUgDQpwcm9jZXNzIHRoYXQgdXNl
cyB0aGUgbW9zdCBtZW1zKS4gQW5kIEkgdGhpbmsgdGhhdCBzY29yZV9hZGogYW5kIG9vbS5wcm90
ZWN0IA0KYXJlIG5vdCBmb3IgdGhlIGtlcm5lbCB0byBjaG9vc2UgdGhlIGJlc3QgY2FuZGlkYXRl
LCBidXQgZm9yIHRoZSB1c2VyIHRvIGNob29zZSANCnRoZSBjYW5kaWRhdGUgbW9yZSBjb252ZW5p
ZW50bHkuIElmIHRoZSB1c2VyIGRvZXMgbm90IGNvbmZpZ3VyZSB0aGUgc2NvcmVfYWRqIA0KYW5k
IG9vbS5wcm90ZWN0LCB0aGUga2VybmVsIHdpbGwgZm9sbG93IHRoZSBzaW1wbGVzdCBhbmQgbW9z
dCBkaXJlY3QgbG9naWMgKGtpbGxpbmcgDQp0aGUgcHJvY2VzcyB0aGF0IHVzZXMgdGhlIG1vc3Qg
bWVtcykuDQoNCj4NCj4+IFRoZSByZWNsYWltIA0KPj4gY2Fubm90IGJlIGRpcmVjdGx5IHBlcmNl
aXZlZCBieSB1c2VycywNCj4NCj5JIHZlcnkgc3Ryb25nbHkgZGlzYWdyZWUgd2l0aCB0aGlzIHN0
YXRlbWVudC4gRmlyc3QgdGhlIGRpcmVjdCByZWNsYWltIGlzIGENCj5kaXJlY3Qgc291cmNlIG9m
IGxhdGVuY2llcyBiZWNhdXNlIHRoZSB3b3JrIGlzIGRvbmUgb24gYmVoYWxmIG9mIHRoZQ0KPmFs
bG9jYXRpbmcgcHJvY2Vzcy4gVGhlcmUgYXJlIHNpZGUgZWZmZWN0IHBvc3NpYmxlIGFzIHdlbGwg
YmVjYXVzZQ0KPnJlZmF1bHRzIGhhdmUgdGhlaXIgY29zdCBhcyB3ZWxsLg0KDQpUaGUgImRpcmVj
dCBwZXJjZXB0aW9uIiBoZXJlIGRvZXMgbm90IG1lYW4gdGhhdCByZWNsYWltIHdpbGwgbm90IGFm
ZmVjdCB0aGUgDQpwZXJmb3JtYW5jZSBvZiB1c2VyIHByb2Nlc3NlcywgYnV0IGVtcGhhc2l6ZXMg
dGhhdCB1c2VycyBjYW5ub3QgbWFrZSANCmZlZWRiYWNrIGFkanVzdG1lbnRzIGJhc2VkIG9uIHRo
ZWlyIG93biBzdGF0ZSBhbmQgbXVzdCByZWx5IG9uIHRoZSBoZWxwIA0Kb2Yga2VybmVsIGluZGlj
YXRvcnMuDQo+DQo+PiBzbyBtZW1jZyBuZWVkIHRvIGNvdW50IGluZGljYXRvcnMgDQo+PiBzaW1p
bGFyIHRvIHBnc2Nhbl8oa3N3YXBkL2RpcmVjdCkuIEhvd2V2ZXIsIHdoZW4gdGhlIHVzZXIgcHJv
Y2VzcyBpcyBraWxsZWQgDQo+PiBieSBvb20ga2lsbGVyLCB1c2VycyBjYW4gY2xlYXJseSBwZXJj
ZWl2ZSBhbmQgY291bnQgKHN1Y2ggYXMgdGhlIG51bWJlciBvZiANCj4+IHJlc3RhcnRzIG9mIGEg
Y2VydGFpbiB0eXBlIG9mIHByb2Nlc3MpLiBBdCB0aGUgc2FtZSB0aW1lLCB0aGUga2VybmVsIGFs
c28gaGFzIA0KPj4gbWVtb3J5LmV2ZW50cyB0byBjb3VudCBzb21lIGluZm9ybWF0aW9uIGFib3V0
IHRoZSBvb20ga2lsbGVyLCB3aGljaCBjYW4gDQo+PiBhbHNvIGJlIHVzZWQgZm9yIGZlZWRiYWNr
IGFkanVzdG1lbnQuDQo+DQo+WWVzIHdlIGhhdmUgdGhvc2UgbWV0cmljcyBhbHJlYWR5LiBJIHN1
c3BlY3QgSSBoYXZlbid0IG1hZGUgbXlzZWxmDQo+Y2xlYXIuIEkgZGlkbid0IHNheSB0aGVyZSBh
cmUgbm8gbWVhc3VyZXMgdG8gc2VlIGhvdyBvb20gYmVoYXZlcy4gV2hhdA0KPkkndmUgc2FpZCB0
aGF0IEkgX3N1c3BlY3RfIHRoYXQgb29tIHByb3RlY3Rpb24gd291bGQgYmUgcmVhbGx5IGhhcmQg
dG8NCj5jb25maWd1cmUgY29ycmVjdGx5IGJlY2F1c2UgdW5saWtlIHRoZSBtZW1vcnkgcmVjbGFp
bSB3aGljaCBoYXBwZW5zDQo+ZHVyaW5nIHRoZSBub3JtYWwgb3BlcmF0aW9uLCBvb20gaXMgYSBy
ZWxhdGl2ZWx5IHJhcmUgZXZlbnQgYW5kIGl0IGlzDQo+cXVpdGUgaGFyZCB0byB1c2UgaXQgZm9y
IGFueSBmZWVkYmFjayBtZWNoYW5pc21zLiANCg0KV2UgZGlzY3Vzc2VkIHNpbWlsYXIgY2FzZXMs
DQpodHRwczovL2xvcmUua2VybmVsLm9yZy9saW51eC1tbS9FRjFEQzAzNS00NDJGLTRCQUUtQjg2
Ri02QzZCMTBCNEEwOTRAZGlkaWdsb2JhbC5jb20vDQoqIE1vcmUgYW5kIG1vcmUgdXNlcnMgd2Fu
dCB0byBzYXZlIGNvc3RzIGFzIG11Y2ggYXMgcG9zc2libGUgYnkgc2V0dGluZyB0aGUgDQoqIG1l
bS5tYXggdG8gYSB2ZXJ5IHNtYWxsIHZhbHVlLCByZXN1bHRpbmcgaW4gYSBzbWFsbCBudW1iZXIg
b2Ygb29tIGV2ZW50cywgDQoqIGJ1dCB1c2VycyBjYW4gdG9sZXJhdGUgdGhlbSwgYW5kIHVzZXJz
IHdhbnQgdG8gbWluaW1pemUgdGhlIGltcGFjdCBvZiBvb20gDQoqIGV2ZW50cyBhdCB0aGlzIHRp
bWUuIEluIHNpbWlsYXIgc2NlbmFyaW9zLCBvb20gZXZlbnRzIGFyZSBubyBsb25nZXIgYWJub3Jt
YWwgDQoqIGFuZCB1bnByZWRpY3RhYmxlLiBXZSBuZWVkIHRvIHByb3ZpZGUgY29udmVuaWVudCBv
b20gcG9saWNpZXMgZm9yIHVzZXJzIHRvIA0KKiBjaG9vc2UuDQoNCj4gQnV0IEkgYW0gcmVhbGx5
IG9wZW4NCj50byBiZSBjb252aW5jZWQgb3RoZXJ3aXNlIGFuZCB0aGlzIGlzIGluIGZhY3Qgd2hh
dCBJIGhhdmUgYmVlbiBhc2tpbmcNCj5mb3Igc2luY2UgdGhlIGJlZ2lubmluZy4gSSB3b3VsZCBs
b3ZlIHRvIHNlZSBzb21lIGV4YW1wbGVzIG9uIHRoZQ0KPnJlYXNvbmFibGUgY29uZmlndXJhdGlv
biBmb3IgYSBwcmFjdGljYWwgdXNlY2FzZS4NCg0KSGVyZSBpcyBhIHNpbXBsZSBleGFtcGxlLiBJ
biBhIGRvY2tlciBjb250YWluZXIsIHVzZXJzIGNhbiBkaXZpZGUgYWxsIHByb2Nlc3NlcyANCmlu
dG8gdHdvIGNhdGVnb3JpZXMgKGltcG9ydGFudCBhbmQgbm9ybWFsKSwgYW5kIHB1dCB0aGVtIGlu
IGRpZmZlcmVudCBjZ3JvdXBzLiANCk9uZSBjZ3JvdXAncyBvb20ucHJvdGVjdCBpcyBzZXQgdG8g
Im1heCIsIHRoZSBvdGhlciBpcyBzZXQgdG8gIjAiLiBJbiB0aGlzIHdheSwgDQppbXBvcnRhbnQg
cHJvY2Vzc2VzIGluIHRoZSBjb250YWluZXIgY2FuIGJlIHByb3RlY3RlZC4NCg0KPiBJdCBpcyBv
bmUgdGhpbmcgdG8gc2F5DQo+dGhhdCB5b3UgY2FuIHNldCB0aGUgcHJvdGVjdGlvbiB0byBhIGNl
cnRhaW4gdmFsdWUgYW5kIGEgZGlmZmVyZW50IG9uZQ0KPnRvIGhhdmUgYSB3YXkgdG8gZGV0ZXJt
aW5lIHRoYXQgdmFsdWUuIFNlZSBteSBwb2ludD8NCg0KQWNjb3JkaW5nIHRvIHRoZSBjdXJyZW50
IHNpdHVhdGlvbiwgaWYgdGhlIHNjb3JlX2FkaiBpcyBzZXQsIHRoZSBvbmx5IHdheSBmb3IgDQp0
aGUga2VybmVsIHRvIGRldGVybWluZSB0aGUgdmFsdWUgaXMgImNhdCAvcHJvYy9waWQvb29tX2Nv
cmUiLiBJbiB0aGUgDQpvb20ucHJvdGVjdCBzY2hlbWUsIEkgYWxzbyBwcm9wb3NlIHRvIGNoYW5n
ZSAiL3Byb2MvcGlkL29vbV9jb3JlIi4gDQpQbGVhc2UgcmVmZXIgdG8gdGhlIGxpbmssDQpodHRw
czovL2xvcmUua2VybmVsLm9yZy9saW51eC1tbS9DMkNDMzZDMS0yOUFFLTRCNjUtQTE4QS0xOUE3
NDU2NTIxODJAZGlkaWdsb2JhbC5jb20vDQoNCj4NCj4tLSANCj5NaWNoYWwgSG9ja28NCj5TVVNF
IExhYnMNCg0K

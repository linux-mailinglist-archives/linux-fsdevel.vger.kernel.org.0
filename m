Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6F5363E913
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Dec 2022 05:52:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229751AbiLAEwp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 30 Nov 2022 23:52:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229619AbiLAEwd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 30 Nov 2022 23:52:33 -0500
Received: from mx5.didiglobal.com (mx5.didiglobal.com [111.202.70.122])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 129C69FED6;
        Wed, 30 Nov 2022 20:52:29 -0800 (PST)
Received: from mail.didiglobal.com (unknown [10.79.65.18])
        by mx5.didiglobal.com (Maildata Gateway V2.8) with ESMTPS id C2673B00A402D;
        Thu,  1 Dec 2022 12:52:27 +0800 (CST)
Received: from ZJY03-ACTMBX-05.didichuxing.com (10.79.71.35) by
 ZJY02-ACTMBX-06.didichuxing.com (10.79.65.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Thu, 1 Dec 2022 12:52:27 +0800
Received: from ZJY03-ACTMBX-05.didichuxing.com ([fe80::1dcd:f7bf:746e:c769])
 by ZJY03-ACTMBX-05.didichuxing.com ([fe80::1dcd:f7bf:746e:c769%8]) with mapi
 id 15.01.2375.017; Thu, 1 Dec 2022 12:52:27 +0800
X-MD-Sfrom: chengkaitao@didiglobal.com
X-MD-SrcIP: 10.79.65.18
From:   =?utf-8?B?56iL5Z6y5rabIENoZW5na2FpdGFvIENoZW5n?= 
        <chengkaitao@didiglobal.com>
To:     Michal Hocko <mhocko@suse.com>
CC:     Tao pilgrim <pilgrimtao@gmail.com>,
        "tj@kernel.org" <tj@kernel.org>,
        "lizefan.x@bytedance.com" <lizefan.x@bytedance.com>,
        "hannes@cmpxchg.org" <hannes@cmpxchg.org>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "roman.gushchin@linux.dev" <roman.gushchin@linux.dev>,
        "shakeelb@google.com" <shakeelb@google.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "songmuchun@bytedance.com" <songmuchun@bytedance.com>,
        "cgel.zte@gmail.com" <cgel.zte@gmail.com>,
        "ran.xiaokai@zte.com.cn" <ran.xiaokai@zte.com.cn>,
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
        "Bagas Sanjaya" <bagasdotme@gmail.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] mm: memcontrol: protect the memory in cgroup from being
 oom killed
Thread-Topic: [PATCH] mm: memcontrol: protect the memory in cgroup from being
 oom killed
Thread-Index: AQHZBK+NwNVzWF9Xk0ibAn/rxGrWSq5XnGYA//+FgwCAAVYiAA==
Date:   Thu, 1 Dec 2022 04:52:27 +0000
Message-ID: <E5A5BCC3-460E-4E81-8DD3-88B4A2868285@didiglobal.com>
In-Reply-To: <Y4eEiqwMMkHv9ELM@dhcp22.suse.cz>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.79.64.102]
Content-Type: text/plain; charset="utf-8"
Content-ID: <897162FFAA554144B1BE8218748B2FE2@didichuxing.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

QXQgMjAyMi0xMi0wMSAwMDoyNzo1NCwgIk1pY2hhbCBIb2NrbyIgPG1ob2Nrb0BzdXNlLmNvbT4g
d3JvdGU6DQo+T24gV2VkIDMwLTExLTIyIDE1OjQ2OjE5LCDnqIvlnrLmtpsgQ2hlbmdrYWl0YW8g
Q2hlbmcgd3JvdGU6DQo+PiBPbiAyMDIyLTExLTMwIDIxOjE1OjA2LCAiTWljaGFsIEhvY2tvIiA8
bWhvY2tvQHN1c2UuY29tPiB3cm90ZToNCj4+ID4gT24gV2VkIDMwLTExLTIyIDE1OjAxOjU4LCBj
aGVuZ2thaXRhbyB3cm90ZToNCj4+ID4gPiBGcm9tOiBjaGVuZ2thaXRhbyA8cGlsZ3JpbXRhb0Bn
bWFpbC5jb20+DQo+PiA+ID4NCj4+ID4gPiBXZSBjcmVhdGVkIGEgbmV3IGludGVyZmFjZSA8bWVt
b3J5Lm9vbS5wcm90ZWN0PiBmb3IgbWVtb3J5LCBJZiB0aGVyZSBpcw0KPj4gPiA+IHRoZSBPT00g
a2lsbGVyIHVuZGVyIHBhcmVudCBtZW1vcnkgY2dyb3VwLCBhbmQgdGhlIG1lbW9yeSB1c2FnZSBv
ZiBhDQo+PiA+ID4gY2hpbGQgY2dyb3VwIGlzIHdpdGhpbiBpdHMgZWZmZWN0aXZlIG9vbS5wcm90
ZWN0IGJvdW5kYXJ5LCB0aGUgY2dyb3VwJ3MNCj4+ID4gPiB0YXNrcyB3b24ndCBiZSBPT00ga2ls
bGVkIHVubGVzcyB0aGVyZSBpcyBubyB1bnByb3RlY3RlZCB0YXNrcyBpbiBvdGhlcg0KPj4gPiA+
IGNoaWxkcmVuIGNncm91cHMuIEl0IGRyYXdzIG9uIHRoZSBsb2dpYyBvZiA8bWVtb3J5Lm1pbi9s
b3c+IGluIHRoZQ0KPj4gPiA+IGluaGVyaXRhbmNlIHJlbGF0aW9uc2hpcC4NCj4+ID4NCj4+ID4g
Q291bGQgeW91IGJlIG1vcmUgc3BlY2lmaWMgYWJvdXQgdXNlY2FzZXM/DQo+DQo+VGhpcyBpcyBh
IHZlcnkgaW1wb3J0YW50IHF1ZXN0aW9uIHRvIGFuc3dlci4NCg0KdXNlY2FzZXMgMTogdXNlcnMg
c2F5IHRoYXQgdGhleSB3YW50IHRvIHByb3RlY3QgYW4gaW1wb3J0YW50IHByb2Nlc3MgDQp3aXRo
IGhpZ2ggbWVtb3J5IGNvbnN1bXB0aW9uIGZyb20gYmVpbmcga2lsbGVkIGJ5IHRoZSBvb20gaW4g
Y2FzZSANCm9mIGRvY2tlciBjb250YWluZXIgZmFpbHVyZSwgc28gYXMgdG8gcmV0YWluIG1vcmUg
Y3JpdGljYWwgb24tc2l0ZSANCmluZm9ybWF0aW9uIG9yIGEgc2VsZiByZWNvdmVyeSBtZWNoYW5p
c20uIEF0IHRoaXMgdGltZSwgdGhleSBzdWdnZXN0IA0Kc2V0dGluZyB0aGUgc2NvcmVfYWRqIG9m
IHRoaXMgcHJvY2VzcyB0byAtMTAwMCwgYnV0IEkgZG9uJ3QgYWdyZWUgd2l0aCANCml0LCBiZWNh
dXNlIHRoZSBkb2NrZXIgY29udGFpbmVyIGlzIG5vdCBpbXBvcnRhbnQgdG8gb3RoZXIgZG9ja2Vy
IA0KY29udGFpbmVycyBvZiB0aGUgc2FtZSBwaHlzaWNhbCBtYWNoaW5lLiBJZiBzY29yZV9hZGog
b2YgdGhlIHByb2Nlc3MgDQppcyBzZXQgdG8gLTEwMDAsIHRoZSBwcm9iYWJpbGl0eSBvZiBvb20g
aW4gb3RoZXIgY29udGFpbmVyIHByb2Nlc3NlcyB3aWxsIA0KaW5jcmVhc2UuDQoNCnVzZWNhc2Vz
IDI6IFRoZXJlIGFyZSBtYW55IGJ1c2luZXNzIHByb2Nlc3NlcyBhbmQgYWdlbnQgcHJvY2Vzc2Vz
IA0KbWl4ZWQgdG9nZXRoZXIgb24gYSBwaHlzaWNhbCBtYWNoaW5lLCBhbmQgdGhleSBuZWVkIHRv
IGJlIGNsYXNzaWZpZWQgDQphbmQgcHJvdGVjdGVkLiBIb3dldmVyLCBzb21lIGFnZW50cyBhcmUg
dGhlIHBhcmVudHMgb2YgYnVzaW5lc3MgDQpwcm9jZXNzZXMsIGFuZCBzb21lIGJ1c2luZXNzIHBy
b2Nlc3NlcyBhcmUgdGhlIHBhcmVudHMgb2YgYWdlbnQgDQpwcm9jZXNzZXMsIEl0IHdpbGwgYmUg
dHJvdWJsZXNvbWUgdG8gc2V0IGRpZmZlcmVudCBzY29yZV9hZGogZm9yIHRoZW0uIA0KQnVzaW5l
c3MgcHJvY2Vzc2VzIGFuZCBhZ2VudHMgY2Fubm90IGRldGVybWluZSB3aGljaCBsZXZlbCB0aGVp
ciANCnNjb3JlX2FkaiBzaG91bGQgYmUgYXQsIElmIHdlIGNyZWF0ZSBhbm90aGVyIGFnZW50IHRv
IHNldCBhbGwgcHJvY2Vzc2VzJ3MgDQpzY29yZV9hZGosIHdlIGhhdmUgdG8gY3ljbGUgdGhyb3Vn
aCBhbGwgdGhlIHByb2Nlc3NlcyBvbiB0aGUgcGh5c2ljYWwgDQptYWNoaW5lIHJlZ3VsYXJseSwg
d2hpY2ggbG9va3Mgc3R1cGlkLg0KDQo+PiA+IEhvdyBkbyB5b3UgdHVuZSBvb20ucHJvdGVjdA0K
Pj4gPiB3cnQgdG8gb3RoZXIgdHVuYWJsZXM/IEhvdyBkb2VzIHRoaXMgaW50ZXJhY3Qgd2l0aCB0
aGUgb29tX3Njb3JlX2Fkag0KPj4gPiB0dW5pbmluZyAoZS5nLiBhIGZpcnN0IGhhbmQgb29tIHZp
Y3RpbSB3aXRoIHRoZSBzY29yZV9hZGogMTAwMCBzaXR0aW5nDQo+PiA+IGluIGEgb29tIHByb3Rl
Y3RlZCBtZW1jZyk/DQo+PiANCj4+IFdlIHByZWZlciB1c2VycyB0byB1c2Ugc2NvcmVfYWRqIGFu
ZCBvb20ucHJvdGVjdCBpbmRlcGVuZGVudGx5LiBTY29yZV9hZGogaXMgDQo+PiBhIHBhcmFtZXRl
ciBhcHBsaWNhYmxlIHRvIGhvc3QsIGFuZCBvb20ucHJvdGVjdCBpcyBhIHBhcmFtZXRlciBhcHBs
aWNhYmxlIHRvIGNncm91cC4gDQo+PiBXaGVuIHRoZSBwaHlzaWNhbCBtYWNoaW5lJ3MgbWVtb3J5
IHNpemUgaXMgcGFydGljdWxhcmx5IGxhcmdlLCB0aGUgc2NvcmVfYWRqIA0KPj4gZ3JhbnVsYXJp
dHkgaXMgYWxzbyB2ZXJ5IGxhcmdlLiBIb3dldmVyLCBvb20ucHJvdGVjdCBjYW4gYWNoaWV2ZSBt
b3JlIGZpbmUtZ3JhaW5lZCANCj4+IGFkanVzdG1lbnQuDQo+DQo+TGV0IG1lIGNsYXJpZnkgYSBi
aXQuIEkgYW0gbm90IHRyeWluZyB0byBkZWZlbmQgb29tX3Njb3JlX2Fkai4gSXQgaGFzDQo+aXQn
cyB3ZWxsIGtub3duIGxpbWl0YXRpb25zIGFuZCBpdCBpcyBpcyBlc3NlbnRpYWxseSB1bnVzYWJs
ZSBmb3IgbWFueQ0KPnNpdHVhdGlvbnMgb3RoZXIgdGhhbiAtIGhpZGUgb3IgYXV0by1zZWxlY3Qg
cG90ZW50aWFsIG9vbSB2aWN0aW0uDQo+DQo+PiBXaGVuIHRoZSBzY29yZV9hZGogb2YgdGhlIHBy
b2Nlc3NlcyBhcmUgdGhlIHNhbWUsIEkgbGlzdCB0aGUgZm9sbG93aW5nIGNhc2VzIA0KPj4gZm9y
IGV4cGxhbmF0aW9uLA0KPj4gDQo+PiAgICAgICAgICAgcm9vdA0KPj4gICAgICAgICAgICB8DQo+
PiAgICAgICAgIGNncm91cCBBDQo+PiAgICAgICAgLyAgICAgICAgXA0KPj4gIGNncm91cCBCICAg
ICAgY2dyb3VwIEMNCj4+ICh0YXNrIG0sbikgICAgICh0YXNrIHgseSkNCj4+IA0KPj4gc2NvcmVf
YWRqKGFsbCB0YXNrKSA9IDA7DQo+PiBvb20ucHJvdGVjdChjZ3JvdXAgQSkgPSAwOw0KPj4gb29t
LnByb3RlY3QoY2dyb3VwIEIpID0gMDsNCj4+IG9vbS5wcm90ZWN0KGNncm91cCBDKSA9IDNHOw0K
Pg0KPkhvdyBjYW4geW91IGVuZm9yY2UgcHJvdGVjdGlvbiBhdCBDIGxldmVsIHdpdGhvdXQgYW55
IHByb3RlY3Rpb24gYXQgQQ0KPmxldmVsPyANCg0KVGhlIGJhc2ljIGlkZWEgb2YgdGhpcyBzY2hl
bWUgaXMgdGhhdCBhbGwgcHJvY2Vzc2VzIGluIHRoZSBzYW1lIGNncm91cCBhcmUgDQplcXVhbGx5
IGltcG9ydGFudC4gSWYgc29tZSBwcm9jZXNzZXMgbmVlZCBleHRyYSBwcm90ZWN0aW9uLCBhIG5l
dyBjZ3JvdXAgDQpuZWVkcyB0byBiZSBjcmVhdGVkIGZvciB1bmlmaWVkIHNldHRpbmdzLiBJIGRv
bid0IHRoaW5rIGl0IGlzIG5lY2Vzc2FyeSB0byANCmltcGxlbWVudCBwcm90ZWN0aW9uIGluIGNn
cm91cCBDLCBiZWNhdXNlIHRhc2sgeCBhbmQgdGFzayB5IGFyZSBlcXVhbGx5IA0KaW1wb3J0YW50
LiBPbmx5IHRoZSBmb3VyIHByb2Nlc3NlcyAodGFzayBtLCBuLCB4IGFuZCB5KSBpbiBjZ3JvdXAg
QSwgaGF2ZSANCmltcG9ydGFudCBhbmQgc2Vjb25kYXJ5IGRpZmZlcmVuY2VzLg0KDQo+IFRoaXMg
d291bGQgZWFzaWx5IGFsbG93IGFyYml0cmFyeSBjZ3JvdXAgdG8gaGlkZSBmcm9tIHRoZSBvb20N
Cj4ga2lsbGVyIGFuZCBzcGlsbCBvdmVyIHRvIG90aGVyIGNncm91cHMuDQoNCkkgZG9uJ3QgdGhp
bmsgdGhpcyB3aWxsIGhhcHBlbiwgYmVjYXVzZSBlb29tLnByb3RlY3Qgb25seSB3b3JrcyBvbiBw
YXJlbnQgDQpjZ3JvdXAuIElmICJvb20ucHJvdGVjdChwYXJlbnQgY2dyb3VwKSA9IDAiLCBmcm9t
IHBlcnNwZWN0aXZlIG9mIA0KZ3JhbmRwYSBjZ3JvdXAsIHRhc2sgeCBhbmQgeSB3aWxsIG5vdCBi
ZSBzcGVjaWFsbHkgcHJvdGVjdGVkLg0KDQo+PiB1c2FnZSh0YXNrIG0pID0gMUcNCj4+IHVzYWdl
KHRhc2sgbikgPSAyRw0KPj4gdXNhZ2UodGFzayB4KSA9IDFHDQo+PiB1c2FnZSh0YXNrIHkpID0g
MkcNCj4+IA0KPj4gb29tIGtpbGxlciBvcmRlciBvZiBjZ3JvdXAgQTogbiA+IG0gPiB5ID4geA0K
Pj4gb29tIGtpbGxlciBvcmRlciBvZiBob3N0OiAgICAgeSA9IG4gPiB4ID0gbQ0KPj4gDQo+PiBJ
ZiBjZ3JvdXAgQSBpcyBhIGRpcmVjdG9yeSBtYWludGFpbmVkIGJ5IHVzZXJzLCB1c2VycyBjYW4g
dXNlIG9vbS5wcm90ZWN0IA0KPj4gdG8gcHJvdGVjdCByZWxhdGl2ZWx5IGltcG9ydGFudCB0YXNr
cyB4IGFuZCB5Lg0KPj4gDQo+PiBIb3dldmVyLCB3aGVuIHNjb3JlX2FkaiBhbmQgb29tLnByb3Rl
Y3QgYXJlIHVzZWQgYXQgdGhlIHNhbWUgdGltZSwgd2UgDQo+PiB3aWxsIGFsc28gY29uc2lkZXIg
dGhlIGltcGFjdCBvZiBib3RoLCBhcyBleHByZXNzZWQgaW4gdGhlIGZvbGxvd2luZyBmb3JtdWxh
LiANCj4+IGJ1dCBJIGhhdmUgdG8gYWRtaXQgdGhhdCBpdCBpcyBhbiB1bnN0YWJsZSByZXN1bHQu
DQo+PiBzY29yZSA9IHRhc2tfdXNhZ2UgKyBzY29yZV9hZGogKiB0b3RhbHBhZ2UgLSBlb29tLnBy
b3RlY3QgKiB0YXNrX3VzYWdlIC8gbG9jYWxfbWVtY2dfdXNhZ2UNCj4NCj5JIGhvcGUgSSBhbSBu
b3QgbWlzcmVhZGluZyBidXQgdGhpcyBoYXMgc29tZSByYXRoZXIgdW5leHBlY3RlZA0KPnByb3Bl
cnRpZXMuIEZpcnN0IG9mZiwgYmlnZ2VyIG1lbW9yeSBjb25zdW1lcnMgaW4gYSBwcm90ZWN0ZWQg
bWVtY2cgYXJlDQo+cHJvdGVjdGVkIG1vcmUuIA0KDQpTaW5jZSBjZ3JvdXAgbmVlZHMgdG8gcmVh
c29uYWJseSBkaXN0cmlidXRlIHRoZSBwcm90ZWN0aW9uIHF1b3RhIHRvIGFsbCANCnByb2Nlc3Nl
cyBpbiB0aGUgY2dyb3VwLCBJIHRoaW5rIHRoYXQgcHJvY2Vzc2VzIGNvbnN1bWluZyBtb3JlIG1l
bW9yeSANCnNob3VsZCBnZXQgbW9yZSBxdW90YS4gSXQgaXMgZmFpciB0byBwcm9jZXNzZXMgY29u
c3VtaW5nIGxlc3MgbWVtb3J5IA0KdG9vLCBldmVuIGlmIHByb2Nlc3NlcyBjb25zdW1pbmcgbW9y
ZSBtZW1vcnkgZ2V0IG1vcmUgcXVvdGEsIGl0cyANCm9vbV9zY29yZSBpcyBzdGlsbCBoaWdoZXIg
dGhhbiB0aGUgcHJvY2Vzc2VzIGNvbnN1bWluZyBsZXNzIG1lbW9yeS4gDQpXaGVuIHRoZSBvb20g
a2lsbGVyIGFwcGVhcnMgaW4gbG9jYWwgY2dyb3VwLCB0aGUgb3JkZXIgb2Ygb29tIGtpbGxlciAN
CnJlbWFpbnMgdW5jaGFuZ2VkDQoNCj5BbHNvIEkgd291bGQgZXhwZWN0IHRoZSBwcm90ZWN0aW9u
IGRpc2NvdW50IHdvdWxkDQo+YmUgY2FwcGVkIGJ5IHRoZSBhY3R1YWwgdXNhZ2Ugb3RoZXJ3aXNl
IGV4Y2Vzc2l2ZSBwcm90ZWN0aW9uDQo+Y29uZmlndXJhdGlvbiBjb3VsZCBza2V3IHRoZSByZXN1
bHRzIGNvbnNpZGVyYWJseS4NCg0KSW4gdGhlIGNhbGN1bGF0aW9uLCB3ZSB3aWxsIHNlbGVjdCB0
aGUgbWluaW11bSB2YWx1ZSBvZiBtZW1jZ191c2FnZSBhbmQgDQpvb20ucHJvdGVjdA0KDQo+PiA+
IEkgaGF2ZW4ndCByZWFsbHkgcmVhZCB0aHJvdWdoIHRoZSB3aG9sZSBwYXRjaCBidXQgdGhpcyBz
dHJ1Y2sgbWUgb2RkLg0KPj4gDQo+PiA+ID4gQEAgLTU1Miw4ICs1NTIsMTkgQEAgc3RhdGljIGlu
dCBwcm9jX29vbV9zY29yZShzdHJ1Y3Qgc2VxX2ZpbGUgKm0sIHN0cnVjdCBwaWRfbmFtZXNwYWNl
ICpucywNCj4+ID4gPiAJdW5zaWduZWQgbG9uZyB0b3RhbHBhZ2VzID0gdG90YWxyYW1fcGFnZXMo
KSArIHRvdGFsX3N3YXBfcGFnZXM7DQo+PiA+ID4gCXVuc2lnbmVkIGxvbmcgcG9pbnRzID0gMDsN
Cj4+ID4gPiAJbG9uZyBiYWRuZXNzOw0KPj4gPiA+ICsjaWZkZWYgQ09ORklHX01FTUNHDQo+PiA+
ID4gKwlzdHJ1Y3QgbWVtX2Nncm91cCAqbWVtY2c7DQo+PiA+ID4gDQo+PiA+ID4gLQliYWRuZXNz
ID0gb29tX2JhZG5lc3ModGFzaywgdG90YWxwYWdlcyk7DQo+PiA+ID4gKwlyY3VfcmVhZF9sb2Nr
KCk7DQo+PiA+ID4gKwltZW1jZyA9IG1lbV9jZ3JvdXBfZnJvbV90YXNrKHRhc2spOw0KPj4gPiA+
ICsJaWYgKG1lbWNnICYmICFjc3NfdHJ5Z2V0KCZtZW1jZy0+Y3NzKSkNCj4+ID4gPiArCQltZW1j
ZyA9IE5VTEw7DQo+PiA+ID4gKwlyY3VfcmVhZF91bmxvY2soKTsNCj4+ID4gPiArDQo+PiA+ID4g
Kwl1cGRhdGVfcGFyZW50X29vbV9wcm90ZWN0aW9uKHJvb3RfbWVtX2Nncm91cCwgbWVtY2cpOw0K
Pj4gPiA+ICsJY3NzX3B1dCgmbWVtY2ctPmNzcyk7DQo+PiA+ID4gKyNlbmRpZg0KPj4gPiA+ICsJ
YmFkbmVzcyA9IG9vbV9iYWRuZXNzKHRhc2ssIHRvdGFscGFnZXMsIE1FTUNHX09PTV9QUk9URUNU
KTsNCj4+ID4NCj4+ID4gdGhlIGJhZG5lc3MgbWVhbnMgZGlmZmVyZW50IHRoaW5nIGRlcGVuZGlu
ZyBvbiB3aGljaCBtZW1jZyBoaWVyYXJjaHkNCj4+ID4gc3VidHJlZSB5b3UgbG9vayBhdC4gU2Nh
bGluZyBiYXNlZCBvbiB0aGUgZ2xvYmFsIG9vbSBjb3VsZCBnZXQgcmVhbGx5DQo+PiA+IG1pc2xl
YWRpbmcuDQo+PiANCj4+IEkgYWxzbyB0b29rIGl0IGludG8gY29uc2lkZXJhdGlvbi4gSSBwbGFu
bmVkIHRvIGNoYW5nZSAiL3Byb2MvcGlkL29vbV9zY29yZSIgDQo+PiB0byBhIHdyaXRhYmxlIG5v
ZGUuIFdoZW4gd3JpdGluZyB0byBkaWZmZXJlbnQgY2dyb3VwIHBhdGhzLCBkaWZmZXJlbnQgdmFs
dWVzIA0KPj4gd2lsbCBiZSBvdXRwdXQuIFRoZSBkZWZhdWx0IG91dHB1dCBpcyByb290IGNncm91
cC4gRG8geW91IHRoaW5rIHRoaXMgaWRlYSBpcyANCj4+IGZlYXNpYmxlPw0KPg0KPkkgZG8gbm90
IGZvbGxvdy4gQ2FyZSB0byBlbGFib3JhdGU/DQoNClRha2UgdHdvIGV4YW1wbGXvvIwNCmNtZDog
Y2F0IC9wcm9jL3BpZC9vb21fc2NvcmUNCm91dHB1dDogU2NhbGluZyBiYXNlZCBvbiB0aGUgZ2xv
YmFsIG9vbQ0KDQpjbWQ6IGVjaG8gIi9jZ3JvdXBBL2Nncm91cEIiID4gL3Byb2MvcGlkL29vbV9z
Y29yZQ0Kb3V0cHV0OiBTY2FsaW5nIGJhc2VkIG9uIHRoZSBjZ3JvdXBCIG9vbQ0KKElmIHRoZSB0
YXNrIGlzIG5vdCBpbiB0aGUgY2dyb3VwQidzIGhpZXJhcmNoeSBzdWJ0cmVlLCBvdXRwdXQ6IGlu
dmFsaWQgcGFyYW1ldGVyKQ0KDQpUaGFua3MgZm9yIHlvdXIgY29tbWVudCENCi0tIA0KQ2hlbmdr
YWl0YW8NCkJlc3Qgd2lzaGVzDQoNCg==

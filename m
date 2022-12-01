Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FC2163EE72
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Dec 2022 11:54:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230013AbiLAKyH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 1 Dec 2022 05:54:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231218AbiLAKxW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 1 Dec 2022 05:53:22 -0500
Received: from mx6.didiglobal.com (mx6.didiglobal.com [111.202.70.123])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id D6825B4B0;
        Thu,  1 Dec 2022 02:52:37 -0800 (PST)
Received: from mail.didiglobal.com (unknown [10.79.65.15])
        by mx6.didiglobal.com (Maildata Gateway V2.8) with ESMTPS id 5CD6C110363201;
        Thu,  1 Dec 2022 18:52:36 +0800 (CST)
Received: from ZJY03-ACTMBX-05.didichuxing.com (10.79.71.35) by
 ZJY02-ACTMBX-05.didichuxing.com (10.79.65.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Thu, 1 Dec 2022 18:52:35 +0800
Received: from ZJY03-ACTMBX-05.didichuxing.com ([fe80::1dcd:f7bf:746e:c769])
 by ZJY03-ACTMBX-05.didichuxing.com ([fe80::1dcd:f7bf:746e:c769%8]) with mapi
 id 15.01.2375.017; Thu, 1 Dec 2022 18:52:35 +0800
X-MD-Sfrom: chengkaitao@didiglobal.com
X-MD-SrcIP: 10.79.65.15
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
Thread-Index: AQHZBK+NwNVzWF9Xk0ibAn/rxGrWSq5XnGYA//+FgwCAAVYiAP//vByAgACohIA=
Date:   Thu, 1 Dec 2022 10:52:35 +0000
Message-ID: <C2CC36C1-29AE-4B65-A18A-19A745652182@didiglobal.com>
In-Reply-To: <Y4hqlzNeZ6Osu0pI@dhcp22.suse.cz>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.79.64.101]
Content-Type: text/plain; charset="utf-8"
Content-ID: <35B1ACF112E51D44A7F25D843B54465E@didichuxing.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

QXQgMjAyMi0xMi0wMSAxNjo0OToyNywgIk1pY2hhbCBIb2NrbyIgPG1ob2Nrb0BzdXNlLmNvbT4g
d3JvdGU6DQo+T24gVGh1IDAxLTEyLTIyIDA0OjUyOjI3LCDnqIvlnrLmtpsgQ2hlbmdrYWl0YW8g
Q2hlbmcgd3JvdGU6DQo+PiBBdCAyMDIyLTEyLTAxIDAwOjI3OjU0LCAiTWljaGFsIEhvY2tvIiA8
bWhvY2tvQHN1c2UuY29tPiB3cm90ZToNCj4+ID5PbiBXZWQgMzAtMTEtMjIgMTU6NDY6MTksIOeo
i+Wesua2myBDaGVuZ2thaXRhbyBDaGVuZyB3cm90ZToNCj4+ID4+IE9uIDIwMjItMTEtMzAgMjE6
MTU6MDYsICJNaWNoYWwgSG9ja28iIDxtaG9ja29Ac3VzZS5jb20+IHdyb3RlOg0KPj4gPj4gPiBP
biBXZWQgMzAtMTEtMjIgMTU6MDE6NTgsIGNoZW5na2FpdGFvIHdyb3RlOg0KPj4gPj4gPiA+IEZy
b206IGNoZW5na2FpdGFvIDxwaWxncmltdGFvQGdtYWlsLmNvbT4NCj4+ID4+ID4gPg0KPj4gPj4g
PiA+IFdlIGNyZWF0ZWQgYSBuZXcgaW50ZXJmYWNlIDxtZW1vcnkub29tLnByb3RlY3Q+IGZvciBt
ZW1vcnksIElmIHRoZXJlIGlzDQo+PiA+PiA+ID4gdGhlIE9PTSBraWxsZXIgdW5kZXIgcGFyZW50
IG1lbW9yeSBjZ3JvdXAsIGFuZCB0aGUgbWVtb3J5IHVzYWdlIG9mIGENCj4+ID4+ID4gPiBjaGls
ZCBjZ3JvdXAgaXMgd2l0aGluIGl0cyBlZmZlY3RpdmUgb29tLnByb3RlY3QgYm91bmRhcnksIHRo
ZSBjZ3JvdXAncw0KPj4gPj4gPiA+IHRhc2tzIHdvbid0IGJlIE9PTSBraWxsZWQgdW5sZXNzIHRo
ZXJlIGlzIG5vIHVucHJvdGVjdGVkIHRhc2tzIGluIG90aGVyDQo+PiA+PiA+ID4gY2hpbGRyZW4g
Y2dyb3Vwcy4gSXQgZHJhd3Mgb24gdGhlIGxvZ2ljIG9mIDxtZW1vcnkubWluL2xvdz4gaW4gdGhl
DQo+PiA+PiA+ID4gaW5oZXJpdGFuY2UgcmVsYXRpb25zaGlwLg0KPj4gPj4gPg0KPj4gPj4gPiBD
b3VsZCB5b3UgYmUgbW9yZSBzcGVjaWZpYyBhYm91dCB1c2VjYXNlcz8NCj4+ID4NCj4+ID5UaGlz
IGlzIGEgdmVyeSBpbXBvcnRhbnQgcXVlc3Rpb24gdG8gYW5zd2VyLg0KPj4gDQo+PiB1c2VjYXNl
cyAxOiB1c2VycyBzYXkgdGhhdCB0aGV5IHdhbnQgdG8gcHJvdGVjdCBhbiBpbXBvcnRhbnQgcHJv
Y2VzcyANCj4+IHdpdGggaGlnaCBtZW1vcnkgY29uc3VtcHRpb24gZnJvbSBiZWluZyBraWxsZWQg
YnkgdGhlIG9vbSBpbiBjYXNlIA0KPj4gb2YgZG9ja2VyIGNvbnRhaW5lciBmYWlsdXJlLCBzbyBh
cyB0byByZXRhaW4gbW9yZSBjcml0aWNhbCBvbi1zaXRlIA0KPj4gaW5mb3JtYXRpb24gb3IgYSBz
ZWxmIHJlY292ZXJ5IG1lY2hhbmlzbS4gQXQgdGhpcyB0aW1lLCB0aGV5IHN1Z2dlc3QgDQo+PiBz
ZXR0aW5nIHRoZSBzY29yZV9hZGogb2YgdGhpcyBwcm9jZXNzIHRvIC0xMDAwLCBidXQgSSBkb24n
dCBhZ3JlZSB3aXRoIA0KPj4gaXQsIGJlY2F1c2UgdGhlIGRvY2tlciBjb250YWluZXIgaXMgbm90
IGltcG9ydGFudCB0byBvdGhlciBkb2NrZXIgDQo+PiBjb250YWluZXJzIG9mIHRoZSBzYW1lIHBo
eXNpY2FsIG1hY2hpbmUuIElmIHNjb3JlX2FkaiBvZiB0aGUgcHJvY2VzcyANCj4+IGlzIHNldCB0
byAtMTAwMCwgdGhlIHByb2JhYmlsaXR5IG9mIG9vbSBpbiBvdGhlciBjb250YWluZXIgcHJvY2Vz
c2VzIHdpbGwgDQo+PiBpbmNyZWFzZS4NCj4+IA0KPj4gdXNlY2FzZXMgMjogVGhlcmUgYXJlIG1h
bnkgYnVzaW5lc3MgcHJvY2Vzc2VzIGFuZCBhZ2VudCBwcm9jZXNzZXMgDQo+PiBtaXhlZCB0b2dl
dGhlciBvbiBhIHBoeXNpY2FsIG1hY2hpbmUsIGFuZCB0aGV5IG5lZWQgdG8gYmUgY2xhc3NpZmll
ZCANCj4+IGFuZCBwcm90ZWN0ZWQuIEhvd2V2ZXIsIHNvbWUgYWdlbnRzIGFyZSB0aGUgcGFyZW50
cyBvZiBidXNpbmVzcyANCj4+IHByb2Nlc3NlcywgYW5kIHNvbWUgYnVzaW5lc3MgcHJvY2Vzc2Vz
IGFyZSB0aGUgcGFyZW50cyBvZiBhZ2VudCANCj4+IHByb2Nlc3NlcywgSXQgd2lsbCBiZSB0cm91
Ymxlc29tZSB0byBzZXQgZGlmZmVyZW50IHNjb3JlX2FkaiBmb3IgdGhlbS4gDQo+PiBCdXNpbmVz
cyBwcm9jZXNzZXMgYW5kIGFnZW50cyBjYW5ub3QgZGV0ZXJtaW5lIHdoaWNoIGxldmVsIHRoZWly
IA0KPj4gc2NvcmVfYWRqIHNob3VsZCBiZSBhdCwgSWYgd2UgY3JlYXRlIGFub3RoZXIgYWdlbnQg
dG8gc2V0IGFsbCBwcm9jZXNzZXMncyANCj4+IHNjb3JlX2Fkaiwgd2UgaGF2ZSB0byBjeWNsZSB0
aHJvdWdoIGFsbCB0aGUgcHJvY2Vzc2VzIG9uIHRoZSBwaHlzaWNhbCANCj4+IG1hY2hpbmUgcmVn
dWxhcmx5LCB3aGljaCBsb29rcyBzdHVwaWQuDQo+DQo+SSBkbyBhZ3JlZSB0aGF0IG9vbV9zY29y
ZV9hZGogaXMgZmFyIGZyb20gaWRlYWwgdG9vbCBmb3IgdGhlc2UgdXNlY2FzZXMuDQo+QnV0IEkg
YWxzbyBhZ3JlZSB3aXRoIFJvbWFuIHRoYXQgdGhlc2UgY291bGQgYmUgYWRkcmVzc2VkIGJ5IGFu
IG9vbQ0KPmtpbGxlciBpbXBsZW1lbnRhdGlvbiBpbiB0aGUgdXNlcnNwYWNlIHdoaWNoIGNhbiBo
YXZlIG11Y2ggYmV0dGVyDQo+dGFpbG9yZWQgcG9saWNpZXMuIE9PTSBwcm90ZWN0aW9uIGxpbWl0
cyB3b3VsZCByZXF1aXJlIHR1bmluZyBhbmQgYWxzbw0KPnJlZ3VsYXIgcmV2aXNpb25zIChlLmcu
IG1lbW9yeSBjb25zdW1wdGlvbiBieSBhbnkgd29ya2xvYWQgbWlnaHQgY2hhbmdlDQo+d2l0aCBk
aWZmZXJlbnQga2VybmVsIHZlcnNpb25zKSB0byBwcm92aWRlIHdoYXQgeW91IGFyZSBsb29raW5n
IGZvci4NCg0KVGhlcmUgaXMgYSBtaXN1bmRlcnN0YW5kaW5nLCBvb20ucHJvdGVjdCBkb2VzIG5v
dCByZXBsYWNlIHRoZSB1c2VyJ3MgDQp0YWlsZWQgcG9saWNpZXMsIEl0cyBwdXJwb3NlIGlzIHRv
IG1ha2UgaXQgZWFzaWVyIGFuZCBtb3JlIGVmZmljaWVudCBmb3IgDQp1c2VycyB0byBjdXN0b21p
emUgcG9saWNpZXMsIG9yIHRyeSB0byBhdm9pZCB1c2VycyBjb21wbGV0ZWx5IGFiYW5kb25pbmcg
DQp0aGUgb29tIHNjb3JlIHRvIGZvcm11bGF0ZSBuZXcgcG9saWNpZXMuDQoNCj4+ID4+ID4gSG93
IGRvIHlvdSB0dW5lIG9vbS5wcm90ZWN0DQo+PiA+PiA+IHdydCB0byBvdGhlciB0dW5hYmxlcz8g
SG93IGRvZXMgdGhpcyBpbnRlcmFjdCB3aXRoIHRoZSBvb21fc2NvcmVfYWRqDQo+PiA+PiA+IHR1
bmluaW5nIChlLmcuIGEgZmlyc3QgaGFuZCBvb20gdmljdGltIHdpdGggdGhlIHNjb3JlX2FkaiAx
MDAwIHNpdHRpbmcNCj4+ID4+ID4gaW4gYSBvb20gcHJvdGVjdGVkIG1lbWNnKT8NCj4+ID4+IA0K
Pj4gPj4gV2UgcHJlZmVyIHVzZXJzIHRvIHVzZSBzY29yZV9hZGogYW5kIG9vbS5wcm90ZWN0IGlu
ZGVwZW5kZW50bHkuIFNjb3JlX2FkaiBpcyANCj4+ID4+IGEgcGFyYW1ldGVyIGFwcGxpY2FibGUg
dG8gaG9zdCwgYW5kIG9vbS5wcm90ZWN0IGlzIGEgcGFyYW1ldGVyIGFwcGxpY2FibGUgdG8gY2dy
b3VwLiANCj4+ID4+IFdoZW4gdGhlIHBoeXNpY2FsIG1hY2hpbmUncyBtZW1vcnkgc2l6ZSBpcyBw
YXJ0aWN1bGFybHkgbGFyZ2UsIHRoZSBzY29yZV9hZGogDQo+PiA+PiBncmFudWxhcml0eSBpcyBh
bHNvIHZlcnkgbGFyZ2UuIEhvd2V2ZXIsIG9vbS5wcm90ZWN0IGNhbiBhY2hpZXZlIG1vcmUgZmlu
ZS1ncmFpbmVkIA0KPj4gPj4gYWRqdXN0bWVudC4NCj4+ID4NCj4+ID5MZXQgbWUgY2xhcmlmeSBh
IGJpdC4gSSBhbSBub3QgdHJ5aW5nIHRvIGRlZmVuZCBvb21fc2NvcmVfYWRqLiBJdCBoYXMNCj4+
ID5pdCdzIHdlbGwga25vd24gbGltaXRhdGlvbnMgYW5kIGl0IGlzIGlzIGVzc2VudGlhbGx5IHVu
dXNhYmxlIGZvciBtYW55DQo+PiA+c2l0dWF0aW9ucyBvdGhlciB0aGFuIC0gaGlkZSBvciBhdXRv
LXNlbGVjdCBwb3RlbnRpYWwgb29tIHZpY3RpbS4NCj4+ID4NCj4+ID4+IFdoZW4gdGhlIHNjb3Jl
X2FkaiBvZiB0aGUgcHJvY2Vzc2VzIGFyZSB0aGUgc2FtZSwgSSBsaXN0IHRoZSBmb2xsb3dpbmcg
Y2FzZXMgDQo+PiA+PiBmb3IgZXhwbGFuYXRpb24sDQo+PiA+PiANCj4+ID4+ICAgICAgICAgICBy
b290DQo+PiA+PiAgICAgICAgICAgIHwNCj4+ID4+ICAgICAgICAgY2dyb3VwIEENCj4+ID4+ICAg
ICAgICAvICAgICAgICBcDQo+PiA+PiAgY2dyb3VwIEIgICAgICBjZ3JvdXAgQw0KPj4gPj4gKHRh
c2sgbSxuKSAgICAgKHRhc2sgeCx5KQ0KPj4gPj4gDQo+PiA+PiBzY29yZV9hZGooYWxsIHRhc2sp
ID0gMDsNCj4+ID4+IG9vbS5wcm90ZWN0KGNncm91cCBBKSA9IDA7DQo+PiA+PiBvb20ucHJvdGVj
dChjZ3JvdXAgQikgPSAwOw0KPj4gPj4gb29tLnByb3RlY3QoY2dyb3VwIEMpID0gM0c7DQo+PiA+
DQo+PiA+SG93IGNhbiB5b3UgZW5mb3JjZSBwcm90ZWN0aW9uIGF0IEMgbGV2ZWwgd2l0aG91dCBh
bnkgcHJvdGVjdGlvbiBhdCBBDQo+PiA+bGV2ZWw/IA0KPj4gDQo+PiBUaGUgYmFzaWMgaWRlYSBv
ZiB0aGlzIHNjaGVtZSBpcyB0aGF0IGFsbCBwcm9jZXNzZXMgaW4gdGhlIHNhbWUgY2dyb3VwIGFy
ZSANCj4+IGVxdWFsbHkgaW1wb3J0YW50LiBJZiBzb21lIHByb2Nlc3NlcyBuZWVkIGV4dHJhIHBy
b3RlY3Rpb24sIGEgbmV3IGNncm91cCANCj4+IG5lZWRzIHRvIGJlIGNyZWF0ZWQgZm9yIHVuaWZp
ZWQgc2V0dGluZ3MuIEkgZG9uJ3QgdGhpbmsgaXQgaXMgbmVjZXNzYXJ5IHRvIA0KPj4gaW1wbGVt
ZW50IHByb3RlY3Rpb24gaW4gY2dyb3VwIEMsIGJlY2F1c2UgdGFzayB4IGFuZCB0YXNrIHkgYXJl
IGVxdWFsbHkgDQo+PiBpbXBvcnRhbnQuIE9ubHkgdGhlIGZvdXIgcHJvY2Vzc2VzICh0YXNrIG0s
IG4sIHggYW5kIHkpIGluIGNncm91cCBBLCBoYXZlIA0KPj4gaW1wb3J0YW50IGFuZCBzZWNvbmRh
cnkgZGlmZmVyZW5jZXMuDQo+PiANCj4+ID4gVGhpcyB3b3VsZCBlYXNpbHkgYWxsb3cgYXJiaXRy
YXJ5IGNncm91cCB0byBoaWRlIGZyb20gdGhlIG9vbQ0KPj4gPiBraWxsZXIgYW5kIHNwaWxsIG92
ZXIgdG8gb3RoZXIgY2dyb3Vwcy4NCj4+IA0KPj4gSSBkb24ndCB0aGluayB0aGlzIHdpbGwgaGFw
cGVuLCBiZWNhdXNlIGVvb20ucHJvdGVjdCBvbmx5IHdvcmtzIG9uIHBhcmVudCANCj4+IGNncm91
cC4gSWYgIm9vbS5wcm90ZWN0KHBhcmVudCBjZ3JvdXApID0gMCIsIGZyb20gcGVyc3BlY3RpdmUg
b2YgDQo+PiBncmFuZHBhIGNncm91cCwgdGFzayB4IGFuZCB5IHdpbGwgbm90IGJlIHNwZWNpYWxs
eSBwcm90ZWN0ZWQuDQo+DQo+SnVzdCB0byBjb25maXJtIEkgYW0gb24gdGhlIHNhbWUgcGFnZS4g
VGhpcyBtZWFucyB0aGF0IHRoZXJlIHdvbid0IGJlDQo+YW55IHByb3RlY3Rpb24gaW4gY2FzZSBv
ZiB0aGUgZ2xvYmFsIG9vbSBpbiB0aGUgYWJvdmUgZXhhbXBsZS4gU28NCj5lZmZlY3RpdmVseSB0
aGUgc2FtZSBzZW1hbnRpYyBhcyB0aGUgbG93L21pbiBwcm90ZWN0aW9uLg0KPg0KPj4gPj4gdXNh
Z2UodGFzayBtKSA9IDFHDQo+PiA+PiB1c2FnZSh0YXNrIG4pID0gMkcNCj4+ID4+IHVzYWdlKHRh
c2sgeCkgPSAxRw0KPj4gPj4gdXNhZ2UodGFzayB5KSA9IDJHDQo+PiA+PiANCj4+ID4+IG9vbSBr
aWxsZXIgb3JkZXIgb2YgY2dyb3VwIEE6IG4gPiBtID4geSA+IHgNCj4+ID4+IG9vbSBraWxsZXIg
b3JkZXIgb2YgaG9zdDogICAgIHkgPSBuID4geCA9IG0NCj4+ID4+IA0KPj4gPj4gSWYgY2dyb3Vw
IEEgaXMgYSBkaXJlY3RvcnkgbWFpbnRhaW5lZCBieSB1c2VycywgdXNlcnMgY2FuIHVzZSBvb20u
cHJvdGVjdCANCj4+ID4+IHRvIHByb3RlY3QgcmVsYXRpdmVseSBpbXBvcnRhbnQgdGFza3MgeCBh
bmQgeS4NCj4+ID4+IA0KPj4gPj4gSG93ZXZlciwgd2hlbiBzY29yZV9hZGogYW5kIG9vbS5wcm90
ZWN0IGFyZSB1c2VkIGF0IHRoZSBzYW1lIHRpbWUsIHdlIA0KPj4gPj4gd2lsbCBhbHNvIGNvbnNp
ZGVyIHRoZSBpbXBhY3Qgb2YgYm90aCwgYXMgZXhwcmVzc2VkIGluIHRoZSBmb2xsb3dpbmcgZm9y
bXVsYS4gDQo+PiA+PiBidXQgSSBoYXZlIHRvIGFkbWl0IHRoYXQgaXQgaXMgYW4gdW5zdGFibGUg
cmVzdWx0Lg0KPj4gPj4gc2NvcmUgPSB0YXNrX3VzYWdlICsgc2NvcmVfYWRqICogdG90YWxwYWdl
IC0gZW9vbS5wcm90ZWN0ICogdGFza191c2FnZSAvIGxvY2FsX21lbWNnX3VzYWdlDQo+PiA+DQo+
PiA+SSBob3BlIEkgYW0gbm90IG1pc3JlYWRpbmcgYnV0IHRoaXMgaGFzIHNvbWUgcmF0aGVyIHVu
ZXhwZWN0ZWQNCj4+ID5wcm9wZXJ0aWVzLiBGaXJzdCBvZmYsIGJpZ2dlciBtZW1vcnkgY29uc3Vt
ZXJzIGluIGEgcHJvdGVjdGVkIG1lbWNnIGFyZQ0KPj4gPnByb3RlY3RlZCBtb3JlLiANCj4+IA0K
Pj4gU2luY2UgY2dyb3VwIG5lZWRzIHRvIHJlYXNvbmFibHkgZGlzdHJpYnV0ZSB0aGUgcHJvdGVj
dGlvbiBxdW90YSB0byBhbGwgDQo+PiBwcm9jZXNzZXMgaW4gdGhlIGNncm91cCwgSSB0aGluayB0
aGF0IHByb2Nlc3NlcyBjb25zdW1pbmcgbW9yZSBtZW1vcnkgDQo+PiBzaG91bGQgZ2V0IG1vcmUg
cXVvdGEuIEl0IGlzIGZhaXIgdG8gcHJvY2Vzc2VzIGNvbnN1bWluZyBsZXNzIG1lbW9yeSANCj4+
IHRvbywgZXZlbiBpZiBwcm9jZXNzZXMgY29uc3VtaW5nIG1vcmUgbWVtb3J5IGdldCBtb3JlIHF1
b3RhLCBpdHMgDQo+PiBvb21fc2NvcmUgaXMgc3RpbGwgaGlnaGVyIHRoYW4gdGhlIHByb2Nlc3Nl
cyBjb25zdW1pbmcgbGVzcyBtZW1vcnkuIA0KPj4gV2hlbiB0aGUgb29tIGtpbGxlciBhcHBlYXJz
IGluIGxvY2FsIGNncm91cCwgdGhlIG9yZGVyIG9mIG9vbSBraWxsZXIgDQo+PiByZW1haW5zIHVu
Y2hhbmdlZA0KPg0KPldoeSBjYW5ub3QgeW91IHNpbXBseSBkaXNjb3VudCB0aGUgcHJvdGVjdGlv
biBmcm9tIGFsbCBwcm9jZXNzZXMNCj5lcXVhbGx5PyBJIGRvIG5vdCBmb2xsb3cgd2h5IHRoZSB0
YXNrX3VzYWdlIGhhcyB0byBwbGF5IGFueSByb2xlIGluDQo+dGhhdC4NCg0KSWYgYWxsIHByb2Nl
c3NlcyBhcmUgcHJvdGVjdGVkIGVxdWFsbHksIHRoZSBvb20gcHJvdGVjdGlvbiBvZiBjZ3JvdXAg
aXMgDQptZWFuaW5nbGVzcy4gRm9yIGV4YW1wbGUsIGlmIHRoZXJlIGFyZSBtb3JlIHByb2Nlc3Nl
cyBpbiB0aGUgY2dyb3VwLCANCnRoZSBjZ3JvdXAgY2FuIHByb3RlY3QgbW9yZSBtZW1zLCBpdCBp
cyB1bmZhaXIgdG8gY2dyb3VwcyB3aXRoIGZld2VyIA0KcHJvY2Vzc2VzLiBTbyB3ZSBuZWVkIHRv
IGtlZXAgdGhlIHRvdGFsIGFtb3VudCBvZiBtZW1vcnkgdGhhdCBhbGwgDQpwcm9jZXNzZXMgaW4g
dGhlIGNncm91cCBuZWVkIHRvIHByb3RlY3QgY29uc2lzdGVudCB3aXRoIHRoZSB2YWx1ZSBvZiAN
CmVvb20ucHJvdGVjdC4NCj4+IA0KPj4gPkFsc28gSSB3b3VsZCBleHBlY3QgdGhlIHByb3RlY3Rp
b24gZGlzY291bnQgd291bGQNCj4+ID5iZSBjYXBwZWQgYnkgdGhlIGFjdHVhbCB1c2FnZSBvdGhl
cndpc2UgZXhjZXNzaXZlIHByb3RlY3Rpb24NCj4+ID5jb25maWd1cmF0aW9uIGNvdWxkIHNrZXcg
dGhlIHJlc3VsdHMgY29uc2lkZXJhYmx5Lg0KPj4gDQo+PiBJbiB0aGUgY2FsY3VsYXRpb24sIHdl
IHdpbGwgc2VsZWN0IHRoZSBtaW5pbXVtIHZhbHVlIG9mIG1lbWNnX3VzYWdlIGFuZCANCj4+IG9v
bS5wcm90ZWN0DQo+PiANCj4+ID4+ID4gSSBoYXZlbid0IHJlYWxseSByZWFkIHRocm91Z2ggdGhl
IHdob2xlIHBhdGNoIGJ1dCB0aGlzIHN0cnVjayBtZSBvZGQuDQo+PiA+PiANCj4+ID4+ID4gPiBA
QCAtNTUyLDggKzU1MiwxOSBAQCBzdGF0aWMgaW50IHByb2Nfb29tX3Njb3JlKHN0cnVjdCBzZXFf
ZmlsZSAqbSwgc3RydWN0IHBpZF9uYW1lc3BhY2UgKm5zLA0KPj4gPj4gPiA+IAl1bnNpZ25lZCBs
b25nIHRvdGFscGFnZXMgPSB0b3RhbHJhbV9wYWdlcygpICsgdG90YWxfc3dhcF9wYWdlczsNCj4+
ID4+ID4gPiAJdW5zaWduZWQgbG9uZyBwb2ludHMgPSAwOw0KPj4gPj4gPiA+IAlsb25nIGJhZG5l
c3M7DQo+PiA+PiA+ID4gKyNpZmRlZiBDT05GSUdfTUVNQ0cNCj4+ID4+ID4gPiArCXN0cnVjdCBt
ZW1fY2dyb3VwICptZW1jZzsNCj4+ID4+ID4gPiANCj4+ID4+ID4gPiAtCWJhZG5lc3MgPSBvb21f
YmFkbmVzcyh0YXNrLCB0b3RhbHBhZ2VzKTsNCj4+ID4+ID4gPiArCXJjdV9yZWFkX2xvY2soKTsN
Cj4+ID4+ID4gPiArCW1lbWNnID0gbWVtX2Nncm91cF9mcm9tX3Rhc2sodGFzayk7DQo+PiA+PiA+
ID4gKwlpZiAobWVtY2cgJiYgIWNzc190cnlnZXQoJm1lbWNnLT5jc3MpKQ0KPj4gPj4gPiA+ICsJ
CW1lbWNnID0gTlVMTDsNCj4+ID4+ID4gPiArCXJjdV9yZWFkX3VubG9jaygpOw0KPj4gPj4gPiA+
ICsNCj4+ID4+ID4gPiArCXVwZGF0ZV9wYXJlbnRfb29tX3Byb3RlY3Rpb24ocm9vdF9tZW1fY2dy
b3VwLCBtZW1jZyk7DQo+PiA+PiA+ID4gKwljc3NfcHV0KCZtZW1jZy0+Y3NzKTsNCj4+ID4+ID4g
PiArI2VuZGlmDQo+PiA+PiA+ID4gKwliYWRuZXNzID0gb29tX2JhZG5lc3ModGFzaywgdG90YWxw
YWdlcywgTUVNQ0dfT09NX1BST1RFQ1QpOw0KPj4gPj4gPg0KPj4gPj4gPiB0aGUgYmFkbmVzcyBt
ZWFucyBkaWZmZXJlbnQgdGhpbmcgZGVwZW5kaW5nIG9uIHdoaWNoIG1lbWNnIGhpZXJhcmNoeQ0K
Pj4gPj4gPiBzdWJ0cmVlIHlvdSBsb29rIGF0LiBTY2FsaW5nIGJhc2VkIG9uIHRoZSBnbG9iYWwg
b29tIGNvdWxkIGdldCByZWFsbHkNCj4+ID4+ID4gbWlzbGVhZGluZy4NCj4+ID4+IA0KPj4gPj4g
SSBhbHNvIHRvb2sgaXQgaW50byBjb25zaWRlcmF0aW9uLiBJIHBsYW5uZWQgdG8gY2hhbmdlICIv
cHJvYy9waWQvb29tX3Njb3JlIiANCj4+ID4+IHRvIGEgd3JpdGFibGUgbm9kZS4gV2hlbiB3cml0
aW5nIHRvIGRpZmZlcmVudCBjZ3JvdXAgcGF0aHMsIGRpZmZlcmVudCB2YWx1ZXMgDQo+PiA+PiB3
aWxsIGJlIG91dHB1dC4gVGhlIGRlZmF1bHQgb3V0cHV0IGlzIHJvb3QgY2dyb3VwLiBEbyB5b3Ug
dGhpbmsgdGhpcyBpZGVhIGlzIA0KPj4gPj4gZmVhc2libGU/DQo+PiA+DQo+PiA+SSBkbyBub3Qg
Zm9sbG93LiBDYXJlIHRvIGVsYWJvcmF0ZT8NCj4+IA0KPj4gVGFrZSB0d28gZXhhbXBsZe+8jA0K
Pj4gY21kOiBjYXQgL3Byb2MvcGlkL29vbV9zY29yZQ0KPj4gb3V0cHV0OiBTY2FsaW5nIGJhc2Vk
IG9uIHRoZSBnbG9iYWwgb29tDQo+PiANCj4+IGNtZDogZWNobyAiL2Nncm91cEEvY2dyb3VwQiIg
PiAvcHJvYy9waWQvb29tX3Njb3JlDQo+PiBvdXRwdXQ6IFNjYWxpbmcgYmFzZWQgb24gdGhlIGNn
cm91cEIgb29tDQo+PiAoSWYgdGhlIHRhc2sgaXMgbm90IGluIHRoZSBjZ3JvdXBCJ3MgaGllcmFy
Y2h5IHN1YnRyZWUsIG91dHB1dDogaW52YWxpZCBwYXJhbWV0ZXIpDQo+DQo+VGhpcyBpcyBhIHRl
cnJpYmxlIGludGVyZmFjZS4gRmlyc3Qgb2YgYWxsIGl0IGFzc3VtZXMgYSBzdGF0ZSBmb3IgdGhl
DQo+ZmlsZSB3aXRob3V0IGFueSB3YXkgdG8gZ3VhcmFudGVlIGF0b21pY2l0eS4gSG93IGRvIHlv
dSBkZWFsIHdpdGggdHdvDQo+ZGlmZmVyZW50IGNhbGxlcnMgYWNjZXNzaW5nIHRoZSBmaWxlPw0K
DQpXaGVuIHRoZSBlY2hvIGNvbW1hbmQgaXMgZXhlY3V0ZWQsIHRoZSBrZXJuZWwgd2lsbCBkaXJl
Y3RseSByZXR1cm4gdGhlIA0KY2FsY3VsYXRlZCBvb21fc2NvcmUuIFdlIGRvIG5vdCBuZWVkIHRv
IHBlcmZvcm0gYWRkaXRpb25hbCBjYXQgY29tbWFuZCwgDQphbmQgYWxsIHRlbXBvcmFyeSBkYXRh
IHdpbGwgYmUgZGlzY2FyZGVkIGltbWVkaWF0ZWx5IGFmdGVyIHRoZSBlY2hvIG9wZXJhdGlvbi4g
DQpXaGVuIHRoZSBjYXQgY29tbWFuZCBpcyBleGVjdXRlZCwgdGhlIGtlcm5lbCB0cmVhdHMgdGhl
IGRlZmF1bHQgdmFsdWUgYXMgcm9vdCANCmNncm91cCwgc28gdGhlc2UgdHdvIG9wZXJhdGlvbnMg
YXJlIGF0b21pYy4NCj4NClRoYW5rcyBmb3IgeW91ciBjb21tZW50IQ0KY2hlbmdrYWl0YW8NCg0K

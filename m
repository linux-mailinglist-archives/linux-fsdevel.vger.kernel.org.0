Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E40E863EA86
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Dec 2022 08:49:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229668AbiLAHtN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 1 Dec 2022 02:49:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229628AbiLAHtK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 1 Dec 2022 02:49:10 -0500
Received: from mx6.didiglobal.com (mx6.didiglobal.com [111.202.70.123])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 7C809442C1;
        Wed, 30 Nov 2022 23:49:06 -0800 (PST)
Received: from mail.didiglobal.com (unknown [10.79.71.35])
        by mx6.didiglobal.com (Maildata Gateway V2.8) with ESMTPS id EDC44110021101;
        Thu,  1 Dec 2022 15:49:04 +0800 (CST)
Received: from ZJY03-ACTMBX-05.didichuxing.com (10.79.71.35) by
 ZJY03-ACTMBX-05.didichuxing.com (10.79.71.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Thu, 1 Dec 2022 15:49:04 +0800
Received: from ZJY03-ACTMBX-05.didichuxing.com ([fe80::1dcd:f7bf:746e:c769])
 by ZJY03-ACTMBX-05.didichuxing.com ([fe80::1dcd:f7bf:746e:c769%8]) with mapi
 id 15.01.2375.017; Thu, 1 Dec 2022 15:49:04 +0800
X-MD-Sfrom: chengkaitao@didiglobal.com
X-MD-SrcIP: 10.79.71.35
From:   =?utf-8?B?56iL5Z6y5rabIENoZW5na2FpdGFvIENoZW5n?= 
        <chengkaitao@didiglobal.com>
To:     "roman.gushchin@linux.dev" <roman.gushchin@linux.dev>
CC:     Tao pilgrim <pilgrimtao@gmail.com>,
        "tj@kernel.org" <tj@kernel.org>,
        "lizefan.x@bytedance.com" <lizefan.x@bytedance.com>,
        "hannes@cmpxchg.org" <hannes@cmpxchg.org>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "shakeelb@google.com" <shakeelb@google.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
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
        Bagas Sanjaya <bagasdotme@gmail.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] mm: memcontrol: protect the memory in cgroup from being
 oom killed
Thread-Topic: [PATCH] mm: memcontrol: protect the memory in cgroup from being
 oom killed
Thread-Index: AQHZBK+NwNVzWF9Xk0ibAn/rxGrWSq5XnGYA//+FgwCAAVYiAIAAMVUA
Date:   Thu, 1 Dec 2022 07:49:04 +0000
Message-ID: <5019F6D4-D341-4A5E-BAA1-1359A090114A@didiglobal.com>
In-Reply-To: <E5A5BCC3-460E-4E81-8DD3-88B4A2868285@didiglobal.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.79.64.101]
Content-Type: text/plain; charset="utf-8"
Content-ID: <55EEAD05261B624DAB9E7E4EE8B22659@didichuxing.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

QXQgMjAyMi0xMi0wMSAwNzoyOToxMSwgIlJvbWFuIEd1c2hjaGluIiA8cm9tYW4uZ3VzaGNoaW5A
bGludXguZGV2PiB3cm90ZToNCj5PbiBXZWQsIE5vdiAzMCwgMjAyMiBhdCAwMzowMTo1OFBNICsw
ODAwLCBjaGVuZ2thaXRhbyB3cm90ZToNCj4+IEZyb206IGNoZW5na2FpdGFvIDxwaWxncmltdGFv
QGdtYWlsLmNvbT4NCj4+IA0KPj4gV2UgY3JlYXRlZCBhIG5ldyBpbnRlcmZhY2UgPG1lbW9yeS5v
b20ucHJvdGVjdD4gZm9yIG1lbW9yeSwgSWYgdGhlcmUgaXMNCj4+IHRoZSBPT00ga2lsbGVyIHVu
ZGVyIHBhcmVudCBtZW1vcnkgY2dyb3VwLCBhbmQgdGhlIG1lbW9yeSB1c2FnZSBvZiBhDQo+PiBj
aGlsZCBjZ3JvdXAgaXMgd2l0aGluIGl0cyBlZmZlY3RpdmUgb29tLnByb3RlY3QgYm91bmRhcnks
IHRoZSBjZ3JvdXAncw0KPj4gdGFza3Mgd29uJ3QgYmUgT09NIGtpbGxlZCB1bmxlc3MgdGhlcmUg
aXMgbm8gdW5wcm90ZWN0ZWQgdGFza3MgaW4gb3RoZXINCj4+IGNoaWxkcmVuIGNncm91cHMuIEl0
IGRyYXdzIG9uIHRoZSBsb2dpYyBvZiA8bWVtb3J5Lm1pbi9sb3c+IGluIHRoZQ0KPj4gaW5oZXJp
dGFuY2UgcmVsYXRpb25zaGlwLg0KPj4gDQo+PiBJdCBoYXMgdGhlIGZvbGxvd2luZyBhZHZhbnRh
Z2VzLA0KPj4gMS4gV2UgaGF2ZSB0aGUgYWJpbGl0eSB0byBwcm90ZWN0IG1vcmUgaW1wb3J0YW50
IHByb2Nlc3Nlcywgd2hlbiB0aGVyZQ0KPj4gaXMgYSBtZW1jZydzIE9PTSBraWxsZXIuIFRoZSBv
b20ucHJvdGVjdCBvbmx5IHRha2VzIGVmZmVjdCBsb2NhbCBtZW1jZywNCj4+IGFuZCBkb2VzIG5v
dCBhZmZlY3QgdGhlIE9PTSBraWxsZXIgb2YgdGhlIGhvc3QuDQo+PiAyLiBIaXN0b3JpY2FsbHks
IHdlIGNhbiBvZnRlbiB1c2Ugb29tX3Njb3JlX2FkaiB0byBjb250cm9sIGEgZ3JvdXAgb2YNCj4+
IHByb2Nlc3NlcywgSXQgcmVxdWlyZXMgdGhhdCBhbGwgcHJvY2Vzc2VzIGluIHRoZSBjZ3JvdXAg
bXVzdCBoYXZlIGENCj4+IGNvbW1vbiBwYXJlbnQgcHJvY2Vzc2VzLCB3ZSBoYXZlIHRvIHNldCB0
aGUgY29tbW9uIHBhcmVudCBwcm9jZXNzJ3MNCj4+IG9vbV9zY29yZV9hZGosIGJlZm9yZSBpdCBm
b3JrcyBhbGwgY2hpbGRyZW4gcHJvY2Vzc2VzLiBTbyB0aGF0IGl0IGlzDQo+PiB2ZXJ5IGRpZmZp
Y3VsdCB0byBhcHBseSBpdCBpbiBvdGhlciBzaXR1YXRpb25zLiBOb3cgb29tLnByb3RlY3QgaGFz
IG5vDQo+PiBzdWNoIHJlc3RyaWN0aW9ucywgd2UgY2FuIHByb3RlY3QgYSBjZ3JvdXAgb2YgcHJv
Y2Vzc2VzIG1vcmUgZWFzaWx5LiBUaGUNCj4+IGNncm91cCBjYW4ga2VlcCBzb21lIG1lbW9yeSwg
ZXZlbiBpZiB0aGUgT09NIGtpbGxlciBoYXMgdG8gYmUgY2FsbGVkLg0KPg0KPkl0IHJlbWluZHMg
bWUgb3VyIGF0dGVtcHRzIHRvIHByb3ZpZGUgYSBtb3JlIHNvcGhpc3RpY2F0ZWQgY2dyb3VwLWF3
YXJlIG9vbQ0KPmtpbGxlci4gDQoNCkFzIHlvdSBzYWlkLCBJIGFsc28gbGlrZSBzaW1wbGUgc3Ry
YXRlZ2llcyBhbmQgY29uY2lzZSBjb2RlIHZlcnkgbXVjaCwgc28gaW4gDQp0aGUgZGVzaWduIG9m
IG9vbS5wcm90ZWN0LCB3ZSByZXVzZSB0aGUgZXZhbHVhdGlvbiBtZXRob2Qgb2Ygb29tX3Njb3Jl
LCANCndlIGRyYXdzIG9uIHRoZSBsb2dpYyBvZiA8bWVtb3J5Lm1pbi9sb3c+IGluIHRoZSBpbmhl
cml0YW5jZSByZWxhdGlvbnNoaXAuIA0KTWVtb3J5Lm1pbi9sb3cgaGF2ZSBiZWVuIGRlbW9uc3Ry
YXRlZCBmb3IgYSBsb25nIHRpbWUuIEkgZGlkIGl0IHRvIHJlZHVjZSANCnRoZSBidXJkZW4gb24g
dGhlIGtlcm5lbC4NCg0KPlRoZSBwcm9ibGVtIGlzIHRoYXQgdGhlIGRlY2lzaW9uIHdoaWNoIHBy
b2Nlc3MoZXMpIHRvIGtpbGwgb3IgcHJlc2VydmUNCj5pcyBpbmRpdmlkdWFsIHRvIGEgc3BlY2lm
aWMgd29ya2xvYWQgKGFuZCBjYW4gYmUgZXZlbiB0aW1lLWRlcGVuZGVudA0KPmZvciBhIGdpdmVu
IHdvcmtsb2FkKS4gDQoNCkl0IGlzIGNvcnJlY3QgdG8ga2lsbCBhIHByb2Nlc3Mgd2l0aCBoaWdo
IHdvcmtsb2FkLCBidXQgaXQgbWF5IG5vdCBiZSB0aGUgDQptb3N0IGFwcHJvcHJpYXRlLiBJIHRo
aW5rIHRoZSBzcGVjaWZpYyBwcm9jZXNzIHRvIGtpbGwgbmVlZHMgdG8gYmUgZGVjaWRlZCANCmJ5
IHRoZSB1c2VyLiBJIHRoaW5rIGl0IGlzIHRoZSBvcmlnaW5hbCBpbnRlbnRpb24gb2Ygc2NvcmVf
YWRqIGRlc2lnbi4NCg0KPlNvIGl0J3MgcmVhbGx5IGhhcmQgdG8gY29tZSB1cCB3aXRoIGFuIGlu
LWtlcm5lbA0KPm1lY2hhbmlzbSB3aGljaCBpcyBhdCB0aGUgc2FtZSB0aW1lIGZsZXhpYmxlIGVu
b3VnaCB0byB3b3JrIGZvciB0aGUgbWFqb3JpdHkNCj5vZiB1c2VycyBhbmQgcmVsaWFibGUgZW5v
dWdoIHRvIHNlcnZlIGFzIHRoZSBsYXN0IG9vbSByZXNvcnQgbWVhc3VyZSAod2hpY2gNCj5pcyB0
aGUgYmFzaWMgZ29hbCBvZiB0aGUga2VybmVsIG9vbSBraWxsZXIpLg0KPg0KT3VyIGdvYWwgaXMg
dG8gZmluZCBhIG1ldGhvZCB0aGF0IGlzIGxlc3MgaW50cnVzaXZlIHRvIHRoZSBleGlzdGluZyAN
Cm1lY2hhbmlzbXMgb2YgdGhlIGtlcm5lbCwgYW5kIGZpbmQgYSBtb3JlIHJlYXNvbmFibGUgc3Vw
cGxlbWVudCANCm9yIGFsdGVybmF0aXZlIHRvIHRoZSBsaW1pdGF0aW9ucyBvZiBzY29yZV9hZGou
DQoNCj5QcmV2aW91c2x5IHRoZSBjb25zZW5zdXMgd2FzIHRvIGtlZXAgdGhlIGluLWtlcm5lbCBv
b20ga2lsbGVyIGR1bWIgYW5kIHJlbGlhYmxlDQo+YW5kIGltcGxlbWVudCBjb21wbGV4IHBvbGlj
aWVzIGluIHVzZXJzcGFjZSAoZS5nLiBzeXN0ZW1kLW9vbWQgZXRjKS4NCj4NCj5JcyB0aGVyZSBh
IHJlYXNvbiB3aHkgc3VjaCBhcHByb2FjaCBjYW4ndCB3b3JrIGluIHlvdXIgY2FzZT8NCg0KSSB0
aGluayB0aGF0IGFzIGtlcm5lbCBkZXZlbG9wZXJzLCB3ZSBzaG91bGQgdHJ5IG91ciBiZXN0IHRv
IHByb3ZpZGUgDQp1c2VycyB3aXRoIHNpbXBsZXIgYW5kIG1vcmUgcG93ZXJmdWwgaW50ZXJmYWNl
cy4gSXQgaXMgY2xlYXIgdGhhdCB0aGUgDQpjdXJyZW50IG9vbSBzY29yZSBtZWNoYW5pc20gaGFz
IG1hbnkgbGltaXRhdGlvbnMuIFVzZXJzIG5lZWQgdG8gDQpkbyBhIGxvdCBvZiB0aW1lZCBsb29w
IGRldGVjdGlvbiBpbiBvcmRlciB0byBjb21wbGV0ZSB3b3JrIHNpbWlsYXIgDQp0byB0aGUgb29t
IHNjb3JlIG1lY2hhbmlzbSwgb3IgZGV2ZWxvcCBhIG5ldyBtZWNoYW5pc20ganVzdCB0byANCnNr
aXAgdGhlIGltcGVyZmVjdCBvb20gc2NvcmUgbWVjaGFuaXNtLiBUaGlzIGlzIGFuIGluZWZmaWNp
ZW50IGFuZCANCmZvcmNlZCBiZWhhdmlvcg0KDQpUaGFua3MgZm9yIHlvdXIgY29tbWVudCENCg0K

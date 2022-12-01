Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27AF963F132
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Dec 2022 14:06:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231336AbiLANF6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 1 Dec 2022 08:05:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231487AbiLANFl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 1 Dec 2022 08:05:41 -0500
Received: from mx5.didiglobal.com (mx5.didiglobal.com [111.202.70.122])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id EB3BA9E474;
        Thu,  1 Dec 2022 05:05:33 -0800 (PST)
Received: from mail.didiglobal.com (unknown [10.79.64.15])
        by mx5.didiglobal.com (Maildata Gateway V2.8) with ESMTPS id A79DBB00F7436;
        Thu,  1 Dec 2022 21:05:31 +0800 (CST)
Received: from ZJY03-ACTMBX-05.didichuxing.com (10.79.71.35) by
 ZJY01-ACTMBX-05.didichuxing.com (10.79.64.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Thu, 1 Dec 2022 21:05:31 +0800
Received: from ZJY03-ACTMBX-05.didichuxing.com ([fe80::1dcd:f7bf:746e:c769])
 by ZJY03-ACTMBX-05.didichuxing.com ([fe80::1dcd:f7bf:746e:c769%8]) with mapi
 id 15.01.2375.017; Thu, 1 Dec 2022 21:05:31 +0800
X-MD-Sfrom: chengkaitao@didiglobal.com
X-MD-SrcIP: 10.79.64.15
From:   =?utf-8?B?56iL5Z6y5rabIENoZW5na2FpdGFvIENoZW5n?= 
        <chengkaitao@didiglobal.com>
To:     Michal Hocko <mhocko@suse.com>
CC:     "roman.gushchin@linux.dev" <roman.gushchin@linux.dev>,
        Tao pilgrim <pilgrimtao@gmail.com>,
        "tj@kernel.org" <tj@kernel.org>,
        "lizefan.x@bytedance.com" <lizefan.x@bytedance.com>,
        "hannes@cmpxchg.org" <hannes@cmpxchg.org>,
        "corbet@lwn.net" <corbet@lwn.net>,
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
Thread-Index: AQHZBK+NwNVzWF9Xk0ibAn/rxGrWSq5XnGYA//+FgwCAAVYiAIAAMVUA//+OT4CAAMofAA==
Date:   Thu, 1 Dec 2022 13:05:31 +0000
Message-ID: <EF1DC035-442F-4BAE-B86F-6C6B10B4A094@didiglobal.com>
In-Reply-To: <Y4htjRAX1v7ZzC/z@dhcp22.suse.cz>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.79.64.101]
Content-Type: text/plain; charset="utf-8"
Content-ID: <53E33F2DC7944D4EB7C18932F5609912@didichuxing.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

QXQgMjAyMi0xMi0wMSAxNzowMjowNSwgIk1pY2hhbCBIb2NrbyIgPG1ob2Nrb0BzdXNlLmNvbT4g
d3JvdGU6DQo+T24gVGh1IDAxLTEyLTIyIDA3OjQ5OjA0LCDnqIvlnrLmtpsgQ2hlbmdrYWl0YW8g
Q2hlbmcgd3JvdGU6DQo+PiBBdCAyMDIyLTEyLTAxIDA3OjI5OjExLCAiUm9tYW4gR3VzaGNoaW4i
IDxyb21hbi5ndXNoY2hpbkBsaW51eC5kZXY+IHdyb3RlOg0KPlsuLi5dDQo+PiA+VGhlIHByb2Js
ZW0gaXMgdGhhdCB0aGUgZGVjaXNpb24gd2hpY2ggcHJvY2VzcyhlcykgdG8ga2lsbCBvciBwcmVz
ZXJ2ZQ0KPj4gPmlzIGluZGl2aWR1YWwgdG8gYSBzcGVjaWZpYyB3b3JrbG9hZCAoYW5kIGNhbiBi
ZSBldmVuIHRpbWUtZGVwZW5kZW50DQo+PiA+Zm9yIGEgZ2l2ZW4gd29ya2xvYWQpLiANCj4+IA0K
Pj4gSXQgaXMgY29ycmVjdCB0byBraWxsIGEgcHJvY2VzcyB3aXRoIGhpZ2ggd29ya2xvYWQsIGJ1
dCBpdCBtYXkgbm90IGJlIHRoZSANCj4+IG1vc3QgYXBwcm9wcmlhdGUuIEkgdGhpbmsgdGhlIHNw
ZWNpZmljIHByb2Nlc3MgdG8ga2lsbCBuZWVkcyB0byBiZSBkZWNpZGVkIA0KPj4gYnkgdGhlIHVz
ZXIuIEkgdGhpbmsgaXQgaXMgdGhlIG9yaWdpbmFsIGludGVudGlvbiBvZiBzY29yZV9hZGogZGVz
aWduLg0KPg0KPkkgZ3Vlc3Mgd2hhdCBSb21hbiB0cmllcyB0byBzYXkgaGVyZSBpcyB0aGF0IHRo
ZXJlIGlzIG5vIG9idmlvdXNseSBfY29ycmVjdF8NCj5vb20gdmljdGltIGNhbmRpZGF0ZS4gV2Vs
bCwgZXhjZXB0IGZvciBhIHZlcnkgbmFycm93IHNpdHVhdGlvbiB3aGVuDQo+dGhlcmUgaXMgYSBt
ZW1vcnkgbGVhayB0aGF0IGNvbnN1bWVzIG1vc3Qgb2YgdGhlIG1lbW9yeSBvdmVyIHRpbWUuIEJ1
dA0KPnRoYXQgaXMgcmVhbGx5IGhhcmQgdG8gaWRlbnRpZnkgYnkgdGhlIG9vbSBzZWxlY3Rpb24g
YWxnb3JpdGhtIGluDQo+Z2VuZXJhbC4NCj4gDQo+PiA+U28gaXQncyByZWFsbHkgaGFyZCB0byBj
b21lIHVwIHdpdGggYW4gaW4ta2VybmVsDQo+PiA+bWVjaGFuaXNtIHdoaWNoIGlzIGF0IHRoZSBz
YW1lIHRpbWUgZmxleGlibGUgZW5vdWdoIHRvIHdvcmsgZm9yIHRoZSBtYWpvcml0eQ0KPj4gPm9m
IHVzZXJzIGFuZCByZWxpYWJsZSBlbm91Z2ggdG8gc2VydmUgYXMgdGhlIGxhc3Qgb29tIHJlc29y
dCBtZWFzdXJlICh3aGljaA0KPj4gPmlzIHRoZSBiYXNpYyBnb2FsIG9mIHRoZSBrZXJuZWwgb29t
IGtpbGxlcikuDQo+PiA+DQo+PiBPdXIgZ29hbCBpcyB0byBmaW5kIGEgbWV0aG9kIHRoYXQgaXMg
bGVzcyBpbnRydXNpdmUgdG8gdGhlIGV4aXN0aW5nIA0KPj4gbWVjaGFuaXNtcyBvZiB0aGUga2Vy
bmVsLCBhbmQgZmluZCBhIG1vcmUgcmVhc29uYWJsZSBzdXBwbGVtZW50IA0KPj4gb3IgYWx0ZXJu
YXRpdmUgdG8gdGhlIGxpbWl0YXRpb25zIG9mIHNjb3JlX2Fkai4NCj4+IA0KPj4gPlByZXZpb3Vz
bHkgdGhlIGNvbnNlbnN1cyB3YXMgdG8ga2VlcCB0aGUgaW4ta2VybmVsIG9vbSBraWxsZXIgZHVt
YiBhbmQgcmVsaWFibGUNCj4+ID5hbmQgaW1wbGVtZW50IGNvbXBsZXggcG9saWNpZXMgaW4gdXNl
cnNwYWNlIChlLmcuIHN5c3RlbWQtb29tZCBldGMpLg0KPj4gPg0KPj4gPklzIHRoZXJlIGEgcmVh
c29uIHdoeSBzdWNoIGFwcHJvYWNoIGNhbid0IHdvcmsgaW4geW91ciBjYXNlPw0KPj4gDQo+PiBJ
IHRoaW5rIHRoYXQgYXMga2VybmVsIGRldmVsb3BlcnMsIHdlIHNob3VsZCB0cnkgb3VyIGJlc3Qg
dG8gcHJvdmlkZSANCj4+IHVzZXJzIHdpdGggc2ltcGxlciBhbmQgbW9yZSBwb3dlcmZ1bCBpbnRl
cmZhY2VzLiBJdCBpcyBjbGVhciB0aGF0IHRoZSANCj4+IGN1cnJlbnQgb29tIHNjb3JlIG1lY2hh
bmlzbSBoYXMgbWFueSBsaW1pdGF0aW9ucy4gVXNlcnMgbmVlZCB0byANCj4+IGRvIGEgbG90IG9m
IHRpbWVkIGxvb3AgZGV0ZWN0aW9uIGluIG9yZGVyIHRvIGNvbXBsZXRlIHdvcmsgc2ltaWxhciAN
Cj4+IHRvIHRoZSBvb20gc2NvcmUgbWVjaGFuaXNtLCBvciBkZXZlbG9wIGEgbmV3IG1lY2hhbmlz
bSBqdXN0IHRvIA0KPj4gc2tpcCB0aGUgaW1wZXJmZWN0IG9vbSBzY29yZSBtZWNoYW5pc20uIFRo
aXMgaXMgYW4gaW5lZmZpY2llbnQgYW5kIA0KPj4gZm9yY2VkIGJlaGF2aW9yDQo+DQo+WW91IGFy
ZSByaWdodCB0aGF0IGl0IG1ha2VzIHNlbnNlIHRvIGFkZHJlc3MgdHlwaWNhbCB1c2VjYXNlcyBp
biB0aGUNCj5rZXJuZWwgaWYgdGhhdCBpcyBwb3NzaWJsZS4gQnV0IG9vbSB2aWN0aW0gc2VsZWN0
aW9uIGlzIHJlYWxseSBoYXJkDQo+d2l0aG91dCBhIGRlZXBlciB1bmRlcnN0YW5kaW5nIG9mIHRo
ZSBhY3R1YWwgd29ya2xvYWQuIFRoZSBtb3JlIGNsZXZlcg0KPndlIHRyeSB0byBiZSB0aGUgbW9y
ZSBjb3JuZXIgY2FzZXMgd2UgY2FuIHByb2R1Y2UuIFBsZWFzZSBub3RlIHRoYXQgdGhpcw0KPmhh
cyBwcm92ZW4gdG8gYmUgdGhlIGNhc2UgaW4gdGhlIGxvbmcgb29tIGRldmVsb3BtZW50IGhpc3Rv
cnkuIFdlIHVzZWQNCj50byBzYWNyaWZpY2UgY2hpbGQgcHJvY2Vzc2VzIG92ZXIgYSBsYXJnZSBw
cm9jZXNzIHRvIHByZXNlcnZlIHdvcmsgb3INCj5wcmVmZXIgeW91bmdlciBwcm9jZXNzZXMuIEJv
dGggdGhvc2Ugc3RyYXRlZ2llcyBsZWQgdG8gcHJvYmxlbXMuDQo+DQo+TWVtY2cgcHJvdGVjdGlv
biBiYXNlZCBtZWNoYW5pc20gc291bmRzIGxpa2UgYW4gaW50ZXJlc3RpbmcgaWRlYSBiZWNhdXNl
DQo+aXQgbWltaWNzIGEgcmVjbGFpbSBwcm90ZWN0aW9uIHNjaGVtZSBidXQgSSBhbSBhIGJpdCBz
Y2VwdGljYWwgaXQgd2lsbA0KPmJlIHByYWN0aWNhbGx5IHVzZWZ1bC4gTW9zdCBmb3IgMiByZWFz
b25zLiBhKSBtZW1vcnkgcmVjbGFpbSBwcm90ZWN0aW9uDQo+Y2FuIGJlIGR5bmFtaWNhbGx5IHR1
bmVkIGJlY2F1c2Ugb24gcmVjbGFpbS9yZWZhdWx0L3BzaSBtZXRyaWNzLiBvb20NCj5ldmVudHMg
YXJlIHJhcmUgYW5kIG1vc3RseSBhIGZhaWx1cmUgc2l0dWF0aW9uLiBUaGlzIGxpbWl0cyBhbnkg
ZmVlZGJhY2sNCj5iYXNlZCBhcHByb2FjaCBJTUhPLiBiKSBIaWVyYXJjaGljYWwgbmF0dXJlIG9m
IHRoZSBwcm90ZWN0aW9uIHdpbGwgbWFrZQ0KPml0IHF1aXRlIGhhcmQgdG8gY29uZmlndXJlIHBy
b3Blcmx5IHdpdGggcHJlZGljdGFibGUgb3V0Y29tZS4NCj4NCk1vcmUgYW5kIG1vcmUgdXNlcnMg
d2FudCB0byBzYXZlIGNvc3RzIGFzIG11Y2ggYXMgcG9zc2libGUgYnkgc2V0dGluZyB0aGUgDQpt
ZW0ubWF4IHRvIGEgdmVyeSBzbWFsbCB2YWx1ZSwgcmVzdWx0aW5nIGluIGEgc21hbGwgbnVtYmVy
IG9mIG9vbSBldmVudHMsIA0KYnV0IHVzZXJzIGNhbiB0b2xlcmF0ZSB0aGVtLCBhbmQgdXNlcnMg
d2FudCB0byBtaW5pbWl6ZSB0aGUgaW1wYWN0IG9mIG9vbSANCmV2ZW50cyBhdCB0aGlzIHRpbWUu
IEluIHNpbWlsYXIgc2NlbmFyaW9zLCBvb20gZXZlbnRzIGFyZSBubyBsb25nZXIgYWJub3JtYWwg
DQphbmQgdW5wcmVkaWN0YWJsZS4gV2UgbmVlZCB0byBwcm92aWRlIGNvbnZlbmllbnQgb29tIHBv
bGljaWVzIGZvciB1c2VycyB0byANCmNob29zZS4NCg0KVXNlcnMgaGF2ZSBhIGdyZWF0ZXIgc2F5
IGluIG9vbSB2aWN0aW0gc2VsZWN0aW9uLCBidXQgdGhleSBjYW5ub3QgcGVyY2VpdmUgDQpvdGhl
ciB1c2Vycywgc28gdGhleSBjYW5ub3QgYWNjdXJhdGVseSBmb3JtdWxhdGUgdGhlaXIgb3duIG9v
bSBwb2xpY2llcy4gDQpUaGlzIGlzIGEgdmVyeSBjb250cmFkaWN0b3J5IHRoaW5nLiBUaGVyZWZv
cmUsIHdlIGhvcGUgdGhhdCBlYWNoIHVzZXIncyANCmN1c3RvbWl6ZWQgcG9saWNpZXMgY2FuIGJl
IGluZGVwZW5kZW50IG9mIGVhY2ggb3RoZXIgYW5kIG5vdCBpbnRlcmZlcmUgd2l0aCANCmVhY2gg
b3RoZXIuDQoNCj4tLSANCj5NaWNoYWwgSG9ja28NCj5TVVNFIExhYnMNCg0K

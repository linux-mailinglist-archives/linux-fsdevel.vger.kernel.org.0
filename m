Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05DC663D9C5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Nov 2022 16:46:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229986AbiK3Pq2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 30 Nov 2022 10:46:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbiK3Pq0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 30 Nov 2022 10:46:26 -0500
Received: from mx6.didiglobal.com (mx6.didiglobal.com [111.202.70.123])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 0DF96813B2;
        Wed, 30 Nov 2022 07:46:23 -0800 (PST)
Received: from mail.didiglobal.com (unknown [10.79.71.35])
        by mx6.didiglobal.com (Maildata Gateway V2.8) with ESMTPS id 631AB11035FE0B;
        Wed, 30 Nov 2022 23:46:19 +0800 (CST)
Received: from ZJY03-ACTMBX-05.didichuxing.com (10.79.71.35) by
 ZJY03-ACTMBX-05.didichuxing.com (10.79.71.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Wed, 30 Nov 2022 23:46:19 +0800
Received: from ZJY03-ACTMBX-05.didichuxing.com ([fe80::1dcd:f7bf:746e:c769])
 by ZJY03-ACTMBX-05.didichuxing.com ([fe80::1dcd:f7bf:746e:c769%8]) with mapi
 id 15.01.2375.017; Wed, 30 Nov 2022 23:46:19 +0800
X-MD-Sfrom: chengkaitao@didiglobal.com
X-MD-SrcIP: 10.79.71.35
From:   =?utf-8?B?56iL5Z6y5rabIENoZW5na2FpdGFvIENoZW5n?= 
        <chengkaitao@didiglobal.com>
To:     Tao pilgrim <pilgrimtao@gmail.com>,
        "mhocko@suse.com" <mhocko@suse.com>
CC:     "tj@kernel.org" <tj@kernel.org>,
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
        "mhocko@kernel.org" <mhocko@kernel.org>,
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
Thread-Index: AQHZBK+NwNVzWF9Xk0ibAn/rxGrWSq5XnGYA
Date:   Wed, 30 Nov 2022 15:46:19 +0000
Message-ID: <7EF16CB9-C34A-410B-BEBE-0303C1BB7BA0@didiglobal.com>
In-Reply-To: <CAAWJmAYPUK+1GBS0R460pDvDKrLr9zs_X2LT2yQTP_85kND5Ew@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.79.71.102]
Content-Type: text/plain; charset="utf-8"
Content-ID: <F2E62DA506DBDC4AAC4A9FA211F5ACC7@didichuxing.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

T24gMjAyMi0xMS0zMCAyMToxNTowNiwgIk1pY2hhbCBIb2NrbyIgPG1ob2Nrb0BzdXNlLmNvbT4g
d3JvdGU6DQo+IE9uIFdlZCAzMC0xMS0yMiAxNTowMTo1OCwgY2hlbmdrYWl0YW8gd3JvdGU6DQo+
ID4gRnJvbTogY2hlbmdrYWl0YW8gPHBpbGdyaW10YW9AZ21haWwuY29tPg0KPiA+DQo+ID4gV2Ug
Y3JlYXRlZCBhIG5ldyBpbnRlcmZhY2UgPG1lbW9yeS5vb20ucHJvdGVjdD4gZm9yIG1lbW9yeSwg
SWYgdGhlcmUgaXMNCj4gPiB0aGUgT09NIGtpbGxlciB1bmRlciBwYXJlbnQgbWVtb3J5IGNncm91
cCwgYW5kIHRoZSBtZW1vcnkgdXNhZ2Ugb2YgYQ0KPiA+IGNoaWxkIGNncm91cCBpcyB3aXRoaW4g
aXRzIGVmZmVjdGl2ZSBvb20ucHJvdGVjdCBib3VuZGFyeSwgdGhlIGNncm91cCdzDQo+ID4gdGFz
a3Mgd29uJ3QgYmUgT09NIGtpbGxlZCB1bmxlc3MgdGhlcmUgaXMgbm8gdW5wcm90ZWN0ZWQgdGFz
a3MgaW4gb3RoZXINCj4gPiBjaGlsZHJlbiBjZ3JvdXBzLiBJdCBkcmF3cyBvbiB0aGUgbG9naWMg
b2YgPG1lbW9yeS5taW4vbG93PiBpbiB0aGUNCj4gPiBpbmhlcml0YW5jZSByZWxhdGlvbnNoaXAu
DQo+DQo+IENvdWxkIHlvdSBiZSBtb3JlIHNwZWNpZmljIGFib3V0IHVzZWNhc2VzPyBIb3cgZG8g
eW91IHR1bmUgb29tLnByb3RlY3QNCj4gd3J0IHRvIG90aGVyIHR1bmFibGVzPyBIb3cgZG9lcyB0
aGlzIGludGVyYWN0IHdpdGggdGhlIG9vbV9zY29yZV9hZGoNCj4gdHVuaW5pbmcgKGUuZy4gYSBm
aXJzdCBoYW5kIG9vbSB2aWN0aW0gd2l0aCB0aGUgc2NvcmVfYWRqIDEwMDAgc2l0dGluZw0KPiBp
biBhIG9vbSBwcm90ZWN0ZWQgbWVtY2cpPw0KDQpXZSBwcmVmZXIgdXNlcnMgdG8gdXNlIHNjb3Jl
X2FkaiBhbmQgb29tLnByb3RlY3QgaW5kZXBlbmRlbnRseS4gU2NvcmVfYWRqIGlzIA0KYSBwYXJh
bWV0ZXIgYXBwbGljYWJsZSB0byBob3N0LCBhbmQgb29tLnByb3RlY3QgaXMgYSBwYXJhbWV0ZXIg
YXBwbGljYWJsZSB0byBjZ3JvdXAuIA0KV2hlbiB0aGUgcGh5c2ljYWwgbWFjaGluZSdzIG1lbW9y
eSBzaXplIGlzIHBhcnRpY3VsYXJseSBsYXJnZSwgdGhlIHNjb3JlX2FkaiANCmdyYW51bGFyaXR5
IGlzIGFsc28gdmVyeSBsYXJnZS4gSG93ZXZlciwgb29tLnByb3RlY3QgY2FuIGFjaGlldmUgbW9y
ZSBmaW5lLWdyYWluZWQgDQphZGp1c3RtZW50Lg0KDQpXaGVuIHRoZSBzY29yZV9hZGogb2YgdGhl
IHByb2Nlc3NlcyBhcmUgdGhlIHNhbWUsIEkgbGlzdCB0aGUgZm9sbG93aW5nIGNhc2VzIA0KZm9y
IGV4cGxhbmF0aW9uLA0KDQogICAgICAgICAgcm9vdA0KICAgICAgICAgICB8DQogICAgICAgIGNn
cm91cCBBDQogICAgICAgLyAgICAgICAgXA0KIGNncm91cCBCICAgICAgY2dyb3VwIEMNCih0YXNr
IG0sbikgICAgICh0YXNrIHgseSkNCg0Kc2NvcmVfYWRqKGFsbCB0YXNrKSA9IDA7DQpvb20ucHJv
dGVjdChjZ3JvdXAgQSkgPSAwOw0Kb29tLnByb3RlY3QoY2dyb3VwIEIpID0gMDsNCm9vbS5wcm90
ZWN0KGNncm91cCBDKSA9IDNHOw0KdXNhZ2UodGFzayBtKSA9IDFHDQp1c2FnZSh0YXNrIG4pID0g
MkcNCnVzYWdlKHRhc2sgeCkgPSAxRw0KdXNhZ2UodGFzayB5KSA9IDJHDQoNCm9vbSBraWxsZXIg
b3JkZXIgb2YgY2dyb3VwIEE6IG4gPiBtID4geSA+IHgNCm9vbSBraWxsZXIgb3JkZXIgb2YgaG9z
dDogICAgIHkgPSBuID4geCA9IG0NCg0KSWYgY2dyb3VwIEEgaXMgYSBkaXJlY3RvcnkgbWFpbnRh
aW5lZCBieSB1c2VycywgdXNlcnMgY2FuIHVzZSBvb20ucHJvdGVjdCANCnRvIHByb3RlY3QgcmVs
YXRpdmVseSBpbXBvcnRhbnQgdGFza3MgeCBhbmQgeS4NCg0KSG93ZXZlciwgd2hlbiBzY29yZV9h
ZGogYW5kIG9vbS5wcm90ZWN0IGFyZSB1c2VkIGF0IHRoZSBzYW1lIHRpbWUsIHdlIA0Kd2lsbCBh
bHNvIGNvbnNpZGVyIHRoZSBpbXBhY3Qgb2YgYm90aCwgYXMgZXhwcmVzc2VkIGluIHRoZSBmb2xs
b3dpbmcgZm9ybXVsYS4gDQpidXQgSSBoYXZlIHRvIGFkbWl0IHRoYXQgaXQgaXMgYW4gdW5zdGFi
bGUgcmVzdWx0Lg0Kc2NvcmUgPSB0YXNrX3VzYWdlICsgc2NvcmVfYWRqICogdG90YWxwYWdlIC0g
ZW9vbS5wcm90ZWN0ICogdGFza191c2FnZSAvIGxvY2FsX21lbWNnX3VzYWdlDQoNCj4gSSBoYXZl
bid0IHJlYWxseSByZWFkIHRocm91Z2ggdGhlIHdob2xlIHBhdGNoIGJ1dCB0aGlzIHN0cnVjayBt
ZSBvZGQuDQoNCj4gPiBAQCAtNTUyLDggKzU1MiwxOSBAQCBzdGF0aWMgaW50IHByb2Nfb29tX3Nj
b3JlKHN0cnVjdCBzZXFfZmlsZSAqbSwgc3RydWN0IHBpZF9uYW1lc3BhY2UgKm5zLA0KPiA+IAl1
bnNpZ25lZCBsb25nIHRvdGFscGFnZXMgPSB0b3RhbHJhbV9wYWdlcygpICsgdG90YWxfc3dhcF9w
YWdlczsNCj4gPiAJdW5zaWduZWQgbG9uZyBwb2ludHMgPSAwOw0KPiA+IAlsb25nIGJhZG5lc3M7
DQo+ID4gKyNpZmRlZiBDT05GSUdfTUVNQ0cNCj4gPiArCXN0cnVjdCBtZW1fY2dyb3VwICptZW1j
ZzsNCj4gPiANCj4gPiAtCWJhZG5lc3MgPSBvb21fYmFkbmVzcyh0YXNrLCB0b3RhbHBhZ2VzKTsN
Cj4gPiArCXJjdV9yZWFkX2xvY2soKTsNCj4gPiArCW1lbWNnID0gbWVtX2Nncm91cF9mcm9tX3Rh
c2sodGFzayk7DQo+ID4gKwlpZiAobWVtY2cgJiYgIWNzc190cnlnZXQoJm1lbWNnLT5jc3MpKQ0K
PiA+ICsJCW1lbWNnID0gTlVMTDsNCj4gPiArCXJjdV9yZWFkX3VubG9jaygpOw0KPiA+ICsNCj4g
PiArCXVwZGF0ZV9wYXJlbnRfb29tX3Byb3RlY3Rpb24ocm9vdF9tZW1fY2dyb3VwLCBtZW1jZyk7
DQo+ID4gKwljc3NfcHV0KCZtZW1jZy0+Y3NzKTsNCj4gPiArI2VuZGlmDQo+ID4gKwliYWRuZXNz
ID0gb29tX2JhZG5lc3ModGFzaywgdG90YWxwYWdlcywgTUVNQ0dfT09NX1BST1RFQ1QpOw0KPg0K
PiB0aGUgYmFkbmVzcyBtZWFucyBkaWZmZXJlbnQgdGhpbmcgZGVwZW5kaW5nIG9uIHdoaWNoIG1l
bWNnIGhpZXJhcmNoeQ0KPiBzdWJ0cmVlIHlvdSBsb29rIGF0LiBTY2FsaW5nIGJhc2VkIG9uIHRo
ZSBnbG9iYWwgb29tIGNvdWxkIGdldCByZWFsbHkNCj4gbWlzbGVhZGluZy4NCg0KSSBhbHNvIHRv
b2sgaXQgaW50byBjb25zaWRlcmF0aW9uLiBJIHBsYW5uZWQgdG8gY2hhbmdlICIvcHJvYy9waWQv
b29tX3Njb3JlIiANCnRvIGEgd3JpdGFibGUgbm9kZS4gV2hlbiB3cml0aW5nIHRvIGRpZmZlcmVu
dCBjZ3JvdXAgcGF0aHMsIGRpZmZlcmVudCB2YWx1ZXMgDQp3aWxsIGJlIG91dHB1dC4gVGhlIGRl
ZmF1bHQgb3V0cHV0IGlzIHJvb3QgY2dyb3VwLiBEbyB5b3UgdGhpbmsgdGhpcyBpZGVhIGlzIA0K
ZmVhc2libGU/DQotLSANCkNoZW5na2FpdGFvDQpCZXN0IHdpc2hlcw0KDQo=

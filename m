Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0BE363F2DF
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Dec 2022 15:30:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231397AbiLAOaY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 1 Dec 2022 09:30:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbiLAOaV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 1 Dec 2022 09:30:21 -0500
Received: from mx6.didiglobal.com (mx6.didiglobal.com [111.202.70.123])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 9BD5BA7AB5;
        Thu,  1 Dec 2022 06:30:17 -0800 (PST)
Received: from mail.didiglobal.com (unknown [10.79.71.35])
        by mx6.didiglobal.com (Maildata Gateway V2.8) with ESMTPS id 5AA13110363200;
        Thu,  1 Dec 2022 22:30:12 +0800 (CST)
Received: from ZJY03-ACTMBX-05.didichuxing.com (10.79.71.35) by
 ZJY03-ACTMBX-05.didichuxing.com (10.79.71.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Thu, 1 Dec 2022 22:30:12 +0800
Received: from ZJY03-ACTMBX-05.didichuxing.com ([fe80::1dcd:f7bf:746e:c769])
 by ZJY03-ACTMBX-05.didichuxing.com ([fe80::1dcd:f7bf:746e:c769%8]) with mapi
 id 15.01.2375.017; Thu, 1 Dec 2022 22:30:11 +0800
X-MD-Sfrom: chengkaitao@didiglobal.com
X-MD-SrcIP: 10.79.71.35
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
Thread-Index: AQHZBK+NwNVzWF9Xk0ibAn/rxGrWSq5XnGYA//+FgwCAAVYiAP//vByAgACohID//5lJgAAA0fUAABOecIA=
Date:   Thu, 1 Dec 2022 14:30:11 +0000
Message-ID: <C9FFF5A4-B883-4C0D-A802-D94080D6C3A4@didiglobal.com>
In-Reply-To: <Y4inSsNpmomzRt8J@dhcp22.suse.cz>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.79.64.101]
Content-Type: text/plain; charset="utf-8"
Content-ID: <C0A32D731A459844B8D5001BAE8B8536@didichuxing.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

QXQgMjAyMi0xMi0wMSAyMTowODoyNiwgIk1pY2hhbCBIb2NrbyIgPG1ob2Nrb0BzdXNlLmNvbT4g
d3JvdGU6DQo+T24gVGh1IDAxLTEyLTIyIDEzOjQ0OjU4LCBNaWNoYWwgSG9ja28gd3JvdGU6DQo+
PiBPbiBUaHUgMDEtMTItMjIgMTA6NTI6MzUsIOeoi+Wesua2myBDaGVuZ2thaXRhbyBDaGVuZyB3
cm90ZToNCj4+ID4gQXQgMjAyMi0xMi0wMSAxNjo0OToyNywgIk1pY2hhbCBIb2NrbyIgPG1ob2Nr
b0BzdXNlLmNvbT4gd3JvdGU6DQo+Wy4uLl0NCj4+IFRoZXJlIGlzIGEgbWlzdW5kZXJzdGFuZGlu
Zywgb29tLnByb3RlY3QgZG9lcyBub3QgcmVwbGFjZSB0aGUgdXNlcidzIA0KPj4gdGFpbGVkIHBv
bGljaWVzLCBJdHMgcHVycG9zZSBpcyB0byBtYWtlIGl0IGVhc2llciBhbmQgbW9yZSBlZmZpY2ll
bnQgZm9yIA0KPj4gdXNlcnMgdG8gY3VzdG9taXplIHBvbGljaWVzLCBvciB0cnkgdG8gYXZvaWQg
dXNlcnMgY29tcGxldGVseSBhYmFuZG9uaW5nIA0KPj4gdGhlIG9vbSBzY29yZSB0byBmb3JtdWxh
dGUgbmV3IHBvbGljaWVzLg0KPg0KPiBUaGVuIHlvdSBzaG91bGQgZm9jdXMgb24gZXhwbGFpbmlu
ZyBvbiBob3cgdGhpcyBtYWtlcyB0aG9zZSBwb2xpY2llcyBhbmQNCj4gZWFzaWVyIGFuZCBtb2Ug
ZWZmaWNpZW50LiBJIGRvIG5vdCBzZWUgaXQuDQoNCkluIGZhY3QsIHRoZXJlIGFyZSBzb21lIHJl
bGV2YW50IGNvbnRlbnRzIGluIHRoZSBwcmV2aW91cyBjaGF0IHJlY29yZHMuIA0KSWYgb29tLnBy
b3RlY3QgaXMgYXBwbGllZCwgaXQgd2lsbCBoYXZlIHRoZSBmb2xsb3dpbmcgYmVuZWZpdHMNCjEu
IFVzZXJzIG9ubHkgbmVlZCB0byBmb2N1cyBvbiB0aGUgbWFuYWdlbWVudCBvZiB0aGUgbG9jYWwg
Y2dyb3VwLCBub3QgdGhlIA0KaW1wYWN0IG9uIG90aGVyIHVzZXJzJyBjZ3JvdXBzLg0KMi4gVXNl
cnMgYW5kIHN5c3RlbSBkbyBub3QgbmVlZCB0byBzcGVuZCBleHRyYSB0aW1lIG9uIGNvbXBsaWNh
dGVkIGFuZCANCnJlcGVhdGVkIHNjYW5uaW5nIGFuZCBjb25maWd1cmF0aW9uLiBUaGV5IGp1c3Qg
bmVlZCB0byBjb25maWd1cmUgdGhlIA0Kb29tLnByb3RlY3Qgb2Ygc3BlY2lmaWMgY2dyb3Vwcywg
d2hpY2ggaXMgYSBvbmUtdGltZSB0YXNrDQoNCj4+ID4gPldoeSBjYW5ub3QgeW91IHNpbXBseSBk
aXNjb3VudCB0aGUgcHJvdGVjdGlvbiBmcm9tIGFsbCBwcm9jZXNzZXMNCj4+ID4gPmVxdWFsbHk/
IEkgZG8gbm90IGZvbGxvdyB3aHkgdGhlIHRhc2tfdXNhZ2UgaGFzIHRvIHBsYXkgYW55IHJvbGUg
aW4NCj4+ID4gPnRoYXQuDQo+PiA+IA0KPj4gPiBJZiBhbGwgcHJvY2Vzc2VzIGFyZSBwcm90ZWN0
ZWQgZXF1YWxseSwgdGhlIG9vbSBwcm90ZWN0aW9uIG9mIGNncm91cCBpcyANCj4+ID4gbWVhbmlu
Z2xlc3MuIEZvciBleGFtcGxlLCBpZiB0aGVyZSBhcmUgbW9yZSBwcm9jZXNzZXMgaW4gdGhlIGNn
cm91cCwgDQo+PiA+IHRoZSBjZ3JvdXAgY2FuIHByb3RlY3QgbW9yZSBtZW1zLCBpdCBpcyB1bmZh
aXIgdG8gY2dyb3VwcyB3aXRoIGZld2VyIA0KPj4gPiBwcm9jZXNzZXMuIFNvIHdlIG5lZWQgdG8g
a2VlcCB0aGUgdG90YWwgYW1vdW50IG9mIG1lbW9yeSB0aGF0IGFsbCANCj4+ID4gcHJvY2Vzc2Vz
IGluIHRoZSBjZ3JvdXAgbmVlZCB0byBwcm90ZWN0IGNvbnNpc3RlbnQgd2l0aCB0aGUgdmFsdWUg
b2YgDQo+PiA+IGVvb20ucHJvdGVjdC4NCj4+IA0KPj4gWW91IGFyZSBtaXhpbmcgdHdvIGRpZmZl
cmVudCBjb25jZXB0cyB0b2dldGhlciBJIGFtIGFmcmFpZC4gVGhlIHBlcg0KPj4gbWVtY2cgcHJv
dGVjdGlvbiBzaG91bGQgcHJvdGVjdCB0aGUgY2dyb3VwIChpLmUuIGFsbCBwcm9jZXNzZXMgaW4g
dGhhdA0KPj4gY2dyb3VwKSB3aGlsZSB5b3Ugd2FudCBpdCB0byBiZSBhbHNvIHByb2Nlc3MgYXdh
cmUuIFRoaXMgcmVzdWx0cyBpbiBhDQo+PiB2ZXJ5IHVuY2xlYXIgcnVudGltZSBiZWhhdmlvciB3
aGVuIGEgcHJvY2VzcyBmcm9tIGEgbW9yZSBwcm90ZWN0ZWQgbWVtY2cNCj4+IGlzIHNlbGVjdGVk
IGJhc2VkIG9uIGl0cyBpbmRpdmlkdWFsIG1lbW9yeSB1c2FnZS4NCj4NClRoZSBjb3JyZWN0IHN0
YXRlbWVudCBoZXJlIHNob3VsZCBiZSB0aGF0IGVhY2ggbWVtY2cgcHJvdGVjdGlvbiBzaG91bGQg
DQpwcm90ZWN0IHRoZSBudW1iZXIgb2YgbWVtcyBzcGVjaWZpZWQgYnkgdGhlIG9vbS5wcm90ZWN0
LiBGb3IgZXhhbXBsZSwgDQphIGNncm91cCdzIHVzYWdlIGlzIDZHLCBhbmQgaXQncyBvb20ucHJv
dGVjdCBpcyAyRywgd2hlbiBhbiBvb20ga2lsbGVyIG9jY3VycywgDQpJbiB0aGUgd29yc3QgY2Fz
ZSwgd2Ugd2lsbCBvbmx5IHJlZHVjZSB0aGUgbWVtb3J5IHVzZWQgYnkgdGhpcyBjZ3JvdXAgdG8g
MkcgDQp0aHJvdWdoIHRoZSBvbSBraWxsZXIuDQoNCj5MZXQgbWUgYmUgbW9yZSBzcGVjaWZpYyBo
ZXJlLiBBbHRob3VnaCBpdCBpcyBwcmltYXJpbHkgcHJvY2Vzc2VzIHdoaWNoDQo+YXJlIHRoZSBw
cmltYXJ5IHNvdXJjZSBvZiBtZW1jZyBjaGFyZ2VzIHRoZSBtZW1vcnkgYWNjb3VudGVkIGZvciB0
aGUgb29tDQo+YmFkbmVzcyBwdXJwb3NlcyBpcyBub3QgcmVhbGx5IGNvbXBhcmFibGUgdG8gdGhl
IG92ZXJhbCBtZW1jZyBjaGFyZ2VkDQo+bWVtb3J5LiBLZXJuZWwgbWVtb3J5LCBub24tbWFwcGVk
IG1lbW9yeSBhbGwgdGhhdCBjYW4gZ2VuZXJhdGUgcmF0aGVyDQo+aW50ZXJlc3RpbmcgY29ybmVy
Y2FzZXMuDQoNClNvcnJ5LCBJJ20gdGhvdWdodGxlc3MgZW5vdWdoIGFib3V0IHNvbWUgc3BlY2lh
bCBtZW1vcnkgc3RhdGlzdGljcy4gSSB3aWxsIGZpeCANCml0IGluIHRoZSBuZXh0IHZlcnNpb24N
CiANClRoYW5rcyBmb3IgeW91ciBjb21tZW50IQ0KY2hlbmdrYWl0YW8NCg0K

Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61A4064714E
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Dec 2022 15:07:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229554AbiLHOHP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 8 Dec 2022 09:07:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbiLHOHO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 8 Dec 2022 09:07:14 -0500
Received: from mx6.didiglobal.com (mx6.didiglobal.com [111.202.70.123])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id BEF2417A81;
        Thu,  8 Dec 2022 06:07:11 -0800 (PST)
Received: from mail.didiglobal.com (unknown [10.79.65.18])
        by mx6.didiglobal.com (Maildata Gateway V2.8) with ESMTPS id 0F88711053B802;
        Thu,  8 Dec 2022 22:07:06 +0800 (CST)
Received: from ZJY03-ACTMBX-05.didichuxing.com (10.79.71.35) by
 ZJY02-ACTMBX-06.didichuxing.com (10.79.65.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Thu, 8 Dec 2022 22:07:06 +0800
Received: from ZJY03-ACTMBX-05.didichuxing.com ([fe80::1dcd:f7bf:746e:c769])
 by ZJY03-ACTMBX-05.didichuxing.com ([fe80::1dcd:f7bf:746e:c769%8]) with mapi
 id 15.01.2375.017; Thu, 8 Dec 2022 22:07:06 +0800
X-MD-Sfrom: chengkaitao@didiglobal.com
X-MD-SrcIP: 10.79.65.18
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
Thread-Index: AQHZCrfAdhr5zYTMtke9YS08C4BFfq5jExWAgACNdAD//34EAIAA6LeA
Date:   Thu, 8 Dec 2022 14:07:06 +0000
Message-ID: <3E260DAC-2E2F-48B7-98BB-036EF0A423DC@didiglobal.com>
In-Reply-To: <Y5Gc0jiDlWlRlMYH@dhcp22.suse.cz>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.79.65.102]
Content-Type: text/plain; charset="utf-8"
Content-ID: <4E155EE2AF03EF418EE4F2728C2F93A6@didichuxing.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

QXQgMjAyMi0xMi0wOCAxNjoxNDoxMCwgIk1pY2hhbCBIb2NrbyIgPG1ob2Nrb0BzdXNlLmNvbT4g
d3JvdGU6DQo+T24gVGh1IDA4LTEyLTIyIDA3OjU5OjI3LCDnqIvlnrLmtpsgQ2hlbmdrYWl0YW8g
Q2hlbmcgd3JvdGU6DQo+PiBBdCAyMDIyLTEyLTA4IDE1OjMzOjA3LCAiTWljaGFsIEhvY2tvIiA8
bWhvY2tvQHN1c2UuY29tPiB3cm90ZToNCj4+ID5PbiBUaHUgMDgtMTItMjIgMTE6NDY6NDQsIGNo
ZW5na2FpdGFvIHdyb3RlOg0KPj4gPj4gRnJvbTogY2hlbmdrYWl0YW8gPHBpbGdyaW10YW9AZ21h
aWwuY29tPg0KPj4gPj4gDQo+PiA+PiBXZSBjcmVhdGVkIGEgbmV3IGludGVyZmFjZSA8bWVtb3J5
Lm9vbS5wcm90ZWN0PiBmb3IgbWVtb3J5LCBJZiB0aGVyZSBpcw0KPj4gPj4gdGhlIE9PTSBraWxs
ZXIgdW5kZXIgcGFyZW50IG1lbW9yeSBjZ3JvdXAsIGFuZCB0aGUgbWVtb3J5IHVzYWdlIG9mIGEN
Cj4+ID4+IGNoaWxkIGNncm91cCBpcyB3aXRoaW4gaXRzIGVmZmVjdGl2ZSBvb20ucHJvdGVjdCBi
b3VuZGFyeSwgdGhlIGNncm91cCdzDQo+PiA+PiB0YXNrcyB3b24ndCBiZSBPT00ga2lsbGVkIHVu
bGVzcyB0aGVyZSBpcyBubyB1bnByb3RlY3RlZCB0YXNrcyBpbiBvdGhlcg0KPj4gPj4gY2hpbGRy
ZW4gY2dyb3Vwcy4gSXQgZHJhd3Mgb24gdGhlIGxvZ2ljIG9mIDxtZW1vcnkubWluL2xvdz4gaW4g
dGhlDQo+PiA+PiBpbmhlcml0YW5jZSByZWxhdGlvbnNoaXAuDQo+PiA+PiANCj4+ID4+IEl0IGhh
cyB0aGUgZm9sbG93aW5nIGFkdmFudGFnZXMsDQo+PiA+PiAxLiBXZSBoYXZlIHRoZSBhYmlsaXR5
IHRvIHByb3RlY3QgbW9yZSBpbXBvcnRhbnQgcHJvY2Vzc2VzLCB3aGVuIHRoZXJlDQo+PiA+PiBp
cyBhIG1lbWNnJ3MgT09NIGtpbGxlci4gVGhlIG9vbS5wcm90ZWN0IG9ubHkgdGFrZXMgZWZmZWN0
IGxvY2FsIG1lbWNnLA0KPj4gPj4gYW5kIGRvZXMgbm90IGFmZmVjdCB0aGUgT09NIGtpbGxlciBv
ZiB0aGUgaG9zdC4NCj4+ID4+IDIuIEhpc3RvcmljYWxseSwgd2UgY2FuIG9mdGVuIHVzZSBvb21f
c2NvcmVfYWRqIHRvIGNvbnRyb2wgYSBncm91cCBvZg0KPj4gPj4gcHJvY2Vzc2VzLCBJdCByZXF1
aXJlcyB0aGF0IGFsbCBwcm9jZXNzZXMgaW4gdGhlIGNncm91cCBtdXN0IGhhdmUgYQ0KPj4gPj4g
Y29tbW9uIHBhcmVudCBwcm9jZXNzZXMsIHdlIGhhdmUgdG8gc2V0IHRoZSBjb21tb24gcGFyZW50
IHByb2Nlc3Mncw0KPj4gPj4gb29tX3Njb3JlX2FkaiwgYmVmb3JlIGl0IGZvcmtzIGFsbCBjaGls
ZHJlbiBwcm9jZXNzZXMuIFNvIHRoYXQgaXQgaXMNCj4+ID4+IHZlcnkgZGlmZmljdWx0IHRvIGFw
cGx5IGl0IGluIG90aGVyIHNpdHVhdGlvbnMuIE5vdyBvb20ucHJvdGVjdCBoYXMgbm8NCj4+ID4+
IHN1Y2ggcmVzdHJpY3Rpb25zLCB3ZSBjYW4gcHJvdGVjdCBhIGNncm91cCBvZiBwcm9jZXNzZXMg
bW9yZSBlYXNpbHkuIFRoZQ0KPj4gPj4gY2dyb3VwIGNhbiBrZWVwIHNvbWUgbWVtb3J5LCBldmVu
IGlmIHRoZSBPT00ga2lsbGVyIGhhcyB0byBiZSBjYWxsZWQuDQo+PiA+PiANCj4+ID4+IFNpZ25l
ZC1vZmYtYnk6IGNoZW5na2FpdGFvIDxwaWxncmltdGFvQGdtYWlsLmNvbT4NCj4+ID4+IC0tLQ0K
Pj4gPj4gdjI6IE1vZGlmeSB0aGUgZm9ybXVsYSBvZiB0aGUgcHJvY2VzcyByZXF1ZXN0IG1lbWNn
IHByb3RlY3Rpb24gcXVvdGEuDQo+PiA+DQo+PiA+VGhlIG5ldyBmb3JtdWxhIGRvZXNuJ3QgcmVh
bGx5IGFkZHJlc3MgY29uY2VybnMgZXhwcmVzc2VkIHByZXZpb3VzbHkuDQo+PiA+UGxlYXNlIHJl
YWQgbXkgZmVlZGJhY2sgY2FyZWZ1bGx5IGFnYWluIGFuZCBmb2xsb3cgdXAgd2l0aCBxdWVzdGlv
bnMgaWYNCj4+ID5zb21ldGhpbmcgaXMgbm90IGNsZWFyLg0KPj4gDQo+PiBUaGUgcHJldmlvdXMg
ZGlzY3Vzc2lvbiB3YXMgcXVpdGUgc2NhdHRlcmVkLiBDYW4geW91IGhlbHAgbWUgc3VtbWFyaXpl
DQo+PiB5b3VyIGNvbmNlcm5zIGFnYWluPw0KPg0KPlRoZSBtb3N0IGltcG9ydGFudCBwYXJ0IGlz
IGh0dHA6Ly9sa21sLmtlcm5lbC5vcmcvci9ZNGpGblk3a01kQjhSZVNXQGRoY3AyMi5zdXNlLmN6
DQo+OiBMZXQgbWUganVzdCBlbXBoYXNpc2UgdGhhdCB3ZSBhcmUgdGFsa2luZyBhYm91dCBmdW5k
YW1lbnRhbCBkaXNjb25uZWN0Lg0KPjogUnNzIGJhc2VkIGFjY291bnRpbmcgaGFzIGJlZW4gdXNl
ZCBmb3IgdGhlIE9PTSBraWxsZXIgc2VsZWN0aW9uIGJlY2F1c2UNCj46IHRoZSBtZW1vcnkgZ2V0
cyB1bm1hcHBlZCBhbmQgX3BvdGVudGlhbGx5XyBmcmVlZCB3aGVuIHRoZSBwcm9jZXNzIGdvZXMN
Cj46IGF3YXkuIE1lbWNnIGNoYW5nZXMgYXJlIGJvdW5kIHRvIHRoZSBvYmplY3QgbGlmZSB0aW1l
IGFuZCBhcyBzYWlkIGluDQo+OiBtYW55IGNhc2VzIHRoZXJlIGlzIG5vIGRpcmVjdCByZWxhdGlv
biB3aXRoIGFueSBwcm9jZXNzIGxpZmUgdGltZS4NCj4NCldlIG5lZWQgdG8gZGlzY3VzcyB0aGUg
cmVsYXRpb25zaGlwIGJldHdlZW4gbWVtY2cncyBtZW0gYW5kIHByb2Nlc3MncyBtZW0sIA0KDQp0
YXNrX3VzYWdlID0gdGFza19hbm9uKHJzc19hbm9uKSArIHRhc2tfbWFwcGVkX2ZpbGUocnNzX2Zp
bGUpIA0KCSArIHRhc2tfbWFwcGVkX3NoYXJlKHJzc19zaGFyZSkgKyB0YXNrX3BndGFibGVzICsg
dGFza19zd2FwZW50cw0KDQptZW1jZ191c2FnZQk9IG1lbWNnX2Fub24gKyBtZW1jZ19maWxlICsg
bWVtY2dfcGd0YWJsZXMgKyBtZW1jZ19zaGFyZQ0KCT0gYWxsX3Rhc2tfYW5vbiArIGFsbF90YXNr
X21hcHBlZF9maWxlICsgYWxsX3Rhc2tfbWFwcGVkX3NoYXJlIA0KCSArIGFsbF90YXNrX3BndGFi
bGVzICsgdW5tYXBwZWRfZmlsZSArIHVubWFwcGVkX3NoYXJlDQoJPSBhbGxfdGFza191c2FnZSAr
IHVubWFwcGVkX2ZpbGUgKyB1bm1hcHBlZF9zaGFyZSAtIGFsbF90YXNrX3N3YXBlbnRzDQoNCk1l
bWNnIGlzIGRpcmVjdGx5IHJlbGF0ZWQgdG8gcHJvY2Vzc2VzIGZvciBtb3N0IG1lbW9yeS4gT24g
dGhlIG90aGVyIGhhbmQsIA0KdW5tYXBwZWRfZmlsZSBwYWdlcyBhbmQgdW5tYXBwZWRfc2hhcmUg
cGFnZXMgYXJlbid0IGNoYXJnZWQgaW50byB0aGUgDQpwcm9jZXNzLCBidXQgdGhlc2UgbWVtb3Jp
ZXMgY2FuIG5vdCBiZSByZWxlYXNlZCBieSB0aGUgb29tIGtpbGxlci4gVGhlcmVmb3JlLCANCnRo
ZXkgc2hvdWxkIG5vdCBhcHBseSB0byBjZ3JvdXAgZm9yIHByb3RlY3Rpb24gcXVvdGEuIFRoZXkg
Y2FuIGJlIGV4Y2x1ZGVkIA0KZHVyaW5nIGNhbGN1bGF0aW9uLg0KDQogICAgICAgbWVtY2cgQQ0K
ICAgIC8gICAgIHwgICAgIFwNCnRhc2steCAgdGFzay15ICBjb21tb24tY2FjaGUNCiAgIDJHICAg
ICAyRyAgICAgICAgMkcNCg0KZW9vbS5wcm90ZWN0KG1lbWNnIEEpID0gM0c7DQp1c2FnZShtZW1j
ZyBBKSA9IDZHDQp1c2FnZSh0YXNrIHgpID0gMkcNCnVzYWdlKHRhc2sgeSkgPSAyRw0KY29tbW9u
LWNhY2hlID0gMkcNCg0KQWZ0ZXIgY2FsY3VsYXRpb24sDQphY3R1YWwtcHJvdGVjdGlvbih0YXNr
IHgpID0gMUcNCmFjdHVhbC1wcm90ZWN0aW9uKHRhc2sgeSkgPSAxRw0KDQpUaGlzIGZvcm11bGEg
aXMgbW9yZSBmYWlyIGZvciBncm91cHMgd2l0aCBmZXdlciBjb21tb24tY2FjaGVzICh1bm1hcHBl
ZF8NCmZpbGUgcGFnZXMgYW5kIHVubWFwcGVkX3NoYXJlIHBhZ2VzKS4NCkluIGV4dHJlbWUgZW52
aXJvbm1lbnRzLCB1bm1hcHBlZF9maWxlIHBhZ2VzIGFuZCB1bm1hcHBlZF9zaGFyZSBwYWdlcyAN
Cm1heSBsb2NrIGEgbGFyZ2Ugc2hhcmUgb2YgcHJvdGVjdGlvbiBxdW90YSwgYnV0IGl0IGlzIGV4
cGVjdGVkLg0KDQo+VGhhdCBpcyB0byB0aGUgcGVyLXByb2Nlc3MgZGlzY291bnQgYmFzZWQgb24g
cnNzIG9yIGFueSBwZXItcHJvY2Vzcw0KPm1lbW9yeSBtZXRyaWNzLg0KPg0KPkFub3RoZXIgcmVh
bGx5IGltcG9ydGFudCBxdWVzdGlvbiBpcyB0aGUgYWN0dWFsIGNvbmZpZ3VyYWJpbGl0eS4gVGhl
DQo+aGllcmFyY2hpY2FsIHByb3RlY3Rpb24gaGFzIHRvIGJlIGVuZm9yY2VkIGFuZCB0aGF0IG1l
YW5zIHRoYXQgc2FtZSBhcw0KPm1lbW9yeSByZWNsYWltIHByb3RlY3Rpb24gaXQgaGFzIHRvIGJl
IGVuZm9yY2VkIHRvcC10by1ib3R0b20gaW4gdGhlDQo+Y2dyb3VwIGhpZXJhcmNoeS4gVGhhdCBt
YWtlcyB0aGUgb29tIHByb3RlY3Rpb24gcmF0aGVyIG5vbi10cml2aWFsIHRvDQo+Y29uZmlndXJl
IHdpdGhvdXQgaGF2aW5nIGEgZ29vZCBwaWN0dXJlIG9mIGEgbGFyZ2VyIHBhcnQgb2YgdGhlIGNn
cm91cA0KPmhpZXJhcmNoeSBhcyBpdCBjYW5ub3QgYmUgdHVuZWQgYmFzZWQgb24gYSByZWNsYWlt
IGZlZWRiYWNrLg0KDQpUaGVyZSBpcyBhbiBlc3NlbnRpYWwgZGlmZmVyZW5jZSBiZXR3ZWVuIHJl
Y2xhaW0gYW5kIG9vbSBraWxsZXIuIFRoZSByZWNsYWltIA0KY2Fubm90IGJlIGRpcmVjdGx5IHBl
cmNlaXZlZCBieSB1c2Vycywgc28gbWVtY2cgbmVlZCB0byBjb3VudCBpbmRpY2F0b3JzIA0Kc2lt
aWxhciB0byBwZ3NjYW5fKGtzd2FwZC9kaXJlY3QpLiBIb3dldmVyLCB3aGVuIHRoZSB1c2VyIHBy
b2Nlc3MgaXMga2lsbGVkIA0KYnkgb29tIGtpbGxlciwgdXNlcnMgY2FuIGNsZWFybHkgcGVyY2Vp
dmUgYW5kIGNvdW50IChzdWNoIGFzIHRoZSBudW1iZXIgb2YgDQpyZXN0YXJ0cyBvZiBhIGNlcnRh
aW4gdHlwZSBvZiBwcm9jZXNzKS4gQXQgdGhlIHNhbWUgdGltZSwgdGhlIGtlcm5lbCBhbHNvIGhh
cyANCm1lbW9yeS5ldmVudHMgdG8gY291bnQgc29tZSBpbmZvcm1hdGlvbiBhYm91dCB0aGUgb29t
IGtpbGxlciwgd2hpY2ggY2FuIA0KYWxzbyBiZSB1c2VkIGZvciBmZWVkYmFjayBhZGp1c3RtZW50
LiBPZiBjb3Vyc2UsIEkgY2FuIGFsc28gYWRkIHNvbWUgDQppbmRpY2F0b3JzIHNpbWlsYXIgdG8g
dGhlIGFjY3VtdWxhdGVkIG1lbW9yeSByZWxlYXNlZCBieSB0aGUgb29tIGtpbGxlciANCnRvIGhl
bHAgdXNlcnMgYmV0dGVyIGdyYXNwIHRoZSBkeW5hbWljcyBvZiB0aGUgb29tIGtpbGxlci4gRG8g
eW91IHRoaW5rIGl0IA0KaXMgdmFsdWFibGU/DQotLSANClRoYW5rcyBmb3IgeW91ciBjb21tZW50
IQ0KY2hlbmdrYWl0YW8NCg0K

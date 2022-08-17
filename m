Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 185AC59760D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Aug 2022 20:51:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241204AbiHQSsA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 17 Aug 2022 14:48:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241223AbiHQSr7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 17 Aug 2022 14:47:59 -0400
Received: from smtp-fw-6001.amazon.com (smtp-fw-6001.amazon.com [52.95.48.154])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A059EA3D47;
        Wed, 17 Aug 2022 11:47:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.co.jp; i=@amazon.co.jp; q=dns/txt;
  s=amazon201209; t=1660762078; x=1692298078;
  h=from:to:cc:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version:subject;
  bh=JT0UheZqUwL1j3/nLtQTtWmRIyVlwLxdUB5dC6DEMzw=;
  b=CbKgmShwQTK1TtuKBbNK8UCzCyCjAFA9OrT20liwpdP+0CD6er6iLCqM
   k/VzpDWxGioSVgBiY62BBQ0sHBYnTjo71ZPPu1mgvg+IFpmG0w9aIECwX
   OtkwtSvEdF2t0EzmbnI6UkGa/RpPRcNN1exl86d8+ucJLZLwakPurWwtS
   M=;
Subject: Re: [PATCH v2] locks: Fix dropped call to ->fl_release_private()
Thread-Topic: [PATCH v2] locks: Fix dropped call to ->fl_release_private()
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-iad-1d-b48bc93b.us-east-1.amazon.com) ([10.43.8.2])
  by smtp-border-fw-6001.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2022 18:47:57 +0000
Received: from EX13MTAUWB001.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan3.iad.amazon.com [10.40.163.38])
        by email-inbound-relay-iad-1d-b48bc93b.us-east-1.amazon.com (Postfix) with ESMTPS id 12A22C4428;
        Wed, 17 Aug 2022 18:47:56 +0000 (UTC)
Received: from EX19D004ANA004.ant.amazon.com (10.37.240.146) by
 EX13MTAUWB001.ant.amazon.com (10.43.161.207) with Microsoft SMTP Server (TLS)
 id 15.0.1497.38; Wed, 17 Aug 2022 18:47:55 +0000
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19D004ANA004.ant.amazon.com (10.37.240.146) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1118.12;
 Wed, 17 Aug 2022 18:47:54 +0000
Received: from EX19D004ANA001.ant.amazon.com ([fe80::643d:967a:f5ca:396]) by
 EX19D004ANA001.ant.amazon.com ([fe80::643d:967a:f5ca:396%5]) with mapi id
 15.02.1118.012; Wed, 17 Aug 2022 18:47:54 +0000
From:   "Iwashima, Kuniyuki" <kuniyu@amazon.co.jp>
To:     Jeff Layton <jlayton@kernel.org>,
        David Howells <dhowells@redhat.com>
CC:     Chuck Lever <chuck.lever@oracle.com>,
        Marc Dionne <marc.dionne@auristor.com>,
        "linux-afs@lists.infradead.org" <linux-afs@lists.infradead.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Iwashima, Kuniyuki" <kuniyu@amazon.co.jp>
Thread-Index: AQHYsmk2dzPGHVMfBkyAOXcKUcCBp62y+YuA
Date:   Wed, 17 Aug 2022 18:47:54 +0000
Message-ID: <3444D598-327B-4C74-81D7-B1BC80EA600F@amazon.co.jp>
References: <166076168742.3677624.2936950729624462101.stgit@warthog.procyon.org.uk>
 <e3952386b70e9bf07e676c47a5a9fa63df93bacf.camel@kernel.org>
In-Reply-To: <e3952386b70e9bf07e676c47a5a9fa63df93bacf.camel@kernel.org>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.187.171.21]
Content-Type: text/plain; charset="utf-8"
Content-ID: <205CD97F578E7F47BAE7AE974C1974A1@amazon.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

RnJvbTogSmVmZiBMYXl0b24gPGpsYXl0b25Aa2VybmVsLm9yZz4NCkRhdGU6IFdlZCwgMTcgQXVn
IDIwMjIgMTQ6NDI6NTcgLTA0MDANCj4gT24gV2VkLCAyMDIyLTA4LTE3IGF0IDE5OjQxICswMTAw
LCBEYXZpZCBIb3dlbGxzIHdyb3RlOg0KPiA+IFByaW9yIHRvIGNvbW1pdCA0MTQ5YmU3YmRhN2Us
IHN5c19mbG9jaygpIHdvdWxkIGFsbG9jYXRlIHRoZSBmaWxlX2xvY2sNCj4gPiBzdHJ1Y3QgaXQg
d2FzIGdvaW5nIHRvIHVzZSB0byBwYXNzIHBhcmFtZXRlcnMsIGNhbGwgLT5mbG9jaygpIGFuZCB0
aGVuIGNhbGwNCj4gPiBsb2Nrc19mcmVlX2xvY2soKSB0byBnZXQgcmlkIG9mIGl0IC0gd2hpY2gg
aGFkIHRoZSBzaWRlIGVmZmVjdCBvZiBjYWxsaW5nDQo+ID4gbG9ja3NfcmVsZWFzZV9wcml2YXRl
KCkgYW5kIHRodXMgLT5mbF9yZWxlYXNlX3ByaXZhdGUoKS4NCj4gPg0KPiA+IFdpdGggY29tbWl0
IDQxNDliZTdiZGE3ZSwgaG93ZXZlciwgdGhpcyBpcyBubyBsb25nZXIgdGhlIGNhc2U6IHRoZSBz
dHJ1Y3QNCj4gPiBpcyBub3cgYWxsb2NhdGVkIG9uIHRoZSBzdGFjaywgYW5kIGxvY2tzX2ZyZWVf
bG9jaygpIGlzIG5vIGxvbmdlciBjYWxsZWQgLQ0KPiA+IGFuZCB0aHVzIGFueSByZW1haW5pbmcg
cHJpdmF0ZSBkYXRhIGRvZXNuJ3QgZ2V0IGNsZWFuZWQgdXAgZWl0aGVyLg0KPiA+DQo+ID4gVGhp
cyBjYXVzZXMgYWZzIGZsb2NrIHRvIGNhdXNlIG9vcHMuICBLYXNhbiBjYXRjaGVzIHRoaXMgYXMg
YSBVQUYgYnkgdGhlDQo+ID4gbGlzdF9kZWxfaW5pdCgpIGluIGFmc19mbF9yZWxlYXNlX3ByaXZh
dGUoKSBmb3IgdGhlIGZpbGVfbG9jayByZWNvcmQNCj4gPiBwcm9kdWNlZCBieSBhZnNfZmxfY29w
eV9sb2NrKCkgYXMgdGhlIG9yaWdpbmFsIHJlY29yZCBkaWRuJ3QgZ2V0IGRlbGlzdGVkLg0KPiA+
IEl0IGNhbiBiZSByZXByb2R1Y2VkIHVzaW5nIHRoZSBnZW5lcmljLzUwNCB4ZnN0ZXN0Lg0KPiA+
DQo+ID4gRml4IHRoaXMgYnkgcmVpbnN0YXRpbmcgdGhlIGxvY2tzX3JlbGVhc2VfcHJpdmF0ZSgp
IGNhbGwgaW4gc3lzX2Zsb2NrKCkuDQo+ID4gSSdtIG5vdCBzdXJlIGlmIHRoaXMgd291bGQgYWZm
ZWN0IGFueSBvdGhlciBmaWxlc3lzdGVtcy4gIElmIG5vdCwgdGhlbiB0aGUNCj4gPiByZWxlYXNl
IGNvdWxkIGJlIGRvbmUgaW4gYWZzX2Zsb2NrKCkgaW5zdGVhZC4NCj4gPg0KPiA+IENoYW5nZXMN
Cj4gPiA9PT09PT09DQo+ID4gdmVyICMyKQ0KPiA+ICAtIERvbid0IG5lZWQgdG8gY2FsbCAtPmZs
X3JlbGVhc2VfcHJpdmF0ZSgpIGFmdGVyIGNhbGxpbmcgdGhlIHNlY3VyaXR5DQo+ID4gICAgaG9v
aywgb25seSBhZnRlciBjYWxsaW5nIC0+ZmxvY2soKS4NCj4gPg0KPiA+IEZpeGVzOiA0MTQ5YmU3
YmRhN2UgKCJmcy9sb2NrOiBEb24ndCBhbGxvY2F0ZSBmaWxlX2xvY2sgaW4gZmxvY2tfbWFrZV9s
b2NrKCkuIikNCj4gPiBjYzogS3VuaXl1a2kgSXdhc2hpbWEgPGt1bml5dUBhbWF6b24uY29tPg0K
PiA+IGNjOiBDaHVjayBMZXZlciA8Y2h1Y2subGV2ZXJAb3JhY2xlLmNvbT4NCj4gPiBjYzogSmVm
ZiBMYXl0b24gPGpsYXl0b25Aa2VybmVsLm9yZz4NCj4gPiBjYzogTWFyYyBEaW9ubmUgPG1hcmMu
ZGlvbm5lQGF1cmlzdG9yLmNvbT4NCj4gPiBjYzogbGludXgtYWZzQGxpc3RzLmluZnJhZGVhZC5v
cmcNCj4gPiBjYzogbGludXgtZnNkZXZlbEB2Z2VyLmtlcm5lbC5vcmcNCj4gPiBMaW5rOiBodHRw
czovL2xvcmUua2VybmVsLm9yZy9yLzE2NjA3NTc1ODgwOS4zNTMyNDYyLjEzMzA3OTM1NTg4Nzc3
NTg3NTM2LnN0Z2l0QHdhcnRob2cucHJvY3lvbi5vcmcudWsvICMgdjENCg0Kbml0OiBtaXNzaW5n
IFNpZ25lZC1vZmYtYnkgOikNCg0KQWNrZWQtYnk6IEt1bml5dWtpIEl3YXNoaW1hIDxrdW5peXVA
YW1hem9uLmNvbT4NCg0KVGhhbmtzIGZvciB0aGUgZml4IQ0KDQoNCj4gPiAtLS0NCj4gPg0KPiA+
ICBmcy9sb2Nrcy5jIHwgICAgMSArDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigr
KQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2ZzL2xvY2tzLmMgYi9mcy9sb2Nrcy5jDQo+ID4gaW5k
ZXggYzI2NmNmZGMzMjkxLi42MDdmOTRhMGU3ODkgMTAwNjQ0DQo+ID4gLS0tIGEvZnMvbG9ja3Mu
Yw0KPiA+ICsrKyBiL2ZzL2xvY2tzLmMNCj4gPiBAQCAtMjEyOSw2ICsyMTI5LDcgQEAgU1lTQ0FM
TF9ERUZJTkUyKGZsb2NrLCB1bnNpZ25lZCBpbnQsIGZkLCB1bnNpZ25lZCBpbnQsIGNtZCkNCj4g
PiAgICAgICBlbHNlDQo+ID4gICAgICAgICAgICAgICBlcnJvciA9IGxvY2tzX2xvY2tfZmlsZV93
YWl0KGYuZmlsZSwgJmZsKTsNCj4gPg0KPiA+ICsgICAgIGxvY2tzX3JlbGVhc2VfcHJpdmF0ZSgm
ZmwpOw0KPiA+ICAgb3V0X3B1dGY6DQo+ID4gICAgICAgZmRwdXQoZik7DQo+ID4NCj4gPg0KPiA+
DQo+IA0KPiBMb29rcyBnb29kLiBJJ2xsIGdldCB0aGlzIGludG8gLW5leHQgYW5kIHBsYW4gdG8g
Z2V0IGl0IHVwIHRvIExpbnVzDQo+IHNvb24uDQo+IA0KPiBUaGFua3MhDQo+IC0tDQo+IEplZmYg
TGF5dG9uIDxqbGF5dG9uQGtlcm5lbC5vcmc+DQo+DQoNCg==

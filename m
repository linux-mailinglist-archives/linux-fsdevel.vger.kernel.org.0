Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14146242782
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Aug 2020 11:26:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727870AbgHLJ0K (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 Aug 2020 05:26:10 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:29455 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727829AbgHLJ0J (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 Aug 2020 05:26:09 -0400
X-UUID: 840c09db627d45f8b83fd88a62548da5-20200812
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=ubj2ydOGUWBxq24rYpXstL71ZWF/3bPYbt3glBglWZg=;
        b=FKy0fCxbi/CMJ+6HIO8CwF5mNN0ozbsXxyo4cRBgzCYeA5DolJwlwhRmfJMY0DJzF4tWVbdnfNM8vcOKSKTsa13V7XNLbi0E6ZBbI/hxaxiGWlLstEk5qDwbw5bBgFsc6o0aV7sa7zzjw4lPjrchcXGZf23PipL1rM4+WcICSKk=;
X-UUID: 840c09db627d45f8b83fd88a62548da5-20200812
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw01.mediatek.com
        (envelope-from <chinwen.chang@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 20540285; Wed, 12 Aug 2020 17:26:04 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs01n1.mediatek.inc (172.21.101.68) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 12 Aug 2020 17:26:01 +0800
Received: from [172.21.77.33] (172.21.77.33) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 12 Aug 2020 17:26:01 +0800
Message-ID: <1597224363.32469.12.camel@mtkswgap22>
Subject: Re: [PATCH 2/2] mm: proc: smaps_rollup: do not stall write attempts
 on mmap_lock
From:   Chinwen Chang <chinwen.chang@mediatek.com>
To:     Steven Price <steven.price@arm.com>
CC:     Matthias Brugger <matthias.bgg@gmail.com>,
        Michel Lespinasse <walken@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Vlastimil Babka" <vbabka@suse.cz>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        Davidlohr Bueso <dbueso@suse.de>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Song Liu <songliubraving@fb.com>,
        Jimmy Assarsson <jimmyassarsson@gmail.com>,
        Huang Ying <ying.huang@intel.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-fsdevel@vger.kernel.org>, <wsd_upstream@mediatek.com>
Date:   Wed, 12 Aug 2020 17:26:03 +0800
In-Reply-To: <bf40676e-b14b-44cd-75ce-419c70194783@arm.com>
References: <1597120955-16495-1-git-send-email-chinwen.chang@mediatek.com>
         <1597120955-16495-3-git-send-email-chinwen.chang@mediatek.com>
         <bf40676e-b14b-44cd-75ce-419c70194783@arm.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

T24gV2VkLCAyMDIwLTA4LTEyIGF0IDA5OjM5ICswMTAwLCBTdGV2ZW4gUHJpY2Ugd3JvdGU6DQo+
IE9uIDExLzA4LzIwMjAgMDU6NDIsIENoaW53ZW4gQ2hhbmcgd3JvdGU6DQo+ID4gc21hcHNfcm9s
bHVwIHdpbGwgdHJ5IHRvIGdyYWIgbW1hcF9sb2NrIGFuZCBnbyB0aHJvdWdoIHRoZSB3aG9sZSB2
bWENCj4gPiBsaXN0IHVudGlsIGl0IGZpbmlzaGVzIHRoZSBpdGVyYXRpbmcuIFdoZW4gZW5jb3Vu
dGVyaW5nIGxhcmdlIHByb2Nlc3NlcywNCj4gPiB0aGUgbW1hcF9sb2NrIHdpbGwgYmUgaGVsZCBm
b3IgYSBsb25nZXIgdGltZSwgd2hpY2ggbWF5IGJsb2NrIG90aGVyDQo+ID4gd3JpdGUgcmVxdWVz
dHMgbGlrZSBtbWFwIGFuZCBtdW5tYXAgZnJvbSBwcm9ncmVzc2luZyBzbW9vdGhseS4NCj4gPiAN
Cj4gPiBUaGVyZSBhcmUgdXBjb21pbmcgbW1hcF9sb2NrIG9wdGltaXphdGlvbnMgbGlrZSByYW5n
ZS1iYXNlZCBsb2NrcywgYnV0DQo+ID4gdGhlIGxvY2sgYXBwbGllZCB0byBzbWFwc19yb2xsdXAg
d291bGQgYmUgdGhlIGNvYXJzZSB0eXBlLCB3aGljaCBkb2Vzbid0DQo+ID4gYXZvaWQgdGhlIG9j
Y3VycmVuY2Ugb2YgdW5wbGVhc2FudCBjb250ZW50aW9uLg0KPiA+IA0KPiA+IFRvIHNvbHZlIGFm
b3JlbWVudGlvbmVkIGlzc3VlLCB3ZSBhZGQgYSBjaGVjayB3aGljaCBkZXRlY3RzIHdoZXRoZXIN
Cj4gPiBhbnlvbmUgd2FudHMgdG8gZ3JhYiBtbWFwX2xvY2sgZm9yIHdyaXRlIGF0dGVtcHRzLg0K
PiA+IA0KPiA+IFNpZ25lZC1vZmYtYnk6IENoaW53ZW4gQ2hhbmcgPGNoaW53ZW4uY2hhbmdAbWVk
aWF0ZWsuY29tPg0KPiA+IC0tLQ0KPiA+ICAgZnMvcHJvYy90YXNrX21tdS5jIHwgMjEgKysrKysr
KysrKysrKysrKysrKysrDQo+ID4gICAxIGZpbGUgY2hhbmdlZCwgMjEgaW5zZXJ0aW9ucygrKQ0K
PiA+IA0KPiA+IGRpZmYgLS1naXQgYS9mcy9wcm9jL3Rhc2tfbW11LmMgYi9mcy9wcm9jL3Rhc2tf
bW11LmMNCj4gPiBpbmRleCBkYmRhNDQ5Li40YjUxZjI1IDEwMDY0NA0KPiA+IC0tLSBhL2ZzL3By
b2MvdGFza19tbXUuYw0KPiA+ICsrKyBiL2ZzL3Byb2MvdGFza19tbXUuYw0KPiA+IEBAIC04NTYs
NiArODU2LDI3IEBAIHN0YXRpYyBpbnQgc2hvd19zbWFwc19yb2xsdXAoc3RydWN0IHNlcV9maWxl
ICptLCB2b2lkICp2KQ0KPiA+ICAgCWZvciAodm1hID0gcHJpdi0+bW0tPm1tYXA7IHZtYTsgdm1h
ID0gdm1hLT52bV9uZXh0KSB7DQo+ID4gICAJCXNtYXBfZ2F0aGVyX3N0YXRzKHZtYSwgJm1zcyk7
DQo+ID4gICAJCWxhc3Rfdm1hX2VuZCA9IHZtYS0+dm1fZW5kOw0KPiA+ICsNCj4gPiArCQkvKg0K
PiA+ICsJCSAqIFJlbGVhc2UgbW1hcF9sb2NrIHRlbXBvcmFyaWx5IGlmIHNvbWVvbmUgd2FudHMg
dG8NCj4gPiArCQkgKiBhY2Nlc3MgaXQgZm9yIHdyaXRlIHJlcXVlc3QuDQo+ID4gKwkJICovDQo+
ID4gKwkJaWYgKG1tYXBfbG9ja19pc19jb250ZW5kZWQobW0pKSB7DQo+ID4gKwkJCW1tYXBfcmVh
ZF91bmxvY2sobW0pOw0KPiA+ICsJCQlyZXQgPSBtbWFwX3JlYWRfbG9ja19raWxsYWJsZShtbSk7
DQo+ID4gKwkJCWlmIChyZXQpIHsNCj4gPiArCQkJCXJlbGVhc2VfdGFza19tZW1wb2xpY3kocHJp
dik7DQo+ID4gKwkJCQlnb3RvIG91dF9wdXRfbW07DQo+ID4gKwkJCX0NCj4gPiArDQo+ID4gKwkJ
CS8qIENoZWNrIHdoZXRoZXIgY3VycmVudCB2bWEgaXMgYXZhaWxhYmxlICovDQo+ID4gKwkJCXZt
YSA9IGZpbmRfdm1hKG1tLCBsYXN0X3ZtYV9lbmQgLSAxKTsNCj4gPiArCQkJaWYgKHZtYSAmJiB2
bWEtPnZtX3N0YXJ0IDwgbGFzdF92bWFfZW5kKQ0KPiANCj4gSSBtYXkgYmUgd3JvbmcsIGJ1dCB0
aGlzIGxvb2tzIGxpa2UgaXQgY291bGQgcmV0dXJuIGluY29ycmVjdCByZXN1bHRzLiANCj4gRm9y
IGV4YW1wbGUgaWYgd2Ugc3RhcnQgcmVhZGluZyB3aXRoIHRoZSBmb2xsb3dpbmcgVk1BczoNCj4g
DQo+ICAgKy0tLS0tLSstLS0tLS0rLS0tLS0tLS0tLS0rDQo+ICAgfCBWTUExIHwgVk1BMiB8IFZN
QTMgICAgICB8DQo+ICAgKy0tLS0tLSstLS0tLS0rLS0tLS0tLS0tLS0rDQo+ICAgfCAgICAgIHwg
ICAgICB8ICAgICAgICAgICB8DQo+IDRrICAgICA4ayAgICAgMTZrICAgICAgICAgNDAwaw0KPiAN
Cj4gVGhlbiBhZnRlciByZWFkaW5nIFZNQTIgd2UgZHJvcCB0aGUgbG9jayBkdWUgdG8gY29udGVu
dGlvbi4gU286DQo+IA0KPiAgICBsYXN0X3ZtYV9lbmQgPSAxNmsNCj4gDQo+IFRoZW4gaWYgVk1B
MiBpcyBmcmVlZCB3aGlsZSB0aGUgbG9jayBpcyBkcm9wcGVkLCBzbyB3ZSBoYXZlOg0KPiANCj4g
ICArLS0tLS0tKyAgICAgICstLS0tLS0tLS0tLSsNCj4gICB8IFZNQTEgfCAgICAgIHwgVk1BMyAg
ICAgIHwNCj4gICArLS0tLS0tKyAgICAgICstLS0tLS0tLS0tLSsNCj4gICB8ICAgICAgfCAgICAg
IHwgICAgICAgICAgIHwNCj4gNGsgICAgIDhrICAgICAxNmsgICAgICAgICA0MDBrDQo+IA0KPiBm
aW5kX3ZtYShtbSwgMTZrLTEpIHdpbGwgdGhlbiByZXR1cm4gVk1BMyBhbmQgdGhlIGNvbmRpdGlv
biB2bV9zdGFydCA8IA0KPiBsYXN0X3ZtYV9lbmQgd2lsbCBiZSBmYWxzZS4NCj4gDQpIaSBTdGV2
ZSwNCg0KVGhhbmsgeW91IGZvciByZXZpZXdpbmcgdGhpcyBwYXRjaC4NCg0KWW91IGFyZSBjb3Jy
ZWN0LiBJZiB0aGUgY29udGVudGlvbiBpcyBkZXRlY3RlZCBhbmQgdGhlIGN1cnJlbnQgdm1hKGhl
cmUNCmlzIFZNQTIpIGlzIGZyZWVkIHdoaWxlIHRoZSBsb2NrIGlzIGRyb3BwZWQsIGl0IHdpbGwg
cmVwb3J0IGFuDQppbmNvbXBsZXRlIHJlc3VsdC4NCg0KPiA+ICsJCQkJY29udGludWU7DQo+ID4g
Kw0KPiA+ICsJCQkvKiBDdXJyZW50IHZtYSBpcyBub3QgYXZhaWxhYmxlLCBqdXN0IGJyZWFrICov
DQo+ID4gKwkJCWJyZWFrOw0KPiANCj4gV2hpY2ggbWVhbnMgd2UgYnJlYWsgb3V0IGhlcmUgYW5k
IHJlcG9ydCBhbiBpbmNvbXBsZXRlIG91dHB1dCAodGhlIA0KPiBudW1iZXJzIHdpbGwgYmUgbXVj
aCBzbWFsbGVyIHRoYW4gcmVhbGl0eSkuDQo+IA0KPiBXb3VsZCBpdCBiZSBiZXR0ZXIgdG8gaGF2
ZSBhIGxvb3AgbGlrZToNCj4gDQo+IAlmb3IgKHZtYSA9IHByaXYtPm1tLT5tbWFwOyB2bWE7KSB7
DQo+IAkJc21hcF9nYXRoZXJfc3RhdHModm1hLCAmbXNzKTsNCj4gCQlsYXN0X3ZtYV9lbmQgPSB2
bWEtPnZtX2VuZDsNCj4gDQo+IAkJaWYgKGNvbnRlbmRlZCkgew0KPiAJCQkvKiBkcm9wL2FjcXVp
cmUgbG9jayAqLw0KPiANCj4gCQkJdm1hID0gZmluZF92bWEobW0sIGxhc3Rfdm1hX2VuZCAtIDEp
Ow0KPiAJCQlpZiAoIXZtYSkNCj4gCQkJCWJyZWFrOw0KPiAJCQlpZiAodm1hLT52bV9zdGFydCA+
PSBsYXN0X3ZtYV9lbmQpDQo+IAkJCQljb250aW51ZTsNCj4gCQl9DQo+IAkJdm1hID0gdm1hLT52
bV9uZXh0Ow0KPiAJfQ0KPiANCj4gdGhhdCB3YXkgaWYgdGhlIFZNQSBpcyByZW1vdmVkIHdoaWxl
IHRoZSBsb2NrIGlzIGRyb3BwZWQgdGhlIGxvb3AgY2FuIA0KPiBqdXN0IGNvbnRpbnVlIGZyb20g
dGhlIG5leHQgVk1BLg0KPiANClRoYW5rcyBhIGxvdCBmb3IgeW91ciBncmVhdCBzdWdnZXN0aW9u
Lg0KDQo+IE9yIHBlcmhhcHMgSSBtaXNzZWQgc29tZXRoaW5nIG9idmlvdXM/IEkgaGF2ZW4ndCBh
Y3R1YWxseSB0ZXN0ZWQgDQo+IGFueXRoaW5nIGFib3ZlLg0KPiANCj4gU3RldmUNCg0KSSB3aWxs
IHByZXBhcmUgbmV3IHBhdGNoIHNlcmllcyBmb3IgZnVydGhlciByZXZpZXdzLg0KDQpUaGFuayB5
b3UuDQpDaGlud2VuDQo+IA0KPiA+ICsJCX0NCj4gPiAgIAl9DQo+ID4gICANCj4gPiAgIAlzaG93
X3ZtYV9oZWFkZXJfcHJlZml4KG0sIHByaXYtPm1tLT5tbWFwLT52bV9zdGFydCwNCj4gPiANCj4g
DQoNCg==


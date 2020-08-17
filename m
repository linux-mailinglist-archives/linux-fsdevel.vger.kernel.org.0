Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A00024623B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Aug 2020 11:15:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726203AbgHQJPP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Aug 2020 05:15:15 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:51317 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726133AbgHQJPN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Aug 2020 05:15:13 -0400
X-UUID: 35b45e7bfc6841338129c60b26e8a854-20200817
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=8fSjUccvg56HN6Kcthxgsp48fEjfxGm/EiyJrkfm+Pg=;
        b=E4V2pVkzekPzhZNAAGJlq7nn1mdmFuhTYv/UmQazAdpkFvgCgDG4QUPqtQy0PCrPVDx8Ji1lZPmqM+J2OqkLMSMn49vlCIQ6gmNAkvya+cZAw4D735cBl3eCvGrhk2ZCtTc+fPHo/+cpw15CbSLKBsrqWDqx/yoZGQRvMjw2qes=;
X-UUID: 35b45e7bfc6841338129c60b26e8a854-20200817
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
        (envelope-from <chinwen.chang@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1299714506; Mon, 17 Aug 2020 17:15:10 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs01n1.mediatek.inc (172.21.101.68) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 17 Aug 2020 17:15:06 +0800
Received: from [172.21.77.33] (172.21.77.33) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 17 Aug 2020 17:15:06 +0800
Message-ID: <1597655708.32469.62.camel@mtkswgap22>
Subject: Re: [PATCH v3 3/3] mm: proc: smaps_rollup: do not stall write
 attempts on mmap_lock
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
        Daniel Kiss <daniel.kiss@arm.com>,
        Laurent Dufour <ldufour@linux.ibm.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-fsdevel@vger.kernel.org>, <wsd_upstream@mediatek.com>
Date:   Mon, 17 Aug 2020 17:15:08 +0800
In-Reply-To: <db0d40e2-72f3-09d5-c162-9c49218f128f@arm.com>
References: <1597472419-32314-1-git-send-email-chinwen.chang@mediatek.com>
         <1597472419-32314-4-git-send-email-chinwen.chang@mediatek.com>
         <db0d40e2-72f3-09d5-c162-9c49218f128f@arm.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

T24gTW9uLCAyMDIwLTA4LTE3IGF0IDA5OjM4ICswMTAwLCBTdGV2ZW4gUHJpY2Ugd3JvdGU6DQo+
IE9uIDE1LzA4LzIwMjAgMDc6MjAsIENoaW53ZW4gQ2hhbmcgd3JvdGU6DQo+ID4gc21hcHNfcm9s
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
PiA+IA0KPiA+IENoYW5nZSBzaW5jZSB2MToNCj4gPiAtIElmIGN1cnJlbnQgVk1BIGlzIGZyZWVk
IGFmdGVyIGRyb3BwaW5nIHRoZSBsb2NrLCBpdCB3aWxsIHJldHVybg0KPiA+IC0gaW5jb21wbGV0
ZSByZXN1bHQuIFRvIGZpeCB0aGlzIGlzc3VlLCByZWZpbmUgdGhlIGNvZGUgZmxvdyBhcw0KPiA+
IC0gc3VnZ2VzdGVkIGJ5IFN0ZXZlLiBbMV0NCj4gPiANCj4gPiBDaGFuZ2Ugc2luY2UgdjI6DQo+
ID4gLSBXaGVuIGdldHRpbmcgYmFjayB0aGUgbW1hcCBsb2NrLCB0aGUgYWRkcmVzcyB3aGVyZSB5
b3Ugc3RvcHBlZCBsYXN0DQo+ID4gLSB0aW1lIGNvdWxkIG5vdyBiZSBpbiB0aGUgbWlkZGxlIG9m
IGEgdm1hLiBBZGQgb25lIG1vcmUgY2hlY2sgdG8gaGFuZGxlDQo+ID4gLSB0aGlzIGNhc2UgYXMg
c3VnZ2VzdGVkIGJ5IE1pY2hlbC4gWzJdDQo+ID4gDQo+ID4gWzFdIGh0dHBzOi8vbG9yZS5rZXJu
ZWwub3JnL2xrbWwvYmY0MDY3NmUtYjE0Yi00NGNkLTc1Y2UtNDE5YzcwMTk0NzgzQGFybS5jb20v
DQo+ID4gWzJdIGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xrbWwvQ0FOTjY4OUZ0Q3NDNzFjakFq
czBHUHNwT2hnb19IUmorZGlXc29VMXdyOThZUGt0Z1dnQG1haWwuZ21haWwuY29tLw0KPiA+IA0K
PiA+IFNpZ25lZC1vZmYtYnk6IENoaW53ZW4gQ2hhbmcgPGNoaW53ZW4uY2hhbmdAbWVkaWF0ZWsu
Y29tPg0KPiA+IENDOiBTdGV2ZW4gUHJpY2UgPHN0ZXZlbi5wcmljZUBhcm0uY29tPg0KPiA+IEND
OiBNaWNoZWwgTGVzcGluYXNzZSA8d2Fsa2VuQGdvb2dsZS5jb20+DQo+IA0KPiBSZXZpZXdlZC1i
eTogU3RldmVuIFByaWNlIDxzdGV2ZW4ucHJpY2VAYXJtLmNvbT4NCj4gDQo+ID4gLS0tDQo+ID4g
ICBmcy9wcm9jL3Rhc2tfbW11LmMgfCA3MyArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKystLS0NCj4gPiAgIDEgZmlsZSBjaGFuZ2VkLCA3MCBpbnNlcnRp
b25zKCspLCAzIGRlbGV0aW9ucygtKQ0KPiA+IA0KPiA+IGRpZmYgLS1naXQgYS9mcy9wcm9jL3Rh
c2tfbW11LmMgYi9mcy9wcm9jL3Rhc2tfbW11LmMNCj4gPiBpbmRleCA3NmU2MjNhLi45NDU5MDRl
IDEwMDY0NA0KPiA+IC0tLSBhL2ZzL3Byb2MvdGFza19tbXUuYw0KPiA+ICsrKyBiL2ZzL3Byb2Mv
dGFza19tbXUuYw0KPiA+IEBAIC04NDYsNyArODQ2LDcgQEAgc3RhdGljIGludCBzaG93X3NtYXBz
X3JvbGx1cChzdHJ1Y3Qgc2VxX2ZpbGUgKm0sIHZvaWQgKnYpDQo+ID4gICAJc3RydWN0IG1lbV9z
aXplX3N0YXRzIG1zczsNCj4gPiAgIAlzdHJ1Y3QgbW1fc3RydWN0ICptbTsNCj4gPiAgIAlzdHJ1
Y3Qgdm1fYXJlYV9zdHJ1Y3QgKnZtYTsNCj4gPiAtCXVuc2lnbmVkIGxvbmcgbGFzdF92bWFfZW5k
ID0gMDsNCj4gPiArCXVuc2lnbmVkIGxvbmcgbGFzdF92bWFfZW5kID0gMCwgbGFzdF9zdG9wcGVk
ID0gMDsNCj4gPiAgIAlpbnQgcmV0ID0gMDsNCj4gPiAgIA0KPiA+ICAgCXByaXYtPnRhc2sgPSBn
ZXRfcHJvY190YXNrKHByaXYtPmlub2RlKTsNCj4gPiBAQCAtODY3LDkgKzg2Nyw3NiBAQCBzdGF0
aWMgaW50IHNob3dfc21hcHNfcm9sbHVwKHN0cnVjdCBzZXFfZmlsZSAqbSwgdm9pZCAqdikNCj4g
PiAgIA0KPiA+ICAgCWhvbGRfdGFza19tZW1wb2xpY3kocHJpdik7DQo+ID4gICANCj4gPiAtCWZv
ciAodm1hID0gcHJpdi0+bW0tPm1tYXA7IHZtYTsgdm1hID0gdm1hLT52bV9uZXh0KSB7DQo+ID4g
LQkJc21hcF9nYXRoZXJfc3RhdHModm1hLCAmbXNzLCAwKTsNCj4gPiArCWZvciAodm1hID0gcHJp
di0+bW0tPm1tYXA7IHZtYTspIHsNCj4gPiArCQlzbWFwX2dhdGhlcl9zdGF0cyh2bWEsICZtc3Ms
IGxhc3Rfc3RvcHBlZCk7DQo+ID4gKwkJbGFzdF9zdG9wcGVkID0gMDsNCj4gPiAgIAkJbGFzdF92
bWFfZW5kID0gdm1hLT52bV9lbmQ7DQo+ID4gKw0KPiA+ICsJCS8qDQo+ID4gKwkJICogUmVsZWFz
ZSBtbWFwX2xvY2sgdGVtcG9yYXJpbHkgaWYgc29tZW9uZSB3YW50cyB0bw0KPiA+ICsJCSAqIGFj
Y2VzcyBpdCBmb3Igd3JpdGUgcmVxdWVzdC4NCj4gPiArCQkgKi8NCj4gPiArCQlpZiAobW1hcF9s
b2NrX2lzX2NvbnRlbmRlZChtbSkpIHsNCj4gPiArCQkJbW1hcF9yZWFkX3VubG9jayhtbSk7DQo+
ID4gKwkJCXJldCA9IG1tYXBfcmVhZF9sb2NrX2tpbGxhYmxlKG1tKTsNCj4gPiArCQkJaWYgKHJl
dCkgew0KPiA+ICsJCQkJcmVsZWFzZV90YXNrX21lbXBvbGljeShwcml2KTsNCj4gPiArCQkJCWdv
dG8gb3V0X3B1dF9tbTsNCj4gPiArCQkJfQ0KPiA+ICsNCj4gPiArCQkJLyoNCj4gPiArCQkJICog
QWZ0ZXIgZHJvcHBpbmcgdGhlIGxvY2ssIHRoZXJlIGFyZSBmb3VyIGNhc2VzIHRvDQo+ID4gKwkJ
CSAqIGNvbnNpZGVyLiBTZWUgdGhlIGZvbGxvd2luZyBleGFtcGxlIGZvciBleHBsYW5hdGlvbi4N
Cj4gPiArCQkJICoNCj4gPiArCQkJICogICArLS0tLS0tKy0tLS0tLSstLS0tLS0tLS0tLSsNCj4g
PiArCQkJICogICB8IFZNQTEgfCBWTUEyIHwgVk1BMyAgICAgIHwNCj4gPiArCQkJICogICArLS0t
LS0tKy0tLS0tLSstLS0tLS0tLS0tLSsNCj4gPiArCQkJICogICB8ICAgICAgfCAgICAgIHwgICAg
ICAgICAgIHwNCj4gPiArCQkJICogIDRrICAgICA4ayAgICAgMTZrICAgICAgICAgNDAwaw0KPiA+
ICsJCQkgKg0KPiA+ICsJCQkgKiBTdXBwb3NlIHdlIGRyb3AgdGhlIGxvY2sgYWZ0ZXIgcmVhZGlu
ZyBWTUEyIGR1ZSB0bw0KPiA+ICsJCQkgKiBjb250ZW50aW9uLCB0aGVuIHdlIGdldDoNCj4gPiAr
CQkJICoNCj4gPiArCQkJICoJbGFzdF92bWFfZW5kID0gMTZrDQo+ID4gKwkJCSAqDQo+ID4gKwkJ
CSAqIDEpIFZNQTIgaXMgZnJlZWQsIGJ1dCBWTUEzIGV4aXN0czoNCj4gPiArCQkJICoNCj4gPiAr
CQkJICogICAgZmluZF92bWEobW0sIDE2ayAtIDEpIHdpbGwgcmV0dXJuIFZNQTMuDQo+ID4gKwkJ
CSAqICAgIEluIHRoaXMgY2FzZSwganVzdCBjb250aW51ZSBmcm9tIFZNQTMuDQo+ID4gKwkJCSAq
DQo+ID4gKwkJCSAqIDIpIFZNQTIgc3RpbGwgZXhpc3RzOg0KPiA+ICsJCQkgKg0KPiA+ICsJCQkg
KiAgICBmaW5kX3ZtYShtbSwgMTZrIC0gMSkgd2lsbCByZXR1cm4gVk1BMi4NCj4gPiArCQkJICog
ICAgSXRlcmF0ZSB0aGUgbG9vcCBsaWtlIHRoZSBvcmlnaW5hbCBvbmUuDQo+ID4gKwkJCSAqDQo+
ID4gKwkJCSAqIDMpIE5vIG1vcmUgVk1BcyBjYW4gYmUgZm91bmQ6DQo+ID4gKwkJCSAqDQo+ID4g
KwkJCSAqICAgIGZpbmRfdm1hKG1tLCAxNmsgLSAxKSB3aWxsIHJldHVybiBOVUxMLg0KPiA+ICsJ
CQkgKiAgICBObyBtb3JlIHRoaW5ncyB0byBkbywganVzdCBicmVhay4NCj4gPiArCQkJICoNCj4g
PiArCQkJICogNCkgKGxhc3Rfdm1hX2VuZCAtIDEpIGlzIHRoZSBtaWRkbGUgb2YgYSB2bWEgKFZN
QScpOg0KPiA+ICsJCQkgKg0KPiA+ICsJCQkgKiAgICBmaW5kX3ZtYShtbSwgMTZrIC0gMSkgd2ls
bCByZXR1cm4gVk1BJyB3aG9zZSByYW5nZQ0KPiA+ICsJCQkgKiAgICBjb250YWlucyBsYXN0X3Zt
YV9lbmQuDQo+ID4gKwkJCSAqICAgIEl0ZXJhdGUgVk1BJyBmcm9tIGxhc3Rfdm1hX2VuZC4NCj4g
PiArCQkJICovDQo+ID4gKwkJCXZtYSA9IGZpbmRfdm1hKG1tLCBsYXN0X3ZtYV9lbmQgLSAxKTsN
Cj4gPiArCQkJLyogQ2FzZSAzIGFib3ZlICovDQo+ID4gKwkJCWlmICghdm1hKQ0KPiA+ICsJCQkJ
YnJlYWs7DQo+ID4gKw0KPiA+ICsJCQkvKiBDYXNlIDEgYWJvdmUgKi8NCj4gPiArCQkJaWYgKHZt
YS0+dm1fc3RhcnQgPj0gbGFzdF92bWFfZW5kKQ0KPiA+ICsJCQkJY29udGludWU7DQo+ID4gKw0K
PiA+ICsJCQkvKiBDYXNlIDQgYWJvdmUgKi8NCj4gPiArCQkJaWYgKHZtYS0+dm1fZW5kID4gbGFz
dF92bWFfZW5kKSB7DQo+ID4gKwkJCQlsYXN0X3N0b3BwZWQgPSBsYXN0X3ZtYV9lbmQ7DQo+ID4g
KwkJCQljb250aW51ZTsNCj4gDQo+IE5vdGUgdGhhdCBpbnN0ZWFkIG9mIGhhdmluZyBsYXN0X3N0
b3BwZWQsIHlvdSBjb3VsZCByZXBsYWNlIHRoZSBhYm92ZSANCj4gd2l0aCBhIGRpcmVjdCBjYWxs
Og0KPiANCj4gICAgc21hcF9nYXRoZXJfc3RhdHModm1hLCAmbXNzLCBsYXN0X3ZtYV9lbmQpOw0K
PiANCj4gSSdtIG5vdCBzdXJlIHdoaWNoIGlzIGNsZWFuZXIgdGhvdWdoLiBsYXN0X3N0b3BwZWQg
aXMgYSBiaXQgbWVzc3kgKGl0J3MgDQo+IGVhc2lseSBjb25mdXNlZCB3aXRoIGxhc3Rfdm1hX2Vu
ZCksIGJ1dCBoYXZpbmcganVzdCB0aGUgb25lIGNhbGwgc2l0ZSANCj4gZm9yIHNtYXBfZ2F0aGVy
X3N0YXRzKCkgaXMgbmljZSB0b28uDQo+IA0KPiBTdGV2ZQ0KPiANCg0KSGkgU3RldmUsDQoNCkkg
dGhpbmsgeW91ciBpZGVhIGlzIGJldHRlci4gTGV0IG1lIHRyeSByZWZhY3RvcmluZyBmb3IgZnVy
dGhlciByZXZpZXdzLg0KVGhhbmtzIGZvciB5b3VyIGtpbmQgc3VnZ2VzdGlvbjopDQoNCkNoaW53
ZW4NCj4gPiArCQkJfQ0KPiA+ICsJCX0NCj4gPiArCQkvKiBDYXNlIDIgYWJvdmUgKi8NCj4gPiAr
CQl2bWEgPSB2bWEtPnZtX25leHQ7DQo+ID4gICAJfQ0KPiA+ICAgDQo+ID4gICAJc2hvd192bWFf
aGVhZGVyX3ByZWZpeChtLCBwcml2LT5tbS0+bW1hcC0+dm1fc3RhcnQsDQo+ID4gDQo+IA0KDQo=


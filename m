Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78EE1243D08
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Aug 2020 18:11:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726656AbgHMQLe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 Aug 2020 12:11:34 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:51667 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726384AbgHMQLe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 Aug 2020 12:11:34 -0400
X-UUID: 1035ad2c217c41c78d291d408254251a-20200814
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=XSjRijPE+nl4SmKKM6w/kNS1fIeih5vxdwiviIYA5dc=;
        b=dUaibPgDf6r8W37jvcQi7XPsFZtDJ1cYrCM1no+nHKPLYFPgTAnjh81M6mqNxHQ25hv+YX7luKCYHLE21JmcUoYZV3JjW9QWYFy2sgvsOD0KpxfscrfycHt2GtsnphdsG4fg5TacMc5pFwB3iYNJHt1UJKDlUNze7JQLSn9Os8c=;
X-UUID: 1035ad2c217c41c78d291d408254251a-20200814
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw02.mediatek.com
        (envelope-from <chinwen.chang@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1536633934; Fri, 14 Aug 2020 00:11:30 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs01n1.mediatek.inc (172.21.101.68) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 14 Aug 2020 00:11:26 +0800
Received: from [172.21.77.33] (172.21.77.33) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 14 Aug 2020 00:11:26 +0800
Message-ID: <1597335088.32469.55.camel@mtkswgap22>
Subject: Re: [PATCH v2 0/2] Try to release mmap_lock temporarily in
 smaps_rollup
From:   Chinwen Chang <chinwen.chang@mediatek.com>
To:     Michel Lespinasse <walken@google.com>
CC:     Matthias Brugger <matthias.bgg@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Daniel Jordan" <daniel.m.jordan@oracle.com>,
        Davidlohr Bueso <dbueso@suse.de>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Steven Price <steven.price@arm.com>,
        Song Liu <songliubraving@fb.com>,
        Jimmy Assarsson <jimmyassarsson@gmail.com>,
        Huang Ying <ying.huang@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-fsdevel@vger.kernel.org>, <wsd_upstream@mediatek.com>
Date:   Fri, 14 Aug 2020 00:11:28 +0800
In-Reply-To: <CANN689G0DkL-wpxMha=nyysPYG6LM3Aw7060k2xQTxTA4PAf-w@mail.gmail.com>
References: <1597284810-17454-1-git-send-email-chinwen.chang@mediatek.com>
         <CANN689G0DkL-wpxMha=nyysPYG6LM3Aw7060k2xQTxTA4PAf-w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

T24gVGh1LCAyMDIwLTA4LTEzIGF0IDAyOjUzIC0wNzAwLCBNaWNoZWwgTGVzcGluYXNzZSB3cm90
ZToNCj4gT24gV2VkLCBBdWcgMTIsIDIwMjAgYXQgNzoxNCBQTSBDaGlud2VuIENoYW5nDQo+IDxj
aGlud2VuLmNoYW5nQG1lZGlhdGVrLmNvbT4gd3JvdGU6DQo+ID4gUmVjZW50bHksIHdlIGhhdmUg
b2JzZXJ2ZWQgc29tZSBqYW5reSBpc3N1ZXMgY2F1c2VkIGJ5IHVucGxlYXNhbnRseSBsb25nDQo+
ID4gY29udGVudGlvbiBvbiBtbWFwX2xvY2sgd2hpY2ggaXMgaGVsZCBieSBzbWFwc19yb2xsdXAg
d2hlbiBwcm9iaW5nIGxhcmdlDQo+ID4gcHJvY2Vzc2VzLiBUbyBhZGRyZXNzIHRoZSBwcm9ibGVt
LCB3ZSBsZXQgc21hcHNfcm9sbHVwIGRldGVjdCBpZiBhbnlvbmUNCj4gPiB3YW50cyB0byBhY3F1
aXJlIG1tYXBfbG9jayBmb3Igd3JpdGUgYXR0ZW1wdHMuIElmIHllcywganVzdCByZWxlYXNlIHRo
ZQ0KPiA+IGxvY2sgdGVtcG9yYXJpbHkgdG8gZWFzZSB0aGUgY29udGVudGlvbi4NCj4gPg0KPiA+
IHNtYXBzX3JvbGx1cCBpcyBhIHByb2NmcyBpbnRlcmZhY2Ugd2hpY2ggYWxsb3dzIHVzZXJzIHRv
IHN1bW1hcml6ZSB0aGUNCj4gPiBwcm9jZXNzJ3MgbWVtb3J5IHVzYWdlIHdpdGhvdXQgdGhlIG92
ZXJoZWFkIG9mIHNlcV8qIGNhbGxzLiBBbmRyb2lkIHVzZXMgaXQNCj4gPiB0byBzYW1wbGUgdGhl
IG1lbW9yeSB1c2FnZSBvZiB2YXJpb3VzIHByb2Nlc3NlcyB0byBiYWxhbmNlIGl0cyBtZW1vcnkg
cG9vbA0KPiA+IHNpemVzLiBJZiBubyBvbmUgd2FudHMgdG8gdGFrZSB0aGUgbG9jayBmb3Igd3Jp
dGUgcmVxdWVzdHMsIHNtYXBzX3JvbGx1cA0KPiA+IHdpdGggdGhpcyBwYXRjaCB3aWxsIGJlaGF2
ZSBsaWtlIHRoZSBvcmlnaW5hbCBvbmUuDQo+ID4NCj4gPiBBbHRob3VnaCB0aGVyZSBhcmUgb24t
Z29pbmcgbW1hcF9sb2NrIG9wdGltaXphdGlvbnMgbGlrZSByYW5nZS1iYXNlZCBsb2NrcywNCj4g
PiB0aGUgbG9jayBhcHBsaWVkIHRvIHNtYXBzX3JvbGx1cCB3b3VsZCBiZSB0aGUgY29hcnNlIG9u
ZSwgd2hpY2ggaXMgaGFyZCB0bw0KPiA+IGF2b2lkIHRoZSBvY2N1cnJlbmNlIG9mIGFmb3JlbWVu
dGlvbmVkIGlzc3Vlcy4gU28gdGhlIGRldGVjdGlvbiBhbmQNCj4gPiB0ZW1wb3JhcnkgcmVsZWFz
ZSBmb3Igd3JpdGUgYXR0ZW1wdHMgb24gbW1hcF9sb2NrIGluIHNtYXBzX3JvbGx1cCBpcyBzdGls
bA0KPiA+IG5lY2Vzc2FyeS4NCj4gDQo+IEkgZG8gbm90IG1pbmQgZXh0ZW5kaW5nIHRoZSBtbWFw
IGxvY2sgQVBJIGFzIG5lZWRlZC4gSG93ZXZlciwgaW4gdGhlDQo+IHBhc3QgSSBoYXZlIHRyaWVk
IGFkZGluZyByd3NlbV9pc19jb250ZW5kZWQgdG8gbWxvY2soKSwgYW5kIGxhdGVyIHRvDQo+IG1t
X3BvcHVsYXRlKCkgcGF0aHMsIGFuZCBJSVJDIGdvdHRlbiBwdXNoYmFjayBvbiBpdCBib3RoIHRp
bWVzLiBJDQo+IGRvbid0IGZlZWwgc3Ryb25nbHkgb24gdGhpcywgYnV0IHdvdWxkIHByZWZlciBp
ZiBzb21lb25lIGVsc2UgYXBwcm92ZWQNCj4gdGhlIHJ3c2VtX2lzX2NvbnRlbmRlZCgpIHVzZSBj
YXNlLg0KPiANCkhpIE1pY2hlbCwNCg0KVGhhbmsgeW91IGZvciB5b3VyIGtpbmQgZmVlZGJhY2su
DQoNCkluIG15IG9waW5pb24sIHRoZSBkaWZmZXJlbmNlIGJldHdlZW4gdGhlIGNhc2UgaW4gc21h
cHNfcm9sbHVwIGFuZCB0aGUNCm9uZSBpbiB5b3VyIGV4YW1wbGUgaXMgdGhhdCwgZm9yIHRoZSBm
b3JtZXIsIHRoZSBpbnRlcmZlcmVuY2UgY29tZXMgZnJvbQ0KdGhlIG91dHNpZGUgb2YgdGhlIGFm
ZmVjdGVkIHByb2Nlc3MsIGZvciB0aGUgbGF0dGVyLCBpdCBkb2Vzbid0Lg0KDQpJbiBvdGhlciB3
b3JkcywgYW55b25lIG1heSB1c2Ugc21hcHNfcm9sbHVwIHRvIHByb2JlIHRoZSBhZmZlY3RlZA0K
cHJvY2VzcyB3aXRob3V0IHRoZSBpbmZvcm1hdGlvbiBhYm91dCB3aGF0IHN0ZXAgdGhlIGFmZmVj
dGVkIG9uZSBpcw0KZXhlY3V0aW5nLg0KDQo+IENvdXBsZSByZWxhdGVkIHF1ZXN0aW9ucywgaG93
IG1hbnkgVk1BcyBhcmUgd2UgbG9va2luZyBhdCBoZXJlID8gV291bGQNCj4gbmVlZF9yZXNjaGVk
KCkgYmUgd29ya2FibGUgdG9vID8NCj4gDQpJdCBkZXBlbmRzIG9uIHRoZSB0eXBlcyBvZiBhcHBs
aWNhdGlvbnMuIFRoZSBudW1iZXIgb2YgVk1BcyB3ZSBhcmUNCmxvb2tpbmcgYXQgaXMgYXJvdW5k
IDMwMDAgfiA0MDAwLg0KDQpBcyBmYXIgYXMgSSBrbm93LCBuZWVkX3Jlc2NoZWQoKSBpcyB1c2Vk
IGJ5IHRoZSBjYWxsZXIgdG8gY2hlY2sgaWYgaXQNCnNob3VsZCByZWxlYXNlIHRoZSBDUFUgcmVz
b3VyY2UgZm9yIG90aGVycy4gQnV0IGluIHRoZSBjYXNlIG9mDQpzbWFwc19yb2xsdXAsIHRoZSBh
ZmZlY3RlZCBwcm9jZXNzIGlzIGNvbnRlbmRlZCBvbiB0aGUgbW1hcF9sb2NrLCBub3QNCndhaXRp
bmcgZm9yIENQVS4gU28gbmVlZF9yZXNjaGVkKCkgbWF5IG5vdCBiZSB3b3JrYWJsZSBoZXJlLg0K
DQpUaGFua3MgYWdhaW4gZm9yIHlvdXIgY29tbWVudC4NCkNoaW53ZW4NCg0K


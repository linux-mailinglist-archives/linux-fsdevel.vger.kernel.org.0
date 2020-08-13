Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A8A6243263
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Aug 2020 04:14:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726651AbgHMCNu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 Aug 2020 22:13:50 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:45595 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726542AbgHMCNu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 Aug 2020 22:13:50 -0400
X-UUID: 7c76ac8912184f7885d5e4e7355baed2-20200813
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=jA4iiVfkVcOmS+pCKVmT4iYfEjD2gJ9VLToSMN7vEIU=;
        b=VInAcgOdMhD13kgI3gk8WsVHX3GJYWmk9fooeB5+xpF1IbM70N5Oo4TpIaxQS5bj/2A32AwggZj8/Be2NRVa6WW675gcMMJXNltBQSVE2vPT0nP2rM4YuCLxJ7USAdMm9taPl+riye9K9WwEnJ4h/nQ3VNsdvAi+NJezlj53B3A=;
X-UUID: 7c76ac8912184f7885d5e4e7355baed2-20200813
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw02.mediatek.com
        (envelope-from <chinwen.chang@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1729284846; Thu, 13 Aug 2020 10:13:46 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs01n1.mediatek.inc (172.21.101.68) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 13 Aug 2020 10:13:45 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 13 Aug 2020 10:13:45 +0800
From:   Chinwen Chang <chinwen.chang@mediatek.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        Michel Lespinasse <walken@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        Davidlohr Bueso <dbueso@suse.de>,
        Chinwen Chang <chinwen.chang@mediatek.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Steven Price <steven.price@arm.com>,
        Song Liu <songliubraving@fb.com>,
        Jimmy Assarsson <jimmyassarsson@gmail.com>,
        Huang Ying <ying.huang@intel.com>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-fsdevel@vger.kernel.org>, <wsd_upstream@mediatek.com>
Subject: [PATCH v2 2/2] mm: proc: smaps_rollup: do not stall write attempts on mmap_lock
Date:   Thu, 13 Aug 2020 10:13:30 +0800
Message-ID: <1597284810-17454-3-git-send-email-chinwen.chang@mediatek.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1597284810-17454-1-git-send-email-chinwen.chang@mediatek.com>
References: <1597284810-17454-1-git-send-email-chinwen.chang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

c21hcHNfcm9sbHVwIHdpbGwgdHJ5IHRvIGdyYWIgbW1hcF9sb2NrIGFuZCBnbyB0aHJvdWdoIHRo
ZSB3aG9sZSB2bWENCmxpc3QgdW50aWwgaXQgZmluaXNoZXMgdGhlIGl0ZXJhdGluZy4gV2hlbiBl
bmNvdW50ZXJpbmcgbGFyZ2UgcHJvY2Vzc2VzLA0KdGhlIG1tYXBfbG9jayB3aWxsIGJlIGhlbGQg
Zm9yIGEgbG9uZ2VyIHRpbWUsIHdoaWNoIG1heSBibG9jayBvdGhlcg0Kd3JpdGUgcmVxdWVzdHMg
bGlrZSBtbWFwIGFuZCBtdW5tYXAgZnJvbSBwcm9ncmVzc2luZyBzbW9vdGhseS4NCg0KVGhlcmUg
YXJlIHVwY29taW5nIG1tYXBfbG9jayBvcHRpbWl6YXRpb25zIGxpa2UgcmFuZ2UtYmFzZWQgbG9j
a3MsIGJ1dA0KdGhlIGxvY2sgYXBwbGllZCB0byBzbWFwc19yb2xsdXAgd291bGQgYmUgdGhlIGNv
YXJzZSB0eXBlLCB3aGljaCBkb2Vzbid0DQphdm9pZCB0aGUgb2NjdXJyZW5jZSBvZiB1bnBsZWFz
YW50IGNvbnRlbnRpb24uDQoNClRvIHNvbHZlIGFmb3JlbWVudGlvbmVkIGlzc3VlLCB3ZSBhZGQg
YSBjaGVjayB3aGljaCBkZXRlY3RzIHdoZXRoZXINCmFueW9uZSB3YW50cyB0byBncmFiIG1tYXBf
bG9jayBmb3Igd3JpdGUgYXR0ZW1wdHMuDQoNCkNoYW5nZSBzaW5jZSB2MToNCi0gSWYgY3VycmVu
dCBWTUEgaXMgZnJlZWQgYWZ0ZXIgZHJvcHBpbmcgdGhlIGxvY2ssIGl0IHdpbGwgcmV0dXJuDQot
IGluY29tcGxldGUgcmVzdWx0LiBUbyBmaXggdGhpcyBpc3N1ZSwgcmVmaW5lIHRoZSBjb2RlIGZs
b3cgYXMNCi0gc3VnZ2VzdGVkIGJ5IFN0ZXZlLiBbMV0NCg0KWzFdIGh0dHBzOi8vbG9yZS5rZXJu
ZWwub3JnL2xrbWwvYmY0MDY3NmUtYjE0Yi00NGNkLTc1Y2UtNDE5YzcwMTk0NzgzQGFybS5jb20v
DQoNClNpZ25lZC1vZmYtYnk6IENoaW53ZW4gQ2hhbmcgPGNoaW53ZW4uY2hhbmdAbWVkaWF0ZWsu
Y29tPg0KLS0tDQogZnMvcHJvYy90YXNrX21tdS5jIHwgNTYgKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKystDQogMSBmaWxlIGNoYW5nZWQsIDU1IGlu
c2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCg0KZGlmZiAtLWdpdCBhL2ZzL3Byb2MvdGFza19t
bXUuYyBiL2ZzL3Byb2MvdGFza19tbXUuYw0KaW5kZXggZGJkYTQ0OS4uMjNiM2E0NDcgMTAwNjQ0
DQotLS0gYS9mcy9wcm9jL3Rhc2tfbW11LmMNCisrKyBiL2ZzL3Byb2MvdGFza19tbXUuYw0KQEAg
LTg1Myw5ICs4NTMsNjMgQEAgc3RhdGljIGludCBzaG93X3NtYXBzX3JvbGx1cChzdHJ1Y3Qgc2Vx
X2ZpbGUgKm0sIHZvaWQgKnYpDQogDQogCWhvbGRfdGFza19tZW1wb2xpY3kocHJpdik7DQogDQot
CWZvciAodm1hID0gcHJpdi0+bW0tPm1tYXA7IHZtYTsgdm1hID0gdm1hLT52bV9uZXh0KSB7DQor
CWZvciAodm1hID0gcHJpdi0+bW0tPm1tYXA7IHZtYTspIHsNCiAJCXNtYXBfZ2F0aGVyX3N0YXRz
KHZtYSwgJm1zcyk7DQogCQlsYXN0X3ZtYV9lbmQgPSB2bWEtPnZtX2VuZDsNCisNCisJCS8qDQor
CQkgKiBSZWxlYXNlIG1tYXBfbG9jayB0ZW1wb3JhcmlseSBpZiBzb21lb25lIHdhbnRzIHRvDQor
CQkgKiBhY2Nlc3MgaXQgZm9yIHdyaXRlIHJlcXVlc3QuDQorCQkgKi8NCisJCWlmIChtbWFwX2xv
Y2tfaXNfY29udGVuZGVkKG1tKSkgew0KKwkJCW1tYXBfcmVhZF91bmxvY2sobW0pOw0KKwkJCXJl
dCA9IG1tYXBfcmVhZF9sb2NrX2tpbGxhYmxlKG1tKTsNCisJCQlpZiAocmV0KSB7DQorCQkJCXJl
bGVhc2VfdGFza19tZW1wb2xpY3kocHJpdik7DQorCQkJCWdvdG8gb3V0X3B1dF9tbTsNCisJCQl9
DQorDQorCQkJLyoNCisJCQkgKiBBZnRlciBkcm9wcGluZyB0aGUgbG9jaywgdGhlcmUgYXJlIHRo
cmVlIGNhc2VzIHRvDQorCQkJICogY29uc2lkZXIuIFNlZSB0aGUgZm9sbG93aW5nIGV4YW1wbGUg
Zm9yIGV4cGxhbmF0aW9uLg0KKwkJCSAqDQorCQkJICogICArLS0tLS0tKy0tLS0tLSstLS0tLS0t
LS0tLSsNCisJCQkgKiAgIHwgVk1BMSB8IFZNQTIgfCBWTUEzICAgICAgfA0KKwkJCSAqICAgKy0t
LS0tLSstLS0tLS0rLS0tLS0tLS0tLS0rDQorCQkJICogICB8ICAgICAgfCAgICAgIHwgICAgICAg
ICAgIHwNCisJCQkgKiAgNGsgICAgIDhrICAgICAxNmsgICAgICAgICA0MDBrDQorCQkJICoNCisJ
CQkgKiBTdXBwb3NlIHdlIGRyb3AgdGhlIGxvY2sgYWZ0ZXIgcmVhZGluZyBWTUEyIGR1ZSB0bw0K
KwkJCSAqIGNvbnRlbnRpb24sIHRoZW4gd2UgZ2V0Og0KKwkJCSAqDQorCQkJICoJbGFzdF92bWFf
ZW5kID0gMTZrDQorCQkJICoNCisJCQkgKiAxKSBWTUEyIGlzIGZyZWVkLCBidXQgVk1BMyBleGlz
dHM6DQorCQkJICoNCisJCQkgKiAgICBmaW5kX3ZtYShtbSwgMTZrIC0gMSkgd2lsbCByZXR1cm4g
Vk1BMy4NCisJCQkgKiAgICBJbiB0aGlzIGNhc2UsIGp1c3QgY29udGludWUgZnJvbSBWTUEzLg0K
KwkJCSAqDQorCQkJICogMikgVk1BMiBzdGlsbCBleGlzdHM6DQorCQkJICoNCisJCQkgKiAgICBm
aW5kX3ZtYShtbSwgMTZrIC0gMSkgd2lsbCByZXR1cm4gVk1BMi4NCisJCQkgKiAgICBJdGVyYXRl
IHRoZSBsb29wIGxpa2UgdGhlIG9yaWdpbmFsIG9uZS4NCisJCQkgKg0KKwkJCSAqIDMpIE5vIG1v
cmUgVk1BcyBjYW4gYmUgZm91bmQ6DQorCQkJICoNCisJCQkgKiAgICBmaW5kX3ZtYShtbSwgMTZr
IC0gMSkgd2lsbCByZXR1cm4gTlVMTC4NCisJCQkgKiAgICBObyBtb3JlIHRoaW5ncyB0byBkbywg
anVzdCBicmVhay4NCisJCQkgKi8NCisJCQl2bWEgPSBmaW5kX3ZtYShtbSwgbGFzdF92bWFfZW5k
IC0gMSk7DQorCQkJLyogQ2FzZSAzIGFib3ZlICovDQorCQkJaWYgKCF2bWEpDQorCQkJCWJyZWFr
Ow0KKw0KKwkJCS8qIENhc2UgMSBhYm92ZSAqLw0KKwkJCWlmICh2bWEtPnZtX3N0YXJ0ID49IGxh
c3Rfdm1hX2VuZCkNCisJCQkJY29udGludWU7DQorCQl9DQorCQkvKiBDYXNlIDIgYWJvdmUgKi8N
CisJCXZtYSA9IHZtYS0+dm1fbmV4dDsNCiAJfQ0KIA0KIAlzaG93X3ZtYV9oZWFkZXJfcHJlZml4
KG0sIHByaXYtPm1tLT5tbWFwLT52bV9zdGFydCwNCi0tIA0KMS45LjENCg==


Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA3DA247C0E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Aug 2020 03:59:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726596AbgHRB7A (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Aug 2020 21:59:00 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:28545 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726328AbgHRB66 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Aug 2020 21:58:58 -0400
X-UUID: 6b5832a878d34e90b043e84e815e5724-20200818
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=plyfflpHNcigH9ZupdiMtUFHhuGRVQowp/bNsUh9Leg=;
        b=pisXs58tvh5LKyQKb0MR76S95bxhkgJMZj2fwPomgQnzh2leDvfWhwYQ/Bdt9v0kApgAVuCinaHIBRWy1GBSiAYc5b70NDBx92xJhUjK5oq/PIZ3euAeVnTJVcCK6WtjvLXSMW7g3HvvEU/SM9Gn0YgBiaUnNzEurAykZiHqtuU=;
X-UUID: 6b5832a878d34e90b043e84e815e5724-20200818
Received: from mtkcas08.mediatek.inc [(172.21.101.126)] by mailgw01.mediatek.com
        (envelope-from <chinwen.chang@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 5852831; Tue, 18 Aug 2020 09:58:53 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs02n1.mediatek.inc (172.21.101.77) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 18 Aug 2020 09:58:45 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 18 Aug 2020 09:58:45 +0800
From:   Chinwen Chang <chinwen.chang@mediatek.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        Michel Lespinasse <walken@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Vlastimil Babka" <vbabka@suse.cz>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        "Davidlohr Bueso" <dbueso@suse.de>,
        Chinwen Chang <chinwen.chang@mediatek.com>,
        "Alexey Dobriyan" <adobriyan@gmail.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Steven Price <steven.price@arm.com>,
        Song Liu <songliubraving@fb.com>,
        Jimmy Assarsson <jimmyassarsson@gmail.com>,
        Huang Ying <ying.huang@intel.com>,
        Daniel Kiss <daniel.kiss@arm.com>,
        Laurent Dufour <ldufour@linux.ibm.com>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-fsdevel@vger.kernel.org>, <wsd_upstream@mediatek.com>
Subject: [PATCH v4 3/3] mm: proc: smaps_rollup: do not stall write attempts on mmap_lock
Date:   Tue, 18 Aug 2020 09:58:18 +0800
Message-ID: <1597715898-3854-4-git-send-email-chinwen.chang@mediatek.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1597715898-3854-1-git-send-email-chinwen.chang@mediatek.com>
References: <1597715898-3854-1-git-send-email-chinwen.chang@mediatek.com>
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
b3cgYXMNCi0gc3VnZ2VzdGVkIGJ5IFN0ZXZlLiBbMV0NCg0KQ2hhbmdlIHNpbmNlIHYyOg0KLSBX
aGVuIGdldHRpbmcgYmFjayB0aGUgbW1hcCBsb2NrLCB0aGUgYWRkcmVzcyB3aGVyZSB5b3Ugc3Rv
cHBlZCBsYXN0DQotIHRpbWUgY291bGQgbm93IGJlIGluIHRoZSBtaWRkbGUgb2YgYSB2bWEuIEFk
ZCBvbmUgbW9yZSBjaGVjayB0byBoYW5kbGUNCi0gdGhpcyBjYXNlIGFzIHN1Z2dlc3RlZCBieSBN
aWNoZWwuIFsyXQ0KDQpDaGFuZ2Ugc2luY2UgdjM6DQotIGxhc3Rfc3RvcHBlZCBpcyBlYXNpbHkg
Y29uZnVzZWQgd2l0aCBsYXN0X3ZtYV9lbmQuIFJlcGxhY2UgaXQgd2l0aA0KLSBhIGRpcmVjdCBj
YWxsIHRvIHNtYXBfZ2F0aGVyX3N0YXRzKHZtYSwgJm1zcywgbGFzdF92bWFfZW5kKSBhcw0KLSBz
dWdnZXN0ZWQgYnkgU3RldmUuIFszXQ0KDQpbMV0gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGtt
bC9iZjQwNjc2ZS1iMTRiLTQ0Y2QtNzVjZS00MTljNzAxOTQ3ODNAYXJtLmNvbS8NClsyXSBodHRw
czovL2xvcmUua2VybmVsLm9yZy9sa21sL0NBTk42ODlGdENzQzcxY2pBanMwR1BzcE9oZ29fSFJq
K2RpV3NvVTF3cjk4WVBrdGdXZ0BtYWlsLmdtYWlsLmNvbS8NClszXSBodHRwczovL2xvcmUua2Vy
bmVsLm9yZy9sa21sL2RiMGQ0MGUyLTcyZjMtMDlkNS1jMTYyLTljNDkyMThmMTI4ZkBhcm0uY29t
Lw0KDQpTaWduZWQtb2ZmLWJ5OiBDaGlud2VuIENoYW5nIDxjaGlud2VuLmNoYW5nQG1lZGlhdGVr
LmNvbT4NCkNDOiBTdGV2ZW4gUHJpY2UgPHN0ZXZlbi5wcmljZUBhcm0uY29tPg0KQ0M6IE1pY2hl
bCBMZXNwaW5hc3NlIDx3YWxrZW5AZ29vZ2xlLmNvbT4NCi0tLQ0KIGZzL3Byb2MvdGFza19tbXUu
YyB8IDY2ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrLQ0KIDEgZmlsZSBjaGFuZ2VkLCA2NSBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQoN
CmRpZmYgLS1naXQgYS9mcy9wcm9jL3Rhc2tfbW11LmMgYi9mcy9wcm9jL3Rhc2tfbW11LmMNCmlu
ZGV4IDc2ZTYyM2EuLjFhODA2MjQgMTAwNjQ0DQotLS0gYS9mcy9wcm9jL3Rhc2tfbW11LmMNCisr
KyBiL2ZzL3Byb2MvdGFza19tbXUuYw0KQEAgLTg2Nyw5ICs4NjcsNzMgQEAgc3RhdGljIGludCBz
aG93X3NtYXBzX3JvbGx1cChzdHJ1Y3Qgc2VxX2ZpbGUgKm0sIHZvaWQgKnYpDQogDQogCWhvbGRf
dGFza19tZW1wb2xpY3kocHJpdik7DQogDQotCWZvciAodm1hID0gcHJpdi0+bW0tPm1tYXA7IHZt
YTsgdm1hID0gdm1hLT52bV9uZXh0KSB7DQorCWZvciAodm1hID0gcHJpdi0+bW0tPm1tYXA7IHZt
YTspIHsNCiAJCXNtYXBfZ2F0aGVyX3N0YXRzKHZtYSwgJm1zcywgMCk7DQogCQlsYXN0X3ZtYV9l
bmQgPSB2bWEtPnZtX2VuZDsNCisNCisJCS8qDQorCQkgKiBSZWxlYXNlIG1tYXBfbG9jayB0ZW1w
b3JhcmlseSBpZiBzb21lb25lIHdhbnRzIHRvDQorCQkgKiBhY2Nlc3MgaXQgZm9yIHdyaXRlIHJl
cXVlc3QuDQorCQkgKi8NCisJCWlmIChtbWFwX2xvY2tfaXNfY29udGVuZGVkKG1tKSkgew0KKwkJ
CW1tYXBfcmVhZF91bmxvY2sobW0pOw0KKwkJCXJldCA9IG1tYXBfcmVhZF9sb2NrX2tpbGxhYmxl
KG1tKTsNCisJCQlpZiAocmV0KSB7DQorCQkJCXJlbGVhc2VfdGFza19tZW1wb2xpY3kocHJpdik7
DQorCQkJCWdvdG8gb3V0X3B1dF9tbTsNCisJCQl9DQorDQorCQkJLyoNCisJCQkgKiBBZnRlciBk
cm9wcGluZyB0aGUgbG9jaywgdGhlcmUgYXJlIGZvdXIgY2FzZXMgdG8NCisJCQkgKiBjb25zaWRl
ci4gU2VlIHRoZSBmb2xsb3dpbmcgZXhhbXBsZSBmb3IgZXhwbGFuYXRpb24uDQorCQkJICoNCisJ
CQkgKiAgICstLS0tLS0rLS0tLS0tKy0tLS0tLS0tLS0tKw0KKwkJCSAqICAgfCBWTUExIHwgVk1B
MiB8IFZNQTMgICAgICB8DQorCQkJICogICArLS0tLS0tKy0tLS0tLSstLS0tLS0tLS0tLSsNCisJ
CQkgKiAgIHwgICAgICB8ICAgICAgfCAgICAgICAgICAgfA0KKwkJCSAqICA0ayAgICAgOGsgICAg
IDE2ayAgICAgICAgIDQwMGsNCisJCQkgKg0KKwkJCSAqIFN1cHBvc2Ugd2UgZHJvcCB0aGUgbG9j
ayBhZnRlciByZWFkaW5nIFZNQTIgZHVlIHRvDQorCQkJICogY29udGVudGlvbiwgdGhlbiB3ZSBn
ZXQ6DQorCQkJICoNCisJCQkgKglsYXN0X3ZtYV9lbmQgPSAxNmsNCisJCQkgKg0KKwkJCSAqIDEp
IFZNQTIgaXMgZnJlZWQsIGJ1dCBWTUEzIGV4aXN0czoNCisJCQkgKg0KKwkJCSAqICAgIGZpbmRf
dm1hKG1tLCAxNmsgLSAxKSB3aWxsIHJldHVybiBWTUEzLg0KKwkJCSAqICAgIEluIHRoaXMgY2Fz
ZSwganVzdCBjb250aW51ZSBmcm9tIFZNQTMuDQorCQkJICoNCisJCQkgKiAyKSBWTUEyIHN0aWxs
IGV4aXN0czoNCisJCQkgKg0KKwkJCSAqICAgIGZpbmRfdm1hKG1tLCAxNmsgLSAxKSB3aWxsIHJl
dHVybiBWTUEyLg0KKwkJCSAqICAgIEl0ZXJhdGUgdGhlIGxvb3AgbGlrZSB0aGUgb3JpZ2luYWwg
b25lLg0KKwkJCSAqDQorCQkJICogMykgTm8gbW9yZSBWTUFzIGNhbiBiZSBmb3VuZDoNCisJCQkg
Kg0KKwkJCSAqICAgIGZpbmRfdm1hKG1tLCAxNmsgLSAxKSB3aWxsIHJldHVybiBOVUxMLg0KKwkJ
CSAqICAgIE5vIG1vcmUgdGhpbmdzIHRvIGRvLCBqdXN0IGJyZWFrLg0KKwkJCSAqDQorCQkJICog
NCkgKGxhc3Rfdm1hX2VuZCAtIDEpIGlzIHRoZSBtaWRkbGUgb2YgYSB2bWEgKFZNQScpOg0KKwkJ
CSAqDQorCQkJICogICAgZmluZF92bWEobW0sIDE2ayAtIDEpIHdpbGwgcmV0dXJuIFZNQScgd2hv
c2UgcmFuZ2UNCisJCQkgKiAgICBjb250YWlucyBsYXN0X3ZtYV9lbmQuDQorCQkJICogICAgSXRl
cmF0ZSBWTUEnIGZyb20gbGFzdF92bWFfZW5kLg0KKwkJCSAqLw0KKwkJCXZtYSA9IGZpbmRfdm1h
KG1tLCBsYXN0X3ZtYV9lbmQgLSAxKTsNCisJCQkvKiBDYXNlIDMgYWJvdmUgKi8NCisJCQlpZiAo
IXZtYSkNCisJCQkJYnJlYWs7DQorDQorCQkJLyogQ2FzZSAxIGFib3ZlICovDQorCQkJaWYgKHZt
YS0+dm1fc3RhcnQgPj0gbGFzdF92bWFfZW5kKQ0KKwkJCQljb250aW51ZTsNCisNCisJCQkvKiBD
YXNlIDQgYWJvdmUgKi8NCisJCQlpZiAodm1hLT52bV9lbmQgPiBsYXN0X3ZtYV9lbmQpDQorCQkJ
CXNtYXBfZ2F0aGVyX3N0YXRzKHZtYSwgJm1zcywgbGFzdF92bWFfZW5kKTsNCisJCX0NCisJCS8q
IENhc2UgMiBhYm92ZSAqLw0KKwkJdm1hID0gdm1hLT52bV9uZXh0Ow0KIAl9DQogDQogCXNob3df
dm1hX2hlYWRlcl9wcmVmaXgobSwgcHJpdi0+bW0tPm1tYXAtPnZtX3N0YXJ0LA0KLS0gDQoxLjku
MQ0K


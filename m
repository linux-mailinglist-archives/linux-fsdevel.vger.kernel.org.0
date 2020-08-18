Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14AEE247C09
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Aug 2020 03:59:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726328AbgHRB7C (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Aug 2020 21:59:02 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:31418 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726303AbgHRB6v (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Aug 2020 21:58:51 -0400
X-UUID: e0b7bdb4388c4b0a8a6c130e10abe582-20200818
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=ujc7Lbua+IslYXDihEh6fsVR2uDX9I8FrwlUNgCM1+Y=;
        b=J2g7J+HfrSa7nObqgPUBVAKL7r5jjMul/UAJ0zKwkSrl+mHIiWIqDMoeMQnKGOkxRse8dJm7TSSfVYHtGdCS3mJ9bn82qFA2Fos9djJm9FxHnqTMhIi0wQ8vhwh5W5WPNgAgBiSFI8EP2dDtHquWxH1K5iuXedx7RiwozkjBKWQ=;
X-UUID: e0b7bdb4388c4b0a8a6c130e10abe582-20200818
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw02.mediatek.com
        (envelope-from <chinwen.chang@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 825494537; Tue, 18 Aug 2020 09:58:46 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs02n2.mediatek.inc (172.21.101.101) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 18 Aug 2020 09:58:44 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 18 Aug 2020 09:58:44 +0800
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
        Huang Ying <ying.huang@intel.com>,
        Daniel Kiss <daniel.kiss@arm.com>,
        Laurent Dufour <ldufour@linux.ibm.com>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-fsdevel@vger.kernel.org>, <wsd_upstream@mediatek.com>
Subject: [PATCH v4 2/3] mm: smaps*: extend smap_gather_stats to support specified beginning
Date:   Tue, 18 Aug 2020 09:58:17 +0800
Message-ID: <1597715898-3854-3-git-send-email-chinwen.chang@mediatek.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1597715898-3854-1-git-send-email-chinwen.chang@mediatek.com>
References: <1597715898-3854-1-git-send-email-chinwen.chang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 9DCA33C3D616333C44B385622478D55A61FB68BA92421FE14445A37B4A995B9C2000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

RXh0ZW5kIHNtYXBfZ2F0aGVyX3N0YXRzIHRvIHN1cHBvcnQgaW5kaWNhdGVkIGJlZ2lubmluZyBh
ZGRyZXNzIGF0DQp3aGljaCBpdCBzaG91bGQgc3RhcnQgZ2F0aGVyaW5nLiBUbyBhY2hpZXZlIHRo
ZSBnb2FsLCB3ZSBhZGQgYSBuZXcNCnBhcmFtZXRlciBAc3RhcnQgYXNzaWduZWQgYnkgdGhlIGNh
bGxlciBhbmQgdHJ5IHRvIHJlZmFjdG9yIGl0IGZvcg0Kc2ltcGxpY2l0eS4NCg0KSWYgQHN0YXJ0
IGlzIDAsIGl0IHdpbGwgdXNlIHRoZSByYW5nZSBvZiBAdm1hIGZvciBnYXRoZXJpbmcuDQoNCkNo
YW5nZSBzaW5jZSB2MjoNCi0gVGhpcyBpcyBhIG5ldyBjaGFuZ2UgdG8gbWFrZSB0aGUgcmV0cnkg
YmVoYXZpb3Igb2Ygc21hcHNfcm9sbHVwDQotIG1vcmUgY29tcGxldGUgYXMgc3VnZ2VzdGVkIGJ5
IE1pY2hlbCBbMV0NCg0KWzFdIGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xrbWwvQ0FOTjY4OUZ0
Q3NDNzFjakFqczBHUHNwT2hnb19IUmorZGlXc29VMXdyOThZUGt0Z1dnQG1haWwuZ21haWwuY29t
Lw0KDQpTaWduZWQtb2ZmLWJ5OiBDaGlud2VuIENoYW5nIDxjaGlud2VuLmNoYW5nQG1lZGlhdGVr
LmNvbT4NCkNDOiBNaWNoZWwgTGVzcGluYXNzZSA8d2Fsa2VuQGdvb2dsZS5jb20+DQpSZXZpZXdl
ZC1ieTogU3RldmVuIFByaWNlIDxzdGV2ZW4ucHJpY2VAYXJtLmNvbT4NCi0tLQ0KIGZzL3Byb2Mv
dGFza19tbXUuYyB8IDMwICsrKysrKysrKysrKysrKysrKysrKystLS0tLS0tLQ0KIDEgZmlsZSBj
aGFuZ2VkLCAyMiBpbnNlcnRpb25zKCspLCA4IGRlbGV0aW9ucygtKQ0KDQpkaWZmIC0tZ2l0IGEv
ZnMvcHJvYy90YXNrX21tdS5jIGIvZnMvcHJvYy90YXNrX21tdS5jDQppbmRleCBkYmRhNDQ5Li43
NmU2MjNhIDEwMDY0NA0KLS0tIGEvZnMvcHJvYy90YXNrX21tdS5jDQorKysgYi9mcy9wcm9jL3Rh
c2tfbW11LmMNCkBAIC03MjMsOSArNzIzLDIxIEBAIHN0YXRpYyBpbnQgc21hcHNfaHVnZXRsYl9y
YW5nZShwdGVfdCAqcHRlLCB1bnNpZ25lZCBsb25nIGhtYXNrLA0KIAkucHRlX2hvbGUJCT0gc21h
cHNfcHRlX2hvbGUsDQogfTsNCiANCisvKg0KKyAqIEdhdGhlciBtZW0gc3RhdHMgZnJvbSBAdm1h
IHdpdGggdGhlIGluZGljYXRlZCBiZWdpbm5pbmcNCisgKiBhZGRyZXNzIEBzdGFydCwgYW5kIGtl
ZXAgdGhlbSBpbiBAbXNzLg0KKyAqDQorICogVXNlIHZtX3N0YXJ0IG9mIEB2bWEgYXMgdGhlIGJl
Z2lubmluZyBhZGRyZXNzIGlmIEBzdGFydCBpcyAwLg0KKyAqLw0KIHN0YXRpYyB2b2lkIHNtYXBf
Z2F0aGVyX3N0YXRzKHN0cnVjdCB2bV9hcmVhX3N0cnVjdCAqdm1hLA0KLQkJCSAgICAgc3RydWN0
IG1lbV9zaXplX3N0YXRzICptc3MpDQorCQlzdHJ1Y3QgbWVtX3NpemVfc3RhdHMgKm1zcywgdW5z
aWduZWQgbG9uZyBzdGFydCkNCiB7DQorCWNvbnN0IHN0cnVjdCBtbV93YWxrX29wcyAqb3BzID0g
JnNtYXBzX3dhbGtfb3BzOw0KKw0KKwkvKiBJbnZhbGlkIHN0YXJ0ICovDQorCWlmIChzdGFydCA+
PSB2bWEtPnZtX2VuZCkNCisJCXJldHVybjsNCisNCiAjaWZkZWYgQ09ORklHX1NITUVNDQogCS8q
IEluIGNhc2Ugb2Ygc21hcHNfcm9sbHVwLCByZXNldCB0aGUgdmFsdWUgZnJvbSBwcmV2aW91cyB2
bWEgKi8NCiAJbXNzLT5jaGVja19zaG1lbV9zd2FwID0gZmFsc2U7DQpAQCAtNzQyLDE4ICs3NTQs
MjAgQEAgc3RhdGljIHZvaWQgc21hcF9nYXRoZXJfc3RhdHMoc3RydWN0IHZtX2FyZWFfc3RydWN0
ICp2bWEsDQogCQkgKi8NCiAJCXVuc2lnbmVkIGxvbmcgc2htZW1fc3dhcHBlZCA9IHNobWVtX3N3
YXBfdXNhZ2Uodm1hKTsNCiANCi0JCWlmICghc2htZW1fc3dhcHBlZCB8fCAodm1hLT52bV9mbGFn
cyAmIFZNX1NIQVJFRCkgfHwNCi0JCQkJCSEodm1hLT52bV9mbGFncyAmIFZNX1dSSVRFKSkgew0K
KwkJaWYgKCFzdGFydCAmJiAoIXNobWVtX3N3YXBwZWQgfHwgKHZtYS0+dm1fZmxhZ3MgJiBWTV9T
SEFSRUQpIHx8DQorCQkJCQkhKHZtYS0+dm1fZmxhZ3MgJiBWTV9XUklURSkpKSB7DQogCQkJbXNz
LT5zd2FwICs9IHNobWVtX3N3YXBwZWQ7DQogCQl9IGVsc2Ugew0KIAkJCW1zcy0+Y2hlY2tfc2ht
ZW1fc3dhcCA9IHRydWU7DQotCQkJd2Fsa19wYWdlX3ZtYSh2bWEsICZzbWFwc19zaG1lbV93YWxr
X29wcywgbXNzKTsNCi0JCQlyZXR1cm47DQorCQkJb3BzID0gJnNtYXBzX3NobWVtX3dhbGtfb3Bz
Ow0KIAkJfQ0KIAl9DQogI2VuZGlmDQogCS8qIG1tYXBfbG9jayBpcyBoZWxkIGluIG1fc3RhcnQg
Ki8NCi0Jd2Fsa19wYWdlX3ZtYSh2bWEsICZzbWFwc193YWxrX29wcywgbXNzKTsNCisJaWYgKCFz
dGFydCkNCisJCXdhbGtfcGFnZV92bWEodm1hLCBvcHMsIG1zcyk7DQorCWVsc2UNCisJCXdhbGtf
cGFnZV9yYW5nZSh2bWEtPnZtX21tLCBzdGFydCwgdm1hLT52bV9lbmQsIG9wcywgbXNzKTsNCiB9
DQogDQogI2RlZmluZSBTRVFfUFVUX0RFQyhzdHIsIHZhbCkgXA0KQEAgLTgwNSw3ICs4MTksNyBA
QCBzdGF0aWMgaW50IHNob3dfc21hcChzdHJ1Y3Qgc2VxX2ZpbGUgKm0sIHZvaWQgKnYpDQogDQog
CW1lbXNldCgmbXNzLCAwLCBzaXplb2YobXNzKSk7DQogDQotCXNtYXBfZ2F0aGVyX3N0YXRzKHZt
YSwgJm1zcyk7DQorCXNtYXBfZ2F0aGVyX3N0YXRzKHZtYSwgJm1zcywgMCk7DQogDQogCXNob3df
bWFwX3ZtYShtLCB2bWEpOw0KIA0KQEAgLTg1NCw3ICs4NjgsNyBAQCBzdGF0aWMgaW50IHNob3df
c21hcHNfcm9sbHVwKHN0cnVjdCBzZXFfZmlsZSAqbSwgdm9pZCAqdikNCiAJaG9sZF90YXNrX21l
bXBvbGljeShwcml2KTsNCiANCiAJZm9yICh2bWEgPSBwcml2LT5tbS0+bW1hcDsgdm1hOyB2bWEg
PSB2bWEtPnZtX25leHQpIHsNCi0JCXNtYXBfZ2F0aGVyX3N0YXRzKHZtYSwgJm1zcyk7DQorCQlz
bWFwX2dhdGhlcl9zdGF0cyh2bWEsICZtc3MsIDApOw0KIAkJbGFzdF92bWFfZW5kID0gdm1hLT52
bV9lbmQ7DQogCX0NCiANCi0tIA0KMS45LjENCg==


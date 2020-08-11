Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B4A92415CD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Aug 2020 06:45:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727899AbgHKEox (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 Aug 2020 00:44:53 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:12029 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726165AbgHKEow (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 Aug 2020 00:44:52 -0400
X-UUID: 8498e0aa151c4c9f87771a6793aa654e-20200811
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=34A2MTCnp24qFDlzu8bAX0BRNrZ0NdDDcDstxdaMF/0=;
        b=lnmK+J9dagYo2xo09H9SJI7IBwCfV2Ty+fPRJ4mMGpnk31gHgswEsgJjuDq45m9Bgnki84pkqLH2CxhCKL0oUBXmOdT3wGVOTmHXm4DPD0FDMZSYfVo4V7GJcwgGGUMEkB7jr3zvW83DgGKz5W1ZJm1AIdVZpm6m+Q7l68r7h2Y=;
X-UUID: 8498e0aa151c4c9f87771a6793aa654e-20200811
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw02.mediatek.com
        (envelope-from <chinwen.chang@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 780838790; Tue, 11 Aug 2020 12:44:48 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs02n1.mediatek.inc (172.21.101.77) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 11 Aug 2020 12:44:46 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 11 Aug 2020 12:44:46 +0800
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
Subject: [PATCH 2/2] mm: proc: smaps_rollup: do not stall write attempts on mmap_lock
Date:   Tue, 11 Aug 2020 12:42:35 +0800
Message-ID: <1597120955-16495-3-git-send-email-chinwen.chang@mediatek.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1597120955-16495-1-git-send-email-chinwen.chang@mediatek.com>
References: <1597120955-16495-1-git-send-email-chinwen.chang@mediatek.com>
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
bG9jayBmb3Igd3JpdGUgYXR0ZW1wdHMuDQoNClNpZ25lZC1vZmYtYnk6IENoaW53ZW4gQ2hhbmcg
PGNoaW53ZW4uY2hhbmdAbWVkaWF0ZWsuY29tPg0KLS0tDQogZnMvcHJvYy90YXNrX21tdS5jIHwg
MjEgKysrKysrKysrKysrKysrKysrKysrDQogMSBmaWxlIGNoYW5nZWQsIDIxIGluc2VydGlvbnMo
KykNCg0KZGlmZiAtLWdpdCBhL2ZzL3Byb2MvdGFza19tbXUuYyBiL2ZzL3Byb2MvdGFza19tbXUu
Yw0KaW5kZXggZGJkYTQ0OS4uNGI1MWYyNSAxMDA2NDQNCi0tLSBhL2ZzL3Byb2MvdGFza19tbXUu
Yw0KKysrIGIvZnMvcHJvYy90YXNrX21tdS5jDQpAQCAtODU2LDYgKzg1NiwyNyBAQCBzdGF0aWMg
aW50IHNob3dfc21hcHNfcm9sbHVwKHN0cnVjdCBzZXFfZmlsZSAqbSwgdm9pZCAqdikNCiAJZm9y
ICh2bWEgPSBwcml2LT5tbS0+bW1hcDsgdm1hOyB2bWEgPSB2bWEtPnZtX25leHQpIHsNCiAJCXNt
YXBfZ2F0aGVyX3N0YXRzKHZtYSwgJm1zcyk7DQogCQlsYXN0X3ZtYV9lbmQgPSB2bWEtPnZtX2Vu
ZDsNCisNCisJCS8qDQorCQkgKiBSZWxlYXNlIG1tYXBfbG9jayB0ZW1wb3JhcmlseSBpZiBzb21l
b25lIHdhbnRzIHRvDQorCQkgKiBhY2Nlc3MgaXQgZm9yIHdyaXRlIHJlcXVlc3QuDQorCQkgKi8N
CisJCWlmIChtbWFwX2xvY2tfaXNfY29udGVuZGVkKG1tKSkgew0KKwkJCW1tYXBfcmVhZF91bmxv
Y2sobW0pOw0KKwkJCXJldCA9IG1tYXBfcmVhZF9sb2NrX2tpbGxhYmxlKG1tKTsNCisJCQlpZiAo
cmV0KSB7DQorCQkJCXJlbGVhc2VfdGFza19tZW1wb2xpY3kocHJpdik7DQorCQkJCWdvdG8gb3V0
X3B1dF9tbTsNCisJCQl9DQorDQorCQkJLyogQ2hlY2sgd2hldGhlciBjdXJyZW50IHZtYSBpcyBh
dmFpbGFibGUgKi8NCisJCQl2bWEgPSBmaW5kX3ZtYShtbSwgbGFzdF92bWFfZW5kIC0gMSk7DQor
CQkJaWYgKHZtYSAmJiB2bWEtPnZtX3N0YXJ0IDwgbGFzdF92bWFfZW5kKQ0KKwkJCQljb250aW51
ZTsNCisNCisJCQkvKiBDdXJyZW50IHZtYSBpcyBub3QgYXZhaWxhYmxlLCBqdXN0IGJyZWFrICov
DQorCQkJYnJlYWs7DQorCQl9DQogCX0NCiANCiAJc2hvd192bWFfaGVhZGVyX3ByZWZpeChtLCBw
cml2LT5tbS0+bW1hcC0+dm1fc3RhcnQsDQotLSANCjEuOS4xDQo=


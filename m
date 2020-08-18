Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D015247C0D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Aug 2020 03:59:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726633AbgHRB7B (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Aug 2020 21:59:01 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:51887 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726357AbgHRB6w (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Aug 2020 21:58:52 -0400
X-UUID: 5077dca911e7440cbd4072a0c1bf4bd1-20200818
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=Mg5uZdFFDJBYK66PxAT2X+zp5o0L419XdVPA3e+0npM=;
        b=k1VuBaskvYwEgkpsX/B8HgEUdXyfZocMjm0013OY0Wc95x9LxPiKxIzIMI7T/mCQhwh68pkCL3vU5lEzjck9YSKlZt6G5VQt9vCb3IKg19rH/GkhxrILRhBbaySFtrHTAncHo5UaSWV7aiNgNzOo48OI1mu152ZxWXxntNM0smA=;
X-UUID: 5077dca911e7440cbd4072a0c1bf4bd1-20200818
Received: from mtkcas08.mediatek.inc [(172.21.101.126)] by mailgw01.mediatek.com
        (envelope-from <chinwen.chang@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 731042030; Tue, 18 Aug 2020 09:58:48 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs02n1.mediatek.inc (172.21.101.77) with Microsoft SMTP Server (TLS) id
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
Subject: [PATCH v4 1/3] mmap locking API: add mmap_lock_is_contended()
Date:   Tue, 18 Aug 2020 09:58:16 +0800
Message-ID: <1597715898-3854-2-git-send-email-chinwen.chang@mediatek.com>
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

QWRkIG5ldyBBUEkgdG8gcXVlcnkgaWYgc29tZW9uZSB3YW50cyB0byBhY3F1aXJlIG1tYXBfbG9j
aw0KZm9yIHdyaXRlIGF0dGVtcHRzLg0KDQpVc2luZyB0aGlzIGluc3RlYWQgb2YgcndzZW1faXNf
Y29udGVuZGVkIG1ha2VzIGl0IG1vcmUgdG9sZXJhbnQNCm9mIGZ1dHVyZSBjaGFuZ2VzIHRvIHRo
ZSBsb2NrIHR5cGUuDQoNClNpZ25lZC1vZmYtYnk6IENoaW53ZW4gQ2hhbmcgPGNoaW53ZW4uY2hh
bmdAbWVkaWF0ZWsuY29tPg0KUmV2aWV3ZWQtYnk6IFN0ZXZlbiBQcmljZSA8c3RldmVuLnByaWNl
QGFybS5jb20+DQpBY2tlZC1ieTogTWljaGVsIExlc3BpbmFzc2UgPHdhbGtlbkBnb29nbGUuY29t
Pg0KLS0tDQogaW5jbHVkZS9saW51eC9tbWFwX2xvY2suaCB8IDUgKysrKysNCiAxIGZpbGUgY2hh
bmdlZCwgNSBpbnNlcnRpb25zKCspDQoNCmRpZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4L21tYXBf
bG9jay5oIGIvaW5jbHVkZS9saW51eC9tbWFwX2xvY2suaA0KaW5kZXggMDcwNzY3MS4uMThlN2Vh
ZSAxMDA2NDQNCi0tLSBhL2luY2x1ZGUvbGludXgvbW1hcF9sb2NrLmgNCisrKyBiL2luY2x1ZGUv
bGludXgvbW1hcF9sb2NrLmgNCkBAIC04Nyw0ICs4Nyw5IEBAIHN0YXRpYyBpbmxpbmUgdm9pZCBt
bWFwX2Fzc2VydF93cml0ZV9sb2NrZWQoc3RydWN0IG1tX3N0cnVjdCAqbW0pDQogCVZNX0JVR19P
Tl9NTSghcndzZW1faXNfbG9ja2VkKCZtbS0+bW1hcF9sb2NrKSwgbW0pOw0KIH0NCiANCitzdGF0
aWMgaW5saW5lIGludCBtbWFwX2xvY2tfaXNfY29udGVuZGVkKHN0cnVjdCBtbV9zdHJ1Y3QgKm1t
KQ0KK3sNCisJcmV0dXJuIHJ3c2VtX2lzX2NvbnRlbmRlZCgmbW0tPm1tYXBfbG9jayk7DQorfQ0K
Kw0KICNlbmRpZiAvKiBfTElOVVhfTU1BUF9MT0NLX0ggKi8NCi0tIA0KMS45LjENCg==


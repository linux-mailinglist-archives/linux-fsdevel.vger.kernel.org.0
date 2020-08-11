Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10FCD2415CF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Aug 2020 06:45:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726280AbgHKEow (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 Aug 2020 00:44:52 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:6055 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725942AbgHKEow (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 Aug 2020 00:44:52 -0400
X-UUID: 5959afdaa73f485dbf2a6c30c94c07e7-20200811
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=H0Ud4DxvbVD4jTTU4mw6Oz6ngOHpGn6wmSjAa92YZU4=;
        b=ONsVnW4jjYfqo1a961AXrBDoUsy/D9qAoVr2s937dlp1KmQSnv+pn9nLi0+H7boIi11f2aeb48D2c0y05sETc5obNfGqx83tYqnIXFnDaIUeBCKZg4j1m0hLBQHzmu3db7Kcg7/a3mA0hGCAdrIlfxTfMJlUFBP+hrwxSZUpZHo=;
X-UUID: 5959afdaa73f485dbf2a6c30c94c07e7-20200811
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw02.mediatek.com
        (envelope-from <chinwen.chang@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 651182344; Tue, 11 Aug 2020 12:44:48 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs01n1.mediatek.inc (172.21.101.68) with Microsoft SMTP Server (TLS) id
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
Subject: [PATCH 1/2] mmap locking API: add mmap_lock_is_contended()
Date:   Tue, 11 Aug 2020 12:42:34 +0800
Message-ID: <1597120955-16495-2-git-send-email-chinwen.chang@mediatek.com>
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

QWRkIG5ldyBBUEkgdG8gcXVlcnkgaWYgc29tZW9uZSB3YW50cyB0byBhY3F1aXJlIG1tYXBfbG9j
aw0KZm9yIHdyaXRlIGF0dGVtcHRzLg0KDQpVc2luZyB0aGlzIGluc3RlYWQgb2YgcndzZW1faXNf
Y29udGVuZGVkIG1ha2VzIGl0IG1vcmUgdG9sZXJhbnQNCm9mIGZ1dHVyZSBjaGFuZ2VzIHRvIHRo
ZSBsb2NrIHR5cGUuDQoNClNpZ25lZC1vZmYtYnk6IENoaW53ZW4gQ2hhbmcgPGNoaW53ZW4uY2hh
bmdAbWVkaWF0ZWsuY29tPg0KLS0tDQogaW5jbHVkZS9saW51eC9tbWFwX2xvY2suaCB8IDUgKysr
KysNCiAxIGZpbGUgY2hhbmdlZCwgNSBpbnNlcnRpb25zKCspDQoNCmRpZmYgLS1naXQgYS9pbmNs
dWRlL2xpbnV4L21tYXBfbG9jay5oIGIvaW5jbHVkZS9saW51eC9tbWFwX2xvY2suaA0KaW5kZXgg
MDcwNzY3MS4uMThlN2VhZSAxMDA2NDQNCi0tLSBhL2luY2x1ZGUvbGludXgvbW1hcF9sb2NrLmgN
CisrKyBiL2luY2x1ZGUvbGludXgvbW1hcF9sb2NrLmgNCkBAIC04Nyw0ICs4Nyw5IEBAIHN0YXRp
YyBpbmxpbmUgdm9pZCBtbWFwX2Fzc2VydF93cml0ZV9sb2NrZWQoc3RydWN0IG1tX3N0cnVjdCAq
bW0pDQogCVZNX0JVR19PTl9NTSghcndzZW1faXNfbG9ja2VkKCZtbS0+bW1hcF9sb2NrKSwgbW0p
Ow0KIH0NCiANCitzdGF0aWMgaW5saW5lIGludCBtbWFwX2xvY2tfaXNfY29udGVuZGVkKHN0cnVj
dCBtbV9zdHJ1Y3QgKm1tKQ0KK3sNCisJcmV0dXJuIHJ3c2VtX2lzX2NvbnRlbmRlZCgmbW0tPm1t
YXBfbG9jayk7DQorfQ0KKw0KICNlbmRpZiAvKiBfTElOVVhfTU1BUF9MT0NLX0ggKi8NCi0tIA0K
MS45LjENCg==


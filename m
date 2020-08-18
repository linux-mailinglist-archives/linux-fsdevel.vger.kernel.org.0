Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0A40247C07
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Aug 2020 03:58:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726444AbgHRB6w (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Aug 2020 21:58:52 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:11447 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726328AbgHRB6v (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Aug 2020 21:58:51 -0400
X-UUID: 523443b9c19b400cb3b7d2e2dbcbc7c2-20200818
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=Y4xhx9IjgKvrJUycw+ZxzgJtq8e5cl3Sw5tNuSRwHcw=;
        b=AbluTKA19PxqLoI+zLg6oLtTkD1p0KH3ifR69zYBIFpvq4MnYzH5qV48j7zZviZglQaAjeM16h0kdLR0b6RkpzMWiY2/XK8/mIUTmUco2BOUKJBkez7l4SbD3I0+QKKpvjZEmN6j0Rvcm2B3Wfq8GJ/xDcvRwf2gATwOb6jg7ms=;
X-UUID: 523443b9c19b400cb3b7d2e2dbcbc7c2-20200818
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw02.mediatek.com
        (envelope-from <chinwen.chang@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1822860258; Tue, 18 Aug 2020 09:58:46 +0800
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
Subject: [PATCH v4 0/3] Try to release mmap_lock temporarily in smaps_rollup
Date:   Tue, 18 Aug 2020 09:58:15 +0800
Message-ID: <1597715898-3854-1-git-send-email-chinwen.chang@mediatek.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 7D471C64083F4CDE6FA76DAD05F7A7CDB90D1CBE8CE8627B75196A7301A582C22000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

UmVjZW50bHksIHdlIGhhdmUgb2JzZXJ2ZWQgc29tZSBqYW5reSBpc3N1ZXMgY2F1c2VkIGJ5IHVu
cGxlYXNhbnRseSBsb25nDQpjb250ZW50aW9uIG9uIG1tYXBfbG9jayB3aGljaCBpcyBoZWxkIGJ5
IHNtYXBzX3JvbGx1cCB3aGVuIHByb2JpbmcgbGFyZ2UNCnByb2Nlc3Nlcy4gVG8gYWRkcmVzcyB0
aGUgcHJvYmxlbSwgd2UgbGV0IHNtYXBzX3JvbGx1cCBkZXRlY3QgaWYgYW55b25lDQp3YW50cyB0
byBhY3F1aXJlIG1tYXBfbG9jayBmb3Igd3JpdGUgYXR0ZW1wdHMuIElmIHllcywganVzdCByZWxl
YXNlIHRoZQ0KbG9jayB0ZW1wb3JhcmlseSB0byBlYXNlIHRoZSBjb250ZW50aW9uLg0KDQpzbWFw
c19yb2xsdXAgaXMgYSBwcm9jZnMgaW50ZXJmYWNlIHdoaWNoIGFsbG93cyB1c2VycyB0byBzdW1t
YXJpemUgdGhlDQpwcm9jZXNzJ3MgbWVtb3J5IHVzYWdlIHdpdGhvdXQgdGhlIG92ZXJoZWFkIG9m
IHNlcV8qIGNhbGxzLiBBbmRyb2lkIHVzZXMgaXQNCnRvIHNhbXBsZSB0aGUgbWVtb3J5IHVzYWdl
IG9mIHZhcmlvdXMgcHJvY2Vzc2VzIHRvIGJhbGFuY2UgaXRzIG1lbW9yeSBwb29sDQpzaXplcy4g
SWYgbm8gb25lIHdhbnRzIHRvIHRha2UgdGhlIGxvY2sgZm9yIHdyaXRlIHJlcXVlc3RzLCBzbWFw
c19yb2xsdXANCndpdGggdGhpcyBwYXRjaCB3aWxsIGJlaGF2ZSBsaWtlIHRoZSBvcmlnaW5hbCBv
bmUuDQoNCkFsdGhvdWdoIHRoZXJlIGFyZSBvbi1nb2luZyBtbWFwX2xvY2sgb3B0aW1pemF0aW9u
cyBsaWtlIHJhbmdlLWJhc2VkIGxvY2tzLA0KdGhlIGxvY2sgYXBwbGllZCB0byBzbWFwc19yb2xs
dXAgd291bGQgYmUgdGhlIGNvYXJzZSBvbmUsIHdoaWNoIGlzIGhhcmQgdG8NCmF2b2lkIHRoZSBv
Y2N1cnJlbmNlIG9mIGFmb3JlbWVudGlvbmVkIGlzc3Vlcy4gU28gdGhlIGRldGVjdGlvbiBhbmQN
CnRlbXBvcmFyeSByZWxlYXNlIGZvciB3cml0ZSBhdHRlbXB0cyBvbiBtbWFwX2xvY2sgaW4gc21h
cHNfcm9sbHVwIGlzIHN0aWxsDQpuZWNlc3NhcnkuDQoNCkNoYW5nZSBzaW5jZSB2MToNCi0gSWYg
Y3VycmVudCBWTUEgaXMgZnJlZWQgYWZ0ZXIgZHJvcHBpbmcgdGhlIGxvY2ssIGl0IHdpbGwgcmV0
dXJuDQotIGluY29tcGxldGUgcmVzdWx0LiBUbyBmaXggdGhpcyBpc3N1ZSwgcmVmaW5lIHRoZSBj
b2RlIGZsb3cgYXMNCi0gc3VnZ2VzdGVkIGJ5IFN0ZXZlLiBbMV0NCg0KQ2hhbmdlIHNpbmNlIHYy
Og0KLSBXaGVuIGdldHRpbmcgYmFjayB0aGUgbW1hcCBsb2NrLCB0aGUgYWRkcmVzcyB3aGVyZSB5
b3Ugc3RvcHBlZCBsYXN0DQotIHRpbWUgY291bGQgbm93IGJlIGluIHRoZSBtaWRkbGUgb2YgYSB2
bWEuIEFkZCBvbmUgbW9yZSBjaGVjayB0byBoYW5kbGUNCi0gdGhpcyBjYXNlIGFzIHN1Z2dlc3Rl
ZCBieSBNaWNoZWwuIFsyXQ0KDQpDaGFuZ2Ugc2luY2UgdjM6DQotIGxhc3Rfc3RvcHBlZCBpcyBl
YXNpbHkgY29uZnVzZWQgd2l0aCBsYXN0X3ZtYV9lbmQuIFJlcGxhY2UgaXQgd2l0aA0KLSBhIGRp
cmVjdCBjYWxsIHRvIHNtYXBfZ2F0aGVyX3N0YXRzKHZtYSwgJm1zcywgbGFzdF92bWFfZW5kKSBh
cw0KLSBzdWdnZXN0ZWQgYnkgU3RldmUuIFszXQ0KDQpbMV0gaHR0cHM6Ly9sb3JlLmtlcm5lbC5v
cmcvbGttbC9iZjQwNjc2ZS1iMTRiLTQ0Y2QtNzVjZS00MTljNzAxOTQ3ODNAYXJtLmNvbS8NClsy
XSBodHRwczovL2xvcmUua2VybmVsLm9yZy9sa21sL0NBTk42ODlGdENzQzcxY2pBanMwR1BzcE9o
Z29fSFJqK2RpV3NvVTF3cjk4WVBrdGdXZ0BtYWlsLmdtYWlsLmNvbS8NClszXSBodHRwczovL2xv
cmUua2VybmVsLm9yZy9sa21sL2RiMGQ0MGUyLTcyZjMtMDlkNS1jMTYyLTljNDkyMThmMTI4ZkBh
cm0uY29tLw0KDQoNCkNoaW53ZW4gQ2hhbmcgKDMpOg0KICBtbWFwIGxvY2tpbmcgQVBJOiBhZGQg
bW1hcF9sb2NrX2lzX2NvbnRlbmRlZCgpDQogIG1tOiBzbWFwcyo6IGV4dGVuZCBzbWFwX2dhdGhl
cl9zdGF0cyB0byBzdXBwb3J0IHNwZWNpZmllZCBiZWdpbm5pbmcNCiAgbW06IHByb2M6IHNtYXBz
X3JvbGx1cDogZG8gbm90IHN0YWxsIHdyaXRlIGF0dGVtcHRzIG9uIG1tYXBfbG9jaw0KDQogZnMv
cHJvYy90YXNrX21tdS5jICAgICAgICB8IDk2ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrLS0tLQ0KIGluY2x1ZGUvbGludXgvbW1hcF9sb2NrLmggfCAgNSArKw0KIDIgZmlsZXMg
Y2hhbmdlZCwgOTIgaW5zZXJ0aW9ucygrKSwgOSBkZWxldGlvbnMoLSk=


Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97C12243264
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Aug 2020 04:14:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726635AbgHMCNu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 Aug 2020 22:13:50 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:48592 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726605AbgHMCNu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 Aug 2020 22:13:50 -0400
X-UUID: dfad2300fe9a44c3b23ad3781c03596b-20200813
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=aF1D+BCyiRCtqB/9T1GyAsWkEq1ttG2TVqo5h3JEkxo=;
        b=lhd/2RrY8T0f6YKQIjm4brzBv6gAsEKFXZ5XX0tHceBMZOLPU0+mNhyrtBsWIxCc9HfwvRXRm3hOogf+C4nB6RInkLlfK3bYVsaFyv87lrTFFeMy30OU8Nugdgyhd/NvPD1pgLYQlfxJL9QvSYFkdrefIKPNBE8Q7SIb66tY8K4=;
X-UUID: dfad2300fe9a44c3b23ad3781c03596b-20200813
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw02.mediatek.com
        (envelope-from <chinwen.chang@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 631092834; Thu, 13 Aug 2020 10:13:46 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs02n1.mediatek.inc (172.21.101.77) with Microsoft SMTP Server (TLS) id
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
Subject: [PATCH v2 0/2] Try to release mmap_lock temporarily in smaps_rollup
Date:   Thu, 13 Aug 2020 10:13:28 +0800
Message-ID: <1597284810-17454-1-git-send-email-chinwen.chang@mediatek.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
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
b2RlIGZsb3cgYXMNCi0gc3VnZ2VzdGVkIGJ5IFN0ZXZlLiBbMV0NCg0KWzFdIGh0dHBzOi8vbG9y
ZS5rZXJuZWwub3JnL2xrbWwvYmY0MDY3NmUtYjE0Yi00NGNkLTc1Y2UtNDE5YzcwMTk0NzgzQGFy
bS5jb20vDQoNCg0KQ2hpbndlbiBDaGFuZyAoMik6DQogIG1tYXAgbG9ja2luZyBBUEk6IGFkZCBt
bWFwX2xvY2tfaXNfY29udGVuZGVkKCkNCiAgbW06IHByb2M6IHNtYXBzX3JvbGx1cDogZG8gbm90
IHN0YWxsIHdyaXRlIGF0dGVtcHRzIG9uIG1tYXBfbG9jaw0KDQogZnMvcHJvYy90YXNrX21tdS5j
ICAgICAgICB8IDU3ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrLQ0KIGlu
Y2x1ZGUvbGludXgvbW1hcF9sb2NrLmggfCAgNSArKysrDQogMiBmaWxlcyBjaGFuZ2VkLCA2MSBp
bnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0p


Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9826C2415CE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Aug 2020 06:45:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728064AbgHKEoz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 Aug 2020 00:44:55 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:30302 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725942AbgHKEox (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 Aug 2020 00:44:53 -0400
X-UUID: 8eb802f3faa042e88534f1e099ec2a97-20200811
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=xMfOcxXPIjQ8x1RL6vb8f9fzkRGTsMOc4csNnJ7zcjY=;
        b=RAjKmqsTF+iGUBIcVHptes79Gmi09FbSYfNTRJFAHvWBkJznx9a6QgKe23gpILz/WoOz+UVM99xSmoLzbqGBkyQSQdFPQjSXibLIry+cJuvf1nKm3iVX3QQ9IfKYbaIfPrHYp4GPxz/++GdTn1quJoJ5JSEQ1yIhwgOIbZGwYZc=;
X-UUID: 8eb802f3faa042e88534f1e099ec2a97-20200811
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw01.mediatek.com
        (envelope-from <chinwen.chang@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1932061379; Tue, 11 Aug 2020 12:44:48 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs02n2.mediatek.inc (172.21.101.101) with Microsoft SMTP Server (TLS) id
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
Subject: [PATCH 0/2] Try to release mmap_lock temporarily in smaps_rollup
Date:   Tue, 11 Aug 2020 12:42:33 +0800
Message-ID: <1597120955-16495-1-git-send-email-chinwen.chang@mediatek.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: FECB1C8FBBC3155D664B844BB8EA23BAF81A4309A9540D60EDA9FF345C03F1222000:8
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
IHNlcV8qIGNhbGxzLiBBbmRyb2lkIHVzZXMNCml0IHRvIHNhbXBsZSB0aGUgbWVtb3J5IHVzYWdl
IG9mIHZhcmlvdXMgcHJvY2Vzc2VzIHRvIGJhbGFuY2UgaXRzIG1lbW9yeQ0KcG9vbCBzaXplcy4g
SWYgbm8gb25lIHdhbnRzIHRvIHRha2UgdGhlIGxvY2sgZm9yIHdyaXRlIHJlcXVlc3RzLCBzbWFw
c19yb2xsdXANCndpdGggdGhpcyBwYXRjaCB3aWxsIGJlaGF2ZSBsaWtlIHRoZSBvcmlnaW5hbCBv
bmUuDQoNCkFsdGhvdWdoIHRoZXJlIGFyZSBvbi1nb2luZyBtbWFwX2xvY2sgb3B0aW1pemF0aW9u
cyBsaWtlIHJhbmdlLWJhc2VkIGxvY2tzLA0KdGhlIGxvY2sgYXBwbGllZCB0byBzbWFwc19yb2xs
dXAgd291bGQgYmUgdGhlIGNvYXJzZSBvbmUsIHdoaWNoIGlzIGhhcmQgdG8NCmF2b2lkIHRoZSBv
Y2N1cnJlbmNlIG9mIGFmb3JlbWVudGlvbmVkIGlzc3Vlcy4gU28gdGhlIGRldGVjdGlvbiBhbmQg
dGVtcG9yYXJ5DQpyZWxlYXNlIGZvciB3cml0ZSBhdHRlbXB0cyBvbiBtbWFwX2xvY2sgaW4gc21h
cHNfcm9sbHVwIGlzIHN0aWxsIG5lY2Vzc2FyeS4NCg0KDQpDaGlud2VuIENoYW5nICgyKToNCiAg
bW1hcCBsb2NraW5nIEFQSTogYWRkIG1tYXBfbG9ja19pc19jb250ZW5kZWQoKQ0KICBtbTogcHJv
Yzogc21hcHNfcm9sbHVwOiBkbyBub3Qgc3RhbGwgd3JpdGUgYXR0ZW1wdHMgb24gbW1hcF9sb2Nr
DQoNCiBmcy9wcm9jL3Rhc2tfbW11LmMgICAgICAgIHwgMjEgKysrKysrKysrKysrKysrKysrKysr
DQogaW5jbHVkZS9saW51eC9tbWFwX2xvY2suaCB8ICA1ICsrKysrDQogMiBmaWxlcyBjaGFuZ2Vk
LCAyNiBpbnNlcnRpb25zKCsp


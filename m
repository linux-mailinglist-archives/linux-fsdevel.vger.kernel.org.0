Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42AAD26BA86
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Sep 2020 05:11:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726199AbgIPDLA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Sep 2020 23:11:00 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:4030 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726023AbgIPDK7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Sep 2020 23:10:59 -0400
X-UUID: cbd4855e607847e9aae04bae63b2b54a-20200916
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=XdGgRW/3OeKuYJf8ldjX1lPp2lx16y2TaHXPel27PiI=;
        b=U5L5/9FV0DUL5oLnBSSDezrmApetUpN4JZqZ5+M7wgiajBFkFXpi+SjNkIKL8YHRVl+4ld7JijH/yCDwVZriKw/52+XCeVqxc+Fx+nonO0R+Hz3aD7Oi+yqKfQm8VtOmE7SvbdKvBEpzTZxcrtZWtuVnHaRj/LZXfytPfq0eRyU=;
X-UUID: cbd4855e607847e9aae04bae63b2b54a-20200916
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw02.mediatek.com
        (envelope-from <miles.chen@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1473426936; Wed, 16 Sep 2020 11:10:55 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs08n2.mediatek.inc (172.21.101.56) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 16 Sep 2020 11:10:52 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 16 Sep 2020 11:10:52 +0800
From:   Miles Chen <miles.chen@mediatek.com>
To:     Alexey Dobriyan <adobriyan@gmail.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <wsd_upstream@mediatek.com>,
        Miles Chen <miles.chen@mediatek.com>
Subject: [RESEND PATCHv1] proc: use untagged_addr() for pagemap_read addresses
Date:   Wed, 16 Sep 2020 11:10:51 +0800
Message-ID: <20200916031051.18064-1-miles.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: CE19B1F2FC9FC8C2D05489159D298EA6D34DC5946529AE6C8C162F3A4E39F4C32000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

V2hlbiB3ZSB0cnkgdG8gdmlzaXQgdGhlIHBhZ2VtYXAgb2YgYSB0YWdnZWQgdXNlcnNwYWNlIHBv
aW50ZXIsIHdlIGZpbmQNCnRoYXQgdGhlIHN0YXJ0X3ZhZGRyIGlzIG5vdCBjb3JyZWN0IGJlY2F1
c2Ugb2YgdGhlIHRhZy4NClRvIGZpeCBpdCwgd2Ugc2hvdWxkIHVudGFnIHRoZSB1c2VzcGFjZSBw
b2ludGVycyBpbiBwYWdlbWFwX3JlYWQoKS4NCg0KU2lnbmVkLW9mZi1ieTogTWlsZXMgQ2hlbiA8
bWlsZXMuY2hlbkBtZWRpYXRlay5jb20+DQotLS0NCiBmcy9wcm9jL3Rhc2tfbW11LmMgfCA0ICsr
LS0NCiAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQ0KDQpk
aWZmIC0tZ2l0IGEvZnMvcHJvYy90YXNrX21tdS5jIGIvZnMvcHJvYy90YXNrX21tdS5jDQppbmRl
eCA1MDY2YjAyNTFlZDguLmVlMGFjMDllNzlmYyAxMDA2NDQNCi0tLSBhL2ZzL3Byb2MvdGFza19t
bXUuYw0KKysrIGIvZnMvcHJvYy90YXNrX21tdS5jDQpAQCAtMTU0MSwxMSArMTU0MSwxMSBAQCBz
dGF0aWMgc3NpemVfdCBwYWdlbWFwX3JlYWQoc3RydWN0IGZpbGUgKmZpbGUsIGNoYXIgX191c2Vy
ICpidWYsDQogDQogCXNyYyA9ICpwcG9zOw0KIAlzdnBmbiA9IHNyYyAvIFBNX0VOVFJZX0JZVEVT
Ow0KLQlzdGFydF92YWRkciA9IHN2cGZuIDw8IFBBR0VfU0hJRlQ7DQorCXN0YXJ0X3ZhZGRyID0g
dW50YWdnZWRfYWRkcihzdnBmbiA8PCBQQUdFX1NISUZUKTsNCiAJZW5kX3ZhZGRyID0gbW0tPnRh
c2tfc2l6ZTsNCiANCiAJLyogd2F0Y2ggb3V0IGZvciB3cmFwYXJvdW5kICovDQotCWlmIChzdnBm
biA+IG1tLT50YXNrX3NpemUgPj4gUEFHRV9TSElGVCkNCisJaWYgKHN0YXJ0X3ZhZGRyID4gbW0t
PnRhc2tfc2l6ZSkNCiAJCXN0YXJ0X3ZhZGRyID0gZW5kX3ZhZGRyOw0KIA0KIAkvKg0KLS0gDQoy
LjE4LjANCg==


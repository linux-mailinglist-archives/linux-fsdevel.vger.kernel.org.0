Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2AB511756C5
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Mar 2020 10:17:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727205AbgCBJRs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 2 Mar 2020 04:17:48 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:32062 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726144AbgCBJRs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 Mar 2020 04:17:48 -0500
X-UUID: f41c14b013444c8b8059cd4b70c15acd-20200302
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=Tm2dGLrDuwKIqwWQ0m6yCuCCVqgYcKl6heBDIiRcfnw=;
        b=m/hQqlwlZqZcCb/1QUp0UCExNYbrk9++KsBF02NmBy/z0LHTDcXsjFrTuG1Zf3urS9X368of4Ko+LS0URaE24EUuO7V75ePvrrl8slLb7iiq+MjRAcUPr8//p0xJT6OkDqOd4GCkNnoFx4lylvtBkyXV4fqCQ5hG4JDNusRWGwU=;
X-UUID: f41c14b013444c8b8059cd4b70c15acd-20200302
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw01.mediatek.com
        (envelope-from <stanley.chu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1936260261; Mon, 02 Mar 2020 17:17:43 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs02n1.mediatek.inc (172.21.101.77) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Mon, 2 Mar 2020 17:15:37 +0800
Received: from [172.21.84.99] (172.21.84.99) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Mon, 2 Mar 2020 17:17:04 +0800
Message-ID: <1583140656.10509.2.camel@mtksdccf07>
Subject: Re: [PATCH v7 6/9] scsi: ufs: Add inline encryption support to UFS
From:   Stanley Chu <stanley.chu@mediatek.com>
To:     Eric Biggers <ebiggers@kernel.org>
CC:     Christoph Hellwig <hch@infradead.org>,
        Satya Tangirala <satyat@google.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-fscrypt@vger.kernel.org" <linux-fscrypt@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-f2fs-devel@lists.sourceforge.net" 
        <linux-f2fs-devel@lists.sourceforge.net>,
        "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>,
        Barani Muthukumaran <bmuthuku@qti.qualcomm.com>,
        Kuohong Wang =?UTF-8?Q?=28=E7=8E=8B=E5=9C=8B=E9=B4=BB=29?= 
        <kuohong.wang@mediatek.com>, Kim Boojin <boojin.kim@samsung.com>,
        Ladvine D Almeida <Ladvine.DAlmeida@synopsys.com>,
        Parshuram Raju Thombare <pthombar@cadence.com>
Date:   Mon, 2 Mar 2020 17:17:36 +0800
In-Reply-To: <1582699394.26304.96.camel@mtksdccf07>
References: <20200221115050.238976-1-satyat@google.com>
         <20200221115050.238976-7-satyat@google.com>
         <20200221172244.GC438@infradead.org> <20200221181109.GB925@sol.localdomain>
         <1582465656.26304.69.camel@mtksdccf07>
         <20200224233759.GC30288@infradead.org>
         <1582615285.26304.93.camel@mtksdccf07> <20200226011206.GD114977@gmail.com>
         <1582699394.26304.96.camel@mtksdccf07>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

SGkgRXJpYyBhbmQgYWxsLA0KDQpPbiBXZWQsIDIwMjAtMDItMjYgYXQgMTQ6NDMgKzA4MDAsIFN0
YW5sZXkgQ2h1IHdyb3RlOg0KPiBIaSBFcmljLA0KPiANCj4gT24gVHVlLCAyMDIwLTAyLTI1IGF0
IDE3OjEyIC0wODAwLCBFcmljIEJpZ2dlcnMgd3JvdGU6DQoNCj4gPiANCj4gPiBJJ20gbm90IHN1
cmUgYWJvdXQgdGhlIFVGUyBjb250cm9sbGVycyBmcm9tIFN5bm9wc3lzLCBDYWRlbmNlLCBvciBT
YW1zdW5nLCBhbGwNCj4gPiBvZiB3aGljaCBhcHBhcmVudGx5IGhhdmUgaW1wbGVtZW50ZWQgc29t
ZSBmb3JtIG9mIHRoZSBjcnlwdG8gc3VwcG9ydCB0b28uICBCdXQgSQ0KPiA+IHdvdWxkbid0IGdl
dCBteSBob3BlcyB1cCB0aGF0IGV2ZXJ5b25lIGZvbGxvd2VkIHRoZSBVRlMgc3RhbmRhcmQgcHJl
Y2lzZWx5Lg0KPiA+IA0KPiA+IFNvIGlmIHRoZXJlIGFyZSBubyBvYmplY3Rpb25zLCBJTU8gd2Ug
c2hvdWxkIG1ha2UgdGhlIGNyeXB0byBzdXBwb3J0IG9wdC1pbi4NCj4gPiANCj4gPiBUaGF0IG1h
a2VzIGl0IGV2ZW4gbW9yZSBpbXBvcnRhbnQgdG8gdXBzdHJlYW0gdGhlIGNyeXB0byBzdXBwb3J0
IGZvciBzcGVjaWZpYw0KPiA+IGhhcmR3YXJlIGxpa2UgdWZzLXFjb20gYW5kIHVmcy1tZWRpYXRl
aywgc2luY2Ugb3RoZXJ3aXNlIHRoZSB1ZnNoY2QtY3J5cHRvIGNvZGUNCj4gPiB3b3VsZCBiZSB1
bnVzYWJsZSBldmVuIHRoZW9yZXRpY2FsbHkuICBJJ20gdm9sdW50ZWVyaW5nIHRvIGhhbmRsZSB1
ZnMtcWNvbSB3aXRoDQo+ID4gaHR0cHM6Ly9sa21sLmtlcm5lbC5vcmcvbGludXgtYmxvY2svMjAy
MDAxMTAwNjE2MzQuNDY3NDItMS1lYmlnZ2Vyc0BrZXJuZWwub3JnLy4NCj4gPiBTdGFubGV5LCBj
b3VsZCB5b3Ugc2VuZCBvdXQgdWZzLW1lZGlhdGVrIHN1cHBvcnQgYXMgYW4gUkZDIHNvIHBlb3Bs
ZSBjYW4gc2VlDQo+ID4gYmV0dGVyIHdoYXQgaXQgaW52b2x2ZXM/DQo+IA0KPiBTdXJlLCBJIHdp
bGwgc2VuZCBvdXQgb3VyIFJGQyBwYXRjaGVzLiBQbGVhc2UgYWxsb3cgbWUgc29tZSB0aW1lIGZv
cg0KPiBzdWJtaXNzaW9uLg0KDQpUaGUgdWZzLW1lZGlhdGVrIFJGQyBwYXRjaCBpcyB1cGxvYWRl
ZCBhcw0KaHR0cHM6Ly9wYXRjaHdvcmsua2VybmVsLm9yZy9wYXRjaC8xMTQxNTA1MS8NCg0KVGhp
cyBwYXRjaCBpcyByZWJhc2VkIHRvIHRoZSBsYXRlc3Qgd2lwLWlubGluZS1lbmNyeXB0aW9uIGJy
YW5jaCBpbg0KRXJpYyBCaWdnZXJzJ3MgZ2l0Og0KaHR0cHM6Ly9naXQua2VybmVsLm9yZy9wdWIv
c2NtL2xpbnV4L2tlcm5lbC9naXQvZWJpZ2dlcnMvbGludXguZ2l0Lw0KDQpUaGFua3MsDQpTdGFu
bGV5IENodQ0K


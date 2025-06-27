Return-Path: <linux-fsdevel+bounces-53171-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F5A6AEB5C0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Jun 2025 13:04:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E5CDF189A78E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Jun 2025 11:04:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BD8F2BEC28;
	Fri, 27 Jun 2025 11:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=didiglobal.com header.i=@didiglobal.com header.b="KApNmOW0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx10.didiglobal.com (mx10.didiglobal.com [111.202.70.125])
	by smtp.subspace.kernel.org (Postfix) with SMTP id B1C922980B4;
	Fri, 27 Jun 2025 11:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.202.70.125
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751022214; cv=none; b=PkcBiXR8QjMgt/ROrZoVBS9g8FD1eYiCz4sZaMspNgUsUpcGFXNzNVILJ9kIwUW8ipCR6PwqWpdwghUMi4uE9KLAidQzJOKQOSKBYb1DCio7Jtfbivo3oe4ich0fM2bBpF4WwMz7d2YrfvBTrjsq4pvYHOBC/PoEqf5lsSwEAv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751022214; c=relaxed/simple;
	bh=3eEkTzd48aJijwJie0PYgb5WApqXlFvlW7CzY8x/BWg=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=oxH7WIPPKQ9Td15bOiV+bfspxRmFpM47eVvbj3m+3oXjfj4WyLhYFu/pltqoxSjDhT3NmG2p2zLtGKPhQJFgkzzriJkyj9vC5O3ggbFAiq/3n6s6XY9hihessMM/2gr0dC8SNTv2QoR5UfgOGkG+Fga5Ie0XnG9hbDI1i6YZX6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=didiglobal.com; spf=pass smtp.mailfrom=didiglobal.com; dkim=pass (1024-bit key) header.d=didiglobal.com header.i=@didiglobal.com header.b=KApNmOW0; arc=none smtp.client-ip=111.202.70.125
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=didiglobal.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=didiglobal.com
Received: from mail.didiglobal.com (unknown [10.79.71.38])
	by mx10.didiglobal.com (MailData Gateway V2.8.8) with ESMTPS id C7EB5180FFD583;
	Fri, 27 Jun 2025 19:02:17 +0800 (CST)
Received: from BJ01-ACTMBX-09.didichuxing.com (10.79.64.19) by
 BJ03-ACTMBX-02.didichuxing.com (10.79.71.38) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Fri, 27 Jun 2025 19:03:00 +0800
Received: from BJ03-ACTMBX-07.didichuxing.com (10.79.71.34) by
 BJ01-ACTMBX-09.didichuxing.com (10.79.64.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Fri, 27 Jun 2025 19:02:59 +0800
Received: from BJ03-ACTMBX-07.didichuxing.com ([fe80::2e1a:dd47:6d25:287e]) by
 BJ03-ACTMBX-07.didichuxing.com ([fe80::2e1a:dd47:6d25:287e%7]) with mapi id
 15.02.1748.010; Fri, 27 Jun 2025 19:02:59 +0800
X-MD-Sfrom: chentaotao@didiglobal.com
X-MD-SrcIP: 10.79.71.38
From: =?gb2312?B?s8LMzszOIFRhb3RhbyBDaGVu?= <chentaotao@didiglobal.com>
To: "tytso@mit.edu" <tytso@mit.edu>, "hch@infradead.org" <hch@infradead.org>,
	"adilger.kernel@dilger.ca" <adilger.kernel@dilger.ca>, "willy@infradead.org"
	<willy@infradead.org>, "brauner@kernel.org" <brauner@kernel.org>,
	"jani.nikula@linux.intel.com" <jani.nikula@linux.intel.com>,
	"rodrigo.vivi@intel.com" <rodrigo.vivi@intel.com>, "tursulin@ursulin.net"
	<tursulin@ursulin.net>, "airlied@gmail.com" <airlied@gmail.com>
CC: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>,
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "chentao325@qq.com" <chentao325@qq.com>,
	"frank.li@vivo.com" <frank.li@vivo.com>,
	=?gb2312?B?s8LMzszOIFRhb3RhbyBDaGVu?= <chentaotao@didiglobal.com>
Subject: [PATCH v3 0/4] fs: refactor write_begin/write_end and add ext4
 IOCB_DONTCACHE support
Thread-Topic: [PATCH v3 0/4] fs: refactor write_begin/write_end and add ext4
 IOCB_DONTCACHE support
Thread-Index: AQHb51MLW2LGYmXE/k20eq/l5Jv3Yw==
Date: Fri, 27 Jun 2025 11:02:59 +0000
Message-ID: <20250627110257.1870826-1-chentaotao@didiglobal.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=didiglobal.com;
	s=2025; t=1751022159;
	bh=3eEkTzd48aJijwJie0PYgb5WApqXlFvlW7CzY8x/BWg=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type;
	b=KApNmOW02CTDBt28PJqDWHYfl7sdBXb/8lUclD2mNMCrpsIKV4nLmUO35t6pdRNpr
	 fHTI/liJvGeoRIHIWhVG48ygm49UNeXjpF4/KLb8hkowd6dGVcIWOIDxcsU0dg3fYw
	 F+JorA/cq5QG40DYy9NfKAWXD/O5aZUoe6XuWCyY=

RnJvbTogVGFvdGFvIENoZW4gPGNoZW50YW90YW9AZGlkaWdsb2JhbC5jb20+DQoNClRoaXMgcGF0
Y2ggc2VyaWVzIHJlZmFjdG9ycyB0aGUgYWRkcmVzc19zcGFjZV9vcGVyYXRpb25zIHdyaXRlX2Jl
Z2luKCkNCmFuZCB3cml0ZV9lbmQoKSBjYWxsYmFja3MgdG8gdGFrZSBjb25zdCBzdHJ1Y3Qga2lv
Y2IgKiBhcyB0aGVpciBmaXJzdA0KYXJndW1lbnQsIGFsbG93aW5nIElPQ0IgZmxhZ3Mgc3VjaCBh
cyBJT0NCX0RPTlRDQUNIRSB0byBwcm9wYWdhdGUgdG8gdGhlDQpmaWxlc3lzdGVtJ3MgYnVmZmVy
ZWQgSS9PIHBhdGguDQoNCkV4dDQgaXMgdXBkYXRlZCB0byBpbXBsZW1lbnQgaGFuZGxpbmcgb2Yg
dGhlIElPQ0JfRE9OVENBQ0hFIGZsYWcgYW5kDQphZHZlcnRpc2VzIHN1cHBvcnQgdmlhIHRoZSBG
T1BfRE9OVENBQ0hFIGZpbGUgb3BlcmF0aW9uIGZsYWcuDQoNCkFkZGl0aW9uYWxseSwgdGhlIGk5
MTUgZHJpdmVyJ3Mgc2htZW0gd3JpdGUgcGF0aHMgYXJlIHVwZGF0ZWQgdG8gYnlwYXNzDQp0aGUg
bGVnYWN5IHdyaXRlX2JlZ2luL3dyaXRlX2VuZCBpbnRlcmZhY2UgaW4gZmF2b3Igb2YgZGlyZWN0
bHkNCmNhbGxpbmcgd3JpdGVfaXRlcigpIHdpdGggYSBjb25zdHJ1Y3RlZCBzeW5jaHJvbm91cyBr
aW9jYi4gQW5vdGhlciBpOTE1DQpjaGFuZ2UgcmVwbGFjZXMgYSBtYW51YWwgd3JpdGUgbG9vcCB3
aXRoIGtlcm5lbF93cml0ZSgpIGR1cmluZyBHRU0gc2htZW0NCm9iamVjdCBjcmVhdGlvbi4NCg0K
VGVzdGVkIHdpdGggZXh0NCBhbmQgaTkxNSBHRU0gd29ya2xvYWRzLg0KDQpUaGlzIHBhdGNoIHNl
cmllcyBpcyBiYXNlZCBvbiB0aGUgdmZzLTYuMTcubWlzYyBicmFuY2guDQoNCkNoYW5nZXMgc2lu
Y2UgdjI6DQotIENoYW5nZWQgYWxsIHdyaXRlX2JlZ2luL3dyaXRlX2VuZCBmdW5jdGlvbiBzaWdu
YXR1cmVzIHRvIHRha2UNCiAgY29uc3Qgc3RydWN0IGtpb2NiICogaW5zdGVhZCBvZiBzdHJ1Y3Qg
a2lvY2IgKi4NCi0gTWVyZ2VkIHRoZSB0d28gZXh0NCBwYXRjaGVzIGludG8gb25lIGZvciBjbGFy
aXR5Lg0KLSBVcGRhdGVkIHJldHVybiB0eXBlIGZyb20gaW50IHRvIHNzaXplX3QgZm9yIGtlcm5l
bF93cml0ZS4NCi0gTWlub3IgZm9ybWF0dGluZyBhbmQgY29tbWVudCBpbXByb3ZlbWVudHMuDQoN
Cg0KVGhhbmtzIHRvIE1hdHRoZXcgV2lsY294IGZvciBlYXJseSBmZWVkYmFjaywgYW5kIHRvIGFs
bCByZXZpZXdlcnMgZm9yDQpkZXRhaWxlZCBjb21tZW50cy4NCg0KVGFvdGFvIENoZW4gKDQpOg0K
ICBkcm0vaTkxNTogVXNlIGtlcm5lbF93cml0ZSgpIGluIHNobWVtIG9iamVjdCBjcmVhdGUNCiAg
ZHJtL2k5MTU6IFJlZmFjdG9yIHNobWVtX3B3cml0ZSgpIHRvIHVzZSBraW9jYiBhbmQgd3JpdGVf
aXRlcg0KICBmczogY2hhbmdlIHdyaXRlX2JlZ2luL3dyaXRlX2VuZCBpbnRlcmZhY2UgdG8gdGFr
ZSBzdHJ1Y3Qga2lvY2IgKg0KICBleHQ0OiBzdXBwb3J0IHVuY2FjaGVkIGJ1ZmZlcmVkIEkvTw0K
DQogRG9jdW1lbnRhdGlvbi9maWxlc3lzdGVtcy9sb2NraW5nLnJzdCAgICAgfCAgIDQgKy0NCiBE
b2N1bWVudGF0aW9uL2ZpbGVzeXN0ZW1zL3Zmcy5yc3QgICAgICAgICB8ICAgNiArLQ0KIGJsb2Nr
L2ZvcHMuYyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwgIDEzICsrLQ0KIGRyaXZlcnMv
Z3B1L2RybS9pOTE1L2dlbS9pOTE1X2dlbV9zaG1lbS5jIHwgMTE0ICsrKysrKy0tLS0tLS0tLS0t
LS0tLS0NCiBmcy9hZGZzL2lub2RlLmMgICAgICAgICAgICAgICAgICAgICAgICAgICB8ICAgOSAr
LQ0KIGZzL2FmZnMvZmlsZS5jICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwgIDI2ICsrLS0t
DQogZnMvYmNhY2hlZnMvZnMtaW8tYnVmZmVyZWQuYyAgICAgICAgICAgICAgfCAgIDQgKy0NCiBm
cy9iY2FjaGVmcy9mcy1pby1idWZmZXJlZC5oICAgICAgICAgICAgICB8ICAgNCArLQ0KIGZzL2Jm
cy9maWxlLmMgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwgICA3ICstDQogZnMvYnVmZmVy
LmMgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAgMjYgKystLS0NCiBmcy9jZXBoL2Fk
ZHIuYyAgICAgICAgICAgICAgICAgICAgICAgICAgICB8ICAxMCArLQ0KIGZzL2VjcnlwdGZzL21t
YXAuYyAgICAgICAgICAgICAgICAgICAgICAgIHwgIDEwICstDQogZnMvZXhmYXQvZmlsZS5jICAg
ICAgICAgICAgICAgICAgICAgICAgICAgfCAgMTUgKystDQogZnMvZXhmYXQvaW5vZGUuYyAgICAg
ICAgICAgICAgICAgICAgICAgICAgfCAgMTYgKy0tDQogZnMvZXh0Mi9pbm9kZS5jICAgICAgICAg
ICAgICAgICAgICAgICAgICAgfCAgMTEgKystDQogZnMvZXh0NC9maWxlLmMgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgfCAgIDMgKy0NCiBmcy9leHQ0L2lub2RlLmMgICAgICAgICAgICAgICAg
ICAgICAgICAgICB8ICAyNSArKystLQ0KIGZzL2YyZnMvZGF0YS5jICAgICAgICAgICAgICAgICAg
ICAgICAgICAgIHwgICA4ICstDQogZnMvZmF0L2lub2RlLmMgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgfCAgMTggKystLQ0KIGZzL2Z1c2UvZmlsZS5jICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIHwgIDE0ICsrLQ0KIGZzL2hmcy9oZnNfZnMuaCAgICAgICAgICAgICAgICAgICAgICAgICAg
IHwgICAyICstDQogZnMvaGZzL2lub2RlLmMgICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAg
IDQgKy0NCiBmcy9oZnNwbHVzL2hmc3BsdXNfZnMuaCAgICAgICAgICAgICAgICAgICB8ICAgNiAr
LQ0KIGZzL2hmc3BsdXMvaW5vZGUuYyAgICAgICAgICAgICAgICAgICAgICAgIHwgICA4ICstDQog
ZnMvaG9zdGZzL2hvc3Rmc19rZXJuLmMgICAgICAgICAgICAgICAgICAgfCAgIDggKy0NCiBmcy9o
cGZzL2ZpbGUuYyAgICAgICAgICAgICAgICAgICAgICAgICAgICB8ICAxOCArKy0tDQogZnMvaHVn
ZXRsYmZzL2lub2RlLmMgICAgICAgICAgICAgICAgICAgICAgfCAgIDkgKy0NCiBmcy9qZmZzMi9m
aWxlLmMgICAgICAgICAgICAgICAgICAgICAgICAgICB8ICAyOCArKystLS0NCiBmcy9qZnMvaW5v
ZGUuYyAgICAgICAgICAgICAgICAgICAgICAgICAgICB8ICAxNiArLS0NCiBmcy9saWJmcy5jICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICB8ICAxMSArKy0NCiBmcy9taW5peC9pbm9kZS5j
ICAgICAgICAgICAgICAgICAgICAgICAgICB8ICAgNyArLQ0KIGZzL25mcy9maWxlLmMgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIHwgICA4ICstDQogZnMvbmlsZnMyL2lub2RlLmMgICAgICAg
ICAgICAgICAgICAgICAgICAgfCAgIDggKy0NCiBmcy9udGZzMy9maWxlLmMgICAgICAgICAgICAg
ICAgICAgICAgICAgICB8ICAgNyArLQ0KIGZzL250ZnMzL2lub2RlLmMgICAgICAgICAgICAgICAg
ICAgICAgICAgIHwgICA3ICstDQogZnMvbnRmczMvbnRmc19mcy5oICAgICAgICAgICAgICAgICAg
ICAgICAgfCAgMTAgKy0NCiBmcy9vY2ZzMi9hb3BzLmMgICAgICAgICAgICAgICAgICAgICAgICAg
ICB8ICAgNiArLQ0KIGZzL29tZnMvZmlsZS5jICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwg
ICA3ICstDQogZnMvb3JhbmdlZnMvaW5vZGUuYyAgICAgICAgICAgICAgICAgICAgICAgfCAgMTYg
Ky0tDQogZnMvdWJpZnMvZmlsZS5jICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAgIDUgKy0N
CiBmcy91ZGYvaW5vZGUuYyAgICAgICAgICAgICAgICAgICAgICAgICAgICB8ICAxMSArKy0NCiBm
cy91ZnMvaW5vZGUuYyAgICAgICAgICAgICAgICAgICAgICAgICAgICB8ICAxNiArLS0NCiBmcy92
Ym94c2YvZmlsZS5jICAgICAgICAgICAgICAgICAgICAgICAgICB8ICAgNSArLQ0KIGluY2x1ZGUv
bGludXgvYnVmZmVyX2hlYWQuaCAgICAgICAgICAgICAgIHwgICA0ICstDQogaW5jbHVkZS9saW51
eC9mcy5oICAgICAgICAgICAgICAgICAgICAgICAgfCAgMTEgKystDQogbW0vZmlsZW1hcC5jICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAgIDQgKy0NCiBtbS9zaG1lbS5jICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICB8ICAxMiArLS0NCiA0NyBmaWxlcyBjaGFuZ2VkLCAzMTAg
aW5zZXJ0aW9ucygrKSwgMjg3IGRlbGV0aW9ucygtKQ0KDQotLSANCjIuMzQuMQ0K


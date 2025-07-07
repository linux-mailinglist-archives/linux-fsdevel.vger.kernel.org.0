Return-Path: <linux-fsdevel+bounces-54062-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 54CA5AFAC99
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Jul 2025 09:04:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE04C3BDE35
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Jul 2025 07:02:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5616C287501;
	Mon,  7 Jul 2025 07:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=didiglobal.com header.i=@didiglobal.com header.b="hDZZRLRC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx10.didiglobal.com (mx10.didiglobal.com [111.202.70.125])
	by smtp.subspace.kernel.org (Postfix) with SMTP id ED46B249F9;
	Mon,  7 Jul 2025 07:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.202.70.125
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751871662; cv=none; b=oZhZ3c2+HyIZEpFTn0qwhPsj8q9UsLA50jBc8s4V9PzoPwQj8/eQj/7PDVzNLH1nN6xMBnLqlOGy3NuYaV6NOtZv83e+8gVLPe+owcFiDN7FZqupw84pHXTFkOeLrCteQ4iBwASQg1WvXYOBwdLYWPfDM7eAcrOkDiQerS+UfWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751871662; c=relaxed/simple;
	bh=ZBvmJURUUdms2LfYgA8hvieU2JmYJfWJCDQdnPgLK2k=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=nsGKmkREf/p5Tk0L8j0zfdo0MUwNX4HndKUrx4+jh/ELPFOsjGykWqa9CTqKIvEuSkOFc5MpDoLy09g2fjNZgJrlstxW4TLlQDQg8n8/HGv9ZnezFy7r2gzOWdGI1QLGD65nOQQnBlNKaj+0CcrBHOS/n59Sk7bQ6XdrqaoOfMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=didiglobal.com; spf=pass smtp.mailfrom=didiglobal.com; dkim=pass (1024-bit key) header.d=didiglobal.com header.i=@didiglobal.com header.b=hDZZRLRC; arc=none smtp.client-ip=111.202.70.125
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=didiglobal.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=didiglobal.com
Received: from mail.didiglobal.com (unknown [10.79.65.19])
	by mx10.didiglobal.com (MailData Gateway V2.8.8) with ESMTPS id B1889188C79650;
	Mon,  7 Jul 2025 14:59:42 +0800 (CST)
Received: from BJ01-ACTMBX-08.didichuxing.com (10.79.64.15) by
 BJ02-ACTMBX-01.didichuxing.com (10.79.65.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Mon, 7 Jul 2025 15:00:26 +0800
Received: from BJ03-ACTMBX-07.didichuxing.com (10.79.71.34) by
 BJ01-ACTMBX-08.didichuxing.com (10.79.64.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Mon, 7 Jul 2025 15:00:26 +0800
Received: from BJ03-ACTMBX-07.didichuxing.com ([fe80::2e1a:dd47:6d25:287e]) by
 BJ03-ACTMBX-07.didichuxing.com ([fe80::2e1a:dd47:6d25:287e%7]) with mapi id
 15.02.1748.010; Mon, 7 Jul 2025 15:00:26 +0800
X-MD-Sfrom: chentaotao@didiglobal.com
X-MD-SrcIP: 10.79.65.19
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
Subject: [PATCH v4 0/5] fs: refactor write_begin/write_end and add ext4
 IOCB_DONTCACHE support
Thread-Topic: [PATCH v4 0/5] fs: refactor write_begin/write_end and add ext4
 IOCB_DONTCACHE support
Thread-Index: AQHb7wzQxCOGA2Mzlky+8l5HBw7WIQ==
Date: Mon, 7 Jul 2025 07:00:26 +0000
Message-ID: <20250707070023.206725-1-chentaotao@didiglobal.com>
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
	s=2025; t=1751871604;
	bh=ZBvmJURUUdms2LfYgA8hvieU2JmYJfWJCDQdnPgLK2k=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type;
	b=hDZZRLRCxUlS82LzdQ4fB4Y0eKw2lBLrAXEmPaY7/ErfOrBqqKbIIV1GtpZ7xp36E
	 AJODwDGundpAUDr5WoJ6L29Rib04hqXKwqQwiq2nPY2CX4V328evOTtb7ieZPkLEvD
	 B+C4JdEtmJaLlo6X7fjcuy8fLEFIJUiiBWEqsXNE=

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
Y2UgdjM6DQotIEFkZGVkIHdyaXRlX2JlZ2luX2dldF9mb2xpbygpIGhlbHBlciBhbmQgdXBkYXRl
ZCBleHQ0IHRvIHVzZSBpdC4NCi0gUmVmYWN0b3JlZCBleGZhdF9leHRlbmRfdmFsaWRfc2l6ZSgp
IHRvIHRha2UgaW5vZGUgaW5zdGVhZCBvZiBmaWxlLCBhbmQNCiAgcmVtb3ZlZCB1bm5lY2Vzc2Fy
eSBraW9jYiB1c2FnZSBpbiBleGZhdCBhbmQgbnRmcy4NCg0KVGFvdGFvIENoZW4gKDUpOg0KICBk
cm0vaTkxNTogVXNlIGtlcm5lbF93cml0ZSgpIGluIHNobWVtIG9iamVjdCBjcmVhdGUNCiAgZHJt
L2k5MTU6IFJlZmFjdG9yIHNobWVtX3B3cml0ZSgpIHRvIHVzZSBraW9jYiBhbmQgd3JpdGVfaXRl
cg0KICBmczogY2hhbmdlIHdyaXRlX2JlZ2luL3dyaXRlX2VuZCBpbnRlcmZhY2UgdG8gdGFrZSBz
dHJ1Y3Qga2lvY2IgKg0KICBtbS9maWxlbWFwOiBhZGQgd3JpdGVfYmVnaW5fZ2V0X2ZvbGlvKCkg
aGVscGVyIGZ1bmN0aW9uDQogIGV4dDQ6IHN1cHBvcnQgdW5jYWNoZWQgYnVmZmVyZWQgSS9PDQoN
CiBEb2N1bWVudGF0aW9uL2ZpbGVzeXN0ZW1zL2xvY2tpbmcucnN0ICAgICB8ICAgNCArLQ0KIERv
Y3VtZW50YXRpb24vZmlsZXN5c3RlbXMvdmZzLnJzdCAgICAgICAgIHwgICA2ICstDQogYmxvY2sv
Zm9wcy5jICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAgMTMgKystDQogZHJpdmVycy9n
cHUvZHJtL2k5MTUvZ2VtL2k5MTVfZ2VtX3NobWVtLmMgfCAxMTQgKysrKysrLS0tLS0tLS0tLS0t
LS0tLQ0KIGZzL2FkZnMvaW5vZGUuYyAgICAgICAgICAgICAgICAgICAgICAgICAgIHwgICA5ICst
DQogZnMvYWZmcy9maWxlLmMgICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAgMjYgKystLS0N
CiBmcy9iY2FjaGVmcy9mcy1pby1idWZmZXJlZC5jICAgICAgICAgICAgICB8ICAgNCArLQ0KIGZz
L2JjYWNoZWZzL2ZzLWlvLWJ1ZmZlcmVkLmggICAgICAgICAgICAgIHwgICA0ICstDQogZnMvYmZz
L2ZpbGUuYyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAgIDcgKy0NCiBmcy9idWZmZXIu
YyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB8ICAyNiArKy0tLQ0KIGZzL2NlcGgvYWRk
ci5jICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwgIDEwICstDQogZnMvZWNyeXB0ZnMvbW1h
cC5jICAgICAgICAgICAgICAgICAgICAgICAgfCAgMTAgKy0NCiBmcy9leGZhdC9maWxlLmMgICAg
ICAgICAgICAgICAgICAgICAgICAgICB8ICAxMSArLS0NCiBmcy9leGZhdC9pbm9kZS5jICAgICAg
ICAgICAgICAgICAgICAgICAgICB8ICAxNiArLS0NCiBmcy9leHQyL2lub2RlLmMgICAgICAgICAg
ICAgICAgICAgICAgICAgICB8ICAxMSArKy0NCiBmcy9leHQ0L2ZpbGUuYyAgICAgICAgICAgICAg
ICAgICAgICAgICAgICB8ICAgMyArLQ0KIGZzL2V4dDQvaW5vZGUuYyAgICAgICAgICAgICAgICAg
ICAgICAgICAgIHwgIDMwICsrKy0tLQ0KIGZzL2YyZnMvZGF0YS5jICAgICAgICAgICAgICAgICAg
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
ICAgICAgICAgICAgICB8ICAgNCArLQ0KIGZzL250ZnMzL2lub2RlLmMgICAgICAgICAgICAgICAg
ICAgICAgICAgIHwgICA3ICstDQogZnMvbnRmczMvbnRmc19mcy5oICAgICAgICAgICAgICAgICAg
ICAgICAgfCAgMTAgKy0NCiBmcy9vY2ZzMi9hb3BzLmMgICAgICAgICAgICAgICAgICAgICAgICAg
ICB8ICAgNiArLQ0KIGZzL29tZnMvZmlsZS5jICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwg
ICA3ICstDQogZnMvb3JhbmdlZnMvaW5vZGUuYyAgICAgICAgICAgICAgICAgICAgICAgfCAgMTYg
Ky0tDQogZnMvdWJpZnMvZmlsZS5jICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAgIDUgKy0N
CiBmcy91ZGYvaW5vZGUuYyAgICAgICAgICAgICAgICAgICAgICAgICAgICB8ICAxMSArKy0NCiBm
cy91ZnMvaW5vZGUuYyAgICAgICAgICAgICAgICAgICAgICAgICAgICB8ICAxNiArLS0NCiBmcy92
Ym94c2YvZmlsZS5jICAgICAgICAgICAgICAgICAgICAgICAgICB8ICAgNSArLQ0KIGluY2x1ZGUv
bGludXgvYnVmZmVyX2hlYWQuaCAgICAgICAgICAgICAgIHwgICA0ICstDQogaW5jbHVkZS9saW51
eC9mcy5oICAgICAgICAgICAgICAgICAgICAgICAgfCAgMTEgKystDQogaW5jbHVkZS9saW51eC9w
YWdlbWFwLmggICAgICAgICAgICAgICAgICAgfCAgIDMgKw0KIG1tL2ZpbGVtYXAuYyAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIHwgIDM0ICsrKysrKy0NCiBtbS9zaG1lbS5jICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICB8ICAxMiArLS0NCiA0OCBmaWxlcyBjaGFuZ2VkLCAzMzMg
aW5zZXJ0aW9ucygrKSwgMjk1IGRlbGV0aW9ucygtKQ0KDQotLSANCjIuMzQuMQ0K


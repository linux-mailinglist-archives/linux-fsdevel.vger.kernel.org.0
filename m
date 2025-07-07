Return-Path: <linux-fsdevel+bounces-54063-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D25DAFAC98
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Jul 2025 09:04:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B2F63BDDB2
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Jul 2025 07:02:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55E50287500;
	Mon,  7 Jul 2025 07:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=didiglobal.com header.i=@didiglobal.com header.b="gs2FiokD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx10.didiglobal.com (mx10.didiglobal.com [111.202.70.125])
	by smtp.subspace.kernel.org (Postfix) with SMTP id CDA3527AC37;
	Mon,  7 Jul 2025 07:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.202.70.125
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751871662; cv=none; b=VowB2kPCXyHwJ5q5419mRmu6Gtnk9dGRiJlZZhQvYAeoDXY5+u98SKbFLmi6VV2HwEMLkRRjZ/SIJpg9pXijnyd7PgkeN6DLRm0XC8/PxCuOhvZjpa3wod5Tb0ooAlTcPoHgvilMF74/6hBJK5ZMMhygZ1Kq53oNcFaGqVQvHgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751871662; c=relaxed/simple;
	bh=2JZTlbnqJn+HPRGwEk8v3nLMgt4gjj2zA82WVyb9JJY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:Content-Type:
	 MIME-Version; b=FjenZofOgbQRdcrJ3lauaubE9/xp3SeuqXEpaM1KhEjrg07eYWk+RizeN9dJYN6tTd8Ulfw4rHmw4aqUYu1yYSL4JS2SwEEj6Bc5z+GTsFS01fsRH9FDiP/l1Sl9vOIYTrBZfrPK33ceApaWKQBmrZzvh1RIlEQwVnnkSP2t984=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=didiglobal.com; spf=pass smtp.mailfrom=didiglobal.com; dkim=pass (1024-bit key) header.d=didiglobal.com header.i=@didiglobal.com header.b=gs2FiokD; arc=none smtp.client-ip=111.202.70.125
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=didiglobal.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=didiglobal.com
Received: from mail.didiglobal.com (unknown [10.79.64.21])
	by mx10.didiglobal.com (MailData Gateway V2.8.8) with ESMTPS id 73645188C71FFE;
	Mon,  7 Jul 2025 14:59:49 +0800 (CST)
Received: from BJ02-ACTMBX-09.didichuxing.com (10.79.65.18) by
 BJ01-ACTMBX-02.didichuxing.com (10.79.64.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Mon, 7 Jul 2025 15:00:33 +0800
Received: from BJ03-ACTMBX-07.didichuxing.com (10.79.71.34) by
 BJ02-ACTMBX-09.didichuxing.com (10.79.65.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Mon, 7 Jul 2025 15:00:33 +0800
Received: from BJ03-ACTMBX-07.didichuxing.com ([fe80::2e1a:dd47:6d25:287e]) by
 BJ03-ACTMBX-07.didichuxing.com ([fe80::2e1a:dd47:6d25:287e%7]) with mapi id
 15.02.1748.010; Mon, 7 Jul 2025 15:00:33 +0800
X-MD-Sfrom: chentaotao@didiglobal.com
X-MD-SrcIP: 10.79.64.21
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
Subject: [PATCH v4 4/5] mm/filemap: add write_begin_get_folio() helper
 function
Thread-Topic: [PATCH v4 4/5] mm/filemap: add write_begin_get_folio() helper
 function
Thread-Index: AQHb7wzV/NCTl0Y/WEyIyiHtat/IIg==
Date: Mon, 7 Jul 2025 07:00:33 +0000
Message-ID: <20250707070023.206725-5-chentaotao@didiglobal.com>
In-Reply-To: <20250707070023.206725-1-chentaotao@didiglobal.com>
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
	s=2025; t=1751871611;
	bh=2JZTlbnqJn+HPRGwEk8v3nLMgt4gjj2zA82WVyb9JJY=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type;
	b=gs2FiokDPwfz7bfDI0bB5uIa5k9gi5N5G+EexPh+mke8Fok5OqljHJKhOAsuPL2aS
	 hCUWofXRCPpoglP3NDps/SqOfwbwNF1Y84LVrHF6os5mlxXS83LYi9X9gb7R/bdujH
	 znYVuNrX9Wxddr/bxsd5aRHBoV+ED4vmSSaTBYbY=

RnJvbTogVGFvdGFvIENoZW4gPGNoZW50YW90YW9AZGlkaWdsb2JhbC5jb20+DQoNCkFkZCB3cml0
ZV9iZWdpbl9nZXRfZm9saW8oKSB0byBzaW1wbGlmeSB0aGUgY29tbW9uIGZvbGlvIGxvb2t1cCBs
b2dpYw0KdXNlZCBieSBmaWxlc3lzdGVtIC0+d3JpdGVfYmVnaW4oKSBpbXBsZW1lbnRhdGlvbnMu
DQoNClRoaXMgaGVscGVyIHdyYXBzIF9fZmlsZW1hcF9nZXRfZm9saW8oKSB3aXRoIGNvbW1vbiBm
bGFncyBzdWNoIGFzDQpGR1BfV1JJVEVCRUdJTiwgY29uZGl0aW9uYWwgRkdQX0RPTlRDQUNIRSwg
YW5kIHNldCBmb2xpbyBvcmRlciBiYXNlZA0Kb24gdGhlIHdyaXRlIGxlbmd0aC4NCg0KUGFydCBv
ZiBhIHNlcmllcyByZWZhY3RvcmluZyBhZGRyZXNzX3NwYWNlX29wZXJhdGlvbnMgd3JpdGVfYmVn
aW4gYW5kDQp3cml0ZV9lbmQgY2FsbGJhY2tzIHRvIHVzZSBzdHJ1Y3Qga2lvY2IgZm9yIHBhc3Np
bmcgd3JpdGUgY29udGV4dCBhbmQNCmZsYWdzLg0KDQpTaWduZWQtb2ZmLWJ5OiBUYW90YW8gQ2hl
biA8Y2hlbnRhb3Rhb0BkaWRpZ2xvYmFsLmNvbT4NCi0tLQ0KIGluY2x1ZGUvbGludXgvcGFnZW1h
cC5oIHwgIDMgKysrDQogbW0vZmlsZW1hcC5jICAgICAgICAgICAgfCAzMCArKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysNCiAyIGZpbGVzIGNoYW5nZWQsIDMzIGluc2VydGlvbnMoKykNCg0K
ZGlmZiAtLWdpdCBhL2luY2x1ZGUvbGludXgvcGFnZW1hcC5oIGIvaW5jbHVkZS9saW51eC9wYWdl
bWFwLmgNCmluZGV4IGU2M2ZiZmJkNWIwZi4uY2JmODUzOWJhMTFiIDEwMDY0NA0KLS0tIGEvaW5j
bHVkZS9saW51eC9wYWdlbWFwLmgNCisrKyBiL2luY2x1ZGUvbGludXgvcGFnZW1hcC5oDQpAQCAt
NzQ5LDYgKzc0OSw5IEBAIHN0cnVjdCBmb2xpbyAqX19maWxlbWFwX2dldF9mb2xpbyhzdHJ1Y3Qg
YWRkcmVzc19zcGFjZSAqbWFwcGluZywgcGdvZmZfdCBpbmRleCwNCiAJCWZnZl90IGZncF9mbGFn
cywgZ2ZwX3QgZ2ZwKTsNCiBzdHJ1Y3QgcGFnZSAqcGFnZWNhY2hlX2dldF9wYWdlKHN0cnVjdCBh
ZGRyZXNzX3NwYWNlICptYXBwaW5nLCBwZ29mZl90IGluZGV4LA0KIAkJZmdmX3QgZmdwX2ZsYWdz
LCBnZnBfdCBnZnApOw0KK3N0cnVjdCBmb2xpbyAqd3JpdGVfYmVnaW5fZ2V0X2ZvbGlvKGNvbnN0
IHN0cnVjdCBraW9jYiAqaW9jYiwNCisJCQkJICAgIHN0cnVjdCBhZGRyZXNzX3NwYWNlICptYXBw
aW5nLA0KKwkJCQkgICAgcGdvZmZfdCBpbmRleCwgc2l6ZV90IGxlbik7DQogDQogLyoqDQogICog
ZmlsZW1hcF9nZXRfZm9saW8gLSBGaW5kIGFuZCBnZXQgYSBmb2xpby4NCmRpZmYgLS1naXQgYS9t
bS9maWxlbWFwLmMgYi9tbS9maWxlbWFwLmMNCmluZGV4IGJhMDg5ZDc1ZmM4Ni4uOTUyMGY2NWMy
ODdhIDEwMDY0NA0KLS0tIGEvbW0vZmlsZW1hcC5jDQorKysgYi9tbS9maWxlbWFwLmMNCkBAIC0y
MDI2LDYgKzIwMjYsMzYgQEAgc3RydWN0IGZvbGlvICpfX2ZpbGVtYXBfZ2V0X2ZvbGlvKHN0cnVj
dCBhZGRyZXNzX3NwYWNlICptYXBwaW5nLCBwZ29mZl90IGluZGV4LA0KIH0NCiBFWFBPUlRfU1lN
Qk9MKF9fZmlsZW1hcF9nZXRfZm9saW8pOw0KIA0KKw0KKy8qKg0KKyAqIHdyaXRlX2JlZ2luX2dl
dF9mb2xpbyAtIEdldCBmb2xpbyBmb3Igd3JpdGVfYmVnaW4gd2l0aCBmbGFncw0KKyAqIEBpb2Ni
OiBraW9jYiBwYXNzZWQgZnJvbSB3cml0ZV9iZWdpbiAobWF5IGJlIE5VTEwpDQorICogQG1hcHBp
bmc6IHRoZSBhZGRyZXNzIHNwYWNlIHRvIHNlYXJjaCBpbg0KKyAqIEBpbmRleDogcGFnZSBjYWNo
ZSBpbmRleA0KKyAqIEBsZW46IGxlbmd0aCBvZiBkYXRhIGJlaW5nIHdyaXR0ZW4NCisgKg0KKyAq
IFRoaXMgaXMgYSBoZWxwZXIgZm9yIGZpbGVzeXN0ZW0gd3JpdGVfYmVnaW4oKSBpbXBsZW1lbnRh
dGlvbnMuDQorICogSXQgd3JhcHMgX19maWxlbWFwX2dldF9mb2xpbygpLCBzZXR0aW5nIGFwcHJv
cHJpYXRlIGZsYWdzIGluDQorICogdGhlIHdyaXRlIGJlZ2luIGNvbnRleHQuDQorICoNCisgKiBS
ZXR1cm5zIGEgZm9saW8gb3IgYW4gRVJSX1BUUi4NCisgKi8NCitzdHJ1Y3QgZm9saW8gKndyaXRl
X2JlZ2luX2dldF9mb2xpbyhjb25zdCBzdHJ1Y3Qga2lvY2IgKmlvY2IsDQorCQkJCSAgICBzdHJ1
Y3QgYWRkcmVzc19zcGFjZSAqbWFwcGluZywNCisJCQkJICAgIHBnb2ZmX3QgaW5kZXgsIHNpemVf
dCBsZW4pDQorew0KKwlmZ2ZfdCBmZ3BfZmxhZ3MgPSBGR1BfV1JJVEVCRUdJTjsNCisNCisJZmdw
X2ZsYWdzIHw9IGZnZl9zZXRfb3JkZXIobGVuKTsNCisNCisJaWYgKGlvY2IgJiYgaW9jYi0+a2lf
ZmxhZ3MgJiBJT0NCX0RPTlRDQUNIRSkNCisJCWZncF9mbGFncyB8PSBGR1BfRE9OVENBQ0hFOw0K
Kw0KKwlyZXR1cm4gX19maWxlbWFwX2dldF9mb2xpbyhtYXBwaW5nLCBpbmRleCwgZmdwX2ZsYWdz
LA0KKwkJCQkgICBtYXBwaW5nX2dmcF9tYXNrKG1hcHBpbmcpKTsNCit9DQorRVhQT1JUX1NZTUJP
TCh3cml0ZV9iZWdpbl9nZXRfZm9saW8pOw0KKw0KIHN0YXRpYyBpbmxpbmUgc3RydWN0IGZvbGlv
ICpmaW5kX2dldF9lbnRyeShzdHJ1Y3QgeGFfc3RhdGUgKnhhcywgcGdvZmZfdCBtYXgsDQogCQl4
YV9tYXJrX3QgbWFyaykNCiB7DQotLSANCjIuMzQuMQ0K


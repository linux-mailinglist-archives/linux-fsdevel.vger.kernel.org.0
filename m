Return-Path: <linux-fsdevel+bounces-52753-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D473AE6492
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jun 2025 14:20:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 26094165539
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jun 2025 12:19:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DC96299951;
	Tue, 24 Jun 2025 12:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=didiglobal.com header.i=@didiglobal.com header.b="ExvA9iRQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx10.didiglobal.com (mx10.didiglobal.com [111.202.70.125])
	by smtp.subspace.kernel.org (Postfix) with SMTP id E68E4291C2D;
	Tue, 24 Jun 2025 12:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.202.70.125
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750767338; cv=none; b=rwYQXQieAOQ4n8vCoFFocmtwRPMxF4gPatwa18Yeabh54ilOz3Um7oJNaU8s482dus0QPAbkrRIGBbE/p3bJJ2djed7F3bwLflyVEyaoHH/0YFJq1RCghy3eOw2zxxVNnnmxeuzun2E15GtDEhNvSzD63V50Lnd3ayj29VNP2t0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750767338; c=relaxed/simple;
	bh=HYU97oIn0cnVusHQfmzKHAF4vcuj7pXpFBHYR5LJCN0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:Content-Type:
	 MIME-Version; b=T8NQTKE3ySUTWbI1LmUln0x9myxUvkMpCnnaWC07yTfd+gmyA7q5WIQs/+5/6ntDb/rS21pIg1smiNG1SE/BVkh/Glu4efroE6lXXW8jtjL9EiypcxnYkAMMjJ+9HDeq/hHCrvoMiob6+W2u85bZUoBqgb3xWMcz6nfAPjJOThA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=didiglobal.com; spf=pass smtp.mailfrom=didiglobal.com; dkim=pass (1024-bit key) header.d=didiglobal.com header.i=@didiglobal.com header.b=ExvA9iRQ; arc=none smtp.client-ip=111.202.70.125
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=didiglobal.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=didiglobal.com
Received: from mail.didiglobal.com (unknown [10.79.64.21])
	by mx10.didiglobal.com (MailData Gateway V2.8.8) with ESMTPS id CCE7B1808ACAE2;
	Tue, 24 Jun 2025 20:11:22 +0800 (CST)
Received: from BJ03-ACTMBX-09.didichuxing.com (10.79.71.36) by
 BJ01-ACTMBX-02.didichuxing.com (10.79.64.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Tue, 24 Jun 2025 20:12:05 +0800
Received: from BJ03-ACTMBX-07.didichuxing.com (10.79.71.34) by
 BJ03-ACTMBX-09.didichuxing.com (10.79.71.36) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Tue, 24 Jun 2025 20:12:04 +0800
Received: from BJ03-ACTMBX-07.didichuxing.com ([fe80::b00b:de35:2067:9787]) by
 BJ03-ACTMBX-07.didichuxing.com ([fe80::b00b:de35:2067:9787%7]) with mapi id
 15.02.1748.010; Tue, 24 Jun 2025 20:12:04 +0800
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
	=?gb2312?B?s8LMzszOIFRhb3RhbyBDaGVu?= <chentaotao@didiglobal.com>
Subject: [PATCH v2 1/5] drm/i915: Use kernel_write() in shmem object create
Thread-Topic: [PATCH v2 1/5] drm/i915: Use kernel_write() in shmem object
 create
Thread-Index: AQHb5QEySZaHYPkPAEOiJqqTdRuvag==
Date: Tue, 24 Jun 2025 12:12:04 +0000
Message-ID: <20250624121149.2927-2-chentaotao@didiglobal.com>
In-Reply-To: <20250624121149.2927-1-chentaotao@didiglobal.com>
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
	s=2025; t=1750767104;
	bh=HYU97oIn0cnVusHQfmzKHAF4vcuj7pXpFBHYR5LJCN0=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type;
	b=ExvA9iRQ48UNJHdn2HJmucGbjVBK6iaRuGf3d3jl4q7HSZMM/2JCQ2DOEvQdbvmUx
	 w/KHs9wUtgV8OpV2/A7iliZgFTh9ug/Do0DhJl/F9wIZdiqTuENdalZvn5acDHTyEG
	 PRXBL55CwnXiRd5I4oRsM2Tf6B28t5W7wZGtDa0o=

RnJvbTogVGFvdGFvIENoZW4gPGNoZW50YW90YW9AZGlkaWdsb2JhbC5jb20+DQoNClJlcGxhY2Ug
dGhlIHdyaXRlX2JlZ2luL3dyaXRlX2VuZCBsb29wIGluDQppOTE1X2dlbV9vYmplY3RfY3JlYXRl
X3NobWVtX2Zyb21fZGF0YSgpIHdpdGggY2FsbCB0byBrZXJuZWxfd3JpdGUoKS4NCg0KVGhpcyBm
dW5jdGlvbiBpbml0aWFsaXplcyBzaG1lbS1iYWNrZWQgR0VNIG9iamVjdHMuIGtlcm5lbF93cml0
ZSgpDQpzaW1wbGlmaWVzIHRoZSBjb2RlIGJ5IHJlbW92aW5nIG1hbnVhbCBmb2xpbyBoYW5kbGlu
Zy4NCg0KUGFydCBvZiBhIHNlcmllcyByZWZhY3RvcmluZyBhZGRyZXNzX3NwYWNlX29wZXJhdGlv
bnMgd3JpdGVfYmVnaW4gYW5kDQp3cml0ZV9lbmQgY2FsbGJhY2tzIHRvIHVzZSBzdHJ1Y3Qga2lv
Y2IgZm9yIHBhc3Npbmcgd3JpdGUgY29udGV4dCBhbmQNCmZsYWdzLg0KDQpTaWduZWQtb2ZmLWJ5
OiBUYW90YW8gQ2hlbiA8Y2hlbnRhb3Rhb0BkaWRpZ2xvYmFsLmNvbT4NCi0tLQ0KIGRyaXZlcnMv
Z3B1L2RybS9pOTE1L2dlbS9pOTE1X2dlbV9zaG1lbS5jIHwgMzEgKysrKysrLS0tLS0tLS0tLS0t
LS0tLS0NCiAxIGZpbGUgY2hhbmdlZCwgOCBpbnNlcnRpb25zKCspLCAyMyBkZWxldGlvbnMoLSkN
Cg0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9pOTE1L2dlbS9pOTE1X2dlbV9zaG1lbS5j
IGIvZHJpdmVycy9ncHUvZHJtL2k5MTUvZ2VtL2k5MTVfZ2VtX3NobWVtLmMNCmluZGV4IDE5YTNl
YjgyZGM2YS4uZDA4YWRlOTM0ZDE1IDEwMDY0NA0KLS0tIGEvZHJpdmVycy9ncHUvZHJtL2k5MTUv
Z2VtL2k5MTVfZ2VtX3NobWVtLmMNCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9pOTE1L2dlbS9pOTE1
X2dlbV9zaG1lbS5jDQpAQCAtNjM3LDggKzYzNyw3IEBAIGk5MTVfZ2VtX29iamVjdF9jcmVhdGVf
c2htZW1fZnJvbV9kYXRhKHN0cnVjdCBkcm1faTkxNV9wcml2YXRlICppOTE1LA0KIHsNCiAJc3Ry
dWN0IGRybV9pOTE1X2dlbV9vYmplY3QgKm9iajsNCiAJc3RydWN0IGZpbGUgKmZpbGU7DQotCWNv
bnN0IHN0cnVjdCBhZGRyZXNzX3NwYWNlX29wZXJhdGlvbnMgKmFvcHM7DQotCWxvZmZfdCBwb3M7
DQorCWxvZmZfdCBwb3MgPSAwOw0KIAlpbnQgZXJyOw0KIA0KIAlHRU1fV0FSTl9PTihJU19ER0ZY
KGk5MTUpKTsNCkBAIC02NDksMjkgKzY0OCwxNSBAQCBpOTE1X2dlbV9vYmplY3RfY3JlYXRlX3No
bWVtX2Zyb21fZGF0YShzdHJ1Y3QgZHJtX2k5MTVfcHJpdmF0ZSAqaTkxNSwNCiAJR0VNX0JVR19P
TihvYmotPndyaXRlX2RvbWFpbiAhPSBJOTE1X0dFTV9ET01BSU5fQ1BVKTsNCiANCiAJZmlsZSA9
IG9iai0+YmFzZS5maWxwOw0KLQlhb3BzID0gZmlsZS0+Zl9tYXBwaW5nLT5hX29wczsNCi0JcG9z
ID0gMDsNCi0JZG8gew0KLQkJdW5zaWduZWQgaW50IGxlbiA9IG1pbl90KHR5cGVvZihzaXplKSwg
c2l6ZSwgUEFHRV9TSVpFKTsNCi0JCXN0cnVjdCBmb2xpbyAqZm9saW87DQotCQl2b2lkICpmc2Rh
dGE7DQotDQotCQllcnIgPSBhb3BzLT53cml0ZV9iZWdpbihmaWxlLCBmaWxlLT5mX21hcHBpbmcs
IHBvcywgbGVuLA0KLQkJCQkJJmZvbGlvLCAmZnNkYXRhKTsNCi0JCWlmIChlcnIgPCAwKQ0KLQkJ
CWdvdG8gZmFpbDsNCisJZXJyID0ga2VybmVsX3dyaXRlKGZpbGUsIGRhdGEsIHNpemUsICZwb3Mp
Ow0KIA0KLQkJbWVtY3B5X3RvX2ZvbGlvKGZvbGlvLCBvZmZzZXRfaW5fZm9saW8oZm9saW8sIHBv
cyksIGRhdGEsIGxlbik7DQorCWlmIChlcnIgPCAwKQ0KKwkJZ290byBmYWlsOw0KIA0KLQkJZXJy
ID0gYW9wcy0+d3JpdGVfZW5kKGZpbGUsIGZpbGUtPmZfbWFwcGluZywgcG9zLCBsZW4sIGxlbiwN
Ci0JCQkJICAgICAgZm9saW8sIGZzZGF0YSk7DQotCQlpZiAoZXJyIDwgMCkNCi0JCQlnb3RvIGZh
aWw7DQotDQotCQlzaXplIC09IGxlbjsNCi0JCWRhdGEgKz0gbGVuOw0KLQkJcG9zICs9IGxlbjsN
Ci0JfSB3aGlsZSAoc2l6ZSk7DQorCWlmIChlcnIgIT0gc2l6ZSkgew0KKwkJZXJyID0gLUVJTzsN
CisJCWdvdG8gZmFpbDsNCisJfQ0KIA0KIAlyZXR1cm4gb2JqOw0KIA0KLS0gDQoyLjM0LjENCg==


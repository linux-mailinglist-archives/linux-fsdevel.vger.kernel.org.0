Return-Path: <linux-fsdevel+bounces-55133-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 127B9B071EE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Jul 2025 11:37:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 502381C22AF2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Jul 2025 09:38:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 519332F3634;
	Wed, 16 Jul 2025 09:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=didiglobal.com header.i=@didiglobal.com header.b="keOE2b5W"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx10.didiglobal.com (mx10.didiglobal.com [111.202.70.125])
	by smtp.subspace.kernel.org (Postfix) with SMTP id 08E3C2F0E49;
	Wed, 16 Jul 2025 09:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.202.70.125
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752658600; cv=none; b=U34W8vg540ntgP2v7TLAArnINH9WpfI2cZsBRN8M3tuKpXdn32U9F9H/jGYfgG4Huzi/vGziDdAGtLFxIzk7QEpZQVu7vl57aXHaT6WSzXsf7KPgGUTbskCQV2DpnFAiT2zDoGIr1I5oVmJHzla/2PHTITD15V3C6RTSZvOSRrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752658600; c=relaxed/simple;
	bh=8LcRUuagwMN/lAroXnJjsVjKDAmcYSyShlGR6KAKpxo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:Content-Type:
	 MIME-Version; b=fqeRVSf6el5NyesVsPy0rMJIZopkl0+mHC22obfzjTB83S6FEMMw0qZBUNsAqoDR+daxAykmMqiAqaTECkh3y9AQjh634grZmKsj9jWtmmpCXJ6V/Ce7+ZfvcMcBSeWjkd5HSrFmXJVnXB+9X7qoI0A1azGs1NFGpppJ3jOME88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=didiglobal.com; spf=pass smtp.mailfrom=didiglobal.com; dkim=pass (1024-bit key) header.d=didiglobal.com header.i=@didiglobal.com header.b=keOE2b5W; arc=none smtp.client-ip=111.202.70.125
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=didiglobal.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=didiglobal.com
Received: from mail.didiglobal.com (unknown [10.79.71.38])
	by mx10.didiglobal.com (MailData Gateway V2.8.8) with ESMTPS id A71DB18BE22D3C;
	Wed, 16 Jul 2025 17:35:19 +0800 (CST)
Received: from BJ03-ACTMBX-08.didichuxing.com (10.79.71.35) by
 BJ03-ACTMBX-02.didichuxing.com (10.79.71.38) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Wed, 16 Jul 2025 17:36:05 +0800
Received: from BJ03-ACTMBX-07.didichuxing.com (10.79.71.34) by
 BJ03-ACTMBX-08.didichuxing.com (10.79.71.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Wed, 16 Jul 2025 17:36:04 +0800
Received: from BJ03-ACTMBX-07.didichuxing.com ([fe80::2e1a:dd47:6d25:287e]) by
 BJ03-ACTMBX-07.didichuxing.com ([fe80::2e1a:dd47:6d25:287e%7]) with mapi id
 15.02.1748.010; Wed, 16 Jul 2025 17:36:04 +0800
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
Subject: [PATCH v6 2/5] drm/i915: Refactor shmem_pwrite() to use kiocb and
 write_iter
Thread-Topic: [PATCH v6 2/5] drm/i915: Refactor shmem_pwrite() to use kiocb
 and write_iter
Thread-Index: AQHb9jUMCjFd1gw0iU2Rz2Fo6Yf3qg==
Date: Wed, 16 Jul 2025 09:36:04 +0000
Message-ID: <20250716093559.217344-3-chentaotao@didiglobal.com>
In-Reply-To: <20250716093559.217344-1-chentaotao@didiglobal.com>
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
	s=2025; t=1752658541;
	bh=8LcRUuagwMN/lAroXnJjsVjKDAmcYSyShlGR6KAKpxo=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type;
	b=keOE2b5WGIkxYc2GxRzGsK+z7NTZyRwJrrvsLISIzTPR4y285zcFpO8glpl3gXmk4
	 R/T8+ZQkQxERQBzh20nWLgUAeRxpRNzpoftqnkYnJtGwtqfRPHMF02/H0rOjnvWOd/
	 dihJmgBoE7p7L7gRQH+1dAsNIy0j1I25M6bjRPEk=

RnJvbTogVGFvdGFvIENoZW4gPGNoZW50YW90YW9AZGlkaWdsb2JhbC5jb20+DQoNClJlZmFjdG9y
cyBzaG1lbV9wd3JpdGUoKSB0byByZXBsYWNlIHRoZSAtPndyaXRlX2JlZ2luL2VuZCBsb2dpYw0K
d2l0aCBhIHdyaXRlX2l0ZXItYmFzZWQgaW1wbGVtZW50YXRpb24gdXNpbmcga2lvY2IgYW5kIGlv
dl9pdGVyLg0KDQpXaGlsZSBrZXJuZWxfd3JpdGUoKSB3YXMgY29uc2lkZXJlZCwgaXQgY2F1c2Vk
IGFib3V0IDUwJSBwZXJmb3JtYW5jZQ0KcmVncmVzc2lvbi4gdmZzX3dyaXRlKCkgaXMgbm90IGV4
cG9ydGVkIGZvciBrZXJuZWwgdXNlLiBUaGVyZWZvcmUsDQpmaWxlLT5mX29wLT53cml0ZV9pdGVy
KCkgaXMgY2FsbGVkIGRpcmVjdGx5IHdpdGggYSBzeW5jaHJvbm91c2x5DQppbml0aWFsaXplZCBr
aW9jYiB0byBwcmVzZXJ2ZSBwZXJmb3JtYW5jZSBhbmQgcmVtb3ZlIHdyaXRlX2JlZ2luDQp1c2Fn
ZS4NCg0KUGVyZm9ybWFuY2UgcmVzdWx0cyB1c2UgZ2VtX3B3cml0ZSBvbiBJbnRlbCBDUFUgaTct
MTA3MDANCihhdmVyYWdlIG9mIDEwIHJ1bnMpOg0KDQotIC4vZ2VtX3B3cml0ZSAtLXJ1bi1zdWJ0
ZXN0IGJlbmNoIC1zIDE2Mzg0DQogIEJlZm9yZTogMC4yMDVzLCBBZnRlcjogMC4yMTRzDQoNCi0g
Li9nZW1fcHdyaXRlIC0tcnVuLXN1YnRlc3QgYmVuY2ggLXMgNTI0Mjg4DQogIEJlZm9yZTogNi4x
MDIxcywgQWZ0ZXI6IDQuODA0N3MNCg0KUGFydCBvZiBhIHNlcmllcyByZWZhY3RvcmluZyBhZGRy
ZXNzX3NwYWNlX29wZXJhdGlvbnMgd3JpdGVfYmVnaW4gYW5kDQp3cml0ZV9lbmQgY2FsbGJhY2tz
IHRvIHVzZSBzdHJ1Y3Qga2lvY2IgZm9yIHBhc3Npbmcgd3JpdGUgY29udGV4dCBhbmQNCmZsYWdz
Lg0KDQpTaWduZWQtb2ZmLWJ5OiBUYW90YW8gQ2hlbiA8Y2hlbnRhb3Rhb0BkaWRpZ2xvYmFsLmNv
bT4NCi0tLQ0KIGRyaXZlcnMvZ3B1L2RybS9pOTE1L2dlbS9pOTE1X2dlbV9zaG1lbS5jIHwgODIg
KysrKysrLS0tLS0tLS0tLS0tLS0tLS0NCiAxIGZpbGUgY2hhbmdlZCwgMjIgaW5zZXJ0aW9ucygr
KSwgNjAgZGVsZXRpb25zKC0pDQoNCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vaTkxNS9n
ZW0vaTkxNV9nZW1fc2htZW0uYyBiL2RyaXZlcnMvZ3B1L2RybS9pOTE1L2dlbS9pOTE1X2dlbV9z
aG1lbS5jDQppbmRleCAxZThmNjZhYzQ4Y2EuLjljYmIwZjY4YTViYiAxMDA2NDQNCi0tLSBhL2Ry
aXZlcnMvZ3B1L2RybS9pOTE1L2dlbS9pOTE1X2dlbV9zaG1lbS5jDQorKysgYi9kcml2ZXJzL2dw
dS9kcm0vaTkxNS9nZW0vaTkxNV9nZW1fc2htZW0uYw0KQEAgLTYsNiArNiw3IEBADQogI2luY2x1
ZGUgPGxpbnV4L3BhZ2V2ZWMuaD4NCiAjaW5jbHVkZSA8bGludXgvc2htZW1fZnMuaD4NCiAjaW5j
bHVkZSA8bGludXgvc3dhcC5oPg0KKyNpbmNsdWRlIDxsaW51eC91aW8uaD4NCiANCiAjaW5jbHVk
ZSA8ZHJtL2RybV9jYWNoZS5oPg0KIA0KQEAgLTQwMCwxMiArNDAxLDEyIEBAIHN0YXRpYyBpbnQN
CiBzaG1lbV9wd3JpdGUoc3RydWN0IGRybV9pOTE1X2dlbV9vYmplY3QgKm9iaiwNCiAJICAgICBj
b25zdCBzdHJ1Y3QgZHJtX2k5MTVfZ2VtX3B3cml0ZSAqYXJnKQ0KIHsNCi0Jc3RydWN0IGFkZHJl
c3Nfc3BhY2UgKm1hcHBpbmcgPSBvYmotPmJhc2UuZmlscC0+Zl9tYXBwaW5nOw0KLQljb25zdCBz
dHJ1Y3QgYWRkcmVzc19zcGFjZV9vcGVyYXRpb25zICphb3BzID0gbWFwcGluZy0+YV9vcHM7DQog
CWNoYXIgX191c2VyICp1c2VyX2RhdGEgPSB1NjRfdG9fdXNlcl9wdHIoYXJnLT5kYXRhX3B0cik7
DQotCXU2NCByZW1haW47DQotCWxvZmZfdCBwb3M7DQotCXVuc2lnbmVkIGludCBwZzsNCisJc3Ry
dWN0IGZpbGUgKmZpbGUgPSBvYmotPmJhc2UuZmlscDsNCisJc3RydWN0IGtpb2NiIGtpb2NiOw0K
KwlzdHJ1Y3QgaW92X2l0ZXIgaXRlcjsNCisJc3NpemVfdCB3cml0dGVuOw0KKwl1NjQgc2l6ZSA9
IGFyZy0+c2l6ZTsNCiANCiAJLyogQ2FsbGVyIGFscmVhZHkgdmFsaWRhdGVkIHVzZXIgYXJncyAq
Lw0KIAlHRU1fQlVHX09OKCFhY2Nlc3Nfb2sodXNlcl9kYXRhLCBhcmctPnNpemUpKTsNCkBAIC00
MjgsNjMgKzQyOSwyNCBAQCBzaG1lbV9wd3JpdGUoc3RydWN0IGRybV9pOTE1X2dlbV9vYmplY3Qg
Km9iaiwNCiAJaWYgKG9iai0+bW0ubWFkdiAhPSBJOTE1X01BRFZfV0lMTE5FRUQpDQogCQlyZXR1
cm4gLUVGQVVMVDsNCiANCi0JLyoNCi0JICogQmVmb3JlIHRoZSBwYWdlcyBhcmUgaW5zdGFudGlh
dGVkIHRoZSBvYmplY3QgaXMgdHJlYXRlZCBhcyBiZWluZw0KLQkgKiBpbiB0aGUgQ1BVIGRvbWFp
bi4gVGhlIHBhZ2VzIHdpbGwgYmUgY2xmbHVzaGVkIGFzIHJlcXVpcmVkIGJlZm9yZQ0KLQkgKiB1
c2UsIGFuZCB3ZSBjYW4gZnJlZWx5IHdyaXRlIGludG8gdGhlIHBhZ2VzIGRpcmVjdGx5LiBJZiB1
c2Vyc3BhY2UNCi0JICogcmFjZXMgcHdyaXRlIHdpdGggYW55IG90aGVyIG9wZXJhdGlvbjsgY29y
cnVwdGlvbiB3aWxsIGVuc3VlIC0NCi0JICogdGhhdCBpcyB1c2Vyc3BhY2UncyBwcmVyb2dhdGl2
ZSENCi0JICovDQorCWlmIChzaXplID4gTUFYX1JXX0NPVU5UKQ0KKwkJcmV0dXJuIC1FRkJJRzsN
CiANCi0JcmVtYWluID0gYXJnLT5zaXplOw0KLQlwb3MgPSBhcmctPm9mZnNldDsNCi0JcGcgPSBv
ZmZzZXRfaW5fcGFnZShwb3MpOw0KKwlpZiAoIWZpbGUtPmZfb3AtPndyaXRlX2l0ZXIpDQorCQly
ZXR1cm4gLUVJTlZBTDsNCiANCi0JZG8gew0KLQkJdW5zaWduZWQgaW50IGxlbiwgdW53cml0dGVu
Ow0KLQkJc3RydWN0IGZvbGlvICpmb2xpbzsNCi0JCXZvaWQgKmRhdGEsICp2YWRkcjsNCi0JCWlu
dCBlcnI7DQotCQljaGFyIF9fbWF5YmVfdW51c2VkIGM7DQotDQotCQlsZW4gPSBQQUdFX1NJWkUg
LSBwZzsNCi0JCWlmIChsZW4gPiByZW1haW4pDQotCQkJbGVuID0gcmVtYWluOw0KLQ0KLQkJLyog
UHJlZmF1bHQgdGhlIHVzZXIgcGFnZSB0byByZWR1Y2UgcG90ZW50aWFsIHJlY3Vyc2lvbiAqLw0K
LQkJZXJyID0gX19nZXRfdXNlcihjLCB1c2VyX2RhdGEpOw0KLQkJaWYgKGVycikNCi0JCQlyZXR1
cm4gZXJyOw0KLQ0KLQkJZXJyID0gX19nZXRfdXNlcihjLCB1c2VyX2RhdGEgKyBsZW4gLSAxKTsN
Ci0JCWlmIChlcnIpDQotCQkJcmV0dXJuIGVycjsNCi0NCi0JCWVyciA9IGFvcHMtPndyaXRlX2Jl
Z2luKG9iai0+YmFzZS5maWxwLCBtYXBwaW5nLCBwb3MsIGxlbiwNCi0JCQkJCSZmb2xpbywgJmRh
dGEpOw0KLQkJaWYgKGVyciA8IDApDQotCQkJcmV0dXJuIGVycjsNCi0NCi0JCXZhZGRyID0ga21h
cF9sb2NhbF9mb2xpbyhmb2xpbywgb2Zmc2V0X2luX2ZvbGlvKGZvbGlvLCBwb3MpKTsNCi0JCXBh
Z2VmYXVsdF9kaXNhYmxlKCk7DQotCQl1bndyaXR0ZW4gPSBfX2NvcHlfZnJvbV91c2VyX2luYXRv
bWljKHZhZGRyLCB1c2VyX2RhdGEsIGxlbik7DQotCQlwYWdlZmF1bHRfZW5hYmxlKCk7DQotCQlr
dW5tYXBfbG9jYWwodmFkZHIpOw0KLQ0KLQkJZXJyID0gYW9wcy0+d3JpdGVfZW5kKG9iai0+YmFz
ZS5maWxwLCBtYXBwaW5nLCBwb3MsIGxlbiwNCi0JCQkJICAgICAgbGVuIC0gdW53cml0dGVuLCBm
b2xpbywgZGF0YSk7DQotCQlpZiAoZXJyIDwgMCkNCi0JCQlyZXR1cm4gZXJyOw0KLQ0KLQkJLyog
V2UgZG9uJ3QgaGFuZGxlIC1FRkFVTFQsIGxlYXZlIGl0IHRvIHRoZSBjYWxsZXIgdG8gY2hlY2sg
Ki8NCi0JCWlmICh1bndyaXR0ZW4pDQotCQkJcmV0dXJuIC1FTk9ERVY7DQotDQotCQlyZW1haW4g
LT0gbGVuOw0KLQkJdXNlcl9kYXRhICs9IGxlbjsNCi0JCXBvcyArPSBsZW47DQotCQlwZyA9IDA7
DQotCX0gd2hpbGUgKHJlbWFpbik7DQorCWluaXRfc3luY19raW9jYigma2lvY2IsIGZpbGUpOw0K
KwlraW9jYi5raV9wb3MgPSBhcmctPm9mZnNldDsNCisJaW92X2l0ZXJfdWJ1ZigmaXRlciwgSVRF
Ul9TT1VSQ0UsICh2b2lkIF9fdXNlciAqKXVzZXJfZGF0YSwgc2l6ZSk7DQorDQorCXdyaXR0ZW4g
PSBmaWxlLT5mX29wLT53cml0ZV9pdGVyKCZraW9jYiwgJml0ZXIpOw0KKwlCVUdfT04od3JpdHRl
biA9PSAtRUlPQ0JRVUVVRUQpOw0KKw0KKwlpZiAod3JpdHRlbiAhPSBzaXplKQ0KKwkJcmV0dXJu
IC1FSU87DQorDQorCWlmICh3cml0dGVuIDwgMCkNCisJCXJldHVybiB3cml0dGVuOw0KIA0KIAly
ZXR1cm4gMDsNCiB9DQotLSANCjIuMzQuMQ0K


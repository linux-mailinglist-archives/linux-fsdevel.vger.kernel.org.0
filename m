Return-Path: <linux-fsdevel+bounces-55130-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 41F8FB071DB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Jul 2025 11:36:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D9133A85A7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Jul 2025 09:36:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBE4B2F1FE1;
	Wed, 16 Jul 2025 09:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=didiglobal.com header.i=@didiglobal.com header.b="pinRda3o"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx9.didiglobal.com (mx9.didiglobal.com [111.202.70.124])
	by smtp.subspace.kernel.org (Postfix) with SMTP id BB2082EAB8D;
	Wed, 16 Jul 2025 09:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.202.70.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752658583; cv=none; b=pEQSNbGbGS2jnQaDfYEeWSpvkBCEsj3Dp79LcsVx4EzMU8WPOiN46rYK87FGK8uP6zy8isCV9HOLSdpRNAfDhy7RX4vxP6zIbdxlrGrsXCz9J2gZIw/EInMqsgBCveckXGmeq2dvcuWYKlkc3Plxk8C6rcFXd0XJYLjVOw3rL9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752658583; c=relaxed/simple;
	bh=G4rwVJYLKQqnce8QoPmaSGWeYFRMyGi7Hu7kmAMCExA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:Content-Type:
	 MIME-Version; b=HT7b3epv9JS9GVryqqJ1ySdRDBu8CMsDyMHS0m1TEaGWecLAOtR5PJyC8FeceXxMORInwlhT0n3ka2Dt9sa8vmlRMMofjST2q5GW4Yejg7PHB/UTb3lItN5+S2VHVQE0Vz4QA0wU8HDgW3D4xDtc+E3Pkr4IDf6zHMMaMprLZjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=didiglobal.com; spf=pass smtp.mailfrom=didiglobal.com; dkim=pass (1024-bit key) header.d=didiglobal.com header.i=@didiglobal.com header.b=pinRda3o; arc=none smtp.client-ip=111.202.70.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=didiglobal.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=didiglobal.com
Received: from mail.didiglobal.com (unknown [10.79.64.20])
	by mx9.didiglobal.com (MailData Gateway V2.8.8) with ESMTPS id D02EC18121AECF;
	Wed, 16 Jul 2025 17:35:52 +0800 (CST)
Received: from BJ03-ACTMBX-07.didichuxing.com (10.79.71.34) by
 BJ01-ACTMBX-01.didichuxing.com (10.79.64.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Wed, 16 Jul 2025 17:36:03 +0800
Received: from BJ03-ACTMBX-07.didichuxing.com (10.79.71.34) by
 BJ03-ACTMBX-07.didichuxing.com (10.79.71.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Wed, 16 Jul 2025 17:36:03 +0800
Received: from BJ03-ACTMBX-07.didichuxing.com ([fe80::2e1a:dd47:6d25:287e]) by
 BJ03-ACTMBX-07.didichuxing.com ([fe80::2e1a:dd47:6d25:287e%7]) with mapi id
 15.02.1748.010; Wed, 16 Jul 2025 17:36:03 +0800
X-MD-Sfrom: chentaotao@didiglobal.com
X-MD-SrcIP: 10.79.64.20
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
Subject: [PATCH v6 1/5] drm/i915: Use kernel_write() in shmem object create
Thread-Topic: [PATCH v6 1/5] drm/i915: Use kernel_write() in shmem object
 create
Thread-Index: AQHb9jUL3N5ZE20a3kaRBvbcgwGzNQ==
Date: Wed, 16 Jul 2025 09:36:03 +0000
Message-ID: <20250716093559.217344-2-chentaotao@didiglobal.com>
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
	s=2025; t=1752658558;
	bh=G4rwVJYLKQqnce8QoPmaSGWeYFRMyGi7Hu7kmAMCExA=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type;
	b=pinRda3o8oP5gwhYhmDu6fD7x4SNtZiVFE84ISrzkXEuSYGANSX9/72WzX/GQGYCq
	 LScVqHvMJZn29M4wVjAj/qq9oye05KfyO2ap2YG+/HMCE3kCodXm5EjN9ZG2crnw4l
	 Qng7qtjtz4lOvjlz7IA3mw3UVuhzwJ4/6z2Z1/XU=

RnJvbTogVGFvdGFvIENoZW4gPGNoZW50YW90YW9AZGlkaWdsb2JhbC5jb20+DQoNClJlcGxhY2Ug
dGhlIHdyaXRlX2JlZ2luL3dyaXRlX2VuZCBsb29wIGluDQppOTE1X2dlbV9vYmplY3RfY3JlYXRl
X3NobWVtX2Zyb21fZGF0YSgpIHdpdGggY2FsbCB0byBrZXJuZWxfd3JpdGUoKS4NCg0KVGhpcyBm
dW5jdGlvbiBpbml0aWFsaXplcyBzaG1lbS1iYWNrZWQgR0VNIG9iamVjdHMuIGtlcm5lbF93cml0
ZSgpDQpzaW1wbGlmaWVzIHRoZSBjb2RlIGJ5IHJlbW92aW5nIG1hbnVhbCBmb2xpbyBoYW5kbGlu
Zy4NCg0KUGFydCBvZiBhIHNlcmllcyByZWZhY3RvcmluZyBhZGRyZXNzX3NwYWNlX29wZXJhdGlv
bnMgd3JpdGVfYmVnaW4gYW5kDQp3cml0ZV9lbmQgY2FsbGJhY2tzIHRvIHVzZSBzdHJ1Y3Qga2lv
Y2IgZm9yIHBhc3Npbmcgd3JpdGUgY29udGV4dCBhbmQNCmZsYWdzLg0KDQpTaWduZWQtb2ZmLWJ5
OiBUYW90YW8gQ2hlbiA8Y2hlbnRhb3Rhb0BkaWRpZ2xvYmFsLmNvbT4NCi0tLQ0KIGRyaXZlcnMv
Z3B1L2RybS9pOTE1L2dlbS9pOTE1X2dlbV9zaG1lbS5jIHwgMzMgKysrKysrKy0tLS0tLS0tLS0t
LS0tLS0NCiAxIGZpbGUgY2hhbmdlZCwgOSBpbnNlcnRpb25zKCspLCAyNCBkZWxldGlvbnMoLSkN
Cg0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9pOTE1L2dlbS9pOTE1X2dlbV9zaG1lbS5j
IGIvZHJpdmVycy9ncHUvZHJtL2k5MTUvZ2VtL2k5MTVfZ2VtX3NobWVtLmMNCmluZGV4IDE5YTNl
YjgyZGM2YS4uMWU4ZjY2YWM0OGNhIDEwMDY0NA0KLS0tIGEvZHJpdmVycy9ncHUvZHJtL2k5MTUv
Z2VtL2k5MTVfZ2VtX3NobWVtLmMNCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9pOTE1L2dlbS9pOTE1
X2dlbV9zaG1lbS5jDQpAQCAtNjM3LDkgKzYzNyw4IEBAIGk5MTVfZ2VtX29iamVjdF9jcmVhdGVf
c2htZW1fZnJvbV9kYXRhKHN0cnVjdCBkcm1faTkxNV9wcml2YXRlICppOTE1LA0KIHsNCiAJc3Ry
dWN0IGRybV9pOTE1X2dlbV9vYmplY3QgKm9iajsNCiAJc3RydWN0IGZpbGUgKmZpbGU7DQotCWNv
bnN0IHN0cnVjdCBhZGRyZXNzX3NwYWNlX29wZXJhdGlvbnMgKmFvcHM7DQotCWxvZmZfdCBwb3M7
DQotCWludCBlcnI7DQorCWxvZmZfdCBwb3MgPSAwOw0KKwlzc2l6ZV90IGVycjsNCiANCiAJR0VN
X1dBUk5fT04oSVNfREdGWChpOTE1KSk7DQogCW9iaiA9IGk5MTVfZ2VtX29iamVjdF9jcmVhdGVf
c2htZW0oaTkxNSwgcm91bmRfdXAoc2l6ZSwgUEFHRV9TSVpFKSk7DQpAQCAtNjQ5LDI5ICs2NDgs
MTUgQEAgaTkxNV9nZW1fb2JqZWN0X2NyZWF0ZV9zaG1lbV9mcm9tX2RhdGEoc3RydWN0IGRybV9p
OTE1X3ByaXZhdGUgKmk5MTUsDQogCUdFTV9CVUdfT04ob2JqLT53cml0ZV9kb21haW4gIT0gSTkx
NV9HRU1fRE9NQUlOX0NQVSk7DQogDQogCWZpbGUgPSBvYmotPmJhc2UuZmlscDsNCi0JYW9wcyA9
IGZpbGUtPmZfbWFwcGluZy0+YV9vcHM7DQotCXBvcyA9IDA7DQotCWRvIHsNCi0JCXVuc2lnbmVk
IGludCBsZW4gPSBtaW5fdCh0eXBlb2Yoc2l6ZSksIHNpemUsIFBBR0VfU0laRSk7DQotCQlzdHJ1
Y3QgZm9saW8gKmZvbGlvOw0KLQkJdm9pZCAqZnNkYXRhOw0KLQ0KLQkJZXJyID0gYW9wcy0+d3Jp
dGVfYmVnaW4oZmlsZSwgZmlsZS0+Zl9tYXBwaW5nLCBwb3MsIGxlbiwNCi0JCQkJCSZmb2xpbywg
JmZzZGF0YSk7DQotCQlpZiAoZXJyIDwgMCkNCi0JCQlnb3RvIGZhaWw7DQorCWVyciA9IGtlcm5l
bF93cml0ZShmaWxlLCBkYXRhLCBzaXplLCAmcG9zKTsNCiANCi0JCW1lbWNweV90b19mb2xpbyhm
b2xpbywgb2Zmc2V0X2luX2ZvbGlvKGZvbGlvLCBwb3MpLCBkYXRhLCBsZW4pOw0KKwlpZiAoZXJy
IDwgMCkNCisJCWdvdG8gZmFpbDsNCiANCi0JCWVyciA9IGFvcHMtPndyaXRlX2VuZChmaWxlLCBm
aWxlLT5mX21hcHBpbmcsIHBvcywgbGVuLCBsZW4sDQotCQkJCSAgICAgIGZvbGlvLCBmc2RhdGEp
Ow0KLQkJaWYgKGVyciA8IDApDQotCQkJZ290byBmYWlsOw0KLQ0KLQkJc2l6ZSAtPSBsZW47DQot
CQlkYXRhICs9IGxlbjsNCi0JCXBvcyArPSBsZW47DQotCX0gd2hpbGUgKHNpemUpOw0KKwlpZiAo
ZXJyICE9IHNpemUpIHsNCisJCWVyciA9IC1FSU87DQorCQlnb3RvIGZhaWw7DQorCX0NCiANCiAJ
cmV0dXJuIG9iajsNCiANCi0tIA0KMi4zNC4xDQo=


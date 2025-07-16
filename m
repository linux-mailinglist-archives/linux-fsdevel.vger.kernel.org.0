Return-Path: <linux-fsdevel+bounces-55135-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 12CAFB071F7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Jul 2025 11:38:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9435F56177A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Jul 2025 09:38:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32CBA2F3C21;
	Wed, 16 Jul 2025 09:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=didiglobal.com header.i=@didiglobal.com header.b="gMjjMenR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx10.didiglobal.com (mx10.didiglobal.com [111.202.70.125])
	by smtp.subspace.kernel.org (Postfix) with SMTP id 325592F1987;
	Wed, 16 Jul 2025 09:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.202.70.125
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752658604; cv=none; b=dgL48Yhj7TDwWuBOSusBi5UwZfxlSIm8YmarOGXzRkvZH4J+S3SAItyhqFp/bfNYKSSOB9fvSaQJHX2q2ynPefHfCOSNSBBkQkfoyF36z+xna3qD8fsxT8+9Ms2brPJVPotxa2mAJ1T1bOfmZWyTb6OFogMvp5r8N+CxJPTWkC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752658604; c=relaxed/simple;
	bh=7NwIqzCgC1RdJfhixz5bD3co5fgHiYbQk2Lmr3rknQE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:Content-Type:
	 MIME-Version; b=sYixVLpYIzE3VTI/I0eR2JF38gv/zB8EYZUBHGkCHSHfev96ZzWCK+RdI98fTGQGGKYtQammr1bQsoylck56Z5c8ZwXqhTz6GasjtMwSkzuXtKn0zH7MtqZGGZG7INPeSyjHPko2OxUpAv31DyzT8SsyJFs1L4RGOPPLOjeIAU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=didiglobal.com; spf=pass smtp.mailfrom=didiglobal.com; dkim=pass (1024-bit key) header.d=didiglobal.com header.i=@didiglobal.com header.b=gMjjMenR; arc=none smtp.client-ip=111.202.70.125
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=didiglobal.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=didiglobal.com
Received: from mail.didiglobal.com (unknown [10.79.64.20])
	by mx10.didiglobal.com (MailData Gateway V2.8.8) with ESMTPS id F00C118BE806D6;
	Wed, 16 Jul 2025 17:35:24 +0800 (CST)
Received: from BJ02-ACTMBX-08.didichuxing.com (10.79.65.15) by
 BJ01-ACTMBX-01.didichuxing.com (10.79.64.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Wed, 16 Jul 2025 17:36:10 +0800
Received: from BJ03-ACTMBX-07.didichuxing.com (10.79.71.34) by
 BJ02-ACTMBX-08.didichuxing.com (10.79.65.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Wed, 16 Jul 2025 17:36:10 +0800
Received: from BJ03-ACTMBX-07.didichuxing.com ([fe80::2e1a:dd47:6d25:287e]) by
 BJ03-ACTMBX-07.didichuxing.com ([fe80::2e1a:dd47:6d25:287e%7]) with mapi id
 15.02.1748.010; Wed, 16 Jul 2025 17:36:10 +0800
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
Subject: [PATCH v6 5/5] ext4: support uncached buffered I/O
Thread-Topic: [PATCH v6 5/5] ext4: support uncached buffered I/O
Thread-Index: AQHb9jUP9LOYES+YUEOSUxZdtu5kSg==
Date: Wed, 16 Jul 2025 09:36:09 +0000
Message-ID: <20250716093559.217344-6-chentaotao@didiglobal.com>
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
	s=2025; t=1752658546;
	bh=7NwIqzCgC1RdJfhixz5bD3co5fgHiYbQk2Lmr3rknQE=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type;
	b=gMjjMenRDOz/Z1BVB8tmb1b4gC5PKmiKtyf6fjnfZfHUb4Ee90HbPIsEIi6iDGH3G
	 S7hJg03IR9ijacY2D6rD9P2rnqqDwUU/cqKfuIUbSGOqPUCJNH746hYEfWtFsXHf/B
	 dgPpUf0GDlc/u4/HzaRGVmB7Piz7Oj9KSnrpB5hU=

RnJvbTogVGFvdGFvIENoZW4gPGNoZW50YW90YW9AZGlkaWdsb2JhbC5jb20+DQoNClNldCBGT1Bf
RE9OVENBQ0hFIGluIGV4dDRfZmlsZV9vcGVyYXRpb25zIHRvIGRlY2xhcmUgc3VwcG9ydCBmb3IN
CnVuY2FjaGVkIGJ1ZmZlcmVkIEkvTy4NCg0KVG8gaGFuZGxlIHRoaXMgZmxhZywgdXBkYXRlIGV4
dDRfd3JpdGVfYmVnaW4oKSBhbmQgZXh0NF9kYV93cml0ZV9iZWdpbigpDQp0byB1c2Ugd3JpdGVf
YmVnaW5fZ2V0X2ZvbGlvKCksIHdoaWNoIGVuY2Fwc3VsYXRlcyBGR1BfRE9OVENBQ0hFIGxvZ2lj
DQpiYXNlZCBvbiBpb2NiLT5raV9mbGFncy4NCg0KUGFydCBvZiBhIHNlcmllcyByZWZhY3Rvcmlu
ZyBhZGRyZXNzX3NwYWNlX29wZXJhdGlvbnMgd3JpdGVfYmVnaW4gYW5kDQp3cml0ZV9lbmQgY2Fs
bGJhY2tzIHRvIHVzZSBzdHJ1Y3Qga2lvY2IgZm9yIHBhc3Npbmcgd3JpdGUgY29udGV4dCBhbmQN
CmZsYWdzLg0KDQpTaWduZWQtb2ZmLWJ5OiBUYW90YW8gQ2hlbiA8Y2hlbnRhb3Rhb0BkaWRpZ2xv
YmFsLmNvbT4NCi0tLQ0KIGZzL2V4dDQvZmlsZS5jICB8ICAzICsrLQ0KIGZzL2V4dDQvaW5vZGUu
YyB8IDEyICsrKy0tLS0tLS0tLQ0KIDIgZmlsZXMgY2hhbmdlZCwgNSBpbnNlcnRpb25zKCspLCAx
MCBkZWxldGlvbnMoLSkNCg0KZGlmZiAtLWdpdCBhL2ZzL2V4dDQvZmlsZS5jIGIvZnMvZXh0NC9m
aWxlLmMNCmluZGV4IDIxZGY4MTM0NzE0Ny4uMjc0YjQxYTQ3NmM4IDEwMDY0NA0KLS0tIGEvZnMv
ZXh0NC9maWxlLmMNCisrKyBiL2ZzL2V4dDQvZmlsZS5jDQpAQCAtOTc3LDcgKzk3Nyw4IEBAIGNv
bnN0IHN0cnVjdCBmaWxlX29wZXJhdGlvbnMgZXh0NF9maWxlX29wZXJhdGlvbnMgPSB7DQogCS5z
cGxpY2Vfd3JpdGUJPSBpdGVyX2ZpbGVfc3BsaWNlX3dyaXRlLA0KIAkuZmFsbG9jYXRlCT0gZXh0
NF9mYWxsb2NhdGUsDQogCS5mb3BfZmxhZ3MJPSBGT1BfTU1BUF9TWU5DIHwgRk9QX0JVRkZFUl9S
QVNZTkMgfA0KLQkJCSAgRk9QX0RJT19QQVJBTExFTF9XUklURSwNCisJCQkgIEZPUF9ESU9fUEFS
QUxMRUxfV1JJVEUgfA0KKwkJCSAgRk9QX0RPTlRDQUNIRSwNCiB9Ow0KIA0KIGNvbnN0IHN0cnVj
dCBpbm9kZV9vcGVyYXRpb25zIGV4dDRfZmlsZV9pbm9kZV9vcGVyYXRpb25zID0gew0KZGlmZiAt
LWdpdCBhL2ZzL2V4dDQvaW5vZGUuYyBiL2ZzL2V4dDQvaW5vZGUuYw0KaW5kZXggOWExNmVmZDA3
MmJiLi41YzcwMjQwNTFmMWUgMTAwNjQ0DQotLS0gYS9mcy9leHQ0L2lub2RlLmMNCisrKyBiL2Zz
L2V4dDQvaW5vZGUuYw0KQEAgLTEyNjQsNyArMTI2NCw2IEBAIHN0YXRpYyBpbnQgZXh0NF93cml0
ZV9iZWdpbihjb25zdCBzdHJ1Y3Qga2lvY2IgKmlvY2IsDQogCXN0cnVjdCBmb2xpbyAqZm9saW87
DQogCXBnb2ZmX3QgaW5kZXg7DQogCXVuc2lnbmVkIGZyb20sIHRvOw0KLQlmZ2ZfdCBmZ3AgPSBG
R1BfV1JJVEVCRUdJTjsNCiANCiAJcmV0ID0gZXh0NF9lbWVyZ2VuY3lfc3RhdGUoaW5vZGUtPmlf
c2IpOw0KIAlpZiAodW5saWtlbHkocmV0KSkNCkBAIC0xMjg4LDE2ICsxMjg3LDE0IEBAIHN0YXRp
YyBpbnQgZXh0NF93cml0ZV9iZWdpbihjb25zdCBzdHJ1Y3Qga2lvY2IgKmlvY2IsDQogCX0NCiAN
CiAJLyoNCi0JICogX19maWxlbWFwX2dldF9mb2xpbygpIGNhbiB0YWtlIGEgbG9uZyB0aW1lIGlm
IHRoZQ0KKwkgKiB3cml0ZV9iZWdpbl9nZXRfZm9saW8oKSBjYW4gdGFrZSBhIGxvbmcgdGltZSBp
ZiB0aGUNCiAJICogc3lzdGVtIGlzIHRocmFzaGluZyBkdWUgdG8gbWVtb3J5IHByZXNzdXJlLCBv
ciBpZiB0aGUgZm9saW8NCiAJICogaXMgYmVpbmcgd3JpdHRlbiBiYWNrLiAgU28gZ3JhYiBpdCBm
aXJzdCBiZWZvcmUgd2Ugc3RhcnQNCiAJICogdGhlIHRyYW5zYWN0aW9uIGhhbmRsZS4gIFRoaXMg
YWxzbyBhbGxvd3MgdXMgdG8gYWxsb2NhdGUNCiAJICogdGhlIGZvbGlvIChpZiBuZWVkZWQpIHdp
dGhvdXQgdXNpbmcgR0ZQX05PRlMuDQogCSAqLw0KIHJldHJ5X2dyYWI6DQotCWZncCB8PSBmZ2Zf
c2V0X29yZGVyKGxlbik7DQotCWZvbGlvID0gX19maWxlbWFwX2dldF9mb2xpbyhtYXBwaW5nLCBp
bmRleCwgZmdwLA0KLQkJCQkgICAgbWFwcGluZ19nZnBfbWFzayhtYXBwaW5nKSk7DQorCWZvbGlv
ID0gd3JpdGVfYmVnaW5fZ2V0X2ZvbGlvKGlvY2IsIG1hcHBpbmcsIGluZGV4LCBsZW4pOw0KIAlp
ZiAoSVNfRVJSKGZvbGlvKSkNCiAJCXJldHVybiBQVFJfRVJSKGZvbGlvKTsNCiANCkBAIC0zMDQ2
LDcgKzMwNDMsNiBAQCBzdGF0aWMgaW50IGV4dDRfZGFfd3JpdGVfYmVnaW4oY29uc3Qgc3RydWN0
IGtpb2NiICppb2NiLA0KIAlzdHJ1Y3QgZm9saW8gKmZvbGlvOw0KIAlwZ29mZl90IGluZGV4Ow0K
IAlzdHJ1Y3QgaW5vZGUgKmlub2RlID0gbWFwcGluZy0+aG9zdDsNCi0JZmdmX3QgZmdwID0gRkdQ
X1dSSVRFQkVHSU47DQogDQogCXJldCA9IGV4dDRfZW1lcmdlbmN5X3N0YXRlKGlub2RlLT5pX3Ni
KTsNCiAJaWYgKHVubGlrZWx5KHJldCkpDQpAQCAtMzA3Miw5ICszMDY4LDcgQEAgc3RhdGljIGlu
dCBleHQ0X2RhX3dyaXRlX2JlZ2luKGNvbnN0IHN0cnVjdCBraW9jYiAqaW9jYiwNCiAJfQ0KIA0K
IHJldHJ5Og0KLQlmZ3AgfD0gZmdmX3NldF9vcmRlcihsZW4pOw0KLQlmb2xpbyA9IF9fZmlsZW1h
cF9nZXRfZm9saW8obWFwcGluZywgaW5kZXgsIGZncCwNCi0JCQkJICAgIG1hcHBpbmdfZ2ZwX21h
c2sobWFwcGluZykpOw0KKwlmb2xpbyA9IHdyaXRlX2JlZ2luX2dldF9mb2xpbyhpb2NiLCBtYXBw
aW5nLCBpbmRleCwgbGVuKTsNCiAJaWYgKElTX0VSUihmb2xpbykpDQogCQlyZXR1cm4gUFRSX0VS
Uihmb2xpbyk7DQogDQotLSANCjIuMzQuMQ0K


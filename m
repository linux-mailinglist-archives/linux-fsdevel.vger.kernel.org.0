Return-Path: <linux-fsdevel+bounces-53175-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FD60AEB5D4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Jun 2025 13:05:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EBA2B3A534E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Jun 2025 11:05:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCE872D6601;
	Fri, 27 Jun 2025 11:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=didiglobal.com header.i=@didiglobal.com header.b="ehTRUkDp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx10.didiglobal.com (mx10.didiglobal.com [111.202.70.125])
	by smtp.subspace.kernel.org (Postfix) with SMTP id E365F2D3EC4;
	Fri, 27 Jun 2025 11:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.202.70.125
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751022221; cv=none; b=U+gwBUTmQ4bbNwBorgN5h0R+3mcKE6HeTA60hYeW4najhOtCskvFjaG72eCMY6EiGhBBC7i0JG8Dv+gCobv1V1HfuAgAWYFfym1WXuas9VZDGpyYJu3c0IQQgPHLY1FP+gOKvHJADSZGGSb/K4PDUSQqPw8oS4Ew8VVdxoe4288=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751022221; c=relaxed/simple;
	bh=4rXllrq3i00vA/X/MCfjVxkg+yARKY9+OylzC6mFE+c=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:Content-Type:
	 MIME-Version; b=qu4l6Dc/IPcjdyWYFv6N/tBWv90qkl1tuU94aStQFju/oizRphFc+fw+zchdkxILbTgNRNO2+0RLHC6QgQ50jiRXnbD3PLUTtl6hVrfYrdXDqd++GN75ci9em48b2vz5HT3AZwwxUoESwd2YInusu/f4tuMallwtlYOVT3VCWAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=didiglobal.com; spf=pass smtp.mailfrom=didiglobal.com; dkim=pass (1024-bit key) header.d=didiglobal.com header.i=@didiglobal.com header.b=ehTRUkDp; arc=none smtp.client-ip=111.202.70.125
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=didiglobal.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=didiglobal.com
Received: from mail.didiglobal.com (unknown [10.79.71.38])
	by mx10.didiglobal.com (MailData Gateway V2.8.8) with ESMTPS id 69C23180FFD57A;
	Fri, 27 Jun 2025 19:02:31 +0800 (CST)
Received: from BJ03-ACTMBX-08.didichuxing.com (10.79.71.35) by
 BJ03-ACTMBX-02.didichuxing.com (10.79.71.38) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Fri, 27 Jun 2025 19:03:14 +0800
Received: from BJ03-ACTMBX-07.didichuxing.com (10.79.71.34) by
 BJ03-ACTMBX-08.didichuxing.com (10.79.71.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Fri, 27 Jun 2025 19:03:13 +0800
Received: from BJ03-ACTMBX-07.didichuxing.com ([fe80::2e1a:dd47:6d25:287e]) by
 BJ03-ACTMBX-07.didichuxing.com ([fe80::2e1a:dd47:6d25:287e%7]) with mapi id
 15.02.1748.010; Fri, 27 Jun 2025 19:03:13 +0800
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
Subject: [PATCH v3 4/4] ext4: support uncached buffered I/O
Thread-Topic: [PATCH v3 4/4] ext4: support uncached buffered I/O
Thread-Index: AQHb51MTaMwhJCsRP0eEgBCVUoPCoQ==
Date: Fri, 27 Jun 2025 11:03:13 +0000
Message-ID: <20250627110257.1870826-5-chentaotao@didiglobal.com>
In-Reply-To: <20250627110257.1870826-1-chentaotao@didiglobal.com>
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
	s=2025; t=1751022173;
	bh=4rXllrq3i00vA/X/MCfjVxkg+yARKY9+OylzC6mFE+c=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type;
	b=ehTRUkDpCbEGkhMZpTTEM7DPSDb/UWxpKKgQP/Vy9sHFH/sbmH4ptirGdI2TC8yxO
	 mZHpZNlUxGBa0YCbHJ9au4BOMGEAd3oFTVzILrWnaR5BANeKmYT+Ta2GlMcEnb/u4G
	 uyBuOmOz7hUFR4dKovFjwFMs6SSIi6KRO/Nb5knw=

RnJvbTogVGFvdGFvIENoZW4gPGNoZW50YW90YW9AZGlkaWdsb2JhbC5jb20+DQoNClNldCBGT1Bf
RE9OVENBQ0hFIGluIGV4dDRfZmlsZV9vcGVyYXRpb25zIHRvIGRlY2xhcmUgc3VwcG9ydCBmb3IN
CnVuY2FjaGVkIGJ1ZmZlcmVkIEkvTy4NCg0KVG8gaGFuZGxlIHRoaXMgZmxhZywgYWRkIHByb2Nl
c3NpbmcgZm9yIElPQ0JfRE9OVENBQ0hFIGluDQpleHQ0X3dyaXRlX2JlZ2luKCkgYW5kIGV4dDRf
ZGFfd3JpdGVfYmVnaW4oKSBieSBwYXNzaW5nIEZHUF9ET05UQ0FDSEUNCnRvIHBhZ2UgY2FjaGUg
bG9va3Vwcy4NCg0KUGFydCBvZiBhIHNlcmllcyByZWZhY3RvcmluZyBhZGRyZXNzX3NwYWNlX29w
ZXJhdGlvbnMgd3JpdGVfYmVnaW4gYW5kDQp3cml0ZV9lbmQgY2FsbGJhY2tzIHRvIHVzZSBzdHJ1
Y3Qga2lvY2IgZm9yIHBhc3Npbmcgd3JpdGUgY29udGV4dCBhbmQNCmZsYWdzLg0KDQpTaWduZWQt
b2ZmLWJ5OiBUYW90YW8gQ2hlbiA8Y2hlbnRhb3Rhb0BkaWRpZ2xvYmFsLmNvbT4NCi0tLQ0KIGZz
L2V4dDQvZmlsZS5jICB8IDMgKystDQogZnMvZXh0NC9pbm9kZS5jIHwgNiArKysrKysNCiAyIGZp
bGVzIGNoYW5nZWQsIDggaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KDQpkaWZmIC0tZ2l0
IGEvZnMvZXh0NC9maWxlLmMgYi9mcy9leHQ0L2ZpbGUuYw0KaW5kZXggMjFkZjgxMzQ3MTQ3Li4y
NzRiNDFhNDc2YzggMTAwNjQ0DQotLS0gYS9mcy9leHQ0L2ZpbGUuYw0KKysrIGIvZnMvZXh0NC9m
aWxlLmMNCkBAIC05NzcsNyArOTc3LDggQEAgY29uc3Qgc3RydWN0IGZpbGVfb3BlcmF0aW9ucyBl
eHQ0X2ZpbGVfb3BlcmF0aW9ucyA9IHsNCiAJLnNwbGljZV93cml0ZQk9IGl0ZXJfZmlsZV9zcGxp
Y2Vfd3JpdGUsDQogCS5mYWxsb2NhdGUJPSBleHQ0X2ZhbGxvY2F0ZSwNCiAJLmZvcF9mbGFncwk9
IEZPUF9NTUFQX1NZTkMgfCBGT1BfQlVGRkVSX1JBU1lOQyB8DQotCQkJICBGT1BfRElPX1BBUkFM
TEVMX1dSSVRFLA0KKwkJCSAgRk9QX0RJT19QQVJBTExFTF9XUklURSB8DQorCQkJICBGT1BfRE9O
VENBQ0hFLA0KIH07DQogDQogY29uc3Qgc3RydWN0IGlub2RlX29wZXJhdGlvbnMgZXh0NF9maWxl
X2lub2RlX29wZXJhdGlvbnMgPSB7DQpkaWZmIC0tZ2l0IGEvZnMvZXh0NC9pbm9kZS5jIGIvZnMv
ZXh0NC9pbm9kZS5jDQppbmRleCAwOGMxMDIwMGQ2ZmUuLjYzOWUyZTIzMWM0YiAxMDA2NDQNCi0t
LSBhL2ZzL2V4dDQvaW5vZGUuYw0KKysrIGIvZnMvZXh0NC9pbm9kZS5jDQpAQCAtMTI3MCw2ICsx
MjcwLDkgQEAgc3RhdGljIGludCBleHQ0X3dyaXRlX2JlZ2luKGNvbnN0IHN0cnVjdCBraW9jYiAq
aW9jYiwNCiAJaWYgKHVubGlrZWx5KHJldCkpDQogCQlyZXR1cm4gcmV0Ow0KIA0KKwlpZiAoaW9j
Yi0+a2lfZmxhZ3MgJiBJT0NCX0RPTlRDQUNIRSkNCisJCWZncCB8PSBGR1BfRE9OVENBQ0hFOw0K
Kw0KIAl0cmFjZV9leHQ0X3dyaXRlX2JlZ2luKGlub2RlLCBwb3MsIGxlbik7DQogCS8qDQogCSAq
IFJlc2VydmUgb25lIGJsb2NrIG1vcmUgZm9yIGFkZGl0aW9uIHRvIG9ycGhhbiBsaXN0IGluIGNh
c2UNCkBAIC0zMDY4LDYgKzMwNzEsOSBAQCBzdGF0aWMgaW50IGV4dDRfZGFfd3JpdGVfYmVnaW4o
Y29uc3Qgc3RydWN0IGtpb2NiICppb2NiLA0KIAkJCXJldHVybiAwOw0KIAl9DQogDQorCWlmIChp
b2NiLT5raV9mbGFncyAmIElPQ0JfRE9OVENBQ0hFKQ0KKwkJZmdwIHw9IEZHUF9ET05UQ0FDSEU7
DQorDQogcmV0cnk6DQogCWZncCB8PSBmZ2Zfc2V0X29yZGVyKGxlbik7DQogCWZvbGlvID0gX19m
aWxlbWFwX2dldF9mb2xpbyhtYXBwaW5nLCBpbmRleCwgZmdwLA0KLS0gDQoyLjM0LjENCg==


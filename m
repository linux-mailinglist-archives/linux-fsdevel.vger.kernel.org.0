Return-Path: <linux-fsdevel+bounces-52752-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A519AE644B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jun 2025 14:12:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CEDC9189DA44
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jun 2025 12:13:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9797291C09;
	Tue, 24 Jun 2025 12:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=didiglobal.com header.i=@didiglobal.com header.b="jG1fTpFZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx10.didiglobal.com (mx10.didiglobal.com [111.202.70.125])
	by smtp.subspace.kernel.org (Postfix) with SMTP id 98FF722CBC6;
	Tue, 24 Jun 2025 12:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.202.70.125
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750767160; cv=none; b=bMmM5M30Oe1O3t98mpUyMn1b8GjYYYWALKWYmhCUbnSz1NgJ+gltLXl9GxxsVHgi17azK5YnTKH/gQm9xoH3xCLMrWBqnqrj5JAALRJFC3rUpbFaRpWqO0lmEdWRZVMSgbTntWO+cdGV2jzoRQpt2dsrpXsd6pXs6RV79awsruw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750767160; c=relaxed/simple;
	bh=iuF1ZOur63OjUvd6ybvJnLgKwbJ3U/NzwPXRo3n32rY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:Content-Type:
	 MIME-Version; b=SS5AkFix8Cyu8iw9MmoHgPV5VY3hTtic3ey1Sd1GVebT1DRRDf2sLSbW8qYq8qQ6iNxPV8a4Qa8vibkbCb39VDXSBqIB/4n1+29JA6Rm6SelDIIsrWlNjCZPuV3SVmiPK7YEmUBXiSZojjbZKPzOw/Q3hy9Y6gZ/wsx058BE+Dw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=didiglobal.com; spf=pass smtp.mailfrom=didiglobal.com; dkim=pass (1024-bit key) header.d=didiglobal.com header.i=@didiglobal.com header.b=jG1fTpFZ; arc=none smtp.client-ip=111.202.70.125
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=didiglobal.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=didiglobal.com
Received: from mail.didiglobal.com (unknown [10.79.65.20])
	by mx10.didiglobal.com (MailData Gateway V2.8.8) with ESMTPS id 3B0B71808ACADD;
	Tue, 24 Jun 2025 20:11:29 +0800 (CST)
Received: from BJ02-ACTMBX-08.didichuxing.com (10.79.65.15) by
 BJ02-ACTMBX-02.didichuxing.com (10.79.65.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Tue, 24 Jun 2025 20:12:11 +0800
Received: from BJ03-ACTMBX-07.didichuxing.com (10.79.71.34) by
 BJ02-ACTMBX-08.didichuxing.com (10.79.65.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Tue, 24 Jun 2025 20:12:11 +0800
Received: from BJ03-ACTMBX-07.didichuxing.com ([fe80::b00b:de35:2067:9787]) by
 BJ03-ACTMBX-07.didichuxing.com ([fe80::b00b:de35:2067:9787%7]) with mapi id
 15.02.1748.010; Tue, 24 Jun 2025 20:12:11 +0800
X-MD-Sfrom: chentaotao@didiglobal.com
X-MD-SrcIP: 10.79.65.20
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
Subject: [PATCH v2 5/5] ext4: declare support for FOP_DONTCACHE
Thread-Topic: [PATCH v2 5/5] ext4: declare support for FOP_DONTCACHE
Thread-Index: AQHb5QE2ZjIKcQrU5kGPOqcDpxUbGg==
Date: Tue, 24 Jun 2025 12:12:10 +0000
Message-ID: <20250624121149.2927-6-chentaotao@didiglobal.com>
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
	s=2025; t=1750767111;
	bh=iuF1ZOur63OjUvd6ybvJnLgKwbJ3U/NzwPXRo3n32rY=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type;
	b=jG1fTpFZ5DZ3tvJBBpHiw+NcCQv4XiH7nagDsfHKhol3W/U+kb7vKldOhO7jBL3pp
	 RxJTpSe2q3R/f5c6cru5v8cqEeQmrQEfxebUH3R6/qe2L9xn1IfGNMxKbvlG0CMej/
	 MWF3ZmON8QiK9ShSKWFSJqmAkMqCtXz1mbNVHfOg=

RnJvbTogVGFvdGFvIENoZW4gPGNoZW50YW90YW9AZGlkaWdsb2JhbC5jb20+DQoNClNldCB0aGUg
Rk9QX0RPTlRDQUNIRSBmbGFnIGluIGV4dDRfZmlsZV9vcGVyYXRpb25zIHRvIGluZGljYXRlIHRo
YXQNCmV4dDQgc3VwcG9ydHMgSU9DQl9ET05UQ0FDSEUgaGFuZGxpbmcgaW4gYnVmZmVyZWQgd3Jp
dGUgcGF0aHMuDQoNClBhcnQgb2YgYSBzZXJpZXMgcmVmYWN0b3JpbmcgYWRkcmVzc19zcGFjZV9v
cGVyYXRpb25zIHdyaXRlX2JlZ2luIGFuZA0Kd3JpdGVfZW5kIGNhbGxiYWNrcyB0byB1c2Ugc3Ry
dWN0IGtpb2NiIGZvciBwYXNzaW5nIHdyaXRlIGNvbnRleHQgYW5kDQpmbGFncy4NCg0KU2lnbmVk
LW9mZi1ieTogVGFvdGFvIENoZW4gPGNoZW50YW90YW9AZGlkaWdsb2JhbC5jb20+DQotLS0NCiBm
cy9leHQ0L2ZpbGUuYyB8IDMgKystDQogMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwg
MSBkZWxldGlvbigtKQ0KDQpkaWZmIC0tZ2l0IGEvZnMvZXh0NC9maWxlLmMgYi9mcy9leHQ0L2Zp
bGUuYw0KaW5kZXggMjFkZjgxMzQ3MTQ3Li4yNzRiNDFhNDc2YzggMTAwNjQ0DQotLS0gYS9mcy9l
eHQ0L2ZpbGUuYw0KKysrIGIvZnMvZXh0NC9maWxlLmMNCkBAIC05NzcsNyArOTc3LDggQEAgY29u
c3Qgc3RydWN0IGZpbGVfb3BlcmF0aW9ucyBleHQ0X2ZpbGVfb3BlcmF0aW9ucyA9IHsNCiAJLnNw
bGljZV93cml0ZQk9IGl0ZXJfZmlsZV9zcGxpY2Vfd3JpdGUsDQogCS5mYWxsb2NhdGUJPSBleHQ0
X2ZhbGxvY2F0ZSwNCiAJLmZvcF9mbGFncwk9IEZPUF9NTUFQX1NZTkMgfCBGT1BfQlVGRkVSX1JB
U1lOQyB8DQotCQkJICBGT1BfRElPX1BBUkFMTEVMX1dSSVRFLA0KKwkJCSAgRk9QX0RJT19QQVJB
TExFTF9XUklURSB8DQorCQkJICBGT1BfRE9OVENBQ0hFLA0KIH07DQogDQogY29uc3Qgc3RydWN0
IGlub2RlX29wZXJhdGlvbnMgZXh0NF9maWxlX2lub2RlX29wZXJhdGlvbnMgPSB7DQotLSANCjIu
MzQuMQ0K


Return-Path: <linux-fsdevel+bounces-52754-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 59B97AE64A4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jun 2025 14:21:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 499341925E9C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jun 2025 12:20:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49D18299A87;
	Tue, 24 Jun 2025 12:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=didiglobal.com header.i=@didiglobal.com header.b="hpzAoHxX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx10.didiglobal.com (mx10.didiglobal.com [111.202.70.125])
	by smtp.subspace.kernel.org (Postfix) with SMTP id E682E28ECEA;
	Tue, 24 Jun 2025 12:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.202.70.125
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750767338; cv=none; b=nU3S46tXbRkjdAG4/T7/vEUUbP4t+7NmeCB1JO7IvDE3VjJz+4pEq64RS60laWUr67GbidZN5uWhJQilJDwd+L+59qvJKiuPpXFyoNquB8oaZzkdGU70jIAP3s8rPQrQ+tW3WiSXKGZKH1nwQUj4DhQIbmiId2Lkawu42fUVtyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750767338; c=relaxed/simple;
	bh=NSR7S0h0nlsDFAQMve21bvAq8IdC1ftrKlDHkbcGUQg=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=qvN4PVj4nRU4t3/TUrSq5EG0GQE521KgkegSduCE5aS1vfpzvwS8kQwdcQyoARgC+/WwSuf2JuIIol4Sad3RW1Qq2M4IwuqMGAKBJI4mE2T6fJNMeygj6yFsJ9r6IITCGpY1rbNi+UvpV9oZ6LZHwY3XUecrenxEtUwVAb7u+lY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=didiglobal.com; spf=pass smtp.mailfrom=didiglobal.com; dkim=pass (1024-bit key) header.d=didiglobal.com header.i=@didiglobal.com header.b=hpzAoHxX; arc=none smtp.client-ip=111.202.70.125
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=didiglobal.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=didiglobal.com
Received: from mail.didiglobal.com (unknown [10.79.65.20])
	by mx10.didiglobal.com (MailData Gateway V2.8.8) with ESMTPS id 39D011808ACAD9;
	Tue, 24 Jun 2025 20:11:18 +0800 (CST)
Received: from BJ03-ACTMBX-07.didichuxing.com (10.79.71.34) by
 BJ02-ACTMBX-02.didichuxing.com (10.79.65.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Tue, 24 Jun 2025 20:12:00 +0800
Received: from BJ03-ACTMBX-07.didichuxing.com (10.79.71.34) by
 BJ03-ACTMBX-07.didichuxing.com (10.79.71.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Tue, 24 Jun 2025 20:12:00 +0800
Received: from BJ03-ACTMBX-07.didichuxing.com ([fe80::b00b:de35:2067:9787]) by
 BJ03-ACTMBX-07.didichuxing.com ([fe80::b00b:de35:2067:9787%7]) with mapi id
 15.02.1748.010; Tue, 24 Jun 2025 20:12:00 +0800
X-MD-Sfrom: chentaotao@didiglobal.com
X-MD-SrcIP: 10.79.65.20
From: =?utf-8?B?6ZmI5rab5rabIFRhb3RhbyBDaGVu?= <chentaotao@didiglobal.com>
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
	=?utf-8?B?6ZmI5rab5rabIFRhb3RhbyBDaGVu?= <chentaotao@didiglobal.com>
Subject: [PATCH v2 0/5] fs: refactor write_begin/write_end and add ext4
 IOCB_DONTCACHE support
Thread-Topic: [PATCH v2 0/5] fs: refactor write_begin/write_end and add ext4
 IOCB_DONTCACHE support
Thread-Index: AQHb5QEvaAoiRj/CJkyi1oGtEi5geQ==
Date: Tue, 24 Jun 2025 12:11:59 +0000
Message-ID: <20250624121149.2927-1-chentaotao@didiglobal.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="utf-8"
Content-ID: <2CD453F0A90DBA419D2AF275EA1B93EA@didichuxing.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=didiglobal.com;
	s=2025; t=1750767104;
	bh=NSR7S0h0nlsDFAQMve21bvAq8IdC1ftrKlDHkbcGUQg=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type;
	b=hpzAoHxXGrLrOt4KyFR3Wu9rYx24YWOUGLJg4cMGOzA/LiAI2xzjQqbgxD9BgQG4N
	 P80y8W+6+dxppjOjwG1nyrcKNA8+PVWIXfMRbf8pnKWnO1Gi8i1h2FuB27m95uce/B
	 dt+7YIGgT0BlZlBUeiGUNZv/RWY4PuBRhALeYV+8=

RnJvbTogVGFvdGFvIENoZW4gPGNoZW50YW90YW9AZGlkaWdsb2JhbC5jb20+DQoNClRoaXMgcGF0
Y2ggc2VyaWVzIHJlZmFjdG9ycyB0aGUgYWRkcmVzc19zcGFjZV9vcGVyYXRpb25zIHdyaXRlX2Jl
Z2luKCkNCmFuZCB3cml0ZV9lbmQoKSBjYWxsYmFja3MgdG8gdGFrZSBzdHJ1Y3Qga2lvY2IgKiBh
cyB0aGVpciBmaXJzdCBhcmd1bWVudCwNCmFsbG93aW5nIElPQ0IgZmxhZ3Mgc3VjaCBhcyBJT0NC
X0RPTlRDQUNIRSB0byBwcm9wYWdhdGUgdG8gZmlsZXN5c3RlbeKAmXMNCmJ1ZmZlcmVkIHdyaXRl
IHBhdGguDQoNCkV4dDQgaXMgdXBkYXRlZCB0byBpbXBsZW1lbnQgaGFuZGxpbmcgb2YgdGhlIElP
Q0JfRE9OVENBQ0hFIGZsYWcgaW4gaXRzDQpidWZmZXJlZCB3cml0ZSBwYXRoIGFuZCB0byBhZHZl
cnRpc2Ugc3VwcG9ydCB2aWEgdGhlIEZPUF9ET05UQ0FDSEUgZmlsZQ0Kb3BlcmF0aW9uIGZsYWcu
DQoNCkFkZGl0aW9uYWxseSwgdGhlIGk5MTUgZHJpdmVy4oCZcyBzaG1lbSB3cml0ZSBwYXRocyBh
cmUgdXBkYXRlZCB0byBieXBhc3MNCnRoZSBsZWdhY3kgd3JpdGVfYmVnaW4vd3JpdGVfZW5kIGlu
dGVyZmFjZSBpbiBmYXZvciBvZiBkaXJlY3RseSBjYWxsaW5nDQp3cml0ZV9pdGVyKCksIHVzaW5n
IGEgY29uc3RydWN0ZWQgc3luY2hyb25vdXMga2lvY2IuIEFub3RoZXIgaTkxNSBwYXRjaA0KcmVw
bGFjZXMgYSBtYW51YWwgd3JpdGUgbG9vcCB3aXRoIGtlcm5lbF93cml0ZSgpIGluIHNobWVtIG9i
amVjdCBjcmVhdGlvbi4NCg0KVGVzdGVkIHdpdGggZXh0NCBhbmQgaTkxNSBHRU0gd29ya2xvYWRz
Lg0KDQpDaGFuZ2VzIHNpbmNlIHYxOg0KLSBleHQ0IHVzZXMga2lvY2ItPmtpX2ZsYWdzIGRpcmVj
dGx5IGluc3RlYWQgb2YgZnNkYXRhLg0KLSB3cml0ZV9iZWdpbi93cml0ZV9lbmQgaW50ZXJmYWNl
IGlzIGNoYW5nZWQgdG8gdGFrZSBzdHJ1Y3Qga2lvY2IgKg0KICBpbnN0ZWFkIG9mIHN0cnVjdCBm
aWxlICouDQotIGk5MTUgc2htZW1fcHdyaXRlIHJlZmFjdG9yZWQgdG8gdXNlIHdyaXRlX2l0ZXIo
KSBkaXJlY3RseSBpbnN0ZWFkDQogIG9mIHdyaXRlX2JlZ2luL3dyaXRlX2VuZC4NCi0gaTkxNSBH
RU0gc2htZW0gb2JqZWN0IGNyZWF0aW9uIHJlcGxhY2VkIG1hbnVhbCB3cml0ZSBsb29wIHdpdGgN
CiAga2VybmVsX3dyaXRlKCkuDQoNClRhb3RhbyBDaGVuICg1KToNCiAgZHJtL2k5MTU6IFVzZSBr
ZXJuZWxfd3JpdGUoKSBpbiBzaG1lbSBvYmplY3QgY3JlYXRlDQogIGRybS9pOTE1OiBSZWZhY3Rv
ciBzaG1lbV9wd3JpdGUoKSB0byB1c2Uga2lvY2IgYW5kIHdyaXRlX2l0ZXINCiAgZnM6IGNoYW5n
ZSB3cml0ZV9iZWdpbi93cml0ZV9lbmQgaW50ZXJmYWNlIHRvIHRha2Ugc3RydWN0IGtpb2NiICoN
CiAgZXh0NDogaGFuZGxlIElPQ0JfRE9OVENBQ0hFIGluIGJ1ZmZlcmVkIHdyaXRlIHBhdGgNCiAg
ZXh0NDogZGVjbGFyZSBzdXBwb3J0IGZvciBGT1BfRE9OVENBQ0hFDQoNCiBEb2N1bWVudGF0aW9u
L2ZpbGVzeXN0ZW1zL2xvY2tpbmcucnN0ICAgICB8ICAgNCArLQ0KIERvY3VtZW50YXRpb24vZmls
ZXN5c3RlbXMvdmZzLnJzdCAgICAgICAgIHwgICA0ICstDQogYmxvY2svZm9wcy5jICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgfCAgIDYgKy0NCiBkcml2ZXJzL2dwdS9kcm0vaTkxNS9nZW0v
aTkxNV9nZW1fc2htZW0uYyB8IDExMiArKysrKystLS0tLS0tLS0tLS0tLS0tDQogZnMvYWRmcy9p
bm9kZS5jICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAgIDQgKy0NCiBmcy9hZmZzL2ZpbGUu
YyAgICAgICAgICAgICAgICAgICAgICAgICAgICB8ICAxMiArLS0NCiBmcy9iY2FjaGVmcy9mcy1p
by1idWZmZXJlZC5jICAgICAgICAgICAgICB8ICAgNCArLQ0KIGZzL2JjYWNoZWZzL2ZzLWlvLWJ1
ZmZlcmVkLmggICAgICAgICAgICAgIHwgICA0ICstDQogZnMvYmZzL2ZpbGUuYyAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgfCAgIDIgKy0NCiBmcy9idWZmZXIuYyAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICB8ICAxOCArKy0tDQogZnMvY2VwaC9hZGRyLmMgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgfCAgIDYgKy0NCiBmcy9lY3J5cHRmcy9tbWFwLmMgICAgICAgICAgICAgICAg
ICAgICAgICB8ICAxMCArLQ0KIGZzL2V4ZmF0L2ZpbGUuYyAgICAgICAgICAgICAgICAgICAgICAg
ICAgIHwgIDE0ICsrLQ0KIGZzL2V4ZmF0L2lub2RlLmMgICAgICAgICAgICAgICAgICAgICAgICAg
IHwgICA2ICstDQogZnMvZXh0Mi9pbm9kZS5jICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAg
IDYgKy0NCiBmcy9leHQ0L2ZpbGUuYyAgICAgICAgICAgICAgICAgICAgICAgICAgICB8ICAgMyAr
LQ0KIGZzL2V4dDQvaW5vZGUuYyAgICAgICAgICAgICAgICAgICAgICAgICAgIHwgIDI1ICsrLS0t
DQogZnMvZjJmcy9kYXRhLmMgICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAgIDQgKy0NCiBm
cy9mYXQvaW5vZGUuYyAgICAgICAgICAgICAgICAgICAgICAgICAgICB8ICAgOCArLQ0KIGZzL2Z1
c2UvZmlsZS5jICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwgICA1ICstDQogZnMvaGZzL2hm
c19mcy5oICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAgIDIgKy0NCiBmcy9oZnMvaW5vZGUu
YyAgICAgICAgICAgICAgICAgICAgICAgICAgICB8ICAgNCArLQ0KIGZzL2hmc3BsdXMvaGZzcGx1
c19mcy5oICAgICAgICAgICAgICAgICAgIHwgICAyICstDQogZnMvaGZzcGx1cy9pbm9kZS5jICAg
ICAgICAgICAgICAgICAgICAgICAgfCAgIDQgKy0NCiBmcy9ob3N0ZnMvaG9zdGZzX2tlcm4uYyAg
ICAgICAgICAgICAgICAgICB8ICAgNiArLQ0KIGZzL2hwZnMvZmlsZS5jICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIHwgICA4ICstDQogZnMvaHVnZXRsYmZzL2lub2RlLmMgICAgICAgICAgICAg
ICAgICAgICAgfCAgIDQgKy0NCiBmcy9qZmZzMi9maWxlLmMgICAgICAgICAgICAgICAgICAgICAg
ICAgICB8ICAgOCArLQ0KIGZzL2pmcy9pbm9kZS5jICAgICAgICAgICAgICAgICAgICAgICAgICAg
IHwgICA2ICstDQogZnMvbGliZnMuYyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAg
IDQgKy0NCiBmcy9taW5peC9pbm9kZS5jICAgICAgICAgICAgICAgICAgICAgICAgICB8ICAgMiAr
LQ0KIGZzL25mcy9maWxlLmMgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwgICA2ICstDQog
ZnMvbmlsZnMyL2lub2RlLmMgICAgICAgICAgICAgICAgICAgICAgICAgfCAgIDYgKy0NCiBmcy9u
dGZzMy9maWxlLmMgICAgICAgICAgICAgICAgICAgICAgICAgICB8ICAgNyArLQ0KIGZzL250ZnMz
L2lub2RlLmMgICAgICAgICAgICAgICAgICAgICAgICAgIHwgICA2ICstDQogZnMvbnRmczMvbnRm
c19mcy5oICAgICAgICAgICAgICAgICAgICAgICAgfCAgIDQgKy0NCiBmcy9vY2ZzMi9hb3BzLmMg
ICAgICAgICAgICAgICAgICAgICAgICAgICB8ICAgNCArLQ0KIGZzL29tZnMvZmlsZS5jICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIHwgICAyICstDQogZnMvb3JhbmdlZnMvaW5vZGUuYyAgICAg
ICAgICAgICAgICAgICAgICAgfCAgIDYgKy0NCiBmcy91Ymlmcy9maWxlLmMgICAgICAgICAgICAg
ICAgICAgICAgICAgICB8ICAgNCArLQ0KIGZzL3VkZi9pbm9kZS5jICAgICAgICAgICAgICAgICAg
ICAgICAgICAgIHwgICA5ICstDQogZnMvdWZzL2lub2RlLmMgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgfCAgIDYgKy0NCiBmcy92Ym94c2YvZmlsZS5jICAgICAgICAgICAgICAgICAgICAgICAg
ICB8ICAgNCArLQ0KIGluY2x1ZGUvbGludXgvYnVmZmVyX2hlYWQuaCAgICAgICAgICAgICAgIHwg
ICA0ICstDQogaW5jbHVkZS9saW51eC9mcy5oICAgICAgICAgICAgICAgICAgICAgICAgfCAgIDYg
Ky0NCiBtbS9maWxlbWFwLmMgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB8ICAgNCArLQ0K
IG1tL3NobWVtLmMgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwgICA0ICstDQogNDcg
ZmlsZXMgY2hhbmdlZCwgMTc2IGluc2VydGlvbnMoKyksIDIxMyBkZWxldGlvbnMoLSkNCg0KLS0g
DQoyLjM0LjENCg==


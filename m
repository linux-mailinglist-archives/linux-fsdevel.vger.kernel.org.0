Return-Path: <linux-fsdevel+bounces-24735-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E7769442B7
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Aug 2024 07:30:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EB678B21777
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Aug 2024 05:30:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1673813D897;
	Thu,  1 Aug 2024 05:30:30 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from SHSQR01.spreadtrum.com (unknown [222.66.158.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E9C8EC2;
	Thu,  1 Aug 2024 05:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=222.66.158.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722490229; cv=none; b=Re7LMAD7jsWZkpNOU054pgEmY2Y2oP5r+aLCaCV7i44DPmss2pKwTj5UI2qXgjDo9su37QLhUzTbbCm/wIwzP9qpyPRI+jk9BxLjRmBERF+Wox/iArirlX45ss0JeJ7YvP/8q8fnnmy7YM67Rrhh3OT3FzOjbqHkWhEohTQ/Qcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722490229; c=relaxed/simple;
	bh=A487K/HlTfObpmp7htZEGKjDfQEBCpQkCZDFHSDmdqE=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=gCS7KMMQCDcFOdf5dMwapvVRh0JQAX8rdbaMMk2wroSJ8qIbjWGLNKvr+f3DeQHVswzmsy4czgWk0ebSoVDR1iQUjbF6W23r5GZeGpwErEaRllbuyxUxf8nasnEiEWiyzj4X3iw6VmhE0SDbmMTIXNSNohkXSYu3y06mxETud9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com; spf=pass smtp.mailfrom=unisoc.com; arc=none smtp.client-ip=222.66.158.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=unisoc.com
Received: from dlp.unisoc.com ([10.29.3.86])
	by SHSQR01.spreadtrum.com with ESMTP id 4715Tpw6019808;
	Thu, 1 Aug 2024 13:29:51 +0800 (+08)
	(envelope-from Dongliang.Cui@unisoc.com)
Received: from SHDLP.spreadtrum.com (bjmbx02.spreadtrum.com [10.0.64.8])
	by dlp.unisoc.com (SkyGuard) with ESMTPS id 4WZHSY2q6xz2LQJ6l;
	Thu,  1 Aug 2024 13:23:57 +0800 (CST)
Received: from BJMBX02.spreadtrum.com (10.0.64.8) by BJMBX02.spreadtrum.com
 (10.0.64.8) with Microsoft SMTP Server (TLS) id 15.0.1497.23; Thu, 1 Aug 2024
 13:29:49 +0800
Received: from BJMBX02.spreadtrum.com ([fe80::c8c3:f3a0:9c9f:b0fb]) by
 BJMBX02.spreadtrum.com ([fe80::c8c3:f3a0:9c9f:b0fb%19]) with mapi id
 15.00.1497.023; Thu, 1 Aug 2024 13:29:49 +0800
From: =?utf-8?B?5bSU5Lic5LquIChEb25nbGlhbmcgQ3VpKQ==?=
	<Dongliang.Cui@unisoc.com>
To: Christoph Hellwig <hch@infradead.org>
CC: "linkinjeon@kernel.org" <linkinjeon@kernel.org>,
        "sj1557.seo@samsung.com"
	<sj1557.seo@samsung.com>,
        "linux-fsdevel@vger.kernel.org"
	<linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "niuzhiguo84@gmail.com"
	<niuzhiguo84@gmail.com>,
        =?utf-8?B?546L55qTIChIYW9faGFvIFdhbmcp?=
	<Hao_hao.Wang@unisoc.com>,
        =?utf-8?B?546L56eRIChLZSBXYW5nKQ==?=
	<Ke.Wang@unisoc.com>,
        =?utf-8?B?54mb5b+X5Zu9IChaaGlndW8gTml1KQ==?=
	<Zhiguo.Niu@unisoc.com>,
        "cuidongliang390@gmail.com"
	<cuidongliang390@gmail.com>
Subject: Re: [PATCH v3] exfat: check disk status during buffer write
Thread-Topic: [PATCH v3] exfat: check disk status during buffer write
Thread-Index: AdrjuT5YHG+eyC7TRnyilKnSRw6r3Q==
Date: Thu, 1 Aug 2024 05:29:48 +0000
Message-ID: <8d0405eea668458d9507aa36e223f503@BJMBX02.spreadtrum.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-exchange-transport-fromentityheader: Hosted
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MAIL:SHSQR01.spreadtrum.com 4715Tpw6019808

QmVzaWRlcyB0aGUgYWRkaXRpb25hbCBjaGVja3MgZm9yIHRoZSBzaHV0ZG93biBmbGFnIGFscmVh
ZHkgbWVudGlvbmVkIHRoZSBzdWJqZWN0IGlzIG5vdyBpbmNvcnJlY3QgSSB0aGluaywgaXQgc2hv
dWxkIHRhbGsgYWJvdXQgaW1wbGVtZW50aW5nIHNodXRkb3duIGhhbmRsaW5nLg0KDQpJbiBjYXNl
IHlvdSBoYXZlbid0IGRvbmUgc28geWV0LCBwbGVhc2UgYWxzbyBzZWUgaWYgZXhmYXQgbm93IHBh
c3NlcyB0aGUgdmFyaW91cyB0ZXN0Y2FzZXMgaW4geGZzdGVzdHMgdGhhdCBleGVyY2lzZSB0aGUg
c2h1dGRvd24gcGF0aC4NCg0KT3RoZXJ3aXNlIHRoaXMgbG9va3MgcmVhc29uYWJsZSB0byBtZSwg
dGhhbmtzIGZvciB0aGUgd29yayENCg0KSGkgQ2hyaXN0b3BoLA0KDQpUaGFuayB5b3UgZm9yIHlv
dXIgc3VnZ2VzdGlvbi4gSSB0aGluayB0aGUgY3VycmVudCBwYXRjaCBpcyBwcmltYXJpbHkgYWlt
ZWQgYXQgYWRkcmVzc2luZyB0aGUgaXNzdWUgb2YgaG90cGx1ZyBhbmQgZW5zdXJpbmcgd3JpdGVy
cyBhcmUgbm90aWZpZWQgd2hlbiBhIGRldmljZSBoYXMgYmVlbiBlamVjdGVkLg0KDQpQcmV2aW91
c2x5LCBleGZhdCBkaWRuJ3QgaGF2ZSBhIHNodXRkb3duIHByb2Nlc3MgaW5oZXJlbnRseSwgYW5k
IGhvdHBsdWcgZGlkbid0IHBvc2UgYW55IHNpZ25pZmljYW50IGlzc3VlcywgZXhjZXB0IGZvciB0
aGUgb25lIHdlJ3JlIGRpc2N1c3NpbmcgaW4gdGhpcyBlbWFpbC4NCg0KVGhlcmVmb3JlLCByZWdh
cmRpbmcgd2hhdCBzcGVjaWZpYyBhY3Rpb25zIHNob3VsZCBiZSB0YWtlbiBkdXJpbmcgc2h1dGRv
d24sIEkgd291bGQgYXBwcmVjaWF0ZSB5b3VyIGlucHV0IG9yIGFueSBzdWdnZXN0aW9ucyBmcm9t
IFN1bmdqb25nIGFuZCBOYW1qYWUuIA0KDQpBZGRpdGlvbmFsbHksIGNhbiB0aGUgc2h1dGRvd24g
aGFuZGxpbmcgYmUgc3VwcGxlbWVudGVkIHdpdGggYW5vdGhlciBwYXRjaCBpZiB0aGVyZSBpcyBp
bmRlZWQgYSBuZWVkIHRvIGltcGxlbWVudCBzb21lIGV4ZmF0IHNodXRkb3duIHByb2Nlc3Nlcz8N
Cg0KSEkgU3VuZ2pvbmcgYW5kIE5hbWphZS4NCg0KQmFzZWQgb24gdGhlIGFib3ZlLCB3aGF0IGRv
IHlvdSB0aGluaywgb3IgZG8geW91IGhhdmUgYW55IHN1Z2dlc3Rpb25zPw0K


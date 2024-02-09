Return-Path: <linux-fsdevel+bounces-10962-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A2D284F744
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Feb 2024 15:29:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F29F5284342
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Feb 2024 14:29:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AFA86997D;
	Fri,  9 Feb 2024 14:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="n2KL3eDA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7575E69956
	for <linux-fsdevel@vger.kernel.org>; Fri,  9 Feb 2024 14:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707488948; cv=none; b=Sahsns+jhlfCkkncVmL4wuP8jWLH0h65Zc15qXS26ow9KZ/XrErT1nbnjJE1oW9qcRcF045HW0DLGToWQEs665enk+SsjlydQDvcgKXn9aJ3JDO1dMu0h0++DCqg+1v+M+vtL2UnhTw3x5poIzv3th86mJfHP3SE6OisLIq8Rk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707488948; c=relaxed/simple;
	bh=Dswm6KHnt6fctGMQEhkJJsY2zjJGUEaprm9g9WiZFfQ=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version:
	 References; b=UDKVWjhsCQTHUvbg8cEUDI9upu9w0w3+pIvDqg91F/MxIYifiaEfB37sE1WFlEQiutb+5rWcn31jqFRusQ9DrOzmQcDldl/PBX3au1VsHycAs6T/y8RH20JrGV8H/yFc+c+CYMQYTFyvzN8amC/BuJg24jlvbxnQIJI3yA3HtHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=n2KL3eDA; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20240209142904euoutp02ce564f886d3d0c1bb9b090ca4e273e79~yOCX3KOq82377223772euoutp02Y
	for <linux-fsdevel@vger.kernel.org>; Fri,  9 Feb 2024 14:29:04 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20240209142904euoutp02ce564f886d3d0c1bb9b090ca4e273e79~yOCX3KOq82377223772euoutp02Y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1707488944;
	bh=Dswm6KHnt6fctGMQEhkJJsY2zjJGUEaprm9g9WiZFfQ=;
	h=From:To:CC:Subject:Date:References:From;
	b=n2KL3eDASHuDHAmLDNeV3h0bS6bxQ2xkSCMjp+bLEfxXqBf+eUhWG/ATcjg7wwv4D
	 5//xY4jRI5JMj9VS/cRLzvuKyP7zfmEHeQUcKVHomYniFi612c4nKMEI5meIt53taN
	 D5ndrjjkSlIxTuCKKH3e866X0VFtGah9LIduUfRs=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTP id
	20240209142903eucas1p2ea029c7e25afcab2b3116ee58615490f~yOCXVzbKe2329623296eucas1p2U;
	Fri,  9 Feb 2024 14:29:03 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
	eusmges3new.samsung.com (EUCPMTA) with SMTP id E7.2E.09552.FA636C56; Fri,  9
	Feb 2024 14:29:03 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20240209142903eucas1p1f211ca6fc40a788e833de062e2772c41~yOCW6KAeo3259232592eucas1p1B;
	Fri,  9 Feb 2024 14:29:03 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
	eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20240209142903eusmtrp17c0f58b9cd349b795e4af0519634af71~yOCW5hFSC0528405284eusmtrp1w;
	Fri,  9 Feb 2024 14:29:03 +0000 (GMT)
X-AuditID: cbfec7f5-853ff70000002550-86-65c636af76a3
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
	eusmgms2.samsung.com (EUCPMTA) with SMTP id 8E.A3.10702.FA636C56; Fri,  9
	Feb 2024 14:29:03 +0000 (GMT)
Received: from CAMSVWEXC01.scsc.local (unknown [106.1.227.71]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20240209142903eusmtip1f20a48f3b94b23fb7387f39f331b4b72~yOCWwn82c2720027200eusmtip1u;
	Fri,  9 Feb 2024 14:29:03 +0000 (GMT)
Received: from CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348) by
	CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) with Microsoft SMTP
	Server (TLS) id 15.0.1497.2; Fri, 9 Feb 2024 14:29:02 +0000
Received: from CAMSVWEXC02.scsc.local ([::1]) by CAMSVWEXC02.scsc.local
	([fe80::3c08:6c51:fa0a:6384%13]) with mapi id 15.00.1497.012; Fri, 9 Feb
	2024 14:29:02 +0000
From: Daniel Gomez <da.gomez@samsung.com>
To: "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
	"brauner@kernel.org" <brauner@kernel.org>, "jack@suse.cz" <jack@suse.cz>,
	"hughd@google.com" <hughd@google.com>, "akpm@linux-foundation.org"
	<akpm@linux-foundation.org>
CC: "dagmcr@gmail.com" <dagmcr@gmail.com>, "linux-fsdevel@vger.kernel.org"
	<linux-fsdevel@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>,
	"willy@infradead.org" <willy@infradead.org>, "hch@infradead.org"
	<hch@infradead.org>, "mcgrof@kernel.org" <mcgrof@kernel.org>, Pankaj Raghav
	<p.raghav@samsung.com>, "gost.dev@samsung.com" <gost.dev@samsung.com>,
	"Daniel Gomez" <da.gomez@samsung.com>
Subject: [RFC PATCH 0/9] shmem: fix llseek in hugepages
Thread-Topic: [RFC PATCH 0/9] shmem: fix llseek in hugepages
Thread-Index: AQHaW2RT7xV/K52STUGwCHRBbQ9MBQ==
Date: Fri, 9 Feb 2024 14:29:01 +0000
Message-ID: <20240209142901.126894-1-da.gomez@samsung.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
Content-Type: text/plain; charset="utf-8"
Content-ID: <FC9A37F54832EA47B4528BC8F1D3C09F@scsc.local>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrOKsWRmVeSWpSXmKPExsWy7djP87rrzY6lGvTNNLSYs34Nm8Xrw58Y
	Lc72/WazOD1hEZPF0099LBazpzczWezZe5LF4vKuOWwW99b8Z7W4MeEpo8X5v8dZLX7/mMPm
	wOOxc9Zddo8Fm0o9Nq/Q8ti0qpPNY9OnSeweJ2b8ZvE4s+AIu8fnTXIem568ZQrgjOKySUnN
	ySxLLdK3S+DKmDTxBXtBh3jFvxnxDYx7xLoYOTkkBEwkls/9zNLFyMUhJLCCUeLq7oXMEM4X
	RomtF/9DZT4zSpyb858dpmVpx1JGiMRyRonOhs1McFWvLy2BypxmlLg//wQzwuS9f5hA+tkE
	NCX2ndzEDpIQEXjOKNG6+yOYwyxwm1liTvssoH4ODmEBc4nFU5JAGkQEbCQ2NTQzQdh6Elfb
	1jOC2CwCKhKHDxwCK+cVsJKYMTkbJMwoICvxaOUvsFuZBcQlbj2ZzwRxt6DEotl7mCFsMYl/
	ux6yQdg6EmevP2GEsA0kti7dxwJhK0p0HLvJBjKeGejm9bv0IUZaSsx+P4sNwlaUmNL9EGwV
	L9D4kzOfgMNLQuAfp8ST1Uuh4eUi8X3OF6i9whKvjm+BistInJ7cwzKBUXsWklNnIaybhWTd
	LCTrZiFZt4CRdRWjeGppcW56arFxXmq5XnFibnFpXrpecn7uJkZg2jv97/jXHYwrXn3UO8TI
	xMF4iFGCg1lJhDdkyZFUId6UxMqq1KL8+KLSnNTiQ4zSHCxK4ryqKfKpQgLpiSWp2ampBalF
	MFkmDk6pBibj9CW9N7WPdSWxXd6u2hCwYfeMC8/ULqSeqeH1tFNdkFE8TV2DL1RQqXqr3qTr
	e66sS1zEP+vU/t3RH35dV/kV/Y7rc4Dvio690U/eyksfCzA7uC23qT7H6fvfDA+LHquPX1vE
	w5bllEc67Xrp7PPA6l1TupHz/JonRQdzHXc7aW8SytrRFS3kpGfy/oHf34ttKUG+l4ofrKxy
	mXVYd6tE5r3ZT9fH/OXfU3VDIzTpXtpeEa267vKb/05PDZrnWqh/TIzVSGj3hbdeGpY5qyWN
	X1nHZ4se9NvqFzLhWd8NBfPG3gszjtV4uHzb+F3jcW1fmqnsJ6mfRjNd81bb/mYNk5rOp+UQ
	6f/16P+Ut0osxRmJhlrMRcWJAAPfo1nqAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrEKsWRmVeSWpSXmKPExsVy+t/xu7rrzY6lGpz6ImIxZ/0aNovXhz8x
	Wpzt+81mcXrCIiaLp5/6WCxmT29mstiz9ySLxeVdc9gs7q35z2pxY8JTRovzf4+zWvz+MYfN
	gcdj56y77B4LNpV6bF6h5bFpVSebx6ZPk9g9Tsz4zeJxZsERdo/Pm+Q8Nj15yxTAGaVnU5Rf
	WpKqkJFfXGKrFG1oYaRnaGmhZ2RiqWdobB5rZWSqpG9nk5Kak1mWWqRvl6CXMWniC/aCDvGK
	fzPiGxj3iHUxcnJICJhILO1YyghiCwksZZS4Oc8QIi4jsfHLVVYIW1jiz7UuNoiaj4wSTS1B
	EPZpRomlzxIh7BWMEo83VYHYbAKaEvtObmLvYuTiEBF4yigx/fchFhCHWeA2s8Sc9llA2zg4
	hAXMJRZPSQJpEBGwkdjU0MwEYetJXG1bD3YQi4CKxOEDh8DKeQWsJGZMzgYJMwrISjxa+Ysd
	xGYWEJe49WQ+E8SdAhJL9pxnhrBFJV4+/gd1v47E2etPGCFsA4mtS/exQNiKEh3HbrKBjGcG
	unn9Ln2IkZYSs9/PYoOwFSWmdD8EW8UrIChxcuYTlgmMUrOQbJ6F0D0LSfcsJN2zkHQvYGRd
	xSiSWlqcm55bbKRXnJhbXJqXrpecn7uJEZiYth37uWUH48pXH/UOMTJxMB5ilOBgVhLhDVly
	JFWINyWxsiq1KD++qDQntfgQoykwgCYyS4km5wNTY15JvKGZgamhiZmlgamlmbGSOK9nQUei
	kEB6YklqdmpqQWoRTB8TB6dUAxMb3zzDTbHmLzeznFxxT3ONdmmKt+2pW6rq27izFJ2PbpFa
	65+Xv/7pCvu1bzz3x0jLrpkdK7Fkd+pVA/GpOzt79nKYfz6vX1PGvN9C7q+LcEFZZE3+Fcur
	V182fJt8pCbXZ6P2sQ8WFS9eNlS+0nvV6zd915U9b+8xCv257rbh0e+ngf8C2qzO8GwqZ639
	4/lv4z/tCedPMP7+feaKti2bZsuFHaw2f2YsOL6si+3vnt8rPcTYnfje7djJa/jWwe/1DoUI
	s7nHNyXtmDPl+pHHv7dulWjmkytfFXbl3J87VW7KM46rfI/z5c+L9ZsecNTRq7/+W2zrxaVV
	86tC5pxJyqw5pXGrvWDONBdm/dOflViKMxINtZiLihMBVjP0VtUDAAA=
X-CMS-MailID: 20240209142903eucas1p1f211ca6fc40a788e833de062e2772c41
X-Msg-Generator: CA
X-RootMTR: 20240209142903eucas1p1f211ca6fc40a788e833de062e2772c41
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20240209142903eucas1p1f211ca6fc40a788e833de062e2772c41
References: <CGME20240209142903eucas1p1f211ca6fc40a788e833de062e2772c41@eucas1p1.samsung.com>

SGksDQoNClRoZSBmb2xsb3dpbmcgc2VyaWVzIGZpeGVzIHRoZSBnZW5lcmljLzI4NSBhbmQgZ2Vu
ZXJpYy80MzYgZnN0ZXN0cyBmb3IgaHVnZQ0KcGFnZXMgKGh1Z2U9YWx3YXlzKS4gVGhlc2UgYXJl
IHRlc3RzIGZvciBsbHNlZWsgKFNFRUtfSE9MRSBhbmQgU0VFS19EQVRBKS4NCg0KVGhlIGltcGxl
bWVudGF0aW9uIHRvIGZpeCBhYm92ZSB0ZXN0cyBpcyBiYXNlZCBvbiBpb21hcCBwZXItYmxvY2sg
dHJhY2tpbmcgZm9yDQp1cHRvZGF0ZSBhbmQgZGlydHkgc3RhdGVzIGJ1dCBhcHBsaWVkIHRvIHNo
bWVtIHVwdG9kYXRlIGZsYWcuDQoNClRoZSBtb3RpdmF0aW9uIGlzIHRvIGF2b2lkIGFueSByZWdy
ZXNzaW9ucyBpbiB0bXBmcyBvbmNlIGl0IGdldHMgc3VwcG9ydCBmb3INCmxhcmdlIGZvbGlvcy4N
Cg0KVGVzdGluZyB3aXRoIGtkZXZvcHMNClRlc3RpbmcgaGFzIGJlZW4gcGVyZm9ybWVkIHVzaW5n
IGZzdGVzdHMgd2l0aCBrZGV2b3BzIGZvciB0aGUgdjYuOC1yYzIgdGFnLg0KVGhlcmUgYXJlIGN1
cnJlbnRseSBkaWZmZXJlbnQgcHJvZmlsZXMgc3VwcG9ydGVkIFsxXSBhbmQgZm9yIGVhY2ggb2Yg
dGhlc2UsDQphIGJhc2VsaW5lIG9mIDIwIGxvb3BzIGhhcyBiZWVuIHBlcmZvcm1lZCB3aXRoIHRo
ZSBmb2xsb3dpbmcgZmFpbHVyZXMgZm9yDQpodWdlcGFnZXMgcHJvZmlsZXM6IGdlbmVyaWMvMDgw
LCBnZW5lcmljLzEyNiwgZ2VuZXJpYy8xOTMsIGdlbmVyaWMvMjQ1LA0KZ2VuZXJpYy8yODUsIGdl
bmVyaWMvNDM2LCBnZW5lcmljLzU1MSwgZ2VuZXJpYy82MTkgYW5kIGdlbmVyaWMvNzMyLg0KDQpJ
ZiBhbnlvbmUgaW50ZXJlc3RlZCwgcGxlYXNlIGZpbmQgYWxsIG9mIHRoZSBmYWlsdXJlcyBpbiB0
aGUgZXhwdW5nZXMgZGlyZWN0b3J5Og0KaHR0cHM6Ly9naXRodWIuY29tL2xpbnV4LWtkZXZvcHMv
a2Rldm9wcy90cmVlL21hc3Rlci93b3JrZmxvd3MvZnN0ZXN0cy9leHB1bmdlcy82LjguMC1yYzIv
dG1wZnMvdW5hc3NpZ25lZA0KDQpbMV0gdG1wZnMgcHJvZmlsZXMgc3VwcG9ydGVkIGluIGtkZXZv
cHM6IGRlZmF1bHQsIHRtcGZzX25vc3dhcF9odWdlX25ldmVyLA0KdG1wZnNfbm9zd2FwX2h1Z2Vf
YWx3YXlzLCB0bXBmc19ub3N3YXBfaHVnZV93aXRoaW5fc2l6ZSwNCnRtcGZzX25vc3dhcF9odWdl
X2FkdmlzZSwgdG1wZnNfaHVnZV9hbHdheXMsIHRtcGZzX2h1Z2Vfd2l0aGluX3NpemUgYW5kDQp0
bXBmc19odWdlX2FkdmlzZS4NCg0KTW9yZSBpbmZvcm1hdGlvbjoNCmh0dHBzOi8vZ2l0aHViLmNv
bS9saW51eC1rZGV2b3BzL2tkZXZvcHMvdHJlZS9tYXN0ZXIvd29ya2Zsb3dzL2ZzdGVzdHMvZXhw
dW5nZXMvNi44LjAtcmMyL3RtcGZzL3VuYXNzaWduZWQNCg0KQWxsIHRoZSBwYXRjaGVzIGhhcyBi
ZWVuIHRlc3RlZCBvbiB0b3Agb2YgdjYuOC1yYzIgYW5kIHJlYmFzZWQgb250byBsYXRlc3QgbmV4
dA0KdGFnIGF2YWlsYWJsZSAobmV4dC0yMDI0MDIwOSkuDQoNCkRhbmllbA0KDQpEYW5pZWwgR29t
ZXogKDgpOg0KICBzaG1lbTogYWRkIHBlci1ibG9jayB1cHRvZGF0ZSB0cmFja2luZyBmb3IgaHVn
ZXBhZ2VzDQogIHNobWVtOiBtb3ZlIGZvbGlvIHplcm8gb3BlcmF0aW9uIHRvIHdyaXRlX2JlZ2lu
KCkNCiAgc2htZW06IGV4aXQgc2htZW1fZ2V0X2ZvbGlvX2dmcCgpIGlmIGJsb2NrIGlzIHVwdG9k
YXRlDQogIHNobWVtOiBjbGVhcl9oaWdocGFnZSgpIGlmIGJsb2NrIGlzIG5vdCB1cHRvZGF0ZQ0K
ICBzaG1lbTogc2V0IGZvbGlvIHVwdG9kYXRlIHdoZW4gcmVjbGFpbQ0KICBzaG1lbTogY2hlY2sg
aWYgYSBibG9jayBpcyB1cHRvZGF0ZSBiZWZvcmUgc3BsaWNlIGludG8gcGlwZQ0KICBzaG1lbTog
Y2xlYXIgdXB0b2RhdGUgYmxvY2tzIGFmdGVyIFBVTkNIX0hPTEUNCiAgc2htZW06IGVuYWJsZSBw
ZXItYmxvY2sgdXB0b2RhdGUNCg0KUGFua2FqIFJhZ2hhdiAoMSk6DQogIHNwbGljZTogZG9uJ3Qg
Y2hlY2sgZm9yIHVwdG9kYXRlIGlmIHBhcnRpYWxseSB1cHRvZGF0ZSBpcyBpbXBsDQoNCiBmcy9z
cGxpY2UuYyB8ICAxNyArKy0NCiBtbS9zaG1lbS5jICB8IDM0MCArKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKystLS0tDQogMiBmaWxlcyBjaGFuZ2VkLCAzMzIg
aW5zZXJ0aW9ucygrKSwgMjUgZGVsZXRpb25zKC0pDQoNCi0tIA0KMi40My4wDQo=


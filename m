Return-Path: <linux-fsdevel+bounces-62369-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69D64B8F75B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Sep 2025 10:17:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C02217F391
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Sep 2025 08:17:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E64C22F659B;
	Mon, 22 Sep 2025 08:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b="N2AD/avK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from pdx-out-014.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-014.esa.us-west-2.outbound.mail-perimeter.amazon.com [35.83.148.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46351277CBF;
	Mon, 22 Sep 2025 08:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.83.148.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758529053; cv=none; b=diuOSdMxH/Ly30pUJL7G0KLGyqG1II5rwoxV/QHRCWHL4ynJlLEwncHOG6m4P7a+MgmXnsuXH1LgOS7MEt4xlbCm/QibNogjM+j2zaRzk/c6rYnTo753mCue8KCMiMp6RTWrFcJ/HggkWW+9bs6LaP83Ag1g2TUrV19pQOymwp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758529053; c=relaxed/simple;
	bh=ojhBJOxHhGb0SD01wdfc89xOlCTZBkPkITxJQOsz22U=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=e5v82T9CHcSoSng2BvMe6a6YzQP1wf3SYOKNQyZqF/kR3hcuhUsA5+tJ6bWeEQkLqtmp0ptFv6N/QUu2jeXlvwVf1o7l5AKhCQE8txdP4s2BA6J6RxTOT1RKdcE/IuVqSuPoigxkKw0ddXP+4Ob/oI+wpcOvDaY9y7NbU0dsq6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de; spf=pass smtp.mailfrom=amazon.de; dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b=N2AD/avK; arc=none smtp.client-ip=35.83.148.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazoncorp2;
  t=1758529051; x=1790065051;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ojhBJOxHhGb0SD01wdfc89xOlCTZBkPkITxJQOsz22U=;
  b=N2AD/avKphuxD/FakiUcMR+tWl0dFTNVv4YXqUPe4gIxweWlbccdxocI
   OwONHQ0X+9d1OfWMaeznF204KXyBKjdlHtWTzyrIXqLOA6agC7l+UuFR2
   C0xINl7QI0vAE8sVJNdDc0zx+UBrwXU5qS08sLF6E196QkIer3L9OwxA2
   L4gQmq5yO1relmclBPEhHaluaWcda4fCCnHXdRe7rBxaLXpRHp2kC6ciy
   qlepgNdk0xTrA7dpihCjPkj3B5KzfQ7cBcRSQJci9jqcqlELx4K0mszlL
   zpqnM529TB421RunDIjPWycss295TSt8awy71NStJuwJv91GIcTKGkILX
   A==;
X-CSE-ConnectionGUID: K9Z+0Zg9R9y8wImayrYigw==
X-CSE-MsgGUID: NyDjXeDGQeioh0WBkX8VTQ==
X-IronPort-AV: E=Sophos;i="6.18,284,1751241600"; 
   d="scan'208";a="3343833"
Received: from ip-10-5-9-48.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.9.48])
  by internal-pdx-out-014.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2025 08:17:29 +0000
Received: from EX19MTAUWB002.ant.amazon.com [10.0.38.20:31320]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.25.189:2525] with esmtp (Farcaster)
 id 9a698592-8561-49e5-b6d8-e6c1950d1a64; Mon, 22 Sep 2025 08:17:29 +0000 (UTC)
X-Farcaster-Flow-ID: 9a698592-8561-49e5-b6d8-e6c1950d1a64
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20;
 Mon, 22 Sep 2025 08:17:28 +0000
Received: from dev-dsk-acsjakub-1b-6f9934e2.eu-west-1.amazon.com
 (172.19.75.107) by EX19D001UWA001.ant.amazon.com (10.13.138.214) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20; Mon, 22 Sep 2025
 08:17:26 +0000
From: Jakub Acs <acsjakub@amazon.de>
To: <linux-fsdevel@vger.kernel.org>
CC: <acsjakub@amazon.de>, Andrew Morton <akpm@linux-foundation.org>, "David
 Hildenbrand" <david@redhat.com>, Vlastimil Babka <vbabka@suse.cz>, "Lorenzo
 Stoakes" <lorenzo.stoakes@oracle.com>, Jinjiang Tu <tujinjiang@huawei.com>,
	Suren Baghdasaryan <surenb@google.com>, Penglei Jiang
	<superman.xpt@gmail.com>, Mark Brown <broonie@kernel.org>, Baolin Wang
	<baolin.wang@linux.alibaba.com>, Ryan Roberts <ryan.roberts@arm.com>, "Andrei
 Vagin" <avagin@gmail.com>, =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?=
	<mirq-linux@rere.qmqm.pl>, Stephen Rothwell <sfr@canb.auug.org.au>, "Muhammad
 Usama Anjum" <usama.anjum@collabora.com>, <linux-kernel@vger.kernel.org>,
	<stable@vger.kernel.org>
Subject: [PATCH v2] fs/proc: check p->vec_buf for NULL
Date: Mon, 22 Sep 2025 08:17:13 +0000
Message-ID: <20250922081713.77303-1-acsjakub@amazon.de>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ClientProxiedBy: EX19D043UWC001.ant.amazon.com (10.13.139.202) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

V2hlbiBQQUdFTUFQX1NDQU4gaW9jdGwgaW52b2tlZCB3aXRoIHZlY19sZW4gPSAwIHJlYWNoZXMK
cGFnZW1hcF9zY2FuX2JhY2tvdXRfcmFuZ2UoKSwga2VybmVsIHBhbmljcyB3aXRoIG51bGwtcHRy
LWRlcmVmOgoKWyAgIDQ0LjkzNjgwOF0gT29wczogZ2VuZXJhbCBwcm90ZWN0aW9uIGZhdWx0LCBw
cm9iYWJseSBmb3Igbm9uLWNhbm9uaWNhbCBhZGRyZXNzIDB4ZGZmZmZjMDAwMDAwMDAwMDogMDAw
MCBbIzFdIFNNUCBERUJVR19QQUdFQUxMT0MgS0FTQU4gTk9QVEkKWyAgIDQ0LjkzNzc5N10gS0FT
QU46IG51bGwtcHRyLWRlcmVmIGluIHJhbmdlIFsweDAwMDAwMDAwMDAwMDAwMDAtMHgwMDAwMDAw
MDAwMDAwMDA3XQpbICAgNDQuOTM4MzkxXSBDUFU6IDEgVUlEOiAwIFBJRDogMjQ4MCBDb21tOiBy
ZXByb2R1Y2VyIE5vdCB0YWludGVkIDYuMTcuMC1yYzYgIzIyIFBSRUVNUFQobm9uZSkKWyAgIDQ0
LjkzOTA2Ml0gSGFyZHdhcmUgbmFtZTogUUVNVSBTdGFuZGFyZCBQQyAoaTQ0MEZYICsgUElJWCwg
MTk5NiksIEJJT1MgcmVsLTEuMTYuMy0wLWdhNmVkNmI3MDFmMGEtcHJlYnVpbHQucWVtdS5vcmcg
MDQvMDEvMjAxNApbICAgNDQuOTM5OTM1XSBSSVA6IDAwMTA6cGFnZW1hcF9zY2FuX3RocF9lbnRy
eS5pc3JhLjArMHg3NDEvMHhhODAKCjxzbmlwIHJlZ2lzdGVycywgdW5yZWxpYWJsZSB0cmFjZT4K
ClsgICA0NC45NDY4MjhdIENhbGwgVHJhY2U6ClsgICA0NC45NDcwMzBdICA8VEFTSz4KWyAgIDQ0
Ljk0OTIxOV0gIHBhZ2VtYXBfc2Nhbl9wbWRfZW50cnkrMHhlYy8weGZhMApbICAgNDQuOTUyNTkz
XSAgd2Fsa19wbWRfcmFuZ2UuaXNyYS4wKzB4MzAyLzB4OTEwClsgICA0NC45NTQwNjldICB3YWxr
X3B1ZF9yYW5nZS5pc3JhLjArMHg0MTkvMHg3OTAKWyAgIDQ0Ljk1NDQyN10gIHdhbGtfcDRkX3Jh
bmdlKzB4NDFlLzB4NjIwClsgICA0NC45NTQ3NDNdICB3YWxrX3BnZF9yYW5nZSsweDMxZS8weDYz
MApbICAgNDQuOTU1MDU3XSAgX193YWxrX3BhZ2VfcmFuZ2UrMHgxNjAvMHg2NzAKWyAgIDQ0Ljk1
Njg4M10gIHdhbGtfcGFnZV9yYW5nZV9tbSsweDQwOC8weDk4MApbICAgNDQuOTU4Njc3XSAgd2Fs
a19wYWdlX3JhbmdlKzB4NjYvMHg5MApbICAgNDQuOTU4OTg0XSAgZG9fcGFnZW1hcF9zY2FuKzB4
MjhkLzB4OWMwClsgICA0NC45NjE4MzNdICBkb19wYWdlbWFwX2NtZCsweDU5LzB4ODAKWyAgIDQ0
Ljk2MjQ4NF0gIF9feDY0X3N5c19pb2N0bCsweDE4ZC8weDIxMApbICAgNDQuOTYyODA0XSAgZG9f
c3lzY2FsbF82NCsweDViLzB4MjkwClsgICA0NC45NjMxMTFdICBlbnRyeV9TWVNDQUxMXzY0X2Fm
dGVyX2h3ZnJhbWUrMHg3Ni8weDdlCgp2ZWNfbGVuID0gMCBpbiBwYWdlbWFwX3NjYW5faW5pdF9i
b3VuY2VfYnVmZmVyKCkgbWVhbnMgbm8gYnVmZmVycyBhcmUKYWxsb2NhdGVkIGFuZCBwLT52ZWNf
YnVmIHJlbWFpbnMgc2V0IHRvIE5VTEwuCgpUaGlzIGJyZWFrcyBhbiBhc3N1bXB0aW9uIG1hZGUg
bGF0ZXIgaW4gcGFnZW1hcF9zY2FuX2JhY2tvdXRfcmFuZ2UoKSwKdGhhdCBwYWdlX3JlZ2lvbiBp
cyBhbHdheXMgYWxsb2NhdGVkIGZvciBwLT52ZWNfYnVmX2luZGV4LgoKRml4IGl0IGJ5IGV4cGxp
Y2l0bHkgY2hlY2tpbmcgcC0+dmVjX2J1ZiBmb3IgTlVMTCBiZWZvcmUgZGVyZWZlcmVuY2luZy4K
Ck90aGVyIHNpdGVzIHRoYXQgbWlnaHQgcnVuIGludG8gc2FtZSBkZXJlZi1pc3N1ZSBhcmUgYWxy
ZWFkeSAoZGlyZWN0bHkKb3IgdHJhbnNpdGl2ZWx5KSBwcm90ZWN0ZWQgYnkgY2hlY2tpbmcgcC0+
dmVjX2J1Zi4KCk5vdGU6CkZyb20gUEFHRU1BUF9TQ0FOIG1hbiBwYWdlLCBpdCBzZWVtcyB2ZWNf
bGVuID0gMCBpcyB2YWxpZCB3aGVuIG5vIG91dHB1dAppcyByZXF1ZXN0ZWQgYW5kIGl0J3Mgb25s
eSB0aGUgc2lkZSBlZmZlY3RzIGNhbGxlciBpcyBpbnRlcmVzdGVkIGluLApoZW5jZSBpdCBwYXNz
ZXMgY2hlY2sgaW4gcGFnZW1hcF9zY2FuX2dldF9hcmdzKCkuCgpUaGlzIGlzc3VlIHdhcyBmb3Vu
ZCBieSBzeXprYWxsZXIuCgpGaXhlczogNTI1MjZjYTdmZGI5ICgiZnMvcHJvYy90YXNrX21tdTog
aW1wbGVtZW50IElPQ1RMIHRvIGdldCBhbmQgb3B0aW9uYWxseSBjbGVhciBpbmZvIGFib3V0IFBU
RXMiKQpTaWduZWQtb2ZmLWJ5OiBKYWt1YiBBY3MgPGFjc2pha3ViQGFtYXpvbi5kZT4KQ2M6IEFu
ZHJldyBNb3J0b24gPGFrcG1AbGludXgtZm91bmRhdGlvbi5vcmc+CkNjOiBEYXZpZCBIaWxkZW5i
cmFuZCA8ZGF2aWRAcmVkaGF0LmNvbT4KQ2M6IFZsYXN0aW1pbCBCYWJrYSA8dmJhYmthQHN1c2Uu
Y3o+CkNjOiBMb3JlbnpvIFN0b2FrZXMgPGxvcmVuem8uc3RvYWtlc0BvcmFjbGUuY29tPgpDYzog
SmluamlhbmcgVHUgPHR1amluamlhbmdAaHVhd2VpLmNvbT4KQ2M6IFN1cmVuIEJhZ2hkYXNhcnlh
biA8c3VyZW5iQGdvb2dsZS5jb20+CkNjOiBQZW5nbGVpIEppYW5nIDxzdXBlcm1hbi54cHRAZ21h
aWwuY29tPgpDYzogTWFyayBCcm93biA8YnJvb25pZUBrZXJuZWwub3JnPgpDYzogQmFvbGluIFdh
bmcgPGJhb2xpbi53YW5nQGxpbnV4LmFsaWJhYmEuY29tPgpDYzogUnlhbiBSb2JlcnRzIDxyeWFu
LnJvYmVydHNAYXJtLmNvbT4KQ2M6IEFuZHJlaSBWYWdpbiA8YXZhZ2luQGdtYWlsLmNvbT4KQ2M6
ICJNaWNoYcWCIE1pcm9zxYJhdyIgPG1pcnEtbGludXhAcmVyZS5xbXFtLnBsPgpDYzogU3RlcGhl
biBSb3Rod2VsbCA8c2ZyQGNhbmIuYXV1Zy5vcmcuYXU+CkNjOiBNdWhhbW1hZCBVc2FtYSBBbmp1
bSA8dXNhbWEuYW5qdW1AY29sbGFib3JhLmNvbT4KQ2M6IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5l
bC5vcmcKQ2M6IGxpbnV4LWZzZGV2ZWxAdmdlci5rZXJuZWwub3JnCkNjOiBzdGFibGVAdmdlci5r
ZXJuZWwub3JnCi0tLQogZnMvcHJvYy90YXNrX21tdS5jIHwgMyArKysKIDEgZmlsZSBjaGFuZ2Vk
LCAzIGluc2VydGlvbnMoKykKCmRpZmYgLS1naXQgYS9mcy9wcm9jL3Rhc2tfbW11LmMgYi9mcy9w
cm9jL3Rhc2tfbW11LmMKaW5kZXggMjljY2EwZTZkMGZmLi5iMjZhZTU1NmI0NDYgMTAwNjQ0Ci0t
LSBhL2ZzL3Byb2MvdGFza19tbXUuYworKysgYi9mcy9wcm9jL3Rhc2tfbW11LmMKQEAgLTI0MTcs
NiArMjQxNyw5IEBAIHN0YXRpYyB2b2lkIHBhZ2VtYXBfc2Nhbl9iYWNrb3V0X3JhbmdlKHN0cnVj
dCBwYWdlbWFwX3NjYW5fcHJpdmF0ZSAqcCwKIHsKIAlzdHJ1Y3QgcGFnZV9yZWdpb24gKmN1cl9i
dWYgPSAmcC0+dmVjX2J1ZltwLT52ZWNfYnVmX2luZGV4XTsKIAorCWlmICghcC0+dmVjX2J1ZikK
KwkJcmV0dXJuOworCiAJaWYgKGN1cl9idWYtPnN0YXJ0ICE9IGFkZHIpCiAJCWN1cl9idWYtPmVu
ZCA9IGFkZHI7CiAJZWxzZQotLSAKMi40Ny4zCgoKCgpBbWF6b24gV2ViIFNlcnZpY2VzIERldmVs
b3BtZW50IENlbnRlciBHZXJtYW55IEdtYkgKVGFtYXJhLURhbnotU3RyLiAxMwoxMDI0MyBCZXJs
aW4KR2VzY2hhZWZ0c2Z1ZWhydW5nOiBDaHJpc3RpYW4gU2NobGFlZ2VyCkVpbmdldHJhZ2VuIGFt
IEFtdHNnZXJpY2h0IENoYXJsb3R0ZW5idXJnIHVudGVyIEhSQiAyNTc3NjQgQgpTaXR6OiBCZXJs
aW4KVXN0LUlEOiBERSAzNjUgNTM4IDU5Nwo=



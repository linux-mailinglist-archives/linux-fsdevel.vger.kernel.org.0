Return-Path: <linux-fsdevel+bounces-62370-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 351C3B8F79D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Sep 2025 10:22:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EBFFF17FFFA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Sep 2025 08:22:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF0682FDC51;
	Mon, 22 Sep 2025 08:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b="brvk8si1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from pdx-out-013.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-013.esa.us-west-2.outbound.mail-perimeter.amazon.com [34.218.115.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 162E61917F1;
	Mon, 22 Sep 2025 08:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.218.115.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758529351; cv=none; b=D241zw3ZL/fWfu5oY785bEz/6cE0ad7DFqCKDDRvvbc5pk6F4Ry2gZnLkEZXxfDmCKGdxlZNzMem7z3gr++amE4XElda8XVWQUwevbAhTHlFERWgim2Z+QI3wHQARBrsVDoUaaNyhgotp63U4WOIAFjZuZZbsLi9Xs3X8YOiHNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758529351; c=relaxed/simple;
	bh=caEwddqtPSczT7z3uM0EFNttlXaBLds+C0H31gwqnvE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=cEHQ8eS3HgcZSq+PwT1OpkgzPIEUNE1kSyvcwSThbPnWECma65iTdY8Sf1ULhwAAp4XfHWMZvxKzNfr8ijerD0OKC3IKGsGS0oGZ66JvYyK1UqifdZaPy6F3bXo8qmf7tLKcQAoRDgoUfB2XSAHD46n8vWLSMiMaf25eFqXYsWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de; spf=pass smtp.mailfrom=amazon.de; dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b=brvk8si1; arc=none smtp.client-ip=34.218.115.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazoncorp2;
  t=1758529349; x=1790065349;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=caEwddqtPSczT7z3uM0EFNttlXaBLds+C0H31gwqnvE=;
  b=brvk8si1tG2CB02XN2xyOsPWjpmS9xstQJsiophy17NBiFqEWyGWSsa8
   fW5GDOWgxYIOOVEaaZ0zrNFLu/kAMfulBporcoZJQmkjkw3iNZ9VlRrOV
   e7V42J8pNkcKSXvT1HUprjkyr8+G/wUnaJfUtRhqHG4i0Wnosooyh8yya
   nfx7j06CbHQmPztXbWmQsaW4Le/UbSDU+CZoqMP0SwuAfk5IAUVBSQEcc
   g7NRLwgiA8WPbqbmjbi0plZZChKkRNDA2mssenrzHqngZCD8KKLFZx5i4
   NopBpNfAW90zKN0ERyJtq2trLB/VYINUaOhVVq+1B7NHgwJufvKEiTJQ7
   w==;
X-CSE-ConnectionGUID: VlXsPdwYSTy5PHFTuTM21w==
X-CSE-MsgGUID: ZpmByKcYTCOY1UHGBCSrHA==
X-IronPort-AV: E=Sophos;i="6.18,284,1751241600"; 
   d="scan'208";a="3343440"
Received: from ip-10-5-6-203.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.6.203])
  by internal-pdx-out-013.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2025 08:22:26 +0000
Received: from EX19MTAUWB002.ant.amazon.com [10.0.7.35:34737]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.57.172:2525] with esmtp (Farcaster)
 id c186fab0-1113-419d-8b5c-5c83b9abb535; Mon, 22 Sep 2025 08:22:26 +0000 (UTC)
X-Farcaster-Flow-ID: c186fab0-1113-419d-8b5c-5c83b9abb535
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20;
 Mon, 22 Sep 2025 08:22:26 +0000
Received: from dev-dsk-acsjakub-1b-6f9934e2.eu-west-1.amazon.com
 (172.19.75.107) by EX19D001UWA001.ant.amazon.com (10.13.138.214) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20; Mon, 22 Sep 2025
 08:22:23 +0000
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
Subject: [PATCH v3] fs/proc/task_mmu: check p->vec_buf for NULL
Date: Mon, 22 Sep 2025 08:22:05 +0000
Message-ID: <20250922082206.6889-1-acsjakub@amazon.de>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ClientProxiedBy: EX19D044UWA004.ant.amazon.com (10.13.139.7) To
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
ZXJuZWwub3JnCi0tLQp2MSAtPiB2MjogY2hlY2sgcC0+dmVjX2J1ZiBpbnN0ZWFkIG9mIGN1cl9i
dWYKdjIgLT4gdjM6IGZpeCBjb21taXQgdGl0bGUKCnYxOiBodHRwczovL2xvcmUua2VybmVsLm9y
Zy9hbGwvMjAyNTA5MTkxNDIxMDYuNDM1MjctMS1hY3NqYWt1YkBhbWF6b24uZGUvIAp2MjogaHR0
cHM6Ly9sb3JlLmtlcm5lbC5vcmcvYWxsLzIwMjUwOTIyMDgxNzEzLjc3MzAzLTEtYWNzamFrdWJA
YW1hem9uLmRlLwoKIGZzL3Byb2MvdGFza19tbXUuYyB8IDMgKysrCiAxIGZpbGUgY2hhbmdlZCwg
MyBpbnNlcnRpb25zKCspCgpkaWZmIC0tZ2l0IGEvZnMvcHJvYy90YXNrX21tdS5jIGIvZnMvcHJv
Yy90YXNrX21tdS5jCmluZGV4IDI5Y2NhMGU2ZDBmZi4uYjI2YWU1NTZiNDQ2IDEwMDY0NAotLS0g
YS9mcy9wcm9jL3Rhc2tfbW11LmMKKysrIGIvZnMvcHJvYy90YXNrX21tdS5jCkBAIC0yNDE3LDYg
KzI0MTcsOSBAQCBzdGF0aWMgdm9pZCBwYWdlbWFwX3NjYW5fYmFja291dF9yYW5nZShzdHJ1Y3Qg
cGFnZW1hcF9zY2FuX3ByaXZhdGUgKnAsCiB7CiAJc3RydWN0IHBhZ2VfcmVnaW9uICpjdXJfYnVm
ID0gJnAtPnZlY19idWZbcC0+dmVjX2J1Zl9pbmRleF07CiAKKwlpZiAoIXAtPnZlY19idWYpCisJ
CXJldHVybjsKKwogCWlmIChjdXJfYnVmLT5zdGFydCAhPSBhZGRyKQogCQljdXJfYnVmLT5lbmQg
PSBhZGRyOwogCWVsc2UKLS0gCjIuNDcuMwoKCgoKQW1hem9uIFdlYiBTZXJ2aWNlcyBEZXZlbG9w
bWVudCBDZW50ZXIgR2VybWFueSBHbWJIClRhbWFyYS1EYW56LVN0ci4gMTMKMTAyNDMgQmVybGlu
Ckdlc2NoYWVmdHNmdWVocnVuZzogQ2hyaXN0aWFuIFNjaGxhZWdlcgpFaW5nZXRyYWdlbiBhbSBB
bXRzZ2VyaWNodCBDaGFybG90dGVuYnVyZyB1bnRlciBIUkIgMjU3NzY0IEIKU2l0ejogQmVybGlu
ClVzdC1JRDogREUgMzY1IDUzOCA1OTcK



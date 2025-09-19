Return-Path: <linux-fsdevel+bounces-62234-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 21AD2B89DD9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Sep 2025 16:21:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C73431898A5A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Sep 2025 14:22:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16896260578;
	Fri, 19 Sep 2025 14:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b="Kl86BVcJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from pdx-out-008.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-008.esa.us-west-2.outbound.mail-perimeter.amazon.com [52.42.203.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B420304BD7;
	Fri, 19 Sep 2025 14:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.42.203.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758291706; cv=none; b=mgjQTGPdnqpzyCkJbgETMXtAiSxnUdbquOwEDDDBOg+3eTYRaj0HBisY85jkNZYZUGrB11VecrTqJAbyUem5aWRqTvqBvpynM4Z+XNWqlcuxYEoC83eEXmL0BnYMT7x49UmE+GcQfcn4UKMj06kyfuqRCMxxUDZiFDaRvvHXitc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758291706; c=relaxed/simple;
	bh=SNoE37pH9IsrRmPPr6Ks6nLKz8UuVU4Y3Ra1GhalwAY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=cnXUI+9mtsLbzLfXho3V+SBlwlRxa12bFXlTec+1Kw73EA145QrYzIrkZIpvyM17tYQnsj3fvoVSL+8HNTvgEZ1btzCm7LTyenzMsEgV8K5iKkq6PLmz2/lBupCCxRDIxW6JNhiTvKTl7G5IkYVcC4ARdOOniV83+3HoZ8eXrMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de; spf=pass smtp.mailfrom=amazon.de; dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b=Kl86BVcJ; arc=none smtp.client-ip=52.42.203.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazoncorp2;
  t=1758291704; x=1789827704;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=SNoE37pH9IsrRmPPr6Ks6nLKz8UuVU4Y3Ra1GhalwAY=;
  b=Kl86BVcJgYRPnAyMKChI70qieZWVKxiYdo/tUnzRHJTXcF0eODqAxT6p
   jv5ZQkx3Ch/F/bzFWZcdBVyCj5QhSQVVERHxKP3XUfAHRaxL7FFIReqt4
   ++O7qM9byBs3Ks/5Y1ToELEHJSNHckQTGGslnUq6nsCfkOKoFtWCJxW1e
   kQe3LRnyjUE3IxgOMDJsRWe4G60TcIeT2CW0LBz5W7gV3FrDRFeAHWryU
   OUM4t/UazgboLMb3JyvkXkIaplYh7R4IvPO/V8tBOEwm9d1clocG0bKb7
   e/yv7HPlYhzT7p8bzYPSHP5jHz23izv2ftI0FZOO+5JHzDVUjWIU1/rA2
   Q==;
X-CSE-ConnectionGUID: 3rQ2T0xWQKyMn44LQUihdg==
X-CSE-MsgGUID: in8j3+qtQTa8prMPIWitiw==
X-IronPort-AV: E=Sophos;i="6.18,278,1751241600"; 
   d="scan'208";a="3277338"
Received: from ip-10-5-12-219.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.12.219])
  by internal-pdx-out-008.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2025 14:21:42 +0000
Received: from EX19MTAUWC001.ant.amazon.com [10.0.21.151:24105]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.11.168:2525] with esmtp (Farcaster)
 id f8312997-ebfd-4e7f-b3de-3651e64ad808; Fri, 19 Sep 2025 14:21:42 +0000 (UTC)
X-Farcaster-Flow-ID: f8312997-ebfd-4e7f-b3de-3651e64ad808
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20;
 Fri, 19 Sep 2025 14:21:41 +0000
Received: from dev-dsk-acsjakub-1b-6f9934e2.eu-west-1.amazon.com
 (172.19.75.107) by EX19D001UWA001.ant.amazon.com (10.13.138.214) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20; Fri, 19 Sep 2025
 14:21:39 +0000
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
 Usama Anjum" <usama.anjum@collabora.com>, <stable@vger.kernel.org>
Subject: [PATCH] fs/proc/task_mmu: check cur_buf for NULL
Date: Fri, 19 Sep 2025 14:21:04 +0000
Message-ID: <20250919142106.43527-1-acsjakub@amazon.de>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ClientProxiedBy: EX19D040UWB003.ant.amazon.com (10.13.138.8) To
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
Y2l0bHkgY2hlY2tpbmcgY3VyX2J1ZiBmb3IgTlVMTCBiZWZvcmUgZGVyZWZlcmVuY2luZy4KCk90
aGVyIHNpdGVzIHRoYXQgbWlnaHQgcnVuIGludG8gc2FtZSBkZXJlZi1pc3N1ZSBhcmUgYWxyZWFk
eSAoZGlyZWN0bHkKb3IgdHJhbnNpdGl2ZWx5KSBwcm90ZWN0ZWQgYnkgY2hlY2tpbmcgcC0+dmVj
X2J1Zi4KCk5vdGU6CkZyb20gUEFHRU1BUF9TQ0FOIG1hbiBwYWdlLCBpdCBzZWVtcyB2ZWNfbGVu
ID0gMCBpcyB2YWxpZCB3aGVuIG5vIG91dHB1dAppcyByZXF1ZXN0ZWQgYW5kIGl0J3Mgb25seSB0
aGUgc2lkZSBlZmZlY3RzIGNhbGxlciBpcyBpbnRlcmVzdGVkIGluLApoZW5jZSBpdCBwYXNzZXMg
Y2hlY2sgaW4gcGFnZW1hcF9zY2FuX2dldF9hcmdzKCkuCgpUaGlzIGlzc3VlIHdhcyBmb3VuZCBi
eSBzeXprYWxsZXIuCgpGaXhlczogNTI1MjZjYTdmZGI5ICgiZnMvcHJvYy90YXNrX21tdTogaW1w
bGVtZW50IElPQ1RMIHRvIGdldCBhbmQgb3B0aW9uYWxseSBjbGVhciBpbmZvIGFib3V0IFBURXMi
KQpDYzogQW5kcmV3IE1vcnRvbiA8YWtwbUBsaW51eC1mb3VuZGF0aW9uLm9yZz4KQ2M6IERhdmlk
IEhpbGRlbmJyYW5kIDxkYXZpZEByZWRoYXQuY29tPgpDYzogVmxhc3RpbWlsIEJhYmthIDx2YmFi
a2FAc3VzZS5jej4KQ2M6IExvcmVuem8gU3RvYWtlcyA8bG9yZW56by5zdG9ha2VzQG9yYWNsZS5j
b20+CkNjOiBKaW5qaWFuZyBUdSA8dHVqaW5qaWFuZ0BodWF3ZWkuY29tPgpDYzogU3VyZW4gQmFn
aGRhc2FyeWFuIDxzdXJlbmJAZ29vZ2xlLmNvbT4KQ2M6IFBlbmdsZWkgSmlhbmcgPHN1cGVybWFu
LnhwdEBnbWFpbC5jb20+CkNjOiBNYXJrIEJyb3duIDxicm9vbmllQGtlcm5lbC5vcmc+CkNjOiBC
YW9saW4gV2FuZyA8YmFvbGluLndhbmdAbGludXguYWxpYmFiYS5jb20+CkNjOiBSeWFuIFJvYmVy
dHMgPHJ5YW4ucm9iZXJ0c0Bhcm0uY29tPgpDYzogQW5kcmVpIFZhZ2luIDxhdmFnaW5AZ21haWwu
Y29tPgpDYzogIk1pY2hhxYIgTWlyb3PFgmF3IiA8bWlycS1saW51eEByZXJlLnFtcW0ucGw+CkNj
OiBTdGVwaGVuIFJvdGh3ZWxsIDxzZnJAY2FuYi5hdXVnLm9yZy5hdT4KQ2M6IE11aGFtbWFkIFVz
YW1hIEFuanVtIDx1c2FtYS5hbmp1bUBjb2xsYWJvcmEuY29tPgpsaW51eC1rZXJuZWxAdmdlci5r
ZXJuZWwub3JnCmxpbnV4LWZzZGV2ZWxAdmdlci5rZXJuZWwub3JnCkNjOiBzdGFibGVAdmdlci5r
ZXJuZWwub3JnClNpZ25lZC1vZmYtYnk6IEpha3ViIEFjcyA8YWNzamFrdWJAYW1hem9uLmRlPgoK
LS0tCiBmcy9wcm9jL3Rhc2tfbW11LmMgfCAzICsrKwogMSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0
aW9ucygrKQoKZGlmZiAtLWdpdCBhL2ZzL3Byb2MvdGFza19tbXUuYyBiL2ZzL3Byb2MvdGFza19t
bXUuYwppbmRleCAyOWNjYTBlNmQwZmYuLjhjMTBhODEzNWU3NCAxMDA2NDQKLS0tIGEvZnMvcHJv
Yy90YXNrX21tdS5jCisrKyBiL2ZzL3Byb2MvdGFza19tbXUuYwpAQCAtMjQxNyw2ICsyNDE3LDkg
QEAgc3RhdGljIHZvaWQgcGFnZW1hcF9zY2FuX2JhY2tvdXRfcmFuZ2Uoc3RydWN0IHBhZ2VtYXBf
c2Nhbl9wcml2YXRlICpwLAogewogCXN0cnVjdCBwYWdlX3JlZ2lvbiAqY3VyX2J1ZiA9ICZwLT52
ZWNfYnVmW3AtPnZlY19idWZfaW5kZXhdOwogCisJaWYgKCFjdXJfYnVmKQorCQlyZXR1cm47CisK
IAlpZiAoY3VyX2J1Zi0+c3RhcnQgIT0gYWRkcikKIAkJY3VyX2J1Zi0+ZW5kID0gYWRkcjsKIAll
bHNlCi0tIAoyLjQ3LjMKCgoKCkFtYXpvbiBXZWIgU2VydmljZXMgRGV2ZWxvcG1lbnQgQ2VudGVy
IEdlcm1hbnkgR21iSApUYW1hcmEtRGFuei1TdHIuIDEzCjEwMjQzIEJlcmxpbgpHZXNjaGFlZnRz
ZnVlaHJ1bmc6IENocmlzdGlhbiBTY2hsYWVnZXIKRWluZ2V0cmFnZW4gYW0gQW10c2dlcmljaHQg
Q2hhcmxvdHRlbmJ1cmcgdW50ZXIgSFJCIDI1Nzc2NCBCClNpdHo6IEJlcmxpbgpVc3QtSUQ6IERF
IDM2NSA1MzggNTk3Cg==



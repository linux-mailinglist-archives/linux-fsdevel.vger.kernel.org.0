Return-Path: <linux-fsdevel+bounces-74043-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id ADE31D2AC69
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jan 2026 04:32:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 004993054989
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jan 2026 03:32:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 810FE265CDD;
	Fri, 16 Jan 2026 03:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="Lan0ie24"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from m16.mail.126.com (m16.mail.126.com [117.135.210.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C24C23EA89
	for <linux-fsdevel@vger.kernel.org>; Fri, 16 Jan 2026 03:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768534336; cv=none; b=Fd4nJcLTQgITfb+9jKHAlguVlUGkl92LqsXw495Ans2VhO4PEZ2Bc3/gwXq7S98AWaUWsgW274wKsmklRUBdCeE3d+ZeYZiEVWuGJL1oTX1CsrQQSm0u+34ffs+u/1ViTRHpIXwP4aYcIqSjJKz1JJH/z+S1KbvIF/bV5ks9g+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768534336; c=relaxed/simple;
	bh=3hk/oahptf+BXzzkU76pxqLubNUxXOLSzyIOL7TJCn8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=YpyEJQqhgEqWWaJPX33mkJr4BJefbRKHHVN81XMXhgh+2zKCjvlfuCtmjYmb2WIqkYFjbXKJW5VgZxOQ2jpQ/sV6yiKynTapeHi+MBOg+J06tp1iBArQWAkwAG8LOkI9sFmHrGSZx2JjQ1ki8H2SJGJTcAtalVxEcmTc7PymhxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=Lan0ie24; arc=none smtp.client-ip=117.135.210.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=Date:From:To:Subject:Content-Type:MIME-Version:
	Message-ID; bh=3hk/oahptf+BXzzkU76pxqLubNUxXOLSzyIOL7TJCn8=; b=L
	an0ie24+0PG+hy/YQZUfY7k9E3Sfgsf0Iv5jg+fAJeozZWkDaA8PRng6Zey8Sdlb
	5cGnmwQZp1LO0g+3QLJ1cuw4yMm+FRNYunI6flvakZJ5FRAQZ9156ul9TeSTZxS2
	2pYmj1nvkSVsnMRQCobuRcaeh7E4ug99yXVAKaCcA0=
Received: from nzzhao$126.com ( [212.135.214.2] ) by
 ajax-webmail-wmsvr-41-112 (Coremail) ; Fri, 16 Jan 2026 11:31:44 +0800
 (CST)
Date: Fri, 16 Jan 2026 11:31:44 +0800 (CST)
From: "Nanzhe Zhao" <nzzhao@126.com>
To: "Jaegeuk Kim" <jaegeuk@kernel.org>
Cc: "Chao Yu" <chao@kernel.org>, linux-f2fs-devel@lists.sourceforge.net,
	linux-fsdevel@vger.kernel.org
Subject: Re:Re: [f2fs-dev] [PATCH v2 1/2] f2fs: add 'folio_in_bio' to handle
 readahead folios with no BIO submission
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2023.4-cmXT build
 20251222(83accb85) Copyright (c) 2002-2026 www.mailtech.cn 126com
In-Reply-To: <aWZ7X9yig5TK2yNN@google.com>
References: <20260111100941.119765-1-nzzhao@126.com>
 <20260111100941.119765-2-nzzhao@126.com>
 <0aca7d1f-b323-4e14-b33c-8e2f0b9e63ea@kernel.org>
 <13c7c3ce.71fa.19bb1687da1.Coremail.nzzhao@126.com>
 <5158ff31-bd7b-4071-b2b1-12cb75c858dd@kernel.org>
 <aWZ7X9yig5TK2yNN@google.com>
X-NTES-SC: AL_Qu2dCvmYu0sr4iOfYOkfmUgRgOw3XMSyu/oi2o9UO5FwjArj+iASW1VpF3XR19+sJCGAmSS7YDVeyP1feIJpWZkVdg8UDdDrThleUbZMcw84Kg==
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=GBK
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <66927673.3096.19bc4dbe67d.Coremail.nzzhao@126.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:cCkvCgD3v1EhsWlpXsBFAA--.58960W
X-CM-SenderInfo: xq22xtbr6rjloofrz/xtbBowEp+GlpsSGHZAAA3A
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==

SGkgS2ltOgoKQXQgMjAyNi0wMS0xNCAwMTowNTozNSwgIkphZWdldWsgS2ltIiA8amFlZ2V1a0Br
ZXJuZWwub3JnPiB3cm90ZToKPk9uIDAxLzEyLCBDaGFvIFl1IHdyb3RlOgo+PiBPbiAxLzEyLzIw
MjYgNDo1MiBQTSwgTmFuemhlIFpoYW8gd3JvdGU6Cj4+ID4gCj4+ID4gQXQgMjAyNi0wMS0xMiAw
OTowMjo0OCwgIkNoYW8gWXUiIDxjaGFvQGtlcm5lbC5vcmc+IHdyb3RlOgo+PiA+ID4gPiBAQCAt
MjU0NSw2ICsyNTQ4LDExIEBAIHN0YXRpYyBpbnQgZjJmc19yZWFkX2RhdGFfbGFyZ2VfZm9saW8o
c3RydWN0IGlub2RlICppbm9kZSwKPj4gPiA+ID4gICAgCX0KPj4gPiA+ID4gICAgCXRyYWNlX2Yy
ZnNfcmVhZF9mb2xpbyhmb2xpbywgREFUQSk7Cj4+ID4gPiA+ICAgIAlpZiAocmFjKSB7Cj4+ID4g
PiA+ICsJCWlmICghZm9saW9faW5fYmlvKSB7Cj4+ID4gPiA+ICsJCQlpZiAoIXJldCkKPj4gPiA+
IAo+PiA+ID4gcmV0IHNob3VsZCBuZXZlciBiZSB0cnVlIGhlcmU/Cj4+ID4gPiAKPj4gPiA+IFRo
YW5rcywKPj4gPiBZZXMuTmVlZCBJIHNlbmQgYSB2MyBwYXRjaCB0byByZW1vdmUgdGhlIHJlZHVu
ZGFudCBjaGVjaz8KPj4gCj4+IFllcywgSSB0aGluayBzby4KPgo+QXBwbGllZCBpbiBkZXYtdGVz
dCB3aXRoIGl0Lgo+CgpUaGFua3MgZm9yIGFwcGx5IQoKQXMgYW4gYXNpZGUsIEkgbm90aWNlZCB0
aGF0IGYyZnNfZm9saW9fc3RhdGUgcmVtb3ZlZCB0aGUgdXB0b2RhdGUgYml0bWFwLiAgRG8gd2Ug
bmVlZCB0byAKY29uc2lkZXIgdGhlIGNhc2Ugd2hlcmUgYSBiaW8gZW5kcyB1cCB3aXRoIGJpX3N0
YXR1cyBzZXQgdG8gZXJyb3IgKHdoaWNoIGNvdWxkIHBvdGVudGlhbGx5CiBjYXVzZSBhIGxhcmdl
IGZvbGlvIHRvIGJlIG9ubHkgcGFydGlhbGx5IHJlYWQgc3VjY2Vzc2Z1bGx5KT8KCkFsc28sIGlz
IGJpbyBzdWJtaXNzaW9uIGFuZCB0aGUgc3VibWl0X2FuZF9yZWFsbG9jIGxvb3AgbmV2ZXIgZmFp
bHMgPwoKVGhhbmtzLApOYW56aGUgWmhhbw==


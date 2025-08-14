Return-Path: <linux-fsdevel+bounces-57814-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D1C04B2587F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Aug 2025 02:41:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 44E261C06A05
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Aug 2025 00:41:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A85E2FF66B;
	Thu, 14 Aug 2025 00:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="Ob4yuPz9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from m16.mail.126.com (m16.mail.126.com [220.197.31.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C50F1459EA;
	Thu, 14 Aug 2025 00:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755132011; cv=none; b=JZ+NILYuMenGyeNqzuUEP81GfZjXCeQpEa3+1R2TFH5rTQZI5oOUbtnhMdlpohgiET6PGnbe6sDPkTyPeotM34wwvkHKtPBmB7Xw7g3i95lt0piC3CEaJyEwz6hqt5XegegcJXKmtz66pzg933WfZCiE9ZqQ49bJ+hiWfVw0ZB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755132011; c=relaxed/simple;
	bh=S2F1KYFdj08kbSGD3imelw94uIcPpeMQDGDSL0wXGKc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=K3Mhsl/Hbim54mrCR4VCTa6iDo7nV4zyFflWEaXWtbvkHyNGxRni3U4x/pejPL8adTc6u003tzysrFV+8DexYaCYeEIfrUg1dw5xWsnYm/Zt7AFDzr4Or33FXTNoFToiIWTxC10ctPY2hnFobc2lfpY/tqlAUuEh2WeCSaq1wCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=Ob4yuPz9; arc=none smtp.client-ip=220.197.31.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=Date:From:To:Subject:Content-Type:MIME-Version:
	Message-ID; bh=S2F1KYFdj08kbSGD3imelw94uIcPpeMQDGDSL0wXGKc=; b=O
	b4yuPz99DZ29Sfb9Yp/DMQgWkAO2v0QzaFvlRxFrvu1P7xd57/SsPsdU+NDLoe+b
	QQFLSrbikwcBbnqlARHjCL8HlTI6GL4pJsjG/hAKUmOvMnJ20KgglCsj4FbIsIhQ
	+pAIoR36p/gZ/vL1cKTL61mYTdEUeeLdgXBwOvWTRI=
Received: from nzzhao$126.com ( [112.86.116.50] ) by
 ajax-webmail-wmsvr-41-116 (Coremail) ; Thu, 14 Aug 2025 08:39:31 +0800
 (CST)
Date: Thu, 14 Aug 2025 08:39:31 +0800 (CST)
From: =?GBK?B?1dTEz9XcIA==?= <nzzhao@126.com>
To: "Christoph Hellwig" <hch@infradead.org>
Cc: "Jaegeuk Kim" <jaegeuk@kernel.org>,
	linux-f2fs-devel@lists.sourceforge.net,
	linux-fsdevel@vger.kernel.org,
	"Matthew Wilcox" <willy@infradead.org>, "Chao Yu" <chao@kernel.org>,
	"Yi Zhang" <yi.zhang@huawei.com>, "Barry Song" <21cnbao@gmail.com>,
	"Darrick J. Wong" <djwong@kernel.org>, linux-xfs@vger.kernel.org
Subject: Re:Re: [f2fs-dev] [RFC PATCH 0/9] f2fs: Enable buffered read/write
 large folios support with extended iomap
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2023.4-cmXT build
 20250723(a044bf12) Copyright (c) 2002-2025 www.mailtech.cn 126com
In-Reply-To: <aJytvfsMcR2hzWKI@infradead.org>
References: <20250813092131.44762-1-nzzhao@126.com>
 <aJytvfsMcR2hzWKI@infradead.org>
X-NTES-SC: AL_Qu2eB/2YvkEs5yKYbOkfmUgRgOw3XMSyu/oi2o9UO5FwjA3j9SoPcGJeMmTT3OSSIi+qiiq1dj9e8PZgd6hBdqgZCTA8v9ofc8iQhGls/sROAA==
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=GBK
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <e81c31e.56a.198a604868e.Coremail.nzzhao@126.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:dCkvCgDn1y9DMJ1oOMAZAA--.15410W
X-CM-SenderInfo: xq22xtbr6rjloofrz/1tbiEwWoz2icl9vu0AAGsx
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==

SGkgTXIuQ2hyaXN0b3BoLAoKVGhhbmtzIGZvciB0aGUgcXVpY2sgZmVlZGJhY2shCgo+IFRoYXQn
cyBwcmV0dHkgdWdseS4gIFdoYXQgYWRkaXRpb25hbCBmbGFncyBkbyB5b3UgbmVlZD8gIAoKRjJG
UyBjYW4gdXRpbGl6ZSB0aGUgZm9saW8ncyBwcml2YXRlIGZpZWxkIGluIGEgbm9uLXBvaW50ZXIg
bW9kZSB0byBzdG9yZSBpdHMgZXh0cmEgZmxhZ3MsIHdoaWNoIGluZGljYXRlIHRoZSBmb2xpbydz
IGFkZGl0aW9uYWwgc3RhdHVzLiAKUGxlYXNlIHRha2UgYSBsb29rIGF0IHRoZSBmMmZzLmggZmls
ZSBmcm9tIFBBR0VfUFJJVkFURV9HRVRfRlVOQyB0byB0aGUgZW5kIG9mIGNsZWFyX3BhZ2VfcHJp
dmF0ZV9hbGwoKS4KClRoZXNlIGZsYWdzIHBlcnNpc3QgdGhyb3VnaG91dCB0aGUgZW50aXJlIGxp
ZmV0aW1lIG9mIGEgZm9saW8sIHdoaWNoIGNvbmZsaWN0cyB3aXRoIHRoZSBpb21hcF9mb2xpb19z
dGF0ZSBwb2ludGVyLgpDdXJyZW50bHksIHRoZSBwcml2YXRlIGZpZWxkcyBvZiBpb21hcCdzIGV4
aXN0aW5nIGRhdGEgc3RydWN0dXJlcyxuYW1lbHkgc3RydWN0IGlvbWFwJ3MgcHJpdmF0ZSwgc3Ry
dWN0IGlvbWFwX2l0ZXIncyBwcml2YXRlLCAKYW5kIHN0cnVjdCBpb21hcF9pb2VuZCdzIGlvX3By
aXZhdGUsYXJlIGVpdGhlciBhbGxvY2F0ZWQgbG9jYWxseSBvbiB0aGUgc3RhY2sgb3IgaGF2ZSBh
IGxpZmVjeWNsZSBvbiB0aGUgaGVhcCB0aGF0IG9ubHkgZXhpc3RzIApmb3IgdGhlIGR1cmF0aW9u
IG9mIHRoZSBJL08gcm91dGluZS4gVGhpcyBjYW5ub3QgbWVldCBGMkZTJ3MgcmVxdWlyZW1lbnRz
LgoKPiBXZSBzaG91bGQgIHRyeSB0byBmaWd1cmUgb3V0IGlmIHRoZXJlIGlzIGEgc2Vuc2libGUg
d2F5IHRvIHN1cHBvcnQgdGhlIG5lZWRzCj4gd2l0aCBhIHNpbmdsZSBjb2RlYmFzZSBhbmQgZGF0
YSBzdHJ1Y3R1cmUuCgpBcyBmYXIgYXMgSSBrbm93LCBvbmx5IEYyRlMgaGFzIHRoaXMgcmVxdWly
ZW1lbnQsIHdoaWxlIG90aGVyIGZpbGUgc3lzdGVtcyBkbyBub3QuIApUaGVyZWZvcmUsIG15IGlu
aXRpYWwgdGhvdWdodCB3YXMgdG8gYXZvaWQgZGlyZWN0bHkgbW9kaWZ5aW5nIHRoZSBnZW5lcmlj
IGxvZ2ljIGluIGZzL2lvbWFwLiBJbnN0ZWFkLCBJIHByb3Bvc2UgZGVzaWduaW5nIAphIHdyYXBw
ZXIgc3RydWN0dXJlIGZvciBpb21hcF9mb2xpb19zdGF0ZSBzcGVjaWZpY2FsbHkgZm9yIEYyRlMg
dG8gc2F0aXNmeSBib3RoIGlvbWFwJ3MgYW5kIEYyRlMncyBvd24gbmVlZHMuCgpBbm90aGVyIGlz
c3VlIGlzIHRoZSBoYW5kbGluZyBvZiBvcmRlci0wIGZvbGlvcy4gU2luY2UgdGhlIGlvbWFwIGZy
YW1ld29yayBkb2VzIG5vdCBhbGxvY2F0ZSBhbiBpb21hcF9mb2xpb19zdGF0ZSBmb3IgdGhlc2Ug
Zm9saW9zLCAKRjJGUyB3aWxsIGFsd2F5cyBzdG9yZXMgaXRzIHByaXZhdGUgZmxhZ3MgaW4gdGhl
IGZvbGlvLT5wcml2YXRlIGZpZWxkLiBUaGVuIGlvbWFwIGZyYW1ld29yayB3b3VsZCBtaXN0YWtl
bmx5IGludGVycHJldCB0aGVzZSBmbGFncyBhcyBhIHBvaW50ZXIuIAoKSWYgd2UgYXJlIHRvIHNv
bHZlIHRoaXMgaXNzdWUgaW4gZ2VuZXJpYyBpb21hcCBsYXllciwgYSBtaW5pbWFsIGNoYW5nZXMg
bWV0aG9kIHRvIGlvbWFwIGZyYW1ld29yayBJIHN1cHBvc2UgaXMgdG8gbGV0IGlvbWFwIGxvZ2lj
IGNhbgpib3RoIGRpc3Rpbmd1aXNoIHBvaW50ZXIgYW5kIG5vbiBwb2ludGVyIG1vZGUgb2YgZm9s
aW8tPnByaXZhdGUuIFdlIHNob3VsZCBhbHNvIGFkZCBhIHByaXZhdGUgZmllbGQgdG8gaW9tYXBf
Zm9saW9fc3RhdGUgLCBvciBleHRlbmQgaGUgc3RhdGUgCmZsZXhpYmxlIGFycmF5IHRvIHN0b3Jl
IHRoZSBleHRyYSBpbmZvbWF0aW9uLiBJZiBpb21hcCBkZXRlY3RzIGEgb3JkZXI+MCBmb2xpbydz
IGZvbGlvLT5wcml2YXRlIGlzIHVzZWQgaW4gbm9uIHBvaW50ZXIgbW9kZSwgdGhlbiBpdCBzdG9y
ZSB0aGUgZmxhZ3MgaW4gYSBuZXdseSAKYWxsb2N0ZWQgaW9tYXBfZm9saW9fc3RhdGUgZmlyc3Qg
LCBjbGVhciB0aGUgcHJpdmF0ZSBmaWVsZCBhbmQgdGhlbiBzdG9yZSdzIGl0cyBhZGRyZXNzIGlu
IGl0LgoKUC5TLiAgSSBqdXN0IG5vdGljZWQgeW91IGRpZG4ndCByZXBseSB2aWEgbXkgcmVzZW5k
IHBhdGNoLiBJIG1pc3NwZWxsZWQgZjJmcydzIHN1YnN5dGVtIG1haWwgYWRkcmVzcyBpbiB0aGUg
b3JpZ2luYWwgcGF0Y2ggYW5kIEkgc2luY2VyZWx5IGFwb2xvZ2l6ZSBmb3IgdGhhdC4KSSBhbHJl
YWR5IHJlLXNlbnQgdGhlIHNlcmllcyBhcyAgCiAiW2YyZnMtZGV2XSBbUkVTRU5EIFJGQyBQQVRD
SCAwLzldIGYyZnM6IEVuYWJsZSBidWZmZXJlZCByZWFkL3dyaXRlIGxhcmdlIGZvbGlvcyBzdXBw
b3J0IHdpdGggZXh0ZW5kZWQgaW9tYXAiCkNvdWxkIHdlIGNvbnRpbnVlIHRoZSBkaXNjdXNzaW9u
IG9uIHRoYXQgdGhyZWFkIHNvIHRoZSByaWdodCBsaXN0IGdldHMgdGhlCmZ1bGwgY29udGV4dD8g
IFRoYW5rcyEKCkJlc3QgcmVnYXJkcywKTmFuemhlIFpoYW8KCkF0IDIwMjUtMDgtMTMgMjM6MjI6
MzcsICJDaHJpc3RvcGggSGVsbHdpZyIgPGhjaEBpbmZyYWRlYWQub3JnPiB3cm90ZToKPk9uIFdl
ZCwgQXVnIDEzLCAyMDI1IGF0IDA1OjIxOjIyUE0gKzA4MDAsIE5hbnpoZSBaaGFvIHdyb3RlOgo+
PiAqICoqV2h5IGV4dGVuZHMgaW9tYXAqKgo+PiAgICogRjJGUyBzdG9yZXMgaXRzIGZsYWdzIGlu
IHRoZSBmb2xpbydzIHByaXZhdGUgZmllbGQsCj4+ICAgICB3aGljaCBjb25mbGljdHMgd2l0aCBp
b21hcF9mb2xpb19zdGF0ZS4KPj4gICAqIFRvIHJlc29sdmUgdGhpcywgd2UgZGVzaWduZWQgZjJm
c19pb21hcF9mb2xpb19zdGF0ZSwKPj4gICAgIGNvbXBhdGlibGUgd2l0aCBpb21hcF9mb2xpb19z
dGF0ZSdzIGxheW91dCB3aGlsZSBleHRlbmRpbmcKPj4gICAgIGl0cyBmbGV4aWJsZSBzdGF0ZSBh
cnJheSBmb3IgRjJGUyBwcml2YXRlIGZsYWdzLgo+PiAgICogV2Ugc3RvcmUgYSBtYWdpYyBudW1i
ZXIgaW4gcmVhZF9ieXRlc19wZW5kaW5nIHRvIGRpc3Rpbmd1aXNoCj4+ICAgICB3aGV0aGVyIGEg
Zm9saW8gdXNlcyB0aGUgb3JpZ2luYWwgb3IgRjJGUydzIGlvbWFwX2ZvbGlvX3N0YXRlLgo+PiAg
ICAgSXQncyBjaG9zZW4gYmVjYXVzZSBpdCByZW1haW5zIDAgYWZ0ZXIgcmVhZGFoZWFkIGNvbXBs
ZXRlcy4KPgo+VGhhdCdzIHByZXR0eSB1Z2x5LiAgV2hhdCBhZGRpdGlvbmFscyBmbGFncyBkbyB5
b3UgbmVlZD8gIFdlIHNob3VsZAo+dHJ5IHRvIGZpZ3VyZSBvdXQgaWYgdGhlcmUgaXMgYSBzZW5z
aWJsZSB3YXkgdG8gc3VwcG9ydCB0aGUgbmVlZHMKPndpdGggYSBzaW5nbGUgY29kZWJhc2UgYW5k
IGRhdGEgc3RydWN0dXJlIGlmIHRoYXQgdGhlIHJlcXVpcmVtZW50cwo+YXJlIHNlbnNpYmxlLgo=



Return-Path: <linux-fsdevel+bounces-40240-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4336BA20EB7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Jan 2025 17:36:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 576F51888C6C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Jan 2025 16:36:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C95E31DE3AA;
	Tue, 28 Jan 2025 16:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="i2TOG0XH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-fw-9102.amazon.com (smtp-fw-9102.amazon.com [207.171.184.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC7DE1DE3AB
	for <linux-fsdevel@vger.kernel.org>; Tue, 28 Jan 2025 16:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.184.29
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738082150; cv=none; b=pIOTWLEqugHeq3PLScOhVLbj7IhHGbrWOk9vn3xTl4MRmU0eJUpnz7IHTQk8JQx6b5GYPL7oBmXpBC0Tg39dX/pvoBLVNCSdj2oziocmVpnWYlQ9//A9x1IUUD+DfDLa8ZcUuBfaAS53Pb5OT7E2jCWKBCH1zE2mu127LMQG/OM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738082150; c=relaxed/simple;
	bh=ZZ7UqPDoLJ6L6B7fzkOFXNYcQSUWFNCrDYGKuE+/KNA=;
	h=Subject:From:To:CC:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=nV/6MWUJ29PJYtDzzHpqVCkpJ/9CdPrALeeIzMp2zJtMS0Uf7Sr6NIgKSxIUJ6+FxJO0gXZ3X+VXJz6TJSviy6LOeq+msboBO0ioIxqofkQSkkrlTMB2adZedQwtpOZoKsMNiESZAm9l9mqR6lGQ9jTMvxivLUtiLEGhsek7gXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=i2TOG0XH; arc=none smtp.client-ip=207.171.184.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1738082149; x=1769618149;
  h=from:to:cc:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version:subject;
  bh=ZZ7UqPDoLJ6L6B7fzkOFXNYcQSUWFNCrDYGKuE+/KNA=;
  b=i2TOG0XHsw9s2aSYS1rGXhCIqXzQ71tTmCRh8mAEx0t/Y36Ga2TgYGni
   4v2HYOVpwUD8ZF3+Qr/X5L1n7EcyzpLlMAPd6rMzbU7BHKb3EhyFmUiRz
   M48LtEK0H+w0azeB3V2wyq3jTnYYB94YwREvhp8mzKsIX8Zs4UQVWnxo1
   M=;
X-IronPort-AV: E=Sophos;i="6.13,241,1732579200"; 
   d="scan'208";a="489304026"
Subject: Re: [LSF/MM/BPF TOPIC] Lustre filesystem upstreaming
Thread-Topic: [LSF/MM/BPF TOPIC] Lustre filesystem upstreaming
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-east-1.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-9102.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2025 16:35:47 +0000
Received: from EX19MTAUEC001.ant.amazon.com [10.0.29.78:41505]
 by smtpin.naws.us-east-1.prod.farcaster.email.amazon.dev [10.0.38.255:2525] with esmtp (Farcaster)
 id b3e3183f-9d97-46a3-8291-454d63c6471c; Tue, 28 Jan 2025 16:35:47 +0000 (UTC)
X-Farcaster-Flow-ID: b3e3183f-9d97-46a3-8291-454d63c6471c
Received: from EX19D017UEA004.ant.amazon.com (10.252.134.70) by
 EX19MTAUEC001.ant.amazon.com (10.252.135.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Tue, 28 Jan 2025 16:35:46 +0000
Received: from EX19D017UEA001.ant.amazon.com (10.252.134.93) by
 EX19D017UEA004.ant.amazon.com (10.252.134.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Tue, 28 Jan 2025 16:35:46 +0000
Received: from EX19D017UEA001.ant.amazon.com ([fe80::bffb:623f:af5e:ebed]) by
 EX19D017UEA001.ant.amazon.com ([fe80::bffb:623f:af5e:ebed%3]) with mapi id
 15.02.1258.039; Tue, 28 Jan 2025 16:35:46 +0000
From: "Day, Timothy" <timday@amazon.com>
To: Christoph Hellwig <hch@infradead.org>
CC: "lsf-pc@lists.linux-foundation.org" <lsf-pc@lists.linux-foundation.org>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"jsimmons@infradead.org" <jsimmons@infradead.org>, Andreas Dilger
	<adilger@ddn.com>, "neilb@suse.de" <neilb@suse.de>
Thread-Index: AQHbbqGKPQGkNCnWmkGOpAnSPDKrX7MruoAAgABZxoA=
Date: Tue, 28 Jan 2025 16:35:46 +0000
Message-ID: <DD162239-D4B3-433C-A7C1-2DBEBFA881EC@amazon.com>
References: <5A3D5719-1705-466D-9A86-96DAFD7EAABD@amazon.com>
 <Z5h1wmTawx6P8lfK@infradead.org>
In-Reply-To: <Z5h1wmTawx6P8lfK@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="utf-8"
Content-ID: <11CBD0A2BA996A41821C92C463D016E8@amazon.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

DQoNCj4gT24gMS8yOC8yNSwgMToxNCBBTSwgIkNocmlzdG9waCBIZWxsd2lnIiA8aGNoQGluZnJh
ZGVhZC5vcmcgPG1haWx0bzpoY2hAaW5mcmFkZWFkLm9yZz4+IHdyb3RlOg0KPiA+IE9uIEZyaSwg
SmFuIDI0LCAyMDI1IGF0IDA4OjUwOjAyUE0gKzAwMDAsIERheSwgVGltb3RoeSB3cm90ZToNCj4g
PiBXaGlsZSBtdWNoIG9mIHRoYXQgaGFzIGJlZW4gYWRkcmVzc2VkIHNpbmNlIC0gdGhlIGtlcm5l
bCBpcyBhDQo+ID4gbW92aW5nIHRhcmdldC4gU2V2ZXJhbCBmaWxlc3lzdGVtcyBoYXZlIGJlZW4g
bWVyZ2VkIChvciByZW1vdmVkKQ0KPiA+IHNpbmNlIEx1c3RyZSBsZWZ0IHN0YWdpbmcuIFdlJ3Jl
IGFpbWluZyB0byBhdm9pZCB0aGUgbWlzdGFrZXMgb2YNCj4gPiB0aGUgcGFzdCBhbmQgaG9wZSB0
byBhZGRyZXNzIGFzIG1hbnkgY29uY2VybnMgYXMgcG9zc2libGUgYmVmb3JlDQo+ID4gc3VibWl0
dGluZyBmb3IgaW5jbHVzaW9uLg0KPg0KPiBUaGF0J3MgYmVjYXVzZSB0aGV5IGhhdmUgYSAobW9y
IGVvciBsZXNzIG5vcm1hbCkgZGV2ZWxvcG1lbnQgbW9kZWwNCj4gYW5kIGEgc3RhYmxlIG9uLWRp
c2sgLyBvbi10aGUtd2lyZSBwcm90b2NvbC4NCj4NCj4gSSB0aGluayB5b3UgZ3V5cyBuZWVkcyB0
byBzb3J0IHlvdXIgaW50ZXJuYWwgbWVzcyBvdXQgZmlyc3QuDQo+IENvbnNvbGlkYXRlIHRoZSBo
YWxmIGEgZG96ZW5kIGluY29tcGF0aWJsZSB2ZXJzaW9ucywgbWFrZSBzdXJlIHlvdQ0KPiBoYXZl
IGEgZG9jdW1lbnRlZCBhbmQgc3RhYmxlIG9uLWRpc2sgdmVyc2lvbiBhbmQgZG9uJ3QgcmVxdWly
ZQ0KPiBhbGwgcGFydGljaXBhbnRzIHRvIHJ1biBleGFjdGx5IHRoZSBzYW1lIHZlcnNpb24uIEFm
dGVyIHRoYXQganVzdA0KPiBzZW5kIHBhdGNoZXMganVzdCBsaWtlIGV2ZXJ5b25lIGVsc2UuDQoN
ClRoZSBuZXR3b3JrIGFuZCBkaXNrIGZvcm1hdCBpcyBwcmV0dHkgc3RhYmxlIGF0IHRoaXMgcG9p
bnQuIEFsbCBvZiB0aGUNCkx1c3RyZSB2ZXJzaW9ucyByZWxlYXNlZCBvdmVyIHRoZSBwYXN0IDYg
eWVhcnMgKGF0IGxlYXN0KSBpbnRlcm9wZXJhdGUNCm92ZXIgdGhlIG5ldHdvcmsganVzdCBmaW5l
LiBJIGRvbid0IGhhdmUgcGVyc29uYWwgZXhwZXJpZW5jZSB3aXRoIGENCmxhcmdlciB2ZXJzaW9u
IGRpZmZlcmVuY2UgLSBidXQgdGhlIEx1c3RyZSBwcm90b2NvbCBuZWdvdGlhdGlvbiBpcyBwcmV0
dHkNCnNvbGlkIGFuZCBJJ3ZlIGhlYXJkIG9mIGxhcmdlciB2ZXJzaW9uIGdhcHMgd29ya2luZyBm
aW5lLg0KDQpGb3IgdGhlIGRpc2sgZm9ybWF0LCBMdXN0cmUgdXNlcyBhIG1pbmltYWxseSBwYXRj
aGVkIGV4dDQgZm9yIHRoZQ0Kc2VydmVycy4gVGhhdCdzIHdlbGwgZG9jdW1lbnRlZCAtIGFsdGhv
dWdoIHBlcmhhcHMgYSBiaXQgb2RkDQpjb21wYXJlZCB0byBORlMgb3IgU01CLiBUaGUgbnVtYmVy
IG9mIHBhdGNoZXMgbmVlZGVkIGZvcg0KZXh0NCBoYXMgZGVjcmVhc2VkIGEgbG90IG92ZXIgdGlt
ZS4gQ29udmVyZ2VuY2Ugd2l0aCByZWd1bGFyDQpleHQ0IGlzIGZlYXNpYmxlLiBCdXQgdGhhdCdz
IGEgZGVlcGVyIGRpc2N1c3Npb24gd2l0aCB0aGUgZXh0NA0KZGV2ZWxvcGVycywgSSB0aGluay4N
Cg0KTXkgYmlnZ2VzdCBxdWVzdGlvbiBmb3IgTFNGIGlzIGFyb3VuZCBkZXZlbG9wbWVudCBtb2Rl
bDoNCk91ciBjdXJyZW50IGRldmVsb3BtZW50IG1vZGVsIGlzIHN0aWxsIG9ydGhvZ29uYWwgdG8g
d2hhdA0KbW9zdCBvdGhlciBzdWJzeXN0ZW1zL2RyaXZlcnMgZG8uIEJ1dCBhcyB3ZSBldm9sdmUs
IGhvdyBkbw0Kd2UgZGVtb25zdHJhdGUgdGhhdCBvdXIgZGV2ZWxvcG1lbnQgbW9kZWwgaXMgcmVh
c29uYWJsZT8NClNlbmRpbmcgdGhlIGluaXRpYWwgcGF0Y2hlcyBpcyBvbmUgdGhpbmcuIENvbnZp
bmNpbmcgZXZlcnlvbmUNCnRoYXQgdGhlIG1vZGVsIGlzIHN1c3RhaW5hYmxlIGlzIGFub3RoZXIu
DQoNClRpbSBEYXkNCg0K


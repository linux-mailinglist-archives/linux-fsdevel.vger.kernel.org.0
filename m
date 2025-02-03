Return-Path: <linux-fsdevel+bounces-40623-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFE94A25F82
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Feb 2025 17:07:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D75D43AA27A
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Feb 2025 16:06:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82D7020A5F5;
	Mon,  3 Feb 2025 16:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="WnY+bkcZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-fw-52005.amazon.com (smtp-fw-52005.amazon.com [52.119.213.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0110E14F12D;
	Mon,  3 Feb 2025 16:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738598806; cv=none; b=phyhUHpMBMPW+48Gv7Gu8MhswOR/WCqILbZU5OPNDRUxYn8aEsFKln3J+o9DaeDTQS91BKYZRc413U8QnEgI9cvXAt01/peeK/fyscIKqGYPpFYA1RfgvEzxWtSF3J5qHcjQ76hc0v7YxE7Q8K5rfWTfzxrzrxmWopL0LoAwamM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738598806; c=relaxed/simple;
	bh=ASpeFHlAwWPzlEHXtgluofyW8ICp0Ap3azBZoh+U3Xg=;
	h=Subject:From:To:CC:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=NcVyfiGulYzF+pD5cBwcZ6vt03d05fHDW9Rd021CU/Ma+P1Emk0LC32lUQcbTfbE36M72YEpAbTIKESO98VB5NV9tBGC3bQ1YTIg4pzfDRXg7SZNRWpcDukqg+PRLtH9UMfpogxmGfPl4AX3YfBWaydL3yYawE8il1LVocsP72Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=WnY+bkcZ; arc=none smtp.client-ip=52.119.213.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1738598805; x=1770134805;
  h=from:to:cc:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version:subject;
  bh=ASpeFHlAwWPzlEHXtgluofyW8ICp0Ap3azBZoh+U3Xg=;
  b=WnY+bkcZMfhqyB57FrZelnCVmotLcuSCLd+nDX1rhgiKiS2zG0RnCWBE
   yCgpa4nnPgdRjJcuaI/UOC2d4qNSTKy6rforVJpcRBgCMe6xPVQIwyApp
   1p6lEgQcHnBz4CYvUCIZw9VFcdb2mVjYlsCxG2dnGjk4rILZH6EXVr/Xa
   w=;
X-IronPort-AV: E=Sophos;i="6.13,256,1732579200"; 
   d="scan'208";a="715636252"
Subject: Re: [Lsf-pc] [LSF/MM/BPF TOPIC] Lustre filesystem upstreaming
Thread-Topic: [Lsf-pc] [LSF/MM/BPF TOPIC] Lustre filesystem upstreaming
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-east-1.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52005.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2025 16:06:44 +0000
Received: from EX19MTAUEB002.ant.amazon.com [10.0.44.209:38164]
 by smtpin.naws.us-east-1.prod.farcaster.email.amazon.dev [10.0.6.110:2525] with esmtp (Farcaster)
 id da1aaf85-21e0-49d7-8ade-09ae5f607307; Mon, 3 Feb 2025 16:06:43 +0000 (UTC)
X-Farcaster-Flow-ID: da1aaf85-21e0-49d7-8ade-09ae5f607307
Received: from EX19D017UEA002.ant.amazon.com (10.252.134.77) by
 EX19MTAUEB002.ant.amazon.com (10.252.135.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Mon, 3 Feb 2025 16:06:43 +0000
Received: from EX19D017UEA001.ant.amazon.com (10.252.134.93) by
 EX19D017UEA002.ant.amazon.com (10.252.134.77) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Mon, 3 Feb 2025 16:06:43 +0000
Received: from EX19D017UEA001.ant.amazon.com ([fe80::bffb:623f:af5e:ebed]) by
 EX19D017UEA001.ant.amazon.com ([fe80::bffb:623f:af5e:ebed%3]) with mapi id
 15.02.1258.039; Mon, 3 Feb 2025 16:06:43 +0000
From: "Day, Timothy" <timday@amazon.com>
To: Christoph Hellwig <hch@infradead.org>, Theodore Ts'o <tytso@mit.edu>
CC: Zorro Lang <zlang@redhat.com>, Amir Goldstein <amir73il@gmail.com>,
	Andreas Dilger <adilger@ddn.com>, "lsf-pc@lists.linux-foundation.org"
	<lsf-pc@lists.linux-foundation.org>, "linux-fsdevel@vger.kernel.org"
	<linux-fsdevel@vger.kernel.org>, "jsimmons@infradead.org"
	<jsimmons@infradead.org>, "neilb@suse.de" <neilb@suse.de>, fstests
	<fstests@vger.kernel.org>
Thread-Index: AQHbdC0lJT0shTaEGUaJ4/a5JPi6tbMxK+qAgAEbT4CAADNcgIABqrgAgAEAcwCAAElOAA==
Date: Mon, 3 Feb 2025 16:06:43 +0000
Message-ID: <DA452751-79D7-4B9B-B831-F073197B5ABB@amazon.com>
References: <20250201135911.tglbjox4dx7htrco@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <20250202152045.GA12129@macsyma-2.local> <Z6BlxO4YjsjPQyuY@infradead.org>
In-Reply-To: <Z6BlxO4YjsjPQyuY@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="utf-8"
Content-ID: <6E2BCD5DF0C11A4C915F342CC79FF02E@amazon.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

T24gMi8zLzI1LCAxOjQ0IEFNLCAiQ2hyaXN0b3BoIEhlbGx3aWciIDxoY2hAaW5mcmFkZWFkLm9y
ZyA8bWFpbHRvOmhjaEBpbmZyYWRlYWQub3JnPj4gd3JvdGU6DQo+IE9uIFN1biwgRmViIDAyLCAy
MDI1IGF0IDEwOjI2OjI4QU0gLTA1MDAsIFRoZW9kb3JlIFRzJ28gd3JvdGU6DQo+ID4gV2VsbCwg
aW4gdGhlIHBhc3QgSSBhdHRlbXB0ZWQgdG8gbGFuZCBhICJsb2NhbCIgZmlsZSBzeXN0ZW0gdHlw
ZSB0aGF0DQo+ID4gY291bGQgYmUgdXNlZCBmb3IgZmlsZSBzeXN0ZW1zIHRoYXQgd2VyZSBhdmFp
bGFibGUgdmlhIGRvY2tlciAoYW5kIHNvDQo+ID4gdGhlcmUgd2FzIG5vIGJsb2NrIGRldmljZSB0
byBtb3VudCBhbmQgdW5tb3VudCkuIFRoaXMgd2FzIHVzZWZ1bCBmb3INCj4gPiB0ZXN0aW5nIGdW
aXNvclsxXSBhbmQgY291bGQgYWxzbyBiZSB1c2VkIGZvciB0ZXN0aW5nIFdpbmRvd3MgU3Vic3lz
dGVtDQo+ID4gZm9yIExpbnV4IHYxLiBBcyBJIHJlY2FsbCwgZWl0aGVyIERhdmUgb3IgQ3Jpc3Rv
cGggb2JqZWN0ZWQsIGV2ZW4NCj4gPiB0aG91Z2ggdGhlIGRpZmZzdGF0IHdhcyArNzMsIC00IGxp
bmVzIGluIGNvbW1vbi9yYy4NCj4NCj4gWWVzLCB4ZnN0ZXN0cyBzaG91bGQganVzdCBzdXBwb3J0
IHVwc3RyZWFtIGNvZGUuIEV2ZW4gZm9yIHRoaW5ncyB3aGVyZQ0KPiB3ZSB0aHJvdWdoIGl0IHdv
dWxkIGdldCB1cHN0cmVhbSBBU0FQIGxpa2UgdGhlIFhGUw0KPiBydHJtYXAvcmVmbGluay9tZXRh
ZGlyIHdvcmsgKHdoaWNoIGZpbmFsbHkgZGlkIGdldCB1cHN0cmVhbSBub3cpIGhhdmluZw0KPiB0
aGUgaGFsZi1maW5pc2hlZCBzdXBwb3J0IGluIHhmc3Rlc3RzIHdpdGhvdXQgYWN0dWFsbHkgbGFu
ZGluZyB0aGUgcmVzdA0KPiBjYXVzZWQgbW9yZSB0aGFuIGVub3VnaCBwcm9ibGVtcy4NCg0KVGhh
dOKAmXMgZmFpci4gRnJvbSB0aGUgcGVyc3BlY3RpdmUgb2Ygc29tZW9uZSBtYWtpbmcgY2hhbmdl
cyB0byB4ZnN0ZXN0cywNCml0J2QgcHJvYmFibHkgYmUgaGFyZCB0byBjaGFuZ2UgYW55IG9mIHRo
ZSBMdXN0cmUgc3R1ZmYgd2l0aG91dCBhbiBlYXN5DQp3YXkgdG8gdmFsaWRhdGUgdGhhdCB0aGUg
dGVzdHMgYXJlIHN0aWxsIHdvcmtpbmcgY29ycmVjdGx5Lg0KDQpCdXQgSSBnYXZlIGl0IGFub3Ro
ZXIgbG9vayB5ZXN0ZXJkYXkgLSB0aGUgY2hhbmdlcyBuZWVkIHRvIHN1cHBvcnQNCkx1c3RyZSBh
cmUgcHJldHR5IG1pbmltYWwuIGZzdGVzdHMgYXNzdW1lcyB0aGF0IGFueSBtaXNjZWxsYW5lb3Vz
IGZpbGVzeXN0ZW0NCmlzIGRpc2sgYmFzZWQuIFNvIGVpdGhlciByZWxheGluZyB0aGF0IGFzc3Vt
cHRpb24gb3IgYWRkaW5nIGFuIGV4cGxpY2l0IEx1c3RyZQ0KJEZTVFlQRSBpcyBlbm91Z2guIE9m
IGNvdXJzZSwgaW4gdGhlIGZ1bGxuZXNzIG9mIHRpbWUgLSBMdXN0cmUgb3VnaHQgdG8gaGF2ZQ0K
aXRzIG93biB0ZXN0cyBleGVyY2lzaW5nIHN0cmlwaW5nIGFuZCBzdWNoLiBXZSBoYXZlIG91ciBv
d24gdGVzdCBzY3JpcHRzIHRvDQpjb3ZlciB0aGlzIC0gYnV0IHBvcnRpbmcgYSBzdWJzZXQgdG8g
ZnN0ZXN0cyB3b3VsZCBiZSBoZWxwZnVsLiBCdXQgdGhlIGluaXRpYWwNCnN1cHBvcnQgZG9lc24n
dCBuZWVkIGFsbCB0aGF0Lg0KDQpCdXQgSSBzdXBwb3NlIEkgY291bGQga2VlcCB0aGlzIGFsbCBk
b3duc3RyZWFtIHVudGlsIEx1c3RyZSBnZXRzIGNsb3Nlcg0KdG8gYWNjZXB0YW5jZS4NCg0KPiBT
b21ldGhpbmcgbGlrZSBsdXN0cmUgdGhhdCBoYXMNCj4gaGlzdG9yaWNhbGx5IGJlZW4gYSBjb21w
bGV0ZSB0cmFpbndyZWNrIGFuZCB3aGVyZSBJIGhhdmUgc3Ryb25nIGRvdWJ0cw0KPiB0aGF0IHRo
ZSBtYWludGFpbmVycyBnZXQgdGhlaXIgYWN0IHRvZ2V0aGVyIGlzIGV2ZW4gd29yc2UuDQoNCkRp
ZCB5b3UgaGF2ZSBhbnkgc3BlY2lmaWMgZG91YnRzLCBiZXlvbmQgdGhlIGRldmVsb3BtZW50IG1v
ZGVsIGFuZA0KZGlzay93aXJlIHByb3RvY29sIHN0YWJpbGl0eT8gSW4gb3RoZXIgd29yZHMsIGlz
IHRoZSBkZXZlbG9wbWVudCBtb2RlbA0KdGhlIHByaW1hcnkgY29uY2Vybj8gT3IgYXJlIHRoZXJl
IHRlY2huaWNhbCBjb25jZXJucyB3aXRoIEx1c3RyZSBpdHNlbGY/DQoNClRpbSBEYXkNCg0K


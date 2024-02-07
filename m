Return-Path: <linux-fsdevel+bounces-10619-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BB92984CD71
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Feb 2024 15:57:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 47F56B26CFD
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Feb 2024 14:57:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C9157F7DF;
	Wed,  7 Feb 2024 14:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="BhyBzEYb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-fw-9106.amazon.com (smtp-fw-9106.amazon.com [207.171.188.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1505E7F477;
	Wed,  7 Feb 2024 14:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.188.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707317804; cv=none; b=GRrt4YmOxsuddG6XspMhnI3nSS1q92nAOyPjKFmWO2R4CWi8tMMzN09+jleInu3SAj6TG6P8JRaW82iwJVFnShuJtrWkwHcbKLsLNFDbZaAxWKjzFbKvRqB0du2I5JdI73fzgV+Z571wdGfR/fO3wfH1KpLbiKVtKV2HENB8ExM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707317804; c=relaxed/simple;
	bh=TkFpvZmkphqkK0Mc10r/Fe7liBcw8osCeQ/jSq2WNzk=;
	h=Subject:From:To:CC:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=OGw7QNDKhjYsu1HiiJEwypjE2ZTzzoam9LZmdYqxN2fiJLpGFThGJE9Xe9+CiZsYqgnPGHW8JBo35tlVexJik6E7N0Rd/zUFMHAlDeVidqavbt9S2MHRHEIJkt0IQBYwnLHSoAgWmuEa2j0Pmy8Wkesa4HsaM58cPHjALMxMpKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=BhyBzEYb; arc=none smtp.client-ip=207.171.188.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1707317804; x=1738853804;
  h=from:to:cc:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version:subject;
  bh=TkFpvZmkphqkK0Mc10r/Fe7liBcw8osCeQ/jSq2WNzk=;
  b=BhyBzEYbSJL/RtHXiu83YiUoPc6Kp+kadbQWWVG2dsCE+ppdEvmIisbZ
   YVsFwm7KBUPbzBNEl34Hbq1fKGOmNTstchHY4xBn0vkRvf9PnU/ocDs/l
   AizigMnLrXUML3d7ao4nuVuRe6MHAgSVSr5NE0yCcVB1eB9inLeByef59
   4=;
X-IronPort-AV: E=Sophos;i="6.05,251,1701129600"; 
   d="scan'208";a="702749743"
Subject: Re: [RFC 00/18] Pkernfs: Support persistence for live update
Thread-Topic: [RFC 00/18] Pkernfs: Support persistence for live update
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-9106.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2024 14:56:36 +0000
Received: from EX19MTAEUB001.ant.amazon.com [10.0.17.79:53357]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.33.191:2525] with esmtp (Farcaster)
 id 163cb722-79c0-4cd0-bb34-f3f452cd665d; Wed, 7 Feb 2024 14:56:33 +0000 (UTC)
X-Farcaster-Flow-ID: 163cb722-79c0-4cd0-bb34-f3f452cd665d
Received: from EX19D012EUC002.ant.amazon.com (10.252.51.162) by
 EX19MTAEUB001.ant.amazon.com (10.252.51.28) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Wed, 7 Feb 2024 14:56:33 +0000
Received: from EX19D014EUC004.ant.amazon.com (10.252.51.182) by
 EX19D012EUC002.ant.amazon.com (10.252.51.162) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Wed, 7 Feb 2024 14:56:33 +0000
Received: from EX19D014EUC004.ant.amazon.com ([fe80::76dd:4020:4ff2:1e41]) by
 EX19D014EUC004.ant.amazon.com ([fe80::76dd:4020:4ff2:1e41%3]) with mapi id
 15.02.1118.040; Wed, 7 Feb 2024 14:56:33 +0000
From: "Gowans, James" <jgowans@amazon.com>
To: "alex.williamson@redhat.com" <alex.williamson@redhat.com>, "jgg@ziepe.ca"
	<jgg@ziepe.ca>
CC: "kexec@lists.infradead.org" <kexec@lists.infradead.org>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>, "brauner@kernel.org"
	<brauner@kernel.org>, "Graf (AWS), Alexander" <graf@amazon.de>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>, "anthony.yznaga@oracle.com"
	<anthony.yznaga@oracle.com>, "skinsburskii@linux.microsoft.com"
	<skinsburskii@linux.microsoft.com>, "steven.sistare@oracle.com"
	<steven.sistare@oracle.com>, "akpm@linux-foundation.org"
	<akpm@linux-foundation.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "seanjc@google.com" <seanjc@google.com>,
	"Woodhouse, David" <dwmw@amazon.co.uk>, "pbonzini@redhat.com"
	<pbonzini@redhat.com>, "linux-mm@kvack.org" <linux-mm@kvack.org>,
	"joro@8bytes.org" <joro@8bytes.org>, "ebiederm@xmission.com"
	<ebiederm@xmission.com>, =?utf-8?B?U2Now7ZuaGVyciwgSmFuIEgu?=
	<jschoenh@amazon.de>, "will@kernel.org" <will@kernel.org>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"usama.arif@bytedance.com" <usama.arif@bytedance.com>
Thread-Index: AQHaWFZfiDfmUo9FfU6oG+xq/LSkjrD++v0A
Date: Wed, 7 Feb 2024 14:56:33 +0000
Message-ID: <6387700a8601722838332fdb2f535f9802d2202e.camel@amazon.com>
References: <20240205120203.60312-1-jgowans@amazon.com>
	 <20240205101040.5d32a7e4.alex.williamson@redhat.com>
In-Reply-To: <20240205101040.5d32a7e4.alex.williamson@redhat.com>
Accept-Language: en-ZA, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="utf-8"
Content-ID: <E7A761E4DFFA1B418369CD572A93C5BE@amazon.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

T24gTW9uLCAyMDI0LTAyLTA1IGF0IDEwOjEwIC0wNzAwLCBBbGV4IFdpbGxpYW1zb24gd3JvdGU6
DQo+ID4gKiBOZWVkaW5nIHRvIGRyaXZlIGFuZCByZS1oeWRyYXRlIHRoZSBJT01NVSBwYWdlIHRh
YmxlcyBieSBkZWZpbmluZw0KPiA+IGFuIElPTU1VIGZpbGUuDQo+ID4gUmVhbGx5IHdlIHNob3Vs
ZCBtb3ZlIHRoZSBhYnN0cmFjdGlvbiBvbmUgbGV2ZWwgdXAgYW5kIG1ha2UgdGhlDQo+ID4gd2hv
bGUgVkZJTw0KPiA+IGNvbnRhaW5lciBwZXJzaXN0ZW50IHZpYSBhIHBrZXJuZnMgZmlsZS4gVGhh
dCB3YXkgeW914oCZZCAianVzdCIgcmUtDQo+ID4gb3BlbiB0aGUgVkZJTw0KPiA+IGNvbnRhaW5l
ciBmaWxlIGFuZCBhbGwgb2YgdGhlIERNQSBtYXBwaW5ncyBpbnNpZGUgVkZJTyB3b3VsZCBhbHJl
YWR5DQo+ID4gYmUgc2V0IHVwLg0KPiANCj4gTm90ZSB0aGF0IHRoZSB2ZmlvIGNvbnRhaW5lciBp
cyBvbiBhIHBhdGggdG93YXJkcyBkZXByZWNhdGlvbiwgdGhpcw0KPiBzaG91bGQgYmUgcmVmb2N1
c2VkIG9uIHZmaW8gcmVsYXRpdmUgdG8gaW9tbXVmZC7CoCBUaGVyZSB3b3VsZCBuZWVkIHRvDQo+
IGJlIGEgc3Ryb25nIGFyZ3VtZW50IGZvciBhIGNvbnRhaW5lci90eXBlMSBleHRlbnNpb24gdG8g
c3VwcG9ydCB0aGlzLA0KPiBpb21tdWZkIHdvdWxkIG5lZWQgdG8gYmUgdGhlIGZpcnN0IGNsYXNz
IGltcGxlbWVudGF0aW9uLsKgIFRoYW5rcywNCg0KQWNrISBXaGVuIEkgZmlyc3Qgc3RhcnRlZCBw
dXR0aW5nIHBrZXJuZnMgdG9nZXRoZXIsIGlvbW11ZmQgd2Fzbid0DQppbnRlZ3JhdGVkIGludG8g
UUVNVSB5ZXQsIGhlbmNlIEkgc3R1Y2sgd2l0aCBWRklPIGZvciB0aGlzIFBvQy4NCkknbSB0aHJp
bGxlZCB0byBzZWUgdGhhdCBpb21tdWZkIG5vdyBzZWVtcyB0byBiZSBpbnRlZ3JhdGVkIGluIFFF
TVUhDQpHb29kIG9wcG9ydHVuaXR5IHRvIGdldCB0byBncmlwcyB3aXRoIGl0Lg0KDQpUaGUgVkZJ
Ty1zcGVjaWZpYyBwYXJ0IG9mIHRoaXMgcGF0Y2ggaXMgZXNzZW50aWFsbHkgaW9jdGxzIG9uIHRo
ZQ0KKmNvbnRhaW5lciogdG8gYmUgYWJsZSB0bzoNCg0KMS4gZGVmaW5lIHBlcnNpc3RlbnQgcGFn
ZSB0YWJsZXMgKFBQVHMpIG9uIHRoZSBjb250YWluZXJzIHNvIHRoYXQgdGhvc2UNClBQVHMgYXJl
IHVzZWQgYnkgdGhlIElPTU1VIGRvbWFpbiBhbmQgaGVuY2UgYnkgYWxsIGRldmljZXMgYWRkZWQg
dG8gdGhhdA0KY29udGFpbmVyLg0KaHR0cHM6Ly9naXRodWIuY29tL2pnb3dhbnMvcWVtdS9jb21t
aXQvZTg0Y2ZiODE4NmQ3MWY3OTdlZjFmNzJkNTdkODczMjIyYTliNDc5ZQ0KDQoyLiBUZWxsIFZG
SU8gdG8gYXZvaWQgbWFwcGluZyB0aGUgbWVtb3J5IGluIGFnYWluIGFmdGVyIGxpdmUgdXBkYXRl
DQpiZWNhdXNlIGl0IGFscmVhZHkgZXhpc3RzLg0KaHR0cHM6Ly9naXRodWIuY29tL2pnb3dhbnMv
cWVtdS9jb21taXQvNmU0ZjE3ZjcwM2VhZjJhNmYxZTRjYjI1NzZkNjE2ODNlYWVlMDJiMA0KKHRo
ZSBhYm92ZSBmbGFnIHNob3VsZCBvbmx5IGJlIHNldCAqYWZ0ZXIqIGxpdmUgdXBkYXRlLi4uKS4N
Cg0KRG8geW91IGhhdmUgYSByb3VnaCBzdWdnZXN0aW9uIGFib3V0IGhvdyBzaW1pbGFyIGNvdWxk
IGJlIGRvbmUgd2l0aA0KaW9tbXVmZD8NCg0KSkcNCg0K


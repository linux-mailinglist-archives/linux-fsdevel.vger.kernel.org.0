Return-Path: <linux-fsdevel+bounces-64847-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DA58BF5BC4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Oct 2025 12:17:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6937F40232B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Oct 2025 10:17:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6128132C31A;
	Tue, 21 Oct 2025 10:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b="olPmgnty"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fra-out-006.esa.eu-central-1.outbound.mail-perimeter.amazon.com (fra-out-006.esa.eu-central-1.outbound.mail-perimeter.amazon.com [18.197.217.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68D8AB652;
	Tue, 21 Oct 2025 10:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.197.217.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761041818; cv=none; b=q5vu3XH7RwplcL3gmIUwhVwfwUCS/2RH8xjhv92WesjLLikNOVSRGcrcT9giw3Ko9UZPT3e52J/XocL6yqrxKksAYLX4FVuYNlQzbKgVj/UAi0lVYK0HE9Y4+yvgjr/l3CqHcIrrxQhDQvFhTZk+nn6/5EUyRH7Tnj+tXGHIFiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761041818; c=relaxed/simple;
	bh=8MDXwoEIFINszKm73LVpBYFxmKJH+hoRSLKsyiU5mp4=;
	h=From:To:CC:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ekI26XMv60VVgiaDaYmwisgY6cdATOkc8yzoIU8m82DpGAJsnRWbP7QiMO6CZLj1g+ouIBfaVrKCfnut70PgmfVbPmrqoN82RPglUJe51noezA8M7oX1B+qx0TKmiiccJx7ZuFmHQ7Ub7hGEA6k5+rGzA7BRstMcBGfOhIfP7K8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de; spf=pass smtp.mailfrom=amazon.de; dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b=olPmgnty; arc=none smtp.client-ip=18.197.217.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazoncorp2;
  t=1761041814; x=1792577814;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version:content-transfer-encoding;
  bh=8MDXwoEIFINszKm73LVpBYFxmKJH+hoRSLKsyiU5mp4=;
  b=olPmgnty0B68hZrxZ6JCcV0+5pyyPv/kxvZgpPBRXNSZSMNZHEcTzF0o
   0/C+d8QVlnwdzXg4y5hQzX/vQAawN28aoTt4Q1gCiAWMauCsktSB1tOLj
   7M+bsEt+uHH1h5rvDpSDyTYgGtA1HleMbhNo4WS4gNsggsoPp8qogUBHl
   PJffsdN+2uEXcvq7RBsL41xwpxOiq8AKq6MpJddvrjI6/IQpSpNjLXRIi
   lF3S0kgKumF2Sa0QVTpkx9KDRsDhBQpHAxmxyU+5hs4zdxW06Z9sUIRTS
   T13N1/EHRD5r7HSG504fFSfxCnYO/ouu2axEDSTHnh6jKgHae3Z4KLi1L
   g==;
X-CSE-ConnectionGUID: t3cCI8X3TtayPGBVW0wUyg==
X-CSE-MsgGUID: KEzN1gffTHWZaf9BIhzJBg==
X-IronPort-AV: E=Sophos;i="6.19,244,1754956800"; 
   d="scan'208";a="3947772"
Received: from ip-10-6-3-216.eu-central-1.compute.internal (HELO smtpout.naws.eu-central-1.prod.farcaster.email.amazon.dev) ([10.6.3.216])
  by internal-fra-out-006.esa.eu-central-1.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2025 10:16:43 +0000
Received: from EX19MTAEUA002.ant.amazon.com [54.240.197.232:30186]
 by smtpin.naws.eu-central-1.prod.farcaster.email.amazon.dev [10.0.17.8:2525] with esmtp (Farcaster)
 id faaeaca1-ecac-4e7b-891e-ed40e4b2799d; Tue, 21 Oct 2025 10:16:43 +0000 (UTC)
X-Farcaster-Flow-ID: faaeaca1-ecac-4e7b-891e-ed40e4b2799d
Received: from EX19D013EUB004.ant.amazon.com (10.252.51.92) by
 EX19MTAEUA002.ant.amazon.com (10.252.50.126) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20;
 Tue, 21 Oct 2025 10:16:35 +0000
Received: from dev-dsk-mngyadam-1c-cb3f7548.eu-west-1.amazon.com.amazon.de
 (10.253.107.175) by EX19D013EUB004.ant.amazon.com (10.252.51.92) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20; Tue, 21 Oct 2025
 10:16:26 +0000
From: Mahmoud Nagy Adam <mngyadam@amazon.de>
To: Greg KH <gregkh@linuxfoundation.org>
CC: <stable@vger.kernel.org>, <nagy@khwaternagy.com>, Jens Axboe
	<axboe@kernel.dk>, Xiubo Li <xiubli@redhat.com>, Ilya Dryomov
	<idryomov@gmail.com>, Jeff Layton <jlayton@kernel.org>, Alexander Viro
	<viro@zeniv.linux.org.uk>, Theodore Ts'o <tytso@mit.edu>, Andreas Dilger
	<adilger.kernel@dilger.ca>, Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu
	<chao@kernel.org>, Christoph Hellwig <hch@infradead.org>, "Darrick J. Wong"
	<djwong@kernel.org>, Trond Myklebust <trond.myklebust@hammerspace.com>, "Anna
 Schumaker" <anna@kernel.org>, Ryusuke Konishi <konishi.ryusuke@gmail.com>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, Andrew Morton
	<akpm@linux-foundation.org>, Hannes Reinecke <hare@suse.de>, Damien Le Moal
	<dlemoal@kernel.org>, Luis Chamberlain <mcgrof@kernel.org>,
	<linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<ceph-devel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
	<linux-ext4@vger.kernel.org>, <linux-f2fs-devel@lists.sourceforge.net>,
	<linux-xfs@vger.kernel.org>, <linux-nfs@vger.kernel.org>,
	<linux-nilfs@vger.kernel.org>, <linux-mm@kvack.org>
Subject: Re: [PATCH 6.1 0/8] Backporting CVE-2025-38073 fix patch
In-Reply-To: <2025102111-stoppage-clergyman-f425@gregkh> (Greg KH's message of
	"Tue, 21 Oct 2025 09:43:45 +0200")
References: <20251021070353.96705-2-mngyadam@amazon.de>
	<2025102128-agent-handheld-30a6@gregkh>
	<lrkyqms5klnri.fsf@dev-dsk-mngyadam-1c-cb3f7548.eu-west-1.amazon.com>
	<2025102111-stoppage-clergyman-f425@gregkh>
Date: Tue, 21 Oct 2025 12:16:22 +0200
Message-ID: <lrkyqikg8lfux.fsf_-_@dev-dsk-mngyadam-1c-cb3f7548.eu-west-1.amazon.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-ClientProxiedBy: EX19D040UWB004.ant.amazon.com (10.13.138.91) To
 EX19D013EUB004.ant.amazon.com (10.252.51.92)
Content-Transfer-Encoding: base64

R3JlZyBLSCA8Z3JlZ2toQGxpbnV4Zm91bmRhdGlvbi5vcmc+IHdyaXRlczoKCj4gT24gVHVlLCBP
Y3QgMjEsIDIwMjUgYXQgMDk6MjU6MzdBTSArMDIwMCwgTWFobW91ZCBOYWd5IEFkYW0gd3JvdGU6
Cj4+IEdyZWcgS0ggPGdyZWdraEBsaW51eGZvdW5kYXRpb24ub3JnPiB3cml0ZXM6Cj4+Cj4+ID4K
Pj4gPgo+PiA+IE9uIFR1ZSwgT2N0IDIxLCAyMDI1IGF0IDA5OjAzOjM1QU0gKzAyMDAsIE1haG1v
dWQgQWRhbSB3cm90ZToKPj4gPj4gVGhpcyBzZXJpZXMgYWltcyB0byBmaXggdGhlIENWRS0yMDI1
LTM4MDczIGZvciA2LjEgTFRTLgo+PiA+Cj4+ID4gVGhhdCdzIG5vdCBnb2luZyB0byB3b3JrIHVu
dGlsIHRoZXJlIGlzIGEgZml4IGluIHRoZSA2LjYueSB0cmVlIGZpcnN0Lgo+PiA+IFlvdSBhbGwg
a25vdyB0aGlzIHF1aXRlIHdlbGwgOigKPj4gPgo+PiA+IFBsZWFzZSB3b3JrIG9uIHRoYXQgdHJl
ZSBmaXJzdCwgYW5kIHRoZW4gbW92ZSB0byBvbGRlciBvbmVzLgo+PiA+Cj4+Cj4+IFl1cCwgSSd2
ZSBhbHJlYWR5IHNlbnQgYSBzZXJpZXMgZm9yIDYuNiB5ZXN0ZXJkYXk6Cj4+IGh0dHBzOi8vbG9y
ZS5rZXJuZWwub3JnL3N0YWJsZS8yMDI1MTAyMDEyMjU0MS43MjI3LTEtbW5neWFkYW1AYW1hem9u
LmRlLwo+Cj4gQWgsIHRvdGFsbHkgbWlzc2VkIHRoYXQgYXMgaXQgd2FzICJqdXN0IiBhIHNpbmds
ZSBiYWNrcG9ydCwgbXkgZmF1bHQuCj4KCjYuNiBoYWQgYWxsIHRoZSByZXF1aXJlZCBkZXBlbmRl
bmNpZXMgYWxyZWFkeSBzbyBpdCB3YXMgZm9ydHVuYXRlbHkgYQpzaW1wbGVyIHNlcmllcyA6KS4g
SSdsbCBtYWtlIHN1cmUgdG8gcmVmZXJlbmNlIHRoZSBvdGhlciBzZXJpZXMgaW4gdGhlCmZ1dHVy
ZSBhcyB3ZWxsLgoKPiBUaGFua3MgZm9yIHRoaXMsIEknbGwgcmV2aWV3IHRoaXMgd2hlbiBJIGdl
dCBhIGNoYW5jZS4gIEhvdyB3YXMgdGhpcwo+IHRlc3RlZD8KClRoaXMgd2FzIHRlc3RlZCBieSBv
dXIgaW50ZXJuYWwgdGVzdGluZyBvdmVyIHZhcmlvdXMgRUMyIGluc3RhbmNlcwooeDg2XzY0ICYg
QVJNKS4gT3VyIHRlc3RpbmcgaW5jbHVkZXMgcnVubmluZyBrc2VsZnRlc3RzLCBmc3Rlc3RzLCBM
VFAKc3VpdGVzLgoKSWYgdGhlcmUgYXJlIHNwZWNpZmljIHRlc3RzIHlvdeKAmWQgbGlrZSBtZSB0
byBydW4gb3IgcmVzdWx0cyB0byBwcm92aWRlLApwbGVhc2UgbGV0IG1lIGtub3cuCgpUaGFua3Ms
Ck1OQWRhbQoKCgpBbWF6b24gV2ViIFNlcnZpY2VzIERldmVsb3BtZW50IENlbnRlciBHZXJtYW55
IEdtYkgKVGFtYXJhLURhbnotU3RyLiAxMwoxMDI0MyBCZXJsaW4KR2VzY2hhZWZ0c2Z1ZWhydW5n
OiBDaHJpc3RpYW4gU2NobGFlZ2VyCkVpbmdldHJhZ2VuIGFtIEFtdHNnZXJpY2h0IENoYXJsb3R0
ZW5idXJnIHVudGVyIEhSQiAyNTc3NjQgQgpTaXR6OiBCZXJsaW4KVXN0LUlEOiBERSAzNjUgNTM4
IDU5Nwo=



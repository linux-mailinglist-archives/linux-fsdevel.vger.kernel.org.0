Return-Path: <linux-fsdevel+bounces-62366-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 38CACB8F489
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Sep 2025 09:24:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A161189FCFB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Sep 2025 07:24:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E25A2F3C19;
	Mon, 22 Sep 2025 07:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b="C7jM2+PQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from pdx-out-001.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-001.esa.us-west-2.outbound.mail-perimeter.amazon.com [44.245.243.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E08A212578;
	Mon, 22 Sep 2025 07:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.245.243.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758525865; cv=none; b=sYok4R2pIII6PYD4vOk4lzljL4kPvo37QQ33aqgaXUre07lQfb/9HgpEz7GE/TyISdsBsdDo7JaO4gs5RncInS3rGML6Kq57vkZMk7mZKvBVn+8Q3nDxEc5FJFalzIrE1AUtZQI+ndnFsBx+LmrAhgIVBcYhFv9vQ7Z5oV/OIe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758525865; c=relaxed/simple;
	bh=s65qbdOBa/yhLNik1NHCrY9BC/xezzj2tA+Gp7ITl6w=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JgKczf/Th+pLwQp1SU49uTrabcb3/MOz1vKbjg9xbPfVVBFRXAHelrWrruLOOyvvOsAGIILZDaeP88JQVvBIDhhaP6tw7IkTpJT71X6hSzabhn2DpExXqWpL/pWKgjVsr22K/eyulpXL8QYLshDCi1/K1XN9RtjhhRlteVv8MN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de; spf=pass smtp.mailfrom=amazon.de; dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b=C7jM2+PQ; arc=none smtp.client-ip=44.245.243.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazoncorp2;
  t=1758525864; x=1790061864;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=s65qbdOBa/yhLNik1NHCrY9BC/xezzj2tA+Gp7ITl6w=;
  b=C7jM2+PQGxTrIXLQNoKA8RDSmzlLnzV963HEgc++iPsrVaVrUMnBhym1
   n8q/ExYpm5rBWh6fFaRXt/2h5Yqc/anaOZEQC6KTaythpmg43SrVZk5Zk
   ww2TUqHq9PrrDyHWfIRAdvx1TthpMP7+5AnOT2QWbL8HoUlHCIOedhazv
   QxlwpFa6An99v+xzLkWKS9ddq8URVPn2+cALlqjwjaCVtTONUzx9xYn4F
   qX/dAiLoFEplvkd8qQnTWNvl1bgWejMbDGdlMD4Q41z9zVXhmwpFufHmM
   09U/HrgxBqN5q1ZOl1+PQSkMsixTdEXRr6g/t6RyL4TvqJbaKJuSl6Epc
   g==;
X-CSE-ConnectionGUID: 3zgVgHRbTSGoAfgnbXipMA==
X-CSE-MsgGUID: JUNOs0TAQRODESP1JRCn3g==
X-IronPort-AV: E=Sophos;i="6.18,281,1751241600"; 
   d="scan'208";a="3459762"
Received: from ip-10-5-6-203.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.6.203])
  by internal-pdx-out-001.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2025 07:24:20 +0000
Received: from EX19MTAUWA001.ant.amazon.com [10.0.21.151:20163]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.11.168:2525] with esmtp (Farcaster)
 id 0cb36e63-7ea7-4a30-8a94-d550c614690f; Mon, 22 Sep 2025 07:24:20 +0000 (UTC)
X-Farcaster-Flow-ID: 0cb36e63-7ea7-4a30-8a94-d550c614690f
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.218) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20;
 Mon, 22 Sep 2025 07:24:20 +0000
Received: from dev-dsk-acsjakub-1b-6f9934e2.eu-west-1.amazon.com
 (172.19.75.107) by EX19D001UWA001.ant.amazon.com (10.13.138.214) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20; Mon, 22 Sep 2025
 07:24:17 +0000
Date: Mon, 22 Sep 2025 07:24:14 +0000
From: Jakub Acs <acsjakub@amazon.de>
To: Andrei Vagin <avagin@gmail.com>
CC: <linux-fsdevel@vger.kernel.org>, Andrew Morton
	<akpm@linux-foundation.org>, David Hildenbrand <david@redhat.com>, "Vlastimil
 Babka" <vbabka@suse.cz>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Jinjiang Tu <tujinjiang@huawei.com>, Suren Baghdasaryan <surenb@google.com>,
	Penglei Jiang <superman.xpt@gmail.com>, Mark Brown <broonie@kernel.org>,
	Baolin Wang <baolin.wang@linux.alibaba.com>, Ryan Roberts
	<ryan.roberts@arm.com>, =?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?=
	<mirq-linux@rere.qmqm.pl>, Stephen Rothwell <sfr@canb.auug.org.au>, "Muhammad
 Usama Anjum" <usama.anjum@collabora.com>, <stable@vger.kernel.org>
Subject: Re: [PATCH] fs/proc/task_mmu: check cur_buf for NULL
Message-ID: <20250922072414.GA40409@dev-dsk-acsjakub-1b-6f9934e2.eu-west-1.amazon.com>
References: <20250919142106.43527-1-acsjakub@amazon.de>
 <CANaxB-yAOhES6j6VJMDybAJJy8JEXM+ZB+ey4-=QVyLBeTYfrw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <CANaxB-yAOhES6j6VJMDybAJJy8JEXM+ZB+ey4-=QVyLBeTYfrw@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-ClientProxiedBy: EX19D032UWB003.ant.amazon.com (10.13.139.165) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)
Content-Transfer-Encoding: base64

T24gRnJpLCBTZXAgMTksIDIwMjUgYXQgMDk6MjI6MTRBTSAtMDcwMCwgQW5kcmVpIFZhZ2luIHdy
b3RlOgo+IE9uIEZyaSwgU2VwIDE5LCAyMDI1IGF0IDc6MjHigK9BTSBKYWt1YiBBY3MgPGFjc2ph
a3ViQGFtYXpvbi5kZT4gd3JvdGU6Cj4gPgo+ID4gV2hlbiBQQUdFTUFQX1NDQU4gaW9jdGwgaW52
b2tlZCB3aXRoIHZlY19sZW4gPSAwIHJlYWNoZXMKPiA+IHBhZ2VtYXBfc2Nhbl9iYWNrb3V0X3Jh
bmdlKCksIGtlcm5lbCBwYW5pY3Mgd2l0aCBudWxsLXB0ci1kZXJlZjoKPiA+Cj4gPiBbICAgNDQu
OTM2ODA4XSBPb3BzOiBnZW5lcmFsIHByb3RlY3Rpb24gZmF1bHQsIHByb2JhYmx5IGZvciBub24t
Y2Fub25pY2FsIGFkZHJlc3MgMHhkZmZmZmMwMDAwMDAwMDAwOiAwMDAwIFsjMV0gU01QIERFQlVH
X1BBR0VBTExPQyBLQVNBTiBOT1BUSQo+ID4gWyAgIDQ0LjkzNzc5N10gS0FTQU46IG51bGwtcHRy
LWRlcmVmIGluIHJhbmdlIFsweDAwMDAwMDAwMDAwMDAwMDAtMHgwMDAwMDAwMDAwMDAwMDA3XQo+
ID4gWyAgIDQ0LjkzODM5MV0gQ1BVOiAxIFVJRDogMCBQSUQ6IDI0ODAgQ29tbTogcmVwcm9kdWNl
ciBOb3QgdGFpbnRlZCA2LjE3LjAtcmM2ICMyMiBQUkVFTVBUKG5vbmUpCj4gPiBbICAgNDQuOTM5
MDYyXSBIYXJkd2FyZSBuYW1lOiBRRU1VIFN0YW5kYXJkIFBDIChpNDQwRlggKyBQSUlYLCAxOTk2
KSwgQklPUyByZWwtMS4xNi4zLTAtZ2E2ZWQ2YjcwMWYwYS1wcmVidWlsdC5xZW11Lm9yZyAwNC8w
MS8yMDE0Cj4gPiBbICAgNDQuOTM5OTM1XSBSSVA6IDAwMTA6cGFnZW1hcF9zY2FuX3RocF9lbnRy
eS5pc3JhLjArMHg3NDEvMHhhODAKPiA+Cj4gPiA8c25pcCByZWdpc3RlcnMsIHVucmVsaWFibGUg
dHJhY2U+Cj4gPgo+ID4gWyAgIDQ0Ljk0NjgyOF0gQ2FsbCBUcmFjZToKPiA+IFsgICA0NC45NDcw
MzBdICA8VEFTSz4KPiA+IFsgICA0NC45NDkyMTldICBwYWdlbWFwX3NjYW5fcG1kX2VudHJ5KzB4
ZWMvMHhmYTAKPiA+IFsgICA0NC45NTI1OTNdICB3YWxrX3BtZF9yYW5nZS5pc3JhLjArMHgzMDIv
MHg5MTAKPiA+IFsgICA0NC45NTQwNjldICB3YWxrX3B1ZF9yYW5nZS5pc3JhLjArMHg0MTkvMHg3
OTAKPiA+IFsgICA0NC45NTQ0MjddICB3YWxrX3A0ZF9yYW5nZSsweDQxZS8weDYyMAo+ID4gWyAg
IDQ0Ljk1NDc0M10gIHdhbGtfcGdkX3JhbmdlKzB4MzFlLzB4NjMwCj4gPiBbICAgNDQuOTU1MDU3
XSAgX193YWxrX3BhZ2VfcmFuZ2UrMHgxNjAvMHg2NzAKPiA+IFsgICA0NC45NTY4ODNdICB3YWxr
X3BhZ2VfcmFuZ2VfbW0rMHg0MDgvMHg5ODAKPiA+IFsgICA0NC45NTg2NzddICB3YWxrX3BhZ2Vf
cmFuZ2UrMHg2Ni8weDkwCj4gPiBbICAgNDQuOTU4OTg0XSAgZG9fcGFnZW1hcF9zY2FuKzB4Mjhk
LzB4OWMwCj4gPiBbICAgNDQuOTYxODMzXSAgZG9fcGFnZW1hcF9jbWQrMHg1OS8weDgwCj4gPiBb
ICAgNDQuOTYyNDg0XSAgX194NjRfc3lzX2lvY3RsKzB4MThkLzB4MjEwCj4gPiBbICAgNDQuOTYy
ODA0XSAgZG9fc3lzY2FsbF82NCsweDViLzB4MjkwCj4gPiBbICAgNDQuOTYzMTExXSAgZW50cnlf
U1lTQ0FMTF82NF9hZnRlcl9od2ZyYW1lKzB4NzYvMHg3ZQo+ID4KPiA+IHZlY19sZW4gPSAwIGlu
IHBhZ2VtYXBfc2Nhbl9pbml0X2JvdW5jZV9idWZmZXIoKSBtZWFucyBubyBidWZmZXJzIGFyZQo+
ID4gYWxsb2NhdGVkIGFuZCBwLT52ZWNfYnVmIHJlbWFpbnMgc2V0IHRvIE5VTEwuCj4gPgo+ID4g
VGhpcyBicmVha3MgYW4gYXNzdW1wdGlvbiBtYWRlIGxhdGVyIGluIHBhZ2VtYXBfc2Nhbl9iYWNr
b3V0X3JhbmdlKCksCj4gPiB0aGF0IHBhZ2VfcmVnaW9uIGlzIGFsd2F5cyBhbGxvY2F0ZWQgZm9y
IHAtPnZlY19idWZfaW5kZXguCj4gPgo+ID4gRml4IGl0IGJ5IGV4cGxpY2l0bHkgY2hlY2tpbmcg
Y3VyX2J1ZiBmb3IgTlVMTCBiZWZvcmUgZGVyZWZlcmVuY2luZy4KPiA+Cj4gPiBPdGhlciBzaXRl
cyB0aGF0IG1pZ2h0IHJ1biBpbnRvIHNhbWUgZGVyZWYtaXNzdWUgYXJlIGFscmVhZHkgKGRpcmVj
dGx5Cj4gPiBvciB0cmFuc2l0aXZlbHkpIHByb3RlY3RlZCBieSBjaGVja2luZyBwLT52ZWNfYnVm
Lgo+ID4KPiA+IE5vdGU6Cj4gPiBGcm9tIFBBR0VNQVBfU0NBTiBtYW4gcGFnZSwgaXQgc2VlbXMg
dmVjX2xlbiA9IDAgaXMgdmFsaWQgd2hlbiBubyBvdXRwdXQKPiA+IGlzIHJlcXVlc3RlZCBhbmQg
aXQncyBvbmx5IHRoZSBzaWRlIGVmZmVjdHMgY2FsbGVyIGlzIGludGVyZXN0ZWQgaW4sCj4gPiBo
ZW5jZSBpdCBwYXNzZXMgY2hlY2sgaW4gcGFnZW1hcF9zY2FuX2dldF9hcmdzKCkuCj4gPgo+ID4g
VGhpcyBpc3N1ZSB3YXMgZm91bmQgYnkgc3l6a2FsbGVyLgo+ID4KPiA+IEZpeGVzOiA1MjUyNmNh
N2ZkYjkgKCJmcy9wcm9jL3Rhc2tfbW11OiBpbXBsZW1lbnQgSU9DVEwgdG8gZ2V0IGFuZCBvcHRp
b25hbGx5IGNsZWFyIGluZm8gYWJvdXQgUFRFcyIpCj4gPiBDYzogQW5kcmV3IE1vcnRvbiA8YWtw
bUBsaW51eC1mb3VuZGF0aW9uLm9yZz4KPiA+IENjOiBEYXZpZCBIaWxkZW5icmFuZCA8ZGF2aWRA
cmVkaGF0LmNvbT4KPiA+IENjOiBWbGFzdGltaWwgQmFia2EgPHZiYWJrYUBzdXNlLmN6Pgo+ID4g
Q2M6IExvcmVuem8gU3RvYWtlcyA8bG9yZW56by5zdG9ha2VzQG9yYWNsZS5jb20+Cj4gPiBDYzog
SmluamlhbmcgVHUgPHR1amluamlhbmdAaHVhd2VpLmNvbT4KPiA+IENjOiBTdXJlbiBCYWdoZGFz
YXJ5YW4gPHN1cmVuYkBnb29nbGUuY29tPgo+ID4gQ2M6IFBlbmdsZWkgSmlhbmcgPHN1cGVybWFu
LnhwdEBnbWFpbC5jb20+Cj4gPiBDYzogTWFyayBCcm93biA8YnJvb25pZUBrZXJuZWwub3JnPgo+
ID4gQ2M6IEJhb2xpbiBXYW5nIDxiYW9saW4ud2FuZ0BsaW51eC5hbGliYWJhLmNvbT4KPiA+IENj
OiBSeWFuIFJvYmVydHMgPHJ5YW4ucm9iZXJ0c0Bhcm0uY29tPgo+ID4gQ2M6IEFuZHJlaSBWYWdp
biA8YXZhZ2luQGdtYWlsLmNvbT4KPiA+IENjOiAiTWljaGHFgiBNaXJvc8WCYXciIDxtaXJxLWxp
bnV4QHJlcmUucW1xbS5wbD4KPiA+IENjOiBTdGVwaGVuIFJvdGh3ZWxsIDxzZnJAY2FuYi5hdXVn
Lm9yZy5hdT4KPiA+IENjOiBNdWhhbW1hZCBVc2FtYSBBbmp1bSA8dXNhbWEuYW5qdW1AY29sbGFi
b3JhLmNvbT4KPiA+IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcKPiA+IGxpbnV4LWZzZGV2
ZWxAdmdlci5rZXJuZWwub3JnCj4gPiBDYzogc3RhYmxlQHZnZXIua2VybmVsLm9yZwo+ID4gU2ln
bmVkLW9mZi1ieTogSmFrdWIgQWNzIDxhY3NqYWt1YkBhbWF6b24uZGU+Cj4gPgo+ID4gLS0tCj4g
PiAgZnMvcHJvYy90YXNrX21tdS5jIHwgMyArKysKPiA+ICAxIGZpbGUgY2hhbmdlZCwgMyBpbnNl
cnRpb25zKCspCj4gPgo+ID4gZGlmZiAtLWdpdCBhL2ZzL3Byb2MvdGFza19tbXUuYyBiL2ZzL3By
b2MvdGFza19tbXUuYwo+ID4gaW5kZXggMjljY2EwZTZkMGZmLi44YzEwYTgxMzVlNzQgMTAwNjQ0
Cj4gPiAtLS0gYS9mcy9wcm9jL3Rhc2tfbW11LmMKPiA+ICsrKyBiL2ZzL3Byb2MvdGFza19tbXUu
Ywo+ID4gQEAgLTI0MTcsNiArMjQxNyw5IEBAIHN0YXRpYyB2b2lkIHBhZ2VtYXBfc2Nhbl9iYWNr
b3V0X3JhbmdlKHN0cnVjdCBwYWdlbWFwX3NjYW5fcHJpdmF0ZSAqcCwKPiA+ICB7Cj4gPiAgICAg
ICAgIHN0cnVjdCBwYWdlX3JlZ2lvbiAqY3VyX2J1ZiA9ICZwLT52ZWNfYnVmW3AtPnZlY19idWZf
aW5kZXhdOwo+ID4KPiA+ICsgICAgICAgaWYgKCFjdXJfYnVmKQo+IAo+IEkgdGhpbmsgaXQgaXMg
YmV0dGVyIHRvIGNoZWNrICFwLT52ZWNfYnVmLiBJIGtub3cgdGhhdCB2ZWNfYnVmX2luZGV4IGlz
Cj4gYWx3YXlzIDAgaW4gdGhpcyBjYXNlLCBzbyB0aGVyZSBpcyBubyBmdW5jdGlvbmFsIGRpZmZl
cmVuY2UsIGJ1dCB0aGUKPiAhcC0+dmVjX2J1ZiBpcyBtb3JlIHJlYWRhYmxlL29idmlvdXMuCj4g
Cj4gVGhhbmtzLAo+IEFuZHJlaQoKSSBjaG9zZSAoIWN1cl9idWYpIGJlY2F1c2UgaXQgaXMgbW9y
ZSAncGFyYW5vaWQnIHRoYW4gIXAtPnZlY19idWYsCmJ1dCBoYXBweSB0byBjaGFuZ2UgdGhhdCBp
biB2Mi4gSG93ZXZlciwgSSBub3RpY2VkIHRoYXQgdGhlIHBhdGNoIHdhcwphbHJlYWR5IG1lcmdl
ZCB0byBtbS1ob3RmaXhlcy11bnN0YWJsZSBpbiBbMV0uIFNob3VsZCBJIHN0aWxsIHNlbmQgdGhl
CnYyIHdpdGggYWRqdXN0bWVudD8KClsxXTogaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvYWxsLzIw
MjUwOTE5MjAxNDA0LjFBQ0I5QzRDRUYwQHNtdHAua2VybmVsLm9yZy8KCgoKQW1hem9uIFdlYiBT
ZXJ2aWNlcyBEZXZlbG9wbWVudCBDZW50ZXIgR2VybWFueSBHbWJIClRhbWFyYS1EYW56LVN0ci4g
MTMKMTAyNDMgQmVybGluCkdlc2NoYWVmdHNmdWVocnVuZzogQ2hyaXN0aWFuIFNjaGxhZWdlcgpF
aW5nZXRyYWdlbiBhbSBBbXRzZ2VyaWNodCBDaGFybG90dGVuYnVyZyB1bnRlciBIUkIgMjU3NzY0
IEIKU2l0ejogQmVybGluClVzdC1JRDogREUgMzY1IDUzOCA1OTcK



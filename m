Return-Path: <linux-fsdevel+bounces-40055-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A4DAA1BC0B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Jan 2025 19:23:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B3ADE7A56CE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Jan 2025 18:22:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA4BD1D88BF;
	Fri, 24 Jan 2025 18:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.fm header.i=@fastmail.fm header.b="l0Iz8zc3";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cmGsERaH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A37CE19005D
	for <linux-fsdevel@vger.kernel.org>; Fri, 24 Jan 2025 18:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737742951; cv=none; b=lEBIxSZWY06BMNa0Q/B2r6DKuR1oe2csQb3KEd6lMV03J3SPRvFsjYYB/lSPKy8Xc3IYhxalxL0/8AQmdxbeeGkm2HRRmftCTuU9WDiAH995h05PWspqm0CBMaAYRfvr+/Zd0a9iVoVUyKGbxkHKTO2x5H6Q+hGNPO5eIVOr6SU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737742951; c=relaxed/simple;
	bh=pg6+Gzh7T7T7/qRlKR5e7MNRvHrMKEWfoZOaNWcaL+M=;
	h=Content-Type:Message-ID:Date:MIME-Version:Subject:From:To:Cc:
	 References:In-Reply-To; b=O/XGFUVGQnb9k90iwFxzc3LtXSVR7G2qf7kO188V1i0GQD6EgSVciI+ezCp8k/i9Zrl/H002pVvy8HBRaPdIxu1JXiWcjVjWCHGE3IMkrv2TQHAB/7qyHrFl75ME8esIdyGDLaV51LnMY5YfuUI8K+lnZwpPQxSUyt8VRF52oU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.fm; spf=pass smtp.mailfrom=fastmail.fm; dkim=pass (2048-bit key) header.d=fastmail.fm header.i=@fastmail.fm header.b=l0Iz8zc3; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=cmGsERaH; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.fm
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.fm
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id AA92E1140083;
	Fri, 24 Jan 2025 13:22:28 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Fri, 24 Jan 2025 13:22:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.fm; h=
	cc:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1737742948; x=1737829348; bh=XPsMMiDVlh
	gXiwRyKKIWrY0Wh1GDVtsZQ8XVGdL/N4A=; b=l0Iz8zc3emGJjG+rnPYKsUK2vU
	vqbY8NFyR1Hbz7PhVlU1TwpBpejcm+jxY46z5lmOy6yhxK4SAAdUFaT+1xR9po8j
	KhH9vDNOmhkAp0BKuAc7K3hOxOSuUhArRNYm3HS3tOj0YiW4WzD9n50x5CPp8esh
	jSYdsslFUk4lYt9CmSXVltgqIJSJkDV+wGEanQPivgxhiT+jC915KZPdbTAVdZby
	aPfSg1PpUIO9OnVrXoWIqMmdVvw2Emtlw+AEE5jGYjCst1YSHMWLkOsn4pg3didR
	gtDb4Z4i3D27QlnoH8L1IO9Jv/Q2DOeKb1rSErJPZR03LtjLaPxwkTFEAo8Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1737742948; x=1737829348; bh=XPsMMiDVlhgXiwRyKKIWrY0Wh1GDVtsZQ8X
	VGdL/N4A=; b=cmGsERaHiENl5inABM+MTFCoeW/D2A2n/8jdZXQzJvojhFtwHTv
	rzpEt9qZ5lecJFEDKupRAzIFhBvv4y7VMWS3lVONJZGrQ3fyvkuToIctqMgDYobA
	a4IKhRh7BdXqcCThUmeBhBNyrlxE9KYUI5TcfohjSRfxLQSiONaxUyBC5Gkh/ovN
	PilXVJSbTx7mwKHgY0B/pjvjNmt1V7FZ7jgZSU09mXpdD9hJdXFCk0vHoS1lohDi
	SNRokZsXl6ozVA7/r8UfgMuUCr7PJR0ONto+eyY4QvUOBLoJVFnFpF/HNdnmsOkr
	lkJZf6i62sXf5irI6CkfqDL0zFURZ1o7x/A==
X-ME-Sender: <xms:ZNqTZ9zH7f7bYbq9hgJCszeb7DT3RpgVFWiXNjyCfx0bEdFAQ1AvNg>
    <xme:ZNqTZ9Tck3tMz_pCeqSV2SXZHTF6Ihe_q_QCuXJhBRImQK-Iwb870FbgPBm3wQqOB
    uMD-WjQ1tfFgXQm>
X-ME-Received: <xmr:ZNqTZ3XWK9nkWZCYDYGAPv5-HIlAU_VK-9nyP9jrf8izlyfv_v-SExCNxI2sKESxiRrbWM1_OlbL7iQFANKEWrdckHgNVl0jXy4qtfoji8S-k7BtC6lJ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudejgedghedvvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpegtkfffgggfuffhvfevfhgjsehmtderredtvdej
    necuhfhrohhmpeeuvghrnhguucfutghhuhgsvghrthcuoegsvghrnhgurdhstghhuhgsvg
    hrthesfhgrshhtmhgrihhlrdhfmheqnecuggftrfgrthhtvghrnhepgfefueetiefhieel
    vddtveeiuefhfeetkeetgeefjeehleejhfeiheettefftdefnecuffhomhgrihhnpehgih
    hthhhusgdrtghomhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhl
    fhhrohhmpegsvghrnhgurdhstghhuhgsvghrthesfhgrshhtmhgrihhlrdhfmhdpnhgspg
    hrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepjhhorghnnhgv
    lhhkohhonhhgsehgmhgrihhlrdgtohhmpdhrtghpthhtohepmhhikhhlohhssehsiigvrh
    gvughirdhhuhdprhgtphhtthhopehlihhnuhigqdhfshguvghvvghlsehvghgvrhdrkhgv
    rhhnvghlrdhorhhgpdhrtghpthhtohepkhgvrhhnvghlqdhtvggrmhesmhgvthgrrdgtoh
    hm
X-ME-Proxy: <xmx:ZNqTZ_jZFklqLdFd-hV1M7VmiyrK8jIi1BS3kk4cnkDHHnP3VmT4LQ>
    <xmx:ZNqTZ_Bic-PeLJVUwBKiLn62yaG0_ojc7aS8nrav4HCALAhIh95x9Q>
    <xmx:ZNqTZ4JcK1mtabcnb66jgVD1mtLBDIGVAwdNnyyztLcMyXGu6-fXtQ>
    <xmx:ZNqTZ-DACGPFGeovVVa3nXljMcBXXtr4cUh0fcPzhaTO53cOAyk29g>
    <xmx:ZNqTZ6-LPYn-Qt45wD699WJZgKOoSOCbtUOF_cPqrxxdw5JH6NZBY2Y7>
Feedback-ID: id8a24192:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 24 Jan 2025 13:22:27 -0500 (EST)
Content-Type: multipart/mixed; boundary="------------NN0Nz6uztXGUDP5059FZsEUz"
Message-ID: <e7dd6a74-ddd3-475a-ab31-f69763aec8ea@fastmail.fm>
Date: Fri, 24 Jan 2025 19:22:26 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] fuse: optimize over-io-uring request expiration check
From: Bernd Schubert <bernd.schubert@fastmail.fm>
To: Joanne Koong <joannelkoong@gmail.com>, miklos@szeredi.hu,
 linux-fsdevel@vger.kernel.org
Cc: kernel-team@meta.com
References: <20250123235251.1139078-1-joannelkoong@gmail.com>
 <11f66304-753d-4500-9c84-184f254d0e46@fastmail.fm>
Content-Language: en-US, de-DE, fr
In-Reply-To: <11f66304-753d-4500-9c84-184f254d0e46@fastmail.fm>

This is a multi-part message in MIME format.
--------------NN0Nz6uztXGUDP5059FZsEUz
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Joanne,

On 1/24/25 12:30, Bernd Schubert wrote:
> Hmm, would only need to check head? Oh I see it, we need to use
> list_move_tail().  


how about the attached updated patch, which uses
list_first_entry_or_null()? It also changes from list_move()
to list_move_tail() so that oldest entry is always on top.
I didn't give it any testing, though.

This is on top of the other fuse-uring updates I had sent
out about an hour ago.


Here is the corresponding branch
https://github.com/bsbernd/linux/tree/optimize-fuse-uring-req-timeouts


Thanks,
Bernd
--------------NN0Nz6uztXGUDP5059FZsEUz
Content-Type: text/x-patch; charset=UTF-8;
 name="fuse-optimize-uring-req-timeout.patch"
Content-Disposition: attachment;
 filename="fuse-optimize-uring-req-timeout.patch"
Content-Transfer-Encoding: base64

ZnVzZTogb3B0aW1pemUgb3Zlci1pby11cmluZyByZXF1ZXN0IGV4cGlyYXRpb24gY2hlY2sK
CkZyb206IEpvYW5uZSBLb29uZyA8am9hbm5lbGtvb25nQGdtYWlsLmNvbT4KCkN1cnJlbnRs
eSwgd2hlbiBjaGVja2luZyB3aGV0aGVyIGEgcmVxdWVzdCBoYXMgdGltZWQgb3V0LCB3ZSBj
aGVjawpmcHEgcHJvY2Vzc2luZywgYnV0IGZ1c2Utb3Zlci1pby11cmluZyBoYXMgb25lIGZw
cSBwZXIgY29yZSBhbmQgMjU2CmVudHJpZXMgaW4gdGhlIHByb2Nlc3NpbmcgdGFibGUuIEZv
ciBzeXN0ZW1zIHdoZXJlIHRoZXJlIGFyZSBhCmxhcmdlIG51bWJlciBvZiBjb3JlcywgdGhp
cyBtYXkgYmUgdG9vIG11Y2ggb3ZlcmhlYWQuCgpJbnN0ZWFkIG9mIGNoZWNraW5nIHRoZSBm
cHEgcHJvY2Vzc2luZyBsaXN0LCBjaGVjayBlbnRfd19yZXFfcXVldWUsCmVudF9pbl91c2Vy
c3BhY2UsIGFuZCBlbnRfY29tbWl0X3F1ZXVlLgoKU2lnbmVkLW9mZi1ieTogSm9hbm5lIEtv
b25nIDxqb2FubmVsa29vbmdAZ21haWwuY29tPgotLS0KIGZzL2Z1c2UvZGV2LmMgICAgICAg
IHwgICAgMiArLQogZnMvZnVzZS9kZXZfdXJpbmcuYyAgfCAgIDMxICsrKysrKysrKysrKysr
KysrKysrKysrKystLS0tLS0KIGZzL2Z1c2UvZnVzZV9kZXZfaS5oIHwgICAgMSAtCiAzIGZp
bGVzIGNoYW5nZWQsIDI2IGluc2VydGlvbnMoKyksIDggZGVsZXRpb25zKC0pCgpkaWZmIC0t
Z2l0IGEvZnMvZnVzZS9kZXYuYyBiL2ZzL2Z1c2UvZGV2LmMKaW5kZXggM2MwM2FhYzQ4MGE0
Li44MGExMWVmNGI2OWEgMTAwNjQ0Ci0tLSBhL2ZzL2Z1c2UvZGV2LmMKKysrIGIvZnMvZnVz
ZS9kZXYuYwpAQCAtNDUsNyArNDUsNyBAQCBib29sIGZ1c2VfcmVxdWVzdF9leHBpcmVkKHN0
cnVjdCBmdXNlX2Nvbm4gKmZjLCBzdHJ1Y3QgbGlzdF9oZWFkICpsaXN0KQogCXJldHVybiB0
aW1lX2lzX2JlZm9yZV9qaWZmaWVzKHJlcS0+Y3JlYXRlX3RpbWUgKyBmYy0+dGltZW91dC5y
ZXFfdGltZW91dCk7CiB9CiAKLWJvb2wgZnVzZV9mcHFfcHJvY2Vzc2luZ19leHBpcmVkKHN0
cnVjdCBmdXNlX2Nvbm4gKmZjLCBzdHJ1Y3QgbGlzdF9oZWFkICpwcm9jZXNzaW5nKQorc3Rh
dGljIGJvb2wgZnVzZV9mcHFfcHJvY2Vzc2luZ19leHBpcmVkKHN0cnVjdCBmdXNlX2Nvbm4g
KmZjLCBzdHJ1Y3QgbGlzdF9oZWFkICpwcm9jZXNzaW5nKQogewogCWludCBpOwogCmRpZmYg
LS1naXQgYS9mcy9mdXNlL2Rldl91cmluZy5jIGIvZnMvZnVzZS9kZXZfdXJpbmcuYwppbmRl
eCBjNDQ1MzM1MmEwYzEuLmVjYWVmZmJjMjY5OCAxMDA2NDQKLS0tIGEvZnMvZnVzZS9kZXZf
dXJpbmcuYworKysgYi9mcy9mdXNlL2Rldl91cmluZy5jCkBAIC0xNDAsNiArMTQwLDIzIEBA
IHZvaWQgZnVzZV91cmluZ19hYm9ydF9lbmRfcmVxdWVzdHMoc3RydWN0IGZ1c2VfcmluZyAq
cmluZykKIAl9CiB9CiAKK3N0YXRpYyBib29sIGVudF9saXN0X3JlcXVlc3RfZXhwaXJlZChz
dHJ1Y3QgZnVzZV9jb25uICpmYywgc3RydWN0IGxpc3RfaGVhZCAqbGlzdCkKK3sKKwlzdHJ1
Y3QgZnVzZV9yaW5nX2VudCAqZW50OworCXN0cnVjdCBmdXNlX3JlcSAqcmVxOworCisJZW50
ID0gbGlzdF9maXJzdF9lbnRyeV9vcl9udWxsKGxpc3QsIHN0cnVjdCBmdXNlX3JpbmdfZW50
LCBsaXN0KTsKKwlpZiAoIWVudCkKKwkJcmV0dXJuIGZhbHNlOworCisJcmVxID0gZW50LT5m
dXNlX3JlcTsKKwlpZiAoV0FSTl9PTl9PTkNFKCFyZXEpKQorCQlyZXR1cm4gZmFsc2U7CisK
KwlyZXR1cm4gdGltZV9pc19iZWZvcmVfamlmZmllcyhyZXEtPmNyZWF0ZV90aW1lICsKKwkJ
CQkgICAgICBmYy0+dGltZW91dC5yZXFfdGltZW91dCk7Cit9CisKIGJvb2wgZnVzZV91cmlu
Z19yZXF1ZXN0X2V4cGlyZWQoc3RydWN0IGZ1c2VfY29ubiAqZmMpCiB7CiAJc3RydWN0IGZ1
c2VfcmluZyAqcmluZyA9IGZjLT5yaW5nOwpAQCAtMTU3LDcgKzE3NCw5IEBAIGJvb2wgZnVz
ZV91cmluZ19yZXF1ZXN0X2V4cGlyZWQoc3RydWN0IGZ1c2VfY29ubiAqZmMpCiAJCXNwaW5f
bG9jaygmcXVldWUtPmxvY2spOwogCQlpZiAoZnVzZV9yZXF1ZXN0X2V4cGlyZWQoZmMsICZx
dWV1ZS0+ZnVzZV9yZXFfcXVldWUpIHx8CiAJCSAgICBmdXNlX3JlcXVlc3RfZXhwaXJlZChm
YywgJnF1ZXVlLT5mdXNlX3JlcV9iZ19xdWV1ZSkgfHwKLQkJICAgIGZ1c2VfZnBxX3Byb2Nl
c3NpbmdfZXhwaXJlZChmYywgcXVldWUtPmZwcS5wcm9jZXNzaW5nKSkgeworCQkgICAgZW50
X2xpc3RfcmVxdWVzdF9leHBpcmVkKGZjLCAmcXVldWUtPmVudF93X3JlcV9xdWV1ZSkgfHwK
KwkJICAgIGVudF9saXN0X3JlcXVlc3RfZXhwaXJlZChmYywgJnF1ZXVlLT5lbnRfaW5fdXNl
cnNwYWNlKSB8fAorCQkgICAgZW50X2xpc3RfcmVxdWVzdF9leHBpcmVkKGZjLCAmcXVldWUt
PmVudF9jb21taXRfcXVldWUpKSB7CiAJCQlzcGluX3VubG9jaygmcXVldWUtPmxvY2spOwog
CQkJcmV0dXJuIHRydWU7CiAJCX0KQEAgLTQ5Niw3ICs1MTUsNyBAQCBzdGF0aWMgdm9pZCBm
dXNlX3VyaW5nX2NhbmNlbChzdHJ1Y3QgaW9fdXJpbmdfY21kICpjbWQsCiAJc3Bpbl9sb2Nr
KCZxdWV1ZS0+bG9jayk7CiAJaWYgKGVudC0+c3RhdGUgPT0gRlJSU19BVkFJTEFCTEUpIHsK
IAkJZW50LT5zdGF0ZSA9IEZSUlNfVVNFUlNQQUNFOwotCQlsaXN0X21vdmUoJmVudC0+bGlz
dCwgJnF1ZXVlLT5lbnRfaW5fdXNlcnNwYWNlKTsKKwkJbGlzdF9tb3ZlX3RhaWwoJmVudC0+
bGlzdCwgJnF1ZXVlLT5lbnRfaW5fdXNlcnNwYWNlKTsKIAkJbmVlZF9jbWRfZG9uZSA9IHRy
dWU7CiAJCWVudC0+Y21kID0gTlVMTDsKIAl9CkBAIC03MTYsNyArNzM1LDcgQEAgc3RhdGlj
IGludCBmdXNlX3VyaW5nX3NlbmRfbmV4dF90b19yaW5nKHN0cnVjdCBmdXNlX3JpbmdfZW50
ICplbnQsCiAJY21kID0gZW50LT5jbWQ7CiAJZW50LT5jbWQgPSBOVUxMOwogCWVudC0+c3Rh
dGUgPSBGUlJTX1VTRVJTUEFDRTsKLQlsaXN0X21vdmUoJmVudC0+bGlzdCwgJnF1ZXVlLT5l
bnRfaW5fdXNlcnNwYWNlKTsKKwlsaXN0X21vdmVfdGFpbCgmZW50LT5saXN0LCAmcXVldWUt
PmVudF9pbl91c2Vyc3BhY2UpOwogCXNwaW5fdW5sb2NrKCZxdWV1ZS0+bG9jayk7CiAKIAlp
b191cmluZ19jbWRfZG9uZShjbWQsIDAsIDAsIGlzc3VlX2ZsYWdzKTsKQEAgLTc3MCw3ICs3
ODksNyBAQCBzdGF0aWMgdm9pZCBmdXNlX3VyaW5nX2FkZF9yZXFfdG9fcmluZ19lbnQoc3Ry
dWN0IGZ1c2VfcmluZ19lbnQgKmVudCwKIAlzcGluX3VubG9jaygmZmlxLT5sb2NrKTsKIAll
bnQtPmZ1c2VfcmVxID0gcmVxOwogCWVudC0+c3RhdGUgPSBGUlJTX0ZVU0VfUkVROwotCWxp
c3RfbW92ZSgmZW50LT5saXN0LCAmcXVldWUtPmVudF93X3JlcV9xdWV1ZSk7CisJbGlzdF9t
b3ZlX3RhaWwoJmVudC0+bGlzdCwgJnF1ZXVlLT5lbnRfd19yZXFfcXVldWUpOwogCWZ1c2Vf
dXJpbmdfYWRkX3RvX3BxKGVudCwgcmVxKTsKIH0KIApAQCAtODU1LDcgKzg3NCw3IEBAIHN0
YXRpYyBpbnQgZnVzZV9yaW5nX2VudF9zZXRfY29tbWl0KHN0cnVjdCBmdXNlX3JpbmdfZW50
ICplbnQpCiAJCXJldHVybiAtRUlPOwogCiAJZW50LT5zdGF0ZSA9IEZSUlNfQ09NTUlUOwot
CWxpc3RfbW92ZSgmZW50LT5saXN0LCAmcXVldWUtPmVudF9jb21taXRfcXVldWUpOworCWxp
c3RfbW92ZV90YWlsKCZlbnQtPmxpc3QsICZxdWV1ZS0+ZW50X2NvbW1pdF9xdWV1ZSk7CiAK
IAlyZXR1cm4gMDsKIH0KQEAgLTExODYsNyArMTIwNSw3IEBAIHN0YXRpYyB2b2lkIGZ1c2Vf
dXJpbmdfc2VuZChzdHJ1Y3QgZnVzZV9yaW5nX2VudCAqZW50LCBzdHJ1Y3QgaW9fdXJpbmdf
Y21kICpjbWQsCiAKIAlzcGluX2xvY2soJnF1ZXVlLT5sb2NrKTsKIAllbnQtPnN0YXRlID0g
RlJSU19VU0VSU1BBQ0U7Ci0JbGlzdF9tb3ZlKCZlbnQtPmxpc3QsICZxdWV1ZS0+ZW50X2lu
X3VzZXJzcGFjZSk7CisJbGlzdF9tb3ZlX3RhaWwoJmVudC0+bGlzdCwgJnF1ZXVlLT5lbnRf
aW5fdXNlcnNwYWNlKTsKIAllbnQtPmNtZCA9IE5VTEw7CiAJc3Bpbl91bmxvY2soJnF1ZXVl
LT5sb2NrKTsKIApkaWZmIC0tZ2l0IGEvZnMvZnVzZS9mdXNlX2Rldl9pLmggYi9mcy9mdXNl
L2Z1c2VfZGV2X2kuaAppbmRleCAzYzRhZTRkNTJiNmYuLjE5YzI5YzYwMDBhNyAxMDA2NDQK
LS0tIGEvZnMvZnVzZS9mdXNlX2Rldl9pLmgKKysrIGIvZnMvZnVzZS9mdXNlX2Rldl9pLmgK
QEAgLTYzLDcgKzYzLDYgQEAgdm9pZCBmdXNlX2Rldl9xdWV1ZV9mb3JnZXQoc3RydWN0IGZ1
c2VfaXF1ZXVlICpmaXEsCiB2b2lkIGZ1c2VfZGV2X3F1ZXVlX2ludGVycnVwdChzdHJ1Y3Qg
ZnVzZV9pcXVldWUgKmZpcSwgc3RydWN0IGZ1c2VfcmVxICpyZXEpOwogCiBib29sIGZ1c2Vf
cmVxdWVzdF9leHBpcmVkKHN0cnVjdCBmdXNlX2Nvbm4gKmZjLCBzdHJ1Y3QgbGlzdF9oZWFk
ICpsaXN0KTsKLWJvb2wgZnVzZV9mcHFfcHJvY2Vzc2luZ19leHBpcmVkKHN0cnVjdCBmdXNl
X2Nvbm4gKmZjLCBzdHJ1Y3QgbGlzdF9oZWFkICpwcm9jZXNzaW5nKTsKIAogI2VuZGlmCiAK


--------------NN0Nz6uztXGUDP5059FZsEUz--


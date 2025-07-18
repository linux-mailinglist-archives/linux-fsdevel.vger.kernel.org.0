Return-Path: <linux-fsdevel+bounces-55455-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9239B0A9F5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Jul 2025 20:07:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E51BF16D169
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Jul 2025 18:07:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CB672E7193;
	Fri, 18 Jul 2025 18:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b="rKr/e9Jb";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ixO7dlkX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D9F52E36F7
	for <linux-fsdevel@vger.kernel.org>; Fri, 18 Jul 2025 18:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752862057; cv=none; b=gRG667KF3vIQ6kdzoVmbg5bfwkChvKenaIVysTgaYfpFbaEjCqWuU3hs8jEeV/XH+PvkDuM+fI3sIlX7pRIRsXi3MbJHuio+NU0qypHMTAN7glN8u6aFx06LVmAtUX6b4CQ4PKyUjqNt/wR4IZaABJNUiHa3yg1qUBekeW4003Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752862057; c=relaxed/simple;
	bh=1lWqXeCuU03hIV06rJzT9n9WDXt/BRe8lOnUDgjI9TI=;
	h=Content-Type:Message-ID:Date:MIME-Version:Subject:From:To:Cc:
	 References:In-Reply-To; b=fztFZcOX2k3bLx9GIpxHsSPo+GqAbHZSE0aRS5IF4t22bcS83mr4DhdmnZWis4Ei8PFhyTeCV3CrYFqz/6vvpQ0iTM390yiz9y2jlMEi45MGodiHzv/FabwvJUJgMXlsCLfHaKeK5xw+aESNLIb1ek08+GGhqsLjDme91mItXZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com; spf=pass smtp.mailfrom=bsbernd.com; dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b=rKr/e9Jb; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ixO7dlkX; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bsbernd.com
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 1C12C140006E;
	Fri, 18 Jul 2025 14:07:33 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Fri, 18 Jul 2025 14:07:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bsbernd.com; h=
	cc:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1752862053; x=1752948453; bh=8NZNASIHYi
	AZ9IzBD7pMH4j2UtwbJf5gfOxfub/ow3s=; b=rKr/e9Jb4lB5i1Mx0YrdVo4UPJ
	BJJk+yPMa0gULlYoiSGp1fkO7NBWMUuopy8l0SeGY1y9YOGznFcfq5VMmxCGc2KT
	nzDTRn+LnXBinAy7HChW1tuHIWeaIw09mHvEjDICjYTe+6rtQDKqzW76PFV2NEmP
	D+kCPH2+Kq9TfROgkxFddj3znPrQGWxVa0zetJlTRu8SjpkPVNwe+D2kB2CNCYzL
	yuwoST6x15Kk6p81V/HULqY3TZnnN545NcCvlwe+J2WNtJNfmUk9XLjhDn2kUrGW
	6Cln5p8E4v8bhReEE717HWTAxC1ySQwInyPlC2aLW5gnu+ODyyxnNrE2RDnQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1752862053; x=1752948453; bh=8NZNASIHYiAZ9IzBD7pMH4j2UtwbJf5gfOx
	fub/ow3s=; b=ixO7dlkXx6GJxFGL7d+eJB2uMqaFfZqyqFufuD5jdBNkCM+3qrb
	10WcFWST6QtYb8esBT87kO/GQfZbKQR85wtHYbBHVUQ0CboJKu41CREHpPGRL4qL
	DI0SpDk9nMZ/svuaRLbmaSVLAABxv5ASHqXnzrI9nSjIyDLeFxYi4ESHN6YwuOMZ
	PczVhPMReUS5uxabp0L0G70yxHTQcVeEB6Lwk9tEzKgbYOwNPEPua5y3dd1BS3HL
	o4Vyeh1F5rVV6SqH00gb7nyJyneU2LiUgLJVniSBpAqPggp8oyDmxEBvHsx97lln
	GkZgUQsaAGUcMFSW0Al/jh2ieQOlXWV62rg==
X-ME-Sender: <xms:ZI16aBdaMnYIhpdysyxbvJ4r00TzVEcZHbxEMdv9iL0f9F2F0a4_Bw>
    <xme:ZI16aMzh2HqXjPUPMfoa6VyKTrzvMfC26TbehG55Xv3s1ECmx9sgXT-VJZmR3-Yzo
    bvc00vc-OJrU4yb>
X-ME-Received: <xmr:ZI16aA_a9Md-ImN5WWZ27mJsg90lNOI6ahRYNAUpUK39VgYubOVfwmgxxYjn_Nex3WB89WBMalOFErmsrZ3DgqXlA70NJrWa8NOyLRMigzMCpthdY-Qg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdeigedugecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpegtkfffgggfuffhvfevfhgjsehmtderredtvdejnecuhfhrohhmpeeuvghrnhguucfu
    tghhuhgsvghrthcuoegsvghrnhgusegsshgsvghrnhgurdgtohhmqeenucggtffrrghtth
    gvrhhnpeeikeegjeektefgleejtefgkefhuddtvdduheeigeeijeeluddvgeejjeejkeeu
    udenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsvg
    hrnhgusegsshgsvghrnhgurdgtohhmpdhnsggprhgtphhtthhopeejpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopegujhifohhngheskhgvrhhnvghlrdhorhhgpdhrtghpth
    htoheplhhinhhugidqfhhsuggvvhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgt
    phhtthhopehnvggrlhesghhomhhprgdruggvvhdprhgtphhtthhopehjohhhnhesghhroh
    hvvghsrdhnvghtpdhrtghpthhtohepmhhikhhlohhssehsiigvrhgvughirdhhuhdprhgt
    phhtthhopehjohgrnhhnvghlkhhoohhnghesghhmrghilhdrtghomhdprhgtphhtthhope
    hhsghirhhthhgvlhhmvghrseguughnrdgtohhm
X-ME-Proxy: <xmx:ZI16aMgms25i3KZ7_WUixWo5qsSxUA2bhQNNG5x6c1px2jN8C7Mg9A>
    <xmx:ZI16aPGSzJnu_nqy9_mgMnZhS1PzwxFbx4V2nApAYpoWxhT--hEWow>
    <xmx:ZI16aD9yJTCFbkINq9FqNzcwWHXU6cYaIF-80ri3TtR_Dh0ZoWaKRg>
    <xmx:ZI16aOw5E6fgdSLCNrd1hmrgPvjMtTvZf4QE7MMBktTnbvXTcVJXUw>
    <xmx:ZY16aOxx1NeuEufGNkXIGHqxLJ48oDADtvyt_CM6uBbf2OidvZMMLtgX>
Feedback-ID: i5c2e48a5:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 18 Jul 2025 14:07:31 -0400 (EDT)
Content-Type: multipart/mixed; boundary="------------0ROvnKzHAWK4eyHVZV8261Vx"
Message-ID: <71f7e629-13ed-4320-a9c1-da2a16b2e26d@bsbernd.com>
Date: Fri, 18 Jul 2025 20:07:30 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/7] fuse: flush pending fuse events before aborting the
 connection
From: Bernd Schubert <bernd@bsbernd.com>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, neal@gompa.dev, John@groves.net,
 miklos@szeredi.hu, joannelkoong@gmail.com,
 Horst Birthelmer <hbirthelmer@ddn.com>
References: <175279449418.710975.17923641852675480305.stgit@frogsfrogsfrogs>
 <175279449501.710975.16858401145201411486.stgit@frogsfrogsfrogs>
 <286e65f0-a54c-46f0-86b7-e997d8bbca21@bsbernd.com>
Content-Language: en-US, de-DE, fr
In-Reply-To: <286e65f0-a54c-46f0-86b7-e997d8bbca21@bsbernd.com>

This is a multi-part message in MIME format.
--------------0ROvnKzHAWK4eyHVZV8261Vx
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


> 
> Please see the two attached patches, which are needed for fuse-io-uring.
> I can also send them separately, if you prefer.

We (actually Horst) is just testing it as Horst sees failing xfs tests in
our branch with tmp page removal

Patch 2 needs this addition (might be more, as I didn't test). 
I had it in first, but then split the patch and missed that.

diff --git a/fs/fuse/dev_uring.c b/fs/fuse/dev_uring.c
index eca457d1005e..acf11eadbf3b 100644
--- a/fs/fuse/dev_uring.c
+++ b/fs/fuse/dev_uring.c
@@ -123,6 +123,9 @@ void fuse_uring_flush_bg(struct fuse_conn *fc)
        struct fuse_ring_queue *queue;
        struct fuse_ring *ring = fc->ring;
 
+       if (!ring)
+               return;
+
        for (qid = 0; qid < ring->nr_queues; qid++) {
                queue = READ_ONCE(ring->queues[qid]);
                if (!queue)



--------------0ROvnKzHAWK4eyHVZV8261Vx
Content-Type: text/plain; charset=UTF-8; name="01-flush-io-uring-queue"
Content-Disposition: attachment; filename="01-flush-io-uring-queue"
Content-Transfer-Encoding: base64

ZnVzZTogUmVmYWN0b3IgaW8tdXJpbmcgYmcgcXVldWUgZmx1c2ggYW5kIHF1ZXVlIGFib3J0
CgpGcm9tOiBCZXJuZCBTY2h1YmVydCA8YnNjaHViZXJ0QGRkbi5jb20+CgpUaGlzIGlzIGEg
cHJlcGFyYXRpb24gdG8gYWxsb3cgZnVzZS1pby11cmluZyBiZyBxdWV1ZQpmbHVzaCBmcm9t
IGZsdXNoX2JnX3F1ZXVlKCkKClRoaXMgZG9lcyB0d28gZnVuY3Rpb24gcmVuYW1lczoKZnVz
ZV91cmluZ19mbHVzaF9iZyAtPiBmdXNlX3VyaW5nX2ZsdXNoX3F1ZXVlX2JnCmZ1c2VfdXJp
bmdfYWJvcnRfZW5kX3JlcXVlc3RzIC0+IGZ1c2VfdXJpbmdfZmx1c2hfYmcKCkFuZCBmdXNl
X3VyaW5nX2Fib3J0X2VuZF9xdWV1ZV9yZXF1ZXN0cygpIGlzIG1vdmVkIHRvCmZ1c2VfdXJp
bmdfc3RvcF9xdWV1ZXMoKS4KClNpZ25lZC1vZmYtYnk6IEJlcm5kIFNjaHViZXJ0IDxic2No
dWJlcnRAZGRuLmNvbT4KLS0tCiBmcy9mdXNlL2Rldl91cmluZy5jICAgfCAgIDE0ICsrKysr
KystLS0tLS0tCiBmcy9mdXNlL2Rldl91cmluZ19pLmggfCAgICA0ICsrLS0KIDIgZmlsZXMg
Y2hhbmdlZCwgOSBpbnNlcnRpb25zKCspLCA5IGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBh
L2ZzL2Z1c2UvZGV2X3VyaW5nLmMgYi9mcy9mdXNlL2Rldl91cmluZy5jCmluZGV4IDI0OWIy
MTBiZWNiMS4uZWNhNDU3ZDEwMDVlIDEwMDY0NAotLS0gYS9mcy9mdXNlL2Rldl91cmluZy5j
CisrKyBiL2ZzL2Z1c2UvZGV2X3VyaW5nLmMKQEAgLTQ3LDcgKzQ3LDcgQEAgc3RhdGljIHN0
cnVjdCBmdXNlX3JpbmdfZW50ICp1cmluZ19jbWRfdG9fcmluZ19lbnQoc3RydWN0IGlvX3Vy
aW5nX2NtZCAqY21kKQogCXJldHVybiBwZHUtPmVudDsKIH0KIAotc3RhdGljIHZvaWQgZnVz
ZV91cmluZ19mbHVzaF9iZyhzdHJ1Y3QgZnVzZV9yaW5nX3F1ZXVlICpxdWV1ZSkKK3N0YXRp
YyB2b2lkIGZ1c2VfdXJpbmdfZmx1c2hfcXVldWVfYmcoc3RydWN0IGZ1c2VfcmluZ19xdWV1
ZSAqcXVldWUpCiB7CiAJc3RydWN0IGZ1c2VfcmluZyAqcmluZyA9IHF1ZXVlLT5yaW5nOwog
CXN0cnVjdCBmdXNlX2Nvbm4gKmZjID0gcmluZy0+ZmM7CkBAIC04OCw3ICs4OCw3IEBAIHN0
YXRpYyB2b2lkIGZ1c2VfdXJpbmdfcmVxX2VuZChzdHJ1Y3QgZnVzZV9yaW5nX2VudCAqZW50
LCBzdHJ1Y3QgZnVzZV9yZXEgKnJlcSwKIAlpZiAodGVzdF9iaXQoRlJfQkFDS0dST1VORCwg
JnJlcS0+ZmxhZ3MpKSB7CiAJCXF1ZXVlLT5hY3RpdmVfYmFja2dyb3VuZC0tOwogCQlzcGlu
X2xvY2soJmZjLT5iZ19sb2NrKTsKLQkJZnVzZV91cmluZ19mbHVzaF9iZyhxdWV1ZSk7CisJ
CWZ1c2VfdXJpbmdfZmx1c2hfcXVldWVfYmcocXVldWUpOwogCQlzcGluX3VubG9jaygmZmMt
PmJnX2xvY2spOwogCX0KIApAQCAtMTE3LDExICsxMTcsMTEgQEAgc3RhdGljIHZvaWQgZnVz
ZV91cmluZ19hYm9ydF9lbmRfcXVldWVfcmVxdWVzdHMoc3RydWN0IGZ1c2VfcmluZ19xdWV1
ZSAqcXVldWUpCiAJZnVzZV9kZXZfZW5kX3JlcXVlc3RzKCZyZXFfbGlzdCk7CiB9CiAKLXZv
aWQgZnVzZV91cmluZ19hYm9ydF9lbmRfcmVxdWVzdHMoc3RydWN0IGZ1c2VfcmluZyAqcmlu
ZykKK3ZvaWQgZnVzZV91cmluZ19mbHVzaF9iZyhzdHJ1Y3QgZnVzZV9jb25uICpmYykKIHsK
IAlpbnQgcWlkOwogCXN0cnVjdCBmdXNlX3JpbmdfcXVldWUgKnF1ZXVlOwotCXN0cnVjdCBm
dXNlX2Nvbm4gKmZjID0gcmluZy0+ZmM7CisJc3RydWN0IGZ1c2VfcmluZyAqcmluZyA9IGZj
LT5yaW5nOwogCiAJZm9yIChxaWQgPSAwOyBxaWQgPCByaW5nLT5ucl9xdWV1ZXM7IHFpZCsr
KSB7CiAJCXF1ZXVlID0gUkVBRF9PTkNFKHJpbmctPnF1ZXVlc1txaWRdKTsKQEAgLTEzMywx
MCArMTMzLDkgQEAgdm9pZCBmdXNlX3VyaW5nX2Fib3J0X2VuZF9yZXF1ZXN0cyhzdHJ1Y3Qg
ZnVzZV9yaW5nICpyaW5nKQogCQlXQVJOX09OX09OQ0UocmluZy0+ZmMtPm1heF9iYWNrZ3Jv
dW5kICE9IFVJTlRfTUFYKTsKIAkJc3Bpbl9sb2NrKCZxdWV1ZS0+bG9jayk7CiAJCXNwaW5f
bG9jaygmZmMtPmJnX2xvY2spOwotCQlmdXNlX3VyaW5nX2ZsdXNoX2JnKHF1ZXVlKTsKKwkJ
ZnVzZV91cmluZ19mbHVzaF9xdWV1ZV9iZyhxdWV1ZSk7CiAJCXNwaW5fdW5sb2NrKCZmYy0+
YmdfbG9jayk7CiAJCXNwaW5fdW5sb2NrKCZxdWV1ZS0+bG9jayk7Ci0JCWZ1c2VfdXJpbmdf
YWJvcnRfZW5kX3F1ZXVlX3JlcXVlc3RzKHF1ZXVlKTsKIAl9CiB9CiAKQEAgLTQ3NSw2ICs0
NzQsNyBAQCB2b2lkIGZ1c2VfdXJpbmdfc3RvcF9xdWV1ZXMoc3RydWN0IGZ1c2VfcmluZyAq
cmluZykKIAkJaWYgKCFxdWV1ZSkKIAkJCWNvbnRpbnVlOwogCisJCWZ1c2VfdXJpbmdfYWJv
cnRfZW5kX3F1ZXVlX3JlcXVlc3RzKHF1ZXVlKTsKIAkJZnVzZV91cmluZ190ZWFyZG93bl9l
bnRyaWVzKHF1ZXVlKTsKIAl9CiAKQEAgLTEzMjYsNyArMTMyNiw3IEBAIGJvb2wgZnVzZV91
cmluZ19xdWV1ZV9icV9yZXEoc3RydWN0IGZ1c2VfcmVxICpyZXEpCiAJZmMtPm51bV9iYWNr
Z3JvdW5kKys7CiAJaWYgKGZjLT5udW1fYmFja2dyb3VuZCA9PSBmYy0+bWF4X2JhY2tncm91
bmQpCiAJCWZjLT5ibG9ja2VkID0gMTsKLQlmdXNlX3VyaW5nX2ZsdXNoX2JnKHF1ZXVlKTsK
KwlmdXNlX3VyaW5nX2ZsdXNoX3F1ZXVlX2JnKHF1ZXVlKTsKIAlzcGluX3VubG9jaygmZmMt
PmJnX2xvY2spOwogCiAJLyoKZGlmZiAtLWdpdCBhL2ZzL2Z1c2UvZGV2X3VyaW5nX2kuaCBi
L2ZzL2Z1c2UvZGV2X3VyaW5nX2kuaAppbmRleCA1MWE1NjM5MjJjZTEuLjU1ZjUyNTA4ZGUz
YyAxMDA2NDQKLS0tIGEvZnMvZnVzZS9kZXZfdXJpbmdfaS5oCisrKyBiL2ZzL2Z1c2UvZGV2
X3VyaW5nX2kuaApAQCAtMTM4LDcgKzEzOCw3IEBAIHN0cnVjdCBmdXNlX3JpbmcgewogYm9v
bCBmdXNlX3VyaW5nX2VuYWJsZWQodm9pZCk7CiB2b2lkIGZ1c2VfdXJpbmdfZGVzdHJ1Y3Qo
c3RydWN0IGZ1c2VfY29ubiAqZmMpOwogdm9pZCBmdXNlX3VyaW5nX3N0b3BfcXVldWVzKHN0
cnVjdCBmdXNlX3JpbmcgKnJpbmcpOwotdm9pZCBmdXNlX3VyaW5nX2Fib3J0X2VuZF9yZXF1
ZXN0cyhzdHJ1Y3QgZnVzZV9yaW5nICpyaW5nKTsKK3ZvaWQgZnVzZV91cmluZ19mbHVzaF9i
ZyhzdHJ1Y3QgZnVzZV9jb25uICpmYyk7CiBpbnQgZnVzZV91cmluZ19jbWQoc3RydWN0IGlv
X3VyaW5nX2NtZCAqY21kLCB1bnNpZ25lZCBpbnQgaXNzdWVfZmxhZ3MpOwogdm9pZCBmdXNl
X3VyaW5nX3F1ZXVlX2Z1c2VfcmVxKHN0cnVjdCBmdXNlX2lxdWV1ZSAqZmlxLCBzdHJ1Y3Qg
ZnVzZV9yZXEgKnJlcSk7CiBib29sIGZ1c2VfdXJpbmdfcXVldWVfYnFfcmVxKHN0cnVjdCBm
dXNlX3JlcSAqcmVxKTsKQEAgLTE1Myw3ICsxNTMsNyBAQCBzdGF0aWMgaW5saW5lIHZvaWQg
ZnVzZV91cmluZ19hYm9ydChzdHJ1Y3QgZnVzZV9jb25uICpmYykKIAkJcmV0dXJuOwogCiAJ
aWYgKGF0b21pY19yZWFkKCZyaW5nLT5xdWV1ZV9yZWZzKSA+IDApIHsKLQkJZnVzZV91cmlu
Z19hYm9ydF9lbmRfcmVxdWVzdHMocmluZyk7CisJCWZ1c2VfdXJpbmdfZmx1c2hfYmcoZmMp
OwogCQlmdXNlX3VyaW5nX3N0b3BfcXVldWVzKHJpbmcpOwogCX0KIH0K
--------------0ROvnKzHAWK4eyHVZV8261Vx
Content-Type: text/plain; charset=UTF-8; name="02-flush-uring-bg"
Content-Disposition: attachment; filename="02-flush-uring-bg"
Content-Transfer-Encoding: base64

ZnVzZTogRmx1c2ggdGhlIGlvLXVyaW5nIGJnIHF1ZXVlIGZyb20gZnVzZV91cmluZ19mbHVz
aF9iZwoKRnJvbTogQmVybmQgU2NodWJlcnQgPGJzY2h1YmVydEBkZG4uY29tPgoKVGhpcyBp
cyB1c2VmdWwgdG8gaGF2ZSBhIHVuaXF1ZSBBUEkgdG8gZmx1c2ggYmFja2dyb3VuZCByZXF1
ZXN0cy4KRm9yIGV4YW1wbGUgd2hlbiB0aGUgYmcgcXVldWUgZ2V0cyBmbHVzaGVkIGJlZm9y
ZQp0aGUgcmVtYWluaW5nIG9mIGZ1c2VfY29ubl9kZXN0cm95KCkuCgpTaWduZWQtb2ZmLWJ5
OiBCZXJuZCBTY2h1YmVydCA8YnNjaHViZXJ0QGRkbi5jb20+Ci0tLQogZnMvZnVzZS9kZXYu
YyAgICAgICAgIHwgICAgMiArKwogZnMvZnVzZS9kZXZfdXJpbmcuYyAgIHwgICAgMyArKysK
IGZzL2Z1c2UvZGV2X3VyaW5nX2kuaCB8ICAgMTAgKysrKysrKy0tLQogMyBmaWxlcyBjaGFu
Z2VkLCAxMiBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2Zz
L2Z1c2UvZGV2LmMgYi9mcy9mdXNlL2Rldi5jCmluZGV4IDUzODdlNDIzOWQ2YS4uM2Y1ZjE2
OGNjMjhhIDEwMDY0NAotLS0gYS9mcy9mdXNlL2Rldi5jCisrKyBiL2ZzL2Z1c2UvZGV2LmMK
QEAgLTQyNiw2ICs0MjYsOCBAQCBzdGF0aWMgdm9pZCBmbHVzaF9iZ19xdWV1ZShzdHJ1Y3Qg
ZnVzZV9jb25uICpmYykKIAkJZmMtPmFjdGl2ZV9iYWNrZ3JvdW5kKys7CiAJCWZ1c2Vfc2Vu
ZF9vbmUoZmlxLCByZXEpOwogCX0KKworCWZ1c2VfdXJpbmdfZmx1c2hfYmcoZmMpOwogfQog
CiAvKgpkaWZmIC0tZ2l0IGEvZnMvZnVzZS9kZXZfdXJpbmcuYyBiL2ZzL2Z1c2UvZGV2X3Vy
aW5nLmMKaW5kZXggZWNhNDU3ZDEwMDVlLi5hY2YxMWVhZGJmM2IgMTAwNjQ0Ci0tLSBhL2Zz
L2Z1c2UvZGV2X3VyaW5nLmMKKysrIGIvZnMvZnVzZS9kZXZfdXJpbmcuYwpAQCAtMTIzLDYg
KzEyMyw5IEBAIHZvaWQgZnVzZV91cmluZ19mbHVzaF9iZyhzdHJ1Y3QgZnVzZV9jb25uICpm
YykKIAlzdHJ1Y3QgZnVzZV9yaW5nX3F1ZXVlICpxdWV1ZTsKIAlzdHJ1Y3QgZnVzZV9yaW5n
ICpyaW5nID0gZmMtPnJpbmc7CiAKKwlpZiAoIXJpbmcpCisJCXJldHVybjsKKwogCWZvciAo
cWlkID0gMDsgcWlkIDwgcmluZy0+bnJfcXVldWVzOyBxaWQrKykgewogCQlxdWV1ZSA9IFJF
QURfT05DRShyaW5nLT5xdWV1ZXNbcWlkXSk7CiAJCWlmICghcXVldWUpCmRpZmYgLS1naXQg
YS9mcy9mdXNlL2Rldl91cmluZ19pLmggYi9mcy9mdXNlL2Rldl91cmluZ19pLmgKaW5kZXgg
NTVmNTI1MDhkZTNjLi5mY2EyMTg0ZThkOTQgMTAwNjQ0Ci0tLSBhL2ZzL2Z1c2UvZGV2X3Vy
aW5nX2kuaAorKysgYi9mcy9mdXNlL2Rldl91cmluZ19pLmgKQEAgLTE1MiwxMCArMTUyLDEw
IEBAIHN0YXRpYyBpbmxpbmUgdm9pZCBmdXNlX3VyaW5nX2Fib3J0KHN0cnVjdCBmdXNlX2Nv
bm4gKmZjKQogCWlmIChyaW5nID09IE5VTEwpCiAJCXJldHVybjsKIAotCWlmIChhdG9taWNf
cmVhZCgmcmluZy0+cXVldWVfcmVmcykgPiAwKSB7Ci0JCWZ1c2VfdXJpbmdfZmx1c2hfYmco
ZmMpOworCS8qIEFzc3VtZXMgYmcgcXVldWVzIHdlcmUgYWxyZWFkeSBmbHVzaGVkIGJlZm9y
ZSAqLworCisJaWYgKGF0b21pY19yZWFkKCZyaW5nLT5xdWV1ZV9yZWZzKSA+IDApCiAJCWZ1
c2VfdXJpbmdfc3RvcF9xdWV1ZXMocmluZyk7Ci0JfQogfQogCiBzdGF0aWMgaW5saW5lIHZv
aWQgZnVzZV91cmluZ193YWl0X3N0b3BwZWRfcXVldWVzKHN0cnVjdCBmdXNlX2Nvbm4gKmZj
KQpAQCAtMjA2LDYgKzIwNiwxMCBAQCBzdGF0aWMgaW5saW5lIGJvb2wgZnVzZV91cmluZ19y
ZXF1ZXN0X2V4cGlyZWQoc3RydWN0IGZ1c2VfY29ubiAqZmMpCiAJcmV0dXJuIGZhbHNlOwog
fQogCitzdGF0aWMgaW5saW5lIHZvaWQgZnVzZV91cmluZ19mbHVzaF9iZyhzdHJ1Y3QgZnVz
ZV9jb25uICpmYykKK3sKK30KKwogI2VuZGlmIC8qIENPTkZJR19GVVNFX0lPX1VSSU5HICov
CiAKICNlbmRpZiAvKiBfRlNfRlVTRV9ERVZfVVJJTkdfSV9IICovCg==

--------------0ROvnKzHAWK4eyHVZV8261Vx--


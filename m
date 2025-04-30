Return-Path: <linux-fsdevel+bounces-47736-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FC63AA50DC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Apr 2025 17:53:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C768C7B0C73
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Apr 2025 15:52:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB1FD261589;
	Wed, 30 Apr 2025 15:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LuFkVxEM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25DE6190676
	for <linux-fsdevel@vger.kernel.org>; Wed, 30 Apr 2025 15:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746028380; cv=none; b=gcgranUwxR5E07MD5K5OKD/VXqj2I81+5eSkhzASOtlS/FLc5HXW9GuA4EYzK4YJ1PDsa9gXODMAaTGneXEY97XRNaEyOW8eu6mURPhjjMOvxpnPUXFU7cnyvs0/oIrJfot0emxC6scGyJTdGv2Uog442KkDTSIIPYFqJunyWeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746028380; c=relaxed/simple;
	bh=5j8QT19Kt1oEn9K6D5P+gQa2cu3/F7aw3cyO6t6oFq0=;
	h=Content-Type:Message-ID:Date:MIME-Version:Subject:To:References:
	 From:In-Reply-To; b=I6wHnQb8gwk18gafzC79rekws6HtBYfgXXQKYO2PnLQh4GNqaZ0rWClXAuyc4e9Tci8bZpOBuj3QZEcOw9pXR21PMYxg9KEX8cmCzlipzJWVyuZTIWamj8810uGITfVeaJ6wPfKZxY56IZpkIxerIm1hrdYxai6JbRL2DDYPNac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LuFkVxEM; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746028379; x=1777564379;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to;
  bh=5j8QT19Kt1oEn9K6D5P+gQa2cu3/F7aw3cyO6t6oFq0=;
  b=LuFkVxEMdMWBSmiaJyWD53fw5oZAirHEo4N2BziCncVQ2F3rLf+LZYiq
   W3ma4Gkk83r2ZVPBHgDevAgJ2TvwuVtULWa5ocpo/6wNWIL3ZqYPADgvn
   cYYqX/pydzR5yEq404lQ7KWDVprNTLNDpIvui2jN5vvj7TmUph24DVdHa
   pD637V62GB5H4zLMQATbeK3UVMNDKL6PR9uYwnAjzunt/B2oVpREtkasY
   c4i+TLVRCKa7jAtohDcG+kCYYnA8DxHSGAVEVbQfXsOL63PrfN5FhZB3s
   rgvbTQqsfFdJ8hbZuIAF3o+2QXN3B5O5/w048cHsoDwRYQ8lpL1290a90
   A==;
X-CSE-ConnectionGUID: KRsWsRMsQxiagGJstam8yA==
X-CSE-MsgGUID: oS/y5pnrRWSzOcLpMrHLug==
X-IronPort-AV: E=McAfee;i="6700,10204,11419"; a="47831665"
X-IronPort-AV: E=Sophos;i="6.15,252,1739865600"; 
   d="scan'208";a="47831665"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2025 08:52:58 -0700
X-CSE-ConnectionGUID: +lMg2cUlQ/G9QwEcEqElIg==
X-CSE-MsgGUID: GZYE6mbdTRiOswyAZlUpNQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,252,1739865600"; 
   d="scan'208";a="157396776"
Received: from tfalcon-desk.amr.corp.intel.com (HELO [10.124.223.193]) ([10.124.223.193])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2025 08:52:56 -0700
Content-Type: multipart/mixed; boundary="------------rWuP6QE2DnQZwx3XJdjK6Re5"
Message-ID: <2040f153-c50e-49ea-acb6-72914c62fecb@intel.com>
Date: Wed, 30 Apr 2025 08:52:54 -0700
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION] orangefs: page writeback problem in 6.14 (bisected
 to 665575cf)
To: Mike Marshall <hubcap@omnibond.com>,
 linux-fsdevel <linux-fsdevel@vger.kernel.org>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 Martin Brandenburg <martin@omnibond.com>, devel@lists.orangefs.org
References: <CAOg9mSTLUOEobom72-MekLpdH-FuF0S+JkU4E13PK6KzNqT1pw@mail.gmail.com>
From: Dave Hansen <dave.hansen@intel.com>
Content-Language: en-US
Autocrypt: addr=dave.hansen@intel.com; keydata=
 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
In-Reply-To: <CAOg9mSTLUOEobom72-MekLpdH-FuF0S+JkU4E13PK6KzNqT1pw@mail.gmail.com>

This is a multi-part message in MIME format.
--------------rWuP6QE2DnQZwx3XJdjK6Re5
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/30/25 07:28, Mike Marshall wrote:
> I ran through xfstests at 6.14-rc7, and then not again until 6.15-rc4.
> 
> Starting with 6.14 xfstests generic/010 hits "WARN_ON(wr->pos >= len);" in
> orangefs_writepage_locked. I bisected:

Any chance you could share the entire warning splat?

I suspect what's happening here is that the orangefs code had an
existing bug when it faults during a write and the write partially
completes. My _guess_ is that the code effectively incremented wr->pos
too far which took it past i_size.

Before my patch, the writes fully complete. After my patch, the writes
partially complete.

Ext4 had a similar bug that caused this to get reverted the first time:

> 00a3d660cbac ("Revert "fs: do not prefault sys_write() user buffer pages"")

I would have felt pretty bad adding a hack to ext4 to work around this
bug. I don't feel as bad doing it to orangefs. Does that make me a
horrible person? :)

Anyway, does the (entirely untested) attached patch hack around the
issue for you? It just adds the old prefault behavior back to orangefs.

BTW, I suspect you could reproduce this splat _without_ 665575cf by
finding a way to undo the iov_iter_fault_in_readable() before
iov_iter_copy_from_user_atomic(). Maybe by having another thread sit
there and pound on the source memory buffer with MADV_DONTNEED or something.

BTW, the orangefs Documentation/ is looking a little crusty. Both of
these 404 on me:

https://lists.orangefs.org/pipermail/devel_lists.orangefs.org/
https://docs.orangefs.com/home/index.htm
--------------rWuP6QE2DnQZwx3XJdjK6Re5
Content-Type: text/x-patch; charset=UTF-8; name="orangefs-hack.patch"
Content-Disposition: attachment; filename="orangefs-hack.patch"
Content-Transfer-Encoding: base64

CgotLS0KCiBiL2ZzL29yYW5nZWZzL2ZpbGUuYyB8ICAgMTIgKysrKysrKysrKysrCiAxIGZp
bGUgY2hhbmdlZCwgMTIgaW5zZXJ0aW9ucygrKQoKZGlmZiAtcHVOIGZzL29yYW5nZWZzL2Zp
bGUuY35vcmFuZ2Vmcy1oYWNrIGZzL29yYW5nZWZzL2ZpbGUuYwotLS0gYS9mcy9vcmFuZ2Vm
cy9maWxlLmN+b3JhbmdlZnMtaGFjawkyMDI1LTA0LTMwIDA4OjMwOjM2Ljk5MjE0MjU3NiAt
MDcwMAorKysgYi9mcy9vcmFuZ2Vmcy9maWxlLmMJMjAyNS0wNC0zMCAwODozNDo0My4wMDIy
MzExNTggLTA3MDAKQEAgLTM2MCw2ICszNjAsNyBAQCBvdXQ6CiBzdGF0aWMgc3NpemVfdCBv
cmFuZ2Vmc19maWxlX3dyaXRlX2l0ZXIoc3RydWN0IGtpb2NiICppb2NiLAogICAgIHN0cnVj
dCBpb3ZfaXRlciAqaXRlcikKIHsKKwlzaXplX3QgYnl0ZXM7CiAJaW50IHJldDsKIAlvcmFu
Z2Vmc19zdGF0cy53cml0ZXMrKzsKIApAQCAtMzY5LDYgKzM3MCwxNyBAQCBzdGF0aWMgc3Np
emVfdCBvcmFuZ2Vmc19maWxlX3dyaXRlX2l0ZXIoCiAJCQlyZXR1cm4gcmV0OwogCX0KIAor
CS8qCisJICogVGhpcyBpcyBhIGhhY2suIFRoZXJlJ3MgKHByb2JhYmx5KSBhbiBvcmFuZ2Vm
cyBidWcgb3V0CisJICogdGhlcmUgdGhhdCBkb2VzIG5vdCBwcm9wZXJseSBoYW5kbGUgZmF1
bHRzIHRoYXQgaGFwcGVuIGluCisJICogdGhlIG1pZGRsZSBvZiBhIHdyaXRlLiBBdm9pZCB0
aGUgYnVnIGJ5IHByZWZhdWx0aW5nLiBJdAorCSAqIGlzIHBvc3NpYmxlIGJ1dCB1bmxpa2Vs
eSB0aGF0IHRoaXMgZmF1bHQgd2lsbCBiZSB1bmRvbmUKKwkgKiBieSByZWNsYWltIGJ5IHRo
ZSB0aW1lIHRoZSBidWdneSBjb2RlIGlzIHJ1bi4KKwkgKi8KKwlieXRlcyA9IGlvdl9pdGVy
X2NvdW50KGl0ZXIpOworCWlmIChmYXVsdF9pbl9pb3ZfaXRlcl9yZWFkYWJsZShpdGVyLCBi
eXRlcykgPT0gYnl0ZXMpCisJCXJldHVybiAtRUZBVUxUOworCiAJcmV0ID0gZ2VuZXJpY19m
aWxlX3dyaXRlX2l0ZXIoaW9jYiwgaXRlcik7CiAJcmV0dXJuIHJldDsKIH0KXwo=

--------------rWuP6QE2DnQZwx3XJdjK6Re5--


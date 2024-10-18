Return-Path: <linux-fsdevel+bounces-32336-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 727F89A3C0D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Oct 2024 12:50:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2CD9F28175E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Oct 2024 10:50:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D44A2038C8;
	Fri, 18 Oct 2024 10:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b="i/xJbZrg";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TS8cyIt8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1142F2036F9;
	Fri, 18 Oct 2024 10:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729248564; cv=none; b=aK2g3NBoHVES/XwZh4cN05WjGPrLmQJblbVA9nlXtpS+jwZ74uXmVmbIaJ7OnIZGYq17UDY2a2aXpRDGpZL7oVok+HlgLxYgFfr9y7RHaxWFJsBzxq01o6uG87FNyL+R3YjHzMQEvIPFtm2Xfd600E8P88+Tch9jo4Om3Weoc0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729248564; c=relaxed/simple;
	bh=cERpOJNcFUtahnaQux82n4tPWU1j9Z1ogqBHffq0xVs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g1JOrWhacBn9arpLhI/Cri3cx5GET29dBkyGm+tCybv9qJyDPn9SETlTIvXi2DFxP/ECBNLt3IoetR3poi4n+KA3tSN4vDVhkRTJz36yIkYTIrp3lHrT0Vnz/Yx5j1lb8fWs1in983RWOU/fSVMDYr5A8JWWDFyp+INR9Escfws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name; spf=pass smtp.mailfrom=shutemov.name; dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b=i/xJbZrg; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TS8cyIt8; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shutemov.name
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 1D8BB1380499;
	Fri, 18 Oct 2024 06:49:21 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Fri, 18 Oct 2024 06:49:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1729248561; x=
	1729334961; bh=mvvVjoh3e6ihasKm0bBvrghicZuE833642Mybcjr34U=; b=i
	/xJbZrgcdFQZSmjOWvK/cUQ+9Bhug/+Jr0N7UXHpOQSUZg191jpCnxxa+VgDRtOi
	ippa4VUGV4jIYKRcMrhUnauix2a6TX4jBdEXgfFK7pNRjuKgIt5U9POgYGiAbwU1
	b6z4V982jZZZIKzbmbOPz5SskZTZQfWl/3SCEIm7xiwiv8HhbThejeQiNOHXaRlc
	S+xZtwFCPisqUf7YNqwO3ODL0WmnHeE24KsjPpqITI4kMEaUi5GAUd/SZkYJXwdu
	/LgULR8RP5ECvGyubNfP7HitfaniaCgDg5wEkON8XweHw0nnJHKT7AyKYHVYCNZF
	z94Bsed1AgXl7JomIflLA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1729248561; x=1729334961; bh=mvvVjoh3e6ihasKm0bBvrghicZuE
	833642Mybcjr34U=; b=TS8cyIt8RghdTeQHg9i1O2IWahrzy7CN5Xyj6eVTFOn8
	ZXWcdjQR3+YQQvwLxnakVlTXbxY951v8YAfGHnGFggZECp3m5oOS101Si1RUwsrU
	J88O8MDBPz9Da7HIlzLb2OGNlhDc+kNHqtW/bbJ+GRA5ush94ZBu3ZKyTFetRPPW
	/rEDWjFpFG13xaNf1NfFK64WauuqHo0o2XBJnNA6HQAS+PvaTlq100by+SnQciaA
	ajrztvBkApxEVKqbGDVlEws4sWTzLxF/lqHr/a10xjU516RP2WLpO1c4zII1hzKx
	gedYKa8x0jKYCDLHATkSIk++kQT7uMRR84Hy/v8UiA==
X-ME-Sender: <xms:LT0SZx5AYByC2-Kwzd1igZjoPH6zU8bTJdNEGXzdHEq0XdevF0fqMg>
    <xme:LT0SZ-5cNPb6udtg5tyByiLsZ0sN_IfGJYy1IKTczOJIaqODYWBCr9cDHkqXbk9mn
    em50ui1BWPaMUsj4sk>
X-ME-Received: <xmr:LT0SZ4e9keYCZoxZXmC4G4WuzHt3xwct9GXr7E4X_j4E0v3QALduIyc0zkCqN6s6d7Oqaw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdehfedgfedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtsfdttddtvden
    ucfhrhhomhepfdfmihhrihhllhcutedrucfuhhhuthgvmhhovhdfuceokhhirhhilhhlse
    hshhhuthgvmhhovhdrnhgrmhgvqeenucggtffrrghtthgvrhhnpeffvdevueetudfhhfff
    veelhfetfeevveekleevjeduudevvdduvdelteduvefhkeenucevlhhushhtvghrufhiii
    gvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehkihhrihhllhesshhhuhhtvghmohhv
    rdhnrghmvgdpnhgspghrtghpthhtohepudelpdhmohguvgepshhmthhpohhuthdprhgtph
    htthhopehrohgsvghrthhordhsrghsshhusehhuhgrfigvihgtlhhouhgurdgtohhmpdhr
    tghpthhtohepphgruhhlsehprghulhdqmhhoohhrvgdrtghomhdprhgtphhtthhopegvsg
    hpqhifvghrthihgeejvdduvdefsehgmhgrihhlrdgtohhmpdhrtghpthhtohepkhhirhhi
    lhhlrdhshhhuthgvmhhovheslhhinhhugidrihhnthgvlhdrtghomhdprhgtphhtthhope
    iiohhhrghrsehlihhnuhigrdhisghmrdgtohhmpdhrtghpthhtohepughmihhtrhihrdhk
    rghsrghtkhhinhesghhmrghilhdrtghomhdprhgtphhtthhopegvrhhitgdrshhnohifsg
    gvrhhgsehorhgrtghlvgdrtghomhdprhgtphhtthhopehjmhhorhhrihhssehnrghmvghi
    rdhorhhgpdhrtghpthhtohepshgvrhhgvgeshhgrlhhlhihnrdgtohhm
X-ME-Proxy: <xmx:LT0SZ6JorCvf9kFFrHrvBx1UJOtOMruMaNBR2Pbu7IE-_H4OVpqkEA>
    <xmx:LT0SZ1LdBazL3EHmJx-AXaqv9AO2jRnX7pNQPWvt_eXemrfYHVb0gQ>
    <xmx:LT0SZzyE1ScJT0Pj8Il-L0aagNuQOpr1bOPeGLTMkW_qkcpjTOc3Pw>
    <xmx:LT0SZxLHpCxlCPbMN5FxvGWgWf8rsmuxJFg7K1f9L1TFJpj-WzTlWQ>
    <xmx:MT0SZ98yDcnInQ9q8Z58C75Rk4vCMWaEfSHTbB1xfkXGauBTCt9qo-kO>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 18 Oct 2024 06:49:11 -0400 (EDT)
Date: Fri, 18 Oct 2024 13:49:06 +0300
From: "Kirill A. Shutemov" <kirill@shutemov.name>
To: Roberto Sassu <roberto.sassu@huaweicloud.com>
Cc: Paul Moore <paul@paul-moore.com>, ebpqwerty472123@gmail.com, 
	kirill.shutemov@linux.intel.com, zohar@linux.ibm.com, dmitry.kasatkin@gmail.com, 
	eric.snowberg@oracle.com, jmorris@namei.org, serge@hallyn.com, 
	linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org, Roberto Sassu <roberto.sassu@huawei.com>, 
	linux-mm@kvack.org, akpm@linux-foundation.org, vbabka@suse.cz, 
	lorenzo.stoakes@oracle.com, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 1/3] ima: Remove inode lock
Message-ID: <ggvucjixgiuelt6vjz6oawgyobmzrhifaozqqvupwfso65ia7c@bauvfqtvq6lv>
References: <20241008165732.2603647-1-roberto.sassu@huaweicloud.com>
 <CAHC9VhSyWNKqustrTjA1uUaZa_jA-KjtzpKdJ4ikSUKoi7iV0Q@mail.gmail.com>
 <CAHC9VhQR2JbB7ni2yX_U8TWE0PcQQkm_pBCuG3nYN7qO15nNjg@mail.gmail.com>
 <7358f12d852964d9209492e337d33b8880234b74.camel@huaweicloud.com>
 <593282dbc9f48673c8f3b8e0f28e100f34141115.camel@huaweicloud.com>
 <15bb94a306d3432de55c0a12f29e7ed2b5fa3ba1.camel@huaweicloud.com>
 <c1e47882720fe45aa9d04d663f5a6fd39a046bcb.camel@huaweicloud.com>
 <b498e3b004bedc460991e167c154cc88d568f587.camel@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b498e3b004bedc460991e167c154cc88d568f587.camel@huaweicloud.com>

On Fri, Oct 18, 2024 at 11:24:06AM +0200, Roberto Sassu wrote:
> Probably it is hard, @Kirill would there be any way to safely move
> security_mmap_file() out of the mmap_lock lock?

What about something like this (untested):

diff --git a/mm/mmap.c b/mm/mmap.c
index dd4b35a25aeb..03473e77d356 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -1646,6 +1646,26 @@ SYSCALL_DEFINE5(remap_file_pages, unsigned long, start, unsigned long, size,
 	if (pgoff + (size >> PAGE_SHIFT) < pgoff)
 		return ret;
 
+	if (mmap_read_lock_killable(mm))
+		return -EINTR;
+
+	vma = vma_lookup(mm, start);
+
+	if (!vma || !(vma->vm_flags & VM_SHARED)) {
+		mmap_read_unlock(mm);
+		return -EINVAL;
+	}
+
+	file = get_file(vma->vm_file);
+
+	mmap_read_unlock(mm);
+
+	ret = security_mmap_file(vma->vm_file, prot, flags);
+	if (ret) {
+		fput(file);
+		return ret;
+	}
+
 	if (mmap_write_lock_killable(mm))
 		return -EINTR;
 
@@ -1654,6 +1674,9 @@ SYSCALL_DEFINE5(remap_file_pages, unsigned long, start, unsigned long, size,
 	if (!vma || !(vma->vm_flags & VM_SHARED))
 		goto out;
 
+	if (vma->vm_file != file)
+		goto out;
+
 	if (start + size > vma->vm_end) {
 		VMA_ITERATOR(vmi, mm, vma->vm_end);
 		struct vm_area_struct *next, *prev = vma;
@@ -1688,16 +1711,11 @@ SYSCALL_DEFINE5(remap_file_pages, unsigned long, start, unsigned long, size,
 	if (vma->vm_flags & VM_LOCKED)
 		flags |= MAP_LOCKED;
 
-	file = get_file(vma->vm_file);
-	ret = security_mmap_file(vma->vm_file, prot, flags);
-	if (ret)
-		goto out_fput;
 	ret = do_mmap(vma->vm_file, start, size,
 			prot, flags, 0, pgoff, &populate, NULL);
-out_fput:
-	fput(file);
 out:
 	mmap_write_unlock(mm);
+	fput(file);
 	if (populate)
 		mm_populate(ret, populate);
 	if (!IS_ERR_VALUE(ret))
-- 
  Kiryl Shutsemau / Kirill A. Shutemov


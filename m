Return-Path: <linux-fsdevel+bounces-62855-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 16D6CBA2917
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Sep 2025 08:48:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 63C101C25BEC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Sep 2025 06:48:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DECAD27E040;
	Fri, 26 Sep 2025 06:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="SLCLAiPj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC5808F6F;
	Fri, 26 Sep 2025 06:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758869287; cv=none; b=gLb3dbRosgAgbKrx0akqPBrfwo2/WUJgfYEkf+ehGPNBoYt+HC2n6Ul29vVyTp2hF57lyzq3DD4nUPEx7lQUVUhh9qxfBVS9YhBCa0PDH3JJME+jEENpxdxe2uUKakWcK6sjN26e0aaK/04d006TDtYjTQr4UN/5Hcig9m4q0Qw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758869287; c=relaxed/simple;
	bh=+yA/JJLiAgN8GgnTni7nhwSz3g3A80NM5yHtKOcsFi4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fTxFIWTZB3VjOD/hJ7S+DheTs2dHnvAH2JFo2o40sJzZHhbJuYoQ3wNw7uZeoBORLG/btUef3nYfmpK9F0be4p0aOKZBV184rCY7aQxOzvqVyZJn1rrPHPTMGi7883q/zmMjmNrpsjEYs08gzSDodvv7SiMXxvkclU1t4E6hM4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=SLCLAiPj; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=K0XisOwhWijwoOa3QwHt0TYzTp5652DJvsJj1cLXIWI=; b=SLCLAiPj29jDcqxXPuaTmqA86E
	5YmcTYDmxJWZjZSjr44Pk1Phg74DUVX3KVmfbihnjgyPkkhrddR2cb4g7bRYVYeHnbwLHoEHu4TGA
	5rCvc/wxjMU5yrJeZHuGDwzKpI3ewlEIs0WF3FBP6kEYIP6FkKQgEOD3L7boKxClHGdvElFvN9X/u
	OJXrFKYc0vg96vpJTd9SQak2y95eLkvlbZHuNJ2IJ0Z9fsQs/qq6hGyw6/mmjT0971eP5xwMq2rkW
	IMy7tQl4gxCkaOaXfOHCroj5okY1+N48ltFUAD2yPc9t24nY/Mp6zRM0vgsvvr5QLF+53Hac1WiPg
	kSjV3zLA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v22FO-00000000tSF-0E7U;
	Fri, 26 Sep 2025 06:48:02 +0000
Date: Fri, 26 Sep 2025 07:48:01 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Christian Brauner <brauner@kernel.org>
Cc: "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>,
	linux-fsdevel@vger.kernel.org, lkft-triage@lists.linaro.org,
	Linux Regressions <regressions@lists.linux.dev>,
	Jan Kara <jack@suse.cz>, Arnd Bergmann <arnd@arndb.de>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Anders Roxell <anders.roxell@linaro.org>,
	Ben Copeland <benjamin.copeland@linaro.org>,
	Naresh Kamboju <naresh.kamboju@linaro.org>
Subject: Re: next-20250924: Internal error: Oops: mnt_ns_release
 (fs/namespace.c:148) __arm64_sys_listmount (fs/namespace.c:5936)
Message-ID: <20250926064801.GE39973@ZenIV>
References: <CA+G9fYueO8kP8mXVNmbHkyrFPKpt-onPfeyNXLuLGGjiO1WFfQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+G9fYueO8kP8mXVNmbHkyrFPKpt-onPfeyNXLuLGGjiO1WFfQ@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Fri, Sep 26, 2025 at 12:00:08AM +0530, Naresh Kamboju wrote:

[snip]

With 59bfb6681680 "listmount: don't call path_put() under namespace semaphore"
we get this:

static void __free_klistmount_free(const struct klistmount *kls)
{
	path_put(&kls->root);
	kvfree(kls->kmnt_ids);
	mnt_ns_release(kls->ns);
}

...

SYSCALL_DEFINE4(listmount, const struct mnt_id_req __user *, req,
		u64 __user *, mnt_ids, size_t, nr_mnt_ids, unsigned int, flags)
{
	struct klistmount kls __free(klistmount_free) = {};
	const size_t maxcount = 1000000;
	struct mnt_id_req kreq;
	ssize_t ret;
		   
	if (flags & ~LISTMOUNT_REVERSE)
		return -EINVAL;

which will oops if it takes that failure exit - if you are initializing
something with any kind of cleanup on it, you'd better make sure
the cleanup will survive being called for the initial value...

Christian, that's your branch and I don't want to play with rebasing
it - had it been mine, the fix would be folded into commit in question,
with the rest of the branch cherry-picked on top of fixed commit,
but everyone got their own preferences in how to do such stuff.

Minimal fix would be to make mnt_ns_release(NULL) a no-op.

BTW, I suspect that one of the sources of confusion had been the fact that
__free(mnt_ns_release) *does* treat NULL as no-op; in statmount(2) you
are using that and get away with NULL as initializer.  In listmount(2)),
OTOH, you are dealing with the function call - same identifier, different
behaviour...


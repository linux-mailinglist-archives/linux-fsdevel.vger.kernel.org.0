Return-Path: <linux-fsdevel+bounces-69936-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 90E34C8C633
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Nov 2025 00:51:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5BB854E2F8F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Nov 2025 23:51:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9039F2FD7BE;
	Wed, 26 Nov 2025 23:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="n1nD1sho"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30EF129BD85;
	Wed, 26 Nov 2025 23:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764201097; cv=none; b=fFWVK+8oG1BW9LZHhFBt9YizgeiJWS7QvOA5IibCVXZiQry28g7HhhoG20aXULqiC/OiEgvIyC8LIzBtM0EyG6oUmawGeHzo+LMYUNZEt0QIvEEGFwAotkg8BgkxmGyTMDcqfoy8AufRHNAAKh73LnyiNh+8QWLGglzoXOmmZSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764201097; c=relaxed/simple;
	bh=ZJ0zJGR5EPjB0PMK4QnRQ1a5rXXPjLj1UEoGCWufwa8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d1tLotsijUwQAnKYTDqlHsn+bsrMchOBJ0s2f7rKV1jP+w523HyrYlyqhv9tK9d+gTEspEWLJbxG0mlLRUMjVhfDe9mx4+wrW36IT36Qk7YAu6Y+e30sU76Y/VTlslaCLm3SCiSc2CwFHNN1ttVyJMuM/pijf0wFApnivYBCqu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=n1nD1sho; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=wkC4EC2zssMx28s9No60sCNue+peZIp/avGbOKBlk10=; b=n1nD1shoa5nvuzhDtF44Purkpc
	5bjbZrX5nCdzonSHSYJqpHMlADRQU+VwdfC5fXQJk4ojTO3bemQGJkJw4CtbUfR3/1ghTrFjzhzLX
	xyxRHWbxXcWc/dcbMkci+w69UUeqkccHLZw+oxDejQ0dfn9XN7hKH3lGMnDlRq24PyViwiT8WzOce
	q2moRs0tG+D5MF9A0E0YYwDfqx8PGiMrkbyZL8OzaYBxQXeFNUwufzjmsRtaWbHmJMdD6AyCQLs21
	KjxSQ2LIwidiH62xuLMZf1PIo8EYJ2NeqssUZH5KpjxYnGZXyeoC6X9sAxibDbEo/JmThxsV/WJUM
	r/WQtNxg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99 #2 (Red Hat Linux))
	id 1vOPII-00000006Ijc-3QlD;
	Wed, 26 Nov 2025 23:51:30 +0000
Date: Wed, 26 Nov 2025 23:51:30 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: david laight <david.laight@runbox.com>
Cc: "Russell King (Oracle)" <linux@armlinux.org.uk>,
	Xie Yuanbin <xieyuanbin1@huawei.com>, brauner@kernel.org,
	jack@suse.cz, will@kernel.org, nico@fluxnic.net,
	akpm@linux-foundation.org, hch@lst.de, jack@suse.com,
	wozizhi@huaweicloud.com, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mm@kvack.org, lilinjie8@huawei.com, liaohua4@huawei.com,
	wangkefeng.wang@huawei.com, pangliyuan1@huawei.com
Subject: Re: [RFC PATCH] vfs: Fix might sleep in load_unaligned_zeropad()
 with rcu read lock held
Message-ID: <20251126235130.GG3538@ZenIV>
References: <20251126090505.3057219-1-wozizhi@huaweicloud.com>
 <20251126101952.174467-1-xieyuanbin1@huawei.com>
 <20251126181031.GA3538@ZenIV>
 <20251126184820.GB3538@ZenIV>
 <aSdPYYqPD5V7Yeh6@shell.armlinux.org.uk>
 <20251126192640.GD3538@ZenIV>
 <aSdaWjgqP4IVivlN@shell.armlinux.org.uk>
 <20251126200221.GE3538@ZenIV>
 <20251126222505.1638a66d@pumpkin>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251126222505.1638a66d@pumpkin>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Wed, Nov 26, 2025 at 10:25:05PM +0000, david laight wrote:

> Can you fix it with a flag on the exception table entry that means
> 'don't try to fault in a page'?
> 
> I think the logic would be the same as 'disabling pagefaults', just
> checking a different flag.
> After all the fault itself happens in both cases.

The problem is getting to the point where you search the exception table
without blocking.

x86 #PF had been done that way from well before the point when
load_unaligned_zeropad() had been introduced, so everything worked
there from the very beginning.

arm and arm64, OTOH, were different - there had been logics for
"if trylock fails, check if we are in kernel space and have no
matching exception table entry; bugger off if so, otherwise we
are safe to grab mmap_sem - it's something like get_user() and
we *want* mmap_sem there", but it did exactly the wrong thing for
this case.

The only thing that prevented serious breakage from the very beginning
was that these faults are very rare - and hard to arrange without
KFENCE.  So it didn't blow up.  In 2017 arm64 side of problem had
been spotted and (hopefully) fixed.  arm counterpart stayed unnoticed
(perhaps for the lack of good reproducer) until now.

Most of the faults are from userland code, obviously, so we don't
want to search through the exception table on the common path.
So hanging that on a flag in exception table entry is not a good
idea - we need a cheaper predicate checked first.

x86 starts with separating the fault on kernel address from that on
userland; we are not going anywhere near mmap_sem (and VMAs in general)
in the former case and that's where load_unaligned_zeropad() faults
end up.  arm64 fix consisted of using do_translation_fault() instead
of do_page_fault(), with the former falling back to the latter for
userland addresses and using do_bad_area() for kernel ones.
Assuming that the way it's hooked up covers everything, we should
be fine there.

One potential problem _might_ be with the next PTE present, but
write-only.  Note that it has to cope with symlink bodies as well
and those might come from page cache rather than kmem_cache_alloc().
I'm nowhere near being uptodate on arm64 virtual memory setup, though,
so take that with a cartload of salt...


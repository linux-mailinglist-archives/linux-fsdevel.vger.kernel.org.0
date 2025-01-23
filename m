Return-Path: <linux-fsdevel+bounces-39980-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BCE4A1A8C8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Jan 2025 18:20:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C3DD53B0900
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Jan 2025 17:14:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 903C4149DFA;
	Thu, 23 Jan 2025 17:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="uTi3bxKR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB8AF14A4D6;
	Thu, 23 Jan 2025 17:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737652487; cv=none; b=dlyfVF3cmFi89dBTgVzINuMlHjD3pURY5iskVHKbSqCQ0mhiK9fkMeMdeW2xD/ExUi/RpnM9ziWMw83AS6VZVyt31/6doUmsJ2sDyYBgGVqVsNDZWZkUxsj01qnd7Vtq5rcpfqoviAm+j89Oaa1S/bEu/mRWD89yC668ewcOuqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737652487; c=relaxed/simple;
	bh=StM0etGCdtEiUi78en3TndbUO9Prhv7o09yaFBQhUck=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E9f2819EbyDx6VPbeVeT8geapCnYtU5CNyqrsuRnmXNwkxDbyTEJrLktb6/JqLR1F3TGG/M2LjW8hfnipNmKM5AvzkD1BGmPBKh0nspdPvY1Q3eavOs6eH1Pnl9xMHNp5GK1mi763hLsnNaPV0H+belmL08w6DN04yYli4++mjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=uTi3bxKR; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=4yAoXigjcz2L5cxtqIhHEfwMwo3R7mjfNXoSQXTLRAw=; b=uTi3bxKRULONszWQeWtiZxnMAL
	qLjg2fkjP8Yi9DwJs2HUNR2KqVIgSREi9hl2XrkTVsRNadHVMipgBCzUFVZfBSwcD5UX9WlzeRttK
	G7eDWbQPhjJK+62269VuGtzerAPJ4Ts+0GrOVl1Yix1g7hHpUdXRTmM/uTcFhklY3DMxx0LgHQLKk
	P3U/YEHzvu9sXjDHNbH+f2HMBQ5xoXaDLtvJ1PY3nidjQD+L22FR8HTm4mpeOatQ10+q0pJwSibWF
	Y1PK1f5k1XjSy+1bFYcUvw7JcRiR7zLfRQi9+GgTOMgTRXE66vkwBGJtQn4QUZESKiwNhmqMA+Jc7
	lhOSn4uw==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tb0mu-00000009XAj-0bAJ;
	Thu, 23 Jan 2025 17:14:40 +0000
Date: Thu, 23 Jan 2025 17:14:39 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Barry Song <21cnbao@gmail.com>
Cc: lokeshgidra@google.com, Liam.Howlett@oracle.com, aarcange@redhat.com,
	akpm@linux-foundation.org, axelrasmussen@google.com,
	bgeffon@google.com, david@redhat.com, jannh@google.com,
	kaleshsingh@google.com, kernel-team@android.com,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, ngeoffray@google.com, peterx@redhat.com,
	rppt@kernel.org, ryan.roberts@arm.com, selinux@vger.kernel.org,
	surenb@google.com, timmurray@google.com
Subject: Re: [PATCH v7 4/4] userfaultfd: use per-vma locks in userfaultfd
 operations
Message-ID: <Z5J4__VslSFk3A78@casper.infradead.org>
References: <20240215182756.3448972-5-lokeshgidra@google.com>
 <20250123041427.1987-1-21cnbao@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250123041427.1987-1-21cnbao@gmail.com>

On Thu, Jan 23, 2025 at 05:14:27PM +1300, Barry Song wrote:
> However, we’ve noticed that userfaultfd still remains one of the largest users
> of mmap_lock for write operations, with the other—binder—having been recently
> addressed by Carlos Llamas's "binder: faster page installations" series:
> 
> https://lore.kernel.org/lkml/20241203215452.2820071-1-cmllamas@google.com/
> 
> The HeapTaskDaemon(Java GC) might frequently perform userfaultfd_register()
> and userfaultfd_unregister() operations, both of which require the mmap_lock
> in write mode to either split or merge VMAs. Since HeapTaskDaemon is a

I don't think that's an innate necessity.  It does require quite some
work in order to fix it though.  Since it was so much work, nobody's
been motivated to fix it ... but now you are!  Congratulations ;-)

The reason we need the mmap_lock in write mode is that the VMA tree is
currently protected by that mmap_lock.  It shouldn't be.  Logically, it
should be protected by the ma_lock spinlock.  But today we use external
locking (ie the mmap_lock) because fixing that was a huge amount of work
that we didn't have time to do.

This MAP_VOLATILE idea is never going to fly.



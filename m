Return-Path: <linux-fsdevel+bounces-70207-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AE87CC93AD3
	for <lists+linux-fsdevel@lfdr.de>; Sat, 29 Nov 2025 10:08:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B427B3A77A8
	for <lists+linux-fsdevel@lfdr.de>; Sat, 29 Nov 2025 09:08:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A2E4273D7B;
	Sat, 29 Nov 2025 09:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="ElfgA3pc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECFA315278E;
	Sat, 29 Nov 2025 09:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764407291; cv=none; b=tnSc3Fy64ubdAr/g3lx5XQ59dgvRxjpz5/OfJ3pnxkFTtStd2x3EUy6l54nap0AGzv3PInYNYuG69+F1gLXa5C8fMisZjzqJY1CvJPdEri6iWBeKq55IlPpD4VZKPpLYxoXjaAxVW6RN2kHoKvCHh1EMrAULho0udg6sMRgv9yM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764407291; c=relaxed/simple;
	bh=bPOF1LOXnXKWVi02KsdeYtWkg+IClfPylDc80KOmHIc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YQMRW7O5UOqaJlVtEAadV+VD1KEl1GQmbLd68eU2Rz2ZMjT2s+q6o7ISvP2qy71NbfDjmPV3Rv4HZapHp8hYi+jA7B4zo06c7J5bAmSVl3ALGHa5VSwvI66OisCM4gSm0Cx8ujwQprIFY0ERC3rGosgyEKYihUahMjwn4XrYVLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=ElfgA3pc; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=puYdCjauAnyp13Z3AbnzcEE9KrU8OtebpK4HHLvOqPI=; b=ElfgA3pcqI4u2V5Qw2qVd/nzGU
	T/EfzhaKAZVqIsLqTKtnSuVLOEUx4j3TU/2CnNbw+rDxqyHoU6/M8j53gZwej0rhySWnbWuxUWIgx
	L5h6kNOL4g4WAPTCm7IFDpDy4FndmhAG6sENH+0qdZm7Jc6ZFC6fZJ+Kru2E0eyv122nxlvxPKPSt
	Crzm0cmJZC9hxgrmlCJgqIs0s/SKhgGb3Em804A/sYtSghutELdkVYwU/7cLq/P/qIL45h56lVOcu
	HAQrDYvlaOjnfaP3cGbNoAmr/70ouZzTg4CMBy0thr/rfv2PJCOyQrljlKsXX4MnKHtqRQGFXmqEp
	9LpKA/1Q==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99 #2 (Red Hat Linux))
	id 1vPGw9-00000007WR1-1Vm6;
	Sat, 29 Nov 2025 09:08:13 +0000
Date: Sat, 29 Nov 2025 09:08:13 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Xie Yuanbin <xieyuanbin1@huawei.com>
Cc: torvalds@linux-foundation.org, will@kernel.org, linux@armlinux.org.uk,
	bigeasy@linutronix.de, rmk+kernel@armlinux.org.uk,
	akpm@linux-foundation.org, brauner@kernel.org,
	catalin.marinas@arm.com, hch@lst.de, jack@suse.com,
	linux-arm-kernel@lists.infradead.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	pangliyuan1@huawei.com, wangkefeng.wang@huawei.com,
	wozizhi@huaweicloud.com, yangerkun@huawei.com, lilinjie8@huawei.com,
	liaohua4@huawei.com
Subject: Re: [Bug report] hash_name() may cross page boundary and trigger
Message-ID: <20251129090813.GK3538@ZenIV>
References: <CAHk-=wjA20ear0hDOvUS7g5-A=YAUifphcf-iFJ1pach0=3ubw@mail.gmail.com>
 <20251129040817.65356-1-xieyuanbin1@huawei.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251129040817.65356-1-xieyuanbin1@huawei.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Sat, Nov 29, 2025 at 12:08:17PM +0800, Xie Yuanbin wrote:

> I think the `user_mode(regs)` check is necessary because the label
> no_context actually jumps to __do_kernel_fault(), whereas page fault
> from user mode should jump to `__do_user_fault()`.
> 
> Alternatively, we would need to change `goto no_context` to
> `goto bad_area`. Or perhaps I misunderstood something, please point it out.

FWIW, goto bad_area has an obvious problem: uses of 'fault' value, which
contains garbage.

The cause of problem is the heuristics in get_mmap_lock_carefully():
	if (regs && !user_mode(regs)) {
		unsigned long ip = exception_ip(regs);
		if (!search_exception_tables(ip))
			return false;
	}
trylock has failed and we are trying to decide whether it's safe to block.
The assumption (inherited from old logics in assorted page fault handlers)
is "by that point we know that fault in kernel mode is either an oops
or #PF on uaccess; in the latter case we should be OK with locking mm,
in the former we should just get to oopsing without risking deadlocks".

load_unaligned_zeropad() is where that assumption breaks - there is
an exception handler and it's not an uaccess attempt; the address is
not going to match any VMA and we really don't want to do anything
blocking.

Note that VMA lookup will return NULL there anyway - there won't be a VMA
for that address.  What we get is exactly the same thing we'd get from
do_bad_area(), whether we get a kernel or userland insn faulting.

The minimal fix would be something like
	if (unlikely(addr >= TASK_SIZE) && !(flags & FAULT_FLAG_USER))
		goto no_context;

right before
	if (!(flags & FAULT_FLAG_USER))
		goto lock_mmap;

in do_page_fault().  Alternatively,
	if (unlikely(addr >= TASK_SIZE)) {
		do_bad_area(addr, fsr, regs);
		return 0;
	}
or
	if (unlikely(addr >= TASK_SIZE)) {
		fault = 0;
		code = SEGV_MAPERR;
		goto bad_area;
	}
at the same place.  Incidentally, making do_bad_area() return 0 would
seem to make all callers happier...


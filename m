Return-Path: <linux-fsdevel+bounces-12176-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3326A85C4DF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Feb 2024 20:32:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AC460B230C4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Feb 2024 19:32:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1563914A0A3;
	Tue, 20 Feb 2024 19:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="M5fNXZ02"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43CA676C89;
	Tue, 20 Feb 2024 19:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708457549; cv=none; b=YvwX0qWxpqFL+lM4cXroPQcbA4oyhZxbJbk5ooQyDl11HU20rPukBQV99nLG1jjnM5s6PaIwcrROCTFMhnwT/HDVdDoofH83zzsUCo+3wBb0BWxX/HtzfpYrj0FC5SwBjqlamhHqYApjGg+VPZlsLk/NML/dYF0v9SWfGMVweJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708457549; c=relaxed/simple;
	bh=IdvaFvhm79uZiC83q8Okzw3yGRUceDjDYvrDd2qCOyA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pvTTqp0gcGbxtXom+MgZOUEkep9YxCuGWSiDxJKVMgcyt5eHiwyAnRrZJh2Hpo5k8iKjJUHrlmkoUEsQsabXX8SPgWHKENpkTRl+t6W73QJQx3dkXFoRyq1M5uRcyFivZlBrzzfPj3GC6tFweEcovIpKgP0Kexem7hvYmzHQqww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=M5fNXZ02; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=9EeLMmuj2gBRx3tMUzCZ8WVsu/6ToXUdH4WzDVXZTQ4=; b=M5fNXZ02w/eoM/RRtl9bP2IekM
	rKkZ6vbrC9qUlnqWk3B3OdAF0FLLpopzPx/6AJUHm0aEe8bO7NGr9sx1IYFYusx74M9gXy+ldsLLc
	cry8b4XY66mE+sk4cFcukfSdX80v0FPktd/Gxi/vZopLYq+TfXJ1eIF+R15SOTAU29so/3AYZRGPH
	x5HokIHk0Gi8uofz+qWSO0NU8zYwRH/JiAlvGvt2l/QCC1s4SBSyyYfBp3dYt6zuOu2Egn7GZUzv2
	HPzlq618z9fG1e8kFv21sA1nAreJqS53N+I8kJgGX1gK6eMFfV842aA7mcN32JgHdrIVaw9dkjw+Y
	2+FjgfEg==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rcVqq-0000000GOLF-3443;
	Tue, 20 Feb 2024 19:32:24 +0000
Date: Tue, 20 Feb 2024 19:32:24 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Steve French <smfrench@gmail.com>
Cc: David Howells <dhowells@redhat.com>,
	linux-fsdevel <linux-fsdevel@vger.kernel.org>,
	CIFS <linux-cifs@vger.kernel.org>
Subject: Re: folio oops
Message-ID: <ZdT-SOlTdrDoFqnX@casper.infradead.org>
References: <CAH2r5ms2Hn1cmYEmmbGXTpCo2DY8FY8mfMewcvzEe2S-vjV0pQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAH2r5ms2Hn1cmYEmmbGXTpCo2DY8FY8mfMewcvzEe2S-vjV0pQ@mail.gmail.com>

On Tue, Feb 20, 2024 at 12:09:17PM -0600, Steve French wrote:
> FYI - I hit this oops in xfstests (around generic/048) today.  This is
> with 6.8-rc5
> 
> Any thoughts?

Umm, this isn't an oops, it's just a backtrace.  Do you have anything
that was printed before the backtrace?  I'd expect to see something
complaining about sleeping for too long, since this is where we wait for
writeback to finish ... the bug is probably something not calling
folio_end_writeback() when it should.

> 125545.834971] task:xfs_io          state:D stack:0     pid:1697299
> tgid:1697299 ppid:1692194 flags:0x00004002
> [125545.834987] Call Trace:
> [125545.834992]  <TASK>
> [125545.835002]  __schedule+0x2cb/0x760
> [125545.835022]  schedule+0x33/0x110
> [125545.835031]  io_schedule+0x46/0x80
> [125545.835039]  folio_wait_bit_common+0x136/0x330
> [125545.835052]  ? __pfx_wake_page_function+0x10/0x10
> [125545.835069]  folio_wait_bit+0x18/0x30
> [125545.835076]  folio_wait_writeback+0x2b/0xa0
> [125545.835087]  __filemap_fdatawait_range+0x93/0x110
> [125545.835104]  filemap_write_and_wait_range+0x94/0xc0
> [125545.835120]  cifs_flush+0x9a/0x140 [cifs]
> [125545.835315]  filp_flush+0x35/0x90
> [125545.835329]  filp_close+0x14/0x30
> [125545.835341]  put_files_struct+0x85/0xf0
> [125545.835354]  exit_files+0x47/0x60
> [125545.835365]  do_exit+0x295/0x530
> [125545.835377]  ? wake_up_state+0x10/0x20
> [125545.835391]  do_group_exit+0x35/0x90
> [125545.835403]  __x64_sys_exit_group+0x18/0x20
> [125545.835414]  do_syscall_64+0x74/0x140
> [125545.835424]  ? handle_mm_fault+0xad/0x380
> [125545.835437]  ? do_user_addr_fault+0x338/0x6b0
> [125545.835446]  ? irqentry_exit_to_user_mode+0x6b/0x1a0
> [125545.835458]  ? irqentry_exit+0x43/0x50
> [125545.835467]  ? exc_page_fault+0x94/0x1b0
> [125545.835478]  entry_SYSCALL_64_after_hwframe+0x6e/0x76
> [125545.835490] RIP: 0033:0x7f9b67eea36d
> [125545.835549] RSP: 002b:00007ffde6442cd8 EFLAGS: 00000202 ORIG_RAX:
> 00000000000000e7
> [125545.835560] RAX: ffffffffffffffda RBX: 00007f9b68000188 RCX:
> 00007f9b67eea36d
> [125545.835566] RDX: 00000000000000e7 RSI: ffffffffffffff28 RDI:
> 0000000000000000
> [125545.835572] RBP: 0000000000000001 R08: 0000000000000000 R09:
> 0000000000000000
> [125545.835576] R10: 00005b88e60ec720 R11: 0000000000000202 R12:
> 0000000000000000
> [125545.835582] R13: 0000000000000000 R14: 00007f9b67ffe860 R15:
> 00007f9b680001a0
> [125545.835597]  </TASK>
> 
> 
> -- 
> Thanks,
> 
> Steve
> 


Return-Path: <linux-fsdevel+bounces-28833-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BB9696ED05
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Sep 2024 10:02:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C57A41F277F5
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Sep 2024 08:01:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1FC9156C6F;
	Fri,  6 Sep 2024 08:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b="qS8uuxYi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E87011A28C;
	Fri,  6 Sep 2024 08:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725609703; cv=none; b=mBv12nwAigauxcEyogv7ktfsts5ClaS6zSbgXfttG7lGgNDs6IOB8agwTqG2f80C/+1+9P9I9QJaN2movrCovqQpaAKW1XEhQ7WM877uRlQC9A9XGe2Q0pkVQwIOH/uEVFGsvULpXyJuTmTLdmqQVCeqNJx3eCV2X0OEs1vt9qQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725609703; c=relaxed/simple;
	bh=GGW2mP0FOw5e7YTZk5o31AtnAUs24hgfzJgcmoV/maU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IwXF7fWh9sqhr44KTa2exQR88VW988G0J5t01ghqt1DwA0yqJshcJU7pClX6KZONlRwqmASyrHvw7qkiQRPrm40bKomivhCnrU/qPkfgxYKU0HtZjU7zOhb4UurwzGCsMdfa1A0HhAfiQ6tWynI1NntgeUFWaN140QpkDoH0So0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com; spf=pass smtp.mailfrom=pankajraghav.com; dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b=qS8uuxYi; arc=none smtp.client-ip=80.241.56.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pankajraghav.com
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4X0TFk0k78z9sn8;
	Fri,  6 Sep 2024 10:01:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pankajraghav.com;
	s=MBO0001; t=1725609690;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=txiTk9IGx6J3KSO7NujdzBabpDFq03RzqiY0DDy6h34=;
	b=qS8uuxYixNti8tE7TN9MLXvUBgPDjjlh9aTJdMkk3SurmVQjB6IIh/4l2iXjxLgrv0h9vr
	5TMmBe6fZTNwOIMXy88Czf0WzZAEb+pV9BXgh7OBbJ+Gb17IrhY2JjvM44y1MRfvr73RnV
	5mAk456khuBRrN/tNg5y458EixvqWWZ4Lh0DR3z0wJ5k2ScCtQhL9gakI4vOB9SMSXh3ah
	JEGczHKtCLcQBlq+yoVbWxcp/PQqGoNs1jxRURY5jwO/zYt/WmJpXyMQB6ERcCziUmXLuh
	19OBukBK+v0mnjJUROFZ2M6jz7ErfMNKPIPPlwH21umlNcYrxdjTLtFMlNN5XA==
Date: Fri, 6 Sep 2024 08:01:20 +0000
From: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
To: "Lai, Yi" <yi1.lai@linux.intel.com>
Cc: brauner@kernel.org, akpm@linux-foundation.org, chandan.babu@oracle.com,
	linux-fsdevel@vger.kernel.org, djwong@kernel.org, hare@suse.de,
	gost.dev@samsung.com, linux-xfs@vger.kernel.org, hch@lst.de,
	david@fromorbit.com, Zi Yan <ziy@nvidia.com>,
	yang@os.amperecomputing.com, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, willy@infradead.org, john.g.garry@oracle.com,
	cl@os.amperecomputing.com, p.raghav@samsung.com, mcgrof@kernel.org,
	ryan.roberts@arm.com, David Howells <dhowells@redhat.com>,
	pengfei.xu@intel.com
Subject: Re: [PATCH v13 04/10] mm: split a folio in minimum folio order chunks
Message-ID: <20240906080120.q6xff2odea3ay4k7@quentin>
References: <20240822135018.1931258-1-kernel@pankajraghav.com>
 <20240822135018.1931258-5-kernel@pankajraghav.com>
 <ZtqmtjZ+mVTDx208@ly-workstation>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZtqmtjZ+mVTDx208@ly-workstation>

On Fri, Sep 06, 2024 at 02:52:38PM +0800, Lai, Yi wrote:
Hi Yi,

> 
> I used Syzkaller and found that there is task hang in soft_offline_page in Linux-next tree - next-20240902.

I don't know if it is related, but we had a fix for this commit for a
ltp failure due to locking issues that is there in next-20240905 but not
in next-20240902.

Fix: https://lore.kernel.org/linux-next/20240902124931.506061-2-kernel@pankajraghav.com/

Is this reproducible also on next-20240905?

> 
> After bisection and the first bad commit is:
> "
> fd031210c9ce mm: split a folio in minimum folio order chunks
> "
> 
> All detailed into can be found at:
> https://github.com/laifryiee/syzkaller_logs/tree/main/240904_155526_soft_offline_page
> Syzkaller repro code:
> https://github.com/laifryiee/syzkaller_logs/tree/main/240904_155526_soft_offline_page/repro.c
> Syzkaller repro syscall steps:
> https://github.com/laifryiee/syzkaller_logs/tree/main/240904_155526_soft_offline_page/repro.prog
> Syzkaller report:
> https://github.com/laifryiee/syzkaller_logs/tree/main/240904_155526_soft_offline_page/repro.report
> Kconfig(make olddefconfig):
> https://github.com/laifryiee/syzkaller_logs/tree/main/240904_155526_soft_offline_page/kconfig_origin
> Bisect info:
> https://github.com/laifryiee/syzkaller_logs/tree/main/240904_155526_soft_offline_page/bisect_info.log
> bzImage:
> https://github.com/laifryiee/syzkaller_logs/raw/f633dcbc3a8e4ca5f52f0110bc75ff17d9885db4/240904_155526_soft_offline_page/bzImage_ecc768a84f0b8e631986f9ade3118fa37852fef0
> Issue dmesg:
> https://github.com/laifryiee/syzkaller_logs/blob/main/240904_155526_soft_offline_page/ecc768a84f0b8e631986f9ade3118fa37852fef0_dmesg.log
> 
> "
> [  447.976688]  ? __pfx_soft_offline_page.part.0+0x10/0x10
> [  447.977255]  ? __sanitizer_cov_trace_const_cmp4+0x1a/0x20
> [  447.977858]  soft_offline_page+0x97/0xc0
> [  447.978281]  do_madvise.part.0+0x1a45/0x2a30
> [  447.978742]  ? __pfx___lock_acquire+0x10/0x10
> [  447.979227]  ? __pfx_do_madvise.part.0+0x10/0x10
> [  447.979716]  ? __this_cpu_preempt_check+0x21/0x30
> [  447.980225]  ? __this_cpu_preempt_check+0x21/0x30
> [  447.980729]  ? lock_release+0x441/0x870
> [  447.981160]  ? __this_cpu_preempt_check+0x21/0x30
> [  447.981656]  ? seqcount_lockdep_reader_access.constprop.0+0xb4/0xd0
> [  447.982321]  ? lockdep_hardirqs_on+0x89/0x110
> [  447.982771]  ? trace_hardirqs_on+0x51/0x60
> [  447.983191]  ? seqcount_lockdep_reader_access.constprop.0+0xc0/0xd0
> [  447.983819]  ? __sanitizer_cov_trace_cmp4+0x1a/0x20
> [  447.984282]  ? ktime_get_coarse_real_ts64+0xbf/0xf0
> [  447.984673]  __x64_sys_madvise+0x139/0x180
> [  447.984997]  x64_sys_call+0x19a5/0x2140
> [  447.985307]  do_syscall_64+0x6d/0x140
> [  447.985600]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> [  447.986011] RIP: 0033:0x7f782623ee5d
> [  447.986248] RSP: 002b:00007fff9ddaffb8 EFLAGS: 00000217 ORIG_RAX: 000000000000001c
> [  447.986709] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f782623ee5d
> [  447.987147] RDX: 0000000000000065 RSI: 0000000000003000 RDI: 0000000020d51000
> [  447.987584] RBP: 00007fff9ddaffc0 R08: 00007fff9ddafff0 R09: 00007fff9ddafff0
> [  447.988022] R10: 00007fff9ddafff0 R11: 0000000000000217 R12: 00007fff9ddb0118
> [  447.988428] R13: 0000000000401716 R14: 0000000000403e08 R15: 00007f782645d000
> [  447.988799]  </TASK>
> [  447.988921]
> [  447.988921] Showing all locks held in the system:
> [  447.989237] 1 lock held by khungtaskd/33:
> [  447.989447]  #0: ffffffff8705c500 (rcu_read_lock){....}-{1:2}, at: debug_show_all_locks+0x73/0x3c0
> [  447.989947] 1 lock held by repro/628:
> [  447.990144]  #0: ffffffff87258a28 (mf_mutex){+.+.}-{3:3}, at: soft_offline_page.part.0+0xda/0xf40
> [  447.990611]
> [  447.990701] =============================================
> 
> "
> 
> I hope you find it useful.
> 
> Regards,
> Yi Lai
> 


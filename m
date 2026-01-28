Return-Path: <linux-fsdevel+bounces-75793-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WIeUDphaemm35QEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75793-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jan 2026 19:51:04 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ED2F1A7E4B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jan 2026 19:51:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8F29D3017060
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jan 2026 18:51:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71503371077;
	Wed, 28 Jan 2026 18:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="LfVaAIVm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB3742356BE;
	Wed, 28 Jan 2026 18:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769626256; cv=none; b=DJt7Lhkv9VtDSbi8piJ6AcJteifSIhR3RAtM2vnRS9TExliN1pU/rp2gummG5gCn2i9mW5Ltd9Id2oamtf6VxrqRwJ8RkXFNvF5mfZ+MIaA4yCDOEUM4qBd+YQyJJd2PmkBSe/HnRI8mzMwAEiIkyTjBVN7ewSlvjrxEsdvEWas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769626256; c=relaxed/simple;
	bh=GmV+39VoTX82rhMpDfh0TAjZav3E6Nj0sqtCxk9BGH4=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=lTgJKwcfYw97T1OjOWZdsDe3WK7jb1TK7yHpyrDWSZZsxhDlzVdINUaPV9O7ldSBKsolnxWn52X1wQ9dJDfYkavfFNQ0pAF2kGjHtFuzjjMB0O0idiAVZZfd/mCyTFDzeT6NAgyXhB4gluaoiutH29ovdRzUcg6WNLZWQ2et3QI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=LfVaAIVm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AAF7C4CEF7;
	Wed, 28 Jan 2026 18:50:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1769626255;
	bh=GmV+39VoTX82rhMpDfh0TAjZav3E6Nj0sqtCxk9BGH4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=LfVaAIVm/qIvPhkmchrmgrKSd69TUE5h4pmwGHRK0x31yPDZb5ZoKGi6NDONX49Sv
	 2us8WRo0d1lell+BOaXKay1BJbYt/FjtQRRPyivfyEmBqrCC8gRoaDr3drTR0vIYHQ
	 4mLvm5RRsO3+o9nvYLn7EXmxdAEcVHYFUvQ6HIm8=
Date: Wed, 28 Jan 2026 10:50:54 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Andrii Nakryiko <andrii@kernel.org>
Cc: linux-mm@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 bpf@vger.kernel.org, surenb@google.com,
 syzbot+4e70c8e0a2017b432f7a@syzkaller.appspotmail.com
Subject: Re: [PATCH mm-stable] procfs: avoid fetching build ID while holding
 VMA lock
Message-Id: <20260128105054.dc5a7e4ff5d201e52b1edf85@linux-foundation.org>
In-Reply-To: <20260128183232.2854138-1-andrii@kernel.org>
References: <20260128183232.2854138-1-andrii@kernel.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[linux-foundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-75793-lists,linux-fsdevel=lfdr.de];
	DMARC_NA(0.00)[linux-foundation.org];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[akpm@linux-foundation.org,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[linux-foundation.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel,4e70c8e0a2017b432f7a];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linux-foundation.org:mid,linux-foundation.org:dkim]
X-Rspamd-Queue-Id: ED2F1A7E4B
X-Rspamd-Action: no action

On Wed, 28 Jan 2026 10:32:32 -0800 Andrii Nakryiko <andrii@kernel.org> wrote:

> Fix PROCMAP_QUERY to fetch optional build ID only after dropping mmap_lock or
> per-VMA lock, whichever was used to lock VMA under question, to avoid deadlock
> reported by syzbot:
> 
> ...
> 
> To make this safe, we need to grab file refcount while VMA is still locked, but
> other than that everything is pretty straightforward. Internal build_id_parse()
> API assumes VMA is passed, but it only needs the underlying file reference, so
> just add another variant build_id_parse_file() that expects file passed
> directly.
> 
> Fixes: ed5d583a88a9 ("fs/procfs: implement efficient VMA querying API for /proc/<pid>/maps")
> Reported-by: syzbot+4e70c8e0a2017b432f7a@syzkaller.appspotmail.com
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>

Thanks.  ed5d583a88a9 was 6 months ago so I assume this isn't super
urgent, so it needn't be rushed into mainline via mm.git's hotfixes
queue.

To provide for additional review and test time I'll queue the fix for
the upcoming merge window (Feb 18 upstream merge) with a cc:stable.


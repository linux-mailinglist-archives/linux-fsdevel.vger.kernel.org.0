Return-Path: <linux-fsdevel+bounces-55772-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 402EFB0E7EF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Jul 2025 03:11:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 33E731C87B08
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Jul 2025 01:11:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D737184524;
	Wed, 23 Jul 2025 01:11:01 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0013.hostedemail.com [216.40.44.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D05E156F45;
	Wed, 23 Jul 2025 01:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753233061; cv=none; b=ETE1bYJMIOTR62DGcGW0myN8w/KrcIPvMAsz5mZepp6twEbRlrBiPVQmIKqfHjvAt114D/uW9QFUSq0XX37sV+VDQSsfGNoX9J8jVQjzJ9nR6QV0QsIcqHnXN6736vj7pyaWiKXiPuL6MLbVXFfRIaIZ2qSBpgD17bmglfdCr1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753233061; c=relaxed/simple;
	bh=bmJTpGLG/krDUoJoGDHofvPljI929sGBb+DrF9RWYBo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PhQYcurUcTAWaQ5itPBAU5fOeybIEXpNTSrO128s7UIXpPihH85Cgx8rqPdeugDnIX8TDdPBEZqCeFZzlsXIXITdBOEqegankemvilHzdG8b6LMJzaBJqPGGH4aATaL2X19CVIWANxMOfKaFs4EeqqANhgPRXqFR1GqjSafZ6i4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf01.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay08.hostedemail.com (Postfix) with ESMTP id 3C0B0140536;
	Wed, 23 Jul 2025 01:10:56 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf01.hostedemail.com (Postfix) with ESMTPA id 16F2A60009;
	Wed, 23 Jul 2025 01:10:52 +0000 (UTC)
Date: Tue, 22 Jul 2025 21:10:52 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Jeff Layton <jlayton@kernel.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner
 <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Chuck Lever <chuck.lever@oracle.com>, NeilBrown <neil@brown.name>, Olga
 Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, Tom
 Talpey <tom@talpey.com>, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-nfs@vger.kernel.org
Subject: Re: [PATCH 1/2] vfs: add tracepoints in inode_set_ctime_deleg
Message-ID: <20250722211052.6bffc11f@gandalf.local.home>
In-Reply-To: <20250722-nfsd-testing-v1-1-31321c7fc97f@kernel.org>
References: <20250722-nfsd-testing-v1-0-31321c7fc97f@kernel.org>
	<20250722-nfsd-testing-v1-1-31321c7fc97f@kernel.org>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: biuprdobuqpeo6mzoe9q6cjxkqeqjxjk
X-Rspamd-Server: rspamout03
X-Rspamd-Queue-Id: 16F2A60009
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/kZsqn7gAPZ41zfL+rykQt7DQhAmAxaA8=
X-HE-Tag: 1753233052-217096
X-HE-Meta: U2FsdGVkX1929BJQGl8KBlEosmZNVxvjMACNoWtndyrMzyA3+iCgoRnl8klsK/aFTNhcNxTY96P+7PMo4a/u9/stj80HzdI2CtYQCzmofZKjpFj3SikQLqY5pEeALDT9tP8gQUh1jye48ir7b2TN57eRDiaFZrW5NVkbTdtCA2UeVjnqhF8WTiG3D0c9GmRE83xA/wdbKE0lGKGf5Z7vyj7fSXP4enwEzA4UrZifeG8vf1n92ZRQzf6UZjCrdEF1Ofe2gawSM4I8h6KDMDuOdLPkqxmfMw2j0dt+VKU7Lv0aile6fpX2Rjf6edcJ3xc+ePBh13kTUXUhQ3zt4yIE/APyeGd5jqHh

On Tue, 22 Jul 2025 14:52:27 -0400
Jeff Layton <jlayton@kernel.org> wrote:

> +	TP_fast_assign(
> +		__entry->dev		= inode->i_sb->s_dev;
> +		__entry->ino		= inode->i_ino;
> +		__entry->gen		= inode->i_generation;
> +		__entry->old_s		= old->tv_sec;
> +		__entry->req_s		= req->tv_sec;
> +		__entry->now_s		= now ? now->tv_sec : 0;
> +		__entry->old_ns		= old->tv_nsec;
> +		__entry->req_ns		= req->tv_nsec;
> +		__entry->now_ns		= now ? now->tv_nsec : 0;
> +	),
> +
> +	TP_printk("ino=%d:%d:%ld:%u old=%lld.%u req=%lld.%u now=%lld.%u",

Hmm, wouldn't you want the above to be:

	TP_printk("ino=%d:%d:%ld:%u old=%lld.%09u req=%lld.%09u now=%lld.%09u",

Otherwise the nanosecond part is going to look confusing if it's less that 100,000,000.

-- Steve


> +		MAJOR(__entry->dev), MINOR(__entry->dev), __entry->ino, __entry->gen,
> +		__entry->old_s, __entry->old_ns,
> +		__entry->req_s, __entry->req_ns,
> +		__entry->now_s, __entry->now_ns
> +	)


Return-Path: <linux-fsdevel+bounces-25384-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F9F594B488
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Aug 2024 03:17:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1AFE91F22D97
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Aug 2024 01:17:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DABD79CC;
	Thu,  8 Aug 2024 01:17:34 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2A5617FD;
	Thu,  8 Aug 2024 01:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723079853; cv=none; b=RHmJuqkBaF/Gj7Z32TENyCbwhhuCC4n2sVyt54Z2L0uw2o5pOOqtt1UMkI1mSNVSHTB5arAer4LDb7Bw4uhM43KIauv40iRZlm+RnkIKS10q5WjnE0UTc4taX5pWlGjsTzIeTuocoiDi6TA6Gwizda+OuUE3Gm+LlvGabDWBM7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723079853; c=relaxed/simple;
	bh=qzT5aRTLzkCGww4XL3uDTkT7u3hvbzs/L0awzaLu4ss=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hTzyeVKVHK0b9AyGWafofvJN7v2L8DwxmJIUCPrlQg09ihe2DWJA0cNiXGIqsYcaY5gHiIKiXlh2FbLUVYXvF6weMrgWUFC1W70X9Nnm4CKj+uNRbxejgW9PiPT22E6rf1cOK7P1sp9IgdJ5hGHAuDkOwJgJaicXd1/GROhXCYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3ABC2C32781;
	Thu,  8 Aug 2024 01:17:32 +0000 (UTC)
Date: Wed, 7 Aug 2024 21:17:31 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Takaya Saeki <takayas@chromium.org>
Cc: Matthew Wilcox <willy@infradead.org>, Andrew Morton
 <akpm@linux-foundation.org>, Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Junichi Uekawa
 <uekawa@chromium.org>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-mm@kvack.org
Subject: Re: [PATCH v2] filemap: add trace events for get_pages, map_pages,
 and fault
Message-ID: <20240807211731.16758171@gandalf.local.home>
In-Reply-To: <20240620161903.3176859-1-takayas@chromium.org>
References: <20240620161903.3176859-1-takayas@chromium.org>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 20 Jun 2024 16:19:03 +0000
Takaya Saeki <takayas@chromium.org> wrote:

> +DECLARE_EVENT_CLASS(mm_filemap_op_page_cache_range,
> +
> +	TP_PROTO(
> +		struct address_space *mapping,
> +		pgoff_t index,
> +		pgoff_t last_index
> +	),
> +
> +	TP_ARGS(mapping, index, last_index),
> +
> +	TP_STRUCT__entry(
> +		__field(unsigned long, i_ino)
> +		__field(dev_t, s_dev)
> +		__field(unsigned long, index)
> +		__field(unsigned long, last_index)
> +	),
> +
> +	TP_fast_assign(
> +		__entry->i_ino = mapping->host->i_ino;
> +		if (mapping->host->i_sb)
> +			__entry->s_dev =
> +				mapping->host->i_sb->s_dev;
> +		else
> +			__entry->s_dev = mapping->host->i_rdev;
> +		__entry->index = index;
> +		__entry->last_index = last_index;
> +	),
> +
> +	TP_printk(
> +		"dev=%d:%d ino=%lx ofs=%lld max_ofs=%lld",
> +		MAJOR(__entry->s_dev),
> +		MINOR(__entry->s_dev), __entry->i_ino,
> +		((loff_t)__entry->index) << PAGE_SHIFT,
> +		((loff_t)__entry->last_index) << PAGE_SHIFT
> +	)

Hmm, since the "ofs" is in decimal, perhaps we should just make it a range:

		"dev=%d:%d ino=%lx ofs=%lld-%lld",
		MAJOR(__entry->s_dev),
		MINOR(__entry->s_dev), __entry->i_ino,
		((loff_t)__entry->index) << PAGE_SHIFT,
		(((loff_t)__entry->last_index + 1) << PAGE_SHIFT - 1)

?

-- Steve

> +);
> +
> +DEFINE_EVENT(mm_filemap_op_page_cache_range, mm_filemap_get_pages,
> +	TP_PROTO(
> +		struct address_space *mapping,
> +		pgoff_t index,
> +		pgoff_t last_index
> +	),
> +	TP_ARGS(mapping, index, last_index)
> +);
> +
> +DEFINE_EVENT(mm_filemap_op_page_cache_range, mm_filemap_map_pages,
> +	TP_PROTO(
> +		struct address_space *mapping,
> +		pgoff_t index,
> +		pgoff_t last_index
> +	),
> +	TP_ARGS(mapping, index, last_index)
> +);
> +


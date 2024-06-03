Return-Path: <linux-fsdevel+bounces-20869-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CBF248FA59B
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Jun 2024 00:36:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8ED66283024
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Jun 2024 22:36:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B8D913CAB0;
	Mon,  3 Jun 2024 22:36:34 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDA3784FB7;
	Mon,  3 Jun 2024 22:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717454194; cv=none; b=lpjrhF5dYxszCpdKSn2H+LxZIAwHthyjpeFqx6CbBM4XoiD7NNWXRgiGmQ3lCiUkoT3ayR2vHfN+b08J9ItdYRK2pEt6/h7D2kq8EuY6gzG5O1x9KET3BxIgIvmiznZ5lgKG2FpAl+NB55vLmQW7o5fEPyrK/VvavSvwmirWeBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717454194; c=relaxed/simple;
	bh=aHFLneUiM7Y8KGK9AriZOavkvqFrckBGJd50BYmAOIM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sxChJSAoH5ww8L0WHokSb+YE0+UPdCMbke4p/srpw9Fee2ZqpP6ExSdzrvF+rURsKiHJhurjlV/OlXGnos+8t/YGZG49qPwNZWpGHiCRYl6lK+I8IxsaEriki0F3pGxMc+Z04XG86p78DMdIA0AlZj9wRPQE7O30EZbhTI1TZHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF7A3C2BD10;
	Mon,  3 Jun 2024 22:36:31 +0000 (UTC)
Date: Mon, 3 Jun 2024 18:37:42 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Yafang Shao <laoar.shao@gmail.com>, linux-mm@kvack.org,
 linux-fsdevel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 audit@vger.kernel.org, linux-security-module@vger.kernel.org,
 selinux@vger.kernel.org, bpf@vger.kernel.org, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH 2/6] tracing: Replace memcpy() with __get_task_comm()
Message-ID: <20240603183742.17b34bc3@gandalf.local.home>
In-Reply-To: <CAHk-=wgDWUpz2LG5KEztbg-S87N9GjPf5Tv2CVFbxKJJ0uwfSQ@mail.gmail.com>
References: <20240602023754.25443-1-laoar.shao@gmail.com>
	<20240602023754.25443-3-laoar.shao@gmail.com>
	<20240603172008.19ba98ff@gandalf.local.home>
	<CAHk-=whPUBbug2PACOzYXFbaHhA6igWgmBzpr5tOQYzMZinRnA@mail.gmail.com>
	<20240603181943.09a539aa@gandalf.local.home>
	<CAHk-=wgDWUpz2LG5KEztbg-S87N9GjPf5Tv2CVFbxKJJ0uwfSQ@mail.gmail.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 3 Jun 2024 15:23:48 -0700
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Mon, 3 Jun 2024 at 15:18, Steven Rostedt <rostedt@goodmis.org> wrote:
> >
> > The logic behind __string() and __assign_str() will always add a NUL
> > character.  
> 
> Ok. But then you still end up with the issue that now the profiles are
> different, and you have a 8-byte pointer to dynamically allocated
> memory instead of just the simpler comm[TASK_COMM_LEN].

It's actually a 4 byte meta data that holds it.

	__data_offsets->item##_ptr_ = src;

The __data_offsets is a local helper structure that holds the information
about where the string data will be in the ring buffer event, while the
event is being recorded. The actual data in the ring buffer is a 4 byte
word, where 2 bytes is for the size of the string and 2 bytes is for the
offset into the event.

If you have a task->comm = "ps", that will take up 12 bytes in the ring buffer.

   field: 2 bytes: for where in the event the "ps" is.
          2 bytes: for the length of ps.

Then after the data, you have 3 or 4 bytes to hold "ps\0". (the data always
ends on a 4 byte alignment).

The amount of data in the ring buffer to hold "ps" just went from 16 bytes
down to 12 bytes, and nothing is truncated if we extend the size of comm.

> 
> Is that actually a good idea for tracing?
> 
> We're trying to fix the core code to be cleaner for places that may
> actually *care* (like 'ps').
> 
> Would we really want to touch this part of tracing?

Note, I've been wanting to get rid of the hard coded TASK_COMM_LEN from the
events for a while. As I mentioned before, the only reason the memcpy exists
is because it was added before the __string() logic was. Then it became
somewhat of a habit to do that for everything that referenced task->comm. :-/

-- Steve


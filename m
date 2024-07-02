Return-Path: <linux-fsdevel+bounces-22960-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 593FA9243AC
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Jul 2024 18:38:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C2651F25824
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Jul 2024 16:38:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77A191BD4FD;
	Tue,  2 Jul 2024 16:37:51 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 147621BC094;
	Tue,  2 Jul 2024 16:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719938271; cv=none; b=nncndl7aMua3T/YPWMrxHovrnW8wRt3SnsRUcZ+Nc5ZLmG8kdDmFSF5s95VPW9FO0/Xe7kiNwldOy4K/ajJ1w76rzSf3II7QQbYOwF2pDJSKbFH0DQBrMTALg9J/I04CzfX9sm5pm/K2jqN2kfxMyhcvct7zsOX48jMSpzt4GYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719938271; c=relaxed/simple;
	bh=NyDSteSnZ6BQf94sFoFThr5Rp9UVaWXqBJvOAZRP5uY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Su8y3mkh9xdaOwKs0HfDn7whbUpn4Z1vM02nhudHmGhbmFtHO0iB+l4dRMLxe4lNKEwaUZ233TscS0PiAYrB2tutrsgRxaI0Xeb7jjSSyOExo4O1u4VW4iBtsMVHZmoVtJGmZ3iUgUSDkaTk9jMwU1ZoDenNjXIRWr+vIJtFFgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D882C116B1;
	Tue,  2 Jul 2024 16:37:49 +0000 (UTC)
Date: Tue, 2 Jul 2024 12:37:47 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Takaya Saeki <takayas@chromium.org>
Cc: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>, Matthew Wilcox
 <willy@infradead.org>, Andrew Morton <akpm@linux-foundation.org>, Mathieu
 Desnoyers <mathieu.desnoyers@efficios.com>, Junichi Uekawa
 <uekawa@chromium.org>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-mm@kvack.org
Subject: Re: [PATCH v2] filemap: add trace events for get_pages, map_pages,
 and fault
Message-ID: <20240702123747.796b98c5@rorschach.local.home>
In-Reply-To: <CAH9xa6ej2g+DvCd=cqjj8sx9yZ=DjL6Ffu6aOfebvcjBmGs5pQ@mail.gmail.com>
References: <20240620161903.3176859-1-takayas@chromium.org>
	<20240626213157.e2d1b916bcb28d97620043d1@kernel.org>
	<20240626095812.2c5ffb72@rorschach.local.home>
	<CAH9xa6ej2g+DvCd=cqjj8sx9yZ=DjL6Ffu6aOfebvcjBmGs5pQ@mail.gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 2 Jul 2024 19:27:16 +0900
Takaya Saeki <takayas@chromium.org> wrote:

> Hello all, and thank you so much for the review, Steven and Masami.
> 
> I'm currently considering replacing the `max_ofs` output with
> `length`. Please let me know your thoughts.
> With the current design, a memory range of an event is an inclusive
> range of [ofs, max_ofs + 4096]. I found the `+4096` part confusing
> during the ureadahead's upstreaming work. Replacing `max_ofs` with
> `length` makes the range specified by an event much more concise.

This makes sense to me.

Matthew, have any comments on this?

Thanks,

-- Steve


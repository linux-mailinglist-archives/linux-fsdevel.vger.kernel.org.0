Return-Path: <linux-fsdevel+bounces-8121-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EF80182FCF5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Jan 2024 23:35:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8DD551F29AC4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Jan 2024 22:35:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D08541C6E;
	Tue, 16 Jan 2024 22:00:42 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCF151DA2C;
	Tue, 16 Jan 2024 22:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705442441; cv=none; b=eE9gYjU6Q9zYxnSZe4vgK9FCaFl4uUSQVq1p7pzC4qS0b58bjGNd9kWvB/eIlptFWjDjfU9lvO2qnYkIcfu6443SpYeuBIT/qrN1KbI0NGG4PkbseFH8zYx/DaFed6RZb1CN3xRcVVOAkXYJxaDFHt0jR752c/uqFeIEYD0FtJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705442441; c=relaxed/simple;
	bh=rBdhBSdBHxB0phUx9UosP1F8D0qiFA4eia10mackJ5s=;
	h=Received:Date:From:To:Cc:Subject:Message-ID:In-Reply-To:
	 References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding; b=i0hSf/z3n0Upn7KH2g1RylzL4Fd/NPorGlwiVb5rVG2f3HL52t6j00n0tSBJYK3ZQlfgYSG3LufG1x8CCtKluTzZ5svXu0MWYcRZ6j6cMdBc1Z62wsqORcSoAqr/6KQNTtV/fe5iusO4KRhMozYtH5R1XEg4E14l9XnuNJYuDp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28402C433F1;
	Tue, 16 Jan 2024 22:00:40 +0000 (UTC)
Date: Tue, 16 Jan 2024 17:01:54 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Trace
 Kernel <linux-trace-kernel@vger.kernel.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Mathieu
 Desnoyers <mathieu.desnoyers@efficios.com>, Christian Brauner
 <brauner@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, Ajay Kaher
 <ajay.kaher@broadcom.com>, linux-fsdevel <linux-fsdevel@vger.kernel.org>,
 kernel test robot <oliver.sang@intel.com>
Subject: Re: [PATCH v2 2/2] eventfs: Create list of files and directories at
 dir open
Message-ID: <20240116170154.5bf0a250@gandalf.local.home>
In-Reply-To: <CAHk-=wgjSuapZoWfQZMyFi80wJE6a=vjOdgpy_k+YaWwbX9Pig@mail.gmail.com>
References: <20240116211217.968123837@goodmis.org>
	<20240116211353.573784051@goodmis.org>
	<CAHk-=wgjSuapZoWfQZMyFi80wJE6a=vjOdgpy_k+YaWwbX9Pig@mail.gmail.com>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 16 Jan 2024 13:39:38 -0800
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> I don't understand why your still insist on this pointless open wrapper.

I just liked the consistency of it.

> 
> Just do this all at iterate time. No open wrappers. No nothing. Just
> iterate over the days structures your have.
> 
> IOW, instead of iterating in open to create the array, just iterate in -
> look, it's in the *name* for chrissake - iterate_shared.
> 
> No array. No random allocation for said array.
> 
> If you can iterate at open time, you can iterate at iterate_shared time.
> Stop creating a list that your already have.
> 
> And nobody cares if you do a readdir at the same time as modifying the
> directory. This isn't a real filesystem with strict POSIX semantics.

OK, I can do that.

-- Steve



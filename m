Return-Path: <linux-fsdevel+bounces-24252-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1927193C664
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jul 2024 17:30:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AD899B2237F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jul 2024 15:30:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6F0519D89A;
	Thu, 25 Jul 2024 15:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="SxOn2vRG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80F281CF8B;
	Thu, 25 Jul 2024 15:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721921433; cv=none; b=OR7OtUDPYsqHLSmsJLD7iQQa8pA17X/3gS38Wkczxf4g5LotyF8yz21YpPUH987rdGHxs50SNhCVh6qJD/ykUoKwiYo8jULd7kBIwfrvEH8h2PDUuil4OprdOTlbndeayDXbYufjoF4fX+khOZF+QRw4JzNZgGF3GDuSXOCqum8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721921433; c=relaxed/simple;
	bh=hCz/JmAspQs7HjFsCGaNWcLwJVHQpD5EZRBb2AFqQEo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D3PSIcmZA4av9CJ0tAZVJn5e1gLd9awdAwAvWmn0JbOE7356FA43wEOuYdNr+HBAH97Z0ge7HQDEWhXtFlXVHfdaXJRqiwg2tRkvX+6iX2/yOwuUupJENMpk2I502lhd3ELYlptO/430TqjSc+F/wibG8MoLeo5ZLEKBofeY6+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=SxOn2vRG; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=2xXlOzOwfMRXBcLrEM7+MPSHfSjca4OWRUltG0XdEGw=; b=SxOn2vRGuoPadXoky66Dr7kkVu
	Nvku9YWseR1Dt675Ei7FUdaGv5L7mfrYNCrLG1skkiROc4B64rMgL0ihWLrafv012W5UkceuaLEoC
	gvg3AdxgcRKn6oIC7W8ASvjJ3ZCZ+3NGzSQ7NZ0vEJ16MfVW9ycdvjXu39C7sfnWwSDjAiA/CSlZO
	wJufyXePQsqGEuDn29H9A+3QpfuB59UN8yZUHe+rTDEGnaXQ0IttSehjQwTQT8pxhkRipaDv5iD7x
	5rTTogCWSyNQwxDNCmnRJIxgo7iJUeNNWNTZ/cT/ZdW2bZty+lVJNTCV56XXilZWN3l1PmmgG0sXv
	FgDF2oBQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sX0Px-00000004358-3kLI;
	Thu, 25 Jul 2024 15:30:10 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id E3E5730037B; Thu, 25 Jul 2024 17:30:08 +0200 (CEST)
Date: Thu, 25 Jul 2024 17:30:08 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
	Wedson Almeida Filho <wedsonaf@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@samsung.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
	Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Carlos Llamas <cmllamas@google.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Matthew Wilcox <willy@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>, Daniel Xu <dxu@dxuuu.xyz>,
	Martin Rodriguez Reboredo <yakoyoku@gmail.com>,
	Trevor Gross <tmgross@umich.edu>, linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	Kees Cook <kees@kernel.org>
Subject: Re: [PATCH v8 1/8] rust: types: add `NotThreadSafe`
Message-ID: <20240725153008.GK13387@noisy.programming.kicks-ass.net>
References: <20240725-alice-file-v8-0-55a2e80deaa8@google.com>
 <20240725-alice-file-v8-1-55a2e80deaa8@google.com>
 <20240725143714.GI13387@noisy.programming.kicks-ass.net>
 <CAH5fLggOo-TErSktC6qmyZpMGVu-M8rFXgvfi3N0Z_u63C3EyA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAH5fLggOo-TErSktC6qmyZpMGVu-M8rFXgvfi3N0Z_u63C3EyA@mail.gmail.com>

On Thu, Jul 25, 2024 at 05:09:14PM +0200, Alice Ryhl wrote:

> > As per always for not being able to read rust; how does this extend to
> > get_task_struct()? Once you've taken a reference on current, you should
> > be free to pass it along to whomever.
> 
> Once you take a reference on current, it becomes thread-safe. This is
> because taking a reference creates a value of type ARef<Task> rather
> than TaskRef, and ARef<Task> is considered thread-safe.

Ignoring comments, there isn't a single mention of ARef there. Where
does it come from?


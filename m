Return-Path: <linux-fsdevel+bounces-7839-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 94BF082B86C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Jan 2024 01:05:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 46BCE1F24FD4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Jan 2024 00:05:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BE44655;
	Fri, 12 Jan 2024 00:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="xenobhv8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D71217988;
	Fri, 12 Jan 2024 00:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 11 Jan 2024 19:05:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1705017914;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ja/rCrslI1ygahysbrKqDdK7cEumA4q0GUIhaAsj41s=;
	b=xenobhv8UAJbqxw9LEhIHklm8eVbdXfTgNl4eYnpAViLGg4XD2eqzldprWOoacL63BDc66
	BhihY9pLUMlJLCbhlThvPSFIJemt2OOM/BllXPeft/BR9O6jxPLpGmLTJ2+mEjU3riEAbF
	GTS2N0EYRkJF6RTp4E1sJZ+mst/yXos=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Kees Cook <keescook@chromium.org>
Cc: Matthew Wilcox <willy@infradead.org>, 
	Linus Torvalds <torvalds@linux-foundation.org>, linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [GIT PULL] bcachefs updates for 6.8
Message-ID: <zocgn7zzr4wo3egjnq2vpmh7kpuxcj7gvo3a5tlbidt6wdh4rs@2udxphdcgeug>
References: <wq27r7e3n5jz4z6pn2twwrcp2zklumcfibutcpxrw6sgaxcsl5@m5z7rwxyuh72>
 <202401101525.112E8234@keescook>
 <6pbl6vnzkwdznjqimowfssedtpawsz2j722dgiufi432aldjg4@6vn573zspwy3>
 <202401101625.3664EA5B@keescook>
 <xlynx7ydht5uixtbkrg6vgt7likpg5az76gsejfgluxkztukhf@eijjqp4uxnjk>
 <CAHk-=wigjbr7d0ZLo+6wbMk31bBMn8sEwHEJCYBRFuNRhzO+Kw@mail.gmail.com>
 <ZaByTq3uy0NfYuQs@casper.infradead.org>
 <202401111534.859084884C@keescook>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202401111534.859084884C@keescook>
X-Migadu-Flow: FLOW_OUT

On Thu, Jan 11, 2024 at 03:42:19PM -0800, Kees Cook wrote:
> On Thu, Jan 11, 2024 at 10:57:18PM +0000, Matthew Wilcox wrote:
> > On Wed, Jan 10, 2024 at 05:47:20PM -0800, Linus Torvalds wrote:
> > > No, because the whole idea of "let me mark something deprecated and
> > > then not just remove it" is GARBAGE.
> > > 
> > > If somebody wants to deprecate something, it is up to *them* to finish
> > > the job. Not annoy thousands of other developers with idiotic
> > > warnings.
> > 
> > What would be nice is something that warned about _new_ uses being
> > added.  ie checkpatch.  Let's at least not make the problem worse.
> 
> For now, we've just kind of "dealt with it". For things that show up
> with new -W options we've enlisted sfr to do the -next builds with it
> explicitly added (but not to the tree) so he could generate nag emails
> when new warnings appeared. That could happen if we added it to W=1
> builds, or some other flag like REPORT_DEPRECATED=1.
> 
> Another ugly idea would be to do a treewide replacement of "func" to
> "func_deprecated", and make "func" just a wrapper for it that is marked
> with __deprecated. Then only new instances would show up (assuming people
> weren't trying to actively bypass the deprecation work by adding calls to
> "func_deprecated"). :P Then the refactoring to replace "func_deprecated"
> could happen a bit more easily.
> 
> Most past deprecations have pretty narrow usage. This is not true with
> the string functions, which is why it's more noticeable here. :P

Before doing the renaming - why not just leave a kdoc comment that marks
it as deprecated? Seems odd that checkpatch was patched, but I can't
find anything marking it as deprecated when I cscope to it.


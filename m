Return-Path: <linux-fsdevel+bounces-63601-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B0F00BC5689
	for <lists+linux-fsdevel@lfdr.de>; Wed, 08 Oct 2025 16:15:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 563EA4E8778
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Oct 2025 14:15:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFC5929E116;
	Wed,  8 Oct 2025 14:15:36 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0013.hostedemail.com [216.40.44.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 694DA24C076;
	Wed,  8 Oct 2025 14:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759932936; cv=none; b=XjoI5So8IN1aE/U6+yCyStFpA5f7E0J6pvSey8lZKdqnK/mC7Du5qhHXWoYHNr4tE7IKWx8EQJiCMa4Z9KUHuE047w95iQnZQBHSR3Akt27Ja4K6dfzvMxnp9PyrcDfi001p9KcR4GSxUHBRAkAVCR70gKdiUdItf/hoTm7mTGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759932936; c=relaxed/simple;
	bh=iXZtSj53wyeR54UevviOLKH/E+uyZX38PDKL04nrvjA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kyzlDHgbRk1aXfRC0AJkafHLLrL7xXghK/igiluVHXUQq9xDDZn3s+KyKLHpEE2f4jcvS8DN5LcMtBk4rwV3tZEjduzZEMR0Hl7Cb7ekDFGYSS9G75glKUu3Z4Gf2IcqtCXvYGrMiObu37/v1ywI/bqEFQ6gUMhPxDr56xUH6Ag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf11.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay09.hostedemail.com (Postfix) with ESMTP id F2D02877B7;
	Wed,  8 Oct 2025 14:15:29 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf11.hostedemail.com (Postfix) with ESMTPA id 0E50F2002A;
	Wed,  8 Oct 2025 14:15:26 +0000 (UTC)
Date: Wed, 8 Oct 2025 10:17:20 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Jakub Acs <acsjakub@amazon.de>
Cc: <aliceryhl@google.com>, <djwong@kernel.org>, <jhubbard@nvidia.com>,
 <akpm@linux-foundation.org>, <axelrasmussen@google.com>,
 <chengming.zhou@linux.dev>, <david@redhat.com>,
 <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-mm@kvack.org>, <peterx@redhat.com>,
 <rust-for-linux@vger.kernel.org>, <xu.xin16@zte.com.cn>
Subject: Re: [PATCH] mm: use enum for vm_flags
Message-ID: <20251008101720.6c68c5cd@gandalf.local.home>
In-Reply-To: <20251008125427.68735-1-acsjakub@amazon.de>
References: <20251007162136.1885546-1-aliceryhl@google.com>
	<20251008125427.68735-1-acsjakub@amazon.de>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: ogj7eysixwgpfom1mi8wk8nmmmx53czq
X-Rspamd-Server: rspamout08
X-Rspamd-Queue-Id: 0E50F2002A
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+qoUNA17ejSntFqW0JBkTCQ/TFqzc90T0=
X-HE-Tag: 1759932926-798415
X-HE-Meta: U2FsdGVkX19evAndJnR+3t5nvLm6JeXv1Z2HsiSMqn0YkhTDtMA1K9uPQfa6BcTjTk0CnLStGPAePV4tk0jTIiNS9QOljZYVJ9Jmu6BHDHyrURNB/hln4NJsL4GSPpopfWFOzYIwW0AlGV3Va/xPaWwxT/QgbMyZ76ai/jDHr9+3ldfOqwB1D5S4DDgemztR1x6zgc5xgRTlsjEf+qwC19nTYKbYzzwyOjYr+5ToVsFXoLIHWY90tQwwAkGtv7iTK/vKDVbTJaxI2UYmNWccreqV5UxEY2lAcArMkN4s/PoLF6GLZeqINP1Pdn4Ta1KB

On Wed, 8 Oct 2025 12:54:27 +0000
Jakub Acs <acsjakub@amazon.de> wrote:


> Hi Alice,
> 
> thanks for the patch, I squashed it in (should I add your signed-off-by
> too?) and added the TRACE_DEFINE_ENUM calls pointed out by Derrick.
> 
> I have the following points to still address, though: 
> 
> - can the fact that we're not controlling the type of the values if
>   using enum be a problem? (likely the indirect control we have through
>   the highest value is good enough, but I'm not sure)
> 
> - where do TRACE_DEFINE_ENUM calls belong?

It's probably best to put them in include/trace/events/mmflags.h

>   I see them placed e.g. in include/trace/misc/nfs.h for nfs or
>   arch/x86/kvm/mmu/mmutrace.h, but I don't see a corresponding file for
>   mm.h - does this warrant creating a separate file for these
>   definitions?
> 
> - with the need for TRACE_DEFINE_ENUM calls, do we still deem this
>   to be a good trade-off? - isn't fixing all of these in
>   rust/bindings/bindings_helper.h better?

There's tricks to add a bunch of TRACE_DEFINE_ENUM()s at once. In fact,
look at how the macro TRACE_GFP_FLAGS_GENERAL is used in that mmflags.h
file.

The reason macros work but enums do not is because the pre-processor
converts macros to their original values but not enums. The TRACE_EVENT()
converts the "printf" part into a string. The macros are changes to their
values, but enums do not get changed.

The TRACE_DEFINE_ENUM() macro adds magic to map the name of the enum to its
value, and on boot up, the printf formats have the enums convert to the
values. Note, I'm working on having this performed at build time.

-- Steve


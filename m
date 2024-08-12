Return-Path: <linux-fsdevel+bounces-25715-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A773794F6A8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Aug 2024 20:27:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 522DF1F23003
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Aug 2024 18:27:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE03319413B;
	Mon, 12 Aug 2024 18:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E81DuNFU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 273CA1917DB;
	Mon, 12 Aug 2024 18:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723487111; cv=none; b=TSkUxaifMsBDVAqJEwIzR0w6GhafbVsCTuA+IRaguGhiuV4OHDlG316SYdCM0tQrkG9cYkCJq+RMlXbtnEhiTtHgL0eLHtjTWmDas2RQ572nNlLgsiHorB7ul1gTiqC+a/5Zu/Sh1/+EZ3koCZtwiOtQuTDpUp05D+Lfdy+ZaKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723487111; c=relaxed/simple;
	bh=b9XMtJBDz1eS9eHtLGMNWgjburbqn9Im8RPbrEwodd0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b8zWePti0WWfDov2Pfxvh539W1FVNQSFOEV9qvs6ZM0hRaAInvQEZibieVvAWjK7pVSKC87hUmuxkeG6y/EEd8NceK2GuhUg1XBtVdqtmR5lM8DoQU038bTb61Rw8io2rsLM8bCUn8HN2SPwU0pcmqH4BvihRWS1LvNkhL/1CbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E81DuNFU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2282C32782;
	Mon, 12 Aug 2024 18:25:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723487111;
	bh=b9XMtJBDz1eS9eHtLGMNWgjburbqn9Im8RPbrEwodd0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=E81DuNFUQBf+Hp0FbT2dTh9FMz6izZjqLPR8pbFkTDHAwRcUSi9U5m4y+b7a5D84S
	 L4T1X6GfeBl5U02jvjl9KAFPYvCkhlnnu6mzL1APe2tZXOEtBs31xMIYkbdSYXb0uw
	 OCZ8ZDxNXF7b9OEHsVto4zb2JZ3KhWUgU8eKSa/fkUBVjkpmgRmH38JMJrE/d+keLW
	 JS9jz+vUKujhhhB11sboKhh4NrSYNASIY94gwq4RxOhzVpA5LDtW+iKVMQnO+sX8+f
	 uubQ8A9wcfOwIxJzy/nBX9COA4qzl87jmWK/AILzeuT6hD8woAsZ10LokHwHHjv8zw
	 nSNBePSfzuDjw==
Date: Mon, 12 Aug 2024 11:25:10 -0700
From: Kees Cook <kees@kernel.org>
To: Brian Mak <makb@juniper.net>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Oleg Nesterov <oleg@redhat.com>,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH v3] binfmt_elf: Dump smaller VMAs first in ELF cores
Message-ID: <202408121123.FBAE8191A3@keescook>
References: <036CD6AE-C560-4FC7-9B02-ADD08E380DC9@juniper.net>
 <87ttfs1s03.fsf@email.froward.int.ebiederm.org>
 <202408121105.E056E92@keescook>
 <713A0ABD-531D-4186-822A-4555906FD7EC@juniper.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <713A0ABD-531D-4186-822A-4555906FD7EC@juniper.net>

On Mon, Aug 12, 2024 at 06:21:15PM +0000, Brian Mak wrote:
> On Aug 12, 2024, at 11:05 AM, Kees Cook <kees@kernel.org> wrote
> 
> > On Sat, Aug 10, 2024 at 07:28:44AM -0500, Eric W. Biederman wrote:
> >> Brian Mak <makb@juniper.net> writes:
> >> 
> >>> Large cores may be truncated in some scenarios, such as with daemons
> >>> with stop timeouts that are not large enough or lack of disk space. This
> >>> impacts debuggability with large core dumps since critical information
> >>> necessary to form a usable backtrace, such as stacks and shared library
> >>> information, are omitted.
> >>> 
> >>> We attempted to figure out which VMAs are needed to create a useful
> >>> backtrace, and it turned out to be a non-trivial problem. Instead, we
> >>> try simply sorting the VMAs by size, which has the intended effect.
> >>> 
> >>> By sorting VMAs by dump size and dumping in that order, we have a
> >>> simple, yet effective heuristic.
> >> 
> >> To make finding the history easier I would include:
> >> v1: https://urldefense.com/v3/__https://lkml.kernel.org/r/CB8195AE-518D-44C9-9841-B2694A5C4002@juniper.net__;!!NEt6yMaO-gk!DavIB4o54KGrCPK44iq9_nJrOpKMJxUAlazBVF6lfKwmMCgLD_NviY088SQXriD19pS0rwhadvc$
> >> v2: https://urldefense.com/v3/__https://lkml.kernel.org/r/C21B229F-D1E6-4E44-B506-A5ED4019A9DE@juniper.net__;!!NEt6yMaO-gk!DavIB4o54KGrCPK44iq9_nJrOpKMJxUAlazBVF6lfKwmMCgLD_NviY088SQXriD19pS0G7RQv4o$
> >> 
> >> Acked-by: "Eric W. Biederman" <ebiederm@xmission.com>
> >> 
> >> As Kees has already picked this up this is quite possibly silly.
> >> But *shrug* that was when I was out.
> > 
> > I've updated the trailers. Thanks for the review!
> 
> Hi Kees,
> 
> Thanks! I think you added it to the wrong commit though.

Ugh. Time for more coffee. Thanks; fixed. I need to update my "b4" -- it
was hanging doing the trailers update so I did it myself manually...
That'll teach me. ;)

> tests. Since all the other tests pass, I'm just going to leave it at
> that.

Yeah, I think you're good. Thank you for taking the time to test rr!

-- 
Kees Cook


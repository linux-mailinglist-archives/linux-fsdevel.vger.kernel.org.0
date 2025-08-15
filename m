Return-Path: <linux-fsdevel+bounces-58029-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E7D7B2819B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Aug 2025 16:25:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E1A2E3B0DD4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Aug 2025 14:25:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA343225765;
	Fri, 15 Aug 2025 14:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LYMz9gcS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37A1622333D;
	Fri, 15 Aug 2025 14:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755267944; cv=none; b=KBKHlA53RS6xUL03+bLqfX23pXhwvc3ds3hiuDWk0cdb7fZpnTDUHhvGKkEGcDKh5yxOtJ8yHUvtKA96coRW5wpwVCNOJkN/irp9UCdmUH6RSUo3TcrceowwQsezPd7efIgFTDK18x5mlMVF/8b63Gf4S7xs3duu+lCsRPAdQAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755267944; c=relaxed/simple;
	bh=IZndjDUGqtf8qtTgBD7buye/s0ai0XN3SlKIaNaEeUg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KBL+v8gBfZGH6KdVVJIz4n+PnZ3K+zSQoIzliQ4cx6mNGK4B67XO5lThMtQCydMS5NdApcDEeYf3P0JpopXbevf2Mu8vXnBaMCvt9IU1dq+bQklQPBaU6jWFfJZfVw7JTDruzJ6+1th4ufbXrV2FUeJZtZSDKdaejXnVR6u7eBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LYMz9gcS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58D40C4CEEB;
	Fri, 15 Aug 2025 14:25:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755267943;
	bh=IZndjDUGqtf8qtTgBD7buye/s0ai0XN3SlKIaNaEeUg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LYMz9gcShwpMMEiSo1WWYlkuM6E6kInrV6Orrl+JK6yk+Nmb+ijdYckIwQMbcFNfQ
	 K6JY4LCJjGuxU19K6lhWn7JGx64MrXiXBPUbjankFoUaJLuutbAjbUfJek1z101hVZ
	 lVkptAmAoeaI1Oadk7bEdUJWvBYWFw5vfQZ7dlREPuHGXt2ZV4j2DOq10T94SrKIF/
	 W4ha2iCGy5MT1UjKcFAUTnJNPl1PVEs4pNPIia6uskrefrJtsoZ4k9mX7gs5XBB4CK
	 1rWslMwRVoFSeCggAdB93nlk++9zly/qqTLOp4SJLt7MCQoljkpLe+L2HEfUAB1qtF
	 Nx4ukXSNcVIvQ==
Date: Fri, 15 Aug 2025 16:25:36 +0200
From: Christian Brauner <brauner@kernel.org>
To: Daniel Gomez <da.gomez@kernel.org>
Cc: Vlastimil Babka <vbabka@suse.cz>, 
	Christoph Hellwig <hch@infradead.org>, Peter Zijlstra <peterz@infradead.org>, 
	David Hildenbrand <david@redhat.com>, Shivank Garg <shivankg@amd.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Jiri Slaby (SUSE)" <jirislaby@kernel.org>, 
	Stephen Rothwell <sfr@canb.auug.org.au>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-modules@vger.kernel.org, linux-kbuild@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	Nicolas Schier <nicolas.schier@linux.dev>, Daniel Gomez <da.gomez@samsung.com>, 
	Linus Torvalds <torvalds@linux-foundation.org>, Matthias Maennich <maennich@google.com>, 
	Jonathan Corbet <corbet@lwn.net>, Luis Chamberlain <mcgrof@kernel.org>, 
	Petr Pavlu <petr.pavlu@suse.com>, Sami Tolvanen <samitolvanen@google.com>, 
	Nathan Chancellor <nathan@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Jan Kara <jack@suse.cz>
Subject: Re: [PATCH v4] module: Rename EXPORT_SYMBOL_GPL_FOR_MODULES to
 EXPORT_SYMBOL_FOR_MODULES
Message-ID: <20250815-darstellen-pappen-90a9edb193e5@brauner>
References: <20250808-export_modules-v4-1-426945bcc5e1@suse.cz>
 <20250811-wachen-formel-29492e81ee59@brauner>
 <2472a139-064c-4381-bc6e-a69245be01df@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2472a139-064c-4381-bc6e-a69245be01df@kernel.org>

On Tue, Aug 12, 2025 at 09:54:43AM +0200, Daniel Gomez wrote:
> On 11/08/2025 07.18, Christian Brauner wrote:
> > On Fri, 08 Aug 2025 15:28:47 +0200, Vlastimil Babka wrote:
> >> Christoph suggested that the explicit _GPL_ can be dropped from the
> >> module namespace export macro, as it's intended for in-tree modules
> >> only. It would be possible to restrict it technically, but it was
> >> pointed out [2] that some cases of using an out-of-tree build of an
> >> in-tree module with the same name are legitimate. But in that case those
> >> also have to be GPL anyway so it's unnecessary to spell it out in the
> >> macro name.
> >>
> >> [...]
> > 
> > Ok, so last I remember we said that this is going upstream rather sooner
> > than later before we keep piling on users. If that's still the case I'll
> > take it via vfs.fixes unless I hear objections.
> 
> This used to go through Masahiro's kbuild tree. However, since he is not
> available anymore [1] I think it makes sense that this goes through the modules
> tree. The only reason we waited until rc1 was released was because of Greg's
> advise [2]. Let me know if that makes sense to you and if so, I'll merge this
> ASAP.

At this point it would mean messing up all of vfs.fixes to drop it from
there. So I'd just leave it in there and send it to Linus. Next time
I know where it'll end up.


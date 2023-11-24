Return-Path: <linux-fsdevel+bounces-3685-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD98D7F7877
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Nov 2023 17:02:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B2FB1C20D40
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Nov 2023 16:02:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DD6333CC4;
	Fri, 24 Nov 2023 16:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rPTG2Rvj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5A2C33098
	for <linux-fsdevel@vger.kernel.org>; Fri, 24 Nov 2023 16:02:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBF82C433C7;
	Fri, 24 Nov 2023 16:02:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700841726;
	bh=margAB1FzEUm28u+SgniGfAuXbnIN6dTK7wX7ICYgeE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rPTG2RvjkMuXUNhYhCCpRkG9RWlYusNzNY8XVGNsFSwmwojcfr807/m/8S1bsnSL3
	 RS87G+2bFn/fJXYKzCSGpYaqm56tO+XtMYAoe0Mpur3NGPNMMo6rwxsEFbQ1KKNC7j
	 wOYT5+m+P1LFDRfeUDcax3hvJQzZR4dXyrXlMfjrnfEHSbEajqd2fTCpCCcnQYSgCB
	 OwjMNCiCQKmkCleo77Z2TJXIHLZ5ADqSqPU/4o6OlaPOMkeYShs7bIq9AIgv3ACpW4
	 MG83wjLWH/KRYQCA+JmD6cLfisi16jk7pCNDbuUFglJXvsrSKrmO3z5Y6IWppJdbKN
	 aFAPCO4rEbksw==
Date: Fri, 24 Nov 2023 17:02:02 +0100
From: Christian Brauner <brauner@kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: Jann Horn <jannh@google.com>, Alexander Viro <viro@zeniv.linux.org.uk>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH] fs/pipe: Fix lockdep false-positive in watchqueue
 pipe_write()
Message-ID: <20231124-gearbeitet-unberechenbar-70241992a995@brauner>
References: <20231124150822.2121798-1-jannh@google.com>
 <1210483.1700841227@warthog.procyon.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1210483.1700841227@warthog.procyon.org.uk>

On Fri, Nov 24, 2023 at 03:53:47PM +0000, David Howells wrote:
> Jann Horn <jannh@google.com> wrote:
> 
> > +	/*
> > +	 * Reject writing to watch queue pipes before the point where we lock
> > +	 * the pipe.
> > +	 * Otherwise, lockdep would be unhappy if the caller already has another
> > +	 * pipe locked.
> > +	 * If we had to support locking a normal pipe and a notification pipe at
> > +	 * the same time, we could set up lockdep annotations for that, but
> > +	 * since we don't actually need that, it's simpler to just bail here.
> > +	 */
> > +	if (pipe_has_watch_queue(pipe))
> > +		return -EXDEV;
> > +
> 
> Linus wanted it to be possible for the user to write to a notificaiton pipe.

Since it has been disabled from the start and nothing has ever actually
materialized we just don't need to care. If we start caring this needs
more work anyway iirc.


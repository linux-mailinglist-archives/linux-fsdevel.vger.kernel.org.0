Return-Path: <linux-fsdevel+bounces-3813-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E7B57F8B17
	for <lists+linux-fsdevel@lfdr.de>; Sat, 25 Nov 2023 14:11:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6BA2FB212C2
	for <lists+linux-fsdevel@lfdr.de>; Sat, 25 Nov 2023 13:11:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86DEA10957;
	Sat, 25 Nov 2023 13:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tdemR95S"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C315D63BD
	for <linux-fsdevel@vger.kernel.org>; Sat, 25 Nov 2023 13:10:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DE46C433C7;
	Sat, 25 Nov 2023 13:10:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700917856;
	bh=7j6ntO1H0+nqJqtu3V8a5oFSFshosbKcXWeIEXFbRjk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tdemR95SUNaQqW0vqdigJ4y5z3gGC/BgDa4iFeJm8SBWuk+BIJjuz6EyKrVurqtuk
	 C7Yk/+fGqOjFqYziZR4ShXtNygezEHphRlCZa+0HobMNnLOE9qnezQINirFvkGw7qE
	 nCqrGyyJV3vGn16TH+HB7oyOfnCC1xqDvQpcfEbOUgCoZDabcJ+mtKmS4zZakVKG8v
	 jFNbrni8VJH4SJ5btGj1wX3m3jxTEdl3aKIWHjutsN7m9LfyFJYwkcDZWHm5dN/+zp
	 xSwvjndO4idNLfWkxX8OythL0/+Aexaec3YSZk4txeySzMlR7Gsr1LxHnOIASI5cIF
	 yT/ksRq1H0Wiw==
Date: Sat, 25 Nov 2023 14:10:52 +0100
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Omar Sandoval <osandov@fb.com>, David Howells <dhowells@redhat.com>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] vfs fixes
Message-ID: <20231125-manifest-hinauf-7007f16894b6@brauner>
References: <20231124-vfs-fixes-3420a81c0abe@brauner>
 <CAHk-=wiJFsu70BqrgxtoAfMHeJVJMfsWzQ42PXFduGNhFSVGDA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=wiJFsu70BqrgxtoAfMHeJVJMfsWzQ42PXFduGNhFSVGDA@mail.gmail.com>

On Fri, Nov 24, 2023 at 10:25:15AM -0800, Linus Torvalds wrote:
> On Fri, 24 Nov 2023 at 02:28, Christian Brauner <brauner@kernel.org> wrote:
> >
> > * Fix a bug introduced with the iov_iter rework from last cycle.
> >
> >   This broke /proc/kcore by copying too much and without the correct
> >   offset.
> 
> Ugh. I think the whole /proc/kcore vmalloc handling is just COMPLETELY broken.

Ugh, I didn't even look at that closely because the fix was obviously
correct for that helper alone. Let's try and just return zeroed memory
like you suggested in your last mail before we bother fixing any of
this.

Long-term plan, it'd be nice to just get distros to start turning
/proc/kcore off. Maybe I underestimate legitimate users but this
requires CAP_SYS_RAW_IO so it really can only be useful to pretty
privileged stuff anyway.


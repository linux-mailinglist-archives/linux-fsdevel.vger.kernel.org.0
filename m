Return-Path: <linux-fsdevel+bounces-820-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5839A7D0E3B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Oct 2023 13:14:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC36A2823E0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Oct 2023 11:14:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59B9218E00;
	Fri, 20 Oct 2023 11:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DJUsAE3i"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8183A18C11
	for <linux-fsdevel@vger.kernel.org>; Fri, 20 Oct 2023 11:14:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F1E9C433C8;
	Fri, 20 Oct 2023 11:14:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697800477;
	bh=M8Sj1iq6gHWICvyY7V5UlksJucFiOAv+3a6dS9C+5Bg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DJUsAE3i4sf1qzoMlcLNxkj6QHd4y6ngFBOTh9Fi8zVHSTZi5aMMnVgTJh/V4CW7n
	 5RnvSpXe3rwLILWIrkl3d+lmwDDoiL5YjwlF2D6TESeT+FA5Ek4c/E+ovsZjXhAISS
	 +bmLGLlA66KZqb9w7cEAoD0YuoEJTu37EoH9PG4WKr9qaQ0P5CV2KOY5rzY7CBJJd5
	 gYbBbY3JHGTQBNcu01kkEfax2w1+1tn6nt6zBtWsl3Dc9HjJqzWnKyHnqxY4dXyhyf
	 2Xlr0AKQ7+V2a8kEecLU/Tt69rqM2o8nQsitOXEE+rIE/2lZIW4LQt0Y5cxiar/rpD
	 KFWXXdfLR8zyQ==
Date: Fri, 20 Oct 2023 13:14:32 +0200
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] vfs fixes
Message-ID: <20231020-abringen-gesurft-5691e5a997ec@brauner>
References: <20231019-kampfsport-metapher-e5211d7be247@brauner>
 <CAHk-=whBXdLJ=QDpYmDEH-Tn71dXasGJSX4Jz4qMo8V4-7vYkg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=whBXdLJ=QDpYmDEH-Tn71dXasGJSX4Jz4qMo8V4-7vYkg@mail.gmail.com>

> Ouch. That filename ref by audit was always supposed to be
> thread-local in a "for this system call" kind of sense.

Yeah, I wasn't happy when that bug showed up.

> That said, using atomics for reference counting is our default
> behavior and should be normal, so the patch isn't wrong, it's just
> annoying since getname/putname is very much in the critical path of
> filename handling.

Yeah.

> That said, the extra atomics are hopefully not really noticeable.
> 
> Some people might want to use the non-refcounted version (ie we have
> getname/putname used by ksmbd too, for example), if they really care.
> 
> It already exists, as __getname/__putname.
> 
> But the normal open/stat/etc system call paths are obviously now going
> to hit those extra atomics. Not lovely, but I guess it's the best we
> can do.

I didn't spend too much time on this issue because it's -rc7 and the
straightforward seemed ok, if annoying.

But if we really really really really cared we could probably do a
deranged thing and massage both audit and io_uring to allows us to
separate the regular system call getname from the io_uring getname. But
I think that would be ugly and likely error prone.


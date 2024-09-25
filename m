Return-Path: <linux-fsdevel+bounces-30102-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C7DB98622A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Sep 2024 17:09:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D69E1C27333
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Sep 2024 15:09:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2261F1428F1;
	Wed, 25 Sep 2024 14:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X+jLjo4O"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80F88381B1
	for <linux-fsdevel@vger.kernel.org>; Wed, 25 Sep 2024 14:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727276210; cv=none; b=cwE7fwQ+teHHHw1X7wqC6foc5Z8PfC6s58sAANgacvTnV5h1xsGyd0eZc9sEk/dSf0u2EDNVkMABtN45+ZAJmW1eh1mXmRS4yP15KwKmaovWtjhqCiIKcPCYRUbqT8KNONQuMs2JXTctrVFpf78+PH8pXNYv66ghCZ2VC3MUWCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727276210; c=relaxed/simple;
	bh=9sbHkqZmmSpAA4pqH0WQoU6SA7608SmkOLGH4uoTlj0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cJhxZGlJJvabO5PRE4XWdeOS0VJtSb4QX/exG3dxGDtLsOBIQt5m9Jy4oGNwzCwwjAHxfQG75dyQmWdX5C2JlySY3zfu9CQz1PMPG+v0DNp+li4JFHWvlkaNy+qDKOpD0uf51Sk51/sAdfuXJg9NkBa8utlQKvbTnV+ACJ6wjD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X+jLjo4O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFA15C4CEC3;
	Wed, 25 Sep 2024 14:56:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727276210;
	bh=9sbHkqZmmSpAA4pqH0WQoU6SA7608SmkOLGH4uoTlj0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=X+jLjo4O/HSOgy0TOuLwd41Uo0MJMLuycg3p8oicGlpFzf+quhJRKdRL7XTkOTZtt
	 ovKsmUGJXzu8bXBK6+/lm9grlbFFQyU1mCF6HVa5J4+BFndyYxIZJDtFc/0Abgx+lE
	 MOfDZ02ynr4cs1jqDeDn9IjQ0yjBPjpxsIu2bXX/TlfavYF1H+D2J4FlSC/2Nin8pw
	 5aGTW1hPIVXNTS3z6k5ituCM4BJDYrJoZMBCyNi/aewW9PPgw7Bpi3qoKmVJ6VEyre
	 /DSgeGR0p56sxjXtOuSfOTrF1lDQehWGIunNTAX9jEdUCToNaOH4JBVrIk08LZ76oe
	 N6BLLF8VllCvA==
Date: Wed, 25 Sep 2024 16:56:46 +0200
From: Christian Brauner <brauner@kernel.org>
To: Jan Kara <jack@suse.cz>
Cc: linux-fsdevel@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	viro@zeniv.linux.org.uk, syzbot+3b6b32dc50537a49bb4a@syzkaller.appspotmail.com
Subject: Re: [PATCH] epoll: annotate racy check
Message-ID: <20240925-jagdsaison-fachzeitschrift-8ebe66af6a90@brauner>
References: <20240925-fungieren-anbauen-79b334b00542@brauner>
 <20240925111516.rb7x7btig74y7nj3@quack3>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240925111516.rb7x7btig74y7nj3@quack3>

On Wed, Sep 25, 2024 at 01:15:16PM GMT, Jan Kara wrote:
> On Wed 25-09-24 11:05:16, Christian Brauner wrote:
> > Epoll relies on a racy fastpath check during __fput() in
> > eventpoll_release() to avoid the hit of pointlessly acquiring a
> > semaphore. Annotate that race by using WRITE_ONCE() and READ_ONCE().
> > 
> > Link: https://lore.kernel.org/r/66edfb3c.050a0220.3195df.001a.GAE@google.com
> > Reported-by: syzbot+3b6b32dc50537a49bb4a@syzkaller.appspotmail.com
> > Signed-off-by: Christian Brauner <brauner@kernel.org>
> > ---
> >  fs/eventpoll.c            | 3 ++-
> >  include/linux/eventpoll.h | 2 +-
> >  2 files changed, 3 insertions(+), 2 deletions(-)
> > 
> > diff --git a/fs/eventpoll.c b/fs/eventpoll.c
> > index f53ca4f7fced..fa766695f886 100644
> > --- a/fs/eventpoll.c
> > +++ b/fs/eventpoll.c
> > @@ -823,7 +823,8 @@ static bool __ep_remove(struct eventpoll *ep, struct epitem *epi, bool force)
> >  	to_free = NULL;
> >  	head = file->f_ep;
> >  	if (head->first == &epi->fllink && !epi->fllink.next) {
> > -		file->f_ep = NULL;
> > +		/* See eventpoll_release() for details. */
> > +		WRITE_ONCE(file->f_ep, NULL);
> 
> There's one more write to file->f_ep in attach_epitem() which needs
> WRITE_ONCE() as well to match the READ_ONCE() in other places. Otherwise

Thanks, done!

> feel free to add:
> 
> Reviewed-by: Jan Kara <jack@suse.cz>

Thanks!


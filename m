Return-Path: <linux-fsdevel+bounces-22358-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 80C00916985
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Jun 2024 15:55:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 39C9C281CF9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Jun 2024 13:55:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2E97161936;
	Tue, 25 Jun 2024 13:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WTzT5SPl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 323631607B0
	for <linux-fsdevel@vger.kernel.org>; Tue, 25 Jun 2024 13:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719323716; cv=none; b=M2hWIPMyVBlMD/l/9Tla5/TM/VR+OXZgBd8FfxPL/I5xQiczqV9GdLdCvm1udOvWCITHAy3RjaEcB1s+ES7/Bi9orHkaf6Zz7tsFKEDd92femB7oTyty3zEQZo7F8DnuQpnTlGfBbH5Z/Y7IPFzYhdxlEKK7IyfDfDIu8o9g3Vw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719323716; c=relaxed/simple;
	bh=af2aOuPdV0JDwueTox0DesDfntZYxv7AMKWSQBKhr5w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CAzCHwoTvXJ8FDgUGnGayopq7016UY5SSDYE1ZlIIO322dihJHdWxqNSquRHha8DDwNwubRXpMQCvIP2lnIcbu0gQJQUc1P4tJt7xzAb+FjpkEAX1lvSfVur0r1/YpaQwhC0ukrwkWC3khNBqARvsHxWx323EY1BUdOgsUJT144=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WTzT5SPl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54A2AC32786;
	Tue, 25 Jun 2024 13:55:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719323715;
	bh=af2aOuPdV0JDwueTox0DesDfntZYxv7AMKWSQBKhr5w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WTzT5SPlb5UU57cxJTC1zDwXG7ig4nGIk4be26PhOsi6dLsdopBbYd2GXjn+jEvEE
	 anbWmX/aaOoe+H9BmC5e+ZYxIFhS4Vt6pUxNkujWwBn+rhjdIILHmuVJ40eZdmXHic
	 dZIfTNiqIA7Z87nDJ3eWqNF5XiKHR4QtJtU/y/zJU5woAUEP6NODBOJkG19OEHq+P5
	 u6bcta/GEwp1ZJ6BQ0R0f/+1eoY6tXiqffgi6QGQGxwvfZg5FjItc0HtN7QA4Hj6gg
	 lEt95Je+58accJcE+AReWP0M5V6VcZDalbhhvbhcwdQ53058MiI33Wizm//uD8CqWO
	 Pvlg8hpknDgtw==
Date: Tue, 25 Jun 2024 15:55:11 +0200
From: Christian Brauner <brauner@kernel.org>
To: Karel Zak <kzak@redhat.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, Josef Bacik <josef@toxicpanda.com>, 
	linux-fsdevel@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH 0/4] Add the ability to query mount options in statmount
Message-ID: <20240625-vorfahren-unbehagen-64b37c23700c@brauner>
References: <cover.1719257716.git.josef@toxicpanda.com>
 <20240625-tragbar-sitzgelegenheit-48f310320058@brauner>
 <20240625130008.GA2945924@perftesting>
 <CAJfpeguAarrLmXq+54Tj3Bf3+5uhq4kXOfVytEAOmh8RpUDE6w@mail.gmail.com>
 <20240625-beackern-bahnstation-290299dade30@brauner>
 <5j2codcdntgdt4wpvzgbadg4r5obckor37kk4sglora2qv5kwu@wsezhlieuduj>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5j2codcdntgdt4wpvzgbadg4r5obckor37kk4sglora2qv5kwu@wsezhlieuduj>

On Tue, Jun 25, 2024 at 03:52:03PM GMT, Karel Zak wrote:
> On Tue, Jun 25, 2024 at 03:35:17PM GMT, Christian Brauner wrote:
> > On Tue, Jun 25, 2024 at 03:04:40PM GMT, Miklos Szeredi wrote:
> > > On Tue, 25 Jun 2024 at 15:00, Josef Bacik <josef@toxicpanda.com> wrote:
> > > 
> > > > We could go this way I suppose, but again this is a lot of work, and honestly I
> > > > just want to log mount options into some database so I can go looking for people
> > > > doing weird shit on my giant fleet of machines/containers.  Would the iter thing
> > > > make the overlayfs thing better?  Yeah for sure.  Do we care?  I don't think so,
> > > > we just want all the options, and we can all strsep/strtok with a comma.
> > > 
> > > I think we can live with the monolithic option block.  However I'd
> > > prefer the separator to be a null character, thus the options could be
> > > sent unescaped.  That way the iterator will be a lot simpler to
> > > implement.
> > 
> > For libmount it means writing a new parser and Karel prefers the ","
> > format so I would like to keep the current format.
>  
> Sorry for the misunderstanding. I had a chat with Christian about it
> when I was out of my office (and phone chats are not ideal for this).
> 
> I thought Miklos had suggested using a space (" ") as the separator, but
> after reading the entire email thread, I now understand that Miklos'
> suggestion is to use \0 (zero) as the options separator.
> 
> I have no issue with using \0, as it will make things much simpler.

Ah, I misread that myself. Fine by me.


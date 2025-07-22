Return-Path: <linux-fsdevel+bounces-55655-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B40AB0D501
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Jul 2025 10:53:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 462E5AA0A5B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Jul 2025 08:53:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ADD72D97A2;
	Tue, 22 Jul 2025 08:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Fxwv+pY9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C66121C178;
	Tue, 22 Jul 2025 08:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753174400; cv=none; b=pUjZjI81SSp7isLOYAocOaAIvvrFiv4ahZt/+KvbqqGcIsnwaXxlzgMk45sS0WJ/8qJTVxYi8osQ+CcpTkbDTj93npuO7HKPT3lcYvrA04sxVQwE4PhASe9/05qqdsFl6sMPqHVx4wTDYAeQTyqOkYVq7wgPSFUW2Dj3gHHruBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753174400; c=relaxed/simple;
	bh=LIgm7MYVKFyNqnPEDEWOXJrkPP+VHDItG+qZ/AuDuPw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m4zV+vJ0zHo32rSQ+a9MBplXK7zRCEmZhxTLYCgUSgQp4wOFS9ZHGNY6J/I3uOmla6m9ZknWoAyqAN7sumsrY/JrH35vcC3+sbHizmRR1M485Ezj1us0/cnmIchMvrn0CwhxRhcc+SO0yRvSxjSP3+90JnhTkZuO6Fqpv5b40+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Fxwv+pY9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EE2CC4CEEB;
	Tue, 22 Jul 2025 08:53:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1753174399;
	bh=LIgm7MYVKFyNqnPEDEWOXJrkPP+VHDItG+qZ/AuDuPw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Fxwv+pY9oovWwqYn5pWnoVVG5XcuGGR0IhD5/MBGY3MneBTI11aH/JyzgQQpyIDQR
	 zajP2Ok4TldR/u1rCqzASioC9/F8A8esyYRxJ6XaMlmonZKwE3w9mMp14aVU5Yv0OH
	 tDJ9r+Jhq3M9AKYX9RCSebz5A4XT7cXKwfos/+nc=
Date: Tue, 22 Jul 2025 10:53:16 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Daniel Gomez <da.gomez@kernel.org>,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
	Stephen Rothwell <sfr@canb.auug.org.au>,
	Daniel Gomez <da.gomez@samsung.com>,
	Matthias Maennich <maennich@google.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Sami Tolvanen <samitolvanen@google.com>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nicolas Schier <nicolas.schier@linux.dev>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Christoph Hellwig <hch@infradead.org>,
	Peter Zijlstra <peterz@infradead.org>,
	David Hildenbrand <david@redhat.com>,
	Shivank Garg <shivankg@amd.com>, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org,
	linux-kbuild@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v3] module: Rename EXPORT_SYMBOL_GPL_FOR_MODULES to
 EXPORT_SYMBOL_FOR_MODULES
Message-ID: <2025072246-unexpired-deletion-a0f8@gregkh>
References: <20250715-export_modules-v3-1-11fffc67dff7@suse.cz>
 <b340eb9f-a336-461c-befe-6b09c68b731e@kernel.org>
 <24f995fe-df76-4495-b9c6-9339b6afa6be@suse.cz>
 <49eeff09-993f-42a0-8e3b-b3f95b41dbcf@kernel.org>
 <2025072219-dollhouse-margarita-de67@gregkh>
 <9d61a747-2655-4f4c-a8fe-5db51ff33ff7@suse.cz>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9d61a747-2655-4f4c-a8fe-5db51ff33ff7@suse.cz>

On Tue, Jul 22, 2025 at 10:49:48AM +0200, Vlastimil Babka wrote:
> On 7/22/25 10:46, Greg Kroah-Hartman wrote:
> > On Tue, Jul 22, 2025 at 10:26:43AM +0200, Daniel Gomez wrote:
> >> > 
> >> > Maybe with no reply, you can queue it then?
> >> 
> >> + Jiri, Stephen and Greg, added to the To: list.
> >> 
> >> EXPORT_SYMBOL_GPL_FOR_MODULES macro was merged [1] through Masahiro's
> >> pull request in v6.16-rc1. This patch from Vlastimil renames the macro to
> >> EXPORT_SYMBOL_FOR_MODULES. This means Jiri's patch b20d6576cdb3 "serial: 8250:
> >> export RSA functions" will need to be updated accordingly. I'd like like to
> >> know how you prefer to proceed, since it was requested to have this merged as a
> >> fix before Linus releases a new kernel with the former name.
> > 
> > So you want this in 6.16-final?  Ok, do so and then someone needs to fix
> > up the build breakage in linux-next and in all of the pull requests to
> > Linus for 6.17-rc1 :)
> > 
> >> Link: https://lore.kernel.org/all/CAK7LNAQunzxOHR+vMZLf8kqxyRtLx-Z2G2VZquJmndrT9TZjiQ@mail.gmail.com/ [1]
> >> 
> >> 
> >> Masahiro, just a heads-up that I plan to merge this through the linux-modules
> >> tree unless you advise otherwise.
> > 
> > Why not just do the rename after 6.17-rc1 is out?  That way all new
> > users will be able to be caught at that point in time.  There's no issue
> 
> Hm there might be people basing their new exports for 6.18 on 6.17-rc1. They
> would have to be told to use rc2 then.

Yes, that's normal, nothing wrong with that at all, we make api name
changes across the tree quite often (i.e. almost every-other release.)

> Maybe the best way would be if Linus
> did this just before tagging rc1, while fixing up all users merged during
> the merge window?

Again, what's wrong with -rc2?  Anyone caught using this on only -rc1
will get a quick "this broke the build" report in linux-next so it's not
like this is going to be unnoticed at all.

thanks,

greg k-h


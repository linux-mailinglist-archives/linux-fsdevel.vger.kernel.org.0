Return-Path: <linux-fsdevel+bounces-16673-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AE038A1493
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Apr 2024 14:26:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DB3CAB21A65
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Apr 2024 12:26:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E87E114D28A;
	Thu, 11 Apr 2024 12:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NMzqooGb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DA8D14C58E;
	Thu, 11 Apr 2024 12:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712838316; cv=none; b=iZOrcPmWRkfY3G8TgSxyGRR9gJ9/E+EIp+v5SZvuZt0ED0+jPIZUpVDHkPD531gBviAtSSi7L9M8bJ2aU5huo7GLfr7rta6Na8Oy6pJjB9+OlmytlhYOJgeEsZd3vwYmt7PMPbWCjsq8TvopUv5lpZRVzFxyssLwuO0gu490p8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712838316; c=relaxed/simple;
	bh=aohTe/5BUf2j0WTU/Tb8M1ao1SPHAhY0rWZFFRvQq70=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p3TDJDHlMDNplM3Mr+bA3RSTuDLVufcJ/SO6ByLzCq8rhZd2V+vI/SvsPYboMyr0AfHbDyyydAMWrfjXUBhbpYo9Rd3MVdQ/eW8BMT145jafapmAVTvNjgTXp3ZIZ/BvyY/SQP1FHRHnUqoaS0SBhcYvHsghevDkFLWZcYaxVfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NMzqooGb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A4ECC433C7;
	Thu, 11 Apr 2024 12:25:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712838315;
	bh=aohTe/5BUf2j0WTU/Tb8M1ao1SPHAhY0rWZFFRvQq70=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NMzqooGb0Q7tyAo2CNJZtyGy3w87FSaJXtQZM/CIf/i+wMhpJrYT4i/d4AIq3QsEQ
	 /Yt+kfc4LAD9Pdxj+7frOiZiLvaEdLqYwRowCIlhm4IGj3H8e2xhfTz7SHruDfN9Pd
	 jV5JyQKSLZfA/HOxhIY0giYZFO0/upBxek+Cv7T9szNLrbELvZAx8ajnVjavVKdn16
	 Xl4SF8bflCCrxHqgYLQG7XSFSZBz60xsDrUeZlqmBJMgO9IJ1C095nU0wtRyPW96yK
	 L7BP7E4E0wuhN9P3kYH0VAYZ5sL1+PB0w6p6PmJnPCa1E5VCNryGXyTifOEImGBf3P
	 o7YT/ugjj/xHg==
Date: Thu, 11 Apr 2024 14:25:10 +0200
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Andrew Lutomirski <luto@kernel.org>, Peter Anvin <hpa@zytor.com>
Subject: Re: [PATCH] vfs: relax linkat() AT_EMPTY_PATH - aka flink() -
 requirements
Message-ID: <20240411-adressieren-preschen-9ed276614069@brauner>
References: <20240411001012.12513-1-torvalds@linux-foundation.org>
 <CAHk-=wiaoij30cnx=jfvg=Br3YTxhQjp4VWRc6=xYE2=+EVRPg@mail.gmail.com>
 <20240411-alben-kocht-219170e9dc99@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240411-alben-kocht-219170e9dc99@brauner>

On Thu, Apr 11, 2024 at 11:04:59AM +0200, Christian Brauner wrote:
> On Wed, Apr 10, 2024 at 07:39:49PM -0700, Linus Torvalds wrote:
> > On Wed, 10 Apr 2024 at 17:10, Linus Torvalds
> > <torvalds@linux-foundation.org> wrote:
> > >
> > > +               if (flags & LOOKUP_DFD_MATCH_CREDS) {
> > > +                       if (f.file->f_cred != current_cred() &&
> > > +                           !capable(CAP_DAC_READ_SEARCH)) {
> > > +                               fdput(f);
> > > +                               return ERR_PTR(-ENOENT);
> > > +                       }
> > > +               }
> > 
> > Side note: I suspect that this could possibly be relaxed further, by
> > making the rule be that if something has been explicitly opened to be
> > used as a path (ie O_PATH was used at open time), we can link to it
> > even across different credentials.
> 
> I had a similar discussion a while back someone requested that we relax
> permissions so linkat can be used in containers. And I drafted the
> following patch back then:
> 
> https://lore.kernel.org/all/20231113-undenkbar-gediegen-efde5f1c34bc@brauner
> 
> IOW, I had intended to make this work with containers so that we check
> CAP_DAC_READ_SEARCH in the namespace of the opener of the file. My
> thinking had been that this can serve as a way to say "Hey, I could've
> opened this file in the openers namespace therefore let me make a path
> to it.". I didn't actually send it because I thought the original author
> would but imho, that would be a worthwhile addition to your patch if
> this makes sense...

For example, say someone opened an O_PATH fd in the initial user ns and
then send that file over an AF_UNIX socket to some other container the
ns_capable(f_cred->user_ns, CAP_DAC_READ_SEARCH) would always be false.
The other way around though would work. Which imho is exactly what we
want to make such cross-container interactions with linkat() safe.

And this didn't aim to solve the problem of allowing unprivileged users
in the initial namespace to do linkat(), of course which yours does.

Btw, I think we should try to avoid putting this into path_init() and
confine this to linkat() itself imho. The way I tried to do it was by
presetting a root for filename_lookup(); means we also don't need a
LOOKUP_* flag for this as this is mostly a linkat thing.

So maybe your suggestion combined with my own attempt would make this
work for unprivileged users and containers?

if (f.file->f_cred != current_cred() &&
    !ns_capable(f.file->f_cred->user_ns, CAP_DAC_READ_SEARCH))

Worst case we get a repeat of the revert and get to make this a 10 year
anniversary patch attempt?


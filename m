Return-Path: <linux-fsdevel+bounces-58281-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 400F8B2BDCA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Aug 2025 11:45:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9BAD87AA643
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Aug 2025 09:43:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 272F231A079;
	Tue, 19 Aug 2025 09:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n0tVvonW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71E69274666;
	Tue, 19 Aug 2025 09:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755596697; cv=none; b=f1VhxVYgb8GJ5tRkzPcZJTxoI7gIe6q3m6vnAVeXMIRhoeDpdbfJkqYygeHyjBG8NMOIMZD4UciHKsB2PT+vt6YVYVTQTpxb9/bCOWhG+tRPylX3Pw8FX0AEOJFhxepSiqEzKsEPDOir6+GrjrtsbEoXXoLQFTPLlHoMb1sgwwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755596697; c=relaxed/simple;
	bh=qkoSavUo25iuaFyv6MbaWJ1hYMagYZR2yJl9AnwGilk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BxDkymUe4eJmOU67++/b1t+Z+efaNpqmwDp55ZFMMrJeQNtFHmK/zbPvjv2S1ivmc1dwC2Q9aCYZxXxlRH1TYj85h7vw3s4T++CeDLILdn85Ma8LHplcuY/Tk6mFpFDM+goycoAAZjwjal2cXuDUkTCUHOpkKwl4CoR2aKqOdo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n0tVvonW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A37EC4CEF1;
	Tue, 19 Aug 2025 09:44:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755596697;
	bh=qkoSavUo25iuaFyv6MbaWJ1hYMagYZR2yJl9AnwGilk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=n0tVvonWE1oEyrGMBnKN7BtdvUYyXYUQ+yYnW91g4LS7S3b+Wic8ckZOkm2c0LQgR
	 W3HpDgxJO3Izhz3SyUlED62hj5dA4ADph7+TZn1CfpcnL1QG2Bfj11Tt4C1oyxNtNS
	 /H+5TlR76OOTKY6AI8bjUTwfmcr4T6EEcBiPOOAKLNWGu5eKrY4LT2T29dcoyt7OJN
	 +CXdYIgO/f1SDXr1D5sF+9nefcAflvmgiFFWSy9N73q7Rqk5Y/nVk/HdKlZpnYmlqU
	 Z+nm9okydm70LTdECMr3tBB+Vn2TrfHNwSC8FvOfv3kbPl/POtg1n8TBtQ9q2QJ2rD
	 XQ2BbTozJRPLA==
Date: Tue, 19 Aug 2025 11:44:48 +0200
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
Message-ID: <20250819-vorgibt-bewalden-d16b7673cc72@brauner>
References: <20250808-export_modules-v4-1-426945bcc5e1@suse.cz>
 <20250811-wachen-formel-29492e81ee59@brauner>
 <2472a139-064c-4381-bc6e-a69245be01df@kernel.org>
 <20250815-darstellen-pappen-90a9edb193e5@brauner>
 <6cce2564-04f2-44ab-96d3-2f47fc221591@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <6cce2564-04f2-44ab-96d3-2f47fc221591@kernel.org>

On Fri, Aug 15, 2025 at 05:39:54PM +0200, Daniel Gomez wrote:
> 
> 
> On 15/08/2025 07.25, Christian Brauner wrote:
> > On Tue, Aug 12, 2025 at 09:54:43AM +0200, Daniel Gomez wrote:
> >> On 11/08/2025 07.18, Christian Brauner wrote:j
> >>> On Fri, 08 Aug 2025 15:28:47 +0200, Vlastimil Babka wrote:
> >>>> Christoph suggested that the explicit _GPL_ can be dropped from the
> >>>> module namespace export macro, as it's intended for in-tree modules
> >>>> only. It would be possible to restrict it technically, but it was
> >>>> pointed out [2] that some cases of using an out-of-tree build of an
> >>>> in-tree module with the same name are legitimate. But in that case those
> >>>> also have to be GPL anyway so it's unnecessary to spell it out in the
> >>>> macro name.
> >>>>
> >>>> [...]
> >>>
> >>> Ok, so last I remember we said that this is going upstream rather sooner
> >>> than later before we keep piling on users. If that's still the case I'll
> >>> take it via vfs.fixes unless I hear objections.
> >>
> >> This used to go through Masahiro's kbuild tree. However, since he is not
> >> available anymore [1] I think it makes sense that this goes through the modules
> >> tree. The only reason we waited until rc1 was released was because of Greg's
> >> advise [2]. Let me know if that makes sense to you and if so, I'll merge this
> >> ASAP.
> > 
> > At this point it would mean messing up all of vfs.fixes to drop it from
> > there. So I'd just leave it in there and send it to Linus.
> 
> Got it. I was waiting for confirmation before taking it into the modules tree,
> and I agree that at this point it makes sense to keep it in vfs.fixes.
> 
> > Next time I know where it'll end up.
> 
> Can you clarify what you mean by this?

Next time I know that you are responsible for taking such patches. :)


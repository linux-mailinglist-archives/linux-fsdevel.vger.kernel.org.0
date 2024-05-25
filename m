Return-Path: <linux-fsdevel+bounces-20153-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 963DC8CEECA
	for <lists+linux-fsdevel@lfdr.de>; Sat, 25 May 2024 13:57:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 40F6B1F2141F
	for <lists+linux-fsdevel@lfdr.de>; Sat, 25 May 2024 11:57:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F9FD3C473;
	Sat, 25 May 2024 11:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LHFHLIZW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0BD6F9CF
	for <linux-fsdevel@vger.kernel.org>; Sat, 25 May 2024 11:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716638226; cv=none; b=lTJRc90iuvqfIIfgC/rIushyQpQ/h7aaLlp3FvGdM2Al/++jss2f2PSc/iJ6TSIEu6BleJV0gCxxyyaJZ7/L3dD+aK9KrbjnlV88Kh/oWFWzDSRLSiXyxjiyyTqudoMzQUSSJHrU/Furmst7q08b65HJe00YGn98Qvcmcf8K2GU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716638226; c=relaxed/simple;
	bh=kmHxEBUCWQ8xP0/93TJgyradBnqjsMHyj0CPuDtnaOg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NtpgjnKdF4eRPnsxvHO8KdGi5LN+jE2UvI6+LtjDWDYVq8JOeVD4ECX6whJBUMO8bYlU+LHphqdn3CclUIJ0BcRSao6ws5cveB+ZHp9pPhsFfToYxjp6mU0BN+HNQ3XVVxSPkQGimCUWa9sIbyUWbHVmr19mF86Dusk4ewU92d4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LHFHLIZW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91BF1C2BD11;
	Sat, 25 May 2024 11:57:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716638226;
	bh=kmHxEBUCWQ8xP0/93TJgyradBnqjsMHyj0CPuDtnaOg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LHFHLIZWPZPyuC3SKITSKcHkOU6cK/tXD5yIiH8hBvPAidvTaMrIDy5HlxqgBB7sB
	 vfzrz11bVwTpWjRxWy/s59xAAiXFlp/RbEnvT9xKLHVzcEHIhhPv6FN/JJSwJ1Z1vP
	 F9bUJ83QPpYvkrv/ZzKBjJaRPIZ7WF/KIvivg0hva7t9PxVRNLNwIV5vpT4kPLpCpG
	 5heRC+irwwwNeaQQJuO5dU9N9jvyQOkL8ovcJKOCUG+SqzA5ZZgKJR07P1Lwu6uCvQ
	 gsJlWlegT5HnbkRfoNZ0AVD02VTrS/T4SBfQgZdjeniaIVQ6eMtq/mfHabvQdJGKGM
	 Ipc+TxQY8xb3Q==
Date: Sat, 25 May 2024 13:57:02 +0200
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org, Jiri Slaby <jirislaby@kernel.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Seth Forshee <sforshee@kernel.org>, 
	Tycho Andersen <tycho@tycho.pizza>
Subject: Re: [PATCH 2/2] pidfd: add pidfdfs
Message-ID: <20240525-karaokebar-hautschonend-375be6a36001@brauner>
References: <84bc442d-c4dd-418e-8020-e1ff987cad13@kernel.org>
 <CAHk-=whMVsvYD4-OZx20ZR6zkOPoeMckxETxtqeJP2AAhd=Lcg@mail.gmail.com>
 <d2805915-5cf0-412e-a8e3-04ff1b18b315@kernel.org>
 <CAHk-=wh68QbOZi_rYaKiydsRDnYHEaCsvK6FD83-vfE6SXg5UA@mail.gmail.com>
 <CAHk-=whgMGb0qM638KfBaa2AA9TR95D3oHJTu6=5YtRoBVWa3g@mail.gmail.com>
 <e983a37b-9eb3-4b53-8f02-d671281f82f9@kernel.org>
 <0bbf8e1d-0590-4e42-91b2-7a35614319d3@kernel.org>
 <20240521-ambitioniert-alias-35c21f740dba@brauner>
 <20240521-girlanden-zehnfach-1bff7eb9218c@brauner>
 <CAHk-=wgt2W6jmfCc9FPB+WC09Cqo4YTmwyAeCQq6Mxkx3EjACQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=wgt2W6jmfCc9FPB+WC09Cqo4YTmwyAeCQq6Mxkx3EjACQ@mail.gmail.com>

On Tue, May 21, 2024 at 08:10:26AM -0700, Linus Torvalds wrote:
> On Tue, 21 May 2024 at 05:40, Christian Brauner <brauner@kernel.org> wrote:
> >
> > Here's the updated patch appended. Linus, feel free to commit it
> > directly or if you prefer I can send it to you later this week.
> 
> Applied.
> 
> > In any case, I really really would like to try to move away from the
> > current insanity maybe by the end of the year. So I really hope that
> > lsof changes to the same format that strace already changed to so we can
> > flip the switch. That should allow us to get rid of both the weird
> > non-type st_mode issue and the unpleasant name faking. Does that sound
> > like something we can try?
> 
> We can try it again later and see if nobody notices because they've
> updated their user space.
> 
> That said, from previous experience, some people (and some distros)
> very seldom update user space, but this is hopefully enough of a
> corner case that *most* people won't even realize they've hit it, so
> maybe it's one of those "fraction of a fraction is zero" cases.

Cool! Fwiw, lsof has now already adapted to the new scheme as well in:
https://github.com/lsof-org/lsof/commit/cd5bb9bd7fbb65bca6cc60de1d35ff0e1c1b81e0


Return-Path: <linux-fsdevel+bounces-32487-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D10D9A69F7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Oct 2024 15:23:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 139161F23C7A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Oct 2024 13:23:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD19B1F4711;
	Mon, 21 Oct 2024 13:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lcIa9Hek"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C1DE1EF953;
	Mon, 21 Oct 2024 13:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729516993; cv=none; b=lYhfG/Hx2GuYFr5Wc7ceASfvJ9mpEob87bFNZwhI8Ip8cPvh/mAZM2oq08bazMBjxQrBZuAfadAgr81tAcSt9392Y48KzCVKwy4o1ft3ymowGs0GRUB2RrutZMJVFTg4gdo20XwLncWL0iWiPgLQunR5/ByJH6WftFS6yYpIVLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729516993; c=relaxed/simple;
	bh=yNPBY4RLl4JpyR1CBd7aVXhxf9HFXQWZ60Vp+IVyuh8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nOcBJ/cOECOwjlFD9AcKp1Yobm4QkFKXzhvajjDl/UENEBcSxQ7E4RWLAoKvub0wT5dSh3S0VW/I1uqkk4qL4ICgnyzIJ+wkBSVm5wmPAlPdsEOhLpr8VFHFky5bC/IR9URKc29IzezFuzu/H2kVgVEj316XtAyATfa17SDJsdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lcIa9Hek; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4910C4CEC3;
	Mon, 21 Oct 2024 13:23:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729516992;
	bh=yNPBY4RLl4JpyR1CBd7aVXhxf9HFXQWZ60Vp+IVyuh8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lcIa9Hek0sfVlZ3qU8kB+W7YhbOeeC/Vlk97QviwoqOHvqTa6eM8z4wObSwcF5vhg
	 qVZ8oetK6z868u2fzL0oZ99iKTBYLf0FQjKr+amVc5n+TBYiqXypuIrhuH6FhWj83Q
	 fG0JpbbQDyus2aZSubSs1dC49UQYR/Au+U4KJBVhXOEBVL973nG4yAL1IhgR9m4wb8
	 b1FJ8WhtH08si7hS9lDnzVnzK1sCmDTma24HQtTi09lU0h8phzoOrpeax4VfoPdsi/
	 aMlFiCYxazXAvk4nVkM8WiYZ5STFcCaI901pqvywoU5BhjKKytriJOZuQ2+NgUKigF
	 HsL8i6RPQj+kQ==
Date: Mon, 21 Oct 2024 15:23:08 +0200
From: Christian Brauner <brauner@kernel.org>
To: Antony Antony <antony@phenome.org>
Cc: Sedat Dilek <sedat.dilek@gmail.com>, 
	Maximilian Bosch <maximilian@mbosch.me>, Linux regressions mailing list <regressions@lists.linux.dev>, 
	David Howells <dhowells@redhat.com>, LKML <linux-kernel@vger.kernel.org>, 
	linux-fsdevel@vger.kernel.org
Subject: Re: [REGRESSION] 9pfs issues on 6.12-rc1
Message-ID: <20241021-nummer-gewillt-1d2a68581ff9@brauner>
References: <D4LHHUNLG79Y.12PI0X6BEHRHW@mbosch.me>
 <c3eff232-7db4-4e89-af2c-f992f00cd043@leemhuis.info>
 <D4LNG4ZHZM5X.1STBTSTM9LN6E@mbosch.me>
 <CA+icZUVkVcKw+wN1p10zLHpO5gqkpzDU6nH46Nna4qaws_Q5iA@mail.gmail.com>
 <ZxFQw4OI9rrc7UYc@Antony2201.local>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZxFQw4OI9rrc7UYc@Antony2201.local>

On Thu, Oct 17, 2024 at 08:00:35PM +0200, Antony Antony wrote:
> Hi,
> 
> On Thu, Oct 03, 2024 at 03:12:15AM +0200, Sedat Dilek wrote:
> > On Wed, Oct 2, 2024 at 11:58 PM Maximilian Bosch <maximilian@mbosch.me> wrote:
> > >
> > > Good evening,
> > >
> > > thanks a lot for the quick reply!
> > >
> > > > A fix for it is already pending in the vfs.fixes branch and -next:
> > > > https://lore.kernel.org/all/cbaf141ba6c0e2e209717d02746584072844841a.1727722269.git.osandov@fb.com/
> > >
> > > I applied the patch on top of Linux 6.12-rc1 locally and I can confirm
> > > that this resolves the issue, thanks!
> 
> Maximilian, would you like to re-run the test a few times? I wonder if there 
> is another intermittend bug related to the same commit.
> 
> > >
> > > With best regards
> > >
> > > Maximilian
> > >
> > 
> > Thanks for testing.
> > 
> > For the records:
> > 
> > iov_iter: fix advancing slot in iter_folioq_get_pages()
> > https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git/commit/?h=vfs.fixes&id=0d24852bd71ec85ca0016b6d6fc997e6a3381552
> > 
> > https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git/log/?h=vfs.fixes
> 
> I’m still seeing a kernel oops after the fix in 6.12-rc3, but I’ve noticed 
> that the issue is no longer 100% reproducible. Most of the time, the system 
> crashes. Before this fix it was 100% reproducible.
> 
> When using the nix testing, I have to force the test to re-run.
> 
> result=$(readlink -f ./result); rm ./result && nix-store --delete $result
> 
> nix-build -v nixos/tests/kernel-generic.nix -A linux_testing
> 
> So may be there is a new bug showing up after the fix. I have reported it.
> 
> https://lore.kernel.org/regressions/ZxFEi1Tod43pD6JC@moon.secunet.de/T/#u

I've pinged David again so hopefully we'll have a fix soon.


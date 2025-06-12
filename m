Return-Path: <linux-fsdevel+bounces-51527-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AF6CAD7E66
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Jun 2025 00:32:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3CECD3AD184
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Jun 2025 22:31:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C43C2E0B5A;
	Thu, 12 Jun 2025 22:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lahfa.xyz header.i=@lahfa.xyz header.b="hyWwVe6y"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from kurisu.lahfa.xyz (kurisu.lahfa.xyz [163.172.69.160])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEBB5537F8;
	Thu, 12 Jun 2025 22:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=163.172.69.160
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749767509; cv=none; b=aTBcH+boqbNNFOEGDCvu02HNtlOsc/A9uDYJKe6iYEVed1gXP6icic5OSZHfFDu02BN/MtLxC/FC5jA25hxuusvxHIxgy+Hjga61hFakTyO87Y0RFI1rcFQQwXg5zQAnmlm8wDE4yr6NEh0cLpkfA+bgMdcRNMCqQ+MMG4bDI7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749767509; c=relaxed/simple;
	bh=cH2TJaPhP16q+O7GZ4mzgek1QfkFEQdXgNxSfT/q03M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UrSSVhaBsIqm9Dlwfbk3D3ktir4lI/98bCcMQkHgeQMKLsvc+ZtkEDQMmZtaP6IX+Lkm609MoR8p3+QJ/b58zlBHMv0fJxX3RPZkFtsWUhIMuDnP2le0QlmbmOo1clNrtadMrhblmuafJBhJIvjIsrIt3eEilGFM6+1tQvgJQEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lahfa.xyz; spf=pass smtp.mailfrom=lahfa.xyz; dkim=pass (1024-bit key) header.d=lahfa.xyz header.i=@lahfa.xyz header.b=hyWwVe6y; arc=none smtp.client-ip=163.172.69.160
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lahfa.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lahfa.xyz
Date: Fri, 13 Jun 2025 00:24:13 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lahfa.xyz; s=kurisu;
	t=1749767060;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=k5CSy6NPtlYW+SywnOyyYPKFA5kG/64nLhhD3+nTO/Q=;
	b=hyWwVe6yQIc8ayyl5ZJszKksBtIr6039zYA9qoofbPidbru0i7jkgdhUcBiXBa0zQluBhK
	guYuK5Mf9JXhJv1BL+10mTDU9Br0lttTKel/wunz+eBzSCA6r6mc2D0kXGOitNPpEEQF8k
	tlOqIr++/TR3ACEaM8sZCrDbn7OJ/v4=
From: Ryan Lahfa <ryan@lahfa.xyz>
To: Antony Antony <antony.antony@secunet.com>
Cc: David Howells <dhowells@redhat.com>, 
	Antony Antony <antony@phenome.org>, Christian Brauner <brauner@kernel.org>, 
	Eric Van Hensbergen <ericvh@kernel.org>, Latchesar Ionkov <lucho@ionkov.net>, 
	Dominique Martinet <asmadeus@codewreck.org>, Christian Schoenebeck <linux_oss@crudebyte.com>, 
	Sedat Dilek <sedat.dilek@gmail.com>, Maximilian Bosch <maximilian@mbosch.me>, 
	regressions@lists.linux.dev, v9fs@lists.linux.dev, netfs@lists.linux.dev, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [REGRESSION] 9pfs issues on 6.12-rc1
Message-ID: <w5ap2zcsatkx4dmakrkjmaexwh3mnmgc5vhavb2miaj6grrzat@7kzr5vlsrmh5>
References: <ZxFQw4OI9rrc7UYc@Antony2201.local>
 <D4LHHUNLG79Y.12PI0X6BEHRHW@mbosch.me>
 <c3eff232-7db4-4e89-af2c-f992f00cd043@leemhuis.info>
 <D4LNG4ZHZM5X.1STBTSTM9LN6E@mbosch.me>
 <CA+icZUVkVcKw+wN1p10zLHpO5gqkpzDU6nH46Nna4qaws_Q5iA@mail.gmail.com>
 <3327438.1729678025@warthog.procyon.org.uk>
 <ZxlQv5OXjJUbkLah@moon.secunet.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZxlQv5OXjJUbkLah@moon.secunet.de>

Hi everyone,

Le Wed, Oct 23, 2024 at 09:38:39PM +0200, Antony Antony a écrit :
> On Wed, Oct 23, 2024 at 11:07:05 +0100, David Howells wrote:
> > Hi Antony,
> > 
> > I think the attached should fix it properly rather than working around it as
> > the previous patch did.  If you could give it a whirl?
> 
> Yes this also fix the crash.
> 
> Tested-by: Antony Antony <antony.antony@secunet.com>

I cannot confirm this fixes the crash for me. My reproducer is slightly
more complicated than Max's original one, albeit, still on NixOS and
probably uses 9p more intensively than the automated NixOS testings
workload.

Here is how to reproduce it:

$ git clone https://gerrit.lix.systems/lix
$ cd lix
$ git fetch https://gerrit.lix.systems/lix refs/changes/29/3329/8 && git checkout FETCH_HEAD
$ nix-build -A hydraJobs.tests.local-releng

I suspect the reason for why Antony considers the crash to be fixed is
that the workload used to test it requires a significant amount of
chance and retries to trigger the bug.

On my end, you can see our CI showing the symptoms:
https://buildkite.com/organizations/lix-project/pipelines/lix/builds/2357/jobs/019761e7-784e-4790-8c1b-f609270d9d19/log.

We retried probably hundreds of times and saw different corruption
patterns, Python getting confused, ld.so getting confused, systemd
sometimes too. Python had a much higher chance of crashing in many of
our tests. We reproduced it over aarch64-linux (Ampere Altra Q80-30) but
also Intel and AMD CPUs (~5 different systems).

As soon as we reverted to Linux 6.6 series, the bug went away.

We bisected but we started to have weirder problems, this is because we
encountered the original regression mentioned in October 2024 and for a
certain range of commits, we were unable to bisect anything further.

So I switched my bisection strategy to understand when the bug was
fixed, this lead me on the commit
e65a0dc1cabe71b91ef5603e5814359451b74ca7 which is the proper fix
mentioned here and on this discussion.

Reverting this on the top of 6.12 cause indeed a massive amount of
traces, see this gist [1] for examples.

Applying the "workaround patch" aka "[PATCH] 9p: Don't revert the I/O
iterator after reading" after reverting e65a0dc1cabe makes the problem
go away after 5 tries (5 tries were sufficient to trigger with the
proper fix).

If this can be helpful, the nature of the test above is to copy a
significant amount of assets to an S3 implementation (Garage) running
inside of the VM. Many of these assets comes from the Nix store which
sits over 9p.

Anyhow, I see three patterns:

- Kernel panic when starting the /init, this is the crash Max reported
  back in October 2024 and the one we started to encounter while
  bisecting this problem in the range between v6.11 and v6.12.
- systemd crashing very quickly, 
  this is what we see when reverting e65a0dc1cabe71b91ef5603e5814359451b74ca7
  on the top of v6.12 *OR* when we are around v6.12rc5.
- what the CI above shows which are userspace programs crashing after
  some serious I/O exercising has been done, which happens on the top of
  v6.12, v6.14, v6.15 (incl. stable kernels).

If you need me to test things, please let me know.

[1]: https://gist.dgnum.eu/raito/3d1fa61ebaf642218342ffe644fb6efd
-- 
Ryan Lahfa


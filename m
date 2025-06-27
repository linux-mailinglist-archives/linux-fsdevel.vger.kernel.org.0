Return-Path: <linux-fsdevel+bounces-53169-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F4B0AEB52F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Jun 2025 12:41:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB7791891AB3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Jun 2025 10:42:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1F6429898E;
	Fri, 27 Jun 2025 10:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lahfa.xyz header.i=@lahfa.xyz header.b="KIX31bsi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from kurisu.lahfa.xyz (kurisu.lahfa.xyz [163.172.69.160])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7EDE22156A;
	Fri, 27 Jun 2025 10:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=163.172.69.160
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751020909; cv=none; b=CIrk4oeoZ1ZehykYUGLK1aL9xePuEYAg/exvn112TBoB/xrOaGuAZdLQ8ZaYKi2CRLoh8UjIM3K/l2YqIDlIgvOSIKI8dXkHTxpgzs54jxiDpnC8Ewz6aD3tR6F7wqQdo/fozmXbPekjde3xxTVVRQh2xhRveVhFBghIMvwW6Mc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751020909; c=relaxed/simple;
	bh=yhF0gvpQ2LingrBx1HYPfc8w3xJ+F33erqmQmXW9kPg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Cxp6Sa86smWRidCSbD/YxrKZbVj3MBMTAwjSRr0o2FtU8ccEfMbBHhxmpufbalLfla+kHI8hm41A0tw/WfbkCMD07qufkyo3rBv7fx7P2NbtQg1HMX9GZnVUHPzB5ZKZT1fLOlBtQ0p7f2Tgo9UFcpu8yfpGFwNiATzRUmxMprs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lahfa.xyz; spf=pass smtp.mailfrom=lahfa.xyz; dkim=pass (1024-bit key) header.d=lahfa.xyz header.i=@lahfa.xyz header.b=KIX31bsi; arc=none smtp.client-ip=163.172.69.160
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lahfa.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lahfa.xyz
Date: Fri, 27 Jun 2025 12:33:18 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lahfa.xyz; s=kurisu;
	t=1751020405;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XKbXq1dbdhV8xumU0aZAN+tBsL+injlXBseZI72UWGQ=;
	b=KIX31bsiJiF4FTf1m/nQ2lEmj9X0nb+B1EjYYq+QrDCcZ8lrVU5vVNzzvuJnhN1083vDrI
	NrnzfKSvauvRKKJSrXC7hlw/ZqkztctbMnQDGxytK3R7L/TPLtZ5KOt58YJy+MEoSadumY
	TtjeSwIdF4YwE8q9BJsTmXDGDK+5fto=
From: Ryan Lahfa <ryan@lahfa.xyz>
To: David Howells <dhowells@redhat.com>
Cc: Antony Antony <antony.antony@secunet.com>, 
	Antony Antony <antony@phenome.org>, Christian Brauner <brauner@kernel.org>, 
	Eric Van Hensbergen <ericvh@kernel.org>, Latchesar Ionkov <lucho@ionkov.net>, 
	Dominique Martinet <asmadeus@codewreck.org>, Christian Schoenebeck <linux_oss@crudebyte.com>, 
	Sedat Dilek <sedat.dilek@gmail.com>, Maximilian Bosch <maximilian@mbosch.me>, 
	regressions@lists.linux.dev, v9fs@lists.linux.dev, netfs@lists.linux.dev, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [REGRESSION] 9pfs issues on 6.12-rc1
Message-ID: <gnji275b4iqotq3x3sa3igwa3vczk6tqtfcxpbv6k47hinrj2j@3wrm3id43qgj>
References: <w5ap2zcsatkx4dmakrkjmaexwh3mnmgc5vhavb2miaj6grrzat@7kzr5vlsrmh5>
 <ZxFQw4OI9rrc7UYc@Antony2201.local>
 <D4LHHUNLG79Y.12PI0X6BEHRHW@mbosch.me>
 <c3eff232-7db4-4e89-af2c-f992f00cd043@leemhuis.info>
 <D4LNG4ZHZM5X.1STBTSTM9LN6E@mbosch.me>
 <CA+icZUVkVcKw+wN1p10zLHpO5gqkpzDU6nH46Nna4qaws_Q5iA@mail.gmail.com>
 <3327438.1729678025@warthog.procyon.org.uk>
 <ZxlQv5OXjJUbkLah@moon.secunet.de>
 <1641293.1751018406@warthog.procyon.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1641293.1751018406@warthog.procyon.org.uk>

Hi David,

Le Fri, Jun 27, 2025 at 11:00:06AM +0100, David Howells a écrit :
> Ryan Lahfa <ryan@lahfa.xyz> wrote:
> 
> > Here is how to reproduce it:
> > 
> > $ git clone https://gerrit.lix.systems/lix
> > $ cd lix
> > $ git fetch https://gerrit.lix.systems/lix refs/changes/29/3329/8 && git checkout FETCH_HEAD
> > $ nix-build -A hydraJobs.tests.local-releng
> 
> How do I build and run this on Fedora is the problem :-/

This may introduce another layer but you could use a Docker container
(Lix has http://ghcr.io/lix-project/lix) and run these instructions
inside that context.

Alternatives are the following:

- static binary for Nix, I can build one for you and make it available.
- the Lix installer, https://lix.systems/install/ (curl | sh but it does
  prompt you for any step and tell you what it does, it should also be
  very easy to uninstall!).
- Debian has Nix packaged: https://packages.debian.org/sid/nix-bin (not
  Lix, but doesn't matter for this reproducer).
- Can install a remote VM for you with Fedora with one of the previous
  option and give you root@ over there.

Let me know how I can help.

> > [1]: https://gist.dgnum.eu/raito/3d1fa61ebaf642218342ffe644fb6efd
> 
> Looking at this, it looks very much like a page may have been double-freed.
> 
> Just to check, what are you using 9p for?  Containers?  And which transport is
> being used, the virtio one?

9p is used in QEMU in this context.
NixOS has a framework of end to end testing à la OpenQA from OpenSUSE
that makes use of 9pfs to mount the host Nix store inside the guest VM
to avoid copying back'n'forth things that are not under test.

Yep, transport is virtio.

Kind regards,
-- 
Ryan Lahfa


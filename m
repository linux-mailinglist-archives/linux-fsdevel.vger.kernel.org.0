Return-Path: <linux-fsdevel+bounces-21719-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AC2CB909247
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Jun 2024 20:28:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BAD981C21467
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Jun 2024 18:28:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 700AA19E7D0;
	Fri, 14 Jun 2024 18:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="TqXSAAeH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB9CF19ADB3
	for <linux-fsdevel@vger.kernel.org>; Fri, 14 Jun 2024 18:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718389699; cv=none; b=sMxjzd7TlbJwhEtFJEMOpK9OWe2fOtc1hK5cAGQ0MNGgYQydrdAXnCEmb4cUhk6nfLmWG6EZS9n030FT9fmteJiWzswLF3EhlTSzoKDbuZapD8+Jxa4vcmACx77TN5SHRO6M0tvrP7LV4b1Y23A/mzC9aUlcBpJFvcpx9wqrSUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718389699; c=relaxed/simple;
	bh=n0nzYbuEKsP5CR5izx9tmUeBzNZs6Dv9llNLoXFas/o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rl07JYP4MNbWPPhYIaEbNCt4tLfIo0AB7tpi1Aj3PuYwKaAi1/qn4UxYeGiefYMAxAEzDiYJ7bmSpYaWInlScUHLvGOGx7mEOlKxQhWBAnC3HI2znQkW3fjnFx9clp/HQHjhruG2PQ/Sjp6Aa5TtoHKDCenobVv0RkJpAwXWdEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=TqXSAAeH; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from macsyma.thunk.org ([84.247.112.25])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 45EIS5YI006182
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 14 Jun 2024 14:28:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1718389688; bh=UBuv+ACn7yY6Imbu4MZetpHQlIo5F19TevPQHO1PRME=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=TqXSAAeHFlrvMmoGgZH7vuDT4FIZLDOG5CjnIarT1J/2KgJ33AoaKNyF9aTPSjsdg
	 z2pZApE6L/0/Noj6HkpsOoe6TxwHQP3VfYckNz7JsKPCDQ03IVG+P1Pv3/ErLF62mx
	 IrO6Q9nPNfEilnUPnisqpWJqQKdHtynPXxBeEUO0Twjs9yRJgughiqswvrbVvSDxYx
	 AKv1wza3b/pFX+AG6GkTBmdIJmEbeutduj+Y/Cr55hF9Bp/LF1F37yXOTD0AYtHIM5
	 w0pwSNvMsEA5wLvPG5Eqx27g4uzw8iC65XTZGFUzSiouj9cWEoAr60X3aXLanMqzYN
	 O3iIlVmFuv6kg==
Received: by macsyma.thunk.org (Postfix, from userid 15806)
	id 4C9A7340F4A; Fri, 14 Jun 2024 20:27:59 +0200 (CEST)
Date: Fri, 14 Jun 2024 19:27:59 +0100
From: "Theodore Ts'o" <tytso@mit.edu>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Linux Filesystem Development List <linux-fsdevel@vger.kernel.org>,
        fstests@vger.kernel.org
Subject: Re: Flaky test: generic:269 (EBUSY on umount)
Message-ID: <20240614182759.GF1906022@mit.edu>
References: <20240612162948.GA2093190@mit.edu>
 <20240612194136.GA2764780@frogsfrogsfrogs>
 <20240613215639.GE1906022@mit.edu>
 <20240614041618.GA6147@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240614041618.GA6147@frogsfrogsfrogs>

On Thu, Jun 13, 2024 at 09:16:18PM -0700, Darrick J. Wong wrote:
> 
> Amusingly enough, I still have that patch (and generic/1220) in my
> fstests branch, and I haven't seen this problem happen on g/1220 in
> quite a while.

Remind me what your fstests git repo is again?

The generic/750 test in my patch 2/2 that I sent out reproduces the
problem super-reliably, so long as fsstress actually issues the
io_uring reads and writes.  So if you have your patch applied which
suppresses io_uring from fstress by default, you might need to modify
the patch series to force the io_uring, at which point it quite nicely
demonstrates the fsstress ; umount problem.  (It sometimes requires
more rounds of fsstress ; umounts before it repro's on the xfs/4k, but
it repro's really nicely on ext4/4k).

xfs/4k:
  generic/750  Failed   3s
  generic/750  Failed   1s
  generic/750  Failed   33s
  generic/750  Failed   1s
  generic/750  Pass     33s
ext4/4k:
  generic/750  Failed   3s
  generic/750  Failed   2s
  generic/750  Failed   7s
  generic/750  Failed   2s
  generic/750  Failed   7s

							- Ted
							


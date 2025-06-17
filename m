Return-Path: <linux-fsdevel+bounces-51894-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 001FCADC948
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Jun 2025 13:26:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 504637A6B73
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Jun 2025 11:24:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1FAC2980AF;
	Tue, 17 Jun 2025 11:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tvh3alMJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27DDE5C96
	for <linux-fsdevel@vger.kernel.org>; Tue, 17 Jun 2025 11:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750159558; cv=none; b=sbmcatCsHrshstMlA/y0EdcsfDWwzktUVH4SO4iw5pxf4c4BEKnD+SgElWSMqbytN0JRgrfNTWuYpwqo8ZPHCbnqq2YcZXoFCuT6RXEber3+wneJIcbxpha97OR37Gfgr0j5Z/0SkBQclVRK9rdUT3LIgHKVl2jmwtnUtt/yMSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750159558; c=relaxed/simple;
	bh=+XeXwpClvwadWY8wTnafxK7UzMaTRoGsX6kydqxhSvs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bdL0pIfu++sJz9OrcvlY1HEZCkMKWgfEoJJ2fQxow+ODARf95GKzzMMQDqwo78PeQEkzaipjUOpLs87rIThZg4mwDmGSFtBrIHdhgmmMTmmGrUvihF+eYJHubifL50zVOyfZef/V63B7TrPtsUUACSBskfpPfWcZ6eeScwzdns8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tvh3alMJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95F00C4CEED;
	Tue, 17 Jun 2025 11:25:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750159557;
	bh=+XeXwpClvwadWY8wTnafxK7UzMaTRoGsX6kydqxhSvs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Tvh3alMJXlbJqBc+5EmXEasiXWwm9nTH+81v0nBTlXHEDWjib1kFrfiuT4Tn3O+6d
	 gFUSvABZ7qgedHXEqbjo03S/D5psoVlefp/dJ3vVJTNZ/58sva224FBGPq8ELnNPuR
	 46taWr6s4XJ1owoNiFrIoJQK1r5I6F8lY9Db/CKTcHgubTwlH/1iM+X6cQtwHUtu5O
	 IClNVpK7LoWwbQddyS6ch1K/TZO8aY5DcTiK5sQc9Cvg0hmS+kGZobf+vvyxJTnzkU
	 gFUv4dM5UViGFlA+ZMT5/M/9K1ZPjdn62I7++yFuAB6QIj1lPDNv25pvT1mhvjA32M
	 NnO5SCwLOOaNA==
Date: Tue, 17 Jun 2025 13:25:53 +0200
From: Christian Brauner <brauner@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, neil@brown.name, 
	torvalds@linux-foundation.org
Subject: Re: [PATCH 3/8] spufs: switch to locked_recursive_removal()
Message-ID: <20250617-marode-zirkulation-a6ab03a96bf8@brauner>
References: <20250614060050.GB1880847@ZenIV>
 <20250614060230.487463-1-viro@zeniv.linux.org.uk>
 <20250614060230.487463-3-viro@zeniv.linux.org.uk>
 <20250616-unsanft-gegolten-725b6c12e6c8@brauner>
 <20250616191458.GH1880847@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250616191458.GH1880847@ZenIV>

On Mon, Jun 16, 2025 at 08:14:58PM +0100, Al Viro wrote:
> On Mon, Jun 16, 2025 at 04:40:14PM +0200, Christian Brauner wrote:
> > On Sat, Jun 14, 2025 at 07:02:25AM +0100, Al Viro wrote:
> > > ... and fix an old deadlock on spufs_mkdir() failures to populate
> > > subdirectory - spufs_rmdir() had always been taking lock on the
> > > victim, so doing it while the victim is locked is a bad idea.
> > > 
> > > Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> > > ---
> > 
> > Fwiw, I think simple_recursive_removal_locked() might be better.
> > It's longer and arguably uglier but it clearer communicates that its the
> > same helper as simple_recursive_removal() just with the assumption that
> > the caller already holds the lock.
> 
> Not sure...  TBH, I'm somewhat tempted to rename simple_recursive_removal()
> to simple_remove()...

Sounds good.


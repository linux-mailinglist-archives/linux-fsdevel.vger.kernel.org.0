Return-Path: <linux-fsdevel+bounces-31049-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A16089913EA
	for <lists+linux-fsdevel@lfdr.de>; Sat,  5 Oct 2024 04:31:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 344A1B23426
	for <lists+linux-fsdevel@lfdr.de>; Sat,  5 Oct 2024 02:31:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB4CE1C2BD;
	Sat,  5 Oct 2024 02:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="vCA79v/s"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BEC2211C;
	Sat,  5 Oct 2024 02:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728095459; cv=none; b=r44Ch398iVK1H34V7Wm8yQH0nWNQ+P0zxK+x70PXP/5Sux5nZrkZrmsl/6QsFaAq9asG357r7EvRdW3km30neE5F2x8KhT+neY6D/T4MsqP40ob0wTIZ8+K66ks9uWUm+VHF1QcqkYeq/5jhfs7uPEwJNaBiRJiDHjwstqH4pR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728095459; c=relaxed/simple;
	bh=csqTLQaxf4ZlCsS3YHzbWIYnBSpqEvG0c3+B/4vCe/0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o8EdoBqcMh+RLX2MEGlZuntIEdbnV343LerYmdtSUqelwz48Jm8nU7rbl4UyBQ3kwSz3nQyfGE0Phj3HKRV5RAvLIOjIvCnuT0guS2Ija7zDDENlMfqqa8RelW8SaBRz2jm3+1UxjO0USMKBlEWzq2gjrIecWV3h+zdjjxpr1Ac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=vCA79v/s; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=csqTLQaxf4ZlCsS3YHzbWIYnBSpqEvG0c3+B/4vCe/0=; b=vCA79v/sQ77e3a329C9tabA+R0
	HMM9Vli8zLXdVJCApU9QKQ1uI7vBfEz6kdhT1bocIW7K1XVGxES7wS82k2eLeCz851KKpTO+CQo7j
	xf948hqZ0+0Y/nJX6DBG17AWCDXxSicN4itHylA+Kjox7dx8yeFcWMygXcfU+2dd6DSH9+cgUy8pm
	7tm6yynoh5z+dQY2kRBSfr7sGroHwynOqlhsgQJCHZU1UyBdEfZ84pkSDGNvjqpm9JITMJnpuaZi3
	dvtRSTAO90iUZKN7iASNW4yqBXRoGJ++PCSEPneJmcd3MDtqnsDLe9BquFUfXxASOUgjXSo/43QY+
	KHBOTs2g==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1swuZJ-0000000Bs24-2ZPa;
	Sat, 05 Oct 2024 02:30:53 +0000
Date: Sat, 5 Oct 2024 03:30:53 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Goldwyn Rodrigues <rgoldwyn@suse.de>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: Re: [PATCH 06/12] iomap: Introduce read_inline() function hook
Message-ID: <ZwCk3eROTMDsZql1@casper.infradead.org>
References: <cover.1728071257.git.rgoldwyn@suse.com>
 <8147ae0a45b9851eacad4e8f5a71b7997c23bdd0.1728071257.git.rgoldwyn@suse.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8147ae0a45b9851eacad4e8f5a71b7997c23bdd0.1728071257.git.rgoldwyn@suse.com>

On Fri, Oct 04, 2024 at 04:04:33PM -0400, Goldwyn Rodrigues wrote:
> Introduce read_inline() function hook for reading inline extents. This
> is performed for filesystems such as btrfs which may compress the data
> in the inline extents.

This feels like an attempt to work around "iomap doesn't support
compressed extents" by keeping the decompression in the filesystem,
instead of extending iomap to support compressed extents itself.
I'd certainly prefer iomap to support compressed extents, but maybe I'm
in a minority here.


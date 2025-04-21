Return-Path: <linux-fsdevel+bounces-46853-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C221A957B7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Apr 2025 23:06:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 18808188F560
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Apr 2025 21:06:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5225820E70E;
	Mon, 21 Apr 2025 21:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KGMiVEen"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF0C020E026;
	Mon, 21 Apr 2025 21:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745269598; cv=none; b=eqwmw2X064+3C/FNWcrtadPdnyES2ApEokWSLQTXFfL3hh9N/LzdJZecLCWWVB7HXFlF8ALuO7hbShNOuw/7SMP5sXHobdaKMTT0foPp4+DpFB+1uGAam3PM/Gsn3of+NdRur3s7wET7adyZZeEuAnObORHXr1VzTy3/Z4xyKXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745269598; c=relaxed/simple;
	bh=6kF4qcAhccbS6K+ytOmRgQrJi0iPWLQ6dCBhdYPzjiQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ne0EC/X3sKpQ/iqIImDabSXKhWXyl8WZNPREztmuz0FpX5QTjbPtqdbqBKmW+Qm5JqdBg2Q+wkdCIn4eL9WG9VdmeULo0V/EkDE/x+OI6g52SVKI+7nAWmn7S5bJaP515nbbtDNcyKQ9v3RKDiCNGl85O+6/ir43J/X7IdDkyFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KGMiVEen; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8563C4CEEA;
	Mon, 21 Apr 2025 21:06:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745269598;
	bh=6kF4qcAhccbS6K+ytOmRgQrJi0iPWLQ6dCBhdYPzjiQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KGMiVEeny0NKQvICXmbZI1stATJNujaWqFdomyXi233hPuOqtNHsjHbesNzMwlDp/
	 Aq6eOQCc08niPiRxa4bnJ06eJqrG7CNDN1fpcTSQ2q/31/JvNWmbOPk+o8/3tQpTYG
	 OSsNbPEtJUaHKBOxkhtb5SO1wXiOFxPkL6Kb63RlHWRXb7f+pZ2tZ/q+00HwboG7AW
	 hVmNAhmBMegEXwG2hb+l/SH4+qpFse44gM7t2xCln/zQ6xrcYt1i2e85wJEYJGuihJ
	 mgZeD5dn515KiDSEWsI4pb4IXoIixhb4Q1hW2LEo5mMsEt4bDxZH1Sb+Bp7AlZfmQM
	 EtSCAEU2ptBWw==
Date: Mon, 21 Apr 2025 14:06:36 -0700
From: Luis Chamberlain <mcgrof@kernel.org>
To: Davidlohr Bueso <dave@stgolabs.net>
Cc: jack@suse.cz, tytso@mit.edu, adilger.kernel@dilger.ca,
	brauner@kernel.org, willy@infradead.org, hare@suse.de,
	djwong@kernel.org, linux-ext4@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v2 0/7] fs/buffer: split pagecache lookups into atomic or
 blocking
Message-ID: <aAazXO06FwqhVJU5@bombadil.infradead.org>
References: <20250418015921.132400-1-dave@stgolabs.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250418015921.132400-1-dave@stgolabs.net>

On Thu, Apr 17, 2025 at 06:59:14PM -0700, Davidlohr Bueso wrote:
> Hello,
> 
> Changes from v1: rebased on top of vfs.fixes (Christian).
> 
> This is a respin of the series[0] to address the sleep in atomic scenarios for
> noref migration with large folios, introduced in:
> 
>       3c20917120ce61 ("block/bdev: enable large folio support for large logical block sizes")
> 
> The main difference is that it removes the first patch and moves the fix (reducing
> the i_private_lock critical region in the migration path) to the final patch, which
> also introduces the new BH_Migrate flag. It also simplifies the locking scheme in
> patch 1 to avoid folio trylocking in the atomic lookup cases. So essentially blocking
> users will take the folio lock and hence wait for migration, and otherwise nonblocking
> callers will bail the lookup if a noref migration is on-going. Blocking callers
> will also benefit from potential performance gains by reducing contention on the
> spinlock for bdev mappings.
> 
> Applies against latest vfs.fixes. Please consider for Linus' tree.
> 
> Patch 1: carves a path for callers that can block to take the folio lock.
> Patch 2: adds sleeping flavors to pagecache lookups, no users.
> Patches 3-6: converts to the new call, where possible.
> Patch 7: does the actual sleep in atomic fix.
> 
> Thanks!

Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>
Tested-by: kdevops@lists.linux.dev # [0] [1]
Link: https://kdevops.org/ext4/v6.15-rc2.html # [0]
Link: https://lore.kernel.org/all/aAAEvcrmREWa1SKF@bombadil.infradead.org/ # [1]

  Luis


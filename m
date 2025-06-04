Return-Path: <linux-fsdevel+bounces-50591-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 34740ACD8AC
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Jun 2025 09:38:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8EA5D1883D1D
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Jun 2025 07:39:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08A6522FDFF;
	Wed,  4 Jun 2025 07:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="debuKGUs"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A5CF8C11
	for <linux-fsdevel@vger.kernel.org>; Wed,  4 Jun 2025 07:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749022723; cv=none; b=J6uNYQhzthJAFF0O7iLeR0hIf5abMTo1k3NSMgxMKQgiF4I7ivpbBolM+vu4RSEVSIA9DWGY1c51A9twEvHJGIP7pIneG8nrPry+7XUTqHScFuvzkLwlKs1T7lLLJP9HMuO5FL8wvAWSDwNuSBOdfxwSg91NzNtOGTKch3REV6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749022723; c=relaxed/simple;
	bh=BgtHFUBpWsYSTt9OIbUYJUqzGV02OvP0dQs7tWm33nM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nXnJP9z0/CTfmRZLwNwVm1jWxc4+B/jLimnX9so15uzlV8P2ZEiJm2lB5VQgLgnSJWoAM2ctMINkSzj+rvNfcj3sjrQ8BR1dzvWtgCua2YMv1NgUHYfqRgikgGxDrE9n+1mBjEKY6ZJvPGcIviftA82LRlGtn2m3N+aPEEsXk40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=debuKGUs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD7DEC4CEE7;
	Wed,  4 Jun 2025 07:38:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749022721;
	bh=BgtHFUBpWsYSTt9OIbUYJUqzGV02OvP0dQs7tWm33nM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=debuKGUs7SnJjWqYMYxo4uL3EKT1Bgw4xQVTWg0rkYcFakr3fIK/Aid7TvZqozJUA
	 PaAXWtPEJ76wQSplSTM4AScFbAEnc8U/dDRX5q1L/koxK5vmp9Iq55RCb46C746Wv9
	 9u0yTOsunwHQsGArL5/mpLowta1dfrY4k0taONBHcMN0ZN9z0+Q7fFbKMZxqDjaEwm
	 /AOF2xfIRZ6y/zbPcnXpCki7tP4613uf3z07AQvYYnT4fI5F+CSju0+aP69+kzrzxH
	 EY5lqKUYT7QNTL3Y2w1GZpr18paajHEqGo3gv++rpciNUJmHoIhR04a+sJXT1jm+6r
	 zUEHYCyipRF5g==
Date: Wed, 4 Jun 2025 09:38:37 +0200
From: Christian Brauner <brauner@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, 
	Linus Torvalds <torvalds@linux-foundation.org>, Jan Kara <jack@suse.cz>
Subject: Re: [PATCH 2/5] path_overmount(): avoid false negatives
Message-ID: <20250604-maden-feucht-e97c83f9897f@brauner>
References: <20250603231500.GC299672@ZenIV>
 <20250603231709.GB145532@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250603231709.GB145532@ZenIV>

On Wed, Jun 04, 2025 at 12:17:09AM +0100, Al Viro wrote:
> Holding namespace_sem is enough to make sure that result remains valid.
> It is *not* enough to avoid false negatives from __lookup_mnt().  Mounts
> can be unhashed outside of namespace_sem (stuck children getting detached
> on final mntput() of lazy-umounted mount) and having an unrelated mount
> removed from the hash chain while we traverse it may end up with false
> negative from __lookup_mnt().  We need to sample and recheck the seqlock
> component of mount_lock...
> 
> Bug predates the introduction of path_overmount() - it had come from
> the code in finish_automount() that got abstracted into that helper.
> 
> Fixes: 26df6034fdb2 ("fix automount/automount race properly")
> Fixes: 6ac392815628 ("fs: allow to mount beneath top mount")
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---

Reviewed-by: Christian Brauner <brauner@kernel.org>


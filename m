Return-Path: <linux-fsdevel+bounces-46592-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 62477A90D9E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Apr 2025 23:15:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF15C1906B27
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Apr 2025 21:15:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98C7022DFBA;
	Wed, 16 Apr 2025 21:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KqbzKKiE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2CFB2DFA36;
	Wed, 16 Apr 2025 21:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744838136; cv=none; b=JJiDJpRlnCR6ytqI6VVcZSTxCYl6jSu+UU1NSTa5ZbNLHc4Rab1ijP5ttCKmY1KpZlTHf5JHefS0MnaK1OG+xCRcbtlo0mWjC9+1/76jMPsFGDl28dtDuy5HOvSiYSHzsXA259vvsG8YfQrm+LOpKppZHYGCcT2K4x76iSu5Yao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744838136; c=relaxed/simple;
	bh=fsYQ4MtXWUhX9eefDtr54gSjHE2qAVtbe9mnowihDQw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iYMULfhWFf+2T8c66+TxCAy542I2d+ehJz9UnZqcvA4JNaGo34O/kSNNbSgsj8mVv44Z3/XSm+2SfyErnwXmEMedqm1+xp4mBuw5ye+1yg6L2A5QFf6T/WipkjhSRfUItJKqKGvWcsNRJafpjewMEpsfW1SQdO2e9GEwHQGpZOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KqbzKKiE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B456C4CEE2;
	Wed, 16 Apr 2025 21:15:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744838135;
	bh=fsYQ4MtXWUhX9eefDtr54gSjHE2qAVtbe9mnowihDQw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KqbzKKiE7d/sopYx5LWOsjPtaHBlmM70j8NrQzP5FvOofJuwnrRxHobjMfAuSeafq
	 eiDtXMUoHO4lDrjkGZV1qgaWF+xiiP+AYVDaL9ZHRsl0wrNzelGxNlpCsR2678VoOE
	 62ZfiD7m5x5HRGjbop2Kr1z+EbSofN1Dwc/BgU1VihZdFEi18fBWHWilvY7Ti2qPAK
	 npq9egsB+xHThCdsddlom7c/xQlF/2OQmOLP7sJoi+TSv9bg/eAeuSZQfe0YD3sEgH
	 qdhmNMLhxchXa3TJu2ihlqeJpRD8C361iBeX2hHMYSk52eihYi1Wd6O4i3IwR5LY3H
	 oOWxOTHAvtCEg==
Date: Wed, 16 Apr 2025 14:15:30 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Christian Brauner <brauner@kernel.org>
Cc: David Rheinsberg <david@readahead.eu>, Oleg Nesterov <oleg@redhat.com>,
	linux-fsdevel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>,
	Lennart Poettering <lennart@poettering.net>,
	Daan De Meyer <daan.j.demeyer@gmail.com>,
	Mike Yuan <me@yhndnzj.com>, linux-kernel@vger.kernel.org,
	Peter Ziljstra <peterz@infradead.org>
Subject: Re: [PATCH v2 0/2] pidfs: ensure consistent ENOENT/ESRCH reporting
Message-ID: <20250416211530.GA3499099@ax162>
References: <20250411-work-pidfs-enoent-v2-0-60b2d3bb545f@kernel.org>
 <20250415223454.GA1852104@ax162>
 <20250416-befugnis-seemeilen-4622c753525b@brauner>
 <20250416-tonlage-gesund-160868ceccc1@brauner>
 <20250416-gegriffen-tiefbau-70cfecb80ac8@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250416-gegriffen-tiefbau-70cfecb80ac8@brauner>

On Wed, Apr 16, 2025 at 10:21:02PM +0200, Christian Brauner wrote:
> Ok, I think I understand how this happens. dbus-broker assumes that
> only EINVAL is reported by SO_PEERPIDFD when a process is reaped:
> 
> https://github.com/bus1/dbus-broker/blob/5d34d91b138fc802a016aa68c093eb81ea31139c/src/util/sockopt.c#L241
> 
> It would be great if it would also allow for ESRCH which is the correct
> error code anyway. So hopefully we'll get that fixed in userspace. For
> now we paper over this in the kernel in the SO_PEERPIDFD code.
> 
> Can you please test vfs-6.16.pidfs again. It has the patch I'm
> appending.

Yes, that appears to work fine for me, thanks for the quick fix!

If it would be helpful:

Tested-by: Nathan Chancellor <nathan@kernel.org>

Cheers,
Nathan


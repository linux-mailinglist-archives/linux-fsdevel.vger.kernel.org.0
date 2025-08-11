Return-Path: <linux-fsdevel+bounces-57385-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ED09AB2107C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Aug 2025 17:58:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 97A131893D65
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Aug 2025 15:52:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB2571A9F9F;
	Mon, 11 Aug 2025 15:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XGVAw1Da"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 190A219D88F;
	Mon, 11 Aug 2025 15:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754926303; cv=none; b=SqivB4xwM/pWOY+wBkMDbnwYu5ue9s/AF2sFPAMjo6o3M8I9hpTd9jzPjoax/xE9c6OWFJKoCHsk9pcP2wd4NFerKwUKXp+M4VvKCCebsmy5YMde+9mLzVEutdJhebjrpjFktYiYvq/PBFHUUSWiAz7lj00Ew1ZRWjYCUQH5aLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754926303; c=relaxed/simple;
	bh=0So7KQGnjijVzM0TWA5+/BW8vDimww8+bmIianA+pQE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qhXhI0xVX2vGRpi4qOUm+ckFnMHz4GQrvCa3/5mzxHNQdm7DyxVVt87voJ+NDIsHmuHz4Sid8bCFkIPBOOH3YCislRXzX7e9VaTyuu+NlEdOp65hfhVj6yzutX6t3GcZ9c2LJbOTKuxnTf7Od3/KT02prwE0vcDRIfmJp0XayG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XGVAw1Da; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92702C4CEED;
	Mon, 11 Aug 2025 15:31:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754926302;
	bh=0So7KQGnjijVzM0TWA5+/BW8vDimww8+bmIianA+pQE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XGVAw1DaymnZ+EX5FBTOzydJAkEv2+wIPPKKSQ/YAiODdwDjzr0niPMHIEQt4Vp13
	 Hju/LgNaJJ50bf//ckE9Dr/0v7g+CeqnlwaQyk71f4R98Ez/TOc1j9khQ+ZcUsT9pc
	 LTRh4oGt1FaNriVmubhqzM7nVZeL6QmPI+lnJKlINttjW/Ya3e5Mez6TpNsbXq1QeQ
	 a/SLYuXv70/BJ7BzcEGGYk4KgSFaIVGfVUS71jDcsIVmgpApuEG+2EWqeajWWm2A+x
	 7vEDbhYAN0YtK7XrKqUxsRA+JChbqRl8FUIOXYq6hUgS27E3ZcqpE5oOUVa8Ct50ro
	 1wUREb/80ViXQ==
Date: Mon, 11 Aug 2025 08:31:42 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Andrey Albershteyn <aalbersh@redhat.com>, fsverity@lists.linux.dev,
	linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
	david@fromorbit.com, ebiggers@kernel.org
Subject: Re: [PATCH RFC 06/29] fsverity: report validation errors back to the
 filesystem
Message-ID: <20250811153142.GJ7965@frogsfrogsfrogs>
References: <20250728-fsverity-v1-0-9e5443af0e34@kernel.org>
 <20250728-fsverity-v1-6-9e5443af0e34@kernel.org>
 <20250811114603.GB8969@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250811114603.GB8969@lst.de>

On Mon, Aug 11, 2025 at 01:46:03PM +0200, Christoph Hellwig wrote:
> On Mon, Jul 28, 2025 at 10:30:10PM +0200, Andrey Albershteyn wrote:
> > From: "Darrick J. Wong" <djwong@kernel.org>
> > 
> > Provide a new function call so that validation errors can be reported
> > back to the filesystem.
> 
> This feels like an awfull generic name for a very specific error
> condition.

<shrug> ->verity_failure?

> > Signed-off-by: Darrick J. Wong <djwong@kernel.org>
> 
> Btw, this is missing a signoff from Andrey as the series submitter
> needs to sign off after the author.

Yes.

--D


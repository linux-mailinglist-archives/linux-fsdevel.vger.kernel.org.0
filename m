Return-Path: <linux-fsdevel+bounces-51269-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 386F6AD5088
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Jun 2025 11:50:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E8ED43A91A8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Jun 2025 09:49:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BE76255F5C;
	Wed, 11 Jun 2025 09:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ir9ACWe4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB78F23AB9C
	for <linux-fsdevel@vger.kernel.org>; Wed, 11 Jun 2025 09:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749635406; cv=none; b=fEGZnR44pE2C/OV7F1k/0G15mp1j44anCI/vgqncF6T9T2ogjmp1peEsxyV6bmU3GZkj1thz9PpILVAoabih+0jES/Fgp5/2fEgfWuI9qNdIwQ3aXpA2ak2a16K/nSq94q2OHgyU7VIZMsuGT9okUV8LLmUXLLLn/bAsIVP8WFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749635406; c=relaxed/simple;
	bh=CxGyHpDdLe1YOdluaS5XUjj64sAbF9ip2IS7hK9qeio=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=om7ZFEEcsdu56qm507ODZxmerKBw/s2NQLxf6BQuf4Pdx/kmAtMHe7ai01FvVDqQ/Jf61ITudt+YmVjfrypPGfa4/cd0O3DL+moRH20TgDtIxIuOdIO7YqmY2OpDa4Hkin0SNuTiXbwS0+8P/B+lZ6IwY5KwX71VDKKT5wYqc0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ir9ACWe4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF2A4C4CEEE;
	Wed, 11 Jun 2025 09:50:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749635406;
	bh=CxGyHpDdLe1YOdluaS5XUjj64sAbF9ip2IS7hK9qeio=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ir9ACWe4P6g4pR4nnbS/+mCdf1Da0a+7m1RLwy6bXZQl45iVr+KJgIO7qGaz3h8Ax
	 WfrobdAnInGtZetqz37jdKEsDritrlP2zL5DvD+HYof/kXVPlmTcsvjmWIla0vew6C
	 2OTC+qqso3Wov40/RXjIGJeMAoB7pTDeYoDHhTGl7fOvYfvVhmfz8+EaUfvMTO8wnJ
	 5dkcH+0JTH3ldDMJeS261qIzqbc6Tmq3R5DCWqofM7sX9pI3qmvA6EGmZhsSYFIRCN
	 idSI1Vr2axaZEd/UMGq1jVBQZDgj/vc9NIyIG0cuwnk6WcDwKng30ICgi3DIhTZEPG
	 Zuy57S74S5mFQ==
Date: Wed, 11 Jun 2025 11:50:02 +0200
From: Christian Brauner <brauner@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, jack@suse.cz, miklos@szeredi.hu, 
	neilb@suse.de, torvalds@linux-foundation.org
Subject: Re: [PATCH v2 10/21] simple_lookup(): just set DCACHE_DONTCACHE
Message-ID: <20250611-lernmittel-gemalt-5564d150069d@brauner>
References: <20250611075023.GJ299672@ZenIV>
 <20250611075437.4166635-1-viro@zeniv.linux.org.uk>
 <20250611075437.4166635-10-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250611075437.4166635-10-viro@zeniv.linux.org.uk>

On Wed, Jun 11, 2025 at 08:54:26AM +0100, Al Viro wrote:
> No need to mess with ->d_op at all.  Note that ->d_delete that always
> returns 1 is equivalent to having DCACHE_DONTCACHE in ->d_flags.
> Later the same thing will be placed into ->s_d_flags of the filesystems
> where we want that behaviour for all dentries; then the check in
> simple_lookup() will at least get unlikely() slapped on it.
> 
> NOTE: there are only two filesystems where
> 	* simple_lookup() might be called
> 	* default ->d_op is non-NULL
> 	* its ->d_delete() doesn't always return 1
> If not for those, we could have simple_lookup() just set DCACHE_DONTCACHE
> without even looking at ->d_op.  Filesystems in question are btrfs
> (where ->d_delete() takes care to recognize the dentries that might
> come from simple_lookup() and returns 1 for those) and tracefs.
> 
> The former would be fine with simple_lookup() setting DCACHE_DONTCACHE;
> the latter... probably wants DCACHE_DONTCACHE in default d_flags.
> 
> IOW, we might want to drop the check for ->d_op in simple_lookup();
> it's definitely a separate story, though.
> 
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---

Reviewed-by: Christian Brauner <brauner@kernel.org>


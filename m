Return-Path: <linux-fsdevel+bounces-59050-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 34640B34037
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Aug 2025 15:00:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B111189D048
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Aug 2025 13:00:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32B211F2380;
	Mon, 25 Aug 2025 13:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m+QcqHHF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 832B5258EF4
	for <linux-fsdevel@vger.kernel.org>; Mon, 25 Aug 2025 13:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756126809; cv=none; b=aB5L588KAVAe0bMAcuNyg05N9yvgcgmRc0iCINJha7gtKl9CEzSfOVs6yBK9nbyvdW6XSfb6AbhoyRF1XzzxmhXltAMvjAvtJb1qFCuRb0CdAd1+c6lChBDn3j3Ke5m1g7I6Kwz/yjfRUQMutPiD4VyFX+W+Qvl/lAXrK2VncpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756126809; c=relaxed/simple;
	bh=pIHPIyTV+AyUbPK0vWXrJVfYaAmUy9SzQ3b70XOZFRg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hri87Gi+2GItXH9H4J4KwPdwnRBDvIQvijWYG4kVFrw9npMY8dSOOv1nusVwvVPGvJbws6HZHKPRqh97tO9f1w0wT9PTi4uXmk+YAMpdr3aPBF/EJhWg3OlGziSvKBxgm4u0hVUwtp1TX9QIW/ryfgZ3gOrY1xtNk1A/imkRDTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m+QcqHHF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9DC4C4CEED;
	Mon, 25 Aug 2025 13:00:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756126809;
	bh=pIHPIyTV+AyUbPK0vWXrJVfYaAmUy9SzQ3b70XOZFRg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=m+QcqHHFh4CYyBJ8+FkP3Eh56AV6oGtFK9PE6tU7zemECrvopNsrL2QSSMitkSutV
	 cK5rwsvc2lC1mBIn3rArlEg9qpy/8tReBczJKXxj0sNTpTkU0D7prF3j1KNpLEZqmH
	 234CWFzKxWm2UNUWBerMZwI4G6gYljv/IHFsOj5+X3lmuAD31hYa0GZDOS5P279pPi
	 mhujmSMiB+sDiFo8os7iHKLlUHw8GcC3etsSFF0lDM3WwnS6ero9MkCenfHioC4NiP
	 F+B8ki47ResTwNy8nKNL9SeN5zuNUneBGOqkny6RKWpHv821oUPFAP2NEmiehhhSyx
	 lodiQbUczKq6w==
Date: Mon, 25 Aug 2025 15:00:05 +0200
From: Christian Brauner <brauner@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, jack@suse.cz, 
	torvalds@linux-foundation.org
Subject: Re: [PATCH 19/52] do_move_mount(): deal with the checks on old_path
 early
Message-ID: <20250825-entziehen-geburt-9fb1ab242958@brauner>
References: <20250825044046.GI39973@ZenIV>
 <20250825044355.1541941-1-viro@zeniv.linux.org.uk>
 <20250825044355.1541941-19-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250825044355.1541941-19-viro@zeniv.linux.org.uk>

On Mon, Aug 25, 2025 at 05:43:22AM +0100, Al Viro wrote:
> 1) checking that location we want to move does point to root of some mount
> can be done before anything else; that property is not going to change
> and having it already verified simplifies the analysis.
> 
> 2) checking the type agreement between what we are trying to move and what
> we are trying to move it onto also belongs in the very beginning -
> do_lock_mount() might end up switching new_path to something that overmounts
> the original location, but... the same type agreement applies to overmounts,
> so we could just as well check against the original location.
> 
> 3) since we know that old_path->dentry is the root of old_path->mnt, there's
> no point bothering with path_is_overmounted() in can_move_mount_beneath();
> it's simply a check for the mount we are trying to move having non-NULL
> ->overmount.  And with that, we can switch can_move_mount_beneath() to
> taking old instead of old_path, leaving no uses of old_path past the original
> checks.
> 
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---

Reviewed-by: Christian Brauner <brauner@kernel.org>


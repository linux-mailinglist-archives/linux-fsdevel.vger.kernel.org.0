Return-Path: <linux-fsdevel+bounces-59805-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C041B3E182
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Sep 2025 13:27:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A597166C20
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Sep 2025 11:27:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F1EC313E2F;
	Mon,  1 Sep 2025 11:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bbm2iOBk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B2301F3BBB
	for <linux-fsdevel@vger.kernel.org>; Mon,  1 Sep 2025 11:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756726039; cv=none; b=rM1uaOimV7ZKS0kavxUTiYXq6g2RvQ/91xEZxxueLI277dNBy/TI0RnKDenRThwMYOdjEm0B5JioKhO/TqO59tN7QAwyGuQT28z1MbLp45TQ/0tdnGNubi1lf0R9pKgwiufqQWxTjRL7EJBTS6W0mnQPY/6h3c6la4f1ytDv7u8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756726039; c=relaxed/simple;
	bh=PfePGlODINV5icgE1chLh4Cg8iuI0/zjaCWE6d37LD8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MtKkV0OYa0yHBYASGTQ9HsZKQenXBQnkT/yxVH6dM4bQ+Vy1JGtu5OG36zZ0m0iGGVz6gmazduDH1mwjhpkXgBqvfihmIZvfQozdD815/aXpITnZigDu18+LrH8UbM/ZV3gzUF0UWwGuxnBdvSmxlXc4CyJt1Ry7+8gWhuFaZVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bbm2iOBk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C161C4CEF0;
	Mon,  1 Sep 2025 11:27:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756726039;
	bh=PfePGlODINV5icgE1chLh4Cg8iuI0/zjaCWE6d37LD8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bbm2iOBkSPnYEeus0HtYGdF8THyfQECLrsocNrthfId8b/mEB7P897fdD4cEWNCH/
	 bDymdL/CJJtw3BLiiTGm6MHHf6vydB4a/C5z4gRWVv7RDh+3CjOS2z4Ds6mzrWMJGh
	 bVZnfxQJsiMod9jfBd1ZYzS/U4cV7YiK33I/m/Fu4HYTa+XA936wrKc3EjyXz6LMCp
	 TOhWmMRjbVghdlIW3HeFxi2NwD3g8RR98wYu3qVsBnkdeazsFhuIsluFFtwhbKh3k9
	 78K0Wtv6mBXc1r0CVLr+JaMoVkCO2YRr1kAPjQC4MOKXrfRKLS/xH/YIDKqn80Hjbl
	 HmNB7oHFL5NCw==
Date: Mon, 1 Sep 2025 13:27:16 +0200
From: Christian Brauner <brauner@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
	linux-fsdevel@vger.kernel.org, jack@suse.cz
Subject: Re: [61/63] preparations to taking MNT_WRITE_HOLD out of ->mnt_flags
Message-ID: <20250901-geometrie-giraffe-ee600828fd06@brauner>
References: <20250828230706.GA3340273@ZenIV>
 <20250828230806.3582485-1-viro@zeniv.linux.org.uk>
 <20250828230806.3582485-61-viro@zeniv.linux.org.uk>
 <CAHk-=wgZEkSNKFe_=W=OcoMTQiwq8j017mh+TUR4AV9GiMPQLA@mail.gmail.com>
 <20250829001109.GB39973@ZenIV>
 <CAHk-=wg+wHJ6G0hF75tqM4e951rm7v3-B5E4G=ctK0auib-Auw@mail.gmail.com>
 <20250829060306.GC39973@ZenIV>
 <20250829060615.GC659926@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250829060615.GC659926@ZenIV>

On Fri, Aug 29, 2025 at 07:06:15AM +0100, Al Viro wrote:
> We have an unpleasant wart in accessibility rules for struct mount.  There
> are per-superblock lists of mounts, used by sb_prepare_remount_readonly()
> to check if any of those is currently claimed for write access and to
> block further attempts to get write access on those until we are done.
> 
> As soon as it is attached to a filesystem, mount becomes reachable
> via that list.  Only sb_prepare_remount_readonly() traverses it and
> it only accesses a few members of struct mount.  Unfortunately,
> ->mnt_flags is one of those and it is modified - MNT_WRITE_HOLD set
> and then cleared.  It is done under mount_lock, so from the locking
> rules POV everything's fine.
> 
> However, it has easily overlooked implications - once mount has been
> attached to a filesystem, it has to be treated as globally visible.
> In particular, initializing ->mnt_flags *must* be done either prior
> to that point or under mount_lock.  All other members are still
> private at that point.
> 
> Life gets simpler if we move that bit (and that's *all* that can get
> touched by access via this list) out of ->mnt_flags.  It's not even
> hard to do - currently the list is implemented as list_head one,
> anchored in super_block->s_mounts and linked via mount->mnt_instance.
> 
> As the first step, switch it to hlist-like open-coded structure -
> address of the first mount in the set is stored in ->s_mounts
> and ->mnt_instance replaced with ->mnt_next_for_sb and ->mnt_pprev_for_sb -
> the former either NULL or pointing to the next mount in set, the
> latter - address of either ->s_mounts or ->mnt_next_for_sb in the
> previous element of the set.
> 
> In the next commit we'll steal the LSB of ->mnt_pprev_for_sb as
> replacement for MNT_WRITE_HOLD.
> 
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---

Reviewed-by: Christian Brauner <brauner@kernel.org>


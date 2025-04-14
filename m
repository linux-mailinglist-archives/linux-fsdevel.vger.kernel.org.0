Return-Path: <linux-fsdevel+bounces-46413-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F45DA88E26
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Apr 2025 23:47:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 041153A5412
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Apr 2025 21:47:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3594F1F3BBB;
	Mon, 14 Apr 2025 21:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Mw81SF0g"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7347A1A9B28;
	Mon, 14 Apr 2025 21:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744667262; cv=none; b=uCA2yM32Drp97DFYMXon3FYMuNbQqoNk0NfXLmtZ0GEi5jl5uyFs29UN2dkuoz76r6YbwU7z1Il1LzelXnde2PeoCcdc6AWlpD6WIySAYxK/q0+wKBUYx5NxPFNiG91R0vvrKHsvQ1j5JMwgIObfEp3OdTKai70h/l85qTt+sXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744667262; c=relaxed/simple;
	bh=Ff776Uh707DAB51HDGiW1TU5SCO3NJAIPvfEppRKcD4=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=qGbgf05/Rv7dd17zwd1YB4Qc+y/a4m9k+RO2Pm5nLhdywp+9o2EtAbbxjs9xc5N7kTBmfzxdgnONA8UcXaPaF7i/kD6zoxZ7bGCSh82KHjTCwT6C5EP3OgiGjYGRq8Y7gZOKB80j7PwBYozlpEHaENWdKRgGztXahVtljutdPgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Mw81SF0g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3441C4CEE2;
	Mon, 14 Apr 2025 21:47:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1744667261;
	bh=Ff776Uh707DAB51HDGiW1TU5SCO3NJAIPvfEppRKcD4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Mw81SF0gpvuSEla2pIDdPcIqG/tRaqJACbGlO7XzjPbu5jSBzmPt53qvKof7IUwc7
	 YV0MyFwiismAkBUJHb+9rn6WTW/6Gc77v7O8jSTcLxVETPv9P+c030iHq0Z++AAwYU
	 za3BfqqjgB36HbZ70DyWb9Rr2Uq7aAw2nmpFVcI4=
Date: Mon, 14 Apr 2025 14:47:41 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Andreas Gruenbacher <agruenba@redhat.com>
Cc: cgroups@vger.kernel.org, Jan Kara <jack@suse.cz>, Tetsuo Handa
 <penguin-kernel@i-love.sakura.ne.jp>, Rafael Aquini <aquini@redhat.com>,
 gfs2@lists.linux.dev, linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] writeback: Fix false warning in inode_to_wb()
Message-Id: <20250414144741.56f7e4162c5faa9f3fb5c2a6@linux-foundation.org>
In-Reply-To: <20250412163914.3773459-3-agruenba@redhat.com>
References: <20250412163914.3773459-1-agruenba@redhat.com>
	<20250412163914.3773459-3-agruenba@redhat.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 12 Apr 2025 18:39:12 +0200 Andreas Gruenbacher <agruenba@redhat.com> wrote:

> From: Jan Kara <jack@suse.cz>
> 
> inode_to_wb() is used also for filesystems that don't support cgroup
> writeback. For these filesystems inode->i_wb is stable during the
> lifetime of the inode (it points to bdi->wb) and there's no need to hold
> locks protecting the inode->i_wb dereference. Improve the warning in
> inode_to_wb() to not trigger for these filesystems.
> 
> ...
>
> --- a/include/linux/backing-dev.h
> +++ b/include/linux/backing-dev.h
> @@ -249,6 +249,7 @@ static inline struct bdi_writeback *inode_to_wb(const struct inode *inode)
>  {
>  #ifdef CONFIG_LOCKDEP
>  	WARN_ON_ONCE(debug_locks &&
> +		     (inode->i_sb->s_iflags & SB_I_CGROUPWB) &&
>  		     (!lockdep_is_held(&inode->i_lock) &&
>  		      !lockdep_is_held(&inode->i_mapping->i_pages.xa_lock) &&
>  		      !lockdep_is_held(&inode->i_wb->list_lock)));

Is this a does-nothing now GFS2 has been altered?

Otherwise, a bogus WARN is something we'll want to eliminate from
-stable kernels also.  Are we able to identify a Fixes: for this?

Thanks.


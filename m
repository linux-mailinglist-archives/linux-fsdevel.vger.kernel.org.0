Return-Path: <linux-fsdevel+bounces-21499-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 487BD90496C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Jun 2024 05:14:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 007D328550B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Jun 2024 03:14:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26F791CABD;
	Wed, 12 Jun 2024 03:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="X4IPrzcW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74C68320D;
	Wed, 12 Jun 2024 03:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718162053; cv=none; b=ctQyKcxMKVl/jY8+PlmyMq9Nkd5smBvr/ZawAlwTDdVlu9tq2AXxnVHMd9fmG2y88SRNVPq6SnjwJlx2hlcipr3eZ7xAfIJQlQCaP7HPZRUHSoyMvVw39JATGwmjrOH4wXJ3UkDnD1HJmrDr0SoZN/9m65pusO65CilXOiFYAww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718162053; c=relaxed/simple;
	bh=9NodQQT4LqtoSA5lSFjpkb5Utm0D00B3WBolnHe8GMY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lRHaTc7q+/IW8MsiMsK0XP1J0LaJOIKvOSTw2+vgdonkMJB0Jh8POQGPKu4CwapZO2MLkHrqod/Zku/l6xAV+ZPkoX2x2TFxv6hCSfnITO8pOGiqqeZJ10t6NsgHper2+e4rrjO6UgTKYy9+HJaputQkTP/eNbLPjqSb0utX4SA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=X4IPrzcW; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=FIjGGRABJCKKFF6YXfYjcpA9fG0vbhL8bpLfh5T2c90=; b=X4IPrzcWTALi93DkoznpTOtARS
	je5oPERYb9xGG9pTKd/dsMWBTNe2+JZ2gw4ZLFbIx1fGxzcTItnJ3tyLc3JUGIzvjGZSZlw1dLQMt
	1dDHbBbLiSFCk664b2MFZRnjz6P3OI/k5VIJqkz6t63mZKXZDXHWNiQqt3Zd6ucIplqJERbTjCSF8
	Kx0SEwVhAFWsHi1km9OEsrHDPTGT5Kc8n8WPH4dgY7JfAoW29QGavz74h3Ip0zEDMt33l0+v4KS8Y
	b60QRZ1B7j/npy/BhcxWRhUJMTK3OZ1k/uyg5H7wWhb7AqhjWZUCYuDcCc5qrU0ShX8EFnoUNxfGe
	oSY5IZoQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1sHER2-00Eioe-0n;
	Wed, 12 Jun 2024 03:14:04 +0000
Date: Wed, 12 Jun 2024 04:14:04 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: NeilBrown <neilb@suse.de>
Cc: Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Amir Goldstein <amir73il@gmail.com>,
	James Clark <james.clark@arm.com>, ltp@lists.linux.it,
	linux-nfs@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] VFS: generate FS_CREATE before FS_OPEN when
 ->atomic_open used.
Message-ID: <20240612031404.GH1629371@ZenIV>
References: <171815791109.14261.10223988071271993465@noble.neil.brown.name>
 <20240612023748.GG1629371@ZenIV>
 <171816094008.14261.10304380583720747013@noble.neil.brown.name>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <171816094008.14261.10304380583720747013@noble.neil.brown.name>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Wed, Jun 12, 2024 at 12:55:40PM +1000, NeilBrown wrote:
> > 	IF we don't care about that, we might as well take fsnotify_open()
> > out of vfs_open() and, for do_open()/do_tmpfile()/do_o_path(), into
> > path_openat() itself.  I mean, having
> >         if (likely(!error)) {
> >                 if (likely(file->f_mode & FMODE_OPENED)) {
> > 			fsnotify_open(file);
> >                         return file;
> > 		}
> > in there would be a lot easier to follow...  It would lose fsnotify_open()
> > in a few more failure exits, but if we don't give a damn about having it
> > paired with fsnotify_close()...
> > 
> 
> Should we have fsnotify_open() set a new ->f_mode flag, and
> fsnotify_close() abort if it isn't set (and clear it if it is)?
> Then we would be guaranteed a balance - which does seem like a good
> idea.

Umm...  In that case, I would rather have FMODE_NONOTIFY set just before
the fput() in path_openat() - no need to grab another flag from ->f_mode
(not a lot of unused ones there) and no need to add any overhead on
the fast path.


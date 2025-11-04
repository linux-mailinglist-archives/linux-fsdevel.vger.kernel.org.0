Return-Path: <linux-fsdevel+bounces-67001-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F10BC32FAA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 04 Nov 2025 21:56:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 042E63A61A3
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Nov 2025 20:56:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74B2F2ED165;
	Tue,  4 Nov 2025 20:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vOVgxcS0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C142DD27E;
	Tue,  4 Nov 2025 20:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762289769; cv=none; b=Pdayhy/A0zpKn/6j4z1JJmC3lCzc+U5U/M5XPsPge1bHGqZK3C9zkZVCdCJ58mv7DQJR7UPfv5zy0rwT21hoyCTDhx3VbLy7QxP69pTSZeKI+LcDd5UyF7BPOKkGVJX6DOd3FkYcJpERoxP3DpvaNBCMuPeL/+Kdj42lEi0TcA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762289769; c=relaxed/simple;
	bh=CTwm0rIOhacb72jtcjpFSe+ocHf2I6iphM3+Xt9t/Kc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sjD78DWe39rrwleu27sRT/68r+fhsUd3WTeKlfNKg5u3fjK1J4xOdciUMbuxcHCxf49gO7FwCXihlDn5droqm80S0Ams9QHIIA9N9ylfGBcsxmsYZZ+rAynKPJ167qRMpFIyOmVe7V6Pz/zQgmiePSbVACVGb35FnOwqxC8YUKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vOVgxcS0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B00FC4CEF7;
	Tue,  4 Nov 2025 20:56:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762289764;
	bh=CTwm0rIOhacb72jtcjpFSe+ocHf2I6iphM3+Xt9t/Kc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vOVgxcS0aIQJht/b8AzRar6NDg+NMYHEI6W3uU5+EMMqvaGT6JVgo3yhgJ84lnnsy
	 p226OiGF7nQzycvBKSO+ki1oVXDsOualYVQunHi8WdlaoPVQSS2gpvo6Cht0XKWlmp
	 FTvQNtxHNeWp4KFy3X6rRQ1tTMmy9bIBJeOSFwbNHVOUsQzUy8RQrOmuzpZi7YsvX2
	 BhUlg8RXHGDDvZMNGmGxVs6DM48vSurV/qr33/BqMec5xBF58HRjOP7OK8vMK8ZZ7c
	 DwFfH1zxgTteSank4iO/GHvzuL5vVoVKGoe3gfESyjnV7OpMWPy2E8jbDBFfjL1A5t
	 SUCJaQdYPt8nw==
Date: Tue, 4 Nov 2025 21:56:00 +0100
From: Christian Brauner <brauner@kernel.org>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: linux-fsdevel@vger.kernel.org, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, linux-btrfs@vger.kernel.org, 
	linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: [PATCH RFC 4/8] btrfs: use super write guard in sb_start_write()
Message-ID: <20251104-abgearbeitet-rotwild-09b3c0375625@brauner>
References: <20251104-work-guards-v1-0-5108ac78a171@kernel.org>
 <20251104-work-guards-v1-4-5108ac78a171@kernel.org>
 <cxrp3a7wu5lz5o6fiwleqiqwqm6xyevdjiega77mwxy5aekeab@522tt37vnwip>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cxrp3a7wu5lz5o6fiwleqiqwqm6xyevdjiega77mwxy5aekeab@522tt37vnwip>

On Tue, Nov 04, 2025 at 06:00:29PM +0100, Mateusz Guzik wrote:
> On Tue, Nov 04, 2025 at 01:12:33PM +0100, Christian Brauner wrote:
> > Signed-off-by: Christian Brauner <brauner@kernel.org>
> > ---
> >  fs/btrfs/volumes.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> > index 2bec544d8ba3..4152b0a5537a 100644
> > --- a/fs/btrfs/volumes.c
> > +++ b/fs/btrfs/volumes.c
> > @@ -4660,7 +4660,8 @@ static int balance_kthread(void *data)
> >  	struct btrfs_fs_info *fs_info = data;
> >  	int ret = 0;
> >  
> > -	sb_start_write(fs_info->sb);
> > +	guard(super_write)(fs_info->sb);
> > +
> >  	mutex_lock(&fs_info->balance_mutex);
> >  	if (fs_info->balance_ctl)
> >  		ret = btrfs_balance(fs_info, fs_info->balance_ctl, NULL);
> > 
> 
> this missed sb_end_write call removal

Thanks, fixed!


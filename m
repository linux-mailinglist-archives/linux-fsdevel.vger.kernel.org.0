Return-Path: <linux-fsdevel+bounces-11255-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4DA78522DB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Feb 2024 00:59:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 241431C23224
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Feb 2024 23:59:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 662BB5027B;
	Mon, 12 Feb 2024 23:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="MWcgTzfx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53C253EA78
	for <linux-fsdevel@vger.kernel.org>; Mon, 12 Feb 2024 23:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707782390; cv=none; b=RXaujj3um3JMW1QH6l4Xgae6IgNTVtuG+EtsrP6oaBmSfja0PFZvL+47qog2lsmujizIaZlQi1py4yEAL4li5ACmu0kS5XEkDFkwz5zJUgRAU2zG+1+M3J2yFhNXJPJoYav/9TeWjSOp1GmQGns4iNw2Yw5urXDs1FAF8bVwMyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707782390; c=relaxed/simple;
	bh=lq6R7JhhffXQqYsw587qV6VPo4SWnKu9fb6zW3R3lXw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e1cv7XNwuFcmu90rlHVlMOb/p75SLYgaQE34wdHUp1KCMb098TFcJcz6houpEHvhj4rP5OkkZ8fkX59hSRrRYi2jz0k9dfgIvRvII30PoRhVlaenf1V5fHu7YimF8LPIYS+MLKdpFjnf3IKKLgtpizoA2BpPBdMytYJNOiaFVPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=MWcgTzfx; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1d51ba18e1bso37183605ad.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 12 Feb 2024 15:59:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1707782388; x=1708387188; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=IWnTDwnlCRJE7nFTprB0Ikx3yROJw68dJDC0nr6br3s=;
        b=MWcgTzfxuk1EEl/FYS9gB8xId1qGvdN0SMaxk9OG0fzWIiazdYTtcZSdiVge0vxElm
         9BA3DqQeWsVvwNaigO0dFU7OaniYlLNCmd4k1bZK1OPq4seDFEIoZFi0Rr073AfGULxb
         aL4Idt268BgLTVJDoEnBrfGeQkzNxFInZxbls=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707782388; x=1708387188;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IWnTDwnlCRJE7nFTprB0Ikx3yROJw68dJDC0nr6br3s=;
        b=nzm+EW9d+HK4fI+v99JJe5QJ/0PP/3XDW7bn7QY6dmVVh1qXpi+DIsMhL5eW5HoeMV
         85HoGAaXWCQsyuC/SUkKBIWg8Fl/2BqrfsmyuoI44KbtzurkRAh7t5eoNhyvZtLKGR64
         kCNtAuZSBF/ObPwTBIsJR8EmOWr/vtoITOJFQbCl4E3h6+Ro2SPFa2fQavd7WBMEPYVK
         QrBaYFZ5A+S4Yp4tQm8LMmwWbTzhvJX1bWYP6lSBKgOfoNg0F/Os+ZFSw+h0tRveEA6E
         GhJfiC9clf+2a6+RhebexjdRnZGztdthR68zA2T9xWND60xGzuGQHi1xUw/dDgdX2Als
         DO4Q==
X-Gm-Message-State: AOJu0YxAgSrjGI1bxUdMUNxS+ptLW9c6xUH5VgdrCs0q9RgWl89D8HbJ
	JwBjOuYxHNnBbx2f/YTYXeVu4YLwVKY70ztxWjTeu4LzFa3hTu2Wmwx3t5bThRXDP+FY/3wHJn8
	=
X-Google-Smtp-Source: AGHT+IEk3fkHirNPHcV+Jtn4OAXXv5rRuBH+wPklcmU7Sv/10VyOrM3sgiPBpVmotRPvP2lR56M5OA==
X-Received: by 2002:a17:90a:8987:b0:296:4f7f:c3ca with SMTP id v7-20020a17090a898700b002964f7fc3camr6232113pjn.21.1707782388578;
        Mon, 12 Feb 2024 15:59:48 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id s13-20020a17090330cd00b001d8f39bf108sm896471plc.80.2024.02.12.15.59.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Feb 2024 15:59:48 -0800 (PST)
Date: Mon, 12 Feb 2024 15:59:47 -0800
From: Kees Cook <keescook@chromium.org>
To: Jan Kara <jack@suse.cz>
Cc: linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] quota: Detect loops in quota tree
Message-ID: <202402121559.8B96E093B@keescook>
References: <20240209112250.10894-1-jack@suse.cz>
 <202402121046.42785619B@keescook>
 <20240212234856.dx7eaf6xdvtqga6p@quack3>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240212234856.dx7eaf6xdvtqga6p@quack3>

On Tue, Feb 13, 2024 at 12:48:56AM +0100, Jan Kara wrote:
> On Mon 12-02-24 10:47:28, Kees Cook wrote:
> > On Fri, Feb 09, 2024 at 12:22:50PM +0100, Jan Kara wrote:
> > > [...]
> > > @@ -613,15 +658,17 @@ static loff_t find_block_dqentry(struct qtree_mem_dqinfo *info,
> > >  
> > >  /* Find entry for given id in the tree */
> > >  static loff_t find_tree_dqentry(struct qtree_mem_dqinfo *info,
> > > -				struct dquot *dquot, uint blk, int depth)
> > > +				struct dquot *dquot, uint *blks, int depth)
> > >  {
> > >  	char *buf = kmalloc(info->dqi_usable_bs, GFP_NOFS);
> > >  	loff_t ret = 0;
> > >  	__le32 *ref = (__le32 *)buf;
> > > +	uint blk;
> > > +	int i;
> > >  
> > >  	if (!buf)
> > >  		return -ENOMEM;
> > > -	ret = read_blk(info, blk, buf);
> > > +	ret = read_blk(info, blks[depth], buf);
> > >  	if (ret < 0) {
> > >  		quota_error(dquot->dq_sb, "Can't read quota tree block %u",
> > >  			    blk);
> >                             ^^^
> > Coverity noticed this is used uninitialized. It should be "blks[depth]"
> > now, I think.
> 
> Yup, already pushed fix to my tree as 0-day notified me as well :) But
> thanks for noticing!

Ah-ha! Thanks :)

-- 
Kees Cook


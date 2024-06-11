Return-Path: <linux-fsdevel+bounces-21428-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 005D4903A69
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Jun 2024 13:37:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 08A251C22C5F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Jun 2024 11:37:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D87017B514;
	Tue, 11 Jun 2024 11:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O7aiwTj0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 383B5171644;
	Tue, 11 Jun 2024 11:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718105668; cv=none; b=BaUCKflApIa1jdKvZU0RsQtglp20KN4YSMb6Zk38Eg3n8b3qnoPlsyAKYcd0xAcNqlrlJjO0EGHbUGTidMr4Mz3ARV9tit3KWrWdxLA4+yRTSERm+nmz5CHpbjZJ3X8tqkJ2RssRAEZyNS40uSAbtlzcFb00vKbjpi+qZDp3c90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718105668; c=relaxed/simple;
	bh=lgMdaGmCPRH+3LfLApnRp+QzYV7UGkzgZMXXTOVZe9Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qd8Eh9rEV8eUlcd3YkBwUoERGUGwxlEl3V3cNsRDdEF8zACJ5WNhDxCUvUQFbQ2PAkta2ytjdIPOUSGkFu07ZI/g2XhjaliyqMcRzPyrdUNka/I5HfMmscf2j/8rSv+4ZwJRw0ggZV3Gp3XkUm6hPj34OIKE7ZCcrKVft0X0jWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O7aiwTj0; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-35f0f4746c2so702895f8f.3;
        Tue, 11 Jun 2024 04:34:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718105665; x=1718710465; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HlD8loeKV8w1EBghL7dw9jtTM30qBeXBqWr6znCZpWo=;
        b=O7aiwTj0fYojdlF8pjAgHyc7zrGs0PyS6xQQq13ygSAEmJYhJs2xXS/OitXjjCkkz/
         xh+fZsa3zZ3MD2CDQO9+iXBoMK9cMSy9nZxOq6l4vqVpsgN3gBPhWenYm0HznTuejwnn
         rPjVgjuR4L6Qzcofc1mWR8A/VtLtzV7TVuq6pXi2LNzqAJvCgE+Ot/lGrBUyQmO1V3PJ
         08g0GNbGtsSovfi8gzzuiIhavdgFkst/wIpEN4foh92u6TYDuYcq78tr0usHdua3IeKC
         EFSJma76Gryjea/wxfffPEuc9JAlbmhPnevucLrwVd9RUvunZxLfypiZ8vDUWz9rwZ/c
         hgew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718105665; x=1718710465;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HlD8loeKV8w1EBghL7dw9jtTM30qBeXBqWr6znCZpWo=;
        b=SGoihm+DcjKMPwWimti0/46oLosYRGMrxnquWgv/8XhwK0aIYs0Ey2VM4Prl57UjZz
         AoWlflAIO8IO7lSZDJGHjqy5nerIAoDh7GzfJzR47+Q5dfZ6H+g+WXxEXt2j55+MrHMJ
         cI+S+OGh7m3K6YO8BoymV0s3HF1VgrKQzd81tOAIGw1VLyuLjFyVu9tlp9X/r5FYv5lf
         oPzEy/oxbq4I8nzI8eP61UpTlqvXS+ZhqA7BsnN8i+8uVZkZ/MkI/05HViYIyqb7vlCC
         hTr9cxBWoqsCpxbGL1UhsUJ/iAIepIHCWhe9fV3GVSpndGDbY3k6Br61tEAogsyQeJqx
         UC0Q==
X-Forwarded-Encrypted: i=1; AJvYcCVCdDVPkEjXcw0pYwUJWovlP+h6qNW9G0JFkepHajAlWJuURxDqEnoeODXhuL5QoERy6st8pB76SSL72yfIds7B/NON8ey4Jl0XXK5cB5gsTsaUEp1E13QhNKgl4RmqxB7J3LfmpL61u+3mPg==
X-Gm-Message-State: AOJu0Yx59Sg8VHishIzyVoJaW0kKZzKC7J4knjVzvtmSPH/42QK++Jfl
	Px3ssnfuOOq9+YLPC8Z0ljCD7OSl7LcEuEaEz7KKa/Z5ydUFRvOp
X-Google-Smtp-Source: AGHT+IEtoKBTY3mWsQ0cFYgh5+pGCUHk1MHqLMF4DKj5V7rLcmoHSGA20A8XC8fy4FRRbpKhSCrq0Q==
X-Received: by 2002:a5d:6482:0:b0:35f:2256:1722 with SMTP id ffacd0b85a97d-35f225617aamr5468205f8f.33.1718105665379;
        Tue, 11 Jun 2024 04:34:25 -0700 (PDT)
Received: from f (cst-prg-65-249.cust.vodafone.cz. [46.135.65.249])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35f27c8a444sm3876601f8f.53.2024.06.11.04.34.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jun 2024 04:34:24 -0700 (PDT)
Date: Tue, 11 Jun 2024 13:34:18 +0200
From: Mateusz Guzik <mjguzik@gmail.com>
To: Jan Kara <jack@suse.cz>
Cc: brauner@kernel.org, viro@zeniv.linux.org.uk, david@fromorbit.com, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] vfs: partially sanitize i_state zeroing on inode creation
Message-ID: <7tl2j4usjuf7bl4l4ikhy5nz3ssars6w4jq3esjluteex5o6tc@en4qbkcpdgiu>
References: <20240611041540.495840-1-mjguzik@gmail.com>
 <20240611100222.htl43626sklgso5p@quack3>
 <kge4tzrxi2nxz7zg3j2qxgvnf4fcaywtlckgsc7d52eubvzmj4@zwmwknndha5y>
 <20240611110505.udtzfwgj3o4vxrxl@quack3>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240611110505.udtzfwgj3o4vxrxl@quack3>

On Tue, Jun 11, 2024 at 01:05:05PM +0200, Jan Kara wrote:
> On Tue 11-06-24 12:23:59, Mateusz Guzik wrote:
> > On Tue, Jun 11, 2024 at 12:02:22PM +0200, Jan Kara wrote:
> > > On Tue 11-06-24 06:15:40, Mateusz Guzik wrote:
> > > > new_inode used to have the following:
> > > > 	spin_lock(&inode_lock);
> > > > 	inodes_stat.nr_inodes++;
> > > > 	list_add(&inode->i_list, &inode_in_use);
> > > > 	list_add(&inode->i_sb_list, &sb->s_inodes);
> > > > 	inode->i_ino = ++last_ino;
> > > > 	inode->i_state = 0;
> > > > 	spin_unlock(&inode_lock);
> > > > 
> > > > over time things disappeared, got moved around or got replaced (global
> > > > inode lock with a per-inode lock), eventually this got reduced to:
> > > > 	spin_lock(&inode->i_lock);
> > > > 	inode->i_state = 0;
> > > > 	spin_unlock(&inode->i_lock);
> > > > 
> > > > But the lock acquire here does not synchronize against anyone.
> > > > 
> > > > Additionally iget5_locked performs i_state = 0 assignment without any
> > > > locks to begin with and the two combined look confusing at best.
> > > > 
> > > > It looks like the current state is a leftover which was not cleaned up.
> > > > 
> > > > Ideally it would be an invariant that i_state == 0 to begin with, but
> > > > achieving that would require dealing with all filesystem alloc handlers
> > > > one by one.
> > > > 
> > > > In the meantime drop the misleading locking and move i_state zeroing to
> > > > alloc_inode so that others don't need to deal with it by hand.
> > > > 
> > > > Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
> > > 
> > > Good point. But the initialization would seem more natural in
> > > inode_init_always(), wouldn't it? And that will also address your "FIXME"
> > > comment.
> > > 
> > 
> > My point is that by the time the inode is destroyed some of the fields
> > like i_state should be set to a well-known value, this one preferably
> > plain 0.
> 
> Well, i_state is set to a more or less well defined value but it is not
> zero. I don't see a performance difference in whether set it to 0 on
> freeing or on allocation and on allocation it is actually much easier to
> find when reading the code.
> 

I was thinking more about assertion potential, not anything
perf-related, but it is a moot subject now.

> > I did not patch inode_init_always because it is exported and xfs uses it
> > in 2 spots, only one of which zeroing the thing immediately after.
> > Another one is a little more involved, it probably would not be a
> > problem as the value is set altered later anyway, but I don't want to
> > mess with semantics of the func if it can be easily avoided.
> 
> Well, I'd consider that as another good reason to actually clean this up.
> Look, inode_init_always() is used in bcachefs and xfs. bcachefs sets
> i_state to 0 just before calling inode_init_always(), xfs just after one
> call of inode_init_always() and the call in xfs_reinit_inode() is used
> only from xfs_iget_recycle() which sets i_state to I_NEW. So I claim that
> moving i_state clearing to inode_init_always() will not cause any issue and
> is actually desirable.
> 

Ok, see my reply to Dave's e-mail.

Just tell me how to ship this and I'll do the needful(tm).


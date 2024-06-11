Return-Path: <linux-fsdevel+bounces-21404-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E6A2C9038C5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Jun 2024 12:24:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6398B285C59
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Jun 2024 10:24:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EF91171093;
	Tue, 11 Jun 2024 10:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K60imDxG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC4B154750;
	Tue, 11 Jun 2024 10:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718101452; cv=none; b=tbjEcoi0YVr55m2zODiHZaqArv0xzlp1NH3JTxPlo3x2ZMMli+b1pUIYgshqn1zxcR6qTZv59as4Pn+QyCQv6ZtV3pBTK0henU0yiepQ4+mlmM7fdcdK7O547DPKaODKSWzkOEwnFG0VL54ZGP3DBE65tVb9z8TtwmQL1Ae5fDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718101452; c=relaxed/simple;
	bh=rS4Lc1OnZtSXD73LoxWr41swx5eOanIZrCW+Tnjwa2I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dV1qH8rq68mDJPNsRJDdzeETxSWWlVOkvxaalZ6XVMCGiQTQvxUOsmDV4MtIu6PkhUXvCBGG60NvHnJgO9YxHVkYmKYOmr6AJ2DtQ2duv8pu94gx1Hy1xqrclNCL2TfKjp4zBPMWrnN9248BOyNHQ+unbF2BGSzBy5Vzf2mwtpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K60imDxG; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2ebed33cb65so16821871fa.2;
        Tue, 11 Jun 2024 03:24:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718101449; x=1718706249; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TuXsJaF8TTlzJOvjlDFq2MCLBqc2IGjgSWzZHxQCqBs=;
        b=K60imDxGGi07zI92EpZPNv4br1lG5zmmQbaEflcXULOdgKSV9kEMXL3PQO6j+fRVIC
         DyE5cV6zi7Z1ax3AJjYnK/KXOLfCJ3I8USnv1Y2OlyeX230mbvyx8sGeLAZR9z+mwSnB
         CjngX9YNVIYcG+DobPvYhLKBPoVaJXW2R07krs+Zo5nyaX/WBfGxBRhpU89x3xG2C/Mh
         egeua0ZY9wgQrXuM8gFyLjagkzcNveD4F57lR4aA2dKRNIItg0WTnVe+V404m8vDjcH6
         cJ+c3zbBxMUjwT9tIbwZh0jV5ujb7nMZ7quU0hUb4ILhIeam0DYV5KhsGaQajVhq3w+A
         T0HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718101449; x=1718706249;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TuXsJaF8TTlzJOvjlDFq2MCLBqc2IGjgSWzZHxQCqBs=;
        b=B+4oizE1PMQJDFUnU9btB40nzsn9NXdNEKwr1p1QJFmURdKhhlSCYy88F+15DAyvGf
         YRNtt4AbyYyEVKl9K15OPM+h6+Bpow7yjpXhqTXI+2hDk9Xh2mc7CViQl4sK3YxNMo9E
         boGXKfx4pTiCEcIAlBW3reMjOS2p2RC/SyvIXpYuo8dSXIAfnZH0rRYCGEZbI5XhrmL/
         n6HVx8phqArhNp7FIjG2Z4goG/dJymBsMIW63UCewmzaNCChaNpb5JQZOWVgMB1XrJGD
         TcoN26uOsWf/7VwTyT+uk62l7/48v5vqq+UHNZVTH+5gW7VYcp0bNb79hb/fDHFxMRwS
         FzpA==
X-Forwarded-Encrypted: i=1; AJvYcCXPRqflJw9A0xByxLz796LeQhXVHieRFVjWjYVq5cgMHLZ/vXHVZgjYWYlIK/IbYrg+GacdvXnUUv+Jxs1kudYhxG7DVdUCB63xNLJtSxcBjAPgMLw1YIf9JLSxMrgntXqKCsOssuvi6fHcXA==
X-Gm-Message-State: AOJu0YyDWChCE4Q6OQhkOot/n+9mqvz57kdHYyapYSUTA3fmWbmgFeYw
	dF4mc5E6sWV9yNQfzRk4iwg1sY8Z01YGQQR40TkhSn8Q0Zg2ayh7f+OoKQ==
X-Google-Smtp-Source: AGHT+IGY57VwKx0yADjfisTVufxhi3uNlLLs7D+06YhPfz7MMOCWr6sKhHf0xjMzwM2tmWpPJxv2YQ==
X-Received: by 2002:a2e:a78f:0:b0:2eb:eb87:5504 with SMTP id 38308e7fff4ca-2ebeb87560dmr31493521fa.27.1718101448965;
        Tue, 11 Jun 2024 03:24:08 -0700 (PDT)
Received: from f (cst-prg-65-249.cust.vodafone.cz. [46.135.65.249])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42274379b83sm627385e9.28.2024.06.11.03.24.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jun 2024 03:24:08 -0700 (PDT)
Date: Tue, 11 Jun 2024 12:23:59 +0200
From: Mateusz Guzik <mjguzik@gmail.com>
To: Jan Kara <jack@suse.cz>
Cc: brauner@kernel.org, viro@zeniv.linux.org.uk, david@fromorbit.com, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] vfs: partially sanitize i_state zeroing on inode creation
Message-ID: <kge4tzrxi2nxz7zg3j2qxgvnf4fcaywtlckgsc7d52eubvzmj4@zwmwknndha5y>
References: <20240611041540.495840-1-mjguzik@gmail.com>
 <20240611100222.htl43626sklgso5p@quack3>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240611100222.htl43626sklgso5p@quack3>

On Tue, Jun 11, 2024 at 12:02:22PM +0200, Jan Kara wrote:
> On Tue 11-06-24 06:15:40, Mateusz Guzik wrote:
> > new_inode used to have the following:
> > 	spin_lock(&inode_lock);
> > 	inodes_stat.nr_inodes++;
> > 	list_add(&inode->i_list, &inode_in_use);
> > 	list_add(&inode->i_sb_list, &sb->s_inodes);
> > 	inode->i_ino = ++last_ino;
> > 	inode->i_state = 0;
> > 	spin_unlock(&inode_lock);
> > 
> > over time things disappeared, got moved around or got replaced (global
> > inode lock with a per-inode lock), eventually this got reduced to:
> > 	spin_lock(&inode->i_lock);
> > 	inode->i_state = 0;
> > 	spin_unlock(&inode->i_lock);
> > 
> > But the lock acquire here does not synchronize against anyone.
> > 
> > Additionally iget5_locked performs i_state = 0 assignment without any
> > locks to begin with and the two combined look confusing at best.
> > 
> > It looks like the current state is a leftover which was not cleaned up.
> > 
> > Ideally it would be an invariant that i_state == 0 to begin with, but
> > achieving that would require dealing with all filesystem alloc handlers
> > one by one.
> > 
> > In the meantime drop the misleading locking and move i_state zeroing to
> > alloc_inode so that others don't need to deal with it by hand.
> > 
> > Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
> 
> Good point. But the initialization would seem more natural in
> inode_init_always(), wouldn't it? And that will also address your "FIXME"
> comment.
> 

My point is that by the time the inode is destroyed some of the fields
like i_state should be set to a well-known value, this one preferably
plain 0.

I did not patch inode_init_always because it is exported and xfs uses it
in 2 spots, only one of which zeroing the thing immediately after.
Another one is a little more involved, it probably would not be a
problem as the value is set altered later anyway, but I don't want to
mess with semantics of the func if it can be easily avoided.


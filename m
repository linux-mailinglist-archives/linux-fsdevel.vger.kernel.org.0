Return-Path: <linux-fsdevel+bounces-34572-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C19549C65FD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Nov 2024 01:28:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9658FB2F544
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Nov 2024 00:13:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D051FA94D;
	Wed, 13 Nov 2024 00:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="Gofc95h1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D71A66FC5;
	Wed, 13 Nov 2024 00:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731456778; cv=none; b=HkjOAYR8QcFNjYAUC5DvINCnI8YtIYyD3/itTEyt24XWCIppv9LTWhmtHZhdt+CY8Ej19C35gYEjv9L2YC+LrMSgNdbgrSHN1ITh7DFsQPrUMkEE6QIY3F6fTUKbvtChNlIS4Mf4+MpCrpUWfiDXYmJjp2gZpj7ocWHvaPWwKPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731456778; c=relaxed/simple;
	bh=EobwpFYxx0YbQ5+ecPqfvIOcQwHsl/JP6WVy7Rky934=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PKn3ceaXOMZXJbohfXJvkTNKx0eqOFaBeuUqZzi/bRC5EUnhEjR41f8b5WY7iy+6EAR/3N/tbp389EsP9KxNVgFisPYuXfoc40G9HA4Ed6kXb7fXN8aBdknR3AdzuMoDX0Lqb2vlaZcThpZ92fve76qgxybGxm1KQSOZdFwF1ds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=Gofc95h1; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=0DSwtmhbJLell6AcTjRyBN5kQjWgo7kIs830Ev76bPY=; b=Gofc95h16q6EJZk78rYwvMMf1v
	xuh6Iq77vpS8jnhMS7AYTia0NFuGcYePnv8bX5YedMkAokC0okuSJMPJRclv5SQe/4v0LrZDDhFBB
	TwwDYYf+SGR8G5AZ/8wQtx7wIDSF6YWaTEGhdETb07S4ZPwdSQZXfTsdeB8fWsA8Zj+ypz3iHDjmG
	saOLvWEUSm3akuOzGyyMx67sLrEB5IwU049a7QZnlZsRBVxMrfWyLvwXUx3fX1jKzHpjE3rXL7zZv
	YFXSfIXhoJy8JYfz+7HQc3zwNfTfPfM2oPM4IM8LzHETaHqtyI7DnFhX0mK8hwR37+s9lxyeCJ+8J
	a0KGKqhg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tB107-0000000EIYh-2CYw;
	Wed, 13 Nov 2024 00:12:51 +0000
Date: Wed, 13 Nov 2024 00:12:51 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Amir Goldstein <amir73il@gmail.com>, Josef Bacik <josef@toxicpanda.com>,
	kernel-team@fb.com, linux-fsdevel@vger.kernel.org, jack@suse.cz,
	brauner@kernel.org, linux-xfs@vger.kernel.org,
	linux-btrfs@vger.kernel.org, linux-mm@kvack.org,
	linux-ext4@vger.kernel.org
Subject: Re: [PATCH v7 05/18] fsnotify: introduce pre-content permission
 events
Message-ID: <20241113001251.GF3387508@ZenIV>
References: <cover.1731433903.git.josef@toxicpanda.com>
 <141e2cc2dfac8b2f49c1c8d219dd7c20925b2cef.1731433903.git.josef@toxicpanda.com>
 <CAHk-=wjkBEch_Z9EMbup2bHtbtt7aoj-o5V6Nara+VxeUtckGw@mail.gmail.com>
 <CAOQ4uxiiFsu-cG89i_PA+kqUp8ycmewhuD9xJBgpuBy5AahG5Q@mail.gmail.com>
 <CAHk-=wijFZtUxsunOVN5G+FMBJ+8A-+p5TOURv2h=rbtO44egw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wijFZtUxsunOVN5G+FMBJ+8A-+p5TOURv2h=rbtO44egw@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Tue, Nov 12, 2024 at 03:48:10PM -0800, Linus Torvalds wrote:
> On Tue, 12 Nov 2024 at 15:06, Amir Goldstein <amir73il@gmail.com> wrote:
> >
> > I am fine not optimizing out the legacy FS_ACCESS_PERM event
> > and just making sure not to add new bad code, if that is what you prefer
> > and I also am fine with using two FMODE_ flags if that is prefered.
> 
> So iirc we do have a handful of FMODE flags left. Not many, but I do
> think a new one would be fine.

8, 13, 24, 30 and 31.

> But if anybody is really worried about running out of f_mode bits, we
> could almost certainly turn the existing
> 
>         unsigned int f_flags;
> 
> into a bitfield, and make it be something like
> 
>         unsigned int f_flags:26, f_special:6;
> 
> instead, with the rule being that "f_special" only gets set at open
> time and never any other time (to avoid any data races with fcntl()
> touching the other 24 bits in the word).

Ugh...  Actually, I would rather mask that on fcntl side (and possibly
moved FMODE_RANDOM/FMODE_NOREUSE over there as well).

Would make for simpler rules for locking - ->f_mode would be never
changed past open, ->f_flags would have all changes under ->f_lock.


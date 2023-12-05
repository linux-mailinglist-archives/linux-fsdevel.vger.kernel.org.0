Return-Path: <linux-fsdevel+bounces-4848-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD87F804A48
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Dec 2023 07:37:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 18B601C20D75
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Dec 2023 06:37:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7794012E47
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Dec 2023 06:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="VDe5+ovG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29BF0D7
	for <linux-fsdevel@vger.kernel.org>; Mon,  4 Dec 2023 22:27:32 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1d076ebf79cso12310965ad.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 04 Dec 2023 22:27:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1701757651; x=1702362451; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bhXYhRtk/KY/XHQgM/c3wDRTe8PmVUkWLPFRhdkev5c=;
        b=VDe5+ovG8apuH9dXqs7gsMH9oPS5VeZljXRRqfAjOh2gxR7byrpmJBz8ho6pfbKHwj
         qOQueLGVaKVco4VFZRtCC3urwX7rrqenY+YpYgYxCLlpClPkSJH0xmSYE3BeRS9oLQuk
         rL6H1uJbzrwFyzUTAfBYsQvJZxkBcjymMIx5M/QYqN1BOvG9AEOiADt3hAIdSJY+5yHb
         uxk8ARsAojkzwMwWN+ZbGr9H+HSetccLBaaK5uXCR5bONn87bPUp4cFUc7fjI+EVf4uL
         of3qfum9sd2ESOS3hGv6ksMK4/wPitekuefp+H7TRUs/GZsktGX+ozYqhed46pnSZjiE
         zGdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701757651; x=1702362451;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bhXYhRtk/KY/XHQgM/c3wDRTe8PmVUkWLPFRhdkev5c=;
        b=PqUbUn3c4Ozftv7xuu4fc0hSlrAC3be7JcCDJ3Hi2s9jpPXOQGXvIo506xW+2C1px0
         BUrp3mbTYHqxRGcKsWoO3Zlmznyqq1CtvZR/BbdTINIuBETIc7JfYcil1B+AyAja1T+2
         6fA87fBJ/+TOCYlAoQAki9uK3jn5wIVjuW9lA4XOqwHbuePyDVLJXwHu52cT6QFUhPXa
         V3OOrGLkLxXXdZ4KptvYs1OJ2S8RiT3/i4hClu9VYL9nlREo7ZUPQLfvs6ZqMcYK+BMR
         wb7Q4iQ6ilRaIYJ+DzIjNLHc3yuiK0INuTL6BVehrbA5tvQdZkIp36GHm9tp0fWzQBxR
         MUPA==
X-Gm-Message-State: AOJu0Yy2XgquOxjHJqXoKZiFJBcrsnNTngxDZjRzxRLXPWX6AuMrqj+D
	rQJFf25ZWYbe5RO2198Ijk0Xbg==
X-Google-Smtp-Source: AGHT+IEUis2isZKyvLiufA2OSYo4xSVBLvpOU4Mj0HrgxtGTqwJ5IEKmqVKYaMx9UVf4tDFqmIy5mw==
X-Received: by 2002:a17:902:c40d:b0:1cf:6ac3:81c2 with SMTP id k13-20020a170902c40d00b001cf6ac381c2mr3414170plk.47.1701757651517;
        Mon, 04 Dec 2023 22:27:31 -0800 (PST)
Received: from dread.disaster.area (pa49-180-125-5.pa.nsw.optusnet.com.au. [49.180.125.5])
        by smtp.gmail.com with ESMTPSA id k10-20020a170902c40a00b001d087f68ef8sm543248plk.37.2023.12.04.22.27.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Dec 2023 22:27:31 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1rAOu0-00449x-2P;
	Tue, 05 Dec 2023 17:27:28 +1100
Date: Tue, 5 Dec 2023 17:27:28 +1100
From: Dave Chinner <david@fromorbit.com>
To: NeilBrown <neilb@suse.de>
Cc: Al Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jens Axboe <axboe@kernel.dk>, Oleg Nesterov <oleg@redhat.com>,
	Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-nfs@vger.kernel.org
Subject: Re: [PATCH 1/2] Allow a kthread to declare that it calls
 task_work_run()
Message-ID: <ZW7C0Cq+WZz+fnaS@dread.disaster.area>
References: <20231204014042.6754-1-neilb@suse.de>
 <20231204014042.6754-2-neilb@suse.de>
 <20231204024031.GV38156@ZenIV>
 <170172483155.7109.15983228851050210918@noble.neil.brown.name>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <170172483155.7109.15983228851050210918@noble.neil.brown.name>

On Tue, Dec 05, 2023 at 08:20:31AM +1100, NeilBrown wrote:
> On Mon, 04 Dec 2023, Al Viro wrote:
> > On Mon, Dec 04, 2023 at 12:36:41PM +1100, NeilBrown wrote:
> > 
> > > This means that any cost for doing the work is not imposed on the kernel
> > > thread, and importantly excessive amounts of work cannot apply
> > > back-pressure to reduce the amount of new work queued.
> > 
> > It also means that a stuck ->release() won't end up with stuck
> > kernel thread...
> 
> Is a stuck kernel thread any worse than a stuck user-space thread?
> 
> > 
> > > earlier than would be ideal.  When __dput (from the workqueue) calls
> > 
> > WTF is that __dput thing?  __fput, perhaps?
> 
> Either __fput or dput :-)
> ->release isn't the problem that I am seeing.
> The call trace that I see causing problems is
> __fput -> dput -> dentry_kill -> destroy_inode -> xfs_fs_destroy_inode

What problem, exactly, are you having with xfs_fs_destroy_inode()?

-Dave.
-- 
Dave Chinner
david@fromorbit.com


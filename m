Return-Path: <linux-fsdevel+bounces-7784-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2270282AB8A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Jan 2024 11:05:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C55D0283B66
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Jan 2024 10:05:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28B4312E59;
	Thu, 11 Jan 2024 10:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RnWgZyZa"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92EAE12E4D
	for <linux-fsdevel@vger.kernel.org>; Thu, 11 Jan 2024 10:05:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6D83C433C7;
	Thu, 11 Jan 2024 10:05:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704967544;
	bh=jeq4pnRoUKuyVDH/O+gt4tU8/bO+/yCbRtJFGBZTaLI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RnWgZyZaGWG0nkVJ/aGOZQFuRyL7vMPo9sMB3n4LELbL2p8nbSJFfZEuR1vTfATg9
	 YXV5fezUEbuQZZNLtDC9QGOADtE+3+qTD/nux6GyNV6vsZFIcTFUJqiP2WIkF6tnIH
	 eI7Pj28MVz3PFpXRmWDCNNCKWnymAqrNamj8TE7cpefAI9e5eMiswv+cjp4APIbN6c
	 xnQOVEWzSHbWl1pVWSiZdWJlK8S/RLGVDXleS6igDM5hM2X1BkBOzl2kHC4rolDc8b
	 2oYWOW+N2C5VeFB6ZKYHuM4T+s6DRj5uhpDH6un4KmRcC/ACkledmY2+OvcJc8Pp0V
	 cYrBLDIYczmRQ==
Date: Thu, 11 Jan 2024 11:05:40 +0100
From: Christian Brauner <brauner@kernel.org>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Jens Axboe <axboe@kernel.dk>, Jan Kara <jack@suse.cz>, 
	linux-fsdevel@vger.kernel.org
Subject: Re: [RFC][PATCH] fsnotify: optimize the case of no access event
 watchers
Message-ID: <20240111-gesponnen-runter-f97e0526abb8@brauner>
References: <20240109194818.91465-1-amir73il@gmail.com>
 <91797c50-d7fc-4f58-b52a-e95823b3df52@kernel.dk>
 <2cf86f5f-58a1-4f5c-8016-b92cb24d88f1@kernel.dk>
 <CAOQ4uxjtKJ_uiP3hEdTbCh5NNExD5S3+m0oEgB2VjhnD2BrvPw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOQ4uxjtKJ_uiP3hEdTbCh5NNExD5S3+m0oEgB2VjhnD2BrvPw@mail.gmail.com>

On Wed, Jan 10, 2024 at 11:08:17AM +0200, Amir Goldstein wrote:
> On Tue, Jan 9, 2024 at 10:24 PM Jens Axboe <axboe@kernel.dk> wrote:
> >
> > On 1/9/24 1:12 PM, Jens Axboe wrote:
> > > On 1/9/24 12:48 PM, Amir Goldstein wrote:
> > >> Commit e43de7f0862b ("fsnotify: optimize the case of no marks of any type")
> > >> optimized the case where there are no fsnotify watchers on any of the
> > >> filesystem's objects.
> > >>
> > >> It is quite common for a system to have a single local filesystem and
> > >> it is quite common for the system to have some inotify watches on some
> > >> config files or directories, so the optimization of no marks at all is
> > >> often not in effect.
> > >>
> > >> Access event watchers are far less common, so optimizing the case of
> > >> no marks with access events could improve performance for more systems,
> > >> especially for the performance sensitive hot io path.
> > >>
> > >> Maintain a per-sb counter of objects that have marks with access
> > >> events in their mask and use that counter to optimize out the call to
> > >> fsnotify() in fsnotify access hooks.
> > >>
> > >> Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> > >> ---
> > >>
> > >> Jens,
> > >>
> > >> You may want to try if this patch improves performance for your workload
> > >> with SECURITY=Y and FANOTIFY_ACCESS_PERMISSIONS=Y.
> > >
> > > Ran the usual test, and this effectively removes fsnotify from the
> > > profiles, which (as per other email) is between 5-6% of CPU time. So I'd
> > > say it looks mighty appealing!
> >
> > Tried with an IRQ based workload as well, as those are always impacted
> > more by the fsnotify slowness. This patch removes ~8% of useless
> > overhead in that case, so even bigger win there.
> >
> 
> Do the IRQ based workloads always go through io_req_io_end()?
> Meaning that unlike the polled io workloads, they also incur the
> overhead of the fsnotify_{modify,access}() hooks?
> 
> I remember I asked you once (cannot find where) whether
> io_complete_rw_iopoll() needs the fsnotify hooks and you said that
> it is a highly specialized code path for fast io, whose users will not
> want those access/modify hooks.
> 
> Considering the fact that fsnotify_{modify,access}() could just as well
> be bypassed by mmap() read/write, I fully support this reasoning.
> 
> Anyway, that explains (to me) why compiling-out the fsnotify_perm()
> hooks took away all the regression that you observed in upstream,
> because I was wondering where the overhead of fsnotify_access() was.
> 
> Jan,
> 
> What are your thoughts about this optimization patch?
> 
> My thoughts are that the optimization is clearly a win, but do we
> really want to waste a full long in super_block for counting access
> event watchers that may never exist?

Meh, not too excited about it. Couldn't you use a flag in s_fsnotify_mask?
Maybe that's what you mean below.

> 
> Should we perhaps instead use a flag to say that "access watchers
> existed"?
> 
> We could put s_fsnotify_access_watchers inside a struct
> fsnotify_sb_mark_connector and special case alloc/free of
> FSNOTIFY_OBJ_TYPE_SB connector.

Would it make sense without incurring performance impact to move
atomic_long_t s_fsnotify_connectors and your new atomic_long_t into a
struct fsnotify_data that gets allocated when an sb is created? Then we
don't waste space in struct super_block. This is basically a copy-pasta
of the LSM sb->s_security approach.


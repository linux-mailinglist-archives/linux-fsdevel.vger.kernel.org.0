Return-Path: <linux-fsdevel+bounces-2406-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 92F617E5BD1
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Nov 2023 17:58:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D3F2281606
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Nov 2023 16:58:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E908E199A5;
	Wed,  8 Nov 2023 16:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="G3gO+HkE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0C5130FAE;
	Wed,  8 Nov 2023 16:57:54 +0000 (UTC)
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 254E41FF5;
	Wed,  8 Nov 2023 08:57:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=3XaTS4l1jOlE5Hfu1CA/WGPIdOF+9JexWwbCk7Slwbc=; b=G3gO+HkEZkgK1i5XsUMRPc9HMW
	TRrdOuilZugvNOCn5bjpjqeDBUWqcAx95RiGs3QByqff+x+IByCOwwxpp1cLKrK0R310/huIICnK8
	mKNNBiv1IZyArrZxo/r4KywNlScnrgWNZjLtmp+OlEW53U+90ei0CVMunHxMVfvC3x+8Z4AkMinEU
	LEbe2fQu4FpUmSL6NNCuCR1P3QdA5QVTuwaPrfgjxFGx2eGiih8z7ynw2+bSSS24CY2tz/mlzsXhw
	mowi6vgI7wE9LQPETfWuEdmyX14udJneWhiWFzKW5AZ069zC99+tz9LGFVcxkKHn5E2/zvbtg74ut
	aRBYsY6w==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1r0lsD-00D7Mu-0D;
	Wed, 08 Nov 2023 16:57:49 +0000
Date: Wed, 8 Nov 2023 16:57:49 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Tycho Andersen <tycho@tycho.pizza>
Cc: cgroups@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	Christian Brauner <brauner@kernel.org>, Tejun Heo <tj@kernel.org>,
	Zefan Li <lizefan.x@bytedance.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Haitao Huang <haitao.huang@linux.intel.com>,
	Kamalesh Babulal <kamalesh.babulal@oracle.com>,
	Tycho Andersen <tandersen@netflix.com>
Subject: Re: [RFC 4/6] misc cgroup: introduce an fd counter
Message-ID: <20231108165749.GY1957730@ZenIV>
References: <20231108002647.73784-1-tycho@tycho.pizza>
 <20231108002647.73784-5-tycho@tycho.pizza>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231108002647.73784-5-tycho@tycho.pizza>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Tue, Nov 07, 2023 at 05:26:45PM -0700, Tycho Andersen wrote:

> +	if (!charge_current_fds(newf, count_open_files(new_fdt)))
> +		return newf;

Are you sure that on configs that are not cgroup-infested compiler
will figure out that count_open_files() would have no side effects
and doesn't need to be evaluated?

Incidentally, since you are adding your charge/uncharge stuff on each
allocation/freeing, why not simply maintain an accurate counter, cgroup or
no cgroup?  IDGI...  Make it an inlined helper right there in fs/file.c,
doing increment/decrement and, conditional upon config, calling
the cgroup side of things.  No need to look at fdt, etc. outside
of fs/file.c either - the counter can be picked right from the
files_struct...

>  static void __put_unused_fd(struct files_struct *files, unsigned int fd)
>  {
>  	struct fdtable *fdt = files_fdtable(files);
> +	if (test_bit(fd, fdt->open_fds))
> +		uncharge_current_fds(files, 1);

Umm...  Just where do we call it without the bit in ->open_fds set?
Any such caller would be a serious bug; suppose you are trying to
call __put_unused_fd(files, N) while N is not in open_fds.  Just before
your call another thread grabs a descriptor and picks N.  Resulting
state won't be pretty, especially if right *after* your call the
third thread also asks for a descriptor - and also gets N.

Sure, you have an exclusion on ->file_lock, but AFAICS all callers
are under it and in all callers except for put_unused_fd() we
have just observed a non-NULL file reference in ->fd[N]; that
would *definitely* be a hard constraint violation if it ever
happened with N not in ->open_fds at that moment.

So the only possibility would be a broken caller of put_unused_fd(),
and any such would be a serious bug.

Details, please - have you ever observed that?

BTW, what about the locking hierarchy?  In the current tree ->files_lock
nests inside of everything; what happens with your patches in place?


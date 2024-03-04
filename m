Return-Path: <linux-fsdevel+bounces-13505-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 14F5B8708F4
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Mar 2024 19:02:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE87528250F
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Mar 2024 18:02:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2BD161686;
	Mon,  4 Mar 2024 18:02:22 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from kanga.kvack.org (kanga.kvack.org [205.233.56.17])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A5701756D;
	Mon,  4 Mar 2024 18:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.233.56.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709575342; cv=none; b=gJImwkNCxi/2iMcvsQX5YXODzThBMYS0USZ/QFkYL1Nir0zglCp/k07T7LMShSpC4Y1r9YFApGStHVeOzshgsizQw+J44bsgWaaC6HlsJsSQoAPAK2af+h3nclW2NsFjQ9oLFwbu+12kB6oOQ22i9Pmkkxep/Wt7GLxqAhqg5kk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709575342; c=relaxed/simple;
	bh=o2Uqzli5Q7BAm+6NVdRphFaatmxkjhCCRQN6B1rsgic=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Mime-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fr/QlDLQXwZnV+Z/BegyRdxf4jfvX+FaxiIhxtc4u8SGeqJYnVsUt+Ji7gCFs0/3+1FKWWmowkMzNP51Mc3OEP+X0P8/ht3a21pHRIC12FSAntj1Hl2CV9ClrpamX50v44np2IrRMhaAoeRaAULCcuuWn9K93M8GCN6ymj6U77Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=communityfibre.ca; spf=pass smtp.mailfrom=communityfibre.ca; arc=none smtp.client-ip=205.233.56.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=communityfibre.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=communityfibre.ca
Received: by kanga.kvack.org (Postfix, from userid 63042)
	id 0FA496B0088; Mon,  4 Mar 2024 13:02:20 -0500 (EST)
Date: Mon, 4 Mar 2024 13:02:20 -0500
From: Benjamin LaHaise <ben@communityfibre.ca>
To: Bart Van Assche <bvanassche@acm.org>
Cc: Edward Adam Davis <eadavis@qq.com>,
	syzbot+b91eb2ed18f599dd3c31@syzkaller.appspotmail.com,
	brauner@kernel.org, jack@suse.cz, linux-aio@kvack.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Subject: Re: [PATCH] fs/aio: fix uaf in sys_io_cancel
Message-ID: <20240304180220.GR20455@kvack.org>
References: <0000000000006945730612bc9173@google.com> <tencent_DC4C9767C786D2D2FDC64F099FAEFDEEC106@qq.com> <14f85d0c-8303-4710-b8b1-248ce27a6e1f@acm.org> <20240304170343.GO20455@kvack.org> <73949a4d-6087-4d8c-bae0-cda60e733442@acm.org> <20240304173120.GP20455@kvack.org> <5ee4df86-458f-4544-85db-81dc82c2df4c@acm.org> <20240304174721.GQ20455@kvack.org> <2587412f-454d-472c-84b3-d7b9776a105a@acm.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2587412f-454d-472c-84b3-d7b9776a105a@acm.org>
User-Agent: Mutt/1.4.2.2i

On Mon, Mar 04, 2024 at 09:58:37AM -0800, Bart Van Assche wrote:
> On 3/4/24 09:47, Benjamin LaHaise wrote:
> >On Mon, Mar 04, 2024 at 09:40:35AM -0800, Bart Van Assche wrote:
> >>On 3/4/24 09:31, Benjamin LaHaise wrote:
> >>>A revert is justified when a series of patches is buggy and had
> >>>insufficient review prior to merging.
> >>
> >>That's not how Linux kernel development works. If a bug can get fixed
> >>easily, a fix is preferred instead of reverting + reapplying a patch.
> >
> >Your original "fix" is not right, and it wasn't properly tested.  Commit
> >54cbc058d86beca3515c994039b5c0f0a34f53dd needs to be reverted.
> 
> As I explained before, the above reply is not sufficiently detailed to
> motivate a revert.

You have introduced a use-after-free.  You have not corrected the
underlying cause of that use-after-free.

Once you call ->ki_cancel(), you can't touch the kiocb.  The call into 
->ki_cancel() can result in a subsequent aio_complete() happening on that
kiocb.  Your change is wrong, your "fix" is wrong, and you are refusing to
understand *why* your change was wrong in the first place.

You haven't even given me a test case justifying your change.  You need to
justify your change to the maintainer, not the other way around.

Revert 54cbc058d86beca3515c994039b5c0f0a34f53dd and the problem goes away.

		-ben

> Bart.
> 

-- 
"Thought is the essence of where you are now."


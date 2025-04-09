Return-Path: <linux-fsdevel+bounces-46112-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DC997A82AC9
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Apr 2025 17:42:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F96D17A668
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Apr 2025 15:38:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99ACD267B7C;
	Wed,  9 Apr 2025 15:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VzPDUykg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 011E026770E;
	Wed,  9 Apr 2025 15:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744213092; cv=none; b=W4wWBr2BU2lerwCR/DiW3GCpD2d8wi+KygnT2HcKUC/qCHWPTIb9m6QV34FwOSsryAFJbiPzWhj9sxZAWt1P90IGdTL4gpLga6AVM4BJjEbseIxZ8YVxApayOgPad5UDtJ0h/ORuImPkQOGwDz0UIHvgccuQTkOUakCsKOB/LVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744213092; c=relaxed/simple;
	bh=fqfH1kvrY0NprE4Wf6dbWb0UT2mQUYVQx6Gs7AkqODg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rV0NzyfqbzcIv3jnaJ43/lcvr28/YHJl8W8x7pxAtoFEwsH6CBvkzS9sHuuGzuviCYvcQ0+bRLqRjKPosyHtOutotyV4pQgjyh50x2LYAwI+gZj07AM5wbM/ddQEduEZ+Q7P2Rc8egX3qrruEk5IbFJqrZhxdGriDw4U+XNIMXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VzPDUykg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79A34C4CEE2;
	Wed,  9 Apr 2025 15:38:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744213091;
	bh=fqfH1kvrY0NprE4Wf6dbWb0UT2mQUYVQx6Gs7AkqODg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VzPDUykgYlNJ9VEOYJEoxdfu6RVmeanMWYFbIEtNmKYLRtebJrUstrCN/ItySJLx1
	 iTrG/qxrLQy33IHXySaYWxl4X4XIxz9btWkwjrTe+mE3bOEhCcEXI/kgCn7091qSZp
	 uz8paIAFq1AqvpooGWnCMRDPXdMPSCCI2V1uvCGVxdxYFasuG0HkDscVOl8VuWLXJJ
	 ACGXaSTxVURARgJYwG1G6ZKrSiZCLdkGXjZf9TgFWU2TbqtOKjHnkMJ6uz3SGHaldl
	 cWclysuAKuxG7b9j3NG1/GenKh0zPVx5EhCPcm3HUgWzx0iAT/rVGVpsdEqg5ApYbm
	 ulAHyhy1crTmA==
Date: Wed, 9 Apr 2025 17:38:06 +0200
From: Christian Brauner <brauner@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>, 
	Lennart Poettering <lennart@poettering.net>, Daan De Meyer <daan.j.demeyer@gmail.com>, 
	Mike Yuan <me@yhndnzj.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC 3/4] pidfd: improve uapi when task isn't found
Message-ID: <20250409-sesshaft-absurd-35d97607142c@brauner>
References: <20250403-work-pidfd-fixes-v1-0-a123b6ed6716@kernel.org>
 <20250403-work-pidfd-fixes-v1-3-a123b6ed6716@kernel.org>
 <20250404123737.GC3720@redhat.com>
 <20250404-roben-zoodirektor-13cb8d1acefe@brauner>
 <20250404145323.GE3720@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250404145323.GE3720@redhat.com>

On Fri, Apr 04, 2025 at 04:53:24PM +0200, Oleg Nesterov wrote:
> On 04/04, Christian Brauner wrote:
> >
> > On Fri, Apr 04, 2025 at 02:37:38PM +0200, Oleg Nesterov wrote:
> > > And... the code looks a bit overcomplicated to me, why not simply
> > >
> > > 	int pidfd_prepare(struct pid *pid, unsigned int flags, struct file **ret)
> > > 	{
> > > 		if (!pid_has_task(pid, PIDTYPE_PID))
> > > 			return -ESRCH;
> > >
> > > 		if (!(flags & PIDFD_THREAD) && !pid_has_task(pid, PIDTYPE_TGID))
> > > 			return -ENOENT;
> >
> > I thought that checking PIDTYPE_PID first could cause misleading results
> > where we report ENOENT where we should report ESRCH: If the task was
> > released after the successful PIDTYPE_PID check for a pid that was never
> > a thread-group leader we report ENOENT.
> 
> Hmm... but the code above can only return ENOENT if !(flags & PIDFD_THREAD),
> so in this case -ENOENT is correct?
> 
> I guess -ENOENT would be wrong if this pid _was_ a leader pid and we
> race with __unhash_process() which does
> 
> 	detach_pid(post->pids, p, PIDTYPE_PID);
> 	if (group_dead)
> 		detach_pid(post->pids, p, PIDTYPE_TGID);

Yes, exactly.

> 
> but without tasklist_lock (or additional barries in both pidfd_prepare() and
> __unhash_process() pidfd_prepare() can see the result of these 2 detach_pid()'s
> in any order anyway. So I don't think the code above is "more" racy.

Right... Hm, I don't like the inherent raciness of this. I think we
should fix this. I'm playing with something. I'll try to get it out
today.

> 
> Although perhaps we can rely on the fact the the 1st detach_pid(PIDTYPE_PID)
> does wake_up(pid->wait_pidfd) and use pid->wait_pidfd->lock to avoid the
> races, not sure...
> 
> But,
> 
> > But I can adapt that to you scheme.
> 
> Again, up to you, whatever you prefer.
> 
> Oleg.
> 


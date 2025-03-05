Return-Path: <linux-fsdevel+bounces-43219-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 286E3A4F93A
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Mar 2025 09:54:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DAB3A188CF23
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Mar 2025 08:54:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC9521F78E6;
	Wed,  5 Mar 2025 08:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BDGiDGmL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36EA21C6FE8
	for <linux-fsdevel@vger.kernel.org>; Wed,  5 Mar 2025 08:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741164875; cv=none; b=SBSt5T2Js55qf3lYDQj7xwG4E9/6GY7aSSSQyNg9TESYH7+yEkh3h/doYmQBywS2DvLHHNHWIJutgCm4Rb9F9gvwq18Lj5VwXSRq2qixtFAG8LjE5w/zhN6TPw2dePtTE3gChBLj2WR/HWzhigPYcxYiIYR//GprMjIdwKSyFw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741164875; c=relaxed/simple;
	bh=0fykOOD2jPhC9mJuGuYorNs1bjRgZy+x8ZobFGMmvCU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bzWO7VL6wJ0M59u+H/Oo3R8OXbd8Xnf3bAnw9CGfHb83v2yfD5vnEkFsHQ0Pilw/46Apv553QF45PhXDcWt+zFnM+dg/RYRRss0GkJebFYgRFvZ6oUTNMxtHHSs6Q+1FmYl7PntsRhxyC7CCmEogSsDKRiJBcQQqYt6FoIAQyE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BDGiDGmL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 026A5C4CEE2;
	Wed,  5 Mar 2025 08:54:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741164874;
	bh=0fykOOD2jPhC9mJuGuYorNs1bjRgZy+x8ZobFGMmvCU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BDGiDGmLH1SK2HyoDBB44shtTXeMHb61YGAt1/46fAW+Rv6VqdEpHNC17yRBfY0b+
	 ZpSr3fIgPOkKgdsf9clzdvGKC88OMzxVPC3roG6IIewdXaf/Y/eGe3V5y9cVTV1I43
	 fmPb5a7gBVPDoyJJvm8JzFir9cd9UcyfUAR/qpmT9NUPHLgZll3zVFlCilZgnRSSmO
	 sr8iq/ztnf6boU/4k0UvWCWIrvpTOE/q3HkdDMSHWtv9xABXrub0KvdFkhRq2FnF9L
	 H0uDYrlP95e3k7erve1UAre6X0GStFXp2a54M68AWkNe0XJ8Pg+hp2wbc/aT59S+jl
	 /aFoX9Tf/PMBQ==
Date: Wed, 5 Mar 2025 09:54:30 +0100
From: Christian Brauner <brauner@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>, 
	Lennart Poettering <lennart@poettering.net>, Daan De Meyer <daan.j.demeyer@gmail.com>, 
	Mike Yuan <me@yhndnzj.com>
Subject: Re: [PATCH v2 06/15] pidfs: allow to retrieve exit information
Message-ID: <20250305-nagel-mitinhaber-4e3ead674289@brauner>
References: <20250304-work-pidfs-kill_on_last_close-v2-0-44fdacfaa7b7@kernel.org>
 <20250304-work-pidfs-kill_on_last_close-v2-6-44fdacfaa7b7@kernel.org>
 <20250304173456.GD5756@redhat.com>
 <20250304-wochen-gutgesinnt-53c0765c5e81@brauner>
 <20250304214710.GF5756@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250304214710.GF5756@redhat.com>

On Tue, Mar 04, 2025 at 10:47:11PM +0100, Oleg Nesterov wrote:
> On 03/04, Christian Brauner wrote:
> >
> > On Tue, Mar 04, 2025 at 06:34:56PM +0100, Oleg Nesterov wrote:
> > > On 03/04, Christian Brauner wrote:
> > > >
> > > > +	task = get_pid_task(pid, PIDTYPE_PID);
> > > > +	if (!task) {
> > > > +		if (!(mask & PIDFD_INFO_EXIT))
> > > > +			return -ESRCH;
> > > > +
> > > > +		if (!current_in_pidns(pid))
> > > > +			return -ESRCH;
> > >
> > > Damn ;) could you explain the current_in_pidns() check to me ?
> > > I am puzzled...
> >
> > So we currently restrict interactions with pidfd by pid namespace
> > hierarchy. Meaning that we ensure that the pidfd is part of the caller's
> > pid namespace hierarchy.
> 
> Well this is clear... but sorry I still can't understand.

Ok, it sounded like you wanted me to explain what current_in_pidns()
does not why it's placed where it is placed. :)

> 
> Why do we check current_in_pidns() only if get_pid_task(PIDTYPE_PID)
> returns NULL?

Because if task != NULL we already catch it kinfo.pid and since we can't
skip the call to task_pid_vnr() it seemed redundant to do that check
twice. But if we do it before get_task_pid() it makes more sense ofc.

> 
> And, unless (quite possibly) I am totally confused, if task != NULL
> but current_in_pidns() would return false, then
> 
> 	kinfo.pid = task_pid_vnr(task);
> 
> below will set kinfo.pid = 0, and pidfd_info() will return -ESRCH anyway?

Yes.

> 
> > So this check is similar to:
> >
> > pid_t pid_nr_ns(struct pid *pid, struct pid_namespace *ns)
> > {
> >         struct upid *upid;
> >         pid_t nr = 0;
> >
> >         if (pid && ns->level <= pid->level) {
> >                 upid = &pid->numbers[ns->level];
> >                 if (upid->ns == ns)
> >                         nr = upid->nr;
> >         }
> >         return nr;
> > }
> >
> > Only that by the time we perform this check the pid numbers have already
> > been freed so we can't use that function directly.
> 
> Confused again... Yes, the [u]pid numbers can be already "freed" in that
> upid->nr can be already idr_remove()'ed, but
> 
> > But the pid namespace
> > hierarchy is still alive as that won't be released until the pidfd has
> > put the reference on struct @pid.
> 
> Yes, so I still don't undestand, sorry :/
> 
> IOW. Why not check current_in_pidns() at the start? and do
> task = get_pid_task() later, right before

Sure, that's a good suggestion.

> 
> 	if (!task)
> 		goto copy_out;
> 
> ?
> 
> Oleg.
> 


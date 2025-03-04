Return-Path: <linux-fsdevel+bounces-43162-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D6C50A4ECDC
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Mar 2025 20:11:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9BFA57A57F8
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Mar 2025 19:10:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C9C4254844;
	Tue,  4 Mar 2025 19:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GLfKkKFh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF8111E505
	for <linux-fsdevel@vger.kernel.org>; Tue,  4 Mar 2025 19:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741115459; cv=none; b=CKiWCfpKwpGNJf/Vbp+UWiRsn4mD0i5hdG7B28l0sZYqaE51v80IpIBVwWeBX9gIuKlHOT/1oz/lRNLNtkj11pk0XVnRb7AunPxBolZlsNYFa0Nf5/zsGc6Sck+oQcnM2rUGSFXhtIoFKUvfLIbFDBt3QAdQXqFU3JBQGi4medY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741115459; c=relaxed/simple;
	bh=ECLz5lZeV4Nx+5HaPm7JjXyPpqEWXDf9OVBphY4cL30=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aSeZmvhqy/CISUHgEI2ZQBgG6PqB8ibCi7LCV9NTrBmNVqY5dtVSLyrkv/l00KkGkrAcFBx+jjDkuPR0UcrLChMrB5wFoQoG6gvdgP9zhU3WggtEq7ezYH9seZrDP6BP61Cdg33z91oly/kCLI4FeKmsLawGMhB2xvazOyrx+0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GLfKkKFh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA182C4CEE5;
	Tue,  4 Mar 2025 19:10:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741115459;
	bh=ECLz5lZeV4Nx+5HaPm7JjXyPpqEWXDf9OVBphY4cL30=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GLfKkKFhC1VKaFZV4RSNTMJRJnOBM2igmMBXO1HxYflHzLNk98z9CVDW2cJCw4pLH
	 h7aaaQBFko8QCzCgjoWTxhOTbAayxqRzfvQiBuIHSdOuyUseI8WJ0+uO1ksu6zaAJa
	 leh5vRKUx0luhs2jz4tSYBlUF33nuXoprFO6WSOT11RG53bVqeNWdgFjPwYPjL8aZG
	 lxUEVo+iYvCi/xGWzrbP4CgzmOrdCYKLFdn90UXOgdeeNsax695Gn4v7hkpooTEtEo
	 SrxVWgStvF80tkq/aWGEDcfTSb9e1F/In4/DkB1Alg9TNp55H1ns6Tig4Kf0PMHpg6
	 8OzVBUopa8W2w==
Date: Tue, 4 Mar 2025 20:10:55 +0100
From: Christian Brauner <brauner@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>, 
	Lennart Poettering <lennart@poettering.net>, Daan De Meyer <daan.j.demeyer@gmail.com>, 
	Mike Yuan <me@yhndnzj.com>
Subject: Re: [PATCH v2 05/15] pidfs: record exit code and cgroupid at exit
Message-ID: <20250304-rentner-luftkammer-be6e9472281e@brauner>
References: <20250304-work-pidfs-kill_on_last_close-v2-0-44fdacfaa7b7@kernel.org>
 <20250304-work-pidfs-kill_on_last_close-v2-5-44fdacfaa7b7@kernel.org>
 <20250304131017.GB26141@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250304131017.GB26141@redhat.com>

On Tue, Mar 04, 2025 at 02:10:18PM +0100, Oleg Nesterov wrote:
> I will read this series later, but I see nothing wrong after a quick glance.
> 
> Minor nit below...
> 
> On 03/04, Christian Brauner wrote:
> >
> > Record the exit code and cgroupid in do_exit()
>                                     ^^^^^^^^^^^^
> this is no longer true. In release_task().

Yes, thanks for catching this!

> 
> > @@ -254,6 +255,7 @@ void release_task(struct task_struct *p)
> >  	write_lock_irq(&tasklist_lock);
> >  	ptrace_release_task(p);
> >  	thread_pid = get_pid(p->thread_pid);
> > +	pidfs_exit(p);
> >  	__exit_signal(p);
> 
> And the next patch rightly moves pidfs_exit() up outside of tasklist.
> 
> Why not call it before write_lock_irq(&tasklist_lock) from the very
> beginning?

Yes, sorry that was my intention. pidfs_exit() can sleep due to dput().
Thanks!


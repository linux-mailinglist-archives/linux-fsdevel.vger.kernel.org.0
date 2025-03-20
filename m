Return-Path: <linux-fsdevel+bounces-44605-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D61DA6A9EA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Mar 2025 16:30:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 10F418A794A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Mar 2025 15:27:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F1D41F8BB0;
	Thu, 20 Mar 2025 15:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ocddy8IO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCA661E8323
	for <linux-fsdevel@vger.kernel.org>; Thu, 20 Mar 2025 15:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742484385; cv=none; b=Lf2J3oOQjMgCaniQv+6RS34/8inKWMdvD9a5jMl2jiktQDAKaEGaEtYfnSddo/8UAxtWZb/c6dQl+keoRo0yhd0vHhIDd0vKWYlTjvHbwJGzMM6CHmiKz8Nzy0DEwY5eaxtjvIkygg/i7R0JIkbDDes3+rGKmkrxkoeMohevwbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742484385; c=relaxed/simple;
	bh=fUMa683179BBQk1u8kIk4ZbSWZGF1/vvHTcjJN2/I/o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AM+iTRs7L96ard08R1glaSFozMJ/eAkqzI2MhPlB8oGGfloJObdMweZ6F3qSQAr8hKcicE0bRDCjz5Z0TTIf0k95s4/J0m9YmoNUu0ZWwQO60YePz8I53qhVlf1EwYKo7FEQVtEL9Mg+IxI9qSbPxaAnSNL/xuIAk9dFHVs7qM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ocddy8IO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B1CDC4CEED;
	Thu, 20 Mar 2025 15:26:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742484385;
	bh=fUMa683179BBQk1u8kIk4ZbSWZGF1/vvHTcjJN2/I/o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ocddy8IOVvRg24di1YjWjC4g1uRbn2Y39ezfxZmhsRXC9ZM4cY/pS+aoTTB8aIvom
	 ni1kOBD+ZnJEYOgUdwkd3hwaqcsaE7bO/o/4LBomvsp8wZfm7TEcjHaBAzBz0djs7n
	 coWkTKf9Sjtz4Zho7rl0kaTsZpyqFoN0QqFBdx1eBluY0yZExWUDK0NqE+dTzgjiJr
	 V0zbk8/pM/V3ICFt7PF7cZeTrXmE8pbAzgXaJKyDFjiECgaEWlSbjWAcCUUR4GeF5Q
	 T5tl7UCBJqHrNVdvFwh7mqudgokqH4GMnsF1qEoreALJNxrQZQ+g9GyoYVFJFX+AEF
	 a0dzbD4+qydiA==
Date: Thu, 20 Mar 2025 16:26:20 +0100
From: Christian Brauner <brauner@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>, 
	Lennart Poettering <lennart@poettering.net>, Daan De Meyer <daan.j.demeyer@gmail.com>, 
	Mike Yuan <me@yhndnzj.com>
Subject: Re: [PATCH v4 1/4] pidfs: improve multi-threaded exec and premature
 thread-group leader exit polling
Message-ID: <20250320-teleobjektiv-leitbild-684b7a979f9d@brauner>
References: <20250320-work-pidfs-thread_group-v4-0-da678ce805bf@kernel.org>
 <20250320-work-pidfs-thread_group-v4-1-da678ce805bf@kernel.org>
 <20250320142817.GE11256@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250320142817.GE11256@redhat.com>

On Thu, Mar 20, 2025 at 03:28:17PM +0100, Oleg Nesterov wrote:
> On 03/20, Christian Brauner wrote:
> >
> > Co-Developed-by: Oleg Nesterov <oleg@redhat.com>
> > Signed-off-by: Oleg Nesterov <oleg@redhat.com>
> > Signed-off-by: Christian Brauner <brauner@kernel.org>
> > ---
> >  fs/pidfs.c      | 9 +++++----
> >  kernel/exit.c   | 6 +++---
> >  kernel/signal.c | 3 +--
> >  3 files changed, 9 insertions(+), 9 deletions(-)
> 
> Thanks, LGTM.
> 
> Todo:
> 
> 	- As we already discussed, do_notify_pidfd() can be called
> 	  twice from exit_notify() paths, we can avoid this.
> 
> 	  But this connects to another minor issue:
> 
> 	- With this change, debuggers can no longer use PIDFD_THREAD.
> 	  I guess we don't really care, I don't think PIDFD_THREAD was
> 	  ever used for this purpose. but perhaps we can change this

If you have ideas how to let them use it I'm all for it!

> 	  or at least document somewhere...
> 
> I'll try to do this but not today and (most probably) not tomorrow.

Cool, sounds great!


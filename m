Return-Path: <linux-fsdevel+bounces-21708-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E0E2908A96
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Jun 2024 12:57:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B583BB22FAB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Jun 2024 10:57:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AA2419599C;
	Fri, 14 Jun 2024 10:57:27 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 994C31922C1;
	Fri, 14 Jun 2024 10:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718362646; cv=none; b=Q5597M3BffuRhdYszhXxzJUa1DEqxku7VkNrtEwCQQZ+Jym2/bIoTqUWTsHp5t1ZgInOSEoeb3pj/qHSbe1TNx6s6K0a9VS+vz6vO9YZWBVc5gk5csKf1afNbFy1zqHIRapV/y0HA36viKKfNcmH1BpE5Hk2FJa6eVUWAmZ9uX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718362646; c=relaxed/simple;
	bh=VpkZMGnsBKmgLtkXIvfdtNY34AGxALRHiAdPhbPfvgk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HDJ+ATA6kfj8g3tdhAApSUbK3HUMZ0E6ZBsje/pgpf1SEDoMGjgpz5NsTXMR0y4+BkLDAO/AMNow+2OxaYGJ4SxGEgahzdiS/FnGOeDskSGfyE6nwkY0O1d+7WoEyBe6CrsGKtcgmG2btZOWdSB/jpgUryGQlahq6J4EJaaUX7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85C86C2BD10;
	Fri, 14 Jun 2024 10:57:23 +0000 (UTC)
Date: Fri, 14 Jun 2024 11:57:21 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Yafang Shao <laoar.shao@gmail.com>
Cc: torvalds@linux-foundation.org, ebiederm@xmission.com,
	alexei.starovoitov@gmail.com, rostedt@goodmis.org,
	linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, audit@vger.kernel.org,
	linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
	bpf@vger.kernel.org, netdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v2 06/10] mm/kmemleak: Replace strncpy() with
 __get_task_comm()
Message-ID: <ZmwiEbCcovJ8fdr5@arm.com>
References: <20240613023044.45873-1-laoar.shao@gmail.com>
 <20240613023044.45873-7-laoar.shao@gmail.com>
 <Zmqvu-1eUpdZ39PD@arm.com>
 <CALOAHbB3Uiwsp2ieiPZ-_CKyZPgW6_gF_y-HEGHN3KWhGh0LDg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALOAHbB3Uiwsp2ieiPZ-_CKyZPgW6_gF_y-HEGHN3KWhGh0LDg@mail.gmail.com>

On Thu, Jun 13, 2024 at 08:10:17PM +0800, Yafang Shao wrote:
> On Thu, Jun 13, 2024 at 4:37 PM Catalin Marinas <catalin.marinas@arm.com> wrote:
> > On Thu, Jun 13, 2024 at 10:30:40AM +0800, Yafang Shao wrote:
> > > Using __get_task_comm() to read the task comm ensures that the name is
> > > always NUL-terminated, regardless of the source string. This approach also
> > > facilitates future extensions to the task comm.
> > >
> > > Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> > > Cc: Catalin Marinas <catalin.marinas@arm.com>
> > > Cc: Andrew Morton <akpm@linux-foundation.org>
> > > ---
> > >  mm/kmemleak.c | 8 +-------
> > >  1 file changed, 1 insertion(+), 7 deletions(-)
> > >
> > > diff --git a/mm/kmemleak.c b/mm/kmemleak.c
> > > index d5b6fba44fc9..ef29aaab88a0 100644
> > > --- a/mm/kmemleak.c
> > > +++ b/mm/kmemleak.c
> > > @@ -663,13 +663,7 @@ static struct kmemleak_object *__alloc_object(gfp_t gfp)
> > >               strncpy(object->comm, "softirq", sizeof(object->comm));
> > >       } else {
> > >               object->pid = current->pid;
> > > -             /*
> > > -              * There is a small chance of a race with set_task_comm(),
> > > -              * however using get_task_comm() here may cause locking
> > > -              * dependency issues with current->alloc_lock. In the worst
> > > -              * case, the command line is not correct.
> > > -              */
> > > -             strncpy(object->comm, current->comm, sizeof(object->comm));
> > > +             __get_task_comm(object->comm, sizeof(object->comm), current);
> > >       }
> >
> > You deleted the comment stating why it does not use get_task_comm()
> > without explaining why it would be safe now. I don't recall the details
> > but most likely lockdep warned of some potential deadlocks with this
> > function being called with the task_lock held.
> >
> > So, you either show why this is safe or just use strscpy() directly here
> > (not sure we'd need strscpy_pad(); I think strscpy() would do, we just
> > need the NUL-termination).
> 
> The task_lock was dropped in patch #1 [0]. My apologies for not
> including you in the CC for that change. After this modification, it
> is now safe to use __get_task_comm().
> 
> [0] https://lore.kernel.org/all/20240613023044.45873-2-laoar.shao@gmail.com/

Ah, great. For this patch:

Acked-by: Catalin Marinas <catalin.marinas@arm.com>

You may want to add a comment in the commit log that since
__get_task_comm() no longer takes a long, it's safe to call it from
kmemleak.

-- 
Catalin


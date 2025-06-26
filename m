Return-Path: <linux-fsdevel+bounces-53120-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03693AEAA19
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Jun 2025 00:52:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 690DF3A9457
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Jun 2025 22:52:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6F18226177;
	Thu, 26 Jun 2025 22:52:18 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from neil.brown.name (neil.brown.name [103.29.64.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1F101FC0F0;
	Thu, 26 Jun 2025 22:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.29.64.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750978338; cv=none; b=ebhwKnTWbzTtwGwKxr6MVWFdivWGKnRsbarclzV2o1sZHtNhumfnFWBxxWNybwagteu1RiWe5KfPZ1kXJcObV0JtFymbXdc0YuArJgxiQPnheW3mQ2+fZYO7DEHy8OdMt2Fmoh7c2t9gjLo65Cz9tBXmDi+YZi23fqs4F0T2jLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750978338; c=relaxed/simple;
	bh=b8e3eSlYm0Iki0C04qxFWFSGgpEYimw2Aeh8yUtp/sc=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=hSeljsAUpwBopLb3uGhjCZ+cUCi+kkFKVP6keWhgZxPFkT7LE02NaBeaUr+KW95EMlBh/QOLuBIR++zouPUT2GqduwngCO5HRYK/pw+g9jb6Ab/JtQiYE7R+mLqRA15DUdLjf8IzztClvZCoRKsik0GVVCrDoDhMluIrbJbVR4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name; spf=pass smtp.mailfrom=neil.brown.name; arc=none smtp.client-ip=103.29.64.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=neil.brown.name
Received: from 196.186.233.220.static.exetel.com.au ([220.233.186.196] helo=home.neil.brown.name)
	by neil.brown.name with esmtp (Exim 4.95)
	(envelope-from <mr@neil.brown.name>)
	id 1uUvRO-006HqN-Es;
	Thu, 26 Jun 2025 22:51:34 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neil@brown.name>
To: "Song Liu" <songliubraving@meta.com>
Cc: "Tingmao Wang" <m@maowtm.org>,
 =?utf-8?q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>,
 "Song Liu" <song@kernel.org>, "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
 "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-security-module@vger.kernel.org"
 <linux-security-module@vger.kernel.org>,
 "brauner@kernel.org" <brauner@kernel.org>,
 "Kernel Team" <kernel-team@meta.com>, "andrii@kernel.org" <andrii@kernel.org>,
 "eddyz87@gmail.com" <eddyz87@gmail.com>, "ast@kernel.org" <ast@kernel.org>,
 "daniel@iogearbox.net" <daniel@iogearbox.net>,
 "martin.lau@linux.dev" <martin.lau@linux.dev>,
 "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
 "jack@suse.cz" <jack@suse.cz>, "kpsingh@kernel.org" <kpsingh@kernel.org>,
 "mattbobrowski@google.com" <mattbobrowski@google.com>,
 =?utf-8?q?G=C3=BCnther?= Noack <gnoack@google.com>
Subject: Re: [PATCH v5 bpf-next 0/5] bpf path iterator
In-reply-to: <127D7BC6-1643-403B-B019-D442A89BADAB@meta.com>
References: <>, <127D7BC6-1643-403B-B019-D442A89BADAB@meta.com>
Date: Fri, 27 Jun 2025 08:51:21 +1000
Message-id: <175097828167.2280845.5635569182786599451@noble.neil.brown.name>

On Fri, 27 Jun 2025, Song Liu wrote:
> 
> 
> > On Jun 26, 2025, at 3:22 AM, NeilBrown <neil@brown.name> wrote:
> 
> [...]
> 
> >> I guess I misunderstood the proposal of vfs_walk_ancestors() 
> >> initially, so some clarification:
> >> 
> >> I think vfs_walk_ancestors() is good for the rcu-walk, and some 
> >> rcu-then-ref-walk. However, I don’t think it fits all use cases. 
> >> A reliable step-by-step ref-walk, like this set, works well with 
> >> BPF, and we want to keep it.
> > 
> > The distinction between rcu-walk and ref-walk is an internal
> > implementation detail.  You as a caller shouldn't need to think about
> > the difference.  You just want to walk.  Note that LOOKUP_RCU is
> > documented in namei.h as "semi-internal".  The only uses outside of
> > core-VFS code is in individual filesystem's d_revalidate handler - they
> > are checking if they are allowed to sleep or not.  You should never
> > expect to pass LOOKUP_RCU to an VFS API - no other code does.
> > 
> > It might be reasonable for you as a caller to have some control over
> > whether the call can sleep or not.  LOOKUP_CACHED is a bit like that.
> > But for dotdot lookup the code will never sleep - so that is not
> > relevant.
> 
> Unfortunately, the BPF use case is more complicated. In some cases, 
> the callback function cannot be call in rcu critical sections. For 
> example, the callback may need to read xatter. For these cases, we
> we cannot use RCU walk at all. 

I really think you should stop using the terms RCU walk and ref-walk.  I
think they might be focusing your thinking in an unhelpful direction.

The key issue about reading xattrs is that it might need to sleep.
Focusing on what might need to sleep and what will never need to sleep
is a useful approach - the distinction is wide spread in the kernel and
several function take a flag indicating if they are permitted to sleep,
or if failure when sleeping would be required.

So your above observation is better described as 

   The vfs_walk_ancestors() API has an (implicit) requirement that the
   callback mustn't sleep.  This is a problem for some use-cases
   where the call back might need to sleep - e.g. for accessing xattrs.

That is a good and useful observation.  I can see three possibly
responses:

1/ Add a vfs_walk_ancestors_maysleep() API for which the callback is
   always allowed to sleep.  I don't particularly like this approach.

2/ Use repeated calls to vfs_walk_parent() when the handling of each
   ancestor might need to sleep.  I see no problem with supporting both
   vfs_walk_ancestors() and vfs_walk_parent().  There is plenty of
   precedent for having different  interfaces for different use cases.

3/ Extend vfs_walk_ancestors() to pass a "may sleep" flag to the callback.
   If the callback finds that it needs to sleep but that "may sleep"
   isn't set, it returns some well known status, like -EWOULDBLOCK (or
   -ECHILD).  It can expect to be called again but with "may sleep" set.
   This is my preferred approach. There is precedent with the
   d_revalidate callbacks which works like this.
   I suspect that accessing xattrs might often be possible without
   sleeping.  It is conceivable that we could add a "may sleep" argument
   to vfs_getxattr() so that it could still often be used without
   requiring vfs_walk_ancestors() to permit sleeping.
   This would almost certainly require a clear demonstration that 
   there was a performance cost in not having the option of non-sleeping
   vfs_getxattr().

> 
> > I strongly suggest you stop thinking about rcu-walk vs ref-walk.  Think
> > about the needs of your code.  If you need a high-performance API, then
> > ask for a high-performance API, don't assume what form it will take or
> > what the internal implementation details will be.
> 
> At the moment, we need a ref-walk API on the BPF side. The RCU walk
> is a totally separate topic. 

Do you mean "we need step-by-step walking" or do you mean "we need to
potentially sleep for each ancestor"?  These are conceptually different
requirements, but I cannot tell which you mean when you talk about "RCU
walk".

Thanks,
NeilBrown

> 
> > I think you already have a clear answer that a step-by-step API will not
> > be read-only on the dcache (i.e.  it will adjust refcounts) and so will
> > not be high performance.  If you want high performance, you need to
> > accept a different style of API.
> 
> Agreed. 
> 
> Thanks,
> Song
> 
> 



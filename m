Return-Path: <linux-fsdevel+bounces-45772-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3934A7BFF6
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Apr 2025 16:54:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D230F17217F
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Apr 2025 14:54:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80BB31F4633;
	Fri,  4 Apr 2025 14:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z/phb073"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 390531F2C5F
	for <linux-fsdevel@vger.kernel.org>; Fri,  4 Apr 2025 14:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743778450; cv=none; b=WflTR5hrE/cZHWomC9+T7agzBANDpQYkVCy7P66ELltEjMdCO092yIcmBoxmv89VshuRMKHJCa8FfjCVdYWMDJsOM6RxTH4qqurJ6PKA8wJmzLrSQ+pYprg11QLE9P/PP8Yugc/uLdb/mOwYdg6PYbvnmJRKki5UdW1Ig589rYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743778450; c=relaxed/simple;
	bh=4y/WLjYzno5OSrYrFZnK4znkMLyrK4Wy6THRGwyci/c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AWjM5XkB+5KYQTZMaY1UtAswGlS7NjSSife0zSJbJPkIVj+bvDts3GcrEPBIE9NB6U6vymtcgTx0dMZIOmX0AZ5pk5fFv8t6cXp+xACzAmByxZcO+3fmmbs2FGpr8YVpxbUu5EXFHspuqzNYqfWp4rQ2NuqJ5lrBLCHHYn5aptA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Z/phb073; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743778448;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=liDuTx+aE7B4E2TtN2o/Ng6PEZ0l8a0w7p9UK65lptE=;
	b=Z/phb073DBSzw1AkwUufGZrZaaGTBz5KX+/fTIiNc5ks+l2SOdMFRXjfLh+jHwRrrGsvPR
	TIvZmPX39IMkt0YuyuF8kHYCBW7bh9PTllz61nVbzwAmzMhV9gLFbnbHN9GBWJSUmvkYzx
	UsRnJDa6MmCmS2/JQAbMjIx9U2eDuIo=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-511-c9KhibYWMtOsmJuHC9xnDQ-1; Fri,
 04 Apr 2025 10:54:05 -0400
X-MC-Unique: c9KhibYWMtOsmJuHC9xnDQ-1
X-Mimecast-MFC-AGG-ID: c9KhibYWMtOsmJuHC9xnDQ_1743778443
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6EA5B19560B6;
	Fri,  4 Apr 2025 14:54:03 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.144])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 70310180B488;
	Fri,  4 Apr 2025 14:54:00 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Fri,  4 Apr 2025 16:53:28 +0200 (CEST)
Date: Fri, 4 Apr 2025 16:53:24 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>,
	Lennart Poettering <lennart@poettering.net>,
	Daan De Meyer <daan.j.demeyer@gmail.com>,
	Mike Yuan <me@yhndnzj.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC 3/4] pidfd: improve uapi when task isn't found
Message-ID: <20250404145323.GE3720@redhat.com>
References: <20250403-work-pidfd-fixes-v1-0-a123b6ed6716@kernel.org>
 <20250403-work-pidfd-fixes-v1-3-a123b6ed6716@kernel.org>
 <20250404123737.GC3720@redhat.com>
 <20250404-roben-zoodirektor-13cb8d1acefe@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250404-roben-zoodirektor-13cb8d1acefe@brauner>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

On 04/04, Christian Brauner wrote:
>
> On Fri, Apr 04, 2025 at 02:37:38PM +0200, Oleg Nesterov wrote:
> > And... the code looks a bit overcomplicated to me, why not simply
> >
> > 	int pidfd_prepare(struct pid *pid, unsigned int flags, struct file **ret)
> > 	{
> > 		if (!pid_has_task(pid, PIDTYPE_PID))
> > 			return -ESRCH;
> >
> > 		if (!(flags & PIDFD_THREAD) && !pid_has_task(pid, PIDTYPE_TGID))
> > 			return -ENOENT;
>
> I thought that checking PIDTYPE_PID first could cause misleading results
> where we report ENOENT where we should report ESRCH: If the task was
> released after the successful PIDTYPE_PID check for a pid that was never
> a thread-group leader we report ENOENT.

Hmm... but the code above can only return ENOENT if !(flags & PIDFD_THREAD),
so in this case -ENOENT is correct?

I guess -ENOENT would be wrong if this pid _was_ a leader pid and we
race with __unhash_process() which does

	detach_pid(post->pids, p, PIDTYPE_PID);
	if (group_dead)
		detach_pid(post->pids, p, PIDTYPE_TGID);

but without tasklist_lock (or additional barries in both pidfd_prepare() and
__unhash_process() pidfd_prepare() can see the result of these 2 detach_pid()'s
in any order anyway. So I don't think the code above is "more" racy.

Although perhaps we can rely on the fact the the 1st detach_pid(PIDTYPE_PID)
does wake_up(pid->wait_pidfd) and use pid->wait_pidfd->lock to avoid the
races, not sure...

But,

> But I can adapt that to you scheme.

Again, up to you, whatever you prefer.

Oleg.



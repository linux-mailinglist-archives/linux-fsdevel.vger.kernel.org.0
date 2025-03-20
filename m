Return-Path: <linux-fsdevel+bounces-44583-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E0A9A6A7E5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Mar 2025 15:04:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D097C17989F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Mar 2025 14:03:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA51E22332E;
	Thu, 20 Mar 2025 14:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MGij4lb+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D9EF221F21
	for <linux-fsdevel@vger.kernel.org>; Thu, 20 Mar 2025 14:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742479366; cv=none; b=S2XcYAoEFg4IVAu+bRTTaUsF+47fp703XU8B8mIG/lcTVHzd7BOrXX+ANYPt62g1Dn41istQaXZ1p6Rj3urQQLHD74wEYhTCwI3GhRr5sujKSRS/MssNEGuqUBra+ukEWGnisH/jmh4fdYDAK5T02LpxxqoEC68bwX5wvwwEv5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742479366; c=relaxed/simple;
	bh=zqBAOBy9A26vPXgaTolxiTQUgd9qwbb7lJ1xdETILro=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LZ1MkEMMbyzZS3jRROY5Nw+jpucXVks46pCV9C72zYMEIq1LJ6l7KqAj9Cbw2QxuT8ai0cKw1JAr7NVwHsEkYOgjjALe/iQ9OtmbUxAGhzEtqcGMlsoqDXOqp+ZtkBQNir6PP/lhxd/0/2kmco7FMgHJThCHHLv2iSAYQPjNHqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MGij4lb+; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742479363;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zqBAOBy9A26vPXgaTolxiTQUgd9qwbb7lJ1xdETILro=;
	b=MGij4lb+qytFk60Fe7fskMNgUYaCG9V1MnumSflyGFbii1sWHkyq8aV8HIWcxGCYjGAyWY
	d1h+rPe+t/7fEJv9rOZuOgg33/zxNmYSQkE1cVi7GwMuSQahOP/7xHvCl+6+WPocfOmIo5
	XZ5qGGf6CagyZtszkCi84nsyMZQsggs=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-212-pFDVUeVqO9ec8CF6zvD7-g-1; Thu,
 20 Mar 2025 10:02:38 -0400
X-MC-Unique: pFDVUeVqO9ec8CF6zvD7-g-1
X-Mimecast-MFC-AGG-ID: pFDVUeVqO9ec8CF6zvD7-g_1742479357
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4529B1933B69;
	Thu, 20 Mar 2025 14:02:37 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.226.12])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 931B91800268;
	Thu, 20 Mar 2025 14:02:34 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Thu, 20 Mar 2025 15:02:04 +0100 (CET)
Date: Thu, 20 Mar 2025 15:02:00 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>,
	Lennart Poettering <lennart@poettering.net>,
	Daan De Meyer <daan.j.demeyer@gmail.com>,
	Mike Yuan <me@yhndnzj.com>
Subject: Re: [PATCH v3 1/4] pidfs: improve multi-threaded exec and premature
 thread-group leader exit polling
Message-ID: <20250320140159.GD11256@redhat.com>
References: <20250320-work-pidfs-thread_group-v3-0-b7e5f7e2c3b1@kernel.org>
 <20250320-work-pidfs-thread_group-v3-1-b7e5f7e2c3b1@kernel.org>
 <20250320105701.GA11256@redhat.com>
 <20250320-erzwungen-adjektiv-6a73b88f5f30@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250320-erzwungen-adjektiv-6a73b88f5f30@brauner>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On 03/20, Christian Brauner wrote:
>
> What you seem to be saying is that you want all references to
> PIDFD_THREAD to be dropped in the comments because the behavior is now
> identical.

yes, to me the references to PIDFD_THREAD look as if PIDFD_THREAD
has some subtle differences in behavior.

With or without PIDFD_THREAD, do_notify_pidfd() is called and pidfd_poll()
returns EPOLLIN when this thread (leader or not) is ready for wait() from
the parent or debugger.

But!

> So I'm wiping the comments but I very much disagree that they are
> misleading/useless.

No, if you don't agree than do not remove the comments ;)


And... can you explain the motivation for this patch?

I mean... Again, the current PIDFD_THREAD/group-leader behavior is
not well defined, this is clear.

But if user-space does sys_pidfd_open(group_leader_pid) and needs the
"correct" EPOLLIN when the whole process exits, then it should not use
PIDFD_THREAD ?

Just in case, I am not arguing, I am just trying to understand.

Oleg.



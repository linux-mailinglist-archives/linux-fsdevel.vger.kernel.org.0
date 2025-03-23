Return-Path: <linux-fsdevel+bounces-44849-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7B13A6D130
	for <lists+linux-fsdevel@lfdr.de>; Sun, 23 Mar 2025 22:18:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2EC023AA144
	for <lists+linux-fsdevel@lfdr.de>; Sun, 23 Mar 2025 21:18:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60B441A5B93;
	Sun, 23 Mar 2025 21:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VT0oYZCx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BCAB2C80
	for <linux-fsdevel@vger.kernel.org>; Sun, 23 Mar 2025 21:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742764710; cv=none; b=IN/ZU3twhs6FFFyfe+Y+eQF+uZkxgQJ5Gac99cBEC0hEWYAyr6dlR5xLSe1j1j9g3YfDrmgMdAPTri5y4mu1gZ7jeV9/6aOYpMpGrn9bHYW47KMgmzWGlHNoAMONDWsR6F/MDo5HxDm/gEmMPi2LW/q4eldmqkSAmiSPqk6d+1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742764710; c=relaxed/simple;
	bh=K7k/4lAdcBxPul10BwK0YUiK6i67U0jJOikTiZC0Sfs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VI6NpIWyaCxx9xP0z6xdP0TdbRXgai8p4Gdn18gHsNgpR0aAj5wACsB0Vf9Ljx7v9cVMGQg3GvejYzmr8TCPelXMyZK4C16Pi8XxJxsObDWsZwrRCu9Pb8J3bKgA2Crb+xbpa0eUuDfXpK7keBcTi1nqfkh/yY2XlMOD/7FiBP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VT0oYZCx; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742764708;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7eFaFAUQEOpUADtXEIEABMN7g/ZF+W8/Gfudn89uDIQ=;
	b=VT0oYZCxu9ALSiYXXVSWCOS9i8lu7k2qTETKpWno7gSLlPEbhR8jhZ8kfYxamD6n3B/b55
	ZF8ZWNTfBreJO/iECUWEZv7RmbqYmW7RKS1iqeHh0i1rtp8CXsDojX8oUtdmUkfSxEK2Dv
	G4KVNKy0D8DEpLqIP5PcLhX84rY48Jk=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-332-KtAxqD8cMTauRLKCme--Gg-1; Sun,
 23 Mar 2025 17:18:22 -0400
X-MC-Unique: KtAxqD8cMTauRLKCme--Gg-1
X-Mimecast-MFC-AGG-ID: KtAxqD8cMTauRLKCme--Gg_1742764701
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2BB78190308B;
	Sun, 23 Mar 2025 21:18:21 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.42])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 7D5C1195609D;
	Sun, 23 Mar 2025 21:18:18 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Sun, 23 Mar 2025 22:17:48 +0100 (CET)
Date: Sun, 23 Mar 2025 22:17:44 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>,
	Lennart Poettering <lennart@poettering.net>,
	Daan De Meyer <daan.j.demeyer@gmail.com>,
	Mike Yuan <me@yhndnzj.com>
Subject: Re: selftests/pidfd: (Was: [PATCH] pidfs: cleanup the usage of
 do_notify_pidfd())
Message-ID: <20250323211743.GE14883@redhat.com>
References: <20250320-work-pidfs-thread_group-v4-0-da678ce805bf@kernel.org>
 <20250323171955.GA834@redhat.com>
 <20250323174518.GB834@redhat.com>
 <20250323-mixen-neidvoll-4f8f8fe7cc94@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250323-mixen-neidvoll-4f8f8fe7cc94@brauner>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On 03/23, Christian Brauner wrote:
>
> On Sun, Mar 23, 2025 at 06:45:18PM +0100, Oleg Nesterov wrote:
> >
> > I think it is a bad idea to do the things like
> >
> > 	#ifndef __NR_clone3
> > 	#define __NR_clone3 -1
> > 	#endif
> >
> > because this can hide a problem. My working laptop runs Fedora-23 which
> > doesn't have __NR_clone3/etc in /usr/include/. So "make" happily succeeds,
> > but everything fails and it is not clear why.
>
> Yeah, I agree. You want to send your small patch as a quick fix?

OK, will do.

FYI, I have another fixlet,

	exit_info->exit_code = tsk->exit_code;

in pidfs_exit() no longer looks correct with the recent changes.
In fact this was probably wrong after we decided to move pidfs_exit()
to release_task(), but I didn't notice this when I reviewed the last
version of "pidfs: record exit code and cgroupid at exit".

But I need to write the changelog which should explain the uglyness
we already have, and the reason for the change. Perhaps we don't
really care, but I think this should be discussed at least.

Oleg.



Return-Path: <linux-fsdevel+bounces-13858-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C5E3A874CA7
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Mar 2024 11:47:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F19791C21AF0
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Mar 2024 10:47:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BBE58529B;
	Thu,  7 Mar 2024 10:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qyLBjWoA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ACDEDDC9
	for <linux-fsdevel@vger.kernel.org>; Thu,  7 Mar 2024 10:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709808426; cv=none; b=o/zqbLpMftKwrWbmfqSHporvGBJIhYuQ4TexdEsqwFCLOaXkepYv9i5ap+UNbczdoB1PN/eZ6Ps1deKGjUkdBxpJD2kakHzEVy4X58k9U92WU+b0whIbRjg2LWhs8vWYvZzpeaz/PWe9W3eHaaBXW4fk3zhIRjYtfMZ3Vvd7T6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709808426; c=relaxed/simple;
	bh=0cHZCo88TMPHI/LOCPHbec49Nf6mIJ1hzL4UMt7Yc/U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EuXl0wd0KQ8Zgrvc13AmbjK9BfGkQDXlIpGowo0hg1WzLfI/g/R7d+3g2JY7NdAe7j9REDCJl8h5PGnhDwYFO6MiRQP+tdaq/LfCMCs/1lLrG/oPMR85ENHHCgBiz6+VOqR8zil7Eyp7gPYJ+Ij//VexiFVTFPoz9bLPN08Y/Z8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qyLBjWoA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9074C433C7;
	Thu,  7 Mar 2024 10:47:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709808425;
	bh=0cHZCo88TMPHI/LOCPHbec49Nf6mIJ1hzL4UMt7Yc/U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qyLBjWoAup0XscsIlT6rAQ3hdK8dnGb0Eg6jcwxbEMpIhYcnB+FWRlg+QA5FngRk1
	 XgbcGLq2xOId86W7ZB9dAxS7NRG9HpS9ifdSU5fVDf0AVdXYOkISz0Vc3sDl3gmXbx
	 7/PvY58+RSiC2OVPA9YTCgo/XuFZ5oY1MsgqBvBAtNzGD8mYEJX1fNARfxoEvBcyRz
	 04nV35lVFwxCOuQHMFNJuGEAb4rfMcpmErGWevDX4LRTFMQjAVqrsfpjvmRixgXzaE
	 94LIARFNvZw3s523MRHE/VM2eKVLhIWsDiN0mClKVrRVyJQJuPNQDGLzN+ccRU0/p3
	 1VNh+sjOJw+cw==
Date: Thu, 7 Mar 2024 11:47:01 +0100
From: Christian Brauner <brauner@kernel.org>
To: Mikulas Patocka <mpatocka@redhat.com>
Cc: Hugh Dickins <hughd@google.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, 
	linux-mm@kvack.org
Subject: Re: [PATCH] tmpfs: don't interrupt fallocate with EINTR
Message-ID: <20240307-entkriminalisierung-wankt-1187288fbb27@brauner>
References: <ef5c3b-fcd0-db5c-8d4-eeae79e62267@redhat.com>
 <20240305-abgas-tierzucht-1c60219b7839@brauner>
 <84acfa88-816f-50d7-50a2-92ea7a7db42@redhat.com>
 <20240305-zugunsten-busbahnhof-6dc705d80152@brauner>
 <a3834f3-8beb-988a-e387-5c8d31e013f@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a3834f3-8beb-988a-e387-5c8d31e013f@redhat.com>

On Tue, Mar 05, 2024 at 03:03:53PM +0100, Mikulas Patocka wrote:
> 
> 
> On Tue, 5 Mar 2024, Christian Brauner wrote:
> 
> > On Tue, Mar 05, 2024 at 10:34:26AM +0100, Mikulas Patocka wrote:
> > > 
> > > 
> > > On Tue, 5 Mar 2024, Christian Brauner wrote:
> > > 
> > > > On Mon, Mar 04, 2024 at 07:43:39PM +0100, Mikulas Patocka wrote:
> > > > > 
> > > > > Index: linux-2.6/mm/shmem.c
> > > > > ===================================================================
> > > > > --- linux-2.6.orig/mm/shmem.c	2024-01-18 19:18:31.000000000 +0100
> > > > > +++ linux-2.6/mm/shmem.c	2024-03-04 19:05:25.000000000 +0100
> > > > > @@ -3143,7 +3143,7 @@ static long shmem_fallocate(struct file
> > > > >  		 * Good, the fallocate(2) manpage permits EINTR: we may have
> > > > >  		 * been interrupted because we are using up too much memory.
> > > > >  		 */
> > > > > -		if (signal_pending(current))
> > > > > +		if (fatal_signal_pending(current))
> > > > 
> > > > I think that's likely wrong and probably would cause regressions as
> > > > there may be users relying on this?
> > > 
> > > ext4 fallocate doesn't return -EINTR. So, userspace code can't rely on it.
> > 
> > I'm confused what does this have to do with ext4 since this is about
> > tmpfs.
> 
> You said that applications may rely on -EINTR and I said they don't 
> because ext4 doesn't return -EINTR.
> 
> > Also note, that fallocate(2) documents EINTR as a valid return
> > value. And fwiw, the manpage also states that "EINTR  A signal was
> > caught during execution; see signal(7)." not a "fatal signal".
> 
> Yes, but how should the userspace use the fallocate call reliably? Block 
> all the signals around the call to fallocate? What to do if I use some 
> library that calls fallocate and retries on EINTR?
> 
> > Aside from that. If a user sends SIGUSR1 then with the code as it is now
> > that fallocate call will be interrupted. With your change that SIGUSR1
> > won't do anything anymore. Instead userspace would need to send SIGKILL.
> > So userspace that uses SIGUSR1 will suddenly hang.
> 
> It will survive one SIGUSR, but it hangs if the signal is being sent at a 
> periodic interval.
> 
> A quick search shows that people are already adding loops when fallocate 
> returns EINTR. All these loops will livelock when a signal is repeatedly 
> being delivered: 
> https://forge.chapril.org/hardcoresushi/libgocryptfs/commit/8518d6d7bde33fdc7ef5bcb7c3c7709404392ad8?style=unified&whitespace= 
> https://postgrespro.com/media/maillist-attaches/pgsql-hackers/2022/07/1/20220701154105.jjfutmngoedgiad3@alvherre.pgsql/v2-0001-retry-ftruncate.patch 
> https://lists.nongnu.org/archive/html/qemu-devel/2015-02/msg01116.html
> 
> Here, Postgres developers hit the same problem with retrying (they have 
> 5ms timer):
> https://www.postgresql.org/message-id/CA%2BhUKGKS2Radu-1Ewhe1-LEj19C-3XAQ7wnkQMb4e9E9q9ZXSg%40mail.gmail.com

All fair points.


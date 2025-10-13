Return-Path: <linux-fsdevel+bounces-64013-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EC52BD5C70
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Oct 2025 20:49:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F20118A611E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Oct 2025 18:49:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 450152D374A;
	Mon, 13 Oct 2025 18:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZUTEXPxq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21EC22D73AD
	for <linux-fsdevel@vger.kernel.org>; Mon, 13 Oct 2025 18:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760381353; cv=none; b=JGsGJ+Pp+OuVGozee/2E1W8WPdLyRwv4IqIco3qNWFagNRV4BbSah+mzlg+WoDKGgFJG5cCOO/vNJAG46UwnRmmDiwIevHv//DaBiydk81AX8wIT/7YIA0qtmF35Sn2ijvnmDSCYUx6/abKy16XMXch1GD8fVzbYkkoXKbAjxkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760381353; c=relaxed/simple;
	bh=vDKQLf2zX4fUf97LFE8Olo0Bnc7aaZR0LZz7MiKjsrk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oDpMczzALTC8+CcXvZgiG2FR+wOBqei/1zIlfpD9lOl6yY5egux5PJe0ug+shT/xqvz5HiM9cQvqF4iyJ9jKGCWZ4xWVRjDXY8DBm7DEVFdxmunCrYWlnRbDj1ZmzBHPMYSMCa2rkDg01HxI8z5UDUTIilhFJcR4vksGg24qcfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZUTEXPxq; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760381350;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IArTzD9Rd6pbKFw8bx7rmNikp77yVmo/ioJRL5FLrNg=;
	b=ZUTEXPxqDf7ZzFfd3XPQQPoHH+EKc8MCdVMLxwgPq75UjuE7TcgJsqeGDEvUS8lNuxa3oK
	XJ8dGAKnglP9xSe2d31HiIhGXJMDagdF4bRgwuBOMvRD4SlbjO8u66oDfTr+GpLdlj2xlC
	CR31MAzOz62csIjbm/pyMdjpHq5xp34=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-669-KAgC93bzOM6DCojhdFrIdQ-1; Mon,
 13 Oct 2025 14:49:05 -0400
X-MC-Unique: KAgC93bzOM6DCojhdFrIdQ-1
X-Mimecast-MFC-AGG-ID: KAgC93bzOM6DCojhdFrIdQ_1760381344
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E1F9519560AE;
	Mon, 13 Oct 2025 18:49:03 +0000 (UTC)
Received: from bfoster (unknown [10.22.80.119])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9D8C319560A2;
	Mon, 13 Oct 2025 18:49:02 +0000 (UTC)
Date: Mon, 13 Oct 2025 14:53:11 -0400
From: Brian Foster <bfoster@redhat.com>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: lu gu <giveme.gulu@gmail.com>, Joanne Koong <joannelkoong@gmail.com>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	Bernd Schubert <bernd@bsbernd.com>
Subject: Re: [PATCH 5.15] fuse: Fix race condition in writethrough path A race
Message-ID: <aO1Klyk0OWx_UFpz@bfoster>
References: <20251009110623.3115511-1-giveme.gulu@gmail.com>
 <CAJnrk1aZ4==a3-uoRhH=qDKA36-FE6GoaKDZB7HX3o9pKdibYA@mail.gmail.com>
 <CAFS-8+VcZn7WZgjV9pHz4c8DYHRdP0on6-er5fm9TZF9RAO0xQ@mail.gmail.com>
 <CAFS-8+V1QU8kCWV1eF3-SZtpQwWAuiSuKzCOwKKnEAjmz+rrmw@mail.gmail.com>
 <CAJfpegsFCsEgG74bMUH2rb=9-72rMGrHhFjWik2fV4335U0sCw@mail.gmail.com>
 <CAJfpegs85DzZjzyCNQ+Lh8R2cLDBG=GcMbEfr5PGSS531hxAeA@mail.gmail.com>
 <aO06hoYuvDGiCBc7@bfoster>
 <CAJfpegs0eeBNstSc-bj3HYjzvH6T-G+sVra7Ln+U1sXCGYC5-Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJfpegs0eeBNstSc-bj3HYjzvH6T-G+sVra7Ln+U1sXCGYC5-Q@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On Mon, Oct 13, 2025 at 08:23:39PM +0200, Miklos Szeredi wrote:
> On Mon, 13 Oct 2025 at 19:40, Brian Foster <bfoster@redhat.com> wrote:
> 
> > If I follow the report correctly, we're basically producing an internal
> > inconsistency between mtime and cache state that falsely presents as a
> > remote change, so one of these attr change checks can race with a write
> > in progress and invalidate cache. Do I have that right?
> 
> Yes.
> 
> >
> > But still a few questions..
> >
> > 1. Do we know where exactly the mtime update comes from? Is it the write
> > in progress that updates the file mtime on the backend and creates the
> > inconsistency?
> 
> It can be a previous write.  A write will set STATX_MTIME in
> fi->inval_mask, indicating that the value cached in i_mtime is
> invalid.  But the auto_inval code will ignore that and use  cached
> mtime to compare against the new value.
> 
> We could skip data invalidation if the cached value of mtime is not
> valid, but this could easily result in remote changes being missed.
> 

Hrm Ok. But even if we did miss remote changes, whose to say we can even
resolve that correctly from the kernel anyways..? Like if there happens
to be dirty data in cache and a remote change at the same time, that
kind of sounds like a policy decision for userspace. Maybe the fuse
position should be something like "expose mechanisms to manage this,
otherwise we'll just pick a side." Or "we'll never toss dirty data
unless explicitly asked by userspace."

> >
> > 2. Is it confirmed that auto_inval is the culprit here? It seems logical
> > to me, but it can also be disabled dynamically so couldn't hurt to
> > confirm that if there's a reproducer.
> 
> Yes, reproducer has auto_inval_data turned on (libfuse turns it on by default).
> 

I was more wondering if the problem goes away if it were disabled..

> >
> > 3. I don't think we should be able to invalidate "dirty" folios like
> > this. On a quick look though, it seems we don't mark folios dirty in
> > this write path. Is that right?
> 
> Correct.
> 
> >
> > If so, I'm a little curious if that's more of a "no apparent need" thing
> > since the writeback occurs right in that path vs. that is an actual
> > wrong thing to do for some reason. Hm?
> 
> Good question.  I think it's wrong, since dirtying the pages would
> allow the witeback code to pick them up, which would be messy.
> 

Ah, yeah that makes sense. Though invalidate waits on writeback. Any
reason this path couldn't skip the dirty state but mark the pages as
under writeback across the op?

> > Agreed in general. IIUC, this is ultimately a heuristic that isn't
> > guaranteed to necessarily get things right for the backing fs. ISTM that
> > maybe fuse is trying too hard to handle the distributed case correctly
> > where the backing fs should be the one to implement this sort of thing
> > through exposed mechanisms. OTOH so long as the heuristic exists we
> > should probably at least work to make it internally consistent.
> 
> Yes, that's my problem.  How can we fix this without adding too much
> complexity and without breaking existing uses?
> 

I probably need to stare at the code some more. Sorry, it's been quite a
while since I've looked at this. Curious.. was there something wrong
with your unstable mtime idea, or just that it might not be fully
generic enough?

This might be a good question for any fuse based distributed fs
projects. I'm not sure if/how active glusterfs is these days..

Brian

> Thanks,
> Miklos
> 



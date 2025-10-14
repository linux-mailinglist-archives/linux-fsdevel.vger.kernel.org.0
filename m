Return-Path: <linux-fsdevel+bounces-64137-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E4D02BD9D46
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Oct 2025 15:57:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A434A3B6F67
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Oct 2025 13:57:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E1F43148AB;
	Tue, 14 Oct 2025 13:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J+V1pvA6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D483E313E1C
	for <linux-fsdevel@vger.kernel.org>; Tue, 14 Oct 2025 13:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760450254; cv=none; b=PPOvoJVVc3L7COlUSqHk2w/NZ6gSmZs5O8g/ivM7kxuNNnNJWwWBbVBMZiP6MDf8MxWN4VivZ/Bl+HHnFZi8OMPvJhSxfbZ79YPwrucmIsQiZm7yFakAOa5rE/R3HCX8KZU+StKeWizINDKNZrHYa1C4QynFntR6VTtAAQYukEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760450254; c=relaxed/simple;
	bh=9Bp8AJ/WQRQ295sdmc7ICQoc1WRNJmV+9KA7IvNc/no=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NZtnTSbQ/8BnYw+v4xeYzzPTGJMpPxQtN+Ggxa02CCWhcYEY1/lpfXsPZgK65i1N9yNWBrmqIVysXlSnJYqBCg2p5lzABXXdh/BhJ8lC2GjBGN+LaKKFP8Fp9DjcZkemddt+pyo29bo+Yn3kmpvqauBy8dbh2KhM4DHFrovAALE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=J+V1pvA6; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760450250;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CLqZvZmZP+WAmkYpFaM0w/WfiPIL+h8tjIzXNrAJ52Q=;
	b=J+V1pvA6OhVsdOrQdwqCIGyq0hzVPRIhareMdsDUTpezDc0fc1KcNtE84np+Tx9gGnUMsj
	aKfVaF+86hoobA9louXMa0fXqnzskt3PmCCiC+4MdI0A4xliESFVyMhsfFyL+rTDGV0TMr
	agaGjdfJgGk2B84ehGDG76q6BlsN1VI=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-629-WLClpadGMXi7wIzoT8PDug-1; Tue,
 14 Oct 2025 09:57:27 -0400
X-MC-Unique: WLClpadGMXi7wIzoT8PDug-1
X-Mimecast-MFC-AGG-ID: WLClpadGMXi7wIzoT8PDug_1760450246
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id AC9C1180034D;
	Tue, 14 Oct 2025 13:57:25 +0000 (UTC)
Received: from bfoster (unknown [10.22.80.119])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 98AEF1801AD7;
	Tue, 14 Oct 2025 13:57:24 +0000 (UTC)
Date: Tue, 14 Oct 2025 10:01:33 -0400
From: Brian Foster <bfoster@redhat.com>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: lu gu <giveme.gulu@gmail.com>, Joanne Koong <joannelkoong@gmail.com>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	Bernd Schubert <bernd@bsbernd.com>
Subject: Re: [PATCH 5.15] fuse: Fix race condition in writethrough path A race
Message-ID: <aO5XvcuhEpw6BmiV@bfoster>
References: <20251009110623.3115511-1-giveme.gulu@gmail.com>
 <CAJnrk1aZ4==a3-uoRhH=qDKA36-FE6GoaKDZB7HX3o9pKdibYA@mail.gmail.com>
 <CAFS-8+VcZn7WZgjV9pHz4c8DYHRdP0on6-er5fm9TZF9RAO0xQ@mail.gmail.com>
 <CAFS-8+V1QU8kCWV1eF3-SZtpQwWAuiSuKzCOwKKnEAjmz+rrmw@mail.gmail.com>
 <CAJfpegsFCsEgG74bMUH2rb=9-72rMGrHhFjWik2fV4335U0sCw@mail.gmail.com>
 <CAJfpegs85DzZjzyCNQ+Lh8R2cLDBG=GcMbEfr5PGSS531hxAeA@mail.gmail.com>
 <aO06hoYuvDGiCBc7@bfoster>
 <CAJfpegs0eeBNstSc-bj3HYjzvH6T-G+sVra7Ln+U1sXCGYC5-Q@mail.gmail.com>
 <aO1Klyk0OWx_UFpz@bfoster>
 <CAJfpeguoN5m4QVnwHPfyoq7=_BMRkWTBWZmY8iy7jMgF_h3uhA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJfpeguoN5m4QVnwHPfyoq7=_BMRkWTBWZmY8iy7jMgF_h3uhA@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On Tue, Oct 14, 2025 at 09:48:34AM +0200, Miklos Szeredi wrote:
> On Mon, 13 Oct 2025 at 20:49, Brian Foster <bfoster@redhat.com> wrote:
> 
> > Hrm Ok. But even if we did miss remote changes, whose to say we can even
> > resolve that correctly from the kernel anyways..?
> 
> No, I'm worrying about the case of
> 
> - range1 cached locally,
> - range1 changed remotely (mtime changed)
> - range2 changed locally (mtime changed, cached mtime invalidated)
> - range1 read locally
> 
> That last one will update mtime in cache, see that old cached mtime is
> stale and happily read the stale data.
> 
> What we currently have is more correct in the sense that it will
> invalidate data on any mtime change, be it of local or remote origin.
> 

Yeah, I guess. IMO if you made it policy that this sort of thing is
userspace responsibility, then something like the above is not
necessarily incorrect in fuse, it's more a failure of userspace.

I'd guess the challenge is more how to manage the change in behavior.
Maybe that would need an opt-in flag or something for userspace to
signify it understands it is responsible for external changes, and then
have a notify call or whatever that can tie into cache truncation
(where'd you'd explicitly punch out cache even if dirty).

But TBH, if the writeback thing or something similarly simple works for
resolving the immediate bug, I wouldnt worry too much about it
until/unless there are userspace fs' explicitly looking for that sort of
behavior. Just my .02.

Brian

> > > Yes, reproducer has auto_inval_data turned on (libfuse turns it on by default).
> > >
> >
> > I was more wondering if the problem goes away if it were disabled..
> 
> I haven't tried, @guangming?
> 
> > Ah, yeah that makes sense. Though invalidate waits on writeback. Any
> > reason this path couldn't skip the dirty state but mark the pages as
> > under writeback across the op?
> 
> Maybe that'd work.  It *is* under writeback after all.
> 
> Maybe the solution is to change the write-through to regular cached
> write + fsync range?  That could even be a complexity reduction.
> 
> Thanks,
> Miklos
> 



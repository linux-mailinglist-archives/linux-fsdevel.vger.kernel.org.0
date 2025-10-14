Return-Path: <linux-fsdevel+bounces-64153-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93ACABDADAB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Oct 2025 19:53:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1FB25479E0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Oct 2025 17:53:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A322D30BBB5;
	Tue, 14 Oct 2025 17:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="B37svGEk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 184D4307AD4
	for <linux-fsdevel@vger.kernel.org>; Tue, 14 Oct 2025 17:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760464378; cv=none; b=tRnLTf6zLKc/BhvMxzW7UYUfXT1ttkiL51wwzZSrnW0Lo3pYkMOuhp6B02r/iD3CcuGMUn6B+8CUQcE39cAx3+uOtMiYenAK3ObRweImLXdGv8Mq9Yy6SoPm63M5lpGCoDMGjNrwem4QtAM1qTA4wVA7abKbdj8WqB4+CLMyjM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760464378; c=relaxed/simple;
	bh=PVzOy9zEvZPI0zXoZBvsf5L2XJJdgoZLMGh8eLtciMA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gTjZSOrfENJTMHbbZS+euscDULC39DVRtAb9kTPO9Mgr7fhzkvT7u9nstmEu+wd1Fdp9vi+CBFT3YuAh7i5Q4Ndv9o4Rp/g4uSmTw9RI2BGJqiNh8qne7aLXGu4QmigjdF3j0d3Ox8J3t6GNTPSa4yKP0r9rwHV96QsQD+MMhxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=B37svGEk; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760464375;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7h7pthixCPmSqhiPy4iPeK+J6lCEADyF3OJpbLw6ehQ=;
	b=B37svGEkrjjtD0us/S72CAL8g6X/B3irWu1GP9Rb98su3uew2LSWB9tH75avRAxcfU9oCs
	vpQs7fF30/37WlpuCZyiUk4X8+234fTDYKRqcA/wZeTPTdvipc0aMsKzKPwVK4iF/Jb6AB
	hfFgD2HK9TkMyDwgr8ZnA73W2vKpvpw=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-609-xfYb1dlbMUSPUilDsbM1eQ-1; Tue,
 14 Oct 2025 13:52:49 -0400
X-MC-Unique: xfYb1dlbMUSPUilDsbM1eQ-1
X-Mimecast-MFC-AGG-ID: xfYb1dlbMUSPUilDsbM1eQ_1760464368
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 877291955E85;
	Tue, 14 Oct 2025 17:52:48 +0000 (UTC)
Received: from bfoster (unknown [10.22.80.119])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 344981955F21;
	Tue, 14 Oct 2025 17:52:47 +0000 (UTC)
Date: Tue, 14 Oct 2025 13:56:56 -0400
From: Brian Foster <bfoster@redhat.com>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, lu gu <giveme.gulu@gmail.com>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	Bernd Schubert <bernd@bsbernd.com>
Subject: Re: [PATCH 5.15] fuse: Fix race condition in writethrough path A race
Message-ID: <aO6N-g-y6VbSItzZ@bfoster>
References: <CAFS-8+VcZn7WZgjV9pHz4c8DYHRdP0on6-er5fm9TZF9RAO0xQ@mail.gmail.com>
 <CAFS-8+V1QU8kCWV1eF3-SZtpQwWAuiSuKzCOwKKnEAjmz+rrmw@mail.gmail.com>
 <CAJfpegsFCsEgG74bMUH2rb=9-72rMGrHhFjWik2fV4335U0sCw@mail.gmail.com>
 <CAJfpegs85DzZjzyCNQ+Lh8R2cLDBG=GcMbEfr5PGSS531hxAeA@mail.gmail.com>
 <aO06hoYuvDGiCBc7@bfoster>
 <CAJfpegs0eeBNstSc-bj3HYjzvH6T-G+sVra7Ln+U1sXCGYC5-Q@mail.gmail.com>
 <aO1Klyk0OWx_UFpz@bfoster>
 <CAJfpeguoN5m4QVnwHPfyoq7=_BMRkWTBWZmY8iy7jMgF_h3uhA@mail.gmail.com>
 <CAJfpegt-OEGLwiBa=dJJowKM5vMFa+xCMZQZ0dKAWZebQ9iRdA@mail.gmail.com>
 <CAJnrk1Z26+c_xqTavib=t4h=Jb3CFwb7NXP=4DdLhWzUwS-QtQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJnrk1Z26+c_xqTavib=t4h=Jb3CFwb7NXP=4DdLhWzUwS-QtQ@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On Tue, Oct 14, 2025 at 10:01:53AM -0700, Joanne Koong wrote:
> On Tue, Oct 14, 2025 at 5:43 AM Miklos Szeredi <miklos@szeredi.hu> wrote:
> >
> > On Tue, 14 Oct 2025 at 09:48, Miklos Szeredi <miklos@szeredi.hu> wrote:
> >
> > > Maybe the solution is to change the write-through to regular cached
> > > write + fsync range?  That could even be a complexity reduction.
> >
> > While this would be nice, it's impossible to guarantee requests being
> > initiated in the context of the original write(2), which means that
> > the information about which open file it originated from might be
> > lost.   This could result in regressions, so I don't think we should
> > risk it.
> >
> > Will try the idea of marking folios writeback for the duration of the write.
> >
> 
> Is it safe to mark a folio as being under writeback if it doesn't
> actually go through mm writeback? for example, my understanding is
> that the inode wb mechanisms get initiated when an inode is marked
> dirty (__mark_inode_dirty()) but writethrough skips any dirtying.
> Afaict, folio_start_writeback()/folio_end_write() needs i_wb.
> Additionally, if the server page faults on the folio that is now
> marked as under writeback, does that lead to a deadlock since
> page_mkwrite() waits on folio writeback?
> 

WRT dirtying I think Miklos was primarily concerned with some other
thread being able to pick up the folio for writeback. I'm not certain if
writeback is dependent on being dirty, but if it is, ISTM you could
technically still mark the folio dirty and transition it to writeback
before it's unlocked in the write path. To Miklos earlier point that
would put the folio through the same sequence as proper writeback,
except I think would claim the writeback work for the current task.

That might start to look wonky I suppose, but maybe that can be
addressed after if it can at least be shown to fix the problem. For
example, if it's really just the wb that is an issue, perhaps an
inode_attach_wb() is all that's needed?

I'm not sure about the fault case. I'm assuming fuse still supports
traditional writeback and that this would all work similarly to that
case.

Brian

> 
> Thanks,
> Joanne
> 
> > Thanks,
> > Miklos
> 



Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 457C0466644
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Dec 2021 16:14:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358902AbhLBPSB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 2 Dec 2021 10:18:01 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:20866 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1358894AbhLBPSA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 2 Dec 2021 10:18:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1638458077;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=FuWM/nUinNNYTfhs/J8qt17tdv5Gw4lghN8CpUibidM=;
        b=W2ACtinJbbE3Hlv2vjCNsrvvxCT0xs+493DKELtAeknvfd/aPo6gl3YA5dRuZ6Ge40ZPu+
        dwyxrXjxTXvSyB9awLzFw6uRQ88cs2dstfNUIiJett8oQK++Hjl6OlDKdsJnew/3uwF9SD
        +nwRZy4BH9sjAWcAbIDmwjcivwUpqJ8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-379-xM7W9_TYP7yyj7wT1qNm1w-1; Thu, 02 Dec 2021 10:14:32 -0500
X-MC-Unique: xM7W9_TYP7yyj7wT1qNm1w-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4A314802925;
        Thu,  2 Dec 2021 15:14:30 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.22.10.181])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1E0FB19729;
        Thu,  2 Dec 2021 15:14:29 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id A048E225F43; Thu,  2 Dec 2021 10:14:28 -0500 (EST)
Date:   Thu, 2 Dec 2021 10:14:28 -0500
From:   Vivek Goyal <vgoyal@redhat.com>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Chengguang Xu <cgxu519@mykernel.net>, Jan Kara <jack@suse.cz>,
        Miklos Szeredi <miklos@szeredi.hu>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        ronyjin <ronyjin@tencent.com>,
        charliecgxu <charliecgxu@tencent.com>
Subject: Re: ovl_flush() behavior
Message-ID: <Yaji1C/wK73jAkho@redhat.com>
References: <20211130112206.GE7174@quack2.suse.cz>
 <17d719b79f9.d89bf95117881.5882353172682156775@mykernel.net>
 <CAOQ4uxidK-yDMZoZtoRwTZLgSTr1o2Mu2L55vJRNJDLV0-Sb1w@mail.gmail.com>
 <17d73da701b.e571c37220081.6904057835107693340@mykernel.net>
 <17d74b08dcd.c0e94e6320632.9167792887632811518@mykernel.net>
 <CAOQ4uxiCYFeeH8oUUNG+rDCru_1XcwB6fR2keS1C6=d_yD9XzA@mail.gmail.com>
 <20211201134610.GA1815@quack2.suse.cz>
 <17d76cf59ee.12f4517f122167.2687299278423224602@mykernel.net>
 <CAOQ4uxiEjGms-sKhrVDtDHSEk97Wku5oPxnmy4vVB=6yRE_Hdg@mail.gmail.com>
 <CAOQ4uxg6FATciQhzRifOft4gMZj15G=UA6MUiPX2n9-NR5+1Pg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxg6FATciQhzRifOft4gMZj15G=UA6MUiPX2n9-NR5+1Pg@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Dec 02, 2021 at 01:23:17AM +0200, Amir Goldstein wrote:
> > >
> > > To be honest I even don't fully understand what's the ->flush() logic in overlayfs.
> > > Why should we open new underlying file when calling ->flush()?
> > > Is it still correct in the case of opening lower layer first then copy-uped case?
> > >
> >
> > The semantics of flush() are far from being uniform across filesystems.
> > most local filesystems do nothing on close.
> > most network fs only flush dirty data when a writer closes a file
> > but not when a reader closes a file.
> > It is hard to imagine that applications rely on flush-on-close of
> > rdonly fd behavior and I agree that flushing only if original fd was upper
> > makes more sense, so I am not sure if it is really essential for
> > overlayfs to open an upper rdonly fd just to do whatever the upper fs
> > would have done on close of rdonly fd, but maybe there is no good
> > reason to change this behavior either.
> >
> 
> On second thought, I think there may be a good reason to change
> ovl_flush() otherwise I wouldn't have submitted commit
> a390ccb316be ("fuse: add FOPEN_NOFLUSH") - I did observe
> applications that frequently open short lived rdonly fds and suffered
> undesired latencies on close().
> 
> As for "changing existing behavior", I think that most fs used as
> upper do not implement flush at all.
> Using fuse/virtiofs as overlayfs upper is quite new, so maybe that
> is not a problem and maybe the new behavior would be preferred
> for those users?

It probably will be nice not to send flush to fuse server when it is not
required.

Right now in virtiofsd, I see that we are depending on flush being sent
as we are dealing with remote posix lock magic. I am supporting remotme
posix locks in virtiofs and virtiofsd is building these on top of open
file description locks on host. (Can't use posix locks on host as these
locks are per process and virtiofsd is single process working on behalf
of all the guest processes, and unexpected things happen).

When an fd is being closed, flush request is sent and along with it we
also send "lock_owner".

inarg.lock_owner = fuse_lock_owner_id(fm->fc, id);

We basically use this to keep track which process is closing the fd and
release associated OFD locks on host. /me needs to dive into details
to explain it better. Will do that if need be.

Bottom line is that as of now virtiofsd seems to be relying on receiving
FLUSH requests when remote posix locks are enabled. Maybe we can set
FOPEN_NOFLUSH when remote posix locks are not enabled.

Thanks
Vivek


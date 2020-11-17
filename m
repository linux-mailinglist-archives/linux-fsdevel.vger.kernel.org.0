Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87FE82B68E0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Nov 2020 16:41:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726387AbgKQPlB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 17 Nov 2020 10:41:01 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:24533 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725943AbgKQPlB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 17 Nov 2020 10:41:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605627659;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xKDdrSI/aSHcVUy/06h/d1EYaudf4mxgMxIcCKQFIac=;
        b=cs187l6Cj6VwTGjnnvgZztI5M8g/Aw3pF5jXRtRWl3cKIdsPX+pFO+aGnD0XUYn854a1H7
        5I/MEpJJ9xsNH2Ypzhkq0A6X0GkfvIlaDl9WOc03QJxtpsDTgA9aW9K+L1zALwsRaiPtbP
        +n8/2qifY5agNIv5XyGulesuZfgmksw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-421-w8bKMC-_NviOUMKimRinhg-1; Tue, 17 Nov 2020 10:40:56 -0500
X-MC-Unique: w8bKMC-_NviOUMKimRinhg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4938C1075621;
        Tue, 17 Nov 2020 15:40:54 +0000 (UTC)
Received: from horse.redhat.com (ovpn-116-186.rdu2.redhat.com [10.10.116.186])
        by smtp.corp.redhat.com (Postfix) with ESMTP id AC4B660C04;
        Tue, 17 Nov 2020 15:40:51 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id CDDF4220BCF; Tue, 17 Nov 2020 10:40:50 -0500 (EST)
Date:   Tue, 17 Nov 2020 10:40:50 -0500
From:   Vivek Goyal <vgoyal@redhat.com>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Sargun Dhillon <sargun@sargun.me>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Daniel J Walsh <dwalsh@redhat.com>,
        David Howells <dhowells@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Chengguang Xu <cgxu519@mykernel.net>
Subject: Re: [RFC PATCH 3/3] overlay: Add the ability to remount volatile
 directories when safe
Message-ID: <20201117154050.GB78221@redhat.com>
References: <20201116045758.21774-1-sargun@sargun.me>
 <20201116045758.21774-4-sargun@sargun.me>
 <20201116144240.GA9190@redhat.com>
 <CAOQ4uxgMmxhT1fef9OtivDjxx7FYNpm7Y=o_C-zx5F+Do3kQSA@mail.gmail.com>
 <20201116163615.GA17680@redhat.com>
 <CAOQ4uxgTXHR3J6HueS_TO5La890bCfsWUeMXKgGnvUth26h29Q@mail.gmail.com>
 <20201116210950.GD9190@redhat.com>
 <CAOQ4uxhkRauEM46nbhZuGdJmP8UGQpe+fw_FtXy+S4eaR4uxTA@mail.gmail.com>
 <20201117144857.GA78221@redhat.com>
 <CAOQ4uxg1ZNSid58LLsGC2tJLk_fpJfu13oOzCz5ScEi6y_4Nnw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxg1ZNSid58LLsGC2tJLk_fpJfu13oOzCz5ScEi6y_4Nnw@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Nov 17, 2020 at 05:24:33PM +0200, Amir Goldstein wrote:
> > > I guess if we change fsync and syncfs to do nothing but return
> > > error if any writeback error happened since mount we will be ok?
> >
> > I guess that will not be sufficient. Because overlay fsync/syncfs can
> > only retrun any error which has happened so far. It is still possible
> > that error happens right after this fsync call and application still
> > reads back old/corrupted data.
> >
> > So this proposal reduces the race window but does not completely
> > eliminate it.
> >
> 
> That's true.
> 
> > We probably will have to sync upper/ and if there are no errors reported,
> > then it should be ok to consume data back.
> >
> > This leads back to same issue of doing fsync/sync which we are trying
> > to avoid with volatile containers. So we have two options.
> >
> > A. Build volatile containers should sync upper and then pack upper/ into
> >   an image. if final sync returns error, throw away the container and
> >   rebuild image. This will avoid intermediate fsync calls but does not
> >   eliminate final syncfs requirement on upper. Now one can either choose
> >   to do syncfs on upper/ or implement a more optimized syncfs through
> >   overlay so that selctives dirty inodes are synced instead.
> >
> > B. Alternatively, live dangerously and know that it is possible that
> >   writeback error happens and you read back corrupted data.
> >
> 
> C. "shutdown" the filesystem if writeback errors happened and return
>      EIO from any read, like some blockdev filesystems will do in face
>      of metadata write errors
> 

Option C sounds interesting. If data writeback fails, shutdown overlay
filesystem and that way image build should fail, container manager
can throw away container and rebuild. And we avoid all the fysnc/syncfs
as we wanted to.

> I happen to have a branch ready for that ;-)
> https://github.com/amir73il/linux/commits/ovl-shutdown

I will check it out.

Thanks
Vivek


Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDBCD2B7FDD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Nov 2020 15:56:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726519AbgKROzc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 18 Nov 2020 09:55:32 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:56282 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725446AbgKROzb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 18 Nov 2020 09:55:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605711330;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=EOTnAlTVJB8vZQ2NNRax/Wvq87dM7jDFni19traWN1Y=;
        b=Rzkmf859NLcpqSwyVDgUvo0N9CKt1u9Ele0etgi/Z823kus1n3ygL9wTmZ9TLb7FqCTk3v
        /vc5DaMWJtR2MjioDqMOPxf7zIEZtSIiRBb+xAoCmccW7dSZrlIWo2XzJE4w+v27D4ihLN
        ZxuRb+rXxGOhhZE9uq5GNDvPwRlStOo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-416-9nGUG89mP7uX4JpsSOlABg-1; Wed, 18 Nov 2020 09:55:26 -0500
X-MC-Unique: 9nGUG89mP7uX4JpsSOlABg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 32DD41084C92;
        Wed, 18 Nov 2020 14:55:25 +0000 (UTC)
Received: from horse.redhat.com (ovpn-117-157.rdu2.redhat.com [10.10.117.157])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BC37A5D9CA;
        Wed, 18 Nov 2020 14:55:23 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id 35C28220203; Wed, 18 Nov 2020 09:55:23 -0500 (EST)
Date:   Wed, 18 Nov 2020 09:55:23 -0500
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
Message-ID: <20201118145523.GA111728@redhat.com>
References: <20201116163615.GA17680@redhat.com>
 <CAOQ4uxgTXHR3J6HueS_TO5La890bCfsWUeMXKgGnvUth26h29Q@mail.gmail.com>
 <20201116210950.GD9190@redhat.com>
 <CAOQ4uxhkRauEM46nbhZuGdJmP8UGQpe+fw_FtXy+S4eaR4uxTA@mail.gmail.com>
 <20201117144857.GA78221@redhat.com>
 <CAOQ4uxg1ZNSid58LLsGC2tJLk_fpJfu13oOzCz5ScEi6y_4Nnw@mail.gmail.com>
 <20201117164600.GC78221@redhat.com>
 <CAOQ4uxgi-8sn4S3pRr0NQC5sjp9fLmVsfno1nSa2ugfM2KQLLQ@mail.gmail.com>
 <20201117182940.GA91497@redhat.com>
 <CAOQ4uxjkmooYY-NAVrSZOU9BDP0azmbrrmkKNKgyQOURR6eqEg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxjkmooYY-NAVrSZOU9BDP0azmbrrmkKNKgyQOURR6eqEg@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Nov 18, 2020 at 09:24:04AM +0200, Amir Goldstein wrote:
> On Tue, Nov 17, 2020 at 8:29 PM Vivek Goyal <vgoyal@redhat.com> wrote:
> >
> > On Tue, Nov 17, 2020 at 08:03:16PM +0200, Amir Goldstein wrote:
> > > > > C. "shutdown" the filesystem if writeback errors happened and return
> > > > >      EIO from any read, like some blockdev filesystems will do in face
> > > > >      of metadata write errors
> > > > >
> > > > > I happen to have a branch ready for that ;-)
> > > > > https://github.com/amir73il/linux/commits/ovl-shutdown
> > > >
> > > >
> > > > This branch seems to implement shutdown ioctl. So it will still need
> > > > glue code to detect writeback failure in upper/ and trigger shutdown
> > > > internally?
> > > >
> > >
> > > Yes.
> > > ovl_get_acess() can check both the administrative ofs->goingdown
> > > command and the upper writeback error condition for volatile ovl
> > > or something like that.
> >
> > This approach will not help mmaped() pages though, if I do.
> >
> > - Store to addr
> > - msync
> > - Load from addr
> >
> > There is a chance that I can still read back old data.
> >
> 
> msync does not go through overlay. It goes directly to upper fs,
> so it will sync pages and return error on volatile overlay as well.

Ok. Its because vma->vm_file points to realfile.

So even for volatile containers we only avoid fsync/syncfs and not msync.
msync will directly call into upper/. 

> 
> Maybe there will still be weird corner cases, but the shutdown approach
> should cover most or all of the interesting cases.

Agreed.

Vivek


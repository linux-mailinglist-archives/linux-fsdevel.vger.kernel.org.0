Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A36BB284C37
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Oct 2020 15:06:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726139AbgJFNG4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 6 Oct 2020 09:06:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:39239 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725891AbgJFNGw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 6 Oct 2020 09:06:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1601989611;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Y104BtTdOzAa80N7i3WOmV1nO/+g8slrnxNz0C4ODak=;
        b=f80H9gghhmy/2OkzdENke3Yb5mHa6mek/SWcH2F5NAlnu+W8wgQKoymI3cga64DEs3zVqt
        RgZtNqUZMhf1taYPkN4lajufDYVbB5zS0n7NzQsfneyagXsKAIKRaw01KJlBUSp3PxZJsw
        ua4r+DHtqyMdFOt5soKN8gycrE/Y0lA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-166-Di54MA5uOGqm0AYrOkFu7g-1; Tue, 06 Oct 2020 09:06:48 -0400
X-MC-Unique: Di54MA5uOGqm0AYrOkFu7g-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9754A8030C7;
        Tue,  6 Oct 2020 13:06:47 +0000 (UTC)
Received: from horse.redhat.com (ovpn-117-72.rdu2.redhat.com [10.10.117.72])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9B9D79CBA;
        Tue,  6 Oct 2020 13:06:38 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id 3CCFE220AD7; Tue,  6 Oct 2020 09:06:38 -0400 (EDT)
Date:   Tue, 6 Oct 2020 09:06:38 -0400
From:   Vivek Goyal <vgoyal@redhat.com>
To:     Stefan Hajnoczi <stefanha@redhat.com>
Cc:     Qian Cai <cai@redhat.com>, Miklos Szeredi <miklos@szeredi.hu>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        virtio-fs@redhat.com
Subject: Re: virtiofs: WARN_ON(out_sgs + in_sgs != total_sgs)
Message-ID: <20201006130638.GA5306@redhat.com>
References: <5ea77e9f6cb8c2db43b09fbd4158ab2d8c066a0a.camel@redhat.com>
 <a2810c3a656115fab85fc173186f3e2c02a98182.camel@redhat.com>
 <20201004143119.GA58616@redhat.com>
 <20201006090427.GA41482@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201006090427.GA41482@stefanha-x1.localdomain>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Oct 06, 2020 at 10:04:27AM +0100, Stefan Hajnoczi wrote:
> On Sun, Oct 04, 2020 at 10:31:19AM -0400, Vivek Goyal wrote:
> > On Fri, Oct 02, 2020 at 10:44:37PM -0400, Qian Cai wrote:
> > > On Fri, 2020-10-02 at 12:28 -0400, Qian Cai wrote:
> > > > Running some fuzzing on virtiofs from a non-privileged user could trigger a
> > > > warning in virtio_fs_enqueue_req():
> > > > 
> > > > WARN_ON(out_sgs + in_sgs != total_sgs);
> > > 
> > > Okay, I can reproduce this after running for a few hours:
> > > 
> > > out_sgs = 3, in_sgs = 2, total_sgs = 6
> > 
> > Thanks. I can also reproduce it simply by calling.
> > 
> > ioctl(fd, 0x5a004000, buf);
> > 
> > I think following WARN_ON() is not correct.
> > 
> > WARN_ON(out_sgs + in_sgs != total_sgs)
> > 
> > toal_sgs should actually be max sgs. It looks at ap->num_pages and
> > counts one sg for each page. And it assumes that same number of
> > pages will be used both for input and output.
> > 
> > But there are no such guarantees. With above ioctl() call, I noticed
> > we are using 2 pages for input (out_sgs) and one page for output (in_sgs).
> > 
> > So out_sgs=4, in_sgs=3 and total_sgs=8 and warning triggers.
> > 
> > I think total sgs is actually max number of sgs and warning
> > should probably be.
> > 
> > WARN_ON(out_sgs + in_sgs >  total_sgs)
> > 
> > Stefan, WDYT?
> 
> It should be possible to calculate total_sgs precisely (not a maximum).
> Treating it as a maximum could hide bugs.

I thought about calculating total_sgs as well. Then became little lazy.
I will redo the patch and then calculate total_sgs precisely.

> 
> Maybe sg_count_fuse_req() should count in_args/out_args[numargs -
> 1].size pages instead of adding ap->num_pages.

That should work, I guess. Will try.

Vivek
> 
> Do you have the details of struct fuse_req and struct fuse_args_pages
> fields for the ioctl in question?

> 
> Thanks,
> Stefan



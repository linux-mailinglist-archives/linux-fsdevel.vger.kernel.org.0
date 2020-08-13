Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF0FB2436F0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Aug 2020 10:53:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726253AbgHMIxI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 Aug 2020 04:53:08 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:42799 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726106AbgHMIxI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 Aug 2020 04:53:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1597308786;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bHxBlhSxxa/67DKNkFk3S3CDohJlBQmN8kkHMo7F2jw=;
        b=ZbUslsAHu3sgveWvWXm2hALTSdsK9dX/3JkGXB4b+UCMKx822LO3HPQV9I4yGSxgUF9euO
        bo5LAD/dXjbcOct/IgncvqNQanaouLkcjbWY1RvKP/LVCCQecivyu46ZbAUQU4wRzHYklM
        ee7FHFmRuas+pu7o89+BI6yeugZGu+Q=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-170-g7xpvjS9Pg-ZPkk-XNFWnQ-1; Thu, 13 Aug 2020 04:53:01 -0400
X-MC-Unique: g7xpvjS9Pg-ZPkk-XNFWnQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6D1BF80046F;
        Thu, 13 Aug 2020 08:52:59 +0000 (UTC)
Received: from ws.net.home (unknown [10.40.193.69])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 8FE145D9F3;
        Thu, 13 Aug 2020 08:52:55 +0000 (UTC)
Date:   Thu, 13 Aug 2020 10:52:52 +0200
From:   Karel Zak <kzak@redhat.com>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Steven Whitehouse <swhiteho@redhat.com>,
        David Howells <dhowells@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Jeff Layton <jlayton@redhat.com>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Nicolas Dichtel <nicolas.dichtel@6wind.com>,
        Christian Brauner <christian@brauner.io>,
        Lennart Poettering <lennart@poettering.net>,
        Linux API <linux-api@vger.kernel.org>,
        Ian Kent <raven@themaw.net>,
        LSM <linux-security-module@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: file metadata via fs API
Message-ID: <20200813085252.ezwd46ahyjiz4flh@ws.net.home>
References: <20200811135419.GA1263716@miu.piliscsaba.redhat.com>
 <CAHk-=wjzLmMRf=QG-n+1HnxWCx4KTQn9+OhVvUSJ=ZCQd6Y1WA@mail.gmail.com>
 <52483.1597190733@warthog.procyon.org.uk>
 <CAJfpegt=cQ159kEH9zCYVHV7R_08jwMxF0jKrSUV5E=uBg4Lzw@mail.gmail.com>
 <98802.1597220949@warthog.procyon.org.uk>
 <CAJfpegsVJo9e=pHf3YGWkE16fT0QaNGhgkUdq4KUQypXaD=OgQ@mail.gmail.com>
 <d2d179c7-9b60-ca1a-0c9f-d308fc7af5ce@redhat.com>
 <CAJfpeguMjU+n-JXE6aUQQGeMpCS4bsy4HQ37NHJ8aD8Aeg2qhA@mail.gmail.com>
 <20200812112825.b52tqeuro2lquxlw@ws.net.home>
 <CAJfpegv4sC2zm+N5tvEmYaEFvvWJRHfdGqXUoBzbeKj81uNCvQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJfpegv4sC2zm+N5tvEmYaEFvvWJRHfdGqXUoBzbeKj81uNCvQ@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Aug 12, 2020 at 02:43:32PM +0200, Miklos Szeredi wrote:
> On Wed, Aug 12, 2020 at 1:28 PM Karel Zak <kzak@redhat.com> wrote:
> 
> > The proposal is based on paths and open(), how do you plan to deal
> > with mount IDs? David's fsinfo() allows to ask for mount info by mount
> > ID and it works well with mount notification where you get the ID. The
> > collaboration with notification interface is critical for our use-cases.
> 
> One would use the notification to keep an up to date set of attributes
> for each watched mount, right?
> 
> That presumably means the mount ID <-> mount path mapping already
> exists, which means it's just possible to use the open(mount_path,
> O_PATH) to obtain the base fd.

The notification also reports new mount nodes, so we have no mount ID
<-> mount path mapping in userspace yet.

The another problem is that open(path) cannot be used if you have multiple
filesystems on the same mount point -- in this case (at least in theory)
you can get ID for by-path inaccessible filesystem.

> A new syscall that returns an fd pointing to the root of the mount
> might be the best solution:
> 
>    int open_mount(int root_fd, u64 mntid, int flags);

Yes, something like this is necessary. You do not want to depend
on paths if you want to read information about mountpoints.

 Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com


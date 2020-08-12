Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 436B624281C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Aug 2020 12:14:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727821AbgHLKOV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 Aug 2020 06:14:21 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:57518 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727108AbgHLKOV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 Aug 2020 06:14:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1597227260;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xlMaPj1QKypnrQ0JYf3BSvOZztYvxS9nKRk9zqeHA7Y=;
        b=Isi6oYcuaQL/N5QcBPC06FeukL+0Z42GTgP/TBPHqA3thEmAptzRQn4XOwuyRX7mXH4eyo
        ehyjI5ECuIBCj6SvgDZomHldUAJFyhivKGdPGoVGJDBgrg5mgWmb4/KCrOTfwaidESwh09
        mbGMPqyhlQFJcSurNHcIOKiOG+HzUlo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-50-nnbUiC46N7C0aUmdRLKZbg-1; Wed, 12 Aug 2020 06:14:16 -0400
X-MC-Unique: nnbUiC46N7C0aUmdRLKZbg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 580991DE0;
        Wed, 12 Aug 2020 10:14:14 +0000 (UTC)
Received: from ws.net.home (unknown [10.40.193.69])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B7C6B60C84;
        Wed, 12 Aug 2020 10:14:08 +0000 (UTC)
Date:   Wed, 12 Aug 2020 12:14:05 +0200
From:   Karel Zak <kzak@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Miklos Szeredi <miklos@szeredi.hu>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
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
Subject: Re: file metadata via fs API (was: [GIT PULL] Filesystem Information)
Message-ID: <20200812101405.brquf7xxt2q22dd3@ws.net.home>
References: <1842689.1596468469@warthog.procyon.org.uk>
 <1845353.1596469795@warthog.procyon.org.uk>
 <CAJfpegunY3fuxh486x9ysKtXbhTE0745ZCVHcaqs9Gww9RV2CQ@mail.gmail.com>
 <ac1f5e3406abc0af4cd08d818fe920a202a67586.camel@themaw.net>
 <CAJfpegu8omNZ613tLgUY7ukLV131tt7owR+JJ346Kombt79N0A@mail.gmail.com>
 <CAJfpegtNP8rQSS4Z14Ja4x-TOnejdhDRTsmmDD-Cccy2pkfVVw@mail.gmail.com>
 <20200811135419.GA1263716@miu.piliscsaba.redhat.com>
 <CAHk-=wjzLmMRf=QG-n+1HnxWCx4KTQn9+OhVvUSJ=ZCQd6Y1WA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wjzLmMRf=QG-n+1HnxWCx4KTQn9+OhVvUSJ=ZCQd6Y1WA@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Aug 11, 2020 at 08:20:24AM -0700, Linus Torvalds wrote:
> IOW, if you do something more along the lines of
> 
>        fd = open(""foo/bar", O_PATH);
>        metadatafd = openat(fd, "metadataname", O_ALT);
> 
> it might be workable.

I have thought we want to replace mountinfo to reduce overhead. If I
understand your idea than we will need openat()+read()+close() for
each attribute? Sounds like a pretty expensive interface.

The question is also how consistent results you get if you will read
information about the same mountpoint by multiple openat()+read()+close()
calls. 

For example,  by fsinfo(FSINFO_ATTR_MOUNT_TOPOLOGY) you get all
mountpoint propagation setting and relations by one syscall, with
your idea you will read parent, slave and flags by multiple read() and
without any lock. Sounds like you can get a mess if someone moves or
reconfigure the mountpoint or so.
  

openat(O_ALT) seems elegant at first glance, but it will be necessary to 
provide a richer (complex) answers by read() to reduce overhead and 
to make it more consistent for userspace. 

It would be also nice to avoid some strings formatting and separators
like we use in the current mountinfo.

I can imagine multiple values separated by binary header (like we already 
have for watch_notification, inotify, etc):

  fd = openat(fd, "mountinfo", O_ALT);

  sz = read(fd, buf, BUFSZ);
  p = buf;

  while (sz) {
     struct alt_metadata *alt = (struct alt_metadata *) p;

     char *varname = alt->name;
     char *data = alt->data;
     int len  = alt->len;

     sz -= len;
     p += len;
  }


  Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com


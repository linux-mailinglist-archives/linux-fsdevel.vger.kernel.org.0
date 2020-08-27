Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99FEC254AB9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Aug 2020 18:29:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726236AbgH0Q3w (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 Aug 2020 12:29:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:41232 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726123AbgH0Q3w (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 Aug 2020 12:29:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1598545790;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=p2rcfPP9LJoBdRqCmlyNha20vMAkLS8jXZnwZTw7m3o=;
        b=QXVqXVkm4/lPbAf5lvX5ApC8M1bPumBbIaIvfy1hFJQMTSDWSNWeIGvGAUnDRe+30O5wHw
        5rCYMp5S3OhEuiFdJ/fxXSCBeOnRH3tS3/s5HFR8zhgzkuoGg/yRYIPbwknG4JY8J/LNsd
        pz6LmGuogkPYn4sjLoW0ZtikaOIZfgA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-81-lyoX8VbUOzO22VU0E8YrJw-1; Thu, 27 Aug 2020 12:29:47 -0400
X-MC-Unique: lyoX8VbUOzO22VU0E8YrJw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0DE68873115;
        Thu, 27 Aug 2020 16:29:44 +0000 (UTC)
Received: from work-vm (ovpn-114-163.ams2.redhat.com [10.36.114.163])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 9A0AC757CB;
        Thu, 27 Aug 2020 16:29:37 +0000 (UTC)
Date:   Thu, 27 Aug 2020 17:29:35 +0100
From:   "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Christian Schoenebeck <qemu_oss@crudebyte.com>,
        Matthew Wilcox <willy@infradead.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        "Theodore Y. Ts'o" <tytso@mit.edu>,
        Frank van der Linden <fllinden@amazon.com>,
        Dave Chinner <david@fromorbit.com>, Greg Kurz <groug@kaod.org>,
        linux-fsdevel@vger.kernel.org,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Vivek Goyal <vgoyal@redhat.com>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Daniel J Walsh <dwalsh@redhat.com>,
        Chirantan Ekbote <chirantan@chromium.org>
Subject: Re: file forks vs. xattr (was: xattr names for unprivileged
 stacking?)
Message-ID: <20200827162935.GC2837@work-vm>
References: <20200824222924.GF199705@mit.edu>
 <3331978.UQhOATu6MC@silver>
 <20200827140107.GH14765@casper.infradead.org>
 <159855515.fZZa9nWDzX@silver>
 <20200827144452.GA1236603@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200827144452.GA1236603@ZenIV.linux.org.uk>
User-Agent: Mutt/1.14.6 (2020-07-11)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

* Al Viro (viro@zeniv.linux.org.uk) wrote:
> On Thu, Aug 27, 2020 at 04:23:24PM +0200, Christian Schoenebeck wrote:
> 
> > Be invited for making better suggestions. But one thing please: don't start 
> > getting offending.
> > 
> > No matter which delimiter you'd choose, something will break. It is just about 
> > how much will it break und how likely it'll be in practice, not if.
> 
> ... which means NAK.  We don't break userland without very good reasons and
> support for anyone's pet feature is not one of those.  It's as simple as
> that.

I'm curious how much people expect to use these forks from existing
programs - do people expect to be able to do something and edit a fork
using their favorite editor or cat/grep/etc them?

I say that because if they do, then having a special syscall to open
the fork wont fly; and while I agree that any form of suffix is a lost
cause, I wonder what else is possible (although if it wasn't for the
internal difficulties, I do have a soft spot for things that look like
both files and directories showing the forks; but I realise I'm weird
there).

Dave

> > If you are concerned about not breaking anything: keep forks disabled.
> 
> s/disabled/out of tree/
> 
> One general note: the arguments along the lines of "don't enable that,
> then" are either ignorant or actively dishonest; it really doesn't work
> that way, as we'd learnt quite a few times by now.  There's no such
> thing as "optional feature" - *any* feature, no matter how useless,
> might end up a dependency (no matter how needless) of something that
> would force distros to enable it.  We'd been down that road too many
> times to keep pretending that it doesn't happen.
> 
-- 
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DED781991BC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 31 Mar 2020 11:21:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731305AbgCaJVQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 31 Mar 2020 05:21:16 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:40757 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1731864AbgCaJVP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 31 Mar 2020 05:21:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585646474;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GTjY9VYWDP/F7mEWfjv7lXAEg3SDOKfVcGPNXYsvZyU=;
        b=PNuFd67EDDf3+0MFfSKQBc4e4VMuGXyFlkVqDH4nJh7Fb1l51lGJvRmBE48kZiYGm6lEVj
        qB9mNDiSI64BsDUbLdGxIK94a6RYG+RPD977ZtSICV8fFYLie0gxgOf0Ugqawl6DCA5kwC
        meyjqPvJL6evWoVU6bNdi32m6RYRo84=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-197-npjoz2J-OJeG2S4WkAFftw-1; Tue, 31 Mar 2020 05:21:11 -0400
X-MC-Unique: npjoz2J-OJeG2S4WkAFftw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C678D8017CC;
        Tue, 31 Mar 2020 09:21:09 +0000 (UTC)
Received: from ws.net.home (unknown [10.40.194.51])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 6C89919C6A;
        Tue, 31 Mar 2020 09:21:04 +0000 (UTC)
Date:   Tue, 31 Mar 2020 11:21:01 +0200
From:   Karel Zak <kzak@redhat.com>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     David Howells <dhowells@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>, dray@redhat.com,
        Miklos Szeredi <mszeredi@redhat.com>,
        Steven Whitehouse <swhiteho@redhat.com>,
        Jeff Layton <jlayton@redhat.com>, Ian Kent <raven@themaw.net>,
        andres@anarazel.de,
        Christian Brauner <christian.brauner@ubuntu.com>,
        keyrings@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: Upcoming: Notifications, FS notifications and fsinfo()
Message-ID: <20200331092101.fnipaxqewol2hzd2@ws.net.home>
References: <1445647.1585576702@warthog.procyon.org.uk>
 <CAJfpegvZ_qtdGcP4bNQyYt1BbgF9HdaDRsmD43a-Muxgki+wTw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJfpegvZ_qtdGcP4bNQyYt1BbgF9HdaDRsmD43a-Muxgki+wTw@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Mar 30, 2020 at 10:28:56PM +0200, Miklos Szeredi wrote:
> All this could be solved with a string key/value representation of the
> same data, with minimal performance loss on encoding/parsing.  The
> proposed fs interface[1] is one example of that, but I could also
> imagine a syscall based one too.

Yes, key/value is possible solution. The question is if we really 
need to add extra /sys-like filesystem to get key/value ;-) I can 
imagine key/value from FD based interface without open/read/close for
each attribute,

    fd = open("/mnt", O_PATH);
    fsinfo(fd, "propagation", buf, sizeof(buf));
    fsinfo(fd, "fstype", buf, sizeof(buf));
    close(fd);

why I need /mountfs/<id>/propagation and /mountfs/<id>/fstype to get
the same? It sounds like over-engineering without any extra bonus.

Anyway, if we have FD based interfaces like fsopen(), fsmount(),
open_tree() and move_mount() then it sounds strange that you cannot
use the FD to ask kernel for the mount node attributes and you need 
to open and read another /sys-like files. 

IMHO it would be nice that after open(/mnt, O_PATH) I can do whatever
with the mount point (umount, move, reconfigure, query, etc.). Please,
try to keep it simple and consistent ;-)

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com


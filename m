Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4A56D16838C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Feb 2020 17:33:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727469AbgBUQd1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 21 Feb 2020 11:33:27 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:27675 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726791AbgBUQd1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 21 Feb 2020 11:33:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582302806;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BUt7yxaGqyhaBTF6KME7cZTH0QCIcSm1V6IEK/6dFnM=;
        b=fcHmO1Czf0sCOnrRC3uDwsgRLXnR0K2QbZhMSi59cI9UkKPfZx4V4IlXnLRSs4Lo3em6iC
        4subY1G65MCcRhZjqWUAOVT/jDxsrFopJUKgu5aFM6EEiH/mrG1Q9PR2CmWZqw9k3CGFtZ
        uwPnzcncG6JaYNRRmr+Jbgt6IXpKR20=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-314-lXsEKvoKOOGLgNW6yuNVXw-1; Fri, 21 Feb 2020 11:33:24 -0500
X-MC-Unique: lXsEKvoKOOGLgNW6yuNVXw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EA0E319057A4;
        Fri, 21 Feb 2020 16:33:22 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-122-163.rdu2.redhat.com [10.10.122.163])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 40AC48B55C;
        Fri, 21 Feb 2020 16:33:21 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <CAG48ez2nFks+yN1Kp4TZisso+rjvv_4UW0FTo8iFUd4Qyq1qDw@mail.gmail.com>
References: <CAG48ez2nFks+yN1Kp4TZisso+rjvv_4UW0FTo8iFUd4Qyq1qDw@mail.gmail.com> <158204549488.3299825.3783690177353088425.stgit@warthog.procyon.org.uk> <158204561120.3299825.5242636508455859327.stgit@warthog.procyon.org.uk> <CAG48ez2B2J_3-+EjR20ukRu3noPnAccZsOTaea0jtKK4=+bkhQ@mail.gmail.com> <1897788.1582295034@warthog.procyon.org.uk>
To:     Jann Horn <jannh@google.com>
Cc:     dhowells@redhat.com, Al Viro <viro@zeniv.linux.org.uk>,
        raven@themaw.net, Miklos Szeredi <mszeredi@redhat.com>,
        Christian Brauner <christian@brauner.io>,
        Linux API <linux-api@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 15/19] vfs: Add superblock notifications [ver #16]
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2031797.1582302800.1@warthog.procyon.org.uk>
Date:   Fri, 21 Feb 2020 16:33:20 +0000
Message-ID: <2031798.1582302800@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Jann Horn <jannh@google.com> wrote:

> (And as in the other case, the s->s_count increment will probably have
> to be moved above the add_watch_to_object(), unless you hold the
> sb_lock around it?)

It shouldn't matter as I'm holding s->s_umount across the add and increment.
That prevents the watch from being removed: watch_sb() would have to get the
lock first to do that.  It also deactivate_locked_super() from removing all
the watchers.

I can move it before, but I probably have to drop s_umount before I can call
put_super().

David


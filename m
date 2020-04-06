Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 22EE919F24B
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Apr 2020 11:17:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727074AbgDFJRR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 6 Apr 2020 05:17:17 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:39103 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726819AbgDFJRP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 6 Apr 2020 05:17:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586164634;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NEV7TR1aEEGU9BOd+7WjT2xwDzuljghXSkqCe1NlNsM=;
        b=MJGgjZJiaQkT0qeqAk6ss3RwPbkBCsHnSkwU+iHBsy8OH/I2VlwMdyJesKn2Xe1vlVaL3/
        SGwc1lu/w9GqicMeQuMLPwHPi/WnCjkwrDdU5ABXd7XXVbNT1IYx8GKnTDuo3cZTPyMDRe
        JDAmwo5gT9Hoh9AjDZka+hffmpHXYe0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-330-mxPGqf0zPReDwLyoyVPcDA-1; Mon, 06 Apr 2020 05:17:10 -0400
X-MC-Unique: mxPGqf0zPReDwLyoyVPcDA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 04F15100551A;
        Mon,  6 Apr 2020 09:17:08 +0000 (UTC)
Received: from ws.net.home (unknown [10.40.194.51])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 1334A60BFB;
        Mon,  6 Apr 2020 09:17:03 +0000 (UTC)
Date:   Mon, 6 Apr 2020 11:17:01 +0200
From:   Karel Zak <kzak@redhat.com>
To:     "J. Bruce Fields" <bfields@fieldses.org>
Cc:     Lennart Poettering <mzxreary@0pointer.de>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Ian Kent <raven@themaw.net>,
        David Howells <dhowells@redhat.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>, dray@redhat.com,
        Miklos Szeredi <mszeredi@redhat.com>,
        Steven Whitehouse <swhiteho@redhat.com>,
        Jeff Layton <jlayton@redhat.com>, andres@anarazel.de,
        keyrings@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Aleksa Sarai <cyphar@cyphar.com>
Subject: Re: Upcoming: Notifications, FS notifications and fsinfo()
Message-ID: <20200406091701.q7ctdek2grzryiu3@ws.net.home>
References: <CAJfpegs3uDzFTE4PCjZ7aZsEh8b=iy_LqO1DBJoQzkP+i4aBmw@mail.gmail.com>
 <2590640.1585757211@warthog.procyon.org.uk>
 <CAJfpegsXqxizOGwa045jfT6YdUpMxpXET-yJ4T8qudyQbCGkHQ@mail.gmail.com>
 <36e45eae8ad78f7b8889d9d03b8846e78d735d28.camel@themaw.net>
 <CAJfpegsCDWehsTRQ9UJYuQnghnE=M8L0_bJBTTPA+Upu87t90w@mail.gmail.com>
 <27994c53034c8f769ea063a54169317c3ee62c04.camel@themaw.net>
 <20200403111144.GB34663@gardel-login>
 <CAJfpeguQAw+Mgc8QBNd+h3KV8=Y-SOGT7TB_N_54wa8MCoOSzg@mail.gmail.com>
 <20200403151223.GB34800@gardel-login>
 <20200403203024.GB27105@fieldses.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200403203024.GB27105@fieldses.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Apr 03, 2020 at 04:30:24PM -0400, J. Bruce Fields wrote:
> On Fri, Apr 03, 2020 at 05:12:23PM +0200, Lennart Poettering wrote:
> > BTW, while we are at it: one more thing I'd love to see exposed by
> > statx() is a simple flag whether the inode is a mount point. There's
> > plenty code that implements a test like this all over the place, and
> > it usually isn't very safe. There's one implementation in util-linux
> > for example (in the /usr/bin/mountpoint binary), and another one in
> > systemd. Would be awesome to just have a statx() return flag for that,
> > that would make things *so* much easier and more robust. because in
> > fact most code isn't very good that implements this, as much of it
> > just compares st_dev of the specified file and its parent. Better code
> > compares the mount ID, but as mentioned that's not as pretty as it
> > could be so far...
> 
> nfs-utils/support/misc/mountpoint.c:check_is_mountpoint() stats the file
> and ".." and returns true if they have different st_dev or the same
> st_ino.  Comparing mount ids sounds better.

BTW, this traditional st_dev+st_ino way is not reliable for bind mounts.
For mountpoint(1) we search the directory in /proc/self/mountinfo.

> So anyway, yes, everybody reinvents the wheel here, and this would be
> useful.

 +1

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com


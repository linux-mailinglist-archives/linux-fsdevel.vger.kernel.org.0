Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E4893198E9A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 31 Mar 2020 10:34:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730034AbgCaIep (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 31 Mar 2020 04:34:45 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:34382 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729819AbgCaIep (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 31 Mar 2020 04:34:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585643684;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=d3uoqh9h+iojx/+Rg3U0VTN2ulL9+wr9bMc1wrNA4m0=;
        b=ZW8Mu3deDP5e5GVq6IzQwBVRZSWhVnbJd8AoBCvhrBFiHceHSXPYCqyNtEA+W3mLWkpkag
        wi+jHJPfT6yJ+cHD6BncDH76PsK5tY3cd3Y2WjCXletUOvOk6ozu3Tu6/PsGNlwyynmAuc
        LYDj3pDJYNRpCFi8HHEBWdPqip3TgvE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-101-XwWS4oBAN9KvwkitkcQc6A-1; Tue, 31 Mar 2020 04:34:41 -0400
X-MC-Unique: XwWS4oBAN9KvwkitkcQc6A-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 54B2B149C5;
        Tue, 31 Mar 2020 08:34:38 +0000 (UTC)
Received: from ws.net.home (unknown [10.40.194.51])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 1866096B80;
        Tue, 31 Mar 2020 08:34:33 +0000 (UTC)
Date:   Tue, 31 Mar 2020 10:34:30 +0200
From:   Karel Zak <kzak@redhat.com>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Christian Brauner <christian.brauner@ubuntu.com>,
        David Howells <dhowells@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>, dray@redhat.com,
        Miklos Szeredi <mszeredi@redhat.com>,
        Steven Whitehouse <swhiteho@redhat.com>,
        Jeff Layton <jlayton@redhat.com>, Ian Kent <raven@themaw.net>,
        andres@anarazel.de, keyrings@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lennart Poettering <lennart@poettering.net>,
        Aleksa Sarai <cyphar@cyphar.com>
Subject: Re: Upcoming: Notifications, FS notifications and fsinfo()
Message-ID: <20200331083430.kserp35qabnxvths@ws.net.home>
References: <1445647.1585576702@warthog.procyon.org.uk>
 <20200330211700.g7evnuvvjenq3fzm@wittgenstein>
 <CAJfpegtjmkJUSqORFv6jw-sYbqEMh9vJz64+dmzWhATYiBmzVQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJfpegtjmkJUSqORFv6jw-sYbqEMh9vJz64+dmzWhATYiBmzVQ@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Mar 31, 2020 at 07:11:11AM +0200, Miklos Szeredi wrote:
> On Mon, Mar 30, 2020 at 11:17 PM Christian Brauner
> <christian.brauner@ubuntu.com> wrote:
> 
> > Fwiw, putting down my kernel hat and speaking as someone who maintains
> > two container runtimes and various other low-level bits and pieces in
> > userspace who'd make heavy use of this stuff I would prefer the fd-based
> > fsinfo() approach especially in the light of across namespace
> > operations, querying all properties of a mount atomically all-at-once,
> 
> fsinfo(2) doesn't meet the atomically all-at-once requirement.

I guess your /proc based idea have exactly the same problem... 

I see two possible ways:

- after open("/mnt", O_PATH) create copy-on-write object in kernel to
  represent mount node -- kernel will able to modify it, but userspace
  will get unchanged data from the FD until to close()

- improve fsinfo() to provide set (list) of the attributes by one call

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com


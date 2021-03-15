Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A0B033B3A8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Mar 2021 14:18:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229731AbhCONSF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 15 Mar 2021 09:18:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229746AbhCONRz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 15 Mar 2021 09:17:55 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32946C06174A;
        Mon, 15 Mar 2021 06:17:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=7Jrclnurpg02FW6SBK78iFY06pC4oqxMEZmAxzr40dg=; b=mLAmtzek/OysmlUkK2D+l/+ViO
        P0JQHzdgMfu6NrsqY8zXpk6RTX/5nmNEn7oIDRUqEQM84J8B3lrsZGvkP5HHPKPkl0ZkPlrOGt31T
        xLmeHPnJjSHqB50gbfaDl7P7BEhGCQo+FHsuI7rB0HWgJzaaV2BLxt752pSmbcJtzi+bcZ+w405PR
        LUlCDthgLnKXM3rZxlWrYs+w7Fn7g+5hBePLZj+wRC9iUihLEQ2IQwyRZYa6GyFvoC+9pAMFj/oHO
        jpdlTTW3D7CA4MMjxR5B+DrHb0PQVjhMQ/4QM/do1x1T9WIERqk5XF/F184c6va0yydPKlm5RGM5o
        4zjRyPUg==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lLn63-000DJ6-7o; Mon, 15 Mar 2021 13:17:26 +0000
Date:   Mon, 15 Mar 2021 13:17:23 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     David Howells <dhowells@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Ian Kent <raven@themaw.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH 0/3] vfs: Use an xarray instead of inserted
 bookmarks to scan mount list
Message-ID: <20210315131723.GW2577561@casper.infradead.org>
References: <161581005972.2850696.12854461380574304411.stgit@warthog.procyon.org.uk>
 <CAJfpegsb9XrUct5zawN+kS_DSfowBf2BnrZzG+cQXUvsGZZuow@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJfpegsb9XrUct5zawN+kS_DSfowBf2BnrZzG+cQXUvsGZZuow@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Mar 15, 2021 at 02:14:35PM +0100, Miklos Szeredi wrote:
> On Mon, Mar 15, 2021 at 1:07 PM David Howells <dhowells@redhat.com> wrote:
> >
> >
> > Hi Al, Miklós,
> >
> > Can we consider replacing the "insert cursor" approach we're currently
> > using for proc files to scan the current namespace's mount list[1] with
> > something that uses an xarray of mounts indexed by mnt_id?
> >
> > This has some advantages:
> >
> >  (1) It's simpler.  We don't need to insert dummy mount objects as
> >      bookmarks into the mount list and code that's walking the list doesn't
> >      have to carefully step over them.
> >
> >  (2) We can use the file position to represent the mnt_id and can jump to
> >      it directly - ie. using seek() to jump to a mount object by its ID.
> 
> What happens if the mount at the current position is removed?

xa_find() will move to the next one.

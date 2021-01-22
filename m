Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D93282FFE30
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Jan 2021 09:32:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726928AbhAVIZl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 Jan 2021 03:25:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726117AbhAVIZ3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 Jan 2021 03:25:29 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E6B0C06174A;
        Fri, 22 Jan 2021 00:24:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=72GbwhSaNm+KhJ5+LNT/6O1Ghfel0X9o+LJMfhOiuQk=; b=IQkHaX7tWmIiZsoJtwtMD5PQh6
        6sSMyLyDrUNouXEQbmbUFvF24EdKoRDQa0ZVLwmyKYTwKkk5xp0VZU5CE31ATf2ZiFwwXx2JWbobI
        L6BxLzzOyWotGM5q0hLW/+GqNioImLvxzCtdhYXF4e+LcRdZ1djRabadZ94sEhJbx2J7UPgXgvjfa
        tqDLPtgWNi4VqC7fTxuk4GVga87ZtHgv2MpOkaBZNnosvzNqcAZirFHTO8gkgafO10FkseKAjRJRH
        pPnEAyzULxisEGO6ubnq1mviR0vHDhTSpgRApSNaMNMdIYD05p10HJrJYd5YtG0+6ZmbWyHSwiX+4
        B1c4lT/Q==;
Received: from hch by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1l2rj0-000VVB-L7; Fri, 22 Jan 2021 08:23:27 +0000
Date:   Fri, 22 Jan 2021 08:23:22 +0000
From:   Christoph Hellwig <hch@infradead.org>
To:     David Howells <dhowells@redhat.com>
Cc:     "J. Bruce Fields" <bfields@fieldses.org>,
        Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Steve French <sfrench@samba.org>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Takashi Iwai <tiwai@suse.de>,
        Matthew Wilcox <willy@infradead.org>,
        linux-afs@lists.infradead.org, Jeff Layton <jlayton@redhat.com>,
        David Wysochanski <dwysocha@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-cachefs@redhat.com, linux-nfs@vger.kernel.org,
        linux-cifs@vger.kernel.org, ceph-devel@vger.kernel.org,
        v9fs-developer@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH 00/25] Network fs helper library & fscache kiocb API
Message-ID: <20210122082322.GB119852@infradead.org>
References: <20210121174306.GB20964@fieldses.org>
 <20210121164645.GA20964@fieldses.org>
 <161118128472.1232039.11746799833066425131.stgit@warthog.procyon.org.uk>
 <1794286.1611248577@warthog.procyon.org.uk>
 <1851804.1611255313@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1851804.1611255313@warthog.procyon.org.uk>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jan 21, 2021 at 06:55:13PM +0000, David Howells wrote:
> > Is it that those "bridging" blocks only show up in certain corner cases
> > that users can arrange to avoid?  Or that it's OK as long as you use
> > certain specific file systems whose behavior goes beyond what's
> > technically required by the bamp or seek interfaces?
> 
> That's a question for the xfs, ext4 and btrfs maintainers, and may vary
> between kernel versions and fsck or filesystem packing utility versions.

For XFS if you do not use reflinks, extent size hints or the RT
subvolume there are no new allocations before i_size that will magically
show up.  But relying on such undocumented assumptions is very
dangerous.

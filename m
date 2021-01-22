Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 605173009FA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Jan 2021 18:42:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729843AbhAVRgL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 Jan 2021 12:36:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729552AbhAVRdk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 Jan 2021 12:33:40 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6198C061786;
        Fri, 22 Jan 2021 09:32:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=zejNF9PdUWUD58A5TE4kg12XP3Xr4LOy04O8OoxwuFE=; b=Mbs9MA1pDs4QRXJy9LAjLAJeqC
        QQ6Bac+mJ0Jrq7b579w9H7JlOPPin7jEeFhJwD1eGdUrhYYr/HkCYTkQmh5z9EQLXxYTzrAqPaXuI
        nekpAyiGU9uFeRXqI2DfC/04H/KM/JSqyF/esVXM4pF5saNjzdFyXT56P0x5YchkhR3Pp3djw1kLD
        lgZ7BvYOXrBA71e/VoxjJGEKXbTzWFVYuuIlqT1frx7teQOCTcaoSqPnY5gWLX0jL6k5M9KlDxVu1
        8xBjnIIcQh/RESsXhvj8LBSUA/C+6/A91enu49A2RaKoi5kJqHCDO6ej2w5yidz2hl4/qgq8xlVxo
        zMBVcMxg==;
Received: from hch by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1l30Ii-0011Uv-4d; Fri, 22 Jan 2021 17:32:48 +0000
Date:   Fri, 22 Jan 2021 17:32:48 +0000
From:   Christoph Hellwig <hch@infradead.org>
To:     "J. Bruce Fields" <bfields@redhat.com>
Cc:     Christoph Hellwig <hch@infradead.org>, linux-nfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <schumakeranna@gmail.com>,
        Chuck Lever <chuck.lever@oracle.com>
Subject: Re: [PATCH 2/3] nfsd: move change attribute generation to filesystem
Message-ID: <20210122173248.GB241302@infradead.org>
References: <1611084297-27352-1-git-send-email-bfields@redhat.com>
 <1611084297-27352-3-git-send-email-bfields@redhat.com>
 <20210120084638.GA3678536@infradead.org>
 <20210121202756.GA13298@pick.fieldses.org>
 <20210122082059.GA119852@infradead.org>
 <20210122144753.GA52753@pick.fieldses.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210122144753.GA52753@pick.fieldses.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jan 22, 2021 at 09:47:53AM -0500, J. Bruce Fields wrote:
> > > I also have a vague idea that some filesystem-specific improvements
> > > might be possible.  (E.g., if a filesystem had some kind of boot count
> > > in the superblock, maybe that would be a better way to prevent the
> > > change attribute from going backwards on reboot than the thing
> > > generic_fetch_iversion is currently doing with ctime.  But I have no
> > > concrete plan there, maybe I'm dreaming.)
> > 
> > Even without the ctime i_version never goes backward, what is the
> > problem here?
> 
> Suppose a modification bumps the change attribute, a client reads
> the new value of the change attribute before it's committed to disk,
> then the server crashes.  After the server comes back up, the client
> requests the change attribute again and sees an older value.

So all metadata operations kicked off by nfsd are synchronous due
to ->commit_metadata/sync_inode_metadata, so this could only happen
for operations not kicked off by nfsd.  More importanly ctime will
also be lost as i_version and the ctime are commited together.

> 
> That's actually not too bad.  What I'd mainly like to avoid is
> incrementing the change attribute further and risking reuse of an old
> value for a different new state of the file.

Ok but that is an issue if we need to deal with changes that did not
come in through NFSD.

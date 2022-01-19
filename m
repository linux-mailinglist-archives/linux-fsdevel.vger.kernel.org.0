Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6819493446
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Jan 2022 06:20:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244075AbiASFU3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 19 Jan 2022 00:20:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231567AbiASFU2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 19 Jan 2022 00:20:28 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B25D0C061574;
        Tue, 18 Jan 2022 21:20:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=zCnUn09sb6ERyGqIvgioo3seFmwAbbVIJnBrFXm1CgA=; b=2IiHzr3sF6AOeiLyrYxB3stg6B
        In72SYB4+LQGzhMbHoql1xCZ3FVDIuJnKKf2vow9nyfeDi7RuGy9/Qlno8PlYmL9Ug3tC9RB/E8Js
        MW22sT6fJYOti8nlF//wxgcYQmr8yUxIdbAVb++QfZ9fi2BeEIvGq9P/v/eUZgTqO3/HwBjWQ9WCG
        B99ElFBr2hiiTS9KQriCGobMvbk5ORDrXoWfhAC0AypL72vq6MIc/I70ZBTuX5L53jI6tdazyHAbN
        qCCIw0znLs/dl1/oCtbeHkjgltfsFJKoCyax0bk6b5j2QduT2Tln9uSU1wDSAWBODpQ2Am6X2vX1h
        4SK/v2Cw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nA3OF-003qhc-Es; Wed, 19 Jan 2022 05:20:11 +0000
Date:   Tue, 18 Jan 2022 21:20:11 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     David Howells <dhowells@redhat.com>
Cc:     Christoph Hellwig <hch@infradead.org>, linux-cachefs@redhat.com,
        Jeff Layton <jlayton@kernel.org>,
        Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Steve French <smfrench@gmail.com>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Matthew Wilcox <willy@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Omar Sandoval <osandov@osandov.com>,
        JeffleXu <jefflexu@linux.alibaba.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-afs@lists.infradead.org, linux-nfs@vger.kernel.org,
        linux-cifs@vger.kernel.org, ceph-devel@vger.kernel.org,
        v9fs-developer@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 09/11] vfs, fscache: Add an IS_KERNEL_FILE() macro for
 the S_KERNEL_FILE flag
Message-ID: <YeefizLOGt1Qf35o@infradead.org>
References: <YebpktrcUZOlBHkZ@infradead.org>
 <164251396932.3435901.344517748027321142.stgit@warthog.procyon.org.uk>
 <164251409447.3435901.10092442643336534999.stgit@warthog.procyon.org.uk>
 <3613681.1642527614@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3613681.1642527614@warthog.procyon.org.uk>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jan 18, 2022 at 05:40:14PM +0000, David Howells wrote:
> Christoph Hellwig <hch@infradead.org> wrote:
> 
> > On Tue, Jan 18, 2022 at 01:54:54PM +0000, David Howells wrote:
> > > Add an IS_KERNEL_FILE() macro to test the S_KERNEL_FILE inode flag as is
> > > common practice for the other inode flags[1].
> > 
> > Please fix the flag to have a sensible name first, as the naming of the
> > flag and this new helper is utterly wrong as we already discussed.
> 
> And I suggested a new name, which you didn't comment on.

Again, look at the semantics of the flag:  The only thing it does in the
VFS is to prevent a rmdir.  So you might want to name it after that.

Or in fact drop the flag entirely.  We don't have that kind of
protection for other in-kernel file use or important userspace daemons
either.  I can't see why cachefiles is the magic snowflake here that
suddenly needs semantics no one else has.

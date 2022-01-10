Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68CE04892EB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Jan 2022 09:00:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241652AbiAJIAY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 10 Jan 2022 03:00:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241519AbiAJH7O (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 10 Jan 2022 02:59:14 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9A01C025481;
        Sun,  9 Jan 2022 23:53:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ck+GCTXTq6vx0+UGObJZ+hDxsPyCcfaXptvnTMJa0B0=; b=2fXREzZXspdztwjUGN/nEr1V70
        ULFZg+uWcgCbVkT9RJ99GqDgBw03zzhprDIvLyzvZ7qRVO9+vpG3FpKNTtBLHUdI9wLAcco3KVtxU
        FmAawMv8GbYeU0N7j7B/Biz03mtuJx5DEGglJ9/5CKfI7DrqrZ/czk6IuLzylhKySlqk0Z8M9x2B9
        CL1qFxrETDgCNuBKXP/FrfvkiFauss03mL7R/dx00Aq6l+KQYF/bcCTcc/XaFeXO9wNYnLfNlrQgC
        YYkQXrYpcLMG3JuaGDp0ZnslXqFynsyaAfJUGtIboPtq2WUvjyLVSa5+1X7l7Sna31kLM21NjUxyO
        AHqQxnZQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1n6pUW-009jUS-SL; Mon, 10 Jan 2022 07:53:20 +0000
Date:   Sun, 9 Jan 2022 23:53:20 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Amir Goldstein <amir73il@gmail.com>,
        David Howells <dhowells@redhat.com>, linux-cachefs@redhat.com,
        Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Steve French <sfrench@samba.org>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Jeff Layton <jlayton@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Omar Sandoval <osandov@osandov.com>,
        JeffleXu <jefflexu@linux.alibaba.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-afs@lists.infradead.org,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        CIFS <linux-cifs@vger.kernel.org>,
        ceph-devel <ceph-devel@vger.kernel.org>,
        v9fs-developer@lists.sourceforge.net,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 38/68] vfs, cachefiles: Mark a backing file in use
 with an inode flag
Message-ID: <Ydvl8Dk8z0mF0KFl@infradead.org>
References: <164021479106.640689.17404516570194656552.stgit@warthog.procyon.org.uk>
 <164021541207.640689.564689725898537127.stgit@warthog.procyon.org.uk>
 <CAOQ4uxjEcvffv=rNXS-r+NLz+=6yk4abRuX_AMq9v-M4nf_PtA@mail.gmail.com>
 <Ydk6jWmFH6TZLPZq@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ydk6jWmFH6TZLPZq@casper.infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Jan 08, 2022 at 07:17:33AM +0000, Matthew Wilcox wrote:
> On Sat, Jan 08, 2022 at 09:08:57AM +0200, Amir Goldstein wrote:
> > > +#define S_KERNEL_FILE  (1 << 17) /* File is in use by the kernel (eg. fs/cachefiles) */
> > 
> > Trying to brand this flag as a generic "in use by kernel" is misleading.
> > Modules other than cachefiles cannot set/clear this flag, because then
> > cachefiles won't know that it is allowed to set/clear the flag.
> 
> Huh?  If some other kernel module sets it, cachefiles will try to set it,
> see it's already set, and fail.  Presumably cachefiles does not go round
> randomly "unusing" files that it has not previously started using.
> 
> I mean, yes, obviously, it's a kernel module, it can set and clear
> whatever flags it likes on any inode in the system, but conceptually,
> it's an advisory whole-file lock.

So let's name it that way.  We have plenty of files in kernel use using
filp_open and this flag very obviously means something else.

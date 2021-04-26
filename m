Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6673936BA53
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Apr 2021 21:52:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241682AbhDZTxd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Apr 2021 15:53:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241606AbhDZTxd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Apr 2021 15:53:33 -0400
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47A03C061574;
        Mon, 26 Apr 2021 12:52:51 -0700 (PDT)
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lb7Hl-008TqF-IE; Mon, 26 Apr 2021 19:52:49 +0000
Date:   Mon, 26 Apr 2021 19:52:49 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     David Howells <dhowells@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org,
        Dave Wysochanski <dwysocha@redhat.com>,
        Marc Dionne <marc.dionne@auristor.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Christoph Hellwig <hch@lst.de>, linux-mm@kvack.org,
        linux-cachefs@redhat.com, linux-afs@lists.infradead.org,
        linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org,
        ceph-devel@vger.kernel.org, v9fs-developer@lists.sourceforge.net,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Steve French <sfrench@samba.org>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Jeff Layton <jlayton@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 01/31] iov_iter: Add ITER_XARRAY
Message-ID: <YIcaESRqrBRqD/EQ@zeniv-ca.linux.org.uk>
References: <YIcMVCkp4xswHolw@zeniv-ca.linux.org.uk>
 <161918446704.3145707.14418606303992174310.stgit@warthog.procyon.org.uk>
 <161918448151.3145707.11541538916600921083.stgit@warthog.procyon.org.uk>
 <3651951.1619465011@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3651951.1619465011@warthog.procyon.org.uk>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Apr 26, 2021 at 08:23:31PM +0100, David Howells wrote:

> I really need to defer this question to Willy, but as I understand it,
> xas_retry() only restarts the current iteration.  Referring to the comment on
> xas_reset():
> 
>  * Resets the error or walk state of the @xas so future walks of the
>  * array will start from the root.  Use this if you have dropped the
>  * xarray lock and want to reuse the xa_state.
> 
> I think that the walk returns to the bottom of the tree and whilst xarray
> presents an interface that appears to be a contiguous array, it's actually a
> tree internally - and 'root' is the root of the tree, not the head of the
> array.
> 
> Basically, I think it throws away its cached iteration state - which might
> have been modified - and rewalks the tree to get back to the same index.

From RTFS(lib/xarray.c) that looks right.  Nevermind the question, then...

Anyway, 

Reviewed-by: Al Viro <viro@zeniv.linux.org.uk>

on the xarray-related bits (this patch + followups)

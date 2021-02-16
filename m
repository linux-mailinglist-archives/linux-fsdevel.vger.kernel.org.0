Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 104CE31C8C3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Feb 2021 11:27:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229944AbhBPK1C (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 16 Feb 2021 05:27:02 -0500
Received: from verein.lst.de ([213.95.11.211]:40732 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229767AbhBPK07 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 16 Feb 2021 05:26:59 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 9AA846736F; Tue, 16 Feb 2021 11:26:14 +0100 (CET)
Date:   Tue, 16 Feb 2021 11:26:14 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     David Howells <dhowells@redhat.com>
Cc:     Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Steve French <sfrench@samba.org>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@lst.de>,
        Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
        linux-cachefs@redhat.com, linux-afs@lists.infradead.org,
        linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org,
        ceph-devel@vger.kernel.org, v9fs-developer@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, Jeff Layton <jlayton@redhat.com>,
        David Wysochanski <dwysocha@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 04/33] vfs: Export rw_verify_area() for use by
 cachefiles
Message-ID: <20210216102614.GA27555@lst.de>
References: <161340385320.1303470.2392622971006879777.stgit@warthog.procyon.org.uk> <161340390150.1303470.509630287091953754.stgit@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <161340390150.1303470.509630287091953754.stgit@warthog.procyon.org.uk>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Feb 15, 2021 at 03:45:01PM +0000, David Howells wrote:
> Export rw_verify_area() for so that cachefiles can use it before issuing
> call_read_iter() and call_write_iter() to effect async DIO operations
> against the cache.  This is analogous to aio_read() and aio_write().

I don't think this is the right thing to do.  Instead of calling
into ->read_iter / ->write_iter directly this should be using helpers.

What prevents you from using vfs_iocb_iter_read and
vfs_iocb_iter_write which seem the right level of abstraction for this?

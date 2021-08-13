Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 211F43EB107
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Aug 2021 09:02:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239143AbhHMHDC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 13 Aug 2021 03:03:02 -0400
Received: from verein.lst.de ([213.95.11.211]:46539 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238877AbhHMHDB (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 13 Aug 2021 03:03:01 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 8132E6736F; Fri, 13 Aug 2021 09:02:31 +0200 (CEST)
Date:   Fri, 13 Aug 2021 09:02:31 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     David Howells <dhowells@redhat.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Christoph Hellwig <hch@lst.de>,
        Trond Myklebust <trond.myklebust@primarydata.com>,
        linux-nfs@vger.kernel.org, viro@zeniv.linux.org.uk,
        jlayton@kernel.org, sfrench@samba.org,
        torvalds@linux-foundation.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v2 1/5] nfs: Fix write to swapfile failure due to
 generic_write_checks()
Message-ID: <20210813070231.GA26339@lst.de>
References: <162879971699.3306668.8977537647318498651.stgit@warthog.procyon.org.uk> <162879972678.3306668.10709543333474121000.stgit@warthog.procyon.org.uk> <YRXicziD5Jy74PZj@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YRXicziD5Jy74PZj@casper.infradead.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Aug 13, 2021 at 04:09:39AM +0100, Matthew Wilcox wrote:
> On Thu, Aug 12, 2021 at 09:22:06PM +0100, David Howells wrote:
> > Trying to use a swapfile on NFS results in every DIO write failing with
> > ETXTBSY because generic_write_checks(), as called by nfs_direct_write()
> > from nfs_direct_IO(), forbids writes to swapfiles.
> 
> Why does nfs_direct_write() call generic_write_checks()?
> 
> ie call generic_write_checks() earlier, and only swap would bypass them.

Yes, something like that is a good idea probably.  Additionally I'd like
to move to a separate of for swap I/O ASAP given that NFS only
implemens ->direct_IO for swap.

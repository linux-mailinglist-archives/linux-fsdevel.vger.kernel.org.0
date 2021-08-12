Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC3063EAB86
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Aug 2021 22:13:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237007AbhHLUOS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 Aug 2021 16:14:18 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:59516 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S236799AbhHLUOP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 Aug 2021 16:14:15 -0400
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 17CKD6OY003112
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 12 Aug 2021 16:13:07 -0400
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id C8CEF15C37C1; Thu, 12 Aug 2021 16:13:06 -0400 (EDT)
Date:   Thu, 12 Aug 2021 16:13:06 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     "Darrick J. Wong" <djwong@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        David Howells <dhowells@redhat.com>,
        trond.myklebust@primarydata.com, darrick.wong@oracle.com,
        jlayton@kernel.org, sfrench@samba.org,
        torvalds@linux-foundation.org, linux-nfs@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] mm: Make swap_readpage() for SWP_FS_OPS use
 ->direct_IO() not ->readpage()
Message-ID: <YRWA0tJy457V4/HO@mit.edu>
References: <20210812122104.GB18532@lst.de>
 <162876946134.3068428.15475611190876694695.stgit@warthog.procyon.org.uk>
 <162876947840.3068428.12591293664586646085.stgit@warthog.procyon.org.uk>
 <3085432.1628773025@warthog.procyon.org.uk>
 <YRVAvKPn8SjczqrD@casper.infradead.org>
 <20210812170233.GA4987@lst.de>
 <20210812174818.GK3601405@magnolia>
 <YRVlDZRIm8zTjDIh@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YRVlDZRIm8zTjDIh@casper.infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Aug 12, 2021 at 07:14:37PM +0100, Matthew Wilcox wrote:
> 
> Well ... this would actually allow the filesystem to break COWs and
> allocate new blocks for holes.  Maybe you don't want to be doing that
> in a low-memory situation though ;-)

I'm not sure the benefits are worth the costs.  You'd have to handle
ENOSPC errors, and it would require some kind of metadata journal
transaction, which could potentially block for any number of reasons
(not just due to memory allocations, but because you're waiting for a
journal commit to complete).  As you say, doing that in a low-memory
situation seems to be unneeded complexity.

					- Ted

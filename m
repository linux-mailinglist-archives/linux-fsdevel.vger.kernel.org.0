Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24B8B3EA487
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Aug 2021 14:21:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236417AbhHLMVf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 Aug 2021 08:21:35 -0400
Received: from verein.lst.de ([213.95.11.211]:44085 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237369AbhHLMVf (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 Aug 2021 08:21:35 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id D840468AFE; Thu, 12 Aug 2021 14:21:04 +0200 (CEST)
Date:   Thu, 12 Aug 2021 14:21:04 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     David Howells <dhowells@redhat.com>
Cc:     willy@infradead.org, trond.myklebust@primarydata.com,
        darrick.wong@oracle.com, hch@lst.de, jlayton@kernel.org,
        sfrench@samba.org, torvalds@linux-foundation.org,
        linux-nfs@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] mm: Make swap_readpage() for SWP_FS_OPS use
 ->direct_IO() not ->readpage()
Message-ID: <20210812122104.GB18532@lst.de>
References: <162876946134.3068428.15475611190876694695.stgit@warthog.procyon.org.uk> <162876947840.3068428.12591293664586646085.stgit@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <162876947840.3068428.12591293664586646085.stgit@warthog.procyon.org.uk>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Aug 12, 2021 at 12:57:58PM +0100, David Howells wrote:
> Make swap_readpage(), when accessing a swap file (SWP_FS_OPS) use
> the ->direct_IO() method on the filesystem rather then ->readpage().

->direct_IO is just a helper for ->read_iter and ->write_iter, so please
don't call it directly.  It actually is slowly on its way out, with at
at least all of the iomap implementations not using it, as well as various
other file systems.

> +	ki = kzalloc(sizeof(*ki), GFP_KERNEL);
> +	if (!ki)
> +		return -ENOMEM;

for the synchronous case we could avoid this allocation and just use
arguments on stack.

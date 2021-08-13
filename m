Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38FF93EB13E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Aug 2021 09:14:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239362AbhHMHOq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 13 Aug 2021 03:14:46 -0400
Received: from verein.lst.de ([213.95.11.211]:46644 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239291AbhHMHOp (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 13 Aug 2021 03:14:45 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 5E36368B05; Fri, 13 Aug 2021 09:14:17 +0200 (CEST)
Date:   Fri, 13 Aug 2021 09:14:15 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     David Howells <dhowells@redhat.com>
Cc:     willy@infradead.org, trond.myklebust@primarydata.com,
        darrick.wong@oracle.com, hch@lst.de, viro@zeniv.linux.org.uk,
        jlayton@kernel.org, sfrench@samba.org,
        torvalds@linux-foundation.org, linux-nfs@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v2 5/5] mm: Remove swap BIO paths and only use DIO
 paths [BROKEN]
Message-ID: <20210813071415.GD26339@lst.de>
References: <162879971699.3306668.8977537647318498651.stgit@warthog.procyon.org.uk> <162879976139.3306668.12495248062404308890.stgit@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <162879976139.3306668.12495248062404308890.stgit@warthog.procyon.org.uk>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Aug 12, 2021 at 09:22:41PM +0100, David Howells wrote:
> [!] NOTE: This doesn't work and might damage your disk's contents.
> 
> Delete the BIO-generating swap read/write paths and always use
> ->direct_IO().  This puts the mapping layer in the filesystem.
> 
> This doesn't work - probably due to ki_pos being set to
> page_file_offset(page) which then gets remapped.

Also because most common block file systems do not actually implement
a ->direct_IO that does anything (noop_direct_IO).

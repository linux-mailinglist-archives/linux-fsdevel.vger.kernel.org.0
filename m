Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DD7C3EA465
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Aug 2021 14:19:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236073AbhHLMTD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 Aug 2021 08:19:03 -0400
Received: from verein.lst.de ([213.95.11.211]:44062 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234942AbhHLMTC (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 Aug 2021 08:19:02 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 3603667373; Thu, 12 Aug 2021 14:18:34 +0200 (CEST)
Date:   Thu, 12 Aug 2021 14:18:34 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     David Howells <dhowells@redhat.com>
Cc:     willy@infradead.org, trond.myklebust@primarydata.com,
        darrick.wong@oracle.com, hch@lst.de, jlayton@kernel.org,
        sfrench@samba.org, torvalds@linux-foundation.org,
        linux-nfs@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] mm: Fix NFS swapfiles and use DIO read for
 swapfiles
Message-ID: <20210812121834.GA18532@lst.de>
References: <162876946134.3068428.15475611190876694695.stgit@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <162876946134.3068428.15475611190876694695.stgit@warthog.procyon.org.uk>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Aug 12, 2021 at 12:57:41PM +0100, David Howells wrote:
> 
> Hi Willy, Trond,
> 
> Here's a change to make reads from the swapfile use async DIO rather than
> readpage(), as requested by Willy.
> 
> Whilst trying to make this work, I found that NFS's support for swapfiles
> seems to have been non-functional since Aug 2019 (I think), so the first
> patch fixes that.  Question is: do we actually *want* to keep this
> functionality, given that it seems that no one's tested it with an upstream
> kernel in the last couple of years?

Independ of the NFS use using the direct I/O code for swap seems like
the right thing to do in generlal.  e.g. for XFS a lookup in the extent
btree will be more efficient than the weird swap extent map.

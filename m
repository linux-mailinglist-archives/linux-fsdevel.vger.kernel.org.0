Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 717D73F9B88
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Aug 2021 17:16:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245407AbhH0PRg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 27 Aug 2021 11:17:36 -0400
Received: from verein.lst.de ([213.95.11.211]:34270 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234186AbhH0PRf (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 27 Aug 2021 11:17:35 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 8260267373; Fri, 27 Aug 2021 17:16:44 +0200 (CEST)
Date:   Fri, 27 Aug 2021 17:16:44 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     NeilBrown <neilb@suse.de>
Cc:     "Darrick J. Wong" <darrick.wong@oracle.com>,
        Christoph Hellwig <hch@lst.de>,
        David Howells <dhowells@redhat.com>,
        torvalds@linux-foundation.org, trond.myklebust@primarydata.com,
        linux-nfs@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Don't block writes to swap-files with ETXTBSY.
Message-ID: <20210827151644.GB19199@lst.de>
References: <162993585927.7591.10174443410031404560@noble.neil.brown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <162993585927.7591.10174443410031404560@noble.neil.brown.name>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Aug 26, 2021 at 09:57:39AM +1000, NeilBrown wrote:
> 
> Commit dc617f29dbe5 ("vfs: don't allow writes to swap files")
> broke swap-over-NFS as it introduced an ETXTBSY error when NFS tries to
> swap-out using ->direct_IO().
> 
> There is no sound justification for this error.  File permissions are
> sufficient to stop non-root users from writing to a swap file, and root
> must always be cautious not to do anything dangerous.
> 
> These checks effectively provide a mandatory write lock on swap, and
> mandatory locks are not supported in Linux.
> 
> So remove all the checks that return ETXTBSY when attempts are made to
> write to swap.

Swap files are not just any files and do need a mandatory write lock
as they are part of the kernel VM and writing to them will mess up
the kernel badly.  David Howells actually has sent various patches
to fix swap over NFS in the last weeks.

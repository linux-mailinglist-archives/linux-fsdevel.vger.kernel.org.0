Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73D733B769F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Jun 2021 18:47:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234109AbhF2Qtr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 29 Jun 2021 12:49:47 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:55363 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S232441AbhF2Qtq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 29 Jun 2021 12:49:46 -0400
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 15TGlBrx004287
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 29 Jun 2021 12:47:12 -0400
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id B5CB515C3CD8; Tue, 29 Jun 2021 12:47:11 -0400 (EDT)
Date:   Tue, 29 Jun 2021 12:47:11 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     "J. Bruce Fields" <bfields@fieldses.org>
Cc:     linux-fsdevel@vger.kernel.org, dai.ngo@oracle.com,
        linux-nfs@vger.kernel.org
Subject: Re: automatic freeing of space on ENOSPC
Message-ID: <YNtOjxXo4XJivFdw@mit.edu>
References: <20210628194908.GB6776@fieldses.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210628194908.GB6776@fieldses.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jun 28, 2021 at 03:49:08PM -0400, J. Bruce Fields wrote:
> Is there anything analogous to a "shrinker", but for disk space?  So,
> some hook that a filesystem could call to say "I'm running out of space,
> could you please free something?", before giving up and returning
> ENOSPC?

In addition to the issues raised by Neil, Amir, Dave, and others, the
other challenge with the file system calling a "please try to free
something before I return ENOSPC" is that this would almost certainly
require blocking a system call while some userspace daemon tried to
free up some space --- or were you thinking that the nfsd kernel code
would be tracking all of the silly-rename files so it could release
space really quickly on demand?

Even if this is only a kernel callback, I'd be concerned about
potential locking hierarchy problems if we are calling out from block
allocation subsystem to nfsd, only to have nfsd call back in to
request unlinking a silly-renamed file.

So the suggestion that we not wait until we're down to 0 blocks free,
but when we hit some threshold (say, free space dips below N minutes
worth of worst or average case block allocations), trigger code which
deletes silly-renamed files, is probably the best way to go.  In which
case, a callback is not what is needed; and if N is large enough, this
could done via a pure user-space-only solution.

		      	     		     - Ted

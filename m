Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FF043B77F3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Jun 2021 20:38:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235226AbhF2Skx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 29 Jun 2021 14:40:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234971AbhF2Skx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 29 Jun 2021 14:40:53 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2E57C061760;
        Tue, 29 Jun 2021 11:38:25 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id 4526E478E; Tue, 29 Jun 2021 14:38:25 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 4526E478E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1624991905;
        bh=EyZ2HYvK9VUNhmzuIN4NcjPgGfykSAb4lP52n2zbWOc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HVwP+wFQ+JvAnabKnpTOPdjdSFKE8ylRg4cQnqyTgQvo9yH6L7jDLUxw+nnBaxWpH
         6K+ODc0ci6SP5/qfIZYwsbmhHFt/KcuYpSADHY6Vo+RZ9yPzgZh+gS5vOsuM+Un78A
         QGehk+ho5NoOqnPVAENfs6tE8Z8GoDL4uYX6bBXk=
Date:   Tue, 29 Jun 2021 14:38:25 -0400
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     linux-fsdevel@vger.kernel.org, dai.ngo@oracle.com,
        linux-nfs@vger.kernel.org
Subject: Re: automatic freeing of space on ENOSPC
Message-ID: <20210629183825.GD1926@fieldses.org>
References: <20210628194908.GB6776@fieldses.org>
 <YNtOjxXo4XJivFdw@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YNtOjxXo4XJivFdw@mit.edu>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jun 29, 2021 at 12:47:11PM -0400, Theodore Ts'o wrote:
> On Mon, Jun 28, 2021 at 03:49:08PM -0400, J. Bruce Fields wrote:
> > Is there anything analogous to a "shrinker", but for disk space?  So,
> > some hook that a filesystem could call to say "I'm running out of space,
> > could you please free something?", before giving up and returning
> > ENOSPC?
> 
> In addition to the issues raised by Neil, Amir, Dave, and others, the
> other challenge with the file system calling a "please try to free
> something before I return ENOSPC" is that this would almost certainly
> require blocking a system call while some userspace daemon tried to
> free up some space --- or were you thinking that the nfsd kernel code
> would be tracking all of the silly-rename files so it could release
> space really quickly on demand?

Something like that, yep.

> Even if this is only a kernel callback, I'd be concerned about
> potential locking hierarchy problems if we are calling out from block
> allocation subsystem to nfsd, only to have nfsd call back in to
> request unlinking a silly-renamed file.
> 
> So the suggestion that we not wait until we're down to 0 blocks free,
> but when we hit some threshold (say, free space dips below N minutes
> worth of worst or average case block allocations), trigger code which
> deletes silly-renamed files, is probably the best way to go.  In which
> case, a callback is not what is needed; and if N is large enough, this
> could done via a pure user-space-only solution.

Makes sense, thanks!

--b.

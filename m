Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB1E93F2DAE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Aug 2021 16:09:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240758AbhHTOJp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 20 Aug 2021 10:09:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235032AbhHTOJm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 20 Aug 2021 10:09:42 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6801C061575;
        Fri, 20 Aug 2021 07:09:04 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id 0D0065BAF; Fri, 20 Aug 2021 10:09:03 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 0D0065BAF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1629468543;
        bh=wY8RC3nRl8mw74fg4RiQly9sGS6KY5S4e1kT6ficbDo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uLNQrICJHtuq70LWUUqRVgWozgalJ08WFOOsOZqBRr7hBYe8itNg2uNRHfsX8hV9w
         iqbK/sRw2HXqb1WneQoev11t5SeB+7ucMp6ayp/tLrKmxHPhmbqboCVfkuJrHpOG7M
         yUwi7bYbplF6X0LxX0UaNOAxpOKbsXq8dEkfIV4U=
Date:   Fri, 20 Aug 2021 10:09:03 -0400
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     torvalds@linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, ebiederm@xmission.com,
        david@redhat.com, willy@infradead.org, linux-nfs@vger.kernel.org,
        viro@zeniv.linux.org.uk, linux-doc@vger.kernel.org,
        v9fs-developer@lists.sourceforge.net,
        linux-afs@lists.infradead.org, cluster-devel@redhat.com,
        ocfs2-devel@oss.oracle.com, linux-mm@kvack.org,
        akpm@linux-foundation.org, luto@kernel.org, w@1wt.eu,
        rostedt@goodmis.org
Subject: Re: [PATCH v2 0/2] fs: remove support for mandatory locking
Message-ID: <20210820140903.GA18096@fieldses.org>
References: <20210820135707.171001-1-jlayton@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210820135707.171001-1-jlayton@kernel.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Aug 20, 2021 at 09:57:05AM -0400, Jeff Layton wrote:
> The first patch in this series adds a new warning that should pop on
> kernels have mandatory locking enabled when someone mounts a filesystem
> with -o mand. The second patch removes support for mandatory locking
> altogether.
> 
> What I think we probably want to do is apply the first to v5.14 before
> it ships and allow the new warning to trickle out into stable kernels.
> Then we can merge the second patch in v5.15 to go ahead and remove it.
> 
> Sound like a plan?

Sounds good to me.--b.

> 
> Jeff Layton (2):
>   fs: warn about impending deprecation of mandatory locks
>   fs: remove mandatory file locking support
> 
>  .../filesystems/mandatory-locking.rst         | 188 ------------------
>  fs/9p/vfs_file.c                              |  12 --
>  fs/Kconfig                                    |  10 -
>  fs/afs/flock.c                                |   4 -
>  fs/ceph/locks.c                               |   3 -
>  fs/gfs2/file.c                                |   3 -
>  fs/locks.c                                    | 116 +----------
>  fs/namei.c                                    |   4 +-
>  fs/namespace.c                                |  31 +--
>  fs/nfs/file.c                                 |   4 -
>  fs/nfsd/nfs4state.c                           |  13 --
>  fs/nfsd/vfs.c                                 |  15 --
>  fs/ocfs2/locks.c                              |   4 -
>  fs/open.c                                     |   8 +-
>  fs/read_write.c                               |   7 -
>  fs/remap_range.c                              |  10 -
>  include/linux/fs.h                            |  84 --------
>  mm/mmap.c                                     |   6 -
>  mm/nommu.c                                    |   3 -
>  19 files changed, 20 insertions(+), 505 deletions(-)
>  delete mode 100644 Documentation/filesystems/mandatory-locking.rst
> 
> -- 
> 2.31.1

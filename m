Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B9B43F32E6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Aug 2021 20:15:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236037AbhHTSQ1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 20 Aug 2021 14:16:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:47104 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235950AbhHTSQZ (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 20 Aug 2021 14:16:25 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E56A461056;
        Fri, 20 Aug 2021 18:15:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629483347;
        bh=lEauG8US0wWV105yX+m78yPpsHVn1SxEBoQkVuK3wLQ=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=iZ8eL9VRJ2N0qnU/+VFbVX5aGbw4kSBmXpVBDdGtuWN2mZZshQv3Sb6XkSinqPdSC
         R5RyHVBJpS81J3HejjC36ETWbCFSCGZ0D5WUK6YDB8XgpgWPo63s8BlbXeGRbCRKnt
         GV70SMKuQrvX1zNhZMdl9qhyq1Q+3jFAVMH49sDZrL3YMWU1Q1IxIWMrV1YzPOmaMu
         JB6HA0VU2hf0RC2+nKj9N4D7MveLwtqVI1BcAPje48v763gchaevYK9wjV2GBFR1+G
         gZtxMTvv1RC6qzlHrVFmgvJGAekzzmMg1Kz3BfKshjEKmIWIV9wrDLBOwoXfdzT/Sg
         6GTkKruOhJ+QQ==
Message-ID: <30fdfda30b42b8b836a199b3cbe65d1673f5100f.camel@kernel.org>
Subject: Re: [PATCH v3 0/2] fs: remove support for mandatory locking
From:   Jeff Layton <jlayton@kernel.org>
To:     torvalds@linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     ebiederm@xmission.com, david@redhat.com, willy@infradead.org,
        linux-nfs@vger.kernel.org, viro@zeniv.linux.org.uk,
        linux-doc@vger.kernel.org, v9fs-developer@lists.sourceforge.net,
        linux-afs@lists.infradead.org, cluster-devel@redhat.com,
        ocfs2-devel@oss.oracle.com, linux-mm@kvack.org,
        akpm@linux-foundation.org, luto@kernel.org, bfields@fieldses.org,
        rostedt@goodmis.org
Date:   Fri, 20 Aug 2021 14:15:44 -0400
In-Reply-To: <20210820163919.435135-1-jlayton@kernel.org>
References: <20210820163919.435135-1-jlayton@kernel.org>
Content-Type: text/plain; charset="ISO-8859-15"
User-Agent: Evolution 3.40.4 (3.40.4-1.fc34) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, 2021-08-20 at 12:39 -0400, Jeff Layton wrote:
> v3: slight revision to verbiage, and use pr_warn_once
> 
> The first patch in this series adds a new warning that should pop on
> kernels that have mandatory locking enabled when someone mounts a
> filesystem with -o mand. The second patch removes support for mandatory
> locking altogether.
> 
> What I think we probably want to do is apply the first to v5.14 before
> it ships and allow the new warning to trickle out into stable kernels.
> Then we can merge the second patch in v5.15 to go ahead and remove it.
> 
> Sound like a plan?
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
>  fs/namespace.c                                |  25 +--
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
>  19 files changed, 14 insertions(+), 505 deletions(-)
>  delete mode 100644 Documentation/filesystems/mandatory-locking.rst
> 

I went ahead and pushed this version into the locks-next branch, so we
can give it some soak time before merging.

-- 
Jeff Layton <jlayton@kernel.org>


Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50AA52D8635
	for <lists+linux-fsdevel@lfdr.de>; Sat, 12 Dec 2020 12:22:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437228AbgLLLWU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 12 Dec 2020 06:22:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:57020 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726633AbgLLLWT (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 12 Dec 2020 06:22:19 -0500
Message-ID: <7779e2ed97080009d894f3442bfad31972494542.camel@kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607772098;
        bh=yFDu5MswmjXa911Cysa//QkZDAZkwzJ9BXKpC+Qq2yg=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=dQaw7qNvEUzy+5fIkuhKb0tYnl1huEbAZsgUOdLuBIXddBT/RJDOYVO+W+zYz8+kS
         5eiMbMH5yQ8Jffl6oGpoTvSaulH8rc7mvUqwgj1Pz0txhZaiz6Vg1W2Nqw0GTBc+fM
         ixVcuI3ZzSIfk4xz1v86KDe4Gz3BojXHL5ibqMT3zLm1s2RqLYKe2Y1Bnxv+z3CikZ
         mCUdebo+EH60pkMYsyHoZ3utmvuwgF8+k0t8n13YdKQpvrlhFkzMWVKvFf4+UXs4oE
         MMV5luK1BXGjDFHqECzKCmi8QnN2CsvezBOQcsMG67UWUYc6udKpnd3Uiw5kgGjAXr
         HxzY3swFnbjuA==
Subject: Re: [PATCH v2 0/3] Check errors on sync for volatile overlayfs
 mounts
From:   Jeff Layton <jlayton@kernel.org>
To:     Sargun Dhillon <sargun@sargun.me>,
        Amir Goldstein <amir73il@gmail.com>,
        Miklos Szeredi <miklos@szeredi.hu>
Cc:     Vivek Goyal <vgoyal@redhat.com>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>
Date:   Sat, 12 Dec 2020 06:21:37 -0500
In-Reply-To: <20201211235002.4195-1-sargun@sargun.me>
References: <20201211235002.4195-1-sargun@sargun.me>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.2 (3.38.2-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, 2020-12-11 at 15:49 -0800, Sargun Dhillon wrote:
> The semantics of errseq and syncfs are such that it is impossible to track
> if any errors have occurred between the time the first error occurred, and
> the user checks for the error (calls syncfs, and subsequently
> errseq_check_and_advance.
> 
> Overlayfs has a volatile feature which short-circuits syncfs. This, in turn
> makes it so that the user can have silent data corruption and not know
> about it. The third patch in the series introduces behaviour that makes it
> so that we can track errors, and bubble up whether the user has put
> themselves in bad situation.
> 
> This required some gymanstics in errseq, and adding a wrapper around it
> called "errseq_counter" (errseq + counter). The data structure uses an
> atomic to track overflow errors. This approach, rather than moving to an
> atomic64 / u64 is so we can avoid bloating every person that subscribes to
> an errseq, and only add the subscriber behaviour to those who care (at the
> expense of space.
> 
> The datastructure is write-optimized, and rightfully so, as the users
> of the counter feature are just overlayfs, and it's called in fsync
> checking, which is a rather seldom operation, and not really on
> any hotpaths.
> 
> [1]: https://lore.kernel.org/linux-fsdevel/20201202092720.41522-1-sargun@sargun.me/
> 
> Sargun Dhillon (3):
>   errseq: Add errseq_counter to allow for all errors to be observed
>   errseq: Add mechanism to snapshot errseq_counter and check snapshot
>   overlay: Implement volatile-specific fsync error behaviour
> 
>  Documentation/filesystems/overlayfs.rst |   8 ++
>  fs/buffer.c                             |   2 +-
>  fs/overlayfs/file.c                     |   5 +-
>  fs/overlayfs/overlayfs.h                |   1 +
>  fs/overlayfs/ovl_entry.h                |   3 +
>  fs/overlayfs/readdir.c                  |   5 +-
>  fs/overlayfs/super.c                    |  26 +++--
>  fs/overlayfs/util.c                     |  28 +++++
>  fs/super.c                              |   1 +
>  fs/sync.c                               |   3 +-
>  include/linux/errseq.h                  |  18 ++++
>  include/linux/fs.h                      |   6 +-
>  include/linux/pagemap.h                 |   2 +-
>  lib/errseq.c                            | 129 ++++++++++++++++++++----
>  14 files changed, 202 insertions(+), 35 deletions(-)
> 

It would hel if you could more clearly lay out the semantics you're
looking for. If I understand correctly:

You basically want to be able to sample the sb->s_wb_err of the upper
layer at mount time and then always return an error if any new errors
were recorded since that point.

If that's correct, then I'm not sure I get need for all of this extra
counter machinery. Why not just sample it at mount time without
recording it as 0 if the seen flag isn't set. Then just do an
errseq_check against the upper superblock (without advancing) in the
overlayfs ->sync_fs routine and just errseq_set that error into the
overlayfs superblock? The syncfs syscall wrapper should then always
report the latest error.

Or (even better) rework all of the sync_fs/syncfs mess to be more sane,
so that overlayfs has more control over what errors get returned to
userland. ISTM that the main problem you have is that the
errseq_check_and_advance is done in the syscall wrapper, and that's
probably not appropriate for your use-case.

-- 
Jeff Layton <jlayton@kernel.org>


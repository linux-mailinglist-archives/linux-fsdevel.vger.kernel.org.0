Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0BDB4132B09
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Jan 2020 17:23:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728365AbgAGQX2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 Jan 2020 11:23:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:36352 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727994AbgAGQX2 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 Jan 2020 11:23:28 -0500
Received: from mail-vs1-f49.google.com (mail-vs1-f49.google.com [209.85.217.49])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4A6372146E;
        Tue,  7 Jan 2020 16:23:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578414207;
        bh=y7nyHtre1LVdk95yztadAkAzthxIXXf14CuMTJ61HGs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=AdqHTgr9/+5YfzEvhvZhdfa21HP+uYxYsTFXS4bonTvyw/IkO9e/C+fwOups+6UG8
         wYIMhDOve5TkopEUuNJkHCuCMro+Z404UQ7UsqGTzQfqyIyCfiO9R14CnYti8hjAD2
         VuuuM5MZloEqTdWrVrHYLyTFvX2J35EP1Q1F0/yk=
Received: by mail-vs1-f49.google.com with SMTP id g23so34257502vsr.7;
        Tue, 07 Jan 2020 08:23:27 -0800 (PST)
X-Gm-Message-State: APjAAAWK+57bPm3mePm6fOqc1KUaNfSi9F8r7L0phoIIqQQyIZOHSoNT
        8P+QY9KO9CIau3ZYKqUjrrH12xy3rwiLrztCMVQ=
X-Google-Smtp-Source: APXvYqyiwyikq1PqEkeZKmAg7xDHHQPQzHxwAbHs7MSq4VO4o/FxN0C0BcFRx0UnAmSOenPMK90qFwJtl+8LLe/QgVk=
X-Received: by 2002:a05:6102:535:: with SMTP id m21mr55052092vsa.95.1578414206426;
 Tue, 07 Jan 2020 08:23:26 -0800 (PST)
MIME-Version: 1.0
References: <20191216182656.15624-1-fdmanana@kernel.org> <20191216182656.15624-2-fdmanana@kernel.org>
In-Reply-To: <20191216182656.15624-2-fdmanana@kernel.org>
From:   Filipe Manana <fdmanana@kernel.org>
Date:   Tue, 7 Jan 2020 16:23:15 +0000
X-Gmail-Original-Message-ID: <CAL3q7H5+CMRkJ9yAa2AeB0aKtA=b_yW2g9JSQwCOhOtLNrH1iQ@mail.gmail.com>
Message-ID: <CAL3q7H5+CMRkJ9yAa2AeB0aKtA=b_yW2g9JSQwCOhOtLNrH1iQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] fs: allow deduplication of eof block into the end of
 the destination file
To:     linux-fsdevel <linux-fsdevel@vger.kernel.org>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>,
        xfs <linux-xfs@vger.kernel.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Filipe Manana <fdmanana@suse.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Dec 16, 2019 at 6:28 PM <fdmanana@kernel.org> wrote:
>
> From: Filipe Manana <fdmanana@suse.com>
>
> We always round down, to a multiple of the filesystem's block size, the
> length to deduplicate at generic_remap_check_len().  However this is only
> needed if an attempt to deduplicate the last block into the middle of the
> destination file is requested, since that leads into a corruption if the
> length of the source file is not block size aligned.  When an attempt to
> deduplicate the last block into the end of the destination file is
> requested, we should allow it because it is safe to do it - there's no
> stale data exposure and we are prepared to compare the data ranges for
> a length not aligned to the block (or page) size - in fact we even do
> the data compare before adjusting the deduplication length.
>
> After btrfs was updated to use the generic helpers from VFS (by commit
> 34a28e3d77535e ("Btrfs: use generic_remap_file_range_prep() for cloning
> and deduplication")) we started to have user reports of deduplication
> not reflinking the last block anymore, and whence users getting lower
> deduplication scores.  The main use case is deduplication of entire
> files that have a size not aligned to the block size of the filesystem.
>
> We already allow cloning the last block to the end (and beyond) of the
> destination file, so allow for deduplication as well.
>
> Link: https://lore.kernel.org/linux-btrfs/2019-1576167349.500456@svIo.N5dq.dFFD/
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Darrick, Al, any feedback?

Thanks.

> ---
>  fs/read_write.c | 10 ++++------
>  1 file changed, 4 insertions(+), 6 deletions(-)
>
> diff --git a/fs/read_write.c b/fs/read_write.c
> index 5bbf587f5bc1..7458fccc59e1 100644
> --- a/fs/read_write.c
> +++ b/fs/read_write.c
> @@ -1777,10 +1777,9 @@ static int remap_verify_area(struct file *file, loff_t pos, loff_t len,
>   * else.  Assume that the offsets have already been checked for block
>   * alignment.
>   *
> - * For deduplication we always scale down to the previous block because we
> - * can't meaningfully compare post-EOF contents.
> - *
> - * For clone we only link a partial EOF block above the destination file's EOF.
> + * For clone we only link a partial EOF block above or at the destination file's
> + * EOF.  For deduplication we accept a partial EOF block only if it ends at the
> + * destination file's EOF (can not link it into the middle of a file).
>   *
>   * Shorten the request if possible.
>   */
> @@ -1796,8 +1795,7 @@ static int generic_remap_check_len(struct inode *inode_in,
>         if ((*len & blkmask) == 0)
>                 return 0;
>
> -       if ((remap_flags & REMAP_FILE_DEDUP) ||
> -           pos_out + *len < i_size_read(inode_out))
> +       if (pos_out + *len < i_size_read(inode_out))
>                 new_len &= ~blkmask;
>
>         if (new_len == *len)
> --
> 2.11.0
>

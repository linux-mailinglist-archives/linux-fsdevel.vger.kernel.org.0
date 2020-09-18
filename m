Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F5A026F769
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Sep 2020 09:52:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726841AbgIRHwb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 18 Sep 2020 03:52:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726711AbgIRHwa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 18 Sep 2020 03:52:30 -0400
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C62B1C06174A;
        Fri, 18 Sep 2020 00:52:30 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id o8so4592549otl.4;
        Fri, 18 Sep 2020 00:52:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=S2eNoZYJBbRdDL+9Rn83UkdafaYmPioHl03HTHvdQG0=;
        b=fO0ZculQNiNNXJ+GZ4XJ+Izjls+aHWlLkPNgFCkYk+T4lrNk7okIWBhRv8aPZ7YnRU
         yWmecYPz7JpgdFFby2UJOV+G1HX6r9Va6HM9/nOoRxu0+aSY1ZDJzT+KIV+hLlMKIIN1
         w6WxP82H9u6RYNFrh5Fzt8r9ozMRUZ1ZZCjaHtyEuwLsoI3zyWl+hUh3asYRUOdT0pVn
         isRpZ3GYvfejEndmnWnnrq7WiQ2WxtgBuhwKo/HbP5kcDNEkirlFKW8syexCFtoRZSqM
         cxQmDcjHLdDdOgUqnk2PF4PFUuECcVinfxvfalrwXNRmNpMP+qmYjTgCkNI/+ZEZu6PZ
         6ZDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=S2eNoZYJBbRdDL+9Rn83UkdafaYmPioHl03HTHvdQG0=;
        b=sFEd2QlV1XYA3Q7MAgDgX1ZOlLTfl3UteH6UH2eeB1NVpuVukXne3fK/C116UchLaO
         8vMBAVxKTA9qhjjOGGHBzDeU/oBmoGf5f8qGmVcTjHqJTDxC6Wckm9PUiinoHbnVfoyV
         d+NohSbEozlcloanb76UXsyg2gPhWPu5YO810V2lbkHQT+yEjXtfuqUWX/3VyM8/vcKi
         uhrha8bnjBDrj8R24DDJ92bg4MYEL2O+2otRqtBc0tN8HEbSIJpxBy0pIgsKF/1Wu3bD
         kof70WeGGvBhR/tj5pbAQtNnNw78jwvigawhDQWqLhQk/m2a0a9J+wW33/8Bw7+UyhZs
         rq8w==
X-Gm-Message-State: AOAM533ekjx57n85xXc8rlaisTwPDbbT92+IJP+VJX65I7UPxpysNePA
        m6/86ipLs5bBBLT3HXjifnzUNvRFH2GrQDYHkrs=
X-Google-Smtp-Source: ABdhPJyuZa4aaOHbJ4KcquqeOW73BYpH7VvGe3VxVVFyF5vKx1u35OqPT0RQOJtMKbnV/Z8+HMnZE6+poiphw4Tj38I=
X-Received: by 2002:a9d:67c3:: with SMTP id c3mr23645453otn.9.1600415549857;
 Fri, 18 Sep 2020 00:52:29 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1600401668.git.riteshh@linux.ibm.com> <88e795d8a4d5cd22165c7ebe857ba91d68d8813e.1600401668.git.riteshh@linux.ibm.com>
In-Reply-To: <88e795d8a4d5cd22165c7ebe857ba91d68d8813e.1600401668.git.riteshh@linux.ibm.com>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Fri, 18 Sep 2020 09:52:18 +0200
Message-ID: <CA+icZUXvhDR2TFEemfGyt=twxHBcu0_9b0H1j5cwGPG5kGA+TA@mail.gmail.com>
Subject: Re: [PATCHv3 1/1] ext4: Optimize file overwrites
To:     Ritesh Harjani <riteshh@linux.ibm.com>
Cc:     linux-ext4@vger.kernel.org, tytso@mit.edu, jack@suse.cz,
        dan.j.williams@intel.com, anju@linux.vnet.ibm.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Sep 18, 2020 at 7:09 AM Ritesh Harjani <riteshh@linux.ibm.com> wrote:
>
> In case if the file already has underlying blocks/extents allocated
> then we don't need to start a journal txn and can directly return
> the underlying mapping. Currently ext4_iomap_begin() is used by
> both DAX & DIO path. We can check if the write request is an
> overwrite & then directly return the mapping information.
>
> This could give a significant perf boost for multi-threaded writes
> specially random overwrites.
> On PPC64 VM with simulated pmem(DAX) device, ~10x perf improvement
> could be seen in random writes (overwrite). Also bcoz this optimizes
> away the spinlock contention during jbd2 slab cache allocation
> (jbd2_journal_handle). On x86 VM, ~2x perf improvement was observed.
>
> Reported-by: Dan Williams <dan.j.williams@intel.com>
> Suggested-by: Jan Kara <jack@suse.cz>
> Signed-off-by: Ritesh Harjani <riteshh@linux.ibm.com>

I have applied your patch on top of recent Linus Git and boot-tested on x86-64.

Here I have LTP installed.
If you have a LTP filesystem test-/use-case you know for testing,
please let me know.

Yes, I have seen the FIO config in the cover-letter.
Maybe you have a different FIO config - 16G AFAIK is too big here.

Feel free to add...

Tested-by: Sedat Dilek <sedat.dilek@gmail.com> # Compile and boot on
x86-64 Debian/unstable

Thanks.

- Sedat -

> ---
>  fs/ext4/inode.c | 18 +++++++++++++++---
>  1 file changed, 15 insertions(+), 3 deletions(-)
>
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index 10dd470876b3..6eae17758ece 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -3437,14 +3437,26 @@ static int ext4_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
>         map.m_len = min_t(loff_t, (offset + length - 1) >> blkbits,
>                           EXT4_MAX_LOGICAL_BLOCK) - map.m_lblk + 1;
>
> -       if (flags & IOMAP_WRITE)
> +       if (flags & IOMAP_WRITE) {
> +               /*
> +                * We check here if the blocks are already allocated, then we
> +                * don't need to start a journal txn and we can directly return
> +                * the mapping information. This could boost performance
> +                * especially in multi-threaded overwrite requests.
> +                */
> +               if (offset + length <= i_size_read(inode)) {
> +                       ret = ext4_map_blocks(NULL, inode, &map, 0);
> +                       if (ret > 0 && (map.m_flags & EXT4_MAP_MAPPED))
> +                               goto out;
> +               }
>                 ret = ext4_iomap_alloc(inode, &map, flags);
> -       else
> +       } else {
>                 ret = ext4_map_blocks(NULL, inode, &map, 0);
> +       }
>
>         if (ret < 0)
>                 return ret;
> -
> +out:
>         ext4_set_iomap(inode, iomap, &map, offset, length);
>
>         return 0;
> --
> 2.26.2
>

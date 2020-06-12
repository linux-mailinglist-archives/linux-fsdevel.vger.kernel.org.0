Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1B5A1F7500
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Jun 2020 10:03:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726262AbgFLIDb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 12 Jun 2020 04:03:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726264AbgFLIDa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 12 Jun 2020 04:03:30 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A20BC08C5C1
        for <linux-fsdevel@vger.kernel.org>; Fri, 12 Jun 2020 01:03:30 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id h188so4980949lfd.7
        for <linux-fsdevel@vger.kernel.org>; Fri, 12 Jun 2020 01:03:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3VJQVK8KxEZy44A4q0tI85Y8fEnNPI/2JQ7v3xMmBdA=;
        b=Phor9LJD4hvBOvwad87WNWqqp0hILeYKJ8e6xKfBOlVoVuoaJBtCV3EWim+kVu+DMT
         1pTJVUQh5d85NtzeHC8zKeBl5LRIq82OGtM57AkkUdRLygalcl5AX+L0mvohY7caYLPb
         ON9JDRsvZdwmwybesxn8hqIPRnyUy8S1bNQTxCb6wDESGhv+dUrs6ieH2wguK07V32MB
         6xcXBa/WvxX+Ey441zavBogz/1/1XFo83o00wGkla61pS27azCvGS8bO55HP47JU40OB
         RNtza0dSWBb+6yICFj13KFhbG7kFQQCbAbhXuQOJcGV3SOuY3zsvYhqbItHcrVVu62yr
         bQXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3VJQVK8KxEZy44A4q0tI85Y8fEnNPI/2JQ7v3xMmBdA=;
        b=e7/3EQFbN7JTWBALE412fH+VXzHiKYNkawly5ilR72XbqF2s3BspQFMU0y659EF+X/
         LTI1G7pToxG0/wjvP+QubTuvkdN6WvffnoXgar6EQe7shCT4GRLyk22gSnQEYn7GO2WN
         uzv6EMTbRS+1gXX2q5v3gh7EkUK+IbkzB6nQjyhju8Axr1WFGD17Ph+gzG1CGMuZKIcR
         o1h1RtndwzK+y4Sk9rnYid+FrUGT3QqBe4t9ow2byfnKSr6BwY0on9Dn3Gy3YzCJNRp7
         dF95VDENEqUKWsH3ICUDFUDo1SbWTJMRiVPY5c1IDAg1VbVMwy1nnPatnbqNEm1MahvQ
         FD1g==
X-Gm-Message-State: AOAM5338ooghQkC//e1NU0pslZowICupzZgDuh4/zkuwd7kjoFJoKVzn
        SJs0th1p2lvP0M1IKbFNCg602+n3JpGojz72CPotlQ==
X-Google-Smtp-Source: ABdhPJxyqEDXun+8F1M5CDL8LieYo7VIDySJCOCesOCZUAm0HKt0iUqs0KihTjxO6p+FPRMFbOTXb3OmLm6//ADH9YQ=
X-Received: by 2002:a19:356:: with SMTP id 83mr6268265lfd.179.1591949008970;
 Fri, 12 Jun 2020 01:03:28 -0700 (PDT)
MIME-Version: 1.0
References: <20200611075033.1248-1-jack@suse.cz> <20200611081203.18161-2-jack@suse.cz>
In-Reply-To: <20200611081203.18161-2-jack@suse.cz>
From:   Martijn Coenen <maco@android.com>
Date:   Fri, 12 Jun 2020 10:03:18 +0200
Message-ID: <CAB0TPYFOtDdS8BRk6aMhhB_5nxw4N7unqHCjgLFNh=YZC3vywA@mail.gmail.com>
Subject: Re: [PATCH 2/4] writeback: Avoid skipping inode writeback
To:     Jan Kara <jack@suse.cz>
Cc:     linux-fsdevel@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Jan,

On Thu, Jun 11, 2020 at 10:12 AM Jan Kara <jack@suse.cz> wrote:
> Reported-by: Martijn Coenen <maco@android.com>
> Fixes: 0ae45f63d4ef ("vfs: add support for a lazytime mount option")
> CC: stable@vger.kernel.org
> Signed-off-by: Jan Kara <jack@suse.cz>

Thanks again for the fix. We've been running this (well, v1) for over
2 weeks across at least ~1000 Android devices with different kernel
versions, and I can confirm we haven't run into the issue this intends
to fix, or any other issues for that matter. The patch LGTM as well.

Reviewed-by: Martijn Coenen <maco@android.com>
Tested-by: Martijn Coenen <maco@android.com>

> ---
>  fs/fs-writeback.c  | 17 ++++++++++++-----
>  include/linux/fs.h |  8 ++++++--
>  2 files changed, 18 insertions(+), 7 deletions(-)
>
> diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
> index ff0b18331590..f470c10641c5 100644
> --- a/fs/fs-writeback.c
> +++ b/fs/fs-writeback.c
> @@ -146,6 +146,7 @@ static void inode_io_list_del_locked(struct inode *inode,
>         assert_spin_locked(&wb->list_lock);
>         assert_spin_locked(&inode->i_lock);
>
> +       inode->i_state &= ~I_SYNC_QUEUED;
>         list_del_init(&inode->i_io_list);
>         wb_io_lists_depopulated(wb);
>  }
> @@ -1187,6 +1188,7 @@ static void redirty_tail_locked(struct inode *inode, struct bdi_writeback *wb)
>                         inode->dirtied_when = jiffies;
>         }
>         inode_io_list_move_locked(inode, wb, &wb->b_dirty);
> +       inode->i_state &= ~I_SYNC_QUEUED;
>  }
>
>  static void redirty_tail(struct inode *inode, struct bdi_writeback *wb)
> @@ -1262,8 +1264,11 @@ static int move_expired_inodes(struct list_head *delaying_queue,
>                         break;
>                 list_move(&inode->i_io_list, &tmp);
>                 moved++;
> +               spin_lock(&inode->i_lock);
>                 if (flags & EXPIRE_DIRTY_ATIME)
> -                       set_bit(__I_DIRTY_TIME_EXPIRED, &inode->i_state);
> +                       inode->i_state |= I_DIRTY_TIME_EXPIRED;
> +               inode->i_state |= I_SYNC_QUEUED;
> +               spin_unlock(&inode->i_lock);
>                 if (sb_is_blkdev_sb(inode->i_sb))
>                         continue;
>                 if (sb && sb != inode->i_sb)
> @@ -1438,6 +1443,7 @@ static void requeue_inode(struct inode *inode, struct bdi_writeback *wb,
>         } else if (inode->i_state & I_DIRTY_TIME) {
>                 inode->dirtied_when = jiffies;
>                 inode_io_list_move_locked(inode, wb, &wb->b_dirty_time);
> +               inode->i_state &= ~I_SYNC_QUEUED;
>         } else {
>                 /* The inode is clean. Remove from writeback lists. */
>                 inode_io_list_del_locked(inode, wb);
> @@ -2301,11 +2307,12 @@ void __mark_inode_dirty(struct inode *inode, int flags)
>                 inode->i_state |= flags;
>
>                 /*
> -                * If the inode is being synced, just update its dirty state.
> -                * The unlocker will place the inode on the appropriate
> -                * superblock list, based upon its state.
> +                * If the inode is queued for writeback by flush worker, just
> +                * update its dirty state. Once the flush worker is done with
> +                * the inode it will place it on the appropriate superblock
> +                * list, based upon its state.
>                  */
> -               if (inode->i_state & I_SYNC)
> +               if (inode->i_state & I_SYNC_QUEUED)
>                         goto out_unlock_inode;
>
>                 /*
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index 19ef6c88c152..48556efcdcf0 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -2157,6 +2157,10 @@ static inline void kiocb_clone(struct kiocb *kiocb, struct kiocb *kiocb_src,
>   *
>   * I_DONTCACHE         Evict inode as soon as it is not used anymore.
>   *
> + * I_SYNC_QUEUED       Inode is queued in b_io or b_more_io writeback lists.
> + *                     Used to detect that mark_inode_dirty() should not move
> + *                     inode between dirty lists.
> + *
>   * Q: What is the difference between I_WILL_FREE and I_FREEING?
>   */
>  #define I_DIRTY_SYNC           (1 << 0)
> @@ -2174,12 +2178,12 @@ static inline void kiocb_clone(struct kiocb *kiocb, struct kiocb *kiocb_src,
>  #define I_DIO_WAKEUP           (1 << __I_DIO_WAKEUP)
>  #define I_LINKABLE             (1 << 10)
>  #define I_DIRTY_TIME           (1 << 11)
> -#define __I_DIRTY_TIME_EXPIRED 12
> -#define I_DIRTY_TIME_EXPIRED   (1 << __I_DIRTY_TIME_EXPIRED)
> +#define I_DIRTY_TIME_EXPIRED   (1 << 12)
>  #define I_WB_SWITCH            (1 << 13)
>  #define I_OVL_INUSE            (1 << 14)
>  #define I_CREATING             (1 << 15)
>  #define I_DONTCACHE            (1 << 16)
> +#define I_SYNC_QUEUED          (1 << 17)
>
>  #define I_DIRTY_INODE (I_DIRTY_SYNC | I_DIRTY_DATASYNC)
>  #define I_DIRTY (I_DIRTY_INODE | I_DIRTY_PAGES)
> --
> 2.16.4
>

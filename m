Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E92941F74C6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Jun 2020 09:45:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726387AbgFLHpu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 12 Jun 2020 03:45:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726292AbgFLHpu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 12 Jun 2020 03:45:50 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14156C03E96F
        for <linux-fsdevel@vger.kernel.org>; Fri, 12 Jun 2020 00:45:50 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id i27so9946780ljb.12
        for <linux-fsdevel@vger.kernel.org>; Fri, 12 Jun 2020 00:45:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nyCQkb3coEYpxQmt5tM2FiCmMFgNt2JWNkIxHlpOi+A=;
        b=L/tBeQGG5Ikhhd/90oK5fCg6Za3+ahIEVNhOqYBco9ubxDinFJVZ2mNT2n24+De6vy
         xy1c3rIps2MXPjDl99QiY3ZkWrE/eYQ0mSL0B9pro+Yxmxz+AnNukE+nMQB5m7UGjXOv
         pDQkh/aP+mscMir/3Fbqs9awbA03zJaOhbU5vatfDRzBNo7KG/vOvAq0bdBvhpt/jmo+
         dCJ+y4Q+XDMzlbnPgb567z4xAg0aGA3EFLpOFehnWfPwcAof2LOUh264k4qyAAAyL3dG
         Bhb+QQB1l7xjQeT2c8/2ueO/PlkfNvra8+Fpy5NOZeWYgwUZ/fXMySjR5P73k7tSk4bh
         k+Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nyCQkb3coEYpxQmt5tM2FiCmMFgNt2JWNkIxHlpOi+A=;
        b=ZpKQX3RrfvSYSIwihSSllPQAizIqJjR3EONY3W1dd3r2V7U+KQ9fgJ5vUdek05peRY
         65H3Ul0bgpiD1bbxeErq9iogTQ2kP8JLbCeGJwtnNgvwYVQE6dYFOMMBOOSStMUh6yYs
         oSzYolT7XY4uHLikxrllmMbhyds8x0Rf46Lc4Y8+qRJgyEIdrXsEmTWGVliohPT6Ibg9
         Yn1f81+khOR0JzQBD0CwfyWHG8TVKGCSpXMjjjvUZsMSiwsjncrWJO0s4qEJkS19fvbO
         0pVQMVa2786PWji71832gF125oAbYSyG3wjIf37VWM5fMfG/o3KvscwsAWBZS3lsVt1R
         eJ0g==
X-Gm-Message-State: AOAM533fnt08wPItL6cI/HM8qWYTeolep7w+obrLh6bZA2aAjgNLZGNe
        h2+9167OXoG/hHZD3mRZSnbTRzq63SOXn0fDO9UTHrmeRrw=
X-Google-Smtp-Source: ABdhPJxcY7VDPHflQhGG4wkr3hw2KdrKkLqt65pvLjgSAqP7v5as/zixzwgS8raA51jxgjJj+TUow7WZPEMCpbPWBfk=
X-Received: by 2002:a05:651c:c1:: with SMTP id 1mr5860799ljr.292.1591947948353;
 Fri, 12 Jun 2020 00:45:48 -0700 (PDT)
MIME-Version: 1.0
References: <20200611075033.1248-1-jack@suse.cz> <20200611081203.18161-1-jack@suse.cz>
In-Reply-To: <20200611081203.18161-1-jack@suse.cz>
From:   Martijn Coenen <maco@android.com>
Date:   Fri, 12 Jun 2020 09:45:37 +0200
Message-ID: <CAB0TPYGUGTtt=Nd9vEKFBLNNsyM=npZs0ipVUgCNv7ZftYh-UQ@mail.gmail.com>
Subject: Re: [PATCH 1/4] writeback: Protect inode->i_io_list with inode->i_lock
To:     Jan Kara <jack@suse.cz>
Cc:     linux-fsdevel@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Jan,

On Thu, Jun 11, 2020 at 10:12 AM Jan Kara <jack@suse.cz> wrote:
>
> Currently, operations on inode->i_io_list are protected by
> wb->list_lock. In the following patches we'll need to maintain
> consistency between inode->i_state and inode->i_io_list so change the
> code so that inode->i_lock protects also all inode's i_io_list handling.
>
> Signed-off-by: Jan Kara <jack@suse.cz>

LGTM.

Reviewed-by: Martijn Coenen <maco@android.com>

> ---
>  fs/fs-writeback.c | 22 +++++++++++++++++-----
>  1 file changed, 17 insertions(+), 5 deletions(-)
>
> diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
> index a605c3dddabc..ff0b18331590 100644
> --- a/fs/fs-writeback.c
> +++ b/fs/fs-writeback.c
> @@ -144,6 +144,7 @@ static void inode_io_list_del_locked(struct inode *inode,
>                                      struct bdi_writeback *wb)
>  {
>         assert_spin_locked(&wb->list_lock);
> +       assert_spin_locked(&inode->i_lock);
>
>         list_del_init(&inode->i_io_list);
>         wb_io_lists_depopulated(wb);
> @@ -1122,7 +1123,9 @@ void inode_io_list_del(struct inode *inode)
>         struct bdi_writeback *wb;
>
>         wb = inode_to_wb_and_lock_list(inode);
> +       spin_lock(&inode->i_lock);
>         inode_io_list_del_locked(inode, wb);
> +       spin_unlock(&inode->i_lock);
>         spin_unlock(&wb->list_lock);
>  }
>  EXPORT_SYMBOL(inode_io_list_del);
> @@ -1172,8 +1175,10 @@ void sb_clear_inode_writeback(struct inode *inode)
>   * the case then the inode must have been redirtied while it was being written
>   * out and we don't reset its dirtied_when.
>   */
> -static void redirty_tail(struct inode *inode, struct bdi_writeback *wb)
> +static void redirty_tail_locked(struct inode *inode, struct bdi_writeback *wb)
>  {
> +       assert_spin_locked(&inode->i_lock);
> +
>         if (!list_empty(&wb->b_dirty)) {
>                 struct inode *tail;
>
> @@ -1184,6 +1189,13 @@ static void redirty_tail(struct inode *inode, struct bdi_writeback *wb)
>         inode_io_list_move_locked(inode, wb, &wb->b_dirty);
>  }
>
> +static void redirty_tail(struct inode *inode, struct bdi_writeback *wb)
> +{
> +       spin_lock(&inode->i_lock);
> +       redirty_tail_locked(inode, wb);
> +       spin_unlock(&inode->i_lock);
> +}
> +
>  /*
>   * requeue inode for re-scanning after bdi->b_io list is exhausted.
>   */
> @@ -1394,7 +1406,7 @@ static void requeue_inode(struct inode *inode, struct bdi_writeback *wb,
>                  * writeback is not making progress due to locked
>                  * buffers. Skip this inode for now.
>                  */
> -               redirty_tail(inode, wb);
> +               redirty_tail_locked(inode, wb);
>                 return;
>         }
>
> @@ -1414,7 +1426,7 @@ static void requeue_inode(struct inode *inode, struct bdi_writeback *wb,
>                          * retrying writeback of the dirty page/inode
>                          * that cannot be performed immediately.
>                          */
> -                       redirty_tail(inode, wb);
> +                       redirty_tail_locked(inode, wb);
>                 }
>         } else if (inode->i_state & I_DIRTY) {
>                 /*
> @@ -1422,7 +1434,7 @@ static void requeue_inode(struct inode *inode, struct bdi_writeback *wb,
>                  * such as delayed allocation during submission or metadata
>                  * updates after data IO completion.
>                  */
> -               redirty_tail(inode, wb);
> +               redirty_tail_locked(inode, wb);
>         } else if (inode->i_state & I_DIRTY_TIME) {
>                 inode->dirtied_when = jiffies;
>                 inode_io_list_move_locked(inode, wb, &wb->b_dirty_time);
> @@ -1669,8 +1681,8 @@ static long writeback_sb_inodes(struct super_block *sb,
>                  */
>                 spin_lock(&inode->i_lock);
>                 if (inode->i_state & (I_NEW | I_FREEING | I_WILL_FREE)) {
> +                       redirty_tail_locked(inode, wb);
>                         spin_unlock(&inode->i_lock);
> -                       redirty_tail(inode, wb);
>                         continue;
>                 }
>                 if ((inode->i_state & I_SYNC) && wbc.sync_mode != WB_SYNC_ALL) {
> --
> 2.16.4
>

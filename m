Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 682DD51F927
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 May 2022 12:00:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235435AbiEIJxW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 May 2022 05:53:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239527AbiEIJqb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 May 2022 05:46:31 -0400
Received: from mail-vk1-xa34.google.com (mail-vk1-xa34.google.com [IPv6:2607:f8b0:4864:20::a34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46E9421E03;
        Mon,  9 May 2022 02:42:33 -0700 (PDT)
Received: by mail-vk1-xa34.google.com with SMTP id d132so6642170vke.0;
        Mon, 09 May 2022 02:42:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2zdJr1D4+tOVKDyCMf5btV9F16hwBzLta+dcq/GYO3o=;
        b=d8vnpsUJmFdQOs7ehYldCku6+vzQBhhGng4fPhDRY+TfRBQy12C2DVVQaCjn8T6waC
         JOoeiQ/HdzWNEVpzLD7bzNnBOkLosvKImmK3Z9P6Kgf9U6YOWtkINzab8q3UZ0V+7sM1
         pTLWnnePfezNoV35397EyOs353V1ANpZiqGZS/1kNREI5llWBziHCssLZIozoAcqtcpl
         WUPTjbNdYZiV1nA8N/C+PA5zScP/vDvXs2bn/PlzLSlJ+zeocl9RMk/TjYRb+cuskof2
         Nc6Hd5XxRsAyF89YPU0BZjT5bX9pwNTRlgLhTzpfGX04E8+9iBlIDbmGmnAdQm5eeE22
         Ugcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2zdJr1D4+tOVKDyCMf5btV9F16hwBzLta+dcq/GYO3o=;
        b=O2uAOvPsBzBtdxDtKv0OLrO+QURTF3Hx0TaMrX97F6r8o92rnzNkCWt5rvrc/a0ZtP
         gOd/bJzxz1nhywYAczlc63aLOmu+ne0w60znJeUBTy3wIGgT745itO53AeLcVJh67Mhj
         quWcw7x9t5Jpv7xsqRBgx2GUFG36D2GXs8Y9f+TC4UNqfRL+CK5VZ6/QRjLtHFtrLGna
         Vh/vnrGNwHUuG4z8Ms2d4DxFACV3FwaH0AlF4AMQwhKQPS2hECtJsjJ0bQdqYDmiBeH9
         bXmLN3zx4W3wW98lPNEdtw9E/ZHg2gso+qgmq7wPiFQY5NyRnI5zIV2UUNbh7u+EK/5q
         jVJQ==
X-Gm-Message-State: AOAM531P3wMb6Y8ZGeakHrtXQVhyUJsQTCYT4YTmcJfsvfC43+V33jBp
        wd+2AdyEBS8Yc9iaBIvkkZ6AD8rJfPx5rZdzL+4=
X-Google-Smtp-Source: ABdhPJy8bywY0kXJ/mx1I4wIiEKnh1GL1ArVlZ2TTvmpxfraOvBQWZWf3Mp07c0n2sMkpQwh9ja2zkO6/cSgfrmMBNg=
X-Received: by 2002:a1f:ae08:0:b0:352:6e83:e963 with SMTP id
 x8-20020a1fae08000000b003526e83e963mr7568288vke.0.1652089291126; Mon, 09 May
 2022 02:41:31 -0700 (PDT)
MIME-Version: 1.0
References: <20220505134731.5295-1-jing.xia@unisoc.com> <Yni42sWLMFITtfmz@infradead.org>
In-Reply-To: <Yni42sWLMFITtfmz@infradead.org>
From:   jing xia <jing.xia.mail@gmail.com>
Date:   Mon, 9 May 2022 17:41:20 +0800
Message-ID: <CAN=25QM6Q1gQWzS27pBEpYokTpKXDamOVTrku40yy=YYGt=tTA@mail.gmail.com>
Subject: Re: [PATCH] writeback: Avoid skipping inode writeback
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Jing Xia <jing.xia@unisoc.com>, viro@zeniv.linux.org.uk,
        Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, May 9, 2022 at 2:46 PM Christoph Hellwig <hch@infradead.org> wrote:
>
> On Thu, May 05, 2022 at 09:47:31PM +0800, Jing Xia wrote:
> >       if (!(inode->i_state & I_DIRTY_ALL))
> >               inode_cgwb_move_to_attached(inode, wb);
> > +     else if (!(inode->i_state & I_SYNC_QUEUED) && (inode->i_state & I_DIRTY))
>
> Please turn this into
>
>         else if ((inode->i_state & I_DIRTY) &&
>                  !(inode->i_state & I_SYNC_QUEUED))
>
> to keep it a little more readable.
>
> Otherwise looks good:
>
> Reviewed-by: Christoph Hellwig <hch@lst.de>

Ok. And thanks for the review.

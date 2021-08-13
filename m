Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AA623EB179
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Aug 2021 09:28:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239419AbhHMH3F (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 13 Aug 2021 03:29:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238816AbhHMH3F (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 13 Aug 2021 03:29:05 -0400
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C471C061756;
        Fri, 13 Aug 2021 00:28:39 -0700 (PDT)
Received: by mail-il1-x132.google.com with SMTP id h18so9851477ilc.5;
        Fri, 13 Aug 2021 00:28:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+zdEzeUkOiPUy+9bCWdpo6nFSqKb8zoXRDJ+beTsy+8=;
        b=rbJ1FwB0AFxhocix583OME/FSGZJX0waV6+R7jclzI+567zJ3EsXbGjJJUPfquY079
         X/AErOYEhOLg0fWnCcgq0ubLHBuHu+Gb+fE4DNMSNAcmxxVEYmKQeGZ7ikUlE491WR2F
         H4wFOK8mWOPy0SiYtIFmb/NZmaXrmIZs/+UIcK8sxaIgU8bEb4tLH8BMcR5dp631DV2z
         lfBWMz8LU5p1hGuEIP9XFBVWMQlpLqECVlkKBDf0vgu6mJMB66BY+ks/EqaLkVo1Iw8+
         rwBjJZfNxvpLgLgdekVfsCaIROk7i1HKpNTX8o3YK2A5lua9xfTkRKhgHTtL/kAy/3A8
         AasQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+zdEzeUkOiPUy+9bCWdpo6nFSqKb8zoXRDJ+beTsy+8=;
        b=FlkZjQFGLI5DOJHYhsatWZb/0nGQwVjije+Oyc53TSyrEmyFzQIGFzPf542SWDPai7
         MRoQq7dUAb/3InaYGGMnfj7tvFXrLS7MpxAuMfhCcdCgw8c/ZXi9tMydebRnXwkj6yzo
         YsMi9raTVYFkDPzSjdZJupcdmdykgv4vE6cW1qYISFo9Q62fYOUpN+h1a1QBrTSyzTh6
         9GsEErclXt5uKZ8Rg1LvMjuIN5slyUb2jqoxsAXvKWt0dtZ0dKuEsUy1qNZN8/rtID2D
         k+yen2tlZM3I0FLYdNM1goiT9ArscvCHDAg8vrE0tqhoV2Ro07XsshKRIRs6C0ELtNVF
         Cqcg==
X-Gm-Message-State: AOAM5328FtZDvdgcHlJ0V2I4lh8HwwEWy68xYvEOWCfjCe5XkSp3sj9J
        B/5LXbM70LrK/6u9eBic8uzANjC0fGQFPtuU5yI=
X-Google-Smtp-Source: ABdhPJyK+cd1IF1AqpBpVRNANZdcnXPB54sDUY2VDLRjgyQXP+kALWC1+cR2AzTFYZjWBdbwarhbodvyW80Y4hmPigA=
X-Received: by 2002:a05:6e02:1c02:: with SMTP id l2mr894353ilh.9.1628839718740;
 Fri, 13 Aug 2021 00:28:38 -0700 (PDT)
MIME-Version: 1.0
References: <20210812214010.3197279-1-krisman@collabora.com> <20210812214010.3197279-5-krisman@collabora.com>
In-Reply-To: <20210812214010.3197279-5-krisman@collabora.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Fri, 13 Aug 2021 10:28:27 +0300
Message-ID: <CAOQ4uxh0WNxsuwtfv_iDCaZbmJEDB700D5_v==ffm2-WAg_V7w@mail.gmail.com>
Subject: Re: [PATCH v6 04/21] fsnotify: Reserve mark flag bits for backends
To:     Gabriel Krisman Bertazi <krisman@collabora.com>
Cc:     Jan Kara <jack@suse.com>, Linux API <linux-api@vger.kernel.org>,
        Ext4 <linux-ext4@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Khazhismel Kumykov <khazhy@google.com>,
        David Howells <dhowells@redhat.com>,
        Dave Chinner <david@fromorbit.com>,
        Theodore Tso <tytso@mit.edu>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Matthew Bobrowski <repnop@google.com>, kernel@collabora.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Aug 13, 2021 at 12:40 AM Gabriel Krisman Bertazi
<krisman@collabora.com> wrote:
>
> Split out the final bits of struct fsnotify_mark->flags for use by a
> backend.
>
> Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
>
> Changes since v1:
>   - turn consts into defines (jan)
> ---
>  include/linux/fsnotify_backend.h | 18 +++++++++++++++---
>  1 file changed, 15 insertions(+), 3 deletions(-)
>
> diff --git a/include/linux/fsnotify_backend.h b/include/linux/fsnotify_backend.h
> index 1ce66748a2d2..ae1bd9f06808 100644
> --- a/include/linux/fsnotify_backend.h
> +++ b/include/linux/fsnotify_backend.h
> @@ -363,6 +363,20 @@ struct fsnotify_mark_connector {
>         struct hlist_head list;
>  };
>
> +enum fsnotify_mark_bits {
> +       FSN_MARK_FL_BIT_IGNORED_SURV_MODIFY,
> +       FSN_MARK_FL_BIT_ALIVE,
> +       FSN_MARK_FL_BIT_ATTACHED,
> +       FSN_MARK_PRIVATE_FLAGS,
> +};
> +
> +#define FSNOTIFY_MARK_FLAG_IGNORED_SURV_MODIFY \
> +       (1 << FSN_MARK_FL_BIT_IGNORED_SURV_MODIFY)
> +#define FSNOTIFY_MARK_FLAG_ALIVE \
> +       (1 << FSN_MARK_FL_BIT_ALIVE)
> +#define FSNOTIFY_MARK_FLAG_ATTACHED \
> +       (1 << FSN_MARK_FL_BIT_ATTACHED)
> +
>  /*
>   * A mark is simply an object attached to an in core inode which allows an
>   * fsnotify listener to indicate they are either no longer interested in events
> @@ -398,9 +412,7 @@ struct fsnotify_mark {
>         struct fsnotify_mark_connector *connector;
>         /* Events types to ignore [mark->lock, group->mark_mutex] */
>         __u32 ignored_mask;
> -#define FSNOTIFY_MARK_FLAG_IGNORED_SURV_MODIFY 0x01
> -#define FSNOTIFY_MARK_FLAG_ALIVE               0x02
> -#define FSNOTIFY_MARK_FLAG_ATTACHED            0x04
> +       /* Upper bits [31:PRIVATE_FLAGS] are reserved for backend usage */

I don't understand what [31:PRIVATE_FLAGS] means

Otherwise:

Reviewed-by: Amir Goldstein <amir73il@gmail.com>

Thanks,
Amir.

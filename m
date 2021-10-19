Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62B8F432D48
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Oct 2021 07:34:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233218AbhJSFhG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Oct 2021 01:37:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbhJSFhF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Oct 2021 01:37:05 -0400
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79817C06161C;
        Mon, 18 Oct 2021 22:34:53 -0700 (PDT)
Received: by mail-io1-xd34.google.com with SMTP id z69so15856352iof.9;
        Mon, 18 Oct 2021 22:34:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZaruljHe7kDR6dP+QS54XPWAlkN8SFW2qWKy+H3YQEw=;
        b=os9Ab4GJHujvQJO7/jacPvhQUobs6+64FPp4pACq91J7nQ2NZlHrRDLwDU1vfKvGUN
         laXmLIg3f5nOVSQFSd78jQFLvX7YfWSLKhwcipeemY5zWy4UZvhIjHRUJxFhw+AgW0DQ
         H7nNCSEpHRPDfiTlHfbPPCqg7+TTcWZxx7Jid+J8guq3qrukv/6tHsdKy/C//jyRboQK
         q/K2Rn/OluHw2tziZjeYi6R70zhJ4x0lmyPm2zqG0xWTKu7mNoZlJGB5razbRA2+n0h0
         hZ2zXpcf6jMoWdcK8rW3HE/bJn1axswvggFXfTxO9lx9iQ6LqpyzhfmfY/aOf8p3aBJ/
         fgFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZaruljHe7kDR6dP+QS54XPWAlkN8SFW2qWKy+H3YQEw=;
        b=uAh+/IV8CPcKpnDSWhDZqF6G5DgqnLbQcgc3T5oCo+FMTq1BKMzdYlfg2Ns89bhxOe
         lGOVMX2GWzXLJcOx2txRoHOlJ+Bp3iCShNFXW/BC0rlmeiHoxK/N7/1g741jUwUpR9kQ
         KL+Q0DHFjzZK6A1xCZDrffU/KtoLxH+LkirFmKVjlQcBEr8pnamBsz7HGxFO748sTwT1
         GR6QTxP8ugCepm2n2iwVRe6GVEDcDvizfPa4Nx7d8Vb2fVzf2htSik8SJTJILfNb6zwP
         osOYeS9Uw9+WIL54f9uUe//LKbz0OIRasSymnBrz2INGT3J8+0t/DQJfQIJxH4dfkUgc
         tglQ==
X-Gm-Message-State: AOAM5323z4S4kvB/QLPeS51vboZWcaQpae72AfPVqsT2ByflmQU4tNAk
        8JPzaQbEQFyKietSi5jnutWMJgrY6lgBhzD9tGmzj4feAFk=
X-Google-Smtp-Source: ABdhPJwny0uw8JY7rG5rh9CKT5QBoFNNuaspDh/YxiyTNTUdY+raBwlA89VMR1Ma4F5VPdZVLjrK3K0Cx4mNqzt6rz8=
X-Received: by 2002:a6b:b5d8:: with SMTP id e207mr17065356iof.52.1634621692844;
 Mon, 18 Oct 2021 22:34:52 -0700 (PDT)
MIME-Version: 1.0
References: <20211019000015.1666608-1-krisman@collabora.com> <20211019000015.1666608-12-krisman@collabora.com>
In-Reply-To: <20211019000015.1666608-12-krisman@collabora.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Tue, 19 Oct 2021 08:34:41 +0300
Message-ID: <CAOQ4uxhyW1O6tEKsEvnyV9ovmM=On0KWoe9Oq-HZou7MdR0GaA@mail.gmail.com>
Subject: Re: [PATCH v8 11/32] fsnotify: Protect fsnotify_handle_inode_event
 from no-inode events
To:     Gabriel Krisman Bertazi <krisman@collabora.com>
Cc:     Jan Kara <jack@suse.com>, "Darrick J. Wong" <djwong@kernel.org>,
        Theodore Tso <tytso@mit.edu>,
        Dave Chinner <david@fromorbit.com>,
        David Howells <dhowells@redhat.com>,
        Khazhismel Kumykov <khazhy@google.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Ext4 <linux-ext4@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>, kernel@collabora.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Oct 19, 2021 at 3:01 AM Gabriel Krisman Bertazi
<krisman@collabora.com> wrote:
>
> FAN_FS_ERROR allows events without inodes - i.e. for file system-wide
> errors.  Even though fsnotify_handle_inode_event is not currently used
> by fanotify, this patch protects this path to handle this new case.
>
> Suggested-by: Amir Goldstein <amir73il@gmail.com>
> Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
> ---
>  fs/notify/fsnotify.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/fs/notify/fsnotify.c b/fs/notify/fsnotify.c
> index fde3a1115a17..47f931fb571c 100644
> --- a/fs/notify/fsnotify.c
> +++ b/fs/notify/fsnotify.c
> @@ -252,6 +252,9 @@ static int fsnotify_handle_inode_event(struct fsnotify_group *group,
>         if (WARN_ON_ONCE(!ops->handle_inode_event))
>                 return 0;
>
> +       if (!inode)
> +               return 0;
> +

Sigh.. the plot thickens.
There are three in-tree backends that implement the ->handle_inode_event()
interface.

inotify and dnotify can take NULL inode and the above will make the CREATE
events on kernfs vanish, so we cannot do that.
Sorry for not noticing this earlier when I asked for this change.

nfsd_file_fsnotify_handle_event() can most certainly not take NULL inode,
but nfsd does not watch for CREATE events.

I think what we need to do is (Jan please correct me if you think otherwise):
1. Document the handle_inode_event() interface that either inode or dir
    must be non-NULL
2. WARN_ON_ONCE(!inode && !dir) instead of just (!inode) above
3. Add WARN_ON_ONCE(!inode) before trace_nfsd_file_fsnotify_handle_event()
    in nfsd_file_fsnotify_handle_event()

Apologies, Gabriel, for having to cleanup our mess ;-)

Thanks,
Amir.

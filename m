Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C2457424F2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Jun 2023 13:28:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232262AbjF2L2N convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 29 Jun 2023 07:28:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231140AbjF2L2M (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 29 Jun 2023 07:28:12 -0400
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BF8330EF;
        Thu, 29 Jun 2023 04:28:09 -0700 (PDT)
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-977e0fbd742so66995666b.2;
        Thu, 29 Jun 2023 04:28:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688038088; x=1690630088;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Nv99uSk5VMguk36mE9uSZcbsJ4nGO6yF7a9CoYdW47k=;
        b=JNehWTgi5cs0d92waTgpLsYfFxhTncchRCPu9QvhInrhGhitO84/dMC7rBYvCP9UYr
         eaMXWoAltbn+0T/u1nV51Ej43kIaGrfOsf1tNrWvoLyAW7sLrnL2/Sxn6dBtKHllbasd
         g0j1joGxQxlReAvZgaeo634HkaE+wTdRTAToGMhi4KLHosWRGH9TKFerOFMwsDizbHff
         M3OOjYEW+fm9ER9F2HmEAwFfLK2ue5pEWG0PaqWmaBJ8dBKByK7VcboDFemmhxgPnFas
         gFQZV4mpFvNz/5sOS8WLqsa+gnaXqPqvkLFFBhhNArR3YnVqvJQ5XEltAD5TNlX8YRAK
         RKLQ==
X-Gm-Message-State: AC+VfDwua2lmIzZGOwbHzvVisYlLL6KsEmH+Z1b/x0r66Tmgh/qwnJ7F
        6kxYAfFnRyNRPEPp5upUA1/b3D2ZFYrqHQ==
X-Google-Smtp-Source: ACHHUZ5zURE3OfviIV42MUpEYuLjsqPnLT3VLhjXtiHRKTl+TdiTILXgTMZyc7rqkb+bvhNUWPtQFA==
X-Received: by 2002:a17:907:5c8:b0:974:6de:8a5e with SMTP id wg8-20020a17090705c800b0097406de8a5emr33361536ejb.40.1688038087694;
        Thu, 29 Jun 2023 04:28:07 -0700 (PDT)
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com. [209.85.208.43])
        by smtp.gmail.com with ESMTPSA id s17-20020a170906bc5100b009920a690cd9sm3196855ejv.59.2023.06.29.04.28.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Jun 2023 04:28:07 -0700 (PDT)
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-51d9865b848so712734a12.1;
        Thu, 29 Jun 2023 04:28:07 -0700 (PDT)
X-Received: by 2002:a17:907:3687:b0:982:501a:62be with SMTP id
 bi7-20020a170907368700b00982501a62bemr30795382ejc.39.1688038087368; Thu, 29
 Jun 2023 04:28:07 -0700 (PDT)
MIME-Version: 1.0
References: <3526895.1687960024@warthog.procyon.org.uk>
In-Reply-To: <3526895.1687960024@warthog.procyon.org.uk>
From:   Marc Dionne <marc.dionne@auristor.com>
Date:   Thu, 29 Jun 2023 08:27:56 -0300
X-Gmail-Original-Message-ID: <CAB9dFdtvDuOGD5wyWMtqtgPv85QHgxvCqYac3pLi3JiAnvCSLg@mail.gmail.com>
Message-ID: <CAB9dFdtvDuOGD5wyWMtqtgPv85QHgxvCqYac3pLi3JiAnvCSLg@mail.gmail.com>
Subject: Re: [PATCH] afs: Fix accidental truncation when storing data
To:     David Howells <dhowells@redhat.com>
Cc:     linux-afs@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jun 28, 2023 at 10:47 AM David Howells <dhowells@redhat.com> wrote:
>
>
> When an AFS FS.StoreData RPC call is made, amongst other things it is given
> the resultant file size to be.  On the server, this is processed by
> truncating the file to new size and then writing the data.
>
> Now, kafs has a lock (vnode->io_lock) that serves to serialise operations
> against a specific vnode (ie. inode), but the parameters for the op are set
> before the lock is taken.  This allows two writebacks (say sync and kswapd)
> to race - and if writes are ongoing the writeback for a later write could
> occur before the writeback for an earlier one if the latter gets
> interrupted.
>
> Note that afs_writepages() cannot take i_mutex and only takes a shared lock
> on vnode->validate_lock.
>
> Also note that the server does the truncation and the write inside a lock,
> so there's no problem at that end.
>
> Fix this by moving the calculation for the proposed new i_size inside the
> vnode->io_lock.  Also reset the iterator (which we might have read from)
> and update the mtime setting there.
>
> Fixes: bd80d8a80e12 ("afs: Use ITER_XARRAY for writing")
> Reported-by: Marc Dionne <marc.dionne@auristor.com>
> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: linux-afs@lists.infradead.org
> cc: linux-fsdevel@vger.kernel.org
> ---
>  fs/afs/write.c |    8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/fs/afs/write.c b/fs/afs/write.c
> index 8750b99c3f56..c1f4391ccd7c 100644
> --- a/fs/afs/write.c
> +++ b/fs/afs/write.c
> @@ -413,17 +413,19 @@ static int afs_store_data(struct afs_vnode *vnode, struct iov_iter *iter, loff_t
>         afs_op_set_vnode(op, 0, vnode);
>         op->file[0].dv_delta = 1;
>         op->file[0].modification = true;
> -       op->store.write_iter = iter;
>         op->store.pos = pos;
>         op->store.size = size;
> -       op->store.i_size = max(pos + size, vnode->netfs.remote_i_size);
>         op->store.laundering = laundering;
> -       op->mtime = vnode->netfs.inode.i_mtime;
>         op->flags |= AFS_OPERATION_UNINTR;
>         op->ops = &afs_store_data_operation;
>
>  try_next_key:
>         afs_begin_vnode_operation(op);
> +
> +       op->store.write_iter = iter;
> +       op->store.i_size = max(pos + size, vnode->netfs.remote_i_size);
> +       op->mtime = vnode->netfs.inode.i_mtime;
> +
>         afs_wait_for_operation(op);
>
>         switch (op->error) {

Looks good to me; the traces where I got a failure indicate that an
extending store occurred in a different thread while waiting for the
io lock, so this looks like the right fix.

Reviewed-by: Marc Dionne <marc.dionne@auristor.com>

Marc

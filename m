Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 664B714A8F2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Jan 2020 18:30:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725907AbgA0RaK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Jan 2020 12:30:10 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:51983 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725828AbgA0RaK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Jan 2020 12:30:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1580146208;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=OyhAWA41X5tProvYLVyTms4GSlY3Oep0pitZbz6qnnM=;
        b=DRfWcrOf1sTnxnK61daxkc22lxoHWuufxg1hbOAPwef05dXrOtVLJVlh7bjlAX5Wu19sWW
        62NCdVVZx1m26ut0Dz49CPybtyaY8ZYLsSYWZi31n89ZrXUWPGIB4K5o1n+Lxvm4nA+9YM
        ajXQD/XUFDMLPuTSAkOQ12a+9tVAlmA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-221-ulzRIJBcN5ym2XhSWfCV4w-1; Mon, 27 Jan 2020 12:30:05 -0500
X-MC-Unique: ulzRIJBcN5ym2XhSWfCV4w-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 914768010DD;
        Mon, 27 Jan 2020 17:30:03 +0000 (UTC)
Received: from pick.fieldses.org (ovpn-124-204.rdu2.redhat.com [10.10.124.204])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 6A1E787056;
        Mon, 27 Jan 2020 17:30:03 +0000 (UTC)
Received: by pick.fieldses.org (Postfix, from userid 2815)
        id 6ED9D1201BA; Mon, 27 Jan 2020 12:30:02 -0500 (EST)
Date:   Mon, 27 Jan 2020 12:30:02 -0500
From:   "J. Bruce Fields" <bfields@redhat.com>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] exportfs: fix handling of rename race in reconnect_one()
Message-ID: <20200127173002.GD115624@pick.fieldses.org>
References: <20200126220800.32397-1-amir73il@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200126220800.32397-1-amir73il@gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Thanks for spotting this!

On Mon, Jan 27, 2020 at 12:08:00AM +0200, Amir Goldstein wrote:
> If a disconnected dentry gets looked up and renamed between the
> call to exportfs_get_name() and lookup_one_len_unlocked(), and if also
> lookup_one_len_unlocked() returns ERR_PTR(-ENOENT), maybe because old
> parent was deleted, we return an error, although dentry may be connected.

A comment that -ENOENT means the parent's gone might be helpful.

But are we sure -ENOENT is what every filesystem returns in the case the
parent was deleted?  And are we sure there aren't other cases that
should be handled similarly to -ENOENT?

> Commit 909e22e05353 ("exportfs: fix 'passing zero to ERR_PTR()'
> warning") changes this behavior from always returning success,
> regardless if dentry was reconnected by somoe other task, to always
> returning a failure.

I wonder whether it might be safest to take the out_reconnected case on
any error, not just -ENOENT.

Looking further back through the history....  Looks like the missing
PTR_ERR(tmp) was just a mistake, introduced in 2013 by my bbf7a8a3562f
"exportfs: move most of reconnect_path to helper function".  So the
historical behavior was always to bail on error.

The old code still did a DCACHE_DISCONNECTED check on the target dentry
in that case and returned success if it found that already cleared, but
we can't necessarily rely on DCACHE_DISCONNECTED being cleared
immediately, so the old code was probably still vulnerable to the race
you saw.

There's not much value in preserving the error as exportfs_decode_fh()
ends up turning everything into ENOMEM or ESTALE for some reason.

Hm.--b.

> Change the lookup error handling to match that of exportfs_get_name()
> error handling and return success after getting -ENOENT and verifying
> that some other task has connected the dentry for us.
> 
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: J. Bruce Fields <bfields@redhat.com>
> Fixes: 909e22e05353 ("exportfs: fix 'passing zero to ERR_PTR()' warning")
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> ---
>  fs/exportfs/expfs.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/fs/exportfs/expfs.c b/fs/exportfs/expfs.c
> index 2dd55b172d57..25a09bacf9c1 100644
> --- a/fs/exportfs/expfs.c
> +++ b/fs/exportfs/expfs.c
> @@ -149,6 +149,8 @@ static struct dentry *reconnect_one(struct vfsmount *mnt,
>  	if (IS_ERR(tmp)) {
>  		dprintk("%s: lookup failed: %d\n", __func__, PTR_ERR(tmp));
>  		err = PTR_ERR(tmp);
> +		if (err == -ENOENT)
> +			goto out_reconnected;
>  		goto out_err;
>  	}
>  	if (tmp != dentry) {
> -- 
> 2.17.1
> 


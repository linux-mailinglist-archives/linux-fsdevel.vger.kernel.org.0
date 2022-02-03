Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AB204A90DF
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Feb 2022 23:50:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355893AbiBCWuY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 3 Feb 2022 17:50:24 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:32128 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1355880AbiBCWuX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 3 Feb 2022 17:50:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643928623;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mJQ9pNXP2BO63pYZSl9BdllJOiFstxfaE98BcStU4rI=;
        b=a0L3cBUobP3eS8dkFwTuwg+zVjE6DcbZNaOBhUU/5sWASdb8AQvVan2+Hm5bMfcUFSddMY
        QN2nBSTvgkJ6kfIUI/Jpwe7tPGCMZuI+rvdLjk3yo5GBn3dfUe0EL9uITngwcy0zpCZX8c
        /QLSk4WL3FT1U/CN23ytSLPO1WxdT70=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-642-8paBBaVCMd2LxDoqm0d5IQ-1; Thu, 03 Feb 2022 17:50:22 -0500
X-MC-Unique: 8paBBaVCMd2LxDoqm0d5IQ-1
Received: by mail-qt1-f200.google.com with SMTP id e14-20020ac84b4e000000b002cfbbdf8206so3312803qts.10
        for <linux-fsdevel@vger.kernel.org>; Thu, 03 Feb 2022 14:50:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=mJQ9pNXP2BO63pYZSl9BdllJOiFstxfaE98BcStU4rI=;
        b=1C4H4mzSluUI9/Ck7NLKtJ8tU6iw/ho0Hp88UkVrejifye4jSc++GSv8W6ouUQhEF9
         aPPMt3CNXuRJ4U4VyAvDZ7q8+S58DnjwCS+rYlud9kdjho/CGyLLu5eZBNW8c454eOZ3
         WFpcShp1Vo9+cB6HCHD9A9pW7K0TzL33SfHqGS53/eHxAanyfzsEEKdD/+OFFy3bxiq8
         l6HSwNL+G2XuiHAO9Tm+8FEqK9d88grxCyVKnKih0dh3ws+nvLEb8q4vGq6uxoNPrUIn
         h/bKn6aRg9r6EkIcnTtxD1zuHR6qJ+KxYyWDmTFmRxHydNikS55lsDZAvtfdpjy1FwaL
         4ViA==
X-Gm-Message-State: AOAM531k8MY6ACoNg5zKMuKw4hNRGvMDNuK9BywC/Suq387legZ9OsBK
        wmcrr5mlyVqz7qkyoaowgRHe5mJv0YTTw4MPgbjWaY+IYI6aFSxwiBdvm8zJh19doN/8guq92Bw
        xTESYhNDUgZLTsvmgeFSLgHFbAA==
X-Received: by 2002:a37:a808:: with SMTP id r8mr138304qke.665.1643928621658;
        Thu, 03 Feb 2022 14:50:21 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyONiqGYaEnzft+IhZzY1XRUiNJXCIm+X9FBrgT5rR4+2xePk7MnFmNDuZnSLYm3wPjAq6gyw==
X-Received: by 2002:a37:a808:: with SMTP id r8mr138296qke.665.1643928621451;
        Thu, 03 Feb 2022 14:50:21 -0800 (PST)
Received: from [192.168.1.3] ([68.20.15.154])
        by smtp.gmail.com with ESMTPSA id m3sm108544qkp.100.2022.02.03.14.50.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Feb 2022 14:50:21 -0800 (PST)
Message-ID: <f02a73124a8372b9b12a1c3e0de785bcd73ddeb1.camel@redhat.com>
Subject: Re: [PATCH RFC 1/3] fs/lock: add new callback, lm_expire_lock, to
 lock_manager_operations
From:   Jeff Layton <jlayton@redhat.com>
To:     Dai Ngo <dai.ngo@oracle.com>, chuck.lever@oracle.com,
        bfields@fieldses.org
Cc:     viro@zeniv.linux.org.uk, linux-nfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Date:   Thu, 03 Feb 2022 17:50:18 -0500
In-Reply-To: <1643398773-29149-2-git-send-email-dai.ngo@oracle.com>
References: <1643398773-29149-1-git-send-email-dai.ngo@oracle.com>
         <1643398773-29149-2-git-send-email-dai.ngo@oracle.com>
Content-Type: text/plain; charset="ISO-8859-15"
User-Agent: Evolution 3.42.3 (3.42.3-1.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, 2022-01-28 at 11:39 -0800, Dai Ngo wrote:
> Add new callback, lm_expire_lock, to lock_manager_operations to allow
> the lock manager to take appropriate action to resolve the lock conflict
> if possible. The callback takes 1 argument, the file_lock of the blocker
> and returns true if the conflict was resolved else returns false. Note
> that the lock manager has to be able to resolve the conflict while
> the spinlock flc_lock is held.
> 
> Lock manager, such as NFSv4 courteous server, uses this callback to
> resolve conflict by destroying lock owner, or the NFSv4 courtesy client
> (client that has expired but allowed to maintains its states) that owns
> the lock.
> 
> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
> ---
>  Documentation/filesystems/locking.rst |  2 ++
>  fs/locks.c                            | 14 ++++++++++----
>  include/linux/fs.h                    |  1 +
>  3 files changed, 13 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/filesystems/locking.rst b/Documentation/filesystems/locking.rst
> index d36fe79167b3..57ce0fbc8ab1 100644
> --- a/Documentation/filesystems/locking.rst
> +++ b/Documentation/filesystems/locking.rst
> @@ -439,6 +439,7 @@ prototypes::
>  	void (*lm_break)(struct file_lock *); /* break_lease callback */
>  	int (*lm_change)(struct file_lock **, int);
>  	bool (*lm_breaker_owns_lease)(struct file_lock *);
> +	bool (*lm_lock_conflict)(struct file_lock *);
>  
>  locking rules:
>  
> @@ -450,6 +451,7 @@ lm_grant:		no		no			no
>  lm_break:		yes		no			no
>  lm_change		yes		no			no
>  lm_breaker_owns_lease:	no		no			no
> +lm_lock_conflict:       no		no			no
>  ======================	=============	=================	=========
>  
>  buffer_head
> diff --git a/fs/locks.c b/fs/locks.c
> index 0fca9d680978..052b42cc7f25 100644
> --- a/fs/locks.c
> +++ b/fs/locks.c
> @@ -853,10 +853,13 @@ posix_test_lock(struct file *filp, struct file_lock *fl)
>  
>  	spin_lock(&ctx->flc_lock);
>  	list_for_each_entry(cfl, &ctx->flc_posix, fl_list) {
> -		if (posix_locks_conflict(fl, cfl)) {
> -			locks_copy_conflock(fl, cfl);
> -			goto out;
> -		}
> +		if (!posix_locks_conflict(fl, cfl))
> +			continue;
> +		if (cfl->fl_lmops && cfl->fl_lmops->lm_lock_conflict &&
> +			!cfl->fl_lmops->lm_lock_conflict(cfl))
> +			continue;
> +		locks_copy_conflock(fl, cfl);
> +		goto out;
>  	}
>  	fl->fl_type = F_UNLCK;
>  out:
> @@ -1059,6 +1062,9 @@ static int posix_lock_inode(struct inode *inode, struct file_lock *request,
>  		list_for_each_entry(fl, &ctx->flc_posix, fl_list) {
>  			if (!posix_locks_conflict(request, fl))
>  				continue;
> +			if (fl->fl_lmops && fl->fl_lmops->lm_lock_conflict &&
> +				!fl->fl_lmops->lm_lock_conflict(fl))
> +				continue;

The naming of this op is a little misleading. We already know that there
is a lock confict in this case. The question is whether it's resolvable
by expiring a tardy client. That said, I don't have a better name to
suggest at the moment.

A comment about what this function actually tells us would be nice here.

>  			if (conflock)
>  				locks_copy_conflock(conflock, fl);
>  			error = -EAGAIN;
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index bbf812ce89a8..21cb7afe2d63 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -1068,6 +1068,7 @@ struct lock_manager_operations {
>  	int (*lm_change)(struct file_lock *, int, struct list_head *);
>  	void (*lm_setup)(struct file_lock *, void **);
>  	bool (*lm_breaker_owns_lease)(struct file_lock *);
> +	bool (*lm_lock_conflict)(struct file_lock *cfl);
>  };
>  
>  struct lock_manager {

Acked-by: Jeff Layton <jlayton@redhat.com>


Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EFF7408D55
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Sep 2021 15:24:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241067AbhIMNZI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 13 Sep 2021 09:25:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:35044 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240570AbhIMNWM (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 13 Sep 2021 09:22:12 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C8D7461151;
        Mon, 13 Sep 2021 13:20:45 +0000 (UTC)
Date:   Mon, 13 Sep 2021 15:20:43 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>,
        linux-block@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 02/13] kernfs: remove kernfs_create_file and
 kernfs_create_file_ns
Message-ID: <20210913132043.76lqlamlnyekjp3t@wittgenstein>
References: <20210913054121.616001-1-hch@lst.de>
 <20210913054121.616001-3-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210913054121.616001-3-hch@lst.de>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Sep 13, 2021 at 07:41:10AM +0200, Christoph Hellwig wrote:
> All callers actually use __kernfs_create_file.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---

Acked-by: Christian Brauner <christian.brauner@ubuntu.com>

>  include/linux/kernfs.h | 24 ------------------------
>  1 file changed, 24 deletions(-)
> 
> diff --git a/include/linux/kernfs.h b/include/linux/kernfs.h
> index 1093abf7c28cc..cecfeedb7361d 100644
> --- a/include/linux/kernfs.h
> +++ b/include/linux/kernfs.h
> @@ -568,30 +568,6 @@ kernfs_create_dir(struct kernfs_node *parent, const char *name, umode_t mode,
>  				    priv, NULL);
>  }
>  
> -static inline struct kernfs_node *
> -kernfs_create_file_ns(struct kernfs_node *parent, const char *name,
> -		      umode_t mode, kuid_t uid, kgid_t gid,
> -		      loff_t size, const struct kernfs_ops *ops,
> -		      void *priv, const void *ns)
> -{
> -	struct lock_class_key *key = NULL;
> -
> -#ifdef CONFIG_DEBUG_LOCK_ALLOC
> -	key = (struct lock_class_key *)&ops->lockdep_key;
> -#endif
> -	return __kernfs_create_file(parent, name, mode, uid, gid,
> -				    size, ops, priv, ns, key);
> -}
> -
> -static inline struct kernfs_node *
> -kernfs_create_file(struct kernfs_node *parent, const char *name, umode_t mode,
> -		   loff_t size, const struct kernfs_ops *ops, void *priv)
> -{
> -	return kernfs_create_file_ns(parent, name, mode,
> -				     GLOBAL_ROOT_UID, GLOBAL_ROOT_GID,
> -				     size, ops, priv, NULL);
> -}
> -
>  static inline int kernfs_remove_by_name(struct kernfs_node *parent,
>  					const char *name)
>  {
> -- 
> 2.30.2
> 

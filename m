Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49E49408FB7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Sep 2021 15:45:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243407AbhIMNpy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 13 Sep 2021 09:45:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:46760 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241915AbhIMNoG (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 13 Sep 2021 09:44:06 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id AB37C61439;
        Mon, 13 Sep 2021 13:30:59 +0000 (UTC)
Date:   Mon, 13 Sep 2021 15:30:57 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>,
        linux-block@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 07/13] sysfs: add ->seq_show support to sysfs_ops
Message-ID: <20210913133057.jecjno7uswlvfdu2@wittgenstein>
References: <20210913054121.616001-1-hch@lst.de>
 <20210913054121.616001-8-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210913054121.616001-8-hch@lst.de>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Sep 13, 2021 at 07:41:15AM +0200, Christoph Hellwig wrote:
> Allow attributes to directly use the seq_file method instead of
> carving out a buffer that can easily lead to buffer overflows.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---

Acked-by: Christian Brauner <christian.brauner@ubuntu.com>

>  fs/sysfs/file.c       | 19 ++++++++++++++-----
>  include/linux/sysfs.h |  9 +++++++--
>  2 files changed, 21 insertions(+), 7 deletions(-)
> 
> diff --git a/fs/sysfs/file.c b/fs/sysfs/file.c
> index 42dcf96881b68..12e0bfe40a2b4 100644
> --- a/fs/sysfs/file.c
> +++ b/fs/sysfs/file.c
> @@ -45,6 +45,9 @@ static int sysfs_kf_seq_show(struct seq_file *sf, void *v)
>  	ssize_t count;
>  	char *buf;
>  
> +	if (ops->seq_show)
> +		return ops->seq_show(kobj, of->kn->priv, sf);
> +
>  	if (WARN_ON_ONCE(!ops->show))
>  		return -EINVAL;
>  
> @@ -268,6 +271,10 @@ int sysfs_add_file_mode_ns(struct kernfs_node *parent,
>  		return -EINVAL;
>  
>  	if (mode & SYSFS_PREALLOC) {
> +		if (WARN(sysfs_ops->seq_show, KERN_ERR
> +				"seq_show not supported on prealloc file: %s\n",
> +				kobject_name(kobj)))
> +			return -EINVAL;
>  		if (sysfs_ops->show && sysfs_ops->store)
>  			ops = &sysfs_prealloc_kfops_rw;
>  		else if (sysfs_ops->show)
> @@ -275,12 +282,14 @@ int sysfs_add_file_mode_ns(struct kernfs_node *parent,
>  		else if (sysfs_ops->store)
>  			ops = &sysfs_prealloc_kfops_wo;
>  	} else {
> -		if (sysfs_ops->show && sysfs_ops->store)
> -			ops = &sysfs_file_kfops_rw;
> -		else if (sysfs_ops->show)
> -			ops = &sysfs_file_kfops_ro;
> -		else if (sysfs_ops->store)
> +		if (sysfs_ops->seq_show || sysfs_ops->show) {
> +			if (sysfs_ops->store)
> +				ops = &sysfs_file_kfops_rw;
> +			else
> +				ops = &sysfs_file_kfops_ro;
> +		} else if (sysfs_ops->store) {
>  			ops = &sysfs_file_kfops_wo;
> +		}
>  	}
>  
>  	if (!ops)
> diff --git a/include/linux/sysfs.h b/include/linux/sysfs.h
> index e3f1e8ac1f85b..e1ab4da716730 100644
> --- a/include/linux/sysfs.h
> +++ b/include/linux/sysfs.h
> @@ -236,8 +236,13 @@ struct bin_attribute bin_attr_##_name = __BIN_ATTR_WO(_name, _size)
>  struct bin_attribute bin_attr_##_name = __BIN_ATTR_RW(_name, _size)
>  
>  struct sysfs_ops {
> -	ssize_t	(*show)(struct kobject *, struct attribute *, char *);
> -	ssize_t	(*store)(struct kobject *, struct attribute *, const char *, size_t);
> +	int	(*seq_show)(struct kobject *kobj, struct attribute *attr,
> +			struct seq_file *sf);
> +	ssize_t	(*store)(struct kobject *kobj, struct attribute *attr,
> +			const char *buf, size_t size);
> +
> +	/* deprecated except for preallocated attributes: */
> +	ssize_t	(*show)(struct kobject *kob, struct attribute *attr, char *buf);
>  };
>  
>  #ifdef CONFIG_SYSFS
> -- 
> 2.30.2
> 

Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83FEC410E57
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Sep 2021 04:23:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233998AbhITCY6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 19 Sep 2021 22:24:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231796AbhITCY6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 19 Sep 2021 22:24:58 -0400
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00075C061574;
        Sun, 19 Sep 2021 19:23:31 -0700 (PDT)
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mS8xm-005iJJ-0G; Mon, 20 Sep 2021 02:23:22 +0000
Date:   Mon, 20 Sep 2021 02:23:21 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Vivek Goyal <vgoyal@redhat.com>
Cc:     Christoph Hellwig <hch@infradead.org>, Jan Kara <jack@suse.cz>,
        Linux fsdevel mailing list <linux-fsdevel@vger.kernel.org>,
        linux kernel mailing list <linux-kernel@vger.kernel.org>,
        xu.xin16@zte.com.cn, christian.brauner@ubuntu.com
Subject: Re: [PATCH v3] init/do_mounts.c: Harden split_fs_names() against
 buffer overflow
Message-ID: <YUfwmdWTylRidtkq@zeniv-ca.linux.org.uk>
References: <YUSUc7AyCq/P3SLR@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YUSUc7AyCq/P3SLR@redhat.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Sep 17, 2021 at 09:13:23AM -0400, Vivek Goyal wrote:

> --- redhat-linux.orig/init/do_mounts.c	2021-09-15 08:46:33.801689806 -0400
> +++ redhat-linux/init/do_mounts.c	2021-09-17 08:44:40.781430167 -0400
> @@ -338,20 +338,19 @@ __setup("rootflags=", root_data_setup);
>  __setup("rootfstype=", fs_names_setup);
>  __setup("rootdelay=", root_delay_setup);
>  
> -static int __init split_fs_names(char *page, char *names)
> +/* This can return zero length strings. Caller should check */
> +static int __init split_fs_names(char *page, size_t size, char *names)
>  {
> -	int count = 0;
> +	int count = 1;
>  	char *p = page;
>  
> -	strcpy(p, root_fs_names);
> +	strlcpy(p, root_fs_names, size);
>  	while (*p++) {
> -		if (p[-1] == ',')
> +		if (p[-1] == ',') {
>  			p[-1] = '\0';
> +			count++;
> +		}
>  	}
> -	*p = '\0';
> -
> -	for (p = page; *p; p += strlen(p)+1)
> -		count++;
>  
>  	return count;
>  }
> @@ -404,12 +403,16 @@ void __init mount_block_root(char *name,
>  	scnprintf(b, BDEVNAME_SIZE, "unknown-block(%u,%u)",
>  		  MAJOR(ROOT_DEV), MINOR(ROOT_DEV));
>  	if (root_fs_names)
> -		num_fs = split_fs_names(fs_names, root_fs_names);
> +		num_fs = split_fs_names(fs_names, PAGE_SIZE, root_fs_names);
>  	else
>  		num_fs = list_bdev_fs_names(fs_names, PAGE_SIZE);
>  retry:
>  	for (i = 0, p = fs_names; i < num_fs; i++, p += strlen(p)+1) {
> -		int err = do_mount_root(name, p, flags, root_mount_data);
> +		int err;
> +
> +		if (!*p)
> +			continue;
> +		err = do_mount_root(name, p, flags, root_mount_data);
>  		switch (err) {
>  			case 0:
>  				goto out;
> @@ -543,10 +546,12 @@ static int __init mount_nodev_root(void)
>  	fs_names = (void *)__get_free_page(GFP_KERNEL);
>  	if (!fs_names)
>  		return -EINVAL;
> -	num_fs = split_fs_names(fs_names, root_fs_names);
> +	num_fs = split_fs_names(fs_names, PAGE_SIZE, root_fs_names);
>  
>  	for (i = 0, fstype = fs_names; i < num_fs;
>  	     i++, fstype += strlen(fstype) + 1) {
> +		if (!*fstype)
> +			continue;
>  		if (!fs_is_nodev(fstype))
>  			continue;
>  		err = do_mount_root(root_device_name, fstype, root_mountflags,


Applied.

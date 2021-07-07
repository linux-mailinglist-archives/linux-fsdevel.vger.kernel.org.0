Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FC733BF135
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Jul 2021 23:06:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232521AbhGGVJb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 7 Jul 2021 17:09:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:47039 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230500AbhGGVJa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 7 Jul 2021 17:09:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1625692009;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+7m/eIRlnZBYcjDw1k2mlaQoBa6NNsCMDSwIdGed5BM=;
        b=Rso6/edC2GhT0wlGQ/FQft0gTRyeU8rj6MUFhEinOXyIJuMOwtmKmHiBs6o5NaR5vf77/D
        BsjVfu1LsVRr9JYMgBJpPwdkLUHB6i7uHaP9B7MpyYopYVpycnPWirV/9hLV6MNSUvEQa3
        mGRd+dapSvitF4ks1oG0vwRPYJCK6CY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-202-l2kfGnpAOr-A8Ox8VlWyDQ-1; Wed, 07 Jul 2021 17:06:48 -0400
X-MC-Unique: l2kfGnpAOr-A8Ox8VlWyDQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0DE6D100C610;
        Wed,  7 Jul 2021 21:06:47 +0000 (UTC)
Received: from horse.redhat.com (ovpn-115-221.rdu2.redhat.com [10.10.115.221])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8AC3560C05;
        Wed,  7 Jul 2021 21:06:36 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id 23F3522054F; Wed,  7 Jul 2021 17:06:36 -0400 (EDT)
Date:   Wed, 7 Jul 2021 17:06:36 -0400
From:   Vivek Goyal <vgoyal@redhat.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Stefan Hajnoczi <stefanha@redhat.com>, viro@zeniv.linux.org.uk,
        linux-fsdevel@vger.kernel.org, virtio-fs@redhat.com,
        linux-kernel@vger.kernel.org
Subject: Re: [Virtio-fs] [PATCH 3/2] fs: simplify get_filesystem_list /
 get_all_fs_names
Message-ID: <20210707210636.GC244500@redhat.com>
References: <20210621062657.3641879-1-hch@lst.de>
 <20210622081217.GA2975@lst.de>
 <YNGhERcnLuzjn8j9@stefanha-x1.localdomain>
 <20210629205048.GE5231@redhat.com>
 <20210630053601.GA29241@lst.de>
 <20210707210404.GB244500@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210707210404.GB244500@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jul 07, 2021 at 05:04:04PM -0400, Vivek Goyal wrote:
> On Wed, Jun 30, 2021 at 07:36:01AM +0200, Christoph Hellwig wrote:
> > On Tue, Jun 29, 2021 at 04:50:48PM -0400, Vivek Goyal wrote:
> > > May be we should modify mount_block_root() code so that it does not
> > > require that extra "\0". Possibly zero initialize page and that should
> > > make sure list_bdev_fs_names() does not have to worry about it.
> > > 
> > > It is possible that a page gets full from the list of filesystems, and
> > > last byte on page is terminating null. In that case just zeroing page
> > > will not help. We can keep track of some sort of end pointer and make
> > > sure we are not searching beyond that for valid filesystem types.
> > > 
> > > end = page + PAGE_SIZE - 1;
> > > 
> > > mount_block_root()
> > > {
> > > 	for (p = fs_names; p < end && *p; p += strlen(p)+1) {
> > > 	}
> > > }
> > 
> > Maybe.  To honest I'd prefer to not even touch this unrelated code given
> > how full of landmines it is :)
> 
> Hi Christoph,
> 
> How about following patch. This applies on top of your patches. I noticed
> that Al had suggested to return number of filesystems from helper
> functions. I just did that and used that to iterate in the loop.
> 
> I tested it with a virtual block device (root=/dev/vda1) and it works.
> I also filled page with garbage after allocation to make sure natually
> occurring null is not there in the middle of page to terminate string.
> 
> If you like it, can you please incorporate it in your patches.

I noticed this will break with "root_fs_names=". Sorry, will have to
fix split_fs_names() as well. Will do.

Vivek

> 
> Thanks
> Vivek
> 
> ---
>  fs/filesystems.c   |    5 ++++-
>  include/linux/fs.h |    2 +-
>  init/do_mounts.c   |    7 ++++---
>  3 files changed, 9 insertions(+), 5 deletions(-)
> 
> Index: redhat-linux/fs/filesystems.c
> ===================================================================
> --- redhat-linux.orig/fs/filesystems.c	2021-07-07 16:12:08.890562576 -0400
> +++ redhat-linux/fs/filesystems.c	2021-07-07 16:27:51.197620063 -0400
> @@ -209,10 +209,11 @@ SYSCALL_DEFINE3(sysfs, int, option, unsi
>  }
>  #endif
>  
> -void __init list_bdev_fs_names(char *buf, size_t size)
> +int __init list_bdev_fs_names(char *buf, size_t size)
>  {
>  	struct file_system_type *p;
>  	size_t len;
> +	int count = 0;
>  
>  	read_lock(&file_systems_lock);
>  	for (p = file_systems; p; p = p->next) {
> @@ -226,8 +227,10 @@ void __init list_bdev_fs_names(char *buf
>  		memcpy(buf, p->name, len);
>  		buf += len;
>  		size -= len;
> +		count++;
>  	}
>  	read_unlock(&file_systems_lock);
> +	return count;
>  }
>  
>  #ifdef CONFIG_PROC_FS
> Index: redhat-linux/include/linux/fs.h
> ===================================================================
> --- redhat-linux.orig/include/linux/fs.h	2021-07-07 15:36:43.224418935 -0400
> +++ redhat-linux/include/linux/fs.h	2021-07-07 16:12:18.232949807 -0400
> @@ -3622,7 +3622,7 @@ int proc_nr_dentry(struct ctl_table *tab
>  		  void *buffer, size_t *lenp, loff_t *ppos);
>  int proc_nr_inodes(struct ctl_table *table, int write,
>  		   void *buffer, size_t *lenp, loff_t *ppos);
> -void __init list_bdev_fs_names(char *buf, size_t size);
> +int __init list_bdev_fs_names(char *buf, size_t size);
>  
>  #define __FMODE_EXEC		((__force int) FMODE_EXEC)
>  #define __FMODE_NONOTIFY	((__force int) FMODE_NONOTIFY)
> Index: redhat-linux/init/do_mounts.c
> ===================================================================
> --- redhat-linux.orig/init/do_mounts.c	2021-07-07 16:12:08.890562576 -0400
> +++ redhat-linux/init/do_mounts.c	2021-07-07 16:23:32.308889444 -0400
> @@ -391,15 +391,16 @@ void __init mount_block_root(char *name,
>  	char *fs_names = page_address(page);
>  	char *p;
>  	char b[BDEVNAME_SIZE];
> +	int num_fs, i;
>  
>  	scnprintf(b, BDEVNAME_SIZE, "unknown-block(%u,%u)",
>  		  MAJOR(ROOT_DEV), MINOR(ROOT_DEV));
>  	if (root_fs_names)
>  		split_fs_names(fs_names, root_fs_names);
>  	else
> -		list_bdev_fs_names(fs_names, PAGE_SIZE);
> +		num_fs = list_bdev_fs_names(fs_names, PAGE_SIZE);
>  retry:
> -	for (p = fs_names; *p; p += strlen(p)+1) {
> +	for (p = fs_names, i = 0; i < num_fs; p += strlen(p)+1, i++) {
>  		int err = do_mount_root(name, p, flags, root_mount_data);
>  		switch (err) {
>  			case 0:
> @@ -432,7 +433,7 @@ retry:
>  	printk("List of all partitions:\n");
>  	printk_all_partitions();
>  	printk("No filesystem could mount root, tried: ");
> -	for (p = fs_names; *p; p += strlen(p)+1)
> +	for (p = fs_names, i = 0; i < num_fs; p += strlen(p)+1, i++)
>  		printk(" %s", p);
>  	printk("\n");
>  	panic("VFS: Unable to mount root fs on %s", b);
> 
> 


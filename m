Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E64227D76A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Sep 2020 21:58:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728825AbgI2T65 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 29 Sep 2020 15:58:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:58363 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727740AbgI2T65 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 29 Sep 2020 15:58:57 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1601409535;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GHmpuPDMKZJYBNRtEpdE4Ez4ALiFOXcUog0Cwe7mUiA=;
        b=NQW8ABlMkMap0bGuzYgl2FrQwzHFhXI9jN81C7yx6ZbFP1blgK4Mt0eFUc6WYfYVrsCA3R
        9k6W2pVJI1jF6QTWQ29DMyNaZl9u5QRE82GkrTKzyXSUE7TybfnfyCEhK5EUF1RGaDplZz
        njL4VQWgv0nsvDySjwvMwWQ6WL6UEQ4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-532-2r0iCLU0PXW7kCZTO8aSfQ-1; Tue, 29 Sep 2020 15:58:53 -0400
X-MC-Unique: 2r0iCLU0PXW7kCZTO8aSfQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5BB5A8015A6;
        Tue, 29 Sep 2020 19:58:52 +0000 (UTC)
Received: from horse.redhat.com (ovpn-116-167.rdu2.redhat.com [10.10.116.167])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BE7485C1C4;
        Tue, 29 Sep 2020 19:58:48 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id 4689C220203; Tue, 29 Sep 2020 15:58:48 -0400 (EDT)
Date:   Tue, 29 Sep 2020 15:58:48 -0400
From:   Vivek Goyal <vgoyal@redhat.com>
To:     Linux fsdevel mailing list <linux-fsdevel@vger.kernel.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        virtio-fs-list <virtio-fs@redhat.com>
Cc:     Brian Foster <bfoster@redhat.com>
Subject: Re: [RFC PATCH] fuse: update attributes on read() only on timeout
Message-ID: <20200929195848.GH220516@redhat.com>
References: <20200929185015.GG220516@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200929185015.GG220516@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Sep 29, 2020 at 02:50:15PM -0400, Vivek Goyal wrote:
> Following commit added a flag to invalidate guest page cache automatically.
> 
> 72d0d248ca823 fuse: add FUSE_AUTO_INVAL_DATA init flag
> 
> Idea seemed to be that for network file systmes if client A modifies
> the file, then client B should be able to detect that mtime of file
> change and invalidate its own cache and fetch new data from server.
> 
> There are few questions/issues with this method.
> 
> How soon client B able to detect that file has changed. Should it
> first GETATTR from server for every READ and compare mtime. That
> will be much stronger cache coherency but very slow because every
> READ will first be preceeded by a GETATTR.
> 
> Or should this be driven by inode timeout. That is if inode cached attrs
> (including mtime) have timed out, we fetch new mtime from server and
> invalidate cache based on that.
> 
> Current logic calls fuse_update_attr() on every READ. But that method
> will result in GETATTR only if either attrs have timedout or if cached
> attrs have been invalidated.
> 
> If client B is only doing READs (and not WRITEs), then attrs should be
> valid for inode timeout interval. And that means client B will detect
> mtime change only after timeout interval.
> 
> But if client B is also doing WRITE, then once WRITE completes, we
> invalidate cached attrs. That means next READ will force GETATTR()
> and invalidate page cache. In this case client B will detect the
> change by client A much sooner but it can't differentiate between
> its own WRITEs and by another client WRITE. So every WRITE followed
> by READ will result in GETATTR, followed by page cache invalidation
> and performance suffers in mixed read/write workloads.
> 
> I am assuming that intent of auto_inval_data is to detect changes
> by another client but it can take up to "inode timeout" seconds
> to detect that change. (And it does not guarantee an immidiate change
> detection).
> 
> If above assumption is acceptable, then I am proposing this patch
> which will update attrs on READ only if attrs have timed out. This
> means every second we will do a GETATTR and invalidate page cache.
> 
> This is also suboptimal because only if client B is writing, our
> cache is still valid but we will still invalidate it after 1 second.
> But we don't have a good mechanism to differentiate between our own
> changes and another client's changes. So this is probably second
> best method to reduce the extent of issue.
> 
> I am running equivalent of following fio workload on virtiofs (cache=auto)
> and there I see a performance improvement of roughly 12%.
> 
> fio --direct=1 --gtod_reduce=1 --name=test --filename=random_read_write.fio
> +--bs=4k --iodepth=64 --size=4G --readwrite=randrw --rwmixread=75
> +--output=/output/fio.txt
> 
> NAME                    WORKLOAD                Bandwidth       IOPS
> vtfs-auto-sh		randrw-psync            43.3mb/14.4mb   10.8k/3709
> vtfs-auto-sh-invaltime  randrw-psync            48.9mb/16.3mb   12.2k/4197

Also ran a kernel compilation test. With this change, there is roughly
10% improvement in build time.

- git clone linux
- cd linux
- sync; echo 3 > /proc/sys/vm/drop_cache
- make defconfig
- time make -j32

Without patch
-------------
real    4m57.819s
user    23m2.432s
sys     18m39.004s

With patch
----------
real    4m33.549s
user    23m4.168s
sys     18m36.515s

Thanks
Vivek

> 
> Signee-off-by: Vivek Goyal <vgoyal@redhat.com>
> ---
>  fs/fuse/dir.c    |  6 ++++++
>  fs/fuse/file.c   | 21 +++++++++++++++------
>  fs/fuse/fuse_i.h |  1 +
>  3 files changed, 22 insertions(+), 6 deletions(-)
> 
> diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
> index 26f028bc760b..5c4eda0edd95 100644
> --- a/fs/fuse/dir.c
> +++ b/fs/fuse/dir.c
> @@ -1002,6 +1002,12 @@ int fuse_update_attributes(struct inode *inode, struct file *file)
>  				    STATX_BASIC_STATS & ~STATX_ATIME, 0);
>  }
>  
> +int fuse_update_attributes_timeout(struct inode *inode, struct file *file)
> +{
> +	/* Only refresh attrs if timeout has happened */
> +	return fuse_update_get_attr(inode, file, NULL, 0, 0);
> +}
> +
>  int fuse_reverse_inval_entry(struct super_block *sb, u64 parent_nodeid,
>  			     u64 child_nodeid, struct qstr *name)
>  {
> diff --git a/fs/fuse/file.c b/fs/fuse/file.c
> index 6611ef3269a8..dea001f5f4e9 100644
> --- a/fs/fuse/file.c
> +++ b/fs/fuse/file.c
> @@ -972,19 +972,28 @@ static ssize_t fuse_cache_read_iter(struct kiocb *iocb, struct iov_iter *to)
>  {
>  	struct inode *inode = iocb->ki_filp->f_mapping->host;
>  	struct fuse_conn *fc = get_fuse_conn(inode);
> +	int err = 0;
>  
>  	/*
> -	 * In auto invalidate mode, always update attributes on read.
> +	 * In auto invalidate mode, update attributes on read if previously
> +	 * stored attributes timed out. This is primarily done to detect
> +	 * writes by other clients and invalidate local cache. But we don't
> +	 * have a way to differentiate between our own writes and writes
> +	 * by other clients. So we end up updating attrs and invalidating
> +	 * cache on our own write. Stick to the theme of detecting changes
> +	 * after timeout. This is what happens already if we are not doing
> +	 * writes but other client is doing.
> +	 *
>  	 * Otherwise, only update if we attempt to read past EOF (to ensure
>  	 * i_size is up to date).
>  	 */
> -	if (fc->auto_inval_data ||
> -	    (iocb->ki_pos + iov_iter_count(to) > i_size_read(inode))) {
> -		int err;
> +	if (iocb->ki_pos + iov_iter_count(to) > i_size_read(inode)) {
>  		err = fuse_update_attributes(inode, iocb->ki_filp);
> -		if (err)
> -			return err;
> +	} else if (fc->auto_inval_data) {
> +		err = fuse_update_attributes_timeout(inode, iocb->ki_filp);
>  	}
> +	if (err)
> +		return err;
>  
>  	return generic_file_read_iter(iocb, to);
>  }
> diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
> index 740a8a7d7ae6..78f93129b60e 100644
> --- a/fs/fuse/fuse_i.h
> +++ b/fs/fuse/fuse_i.h
> @@ -1004,6 +1004,7 @@ u64 fuse_lock_owner_id(struct fuse_conn *fc, fl_owner_t id);
>  void fuse_update_ctime(struct inode *inode);
>  
>  int fuse_update_attributes(struct inode *inode, struct file *file);
> +int fuse_update_attributes_timeout(struct inode *inode, struct file *file);
>  
>  void fuse_flush_writepages(struct inode *inode);
>  
> -- 
> 2.25.4
> 


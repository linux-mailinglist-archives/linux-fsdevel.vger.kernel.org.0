Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D4F035E7A5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Apr 2021 22:38:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232302AbhDMUjA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 13 Apr 2021 16:39:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:57432 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232041AbhDMUi5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 13 Apr 2021 16:38:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1618346317;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=E0nETp9hX+E4qbIOEDNqrOiP+I2YWR1jumKXOEBfrjE=;
        b=ayk2r61aBxEHBNgI+5voLEM9Z6LLHDgXeQPpaFskXc4etjqv4bGMS8/zbpkSAlYCxNNAGt
        WUtXfDqzI1/UCtVmSFhxm34pM2IZOCbfTIPGBM8mBUb8G4a6haAgPIM4v3Jpk1h55kJiV3
        lTremD5Jia0VqH4wY93ehX7y1hVTMMM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-57-0WjinJ9iO7uH-DOPPILJGQ-1; Tue, 13 Apr 2021 16:38:35 -0400
X-MC-Unique: 0WjinJ9iO7uH-DOPPILJGQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E76E3108BD0E;
        Tue, 13 Apr 2021 20:38:31 +0000 (UTC)
Received: from horse.redhat.com (ovpn-116-152.rdu2.redhat.com [10.10.116.152])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BF9755D9D0;
        Tue, 13 Apr 2021 20:38:31 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id 44AC422054F; Tue, 13 Apr 2021 16:38:31 -0400 (EDT)
Date:   Tue, 13 Apr 2021 16:38:31 -0400
From:   Vivek Goyal <vgoyal@redhat.com>
To:     linux-fsdevel@vger.kernel.org, Miklos Szeredi <miklos@szeredi.hu>
Cc:     virtio-fs-list <virtio-fs@redhat.com>, eric.auger@redhat.com
Subject: Re: [Virtio-fs] [PATCH] fuse: Invalidate attrs when page writeback
 completes
Message-ID: <20210413203831.GJ1235549@redhat.com>
References: <20210406140706.GB934253@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210406140706.GB934253@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Miklos,

Ping.

Thanks
Vivek

On Tue, Apr 06, 2021 at 10:07:06AM -0400, Vivek Goyal wrote:
> In fuse when a direct/write-through write happens we invalidate attrs because
> that might have updated mtime/ctime on server and cached mtime/ctime
> will be stale.
> 
> What about page writeback path. Looks like we don't invalidate attrs there.
> To be consistent, invalidate attrs in writeback path as well. Only exception
> is when writeback_cache is enabled. In that case we strust local mtime/ctime
> and there is no need to invalidate attrs.
> 
> Recently users started experiencing failure of xfstests generic/080,
> geneirc/215 and generic/614 on virtiofs. This happened only newer
> "stat" utility and not older one. This patch fixes the issue.
> 
> So what's the root cause of the issue. Here is detailed explanation.
> 
> generic/080 test does mmap write to a file, closes the file and then
> checks if mtime has been updated or not. When file is closed, it
> leads to flushing of dirty pages (and that should update mtime/ctime
> on server). But we did not explicitly invalidate attrs after writeback
> finished. Still generic/080 passed so far and reason being that we
> invalidated atime in fuse_readpages_end(). This is called in fuse_readahead()
> path and always seems to trigger before mmaped write.
> 
> So after mmaped write when lstat() is called, it sees that atleast one
> of the fields being asked for is invalid (atime) and that results in
> generating GETATTR to server and mtime/ctime also get updated and test
> passes.
> 
> But newer /usr/bin/stat seems to have moved to using statx() syscall now
> (instead of using lstat()). And statx() allows it to query only ctime
> or mtime (and not rest of the basic stat fields). That means when
> querying for mtime, fuse_update_get_attr() sees that mtime is not
> invalid (only atime is invalid). So it does not generate a new GETATTR
> and fill stat with cached mtime/ctime. And that means updated mtime
> is not seen by xfstest and tests start failing.
> 
> Invalidating attrs after writeback completion should solve this problem
> in a generic manner.
> 
> Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
> ---
>  fs/fuse/file.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/fs/fuse/file.c b/fs/fuse/file.c
> index 8cccecb55fb8..482281bf170a 100644
> --- a/fs/fuse/file.c
> +++ b/fs/fuse/file.c
> @@ -1759,8 +1759,17 @@ static void fuse_writepage_end(struct fuse_mount *fm, struct fuse_args *args,
>  		container_of(args, typeof(*wpa), ia.ap.args);
>  	struct inode *inode = wpa->inode;
>  	struct fuse_inode *fi = get_fuse_inode(inode);
> +	struct fuse_conn *fc = get_fuse_conn(inode);
>  
>  	mapping_set_error(inode->i_mapping, error);
> +	/*
> +	 * A writeback finished and this might have updated mtime/ctime on
> +	 * server making local mtime/ctime stale. Hence invalidate attrs.
> +	 * Do this only if writeback_cache is not enabled. If writeback_cache
> +	 * is enabled, we trust local ctime/mtime.
> +	 */
> +	if (!fc->writeback_cache)
> +		fuse_invalidate_attr(inode);
>  	spin_lock(&fi->lock);
>  	rb_erase(&wpa->writepages_entry, &fi->writepages);
>  	while (wpa->next) {
> -- 
> 2.25.4
> 
> _______________________________________________
> Virtio-fs mailing list
> Virtio-fs@redhat.com
> https://listman.redhat.com/mailman/listinfo/virtio-fs


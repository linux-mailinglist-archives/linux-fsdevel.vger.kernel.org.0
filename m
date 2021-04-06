Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7C9B355781
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Apr 2021 17:15:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345552AbhDFPPa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 6 Apr 2021 11:15:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:54918 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1345526AbhDFPP2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 6 Apr 2021 11:15:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617722120;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pfDBPF8LdvyhRPcGnZsgkl0rlZHryHgc3r1ioOxrtKc=;
        b=Ka8QcY8iEf/oIyhrcnSitEvJKYfFrNXuG6lwGF511R65acEsxzLtxufJ79Mfc8gxDXMjGO
        FxJoPWH+CUR0sJel7rg03OCCj4jRISERTNOa3rNgoJw3a6wo9gX26tnTpPQZ89w9VLUhHw
        pjoUYKk+PiAzjXbZLxjEshjQZVC2tBs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-407-HZZ-fZE0OMKSN5kd71TJuA-1; Tue, 06 Apr 2021 11:15:16 -0400
X-MC-Unique: HZZ-fZE0OMKSN5kd71TJuA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DBC18108BD0E;
        Tue,  6 Apr 2021 15:15:15 +0000 (UTC)
Received: from [10.36.112.13] (ovpn-112-13.ams2.redhat.com [10.36.112.13])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id CFF81610A8;
        Tue,  6 Apr 2021 15:15:11 +0000 (UTC)
Subject: Re: [PATCH] fuse: Invalidate attrs when page writeback completes
To:     Vivek Goyal <vgoyal@redhat.com>, linux-fsdevel@vger.kernel.org,
        Miklos Szeredi <miklos@szeredi.hu>
Cc:     virtio-fs-list <virtio-fs@redhat.com>
References: <20210406140706.GB934253@redhat.com>
From:   Auger Eric <eric.auger@redhat.com>
Message-ID: <99147394-228d-9cbc-29b3-e3144e4bb9f9@redhat.com>
Date:   Tue, 6 Apr 2021 17:15:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210406140706.GB934253@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Vivek,

On 4/6/21 4:07 PM, Vivek Goyal wrote:
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
all the above tests now pass on aarch64 whereas they failed without the
patch.

Tested-by: Eric Auger <eric.auger@redhat.com>

Thanks!

Eric

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
> 


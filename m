Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26498315752
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Feb 2021 21:01:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233720AbhBIUAi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 9 Feb 2021 15:00:38 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:39778 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233294AbhBITvf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 9 Feb 2021 14:51:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612900202;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=J0SCPlBXORW2GTqcktfrJi1FQ//IYX3jvXLSujQSlo4=;
        b=IgiuLGVzPBCckmncf0UpVznJrCoJD3En8zI2VUhthNnbycrCENXl584uicoXt8cA9PWsRA
        gonfaJfiJ9L7wuYhCFtZwfzQniOSsNyZQlDLnTDnkAlmDZUCFK4WgxFHlIIFOBX/gtE0Ue
        P/ZP89yF8x6rpsZPNRRt5gNCkrOrh5o=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-266-O7ehgX27OtCxB3tHry24qg-1; Tue, 09 Feb 2021 14:09:22 -0500
X-MC-Unique: O7ehgX27OtCxB3tHry24qg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C34D7107ACE3;
        Tue,  9 Feb 2021 19:09:20 +0000 (UTC)
Received: from horse.redhat.com (ovpn-116-3.rdu2.redhat.com [10.10.116.3])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2183C60C04;
        Tue,  9 Feb 2021 19:09:20 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id A82BA220BCF; Tue,  9 Feb 2021 14:09:19 -0500 (EST)
Date:   Tue, 9 Feb 2021 14:09:19 -0500
From:   Vivek Goyal <vgoyal@redhat.com>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Qian Cai <cai@lca.pw>, Hugh Dickins <hughd@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Linux-MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Amir Goldstein <amir73il@gmail.com>
Subject: Re: Possible deadlock in fuse write path (Was: Re: [PATCH 0/4] Some
 more lock_page work..)
Message-ID: <20210209190919.GE3171@redhat.com>
References: <CAHk-=wh9Eu-gNHzqgfvUAAiO=vJ+pWnzxkv+tX55xhGPFy+cOw@mail.gmail.com>
 <20201015151606.GA226448@redhat.com>
 <20201015195526.GC226448@redhat.com>
 <CAHk-=wj0vjx0jzaq5Gha-SmDKc3Hnog5LKX0eJZkudBvEQFAUA@mail.gmail.com>
 <CAJfpegtAstEo+nYgT81swYZWdziaZP_40QGAXcTORqYwgeWNUA@mail.gmail.com>
 <20201020204226.GA376497@redhat.com>
 <CAJfpegsi8UFiYyPrPbQob2x4X7NKSnciEz-a=5YZtFCgY0wL6w@mail.gmail.com>
 <20201021201249.GB442437@redhat.com>
 <CAJfpegsaLrbJ7bjJVBC3=vLzWZcF+GtTpGjVKYYOE3mjKyuVAw@mail.gmail.com>
 <20210209100115.GB1208880@miu.piliscsaba.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210209100115.GB1208880@miu.piliscsaba.redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Feb 09, 2021 at 11:01:15AM +0100, Miklos Szeredi wrote:
> Hi Vivek,
> 
> Here's an updated patch with a header comment containing all the gory details.
> It's basically your patch, but it's missing your S-o-b.  If you are fine with
> it, can you please provide one?
> 
> The only change I made was to clear PG_uptodate on write error, otherwise I
> think the patch is fine.

Hi Miklos,

In general I am fine with the patch. I am still little concerned with
how to handle error scenario and how to handle it best. Whether to
clear Pageuptodate on error or leave it alone. Leaving it alone will
more like be writeback failure scenario where many filesystems don't
set dirty flag on page again if writeback fails. 

Can't decide whether to leave it alone is better or not. So for now, I
will just go along with clearing PageUptodate on error.

Can you please also put Link to this mail thread in the commit id. There
are quite a few good details in this mail thread. Will be good to be
able to track it back from commit.

Link: https://lore.kernel.org/linux-fsdevel/4794a3fa3742a5e84fb0f934944204b55730829b.camel@lca.pw/

With that.

Signed-off-by: Vivek Goyal <vgoyal@redhat.com>


> 
> Splitting the request might cause a performance regression in some cases (lots
> of unaligned writes that spill over a page boundary) but I don't have a better
> idea at this moment.
> 
> Thanks,
> Miklos
> ----
> 
> Date: Wed, 21 Oct 2020 16:12:49 -0400
> From: Vivek Goyal <vgoyal@redhat.com>
> Subject: fuse: fix write deadlock
> 
> There are two modes for write(2) and friends in fuse:
> 
> a) write through (update page cache, send sync WRITE request to userspace)
> 
> b) buffered write (update page cache, async writeout later)
> 
> The write through method kept all the page cache pages locked that were
> used for the request.  Keeping more than one page locked is deadlock prone
> and Qian Cai demonstrated this with trinity fuzzing.
> 
> The reason for keeping the pages locked is that concurrent mapped reads
> shouldn't try to pull possibly stale data into the page cache.
> 
> For full page writes, the easy way to fix this is to make the cached page
> be the authoritative source by marking the page PG_uptodate immediately.
> After this the page can be safely unlocked, since mapped/cached reads will
> take the written data from the cache.
> 
> Concurrent mapped writes will now cause data in the original WRITE request
> to be updated; this however doesn't cause any data inconsistency and this
> scenario should be exceedingly rare anyway.
> 
> If the WRITE request returns with an error in the above case, currently the
> page is not marked uptodate; this means that a concurrent read will always
> read consistent data.  After this patch the page is uptodate between
> writing to the cache and receiving the error: there's window where a cached
> read will read the wrong data.  While theoretically this could be a
> regression, it is unlikely to be one in practice, since this is normal for
> buffered writes.
> 
> In case of a partial page write to an already uptodate page the locking is
> also unnecessary, with the above caveats.
> 
> Partial write of a not uptodate page still needs to be handled.  One way
> would be to read the complete page before doing the write.  This is not
> possible, since it might break filesystems that don't expect any READ
> requests when the file was opened O_WRONLY.
> 
> The other solution is to serialize the synchronous write with reads from
> the partial pages.  The easiest way to do this is to keep the partial pages
> locked.  The problem is that a write() may involve two such pages (one head
> and one tail).  This patch fixes it by only locking the partial tail page.
> If there's a partial head page as well, then split that off as a separate
> WRITE request.
> 
> Reported-by: Qian Cai <cai@lca.pw>
> Fixes: ea9b9907b82a ("fuse: implement perform_write")
> Cc: <stable@vger.kernel.org> # v2.6.26
> Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
> ---
>  fs/fuse/file.c   |   25 +++++++++++++++----------
>  fs/fuse/fuse_i.h |    1 +
>  2 files changed, 16 insertions(+), 10 deletions(-)
> 
> --- a/fs/fuse/file.c
> +++ b/fs/fuse/file.c
> @@ -1117,17 +1117,12 @@ static ssize_t fuse_send_write_pages(str
>  	count = ia->write.out.size;
>  	for (i = 0; i < ap->num_pages; i++) {
>  		struct page *page = ap->pages[i];
> +		bool page_locked = ap->page_locked && (i == ap->num_pages - 1);
>  
> -		if (!err && !offset && count >= PAGE_SIZE)
> -			SetPageUptodate(page);
> -
> -		if (count > PAGE_SIZE - offset)
> -			count -= PAGE_SIZE - offset;
> -		else
> -			count = 0;
> -		offset = 0;
> -
> -		unlock_page(page);
> +		if (err)
> +			ClearPageUptodate(page);
> +		if (page_locked)
> +			unlock_page(page);
>  		put_page(page);
>  	}
>  
> @@ -1191,6 +1186,16 @@ static ssize_t fuse_fill_write_pages(str
>  		if (offset == PAGE_SIZE)
>  			offset = 0;
>  
> +		/* If we copied full page, mark it uptodate */
> +		if (tmp == PAGE_SIZE)
> +			SetPageUptodate(page);
> +
> +		if (PageUptodate(page)) {
> +			unlock_page(page);
> +		} else {
> +			ap->page_locked = true;
> +			break;
> +		}
>  		if (!fc->big_writes)
>  			break;
>  	} while (iov_iter_count(ii) && count < fc->max_write &&
> --- a/fs/fuse/fuse_i.h
> +++ b/fs/fuse/fuse_i.h
> @@ -277,6 +277,7 @@ struct fuse_args_pages {
>  	struct page **pages;
>  	struct fuse_page_desc *descs;
>  	unsigned int num_pages;
> +	bool page_locked;
>  };
>  
>  #define FUSE_ARGS(args) struct fuse_args args = {}
> 


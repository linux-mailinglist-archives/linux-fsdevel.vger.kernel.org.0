Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D722A765C0A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Jul 2023 21:23:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231251AbjG0TXw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 Jul 2023 15:23:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231149AbjG0TXv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 Jul 2023 15:23:51 -0400
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C969268B
        for <linux-fsdevel@vger.kernel.org>; Thu, 27 Jul 2023 12:23:50 -0700 (PDT)
Received: by mail-yb1-xb34.google.com with SMTP id 3f1490d57ef6-d0548cf861aso1244007276.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 27 Jul 2023 12:23:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690485829; x=1691090629;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=3p55Sq7jOPOyztMgwNy28i6gxdMWDYbV2zRCVkaZOto=;
        b=Wj44Om9rKG337qfaoqNek+dwsW6frepjR1UGJOMg/1FCMzqBFifNdPcPRBDFpRsC+r
         SWWlcSfWx4A39OvqV8Fzs0i6HEBcBLtqv+jj7oms/GxCe5D3QAICKVlc4Q4xiXyXd7Bh
         HDmP7jiSSAfsp1QdKpksw4CJOCcT6DZ/DXPn6hD4XdXjL1fIlE9XixdqqLB+fsqmB6a8
         QQQEugaI34wzJTOX5tOC4ZFDdun96gc60Khp3ZZumpXuwKLHH1GLC8oVlOGnmsnI75T9
         4YJLXKFkte2bKZPAmdiWpRY9eKwH4uLEhjMrqI7UTGuYdagkrJz3Yod2HVz88u5g22vd
         Rd9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690485829; x=1691090629;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3p55Sq7jOPOyztMgwNy28i6gxdMWDYbV2zRCVkaZOto=;
        b=aELP8YOXqKop8KS2oIl/yAcYc4jtwNzIj5zGVQUDypqBXj0V3R1MxftML0fVGTgNPW
         rbsszmwcgk3ep3T31GYsPUURf/4MbqB1WXHb24PnVfOafn9BDJmJxgNCk3dt4Lms69Q6
         r/lLeBKzhDe5C99GxYVbafDxUcUNhRbNyrGmeAL/c+ARy5+qb7TuEU2xOgRlBHom23KV
         ARMgbJFA9nXmgWHnF/XVtOJXxtw0QnYhGx5yolbsMOmAxi6lhx2T+bXz1QRBoGCXmxWL
         ow9w358wzr7bZubBmY/YUvwb0o6gYl82Z0wEInWI5MP0iXeAIUKMHSTgsDFYwC91czhc
         JVjA==
X-Gm-Message-State: ABy/qLbkHUiTppERqUkC0AI6zl13NmYpo6PgJjB16EnHtPUSuyQ2BlYM
        zczY0xNHqDCGLKZKsWT5fa54Gw==
X-Google-Smtp-Source: APBJJlHy7zEq/TtzCz5Zjkh2FW+fxbAj2FT57ApWwlXXwTCIV6gmpUv/jH1vywotXR7udrz7isqt/w==
X-Received: by 2002:a25:260d:0:b0:d25:129e:8766 with SMTP id m13-20020a25260d000000b00d25129e8766mr311316ybm.29.1690485829111;
        Thu, 27 Jul 2023 12:23:49 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id f11-20020a5b0d4b000000b00d13b72fae3esm433941ybr.2.2023.07.27.12.23.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jul 2023 12:23:48 -0700 (PDT)
Date:   Thu, 27 Jul 2023 12:23:46 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.attlocal.net
To:     David Howells <dhowells@redhat.com>
cc:     Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Al Viro <viro@zeniv.linux.org.uk>,
        John Hubbard <jhubbard@nvidia.com>,
        David Hildenbrand <david@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH 2/2] shmem: Apply a couple of filemap_splice_read() fixes
 to shmem_splice_read()
In-Reply-To: <20230727161016.169066-3-dhowells@redhat.com>
Message-ID: <bd497349-1cce-7c29-8b8f-d95f10e534e6@google.com>
References: <20230727161016.169066-1-dhowells@redhat.com> <20230727161016.169066-3-dhowells@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, 27 Jul 2023, David Howells wrote:

> Fix shmem_splice_read() to use the inode from in->f_mapping->host rather
> than file_inode(in) and to skip the splice if it starts after s_maxbytes,
> analogously with fixes to filemap_splice_read().
> 
> Fixes: bd194b187115 ("shmem: Implement splice-read")
> Signed-off-by: David Howells <dhowells@redhat.com>

Thanks for trying to keep them in synch, but I already had to look into
both of these two "fixes" before sending my patch to Andrew, and neither
appears to be needed.

Neither of them does any harm either, but I think I'd prefer Andrew to
drop this patch from mm-unstable, just because it changes nothing.

Comment on each below...

> cc: Hugh Dickins <hughd@google.com>
> cc: Christoph Hellwig <hch@lst.de>
> cc: Jens Axboe <axboe@kernel.dk>
> cc: Al Viro <viro@zeniv.linux.org.uk>
> cc: John Hubbard <jhubbard@nvidia.com>
> cc: David Hildenbrand <david@redhat.com>
> cc: Matthew Wilcox <willy@infradead.org>
> cc: Chuck Lever <chuck.lever@oracle.com>
> cc: linux-block@vger.kernel.org
> cc: linux-fsdevel@vger.kernel.org
> cc: linux-mm@kvack.org
> ---
>  mm/shmem.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/shmem.c b/mm/shmem.c
> index 0164cccdcd71..8a16d4c7092b 100644
> --- a/mm/shmem.c
> +++ b/mm/shmem.c
> @@ -2780,13 +2780,16 @@ static ssize_t shmem_file_splice_read(struct file *in, loff_t *ppos,
>  				      struct pipe_inode_info *pipe,
>  				      size_t len, unsigned int flags)
>  {
> -	struct inode *inode = file_inode(in);
> +	struct inode *inode = in->f_mapping->host;

Haha, it's years and years since I had to worry about that distinction:
I noticed you'd made that change in filemap, and had to refresh old
memories, before concluding that this change is not needed.

shmem_file_splice_read() is specified only in shmem_file_operations,
and shmem_file_operations is connected up only when S_IFREG; so block
and char device nodes will not ever arrive at shmem_file_splice_read().

And shmem does not appear to be out of step there: I did not search
through many filesystems, but it appeared to be normal that only the
regular files reach the splice_read.

Which made me wonder whether the file_inode -> f_mapping->host
change was appropriate elsewhere.  Wouldn't the splice_read always
get called on the bd_inode?  Ah, perhaps not: init_special_inode()
sets i_fop to def_blk_fops (for shmem and everyone else), and that
points to filemap_splice_read(), which explains why just that one
needs to pivot to f_mapping->host (I think).

>  	struct address_space *mapping = inode->i_mapping;
>  	struct folio *folio = NULL;
>  	size_t total_spliced = 0, used, npages, n, part;
>  	loff_t isize;
>  	int error = 0;
>  
> +	if (unlikely(*ppos >= inode->i_sb->s_maxbytes))
> +		return 0;
> +
>  	/* Work out how much data we can actually add into the pipe */
>  	used = pipe_occupancy(pipe->head, pipe->tail);
>  	npages = max_t(ssize_t, pipe->max_usage - used, 0);
	len = min_t(size_t, len, npages * PAGE_SIZE);

	do {
		if (*ppos >= i_size_read(inode))
			break;

I've added to the context there, to show that the very first thing the
do loop does is check *ppos against i_size: so there's no need for that
preliminary check against s_maxbytes - something would be wrong already
if the file has grown beyond s_maxbytes.

So, thanks for the patch, but shmem does not need it.

Hugh

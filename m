Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D93470B314
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 May 2023 04:14:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231565AbjEVCN6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 21 May 2023 22:13:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229922AbjEVCNy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 21 May 2023 22:13:54 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C45D0D7
        for <linux-fsdevel@vger.kernel.org>; Sun, 21 May 2023 19:13:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684721585;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gmNRxdDl0Iw5312gWw2B9QxJef2rV33yjDNEcMTuktQ=;
        b=FecRXxbkx62KzroVxTrzJCt3PijTTejOXLp3rRNrxrNWdIYSRoyYypiNrl79z0PsOr46Wt
        gZcCkGCWLOtDpHw4yzxxfW7JgI5C34tZFPHO13zqC/V3bWKwhgZwBPM2ZDUGe7B8IeVrfA
        nPArh+UXjebaoQ+asfEZL0+8OhSC89Q=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-26-GGXTQ4AkM5-kdJOAigCu7A-1; Sun, 21 May 2023 22:13:03 -0400
X-MC-Unique: GGXTQ4AkM5-kdJOAigCu7A-1
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-53450fa3a18so4696729a12.0
        for <linux-fsdevel@vger.kernel.org>; Sun, 21 May 2023 19:13:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684721582; x=1687313582;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gmNRxdDl0Iw5312gWw2B9QxJef2rV33yjDNEcMTuktQ=;
        b=MS8BadmD0D51AmGl+ft2xtQQV3QPou82a0gIvi81f4qsNpjggkFbwUtbRpjluInuSY
         5MBI1Mj3FHVNhkf/6P3hULQ4cojwLcYwXlux26j9gNFZY9P844pg5Tn0c6Z3Q1k0hYWM
         f1bchD7t1OM8qQ6/A2pLtTbdYvc3K049r8VTbNlYhbNygrM3lOeNyghycrWPgSMyl7Fs
         LbHgPOGedzSc7YI+hMKsLTX/WrhkqGu7A1cPwKDE7a4cSyN0fn4tGE+PkfjbCC/7Jrcx
         SUnB+afN7JGWeNbjZ8qLXDbpwdlFdJ44JAbLlcm9tOUHjVIxKQxnlkhUSLOw3cqE1RTZ
         pK8g==
X-Gm-Message-State: AC+VfDzlAia7MHAEUwJNwjc4yRgXbRZmMuO9X6OvX0GgxVsEbF5T6Z4d
        4EZzGSHDhuJv0am9pATM59gqHtejEc360tIZqESTvRl8xhHqkqBjD8MFwC9Euee3ymgCB3qLLCp
        cuQxbvgiHQ+xQDdFYDxdEkw2egQ==
X-Received: by 2002:a05:6a20:5483:b0:10b:e90d:13a2 with SMTP id i3-20020a056a20548300b0010be90d13a2mr590813pzk.36.1684721582486;
        Sun, 21 May 2023 19:13:02 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4edrM21wwKnQnIY2WKOKek3wiSXXo/hL8jRVd6QZLFCn+oldEoDVlQ950aoB0pemRSWszePg==
X-Received: by 2002:a05:6a20:5483:b0:10b:e90d:13a2 with SMTP id i3-20020a056a20548300b0010be90d13a2mr590790pzk.36.1684721582215;
        Sun, 21 May 2023 19:13:02 -0700 (PDT)
Received: from [10.72.12.68] ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id i9-20020aa79089000000b0064559b58eb8sm3081025pfa.154.2023.05.21.19.12.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 21 May 2023 19:13:01 -0700 (PDT)
Message-ID: <fa54e41d-86fe-1e63-a6fc-85c19985b3e9@redhat.com>
Date:   Mon, 22 May 2023 10:12:49 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v21 16/30] ceph: Provide a splice-read stub
Content-Language: en-US
To:     David Howells <dhowells@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>
Cc:     Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Hillf Danton <hdanton@sina.com>,
        Christian Brauner <brauner@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Christoph Hellwig <hch@lst.de>,
        Ilya Dryomov <idryomov@gmail.com>, ceph-devel@vger.kernel.org
References: <20230520000049.2226926-1-dhowells@redhat.com>
 <20230520000049.2226926-17-dhowells@redhat.com>
From:   Xiubo Li <xiubli@redhat.com>
In-Reply-To: <20230520000049.2226926-17-dhowells@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 5/20/23 08:00, David Howells wrote:
> Provide a splice_read stub for Ceph.  This does the inode shutdown check
> before proceeding and jumps to copy_splice_read() if the file has inline
> data or is a synchronous file.
>
> We try and get FILE_RD and either FILE_CACHE and/or FILE_LAZYIO caps and
> hold them across filemap_splice_read().  If we fail to get FILE_CACHE or
> FILE_LAZYIO capabilities, we use copy_splice_read() instead.
>
> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: Christoph Hellwig <hch@lst.de>
> cc: Al Viro <viro@zeniv.linux.org.uk>
> cc: Jens Axboe <axboe@kernel.dk>
> cc: Xiubo Li <xiubli@redhat.com>
> cc: Ilya Dryomov <idryomov@gmail.com>
> cc: Jeff Layton <jlayton@kernel.org>
> cc: ceph-devel@vger.kernel.org
> cc: linux-fsdevel@vger.kernel.org
> cc: linux-block@vger.kernel.org
> cc: linux-mm@kvack.org
> ---
>
> Notes:
>      ver #21)
>       - Need to drop the caps ref.
>       - O_DIRECT is handled by the caller.
>
>   fs/ceph/file.c | 65 +++++++++++++++++++++++++++++++++++++++++++++++++-
>   1 file changed, 64 insertions(+), 1 deletion(-)
>
> diff --git a/fs/ceph/file.c b/fs/ceph/file.c
> index f4d8bf7dec88..4285f6cb5d3b 100644
> --- a/fs/ceph/file.c
> +++ b/fs/ceph/file.c
> @@ -1745,6 +1745,69 @@ static ssize_t ceph_read_iter(struct kiocb *iocb, struct iov_iter *to)
>   	return ret;
>   }
>   
> +/*
> + * Wrap filemap_splice_read with checks for cap bits on the inode.
> + * Atomically grab references, so that those bits are not released
> + * back to the MDS mid-read.
> + */
> +static ssize_t ceph_splice_read(struct file *in, loff_t *ppos,
> +				struct pipe_inode_info *pipe,
> +				size_t len, unsigned int flags)
> +{
> +	struct ceph_file_info *fi = in->private_data;
> +	struct inode *inode = file_inode(in);
> +	struct ceph_inode_info *ci = ceph_inode(inode);
> +	ssize_t ret;
> +	int want = 0, got = 0;
> +	CEPH_DEFINE_RW_CONTEXT(rw_ctx, 0);
> +
> +	dout("splice_read %p %llx.%llx %llu~%zu trying to get caps on %p\n",
> +	     inode, ceph_vinop(inode), *ppos, len, inode);
> +
> +	if (ceph_inode_is_shutdown(inode))
> +		return -ESTALE;
> +
> +	if (ceph_has_inline_data(ci) ||
> +	    (fi->flags & CEPH_F_SYNC))
> +		return copy_splice_read(in, ppos, pipe, len, flags);
> +
> +	ceph_start_io_read(inode);
> +
> +	want = CEPH_CAP_FILE_CACHE;
> +	if (fi->fmode & CEPH_FILE_MODE_LAZY)
> +		want |= CEPH_CAP_FILE_LAZYIO;
> +
> +	ret = ceph_get_caps(in, CEPH_CAP_FILE_RD, want, -1, &got);
> +	if (ret < 0)
> +		goto out_end;
> +
> +	if ((got & (CEPH_CAP_FILE_CACHE | CEPH_CAP_FILE_LAZYIO)) == 0) {
> +		dout("splice_read/sync %p %llx.%llx %llu~%zu got cap refs on %s\n",
> +		     inode, ceph_vinop(inode), *ppos, len,
> +		     ceph_cap_string(got));
> +
> +		ceph_put_cap_refs(ci, got);
> +		ceph_end_io_read(inode);
> +		return copy_splice_read(in, ppos, pipe, len, flags);
> +	}
> +
> +	dout("splice_read %p %llx.%llx %llu~%zu got cap refs on %s\n",
> +	     inode, ceph_vinop(inode), *ppos, len, ceph_cap_string(got));
> +
> +	rw_ctx.caps = got;
> +	ceph_add_rw_context(fi, &rw_ctx);
> +	ret = filemap_splice_read(in, ppos, pipe, len, flags);
> +	ceph_del_rw_context(fi, &rw_ctx);
> +
> +	dout("splice_read %p %llx.%llx dropping cap refs on %s = %zd\n",
> +	     inode, ceph_vinop(inode), ceph_cap_string(got), ret);
> +
> +	ceph_put_cap_refs(ci, got);
> +out_end:
> +	ceph_end_io_read(inode);
> +	return ret;
> +}
> +
>   /*
>    * Take cap references to avoid releasing caps to MDS mid-write.
>    *
> @@ -2593,7 +2656,7 @@ const struct file_operations ceph_file_fops = {
>   	.lock = ceph_lock,
>   	.setlease = simple_nosetlease,
>   	.flock = ceph_flock,
> -	.splice_read = generic_file_splice_read,
> +	.splice_read = ceph_splice_read,
>   	.splice_write = iter_file_splice_write,
>   	.unlocked_ioctl = ceph_ioctl,
>   	.compat_ioctl = compat_ptr_ioctl,
>
LGTM.

Reviewed-by: Xiubo Li <xiubli@redhat.com>

Thanks

- Xiubo



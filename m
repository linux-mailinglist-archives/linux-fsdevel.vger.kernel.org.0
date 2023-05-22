Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F2D870B321
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 May 2023 04:21:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230050AbjEVCV5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 21 May 2023 22:21:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbjEVCV4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 21 May 2023 22:21:56 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1EBBE6
        for <linux-fsdevel@vger.kernel.org>; Sun, 21 May 2023 19:21:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684722072;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pl1j2Mo02M1sQGfGs/DUFoRb8smUY2ZG1V4PFyySeOU=;
        b=fbd4cgGzbe98ztRge+XfdGtAWX2YqD5beTYIX49/jCNCUxqhA3Yy8xfo1a3qMvmUPaESSk
        NvgewWFtXseGu8CgwxHc+P7hr+B9ldfb+CJ1UqISOMgXqxFTRMXYr7yBW7oe+oLXWpnAiH
        OGWqhnUksokunDDGa4VHEAC1+65gJPQ=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-206-75hcuVNBN_GyWEHhSMnhcA-1; Sun, 21 May 2023 22:21:11 -0400
X-MC-Unique: 75hcuVNBN_GyWEHhSMnhcA-1
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-5348c950d03so1461408a12.1
        for <linux-fsdevel@vger.kernel.org>; Sun, 21 May 2023 19:21:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684722070; x=1687314070;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pl1j2Mo02M1sQGfGs/DUFoRb8smUY2ZG1V4PFyySeOU=;
        b=Qi3iOiaDwXBFNuzxaOxMFEgvbuGbri2fGEKZXG9a9lJbGaDUjSigZ7a/kJhGOcto1+
         eslzW9HmsVLITp8DjZH9zSmCTYLO6RtGX+Gfac4bUXqUxgOZoZFDkGbqoRpRnUeq2yK3
         KKGBKYiqEwkIIQXVqKIMkZvlggfNZvhdjUfCgqS6/laI3mzjJ93M7YhEPDZsfeK8aM0J
         oo/sxM9z8tE0Pvr+4ePMjPWFykMNDCK9YK9qXoWkM3V/Qj3JjzmT52c7OHgQorYcs4MH
         zDLm5oW2aSmi5g/+jUI3ICn1awAHazf0W8Je1oGr2onM3jt2FyJm2jW5dDh7Nm0Rngho
         7aQw==
X-Gm-Message-State: AC+VfDxQxfnT9rLPCdEwI2s6Gxsyyd/rFuCUvSXMrIOGjze4qqpP4GTd
        YmKDj2lqJPtfzqwFfNIWpY9D5Z03BG3+8yHucteBFQG/S330ZU/1Cnxkxfg+gq7p4Tn4AE6lEd0
        t7UX7hSdy72+GGukZz7pJpVB/Vw==
X-Received: by 2002:a17:902:ab14:b0:1ac:71a7:a1fb with SMTP id ik20-20020a170902ab1400b001ac71a7a1fbmr9173001plb.18.1684722070542;
        Sun, 21 May 2023 19:21:10 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5vgpUHg5KMr5fvVKnKuCGiBu82Kta1T/m+fZ4YXIOR/n75V5hEd2a8qnobD9FuM9h7/ryidw==
X-Received: by 2002:a17:902:ab14:b0:1ac:71a7:a1fb with SMTP id ik20-20020a170902ab1400b001ac71a7a1fbmr9172986plb.18.1684722070171;
        Sun, 21 May 2023 19:21:10 -0700 (PDT)
Received: from [10.72.12.68] ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id az8-20020a170902a58800b001ae44cd96besm3520183plb.135.2023.05.21.19.20.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 21 May 2023 19:21:08 -0700 (PDT)
Message-ID: <745e2a68-ed19-dc3d-803a-a7d1d47903dd@redhat.com>
Date:   Mon, 22 May 2023 10:20:56 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 02/13] filemap: update ki_pos in generic_perform_write
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>,
        Matthew Wilcox <willy@infradead.org>
Cc:     Jens Axboe <axboe@kernel.dk>, Ilya Dryomov <idryomov@gmail.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        Theodore Ts'o <tytso@mit.edu>,
        Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>,
        Damien Le Moal <dlemoal@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-block@vger.kernel.org, ceph-devel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        "open list:F2FS FILE SYSTEM" <linux-f2fs-devel@lists.sourceforge.net>,
        cluster-devel@redhat.com, linux-xfs@vger.kernel.org,
        linux-nfs@vger.kernel.org, linux-mm@kvack.org
References: <20230519093521.133226-1-hch@lst.de>
 <20230519093521.133226-3-hch@lst.de>
From:   Xiubo Li <xiubli@redhat.com>
In-Reply-To: <20230519093521.133226-3-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 5/19/23 17:35, Christoph Hellwig wrote:
> All callers of generic_perform_write need to updated ki_pos, move it into
> common code.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   fs/ceph/file.c | 2 --
>   fs/ext4/file.c | 9 +++------
>   fs/f2fs/file.c | 1 -
>   fs/nfs/file.c  | 1 -
>   mm/filemap.c   | 8 ++++----
>   5 files changed, 7 insertions(+), 14 deletions(-)
>
> diff --git a/fs/ceph/file.c b/fs/ceph/file.c
> index f4d8bf7dec88a8..feeb9882ef635a 100644
> --- a/fs/ceph/file.c
> +++ b/fs/ceph/file.c
> @@ -1894,8 +1894,6 @@ static ssize_t ceph_write_iter(struct kiocb *iocb, struct iov_iter *from)
>   		 * can not run at the same time
>   		 */
>   		written = generic_perform_write(iocb, from);
> -		if (likely(written >= 0))
> -			iocb->ki_pos = pos + written;
>   		ceph_end_io_write(inode);
>   	}
>   
> diff --git a/fs/ext4/file.c b/fs/ext4/file.c
> index d101b3b0c7dad8..50824831d31def 100644
> --- a/fs/ext4/file.c
> +++ b/fs/ext4/file.c
> @@ -291,12 +291,9 @@ static ssize_t ext4_buffered_write_iter(struct kiocb *iocb,
>   
>   out:
>   	inode_unlock(inode);
> -	if (likely(ret > 0)) {
> -		iocb->ki_pos += ret;
> -		ret = generic_write_sync(iocb, ret);
> -	}
> -
> -	return ret;
> +	if (unlikely(ret <= 0))
> +		return ret;
> +	return generic_write_sync(iocb, ret);
>   }
>   
>   static ssize_t ext4_handle_inode_extension(struct inode *inode, loff_t offset,
> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> index 5ac53d2627d20d..9e3855e43a7a63 100644
> --- a/fs/f2fs/file.c
> +++ b/fs/f2fs/file.c
> @@ -4522,7 +4522,6 @@ static ssize_t f2fs_buffered_write_iter(struct kiocb *iocb,
>   	current->backing_dev_info = NULL;
>   
>   	if (ret > 0) {
> -		iocb->ki_pos += ret;
>   		f2fs_update_iostat(F2FS_I_SB(inode), inode,
>   						APP_BUFFERED_IO, ret);
>   	}
> diff --git a/fs/nfs/file.c b/fs/nfs/file.c
> index f0edf5a36237d1..3cc87ae8473356 100644
> --- a/fs/nfs/file.c
> +++ b/fs/nfs/file.c
> @@ -658,7 +658,6 @@ ssize_t nfs_file_write(struct kiocb *iocb, struct iov_iter *from)
>   		goto out;
>   
>   	written = result;
> -	iocb->ki_pos += written;
>   	nfs_add_stats(inode, NFSIOS_NORMALWRITTENBYTES, written);
>   
>   	if (mntflags & NFS_MOUNT_WRITE_EAGER) {
> diff --git a/mm/filemap.c b/mm/filemap.c
> index b4c9bd368b7e58..4d0ec2fa1c7070 100644
> --- a/mm/filemap.c
> +++ b/mm/filemap.c
> @@ -3957,7 +3957,10 @@ ssize_t generic_perform_write(struct kiocb *iocb, struct iov_iter *i)
>   		balance_dirty_pages_ratelimited(mapping);
>   	} while (iov_iter_count(i));
>   
> -	return written ? written : status;
> +	if (!written)
> +		return status;
> +	iocb->ki_pos += written;
> +	return written;
>   }
>   EXPORT_SYMBOL(generic_perform_write);
>   
> @@ -4036,7 +4039,6 @@ ssize_t __generic_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
>   		endbyte = pos + status - 1;
>   		err = filemap_write_and_wait_range(mapping, pos, endbyte);
>   		if (err == 0) {
> -			iocb->ki_pos = endbyte + 1;
>   			written += status;
>   			invalidate_mapping_pages(mapping,
>   						 pos >> PAGE_SHIFT,
> @@ -4049,8 +4051,6 @@ ssize_t __generic_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
>   		}
>   	} else {
>   		written = generic_perform_write(iocb, from);
> -		if (likely(written > 0))
> -			iocb->ki_pos += written;
>   	}
>   out:
>   	current->backing_dev_info = NULL;

LGTM.

Reviewed-by: Xiubo Li <xiubli@redhat.com>

Thanks

- Xiubo



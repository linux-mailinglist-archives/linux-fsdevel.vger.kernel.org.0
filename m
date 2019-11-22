Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EB171106B12
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Nov 2019 11:42:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728973AbfKVKlD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 Nov 2019 05:41:03 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:37593 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728968AbfKVKlC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 Nov 2019 05:41:02 -0500
Received: by mail-wm1-f67.google.com with SMTP id f129so5669738wmf.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 22 Nov 2019 02:41:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=scylladb-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=aNGN891yZLYLO77V9MqSHkSbnhVDGGcgyxBVb5KylA8=;
        b=ODFa1XyAjClvGYMbe5SfFY7xmQprV1iyNVzfjtCmH4DGk2JNKy3NX8xIkGfk+hkBzz
         R3ipC3ZXpud9WnIXdBPOdMtEd9Bn/jSRaLUEImVH/2bqHKNAZyigbYS6xZkmX7uo0ojE
         guA6XGqL2Lt6rLGoO7IMjZmQqxnxXpc8uD8F+NJsV5j6N0Q8ivbwUDlb9oNt50wgQhKy
         KPT0S5muaf+X6khZSfkplRy2F3eRlXuI5xQdsWnsr49GWsN/5aEydJ1p98kuttlkT0by
         RsHTHyRwQRxnRFSy0+15Yd/rtw5qIBOYfdmL1QaKlslsFxXbEU8sStA4GK/J2ra04DwW
         Bwcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=aNGN891yZLYLO77V9MqSHkSbnhVDGGcgyxBVb5KylA8=;
        b=j9PxJJ0xYPCtaeLr1iDpQcpR8JsuevAOc/3pf+wKwcZHBx5g+QMa4uDN59A7BBQsQE
         1M+FrLj0mHjKAXtQc8I/iDFhQiJCobFA4CBosMXIwg08pB8WrVeBXm6jepNva2ZQO1r8
         uQTC8bOtuNGnmLXnPbexKtijI/ZMCA5TvmpswcNe8EkI7VNMddphpgF6W3LKlsHqM1gp
         CPZ3VA4FlHKNt8lS3kq17pB53NxbtqA/IDoKbt1givlR8VdJh1J2jxsrJgz6lnsnNoX5
         iAl8ihNMXvWoixehDGbQqRZKxjgDocubBEs4/T9eNRvuACNw/BXPnzC58kPvQVMhnQm7
         jsGQ==
X-Gm-Message-State: APjAAAUQOrtpCgZaiN04/0XQQiXoU5TvOhEGBOwEqFs+eiSvQzgX87MB
        JOBrrKUgm3SVpiz7+L2NA8LjTw==
X-Google-Smtp-Source: APXvYqys74lf/1xgRjXgKDEuVLPZ74jZij9wDnFmfnhEDnUiiaXHYYlx2sjOX/cKCb0vmMBYaY+oVg==
X-Received: by 2002:a7b:c1ca:: with SMTP id a10mr16713832wmj.161.1574419260412;
        Fri, 22 Nov 2019 02:41:00 -0800 (PST)
Received: from tmp.scylladb.com (bzq-109-67-4-68.red.bezeqint.net. [109.67.4.68])
        by smtp.googlemail.com with ESMTPSA id y6sm7307864wrl.17.2019.11.22.02.40.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Nov 2019 02:40:59 -0800 (PST)
Subject: Re: [PATCH] aio: fix async fsync creds
To:     Miklos Szeredi <miklos@szeredi.hu>,
        Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>,
        Jens Axboe <axboe@kernel.dk>,
        Giuseppe Scrivano <gscrivan@redhat.com>
References: <20191122103438.GC5569@miu.piliscsaba.redhat.com>
From:   Avi Kivity <avi@scylladb.com>
Message-ID: <26f0d78e-99ca-2f1b-78b9-433088053a61@scylladb.com>
Date:   Fri, 22 Nov 2019 12:40:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191122103438.GC5569@miu.piliscsaba.redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 11/22/19 12:34 PM, Miklos Szeredi wrote:
> From: Miklos Szeredi <mszeredi@redhat.com>
>
> Avi Kivity reports that on fuse filesystems running in a user namespace
> asyncronous fsync fails with EOVERFLOW.
>
> The reason is that f_ops->fsync() is called with the creds of the kthread
> performing aio work instead of the creds of the process originally
> submitting IOCB_CMD_FSYNC.
>
> Fuse sends the creds of the caller in the request header and it needs to
> translate the uid and gid into the server's user namespace.  Since the
> kthread is running in init_user_ns, the translation will fail and the
> operation returns an error.
>
> It can be argued that fsync doesn't actually need any creds, but just
> zeroing out those fields in the header (as with requests that currently
> don't take creds) is a backward compatibility risk.
>
> Instead of working around this issue in fuse, solve the core of the problem
> by calling the filesystem with the proper creds.
>
> Reported-by: Avi Kivity <avi@scylladb.com>
> Tested-by: Giuseppe Scrivano <gscrivan@redhat.com>
> Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>


May I suggest


     Cc: stable@vger.kernel.org  # 4.18+


?


> ---
>   fs/aio.c |    8 ++++++++
>   1 file changed, 8 insertions(+)
>
> --- a/fs/aio.c
> +++ b/fs/aio.c
> @@ -176,6 +176,7 @@ struct fsync_iocb {
>   	struct file		*file;
>   	struct work_struct	work;
>   	bool			datasync;
> +	struct cred		*creds;
>   };
>   
>   struct poll_iocb {
> @@ -1589,8 +1590,11 @@ static int aio_write(struct kiocb *req,
>   static void aio_fsync_work(struct work_struct *work)
>   {
>   	struct aio_kiocb *iocb = container_of(work, struct aio_kiocb, fsync.work);
> +	const struct cred *old_cred = override_creds(iocb->fsync.creds);
>   
>   	iocb->ki_res.res = vfs_fsync(iocb->fsync.file, iocb->fsync.datasync);
> +	revert_creds(old_cred);
> +	put_cred(iocb->fsync.creds);
>   	iocb_put(iocb);
>   }
>   
> @@ -1604,6 +1608,10 @@ static int aio_fsync(struct fsync_iocb *
>   	if (unlikely(!req->file->f_op->fsync))
>   		return -EINVAL;
>   
> +	req->creds = prepare_creds();
> +	if (!req->creds)
> +		return -ENOMEM;
> +
>   	req->datasync = datasync;
>   	INIT_WORK(&req->work, aio_fsync_work);
>   	schedule_work(&req->work);



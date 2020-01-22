Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A6C141449A9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Jan 2020 03:03:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728901AbgAVCDh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 21 Jan 2020 21:03:37 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:39613 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726968AbgAVCDh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 21 Jan 2020 21:03:37 -0500
Received: by mail-pg1-f193.google.com with SMTP id 4so2561247pgd.6
        for <linux-fsdevel@vger.kernel.org>; Tue, 21 Jan 2020 18:03:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=e7FwBWIW8IGtpE9uyvgf8eUHJH2AGbivzVpzVQ32h1g=;
        b=mXRfAoPG6gsQGH8Kykj/OE9p6Y3BEqyAjZ36/fFGQmG0goZBr5FysQSt/5rc08WUp2
         uA0Exk/eK3fFyHtQgYEMULf/p5OJIVxBazrY8JkDMQ+X6QpTOQFq4axKKEcegoXE76FD
         Q3tf5ceTt+0b/GotcgOVVqnyua/QyCM4ZY3nk6vYlpNFpjEK6H8yRRFy3sHEoc3rE/HQ
         rbDY9LV6tzK2Sbz33tRTXgwN+ayvNAsmI7fCigbSnLSgnmBQoQwAqhOwx9OwOF0qjR69
         m3cGhcoddJPZWj1VBN//5dToYRb8N4T6rfZ4Lu0uuDvwOU8vFzIdaNN5wIOTzaiaV5Tn
         Ofjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=e7FwBWIW8IGtpE9uyvgf8eUHJH2AGbivzVpzVQ32h1g=;
        b=XOr/8CgBbDSg/nH0r1IQsbuURExTGcdUE/QxOlUfqkpL1YciKcNaJVg1Qb4jlomBLU
         uAccFdF0MgYfxRDNwJ1FV0NqSMsqdu2brmwKinKfn7ElswO6KplFr3NOojLSgz5zlitn
         zak5anBgG78IqUfKVmcdh1F0tuROc7kUTMyz3zkdYEgi+B36/6XT+S6pZG1JkF7lJffB
         B7Fyt0SoWYIamrMmFk4os8dQUrCKpIx1C8DIO+kPpc6q53RaUzvTSl05rSLpbkKSBooh
         yVPk+pwNeQ9QT6pHHHogQk72zKcKdSAGCkWAp47NLUAaJ5aRZuxOpY6Da8lUb6O4L2Cq
         do2w==
X-Gm-Message-State: APjAAAUSro8wPB6cM5o+2MxDnkx1SQHQ01GXgfUSo5pE+8E3nLnbY4PI
        G4eEcqemdc8kg4CG5Aqijc2jBQ==
X-Google-Smtp-Source: APXvYqxtLnnOkMqzi99/d09pO1vOn30qGYYwyeZzbV4j3PrOvgJUDqmYarLWlLl55hSUd2jARYLtGg==
X-Received: by 2002:a62:2a49:: with SMTP id q70mr444040pfq.170.1579658616244;
        Tue, 21 Jan 2020 18:03:36 -0800 (PST)
Received: from [192.168.1.188] ([66.219.217.145])
        by smtp.gmail.com with ESMTPSA id q12sm43794842pfh.158.2020.01.21.18.03.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Jan 2020 18:03:35 -0800 (PST)
Subject: Re: [PATCH 3/3] io_uring: add splice(2) support
To:     Pavel Begunkov <asml.silence@gmail.com>, io-uring@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>
References: <cover.1579649589.git.asml.silence@gmail.com>
 <8bfd9a57bf42cfc10ee7195969058d6da277deed.1579649589.git.asml.silence@gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <6d43b9d7-209a-2bbf-e2c2-e125e84b46ab@kernel.dk>
Date:   Tue, 21 Jan 2020 19:03:33 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <8bfd9a57bf42cfc10ee7195969058d6da277deed.1579649589.git.asml.silence@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 1/21/20 5:05 PM, Pavel Begunkov wrote:
> @@ -373,6 +374,15 @@ struct io_rw {
>  	u64				len;
>  };
>  
> +struct io_splice {
> +	struct file			*file_in;
> +	struct file			*file_out;
> +	loff_t __user			*off_in;
> +	loff_t __user			*off_out;
> +	u64				len;
> +	unsigned int			flags;
> +};
> +
>  struct io_connect {
>  	struct file			*file;
>  	struct sockaddr __user		*addr;

Probably just make that len u32 as per previous email.

> @@ -719,6 +730,11 @@ static const struct io_op_def io_op_defs[] = {
>  		.needs_file		= 1,
>  		.fd_non_neg		= 1,
>  	},
> +	[IORING_OP_SPLICE] = {
> +		.needs_file		= 1,
> +		.hash_reg_file		= 1,
> +		.unbound_nonreg_file	= 1,
> +	}
>  };
>  
>  static void io_wq_submit_work(struct io_wq_work **workptr);

I probably want to queue up a reservation for the EPOLL_CTL that I
haven't included yet, but which has been tested. But that's easily
manageable, so no biggy on my end.

> +static bool io_splice_punt(struct file *file)
> +{
> +	if (get_pipe_info(file))
> +		return false;
> +	if (!io_file_supports_async(file))
> +		return true;
> +	return !(file->f_mode & O_NONBLOCK);
> +}
> +
> +static int io_splice(struct io_kiocb *req, struct io_kiocb **nxt,
> +		     bool force_nonblock)
> +{
> +	struct io_splice* sp = &req->splice;
> +	struct file *in = sp->file_in;
> +	struct file *out = sp->file_out;
> +	unsigned int flags = sp->flags;
> +	long ret;
> +
> +	if (force_nonblock) {
> +		if (io_splice_punt(in) || io_splice_punt(out)) {
> +			req->flags |= REQ_F_MUST_PUNT;
> +			return -EAGAIN;
> +		}
> +		flags |= SPLICE_F_NONBLOCK;
> +	}
> +
> +	ret = do_splice(in, sp->off_in, out, sp->off_out, sp->len, flags);
> +	if (force_nonblock && ret == -EAGAIN)
> +		return -EAGAIN;
> +
> +	io_put_file(req->ctx, out, (flags & IOSQE_SPLICE_FIXED_OUT));
> +	io_cqring_add_event(req, ret);
> +	if (ret != sp->len)
> +		req_set_fail_links(req);
> +	io_put_req_find_next(req, nxt);
> +	return 0;
> +}

This looks good. And this is why the put_file() needs to take separate
arguments...

> diff --git a/include/uapi/linux/io_uring.h b/include/uapi/linux/io_uring.h
> index 57d05cc5e271..f234b13e7ed3 100644
> --- a/include/uapi/linux/io_uring.h
> +++ b/include/uapi/linux/io_uring.h
> @@ -23,8 +23,14 @@ struct io_uring_sqe {
>  		__u64	off;	/* offset into file */
>  		__u64	addr2;
>  	};
> -	__u64	addr;		/* pointer to buffer or iovecs */
> -	__u32	len;		/* buffer size or number of iovecs */
> +	union {
> +		__u64	addr;		/* pointer to buffer or iovecs */
> +		__u64	off_out;
> +	};
> +	union {
> +		__u32	len;	/* buffer size or number of iovecs */
> +		__s32	fd_out;
> +	};
>  	union {
>  		__kernel_rwf_t	rw_flags;
>  		__u32		fsync_flags;
> @@ -37,10 +43,12 @@ struct io_uring_sqe {
>  		__u32		open_flags;
>  		__u32		statx_flags;
>  		__u32		fadvise_advice;
> +		__u32		splice_flags;
>  	};
>  	__u64	user_data;	/* data to be passed back at completion time */
>  	union {
>  		__u16	buf_index;	/* index into fixed buffers, if used */
> +		__u64	splice_len;
>  		__u64	__pad2[3];
>  	};
>  };

Not a huge fan of this, also mean splice can't ever used fixed buffers.
Hmm...

> @@ -67,6 +75,9 @@ enum {
>  /* always go async */
>  #define IOSQE_ASYNC		(1U << IOSQE_ASYNC_BIT)
>  
> +/* op custom flags */
> +#define IOSQE_SPLICE_FIXED_OUT	(1U << 16)
> +

I don't think it's unreasonable to say that if you specify
IOSQE_FIXED_FILE, then both are fixed. If not, then none of them are.
What do you think?

-- 
Jens Axboe


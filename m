Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EF081CA11C
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 May 2020 04:53:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727032AbgEHCxb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 7 May 2020 22:53:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726598AbgEHCxa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 7 May 2020 22:53:30 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DEAEC05BD09
        for <linux-fsdevel@vger.kernel.org>; Thu,  7 May 2020 19:53:29 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id hi11so3581669pjb.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 07 May 2020 19:53:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=um3mI9LmYrUvelmN4ru3INCNryFm6dnCjlmdCTLr9ao=;
        b=TVVEgyyqm/kK9/OemwN+zgXn3on4bbRKhx3Cy38nRns+DTL5BXOau4BfM1OMRb4hmi
         U64R4g5JdBSU6iz4WjA+sXyDG+orAwaPmDyNvDbOmzqvbcRjk0p1P23HP5GFKEzR9tWw
         fyLGOswEQM1RTh/RdnE8asYdThCIRO3gihQL2WI3TdpExiz5thCBkXoo1x1jV/8E61MC
         toEHulgivJUVJtpG50zDFpv+GKuZgFCtDpk0Tqrwwkz4XW595+BpJfWvJLQfvT9siHyJ
         Kkmv7lmFKVWV+hdW5fjTnB9bSxaGfCtewe1W40/1EZvvFD91KjXjiSFyW7z/k1cvVB/v
         BRpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=um3mI9LmYrUvelmN4ru3INCNryFm6dnCjlmdCTLr9ao=;
        b=ESO0tAuPNRn96180CwXwKnUeT7hVIx1/aEhpeWesAqyvunnMN0i9pBwGtqUH7/Zrb/
         2/s/3QqAjhxmdrz2JMUuFBioerxezOCysuVq7SNoR2WgRRwCLb+Nf0XzSxSaOUw3TDFx
         YpWDw/qkEjnZjb/foV7RRA03a/g2An7IK1pfSVThstYTpgTvHvtFiGkhSKfMbTjEj2hD
         CCK9H5AKP7qI3/vSkVqbPh1g+hO+j8Jr/7bW5vozhNi7L+nmVZ0edNc3jO/koY6SKdl3
         mQzQdAWXgHQl4kvUKTBveAo6XnW2wyzJG4CI7reJIxhbv3NHF+BZG3J7bsRnyVkBbXoo
         eXIw==
X-Gm-Message-State: AGi0PuYB04LROvWanilkkOXIjYRS6n3FVghgdNb+XweTkb3dkU+mnwuR
        2X3rPsuebV3YIg/lbWE0zBw4eg==
X-Google-Smtp-Source: APiQypKy9TgJamBvSmsR9YdO8pkJvhKSJM26xMFwf1LATbkMrBLCPemDgtow7vBHH/1jeMKYcVZU7A==
X-Received: by 2002:a17:90a:2843:: with SMTP id p3mr3333214pjf.204.1588906408379;
        Thu, 07 May 2020 19:53:28 -0700 (PDT)
Received: from [192.168.1.188] ([66.219.217.145])
        by smtp.gmail.com with ESMTPSA id d12sm179788pfq.36.2020.05.07.19.53.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 May 2020 19:53:27 -0700 (PDT)
Subject: Re: [PATCH] fs/io_uring: fix O_PATH fds in openat, openat2, statx
From:   Jens Axboe <axboe@kernel.dk>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Max Kellermann <mk@cm4all.com>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20200507185725.15840-1-mk@cm4all.com>
 <20200507190131.GF23230@ZenIV.linux.org.uk>
 <4cac0e53-656c-50f0-3766-ae3cc6c0310a@kernel.dk>
 <20200507192903.GG23230@ZenIV.linux.org.uk>
 <8e3c88cc-027b-4f90-b4f8-a20d11d35c4b@kernel.dk>
 <20200507220637.GH23230@ZenIV.linux.org.uk>
 <283c8edb-fea2-5192-f1d6-3cc57815b1e2@kernel.dk>
 <20200507224447.GI23230@ZenIV.linux.org.uk>
 <e16125f2-c3ec-f029-c607-19bede54fa17@kernel.dk>
 <20200507233132.GJ23230@ZenIV.linux.org.uk>
 <629de3b6-cf80-fe37-1dde-7f0464da0a04@kernel.dk>
Message-ID: <672e9220-2634-95f1-95a1-62c35bcf7341@kernel.dk>
Date:   Thu, 7 May 2020 20:53:24 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <629de3b6-cf80-fe37-1dde-7f0464da0a04@kernel.dk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 5/7/20 8:28 PM, Jens Axboe wrote:
> On 5/7/20 5:31 PM, Al Viro wrote:
>> On Thu, May 07, 2020 at 05:03:17PM -0600, Jens Axboe wrote:
>>> On 5/7/20 4:44 PM, Al Viro wrote:
>>>> On Thu, May 07, 2020 at 04:25:24PM -0600, Jens Axboe wrote:
>>>>
>>>>>  static int io_close(struct io_kiocb *req, bool force_nonblock)
>>>>>  {
>>>>> +	struct files_struct *files = current->files;
>>>>>  	int ret;
>>>>>  
>>>>>  	req->close.put_file = NULL;
>>>>> -	ret = __close_fd_get_file(req->close.fd, &req->close.put_file);
>>>>> +	spin_lock(&files->file_lock);
>>>>> +	if (req->file->f_op == &io_uring_fops ||
>>>>> +	    req->close.fd == req->ctx->ring_fd) {
>>>>> +		spin_unlock(&files->file_lock);
>>>>> +		return -EBADF;
>>>>> +	}
>>>>> +
>>>>> +	ret = __close_fd_get_file_locked(files, req->close.fd,
>>>>> +						&req->close.put_file);
>>>>
>>>> Pointless.  By that point req->file might have nothing in common with
>>>> anything in any descriptor table.
>>>
>>> How about the below then? Stop using req->file, defer the lookup until
>>> we're in the handler instead. Not sure the 'fd' check makes sense
>>> at this point, but at least we should be consistent in terms of
>>> once we lookup the file and check the f_op.
>>
>> Actually, what _is_ the reason for that check?  Note, BTW, that if the
>> file in question happens to be an AF_UNIX socket, closing it will
>> close all references held in SCM_RIGHTS datagrams sitting in its queue,
>> which might very well include io_uring files.
>>
>> IOW, if tries to avoid something really unpleasant, it's not enough.
>> And if it doesn't, then what is it for?
> 
> Maybe there is no issue at all, the point was obviously to not have
> io_uring close itself. But we might just need an ordering of the
> fput vs put_request to make that just fine. Let me experiment a bit
> and see what's going on.

Ran various bits of testing and tracing with just the below, and
I don't see anything wrong. Even verified the same cases with
pending poll requests and an async read (punted to thread), and
it works and doesn't complain with KASAN either.

And I did think this would work after looking at it. The ctx
referencing should handle this just fine. Hence it seems to me
that my initial attempts at blocking the ring closing itself
were not needed at all.

diff --git a/fs/io_uring.c b/fs/io_uring.c
index 979d9f977409..9099a9362ad4 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -786,7 +786,6 @@ static const struct io_op_def io_op_defs[] = {
 		.needs_fs		= 1,
 	},
 	[IORING_OP_CLOSE] = {
-		.needs_file		= 1,
 		.file_table		= 1,
 	},
 	[IORING_OP_FILES_UPDATE] = {
@@ -3399,10 +3398,6 @@ static int io_close_prep(struct io_kiocb *req, const struct io_uring_sqe *sqe)
 		return -EBADF;
 
 	req->close.fd = READ_ONCE(sqe->fd);
-	if (req->file->f_op == &io_uring_fops ||
-	    req->close.fd == req->ctx->ring_fd)
-		return -EBADF;
-
 	return 0;
 }
 
-- 
Jens Axboe


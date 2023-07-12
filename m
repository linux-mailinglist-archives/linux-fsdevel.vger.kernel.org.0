Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81EB0750075
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Jul 2023 09:53:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231859AbjGLHxh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 Jul 2023 03:53:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229718AbjGLHxg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 Jul 2023 03:53:36 -0400
Received: from out-8.mta0.migadu.com (out-8.mta0.migadu.com [IPv6:2001:41d0:1004:224b::8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 007F8E6F
        for <linux-fsdevel@vger.kernel.org>; Wed, 12 Jul 2023 00:53:34 -0700 (PDT)
Message-ID: <858c3f16-ffb3-217e-b5d6-fcc63ef9c401@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1689148413;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FC42AF7xix5hDLWrq2t7lf71x97Aeew4iatdDcbvI/k=;
        b=kuZPChWNeKsG/KDgvuhXuMbYLYihVnXzPB1re2KFiq9BTKXFiU/NkrZtGW/8seNtjL1CDD
        bpbeaocDtE/qkypWN5rDO6eFejmZpHE7E/ZvaogBBDqQesB0ESGD0FwEKfFWx4Hsa3CYEQ
        pjhJd/86jh13krreotIQnwrkS5ndPmo=
Date:   Wed, 12 Jul 2023 15:53:24 +0800
MIME-Version: 1.0
Subject: Re: [PATCH 3/3] io_uring: add support for getdents
Content-Language: en-US
To:     Dominique Martinet <asmadeus@codewreck.org>
Cc:     io-uring@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Pavel Begunkov <asml.silence@gmail.com>,
        Christian Brauner <brauner@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Stefan Roesch <shr@fb.com>, Clay Harris <bugs@claycon.org>,
        Dave Chinner <david@fromorbit.com>,
        linux-fsdevel@vger.kernel.org, Wanpeng Li <wanpengli@tencent.com>
References: <20230711114027.59945-1-hao.xu@linux.dev>
 <20230711114027.59945-4-hao.xu@linux.dev> <ZK1H568bvIzcsB6J@codewreck.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Hao Xu <hao.xu@linux.dev>
In-Reply-To: <ZK1H568bvIzcsB6J@codewreck.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 7/11/23 20:15, Dominique Martinet wrote:
> Hao Xu wrote on Tue, Jul 11, 2023 at 07:40:27PM +0800:
>> diff --git a/io_uring/fs.c b/io_uring/fs.c
>> index f6a69a549fd4..77f00577e09c 100644
>> --- a/io_uring/fs.c
>> +++ b/io_uring/fs.c
>> @@ -291,3 +298,56 @@ void io_link_cleanup(struct io_kiocb *req)
>>   	putname(sl->oldpath);
>>   	putname(sl->newpath);
>>   }
>> +
>> +int io_getdents_prep(struct io_kiocb *req, const struct io_uring_sqe *sqe)
>> +{
>> +	struct io_getdents *gd = io_kiocb_to_cmd(req, struct io_getdents);
>> +
>> +	if (READ_ONCE(sqe->off) != 0)
>> +		return -EINVAL;
>> +
>> +	gd->dirent = u64_to_user_ptr(READ_ONCE(sqe->addr));
>> +	gd->count = READ_ONCE(sqe->len);
>> +
>> +	return 0;
>> +}
>> +
>> +int io_getdents(struct io_kiocb *req, unsigned int issue_flags)
>> +{
>> +	struct io_getdents *gd = io_kiocb_to_cmd(req, struct io_getdents);
>> +	struct file *file;
>> +	unsigned long getdents_flags = 0;
>> +	bool force_nonblock = issue_flags & IO_URING_F_NONBLOCK;
>> +	bool should_lock = false;
>> +	int ret;
>> +
>> +	if (force_nonblock) {
>> +		if (!(req->file->f_mode & FMODE_NOWAIT))
>> +			return -EAGAIN;
>> +
>> +		getdents_flags = DIR_CONTEXT_F_NOWAIT;
>> +	}
>> +
>> +	file = req->file;
>> +	if (file && (file->f_mode & FMODE_ATOMIC_POS)) {
> 
> If file is NULL here things will just blow up in vfs_getdents anyway,
> let's remove the useless check
> 
>> +		if (file_count(file) > 1)
> 
> I was curious about this so I found it's basically what __fdget_pos does
> before deciding it should take the f_pos_lock, and as such this is
> probably correct... But if someone can chime in here: what guarantees
> someone else won't __fdget_pos (or equivalent through this) the file
> again between this and the vfs_getdents call?
> That second get would make file_count > 1 and it would lock, but lock
> hadn't been taken here so the other call could get the lock without
> waiting and both would process getdents or seek or whatever in
> parallel.
> 

Hi Dominique,

This file_count(file) is atomic_read, so I believe no race condition here.

> 
> That aside I don't see any obvious problem with this.
> 


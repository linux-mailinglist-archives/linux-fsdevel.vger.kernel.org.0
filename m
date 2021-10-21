Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52A9F436C60
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Oct 2021 22:56:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232095AbhJUU6v (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 Oct 2021 16:58:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:20565 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230272AbhJUU6v (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 Oct 2021 16:58:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634849794;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=68HUPzgPttUWe5FwedRO8wZKqqjzi3HsAYTIx2wQjJ0=;
        b=T6SwCnWMbSzeWxHDL0ovGJ+zPUS7cQU0PM6hy4Xf/rNvRz+ySrn9IWCj0oluQtIJwd+ej1
        GLhl99XcNFdd06/ZC0PCzLpDTF/T8ystD3sWvlzCYoGhfHNrHnYpl8Be+mVxR5mtNjKXUa
        e+4A2jBsEEd+dzWH0kEhlDIWBTFlBY8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-572-34zrKJK6POCILkQm9taGyA-1; Thu, 21 Oct 2021 16:56:31 -0400
X-MC-Unique: 34zrKJK6POCILkQm9taGyA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D45A4806691;
        Thu, 21 Oct 2021 20:56:29 +0000 (UTC)
Received: from segfault.boston.devel.redhat.com (segfault.boston.devel.redhat.com [10.19.60.26])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 2DDDE1017E35;
        Thu, 21 Oct 2021 20:56:29 +0000 (UTC)
From:   Jeff Moyer <jmoyer@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Christoph Hellwig <hch@infradead.org>,
        "linux-fsdevel\@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-block\@vger.kernel.org" <linux-block@vger.kernel.org>,
        linux-aio@kvack.org, linux-usb@vger.kernel.org
Subject: Re: [PATCH v2] fs: replace the ki_complete two integer arguments with a single argument
References: <4d409f23-2235-9fa6-4028-4d6c8ed749f8@kernel.dk>
        <YXElk52IsvCchbOx@infradead.org> <YXFHgy85MpdHpHBE@infradead.org>
        <4d3c5a73-889c-2e2c-9bb2-9572acdd11b7@kernel.dk>
        <YXF8X3RgRfZpL3Cb@infradead.org>
        <b7b6e63e-8787-f24c-2028-e147b91c4576@kernel.dk>
        <x49ee8ev21s.fsf@segfault.boston.devel.redhat.com>
        <6338ba2b-cd71-f66d-d596-629c2812c332@kernel.dk>
        <x497de6uubq.fsf@segfault.boston.devel.redhat.com>
        <7a697483-8e44-6dc3-361e-ae7b62b82074@kernel.dk>
X-PGP-KeyID: 1F78E1B4
X-PGP-CertKey: F6FE 280D 8293 F72C 65FD  5A58 1FF8 A7CA 1F78 E1B4
Date:   Thu, 21 Oct 2021 16:58:34 -0400
In-Reply-To: <7a697483-8e44-6dc3-361e-ae7b62b82074@kernel.dk> (Jens Axboe's
        message of "Thu, 21 Oct 2021 14:41:18 -0600")
Message-ID: <x49wnm6t7r9.fsf@segfault.boston.devel.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Jens Axboe <axboe@kernel.dk> writes:

> On 10/21/21 12:05 PM, Jeff Moyer wrote:
>> 
>>>> I'll follow up if there are issues.
>> 
>> s390 (big endian, 64 bit) is failing libaio test 21:
>> 
>> # harness/cases/21.p
>> Expected -EAGAIN, got 4294967285
>> 
>> If I print out both res and res2 using %lx, you'll see what happened:
>> 
>> Expected -EAGAIN, got fffffff5,ffffffff
>> 
>> The sign extension is being split up.
>
> Funky, does it work if you apply this on top?
>
> diff --git a/fs/aio.c b/fs/aio.c
> index 3674abc43788..c56437908339 100644
> --- a/fs/aio.c
> +++ b/fs/aio.c
> @@ -1442,8 +1442,8 @@ static void aio_complete_rw(struct kiocb *kiocb, u64 res)
>  	 * 32-bits of value at most for either value, bundle these up and
>  	 * pass them in one u64 value.
>  	 */
> -	iocb->ki_res.res = lower_32_bits(res);
> -	iocb->ki_res.res2 = upper_32_bits(res);
> +	iocb->ki_res.res = (long) (res & 0xffffffff);
> +	iocb->ki_res.res2 = (long) (res >> 32);
>  	iocb_put(iocb);
>  }

I think you'll also need to clamp any ki_complete() call sites to 32
bits (cast to int, or what have you).  Otherwise that sign extension
will spill over into res2.

fwiw, I tested with this:

	iocb->ki_res.res = (long)(int)lower_32_bits(res);
	iocb->ki_res.res2 = (long)(int)upper_32_bits(res);

Coupled with the call site changes, that made things work for me.

-Jeff


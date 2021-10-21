Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04E634365C8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Oct 2021 17:16:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231774AbhJUPTM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 Oct 2021 11:19:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:23350 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231909AbhJUPTL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 Oct 2021 11:19:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634829415;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZuGUCWJesXH8eEfD4uYbvpcQnhlkdtgHDHRl2HOKRu4=;
        b=Xm8WSnCdPkZFg6GnpN1agPXiaT2xLgxKcZFp7i6w6h/83twpXBZBxUmHC8kl2FOpOatws1
        YHI5HJo5SXdg/kjHQC2vRybwMDQtTuFyQLpi25TmII1+8Q+W1b9ZuIzhIYXbvcQJJjcOC1
        2L1djELmh0iEhROyDzgvxIOoqs8T42w=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-218-8T2Q3_FoMD6B-Jir8MiN0g-1; Thu, 21 Oct 2021 11:16:51 -0400
X-MC-Unique: 8T2Q3_FoMD6B-Jir8MiN0g-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 199CC1927801;
        Thu, 21 Oct 2021 15:16:50 +0000 (UTC)
Received: from segfault.boston.devel.redhat.com (segfault.boston.devel.redhat.com [10.19.60.26])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 9042960C13;
        Thu, 21 Oct 2021 15:16:49 +0000 (UTC)
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
X-PGP-KeyID: 1F78E1B4
X-PGP-CertKey: F6FE 280D 8293 F72C 65FD  5A58 1FF8 A7CA 1F78 E1B4
Date:   Thu, 21 Oct 2021 11:18:55 -0400
In-Reply-To: <b7b6e63e-8787-f24c-2028-e147b91c4576@kernel.dk> (Jens Axboe's
        message of "Thu, 21 Oct 2021 08:44:16 -0600")
Message-ID: <x49ee8ev21s.fsf@segfault.boston.devel.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Jens Axboe <axboe@kernel.dk> writes:

> On 10/21/21 8:42 AM, Christoph Hellwig wrote:
>> On Thu, Oct 21, 2021 at 08:34:38AM -0600, Jens Axboe wrote:
>>> Incremental, are you happy with that comment?
>> 
>> Looks fine to me.
>
> OK good, can I add your ack/review? I can send out a v3 if needed, but
> seems a bit pointless for that small change.
>
> Jeff, are you happy with this one too?

> diff --git a/drivers/block/loop.c b/drivers/block/loop.c
> index 397bfafc4c25..66c6e0c5d638 100644
> --- a/drivers/block/loop.c
> +++ b/drivers/block/loop.c
> @@ -550,7 +550,7 @@ static void lo_rw_aio_do_completion(struct loop_cmd *cmd)
>  		blk_mq_complete_request(rq);
>  }
>  
> -static void lo_rw_aio_complete(struct kiocb *iocb, long ret, long ret2)
> +static void lo_rw_aio_complete(struct kiocb *iocb, u64 ret)
>  {
>  	struct loop_cmd *cmd = container_of(iocb, struct loop_cmd, iocb);
>  
> @@ -623,7 +623,7 @@ static int lo_rw_aio(struct loop_device *lo, struct loop_cmd *cmd,
>  	lo_rw_aio_do_completion(cmd);
>  
>  	if (ret != -EIOCBQUEUED)
> -		cmd->iocb.ki_complete(&cmd->iocb, ret, 0);
> +		lo_rw_aio_complete(&cmd->iocb, ret);
>  	return 0;

I'm not sure why that was part of this patch, but I think it's fine.

I've still got more testing to do, but you can add:

Reviewed-by: Jeff Moyer <jmoyer@redhat.com>

I'll follow up if there are issues.

Cheers,
Jeff


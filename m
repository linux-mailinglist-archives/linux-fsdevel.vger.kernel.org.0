Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5BC7435275
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Oct 2021 20:14:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231140AbhJTSQe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 20 Oct 2021 14:16:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:30037 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231199AbhJTSQd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 20 Oct 2021 14:16:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634753658;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JlbiDX/zLUgGtbtz7d4EWViuLkB3Jf+ofvgaSGXt0P0=;
        b=JM5pdwzWJq5S3VleyTeRIMMcUmcCMiqL3VwNnR8fODYtiB8BiXb7ubODLx7aEVWiqS5JRl
        5bz2czeafH+SG74nlvaWlVR2B/R2r/P07v5Gb34iwAE+lTTcb859xFpwqcqtXG6QG9IeLr
        pBG11ElpGcUTgQMpwGP0j3IbXzAm/pk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-440-lry4q7BWMcupuR_0Mc3LyA-1; Wed, 20 Oct 2021 14:14:16 -0400
X-MC-Unique: lry4q7BWMcupuR_0Mc3LyA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8D2F010A8E00;
        Wed, 20 Oct 2021 18:14:15 +0000 (UTC)
Received: from segfault.boston.devel.redhat.com (segfault.boston.devel.redhat.com [10.19.60.26])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 05D26694B5;
        Wed, 20 Oct 2021 18:14:14 +0000 (UTC)
From:   Jeff Moyer <jmoyer@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     "linux-fsdevel\@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-block\@vger.kernel.org" <linux-block@vger.kernel.org>,
        linux-aio@kvack.org
Subject: Re: [PATCH] fs: kill unused ret2 argument from iocb->ki_complete()
References: <ce839d66-1d05-dab8-4540-71b8485fdaf3@kernel.dk>
X-PGP-KeyID: 1F78E1B4
X-PGP-CertKey: F6FE 280D 8293 F72C 65FD  5A58 1FF8 A7CA 1F78 E1B4
Date:   Wed, 20 Oct 2021 14:16:19 -0400
In-Reply-To: <ce839d66-1d05-dab8-4540-71b8485fdaf3@kernel.dk> (Jens Axboe's
        message of "Wed, 20 Oct 2021 10:49:07 -0600")
Message-ID: <x498ryno93g.fsf@segfault.boston.devel.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi, Jens,

Jens Axboe <axboe@kernel.dk> writes:

> It's not used for anything, and we're wasting time passing in zeroes
> where we could just ignore it instead. Update all ki_complete users in
> the kernel to drop that last argument.

What does "wasting time passing in zeroes" mean?

> The exception is the USB gadget code, which passes in non-zero. But
> since nobody every looks at ret2, it's still pointless.

As Christoph mentioned, it is passed along to userspace as part of the
io_event.

> @@ -499,8 +499,7 @@ static void ep_aio_complete(struct usb_ep *ep, struct usb_request *req)
>  		/* aio_complete() reports bytes-transferred _and_ faults */

Note this comment ^^^

>  
>  		iocb->ki_complete(iocb,
> -				req->actual ? req->actual : (long)req->status,
> -				req->status);
> +				req->actual ? req->actual : (long)req->status);

We can't know whether some userspace implementation relies on this
behavior, so I don't think you can change it.

Cheers,
Jeff

p.s. Please CC linux-aio on future changes to the aio code.


Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 393C817C62C
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Mar 2020 20:21:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726674AbgCFTU6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 6 Mar 2020 14:20:58 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:49563 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726178AbgCFTU6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 6 Mar 2020 14:20:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583522457;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=t0H1vkQmPmzBSwnwF8uzFghL+fUOg4p2orNUbsJWNSo=;
        b=TNBW1Hsq8NSExzCYqVWyzyLM4bzRh3m1on8fa7YBOiTQD9afbNlLYezFoc9zckK6FOpUe5
        BtIy+rcsbrHT2jH0YebK30JAiMNQ77Chnnutn69vJIhB7HbndOhXRQY2NfUkRmy6JzMkag
        rTPUqDBMA9LmH9OExkSdH/YgJxQb+l4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-307-QzDKrNssNASCS4pYajeMpQ-1; Fri, 06 Mar 2020 14:20:53 -0500
X-MC-Unique: QzDKrNssNASCS4pYajeMpQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F1F30190D344;
        Fri,  6 Mar 2020 19:20:51 +0000 (UTC)
Received: from segfault.boston.devel.redhat.com (segfault.boston.devel.redhat.com [10.19.60.26])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 0932C90795;
        Fri,  6 Mar 2020 19:20:50 +0000 (UTC)
From:   Jeff Moyer <jmoyer@redhat.com>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Benjamin LaHaise <bcrl@kvack.org>,
        linux-fsdevel@vger.kernel.org, linux-aio@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] aio: Replace zero-length array with flexible-array member
References: <20200306164446.GA21604@embeddedor>
X-PGP-KeyID: 1F78E1B4
X-PGP-CertKey: F6FE 280D 8293 F72C 65FD  5A58 1FF8 A7CA 1F78 E1B4
Date:   Fri, 06 Mar 2020 14:20:49 -0500
In-Reply-To: <20200306164446.GA21604@embeddedor> (Gustavo A. R. Silva's
        message of "Fri, 6 Mar 2020 10:44:46 -0600")
Message-ID: <x49ftelnvce.fsf@segfault.boston.devel.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

"Gustavo A. R. Silva" <gustavo@embeddedor.com> writes:

> The current codebase makes use of the zero-length array language
> extension to the C90 standard, but the preferred mechanism to declare
> variable-length types such as these ones is a flexible array member[1][2],
> introduced in C99:
>
> struct foo {
>         int stuff;
>         struct boo array[];
> };
>
> By making use of the mechanism above, we will get a compiler warning
> in case the flexible array does not occur last in the structure, which
> will help us prevent some kind of undefined behavior bugs from being
> inadvertently introduced[3] to the codebase from now on.
>
> Also, notice that, dynamic memory allocations won't be affected by
> this change:
>
> "Flexible array members have incomplete type, and so the sizeof operator
> may not be applied. As a quirk of the original implementation of
> zero-length arrays, sizeof evaluates to zero."[1]
>
> This issue was found with the help of Coccinelle.
>
> [1] https://gcc.gnu.org/onlinedocs/gcc/Zero-Length.html
> [2] https://github.com/KSPP/linux/issues/21
> [3] commit 76497732932f ("cxgb3/l2t: Fix undefined behaviour")
>
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> ---
>  fs/aio.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/fs/aio.c b/fs/aio.c
> index 94f2b9256c0c..13c4be7f00f0 100644
> --- a/fs/aio.c
> +++ b/fs/aio.c
> @@ -68,7 +68,7 @@ struct aio_ring {
>  	unsigned	header_length;	/* size of aio_ring */
>  
>  
> -	struct io_event		io_events[0];
> +	struct io_event		io_events[];
>  }; /* 128 bytes + ring size */
>  
>  /*

Acked-by: Jeff Moyer <jmoyer@redhat.com>


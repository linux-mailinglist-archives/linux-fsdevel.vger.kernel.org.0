Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E83C672682
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Jan 2023 19:16:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230424AbjARSQj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 18 Jan 2023 13:16:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231244AbjARSQT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 18 Jan 2023 13:16:19 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5FE65A365
        for <linux-fsdevel@vger.kernel.org>; Wed, 18 Jan 2023 10:15:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674065726;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rgtBVwEo115pa/wHlq8zXkWV41DjF6dYWeawMxXfPU8=;
        b=go2M2ci34qXOSojIymxoFOOCoBI0nh9KqMhDbnzfZJE/G7p1PR/iWelZNeAGo1ORW0DB72
        TO5Ze9VCpj2K6Pc1B52q8pCoKSkkl7DdU2atSe0xmItx4GiEiBCUri0FRdZefO2LlLIok1
        iMRQCFhhiKilL2Pdf+mzEeSMlGtPBDA=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-398-Lo7GEuZjOV-TWbeD26myVA-1; Wed, 18 Jan 2023 13:15:20 -0500
X-MC-Unique: Lo7GEuZjOV-TWbeD26myVA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 79F3B280558D;
        Wed, 18 Jan 2023 18:15:17 +0000 (UTC)
Received: from segfault.boston.devel.redhat.com (segfault.boston.devel.redhat.com [10.19.60.26])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 50BCB1121315;
        Wed, 18 Jan 2023 18:15:17 +0000 (UTC)
From:   Jeff Moyer <jmoyer@redhat.com>
To:     Kent Overstreet <kent.overstreet@linux.dev>
Cc:     linux-kernel@vger.kernel.org, linux-aio@kvack.org,
        linux-fsdevel@vger.kernel.org, fmdefrancesco@gmail.com
Subject: Re: [PATCH 1/2] fs/aio: Use kmap_local() instead of kmap()
References: <20230118152603.28301-1-kent.overstreet@linux.dev>
X-PGP-KeyID: 1F78E1B4
X-PGP-CertKey: F6FE 280D 8293 F72C 65FD  5A58 1FF8 A7CA 1F78 E1B4
Date:   Wed, 18 Jan 2023 13:19:13 -0500
In-Reply-To: <20230118152603.28301-1-kent.overstreet@linux.dev> (Kent
        Overstreet's message of "Wed, 18 Jan 2023 10:26:02 -0500")
Message-ID: <x49mt6f7ljy.fsf@segfault.boston.devel.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi, Kent,

Kent Overstreet <kent.overstreet@linux.dev> writes:

> Originally, we used kmap() instead of kmap_atomic() for reading events
> out of the completion ringbuffer because we're using copy_to_user(),
> which can fault.
>
> Now that kmap_local() is a thing, use that instead.

This has already been proposed as part of a more comprehensive patch:
  https://lore.kernel.org/linux-fsdevel/20230109175629.9482-1-fmdefrancesco@gmail.com/

Would you be willing to review that one?

Thanks!
Jeff

>
> Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
> Cc: Benjamin LaHaise <bcrl@kvack.org
> Cc: linux-aio@kvack.org
> Cc: linux-fsdevel@vger.kernel.org
> ---
>  fs/aio.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/fs/aio.c b/fs/aio.c
> index 5b2ff20ad3..3f795ed2a2 100644
> --- a/fs/aio.c
> +++ b/fs/aio.c
> @@ -1246,10 +1246,10 @@ static long aio_read_events_ring(struct kioctx *ctx,
>  		avail = min(avail, nr - ret);
>  		avail = min_t(long, avail, AIO_EVENTS_PER_PAGE - pos);
>  
> -		ev = kmap(page);
> +		ev = kmap_local_page(page);
>  		copy_ret = copy_to_user(event + ret, ev + pos,
>  					sizeof(*ev) * avail);
> -		kunmap(page);
> +		kunmap_local(ev);
>  
>  		if (unlikely(copy_ret)) {
>  			ret = -EFAULT;


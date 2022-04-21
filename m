Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4E3E50A206
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Apr 2022 16:20:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1389110AbiDUOVW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 Apr 2022 10:21:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231440AbiDUOVS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 Apr 2022 10:21:18 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 004653C4BF
        for <linux-fsdevel@vger.kernel.org>; Thu, 21 Apr 2022 07:18:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650550708;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=coOw4RfXiLNZzQ3xqdVQ85pRpofvZXMbbKbFNiXv7eM=;
        b=HyOy5EH4jJgnZ1pdEJk5WY38Qdz4IdYstTU6Qd4kVO7DgoR/h9XXiPEix8aKm6aeJbUzbP
        iDtAXpfBS775+nuir4DcBnUPj+j3fKytJkNy9Nd99ihwvCf6zKd/ajLem9Wf9zSH4RMGo7
        WRSksxm9SssEPDmwN/GBrOCGtSGcoFY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-298-gRSGhd4YNJGFrIMlixXwVQ-1; Thu, 21 Apr 2022 10:18:23 -0400
X-MC-Unique: gRSGhd4YNJGFrIMlixXwVQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5BA6B18019EF;
        Thu, 21 Apr 2022 14:17:42 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.13])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DEAF240CFD22;
        Thu, 21 Apr 2022 14:17:39 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20220415123614.54024-7-jefflexu@linux.alibaba.com>
References: <20220415123614.54024-7-jefflexu@linux.alibaba.com> <20220415123614.54024-1-jefflexu@linux.alibaba.com>
To:     Jeffle Xu <jefflexu@linux.alibaba.com>
Cc:     dhowells@redhat.com, linux-cachefs@redhat.com, xiang@kernel.org,
        chao@kernel.org, linux-erofs@lists.ozlabs.org,
        torvalds@linux-foundation.org, gregkh@linuxfoundation.org,
        willy@infradead.org, linux-fsdevel@vger.kernel.org,
        joseph.qi@linux.alibaba.com, bo.liu@linux.alibaba.com,
        tao.peng@linux.alibaba.com, gerry@linux.alibaba.com,
        eguan@linux.alibaba.com, linux-kernel@vger.kernel.org,
        luodaowen.backend@bytedance.com, tianzichen@kuaishou.com,
        fannaihao@baidu.com, zhangjiachen.jaycee@bytedance.com
Subject: Re: [PATCH v9 06/21] cachefiles: enable on-demand read mode
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1445690.1650550659.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date:   Thu, 21 Apr 2022 15:17:39 +0100
Message-ID: <1445691.1650550659@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.1
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Jeffle Xu <jefflexu@linux.alibaba.com> wrote:

> +	if (IS_ENABLED(CONFIG_CACHEFILES_ONDEMAND) &&
> +	    !strcmp(args, "ondemand")) {
> +		set_bit(CACHEFILES_ONDEMAND_MODE, &cache->flags);
> +	} else if (*args) {
> +		pr_err("'bind' command doesn't take an argument\n");

The error message isn't true if CONFIG_CACHEFILES_ONDEMAND=3Dy.  It would =
be
better to say "Invalid argument to the 'bind' command".

> -retry:
>  	/* If the caller asked us to seek for data before doing the read, then
>  	 * we should do that now.  If we find a gap, we fill it with zeros.
>  	 */
> @@ -120,16 +119,6 @@ static int cachefiles_read(struct netfs_cache_resou=
rces *cres,
>  			if (read_hole =3D=3D NETFS_READ_HOLE_FAIL)
>  				goto presubmission_error;
>  =

> -			if (read_hole =3D=3D NETFS_READ_HOLE_ONDEMAND) {
> -				ret =3D cachefiles_ondemand_read(object, off, len);
> -				if (ret)
> -					goto presubmission_error;
> -
> -				/* fail the read if no progress achieved */
> -				read_hole =3D NETFS_READ_HOLE_FAIL;
> -				goto retry;
> -			}
> -

Unexplained deletion of newly added code.

David


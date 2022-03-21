Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F5754E27B0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Mar 2022 14:35:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347935AbiCUNgf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 21 Mar 2022 09:36:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347793AbiCUNgb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 21 Mar 2022 09:36:31 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3659142A06
        for <linux-fsdevel@vger.kernel.org>; Mon, 21 Mar 2022 06:34:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647869697;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2ru2iq/ox5s0Rm8wfLoTnDRL9rVImEm3d4wp9HAg3/0=;
        b=RL6l+woIah/31r6M4stFj9d35Ix2knegrdiJ4v0Dlx5313JJnSbp4iK+XHADvxFrtTYgia
        iEqF49YR7AtRLp8dcNCO34qZCzbXgWNyz6mXYR1tXWRyfpntqvSBZ7BqfnRpRhfveVrDaa
        pzUkaHxKUT0lw7ifWUCJTOLySbVq2fY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-634-P_Li5wrOPx-px3Lu6HvcqA-1; Mon, 21 Mar 2022 09:34:54 -0400
X-MC-Unique: P_Li5wrOPx-px3Lu6HvcqA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2DD291044562;
        Mon, 21 Mar 2022 13:34:53 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.19])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2B1821121318;
        Mon, 21 Mar 2022 13:34:45 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20220316131723.111553-4-jefflexu@linux.alibaba.com>
References: <20220316131723.111553-4-jefflexu@linux.alibaba.com> <20220316131723.111553-1-jefflexu@linux.alibaba.com>
To:     Jeffle Xu <jefflexu@linux.alibaba.com>
Cc:     dhowells@redhat.com, linux-cachefs@redhat.com, xiang@kernel.org,
        chao@kernel.org, linux-erofs@lists.ozlabs.org,
        torvalds@linux-foundation.org, gregkh@linuxfoundation.org,
        willy@infradead.org, linux-fsdevel@vger.kernel.org,
        joseph.qi@linux.alibaba.com, bo.liu@linux.alibaba.com,
        tao.peng@linux.alibaba.com, gerry@linux.alibaba.com,
        eguan@linux.alibaba.com, linux-kernel@vger.kernel.org,
        luodaowen.backend@bytedance.com
Subject: Re: [PATCH v5 03/22] cachefiles: introduce on-demand read mode
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1027871.1647869684.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date:   Mon, 21 Mar 2022 13:34:44 +0000
Message-ID: <1027872.1647869684@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Jeffle Xu <jefflexu@linux.alibaba.com> wrote:

> Fscache/cachefiles used to serve as a local cache for remote fs. This
> patch, along with the following patches, introduces a new on-demand read
> mode for cachefiles, which can boost the scenario where on-demand read
> semantics is needed, e.g. container image distribution.
> =

> The essential difference between the original mode and on-demand read
> mode is that, in the original mode, when cache miss, netfs itself will
> fetch data from remote, and then write the fetched data into cache file.
> While in on-demand read mode, a user daemon is responsible for fetching
> data and then writing to the cache file.
> =

> This patch only adds the command to enable on-demand read mode. An optio=
nal
> parameter to "bind" command is added. On-demand mode will be turned on w=
hen
> this optional argument matches "ondemand" exactly, i.e.  "bind
> ondemand". Otherwise cachefiles will keep working in the original mode.

You're not really adding a command, per se.  Also, I would recommend
starting the paragraph with a verb.  How about:

	Make it possible to enable on-demand read mode by adding an
	optional parameter to the "bind" command.  On-demand mode will be
	turned on when this parameter is "ondemand", i.e. "bind ondemand".
	Otherwise cachefiles will work in the original mode.

Also, I'd add a note something like the following:

	This is implemented as a variation on the bind command so that it
	can't be turned on accidentally in /etc/cachefilesd.conf when
	cachefilesd isn't expecting it.	=


> The following patches will implement the data plane of on-demand read
> mode.

I would remove this line.  If ondemand mode is not fully implemented in
cachefiles at this point, I would be tempted to move this to the end of th=
e
cachefiles subset of the patchset.  That said, I'm not sure it can be made
to do anything much before that point.

> +#ifdef CONFIG_CACHEFILES_ONDEMAND
> +static inline void cachefiles_ondemand_open(struct cachefiles_cache *ca=
che)
> +{
> +	xa_init_flags(&cache->reqs, XA_FLAGS_ALLOC);
> +	rwlock_init(&cache->reqs_lock);
> +}

Just merge that into the caller.

> +static inline void cachefiles_ondemand_release(struct cachefiles_cache =
*cache)
> +{
> +	xa_destroy(&cache->reqs);
> +}

Ditto.

> +static inline
> +bool cachefiles_ondemand_daemon_bind(struct cachefiles_cache *cache, ch=
ar *args)
> +{
> +	if (!strcmp(args, "ondemand")) {
> +		set_bit(CACHEFILES_ONDEMAND_MODE, &cache->flags);
> +		return true;
> +	}
> +
> +	return false;
> +}
> ...
> +	if (!cachefiles_ondemand_daemon_bind(cache, args) && *args) {
> +		pr_err("'bind' command doesn't take an argument\n");
> +		return -EINVAL;
> +	}
> +

I would merge these together, I think, and say something like "Ondemand
mode not enabled in kernel" if CONFIG_CACHEFILES_ONDEMAND=3Dn.

David


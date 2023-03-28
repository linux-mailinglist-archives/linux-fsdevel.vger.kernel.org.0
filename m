Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 647E76CC171
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Mar 2023 15:53:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232345AbjC1NxH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Mar 2023 09:53:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232289AbjC1NxF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Mar 2023 09:53:05 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 339721A5
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Mar 2023 06:52:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680011539;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0Bjk4mx3lBKFeadPQXueJB7h/c8lDuCBaVc1H5uzUP4=;
        b=drOTsbtcpjOl91fg5guATRzb4vojiJhIZ/lalGAmWO1vCegep52DuPAZsglonA/J9NCI9M
        75kZEYCXysvKnZSVObsDy5k12o3v129ioy5s6cbBwe/50APGA2LtzYJd4mEUETgCqbKnje
        m1kwadVZZxd21cFwwaEUDEBBgR62j9I=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-587-gnJ2ogLqNoKHz6FfAC4XsA-1; Tue, 28 Mar 2023 09:52:14 -0400
X-MC-Unique: gnJ2ogLqNoKHz6FfAC4XsA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7A9C1855315;
        Tue, 28 Mar 2023 13:52:13 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.18])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3E09614171BB;
        Tue, 28 Mar 2023 13:52:12 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20230111052515.53941-2-zhujia.zj@bytedance.com>
References: <20230111052515.53941-2-zhujia.zj@bytedance.com> <20230111052515.53941-1-zhujia.zj@bytedance.com>
To:     Jia Zhu <zhujia.zj@bytedance.com>
Cc:     dhowells@redhat.com, linux-cachefs@redhat.com,
        linux-erofs@lists.ozlabs.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Xin Yin <yinxin.x@bytedance.com>,
        Jingbo Xu <jefflexu@linux.alibaba.com>
Subject: Re: [PATCH V4 1/5] cachefiles: introduce object ondemand state
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <131868.1680011531.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date:   Tue, 28 Mar 2023 14:52:11 +0100
Message-ID: <131869.1680011531@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Jia Zhu <zhujia.zj@bytedance.com> wrote:

> +enum cachefiles_object_state {
> +	CACHEFILES_ONDEMAND_OBJSTATE_close, /* Anonymous fd closed by daemon o=
r initial state */
> +	CACHEFILES_ONDEMAND_OBJSTATE_open, /* Anonymous fd associated with obj=
ect is available */

That looks weird.  Maybe make them all-lowercase?

> @@ -296,6 +302,21 @@ extern void cachefiles_ondemand_clean_object(struct=
 cachefiles_object *object);
>  extern int cachefiles_ondemand_read(struct cachefiles_object *object,
>  				    loff_t pos, size_t len);
>  =

> +#define CACHEFILES_OBJECT_STATE_FUNCS(_state)	\
> +static inline bool								\
> +cachefiles_ondemand_object_is_##_state(const struct cachefiles_object *=
object) \
> +{												\
> +	return object->state =3D=3D CACHEFILES_ONDEMAND_OBJSTATE_##_state; \
> +}												\
> +												\
> +static inline void								\
> +cachefiles_ondemand_set_object_##_state(struct cachefiles_object *objec=
t) \
> +{												\
> +	object->state =3D CACHEFILES_ONDEMAND_OBJSTATE_##_state; \
> +}
> +
> +CACHEFILES_OBJECT_STATE_FUNCS(open);
> +CACHEFILES_OBJECT_STATE_FUNCS(close);

Or just get rid of the macroisation?  If there are only two states, it doe=
sn't
save you that much and it means that "make TAGS" won't generate refs for t=
hose
functions and grep won't find them.

David


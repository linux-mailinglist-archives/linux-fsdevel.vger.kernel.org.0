Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45CDB52DC3F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 May 2022 20:04:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243579AbiESSCo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 19 May 2022 14:02:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243582AbiESSCn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 19 May 2022 14:02:43 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 806D25AEFF
        for <linux-fsdevel@vger.kernel.org>; Thu, 19 May 2022 11:02:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652983361;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+vRbUI4/GPSCZt1VwOoZEQyVUcK9j3r3qdubIZdOiHI=;
        b=ejlgjJ3ZAiyW9ykQM2XTq3c8q4ercwdPtKLMVtdHN/22qdsMxlcPY0hae3y8oy1KFTk0av
        kZz2w98jTZmtpJynEv+lMEnYfjoQvpyMKLwKLirasFPqvd1iDqeLfDTs8qRQ0CDp8LhJkI
        qaOOonXgBFZ5bb5+F9yYdHramRsz6ZM=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-390-3OYFdW9OOTKNIUu3k3hs_g-1; Thu, 19 May 2022 14:02:34 -0400
X-MC-Unique: 3OYFdW9OOTKNIUu3k3hs_g-1
Received: by mail-ej1-f70.google.com with SMTP id pj21-20020a170906d79500b006fea2020e78so567471ejb.11
        for <linux-fsdevel@vger.kernel.org>; Thu, 19 May 2022 11:02:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+vRbUI4/GPSCZt1VwOoZEQyVUcK9j3r3qdubIZdOiHI=;
        b=GDOGunrLzDFeUDtwbuPS3Cp0M8KdNbBYg2z2FeLyCXoPEkuQTwNsrXkKage3IvW0oz
         dfb7g8BmxT7y6KFtDqZ/WuWqTuPsicHp/jx8bw+noyk9HxPNFQhHr0VKNdFAiTAjGBDP
         qTkvmQ8NaNWiAbHeh5tcVtol0NA/ia+tzSrQGVT7Q+eqpoJTgawvewUNpdy3CM6GJzJz
         zpCWoGeQxgghrQocWMzS16NKdJD3kbiLXPx/Fsny2AYp8UtW1osgqysoKe81ghbL7QcD
         OMBThj6GBrvjx3CtbZOZxMQOm3XgOkTg9ltd9w2bZJduzzMTpTXaI1gIWjeaA/e2oQ9I
         fwdA==
X-Gm-Message-State: AOAM533yxoH0FKBay25NpbW2KLKVkvW6OqEZwvET5xzsL9eyzMjx9t9X
        zwvOZCig9oIsGeyt6pWn+Lr/INvZV7p6Rxc3udu6Y6vns/B1j8sM6PKwSQpmZiU55i056rg5etM
        5cU9wuA3VZoGATwo5o6/g1w6qzxSEdDlUYF666mlZCg==
X-Received: by 2002:a05:6402:5298:b0:42a:cb63:5d10 with SMTP id en24-20020a056402529800b0042acb635d10mr6750413edb.415.1652983353660;
        Thu, 19 May 2022 11:02:33 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxn6/Tj4V8KVXox3lSlmm5Gz66eQBDgYCQAVpr2miM030h/XBUwtnvlrRGYYV9HfkeB+8UEO+uov7EtDJwHTak=
X-Received: by 2002:a05:6402:5298:b0:42a:cb63:5d10 with SMTP id
 en24-20020a056402529800b0042acb635d10mr6750403edb.415.1652983353522; Thu, 19
 May 2022 11:02:33 -0700 (PDT)
MIME-Version: 1.0
References: <165294669215.3283481.13374322806917745974.stgit@warthog.procyon.org.uk>
In-Reply-To: <165294669215.3283481.13374322806917745974.stgit@warthog.procyon.org.uk>
From:   David Wysochanski <dwysocha@redhat.com>
Date:   Thu, 19 May 2022 14:01:57 -0400
Message-ID: <CALF+zOk923ZnSucxitYQFN9m3AY=iOy+j90WrFmqZbKMuOcVsA@mail.gmail.com>
Subject: Re: [PATCH] nfs: Fix fscache volume key rendering for endianness
To:     David Howells <dhowells@redhat.com>
Cc:     Trond Myklebust <trond.myklebust@hammerspace.com>, anna@kernel.org,
        Jeff Layton <jlayton@kernel.org>,
        linux-nfs <linux-nfs@vger.kernel.org>,
        linux-cachefs <linux-cachefs@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, May 19, 2022 at 3:51 AM David Howells <dhowells@redhat.com> wrote:
>
> Fix fscache volume key rendering for endianness.  Convert the BE numbers in
> the address to host-endian before printing them so that they're consistent
> if the cache is copied between architectures.
>
> Question: This change could lead to misidentification of a volume directory
> in the cache on a LE machine (it's unlikely because the port number as well
> as the address numbers all get flipped), but it was introduced in -rc1 in
> this cycle so probably isn't in any distro kernels yet.  Should I add a
> version number to enforce non-matching?
>
> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: Dave Wysochanski <dwysocha@redhat.com>
> cc: Trond Myklebust <trond.myklebust@hammerspace.com>
> cc: Anna Schumaker <anna@kernel.org>
> cc: Jeff Layton <jlayton@kernel.org>
> cc: linux-nfs@vger.kernel.org
> cc: linux-cachefs@redhat.com
> ---
>
>  fs/nfs/fscache.c |   14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
>
> diff --git a/fs/nfs/fscache.c b/fs/nfs/fscache.c
> index f73c09a9cf0a..0e5572b192b2 100644
> --- a/fs/nfs/fscache.c
> +++ b/fs/nfs/fscache.c
> @@ -54,17 +54,17 @@ static bool nfs_fscache_get_client_key(struct nfs_client *clp,
>
>         switch (clp->cl_addr.ss_family) {
>         case AF_INET:
> -               if (!nfs_append_int(key, _len, sin->sin_port) ||
> -                   !nfs_append_int(key, _len, sin->sin_addr.s_addr))
> +               if (!nfs_append_int(key, _len, ntohs(sin->sin_port)) ||
> +                   !nfs_append_int(key, _len, ntohl(sin->sin_addr.s_addr)))
>                         return false;
>                 return true;
>
>         case AF_INET6:
> -               if (!nfs_append_int(key, _len, sin6->sin6_port) ||
> -                   !nfs_append_int(key, _len, sin6->sin6_addr.s6_addr32[0]) ||
> -                   !nfs_append_int(key, _len, sin6->sin6_addr.s6_addr32[1]) ||
> -                   !nfs_append_int(key, _len, sin6->sin6_addr.s6_addr32[2]) ||
> -                   !nfs_append_int(key, _len, sin6->sin6_addr.s6_addr32[3]))
> +               if (!nfs_append_int(key, _len, ntohs(sin6->sin6_port)) ||
> +                   !nfs_append_int(key, _len, ntohl(sin6->sin6_addr.s6_addr32[0])) ||
> +                   !nfs_append_int(key, _len, ntohl(sin6->sin6_addr.s6_addr32[1])) ||
> +                   !nfs_append_int(key, _len, ntohl(sin6->sin6_addr.s6_addr32[2])) ||
> +                   !nfs_append_int(key, _len, ntohl(sin6->sin6_addr.s6_addr32[3])))
>                         return false;
>                 return true;
>
>
>

IMO it's not worth versioning in this case but I agree with this change.
Did someone report the "cache copied between architectures" issue, or
is that mostly a theoretical problem you noticed?

Acked-by: Dave Wysochanski <dwysocha@redhat.com>


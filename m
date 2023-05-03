Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 351236F51C9
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 May 2023 09:36:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229680AbjECHgD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 3 May 2023 03:36:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbjECHgC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 3 May 2023 03:36:02 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08B022736;
        Wed,  3 May 2023 00:36:00 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 50EBC20072;
        Wed,  3 May 2023 07:35:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1683099359; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=i3Hzbp6Fc0h0hj5rYtAeMr0Bup0FedFGgjm/ljEsba4=;
        b=A1RUCh5ESqnCmqQHykA4qtiRA0TnekVST89bVweUc4YoOPAxXPAgcnp/rVynH6+pRPkp+z
        0FzTPxhVUa0WAN3v90MiKxX/mhoNEqn2v/EhT/wx95G56Ej/zpg/VQwdKLa255ScGTYoBo
        r9VjFKfCEoqB/4FmnoBqhK5sAhIi958=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0FDBE1331F;
        Wed,  3 May 2023 07:35:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id M6TzAt8OUmR+UgAAMHmgww
        (envelope-from <mhocko@suse.com>); Wed, 03 May 2023 07:35:59 +0000
Date:   Wed, 3 May 2023 09:35:58 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     akpm@linux-foundation.org, kent.overstreet@linux.dev,
        vbabka@suse.cz, hannes@cmpxchg.org, roman.gushchin@linux.dev,
        mgorman@suse.de, dave@stgolabs.net, willy@infradead.org,
        liam.howlett@oracle.com, corbet@lwn.net, void@manifault.com,
        peterz@infradead.org, juri.lelli@redhat.com, ldufour@linux.ibm.com,
        catalin.marinas@arm.com, will@kernel.org, arnd@arndb.de,
        tglx@linutronix.de, mingo@redhat.com, dave.hansen@linux.intel.com,
        x86@kernel.org, peterx@redhat.com, david@redhat.com,
        axboe@kernel.dk, mcgrof@kernel.org, masahiroy@kernel.org,
        nathan@kernel.org, dennis@kernel.org, tj@kernel.org,
        muchun.song@linux.dev, rppt@kernel.org, paulmck@kernel.org,
        pasha.tatashin@soleen.com, yosryahmed@google.com,
        yuzhao@google.com, dhowells@redhat.com, hughd@google.com,
        andreyknvl@gmail.com, keescook@chromium.org,
        ndesaulniers@google.com, gregkh@linuxfoundation.org,
        ebiggers@google.com, ytcoode@gmail.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        bristot@redhat.com, vschneid@redhat.com, cl@linux.com,
        penberg@kernel.org, iamjoonsoo.kim@lge.com, 42.hyeyoo@gmail.com,
        glider@google.com, elver@google.com, dvyukov@google.com,
        shakeelb@google.com, songmuchun@bytedance.com, jbaron@akamai.com,
        rientjes@google.com, minchan@google.com, kaleshsingh@google.com,
        kernel-team@android.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
        linux-arch@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-modules@vger.kernel.org,
        kasan-dev@googlegroups.com, cgroups@vger.kernel.org
Subject: Re: [PATCH 34/40] lib: code tagging context capture support
Message-ID: <ZFIO3tXCbmTn53uv@dhcp22.suse.cz>
References: <20230501165450.15352-1-surenb@google.com>
 <20230501165450.15352-35-surenb@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230501165450.15352-35-surenb@google.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon 01-05-23 09:54:44, Suren Baghdasaryan wrote:
[...]
> +static inline void add_ctx(struct codetag_ctx *ctx,
> +			   struct codetag_with_ctx *ctc)
> +{
> +	kref_init(&ctx->refcount);
> +	spin_lock(&ctc->ctx_lock);
> +	ctx->flags = CTC_FLAG_CTX_PTR;
> +	ctx->ctc = ctc;
> +	list_add_tail(&ctx->node, &ctc->ctx_head);
> +	spin_unlock(&ctc->ctx_lock);

AFAIU every single tracked allocation will get its own codetag_ctx.
There is no aggregation per allocation site or anything else. This looks
like a scalability and a memory overhead red flag to me.

> +}
> +
> +static inline void rem_ctx(struct codetag_ctx *ctx,
> +			   void (*free_ctx)(struct kref *refcount))
> +{
> +	struct codetag_with_ctx *ctc = ctx->ctc;
> +
> +	spin_lock(&ctc->ctx_lock);

This could deadlock when allocator is called from the IRQ context.

> +	/* ctx might have been removed while we were using it */
> +	if (!list_empty(&ctx->node))
> +		list_del_init(&ctx->node);
> +	spin_unlock(&ctc->ctx_lock);
> +	kref_put(&ctx->refcount, free_ctx);
-- 
Michal Hocko
SUSE Labs

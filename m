Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3BE77822C6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Aug 2023 06:26:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232976AbjHUEZ5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 21 Aug 2023 00:25:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229842AbjHUEZ4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 21 Aug 2023 00:25:56 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D4209B;
        Sun, 20 Aug 2023 21:25:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=+ThJSbWV78NlzV1/8C4mbgmYWZr69CC6aj59sQ9jdrI=; b=GrUAGT6/KObw5bPBQ7exfokg3U
        ynl1o6BaBJE2w8dxWn4SHwihK33nGtJXtQSf9WII5QNzRQ2K/FxjOeVh+I3cjJNNkdtdWtKYo9QXK
        L1nLWdqK2Q2UfESbpjBtH/wGVGA9F2JGqgVtY6LJfU5xpdm1d9Obs7iRoLeHn5+Fk4u9lWEzssWKz
        v3voHD9tHVIJeSzrbvkM2TyQTv/4lGmEmBmfGOENaS2YUABDuZDOlr+lPFyQjvTKPSjdOTcR16Q+W
        wkXH6nfN409c0r0+HFEB6nQP6TIFVNFeqlDel+ejgohfCksc0lt18vCEm9FV/ufHxoZNkWyxoln6Q
        dG471p0Q==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qXwU2-0086y2-1U; Mon, 21 Aug 2023 04:25:42 +0000
Date:   Mon, 21 Aug 2023 05:25:41 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Byungchul Park <byungchul@sk.com>
Cc:     linux-kernel@vger.kernel.org, kernel_team@skhynix.com,
        torvalds@linux-foundation.org, damien.lemoal@opensource.wdc.com,
        linux-ide@vger.kernel.org, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, mingo@redhat.com, peterz@infradead.org,
        will@kernel.org, tglx@linutronix.de, rostedt@goodmis.org,
        joel@joelfernandes.org, sashal@kernel.org, daniel.vetter@ffwll.ch,
        duyuyang@gmail.com, johannes.berg@intel.com, tj@kernel.org,
        tytso@mit.edu, david@fromorbit.com, amir73il@gmail.com,
        gregkh@linuxfoundation.org, kernel-team@lge.com,
        linux-mm@kvack.org, akpm@linux-foundation.org, mhocko@kernel.org,
        minchan@kernel.org, hannes@cmpxchg.org, vdavydov.dev@gmail.com,
        sj@kernel.org, jglisse@redhat.com, dennis@kernel.org, cl@linux.com,
        penberg@kernel.org, rientjes@google.com, vbabka@suse.cz,
        ngupta@vflare.org, linux-block@vger.kernel.org,
        josef@toxicpanda.com, linux-fsdevel@vger.kernel.org,
        viro@zeniv.linux.org.uk, jack@suse.cz, jlayton@kernel.org,
        dan.j.williams@intel.com, hch@infradead.org, djwong@kernel.org,
        dri-devel@lists.freedesktop.org, rodrigosiqueiramelo@gmail.com,
        melissa.srw@gmail.com, hamohammed.sa@gmail.com,
        42.hyeyoo@gmail.com, chris.p.wilson@intel.com,
        gwan-gyeong.mun@intel.com, max.byungchul.park@gmail.com,
        boqun.feng@gmail.com, longman@redhat.com, hdanton@sina.com,
        her0gyugyu@gmail.com
Subject: Re: [RESEND PATCH v10 25/25] dept: Track the potential waits of
 PG_{locked,writeback}
Message-ID: <ZOLnRSdH4Wcrl67L@casper.infradead.org>
References: <20230821034637.34630-1-byungchul@sk.com>
 <20230821034637.34630-26-byungchul@sk.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230821034637.34630-26-byungchul@sk.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Aug 21, 2023 at 12:46:37PM +0900, Byungchul Park wrote:
> @@ -377,44 +421,88 @@ static __always_inline int Page##uname(struct page *page)		\
>  #define SETPAGEFLAG(uname, lname, policy)				\
>  static __always_inline							\
>  void folio_set_##lname(struct folio *folio)				\
> -{ set_bit(PG_##lname, folio_flags(folio, FOLIO_##policy)); }		\
> +{									\
> +	set_bit(PG_##lname, folio_flags(folio, FOLIO_##policy));	\
> +	dept_page_set_bit(&folio->page, PG_##lname);			\

The PG_locked and PG_writeback bits only actually exist in the folio;
the ones in struct page are just legacy and never actually used.
Perhaps we could make the APIs more folio-based and less page-based?

>  static __always_inline void SetPage##uname(struct page *page)		\
> -{ set_bit(PG_##lname, &policy(page, 1)->flags); }
> +{									\
> +	set_bit(PG_##lname, &policy(page, 1)->flags);			\
> +	dept_page_set_bit(page, PG_##lname);				\
> +}

I don't think we ever call this for PG_writeback or PG_locked.  If
I'm wrong, we can probably fix that ;-)

>  static __always_inline void __SetPage##uname(struct page *page)		\
> -{ __set_bit(PG_##lname, &policy(page, 1)->flags); }
> +{									\
> +	__set_bit(PG_##lname, &policy(page, 1)->flags);			\
> +	dept_page_set_bit(page, PG_##lname);				\
> +}

Umm.  We do call __SetPageLocked() though ... I'll fix those up to
be __set_folio_locked().


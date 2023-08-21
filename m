Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C732782287
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Aug 2023 06:11:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232883AbjHUELK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 21 Aug 2023 00:11:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232120AbjHUELI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 21 Aug 2023 00:11:08 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D64BD11D;
        Sun, 20 Aug 2023 21:10:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=sTOdBFeZC0ZITAjiSCC8ryUnVRY9Lhk36Ip26KjeYr4=; b=ICymlCyLpaJ6lmuyoMFR5kttyw
        UBm9C082xuk3Z6hhwZEKWSF+ox3NgccEuO8Z/43fptOWwRZsWum/7FRoRaW1UQbyW1qJwMW+RtTE5
        LuYT1pNyy0SaxkHsTTkacsbgLDntlcgS1wSJqQvwXrvlQeAEdAYSdM61NzEaEm48NI/eOnoim4ojj
        8vV9ewOGSLgUh2r2vGs4nVL8ZJ4gZ46GXf8M9SfbYoQvZdxJbeNQKkzbyh3E1MLZutAHTaZUuOqIq
        1S/Hr371deuhKGgzMbb+5HqLyRiiOPcO8oCTUXpithV1sUUXjoat+U6z6h/eBmQhpwA7bLdvom+us
        SUX4CjPw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qXwEa-0081su-Uu; Mon, 21 Aug 2023 04:09:45 +0000
Date:   Mon, 21 Aug 2023 05:09:44 +0100
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
Subject: Re: [RESEND PATCH v10 08/25] dept: Apply
 sdt_might_sleep_{start,end}() to PG_{locked,writeback} wait
Message-ID: <ZOLjiF2oKxBvVzyw@casper.infradead.org>
References: <20230821034637.34630-1-byungchul@sk.com>
 <20230821034637.34630-9-byungchul@sk.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230821034637.34630-9-byungchul@sk.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Aug 21, 2023 at 12:46:20PM +0900, Byungchul Park wrote:
> @@ -1219,6 +1220,9 @@ static inline bool folio_trylock_flag(struct folio *folio, int bit_nr,
>  /* How many times do we accept lock stealing from under a waiter? */
>  int sysctl_page_lock_unfairness = 5;
>  
> +static struct dept_map __maybe_unused PG_locked_map = DEPT_MAP_INITIALIZER(PG_locked_map, NULL);
> +static struct dept_map __maybe_unused PG_writeback_map = DEPT_MAP_INITIALIZER(PG_writeback_map, NULL);

Hmm, why are these "maybe unused"?  *digs*.  Ah.  Because
sdt_might_sleep_start() becomes a no-op macro if DEPT is disabled.

OK, the right way to handle this is

#ifdef CONFIG_DEPT
#define DEPT_MAP(name)	static struct dept_map name = \
		DEPT_MAP_INITIALIZER(name, NULL)
#else
#define DEPT_MAP(name)	/* */
#endif

And now DEPT takes up no space if disabled.

/* */; is a somewhat unusual thing to see, but since this must work at
top level, we can't use "do { } while (0)" like we usually do.  Given
where else this is likely to be used, i don't think it's going to be
a problem ...


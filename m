Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DB5D4EC978
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Mar 2022 18:17:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348707AbiC3QS6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 30 Mar 2022 12:18:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348694AbiC3QS5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 30 Mar 2022 12:18:57 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC4A9DEAA
        for <linux-fsdevel@vger.kernel.org>; Wed, 30 Mar 2022 09:17:11 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id s11so18483375qtc.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 30 Mar 2022 09:17:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=sE79b5xf1pu5spCGHEXKbfq2zO6/d3c8ibhtXAoqtQ8=;
        b=0MJRsQjAcGaYRmd1h6Pqxr17HDJtykd8JOH+AOEISyH5SHZzxS8LscnZAXcKOFHdVF
         zpo83KdVFXKzTrrBkdac9nldVOA2KFBimbg7untEnME14A+bruTvVC+WVVPZWOeM7UEo
         xS8Fc9GofuwWqbcSmn4dufLUSvrWhUF/vl2lQo07i0t9LFTS3FCx4fFPPfIiqLmzUwb1
         13yjnnWj/PIyED9DcxN/IW7n6ogFQn3BviOTH2hBN18UsUQXbN7p33moYsp6bHRvswCl
         YhvIlqYNacFE+iHwNivuq04BuVbB8hWfG6zrRXGI0X7QTOkbWjqPaNP+OQoVFqQ4NJik
         OhTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=sE79b5xf1pu5spCGHEXKbfq2zO6/d3c8ibhtXAoqtQ8=;
        b=jPCGtt2YlJDRQldgt8CQkDsZdHr3Db0zAsw8KCD0Zg1qiMDhTK11h0FLtqLlDF9pkg
         wqxhUDqoeKSYkaAMFQFTKtKUZBlfEGt7FGq9HUvxVj6cG4XDmT40McROCDrkfv/rOct8
         XPyN3aUD7AvpMIrArHtaVV/ijcW50CK1HKM1MwsC5oJu/9qS20vQf319jtCNBOkiuPrU
         z+UL+Rg4KII+7LBzug9L4WW64N+2MW80u7flGrom1c0Ar87LoT+JbMhtjbY39mHyedaA
         CixDbErDWtP87yZPc9SlsdQ2/1spLLjFu+Y6iZH4j9rHcVIjlgmdDY7Ihtz0TYDG+o9p
         BhcA==
X-Gm-Message-State: AOAM533ENDXClQ1WBBMDbMZNczfdNmeYUd6bHdwdLe8WjickA0wnnnhV
        19r2sxRU9QaVHJQvro8LHhWeYg==
X-Google-Smtp-Source: ABdhPJzF/ry2xuy0oHxOMDKGlfKRY6IH7+5YeycyXAPyxi9mB2917VgqHJK8duwayZ5P0FrMTPzVgA==
X-Received: by 2002:a05:622a:8e:b0:2e1:fee4:8ca2 with SMTP id o14-20020a05622a008e00b002e1fee48ca2mr242426qtw.431.1648657030772;
        Wed, 30 Mar 2022 09:17:10 -0700 (PDT)
Received: from localhost (cpe-98-15-154-102.hvc.res.rr.com. [98.15.154.102])
        by smtp.gmail.com with ESMTPSA id s13-20020a05620a0bcd00b0067afe7dd3ffsm11684222qki.49.2022.03.30.09.17.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Mar 2022 09:17:10 -0700 (PDT)
Date:   Wed, 30 Mar 2022 12:17:09 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     CGEL <cgel.zte@gmail.com>, axboe@kernel.dk,
        viro@zeniv.linux.org.uk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        akpm@linux-foundation.org, Yang Yang <yang.yang29@zte.com.cn>,
        Ran Xiaokai <ran.xiaokai@zte.com.cn>
Subject: Re: [PATCH] block/psi: make PSI annotations of submit_bio only work
 for file pages
Message-ID: <YkSChWxuBzEB3Fqn@cmpxchg.org>
References: <20220316063927.2128383-1-yang.yang29@zte.com.cn>
 <YjiMsGoXoDU+FwsS@cmpxchg.org>
 <623938d1.1c69fb81.52716.030f@mx.google.com>
 <YjnO3p6vvAjeMCFC@cmpxchg.org>
 <20220323061058.GA2343452@cgel.zte@gmail.com>
 <62441603.1c69fb81.4b06b.5a29@mx.google.com>
 <YkRUfuT3jGcqSw1Q@cmpxchg.org>
 <YkRVSIG6QKfDK/ES@infradead.org>
 <YkR7NPFIQ9h2AK9h@cmpxchg.org>
 <YkR9IW1scr2EDBpa@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YkR9IW1scr2EDBpa@infradead.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Mar 30, 2022 at 08:54:09AM -0700, Christoph Hellwig wrote:
> On Wed, Mar 30, 2022 at 11:45:56AM -0400, Johannes Weiner wrote:
> > > FYI, I started redoing that version and I think with all the cleanups
> > > to filemap.c and the readahead code this can be done fairly nicely now:
> > > 
> > > http://git.infradead.org/users/hch/block.git/commitdiff/666abb29c6db870d3941acc5ac19e83fbc72cfd4
> > 
> > Yes, it's definitely much nicer now with the MM instantiating the
> > pages for ->readpage(s).
> > 
> > But AFAICS this breaks compressed btrfs (and erofs?) because those
> > still do additional add_to_page_cache_lru() and bio submissions.
> 
> In btrfs, add_ra_bio_pages only passed freshly allocated pages to
> add_to_page_cache_lru.  These can't really have PageWorkingSet set,
> can they?  In erofs they can also come from a local page pool, but
> I think otherwise the same applies.

It's add_to_page_cache_lru() that sets the flag.

Basically, when a PageWorkingset (hot) page gets reclaimed, the bit is
stored in the vacated tree slot. When the entry is brought back in,
add_to_page_cache_lru() transfers it to the newly allocated page.

add_to_page_cache_lru()
  filemap_add_folio()
    __filemap_add_folio(mapping, folio, index, gfp, &shadow)
      *shadow = *slot
      *slot = folio
  if (shadow)
    workingset_refault(folio, shadow)
      folio_set_workingset()

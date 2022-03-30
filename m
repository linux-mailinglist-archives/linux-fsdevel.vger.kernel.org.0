Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8FC14EC523
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Mar 2022 15:04:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345630AbiC3NF7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 30 Mar 2022 09:05:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345618AbiC3NF6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 30 Mar 2022 09:05:58 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AB7E2BC;
        Wed, 30 Mar 2022 06:04:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=uMLqGfWuqWdrPS+5GCzVB17d8FYui969zyu6SJ6c6Tc=; b=kSYREJcmSh+sctnbfm38Lr17hn
        xkvX/5nDs0uyM7t1OwM3KRSMhMGLZCsypuyTSccqbWRrI1ZXVrzGCqeoRHqWX6QobbLLrLRtPlb3e
        pOprx5IHn8HH7YeT+0YS6ldLu4xbYlDrr1q6kS/ywGE7Yzqtcj4NJsWE6SJRDGnhwtmxNwHXXsyFf
        LMdlE3xLONbBV7qaphD7JGgrO+sn/Cw3gMqjsDNmXxJnEefKbLKJJYq26OIfv5o6LWy2qRmD6HPQb
        iX2VZssSGtb5SotNyx5MzDiY1Rn0qd95cfQXM/of+U25oKeSWPZ73Qkstb3iCRlR6Q4RDGov7QVhp
        G6zDEwnw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nZXzc-00FxoT-Lk; Wed, 30 Mar 2022 13:04:08 +0000
Date:   Wed, 30 Mar 2022 06:04:08 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     CGEL <cgel.zte@gmail.com>, axboe@kernel.dk,
        viro@zeniv.linux.org.uk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        akpm@linux-foundation.org, Yang Yang <yang.yang29@zte.com.cn>,
        Ran Xiaokai <ran.xiaokai@zte.com.cn>,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH] block/psi: make PSI annotations of submit_bio only work
 for file pages
Message-ID: <YkRVSIG6QKfDK/ES@infradead.org>
References: <20220316063927.2128383-1-yang.yang29@zte.com.cn>
 <YjiMsGoXoDU+FwsS@cmpxchg.org>
 <623938d1.1c69fb81.52716.030f@mx.google.com>
 <YjnO3p6vvAjeMCFC@cmpxchg.org>
 <20220323061058.GA2343452@cgel.zte@gmail.com>
 <62441603.1c69fb81.4b06b.5a29@mx.google.com>
 <YkRUfuT3jGcqSw1Q@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YkRUfuT3jGcqSw1Q@cmpxchg.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Mar 30, 2022 at 09:00:46AM -0400, Johannes Weiner wrote:
> If you want type distinction, we should move it all into MM code, like
> Christoph is saying. Were swap code handles anon refaults and the page
> cache code handles file refaults. This would be my preferred layering,
> and my original patch did that: https://lkml.org/lkml/2019/7/22/1070.

FYI, I started redoing that version and I think with all the cleanups
to filemap.c and the readahead code this can be done fairly nicely now:

http://git.infradead.org/users/hch/block.git/commitdiff/666abb29c6db870d3941acc5ac19e83fbc72cfd4


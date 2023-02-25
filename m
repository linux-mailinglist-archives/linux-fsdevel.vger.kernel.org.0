Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 880FF6A26DE
	for <lists+linux-fsdevel@lfdr.de>; Sat, 25 Feb 2023 04:01:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229495AbjBYDBr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 24 Feb 2023 22:01:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjBYDBq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 24 Feb 2023 22:01:46 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F155CDBF4
        for <linux-fsdevel@vger.kernel.org>; Fri, 24 Feb 2023 19:01:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=tuXU2UVLGfPHGmNryWKbNIhCr40+De/DEkKn96iM3Xs=; b=Efr+YyydJpDb2P3SbarHS4EhN8
        uAku6EMzcETpRfoqkJ/nNVBLg+1mCq1KQ2SU9X6WWgX5xzlzPQ9vNDb4GFeTpXwXCL/P4qIdhaK2m
        67mbZbYqlQC26FCqsvrUlWmaCkh8mCzxPAN+ASti7huI4WSZMzR0+06IUaMJEEVmd3mFkT2uZWfFv
        q9SEUlrL7MM96BUbtplP+XBWlNiEtm8YW92g9KbEDl/TOk+if/Tdt6ImC/zi03nhpZRiha4sruaF5
        5Pzs15B5dr9V1oClmlKk3ra7NM/+Na14C1IT0fq1Dnh5K4azMb96QBxGf0WyB2BGRycRKL9uyxFX2
        2qImmjgQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pVkod-00FoMm-5o; Sat, 25 Feb 2023 03:01:39 +0000
Date:   Sat, 25 Feb 2023 03:01:39 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Viacheslav Dubeyko <slava@dubeyko.com>
Cc:     linux-fsdevel@vger.kernel.org, viacheslav.dubeyko@bytedance.com,
        luka.perkov@sartura.hr, bruno.banelli@sartura.hr
Subject: Re: [RFC PATCH 75/76] ssdfs: implement file operations support
Message-ID: <Y/l6E6Czw48180ie@casper.infradead.org>
References: <20230225010927.813929-1-slava@dubeyko.com>
 <20230225010927.813929-76-slava@dubeyko.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230225010927.813929-76-slava@dubeyko.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Feb 24, 2023 at 05:09:26PM -0800, Viacheslav Dubeyko wrote:
> +int ssdfs_read_folio(struct file *file, struct folio *folio)
> +{
> +	struct page *page = &folio->page;

I'm not really excited about merging a new filesystem that's still using
all the pre-folio APIs.  At least you're not using buffer_heads, but
you are using some APIs which have been entirely removed in 6.3.

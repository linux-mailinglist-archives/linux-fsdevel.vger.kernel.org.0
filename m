Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 348F871F137
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Jun 2023 19:57:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231499AbjFARx7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 1 Jun 2023 13:53:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229992AbjFARx6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 1 Jun 2023 13:53:58 -0400
Received: from out-39.mta0.migadu.com (out-39.mta0.migadu.com [91.218.175.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82A62199
        for <linux-fsdevel@vger.kernel.org>; Thu,  1 Jun 2023 10:53:57 -0700 (PDT)
Date:   Thu, 1 Jun 2023 13:53:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1685642035;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=J3DmRiG+N/ipm5aqjmc6HICQWlnAntrnwWB/Z2c5TEM=;
        b=vIaIChrwYlze5FGCkN8xsuj5dPwi6DuUqA3/adW7De0PnI72UwAQeKxV8Gre5UDQei+G7B
        icFz4be3ivPiXAjjuWz0kx39AtbJlCpXE7G14XKQXj/IIfhrYJJxIM8W/kzsMHyB3Mm41h
        ++I3vqfAh9dIEbzVlxLmjE+DjR7uPVE=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Kent Overstreet <kent.overstreet@linux.dev>
To:     Mikulas Patocka <mpatocka@redhat.com>
Cc:     linux-bcachefs@vger.kernel.org, dm-devel@redhat.com,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] bcachefs: fix NULL pointer dereference in
 try_alloc_bucket
Message-ID: <ZHjbL1o1KZt1385/@moria.home.lan>
References: <alpine.LRH.2.21.2305300803220.12797@file01.intranet.prod.int.rdu2.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LRH.2.21.2305300803220.12797@file01.intranet.prod.int.rdu2.redhat.com>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, May 30, 2023 at 08:15:41AM -0400, Mikulas Patocka wrote:
> 
> 
> On Mon, 29 May 2023, Mikulas Patocka wrote:
> 
> > The oops happens in set_btree_iter_dontneed and it is caused by the fact 
> > that iter->path is NULL. The code in try_alloc_bucket is buggy because it 
> > sets "struct btree_iter iter = { NULL };" and then jumps to the "err" 
> > label that tries to dereference values in "iter".
> 
> Here I'm sending a patch for it.
> 
> 
> 
> +		set_btree_iter_dontneed(&iter);
>  	bch2_trans_iter_exit(trans, &iter);

I need to look at this code a bit more, perhaps we'll want to move the
check into set_btree_iter_dontneed(), since iter_exit() is safe to call
on an uninitialized-but-zeroed iterator

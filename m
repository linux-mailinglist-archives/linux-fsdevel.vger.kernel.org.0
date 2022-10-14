Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6239F5FEDD9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Oct 2022 14:12:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229609AbiJNMMK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 14 Oct 2022 08:12:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229867AbiJNMMJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 14 Oct 2022 08:12:09 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60F591B76ED;
        Fri, 14 Oct 2022 05:12:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=/xUt8Y4IwTvvldIp0EcUJRzSF4xX9kwkjX2KlbgFVak=; b=IuijqRk1+kAIPSVBfC5zxk0m/r
        hLuzS2HAvJVHGGTadOrvNRfpkb1wmSG/wqcu9uJwv3DxpXkWqacOU3qo+WEXMQTLH8zNHEvHAqBJg
        30yIjM8Fp+bOkGe9aJGWgxaLcNa2huQK5f8BuUdi4KKx1xoR8lpyGk8tH1ai4+JlIjEtSjqc8/s88
        h6bZyTj+4p+q5t4pwbiZlhTLn1AbNAsg48GuGjvHjEtgs2342hjrwAnAIo8wNaJ3hMfTy6z+D1VxG
        kt5J9Dvfm5RjN0v/gWkb9dVBGLZRkFyQ99lN2k18S4hkGVp657c3JwPRkoHsPLWQYXGzHcylnKKZe
        ZTbKU4Eg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ojJXe-007biS-Fv; Fri, 14 Oct 2022 12:11:54 +0000
Date:   Fri, 14 Oct 2022 13:11:54 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     "zhaoyang.huang" <zhaoyang.huang@unisoc.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Zhaoyang Huang <huangzhaoyang@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, ke.wang@unisoc.com,
        steve.kang@unisoc.com, baocong.liu@unisoc.com,
        linux-fsdevel@vger.kernel.org
Subject: Re: [RFC PATCH] mm: move xa forward when run across zombie page
Message-ID: <Y0lSChlclGPkwTeA@casper.infradead.org>
References: <1665725448-31439-1-git-send-email-zhaoyang.huang@unisoc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1665725448-31439-1-git-send-email-zhaoyang.huang@unisoc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Oct 14, 2022 at 01:30:48PM +0800, zhaoyang.huang wrote:
> From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> 
> Bellowing RCU stall is reported where kswapd traps in a live lock when shrink
> superblock's inode list. The direct reason is zombie page keeps staying on the
> xarray's slot and make the check and retry loop permanently. The root cause is unknown yet
> and supposed could be an xa update without synchronize_rcu etc. I would like to
> suggest skip this page to break the live lock as a workaround.

No, the underlying bug should be fixed.

>  	if (!folio || xa_is_value(folio))
>  		return folio;
>  
> -	if (!folio_try_get_rcu(folio))
> +	if (!folio_try_get_rcu(folio)) {
> +		xas_advance(xas, folio->index + folio_nr_pages(folio) - 1);
>  		goto reset;
> +	}

You can't do this anyway.  To call folio_nr_pages() and to look at
folio->index, you must have a refcount on the page, and this is the
path where we failed to get the refcount.

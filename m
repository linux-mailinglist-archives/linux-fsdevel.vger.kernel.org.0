Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2451626C827
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Sep 2020 20:42:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728182AbgIPSmV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Sep 2020 14:42:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727814AbgIPS1x (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Sep 2020 14:27:53 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E31C7C0D941B
        for <linux-fsdevel@vger.kernel.org>; Wed, 16 Sep 2020 07:56:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=yoFdoNBAApNfEqyd3LW0/oOTX7Bhfr4S2yzp+c8awSw=; b=pbGK7OlJmT7qkQlGXeRxx6MtZw
        +dhL9b1Rm+FjVw7eRNR5eCAkt9fOzJWZ3Jr9QU/NjVvZCSibpnS8B79PudoRAzzl/FWgXx3cqG7Pk
        JFgdEeWPcLnvOwhqdAKfKneN0GSTVdbimr3KJudzUzYNJf+dCLRIFN8oGy+2B2e7X7Msbin34iqL/
        MYwr2L5EMxzCdj47PVN6eBRotsJj/w822BjwHWUia1aoPkMNzOPg5bTQEiPsH8y9+h36OzqWIkd3y
        jjhwhMkZ9ryzj7vCShO6jNVtQ6kp/3HD78jQOHgpLWXZy+WZVo7reUyiMT2vPq2AKnURqYy4FzvaS
        881O5ozw==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kIYrK-0005Cx-Nm; Wed, 16 Sep 2020 14:56:34 +0000
Date:   Wed, 16 Sep 2020 15:56:34 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Pradeep P V K <ppvk@codeaurora.org>
Cc:     miklos@szeredi.hu, linux-fsdevel@vger.kernel.org,
        stummala@codeaurora.org, sayalil@codeaurora.org
Subject: Re: [PATCH V2] fuse: Remove __GFP_FS flag to avoid allocator
 recursing
Message-ID: <20200916145634.GN5449@casper.infradead.org>
References: <1600238380-33350-1-git-send-email-ppvk@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1600238380-33350-1-git-send-email-ppvk@codeaurora.org>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Sep 16, 2020 at 12:09:40PM +0530, Pradeep P V K wrote:
> Changes since V1:
> - Used memalloc_nofs_save() in all allocation paths of fuse daemons
>   to avoid use __GFP_FS flag as per Matthew comments.

That's not how to use memalloc_nofs_save().  You call it when entering a
context in which any memory allocation would cause a deadlock.  You don't
look for every place which allocates memory and wrap the memory allocation
calls in memalloc_nofs_save() because you're likely to miss one.

>  static ssize_t fuse_dev_read(struct kiocb *iocb, struct iov_iter *to)
>  {
> +	ssize_t size;
> +	unsigned nofs_flag;

This is almost certainly too low in the call stack.


Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95988762A54
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Jul 2023 06:32:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230182AbjGZEcS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 26 Jul 2023 00:32:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjGZEcQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 26 Jul 2023 00:32:16 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D5D6A0;
        Tue, 25 Jul 2023 21:32:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=uMDpXai9jnzcyG1+E1KFnjBJUtDKa0sU3l3aqJf5M+Q=; b=dGXA4NWGVTSoEmqk20tITHiyuE
        lPYPO6433XZ4tnt3t48LsE+d/4VpNeS7oM84J6y+thfwX/XPYruwCi8vYRFHLt+GjDjCiHIw3MOf9
        B21S3QCJnJSQVU4cmVrMA6Jwxia0nG8m3HOCU5rdRiQ6gG8soU8Qjqj6y1ihQKybMrEnsXy7uw3aa
        oXjrcZqWY8VGbOpl7xebCsuPS5dZaIJp1WF6eVY2mca4sqyVVYH3Qi1HU8k9pMX8ZE1Qa7nutJJ21
        vKLYSH4ku2imUu6ZYo8rdtqCTm83go7AEUCC1l8bmHLUIc2eqRqhsJg0vXj9KOvIgeUc85oxV/W6D
        EOVARvtw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qOVr9-0069Nf-DF; Wed, 26 Jul 2023 04:10:35 +0000
Date:   Wed, 26 Jul 2023 05:10:35 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Dan Carpenter <dan.carpenter@linaro.org>
Cc:     Baoquan He <bhe@redhat.com>, Vivek Goyal <vgoyal@redhat.com>,
        Dave Young <dyoung@redhat.com>, kexec@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] proc/vmcore: fix signedness bug in read_from_oldmem()
Message-ID: <ZMCcu9KHh0uC2VFq@casper.infradead.org>
References: <b55f7eed-1c65-4adc-95d1-6c7c65a54a6e@moroto.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b55f7eed-1c65-4adc-95d1-6c7c65a54a6e@moroto.mountain>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jul 25, 2023 at 08:03:16PM +0300, Dan Carpenter wrote:
> The bug is the error handling:
> 
> 	if (tmp < nr_bytes) {
> 
> "tmp" can hold negative error codes but because "nr_bytes" is type
> size_t the negative error codes are treated as very high positive
> values (success).  Fix this by changing "nr_bytes" to type ssize_t.  The
> "nr_bytes" variable is used to store values between 1 and PAGE_SIZE and
> they can fit in ssize_t without any issue.
> 
> Fixes: 5d8de293c224 ("vmcore: convert copy_oldmem_page() to take an iov_iter")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>

Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>

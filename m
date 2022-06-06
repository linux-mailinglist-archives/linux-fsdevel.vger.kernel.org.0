Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC19753E920
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Jun 2022 19:08:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237561AbiFFMmX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 6 Jun 2022 08:42:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237554AbiFFMmV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 6 Jun 2022 08:42:21 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9F941A3AF;
        Mon,  6 Jun 2022 05:42:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=r1GO4NK/Jiz8RFmlhNVithIgsmOjD1tHTDligDyAX9w=; b=ORACbARkFUH7vtAeVUbWBOE2cK
        rHY85qqmpIP28DLzBhN6Du1nLheAUE/ydsYvaaKIxzdCVetkw+YeOgrNulIPHYvbcUa0ss3//3XhI
        7d5hZBpICC3+ouSYBeETkouEYpTaQOrrk7ACRSOk174Bj9MidK2B7ZzWBwbVCdf1W/xMUqlRKXqwy
        ECwvnXdfjG+eUbAgyDgkl9MDFwOFqUmg4wfcBKzvOVSY4cGONJBU128zAkcnMd94XHQORATE9u6HV
        jsavlD/1kLpMZwxX2+WEyCmZBRpb9cj/mmQOCpJPDHs2M+RH2mijTGgNwOgtlhYdJvdGYRQNs1dEM
        9qTfplpw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nyC3e-00Afmw-Pf; Mon, 06 Jun 2022 12:42:10 +0000
Date:   Mon, 6 Jun 2022 13:42:10 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Jan Kara <jack@suse.cz>
Cc:     Jan Kara <jack@suse.com>, tytso@mit.edu,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 1/3] quota: Prevent memory allocation recursion while
 holding dq_lock
Message-ID: <Yp32IsyQFJXRAOtt@casper.infradead.org>
References: <20220605143815.2330891-1-willy@infradead.org>
 <20220605143815.2330891-2-willy@infradead.org>
 <20220606080334.tv5r7kljang55fat@quack3.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220606080334.tv5r7kljang55fat@quack3.lan>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jun 06, 2022 at 10:03:34AM +0200, Jan Kara wrote:
> On Sun 05-06-22 15:38:13, Matthew Wilcox (Oracle) wrote:
> > As described in commit 02117b8ae9c0 ("f2fs: Set GF_NOFS in
> > read_cache_page_gfp while doing f2fs_quota_read"), we must not enter
> > filesystem reclaim while holding the dq_lock.  Prevent this more generally
> > by using memalloc_nofs_save() while holding the lock.
> > 
> > Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> 
> This is definitely a good cleanup to have and seems mostly unrelated to the
> rest. I'll take it rightaway into my tree. Thanks for the patch!

Thanks!  It's really a pre-requisite for the second patch; I haven't
seen anywhere in the current codebase that will have a problem.  All
the buffer_heads are allocated with GFP_NOFS | __GFP_NOFAIL (in
grow_dev_page()).

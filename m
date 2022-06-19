Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D2665507F7
	for <lists+linux-fsdevel@lfdr.de>; Sun, 19 Jun 2022 04:25:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229690AbiFSCZb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 18 Jun 2022 22:25:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbiFSCZa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 18 Jun 2022 22:25:30 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7454FE0B2
        for <linux-fsdevel@vger.kernel.org>; Sat, 18 Jun 2022 19:25:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=2Jm37FYV3MgXNxAB2+abU7SpCamvxFbnNkXqLUXtZvE=; b=eXt9SL5+nPPt22USTRr2g0iQAa
        SXFAWyBMnkmVTb5C8pqjt8xYPgk2R26G/3mlma1ya+1AgSEpc4PmJ095jFf0S+4rVZvlbB55VO922
        rDUUvOP6C+YnFIp1HtcpmVIUhLvV96XlmJQGPgaCQCFRO2X0ULr5Hez9qcRfXJspEGotB+snwYhCt
        t170nc5tA1D5FxSAxfQTYrMHkBhsz42X3Kyp6T4vDVseT82cDEa9xf6S9y9CO0NISdV+jP5lIgDDs
        HKW3QFc0jzUytenLkmN5B8DeV8tfgEYhRmUb5RFknxvmkRncalWknFXZpU5YresMyYN6qJ8EfDNsL
        qYRV0F8g==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.95 #2 (Red Hat Linux))
        id 1o2kcx-001uOt-2q;
        Sun, 19 Jun 2022 02:25:27 +0000
Date:   Sun, 19 Jun 2022 03:25:27 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     linux-fsdevel@vger.kernel.org
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH 10/31] ITER_PIPE: fold data_start() and
 pipe_space_for_user() together
Message-ID: <Yq6JFzxNwcyqpzF/@ZenIV>
References: <Yq1iNHboD+9fz60M@ZenIV>
 <20220618053538.359065-1-viro@zeniv.linux.org.uk>
 <20220618053538.359065-11-viro@zeniv.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220618053538.359065-11-viro@zeniv.linux.org.uk>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Jun 18, 2022 at 06:35:17AM +0100, Al Viro wrote:
> +	*npages = max(used - (int)pipe->max_usage, 0);

	*npages = max((int)pipe->max_usage - used, 0);

>  	if (off > 0 && off < PAGE_SIZE) { // anon and not full

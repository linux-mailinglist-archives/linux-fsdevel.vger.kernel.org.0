Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 822A272CD16
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jun 2023 19:43:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233277AbjFLRnN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Jun 2023 13:43:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237014AbjFLRnJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Jun 2023 13:43:09 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40D7EA1;
        Mon, 12 Jun 2023 10:43:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=YkJgq+xZxuWnpaPqTqevVGw+VbQ7xAInoSR0rdPbq9M=; b=SpXYDrplkt01uzFSPTkFXaSI0o
        /wtEgAKa1nSvr49S/q+j09isdTMsV1rZ0ktITh3FPJeccQ1380KvL/hJkvjRK8p7sDiW7Qagrnrc3
        lr5rlkervXJ2G/Frsg+ZAPf0q151QffSD9ifNnK5pd7zyLj7prwkxb8N+0VhN9nE7S//HsEIA5Hvr
        DKX/LWd2JbwYDSXg2BrobcDva2I16HmJK53HzAl6HJ3wnEz4ei+mR/nAyK9OCqhiNTycA0+J2UvDU
        nzSt1YUZyoh/iaPAZt3+fL75wGFL3+xiNmW5X+R+I9OSk7q75NsLDLygzOv5CtVhTTzD7jaJN20pk
        9pN098mw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1q8lZJ-002sui-PH; Mon, 12 Jun 2023 17:43:05 +0000
Date:   Mon, 12 Jun 2023 18:43:05 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Ritesh Harjani <ritesh.list@gmail.com>
Cc:     Theodore Ts'o <tytso@mit.edu>, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        Ojaswin Mujoo <ojaswin@linux.ibm.com>,
        Disha Goel <disgoel@linux.ibm.com>, Jan Kara <jack@suse.cz>
Subject: Re: [RFCv2 2/5] ext4: Remove PAGE_SIZE assumption of folio from
 mpage_submit_folio
Message-ID: <ZIdZKSLidg1o89qX@casper.infradead.org>
References: <87a5x6hy8l.fsf@doe.com>
 <87wn08pp7y.fsf@doe.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87wn08pp7y.fsf@doe.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jun 12, 2023 at 10:55:37PM +0530, Ritesh Harjani wrote:
> It is easily recreatable if we have one thread doing buffered-io +
> sync and other thread trying to truncate down inode->i_size.
> Kernel panic maybe is happening only with -O encrypt mkfs option +
> -o test_dummy_encryption mount option, but the size - folio_pos(folio)
> is definitely wrong because inode->i_size is not protected in writeback path.

Did you not see the email I sent right before you sent your previous
email?
